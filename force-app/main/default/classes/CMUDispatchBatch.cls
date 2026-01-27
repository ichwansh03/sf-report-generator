public class CMUDispatchBatch implements Database.Batchable<Case> {
    public List<Case> l_ba {get;set;}
    
    public CMUDispatchBatch(List<Case> ba_l) {
        l_ba = ba_l;
    }
    
    public List<Case> start(Database.BatchableContext BS) {
        return this.l_ba;
    }
    
    public void execute(Database.BatchableContext BS, List<Case> l_ba) {
        update l_ba;
    }
    
    public void finish(Database.BatchableContext BS) {
        
    }
}