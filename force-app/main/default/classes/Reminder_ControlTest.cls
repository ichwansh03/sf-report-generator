@isTest
public class Reminder_ControlTest {

     public static testMethod void testReminder_Control(){
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
         User subOrdinateAFIUser = new User(Alias = 'agent1', Email='agentAfi@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentAfi', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, managerId = loginAFIUser.id, Entity__c = 'AFI',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentAfi@axa.co.id');
		 agentList.add(subOrdinateAFIUser);

         User subOrdinateAMFSUser = new User(Alias = 'agent2', Email='agentAmfs@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentAmfs', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = loginAMFSUser.id, Entity__c = 'AMFS',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentAmfs@axa.co.id');
		 agentList.add(subOrdinateAMFSUser);

         User subOrdinateMAGIUser = new User(Alias = 'agent3', Email='agentMagi@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentMagi', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileMAGI.Id, managerId = loginMAGIUser.id, Entity__c = 'MAGI',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentMagi@axa.co.id');
		 agentList.add(subOrdinateMAGIUser);
		 insert agentList;
         
         /*         
         User subOrdinateAFIUser = [select id, managerId, Entity__c from user where isActive = true and managerId!=null and Manager.isActive = true and entitY__c = 'AFI' and Agent__c = true limit 1];
         system.debug('>>> subOrdinateAFIUser id : '+subOrdinateAFIUser.id); 
         User loginAFIUser = [select id, Entity__c from user where isActive = true and id = :subOrdinateAFIUser.managerId and entitY__c = 'AFI' limit 1];
         system.debug('>>> loginAFIUser id : '+loginAFIUser.id); 
    
         User subOrdinateAMFSUser = [select id, managerId, Entity__c from user where isActive = true and managerId!=null and Manager.isActive = true and entitY__c = 'AMFS' and Agent__c = true limit 1];
         system.debug('>>> subOrdinateAMFSUser id : '+subOrdinateAMFSUser.id); 
         User loginAMFSUser = [select id, Entity__c from user where isActive = true and id = :subOrdinateAMFSUser.managerId and entitY__c = 'AMFS' limit 1];
         system.debug('>>> loginAMFSUser id : '+loginAMFSUser.id); 
         
         User subOrdinateMAGIUser = [select id, managerId, Entity__c from user where isActive = true and managerId!=null and Manager.isActive = true and entitY__c = 'MAGI' and Agent__c = true limit 1];
         system.debug('>>> subOrdinateMAGIUser id : '+subOrdinateMAGIUser.id); 
         User loginMAGIUser = [select id, Entity__c from user where isActive = true and id = :subOrdinateMAGIUser.managerId and entitY__c = 'MAGI' limit 1];
         system.debug('>>> loginMAGIUser id : '+loginMAGIUser.id); 
		 */
		 	
         //Create Campaign
         List<Call_List__c> callList = new List<Call_List__c>();
         Call_List__c campAFI = new Call_List__c();
         campAFI.Campaign_Name__c = 'test campaign afi';
         campAFI.Entity__c = 'AFI';
         campAFI.Activity__c = 'Renewal';
         campAFI.Case_Type__c = 'Renewal';
         campAFI.ownerid = loginAFIUser.id;
         campAFI.IsExpired__c = false;
         campAFI.Expired_Date__c = Datetime.now().addDays(1).date();
         callList.add(campAFI);
        
         Call_List__c campAMFS = new Call_List__c();
         campAMFS.Campaign_Name__c = 'test campaign amfs';
         campAMFS.Entity__c = 'AMFS';
         campAMFS.Activity__c = 'Renewal';
         campAMFS.Case_Type__c = 'Renewal';
         campAMFS.ownerid = loginAMFSUser.id;
         campAMFS.IsExpired__c = false;
         campAMFS.Expired_Date__c = Datetime.now().addDays(1).date();
         callList.add(campAMFS);
         
         Call_List__c campMAGI = new Call_List__c();
         campMAGI.Campaign_Name__c = 'test campaign magi';
         campMAGI.Entity__c = 'MAGI';
         campMAGI.Activity__c = 'Renewal';
         campMAGI.Case_Type__c = 'Renewal';
         campMAGI.ownerid = loginMAGIUser.id;
         campMAGI.IsExpired__c = false;
         campMAGI.Expired_Date__c = Datetime.now().addDays(1).date();
         callList.add(campMAGI);
         
         insert callList;
         
         //create distribution call
         List<Call_Line__c> disList = new List<Call_Line__c>();
         Call_Line__c callAFI1 = new Call_Line__c();
         callAFI1.Call_List__c = campAFI.id;
         callAFI1.ownerid = subOrdinateAFIUser.id;
         callAFI1.Activity__c = 'Renewal';
         callAFI1.Policy_No__c = 'afi001';
         callAFI1.Agent__c  = subOrdinateAFIUser.id;
         callAFI1.Activity_Result__c = 'Rescheduled'; 
         callAFI1.Call_Remarks__c = 'OK';
         callAFI1.Entity__c = 'AFI';
         disList.add(callAFI1);

         Call_Line__c callAFI2 = new Call_Line__c();
         callAFI2.Call_List__c = campAFI.id;
         callAFI2.ownerid = subOrdinateAFIUser.id;
         callAFI2.Activity__c = 'Renewal';
         callAFI2.Policy_No__c = 'afi002';
         callAFI2.Agent__c  = subOrdinateAFIUser.id; 
         callAFI2.Activity_Result__c = 'Rescheduled'; 
         callAFI2.Call_Remarks__c = 'OK';
         callAFI2.Entity__c = 'AFI';
         disList.add(callAFI2);

         Call_Line__c callAFI3 = new Call_Line__c();
         callAFI3.Call_List__c = campAFI.id;
         callAFI3.ownerid = subOrdinateAFIUser.id;
         callAFI3.Activity__c = 'Renewal';
         callAFI3.Policy_No__c = 'afi003';
         callAFI3.Agent__c  = subOrdinateAFIUser.id; 
         callAFI3.Activity_Result__c = 'Rescheduled'; 
         callAFI3.Call_Remarks__c = 'OK';
         callAFI3.Entity__c = 'AFI';
         disList.add(callAFI3);
         
         Call_Line__c callAMFS1 = new Call_Line__c();
         callAMFS1.Call_List__c = campAMFS.id;
         callAMFS1.ownerid = subOrdinateAMFSUser.id;
         callAMFS1.Activity__c = 'Renewal';
         callAMFS1.Policy_No__c = 'amfs001';
         callAMFS1.Agent__c  = subOrdinateAMFSUser.id; 
         callAMFS1.Activity_Result__c = 'Rescheduled'; 
         callAMFS1.Call_Remarks__c = 'OK';
         callAMFS1.Entity__c = 'AMFS';
         disList.add(callAMFS1);

         Call_Line__c callAMFS2 = new Call_Line__c();
         callAMFS2.Call_List__c = campAMFS.id;
         callAMFS2.ownerid = subOrdinateAMFSUser.id;
         callAMFS2.Activity__c = 'Renewal';
         callAMFS2.Policy_No__c = 'amfs002';
         callAMFS2.Agent__c  = subOrdinateAMFSUser.id; 
         callAMFS2.Activity_Result__c = 'Rescheduled'; 
         callAMFS2.Call_Remarks__c = 'OK';
         callAMFS2.Entity__c = 'AMFS';
         disList.add(callAMFS2);
         
         Call_Line__c callMAGI1 = new Call_Line__c();
         callMAGI1.Call_List__c = campMAGI.id;
         callMAGI1.ownerid = subOrdinateMAGIUser.id;
         callMAGI1.Activity__c = 'Renewal';
         callMAGI1.Policy_No__c = 'magi001';
         callMAGI1.Agent__c  = subOrdinateMAGIUser.id; 
         callMAGI1.Activity_Result__c = 'Rescheduled'; 
         callMAGI1.Call_Remarks__c = 'OK';
         callMAGI1.Entity__c = 'MAGI';
         disList.add(callMAGI1);
         
         insert disList;
                        
         //system.runAs(loginAFIUser){
         system.runAs(subOrdinateAFIUser){	//added by Hamfry
         	  Reminder_Control controlAFI = new Reminder_Control (); 
              system.debug('>>>> loggedInUser id : '+controlAFI.loggedInUser);   
              system.debug('>>>> loginAFIUser id : '+loginAFIUser.id);   
              system.debug('>>> displayPopup : '+controlAFI.displayPopup); 
              system.debug('>>> entity : '+controlAFI.entity); 
              system.debug('>>> callList size : '+controlAFI.callList.size()); 
              system.assertEquals(false, controlAFI.displayPopup);
              system.assertEquals('AFI', controlAFI.entity);
              //system.assertEquals(3, controlAFI.callList.size());
              
              controlAFI.choosen_campaign = campAFI.id;
              controlAFI.populateAssignment();
              List<Reminder_Control.AgentBucket> bucket = controlAFI.distList;
              //system.assertEquals(3, assignsize);
              
              controlAFI.show();
              system.debug('>>> displayPopup:show() : '+controlAFI.displayPopup); 
              system.assertEquals(true, controlAFI.displayPopup);
              integer reminderSize = controlAFI.showList.size(); 
              //system.assertEquals(3, reminderSize);

              controlAFI.close();
              system.debug('>>> displayPopup:close() : '+controlAFI.displayPopup); 
              system.assertEquals(false, controlAFI.displayPopup);
         }
         Test.stopTest();         
     }
}