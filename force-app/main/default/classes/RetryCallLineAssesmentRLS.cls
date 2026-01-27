public class RetryCallLineAssesmentRLS {
    
    public static void retryAssesmentRLS(String logId){
        AppLog__c log = (AppLog__c) SOQL.of(AppLog__c.SObjectType)
            .with('Id, Log_Call_Line__c, Log_Case__c, Request_Value__c, Policy_App__c')
            .whereAre(SOQL.Filter.with(AppLog__c.Id).equal(logId))
            .systemMode()
            .toObject();
        
        EIPJson convertReqJson = (EIPJson) JSON.deserialize(log.Request_Value__c, EIPJson.class);
        system.debug('request value: '+convertReqJson.Body.service);
        Map<String, String> requestProp = new Map<String, String>();
        String operation = convertReqJson.Body.operation;
        EIPJson.EIP_AgSa_InsurancePolicy hasPolicy = convertReqJson.Body.Customer.hasPolicyAccount[0];
        
        if (operation == EIPConstant.OPERATION_INSERT_ASSESMENT) {
            
        } else if (operation == EIPConstant.OPERATION_CR_REGISTER) {
            
        } else if (operation == EIPConstant.OPERATION_APP_DETAIL) {
            
        } else if (operation == EIPConstant.OPERATION_NOTIF_REMARK) {
            
        }
    }
}