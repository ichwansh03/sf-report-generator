@isTest(seeAllData = true)
public class EmailSmsLogUtil1_Test {
    public static testmethod void emailSmsLogUtilTest1() {
        Test.startTest();
        String MASTER_EMAIL_SMS = 'Master - Email & SMS';
        String MASTER_CCC = 'Master - CCC';
        String I_ASK = 'I Ask';
        String I_BUY = 'I Buy';
        String I_CLAIM = 'I Claim';
        String I_COMPLAIN = 'I Complain';
        String I_RENEW = 'I Renew';
        String OTHER = 'Other';
        Date todayDate = Date.today();
        Integer interval = 6;
        String INTERVAL_NO_RESPONSE_UNIT = 'WEEK';
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = userObj.Entity__c;
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest2';
        ac1.Entity__c = entity;
        insert ac1;
            
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com';
        contact1.MobilePhone = '0891667363';
        contact1.Policy_No__c = '77700140';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        Survey__c survey = new Survey__c();
        survey.Status__c = 'Open';
        survey.Survey_Type__c = 'I Ask';
        survey.Submit_Response__c = 'empty';
        insert survey;
        
        SurveyTaker__c st = new SurveyTaker__c();
        st.Survey__c = survey.Id;
        st.Contact__c = contact1.Id;
        st.User__c = userId;
        st.Taken__c = 'true';
        insert st;
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = OTHER;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = OTHER;
        esl.Request_Date__c = todayDate;
        insert esl;
        
        EmailSmsLogUtil emailSmsLogUtil = new EmailSmsLogUtil();
        emailSmsLogUtil.initICFParam(null, MASTER_EMAIL_SMS);
        emailSmsLogUtil.getICFParamByRecordType(MASTER_EMAIL_SMS, null);
        emailSmsLogUtil.getSurveyById(survey.Id);
        emailSmsLogUtil.getContactById(contact1.Id);
        emailSmsLogUtil.updateContactFreezeDate(contact1, todayDate, interval, I_ASK, INTERVAL_NO_RESPONSE_UNIT);
        emailSmsLogUtil.updateContactFreezeDate(contact1, todayDate, interval, I_BUY, INTERVAL_NO_RESPONSE_UNIT);
        emailSmsLogUtil.updateContactFreezeDate(contact1, todayDate, interval, I_CLAIM, INTERVAL_NO_RESPONSE_UNIT);
        emailSmsLogUtil.updateContactFreezeDate(contact1, todayDate, interval, I_COMPLAIN, INTERVAL_NO_RESPONSE_UNIT);
        emailSmsLogUtil.updateContactFreezeDate(contact1, todayDate, interval, I_RENEW, INTERVAL_NO_RESPONSE_UNIT);
        emailSmsLogUtil.getSurveyTakerById(st.Id);
        emailSmsLogUtil.getEmailSmsLogByRequestDate(OTHER, contact1, todayDate);
        
        Test.stopTest();
    }
}