public class CallLineAssesmentServiceCR {
    
    public static void insertAssessment(String clid) {
        Call_Line__c cl = BaseCoreServiceController.generateCallLine(clid);
        long startLongTime = system.now().getTime();
        String message = '', response, errorMessage = 'Failed to insert assessment, please contact Admin';
        String sep = '\u001F';
        String callDate = cl.Collection_Call_Date__c != null ? cl.Collection_Call_Date__c.format('yyyy-MM-dd HH:mm:ss', 'Asia/Jakarta') : cl.LastModifiedDate.format('yyyy-MM-dd HH:mm:ss', 'Asia/Jakarta');
        String description = cl.Case_Type__c + sep + callDate + sep + BaseCoreServiceController.generateUser(cl.Agent__c).ID_User_RLS__c + sep + cl.Call_Remarks__c;
        
        EIPJson requestAssmt = new EIPJson();

        try {
			system.debug('INSERT ASSESSMENT MAINTENANCE');
            Map<String, String> properties = new Map<String, String>();
            properties.put(EIPConstant.PARAM_MSG_POLICY, cl.Policy_No__c);
            properties.put(EIPConstant.PARAM_ASSMT_DESC, description);
            properties.put(EIPConstant.PARAM_ASSMT_SECTION, 'OTH');
            properties.put(EIPConstant.PARAM_ASSESSOR_DTTM, cl.LastModifiedDate.format('yyyyMMddHHmmss', 'Asia/Jakarta'));
            properties.put(EIPConstant.PARAM_LAST_UPD_DTTM, cl.LastModifiedDate.format('yyyyMMddHHmmss', 'Asia/Jakarta'));
            properties.put(EIPConstant.PARAM_CASE_TYPE, cl.Case_Type__c);
            properties.put(EIPConstant.PARAM_ASSESSOR, BaseCoreServiceController.generateUser(cl.Agent__c).ID_User_RLS__c);
            
            requestAssmt = EIPConnector.insertAssessmentMaintenance(EIPConstant.OPERATION_INSERT_ASSESMENT, EIPConstant.ENTITY_AMFS, EIPConstant.APP_RLS, properties);
            system.debug('requestAssmt: '+requestAssmt);
            if (requestAssmt != null) {
             	if (requestAssmt.Body.Status != null && requestAssmt.Body.Status == '0') message = String.isBlank(requestAssmt.Body.exceptionObj.message) 
                    || requestAssmt.Body.exceptionObj.message == '' 
                    ? errorMessage : requestAssmt.Body.exceptionObj.message;
                
                response = requestAssmt.toStringJSON();
            }
            
        } catch (Exception e) {
            system.debug('Call Line Assessment Service RLS Error: '+e.getMessage());
            response = e.getMessage();
            message = errorMessage;
        }
        
        Map<String, String> logProp = new Map<String, String>();
        logProp.put('ObjectId', cl.Id);
        logProp.put('Message', message);
        logProp.put('Report', 'AMFS Collection Robot RLS');
        logProp.put('CaseType', cl.Case_Type__c);
        logProp.put('Request', EIPConnector.getRequestPrettyPrint());
        logProp.put('Response', response);
        BaseCoreServiceController.insertLog(logProp, startLongTime);
        
        if (cl.Case_Type__c == 'Redemption Konven' && cl.Activity_Result__c != 'Takeout' && message == '') {
            String uwRemark = BaseCoreServiceController.generateUser(cl.Agent__c).ID_User_RLS__c + ': ' + cl.Activity_Result__c + ': ' + cl.Call_Remarks__c;
            
            Map<String, String> prop = new Map<String, String>();
            prop.put(EIPConstant.FIELD_POLICY_NO,cl.Policy_No__c);
            prop.put(EIPConstant.FIELD_ID_RLS, BaseCoreServiceController.generateUser(cl.Agent__c).ID_User_RLS__c);
            prop.put(EIPConstant.FIELD_UW_REMARK, uwRemark);
            prop.put(EIPConstant.FIELD_ACTIVITY_RESULT, cl.Activity_Result__c);
            prop.put(EIPConstant.FIELD_REASON_STATUS, cl.Reason_Status_Config__c);
            prop.put(EIPConstant.FIELD_COL_CALL_DATE, cl.Collection_Call_Date__c.format('yyyyMMddHHmmss', 'Asia/Jakarta'));
            prop.put(EIPConstant.FIELD_ID, cl.Id);
            prop.put(EIPConstant.FIELD_LAST_MDDT, cl.LastModifiedDate.format('yyyyMMddHHmmss', 'Asia/Jakarta')); 
            
            System.enqueueJob(new CallLineConservationQueueable(prop));
        }
        
    }
    
}