@isTest(seeAllData = true)
public class EmailSMSLog_UpdateContact_Test {
    public static testmethod void emailSMSLogUpdateContactTest() {
        Test.startTest();
        String ICF = 'ICF';
        String I_ASK = 'I Ask';
        String I_BUY = 'I Buy';
        String I_CLAIM = 'I Claim';
        String I_COMPLAIN = 'I Complain';
        String I_RENEW = 'I Renew';
        Date todayDate = Date.today();
        String INQUIRY = 'Inquiry';
        String NEW_STATUS = 'New';
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = userObj.Entity__c;
        
        Email_SMS_Template__c est = [select id, Name from Email_SMS_Template__c where name = 'ICF Email (AMFS) 2024' limit 1];
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest20';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com';
        contact1.MobilePhone = '0891667363';
        contact1.Policy_No__c = '77700101';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = INQUIRY;
        inquiryCreateOpen.Status = NEW_STATUS;
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        insert inquiryCreateOpen;
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.case__c = inquiryCreateOpen.id;
        esl.Contact__c = contact1.Id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = I_ASK;
        esl.Request_Date__c = todayDate;
        esl.Template_Email__c = est.Id;
        esl.Email_SMS_Template__c = est.Id;
        insert esl;
        
        system.debug('Template:'+esl.Email_SMS_Template__c);
        
        esl.Fg_Update_Contact__c = true;
        esl.Survey_Type__c = I_ASK;
        update esl;
        esl.Fg_Update_Contact__c = true;
        esl.Survey_Type__c = I_BUY;
        update esl;
        esl.Fg_Update_Contact__c = true;
        esl.Survey_Type__c = I_CLAIM;
        update esl;
        esl.Fg_Update_Contact__c = true;
        esl.Survey_Type__c = I_COMPLAIN;
        update esl;
        esl.Fg_Update_Contact__c = true;
        esl.Survey_Type__c = I_RENEW;
        update esl;
        
        Test.stopTest();
    }
}