@isTest(SeeAllData=true)
private class ChatMapCaseBatch_Test{
    static testMethod void testBatch(){
    List<Case> scope = [SELECT id, SourceId FROM Case WHERE SourceId != NULL and Entity_Backup__c = 'ALI' LIMIT 10 Offset 0];
    List<Case> scope2 = [SELECT id, SourceId FROM Case WHERE SourceId != NULL and Entity_Backup__c = 'ALI' LIMIT 10 Offset 10];
    List<Case> scope3 = [SELECT id, SourceId FROM Case WHERE SourceId != NULL and Entity_Backup__c = 'ALI' LIMIT 10 Offset 20];
    String q = 'SELECT id, SourceId FROM Case WHERE SourceId != NULL LIMIT 10';
    Database.BatchableContext BC;
    ChatMapCaseBatch obj01 = new ChatMapCaseBatch(q);
    obj01.execute(BC, scope);
    obj01.execute(BC, scope2);
    obj01.execute(BC, scope3);
    Database.executeBatch(obj01, 10);
}
}