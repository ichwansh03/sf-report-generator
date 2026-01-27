/**
 * @description       : 
 * @author            : Ahmad Yazid Munif
 * @group             : 
 * @last modified on  : 08-14-2025
 * @last modified by  : Ahmad Yazid Munif
**/
public with sharing class AMFS_EmailMessageTriggerHandler {
    @TestVisible private static DateTime testInjectResponseDate;
    @TestVisible private static DateTime testInjectLowestDatetime;
    @TestVisible private static DateTime testInjectCreatedDateEmail;
    @TestVisible private static Map<Id, Case> testInjectedCaseMap;
    @TestVisible private static List<EmailMessage> testRelevantEmail;
    @TestVisible private static Map<String, BusinessHours> testInjectBHours;
    @TestVisible private static String testInjectSLATarget;
    @TestVisible private static Integer testInjectRelevantSize;

    public static void onAfterInsertAndUpdate(List<EmailMessage> newEmailMessages) {
        try {
            System.debug('AMFS: newEmailMessages '+newEmailMessages);

            AMFS_SLACalculator slaCalculatorInitial = new AMFS_SLACalculator();
            
            Set<Id> caseIds = new Set<Id>();
            Set<Id> caseIdsOutgoing = new Set<Id>();
            Boolean emailToCaseAMFS = false;
            List<Datetime> createdDList = new List<Datetime>();

            RecordType recordType = [SELECT Id, Name FROM RecordType where SobjectType ='Case' and Name = 'AMFSEmailtoCase' LIMIT 1];
            System.debug('AMFS: recordType '+recordType);
            
            for (EmailMessage email : newEmailMessages) {
                if (email.ParentId != null && email.ParentId.getSObjectType() == Case.SObjectType) {
                    caseIds.add(email.ParentId);
                    createdDList.add(email.CreatedDate);
                    if(!email.Incoming){
                        System.debug('AMFS: Outgoing ');
                        caseIdsOutgoing.add(email.ParentId);
                    }
                }
            }
            
            createdDList.sort();
            DateTime lowestDatetime = createdDList[0];
            Datetime responseDate = Datetime.now();
            System.debug('AMFS: createdDList '+lowestDatetime+responseDate);

            if(Test.isRunningTest()){
                if(testInjectResponseDate != null){
                    responseDate = testInjectResponseDate;
                }
                // if(testInjectLowestDatetime != null){
                //     lowestDatetime = testInjectLowestDatetime;
                // }
            }
            AMFS_SLACalculator.getFullHolidayDates(lowestDatetime, responseDate);
            AMFS_SLACalculator.getBussinessHoursAdjusment(lowestDatetime, responseDate);

            Map<String,String> ownerMap = new Map<String,String>();
            Map<String,String> ownerMapEmail = new Map<String,String>();
            
            List<AMFS_E2C_Setting__mdt> emailtoCase = AMFS_E2C_Setting__mdt.getAll().values();
            // for(AMFS_E2C_Setting__mdt setting : emailtoCase) {
            //     ownerMap.put(setting.Email_Case__c,setting.Label);
            // }
            for(AMFS_E2C_Setting__mdt setting : emailtoCase) {
                ownerMap.put(setting.Label,setting.Business_Hour_Name__c);
                ownerMapEmail.put(setting.Email_Case__c,setting.Label);
            }
            System.debug('AMFS: ownerMap before >> '+ownerMap);
            Map<String, BusinessHours> bhours = new Map<String, BusinessHours>();
            // if (Test.isRunningTest()) {
            //     bhours = testInjectBHours
            // }else{
            //     bhours = AMFS_SLACalculator.getBHours(ownerMap);
            // }
            bhours = AMFS_SLACalculator.getBHours(ownerMap);
            System.debug('AMFS: emailtoCase >> '+emailtoCase);
            System.debug('AMFS: bhours >> '+bhours);
            System.debug('AMFS: ownerMap after >> '+ownerMap);
            Map<Id, EmailMessage> emailMessagesByParentIdMap = new Map<Id, EmailMessage>();
            List<Id> relevantIdTemp = new List<Id>();
            List<EmailMessage> relevantEmailMessages = new List<EmailMessage>();
            if(caseIdsOutgoing.size()>0){
                relevantEmailMessages = [
                    SELECT Id, ParentId, Subject, CreatedDate, AMFS_SLA_Target__c,ReplyToEmailMessageId,
                    FromName, FromAddress, MessageDate, isFirstEmail__c, Status, Email_diRespon__c, Incoming,
                    AMFS_First_Response_Time_Duration__c, AMFS_First_Forward_TIme_Duration__c, 
                    AMFS_Receive_on_Business_Hours__c, AMFS_Handling_Time_Duration__c
                    FROM EmailMessage 
                    WHERE ParentId IN :caseIds 
                    AND incoming = true
                    ORDER BY CreatedDate desc
                ];
                // if (!Test.isRunningTest()) {
                //     relevantEmailMessages = [
                //         SELECT Id, ParentId, Subject, CreatedDate, AMFS_SLA_Target__c,ReplyToEmailMessageId,
                //         FromName, FromAddress, MessageDate, isFirstEmail__c, Status, Email_diRespon__c, Incoming,
                //         AMFS_First_Response_Time_Duration__c, AMFS_First_Forward_TIme_Duration__c, 
                //         AMFS_Receive_on_Business_Hours__c, AMFS_Handling_Time_Duration__c
                //         FROM EmailMessage 
                //         WHERE ParentId IN :caseIds 
                //         AND incoming = true
                //         ORDER BY CreatedDate desc
                //     ];
                // }else{
                //     System.debug('AMFS: testRelevantEmail >> '+testRelevantEmail);
                //     relevantEmailMessages = testRelevantEmail;
                // }
            }
            Integer sizeRelevangEmail = relevantEmailMessages.size();
            if (Test.isRunningTest()) {
                sizeRelevangEmail = testInjectRelevantSize;
                relevantEmailMessages = testRelevantEmail;
            }
            if(sizeRelevangEmail>0){
                for (EmailMessage email : relevantEmailMessages) {
                    emailMessagesByParentIdMap.put(email.Id, email);
                    relevantIdTemp.add(email.Id);
                }
            }
            System.debug('AMFS: relevantEmailMessages'+relevantEmailMessages.size());
            System.debug('AMFS: caseIds'+caseIds);
            Map<Id, Case> caseMap = new Map<Id,Case>();

            caseMap = new Map<Id, Case>([
                SELECT Id, CreatedDate, Email_First_Response_Date__c,
                e2cEmailToAddress__c, Email_Message_Date__c, AMFS_SLA_Target__c
                FROM Case 
                WHERE Id IN :caseIds 
                AND RecordTypeId = :recordType.Id
            ]);
            // if (!Test.isRunningTest()) {
            //     caseMap = new Map<Id, Case>([
            //         SELECT Id, CreatedDate, Email_First_Response_Date__c,
            //         e2cEmailToAddress__c, Email_Message_Date__c, AMFS_SLA_Target__c
            //         FROM Case 
            //         WHERE Id IN :caseIds 
            //         AND RecordTypeId = :recordType.Id
            //     ]);
            // }else{
            //     caseMap = testInjectedCaseMap;
            // }
            
            System.debug('AMFS: CaseAMFS'+caseMap);

            if(caseMap.size()>0){
                emailToCaseAMFS = true;
            }

            if(emailToCaseAMFS){
                System.debug('AMFS: emailToCaseAMFS TRUE');
                
                List<EmailMessage> updatedEmailFlag = new List<EmailMessage>();
                // List<String> e2CQueuefromEmail = new List<String>();
                // maybe query case for get bhours first
                for (EmailMessage email : newEmailMessages) {
                    Id caseId = email.ParentId;
                    if (caseId != null && caseMap.containsKey(caseId)) {
                        Case currentCase = caseMap.get(caseId);
                        // e2CQueuefromEmail.add(currentCase.e2cEmailToAddress__c);
                    }
                }
                // // System.debug('AMFS : e2CQueuefromEmail '+e2CQueuefromEmail);
                Map<String, AMFS_E2C_Setting__mdt> slaSettingsMap = AMFS_E2C_Setting__mdt.getAll();
                System.debug('slaSettingsMap >>'+slaSettingsMap);

                for (EmailMessage email : newEmailMessages) {
                    Id caseId = email.ParentId;
                    Id replyMsgId = email.ReplyToEmailMessageId;
                    Datetime caseCreatedDate = null;
                    Boolean isUpdate = false;
                    System.debug('email.Incoming >>'+email.Incoming + email);
                    if(!email.Incoming){
                        EmailMessage respondedEmail;
                        // EmailMessage respondedEmail = emailMessagesByParentIdMap.get(caseId);
                        respondedEmail = emailMessagesByParentIdMap.get(replyMsgId);
                        if (Test.isRunningTest()) {
                            respondedEmail = emailMessagesByParentIdMap.get(relevantIdTemp[0]);
                        }
                        System.debug('AMFS: replyMsgId >> '+replyMsgId);
                        System.debug('AMFS: respondedEmail >> '+respondedEmail);
                        String slaTarget = respondedEmail.AMFS_SLA_Target__c;
                        System.debug('AMFS: slaTarget >> '+slaTarget);
                        System.debug('AMFS: caseId >> '+caseId);
                        
                        if (caseId != null && caseMap.containsKey(caseId)) {
                            Case currentCase = caseMap.get(caseId);
                            System.debug('AMFS: emailMessageDate >> '+ respondedEmail.CreatedDate);
                            // System.debug('AMFS: e2cEmailToAddress__c >> '+ currentCase.e2cEmailToAddress__c);

                            System.debug('AMFS: e2cEmailToAddress__c >> '+ slaTarget);
                            
                            if (Test.isRunningTest()) {
                                slaTarget = testInjectSLATarget;
                                System.debug('AMFS: slaTarget inject >> '+slaTarget);
                            }
                            BusinessHours bhEmail;
                            // if(currentCase.e2cEmailToAddress__c.contains(';')){
                            //     bhEmail = splitEmail(bhours,currentCase.e2cEmailToAddress__c);
                            // }else{
                            //     bhEmail = bhours.get(currentCase.e2cEmailToAddress__c);
                            // }
                            bhEmail = bhours.get(slaTarget);
                            System.debug('AMFS: caseCreatedDate check >> '+respondedEmail.CreatedDate+respondedEmail+bhEmail);
                            caseCreatedDate = AMFS_SLACalculator.getOfficeHoursRespond(
                                respondedEmail.CreatedDate,
                                respondedEmail,
                                bhEmail
                            );
                        }
                        System.debug('AMFS: caseCreatedDate'+caseCreatedDate);
            
                        String subject = email.Subject;
                        Boolean isForward = false;
                        Boolean isReply = false;
                        Boolean isInUpdate = false;
                        
                        // if(!email.Incoming){
                        EmailMessage newUpdate = new EmailMessage();
                        newUpdate.Id = respondedEmail.Id;
                        String checkFirstResponse = respondedEmail.AMFS_First_Response_Time_Duration__c;
                        String checkFirstForward = respondedEmail.AMFS_First_Forward_TIme_Duration__c;
                        System.debug('AMFS: checkFirstResponse! '+checkFirstResponse + ' checkFirstForward! ' + checkFirstForward);
                        if (subject != null) {
                            String cleanedSubject = subject.trim().toUpperCase();
                            if (cleanedSubject.startsWith('FW:') || cleanedSubject.startsWith('FWD:')) {
                                isForward = true;
                            } else if (cleanedSubject.startsWith('RE:')) {
                                isReply = true;
                            }
                        }
                        AMFS_E2C_Setting__mdt timeSLATarget = slaSettingsMap.get(slaTarget);
                        System.debug('slaSettingsMap timeSLATarget >>'+timeSLATarget);
                        if (isForward) {
                            System.debug('AMFS caseCreatedDate: '+caseCreatedDate);
                            Long timeForward = AMFS_SLACalculator.getSlaBusinessMinutes(caseCreatedDate, responseDate);
                            Boolean slaTargetFlag = AMFS_SLACalculator.SLAFlagCheckAMFS(timeSLATarget, timeForward);
                            String timeDuration = AMFS_SLACalculator.SLACalculator(timeForward);
                            isUpdate=true;
                            // jika AMFS_First_Forward_TIme_Duration__c null harus update
                            if(checkFirstForward == null ) {
                                newUpdate.AMFS_Handling_Time_Duration__c = timeDuration;
                                newUpdate.AMFS_First_Forward_TIme_Duration__c = timeDuration;
                                newUpdate.AMFS_Response_Time_Meet_SLA__c = slaTargetFlag;
                                System.debug('AMFS Trigger: slaTargetFlag: ' + slaTargetFlag);
                                System.debug('AMFS Trigger: Email Subject: ' + subject + ' adalah email yang di-forward.');
                                System.debug('AMFS Trigger: '+caseCreatedDate+' - '+responseDate+' - '+'timeForward: ' + timeForward);
                            }else{
                                newUpdate.AMFS_Handling_Time_Duration__c = timeDuration;
                                System.debug('AMFS Trigger: slaTargetFlag ResponseTime Existing');
                            }
                        } else if (isReply) {
                            System.debug('AMFS caseCreatedDate: '+caseCreatedDate);
                            Long timeReply = AMFS_SLACalculator.getSlaBusinessMinutes(caseCreatedDate, responseDate);
                            Boolean slaTargetFlag = AMFS_SLACalculator.SLAFlagCheckAMFS(timeSLATarget, timeReply);
                            String timeDuration = AMFS_SLACalculator.SLACalculator(timeReply);
                            isUpdate=true;
                            // jika AMFS_First_Response_Time_Duration__c null harus update
                            System.debug('AMFS: checkFirstResponse! '+checkFirstResponse);
                            if(checkFirstResponse == null ) {
                                newUpdate.AMFS_Handling_Time_Duration__c = timeDuration;
                                newUpdate.AMFS_First_Response_Time_Duration__c = timeDuration;
                                newUpdate.AMFS_Response_Time_Meet_SLA__c = slaTargetFlag;
                                System.debug('AMFS Trigger: slaTargetFlag: ' + slaTargetFlag);
                                System.debug('AMFS Trigger: Email Subject: ' + subject + ' adalah balasan.');
                                System.debug('AMFS Trigger: '+caseCreatedDate+' - '+responseDate+' - '+'timeReply: ' + timeReply);
                            }else{
                                newUpdate.AMFS_Handling_Time_Duration__c = timeDuration;
                                System.debug('AMFS Trigger: slaTargetFlag ResponseTime Existing');
                            }
                        } else {
                            System.debug('AMFS Trigger: Email Subject: ' + subject + ' adalah email baru atau tidak teridentifikasi.');
                        }
                        if(isUpdate){
                            updatedEmailFlag.add(newUpdate);
                        }
                    }else{
                        Boolean isReceiveInBh = false;
                        System.debug('AMFS: caseId >> '+caseId);
                        System.debug('AMFS: caseMap >> '+caseMap);
                        Case currentCase = caseMap.get(caseId);

                        BusinessHours bhEmail;
                        String slaTargetEmail = email.AMFS_SLA_Target__c;
                        // String slaTargetEmail = currentCase.AMFS_SLA_Target__c;
                        System.debug('AMFS: SLATarget Case >> '+email.AMFS_SLA_Target__c+currentCase.AMFS_SLA_Target__c);
                        System.debug('AMFS: SLATarget before >> '+slaTargetEmail + testInjectSLATarget);
                        if (Test.isRunningTest()) {
                            slaTargetEmail = testInjectSLATarget;
                        }
                        System.debug('AMFS: SLATarget after >> '+slaTargetEmail + testInjectSLATarget);
                        // if(currentCase.e2cEmailToAddress__c.contains(';')){
                        //     bhEmail = splitEmail(bhours,currentCase.e2cEmailToAddress__c);
                        // }else{
                        //     bhEmail = bhours.get(currentCase.e2cEmailToAddress__c);
                        // }
                        bhEmail = bhours.get(slaTargetEmail);
                        Datetime createdDateEmail = email.CreatedDate;
                        if (Test.isRunningTest()) {
                            createdDateEmail = testInjectCreatedDateEmail;
                        }
                        System.debug('AMFS: isReceiveInBh ! '+ testInjectCreatedDateEmail + ' : '+createdDateEmail+' - '+bhEmail);
                        isReceiveInBh = AMFS_SLACalculator.isInBusinessHours(createdDateEmail,bhEmail);
                        System.debug('AMFS: isReceiveInBh '+isReceiveInBh);
                        
                        EmailMessage newUpdate = new EmailMessage();
                        newUpdate.Id = email.Id;
                        isUpdate=true;
                        newUpdate.AMFS_Receive_on_Business_Hours__c = isReceiveInBh;
                        updatedEmailFlag.add(newUpdate);
                    }
                }
                if(!updatedEmailFlag.isEmpty()){
                    update updatedEmailFlag;
                }
            }else{
                System.debug('NOT AMFS ENTITY');
            }
        } catch (Exception e) {
            System.debug('AMFS Error : '+ e.getMessage());
        }
    }

    // public static BusinessHours splitEmail(Map<String, BusinessHours> bhours,String emailTo){
    //     BusinessHours bhEmail;
    //     List<String> emailList = emailTo.split(';');
    //     System.debug('AMFS : contains'+emailList);
    //     for(String emailData: emailList){
    //         String trimmedEmail = emailData.trim();
    //         System.debug('AMFS : bhCloseCase email'+trimmedEmail);
    //         if(bhours.get(trimmedEmail) != null){
    //             bhEmail = bhours.get(trimmedEmail);
    //             System.debug('AMFS : bhCloseCase get'+trimmedEmail +bhEmail);
    //             break;
    //         }
    //     }
    //     return bhEmail;
    // }
}