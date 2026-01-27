@RestResource(urlMapping='/Cases/v1/complaint/*')
global with sharing class RestCaseComplaint {
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
    private final static String CASE_TYPE_COMPLAINT = 'Complaint';
    private final static String CASE_ORIGIN = 'Web';
    private final static String RECORD_TYPE_COMPLAINT_AMFS_CASE = 'AMFSComplaintCase';
    private final static String RECORD_TYPE_COMPLAINT_AFI_CASE = 'AFIComplaintCase';
    
    @HttpPost
    global static CaseWrapper.Response createCaseInquiry(CaseWrapper.Request caseComplaint){
        CaseWrapper.Response response = new CaseWrapper.Response();
        CaseServiceController service = new CaseServiceController();
        Case cs = new Case();
        try{
            cs.Type = CASE_TYPE_COMPLAINT;
            switch on caseComplaint.entity.toUpperCase(){
                when 'AMFS'{
                    cs.RecordTypeId = CCCUtils.getRecordTypeCaseId(RECORD_TYPE_COMPLAINT_AMFS_CASE);
                }
                when 'AFI'{
                    cs.RecordTypeId = CCCUtils.getRecordTypeCaseId(RECORD_TYPE_COMPLAINT_AFI_CASE);
                }
                when else {
                    response.status = STATUS_FAILURE_ENTITY;
                    response.message = MESSAGE_FAILURE_ENTITY;
                    return response;
                }
            }
            cs.ContactId = CCCUtils.getContactIdByPolicyNo(caseComplaint.policyNo,caseComplaint.entity.toUpperCase());
            if(String.isEmpty(cs.ContactId)){
                response.status = STATUS_FAILURE_ENTITY;
                response.message = MESSAGE_FAILURE_ENTITY;
                return response;
            }
            cs.Status = caseComplaint.Status;
            cs.Priority = caseComplaint.priority;
            cs.Origin = caseComplaint.origin;
            cs.Case_Type_Config__c = caseComplaint.caseTypeConfig;
            cs.CHS_Status__c = caseComplaint.chsStatus;
            cs.Pending_Status__c = caseComplaint.pendingStatus;
            cs.Sub_Status__c = caseComplaint.subStatus;
            cs.Service_Type__c = caseComplaint.serviceType;
            cs.Subject = caseComplaint.subject;
            cs.Nature_Config__c = caseComplaint.natureConfig;
            cs.Customer__c = caseComplaint.customer;
            cs.Category_Config__c = caseComplaint.categoryConfig;
            cs.Customer_type__c = caseComplaint.customerType;
            cs.Business_channel__c = caseComplaint.businessChannel;
            cs.Complainant__c = caseComplaint.complainant;
            cs.Channel__c = caseComplaint.channel;
            cs.Received_date__c = caseComplaint.receivedDate != null ? CCCUtils.strToDate(caseComplaint.receivedDate,'yyyymmdd') : null;
            cs.Complaint_type__c = caseComplaint.complaintType;
            cs.Product__c = caseComplaint.product;
            cs.Description__c = caseComplaint.description;
            cs.Lampiran__c = caseComplaint.lampiran;
            cs.Back_Office_PIC__c = caseComplaint.backOffice;
            cs.Appeal__c = caseComplaint.appeal;
            cs.Region__c = caseComplaint.region;
            cs.Related_ticket__c = caseComplaint.relatedTicket;
            cs.Other_Information__c = caseComplaint.otherInformation;
            cs.Case_Error__c = caseComplaint.caseError;
            cs.Complaint__c = caseComplaint.complaint;
            cs.Demand__c = caseComplaint.demand;
            cs.Chronological__c = caseComplaint.chronological;
            cs.Financial_Lost__c = caseComplaint.financialLost != null ? Decimal.valueOf(caseComplaint.financialLost) : null;
            cs.Financial_Lost_Currency__c = caseComplaint.financialLostCurrency;
            cs.Reason_Root_Cause__c = caseComplaint.reasonRootCause;
            cs.Corrective_Action__c = caseComplaint.correctiveAction;
            cs.Recommendation__c = caseComplaint.recommendation;
            cs.accountId = caseComplaint.accountId;
            cs.createdbyId = UserInfo.getUserId();
            cs.Objek_Pertanggungan__c = caseComplaint.objekPertanggungan;
            cs.Jenis_Pertanggungan__c = caseComplaint.jenisPertanggungan;
            cs.Tanggal_Assign__c = caseComplaint.tanggalAssign != null ? CCCUtils.strToDate(caseComplaint.tanggalAssign,'yyyymmdd') : null;
            cs.Bengkel__c = caseComplaint.bengkel;
            cs.Lokasi_Survey__c = caseComplaint.lokasiSurvey;
            cs.PIC_Surveyor__c = caseComplaint.picSurveyor;
            cs.COB__c = caseComplaint.cob;
            cs.Received_Party__c = caseComplaint.receivedParty;
            cs.Activity_Log__c = caseComplaint.activityLog;
            cs.Complaint_Resume__c = caseComplaint.complaintResume;
            cs.Progress_Action__c = caseComplaint.progressAction;
            cs.ParentId = caseComplaint.parentId;
            cs.Negative_Feedback__c = caseComplaint.negativeFeedback;
            cs.NonPP__c = caseComplaint.nonPP;
            cs.Product_AFI__c = caseComplaint.productAFI;
            cs.Line_Queue__c = caseComplaint.lineQueue;
            
            Case resultCase = service.processComplaintCollectiveSave(cs, caseComplaint.entity, caseComplaint.idCaseInquiry);
            response.caseId = resultCase.ID;
            response.CaseNumber = CCCUtils.getCaseNumberByCaseId(resultCase.ID);
            response.status = STATUS_SUCCESS;
            response.message = CREATE_MESSAGE_SUCCESS;
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