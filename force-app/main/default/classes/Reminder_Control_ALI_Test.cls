@isTest
public class Reminder_Control_ALI_Test {

     public static testMethod void testReminder_Control_ALI(){
         Test.startTest();

         Profile agentProfileALI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%ALI' limit 1]; 
         Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AMFS' limit 1]; 
         Profile agentProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%MAGI' limit 1]; 

         Profile spvProfileALI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%ALI' limit 1]; 
         Profile spvProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AMFS' limit 1]; 
         Profile spvProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%MAGI' limit 1]; 
    
     List<User> spvList = new List<User>();
         User loginALIUser = new User(Alias = 'spv1', Email='spvALI@axa.co.id', 
            EmailEncodingKey='UTF-8', LastName='spvALI', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = spvProfileALI.Id, Entity__c = 'ALI', 
            TimeZoneSidKey='Asia/Jakarta', UserName='spvALI@axa.co.id');
     spvList.add(loginALIUser);

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
         User subOrdinateALIUser = new User(Alias = 'agent1', Email='agentALI@axa.co.id', 
            EmailEncodingKey='UTF-8', LastName='agentALI', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = agentProfileALI.Id, managerId = loginALIUser.id, Entity__c = 'ALI',
            TimeZoneSidKey='Asia/Jakarta', UserName='agentALI@axa.co.id');
     agentList.add(subOrdinateALIUser);

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
         User subOrdinateALIUser = [select id, managerId, Entity__c from user where isActive = true and managerId!=null and Manager.isActive = true and entitY__c = 'ALI' and Agent__c = true limit 1];
         system.debug('>>> subOrdinateALIUser id : '+subOrdinateALIUser.id); 
         User loginALIUser = [select id, Entity__c from user where isActive = true and id = :subOrdinateALIUser.managerId and entitY__c = 'ALI' limit 1];
         system.debug('>>> loginALIUser id : '+loginALIUser.id); 
    
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
         Call_List__c campALI = new Call_List__c();
         campALI.Campaign_Name__c = 'test campaign ALI';
         campALI.Entity__c = 'ALI';
         campALI.Activity__c = 'Renewal';
         campALI.Case_Type__c = 'Renewal';
         campALI.ownerid = loginALIUser.id;
         campALI.IsExpired__c = false;
         campALI.Expired_Date__c = Datetime.now().addDays(1).date();
         callList.add(campALI);
        
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
         Call_Line__c callALI1 = new Call_Line__c();
         callALI1.Call_List__c = campALI.id;
         callALI1.ownerid = subOrdinateALIUser.id;
         callALI1.Activity__c = 'Renewal';
         callALI1.Policy_No__c = 'ALI001';
         callALI1.Agent__c  = subOrdinateALIUser.id;
         callALI1.Activity_Result__c = 'Rescheduled'; 
         callALI1.Call_Remarks__c = 'OK';
         callALI1.Entity__c = 'ALI';
         disList.add(callALI1);

         Call_Line__c callALI2 = new Call_Line__c();
         callALI2.Call_List__c = campALI.id;
         callALI2.ownerid = subOrdinateALIUser.id;
         callALI2.Activity__c = 'Renewal';
         callALI2.Policy_No__c = 'ALI002';
         callALI2.Agent__c  = subOrdinateALIUser.id; 
         callALI2.Activity_Result__c = 'Rescheduled'; 
         callALI2.Call_Remarks__c = 'OK';
         callALI2.Entity__c = 'ALI';
         disList.add(callALI2);

         Call_Line__c callALI3 = new Call_Line__c();
         callALI3.Call_List__c = campALI.id;
         callALI3.ownerid = subOrdinateALIUser.id;
         callALI3.Activity__c = 'Renewal';
         callALI3.Policy_No__c = 'ALI003';
         callALI3.Agent__c  = subOrdinateALIUser.id; 
         callALI3.Activity_Result__c = 'Rescheduled'; 
         callALI3.Call_Remarks__c = 'OK';
         callALI3.Entity__c = 'ALI';
         disList.add(callALI3);
         
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
                        
         //system.runAs(loginALIUser){
         system.runAs(subOrdinateALIUser){  //added by Hamfry
             Reminder_Control_ALI controlALI = new Reminder_Control_ALI (); 
              system.debug('>>>> loggedInUser id : '+controlALI.loggedInUser);   
              system.debug('>>>> loginALIUser id : '+loginALIUser.id);   
              system.debug('>>> displayPopup : '+controlALI.displayPopup); 
              system.debug('>>> entity : '+controlALI.entity); 
              system.debug('>>> callList size : '+controlALI.callList.size()); 
              system.assertEquals(false, controlALI.displayPopup);
              system.assertEquals('ALI', controlALI.entity);
              //system.assertEquals(3, controlALI.callList.size());
              
              controlALI.choosen_campaign = campALI.id;
              controlALI.populateAssignment();
              List<Reminder_Control_ALI.AgentBucket> bucket = controlALI.distList;
              //system.assertEquals(3, assignsize);
              
              controlALI.show();
              system.debug('>>> displayPopup:show() : '+controlALI.displayPopup); 
              system.assertEquals(true, controlALI.displayPopup);
              integer reminderSize = controlALI.showList.size(); 
              //system.assertEquals(3, reminderSize);

              controlALI.close();
              system.debug('>>> displayPopup:close() : '+controlALI.displayPopup); 
              system.assertEquals(false, controlALI.displayPopup);
         }
         Test.stopTest();         
     }
}