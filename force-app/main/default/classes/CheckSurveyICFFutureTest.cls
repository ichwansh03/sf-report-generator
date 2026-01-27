@istest
public class CheckSurveyICFFutureTest {
    
    public static testmethod void createCaseAsk() {
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
                  
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Qualtrics').getRecordTypeId();
        testICFParam.Interval_Completed_Month__c = '1';
        testICFParam.Entity__c = 'AMFS';
        testICFParam.Status__c = 'Active';
        testICFParam.Status_Cases__c = 'Closed';
        insert testICFParam;
        
        ICF_Parameter__c testICFParam2 = new ICF_Parameter__c();
        testICFParam2.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam2.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId();
        testICFParam2.Interval_Completed_Month__c = '1';
        testICFParam2.Entity__c = 'AMFS';
        testICFParam2.Status__c = 'Active';
        testICFParam2.Status_Cases__c = 'Closed';
        insert testICFParam2;
        
        
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
        contact1.Freeze_Ask_End_Date__c = system.today().addDays(1);
        insert contact1;
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master Qualtrics').getRecordTypeId();
        insert setSurvey;
        
        
        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        //setCaseType.name = 'Inquiry_CS Info Manfaat Polis';
        //setCaseType.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.name = 'Request_POS_Withdrawal';
        setCaseType.Case_Type__c = 'Request_POS_Withdrawal';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Ask';
        setCaseType.Qualtrics__c  = true;
        setCaseType.type__c  = 'Inquiry';
        
        INSERT setCaseType;
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = INQUIRY;
        inquiryCreateOpen.Status = NEW_STATUS;
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        //inquiryCreateOpen.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen.Case_Type__c = 'Request_POS_Withdrawal';
        inquiryCreateOpen.Case_Type_Config__c = 'Request_POS_Withdrawal' ;
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        inquiryCreateOpen.Description = 'Testing';
        inquiryCreateOpen.MOT__c = 'I Ask';
        insert inquiryCreateOpen;
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = I_ASK;
        esl.MOT__c = 'I Ask';
        esl.Request_Date__c = todayDate;
        esl.Outbound_Call__c = true;
        esl.Email_Text__c = 'Test [SHORT_URL] ';
        insert esl; 
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        esl.status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        
        datetime getDate = system.today();
        CheckSurveyICFFuture.convertToDateField(getDate.format('YYYYMMdd'));
        
        CheckSurveyICFFuture.updateContactFlagAgentRole(contact1);
        Test.stopTest();
    } 
    
    public static testmethod void createCaseBuy() {
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
        insert setSurvey;
        
        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        setCaseType.name = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Buy';
        setCaseType.Qualtrics__c  = true;
        INSERT setCaseType;
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = INQUIRY;
        inquiryCreateOpen.Status = NEW_STATUS;
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.MOT__c = 'I Buy';
        inquiryCreateOpen.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
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
        
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Buy'; 
        esl.MOT__c = 'I Buy';
        esl.Request_Date__c = todayDate;
        insert esl;
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        esl.status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        
        Test.stopTest();
    }
    
    public static testmethod void createCaseRenew() {
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
        setSurvey.name = 'Survey Qualtrics';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master Qualtrics').getRecordTypeId();
        insert setSurvey;
        
        
        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        setCaseType.name = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Renew';
        setCaseType.Qualtrics__c  = true;
        INSERT setCaseType;
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = INQUIRY;
        inquiryCreateOpen.Status = NEW_STATUS;
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.MOT__c = 'I Renew';
        inquiryCreateOpen.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
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
        
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Renew'; 
        esl.MOT__c = 'I Renew';
        esl.Request_Date__c = todayDate;
        insert esl;
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        esl.status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        
        Test.stopTest();
    }
    
