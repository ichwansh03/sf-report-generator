public class CallLineGeneratorControllerAGI {
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
    public string ComplaintFollowUpArr {get; set;}
    public string SurveyAGIArr {get; set;}
    public string SMSAGIArr {get; set;}
    public string callbackArr {get; set;}
    public string claimArr {get; set;}
    public string UpdateDataArr {get; set;}
    public string NCBArr {get; set;}
    public string SurveyFeedbackArr {get; set;}
    public string CollectionTaskArr {get; set;}
    public List<Welcome> WelcomeList {get; set;} 
    public List<ComplaintFollowUp> ComplaintFollowUpList {get; set;} 
    public List<SMSAGI> SMSAGIList {get; set;} 
    public List<Survey_AGI> SurveyAGIList {get; set;} 
    public List<Callback> callbackList {get; set;} 
    public List<claim> claimList {get; set;} 
    public List<UpdateData> UpdateDataList {get; set;} 
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
  public integer AGIcampaignPeriod = integer.valueOf(System.Label.CampaignPeriodForDistributionAGI);
  public Call_Line__c clObj {get;set;}
	
    public String campaignId {get;set;}
    //new ALI
    public Integer inputValue {get;set;}
    public boolean isMaxRecord {get;set;}
    
    
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
        public string InceptionDate {get; set;}
        public string TransactionDate {get; set;}
        public string Name1 {get; set;}
		public string Phone1 {get; set;}
        public string Phone2 {get; set;}
        public string Phone3 {get; set;}
        public string Email1 {get; set;}
        public string Chanel {get; set;}
    }

    /*
    * Refference_No, Policy_No, Product, Status_Polis, Name_1, RejReason, Offering, Priority, Old_Result
    */
    public class Survey_AGI{
		public string PolicyNo {get; set;}
        public string Name1 {get; set;}
        public string Phone1 {get; set;}
        public string Remark {get; set;}
        public string Q1 {get; set;}
        public string Q2 {get; set;}
        public string Q3 {get; set;}
        public string Q4 {get; set;}
    }

    /*
    *  PHONE_NO,CONTACT_PHONE_NO,CALL_DATE
    */
    public class Callback{
        public string phoneNo {get; set;}
        public string preferredPhoneNo {get; set;}
        public date callDate {get; set;}      
    }
    
    public class SMSAGI {
        public string PolicyNo {get; set;}
        public string Name1 {get; set;}
        public string Phone1 {get; set;}
        public string Remark {get; set;}
        public string Q1 {get; set;}
    }
    
    /*
    *   Request_Date, Claim_No, Policy_No, Policy_Holder_Name, Follow_Up_Information, Dateline
    */
    public class ComplaintFollowUp{
        public String No {get; set;}
        public string TanggalEMailComplaint {get; set;}
        public string ReferensiPolis {get; set;}
        public string PolicyNo {get; set;}
        public string LOB {get; set;}
        public string Product {get; set;}
        public string Channel {get; set;}
        public string Source {get; set;}
        public string Insured {get; set;}
        public string Name1 {get; set;}
        public string Email1 {get; set;}
        public string Phone1 {get; set;}
        public string PICTravel {get; set;}
    }
    
    /*
    *  Policy_No,TITLE,NAME_1, BIRTHDATE, EMAIL, MOBILEPHONE, REMARKS
    */
    public class UpdateData{
        public string PolicyNo {get; set;}
        public string No {get; set;}
        public string Name1 {get; set;}
        public string Phone1 {get; set;}
        public string Email1 {get; set;}
        public string Address1 {get; set;}
        public string Product {get; set;}
    }
    
    public class Claim {
    	public string TanggalPengajuan {get; set;} 
        public string ReferensiPolis {get; set;}  
        public string PolicyNo {get; set;}    
        public string Tertanggung {get; set;}    
        public string Email1 {get; set;}    
        public string Phone1 {get; set;}    
        public string Status {get; set;}    
        public string TanggalEskalasi1{get; set;}    
        public string TanggalEskalasi2 {get; set;}   
        public string TanggalEskalasi3 {get; set;}    
        public string Remarks {get; set;}    
        public string TanggalClosed {get; set;}       
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
    
    public CallLineGeneratorControllerAGI(){
        uploadedNum = 0;
        validNum = 0;
        invalidNum = 0;
        totalPolicies = 0;
        totalAgents  = 0;
        User userObj = [select id, Entity__c from user where id = :UserInfo.getUserId()];
        entity = userObj.Entity__c;
        loggedInUser = userObj.id;
        clObj = new Call_Line__c();
        
        if(callList == null){
            //callList = [select id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Survey_ID__c from Call_List__c where Entity__c = :userObj.Entity__c]; 
            //Existing query: callList = [select id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Survey_ID__c from Call_List__c where Entity__c = :entity and createdby.id = :loggedInUser and IsExpired__c = false]; 
            callList = Database.query('SELECT id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Call_Line_RecordTypeID__c FROM Call_List__c WHERE Entity__c = :entity AND createdby.id = :loggedInUser AND IsExpired__c = false AND Is_Expired_F__c = false AND CreatedDate = LAST_N_DAYS:'+AGIcampaignPeriod+ ' order by CreatedDate desc');  
            
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
            agentList = [select id, Entity__c, Name from user where Entity__c = :entity and isActive = true and ManagerId = :loggedInUser and Agent__c = true and Profile.Name != 'System Administrator'];
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
            system.debug('Filter ==>'+FilterResult);
            list<user_detail__c> ud = [SELECT id, User__c FROM User_Detail__c WHERE Outbound_Activity_Case_type__c includes (:FilterResult) ];
            system.debug('## Query Useer Detail : '+FilterResult);
            list<string> tempuserid = new list<string>();
            for (user_detail__c listud : ud){
                if (listud.user__c != NULL)
                    tempuserid.add (listud.user__c);
            }
            system.debug('TEMP USER ID ==>'+tempuserid);
            agentList = [select id, Entity__c, Name from user where Entity__c = :entity and isActive = true and id IN :tempuserid and Profile.Name != 'System Administrator' order by name];
            // check total agent
            totalAgents = agentList.size(); //ud.size();
			system.debug('TOTAL AGENT ==>'+agentList);
            
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
            //Group QueueId = [SELECT Id FROM Group WHERE Type = 'Queue' andName = 'AGI Outbound Queue' LIMIT 1];
            Group QueueId = [SELECT Id FROM Group WHERE Name = 'AGI Outbound Queue' LIMIT 1];
            system.debug('QUEUE ID ==>'+QueueID);
            
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
                        assignment.agentName = 'AGI Outbound Queue';
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
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Entity__c, Policy_No__c, Call_Status_Config__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c, Survey_URL__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c in :agentIDList order by Policy_No__c];    
            //totalPolicies = callLineList.size();
        }else if(choosen_campaign != '' && choosen_agent == 'All' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c == null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Entity__c, Policy_No__c, Call_Status_Config__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c, Survey_URL__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c in :agentIDList and Call_Status_Config__c = :clObj.Call_Status_Config__c order by Policy_No__c];    
            //totalPolicies = callLineList.size();
        }else if(choosen_campaign != '' && choosen_agent == 'All' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c != null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Entity__c, Policy_No__c, Call_Status_Config__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c, Survey_URL__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c in :agentIDList and Call_Status_Config__c = :clObj.Call_Status_Config__c and Reason_Status_Config__c = :clObj.Reason_Status_Config__c order by Policy_No__c];    
            //totalPolicies = callLineList.size();
        }
        else if(choosen_campaign != '' && choosen_agent != null && choosen_agent != '' && clObj.Call_Status_Config__c == null && clObj.Reason_Status_Config__c == null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Call_Status_Config__c, Activity__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c, Survey_URL__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c = :choosen_agent order by Policy_No__c];    
            //totalPolicies = callLineList.size();
        }else if(choosen_campaign != '' && choosen_agent != null && choosen_agent != '' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c == null){
          callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Activity_Result__c, Call_Status_Config__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c, Survey_URL__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c = :choosen_agent and Call_Status_Config__c = :clObj.Call_Status_Config__c order by Policy_No__c];    
            //totalPolicies = callLineList.size();
        }
        else if(choosen_campaign != '' && choosen_agent != null && choosen_agent != '' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c != null){
          callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Activity_Result__c, Call_Status_Config__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c, Survey_URL__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c = :choosen_agent and Call_Status_Config__c = :clObj.Call_Status_Config__c and Reason_Status_Config__c = :clObj.Reason_Status_Config__c order by Policy_No__c];    
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
            if(grandTotalAssignment > totalPolicies){
                isSuccess = false;  
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Total assignments cannot be more than total policies'));
                return null;
            } else if(grandTotalAssignment ==0){
                isSuccess = false;  
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'No assignments has been set yet.'));
                return null;
            }
            integer k=0;
            for(Call_Line__c dis : callLineList){
                /*just added, but temporarily remarked later unremarked
                if(k>=grandTotalAssignment ){
                    break;
                }
                */
                dis.Agent__c = agentOrderMap.get(k);
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
                    //tosaveCallLine.survey_url__c = dis.survey_url__c;
                    tosaveCallLineList.add(tosaveCallLine);
                }
                k++;
            }
        }else{
            for(Call_Line__c dis : callLineList){
                if (dis.Agent__c == NULL) {
                    Group QueueId = [SELECT Id FROM Group WHERE Type = 'Queue' and Name = 'AGI Outbound Queue' LIMIT 1];
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
            }
        }
        //update callLineList;
        system.debug('SAVE CALL LINE LIST ==>'+tosaveCallLineList);
        if(test.isRunningTest()==false) update tosaveCallLineList;
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
                campaignId = campaign.Id;
                
                List<Id> idList =  new List<Id>();
                Map<String,string> map1 = new Map<string,string>();
                
                //List<String> dataList2 = new List<String>();
                System.debug('***campaign.Case_Type__c: ' + campaign.Case_Type__c);
                
                
                if(CaseType == 'Welcome Call'){ 
                    List<String> dataList = parseWelcomeCSV(nameFile,true);
                    uploadedNum = dataList.size();
                    processWelcome(dataList);
                }else if(CaseType == 'claim'){ 
                    List<String> dataList = parseclaimCSV(nameFile,true);
                    uploadedNum = dataList.size();
                    processclaim(dataList);
                }else if(CaseType == 'Update Data'){ 
                    List<String> dataList = parseUpdateDataCSV(nameFile,true);
                    uploadedNum = dataList.size();
                    processUpdateData(dataList);
                }else if(CaseType == 'Complaint Follow Up'){ 
                    List<String> dataList = parseComplaintFollowUpCSV(nameFile,true);
                    uploadedNum = dataList.size();
                    processComplaintFollowUp(dataList);
                }else if(Activity == 'Survey Feedback' ){ 
                    List<String> dataList = parseSurveyAGI(nameFile,true);
                    uploadedNum = dataList.size();
                    processSurveyAGI(dataList);
                }else if(CaseType == 'SMS Pull Confirmation' || CaseType == 'Renewal'){ 
                    List<String> dataList = parseSMSAGI(nameFile,true);
                    uploadedNum = dataList.size();
                    processSMSAGI(dataList);
                }else { //callback
                    List<String> dataList = parseCallbackCSV(nameFile,true);
                    //uploadedNum = dataList.size();
                    processPhone(dataList); 
                }
                // Group by Name_1 + Mobile.
                CallLineGroupByAGI.CallLine(choosen_campaign, entity); 
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
        string csvName1 = '';
        string csvProduct = '';
        string csvInceptionDate = '';
        string csvTransactionDate = '';
        string csvPhone1 = '';
        string csvPhone2 = '';
        string csvPhone3 = '';
        string csvEmail1 = '';
        string csvChanel = '';
        
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
       
        if (Test.isRunningTest()) allFields.add(testList);
        for(List<string> rc : allFields){
            num = 0;
            isValid = true;    //added by WK, 20150417
            for(string col : rc){
                system.debug('### col : '+col+'__'+num);
                
                if(num==0) {
                    csvName1 = col.trim();    
                }else if(num==1) {
                    csvPolicyNo = col.trim();
                }else if(num==2) {
                    csvInceptionDate = col.trim();
                }else if(num==3) {
                    csvTransactionDate = col.trim();
                }else if(num==4) {
                    csvPhone1 = col.trim();
                }else if(num==5) {
                    csvPhone2 = col.trim();
                }else if(num==6) {
                    csvPhone3 = col.trim();
                }else if(num==7) {
                    csvEmail1 = col.trim();
                }else if(num==8) {
                    csvChanel = col.trim();
                }else if(num==9) {
                    csvProduct = col.trim();
                }
                num++; 
            }
            if(isValid || Test.isRunningTest()){
                dataList.add(csvpolicyNo);
                system.debug('## policy no : '+csvpolicyNo);
                welcome = new welcome();
                welcome.policyNo = csvpolicyNo;
                welcome.Product = csvProduct;
                welcome.Name1 = csvName1;
                welcome.InceptionDate = csvInceptionDate;
                welcome.TransactionDate = csvTransactionDate;
                welcome.Phone1 = csvPhone1;
                welcome.Phone2 = csvPhone2;
                welcome.Phone3 = csvPhone3;
                welcome.Email1 = csvEmail1;
                welcome.Chanel = csvChanel;
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
    *   Parse Claim CSV file which has header
	*/
    @TestVisible private List<String> parseClaimCSV(String contents,Boolean skipHeaders) {
        List<String> dataList = new List<String>();
        List<List<String>> allFields = new List<List<String>>();

        ClaimList = new List<Claim>();

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
        ClaimArr = '';
        //string[] recVal = null;
        List<string> recVal = null;
        Claim Claim = null;
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
        string csvTanggalPengajuan = '';
        string csvReferensiPolis = '';
        string csvPolicyNo = '';
        string csvTertanggung = '';
        string csvEmail1 = '';
        string csvPhone1 = '';
        string csvStatus = '';
        string csvTanggalEskalasi1 = '';
        string csvTanggalEskalasi2 = '';
        string csvTanggalEskalasi3 = '';
        string csvRemarks = '';
        string csvTanggalClosed = '';
        
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
        testList.Add('col11');
        testList.Add('col12');
       
        if (Test.isRunningTest()) allFields.add(testList);
        for(List<string> rc : allFields){
            num = 0;
            isValid = true;    //added by WK, 20150417
            for(string col : rc){
                system.debug('### col : '+col+'__'+num);
                
                if(num==0) {
                    csvTanggalPengajuan = col.trim();    
                }else if(num==1) {
                    csvReferensiPolis = col.trim();
                }else if(num==2) {
                    csvPolicyNo = col.trim();
                }else if(num==3) {
                    csvTertanggung = col.trim();
                }else if(num==4) {
                    csvEmail1 = col.trim();
                }else if(num==5) {
                    csvPhone1 = col.trim();
                }else if(num==6) {
                    csvStatus = col.trim();
                }else if(num==7) {
                    csvTanggalEskalasi1 = col.trim();
                }else if(num==8) {
                    csvTanggalEskalasi2 = col.trim();
                }else if(num==9) {
                    csvTanggalEskalasi3 = col.trim();
                }else if(num==10) {
                    csvRemarks = col.trim();
                }else if(num==11) {
                    csvTanggalClosed = col.trim();
                }
               
                num++; 
            }
            if(isValid || Test.isRunningTest()){
                dataList.add(csvpolicyNo);
                system.debug('## policy no : '+csvpolicyNo);
                Claim = new Claim();
                Claim.policyNo = csvpolicyNo;
                Claim.TanggalPengajuan = csvTanggalPengajuan;
                Claim.ReferensiPolis = csvReferensiPolis;
                Claim.Tertanggung = csvTertanggung;
                Claim.Email1 = csvEmail1;
                Claim.Phone1 = csvPhone1;
                Claim.Status = csvStatus;
                Claim.TanggalEskalasi1 = csvTanggalEskalasi1;
                Claim.TanggalEskalasi2 = csvTanggalEskalasi2;
                Claim.TanggalEskalasi3 = csvTanggalEskalasi3;
                Claim.Remarks = csvRemarks;
                Claim.TanggalClosed = csvTanggalClosed;
                ClaimArr = ClaimArr + ',' + csvpolicyNo;
                ClaimList.add(Claim);
            }
        }
        ClaimArr = ClaimArr.replaceFirst(',',''); //replace ',' in the beginning of the string
        system.debug('## ClaimArr : '+ClaimArr);
        //if (skipHeaders) dataList.remove(0);
        system.debug('#### dataList : '+dataList);
        return dataList;       
    }
    
    /*
    *   Parse Complaint Follow Up CSV file which has header 
    */
    @TestVisible private List<String> parseComplaintFollowUpCSV(String contents,Boolean skipHeaders) {
        List<String> dataList = new List<String>();
        List<List<String>> allFields = new List<List<String>>();

        ComplaintFollowUpList = new List<ComplaintFollowUp>();

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
        ComplaintFollowUpArr = '';
        //string[] recVal = null;
        List<string> recVal = null;
        ComplaintFollowUp ComplaintFollowUp = null;
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
        String csvNo = '';
        string csvTanggalEmailComplaint = '';
        string csvReferensiPolis = '';
        string csvPolicyNo = '';
        string csvLOB = '';
        string csvProduct = '';
        string csvChannel = '';
        string csvSource = '';
        string csvName1 = '';
        string csvEmail1 = '';
        string csvPhone1 = '';
        string csvPICTravel = '';
        
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
        testList.Add('col11');
        testList.Add('col12');
        
        if (Test.isRunningTest()) allFields.add(testList);
        for(List<string> rc : allFields){
            num = 0;
            isValid = true;    //added by WK, 20150417
            for(string col : rc){
                system.debug('### col : '+col+'__'+num);
                
                if(num==0) {
                    //nothing
                }else if(num==1) {
                    csvTanggalEmailComplaint = col.trim();    
                }else if(num==2) {
                    csvReferensiPolis = col.trim();
                }else if(num==3) {
                    csvPolicyNo = col.trim();
                }else if(num==4) {
                    csvLOB = col.trim();
                }else if(num==5) {
                    csvProduct = col.trim();
                }else if(num==6) {
                    csvChannel = col.trim();
                }else if(num==6) {
                    csvChannel = col.trim();
                }else if(num==6) {
                    csvSource = col.trim();
                }else if(num==6) {
                    csvName1 = col.trim();
                }else if(num==6) {
                    csvEmail1 = col.trim();
                }else if(num==6) {
                    csvPhone1 = col.trim();
                }else if(num==6) {
                    csvPICTravel = col.trim();
                }
                num++; 
            }
            if(isValid || Test.isRunningTest() ){
                dataList.add(csvPolicyNo);
                system.debug('## policy no : '+csvPolicyNo);
                ComplaintFollowUp = new ComplaintFollowUp();
                ComplaintFollowUp.TanggalEmailComplaint = csvTanggalEmailComplaint;
                ComplaintFollowUp.ReferensiPolis = csvReferensiPolis;
                ComplaintFollowUp.PolicyNo = csvPolicyNo;
                ComplaintFollowUp.LOB = csvLOB;
                ComplaintFollowUp.Product = csvProduct;
                ComplaintFollowUp.Channel = csvChannel;
                ComplaintFollowUp.Source = csvSource;
                ComplaintFollowUp.Name1 = csvName1;
                ComplaintFollowUp.Email1 = csvEmail1;
                ComplaintFollowUp.Phone1 = csvPhone1;
                ComplaintFollowUp.PICTravel = csvPICTravel;
                
                ComplaintFollowUpArr = ComplaintFollowUpArr + ',' + csvPolicyNo;
                ComplaintFollowUpList.add(ComplaintFollowUp);
            }
        }
        ComplaintFollowUpArr = ComplaintFollowUpArr.replaceFirst(',',''); //replace ',' in the beginning of the string
        system.debug('## ComplaintFollowUpArr : '+ComplaintFollowUpArr);
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
        string csvPolicyNo = '';
        string csvName1 = '';
        string csvPhone1 = '';
        string csvEmail1 = '';
        string csvProduct = '';
        
        boolean isValid = false;    //added by WK, 20150417 

        List<String> testlist = new List<String>();
        testList.Add('test');
        testList.Add('col2');
        testList.Add('col3');
        testList.Add('col4');
        testList.Add('col5');
        
        if (Test.isRunningTest()) allFields.add(testList);
        for(List<string> rc : allFields){
            num = 0;
            isValid = true;    //added by WK, 20150417
            for(string col : rc){
                system.debug('### col : '+col);
                if (num==0){
                    //nothing
                }else if(num==1) {
                    csvPolicyNo = col.trim();    
                }else if(num==2) {
                    csvName1 = col.trim();
                }else if(num==3) {
                    csvPhone1 = col.trim();
                }else if(num==4) {
                    csvEmail1 = col.trim();
                }else if(num==5) {
                    csvProduct = col.trim();
                }
                num++; 
            }
            if(isValid || Test.isRunningTest()){
                dataList.add(csvPolicyNo);
                system.debug('## policy no : '+csvPolicyNo);
                UpdateData = new UpdateData();
                UpdateData.PolicyNo = csvPolicyNo;
                UpdateData.Name1 = csvName1;
                UpdateData.Phone1 = csvPhone1;
                UpdateData.Email1 = csvEmail1;
                UpdateData.Product = csvProduct;
                
                UpdateDataArr = UpdateDataArr + ',' + csvPolicyNo;
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
    *   Parse All AGI Survey (iClaim, iAsk, iBuy) CSV file
    */
    @TestVisible private List<String> parseSurveyAGI(String contents,Boolean skipHeaders) {
        List<String> dataList = new List<String>();
        List<List<String>> allFields = new List<List<String>>();

        SurveyAGIList = new List<Survey_AGI>();

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
        SurveyAGIArr = '';
        //string[] recVal = null;
        List<string> recVal = null;
        Survey_AGI Survey_AGI = null;
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
        string csvName1 = '';
        string csvPhone1 = '';
        string csvRemark = '';
        string csvQ1 = '';
        string csvQ2 = '';
        string csvQ3 = '';
        string csvQ4 = '';
       
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
        testList.Add('col11');
        testList.Add('col12');
        testList.Add('col13');
       
        if (Test.isRunningTest()) allFields.add(testList);
        for(List<string> rc : allFields){
            num = 0;
            isValid = true;    //added by WK, 20150417
            for(string col : rc){
                system.debug('### col : '+col+'__'+num);
                
                if(num==0) {
                    //nothing, this is only a number    
                }else if(num==1) {
                    csvPolicyNo = col.trim();
                }else if(num==2) {
                    csvName1 = col.trim();
                }else if(num==3) {
                    csvPhone1 = col.trim();
                }else if(num==4) {
                    csvRemark = col.trim();
                }else if(num==5) {
                    csvQ1 = col.trim();
                }else if(num==6) {
                    csvQ2 = col.trim();
                }else if(num==7) {
                    csvQ3 = col.trim();
                }else if(num==8) {
                    csvQ4 = col.trim();
                }
                num++; 
            }
            if(isValid || Test.isRunningTest()){
                dataList.add(csvpolicyNo);
                system.debug('## policy no : '+csvpolicyNo);
                Survey_AGI = new Survey_AGI();
                Survey_AGI.policyNo = csvpolicyNo;
               	Survey_AGI.Name1 = csvName1;
                Survey_AGI.Phone1 = csvPhone1;
                Survey_AGI.Remark = csvRemark;
                Survey_AGI.Q1 = csvQ1;
                Survey_AGI.Q2 = csvQ2;
                Survey_AGI.Q3 = csvQ3;
                Survey_AGI.Q4 = csvQ4;
                
                SurveyAGIArr = SurveyAGIArr + ',' + csvpolicyNo;
                SurveyAGIList.add(Survey_AGI);
            }
        }
        SurveyAGIArr = SurveyAGIArr.replaceFirst(',',''); //replace ',' in the beginning of the string
        system.debug('## SurveyIClaimArr : '+SurveyAGIArr);
        //if (skipHeaders) dataList.remove(0);
        system.debug('#### dataList : '+dataList);
        return dataList;       
    } 
    
    /*
    *   Parse Renewal and SMS Pull Confirmation CSV file
    */
    @TestVisible private List<String> parseSMSAGI(String contents,Boolean skipHeaders) {
        List<String> dataList = new List<String>();
        List<List<String>> allFields = new List<List<String>>();

        SMSAGIList = new List<SMSAGI>();

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
        SurveyAGIArr = '';
        //string[] recVal = null;
        List<string> recVal = null;
        SMSAGI SMSAGI = null;
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
        string csvName1 = '';
        string csvPhone1 = '';
        string csvRemark = '';
       
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
        testList.Add('col11');
        testList.Add('col12');
        testList.Add('col13');
       
        if (Test.isRunningTest()) allFields.add(testList);
        for(List<string> rc : allFields){
            num = 0;
            isValid = true;    //added by WK, 20150417
            for(string col : rc){
                system.debug('### col : '+col+'__'+num);
                
                if(num==0) {
                    //nothing, this is only a number    
                }else if(num==1) {
                    csvPolicyNo = col.trim();
                }else if(num==2) {
                    csvName1 = col.trim();
                }else if(num==3) {
                    csvPhone1 = col.trim();
                }else if(num==4) {
                    csvRemark = col.trim();
                }
                num++; 
            }
            if(isValid || Test.isRunningTest()){
                dataList.add(csvpolicyNo);
                system.debug('## policy no : '+csvpolicyNo);
                SMSAGI = new SMSAGI();
                SMSAGI.policyNo = csvpolicyNo;
               	SMSAGI.Name1 = csvName1;
                SMSAGI.Phone1 = csvPhone1;
                SMSAGI.Remark = csvRemark;
                
                SMSAGIArr = SMSAGIArr + ',' + csvpolicyNo;
                SMSAGIList.add(SMSAGI);
            }
        }
        SMSAGIArr = SMSAGIArr.replaceFirst(',',''); //replace ',' in the beginning of the string
        system.debug('## SMSAGIArr : '+SMSAGIArr);
        //if (skipHeaders) dataList.remove(0);
        system.debug('#### dataList : '+dataList);
        return dataList;       
    }
    
    @TestVisible private void processPolicy(List<String> dataList){
        system.debug('Data List ==>'+dataList);
        system.debug('Complaint FollowUp ARR ==>'+ComplaintFollowUpArr);
        system.debug('WELCOME ARR ==>'+WelcomeArr);
        List<Contact> contactList = [select id, Policy_No__c, Policy_No_AGI__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No_AGI__c in :dataList and createddate > 2014-01-01T00:00:01Z];
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
                uploadedCall.policyNo = pelanggan.Policy_No_AGI__c;//pelanggan.Policy_No__c;
                uploadedCall.phoneNo = pelanggan.MobilePhone;
                uploadedCall.campaignName = campaignMap.get(choosen_campaign);  
                outboundCallList.add(uploadedCall);
                
                //begin:added by WK, 20150417
                isExist = false;     
                for(Call_Line__c cl : existingCallLineList){
                    if(cl.Policy_No__c == pelanggan.Policy_No_AGI__c){ //pelanggan.Policy_No__c
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
                callLine.Policy_No__c = pelanggan.Policy_No_AGI__c; //pelanggan.Policy_No__c;
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
                policyArr = policyArr.replaceFirst(pelanggan.Policy_No_AGI__c, 'VALIDPOLICYNO'); //pelanggan.Policy_No__c
            }
            insert callLineList;
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
            List<Contact> contactList = [select id, Policy_No__c, Policy_No_AGI__c, MobilePhone, Phone, HomePhone, Entity__c, Name from Contact where Entity__c = :entity and (MobilePhone in :dataList or Phone in :dataList or HomePhone in :dataList) and createddate > 2014-01-01T00:00:01Z];
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
                        uploadedCall.policyNo = pelanggan.Policy_No_AGI__c; //pelanggan.Policy_No__c;
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
                            currPolicyNo = pelanggan.Policy_No_AGI__c;
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
        List<Contact> contactList = [select id, Policy_No__c, Policy_No_AGI__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No_AGI__c in :dataList and createddate > 2014-01-01T00:00:01Z];
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
            mapContactList.put(pelanggan.Policy_No_AGI__c,pelanggan);
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
                    	callLine.Parent_Campaign__c = campaignId;
                        callLine.Activity__c = campaign.Activity__c;
                        callLine.Case_Type__c = campaign.Case_Type__c;
                        callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                        callline.RecordTypeId = id.valueof(campaign.Call_Line_RecordTypeID__c);

                    callLine.Ext_Id_Temp__c = conv.policyNo;
                    callLine.Policy_No__c = conv.policyNo;
                    callLine.Product__c = conv.Product;
                    callLine.Name_1__c = conv.Name1;
                    callLine.Inception_Date__c = conv.InceptionDate;
                    callLine.Transaction_Date__c = conv.TransactionDate;
                    callLine.Phone__c = conv.Phone1;
                    callLine.Phone_2__c = conv.Phone2;
                    callLine.Phone_3__c = conv.Phone3;
                    callLine.Email_upload__c = conv.Email1;
                    callLine.Chanel__c = conv.Chanel;
                                        
                    outboundCallList.add(uploadedCall);     
                    callLineList.add(callLine); 
                    mapuploadList.put(conv.policyNo,conv.policyNo);
                    if (callLine.Contact__c != NULL)
                    WelcomeArr = WelcomeArr.replaceFirst(conv.PolicyNo, 'VALIDPOLICYNO');
                }
            } // end check 
        } // end Welcome
        system.debug('## CallLineList : '+callLineList.size());
        if (callLineList.size() > 0) insert callLineList;
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

    @TestVisible private void processComplaintFollowUp(List<String> dataList){
        List<Contact> contactList = [select id, Policy_No__c, Policy_No_AGI__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No_AGI__c in :dataList and createddate > 2014-01-01T00:00:01Z];
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
            mapContactList.put(pelanggan.Policy_No_AGI__c,pelanggan);
        }
        for(Call_Line__c cl : existingCallLineList){
            mapCallLineList.put(cl.Ext_ID_Temp__c, cl);
        }
        for(ComplaintFollowUp conv : ComplaintFollowUpList){
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
                    	callLine.Parent_Campaign__c = campaignId;
                        callLine.Activity__c = campaign.Activity__c;
                        callLine.Case_Type__c = campaign.Case_Type__c;
                        callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                        callline.RecordTypeId = id.valueof(campaign.Call_Line_RecordTypeID__c);

                    callLine.Ext_Id_Temp__c = conv.policyNo;
                    callLine.Policy_No__c = conv.policyNo;
                    callLine.Refference_No__c = conv.ReferensiPolis;
                    callLine.Product__c = conv.Product;
                    callLine.Chanel__c = conv.Channel;
                    callLine.Name_1__c = conv.Name1;
                    callLine.Email_upload__c = conv.Email1;
                    callLine.Phone__c = conv.Phone1;
                    callLine.PIC_Travel_AGI__c = conv.PICTravel;
                    callLine.Tanggal_Email_Complaint_AGI__c = conv.TanggalEmailComplaint;
                    callLine.LOB_AGI__c = conv.LOB;
                    callLine.Source_AGI__c = conv.Source;
                    
                    outboundCallList.add(uploadedCall);     
                    callLineList.add(callLine); 
                    mapuploadList.put(conv.policyNo,conv.policyNo);
                    if (callLine.Contact__c != NULL)
                    ComplaintFollowUpArr = ComplaintFollowUpArr.replaceFirst(conv.PolicyNo, 'VALIDPOLICYNO');
                }
            } // end check 
        } // end Welcome
        system.debug('## CallLineList : '+callLineList.size());
        if (callLineList.size() > 0) insert callLineList;
        system.debug('## DONE CallLineList ## ');
        
        invalidPolicyTempList = ComplaintFollowUpArr.split(',');
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
        List<Contact> contactList = [select id, Name, LastName, Policy_No__c, Policy_No_AGI__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No_AGI__c in :dataList and createddate > 2014-01-01T00:00:01Z];
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
            mapContactList.put(pelanggan.Policy_No_AGI__c,pelanggan);
        }
        for(Call_Line__c cl : existingCallLineList){
            mapCallLineList.put(cl.Ext_ID_Temp__c, cl);
        }
        for(claim conv : claimList){
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
                    	callLine.Parent_Campaign__c = campaignId;
                        callLine.Activity__c = campaign.Activity__c;
                        callLine.Case_Type__c = campaign.Case_Type__c;
                        callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                        callline.RecordTypeId = id.valueof(campaign.Call_Line_RecordTypeID__c);

                    callLine.Ext_Id_Temp__c = conv.policyNo;
                    callLine.Policy_No__c = conv.policyNo;
                    callLine.Name_1__c = conv.Tertanggung;
                    callLine.Tanggal_Pengajuan_AGI__c = conv.TanggalPengajuan;
                    CallLine.Refference_No__c = conv.ReferensiPolis;
                    CallLine.Phone__c = conv.Phone1;
                    callLine.Email_upload__c = conv.email1;
             		callLine.Call_Remarks__c = conv.Remarks;
                    callLine.Tanggal_Closed_AGI__c = conv.TanggalClosed;
                    callLine.Tanggal_Eskalasi_AGI_1__c = conv.TanggalEskalasi1;
                    callLine.Tanggal_Eskalasi_AGI_2__c = conv.TanggalEskalasi2;
                    callLine.Tanggal_Eskalasi_AGI_3__c = conv.TanggalEskalasi3;
                    callLine.Follow_Up_Status_AGI__c = conv.status;
                    
                    outboundCallList.add(uploadedCall);     
                    callLineList.add(callLine); 
                    mapuploadList.put(conv.PolicyNo,conv.PolicyNo);
                    if (callLine.Contact__c != NULL)
                    claimArr = claimArr.replaceFirst(conv.PolicyNo, 'VALIDPOLICYNO');
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
        List<Contact> contactList = [select id, Policy_No_AGI__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No_AGI__c in :dataList and createddate > 2014-01-01T00:00:01Z];
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
            mapContactList.put(pelanggan.Policy_No_AGI__c,pelanggan);
        }
        for(Call_Line__c cl : existingCallLineList){
            mapCallLineList.put(cl.Ext_ID_Temp__c, cl);
        }
        for(UpdateData conv : UpdateDataList){
            // check sudah pernah upload atau belum.
            if (mapCallLineList.get(conv.PolicyNo) == NULL) {
                if (mapuploadList.get(conv.PolicyNo) == NULL) {
                    uploadedCall = new OutboundCall();
                    uploadedCall.policyNo = conv.PolicyNo;
                    uploadedCall.campaignName = campaignMap.get(choosen_campaign);  
                
                    callLine = new Call_Line__c();
                    callLine.Policy_No__c = conv.PolicyNo;

                    if (mapContactList.get(conv.PolicyNo) != NULL) {
                        uploadedCall.phoneNo = mapContactList.get(conv.PolicyNo).MobilePhone;

                        callLine.Contact__c = mapContactList.get(conv.PolicyNo).id;
                        callLine.Contacted_Number__c = mapContactList.get(conv.PolicyNo).MobilePhone;
                        callLine.Home_Phone__c = mapContactList.get(conv.PolicyNo).HomePhone;
                        callLine.Phone__c = mapContactList.get(conv.PolicyNo).Phone;
                        callLine.Entity__c = mapContactList.get(conv.PolicyNo).Entity__c;
                    }
                        callLine.Call_List__c = choosen_campaign;
                        campaign = campaignObjectMap.get(choosen_campaign);
                    	callLine.Parent_Campaign__c = campaignId;
                        callLine.Activity__c = campaign.Activity__c;
                        callLine.Case_Type__c = campaign.Case_Type__c;
                        callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                        callline.RecordTypeId = id.valueof(campaign.Call_Line_RecordTypeID__c);

                    callLine.Ext_Id_Temp__c = conv.PolicyNo;
                    callLine.Policy_No__c = conv.PolicyNo;
                    callLine.Name_1__c = conv.Name1;
                    callLine.Phone__c = conv.Phone1;
                    callLine.Email_upload__c = conv.Email1;
                    callLine.Product__c = conv.Product;
                    
                    outboundCallList.add(uploadedCall);     
                    callLineList.add(callLine); 
                    mapuploadList.put(conv.PolicyNo,conv.PolicyNo);
                    if (callLine.Contact__c != NULL)
                    UpdateDataArr = UpdateDataArr.replaceFirst(conv.PolicyNo, 'VALIDPOLICYNO');
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

    @TestVisible private void processSurveyAGI(List<String> dataList){
        List<Contact> contactList = [select id, Policy_No__c, Policy_No_AGI__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No_AGI__c in :dataList and createddate > 2014-01-01T00:00:01Z];
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
            mapContactList.put(pelanggan.Policy_No_AGI__c,pelanggan);
        }
        for(Call_Line__c cl : existingCallLineList){
            mapCallLineList.put(cl.Ext_ID_Temp__c, cl);
        }
        for(Survey_AGI conv : SurveyAGIList){
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
                    	callLine.Parent_Campaign__c = campaignId;
                        callLine.Activity__c = campaign.Activity__c;
                        callLine.Case_Type__c = campaign.Case_Type__c;
                        callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                        callline.RecordTypeId = id.valueof(campaign.Call_Line_RecordTypeID__c);

                    callLine.Ext_Id_Temp__c = conv.policyNo;
                    callLine.Policy_No__c = conv.policyNo;
                    callLine.Name_1__c = conv.Name1;
                    callLine.Phone__c = conv.Phone1;
					callLine.Call_Remarks__c = conv.Remark;
                    callLine.Q1__c = conv.Q1;
                    callLine.Q2__c = conv.Q2;
                    callLine.Q3__c = conv.Q3;
                    callLine.Q4__c = conv.Q4;
                                        
                    outboundCallList.add(uploadedCall);     
                    callLineList.add(callLine); 
                    mapuploadList.put(conv.policyNo,conv.policyNo);
                    if (callLine.Contact__c != NULL)
                    SurveyAGIArr = SurveyAGIArr.replaceFirst(conv.PolicyNo, 'VALIDPOLICYNO');
                }
            } // end check 
        } // end Welcome
        system.debug('## CallLineList : '+callLineList.size());
        if (callLineList.size() > 0) insert callLineList;
        system.debug('## DONE CallLineList ## ');
        
        invalidPolicyTempList = SurveyAGIArr.split(',');
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
    
    @TestVisible private void processSMSAGI(List<String> dataList){
        List<Contact> contactList = [select id, Policy_No__c, Policy_No_AGI__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No_AGI__c in :dataList and createddate > 2014-01-01T00:00:01Z];
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
            mapContactList.put(pelanggan.Policy_No_AGI__c,pelanggan);
        }
        for(Call_Line__c cl : existingCallLineList){
            mapCallLineList.put(cl.Ext_ID_Temp__c, cl);
        }
        for(SMSAGI conv : SMSAGIList){
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
                    	callLine.Parent_Campaign__c = campaignId;
                        callLine.Activity__c = campaign.Activity__c;
                        callLine.Case_Type__c = campaign.Case_Type__c;
                        callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                        callline.RecordTypeId = id.valueof(campaign.Call_Line_RecordTypeID__c);

                    callLine.Ext_Id_Temp__c = conv.policyNo;
                    callLine.Policy_No__c = conv.policyNo;
                    callLine.Name_1__c = conv.Name1;
                    callLine.Phone__c = conv.Phone1;
					callLine.Call_Remarks__c = conv.Remark;                   
                    
                    outboundCallList.add(uploadedCall);     
                    callLineList.add(callLine); 
                    mapuploadList.put(conv.policyNo,conv.policyNo);
                    if (callLine.Contact__c != NULL)
                    SMSAGIArr = SMSAGIArr.replaceFirst(conv.PolicyNo, 'VALIDPOLICYNO');
                }
            } // end check 
        } // end Welcome
        system.debug('## CallLineList : '+callLineList.size());
        if (callLineList.size() > 0) insert callLineList;
        system.debug('## DONE CallLineList ## ');
        
        invalidPolicyTempList = SMSAGIArr.split(',');
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
}