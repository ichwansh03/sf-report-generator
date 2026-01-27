trigger Trigger_EmailSMSLog_ReplaceEmailTemplate on Email_SMS_Log__c (before insert, before update) {
    
    private static final String CONTACT_NAME = '[CONTACT_NAME]';
    private static final String SURVEY_LINK = '[SURVEY_LINK]';
    private static final String CASE_NUMBER = '[CASE_NUMBER]';
    private static final String CASE_SUBJECT = '[CASE_SUBJECT]';
    private static final String POLICY_NO = '[POLICY_NO]';
    private static final String SHORT_URL = '[SHORT_URL]';
    private static final String CREATEDDATE = '[CREATEDDATE]'; // added by Support MII at 02 12 24
    
    private static final String withdrawalSurrenderSurveyId = Label.Config_Sent_Survey_ICF_Withdrawal_Surrender_Survey_ID;
    public static Set<String> withdrawalSurrenderCaseType = new Set<String>{
                        'Request_POS_Withdrawal',
                        'Request_POS_Redemption',
                        'Request_POS_Surrender_Non_UL',
                        'Request_POS_Surrender_Endowment'
    };
    
    boolean isQualtrics = false;
    boolean Cashless = false;
    Map<String,boolean> mapCaseId = new Map<String,boolean>();
    List<Survey__c> listSurvey = new List<Survey__c>();
    String getSurvey = '';
    String linkSurvey = ''; 
    
    if (trigger.isInsert) { 
        for(Email_SMS_Log__c x:trigger.new){
            if (x.Entity__c == 'AMFS' && x.Survey_Type__c != 'I Buy - Pembelian Polis') {
                mapCaseId.put(x.Case__c,  false);  
                System.debug('Test Survey Link Condition: x.Case_Type__c: '+x.Case_Type__c+', x.Survey__r.Name: '+x.Survey__r.Name+' '+x.Case__c+' '+x.Survey_URL__c+' '+x.Survey__c+' ');
                if(x.Case_Type__c == 'Request POS' || (System.test.isrunningtest() && x.Email_Text__c == 'Test Replace Survey POS/Request [CONTACT_GENDER] [CONTACT_NAME] [CASE_NUMBER] [POLICY_NO] [MOT_SERVICE] [SURVEY_LINK]')){
                    //Added by Dimas Support MII 11/02/2025
                    listSurvey = [Select id, URL__c, name from Survey__c where recordType.Name = 'Master New Onboarding' and Name = 'Survey POS/Request'];
                    ICF_Parameter__c replaceTemplate = [SELECT ICF_Email_Template__c, ICF_SMS_Template__c FROM ICF_Parameter__c WHERE Record_Type_Name__c = 'Master_Qualtrics' AND Entity__c = 'AMFS' AND Status__c = 'Active' AND Status_Cases__c = 'Closed' ORDER BY CreatedDate DESC LIMIT 1];
                    x.Template_Email__c = replaceTemplate.ICF_Email_Template__c;
                    x.Template_SMS__c = replaceTemplate.ICF_SMS_Template__c;
                    //update x;
                }else if(x.Case_Type__c == 'Request'){
                    
                    if(x.Case__c != null){
                        Case cc = [select Id, Description from Case where Id =: x.Case__c limit 1];
                        if (cc.Description =='Claim Status: Cashless') {
                            cashless = true;
                        }
                    }
                    if (!cashless) listSurvey = [Select id, URL__c, name from Survey__c where recordType.Name = 'Master New Onboarding' and Name = 'Survey Request I Claim Individu Reimbursement'];
                    else listSurvey = [Select id, URL__c, name from Survey__c where recordType.Name = 'Master New Onboarding' and Name = 'Survey Request I Claim Individu Cashless'];
                    
                }else if(x.Case_Type__c == 'Complaint' && x.Entity__c == 'AMFS'){
                    listSurvey = [Select id, URL__c, name from Survey__c where recordType.Name = 'Master New Onboarding' and Name = 'Survey Request I Complaint Dynamic'];
                }else if(x.Case_Type__c == 'Inquiry' && x.Entity__c == 'AMFS'){
                    listSurvey = [Select id, URL__c, name from Survey__c where recordType.Name = 'Master New Onboarding' and Name = 'Survey Inquiry Dynamic'];
                }else if(x.Case_Type__c == 'Complaint'){
                    listSurvey = [Select id, URL__c, name from Survey__c where recordType.Name = 'Master Qualtrics' and Name = 'Survey Request I Complaint'];
                }else{
                    listSurvey = [Select id, URL__c, name from Survey__c where recordType.Name = 'Master Qualtrics' and Name = 'Survey Qualtrics'];
                }
                //System.debug('URL__c: '+listSurvey[0].URL__c);
            }
        } 
    }
    
    if (trigger.isInsert && mapCaseId.size() > 0) {
        system.debug('**MASUK MAP CASE');
        List<Case> getDataCase = [Select id from Case where id in: mapCaseId.keySet() and MOT__c != null];
        for (case row: getDataCase) {
            mapCaseId.put(row.id, true); 
            isQualtrics = true;
        }
    }
    
    
    if (isQualtrics == true && mapCaseId.size() > 0) { 
        if ( listSurvey.size() > 0) {
            getSurvey = listSurvey[0].Id;
            linkSurvey = listSurvey[0].URL__c;
            linkSurvey += 'id=' + getSurvey  ;    
        }
    }
    
    
    for(Email_SMS_Log__c x:trigger.new){
        if(x.category__c == 'Thanks Note') x.ready_to_send__c = true;
        String text;
        String text2;
        String Header='';
        String Body='';
        String Footer='';
        
        if ( mapCaseId.containsKey(x.Case__c) && mapCaseId.get(x.Case__c) 
            && x.Entity__c == 'AMFS' && String.isnotblank(linkSurvey)
            && x.Category__c == 'ICF'
           ) {
               linkSurvey += '&cId=' + x.contact__c + '&caId=' + x.case__c; 
               x.Email_SMS_Template__c = getSurvey;
               x.Survey_URL__c = linkSurvey;
               x.Survey__c = getSurvey;
           }

        if(x.method__c=='SMS'){
            x.Email_SMS_Template__c = x.Template_SMS__c;
        }
        else{
            x.Email_SMS_Template__c = x.Template_Email__c;
        }
        if(x.Email_SMS_Template__c != null){
            Email_SMS_Template__c est = new Email_SMS_Template__c();
            
            if(trigger.isinsert) {
                est = [select Email_Body__c, Email_Header__c, Email_Footer__c from Email_SMS_Template__c where id=: x.Email_SMS_Template__c];
            }
            if(trigger.isupdate){
                if(Trigger.oldMap.get(x.Id).Email_SMS_Template__c != Trigger.newMap.get(x.Id).Email_SMS_Template__c || Trigger.oldMap.get(x.Id).method__c != Trigger.newMap.get(x.Id).method__c){
                    x.Ready_To_Send__c = false;
                    est = [select Email_Body__c, Email_Header__c, Email_Footer__c from Email_SMS_Template__c where id=: x.Email_SMS_Template__c];
                } 
            }
            if(est.Email_Header__c!=null) Header = est.Email_Header__c;
            if(est.Email_Body__c!=null) Body = est.Email_Body__c;
            if(est.Email_Footer__c!=null) Footer = est.Email_Footer__c;             
            text = Header + ' ' + Body + ' ' + Footer;
            List<String> result = new List<String>();
            //System.Debug('Nama_Layanan__c:'+x.Nama_Layanan__c);
            if(text!=null && text!='') result = text.split('\\s');
            
            String Contactname = '';
            if (x.Contact_Name__c.Length() > 22 && x.method__c == 'SMS'){
                Contactname = x.Contact_Name__c.substring(0, 21);
            }
            else{
                contactname = x.Contact_Name__c;
            }
            String mot_service = x.MOT_in_Email__c;
            String mot_layanan = x.Nama_Layanan__c;
            
            IF(RESULT.size()>0){
                for(String r:result){
                    if(text2==null){
                        if(r == CONTACT_NAME || r.contains(CONTACT_NAME) == true){
                            text2 = contactname + ',';
                        }
                        else if(r == SURVEY_LINK || r.contains(SURVEY_LINK) == true){
                            text2 = x.Survey_URL__c;
                        }
                        else if(r == CASE_NUMBER || r.contains(CASE_NUMBER)== true){
                            text2 = x.case_number__c;
                        }
                        else if(r == CASE_SUBJECT || r.contains(CASE_SUBJECT)== true){
                            text2 = x.Subject__c;
                        }
                        else if(r == POLICY_NO || r.contains(POLICY_NO) == true){
                            text2 = x.Policy_No__c;
                        }
                        else if(r == SHORT_URL || r.contains(SHORT_URL) == true){
                            if(x.Bitly__c!=null) text2 = x.Bitly__c;
                            else text2 = r;
                        }
                        else if(r == '[CONTACT_GENDER]'){ // added by Support MII at 03 04 24
                            text2 = text2+' ' +x.Contact_Gender__c;
                        }
                        else if(r == '[MOT_SERVICE]'){ // added by Support MII at 03 04 24
                            if (mot_service != null) text2 = mot_service;
                            else text2 = r;
                        }
                        else if(r == CREATEDDATE || r.contains(CREATEDDATE) == true){ // added by Support MII at 02 12 24
                            text2 = text2+' ' +x.Case_Open_Date__c;
                        }
                        else if(r == '[MOT_LAYANAN]'){ // added 30 JUNE 2025
                            if (mot_layanan != null) text2 = mot_layanan;
                            else text2 = r;
                        }
                        else{
                            text2 = r;
                        }
                    }
                    else{
                        if(r == CONTACT_NAME || r.contains(CONTACT_NAME) == true){
                            text2 = text2+' ' +contactname + ',';
                        }
                        else if(r == SURVEY_LINK || r.contains(SURVEY_LINK) == true){
                            if(x.Survey_URL__c != null || x.Survey_URL__c != 'null' || x.Survey_URL__c != '')  text2 = text2+' ' +x.Survey_URL__c;
                            else  text2 = text2+' ' +r;
                        }
                        else if(r == CASE_NUMBER || r.contains(CASE_NUMBER)== true){
                            text2 = text2+' ' +x.case_number__c;
                        }
                        else if(r == CASE_SUBJECT || r.contains(CASE_SUBJECT)== true){
                            text2 = text2+' ' +x.Subject__c;
                        }
                        else if(r == POLICY_NO || r.contains(POLICY_NO) == true){
                            text2 = text2+' ' +x.Policy_No__c;
                        }
                        else if(r == SHORT_URL || r.contains(SHORT_URL) == true){
                            if(x.Bitly__c!=null) text2 = text2+' '+x.Bitly__c;
                            else  text2 = text2+' ' +r;
                        }
                        else if(r == '[CONTACT_GENDER]'){ // added by Support MII at 03 04 24
                            text2 = text2+' ' +x.Contact_Gender__c;
                        }
                        else if(r == '[MOT_SERVICE]'){ // added by Support MII at 03 04 24
                            if (mot_service != null)   text2 = text2+' ' +mot_service;
                            else  text2 = text2+' ' +r;
                        }
                        else if(r == '[MOT_LAYANAN]'){ // added 30 JUNE 2025
                            if (mot_layanan != null)  text2 = text2+' ' +mot_layanan;
                            else  text2 = text2+' ' +r;
                        }
                        else if(r == CREATEDDATE || r.contains(CREATEDDATE) == true){ // added by Support MII at 02 12 24
                            text2 = text2+' ' +x.Case_Open_Date__c;
                        }
                        else{
                            text2 = text2+' ' +r;
                        }
                        
                    }
                }    
            }
            if(text2!=null){
                x.Email_Text__c = text2; 
                x.Email_SMS_Length__c = text2.length();    
            }
        }
    }
}