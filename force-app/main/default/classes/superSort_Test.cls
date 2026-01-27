@isTest(seeAllData = true)
public class superSort_Test {
    public static testmethod void superSortTest() {
        Test.startTest();
        
        List<NumberCounter__c> numberCounters = [SELECT Id,  Name, Counter__c, Entity__c FROM NumberCounter__c];
        if (numberCounters.size() > 0) {
            superSort.sortList(numberCounters, 'Name', 'ASC');
            superSort.sortList(numberCounters, 'Id', 'ASC');
        }
        
        Test.stopTest();
    }
}