@isTest(seeAllData=true)
private class ScoreCard_Initial_Test {

    static testMethod void myTest() { 

        Test.startTest();
        
        Score_Card__c sc = [SELECT id, Status__c FROM Score_Card__c LIMIT 1];
        sc.Status__c = 'Approved';
        update sc;
        
        sc.Status__c = 'Draft';
        update sc;

        Test.stopTest();

    }
}