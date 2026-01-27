public class CallLineMaintenanceQueueable implements Queueable, Database.AllowsCallouts {
    
    private Map<String, String> prop;
    
    public CallLineMaintenanceQueueable(Map<String, String> prop) {
        this.prop = prop;
    }
    
    public void execute(QueueableContext qc) {
        long startLongTime = system.now().getTime();
        String message = '', response, request, statusCode;
        
        EIPJson requestCR = new EIPJson();
        
        try {

            system.debug('INSERT CR REGISTER MAINTENANCE FOR REDEMPTION KONVEN');            
            Map<String, String> properties = new Map<String, String>();
            properties.put(EIPConstant.PARAM_MSG_POLICY, prop.get(EIPConstant.FIELD_POLICY_NO));
            properties.put(EIPConstant.PARAM_ASSESSOR_DTTM, prop.get(EIPConstant.FIELD_LAST_MDDT));
            properties.put(EIPConstant.PARAM_LAST_UPD_DTTM, prop.get(EIPConstant.FIELD_COL_CALL_DATE));
            properties.put(EIPConstant.PARAM_CLAIM_STATUSCD, prop.get('Status1'));
            properties.put(EIPConstant.PARAM_CLAIM_TYPECD, prop.get('Status2'));
            properties.put(EIPConstant.PARAM_CLAIM_REMARKS, prop.get('Status3'));
            properties.put(EIPConstant.PARAM_ASSESSOR, prop.get(EIPConstant.FIELD_ID_RLS));
            properties.put(EIPConstant.PARAM_UWREMARK1, prop.get('Uw_Remark1'));
            properties.put(EIPConstant.PARAM_UWREMARK2, prop.get('Uw_Remark2'));
            properties.put(EIPConstant.PARAM_UWREMARK3, prop.get('Uw_Remark3'));
            properties.put(EIPConstant.PARAM_REASON1, prop.get('Reason1'));
            properties.put(EIPConstant.PARAM_REASON2, prop.get('Reason2'));
            properties.put(EIPConstant.PARAM_MSG_REMARKS, prop.get('Reason3'));
            
            if (validateConsStatus(prop.get(EIPConstant.FIELD_ACTIVITY_RESULT), prop.get('Cons_Status'))) {
                properties.put(EIPConstant.PARAM_STATUS_REASON, prop.get(EIPConstant.FIELD_ACTIVITY_RESULT));
                properties.put(EIPConstant.PARAM_MSG_UWTYPE, prop.get('Cons_Status'));   
            } else {
                properties.put(EIPConstant.PARAM_STATUS_REASON, prop.get('Cons_Status'));
                properties.put(EIPConstant.PARAM_MSG_UWTYPE, prop.get('Prev_Status'));   
            }
            
            requestCR = EIPConnector.insertRegisterMaintenance(EIPConstant.OPERATION_CR_REGISTER, EIPConstant.ENTITY_AMFS, EIPConstant.APP_RLS, properties);
            system.debug('requestCR: '+requestCR);
            
            statusCode = requestCR.Body.Status;
            if (statusCode != null && statusCode == '0') message = requestCR.Body.exceptionObj.message;
            
        } catch (Exception e) {
            system.debug('Call Line CR Register Assessment Service RLS Error: '+e.getMessage());
            message = 'CR Register Maintenance: Failed to insert assesment, please contact Admin';
        }
        
        Map<String, String> logProp = new Map<String, String>();
        logProp.put('ObjectId', prop.get(EIPConstant.FIELD_ID));
        logProp.put('Message', message);
        logProp.put('Report', 'AMFS Collection Robot RLS');
        logProp.put('CaseType', 'Redemption Konven (CR Register)');
        logProp.put('Request', EIPConnector.getRequestPrettyPrint());
        logProp.put('Response', requestCR.toStringJson());
        BaseCoreServiceController.insertLog(logProp, startLongTime);
        
    }
    
    private static Boolean validateConsStatus(String resultCall, String status) {
        system.debug('>>> MATCHING RESULT CALL AND Q7CSTS FROM RLS <<<');
        List<Cons_Status_RLS__c> matches = [SELECT Call_Status__c, Q7CSTS__c FROM Cons_Status_RLS__c WHERE Call_Status__c = :resultCall AND Q7CSTS__c = :status];
        system.debug('MATCHES: '+matches);
        return !matches.isEmpty();
    }
    
}