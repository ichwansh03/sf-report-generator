global with sharing class ClaimRejectSch implements Schedulable, Database.Batchable<sObject>{
    global void execute(SchedulableContext sc) { 
        // To start the batch job: 
        Database.executeBatch(new ClaimRejectSch(), 25);
    }
    
    global Iterable<sObject> start(Database.BatchableContext bc){
        String filter = System.Label.ICF_I_Claim_Reject;
        List<ICF_Non_Real_Time__c> data = new List<ICF_Non_Real_Time__c> ();
        
        Date fiveDaysAgo = System.today().addDays(-5);
        Date sevenDaysAgo = System.today().addDays(-7);
        
        DescribeSObjectResult describeResult = ICF_Non_Real_Time__c.getSObjectType().getDescribe();
        List<String> FieldList = new List<String>(describeResult.fields.getMap().keySet());
        String Fields = String.join(FieldList, ',');
        String query = ' SELECT ' +Fields+ ' from ICF_Non_Real_Time__c where ' + filter;
        data = Database.query(query);
        
        return data;
    }
    
    global void execute(Database.BatchableContext BC, List<ICF_Non_Real_Time__c> listdata){ 
        Set<Id> idICF = new Set<Id>();
        List<ICF_Non_Real_Time__c> list_data = new List<ICF_Non_Real_Time__c> ();
        if(listdata.size() > 0){
            for(ICF_Non_Real_Time__c d:listdata){
                idICF.add(d.id);
            }
        }
        System.enqueueJob(new CreateEmailSMSLogClaimReject.CreateEmailSMSLog(idICF));
    }
    
    global void finish(Database.BatchableContext bc){
        
    }
    
}