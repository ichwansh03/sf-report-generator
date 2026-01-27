public class LogCallLineServiceBatch implements Database.Batchable<Call_Line__c> {

    public List<Call_Line__c> clines {get; set;}
    
    public LogCallLineServiceBatch(List<Call_Line__c> clines) {
        this.clines = clines;
    }
    
    public List<Call_Line__c> start(Database.BatchableContext bc) {
        return this.clines;
    }
    
    public void execute(Database.BatchableContext bc, List<Call_Line__c> clines) {
        System.enqueueJob(new RequestAssesmentQueueable(clines));
    }
    
    public void finish(Database.BatchableContext bc) {
        
    }
}