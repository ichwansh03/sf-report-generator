global class SchCoreServiceNotification implements Schedulable {
    
    global void execute(SchedulableContext sc){
        
        Map<String, List<AppLog__c>> reportMapSuccess = new Map<String, List<AppLog__c>>();
        Map<String, List<AppLog__c>> reportMapError = new Map<String, List<AppLog__c>>();
        
        DateTime current = DateTime.now();
        DateTime ends = DateTime.newInstance(current.year(), current.month(), current.day(), current.hour(), 0, 0);
        DateTime start = ends.addHours(-1);
        
        system.debug('[SchCoreServiceNotification] Schedulable Execute: '+sc);
        String jobName = [SELECT Id, CronJobDetail.Name FROM CronTrigger WHERE Id = :sc.getTriggerId()].CronJobDetail.Name;
        
        if (jobName == 'SchNotificationServiceError') {
            
            List<AppLog__c> errorLogs = [SELECT Id, LastModifiedDate, id__c, Report_Name__c, Status__c, Log_Call_Line__c, Log_Case__c, Request_Value__c, Policy_App__c FROM AppLog__c WHERE Status__c = 'Error' ORDER BY LastModifiedDate LIMIT :Integer.valueOf(Label.Limit_Batch_Service)];
            collectDataMap(reportMapError, errorLogs, 'ET - AMFS - Notification Service DMTM-RLS Error', 'Error', start, DateTime.now());
            rescheduleJob(errorLogs);
        }
        
        if (jobName == 'SchNotificationServiceSuccess') {
            
            List<AppLog__c> successLogs = [SELECT Id, LastModifiedDate, id__c, Report_Name__c, Status__c FROM AppLog__c WHERE Status__c = 'Success' AND LastModifiedDate > :start AND LastModifiedDate < :ends];
            
            system.debug('size of logs: '+successLogs.size());
            collectDataMap(reportMapSuccess, successLogs, 'ET - AMFS - Notification Service DMTM-RLS Success', 'Success', start, ends);
        }
    }
    
    private void collectDataMap(Map<String, List<AppLog__c>> mapLogs, List<AppLog__c> logs, String subject, String status, DateTime startTime, DateTime endTime) {
        if (logs.size() > 0) {
            
            for (AppLog__c log : logs) {
                if (!mapLogs.containsKey(log.Report_Name__c)) {
                    mapLogs.put(log.Report_Name__c, new List<AppLog__c>());
                }
                mapLogs.get(log.Report_Name__c).add(log);
            }

            sendNotificationReport(mapLogs, subject, status, startTime.toString(), endTime.toString());
        }
    }
    
    public void sendNotificationReport(Map<String, List<AppLog__c>> reportMap, String templateName, String status, String start, String ends) {
        List<Messaging.SingleEmailMessage> listEmail = new List<Messaging.SingleEmailMessage>();
        EmailTemplate et = [SELECT Id, Name, HtmlValue, Subject, Body FROM EmailTemplate WHERE Name = :templateName];
        
        String htmlBody = et.HtmlValue;
        String subject = et.Subject;
        
        OrgWideEmailAddress[] owea = [SELECT Id FROM OrgWideEmailAddress WHERE Address = 'noreply.general@axa-mandiri.co.id'];
        
        for (String report : reportMap.keySet()) {
            String modHtmlBody = htmlBody;
            String modSubject = subject;
            modSubject = subject.replace('[report_name]', report);
            modHtmlBody = modHtmlBody.replace('[report_name]', report);
            if (status == 'Success') modHtmlBody = modHtmlBody.replace('[report_url]', Label.SFDC_URL_AXA_VF+'apex/ExportServiceRevamp?report='+report+'&status='+status+'&start='+start+'&ends='+ends);
            else modHtmlBody = modHtmlBody.replace('[report_url]', Label.SFDC_URL_AXA_VF+'apex/ExportServiceRevamp?report='+report+'&status='+status);
            modHtmlBody = modHtmlBody.replace('[date_created]', DateTime.valueOfGmt(ends).format());
            modHtmlBody = modHtmlBody.replace('[date_started]', DateTime.valueOfGmt(start).format());
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setSubject(modSubject);
            mail.setHtmlBody(modHtmlBody);
            mail.setTreatTargetObjectAsRecipient(false);
            mail.setTemplateId(et.Id); 
            mail.setOrgWideEmailAddressId(owea.get(0).Id);    
            
            if (report.contains('Collection') && reportMap.get(report).size() > 0) mail.setToAddresses(Label.Email_Collection_Recipient.split(','));
            if (report.contains('Correspondence') && reportMap.get(report).size() > 0) mail.setToAddresses(Label.Email_Correspondence_Recipient.split(','));   
            if (report.contains('Inbound') && reportMap.get(report).size() > 0) mail.setToAddresses(Label.Email_Inbound_Recipient.split(','));   
            system.debug(reportMap.get(report).size());
            mail.setSaveAsActivity(false);
            listEmail.add(mail);
            
        }
        
        if(!Test.isRunningTest()) Messaging.sendEmail(listEmail);
    }
    
    public void rescheduleJob(List<AppLog__c> errorLogs) {
        CronTrigger schJob = [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name = 'SchNotificationServiceError' LIMIT 1];
        
        if (schJob != null) System.abortJob(schJob.Id);
        
        if (errorLogs.size() > 0) {
            //String sch = '0 '+String.valueOf(DateTime.now().addMinutes(Integer.valueOf(System.Label.SchNotificationServiceError_Minute)).minute())+' '+System.Label.SchNotificationServiceError_Hour.toString();
            //System.schedule('SchNotificationServiceError', sch, new SchCoreServiceNotification());   
            
            //Database.executeBatch(new LogCoreIntegrationServiceBatch(errorLogs), 20);
            System.enqueueJob(new LogCoreIntegrationServiceQueue(errorLogs));
        }
    }
}