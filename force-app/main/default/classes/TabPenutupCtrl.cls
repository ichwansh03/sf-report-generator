global class TabPenutupCtrl {
    public Call_Line__c cl {get;set;}
    
    //direct access from visualforce
    public Map<String, ScriptObj.Direction> mapDirection {get;set;}
    public String serialMapDirection {get;set;}
    public Map<String, ScriptObj> mapScript = new Map<String, ScriptObj>();
    public String serialMapScript {get;set;}
    public Map<String, ResponseScript> mapDatatoSaved = new Map<String, ResponseScript>();
    public String serialDatatoSaved {get;set;}
    public Map<String, Set<ScriptObj.Direction>> mapInputPerSection = new Map<String, Set<ScriptObj.Direction>>();
    public String serialInputPerSection {get;set;}
    public Map<String, List<ScriptObj.Direction>> mapDependencyListValue = new Map<String, List<ScriptObj.Direction>>();
    public String serialDependencyListValue {get;set;}
    public Map<String, Set<String>> mapDependencyList = new Map<String, Set<String>>();
    public String serialDependencyList {get;set;}
    public Boolean isStatusClosed {get;set;}
    
    private static WelcomeCallUtils wcu = new WelcomeCallUtils();
    private static Contact contact = new Contact();
    public Call_Line__c call_line {get;set;}
    private String productValue='';
    private String tab='';
    private Id clId;
    private List<SurveyTaker__c> svTaker = new List<SurveyTaker__c>();
    private Map<String, ResponseScript> mapOfExistingResponse = new Map<String, ResponseScript>();
    
    public Boolean detailStatus {get;set;}
    public Boolean reasonDetailStatus {get;set;}
    public String activityDisabled {get;set;}
    public String callLineStatusDisabled {get;set;}
    
    public Survey_Response__c respon {get;set;}
    public WrapperResponse wrResponse {get;set;}
    
    public class WrapperResponse{
        public String callStatus {get; set;}
        public String reasonStatus {get; set;}
        public String detailStatus {get; set;}
        public String reasonDetailStatus {get; set;}
        public String note {get; set;}
    }
    
    public List<String> getPickListValuesIntoList(String objectType, String selectedField){
        List<String> pickListValuesList = new List<String>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectType);
        Schema.DescribeSObjectResult res = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = res.fields.getMap().get(selectedField).getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
        }     
        return pickListValuesList;
    }
    
    public void populateAllReponseFromPreviousTab(Id callId){
            List<Survey_Response__c> res = [SELECT WelcomeCall_Address_1__c, WelcomeCall_Address_2__c, WelcomeCall_Address_3__c, WelcomeCall_Address_4__c, 
                                    WelcomeCall_Email__c, WelcomeCall_Others__c, Answer_1__c, Answer_2__c,Answer_3__c ,Answer_4__c , WelcomeCall_Section__c, WelcomeCall_Tab__c,
                                    WelcomeCall_Note__c, Question_1__c
                                 FROM Survey_Response__c
                                 WHERE WelcomeCall_Call_Line__c = :callId and Answer_1__c <> null order by Question_1__c, createddate asc];
        Integer i=1;
        wrResponse =  new WrapperResponse();
        wrResponse.note = '';
        Boolean isContacted = false;
        List<String> callStatus = getPickListValuesIntoList('Call_Line__c', 'Activity_Result__c');
        List<String> result = getPickListValuesIntoList('Call_Line__c', 'Verification__c');
        List<String> detailStatus = getPickListValuesIntoList('Call_Line__c', 'WelcomeCall_Detail_Status__c');
        List<String> reasonDetailStatus = getPickListValuesIntoList('Call_Line__c', 'WelcomeCall_Reason_Detail_Status__c');
        Boolean isCheckAll = true;
        String section;
        for(Survey_Response__c r : res){
            System.debug('count '+i);
            System.debug('response answer 1 = "'+r.Answer_1__c+'", answer 2 = "'+r.Answer_2__c+'"');
            isCheckAll = true;
            //String tempStr='';
            if(r.WelcomeCall_Section__c == 'Pembuka' && (callStatus.indexOf(r.Answer_1__c) != -1)){
                call_line.Activity_Result__c = r.Answer_1__c;
                isCheckAll = false;
                if(r.Answer_1__c == 'Uncontacted'){
                    isContacted = true;
                    System.debug('isContacted '+isContacted);
                }
            }
            if((i == 2 || (/**i== 1 && */r.Answer_2__c != null)) && isContacted){
                
                String tempStr = r.Answer_1__c;//(r.Answer_2__c != null) ? r.Answer_2__c : r.Answer_1__c;
                    System.debug('tempStr '+tempStr);
                if(result.indexOf(tempStr) != -1){
                    isCheckAll = false;
                    call_line.Verification__c = tempStr;
                }
            }
            if((i ==3 || (/**i== 2 && */r.Answer_2__c != null)) && isContacted){
                String tempStr = (r.Answer_2__c != null) ? r.Answer_2__c : r.Answer_1__c;
                System.debug('tempStr '+tempStr);
                if(detailStatus.indexOf(tempStr) != -1){
                    isCheckAll = false;
                    call_line.WelcomeCall_Detail_Status__c = tempStr;
                }
            }
            if((i ==4 || (/**i== 3 && */r.Answer_2__c != null)) && isContacted){
                String tempStr = (r.Answer_2__c != null) ? r.Answer_2__c : r.Answer_1__c;
                System.debug('tempStr '+tempStr);
                if(reasonDetailStatus.indexOf(tempStr) != -1){
                    isCheckAll = false;
                    call_line.WelcomeCall_Reason_Detail_Status__c = tempStr;
                }
            }
            
            system.debug('isCheckAll =='+isCheckAll);
            
            if(isCheckAll){
                if(result.indexOf(r.Answer_1__c) != -1){
                    call_line.Verification__c = r.Answer_1__c;
                }
                if(detailStatus.indexOf(r.Answer_1__c) != -1){
                    call_line.WelcomeCall_Detail_Status__c = r.Answer_1__c;
                }
                if(reasonDetailStatus.indexOf(r.Answer_1__c) != -1){
                    call_line.WelcomeCall_Reason_Detail_Status__c = r.Answer_1__c;
                }
                if(result.indexOf(r.Answer_2__c) != -1){
                    call_line.Verification__c = r.Answer_2__c;
                }
                if(detailStatus.indexOf(r.Answer_2__c) != -1){
                    call_line.WelcomeCall_Detail_Status__c = r.Answer_2__c;
                }
                if(reasonDetailStatus.indexOf(r.Answer_2__c) != -1){
                    call_line.WelcomeCall_Reason_Detail_Status__c = r.Answer_2__c;
                }
                
            }

            if(r.WelcomeCall_Note__c != null){
                wrResponse.note = wrResponse.note +' '+ r.WelcomeCall_Note__c;
                call_line.Notes__c = wrResponse.note;
            }
            system.debug('call_line.Verification__c =='+call_line.Verification__c);            
            i++;
        }
    }
    
    public TabPenutupCtrl(ApexPages.StandardController controller){
           clId = ApexPages.CurrentPage().getParameters().get('id');
           tab = ApexPages.CurrentPage().getParameters().get('tab');
           call_line = new call_line__c();
           contact = new contact();
        //test
        //clId = 'a015D000003QpaIQAS';
        //tab ='salam';
       
        
        // updated by Ranti at 31/10/2022
        //svTaker = [Select id from SurveyTaker__c where WelcomeCall_CallLine__c =: clId ];
         svTaker = [Select id from SurveyTaker__c where (WelcomeCall_CallLine__c =: clId OR Call_Line_Survey__c =: clId)];
         
        if(clId != null){
            call_line = wcu.getCLById(cLId);
            populateAllReponseFromPreviousTab(clid);
            contact = wcu.getContactById(call_line.Contact__c);   
            productValue = contact.WelcomeCall_Product_Code_Plan__c+';';//wcu.checkProductType(contact.WelcomeCall_Product_Code_Plan__c);
            wcu.getListofProductNameByCode(contact.WelcomeCall_Product_Code_Plan__c);
            
            // set disabled flag if call line already closed
            isStatusClosed = call_line.welcomecall_call_line_status__c == 'Closed' ? true : false;
            
            List<Survey_Response__c> res = [SELECT WelcomeCall_Address_1__c, WelcomeCall_Address_2__c, WelcomeCall_Address_3__c, WelcomeCall_Address_4__c, 
                                    WelcomeCall_Email__c, WelcomeCall_Others__c
                                 FROM Survey_Response__c
                                 WHERE WelcomeCall_Call_Line__c = :call_line.Id AND WelcomeCall_Tab__c = 'Verifikasi data'
                                 LIMIT 1];
            if(!res.isEmpty()){
                respon = res.get(0);
            }
            
            if((call_line.WelcomeCall_Detail_Status__c == null) || (call_line.WelcomeCall_Detail_Status__c == ''))
                detailStatus = true;
            else
                detailStatus = false;
            
            if((call_line.WelcomeCall_Reason_Detail_Status__c == null) || (call_line.WelcomeCall_Reason_Detail_Status__c == ''))
                reasonDetailStatus = true;
            else
                reasonDetailStatus = false;
            activityDisabled = '';
            callLineStatusDisabled = '';
            if(call_line.WelcomeCall_Call_Line_Status__c == 'Closed'){
                activityDisabled = 'disabled';
                callLineStatusDisabled = 'disabled';
            }
        }
        
        // populate all data, existing response, script from custom setting
        // replace variable, convert to wrapper class, etc.
        populateExistingResponse();
        mapScript = getScripts();
        serialMapDirection = JSON.serialize(mapDirection);
        serialMapScript = JSON.serialize(mapScript);
        serialDatatoSaved = JSON.serialize(mapDatatoSaved);
        serialInputPerSection = JSON.serialize(mapInputPerSection);
        serialDependencyListValue = JSON.serialize(mapDependencyListValue);
        serialDependencyList = JSON.serialize(mapDependencyList);
    }
    
    private static Map<String, String> populateMapNameSection(List<WelcomeCall_Script__c> scripts){
        Map<String, String> mNametoSection = new Map<String, String>();
        for(WelcomeCall_Script__c script : scripts){
            mNametoSection.put(script.Name, script.WelcomeCall_Section__c);
        }
        return mNametoSection;
    }
    private void createMapDatatoSaved(WelcomeCall_Script__c script){
        ResponseScript rs = mapOfExistingResponse.get(script.WelcomeCall_Section__c);
        if(rs == null){
            rs = new ResponseScript();
            rs.section = script.WelcomeCall_Section__c;
            rs.tab = script.WelcomeCall_Tab_Name__c;
            rs.callLineId = clId;
        }
        //all space will remove for id in html element
        mapDatatoSaved.put(script.WelcomeCall_Section__c.deleteWhitespace(), rs);
    }
    
    private void populateExistingResponse(){
        Map<String, ResponseScript> mapOfResponse = new Map<String, ResponseScript>();
        List<Survey_Response__c> responses = [Select id, name, WelcomeCall_Section__c, WelcomeCall_Tab__c, WelcomeCall_Call_Line__c,
                                       Question_1__c, Question_2__c, Question_3__c, Question_4__c, WelcomeCall_Note__c,
                                       Answer_1__c, Answer_2__c, Answer_3__c, Answer_4__c,
                                       SurveyTaker__c, WelcomeCall_Others__c,WelcomeCall_Address_1__c,WelcomeCall_Address_2__c  ,
                                       WelcomeCall_Address_3__c, WelcomeCall_Address_4__c, WelcomeCall_Email__c
                                      from Survey_Response__c
                                      where WelcomeCall_Tab__c =: tab and WelcomeCall_Call_Line__c =: clId];
        for(Survey_Response__c res : responses){
            ResponseScript rs = new ResponseScript(res);
            mapOfExistingResponse.put(rs.section, rs);
        }
    }
    private void populateListOfInputPerSection(String section, ScriptObj.Direction dr){
        section = (section != null ? section.deleteWhitespace() : '');
        Set<ScriptObj.Direction> drs = mapInputPerSection.get(section);
        ScriptObj.Direction drInput = new ScriptObj.Direction();
        if(drs == null || drs.isEmpty()){
            drs = new Set<ScriptObj.Direction>();
        }
            //drInput.name = dr.name;
            //drInput.type = dr.type.deleteWhitespace().toLowerCase();
            drInput.grpType = dr.grpType.deleteWhitespace();
            drs.add(dr);
        if(dr.fgNote){
            ScriptObj.Direction drNote = new ScriptObj.Direction();
            drNote.name = dr.name;//'note'+section;
            drNote.grpType = section;
            drNote.type = 'textarea';
            drs.add(drNote);
        }
        mapInputPerSection.put(section, drs);
    }
    
    private void populateListOfDependency(String section, ScriptObj.Direction dr){
        section = section.deleteWhitespace();
        String[] pDependency = dr.parentDependency.split(';');
        for(String pDep : pDependency){
            // set list value of dependency per value
            pDep = pDep.deleteWhitespace();
            List<ScriptObj.Direction> drs = mapDependencyListValue.get(pDep);
            if(drs == null || drs.isEmpty()){
                drs = new List<ScriptObj.Direction>();
            }
            drs.add(dr);
            mapDependencyListValue.put(pDep, drs);
            
            // set list of dependency per group
            // to reset child list value if parent does not have any child
            ScriptObj.Direction parent = mapDirection.get(pDep);
            if(parent != null){
                Set<String> grpList = mapDependencyList.get(parent.grpType.deleteWhitespace());
                if(grpList == null || grpList.isEmpty()){
                    grpList = new Set<String>();
                }
                grpList.add(dr.grpType.deleteWhitespace());
                mapDependencyList.put(parent.grpType.deleteWhitespace(), grpList);
            }
            
        }
    }
    
    public Map<String, ScriptObj> getScripts(){
        String newSearchText = '%'+productValue+'%';
        List<WelcomeCall_Script__c> scripts = wcu.getScriptByTab(tab);
        
        Map<String, String> mNametoSection = populateMapNameSection(scripts);
        Map<String, Document> mapDocImage= wcu.populateMapDocumentbyKeyName('Welcome Call Image');
        Map<String, String> mParentSection = new Map<String, String>();
        Map<String, ScriptObj> mScript = new Map<String, ScriptObj>();
        mapDirection = new Map<String, ScriptObj.Direction>();
        Integer i=1;
        List<string> sections = new List<string>();//{'Konfirmasi Kelanjutan Polis','Pembatalan','Verifikasi Data'};
        List<Survey_Response__c> responseLnjutPolis = wcu.getResponseByParams(sections, clId);
        // hardcode to open section, temp
        Boolean defSlmPenutup = true;
        for(WelcomeCall_Script__c script : scripts){
            String product = script.WelcomeCall_Product_Name__c;
            if(product != null && product.contains('LABEL')){
                product = wcu.getCustomLabelValue(script.WelcomeCall_Product_Name__c.replace('LABEL_',''));
            }
        if(product.contains(productValue)){
            createMapDatatoSaved(script);
            
            String lParent = script.WelcomeCall_Parent__c == null ? '' : script.WelcomeCall_Parent__c ;
            if(script.WelcomeCall_Parent__c != null && script.WelcomeCall_Parent__c.contains('LABEL')){
                lParent = wcu.getCustomLabelValue(script.WelcomeCall_Parent__c.replace('LABEL_',''));
            }
            String[] parents = (lParent != null ? lParent : '').split(';');
            for(String parent : parents){
                parent = parent.replace(' ', '');
                // save all parent, in case the order of name is not in sequence.
                mParentSection.put(parent, script.WelcomeCall_Section__c);
                ScriptObj existsObj = mScript.get(mNametoSection.get(parent));
                // set next
                if(existsObj != null){
                    for(Map<String, ScriptObj.Direction> mapDr : existsObj.getMultiContentAnswer().values()){
                        if(mapDr != null){
                            ScriptObj.Direction dr = mapDr.get(parent);
                            if(dr != null){
                                dr.next = mNametoSection.get(script.name);
                                if(dr.fgIsExist){
                                    existsObj.defNext = (dr.next != null ? dr.next.deleteWhitespace() : '');
                                }
                                existsObj.setMultiContentAnswer(dr);
                                mScript.put(existsObj.section, existsObj);
                                mapDirection.put(dr.name, dr);
                                
                                //populate input per section
                                populateListOfInputPerSection(existsObj.section, dr);
                            } 
                        }
                    }
                }
            }
            
            ScriptObj sObj = mScript.get(script.WelcomeCall_Section__c);
            if(sObj == null){
                sObj = new ScriptObj(script);
                sObj.secOrder =i;
                i++;
                for(Survey_Response__c rc : responseLnjutPolis){
                    //if(sObj.section == 'Informasi Cooling Off' && rc.Answer_1__c == 'Continue' && rc.WelcomeCall_Section__c == 'Konfirmasi Kelanjutan Polis'){
                    if((rc.Question_1__c != null && lParent.contains(rc.Question_1__c)) || (rc.Question_2__c != null && lParent.contains(rc.Question_2__c))){ //&& (rc.Answer_1__c == 'Continue' || rc.Answer_1__c == 'Verikasi Tidak Berhasil' 
                                                     //|| rc.WelcomeCall_Section__c == 'Pembatalan' || sObj.section == 'Salam Penutup')){
                        sObj.defaultOpen = true;
                        defSlmPenutup = false;
                    }
                    /**if(rc.Answer_1__c == 'Continue'){
                        defSlmPenutup = true;
                    }*/
                }
               /** if(defSlmPenutup && sObj.section == 'Salam Penutup'){
                    sObj.defaultOpen = true;
                } else if(!lnjutPolis && sObj.section == 'Salam Penutup Pembatalan'){
                    sObj.defaultOpen = true;
                }*/
                
                // auto get question from custom label value
                if(sObj.lookupLabel != ''){
                    String[] labels = sObj.lookupLabel.split(';');
                    for(String label : labels){
                        if(label != null){
                            sObj.contentQuestion = sObj.contentQuestion+wcu.getCustomLabelValue(label);
                        }
                    }
                }
                sObj.contentQuestion = wcu.replaceVariableQuestion(sObj.contentQuestion, contact, call_line);
                if(sObj.lookupLabel2 != ''){
                    String[] labels = sObj.lookupLabel2.split(';');
                    for(String label : labels){
                        if(label != null){
                            sObj.contentQuestion2 = sObj.contentQuestion2+wcu.getCustomLabelValue(label);
                        }
                    }
                }
                sObj.contentQuestion2 = wcu.replaceVariableQuestion(sObj.contentQuestion2, contact, call_line);
            }else {
                if(script.WelcomeCall_Fg_Note__c){
                    sObj.contentCount = sObj.contentCount + 1;   
                    sObj.defaultFgNote = script.WelcomeCall_Fg_Note__c;
                }
            }
            ResponseScript rs = mapOfExistingResponse.get(script.WelcomeCall_Section__c);
            ScriptObj.Direction dr = new ScriptObj.Direction(script);
            
            // set image id
            if(!String.isBlank(script.WelcomeCall_ImageAnswer_c__c)){
              Document doc = mapDocImage.get(script.WelcomeCall_ImageAnswer_c__c);
              if(doc != null){
                dr.imageResourceAnswer = doc.Id;
              }
            }
            if(!String.isBlank(script.WelcomeCall_ImageContent_c__c)){
                    String[] imgaeContent = script.WelcomeCall_ImageContent_c__c.split(';');
                    for(String img : imgaeContent){
                        if(img != null && img != ''){
                          Document doc = mapDocImage.get(img.deleteWhitespace());
                          if(doc != null){
                            sObj.imageResourceContent.add(doc.Id);
                            dr.imageResourceContent.add(doc.Id);
                          }
                        }
                    }
            }
            // end set image id
            
            dr.previous = mNametoSection.get(dr.parent);
            dr.question = sObj.contentQuestion;
            if(mParentSection.get(dr.name) != null){
                dr.next = mParentSection.get(dr.name);
            }
            if(rs != null && ((rs.question1 != null && dr.parentDependency.contains(rs.question1))
                                                       ||(rs.question2 != null && dr.parentDependency.contains(rs.question2)))){
                dr.fgDefault = true;
            }
            if(rs != null && rs.responseId != null && (rs.question1 == dr.name || rs.question2 == dr.name || 
                                                      rs.question3 == dr.name || rs.question4 == dr.name)){
                dr.note = rs.note;
                dr.fgIsExist = true;
                dr.fgDefault = true;
                sObj.defPrevious = ( dr.previous != null ? dr.previous.deleteWhitespace() : '').remove(';');
                sObj.defNote = dr.note;
            } else {
                dr.fgIsExist = false;                                    
            }
            sObj.setMultiContentAnswer(dr);
            mapDirection.put(dr.name, dr);
            populateListOfInputPerSection(sObj.section, dr);
            populateListOfDependency(sObj.section, dr);
            mScript.put(sObj.section, sObj);
            
        }
        }
        return mScript;
    }
    
    @RemoteAction
    public static List<Survey_Response__c> SaveorUpdateScript(String mapOfScript){
        Map<String, ResponseScript> rss = (Map<String, ResponseScript>) JSON.deserialize(mapOfScript, Map<String,ResponseScript>.class);
        List<Survey_Response__c> responses = new List<Survey_Response__c>();
        String result;
        for(String str : rss.keySet()){
            Survey_Response__c response = new Survey_Response__c();
            ResponseScript res = (ResponseScript) rss.get(str);
            if(res != null && res.isValid != null && res.isValid){
                // updated by Ranti at 31/10/2022
                // List<SurveyTaker__c> svTaker = [Select id, welcomecall_callline__c from SurveyTaker__c where WelcomeCall_CallLine__c =: res.callLineId];
                List<SurveyTaker__c> svTaker = [Select id, welcomecall_callline__c,Call_Line_Survey__c from SurveyTaker__c where (WelcomeCall_CallLine__c =: res.callLineId OR Call_Line_Survey__c =: res.callLineId)];
                response.Id = res.responseId;
                
                //response.Id = res.responseId;
                response.WelcomeCall_Note__c = res.note != null ? res.note : '';
                response.Answer_1__c = res.answer1 != null ? res.answer1 : '';
                response.answer_2__c = res.answer2 != null ? res.answer2 : '';
                response.Answer_3__c = res.answer3 != null ? res.answer3 : '';
                response.answer_4__c = res.answer4 != null ? res.answer4 : '';
                response.Question_1__c = res.question1 != null ? res.question1 : '';
                response.Question_2__c = res.question2 != null ? res.question2 : '';
                response.Question_3__c = res.question3 != null ? res.question3 : '';
                response.Question_4__c = res.question4 != null ? res.question4 : '';
                response.WelcomeCall_Tab__c = res.tab != null ? res.tab : '';
                response.WelcomeCall_Section__c = res.section != null ? res.section : '';
                response.WelcomeCall_Address_1__c = res.address1 != null ? res.address1 : '';
                response.WelcomeCall_Address_2__c = res.address2 != null ? res.address2 : '';
                response.WelcomeCall_Address_3__c = res.address3 != null ? res.address3 : '';
                response.WelcomeCall_Address_4__c = res.address4 != null ? res.address4 : '';
                response.WelcomeCall_Email__c = res.email != null ? res.email : '';
                response.WelcomeCall_Others__c = res.other != null ? res.other : '';
                
                if(response.Id == null){
                    response.SurveyTaker__c = svTaker.get(0).Id;
                    // updated by Ranti at 31/10/2022
                    // response.WelcomeCall_Call_Line__c = svTaker.get(0).welcomecall_callline__c;
                    if (svTaker.get(0).welcomecall_callline__c != null) { 
                    	response.WelcomeCall_Call_Line__c = svTaker.get(0).welcomecall_callline__c;
                    } else {
                        response.WelcomeCall_Call_Line__c = svTaker.get(0).Call_Line_Survey__c; 
                    }
                }
                
                responses.add(response);
            }
        }
        if(!responses.isEmpty()){
            CallLineTriggerControl.skipResponseTrigger = true;
            upsert(responses);
            result = JSON.serialize(responses);
        }
        return responses;
    }
    
    public PageReference UpdateCallLineStatus(){
        /**if(isStatusClosed){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Status call line sudah pernah Closed, perubahan data tidak disimpan.'));
            return null;
        }*/
        
        if(!detailStatus && ((call_line.WelcomeCall_Detail_Status__c == '') || call_line.WelcomeCall_Detail_Status__c == null)){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Detail status harus diisi.'));
            //return null;
        }
        if(!reasonDetailStatus && ((call_line.WelcomeCall_Reason_Detail_Status__c == '') || call_line.WelcomeCall_Reason_Detail_Status__c == null)){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Reason detail status harus diisi.'));
            //return null;
        }
        try{
            update call_line;   
        } catch(DmlException e){
            System.debug('ERROR '+e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return null;
        }
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Data berhasil disimpan.'));
            if((call_line.WelcomeCall_Detail_Status__c == null) || (call_line.WelcomeCall_Detail_Status__c == ''))
                detailStatus = false;
            else
                detailStatus = true;
            
            if((call_line.WelcomeCall_Reason_Detail_Status__c == null) || (call_line.WelcomeCall_Reason_Detail_Status__c == ''))
                reasonDetailStatus = false;
            else
                reasonDetailStatus = true;
        
        return null;
    }

}