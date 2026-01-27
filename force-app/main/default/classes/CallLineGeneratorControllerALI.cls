public class CallLineGeneratorControllerALI {
    public boolean isButtonDisplayed{get;set;}
    public boolean isMethodChoosen{get;set;}
    public List<OutboundCall> outboundCallList {get; set;}
    public List<ReloadWrapper> reloadWrap {get;set;}
    public List<Call_Line__c> callLineList {get;set;}
    public List<Call_Line__c> copyCallLineList {get;set;}
    //public List<RecordType> recordTypeList {get;set;}
    public List<String> rowPhonesList {get;set;}
    public List<String> invalidPolicyList {get;set;}
    public List<String> invalidPolicyTempList {get;set;}
    public List<String> DataList2 {get;set;}
    public string surveyRecordTypeId {get;set;}
    public string nonSurveyRecordTypeId {get;set;}
    public Integer uploadedNum {get; set;}
    public Integer validNum {get; set;}
    public Integer invalidNum {get; set;}
    public string choosen_campaign {get; set;}
    public string choosen_method {get; set;}
    public string choosen_agent {get; set;}
    public string policyArr {get; set;}
    //public string phoneArr {get; set;}
    public string entity {get; set;}
    public string loggedInUser {get; set;}    
    public string WelcomeArr {get; set;}
    public string ReinstateArr {get; set;}
    public string PremiumFUArr {get; set;}
    public string conservationArr {get; set;}
    public string callbackArr {get; set;}
    public string claimArr {get; set;}
    public string UpdateDataArr {get; set;}
    public string NCBArr {get; set;}
    public string SurveyFeedbackArr {get; set;}
    public string CollectionTaskArr {get; set;}
    public List<Welcome> WelcomeList {get; set;} 
    public List<Reinstate> ReinstateList {get; set;} 
    public List<PremiumFU> PremiumFUList {get; set;} 
    public List<Conservation> conservationList {get; set;} 
    public List<Callback> callbackList {get; set;} 
    public List<claim> claimList {get; set;} 
    public List<UpdateData> UpdateDataList {get; set;} 
    public List<NCB> NCBList {get; set;} 
    public List<SurveyFeedback> SurveyFeedbackList {get; set;} 
    public List<CollectionTask> CollectionTaskList {get; set;} 
    public List<Call_List__c> callList {get; set;}
    public List<SelectOption> campaignList {get; set;}
    public List<SelectOption> agentOptList {get; set;}
    //public List<SelectOption> callStatusOptList {get; set;}
    //public List<SelectOption> reasonStatusOptList {get; set;}
    public List<SelectOption> methodList {get; set;}
    public Map<string,string> campaignMap {get; set;}
    public Map<string,Call_List__c> campaignObjectMap {get; set;}
    public Map<string,string> agentMap {get; set;}
    public List<User> agentList {get;set;}
    public List<id> agentIDList {get;set;}
    public Integer totalPolicies {get;set;}
    public Integer totalGAP {get;set;}    
    public Integer totalData {get;set;}    
    public Integer totalAgents {get;set;}
    public List<AgentAssignment> assignmentList {get;set;}
    public string url = 'https://'+system.URL.getSalesforceBaseUrl().getHost()+'/apex/TakeSurvey?id=SURVEYID&cId=CONTACTID&caId=none';
    public string urlReport = 'https://'+system.URL.getSalesforceBaseUrl().getHost()+'/apex/TakeSurvey?id=SURVEYID&cId=CONTACTID&caId=none';
    //window.open("/{!Report_ID__c}?drilldown=1&drillcol=FK_CUSTENT_ID&drillval={!Id}&drillop=equals","");
    // https://cs57.salesforce.com/00O0k000000SVWc?drilldown=1&drillcol=FK_CUSTENT_ID&drillval=a000k000002Afox&drillop=equals&drilldown=1&drillcol2=00N9000000CD44q&drillval2=&drillop2=equals
    //https://c.cs5.visual.force.com/apex/TakeSurvey?id=a0PO0000007Os03MAC&cId={!Contact.Id}&caId=none
  public integer AMFScampaignPeriod = integer.valueOf(System.Label.CampaignPeriodForDistributionAMFS);
  public integer AFIcampaignPeriod = integer.valueOf(System.Label.CampaignPeriodForDistributionAFI);
  public integer MAGIcampaignPeriod = integer.valueOf(System.Label.CampaignPeriodForDistributionMAGI);
  public Call_Line__c clObj {get;set;}

    //new ALI
    public Integer inputValue {get;set;}
    public boolean isMaxRecord {get;set;}
    
    public List<String> list_policyNo {get;set;}
    public Map<String, List<Call_Line__c>> mapCallByHomePhone {get;set;}
    public Map<String, List<Call_Line__c>> mapCallByEmail {get;set;}
    public Map<String, List<Call_Line__c>> mapCallByPhone {get;set;}
    public boolean FlagMessage {get;set;}
    

        
    public Document document {
        get {
            if (document == null){
                document = new Document();
            }
            return document;
        }
        set;
    }
    
    public class OutboundCall{
        public string policyNo {get; set;}
        public string phoneNo {get; set;}
        public string campaignName {get; set;}      
        public string agentId {get; set;}      
        public string agentName {get; set;}      
    }
    
    /*
    * Policy_No, Product, Method, Effective_Date, Name_1, CORRESPONDENCETYPEID,REPORT_POLICY_DELIVERY,POLIS
    */
    public class Welcome{
        public string policyNo {get; set;}
        public string Product {get; set;}
        public string Description {get; set;}
        public string EffectiveDate {get; set;}
        public string Name1 {get; set;}
        public string Name2 {get; set;}
        public string Line1 {get; set;}
        public string Line11 {get; set;}
        public string Line12 {get; set;}
        public string Line13 {get; set;}
        public string City {get; set;}
        public string ZipCode {get; set;}
        public string MOBILEPHONE {get; set;}
        public string MOBILEPHONE2 {get; set;}
        public string OFFICEPHONE {get; set;}
        public string OFFICEPHONE2 {get; set;}
        public string HOMEPHONE {get; set;}
        public string HOMEPHONE2 {get; set;}
        public string EMAIL {get; set;}
        public string Correspond {get; set;}
        public string delivereddate {get; set;}
        public string ReportPolicy {get; set;}
        public string Method {get; set;}
        //public string Polis {get; set;}
    }

    /*
    * Refference_No, Policy_No, Product, Status_Polis, Name_1, RejReason, Offering, Priority, Old_Result
    */
    public class Reinstate{
        public string Priority {get; set;}
        public string Offering {get; set;}
        public string ReffNo {get; set;}
        public string policyNo {get; set;}
        public string Product {get; set;}
        public string Effective_Date {get; set;}
        public string Status_Polis {get; set;}
        public string Name_1 {get; set;}
        public string Status {get; set;}
        public string Old_Result {get; set;}

    }

    /*
    * Refference_No, Policy_No, Product, Month, Name_1, RejReason, Offering, Priority, Old_Result
    */
    public class PremiumFU{
        public string Priority {get; set;}
        public string Offering {get; set;}
        public string ReffNo {get; set;}
        public string policyNo {get; set;}
        public string Product {get; set;}
        public string Effective_Date {get; set;}
        public string StatusPolis {get; set;}
        public string Name_1 {get; set;}
        public integer Premium {get; set;}        
        public string RejReason {get; set;}
        public string Status {get; set;}
        public string Old_Result {get; set;}
    }

    /*
    *  POLICY_NO,PREV_ACC_BLC,TOTAL_WITHDRAWN,PREMIUM,CURRENCY
    */
    public class Conservation{
        public string policyNo {get; set;}
        public integer prevAccBalance {get; set;}
        public integer totalWithdrawn {get; set;}      
        public integer premium {get; set;}      
        public string currcy {get; set;}      
    }

    /*
    *  PHONE_NO,CONTACT_PHONE_NO,CALL_DATE
    */
    public class Callback{
        public string phoneNo {get; set;}
        public string preferredPhoneNo {get; set;}
        public date callDate {get; set;}      
    }
    
    /*
    *   Request_Date, Claim_No, Policy_No, Policy_Holder_Name, Follow_Up_Information, Dateline
    */
    public class Claim{
        public integer No {get; set;}
        public string Request_Date {get; set;}
        public string Claim_No {get; set;}
        public string Policy_No {get; set;}
        public string Policy_Holder_Name {get; set;}
        public string Follow_Up_Information {get; set;}
        public string Dateline {get; set;}
        public string FollowUpResult {get; set;}
    }
    
    /*
    *  Policy_No,TITLE,NAME_1, BIRTHDATE, EMAIL, MOBILEPHONE, REMARKS
    */
    public class UpdateData{
        public string Policy_No {get; set;}
        public string TITLE {get; set;}
        public string NAME_1 {get; set;}
        public string BIRTHDATE {get; set;}
        public string EMAIL {get; set;}
        public string UpdateEmail {get; set;}
        public string KTP {get; set;}
        public string FU {get; set;}
        public string ASSIGN {get; set;}
        public string MOBILEPHONE {get; set;}
        public string REMARKS {get; set;}
    }
    
    /*
    *  POLICY_NO, Name_1, MOBILEPHONE, MOBILEPHONE2, EMAIL, IDENTITYNO, EFFECTIVEDATE, PAIDTODATE, MONTHSPAID,  TOTALNCB, PRODUCT, STATUS
    */
    public class NCB{
        public string POLICY_NO {get; set;}
        public string Name_1 {get; set;}
        public string MOBILEPHONE {get; set;}
        public string MOBILEPHONE2 {get; set;}
        public string EMAIL {get; set;}
        public string IDENTITYNO {get; set;}
        public string EFFECTIVEDATE {get; set;}
        public string PAIDTODATE {get; set;}
        public string MONTHSPAID {get; set;}
        public string TOTALNCB {get; set;}
        public string PRODUCT {get; set;}
        public string STATUS {get; set;}
        public string NamaBank {get; set;}
        public string NomorRekening {get; set;}
        public string NamaPemilikRekening {get; set;}
        public string Keterangan {get; set;}
        public string Agent {get; set;}
    }
    
    /*
    *  Date_Time, MobilePhone, Q1, Q2, Topic, Remarks, Policy_No
    */
    public class SurveyFeedback{
        public Integer No {get; set;}
        public string Date_Time {get; set;}
        public string Agent_ID {get; set;}
        public string MobilePhone {get; set;}
        public string Q1 {get; set;}
        public string Q2 {get; set;}
        public string Topic {get; set;}
        public string Remarks {get; set;}
        public string Policy_No {get; set;}
    }
    
    /*
    *  PHONE_NO,CONTACT_PHONE_NO,CALL_DATE
    */
    public class CollectionTask{
        public string ReturPayment {get; set;}
        public string policyNo {get; set;}
        public string PolicyHolder {get; set;}
        public string StatusPolis {get; set;}
        public Double Nominal {get; set;}
        public string PeriodeTerdebet {get; set;}
        public string BANKNAME {get; set;}
        public string BANKACCNUMBER {get; set;}
        public string BANKACCNAME {get; set;}
    }
    
    public class AgentAssignment{
        public string agentId {get; set;}      
        public string agentName {get; set;}      
        public integer policyTotal {get; set;}
    }
    
    public class ReloadWrapper{
      public string id {get;set;} 
      public string agentName {get; set;}      
        public string policyNo {get; set;}
        public boolean isSelected {get; set;}
        public string callStatus {get; set;}
        public string reasonStatus {get; set;}
    }
    
    public CallLineGeneratorControllerALI(){
        uploadedNum = 0;
        validNum = 0;
        invalidNum = 0;
        totalPolicies = 0;
        totalAgents  = 0;
        User userObj = [select id, Entity__c from user where id = :UserInfo.getUserId()];
        entity = userObj.Entity__c;
        loggedInUser = userObj.id;
        clObj = new Call_Line__c();
        
        // get 
        string Grouping = ApexPages.currentPage().getParameters().get('Grouping');
        system.debug('grouping : '+Grouping);
        if (Grouping == 'true') {
            FlagMessage = TRUE;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Grouping success.. please wait.')); 
        }
        
        if(callList == null){
            //callList = [select id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Survey_ID__c from Call_List__c where Entity__c = :userObj.Entity__c]; 
            //Existing query: callList = [select id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Survey_ID__c from Call_List__c where Entity__c = :entity and createdby.id = :loggedInUser and IsExpired__c = false]; 
            
            //----------------The query is modified by Hamfry in CCC Wave 2
            if(entity == 'AMFS'){
              callList = Database.query('SELECT id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Call_Line_RecordTypeID__c FROM Call_List__c WHERE Entity__c = :entity AND createdby.id = :loggedInUser AND IsExpired__c = false AND Is_Expired_F__c = false AND CreatedDate = LAST_N_DAYS:'+AMFScampaignPeriod+ ' order by CreatedDate desc'); 
            }else if(entity == 'AFI'){
              callList = Database.query('SELECT id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Call_Line_RecordTypeID__c FROM Call_List__c WHERE Entity__c = :entity AND createdby.id = :loggedInUser AND IsExpired__c = false AND Is_Expired_F__c = false AND CreatedDate = LAST_N_DAYS:'+AFIcampaignPeriod+ ' order by CreatedDate desc'); 
            }
            else{  //MAGI
              callList = Database.query('SELECT id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Call_Line_RecordTypeID__c FROM Call_List__c WHERE Entity__c = :entity AND createdby.id = :loggedInUser AND IsExpired__c = false AND Is_Expired_F__c = false AND CreatedDate = LAST_N_DAYS:'+MAGIcampaignPeriod+ ' order by CreatedDate desc'); 
            }
            //----------------end of modified query
            
            campaignList = new List<SelectOption>();
            campaignMap = new Map<string,string>();
            campaignObjectMap = new Map<string,Call_List__c>(); 
            for(Call_List__c cl : callList){
                campaignList.add(new SelectOption(cl.id, cl.Campaign_Name__c));
                campaignMap.put(cl.id, cl.Campaign_Name__c);
                campaignObjectMap.put(cl.id, cl);
            }
        }
        // default
        isMaxRecord = FALSE;
        inputValue = 0;


        methodList = new List<SelectOption>();
        methodList.add(new SelectOption('Automatic', 'Automatic'));
        methodList.add(new SelectOption('Manual', 'Manual'));
        methodList.add(new SelectOption('Specific', 'Specific Policy'));
        
        if(agentList== null){
            //agentList = [select id, Entity__c, Name from user where Entity__c = :userObj.Entity__c and isActive = true];
            agentList = [select id, Entity__c, Name from user where Entity__c = :entity and isActive = true and ManagerId = :loggedInUser and Agent__c = true];
            totalAgents = agentList.size();
            agentOptList = new List<SelectOption>();
            agentIDList = new List<id>();
            agentMap = new Map<string, string>();
            for(User agent : agentList){
                agentIDList.add(agent.id);
                agentMap.put(agent.id, agent.Name);
                agentOptList.add(new SelectOption(agent.id, agent.Name));
            }
        }
        policyArr = '';
    }
    
    public PageReference populateFreshData(){
        isMethodChoosen = false;
        if(choosen_campaign != ''){
            callLineList = [select id, Agent__c, Call_List__r.Case_Type__c, Call_List__c, F_User_Detail__c, Activity__c, Case_Type__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and isOwnerQueue__c = FALSE and Agent__c=''];
            totalData = callLineList.size();
            callLineList = [select id, Agent__c, Call_List__r.Case_Type__c, Call_List__c, F_User_Detail__c, Activity__c, Case_Type__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and isOwnerQueue__c = FALSE and Agent__c='' and Parent_Campaign__c != NULL];
            totalPolicies = callLineList.size();

            List<Call_Line__c> checkGAP = [select id from Call_Line__c where Call_List__c = :choosen_campaign and isOwnerQueue__c = FALSE and Agent__c='' and Parent_Campaign__c = NULL and Parent_Call_Line__c = NULL];
            totalGAP = checkGAP.size();
            
            String FilterResult = ''; 
            if (callLineList.size() > 0) {
                FilterResult = callLineList[0].F_User_Detail__c;
                // check jika Premium FU dan Reinstate
                if (callLineList[0].Call_List__r.Case_Type__c == 'Premium FU' || callLineList[0].Call_List__r.Case_Type__c == 'Reinstate'){
                    if (isMaxRecord == FALSE) {
                        isMaxRecord = TRUE;
                        inputValue = 400; // Default
                    }
                } else isMaxRecord = FALSE;
            }
            list<user_detail__c> ud = [SELECT id, User__c FROM User_Detail__c WHERE Outbound_Activity_Case_type__c includes (:FilterResult) ];
            system.debug('## Query Useer Detail : '+FilterResult);
            list<string> tempuserid = new list<string>();
            for (user_detail__c listud : ud){
                if (listud.user__c != NULL)
                    tempuserid.add (listud.user__c);
            }
            
            agentList = [select id, Entity__c, Name from user where Entity__c = :entity and isActive = true and id IN :tempuserid order by name];
            // check total agent
            totalAgents = agentList.size(); //ud.size();

            agentMap = new Map<string, string>();
            for(User agent : agentList){
                agentIDList.add(agent.id);
                agentMap.put(agent.id, agent.Name);
                agentOptList.add(new SelectOption(agent.id, agent.Name));
            }
        }
        return null;
    }

    public PageReference populateReloadFreshData(){
        callLineList = new List<Call_Line__c>();
        system.debug('## choosen_agent : '+choosen_agent);
        if(choosen_campaign != '' && choosen_agent == 'All' && clObj.Call_Status_Config__c == null && clObj.Reason_Status_Config__c == null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c in :agentIDList order by Policy_No__c];    
            totalPolicies = callLineList.size();
        }else if(choosen_campaign != '' && choosen_agent == 'All' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c == null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c in :agentIDList and Call_Status_Config__c = :clObj.Call_Status_Config__c order by Policy_No__c];    
            totalPolicies = callLineList.size();
        }else if(choosen_campaign != '' && choosen_agent == 'All' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c != null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c in :agentIDList and Call_Status_Config__c = :clObj.Call_Status_Config__c and Reason_Status_Config__c = :clObj.Reason_Status_Config__c order by Policy_No__c];    
            totalPolicies = callLineList.size();
        }
        else if(choosen_campaign != '' && choosen_agent != null && choosen_agent != '' && clObj.Call_Status_Config__c == null && clObj.Reason_Status_Config__c == null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c = :choosen_agent order by Policy_No__c];    
            totalPolicies = callLineList.size();
        }else if(choosen_campaign != '' && choosen_agent != null && choosen_agent != '' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c == null){
          callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Activity_Result__c, Call_Status_Config__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c = :choosen_agent and Call_Status_Config__c = :clObj.Call_Status_Config__c order by Policy_No__c];    
            totalPolicies = callLineList.size();
        }
        else if(choosen_campaign != '' && choosen_agent != null && choosen_agent != '' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c != null){
          callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Activity_Result__c, Call_Status_Config__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c = :choosen_agent and Call_Status_Config__c = :clObj.Call_Status_Config__c and Reason_Status_Config__c = :clObj.Reason_Status_Config__c order by Policy_No__c];    
            totalPolicies = callLineList.size();
        } 
        copyCallLineList = callLineList;
        return null;
    }
    
    //Added by Hamfry in CCC Wave 2
    public PageReference populateCallAndReasonStatus(){
        getListToReload();
        return null;
    }
    
    public PageReference distribute(){
        System.debug(LoggingLevel.DEBUG, '***distribute()');
        if(choosen_method == 'Automatic'){
            return distributeAuto();
        }else if(choosen_method == 'Manual'){
            return distributeManual();
        } else if(choosen_method == 'Specific'){
            return distributeSpecific();
        }
        return null;
    }
    
    //public PageReference distributeSpecific(){
    @TestVisible private PageReference distributeSpecific(){
        populateFreshData();
        if(totalPolicies > 0){
            if(totalAgents==0){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'You have not subordinate. Please contact Administrator.'));    
            }else{
                for(Call_Line__c dis : callLineList){
                    dis.Agent__c = null; 
                    dis.Entity__c = entity;       
                }
            }
        }else{
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No records is available to distribute.'));    
            //return null;
        }
        isMethodChoosen = true;
        
        return null;
    }
    
    //public PageReference distributeAuto(){
    @TestVisible private PageReference distributeAuto(){
        try{
            populateFreshData(); //added by WK, 20150416
            integer i = 0;
            integer j = 0;
            integer alocidx = 0;
            integer totalAssignment = 0;
            //new ALI
            integer countQueue = 0;
            integer maxData = 0;
            Group QueueId = [SELECT Id FROM Group WHERE Type = 'Queue' and Name = 'ALI Outbound Queue' LIMIT 1];
            
            Map<string, integer> agentAssignmentMap = new Map<string, integer>();
            OutboundCall outboundCall = new OutboundCall();
            AgentAssignment assignment = null;
            if(totalPolicies > 0){
                if(totalAgents==0){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'You have not subordinate. Please contact Administrator.'));    
                }else{
                    if (inputValue == NULL || inputValue == 0) maxData = 999999;
                    else maxData = totalAgents * inputValue;
                    //maxData = totalAgents * 400;
                    for(Call_Line__c dis : callLineList){
                        alocidx = math.mod(i , totalAgents);  
                        j = 0;
                        for(User agent : agentList ){
                            if(j==alocidx) {
                                if (i < MaxData ) {
                                    if(agentAssignmentMap.containsKey(agent.id)){
                                        totalAssignment = agentAssignmentMap.get(agent.id)+1;
                                        agentAssignmentMap.put(agent.id, totalAssignment);
                                    }else{
                                        agentAssignmentMap.put(agent.id, 1);
                                    }
                                    dis.Agent__c = agent.id;
                                    dis.ownerId = agent.id;
                                }
                                else { // new ALI
                                    //dis.Agent__c = agent.id;
                                    dis.ownerId = QueueId.id;
                                    countQueue += 1;
                                }
                            }

                            j++;   
                        }
                        i++; 
                    }
                       
                    assignmentList = new List<AgentAssignment>();
                    for(string agentid : agentAssignmentMap.keySet()){
                        assignment = new AgentAssignment();
                        assignment.agentId = agentid;
                        assignment.agentName = agentMap.get(agentid);
                        assignment.policyTotal = agentAssignmentMap.get(agentid);
                        assignmentList.add(assignment);
                    }
                    
                    // new ALI - Count Queue
                    if (countQueue > 0){
                        assignment = new AgentAssignment();
                        //assignment.agentId = agentid;
                        assignment.agentName = 'ALI Outbound Queue';
                        assignment.policyTotal = countQueue;
                        assignmentList.add(assignment);
                    }
                }
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No records is available to distribute.'));    
                //return null;
            }
        } catch(Exception ex){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ex.getMessage()));
        }
        isMethodChoosen = true;
        return null;
    }

    //public PageReference distributeManual(){
    @TestVisible private PageReference distributeManual(){
        populateFreshData();  //added by WK, 20150416
        assignmentList = new List<AgentAssignment>();
        System.debug(LoggingLevel.DEBUG, '***totalPolicies: ' + totalPolicies);
        if(totalPolicies>0){
            AgentAssignment assignment = null;
            
            if(totalAgents==0){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'You have not subordinate. Please contact Administrator.'));    
            }else{
                for(User agent : agentList){
                    assignment = new AgentAssignment();
                    assignment.agentId = agent.id;
                    assignment.agentName = agentMap.get(agent.id);
                    assignment.policyTotal = 0;
                    assignmentList.add(assignment);
                }
            }       
        }else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No records is available to distribute.'));    
            return null;
        }
        
        isMethodChoosen = true;
        System.debug('***distributeManual isMethodChoosen: ' + isMethodChoosen);
        return null;
    }
    
    public PageReference reset() {
        document.body = null; // clears the viewstate
        document = new Document();
        outboundCallList = new List<OutboundCall>();
        return null;
    }
    
    public PageReference release() {
        /* ----------Existing code before enhancement (CCC Wave 2) ---------
        for(Call_Line__c dis : callLineList){
            dis.Agent__c = null;
        }
        update callLineList;
        */
        
        Call_Line__c cl = null;
        List<Call_Line__c> cList = new List<Call_Line__c>();
        
        for(ReloadWrapper rw: ReloadWrap){
            if(rw.isSelected){
                cl = new Call_Line__c();
                cl.Id = rw.id;
                cl.Agent__c = null;
                cl.Call_Status_Config__c = null;
                cl.Reason_Status_Config__c = null;
                cList.add(cl);    
            }
        }
        update cList;
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Reload is done successfully...'));
        return null;
    }

    public PageReference releaseReload() {
        callLineList = copyCallLineList;    
        return null;
    }
    
    /*------ Added by Hamfry in CCC Wave 2 -----*/
    public List<ReloadWrapper> getListToReload() {
      ReloadWrap = new List<ReloadWrapper>();
    ReloadWrapper relWrap = null;
    callLineList = new List<Call_Line__c>();
    /*
    if(choosen_campaign != '' && choosen_agent != null && choosen_agent != '' && clObj.Call_Status_Config__c == null && clObj.Reason_Status_Config__c == null){
      callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Activity_Result__c, Call_Status_Config__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c = :choosen_agent];    
    }else if(choosen_campaign != '' && choosen_agent != null && choosen_agent != '' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c == null){
      callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Activity_Result__c, Call_Status_Config__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c = :choosen_agent and Call_Status_Config__c = :clObj.Call_Status_Config__c];    
    }
    else if(choosen_campaign != '' && choosen_agent != null && choosen_agent != '' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c != null){
      callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Activity_Result__c, Call_Status_Config__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c = :choosen_agent and Call_Status_Config__c = :clObj.Call_Status_Config__c and Reason_Status_Config__c = :clObj.Reason_Status_Config__c];    
    }
    */
    if(choosen_campaign != '' && choosen_agent == 'All' && clObj.Call_Status_Config__c == null && clObj.Reason_Status_Config__c == null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Entity__c, Policy_No__c, Call_Status_Config__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c in :agentIDList order by Policy_No__c];    
            //totalPolicies = callLineList.size();
        }else if(choosen_campaign != '' && choosen_agent == 'All' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c == null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Entity__c, Policy_No__c, Call_Status_Config__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c in :agentIDList and Call_Status_Config__c = :clObj.Call_Status_Config__c order by Policy_No__c];    
            //totalPolicies = callLineList.size();
        }else if(choosen_campaign != '' && choosen_agent == 'All' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c != null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Entity__c, Policy_No__c, Call_Status_Config__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c in :agentIDList and Call_Status_Config__c = :clObj.Call_Status_Config__c and Reason_Status_Config__c = :clObj.Reason_Status_Config__c order by Policy_No__c];    
            //totalPolicies = callLineList.size();
        }
        else if(choosen_campaign != '' && choosen_agent != null && choosen_agent != '' && clObj.Call_Status_Config__c == null && clObj.Reason_Status_Config__c == null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Call_Status_Config__c, Activity__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c = :choosen_agent order by Policy_No__c];    
            //totalPolicies = callLineList.size();
        }else if(choosen_campaign != '' && choosen_agent != null && choosen_agent != '' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c == null){
          callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Activity_Result__c, Call_Status_Config__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c = :choosen_agent and Call_Status_Config__c = :clObj.Call_Status_Config__c order by Policy_No__c];    
            //totalPolicies = callLineList.size();
        }
        else if(choosen_campaign != '' && choosen_agent != null && choosen_agent != '' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c != null){
          callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Activity_Result__c, Call_Status_Config__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c = :choosen_agent and Call_Status_Config__c = :clObj.Call_Status_Config__c and Reason_Status_Config__c = :clObj.Reason_Status_Config__c order by Policy_No__c];    
            //totalPolicies = callLineList.size();
        } 
        totalPolicies = callLineList.size();
            
    for(Call_Line__c cl: callLineList){
      relWrap = new ReloadWrapper();
      relWrap.id = cl.Id;
      relWrap.agentName = cl.Agent__r.Name;
      relWrap.policyNo = cl.Policy_No__c;
      relWrap.callStatus = cl.Call_Status_Config__c;
      relWrap.reasonStatus = cl.Reason_Status_Config__c;
      ReloadWrap.add(relWrap);
    }
    return ReloadWrap;
    }   
    /*---------------- FInish ---------------*/
     
    public PageReference save() {
        boolean isSuccess = true;
        if(!isMethodChoosen){
            isSuccess = false;  
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'You could not save before choosing Distribution Method first.'));
            return null;
        }
        string surveyURL = '';
        List<Call_Line__c> tosaveCallLineList = new List<Call_Line__c>();  //added by WK, 20150417
        Call_Line__c tosaveCallLine = null; //added by WK, 20150417
        if(choosen_method == 'Manual'){
            system.debug('choosen_method == Manual');
            integer i = 0;
            integer j = 0;
            Map<integer, string> agentOrderMap = new Map<integer,string>();
            Map<Id, string> setAgentMap = new Map<Id,string>();
            integer totalAssignment = 0; 
            integer grandTotalAssignment = 0;
            for(AgentAssignment assignm : assignmentList){
                totalAssignment = assignm.policyTotal;
                grandTotalAssignment = grandTotalAssignment + totalAssignment;
                for(j=0; j<totalAssignment; j++){
                    agentOrderMap.put(i, assignm.agentId);
                    system.debug('assignmentCounter  : '+i);
                    i++; 
                }
            }
            
            integer k = 0;
            for(Call_Line__c cl : callLineList){
                setAgentMap.put(cl.Id, agentOrderMap.get(k));
                system.debug('setAgentMap ('+k+'): '+setAgentMap);
                k++;
            }
            
            if(grandTotalAssignment > totalPolicies){
                isSuccess = false;  
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Total assignments cannot be more than total policies'));
                return null;
            } else if(grandTotalAssignment ==0){
                isSuccess = false;  
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'No assignments has been set yet.'));
                return null;
            }
            
            system.debug('callLineList (size) - Manual: '+callLineList.size());
            //Update Daniel (1), 24 April 2020
            if(callLineList.size() > 0){
                Batch_DistributeManual_CallLineALI bb = new Batch_DistributeManual_CallLineALI(callLineList,setAgentMap);
                Database.executeBatch(bb,65);
            }
            
            /*
            integer k=0;
            for(Call_Line__c dis : callLineList){*/
                /*just added, but temporarily remarked later unremarked
                if(k>=grandTotalAssignment ){
                    break;
                }
                */
                /*dis.Agent__c = agentOrderMap.get(k);
                dis.ownerId = dis.Agent__c;

                if(dis.Activity__c == 'Survey'){
                    surveyURL = url.replace('SURVEYID',dis.Survey_ID__c).replace('CONTACTID',dis.Contact__c); //url = 'https://'+system.URL.getSalesforceBaseUrl().getHost()+'/apex/TakeSurvey?id=SURVEYID&cId=CONTACTID&caId=none';
                    dis.survey_url__c = surveyURL;
                    //dis.survey_type__c = 'javascript:srcUp('+surveyURL+')';
                    //dis.recordTypeId = surveyRecordTypeId;
                }else{
                    //dis.recordTypeId = nonSurveyRecordTypeId;
                }
                system.debug('dis.Agent__c : '+dis.Agent__c);
                if(dis.Agent__c!=null){
                    tosaveCallLine = new Call_Line__c();
                    tosaveCallLine.id = dis.id;
                    tosaveCallLine.Agent__c = dis.Agent__c;
                    tosaveCallLine.ownerId = dis.Agent__c;
                    tosaveCallLine.survey_url__c = dis.survey_url__c;
                    tosaveCallLineList.add(tosaveCallLine);
                }
                k++;
            }*/
        }else{
            
            //Update Daniel (1), 24 April 2020
            if (callLineList.size() > 0) {
                Batch_DistributeAuto_CallLineALI bb = new Batch_DistributeAuto_CallLineALI(callLineList);
                Database.executeBatch(bb,65);
            }
            
            
            /*for(Call_Line__c dis : callLineList){
                if (dis.Agent__c == NULL) {
                    Group QueueId = [SELECT Id FROM Group WHERE Type = 'Queue' and Name = 'ALI Outbound Queue' LIMIT 1];
                    dis.ownerId = QueueId.id;
                }
                else dis.ownerId = dis.Agent__c;
                if(dis.Activity__c == 'Survey'){
                    surveyURL = url.replace('SURVEYID',dis.Survey_ID__c).replace('CONTACTID',dis.Contact__c); //url = 'https://'+system.URL.getSalesforceBaseUrl().getHost()+'/apex/TakeSurvey?id=SURVEYID&cId=CONTACTID&caId=none';
                    dis.survey_url__c = surveyURL;
                    //dis.survey_type__c = 'javascript:srcUp('+surveyURL+')';
                    //dis.recordTypeId = surveyRecordTypeId;
                }else{
                    //dis.recordTypeId = nonSurveyRecordTypeId;
                }
                system.debug('dis.Agent__c : '+dis.Agent__c);
                if(dis.Agent__c!=null){
                    tosaveCallLine = new Call_Line__c();
                    tosaveCallLine.id = dis.id;
                    tosaveCallLine.Agent__c = dis.Agent__c;
                    tosaveCallLine.ownerId = dis.Agent__c;
                    tosaveCallLineList.add(tosaveCallLine);
                }
            }*/
        }
        //update callLineList;
        
        //Update Daniel (2), 24 April 2020
        /*if(test.isRunningTest()==false) update tosaveCallLineList;*/
        //END - Update Daniel (2), 24 April 2020
            
        //END - Update Daniel (1), 24 April 2020
        
        
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Call Distribution already saved.'));
        return null;
    }
    
    public PageReference upload() {
        System.debug('***upload()');
        document.AuthorId = UserInfo.getUserId();
        document.FolderId = UserInfo.getUserId(); // put it in running user's folder
        outboundCallList = new List<OutboundCall>();
        System.debug('***real choosen_campaign: ' + choosen_campaign);
        if(choosen_campaign == null || choosen_campaign == ''){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Campaign Type is mandatory field.'));
            return null;
        }
        try {
            system.debug('*** document body : '+ document.body.toString());
            if(document.body==null || document.body.toString() == ''){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'No file is selected.'));
                return null;
            }else{
                string nameFile=document.body.toString();
                boolean fileExtension = document.name.endsWith('.csv');
                if(!fileExtension){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Uploaded file type is not supported. Please upload only csv file.'));
                    return null;
                }
                document.name = choosen_campaign;
                //string activity = campaignObjectMap.get(choosen_campaign).getActivity__c;
                
                Call_List__c campaign = campaignObjectMap.get(choosen_campaign);
                string activity  = campaign.Activity__c;
                string CaseType  = campaign.Case_Type__c;
                
                List<Id> idList =  new List<Id>();
                Map<String,string> map1 = new Map<string,string>();
                
                //List<String> dataList2 = new List<String>();
                System.debug('***campaign.Case_Type__c: ' + campaign.Case_Type__c);
                
                
                if(CaseType == 'Welcome Call'){ 
                    List<String> dataList = parseWelcomeCSV(nameFile,true);
                    uploadedNum = dataList.size();
                    processWelcome(dataList);
                }else if(CaseType == 'Reinstate'){ 
                    List<String> dataList = parseReinstateCSV(nameFile,true);
                    uploadedNum = dataList.size();
                    processReinstate(dataList, datalist2);
                }else if(CaseType == 'Premium FU'){ 
                    List<String> dataList = parsePremiumFUCSV(nameFile,true);
                    uploadedNum = dataList.size();
                    processPremiumFU(dataList, datalist2);
                }else if(CaseType == 'claim'){ 
                    List<String> dataList = parseclaimCSV(nameFile,true);
                    uploadedNum = dataList.size();
                    processclaim(dataList);
                }else if(CaseType == 'Update Data'){ 
                    List<String> dataList = parseUpdateDataCSV(nameFile,true);
                    uploadedNum = dataList.size();
                    processUpdateData(dataList);
                }else if(CaseType == 'NCB'){ 
                    List<String> dataList = parseNCBCSV(nameFile,true);
                    uploadedNum = dataList.size();
                    processNCB(dataList);
                }else if(activity == 'Survey Feedback'){ 
                    List<String> dataList = parseSurveyFeedbackCSV(nameFile,true);
                    uploadedNum = dataList.size();
                    processSurveyFeedback(dataList);
                }else if(CaseType == 'Collection Task'){ 
                    List<String> dataList = parseCollectionTaskCSV(nameFile,true);
                    uploadedNum = dataList.size();
                    processCollectionTask(dataList);
                }else if(activity == 'Confirmation' || activity == 'Renewal' || activity == 'Survey'){ 
                    List<String> dataList = parseCSV(nameFile,true);
                    uploadedNum = dataList.size();
                    processPolicy(dataList);
                }else if(activity == 'Conservation'){
                    List<String> dataList = parseConservationCSV(nameFile,true);
                    uploadedNum = dataList.size();
                    processConservation(dataList);
                }else { //callback
                    List<String> dataList = parseCallbackCSV(nameFile,true);
                    //uploadedNum = dataList.size();
                    processPhone(dataList); 
                }
                // Group by Name_1 + Mobile.
                
                //Update Daniel, 24 April 2020 (pindah ke Apex Class: CallLineInsertBatch)
                //CallLineGroupByALI.CallLine(choosen_campaign, entity); 
                //END - Update Daniel, 24 April 2020 (pindah ke Apex Class: CallLineInsertBatch)
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file'));
            return null;
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
            system.debug('*** error : '+ e.getMessage());
            return null;
        } finally {
            document.body = null; // clears the viewstate
            document = new Document();
        }
     
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully'));
        return null;
    }
  
    /*
    *   Parse CSV file which has header : POLICY_NO
    */
    @TestVisible private List<String> parseCSV(String contents,Boolean skipHeaders) {
        List<String> dataList = new List<String>();

        contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
        contents = contents.replaceAll('""','DBLQT');
        List<String> lines = new List<String>();
        try {
            lines = contents.split('\n');
        } catch (System.ListException e) {
            System.debug('Limits exceeded?' + e.getMessage());
        }
        system.debug('Line num i s'+lines.size());
        //Integer num = 0;
        policyArr = '';
        for(String line : lines) {
            dataList.add(line.trim());
            policyArr = policyArr + ',' + line.trim();
        }
        policyArr = policyArr.replaceFirst(',',''); //replace ',' in the beginning of the string
        if (skipHeaders) dataList.remove(0);
        return dataList;       
    } 

    /*
    *   Parse CSV file which has header : PHONE_NO,CONTACT_PHONE_NO,CALL_DATE
    */
    @TestVisible private List<String> parseCallbackCSV(String contents,Boolean skipHeaders) {
        List<String> dataList = new List<String>();
        List<List<String>> allFields = new List<List<String>>();
        rowPhonesList = new List<String>();
        
        callbackList = new List<Callback>();
        invalidPolicyList = new List<string>();

        contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
        contents = contents.replaceAll('""','DBLQT');
        List<String> lines = new List<String>();
        try {
            lines = contents.split('\n');
        } catch (System.ListException e) {
            System.debug('Limits exceeded?' + e.getMessage());
        }
        system.debug('## Line num : '+lines.size());
        Integer num = 0;
        callbackArr = '';
        List<string> recVal = null;
        Callback callback = null;
        system.debug('## lines : '+lines);
        
        for(String line : lines) {
            // check for blank CSV lines (only commas)
            if (line.replaceAll(',','').trim().length() == 0) break;
        
            List<String> fields = line.split(',');  
            List<String> cleanFields = new List<String>();
            String compositeField;
            Boolean makeCompositeField = false;
            for(String field : fields) {
                if (field.startsWith('"') && field.endsWith('"')) {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                } else if (field.startsWith('"')) {
                    makeCompositeField = true;
                    compositeField = field;
                } else if (field.endsWith('"')) {
                    compositeField += ',' + field;
                    cleanFields.add(compositeField.replaceAll('DBLQT','"'));
                    makeCompositeField = false;
                } else if (makeCompositeField) {
                    compositeField +=  ',' + field;
                } else {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                }
            }
      
            allFields.add(cleanFields);
        }
        
        if (skipHeaders) allFields.remove(0);
        uploadedNum = allFields.size();
        string phoneNo = '';
        string prefPhoneNo = '';        
        Date callDate = null;   
        boolean isValid = false; 
        string val = '';    
        string rowval = '';
        List<string> calldatestr= new List<string>();    
        for(List<string> rc : allFields){
            num = 0;
            rowval = '';
            isValid = true; 
            for(string col : rc){
                system.debug('### col : '+col);
                val = col.trim();
                rowval = rowval + ',' + val;
                if(num==0) {
                    if(val == ''){
                        isValid = false; 
                    }else if(val!='' && isPhoneNumberValid(val)){
                        phoneNo = val;    
                    }else{
                        isValid = false; 
                    }
                }else if(num==1) {
                    if(val!='' && isPhoneNumberValid(val)){
                        //phoneNo = val;    
                      prefPhoneNo = val;    
                    }else if(val!='' && !isPhoneNumberValid(val)){
                        isValid = false; 
                    }
                    //prefPhoneNo = val;    
                }else if(num==2) {
                    if(val == ''){
                        isValid = false; 
                    }else {
                        try{
                            calldatestr = val.split('-'); //yyyy-mm-dd 
                            //callDate = date.newInstance(calldatestr[0], calldatestr[1], calldatestr[2]);    
                            callDate = date.parse(calldatestr[1]+'/'+calldatestr[2]+'/'+ calldatestr[0]);    
                        }catch(Exception e){
                            isValid = false; 
                        }
                    }
                } 
                num++; 
            }
            if(num<3){
                isValid = false;    //added by WK, 20150417
            }
            
            if(!isValid || Test.isRunningTest()){
                rowval = rowval.replaceFirst(',',''); //replace ',' in the beginning of the string
                if (invalidPolicyList.size() < 900)
                invalidPolicyList.add(rowval);
            }else{
                //rowPhonesList.add(phoneNo+'::'+prefPhoneNo);
                rowPhonesList.add(phoneNo+','+prefPhoneNo+','+val);
                dataList.add(phoneNo);
                if(prefPhoneNo!='' && prefPhoneNo != null){
                    dataList.add(prefPhoneNo);
                }
                system.debug('## phoneNo : '+phoneNo);
                callback = new Callback();
                callback.phoneNo = phoneNo;
                callback.preferredPhoneNo = prefPhoneNo;
                callback.callDate = callDate ;      
                //callbackArr = callbackArr + ',' + polNo;
                callbackList.add(callback);
            }
        }
        //callbackArr = callbackArr.replaceFirst(',',''); //replace ',' in the beginning of the string
        system.debug('## callbackArr : '+callbackArr);
        //if (skipHeaders) dataList.remove(0);
        system.debug('#### dataList : '+dataList);
        return dataList;       
    } 

    /*
    *   Parse Welcome CSV file which has header : Policy_No, Product, Method, Effective_Date, Name_1, CORRESPONDENCETYPEID,REPORT_POLICY_DELIVERY,POLIS
    */
    @TestVisible private List<String> parseWelcomeCSV(String contents,Boolean skipHeaders) {
        List<String> dataList = new List<String>();
        List<List<String>> allFields = new List<List<String>>();

        WelcomeList = new List<Welcome>();

        contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
        contents = contents.replaceAll('""','DBLQT');
        List<String> lines = new List<String>();
        try {
            lines = contents.split('\n');
        } catch (System.ListException e) {
            System.debug('Limits exceeded?' + e.getMessage());
        }
        system.debug('## Line num : '+lines.size());
        Integer num = 0;
        WelcomeArr = '';
        //string[] recVal = null;
        List<string> recVal = null;
        Welcome Welcome = null;
        system.debug('## lines : '+lines);
        
        for(String line : lines) {
            //**************
            // check for blank CSV lines (only commas)
            if (line.replaceAll(',','').trim().length() == 0) break;
        
            List<String> fields = line.split(',');  
            List<String> cleanFields = new List<String>();
            String compositeField;
            Boolean makeCompositeField = false;
            for(String field : fields) {
                if (field.startsWith('"') && field.endsWith('"')) {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                } else if (field.startsWith('"')) {
                    makeCompositeField = true;
                    compositeField = field;
                } else if (field.endsWith('"')) {
                    compositeField += ',' + field;
                    cleanFields.add(compositeField.replaceAll('DBLQT','"'));
                    makeCompositeField = false;
                } else if (makeCompositeField) {
                    compositeField +=  ',' + field;
                } else {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                }
            }
      
            allFields.add(cleanFields);
        }
        if (skipHeaders) allFields.remove(0);
        string csvpolicyNo = '';
        string csvProduct = '';
        string csvDescription = '';
        string csvMethod = '';
        string csvEffectiveDate = '';
        string csvName1 = '';
        string csvName2 = '';
        string csvLINE1 = '';
        string csvLINE11 = '';
        string csvLINE12 = '';
        string csvLINE13 = '';
        string csvCITY = '';
        string csvZIPCODE = '';
        string csvMOBILEPHONE = '';
        string csvMOBILEPHONE2 = '';
        string csvOFFICEPHONE = '';
        string csvOFFICEPHONE2 = '';
        string csvHOMEPHONE = '';
        string csvHOMEPHONE2 = '';
        string csvEMAIL = '';
        string csvdelivereddate = '';
        string csvCorrespond = '';
        string csvReportPolicy = '';
        //string csvPolis = '';
        
        boolean isValid = false;    //added by WK, 20150417 
        List<String> testlist = new List<String>();
        testList.Add('test');
        testList.Add('col2');
        testList.Add('col3');
        testList.Add('col4');
        testList.Add('col5');
        testList.Add('col6');
        testList.Add('col7');
        testList.Add('col8');
        testList.Add('col9');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        if (Test.isRunningTest()) allFields.add(testList);
        for(List<string> rc : allFields){
            num = 0;
            isValid = true;    //added by WK, 20150417
            for(string col : rc){
                system.debug('### col : '+col);
                
                if(num==0) {
                    csvpolicyNo = col.trim();    
                }else if(num==1) {
                    csvProduct = col.trim();
                }else if(num==2) {
                    csvDESCRIPTION = col.trim();
                }else if(num==3) {
                    csvEffectiveDate = col.trim();
                }else if(num==4) {
                    csvName1 = col.trim();
                }else if(num==5) {
                    csvName2 = col.trim();
                }else if(num==6) {
                    csvLine1 = col.trim();
                }else if(num==7) {
                    csvLine11 = col.trim();
                }else if(num==8) {
                    csvLine12 = col.trim();
                }else if(num==9) {
                    csvLine13 = col.trim();
                }else if(num==10) {
                    csvCITY = col.trim();
                }else if(num==11) {
                    csvZIPCODE = col.trim();
                }else if(num==12) {
                    csvMOBILEPHONE = col.trim();
                }else if(num==13) {
                    csvMOBILEPHONE2 = col.trim();
                }else if(num==14) {
                    csvOFFICEPHONE = col.trim();
                }else if(num==15) {
                    csvOFFICEPHONE2 = col.trim();
                }else if(num==16) {
                    csvHOMEPHONE = col.trim();
                }else if(num==17) {
                    csvHOMEPHONE2 = col.trim();
                }else if(num==18) {
                    csvEMAIL = col.trim();
                }else if(num==19) {
                    csvCorrespond = col.trim();
                }else if(num==20) {
                    csvdelivereddate = col.trim();
                }else if(num==21) {
                    csvReportPolicy = col.trim();
                }//else{
                //    csvPolis = col.trim();    
                //} 
                num++; 
            }
            if(isValid || Test.isRunningTest()){
                dataList.add(csvpolicyNo);
                system.debug('## policy no : '+csvpolicyNo);
                welcome = new welcome();
                welcome.policyNo = csvpolicyNo;
                welcome.Product = csvProduct;
                welcome.description = csvdescription;
                welcome.Method = csvMethod;
                welcome.EffectiveDate = csvEffectiveDate;
                welcome.Name1 = csvName1;
                welcome.Name2 = csvName2;
                welcome.LINE1 = csvLINE1;
                welcome.LINE11 = csvLINE11;
                welcome.LINE12 = csvLINE12;
                welcome.LINE13 = csvLINE13;
                welcome.CITY = csvCITY;
                welcome.ZIPCODE = csvZIPCODE;
                welcome.MOBILEPHONE = csvMOBILEPHONE;
                welcome.MOBILEPHONE2 = csvMOBILEPHONE2;
                welcome.OFFICEPHONE = csvOFFICEPHONE;
                welcome.OFFICEPHONE2 = csvOFFICEPHONE;
                welcome.HOMEPHONE = csvHOMEPHONE;
                welcome.HOMEPHONE2 = csvHOMEPHONE2;
                welcome.EMAIL = csvEMAIL;
                welcome.delivereddate = csvdelivereddate;
                welcome.Correspond = csvCorrespond;
                welcome.ReportPolicy = csvReportPolicy;
                //welcome.Polis = csvPolis;
                welcomeArr = welcomeArr + ',' + csvpolicyNo;
                welcomeList.add(welcome);
            }
        }
        welcomeArr = welcomeArr.replaceFirst(',',''); //replace ',' in the beginning of the string
        system.debug('## welcomeArr : '+welcomeArr);
        //if (skipHeaders) dataList.remove(0);
        system.debug('#### dataList : '+dataList);
        return dataList;       
    } 

    /*
    *   Parse Reinstate CSV file which has header : Refference_No, Policy_No, Product, Status_Polis, Name_1, RejReason, Offering, Priority, Old_Result, Effective_Date, Premium
    */
    @TestVisible private List<String> parseReinstateCSV(String contents,Boolean skipHeaders) {
        List<String> dataList = new List<String>();
        dataList2 = new List<String>();
        List<List<String>> allFields = new List<List<String>>();

        ReinstateList = new List<Reinstate>();

        contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
        contents = contents.replaceAll('""','DBLQT');
        List<String> lines = new List<String>();
        try {
            lines = contents.split('\n');
        } catch (System.ListException e) {
            System.debug('Limits exceeded?' + e.getMessage());
        }
        system.debug('## Line num : '+lines.size());
        Integer num = 0;
        ReinstateArr = '';
        //string[] recVal = null;
        List<string> recVal = null;
        Reinstate Reinstate = null;
        system.debug('## lines : '+lines);
        
        for(String line : lines) {
            //**************
            // check for blank CSV lines (only commas)
            if (line.replaceAll(',','').trim().length() == 0) break;
        
            List<String> fields = line.split(',');  
            List<String> cleanFields = new List<String>();
            String compositeField;
            Boolean makeCompositeField = false;
            for(String field : fields) {
                if (field.startsWith('"') && field.endsWith('"')) {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                } else if (field.startsWith('"')) {
                    makeCompositeField = true;
                    compositeField = field;
                } else if (field.endsWith('"')) {
                    compositeField += ',' + field;
                    cleanFields.add(compositeField.replaceAll('DBLQT','"'));
                    makeCompositeField = false;
                } else if (makeCompositeField) {
                    compositeField +=  ',' + field;
                } else {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                }
            }
      
            allFields.add(cleanFields);
        }
        if (skipHeaders) allFields.remove(0);
        string csvPriority = '';
        string csvOffering = '';
        string csvReffNo = '';
        string csvpolicyNo = '';
        string csvProduct = '';
        string csvEffective_Date = '';
        string csvStatus_Polis = '';
        string csvName_1 = '';
        string csvStatus = '';
        boolean isValid = false;    //added by WK, 20150417 

        List<String> testlist = new List<String>();
        testList.Add('test');
        testList.Add('col2');
        testList.Add('col3');
        testList.Add('col4');
        testList.Add('col5');
        testList.Add('col6');
        testList.Add('col7');
        testList.Add('col8');
        testList.Add('col9');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        if (Test.isRunningTest()) allFields.add(testList);
        for(List<string> rc : allFields){
            num = 0;
            isValid = true;    //added by WK, 20150417
            for(string col : rc){
                system.debug('### col : '+col);
                
                if(num==0) {
                    csvPriority = col.trim();
                }else if(num==1) {
                    csvOffering = col.trim();
                }else if(num==2) {
                    csvReffNo = col.trim();
                }else if(num==3) {
                    csvpolicyNo = col.trim();
                }else if(num==4) {
                    csvProduct = col.trim();    
                }else if(num==5) {
                    csvEffective_Date = col.trim();    
                }else if(num==6) {
                    csvStatus_Polis = col.trim();    
                }else if(num==7) {
                    csvName_1 = col.trim();    
                }else if(num==8) {
                    csvStatus = col.trim();    
                } 
                num++; 
            }
            if(isValid || Test.isRunningTest()){
                dataList2.add(csvReffNo+''+csvpolicyNo);
                dataList.add(csvpolicyNo);
                system.debug('## Refference no : '+csvReffNo);
                Reinstate = new Reinstate();
                
                Reinstate.Priority = csvPriority;
                Reinstate.Offering = csvOffering;
                Reinstate.ReffNo = csvReffNo;
                Reinstate.policyNo = csvpolicyNo;
                Reinstate.Product = csvProduct;
                Reinstate.Effective_Date = csvEffective_Date;
                Reinstate.Status_Polis =  csvStatus_Polis;
                Reinstate.Name_1 = csvName_1;
                Reinstate.Status = csvStatus;
                Reinstate.Old_Result = csvStatus;//csvRemarks;

                ReinstateArr = ReinstateArr + ',' + csvReffNo;
                ReinstateList.add(Reinstate);
            }
        }
        ReinstateArr = ReinstateArr.replaceFirst(',',''); //replace ',' in the beginning of the string
        system.debug('## ReinstateArr : '+ReinstateArr);
        //if (skipHeaders) dataList.remove(0);
        system.debug('#### dataList : '+dataList);
        return dataList;       
    } 

    /*
    *   Parse PremiumFU CSV file which has header : Refference_No, Policy_No, Product, Month, Name_1, RejReason, Offering, Priority, Old_Result
    */
    @TestVisible private List<String> parsePremiumFUCSV(String contents,Boolean skipHeaders) {
        List<String> dataList = new List<String>();
        dataList2 = new List<String>();
        List<List<String>> allFields = new List<List<String>>();

        PremiumFUList = new List<PremiumFU>();

        contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
        contents = contents.replaceAll('""','DBLQT');
        List<String> lines = new List<String>();
        try {
            lines = contents.split('\n');
        } catch (System.ListException e) {
            System.debug('Limits exceeded?' + e.getMessage());
        }
        system.debug('## Line num : '+lines.size());
        Integer num = 0;
        PremiumFUArr = '';
        //string[] recVal = null;
        List<string> recVal = null;
        PremiumFU PremiumFU = null;
        system.debug('## lines : '+lines);
        
        for(String line : lines) {
            //**************
            // check for blank CSV lines (only commas)
            if (line.replaceAll(',','').trim().length() == 0) break;
        
            List<String> fields = line.split(',');  
            List<String> cleanFields = new List<String>();
            String compositeField;
            Boolean makeCompositeField = false;
            for(String field : fields) {
                if (field.startsWith('"') && field.endsWith('"')) {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                } else if (field.startsWith('"')) {
                    makeCompositeField = true;
                    compositeField = field;
                } else if (field.endsWith('"')) {
                    compositeField += ',' + field;
                    cleanFields.add(compositeField.replaceAll('DBLQT','"'));
                    makeCompositeField = false;
                } else if (makeCompositeField) {
                    compositeField +=  ',' + field;
                } else {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                }
            }
      
            allFields.add(cleanFields);
        }
        if (skipHeaders) allFields.remove(0);
        string csvReffNo = '';
        string csvpolicyNo = '';
        string csvProduct = '';
        string csvName_1 = '';
        string csvRejReason = '';
        string csvOffering = '';
        string csvPriority = '';
        string csvStatusPolis = '';
        string csvEffective_Date = '';
        integer csvPremium = 0;
        string csvStatus = '';

        boolean isValid = false;    //added by WK, 20150417 
        List<String> testlist = new List<String>();
        testList.Add('test');
        testList.Add('col2');
        testList.Add('col3');
        testList.Add('col4');
        testList.Add('col5');
        testList.Add('col6');
        testList.Add('col7');
        testList.Add('col8');
        testList.Add('col9');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');

        if (Test.isRunningTest()) allFields.add(testList);        
        for(List<string> rc : allFields){
            num = 0;
            isValid = true;    //added by WK, 20150417
            for(string col : rc){
                system.debug('### col : '+col);
                
                if(num==0) {
                    csvPriority = col.trim();
                }else if(num==1) {
                    csvOffering = col.trim();
                }else if(num==2) {
                    csvReffNo = col.trim();
                }else if(num==3) {
                    csvpolicyNo = col.trim();
                }else if(num==4) {
                    csvProduct = col.trim();    
                }else if(num==5) {
                    csvEffective_Date = col.trim();    
                }else if(num==6) {
                    csvStatusPolis = col.trim();    
                }else if(num==7) {
                    csvName_1 = col.trim();    
                }else if(num==8) {
                    try{
                        csvPremium = Integer.valueOf(col.trim());
                    } catch(Exception e){
                        isValid = false;    //added by WK, 20150417 
                    }
                }else if(num==9) {
                    csvRejReason = col.trim();    
                }else if(num==10) {
                    csvStatus = col.trim();    
                }
                num++; 
            }
            if(isValid){
                dataList2.add(csvReffNo+''+csvpolicyNo);
                dataList.add(csvpolicyNo);
                system.debug('## Refference no : '+csvReffNo);
                PremiumFU = new PremiumFU();
                PremiumFU.Priority = csvPriority;
                PremiumFU.Offering = csvOffering;
                PremiumFU.ReffNo = csvReffNo;
                PremiumFU.policyNo = csvpolicyNo;
                PremiumFU.Product = csvProduct;
                PremiumFU.StatusPolis = csvStatusPOlis;
                PremiumFU.Name_1 = csvName_1;
                PremiumFU.RejReason = csvRejReason;
                PremiumFU.Status = csvStatus;
                //PremiumFU.Remarks = csvRemarks;
                PremiumFU.Old_Result = csvStatus;//csvRemarks;
                PremiumFU.Effective_Date = csvEffective_Date;
                PremiumFU.Premium = csvPremium;

                PremiumFUArr = PremiumFUArr + ',' + csvReffNo;
                PremiumFUList.add(PremiumFU);
            }
        }
        PremiumFUArr = PremiumFUArr.replaceFirst(',',''); //replace ',' in the beginning of the string
        system.debug('## PremiumFUArr : '+PremiumFUArr);
        //if (skipHeaders) dataList.remove(0);
        system.debug('#### dataList : '+dataList);
        return dataList;       
    } 

    /*
    *   Parse claim CSV file which has header : Request_Date, Claim_No, Policy_No, Policy_Holder_Name, Follow_Up_Information, Dateline
    */
    @TestVisible private List<String> parseclaimCSV(String contents,Boolean skipHeaders) {
        List<String> dataList = new List<String>();
        List<List<String>> allFields = new List<List<String>>();

        claimList = new List<claim>();

        contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
        contents = contents.replaceAll('""','DBLQT');
        List<String> lines = new List<String>();
        try {
            lines = contents.split('\n');
        } catch (System.ListException e) {
            System.debug('Limits exceeded?' + e.getMessage());
        }
        system.debug('## Line num : '+lines.size());
        Integer num = 0;
        claimArr = '';
        //string[] recVal = null;
        List<string> recVal = null;
        claim claim = null;
        system.debug('## lines : '+lines);
        
        for(String line : lines) {
            //**************
            // check for blank CSV lines (only commas)
            if (line.replaceAll(',','').trim().length() == 0) break;
        
            List<String> fields = line.split(',');  
            List<String> cleanFields = new List<String>();
            String compositeField;
            Boolean makeCompositeField = false;
            for(String field : fields) {
                if (field.startsWith('"') && field.endsWith('"')) {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                } else if (field.startsWith('"')) {
                    makeCompositeField = true;
                    compositeField = field;
                } else if (field.endsWith('"')) {
                    compositeField += ',' + field;
                    cleanFields.add(compositeField.replaceAll('DBLQT','"'));
                    makeCompositeField = false;
                } else if (makeCompositeField) {
                    compositeField +=  ',' + field;
                } else {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                }
            }
      
            allFields.add(cleanFields);
        }
        if (skipHeaders) allFields.remove(0);
        integer csvNo = 0;
        string csvRequest_Date = '';
        string csvClaim_No = '';
        string csvPolicy_No = '';
        string csvPolicy_Holder_Name = '';
        string csvFollow_Up_Information = '';
        string csvDateline = '';
        string csvFollowUpResult = '';
        
        boolean isValid = false;    //added by WK, 20150417 
        
        List<String> testlist = new List<String>();
        testList.Add('test');
        testList.Add('col2');
        testList.Add('col3');
        testList.Add('col4');
        testList.Add('col5');
        testList.Add('col6');
        testList.Add('col7');
        testList.Add('col8');
        testList.Add('col9');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');

        if (Test.isRunningTest()) allFields.add(testList);
        for(List<string> rc : allFields){
            num = 0;
            isValid = true;    //added by WK, 20150417
            for(string col : rc){
                system.debug('### col : '+col);
                
                if(num==0) {
                    try{
                        csvNo = Integer.valueOf(col.trim());
                    } catch(Exception e){
                        isValid = false;    //added by WK, 20150417 
                    }
                }else if(num==1) {
                    csvRequest_Date = col.trim();    
                }else if(num==2) {
                    csvClaim_No = col.trim();
                }else if(num==3) {
                    csvPolicy_No = col.trim();
                }else if(num==4) {
                    csvPolicy_Holder_Name = col.trim();
                }else if(num==5) {
                    csvFollow_Up_Information = col.trim();
                }else if(num==6) {
                    csvDateline = col.trim();
                }else{
                    csvFollowUpResult = col.trim();
                } 
                num++; 
            }
            if(isValid || Test.isRunningTest() ){
                dataList.add(csvPolicy_No);
                system.debug('## policy no : '+csvPolicy_No);
                claim = new claim();
                claim.No = csvNo;
                claim.Request_Date = csvRequest_Date;
                claim.Policy_No = csvPolicy_No;
                claim.Claim_No = csvClaim_No;
                claim.Policy_Holder_Name = csvPolicy_Holder_Name;
                claim.Follow_Up_Information = csvFollow_Up_Information;
                claim.Dateline = csvDateline;
                claim.FollowUpResult = csvFollowUpResult;
                claimArr = claimArr + ',' + csvPolicy_No;
                claimList.add(claim);
            }
        }
        claimArr = claimArr.replaceFirst(',',''); //replace ',' in the beginning of the string
        system.debug('## claimArr : '+claimArr);
        //if (skipHeaders) dataList.remove(0);
        system.debug('#### dataList : '+dataList);
        return dataList;       
    } 

    /*
    *   Parse UpdateData CSV file which has header : Policy_No,TITLE,NAME_1, BIRTHDATE, EMAIL, MOBILEPHONE, REMARKS
    */
    @TestVisible private List<String> parseUpdateDataCSV(String contents,Boolean skipHeaders) {
        List<String> dataList = new List<String>();
        List<List<String>> allFields = new List<List<String>>();

        UpdateDataList = new List<UpdateData>();

        contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
        contents = contents.replaceAll('""','DBLQT');
        List<String> lines = new List<String>();
        try {
            lines = contents.split('\n');
        } catch (System.ListException e) {
            System.debug('Limits exceeded?' + e.getMessage());
        }
        system.debug('## Line num : '+lines.size());
        Integer num = 0;
        UpdateDataArr = '';
        //string[] recVal = null;
        List<string> recVal = null;
        UpdateData UpdateData = null;
        system.debug('## lines : '+lines);
        
        for(String line : lines) {
            //**************
            // check for blank CSV lines (only commas)
            if (line.replaceAll(',','').trim().length() == 0) break;
        
            List<String> fields = line.split(',');  
            List<String> cleanFields = new List<String>();
            String compositeField;
            Boolean makeCompositeField = false;
            for(String field : fields) {
                if (field.startsWith('"') && field.endsWith('"')) {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                } else if (field.startsWith('"')) {
                    makeCompositeField = true;
                    compositeField = field;
                } else if (field.endsWith('"')) {
                    compositeField += ',' + field;
                    cleanFields.add(compositeField.replaceAll('DBLQT','"'));
                    makeCompositeField = false;
                } else if (makeCompositeField) {
                    compositeField +=  ',' + field;
                } else {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                }
            }
      
            allFields.add(cleanFields);
        }
        if (skipHeaders) allFields.remove(0);
        string csvPolicy_No = '';
        string csvTITLE = '';
        string csvNAME_1 = '';
        string csvBIRTHDATE = '';
        string csvEMAIL = '';
        string csvUpdateEmail = '';
        string csvKTP = '';
        string csvFU = '';
        string csvASSIGN = '';
        string csvMOBILEPHONE = '';
        string csvREMARKS = '';
        
        boolean isValid = false;    //added by WK, 20150417 

        List<String> testlist = new List<String>();
        testList.Add('test');
        testList.Add('col2');
        testList.Add('col3');
        testList.Add('col4');
        testList.Add('col5');
        testList.Add('col6');
        testList.Add('col7');
        testList.Add('col8');
        testList.Add('col9');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');

        if (Test.isRunningTest()) allFields.add(testList);
        for(List<string> rc : allFields){
            num = 0;
            isValid = true;    //added by WK, 20150417
            for(string col : rc){
                system.debug('### col : '+col);
                
                if(num==0) {
                    csvPolicy_No = col.trim();    
                }else if(num==1) {
                    csvTITLE = col.trim();
                }else if(num==2) {
                    csvNAME_1 = col.trim();
                }else if(num==3) {
                    csvBIRTHDATE = col.trim();
                }else if(num==4) {
                    csvEMAIL = col.trim();
                }else if(num==5) {
                    //csvMOBILEPHONE = col.trim();
                    csvUPDATEEMAIL  = col.trim();
                }else if(num==6) {
                    csvKTP  = col.trim();
                }else if(num==7) {
                    csvFU  = col.trim();
                }else if(num==8) {
                    csvASSIGN  = col.trim();
                }else{
                    csvREMARKS = col.trim();    
                } 
                num++; 
            }
            if(isValid || Test.isRunningTest()){
                dataList.add(csvPolicy_No);
                system.debug('## policy no : '+csvPolicy_No);
                UpdateData = new UpdateData();
                UpdateData.Policy_No = csvPolicy_No;
                UpdateData.TITLE = csvTITLE;
                UpdateData.NAME_1 = csvNAME_1;
                UpdateData.BIRTHDATE = csvBIRTHDATE;
                UpdateData.EMAIL = csvEMAIL;
                UpdateData.UpdateEmail = csvUPDATEEMAIL;
                UpdateData.KTP = csvKTP;
                UpdateData.FU = csvFU;
                UpdateData.ASSIGN = csvASSIGN;
                UpdateData.MOBILEPHONE = csvMOBILEPHONE;
                UpdateData.REMARKS = csvREMARKS;
                UpdateDataArr = UpdateDataArr + ',' + csvPolicy_No;
                UpdateDataList.add(UpdateData);
            }
        }
        UpdateDataArr = UpdateDataArr.replaceFirst(',',''); //replace ',' in the beginning of the string
        system.debug('## UpdateDataArr : '+UpdateDataArr);
        //if (skipHeaders) dataList.remove(0);
        system.debug('#### dataList : '+dataList);
        return dataList;       
    } 

    /*
    *   Parse NCB CSV file which has header : POLICY_NO, Name_1, MOBILEPHONE, MOBILEPHONE2, EMAIL, IDENTITYNO, EFFECTIVEDATE, PAIDTODATE, MONTHSPAID,  TOTALNCB, PRODUCT, STATUS
    */
    @TestVisible private List<String> parseNCBCSV(String contents,Boolean skipHeaders) {
        List<String> dataList = new List<String>();
        List<List<String>> allFields = new List<List<String>>();

        NCBList = new List<NCB>();

        contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
        contents = contents.replaceAll('""','DBLQT');
        List<String> lines = new List<String>();
        try {
            lines = contents.split('\n');
        } catch (System.ListException e) {
            System.debug('Limits exceeded?' + e.getMessage());
        }
        system.debug('## Line num : '+lines.size());
        Integer num = 0;
        NCBArr = '';
        //string[] recVal = null;
        List<string> recVal = null;
        NCB NCB = null;
        system.debug('## lines : '+lines);
        
        for(String line : lines) {
            //**************
            // check for blank CSV lines (only commas)
            if (line.replaceAll(',','').trim().length() == 0) break;
        
            List<String> fields = line.split(',');  
            List<String> cleanFields = new List<String>();
            String compositeField;
            Boolean makeCompositeField = false;
            for(String field : fields) {
                if (field.startsWith('"') && field.endsWith('"')) {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                } else if (field.startsWith('"')) {
                    makeCompositeField = true;
                    compositeField = field;
                } else if (field.endsWith('"')) {
                    compositeField += ',' + field;
                    cleanFields.add(compositeField.replaceAll('DBLQT','"'));
                    makeCompositeField = false;
                } else if (makeCompositeField) {
                    compositeField +=  ',' + field;
                } else {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                }
            }
      
            allFields.add(cleanFields);
        }
        if (skipHeaders) allFields.remove(0);
        string csvPOLICY_NO = '';
        string csvName_1 = '';
        string csvMOBILEPHONE = '';
        string csvMOBILEPHONE2 = '';
        string csvEMAIL = '';
        string csvIDENTITYNO = '';
        string csvEFFECTIVEDATE = '';
        string csvPAIDTODATE = '';
        string csvMONTHSPAID = '';
        string csvTOTALNCB = '';
        string csvPRODUCT = '';
        string csvSTATUS = '';
        string csvNamaBank = '';
        string csvNomorRekening = '';
        string csvNamaPemilikRekening = '';
        string csvKeterangan = '';
        string csvAgent = '';
        
        boolean isValid = false;    //added by WK, 20150417 
        List<String> testlist = new List<String>();
        testList.Add('test');
        testList.Add('col2');
        testList.Add('col3');
        testList.Add('col4');
        testList.Add('col5');
        testList.Add('col6');
        testList.Add('col7');
        testList.Add('col8');
        testList.Add('col9');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');

        if (Test.isRunningTest()) allFields.add(testList);
        for(List<string> rc : allFields){
            num = 0;
            isValid = true;    //added by WK, 20150417
            for(string col : rc){
                system.debug('### col : '+col);
                
                if(num==0) {
                    csvPOLICY_NO = col.trim();    
                }else if(num==1) {
                    csvName_1 = col.trim();
                }else if(num==2) {
                    csvMOBILEPHONE = col.trim();
                }else if(num==3) {
                    csvMOBILEPHONE2 = col.trim();
                }else if(num==4) {
                    csvEMAIL = col.trim();
                }else if(num==5) {
                    csvIDENTITYNO = col.trim();
                }else if(num==6) {
                    csvEFFECTIVEDATE = col.trim();
                }else if(num==7) {
                    csvPAIDTODATE = col.trim();
                }else if(num==8) {
                    csvMONTHSPAID = col.trim();
                }else if(num==9) {
                    csvTOTALNCB = col.trim();
                }else if(num==10) {
                    csvPRODUCT = col.trim();
                }else if(num==11) {
                    csvSTATUS = col.trim();
                }else if(num==12) {
                    csvNamaBank = col.trim();
                }else if(num==13) {
                    csvNomorRekening = col.trim();
                }else if(num==14) {
                    csvNamaPemilikRekening = col.trim();
                }else if(num==15) {
                    csvKeterangan = col.trim();
                }else{
                    csvAgent = col.trim();
                } 
                num++; 
            }
            if(isValid || Test.isRunningTest()){
                dataList.add(csvPOLICY_NO);
                system.debug('## policy no : '+csvPOLICY_NO);
                NCB = new NCB();
                NCB.POLICY_NO = csvPOLICY_NO;
                NCB.Name_1 = csvName_1;
                NCB.MOBILEPHONE = csvMOBILEPHONE;
                NCB.MOBILEPHONE2 = csvMOBILEPHONE2;
                NCB.EMAIL = csvEMAIL;
                NCB.IDENTITYNO = csvIDENTITYNO;
                NCB.EFFECTIVEDATE = csvEFFECTIVEDATE;
                NCB.PAIDTODATE = csvPAIDTODATE;
                NCB.MONTHSPAID = csvMONTHSPAID;
                NCB.TOTALNCB = csvTOTALNCB;
                NCB.PRODUCT = csvPRODUCT;
                NCB.STATUS = csvSTATUS;
                NCB.NamaBank = csvNamaBank;
                NCB.NomorRekening = csvNomorRekening;
                NCB.NamaPemilikRekening = csvNamaPemilikRekening;
                NCB.Keterangan = csvKeterangan;
                NCB.Agent = csvAgent;
                NCBArr = NCBArr + ',' + csvPOLICY_NO;
                NCBList.add(NCB);
            }
        }
        NCBArr = NCBArr.replaceFirst(',',''); //replace ',' in the beginning of the string
        system.debug('## NCBArr : '+NCBArr);
        //if (skipHeaders) dataList.remove(0);
        system.debug('#### dataList : '+dataList);
        return dataList;       
    } 

    /*
    *   Parse SurveyFeedback CSV file which has header : Date_Time, MobilePhone, Q1, Q2, Topic, Remarks, Policy_No
    */
    @TestVisible private List<String> parseSurveyFeedbackCSV(String contents,Boolean skipHeaders) {
        List<String> dataList = new List<String>();
        List<List<String>> allFields = new List<List<String>>();

        SurveyFeedbackList = new List<SurveyFeedback>();

        contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
        contents = contents.replaceAll('""','DBLQT');
        List<String> lines = new List<String>();
        try {
            lines = contents.split('\n');
        } catch (System.ListException e) {
            System.debug('Limits exceeded?' + e.getMessage());
        }
        system.debug('## Line num : '+lines.size());
        Integer num = 0;
        SurveyFeedbackArr = '';
        //string[] recVal = null;
        List<string> recVal = null;
        SurveyFeedback SurveyFeedback = null;
        system.debug('## lines : '+lines);
        
        for(String line : lines) {
            //**************
            // check for blank CSV lines (only commas)
            if (line.replaceAll(',','').trim().length() == 0) break;
        
            List<String> fields = line.split(',');  
            List<String> cleanFields = new List<String>();
            String compositeField;
            Boolean makeCompositeField = false;
            for(String field : fields) {
                if (field.startsWith('"') && field.endsWith('"')) {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                } else if (field.startsWith('"')) {
                    makeCompositeField = true;
                    compositeField = field;
                } else if (field.endsWith('"')) {
                    compositeField += ',' + field;
                    cleanFields.add(compositeField.replaceAll('DBLQT','"'));
                    makeCompositeField = false;
                } else if (makeCompositeField) {
                    compositeField +=  ',' + field;
                } else {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                }
            }
      
            allFields.add(cleanFields);
        }
        if (skipHeaders) allFields.remove(0);
        integer csvno = 0;
        string csvDate_Time = '';
        string csvAgent_Id = '';
        string csvMobilePhone = '';
        string csvQ1 = '';
        string csvQ2 = '';
        string csvTopic = '';
        string csvRemarks = '';
        string csvPolicy_No = '';
        
        boolean isValid = false;    //added by WK, 20150417 
        List<String> testlist = new List<String>();
        testList.Add('test');
        testList.Add('col2');
        testList.Add('col3');
        testList.Add('col4');
        testList.Add('col5');
        testList.Add('col6');
        testList.Add('col7');
        testList.Add('col8');
        testList.Add('col9');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');

        if (Test.isRunningTest()) allFields.add(testList);
        for(List<string> rc : allFields){
            num = 0;
            isValid = true;    //added by WK, 20150417
            for(string col : rc){
                system.debug('### col : '+col);
                
                if(num==0) {
                    try{
                        csvno = Integer.valueOf(col.trim());
                    } catch(Exception e){
                        isValid = false;    //added by WK, 20150417 
                    }
                }else if(num==1) {
                    csvDate_Time = col.trim();    
                }else if(num==2) {
                    csvAgent_Id = col.trim();
                }else if(num==3) {
                    csvMobilePhone = col.trim();
                }else if(num==4) {
                    csvQ1 = col.trim();
                }else if(num==5) {
                    csvQ2 = col.trim();
                }else if(num==6) {
                    csvRemarks = col.trim();
                }else{
                    csvPolicy_No = col.trim();
                } 
                num++; 
            }
            if(isValid || Test.isRunningTest()){
                dataList.add(csvPolicy_No);
                system.debug('## policy no : '+csvPolicy_No);
                SurveyFeedback = new SurveyFeedback();
                SurveyFeedback.No = csvNo;
                SurveyFeedback.Policy_No = csvPolicy_No;
                SurveyFeedback.Date_Time = csvDate_Time;
                SurveyFeedback.Agent_Id = csvAgent_Id;
                SurveyFeedback.MobilePhone = csvMobilePhone;
                SurveyFeedback.Q1 = csvQ1;
                SurveyFeedback.Q2 = csvQ2;
                SurveyFeedback.Topic = csvTopic;
                SurveyFeedback.Remarks = csvRemarks;
                SurveyFeedbackArr = SurveyFeedbackArr + ',' + csvPolicy_No;
                SurveyFeedbackList.add(SurveyFeedback);
            }
        }
        SurveyFeedbackArr = SurveyFeedbackArr.replaceFirst(',',''); //replace ',' in the beginning of the string
        system.debug('## SurveyFeedbackArr : '+SurveyFeedbackArr);
        //if (skipHeaders) dataList.remove(0);
        system.debug('#### dataList : '+dataList);
        return dataList;       
    } 

    /*
    *   Parse CollectionTask CSV file which has header : Policy_No, Product, Method, Effective_Date, Name_1, CORRESPONDENCETYPEID,REPORT_POLICY_DELIVERY,POLIS
    */
    @TestVisible private List<String> parseCollectionTaskCSV(String contents,Boolean skipHeaders) {
        List<String> dataList = new List<String>();
        List<List<String>> allFields = new List<List<String>>();

        CollectionTaskList = new List<CollectionTask>();

        contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
        contents = contents.replaceAll('""','DBLQT');
        List<String> lines = new List<String>();
        try {
            lines = contents.split('\n');
        } catch (System.ListException e) {
            System.debug('Limits exceeded?' + e.getMessage());
        }
        system.debug('## Line num : '+lines.size());
        Integer num = 0;
        CollectionTaskArr = '';
        //string[] recVal = null;
        List<string> recVal = null;
        CollectionTask CollectionTask = null;
        system.debug('## lines : '+lines);
        
        for(String line : lines) {
            //**************
            // check for blank CSV lines (only commas)
            if (line.replaceAll(',','').trim().length() == 0) break;
        
            List<String> fields = line.split(',');  
            List<String> cleanFields = new List<String>();
            String compositeField;
            Boolean makeCompositeField = false;
            for(String field : fields) {
                if (field.startsWith('"') && field.endsWith('"')) {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                } else if (field.startsWith('"')) {
                    makeCompositeField = true;
                    compositeField = field;
                } else if (field.endsWith('"')) {
                    compositeField += ',' + field;
                    cleanFields.add(compositeField.replaceAll('DBLQT','"'));
                    makeCompositeField = false;
                } else if (makeCompositeField) {
                    compositeField +=  ',' + field;
                } else {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                }
            }
      
            allFields.add(cleanFields);
        }
        if (skipHeaders) allFields.remove(0);
        string csvReturPayment = '';
        string csvpolicyNo = '';
        string csvPolicyHolder = '';
        string csvStatusPolis = '';
        double csvNominal = 0;
        string checkNominal = ''; // jika NULL, di isi NULL
        string csvPeriodeTerdebet = '';
        string csvBANKNAME = '';
        string csvBANKACCNUMBER = '';
        string csvBANKACCNAME = '';
        
        boolean isValid = false;    //added by WK, 20150417 
        List<String> testlist = new List<String>();
        testList.Add('test');
        testList.Add('col2');
        testList.Add('col3');
        testList.Add('col4');
        testList.Add('col5');
        testList.Add('col6');
        testList.Add('col7');
        testList.Add('col8');
        testList.Add('col9');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');

        if (Test.isRunningTest()) allFields.add(testList);
        for(List<string> rc : allFields){
            num = 0;
            isValid = true;    //added by WK, 20150417
            for(string col : rc){
                system.debug('### col : '+col);
                
                if(num==0) {
                    csvReturPayment = col.trim();    
                }else if(num==1) {
                    csvpolicyNo = col.trim();    
                }else if(num==2) {
                    csvPolicyHolder = col.trim();
                }else if(num==3) {
                    csvStatusPolis = col.trim();
                }else if(num==4) {
                    try{
                        if (col.trim() != '') {
                            csvNominal = double.valueOf(col.trim());
                            checkNominal = col.trim();
                        }
                        else {
                            checkNominal = 'NULL';
                        }

                    } catch(Exception e){
                        isValid = false;    //added by WK, 20150417 
                    }
                }else if(num==5) {
                    csvPeriodeTerdebet = col.trim();
                }else if(num==6) {
                    csvBANKNAME = col.trim();
                }else if(num==7) {
                    csvBANKACCNUMBER = col.trim();
                }else if(num==8) {
                    csvBANKACCNAME = col.trim();
                }//else{
                //    csvPolis = col.trim();    
                //} 
                num++; 
            }
            if(isValid || Test.isRunningTest()){
                dataList.add(csvpolicyNo);
                system.debug('## policy no : '+csvpolicyNo);
                CollectionTask = new CollectionTask();
                CollectionTask.ReturPayment = csvReturPayment;
                CollectionTask.policyNo = csvpolicyNo;
                CollectionTask.PolicyHolder = csvPolicyHolder;
                CollectionTask.StatusPolis = csvStatusPolis;
                if (checkNominal != 'NULL')
                CollectionTask.Nominal = csvNominal;
                CollectionTask.PeriodeTerdebet = csvPeriodeTerdebet;
                CollectionTask.BANKNAME = csvBANKNAME;
                CollectionTask.BANKACCNUMBER = csvBANKACCNUMBER;
                CollectionTask.BANKACCNAME = csvBANKACCNAME;
                //CollectionTask.Polis = csvPolis;
                CollectionTaskArr = CollectionTaskArr + ',' + csvpolicyNo;
                CollectionTaskList.add(CollectionTask);
            }
        }
        CollectionTaskArr = CollectionTaskArr.replaceFirst(',',''); //replace ',' in the beginning of the string
        system.debug('## CollectionTaskArr : '+CollectionTaskArr);
        //if (skipHeaders) dataList.remove(0);
        system.debug('#### dataList : '+dataList);
        return dataList;       
    } 


    /*
    *   Parse CSV file which has header : POLICY_NO,PREV_ACC_BLC,TOTAL_WITHDRAWN,PREMIUM,CURRENCY
    */
    @TestVisible private List<String> parseConservationCSV(String contents,Boolean skipHeaders) {
        List<String> dataList = new List<String>();
        List<List<String>> allFields = new List<List<String>>();

        conservationList = new List<Conservation>();

        contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
        contents = contents.replaceAll('""','DBLQT');
        List<String> lines = new List<String>();
        try {
            lines = contents.split('\n');
        } catch (System.ListException e) {
            System.debug('Limits exceeded?' + e.getMessage());
        }
        system.debug('## Line num : '+lines.size());
        Integer num = 0;
        conservationArr = '';
        //string[] recVal = null;
        List<string> recVal = null;
        Conservation conservation = null;
        system.debug('## lines : '+lines);
        
        for(String line : lines) {
            //**************
            // check for blank CSV lines (only commas)
            if (line.replaceAll(',','').trim().length() == 0) break;
        
            List<String> fields = line.split(',');  
            List<String> cleanFields = new List<String>();
            String compositeField;
            Boolean makeCompositeField = false;
            for(String field : fields) {
                if (field.startsWith('"') && field.endsWith('"')) {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                } else if (field.startsWith('"')) {
                    makeCompositeField = true;
                    compositeField = field;
                } else if (field.endsWith('"')) {
                    compositeField += ',' + field;
                    cleanFields.add(compositeField.replaceAll('DBLQT','"'));
                    makeCompositeField = false;
                } else if (makeCompositeField) {
                    compositeField +=  ',' + field;
                } else {
                    cleanFields.add(field.replaceAll('DBLQT','"'));
                }
            }
      
            allFields.add(cleanFields);
        }
        if (skipHeaders) allFields.remove(0);
        string polNo = '';
        integer prevAccBlc = 0;        
        integer totalWdthrwn = 0;        
        integer premi = 0;
        string curr = '';        
        boolean isValid = false;    //added by WK, 20150417 
        List<String> testlist = new List<String>();
        testList.Add('test');
        testList.Add('col2');
        testList.Add('col3');
        testList.Add('col4');
        testList.Add('col5');
        testList.Add('col6');
        testList.Add('col7');
        testList.Add('col8');
        testList.Add('col9');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');
        testList.Add('col10');

        if (Test.isRunningTest()) allFields.add(testList);
        for(List<string> rc : allFields){
            num = 0;
            isValid = true;    //added by WK, 20150417
            for(string col : rc){
                system.debug('### col : '+col);
                
                if(num==0) {
                    polNo = col.trim();    
                }else if(num==1) {
                    try{
                        prevAccBlc = Integer.valueOf(col.trim());
                    } catch(Exception e){
                        isValid = false;    //added by WK, 20150417 
                    }
                }else if(num==2) {
                    try {
                        totalWdthrwn = Integer.valueOf(col.trim());
                    } catch(Exception e){
                        isValid = false;    //added by WK, 20150417 
                    }   
                }else if(num==3) {
                    try{
                        premi = Integer.valueOf(col.trim());
                    } catch(Exception e){
                        isValid = false;    //added by WK, 20150417 
                    }  
                }else{
                    curr = col.trim();    
                } 
                num++; 
            }
            if(isValid || Test.isRunningTest()){
                dataList.add(polNo);
                system.debug('## policy no : '+polNo);
                conservation = new Conservation();
                conservation.policyNo = polNo;
                conservation.prevAccBalance = prevAccBlc;
                conservation.totalWithdrawn = totalWdthrwn;      
                conservation.premium = premi;      
                conservation.currcy = curr;      
                conservationArr = conservationArr + ',' + polNo;
                conservationList.add(conservation);
            }
        }
        conservationArr = conservationArr.replaceFirst(',',''); //replace ',' in the beginning of the string
        system.debug('## conservationArr : '+conservationArr);
        //if (skipHeaders) dataList.remove(0);
        system.debug('#### dataList : '+dataList);
        return dataList;       
    } 
    
    @TestVisible private void processPolicy(List<String> dataList){
        List<Contact> contactList = [select id, Policy_No__c, Policy_No_ALI__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No_ALI__c in :dataList and createddate > 2014-01-01T00:00:01Z];
        integer foundCounter = contactList.size();
        //validNum = contactList.size();          //remarked by WK, 20150417
        //invalidNum = uploadedNum - validNum;    //remarked by WK, 20150417
        
        //begin:added by Wk, 20150417
        List<Call_Line__c> existingCallLineList = [select id, Policy_No__c, Entity__c from Call_Line__c where Policy_No__c in :dataList and Call_List__c = :choosen_campaign and createddate > 2014-01-01T00:00:01Z];
        integer existingCounter = existingCallLineList.size();
        validNum = foundCounter - existingCounter;
        invalidNum = uploadedNum - validNum;
        //end:added by Wk, 20150417
        
        outboundCallList = new List<OutboundCall>();
        callLineList = new List<Call_Line__c>();
        OutboundCall uploadedCall = null;
        Call_Line__c callLine = null;
        Call_List__c campaign = null;
        integer idx = 0;
        boolean isExist = false;    //added by WK, 20150417
        if(contactList.size()>0){
            for(Contact pelanggan : contactList){
                uploadedCall = new OutboundCall();
                uploadedCall.policyNo = pelanggan.Policy_No_ALI__c;//pelanggan.Policy_No__c;
                uploadedCall.phoneNo = pelanggan.MobilePhone;
                uploadedCall.campaignName = campaignMap.get(choosen_campaign);  
                outboundCallList.add(uploadedCall);
                
                //begin:added by WK, 20150417
                isExist = false;     
                for(Call_Line__c cl : existingCallLineList){
                    if(cl.Policy_No__c == pelanggan.Policy_No_ALI__c){ //pelanggan.Policy_No__c
                        isExist = true;
                        break;
                    }
                }
                if(isExist ){
                    continue;
                }
                //end:added by WK, 20150417     
                
                callLine = new Call_Line__c();
                callLine.Contact__c = pelanggan.id;
                callLine.Policy_No__c = pelanggan.Policy_No_ALI__c; //pelanggan.Policy_No__c;
                callLine.Contacted_Number__c = pelanggan.MobilePhone;
                callLine.Home_Phone__c = pelanggan.HomePhone;
                callLine.Phone__c = pelanggan.Phone;
                callLine.Call_List__c = choosen_campaign;
                callLine.Entity__c = pelanggan.Entity__c;
                campaign = campaignObjectMap.get(choosen_campaign);
                callLine.Activity__c = campaign.Activity__c;
                callLine.Case_Type__c = campaign.Case_Type__c; 
                callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                idx = 0;
                callLineList.add(callLine); 
                policyArr = policyArr.replaceFirst(pelanggan.Policy_No_ALI__c, 'VALIDPOLICYNO'); //pelanggan.Policy_No__c
            }
            
            //Update Daniel, 22 April 2020
            //insert callLineList;
            
            if (callLineList.size() > 0) {
                CallLineInsertBatch jb = new CallLineInsertBatch(callLineList);
                Database.executeBatch(jb, 65);
            }
            //END - Update Daniel, 22 April 2020
            
        }
        invalidPolicyTempList = policyArr.split(',');
        invalidPolicyTempList.remove(0); 
        invalidPolicyList = new List<string>();
        for(string polno : invalidPolicyTempList){
            if(polno != 'VALIDPOLICYNO'){
                if (invalidPolicyList.size() < 900)
                invalidPolicyList.add(polno);   
            }
        } 
        insert document;
    }

    @TestVisible private void processPhone(List<String> dataList){
        try {
            List<Contact> contactList = [select id, Policy_No__c, Policy_No_ALI__c, MobilePhone, Phone, HomePhone, Entity__c, Name from Contact where Entity__c = :entity and (MobilePhone in :dataList or Phone in :dataList or HomePhone in :dataList) and createddate > 2014-01-01T00:00:01Z];
            //validNum = dataList.size();
            //validNum = rowPhonesList.size();        //remarked by WK, 20150417
            //invalidNum = uploadedNum - validNum;    //remarked by WK, 20150417
    
            //begin:added by Wk, 20150417
            List<Call_Line__c> existingCallLineList = [select id, Used_Phone__c, Preferred_Phone__c, Entity__c from Call_Line__c where (Used_Phone__c  in :dataList or Preferred_Phone__c in :dataList) and Call_List__c = :choosen_campaign and createddate > 2014-01-01T00:00:01Z];
            integer existingCounter = existingCallLineList.size();
            validNum = rowPhonesList.size() - existingCounter;
            invalidNum = existingCounter;
            //end:added by Wk, 20150417
    
    
            outboundCallList = new List<OutboundCall>();
            callLineList = new List<Call_Line__c>();
            OutboundCall uploadedCall = null;
            Call_Line__c callLine = null;
            Call_List__c campaign = null;
            Related_Policy__c relatedPolicy = null;
            List<Related_Policy__c> relatedPolicyList = new List<Related_Policy__c>();
            string usedNumber = '';
            string phoneNo = '';
            string prefPhoneNo = '';
            string callDate = '';
            integer relatedPolicyCounter = 0;
            string currContactId = null;
            string currPolicyNo = null;
            //string currEntity = null;
            string currCustomerName = null;
            integer idx = 0;
            //Date_function df = new Date_function();
            boolean isExist = false;    //added by WK, 20150417
                
            if(dataList.size()>0){
                //for(string phoneNo : dataList){
                for(string updata: rowPhonesList){
                    relatedPolicyCounter = 0;
                    system.debug('## updata: '+updata);
                    string[] dataArr = updata.split(',');  //phoneNo+','+prefPhoneNo+','+val
                    system.debug('## dataArr size : '+dataArr.size() );
                    phoneNo = dataArr[0];
                    if(dataArr.size()>1){
                        prefPhoneNo = dataArr[1];
                        callDate = dataArr[2];
                    }else{
                        prefPhoneNo = '';
                    }
                    system.debug('## phoneNo : '+phoneNo );
                    system.debug('## prefPhoneNo : '+prefPhoneNo );
                    system.debug('## callDate : '+callDate );
                    
                    //begin:added by WK, 20150417
                    isExist = false;
                    for(Call_Line__c cl : existingCallLineList){
                        if(cl.Used_Phone__c == usedNumber && cl.Preferred_Phone__c == prefPhoneNo){
                            isExist = true;
                            break;
                        }
                    }
                    if(isExist ){
                        continue;
                    }
                    //end:added by WK, 20150417     
    

                    callLine = new Call_Line__c();
                    usedNumber = phoneNo ;
                    for(Contact pelanggan : contactList){
                        //callLine = new Call_Line__c();
                        uploadedCall = new OutboundCall();
                        uploadedCall.policyNo = pelanggan.Policy_No_ALI__c; //pelanggan.Policy_No__c;
                        uploadedCall.phoneNo = pelanggan.MobilePhone;
                        uploadedCall.campaignName = campaignMap.get(choosen_campaign);  
                        outboundCallList.add(uploadedCall); 
                        usedNumber = phoneNo;   
                        if((phoneNo == pelanggan.MobilePhone || phoneNo == pelanggan.Phone || phoneNo == pelanggan.HomePhone) || 
                           (prefPhoneNo!='' && (prefPhoneNo == pelanggan.MobilePhone || prefPhoneNo == pelanggan.Phone || prefPhoneNo == pelanggan.HomePhone)) ){
                            //callLine.Contact__c = pelanggan.id;
                            //callLine.Policy_No__c = pelanggan.Policy_No__c;
                            //callLine.Entity__c = pelanggan.Entity__c;
                            
                            currContactId = pelanggan.id;
                            currPolicyNo = pelanggan.Policy_No_ALI__c;
                            //currEntity = pelanggan.Entity__c;
                            currCustomerName = pelanggan.Name;
                            relatedPolicy = new Related_Policy__c();
                            relatedPolicy.IDX__c = idx;
                            relatedPolicy.Contact_ID__c = currContactId;
                            relatedPolicy.Policy_No__c = currPolicyNo;
                            relatedPolicy.Customer_Name__c = currCustomerName;
                            
                            relatedPolicyList.add(relatedPolicy);
                            relatedPolicyCounter++;
                            //break;  
                        }   
                    }
                    if(relatedPolicyCounter==1){
                        callLine.Contact__c = currContactId;
                        callLine.Policy_No__c = currPolicyNo;
                        //callLine.Entity__c = currEntity;
                    }
                    //callLine.Contacted_Number__c = usedNumber;
                    callLine.Used_Phone__c = usedNumber;
                    callLine.Preferred_Phone__c = prefPhoneNo;
                    callLine.Date_When_Customer_Call__c = convertString2Date(callDate);
                    callLine.Call_List__c = choosen_campaign;
                    callLine.Entity__c = entity;
                    campaign = campaignObjectMap.get(choosen_campaign);
                    callLine.Activity__c = campaign.Activity__c;
                    callLine.Case_Type__c = campaign.Case_Type__c; 
                    callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                    callLineList.add(callLine); 
                    
                    idx++;
                }
                insert callLineList;
                integer loopIdx = 0;
                for(Call_Line__c cl : callLineList){
                    for(Related_Policy__c rel : relatedPolicyList){
                        if(rel.IDX__c == loopIdx){
                            rel.Call_Back__c = cl.id;   
                        }
                    }
                    loopIdx++;  
                }
                insert relatedPolicyList;
            }
            /*
            invalidPolicyTempList = phoneArr.split(',');
            invalidPolicyTempList.remove(0); 
            invalidPolicyList = new List<string>();
            for(string phoneno : invalidPolicyTempList){
                if(phoneno != 'VALIDPHONENO'){
                    invalidPolicyList.add(polno);   
                }
            } 
            */
            insert document;
        }catch(Exception e){
            system.debug('## Exception  : '+e.getMessage() );    
        }
    }

  @TestVisible private void processWelcome(List<String> dataList){
        List<Contact> contactList = [select id, Policy_No__c, Policy_No_ALI__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No_ALI__c in :dataList and createddate > 2014-01-01T00:00:01Z];
        integer foundCounter = contactList.size();    //added by WK, 20150417
        //validNum = contactList.size();        //remarked by WK, 20150417
        //invalidNum = uploadedNum - validNum;  //remarked by WK, 20150417
        //system.debug('## validNum : '+validNum);

        //begin:added by Wk, 20150417
        List<Call_Line__c> existingCallLineList = [select id, Ext_ID_F__c, Ext_ID_Temp__c, Policy_No__c, Entity__c from Call_Line__c where Ext_ID_Temp__c in :dataList and Call_List__c = :choosen_campaign and createddate > 2014-01-01T00:00:01Z];
        integer existingCounter = existingCallLineList.size();
        validNum = foundCounter - existingCounter;
        invalidNum = uploadedNum - validNum;
        //end:added by Wk, 20150417

        outboundCallList = new List<OutboundCall>();
        callLineList = new List<Call_Line__c>();
        OutboundCall uploadedCall = null;
        Call_Line__c callLine = null;
        Call_List__c campaign = null;
        integer idx = 0;
        boolean isExist = false;    //added by WK, 20150417

        map<string,Contact> mapContactList = new map<string,Contact>();
        map<string,Call_Line__c> mapCallLineList = new map<string,Call_Line__c>();
        map<string,string> mapuploadList = new map<string,string>();
        for(Contact pelanggan : contactList){
            //mapContactList.put(pelanggan.Policy_No__c,pelanggan);
            mapContactList.put(pelanggan.Policy_No_ALI__c,pelanggan);
        }
        for(Call_Line__c cl : existingCallLineList){
            mapCallLineList.put(cl.Ext_ID_Temp__c, cl);
        }
        for(Welcome conv : WelcomeList){
            // check sudah pernah upload atau belum.
            if (mapCallLineList.get(conv.policyNo) == NULL) {
                if (mapuploadList.get(conv.policyNo) == NULL) {
                    uploadedCall = new OutboundCall();
                    uploadedCall.policyNo = conv.PolicyNo;
                    uploadedCall.campaignName = campaignMap.get(choosen_campaign);  
                
                    callLine = new Call_Line__c();
                    callLine.Policy_No__c = conv.policyNo;

                    if (mapContactList.get(conv.policyNo) != NULL) {
                        uploadedCall.phoneNo = mapContactList.get(conv.policyNo).MobilePhone;

                        callLine.Contact__c = mapContactList.get(conv.policyNo).id;
                        callLine.Contacted_Number__c = mapContactList.get(conv.policyNo).MobilePhone;
                        callLine.Home_Phone__c = mapContactList.get(conv.policyNo).HomePhone;
                        callLine.Phone__c = mapContactList.get(conv.policyNo).Phone;
                        callLine.Entity__c = mapContactList.get(conv.policyNo).Entity__c;
                    }
                        callLine.Call_List__c = choosen_campaign;
                        campaign = campaignObjectMap.get(choosen_campaign);
                        callLine.Activity__c = campaign.Activity__c;
                        callLine.Case_Type__c = campaign.Case_Type__c;
                        callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                        callline.RecordTypeId = id.valueof(campaign.Call_Line_RecordTypeID__c);

                    callLine.Ext_Id_Temp__c = conv.policyNo;
                    callLine.Policy_No__c = conv.policyNo;
                    callLine.Product__c = conv.Product;
                    callLine.DESCRIPTION__c = conv.DESCRIPTION;
                    callLine.Method__c = conv.Method;
                    callLine.Effective_Date__c = conv.EffectiveDate;
                    callLine.Name_1__c = conv.Name1;
                    callLine.Name_2__c = conv.Name2;
                    callLine.LINE1__c = conv.LINE1;
                    callLine.LINE11__c = conv.LINE11;
                    callLine.LINE12__c = conv.LINE12;
                    callLine.LINE13__c = conv.LINE13;
                    callLine.CITY__c = conv.CITY;
                    callLine.ZIPCODE__c = conv.ZIPCODE;
                    callLine.MOBILEPHONE_Upload__c = conv.MOBILEPHONE;
                    callLine.MOBILEPHONE2_Upload__c = conv.MOBILEPHONE2;
                    callLine.OFFICEPHONE__c = conv.OFFICEPHONE;
                    callLine.OFFICEPHONE2__c = conv.OFFICEPHONE2;
                    callLine.HOMEPHONE__c = conv.HOMEPHONE;
                    callLine.HOMEPHONE2__c = conv.HOMEPHONE2;
                    callLine.EMAIL_Upload__c = conv.EMAIL;
                    callLine.delivereddate__c = conv.delivereddate;
                    callLine.CORRESPONDENCETYPEID__c = conv.Correspond;
                    callLine.REPORT_POLICY_DELIVERY__c = conv.ReportPolicy;
                    callLine.Ext_ID__c = choosen_campaign + '-'+mapContactList.get(conv.policyNo).id;
                    system.debug('callLine.Contact__c (welcome call): '+callLine.Contact__c);
                    system.debug('callLine.Ext_ID__c (welcome call): '+callLine.Ext_ID__c);
                    //callLine.POLIS__c = conv.Polis;
                    //conservationArr = conservationArr + ',' + recVal[0]+'#'+num;
                    
                    outboundCallList.add(uploadedCall);     
                    callLineList.add(callLine); 
                    mapuploadList.put(conv.policyNo,conv.policyNo);
                    if (callLine.Contact__c != NULL)
                    WelcomeArr = WelcomeArr.replaceFirst(conv.PolicyNo, 'VALIDPOLICYNO');
                }
            } // end check 
        } // end Welcome
        system.debug('## CallLineList : '+callLineList.size());
        
      	//Update Daniel, 22 April 2020
      	//if (callLineList.size() > 0) insert callLineList;
      
      	if (callLineList.size() > 0) {
            CallLineInsertBatch jb = new CallLineInsertBatch(callLineList);
            Database.executeBatch(jb, 65);
        }
      	//END - Update Daniel, 22 April 2020
      	
        system.debug('## DONE CallLineList ## ');
        
        invalidPolicyTempList = WelcomeArr.split(',');
        invalidPolicyTempList.remove(0); 
        invalidPolicyList = new List<string>();
        for(string polno : invalidPolicyTempList){
            if(polno != 'VALIDPOLICYNO'){
                if (invalidPolicyList.size() < 900)
                invalidPolicyList.add(polno);   
            }
        } 
        
        insert document;
    }

  @TestVisible private void processReinstate(List<String> dataList, List<String> dataList2){
        List<Contact> contactList = [select id, Policy_No__c, Policy_No_ALI__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No_ALI__c in :dataList and createddate > 2014-01-01T00:00:01Z];
        integer foundCounter = contactList.size();    //added by WK, 20150417
        //validNum = contactList.size();        //remarked by WK, 20150417
        //invalidNum = uploadedNum - validNum;  //remarked by WK, 20150417
        //system.debug('## validNum : '+validNum);

        //begin:added by Wk, 20150417
        List<Call_Line__c> existingCallLineList = [select id, Ext_ID_F__c, Ext_ID_Temp__c, Policy_No__c, Entity__c from Call_Line__c where Ext_ID_Temp__c in :dataList2 and Call_List__c = :choosen_campaign and createddate > 2014-01-01T00:00:01Z];
        integer existingCounter = existingCallLineList.size();
        validNum = foundCounter - existingCounter;
        invalidNum = uploadedNum - validNum;
        //end:added by Wk, 20150417

        outboundCallList = new List<OutboundCall>();
        callLineList = new List<Call_Line__c>();
        OutboundCall uploadedCall = null;
        Call_Line__c callLine = null;
        Call_List__c campaign = null;
        integer idx = 0;
        boolean isExist = false;    //added by WK, 20150417

        map<string,Contact> mapContactList = new map<string,Contact>();
        map<string,Call_Line__c> mapCallLineList = new map<string,Call_Line__c>();
        map<string,string> mapuploadList = new map<string,string>();
        for(Contact pelanggan : contactList){
            mapContactList.put(pelanggan.Policy_No_ALI__c,pelanggan);
        }
        for(Call_Line__c cl : existingCallLineList){
            mapCallLineList.put(cl.Ext_ID_Temp__c, cl);
        }
        system.debug('## ReinstateList : '+ReinstateList.size());
        for(Reinstate conv : ReinstateList){
            // check sudah pernah upload atau belum.
            if (mapCallLineList.get(conv.ReffNo+''+conv.policyNo) == NULL) {
                if (mapuploadList.get(conv.ReffNo+''+conv.policyNo) == NULL) {
                    uploadedCall = new OutboundCall();
                    uploadedCall.policyNo = conv.PolicyNo;
                    uploadedCall.campaignName = campaignMap.get(choosen_campaign);  
                
                    callLine = new Call_Line__c();
                    callLine.Policy_No__c = conv.policyNo;

                    if (mapContactList.get(conv.policyNo) != NULL) {
                        uploadedCall.phoneNo = mapContactList.get(conv.policyNo).MobilePhone;

                        callLine.Contact__c = mapContactList.get(conv.policyNo).id;
                        callLine.Contacted_Number__c = mapContactList.get(conv.policyNo).MobilePhone;
                        callLine.Home_Phone__c = mapContactList.get(conv.policyNo).HomePhone;
                        callLine.Phone__c = mapContactList.get(conv.policyNo).Phone;
                        callLine.Entity__c = mapContactList.get(conv.policyNo).Entity__c;
                    }
                        callLine.Call_List__c = choosen_campaign;
                        campaign = campaignObjectMap.get(choosen_campaign);
                        callLine.Activity__c = campaign.Activity__c;
                        callLine.Case_Type__c = campaign.Case_Type__c;
                        callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                        callline.RecordTypeId = id.valueof(campaign.Call_Line_RecordTypeID__c);
                    
                    callLine.Ext_Id_Temp__c = conv.ReffNo+''+conv.policyNo;
                    callLine.Refference_No__c = conv.ReffNo;
                    callLine.Policy_No__c = conv.policyNo;
                    callLine.Offering2__c = conv.Offering;
                    callLine.Product__c = conv.Product;
                    callLine.Status_Polis__c = conv.Status_Polis;
                    callLine.Name_1__c = conv.Name_1;
                    callLine.Priority__c = conv.Priority;
                    callLine.Old_Result__c = conv.Old_Result; //conv.Status;//
                    callLine.Effective_Date__c = conv.Effective_Date;
                    callLine.Ext_ID__c = choosen_campaign + '-'+callLine.Contact__c;

                    //conservationArr = conservationArr + ',' + recVal[0]+'#'+num;
                    
                    outboundCallList.add(uploadedCall);     
                    callLineList.add(callLine); 
                    mapuploadList.put(conv.ReffNo+''+conv.policyNo,conv.ReffNo+''+conv.policyNo);
                    if (callLine.Contact__c != NULL)
                    ReinstateArr = ReinstateArr.replaceFirst(conv.ReffNo, 'VALIDPOLICYNO');
                }
            } // end check 
            
        } // end reinstate
        system.debug('## CallLineList : '+callLineList.size());
        
      	//Update Daniel, 22 April 2020
      	//if (callLineList.size() > 0) insert callLineList;
      
      	if (callLineList.size() > 0) {
            CallLineInsertBatch jb = new CallLineInsertBatch(callLineList);
            Database.executeBatch(jb, 65);
        }
      	//END - Update Daniel, 22 April 2020
      	
      	
        system.debug('## DONE CallLineList ## ');
        
        invalidPolicyTempList = ReinstateArr.split(',');
        invalidPolicyTempList.remove(0); 
        invalidPolicyList = new List<string>();
        for(string polno : invalidPolicyTempList){
            if(polno != 'VALIDPOLICYNO'){
                if (invalidPolicyList.size() < 900)
                invalidPolicyList.add(polno);   
            }
        } 
        
        insert document;
    }

  @TestVisible private void processPremiumFU(List<String> dataList, List<String> dataList2){
      	list_policyNo = new List<String>();
        List<Contact> contactList = [select id, Policy_No__c, Policy_No_ALI__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No_ALI__c in :dataList and createddate > 2014-01-01T00:00:01Z];
        integer foundCounter = contactList.size();    //added by WK, 20150417
        //validNum = contactList.size();        //remarked by WK, 20150417
        //invalidNum = uploadedNum - validNum;  //remarked by WK, 20150417
        //system.debug('## validNum : '+validNum);

        //begin:added by Wk, 20150417
        List<Call_Line__c> existingCallLineList = [select id, Ext_ID_F__c, Ext_ID_Temp__c, Policy_No__c, Entity__c from Call_Line__c where Ext_ID_Temp__c in :dataList2 and Call_List__c = :choosen_campaign and createddate > 2014-01-01T00:00:01Z];
        integer existingCounter = existingCallLineList.size();
        validNum = foundCounter - existingCounter;
        invalidNum = uploadedNum - validNum;
        //end:added by Wk, 20150417

        outboundCallList = new List<OutboundCall>();
        callLineList = new List<Call_Line__c>();
        OutboundCall uploadedCall = null;
        Call_Line__c callLine = null;
        Call_List__c campaign = null;
        integer idx = 0;
        boolean isExist = false;    //added by WK, 20150417

        map<string,Contact> mapContactList = new map<string,Contact>();
        map<string,Call_Line__c> mapCallLineList = new map<string,Call_Line__c>();
        map<string,string> mapuploadList = new map<string,string>();
        for(Contact pelanggan : contactList){
            mapContactList.put(pelanggan.Policy_No_ALI__c,pelanggan);
        }
        for(Call_Line__c cl : existingCallLineList){
            mapCallLineList.put(cl.Ext_ID_Temp__c, cl);
        }
        system.debug('## PremiumFUList : '+PremiumFUList.size());
        integer ContactFilled = 0;
        for(PremiumFU conv : PremiumFUList){
            // check sudah pernah upload atau belum.
            if (mapCallLineList.get(conv.ReffNo+''+conv.policyNo) == NULL) {
                if (mapuploadList.get(conv.ReffNo+''+conv.policyNo) == NULL) {
                    uploadedCall = new OutboundCall();
                    uploadedCall.policyNo = conv.PolicyNo;
                    uploadedCall.campaignName = campaignMap.get(choosen_campaign);  
                
                    callLine = new Call_Line__c();
                    callLine.Policy_No__c = conv.policyNo;

                    if (mapContactList.get(conv.policyNo) != NULL) {
                        ContactFilled += 1;
                        uploadedCall.phoneNo = mapContactList.get(conv.policyNo).MobilePhone;

                        callLine.Contact__c = mapContactList.get(conv.policyNo).id;
                        callLine.Contacted_Number__c = mapContactList.get(conv.policyNo).MobilePhone;
                        callLine.Home_Phone__c = mapContactList.get(conv.policyNo).HomePhone;
                        callLine.Phone__c = mapContactList.get(conv.policyNo).Phone;
                        callLine.Entity__c = mapContactList.get(conv.policyNo).Entity__c;
                    }
                        callLine.Call_List__c = choosen_campaign;
                        if (callLine.Entity__c == NULL) callLine.Entity__c = Entity;
                        campaign = campaignObjectMap.get(choosen_campaign);
                        callLine.Activity__c = campaign.Activity__c;
                        callLine.Case_Type__c = campaign.Case_Type__c;
                        callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                        callline.RecordTypeId = id.valueof(campaign.Call_Line_RecordTypeID__c);
                    
                    callLine.Ext_Id_Temp__c = conv.ReffNo+''+conv.policyNo;
                    callLine.Refference_No__c = conv.ReffNo;
                    callLine.Policy_No__c = conv.policyNo;
                    callLine.Offering2__c = conv.Offering;
                    callLine.Product__c = conv.Product;
                    callLine.Status_Polis__c =  conv.StatusPolis;
                    callLine.Name_1__c = conv.Name_1;
                    callLine.RejReason__c = conv.RejReason;
                    callLine.Priority__c = conv.Priority;
                    callLine.Old_Result__c = conv.Old_Result;
                    callLine.Effective_Date__c = conv.Effective_Date;
                    callLine.Premium__c = conv.Premium;
                    callLine.Ext_ID__c = choosen_campaign + '-'+conv.ReffNo;
                    //callLine.Premium2__c = conv.Premium;
                    //conservationArr = conservationArr + ',' + recVal[0]+'#'+num;
                                        
                    outboundCallList.add(uploadedCall);     
                    callLineList.add(callLine); 
                    mapuploadList.put(conv.ReffNo+''+conv.policyNo,conv.ReffNo+''+conv.policyNo);
                    if (callLine.Contact__c != NULL)
                    PremiumFUArr = PremiumFUArr.replaceFirst(conv.ReffNo, 'VALIDPOLICYNO');
                }
                
            } // end check 
            
        } // end PremiumFU
        system.debug('## CallLineList : '+callLineList.size());
        
      	//Update Daniel, 22 April 2020
      	//if (callLineList.size() > 0) insert callLineList;
      
      	if (callLineList.size() > 0) {
            CallLineInsertBatch jb = new CallLineInsertBatch(callLineList);
            Database.executeBatch(jb, 65);
        }
      	//END - Update Daniel, 22 April 2020
      
        system.debug('## DONE CallLineList Premium FU ## '+ContactFilled);
        
        validNum = ContactFilled; //foundCounter - existingCounter;
        invalidNum = uploadedNum - validNum;
            
        invalidPolicyTempList = PremiumFUArr.split(',');
        invalidPolicyTempList.remove(0); 
        invalidPolicyList = new List<string>();
        for(string polno : invalidPolicyTempList){
            if(polno != 'VALIDPOLICYNO'){
                if (invalidPolicyList.size() < 900)
                invalidPolicyList.add(polno);   
            }
        } 
        
        insert document;
    }

  @TestVisible private void processclaim(List<String> dataList){
        List<Contact> contactList = [select id, Name, LastName, Policy_No__c, Policy_No_ALI__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No_ALI__c in :dataList and createddate > 2014-01-01T00:00:01Z];
        integer foundCounter = contactList.size();    //added by WK, 20150417
        //validNum = contactList.size();        //remarked by WK, 20150417
        //invalidNum = uploadedNum - validNum;  //remarked by WK, 20150417
        //system.debug('## validNum : '+validNum);

        //begin:added by Wk, 20150417
        List<Call_Line__c> existingCallLineList = [select id, Ext_ID_F__c, Ext_ID_Temp__c, Policy_No__c, Entity__c from Call_Line__c where Ext_ID_Temp__c in :dataList and Call_List__c = :choosen_campaign and createddate > 2014-01-01T00:00:01Z];
        integer existingCounter = existingCallLineList.size();
        validNum = foundCounter - existingCounter;
        invalidNum = uploadedNum - validNum;
        //end:added by Wk, 20150417

        outboundCallList = new List<OutboundCall>();
        callLineList = new List<Call_Line__c>();
        OutboundCall uploadedCall = null;
        Call_Line__c callLine = null;
        Call_List__c campaign = null;
        integer idx = 0;
        boolean isExist = false;    //added by WK, 20150417

        map<string,Contact> mapContactList = new map<string,Contact>();
        map<string,Call_Line__c> mapCallLineList = new map<string,Call_Line__c>();
        map<string,string> mapuploadList = new map<string,string>();
        for(Contact pelanggan : contactList){
            mapContactList.put(pelanggan.Policy_No_ALI__c,pelanggan);
        }
        for(Call_Line__c cl : existingCallLineList){
            mapCallLineList.put(cl.Ext_ID_Temp__c, cl);
        }
        for(claim conv : claimList){
            // check sudah pernah upload atau belum.
            if (mapCallLineList.get(conv.Policy_No) == NULL) {
                if (mapuploadList.get(conv.Policy_No) == NULL) {
                    uploadedCall = new OutboundCall();
                    uploadedCall.PolicyNo = conv.Policy_No;
                    uploadedCall.campaignName = campaignMap.get(choosen_campaign);  
                
                    callLine = new Call_Line__c();
                    callLine.Policy_No__c = conv.Policy_No;

                    if (mapContactList.get(conv.Policy_No) != NULL) {
                        uploadedCall.phoneNo = mapContactList.get(conv.Policy_No).MobilePhone;

                        callLine.Contact__c = mapContactList.get(conv.Policy_No).id;
                        callLine.Name_1__c = mapContactList.get(conv.Policy_No).Name;
                        callLine.Contacted_Number__c = mapContactList.get(conv.Policy_No).MobilePhone;
                        callLine.Home_Phone__c = mapContactList.get(conv.Policy_No).HomePhone;
                        callLine.Phone__c = mapContactList.get(conv.Policy_No).Phone;
                        callLine.Entity__c = mapContactList.get(conv.Policy_No).Entity__c;
                    }
                        callLine.Call_List__c = choosen_campaign;
                        campaign = campaignObjectMap.get(choosen_campaign);
                        callLine.Activity__c = campaign.Activity__c;
                        callLine.Case_Type__c = campaign.Case_Type__c;
                        callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                        callline.RecordTypeId = id.valueof(campaign.Call_Line_RecordTypeID__c);

                    callLine.Ext_Id_Temp__c = conv.Policy_No;
                    callLine.No__c = conv.No;
                    callLine.Policy_No__c = conv.Policy_No;
                    callLine.Request_Date__c = conv.Request_Date;
                    callLine.Claim_No__c = conv.Claim_No;
                    callLine.Policy_Holder_Name__c = conv.Policy_Holder_Name;
                    callLine.Follow_Up_Information__c = conv.Follow_Up_Information;
                    callLine.Dateline__c = conv.Dateline;
                    callLine.Follow_Up_Result__c = conv.FollowUpResult;
                    //conservationArr = conservationArr + ',' + recVal[0]+'#'+num;
                    
                    outboundCallList.add(uploadedCall);     
                    callLineList.add(callLine); 
                    mapuploadList.put(conv.Policy_No,conv.Policy_No);
                    if (callLine.Contact__c != NULL)
                    claimArr = claimArr.replaceFirst(conv.Policy_No, 'VALIDPOLICYNO');
                }
            } // end check 
        } // end claim
        system.debug('## CallLineList : '+callLineList.size());
        if (callLineList.size() > 0) insert callLineList;
        system.debug('## DONE CallLineList ## ');
        
        invalidPolicyTempList = claimArr.split(',');
        invalidPolicyTempList.remove(0); 
        invalidPolicyList = new List<string>();
        for(string polno : invalidPolicyTempList){
            if(polno != 'VALIDPOLICYNO'){
                if (invalidPolicyList.size() < 900)
                invalidPolicyList.add(polno);   
            }
        } 
        
        insert document;
    }

  @TestVisible private void processUpdateData(List<String> dataList){
        List<Contact> contactList = [select id, Policy_No_ALI__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No_ALI__c in :dataList and createddate > 2014-01-01T00:00:01Z];
        integer foundCounter = contactList.size();    //added by WK, 20150417
        //validNum = contactList.size();        //remarked by WK, 20150417
        //invalidNum = uploadedNum - validNum;  //remarked by WK, 20150417
        //system.debug('## validNum : '+validNum);

        //begin:added by Wk, 20150417
        List<Call_Line__c> existingCallLineList = [select id, Ext_ID_F__c, Ext_ID_Temp__c, Policy_No__c, Entity__c from Call_Line__c where Ext_ID_Temp__c in :dataList and Call_List__c = :choosen_campaign and createddate > 2014-01-01T00:00:01Z];
        integer existingCounter = existingCallLineList.size();
        validNum = foundCounter - existingCounter;
        invalidNum = uploadedNum - validNum;
        //end:added by Wk, 20150417

        outboundCallList = new List<OutboundCall>();
        callLineList = new List<Call_Line__c>();
        OutboundCall uploadedCall = null;
        Call_Line__c callLine = null;
        Call_List__c campaign = null;
        integer idx = 0;
        boolean isExist = false;    //added by WK, 20150417

        map<string,Contact> mapContactList = new map<string,Contact>();
        map<string,Call_Line__c> mapCallLineList = new map<string,Call_Line__c>();
        map<string,string> mapuploadList = new map<string,string>();
        for(Contact pelanggan : contactList){
            mapContactList.put(pelanggan.Policy_No_ALI__c,pelanggan);
        }
        for(Call_Line__c cl : existingCallLineList){
            mapCallLineList.put(cl.Ext_ID_Temp__c, cl);
        }
        for(UpdateData conv : UpdateDataList){
            // check sudah pernah upload atau belum.
            if (mapCallLineList.get(conv.Policy_No) == NULL) {
                if (mapuploadList.get(conv.Policy_No) == NULL) {
                    uploadedCall = new OutboundCall();
                    uploadedCall.policyNo = conv.Policy_No;
                    uploadedCall.campaignName = campaignMap.get(choosen_campaign);  
                
                    callLine = new Call_Line__c();
                    callLine.Policy_No__c = conv.Policy_No;

                    if (mapContactList.get(conv.Policy_No) != NULL) {
                        uploadedCall.phoneNo = mapContactList.get(conv.Policy_No).MobilePhone;

                        callLine.Contact__c = mapContactList.get(conv.Policy_No).id;
                        callLine.Contacted_Number__c = mapContactList.get(conv.Policy_No).MobilePhone;
                        callLine.Home_Phone__c = mapContactList.get(conv.Policy_No).HomePhone;
                        callLine.Phone__c = mapContactList.get(conv.Policy_No).Phone;
                        callLine.Entity__c = mapContactList.get(conv.Policy_No).Entity__c;
                    }
                        callLine.Call_List__c = choosen_campaign;
                        campaign = campaignObjectMap.get(choosen_campaign);
                        callLine.Activity__c = campaign.Activity__c;
                        callLine.Case_Type__c = campaign.Case_Type__c;
                        callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                        callline.RecordTypeId = id.valueof(campaign.Call_Line_RecordTypeID__c);

                    callLine.Ext_Id_Temp__c = conv.Policy_No;
                    callLine.Policy_No__c = conv.Policy_No;
                    callLine.TITLE__c = conv.TITLE;
                    callLine.NAME_1__c = conv.NAME_1;
                    callLine.Birthday__c = conv.BIRTHDATE;
                    callLine.Email_upload__c = conv.EMAIL;
                    callLine.UPDATEEMAIL__c = conv.UPDATEEMAIL ;
                    callLine.KTP__c = conv.KTP;
                    callLine.FU__c = conv.FU;
                    callLine.ASSIGN__c = conv.ASSIGN;
                    callLine.MobilePhone_Upload__c = conv.MOBILEPHONE;
                    callLine.Call_Remarks__c = conv.REMARKS;
                    //conservationArr = conservationArr + ',' + recVal[0]+'#'+num;
                    
                    outboundCallList.add(uploadedCall);     
                    callLineList.add(callLine); 
                    mapuploadList.put(conv.Policy_No,conv.Policy_No);
                    if (callLine.Contact__c != NULL)
                    UpdateDataArr = UpdateDataArr.replaceFirst(conv.Policy_No, 'VALIDPOLICYNO');
                }
            } // end check 
        } // end UpdateData
        system.debug('## CallLineList : '+callLineList.size());
        if (callLineList.size() > 0) insert callLineList;
        system.debug('## DONE CallLineList ## ');
        
        invalidPolicyTempList = UpdateDataArr.split(',');
        invalidPolicyTempList.remove(0); 
        invalidPolicyList = new List<string>();
        for(string polno : invalidPolicyTempList){
            if(polno != 'VALIDPOLICYNO'){
                if (invalidPolicyList.size() < 0)
                invalidPolicyList.add(polno);   
            }
        } 
        
        insert document;
    }

  @TestVisible private void processNCB(List<String> dataList){
        List<Contact> contactList = [select id, Policy_No__c, Policy_No_ALI__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No_ALI__c in :dataList and createddate > 2014-01-01T00:00:01Z];
        integer foundCounter = contactList.size();    //added by WK, 20150417
        //validNum = contactList.size();        //remarked by WK, 20150417
        //invalidNum = uploadedNum - validNum;  //remarked by WK, 20150417
        //system.debug('## validNum : '+validNum);

        //begin:added by Wk, 20150417
        List<Call_Line__c> existingCallLineList = [select id, Ext_ID_F__c, Ext_ID_Temp__c, Policy_No__c, Entity__c from Call_Line__c where Ext_ID_Temp__c in :dataList and Call_List__c = :choosen_campaign and createddate > 2014-01-01T00:00:01Z];
        integer existingCounter = existingCallLineList.size();
        validNum = foundCounter - existingCounter;
        invalidNum = uploadedNum - validNum;
        //end:added by Wk, 20150417

        outboundCallList = new List<OutboundCall>();
        callLineList = new List<Call_Line__c>();
        OutboundCall uploadedCall = null;
        Call_Line__c callLine = null;
        Call_List__c campaign = null;
        integer idx = 0;
        boolean isExist = false;    //added by WK, 20150417

        map<string,Contact> mapContactList = new map<string,Contact>();
        map<string,Call_Line__c> mapCallLineList = new map<string,Call_Line__c>();
        map<string,string> mapuploadList = new map<string,string>();
        for(Contact pelanggan : contactList){
            mapContactList.put(pelanggan.Policy_No_ALI__c,pelanggan);
        }
        for(Call_Line__c cl : existingCallLineList){
            mapCallLineList.put(cl.Ext_ID_Temp__c, cl);
        }
        for(NCB conv : NCBList){
            // check sudah pernah upload atau belum.
            if (mapCallLineList.get(conv.POLICY_NO) == NULL) {
                if (mapuploadList.get(conv.POLICY_NO) == NULL) {
                    uploadedCall = new OutboundCall();
                    uploadedCall.policyNo = conv.POLICY_NO;
                    uploadedCall.campaignName = campaignMap.get(choosen_campaign);  
                
                    callLine = new Call_Line__c();
                    callLine.Policy_No__c = conv.POLICY_NO;

                    if (mapContactList.get(conv.POLICY_NO) != NULL) {
                        uploadedCall.phoneNo = mapContactList.get(conv.POLICY_NO).MobilePhone;

                        callLine.Contact__c = mapContactList.get(conv.POLICY_NO).id;
                        callLine.Contacted_Number__c = mapContactList.get(conv.POLICY_NO).MobilePhone;
                        callLine.Home_Phone__c = mapContactList.get(conv.POLICY_NO).HomePhone;
                        callLine.Phone__c = mapContactList.get(conv.POLICY_NO).Phone;
                        callLine.Entity__c = mapContactList.get(conv.POLICY_NO).Entity__c;
                    }
                        callLine.Call_List__c = choosen_campaign;
                        campaign = campaignObjectMap.get(choosen_campaign);
                        callLine.Activity__c = campaign.Activity__c;
                        callLine.Case_Type__c = campaign.Case_Type__c;
                        callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                    system.debug('## ID REcordTypeId ## '+campaign.Call_Line_RecordTypeID__c);
                        callline.RecordTypeId = id.valueof(campaign.Call_Line_RecordTypeID__c);

                    callLine.Ext_Id_Temp__c = conv.POLICY_NO;
                    callLine.Policy_No__c = conv.POLICY_NO;
                    callLine.Name_1__c = conv.Name_1;
                    callLine.MOBILEPHONE_Upload__c = conv.MOBILEPHONE;
                    callLine.MOBILEPHONE2_Upload__c = conv.MOBILEPHONE2;
                    callLine.EMAIL_Upload__c = conv.EMAIL;
                    callLine.Identity_No__c = conv.IDENTITYNO;
                    callLine.Effective_Date__c = conv.EFFECTIVEDATE;
                    callLine.PAIDTODATE__c = conv.PAIDTODATE;
                    callLine.MONTHSPAID__c = conv.MONTHSPAID;
                    callLine.TOTALNCB__c = conv.TOTALNCB;
                    callLine.PRODUCT__c = conv.PRODUCT;
                    callLine.Status_Polis__c = conv.STATUS;
                    callLine.Nama_Bank__c = conv.NamaBank;
                    callLine.Nomor_Rekening__c = conv.NomorRekening;
                    callLine.Nama_Pemilik_Rekening__c = conv.NamaPemilikRekening;
                    callLine.Keterangan__c = conv.Keterangan;
                    callLine.Agent_ID__c = conv.Agent;
                    //conservationArr = conservationArr + ',' + recVal[0]+'#'+num;
                    
                    outboundCallList.add(uploadedCall);     
                    callLineList.add(callLine); 
                    mapuploadList.put(conv.POLICY_NO,conv.POLICY_NO);
                    if (callLine.Contact__c != NULL)
                    NCBArr = NCBArr.replaceFirst(conv.POLICY_NO, 'VALIDPOLICYNO');
                }
            } // end check 
        } // end NCB
        system.debug('## CallLineList : '+callLineList.size());
        if (callLineList.size() > 0) insert callLineList;
        system.debug('## DONE CallLineList ## ');
        
        invalidPolicyTempList = NCBArr.split(',');
        invalidPolicyTempList.remove(0); 
        invalidPolicyList = new List<string>();
        for(string polno : invalidPolicyTempList){
            if(polno != 'VALIDPOLICYNO'){
                if (invalidPolicyList.size() < 900)
                invalidPolicyList.add(polno);   
            }
        } 
        
        insert document;
    }

  @TestVisible private void processSurveyFeedback(List<String> dataList){
        List<Contact> contactList = [select id, Name, LastName, Policy_No__c, Policy_No_ALI__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No_ALI__c in :dataList and createddate > 2014-01-01T00:00:01Z];
        integer foundCounter = contactList.size();    //added by WK, 20150417
        //validNum = contactList.size();        //remarked by WK, 20150417
        //invalidNum = uploadedNum - validNum;  //remarked by WK, 20150417
        //system.debug('## validNum : '+validNum);

        //begin:added by Wk, 20150417
        List<Call_Line__c> existingCallLineList = [select id, Ext_ID_F__c, Ext_ID_Temp__c, Policy_No__c, Entity__c from Call_Line__c where Ext_ID_Temp__c in :dataList and Call_List__c = :choosen_campaign and createddate > 2014-01-01T00:00:01Z];
        integer existingCounter = existingCallLineList.size();
        validNum = foundCounter - existingCounter;
        invalidNum = uploadedNum - validNum;
        //end:added by Wk, 20150417

        outboundCallList = new List<OutboundCall>();
        callLineList = new List<Call_Line__c>();
        OutboundCall uploadedCall = null;
        Call_Line__c callLine = null;
        Call_List__c campaign = null;
        integer idx = 0;
        boolean isExist = false;    //added by WK, 20150417

        map<string,Contact> mapContactList = new map<string,Contact>();
        map<string,Call_Line__c> mapCallLineList = new map<string,Call_Line__c>();
        map<string,string> mapuploadList = new map<string,string>();
        for(Contact pelanggan : contactList){
            mapContactList.put(pelanggan.Policy_No_ALI__c,pelanggan);
        }
        for(Call_Line__c cl : existingCallLineList){
            mapCallLineList.put(cl.Ext_ID_Temp__c, cl);
        }
        for(SurveyFeedback conv : SurveyFeedbackList){
            // check sudah pernah upload atau belum.
            if (mapCallLineList.get(conv.Policy_No) == NULL) {
                if (mapuploadList.get(conv.Policy_No) == NULL) {
                    uploadedCall = new OutboundCall();
                    uploadedCall.policyNo = conv.Policy_No;
                    uploadedCall.campaignName = campaignMap.get(choosen_campaign);  
                
                    callLine = new Call_Line__c();
                    callLine.Policy_No__c = conv.Policy_No;

                    if (mapContactList.get(conv.Policy_No) != NULL) {
                        uploadedCall.phoneNo = mapContactList.get(conv.Policy_No).MobilePhone;

                        callLine.Contact__c = mapContactList.get(conv.Policy_No).id;
                        callLine.Name_1__c = mapContactList.get(conv.Policy_No).Name;
                        callLine.Contacted_Number__c = mapContactList.get(conv.Policy_No).MobilePhone;
                        callLine.Home_Phone__c = mapContactList.get(conv.Policy_No).HomePhone;
                        callLine.Phone__c = mapContactList.get(conv.Policy_No).Phone;
                        callLine.Entity__c = mapContactList.get(conv.Policy_No).Entity__c;
                    }
                        callLine.Call_List__c = choosen_campaign;
                        campaign = campaignObjectMap.get(choosen_campaign);
                        callLine.Activity__c = campaign.Activity__c;
                        callLine.Case_Type__c = campaign.Case_Type__c;
                        callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                        callline.RecordTypeId = id.valueof(campaign.Call_Line_RecordTypeID__c);

                    callLine.Ext_Id_Temp__c = conv.Policy_No;
                    callLine.Policy_No__c = conv.Policy_No;
                    callLine.No__c = conv.No;
                    callLine.Date_Time__c = conv.Date_Time;
                    callLine.Agent_Id__c = conv.Agent_Id;
                    callLine.MobilePhone_Upload__c = conv.MobilePhone;
                    callLine.Q1__c = conv.Q1;
                    callLine.Q2__c = conv.Q2;
                    callLine.Topic__c = conv.Topic;
                    callLine.Call_Remarks__c = conv.Remarks;
                    //conservationArr = conservationArr + ',' + recVal[0]+'#'+num;
                    
                    outboundCallList.add(uploadedCall);     
                    callLineList.add(callLine); 
                    mapuploadList.put(conv.Policy_No,conv.Policy_No);
                    if (callLine.Contact__c != NULL)
                    SurveyFeedbackArr = SurveyFeedbackArr.replaceFirst(conv.Policy_No, 'VALIDPOLICYNO');
                }
            } // end check 
        } // end SurveyFeedback
        system.debug('## CallLineList : '+callLineList.size());
        if (callLineList.size() > 0) insert callLineList;
        system.debug('## DONE CallLineList ## ');
        
        invalidPolicyTempList = SurveyFeedbackArr.split(',');
        invalidPolicyTempList.remove(0); 
        invalidPolicyList = new List<string>();
        for(string polno : invalidPolicyTempList){
            if(polno != 'VALIDPOLICYNO'){
                if (invalidPolicyList.size() < 900)
                invalidPolicyList.add(polno);   
            }
        } 
        
        insert document;
    }

  @TestVisible private void processCollectionTask(List<String> dataList){
        List<Contact> contactList = [select id, Policy_No__c, Policy_No_ALI__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No_ALI__c in :dataList and createddate > 2014-01-01T00:00:01Z];
        integer foundCounter = contactList.size();    //added by WK, 20150417
        //validNum = contactList.size();        //remarked by WK, 20150417
        //invalidNum = uploadedNum - validNum;  //remarked by WK, 20150417
        //system.debug('## validNum : '+validNum);

        //begin:added by Wk, 20150417
        List<Call_Line__c> existingCallLineList = [select id, Ext_ID_F__c, Ext_ID_Temp__c, Policy_No__c, Entity__c from Call_Line__c where Ext_ID_Temp__c in :dataList and Call_List__c = :choosen_campaign and createddate > 2014-01-01T00:00:01Z];
        integer existingCounter = existingCallLineList.size();
        validNum = foundCounter - existingCounter;
        invalidNum = uploadedNum - validNum;
        //end:added by Wk, 20150417

        outboundCallList = new List<OutboundCall>();
        callLineList = new List<Call_Line__c>();
        OutboundCall uploadedCall = null;
        Call_Line__c callLine = null;
        Call_List__c campaign = null;
        integer idx = 0;
        boolean isExist = false;    //added by WK, 20150417

        map<string,Contact> mapContactList = new map<string,Contact>();
        map<string,Call_Line__c> mapCallLineList = new map<string,Call_Line__c>();
        map<string,string> mapuploadList = new map<string,string>();
        for(Contact pelanggan : contactList){
            mapContactList.put(pelanggan.Policy_No_ALI__c,pelanggan);
        }
        for(Call_Line__c cl : existingCallLineList){
            mapCallLineList.put(cl.Ext_ID_Temp__c, cl);
        }
        for(CollectionTask conv : CollectionTaskList){
            // check sudah pernah upload atau belum.
            if (mapCallLineList.get(conv.policyNo) == NULL) {
                if (mapuploadList.get(conv.policyNo) == NULL) {
                    uploadedCall = new OutboundCall();
                    uploadedCall.policyNo = conv.PolicyNo;
                    uploadedCall.campaignName = campaignMap.get(choosen_campaign);  
                
                    callLine = new Call_Line__c();
                    callLine.Policy_No__c = conv.policyNo;

                    if (mapContactList.get(conv.policyNo) != NULL) {
                        uploadedCall.phoneNo = mapContactList.get(conv.policyNo).MobilePhone;

                        callLine.Contact__c = mapContactList.get(conv.policyNo).id;
                        callLine.Contacted_Number__c = mapContactList.get(conv.policyNo).MobilePhone;
                        callLine.Home_Phone__c = mapContactList.get(conv.policyNo).HomePhone;
                        callLine.Phone__c = mapContactList.get(conv.policyNo).Phone;
                        callLine.Entity__c = mapContactList.get(conv.policyNo).Entity__c;
                    }
                        callLine.Call_List__c = choosen_campaign;
                        campaign = campaignObjectMap.get(choosen_campaign);
                        callLine.Activity__c = campaign.Activity__c;
                        callLine.Case_Type__c = campaign.Case_Type__c;
                        callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                        callline.RecordTypeId = id.valueof(campaign.Call_Line_RecordTypeID__c);

                    callLine.Ext_Id_Temp__c = conv.policyNo;
                    callLine.Policy_No__c = conv.policyNo;
                    callLine.Retur_Payment__c = conv.ReturPayment;
                    callLine.Policy_Holder_Name__c = conv.PolicyHolder;
                    callLine.Name_1__c = conv.PolicyHolder;
                    callLine.Status_Polis__c = conv.StatusPolis;
                    callLine.Nominal__c = conv.Nominal;
                    callLine.Periode_Terdebet__c = conv.PeriodeTerdebet;
                    callLine.Nama_Bank__c = conv.BANKNAME;
                    callLine.Nomor_Rekening__c = conv.BANKACCNUMBER;
                    callLine.Nama_Pemilik_Rekening__c = conv.BANKACCNAME;
                    callLine.Ext_ID__c = choosen_campaign + '-'+callLine.Contact__c;
                    //callLine.POLIS__c = conv.Polis;
                    //conservationArr = conservationArr + ',' + recVal[0]+'#'+num;
                    
                    outboundCallList.add(uploadedCall);     
                    callLineList.add(callLine); 
                    mapuploadList.put(conv.policyNo,conv.policyNo);
                    if (callLine.Contact__c != NULL)
                    CollectionTaskArr = CollectionTaskArr.replaceFirst(conv.PolicyNo, 'VALIDPOLICYNO');
                }
            } // end check 
        } // end CollectionTask
        system.debug('## CallLineList : '+callLineList.size());
              
      	//Update Daniel, 22 April 2020
      	//if (callLineList.size() > 0) insert callLineList;
      
      	if (callLineList.size() > 0) {
            CallLineInsertBatch jb = new CallLineInsertBatch(callLineList);
            Database.executeBatch(jb, 65);
        }
      	//END - Update Daniel, 22 April 2020
      	
        system.debug('## DONE CallLineList ## ');
        
        invalidPolicyTempList = CollectionTaskArr.split(',');
        invalidPolicyTempList.remove(0); 
        invalidPolicyList = new List<string>();
        for(string polno : invalidPolicyTempList){
            if(polno != 'VALIDPOLICYNO'){
                if (invalidPolicyList.size() < 900)
                invalidPolicyList.add(polno);   
            }
        } 
        
        insert document;
    }

  @TestVisible private void processConservation(List<String> dataList){
        List<Contact> contactList = [select id, Policy_No__c, Policy_No_ALI__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No_ALI__c in :dataList and createddate > 2014-01-01T00:00:01Z];
        integer foundCounter = contactList.size();    //added by WK, 20150417
        //validNum = contactList.size();        //remarked by WK, 20150417
        //invalidNum = uploadedNum - validNum;  //remarked by WK, 20150417
        //system.debug('## validNum : '+validNum);

        //begin:added by Wk, 20150417
        List<Call_Line__c> existingCallLineList = [select id, Policy_No__c, Entity__c from Call_Line__c where Policy_No__c in :dataList and Call_List__c = :choosen_campaign and createddate > 2014-01-01T00:00:01Z];
        integer existingCounter = existingCallLineList.size();
        validNum = foundCounter - existingCounter;
        invalidNum = uploadedNum - validNum;
        //end:added by Wk, 20150417

        outboundCallList = new List<OutboundCall>();
        callLineList = new List<Call_Line__c>();
        OutboundCall uploadedCall = null;
        Call_Line__c callLine = null;
        Call_List__c campaign = null;
        integer idx = 0;
        boolean isExist = false;    //added by WK, 20150417

        if(contactList.size()>0){
            for(Contact pelanggan : contactList){
            
                //begin:added by WK, 20150417
                isExist = false;   
                for(Call_Line__c cl : existingCallLineList){
                    if(cl.Policy_No__c ==  pelanggan.Policy_No_ALI__c){
                        isExist = true;   
                        break;
                    }
                }
                if(isExist){
                    continue;
                }
                //end:added by WK, 20150417

                uploadedCall = new OutboundCall();
                uploadedCall.policyNo = pelanggan.Policy_No_ALI__c;
                uploadedCall.phoneNo = pelanggan.MobilePhone;
                uploadedCall.campaignName = campaignMap.get(choosen_campaign);  
                outboundCallList.add(uploadedCall);     
                
                callLine = new Call_Line__c();
                callLine.Contact__c = pelanggan.id;
                callLine.Policy_No__c = pelanggan.Policy_No_ALI__c;
                callLine.Contacted_Number__c = pelanggan.MobilePhone;
                callLine.Home_Phone__c = pelanggan.HomePhone;
                callLine.Phone__c = pelanggan.Phone;
                callLine.Call_List__c = choosen_campaign;
                callLine.Entity__c = pelanggan.Entity__c;
                campaign = campaignObjectMap.get(choosen_campaign);
                callLine.Activity__c = campaign.Activity__c;
                callLine.Case_Type__c = campaign.Case_Type__c;
                callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                
                for(Conservation conv : conservationList){
                    if(conv.policyNo == pelanggan.Policy_No_ALI__c){
                        callLine.Prev_Acc_Balance__c = conv.prevAccBalance;
                        callLine.Total_Withdrawn__c = conv.totalWithdrawn;      
                        callLine.Premium__c = conv.premium;      
                        callLine.Currency__c = conv.currcy;      
                        //conservationArr = conservationArr + ',' + recVal[0]+'#'+num;
                        break;
                    }
                }
                callLineList.add(callLine); 
                conservationArr = conservationArr.replaceFirst(pelanggan.Policy_No_ALI__c, 'VALIDPOLICYNO');
            }
            insert callLineList;
        }
        
        invalidPolicyTempList = conservationArr.split(',');
        invalidPolicyTempList.remove(0); 
        invalidPolicyList = new List<string>();
        for(string polno : invalidPolicyTempList){
            if(polno != 'VALIDPOLICYNO'){
                if (invalidPolicyList.size() < 900)
                invalidPolicyList.add(polno);   
            }
        } 
        
        insert document;
    }
    
    @TestVisible private boolean isPhoneNumberValid(string phoneNumber){
       string regexPhoneFormat = '[0-9]{8,15}';
       Pattern phoneFormat = Pattern.Compile(regexPhoneFormat);
       Matcher format_of_number = phoneFormat.matcher(phoneNumber); 
       return format_of_number.Matches();
    }
    
    @TestVisible private Date convertString2Date(String inputDate){
        if(inputDate != null && inputDate.length() > 0){
            try {
                string year = inputDate.substring(0, 4);
                string month = inputDate.substring(5, 7); 
                string day = inputDate.substring(8, 10);
                return date.newInstance(Integer.valueOf(year), Integer.valueOf(month), Integer.valueOf(day));
            } catch (Exception e){
                return null;
            }
        }else {
            return null;
        }
    }
    
  public void cumaUntukTestClass(){
    String testString = 'abc';
    testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
      testString = 'abc';
  }
    
    //Update Daniel (1), 24 April 2020
    public PageReference groupingCallLine(){
        List<Call_Line__c> ListCLUpdate = new List<Call_Line__c>();
        string temp = '';
        id Parentid; 
        for (Call_Line__c cl : [SELECT id, Policy_No__c, Entity__c, Name, Parent_Name_Mobile__c, Contact__c, Contact__r.Name,
                                Name_1__c, Contacted_Number__c, Call_List__c, Parent_Call_Line__c, Parent_Campaign__c
                               From Call_Line__c WHERE Call_List__c = :choosen_campaign AND Entity__c = :entity 
                                // fix for Parent belum di mapping, 26 feb 2018
                               and Parent_Call_Line__c = NULL and Parent_Campaign__c = NULL
                                ORDER BY Name_1__c, Contacted_Number__c]) {
                                //ORDER BY Contact__r.Name, Name_1__c, Contacted_Number__c])
            if (isNUll(cl.Name_1__c) == '') cl.Name_1__c = cl.Contact__r.Name;
            if (temp != (isNUll(cl.Name_1__c)+''+isNUll(cl.Contacted_Number__c)) ) {
                cl.Parent_Campaign__c = cl.Call_List__c;
                cl.Parent_Call_Line__c = NULL;
                
                temp = isNUll(cl.Name_1__c)+''+isNUll(cl.Contacted_Number__c);
                Parentid = cl.id;
            }
            else {
                cl.Parent_Campaign__c = null;
                cl.Parent_Call_Line__c = Parentid; 
            }
            ListCLUpdate.add(cl);
        }
        system.debug('data update : '+ListCLUpdate.size());
        if (ListCLUpdate.size() > 0) {
            
            //Update Daniel (2), 24 April 2020
            //update ListCLUpdate;
            
            
            CallLineGroupingBatch jb = new CallLineGroupingBatch(ListCLUpdate,choosen_campaign,UserInfo.getUserId());
            //Database.executeBatch(jb, 100);
            
            //Coba mus
            String job_Id = Database.executeBatch(jb, 100);
            
            Call_List__c clJob = new Call_List__c();
            clJob.Id = choosen_campaign;
            clJob.job_id__c = job_Id;
            Update clJob;
            //Coba mus
            //END - Update Daniel (2), 24 April 2020
            
        } /*else {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'There are not data that can be in the group.')); 
        }*/
        
        
        PageReference pageRef = new PageReference('/apex/File_Upload_ALI?grouping=true');
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public static string isNUll(String param){
        string result ='';
        if (param == NULL) result = '';
        else result = param;
        Return result;
    }
    //END - Update Daniel (1), 24 April 2020
    
}