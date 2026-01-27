global class SchDeleteICFNonCCC implements Database.Batchable<sObject>,Schedulable {
    global Database.QueryLocator start(Database.BatchableContext BC) {
    	String query = 'SELECT Id FROM ICF_Non_CCC__c';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<ICF_Non_CCC__c> scope) {
        delete scope;
    }
    global void finish(Database.BatchableContext BC) {
          
    }
    global void execute(SchedulableContext sc) {
        //--Call the batch class to be scheduled
        Type t = Type.forName('SchDeleteICFNonCCC');
        Database.Batchable<sObject> batchClass = ((Database.Batchable<sObject>) t.newInstance());
        
        //--Parameters of ExecuteBatch(context,BatchSize)
        Database.executeBatch(batchClass, 200);
    }

}