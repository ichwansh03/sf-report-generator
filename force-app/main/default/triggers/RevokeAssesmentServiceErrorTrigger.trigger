trigger RevokeAssesmentServiceErrorTrigger on AppLog__c (after insert, after update) {
    
    try {
        AppLog__c log = [SELECT Id FROM AppLog__c WHERE Status__c = 'Error' ORDER BY LastModifiedDate LIMIT 1];
        
        if (log != null) {
            DateTime dt = DateTime.now().addMinutes(Integer.valueOf(System.Label.SchNotificationServiceError_Minute));
            String sch = '0 '+dt.minute()+' '+System.Label.SchNotificationServiceError_Hour.toString();
            System.schedule('SchNotificationServiceError', sch, new SchCoreServiceNotification());   
            
        } else {
            CronTrigger schJob = [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name = 'SchNotificationServiceError' LIMIT 1];
            
            if (schJob != null) System.abortJob(schJob.Id);
        }
    } catch (Exception e) {
     	system.debug('Revoke Assesment Service Error: '+e.getMessage());   
    }
   
}