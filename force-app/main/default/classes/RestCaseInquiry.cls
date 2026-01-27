@RestResource(urlMapping='/Cases/v1/inquiry/*')
global with sharing class RestCaseInquiry {
    private final static String STATUS_SUCCESS = '00';
    private final static String MESSAGE_SUCCESS = 'Success created case';
    private final static String STATUS_FAILURE_ENTITY = '01';
    private final static String MESSAGE_FAILURE_ENTITY = 'invalid entity';
    private final static String STATUS_FAILURE_POLICY = '02';
    private final static String MESSAGE_FAILURE_POLICY = 'policy not found';
    private final static String STATUS_FAILURE_UNIDENTIFIED = '09';
    private final static String CASE_TYPE_INQUIRY = 'Inquiry';
    private final static String RECORD_TYPE_INQUIRY_AMFS_CASE = 'InquiryAMFSCase';
    private final static String RECORD_TYPE_INQUIRY_AFI_CASE = 'InquiryAFICase';
	@HttpPost
    global static CaseWrapper.Response createCaseInquiry(CaseWrapper.Request caseInquiry){
        CaseWrapper.Response response = new CaseWrapper.Response();
        CaseServiceController service = new CaseServiceController();
        try{
            Case cs = new Case();
            cs.type = CASE_TYPE_INQUIRY;
            switch on caseInquiry.entity.toUpperCase(){
                when 'AMFS'{
                    cs.RecordTypeId = CCCUtils.getRecordTypeCaseId(RECORD_TYPE_INQUIRY_AMFS_CASE);
                }
                when 'AFI'{
                    cs.RecordTypeId = CCCUtils.getRecordTypeCaseId(RECORD_TYPE_INQUIRY_AFI_CASE);
                }
                when else {
                    response.status = STATUS_FAILURE_ENTITY;
                    response.message = MESSAGE_FAILURE_ENTITY;
                    return response;
                }
            }
            cs.Description = caseInquiry.description;
            cs.NonPP__c = caseInquiry.nonPP;
            cs.Subject = caseInquiry.subject;
            system.debug('policy no :'+caseInquiry.policyNo);
            cs.ContactId = CCCUtils.getContactIdByPolicyNo(caseInquiry.policyNo,caseInquiry.entity.toUpperCase());
            if(String.isEmpty(cs.ContactId)){
                response.status = STATUS_FAILURE_ENTITY;
                response.message = MESSAGE_FAILURE_ENTITY;
                return response;
            }
            cs.Origin = caseInquiry.origin;
            cs.General_Attitude__c = caseInquiry.customerMood;
            cs.Status = caseInquiry.status;
            List<Case> resultCases = service.processInquirySave(cs, new String[]{caseInquiry.caseType});
            response.status = STATUS_SUCCESS;
            response.message = MESSAGE_SUCCESS;
            response.caseId = resultCases[0].ID;
            response.caseNumber = resultCases[0].CaseNumber;
        }catch(Exception ex){
            system.debug(ex);
            system.debug(ex.getCause());
            system.debug(ex.getStackTraceString());
            response.status = STATUS_FAILURE_UNIDENTIFIED;
            response.message = ex.getMessage();
            response.stackTrace = ex.getStackTraceString();
        }
        
        return response;
    }
}