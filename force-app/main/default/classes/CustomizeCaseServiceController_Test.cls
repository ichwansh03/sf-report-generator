@isTest
public class CustomizeCaseServiceController_Test {
    
    @isTest(seeAllData=true)
    public static void getFilterReportTest(){
        Case cs = [SELECT Id, Policy_Numbers__c, Case_Owner_CCC__c, Department__c, Origin, Status, Contact.PolicyApp__c FROM Case WHERE Entity__c = 'AMFS' AND Type = 'Request' LIMIT 1];
        Boolean isUserInb = BaseCoreServiceController.getValueFilterReport('Customize Inbound Robot (RLS)', 'Case.CreatedBy.Name').toUpperCase().contains(cs.Case_Owner_CCC__c.toUpperCase().trim());
        Boolean isOriginCor = BaseCoreServiceController.getValueFilterReport('Customize Correspondence Robot', 'Case.Origin').contains(cs.Origin);
    }
    
    private static Case replicateCaseRecord(String policyApp) {
        
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
        c.PolicyApp__c = policyApp;
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
        cs.Origin = 'Test';
        cs.Complaint_type__c = 'New';
        cs.Customer_type__c = 'Regular';
        cs.Department__c = 'Collection & CR';
        cs.Case_Type__c = 'Request_CR_Redemption';
        cs.Case_Type_Config__c = 'Request_CR_Redemption';
        cs.Description = 'Test';
        insert cs;
        
        return cs;
    }
    
    @isTest
    public static void sendRequestDMTMTest(){
        
        Case cs = replicateCaseRecord('DMTM');
        
        System.debug('***case_id: ' + cs.Id);
        
        Test.startTest();
        cs.Description = 'Update desc';
        update cs;
        CallLineTriggerHelper.skipMultipleUpdate = true;
        List<Case> cases = new List<Case>();
        cases.add(cs);

        system.enqueueJob(new SubmitCaseServiceQueueable(cases));
        
        CustomizeCaseServiceController.sendRequest(cs.Id);
        
        Test.setMock(HttpCalloutMock.class, new CustomizeCaseServiceController_TestMock());
        
        BaseCoreServiceController.insertLog(cs.Id, 'success', 'Customize Correspondence Robot(DMTM)', system.now().getTime(), 'test', 'test');

        Test.stopTest();
    }
    
    @isTest
    public static void sendReqDMTMTestFailed(){
        Case cs = replicateCaseRecord('DMTM');
        
        System.debug('***case_id: ' + cs.Id);
        
        Test.startTest();
        cs.Description = 'Update desc';
        update cs;
        CallLineTriggerHelper.skipMultipleUpdate = true;
        List<Case> cases = new List<Case>();
        cases.add(cs);
        
        system.enqueueJob(new SubmitCaseServiceQueueable(cases));
        
        CustomizeCaseServiceController.sendRequest(cs.Id);
        
        BaseCoreServiceController.insertLog(cs.Id, 'success', 'Customize Correspondence Robot(DMTM)', system.now().getTime(), 'test', 'test');
        
        Test.stopTest();
    }
    
    @isTest
    public static void sendRequestRLSTest(){
        
        Case cs = replicateCaseRecord('RLS');
        System.debug('***case_id: ' + cs.Id);
        
        Test.startTest();
        cs.Description = 'Update desc';
        update cs;
        CallLineTriggerHelper.skipMultipleUpdate = true;
        List<Case> cases = new List<Case>();
        cases.add(cs);

        system.enqueueJob(new SubmitCaseServiceQueueable(cases));
        
        CustomizeCaseServiceController.sendRequest(cs.Id);
        
        Test.setMock(HttpCalloutMock.class, new CustomizeCaseServiceController_TestMock());
        
        BaseCoreServiceController.insertLog(cs.Id, 'success', 'Customize Correspondence Robot(RLS)', system.now().getTime(), 'test', 'test');

        Test.stopTest();
    }
    
    @isTest
    public static void sendReqRLSTestFailed(){
        Case cs = replicateCaseRecord('RLS');
        System.debug('***case_id: ' + cs.Id);
        
        Test.startTest();
        cs.Description = 'Update desc';
        update cs;
        CallLineTriggerHelper.skipMultipleUpdate = true;
        List<Case> cases = new List<Case>();
        cases.add(cs);
        
        system.enqueueJob(new SubmitCaseServiceQueueable(cases));
        
        CustomizeCaseServiceController.sendRequest(cs.Id);
        
        BaseCoreServiceController.insertLog(cs.Id, 'success', 'Customize Correspondence Robot(RLS)', system.now().getTime(), 'test', 'test');
        
        Test.stopTest();
    }
    
    @isTest
    public static void submitCaseQueueableFailedTest(){
        
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
        
        Case cs = new Case();
        cs.PIC_Department_LU__c = u.Id;
        cs.Subject = 'Subject T';
        cs.Type = 'Request';
        cs.Channel__c = 'Verbal (Call)';
        cs.Customer__c = 'Customer';
        cs.Complainant__c = 'Customer';
        cs.Priority = 'Medium';
        cs.Appeal__c = 'No';
        cs.Complaint_type__c = 'New';
        cs.Customer_type__c = 'Regular';
        cs.Case_Type__c = 'Request_CR_Redemption';
        cs.Case_Type_Config__c = 'Request_CR_Redemption';
        cs.Description = 'Test';
        insert cs;
        
        Test.startTest();
        cs.Description = 'Update desc';
        update cs;
        CallLineTriggerHelper.skipMultipleUpdate = true;
        List<Case> cases = new List<Case>();
        cases.add(cs);

        system.enqueueJob(new SubmitCaseServiceQueueable(cases));
        
        Test.stopTest();
    }
    
}