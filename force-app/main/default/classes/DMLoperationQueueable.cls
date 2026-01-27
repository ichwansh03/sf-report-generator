public class DMLoperationQueueable implements Queueable {

    List<Call_Line__c> sobjectList = new List<Call_Line__c>();
    Boolean isUpdate = False;
    
    public DMLoperationQueueable(List<Call_Line__c> sobjectList, Boolean isUpdate){
        this.sobjectList = new List<Call_Line__c>(sobjectList);
        this.isUpdate = isUpdate;
    }
    public void execute(QueueableContext context) {
        if(isUpdate){
            update(sobjectList);
        } else {
            insert(sobjectList);
        }
    }
}