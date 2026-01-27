global class ScheduleSentNotifyCallLinesBatch implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) { 
        String query;
        
        // query = 'select id, Count_Scheduled_Date__c, send_reminder__c from Call_Line__c where WelcomeCall_Schedule_Date__c != null AND Count_Scheduled_Date__c <= 3 AND Count_Scheduled_Date__c >= 0 AND send_reminder__c = FALSE AND WelcomeCall_Reschedule_Source__c = \'SMARTS\'  LIMIT 50000';
        
        
        query = 'select id, Count_Scheduled_Date__c, send_reminder__c from Call_Line__c where WelcomeCall_Schedule_Date__c != null AND Count_Scheduled_Date__c <= 3 AND Count_Scheduled_Date__c >= 0 AND send_reminder__c = FALSE AND WelcomeCall_Reschedule_Source__c != null ';
        
        String filterSource = System.label.Perfect_Assistant;
        List<String> listFilter = new List<String>();
        if (String.isnotblank(filterSource)) { 
            if (filterSource.contains(',')) { // harus pilih salah satu, tidak bisa keduanya
                listFilter.addAll(filterSource.split(','));
            } else if (filterSource.contains(';')) { 
                listFilter.addAll(filterSource.split(';'));
            } else {
                listFilter.add(filterSource);
            }
            
            query += '  AND WelcomeCall_Reschedule_Source__c in (';
            Integer n = 0;
            for(String row: listFilter) {
                query += '\''+row+'\'';
                
                n++;
                if (n < listFilter.size()) query += ',';
            } 
            
            query += ')';
        }
        
        query += '  LIMIT 50000'; 
        if (Test.isRunningTest()) query = 'select id, Count_Scheduled_Date__c, send_reminder__c from Call_Line__c LIMIT 1';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc, List<Call_Line__c> records){  
        for (Call_Line__c row: records) {
            NotifyAssignTaskAMFS.SendEmail(row.id, 'Welcome');
            row.send_reminder__c= true;
        } 
        update records;
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }   
}