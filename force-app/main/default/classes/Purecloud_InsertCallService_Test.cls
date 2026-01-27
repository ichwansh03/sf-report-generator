@isTest
public class Purecloud_InsertCallService_Test {
	static testMethod void myTest() {
    
        String startInterval = '2018-11-13T08:00:00.000Z';
        String endInterval = '2018-11-14T20:30:00.000Z';
        
        Purecloud_Connector__c pc = new Purecloud_Connector__c();
        pc.name = 'Purecloud Token';
        pc.Access_Token__c = '123123123123';
        insert pc;
        
        User u = new User(
             ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
             LastName = 'last',
             Email = 'puser000@amamama.com',
             Username = 'puser000@amamama.com',
             CompanyName = 'TEST',
             Title = 'title',
             Alias = 'alias',
             TimeZoneSidKey = 'America/Los_Angeles',
             EmailEncodingKey = 'UTF-8',
             LanguageLocaleKey = 'en_US',
             LocaleSidKey = 'en_US',
             isActive = True,
             Softphone_Type__c = 'Purecloud'
        );
        
        Purecloud_Connector__c presence = new Purecloud_Connector__c();
        presence.name = 'AUX';
        presence.Presence_ID__c = '6a3af858-942f-489d-9700-5f9bcdcdae9b';
        presence.AUX_Name__c = 'Available';
        insert presence;
        
        Purecloud__c agent = new Purecloud__c();
        agent.name = 'Arief_2018-11-02';
        agent.External_ID__c = 'f81eb6e2-5f0b-4d17-86f4-f572f58aaa4d_2018-11-2';
        insert agent;
        
        Purecloud_Master_Queue__c queue = new Purecloud_Master_Queue__c();
        queue.Name = 'QUEUE TEST';
        queue.Queue_ID__c = 'f7866f57-3522-487e-9a62-7889cd68f782';
        queue.Entity__c = 'AFI';
        queue.Languange__c = 'English';
        queue.Skill__c = 'Telemarketing';
        queue.Type__c = 'Inbound';
        insert queue;
        
        Purecloud_Master_Queue__c queue2 = new Purecloud_Master_Queue__c();
        queue2.Name = 'QUEUE TEST';
        queue2.Queue_ID__c = 'f7866f57-3522-487e-9a62-7889cd68f782';
        queue2.Entity__c = 'AFI';
        queue2.Languange__c = 'English';
        queue2.Skill__c = 'Telemarketing';
        queue2.Type__c = 'Callback';
        insert queue2;
        
        StaticResourceCalloutMock mock3 = new StaticResourceCalloutMock();
        mock3.setStaticResource('ResBody_ConAggregate_QueueIdPT30M');
        mock3.setStatusCode(200);
        mock3.setHeader('Content-Type', 'application/json');
        
       	Test.setMock(HttpCalloutMock.class, mock3);
       
        Test.startTest();
        Purecloud_InsertCallService.getTest(startInterval, endInterval);
        Purecloud_InsertCallService_Callback.getTest(startInterval, endInterval);
        Test.stopTest();  
        	 
    }
}