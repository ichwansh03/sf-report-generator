global class ScheduleSentNotifyCallLines implements Schedulable {
	global void execute(SchedulableContext sc){ 
        ScheduleSentNotifyCallLinesBatch batchNotify = new ScheduleSentNotifyCallLinesBatch();
        Database.executeBatch(batchNotify,100);
    }	
}