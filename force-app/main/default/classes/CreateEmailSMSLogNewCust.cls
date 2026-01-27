public class CreateEmailSMSLogNewCust {
    @future(callout=true)
    public static void send(String idContact, String Param){
        String ENTITY = 'AMFS';
        
        Boolean configSendNewCust = Boolean.valueof(System.Label.Config_Sent_Survey_New_Cust); 
        //Boolean isSuccess = false;
        
        String ProducingCD = '';
        String AgentCode = '';
        String AgentCodes = '';
        String EIPMessage = '';
        Boolean isGetData = false;
        Boolean sendData = false;
        
        DescribeSObjectResult describeResultContact = Contact.getSObjectType().getDescribe();
        List<String> contactFieldList = new List<String>(describeResultContact.fields.getMap().keySet());
        String ContactFields = String.join(contactFieldList, ',');
        String query = ' SELECT ' + ContactFields + ' from Contact where Entity__c =:ENTITY AND Id =:idContact ';
        List<Contact> Ctc = Database.query(query);
        List<Contact> List_Ctc = new List<Contact>();
        List<Contact> List_Ctc_upd = new List<Contact>();
        List<Email_SMS_Log__c> List_esl = new List<Email_SMS_Log__c>();
        List<Email_SMS_Log__c> List_esl_upd = new List<Email_SMS_Log__c>();

        Email_SMS_Template__c est = [select id, Email_Body__c, Email_Header__c, Email_Footer__c, Subject__c from Email_SMS_Template__c where name = 'ICF Email Customer Onboarding (AMFS) 2024' limit 1];
        Survey__c survey = [SELECT Id, RecordType.Name, URL__c FROM Survey__c WHERE RecordType.Name = 'Master New Onboarding' AND Survey_Type__c = 'I Buy' AND Status__c = 'Active' AND Entity__c = 'AMFS' AND Name = 'Survey Nasabah Onboarding' limit 1];	            

        for(Contact contactObj : Ctc )
        {
            String surveyUrlParam = 'id=' + survey.Id + '&cId=' + contactObj.Id;
            String method = contactObj.MobilePhone != null ? 'Whatsapp': 'Email';
            
            Map<String, String> configEIP = new Map<String,String>();
            configEIP.put(EIPConstant.CS_COM_TARGET, survey.URL__c + surveyUrlParam);
            configEIP.put(EIPConstant.CS_COM_DELIVER_STATUS,'301');
            EIPJson response, dataAgent;
            EIPMessage = '';
            try{
                if (!System.test.isrunningtest() ) {
                    response = EIPConnector.sendCommunicationMessageT2M('createNewUrl', 'AMFS', 'T2MIO', configEIP);

                    if(contactObj.policyApp__c == 'DMTM'){
                        AgentCodes = 'TM';
                    }else{
                        dataAgent = EIPConnector.getCustomerInfo('Customer Profile', ENTITY, contactObj.policyApp__c, contactObj.policy_no__c);
                        if(dataAgent != null){
                            ProducingCD = dataAgent.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPartyDetailsIn[0].producingCD;
                            AgentCode = ProducingCD.substring(0,1);
                            if(AgentCode == '3') {
                                AgentCodes = 'LP';
                            }
                            else if(AgentCode == '1' || AgentCode == '6' || AgentCode == '7') {
                                AgentCodes = 'FA Conventional';
                            }
                            else if(AgentCode == '4' || AgentCode == '5') {
                                AgentCodes = 'FA Syariah';
                            }
                            else{
                                AgentCodes = 'TM'; 
                            }
                        }
                        
                    }
                    isGetData = true;
                }
            }
            catch(EIPConnector.NoDataException e){
                System.debug('NoDataException'+ e);
                EIPMessage = e.getStackTraceString();
            }catch(EIPConnector.EIPConnectorException e){
                System.debug('EIPConnectorException'+ e); 
                EIPMessage = e.getStackTraceString();
            }catch(Exception e){
                System.debug('Exception' + e);
                EIPMessage = e.getStackTraceString();
            }
            contactObj.Agent_Role_Code__c = AgentCodes;
            contactObj.New_Customer_Onboarding__c = true;
            
            Email_SMS_Log__c esl = new Email_SMS_Log__c();
            if(Param == 'New'){
                esl.OwnerId = UserInfo.getUserId();
                esl.Account__c = contactObj.AccountId;
                esl.Category__c = 'ICF';
                esl.Contact__c = contactObj.Id;
                esl.Mobile__c = contactObj.MobilePhone;
                esl.Email__c = contactObj.Email;
                esl.Method__c = method;
                esl.Entity__c = 'AMFS';
                esl.Request_Date__c = Date.Today();
                esl.Survey_Type__c = 'I Buy - Pembelian Polis';
                esl.Survey_URL__c = survey.URL__c + surveyUrlParam;
                esl.Survey__c = survey.Id;
                esl.Start_Date__c = Date.Today();
                esl.Type__c = 'CCC';
                esl.Email_SMS_Template__c = est.Id;
                esl.Template_Email__c =  est.Id;
                esl.Template_SMS__c =  est.Id;
                esl.Department_Owner__c = 'ICF';
                esl.Topic__c = 'ICF';
                esl.MOT__c = 'I Buy';
                if(configSendNewCust == true || System.Test.IsRunningTest()){
                    esl.Status__c = 'Draft';
                }else{ 
                    esl.Status__c = 'Hold'; 
                }
            }
            else{
                DescribeSObjectResult describeResult = Email_SMS_Log__c.getSObjectType().getDescribe();
                List<String> fieldList_esl = new List<String>(describeResult.fields.getMap().keySet());
                String fieldStr_esl = String.join(fieldList_esl, ',');
                String query_esl = ' SELECT ' + fieldStr_esl + ', contact__r.MobilePhone FROM Email_SMS_Log__c WHERE contact__c =:idContact and Status__c = \'Draft Eip\' limit 1 ';
                esl = Database.query(query_esl); 
            }
            
            esl.EIP_Response__c = EIPMessage;
            
            
            if ((response != null && isGetData) || System.test.isrunningtest())  { 
                String urlshort  = '';
                if (! System.test.isrunningtest()){
                    urlshort = response.Body.Customer.haveCommunicatedMessage[0].replyTo;
                } else{
                    urlshort = 'https://axa.t2mio.com/mqBi9sV';
                }
                if (urlshort != null && urlshort != ''){
                    if(String.isnotblank(esl.Email_Text__c) && esl.Email_Text__c.contains('[SHORT_URL]')==true){
                        esl.Email_Text__c = esl.Email_Text__c.replace('[SHORT_URL]',urlshort);
                    } 
                    esl.bitly__c = urlshort;
                    esl.ready_to_send__c = true; 
                }
                esl.Send_Flag__c = true; 
            }else {
                esl.Status__c = 'Draft EIP';
                esl.Send_Flag__c = false; 
                
                if(response == null){
                    esl.Description__c = 'Failed get link survey';
                } else if(!isGetData) {
                    esl.Description__c = 'Failed get data customer';
                }
            }
            List_Ctc.add(contactObj);
            List_esl.add(esl);
        }
        
        if(Param == 'New') {
            insert List_esl;
        } else{
            update List_esl;
        }
        update List_Ctc;
        
        
        // Send Email or WA
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        OrgWideEmailAddress owea = [SELECT Id, Address, DisplayName FROM OrgWideEmailAddress WHERE Address = :Label.EmailNoReplayAMFS limit 1];
         String Header, Body, Footer, text, text2;
        for(Email_SMS_Log__c log : List_esl){
            if(log.Send_Flag__c && (log.Status__c == 'Draft' || log.Status__c == 'Draft Eip')){
                Contact contactObj = [select id, Name, Policy_No__c, Email, WelcomeCall_GenderName__c, Survey_Buy_Send_Counter__c, Survey_Buy_Send_Date__c 
                                      from Contact where Id=:log.Contact__c limit 1];
                try{
                    if(log.Method__c == 'Email') {
                        //sendMail(est, contactObj, log.Survey_URL__c ,log.bitly__c); 
                        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                        if(est.Email_Header__c!=null) Header = est.Email_Header__c;
                        if(est.Email_Body__c!=null) Body = est.Email_Body__c;
                        if(est.Email_Footer__c!=null) Footer = est.Email_Footer__c; 
                        text = Header + ' ' + Body + ' ' + Footer;
                        List<String> result = new List<String>();
                        if(text!=null && text!='') result = text.split('\\s');
                        String CONTACT_NAME = '[CONTACT_NAME]';
                        String SURVEY_LINK = '[SURVEY_LINK]';
                        String CASE_NUMBER = '[CASE_NUMBER]';
                        String CASE_SUBJECT = '[CASE_SUBJECT]';
                        String POLICY_NO = '[POLICY_NO]';
                        String SHORT_URL = '[SHORT_URL]';
                        String Gender = contactObj.WelcomeCall_GenderName__c;
                        if(contactObj.WelcomeCall_GenderName__c == null || contactObj.WelcomeCall_GenderName__c == 'null' || contactObj.WelcomeCall_GenderName__c == '' ) Gender = 'Bapak/Ibu';
                        IF(result.size()>0){
                            for(String r:result){
                                if(text2==null){
                                    if(r == CONTACT_NAME || r.contains(CONTACT_NAME) == true){
                                        text2 = contactObj.Name;
                                    }
                                    else if(r == SURVEY_LINK || r.contains(SURVEY_LINK) == true){
                                        text2 = log.Survey_URL__c;
                                    }
                                    else if(r == POLICY_NO || r.contains(POLICY_NO) == true){
                                        text2 = contactObj.Policy_No__c;
                                    }
                                    else if(r == SHORT_URL || r.contains(SHORT_URL) == true){
                                        if(log.bitly__c!=null) text2 = log.bitly__c;
                                        else text2 = r;
                                    }
                                    else if(r == '[CONTACT_GENDER]'){ // added by Support MII at 03 04 24
                                        text2 = text2+' ' +Gender ;
                                    }
                                    else if(r == '[MOT_SERVICE]'){ // added by Support MII at 03 04 24
                                        text2 = text2+' Pembelian Polis';
                                    }
                                    else{
                                        text2 = r;
                                    }
                                }
                                else{
                                    if(r == CONTACT_NAME || r.contains(CONTACT_NAME) == true){
                                        text2 = text2+' ' +contactObj.Name;
                                    }
                                    else if(r == SURVEY_LINK || r.contains(SURVEY_LINK) == true){
                                        text2 = text2+' ' +log.Survey_URL__c;
                                    }
                                    else if(r == POLICY_NO || r.contains(POLICY_NO) == true){
                                        text2 = text2+' ' +contactObj.Policy_No__c;
                                    }
                                    else if(r == SHORT_URL || r.contains(SHORT_URL) == true){
                                        if(log.bitly__c!=null) text2 = text2+' '+log.bitly__c;
                                        else  text2 = text2+' ' +r;
                                    }
                                    else if(r == '[CONTACT_GENDER]'){ // added by Support MII at 03 04 24
                                        text2 = text2+' ' + Gender;
                                    }
                                    else if(r == '[MOT_SERVICE]'){ // added by Support MII at 03 04 24
                                        text2 = text2+' Pembelian Polis';
                                    }
                                    else{
                                        text2 = text2+' ' +r;
                                    }
                                    
                                }
                            }    
                        }
                        
                        String htmlbody = text2;
                        String subject = est.Subject__c;
                        if (string.isnotblank(subject) && subject.contains('[MOT_SERVICE]')) {
                            subject = subject.replace('[MOT_SERVICE]', ' Pembelian Polis');
                        }
                        email.setToAddresses( new List<String>{ contactObj.Email } );
                        
                        email.setOrgWideEmailAddressId(owea.Id);
                        email.setCcAddresses( new List<String>() );
                        email.setSubject(subject);
                        email.setHtmlBody(htmlbody);
                        emails.add(email);
                    }
                    if(log.Method__c == 'Whatsapp') {
                        Set<id> sendWa = new Set<id>();
                        sendWa.add(log.id);
                        if (!System.Test.IsRunningTest()) System.enqueueJob(new SendSurveyICF.sendWhatsapp(sendWa));
                    }
                    log.Status__c = 'Send';
                    log.Updated_Contact_Flag__c = true;
                    log.End_Date__c = system.today();
                    log.Request_Date__c = System.today();
                    contactObj.Survey_Buy_Send_Counter__c = 1;
                    contactObj.Survey_Buy_Send_Date__c = System.today(); 
                    contactObj.New_Customer_Onboarding__c = false;
                    sendData = true;
                }catch(Exception e){
                    System.debug('Exception' + e);
                }
                if(!sendData) {
                    log.Status__c = 'Cancel';
                    log.Description__c = 'Failed send WA / Email';
                }
                log.External_ID__c = '';
                List_esl_upd.add(log);
                List_Ctc_upd.add(contactObj);
            }
        }
        try{
            if(!Test.isRunningTest()) Messaging.sendEmail(emails); 
        }catch(Exception e){
            System.debug('Exception' + e);
        }
        update List_esl_upd;
        update List_Ctc_upd;
    }
    
    Public static void sendSurveyNewCustomer(Set<Id> contactId) { 
        Set<id> sendWa = new Set<id>();
        
        DescribeSObjectResult describeResult = Email_SMS_Log__c.getSObjectType().getDescribe();
        List<String> fieldList = new List<String>(describeResult.fields.getMap().keySet());
        String fieldStr = String.join(fieldList, ',');
        String query = ' SELECT ' + fieldStr + ' FROM Email_SMS_Log__c WHERE contact__c in:contactId AND Status__c = \'Hold\' ORDER BY createddate asc';
        List<Email_SMS_Log__c> listLog = Database.query(query);
        List<Email_SMS_Log__c> list_esl = new List<Email_SMS_Log__c>();
        List<Contact> list_ctc = new List<Contact>();
        Contact ctc = new Contact();
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        OrgWideEmailAddress owea = [SELECT Id, Address, DisplayName FROM OrgWideEmailAddress WHERE Address = :Label.EmailNoReplayAMFS limit 1];
        
        
        for (Email_SMS_Log__c row : listLog) {    
            ctc = [Select Survey_Buy_Send_Counter__c, Survey_Buy_Send_Date__c, Email_Sms_Log_Buy__c, policy_no__c, entity__c, policyApp__c, New_Customer_Onboarding__c 
                   from contact where id =:row.contact__c limit 1]; 
            if (string.isnotblank(row.Mobile__c)) {   
                system.debug('row.Mobile__c is not blank');  
                sendWa.add(row.id);
                row.method__c = 'Whatsapp'; 
            }
            else{
                if (string.isnotblank(row.Email__c)) { 
                    map<string, string> mapEmailTemplate = new map<string, string>(); 
                    system.debug('Masuk Email');
                    if (!mapEmailTemplate.containsKey(row.Email_SMS_Template__c)) {
                        mapEmailTemplate.put(row.Email_SMS_Template__c, ''); 
                        
                        List<Email_SMS_Template__c> subjectEmail = [SELECT Id, Subject__c FROM Email_SMS_Template__c WHERE id in : mapEmailTemplate.keyset()];
                        for(Email_SMS_Template__c emailTemplate: subjectEmail){
                            mapEmailTemplate.put(emailTemplate.Id, emailTemplate.Subject__c ); 
                        } 
                        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                        String htmlbody = row.Email_Text__c;
                        String subject = mapEmailTemplate.get(row.Email_SMS_Template__c);
                        if (string.isnotblank(subject) && subject.contains('[MOT_SERVICE]')) {
                            subject = subject.replace('[MOT_SERVICE]', ' Pembelian Polis');
                        }
                        email.setToAddresses( new List<String>{ row.Email__c } );
                        
                        email.setOrgWideEmailAddressId(owea.Id);
                        email.setCcAddresses( new List<String>() );
                        email.setSubject(subject);
                        email.setHtmlBody(htmlbody);
                        emails.add(email);
                        row.status__c = 'Send';
                        row.Send_Flag__c = true;
                        row.End_Date__c = System.Today();
                        row.Updated_Contact_Flag__c = true;
                        row.Request_Date__c = System.today();
                    }
                }
            }
            ctc.Survey_Buy_Send_Counter__c = 1;
            ctc.Survey_Buy_Send_Date__c = System.today(); 
            ctc.Email_Sms_Log_Buy__c = row.Id;
            ctc.New_Customer_Onboarding__c = false;
            
            list_ctc.add(ctc);
            list_esl.add(row);
        } 
        
        if (!System.Test.IsRunningTest() && sendWa.size() > 0) System.enqueueJob(new SendSurveyICF.sendWhatsapp(sendWa));
        if (!Test.isRunningTest()) Messaging.sendEmail(emails); 
        update list_ctc;
        update list_esl;
    } 
    
    public class CreateEmailSMSLog implements Queueable {
        private Set<id> logIds;  
        private String params;
        public CreateEmailSMSLog(Set<id> logIds, String params) {
            this.logIds = logIds; 
            this.params = params;
        }
        
        public void execute(QueueableContext context) {
            // Perform the callout asynchronously
            for (string logId : logIds) { 
                send(logId, params); 
            }
        } 
    } 

}