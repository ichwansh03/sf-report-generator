@isTest
private class MID_Secure_Payment_Trigger_Test {
    static testMethod void testRecord() {
        Test.startTest();
        MID_Secure_Payment__c mid = new MID_Secure_Payment__c();
        mid.Origin__c = 'PureCloud';
        mid.Payment_Type__c = 'saving';
        mid.Status__c = 'Waiting PureCloud';
        mid.SFDC_Order_Id__c = 'SFIFB_12347588115_1592797949147_Test';
        mid.Account_Number__c = '12345678901';
        //mid.Bank_Name__c = 'Bank Central Asia';
        
        insert mid;

        mid.Status__c = 'Accepted';
        update mid;
        
        Test.stopTest();
    }
}