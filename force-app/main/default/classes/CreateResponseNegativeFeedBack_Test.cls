@isTest(seeAllData = true)
public class CreateResponseNegativeFeedBack_Test {
    public static testmethod void createResponseNegativeTest() {
        Test.startTest();
        String INQUIRY = 'Inquiry';
        String REQUEST = 'Request';
        String COMPLAINT = 'Complaint';
        String NEW_STATUS = 'New';
        String CLOSED = 'Closed';
        String MASTER_EMAIL_SMS = 'Master - Email & SMS';
        String MASTER_CCC = 'Master - CCC';
        String OPEN = 'Open';
        String ICF = 'ICF';
        Date todayDate = Date.today();
        
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
        
        //CREATED-OPEN | INQUIRY =============================================================================
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = INQUIRY;
        inquiryCreateOpen.Status = NEW_STATUS;
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Phone';
        inquiryCreateOpen.Case_Type__c = 'Claim Procedure';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        insert inquiryCreateOpen;
        
        SurveyTaker__c st = new SurveyTaker__c();
        st.Survey__c = survey.Id;
        st.Contact__c = contact1.Id;
        st.Case__c = inquiryCreateOpen.Id;
        st.User__c = userId;
        st.Taken__c = 'true';
        insert st;
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Case__c = inquiryCreateOpen.Id;
        esl.Contact__c = contact1.Id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Ask';
        esl.Request_Date__c = todayDate;
        esl.End_Date__c = todayDate;
        insert esl;
        
        Survey_Response__c resp = new Survey_Response__c();
        resp.Survey__c = survey.Id;
        resp.SurveyTaker__c = st.Id;
        resp.Negative_Question__c = '1';
        resp.Negative_Answer__c = '2';
        resp.Answer_Index_1__c = '0';
        resp.Answer_Index_2__c = '0';
        resp.Answer_Index_3__c = '0';
        resp.Email_Sms_Log__c = esl.Id;
        insert resp;
        
        Test.stopTest();
    }
}