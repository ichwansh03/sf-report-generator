@isTest
Private class Sch_PurecloudSurveyResult_Test {

    static testMethod void myTest() {
        
        Purecloud_Connector__c pc = new Purecloud_Connector__c();
        pc.name = 'Purecloud Token';
        pc.Access_Token__c = '123123123123';
        insert pc;
        
        User u = new User(
             ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
             LastName = 'last',
             Email = 'puser000@amamama.com',
             Username = 'puser01230@amamama.com',
             CompanyName = 'TEST',
             Title = 'title',
             Alias = 'al2ias',
             TimeZoneSidKey = 'America/Los_Angeles',
             EmailEncodingKey = 'UTF-8',
             LanguageLocaleKey = 'en_US',
             LocaleSidKey = 'en_US',
             isActive = True,
             Softphone_Type__c = 'Purecloud',
             Entity__c = 'AFI'
        );
        insert u;
        
        Task tk = new Task();
        tk.OwnerId = u.id;
        tk.Subject = 'Call XXXXX';
        insert tk;
        
        StaticResourceCalloutMock mock1 = new StaticResourceCalloutMock();
        mock1.setStaticResource('ResBody_Task');
        mock1.setStatusCode(200);
        mock1.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock1);
        
    	Test.startTest();
        Sch_PurecloudSurveyResult sh1 = new Sch_PurecloudSurveyResult();
		String sch = '0 0 23 * * ?';
        system.schedule('Sch_PurecloudSurveyResult', sch, sh1); 
        
        Test.stopTest(); 
    }
}