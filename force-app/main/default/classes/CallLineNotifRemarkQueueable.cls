public class CallLineNotifRemarkQueueable implements Queueable, Database.AllowsCallouts {

    private Map<String, String> prop;
    
    public CallLineNotifRemarkQueueable(Map<String, String> prop) {
        this.prop = prop;
    }
    
    public void execute(QueueableContext qc) {
        long startLongTime = system.now().getTime();
        String message = '', response, errorMessage = 'Notification Remark: Failed to insert assessment, please contact Admin';
        
        EIPJson getNotifRemark;
        try {
            getNotifRemark = EIPConnector.getAssNotes(EIPConstant.OPERATION_NOTIF_REMARK, EIPConstant.ENTITY_AMFS, EIPConstant.APP_RLS, prop.get(EIPConstant.FIELD_POLICY_NO), 'UW', null, null);
            system.debug('getNotifRemark: '+getNotifRemark);
            if (getNotifRemark != null) {
                if (getNotifRemark.Body.Status != null && getNotifRemark.Body.Status == '0') message = String.isBlank(getNotifRemark.Body.exceptionObj.message) || getNotifRemark.Body.exceptionObj.message == '' ? errorMessage : getNotifRemark.Body.exceptionObj.message;
                else validateAssType(getNotifRemark, prop);
                response = getNotifRemark.toStringJson();    
            }
            
        } catch (Exception e) {
            System.debug('Call Line Get Notification Remark error: '+e.getMessage());
            response = e.getMessage();
            message = errorMessage;
        }
        
        Map<String, String> logProp = new Map<String, String>();
        logProp.put('ObjectId', prop.get(EIPConstant.FIELD_ID));
        logProp.put('Message', message);
        logProp.put('Report', 'Report Contacted & Uncontacted TelUW');
        logProp.put('CaseType', 'TelUW (Notif Remark)');
        logProp.put('Request', EIPConnector.getRequestPrettyPrint());
        logProp.put('Response', response);
        BaseCoreServiceController.insertLog(logProp, startLongTime);
        
    }
    
    private static void validateAssType(EIPJson getNotifRemark, Map<String, String> prop) {
        String assmTypeCd = getNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[0].assmtTypeCd;
        String assmtRemark = getNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[0].assmtRemark;
        String assmClassType = getNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[0].assessmentClassType;
        String assmStatus = getNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[0].assmtStatus;
        
        prop.put('assmtTypeCd', assmTypeCd.trim());
        prop.put('assmtRemark', assmtRemark);
        prop.put('assessmentClassType', assmClassType);
        if (assmStatus == 'R') System.enqueueJob(new RecordPolicyNotesQueueable(prop));
    }
}