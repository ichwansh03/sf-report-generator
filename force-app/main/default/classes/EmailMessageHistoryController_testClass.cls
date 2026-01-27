@isTest
public class EmailMessageHistoryController_testClass {
    @isTest static void test() {
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like '%Agent%AFI' limit 1];
        User usr = new User();
        usr.Alias = 'agentAFI';
        usr.LastName = 'User Agent AFI';
        usr.Email = 'agent01@axa.co.id';
        usr.EmailEncodingKey = 'UTF-8';
        usr.LanguageLocaleKey = 'en_US'; 
        usr.LocaleSidKey = 'en_US';
        usr.IsActive = TRUE;
        usr.Entity__c = 'AFI';
        usr.ProfileId = agentProfileAFI.Id;
        usr.TimeZoneSidKey = 'Asia/Jakarta';
        usr.UserName = 'agent01@axa.co.id';
        usr.Agent_Queue_ID_Email_Reply_Customer__c = '00G0k000009awyn';
        insert usr;
        
        //--Dummy Account
        Account a = new Account();
        a.Name = 'Sample Account';
        insert a;
        
        //--Dummy Contact
        Contact c = new Contact();
        c.AccountId = a.Id;
        c.LastName = 'LastName';
        c.FirstName = 'FirstName';
        insert c;
        
        //--Dummy Case
        Case cs2 = new Case();
        cs2.AccountId = a.Id;
        cs2.ContactId = c.Id;
        cs2.Subject = 'Subject Case';
        cs2.Entity_Backup__c = 'AFI';
        cs2.OwnerId = usr.Id;
        Insert cs2;
        
        //eMessage = [SELECT Id, ParentId, Subject, TextBody, FromAddress, ToAddress, MessageDate FROM EmailMessage WHERE ParentId =: cs.Id ORDER BY MessageDate DESC LIMIT 1];
        EmailMessage mess = new EmailMessage();
        mess.ParentId = cs2.Id;
        mess.Subject = 'Test';
        mess.TextBody = 'test ya';
        mess.FromAddress = 'akubaru@gmail.com';
        mess.ToAddress = 'diabaru@gmail.com';
        mess.MessageDate = system.now();
        Insert mess;
        
        Test.startTest();
        
        PageReference pageRef = Page.EmailMessageHistory;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('Id', String.valueOf(cs2.Id));
        ApexPages.StandardController sc = new ApexPages.StandardController(cs2);
        EmailMessageHistoryController testAccPlan = new EmailMessageHistoryController(sc);
        
        Test.stopTest();
    }
}