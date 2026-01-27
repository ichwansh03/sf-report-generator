public class CallLineUpdateBatch implements Database.Batchable<Call_Line__c>{
    public List<Call_Line__c> l_ba {get;set;}
    
    public CallLineUpdateBatch(List<Call_Line__c> ba_l) {
        l_ba = ba_l;
    }
    
    public List<Call_Line__c> start(Database.BatchableContext BS) {
        return this.l_ba;
    }
    
    public void execute(Database.BatchableContext BS, List<Call_Line__c> l_ba) {
        
        list<Call_List__c> cl = [SELECT id, Count_Upload__c, Count_Failed_Upload__c FROM Call_List__c WHERE id =: l_ba[0].Call_List__c];
        try {
            update l_ba;
            
            if (cl[0].Count_Upload__c == NULL) cl[0].Count_Upload__c = 0;
            cl[0].Count_Upload__c += l_ba.size();
            update cl;
        } catch (ListException e) {
            if (cl[0].Count_Failed_Upload__c == NULL) cl[0].Count_Failed_Upload__c = 0;
            cl[0].Count_Failed_Upload__c += l_ba.size();
            update cl;            
        }
    }
    
    public void finish(Database.BatchableContext BS) {
        
    }
}