    public static testmethod void createCaseClaimAHSCashless() {
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
        contact1.policyApp__c = 'DMTM';
        contact1.WelcomeCall_Product_Code_Plan__c = '	MKD1';
        insert contact1;
        
        Email_SMS_Template__c template = new Email_SMS_Template__c();
        template.Name = 'ICF Email (AMFS) 2024';
        template.Category__c = 'ICF';
        template.Detail_Link__c = '[SURVEY_LINK]';
        template.Email_Body__c = '[CONTACT_GENDER] [CONTACT_NAME] [CASE_NUMBER] [POLICY_NO] [MOT_SERVICE] [SURVEY_LINK]';
        template.Entity__c = 'AMFS';
        template.Subject__c = 'Survey Kepuasan Nasabah [MOT_SERVICE]';
        insert template;
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'Survey Request I Claim Individu Reimbursement';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master New Onboarding').getRecordTypeId();
        insert setSurvey;
        
        Survey__c setSurvey2 = new Survey__c();
        setSurvey2.name = 'Survey Request I Claim Individu Cashless';
        setSurvey2.Submit_Response__c = 'empty';
        setSurvey2.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master New Onboarding').getRecordTypeId();
        insert setSurvey2;
        
        
        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        setCaseType.name = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Claim';
        setCaseType.Qualtrics__c  = true;
        INSERT setCaseType;
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = request;
        inquiryCreateOpen.Status = NEW_STATUS;
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.MOT__c = 'I Claim';
        inquiryCreateOpen.Case_Type__c = 'Request_Claim_Payment';
        inquiryCreateOpen.Case_Type_Config__c = 'Request_Claim_Payment' ;
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        inquiryCreateOpen.Description = 'Cashless';
        insert inquiryCreateOpen;
        
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Qualtrics').getRecordTypeId();
        testICFParam.Interval_Completed_Month__c = '1';
        testICFParam.Entity__c = 'AMFS';
        testICFParam.Status__c = 'Active';
        testICFParam.Include_Product_Code_Plan_Claim_1__c = 'MKD1';
        insert testICFParam;
        
        ICF_Parameter__c testICFParam2 = new ICF_Parameter__c();
        testICFParam2.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam2.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId();
        testICFParam2.Interval_Completed_Month__c = '1';
        testICFParam2.Entity__c = 'AMFS';
        testICFParam2.Status__c = 'Active';
        insert testICFParam2;
        
        ICF_Claim_Approve__c app = new ICF_Claim_Approve__c();
        app.Claim_Number__c = '23456';
        app.Policy_Number__c = '77700101';
        app.Claim_Status_Code__c = 'Test';
        app.Claim_Status_Desc__c = 'Test';
        app.Nama_Rumah_Sakit__c = 'Test';
        app.Proceed_ICF__c = true;
        insert app;
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Claim'; 
        esl.MOT__c = 'I Claim';
        esl.Request_Date__c = todayDate;
        esl.Email_Text__c = 'lalala';
        insert esl;
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        esl.status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        
        Test.stopTest();
    }
    
