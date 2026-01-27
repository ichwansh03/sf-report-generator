@isTest
public class EmailAssignmentAutoNumber_Test {

     public static testMethod void muTest(){
     	List<Email_Config__c> ecList = new List<Email_Config__c>();
     	Email_Config__c ec = new Email_Config__c();
     	ec.Name = 'Testing';
     	ec.Email_Address__c = 'testing123@nyahoo.com';
     	ec.Entity__c = 'AMFS';
     	ec.SLA__c = '1';
     	ec.Unit__c = 'Day';
     	ec.Distribution_Type__c = 'Automatic';
     	ecList.add(ec);
     	
     	insert ecList;
     	
     	Profile agentProfile = [SELECT Id FROM Profile WHERE Name like '%Agent%AMFS' limit 1]; 
     	
     	List<User> usrList = new List<User>();
        User usr1 = new User(Alias = 'agent1', Email='agent01@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agent01', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfile.Id, Entity__c = 'AMFS', 
      			TimeZoneSidKey='Asia/Jakarta', UserName='agent01@axa.co.id', isActive = true);
		usrList.add(usr1);
		User usr2 = new User(Alias = 'agent2', Email='agent02@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agent02', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfile.Id, Entity__c = 'AMFS', 
      			TimeZoneSidKey='Asia/Jakarta', UserName='agent02@axa.co.id', isActive = true);
		usrList.add(usr2);
		
		insert usrList;
		
     	List<Email_Assignment__c> eaList1 = new List<Email_Assignment__c>();
     	Email_Assignment__c ea1 = new Email_Assignment__c();
     	ea1.Inbox__c = ec.Id;
     	ea1.User__c = usr1.Id;
     	eaList1.add(ea1);
     	
     	insert eaList1;
     	
     	List<Email_Assignment__c> eaList2 = new List<Email_Assignment__c>();
     	Email_Assignment__c ea2 = new Email_Assignment__c();
     	ea2.Inbox__c = ec.Id;
     	ea2.User__c = usr2.Id;
     	eaList2.add(ea2);
     	
     	insert eaList2;
     }
}