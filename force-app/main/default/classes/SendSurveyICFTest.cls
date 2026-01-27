@isTest
public class SendSurveyICFTest {
    public static testmethod void sendSurvey() {
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        Test.startTest();
        String ICF = 'ICF';
        String I_ASK = 'I Ask';
        String I_BUY = 'I Buy';
        String I_CLAIM = 'I Claim';
        String I_COMPLAIN = 'I Complain';
        String I_RENEW = 'I Renew';
        Date todayDate = Date.today();
        String INQUIRY = 'Inquiry';
        String REQUEST = 'Request';
        String COMPLAINT = 'Complaint';
        String NEW_STATUS = 'New';
        String RECORD_TYPE_MASTER_QUALTRICS = 'Master - Qualtrics';
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';
        
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
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master Qualtrics').getRecordTypeId();
        setSurvey.URL__c = 'www.testurl.com';
        insert setSurvey;
        
        
        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        setCaseType.name = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Ask';
        setCaseType.Qualtrics__c  = true;
        INSERT setCaseType;
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = INQUIRY;
        inquiryCreateOpen.Status = NEW_STATUS;
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        inquiryCreateOpen.MOT__c = 'I Ask';
        insert inquiryCreateOpen;
        
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Qualtrics').getRecordTypeId();
        testICFParam.Interval_Completed_Month__c = '1';
        testICFParam.Entity__c = 'AMFS';
        testICFParam.Status__c = 'Active';
        //testICFParam.Status_Cases__c = 'Closed';
        insert testICFParam;
        
        ICF_Parameter__c testICFParam2 = new ICF_Parameter__c();
        testICFParam2.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam2.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId();
        testICFParam2.Interval_Completed_Month__c = '1';
        testICFParam2.Entity__c = 'AMFS';
        testICFParam2.Status__c = 'Active';
        //testICFParam2.Status_Cases__c = 'Closed';
        insert testICFParam2;
        
        ICF_Template_and_Namespace__c setTemplate = new ICF_Template_and_Namespace__c();
        setTemplate.Survey_Type__c = 'I Ask';
        setTemplate.Template_ID__c = 'test';
        setTemplate.Namespace__c = 'test'; 
        insert setTemplate;
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.MOT__c = 'I Ask';
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = I_ASK;
        esl.Request_Date__c = todayDate;
        insert esl;
        
        Set<id> sendWa = new Set<id>();
        sendWa.add(esl.id);
        System.enqueueJob(new SendSurveyICF.sendWhatsapp(sendWa)); 
        
        Test.stopTest();
    }
    
    public static testmethod void sendSurveyTemplateNull() {
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        Test.startTest();
        String ICF = 'ICF';
        String I_ASK = 'I Ask';
        String I_BUY = 'I Buy';
        String I_CLAIM = 'I Claim';
        String I_COMPLAIN = 'I Complain';
        String I_RENEW = 'I Renew';
        Date todayDate = Date.today();
        String INQUIRY = 'Inquiry';
        String REQUEST = 'Request';
        String COMPLAINT = 'Complaint';
        String NEW_STATUS = 'New';
        String RECORD_TYPE_MASTER_QUALTRICS = 'Master - Qualtrics';
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';
        
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
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master Qualtrics').getRecordTypeId();
        setSurvey.URL__c = 'www.testurl.com';
        insert setSurvey;
        
        
        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        setCaseType.name = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Ask';
        setCaseType.Qualtrics__c  = true;
        INSERT setCaseType;
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = INQUIRY;
        inquiryCreateOpen.Status = NEW_STATUS;
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        inquiryCreateOpen.MOT__c = 'I Ask';
        insert inquiryCreateOpen;
        
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Qualtrics').getRecordTypeId();
        testICFParam.Interval_Completed_Month__c = '1';
        testICFParam.Entity__c = 'AMFS';
        testICFParam.Status__c = 'Active';
        //testICFParam.Status_Cases__c = 'Closed';
        insert testICFParam;
        
        ICF_Parameter__c testICFParam2 = new ICF_Parameter__c();
        testICFParam2.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam2.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId();
        testICFParam2.Interval_Completed_Month__c = '1';
        testICFParam2.Entity__c = 'AMFS';
        testICFParam2.Status__c = 'Active';
        //testICFParam2.Status_Cases__c = 'Closed';
        insert testICFParam2;
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.MOT__c = 'I Ask';
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = I_ASK;
        esl.Request_Date__c = todayDate;
        insert esl;
        
        Set<id> sendWa = new Set<id>();
        sendWa.add(esl.id);
        System.enqueueJob(new SendSurveyICF.sendWhatsapp(sendWa)); 
        
        Test.stopTest();
    }
    
