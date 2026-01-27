@isTest
public class ScheduleSentNotifyCallLinesTest {
	   @testSetup static void setTestData() {
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%AMFS%' LIMIT 1].Id,
            LastName = 'LastName',
            Email = 'tester@email.com',
            Username = 'tester@email.com' + System.currentTimeMillis(),
            CompanyName = 'The Company',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            Entity__c = 'AMFS'
        );
        insert u; 
           
		Account a = new Account();
        a.Name = 'Account AMFS';
        a.Entity__c = 'AMFS';
        insert a;
        
        Contact c = new Contact();
        c.AccountId = a.Id;
        c.LastName = 'LastName';
        c.FirstName = 'FirstName';
        c.Entity__c = 'AMFS';
        c.WelcomeCall_Product_Code_Plan__c  = 'MJK';
        insert c;  
           
           
        Contact cont = new Contact();
        cont.Policy_No__c = '100-000-1110001';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP DMTM';
        cont.WelcomeCall_Product_Code_Plan__c  = 'HONMEPS';
        insert cont;  
           
        Id rtype = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
        Id usdRtype = Schema.SObjectType.User_Detail__c.getRecordTypeInfosByName().get('User Detail Collection AMFS').getRecordTypeId();
        
        Call_List__c cl = new Call_List__c();
        cl.RecordTypeId = rtype;
        cl.Activity__c = 'Collection';
        cl.OwnerId = u.id;
        //cl.Case_Type__c = 'Lapse Konven';			//update 11/09/2020 - ganti jadi "Redemption Konven"
        cl.Case_Type__c = 'Redemption Konven';
        cl.Expired_Date__c = system.today() + 30;
        cl.Entity__c = 'AMFS';
        //cl.Campaign_Name__c = 'Lapse Konven';
        //cl.Campaign_Name__c = 'Lapse Konven';
        cl.Campaign_Name__c = 'Redemption Konven';
        cl.Activity__c = 'Collection';
        insert cl;
            
        Call_Line__c cLine = new Call_Line__c();
        cLine.Call_List__c = cl.id; 
        cLine.Contact__c = cont.id;
        cLine.Activity__c = 'Collection';
        cLine.Policy_No__c = '100-000-1110001'; 
        cLine.Call_Remarks__c = 'OK';
        cLine.Entity__c = 'AMFS';
        cLine.APE__c = 1000;
        cLine.Currency__c = 'IDR';
           cLine.WelcomeCall_Schedule_Date__c = system.now();
        insert cLine; 
            
    }

    public static testmethod void testNotifyCallLine(){
        Test.startTest(); 
            ScheduleSentNotifyCallLines lrs = new ScheduleSentNotifyCallLines(); 
            system.schedule('Test notifyEmail', '0 0 * * * ?', lrs);
        Test.stopTest();
    }  
     
}