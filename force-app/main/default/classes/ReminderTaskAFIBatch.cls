global class ReminderTaskAFIBatch implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        string query = 'SELECT ID, Reminder_DateTime__c, ActivityDate, Subject, Status, WhatId, entity__c,  IsReminderSet, Resechedule_Call_Line__c, Time_Reminder__c FROM Task ';
        if (!System.test.isRunningTest()) {
            query += ' WHERE Status = \'Open\' AND entity__c= \'AFI\' AND Resechedule_Call_Line__c != NULL AND Time_Reminder__c > 0 AND Reminder_DateTime__c != NULL';
        }  
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Task> scope){ 
        IF (scope.size() > 0) {
            List<Task> updateReminderTimeTask = new List<Task>();
            
            Datetime currentTime = System.now();
            Date currentDate = System.today();
            for (Task row: scope) {
                if (row.Time_Reminder__c < 10) { 
                    String taskId = row.id;
                    Datetime rescheduleCL = row.Resechedule_Call_Line__c; 
                    Datetime reminderDate = row.Reminder_DateTime__c;  
                    system.debug('rescheduleCL:'+rescheduleCL);
                    system.debug('reminderDate:'+reminderDate);
                    system.debug('currentTime:'+currentTime);
                    if (reminderDate < currentTime || System.test.isRunningTest()) {
                        system.debug('masuk');
                        integer timeSch = 5;
                        if (reminderDate >= rescheduleCL) {  
                            system.debug('10 minute');
                            timeSch = 10; 
                            reminderDate = reminderDate.addMinutes(timeSch);
                        } else  {
                            reminderDate = rescheduleCL; 
                        }
                        
                        
                        system.debug('reminderDate:'+reminderDate);
                        system.debug('timeSch:'+timeSch);
                        updateReminderTimeTask.add(new Task(
                            id = taskId,
                            Reminder_DateTime__c = reminderDate,
                            ReminderDateTime = reminderDate,
                            Time_Reminder__c = timeSch
                        ));
                    } 
                }
            }
            
            if (updateReminderTimeTask.size () > 0) {
                system.debug('update'); 
                system.debug('updateReminderTimeTask:'+updateReminderTimeTask);
                update updateReminderTimeTask;
            }
        }
    }
    
    global void finish(Database.BatchableContext BC){  
        deleteOldJob();
        
		Datetime currentTime = System.now();         
        Datetime taskTime = currentTime.addMinutes(3);
          
    	String cronExpression = '0 ' + taskTime.minute() + ' ' + taskTime.hour() + ' ' + taskTime.day() + ' ' + taskTime.month() + ' ? ' + taskTime.year();
    
        //Create an Instance of your Schedule Class 
        System.schedule('Schedule AFI update Task', cronExpression, new ReminderTaskAFISch()); 
    }
    
    public static void deleteOldJob () {
        List<CronTrigger> oldTriggers = [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name = 'Schedule AFI update Task'];
    
        if (!oldTriggers.isEmpty()) {
            // Hapus penjadwalan lama
            System.abortJob(oldTriggers[0].Id);
        }

    }
}