    public static testmethod void createCaseClaimAHSReimburse() {
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
        contact1.policyApp__c = 'DMTM';
        contact1.WelcomeCall_Product_Code_Plan__c = '	MKD1';
        insert contact1;
        
        Email_SMS_Template__c template = new Email_SMS_Template__c();
        template.Name = 'ICF Email (AMFS) 2024';
        template.Category__c = 'ICF';
        template.Detail_Link__c = '[SURVEY_LINK]';
        template.Email_Body__c = '[CONTACT_GENDER] [CONTACT_NAME] [CASE_NUMBER] [POLICY_NO] [MOT_SERVICE] [SURVEY_LINK]';
        template.Entity__c = 'AMFS';
        template.Subject__c = 'Survey Kepuasan Nasabah [MOT_SERVICE]';
        insert template;
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'Survey Request I Claim Individu Reimbursement';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master New Onboarding').getRecordTypeId();
        insert setSurvey;
        
        Survey__c setSurvey2 = new Survey__c();
        setSurvey2.name = 'Survey Request I Claim Individu Cashless';
        setSurvey2.Submit_Response__c = 'empty';
        setSurvey2.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master New Onboarding').getRecordTypeId();
        insert setSurvey2;
        
        
        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        setCaseType.name = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Claim';
        setCaseType.Qualtrics__c  = true;
        INSERT setCaseType;
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = request;
        inquiryCreateOpen.Status = NEW_STATUS;
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.MOT__c = 'I Claim';
        inquiryCreateOpen.Case_Type__c = 'Request_Claim_Payment';
        inquiryCreateOpen.Case_Type_Config__c = 'Request_Claim_Payment' ;
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        inquiryCreateOpen.Description = 'Reimburse';
        insert inquiryCreateOpen;
        
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Qualtrics').getRecordTypeId();
        testICFParam.Interval_Completed_Month__c = '1';
        testICFParam.Entity__c = 'AMFS';
        testICFParam.Status__c = 'Active';
        testICFParam.Include_Product_Code_Plan_Claim_1__c = 'MKD1';
        insert testICFParam;
        
        ICF_Parameter__c testICFParam2 = new ICF_Parameter__c();
        testICFParam2.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam2.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId();
        testICFParam2.Interval_Completed_Month__c = '1';
        testICFParam2.Entity__c = 'AMFS';
        testICFParam2.Status__c = 'Active';
        insert testICFParam2;
        
        ICF_Claim_Approve__c app = new ICF_Claim_Approve__c();
        app.Claim_Number__c = '23456';
        app.Policy_Number__c = '77700101';
        app.Claim_Status_Code__c = 'Test';
        app.Claim_Status_Desc__c = 'Test';
        app.Nama_Rumah_Sakit__c = 'Test';
        insert app;
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Claim'; 
        esl.MOT__c = 'I Claim';
        esl.Request_Date__c = todayDate;
        esl.Email_Text__c = 'lalala';
        insert esl;
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        esl.status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        
        Test.stopTest();
    }
    
    public static testmethod void createCaseComplaint() {
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
        setSurvey.name = 'Survey Request I Complaint Dynamic';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master New Onboarding').getRecordTypeId();
        insert setSurvey;
        
        
        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        setCaseType.name = 'Complaint';
        setCaseType.Case_Type__c = 'Complaint';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Complaint';
        setCaseType.Qualtrics__c  = true;
        INSERT setCaseType;
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = INQUIRY;
        inquiryCreateOpen.Status = NEW_STATUS;
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.MOT__c = 'I Complaint';
        inquiryCreateOpen.Case_Type__c = 'Complaint';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
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
        
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Complaint'; 
        esl.MOT__c = 'I Complaint';
        esl.Request_Date__c = todayDate;
        insert esl;
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        esl.status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        
        Test.stopTest();
    }
    
    public static testmethod void createCaseAsk2() {
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
        
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Qualtrics').getRecordTypeId();
        testICFParam.Interval_Completed_Month__c = '1';
        testICFParam.Entity__c = 'AMFS';
        testICFParam.Status__c = 'Active';
        testICFParam.Status_Cases__c = 'Closed';
        insert testICFParam;
        
        ICF_Parameter__c testICFParam2 = new ICF_Parameter__c();
        testICFParam2.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam2.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId();
        testICFParam2.Interval_Completed_Month__c = '1';
        testICFParam2.Entity__c = 'AMFS';
        testICFParam2.Status__c = 'Active';
        testICFParam2.Status_Cases__c = 'Closed';
        insert testICFParam2;
        
        
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
        contact1.Policy_No__c = '77700101';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        contact1.Freeze_Ask_End_Date__c = system.today().addDays(1);
        insert contact1;
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master Qualtrics').getRecordTypeId();
        insert setSurvey;
        
        
        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        setCaseType.name = 'Inquiry';
        setCaseType.Case_Type__c = 'Inquiry';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Ask';
        setCaseType.Qualtrics__c  = true;
        setCaseType.type__c  = 'Inquiry';
        INSERT setCaseType;
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = INQUIRY;
        inquiryCreateOpen.Status = NEW_STATUS;
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.Case_Type__c = 'Inquiry';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.Entity_Backup__c = 'AMFS';
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        inquiryCreateOpen.MOT__c = 'I Ask';
        insert inquiryCreateOpen;
        
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = I_ASK;
        esl.MOT__c = 'I Ask';
        esl.Request_Date__c = todayDate;
        esl.Outbound_Call__c = true;
        insert esl;
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        
        List<String> emailId = new List<String>();
        emailId.add(esl.id);
        CheckSurveyICFFuture.sendSurveyViaWhatsappFlow(emailId);
        
        esl.status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        Test.stopTest();
    }
    
