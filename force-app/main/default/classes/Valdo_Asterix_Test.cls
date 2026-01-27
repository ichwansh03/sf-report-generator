@isTest (seealldata=true)
private class Valdo_Asterix_Test{
    static testMethod void test_execute_UseCase1(){
        Log_CTI_Valdo__c x = new Log_CTI_Valdo__c();
        x.SIP__c = '703';
        x.To__c = '0812878734';
        x.Status__c = 'Outbound';
        x.Mode__c = 'API Call Out';
        insert x;
        Valdo_Asterix.getCallOut(x.SIP__c, x.To__c, x.id);
    }
}