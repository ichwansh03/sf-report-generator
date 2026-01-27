public class CallLineAssesmentServiceTelUW {
    
    public static void insertAssesmentTelUW(String id){
        Call_Line__c cl = BaseCoreServiceController.generateCallLine(id);
        long startLongTime = system.now().getTime();
        String message = '', response, errorMessage = 'Failed to insert assessment, please contact Admin';
        String sep = '\u001F';
        String description = validateResultCall(cl) + sep + cl.Owner.Name + sep + cl.LastModifiedDate.addHours(7).toString() + sep + cl.Notes__c;
        EIPJson requestAssmt = new EIPJson();
        
        try {
            Map<String, String> properties = new Map<String, String>();
            properties.put(EIPConstant.PARAM_MSG_POLICY, cl.Policy_No__c);
            properties.put(EIPConstant.PARAM_ASSMT_DESC, description);
            properties.put(EIPConstant.PARAM_ASSMT_SECTION, 'UW');
            properties.put(EIPConstant.PARAM_ASSESSOR_DTTM,  cl.LastModifiedDate.format('yyyyMMddHHmmss', 'Asia/Jakarta'));
            properties.put(EIPConstant.PARAM_LAST_UPD_DTTM,  cl.LastModifiedDate.format('yyyyMMddHHmmss', 'Asia/Jakarta'));
            properties.put(EIPConstant.PARAM_CASE_TYPE, cl.Case_Type__c);
            properties.put(EIPConstant.PARAM_ASSESSOR, BaseCoreServiceController.generateUser(cl.OwnerId).ID_User_RLS__c);
            
            requestAssmt = EIPConnector.insertAssessmentMaintenance(EIPConstant.OPERATION_INSERT_ASSESMENT, EIPConstant.ENTITY_AMFS, EIPConstant.APP_RLS, properties);
            system.debug('requestAssmt: '+requestAssmt);
            
            if (requestAssmt != null) {
                if (requestAssmt.Body.Status != null && requestAssmt.Body.Status == '0') message = String.isBlank(requestAssmt.Body.exceptionObj.message) || requestAssmt.Body.exceptionObj.message == '' ? errorMessage : requestAssmt.Body.exceptionObj.message;
                response = requestAssmt.toStringJSON();
            }
            
        } catch (Exception e) {
            system.debug('TelUW Call Line Assesment Error: '+e.getMessage());
            response = e.getMessage();
            message = errorMessage;
        }
        
        Map<String, String> logProp = new Map<String, String>();
        logProp.put('ObjectId', cl.Id);
        logProp.put('Message', message);
        logProp.put('Report', 'Report Contacted & Uncontacted TelUW');
        logProp.put('CaseType', 'TelUW');
        logProp.put('Request', EIPConnector.getRequestPrettyPrint());
        logProp.put('Response', response);
        BaseCoreServiceController.insertLog(logProp, startLongTime);
        
        if (message == '') {
            Map<String, String> prop = new Map<String, String>();
            prop.put(EIPConstant.FIELD_POLICY_NO,cl.Policy_No__c);
            prop.put(EIPConstant.FIELD_ID, cl.Id);
            System.enqueueJob(new CallLineAppDetailQueueable(prop));   
        }
    }
    
    public static String validateResultCall(Call_Line__c cl) {
        String call = cl.Activity_Result__c.trim().toLowerCase();
        String reason = cl.Verification__c != null ? cl.Verification__c.trim().toLowerCase() : '';
        
        Map<String, TelUW_Result__c> telUwResult = TelUW_Result__c.getAll();
        TelUW_Result__c matched = null;
        
        for (TelUW_Result__c result : telUwResult.values()) {
            if (result.Call_Status__c == null || result.Reason_Status__c == null) continue;
            
            for (String res : result.Reason_Status__c.split(',')) {
                if (res == null) continue;
                if (res.trim().toLowerCase() == reason) {
                    matched = result;
                    break;
                }
            }
            if (matched != null) break;
        }
        
     	if (matched != null && matched.Result_Call__c != null) return matched.Result_Call__c;    
        
        return cl.Activity_Result__c == 'Hold' ? 'TeleUW Hold' : null;
    }
    
}