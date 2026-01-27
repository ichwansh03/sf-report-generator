@isTest(seeAllData = true)
public class CreateEmailSmsLogWhenCaseClosed14_Test {
    public static testmethod void createEmailSmsLogWhenCaseClosedTest14() {
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
        ac1.Name = 'AccountTest14';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com';
        contact1.MobilePhone = '0891667363';
        contact1.Policy_No__c = '77700133';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        EmailSmsLogUtil emailSmsLogutil = new EmailSmsLogUtil();
        ICF_Parameter__c icfParamObj = emailSmsLogutil.getICFParamByRecordType(RECORD_TYPE_EMAIL_SMS, entity);
        //icfParamObj.Send_ICF_Flag__c = false;
        //update icfParamObj;
        
        ICF_Parameter__c icfParamNew = new ICF_Parameter__c();
        icfParamNew = icfParamObj.clone();
        icfParamNew.Send_ICF_Flag__c = false;
        insert icfParamNew;
        
        //CREATED-OPEN | REQUEST =============================================================================
        Case requestCreateOpen = new Case();
        requestCreateOpen.ContactId = contact1.Id;
        requestCreateOpen.Type = REQUEST;
        requestCreateOpen.Status = NEW_STATUS;
        requestCreateOpen.Priority = 'Medium';
        requestCreateOpen.Origin = 'Phone';
        requestCreateOpen.Case_Type__c = 'MV Claim Report';
        requestCreateOpen.Case_Type_Config__c = 'MV Claim Report';
        requestCreateOpen.PIC_Department_LU__c = UserInfo.getUserId();
        requestCreateOpen.AccountId = contact1.AccountId;
        insert requestCreateOpen;
        
        //UPDATED TO CLOSED==============================================================================================
        requestCreateOpen.Status = CLOSED;
        update requestCreateOpen;
        
        Test.stopTest();
    }
}