global class UpdateRequestDateBatch implements Database.Batchable<sObject>, Database.Stateful {
	global Integer recordsProcessed = 0;
    global String query;
    private static Date todayDate = Date.today();
    private static Date tomorrowDate = todayDate.addDays(1);
    private static final String SEND = 'Send';
    private static final String RECEIVED = 'Received';
    private static final String ICF = 'ICF';
    
    global UpdateRequestDateBatch(String q) {
        this.query = q;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);	
    }
    
    global void execute(Database.BatchableContext bc, List<Email_Sms_Log__c> scope) {
        System.debug(LoggingLevel.DEBUG, '***SCOPE: ' + scope.size());
        Set<Email_SMS_Log__c> eslToUpdate = new Set<Email_SMS_Log__c>();
        
        for (Email_Sms_Log__c esl : scope) {
            esl.Request_Date__c = tomorrowDate;
            eslToUpdate.add(esl);
            recordsProcessed = recordsProcessed + 1;
        }
        List<Email_SMS_Log__c> eslList = new List<Email_SMS_Log__c>();
        eslList.addAll(eslToUpdate);
        update eslList;
    }
    
    global void finish(Database.BatchableContext bc) {
        System.debug(LoggingLevel.DEBUG, '***TOTAL PROCESSED: ' + recordsProcessed);
    }
}