@isTest(seeAllData = true)
public class CreateEmailSmsLogWhenCaseClosed8_Test {
	public static testmethod void createEmailSmsLogWhenCaseClosedTest8() {
        Test.startTest();
        String INQUIRY = 'Inquiry';
        String REQUEST = 'Request';
        String COMPLAINT = 'Complaint';
        String NEW_STATUS = 'New';
        String CLOSED = 'Closed';
        String RECORD_TYPE_EMAIL_SMS = 'Master - Email & SMS';
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = userObj.Entity__c;
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest8';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com';
        contact1.MobilePhone = '0891667363';
        contact1.Policy_No__c = '77700125';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        Contact contact2 = new Contact();
        contact2.FirstName = 'Bill2';
        contact2.LastName = 'Gates2';
        contact2.Email = 'billgates@email.com';
        contact2.MobilePhone = '0891667363';
        contact2.Policy_No__c = '77700126';
        contact2.Entity__c = entity;
        contact2.AccountId = ac1.Id;
        insert contact2;
        
        EmailSmsLogUtil emailSmsLogutil = new EmailSmsLogUtil();
        ICF_Parameter__c icfParamObj = emailSmsLogutil.getICFParamByRecordType(RECORD_TYPE_EMAIL_SMS, entity);
        //icfParamObj.Send_Thanks_Note_Flag__c = false;
        //update icfParamObj;
        
        ICF_Parameter__c icfParamNew = new ICF_Parameter__c();
        icfParamNew = icfParamObj.clone();
        icfParamNew.Send_Thanks_Note_Flag__c = false;
        insert icfParamNew;
        
        //CREATED-OPEN | INQUIRY & REQUEST =============================================================================
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
        
        Case requestCreateOpen = new Case();
        requestCreateOpen.ContactId = contact2.Id;
        requestCreateOpen.Type = REQUEST;
        requestCreateOpen.Status = NEW_STATUS;
        requestCreateOpen.Priority = 'Medium';
        requestCreateOpen.Origin = 'Phone';
        requestCreateOpen.Case_Type__c = 'MV Claim Report';
        requestCreateOpen.Case_Type_Config__c = 'MV Claim Report';
        requestCreateOpen.PIC_Department_LU__c = UserInfo.getUserId();
        requestCreateOpen.AccountId = contact2.AccountId;
        insert requestCreateOpen;
        
        Test.stopTest();
    }
}