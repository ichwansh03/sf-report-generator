@isTest
public class CreateEmailCCC_Test {
    public static testmethod void CreateEmailCCCTest() {
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
        String REQUEST_POS = 'Request POS';
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
        setSurvey.name = 'Survey Request I Claim Individu Cashless';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master New Onboarding').getRecordTypeId();
        setSurvey.URL__c = 'https://axaid-ccc--fullsb.sandbox.my.salesforce-sites.com/survey/TakeSurveyDynamic?';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Status__c = 'Active';
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
        inquiryCreateOpen.PIC_Department_LU__c = UserInfo.getUserId();
        insert inquiryCreateOpen;
        
        Case requestPOSCreateOpen = new Case();
        requestPOSCreateOpen.ContactId = contact1.Id;
        requestPOSCreateOpen.Type = REQUEST_POS;
        requestPOSCreateOpen.Status = NEW_STATUS;
        requestPOSCreateOpen.Priority = 'Medium';
        requestPOSCreateOpen.Origin = 'Email';
        requestPOSCreateOpen.Case_Type__c = 'Request_POS_Withdrawal';
        requestPOSCreateOpen.Subject = 'Case Subject 23456';
        requestPOSCreateOpen.AccountId = contact1.AccountId;
        requestPOSCreateOpen.PIC_Department_LU__c = UserInfo.getUserId();
        insert requestPOSCreateOpen;
                
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Qualtrics' LIMIT 1];
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = rt.Id;
        insert testICFParam;
        
        Email_SMS_Template__c template = new Email_SMS_Template__c();
        template.Name = 'ICF Email (AMFS) 2024';
        template.Category__c = 'ICF';
        template.Detail_Link__c = '[SURVEY_LINK]';
        template.Email_Body__c = '[CONTACT_GENDER] [CONTACT_NAME] [CASE_NUMBER] [POLICY_NO] [MOT_SERVICE] [SURVEY_LINK]';
        template.Entity__c = 'AMFS';
        template.Subject__c = 'Survey Kepuasan Nasabah [MOT_SERVICE]';
        insert template;
        
        ICF_Parameter__c ICFParam = new ICF_Parameter__c();
        ICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        ICFParam.RecordTypeId = rt.Id;
        ICFParam.Entity__c ='AMFS';
        ICFParam.Status__c ='Active';
        ICFParam.Status_Cases__c ='Closed';
        //ICFParam.ICF_Email_Template__c = template.Id;
        //ICFParam.ICF_SMS_Template__c = template.Id;
        insert ICFParam;
        
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
        esl.Request_Date__c = todayDate;
        insert esl;
        
        Email_SMS_Log__c esl2 = new Email_SMS_Log__c();
        esl2.Status__c = 'Draft';
        esl2.Contact__c = contact1.Id;
        esl2.case__c = inquiryCreateOpen.id;
        esl2.Account__c = contact1.AccountId;
        esl2.Entity__c = contact1.Entity__c;
        esl2.Email__c = contact1.Email;
        esl2.Mobile__c = contact1.MobilePhone;
        esl2.Send_Flag__c = true;
        esl2.Category__c = ICF;
        esl2.Type__c = 'CCC';
        esl2.Method__c = 'Email';
        esl2.Survey_Type__c = I_ASK;
        esl2.Request_Date__c = todayDate;
        esl2.Mot__c = 'I Complain';
        insert esl2;
        
        Email_SMS_Log__c esl3 = new Email_SMS_Log__c();
        esl3.Status__c = 'Draft';
        esl3.Contact__c = contact1.Id;
        esl3.case__c = requestPOSCreateOpen.id;
        esl3.Account__c = contact1.AccountId;
        esl3.Entity__c = contact1.Entity__c;
        esl3.Email__c = contact1.Email;
        esl3.Mobile__c = contact1.MobilePhone;
        esl3.Send_Flag__c = true;
        esl3.Category__c = ICF;
        esl3.Type__c = 'CCC';
        esl3.Method__c = 'Email';
        esl3.Survey_Type__c = I_ASK;
        esl3.Request_Date__c = todayDate;
        esl3.Mot__c = 'I Ask';
        insert esl3;
        
        Email_SMS_Log__c esl4 = new Email_SMS_Log__c();
        esl4.Status__c = 'Draft';
        esl4.Contact__c = contact1.Id;
        esl4.Account__c = contact1.AccountId;
        esl4.Entity__c = contact1.Entity__c;
        esl4.Email__c = contact1.Email;
        esl4.Mobile__c = contact1.MobilePhone;
        esl4.Send_Flag__c = true;
        esl4.Category__c = ICF;
        esl4.Type__c = 'CCC';
        esl4.Method__c = 'Whatsapp';
        esl4.Survey_Type__c = I_ASK;
        esl4.Request_Date__c = todayDate;
        esl4.Mot__c = 'I Claim';
        esl4.Claim_Status__c = 'Reject';
        esl4.Survey__c = setSurvey.Id;
        esl4.Email_SMS_Template__c = template.Id;
        esl.Email_Text__c = 'test';
        insert esl4;
               
        
        Test.stopTest();
    }
    
