@RestResource(urlMapping='/Cases/v1/Request/*')
global with sharing class RestCaseRequest {
    private final static String STATUS_SUCCESS = '00';
    private final static String CREATE_MESSAGE_SUCCESS = 'Success created case';
    private final static String DELETE_MESSAGE_SUCCESS = 'Success delete case';
    private final static String STATUS_FAILURE_ENTITY = '01';
    private final static String MESSAGE_FAILURE_ENTITY = 'invalid entity';
    private final static String STATUS_FAILURE_POLICY = '02';
    private final static String MESSAGE_FAILURE_POLICY = 'policy not found';
    private final static String STATUS_FAILURE_DELETE = '03';
    private final static String MESSAGE_FAILURE_DELETE = 'No Case Found';
    private final static String STATUS_FAILURE_UNIDENTIFIED = '500';
    private final static String CASE_TYPE_REQUEST = 'Request';
    private final static String CASE_ORIGIN = 'Web';
    private final static String RECORD_TYPE_REQUEST_AMFS_CASE = 'RequestAMFSCase';
    private final static String RECORD_TYPE_REQUEST_AFI_CASE = 'RequestAFICase';
    @HttpPost
    global static CaseWrapper.Response createCaseInquiry(CaseWrapper.Request caseRequest){
        System.debug('starting create case request...');
        CaseWrapper.Response response = new CaseWrapper.Response();
        CaseServiceController service = new CaseServiceController();
        try{
            Case cs = new Case();
            cs.Type = CASE_TYPE_REQUEST;
            system.debug('entity : '+ caseRequest.entity);
            switch on caseRequest.entity.toUpperCase(){
                when 'AMFS'{
                    cs.RecordTypeId = CCCUtils.getRecordTypeCaseId(RECORD_TYPE_REQUEST_AMFS_CASE);
                }
                when 'AFI'{
                    cs.RecordTypeId = CCCUtils.getRecordTypeCaseId(RECORD_TYPE_REQUEST_AFI_CASE);
                }
                when else {
                    response.status = STATUS_FAILURE_ENTITY;
                    response.message = MESSAGE_FAILURE_ENTITY;
                    return response;
                }
            }
            system.debug('Record Type ID : '+cs.RecordTypeId);
            cs.Description = caseRequest.description;
            cs.Status = caseRequest.status;
            cs.Subject = caseRequest.subject;
            cs.Courier__c = caseRequest.courier;
            cs.General_Attitude__c = caseRequest.customerMood;
            cs.Origin = caseRequest.origin;
            cs.Service_Type__c = caseRequest.serviceType;
            cs.Case_Type_Config__c = caseRequest.caseTypeConfig;
            cs.Waktu_Kejadian__c = caseRequest.waktuKejadian;
            cs.Detail_of_Claim_Damage__c = caseRequest.detailOfClaimDamage;
            cs.Accident_Place_Claim__c   = caseRequest.accidentPlaceClaim;
            cs.Lokasi_Survey__c = caseRequest.lokasiSurvey;
            cs.Coverage__c = caseRequest.coverage;
            cs.Bengkel__c = caseRequest.bengkel;
            cs.Driver_of_claim__c  = caseRequest.driverOfClaim;
            cs.Vehicle_Registration_Number__c = caseRequest.vehicleRegNumber;
            cs.Internal_Comment__c = caseRequest.internalComment;
            cs.accountId = caseRequest.accountId;
            cs.createdbyId = UserInfo.getUserId();
            cs.ParentId = caseRequest.parentId;
            system.debug('policy no : '+caseRequest.policyNo );
            cs.ContactId = CCCUtils.getContactIdByPolicyNo(caseRequest.policyNo,caseRequest.entity.toUpperCase());
            system.debug('contact id : '+cs.ContactId );
            if(String.isEmpty(cs.ContactId)){
                response.status = STATUS_FAILURE_POLICY;
                response.message = MESSAGE_FAILURE_POLICY;
                return response;
            }
            cs.Negative_Feedback__c = caseRequest.negativeFeedback;
            cs.NonPP__c = caseRequest.nonPP;
            cs.Account_Number__c = caseRequest.accountNumber != null ? Decimal.valueOf(caseRequest.accountNumber) : null;
            cs.Follow_Debit_Date__c = caseRequest.followDebitDate != null || !String.isEmpty(caseRequest.followDebitDate)  ? CCCUtils.strToDate(caseRequest.followDebitDate,'yyyymmdd') : null;
            cs.Follow_Hold_Date__c = caseRequest.followHoldDate != null || !String.isEmpty(caseRequest.followHoldDate) ? CCCUtils.strToDate(caseRequest.followHoldDate,'yyyymmdd'): null;
            cs.Amount_to_be_Debited__c = caseRequest.amountToBeDebited != null ? Decimal.valueOf(caseRequest.amountToBeDebited) : null;
            cs.TS_Send_To__c = caseRequest.tsSendTo;
            cs.TS_Period_From__c = caseRequest.tsPeriodForm != null || !String.isEmpty(caseRequest.tsPeriodForm) ? CCCUtils.strToDate(caseRequest.tsPeriodForm,'yyyymmdd') : null;
            cs.Product_AFI__c = caseRequest.productAFI;
            cs.Line_Queue__c = caseRequest.lineQueue;
            cs.Already_Send_Survey__c = caseRequest.dontSendICF;
            Case resultCase = service.processRequestSave(cs, caseRequest.entity);
            response.caseId = resultCase.ID;
            response.CaseNumber = CCCUtils.getCaseNumberByCaseId(resultCase.ID);
            response.status = STATUS_SUCCESS;
            response.message = CREATE_MESSAGE_SUCCESS;
            system.debug('done');
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