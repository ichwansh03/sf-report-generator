@isTest
public class CallLineAssesmentServiceTM_Test {
    
	@testSetup
    public static void createToken() {
        Access_Token__c at = new Access_Token__c();
        at.Endpoint__c = 'https://b2bsso-test.axa.co.id/oauth/token';
        at.Token__c = 'qwerty123';
        insert at;
    }
    
    private static Call_Line__c replicateCallLineRecord(String caseType) {
        
        ID rtContact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Contact').getRecordTypeId();
        ID rtCollectionAMFS = Schema.SObjectType.Call_list__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
        ID rtClRedemp = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('Collection AMFS 8').getRecordTypeId();
        
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
        
        CallLine_Reason_Type__c reasonType = new CallLine_Reason_Type__c();
        reasonType.Name = 'Cause Of Death';
        reasonType.Type_ID__c = 'COD';
        reasonType.Value__c = 'Cause Of Death-[Claim Investigation]';
        insert reasonType;
        
        Call_Status_Type__c statusType = new Call_Status_Type__c();
        statusType.Name = 'Pending';
        statusType.Status_ID__c = 'PE';
        insert statusType;
        
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
        
        Call_List__c cpg = new Call_List__c();
        cpg.RecordTypeId = rtCollectionAMFS;
        cpg.Entity__c = 'AMFS';
        cpg.Activity__c = 'Collection';
        cpg.Case_Type__c = 'Redemption TM';
        cpg.Campaign_Name__c = 'Collection-Redemption TM-Test#20240718';
        cpg.Expired_Date__c = cpgExpDate; 
        insert cpg;
        
        Call_line__c cl = new Call_Line__c();
        cl.RecordTypeId = rtClRedemp;
        cl.Contact__c = c.Id;
        cl.Call_List__c = cpg.Id;
        cl.Case_Type__c = 'Redemption TM';
        cl.policy_no__c = c.Policy_No__c;
        cl.Call_Remarks__c = 'Remarks';
        cl.Notes__c = 'Notes';
        cl.Entity__c = 'AMFS';
        cl.Contacted_Number__c = '085156080110';
        cl.Activity_Result__c = 'Retry';
        cl.Reason_Status_Config__c = 'Busy Line';
        cl.Agent__c = u.Id;
        insert cl;
        
        return cl;
    }
    
    @isTest
    public static void insertConservationTest(){
        
        Test.startTest();
        String caseType = 'Redemption TM';
        Call_Line__c cl = replicateCallLineRecord(caseType);
        cl.Activity_Result__c = 'Pending';
        cl.Reason_Status_Config__c = 'Cause Of Death-[Claim Investigation]';
        cl.Confirm__c = true;
        cl.Call_Remarks__c = 'Update Remarks';
        update cl;
        system.debug('**cl: '+cl);        

        List<Call_Line__c> clines = new List<Call_Line__c>();
        clines.add(cl);

        RequestAssesmentQueueable queueable = new RequestAssesmentQueueable(clines);
        system.enqueueJob(queueable);
        
        CallLineAssesmentServiceTM.requestPolicyTM(cl.Id);
        
        Test.setMock(HttpCalloutMock.class, new CallLineAssesmentServiceTM_TestMock());
        
        Test.stopTest();
    }
    
    
    @isTest
    public static void insertNotConservationTest(){
        Test.startTest();
        String caseType = 'Redemption TM';
        Call_Line__c cl = replicateCallLineRecord(caseType);
        cl.Activity_Result__c = 'Pending';
        cl.Reason_Status_Config__c = 'Cause Of Death-[Claim Investigation]';
        cl.Confirm__c = true;
        cl.Call_Remarks__c = 'Not Conserved';
        update cl;
        system.debug('**cl: '+cl);        
        
        List<Call_Line__c> clines = new List<Call_Line__c>();
        clines.add(cl);
        
        RequestAssesmentQueueable queueable = new RequestAssesmentQueueable(clines);
        system.enqueueJob(queueable);
        
        CallLineAssesmentServiceTM.requestPolicyTM(cl.Id);
        
        Test.setMock(HttpCalloutMock.class, new CallLineAssesmentServiceTM_TestErrorMock());
        
        Test.stopTest();
    }
    
    @isTest
    public static void insertCallNoteTest(){
        String caseType = 'Redemption TM';
        Call_Line__c cl = ReplicateCallLineRecord(caseType);
        cl.Confirm__c = true;
        cl.Call_Status_Config__c = 'Uncontacted';
        cl.Reason_Status_Config__c = 'Busy Line';
        cl.Call_Remarks__c = 'Update Remarks';
        cl.Case_Type__c = 'Lapse TM';
        update cl;
        system.debug('**cl: '+cl);
        
        Test.startTest();
        List<Call_Line__c> clines = new List<Call_Line__c>();
        clines.add(cl);
        RequestAssesmentQueueable queueable = new RequestAssesmentQueueable(clines);
        system.enqueueJob(queueable);
        CallLineAssesmentServiceTM.requestPolicyTM(cl.Id);
        Test.setMock(HttpCalloutMock.class, new CallLineAssesmentServiceTM_TestMock());
        Test.stopTest();
        
    }
    
}