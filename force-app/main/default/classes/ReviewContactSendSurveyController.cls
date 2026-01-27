public class ReviewContactSendSurveyController {
    public List<WrapData> listContact {get;set;}
    
    //filter
    public String MOT{get; set;}
    public String Method{get; set;}
    public String StatusClaim{get; set;}
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
    
    private static final String HOLD = 'Hold';
    private static final String AMFS = 'AMFS';
    private static final String ICF = 'ICF';
    
    public ReviewContactSendSurveyController() {
        SIZE_DATA = 25;
        
        listContact = new List<WrapData>();
        List<aggregateResult> groupByContact = new List<aggregateResult>();
        groupByContact = [Select contact__c from Email_sms_log__c where status__c = 'Hold' and mot__c != null 
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
        List<String> contactids = new List<String>();
        for (String row: selectedRecord.keySet()) {
            if (selectedRecord.get(row) == true) {
                contactids.add(row);
            }
        }
        
        if (contactids.size()  > 0) {
            
            Database.executeBatch(new ReviewContactSendSurveyBatching(contactids), 1);  
            PageReference tempPage = new PageReference(Apexpages.currentPage().getUrl());
            tempPage.setRedirect(true);
            return tempPage;
        } 
        else {
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Please select at least 1 contact'));  
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
            
            List<Contact> getDataContact = [select Id, name, MobilePhone, Policy_No__c, email from Contact where id in :selectedRecord.keySet() 
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
                    selectedRecord.get(row.id)
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
        WrapData(string cid, string policy, string name, string email, string mp, boolean slct) {
            this.contactId = cid;
            this.policy_no = policy;
            this.name = name;
            this.email = email;
            this.mobilePhone = mp;
            this.selected = slct;
        }
    }
    
    public List<SelectOption> getOptionMOT() {
       List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','Please Select One'));
        options.add(new SelectOption('I Ask','I Ask'));
        options.add(new SelectOption('I Claim','I Claim'));
        options.add(new SelectOption('I Renew','I Renew'));
        options.add(new SelectOption('I Buy','I Buy'));
        return options;
    }
    
    public List<SelectOption> getOptionStatusClaim() {
       List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','Please Select One'));
        options.add(new SelectOption('Approve','Approve'));
        options.add(new SelectOption('Reject','Reject'));
        return options;
    }
    
    public List<SelectOption> getOptionMethod() {
       List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','Please Select One'));
        options.add(new SelectOption('Request','Request'));
        options.add(new SelectOption('Request POS','Request POS'));
        options.add(new SelectOption('Inquiry','Inquiry'));
        options.add(new SelectOption('Complaint','Complaint'));
        return options;
    }
    
    public void filterin(){
        List<aggregateResult> groupByContact = new List<aggregateResult>();
        String q = 'SELECT contact__c FROM Email_sms_log__c where status__c=:HOLD and entity__c =:AMFS and category__c =:ICF and contact__c != null ' ; 
        if (SurveyDate != null) q = q + ' and day_only(createddate) =:SurveyDate ';
        if (Method != null) q = q + ' and Case_Type__c =:Method ';
        if (MOT != null) q = q + ' and mot__c =: MOT ';
        if (StatusClaim != null) q = q + ' and Claim_Status__c =: StatusClaim ';
        
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