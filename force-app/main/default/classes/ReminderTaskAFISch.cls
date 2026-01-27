global class ReminderTaskAFISch implements Schedulable{
    global void execute(SchedulableContext ctx) {  
        Database.executeBatch(new ReminderTaskAFIBatch(),10); 
    }
}