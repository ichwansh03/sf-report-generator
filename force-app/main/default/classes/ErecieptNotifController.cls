public class ErecieptNotifController {
    public final static String MSG_SEND_FAILED = 'An Error Occurred in Sending the E-receipt'; 
    public final static String MSG_SEND_SUCCESS = 'E-receipt Delivery Process was Successful';
    
    public ErecieptNotifController() {
    }
    
    
    public void sendEmail(List<String> listEmailTo, List<Log_Book_Activitiy_Detail__c> logBookDetailList, String subjectEmail, String bodyEmail) {
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        List<String> listEmailToTest = new List<String>();
        OrgWideEmailAddress owea = new OrgWideEmailAddress();
        
        owea = [SELECT Id, Address, DisplayName FROM OrgWideEmailAddress WHERE IsAllowAllProfiles = TRUE LIMIT 1];
        
        // listEmailToTest.add('akungame607@gmail.com');
        
        try {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setOrgWideEmailAddressId(owea.Id);
            //mail.setToAddresses(listEmailToTest);
            mail.setToAddresses(listEmailTo);
            mail.setSubject(subjectEmail);
            mail.setHtmlBody(bodyEmail);
            mails.add(mail);
            if(mails.size() > 0 && !Test.isRunningTest()) Messaging.sendEmail(mails);
            
            id caseId = null;
            Id lbaId;
            //update status send
            Set<Log_Book_Activitiy__c> listUpdateLogBook = new Set<Log_Book_Activitiy__c>();
            List<Log_Book_Activitiy__c> listFinalUpdateLogBook = new List<Log_Book_Activitiy__c>();
            Set<Log_Book_Activitiy_Detail__c> listUpdateLogBookDetail = new Set<Log_Book_Activitiy_Detail__c>();
            List<Log_Book_Activitiy_Detail__c> listFinalUpdateLogBookDetail = new List<Log_Book_Activitiy_Detail__c>(); 
            for(Log_Book_Activitiy_Detail__c lbDetail : logBookDetailList) {
                //Log_Book_Activitiy__c templb = new Log_Book_Activitiy__c();
                //templb.Id = lbDetail.Log_Book_Activitiy__c;
                //templb.Status_send__c = 'Email';
                caseId = lbDetail.Log_Case__c;
                lbaId = lbDetail.Log_Book_Activitiy__c;
                //listUpdateLogBook.add(templb);
                lbDetail.Status_Send__c = 'Email';
                listUpdateLogBookDetail.add(lbDetail);
            }
            //listFinalUpdateLogBook.addAll(listUpdateLogBook);
            listFinalUpdateLogBookDetail.addAll(listUpdateLogBookDetail);
            //if(listFinalUpdateLogBook.size() > 0) update listFinalUpdateLogBook;
            if(listFinalUpdateLogBookDetail.size() > 0) update listFinalUpdateLogBookDetail; 
            
            string emailto;
            
            for(String et : listEmailTo) {
                emailto = et;
            }
            
            Log_Book_Activitiy__c lba = [SELECT Id, Touch_Point__c FROM Log_Book_Activitiy__c WHERE Id =:lbaId];
            
            //create log email to object Email_SMS_Log__c
            Email_SMS_Log__c tempLog = new Email_SMS_Log__c();
            tempLog.Entity__c = 'AMFS';
            tempLog.Method__c = 'Email';
            tempLog.Category__c = 'Ereciept-AMFS';
            tempLog.case__c = caseId;
            tempLog.Email__c = emailto;
            tempLog.Status__c = 'Send';
            tempLog.First_Send__c = system.today();
            tempLog.Touch_Point__c = lbaId;
            insert tempLog;
        }
        catch(Exception ex) {system.debug('exception email = '+ex.getMessage());}
    }
    
    @future(callout = TRUE)
    public static void sendSMS(Id lbdId, String bodySMS, String longUrl, String userId, String password, String sender, String division, String batchName, String uploadBy, String channel) {
        //get data logbookdetail 
        Log_Book_Activitiy_Detail__c logBookDetail = new Log_Book_Activitiy_Detail__c();
        system.debug('LONGURL :' + longUrl);
        
        logBookDetail = [SELECT ID, Log_Case__r.CaseNumber, Log_Book_Activitiy__c, Log_Book_Activitiy__r.Log_Book_Date__c, Log_Book_Activitiy__r.Touch_Point__c, Log_Book_Activitiy__r.Touch_Point_City__c, Log_Book_Activitiy__r.Queue_No__c, 
                             Log_Book_Activitiy__r.CSO_Name__c, Status_send__c, Policy_Number__c, Policy_Name_Holder__c, Product_Type__c, Customer_Name__c, Customer_Relation__c,
                             Is_Policy_Holder__c, Segmentation__c, Department__c, Kind_Of_Transaction__c, Document_Type__c, Document__c, Document_Information__c, 
                             Stamp__c, Remarks_Long_Text__c, Notes__c, Transaction_Type__c, Case_Type__c, Customer_Mood__c, Status__c, Need_CR__c, Log_Case__r.Type, Log_Case__c,
                             Log_Case__r.Case_Type_Config__c, Log_Case__r.Case_Type__c, Log_Case__r.Subject, Log_Case__r.Description, Log_Case__r.Description__c, 
                             Log_Case__r.Nature_Config__c, Log_Case__r.Category_Config__c, Log_Case__r.PIC_Department_LU__c, Log_Case__r.Status, Other_Document__c,
                             Contact_Policy__r.Email, Contact_Policy__r.MobilePhone, Email_Non_PP__c, Phone_Non_PP__c, Email_PP__c, Phone_PP__c, Count_SMS__c, Shorten_Link__c,Is_Non_Customer__c
                             FROM Log_Book_Activitiy_Detail__c WHERE Id = :lbdId];
        
        String remarkLBD = (String) logBookDetail.Remarks_Long_Text__c;
        Boolean isTest =  remarkLBD.contains('E-Receipt AMFS Test Remarks');
        System.debug('isTest: ' + isTest);
        
        String T2MIO_URL = Label.T2MIO_URL;
        String T2MIO_Username = Label.T2MIO_Username;
        String T2MIO_Password = Label.T2MIO_Password;
        String shortUrl = null;
        String transId;
        String phone = null;
        Double count;
        
        //start get shorten link via T2MIO
        if(logBookDetail.Shorten_Link__c == NULL) {
            //check record ada shorten link
            AggregateResult agr = [SELECT COUNT(Id) cnt FROM Log_Book_Activitiy_Detail__c WHERE Shorten_Link__c != NULL];
            count = Double.valueOf(agr.get('cnt'))+1;
            //end check record ada shorten link
            
            transId = isTest? 'EAT' + String.valueOf(count) : String.valueOf(count);
            System.debug('transId: ' + transId);
            
            //create JSON shorten link
        	String jsonLink = '{'+
            						'"Header":{'+
            							'"SecurityContext":{'+
            								'"username":"'+T2MIO_Username+'",'+
            								'"password":"'+T2MIO_Password+'"'+
            							'}'+
            						'},'+
        							'"Body":{'+
            							'"transactionId":"'+transId+'",'+
            							'"operation":"createNewUrl",'+
            							'"appID":"T2MIO",'+
            							'"entity":"AMFS",'+
            							'"service":"sendCommunicationMessage",'+
        							'"Customer":{'+
                                    	'"haveCommunicatedMessage":['+
            								'{'+
                                                '"target":"'+longUrl+'",'+
                                                '"deliveryStatusCD":"301"'+
            								'}'+
            							']'+
            						'}'+
            					'}'+
            				'}';
            
            System.debug('json link: ' + jsonLink);
            try {
                HttpRequest reqLink = new HttpRequest();
                reqLink.setEndpoint(T2MIO_URL);
                reqLink.setMethod('POST');
                reqLink.setBody(jsonLink);
                reqLink.setHeader('Content-Type', 'application/json');
                reqLink.setHeader('Accept', 'application/json');
                reqLink.setTimeout(120000);
                
                Http httpLink = new Http();
                HttpResponse resLink = httpLink.send(reqLink);
                
                WS_RES_SHORTLINK resObjLink = WS_RES_SHORTLINK.parse(resLink.getBody());
                if(resObjLink != NULL) {
                    if(resObjLink.Body.Customer.haveCommunicatedMessage.size() > 0) {
                        for(Integer i = 0 ; i < resObjLink.Body.Customer.haveCommunicatedMessage.size(); i++) {
                            shortUrl = resObjLink.Body.Customer.haveCommunicatedMessage[i].replyTo;
                        }
                    }
                }
                system.debug('SHORTURL: ' + shortUrl);
                
                if(shortUrl == NULL) {
                	throw new NullPointerException();
                }
            } catch (NullPointerException enp) {
                system.debug('short url not generated = '+enp.getMessage());
                return;
            } catch (Exception ex) {
                system.debug('exception shorten link = '+ex.getMessage());
                return;
            } 
            
        } else {
            shortUrl = logBookDetail.Shorten_Link__c; 
        }
        
        if(bodySMS.contains('[LINKPAGE]')) bodySMS = bodySMS.replace('[LINKPAGE]', shortUrl);
        
        if(logBookDetail.Phone_PP__c != NULL  && logBookDetail.Is_Non_Customer__c != true) {
            phone = logBookDetail.Phone_PP__c;
        }
        if(logBookDetail.Phone_Non_PP__c != NULL && logBookDetail.Is_Non_Customer__c == true) {
            phone = logBookDetail.Phone_Non_PP__c;
        }
        
        System.debug('Phone: ' + phone);
        try {              
            if(phone != NULL) { 
                String url1 = Label.JATIS_SMS_Endpoint + '?userid='+userId+'&password='+password+'&msisdn='+phone+'&message='+EncodingUtil.urlEncode(bodySMS, 'UTF-8');
                String url2 = '&sender='+sender+'&division='+EncodingUtil.urlEncode(division, 'UTF-8')+'&batchname='+EncodingUtil.urlEncode(batchName, 'UTF-8');
                String url3 = '&uploadby='+EncodingUtil.urlEncode(uploadBy, 'UTF-8')+'&channel='+EncodingUtil.urlEncode(channel, 'UTF-8')+' ';
                String JATIS_URL = url1 + url2 + url3;
                
                HttpRequest reqSMS = new HttpRequest();
                reqSMS.setEndpoint(JATIS_URL);
                reqSMS.setMethod('GET');
                reqSMS.setCompressed(TRUE);
                reqSMS.setTimeout(120000);
                
                Http httpSMS = new Http();
                HttpResponse resSMS = httpSMS.send(reqSMS);		
                
                Log_Book_Activitiy_Detail__c updateLBD = new Log_Book_Activitiy_Detail__c();
                updateLBD.Id = logBookDetail.Id;
                updateLBD.Shorten_Link__c = shortUrl;
                updateLBD.Send_Datetime__c = system.today();
                updateLBD.Status_Send__c = 'SMS';
                update updateLBD;
                
                /* // remark status send, move status send to activity detail
                 * Log_Book_Activitiy__c updateLB = new Log_Book_Activitiy__c();
                 * updateLB.Id = logBookDetail.Log_Book_Activitiy__c;
                 * updateLB.Status_send__c = 'SMS';
                 * update updateLB;
				*/
                
                //create log email to object Email_SMS_Log__c
                Email_SMS_Log__c tempLog = new Email_SMS_Log__c();
                tempLog.Entity__c = 'AMFS';
                tempLog.Method__c = 'SMS';
                tempLog.Category__c = 'Ereciept-AMFS';
                tempLog.case__c = logBookDetail.Log_Case__c;
                tempLog.Mobile__c = phone;
                tempLog.Status__c = 'Send';
                tempLog.First_Send__c = system.today();
                tempLog.Touch_Point__c = logBookDetail.Log_Book_Activitiy__r.Touch_Point__c;
                insert tempLog;
            }
        } catch (Exception ex) {system.debug('exception send jatis = '+ex.getMessage());}
    }
}