    public static testmethod void CreateEmailCCCTest2() {
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
        String REQUEST_POS = 'Request POS';
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
        setCaseType.MOT__c = 'I Ask';
        setCaseType.Qualtrics__c  = true;
        INSERT setCaseType;
        
        Case claimRejectCase = new Case();
        claimRejectCase.ContactId = contact1.Id;
        claimRejectCase.Type = 'Request';
        claimRejectCase.Status = NEW_STATUS;
        claimRejectCase.Priority = 'Medium';
        claimRejectCase.Origin = 'Email';
        claimRejectCase.Case_Type_Config__c = 'Agency Related';
        claimRejectCase.Case_Type__c = 'Agency Related';
        claimRejectCase.Subject = 'Case Subject 234567';
        claimRejectCase.AccountId = contact1.AccountId;
        claimRejectCase.PIC_Department_LU__c = UserInfo.getUserId();
        insert claimRejectCase;
        
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Qualtrics' LIMIT 1];
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = rt.Id;
        insert testICFParam;
        
        Email_SMS_Template__c template = new Email_SMS_Template__c();
        template.Name = 'ICF Email (AMFS) 2024';
        template.Category__c = 'ICF';
        template.Detail_Link__c = '[SURVEY_LINK]';
        template.Email_Body__c = '[CONTACT_GENDER] [CONTACT_NAME] [CASE_NUMBER] [POLICY_NO] [MOT_SERVICE] [SURVEY_LINK]';
        template.Entity__c = 'AMFS';
        template.Subject__c = 'Survey Kepuasan Nasabah [MOT_SERVICE]';
        insert template;
        
        ICF_Parameter__c ICFParam = new ICF_Parameter__c();
        ICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        ICFParam.RecordTypeId = rt.Id;
        ICFParam.Entity__c ='AMFS';
        ICFParam.Status__c ='Active';
        ICFParam.Status_Cases__c ='Closed';
        //ICFParam.ICF_Email_Template__c = template.Id;
        //ICFParam.ICF_SMS_Template__c = template.Id;
        insert ICFParam;
        
        Email_SMS_Log__c esl5 = new Email_SMS_Log__c();
        esl5.Status__c = 'Draft';
        esl5.Contact__c = contact1.Id;
        esl5.case__c = claimRejectCase.id;
        esl5.Account__c = contact1.AccountId;
        esl5.Entity__c = contact1.Entity__c;
        esl5.Email__c = contact1.Email;
        esl5.Mobile__c = contact1.MobilePhone;
        esl5.Send_Flag__c = true;
        esl5.Category__c = ICF;
        esl5.Type__c = 'CCC';
        esl5.Method__c = 'Email';
        esl5.Survey_Type__c = I_ASK;
        esl5.Request_Date__c = todayDate;
        insert esl5;
        
        
        Test.stopTest();
    }
    
    public static testmethod void CreateEmailCCCTest3() {
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
        String REQUEST_POS = 'Request POS';
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
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master Qualtrics').getRecordTypeId();
        setSurvey.name = 'Survey Request I Claim Individu Cashless';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master New Onboarding').getRecordTypeId();
        setSurvey.URL__c = 'https://axaid-ccc--fullsb.sandbox.my.salesforce-sites.com/survey/TakeSurveyDynamic?';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Status__c = 'Active';
        insert setSurvey;
        
        
        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        setCaseType.name = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Ask';
        setCaseType.Qualtrics__c  = true;
        INSERT setCaseType;
        
        Case claimRejectCase = new Case();
        claimRejectCase.ContactId = contact1.Id;
        claimRejectCase.Type = 'Request';
        claimRejectCase.Status = NEW_STATUS;
        claimRejectCase.Priority = 'Medium';
        claimRejectCase.Origin = 'Email';
        claimRejectCase.Case_Type_Config__c = 'Request_Claim_Payment';
        claimRejectCase.Case_Type__c = 'Request_Claim_Payment';
        claimRejectCase.Subject = 'Case Subject 234567';
        claimRejectCase.AccountId = contact1.AccountId;
        claimRejectCase.PIC_Department_LU__c = UserInfo.getUserId();
        insert claimRejectCase;
        
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Qualtrics' LIMIT 1];
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = rt.Id;
        insert testICFParam;
        
        Email_SMS_Template__c template = new Email_SMS_Template__c();
        template.Name = 'ICF Email (AMFS) 2024';
        template.Category__c = 'ICF';
        template.Detail_Link__c = '[SURVEY_LINK]';
        template.Email_Body__c = '[CONTACT_GENDER] [CONTACT_NAME] [CASE_NUMBER] [POLICY_NO] [MOT_SERVICE] [SURVEY_LINK]';
        template.Entity__c = 'AMFS';
        template.Subject__c = 'Survey Kepuasan Nasabah [MOT_SERVICE]';
        insert template;
        
        ICF_Parameter__c ICFParam = new ICF_Parameter__c();
        ICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        ICFParam.RecordTypeId = rt.Id;
        ICFParam.Entity__c ='AMFS';
        ICFParam.Status__c ='Active';
        ICFParam.Status_Cases__c ='Closed';
        //ICFParam.ICF_Email_Template__c = template.Id;
        //ICFParam.ICF_SMS_Template__c = template.Id;
        insert ICFParam;
        
        Email_SMS_Log__c esl5 = new Email_SMS_Log__c();
        esl5.Status__c = 'Draft';
        esl5.Contact__c = contact1.Id;
        esl5.case__c = claimRejectCase.id;
        esl5.Account__c = contact1.AccountId;
        esl5.Entity__c = contact1.Entity__c;
        esl5.Email__c = contact1.Email;
        esl5.Mobile__c = contact1.MobilePhone;
        esl5.Send_Flag__c = true;
        esl5.Category__c = ICF;
        esl5.Type__c = 'CCC';
        esl5.Method__c = 'Email';
        esl5.Survey_Type__c = I_ASK;
        esl5.Request_Date__c = todayDate;
        esl5.Transaction_Type__c = 'Cashless';
        esl5.MOT__c = 'I Ask';
        insert esl5;
        
        
        Test.stopTest();
    }
}