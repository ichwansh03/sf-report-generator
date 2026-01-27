@isTest
public class BaseCoreServiceController_Test {
    
    @testSetup
    static void initData(){
        Integer q0 = Limits.getQueries();
        
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%AMFS%' LIMIT 1].Id,
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
        
        Account a = new Account();
        a.Name = 'Account AMFS';
        a.Entity__c = 'AMFS';
        insert a;
        
        Contact c = new Contact();
        c.AccountId = a.Id;
        c.LastName = 'LastName';
        c.FirstName = 'FirstName';
        c.Entity__c = 'AMFS';
        c.Policy_No__c = '100-000-1110001';
        c.PolicyApp__c = 'DMTM';
        insert c;  
        
        Id rtype = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
        Id usdRtype = Schema.SObjectType.User_Detail__c.getRecordTypeInfosByName().get('User Detail Collection AMFS').getRecordTypeId();
        // total 4 query
        
        Call_List__c cl = new Call_List__c();
        cl.RecordTypeId = rtype;
        cl.Activity__c = 'Collection';
        cl.OwnerId = u.id;
        cl.Case_Type__c = 'Redemption TM';
        cl.Expired_Date__c = system.today() + 30;
        cl.Entity__c = 'AMFS';
        cl.Campaign_Name__c = 'Redemption TM';
        cl.Activity__c = 'Collection';
        insert cl;
        // total 27 query
        
        Call_Line__c cLine = new Call_Line__c();
        cLine.Call_List__c = cl.id; 
        cLine.Contact__c = c.id;
        cLine.Activity__c = 'Collection';
        cLine.Policy_No__c = '100-000-1110001'; 
        cLine.Call_Remarks__c = 'OK';
        cLine.Entity__c = 'AMFS';
        insert cLine; 
        // total 35 query
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.Subject = 'Subject T';
        cs.Type = 'Complaint';
        cs.Channel__c = 'Verbal (Call)';
        cs.Customer__c = 'Customer';
        cs.Complainant__c = 'Customer';
        cs.Priority = 'Medium';
        cs.Appeal__c = 'No';
        cs.Complaint_type__c = 'New';
        cs.Customer_type__c = 'Regular';
        insert cs;
        // total 94 query
        System.debug('Queries used by insert: ' + (Limits.getQueries() - q0));
    }
    
    @isTest
    static void generateSObjectTest(){
        Test.startTest();
        Case cse = [SELECT Id FROM Case ORDER BY CreatedDate DESC LIMIT 1];
        BaseCoreServiceController.generateCase(cse.Id);
        BaseCoreServiceController.insertLog(cse.Id, 'case insert', 'Customize Correspondence Robot(DMTM)', system.now().getTime(), 'test request', 'test response');
        
        Call_Line__c cl = [SELECT Id, Call_List__c FROM Call_Line__c ORDER BY CreatedDate DESC LIMIT 1];
        BaseCoreServiceController.generateCallLine(cl.Id);        
        //BaseCoreServiceController.validateRecordType(cl.Call_List__c);
        BaseCoreServiceController.insertLog(cl.Id, 'call line insert', 'AMFS Collection Robot(DMTM)', system.now().getTime(), 'test request', 'test response');
        
        Test.stopTest();
    }
}