public class LogCaseServiceBatch implements Database.Batchable<Case>{

    public List<Case> csh {get; set;}
    
    public LogCaseServiceBatch(List<Case> csh) {
        this.csh = csh;
    }
    
    public List<Case> start(Database.BatchableContext bc) {
        return this.csh;
    }
    
    public void execute(Database.BatchableContext bc, List<Case> csh) {
        System.enqueueJob(new SubmitCaseServiceQueueable(csh));
    }
    
    public void finish(Database.BatchableContext bc) {
        
    }
}