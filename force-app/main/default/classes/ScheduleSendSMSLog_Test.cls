@isTest(seeAllData = true)
private class ScheduleSendSMSLog_Test {
    static testMethod void test_execute_UseCase1(){
        ScheduleSendSMSLog obj01 = new ScheduleSendSMSLog();
        obj01.execute(null);
    }
    
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
        String entity = 'AFI';
        
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
        
        Date todayDate = Date.today();
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.OwnerId = userId;
        esl.Account__c = contact1.AccountId;
        esl.Case__c = inquiryCreateOpen.Id;
        esl.Category__c = 'ICF';
        esl.Contact__c = contact1.Id;
        esl.Email__c = 'test@email.com';
        esl.Entity__c = entity;
        esl.Method__c = 'SMS';
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
        esl.Ready_To_Send__c = true;
        esl.Bitly__c = 'https://link.com';
        insert esl;
        
        Email_SMS_Log__c esl2 = new Email_SMS_Log__c();
        esl2.OwnerId = userId;
        esl2.Account__c = contact2.AccountId;
        esl2.Case__c = inquiryCreateOpen.Id;
        esl2.Category__c = 'ICF';
        esl2.Contact__c = contact2.Id;
        esl2.Email__c = 'test@email.com';
        esl2.Entity__c = entity;
        esl2.Method__c = 'SMS';
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
        esl2.Ready_To_Send__c = true;
        esl2.Bitly__c = 'https://link.com';
        insert esl2;
        
        Email_SMS_Log__c esl3 = new Email_SMS_Log__c();
        esl3.OwnerId = userId;
        esl3.Account__c = contact1.AccountId;
        esl3.Case__c = inquiryCreateOpen.Id;
        esl3.Category__c = 'Thanks Note';
        esl3.Contact__c = contact1.Id;
        esl3.Email__c = 'test@email.com';
        esl3.Entity__c = entity;
        esl3.Method__c = 'SMS';
        esl3.Mobile__c = contact1.MobilePhone;
        esl3.Request_Date__c = todayDate;
        esl3.Send_Flag__c = true;
        esl3.Start_Date__c = todayDate;
        esl3.Status__c = 'Draft';
        esl3.Type__c = 'CCC';
        esl3.Survey_Type__c = 'I Ask - Inquiry';
        esl3.Email_SMS_Template__c = est.Id;
        esl3.Email_Text__c = 'Email Text Body';
        esl3.Send_Admin_Flag__c = true;
        esl3.Ready_To_Send__c = true;
        esl3.Bitly__c = 'https://link.com';
        insert esl3;
        
