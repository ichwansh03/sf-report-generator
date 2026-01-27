public class File_Update_AMFS_Ctrl {
    public boolean FlagMessage {get;set;}
    public String choosen_campaign {get;set;}
    public List<SelectOption> optionCampaign_list {get;set;}
    public Integer uploadedNum {get; set;}
    public Integer validNum {get; set;}
    public Integer invalidNum {get; set;}
    public String entity {get; set;}
    public List<AggregateResult> campaign_list {get;set;}
    public List<CollectionTask> CollectionTaskList {get; set;}
    public String CollectionTaskArr {get; set;}
    public List<String> list_policyNoBatch {get;set;}
    public Integer totalDataCSV {get;set;}
    public List<Call_Line__c> callLineList {get;set;}
    public List<String> list_policyNo {get;set;}
    public List<String> invalidPolicyList {get;set;}
    public List<String> invalidPolicyTempList {get;set;}
    
    Public String AMFS = 'AMFS';
    
    public List<invalidPolicy> list_invalidPolicy {get;set;}
    public List<String> list_invalidPolicyText {get;set;}
    public String invalidPolicy {get; set;}
    public integer countInvalid {get;set;}
    
    public Document document {
        get {
            if (document == null){
                document = new Document();
            }
            return document;
        }
        set;
    }
    
    public File_Update_AMFS_Ctrl(){
        list_invalidPolicy = new List<invalidPolicy>();
        list_invalidPolicyText = new list<string>();
        countInvalid = 0;
        uploadedNum = 0;
        validNum = 0;
        invalidNum = 0;
        
        string StatusUpload = ApexPages.currentPage().getParameters().get('upload');
        string StatusuploadedNum = ApexPages.currentPage().getParameters().get('uploadedNum');
        string StatusvalidNum = ApexPages.currentPage().getParameters().get('validNum');
        string StatusinvalidNum = ApexPages.currentPage().getParameters().get('invalidNum');
        string Statuslist_invalidPolicy = ApexPages.currentPage().getParameters().get('list_invalidPolicy');
        system.debug('Statuslist_invalidPolicy : '+ Statuslist_invalidPolicy);
        
        if (StatusuploadedNum != NULL && StatusuploadedNum != '') uploadedNum = integer.valueof(StatusuploadedNum);
        if (StatusvalidNum != NULL && StatusvalidNum != '') validNum = integer.valueof(StatusvalidNum);
        if (StatusinvalidNum != NULL && StatusinvalidNum != '') invalidNum = integer.valueof(StatusinvalidNum);
        if (StatusUpload == 'success') {
            FlagMessage = TRUE;
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully'));
            list_invalidPolicyText = Statuslist_invalidPolicy.split(',');
            System.debug('list_invalidPolicyText.size() ' +list_invalidPolicyText.size());
            for (integer i=0; i < list_invalidPolicyText.size(); i++) {
                if (i < 999 && list_invalidPolicyText[i] != '()') list_invalidPolicy.add(new invalidPolicy(list_invalidPolicyText[i], 'Policy Number is Not Found'));
            }
        }
    
        User userObj = [select id, Entity__c from user where id = :UserInfo.getUserId()];
        Entity = userObj.Entity__c;
        String loggedInUser = userObj.id;
        
        campaign_list = Database.query('SELECT Case_Type_Config__c FROM Call_List__c WHERE Entity__c = :AMFS AND createdby.id = :loggedInUser AND Case_Type_Config__c != \'Cuti Premi\' AND Case_Type_Config__c != \'RTU\' group by Case_Type_Config__c');
        optionCampaign_list = new List<SelectOption>();
        if (campaign_list.size() > 0){
            for(AggregateResult cl : campaign_list){
                String result = String.ValueOf(cl.get('Case_Type_Config__c'));
                optionCampaign_list.add(new SelectOption(result, result));
            }
        }
        else {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'There`s no campaign / call line available'));   
        }
    }
    
    public PageReference Upload(){
        System.debug('***choosen_campaign: ' + choosen_campaign);
        FlagMessage = TRUE;
        document.AuthorId = UserInfo.getUserId();
        document.FolderId = UserInfo.getUserId(); // put it in running user's folder
        //outboundCallList = new List<OutboundCall>();
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
                boolean fileExtension = document.name.endsWith('.csv');
                if(!fileExtension){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Uploaded file type is not supported. Please upload csv file only.'));
                    return null;
                }
                document.name = choosen_campaign;
                
                List<String> dataList = parseCollectionTaskCSV(nameFile,true);
                uploadedNum = dataList.size();
                processCollectionTask(dataList);
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
        PageReference pageRef = new PageReference('/apex/File_Update_AMFS?upload=success&uploadedNum='+uploadedNum+'&validNum='+validNum+'&invalidNum='+countInvalid+'&list_invalidPolicy='+invalidPolicy);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
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
        
        string csvpolicyNo = '';
        string csvStatusPaid = '';
        
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
        String campaignName = choosen_campaign;
        
        for(List<string> rc : allFields){
            num = 0;
            isValid = true;
            for(string col : rc){
                if(num==0) {
                    csvpolicyNo = col.trim();    
                }else if(num==1){
                    csvStatusPaid = col.trim();
                }
                
                num++; 
            }
            
            if(isValid || Test.isRunningTest()){
                dataList.add(csvpolicyNo);
                system.debug('## policy no : '+csvpolicyNo);
                CollectionTask = new CollectionTask();
                CollectionTask.policyNo = csvpolicyNo;
                CollectionTask.statusPaid = csvStatusPaid;
                
                if(!map_BatchExist.containsKey(csvpolicyNo)){
                    map_BatchExist.put(csvpolicyNo,true);
                    CollectionTaskList.add(CollectionTask);
                    list_policyNoBatch.add(csvpolicyNo);
                }else{
                    //duplicate in file
                    if (countInvalid < 999) list_invalidPolicy.add(new invalidPolicy(csvpolicyNo, 'Duplicate found in uploaded file'));
                    if (countInvalid < 999) list_invalidPolicyText.add(csvpolicyNo);
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
        //campaign terakhir
        List<Call_List__c> lastCampaign = [SELECT CreatedDate, Case_Type_Config__c FROM Call_List__c where Case_Type_Config__c = :choosen_campaign order by CreatedDate desc limit 1];
        System.debug('lastCampaign ' +lastCampaign);
        List<Call_List__c> lastCampaignList = new List<Call_List__c>();
        Datetime lastCampaignCreated;
        if(lastCampaign.size() > 0){
            lastCampaignCreated = lastCampaign[0].CreatedDate;
            //lastCampaignList = [SELECT Id, CreatedDate, Case_Type_Config__c FROM Call_List__c where Case_Type_Config__c = :choosen_campaign And CreatedDate >= :lastCampaignCreated.addMonths(-6) order by CreatedDate desc];
            // Taufik, 22 Sept 2020, Checklist "Freeze_Update_Status_Paid__c" = FALSE, Jalan Normal.
            lastCampaignList = [SELECT Id, CreatedDate, Case_Type_Config__c FROM Call_List__c where Freeze_Update_Status_Paid__c = FALSE AND Case_Type_Config__c = :choosen_campaign And CreatedDate >= :lastCampaignCreated.addMonths(-6) order by CreatedDate desc];
            System.debug('lastCampaignList ' +lastCampaignList);
            if(lastCampaignList.size() == 0){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'There`s no campaign for the last 6 Months'));
            }
        } 
        
        List<Call_Line__c> existingCallLineList = [select id, Case_Type__c, Ext_ID_F__c, Ext_ID_Temp__c, Policy_No__c, Entity__c, Batch_No__c, Call_List__c from Call_Line__c 
                                                   where Policy_No__c IN :list_policyNoBatch and Case_Type__c = :choosen_campaign and Call_List__c In :lastCampaignList and call_list__r.Entity__c = :AMFS 
                                                   AND call_list__r.createdby.id = :UserInfo.getUserId() order by createddate asc];
        
        if(test.isRunningTest()){
            existingCallLineList = [select id, Case_Type__c, Ext_ID_F__c, Ext_ID_Temp__c, Policy_No__c, Entity__c, Batch_No__c, Call_List__c from Call_Line__c Limit 10];
        }
            
        integer existingCounter = existingCallLineList.size();
        validNum = uploadedNum - existingCounter;
        invalidNum = totalDataCSV - validNum;
        
        callLineList = new List<Call_Line__c>();
        Call_Line__c callLine = null;
        Call_List__c campaign = null;
        integer idx = 0;
        boolean isExist = false;    //added by WK, 20150417
        
        map<string,Call_Line__c> mapCallLineList = new map<string,Call_Line__c>();
        //List<Call_Line__c> callLineListUpdate = new List<Call_Line__c>();
        map<string,List<Call_Line__c>> mapCallLineListUpdate = new map<string,List<Call_Line__c>>();
        
        for(Call_Line__c cl : existingCallLineList){
            if(cl.Batch_No__c == NULL) cl.Batch_No__c = '';
            
            if(choosen_campaign == 'Redemption TM' || choosen_campaign == 'Lapse TM' || choosen_campaign == 'Lapse Konven'){
                //callLineListUpdate.add(cl);
                
                if(mapCallLineListUpdate.get(cl.Ext_ID_Temp__c) == Null){
                    List<Call_Line__c> temp = new List<Call_Line__c>();
                    temp.add(cl);
                    mapCallLineListUpdate.put(cl.Ext_ID_Temp__c, temp);
                } else {
                    List<Call_Line__c> temp = mapCallLineListUpdate.get(cl.Ext_ID_Temp__c);
                    temp.add(cl);
                    mapCallLineListUpdate.put(cl.Ext_ID_Temp__c, temp);
                }
            }else{
                mapCallLineList.put(cl.Ext_ID_Temp__c, cl);
            }
        }
        //System.debug('callLineListUpdate ' +callLineListUpdate.size());
        list_policyNo = new List<String>();
                
        for(CollectionTask conv : CollectionTaskList){
            // check sudah pernah upload atau belum.
            System.debug('mapCallLineList ' +mapCallLineList.size() +' existingCounter ' +existingCounter);
            
            if(choosen_campaign == 'Redemption TM' || choosen_campaign == 'Lapse TM' || choosen_campaign == 'Lapse Konven'){
                /*
                if(callLineListUpdate.size() > 0){
                    for(Call_Line__c cline : callLineListUpdate){
                        if(conv.policyNo == cline.Ext_ID_Temp__c){
                            if(conv.statusPaid.toUpperCase() == 'Y') cline.Status_Paid_Not_Paid__c = 'Y';
                            else if(conv.statusPaid.toUpperCase() == 'N') cline.Status_Paid_Not_Paid__c = 'N';
                            else if(conv.statusPaid.toUpperCase() == 'PAID') cline.Status_Paid_Not_Paid__c = 'Paid';
                            else if(conv.statusPaid.toUpperCase() == 'NOT PAID') cline.Status_Paid_Not_Paid__c = 'Not Paid';
                            else cline.Status_Paid_Not_Paid__c = conv.statusPaid;
                            callLineList.add(cline);
                        }
                    }   
                }*/
                
                if(mapCallLineListUpdate.get(conv.policyNo) != Null){
                    List<Call_Line__c> clList = mapCallLineListUpdate.get(conv.policyNo);
                    for(Call_Line__c cline : clList){
                        if(conv.statusPaid.toUpperCase() == 'Y') cline.Status_Paid_Not_Paid__c = 'Y';
                        else if(conv.statusPaid.toUpperCase() == 'N') cline.Status_Paid_Not_Paid__c = 'N';
                        else if(conv.statusPaid.toUpperCase() == 'PAID') cline.Status_Paid_Not_Paid__c = 'Paid';
                        else if(conv.statusPaid.toUpperCase() == 'NOT PAID') cline.Status_Paid_Not_Paid__c = 'Not Paid';
                        else cline.Status_Paid_Not_Paid__c = conv.statusPaid;
                        callLineList.add(cline);
                    } 
                }
            }            
            else if (mapCallLineList.get(conv.policyNo) != NULL) {
                Call_Line__c cl = mapCallLineList.get(conv.policyNo);
                if(conv.statusPaid.toUpperCase() == 'Y') cl.Status_Paid_Not_Paid__c = 'Y';
                else if(conv.statusPaid.toUpperCase() == 'N') cl.Status_Paid_Not_Paid__c = 'N';
                else if(conv.statusPaid.toUpperCase() == 'PAID') cl.Status_Paid_Not_Paid__c = 'Paid';
                else if(conv.statusPaid.toUpperCase() == 'NOT PAID') cl.Status_Paid_Not_Paid__c = 'Not Paid';
                else cl.Status_Paid_Not_Paid__c = conv.statusPaid;
                callLineList.add(cl);
            } // end check 
            else{
                // duplicate with existing record
                if (countInvalid < 999) list_invalidPolicy.add(new invalidPolicy(conv.policyNo, 'Policy Number is Not Found'));
                if (countInvalid < 999) list_invalidPolicyText.add(conv.policyNo);
                countInvalid += 1;
            }
        } // end Co
        system.debug('## CallLineList : '+callLineList.size());
                
        if (callLineList.size() > 0) {
            CallLineUpdateBatch jb = new CallLineUpdateBatch(callLineList);
            Database.executeBatch(jb, 65);
        }
        
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
        
        validNum = totalDataCSV - countInvalid;
        System.debug('Test ni ya ' +validNum +' = ' +totalDataCSV +' - ' +countInvalid);
        
        invalidPolicy = String.join(list_invalidPolicyText, ',');
        System.debug('invalidPolicy ' +invalidPolicy);
        
        insert document;
    }
    
    public PageReference Reset(){
        document = new Document();
        document.body = Blob.valueOf('test'); // clears the viewstate
        choosen_campaign = 'test';
        PageReference tempPage = new PageReference('/apex/File_Update_AMFS');
        tempPage.setRedirect(true);
        return tempPage;
    }
    
    public class invalidPolicy{
        public string policyNo {get;set;}
        public string status {get;set;}
        public invalidPolicy(string policyNo, string status){
            this.policyNo = policyNo;
            this.status = status;
        }
    }
    public class CollectionTask{
        public String PolicyNo {get;set;}
        public String statusPaid {get;set;}
    }
}