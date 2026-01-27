@isTest
public class CallLineGroupByAGI_Test {
    private static testMethod void setupTestData() {
        Test.startTest();
        
        Profile spvProfileAGI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AGI' limit 1];
        Profile agentProfileAGI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AGI' limit 1]; 
        
        User loginAGIUser = new User(Alias = 'spv1', Email='spvAGI@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='spvAGI', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = spvProfileAGI.Id, Entity__c = 'AGI', 
      			TimeZoneSidKey='Asia/Jakarta', UserName='spvAGI@axa.co.id');
        insert loginAGIUser;
        
        User subOrdinateAGIUser = new User(Alias = 'agent1', Email='agentAGI@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentAGI', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileAGI.Id, managerId = loginAGIUser.id, Entity__c = 'AGI',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentAGI@axa.co.id', isActive = true, Agent__c = true);
        insert subOrdinateAGIUser;
        
        String contactRecordTypeAGI = [select Id,Name from RecordType where sObjectType='Contact' And Name = 'Contact AGI'].Id;
        
        Contact c1 = new Contact();
        c1.LastName = 'test3';
        c1.Entity__c = 'AGI';
        c1.Policy_No__c = 'AGI001';
        c1.RecordTypeId = contactRecordTypeAGI;
        insert c1;
        
        Contact c2 = new Contact();
        c2.LastName = 'test4';
        c2.Entity__c = 'AGI';
        c2.Policy_No__c = 'AGI002';
        c2.RecordTypeId = contactRecordTypeAGI;
        insert c2;
        
        //Create Campaign
        Call_List__c campAGI = new Call_List__c();
         campAGI.Campaign_Name__c = 'test campaign AGI';
         campAGI.Entity__c = 'AGI';
         campAGI.Activity__c = 'Renewal';
         campAGI.Case_Type_Config__c = 'Renewal';
         campAGI.ownerid = loginAGIUser.id;
         campAGI.IsExpired__c = false;
         campAGI.Expired_Date__c = Datetime.now().addDays(1).date();
         campAGI.CreatedDate = system.today() - 10;
         campAGI.CreatedById = loginAGIUser.id;
        insert campAGI;
        
        //create distribution call
        Call_Line__c callAGI1 = new Call_Line__c();
         callAGI1.Call_List__c = campAGI.id;
         callAGI1.ownerid = loginAGIUser.id;
         callAGI1.Activity__c = 'Renewal';
         callAGI1.Policy_No__c = 'AGI001';
         callAGI1.Agent__c  = subOrdinateAGIUser.id;
         callAGI1.Call_Status_Config__c = 'Contacted';		//callAFI1.Activity_Result__c = 'Contacted';
         callAGI1.Reason_Status_Config__c = 'Agree'; 		//callAFI1.Verification__c = 'Agree'; 
         callAGI1.Call_Remarks__c = 'OK';
         callAGI1.Entity__c = 'AGI';
        insert callAGI1;
        
        CallLineGroupByAGI.CallLine(callAGI1.Call_List__c, callAGI1.Entity__c);
        
        Test.stopTest();
    }
}