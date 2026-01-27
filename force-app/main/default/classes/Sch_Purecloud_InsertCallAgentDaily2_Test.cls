@isTest
public class Sch_Purecloud_InsertCallAgentDaily2_Test {
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
             Username = 'puser120@amamama.com',
             CompanyName = 'TEST',
             Title = 'title',
             Alias = 'aliass',
             TimeZoneSidKey = 'America/Los_Angeles',
             EmailEncodingKey = 'UTF-8',
             LanguageLocaleKey = 'en_US',
             LocaleSidKey = 'en_US',
             isActive = True,
             Softphone_Type__c = 'Purecloud',
            entity__c = 'AFI'
        );
        insert u;
        
        Purecloud_Connector__c presence = new Purecloud_Connector__c();
        presence.name = 'AUX';
        presence.Presence_ID__c = '6a3af858-942f-489d-9700-5f9bcdcdae9b';
        presence.AUX_Name__c = 'Available';
        insert presence;
        
        Purecloud__c agent = new Purecloud__c();
        agent.name = 'Arief_2018-11-02';
        agent.External_ID__c = 'f81eb6e2-5f0b-4d17-86f4-f572f58aaa4d_2018-11-2';
        insert agent;

        StaticResourceCalloutMock mock1 = new StaticResourceCalloutMock();
        mock1.setStaticResource('ResBody_UserAggregate');
        mock1.setStatusCode(200);
        mock1.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock1);
        
        StaticResourceCalloutMock mock2 = new StaticResourceCalloutMock();
        mock2.setStaticResource('ResBody_UserDetail');
        mock2.setStatusCode(200);
        mock2.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock2);
        
        StaticResourceCalloutMock mock3 = new StaticResourceCalloutMock();
        mock3.setStaticResource('ResBody_ConAggregate_Agent');
        mock3.setStatusCode(200);
        mock3.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock3);
        
        Test.startTest();
        Sch_Purecloud_InsertCallAgentDailyResync sh1 = new Sch_Purecloud_InsertCallAgentDailyResync();
    String sch = '0 0 20 * * ?';
        system.schedule('Sch_Purecloud_InsertCallAgentDaily_Test', sch, sh1); 
        
        Test.stopTest();
        
    }
}