    public static testmethod void createCaseClaimDMTM() {
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
        
        Email_SMS_Template__c template = new Email_SMS_Template__c();
        template.Name = 'ICF Email (AMFS) 2024';
        template.Category__c = 'ICF';
        template.Detail_Link__c = '[SURVEY_LINK]';
        template.Email_Body__c = '[CONTACT_GENDER] [CONTACT_NAME] [CASE_NUMBER] [POLICY_NO] [MOT_SERVICE] [SURVEY_LINK]';
        template.Entity__c = 'AMFS';
        template.Subject__c = 'Survey Kepuasan Nasabah [MOT_SERVICE]';
        insert template;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com'; 
        contact1.Policy_No__c = '77700101';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        contact1.policyApp__c = 'DMTM';
        insert contact1;
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'Survey Request I Claim Individu Reimbursement';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master New Onboarding').getRecordTypeId();
        insert setSurvey;
        
        Survey__c setSurvey2 = new Survey__c();
        setSurvey2.name = 'Survey Request I Claim Individu Cashless';
        setSurvey2.Submit_Response__c = 'empty';
        setSurvey2.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master New Onboarding').getRecordTypeId();
        insert setSurvey2;
        
        
        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        setCaseType.name = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Ask';
        setCaseType.Qualtrics__c  = true;
        INSERT setCaseType;
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = 'Request';
        inquiryCreateOpen.Status = 'Closed';
        inquiryCreateOpen.MOT__c = 'I Claim';
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Entity_Backup__c = 'AMFS';
        inquiryCreateOpen.Case_Type__c = 'Request_Claim_Payment';
        inquiryCreateOpen.Case_Type_Config__c = 'Request_Claim_Payment' ;
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        inquiryCreateOpen.Description = 'Testing';
        insert inquiryCreateOpen;
        
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Qualtrics').getRecordTypeId();
        testICFParam.Interval_Completed_Month__c = '1';
        testICFParam.Entity__c = 'AMFS';
        testICFParam.Status__c = 'Active';
        testICFParam.Status_Cases__c = 'Closed';
        insert testICFParam;
        
        ICF_Parameter__c testICFParam2 = new ICF_Parameter__c();
        testICFParam2.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam2.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId();
        testICFParam2.Interval_Completed_Month__c = '1';
        testICFParam2.Entity__c = 'AMFS';
        testICFParam2.Status__c = 'Active';
        testICFParam2.Status_Cases__c = 'Closed';
        insert testICFParam2;
        
        ICF_Claim_Approve__c ca = new ICF_Claim_Approve__c();
        ca.Claim_Number__c = '23456';
        ca.Claim_Status_Code__c = 'Testing';
        ca.Claim_Status_Desc__c = 'Health';
        ca.Nama_Rumah_Sakit__c = 'testing';
        ca.Policy_Number__c = '77700101';
        ca.Proceed_ICF__c = true;
        insert ca;
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = I_ASK;
        esl.MOT__c = 'I Claim';
        esl.Request_Date__c = todayDate;
        esl.Email_Text__c = '<table width="100%"> <tr> <td colspan="2"><img src="https://c.ap4.content.force.com/servlet/servlet.ImageServer?id=0156F00000HhS59&oid=00D90000000zAlz&lastMod=1556081666000" width="250" align="right" /></td> </tr> <tr> <td> <table width="100%"> <tr> <td colspan="3"> <b>Yth. Ibu LASINEM , </b><br/> Terima kasih telah mempercayakan perlindungan Anda & keluarga kepada AXA Mandiri. <br/> Untuk meningkatkan kualitas pelayanan kami, mohon berikan penilaian Anda kepada kami dengan mengisi survei singkat ini. <br/> Berikut informasi interaksi Anda [SHORT_URL] / <i>Your case information </i> :<br/> </td> </tr> <tr> <td width="10%">Nomor / <i>Case no</i></td> <td width="1%">:</td> <td><i><b> 05417543 </b> </i></td> </tr> <tr> <td>Nomor Polis / <i>Policy no </i></td> <td>:</td> <td><i><b> 514-5863659 </b> </i></td> </tr> <tr> <td>Transaksi/ <i>Transaction</i></td> <td>:</td> <td><i><b> Pembayaran Claim </b> </i></td> </tr> <tr> <td colspan="3"><br/> Klik link berikut : <a href=" https://axaid-ccc--fullsb.sandbox.my.salesforce-sites.com/survey/TakeSurvey?id=a0PF800000Aqna2MAB&cId=0039000001XlvbkAAB&caId=500F800000AROtdIAH "><b>Link Survei</b> </a><br/><br/> <b>PT AXA Mandiri Financial Services</b><br/><br/> <img src="https://c.ap4.content.force.com/servlet/servlet.ImageServer?id=0156F00000HhS59&oid=00D90000000zAlz&lastMod=1556081666000" width="250" style="margin: 0 0 0 0"/> </td> </tr> </table> <br/> <tr> <td colspan="2"><b>INFO : </b><br/> Apabila Anda membutuhkan informasi lebih lanjut, kami siap membantu Anda di layanan <b>Customer Care Centre</b> atau <b>Layanan Live Chat</b> <a href="www.axa-mandiri.co.id">www.axa-mandiri.co.id</a> atau Anda dapat mengirimkan email ke <a href="mailto:customer@axa-mandiri.co.id">customer@axa-mandiri.co.id</a> <br/> <i>For more info, please contact <b>Customer Care Centre</b> or <b>Live Chat Service</b> <a href="www.axa-mandiri.co.id">www.axa-mandiri.co.id</a> or email to <a href="mailto:customer@axa-mandiri.co.id">customer@axa-mandiri.co.id</a></i> </td> </tr></table>';
        insert esl;
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        esl.status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        Test.stopTest();
    }
    
