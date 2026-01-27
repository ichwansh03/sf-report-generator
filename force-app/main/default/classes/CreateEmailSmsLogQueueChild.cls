public class CreateEmailSmsLogQueueChild implements Queueable, Database.AllowsCallouts {
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
    private static final String I_ASK_INQUIRY = 'I Ask - Inquiry';
    private static final String CANCEL = 'Cancel';
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
    //Custom Labels
    private static final String CASE_MULTIPLE_INQ = Label.ICF_Cancel_Multiple_Inquiry;
    
    public CreateEmailSmsLogQueueChild(Case caseParam) {
        this.caseObj = caseParam;
    }
    
    public void execute(QueueableContext qc) {
        //this method was intended to update the inquiry if inquiry is more than 1 within single queue action
        //this because when create multiple inquiry in single case form, the queue cannot detect the first inquiry to validate second inquiry
        EmailSmsLogUtil emailSmsLogutil = new EmailSmsLogUtil();
        ICF_Parameter__c icfParamObj = emailSmsLogutil.getICFParamByRecordType(RECORD_TYPE_EMAIL_SMS, caseObj.Entity__c);
        ICF_Parameter__c icfParamCCC = emailSmsLogutil.getICFParamByRecordType(MASTER_CCC, caseObj.Entity__c);
        Contact contactObj = emailSmsLogutil.getContactFromCase(caseObj);
        EmailSmsLogUtil.ICFConfig ic = emailSmsLogutil.initConfig(caseObj, contactObj, icfParamObj, caseObj.Type);
        
        List<Email_SMS_Log__c> eslListEx = [SELECT Id FROM Email_SMS_Log__c WHERE Category__c = :ICF 
                                            AND Contact__c = :contactObj.Id 
                                            AND Survey_Type__c = :I_ASK_INQUIRY
                                            AND Status__c = :DRAFT
                                            AND Request_Date__c <= :ic.pendingDateICF];
        System.debug(LoggingLevel.DEBUG, '***TOTAL ESL QUEUE CHILD: ' + eslListEx.size());
        
        if (eslListEx.size() > 1) {
            Email_SMS_Log__c esl = getICFLog(contactObj, ic);
            Email_SMS_Log__c eslTn = getTnLog(contactObj, ic);
            updateInquiryToCancel(esl);
            updateInquiryToCancelTn(eslTn);
        }
    }
    
    public void updateInquiryToCancel(Email_SMS_Log__c esl) {
        // Taufik, 9 July20, Check jika Null = Skip.
        if (esl != NULL) {
            try {
                esl.Status__c = CANCEL;
                esl.Description__c = CASE_MULTIPLE_INQ;
                esl.Exclude_From__c = 'Multiple inquiry creation';
                update esl;
            } catch (System.NullPointerException e) {

            }
        }
    }
    
    public void updateInquiryToCancelTn(Email_SMS_Log__c esl) {
        // Taufik, 9 July20, Check jika Null = Skip.
        if (esl != NULL) {
            try {
                esl.Status__c = CANCEL;
                esl.Description__c = CASE_MULTIPLE_INQ;
                esl.Exclude_From__c = 'Multiple inquiry creation';
                update esl;
            } catch (System.NullPointerException e) {

            }
        }
    }
    
    public Email_SMS_Log__c getICFLog(Contact contactObj, EmailSmsLogUtil.ICFConfig ic) {
        List<Email_SMS_Log__c> eslList = [SELECT Id FROM Email_SMS_Log__c WHERE Category__c = :ICF 
                                            AND Contact__c = :contactObj.Id 
                                            AND Survey_Type__c = :I_ASK_INQUIRY
                                            AND Case_Number__c = :caseObj.CaseNumber
                                            AND Status__c = :DRAFT
                                            AND Case__r.X2nd_Record__c = TRUE // taufik, hanya yang true, di set Cancel Multi Inquiry.
                                            AND Request_Date__c <= :ic.pendingDateICF
                                            LIMIT 1];
        Email_SMS_Log__c esl = null;
        if (eslList.size() > 0) {
            esl = eslList.get(0);
        }
        return esl;
    }
    
    public Email_SMS_Log__c getTnLog(Contact contactObj, EmailSmsLogUtil.ICFConfig ic) {
        List<Email_SMS_Log__c> eslTnList = [SELECT Id FROM Email_SMS_Log__c WHERE Category__c = :THANKS_NOTE 
                                            AND Contact__c = :contactObj.Id 
                                            AND Survey_Type__c = :THANKS_NOTE
                                            AND Case_Number__c = :caseObj.CaseNumber
                                            AND Status__c = :DRAFT
                                            AND Case__r.X2nd_Record__c = TRUE // taufik, hanya yang true, di set Cancel Multi Inquiry.
                                            AND Request_Date__c <= :ic.pendingDateTn
                                            LIMIT 1];
        Email_SMS_Log__c eslTn = null;
        if (eslTnList.size() > 0) {
            eslTn = eslTnList.get(0);
        }
        return eslTn;
    }
}