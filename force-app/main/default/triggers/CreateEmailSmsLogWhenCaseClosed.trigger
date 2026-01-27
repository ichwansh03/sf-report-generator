trigger CreateEmailSmsLogWhenCaseClosed on Case (after insert, after update) {
    // ICF Parameter
    private static final String RECORD_TYPE_EMAIL_SMS = 'Master - Email & SMS';
    private static final String MASTER_CCC = 'Master - CCC';
    private static final String CLOSED = 'Closed';
    private static final String CREATED = 'Created';
    private static final String OPEN = 'Open';
    private static final String CUSTOMER = 'Customer';
    private static final String AGENT = 'Agent';
    private static final String CUSTOMER_AGENT = 'Customer & Agent';
    private static final String EMAIL = 'Email';
    private static final String OTHER_EMAIL = 'Other Email';
    //Email Sms Log
    private static final String ICF = 'ICF';
    private static final String THANKS_NOTE = 'Thanks Note';
    private static final String DRAFT = 'Draft';
    private static final String I_ASK = 'I Ask';
    private static final String I_BUY = 'I Buy';
    private static final String I_CLAIM = 'I Claim';
    private static final String I_COMPLAIN = 'I Complain';
    private static final String I_RENEW = 'I Renew';
    private static final String CCC = 'CCC';
    private static final String NON_CCC = 'Non-CCC';
    // Case
    private static final String INQUIRY = 'Inquiry';
    private static final String REQUEST = 'Request';
    private static final String REQUEST_POS = 'Request POS';
    private static final String COMPLAINT = 'Complaint';
    private static final String CUSTOMER_AFI = 'Customer AFI';
    private static final String HELPLINE = 'Helpline';
    private static final String SIMPLE = 'Simple';
    private static final String CLOSE_INVALID = 'Closed - Invalid';
    private static final String CLOSE_VALID = 'Closed - Valid';
    //Survey
    private static final String SURVEY_PUBLIC_SITE = 'survey';
    private static final String TAKE_SURVEY_VF = 'TakeSurvey';
    private static final String MASTER = 'Master';
    private static final String ACTIVE = 'Active';
    
    /*
* INSERT
*/ 
    
    if (Trigger.isInsert) {          
        for (Case caseObj : Trigger.new) { 
            if (caseObj.Type == INQUIRY && !caseObj.isMassUpload__c) {
                system.debug('masuk 1');
                CreateEmailSmsLogQueue caseQueue = new CreateEmailSmsLogQueue(caseObj);
                System.enqueueJob(caseQueue);
            } else {            
                EmailSmsLogUtil emailSmsLogutil = new EmailSmsLogUtil();
                ICF_Parameter__c icfParamObj = emailSmsLogutil.getICFParamByRecordType(RECORD_TYPE_EMAIL_SMS, caseObj.Entity__c);
                ICF_Parameter__c icfParamCCC = emailSmsLogutil.getICFParamByRecordType(MASTER_CCC, caseObj.Entity__c);
                system.debug('#### caseObj icfParamObj:'+icfParamObj);
                system.debug('#### caseObj icfParamCCC:'+icfParamCCC);
                if (icfParamObj != null && !caseObj.isMassUpload__c) { 
                    system.debug('#### caseObj.Already_Send_Survey__c:'+caseObj.Already_Send_Survey__c);
                    if (!caseObj.Already_Send_Survey__c) {
                        Contact contactObj = null;
                        
                        contactObj = emailSmsLogutil.getContactFromCase(caseObj);
                        
                        if (contactObj != null) {
                            //thanks note
                            Boolean isAllowThanksNote = icfParamObj.Send_Thanks_Note_Flag__c;
                            //icf
                            Boolean isAllowICF = icfParamObj.Send_ICF_Flag__c;
                            
                            //Case created & closed
                            if ( caseObj.IsClosed ) {
                                
                                if (caseObj.Type != null ? (caseObj.Type.equals(REQUEST) || caseObj.Type.equals(REQUEST_POS)): false) {
                                    if(caseObj.Case_Type__c == 'Request_Claim_Payment'  || caseObj.Case_Type__c == 'Request_Claim_Payment_Reject'){
                                        //add by mii Sept 2024 for i Claim ICF
                                        CreateEmailSmsLogQueue caseQueue = new CreateEmailSmsLogQueue(caseObj);
                                        System.enqueueJob(caseQueue);
                                        system.debug('masuk Request_Claim_Payment');
                                    }
                                    else{
                                        //insert icf_tn created-closed (icf) request
                                        if (isAllowThanksNote == true && isAllowICF == true) {
                                            emailSmsLogutil.saveIcfTnInsert(caseObj, contactObj, icfParamObj, icfParamCCC, REQUEST, CLOSED);
                                        }
                                        //insert tn created-closed (tn) request
                                        else if (isAllowThanksNote == true && isAllowICF == false) {
                                            emailSmsLogutil.saveTnInsert(caseObj, contactObj, icfParamObj, icfParamCCC, REQUEST, CLOSED);
                                        }
                                        //insert icf created-closed (icf) request
                                        else if (isAllowThanksNote == false && isAllowICF == true) {
                                            emailSmsLogutil.saveIcfInsert(caseObj, contactObj, icfParamObj, icfParamCCC, REQUEST, CLOSED);
                                        }
                                    }
                                }
                                else if (caseObj.Type != null ? caseObj.Type.equals(COMPLAINT) : false) {
                                    Boolean isEligible = false;
                                    if(caseObj.CHS_Status__c == 'Closed - Invalid' || caseObj.CHS_Status__c == 'Closed - Valid'){
                                        if(caseObj.Complaint_Decision_AMFS__c == 'Invalid & Paid') isEligible = true;
                                        if(caseObj.Complaint_Decision_AMFS__c == 'Approve & Paid') isEligible = true;
                                        //Added by Dimas Support MII 21/03/2025
                                        if(caseObj.Complaint_Decision_AMFS__c == 'Invalid & Reject' && caseObj.Entity__c == 'AMFS') isEligible = true;
                                    }
                                    if(isEligible){
                                        CreateEmailSmsLogQueue caseQueue = new CreateEmailSmsLogQueue(caseObj);
                                        System.enqueueJob(caseQueue);
                                    }
                                }
                            }
                            //Case created & not closed
                            else {
                                
                                if (caseObj.Type != null ? caseObj.Type.equals(COMPLAINT) : false) {
                                    //insert icf_tn created-notclosed (tn) request
                                    if (isAllowThanksNote == true && isAllowICF == true) {
                                        emailSmsLogutil.saveIcfTnInsert(caseObj, contactObj, icfParamObj, icfParamCCC, COMPLAINT, OPEN);
                                    }
                                    //insert tn created-notclosed (tn) request
                                    else if (isAllowThanksNote == true && isAllowICF == false) {
                                        emailSmsLogutil.saveTnInsert(caseObj, contactObj, icfParamObj, icfParamCCC, COMPLAINT, OPEN);
                                    }
                                    //insert icf created-notclosed (-) request
                                    else if (isAllowThanksNote == false && isAllowICF == true) {
                                        emailSmsLogutil.saveIcfInsert(caseObj, contactObj, icfParamObj, icfParamCCC, COMPLAINT, OPEN);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        // if Activate_Event_Case is false, trigger has moved to Trigger_CustomizeCase
        system.debug('Case Inqiury Single Call Note for Assessment: '+Trigger.new[Trigger.new.size()-1]);
        Case cs = Trigger.new[Trigger.new.size()-1];
        if (cs.Entity__c == 'AMFS' && cs.Description != null && System.label.Activate_Event_Case == 'true' && cs.Description != 'Claim Status: Cashless') publishCaseAssessment(cs);
        
    }
    /*
* UPDATE
*/ 
    else if (Trigger.isUpdate) {
        system.debug('=== CreateEmailSMSLogWhenCaseClosed Triggered, Not Start');
        
        for (Case caseObj : Trigger.new) {
            system.debug('=== CreateEmailSMSLogWhenCaseClosed Triggered, Start');
            Case old = Trigger.oldMap.get(caseObj.Id);
            Case newcs = Trigger.newMap.get(caseObj.id);
            
            Id socialPostRecTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SocialPost').getRecordTypeId();
            Id socialPostAMFS = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SocialPost-AMFS').getRecordTypeId();
            Id socialPostAFI = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SocialPost-AFI').getRecordTypeId();
            Id socialPostAGI = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SocialPost-AGI').getRecordTypeId();
            Id socialPostMAGI = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SocialPost-MAGI').getRecordTypeId();
            Id emailToCaseALI = Schema.SObjectType.Case.getRecordTypeInfosByName().get('InquiryALICase').getRecordTypeId();
            Id emailToCaseAFI = Schema.SObjectType.Case.getRecordTypeInfosByName().get('InquiryAFICase').getRecordTypeId();
            if(caseObj.recordTypeId == socialPostRecTypeId || caseObj.recordTypeId == socialPostAMFS || caseObj.recordTypeId == socialPostAFI || caseObj.recordTypeId == socialPostAGI || caseObj.recordTypeId == socialPostMAGI || caseObj.Entity_Backup__c == 'AGI' || caseObj.recordTypeId == emailToCaseALI || caseObj.recordTypeId == emailToCaseAFI) { 
                //added by suryono 5-11-2018
            } else {
                Case oldCase = Trigger.oldMap.get(caseObj.Id);
                Boolean diffStatus = false; 
                Boolean diffStatus_CHS = false; 
                
                system.debug('=== VALIDASI caseObj.Status: ' + caseObj.Status + ', oldCase.Status: ' + oldCase.Status);
                system.debug('=== VALIDASI ELSE caseObj.CHS_Status__c: ' + caseObj.CHS_Status__c + ', oldCase.CHS_Status__c: ' + oldCase.CHS_Status__c);
                if (caseObj.Status != null && oldCase.Status != null) {
                    //diffStatus = oldCase.Status.equals(caseObj.Status) ? false : true;
                    diffStatus = true;
                }
                else if (caseObj.CHS_Status__c != null && oldCase.CHS_Status__c != null) {
                    diffStatus = oldCase.CHS_Status__c.equals(caseObj.CHS_Status__c) ? false : true;
                }
                // added by Support MII at 18 09 2024
                // add filtering diffstatus inquiry AMFS
                // bypass generate double ICF
                if (caseObj.Status == 'Closed'  
                    && caseObj.entity__c == 'AMFS' 
                    && caseObj.Type == INQUIRY
                    && diffStatus
                   ) {
                       diffStatus = false;
                   }
                // ended
                
                system.debug('=== VALIDASI diffStatus: ' + diffStatus);
                if (diffStatus) {
                    system.debug('=== VALIDASI caseObj.IsClosed: ' + caseObj.IsClosed + ', caseObj.ManualClosedCase__c: ' + caseObj.ManualClosedCase__c);
                    if ( caseObj.IsClosed && !caseObj.ManualClosedCase__c) {
                        
                        EmailSmsLogUtil emailSmsLogutil = new EmailSmsLogUtil();
                        ICF_Parameter__c icfParamObj = emailSmsLogutil.getICFParamByRecordType(RECORD_TYPE_EMAIL_SMS, caseObj.Entity__c);
                        ICF_Parameter__c icfParamCCC = emailSmsLogutil.getICFParamByRecordType(MASTER_CCC, caseObj.Entity__c);
                       
                        if (caseObj.Type != null ? caseObj.Type.equals(COMPLAINT) : false) {
                            //update icf_tn updated-closed (icf) complain
                            //add for ICF Complain By MII, October 2024
                            Boolean isEligible = false;
                            if(caseObj.CHS_Status__c == 'Closed - Invalid' || caseObj.CHS_Status__c == 'Closed - Valid'){
                                if(caseObj.Complaint_Decision_AMFS__c == 'Invalid & Paid') isEligible = true;
                                if(caseObj.Complaint_Decision_AMFS__c == 'Approve & Paid') isEligible = true;
                                //Added by Dimas Support MII 21/03/2025
                                if(caseObj.Complaint_Decision_AMFS__c == 'Invalid & Reject' && caseObj.Entity__c == 'AMFS') isEligible = true;
                            }
                            system.debug('isEligible Update:'+isEligible);
                            
                            if(isEligible){ 
                                system.debug('=== VALIDASI CreateEmailSMSLogWhenCaseClosedHelper.processedCaseId.contains(caseObj.Id): ' + CreateEmailSMSLogWhenCaseClosedHelper.processedCaseId.contains(caseObj.Id));
                                //Modified by Dimas Support MII 21/03/2025
                                if (!CreateEmailSMSLogWhenCaseClosedHelper.processedCaseId.contains(caseObj.Id)) {
                                    CreateEmailSMSLogWhenCaseClosedHelper.processedCaseId.add(caseObj.Id);
                                    CreateEmailSmsLogQueue caseQueue = new CreateEmailSmsLogQueue(caseObj);
                                    System.enqueueJob(caseQueue);
                                    system.debug('=== Memenuhi Validasi Pembuatan ICF Email SMS Log Complaint');
                                }
                            }
                        }
                        if (icfParamObj != null) {
                            if (caseObj.Already_Send_Survey__c == false) {
                                Contact contactObj = null;
                                if(!System.test.isrunningtest()) contactObj = emailSmsLogutil.getContactFromCase(caseObj);

                                if (contactObj != null || System.test.isrunningtest()) {
                                    //thanks note
                                    Boolean isAllowThanksNote = icfParamObj.Send_Thanks_Note_Flag__c;
                                    //icf
                                    Boolean isAllowICF = icfParamObj.Send_ICF_Flag__c;
                                    
                                    if (caseObj.Type != null ? caseObj.Type.equals(INQUIRY) : false) {
                                        //update icf_tn updated-closed (icf) inquiry
                                        if (isAllowThanksNote == true && isAllowICF == true) {
                                            emailSmsLogutil.saveIcfTnUpdated(caseObj, contactObj, icfParamObj, icfParamCCC, INQUIRY, CLOSED);
                                        }
                                        //update tn updated-closed (tn) inquiry
                                        else if (isAllowThanksNote == true && isAllowICF == false) {
                                            emailSmsLogutil.saveTnUpdated(caseObj, contactObj, icfParamObj, icfParamCCC, INQUIRY, CLOSED);
                                        }
                                        //update icf updated-closed (icf) inquiry
                                        else if (isAllowThanksNote == false && isAllowICF == true) {
                                            emailSmsLogutil.saveIcfUpdated(caseObj, contactObj, icfParamObj, icfParamCCC, INQUIRY, CLOSED);
                                        }
                                    }
                                    else if (caseObj.Type != null ? caseObj.Type.equals(REQUEST) : false) {
                                        if(caseObj.Case_Type__c == 'Request_Claim_Payment' || caseObj.Case_Type__c == 'Request_Claim_Payment_Reject'){
                                            List<Email_SMS_Log__c> listEmail = [select id from Email_SMS_Log__c where Case__c =: caseObj.Id and Entity__c = 'AMFS' 
                                                                                and Category__c = 'ICF' and Status__c = 'Draft'];
                                            Set<Id> emailIds = new Set<Id>();
                                            if(listEmail.size() > 0 &&  ! System.isFuture()){
                                                for(Email_SMS_Log__c EmailLogCheck: listEmail){
                                                    emailIds.add(EmailLogCheck.id);
                                                }
                                                CheckSurveyICFFuture.checkSurveyICF(emailIds);
                                            }
                                        }else{
                                            //update icf_tn updated-closed (icf) request
                                            if (isAllowThanksNote == true && isAllowICF == true) {
                                                emailSmsLogutil.saveIcfTnUpdated(caseObj, contactObj, icfParamObj, icfParamCCC, REQUEST, CLOSED);
                                            }
                                            //update tn updated-closed (tn) request
                                            else if (isAllowThanksNote == true && isAllowICF == false) {
                                                emailSmsLogutil.saveTnUpdated(caseObj, contactObj, icfParamObj, icfParamCCC, REQUEST, CLOSED);
                                            }
                                            //update icf updated-closed (icf) request
                                            else if (isAllowThanksNote == false && isAllowICF == true) {
                                                emailSmsLogutil.saveIcfUpdated(caseObj, contactObj, icfParamObj, icfParamCCC, REQUEST, CLOSED);
                                            }
                                        }   
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }
            
            // if Activate_Event_Case is false, trigger has moved to Trigger_CustomizeCase
            if (caseObj.Entity__c == 'AMFS' && caseObj.Description != NULL && (old.Description != newCs.Description) && System.label.Activate_Event_Case == 'true') publishCaseAssessment(caseObj);
        }
        

    }
    
    public static void publishCaseAssessment(Case cs){
        Assessment_Case__e ac = new Assessment_Case__e();
        ac.Case_ID__c = cs.Id;
        
        Database.SaveResult sr = EventBus.publish(ac);
        
        if (sr.isSuccess()) {
            System.debug('Successfully published event.');
        } else {
            for(Database.Error err : sr.getErrors()) {
                System.debug('Error returned: ' + err.getStatusCode() );
            }
        }
    }
    
    
}