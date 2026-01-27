global class ChatMapCaseBatch implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    global String query;
    global String url;
    global String shorturl;
    global ChatMapCaseBatch(String q) {
        this.query = q;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug(LoggingLevel.DEBUG, '***QUERY BATCH: ' + query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Case> scope){
        Boolean pos = true;
        Boolean pos2 = true;
        Boolean pos3 = true;
        Boolean pos4 = true;
        for(Case s : scope){
            List<LiveChatTranscript> lct = [SELECT Id, Owner.LastName, List_Agent__c, CaseId, TriggerOff__c FROM LiveChatTranscript
            WHERE id =: s.SourceId];
            if (lct.size() > 0) {
                lct[0].TriggerOff__c = TRUE;
                lct[0].CaseId = s.Id;
                if (lct[0].List_Agent__c == NULL) lct[0].List_Agent__c = 'Agent';
                update lct;
            }
        }  
        //update scope;
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