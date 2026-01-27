@isTest
Private class Purecloud_InsertCallAgent_Test {
    static testMethod void myTest() {
        
        String s = '2018-11-13T08:00:00.000Z';
        String e = '2018-11-14T20:30:00.000Z';
        String s2 = '2018-11-15T08:00:00.000Z';
        String e2 = '2018-11-16T20:30:00.000Z';
        String q = 'SELECT Id,SIP__c,Entity__c, Name FROM User WHERE SIP__c != NULL and Softphone_Type__c = '+'\''+'Purecloud'+'\''+' and isActive = TRUE  LIMIT 1';
        
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
        //insert u;
        
        Purecloud_Connector__c presence = new Purecloud_Connector__c();
        presence.name = 'AUX';
        presence.Presence_ID__c = '6a3af858-942f-489d-9700-5f9bcdcdae9b';
        presence.AUX_Name__c = 'Available';
        insert presence;
        
        Purecloud_Connector__c presence_break = new Purecloud_Connector__c();
        presence_break.name = 'AUX';
        presence_break.Presence_ID__c = '227b37e2-f1d0-4dd0-8f50-badd7cf6d158';
        presence_break.AUX_Name__c = 'Break';
        insert presence_break;
        
        Purecloud_Connector__c presence_break_pray = new Purecloud_Connector__c();
        presence_break_pray.name = 'AUX';
        presence_break_pray.Presence_ID__c = '35ed6bfc-e17c-4fe8-aaf0-092b64321c61';
        presence_break_pray.AUX_Name__c = 'Break_Pray';
        insert presence_break_pray;
        
        Purecloud_Connector__c presence_break_rest = new Purecloud_Connector__c();
        presence_break_rest.name = 'AUX';
        presence_break_rest.Presence_ID__c = '824fed12-0068-48fe-8f34-204980ee763b';
        presence_break_rest.AUX_Name__c = 'Break_Rest';
        insert presence_break_rest;
        
        Purecloud__c agent = new Purecloud__c();
        agent.name = 'Arief_2018-11-02';
        agent.External_ID__c = 'f81eb6e2-5f0b-4d17-86f4-f572f58aaa4d_2018-11-2';
        insert agent;

        StaticResourceCalloutMock mock1 = new StaticResourceCalloutMock();
        mock1.setStaticResource('ResBody_UserAggregate2');
        mock1.setStatusCode(200);
        mock1.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock1);
        
        StaticResourceCalloutMock mock2 = new StaticResourceCalloutMock();
        mock2.setStaticResource('ResBody_UserDetail2');
        mock2.setStatusCode(200);
        mock2.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock2);
        
        StaticResourceCalloutMock mock3 = new StaticResourceCalloutMock();
        mock3.setStaticResource('ResBody_ConAggregate_Agent');
        mock3.setStatusCode(200);
        mock3.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock3);
        
        /*StaticResourceCalloutMock mock4 = new StaticResourceCalloutMock();
        mock4.setStaticResource('ResBody_UserAggregate2');
        mock4.setStatusCode(200);
        mock4.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock4);
        
        StaticResourceCalloutMock mock5 = new StaticResourceCalloutMock();
        mock5.setStaticResource('ResBody_UserDetail2');
        mock5.setStatusCode(200);
        mock5.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock5);*/
        
        Test.startTest();
        Purecloud_InsertCallAgent bb = new Purecloud_InsertCallAgent(q,s,e);
		Database.executeBatch(bb,1);
        Purecloud_InsertCallAgent bb2 = new Purecloud_InsertCallAgent(q,s2,e2);
		Database.executeBatch(bb2,1);
        Test.stopTest();         
    }
}