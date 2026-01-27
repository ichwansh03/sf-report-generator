@isTest(seeAllData=true)
private class ContactLogCTIValdo_Test {

    static testMethod void myTest() { 
        contact ct = [SELECT Id FROM contact Limit 1];

        ApexPages.StandardController stc = new ApexPages.StandardController(ct);
        
        ContactLogCTIValdo b = new ContactLogCTIValdo(stc);
        Test.startTest();
        String sP = b.idprospect;
        b.Save();
        Test.stopTest();

    }
}