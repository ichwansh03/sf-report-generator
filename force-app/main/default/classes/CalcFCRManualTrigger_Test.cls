@isTest
private class CalcFCRManualTrigger_Test {
    static testMethod void testRecord() {        
        Test.startTest();
        Calc_FCR_Manual__c data = new Calc_FCR_Manual__c();
        data.Case_Date__c = date.today();
        data.Contact_ID__c = '0056F000004TDzz';
        insert data;
        Test.stopTest();        
    }
}