global class SchCMUReminderNotification implements Schedulable{
    
    private static final String CMU_CASE_EMAIL = '[CMU_CASE_EMAIL]';
    
    global void execute(SchedulableContext ctx){
        
        String strQueryCase = '';
        List<Case> listCase = new List<Case>();
        
        
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http h = new Http(); 
        
        String url;
        String url1;
        String url2;
        String url3;
        
        String sms;
        String emailText;
        
        if (Test.isRunningTest()) {
            strQueryCase = Label.query_schCMUReminderNotification;
        }else{
            strQueryCase = Label.query_schCMUReminderNotification;
        }
        System.debug('SchCMUReminderNotification QUERY: '+strQueryCase);
        
        listCase = Database.query(strQueryCase);
        
        ICF_Parameter__c icfES = [SELECT id, ICF_Email_Template__c, ICF_SMS_Template__c, 
                                  User_ID__c, Password__c, Division__c, Sender__c, Batchname__c, Uploadby__c, Channel__c, 
                                  Login_1__c, API_Key_1__c, Login_2__c, API_Key_2__c, Description__c,
                                  ICF_Method__c, Entity__c, ICF_Email_Template__r.Email_Body__c,ICF_SMS_Template__r.Email_Body__c,
                                  ICF_Email_Template__r.Email_Header__c,ICF_Email_Template__r.Email_Footer__c,ICF_Email_Template__r.subject__c,ICF_SMS_Template__r.Subject__c   
                                  FROM ICF_Parameter__c WHERE Record_Type_Name__c = 'Master_CMU' and Entity__c = 'AMFS' 
                                  and ICF_Email_Template__r.Subject__c='Reminder Case Complaint' and ICF_SMS_Template__r.Subject__c='Reminder Case Complaint'];
        
        
        for(Case CMUCase: listCase){
            Date RequestDate = Date.Today();   
            
            // insert Email_SMS_Log__c
            System.debug('CMUCaseNotificationTrigger: INSERT LOG TO ES LOG INSERT');
            Email_SMS_Log__c ESLog = new Email_SMS_Log__c();
            // Information
            ESLog.Status__c = 'Draft';
            ESLog.Template_Email__c = icfES.ICF_Email_Template__c;
            ESLog.Template_SMS__c = icfES.ICF_SMS_Template__c;
            SYSTEM.debug('CMUCaseNotificationTrigger TEMPLATE EMAIL FROM ICFES INSERT : '+icfES.ICF_Email_Template__r.Email_Body__c+' , TEMPLATE SMS: '+icfES.ICF_SMS_Template__r.Email_Body__c);
            SYSTEM.debug('CMUCaseNotificationTrigger TEMPLATE EMAIL FROM ESLOG INSERT : '+ESLog.Template_Email__r.Email_Body__c+' , TEMPLATE SMS: '+ESLog.Template_SMS__r.Email_Body__c);
            SYSTEM.debug('CMUCaseNotificationTrigger TEMPLATE EMAIL FROM ICFES 2 INSERT: '+icfES.ICF_Email_Template__c+' , TEMPLATE SMS: '+icfES.ICF_SMS_Template__c);
            ESLog.Entity__c = icfES.Entity__c;
            
            ESLog.Contact__c = CMUCase.ContactId;
            
            ESLog.Category__c = 'Reminder CMU';
            ESLog.Email__c = CMUCase.ContactEmail!=null?CMUCase.ContactEmail:null;
            ESLog.Mobile__c = CMUCase.ContactMobile!=null?CMUCase.ContactMobile:null;
            
            String phone = ESLog.Mobile__c;
            
            SYSTEM.debug('CMUCaseNotificationTrigger: EMAIL: '+CMUCase.ContactEmail+', MOBILE: '+CMUCase.ContactMobile+', ENTITY: '+CMUCase.Entity__c+', PARENT CASE: '+CMUCase.ParentId+'  INSERT');
            
            
            if(CMUCase.Entity__c=='AMFS' && (CMUCase.ParentId == null || CMUCase.Appeal__c.contains('^1Yes')) ){
                //replace createddate
                DateTime currentDate = CMUCase.createddate;
                String createddate = 'tes_'+currentDate;
                
                String strdt;
                
                List<String> strArr1 = createddate.split('_');
                List<String> strArr2 = new List<String>();
                String strDate;
                
                strdt = strArr1[1];    
                
                for(String s1: strArr1){
                    if(s1.contains('/')){
                        strArr2 = s1.split('/');
                        
                    }
                    
                }
                
                String val1;
                String val2;
                String val3;
                
                val1= strArr2[1];
                val2 = strArr2[0];
                val3 = strArr2[2];
                List<String> strVal3 = val3.split(' ');
                val3= strVal3[0];
                
                currentDate = DateTime.newInstance(Integer.valueOf(val3),Integer.valueOf(val2),Integer.valueOf(val1));
                strDate = currentDate.format('dd MMM yyyy');
                
                
                if(CMUCase.ContactMobile != null){
                    ESLog.Method__c='SMS';
                    emailText = icfES.ICF_SMS_Template__r.email_body__c;
                    emailText= emailText.replace('[CREATED_DATE]',strDate); 
                    emailText= emailText.replace('[CASE_NO]', CMUCase.CaseNumber);
                    emailText = emailtext.replace('[POLICY_NO]',CMUCase.policy_numbers__c);
                    System.debug('CMUCaseNotificationTrigger SMS: '+emailText+', METHOD: '+ESLog.Method__c+' INSERT');
                    
                    System.debug('SchCMUReminderNotification inquiry email subject: '+icfES.ICF_Email_Template__r.subject__c);
                    System.debug('SchCMUReminderNotification inquiry sms subject: '+icfES.ICF_Email_Template__r.subject__c);
                    
                    System.debug('SchCMUReminderNotification inquiry mobile number: '+CMUCase.ContactMobile+', email: '+CMUCase.ContactEmail);
                    System.debug('SchCMUReminderNotification inquiry from icf parameter email subject: '+icfES.ICF_Email_Template__r.subject__c+', sms subject: '+icfES.ICF_SMS_Template__r.subject__c);
                    
                    System.debug('SchCMUReminderNotification mobile phone');
                    //replace createddate
                    
                    System.debug('SchCMUReminderNotification subject: '+ESLog.Template_SMS__r.subject__c+', body: '+ESLog.Template_SMS__r.Email_Body__c);
                    
                    System.debug('SchCMUReminderNotification body:'+ESLog.Email_Text__c);
                    
                    if(CMUCase.Customer_type__c == 'Priority Banking Customer'){
                        emailText = emailtext.replace(CMU_CASE_EMAIL,Label.CMU_Case_Email_Priority_Customer);
                    }else{
                        emailText = emailtext.replace(CMU_CASE_EMAIL,Label.CMU_Case_Email_Regular_Customer);
                    }
                    
                    System.debug('SchCMUReminderNotification emailText: '+emailText);
                    
                    sms = EncodingUtil.urlEncode(emailText, 'UTF-8');
                    System.debug('[?][username / pass] = '+ icfES.user_id__c +'/'+icfES.password__c);
                    
                    // checking format
                    String defaultFormat = Label.Jatis_Phone_Prefix_Default;
                    List<String> otherFormatList = (Label.Phone_Others_Prefix).split(';');
                    String phoneCurrentFormat = phone.substring(0, defaultFormat.length());
                    
                    if (!phoneCurrentFormat.equals(defaultFormat)) {
                        for (String phoneFormat : otherFormatList) {
                            phoneCurrentFormat = phone.substring(0, phoneFormat.length());
                            if (phoneCurrentFormat.equals(phoneFormat)) {
                                phone = defaultFormat + phone.substring(phoneFormat.length()); 
                                system.debug(LoggingLevel.DEBUG, 'Phone number after formating:' + phone);
                            }
                        }
                    }
                    
                    String phonenumber = phone;
                    
                    url1 = Label.JATIS_SMS_Endpoint + '?userid='+icfES.user_id__c+'&password='+icfES.password__c+'&msisdn='+phonenumber+'&message='+sms;
                    url2 = '&sender='+icfES.sender__c+'&division='+EncodingUtil.urlEncode(icfES.division__c, 'UTF-8')+'&batchname='+EncodingUtil.urlEncode(icfES.batchname__c, 'UTF-8');
                    url3 = '&uploadby='+EncodingUtil.urlEncode(icfES.uploadby__c, 'UTF-8')+'&channel='+EncodingUtil.urlEncode(icfES.channel__c, 'UTF-8')+' ';
                    url = url1 + url2 + url3;
                    
                    // buat class untuk panggil jatis pake url
                    
                    System.debug('JATIS URL: '+url);
                    if(Test.isRunningTest()!=true)
                        JatisBatchWorker.call(url+'_'+strDate);
                    
                    // validasi resp body not null
                    
                }
                else {
                    ESLog.Method__c='EMAIL';
                    emailText = icfES.ICF_Email_Template__r.email_body__c+icfES.ICF_Email_Template__r.email_footer__c;
                    SYSTEM.debug('CREATEDDATE: '+strDate);
                    emailText= emailText.replace('[CREATED_DATE]',strDate); 
                    emailText= emailText.replace('[CASE_NO]', CMUCase.CaseNumber);
                    emailText = emailtext.replace('[POLICY_NO]',CMUCase.policy_numbers__c);
                    if(CMUCase.Customer_type__c == 'Priority Banking Customer'){
                        emailText = emailtext.replace(CMU_CASE_EMAIL,Label.CMU_Case_Email_Priority_Customer);
                    }else{
                        emailText = emailtext.replace(CMU_CASE_EMAIL,Label.CMU_Case_Email_Regular_Customer);
                    }
                    
                    System.debug('CMUCaseNotificationTrigger EMAIL: '+emailText+', METHOD: '+ESLog.Method__c);
                    
                    System.debug('SchCMUReminderNotification email');
                    
                    System.debug('SchCMUReminderNotification email subject: '+icfES.ICF_Email_Template__r.subject__c+', body: '+icfES.ICF_Email_Template__r.Email_Body__c+', footer: '+icfES.ICF_Email_Template__r.Email_Footer__c);
                    
                    EmailSenderUtil.sendEmail(CMUCase.ContactEmail, emailText, icfES.ICF_Email_Template__r.Subject__c);
                    
                }
                Date caseDT = Date.newInstance(Integer.valueOf(val3),Integer.valueOf(val2),Integer.valueOf(val1));
                System.debug('FORMAT: '+caseDT);
                
                ESLog.Request_Date__c = caseDT;
                ESLog.Start_Date__c = ESLog.Request_Date__c;
                
                // tambahin field ready to send  = true
                ESLog.Ready_To_Send__c = true;
                ESLog.Case__c = CMUCase.id;
                
                ESLog.Email_Text__c = emailText;
                
                
                insert ESLog;
                system.debug('ESLog: '+ESLog);
            }
        }
        
        
        
    }
}