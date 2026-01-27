@isTest(seeAllData = true)
public class EmailSmsLogUtil2_Test {
    public static testmethod void emailSmsLogUtilTest2() {
        Test.startTest();
        String INQUIRY = 'Inquiry';
        String REQUEST = 'Request';
        String COMPLAINT = 'Complaint';
        String NEW_STATUS = 'New';
        String CLOSED = 'Closed';
        String MASTER_EMAIL_SMS = 'Master - Email & SMS';
        String MASTER_CCC = 'Master - CCC';
        String OPEN = 'Open';
        String EXCLUDED = 'Excluded by ICF Parameter';
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = userObj.Entity__c;
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest20';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com';
        contact1.MobilePhone = '0891667363';
        contact1.Policy_No__c = '77700144';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        Contact contact2 = new Contact();
        contact2.FirstName = 'Bill2';
        contact2.LastName = 'Gates2';
        contact2.Email = 'billgates@email.com';
        contact2.MobilePhone = '0891667363';
        contact2.Policy_No__c = '77700145';
        contact2.Entity__c = entity;
        contact2.AccountId = ac1.Id;
        insert contact2;
        
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
        
        EmailSmsLogUtil emailSmsLogUtil1 = new EmailSmsLogUtil();
        ICF_Parameter__c icfParamObj = emailSmsLogUtil1.initICFParam(inquiryCreateOpen, MASTER_EMAIL_SMS);
        ICF_Parameter__c icfParamCCC = emailSmsLogUtil1.getICFParamByRecordType(MASTER_CCC, inquiryCreateOpen.Entity__c);
        emailSmsLogUtil1.saveIcfTnUpdated(inquiryCreateOpen, contact2, icfParamObj, icfParamCCC, INQUIRY, OPEN);
        
        EmailSmsLogUtil.ICFConfig ic = emailSmsLogUtil1.initConfig(inquiryCreateOpen, contact2, icfParamObj, INQUIRY);
        emailSmsLogUtil1.createLogCancel(ic, inquiryCreateOpen, contact2, icfParamObj, INQUIRY, 'Drop Call/Wrong Number', EXCLUDED);
        emailSmsLogUtil1.createLogTNCancel(ic, inquiryCreateOpen, contact2, icfParamObj, INQUIRY, 'Drop Call/Wrong Number', EXCLUDED);
        emailSmsLogUtil1.updateContactFreezeDateToday(contact2, Date.today(), 1, 'I Ask');
        
        EmailSmsLogUtil.updateContactFreezeDateFuture(contact2.Id, Date.today(), 1, 'I Ask', 'MONTH');
        
        Test.stopTest();
    }
}