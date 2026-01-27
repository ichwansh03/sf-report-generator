trigger CMUCaseNotificationTrigger on Case (after insert,after update) {
    
    
    if(trigger.isAfter){
        List<ID> listESLog = new List<ID>();
        System.debug('CMUCaseNotificationTrigger');
        String recordTypeName;
        ICF_Parameter__c icfES = new ICF_Parameter__c();
        
        //when case new
        RecordType rt = [SELECT Id,Name FROM RecordType WHERE SobjectType='Case' and Name='AMFSComplaintCase' limit 1];
        Schema.DescribeSObjectResult d = Schema.SObjectType.Case; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = d.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName =  rtMapByName.get(rt.name);
        System.debug('CMUCaseNotificationTrigger INSERT');
        if (trigger.isInsert) {
            for(Case CMUCase: trigger.new){
                
                System.debug('CMUCaseNotificationTrigger LOOP CASE: STATUS: '+CMUCase.Status+', RECORD TYPE NAME: '+CMUCase.RecordTypeId + '|' + CMUCase.RecordType.Name+', COMPLAINT: '+CMUCase.Complaint_type__c+'INSERT');
                if(CMUCase.Status == 'New' && CMUCase.RecordTypeId == rtByName.getRecordTypeId() &&  !Label.SoftComplaint.Contains(CMUCase.Complaint_type__c) && CMUCase.Nature_Config__c!='Policy Duplicate' && CMUCase.Origin!='Walk-In' && ((CMUCase.Appeal__c != null && CMUCase.Appeal__c == '^1Yes') || CMUCase.ParentId == null)){
                    if (CMUCase.ParentId == null) {
                        System.debug('CMUCaseNotificationTrigger CALL QUERY ICF PARAMETER INSERT: NEW CASE PARENT');
                        icfES = [SELECT id, ICF_Email_Template__c, ICF_SMS_Template__c, 
                                 User_ID__c, Password__c, Division__c, Sender__c, Batchname__c, Uploadby__c, Channel__c, 
                                 Login_1__c, API_Key_1__c, Login_2__c, API_Key_2__c, Description__c,
                                 ICF_Method__c, Entity__c, ICF_Email_Template__r.Email_Body__c,ICF_SMS_Template__r.Email_Body__c,
                                 ICF_Email_Template__r.Email_Header__c,ICF_Email_Template__r.Email_Footer__c,ICF_Email_Template__r.subject__c  
                                 FROM ICF_Parameter__c WHERE Record_Type_Name__c = 'Master_CMU' and Entity__c =: CMUCase.Entity__c 
                                 and ICF_Email_Template__r.Subject__c='New Case Complaint' and ICF_SMS_Template__r.Subject__c='New Case Complaint'];                        
                    } else {
                        System.debug('CMUCaseNotificationTrigger CALL QUERY ICF PARAMETER INSERT: NEW CASE CHILD');
                        icfES = [SELECT id, ICF_Email_Template__c, ICF_SMS_Template__c, 
                                 User_ID__c, Password__c, Division__c, Sender__c, Batchname__c, Uploadby__c, Channel__c, 
                                 Login_1__c, API_Key_1__c, Login_2__c, API_Key_2__c, Description__c,
                                 ICF_Method__c, Entity__c, ICF_Email_Template__r.Email_Body__c,ICF_SMS_Template__r.Email_Body__c,
                                 ICF_Email_Template__r.Email_Header__c,ICF_Email_Template__r.Email_Footer__c,ICF_Email_Template__r.subject__c  
                                 FROM ICF_Parameter__c WHERE Record_Type_Name__c = 'Master_CMU' and Entity__c =: CMUCase.Entity__c 
                                 and ICF_Email_Template__r.Subject__c='New Case Appeal Complaint' and ICF_SMS_Template__r.Subject__c='New Case Appeal Complaint'];
                    }
                    
                    Date RequestDate = Date.Today();   
                    
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
                    ESLog.Email__c = CMUCase.ContactEmail;
                    ESLog.Mobile__c = CMUCase.ContactMobile;
                    SYSTEM.debug('CMUCaseNotificationTrigger: EMAIL: '+CMUCase.ContactEmail+', MOBILE: '+CMUCase.ContactMobile+', ENTITY: '+CMUCase.Entity__c+' INSERT');
                    String emailText = '';
                    if(CMUCase.Entity__c=='AMFS' && !Label.SoftComplaint.Contains(CMUCase.Complaint_type__c)){
                        //replace createddate
                        DateTime currentDate = Date.today();
                        String createddate = '';
                        Date parentDate = system.today();
                        if (CMUCase.Parent_Date_Time_Opened__c != null) parentDate = CMUCase.Parent_Date_Time_Opened__c;
                        if (CMUCase.Appeal__c != null && CMUCase.Appeal__c.contains('Yes')) createddate = DateTime.newInstance(parentDate.year(), parentDate.month(), parentDate.day()).format('dd MMM yyyy');
                        else createddate = currentDate.formatGmt('dd MMM yyyy');
                        
                        if(CMUCase.ContactMobile != null){
                            system.debug('CREATED_DATE: '+createddate);
                            ESLog.Method__c='SMS';
                            emailText = icfES.ICF_SMS_Template__r.email_body__c;
                            emailText= emailText.replace('[CREATED_DATE]',createddate); 
                            emailText= emailText.replace('[CASE_NO]', CMUCase.CaseNumber);
                            System.debug('CMUCaseNotificationTrigger SMS: '+emailText+', METHOD: '+ESLog.Method__c+' INSERT');
                        }
                        else {
                            ESLog.Method__c='EMAIL';
                            emailText = icfES.ICF_Email_Template__r.email_body__c+icfES.ICF_Email_Template__r.email_footer__c;
                            SYSTEM.debug('CREATED_DATE: '+createddate);
                            emailText= emailText.replace('[CREATED_DATE]',createddate); 
                            emailText= emailText.replace('[CASE_NO]', CMUCase.CaseNumber);
                            System.debug('CMUCaseNotificationTrigger EMAIL: '+emailText+', METHOD: '+ESLog.Method__c);
                        }
                        
                        ESLog.Email_Text__c = emailText;
                        ESLog.Request_Date__c = RequestDate;
                        ESLog.Start_Date__c = ESLog.Request_Date__c;
                        
                        ESLog.Ready_To_Send__c = true;
                        ESLog.Case__c = CMUCase.id;
                        
                        insert ESLog;
                        System.debug('CMUCaseNotificationTrigger: FINISH INSERT TO ES LOG');
                        
                        listESLog.add(ESLog.Id);
                        System.debug('CMUCaseNotificationTrigger: ID: '+ESLog.Id);
                        System.debug('CMUCaseNotificationTrigger: CREATEDDATE and CASENO: '+ESLog.Email_Text__c+'\n');
                        System.debug('CMUCaseNotificationTrigger: CALL JATIS BATCH INSERT');
                        if (!Test.isRunningTest()) { 
                            JatisBatch runJatisBatch = new JatisBatch(listESLog);
                            Integer offset = Integer.valueOf(Label.runJatisBatchOffset);
                            Database.executeBatch(runJatisBatch, offset); //bikinin label as parameter 
                        }
                    } 
                }  
            } 
            System.debug('CallLineTriggerHelper.firstRun '+CallLineTriggerHelper.firstRun);
        } if(trigger.isUpdate) {
            
            if (Test.isRunningTest()) CallLineTriggerHelper.firstRun = true;
            
            if(CallLineTriggerHelper.firstRun == true) {
                CallLineTriggerHelper.firstRun = false;
                //when case closed
                System.debug('CMUCaseNotificationTrigger UPDATE');
                for(Case CMUCase: trigger.new){
                    System.debug('CMUCaseNotificationTrigger LOOP CASE: STATUS: '+CMUCase.Status+', RECORD TYPE NAME: '+rtByName.getName()+', COMPLAINT: '+CMUCase.Complaint_type__c+' UPDATE');
                    if(CMUCase.Status=='Closed' && CMUCase.RecordTypeId == rtByName.getRecordTypeId() &&  !Label.SoftComplaint.Contains(CMUCase.Complaint_type__c) && CMUCase.Nature_Config__c!='Policy Duplicate' && CMUCase.Origin!='Walk-In' && ((CMUCase.Appeal__c != null && CMUCase.Appeal__c.contains('^1')) || CMUCase.ParentId == null)){
                        // ICF Master_Email_SMS
                        System.debug('CMUCaseNotificationTrigger CALL QUERY ICF PARAMETER UPDATE: CLOSED CASE');
                        System.debug('icfES: ' + CMUCase.Entity__c);
                        
                        
                        icfES = [SELECT id, ICF_Email_Template__c, ICF_SMS_Template__c, 
                                 User_ID__c, Password__c, Division__c, Sender__c, Batchname__c, Uploadby__c, Channel__c, 
                                 Login_1__c, API_Key_1__c, Login_2__c, API_Key_2__c, Description__c,
                                 ICF_Method__c, Entity__c, ICF_Email_Template__r.Email_Body__c,ICF_SMS_Template__r.Email_Body__c,
                                 ICF_Email_Template__r.Email_Header__c,ICF_Email_Template__r.Email_Footer__c,ICF_Email_Template__r.subject__c  
                                 FROM ICF_Parameter__c WHERE Record_Type_Name__c = 'Master_CMU' and Entity__c =: CMUCase.Entity__c 
                                 and ICF_Email_Template__r.Subject__c='Closed Case Complaint' and ICF_SMS_Template__r.Subject__c='Closed Case Complaint'];
                        
                        System.debug('CMUCaseNotificationTrigger: QUERY ICF PARAMETER UPDATE');
                        Date RequestDate = Date.Today();   
                        
                        // insert Email_SMS_Log__c
                        System.debug('CMUCaseNotificationTrigger: INSERT LOG TO ES LOG UPDATE');
                        Email_SMS_Log__c ESLog = new Email_SMS_Log__c();
                        // Information
                        ESLog.Status__c = 'Draft';
                        
                        ESLog.Template_Email__c = icfES.ICF_Email_Template__c;
                        ESLog.Template_SMS__c = icfES.ICF_SMS_Template__c;
                        SYSTEM.debug('CMUCaseNotificationTrigger TEMPLATE EMAIL FROM ICFES UPDATE : '+icfES.ICF_Email_Template__r.Email_Body__c+' , TEMPLATE SMS: '+icfES.ICF_SMS_Template__r.Email_Body__c);
                        SYSTEM.debug('CMUCaseNotificationTrigger TEMPLATE EMAIL FROM ESLOG UPDATE : '+ESLog.Template_Email__r.Email_Body__c+' , TEMPLATE SMS: '+ESLog.Template_SMS__r.Email_Body__c);
                        SYSTEM.debug('CMUCaseNotificationTrigger TEMPLATE EMAIL FROM ICFES 2 UPDATE : '+icfES.ICF_Email_Template__c+' , TEMPLATE SMS: '+icfES.ICF_SMS_Template__c);
                        ESLog.Entity__c = icfES.Entity__c;
                        
                        ESLog.Contact__c = CMUCase.ContactId;
                        
                        ESLog.Category__c = 'Reminder CMU';
                        ESLog.Email__c = CMUCase.ContactEmail;
                        ESLog.Mobile__c = CMUCase.ContactMobile;
                        SYSTEM.debug('CMUCaseNotificationTrigger UPDATE: EMAIL: '+CMUCase.ContactEmail+', MOBILE: '+CMUCase.ContactMobile+', ENTITY: '+CMUCase.Entity__c);
                        String emailText = '';
                        if(CMUCase.Entity__c=='AMFS'){
                            //replace createddate
                            DateTime currentDate = CMUCase.CreatedDate;
                            String createddate = '';
                            createddate = currentDate.formatGmt('dd MMM yyyy');
                            if(CMUCase.ContactMobile != null){
                                ESLog.Method__c='SMS';
                                emailText = icfES.ICF_SMS_Template__r.email_body__c;
                                emailText= emailText.replace('[CREATED_DATE]',createddate); 
                                emailText= emailText.replace('[CASE_NO]', CMUCase.CaseNumber);
                                System.debug('CMUCaseNotificationTrigger SMS UPDATE : '+emailText+', METHOD: '+ESLog.Method__c);
                            }
                            else{
                                ESLog.Method__c='EMAIL';
                                emailText = icfES.ICF_Email_Template__r.email_body__c+icfES.ICF_Email_Template__r.email_footer__c;
                                SYSTEM.debug('CREATEDDATE: '+createddate);
                                emailText= emailText.replace('[CREATED_DATE]',createddate); 
                                emailText= emailText.replace('[CASE_NO]', CMUCase.CaseNumber);
                                System.debug('CMUCaseNotificationTrigger UPDATE EMAIL: '+emailText+', METHOD: '+ESLog.Method__c);
                                System.debug('JATIS BATCH SENDING MAIL UPDATE ');
                            }
                            
                        }
                        
                        ESLog.Email_Text__c = emailText;
                        ESLog.Request_Date__c = RequestDate;
                        ESLog.Start_Date__c = ESLog.Request_Date__c;
                        
                        // tambahin field ready to send  = true
                        ESLog.Ready_To_Send__c = true;
                        ESLog.case__c = CMUCase.id;
                        
                        insert ESLog;
                        System.debug('CMUCaseNotificationTrigger UPDATE: FINISH INSERT TO ES LOG');
                        
                        listESLog.add(ESLog.Id);
                        System.debug('CMUCaseNotificationTrigger UPDATE: ID: '+ESLog.Id);
                        System.debug('CMUCaseNotificationTrigger UPDATE: CREATEDDATE and CASENO: '+ESLog.Email_Text__c+'\n');
                        System.debug('CMUCaseNotificationTrigger UPDATE: CALL JATIS BATCH');
                        if ( ! System.test.isRunningTest()) {
                            JatisBatch runJatisBatch = new JatisBatch(listESLog);
                            Integer offset = Integer.valueOf(Label.runJatisBatchOffset);
                            Database.executeBatch(runJatisBatch, offset); //bikinin label as parameter   
                        }
                        
                    }
                }  
            }
            
            // added by Support MII at 02 12 24
            map<string,case> acceptCases = new map<string,case>();
            map<string,Contact> mapContact = new map<string,Contact>();
            map<string,case> ClosedCases = new map<string,case>();  
            for (Case row: trigger.new) {  
                if (row.Entity__c == 'AFI' && row.Type == 'Complaint') {
                    Case old = Trigger.oldMap.get(row.Id);
                    // added by support mii at 02 12 24
                    if (string.isblank(old.Named_User__c) && old.Named_User__c != row.Named_User__c 
                        && string.isnotblank(row.Entity__c) && row.Entity__c == 'AFI' ) 
                    {
                        acceptCases.put(row.id,row);
                    } else if (string.isnotblank(row.CHS_Status__c)
                               && row.CHS_Status__c != old.CHS_Status__c
                               && row.CHS_Status__c.contains('Closed') 
                               && old.Closed_Date__c == null && row.Closed_Date__c != old.Closed_Date__c
                               && old.ClosedDate == null && row.ClosedDate != old.ClosedDate ) 
                    { 
                        ClosedCases.put(row.id,row);
                    }
                    if (string.isnotblank(row.ContactId)) mapContact.put(row.ContactId,new Contact());
                } 
            }
            
            String labelEmailTemplateAcceptCase = System.label.AFI_CMU_Accept_Case;
            String labelEmailTemplateClosedCase = System.label.AFI_CMU_Closed_Case;
            if (acceptCases.size() > 0 || ClosedCases.size() > 0 ) {
                List<Email_SMS_Template__c> emailTemplate = [SELECT id, Name, Email_Header__c, Email_Body__c, Email_Footer__c, Entity__c
                                          FROM Email_SMS_Template__c WHERE Category__c = 'Reminder CMU' AND ( Name =: labelEmailTemplateAcceptCase OR name =: labelEmailTemplateClosedCase )];
                Map<String, Email_SMS_Template__c> mapEmailTemplate = new Map<String, Email_SMS_Template__c>();
                for (Email_SMS_Template__c row: emailTemplate) {
                    mapEmailTemplate.put(row.name, row);
                }
                
                if (mapContact.size() > 0) {
                    List<Contact> getDataContact = [select id, name, policy_no__c, Email, MobilePhone, LastName 
                                                    from contact where id in :mapContact.keySet()];
                    for (Contact row: getDataContact) {
                        mapContact.put(row.id, row);
                    }
                }
                
                list<Email_SMS_Log__c> InsertESLog = new list<Email_SMS_Log__c>();
                if ( mapEmailTemplate.containskey(labelEmailTemplateAcceptCase) ) { 
                    for (string caseId: acceptCases.keySet()) { 
                        Case detail = acceptCases.get(caseId); 
                        Email_SMS_Log__c ESLog = setEmailLog(detail, mapEmailTemplate.get(labelEmailTemplateAcceptCase), mapContact);  
                        InsertESLog.add(ESLog);
                    }
                }
                
                if ( mapEmailTemplate.containskey(labelEmailTemplateClosedCase) ) { 
                    for (string caseId: ClosedCases.keySet()) { 
                        Case detail = ClosedCases.get(caseId); 
                        Email_SMS_Log__c ESLog = setEmailLog(detail, mapEmailTemplate.get(labelEmailTemplateClosedCase), mapContact);  
                        InsertESLog.add(ESLog);
                    }
                }
                
                if (InsertESLog.size() > 0) insert InsertESLog;
            }
        }
    }
    
    // added by Support MII at 02 12 24
    Public static Email_SMS_Log__c setEmailLog(Case detail, Email_SMS_Template__c template, map<String, Contact> mapContact) {
        Contact getDataContact = new Contact();
        Date currentDate = system.today();        
        
        if (mapContact.containskey(detail.ContactId)) {
            getDataContact = mapContact.get(detail.ContactId);
        }
        
        Email_SMS_Log__c ESLog = new Email_SMS_Log__c(); 
        ESLog.Status__c = 'Send'; 
        
        ESLog.Template_Email__c = template.id;//'a0i0k0000012P2z';
        ESLog.Template_SMS__c = template.id; //'a0i0k0000012P2z';
        ESLog.Entity__c = detail.Entity_Backup__c; 
        
        // Respondent Information
        ESLog.Account__c = detail.AccountId;
        ESLog.Contact__c = detail.Contactid;
        ESLog.Case__c = detail.id;
        ESLog.Contact_Short_Name__c = getDataContact.LastName;
        ESLog.Email__c = getDataContact.Email;
        ESLog.Mobile__c = getDataContact.MobilePhone;
        
        // Instant Customer Feedback Configuration
        ESLog.Category__c = 'Reminder CMU';
        ESLog.Type__c = 'Reminder CMU';
        ESLog.Method__c = 'Email';   
        ESLog.Request_Date__c = currentDate;
        ESLog.Start_Date__c = currentDate; 
        ESLog.End_Date__c = currentDate; 
        ESLog.Ready_To_Send__c = true;
        
        string textbody = '';
        if (string.isnotblank(template.Email_Header__c)) textbody += template.Email_Header__c;
        if (string.isnotblank(template.Email_Body__c)) {
            textbody += template.Email_Body__c;
            string contactname = '';
            string contactpolicyno = '';
            if (String.isnotblank(getDataContact.Name)) {
                contactname = getDataContact.Name;
            }
            if (string.isnotblank(getDataContact.policy_no__c)) {
                contactpolicyno = getDataContact.policy_no__c;
            }
            if (textbody.contains('[CONTACT_NAME]')) textbody = textbody.replace('[CONTACT_NAME]',contactname);
            if (textbody.contains('[POLICY_NO]')) textbody = textbody.replace('[POLICY_NO]',contactpolicyno);
            if (textbody.contains('[CASE_NUMBER]')) textbody = textbody.replace('[CASE_NUMBER]',detail.CaseNumber); 
            
            if (textbody.contains('[CREATEDDATE]')) { 
                string createddateStr = '';
                date createddate = Date.valueof(detail.createddate); 
                createddateStr += createddate.day();
                createddateStr += '-';
                createddateStr += createddate.month();
                createddateStr += '-';
                createddateStr += createddate.year();
                
                
                textbody = textbody.replace('[CREATEDDATE]',createddateStr);
            }  
        }
        if (string.isnotblank(template.Email_Footer__c)) textbody += template.Email_Footer__c;
        
        ESLog.Email_Text__c = textbody;
        eslog.Email_SMS_Length__c = textbody.length();
        return ESLog;
    }
}