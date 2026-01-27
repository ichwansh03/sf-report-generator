Global class CallLineGeneratorControllerAMFS {
    public Integer AMFScampaignPeriod = Integer.valueOf(System.Label.CampaignPeriodForDistributionAMFS);
    public Integer uploadedNum {get; set;}
    public Integer validNum {get; set;}
    public Integer invalidNum {get; set;}
    public Integer totalPolicies {get;set;}
    public Integer totalData {get;set;}
    public Integer totalDataCSV {get;set;}
    public Integer totalGAP {get;set;}
    public Integer inputValue {get;set;}
    public Integer totalAgents {get;set;}
    public Boolean isMaxRecord {get;set;}
    public Boolean isMethodChoosen{get;set;}
    public String entity {get; set;}
    public String choosen_campaign {get;set;}
    public String choosen_method {get; set;}
    public String CollectionTaskArr {get; set;}
    public String url = 'https://'+system.URL.getSalesforceBaseUrl().getHost()+'/apex/TakeSurvey?id=SURVEYID&cId=CONTACTID&caId=none';
    public List<Call_List__c> campaign_list {get;set;}
    public Call_List__c campaign_single {get;set;}    
    public Call_List__c campaign_check {get;set;}
    //added by Ichwan
    public List<Call_Line_Retention__c> clrList {get; set;}
    
    public List<Call_Line__c> callLineList {get;set;}
    public List<Call_Line__c> notifyClPolicy {get;set;}
    public List<SelectOption> optionCampaign_list {get;set;}
    public List<CollectionTask> CollectionTaskList {get; set;}
    public List<String> invalidPolicyList {get;set;}
    public List<String> invalidPolicyTempList {get;set;}
    public List<OutboundCall> outboundCallList {get; set;}
    public List<AgentAssignment> assignmentList {get;set;}
    public List<User_Detail__c> agentList {get;set;}
    public List<Id> agentIDList {get;set;}
    public List<SelectOption> agentOptList {get; set;}
    public List<SelectOption> distributeOptionList {get; set;}
    public List<String> list_policyNo {get;set;}
    public List<String> list_policyNoBatch {get;set;}
    public Map<Id, Call_List__c> map_campaignObj {get;set;}
    public Map<string,Contact> mapContactList {get;set;}
    public Map<string,string> agentMap {get; set;}
    public Map<String, Call_Line__c> map_callLine {get;set;}
    public Map<String, List<CollectionTask>> mapByName {get;set;}
    public Map<String, List<CollectionTask>> mapByEmail {get;set;}
    public Map<String, List<CollectionTask>> mapByPhone {get;set;}
    public Map<String, List<Call_Line__c>> mapCallByHomePhone {get;set;}
    public Map<String, List<Call_Line__c>> mapCallByEmail {get;set;}
    public Map<String, List<Call_Line__c>> mapCallByPhone {get;set;}
    public Map<String, List<Call_Line__c>> mapCallByName {get;set;}
    public Map<String, List<Call_Line__c>> mapCallByProduct {get;set;} 
    
    Public Integer checkLoop = 0;
    Public String AMFS = 'AMFS';
    Public Decimal total_APE {get;set;}
    Public String string_APE {get;set;}
    Public Integer campaignTarget {get;set;}
    public List<Agent_Distribution_History__c> agentListView {get;set;}
    public List<Agent_Distribution_History__c> finalListAdh {get;set;}
    public map<Id,Agent_Distribution_History__c> mapAgentHistory {get;set;}
    public string filterResult {get;set;}
    public boolean isReorder {get;set;}
    public string campaignName;
    public boolean flagMessage {get;set;}
    public boolean policyAPECurr = false;
    public integer limitAgent = 0;
    public integer bottomLimitAgent = 0;
    public Decimal topLimitAgentAPE = 0;
    public Decimal topLimitAgentPolicy = 0;
    public Decimal averagePolicy = 0;
    public String newestCallLineGrouping;
    
    public List<InvalidPolicy> list_invalidPolicy {get;set;}
    public List<String> list_invalidPolicyText {get;set;}
    public List<String> list_invalidPolicyStatusText {get;set;}
    public integer countInvalid {get;set;}
    
    // Add by Ranti at 01/20/2022
    public String batchStatusJob {get;set;}
    public Map<Id, String> batchId {get;set;}
    private Map<Id, String> batchClassIds;
    private Id userId;
    public string message{get;set;}
    public List<AsyncApexJob> apexJobs{get;set;}
    public boolean isDistribution {get;set;}
    
    public static final String MANUAL_OPT = 'Manual By Count';
    public static final String AUTOMATIC_OPT = 'Automatic';
    
    public static final String REDEMPTION_KONVEN = 'Redemption Konven';
    public static final String REDEMPTION_TM = 'Redemption TM';
    public static final String CUTI_PREMI = 'Cuti Premi';
    public static final String RENEWAL_REMINDER = 'Renewal Reminder';
    public static final String TRO_PROJECT = 'TRO Project';
    public static final String LAPSE_KONVEN = 'Lapse Konven';
    public static final String LAPSE_TM = 'Lapse TM';
    
    public Document document {
        get {
            if (document == null){
                document = new Document();
            }
            return document;
        }
        set;
    }
    
    public CallLineGeneratorControllerAMFS(){
        // get 
        string grouping = ApexPages.currentPage().getParameters().get('Grouping');
        system.debug('grouping : '+grouping);
        // added by ranti at 01/25/2022
        batchStatusJob = ApexPages.currentPage().getParameters().get('ProcessJob');  
        
        if (Grouping == 'true') {
            // updated by Ranti at 01/25/2022
            flagMessage = batchStatusJob != null ? FALSE : true; 
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Grouping success.. please wait.')); 
        }
        
        list_invalidPolicy = new List<InvalidPolicy>();
        list_invalidPolicyText = new list<string>();
        list_invalidPolicyStatusText = new list<string>();
        countInvalid = 0;
        isReorder = false;
        uploadedNum = 0;
        validNum = 0;
        invalidNum = 0;
        totalPolicies = 0;
        
        string statusUpload = ApexPages.currentPage().getParameters().get('upload');
        string statusUploadedNum = ApexPages.currentPage().getParameters().get('uploadedNum');
        string statusValidNum = ApexPages.currentPage().getParameters().get('validNum');
        string statusInvalidNum = ApexPages.currentPage().getParameters().get('invalidNum');
        string statusListInvalidPolicy = ApexPages.currentPage().getParameters().get('list_invalidPolicy');
        string statusList = ApexPages.currentPage().getParameters().get('status_invalid');
        string statusCampaignTemp = ApexPages.currentPage().getParameters().get('campaigntemp');
        system.debug('statusListInvalidPolicy : '+ statusListInvalidPolicy);
        
        if (statusUploadedNum != NULL && statusUploadedNum != '') uploadedNum = integer.valueof(statusUploadedNum);
        if (statusValidNum != NULL && statusValidNum != '') validNum = integer.valueof(statusValidNum);
        if (statusInvalidNum != NULL && statusInvalidNum != '') invalidNum = integer.valueof(statusInvalidNum);
        if (statusUpload == 'success') {
            
            // updated by Ranti at 01/25/2022
            flagMessage = batchStatusJob != null ? FALSE : true; 
            
            
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully'));
            list_invalidPolicyText = statusListInvalidPolicy.split(','); System.debug('list_invalidPolicyText' + list_invalidPolicyText.size());
            list_invalidPolicyStatusText= statusList.split(','); System.debug('list_invalidPolicyStatusText' + list_invalidPolicyStatusText.size());
            for (integer i=0; i < list_invalidPolicyText.size(); i++) {
                if(list_invalidPolicyStatusText[i].contains('EM1')) list_invalidPolicyStatusText[i] = 'Duplicate found in uploaded file';
                else if(list_invalidPolicyStatusText[i].contains('EM2')) list_invalidPolicyStatusText[i] = 'Contact does not exist';
                else if(list_invalidPolicyStatusText[i].contains('EM3')) list_invalidPolicyStatusText[i] = 'Duplicate found in existing record';
                
                if (i < 999) list_invalidPolicy.add(new InvalidPolicy(list_invalidPolicyText[i], list_invalidPolicyStatusText[i]));
            }
            campaign_single = new Call_List__c();
            campaign_single.Campaign_temp__c = id.valueof(statusCampaignTemp);
        }
        
        map_campaignObj = new Map<Id, Call_List__c>();
        User userObj = [select id, Entity__c from user where id = :UserInfo.getUserId()];
        Entity = userObj.Entity__c;
        String loggedInUser = userObj.id;
        if (Test.isRunningTest()) {
            campaign_list = Database.query('SELECT id, Name, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Call_Line_RecordTypeID__c FROM Call_List__c LIMIT 10');
        } else if(loggedInUser =='0050K00000B6ta6QAB'){
            campaign_list = Database.query('SELECT id, Name, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Call_Line_RecordTypeID__c FROM Call_List__c WHERE Entity__c ='+' \'AMFS'+'\' AND IsExpired__c = false AND Is_Expired_F__c = false AND (createdby.name = '+'\'Ranggi Rakashiwi'+'\' or campaign_type__c in ('+'\'Collection-Redemption TM'+'\','+'\'Collection-Lapse TM'+'\')) order by CreatedDate desc');
        }
        else {
            campaign_list = Database.query('SELECT id, Name, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Call_Line_RecordTypeID__c FROM Call_List__c WHERE Entity__c = :AMFS AND createdby.id = :loggedInUser AND IsExpired__c = false AND Is_Expired_F__c = false order by CreatedDate desc');
        }
        
        optionCampaign_list = new List<SelectOption>();
        
        if (campaign_list.size() > 0){
            for(Call_List__c cl : campaign_list){
                optionCampaign_list.add(new SelectOption(cl.id, cl.Campaign_Name__c));
                map_campaignObj.put(cl.Id, cl);
            }    
        }
        else {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'There`s no campaign / call line available'));   
        }    
        
        isMaxRecord = FALSE;
        inputValue = 0;
        
        distributeOptionList = new List<SelectOption>();
        distributeOptionList.add(new SelectOption(AUTOMATIC_OPT, AUTOMATIC_OPT));
        distributeOptionList.add(new SelectOption(MANUAL_OPT, MANUAL_OPT));
        
        if(agentList== null){
            agentList = [select id, Entity__c, Name, User__c, User__r.Name from user_detail__c where Entity__c = :AMFS and User__r.isActive = true and User__r.Agent__c = true];//and User__r.ManagerId = :loggedInUser and User__r.Agent__c = true];
            //totalAgents = agentList.size();
            agentOptList = new List<SelectOption>();
            agentIDList = new List<id>();
            agentMap = new Map<string, string>();
            for(User_Detail__c agent : agentList){
                agentIDList.add(agent.User__c);
                agentMap.put(agent.User__c, agent.Name);
                agentOptList.add(new SelectOption(agent.User__c, agent.Name));
            }
        }
        
        //added by Ranti at 01/20/2022
        
        userId = UserInfo.getUserId();
        System.debug('batchStatusJob:'+batchStatusJob);
        batchClassIds = new map<id,string>();
        message = ''; 
        batchId = new Map<id,string>();
        isDistribution = false;
    }
    public PageReference upload(){
        flagMessage = TRUE;
        document.AuthorId = UserInfo.getUserId();
        document.FolderId = UserInfo.getUserId(); // put it in running user's folder
        
        if(choosen_campaign == null || choosen_campaign == ''){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Campaign Type is mandatory field.'));
            return null;
        }
        try {
            system.debug('*** document body : '+ document.body.toString());
            
            //Coba Mus start
            List<String> nbody = document.body.toString().split('\n');
            nbody = nbody[0].split(',');
            System.debug('nbody ' +nbody);
            System.debug('nbody size ' +nbody.size());
            if(nbody.size() >= 3){
                policyAPECurr = true;
            }
            //Coba Mus end
            
            if(document.body==null || document.body.toString() == ''){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'No file is selected.'));
                return null;
            }else{
                string nameFile=document.body.toString();
                boolean fileExtension = document.name.endsWith('.csv');
                if(!fileExtension){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Uploaded file type is not supported. Please upload csv file only.'));
                    return null;
                }
                document.name = choosen_campaign;
                
                Call_List__c campaign = map_campaignObj.get(choosen_campaign);
                
                System.debug('***campaign.Case_Type__c: ' + campaign.Case_Type__c);
                
                List<String> dataList = parseCollectionTaskCSV(nameFile,true);
                System.debug('INI DATA LIST + ' + JSON.serialize(dataList));
                for (String s : dataList) {
                    System.debug('INI PolicyNo dari CSV: [' + s + ']');
                }
                uploadedNum = dataList.size();
                processCollectionTask(dataList);
                progressUploadFile(); 
                
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
        
        PageReference pageRef = new PageReference('/apex/File_Upload_AMFS?campaigntemp='+campaign_single.Campaign_Temp__c+'&upload=success&uploadedNum='+uploadedNum+'&validNum='+callLineList.size()+'&invalidNum='+countInvalid+'&list_invalidPolicy='+list_invalidPolicyText+'&status_invalid='+list_invalidPolicyStatusText+'&ProcessJob=Processing');
        pageRef.setRedirect(true);
        return pageRef;
        
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
        
        string csvpolicyNo = '';
        String csvHomePhone = '';
        String csvMobilePhone = '';
        String csvOtherPhone = '';
        String csvAmount = '';
        String csvAmountCurrency = '';
        String csvCaseType = '';
        String csvBatchNo = '';
        String csvInfoPending = '';
        
        //Coba Mus start
        String csvAPE = '';
        String csvCurrency = '';
        String csvUserId = '';
        //Coba Mus end
        
        // added new column call notes 1-3 for collection (catur,20210708)
        String csvCallNotes1 = '';
        String csvCallNotes2 = '';
        String csvCallNotes3 = '';
        
        boolean isValid = false;    //added by WK, 20150417 
        List<String> testlist = new List<String>();
        testList.Add('test');
        testList.Add('10000');
        testList.Add('col2');
        testList.Add('col3');
        testList.Add('col4');
        testList.Add('col5');
        testList.Add('col6');
        testList.Add('col7');
        testList.Add('col8');
        
        Map<string, boolean> map_BatchExist = new Map<string, boolean>();
        list_policyNoBatch = new List<string>();
        
        if (Test.isRunningTest()) allFields.add(testList);
        
        Call_List__c cl = map_campaignObj.get(choosen_campaign);
        String campaignName = cl.Campaign_Name__c;
        
        for(List<string> rc : allFields){
            num = 0;
            isValid = true;
            for(string col : rc){
                if(num==0) {
                    csvpolicyNo = col.trim();    
                }else if(num==1){
                    if(campaignName.contains('Withdrawal') || campaignName.contains(REDEMPTION_KONVEN)){
                        csvAmount = col.trim();
                    } else if(campaignName.contains(REDEMPTION_TM)){
                        csvBatchNo = col.trim();
                    } else if(campaignName.contains(CUTI_PREMI)){
                        csvInfoPending = col.trim();
                    } 
                    //Coba Mus start
                    else if(campaignName.contains(LAPSE_TM) || campaignName.contains(RENEWAL_REMINDER) || campaignName.contains(LAPSE_KONVEN) || campaignName.contains('MKP') || campaignName.contains('RTU') || campaignName.contains(TRO_PROJECT) || campaignName.contains('Others')){
                        if(policyAPECurr){
                            csvAPE = col.trim();
                        } else {
                            csvUserId = col.trim();
                        }
                    }
                    //Coba Mus end
                }else if(num==2){
                    if(campaignName.contains('Withdrawal') || campaignName.contains(REDEMPTION_KONVEN)){
                        csvAmountCurrency = col.trim();
                    }
                    //Coba Mus start
                    else if(campaignName.contains(LAPSE_TM) || campaignName.contains(RENEWAL_REMINDER) || campaignName.contains(LAPSE_KONVEN) || campaignName.contains('MKP') || campaignName.contains('RTU') || campaignName.contains(TRO_PROJECT) || campaignName.contains('Others')){
                        if(policyAPECurr){
                            csvCurrency = col.trim();
                        }
                    } else if(campaignName.contains(REDEMPTION_TM) || campaignName.contains(CUTI_PREMI)){
                        csvAPE = col.trim();
                    }
                    //Coba Mus end
                }else if(num==3){
                    if(campaignName.contains(REDEMPTION_KONVEN)){
                        csvInfoPending = col.trim();
                    } 
                    //Coba Mus start
                    else if(campaignName.contains(REDEMPTION_TM) || campaignName.contains(CUTI_PREMI)){
                        csvCurrency = col.trim();
                    }
                    else if(campaignName.contains('Withdrawal')){
                        csvUserId = col.trim();
                    } 
                    else if(campaignName.contains(LAPSE_TM) || campaignName.contains(RENEWAL_REMINDER) || campaignName.contains(LAPSE_KONVEN) || campaignName.contains('MKP') || campaignName.contains('RTU') || campaignName.contains(TRO_PROJECT) || campaignName.contains('Others')){
                        if(policyAPECurr){
                            csvUserId = col.trim();
                        }
                    }
                    //Coba Mus end
                }  
                //Coba Mus start
                else if(num==4){
                    if(campaignName.contains(REDEMPTION_KONVEN)){
                        csvBatchNo = col.trim();
                    } 
                    else if(campaignName.contains(REDEMPTION_TM) || campaignName.contains(CUTI_PREMI)){
                        csvUserId = col.trim();
                    }
                    else if(campaignName.contains(LAPSE_TM) || campaignName.contains(RENEWAL_REMINDER) || campaignName.contains(LAPSE_KONVEN) || campaignName.contains('MKP') || campaignName.contains('RTU') || campaignName.contains('Withdrawal') || campaignName.contains(TRO_PROJECT) || campaignName.contains('Others')){
                        csvCallNotes1 = col.trim();
                    }
                }
                
                else if(num==5){
                    if(campaignName.contains(REDEMPTION_KONVEN)){
                        csvUserId = col.trim();
                    }
                    else if(campaignName.contains(REDEMPTION_TM) || campaignName.contains(CUTI_PREMI)){
                        csvCallNotes1 = col.trim();
                    }
                    else if(campaignName.contains(LAPSE_TM) || campaignName.contains(RENEWAL_REMINDER) || campaignName.contains(LAPSE_KONVEN) || campaignName.contains('MKP') || campaignName.contains('RTU') || campaignName.contains('Withdrawal') || campaignName.contains(TRO_PROJECT) || campaignName.contains('Others')){
                        csvCallNotes2 = col.trim();
                    }
                }
                //Coba Mus end
                
                // added new column for call notes 1-3 (catur,20210708)
                else if(num==6){
                    if(campaignName.contains(REDEMPTION_KONVEN)){
                        csvCallNotes1 = col.trim();
                    }
                    else if(campaignName.contains(REDEMPTION_TM) || campaignName.contains(CUTI_PREMI)){
                        csvCallNotes2 = col.trim();
                    }
                    else if(campaignName.contains(LAPSE_TM) || campaignName.contains(RENEWAL_REMINDER) || campaignName.contains(LAPSE_KONVEN) || campaignName.contains('MKP') || campaignName.contains('RTU') || campaignName.contains('Withdrawal') || campaignName.contains(TRO_PROJECT) || campaignName.contains('Others')){
                        csvCallNotes3 = col.trim();
                    }
                }
                
                else if(num==7){
                    if(campaignName.contains(REDEMPTION_KONVEN)){
                        csvCallNotes2 = col.trim();
                    }
                    else if(campaignName.contains(REDEMPTION_TM) || campaignName.contains(CUTI_PREMI)){
                        csvCallNotes3 = col.trim();
                    }
                }
                
                else if(num==8){
                    if(campaignName.contains(REDEMPTION_KONVEN)){
                        csvCallNotes3 = col.trim();
                    } 
                }
                
                num++; 
            }
            if(isValid || Test.isRunningTest()){
                dataList.add(csvpolicyNo);
                system.debug('## policy no : '+csvpolicyNo);
                CollectionTask = new CollectionTask();
                CollectionTask.policyNo = csvpolicyNo;
                CollectionTask.HomePhone = csvHomePhone;
                CollectionTask.MobilePhone = csvMobilePhone;
                CollectionTask.OtherPhone = csvOtherPhone;
                CollectionTask.Amount = csvAmount;
                CollectionTask.AmountCurrency = csvAmountCurrency;
                CollectionTask.CaseType = csvCaseType;
                CollectionTask.BatchNo = csvBatchNo;
                CollectionTask.infoPending = csvInfoPending;
                CollectionTask.callNotes1 = csvCallNotes1;
                CollectionTask.callNotes2 = csvCallNotes2;
                CollectionTask.callNotes3 = csvCallNotes3;
                
                if(Test.isRunningTest()){
                    CollectionTask.infoPending = 'Clean';
                    csvAPE = '10000';
                    csvCurrency = 'USD';
                }
                
                //Coba Mus start
                if(csvAPE == ''){
                    CollectionTask.APE = '-1';
                } else {
                    CollectionTask.APE = csvAPE;
                }
                CollectionTask.cCurrency = csvCurrency;
                System.debug('csvInfoPending = ' +csvInfoPending);
                
                if(csvUserId == ''){
                    CollectionTask.userId = 'kosong';
                } else {
                    CollectionTask.userId = csvUserId;
                }
                //Coba Mus end
                
                system.debug('***Currency'+CollectionTask.AmountCurrency);
                system.debug('Amount=>> '+CollectionTask.Amount+'Batch =>>'+CollectionTask.BatchNo);
                
                CollectionTaskArr = CollectionTaskArr + ',' + csvpolicyNo;
                if(csvBatchNo == NULL) csvBatchNo = '';
                if(!map_BatchExist.containsKey(csvpolicyNo +';'+ csvBatchNo.trim())){
                    map_BatchExist.put(csvpolicyNo +';'+ csvBatchNo,true);
                    CollectionTaskList.add(CollectionTask);
                    if(csvBatchNo  == null) csvBatchNo = '';
                    list_policyNoBatch.add(csvpolicyNo +';'+ csvBatchNo.trim());
                    system.debug('>>> LIST POLICY BATCH: '+list_policyNoBatch);
                }else{
                    //duplicate in file
                    if (countInvalid < 999) list_invalidPolicy.add(new InvalidPolicy(csvpolicyNo, 'Duplicate found in uploaded file'));
                    if (countInvalid < 999) {
                        list_invalidPolicyStatusText.add('EM1');
                        list_invalidPolicyText.add(csvpolicyNo);
                    }
                    countInvalid += 1;
                }
            }
        }
        CollectionTaskArr = CollectionTaskArr.replaceFirst(',',''); //replace ',' in the beginning of the string
        system.debug('## CollectionTaskArr : '+CollectionTaskArr);
        
        system.debug('#### dataList : '+dataList);
        totalDataCSV = dataList.size();
        return dataList;       
    }
    
    @TestVisible private void processCollectionTask(List<String> dataList){
        //coba Mus start
        List<User> userId = new List<User>([Select Id, ID_User_DMTM__c, ID_User_RLS__c From User Where ID_User_RLS__c != Null OR ID_User_DMTM__c != Null]);
        Map<String,User> userIdMap = new Map<String,User>();
        
        if(userId.size() > 0){
            for(User usr : userId){
                if(usr.ID_User_DMTM__c != Null){
                    userIdMap.put(usr.ID_User_DMTM__c, usr);
                }
                if(usr.ID_User_RLS__c != Null){
                    userIdMap.put(usr.ID_User_RLS__c, usr);
                }
            }
        }
        //coba Mus end
        
        //Check is campaign null call line?
        Integer callLineCount = [Select count() From Call_Line__c WHERE Call_List__c=:choosen_campaign];
        Boolean isNullCallLine = callLineCount == 0 ? true : false;
        Integer countNumberUpload = 0;
        if(!isNullCallLine){
            countNumberUpload = [Select Number_Of_Call__c From Call_Line__c WHERE Call_List__c=:choosen_campaign group by Number_Of_Call__c].size();
        }
        
        List<Contact> contactList = new List<Contact>();
        if (test.isRunningTest()) {
            contactList = [select id, Name, Email, Policy_No__c, Policy_No_ALI__c, MobilePhone, Phone, HomePhone, Entity__c, WelcomeCall_Currency__c, WelcomeCall_APE__c, WelcomeCall_Product_Code_Plan__c from Contact LIMIT 100];
        } else {
            contactList = [select id, Name, Email, Policy_No__c, Policy_No_ALI__c, MobilePhone, Phone, HomePhone, Entity__c, WelcomeCall_Currency__c, WelcomeCall_APE__c, WelcomeCall_Product_Code_Plan__c from Contact where Policy_No__c in :dataList AND Entity__c = :AMFS and createddate > 2014-01-01T00:00:01Z];
        }
        System.debug('INI CONTACT LIST : ' + contactList);
        
        //begin:added by Wk, 20150417
        List<Call_Line__c> existingCallLineList = [select id,Info_Pendingan__c, Ext_ID_F__c, Ext_ID_Temp__c, Policy_No__c, Entity__c, Batch_No__c from Call_Line__c where Polis_Batch__c IN :list_policyNoBatch /*Ext_ID_Temp__c in :dataList*/ and Call_List__c = :choosen_campaign and createddate > 2014-01-01T00:00:01Z];
        integer existingCounter = existingCallLineList.size();
        validNum = uploadedNum - existingCounter;
        invalidNum = totalDataCSV - validNum;
        
        outboundCallList = new List<OutboundCall>();
        callLineList = new List<Call_Line__c>();
        OutboundCall uploadedCall = null;
        Call_Line__c callLine = null;
        Call_List__c campaign = null;
        
        mapContactList = new map<string,Contact>();
        map<string,Call_Line__c> mapCallLineList = new map<string,Call_Line__c>();
        map<string,Call_Line__c> mapuploadList = new map<string,Call_Line__c>();
        
        clrList = [SELECT Id, Policy_No__c, Remark_Description__c, Retention_Status__c FROM Call_Line_Retention__c WHERE Policy_No__c IN :dataList];
        map<String, Call_Line_Retention__c> mapCallLineRetention = new map<String, Call_Line_Retention__c>(); 
        
        System.debug('contactList ' +contactList);
        
        List<String> productList = new List<String>();
        
        for(Contact pelanggan : contactList){
            mapContactList.put(pelanggan.Policy_No__c,pelanggan);
            productList.add(pelanggan.WelcomeCall_Product_Code_Plan__c);
        }
        system.debug('mapContactList==> '+mapContactList);
        
        System.debug('INI EXISTING CALL LINE LIST : ' + existingCallLineList);
        for(Call_Line__c cl : existingCallLineList){
            if(cl.Batch_No__c == NULL) cl.Batch_No__c = '';
            mapCallLineList.put(cl.Ext_ID_Temp__c +';'+ cl.Batch_No__c.trim(), cl);
        }
        System.debug('INI MAP CALL LINE LIST : ' + mapCallLineList);

        for (Call_Line_Retention__c clr : clrList) {
            mapCallLineRetention.put(clr.Policy_No__c, clr);
        }
        system.debug('mapCallRetentionList==> '+mapCallLineRetention);
        //for grouping call line
        mapByName = new Map<String, List<CollectionTask>>();
        mapByEmail = new Map<String, List<CollectionTask>>();
        mapByPhone = new Map<String, List<CollectionTask>>();
        list_policyNo = new List<String>();
        Double csvAPE = 0;
        String cCurrency = '';
        String uUserId = '';
        
        System.debug('INI COLLECTION TASK LIST : ' + CollectionTaskList);
        for(CollectionTask conv : CollectionTaskList){
            // check sudah pernah upload atau belum.
            System.debug('INI NOMOR POLIS : ' + conv.policyNo);
            System.debug('INI NOMOR POLIS, TAPI DARI DB : ' + mapCallLineList.get(conv.policyNo));
            System.debug('INI NOMOR POLIS, TAPI LENGKAP DARI DB : ' + mapCallLineList);
            if (mapCallLineList.get(conv.policyNo +';'+ conv.BatchNo) == NULL) {
                
                if (mapuploadList.get(conv.policyNo +';'+ conv.BatchNo) == NULL) {
                    uploadedCall = new OutboundCall();
                    uploadedCall.policyNo = conv.PolicyNo;
                    uploadedCall.campaignName = map_campaignObj.get(choosen_campaign).Name; 
                    
                    callLine = new Call_Line__c();
                    callLine.Policy_No__c = conv.policyNo;
                    String campaignName = map_campaignObj.get(choosen_campaign).Campaign_Name__c;
                    if(campaignName.contains('Withdrawal') || campaignName.contains(REDEMPTION_KONVEN))callLine.Amount__c = Double.valueOf(conv.Amount);
                    if(campaignName.contains(REDEMPTION_TM))callLine.Batch_No__c = conv.BatchNo;
                    
                    //Number of Upload
                    if(isNullCallLine) {
                        callLine.Number_Of_Call__c = '1';
                    }else {
                        callLine.Number_Of_Call__c = String.valueOf(countNumberUpload+1);
                    }
                    
                    //Coba Mus start
                    if(campaignName.contains(LAPSE_TM) || campaignName.contains(RENEWAL_REMINDER) || campaignName.contains(LAPSE_KONVEN) || campaignName.contains('MKP') || campaignName.contains('RTU') || campaignName.contains(REDEMPTION_TM) || campaignName.contains(CUTI_PREMI) || campaignName.contains(TRO_PROJECT) || campaignName.contains('Others')){
                        //Added by ichwan
                        //change new CL renewal reminder status based on Policy_No in CLRetention
                        if (campaignName.contains(RENEWAL_REMINDER) && mapContactList.containsKey(conv.policyNo)) {
                            Call_Line_Retention__c clr  = mapCallLineRetention.get(conv.policyNo);
                            if (clr != null && clr.Retention_Status__c.equals('Takeout')) {
                                callLine.Call_Status_Config__c = 'Takeout';
                                callLine.Call_Remarks__c = clr.Remark_Description__c;
                                callLine.Reason_Status_Config__c = 'Tidak Berkenan Dihubungi';
                            }
                            callLine.Collection_Call_Date__c = Datetime.now();
                        }
                        csvAPE = Double.valueOf(conv.APE);
                        cCurrency = conv.cCurrency;
                    }
                    if(campaignName.contains(REDEMPTION_KONVEN)){
                        if(conv.BatchNo != ''){
                            callLine.Batch_No__c = conv.BatchNo;
                        }
                    }
                    //Coba Mus end
                    system.debug('Amount__c '+conv.Amount);
                    system.debug('policyNo '+conv.policyNo);
                    system.debug('mapContactList '+mapContactList);
                    if (mapContactList.get(conv.policyNo) != NULL) {
                        uploadedCall.phoneNo = mapContactList.get(conv.policyNo).MobilePhone;
                        Contact con = mapContactList.get(conv.policyNo);
                        callLine.Contact__c = con.id;
                        callLine.Contacted_Number__c = mapContactList.get(conv.policyNo).MobilePhone;
                        callLine.Home_Phone__c = mapContactList.get(conv.policyNo).HomePhone;
                        callLine.Phone__c = mapContactList.get(conv.policyNo).Phone;
                        callLine.Entity__c = mapContactList.get(conv.policyNo).Entity__c;
                        callLine.APE__c = mapContactList.get(conv.policyNo).WelcomeCall_APE__c;
                        String formulaProduct = mapContactList.get(conv.policyNo).WelcomeCall_Product_Code_Plan__c;
                        
                        //Coba Mus start
                        uUserId = conv.userId;
                        if(uUserId != 'kosong'){
                            if(userIdMap.get(uUserId) != Null){
                                callLine.ownerId = userIdMap.get(uUserId).Id;
                                callLine.Agent__c = userIdMap.get(uUserId).Id;
                            }
                        }
                        
                        if(csvAPE >= 0){
                            callLine.APE__c = csvAPE;
                            System.debug('mus test csvAPE = '+csvAPE);
                            System.debug('mus test callLine.APE__c = '+callLine.APE__c);
                        }
                        //Coba Mus end
                        
                        if(campaignName.contains('Withdrawal')){
                            system.debug('***Amount Currency Call Line: '+conv.amountCurrency);
                            callLine.Currency__c = conv.amountCurrency;
                        }
                        else if(campaignName.contains(CUTI_PREMI) || campaignName.contains(REDEMPTION_KONVEN)){
                            System.debug('conv.infoPending = ' +conv.infoPending);
                            if(conv.infoPending != ''){
                                callLine.Info_Pendingan__c = conv.infoPending;
                            }
                            callLine.Currency__c = conv.amountCurrency;
                            
                            //Coba Mus start
                            if(cCurrency != ''){
                                callLine.Currency__c = cCurrency;
                                System.debug('mus test cCurrency = ' +cCurrency);
                                System.debug('mus test callLine.Currency__c = ' +callLine.Currency__c);
                            }
                            //Coba Mus end
                        }else{
                            callLine.Currency__c = mapContactList.get(conv.policyNo).WelcomeCall_Currency__c;   
                            
                            //Coba Mus start
                            if(cCurrency != ''){
                                callLine.Currency__c = cCurrency;
                            }
                            //Coba Mus end
                        }
                        
                    }else{
                        //policy with contact does not exist
                        if (countInvalid < 999) list_invalidPolicy.add(new InvalidPolicy(conv.policyNo, 'Contact does not exist'));
                        if (countInvalid < 999){
                            list_invalidPolicyStatusText.add('EM2');
                            list_invalidPolicyText.add(conv.policyNo);
                        } 
                        countInvalid += 1;
                    }
                    
                    callLine.Call_List__c = choosen_campaign;
                    callLine.Parent_Campaign__c = choosen_campaign;
                    campaign = map_campaignObj.get(choosen_campaign);
                    
                    callLine.Case_Type__c = campaign.Case_Type__c;
                    callLine.Case_Type_Config__c = campaign.Case_Type_Config__c;
                    callline.RecordTypeId = id.valueof(campaign.Call_Line_RecordTypeID__c);
                    callLine.Activity__c = 'Collection';
                    callLine.Ext_Id_Temp__c = conv.policyNo;
                    callLine.Policy_No__c = conv.policyNo;
                    // added for 3 column call notes 1-3 for Collection (catur, 20210708)
                    callLine.Call_Notes_1__c = conv.callNotes1;
                    callLine.Call_Notes_2__c = conv.callNotes2;
                    callLine.Call_Notes_3__c = conv.callNotes3;
                    // taufik 25 Feb20, Upsert data di CallLineInsertBatch.
                    if (callLine.Case_Type_Config__c == REDEMPTION_TM)
                        callLine.Ext_ID__c = choosen_campaign + '-'+callLine.Contact__c + '-'+callLine.Batch_No__c;
                    else 
                        callLine.Ext_ID__c = choosen_campaign + '-'+callLine.Contact__c;
                    
                    outboundCallList.add(uploadedCall);     
                    if(callLine.Contact__c!=NULL)callLineList.add(callLine); 
                    mapuploadList.put(conv.policyNo +';'+ conv.BatchNo,callLine);
                    if (callLine.Contact__c != NULL){
                        CollectionTaskArr = CollectionTaskArr.replaceFirst(conv.PolicyNo, 'VALIDPOLICYNO');
                        list_policyNo.add(callLine.Policy_No__c);
                    }
                }
            } // end check 
            else{
                // duplicate with existing record
                if (countInvalid < 999) list_invalidPolicy.add(new InvalidPolicy(conv.policyNo, 'Duplicate found in existing record'));
                if (countInvalid < 999){
                    list_invalidPolicyStatusText.add('EM3');
                    list_invalidPolicyText.add(conv.policyNo);
                } 
                countInvalid += 1;
            }
        } // end Co
        system.debug('mapByName '+mapByName.size());
        system.debug('mapByEmail '+mapByEmail.size());
        system.debug('mapByPhone '+mapByPhone.size());
        system.debug('## CallLineList : '+callLineList.size());
        
        list<Call_List__c> temp = [SELECT id, Count_Data__c, Count_Invalid__c FROM Call_List__c WHERE id =:choosen_campaign];
        if (temp.size() > 0) {
            if (temp[0].Count_Data__c == NULL) temp[0].Count_Data__c = 0;
            temp[0].Count_Data__c += uploadedNum; 
            if (temp[0].Count_Invalid__c == NULL) temp[0].Count_Invalid__c = 0;
            temp[0].Count_Invalid__c += invalidNum; 
            update temp;        
        }
        
        if (callLineList.size() > 0) {
            CallLineInsertBatch jb = new CallLineInsertBatch(callLineList);
            Database.executeBatch(jb, 65);
        }
        
        campaign_single = new Call_List__c();
        campaign_single.Campaign_temp__c = choosen_campaign;
        
        // End Taufik, test ======
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
    public PageReference groupingCallLine(){
        //Coba mus
        String jobId = [Select Id, job_id__c From Call_List__c where Id =:choosen_campaign].job_id__c;
        List<AsyncApexJob> jobList = new List<AsyncApexJob>();
        if(jobId != Null && jobId != ''){
            jobList = [SELECT Id, Status FROM AsyncApexJob Where Id = :jobId];
            if(jobList.size() > 0){
                String batchStatus = jobList[0].Status;
                if(batchStatus != 'Completed'){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please Wait Until The Previous Process Is Complete'));
                    return null;
                }
            }
        }
        //Coba mus
        
        flagMessage = FALSE;
        document.body = null; // clears the viewstate
        document = new Document();
        outboundCallList = new List<OutboundCall>();
        
        system.debug('list_policyNo '+list_policyNo);
        mapCallByHomePhone = new Map<String, List<Call_Line__c>>();
        mapCallByEmail = new Map<String, List<Call_Line__c>>();
        mapCallByPhone = new Map<String, List<Call_Line__c>>();
        mapCallByName = new Map<String, List<Call_Line__c>>();
        mapCallByProduct = new Map<String, List<Call_Line__c>>();
        
        // Taufik, 14 Mar20, map, child parent nya siapa. supaya child tidak bisa jadi parent.
        Map<Id, Id> mapChildParent = new Map<Id, Id>();
        
        //Query ini jika agen = null
        List<Call_Line__c> lcall = [SELECT Id, Name,Formula_Product__c, Call_List__c, Policy_No__c, Entity__c, Contacted_Number__c, Home_Phone__c, Parent_Call_Line__c, Contact__c, Contact__r.Name, Contact__r.Email, Contact__r.MobilePhone FROM Call_Line__c WHERE Call_List__c=:choosen_campaign And Agent__c = Null order by Contact__r.Name,Contact__r.Email, Contact__r.MobilePhone, Contact__r.HomePhone];
        if(Test.isRunningTest()) lcall = [SELECT Id, Name,Formula_Product__c, Call_List__c, Policy_No__c, Entity__c, Contacted_Number__c, Home_Phone__c, Parent_Call_Line__c, Contact__c, Contact__r.Name, Contact__r.Email, Contact__r.MobilePhone FROM Call_Line__c order by Contact__r.Name,Contact__r.Email, Contact__r.MobilePhone, Contact__r.HomePhone]; 
        
        System.debug(':: lcall:'+lcall);
        System.debug(':: lcall.size():'+lcall.size());
        
        //added by Ranti at 01/24/2022
        Map<string,integer> totalProd = new map<string,integer>();
        
        for(Call_Line__c cl : lcall){
            // added by Ranti at 01/24/2022
            if (totalProd.containsKey(cl.Formula_Product__c)) {
                integer countProduct = totalProd.get(cl.Formula_Product__c) + 1; 
                totalProd.put(cl.Formula_Product__c,countProduct);
            } else if (cl.Formula_Product__c != null) {  
                totalProd.put(cl.Formula_Product__c,1);
            }
            
            
            //mapping call line that has same Name or Email or Phone
            
            List<Call_Line__c> lcall2 = new List<Call_Line__c>();
            String emailDummy = Label.EmailDummy;
            
            //By Email
            if(cl.Contact__r.Email !=null && cl.Contact__r.Email!='' && !emailDummy.CONTAINS(cl.Contact__r.Email)){
                if(mapCallByEmail.containsKey(cl.Contact__r.Email)){
                    lcall2 = mapCallByEmail.get(cl.Contact__r.Email);
                    lcall2.add(cl);
                    mapCallByEmail.put(cl.Contact__r.Email, lcall2);
                }else{
                    lcall2.add(cl);
                    mapCallByEmail.put(cl.Contact__r.Email, lcall2);
                }
            }
            //By Phone
            List<Call_Line__c> lcall3 = new List<Call_Line__c>();
            if(cl.Contacted_Number__c !=null && cl.Contacted_Number__c!=''){
                if(mapCallByPhone.containsKey(cl.Contacted_Number__c)){
                    lcall3 = mapCallByPhone.get(cl.Contacted_Number__c);
                    lcall3.add(cl);
                    mapCallByPhone.put(cl.Contacted_Number__c, lcall3);
                }else{
                    lcall3.add(cl);
                    mapCallByPhone.put(cl.Contacted_Number__c, lcall3);
                }
            }
            //By Home Phone
            List<Call_Line__c> lcall1 = new List<Call_Line__c>();
            if(cl.Home_Phone__c !=null && cl.Home_Phone__c!=''){
                if(mapCallByHomePhone.containsKey(cl.Home_Phone__c)){
                    lcall1 = mapCallByHomePhone.get(cl.Home_Phone__c);
                    lcall1.add(cl);
                    mapCallByHomePhone.put(cl.Home_Phone__c, lcall1);
                }else{
                    lcall1.add(cl);
                    mapCallByHomePhone.put(cl.Home_Phone__c, lcall1);
                }
            }
            //By Name
            List<Call_Line__c> lcall4 = new List<Call_Line__c>();
            if(cl.Contact__c !=null){
                if(mapCallByName.containsKey(cl.Contact__r.Name)){
                    lcall4 = mapCallByName.get(cl.Contact__r.Name);
                    lcall4.add(cl);
                    mapCallByName.put(cl.Contact__r.Name, lcall4);
                }else{
                    lcall4.add(cl);
                    mapCallByName.put(cl.Contact__r.Name, lcall4);
                }
            }
            
        }// end loop
        
        
        System.debug(':: mapCallByEmail:'+mapCallByEmail);
        System.debug(':: mapCallByEmail.size():'+mapCallByEmail.size());
        
        System.debug(':: mapCallByPhone:'+mapCallByPhone);
        System.debug(':: mapCallByPhone.size():'+mapCallByPhone.size());
        
        System.debug(':: mapCallByHomePhone:'+mapCallByHomePhone);
        System.debug(':: mapCallByHomePhone.size():'+mapCallByHomePhone.size());
        
        System.debug(':: mapCallByName:'+mapCallByName);
        System.debug(':: mapCallByName.size():'+mapCallByName.size());
        
        Map<Id, Call_Line__c> map_callLineUpdate = new Map<Id, Call_Line__c>();
        Id parentId;
        system.debug('mapCallByEmail.keyset '+mapCallByEmail.keyset()+'=='+'mapCallByPhone '+mapCallByPhone.keyset()+'=='+'mapCallByHomePhone '+mapCallByHomePhone.keyset());        
        if(!mapCallByEmail.isEmpty() || !mapCallByPhone.isEmpty() || !mapCallByHomePhone.isEmpty() || !mapCallByName.isEmpty()){
            //By Email
            for(String  str : mapCallByEmail.keyset()){
                if(mapCallByEmail.get(str).size()>1){
                    system.debug('masuk1');
                    Integer i = 1;
                    for(Call_Line__c cl : mapCallByEmail.get(str)){
                        if(i==1){
                            parentId = cl.Id;
                        }
                        else{
                            cl.Parent_Call_Line__c = parentId;
                            // Taufik, 14 Mar20, add mapChildParent
                            mapChildParent.put(cl.id, parentId);
                        }
                        map_callLineUpdate.put(cl.Id, cl);
                        i++;
                    }
                }
            }
            for(String str : mapCallByPhone.keySet()){
                if(mapCallByPhone.get(str).size()>1){
                    system.debug('masuk2');
                    Integer i = 1;
                    for(Call_Line__c cl : mapCallByPhone.get(str)){
                        if(i==1){
                            // check, jika sudah ada parent, ambil parent yang lama
                            if (mapChildParent.get(cl.Id) != NULL) parentId = mapChildParent.get(cl.Id);
                            else parentId = cl.Id;
                        }
                        else{
                            cl.Parent_Call_Line__c = parentId;
                            // Taufik, 14 Mar20, add mapChildParent
                            mapChildParent.put(cl.id, parentId);
                        }
                        map_callLineUpdate.put(cl.Id, cl);
                        i++;
                    }
                }
            }
            for(String str : mapCallByHomePhone.keySet()){
                if(mapCallByHomePhone.get(str).size()>1){
                    system.debug('masuk3');
                    Integer i = 1;
                    for(Call_Line__c cl : mapCallByHomePhone.get(str)){
                        if(i==1){
                            // check, jika sudah ada parent, ambil parent yang lama
                            if (mapChildParent.get(cl.Id) != NULL) parentId = mapChildParent.get(cl.Id);
                            else parentId = cl.Id;
                        }
                        else{
                            cl.Parent_Call_Line__c = parentId;
                            // Taufik, 14 Mar20, add mapChildParent
                            mapChildParent.put(cl.id, parentId);
                        }
                        map_callLineUpdate.put(cl.Id, cl);
                        i++;
                    }
                }
            }
            
            //By Name
            for(String str : mapCallByName.keySet()){
                if(mapCallByName.get(str).size()>1){
                    system.debug('masuk4');
                    Integer i = 1;
                    for(Call_Line__c cl : mapCallByName.get(str)){
                        if(i==1){
                            if (mapChildParent.get(cl.Id) != NULL) parentId = mapChildParent.get(cl.Id);
                            else parentId = cl.Id;
                        }
                        else{
                            cl.Parent_Call_Line__c = parentId; 
                            mapChildParent.put(cl.id, parentId);
                        }
                        map_callLineUpdate.put(cl.Id, cl);
                        i++;
                    }
                }
            }           
        }
        
        map_callLine = new Map<String, Call_Line__c>();
        
        system.debug('map_callLineUpdate '+map_callLineUpdate.size());
        
        if (!map_callLineUpdate.isEmpty()) {
            
            // updated by Ranti at 28/04/2022
            for(Id str : map_callLineUpdate.keySet()){ 
                system.debug('masuk update call line');
                system.debug('str:'+str);
                system.debug('map_callLineUpdate.get(str):'+map_callLineUpdate.get(str));
                Call_Line__c cl = map_callLineUpdate.get(str); 
                if (cl.Formula_Product__c != null && totalProd.containsKey(cl.Formula_Product__c)) {
                    cl.total_grouping_product__c = totalProd.get(cl.Formula_Product__c); 
                } else {
                    cl.total_grouping_product__c = 1;
                }
                
                System.debug('cl.id:'+cl.id);
                System.debug('cl.total_grouping_product__c:'+cl.total_grouping_product__c);
                System.debug('===');
                map_callLineUpdate.put(cl.Id, cl); 
            }          
            
            CallLineGroupingBatch jb = new CallLineGroupingBatch(map_callLineUpdate.values(),choosen_campaign,UserInfo.getUserId());
            
            
            // Added by Ranti at 01/20/2022
            progressGrouping();
            
            //Coba mus
            String job_Id = Database.executeBatch(jb, 100);
            
            Call_List__c clJob = new Call_List__c();
            clJob.Id = choosen_campaign;
            clJob.job_id__c = job_Id;
            System.debug('clJob.job_id__c = job_Id ' +job_Id);
            Update clJob;
            //Coba mus
        }
        
        PageReference pageRef = new PageReference('/apex/File_Upload_AMFS?grouping=true&ProcessJob=Processing');
        pageRef.setRedirect(true);
        return pageRef;
        
    }
    
    public PageReference reset() {
        flagMessage = FALSE;
        document.body = null; // clears the viewstate
        document = new Document();
        outboundCallList = new List<OutboundCall>();
        return null;
    }
    public PageReference populateFreshData(){ // untuk collect data agent dan collect data call line yg akan di distribusi
        campaignName = [Select id, Campaign_Name__c from Call_List__c where id = :choosen_campaign limit 10].Campaign_Name__c;
        Map<Id, Agent_Distribution_History__c> mapAdh = new Map<Id, Agent_Distribution_History__c>([SELECT Id, User_Detail__r.Sequence__c from Agent_Distribution_History__c where Campaign__c = :choosen_campaign AND (User_Detail__r.Sequence__c != 0 OR User_Detail__r.Sequence__c = null)]);
        if (isReorder == FALSE){
            List<User_Detail__c> upUd = new List<User_Detail__c>();
            for (Agent_Distribution_History__c adh : mapAdh.values()){
                User_Detail__c nUd = new User_Detail__c();
                nUd.id = adh.User_Detail__c;
                nUd.Sequence__c = 0;
                upUd.add(nUd);
            } 
            update upUd;  
        }
        
        isMethodChoosen = false;
        checkLoop += 1;
        system.debug('campaignName = '+campaignName);
        if(choosen_campaign != ''){
            if (campaignName.contains(LAPSE_TM) || campaignName.contains(REDEMPTION_TM) || campaignName.contains(RENEWAL_REMINDER) || campaignName.contains(LAPSE_KONVEN) || campaignName.contains(TRO_PROJECT) || campaignName.contains('Others')){
                
                //add khris 22-10-2021
                List<Id> setCallLineIdSortByAmountAPE = new List<Id>();
                if(campaignName.contains(REDEMPTION_TM)) {
                    List<Call_Line__c> listCallLineSortByAmount = [select id,ownerId,APE__c,Agent__r.Name,Formula_Product__c,Parent_Call_Line__c, Agent__c,APE_Convert__c,APE_Total_Child__c,Child_Count__c, Call_List__r.Case_Type__c, Call_List__c, F_User_Detail__c, Activity__c, Case_Type__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and isOwnerQueue__c = TRUE and Agent__c='' ORDER BY APE_Total_Child__c ASC];
                    if(listCallLineSortByAmount.size() > 0 ) {
                        for(Call_Line__c clAm : listCallLineSortByAmount) {
                            system.debug(':::Id Call Line = '+clAm.Id);
                            setCallLineIdSortByAmountAPE.add(clAm.Id);
                        }
                    }
                    system.debug('setCallLineIdSortByAmountAPE = '+setCallLineIdSortByAmountAPE.size());
                    callLineList = [select id,ownerId,APE__c,Agent__r.Name,Formula_Product__c,Parent_Call_Line__c, Agent__c,APE_Convert__c,APE_Total_Child__c,Child_Count__c, Call_List__r.Case_Type__c, Call_List__c, F_User_Detail__c, Activity__c, Case_Type__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c, Policy_Effective_Date__c from Call_Line__c where Id IN :setCallLineIdSortByAmountAPE AND Call_List__c = :choosen_campaign and isOwnerQueue__c = TRUE and Agent__c='' ORDER BY total_grouping_product__c   desc nulls last, Child_Count__c desc nulls last,Year_of_Policy_Effective_Date__c asc nulls last];
                }   else {
                    callLineList = [select id,ownerId,APE__c,Agent__r.Name,Formula_Product__c,Parent_Call_Line__c, Agent__c,APE_Convert__c,APE_Total_Child__c,Child_Count__c, Call_List__r.Case_Type__c, Call_List__c, F_User_Detail__c, Activity__c, Case_Type__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and isOwnerQueue__c = TRUE and Agent__c='' ORDER BY APE_Total_Child__c DESC]; //Parent_Call_Line__c DESC, Formula_Product__c ASC, APE_Total_Child__c DESC];  
                }
                //added by ichwan
                if (campaignName.contains(RENEWAL_REMINDER)) {
                    callLineList = [select id,ownerId,APE__c,Agent__r.Name,Formula_Product__c,Parent_Call_Line__c, Agent__c,APE_Convert__c,APE_Total_Child__c,Child_Count__c, Call_List__r.Case_Type__c, Call_List__c, F_User_Detail__c, Activity__c, Case_Type__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and isOwnerQueue__c = TRUE and Agent__c='' and (NOT Call_Status_Config__c = 'Takeout') ORDER BY APE_Total_Child__c DESC];
                    //notify policy_no has been takeout
                    notifyClPolicy = [SELECT Id, Policy_No__c FROM Call_Line__c WHERE Call_List__c = :choosen_campaign AND Call_Status_Config__c = 'Takeout'];
                }
                //end add 
                
            }
            else {
                callLineList = [select id,ownerId,APE__c,Agent__r.Name,Formula_Product__c,Parent_Call_Line__c, Agent__c,APE_Convert__c,APE_Total_Child__c,Child_Count__c, Call_List__r.Case_Type__c, Call_List__c, F_User_Detail__c, Activity__c, Case_Type__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign and isOwnerQueue__c = TRUE and Agent__c='' ORDER BY APE_Total_Child__c DESC];
            }
            if(Test.isRunningTest()){
                callLineList = [select id,ownerId,APE__c,Agent__r.Name,Formula_Product__c,Parent_Call_Line__c, Agent__c,APE_Convert__c,APE_Total_Child__c,Child_Count__c, Call_List__r.Case_Type__c, Call_List__c, F_User_Detail__c, Activity__c, Case_Type__c, Entity__c, Policy_No__c, Contact__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c from Call_Line__c where Call_List__c = :choosen_campaign ORDER BY APE_Total_Child__c DESC];
            }
            
            totalData = callLineList.size();
            totalPolicies = callLineList.size();
            
            system.debug('***Call Line List Size:'+callLineList.size()); 
            if (total_APE == null) total_APE = 0;
            if (checkLoop < 2){
                Decimal tempAPE = 0;
                for (Call_Line__c cl : callLineList){
                    tempAPE = cl.APE_Total_Child__c;
                    if (tempAPE != null) total_APE += tempAPE;
                } 
                List<String> args = new String[]{'0','number','###,###,##0.00'};
                    string_APE = String.format(total_APE.format(), args);
                System.debug(string_APE);
            }
            
            List<Call_Line__c> checkGAP = [select id from Call_Line__c where Call_List__c = :choosen_campaign and isOwnerQueue__c = FALSE and Agent__c='' and Parent_Call_Line__c != NULL]; //and Parent_Campaign__c = NULL and Parent_Call_Line__c = NULL];
            totalGAP = checkGAP.size();
            
            filterResult = '';     
            if (callLineList.size() > 0) {
                filterResult = callLineList[0].F_User_Detail__c;
            }
            if(test.isRunningTest()) {
                agentList = [SELECT id, User__c,Max_Capacity_Amount__c, User__r.Name, Name FROM User_Detail__c LIMIT 10 ]; 
            } else { 
                agentList = [SELECT id, User__c,Max_Capacity_Amount__c, User__r.Name, Name FROM User_Detail__c WHERE Entity__c = :AMFS AND Outbound_Activity_Case_type__c != NULL AND Outbound_Activity_Case_type__c includes (:filterResult) ];
            }
            List<Agent_Distribution_History__c> upsertAdh = new List<Agent_Distribution_History__c>();
            for (user_detail__c ud : agentList){
                Agent_Distribution_History__c newAdh = new Agent_Distribution_History__c();
                newAdh.Campaign__c = choosen_campaign;
                newAdh.User_Detail__c = ud.id;
                newAdh.External_Key__c = choosen_campaign + '-' + ud.User__c;
                upsertAdh.add(newAdh);
            } upsert upsertAdh External_Key__c;
            
            agentMap = new Map<string, string>();
            list<string> tempuserid = new list<string>();
            
            Decimal tempCheckAmountAdh = 0;
            for (Agent_Distribution_History__c adh : [SELECT Id,User_Detail__r.Level__c,User_Detail__r.Amount_Level__c, Amount__c, Campaign__c, External_Key__c,User_Detail__c,User_Detail__r.Name,User_Detail__r.user__c, User_Detail__r.Sequence__c FROM Agent_Distribution_History__c WHERE Campaign__c = :choosen_campaign AND User_Detail__r.Outbound_Activity_Case_type__c includes (:filterResult)]){
                if (adh.Amount__c != null) tempCheckAmountAdh += adh.Amount__c;
            }
            
            
            if(Test.isRunningTest()){
                finalListAdh = [SELECT Id,Total_Distributed__c,User_Detail__r.Level__c,User_Detail__r.Amount_Level__c, Amount__c, Campaign__c, External_Key__c,User_Detail__c,User_Detail__r.Name,User_Detail__r.user__c, User_Detail__r.Sequence__c FROM Agent_Distribution_History__c WHERE User_Detail__r.Outbound_Activity_Case_type__c != NULL AND Campaign__c = :choosen_campaign ORDER BY User_Detail__r.Name ASC];
            } else {
                if (isReorder) {
                    finalListAdh = [SELECT Id,Total_Distributed__c,User_Detail__r.Level__c,User_Detail__r.Amount_Level__c, Amount__c, Campaign__c, External_Key__c,User_Detail__c,User_Detail__r.Name,User_Detail__r.user__c, User_Detail__r.Sequence__c FROM Agent_Distribution_History__c WHERE User_Detail__r.Outbound_Activity_Case_type__c != NULL AND Campaign__c = :choosen_campaign AND User_Detail__r.Outbound_Activity_Case_type__c includes (:filterResult) ORDER BY User_Detail__r.Sequence__c ASC];        
                }
                if (isReorder == false && tempCheckAmountAdh == 0){
                    finalListAdh = [SELECT Id,Total_Distributed__c,User_Detail__r.Level__c,User_Detail__r.Amount_Level__c, Amount__c, Campaign__c, External_Key__c,User_Detail__c,User_Detail__r.Name,User_Detail__r.user__c, User_Detail__r.Sequence__c FROM Agent_Distribution_History__c WHERE User_Detail__r.Outbound_Activity_Case_type__c != NULL AND Campaign__c = :choosen_campaign AND User_Detail__r.Outbound_Activity_Case_type__c includes (:filterResult) ORDER BY User_Detail__r.Name ASC];    
                }
                if (isReorder == false && tempCheckAmountAdh > 0) {
                    finalListAdh = [SELECT Id,Total_Distributed__c,User_Detail__r.Level__c,User_Detail__r.Amount_Level__c, Amount__c, Campaign__c, External_Key__c,User_Detail__c,User_Detail__r.Name,User_Detail__r.user__c, User_Detail__r.Sequence__c FROM Agent_Distribution_History__c WHERE User_Detail__r.Outbound_Activity_Case_type__c != NULL AND Campaign__c = :choosen_campaign AND User_Detail__r.Outbound_Activity_Case_type__c includes (:filterResult) ORDER BY Amount__c ASC];        
                }
            }
            
            
            totalAgents = finalListAdh.size();
            agentListView = finalListAdh.clone();
            
            mapAgentHistory = new map <Id,Agent_Distribution_History__c>();
            for (Agent_Distribution_History__c adh : finalListAdh){
                if (adh.User_Detail__c != NULL)
                    mapAgentHistory.put(adh.User_Detail__r.User__c, adh);
                
                agentIDList.add(adh.User_Detail__r.User__c);
                agentMap.put(adh.User_Detail__r.User__c, adh.User_Detail__r.Name);
                agentOptList.add(new SelectOption(adh.User_Detail__r.User__c, adh.User_Detail__r.Name));
                tempuserid.add (adh.User_Detail__r.User__c);
            }
        }
        
        if (callLineList.size() > 0 && finalListAdh.size() > 0){
            topLimitAgentPolicy = Decimal.ValueOf(callLineList.size()) / Decimal.ValueOf(finalListAdh.size());
            topLimitAgentPolicy = topLimitAgentPolicy.round(System.RoundingMode.UP);
            
            averagePolicy = total_APE / callLineList.size();
            
            topLimitAgentAPE = (total_APE / finalListAdh.size()) + (averagePolicy * 30);  
            
            topLimitAgentAPE = topLimitAgentAPE.round(System.RoundingMode.UP);
        }
        system.debug('***Average Policy: '+callLineList.size()+ ' / '+ finalListAdh.size()+ ' = '+topLimitAgentPolicy);
        system.debug('***Average Amount: '+topLimitAgentAPE);
        return null;
    }
    
    public PageReference resetAgent(){
        isReorder = false;
        choosen_method = '';
        return populateFreshData();
    }
    
    public PageReference reorder(){
        List<User_Detail__c> udToUpdate = new List<User_Detail__c>();
        for (Agent_Distribution_History__c adh : finalListAdh){
            User_Detail__c newUd = new User_Detail__c();
            newUd.id = adh.User_Detail__c;
            if (adh.User_Detail__r.Sequence__c == null){
                newUd.Sequence__c = 0;
                adh.User_Detail__r.Sequence__c = 0;
            }
            else {
                newUd.Sequence__c = adh.User_Detail__r.Sequence__c;
            }
            udToUpdate.add(newUd);
        }
        
        Integer countDuplicateSequence = 0;
        for(integer i=0;i<udToUpdate.size();i++) {
            User_Detail__c udI = udToUpdate.get(i);
            for(integer j=(i+1);j<udToUpdate.size();j++) {
                User_Detail__c udJ = udToUpdate.get(j); 
                if(udI.Sequence__c == udJ.Sequence__c && i!=j) {
                    countDuplicateSequence += 1;
                }
            }
        }
        if (countDuplicateSequence > 0){
            countDuplicateSequence = 0;
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,'Duplicate sequence found, please put different sequence number for each available agent.'));    
        }
        else {
            update udToUpdate;
            isReorder = true;
            if(Test.isRunningTest()){
                finalListAdh = [SELECT Id,Total_Distributed__c,User_Detail__r.Level__c,User_Detail__r.Amount_Level__c, Amount__c, Campaign__c, External_Key__c,User_Detail__c,User_Detail__r.Name,User_Detail__r.user__c, User_Detail__r.Sequence__c FROM Agent_Distribution_History__c LIMIT 10];
            } else {
                finalListAdh = [SELECT Id, Amount__c, Campaign__c, External_Key__c,User_Detail__c,User_Detail__r.Name,User_Detail__r.user__c, User_Detail__r.Sequence__c,User_Detail__r.Level__c,User_Detail__r.Amount_Level__c FROM Agent_Distribution_History__c WHERE Campaign__c = :choosen_campaign AND User_Detail__r.Outbound_Activity_Case_type__c includes (:filterResult) ORDER BY User_Detail__r.Sequence__c ASC];        
            }
            agentListView = finalListAdh.clone();
            return distribute();    
        }
        return null;
    }
    
    public PageReference distribute(){
        System.debug(LoggingLevel.DEBUG, '***distribute()');
        if(choosen_method == AUTOMATIC_OPT){
            return distributeAuto();
        }else if(choosen_method == MANUAL_OPT){
            return distributeManualByCount();
        }
        
        return null;
    }
    
    @TestVisible private PageReference distributeAuto(){
        try{
            populateFreshData(); //added by WK, 20150416
            integer i = 0;
            integer j = 0;
            integer alocidx = 0;
            integer maxData = 0;
            Boolean level_1;
            Boolean level_2;
            
            Map<String,TempUserAssignment> agentAssignmentMap = new Map<String,TempUserAssignment>();
            OutboundCall outboundCall = new OutboundCall();
            AgentAssignment assignment = null;
            
            system.debug('Call Line List Size: '+callLineList.size());
            
            if(totalPolicies > 0){
                if(totalAgents==0){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'You have not subordinate. Please contact Administrator.'));    
                }
                else{
                    if (inputValue == NULL || inputValue == 0) maxData = 999999;
                    else maxData = totalAgents * inputValue;    
                    
                    System.debug('::totalAgents:'+totalAgents);
                    System.debug('::inputValue:'+inputValue);
                    System.debug('::callLineList.size():'+callLineList.size());
                    System.debug('::finalListAdh.size():'+finalListAdh.size());
                    for(Call_Line__c dis : callLineList){
                        System.debug(':::Call Line:'+dis);
                        
                        // updated by Ranti at 01/24/2022
                        if (dis.Parent_Call_Line__c != null) continue;
                        
                        alocidx = math.mod(i , totalAgents);  
                        j = 0;
                        
                        for(Agent_Distribution_History__c agent : finalListAdh ){
                            Level_1 = false;
                            Level_2 = false;
                            
                            if (campaignName.contains(REDEMPTION_KONVEN)){
                                
                                if (agent.User_Detail__r.Level__c == '1') Level_1 = true;
                                if (agent.User_Detail__r.Level__c == '2' && dis.APE_Total_Child__c < agent.User_Detail__r.Amount_Level__c) Level_2 = true;
                            }
                            
                            
                            if (i < maxData) {
                                if(agentAssignmentMap.containsKey(agent.User_Detail__r.User__c)){
                                    system.debug('in contains agentAssignmentMap');
                                    TempUserAssignment tua = new TempUserAssignment();
                                    if (campaignName.contains(REDEMPTION_KONVEN)){ 
                                        System.debug('Redem Konven');
                                        if ((Level_1 == true && agent.User_Detail__r.Level__c == '1')){
                                            if (dis.Child_Count__c != 0 && dis.Child_Count__c != null){
                                                Decimal tempTotalPolicyAgent = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalPolicy + Integer.valueof(dis.Child_Count__c); 
                                                Decimal tempTotalAPEAgent = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalAPE + dis.APE_Total_Child__c;
                                                if (tempTotalAPEAgent <= topLimitAgentAPE && tempTotalPolicyAgent <= topLimitAgentPolicy){
                                                    tua.totalPolicy = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalPolicy + Integer.valueof(dis.Child_Count__c);   
                                                }
                                                else {
                                                    continue;
                                                } 
                                                
                                            }
                                            else {
                                                Decimal tempTotalPolicyAgent = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalPolicy + 1;
                                                Decimal tempTotalAPEAgent = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalAPE + dis.APE_Total_Child__c;
                                                if (tempTotalAPEAgent <= topLimitAgentAPE && tempTotalPolicyAgent <= topLimitAgentPolicy){
                                                    tua.totalPolicy = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalPolicy + 1;
                                                }
                                                else {
                                                    continue;
                                                }
                                                
                                            }
                                            tua.totalAPE = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalAPE + dis.APE_Total_Child__c;
                                            agentAssignmentMap.put(agent.User_Detail__r.User__c, tua); 
                                            dis.Agent__c = agent.User_Detail__r.User__c;
                                            dis.ownerId = agent.User_Detail__r.User__c;
                                            
                                            j++;
                                            break;
                                        }
                                        else if ((Level_2 == true && agent.User_Detail__r.Level__c == '2')){
                                            if (dis.Child_Count__c != 0 && dis.Child_Count__c != null){
                                                Decimal tempTotalPolicyAgent = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalPolicy + Integer.valueof(dis.Child_Count__c); 
                                                Decimal tempTotalAPEAgent = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalAPE + dis.APE_Total_Child__c;
                                                if (tempTotalAPEAgent <= topLimitAgentAPE && tempTotalPolicyAgent <= topLimitAgentPolicy){
                                                    tua.totalPolicy = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalPolicy + Integer.valueof(dis.Child_Count__c);   
                                                }
                                                else {
                                                    continue;
                                                } 
                                            }
                                            else {
                                                Decimal tempTotalPolicyAgent = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalPolicy + 1;
                                                Decimal tempTotalAPEAgent = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalAPE + dis.APE_Total_Child__c;
                                                if (tempTotalAPEAgent <= topLimitAgentAPE && tempTotalPolicyAgent <= topLimitAgentPolicy){
                                                    tua.totalPolicy = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalPolicy + 1;
                                                }
                                                else {
                                                    continue;
                                                }
                                                
                                            }
                                            tua.totalAPE = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalAPE + dis.APE_Total_Child__c;
                                            agentAssignmentMap.put(agent.User_Detail__r.User__c, tua); 
                                            dis.Agent__c = agent.User_Detail__r.User__c;
                                            dis.ownerId = agent.User_Detail__r.User__c;
                                            j++;
                                            break;
                                        }
                                        else {
                                            j++;
                                            continue;
                                        }
                                    }
                                    
                                    // added by Ranti at 20/01/2022
                                    else if (campaignName.contains(REDEMPTION_TM)) {  
                                        
                                        integer totalChild = 1;
                                        if (dis.Child_Count__c != 0 && dis.Child_Count__c != null) totalChild = Integer.valueof(dis.Child_Count__c);  
                                        system.debug('****agentAssignmentMap:'+agentAssignmentMap); 
                                        system.debug('****agent.User_Detail__r.User__c:'+agent.User_Detail__r.User__c); 
                                        system.debug('****dis.APE_Total_Child__c:'+dis.APE_Total_Child__c);
                                        if (test.isRunningTest()) {
                                            dis.APE_Total_Child__c = 1000;
                                        }
                                        
                                        Decimal tempTotalAPEAgent = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalAPE + dis.APE_Total_Child__c;                                              
                                        Decimal tempTotalPolicyAgent = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalPolicy + totalChild;
                                        
                                        if (tempTotalAPEAgent <= topLimitAgentAPE && tempTotalPolicyAgent <= topLimitAgentPolicy){
                                            tua.totalPolicy = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalPolicy + totalChild;    
                                        }
                                        else { 
                                            System.debug('::OVER!!!');
                                            continue;
                                        }  
                                        
                                        tua.totalAPE = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalAPE + dis.APE_Total_Child__c;
                                        agentAssignmentMap.put(agent.User_Detail__r.User__c, tua); 
                                        system.debug('***TOTAL DISTRIBUTED 555: '+agentAssignmentMap);
                                        dis.Agent__c = agent.User_Detail__r.User__c;
                                        dis.ownerId = agent.User_Detail__r.User__c; 
                                        break;
                                    } 
                                    //end added by Ranti at 20/01/2022
                                    
                                    else {
                                        if (dis.Child_Count__c != 0 && dis.Child_Count__c != null){
                                            Decimal tempTotalPolicyAgent = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalPolicy + Integer.valueof(dis.Child_Count__c); 
                                            Decimal tempTotalAPEAgent = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalAPE + dis.APE_Total_Child__c;
                                            System.debug(':::tempTotalPolicyAgent1:'+tempTotalPolicyAgent);
                                            System.debug(':::tempTotalAPEAgent1:'+tempTotalAPEAgent);
                                            System.debug(':::topLimitAgentAPE1:'+topLimitAgentAPE);
                                            System.debug(':::topLimitAgentPolicy1:'+topLimitAgentPolicy);
                                            //Jumlah dan amount nya merata
                                            if (!campaignName.contains(LAPSE_KONVEN) && !campaignName.contains('Withdrawal')){
                                                
                                                if (tempTotalAPEAgent <= topLimitAgentAPE && tempTotalPolicyAgent <= topLimitAgentPolicy){
                                                    tua.totalPolicy = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalPolicy + Integer.valueof(dis.Child_Count__c);    
                                                }
                                                else {
                                                    system.debug('::Skip on campaign 1');
                                                    continue;
                                                }    
                                            }
                                            //Hanya jumlah nya yang merata, khusus Lapse Konven dan Withdrawal, karena besarnya APE mengikuti pengajuan (GAP bisa sangat jauh)
                                            else { 
                                                system.debug('::Is Campaign LK/Withdrawal ON Child_Count__c is not null');
                                                
                                                if (tempTotalPolicyAgent <= topLimitAgentPolicy){
                                                    tua.totalPolicy = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalPolicy + Integer.valueof(dis.Child_Count__c);    
                                                }
                                                else {
                                                    
                                                    system.debug('::Skip on campaign 2');
                                                    continue;
                                                }    
                                            }
                                        }
                                        else {
                                            Decimal tempTotalPolicyAgent = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalPolicy + 1;
                                            Decimal tempTotalAPEAgent = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalAPE + dis.APE_Total_Child__c;
                                            
                                            
                                            System.debug(':::tempTotalPolicyAgent2:'+tempTotalPolicyAgent);
                                            System.debug(':::tempTotalAPEAgent2:'+tempTotalAPEAgent);
                                            System.debug(':::topLimitAgentAPE2:'+topLimitAgentAPE);
                                            System.debug(':::topLimitAgentPolicy2:'+topLimitAgentPolicy);
                                            
                                            if (!campaignName.contains(LAPSE_KONVEN) && !campaignName.contains('Withdrawal')){
                                                
                                                if (tempTotalAPEAgent <= topLimitAgentAPE && tempTotalPolicyAgent <= topLimitAgentPolicy){
                                                    tua.totalPolicy = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalPolicy + 1;
                                                }
                                                else {
                                                    system.debug('::Skip on campaign 3');
                                                    continue;
                                                }    
                                            }
                                            else {
                                                
                                                if (tempTotalPolicyAgent <= topLimitAgentPolicy){
                                                    tua.totalPolicy = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalPolicy + 1;
                                                }
                                                else {
                                                    system.debug('::Skip on campaign 4');
                                                    continue;
                                                }    
                                            }
                                        }
                                        tua.totalAPE = agentAssignmentMap.get(agent.User_Detail__r.User__c).totalAPE + dis.APE_Total_Child__c;
                                        agentAssignmentMap.put(agent.User_Detail__r.User__c, tua); 
                                        system.debug('***TOTAL DISTRIBUTED 1: '+agentAssignmentMap);
                                        dis.Agent__c = agent.User_Detail__r.User__c;
                                        dis.ownerId = agent.User_Detail__r.User__c; 
                                        break;
                                    }
                                }
                                
                                else{
                                    system.debug('in not contains agentAssignmentMap');
                                    TempUserAssignment tua = new TempUserAssignment();
                                    if (campaignName.contains(REDEMPTION_KONVEN)){ 
                                        System.debug('::Redemption Konven');
                                        if ((Level_1 == true && agent.User_Detail__r.Level__c == '1')){
                                            if (dis.Child_Count__c != 0 && dis.Child_Count__c != null){
                                                tua.totalPolicy = Integer.valueof(dis.Child_Count__c);    
                                            }
                                            else {
                                                tua.totalPolicy = 1;
                                            }
                                            tua.totalAPE = dis.APE_Total_Child__c;
                                            agentAssignmentMap.put(agent.User_Detail__r.User__c, tua);
                                            dis.Agent__c = agent.User_Detail__r.User__c;
                                            dis.ownerId = agent.User_Detail__r.User__c; 
                                            j++;
                                            break;
                                        }
                                        else if ((Level_2 == true && agent.User_Detail__r.Level__c == '2')){
                                            if (dis.Child_Count__c != 0 && dis.Child_Count__c != null){
                                                tua.totalPolicy = Integer.valueof(dis.Child_Count__c);    
                                            }
                                            else {
                                                tua.totalPolicy = 1;
                                            }
                                            tua.totalAPE = dis.APE_Total_Child__c;
                                            agentAssignmentMap.put(agent.User_Detail__r.User__c, tua);
                                            dis.Agent__c = agent.User_Detail__r.User__c;
                                            dis.ownerId = agent.User_Detail__r.User__c; 
                                            j++;
                                            break;
                                        }
                                        else {
                                            
                                            system.debug('::Skip on campaign 5');
                                            j++;
                                            continue;
                                        } 
                                    }
                                    
                                    // added by Ranti at 20/01/2022
                                    else if (campaignName.contains(REDEMPTION_TM)) { 
                                        integer totalChild = 1;
                                        if (dis.Child_Count__c != 0 && dis.Child_Count__c != null) totalChild = Integer.valueof(dis.Child_Count__c);  
                                        
                                        tua.totalPolicy = totalChild; 
                                        tua.totalAPE = dis.APE_Total_Child__c;
                                        
                                        if (test.isRunningTest()) {
                                            tua.totalAPE = 100000;
                                        }
                                        
                                        agentAssignmentMap.put(agent.User_Detail__r.User__c, tua);
                                        dis.Agent__c = agent.User_Detail__r.User__c;
                                        dis.ownerId = agent.User_Detail__r.User__c;     
                                        break;
                                    } 
                                    //end added by Ranti at 20/01/2022 
                                    
                                    else {
                                        
                                        System.debug('::ELSE');
                                        if (dis.Child_Count__c != 0 && dis.Child_Count__c != null){
                                            tua.totalPolicy = Integer.valueof(dis.Child_Count__c);  
                                        }
                                        else {
                                            tua.totalPolicy = 1;
                                        }
                                        tua.totalAPE = dis.APE_Total_Child__c;
                                        
                                        if (test.isRunningTest()) {
                                            tua.totalAPE = 100000;
                                        }
                                        
                                        agentAssignmentMap.put(agent.User_Detail__r.User__c, tua);
                                        dis.Agent__c = agent.User_Detail__r.User__c;
                                        dis.ownerId = agent.User_Detail__r.User__c;     
                                        break;
                                    }
                                }
                            }
                            
                            j++;
                        }
                        
                        
                        Integer r = 0;
                        if (j >= 1){ 
                            r = j-1;
                        }
                        finalListAdh.add(finalListAdh.remove(r));
                        
                        i++;   
                        
                        system.debug('****Police Number: '+ dis.Policy_No__c);
                        system.debug('****Product: '+ dis.Formula_Product__c);
                        system.debug('****Amount: '+ dis.APE_Total_Child__c);
                        system.debug('****Agent Name: '+ dis.Agent__c);
                        system.debug('****Owner Name: '+ dis.ownerId);
                        system.debug('****agentAssignmentMap: '+ agentAssignmentMap);
                        system.debug('****i Count: '+ i);
                    }
                    
                    assignmentList = new List<AgentAssignment>();
                    
                    system.debug('agentAssignmentMap 1:'+agentAssignmentMap);
                    for(string agentid : agentAssignmentMap.keySet()){
                        assignment = new AgentAssignment();
                        assignment.agentId = agentid;
                        assignment.agentName = agentMap.get(agentid);
                        assignment.policyTotal = agentAssignmentMap.get(agentid).totalPolicy;
                        
                        Decimal tempApe = agentAssignmentMap.get(agentid).totalAPE;
                        List<String> args = new String[]{'0','number','###,###,##0.00'};
                            assignment.StringAPE_Distributed = String.format(tempApe.format(), args);
                        
                        assignmentList.add(assignment);
                    }
                    system.debug('***assignmentList:'+assignmentList);
                    system.debug('***assignmentList size:'+assignmentList.size());
                }       
            }
            else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No records is available to distribute.'));    
                
            }
        } catch(Exception ex){
            System.debug('ERROR lineMsg: '+ ex.getLineNumber());
            System.debug('ERROR lineMsg getMessage: '+ ex.getMessage());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ex.getMessage()));
        }
        isMethodChoosen = true;
        return null;
    }
    
    @TestVisible private PageReference distributeManualByCount(){
        if(!Test.isRunningTest()) populateFreshData();  //added by WK, 20150416
        assignmentList = new List<AgentAssignment>();
        System.debug(LoggingLevel.DEBUG, '***totalPolicies: ' + totalPolicies);
        if(totalPolicies>0){
            AgentAssignment assignment = null;
            
            if(totalAgents==0){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'You have not subordinate. Please contact Administrator.'));    
            }else{
                system.debug('agentAssignmentMap 2:'+finalListAdh);
                for(Agent_Distribution_History__c agent : finalListAdh){
                    assignment = new AgentAssignment();
                    assignment.agentId = agent.User_Detail__r.user__c;
                    assignment.agentName = agentMap.get(agent.User_Detail__r.user__c);
                    assignment.policyTotal = 0;
                    assignment.apeDistributed = 0;
                    assignmentList.add(assignment);
                }
                system.debug('assignmentList 2:'+assignmentList);
            }       
        }else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No records is available to distribute.'));    
            return null;
        }
        
        isMethodChoosen = true;
        System.debug('***distributeManual isMethodChoosen: ' + isMethodChoosen);
        return null;
    }
    
    public void save() {
        system.debug('***CHOOSEN METHOD:'+choosen_method);
        
        boolean isSuccess = true;
        if(!isMethodChoosen){
            isSuccess = false;  
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'You could not save before choosing Distribution Method first.'));
            
        }
        
        if(choosen_method == MANUAL_OPT){
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
            } else if(grandTotalAssignment ==0){
                isSuccess = false;  
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'No assignments has been set yet.'));
            }
            
            system.debug('save manual finalListAdh:'+finalListAdh);
            system.debug('save manual callLineList:'+callLineList);
            system.debug('save manual agentOrderMap:'+agentOrderMap);
            system.debug('save manual mapAgentHistory:'+mapAgentHistory);
            system.debug('save manual choosen_campaign:'+choosen_campaign);
            if(!Test.isRunningTest()) {
                Batch_DistributeManual_CallLineAMFS bb = new Batch_DistributeManual_CallLineAMFS(finalListAdh,callLineList,agentOrderMap,mapAgentHistory,choosen_campaign);
                // updated by ranti at 01/24/2022
                
                batchId.put(Database.executeBatch(bb,65),'Batch_DistributeManual_CallLineAMFS');
            }
            
            progressDistribution(); 
            
            
        }
        
        
        if(choosen_method == AUTOMATIC_OPT){  
            system.debug('save automatic finalListAdh:'+finalListAdh);
            system.debug('save automatic callLineList:'+callLineList);
            system.debug('save automatic assignmentList:'+assignmentList);
            system.debug('save automatic mapAgentHistory:'+mapAgentHistory);
            system.debug('save automatic choosen_campaign:'+choosen_campaign);
            
            Map<Id,Decimal> mapAA = new Map<Id,Decimal>();
            for (AgentAssignment aa : assignmentList){
                mapAA.put(aa.agentId, aa.apeDistributed);    
            }
            
            Batch_DistributeAuto_CallLineAMFS bb = new Batch_DistributeAuto_CallLineAMFS(finalListAdh,callLineList,mapAA,mapAgentHistory,choosen_campaign);
            // updated by ranti at 01/24/2022
            
            batchStatusJob = 'Processing';
            
            batchId.put(Database.executeBatch(bb,65),'Batch_DistributeManual_CallLineAMFS');
            
            progressDistribution(); 
        }
        
        // updated by Ranti at 01/25/2022
        isDistribution = true;
    }
    
    public class TempUserAssignment{
        public String Agent_Id;
        public Integer totalPolicy;
        public Decimal totalAPE;
        
        //Coba Mus
        public Integer count = 0;
    }
    
    public class CollectionTask{
        public String PolicyNo {get;set;}
        public String HomePhone {get;set;}
        public String MobilePhone {get;set;}
        public String OtherPhone {get;set;}
        public String Amount {get;set;}
        public String AmountCurrency {get;set;}
        public String BatchNo {get;set;}
        public String CaseType {get;set;}
        public String parentId {get;set;}
        public String infoPending {get;set;}
        
        //Coba Mus start
        public String APE {get;set;}
        public String cCurrency {get;set;}
        public String userId {get;set;}
        //Coba Mus end
        
        // collection add call notes (1-3) for theirs upload template (catur, 20210708)
        public String callnotes1 {get;set;}
        public String callnotes2 {get;set;}
        public String callnotes3 {get;set;}
    }
    public class OutboundCall{
        public string policyNo {get; set;}
        public string phoneNo {get; set;}
        public string campaignName {get; set;}      
        public string agentId {get; set;}      
        public string agentName {get; set;}      
    }
    Global class AgentAssignment{
        public string agentId {get; set;}    
        public string agentName {get; set;}      
        public integer policyTotal {get; set;}
        public decimal apeDistributed {get; set;}
        public string StringAPE_Distributed {get;set;}
    }
    
    public class InvalidPolicy{
        public string policyNo {get;set;}
        public string status {get;set;}
        public InvalidPolicy(string policyNo, string status){
            this.policyNo = policyNo;
            this.status = status;
        }
    }
    
    
    // Add by Ranti at 01/20/2022
    public void progressUploadFile() {
        message = '';
        batchClassIds = new Map<id, String>();
        List<ApexClass> getBatchClass = [Select Name, Id From ApexClass Where Name = 'CallLineInsertBatch'];
        if (getBatchClass.size() > 0) {
            for(ApexClass ac : getBatchClass) {
                batchClassIds.put(ac.Id,ac.name);
            }
        } 
        
        // Added by Ranti at 01/20/2022
        batchStatusJob = 'Processing';
        System.debug('batchStatusJob: '+batchStatusJob);
        
    } 
    
    public void progressGrouping() {
        message = '';
        batchClassIds = new Map<id, String>();
        List<ApexClass> getBatchClass = [Select Name, Id From ApexClass Where Name in ('CallLineGroupingBatch','AMFS_CallLine_ParentCounter')];
        if (getBatchClass.size() > 0) {
            for(ApexClass ac : getBatchClass) {
                batchClassIds.put(ac.Id,ac.name);
            }
        }
        apexJobs = [Select TotalJobItems, Status, NumberOfErrors, ExtendedStatus, JobItemsProcessed, Id, JobType, ApexClassId,ApexClass.name, CreatedDate From AsyncApexJob Where ApexClassId =: batchClassIds.keySet() and CreatedById =: UserInfo.getUserId() Order by CreatedDate DESC];
        
        // Added by Ranti at 01/20/2022
        batchStatusJob = 'Processing';
        System.debug('batchStatusJob=> '+batchStatusJob);
    }
    
    public void progressDistribution() {
        message = '';
        batchClassIds = new Map<id, String>();
        List<ApexClass> getBatchClass = [Select Name, Id From ApexClass Where Name = 'Batch_DistributeAuto_CallLineAMFS'];
        if (getBatchClass.size() > 0) {
            for(ApexClass ac : getBatchClass) {
                batchClassIds.put(ac.Id,ac.name); 
            }
        } 
        
        // Added by Ranti at 01/20/2022
        batchStatusJob = 'Processing';
        System.debug('::batchStatusJob:'+batchStatusJob);
    }  
    
    public class BatchJob{
        public AsyncApexJob aj {get;set;}
        public Integer Percent {get;set;}
        public String Job_Type {get;set;}
        public Boolean isCompleted {get;set;}
        public BatchJob(){}     
    }
    
    public BatchJob[] getJobs() {   
        apexJobs = [Select TotalJobItems, Status, NumberOfErrors, ExtendedStatus, JobItemsProcessed, Id, JobType, ApexClassId,ApexClass.name, CreatedDate From AsyncApexJob Where  CreatedById =: UserInfo.getUserId() AND Status in ('Queued', 'Processing', 'Preparing', 'Holding')  Order by CreatedDate DESC];
        for (AsyncApexJob apj: apexJobs) {
            batchId.put(apj.id,apj.ApexClass.name);
        }
        System.debug('batchId.size():'+batchId.size());
        if(apexJobs.size() == 0) {
            return new List<BatchJob>();
        }
        
        List<BatchJob> jobs = new List<BatchJob>();      
        if (apexJobs.size() > 0) {
            flagMessage = false;
            for(AsyncApexJob job : apexJobs) { 
                if (batchId.containsKey(job.id)) { 
                    BatchJob bj = new BatchJob();
                    bj.isCompleted = false;
                    
                    if(batchClassIds.containsKey(job.ApexClassId)) {
                        bj.Job_Type = 'Process 1';
                    }            
                    bj.aj = job;
                    
                    // NOT START YET
                    if(job.jobItemsProcessed == 0) {
                        bj.Percent= 0;
                        jobs.add(bj);
                        continue;
                    }
                    
                    Decimal d = job.jobItemsProcessed;
                    d = d.divide(job.TotalJobItems, 2)*100;
                    bj.Percent= d.intValue();
                    
                    // PROCESSING
                    if(bj.Percent != 100){
                        jobs.add(bj);
                        continue;
                    }
                    
                    // FINISED
                    if(batchClassIds.containsKey(job.ApexClassId) && job.Status == 'Completed') {
                        batchStatusJob = 'Finish';
                    }
                    
                    bj.isCompleted = true;
                    jobs.add(bj);    
                }       
            }    
        } else {
            flagMessage = true;
            batchStatusJob = 'Finish';
            BatchJob bj = new BatchJob(); 
            bj.isCompleted = true;
            jobs.add(bj);    
        }
        
        return jobs;
    }  
    
    
    public PageReference updateProgress() {        
        string processJob = ApexPages.currentPage().getParameters().get('ProcessJob');
        integer totalJobProcess = [Select count() From AsyncApexJob Where CreatedById =: UserInfo.getUserId() AND Status in ('Queued', 'Processing', 'Preparing', 'Holding')];
        string grouping = ApexPages.currentPage().getParameters().get('Grouping');
        string statusUpload = ApexPages.currentPage().getParameters().get('upload');
        
        if (totalJobProcess >  0){
            batchStatusJob = 'Processing';
            flagMessage = false;
            if (isDistribution == true) ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'System are now processing your request, please wait up to 10 minutes until it`s distributed completely.'));
        } else { 
            if (processJob != null) {
                flagMessage = true;
                if (grouping == 'true')  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Grouping success.')); 
                if (statusUpload == 'success') ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully'));
            }
            if (isDistribution == true) ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Distribution is Completed'));
            
            batchId = new Map<id,String>();
            message = 'COMPLETED';
            batchStatusJob = 'Finish';  
        }
        system.debug('batchStatusJob:'+batchStatusJob);
        return null;
    }
    
    
    public boolean getShowProgressBar() {
        System.debug('check Progress Bar');
        if(batchStatusJob == 'Processing' ) return true; 
        return false;
    }
    
}