public class CallLineAssesmentServiceWecall {

    //@future(callout = true)
    public static void requestWecall(String clid) {
        
        System.debug('CALL LINE WELCOME CALL ASSESSMENT SERVICE');
        
        long startLongTime = system.now().getTime();
        String message = '', statusCode;
        Call_Line__c cl = BaseCoreServiceController.generateCallLine(clid);
        EIPJson addWecallAssmt = new EIPJson();
        
        User user = BaseCoreServiceController.generateUser(cl.Agent__c);
        
        try {
            String sep = '\u001F';
            String description = validateResultCall(cl) + sep + cl.LastModifiedDate.toString() + sep + cl.Owner.Name + sep + cl.Notes__c;
        
            Map<String, String> properties = new Map<String, String>();
            properties.put(EIPConstant.PARAM_MSG_POLICY, cl.Policy_No__c);
            properties.put(EIPConstant.PARAM_ASSMT_SECTION, 'OTH');
            properties.put(EIPConstant.PARAM_ASSESSOR_DTTM, cl.LastModifiedDate.format('yyyyMMddHHmmss', 'Asia/Jakarta'));
            properties.put(EIPConstant.PARAM_LAST_UPD_DTTM, cl.LastModifiedDate.format('yyyyMMddHHmmss', 'Asia/Jakarta'));
            properties.put(EIPConstant.PARAM_ASSMT_DESC, description);
            properties.put(EIPConstant.PARAM_CASE_TYPE, cl.Case_Type__c);
            properties.put(EIPConstant.PARAM_ASSESSOR, user.ID_User_RLS__c);
            system.debug('properties: '+properties);
            addWecallAssmt = EIPConnector.insertAssessmentMaintenance(EIPConstant.OPERATION_INSERT_ASSESMENT, EIPConstant.ENTITY_AMFS, EIPConstant.APP_RLS, properties);
            system.debug('requestAssmt: '+addWecallAssmt);
            
            statusCode = addWecallAssmt.Body.Status;
            String errorMessage = 'Failed to insert assessment, please contact Admin';
            if (statusCode != null && statusCode == '0') message = String.isBlank(addWecallAssmt.Body.exceptionObj.message) || addWecallAssmt.Body.exceptionObj.message == '' ? errorMessage : addWecallAssmt.Body.exceptionObj.message;
            
        } catch (Exception e) {
            System.debug('Assessment Welcome Call Error: '+e.getMessage());
        }
        
        Map<String, String> logProp = new Map<String, String>();
        logProp.put('ObjectId', cl.Id);
        logProp.put('Message', message);
        logProp.put('Report', 'Report Assesment WeCall');
        logProp.put('CaseType', cl.Case_Type__c);
        logProp.put('Request', EIPConnector.getRequestPrettyPrint());
        logProp.put('Response', addWecallAssmt.toStringJson());
        BaseCoreServiceController.insertLog(logProp, startLongTime);
    }
    
    public static String validateResultCall(Call_Line__c cl) {
        String call = cl.Activity_Result__c.trim().toLowerCase();
        String reason = cl.Verification__c.trim().toLowerCase();
        Map<String, Welcome_Call_Result__c> weCallResult = Welcome_Call_Result__c.getAll();
        Welcome_Call_Result__c matched = null;
        
        for (Welcome_Call_Result__c result : weCallResult.values()) {
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
        
        system.debug('matched: '+matched.Result_Call__c);
        return matched.Result_Call__c;
    }
}