global class JatisWhatsappBatch implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts {
    global String query;
    global String url;
    global String phone;
    global String whatsapp;
    global JatisWhatsappBatch(List<Id> listWhatsapp) {
        
        String listid='(';
        Integer hit = 0;
        if(listWhatsapp.size()>0){
            for(Id wa:listWhatsapp){
                hit++;
                listid = listid+'\''+wa+'\'';
                if(hit!=listWhatsapp.size()) listid = listid+ ',';
            }
            listid = listid+')';
        }
       
        DescribeSObjectResult describeResultdp = email_sms_log__c.getSObjectType().getDescribe();
        List<String> dpFieldList = new List<String>(describeResultdp.fields.getMap().keySet());
        String dpFields = String.join(dpFieldList, ',');
        String q = 'SELECT '+dpFields+' from email_sms_log__c where id in '+listid;
        this.query = q;
        system.debug(LoggingLevel.DEBUG,'*query*'+q);
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug(LoggingLevel.DEBUG, '***QUERY BATCH: ' + query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Email_SMS_Log__c> scope){
        Date MyDate = Date.Today(); //+ 7;
        String phone2='';
        String phone3='';
        List<String> splittext=new List<String>();
        List<String> splittext2=new List<String>();
        List<String> splittext3=new List<String>();
        Integer i = 0;
        Integer j = 0;
        System.debug('[?][HERE 1]');
        for(Email_SMS_Log__c s : scope){
            //Boolean istest = true;
            System.debug('***ready_to_send__c***' + s.ready_to_send__c);
            System.debug('***Category***' + s.Category__c);
            System.debug('***Is Test?***' + Test.isRunningTest());
            if((s.ready_to_send__c == true && s.Category__c == 'ICF') || Test.isRunningTest()==TRUE || s.Category__c == 'BookingCall'){
                IF(s.Send_Admin_Flag__c == FALSE) phone = s.Mobile__c;
                IF(s.Send_Admin_Flag__c == TRUE && S.Entity__c == 'AMFS') phone = label.SMS_Schedule_To_Admin_AMFS;
                system.debug(LoggingLevel.DEBUG, '***phone***'+phone);
                
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
                String soql = 'SELECT '+dpFields+' FROM ICF_Parameter__c ';
                soql = soql+ ' where Record_Type_Name__c Like '+'\''+'%Email%'+'\''+' ';
                soql = soql+ ' and entity__c = '+'\''+ s.Entity__c+'\''+' ';
                soql = soql+ ' AND Status__c = '+'\''+ 'Active'+'\''+ ' limit 1'; 
                
                mt = Database.query(soql);
                system.debug('s.MOT__c ---> ' + s.MOT__c );
                List<ICF_Template_and_Namespace__c> icfNT = [SELECT Id, OwnerId, IsDeleted, Name, CreatedDate,
                                                             CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp,
                                                             Survey_Type__c, Namespace__c, Template_ID__c FROM ICF_Template_and_Namespace__c
                                                             where Survey_Type__c =: s.MOT__c Limit 1];
                String templateId;
                String nameSpace;
                
                if (icfNT.size() > 0){
                    templateId = icfNT[0].Template_ID__c;
                    nameSpace = icfNT[0].Namespace__c;
                }
                String phonenumber = phone;
                try {
                    Map<String, String> properties = new Map<String, String>();
                    properties.put(EIPConstant.WA_TEMPLATE_ID, templateId);
                    properties.put(EIPConstant.WA_NAMESPACE, nameSpace);
                    properties.put(EIPConstant.WA_CUSTOMER_NAME, s.Contact_Name__c);
                    properties.put(EIPConstant.WA_PHONE_TO, phonenumber);
                    if (s.Category__c != 'BookingCall'){
                        properties.put(EIPConstant.WA_SURVEY_URL_LINK, s.Bitly__c);
                        system.debug('s.Bitly__c '+s.Bitly__c);
                        properties.put(EIPConstant.WA_CUSTOMER_SERVICE, s.MOT_in_Email__c);
                    } else {
                        properties.put(EIPConstant.WA_CATEGORY, s.Category__c);
                        properties.put(EIPConstant.WA_POLICY_NUMBER, s.Policy_No__c);
                        if (s.Campaign_Type__c =='Collection-Withdrawal'){
                            properties.put(EIPConstant.WA_SUBMISSION_TYPE, 'Penarikan Dana Sebagian Unit');
                        } else{
                            properties.put(EIPConstant.WA_SUBMISSION_TYPE, 'Penutupan Polis');
                        }
                        
                    }
                    
                    //properties.put(EIPConstant.WA_CUSTOMER_SERVICE, 'EMAIL TEST BOOKING CALL');
                    //system.debug('s.MOT_in_Email__c '+s.MOT_in_Email__c);
                    properties.put(EIPConstant.WA_CUSTOMER_GENDER, s.Contact_Gender__c);
                    
                    EIPJson res = EIPConnector.sendCommunicationMessageWhatsapp(EIPConstant.OPERATION_SEND_WHATSAPP, EIPConstant.ENTITY_AMFS, EIPConstant.APP_JATIS, properties);
                    
                    system.debug('res:'+res);
                    system.debug('send whatsapp');
                    
                    String resBody = JSON.serialize(res.Body);
        Integer resBodySize = resBody.length();
        system.debug('resBodySize  '+ resBodySize);
        system.debug(resBody.substring(0, 149));
        system.debug(resBody.substring(149, 299));
        system.debug(resBody.substring(299, 449));
        system.debug(resBody.substring(499, 599));
        system.debug(resBody.substring(599, resBodySize));
        system.debug('ini response jatis====================================================================================================================================');
        system.debug('.'); 
                    
                    
                    if (res != null) {
                        system.debug('send whatsapp masuk if');
                        //System.debug('***Res messageID Null*** '+res.Body.Customer.haveCommunicatedMessage[0].messageID);
                        //System.debug('***Res channelID Not Null*** '+res.Body.Customer.haveCommunicatedMessage[0].channelID);
                        s.MessageId_JATIS__c = res.Body.Customer.haveCommunicatedMessage[0].channelID;
                        //System.debug('***Res status Not Null*** '+String.valueOf(res.Body.status));
                        s.Status_JATIS__c = String.valueOf(res.Body.status);
                        s.Namespace_JATIS__c = icfNT[0].Namespace__c;
                        s.Template_Id_JATIS__c = icfNT[0].Template_ID__c;
                        s.Password_JATIS__c = System.Label.EIP_Jatis_WA_Pass;  
                        s.Username_JATIS__c = System.Label.EIP_Jatis_WA_User;  
                    }
                    
                    s.Division__c = mt.Division__c;
                    s.Status__c = 'Send';
                    s.End_Date__c = MyDate;
                    System.debug('***Done call EIP***' + res);


                } catch (Exception e) {
                    s.Status__c = 'Failed';
                    s.End_Date__c = MyDate;
                    System.debug('***Error EIP***' + e.getMessage());
                }
            }
            else{
                s.Status__c = 'Cancel';                
                s.Description__c = 'WA only send ICF';                
                s.End_Date__c = MyDate;
                System.debug('***');
            }
        }
        update scope;
    }
    
    global void finish(Database.BatchableContext BC){

   }
}