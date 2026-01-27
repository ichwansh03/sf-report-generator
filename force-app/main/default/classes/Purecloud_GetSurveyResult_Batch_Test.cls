@isTest
public class Purecloud_GetSurveyResult_Batch_Test {
	static testMethod void myTest() {
     
        Purecloud_Connector__c pc = new Purecloud_Connector__c();
        pc.name = 'Purecloud Token';
        pc.Access_Token__c = '123123123123';
        insert pc;
        
        
        
        User u = new User();
             u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id;
             u.LastName = 'last';
             u.Email = 'puser023@amamama.com';
             u.Username = 'puser023@amamama.com';
             u.CompanyName = 'TEST';
             u.Title = 'title';
             u.Alias = 'alias';
             u.TimeZoneSidKey = 'America/Los_Angeles';
             u.EmailEncodingKey = 'UTF-8';
             u.LanguageLocaleKey = 'en_US';
             u.LocaleSidKey = 'en_US';
             u.isActive = True;
             u.Softphone_Type__c = 'Purecloud';
        	 u.Entity__c = 'AGI';
             insert u;
        
        
        Task tk = new Task();
        tk.OwnerId = u.id;
        tk.Subject = 'TEST';
        tk.callObject = '01f38141-d85b-4e43-a04a-8f87a4712011';
        tk.Purecloud_Participant_ID__c = '7c029ac9-72e3-4a40-9405-82fcaf7c4740';
        //tk.Start_Calling__c = system.today();
        //tk.Start_Dialing__c = system.today();
        insert tk;
        
        String q = 'SELECT Id,CallObject, Purecloud_Participant_Id__c FROM Task WHERE Id = '+'\''+tk.id+'\'';
        system.debug('Q ==>'+q);
        system.debug('Owner ID ==>'+tk.OwnerId);
        
        StaticResourceCalloutMock mock1 = new StaticResourceCalloutMock();
        mock1.setStaticResource('ResBody_Task');
        mock1.setStatusCode(200);
        mock1.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock1);
        
        Test.startTest();
        Purecloud_GetSurveyResult_Batch bb = new Purecloud_GetSurveyResult_Batch(q);
		Database.executeBatch(bb,1);
        Test.stopTest();     
        
    }
}