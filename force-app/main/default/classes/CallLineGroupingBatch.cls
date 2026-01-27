//Arief - 3 April 2020 : Add AMFS_CallLine_ParentCounter,choosen_campaign,and userId at the finish of the job to count the child of the parent and APE total
public class CallLineGroupingBatch implements Database.Batchable<Call_Line__c> {
    public List<Call_Line__c> l_ba {get;set;}
    public id userId;
    public string choosen_campaign;
    
    public CallLineGroupingBatch(List<Call_Line__c> ba_l,String choosen_campaign,Id userId) {
        l_ba = ba_l;
        this.choosen_campaign = choosen_campaign;
        this.userId = userId;
    }
    
    public List<Call_Line__c> start(Database.BatchableContext BS) {
        return this.l_ba;
    }
    
    public void execute(Database.BatchableContext BS, List<Call_Line__c> l_ba) {
        //Coba mus
        /*
        if(l_ba.size() > 0){
            Call_List__c clJob = new Call_List__c();
            clJob.Id = l_ba[0].Call_List__c;
            clJob.job_id__c = BS.getJobId();
            Update clJob;
        }
		*/
        //Coba mus
        //userId = userInfo.getUserId();
        try {
          update l_ba;
        } catch (ListException e) {
        }
    }
    
    public void finish(Database.BatchableContext BS) {
        List<Call_List__c> checkEntity = [SELECT Id, Entity__c FROM Call_List__c WHERE Id =: choosen_campaign];
        
        if(checkEntity[0].Entity__c != 'ALI'){
            AMFS_CallLine_ParentCounter jb = new AMFS_CallLine_ParentCounter(choosen_campaign,userId,l_ba);
            Database.executeBatch(jb, 65);
        }
    }
}