@isTest(seeAllData = true)
public class EmailSmsLogUtil3_Test {
    
    public static testmethod void emailSmsLogUtilTest2(){
        Test.startTest();
        String INQUIRY = 'Inquiry';
        String REQUEST = 'Request';
        String COMPLAINT = 'Complaint';
        String NEW_STATUS = 'New';
        String CLOSED = 'Closed';
        String MASTER_EMAIL_SMS = 'Master - Email & SMS';
        String RECORD_TYPE_QUALTRICS = 'Master - Qualtrics';
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
        contact1.Survey_Method__c = 'Whatsapp';
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
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master Qualtrics').getRecordTypeId();
        insert setSurvey;
        
        SurveyTaker__c st = new SurveyTaker__c();
        st.Contact__c = contact2.Id;
        st.Survey__c = setSurvey.Id;
        st.Taken__c = 'true';
        st.User__c = userObj.Id;
        insert st;
        
        //CREATED-OPEN | INQUIRY =============================================================================
        List<Case> list_case = new List<Case>();
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = INQUIRY;
        inquiryCreateOpen.Status = CLOSED;
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Phone';
        inquiryCreateOpen.Case_Type__c = 'Claim Procedure';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.mot__c = 'I Ask';
        
        Case inquiryCreate2 = new Case();
        inquiryCreate2.ContactId = contact2.Id;
        inquiryCreate2.Type = INQUIRY;
        inquiryCreate2.Status = CLOSED;
        inquiryCreate2.Priority = 'Medium';
        inquiryCreate2.Origin = 'Phone';
        inquiryCreate2.Case_Type__c = 'Claim Procedure';
        inquiryCreate2.Subject = 'Case Subject 123456';
        inquiryCreate2.AccountId = contact2.AccountId;
        
        list_case.add(inquiryCreateOpen);
        list_case.add(inquiryCreate2);
        insert list_case;
                
        EmailSmsLogUtil emailSmsLogUtil = new EmailSmsLogUtil();
        ICF_Parameter__c icfParamObj = emailSmsLogutil.getICFParamByRecordType(RECORD_TYPE_QUALTRICS, 'AMFS'); 
        ICF_Parameter__c icfParamCCC = emailSmsLogutil.getICFParamByRecordType(RECORD_TYPE_QUALTRICS, 'AMFS');
        EmailSmsLogUtil.ICFConfig ic = emailSmsLogUtil.initConfig(inquiryCreateOpen, contact1, icfParamObj, INQUIRY);
        emailSmsLogUtil.createLogCancel(ic, inquiryCreateOpen, contact1, icfParamObj, INQUIRY, '', '');
        emailSmsLogUtil.createLogTNCancel(ic, inquiryCreate2, contact2, icfParamObj, INQUIRY, '', '');
        emailSmsLogutil.saveIcfInsert(inquiryCreateOpen, contact1, icfParamObj, icfParamCCC, INQUIRY, CLOSED);
        Test.stopTest();
    }
    
    public static testmethod void emailSmsLogUtilTest3() {
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
        contact1.Survey_Method__c = 'Whatsapp';
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
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master Qualtrics').getRecordTypeId();
        insert setSurvey;
        
        SurveyTaker__c st = new SurveyTaker__c();
        st.Contact__c = contact2.Id;
        st.Survey__c = setSurvey.Id;
        st.Taken__c = 'true';
        st.User__c = userObj.Id;
        insert st;
        
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
        
        
        EmailSmsLogUtil.updateContactFreezeDateFuture(contact1.Id, Date.today(), 1, 'I Ask', '1');
        emailSmsLogUtil.updateContactFreezeDateFuture(contact1.Id, Date.today(), 1, 'I Buy', '1');
        emailSmsLogUtil.updateContactFreezeDateFuture(contact1.Id, Date.today(), 1, 'I Claim', '1');
        emailSmsLogUtil.updateContactFreezeDateFuture(contact1.Id, Date.today(), 1, 'I Complain', '1');
        emailSmsLogUtil.updateContactFreezeDateFuture(contact1.Id, Date.today(), 1, 'I Renew', '1');
        
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
        eslTn.Request_Date__c = Date.today();
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
        
        
        Contact ContactTest = emailSmsLogUtil.getContactById(contact1.Id);
        Survey__c SurveyTest = emailSmsLogUtil.getSurveyById(setSurvey.Id);
        Email_SMS_Log__c ESLTest = emailSmsLogUtil.getEmailSmsLogByRequestDate('Thanks Note',contact1, Date.today());
        SurveyTaker__c stTest = emailSmsLogUtil.getSurveyTakerById(st.Id);
        
        EmailSmsLogUtil.updateContactFreezeDate(contact1, Date.today(), 1, 'I Ask', '1');
        emailSmsLogUtil.updateContactFreezeDate(contact1, Date.today(), 1, 'I Buy', '1');
        emailSmsLogUtil.updateContactFreezeDate(contact1, Date.today(), 1, 'I Claim', '1');
        emailSmsLogUtil.updateContactFreezeDate(contact1, Date.today(), 1, 'I Complain', '1');
        emailSmsLogUtil.updateContactFreezeDate(contact1, Date.today(), 1, 'I Renew', '1');
        
        EmailSmsLogUtil.updateContactFreezeDateToday(contact1, Date.today(), 1, 'I Ask');
        emailSmsLogUtil.updateContactFreezeDateToday(contact1, Date.today(), 1, 'I Buy');
        emailSmsLogUtil.updateContactFreezeDateToday(contact1, Date.today(), 1, 'I Claim');
        emailSmsLogUtil.updateContactFreezeDateToday(contact1, Date.today(), 1, 'I Complain');
        emailSmsLogUtil.updateContactFreezeDateToday(contact1, Date.today(), 1, 'I Renew');
        
        
        
        Test.stopTest();
    }
    
    
}