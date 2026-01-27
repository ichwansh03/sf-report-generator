@isTest
public class Agent_Callback_Controller_Test {

     public static testMethod void callbackControllerTest(){
         Test.startTest(); 
         
         Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AFI' limit 1]; 
         Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AMFS' limit 1]; 
         Profile agentProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%MAGI' limit 1]; 

         Profile spvProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AFI' limit 1]; 
         Profile spvProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AMFS' limit 1]; 
         Profile spvProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%MAGI' limit 1]; 
		
		 List<User> spvList = new List<User>();
         User loginAFIUser = new User(Alias = 'spv1', Email='spvAfi@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='spvAfi', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = spvProfileAFI.Id, Entity__c = 'AFI', 
      			TimeZoneSidKey='Asia/Jakarta', UserName='spvAfi@axa.co.id');
		 spvList.add(loginAFIUser);

         User loginAMFSUser = new User(Alias = 'spv2', Email='spvAmfs@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='spvAmfs', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = spvProfileAMFS.Id, Entity__c = 'AMFS', 
      			TimeZoneSidKey='Asia/Jakarta', UserName='spvAmfs@axa.co.id');
		 spvList.add(loginAMFSUser);

         User loginMAGIUser = new User(Alias = 'spv3', Email='spvMagi@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='spvMagi', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = spvProfileMAGI.Id, Entity__c = 'MAGI',
      			TimeZoneSidKey='Asia/Jakarta', UserName='spvMagi@axa.co.id');
		 spvList.add(loginMAGIUser);
		 insert spvList;
		 
		 List<User> agentList = new List<User>();
         User userAFI = new User(Alias = 'agent1', Email='agentAfi@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentAfi', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, managerId = loginAFIUser.id, Entity__c = 'AFI',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentAfi@axa.co.id');
		 agentList.add(userAFI);

         User userAMFS = new User(Alias = 'agent2', Email='agentAmfs@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentAmfs', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = loginAMFSUser.id, Entity__c = 'AMFS',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentAmfs@axa.co.id');
		 agentList.add(userAMFS);

         User userMAGI = new User(Alias = 'agent3', Email='agentMagi@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentMagi', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileMAGI.Id, managerId = loginMAGIUser.id, Entity__c = 'MAGI',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentMagi@axa.co.id');
		 agentList.add(userMAGI);
		 insert agentList;
                 
		 /*
         User userAFI = [select id, managerId, Entity__c from user where isActive = true and managerId!=null and Manager.isActive = true and entitY__c = 'AFI' and Agent__c = true limit 1];
         User loginAFIUser = [select id, Entity__c from user where isActive = true and id = :userAFI.managerId and entitY__c = 'AFI' limit 1];
         
         User userAMFS = [select id, managerId, Entity__c from user where isActive = true and managerId!=null and Manager.isActive = true and entitY__c = 'AMFS' and Agent__c = true limit 1];
         User loginAMFSUser = [select id, Entity__c from user where isActive = true and id = :userAMFS.managerId and entitY__c = 'AMFS' limit 1];
         
         User userMAGI = [select id, managerId, Entity__c from user where isActive = true and managerId!=null and Manager.isActive = true and entitY__c = 'MAGI' and Agent__c = true limit 1];
         User loginMAGIUser = [select id, Entity__c from user where isActive = true and id = :userMAGI.managerId and entitY__c = 'MAGI' limit 1];
         */
         
         //Create Campaign
         List<Call_List__c> callList = new List<Call_List__c>();
         Call_List__c campAFI = new Call_List__c();
         campAFI.Campaign_Name__c = 'Campaign AFI';
         campAFI.Entity__c = 'AFI';
         campAFI.Activity__c = 'Callback';
         campAFI.ownerid = loginAFIUser.id;
         campAFI.IsExpired__c = false;
         campAFI.Expired_Date__c = Datetime.now().addDays(5).date();
         callList.add(campAFI);
        
         Call_List__c campAMFS = new Call_List__c();
         campAMFS.Campaign_Name__c = 'Campaign AMFS';
         campAMFS.Entity__c = 'AMFS';
         campAMFS.Activity__c = 'Callback';
         campAMFS.ownerid = loginAMFSUser.id;
         campAMFS.IsExpired__c = false;
         campAMFS.Expired_Date__c = Datetime.now().addDays(5).date();
         callList.add(campAMFS);
         
         Call_List__c campMAGI = new Call_List__c();
         campMAGI.Campaign_Name__c = 'Campaign MAGI';
         campMAGI.Entity__c = 'MAGI';
         campMAGI.Activity__c = 'Callback';
         campMAGI.ownerid = loginMAGIUser.id;
         campMAGI.IsExpired__c = false;
         campMAGI.Expired_Date__c = Datetime.now().addDays(5).date();
         callList.add(campMAGI);
         
         insert callList;
         
         //create distribution call
         List<Call_Line__c> disList = new List<Call_Line__c>();
         Call_Line__c callAFI1 = new Call_Line__c();
         callAFI1.Call_List__c = campAFI.id;
         callAFI1.ownerid = userAFI.id;
         callAFI1.Activity__c = 'Callback';
         callAFI1.Policy_No__c = 'afi666';
         callAFI1.Agent__c  = userAFI.id;
         callAFI1.Is_Calledback_Already__c = false;
         callAFI1.Call_Remarks__c = 'OK';
         callAFI1.Entity__c = 'AFI';
         disList.add(callAFI1);

         Call_Line__c callAFI2 = new Call_Line__c();
         callAFI2.Call_List__c = campAFI.id;
         callAFI2.ownerid = userAFI.id;
         callAFI2.Activity__c = 'Callback';
         callAFI2.Policy_No__c = 'afi555';
         callAFI2.Agent__c  = userAFI.id; 
         callAFI2.Is_Calledback_Already__c = false;
         callAFI2.Call_Remarks__c = 'OK';
         callAFI2.Entity__c = 'AFI';
         disList.add(callAFI2);

         Call_Line__c callAMFS1 = new Call_Line__c();
         callAMFS1.Call_List__c = campAMFS.id;
         callAMFS1.ownerid = loginAMFSUser.id;
         callAMFS1.Activity__c = 'Callback';
         callAMFS1.Policy_No__c = 'amfs666';
         callAMFS1.Agent__c  = userAMFS.id; 
         callAMFS1.Is_Calledback_Already__c = false; 
         callAMFS1.Call_Remarks__c = 'OK';
         callAMFS1.Entity__c = 'AMFS';
         disList.add(callAMFS1);

         Call_Line__c callAMFS2 = new Call_Line__c();
         callAMFS2.Call_List__c = campAMFS.id;
         callAMFS2.ownerid = loginAMFSUser.id;
         callAMFS2.Activity__c = 'Callback';
         callAMFS2.Policy_No__c = 'amfs555';
         callAMFS2.Agent__c  = userAMFS.id; 
         callAMFS2.Is_Calledback_Already__c = false; 
         callAMFS2.Call_Remarks__c = 'OK';
         callAMFS2.Entity__c = 'AMFS';
         disList.add(callAMFS2);
         
         Call_Line__c callMAGI1 = new Call_Line__c();
         callMAGI1.Call_List__c = campMAGI.id;
         callMAGI1.ownerid = userMAGI.id;
         callMAGI1.Activity__c = 'Callback';
         callMAGI1.Policy_No__c = 'magi666';
         callMAGI1.Agent__c  = userMAGI.id;
         callMAGI1.Is_Calledback_Already__c = false; 
         callMAGI1.Call_Remarks__c = 'OK';
         callMAGI1.Entity__c = 'MAGI';
         disList.add(callMAGI1);
         insert disList;

         system.runAs(loginAMFSUser){
              Agent_Callback_Controller controlAMFS = new Agent_Callback_Controller(); 
              
              controlAMFS.choosen_campaign = campAMFS.id;
              controlAMFS.populateAssignment();
              List<Agent_Callback_Controller.AgentBucket> bucket = controlAMFS.callbackList;
              
              controlAMFS.show();
              integer reminderSize = controlAMFS.showList.size(); 
              
              controlAMFS.close();
         }
         Test.stopTest();         
     }
}