    public static testmethod void createCaseClaimRLS() {
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
        contact1.policyApp__c = 'RLS';
        insert contact1;
        
        Email_SMS_Template__c template = new Email_SMS_Template__c();
        template.Name = 'ICF Email (AMFS) 2024';
        template.Category__c = 'ICF';
        template.Detail_Link__c = '[SURVEY_LINK]';
        template.Email_Body__c = '[CONTACT_GENDER] [CONTACT_NAME] [CASE_NUMBER] [POLICY_NO] [MOT_SERVICE] [SURVEY_LINK]';
        template.Entity__c = 'AMFS';
        template.Subject__c = 'Survey Kepuasan Nasabah [MOT_SERVICE]';
        insert template;
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'Survey Request I Claim Individu Reimbursement';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master New Onboarding').getRecordTypeId();
        insert setSurvey;
        
        Survey__c setSurvey2 = new Survey__c();
        setSurvey2.name = 'Survey Request I Claim Individu Cashless';
        setSurvey2.Submit_Response__c = 'empty';
        setSurvey2.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master New Onboarding').getRecordTypeId();
        insert setSurvey2;
        
        
        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        setCaseType.name = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Claim';
        setCaseType.Qualtrics__c  = true;
        INSERT setCaseType;
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = request;
        inquiryCreateOpen.Status = NEW_STATUS;
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.MOT__c = 'I Claim';
        inquiryCreateOpen.Case_Type__c = 'Request_Claim_Payment';
        inquiryCreateOpen.Case_Type_Config__c = 'Request_Claim_Payment' ;
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        inquiryCreateOpen.Description = 'Testing';
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
        
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Claim'; 
        esl.MOT__c = 'I Claim';
        esl.MOT__c = 'I Claim';
        esl.Request_Date__c = todayDate;
        insert esl;
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        esl.status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        
        Test.stopTest();
    }
    
