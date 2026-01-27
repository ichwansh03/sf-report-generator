global class CreateEmailSMSLogClaimReject {
    @future(callout=true)
    public static void send(Set<Id> emailLogs){
        for (string emailLogId: emailLogs) {
            Boolean configSendClaimReject = Boolean.valueof(System.Label.Config_Sent_Survey_ICF_Claim_Reject);
            Boolean getDataEip = false;
            String EIPMessage = '';
            EIPJson response;
            DescribeSObjectResult describeResult = Email_SMS_Log__c.getSObjectType().getDescribe();
            List<String> fieldList = new List<String>(describeResult.fields.getMap().keySet());
            String fieldStr = String.join(fieldList, ',');
            String query = ' SELECT ' + fieldStr + ', case__r.Case_Type_Config__c, case__r.Case_type__c, case__r.MOT__c, case__r.entity__c, case__r.Follow_Up_ICF__c, contact__r.MobilePhone, case__r.Subject, case__r.Origin, case__r.Description FROM Email_SMS_Log__c WHERE Id = :emailLogId ';
            
            Email_SMS_Log__c log = Database.query(query); 
            
            Survey__c survey = new Survey__c();
            survey = [SELECT Id, RecordType.Name, URL__c FROM Survey__c WHERE id=:log.Survey__c  limit 1];	     
            String surveyUrlParam = 'id=' + log.Survey__c + '&cId=' + log.Contact__c + '&eId=' +log.Id;
            log.Survey_URL__c = survey.URL__c + surveyUrlParam;
            system.debug('surveyUrlParam:'+surveyUrlParam);
            if(log.Method__c == 'Whatsapp'){
                Map<String, String> configEIP = new Map<String,String>();
                configEIP.put(EIPConstant.CS_COM_TARGET, survey.URL__c + surveyUrlParam);
                configEIP.put(EIPConstant.CS_COM_DELIVER_STATUS,'301');
                
                EIPMessage = '';
                try{   
                    getDataEip = true;
                    if (System.test.isrunningtest()) {
                        EIPJSON.EIP_CustomerCommunication hasPolicyAccount = new EIPJSON.EIP_CustomerCommunication();
                        hasPolicyAccount.replyTo = 'https://axa.t2mio.com/mqBi9sV';
                        
                        List<EIPJSON.EIP_CustomerCommunication> haveCommunicatedMessage = new List<EIPJSON.EIP_CustomerCommunication>();
                        haveCommunicatedMessage.add(hasPolicyAccount);
                        
                        EIPJSON.EIP_IcAx_AXAAsiaCustomer customer = new EIPJSON.EIP_IcAx_AXAAsiaCustomer();
                        customer.haveCommunicatedMessage = haveCommunicatedMessage;
                        
                        EIPJSON.EIP_Body body = new EIPJSON.EIP_Body();
                        body.Customer = customer;
                        
                        EIPJson test = new EIPJson();
                        test.Body = body;
                        
                        response = test;
                    }
                    else{
                        response = EIPConnector.sendCommunicationMessageT2M('createNewUrl', 'AMFS', 'T2MIO', configEIP);

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
            }else{
                getDataEip = true;
                
            }
            
            if(getDataEip){
                if (response != null && log.Method__c == 'Whatsapp')  { 
                    String urlshort  = '';
                    if (!System.test.isrunningtest()){
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
                    }
                    Set<id> sendWa = new Set<id>();
                    sendWa.add(log.id);
                    if(configSendClaimReject == true && !System.Test.IsRunningTest()){
                        if (string.isnotblank(log.Mobile__c )) { 
                            System.enqueueJob(new SendSurveyICF.sendWhatsapp(sendWa));
                            log.Status__c = 'Send';
                        }else{
                            log.Status__c = 'Cancel';
                            log.Description__c = 'Mobile Phone Null';
                        }
                    }else{
                        log.Status__c = 'Hold';
                    }
                }
                if (log.Method__c == 'Email'){
                    List<Email_SMS_Template__c> subjectEmail = [SELECT Id, Subject__c FROM Email_SMS_Template__c WHERE id=:log.Email_SMS_Template__c limit 1];
                    List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    OrgWideEmailAddress owea = [SELECT Id, Address, DisplayName FROM OrgWideEmailAddress WHERE Address = :Label.EmailNoReplayAMFS limit 1];
                    String Header, Body, Footer, text, text2;
                    
                    String htmlbody = log.Email_Text__c.replace('<a href=" null ">','<a href="' +survey.URL__c +surveyUrlParam+' ">');
                    log.Email_Text__c = htmlbody;
                    String subject = '';
                    if(!Test.isRunningTest()) subject = subjectEmail[0].Subject__c;
                    
                    email.setToAddresses( new List<String>{ log.Email__c } );
                    
                    email.setOrgWideEmailAddressId(owea.Id);
                    email.setCcAddresses( new List<String>() );
                    email.setSubject(subject);
                    email.setHtmlBody(htmlbody);
                    emails.add(email);
                    if(!Test.isRunningTest() && configSendClaimReject == true) {
                        Messaging.sendEmail(emails); 
                        log.Status__c = 'Send';
                    }else{
                        log.Status__c = 'Hold';
                    }
                }
            }
            else{
                log.Status__c = 'draft_eip';
                log.EIP_Response__c = EIPMessage;
            }
            update log;
        }
        
    }
    
    public class CreateEmailSMSLog implements Queueable{
        private Set<id> icf_Ids;  
        public CreateEmailSMSLog(Set<id> icf_Ids) {
            this.icf_Ids = icf_Ids; 
        }
        public void execute(QueueableContext context) {
            for (string icf_Id: icf_Ids) {
                String PolicyNo,PolicyApp,Entity;
                Boolean fraud, proceed_icf;
                List<Email_SMS_Log__c> List_esl = new List<Email_SMS_Log__c>();
                
                //get icf non real time
                List<ICF_Non_Real_Time__c> list_data = new List<ICF_Non_Real_Time__c> ();
                DescribeSObjectResult describeResultICF = ICF_Non_Real_Time__c.getSObjectType().getDescribe();
                List<String> ICFFieldList = new List<String>(describeResultICF.fields.getMap().keySet());
                String Fields = String.join(ICFFieldList, ',');
                String query = ' SELECT ' + Fields + ' from ICF_Non_Real_Time__c where id=:icf_Id ';
                ICF_Non_Real_Time__c data = Database.query(query);
                PolicyNo = data.Policy_Number__c;
                Entity = 'AMFS';
                fraud = false;
                proceed_icf = false;
                Email_SMS_Log__c esl = new Email_SMS_Log__c();
                
                DescribeSObjectResult describeResultContact = Contact.getSObjectType().getDescribe();
                List<String> contactFieldList = new List<String>(describeResultContact.fields.getMap().keySet());
                String ContactFields = String.join(contactFieldList, ',');
                String querycontact = ' SELECT ' + ContactFields + ' from Contact where Entity__c =:Entity and Policy_No__c =:PolicyNo limit 1';
                List<Contact> contactList = Database.query(querycontact);
                if(contactList.size() > 0){
                    Contact contactObj = contactList[0];
                    
                    data.Contact__c = contactObj.Id;
                    String product =  contactObj.WelcomeCall_Product_Code_Plan__c;
                    
                    if(data.Source_System__c == 'care') PolicyApp = 'AHS';
                    else PolicyApp = data.Source_System__c;
                    
                    //check fraud
                    if(PolicyApp == 'AHS' && (data.Fraud__c == 'R0376' || data.Fraud__c == 'R0334')) {
                        data.Status_Fraud__c = 'Fraud';
                        fraud = true;
                    }
                    if(PolicyApp == 'RLS' && (data.Fraud__c == 'AF' || data.Fraud__c == 'PF')) {
                        data.Status_Fraud__c = 'Fraud';
                        fraud = true;
                    }
                    if(PolicyApp == 'DMTM' && (data.Fraud__c == 'AF' || data.Fraud__c == 'PF' || data.Fraud__c == 'PA' || data.Fraud__c == 'PW' || data.Fraud__c == 'NF')) {
                        data.Status_Fraud__c = 'Fraud';
                        fraud = true;
                    }
                    if (!fraud){
                        data.Status_Fraud__c = 'Not Fraud';
                        String method = contactObj.MobilePhone != null ? 'Whatsapp': 'Email';
                        
                        Email_SMS_Template__c est = new Email_SMS_Template__c();
                        Survey__c survey = new Survey__c();
                        
                        if(data.Jenis_Transaksi__c == 'cashless'){
                            survey = [SELECT Id, RecordType.Name, URL__c FROM Survey__c WHERE recordType.Name = 'Master New Onboarding' and Name = 'Survey Request I Claim Individu Cashless' limit 1];	      
                        }else{
                            survey = [SELECT Id, RecordType.Name, URL__c FROM Survey__c WHERE recordType.Name = 'Master New Onboarding' and Name = 'Survey Request I Claim Individu Reimbursement' limit 1];	      
                            
                        }
                        List<ICF_Parameter__c> icfParams = [select id from ICF_Parameter__c where RecordType.Name = 'Master - qualtrics' and Status__c = 'Active' and entity__c = 'AMFS'
                                                            and (Include_Product_Code_Plan_Claim_1__c includes (:product) or Include_Product_Code_Plan_Claim_2__c includes (:product))];
                        if(icfParams.size() > 0 || data.Source_System__c == 'Care'){
                            PolicyApp = 'AHS';
                            if(data.Jenis_Transaksi__c == 'cashless'){
                                
                                est = [select id, Email_Body__c, Email_Header__c, Email_Footer__c, Subject__c from Email_SMS_Template__c where name = 'ICF Email AMFS Claim Reject AHS cashless' limit 1];
                                
                            }else{
                                est = [select id, Email_Body__c, Email_Header__c, Email_Footer__c, Subject__c from Email_SMS_Template__c where name = 'ICF Email AMFS Claim Reject AHS reimbusement' limit 1];
                                
                            }
                        }else{
                            PolicyApp = contactObj.PolicyApp__c;
                            if(data.Jenis_Transaksi__c == 'cashless'){
                                est = [select id, Email_Body__c, Email_Header__c, Email_Footer__c, Subject__c from Email_SMS_Template__c where name = 'ICF Email (AMFS) 2024' limit 1];
                                
                            }else{
                                est = [select id, Email_Body__c, Email_Header__c, Email_Footer__c, Subject__c from Email_SMS_Template__c where name = 'ICF Email AMFS Claim Reject RLS DMTM' limit 1];
                            }
                        }
                        
                        //get response for WA
                        data.Proceed_ICF__c = true;
                        esl.OwnerId = UserInfo.getUserId();
                        esl.Account__c = contactObj.AccountId;
                        esl.Category__c = 'ICF';
                        esl.Contact__c = contactObj.Id;
                        esl.Mobile__c = contactObj.MobilePhone;
                        esl.Email__c = contactObj.Email;
                        esl.Method__c = method;
                        esl.Entity__c = 'AMFS';
                        esl.Request_Date__c = Date.Today();
                        esl.Survey_Type__c = 'I Claim - Request';
                        esl.Survey__c = survey.Id;
                        esl.Start_Date__c = Date.Today();
                        esl.Type__c = 'CCC';
                        esl.Email_SMS_Template__c = est.Id;
                        esl.Template_Email__c =  est.Id;
                        esl.Template_SMS__c =  est.Id;
                        esl.Department_Owner__c = 'ICF';
                        esl.Topic__c = 'ICF';
                        esl.MOT__c = 'I Claim';
                        esl.Nama_Rumah_Sakit__c = data.Nama_RS_Provider__c;
                        esl.Claim_Type__c = data.Claim_Type__c;
                        esl.Claim_Transaction_Type__c  = data.Jenis_Transaksi__c != null ? data.Jenis_Transaksi__c : 'Reimbursement';
                        esl.Claim_Number__c = data.Claim_Number__c;
                        esl.Status__c = 'Draft';
                        esl.Claim_Status__c = 'Reject';
                        esl.Send_Flag__c = true; 
                        esl.Nama_Rumah_Sakit__c = data.Nama_RS_Provider__c;
                        esl.Claim_Type__c = data.Claim_Type__c;
                        esl.Claim_Transaction_Type__c = data.Jenis_Transaksi__c == null ? 'Reimbursement' : data.Jenis_Transaksi__c;
                        esl.Claim_Susp_Fraud__c = 'NF';
                        esl.is_Eligible__c = true;
                        
                        List_esl.add(esl);
                        if (!System.Test.IsRunningTest()) insert List_esl;
                        system.debug('Email sms log:'+ List_esl[0].id);
                        data.Email_SMS_Log__c = List_esl[0].id;
                        data.Proceed_ICF__c = true;
                    }
                    else{
                        //data fraud, email sms log not created, flag proceed true
                        data.Proceed_ICF__c = true;
                        data.Status_Fraud__c = 'Fraud';
                    }
                }
                
                
                list_data.add(data);
                update list_data;
            }
        }
    }
    
}