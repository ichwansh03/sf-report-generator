@isTest(seeAllData=true)
public class CallLineGroupByALI_Test {
    private static testMethod void setupTestData() {
        Test.startTest();
        
        Profile spvProfileALI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%ALI' limit 1];
        Profile agentProfileALI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%ALI' limit 1]; 
        
        User loginALIUser = new User(Alias = 'spv1', Email='spvAli@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='spvAli', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = spvProfileALI.Id, Entity__c = 'ALI', 
      			TimeZoneSidKey='Asia/Jakarta', UserName='spvAli@axa.co.id');
        insert loginALIUser;
        
        User subOrdinateALIUser = new User(Alias = 'agent1', Email='agentAli@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentAli', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileALI.Id, managerId = loginALIUser.id, Entity__c = 'ALI',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentAli@axa.co.id', isActive = true, Agent__c = true);
        insert subOrdinateALIUser;
        
        //Create Campaign
        Call_List__c campALI = new Call_List__c();
         campALI.Campaign_Name__c = 'test campaign ali';
         campALI.Entity__c = 'ALI';
         campALI.Activity__c = 'Renewal';
         campALI.Case_Type_Config__c = 'Renewal';
         campALI.ownerid = loginALIUser.id;
         campALI.IsExpired__c = false;
         campALI.Expired_Date__c = Datetime.now().addDays(1).date();
         campALI.CreatedDate = system.today() - 10;
         campALI.CreatedById = loginALIUser.id;
        insert campALI;
        
        //create distribution call
        Call_Line__c callALI1 = new Call_Line__c();
         callALI1.Call_List__c = campALI.id;
         callALI1.ownerid = loginALIUser.id;
         callALI1.Activity__c = 'Renewal';
         callALI1.Policy_No__c = 'ali001';
         callALI1.Agent__c  = subOrdinateALIUser.id;
         callALI1.Call_Status_Config__c = 'Contacted';		//callAFI1.Activity_Result__c = 'Contacted';
         callALI1.Reason_Status_Config__c = 'Agree'; 		//callAFI1.Verification__c = 'Agree'; 
         callALI1.Call_Remarks__c = 'OK';
         callALI1.Entity__c = 'ALI';
        insert callALI1;
        
        CallLineGroupByALI.CallLine(callALI1.Call_List__c, callALI1.Entity__c);
        
        Test.stopTest();
    }
}