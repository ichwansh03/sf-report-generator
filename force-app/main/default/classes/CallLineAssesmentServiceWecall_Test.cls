@isTest
public class CallLineAssesmentServiceWecall_Test {

    @testSetup
    public static void createToken() {
        Access_Token__c at = new Access_Token__c();
        at.Endpoint__c = 'https://b2bsso-test.axa.co.id/oauth/token';
        at.Token__c = 'qwerty123';
        insert at;
    }
    
    private static Call_Line__c replicateCallLineRecord(String caseType) {
        
        ID rtContact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Contact').getRecordTypeId();
        ID rtConfirmationAMFS = Schema.SObjectType.Call_list__c.getRecordTypeInfosByName().get('Confirmation AMFS').getRecordTypeId();
        ID rtClWecall = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
        
        Date dtNow = Date.today();
        Date cpgExpDate = dtNow.addDays(19);
        
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
        
        Welcome_Call_Result__c wecall = new Welcome_Call_Result__c();
        wecall.Call_Status__c = 'Uncontacted';
        wecall.Reason_Status__c = 'Busy Line';
        wecall.Result_Call__c = 'Welcome Call Tidak Berhasil';
        wecall.Name = 'Wecall Tidak Berhasil';
        insert wecall;
        
        Welcome_Call_Result__c wecall2 = new Welcome_Call_Result__c();
        wecall2.Call_Status__c = 'Contacted';
        wecall2.Reason_Status__c = 'Success';
        wecall2.Result_Call__c = 'Welcome Call Berhasil';
        wecall2.Name = 'Wecall Berhasil';
        insert wecall2;
        
        Account a = new Account();
        a.Name = 'Account AMFS';
        a.Entity__c = 'AMFS';
        insert a;
        
        Contact c = new Contact();
        c.AccountId = a.Id;
        c.LastName = 'LastName';
        c.FirstName = 'FirstName';
        c.Entity__c = 'AMFS';
        c.PolicyApp__c = 'RLS';
        c.Policy_No__c = '190-1234567';
        insert c;
        
        Call_List__c cpg = new Call_List__c();
        cpg.RecordTypeId = rtConfirmationAMFS;
        cpg.Entity__c = 'AMFS';
        cpg.Activity__c = 'Collection';
        cpg.Case_Type__c = 'Welcome Call';
        cpg.Campaign_Name__c = 'Collection-Welcome Call-Test#20240718';
        cpg.Expired_Date__c = cpgExpDate; 
        insert cpg;
        
        Call_line__c cl = new Call_Line__c();
        cl.RecordTypeId = rtClWecall;
        cl.Contact__c = c.Id;
        cl.Call_List__c = cpg.Id;
        cl.Case_Type__c = 'Welcome Call';
        cl.policy_no__c = c.Policy_No__c;
        cl.Call_Remarks__c = 'Remarks';
        cl.Notes__c = 'Notes';
        cl.Entity__c = 'AMFS';
        cl.Contacted_Number__c = '085156080110';
        cl.Activity_Result__c = 'Uncontacted';
        cl.Reason_Status_Config__c = 'Busy Line';
        cl.Agent__c = u.Id;
        insert cl;
        
        return cl;
    }
    
    @isTest
    public static void insertAssessmentServiceTest(){
        Test.startTest();
        String caseType = 'Welcome Call';
        Call_Line__c cl = replicateCallLineRecord(caseType);
        cl.Activity_Result__c = 'Contacted';
        cl.Reason_Status_Config__c = 'Success';
        cl.Confirm__c = true;
        cl.Notes__c = 'Not Conserved';
        update cl;
        system.debug('**cl: '+cl);        
        
        List<Call_Line__c> clines = new List<Call_Line__c>();
        clines.add(cl);
        
        RequestAssesmentQueueable queueable = new RequestAssesmentQueueable(clines);
        system.enqueueJob(queueable);
        
        CallLineAssesmentServiceWecall.requestWecall(cl.Id);
        
        Test.stopTest();
    }
    
    @isTest
    public static void insertAssessmentServiceFailedTest(){
        Test.startTest();
        String caseType = 'Welcome Call';
        Call_Line__c cl = replicateCallLineRecord(caseType);
        cl.Activity_Result__c = 'Contacted';
        cl.Reason_Status_Config__c = 'Success';
        cl.Confirm__c = true;
        cl.Notes__c = 'TRIGGER_EIPEXC';
        update cl;
        system.debug('**cl: '+cl);        
        
        List<Call_Line__c> clines = new List<Call_Line__c>();
        clines.add(cl);
        
        RequestAssesmentQueueable queueable = new RequestAssesmentQueueable(clines);
        system.enqueueJob(queueable);
        
        CallLineAssesmentServiceWecall.requestWecall(cl.Id);
        
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        
        Test.stopTest();
    }
}