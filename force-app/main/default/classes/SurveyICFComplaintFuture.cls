global class SurveyICFComplaintFuture {
    public static String configSendLogApprove = System.Label.Config_Sent_Survey_ICF_Complaint_Approve;  
    public static String configSendLogReject = System.Label.Config_Sent_Survey_ICF_Complaint_Reject;  
    public static Boolean configSendLogBoolApprove = Boolean.valueof(configSendLogApprove);
    public static Boolean configSendLogBoolReject = Boolean.valueof(configSendLogReject);
    @future(callout=true)
    public static void checkSurveyICF(Set<Id> emailLogs) {  
        for (string emailLogId: emailLogs) {
            DescribeSObjectResult describeResult = Email_SMS_Log__c.getSObjectType().getDescribe();
            List<String> fieldList = new List<String>(describeResult.fields.getMap().keySet());
            String fieldStr = String.join(fieldList, ',');
            String query = ' SELECT ' + fieldStr + ', case__r.Case_Type_Config__c, case__r.Case_type__c, case__r.MOT__c, case__r.entity__c, case__r.Follow_Up_ICF__c, contact__r.MobilePhone, case__r.Subject, case__r.CHS_Status__c, case__r.Complaint_Decision_AMFS__c FROM Email_SMS_Log__c WHERE Id = :emailLogId ';
            
            Email_SMS_Log__c log = Database.query(query); 
            string infoDescription = '';
            String contactIds = log.Contact__c;  
            String mot = log.MOT__c;   
            String typeCase = log.case__r.Case_type__c;
            Boolean haveComplaint = false;
            Boolean sendData = false;
            Boolean isSuccess = false;
            
            //system.debug('contactIds:'+contactIds);
            //system.debug('mot:'+mot);
            //system.debug('typeCase:'+typeCase);
            
            if (System.Test.isRunningTest()) configSendLogBoolApprove = true;
            if (System.Test.isRunningTest()) configSendLogBoolReject = true;
            if (String.isnotblank(contactIds) && string.isnotblank(mot)) {
                List<Case> c = [select id, MOT__c from case where id=: log.Case__c limit 1];
                List<Case> checkListComplaint = new List<Case>();
                //check open complaint case
                checkListComplaint = [select id from Case where contactid =: contactIds and entity__c = 'AMFS' 
                                      and Type = 'Complaint' and id !=: log.Case__c and Status != 'Closed'
                                      order by Createddate limit 1];
                if(checkListComplaint.size()>0) haveComplaint = true;
                
                Contact checkFreezeContact = [Select Survey_Complaint_Send_Counter__c,Survey_Complaint_Send_Date__c,
                                          Email_Sms_Log_Complaint__c,Email_Sms_Log_Complaint__r.Case__c from contact where id =: contactIds limit 1]; 
                                
                if (haveComplaint) { 
                    log.Status__c = 'Cancel';
                    log.Exclude_From__c = 'Have Open Complaint Case';
                    log.Description__c = 'Have Open Complaint Case';
                    log.Send_Flag__c = false;
                }
                else{
                    String getSurvey = '';
                    String linkSurvey = '';
                    OrgWideEmailAddress owea = [SELECT Id, Address, DisplayName FROM OrgWideEmailAddress WHERE Address = :Label.EmailNoReplayAMFS limit 1];
                    
                    map<string, string> mapEmailTemplate = new map<string, string>();  
                    mapEmailTemplate.put(log.Email_SMS_Template__c, ''); 
                    
                    List<Email_SMS_Template__c> subjectEmail = [SELECT Id, Subject__c FROM Email_SMS_Template__c WHERE name = 'ICF Email (AMFS) 2024'];
                    for(Email_SMS_Template__c emailTemplate: subjectEmail){
                        mapEmailTemplate.put(emailTemplate.Id, emailTemplate.Subject__c ); 
                    }
                    
                    Map<String, String> configEIP = new Map<String,String>();
                    configEIP.put(EIPConstant.CS_COM_TARGET, log.Survey_URL__c);
                    configEIP.put(EIPConstant.CS_COM_DELIVER_STATUS,'301');
                    EIPJson response;
                    
                    try{   
                        if (!System.test.isrunningtest()) response = EIPConnector.sendCommunicationMessageT2M('createNewUrl', 'AMFS', 'T2MIO', configEIP);
                        
                        if ((response != null || System.test.isrunningtest()) ) { 
                            String urlshort  = '';
                            
                            if (! System.test.isrunningtest()){
                                urlshort = response.Body.Customer.haveCommunicatedMessage[0].replyTo;
                            } else{
                                urlshort = 'https://axa.t2mio.com/mqBi9sV';
                            }
                            if (urlshort != null && urlshort != ''){
                                if(String.isnotblank(log.Email_Text__c) && log.Email_Text__c.contains('[SHORT_URL]')==true){
                                    log.Email_Text__c = log.Email_Text__c.replace('[SHORT_URL]',urlshort);
                                } 
                                log.bitly__c = urlshort;
                                log.ready_to_send__c = true; 
                                if (string.isnotblank(log.contact__r.MobilePhone )) log.method__c = 'Whatsapp';     
                                
                                isSuccess = true;
                                //Updated by Dimas Support MII 10/04/2025
                                if((log.case__r.CHS_Status__c == 'Closed - Valid' || log.case__r.CHS_Status__c == 'Closed - Invalid') && (log.case__r.Complaint_Decision_AMFS__c == 'Approve & Paid' || log.case__r.Complaint_Decision_AMFS__c == 'Invalid & Paid') && configSendLogBoolApprove == true){
                                    if (string.isnotblank(log.contact__r.MobilePhone )) { 
                                        Set<id> sendWa = new Set<id>();
                                        sendWa.add(log.id);
                                        if (!System.Test.IsRunningTest()){
                                            System.enqueueJob(new SendSurveyICF.sendWhatsapp(sendWa));
                                        }else{
                                            sendMail(log, owea, mapEmailTemplate);   
                                            log.method__c = 'Email';   
                                            sendData = true;
                                        }
                                        sendData = true; 
                                        log.method__c = 'Whatsapp';     
                                    } 
                                    else if (string.isnotblank(log.Email__c)) {
                                        sendMail(log, owea, mapEmailTemplate);   
                                        log.method__c = 'Email';   
                                        sendData = true;
                                    }
                                } else if((log.case__r.CHS_Status__c == 'Closed - Valid' || log.case__r.CHS_Status__c == 'Closed - Invalid') && log.case__r.Complaint_Decision_AMFS__c == 'Invalid & Reject' && configSendLogBoolReject == true){
                                    if (string.isnotblank(log.contact__r.MobilePhone )) { 
                                        Set<id> sendWa = new Set<id>();
                                        sendWa.add(log.id);
                                        if (!System.Test.IsRunningTest()){
                                            System.enqueueJob(new SendSurveyICF.sendWhatsapp(sendWa));
                                        }else{
                                            sendMail(log, owea, mapEmailTemplate);   
                                            log.method__c = 'Email';   
                                            sendData = true;
                                        }
                                        sendData = true; 
                                        log.method__c = 'Whatsapp';     
                                    } 
                                    else if (string.isnotblank(log.Email__c)) {
                                        sendMail(log, owea, mapEmailTemplate);   
                                        log.method__c = 'Email';   
                                        sendData = true;
                                    }
                                }
                                
                            }  
                            
                            log.Description__c = ''; 
                            if ((log.case__r.CHS_Status__c == 'Closed - Valid' || log.case__r.CHS_Status__c == 'Closed - Invalid') && (log.case__r.Complaint_Decision_AMFS__c == 'Approve & Paid' || log.case__r.Complaint_Decision_AMFS__c == 'Invalid & Paid') && configSendLogBoolApprove == true) {
                                if (sendData == true) {
                                    log.Status__c = 'Send'; 
                                    log.Updated_Contact_Flag__c = true;
                                    log.End_Date__c = system.today();
                                    
                                    integer countSendComplain = 1;
                                    Date currDate = system.Today();
                                    
                                    if (checkFreezeContact.Survey_Complaint_Send_Counter__c != null) countSendComplain++;
                                    checkFreezeContact.Survey_Complaint_Send_Counter__c = countSendComplain;
                                    checkFreezeContact.Survey_Complaint_Send_Date__c = currDate; 
                                    checkFreezeContact.Email_Sms_Log_Complaint__c = emailLogId;
                                    update checkFreezeContact;
                                }
                            } else if ((log.case__r.CHS_Status__c == 'Closed - Valid' || log.case__r.CHS_Status__c == 'Closed - Invalid') && log.case__r.Complaint_Decision_AMFS__c == 'Invalid & Reject' && configSendLogBoolReject == true) {
                                if (sendData == true) {
                                    log.Status__c = 'Send'; 
                                    log.Updated_Contact_Flag__c = true;
                                    log.End_Date__c = system.today();
                                    
                                    integer countSendComplain = 1;
                                    Date currDate = system.Today();
                                    
                                    if (checkFreezeContact.Survey_Complaint_Send_Counter__c != null) countSendComplain++;
                                    checkFreezeContact.Survey_Complaint_Send_Counter__c = countSendComplain;
                                    checkFreezeContact.Survey_Complaint_Send_Date__c = currDate; 
                                    checkFreezeContact.Email_Sms_Log_Complaint__c = emailLogId;
                                    update checkFreezeContact;
                                }
                            } else {
                                if(log.Status__c != 'Send') log.Status__c = 'Hold';
                            }
                            
                            log.Description__c  = '';
                            log.Exclude_From__c = '';
                            
                            if (sendData == true)  log.Send_Flag__c = true; 
                            log.Request_Date__c = System.today();
                            log.Start_Date__c = System.today(); 
                            
                        } 
                    }catch(EIPConnector.NoDataException e){
                        System.debug('NoDataException'+ e); 
                        log.EIP_Response__c = e.getStackTraceString();
                    }catch(EIPConnector.EIPConnectorException e){
                        System.debug('EIPConnectorException'+ e); 
                    }catch(Exception e){
                        System.debug('Exception' + e);
                    }
                    
                    if(isSuccess == false){
                        log.Status__c = 'Draft';
                        log.Send_Flag__c = false; 
                        log.Exclude_From__c = '';
                        log.Description__c = '';
                    }
                }
                //log.MOT__c = 'I Complain';
                log.Survey_Type__c = ' I Complain - Complaint';
                 
                update log;
            }
        }
    }
    
    public static void sendMail(Email_sms_log__c requestEmail, OrgWideEmailAddress owea, map<string, string> template) { 
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        String htmlbody = requestEmail.Email_Text__c;
        String subject = template.get(requestEmail.Email_SMS_Template__c);
        if (string.isnotblank(subject) && subject.contains('[MOT_SERVICE]')) {
            subject = subject.replace('[MOT_SERVICE]', 'Penanganan Pengaduan');
        }
        
        System.debug('subject:'+subject);
        
        email.setToAddresses( new List<String>{ requestEmail.Email__c } );
        
        email.setOrgWideEmailAddressId(owea.Id);
        email.setCcAddresses( new List<String>() );
        email.setSubject(subject);
        email.setHtmlBody(htmlbody);
        emails.add(email);
        
        System.debug('owea:'+owea);         
        System.debug('emails:'+emails);         
        if(!Test.isRunningTest()) Messaging.sendEmail(emails); 
    } 
 
}