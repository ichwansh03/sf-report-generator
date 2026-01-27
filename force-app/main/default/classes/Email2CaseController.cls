public class Email2CaseController{
    public transient List<CaseWrapper> caseListWrapper {get;set;}
    //public transient List<CaseWrapper> caseListWrapper_new {get;set;}
    public transient List<Case> caseList {get;set;}
    public List<User> agentList {get;set;}
    //public List<User> adminList {get;set;}
    public List<OrgWideEmailAddress> inboxList {get;set;}
    public transient list<EmailMessage> emailMsgList {get;set;}
    public List<SelectOption> agentOptList {get; set;}
    public List<SelectOption> inboxOptList {get; set;}
    //public List<SelectOption> viewOptList {get; set;}
    public Map<string,string> agentMap {get; set;}
    public Map<string,string> inboxMap {get; set;}
    public List<id> agentIDList {get;set;}
    public List<id> inboxIDList {get;set;}
    public integer counter=0;
    public integer size {get;set;} //sets the page size per screen
    public integer noOfRecords; //total size of the list
    public User userObj {get; set;}
    public String loggedInUser {get;set;}
    public String entity {get;set;}
    public string host {get;set;}
    public string assignedAgent {get; set;}
    public string assignedInbox {get; set;}
    public string agentId {get; set;}
    public String colWidth {get;set;}
    public boolean isSupervisor {get;set;}
    public boolean isAgent {get;set;}
    public string selectedPage{
        get;
        set{
            selectedPage=value;
        }
    }
    String toAddress = '';
    String assignedInboxQuery = '';
    String emailafi = system.label.EMAIL_AFI;
    String emailamfs = system.label.EMAIL_AMFS;
    String emailmagi = system.label.EMAIL_MAGI;
    //string emailQuery = system.label.Email_Query;
    Set<String> toAddressListAFI = new Set<String>();
    Set<String> toAddressListAMFS = new Set<String>();
    Set<String> toAddressListMAGI = new Set<String>();
    Set<Id> emailMsgParentId;
    integer slaEmailDuration = 0;
    integer slaEmailDurationBeforeLoop = 0;
    integer totalAdditionalDays = 0;
    Datetime dueDateEmail;
    Datetime emailCounter;
    Date holiday = null;
    String dueDateEmailInLocal;
    integer rowsLeft;
    integer i = 0;
    string inquiry = 'Inquiry';
	string origin = 'Email';
	string status = 'New';
	string inboxToAddress = '';
	string inboxCCAddress = '';
					        
    public Email2CaseController(){
        userObj = [SELECT id, Entity__c, Profile.Name FROM user WHERE id = :UserInfo.getUserId()];
        loggedInUser = userObj.id;
        entity = userObj.Entity__c;
        noOfRecords = 0;
        selectedPage='0';
        size = Integer.valueof(system.label.CaseEmailInboxPageSize);    //set page size to be displayed per screen
        isSupervisor = false;
        isAgent = false;
        caseList = new List<Case>();
        emailMsgList = new list<EmailMessage>();
        caseListWrapper = new List<CaseWrapper>();
        //adminList = new List<User>();
        //adminList = [SELECT id, Name, Entity__c, Profile.Name FROM User WHERE Profile.Name like '%admin%'];
        host = ApexPages.currentPage().getHeaders().get('Host'); 
        agentList = new List<User>();
        agentOptList = new List<SelectOption>();
        emailMsgParentId = new Set<Id>();
        			
        if(entity=='AFI' || entity=='AMFS'){
            agentList = [SELECT id, Entity__c, Name FROM User WHERE Entity__c = :entity AND isActive = true AND Agent__c = true ORDER BY Name asc];
        }else{
            agentList = [SELECT id, Entity__c, Name FROM User WHERE Entity__c = :entity AND isActive = true AND (Agent__c = true OR Profile.Name = 'SPV CMU-MAGI') ORDER BY Name asc];
        }
        
        agentOptList = new List<SelectOption>();
        agentIDList = new List<id>();
        agentMap = new Map<string, string>();
        for(User agent : agentList){
            agentIDList.add(agent.id);
            agentMap.put(agent.id, agent.Name);
            agentOptList.add(new SelectOption(agent.id, agent.Name));
        }
        
        inboxList = new List<OrgWideEmailAddress>();
        inboxOptList = new List<SelectOption>();
        
        if(emailafi.contains('||')){
            String[] ToAddressSplit = emailafi.split('\\|');
            for(string address: ToAddressSplit){
                toAddressListAFI.add(address.trim());   
            }
        }else{
            toAddressListAFI.add(emailafi);
        }
        if(emailamfs.contains('||')){
            String[] ToAddressSplit = emailamfs.split('\\|');
            for(string address: ToAddressSplit){
                toAddressListAMFS.add(address.trim());  
            }
        }else{
            toAddressListAMFS.add(emailamfs);
        }
        if(emailmagi.contains('||')){
            String[] ToAddressSplit = emailmagi.split('\\|');
            for(string address: ToAddressSplit){
                toAddressListMAGI.add(address.trim());  
            }
        }else{
            toAddressListMAGI.add(emailmagi);
        }
            
        if(entity == 'AFI'){
            inboxList = [SELECT id, Address, IsAllowAllProfiles, DisplayName FROM OrgWideEmailAddress WHERE Address in :toAddressListAFI];  
        }else if(entity == 'AMFS'){
            inboxList = [SELECT id, Address, IsAllowAllProfiles, DisplayName FROM OrgWideEmailAddress WHERE Address in :toAddressListAMFS]; 
        }else if(entity == 'MAGI'){
            inboxList = [SELECT id, Address, IsAllowAllProfiles, DisplayName FROM OrgWideEmailAddress WHERE Address in :toAddressListMAGI]; 
        }
        
        inboxOptList = new List<SelectOption>();
        inboxIDList = new List<id>();
        inboxMap = new Map<string, string>();
        
        if(userObj.Profile.Name.contains('Supervisor') || userObj.Profile.Name.contains('Admin') || userObj.Profile.Name.contains('SPV') || userObj.Profile.Name.contains('Desk') || userObj.Profile.Name.contains('Manager')){
            isSupervisor = true;
            colWidth='4%, 3%, 4%, 6%, 10%, 11%, 11%, 10%, 6%, 8%, 10%, 11%, 6%';
            
            for(OrgWideEmailAddress inbox : inboxList){
                inboxIDList.add(inbox.id);
                inboxMap.put(inbox.Address, inbox.Address);
                inboxOptList.add(new SelectOption(inbox.Address, inbox.Address));
            }
            for(String inboxEmail : inboxMap.keySet()){
			   	if(i>0){
					inboxToAddress = inboxToAddress + ' OR ToAddress LIKE ' + '\'%' +inboxEmail+ '%\'';
					inboxCCAddress = inboxCCAddress + ' OR CCAddress LIKE ' + '\'%' +inboxEmail+ '%\'';
			    }else{
					inboxToAddress = 'ToAddress LIKE ' + '\'%' +inboxEmail+ '%\'';
					inboxCCAddress = 'CCAddress LIKE ' + '\'%' +inboxEmail+ '%\'';
				}
			   	i++;
			}
            //The original: emailMsgList = [Select id, ParentId From EmailMessage where Parent.createddate = LAST_N_DAYS:60 and Parent.Entity_Backup__c= :entity and Parent.Type = 'Inquiry' and Parent.Origin='Email' and Parent.Status='New' and (ToAddress in :inboxMap.keySet() or CCAddress in :inboxMap.keySet()) and Incoming = true limit 20000];
	        emailMsgList = Database.query('SELECT id, ParentId FROM EmailMessage WHERE Parent.CreatedDate = LAST_N_DAYS:60 AND Parent.Entity_Backup__c = :entity AND Parent.Type = :inquiry AND Parent.Origin = :origin AND Parent.Status = :status AND (' +inboxToAddress+ ' OR ' +inboxCCAddress+ ') AND Incoming = true order by CreatedDate desc limit 20000');
	        
	        for(EmailMessage em: emailMsgList){
	            emailMsgParentId.add(em.ParentId); 
	        }
	        
	        noOfRecords = emailMsgParentId.size();
        	
        	if(noOfRecords > 2000){
        		noOfRecords = 2000;	
        	}
        	rowsLeft = Limits.getLimitQueryRows() - Limits.getQueryRows();
        	system.debug('Total rows left (Admin mode): '+rowsLeft);
        }else{
            isAgent = true;
            colWidth='3%, 5%, 6%, 11%, 11%, 11%, 11%, 7%, 10%, 12%, 13%';
            
            inboxOptList.add(new SelectOption('All','All'));    
            for(OrgWideEmailAddress inbox : inboxList){
                inboxIDList.add(inbox.id);
                inboxMap.put(inbox.Address, inbox.Address);
                inboxOptList.add(new SelectOption(inbox.Address, inbox.Address));
            }
            inboxOptList.add(new SelectOption('Only Assigned To Me','Only Assigned To Me'));
            
            noOfRecords = [SELECT count() FROM Case WHERE createddate = LAST_N_DAYS:60 and Entity_Backup__c= :entity and Type = 'Inquiry' and Origin='Email' and Status='New' and OwnerId = :loggedInUser limit 20000];
        
        	if(noOfRecords > 2000){
        		noOfRecords = 2000;	
        	}
        	rowsLeft = Limits.getLimitQueryRows() - Limits.getQueryRows();
        	system.debug('Total rows left (agent mode): '+rowsLeft);
        }
        //caseListWrapper_new = getCaseRecords();
    }
    
    public List<CaseWrapper> getCaseRecords() {
        if (selectedPage != '0'){
            counter = size * integer.valueOf(selectedPage) - size;
        }
        try {
            caseList = new List<Case>();
            emailMsgList = new list<EmailMessage>();
            caseListWrapper = new List<CaseWrapper>();
            CaseWrapper csWrap = null;
            caseList = null;
            emailMsgList = null;
                        
            /*---------------Checking the Filter By menu------------------*/
            if(assignedInbox != '' && assignedInbox != null){
                assignedInboxQuery = '%' + assignedInbox + '%'; 
                system.debug('Assigned Inbox Query: ' +assignedInboxQuery);
                
                if(userObj.Profile.Name.contains('Supervisor') || userObj.Profile.Name.contains('Admin') || userObj.Profile.Name.contains('SPV') || userObj.Profile.Name.contains('Desk') || userObj.Profile.Name.contains('Manager')){
                    /*the original query*/ emailMsgList = [SELECT id, ParentId FROM EmailMessage WHERE Parent.createddate = LAST_N_DAYS:60 AND Parent.Entity_Backup__c= :entity AND Parent.Type = 'Inquiry' AND Parent.Origin='Email' AND Parent.Status='New' AND (ToAddress like :assignedInboxQuery OR CCAddress like :assignedInboxQuery OR BCCAddress like :assignedInboxQuery) AND Incoming = true order by CreatedDate desc limit 20000]; 
                    emailMsgList = [SELECT id, ParentId FROM EmailMessage WHERE Parent.createddate = LAST_N_DAYS:60 AND Parent.Entity_Backup__c= :entity AND Parent.Type = 'Inquiry' AND Parent.Origin='Email' AND Parent.Status='New' AND Parent.Email_Inbox__c = :assignedInbox AND Incoming = true order by CreatedDate desc limit 20000]; 
                    
                    rowsLeft = Limits.getLimitQueryRows() - Limits.getQueryRows();
        			system.debug('Total rows left if email filter is not empty: '+rowsLeft);
        	 
                    for(EmailMessage em: emailMsgList){
                        emailMsgParentId.add(em.ParentId);  
                    }
                    caseList = [SELECT id, CaseNumber, LinkToOpenCaseEmail__c, SuppliedEmail, e2cEmailToAddress__c, Contact.Name, Status, Subject, Type, Entity__c, Description, CreatedDate, OwnerId, Owner.Name, Indicator__c, Follow_Up_Flag__c FROM Case WHERE Id IN :emailMsgParentId order by Email_Message_Date__c desc limit :size OFFSET :counter]; 
                    noOfRecords = emailMsgParentId.size();
                    
                    if(noOfRecords > 2000){
		        		noOfRecords = 2000;	
		        	}
                }else{
                    if(assignedInbox == 'All'){
                        emailMsgList = [SELECT id, ParentId FROM EmailMessage WHERE Parent.createddate = LAST_N_DAYS:60 and Parent.Entity_Backup__c= :entity and Parent.Type = 'Inquiry' and Parent.Origin='Email' and Parent.Status='New' and (ToAddress IN :inboxMap.keySet() OR CCAddress IN :inboxMap.keySet()) AND Incoming = true order by CreatedDate desc limit 20000]; 
                     	//emailMsgList = Database.query('SELECT id, ParentId FROM EmailMessage WHERE Parent.CreatedDate = LAST_N_DAYS:60 AND Parent.Entity_Backup__c = :entity AND Parent.Type = :inquiry AND Parent.Origin = :origin AND Parent.Status = :status AND (' +inboxToAddress+ ' OR ' +inboxCCAddress+ ') AND Incoming = true limit 20000');
	                    
	                    for(EmailMessage em: emailMsgList){
	                        emailMsgParentId.add(em.ParentId);  
	                    }
	                    caseList = [SELECT id, CaseNumber, LinkToOpenCaseEmail__c, SuppliedEmail, e2cEmailToAddress__c, Contact.Name, Status, Subject, Type, Entity__c, Description, CreatedDate, OwnerId, Owner.Name, Indicator__c, Follow_Up_Flag__c FROM Case WHERE Id IN :emailMsgParentId order by Email_Message_Date__c desc limit :size OFFSET :counter]; 
                        noOfRecords = emailMsgParentId.size(); 
	                 	
	                 	if(noOfRecords > 2000){
			        		noOfRecords = 2000;	
			        	}   
                    }
                    else if(assignedInbox == 'Only Assigned To Me'){
                        caseList = [SELECT id, CaseNumber, LinkToOpenCaseEmail__c, SuppliedEmail, e2cEmailToAddress__c, Contact.Name, Status, Subject, Type, Entity__c, Description, CreatedDate, OwnerId, Owner.Name, Indicator__c, Follow_Up_Flag__c FROM Case WHERE createddate = LAST_N_DAYS:60 AND Entity_Backup__c= :entity AND Type = 'Inquiry' AND Origin='Email' AND Status='New' AND OwnerId = :loggedinUser
                                    order by Email_Message_Date__c desc limit :size OFFSET :counter];
                        
                        noOfRecords = [SELECT count() FROM Case WHERE CreatedDate = LAST_N_DAYS:60 and Entity_Backup__c= :entity and Type = 'Inquiry' and Origin='Email' and Status='New' and OwnerId = :loggedInUser limit 20000];
                        
                        if(noOfRecords > 2000){
			        		noOfRecords = 2000;	
			        	}
                    }else{
                        /*the original query*/ //emailMsgList = [SELECT id, ParentId FROM EmailMessage WHERE Parent.createddate = LAST_N_DAYS:60 AND Parent.Entity_Backup__c= :entity AND Parent.Type = 'Inquiry' AND Parent.Origin='Email' AND Parent.Status='New' AND (ToAddress like :assignedInboxQuery OR CCAddress like :assignedInboxQuery OR BCCAddress like :assignedInboxQuery) AND Incoming = true order by CreatedDate desc limit 20000]; 
                    	emailMsgList = [SELECT id, ParentId FROM EmailMessage WHERE Parent.createddate = LAST_N_DAYS:60 AND Parent.Entity_Backup__c= :entity AND Parent.Type = 'Inquiry' AND Parent.Origin='Email' AND Parent.Status='New' AND Parent.Email_Inbox__c = :assignedInbox AND Incoming = true order by CreatedDate desc limit 20000]; 
                    	
                        for(EmailMessage em: emailMsgList){
                            emailMsgParentId.add(em.ParentId);  
                        }
                        caseList = [SELECT id, CaseNumber, LinkToOpenCaseEmail__c, SuppliedEmail, e2cEmailToAddress__c, Contact.Name, Status, Subject, Type, Entity__c, Description, CreatedDate, OwnerId, Owner.Name, Indicator__c, Follow_Up_Flag__c FROM Case WHERE Id IN :emailMsgParentId order by Email_Message_Date__c desc limit :size OFFSET :counter];      
                        noOfRecords = emailMsgParentId.size();
					
						if(noOfRecords > 2000){
			        		noOfRecords = 2000;	
			        	}
                    }
                }   
            }else{
                if(userObj.Profile.Name.contains('Supervisor') || userObj.Profile.Name.contains('Admin') || userObj.Profile.Name.contains('SPV') || userObj.Profile.Name.contains('Desk') || userObj.Profile.Name.contains('Manager')){
                    /*
					for(String inboxEmail : inboxMap.keySet()){
					   	if(i>0){
							inboxToAddress = inboxToAddress + ' OR e2cEmailToAddress__c LIKE ' + '\'%' +inboxEmail+ '%\'';
							inboxCCAddress = inboxCCAddress + ' OR e2cEmailCC__c LIKE ' + '\'%' +inboxEmail+ '%\'';
					    }else{
							inboxToAddress = 'e2cEmailToAddress__c LIKE ' + '\'%' +inboxEmail+ '%\'';
							inboxCCAddress = 'e2cEmailCC__c LIKE ' + '\'%' +inboxEmail+ '%\'';
						}
					   	i++;
					}
					//Here's the modified query using LIKE clause
					emailMsgList = Database.query('SELECT id, ParentId FROM EmailMessage WHERE Parent.createddate = LAST_N_DAYS:60 AND Parent.Entity_Backup__c = :entity AND Parent.Type = :inquiry AND Parent.Origin = :origin AND Parent.Status = :status AND (' +inboxToAddress+ ' OR ' +inboxCCAddress+ ') AND Incoming = true limit :rowsLeft');
					
					for(EmailMessage em: emailMsgList){
                        emailMsgParentId.add(em.ParentId); 
                    }
                    //noOfRecords = emailMsgParentId.size();  //noOfRecords = [select count() from Case where createddate = LAST_N_DAYS:60 and Entity_Backup__c= :entity and Type = 'Inquiry' and Origin='Email' and Status='New' limit 20000]; //set the total size in the constructor
          			*/          
                    caseList = [Select id, CaseNumber, LinkToOpenCaseEmail__c, SuppliedEmail, e2cEmailToAddress__c, Contact.Name, Status, Subject, Type, Entity__c, Description, CreatedDate, OwnerId, Owner.Name, Indicator__c, Follow_Up_Flag__c FROM Case WHERE Id IN :emailMsgParentId order by Email_Message_Date__c desc limit :size OFFSET :counter];
               		system.debug('caseList query: '+caseList);
               		
               		rowsLeft = Limits.getLimitQueryRows() - Limits.getQueryRows();
					system.debug('Total rows left 2: '+rowsLeft);
                }else{
                    caseList = [SELECT id, CaseNumber, LinkToOpenCaseEmail__c, SuppliedEmail, e2cEmailToAddress__c, Contact.Name, Status, Subject, Type, Entity__c, Description, CreatedDate, OwnerId, Owner.Name, Indicator__c, Follow_Up_Flag__c FROM Case WHERE CreatedDate = LAST_N_DAYS:60 AND Entity_Backup__c= :entity AND Type = 'Inquiry' AND Origin='Email' AND Status='New' AND OwnerId = :loggedinUser
                                order by Email_Message_Date__c desc limit :size OFFSET :counter];
                    system.debug('Masuk IF Agent ---> jika selected inbox TIDAK ADA, user login = Agent');
                }
            }
            
            for(Case cse: caseList){
                toAddress = cse.e2cEmailToAddress__c;
                
                csWrap = new CaseWrapper();
                csWrap.id = cse.Id; 
                csWrap.isSelected = false;
                csWrap.indikator = cse.Indicator__c;
                csWrap.followUp = cse.Follow_Up_Flag__c;
                if(userObj.Profile.Name.contains('Supervisor') || userObj.Profile.Name.contains('Admin') || userObj.Profile.Name.contains('SPV') || userObj.Profile.Name.contains('Desk') || userObj.Profile.Name.contains('Manager')){
                    csWrap.caseNumber = cse.LinkToOpenCaseEmail__c;
                }else{
                    if(loggedInUser == cse.OwnerId){
                        csWrap.caseNumber = cse.LinkToOpenCaseEmail__c;
                    }else{
                        csWrap.caseNumber = cse.CaseNumber; 
                    }
                }
                csWrap.senderEmail = cse.SuppliedEmail ; 
                csWrap.customerName = cse.Contact.Name; 
                for(EmailMessage em: [SELECT Id, ToAddress, CCAddress, BCCAddress, CreatedDate, MessageDate, TextBody FROM EmailMessage WHERE ParentId = :cse.Id order by MessageDate asc]){
                    csWrap.toAddress = em.ToAddress;
                    csWrap.ccAddress = em.CCAddress;
                    csWrap.bccAddress = em.BCCAddress;
                    csWrap.messageDate = em.MessageDate.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
                    //csWrap.messageSlaDate = em.Email_Due_Date_In_Datetime__c.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
               		if(em.TextBody !=null){
	                    if(em.TextBody.contains('.')){
	                        csWrap.subDescription = em.TextBody.substring(0, em.TextBody.indexOf('.'))+'...';
	                        csWrap.Description = em.TextBody;
	                    }else{
	                        csWrap.Description = em.TextBody;
	                    }
	                }else{
	                    csWrap.subDescription = null;
	                    csWrap.Description = null; 
	                }
                }   
                csWrap.status = cse.Status; 
                csWrap.subject = cse.Subject; 
                csWrap.type = cse.Type; 
                csWrap.Entity = cse.Entity__c; 
                csWrap.createdDate = cse.createdDate;
                
                if(cse.Owner.Name.contains(System.Label.AdminNames)){  
                    csWrap.assignedTo = 'System';
                }else{
                    csWrap.assignedTo = cse.Owner.Name;
                }
                /*
                if(cse.Description!=null){
                    if(cse.Description.contains('.')){
                        csWrap.subDescription = cse.Description.substring(0, cse.Description.indexOf('.'))+'...';
                        csWrap.Description = cse.Description;
                    }else{
                        csWrap.Description = cse.Description;
                    }
                }else{
                    csWrap.subDescription = null;
                    csWrap.Description = null; 
                }
                */
                caseListWrapper.add(csWrap);
            }
            calculateEmailSLA(toAddress);
            return caseListWrapper;
        }catch (QueryException e) {                            
            ApexPages.addMessages(e);                   
            return null;
        }
    }
	    
    public PageReference assignUser() {
        //calculateEmailSLA();
        Case cs = null;
        List<Case> cList = new List<Case>();
        
        system.debug('caseListWrapper in assignUser method: ' +caseListWrapper);
        
        for(CaseWrapper cw: caseListWrapper){
            if(cw.isSelected && assignedAgent != null){
                cs = new Case();
                cs.id = cw.id;
                if(cw.assignedTo == 'System'){
                    cs.Email_Due_Date_In_Datetime__c = dueDateEmail;
                    cs.Email_Due_Date__c = dueDateEmailInLocal;
                }
                cs.OwnerId = assignedAgent;
                cList.add(cs);    
            }
        }
        update cList;
        caseListWrapper=null; // we need this line if we performed a write operation because getCaseRecords gets a fresh list now
        return null;
    }
    
    public void selectedInbox(){
        emailMsgParentId = new Set<Id>();
        getCaseRecords();
        getPagingButtons();
    }
    
    public PageReference agentPicklist(){
        return null;
    }
    
    public PageReference refreshList(){
        PageReference p = System.Page.Email2CaseInbox;
        p.setRedirect(true);
        return p;
    }
    
    public Component.Apex.outputPanel getPagingButtons() {  //public Component.Apex.pageBlockButtons getPagingButtons() {
        //the reRender attribute is a set NOT a string
        Set<string> theSet = new Set<string>();
        theSet.add('myPanel');
        theSet.add('myButtons');
                
        integer totalPages;
        if (math.mod(noOfRecords, size) > 0) {
            totalPages = noOfRecords/size + 1;
        }else{
            totalPages = (noOfRecords/size);
        }
        
        integer currentPage;        
        if (selectedPage == '0') {
            currentPage = counter/size + 1;
        } else {
            currentPage = integer.valueOf(selectedPage);
        }

        Component.Apex.outputPanel opPanel = new Component.Apex.outputPanel();
        opPanel.id = 'myButtons';
                                
        Component.Apex.commandButton b1 = new Component.Apex.commandButton();
        b1.expressions.action = '{!Previous}';
        b1.title = 'Previous';
        b1.value = 'Previous';
        b1.style = 'font: normal 12px helvetica, sans-serif; background:#fff; color:#0070d2;';
        b1.expressions.disabled = '{!disablePrevious}';        
        b1.reRender = theSet;
        b1.oncomplete = 'reInitializeTableSorter();';
        opPanel.childComponents.add(b1);        
                        
        for (integer i=0;i<totalPages;i++) {
            Component.Apex.commandButton btn = new Component.Apex.commandButton();
            //string bgColor = 'grey';
            
            if (i+1==1) {
                btn.title = 'First';
                btn.value = 'First';
                btn.style = 'font: normal 12px helvetica, sans-serif; background:#fff; color:#0070d2;';
                btn.rendered = true;                                        
            } else if (i+1==totalPages) {
                btn.title = 'Last';
                btn.value = 'Last';
                btn.style = 'font: normal 12px helvetica, sans-serif; background:#fff; color:#0070d2;';
                btn.rendered = true;                            
            } else {
                btn.title = 'Page ' + string.valueOf(i+1) + ' ';
                btn.value = ' ' + string.valueOf(i+1) + ' ';
                btn.rendered = false;             
            }
            
            //if ((i+1 <= 6 && currentPage < 6) || (i+1 >= totalPages-4 && currentPage > totalPages-4) || (i+1 >= currentPage-2 && i+1 <= currentPage+2)){
            if ((i+1 <= 10 && currentPage < 10) || (i+1 >= totalPages-4 && currentPage > totalPages-4) || (i+1 >= currentPage-4 && i+1 <= currentPage+4)){
                btn.rendered = true;
                btn.style = 'font: normal 12px helvetica, sans-serif; background:#fff; color:#0070d2;';
            }
                                     
            if (i+1==currentPage) {
                btn.disabled = true; 
                btn.style = 'font: normal 12px helvetica, sans-serif; color:white; background:#0070d2;';
            }  
            
            //btn.onmouseover = ' this.style.backgroundcolor=\''+bgColor+'\' '; 
            btn.onclick = 'queryByPage(\''+string.valueOf(i+1)+'\');return false;';
            opPanel.childComponents.add(btn);
            
            if (i+1 == 1 || i+1 == totalPages-1) { //put '...' after page 1 and before the last page
                Component.Apex.outputText text = new Component.Apex.outputText();
                text.value = ' ... ';        
                opPanel.childComponents.add(text);
            } 
             
        }
        
        //Next button will always be displayed
        Component.Apex.commandButton b2 = new Component.Apex.commandButton();
        b2.expressions.action = '{!Next}';
        b2.title = 'Next';
        b2.value = 'Next';
        b2.style = 'font: normal 12px helvetica, sans-serif; background:#fff; color:#0070d2;';
        b2.expressions.disabled = '{!disableNext}';        
        b2.reRender = theSet;
        b2.oncomplete = 'reInitializeTableSorter();';
        opPanel.childComponents.add(b2);
                
        //add all buttons as children of the outputPanel                
        //pbButtons.childComponents.add(opPanel);  
  
        return opPanel;     //return pbButtons;
    }    
    
    public PageReference refreshGrid() {        
        system.debug('**** ' + selectedPage);
        return null;
    }
    
    public PageReference Previous() {
        selectedPage = '0';
        counter -= size;
        return null;
    }

    public PageReference Next() {
        selectedPage = '0';
        counter += size;
        return null;
    }

    public PageReference End() { 
        selectedPage = '0';
        counter = noOfRecords - math.mod(noOfRecords, size);
        return null;
    }
    
    public Boolean getDisablePrevious() { 
        if (counter>0) return false; else return true;
    }

    public Boolean getDisableNext() { 
        if (counter + size < noOfRecords) return false; else return true;
    }

    public Integer getNoOfRecords() {
        return noOfRecords;
    }
    
    public Integer getPageNumber() {
        return counter/size + 1;
    }

    public Integer getTotalPages() {
        if (math.mod(noOfRecords, size) > 0) {
            return noOfRecords/size + 1;
        } else {
            return (noOfRecords/size);
        }
    }
    
    @TestVisible private void calculateEmailSLA(string emailAddress){
        List<Holiday> holidayList = [SELECT ID, Name, ActivityDate, IsAllDay FROM Holiday WHERE ActivityDate > today];
    
        for(Holiday hol : holidayList){
            if(hol.ActivityDate != null){
                holiday = hol.ActivityDate;     
            }
        }
    
        system.debug('toAddress in method calculateEmailSLA(): '+emailAddress);
        
        List<Email_Config__c> emailCfgList = [SELECT Id, Email_Address__c, Entity__c, Distribution_Type__c, SLA__c, Unit__c, Start_Working_Hour__c, End_Working_Hour__c FROM Email_Config__c WHERE Distribution_Type__c = 'Manual' AND Email_Address__c = :emailAddress];
        
        for(Email_Config__c ec : emailCfgList) {
            slaEmailDuration = Integer.valueOf(ec.SLA__c);
            slaEmailDurationBeforeLoop = slaEmailDuration;
                
            if(ec.Email_Address__c !=null){
                if(ec.SLA__c !=null && ec.Unit__c == 'Day'){
                    
                    for(integer i=1; i<=slaEmailDuration; i++){
                        emailCounter = system.now().addDays(i); //emailCounter = createdDate.addDays(i);    
                        
                        if(emailCounter.format('E') == 'Sat' || emailCounter.format('E') == 'Sun' || emailCounter.date() == holiday){
                            slaEmailDuration++;
                        }
                    }
                    totalAdditionalDays = slaEmailDuration - slaEmailDurationBeforeLoop;
                    dueDateEmail = system.now() + slaEmailDurationBeforeLoop + totalAdditionalDays; 
                    dueDateEmailInLocal = dueDateEmail.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');   //change to local timezone
                }
                else if(ec.SLA__c !=null && ec.Unit__c == 'Hour'){
                    system.debug('Unit is Hour');
                    dueDateEmail = system.now().addHours(slaEmailDuration);
                    dueDateEmailInLocal = dueDateEmail.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
                    
                    Integer divYear = Integer.valueOf(dueDateEmailInLocal.substring(6, 10));
                    Integer divMonth = Integer.valueOf(dueDateEmailInLocal.substring(3, 5));
                    Integer divDay = Integer.valueOf(dueDateEmailInLocal.substring(0, 2));
                    Integer divHours = Integer.valueOf(dueDateEmailInLocal.substring(11, 13));
                    Integer divMins = Integer.valueOf(dueDateEmailInLocal.substring(14, 16));
                    
                    //Check if the email due date time / SLA exceeds office hour (8-16 PM)
                    if(divHours == integer.valueOf(ec.End_Working_Hour__c) && divMins > 0){
                        //integer surplusMin = 60 - divMins;
                        dueDateEmail = Datetime.newInstance(divYear, divMonth, divDay + 1, integer.valueOf(ec.Start_Working_Hour__c), divMins, 0);
                        
                        while(dueDateEmail.date() == holiday || dueDateEmail.format('E') == 'Sat' || dueDateEmail.format('E') == 'Sun'){
                            dueDateEmail = dueDateEmail + 1;
                        }
                        dueDateEmailInLocal = dueDateEmail.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
                    }
                    if(divHours > integer.valueOf(ec.End_Working_Hour__c)){
                        integer surplusHour = divHours - integer.valueOf(ec.End_Working_Hour__c);
                        dueDateEmail = Datetime.newInstance(divYear, divMonth, divDay + 1, integer.valueOf(ec.Start_Working_Hour__c) + surplusHour, divMins, 0);
                        
                        while(dueDateEmail.date() == holiday || dueDateEmail.format('E') == 'Sat' || dueDateEmail.format('E') == 'Sun'){
                            dueDateEmail = dueDateEmail + 1;
                        }
                       dueDateEmailInLocal = dueDateEmail.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
                    }
                }
            }
        }
    }
    
    public class CaseWrapper{
        public string id{get;set;} 
        public boolean isSelected{get;set;}
        public string indikator{get;set;}
        public string followUp{get;set;}
        public string caseNumber{get;set;} 
        public string senderEmail{get;set;}
        public string toAddress{get;set;}
        public string ccAddress{get;set;}
        public string bccAddress{get;set;}
        public string messageDate {get;set;}
        //public string messageSlaDate {get;set;}
        public string customerName{get;set;}
        public string status{get;set;} 
        public string subject{get;set;} 
        public string type{get;set;} 
        public string Entity{get;set;}
        public string Description{get;set;}
        public string subDescription{get;set;}
        public string assignedTo{get;set;}
        public Datetime createdDate{get;set;}
    }
    
}