public class JatisBatchWorker {
    
    @future(callout=true)
    public static void call(String url){
        System.debug('JATIS URL: '+url);
        
        String statusJatis;
        String messageIdJatis;
        String description;
        
        List<Email_SMS_Log__c> listESLog = [select id, Case_Number__c,status__c,Template_Email__c,Template_SMS__c,Template_Email__r.subject__c,Template_Email__r.email_body__c,Template_Email__r.email_footer__c,Template_SMS__r.subject__c,Template_SMS__r.email_body__c,entity__c,Contact__c,Category__c,Email__c,Mobile__c,Method__c,Email_Text__c,Request_Date__c,Start_Date__c,Ready_To_Send__c,Status_JATIS__c, MessageId_JATIS__c,Description_Status_JATIS__c,format(createddate), format(lastmodifieddate),policy_number__c,send_admin_flag__c from Email_SMS_Log__c where Policy_Number__c!=null and createddate=N_DAYS_AGO:10 and category__c='Reminder CMU' and case_number__c != null and entity__c='AMFS' order by createddate desc ];
        
        List<String> splittext=new List<String>();
        List<String> splittext2=new List<String>();
        List<String> splittext3=new List<String>();
        Integer i = 0;
        Integer j = 0;
        
        String emailText;
        Integer total=0;
        
        
        Date MyDate = Date.Today(); //+ 7;
        
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http h = new Http(); 
        
        
        List<String> strArr1 = new List<String>();
        List<String> strArr2 = new List<String>();
        String strDate;
        String strdt;
        
        System.debug('url: '+url);
        if(url.contains(' _')){
            strArr1 = url.split(' _');
        }
        
        req.setEndpoint(strArr1[0]);
        req.setMethod('GET');
        // tes layering notif 
        //req.setCompressed(TRUE);
        req.setTimeout(120000);
        
        if(!Test.isRunningTest()) {
            try{
                res = h.send(req);
            }catch(Exception ex){
                System.debug('EXCEPTION WHILE SEND SMS: '+ex.getMessage());
            }
        } else {
            res.setBody('Status=1&MessageId=VT3JNT3DSDSmnICt8sFnACQc');
        }
        
        for(Email_SMS_Log__c ES: listESLog){
            if (res.getBody() != null
               ) {
                   String responseBody = res.getBody();
                   splittext = responseBody.split('&');
                   if(splittext.size()>1){
                       splittext2 = splittext[0].split('=');
                       splittext3 = splittext[1].split('=');
                       if(splittext2.size()>0){
                           i = splittext2.size() - 1;
                           System.debug(LoggingLevel.DEBUG,'**status**'+splittext2[i]);
                           if(splittext2[i].length()>=255){
                               description = splittext2[i];
                           }else{
                               statusJatis = splittext2[i];
                               ES.status_jatis__c= statusJatis;
                           }
                           SYSTEM.debug('JATIS RESPONSE SPLITTEXT SIZE > 1: '+splittext);
                           SYSTEM.debug('JATIS RESPONSE SPLITTEXT SIZE > 1: '+splittext2);
                           SYSTEM.debug('JATIS RESPONSE SPLITTEXT SIZE > 1: '+splittext3);
                       }
                       if(splittext3.size()>0){
                           j = splittext3.size() - 1;
                           System.debug(LoggingLevel.DEBUG,'**messageid**'+splittext3[j]);
                           messageIdJatis = splittext3[j];
                           ES.messageid_jatis__C= messageIdJatis;
                       }
                   }
                   else{
                       splittext2 = splittext[0].split('=');
                       if(splittext2.size()>0){
                           i = splittext2.size() - 1;
                           System.debug(LoggingLevel.DEBUG,'**status**'+splittext2[i]);
                           if(splittext2[i].length()>=255){
                               description = splittext2[i];
                           }else{
                               statusJatis = splittext2[i];
                               ES.status_jatis__c= statusJatis;
                           }
                           SYSTEM.debug('JATIS RESPONSE SPLITTEXT SIZE == 1: '+splittext);
                           SYSTEM.debug('JATIS RESPONSE SPLITTEXT SIZE == 1: '+splittext2);
                       }
                       
                       
                       
                   }
                   
                   
               }
            
            //replace createddate
            
            DateTime currentDate;
            
            System.debug('JatisBatchWorker: '+currentDate);
            
            strDate = strArr1[1];    
            
            if(statusJatis == null && messageIdJatis == null || Test.isRunningTest()){
                // 20 Feb20, Add Status "Failed"
                System.debug('JATIS BATCH FAILED STATE');
                ES.End_Date__c = MyDate;
                ES.Status__c='Failed';
                
                System.debug('JATIS BATCH INSERT INTO CMU_Failed_Send_SMS_Notification__c ');
                
                System.debug('SchCMUReminderNotification email');
                
                System.debug('SchCMUReminderNotification email subject: '+ES.Template_Email__r.subject__c+', body: '+ES.Template_Email__r.Email_Body__c+', footer: '+ES.Template_Email__r.Email_Footer__c);
                System.debug('SchCMUReminderNotification email sender: '+ES.Email__c);
                
                emailText = ES.Template_Email__r.Email_Body__c+ES.Template_Email__r.Email_Footer__c;
                
                emailText= emailText.replace('[CREATED_DATE]',strDate); 
                System.debug('JatisBatchWorker: CASE NUMBER : '+ES.Case_Number__c);
                emailText= emailText.replace('[CASE_NO]', ES.Case_Number__c);
                emailText = emailText.replace('[POLICY_NO]',ES.Policy_Number__c);
                EmailSenderUtil.sendEmail(ES.Email__c, emailText, ES.Template_Email__r.Subject__c);
                
                total++;
            } 
            
        }
        
        
    }
    
    
    
    
}