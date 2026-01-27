public class CaseReviewController {
    public Case caseObj {get;set;}
    public Case existingCase {get;set;}
    public String caseId {get;set;}

    public Boolean isRequiredReasonText {get;set;}
    public Boolean isRequiredInvalidPaid {get;set;}
    public Boolean isRequiredApprovePaid {get;set;}
    public Boolean isRequiredDrop {get;set;}
    
    public Boolean isRequredCompensationPayment {get;set;}
    public Boolean isRequiredPaid {get;set;}

    public CaseReviewController(ApexPages.StandardController sctrl) {
        caseId = sctrl.getId();
        existingCase = (Case) sctrl.getRecord();
        init();
    }

    public void init() {
        caseObj = CaseComplaintService.getCaseById(caseId);
        clearReview();
    }

    public void clearReview() {
        caseObj.Review_Status__c = '';
        caseObj.Complaint_Decision_AMFS__c = '';
        caseObj.Reason__c = '';
        caseObj.Invalid_Paid__c = '';
        caseObj.Compensation_Payment__c = '';
        caseObj.Paid__c = '';
        caseObj.Approve_Paid__c = '';
        caseObj.Drop__c = '';
        caseObj.Others__c = '';
        caseObj.Conclusion__c = '';
        caseObj.Corrective_Action__c = '';
        caseObj.Loss_Impacted__c = null;
    }

    public PageReference submitReview() {
        PageReference pr = getUpdatedPage();
        try {
            update caseObj;
            clearReview();
        }
        catch (Exception e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'ERROR: ' + e.getMessage() + '. ' + e.getStackTraceString()));
            pr = null;
        }
        return pr;
    }

    public PageReference complaintDecisionOnchange() {
        System.debug('***CaseReviewController complaintDecisionOnchange caseObj.Complaint_Decision_AMFS__c: ' + caseObj.Complaint_Decision_AMFS__c);
        if (caseObj.Complaint_Decision_AMFS__c == 'Invalid & Reject') {
            isRequiredReasonText = true;
            isRequiredInvalidPaid = false;
            isRequiredApprovePaid = false;
            isRequiredDrop = false;
        }
        else if (caseObj.Complaint_Decision_AMFS__c == 'Invalid & Paid') {
            isRequiredReasonText = false;
            isRequiredInvalidPaid = true;
            isRequiredApprovePaid = false;
            isRequiredDrop = false;
        }
        else if (caseObj.Complaint_Decision_AMFS__c == 'Approve & Paid') {
            isRequiredReasonText = false;
            isRequiredInvalidPaid = false;
            isRequiredApprovePaid = true;
            isRequiredDrop = false;
        }
        else if (caseObj.Complaint_Decision_AMFS__c == 'Drop') {
            isRequiredReasonText = false;
            isRequiredInvalidPaid = false;
            isRequiredApprovePaid = false;
            isRequiredDrop = true;
        }
        else {
            isRequiredReasonText = false;
            isRequiredInvalidPaid = false;
            isRequiredApprovePaid = false;
            isRequiredDrop = false;
        }
        System.debug('***CaseReviewController complaintDecisionOnchange isRequiredReasonText: ' + isRequiredReasonText);
        System.debug('***CaseReviewController complaintDecisionOnchange isRequiredInvalidPaid: ' + isRequiredInvalidPaid);
        System.debug('***CaseReviewController complaintDecisionOnchange isRequiredApprovePaid: ' + isRequiredApprovePaid);
        System.debug('***CaseReviewController complaintDecisionOnchange isRequiredDrop: ' + isRequiredDrop);
        return null;
    }

    public PageReference invalidPaidOnChange() {
        System.debug('***CaseReviewController invalidPaidOnChange caseObj.Invalid_Paid__c: ' + caseObj.Invalid_Paid__c);
        if (caseObj.Invalid_Paid__c == 'Compensation Payment') {
            isRequredCompensationPayment = true;
            isRequiredPaid = false;
        }
        else if (caseObj.Invalid_Paid__c == 'Paid') {
            isRequredCompensationPayment = false;
            isRequiredPaid = true;
        }
        else {
            isRequredCompensationPayment = false;
            isRequiredPaid = false;
        }
        isRequiredInvalidPaid = true;
        System.debug('***CaseReviewController invalidPaidOnChange isRequiredInvalidPaid: ' + isRequiredInvalidPaid);
        System.debug('***CaseReviewController invalidPaidOnChange isRequredCompensationPayment: ' + isRequredCompensationPayment);
        System.debug('***CaseReviewController invalidPaidOnChange isRequiredPaid: ' + isRequiredPaid);
        return null;
    }

    public PageReference getUpdatedPage() {
        PageReference pr = Page.CaseReview;
        pr.getParameters().put('Id', caseId);
        pr.setRedirect(true);
        return pr;
    }
}