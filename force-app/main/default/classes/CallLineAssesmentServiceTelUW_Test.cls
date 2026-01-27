@isTest
public class CallLineAssesmentServiceTelUW_Test {

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
        ID rtClWecall = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('TelUW').getRecordTypeId();
        
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
        
		UW_Code_Mapping__c uw = new UW_Code_Mapping__c();
        uw.Name = 'Busy Person';
        uw.UW_Code__c = 'T7';
        uw.Description__c = 'Pending TeleUW : Nasabah Tidak dapat dihubungi karena sedang sibuk';
        insert uw;
        
        TelUW_Result__c result = new TelUW_Result__c();
        result.Name = 'Tidak Berhasil';
        result.Call_Status__c = 'Uncontacted';
        result.Reason_Status__c = 'Busy Line';
        result.Result_Call__c = 'TelUW Tidak Berhasil';
        insert result;
        
        TelUW_Result__c result2 = new TelUW_Result__c();
        result2.Name = 'Berhasil';
        result2.Call_Status__c = 'Contacted';
        result2.Reason_Status__c = 'Success';
        result2.Result_Call__c = 'TelUW Berhasil';
        insert result2;
        
        TelUW_Result__c result3 = new TelUW_Result__c();
        result3.Name = 'Hold';
        result3.Call_Status__c = 'Hold';
        result3.Result_Call__c = 'TelUW Hold';
        insert result3;
        
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
        cpg.Case_Type__c = 'TelUW';
        cpg.Campaign_Name__c = 'Collection-TelUW-Test#20240718';
        cpg.Expired_Date__c = cpgExpDate; 
        insert cpg;
        
        Call_line__c cl = new Call_Line__c();
        cl.RecordTypeId = rtClWecall;
        cl.Contact__c = c.Id;
        cl.Call_List__c = cpg.Id;
        cl.Case_Type__c = 'TelUW';
        cl.policy_no__c = c.Policy_No__c;
        cl.Call_Remarks__c = 'Remarks';
        cl.Notes__c = 'Notes';
        cl.Entity__c = 'AMFS';
        cl.Contacted_Number__c = '085156080110';
        cl.Activity_Result__c = 'Uncontacted';
        cl.Verification__c = 'Busy Line';
        cl.Agent__c = u.Id;
        insert cl;
        
        return cl;
    }
    
    @isTest
    public static void insertAssesmentServiceTest(){
        Test.startTest();
        String caseType = 'TelUW';
        Call_Line__c cl = replicateCallLineRecord(caseType);
        cl.Activity_Result__c = 'Hold';
        cl.Confirm__c = true;
        cl.Notes__c = 'Update hold';
        update cl;
        system.debug('**cl: '+cl);        
        
        List<Call_Line__c> clines = new List<Call_Line__c>();
        clines.add(cl);
        
        RequestAssesmentQueueable queueable = new RequestAssesmentQueueable(clines);
        system.enqueueJob(queueable);
        
        CallLineAssesmentServiceTelUW.requestTelUw(cl.Id);
        
        Map<String, String> prop = new Map<String, String>();
        prop.put('Policy_No__c',cl.Policy_No__c);
        prop.put('Id', cl.Id);
        System.enqueueJob(new CallLineAppDetailQueueable(prop));
        CallLineAppDetailQueueable.validatePolicyStatus('[09] POLICY ISSUED',prop);
        
        System.enqueueJob(new CallLineNotifRemarkQueueable(prop));
        
        System.enqueueJob(new RecordPolicyNotesQueueable(prop));
        RecordPolicyNotesService notes = new RecordPolicyNotesService();
        notes.toStringJSON();
        
        Test.setMock(HttpCalloutMock.class, new CallLineAssesmentServiceRLS_TestMock());
        
        Test.stopTest();
    }
    
    @isTest
    public static void insertAssesmentServiceFailedTest(){
        Test.startTest();
        String caseType = 'TelUW';
        Call_Line__c cl = replicateCallLineRecord(caseType);
        cl.Activity_Result__c = 'Contacted';
        cl.Verification__c = 'Success';
        cl.Confirm__c = true;
        cl.Notes__c = 'TRIGGER_EIPEXC';
        update cl;
        system.debug('**cl: '+cl);        
        
        List<Call_Line__c> clines = new List<Call_Line__c>();
        clines.add(cl);
        
        RequestAssesmentQueueable queueable = new RequestAssesmentQueueable(clines);
        system.enqueueJob(queueable);
        
        CallLineAssesmentServiceTelUW.requestTelUw(cl.Id);
        
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        
        Test.stopTest();
    }
}