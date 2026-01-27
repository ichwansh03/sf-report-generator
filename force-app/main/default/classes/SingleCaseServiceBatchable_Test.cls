@isTest
public class SingleCaseServiceBatchable_Test {

    @testSetup
    public static void initData(){
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%AMFS%' LIMIT 1].Id,
            LastName = 'Test',
            Email = 'tester@email.com',
            Username = 'tester@email.com' + System.currentTimeMillis(),
            CompanyName = 'The Company',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            Agent__c = TRUE,
            Entity__c = 'AMFS'
        );
        insert u;
        
        Account a = new Account();
        a.Name = 'Account AMFS';
        a.Entity__c = 'AMFS';
        insert a;
        
        Contact c = new Contact();
        c.AccountId = a.Id;
        c.LastName = 'LastName';
        c.FirstName = 'FirstName';
        c.Entity__c = 'AMFS';
        c.PolicyApp__c = 'DMTM';
        c.Policy_No__c = '190-1234567';
        insert c;
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.OwnerId = u.Id;
        cs.CreatedById = u.Id;
        cs.PIC_Department_LU__c = u.Id;
        cs.Subject = 'Subject T';
        cs.Type = 'Request';
        cs.Channel__c = 'Verbal (Call)';
        cs.Customer__c = 'Customer';
        cs.Complainant__c = 'Customer';
        cs.Priority = 'Medium';
        cs.Appeal__c = 'No';
        cs.Origin = 'Email';
        cs.Complaint_type__c = 'New';
        cs.Customer_type__c = 'Regular';
        cs.Department__c = 'POS';
        cs.Case_Type__c = 'Request_POS_Hold Pengiriman Buku Polis';
        cs.Case_Type_Config__c = 'Request_POS_Hold Pengiriman Buku Polis';
        cs.Description = 'Test';
        insert cs;
    }
    
    @isTest
    static void insertBatchable(){
        Test.startTest();
        DescribeSObjectResult describeResultCase = Case.getSObjectType().getDescribe();
        List<String> caseFieldList = new List<String>(describeResultCase.fields.getMap().keySet());
        String caseFields = String.join(caseFieldList, ',');
        String caseQuery = ' SELECT ' + caseFields + ' FROM Case WHERE Type = \'Request\' AND Policy_Numbers__c = \'190-1234567\' ORDER BY CreatedDate DESC LIMIT 1 ';
        Case caseObj = Database.query(caseQuery);
        
        SingleCaseServiceBatchable.validateCaseTM(caseObj);
        Database.executeBatch(new SingleCaseServiceBatchable(new List<Case>{caseObj}), 20);
        
        Test.stopTest();
    }
}