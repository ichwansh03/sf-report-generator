global class TabSurveyCtrl {
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
    public String serializeError {get;set;}
    public Map<String, String> mapStaticResource {get; set;}
    public String firstSection {get;set;}
    
    private static WelcomeCallUtils wcu = new WelcomeCallUtils();
    private static Contact contact = new Contact();
    private static Call_Line__c call_line = new Call_Line__c();
    private static String productValue='';
    private static String tab='';
    private static Id clId;
    private List<SurveyTaker__c> svTaker = new List<SurveyTaker__c>();
    private Map<String, ResponseScript> mapOfExistingResponse = new Map<String, ResponseScript>();
    
    public TabSurveyCtrl(ApexPages.StandardController controller){
        clId = ApexPages.CurrentPage().getParameters().get('id');
        tab = ApexPages.CurrentPage().getParameters().get('tab');
        call_line = new call_line__c();
        contact = new contact();
        //test
        mapStaticResource = new Map<string, String>();
        //clId = 'a015D00000E6Z7FQAV';
        //tab ='Survey';
        svTaker = [Select id from SurveyTaker__c where WelcomeCall_CallLine__c =: clId];
        
        if(clId != null){
            call_line = wcu.getCLById(cLId);
            contact = wcu.getContactById(call_line.Contact__c);   
            productValue = contact.WelcomeCall_Product_Code_Plan__c+';';//wcu.checkProductType(contact.WelcomeCall_Product_Code_Plan__c);
            wcu.getListofProductNameByCode(contact.WelcomeCall_Product_Code_Plan__c);
            // set disabled flag if call line already closed
            isStatusClosed = call_line.welcomecall_call_line_status__c == 'Closed' ? true : false;
        }
        
        // populate all data, existing response, script from custom setting
        // replace variable, convert to wrapper class, etc.
        populateExistingResponse();
        
        // START populateDetailNasabah *Added by Faizir 25-11-2019*
        system.debug('start test populateDetailNasabah==');
        wcu.populateDetailNasabah(contact, call_line);
        system.debug('end populateDetailNasabah==');
        // End populateDetailNasabah *Added by Faizir 25-11-2019*
        mapScript = getScripts();
        serialMapDirection = JSON.serialize(mapDirection);
        serialMapScript = JSON.serialize(mapScript);
        serialDatatoSaved = JSON.serialize(mapDatatoSaved);
        serialInputPerSection = JSON.serialize(mapInputPerSection);
        serialDependencyListValue = JSON.serialize(mapDependencyListValue);
        serialDependencyList = JSON.serialize(mapDependencyList);
        
        system.debug('ELVI 1 nih');
    }
    // END get Detail Nasabah from EIP *Added by Faizir 25-11-2019*
    
    private static Map<String, String> populateMapNameSection(List<WelcomeCall_Script__c> scripts){
        Map<String, String> mNametoSection = new Map<String, String>();
        for(WelcomeCall_Script__c script : scripts){
            mNametoSection.put(script.Name, script.WelcomeCall_Section__c);
        }
        system.debug('ELVI 2 nih');
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
        system.debug('ELVI 3 nih');
    }
    
    private void populateExistingResponse(){
        Map<String, ResponseScript> mapOfResponse = new Map<String, ResponseScript>();
        List<Survey_Response__c> responses = [Select id, name, WelcomeCall_Section__c, WelcomeCall_Tab__c, WelcomeCall_Call_Line__c,  
                                              Question_1__c, Question_2__c, Question_3__c, Question_4__c, WelcomeCall_Note__c,
                                              Answer_1__c, Answer_2__c, Answer_3__c, Answer_4__c,
                                              SurveyTaker__c, WelcomeCall_Others__c,WelcomeCall_Address_1__c,WelcomeCall_Address_2__c  ,
                                              WelcomeCall_Address_3__c, WelcomeCall_Address_4__c, WelcomeCall_Email__c
                                              from Survey_Response__c
                                              where WelcomeCall_Tab__c =: tab and WelcomeCall_Call_Line__c =: clId  ];
        for(Survey_Response__c res : responses){
            ResponseScript rs = new ResponseScript(res);
            mapOfExistingResponse.put(rs.section, rs);
        }        
        system.debug('ELVI 4 nih');
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
        mapInputPerSection.put(section, drs);
        system.debug('ELVI 5 nih');
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
        system.debug('ELVI 6 nih');
    }
    
    public Map<String, ScriptObj> getScripts(){
        system.debug('ELVI 12 nih' + tab);
        String newSearchText = '%'+productValue+'%';
        List<WelcomeCall_Script__c> scripts = wcu.getScriptByTab(tab);
        system.debug('ELVI 19 nih' + scripts);
        
        Map<String, String> mNametoSection = populateMapNameSection(scripts);
        Map<String, Document> mapDocImage= wcu.populateMapDocumentbyKeyName('Welcome Call Image');
        Map<String, String> mParentSection = new Map<String, String>();
        Map<String, ScriptObj> mScript = new Map<String, ScriptObj>();
        mapDirection = new Map<String, ScriptObj.Direction>();
        Integer i=1;
        for(WelcomeCall_Script__c script : scripts){
            if(i==1){
                firstSection = script.WelcomeCall_Section__c.replace(' ','');
                system.debug('ELVI 7 nih');
            }
            String product = script.WelcomeCall_Product_Name__c;
            system.debug('ELVI 18 nihH' + product + 'prodv'+productValue);
            if(product != null && product.contains('LABEL')){
                product = wcu.getCustomLabelValue(script.WelcomeCall_Product_Name__c.replace('LABEL_',''));
                system.debug('ELVI 8 nih');
            }
            if(product.contains(productValue)){
                system.debug('ELVI 16 nih' + product + 'prodv'+productValue);
                createMapDatatoSaved(script);
                
                String lParent = script.WelcomeCall_Parent__c;
                if(script.WelcomeCall_Parent__c != null && script.WelcomeCall_Parent__c.contains('LABEL')){
                    lParent = wcu.getCustomLabelValue(script.WelcomeCall_Parent__c.replace('LABEL_',''));
                }
                String[] parents = (lParent != null ? lParent : '').split(';');
                for(String parent : parents){
                    parent = parent.replace(' ', '');
                    mParentSection.put(parent, script.WelcomeCall_Section__c);
                    ScriptObj existsObj = mScript.get(mNametoSection.get(parent));
                    // set next
                    if(existsObj != null){
                        for(Map<String, ScriptObj.Direction> mapDr : existsObj.getMultiContentAnswer().values()){
                            if(mapDr != null){
                                ScriptObj.Direction dr = mapDr.get(parent);
                                if(dr != null){
                                    dr.next = mNametoSection.get(script.name);
                                    if(dr.fgIsExist || dr.contentAnswer == null || dr.contentAnswer ==''){
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
                    system.debug('ELVI 10 nih');
                } else {
                    sObj.contentCount = sObj.contentCount + 1;
                    system.debug('ELVI 11 nih');
                }
                
                ResponseScript rs = mapOfExistingResponse.get(script.WelcomeCall_Section__c);
                ScriptObj.Direction dr = new ScriptObj.Direction(script);
                
                if(!String.isBlank(script.WelcomeCall_ImageAnswer_c__c)){
                    Document doc = mapDocImage.get(script.WelcomeCall_ImageAnswer_c__c);
                    if(doc != null){
                        dr.imageResourceAnswer = doc.Id;
                    }
                }
                if(!String.isBlank(script.WelcomeCall_ImageContent_c__c)){
                    String[] imgaeContent = script.WelcomeCall_ImageContent_c__c.split(';');
                    for(String img : imgaeContent){
                        if(img != null){
                            Document doc = mapDocImage.get(img.deleteWhitespace());
                            if(doc != null){
                                sObj.imageResourceContent.add(doc.Id);
                                dr.imageResourceContent.add(doc.Id);
                            }
                        }
                    }
                }
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
                                                               sObj.defaultFgNote = dr.fgNote; 
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
    public static List<Survey_Response__c> SaveorUpdateScript(String mapOfScript, String tab){
        Map<String, ResponseScript> rss = (Map<String, ResponseScript>) JSON.deserialize(mapOfScript, Map<String,ResponseScript>.class);
        List<Survey_Response__c> responses = new List<Survey_Response__c>();
        String result;
        String callLineId;
        String kepuasan;
        String ekspetasi;
        for(String str : rss.keySet()){
            System.debug('str==> '+str);
            Survey_Response__c response = new Survey_Response__c();
            ResponseScript res = (ResponseScript) rss.get(str);
            if(res != null && res.isValid != null && res.isValid){
                callLineId = res.callLineId;
                System.debug('res.section==> '+res.section);
                System.debug('res.answer1==> '+res.answer1);
                if(res.section == 'Kepuasan Pelanggan'){
                    if(res.answer1 != null && res.answer1 != ''){
                        kepuasan = res.answer1;   
                    }
                } else if(res.section == 'Ekspetasi Pelanggan'){
                    
                    System.debug('res.answer1==> '+res.answer1);
                    if(res.answer1 != null && res.answer1 != ''){
                        ekspetasi = res.answer1;   
                    }
                }
                
                System.debug('res==> '+res);
            System.debug('str==> '+str);
            System.debug('res.callLineId==> '+res.callLineId);
                
                List<SurveyTaker__c> svTaker = [Select id, welcomecall_callline__c from SurveyTaker__c 
                                                where WelcomeCall_CallLine__c =: res.callLineId];
                List<SurveyTaker__c> svTaker2 = [Select id, Call_Line_Survey__c from SurveyTaker__c 
                                                where Call_Line_Survey__c =: res.callLineId];
                 
                
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
                     System.debug('svTaker.size()==> '+svTaker.size());
                    System.debug('svTaker2.size()==> '+svTaker2.size());
                    if (svTaker.size() > 0){
                        response.SurveyTaker__c = svTaker.get(0).Id;
                        response.WelcomeCall_Call_Line__c = svTaker.get(0).welcomecall_callline__c;
                    } else if (svTaker2.size() > 0) {
                        response.SurveyTaker__c = svTaker2.get(0).Id;
                        response.WelcomeCall_Call_Line__c = svTaker2.get(0).Call_Line_Survey__c;
                    } else {
                        response.SurveyTaker__c = '';
                        response.WelcomeCall_Call_Line__c = '';
                    }
                    //response.SurveyTaker__c = svTaker.get(0).Id;
                    //response.WelcomeCall_Call_Line__c = svTaker.get(0).welcomecall_callline__c;
                    /*if (svTaker.get(0).welcomecall_callline__c != null) { 
                    	response.WelcomeCall_Call_Line__c = svTaker.get(0).welcomecall_callline__c;
                    } else {
                        response.WelcomeCall_Call_Line__c = svTaker.get(0).Call_Line_Survey__c; 
                    } */
                }
                
                responses.add(response);
            }
        }
        if(callLineId != null && callLineId != ''){
            Call_line__c cl =[Select id,name, owner.name, welcomecall_attempt__c, welcomecall_call_line_status__c, Contact__c, 
                              Activity_Result__c, Verification__c, WelcomeCall_First_Call_Date__c, WelcomeCall_Customer_Expectation__c, WelcomeCall_Customer_Satisfaction__c
                              from call_line__c
                              where id =: callLineId];
            String convertEkspetasi='';
            if (ekspetasi != null && ekspetasi != ''){
                if (ekspetasi == 'Analisa kondisi keuangan kurang tajam'){
                    convertEkspetasi = 'Analisa Kebutuhan';
                } else if (ekspetasi == 'Pemahaman fitur produk perlu diperdalam'){
                    convertEkspetasi = 'Pemahaman fitur/produk';
                } else if (ekspetasi == 'Kejelasan komunikasi kurang baik'){
                    convertEkspetasi = 'Transparansi Komunikasi';
                } else if (ekspetasi == 'Rekomendasi produk kurang sesuai kebutuhan'){
                    convertEkspetasi = 'Rekomendasi produk/solusi';
                } else if (ekspetasi == 'Tidak ada/sudah baik'){
                    convertEkspetasi = 'Tidak ada/sudah baik';
                } else if (ekspetasi == 'Lain-lain'){
                    convertEkspetasi = 'Lain-lain';
                }
            }
            String convertKepuasan='';
            System.debug('ekspetasi==> '+ekspetasi);
            
            System.debug('kepuasan==> '+kepuasan);
            
            if(kepuasan != null && kepuasan != ''){
                if (kepuasan == 'Sangat Tidak Puas'){
                    convertKepuasan='1';
                } else if (kepuasan == 'Tidak Puas'){
                    convertKepuasan='2';
                } else if (kepuasan == 'Biasa Saja'){
                    convertKepuasan='3';
                } else if (kepuasan == 'Puas'){
                    convertKepuasan='4';
                } else if (kepuasan == 'Sangat Puas'){
                    convertKepuasan='5';
                } else if (kepuasan == 'No Score'){
                    convertKepuasan='No Score';
                }
                cl.WelcomeCall_Customer_Satisfaction__c = convertKepuasan;
            }
            if(ekspetasi != null && ekspetasi != ''){
                cl.WelcomeCall_Customer_Expectation__c	= ekspetasi;
            }
            update cl;
            
            //deleting response by tab and call line
            wcu.deleteResponseByTabCLId(tab, callLineId);
        }
        if(!responses.isEmpty()){
            CallLineTriggerControl.skipResponseTrigger = true;
            upsert(responses);
            result = JSON.serialize(responses);
        }
        return responses;
    }
    
}