        String jobId = System.schedule('ScheduleSendSMSLog Test','0 10 * * * ?', new ScheduleSendSMSLog());
        Test.stopTest();
    }

    public static testmethod void test_flag() {
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
        String entity = 'AFI';
        
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
        
        Date todayDate = Date.today();
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.OwnerId = userId;
        esl.Account__c = contact1.AccountId;
        esl.Case__c = inquiryCreateOpen.Id;
        esl.Category__c = 'ICF';
        esl.Contact__c = contact1.Id;
        esl.Email__c = 'test@email.com';
        esl.Entity__c = entity;
        esl.Method__c = 'SMS';
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
        esl.Ready_To_Send__c = true;
        esl.Bitly__c = 'https://link.com';
        esl.FlagTestClass__c = 'Thanks Note';
        insert esl;
        
        Email_SMS_Log__c esl2 = new Email_SMS_Log__c();
        esl2.OwnerId = userId;
        esl2.Account__c = contact2.AccountId;
        esl2.Case__c = inquiryCreateOpen.Id;
        esl2.Category__c = 'ICF';
        esl2.Contact__c = contact2.Id;
        esl2.Email__c = 'test@email.com';
        esl2.Entity__c = entity;
        esl2.Method__c = 'SMS';
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
        esl2.Ready_To_Send__c = true;
        esl2.Bitly__c = 'https://link.com';
        esl2.FlagTestClass__c = 'Thanks Note';
        insert esl2;
        
        Email_SMS_Log__c esl3 = new Email_SMS_Log__c();
        esl3.OwnerId = userId;
        esl3.Account__c = contact1.AccountId;
        esl3.Case__c = inquiryCreateOpen.Id;
        esl3.Category__c = 'Thanks Note';
        esl3.Contact__c = contact1.Id;
        esl3.Email__c = 'test@email.com';
        esl3.Entity__c = entity;
        esl3.Method__c = 'SMS';
        esl3.Mobile__c = contact1.MobilePhone;
        esl3.Request_Date__c = todayDate;
        esl3.Send_Flag__c = true;
        esl3.Start_Date__c = todayDate;
        esl3.Status__c = 'Draft';
        esl3.Type__c = 'CCC';
        esl3.Survey_Type__c = 'I Ask - Inquiry';
        esl3.Email_SMS_Template__c = est.Id;
        esl3.Email_Text__c = 'Email Text Body';
        esl3.Send_Admin_Flag__c = true;
        esl3.Ready_To_Send__c = true;
        esl3.Bitly__c = 'https://link.com';
        esl3.FlagTestClass__c = 'Thanks Note';
        insert esl3;
        
        String jobId = System.schedule('ScheduleSendSMSLog Test','0 10 * * * ?', new ScheduleSendSMSLog());
        Test.stopTest();
    }

    public static testmethod void test2() {
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
        String entity = 'NewAFI';
        
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
        
        //Email_SMS_Template__c est = [SELECT Id FROM Email_SMS_Template__c WHERE Category__c = 'ICF' AND Entity__c = :entity LIMIT 1];
        
        Date todayDate = Date.today();
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.OwnerId = userId;
        esl.Account__c = contact1.AccountId;
        esl.Case__c = inquiryCreateOpen.Id;
        esl.Category__c = 'ICF';
        esl.Contact__c = contact1.Id;
        esl.Email__c = 'test@email.com';
        esl.Entity__c = entity;
        esl.Method__c = 'SMS';
        esl.Mobile__c = contact1.MobilePhone;
        esl.Request_Date__c = todayDate;
        esl.Send_Flag__c = true;
        esl.Start_Date__c = todayDate;
        esl.Status__c = 'Draft';
        esl.Type__c = 'CCC';
        esl.Survey_Type__c = 'I Ask - Inquiry';
        //esl.Email_SMS_Template__c = est.Id;
        esl.Email_Text__c = 'Email Text Body';
        esl.Send_Admin_Flag__c = true;
        esl.Ready_To_Send__c = true;
        esl.Bitly__c = 'https://link.com';
        insert esl;
        
        Email_SMS_Log__c esl2 = new Email_SMS_Log__c();
        esl2.OwnerId = userId;
        esl2.Account__c = contact2.AccountId;
        esl2.Case__c = inquiryCreateOpen.Id;
        esl2.Category__c = 'ICF';
        esl2.Contact__c = contact2.Id;
        esl2.Email__c = 'test@email.com';
        esl2.Entity__c = entity;
        esl2.Method__c = 'SMS';
        esl2.Mobile__c = contact2.MobilePhone;
        esl2.Request_Date__c = todayDate;
        esl2.Send_Flag__c = true;
        esl2.Start_Date__c = todayDate;
        esl2.Status__c = 'Draft';
        esl2.Type__c = 'CCC';
        //esl2.Survey_Type__c = 'I Complain';
        //esl2.Email_SMS_Template__c = est.Id;
        esl2.Email_Text__c = 'Email Text Body';
        esl2.Send_Admin_Flag__c = true;
        esl2.Ready_To_Send__c = true;
        esl2.Bitly__c = 'https://link.com';
        insert esl2;
        
        Email_SMS_Log__c esl3 = new Email_SMS_Log__c();
        esl3.OwnerId = userId;
        esl3.Account__c = contact1.AccountId;
        esl3.Case__c = inquiryCreateOpen.Id;
        esl3.Category__c = 'Thanks Note';
        esl3.Contact__c = contact1.Id;
        esl3.Email__c = 'test@email.com';
        esl3.Entity__c = entity;
        esl3.Method__c = 'SMS';
        esl3.Mobile__c = contact1.MobilePhone;
        esl3.Request_Date__c = todayDate;
        esl3.Send_Flag__c = true;
        esl3.Start_Date__c = todayDate;
        esl3.Status__c = 'Draft';
        esl3.Type__c = 'CCC';
        esl3.Survey_Type__c = 'I Ask - Inquiry';
        //esl3.Email_SMS_Template__c = est.Id;
        esl3.Email_Text__c = 'Email Text Body';
        esl3.Send_Admin_Flag__c = true;
        esl3.Ready_To_Send__c = true;
        esl3.Bitly__c = 'https://link.com';
        insert esl3;
        
        String jobId = System.schedule('ScheduleSendSMSLog Test','0 10 * * * ?', new ScheduleSendSMSLog());
        Test.stopTest();
    }

}