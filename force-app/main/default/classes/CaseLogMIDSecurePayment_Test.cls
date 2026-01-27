@isTest(seeAllData=true)
private class CaseLogMIDSecurePayment_Test {

    static testMethod void myTest() { 
        
        case cs = [SELECT Id, ContactId FROM case WHERE ContactId != NULL Limit 1];
        
        MID_Secure_Payment__c mid = new MID_Secure_Payment__c();
        //mid.Name
        	mid.Case__c = cs.id;
        	mid.Checklist__c = TRUE;
            mid.Log_a_Case__c = TRUE;
            mid.SFDC_Order_Id__c = '123456789';
            mid.Account_Name__c = 'Testing';
            mid.Card_Holder_Name__c = 'Testing';
            mid.Origin__c = 'Purecloud';
            mid.Payment_Frequency__c = '';
            mid.Payment_Type__c = 'saving';
            mid.Contact__c = cs.ContactId;
            mid.Status__c = 'Waiting';
        insert mid;

        ApexPages.StandardController stc = new ApexPages.StandardController(cs);
        
        CaseLogMIDSecurePayment b = new CaseLogMIDSecurePayment(stc);
        Test.startTest();
        String sP = b.idprospect;
        b.Save();
        Test.stopTest();

    }
}