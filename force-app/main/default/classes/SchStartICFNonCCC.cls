global class SchStartICFNonCCC implements Database.Batchable<sObject>,Schedulable {
    global Database.QueryLocator start(Database.BatchableContext BC) {
    	String query = 'SELECT Id, Status__c FROM ICF_Non_CCC__c WHERE Status__c =\'Check\' '; // AND (MOT__c != \'I BUY\' OR Entity__c != \'AMFS\')  AND ICF_Status__c = \'Ready to Send\' 
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<ICF_Non_CCC__c> scope) {
        for(ICF_Non_CCC__c icf : scope) {
            icf.Status__c = 'Start';
        }
        update scope;
    }
    global void finish(Database.BatchableContext BC) {
          
    }
    global void execute(SchedulableContext sc) {
        //--Call the batch class to be scheduled
        Type t = Type.forName('SchStartICFNonCCC');
        Database.Batchable<sObject> batchClass = ((Database.Batchable<sObject>) t.newInstance());
        
        //--Parameters of ExecuteBatch(context,BatchSize)
        Database.executeBatch(batchClass, 20);
    }
}