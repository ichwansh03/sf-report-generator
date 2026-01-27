@isTest
public class Trigger_ContactPolicyTakeoutTest {
    
    @testSetup
    static void initContact(){
        Contact contact = new Contact();
        contact.Policy_No__c = '410-7654321';
        contact.LastName = 'Abdullah';
        contact.mdmid_owner__c = '74123234';
        contact.Entity__c = 'AMFS';
        contact.PolicyApp__c = 'RLS';
        insert contact; 
    }
    
    @isTest
    static void contactTakeoutTest_Success() {
        Test.startTest();
       	Contact contact = [SELECT Id FROM Contact LIMIT 1];
        Call_Line_Retention__c cl = new Call_Line_Retention__c();
       	cl.Contact__c = contact.Id;
        cl.Remark_Description__c = 'Req by user';
        cl.Retention_Status__c = 'Takeout';
        insert cl;
        
		Contact contact2 = new Contact();
        contact2.Policy_No__c = '410-1234567';
        contact2.LastName = 'Ali';
        contact2.mdmid_owner__c = '74123234';
        contact2.PolicyApp__c = 'RLS';
        contact2.Entity__c = 'AMFS';
        insert contact2;
        
        Test.stopTest();
    }
    
    @isTest
    static void contactReleaseTest_Success(){
		Test.startTest();
       	Contact contact = [SELECT Id FROM Contact LIMIT 1];
        Call_Line_Retention__c cl = new Call_Line_Retention__c();
       	cl.Contact__c = contact.Id;
        cl.Remark_Description__c = 'Req by user';
        cl.Retention_Status__c = 'Release';
        insert cl;
        
		Contact contact2 = new Contact();
        contact2.Policy_No__c = '410-1234567';
        contact2.LastName = 'Ali';
        contact2.mdmid_owner__c = '74123234';
        contact2.PolicyApp__c = 'RLS';
        contact2.Entity__c = 'AMFS';
        insert contact2;
        
        List<Call_Line_Retention__c> listclr = [SELECT Id, mdmid_owner__c, Policy_No__c, Retention_Status__c FROM Call_Line_Retention__c WHERE mdmid_owner__c = :contact2.mdmid_owner__c];
        System.assertEquals(1, listclr.size(), 'release status should be cannot inserted to object call line retention');
        Test.stopTest();        
    }
}