    public static testmethod void sendSurveyClaim() {
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        Test.startTest();
        String ICF = 'ICF';
        String I_ASK = 'I Ask';
        String I_BUY = 'I Buy';
        String I_CLAIM = 'I Claim';
        String I_COMPLAIN = 'I Complain';
        String I_RENEW = 'I Renew';
        Date todayDate = Date.today();
        String INQUIRY = 'Inquiry';
        String REQUEST = 'Request';
        String COMPLAINT = 'Complaint';
        String NEW_STATUS = 'New';
        String RECORD_TYPE_MASTER_QUALTRICS = 'Master - Qualtrics';
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';
        
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
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master Qualtrics').getRecordTypeId();
        setSurvey.URL__c = 'www.testurl.com';
        insert setSurvey;
        
        
        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        setCaseType.name = 'Request_Claim_Payment';
        setCaseType.Case_Type__c = 'Request_Claim_Payment';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Claim';
        setCaseType.Qualtrics__c  = true;
        INSERT setCaseType;
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = INQUIRY;
        inquiryCreateOpen.Status = NEW_STATUS;
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.Case_Type__c = 'Request_Claim_Payment';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        inquiryCreateOpen.MOT__c = 'I Claim';
        insert inquiryCreateOpen;
        
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Qualtrics').getRecordTypeId();
        testICFParam.Interval_Completed_Month__c = '1';
        testICFParam.Entity__c = 'AMFS';
        testICFParam.Status__c = 'Active';
        insert testICFParam;
        
        ICF_Parameter__c testICFParam2 = new ICF_Parameter__c();
        testICFParam2.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam2.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId();
        testICFParam2.Interval_Completed_Month__c = '1';
        testICFParam2.Entity__c = 'AMFS';
        testICFParam2.Status__c = 'Active';
        insert testICFParam2;
        
        List<ICF_Template_and_Namespace__c> list_template = new List<ICF_Template_and_Namespace__c>();
        
        ICF_Template_and_Namespace__c setTemplate = new ICF_Template_and_Namespace__c();
        setTemplate.Survey_Type__c = 'I Claim';
        setTemplate.Template_ID__c = 'test';
        setTemplate.Namespace__c = 'test'; 
        
        ICF_Template_and_Namespace__c setTemplate1 = new ICF_Template_and_Namespace__c();
        setTemplate1.Survey_Type__c = 'I Claim AHS Reject';
        setTemplate1.Template_ID__c = 'test';
        setTemplate1.Namespace__c = 'test'; 
        
        ICF_Template_and_Namespace__c setTemplate2 = new ICF_Template_and_Namespace__c();
        setTemplate2.Survey_Type__c = 'I Claim Core Reject';
        setTemplate2.Template_ID__c = 'test';
        setTemplate2.Namespace__c = 'test'; 
        
        list_template.add(setTemplate);
        insert list_template;
        
        List<Email_SMS_Log__c> list_esl = new List<Email_SMS_Log__c>();
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.MOT__c = 'I Claim';
        esl.Claim_Status__c = 'Reject';
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = I_Claim;
        esl.Request_Date__c = todayDate;
        
        Email_SMS_Log__c esl1 = new Email_SMS_Log__c();
        esl1.Status__c = 'Draft';
        esl1.Contact__c = contact1.Id;
        esl1.case__c = inquiryCreateOpen.id;
        esl1.Account__c = contact1.AccountId;
        esl1.Entity__c = contact1.Entity__c;
        esl1.Email__c = contact1.Email;
        esl1.Mobile__c = contact1.MobilePhone;
        esl1.MOT__c = 'I Claim';
        esl1.Claim_Status__c = 'Reject';
        esl1.Send_Flag__c = true;
        esl1.Category__c = ICF;
        esl1.Type__c = 'CCC';
        esl1.Method__c = 'Email';
        esl1.Survey_Type__c = I_Claim;
        esl1.Request_Date__c = todayDate;
        
        Email_SMS_Log__c esl2 = new Email_SMS_Log__c();
        esl2.Status__c = 'Draft';
        esl2.Contact__c = contact1.Id;
        esl2.case__c = inquiryCreateOpen.id;
        esl2.Account__c = contact1.AccountId;
        esl2.Entity__c = contact1.Entity__c;
        esl2.Email__c = contact1.Email;
        esl2.Mobile__c = contact1.MobilePhone;
        esl2.MOT__c = 'I Claim';
        esl2.Claim_Status__c = 'Reject';
        esl2.Send_Flag__c = true;
        esl2.Category__c = ICF;
        esl2.Type__c = 'CCC';
        esl2.Method__c = 'Email';
        esl2.Survey_Type__c = I_Claim;
        esl2.Request_Date__c = todayDate;
        
        list_esl.add(esl);
        list_esl.add(esl1);
        list_esl.add(esl2);
        
        insert list_esl;
        
        List<ICF_Non_Real_Time__c> list_data = new List<ICF_Non_Real_Time__c>();
        
        ICF_Non_Real_Time__c data_fraud = new ICF_Non_Real_Time__c();
        data_fraud.Claim_Number__c = '12345';
        data_fraud.Claim_Type__c = 'Health';
        data_fraud.Fraud__c = 'AF';
        data_fraud.Jenis_Transaksi__c = 'CASHLESS';
        data_fraud.Nama_RS_Provider__c = 'RS. ABC';
        data_fraud.Source_System__c = 'RLS';
        data_fraud.External_ID__c = '12345-77700144';
        data_fraud.Policy_Number__c = '77700144';
        data_fraud.Email_SMS_Log__c = esl.id;
        
        ICF_Non_Real_Time__c data_fraud1 = new ICF_Non_Real_Time__c();
        data_fraud1.Claim_Number__c = '12345';
        data_fraud1.Claim_Type__c = 'Health';
        data_fraud1.Fraud__c = 'R0376';
        data_fraud1.Jenis_Transaksi__c = 'REIMBURSEMENT';
        data_fraud1.Nama_RS_Provider__c = 'RS. ABC';
        data_fraud1.Source_System__c = 'CARE';
        data_fraud1.External_ID__c = '12346-77700144';
        data_fraud1.Policy_Number__c = '77700144';
        data_fraud1.Email_SMS_Log__c = esl1.id;
        
        ICF_Non_Real_Time__c data_fraud2 = new ICF_Non_Real_Time__c();
        data_fraud2.Claim_Number__c = '12345';
        data_fraud2.Claim_Type__c = 'Health';
        data_fraud2.Fraud__c = 'AF';
        data_fraud2.Jenis_Transaksi__c = 'REIMBURSEMENT';
        data_fraud2.Nama_RS_Provider__c = 'RS. ABC';
        data_fraud2.Source_System__c = 'DMTM';
        data_fraud2.External_ID__c = '12347-77700144';
        data_fraud2.Policy_Number__c = '77700144';
        data_fraud2.Email_SMS_Log__c = esl2.id;
        
        list_data.add(data_fraud);
        list_data.add(data_fraud1);
        list_data.add(data_fraud2);
        
        insert list_data;
        
        Set<id> sendWa = new Set<id>();
        sendWa.add(esl.id);
        sendWa.add(esl1.id);
        sendWa.add(esl2.id);
        System.enqueueJob(new SendSurveyICF.sendWhatsapp(sendWa)); 
        
        Test.stopTest();
    }
    
