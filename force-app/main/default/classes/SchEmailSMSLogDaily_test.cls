@isTest(seeAllData = true)
public class SchEmailSMSLogDaily_test {
    public static testmethod void test() {
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
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = INQUIRY;
        inquiryCreateOpen.Status = CLOSED;
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Phone';
        inquiryCreateOpen.Case_Type__c = 'Claim Procedure';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        insert inquiryCreateOpen;
        
        EmailSmsLogUtil emailSmsLogUtil = new EmailSmsLogUtil();
        ICF_Parameter__c icfParamObj = emailSmsLogutil.initICFParam(inquiryCreateOpen, MASTER_EMAIL_SMS);
        
        Email_SMS_Template__c est = [SELECT Id FROM Email_SMS_Template__c WHERE Category__c = 'ICF' AND Entity__c = :entity LIMIT 1];

        list<Email_SMS_Log__c> esldel = [SELECT id FROM Email_SMS_Log__c WHERE Method__c = 'Email' and Send_Flag__c = TRUE and End_Date__c = NULL and Status__c != 'Cancel'];
        if (esldel.size() > 0) delete esldel;
        
        Date todayDate = Date.today();
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.OwnerId = userId;
        esl.Account__c = contact1.AccountId;
        esl.Case__c = inquiryCreateOpen.Id;
        esl.Category__c = 'ICF';
        esl.Contact__c = contact1.Id;
        esl.Email__c = 'billgates@email.com';
        esl.Entity__c = entity;
        esl.Method__c = 'Email';
        esl.Mobile__c = contact1.MobilePhone;
        esl.Request_Date__c = todayDate;
        esl.Send_Flag__c = true;
        esl.Start_Date__c = todayDate;
        esl.Status__c = 'Draft';
        esl.Type__c = 'CCC';
        esl.Survey_Type__c = 'I Ask - Inquiry';
        esl.Email_SMS_Template__c = est.Id;
        esl.Email_Text__c = 'Email Text Body';
        esl.Send_Admin_Flag__c = true;
        insert esl;
        
        Email_SMS_Log__c esl2 = new Email_SMS_Log__c();
        esl2.OwnerId = userId;
        esl2.Account__c = contact2.AccountId;
        esl2.Case__c = inquiryCreateOpen.Id;
        esl2.Category__c = 'ICF';
        esl2.Contact__c = contact2.Id;
        esl2.Email__c = 'billgates@email.com';
        esl2.Entity__c = entity;
        esl2.Method__c = 'Email';
        esl2.Mobile__c = contact2.MobilePhone;
        esl2.Request_Date__c = todayDate;
        esl2.Send_Flag__c = true;
        esl2.Start_Date__c = todayDate;
        esl2.Status__c = 'Draft';
        esl2.Type__c = 'CCC';
        esl2.Survey_Type__c = 'I Complain';
        esl2.Email_SMS_Template__c = est.Id;
        esl2.Email_Text__c = 'Email Text Body';
        esl2.Send_Admin_Flag__c = true;
        insert esl2;
                
        String jobId = System.schedule('SchEmailSMSLogDaily Test','0 0 0/1 1/1 * ? *', new SchEmailSMSLogDaily());
        
        esl2.End_date__c = null;
        esl2.Status__c = 'Draft';
        update esl2;
        
        list<ICF_Parameter__c> delicf = [SELECT id FROM ICF_Parameter__c WHERE Entity__c = 'General'];
        
        delete delicf;
        
        String jobId2 = System.schedule('SchEmailSMSLogDaily Test2','0 0 0/1 1/1 * ? *', new SchEmailSMSLogDaily());

        Test.stopTest();
    } 
    
    
    public static testmethod void testSch() {
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
        
        EmailSmsLogUtil emailSmsLogUtil = new EmailSmsLogUtil();
        ICF_Parameter__c icfParamObj = emailSmsLogutil.initICFParam(inquiryCreateOpen, MASTER_EMAIL_SMS);
        EmailSmsLogUtil.ICFConfig ic = emailSmsLogUtil.initConfig(inquiryCreateOpen, contact2, icfParamObj, INQUIRY);
        emailSmsLogUtil.createLogDraft(ic, inquiryCreateOpen, contact2, icfParamObj, INQUIRY);
        
        CreateEmailSmsLogQueueChild caseQueueChild = new CreateEmailSmsLogQueueChild(inquiryCreateOpen);
        System.enqueueJob(caseQueueChild);
        
        Date todayDate = Date.today();
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.OwnerId = userId;
        esl.Account__c = contact1.AccountId;
        esl.Case__c = inquiryCreateOpen.Id;
        esl.Category__c = 'ICF';
        esl.Contact__c = contact1.Id;
		esl.Email__c = 'test@email.com';
        esl.Entity__c = inquiryCreateOpen.Entity__c;
        esl.Method__c = 'Email';
        esl.Mobile__c = contact1.MobilePhone;
        esl.Request_Date__c = todayDate;
        esl.Send_Flag__c = true;
        esl.Start_Date__c = todayDate;
        esl.Status__c = 'Draft';
		esl.Type__c = 'CCC';
        insert esl;
        
        Email_SMS_Log__c eslTn = new Email_SMS_Log__c();
        eslTn.OwnerId = userId;
        eslTn.Account__c = contact1.AccountId;
        eslTn.Case__c = inquiryCreateOpen.Id;
        eslTn.Category__c = 'Thanks Note';
        eslTn.Contact__c = contact1.Id;
		eslTn.Email__c = 'test@email.com';
        eslTn.Entity__c = inquiryCreateOpen.Entity__c;
        eslTn.Method__c = 'Email';
        eslTn.Mobile__c = contact1.MobilePhone;
        eslTn.Request_Date__c = todayDate;
        eslTn.Send_Flag__c = true;
        eslTn.Start_Date__c = todayDate;
        eslTn.Status__c = 'Draft';
		eslTn.Type__c = 'CCC';
        insert eslTn;
        
        caseQueueChild.updateInquiryToCancel(esl);
        caseQueueChild.updateInquiryToCancelTn(eslTn);
        caseQueueChild.getICFLog(contact1, ic);
        caseQueueChild.getTnLog(contact1, ic);
        
        String SEND = 'Send';
        String ICF = 'ICF';
        DescribeSObjectResult describeResultEsl = Email_SMS_Log__c.getSObjectType().getDescribe();
        List<String> eslFieldList = new List<String>(describeResultEsl.fields.getMap().keySet());
        String eslFields = String.join(eslFieldList, ',');
        String querySelectEslTodaySend = '';
        Map<String, Integer> intervalMap = new Map<String, Integer>();
    	Map<String, String> surveyTypeMap = new Map<String, String>();
        String query = ' SELECT ' + eslFields + ' FROM Email_SMS_Log__c WHERE Category__c = :ICF AND Status__c = :SEND AND End_Date__c = :MyDate AND Updated_Contact_Flag__c = false LIMIT 100 ';
        UpdateContactAfterSendLog ucas = new UpdateContactAfterSendLog(intervalMap, surveyTypeMap, query);
        ucas.initFC(esl);
        
        System.schedule('SchEmailSMSLogDaily Test','0 0 0/1 1/1 * ? *', new SchEmailSMSLogDaily());        
        
        Test.stopTest();
    }
}