global class SchedulerRedemeptionCancel implements Schedulable {
    
    global void execute(SchedulableContext sc) {
        
        List<Id> clId = new List<Id>();
        
        for (AppLog__c log : [SELECT Id, Log_Call_Line__c, Request_Value__c FROM AppLog__c WHERE Log_Call_Line__r.Call_Status_Config__c = 'Cancel' AND Status__c = 'Success' AND LastModifiedDate = TODAY]) {
            clId.add(log.Log_Call_Line__c);
        }
        
		List<Call_Line__c> cl = [SELECT Id, Case_Type__c, Contact_Policy_App__c FROM Call_Line__c WHERE Id NOT IN :clId AND Case_Type__c = 'Redemption TM'  AND Call_Status_Config__c = 'Cancel' AND LastModifiedDate = TODAY];
        
        if (cl.size() > 0) Database.executeBatch(new LogCallLineServiceBatch(cl), Integer.valueOf(Label.Limit_Batch_Service));
        system.debug(cl);
    }

}