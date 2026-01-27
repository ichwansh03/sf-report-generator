public class CaseComplaintViewAttachmentController {
    public List<Attachment> viewAttList {get;set;}
    public String attListStr {get;set;}
    public List<Attachment> viewAttFAList {get;set;}
    public String attFAListStr {get;set;}
    public String caseId {get;set;}
    public String caseExtId {get;set;}
    public String errMessage {get;set;}
    public Boolean isError {get;set;}

    public Double offset {get {
        TimeZone tz = UserInfo.getTimeZone();
        //Milliseconds to Day
        return tz.getOffset(Datetime.now()) / (1000 * 3600 * 24.0);
    }}

    public CaseComplaintViewAttachmentController(ApexPages.StandardController sctrl) {
        caseId = sctrl.getId();
        Case caseObj = CaseComplaintService.getCaseById(caseId);
        caseExtId = caseObj.Case_Id_External__c;
    }

    public PageReference retrieveAttachment() {
        viewAttList = getAttachmentByParentId(caseId);
        attListStr = JSON.serialize(viewAttList).escapeEcmaScript();
        viewAttFAList = CaseComplaintService.callGetAttachments(caseExtId);
        attFAListStr = JSON.serialize(viewAttFAList).escapeEcmaScript();
        return null;
    }

    public List<Attachment> getAttachmentByParentId(String parentId) {
        String q = 'SELECT Id, Name, LastModifiedDate, Parent.Name, LastModifiedBy.Name FROM Attachment WHERE ParentId = :parentId ORDER BY CreatedDate ASC';
        return Database.query(q);
    }

    public PageReference syncAttachments() {
        isError = false;
        PageReference pr = getUpdatedPage();
        try {
            CaseComplaintAPI.SyncAttachmentResponse sar = CaseComplaintService.callSyncAttachments(caseExtId);
            if (sar != null && sar.success) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.CONFIRM, 'Synced. Please allow from 1-2 minutes for your changes to take effect on the server'));
            }
            else {
                isError = true;
                errMessage = String.isNotBlank(errMessage) ? errMessage + '. ' + sar.errors.toString() : sar.errors.toString();
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, errMessage));
            }
            pr = null;
        }
        catch (Exception e) {
            isError = true;
            String rBodyStr = CaseComplaintService.rstr;
            String methodStr = CaseComplaintService.mstr;
            String endpointStr = CaseComplaintService.estr;
            errMessage = String.isNotBlank(errMessage) ? errMessage + '. ' + e.getMessage() + '. ' + e.getStackTraceString() : e.getMessage() + '. ' + e.getStackTraceString();
            errMessage = String.isNotBlank(errMessage) ? errMessage + '. Endpoint: ' + methodStr + ' ' + endpointStr : 'Endpoint: ' + methodStr + ' ' + endpointStr;
            errMessage = String.isNotBlank(errMessage) ? errMessage + '. Response Body: ' + rBodyStr : 'Response Body: ' + rBodyStr;
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, errMessage));
            pr = null;
        }
        return pr;
    }

    public PageReference getUpdatedPage() {
        PageReference pr = Page.CaseComplaintViewAttachment;
        pr.getParameters().put('Id', caseId);
        pr.setRedirect(true);
        return pr;
    }
}