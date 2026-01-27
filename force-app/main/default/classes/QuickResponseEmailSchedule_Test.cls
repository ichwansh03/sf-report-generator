@isTest
public class QuickResponseEmailSchedule_Test {
	@testSetup static void setTestData() {
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Supervisor-AMFS' LIMIT 1].Id,
            LastName = 'LastName',
            Email = 'tester@email.com',
            Username = 'tester@email.com' + System.currentTimeMillis(),
            CompanyName = 'The Company',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            Entity__c = 'AMFS'
        );
        insert u;
        
        User u2 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Email Agent A-AMFS' LIMIT 1].Id,
            LastName = 'LastName2',
            Email = 'tester@email.com',
            Username = 'tester@email.com' + System.currentTimeMillis(),
            CompanyName = 'The Company',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            Entity__c = 'AMFS'
        );
        insert u2;
        
        Account a = new Account();
        a.Name = 'Account AMFS';
        a.Entity__c = 'AMFS';
        insert a;
        
        Contact c = new Contact();
        c.AccountId = a.Id;
        c.LastName = 'LastName';
        c.FirstName = 'FirstName';
        c.Entity__c = 'AMFS';
        c.Policy_No__c = '512-2230824';
        insert c;
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.OwnerId = u.Id;
        cs.Entity_Backup__c = 'AMFS';
        cs.Related_Departments__c = 'Quick Response';
        cs.Case_Type__c = 'Request_QRO_Info Manfaat Polis';
        cs.Type = 'Request';
        cs.Origin = 'Phone';
        cs.Related_Departments__c = 'CCC';
        cs.PIC_Department_LU__c = u2.Id;
        cs.Date_of_Submit__c = Date.today();
        cs.Date_of_Service__c = Date.today().addDays(1);
        cs.Time_of_Service__c = Time.newInstance(10, 0, 0, 0);
        cs.Unit_of_Request__c = 'DMU';
        cs.Service_of_Area__c = 'Jakarta Utara';
        cs.address_of_service__c = 'Tanjung Priok';
        cs.Type_of_Request__c = 'Delivery';
        insert cs;
    }
    
    public static testMethod void executeTest() {
    	Test.startTest();
        QuickResponseEmailSchedule sch = new QuickResponseEmailSchedule();
        sch.execute(null);
        Test.stopTest();
    }    
}