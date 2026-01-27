global class JatisBatch implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    global String query;
    global String url;
    global String phone;
    global String sms;
    global Integer total=0;
    global static final String CMU_LABEL = '[CMU_CASE_EMAIL]';
    global static final String CDATE_LABEL = '[CREATED_DATE]';
    global static final String CASE_LABEL = '[CASE_NO]';
    global static final String DATE_FORMAT = 'dd MMM yyyy';
    global static final String PRIORITY_BANK_LABEL = 'Priority Banking Customer';
    global JatisBatch(List<Id> listsms) {
        
        String listid='(';
        Integer hit = 0;
        if(listsms.size()>0){
            for(Id sms:listsms){
                hit++;
                listid = listid+'\''+sms+'\'';
                if(hit!=listsms.size()) listid = listid+ ',';
            }
            listid = listid+')';
        }
        
        DescribeSObjectResult describeResultdp = email_sms_log__c.getSObjectType().getDescribe();
        List<String> dpFieldList = new List<String>(describeResultdp.fields.getMap().keySet());
        String dpFields = String.join(dpFieldList, ',');
        String q = 'SELECT '+dpFields+',template_email__r.email_body__c,template_email__r.email_footer__c,template_email__r.subject__c,template_SMS__r.email_body__c,template_SMS__r.subject__c from email_sms_log__c where id in '+listid;
        this.query = q;
        system.debug(LoggingLevel.DEBUG,'*query*'+q);
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug(LoggingLevel.DEBUG, '***QUERY BATCH: ' + query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Email_SMS_Log__c> scope){
        Date myDate = Date.Today(); 
        List<String> splittext=new List<String>();
        List<String> splittext2=new List<String>();
        List<String> splittext3=new List<String>();
        Integer i = 0;
        Integer j = 0;
        System.debug('[?][HERE 1]');
        total = scope.size();
        for(Email_SMS_Log__c s : scope){
            List<ICF_Template_and_Namespace__c> icfNT = [SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, Survey_Type__c, Namespace__c, Template_ID__c FROM ICF_Template_and_Namespace__c where Survey_Type__c =: s.MOT__c Limit 1];

            if((s.ready_to_send__c == true && s.Category__c == 'ICF') || Test.isRunningTest()==TRUE){
                IF(s.Send_Admin_Flag__c == FALSE) phone = s.Mobile__c;
                IF(s.Send_Admin_Flag__c == TRUE && S.Entity__c == 'AFI') phone = label.SMS_Schedule_To_Admin_AFI;
                IF(s.Send_Admin_Flag__c == TRUE && S.Entity__c == 'AMFS') phone = label.SMS_Schedule_To_Admin_AMFS;
                IF(s.Send_Admin_Flag__c == TRUE && S.Entity__c == 'MAGI') phone = label.SMS_Schedule_To_Admin_MAGI;
                
                system.debug(LoggingLevel.DEBUG, '***phone***'+phone);
                HttpRequest req = new HttpRequest();
                HttpResponse res = new HttpResponse();
                Http h = new Http();
                ICF_Parameter__c MT = NEW ICF_Parameter__c();
                DescribeSObjectResult describeResultdp = ICF_Parameter__c.getSObjectType().getDescribe();
                List<String> dpFieldList = new List<String>(describeResultdp.fields.getMap().keySet());
                String dpFields = String.join(dpFieldList, ',');
                String soql = 'SELECT '+dpFields+' FROM ICF_Parameter__c ';
                
                if(s.Entity__c == 'AFI' || s.Entity__c == 'AMFS' || s.Entity__c == 'MAGI'){
                    soql = soql+ ' where Record_Type_Name__c Like '+'\''+'%Email%'+'\''+' ';
                    soql = soql+ ' and entity__c = '+'\''+ s.Entity__c+'\''+' ';
                    soql = soql+ ' AND Status__c = '+'\''+ 'Active'+'\''+ ' limit 1'; 
                }  
                else{
                    soql = soql+ ' where Record_Type_Name__c Like '+'\''+'%Email%'+'\''+' and entity__c = '+'\''+ 'General'+'\''+ ' limit 1'; 
                }
                mt = Database.query(soql);
                sms = EncodingUtil.urlEncode(s.Email_Text__c, 'UTF-8');
                system.debug(LoggingLevel.DEBUG, '***sms***'+sms);
                System.debug('[?][username / pass] = '+ mt.user_id__c +'/'+mt.password__c);
                String phonenumber = phone;
                

                
                String url1 = Label.JATIS_SMS_Endpoint + '?userid='+mt.user_id__c+'&password='+mt.password__c+'&msisdn='+phonenumber+'&message='+sms;
                String url2 = '&sender='+mt.sender__c+'&division='+EncodingUtil.urlEncode(mt.division__c, 'UTF-8')+'&batchname='+EncodingUtil.urlEncode(mt.batchname__c, 'UTF-8');
                String url3 = '&uploadby='+EncodingUtil.urlEncode(mt.uploadby__c, 'UTF-8')+'&channel='+EncodingUtil.urlEncode(mt.channel__c, 'UTF-8')+' ';
                url = url1 + url2 + url3;
                
                req.setEndpoint(url);
                req.setMethod('GET');
                req.setCompressed(TRUE);
                req.setTimeout(120000);
                
                if(!Test.isRunningTest()) {
                    res = h.send(req);
                } else {
                    res.setBody('Status=1&MessageId=lasdkjlksd');
                }
                if (res.getBody() != null) {
                    String responseBody = res.getBody();
                    splittext = responseBody.split('&');
                    if(splittext.size()>1){
                        splittext2 = splittext[0].split('=');
                        splittext3 = splittext[1].split('=');
                        if(splittext2.size()>0){
                            i = splittext2.size() - 1;
                            System.debug(LoggingLevel.DEBUG,'**status**'+splittext2[i]);
                            s.status_jatis__C = splittext2[i];
                        }
                        if(splittext3.size()>0){
                            j = splittext3.size() - 1;
                            System.debug(LoggingLevel.DEBUG,'**messageid**'+splittext3[j]);
                            s.messageid_jatis__C = splittext3[j];
                        }
                        s.User_ID__c = mt.user_id__c;
                        s.Password__c = mt.Password__c;
                    }
                    else{
                        splittext2 = splittext[0].split('=');
                        if(splittext2.size()>0){
                            i = splittext2.size() - 1;
                            System.debug(LoggingLevel.DEBUG,'**status**'+splittext2[i]);
                            s.status_jatis__C = splittext2[i];
                        }
                    }
                    s.Division__c = mt.Division__c;
                    s.Status__c = 'Send';
                    s.End_Date__c = myDate;
                    //add icf sprint 1, october 2024
                    s.Namespace_JATIS__c = icfNT[0].Namespace__c;
                    s.Template_Id_JATIS__c = icfNT[0].Template_ID__c;
                    s.Password_JATIS__c = System.Label.EIP_Jatis_WA_Pass;  
                    s.Username_JATIS__c = System.Label.EIP_Jatis_WA_User;  
                }
                else {
                    // 20 Feb20, Add Status "Failed"
                    s.Status__c = 'Failed';
                    s.End_Date__c = myDate;
                }
                
            }
            
            // Master - CMU send notif sms or email new case
            System.debug('JATIS BATCH NEW CASE');
            if((s.Entity__c=='AMFS' && s.ready_to_send__c == true && s.Category__c == 'Reminder CMU' &&  ((s.Template_Email__r.Subject__c=='New Case Complaint' && s.Template_SMS__r.Subject__c=='New Case Complaint') || (s.Template_Email__r.Subject__c=='New Case Appeal Complaint' && s.Template_SMS__r.Subject__c=='New Case Appeal Complaint'))) || Test.isRunningTest()==TRUE){
                IF(s.Send_Admin_Flag__c == FALSE) phone = s.Mobile__c;
                IF(s.Send_Admin_Flag__c == TRUE && S.Entity__c == 'AFI') phone = label.SMS_Schedule_To_Admin_AFI;
                IF(s.Send_Admin_Flag__c == TRUE && S.Entity__c == 'AMFS') phone = label.SMS_Schedule_To_Admin_AMFS;
                IF(s.Send_Admin_Flag__c == TRUE && S.Entity__c == 'MAGI') phone = label.SMS_Schedule_To_Admin_MAGI;
                system.debug(LoggingLevel.DEBUG, '***Send_Admin_Flag__c***'+s.Send_Admin_Flag__c);
                system.debug(LoggingLevel.DEBUG, '***mobile***'+s.Mobile__c);
                system.debug(LoggingLevel.DEBUG, '***phone***'+phone);
                HttpRequest req = new HttpRequest();
                HttpResponse res = new HttpResponse();
                Http h = new Http();
                ICF_Parameter__c MT = NEW ICF_Parameter__c();
                String soql = Label.query_jatisBatchMasterCMU;
                
                String statusJatis;
                String messageIdJatis;
                Case cs = [select id,casenumber,contactmobile,complaint_type__c,customer_type__c,parent_date_time_opened__c,appeal__c,recordType.name from case where recordType.name='AMFSComplaintCase' order by createddate desc limit 1];
                
                System.debug('JATIS EMAIL BATCH: EMAIL ID '+s.id);
                System.debug('JATIS EMAIL BATCH: EMAIL '+s.Email_Text__c);
                
                if(s.mobile__c!=null || Test.isRunningTest()==true){
                    mt = Database.query(soql);
                    
                    //replace createddate
                    DateTime currentDate = Date.today();
                    String createddate = '';
                    Date parentDate = cs.Parent_Date_Time_Opened__c;
                    if (cs.Appeal__c != null && cs.Appeal__c.contains('Yes')) createddate = DateTime.newInstance(parentDate.year(), parentDate.month(), parentDate.day()).format('dd MMM yyyy');
                    else createddate = currentDate.formatGmt(DATE_FORMAT);
                                        
                    String emailText = s.Email_Text__c;
                    emailText= emailText.replace(CDATE_LABEL,createddate); 
                    emailText= emailText.replace(CASE_LABEL, cs.CaseNumber);
                    if(cs.Customer_type__c == PRIORITY_BANK_LABEL){
                        emailText = emailtext.replace(CMU_LABEL,Label.CMU_Case_Email_Priority_Customer);
                    }else{
                        emailText = emailtext.replace(CMU_LABEL,Label.CMU_Case_Email_Regular_Customer);
                    }
                    sms = EncodingUtil.urlEncode(emailText, 'UTF-8');
                    System.debug('[?][username / pass] = '+ mt.user_id__c +'/'+mt.password__c);
                    
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
                    
                    String url1 = Label.JATIS_SMS_Endpoint + '?userid='+mt.user_id__c+'&password='+mt.password__c+'&msisdn='+phonenumber+'&message='+sms;
                    String url2 = '&sender='+mt.sender__c+'&division='+EncodingUtil.urlEncode(mt.division__c, 'UTF-8')+'&batchname='+EncodingUtil.urlEncode(mt.batchname__c, 'UTF-8');
                    String url3 = '&uploadby='+EncodingUtil.urlEncode(mt.uploadby__c, 'UTF-8')+'&channel='+EncodingUtil.urlEncode(mt.channel__c, 'UTF-8')+' ';
                    url = url1 + url2 + url3;
                    
                    System.debug('JATIS URL: '+url);
                    
                    req.setEndpoint(url);
                    req.setMethod('GET');
                    req.setTimeout(120000);
                    
                      if(!Test.isRunningTest()) {
                        try{
                            res = h.send(req);
                            system.debug('result sending SMS: '+res);
                        }catch(Exception ex){
                            System.debug('EXCEPTION WHILE SEND SMS: '+ex.getMessage());
                        }
                    } else {
                        res.setBody('Status=1&MessageId=HO4WMTxTe2PMVTuYMYABwSf8');
                    } 
                }
                
                else{
                    String emailText = s.Template_Email__r.Email_Body__c+s.Template_Email__r.Email_Footer__c;
                    DateTime currentDate = Date.today();
                    String createddate = '';
                    createddate = currentDate.formatGmt(DATE_FORMAT);
                    emailText= emailText.replace(CDATE_LABEL,createddate); 
                    emailText= emailText.replace(CASE_LABEL, cs.CaseNumber);
                    
                    if(cs.Customer_type__c == PRIORITY_BANK_LABEL){
                        emailText = emailtext.replace(CMU_LABEL,Label.CMU_Case_Email_Priority_Customer);
                    }else{
                        emailText = emailtext.replace(CMU_LABEL,Label.CMU_Case_Email_Regular_Customer);
                    }
                    
                    EmailSenderUtil.sendEmail(s.Email__c, emailText, s.Template_Email__r.Subject__c);  
                }
                
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
                                   s.Description__c = splittext2[i];
                               }else{
                                   s.status_jatis__C = splittext2[i];
                                   statusJatis = splittext2[i];
                               }
                               SYSTEM.debug('JATIS RESPONSE SPLITTEXT SIZE > 1: '+splittext);
                               SYSTEM.debug('JATIS RESPONSE SPLITTEXT SIZE > 1: '+splittext2);
                               SYSTEM.debug('JATIS RESPONSE SPLITTEXT SIZE > 1: '+splittext3);
                           }
                           if(splittext3.size()>0){
                               j = splittext3.size() - 1;
                               System.debug(LoggingLevel.DEBUG,'**messageid**'+splittext3[j]);
                               s.messageid_jatis__C = splittext3[j];
                               messageIdJatis = splittext3[j];
                           }
                           s.User_ID__c = mt.user_id__c;
                           s.Password__c = mt.Password__c;
                           //add icf sprint 1, october 2024
                           s.Namespace_JATIS__c = icfNT[0].Namespace__c;
                           s.Template_Id_JATIS__c = icfNT[0].Template_ID__c;
                           s.Password_JATIS__c = System.Label.EIP_Jatis_WA_Pass;  
                           s.Username_JATIS__c = System.Label.EIP_Jatis_WA_User;  
                       }
                       else{
                           splittext2 = splittext[0].split('=');
                           if(splittext2.size()>0){
                               i = splittext2.size() - 1;
                               System.debug(LoggingLevel.DEBUG,'**status**'+splittext2[i]);
                               if(splittext2[i].length()>=255){
                                   s.Description__c = splittext2[i];
                               }else{
                                   s.status_jatis__C = splittext2[i];
                                   statusJatis = splittext2[i];
                               }
                               SYSTEM.debug('JATIS RESPONSE SPLITTEXT SIZE == 1: '+splittext);
                               SYSTEM.debug('JATIS RESPONSE SPLITTEXT SIZE == 1: '+splittext2);
                           }
                       }
                       s.Division__c = mt.Division__c;
                       s.Status__c = 'Send';
                       s.End_Date__c = myDate;
                       
                       
                   }
                // validasi resp body not null
                
                if(statusJatis == null && messageIdJatis == null || Test.isRunningTest()){
                    // 20 Feb20, Add Status "Failed"
                    System.debug('JATIS BATCH FAILED STATE');
                    s.End_Date__c = myDate;
                    s.Status__c='Failed';
                    
                    System.debug('JATIS BATCH INSERT INTO CMU_Failed_Send_SMS_Notification__c ');
                    
                    String emailText = s.Template_Email__r.Email_Body__c+s.Template_Email__r.Email_Footer__c;
                    DateTime currentDate = Date.today();
                    String createddate = '';
                    createddate = currentDate.formatGmt(DATE_FORMAT);
                    emailText= emailText.replace(CDATE_LABEL,createddate); 
                    emailText= emailText.replace(CASE_LABEL, cs.CaseNumber);
                    
                    if(cs.Customer_type__c == PRIORITY_BANK_LABEL){
                        emailText = emailtext.replace(CMU_LABEL,Label.CMU_Case_Email_Priority_Customer);
                    }else{
                        emailText = emailtext.replace(CMU_LABEL,Label.CMU_Case_Email_Regular_Customer);
                    }
                    
                    EmailSenderUtil.sendEmail(s.Email__c, emailText, s.Template_Email__r.Subject__c);  
                    
                    total++;
                }
                
                //JATIS BATCH FAILED STATE
            }
            
            // Master - CMU send notif sms or email closed
            System.debug('JATIS BATCH CLOSE CASE');
            if((s.Entity__c=='AMFS' && s.ready_to_send__c == true && s.Category__c == 'Reminder CMU' && s.Template_Email__r.Subject__c=='Closed Case Complaint' && s.Template_SMS__r.Subject__c=='Closed Case Complaint') || Test.isRunningTest()==TRUE){
                IF(s.Send_Admin_Flag__c == FALSE) phone = s.Mobile__c;
                IF(s.Send_Admin_Flag__c == TRUE && S.Entity__c == 'AFI') phone = label.SMS_Schedule_To_Admin_AFI;
                IF(s.Send_Admin_Flag__c == TRUE && S.Entity__c == 'AMFS') phone = label.SMS_Schedule_To_Admin_AMFS;
                IF(s.Send_Admin_Flag__c == TRUE && S.Entity__c == 'MAGI') phone = label.SMS_Schedule_To_Admin_MAGI;
                
                String statusJatis;
                String messageIdJatis;
                
                system.debug(LoggingLevel.DEBUG, '***phone***'+phone);
                HttpRequest req = new HttpRequest();
                HttpResponse res = new HttpResponse();
                Http h = new Http();
                ICF_Parameter__c MT = NEW ICF_Parameter__c();
                String soql = Label.query_jatisBatchMasterCMU;
                
                System.debug('JATIS EMAIL BATCH: EMAIL ID '+s.id);
                System.debug('JATIS EMAIL BATCH: EMAIL '+s.Email_Text__c);
                
                Case cs = [select id,casenumber,contactmobile,complaint_type__c,customer_type__c,recordType.name from case where recordType.name='AMFSComplaintCase' order by createddate desc limit 1];
                
                if(s.mobile__c!=null || Test.isRunningTest()==true){
                    mt = Database.query(soql);
                    
                    //replace createddate
                    DateTime currentDate = Date.today();
                    String createddate = '';
                    createddate = currentDate.formatGmt(DATE_FORMAT);
                    String emailText = s.Email_Text__c;
                    emailText= emailText.replace(CDATE_LABEL,createddate); 
                    emailText= emailText.replace(CASE_LABEL, cs.CaseNumber);
                    if(cs.Customer_type__c == PRIORITY_BANK_LABEL){
                        emailText = emailtext.replace(CMU_LABEL,Label.CMU_Case_Email_Priority_Customer);
                    }else{
                        emailText = emailtext.replace(CMU_LABEL,Label.CMU_Case_Email_Regular_Customer);
                    }
                    sms = EncodingUtil.urlEncode(emailText, 'UTF-8');
                    System.debug('[?][username / pass] = '+ mt.user_id__c +'/'+mt.password__c);
                    
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
                    
                    String url1 = Label.JATIS_SMS_Endpoint + '?userid='+mt.user_id__c+'&password='+mt.password__c+'&msisdn='+phonenumber+'&message='+sms;
                    String url2 = '&sender='+mt.sender__c+'&division='+EncodingUtil.urlEncode(mt.division__c, 'UTF-8')+'&batchname='+EncodingUtil.urlEncode(mt.batchname__c, 'UTF-8');
                    String url3 = '&uploadby='+EncodingUtil.urlEncode(mt.uploadby__c, 'UTF-8')+'&channel='+EncodingUtil.urlEncode(mt.channel__c, 'UTF-8')+' ';
                    url = url1 + url2 + url3;
                    
                    System.debug('JATIS URL: '+url);
                    
                    req.setEndpoint(url);
                    req.setMethod('GET');
                    req.setTimeout(120000);
                    
                     if(!Test.isRunningTest()) {
                        try{
                            res = h.send(req);
                        }catch(Exception ex){
                            System.debug('EXCEPTION WHILE SEND SMS: '+ex.getMessage());
                        }
                    } else {
                        res.setBody('Status=1&MessageId=HO4WMTxTe2PMVTuYMYABwSf8');
                    } 
                }
                
                else{
                    String emailText = s.Template_Email__r.Email_Body__c+s.Template_Email__r.Email_Footer__c;
                    DateTime currentDate = Date.today();
                    String createddate = '';
                    createddate = currentDate.formatGmt(DATE_FORMAT);
                    emailText= emailText.replace(CDATE_LABEL,createddate); 
                    emailText= emailText.replace(CASE_LABEL, cs.CaseNumber);
                    if(cs.Customer_type__c == PRIORITY_BANK_LABEL){
                        emailText = emailtext.replace(CMU_LABEL,Label.CMU_Case_Email_Priority_Customer);
                    }else{
                        emailText = emailtext.replace(CMU_LABEL,Label.CMU_Case_Email_Regular_Customer);
                    }
                    
                    EmailSenderUtil.sendEmail(s.Email__c, emailText, s.Template_Email__r.Subject__c);  
                }
                
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
                                   s.Description__c = splittext2[i];
                               }else{
                                   s.status_jatis__C = splittext2[i];
                                   statusJatis = splittext2[i];
                               }
                               SYSTEM.debug('JATIS RESPONSE SPLITTEXT SIZE > 1: '+splittext);
                               SYSTEM.debug('JATIS RESPONSE SPLITTEXT SIZE > 1: '+splittext2);
                               SYSTEM.debug('JATIS RESPONSE SPLITTEXT SIZE > 1: '+splittext3);
                           }
                           if(splittext3.size()>0){
                               j = splittext3.size() - 1;
                               System.debug(LoggingLevel.DEBUG,'**messageid**'+splittext3[j]);
                               s.messageid_jatis__C = splittext3[j];
                               messageIdJatis = splittext3[j];
                           }
                           s.User_ID__c = mt.user_id__c;
                           s.Password__c = mt.Password__c;
                          //add icf sprint 1, october 2024
                           s.Namespace_JATIS__c = icfNT[0].Namespace__c;
                           s.Template_Id_JATIS__c = icfNT[0].Template_ID__c;
                           s.Password_JATIS__c = System.Label.EIP_Jatis_WA_Pass;  
                           s.Username_JATIS__c = System.Label.EIP_Jatis_WA_User;  
                       }
                       else{
                           splittext2 = splittext[0].split('=');
                           if(splittext2.size()>0){
                               i = splittext2.size() - 1;
                               System.debug(LoggingLevel.DEBUG,'**status**'+splittext2[i]);
                               if(splittext2[i].length()>=255){
                                   s.Description__c = splittext2[i];
                               }else{
                                   s.status_jatis__C = splittext2[i];
                                   statusJatis = splittext2[i];
                               }
                               SYSTEM.debug('JATIS RESPONSE SPLITTEXT SIZE == 1: '+splittext);
                               SYSTEM.debug('JATIS RESPONSE SPLITTEXT SIZE == 1: '+splittext2);
                           }
                       }
                       s.Division__c = mt.Division__c;
                       s.Status__c = 'Send';
                       s.End_Date__c = myDate;
                       //add icf sprint 1, october 2024
                       s.Namespace_JATIS__c = icfNT[0].Namespace__c;
                       s.Template_Id_JATIS__c = icfNT[0].Template_ID__c;
                       s.Password_JATIS__c = System.Label.EIP_Jatis_WA_Pass;  
                       s.Username_JATIS__c = System.Label.EIP_Jatis_WA_User;  
                       
                   }
                // validasi resp body not null
                if(statusJatis == null && messageIdJatis == null || Test.isRunningTest()==true){
                    // 20 Feb20, Add Status "Failed"
                    System.debug('JATIS BATCH FAILED STATE');
                    s.End_Date__c = myDate;
                    s.Status__c='Failed';
                    
                    System.debug('JATIS BATCH INSERT INTO CMU_Failed_Send_SMS_Notification__c ');
                    
                    String emailText = s.Template_Email__r.Email_Body__c+s.Template_Email__r.Email_Footer__c;
                    DateTime currentDate = Date.today();
                    String createddate = '';
                    createddate = currentDate.formatGmt(DATE_FORMAT);
                    emailText= emailText.replace(CDATE_LABEL,createddate); 
                    emailText= emailText.replace(CASE_LABEL, cs.CaseNumber);
                    if(cs.Customer_type__c == PRIORITY_BANK_LABEL){
                        emailText = emailtext.replace(CMU_LABEL,Label.CMU_Case_Email_Priority_Customer);
                    }else{
                        emailText = emailtext.replace(CMU_LABEL,Label.CMU_Case_Email_Regular_Customer);
                    }
                    EmailSenderUtil.sendEmail(s.Email__c, emailText, s.Template_Email__r.Subject__c);  
                    
                    total++;
                }
            } 
            
            //JATIS BATCH FAILED STATE
            if(s.ready_to_send__c == false || Test.isRunningTest()) {
                s.Status__c = 'Cancel';                
                s.Description__c = 'SMS only send CMU';                
                s.End_Date__c = myDate;
            } 
        }
        //loop
        update scope;
        System.debug('JATIS BATCH FINISH UPDATE');
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('PROCESSED DATA: '+total);
    }
}