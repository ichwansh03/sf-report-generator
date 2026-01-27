public class ReviewSurveyIClaimController {
    public List<WrapData> listContact {get;set;}
    
    //filter
    public String PolicyApp{get; set;}
    public String MOT{get; set;}
    public String CaseType{get; set;}
    public static Date SurveyDate {get;set;}
    public Boolean filter {get;set;}
    //
    public Integer skip {get;set;}
    public Integer take {get;set;} 
    public Integer total_page {get;set;}
    public Integer current_page {get;set;}
    public Integer to_page {get;set;}
    public List<string> list_page {get;set;}
    
    public Long mulai {get;set;}
    public Long selesai {get;set;}
    public Integer totalRow {get;set;} 
    public Integer SIZE_DATA {get;set;}
    public List<Integer> LIST_SIZE_DATA {get;set;}
    public String processTime {get;set;} 
    public List<Call_Line__c> listData {get;set;}
    Public String joinFilter {get;set;}
    Public set<id> contactIds {get;set;}
    
    public map<string, boolean> selectedRecord {get;set;} 
    
    public List<SelectOption> paginationSizeOptions{get;set;}
    
    private static final String DRAFT = 'Draft EIP';
    private static final String AMFS = 'AMFS';
    private static final String ICF = 'ICF';
    
    public ReviewSurveyIClaimController() {
        SIZE_DATA = 25;
        
        listContact = new List<WrapData>();
        List<aggregateResult> groupByContact = new List<aggregateResult>();
        groupByContact = [Select contact__c from Email_sms_log__c where status__c = 'Draft EIP' and MOT__c != null
                          //and case__r.Case_type__c = 'Request_Claim_Payment'
                          and entity__c = 'AMFS' and category__c = 'ICF' and contact__c != null
                          group by contact__c, day_only(createddate) order by day_only(createddate) desc limit 5000];
        selectedRecord = new map<string, boolean>();
        
        if (groupByContact.size() > 0) {
            for (aggregateResult row: groupByContact) {
                string contactid = string.valueof(row.get('contact__c'));
                selectedRecord.put(contactid, false);
            }
        }
        
        paginationSizeOptions = new List<SelectOption>(); 
        paginationSizeOptions.add(new SelectOption('25','25'));
        paginationSizeOptions.add(new SelectOption('50','50'));
        paginationSizeOptions.add(new SelectOption('100','100'));
        paginationSizeOptions.add(new SelectOption('500','500'));
        
        refresh();
        loadData();
    }
    
        
    public PageReference Send() { 
        Set<Id> emailIds = new Set<Id>();
        Set<Id> email_reject_Ids = new Set<Id>();
        List<String> idContact = new List<String>();
        List<Email_SMS_Log__c> listEmail = new  List<Email_SMS_Log__c>();
        List<Email_SMS_Log__c> listEmail_Reject = new  List<Email_SMS_Log__c>();
        List<Email_SMS_Log__c> listEmail_IBuy = new  List<Email_SMS_Log__c>();
        for (String row: selectedRecord.keySet()) {
            if (selectedRecord.get(row) == true) {
                listEmail = [select id, Claim_Status__c from Email_SMS_Log__c where status__c = 'Draft EIP' and MOT__c != null
                         and case__r.Case_type__c = 'Request_Claim_Payment'
                         and entity__c = 'AMFS' and category__c = 'ICF' and contact__c =:row ];

                if(listEmail.size() > 0){
                   if(listEmail[0].Claim_Status__c == 'Approve') emailIds.add(listEmail[0].id);
                }
                
                listEmail_Reject = [select id, Claim_Status__c from Email_SMS_Log__c where status__c = 'Draft EIP' and MOT__c = 'I Claim'
                         and entity__c = 'AMFS' and category__c = 'ICF' and contact__c =:row ];
                
                if(listEmail_Reject.size() > 0){
                    if(listEmail_Reject[0].Claim_Status__c == 'Reject') email_reject_Ids.add(listEmail_Reject[0].id);
                }
                
                listEmail_IBuy = [select id, contact__c from Email_SMS_Log__c where status__c = 'Draft EIP' and MOT__c = 'I Buy'
                                  and entity__c = 'AMFS' and category__c = 'ICF' and contact__c =:row ];
                if(listEmail_IBuy.size() > 0){
                    idContact.add(listEmail_IBuy[0].contact__c);
                }
            }
        }
        
        if (emailIds.size()  > 0) {
            CheckSurveyICFFuture.checkSurveyICF(emailIds);
            PageReference tempPage = ApexPages.currentPage();
            tempPage.setRedirect(true);
            return tempPage;
        } 
        else if (email_reject_Ids.size()  > 0) {
            CreateEmailSMSLogClaimReject.send(email_reject_Ids);
            PageReference tempPage = ApexPages.currentPage();
            tempPage.setRedirect(true);
            return tempPage;
        } 
        else if(idContact.size()  > 0){
            Database.executeBatch(new ReviewSurveyIClaimBatching(idContact), 1);  
            //CreateEmailSMSLogNewCust.CreateEmailSMSLog(idContact, 'Update');
            PageReference tempPage = ApexPages.currentPage();
            tempPage.setRedirect(true);
            return tempPage;
        }
        else {
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Please select at least 1 contact' ));  
            return null;
        } 
        
    }
    
    public void selectedAll() {
        for (WrapData row: listContact) {
            row.selected = true;
            selectedRecord.put(row.contactId,true);
        }
    }
    
    public void selected() {
       for (WrapData row: listContact) {
           selectedRecord.put(row.contactId,row.selected);   
        } 
    }     
    
    Public void loadData() {
        mulai =  DateTime.now().getTime();
        totalRow = 0;
        listContact = new List<WrapData>();
        
        if (selectedRecord.size() > 0) {
            for (String row: selectedRecord.keySet()) {
                selectedRecord.put(row,false);
            }
            system.debug('SIZE_DATA:'+SIZE_DATA);
            system.debug('skip:'+skip);
            
            List<Contact> getDataContact = [select Id, name, MobilePhone, Policy_No__c, email, PolicyApp__c from Contact where id in :selectedRecord.keySet() 
                                            order by lastmodifieddate desc Limit :SIZE_DATA offset :skip];
            
           totalRow = selectedRecord.size();
            
            
            system.debug('total:'+totalRow);
            total_page =  (Integer)Math.ceil((Double)totalRow / SIZE_DATA);
            system.debug('total_page:'+total_page);
            list_page = showListPagination();
            system.debug('list_page:'+list_page);
            
            for (contact row : getDataContact) {
                WrapData setData = new WrapData(
                	row.id, 
                    row.Policy_No__c,
                    row.name,
                    row.email,
                    row.mobilePhone,
                    selectedRecord.get(row.id),
                    row.PolicyApp__c
                );
                
                listContact.add(setData);
            }
            
        }
        selesai =  Datetime.now().getTime();
        system.debug('current_page == '+current_page);
        system.debug('selesai == '+selesai);
        processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
        processTime += '<br/>Total : ' + totalRow + ' records';
        system.debug('processTime == '+processTime);
        
    }
    
    
    public void refresh(){
        processTime = ''; 
        totalRow = 0;
        skip = 0;
        current_page = 1; 
        total_page = 1; 
        to_page = 0;
        take = SIZE_DATA;
        list_page = new List<String>();      
    }
    
    public void getDataNext(){
        system.debug('next');
        skip = (current_page * SIZE_DATA);
        to_page = current_page + 1;
        current_page = to_page;
        take = to_page * SIZE_DATA;   
        loadData();
    }
    
    public void getDataPrevious(){
        to_page = current_page - 1;
        skip = (to_page - 1) * SIZE_DATA;
        current_page = to_page;
        take = to_page * SIZE_DATA;  
        loadData();
    }
    
    
    public void changeSizeData(){
        refresh();
        loadData();
    }
    
     
    public void getDataToPage(){ 
        skip = (to_page - 1) * SIZE_DATA;
        current_page = to_page;
        take = to_page * SIZE_DATA;  
        loadData();
    }
    
    public void getDataFirst(){
        skip = 0;
        current_page = 1;
        take = SIZE_DATA;  
        loadData();
    }
    
    public void getDataLast(){
        to_page = total_page;
        skip = (to_page - 1) * SIZE_DATA ;
        current_page = to_page;
        take = to_page * SIZE_DATA;  
        loadData();
    } 
    
    public List<String> showListPagination() {
        
        List<string>  ShowPaginate = new List<string>();
        integer nilaiAwal  = 0;
        integer nilaiAkhir = 0;
        
        if ( (current_page != null && current_page > 0) && (total_page != null && total_page > 0)) {
            Decimal middletotal_page = ((double) total_page)/current_page; 
            if (current_page == 1) { 
                if (total_page > current_page) {
                    nilaiAwal = current_page;
                    if (total_page > 1) nilaiAkhir = current_page+1;
                    if (total_page > 2) nilaiAkhir = current_page+2; 
                } else { 
                    nilaiAwal = current_page;
                    nilaiAkhir = current_page;
                }
            } else if (middletotal_page > 0) { 
                if (current_page == total_page) {  
                    nilaiAkhir = current_page; 
                    if (current_page > 0) nilaiAwal = current_page-1;
                    if (nilaiAwal > 1) nilaiAwal = current_page-2;  
                } else {                  
                    nilaiAwal = current_page-1; 
                    nilaiAkhir = current_page+1; 
                }
            } 
            
            for (integer i = nilaiAwal; i <= nilaiAkhir; i++) {
                ShowPaginate.add(string.valueOf(i));
            }  
        } 
        return ShowPaginate;
    } 
    
    class WrapData {
        public String contactId {get;set;}
        public String policy_no {get;set;}
        public String name {get;set;}
        public String email {get;set;}
        public String mobilePhone {get;set;}
        public boolean selected {get;set;}
        public String policy_app {get;set;}
        WrapData(string cid, string policy, string name, string email, string mp, boolean slct, string policyApp) {
            this.contactId = cid;
            this.policy_no = policy;
            this.name = name;
            this.email = email;
            this.mobilePhone = mp;
            this.selected = slct;
            this.policy_app = policyApp;
        }
    }
    
    public List<SelectOption> getOptionPolicyApp() {
       List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','Please Select One'));
        options.add(new SelectOption('RLS','RLS'));
        options.add(new SelectOption('DMTM','DMTM'));
        return options;
    }
    
    public List<SelectOption> getOptionMOT() {
       List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','Please Select One'));
        options.add(new SelectOption('I Ask','I Ask'));
        options.add(new SelectOption('I Buy','I Buy'));
        options.add(new SelectOption('I Claim','I Claim'));
        options.add(new SelectOption('I Renew','I Renew'));
        options.add(new SelectOption('I Complaint','I Complaint'));
        return options;
    }
    
    public List<SelectOption> getOptionCaseType() {
       List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','Please Select One'));
        options.add(new SelectOption('Inquiry','Inquiry'));
        options.add(new SelectOption('Request','Request'));
        options.add(new SelectOption('Complaint','Complaint'));
        return options;
    }
    
    public void filterin(){
        List<aggregateResult> groupByContact = new List<aggregateResult>();
        String q = 'SELECT contact__c FROM Email_sms_log__c where status__c=:DRAFT and entity__c =:AMFS and category__c =:ICF and contact__c != null ' ; 
        if (PolicyApp != null) q = q + ' and contact__r.PolicyApp__c =:PolicyApp ';
        if (MOT != null) q = q + ' and MOT__c =: MOT ';
        if (CaseType != null) q = q + ' and case__r.type =: CaseType ';
        if (SurveyDate != null) q = q + ' and day_only(createddate) =:SurveyDate ';
        
        q = q + ' group by contact__c, day_only(createddate) order by day_only(createddate) desc limit 5000 ';

        groupByContact = database.query(q);
        selectedRecord = new map<string, boolean>();
        
        if (groupByContact.size() > 0) {
            for (aggregateResult row: groupByContact) {
                string contactid = string.valueof(row.get('contact__c'));
                selectedRecord.put(contactid, false);
            }
        }
        loadData();
    }

}