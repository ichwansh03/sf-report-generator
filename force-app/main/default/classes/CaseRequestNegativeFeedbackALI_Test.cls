@isTest
public class CaseRequestNegativeFeedbackALI_Test{
    @testSetup static void setTestData() {
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%ALI%' LIMIT 1].Id,
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
            Entity__c = 'ALI'
        );
        insert u;
                
        User u3 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
            LastName = 'LastName3',
            Email = 'tester3@email.com',
            Username = 'tester3@email.com' + System.currentTimeMillis(),
            CompanyName = 'The Company 3',
            Title = 'title3',
            Alias = 'alias3',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            Entity__c = 'ALI'
        );
        insert u3;
        
		Account a = new Account();
        a.Name = 'Account ALI';
        a.Entity__c = 'ALI';
        insert a;
        
        Contact c = new Contact();
        c.AccountId = a.Id;
        c.LastName = 'LastName';
        c.FirstName = 'FirstName';
        c.Entity__c = 'ALI';
        insert c;
        
    }
    
    public static testMethod void caseRequestALINew() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'RequestALICase'];
        
        String retURL = 'www.url.com/return';
        
        System.runAs(u) {
            Case cs = new Case();
            cs.recordTypeId = rt.Id;
            //cs.ContactId = c.Id;
            cs.OwnerId = u.Id;
            cs.Subject = 'Subject Test Case';
            cs.Entity_Backup__c = 'ALI';
            cs.Case_Type__c = 'Request_Add Debit';
            cs.Type = 'Request';
            cs.Origin = 'Email';
            cs.PIC_Department_LU__c = u.Id;
            insert cs;
        
        
            Test.startTest();
            Test.setCurrentPage(Page.CaseRequestLayoutContactALINew);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'ALI');
            Apexpages.currentPage().getParameters().put('cas5', 'Request'); 
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseRequestLayoutNegativeFeedbackALI con = new CaseRequestLayoutNegativeFeedbackALI(stdController);
            con.cs.Case_Type_Config__c = 'Request_Add Debit';
            con.availableCaseTypeKeeper = 'Request_Add Debit';
            con.selectedCaseTypeKeeper = 'Request_Add Debit';
            con.comment = 'comment';
            con.IsMAGI = FALSE;
            con.IsAMFS = FALSE;
            con.save();
            con.cancel();
            Test.stopTest();
        }  
    }
}