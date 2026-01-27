public class LogCoreIntegrationServiceQueue implements Queueable, Database.AllowsCallouts {
    
    private List<AppLog__c> logs;
    private Integer currentIndex;
    private List<AppLog__c> logResponses;
    
    public LogCoreIntegrationServiceQueue(List<AppLog__c> logs) {
        this(logs, 0, new List<AppLog__c>());
    }
    
    private LogCoreIntegrationServiceQueue(List<AppLog__c> logs, Integer currentIndex, List<AppLog__c> logResponses) {
        this.logs = logs;
        this.currentIndex = currentIndex;
        this.logResponses = logResponses;
    }
    
    public void execute(QueueableContext context) {
        if (currentIndex >= logs.size()) {
            if (!logResponses.isEmpty()) update logResponses;
            
            return;
        }
        
        AppLog__c log = logs[currentIndex];
        processLog(log);
        
        if (currentIndex + 1 < logs.size()) {
            System.enqueueJob(new LogCoreIntegrationServiceQueue(logs, currentIndex + 1, logResponses));
        } else {
            if (!logResponses.isEmpty()) {
                update logResponses;
            }
        }
    }
    
    private void processLog(AppLog__c log) {
        try {
            EIPJson convertReqJson = (EIPJson) JSON.deserialize(log.Request_Value__c, EIPJson.class);
            String operation = convertReqJson.Body.operation;
            
            if (operation == EIPConstant.OPERATION_GET_CONSERVATION && log.Policy_App__c == 'DMTM') {
                CallLineAssesmentServiceTM.retryConservation(convertReqJson, log.Log_Call_Line__c);
            } 
            else if ((operation == EIPConstant.OPERATION_GET_CONSERVATION && log.Policy_App__c == 'RLS') 
                     || operation == EIPConstant.OPERATION_APP_DETAIL) {
                updateResponseLog(convertReqJson, Label.Biz_getPolicyDetail, log);
            } 
            else if (operation == EIPConstant.OPERATION_NOTIF_REMARK) {
                updateResponseLog(convertReqJson, Label.Biz_getAssNotes, log);
            }
            else {
                updateResponseLog(convertReqJson, Label.Biz_getCustomerInfo, log);   
            }
        } catch (Exception e) {
            // Log error and continue to next record
            System.debug('Error processing log ' + log.Id + ': ' + e.getMessage());
            logResponses.add(new AppLog__c(
                Id = log.Id, 
                Error_Message__c = e.getMessage(), 
                Status__c = 'Error'
            ));
        }
    }
    
    private void updateResponseLog(EIPJson response, String bizEndpoint, AppLog__c log) {
        String message, status = 'Success', errorMessage = 'Failed to insert assessment, please contact Admin';
        
        String updateReqJson = updateTransIdRequest(log.Request_Value__c, log.Id, log.id__c);
        response = EIPConnector.sendRequest('', updateReqJson, bizEndpoint);
        
        if (response.Body.Status != null && response.Body.Status == '0') {
            message = String.isBlank(response.Body.exceptionObj.message) 
                || response.Body.exceptionObj.message == '' 
                ? errorMessage 
                : response.Body.exceptionObj.message;
        }
        
        System.debug('response: ' + response);
        system.debug('message: '+message);
        if (message != null) status = 'Error';
        
        logResponses.add(new AppLog__c(
            Id = log.Id, 
            Response_Payload__c = response.toStringJSON(), 
            Error_Message__c = message, 
            Status__c = status
        ));
    }
    
    private static String updateTransIdRequest(String reqJson, String logId, String objId) {
        EIPJson convertReqJson = (EIPJson) JSON.deserialize(reqJson, EIPJson.class);
        
        String datePart = DateTime.now().format('yyyyMMdd');
        String uniqueString = EncodingUtil.convertToHex(
            Crypto.generateDigest('MD5', Blob.valueOf(logId + System.now().format() + Crypto.getRandomLong()))
        );
        String newTransId = objId + '-' + datePart + '-' + uniqueString;
        
        convertReqJson.Body.transactionId = newTransId;
        
        return convertReqJson.toStringJSON();
    }
}