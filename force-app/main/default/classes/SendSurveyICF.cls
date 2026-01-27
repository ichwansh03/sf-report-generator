public class SendSurveyICF {    
    @Future(callout=true)
    public static void send(string logId) {  
        DescribeSObjectResult describeResult = Email_SMS_Log__c.getSObjectType().getDescribe();
        List<String> fieldList = new List<String>(describeResult.fields.getMap().keySet());
        String fieldStr = String.join(fieldList, ',');
        String query = ' SELECT ' + fieldStr + ', case__r.Case_Type_Config__c, case__r.Case_type__c, case__r.MOT__c, case__r.entity__c FROM Email_SMS_Log__c WHERE id =:logId ORDER BY createddate asc';
            
        Email_sms_log__c log = Database.query(query); 
        String phone = log.Mobile__c;  
        
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
        
        ICF_Parameter__c MT = NEW ICF_Parameter__c();
        DescribeSObjectResult describeResultdp = ICF_Parameter__c.getSObjectType().getDescribe();
        List<String> dpFieldList = new List<String>(describeResultdp.fields.getMap().keySet());
        String dpFields = String.join(dpFieldList, ',');
        String mot = log.MOT__c;
        String lognya = '';
        String soql = 'SELECT '+dpFields+' FROM ICF_Parameter__c ';
        soql = soql+ ' where Record_Type_Name__c Like '+'\''+'%Qualtrics%'+'\''+' ';
        soql = soql+ ' and entity__c = '+'\''+ log.Entity__c+'\''+' ';
        soql = soql+ ' AND Status__c = '+'\''+ 'Active'+'\''+ ' limit 1'; 
        
        mt = Database.query(soql);
        if(log.Claim_Status__c == 'Reject'){
            
            DescribeSObjectResult describeResultICF = ICF_Non_Real_Time__c.getSObjectType().getDescribe();
            List<String> ICFFieldList = new List<String>(describeResultICF.fields.getMap().keySet());
            String Fields = String.join(ICFFieldList, ',');
            String query_reject = ' SELECT ' + Fields + ' from ICF_Non_Real_Time__c where Email_SMS_Log__c=:logId limit 1';
            List<ICF_Non_Real_Time__c> data = Database.query(query_reject);
            if(data.size() > 0){
                if (data[0].Source_System__c == 'care') {
                    if (data[0].Jenis_Transaksi__c == 'Cashless') mot = 'I Claim AHS Reject';
                    else if (data[0].Jenis_Transaksi__c == 'Reimbursement') mot = 'I Claim AHS Reject Reimbursement';
                } else {
                    mot = 'I Claim Core Reject';
                }
            }
            
        }
        List<ICF_Template_and_Namespace__c> icfNT = [SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, Survey_Type__c, Namespace__c, Template_ID__c FROM ICF_Template_and_Namespace__c where Survey_Type__c =:mot  Limit 1];
        system.debug('icfNT:'+icfNT);
        if (icfNT.size() > 0){
            String phonenumber = phone;
            EIPJson res = new EIPJson(); 
            try {
                Map<String, String> configEIP = new Map<String, String>();
                configEIP.put(EIPConstant.WA_TEMPLATE_ID, icfNT[0].Template_ID__c);
                configEIP.put(EIPConstant.WA_NAMESPACE, icfNT[0].Namespace__c);
                configEIP.put(EIPConstant.WA_CUSTOMER_NAME, log.Contact_Name__c);
                configEIP.put(EIPConstant.WA_PHONE_TO, phonenumber);
                configEIP.put(EIPConstant.WA_SURVEY_URL_LINK, log.Bitly__c);
                configEIP.put(EIPConstant.WA_CUSTOMER_SERVICE, log.Nama_Layanan__c);
                //configEIP.put(EIPConstant.WA_CUSTOMER_SERVICE, log.MOT_in_Email__c);
                configEIP.put(EIPConstant.WA_CUSTOMER_GENDER, log.Contact_Gender__c);
                               
            	
                if (!system.Test.isrunningtest()) {
                    res = EIPConnector.sendCommunicationMessageWhatsapp(EIPConstant.OPERATION_SEND_WHATSAPP, EIPConstant.ENTITY_AMFS, EIPConstant.APP_JATIS, configEIP);
                }else{
                    EIPJson.EIP_CustomerCommunication hasPolicyAccount = new EIPJson.EIP_CustomerCommunication();
                    hasPolicyAccount.channelID = 'Testing';
                    
                    List<EIPJson.EIP_CustomerCommunication> haveCommunicatedMessage = new List<EIPJson.EIP_CustomerCommunication>();
                    haveCommunicatedMessage.add(hasPolicyAccount);
                    
                    EIPJson.EIP_IcAx_AXAAsiaCustomer customer = new EIPJson.EIP_IcAx_AXAAsiaCustomer();
                    customer.haveCommunicatedMessage = haveCommunicatedMessage;
                    
                    EIPJson.EIP_Body body = new EIPJson.EIP_Body();
                    body.status = '1';
                    body.Customer = customer;
                    
                    //EIPJson test = new EIPJson();
                    //test.Body = body;
                    
                    res.Body = body;
                }
                
                log.Date_Hit_JATIS__c = string.valueof(System.today()); 
                if (res != null) { 
                    log.MessageId_JATIS__c = res.Body.Customer.haveCommunicatedMessage[0].channelID;
                    
                    log.Status_JATIS__c = String.valueOf(res.Body.status);
                    log.Namespace_JATIS__c = icfNT[0].Namespace__c;
                    log.Template_Id_JATIS__c = icfNT[0].Template_ID__c;
                    log.Password_JATIS__c = System.Label.EIP_Jatis_WA_Pass;  
                    log.Username_JATIS__c = System.Label.EIP_Jatis_WA_User;  
                }  
        
                log.method__c = 'Whatsapp';
                log.Division__c = mt.Division__c;
                log.Status__c = 'Send'; 
                log.Send_Flag__c = true;
                log.End_Date__c = System.Today();
                log.Updated_Contact_Flag__c = true;
                log.Request_Date__c = System.today();
                System.debug('***Done call EIP***' + res); 
            } catch (Exception e) {
                log.Status__c = 'Failed';
                log.Description__c = log.Status__c + ': ' + e.getMessage();
                System.debug('***Error EIP***' + e.getMessage());
                System.debug('General Error StackTrace: ' + e.getStackTraceString());
            }
        } 
        else{
            log.Description__c = 'ICF Template Null';
        }
        
        if (log.Status__c != 'Send') {
            log.Status__c = 'Hold';
            log.Send_Flag__c = false; 
        }
        
        update log;
    } 
    
    public class sendWhatsapp implements Queueable {
        private Set<id> logIds;  
        public sendWhatsapp(Set<id> logIds) {
            this.logIds = logIds; 
        }
        
        public void execute(QueueableContext context) {
            // Perform the callout asynchronously
            for (string logId : logIds) { 
                send(logId); 
            }
        } 
    } 
    
    
    public class communication {
        string transactionId {get;set;}
        String status {get;set;}
        
        public void setDataCommunication(EIPJson response) {
            transactionId = response.Body.transactionId;
            status = response.Body.status;
        }
    }
}