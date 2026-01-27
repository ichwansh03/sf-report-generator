global class DelBackEndPagingBatch implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    global String query;
    global String url;
    global String shorturl;
    global DelBackEndPagingBatch(String q) {
        this.query = q;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug(LoggingLevel.DEBUG, '***QUERY BATCH: ' + query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<BackEndPaging__c> scope){
        Boolean pos = true;
        Boolean pos2 = true;
        Boolean pos3 = true;
        Boolean pos4 = true;
        
        delete scope;
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
    /*
public string getURL() {


shortURL  = JSON.deserialize(jsonString, System.apexType);
return shortURL;
}
*/
}