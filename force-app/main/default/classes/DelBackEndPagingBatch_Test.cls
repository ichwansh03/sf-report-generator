@isTest(SeeAllData=true)
private class DelBackEndPagingBatch_Test{
    static testMethod void testBatch(){
    List<BackEndPaging__c> scope = [SELECT id FROM BackEndPaging__c LIMIT 10 Offset 0];
    List<BackEndPaging__c> scope2 = [SELECT id FROM BackEndPaging__c LIMIT 10 Offset 10];
    List<BackEndPaging__c> scope3 = [SELECT id FROM BackEndPaging__c LIMIT 10 Offset 20];
    String q = 'SELECT id FROM BackEndPaging__c LIMIT 10';
    Database.BatchableContext BC;
    DelBackEndPagingBatch obj01 = new DelBackEndPagingBatch(q);
    obj01.execute(BC, scope);
    obj01.execute(BC, scope2);
    obj01.execute(BC, scope3);
    Database.executeBatch(obj01, 10);
}
}