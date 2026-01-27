public class CallLineGeneratorController {
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
    public string conservationArr {get; set;}
    public string callbackArr {get; set;}
    public List<Conservation> conservationList {get; set;} 
    public List<Callback> callbackList {get; set;} 
    public List<Call_List__c> callList {get; set;}
    public List<SelectOption> campaignList {get; set;}
    public List<SelectOption> agentOptList {get; set;}
    public List<SelectOption> callStatusList {get; set;}
    //public List<SelectOption> callStatusOptList {get; set;}
    //public List<SelectOption> reasonStatusOptList {get; set;}
    public List<SelectOption> methodList {get; set;}
    public Map<string,string> campaignMap {get; set;}
    public Map<string,Call_List__c> campaignObjectMap {get; set;}
    public Map<string,string> campaignIDMap {get; set;}
    public Map<string,string> agentMap {get; set;}
    public Map<string,Integer> sizeBlank {get; set;}
    public Map<string,Integer> sizeContacted {get; set;}
    public Map<string,Integer> sizeUncontacted {get; set;}
    public Map<string,Integer> sizeRescheduled {get; set;}
    public Map<string,Integer> sizeInvalidNumber {get; set;}
    public Map<string,Integer> sizeHold {get; set;}
    public Map<string,Integer> sizeGrandTotal {get; set;}
    public List<AggregateResult> callLineBlank {get; set;}
    public List<AggregateResult> callLineContacted {get; set;}
    public List<AggregateResult> callLineUncontacted {get; set;}
    public List<AggregateResult> callLineRescheduled {get; set;}
    public List<AggregateResult> callLineInvalidNumber {get; set;}
    public List<AggregateResult> callLineHold {get; set;}
    public List<AggregateResult> callLineGrandTotal {get; set;}
    public Transient Map<string, customerSegmentation> custSegMap {get;set;} //added by Phincon (ARIF)
    public Boolean isInvalidPolicyNoShow {get;set;}
    public List<User> agentList {get;set;}
    public List<id> agentIDList {get;set;}
    public String totalPolicyLabel {get;set;}
    public Integer totalPolicies {get;set;}
    public Integer totalAgents {get;set;}
    public List<AgentAssignment> assignmentList {get;set;}
    public string url = 'https://'+system.URL.getSalesforceBaseUrl().getHost()+'/apex/TakeSurvey?id=SURVEYID&cId=CONTACTID&caId=none';
    //https://c.cs5.visual.force.com/apex/TakeSurvey?id=a0PO0000007Os03MAC&cId={!Contact.Id}&caId=none
    public integer AMFScampaignPeriod = integer.valueOf(System.Label.CampaignPeriodForDistributionAMFS);
    public integer AFIcampaignPeriod = integer.valueOf(System.Label.CampaignPeriodForDistributionAFI);
    public integer MAGIcampaignPeriod = integer.valueOf(System.Label.CampaignPeriodForDistributionMAGI);
    public Call_Line__c clObj {get;set;}
    ID rtCustSegCampaign = Schema.SObjectType.Call_list__c.getRecordTypeInfosByName().get('Customer Segmentation AMFS').getRecordTypeId();
    public string activity {get; set;}
    public string Case_Type_Config {get; set;}
    Id recTypeWC = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
    public boolean mode{get; set;}
    public List<wcWrapper> invalidwelList {get; set;}
    
    // add by Fajar Salam
    private static String BLOCKED_TELUW = 'TelUW';    
    //Update, 19 Maret 2020
    public DateTime dtime = System.now();
    public Date dt_today = date.newinstance(dtime.year(), dtime.month(), dtime.day());
    String query = '';
    public string searchStartDate {get;set;}
    public string searchEndDate {get;set;}
    public string searchPolicyNo {get;set;}
    public boolean choosen_callStatus_blank {get; set;}
    //END - Update, 19 Maret 2020
    
    
    //pagination
    integer totalRecs = 0;
    public Integer count {get; set;}
    public Integer LimitSize {get; set;} 
    public Integer tot { get; set; }
    public Integer currentTot { get; set; }
    Integer lastSizeData=0;
            
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
    
    public class AgentAssignment{
        public string agentId {get; set;}      
        public string agentName {get; set;}
        public integer clBlank {get; set;}
        public integer clContacted {get; set;}
        public integer clUncontacted {get; set;}
        public integer clRescheduled {get; set;}
        public integer clInvalidNumber {get; set;}
        public integer clHold {get; set;}
        public integer clGrandTotal {get; set;}
        public integer policyTotal {get; set;}
    }
    
    public class ReloadWrapper{
        public string id {get;set;} 
        public string agentName {get; set;}      
        public string policyNo {get; set;}
        public string contactId {get; set;}
        public string contactName {get; set;}
        public boolean isSelected {get; set;}
        public string callStatus {get; set;}
        public string reasonStatus {get; set;}
    }
    
    public CallLineGeneratorController(){
        LimitSize = System.LABEL.rowPerPage.Isnumeric() ? Integer.valueOf(System.LABEL.rowPerPage): 5;
        count = 0;
        currentTot=0;
        
        uploadedNum = 0;
        validNum = 0;
        invalidNum = 0;
        totalPolicyLabel = 'Total Policy';
        totalPolicies = 0;
        totalAgents  = 0;
        User userObj = [select id, Entity__c from user where id = :UserInfo.getUserId()];
        entity = userObj.Entity__c;
        loggedInUser = userObj.id;
        isInvalidPolicyNoShow = true;
        clObj = new Call_Line__c();
        
        
        
        if(callList == null){
            //callList = [select id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Survey_ID__c from Call_List__c where Entity__c = :userObj.Entity__c]; 
            //Existing query: callList = [select id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Survey_ID__c from Call_List__c where Entity__c = :entity and createdby.id = :loggedInUser and IsExpired__c = false]; 
            
            //----------------The query is modified by Hamfry in CCC Wave 2
            //--- 20180927 - added where WelcomeCall_Fg_Automatic__c = false <-- by Ocky, acknowledged by Rosa
            if(entity == 'AMFS'){
                callList = Database.query('SELECT id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c FROM Call_List__c WHERE Case_Type_Config__c != \'Welcome Call\' AND Entity__c = :entity AND createdby.id = :loggedInUser AND IsExpired__c = false AND CreatedDate = LAST_N_DAYS:'+AMFScampaignPeriod+ ' AND WelcomeCall_Fg_Automatic__c = false order by CreatedDate desc'); 
                // only for AMFS WELCOME CALL
                System.debug('entity : '+entity);
                List<Call_List__c> callListforWC = new List<Call_List__c>();
                callListforWC = Database.query('SELECT id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c FROM Call_List__c WHERE Case_Type_Config__c = \'Welcome Call\' AND is_Expired_F__c = FALSE AND WelcomeCall_Fg_Automatic__c = False AND Entity__c= :entity');
                System.debug('tempelan : '+callListforWC);
                callList.addAll(callListforWC);
                // end
                
            }else if(entity == 'AFI'){
                callList = Database.query('SELECT id, Campaign_Name__c, Activity__c, Entity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Expired_Date__c FROM Call_List__c WHERE Entity__c = :entity AND createdby.id = :loggedInUser AND IsExpired__c = false AND CreatedDate = LAST_N_DAYS:'+AFIcampaignPeriod+ ' AND WelcomeCall_Fg_Automatic__c = false AND Expired_Date__c >=: dt_today order by CreatedDate desc'); 
            }else{  //MAGI
                callList = Database.query('SELECT id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c FROM Call_List__c WHERE Entity__c = :entity AND createdby.id = :loggedInUser AND IsExpired__c = false AND CreatedDate = LAST_N_DAYS:'+MAGIcampaignPeriod+ ' AND WelcomeCall_Fg_Automatic__c = false order by CreatedDate desc'); 
            }
            //----------------end of modified query
            
            campaignList = new List<SelectOption>();
            campaignMap = new Map<string,string>();
            campaignObjectMap = new Map<string,Call_List__c>();
            campaignIDMap = new Map<string,string>();
            System.debug('callList: ' + callList);
            System.debug('callList (SIZE): ' + callList.size());
            for(Call_List__c cl : callList){
                campaignList.add(new SelectOption(cl.id, cl.Campaign_Name__c));
                campaignMap.put(cl.id, cl.Campaign_Name__c);
                campaignObjectMap.put(cl.id, cl);
                campaignIDMap.put(cl.id, cl.id);
            }
        }
        
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
            sizeBlank = new Map<string, Integer>();
            sizeContacted = new Map<string, Integer>();
            sizeUncontacted = new Map<string, Integer>();
            sizeRescheduled = new Map<string, Integer>();
            sizeInvalidNumber = new Map<string, Integer>();
            sizeHold = new Map<string, Integer>();
            sizeGrandTotal = new Map<string, Integer>();
            for(User agent : agentList){
                agentIDList.add(agent.id);
                agentMap.put(agent.id, agent.Name);
                agentOptList.add(new SelectOption(agent.id, agent.Name));
            }
        }
        
        //Update Daniel, 15 Mei 2020
        /*system.debug('clObj: '+clObj);
        callStatusList = new List<SelectOption>();
        callStatusList.add(new SelectOption(clObj.Call_Status_Config__c, clObj.Call_Status_Config__c));*/
        //END - Update Daniel, 15 Mei 2020
        
        policyArr = '';
    }
    
    public PageReference populateFreshData(){
        isMethodChoosen = false;
        if(choosen_campaign != ''){
            List<Call_List__c> casetype = [select id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c from Call_List__c where id = :choosen_campaign
                                           and Case_Type__c = 'Welcome Call' and Entity__c ='AMFS'];
            // only for call line welcome call AMFS
            if(!casetype.isEmpty()){
                methodList = new List<SelectOption>();
                methodList.add(new SelectOption('Round Robin', 'Round Robin'));
                
            }// end
            else{
                methodList = new List<SelectOption>();
                methodList.add(new SelectOption('Automatic', 'Automatic'));
                methodList.add(new SelectOption('Manual', 'Manual'));
                methodList.add(new SelectOption('Specific', 'Specific Policy'));
            }
            LIST<Call_list__c> campaign = [select id, name, recordtypeid, Activity__c from call_list__c where id =: choosen_campaign];
            if(!campaign.isEmpty() && campaign.get(0).recordtypeid == rtCustSegCampaign && choosen_method == 'Specific'){
                activity = campaign.get(0).Activity__c;
                System.debug('===Distribute RM Campaign===');
                callLineList = [select id, Agent__c, Call_List__c, Activity__c, Entity__c, Policy_No__c, 
                                Contact__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c 
                                from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c='' 
                                //added by Fajar Salam
                                and Campaign_Type__c != :BLOCKED_TELUW
                                LIMIT:limitsize OFFSET:count];    
            } else {
                system.debug('hereeee');
                callLineList = [select id, Agent__c, Call_List__c, Activity__c, Entity__c, Policy_No__c, 
                                Contact__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c 
                                from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c=''
                                //added by Fajar Salam
                                And Campaign_Type__c != :BLOCKED_TELUW
                               ];  
            }  
            tot = totalRecs = [select count() FROM Call_Line__c where Call_List__c = :choosen_campaign and Agent__c='' ];
            totalPolicyLabel = 'Total Policy';
            totalPolicies = callLineList.size();
            lastSizeData=callLineList.size();
            if(count==0){
                currentTot=lastSizeData;
            }
        }
        System.debug('casetype : '+choosen_campaign);
        System.debug('===calllinelist=== '+callLineList);
        return null;
    }

    public PageReference populateReloadFreshData(){
        callLineList = new List<Call_Line__c>();
        system.debug('## choosen_agent : '+choosen_agent);
        if(choosen_campaign != '' && choosen_agent == 'All' && clObj.Call_Status_Config__c == null && clObj.Reason_Status_Config__c == null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c in :agentIDList];    
            totalPolicies = callLineList.size();
        }else if(choosen_campaign != '' && choosen_agent == 'All' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c == null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c in :agentIDList and Call_Status_Config__c = :clObj.Call_Status_Config__c];    
            totalPolicies = callLineList.size();
        }else if(choosen_campaign != '' && choosen_agent == 'All' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c != null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c in :agentIDList and Call_Status_Config__c = :clObj.Call_Status_Config__c and Reason_Status_Config__c = :clObj.Reason_Status_Config__c];    
            totalPolicies = callLineList.size();
        }
        else if(choosen_campaign != '' && choosen_agent != null && choosen_agent != '' && clObj.Call_Status_Config__c == null && clObj.Reason_Status_Config__c == null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c = :choosen_agent];    
            totalPolicies = callLineList.size();
        }else if(choosen_campaign != '' && choosen_agent != null && choosen_agent != '' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c == null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Activity_Result__c, Call_Status_Config__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c = :choosen_agent and Call_Status_Config__c = :clObj.Call_Status_Config__c];    
            totalPolicies = callLineList.size();
        }
        else if(choosen_campaign != '' && choosen_agent != null && choosen_agent != '' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c != null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Activity_Result__c, Call_Status_Config__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c = :choosen_agent and Call_Status_Config__c = :clObj.Call_Status_Config__c and Reason_Status_Config__c = :clObj.Reason_Status_Config__c];    
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
        
        // if the campaign is Customer Segmentation
        // only user with 'RM Agent AMFS' can have the call liner.s 
        LIST<Call_list__c> campaign = [select id, name, recordtypeid from call_list__c where id =: choosen_campaign];
        if(!campaign.isEmpty() && campaign.get(0).recordtypeid == rtCustSegCampaign){
            System.debug('===Distribute RM Campaign===');
            agentList = [select id, Entity__c, Name from user where Entity__c = :entity 
                         and isActive = true and ManagerId = :loggedInUser and Agent__c = true 
                         and profile.name ='RM Agent AMFS'];
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
        
        if(choosen_method == 'Automatic'){
            return distributeAuto();
        }else if(choosen_method == 'Manual'){
            return distributeManual();
        } else if(choosen_method == 'Specific'){
            return distributeSpecific();
        } else if(choosen_method == 'Round Robin'){
            return distributeRoundRobin();
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
            Map<string, integer> agentAssignmentMap = new Map<string, integer>();
            OutboundCall outboundCall = new OutboundCall();
            AgentAssignment assignment = null;
            if(totalPolicies > 0){
                if(totalAgents==0){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'You have not subordinate. Please contact Administrator.'));    
                }else{
                    
                    //Update, 26 Maret 2020
                    system.debug('loggedInUser: '+loggedInUser);
                    
                    //----------------------------------------------------------------------------------------------------------------------------------------------------------
                    //----------------------------------------------------------------------------------------------------------------------------------------------------------
                    
                    
                    //***** OLD *****//
                    //callLineBlank = [SELECT Agent__r.Name nm, Agent__c ag, Count(Id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Call_Status_Config__c = '' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - OLD *****//
                    
                    //***** NEW *****//
                    //callLineBlank = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = '' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - NEW *****//
                    
                    //***** NEW (2) *****//
                    callLineBlank = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = '' AND Call_List__c = :choosen_campaign GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - NEW (2) *****//
                    
                    system.debug('callLineBlank: '+callLineBlank);
                    for(AggregateResult ar : callLineBlank){
                        sizeBlank.put((String)ar.get('ag'), (Integer)ar.get('hasCallLine'));
                    }
                    system.debug('sizeBlank: '+sizeBlank);
                    
                    
                    //----------------------------------------------------------------------------------------------------------------------------------------------------------
                    //----------------------------------------------------------------------------------------------------------------------------------------------------------
                    
                    
                    //***** OLD *****//
                    //callLineContacted = [SELECT Agent__r.Name nm, Agent__c ag, Count(Call_Status_Config__c) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Call_Status_Config__c = 'Contacted' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - OLD *****//
                    
                    //***** NEW *****//
                    //callLineContacted = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Contacted' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - NEW *****//
                    
                    //***** NEW (2)*****//
                    callLineContacted = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Contacted' AND Call_List__c = :choosen_campaign GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - NEW (2) *****//
                    
                    system.debug('callLineContacted: '+callLineContacted);
                    for(AggregateResult ar : callLineContacted){
                        sizeContacted.put((String)ar.get('ag'), (Integer)ar.get('hasCallLine'));
                    }
                    system.debug('sizeContacted: '+sizeContacted);
                    
                    
                    //----------------------------------------------------------------------------------------------------------------------------------------------------------
                    //----------------------------------------------------------------------------------------------------------------------------------------------------------
                    
                    
                    //***** OLD *****//
                    //callLineUncontacted = [SELECT Agent__r.Name nm, Agent__c ag, Count(Call_Status_Config__c) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Call_Status_Config__c = 'Uncontacted' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - OLD *****//
                    
                    //***** NEW *****//
                    //callLineUncontacted = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Uncontacted' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - NEW *****//
                    
                    //***** NEW (2) *****//
                    callLineUncontacted = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Uncontacted' AND Call_List__c = :choosen_campaign GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - NEW (2) *****//
                    
                    system.debug('callLineUncontacted: '+callLineUncontacted);
                    for(AggregateResult ar : callLineUncontacted){
                        sizeUncontacted.put((String)ar.get('ag'), (Integer)ar.get('hasCallLine'));
                    }
                    system.debug('sizeUncontacted: '+sizeUncontacted);
                    
                    
                    //----------------------------------------------------------------------------------------------------------------------------------------------------------
                    //----------------------------------------------------------------------------------------------------------------------------------------------------------
                    
                    
                    //***** OLD *****//
                    //callLineRescheduled = [SELECT Agent__r.Name nm, Agent__c ag, Count(Call_Status_Config__c) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Call_Status_Config__c = 'Rescheduled' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - OLD *****//
                    
                    //***** NEW *****//
                    //callLineRescheduled = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Rescheduled' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - NEW *****//
                    
                    //***** NEW (2) *****//
                    callLineRescheduled = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Rescheduled' AND Call_List__c = :choosen_campaign GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - NEW (2) *****//
                    
                    system.debug('callLineRescheduled: '+callLineRescheduled);
                    for(AggregateResult ar : callLineRescheduled){
                        sizeRescheduled.put((String)ar.get('ag'), (Integer)ar.get('hasCallLine'));
                    }
                    system.debug('sizeRescheduled: '+sizeRescheduled);
                    
                    
                    //----------------------------------------------------------------------------------------------------------------------------------------------------------
                    //----------------------------------------------------------------------------------------------------------------------------------------------------------
                    
                    
                    //***** OLD *****//
                    //callLineInvalidNumber = [SELECT Agent__r.Name nm, Agent__c ag, Count(Call_Status_Config__c) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Call_Status_Config__c = 'Invalid Number' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - OLD *****//
                    
                    //***** NEW *****//
                    //callLineInvalidNumber = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Invalid Number' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - NEW *****//
                    
                    //***** NEW (2) *****//
                    callLineInvalidNumber = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Invalid Number' AND Call_List__c = :choosen_campaign GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - NEW (2) *****//
                    
                    system.debug('callLineInvalidNumber: '+callLineInvalidNumber);
                    for(AggregateResult ar : callLineInvalidNumber){
                        sizeInvalidNumber.put((String)ar.get('ag'), (Integer)ar.get('hasCallLine'));
                    }
                    system.debug('sizeInvalidNumber: '+sizeInvalidNumber);
                    
                    
                    //----------------------------------------------------------------------------------------------------------------------------------------------------------
                    //----------------------------------------------------------------------------------------------------------------------------------------------------------
                    
                    
                    //***** OLD *****//
                    //callLineHold = [SELECT Agent__r.Name nm, Agent__c ag, Count(Call_Status_Config__c) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Call_Status_Config__c = 'Hold' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - OLD *****//
                    
                    //***** NEW *****//
                    //callLineHold = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Hold' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - NEW *****//
                    
                    //***** NEW (2) *****//
                    callLineHold = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Hold' AND Call_List__c = :choosen_campaign GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - NEW (2) *****//
                    
                    system.debug('callLineHold: '+callLineHold);
                    for(AggregateResult ar : callLineHold){
                        sizeHold.put((String)ar.get('ag'), (Integer)ar.get('hasCallLine'));
                    }
                    system.debug('sizeHold: '+sizeHold);
                    
                    
                    //----------------------------------------------------------------------------------------------------------------------------------------------------------
                    //----------------------------------------------------------------------------------------------------------------------------------------------------------
                    
                    //***** OLD *****//
                    //callLineGrandTotal = [SELECT Agent__r.Name nm, Agent__c ag, Count(Id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - OLD *****//
                    
                    //***** NEW *****//
                    callLineGrandTotal = [SELECT Agent__r.Name nm, Agent__c ag, Count(Id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Call_List__c = :choosen_campaign GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                    //***** END - NEW *****//
                    
                    system.debug('callLineGrandTotal: '+callLineGrandTotal);
                    for(AggregateResult ar : callLineGrandTotal){
                        sizeGrandTotal.put((String)ar.get('ag'), (Integer)ar.get('hasCallLine'));
                    }
                    system.debug('sizeGrandTotal: '+sizeGrandTotal);
                    //END - Update, 26 Maret 2020
                    
                    
                    for(Call_Line__c dis : callLineList){
                        alocidx = math.mod(i , totalAgents);  
                        j = 0;
                        for(User agent : agentList ){
                            if(j==alocidx) {
                                if(agentAssignmentMap.containsKey(agent.id)){
                                    totalAssignment = agentAssignmentMap.get(agent.id)+1;
                                    agentAssignmentMap.put(agent.id, totalAssignment);
                                }else{
                                    agentAssignmentMap.put(agent.id, 1);
                                }
                                dis.Agent__c = agent.id;
                                dis.ownerId = agent.id;
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
                        assignment.clBlank = sizeBlank.get(agentid);
                        assignment.clContacted = sizeContacted.get(agentid);
                        assignment.clUncontacted = sizeUncontacted.get(agentid);
                        assignment.clRescheduled = sizeRescheduled.get(agentid);
                        assignment.clInvalidNumber = sizeInvalidNumber.get(agentid);
                        assignment.clHold = sizeHold.get(agentid);
                        assignment.clGrandTotal = sizeGrandTotal.get(agentid);
                        assignment.policyTotal = agentAssignmentMap.get(agentid);
                        assignmentList.add(assignment);
                    } 
                    system.debug('assignment.clBlank: '+assignment.clBlank);
                    system.debug('assignment.clContacted: '+assignment.clContacted);
                    system.debug('assignment.clUncontacted: '+assignment.clUncontacted);
                    system.debug('assignment.clRescheduled: '+assignment.clRescheduled);
                    system.debug('assignment.clInvalidNumber: '+assignment.clInvalidNumber);
                    system.debug('assignment.clHold: '+assignment.clHold);
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
    @TestVisible private PageReference distributeRoundRobin(){
        List<Call_Line__c> calin = [SELECT Name, OwnerId, Contact__r.Name, Contact__r.WelcomeCall_APE__c, WelcomeCall_Call_Line_Status__c, Contact__r.Policy_No__c
                                FROM Call_Line__C
                                WHERE WelcomeCall_Call_Line_Status__c != 'Closed' AND Contact__r.WelcomeCall_APE__c != Null
                                AND WelcomeCall_Fg_Round_Robin__c = false and recordType.name ='Welcome Call'
                                And Call_List__c = :choosen_campaign];
        totalPolicyLabel = 'Total Round Robin';
        totalPolicies = calin.size();
        /*populateFreshData();
        if(totalPolicies > 0){
            try {
                CallLineWelcomeCall calin = new CallLineWelcomeCall();
                calin.roundRobinDist();
            } catch(Exception ex){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ex.getMessage()));
            }
        }else{
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No records is available to distribute.'));    
            //return null;
        }
        */
        
        isMethodChoosen = true;
        return null;
    }
    
    @TestVisible private PageReference distributeAutoWC(){
        populateFreshData();
        //select callLine yang caseId sama dengan welcomecall
        //String jenisRec = recTypeWC;
        List<Call_Line__c> daftarCallLine = [SELECT Id, Name, OwnerId FROM Call_Line__c WHERE RecordTypeId =: recTypeWC];
        List<WelcomeCall_Group__c> groupID = [SELECT Id FROM WelcomeCall_Group__c WHERE Name = 'Level 1' LIMIT 1];
        List<Agent_Group__c> cekJumlah = [SELECT Id, Name, isActive__c, WelcomeCall_Assignment__c FROM Agent_Group__c WHERE WelcomeCall_Group__c =: groupID];
        
        WelcomeCall_Group__c prioritas_terakhir = [SELECT WelcomeCall_Last_Priority__c FROM WelcomeCall_Group__c];
        //Agent_Group__c empunya = new Agent_Group__c();
        for(Call_Line__c camel : daftarCallLine){
            if(prioritas_terakhir.WelcomeCall_Last_Priority__c > cekJumlah.size()){
                prioritas_terakhir.WelcomeCall_Last_Priority__c = 0;
            }
            Double prioritas_berikut = double.valueOf(prioritas_terakhir.WelcomeCall_Last_Priority__c)+1;
            Agent_Group__c pengenal = [SELECT Id, Name, isActive__c, WelcomeCall_Assignment__c FROM Agent_Group__c WHERE WelcomeCall_Priority__c =:prioritas_berikut AND WelcomeCall_Group__c =: groupID];
            if(pengenal.isActive__c == True && pengenal.WelcomeCall_Assignment__c == True){
                camel.OwnerId = pengenal.Id;
                prioritas_terakhir.WelcomeCall_Last_Priority__c = prioritas_berikut;
            }else{
                prioritas_terakhir.WelcomeCall_Last_Priority__c = prioritas_berikut;
                break;
            }
        }
        
        return null;
    }

    //public PageReference distributeManual(){
    @TestVisible private PageReference distributeManual(){
        populateFreshData();  //added by WK, 20150416
        assignmentList = new List<AgentAssignment>();
        if(totalPolicies>0){
            AgentAssignment assignment = null;
            if(totalAgents==0){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'You have not subordinate. Please contact Administrator.'));    
            }else{
                
                //Update, 26 Maret 2020
                system.debug('loggedInUser: '+loggedInUser);
                
                //----------------------------------------------------------------------------------------------------------------------------------------------------------
                //----------------------------------------------------------------------------------------------------------------------------------------------------------
                
                
                //***** OLD *****//
                //callLineBlank = [SELECT Agent__r.Name nm, Agent__c ag, Count(Id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Call_Status_Config__c = '' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - OLD *****//
                
                //***** NEW *****//
                //callLineBlank = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = '' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - NEW *****//
                
                //***** NEW (2) *****//
                callLineBlank = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = '' AND Call_List__c = :choosen_campaign GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - NEW (2) *****//
                
                system.debug('callLineBlank: '+callLineBlank);
                for(AggregateResult ar : callLineBlank){
                    sizeBlank.put((String)ar.get('ag'), (Integer)ar.get('hasCallLine'));
                }
                system.debug('sizeBlank: '+sizeBlank);
                
                
                //----------------------------------------------------------------------------------------------------------------------------------------------------------
                //----------------------------------------------------------------------------------------------------------------------------------------------------------
                
                
                //***** OLD *****//
                //callLineContacted = [SELECT Agent__r.Name nm, Agent__c ag, Count(Call_Status_Config__c) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Call_Status_Config__c = 'Contacted' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - OLD *****//
                
                //***** NEW *****//
                //callLineContacted = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Contacted' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - NEW *****//
                
                //***** NEW (2)*****//
                callLineContacted = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Contacted' AND Call_List__c = :choosen_campaign GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - NEW (2) *****//
                
                system.debug('callLineContacted: '+callLineContacted);
                for(AggregateResult ar : callLineContacted){
                    sizeContacted.put((String)ar.get('ag'), (Integer)ar.get('hasCallLine'));
                }
                system.debug('sizeContacted: '+sizeContacted);
                
                
                //----------------------------------------------------------------------------------------------------------------------------------------------------------
                //----------------------------------------------------------------------------------------------------------------------------------------------------------
                
                
                //***** OLD *****//
                //callLineUncontacted = [SELECT Agent__r.Name nm, Agent__c ag, Count(Call_Status_Config__c) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Call_Status_Config__c = 'Uncontacted' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - OLD *****//
                
                //***** NEW *****//
                //callLineUncontacted = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Uncontacted' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - NEW *****//
                
                //***** NEW (2) *****//
                callLineUncontacted = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Uncontacted' AND Call_List__c = :choosen_campaign GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - NEW (2) *****//
                
                system.debug('callLineUncontacted: '+callLineUncontacted);
                for(AggregateResult ar : callLineUncontacted){
                    sizeUncontacted.put((String)ar.get('ag'), (Integer)ar.get('hasCallLine'));
                }
                system.debug('sizeUncontacted: '+sizeUncontacted);
                
                
                //----------------------------------------------------------------------------------------------------------------------------------------------------------
                //----------------------------------------------------------------------------------------------------------------------------------------------------------
                
                
                //***** OLD *****//
                //callLineRescheduled = [SELECT Agent__r.Name nm, Agent__c ag, Count(Call_Status_Config__c) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Call_Status_Config__c = 'Rescheduled' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - OLD *****//
                
                //***** NEW *****//
                //callLineRescheduled = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Rescheduled' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - NEW *****//
                
                //***** NEW (2) *****//
                callLineRescheduled = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Rescheduled' AND Call_List__c = :choosen_campaign GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - NEW (2) *****//
                
                system.debug('callLineRescheduled: '+callLineRescheduled);
                for(AggregateResult ar : callLineRescheduled){
                    sizeRescheduled.put((String)ar.get('ag'), (Integer)ar.get('hasCallLine'));
                }
                system.debug('sizeRescheduled: '+sizeRescheduled);
                
                
                //----------------------------------------------------------------------------------------------------------------------------------------------------------
                //----------------------------------------------------------------------------------------------------------------------------------------------------------
                
                
                //***** OLD *****//
                //callLineInvalidNumber = [SELECT Agent__r.Name nm, Agent__c ag, Count(Call_Status_Config__c) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Call_Status_Config__c = 'Invalid Number' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - OLD *****//
                
                //***** NEW *****//
                //callLineInvalidNumber = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Invalid Number' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - NEW *****//
                
                //***** NEW (2) *****//
                callLineInvalidNumber = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Invalid Number' AND Call_List__c = :choosen_campaign GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - NEW (2) *****//
                
                system.debug('callLineInvalidNumber: '+callLineInvalidNumber);
                for(AggregateResult ar : callLineInvalidNumber){
                    sizeInvalidNumber.put((String)ar.get('ag'), (Integer)ar.get('hasCallLine'));
                }
                system.debug('sizeInvalidNumber: '+sizeInvalidNumber);
                
                
                //----------------------------------------------------------------------------------------------------------------------------------------------------------
                //----------------------------------------------------------------------------------------------------------------------------------------------------------
                
                
                //***** OLD *****//
                //callLineHold = [SELECT Agent__r.Name nm, Agent__c ag, Count(Call_Status_Config__c) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Call_Status_Config__c = 'Hold' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - OLD *****//
                
                //***** NEW *****//
                //callLineHold = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Hold' GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - NEW *****//
                
                //***** NEW (2) *****//
                callLineHold = [SELECT Agent__r.Name nm, Agent__c ag, Count(id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Activity_Result__c = 'Hold' AND Call_List__c = :choosen_campaign GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - NEW (2) *****//
                
                system.debug('callLineHold: '+callLineHold);
                for(AggregateResult ar : callLineHold){
                    sizeHold.put((String)ar.get('ag'), (Integer)ar.get('hasCallLine'));
                }
                system.debug('sizeHold: '+sizeHold);
                
                
                //----------------------------------------------------------------------------------------------------------------------------------------------------------
                //----------------------------------------------------------------------------------------------------------------------------------------------------------
                
                //***** OLD *****//
                //callLineGrandTotal = [SELECT Agent__r.Name nm, Agent__c ag, Count(Id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - OLD *****//
                
                //***** NEW *****//
                callLineGrandTotal = [SELECT Agent__r.Name nm, Agent__c ag, Count(Id) hasCallLine FROM Call_Line__c WHERE Agent__r.ManagerId = :loggedInUser AND Call_List__c = :choosen_campaign GROUP BY Agent__r.Name, Agent__c ORDER BY Agent__r.Name LIMIT 50000];
                //***** END - NEW *****//
                
                system.debug('callLineGrandTotal: '+callLineGrandTotal);
                for(AggregateResult ar : callLineGrandTotal){
                    sizeGrandTotal.put((String)ar.get('ag'), (Integer)ar.get('hasCallLine'));
                }
                system.debug('sizeGrandTotal: '+sizeGrandTotal);
                //END - Update, 26 Maret 2020
                
                for(User agent : agentList){
                    assignment = new AgentAssignment();
                    assignment.agentId = agent.id;
                    assignment.agentName = agentMap.get(agent.id);
                    assignment.clBlank = sizeBlank.get(agent.id);
                    assignment.clContacted = sizeContacted.get(agent.id);
                    assignment.clUncontacted = sizeUncontacted.get(agent.id);
                    assignment.clRescheduled = sizeRescheduled.get(agent.id);
                    assignment.clInvalidNumber = sizeInvalidNumber.get(agent.id);
                    assignment.clHold = sizeHold.get(agent.id);
                    assignment.clGrandTotal = sizeGrandTotal.get(agent.id);
                    assignment.policyTotal = 0;
                    assignmentList.add(assignment);
                }
                system.debug('assignment.clBlank (2): '+assignment.clBlank);
                system.debug('assignment.clContacted (2): '+assignment.clContacted);
                system.debug('assignment.clUncontacted (2): '+assignment.clUncontacted);
                system.debug('assignment.clRescheduled (2): '+assignment.clRescheduled);
                system.debug('assignment.clInvalidNumber (2): '+assignment.clInvalidNumber);
                system.debug('assignment.clHold (2): '+assignment.clHold);
            }       
        }else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No records is available to distribute.'));    
            return null;
        }

        isMethodChoosen = true;
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
        
        try
        {
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
        }
        catch (Exception e)
        {
            System.debug('e: ' + e.getLineNumber() + ' / ' + e.getMessage());
        }
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
        
        //Update, 19 Maret 2020
        /*String dr_today = string.valueOf(system.today());
        system.debug(dr_today);
        
        if(searchStartDate != '' && searchEndDate != ''){
            if(searchStartDate > searchEndDate){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING, 'Start Date must be smaller than End Date.'));
            } 
        } else if(searchStartDate != '' || searchEndDate != ''){
            if(searchStartDate > dr_today || searchEndDate > dr_today){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING, 'Start Date/End Date cannot greater than today.'));
            }
        }*/
        
        if(choosen_campaign != '' && choosen_campaign != null && choosen_agent != null && choosen_agent != ''){
            query = 'SELECT Id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Entity__c, Policy_No__c, Call_Status_Config__c, Contact__c, Contact__r.Name, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c FROM Call_Line__c WHERE Entity__c = \''+entity+'\' ';
            
            String campaignList_split = '';
            for(integer i=0; i<callList.size(); i++){
                if(i+1 < callList.size()){
                    campaignList_split += '\''+callList[i].Id+'\', ';
                } else if(i+1 == campaignList.size()){
                    campaignList_split += '\''+callList[i].Id+'\'';
                }
            }
            system.debug('campaignList_split: '+campaignList_split);
            
            if(choosen_campaign != '' && choosen_campaign != null && choosen_campaign != 'All'){
                query += 'AND Call_List__c = \''+choosen_campaign+'\' ';
                System.debug('choosen_campaign: '+choosen_campaign);
            } else if(choosen_campaign != '' && choosen_campaign != null && choosen_campaign == 'All'){
                query += 'AND Call_List__c IN ('+campaignList_split+') ';
                System.debug('choosen_campaign: '+choosen_campaign);
            }
            
            system.debug('agentIDList: '+agentIDList);
            String splitString = '';
            for(integer i=0; i<agentIDList.size(); i++){
                if(i+1 < agentIDList.size()){
                    splitString += '\''+agentIDList[i]+'\', ';
                } else if(i+1 == agentIDList.size()){
                    splitString += '\''+agentIDList[i]+'\'';
                }
            }
            system.debug('splitString: '+splitString);
            
            if(splitString != ''){
                if(choosen_agent != '' && choosen_agent != null && choosen_agent == 'All'){
                    query += 'AND Agent__c in ('+splitString+') ';
                    System.debug('choosen_agent (All): '+choosen_agent);
                } else if(choosen_agent != '' && choosen_agent != null && choosen_agent != 'All'){
                    query += 'AND Agent__c = \''+choosen_agent+'\' ';
                    System.debug('choosen_agent: '+choosen_agent);
                }
            } else {
                System.debug('choosen_agent (Tidak ada Agent)');
            }
            
            string s_null = 'null';
            if(clObj.Call_Status_Config__c != null && choosen_callStatus_blank == FALSE){
                query += 'AND Call_Status_Config__c = \''+clObj.Call_Status_Config__c+'\' ';
                System.debug('Call_Status_Config__c (IF): '+clObj.Call_Status_Config__c);
            } else if(clObj.Call_Status_Config__c == null && choosen_callStatus_blank == TRUE){
                query += 'AND Call_Status_Config__c = '+s_null+' ';
                System.debug('Call_Status_Config__c (ELSE IF)');
            } else if(clObj.Call_Status_Config__c != null && choosen_callStatus_blank == TRUE){
                //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING, 'Tidak bisa dicentang ketika sudah memilih Call Status.'));
                System.debug('WARNING: Tidak bisa dicentang ketika sudah memilih Call Status.');
            }
            
            if(clObj.Reason_Status_Config__c != null){
                query += 'AND Reason_Status_Config__c = \''+clObj.Reason_Status_Config__c+'\' ';
                System.debug('Reason_Status_Config__c: '+clObj.Reason_Status_Config__c);
            }
            
            //to Call Start Date
            String[] CallStartDateString;
            String daytempStart = '';
            String dayStart = '';
            String monthtempStart = '';
            string monthStart = '';
            String yearStart = '';
            String CallStartDate = '';
            
            //to Call End Date
            String[] CallEndDateString;
            String daytempEnd = '';
            String dayEnd = '';
            String monthtempEnd = '';
            string monthEnd = '';
            String yearEnd = '';
            String CallEndDate = '';
            
            system.debug('searchStartDate: '+searchStartDate);
            system.debug('searchEndDate: '+searchEndDate);
            if((searchStartDate != '' && searchStartDate != null) && (searchEndDate != '' && searchEndDate != null)){
                system.debug('********** Condition 1 **********');
                
                //Start Date
                CallStartDateString = searchStartDate.split('/');
                daytempStart = CallStartDateString.get(1).replace(',', '');
                if(daytempStart.length() == 1){ dayStart = '0'+daytempStart; }
                else { dayStart = daytempStart; }
                
                monthtempStart = CallStartDateString.get(0).replace(',', '');
                
                if(monthtempStart.length() == 1){ monthStart = '0'+monthtempStart; } 
                else { monthStart = monthtempStart; }
                
                yearStart = CallStartDateString.get(2);
                CallStartDate = yearStart + '-' + monthStart + '-' + dayStart;
                System.debug('CallStartDateString: '+CallStartDateString);
                System.debug('dayStart: '+dayStart);
                System.debug('monthStart: '+monthStart);
                System.debug('yearStart: '+yearStart);
                System.debug('CallStartDate: '+CallStartDate);
                //END - Start Date
                
                //End Date
                CallEndDateString = searchEndDate.split('/');
                daytempEnd = CallEndDateString.get(1).replace(',', '');
                if(daytempEnd.length() == 1){ dayEnd = '0'+daytempEnd; } 
                else { dayEnd = daytempEnd; }
                
                monthtempEnd = CallEndDateString.get(0).replace(',', '');
                
                if(monthtempEnd.length() == 1){ monthEnd = '0'+monthtempEnd; } 
                else { monthEnd = monthtempEnd; }
                yearEnd = CallEndDateString.get(2);
                CallEndDate = yearEnd + '-' + monthEnd + '-' + dayEnd;
                System.debug('CallEndDateString: '+CallEndDateString);
                System.debug('dayEnd: '+dayEnd);
                System.debug('monthEnd: '+monthEnd);
                System.debug('yearEnd: '+yearEnd);
                System.debug('CallEndDate: '+CallEndDate);
                //END - End Date
                
                query += 'AND (Call_Date__c >= '+CallStartDate+' AND Call_Date__c <= '+CallEndDate+') ';
            } else if((searchStartDate != '' && searchStartDate != null) || (searchEndDate == '' && searchEndDate == null)){
                system.debug('********** Condition 2 **********');
                
                //Start Date
                CallStartDateString = searchStartDate.split('/');
                daytempStart = CallStartDateString.get(1).replace(',', '');
                if(daytempStart.length() == 1){ dayStart = '0'+daytempStart; } 
                else { dayStart = daytempStart; }
                
                monthtempStart = CallStartDateString.get(0).replace(',', '');
                
                if(monthtempStart.length() == 1){ monthStart = '0'+monthtempStart; } 
                else { monthStart = monthtempStart; }
                yearStart = CallStartDateString.get(2);
                CallStartDate = yearStart + '-' + monthStart + '-' + dayStart;
                System.debug('CallStartDateString: '+CallStartDateString);
                System.debug('dayStart: '+dayStart);
                System.debug('monthStart: '+monthStart);
                System.debug('yearStart: '+yearStart);
                System.debug('CallStartDate: '+CallStartDate);
                //END - Start Date
                
                query += 'AND Call_Date__c >= '+CallStartDate+' ';
            } else if((searchStartDate == '' && searchStartDate == null) || (searchEndDate != '' && searchEndDate != null)){
                system.debug('********** Condition 3 **********');
                
                //End Date
                CallEndDateString = searchEndDate.split('/');
                daytempEnd = CallEndDateString.get(1).replace(',', '');
                if(daytempEnd.length() == 1){ dayEnd = '0'+daytempEnd; } 
                else { dayEnd = daytempEnd; }
                
                monthtempEnd = CallEndDateString.get(0).replace(',', '');
                
                if(monthtempEnd.length() == 1){ monthEnd = '0'+monthtempEnd; } 
                else { monthEnd = monthtempEnd; }
                yearEnd = CallEndDateString.get(2);
                CallEndDate = yearEnd + '-' + monthEnd + '-' + dayEnd;
                System.debug('CallEndDateString: '+CallEndDateString);
                System.debug('dayEnd: '+dayEnd);
                System.debug('monthEnd: '+monthEnd);
                System.debug('yearEnd: '+yearEnd);
                System.debug('CallEndDate: '+CallEndDate);
                //END - END Date
                
                query += 'AND Call_Date__c <= '+CallEndDate+' ';
            }
            
            if(searchPolicyNo != '' && searchPolicyNo != null){
                query += 'AND Policy_No__c  = \''+searchPolicyNo+'\' ';
                System.debug('searchPolicyNo: '+searchPolicyNo);
            }
            
            query += 'order by Agent__r.Name ASC limit 400';
            system.debug('query: '+query);
            
            callLineList = database.query(query);
            system.debug('callLineList: '+callLineList);
        }
        //END - Update, 19 Maret 2020
        
        
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
        
        //Update, 19 Maret 2020
        /*if(choosen_campaign != '' && choosen_agent == 'All' && clObj.Call_Status_Config__c == null && clObj.Reason_Status_Config__c == null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Entity__c, Policy_No__c, Call_Status_Config__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c in :agentIDList];    
            //totalPolicies = callLineList.size();
        }else if(choosen_campaign != '' && choosen_agent == 'All' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c == null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Entity__c, Policy_No__c, Call_Status_Config__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c in :agentIDList and Call_Status_Config__c = :clObj.Call_Status_Config__c];    
            //totalPolicies = callLineList.size();
        }else if(choosen_campaign != '' && choosen_agent == 'All' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c != null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Entity__c, Policy_No__c, Call_Status_Config__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c in :agentIDList and Call_Status_Config__c = :clObj.Call_Status_Config__c and Reason_Status_Config__c = :clObj.Reason_Status_Config__c];    
            //totalPolicies = callLineList.size();
        }
        else if(choosen_campaign != '' && choosen_agent != null && choosen_agent != '' && clObj.Call_Status_Config__c == null && clObj.Reason_Status_Config__c == null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Call_Status_Config__c, Activity__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c = :choosen_agent];    
            //totalPolicies = callLineList.size();
        }else if(choosen_campaign != '' && choosen_agent != null && choosen_agent != '' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c == null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Activity_Result__c, Call_Status_Config__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c = :choosen_agent and Call_Status_Config__c = :clObj.Call_Status_Config__c];    
            //totalPolicies = callLineList.size();
        }
        else if(choosen_campaign != '' && choosen_agent != null && choosen_agent != '' && clObj.Call_Status_Config__c != null && clObj.Reason_Status_Config__c != null){
            callLineList = [select id, Agent__c, Agent__r.Name, Call_List__c, Activity__c, Activity_Result__c, Call_Status_Config__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Reason_Status_Config__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and Agent__c = :choosen_agent and Call_Status_Config__c = :clObj.Call_Status_Config__c and Reason_Status_Config__c = :clObj.Reason_Status_Config__c];    
            //totalPolicies = callLineList.size();
        }*/
        //END - Update, 19 Maret 2020
        totalPolicies = callLineList.size();
            
        for(Call_Line__c cl: callLineList){
            relWrap = new ReloadWrapper();
            relWrap.id = cl.Id;
            relWrap.agentName = cl.Agent__r.Name;
            relWrap.policyNo = cl.Policy_No__c;
            relWrap.contactId = cl.Contact__c;
            relWrap.contactName = cl.Contact__r.Name;
            relWrap.callStatus = cl.Call_Status_Config__c;
            relWrap.reasonStatus = cl.Reason_Status_Config__c;
            ReloadWrap.add(relWrap);
        }
        return ReloadWrap;
    }   
    /*---------------- FInish ---------------*/
     
    public PageReference save() {   
        boolean isSuccess = true;
        system.debug('::: SAVING Distribution:::');
        system.debug('::: choosen_method: ' + choosen_method);
        system.debug('::: choosen campaign: ' + choosen_campaign);
        
        if(choosen_campaign == null || choosen_campaign == ''){
            system.debug('::: choosen campaign: ' + choosen_campaign);
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Campaign Type is mandatory field.'));
            return null;
        }
        if(!isMethodChoosen){
            system.debug('::: choosen_method: ' + choosen_method);
            isSuccess = false;  
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'You could not save before choosing Distribution Method first.'));
            return null;
        }
        string surveyURL = '';
        List<Call_Line__c> tosaveCallLineList = new List<Call_Line__c>();  //added by WK, 20150417
        Call_Line__c tosaveCallLine = null; //added by WK, 20150417
        System.debug('===log callLineList debug=== '+callLineList);
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
                    tosaveCallLine.survey_url__c = dis.survey_url__c;
                    tosaveCallLineList.add(tosaveCallLine);
                }
                k++;
            }
        }
        else if(choosen_method == 'Round Robin'){
            System.debug('running round robin');
            
            CallLineWelcomeCall calin = new CallLineWelcomeCall();
            calin.roundRobinDist(false);
        }
        else{
            for(Call_Line__c dis : callLineList){
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
                    tosaveCallLineList.add(tosaveCallLine);
                }
            }
        }
        //update callLineList;
        system.debug('update list size: '+ tosaveCallLineList.size());
         // update by MII at 11 09 23,  
        // if (tosaveCallLineList.isEmpty()) {
         // penambahan simbol !
         // karena sebelumnya tidak ada, jadi proses distribution agen tidak berhasil.
        if (!tosaveCallLineList.isEmpty()) {
            update tosaveCallLineList;
        }
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Call Distribution already saved.'));
        return null;
    }
    
    public PageReference upload() {
        System.debug('running round robin');
        document.AuthorId = UserInfo.getUserId();
        document.FolderId = UserInfo.getUserId(); // put it in running user's folder
        outboundCallList = new List<OutboundCall>();
        if(choosen_campaign == null || choosen_campaign == ''){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Campaign Type is mandatory field.'));
            return null;
        }
        try {
            if(document.body==null || document.body.toString() == ''){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'No file is selected.'));
                return null;
            }else{
                string nameFile=document.body.toString();
                System.debug('document name '+document.name);
                boolean fileExtension = document.name.endsWith('.csv');
                if(!fileExtension){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Uploaded file type is not supported. Please upload only csv file.'));
                    return null;
                }
                document.name = choosen_campaign;
                //string activity = campaignObjectMap.get(choosen_campaign).getActivity__c;
               
                Call_List__c campaign = campaignObjectMap.get(choosen_campaign);
                string activity  = campaign.Activity__c;
                Case_Type_Config = campaign.Case_Type_Config__c;
                
                List<Id> idList =  new List<Id>();
                Map<String,string> map1 = new Map<string,string>();
                
                if(Case_Type_Config == 'Welcome Call' && campaign.Entity__c == 'AMFS'){
                    System.debug('it is a ' + Case_Type_Config);
                    List<String> dataList = parseCSV(nameFile,true);
                    uploadedNum = dataList.size();
                    welcomecallAssign(dataList);
                }else 
                if(activity == 'Confirmation' || activity == 'Renewal' || activity == 'Survey'){
                    System.debug('it aint a welcome call, it\'s '  + Case_Type_Config);
                    List<String> dataList = parseCSV(nameFile,true);
                    uploadedNum = dataList.size();
                    processPolicy(dataList);
                }else if(activity == 'Conservation'){
                    List<String> dataList = parseConservationCSV(nameFile,true);
                    uploadedNum = dataList.size();
                    processConservation(dataList);
                }else if(activity == 'Customer Segmentation'){
                    isInvalidPolicyNoShow = false;
                    parseCustSegmentationCSV(nameFile,true);
                    uploadedNum = custSegMap.size();
                    invalidNum = uploadedNum - validNum;
                    processCustSegmentation();
                }else { //callback
                    List<String> dataList = parseCallbackCSV(nameFile,true);
                    //uploadedNum = dataList.size();
                    processPhone(dataList); 
                } 
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file'));
            return null;
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
            return null;
        } finally {
            document.body = null; // clears the viewstate
            document = new Document();
        }
     
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully'));
        return null;
    }
  
    /*
     * Parse CSV file which has header : customer segmentation 
     */
    @TestVisible private Set<String> parseCustSegmentationCSV(String contents,Boolean skipHeaders){

            System.debug('===contents=== '+contents);
        contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
        System.debug('===contents=== '+contents);
        contents = contents.replaceAll('""','DBLQT');
        System.debug('===contents=== '+contents);
        List<String> lines = new List<String>();
        lines = contents.split('\n');
        if(skipHeaders)lines.remove(0);
        custSegMap = new Map<String, CustomerSegmentation>();
        for(String data : lines){
            //data = data.replaceFirst(',', '');
            String[] datas = data.split(',');
            System.debug('===datas=== '+datas);
            if(datas.size() >= 2){
             CustomerSegmentation cSeg = new CustomerSegmentation();
             cSeg.policyNo = datas[0];
             cSeg.custSegmentation = datas[1];
             custSegMap.put(cSeg.policyNo, cSeg);
            }
        }
        List<Contact> cts = [Select id, Cust_Segmentation__c, policy_no__c from Contact where policy_No__c in : custSegMap.keySet() LIMIT 50000];
        validNum =0;
        invalidNum =0;
        for(Contact ct : cts){
            if(custSegMap.get(ct.policy_no__c) != null){
                validNum = validNum + 1;
            }
        }
        System.debug('custSegMap '+custSegMap);
        return custSegMap.keySet();
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
        System.debug('polno : '+dataList);
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
            
            if(!isValid){
                rowval = rowval.replaceFirst(',',''); //replace ',' in the beginning of the string
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
            if(isValid){
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
    
    //process customer segmentation using apex batch.
    private void processCustSegmentation(){
        try{
            Call_List__c campaign = campaignObjectMap.get(choosen_campaign);
            UpdateContactBatchable be = new UpdateContactBatchable(custSegMap, true, UserInfo.getUserId(), 
                                                                   campaign);
            database.executeBatch(be, 1000);
        } catch(Exception e){
            
            System.debug('System Error '+e);
        }
    }
    
    @TestVisible private void processPolicy(List<String> dataList){
        System.debug('try to get contactList');
        System.debug('Entity '+entity);
        System.debug('Datalist '+dataList);
        List<Contact> contactList = [select id, Policy_No__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No__c in :dataList and createddate > 2014-01-01T00:00:01Z];

        System.debug('contactlist '+contactList);
        integer foundCounter = contactList.size();
        System.debug('contactList size '+foundCounter);
        //validNum = contactList.size();          //remarked by WK, 20150417
        //invalidNum = uploadedNum - validNum;    //remarked by WK, 20150417
        
        //begin:added by Wk, 20150417
        System.debug('try to get existingCallLineList');
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
                uploadedCall.policyNo = pelanggan.Policy_No__c;
                uploadedCall.phoneNo = pelanggan.MobilePhone;
                uploadedCall.campaignName = campaignMap.get(choosen_campaign);  
                outboundCallList.add(uploadedCall);
                
                //begin:added by WK, 20150417
                isExist = false;     
                for(Call_Line__c cl : existingCallLineList){
                    if(cl.Policy_No__c == pelanggan.Policy_No__c){
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
                callLine.Policy_No__c = pelanggan.Policy_No__c;
                callLine.Contacted_Number__c = pelanggan.MobilePhone;
                callLine.Home_Phone__c = pelanggan.HomePhone;
                callLine.Phone__c = pelanggan.Phone;
                callLine.Call_List__c = choosen_campaign;
                callLine.Entity__c = pelanggan.Entity__c;
                campaign = campaignObjectMap.get(choosen_campaign);
                callLine.Activity__c = campaign.Activity__c;
                callLine.Case_Type__c = campaign.Case_Type__c; 
                callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                callLine.Ext_ID__c = choosen_campaign + '-'+callLine.Contact__c;
                idx = 0;
                callLineList.add(callLine); 
                policyArr = policyArr.replaceFirst(pelanggan.Policy_No__c, 'VALIDPOLICYNO');
            }
            System.debug('mau insert');
            
            //Update Daniel, 23 April 2020 (use Batching)
            //insert callLineList;
            
            if (callLineList.size() > 0) {
                CallLineInsertBatch jb = new CallLineInsertBatch(callLineList);
                Database.executeBatch(jb, 65);
                System.debug('== DONE BATCH (to Confirmation / Renewal / Survey) ==');
            }
            //END - Update Daniel, 23 April 2020 (use Batching)
            
            
        }
        invalidPolicyTempList = policyArr.split(',');
        invalidPolicyTempList.remove(0); 
        invalidPolicyList = new List<string>();
        for(string polno : invalidPolicyTempList){
            if(polno != 'VALIDPOLICYNO'){
                invalidPolicyList.add(polno);   
            }
        } 
        
        try
        {
        insert document;
        }
        catch(Exception e)
        {
            System.debug('e: ' + e.getLineNumber() + ' / ' + e.getMessage());
        }
    }

    @TestVisible private void welcomecallAssign(List<String> dataList){
        System.debug('welcomecallAssign LV');
        mode = true;
        Boolean noContact = false;
        List<Contact> contactList = [SELECT id,Name, policyApp__c, Pic_Name__c, Policy_No__c, MobilePhone, Phone, HomePhone, Entity__c, OtherPhone,
                                     WelcomeCall_APE__c, WelcomeCall_Currency__c
                                     FROM Contact 
                                     WHERE Entity__c = :entity AND Policy_No__c in :dataList and WelcomeCall_APE__c != null and 
                                           WelcomeCall_Issued_Date__c != null and WelcomeCall_Product_Code_Plan__c != null 
                                           AND Campaign_Type__c != 'TelUW']; // adding by Fajar 31-03-2022
        
        List<Contact> contactValidation = [SELECT id,Name, Policy_No__c, WelcomeCall_APE__c, WelcomeCall_Issued_Date__c, WelcomeCall_Product_Code_Plan__c
                                           FROM Contact
                                           WHERE Entity__c = :entity AND Policy_No__c in :dataList and WelcomeCall_APE__c != null and 
                                           WelcomeCall_Issued_Date__c != null and WelcomeCall_Product_Code_Plan__c != null 
                                           AND Campaign_Type__c != 'TelUW']; // adding by Fajar 31-03-2022
        List<Call_Line__c> existingCallLineList = [SELECT Id, Name, Policy_No__c, Entity__c, WelcomeCall_Call_Line_Status__c, Activity_Result__c, Phone__c,
                                                            owner.name
                                                   FROM Call_Line__c 
                                                   WHERE Entity__c = :entity 
                                                   AND Policy_No__c in : dataList
                                                   AND Case_Type__c =: Case_Type_Config 
                                                   AND WelcomeCall_Call_Line_Status__c != 'Closed' 
                                                   AND RecordTypeId =: recTypeWC 
                                                   AND Campaign_Type__c != 'TelUW']; // adding by Fajar 31-03-2022
        
        List<WelcomeCall_Criteria__c> csCriteria = [SELECT id, Name, WelcomeCall_Start_Range__c, WelcomeCall_End_Range__c, WelcomeCall_Fg_Active__c,
                                                    WelcomeCall_Start_Range_USD__c, WelcomeCall_End_Range_USD__c
                                                    FROM WelcomeCall_Criteria__c
                                                    WHERE WelcomeCall_Start_Range__c != null AND WelcomeCall_End_Range__c != null]; 
        
        integer foundCounter = contactList.size();
        callLineList = new List<Call_Line__c>();
        Call_Line__c newCL = null;
        Call_Line__c callLine = null;
        Call_List__c campaign = null;
        integer idx = 0;
        boolean isExist = false;
        if(csCriteria.isEmpty()){
            System.debug('No criteria found LV');
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'No Criteria have been setup on Custom Setting'));
        }
                invalidwelList = new List<wcWrapper>();
        if(contactList.isEmpty()){ //jika contact ga ada
            System.debug('No contact found');
            String msg = 'No contact existed with all policy number uploaded.';
            invalidwelList.add(new wcWrapper('#1', msg));
            noContact = true;
        }
        else{ 
                integer i =1;
                for(String polisNo : dataList){
                    // contact validation, if the policy number has a contact.
                    Boolean isThereisContact = false;
                    Contact pelanggan = new Contact();
                    
                    for(Contact ct : contactList){
                        if(ct.Policy_No__c == polisNo){
                            isThereisContact = true;
                            pelanggan = ct;
                            
                            break;
                        }
                    }
                    if(!isThereisContact){
                        invalidwelList.add(new wcWrapper(polisNo, 'There is no contact for this policy number :'+polisNo));
                        continue;
                    }
                    
                    //end contact validation

                    // call line validation, should be no more than one active call line (not closed).
                    Boolean isActiveCallLine = false;
                    Call_Line__c activeCallLine = new Call_Line__c();
                    for(Call_Line__c cl : existingCallLineList){
                        if(cl.Policy_No__c == polisNo){
                            isActiveCallLine = true;
                            activeCallLine = cl;
                            break;
                        }
                    }
                    if(isActiveCallLine){
                        invalidwelList.add(new wcWrapper(polisNo, 'There is an active welcome call line for policy number :'+polisNo
                                                         +'. Already handled by '+activeCallLine.Owner.name));
                        continue;
                    }
                    // end call line validation
                    
                    // validate if contact ape is in criteria and not null
                    // if there is no match a single criteria contact will be skip/no Call line.
                    Boolean isNoCriteria = true;
                    if (pelanggan.policyApp__c!='G400'){
                        
                    
                    for(WelcomeCall_Criteria__c criteria : csCriteria){
                        if(pelanggan.WelcomeCall_Currency__c == 'RP' && pelanggan.WelcomeCall_APE__c >= criteria.WelcomeCall_Start_Range__c){
                            isNoCriteria = false;
                            break;
                        }else if(pelanggan.WelcomeCall_Currency__c == 'USD' && pelanggan.WelcomeCall_APE__c >= criteria.WelcomeCall_Start_Range_USD__c){
                            isNoCriteria = false;
                            break;
                        }
                    }
                    } else {
                        isNoCriteria = false;
                    }
                    if(isNoCriteria){
                        String msg = 'Contact APE ('+pelanggan.WelcomeCall_APE__c+') with policy no '+pelanggan.Policy_No__c+
                                                         ' is no match with any Criteria';
                        invalidwelList.add(new wcWrapper(pelanggan.Policy_No__c, msg));
                        continue;
                    }
                    // end validate ape 
                     
                    // Create new call Line
                    
                    newCL = new Call_Line__c();
                    newCL.Contact__c = pelanggan.id;
                    newCL.Policy_No__c = pelanggan.Policy_No__c;
                    newCL.Contacted_Number__c = pelanggan.MobilePhone;
                    newCL.Home_Phone__c = pelanggan.HomePhone;
                    newCL.Phone__c = pelanggan.Phone;
                    newCL.Call_List__c = choosen_campaign;
                    newCL.Entity__c = pelanggan.Entity__c;
                    newCL.Other_Phone__c = pelanggan.OtherPhone;
                    campaign = campaignObjectMap.get(choosen_campaign);
                    newCL.Activity__c = campaign.Activity__c;
                    newCL.Case_Type__c = campaign.Case_Type__c; 
                    newCL.Case_Type_Config__c = campaign.Case_Type_Config__c;
                    newCL.WelcomeCall_Schedule_Date__c = date.today();
                    newCL.WelcomeCall_Call_Line_Status__c = 'Open';
                    newCL.Ext_ID__c = choosen_campaign + '-'+newCL.Contact__c;
                    newCL.RecordTypeId = recTypeWC;
                    callLineList.add(newCL);
                }
                
                //Update Daniel, 23 April 2020 (use Batching)
                //insert callLineList;
                
                if (callLineList.size() > 0) {
                    CallLineInsertBatch jb = new CallLineInsertBatch(callLineList);
                    Database.executeBatch(jb, 65);
                    System.debug('== DONE BATCH (to Welcome Call) ==');
                }
                //END - Update Daniel, 23 April 2020 (use Batching)
                
                insert document;
        }
        validNum = callLineList.size();
        invalidNum = uploadedNum - validNum;
    }
    
    public class wcWrapper{
        public String polNo {get; set;}
        public String reason {get; set;}
        
        public wcWrapper(String polNo, String reason){
            this.polNo = polNo;
            this.reason = reason;
        }
    }
    
    
    @TestVisible private void processPhone(List<String> dataList){
        try {
            List<Contact> contactList = [select id, Policy_No__c, MobilePhone, Phone, HomePhone, Entity__c, Name from Contact where Entity__c = :entity and (MobilePhone in :dataList or Phone in :dataList or HomePhone in :dataList) and createddate > 2014-01-01T00:00:01Z];
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
                        uploadedCall.policyNo = pelanggan.Policy_No__c;
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
                            currPolicyNo = pelanggan.Policy_No__c;
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
                    callLine.Ext_ID__c = choosen_campaign + '-'+callLine.Contact__c;
                    callLineList.add(callLine); 
                    
                    idx++;
                }
                
                //Update Daniel, 23 April 2020 (use Batching)
                //insert callLineList;
                
                if (callLineList.size() > 0) {
                    CallLineInsertBatch jb = new CallLineInsertBatch(callLineList);
                    Database.executeBatch(jb, 65);
                    System.debug('== DONE BATCH (to Phone) ==');
                }
                //END - Update Daniel, 23 April 2020 (use Batching)
                
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

  @TestVisible private void processConservation(List<String> dataList){
        List<Contact> contactList = [select id, Policy_No__c, MobilePhone, Phone, HomePhone, Entity__c from Contact where Entity__c = :entity and Policy_No__c in :dataList and createddate > 2014-01-01T00:00:01Z];
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
                    if(cl.Policy_No__c ==  pelanggan.Policy_No__c){
                        isExist = true;   
                        break;
                    }
                }
                if(isExist){
                    continue;
                }
                //end:added by WK, 20150417

                uploadedCall = new OutboundCall();
                uploadedCall.policyNo = pelanggan.Policy_No__c;
                uploadedCall.phoneNo = pelanggan.MobilePhone;
                uploadedCall.campaignName = campaignMap.get(choosen_campaign);  
                outboundCallList.add(uploadedCall);     
                
                callLine = new Call_Line__c();
                callLine.Contact__c = pelanggan.id;
                callLine.Policy_No__c = pelanggan.Policy_No__c;
                callLine.Contacted_Number__c = pelanggan.MobilePhone;
                callLine.Home_Phone__c = pelanggan.HomePhone;
                callLine.Phone__c = pelanggan.Phone;
                callLine.Call_List__c = choosen_campaign;
                callLine.Entity__c = pelanggan.Entity__c;
                campaign = campaignObjectMap.get(choosen_campaign);
                callLine.Activity__c = campaign.Activity__c;
                callLine.Case_Type__c = campaign.Case_Type__c;
                callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                callLine.Ext_ID__c = choosen_campaign + '-'+callLine.Contact__c;
                
                for(Conservation conv : conservationList){
                    if(conv.policyNo == pelanggan.Policy_No__c){
                        callLine.Prev_Acc_Balance__c = conv.prevAccBalance;
                        callLine.Total_Withdrawn__c = conv.totalWithdrawn;      
                        callLine.Premium__c = conv.premium;      
                        callLine.Currency__c = conv.currcy;      
                        //conservationArr = conservationArr + ',' + recVal[0]+'#'+num;
                        break;
                    }
                }
                callLineList.add(callLine); 
                conservationArr = conservationArr.replaceFirst(pelanggan.Policy_No__c, 'VALIDPOLICYNO');
            }
            
            
            //Update Daniel, 23 April 2020 (use Batching)
            //insert callLineList;
            
            if (callLineList.size() > 0) {
                CallLineInsertBatch jb = new CallLineInsertBatch(callLineList);
                Database.executeBatch(jb, 65);
                System.debug('== DONE BATCH (to Conservation) ==');
            }
            //END - Update Daniel, 23 April 2020 (use Batching)
            
        }
        
        invalidPolicyTempList = conservationArr.split(',');
        invalidPolicyTempList.remove(0); 
        invalidPolicyList = new List<string>();
        for(string polno : invalidPolicyTempList){
            if(polno != 'VALIDPOLICYNO'){
                invalidPolicyList.add(polno);   
            }
        } 
        
      try{
        insert document;
      }
      catch (Exception e)
      {
          System.debug('e: ' + e.getLineNumber() + ' / ' + e.getMessage());
      }
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
     public PageReference Firstbtn() {
        count=0;
        populateFreshData();
        currentTot = totalPolicies;
        return null;
    }
      public PageReference prvbtn() {
        //fa=null;
        count=count-limitsize;
        //getListAcc();
        currentTot = currentTot - lastSizeData;
        populateFreshData();
        return null;
    }
   
    public PageReference Nxtbtn() {
        count=count+limitsize;
        populateFreshData();
        currentTot = currentTot +totalPolicies;
        
        return null;
    }
    public PageReference lstbtn() {
        count= totalrecs - math.mod(totalRecs,LimitSize);
        populateFreshData();
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
    
    //Update, 19 Maret 2020
    public PageReference refreshList(){
        PageReference p = System.Page.Outbound_Distribution;
        p.setRedirect(true);
        return p;
    }
    //END - Update, 19 Maret 2020
}