    public static testmethod void createCaseFreeze() {
        Test.startTest();
        String ICF = 'ICF';
        String I_ASK = 'I Ask';
        Date todayDate = Date.today();
        String INQUIRY = 'Inquiry';
        String NEW_STATUS = 'New';
        String RECORD_TYPE_MASTER_QUALTRICS = 'Master - Qualtrics';
        
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Qualtrics').getRecordTypeId();
        testICFParam.Interval_Completed_Month__c = '1';
        testICFParam.Entity__c = 'AMFS';
        testICFParam.Status__c = 'Active';
        testICFParam.Status_Cases__c = 'Closed';
        insert testICFParam;
        
        ICF_Parameter__c testICFParam2 = new ICF_Parameter__c();
        testICFParam2.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam2.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId();
        testICFParam2.Interval_Completed_Month__c = '1';
        testICFParam2.Entity__c = 'AMFS';
        testICFParam2.Status__c = 'Active';
        testICFParam2.Status_Cases__c = 'Closed';
        insert testICFParam2;
        
        
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
        contact1.Policy_No__c = '77700101';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        contact1.Freeze_Ask_End_Date__c = system.today().addDays(-1);
        contact1.Freeze_Renew_End_Date__c = system.today().addDays(-1);
        contact1.Freeze_Complaint_End_Date__c = system.today().addDays(-1);
        contact1.Freeze_Buy_End_Date__c = system.today().addDays(-1);
        insert contact1;
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master Qualtrics').getRecordTypeId();
        insert setSurvey;
        
        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        setCaseType.name = 'Inquiry';
        setCaseType.Case_Type__c = 'Inquiry';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Ask';
        setCaseType.Qualtrics__c  = true;
        setCaseType.type__c  = 'Inquiry';
        INSERT setCaseType;
        
        List<Case> list_case = new List<Case>();
        
        Case freezeCase = new Case();
        freezeCase.ContactId = contact1.Id;
        freezeCase.Type = INQUIRY;
        freezeCase.Status = NEW_STATUS;
        freezeCase.Priority = 'Medium';
        freezeCase.Origin = 'Email';
        freezeCase.Case_Type__c = 'Inquiry';
        freezeCase.Subject = 'Case Subject 123456';
        freezeCase.AccountId = contact1.AccountId;
        freezeCase.Entity_Backup__c = 'AMFS';
        freezeCase.PIC_Department_LU__c = userObj.Id;
        freezeCase.MOT__c = 'I Ask';
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = INQUIRY;
        inquiryCreateOpen.Status = NEW_STATUS;
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.Case_Type__c = 'Inquiry';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.Entity_Backup__c = 'AMFS';
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        inquiryCreateOpen.MOT__c = 'I Ask';
        
        Case complaintCreateOpen = new Case();
        complaintCreateOpen.ContactId = contact1.Id;
        complaintCreateOpen.Type = INQUIRY;
        complaintCreateOpen.Status = NEW_STATUS;
        complaintCreateOpen.Priority = 'Medium';
        complaintCreateOpen.Origin = 'Email';
        complaintCreateOpen.Case_Type__c = 'Inquiry';
        complaintCreateOpen.Subject = 'Case Subject 23456';
        complaintCreateOpen.AccountId = contact1.AccountId;
        complaintCreateOpen.Entity_Backup__c = 'AMFS';
        complaintCreateOpen.PIC_Department_LU__c = userObj.Id;
        complaintCreateOpen.MOT__c = 'I Complain';
        
        list_case.add(freezeCase);
        list_case.add(inquiryCreateOpen);
        list_case.add(complaintCreateOpen);
        insert list_case;
        
        List<Email_SMS_Log__c> list_esl = new List<Email_SMS_Log__c> ();
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = freezeCase.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = I_ASK;
        esl.MOT__c = 'I Ask';
        esl.Request_Date__c = todayDate;
        esl.Outbound_Call__c = false;
        
        Email_SMS_Log__c esl1 = new Email_SMS_Log__c();
        esl1.Status__c = 'Draft';
        esl1.Contact__c = contact1.Id;
        esl1.case__c = inquiryCreateOpen.id;
        esl1.Account__c = contact1.AccountId;
        esl1.Entity__c = contact1.Entity__c;
        esl1.Email__c = contact1.Email;
        esl1.Mobile__c = contact1.MobilePhone;
        esl1.Send_Flag__c = true;
        esl1.Category__c = ICF;
        esl1.Type__c = 'CCC';
        esl1.Method__c = 'Email';
        esl1.Survey_Type__c = I_ASK;
        esl1.MOT__c = 'I Ask';
        esl1.Request_Date__c = todayDate;
        esl1.Outbound_Call__c = true;
        
        Email_SMS_Log__c esl_complain = new Email_SMS_Log__c();
        esl_complain.Status__c = 'Draft';
        esl_complain.Contact__c = contact1.Id;
        esl_complain.case__c = complaintCreateOpen.id;
        esl_complain.Account__c = contact1.AccountId;
        esl_complain.Entity__c = contact1.Entity__c;
        esl_complain.Email__c = contact1.Email;
        esl_complain.Mobile__c = contact1.MobilePhone;
        esl_complain.Send_Flag__c = true;
        esl_complain.Category__c = ICF;
        esl_complain.Type__c = 'CCC';
        esl_complain.Method__c = 'Email';
        esl_complain.Survey_Type__c = I_ASK;
        esl_complain.MOT__c = 'I Complain';
        esl_complain.Request_Date__c = todayDate;
        
        Email_SMS_Log__c esl_buy = new Email_SMS_Log__c();
        esl_buy.Status__c = 'Draft';
        esl_buy.Contact__c = contact1.Id;
        esl_buy.case__c = complaintCreateOpen.id;
        esl_buy.Account__c = contact1.AccountId;
        esl_buy.Entity__c = contact1.Entity__c;
        esl_buy.Email__c = contact1.Email;
        esl_buy.Mobile__c = contact1.MobilePhone;
        esl_buy.Send_Flag__c = true;
        esl_buy.Category__c = ICF;
        esl_buy.Type__c = 'CCC';
        esl_buy.Method__c = 'Email';
        esl_buy.Survey_Type__c = I_ASK;
        esl_buy.MOT__c = 'I Buy';
        esl_buy.Request_Date__c = todayDate;
        
        Email_SMS_Log__c esl_renew = new Email_SMS_Log__c();
        esl_renew.Status__c = 'Draft';
        esl_renew.Contact__c = contact1.Id;
        esl_renew.case__c = complaintCreateOpen.id;
        esl_renew.Account__c = contact1.AccountId;
        esl_renew.Entity__c = contact1.Entity__c;
        esl_renew.Email__c = contact1.Email;
        esl_renew.Mobile__c = contact1.MobilePhone;
        esl_renew.Send_Flag__c = true;
        esl_renew.Category__c = ICF;
        esl_renew.Type__c = 'CCC';
        esl_renew.Method__c = 'Email';
        esl_renew.Survey_Type__c = I_ASK;
        esl_renew.MOT__c = 'I Renew';
        esl_renew.Request_Date__c = todayDate;

        
        list_esl.add(esl);
        list_esl.add(esl1);
        list_esl.add(esl_complain);
        list_esl.add(esl_buy);
        list_esl.add(esl_renew);
        insert list_esl;
        
        contact1.Email_Sms_Log_Ask__c = esl.id;
        contact1.Email_Sms_Log_complaint__c = esl.id;
        contact1.Email_Sms_Log_Renew__c = esl.id;
        contact1.Email_Sms_Log_Buy__c = esl.id;
        update contact1;
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl1.id); 
        emailIds.add(esl_complain.id); 
        emailIds.add(esl_buy.id); 
        emailIds.add(esl_renew.id); 
        
        CheckSurveyICFFuture.checkSurveyICF(emailIds);

        Test.stopTest();
    }
}