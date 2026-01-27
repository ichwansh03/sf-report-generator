public with sharing class CreateEmailSmsLogQueue implements Queueable, Database.AllowsCallouts {
    private Case caseObj{get;set;}
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
    
    private static integer totalCall =  0;
    
    // Added by Support MII at 03 24 
    private static final String RECORD_TYPE_QUALTRICS = 'Master - Qualtrics';
    
    public CreateEmailSmsLogQueue(Case caseParam) {
        this.caseObj = caseParam;
    }
    
    public void execute(QueueableContext qc) {
        
        system.debug('case in'+caseObj);
        
        EmailSmsLogUtil emailSmsLogutil = new EmailSmsLogUtil();
        
        system.debug('caseObj.MOT__c:'+caseObj.MOT__c);
        system.debug('caseObj.Entity__c:'+caseObj.Entity__c);
        // updated by Support MII at 03 24 
        String recordTypeICF = caseObj.MOT__c != null && caseObj.Entity__c == 'AMFS' ? RECORD_TYPE_QUALTRICS : RECORD_TYPE_EMAIL_SMS;
        String recordTypeCCC = caseObj.MOT__c != null && caseObj.Entity__c == 'AMFS' ? RECORD_TYPE_QUALTRICS : MASTER_CCC;
        
        system.debug('recordTypeICF:'+recordTypeICF);
        system.debug('Entity:'+caseObj.Entity__c);
        
        ICF_Parameter__c icfParamObj = emailSmsLogutil.getICFParamByRecordType(recordTypeICF, caseObj.Entity__c); 
        ICF_Parameter__c icfParamCCC = emailSmsLogutil.getICFParamByRecordType(recordTypeCCC, caseObj.Entity__c);
        
        system.debug('icfParamObj:'+icfParamObj);
        system.debug('icfParamCCC:'+icfParamCCC );
        CreateEmailSmsLogQueueChild caseQueueNext = new CreateEmailSmsLogQueueChild(caseObj);
        totalCall += 1;
        system.debug('icfParamObj:'+icfParamObj);
        system.debug('Already_Send_Survey__c:'+caseObj.Already_Send_Survey__c);
        if (icfParamObj != null && caseObj.Already_Send_Survey__c == false) {
            Contact contactObj = emailSmsLogutil.getContactFromCase(caseObj);
            system.debug('contactObj:'+contactObj);
            if (contactObj != null) {
                //thanks note
                Boolean isAllowThanksNote = icfParamObj.Send_Thanks_Note_Flag__c;
                //icf
                Boolean isAllowICF = icfParamObj.Send_ICF_Flag__c;
                
                //Case created & closed
                if ( (caseObj.Status != null ? caseObj.Status.equals(CLOSED) : false) || (caseObj.CHS_Status__c != null ? caseObj.CHS_Status__c.equals(CLOSE_INVALID) : false) || (caseObj.CHS_Status__c != null ? caseObj.CHS_Status__c.equals(CLOSE_VALID) : false) ) {
                    if ( (caseObj.Type != null ? caseObj.Type.equals(INQUIRY) : false) || (caseObj.Case_Type__c != null ? caseObj.Case_Type__c.equals('Request_Claim_Payment') : false) ) {
                        
                        system.debug('MASUK QUEUE INQUIRY & REQUEST');
                        if (isAllowThanksNote == true && isAllowICF == true) {
                            emailSmsLogutil.saveIcfTnInsert(caseObj, contactObj, icfParamObj, icfParamCCC, INQUIRY, CLOSED);
                            if (!Test.isRunningTest()) {
                                System.enqueueJob(caseQueueNext);
                            }
                        }
                        //insert tn created-closed (tn) inquiry
                        else if (isAllowThanksNote == true && isAllowICF == false) {
                            emailSmsLogutil.saveTnInsert(caseObj, contactObj, icfParamObj, icfParamCCC, INQUIRY, CLOSED);
                            if (!Test.isRunningTest()) {
                                System.enqueueJob(caseQueueNext);
                            }
                        }
                        //insert icf created-closed (icf) inquiry
                        else if (isAllowThanksNote == false && isAllowICF == true) {
                            emailSmsLogutil.saveIcfInsert(caseObj, contactObj, icfParamObj, icfParamCCC, INQUIRY, CLOSED);
                            if (!Test.isRunningTest()) {
                                System.enqueueJob(caseQueueNext);
                            }
                        }
                    }
                    if (caseObj.Type != null ? caseObj.Type.equals(COMPLAINT) : false) {
                        system.debug('MASUK QUEUE COMPLAINT');
                        if (isAllowThanksNote == true && isAllowICF == true) {
                            emailSmsLogutil.saveIcfTnInsert(caseObj, contactObj, icfParamObj, icfParamCCC, COMPLAINT, CLOSED);
                            if (!Test.isRunningTest()) {
                                System.enqueueJob(caseQueueNext);
                            }
                        }
                        //insert tn created-notclosed (tn) inquiry
                        else if (isAllowThanksNote == true && isAllowICF == false) {
                            emailSmsLogutil.saveTnInsert(caseObj, contactObj, icfParamObj, icfParamCCC, COMPLAINT, CLOSED);
                            if (!Test.isRunningTest()) {
                                System.enqueueJob(caseQueueNext);
                            }
                        }
                        //insert icf created-notclosed (-) inquiry
                        else if (isAllowThanksNote == false && isAllowICF == true) {
                            emailSmsLogutil.saveIcfInsert(caseObj, contactObj, icfParamObj, icfParamCCC, COMPLAINT, CLOSED);
                            if (!Test.isRunningTest()) {
                                System.enqueueJob(caseQueueNext);
                            }
                        }
                    }
                }
                //Case created & not closed
                else {
                    if ( (caseObj.Type != null ? caseObj.Type.equals(INQUIRY) : false) || (caseObj.Case_Type__c != null ? caseObj.Case_Type__c.equals('Request_Claim_Payment') : false)) {
                        //insert icf_tn created-notclosed (tn) inquiry
                        if (isAllowThanksNote == true && isAllowICF == true) {
                            emailSmsLogutil.saveIcfTnInsert(caseObj, contactObj, icfParamObj, icfParamCCC, INQUIRY, OPEN);
                            if (!Test.isRunningTest()) {
                                Id jobid = System.enqueueJob(caseQueueNext);
                                system.debug('job id queueable inquiry: '+jobid);
                            }
                        }
                        //insert tn created-notclosed (tn) inquiry
                        else if (isAllowThanksNote == true && isAllowICF == false) {
                            emailSmsLogutil.saveTnInsert(caseObj, contactObj, icfParamObj, icfParamCCC, INQUIRY, OPEN);
                            if (!Test.isRunningTest()) {
                                System.enqueueJob(caseQueueNext);
                            }
                        }
                        //insert icf created-notclosed (-) inquiry
                        else if (isAllowThanksNote == false && isAllowICF == true) {
                            emailSmsLogutil.saveIcfInsert(caseObj, contactObj, icfParamObj, icfParamCCC, INQUIRY, OPEN);
                            if (!Test.isRunningTest()) {
                                System.enqueueJob(caseQueueNext);
                            }
                        }
                    }
                }
            }
        }

    }
    
    
}