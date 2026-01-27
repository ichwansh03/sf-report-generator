public class LogCoreIntegrationServiceBatch implements Database.Batchable<AppLog__c> {

    public List<AppLog__c> logs {get; set;}
    
    public LogCoreIntegrationServiceBatch(List<AppLog__c> logs) {
        this.logs = logs;
    }
    
    public List<AppLog__c> start(Database.BatchableContext bc) {
        return this.logs;
    }
    
    public void execute(Database.BatchableContext bc, List<AppLog__c> logs) {
        retryToHitService(logs);
    }
    
    public void finish(Database.BatchableContext bc) {
        
    }
    
    public static void retryToHitService(List<AppLog__c> logs) {
        
        List<AppLog__c> logResponses = new List<AppLog__c>();
        
        for (AppLog__c log : logs) {
            EIPJson convertReqJson = (EIPJson) JSON.deserialize(log.Request_Value__c, EIPJson.class);
            String operation = convertReqJson.Body.operation;
            
            if (operation == EIPConstant.OPERATION_GET_CONSERVATION && log.Policy_App__c == 'DMTM') CallLineAssesmentServiceTM.retryConservation(convertReqJson, log.Log_Call_Line__c);
            else if ((operation == EIPConstant.OPERATION_GET_CONSERVATION && log.Policy_App__c == 'RLS') || operation == EIPConstant.OPERATION_APP_DETAIL) updateResponseLog(convertReqJson, Label.Biz_getPolicyDetail, log, logResponses);
            else if (operation == EIPConstant.OPERATION_NOTIF_REMARK) updateResponseLog(convertReqJson, Label.Biz_getAssNotes, log, logResponses);
            else updateResponseLog(convertReqJson, Label.Biz_getCustomerInfo, log, logResponses);
        }
        
        update logResponses; 
    }
    
    private static String updateTransIdRequest(String reqJson, String logId, String objId) {
        EIPJson convertReqJson = (EIPJson) JSON.deserialize(reqJson, EIPJson.class);
        
        String datePart = DateTime.now().format('yyyyMMdd');
        String uniqueString = EncodingUtil.convertToHex(Crypto.generateDigest('MD5', Blob.valueOf(logId + System.now().format() + Crypto.getRandomLong())));
        String newTransId = objId + '-' + datePart + '-' + uniqueString;
        
        convertReqJson.Body.transactionId = newTransId;
        
        return convertReqJson.toStringJSON();
    }

    private static void updateResponseLog(EIPJson response, String bizEndpoint, AppLog__c log, List<AppLog__c> logResponses) {
        String message, status, errorMessage = 'Failed to insert assessment, please contact Admin';
        
        String updateReqJson = updateTransIdRequest(log.Request_Value__c, log.Id, log.id__c);
        response = EIPConnector.sendRequest('',updateReqJson, bizEndpoint);
        
        if (response.Body.Status != null && response.Body.Status == '0') message = String.isBlank(response.Body.exceptionObj.message) 
            || response.Body.exceptionObj.message == '' 
            ? errorMessage : response.Body.exceptionObj.message;
        
        system.debug('response: '+response);
        
        if (message != null) status = 'Error';
        else status = 'Success';
        
        logResponses.add(new AppLog__c(Id = log.Id, Response_Payload__c = response.toStringJSON(), Error_Message__c = errorMessage, Status__c = status));
    }
}