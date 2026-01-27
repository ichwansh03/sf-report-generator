@isTest(seealldata=true)
private class JatisBatch_Test{
    static testMethod void testBatch(){
        list<ID> listsms = new List<ID>();
        Email_SMS_Log__c idsms = [select id from Email_SMS_Log__c order by createddate desc limit 1];
        listsms.add(idsms.id);
        system.debug('idsms: '+idsms);
        JatisBatch bb = new JatisBatch(listsms);
        Database.executeBatch(bb, 10);
    }
    
     static testMethod void testCMUBatch(){
        list<ID> listsms = new List<ID>();
        Email_SMS_Log__c idsms = [select id from Email_SMS_Log__c order by createddate desc limit 1];
        listsms.add(idsms.id);
        system.debug('idsms cmu: '+idsms);
        JatisBatch bb = new JatisBatch(listsms);
        Database.executeBatch(bb, 10);
    } 
}