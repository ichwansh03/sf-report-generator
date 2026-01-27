@isTest
public class AssignCaseSocialMediaTest {
    static testMethod void buttonClick() {
        Account acc = new Account();
        acc.Name = 'Account AMFS';
        insert acc;
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'Anonymous AMFS';
        insert con;
        
        RecordType recTypeCase = [SELECT Id, Name FROM RecordType WHERE Name = 'SocialPost-AMFS' LIMIT 1];
        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;
        c.RecordTypeId = recTypeCase.Id;
        c.Subject = 'Test Case';
        c.Origin = 'Facebook';
        insert c;
        
        AssignCaseSocialMedia.assign(c.Id, 'AMFS', c.Origin);
    }
}