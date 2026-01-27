// 24 Feb 2020, For AFI
global class SchCHSReminder Implements Schedulable {
    global void execute(SchedulableContext sc)
    {
        SchCHSReminderAFI();
    }
    
    
    public void SchCHSReminderAFI(){
        
        String labelEmailTemplateAFI1 = System.label.AFI_CMU_Reminder_1;
        String labelEmailTemplateAFI2 = System.label.AFI_CMU_Reminder_2;
        String labelEmailTemplateAFI3 = System.label.AFI_CMU_Reminder_3;
        
        // Email & Template
        string EntityTemp ='';
        map<string,Email_SMS_Template__c> mapest = new map<string,Email_SMS_Template__c>();
        for (Email_SMS_Template__c est : [SELECT id, Name, Email_Header__c, Email_Body__c, Email_Footer__c, Entity__c
                                          FROM Email_SMS_Template__c WHERE Category__c = 'Reminder CMU' AND
                                          (
                                              // Name = 'REMINDER_CMU_ID_AFI_1' OR // comment by support mii at 02 12 24
                                              // Name = 'REMINDER_CMU_ID_AFI_2' OR // comment by support mii at 02 12 24
                                              // Name = 'REMINDER_CMU_ID_AFI_3' OR // comment by support mii at 02 12 24
                                              Name = :labelEmailTemplateAFI1 OR  // added by support mii at 02 12 24 use new templated
                                              Name = :labelEmailTemplateAFI2 OR  // added by support mii at 02 12 24 use new templated 
                                              Name = :labelEmailTemplateAFI3 
                                              /* OR  // added by support mii at 02 12 24 use new templated 
                                              Name = 'REMINDER_CMU_ID_ALI_1' OR 
                                              Name = 'REMINDER_CMU_ID_ALI_2' OR 
                                              Name = 'REMINDER_CMU_ID_ALI_3' */
                                          )
                                          
                                          order by Entity__c]){
                                              
                                              mapest.put(est.Name, est);
                                              
                                          }
        system.debug('mapest: '+mapest);
        
        // Check Reminder H+5
        list<Case> listcs = new list<Case>();
        if (Test.isRunningTest())
            listcs = [SELECT id, Subject, AccountId, ContactId, Contact.LastName, Contact.Email, Contact.MobilePhone, CaseNumber,
                      contact.name,  contact.policy_no__c, 
                      Entity_Backup__c, Age__c, Entity__c,createddate // Reminder_CMU_ID__c, Reminder_CMU_EN__c, 
                      FROM Case 
                      WHERE Status != 'Closed' and Type = 'Complaint' and (Entity_Backup__c = 'AFI' OR Entity_Backup__c = 'ALI') LIMIT 10];
        else 
            listcs = [SELECT id, Subject, AccountId, ContactId, Contact.LastName, Contact.Email, Contact.MobilePhone, CaseNumber, 
                      contact.name,  contact.policy_no__c,  
                      Entity_Backup__c, Age__c, entity__c,createddate // Reminder_CMU_ID__c, Reminder_CMU_EN__c, 
                      FROM Case 
                      WHERE Status != 'Closed' and 
                      Type = 'Complaint'
                      /* 
                        update filter by Support MII 02 12 24
                        ((Age__c >= 5 and Age__c < 6) OR
                        (Age__c >= 15 and Age__c < 16) OR 
                        (Age__c >= 25 and Age__c < 26)) and 
                        Type = 'Complaint' and (Entity_Backup__c = 'AFI' OR Entity_Backup__c = 'ALI') */
                      AND  (
                          /* (
                              (
                                  (Age__c >= 5 and Age__c < 6) OR
                                  (Age__c >= 15 and Age__c < 16) OR 
                                  (Age__c >= 25 and Age__c < 26)
                              )  AND Entity_Backup__c = 'ALI'
                          ) OR */  (
                              (
                                  (Age__c >= 5 and Age__c < 6) OR
                                  (Age__c >= 9 and Age__c < 10) OR 
                                  (Age__c >= 15 and Age__c < 16)
                              )  AND (
                                  Entity_Backup__c = 'AFI'
                                  OR Entity_Backup__c = 'ALI'
                              )	    
                          )
                      )  
                     ];
        system.debug('listcs: '+listcs);
        
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        list<Email_SMS_Log__c> InsertESLog = new list<Email_SMS_Log__c>();
        for (integer i = 0; i < listcs.size(); i++) {
            // comment by Support MII at 02 12 24
            /* IF (listcs[i].Age__c >= 5 && listcs[i].Age__c < 6) est = mapest.get('REMINDER_CMU_ID_AFI_1');
            IF (listcs[i].Age__c >= 15 && listcs[i].Age__c < 16) est = mapest.get('REMINDER_CMU_ID_AFI_2');
            IF (listcs[i].Age__c >= 25 && listcs[i].Age__c < 26) est = mapest.get('REMINDER_CMU_ID_AFI_3');
			*/
             
            // updated by Support MII at 02 12 24
            // update age and get label name template
            if (listcs[i].Entity_Backup__c == 'AFI' || listcs[i].Entity_Backup__c == 'ALI') {
                IF (listcs[i].Age__c >= 5 && listcs[i].Age__c < 6) est = mapest.get(labelEmailTemplateAFI1);
                IF (listcs[i].Age__c >= 9 && listcs[i].Age__c < 10) est = mapest.get(labelEmailTemplateAFI2);
                IF (listcs[i].Age__c >= 15 && listcs[i].Age__c < 16) est = mapest.get(labelEmailTemplateAFI3); 
            }
            
            /* if (listcs[i].Entity_Backup__c == 'ALI') {
                IF (listcs[i].Age__c >= 5 && listcs[i].Age__c < 6) est = mapest.get('REMINDER_CMU_ID_AFI_1');
                IF (listcs[i].Age__c >= 15 && listcs[i].Age__c < 16) est = mapest.get('REMINDER_CMU_ID_AFI_2');
                IF (listcs[i].Age__c >= 25 && listcs[i].Age__c < 26) est = mapest.get('REMINDER_CMU_ID_AFI_3');
            } */
            
            // if (Test.isRunningTest()) est = mapest.get('REMINDER_CMU_ID_AFI_1');
            if (Test.isRunningTest()) est = mapest.get(labelEmailTemplateAFI1);
            
            // insert Email_SMS_Log__c
            Email_SMS_Log__c ESLog = new Email_SMS_Log__c();
            // Information
            ESLog.Status__c = 'Draft';
            //ESLog.MOT__c = nonccc.MOT__c;
            //ESLog.Exclude_From__c = ExcludeFrom;
            
            ESLog.Template_Email__c = est.id;//'a0i0k0000012P2z';
            ESLog.Template_SMS__c = est.id; //'a0i0k0000012P2z';
            ESLog.Entity__c = listcs[i].Entity_Backup__c;
            //ESLog.Insurance_Type__c = nonccc.Insurance_Type__c;
            
            // Respondent Information
            ESLog.Account__c = listcs[i].AccountId;
            ESLog.Contact__c = listcs[i].Contactid;
            ESLog.Case__c = listcs[i].id;
            ESLog.Contact_Short_Name__c = listcs[i].Contact.LastName;
            ESLog.Email__c = listcs[i].Contact.Email;
            ESLog.Mobile__c = listcs[i].Contact.MobilePhone;
            
            // Instant Customer Feedback Configuration
            ESLog.Category__c = 'Reminder CMU';
            ESLog.Type__c = 'Reminder CMU';
            ESLog.Method__c = 'Email';
            if (ESLog.Email__c == NULL) ESLog.Method__c = 'SMS';
            //ESLog.Survey_Type__c = nonccc.MOT__c;
            String contacttxt = '';
            if (ESLog.Contact__c == NULL) contacttxt = 'None';
            else contacttxt = ESLog.Contact__c;
            // if (ESLog.Entity__c  == 'ALI') ESLog.Request_Date__c = date.today()+5;//RequestDate; // added by Support MII at 09 12 24, add condition AFI will be notif today
            // else
            ESLog.Request_Date__c = date.today();//RequestDate;
            ESLog.Start_Date__c = ESLog.Request_Date__c;
            //ESLog.ICF_Non_CCC__c = nonccc.Id;
            //ESLog.Survey_URL__c = '[SURVEY_LINK]';
            
            
            // added by Support MII at 5 12 2024
            string textbody='';
            if (string.isnotblank(est.Email_Header__c)) textbody += est.Email_Header__c;
            if (string.isnotblank(est.Email_Body__c) && ( listcs[i].entity__c == 'AFI' || listcs[i].entity__c == 'ALI') ) {
                textbody += est.Email_Body__c;
                string contactname = '';
                string contactpolicyno = '';
                if (String.isnotblank(listcs[i].contact.Name)) {
                    contactname = listcs[i].contact.Name;
                }
                if (string.isnotblank(listcs[i].contact.policy_no__c)) {
                    contactpolicyno = listcs[i].contact.policy_no__c;
                }
                
                if (textbody.contains('[CONTACT_NAME]')) textbody = textbody.replace('[CONTACT_NAME]',contactname);
                if (textbody.contains('[POLICY_NO]')) textbody = textbody.replace('[POLICY_NO]',contactpolicyno);
                if (textbody.contains('[CASE_NUMBER]'))   textbody = textbody.replace('[CASE_NUMBER]',listcs[i].CaseNumber); 
                
                if (textbody.contains('[CREATEDDATE]')) { 
                    string createddateStr = '';
                    date createddate = Date.valueof(listcs[i].createddate); 
                    createddateStr += createddate.day();
                    createddateStr += '-';
                    createddateStr += createddate.month();
                    createddateStr += '-';
                    createddateStr += createddate.year();
                    
                    
                    textbody = textbody.replace('[CREATEDDATE]',createddateStr);
                }
            }
            if (string.isnotblank(est.Email_Footer__c)) textbody += est.Email_Footer__c;
            ESLog.Send_Flag__c = true;
            ESLog.Email_Text__c = textbody;
            ESLog.Email_SMS_Length__c = textbody.length();
            
            //insert ESLog;
            InsertESLog.add(ESLog);
            // taufik: hide
            //ESLog.Survey_URL__c =
            
        }
        system.debug('InsertESLog: '+InsertESLog);
        if (InsertESLog.size() > 0) insert InsertESLog; system.debug('=======INSERT InsertESLog DONE=======');
        
        //By Daniel, 6 Feb 2020
        String reminderCMUQueueAFI = Label.ReminderCMUQueue_AFI;
        system.debug('Reminder CMU Queue AFI: '+reminderCMUQueueAFI);
        
        Log_Notification__c logNotif = new Log_Notification__c();
        logNotif.Size__c = InsertESLog.size();
        logNotif.Type__c = 'Reminder CMU';
        logNotif.OwnerId = reminderCMUQueueAFI;
        system.debug('logNotif: '+logNotif);
        
        if(InsertESLog.size() > 0){
            insert logNotif;
            system.debug('=======INSERT LogNotif DONE=======');
        }
        
        //return 'Success';
    }
}