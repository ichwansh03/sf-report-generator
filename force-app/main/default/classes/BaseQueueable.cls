public abstract class BaseQueueable implements Queueable {

    public Integer thread;
    
    public void execute(QueueableContext context) {
        Savepoint savepoint = Database.setSavepoint();
        
        try {
            doExecute(context);
            delete [SELECT Id FROM Async_Request__c WHERE Async_Apex_Job_Id__c = :context.getJobId()];
        } catch (Exception e) {
            Database.rollback(savepoint);
            
            Async_Request__c asyncReq = [SELECT Id FROM Async_Request__c WHERE Async_Apex_Job_Id__c = :context.getJobId() LIMIT 1];
            asyncReq.Status__c = 'Error';
            asyncReq.Error_Message__c = e.getTypeName() + ' : ' + e.getMessage() + ' (Line ' + e.getLineNumber() + ') ' + e.getStackTraceString();
            update asyncReq;
            
            QueueableManager.enqueueNextJob(this.thread);
            return;
        }
        
        QueueableManager.enqueueNextJob(this.thread);

    }
    
    public abstract void doExecute(QueueableContext qc);
}