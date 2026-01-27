public class CallLineControllerAFI {
    public transient List<Call_Line__c> callLineList {get;set;}
    public transient List<Call_List__c> callList {get; set;}
    public List<SelectOption> campaignList {get; set;}
    public Map<id,User> agentMap {get;set;}
    public Map<string,string> campaignMap {get; set;}
    public Map<string,Call_List__c> campaignObjectMap {get; set;}
    public String entity {get;set;}
    public String loggedInUser {get;set;}
    public string choosen_campaign {get; set;}
    public string activity {get; set;}
    public transient integer totalRecords {get;set;} 
	public transient String sortDirection = 'ASC';
   	public transient String sortExp = 'Name';
	public transient string queryStr = '';
	Set<ID> keys = new Set<ID>();
    User userObj;
    ID rtCustSegCampaign = Schema.SObjectType.Call_list__c.getRecordTypeInfosByName().get('Customer Segmentation AMFS').getRecordTypeId();
        
    //pagination attribute
   	integer totalRecs = 0;
   	public Integer count {get; set;}
   	public Integer LimitSize {get; set;} 
    public Integer tot { get; set; }
    public Integer currentTot { get; set; }
    public Decimal totPage { get; set; }
    public Integer numPage { get; set; }
    Integer lastSizeData=0;
	
	public CallLineControllerAFI (){
        //LimitSize = System.LABEL.rowPerPage.Isnumeric() ? Integer.valueOf(System.LABEL.rowPerPage): 5;
        LimitSize = 10; 
        count = 0;
        currentTot=0;
        totalRecords = 0;
        tot = 0;
        numPage = 1;
        totPage = 1;
        // get logged-in user info
        userObj = new User();
        userObj = [select id, Entity__c, ManagerId, profile.name from user where id = :UserInfo.getUserId()];
        entity = userObj.Entity__c;
        loggedInUser = userObj.id;
        callLineList = new List <Call_Line__c>();
        
        //get all subordinate of logged-in user (if any)
        agentMap = new Map<id,User> ([select id, Entity__c, Name from user where Entity__c = :entity and isActive = true and ManagerId = :loggedInUser and Agent__c = true]);
		keys = agentMap.keySet();	//Added by Hamfry in CCC Wave 2
		
        if(callList == null){
            //callList = [select id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Survey_ID__c from Call_List__c where Entity__c = :entity and (createdby.id = :loggedInUser or ownerid = :loggedInUser) and Is_Expired__c = false];
            
        LIST<Call_list__c> campaign = [select id, name, recordtypeid from call_list__c where id =: choosen_campaign];
        if(userObj.profile.name == 'RM Agent AMFS'){
            callLineList = [select Id, Name, Call_List__r.id, Call_List__r.Campaign_Name__c, Call_List__r.Entity__c, 
                            Call_List__r.Activity__c, Call_List__r.Case_Type__c, Call_List__r.Case_Type_Config__c, 
                            Call_List__r.Survey_ID__c from Call_Line__c where Entity__c = :entity 
                            and (ownerid = :loggedInUser or ownerid in :agentMap.keySet() or ownerid =: userObj.ManagerId) 
                            and recordtype.name = 'Call Line Customer Segmentation'];
        } else { 
            callLineList = [select Id, Name, Call_List__r.id, Call_List__r.Campaign_Name__c, Call_List__r.Entity__c, Call_List__r.Activity__c, Call_List__r.Case_Type__c, Call_List__r.Case_Type_Config__c, Call_List__r.Survey_ID__c from Call_Line__c where Entity__c = :entity 
                            and (ownerid = :loggedInUser or ownerid in :agentMap.keySet()) 
                            and Is_Expired__c = false];
            
            //coba mus
            List<Call_Line__c> listcl = new List<Call_Line__c>();
            List<Call_Line__c> listcl2 = new List<Call_Line__c>();
            
            //if(test.isRunningTest()==false){
            if(userObj.profile.name != 'Outbound Agent-AFI' && userObj.profile.name != 'Supervisor Outbound-AFI'){		//Update Daniel, 11 Mei 2020
                listcl2 = callLineList;
                totalrecs = listcl2.size();
                Integer endblock = LimitSize + count;
                if(endblock>=totalRecs) endblock = totalRecs;
                for(Integer i = count ; i < endblock ; i++){
                    listcl.add(listcl2.get(i));
                }
            //}
                callLineList = listcl;
            }
                
            //coba mus
        }
            
            callList = new List<Call_List__c>();
            Call_List__c clist = null;
            campaignList = new List<SelectOption>();
            campaignMap = new Map<string,string>();
            campaignObjectMap = new Map<string,Call_List__c>(); 

            for(Call_Line__c cline : callLineList){
                if(!campaignObjectMap.containsKey(cline.Call_List__r.id)){
                    clist = new Call_List__c();
                    clist.id = cline.Call_List__r.id; 
                    clist.Campaign_Name__c = cline.Call_List__r.Campaign_Name__c;
                    clist.Entity__c = cline.Call_List__r.Entity__c; 
                    clist.Activity__c = cline.Call_List__r.Activity__c; 
                    clist.Case_Type_Config__c = cline.Call_List__r.Case_Type_Config__c; 
                    clist.Survey_ID__c = cline.Call_List__r.Survey_ID__c;   
                    
                    callList.add(clist); 
                    campaignList.add(new SelectOption(clist.id, clist.Campaign_Name__c));
                    campaignMap.put(clist.id, clist.Campaign_Name__c);
                    campaignObjectMap.put(clist.id, clist);
                }    
            } 
        }
     	callLineList = null; 
     	callList = null;  
    }
    
    public PageReference populateAssignment(){
        callLineList = new List<Call_Line__c>();
        system.debug('## choosen_campaign : '+choosen_campaign);
        activity = '';
        Call_List__c cl = campaignObjectMap.get(choosen_campaign);
        if(cl!=null){
            activity = cl.Activity__c;
        }
        system.debug('## activity : '+activity);
        System.debug('limit size ' +LimitSize);
        if(choosen_campaign != '' && choosen_campaign != null){
            
            
        LIST<Call_list__c> campaign = [select id, name, recordtypeid from call_list__c where id =: choosen_campaign];
        if(!campaign.isEmpty() && campaign.get(0).recordtypeid == rtCustSegCampaign){
            callLineList = [select id, Name, Call_Date__c, Contacted_Number__c, Used_Phone__c, Date_When_Customer_Call__c, 
                            Contact__c, Contact__r.Name, Policy_No__c, Expired_Date__c, Entity__c, Survey_Name__c, 
                            Is_Calledback_Already__c, Prev_Acc_Balance__c, Total_Withdrawn__c, Premium__c, 
                            Call_Status_Config__c, Reason_Status_Config__c, Contact__r.Insured_Name__c, Open_Cases_Fml__c,
                            Customer_Segmentation__c, Open_Cases__c, Priority_Customer__c
                            from Call_Line__c where RecordType.name = 'Call Line Customer Segmentation'
                            AND Call_List__c = :choosen_campaign 
                            and (Agent__c = :loggedInUser or Agent__c in :agentMap.keySet()) 
                            LIMIT :LimitSize OFFSET :count]; 
            tot = totalRecs = [select count() FROM Call_Line__c where RecordType.name = 'Call Line Customer Segmentation'
                            AND Call_List__c = :choosen_campaign 
                            and (Agent__c = :loggedInUser or Agent__c in :agentMap.keySet())];
            if(LimitSize >= tot){
                totPage = 1;
            } else {
                totPage = Decimal.valueOf(tot)/Decimal.valueOf(LimitSize);
                totPage = totPage.round(System.roundingMode.UP);
            }
            
            lastSizeData= callLineList.size();
            if(count==0){
                currentTot=lastSizeData;
            }
        } else {
            callLineList = [select id, Name, Call_Date__c, Contacted_Number__c, Used_Phone__c, Date_When_Customer_Call__c, 
                            Contact__c, Contact__r.Name, Policy_No__c, Expired_Date__c, Entity__c, Survey_Name__c, 
                            Is_Calledback_Already__c, Prev_Acc_Balance__c, Total_Withdrawn__c, Premium__c, 
                            Call_Status_Config__c, Reason_Status_Config__c, Contact__r.Insured_Name__c 
                            from Call_Line__c where Is_Expired__c = false AND Expired_Date__c >= today
                            AND Call_List__c = :choosen_campaign and (Agent__c = :loggedInUser or Agent__c in :agentMap.keySet())]; 
            //tot = totalRecs = 0;
            //lastSizeData= 0;
        	//currentTot=0;
        	
            //coba mus
        	tot = totalRecs = [Select count() from Call_Line__c where Is_Expired__c = false AND Expired_Date__c >= today
                            AND Call_List__c = :choosen_campaign and (Agent__c = :loggedInUser or Agent__c in :agentMap.keySet())];
            if(LimitSize >= tot){
                totPage = 1;
            } else {
                totPage = Decimal.valueOf(tot)/Decimal.valueOf(LimitSize);
                totPage = totPage.round(System.roundingMode.UP);
            }
            
            lastSizeData= callLineList.size();
        	if(count==0){
                currentTot=lastSizeData;
            }
        }
            //queryStr = 'select id, Name, Call_Date__c, Activity_Result__c, Call_Result__c, Contacted_Number__c, Used_Phone__c, Date_When_Customer_Call__c, Contact__c, Contact__r.Name, Policy_No__c, Expired_Date__c, Entity__c, Survey_Type__c, Survey_ID__c, Survey_Name__c, Is_Calledback_Already__c, Prev_Acc_Balance__c, Total_Withdrawn__c, Premium__c, Call_Status_Config__c, Reason_Status_Config__c, Contact__r.Insured_Name__c from Call_Line__c where Is_Expired__c = false AND Expired_Date__c >= today AND Call_List__c = :choosen_campaign and (Agent__c = :loggedInUser or Agent__c in :keys)';		//Added by Hamfry in CCC Wave 2
            //callLineList = Database.query(queryStr);
            
            //coba mus
            List<Call_Line__c> listcl = new List<Call_Line__c>();
            List<Call_Line__c> listcl2 = new List<Call_Line__c>();
            
            //if(test.isRunningTest()==false){
                listcl2 = callLineList;
                totalrecs = listcl2.size();
                Integer endblock = LimitSize + count;
                if(endblock>=totalRecs) endblock = totalRecs;
                for(Integer i = count ; i < endblock ; i++){
                    listcl.add(listcl2.get(i));
                }
            //}
            callLineList = listcl;
            //coba mus
            
            totalRecords = callLineList.size();
            System.debug('===totalRecords=== '+totalRecords);
        }
        return null;
    } 
    
    
	//The following methods (until EOF) are added by Hamfry in CCC Wave 2 project, 31082016
   public String sortExpression{
     get{
        return sortExp;
     }
     set{
     	 //if the column is clicked, switch between Ascending and Descending modes
         if (value == sortExp){
             sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';
         }
         else{
             sortDirection = 'ASC';
             sortExp = value;
         }
     }
   }

   public String getSortDirection(){
   	   //if no column is selected 
	   if (sortExpression == null && sortExpression == '')
	      return 'ASC';
	   else
	     return sortDirection;
   }

   public void setSortDirection(String value){  
 	   sortDirection = value;
   }
    
    //coba mus
    public String sortField {
        get  { if (sortField == null) {sortField = 'Createddate'; } return sortField;  }
        set;
    }
    
    public void sortExpression2(){
        SortDirection2 = SortDirection2.equals('asc') ? 'desc' : 'asc';
        ViewData();
    }
    
    public String SortDirection2{
        get  { if (SortDirection2 == null) {  SortDirection2 = 'asc'; } return SortDirection2;  }
        set;
    }
    //coba mus
  
   public PageReference ViewData() {
   	   callLineList = new List <Call_Line__c>();
       //string sortFullExp = sortExpression  + ' ' + sortDirection;
       
       //coba mus
       string sortFullExp = sortField +' ' +SortDirection2;
              
        LIST<Call_list__c> campaign = [select id, name, recordtypeid from call_list__c where id =: choosen_campaign];
        if(!campaign.isEmpty() && campaign.get(0).recordtypeid == rtCustSegCampaign){
       		queryStr = 'select id, Name, Call_Date__c, Activity_Result__c, Call_Result__c, Contacted_Number__c, '+
                ' Used_Phone__c, Date_When_Customer_Call__c, Contact__c, Contact__r.Name, Policy_No__c, Expired_Date__c, '+
                ' Entity__c, Survey_Type__c, Survey_ID__c, Survey_Name__c, Is_Calledback_Already__c, Prev_Acc_Balance__c,'+
                ' Total_Withdrawn__c, Premium__c, Call_Status_Config__c, Reason_Status_Config__c, Contact__r.Insured_Name__c '+
                ' , Open_Cases_Fml__c, Customer_Segmentation__c, Open_Cases__c, Priority_Customer__c '+
                ' from Call_Line__c where Call_List__c = :choosen_campaign and (Agent__c = :loggedInUser or Agent__c in :keys) '+
                ' order by ' +sortFullExp+' LIMIT :LimitSize OFFSET :count';
        } else {
       		queryStr = 'select id, Name, Call_Date__c, Activity_Result__c, Call_Result__c, Contacted_Number__c, Used_Phone__c, Date_When_Customer_Call__c, Contact__c, Contact__r.Name, Policy_No__c, Expired_Date__c, Entity__c, Survey_Type__c, Survey_ID__c, Survey_Name__c, Is_Calledback_Already__c, Prev_Acc_Balance__c, Total_Withdrawn__c, Premium__c, Call_Status_Config__c, Reason_Status_Config__c, Contact__r.Insured_Name__c from Call_Line__c where Is_Expired__c = false AND Expired_Date__c >= today AND Call_List__c = :choosen_campaign and (Agent__c = :loggedInUser or Agent__c in :keys) order by ' +sortFullExp;   
        }
       callLineList = Database.query(queryStr);
       lastSizeData= callLineList.size();
       //callLineList = Database.query('select id, Name, Call_Date__c, Activity_Result__c, Call_Result__c, Contacted_Number__c, Used_Phone__c, Date_When_Customer_Call__c, Contact__c, Contact__r.Name, Policy_No__c, Expired_Date__c, Entity__c, Survey_Type__c, Survey_ID__c, Survey_Name__c, Is_Calledback_Already__c, Prev_Acc_Balance__c, Total_Withdrawn__c, Premium__c, Call_Status_Config__c, Reason_Status_Config__c, Contact__r.Insured_Name__c from Call_Line__c where Is_Expired__c = false AND Expired_Date__c >= today AND Call_List__c = :choosen_campaign and (Agent__c = :loggedInUser or Agent__c in :keys) order by ' +sortFullExp); 
       
       //coba mus
       List<Call_Line__c> listcl = new List<Call_Line__c>();
       List<Call_Line__c> listcl2 = new List<Call_Line__c>();
       
       if(test.isRunningTest()==false){
           listcl2 = callLineList;
           totalrecs = listcl2.size();
           Integer endblock = LimitSize + count;
           if(endblock>=totalRecs) endblock = totalRecs;
           for(Integer i = count ; i < endblock ; i++){
               listcl.add(listcl2.get(i));
           }
       }
       callLineList = listcl;
       totalRecords = callLineList.size();
       //coba mus
       
       return null;
   }
    public PageReference Firstbtn() {
        numPage = 1;
        count=0;
        populateAssignment();
        currentTot = lastSizeData;
        return null;
    }
    public PageReference prvbtn() {
        numPage = numPage - 1;
        count=count-limitsize;
        currentTot = currentTot - lastSizeData;
        populateAssignment();
        return null;
    }
    
    public PageReference Nxtbtn() {
        numPage = numPage + 1;
        count=count+limitsize;
        populateAssignment();
        currentTot = currentTot +lastSizeData;
        return null;
    }
    public PageReference lstbtn() {
        numPage = Integer.valueOf(totPage);
        count= totalrecs - math.mod(totalRecs,LimitSize);
        populateAssignment();
        currentTot=totalrecs;
        return null;
    }

    public Boolean getNxt() {
        if((count+ LimitSize) > totalRecs)
       return true;
     	else
       return false;
    }
     public Boolean getPrv() {
      if(count== 0)
          return true;
        else
          return false;
     }

    //coba mus
    public List<SelectOption> getBlock_Size(){
        List<SelectOption> options = new List<SelectOption>();
        String opsi = label.CL_BlockSize_AFI;
        List<String> listopsi = new List<String>();
        if(opsi!=null && opsi!='') listopsi = opsi.split(';');
        if(listopsi.size()>0){
            for(String s:listopsi){
                options.add(new SelectOption(s,s));
            }
        }
		return options;   
     }
    
    //coba mus
}