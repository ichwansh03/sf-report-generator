@isTest
public class CallLineAssNoteControllerTest {
    Static testMethod void loadAssNotesSummaryTest() {
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id contactRtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        system.debug('contactRtId: ' + contactRtId);
        
        Schema.DescribeSObjectResult cfrSchema2 = Schema.SObjectType.Call_List__c; 
        Map<String,Schema.RecordTypeInfo> CampaignRecordTypeInfo = cfrSchema2.getRecordTypeInfosByName(); 
        Id campaignRtId = CampaignRecordTypeInfo.get('Collection AMFS').getRecordTypeId();
        system.debug('campaignRtId: ' + campaignRtId);
        
        Schema.DescribeSObjectResult cfrSchema3 = Schema.SObjectType.Call_Line__c; 
        Map<String,Schema.RecordTypeInfo> CallLineRecordTypeInfo = cfrSchema3.getRecordTypeInfosByName(); 
        Id clRtId = CallLineRecordTypeInfo.get('Collection AMFS 6').getRecordTypeId();
        system.debug('clRtId: ' + clRtId);
        
        Date dtNow = Date.today();
        Date cpgExpDate = dtNow.addDays(19);
        
        Contact c = new Contact();
        c.RecordTypeId = contactRtId;
        c.LastName = 'Wati';
        c.FirstName = 'Konto';
        c.Policy_No__c = '123-1234567';
        c.PolicyApp__c = 'RLS';
        c.Insured_Name__c = 'Konto Wati';
        c.Entity__c = 'AMFS';
        c.Email = 'kontowati@gmail.com';
        c.MobilePhone = '085156080110';
        insert c;
        
        Call_List__c cpg = new Call_List__c();
        cpg.RecordTypeId = campaignRtId;
        cpg.Entity__c = 'AMFS';
        cpg.Activity__c = 'Collection';
        cpg.Case_Type__c = 'Withdrawal';
        cpg.Campaign_Name__c = 'Collection-Withdrawal-Test#20240718';
        cpg.Expired_Date__c = cpgExpDate; 
        insert cpg;
        
        Call_line__c cl = new Call_Line__c();
        cl.RecordTypeId = clRtId;
        cl.Contact__c = c.Id;
        cl.Call_List__c = cpg.Id;
        cl.policy_no__c = '123-1234567';
        cl.Contacted_Number__c = '085156080110';
        insert cl;
        
        Test.StartTest();
        Test.setMock(HttpCalloutMock.class, new CallLineAssNoteControllerMock());
        ApexPages.StandardController stdCntrl = new ApexPages.StandardController(cl);
        CallLineAssNoteController clanc = new CallLineAssNoteController(stdCntrl); 
        
        clanc.generateInitPage();
        clanc.policyNumber = c.Policy_No__c;
        clanc.selectedReffNo = '0749944';
        clanc.generateAssNoteDetails();
        
        Test.StopTest();
    }
}