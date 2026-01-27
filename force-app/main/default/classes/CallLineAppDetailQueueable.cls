public class CallLineAppDetailQueueable implements Queueable, Database.AllowsCallouts {

    private Map<String, String> prop;
    
    public CallLineAppDetailQueueable(Map<String, String> prop) {
        this.prop = prop;
    }
    
    public void execute(QueueableContext qc) {
        long startLongTime = system.now().getTime();
        String message = '', response, errorMessage = 'Application Detail: Failed to insert assessment, please contact Admin';
        
        EIPJson getPolicyStatus;
        try {
            system.debug('GET APPLICATION DETAIL REPORT TELEUW');
            
            getPolicyStatus = EIPConnector.getPolicyDetails(EIPConstant.OPERATION_APP_DETAIL, EIPConstant.ENTITY_AMFS, EIPConstant.APP_RLS, prop.get(EIPConstant.FIELD_POLICY_NO));
            
            if (getPolicyStatus != null) {
                if (getPolicyStatus.Body.Status != null && getPolicyStatus.Body.Status == '0') message = String.isBlank(getPolicyStatus.Body.exceptionObj.message) || getPolicyStatus.Body.exceptionObj.message == '' ? errorMessage : getPolicyStatus.Body.exceptionObj.message;
                else validatePolicyStatus(getPolicyStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyStatusCD, prop);
                
                response = getPolicyStatus.toStringJSON();   
            }
        
        } catch (Exception e) {
        	system.debug('Call Line Application Detail Error: '+e.getMessage());    
            response = e.getMessage();
            message = errorMessage;
        }
        
        Map<String, String> logProp = new Map<String, String>();
        logProp.put('ObjectId', prop.get(EIPConstant.FIELD_ID));
        logProp.put('Message', message);
        logProp.put('Report', 'Report Contacted & Uncontacted TelUW');
        logProp.put('CaseType', 'TelUW (App Detail)');
        logProp.put('Request', EIPConnector.getRequestPrettyPrint());
        logProp.put('Response', response);
        BaseCoreServiceController.insertLog(logProp, startLongTime);
        
    }
    
    @TestVisible
    private static void validatePolicyStatus(String policyStatus, Map<String, String> prop) {
        system.debug('call this method');
        String statusCode = policyStatus.subStringBetween('[',']');
        system.debug('status code: '+statusCode);
        if (!System.label.Validate_Policy_Status.split(',').contains(statusCode)) {
			System.enqueueJob(new CallLineNotifRemarkQueueable(prop));        
        }
    }
}