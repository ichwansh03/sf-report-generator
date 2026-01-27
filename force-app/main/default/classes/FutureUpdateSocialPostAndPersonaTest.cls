@isTest
public class FutureUpdateSocialPostAndPersonaTest {
    @testSetup static void Setup() {
        //User usr = [Select Id From User Where IsActive = true And Agent__c = True AND Agent_Queue_ID_Email_Reply_Customer__c != Null AND UserRoleId = '00E90000001QoDx' Limit 1];
        //User usr2 = [Select Id From User Where IsActive = true And Agent__c = True AND Agent_Queue_ID_Email_Reply_Customer__c = Null AND UserRoleId = '00E6F000001VNGB' Limit 1];
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
        Case cs = new Case();
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject Case';
        cs.Entity_Backup__c = 'AFI';
        cs.OwnerId = usr.Id;
        Insert cs;
        
        //--Dummy Case
        /*Case cs2 = new Case();
        cs2.AccountId = a.Id;
        cs2.ContactId = c.Id;
        cs2.Subject = 'Subject Case';
        cs2.Entity_Backup__c = 'AFI';
        cs2.OwnerId = usr.Id;
        Insert cs2;
        
        //--Dummy Case
        Case cs3 = new Case();
        cs3.AccountId = a.Id;
        cs3.ContactId = c.Id;
        cs3.Subject = 'Subject Case';
        cs3.Entity_Backup__c = 'ALI';
        cs3.OwnerId = usr2.Id;
        Insert cs3;*/
        
        //--Dummy SocialPersona
        SocialPersona spe = new SocialPersona();
        spe.ParentId = c.Id;
        spe.Name = 'Sample Social Persona';
        spe.Provider = 'Facebook';
        insert spe;
        
        //--Dummy SocialPost
        SocialPost spo = new SocialPost();
        spo.ParentId = cs.Id;
        spo.PersonaId = spe.Id;
        spo.WhoId = c.Id;
        spo.Name = 'Sample Social Post';
        spo.Provider = 'Facebook';
        spo.PostTags = 'AXA Financial Indonesia';
        insert spo;
    }
    
    public static testMethod void runFutureClass() {
        List<Case> recordCase = [SELECT Id FROM Case WHERE Subject = 'Subject Case' LIMIT 1];
        List<Contact> recordContact = [SELECT Id FROM Contact WHERE LastName = 'LastName' LIMIT 1];
        
        Id caseId = recordCase[0].Id;
        Id oldContactId = recordContact[0].Id;
        
        Test.startTest();
        FutureUpdateSocialPostAndPersona.updateRecord(caseId, oldContactId);
        Test.stopTest();
    }
}