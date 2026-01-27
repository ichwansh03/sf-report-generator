trigger LogAssesmentErrorTrigger on AppLog__c (after insert, after update) {

    /*List<AppLog__c> logs = [SELECT Id FROM AppLog__c WHERE Status__c = 'Error' AND Report_Name__c != NULL LIMIT 10];
    system.debug('logs trigger error: '+logs);
    if (logs.size() > 0) {
        String sch = '0 '+String.valueOf(DateTime.now().addHours(7).addMinutes(Integer.valueOf(System.Label.SchNotificationServiceError_Minute)).minute())+' '+System.Label.SchNotificationServiceError_Hour.toString();
        System.schedule('SchNotificationServiceError', sch, new SchCoreServiceNotification());   
    } else {
        try {
            CronTrigger schJob = [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name = 'SchNotificationServiceError' LIMIT 1];
            
            if (schJob != null) System.abortJob(schJob.Id);
        } catch (Exception e) {
            system.debug('LogAssesmentErrorTrigger: '+e.getMessage());
        }
    }*/
}