    public static testMethod void TestClass(){
        Test.startTest();
        EIPJson.EIP_Body body = new EIPJson.EIP_Body();
        body.status = '1';
        body.transactionId = 'Test';
        
        EIPJson res = new EIPJson();
        res.Body = body;
                    
        SendSurveyICF.communication comm = new SendSurveyICF.communication();
        comm.setDataCommunication(res);
        
        Test.stopTest();
    }
    
    /*
    public static testmethod void testSendMethodThrowsException() {
        // Setup Email_SMS_Log__c
        Email_SMS_Log__c log = new Email_SMS_Log__c();
        log.Mobile__c = '08123456789';
        log.MOT__c = 'I Claim';
        log.Entity__c = 'AMFS';
        log.Claim_Status__c = 'Approve'; // agar tidak masuk ke blok reject
        //log.Contact_Name__c = 'Test Name';
        log.Bitly__c = 'http://bit.ly/test';
        //log.Nama_Layanan__c = 'Test Service';
        //log.Contact_Gender__c = 'Male';
        insert log;

        // Setup ICF_Template_and_Namespace__c dengan data yang akan menyebabkan error
        ICF_Template_and_Namespace__c template = new ICF_Template_and_Namespace__c();
        template.Survey_Type__c = 'I Claim';
        template.Namespace__c = null; // null untuk memicu error saat assignment
        template.Template_ID__c = null; // null untuk memicu error saat digunakan
        insert template;

        
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Qualtrics').getRecordTypeId();
        testICFParam.Interval_Completed_Month__c = '1';
        testICFParam.Entity__c = 'AMFS';
        testICFParam.Status__c = 'Active';
        insert testICFParam;

        Test.startTest();
        SendSurveyICF.isNotTest = true;
        SendSurveyICF.send(log.Id); 
        Test.stopTest();
    }*/

}