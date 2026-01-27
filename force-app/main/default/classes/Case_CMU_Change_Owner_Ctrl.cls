public class Case_CMU_Change_Owner_Ctrl {
    public Integer AMFScampaignPeriod = Integer.valueOf(System.Label.CampaignPeriodForDistributionAMFS);
    public Integer uploadedNum {get; set;}
    public Integer validNum {get; set;}
    public Integer invalidNum {get; set;}
    public Integer totalPolicies {get;set;}
    public Integer totalData {get;set;}
    public Integer totalGAP {get;set;}
    public Integer inputValue {get;set;}
    public Integer totalAgents {get;set;}
    public Boolean isMaxRecord {get;set;}
    public Boolean isMethodChoosen{get;set;}
    public String entity {get; set;}
    public String choosen_campaign {get;set;}
    public String choosen_user{get;set;}
    public String prev_user{get;set;}
    public String choosen_method {get; set;}
    public String CollectionTaskArr {get; set;}
    public String url = 'https://'+system.URL.getSalesforceBaseUrl().getHost()+'/apex/TakeSurvey?id=SURVEYID&cId=CONTACTID&caId=none';
    public List<Call_List__c> campaign_list {get;set;}
    public List<Case> CaseList {get;set;}
    public List<SelectOption> optionCampaign_list {get;set;}
    public List<String> invalidPolicyList {get;set;}
    public List<String> invalidPolicyTempList {get;set;}
    public List<User_Detail__c> agentList {get;set;}
    public List<Id> agentIDList {get;set;}
    public List<SelectOption> agentOptList {get; set;}
    public List<SelectOption> distributeOptionList {get; set;}
    public List<String> list_policyNo {get;set;}
    public Map<Id, Call_List__c> map_campaignObj {get;set;}
    public Map<string,Contact> mapContactList {get;set;}
    public Map<string,string> agentMap {get; set;}
    public Map<String, Case> map_callLine {get;set;}
    public Map<String, ID> map_userid {get;set;}
    
    Public Integer checkLoop = 0;
    Public String AMFS = 'AMFS';
    Public Decimal Total_APE {get;set;}
    Public String String_APE {get;set;}
    Public Integer campaignTarget {get;set;}
    public List<User_Detail__c> agentListView {get;set;}
    public List<Agent_Distribution_History__c> finalListAdh {get;set;}
    public map<Id,Agent_Distribution_History__c> mapAgentHistory {get;set;}
    public List<SelectOption> optionUser_list {get;set;}
    public List<SelectOption> prevUser_list {get;set;}
    
    Public List<tempCase> tempCallLineList {get;set;}
    
    Public boolean selectAll {get;set;}

     public List<SelectOption> getNamedUserAlllist(){
         List<SelectOption> options = new List<SelectOption>();
         
         options.add(new SelectOption('All','--All--'));
         options.add(new SelectOption('Queue','Queue'));
         for (Named_User__c nu : [SELECT id, Name FROM Named_User__c WHERE Entity__c = 'AMFS' and Division__c = 'CMU']){
             options.add(new SelectOption(nu.Name,nu.Name));
         }

         return options;   
     }

     public List<SelectOption> getNamedUserlist(){
         List<SelectOption> options = new List<SelectOption>();
         
         map_userid = new map<string,ID>();
         
         options.add(new SelectOption('All','--All--'));
         for (Named_User__c nu : [SELECT id, Name, User__c FROM Named_User__c WHERE Entity__c = 'AMFS' and Division__c = 'CMU' and (Status__c = 'Active' OR Status__c = 'Non Active' OR Status__c = '')]){
             options.add(new SelectOption(nu.Name,nu.Name));
             map_userid.put(nu.Name, nu.User__c);
         }

         return options;   
     }
    
    public Document document {
        get {
            if (document == null){
                document = new Document();
            }
            return document;
        }
        set;
    }
    
    public Case_CMU_Change_Owner_Ctrl(){
        uploadedNum = 0;
        validNum = 0;
        invalidNum = 0;
        totalPolicies = 0;
        selectAll = false;
        map_campaignObj = new Map<Id, Call_List__c>();
        User userObj = [select id, Entity__c from user where id = :UserInfo.getUserId()];
        Entity = userObj.Entity__c;
        String loggedInUser = userObj.id;
        campaign_list = Database.query('SELECT id, Name, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Call_Line_RecordTypeID__c FROM Call_List__c WHERE Entity__c = :AMFS AND createdby.id = :loggedInUser AND IsExpired__c = false AND Is_Expired_F__c = false order by CreatedDate desc'); //AND Expired_Date__c <= system.today();
        
        optionCampaign_list = new List<SelectOption>();
        optionUser_list = new List<SelectOption>();
        prevUser_list = new List<SelectOption>();
        tempCallLineList = new List<tempCase>();
        
        if (campaign_list.size() > 0){
            for(Call_List__c cl : campaign_list){
                optionCampaign_list.add(new SelectOption(cl.id, cl.Campaign_Name__c));
                map_campaignObj.put(cl.Id, cl);
            }    
        }
        else {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'There`s no campaign / call line available'));   
        }    
        // default
        isMaxRecord = FALSE;
        inputValue = 0;
        
    }
   
    public PageReference populateFreshData(){ // untuk collect data agent dan collect data call line yg akan di distribusi
        isMethodChoosen = false;
        
        if (tempCallLineList.size() > 0) tempCallLineList.clear();
        
        checkLoop += 1;
        {
            String query = 'select id, Named_User__c, CaseNumber, Contact.Name, Contact.Policy_No__c, Received_date__c, Age__c, Category__c, Complaint_type__c, Other_Information__c, CHS_Status__c, Complaint__c from Case where Entity_Backup__c = \'AMFS\' AND Type = \'Complaint\' AND Status != \'Closed\'';
            if (prev_user != null) 
                if (prev_user == 'Queue') 
                    query += 'AND Owner.Name = \'AMFS - CMU Queue\' ';
                else if (prev_user != 'All') 
                    query += 'AND Named_User__c = :prev_user';
            
            query += ' order by Received_date__c LIMIT 800';
            
            if (Test.isRunningTest()) query = 'select id, Named_User__c, CaseNumber, Contact.Name, Contact.Policy_No__c, Received_date__c, Age__c, Category__c, Complaint_type__c, Other_Information__c, CHS_Status__c, Complaint__c from Case limit 1';

            CaseList = Database.query(query);
            
            for (Case cl : CaseList){
                tempCase tcl = new tempCase();
                tcl.cl_id = cl.Id;

        tcl.cl_Named_User = cl.Named_User__c;
        tcl.cl_CaseNumber = cl.CaseNumber;
        tcl.cl_Contact_Name = cl.Contact.Name;
        tcl.cl_Contact_Policy_No = cl.Contact.Policy_No__c;
        tcl.cl_Received_date = string.valueof(cl.Received_Date__c);
        tcl.cl_Age = string.valueof(cl.Age__c);
        tcl.cl_Category = cl.Category__c;
        tcl.cl_Complaint_type = cl.Complaint_Type__c;
        tcl.cl_Other_Information = cl.Other_Information__c;
        tcl.cl_CHS_Status = cl.CHS_Status__c;
        tcl.cl_Complaint = cl.Complaint__c;

                tempCallLineList.add(tcl);
            }
                        
            String query2 = 'select id from Case where Call_List__c = :choosen_campaign and isOwnerQueue__c = FALSE and Agent__c= null and Parent_Call_Line__c != NULL';
            if (prev_user != null) query2 += 'AND Agent__c = :prev_user';
                        
        }
        return null;
    }
    
    public PageReference save() {
        List<Case> clUpdate = new list <Case>();
        for (tempCase tcl : tempCallLineList){
            if (tcl.cl_isSelected == true){
                Case ncl = new Case();
                ncl.id = tcl.cl_id;
                ncl.Named_User__c = choosen_user;
                if (map_userid.get(choosen_user) != NULL) {
                    ncl.OwnerId = map_userid.get(choosen_user);
                    ncl.PIC__c = map_userid.get(choosen_user);
                }
                clUpdate.add(ncl);
            }
        } 
        Set<Case> myset = new Set<Case>();
        List<Case> result = new List<Case>();
        myset.addAll(clUpdate);
        result.addAll(myset);
        
        if (result.size() > 0) {
            update result;  
            PageReference tempPage = ApexPages.currentPage();            
            tempPage.setRedirect(true);
            return tempPage;
        }
        else {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Please select at least 1 call line'));  
            return null;
        } 
    }
    
    public class tempCase{
        Public id cl_id {get;set;}
        Public String cl_Named_User {get;set;}
        Public String cl_CaseNumber {get;set;}
        Public String cl_Contact_Name {get;set;}
        Public String cl_Contact_Policy_No {get;set;}
        Public String cl_Received_date {get;set;}
        Public String cl_Age {get;set;}
        Public String cl_Category {get;set;}
        Public String cl_Complaint_type {get;set;}
        Public String cl_Other_Information {get;set;}
        Public String cl_CHS_Status {get;set;}
        Public String cl_Complaint {get;set;}
        Public Boolean cl_isSelected {get;set;}

    }
}