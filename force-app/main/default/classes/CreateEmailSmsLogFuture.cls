public class CreateEmailSmsLogFuture {
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
    
	@future(callout=true)
    public static void createCase(Id caseId) {
        DescribeSObjectResult describeResultCase = Case.getSObjectType().getDescribe();
        List<String> caseFieldList = new List<String>(describeResultCase.fields.getMap().keySet());
        String caseFields = String.join(caseFieldList, ',');
        String caseQuery = ' SELECT ' + caseFields + ' FROM Case WHERE Id = :caseId ';
        Case caseObj = Database.query(caseQuery);
        
        EmailSmsLogUtil emailSmsLogutil = new EmailSmsLogUtil();
        ICF_Parameter__c icfParamObj = emailSmsLogutil.getICFParamByRecordType(RECORD_TYPE_EMAIL_SMS, caseObj.Entity__c);
        ICF_Parameter__c icfParamCCC = emailSmsLogutil.getICFParamByRecordType(MASTER_CCC, caseObj.Entity__c);
        
        if (icfParamObj != null) {
            if (caseObj.Already_Send_Survey__c == false) {
                Contact contactObj = emailSmsLogutil.getContactFromCase(caseObj);
                if (contactObj != null) {
                    //thanks note
                    Boolean isAllowThanksNote = icfParamObj.Send_Thanks_Note_Flag__c;
                    //icf
                    Boolean isAllowICF = icfParamObj.Send_ICF_Flag__c;
                    
                    //Case created & closed
                    if ( (caseObj.Status != null ? caseObj.Status.equals(CLOSED) : false) || (caseObj.CHS_Status__c != null ? caseObj.CHS_Status__c.equals(CLOSE_INVALID) : false) || (caseObj.CHS_Status__c != null ? caseObj.CHS_Status__c.equals(CLOSE_VALID) : false) ) {
                        if (caseObj.Type != null ? caseObj.Type.equals(INQUIRY) : false) {
                            //insert icf_tn created-closed (icf) inquiry
                            if (isAllowThanksNote == true && isAllowICF == true) {
                                emailSmsLogutil.saveIcfTnInsert(caseObj, contactObj, icfParamObj, icfParamCCC, INQUIRY, CLOSED);
                            }
                            //insert tn created-closed (tn) inquiry
                            else if (isAllowThanksNote == true && isAllowICF == false) {
                                emailSmsLogutil.saveTnInsert(caseObj, contactObj, icfParamObj, icfParamCCC, INQUIRY, CLOSED);
                            }
                            //insert icf created-closed (icf) inquiry
                            else if (isAllowThanksNote == false && isAllowICF == true) {
                                emailSmsLogutil.saveIcfInsert(caseObj, contactObj, icfParamObj, icfParamCCC, INQUIRY, CLOSED);
                            }
                        }
                    }
                    //Case created & not closed
                    else {
                        if (caseObj.Type != null ? caseObj.Type.equals(INQUIRY) : false) {
                            //insert icf_tn created-notclosed (tn) inquiry
                            if (isAllowThanksNote == true && isAllowICF == true) {
                                emailSmsLogutil.saveIcfTnInsert(caseObj, contactObj, icfParamObj, icfParamCCC, INQUIRY, OPEN);
                            }
                            //insert tn created-notclosed (tn) inquiry
                            else if (isAllowThanksNote == true && isAllowICF == false) {
                                emailSmsLogutil.saveTnInsert(caseObj, contactObj, icfParamObj, icfParamCCC, INQUIRY, OPEN);
                            }
                            //insert icf created-notclosed (-) inquiry
                            else if (isAllowThanksNote == false && isAllowICF == true) {
                                emailSmsLogutil.saveIcfInsert(caseObj, contactObj, icfParamObj, icfParamCCC, INQUIRY, OPEN);
                            }
                        }
                    }
                }
                else {
                    if (!Test.isRunningTest()) {
                        //caseObj.addError('Contact not found');
                    }
                }
            }
        }
        else {
            if (!Test.isRunningTest()) {
                //caseObj.addError('No ICF parameter found');
            }
        }
    }
}