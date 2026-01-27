@isTest
public class CreateEmailSMSLogClaimReject_Test {
    static testMethod void TestClass(){
        String entity = 'AMFS';
        Date YESTERDAYS = Date.today().addDays(-1);
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest20';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Adi';
        contact1.LastName = 'Wijaya';
        contact1.Email = 'adiwijaya@email.com';
        contact1.Policy_No__c = '77700144';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        contact1.WelcomeCall_Issued_Date__c = YESTERDAYS;
        insert contact1;
        
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
        
        ICF_Non_Real_Time__c data_fraud1 = new ICF_Non_Real_Time__c();
        data_fraud1.Claim_Number__c = '12345';
        data_fraud1.Claim_Type__c = 'Health';
        data_fraud1.Fraud__c = 'R0376';
        data_fraud1.Jenis_Transaksi__c = 'CASHLESS';
        data_fraud1.Nama_RS_Provider__c = 'RS. ABC';
        data_fraud1.Source_System__c = 'CARE';
        data_fraud1.External_ID__c = '12346-77700144';
        data_fraud1.Policy_Number__c = '77700144';
        
        ICF_Non_Real_Time__c data_fraud2 = new ICF_Non_Real_Time__c();
        data_fraud2.Claim_Number__c = '12345';
        data_fraud2.Claim_Type__c = 'Health';
        data_fraud2.Fraud__c = 'AF';
        data_fraud2.Jenis_Transaksi__c = 'CASHLESS';
        data_fraud2.Nama_RS_Provider__c = 'RS. ABC';
        data_fraud2.Source_System__c = 'DMTM';
        data_fraud2.External_ID__c = '12347-77700144';
        data_fraud2.Policy_Number__c = '77700144';
        
        ICF_Non_Real_Time__c data_c = new ICF_Non_Real_Time__c();
        data_c.Claim_Number__c = '12345';
        data_c.Claim_Type__c = 'Health';
        data_c.Fraud__c = '';
        data_c.Jenis_Transaksi__c = 'CASHLESS';
        data_c.Nama_RS_Provider__c = 'RS. ABC';
        data_c.Source_System__c = 'RLS';
        data_c.External_ID__c = '12348-77700144';
        data_c.Policy_Number__c = '77700144';
        
        ICF_Non_Real_Time__c data_c1 = new ICF_Non_Real_Time__c();
        data_c1.Claim_Number__c = '12345';
        data_c1.Claim_Type__c = 'Health';
        data_c1.Fraud__c = '';
        data_c1.Jenis_Transaksi__c = 'CASHLESS';
        data_c1.Nama_RS_Provider__c = 'RS. ABC';
        data_c1.Source_System__c = 'CARE';
        data_c1.External_ID__c = '12349-77700144';
        data_c1.Policy_Number__c = '77700144';
        
        ICF_Non_Real_Time__c data_c2 = new ICF_Non_Real_Time__c();
        data_c2.Claim_Number__c = '12345';
        data_c2.Claim_Type__c = 'Health';
        data_c2.Fraud__c = '';
        data_c2.Jenis_Transaksi__c = 'CASHLESS';
        data_c2.Nama_RS_Provider__c = 'RS. ABC';
        data_c2.Source_System__c = 'DMTM';
        data_c2.External_ID__c = '12351-77700144';
        data_c2.Policy_Number__c = '77700144';
        
        ICF_Non_Real_Time__c data_r = new ICF_Non_Real_Time__c();
        data_r.Claim_Number__c = '12345';
        data_r.Claim_Type__c = 'Health';
        data_r.Fraud__c = '';
        data_r.Jenis_Transaksi__c = 'Reimbursement';
        data_r.Nama_RS_Provider__c = 'RS. ABC';
        data_r.Source_System__c = 'RLS';
        data_r.External_ID__c = '12348-77700145';
        data_r.Policy_Number__c = '77700144';
        
        ICF_Non_Real_Time__c data_r1 = new ICF_Non_Real_Time__c();
        data_r1.Claim_Number__c = '12345';
        data_r1.Claim_Type__c = 'Health';
        data_r1.Fraud__c = '';
        data_r1.Jenis_Transaksi__c = 'Reimbursement';
        data_r1.Nama_RS_Provider__c = 'RS. ABC';
        data_r1.Source_System__c = 'CARE';
        data_r1.External_ID__c = '12349-77700145';
        data_r1.Policy_Number__c = '77700144';
        
        ICF_Non_Real_Time__c data_r2 = new ICF_Non_Real_Time__c();
        data_r2.Claim_Number__c = '12345';
        data_r2.Claim_Type__c = 'Health';
        data_r2.Fraud__c = '';
        data_r2.Jenis_Transaksi__c = 'Reimbursement';
        data_r2.Nama_RS_Provider__c = 'RS. ABC';
        data_r2.Source_System__c = 'DMTM';
        data_r2.External_ID__c = '12351-77700145';
        data_r2.Policy_Number__c = '77700144';
        
        list_data.add(data_fraud);
        list_data.add(data_fraud1);
        list_data.add(data_fraud2);
        list_data.add(data_c);
        list_data.add(data_c1);
        list_data.add(data_c2);
        list_data.add(data_r);
        list_data.add(data_r1);
        list_data.add(data_r2);
        insert list_data;
        
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Qualtrics').getRecordTypeId();
        testICFParam.Interval_Completed_Month__c = '1';
        testICFParam.Entity__c = 'AMFS';
        testICFParam.Status__c = 'Active';
        testICFParam.Status_Cases__c = 'Closed';
        //insert testICFParam;
        
        List<Survey__c> List_survey = new List<Survey__c>();
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'Survey Request I Claim Individu Cashless';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master New Onboarding').getRecordTypeId();
        setSurvey.URL__c = 'https://axaid-ccc--fullsb.sandbox.my.salesforce-sites.com/survey/TakeSurveyDynamic?';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Status__c = 'Active';
        
        Survey__c setSurvey2 = new Survey__c();
        setSurvey2.name = 'Survey Request I Claim Individu Reimbursement';
        setSurvey2.Submit_Response__c = 'empty';
        setSurvey2.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master New Onboarding').getRecordTypeId();
        setSurvey2.URL__c = 'https://axaid-ccc--fullsb.sandbox.my.salesforce-sites.com/survey/TakeSurveyDynamic?';
        setSurvey2.Entity__c = 'AMFS';
        setSurvey2.Status__c = 'Active';
        
        List_survey.add(setSurvey);
        List_survey.add(setSurvey2);
        insert List_survey;
        
        List<Email_SMS_Template__c> List_esl = new List<Email_SMS_Template__c> ();
        Email_SMS_Template__c template = new Email_SMS_Template__c();
        template.Name = 'ICF Email (AMFS) 2024';
        template.Category__c = 'ICF';
        template.Detail_Link__c = '[SURVEY_LINK]';
        template.Email_Body__c = '[CONTACT_GENDER] [CONTACT_NAME] [CASE_NUMBER] [POLICY_NO] [MOT_SERVICE] [SURVEY_LINK]';
        template.Entity__c = 'AMFS';
        template.Subject__c = 'Survey Kepuasan Nasabah [MOT_SERVICE]';
        
        Email_SMS_Template__c template1= new Email_SMS_Template__c();
        template1.Name = 'ICF Email AMFS Claim Reject RLS DMTM';
        template1.Category__c = 'ICF';
        template1.Detail_Link__c = '[SURVEY_LINK]';
        template1.Email_Body__c = '[CONTACT_GENDER] [CONTACT_NAME] [CASE_NUMBER] [POLICY_NO] [MOT_SERVICE] [SURVEY_LINK]';
        template1.Entity__c = 'AMFS';
        template1.Subject__c = 'Survey Kepuasan Nasabah [MOT_SERVICE]';
        
        Email_SMS_Template__c template2= new Email_SMS_Template__c();
        template2.Name = 'ICF Email AMFS Claim Reject AHS cashless';
        template2.Category__c = 'ICF';
        template2.Detail_Link__c = '[SURVEY_LINK]';
        template2.Email_Body__c = '[CONTACT_GENDER] [CONTACT_NAME] [CASE_NUMBER] [POLICY_NO] [MOT_SERVICE] [SURVEY_LINK]';
        template2.Entity__c = 'AMFS';
        template2.Subject__c = 'Survey Kepuasan Nasabah [MOT_SERVICE]';
        
        Email_SMS_Template__c template3= new Email_SMS_Template__c();
        template3.Name = 'ICF Email AMFS Claim Reject AHS reimbusement';
        template3.Category__c = 'ICF';
        template3.Detail_Link__c = '[SURVEY_LINK]';
        template3.Email_Body__c = '[CONTACT_GENDER] [CONTACT_NAME] [CASE_NUMBER] [POLICY_NO] [MOT_SERVICE] [SURVEY_LINK]';
        template3.Entity__c = 'AMFS';
        template3.Subject__c = 'Survey Kepuasan Nasabah [MOT_SERVICE]';
        
        List_esl.add(template);
        List_esl.add(template1);
        List_esl.add(template2);
        List_esl.add(template3);
        insert List_esl;
        
        Set<Id> idICF = new Set<Id>();
        idICF.add(data_fraud.id);
        idICF.add(data_fraud1.id);
        idICF.add(data_fraud2.id);
        idICF.add(data_c.id);
        idICF.add(data_c1.id);
        idICF.add(data_c2.id);
        idICF.add(data_r.id);
        idICF.add(data_r1.id);
        idICF.add(data_r2.id);
        
        Test.startTest();
        System.enqueueJob(new CreateEmailSMSLogClaimReject.CreateEmailSMSLog(idICF));

        Test.stopTest();
    }
    
    static testMethod void TestClass1(){
        String entity = 'AMFS';
        Date YESTERDAYS = Date.today().addDays(-1);
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest20';
        ac1.Entity__c = entity;
        insert ac1;
        
        List<Contact> list_contact = new List<Contact>();
        Contact contact1 = new Contact();
        contact1.FirstName = 'Adi';
        contact1.LastName = 'Wijaya';
        contact1.Email = 'adiwijaya@email.com';
        contact1.Policy_No__c = '77700144';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        contact1.WelcomeCall_Issued_Date__c = YESTERDAYS;
        
        Contact contact2= new Contact();
        contact2.FirstName = 'Adi';
        contact2.LastName = 'Wijaya';
        contact2.MobilePhone = '6285716222996';
        contact2.Policy_No__c = '77700145';
        contact2.Entity__c = entity;
        contact2.AccountId = ac1.Id;
        contact2.WelcomeCall_Issued_Date__c = YESTERDAYS;
        
        list_contact.add(contact1);
        list_contact.add(contact2);
        insert list_contact;

        
        ICF_Non_Real_Time__c data = new ICF_Non_Real_Time__c();
        data.Claim_Number__c = '12345';
        data.Claim_Type__c = 'Health';
        data.Fraud__c = '';
        data.Jenis_Transaksi__c = 'CASHLESS';
        data.Nama_RS_Provider__c = 'RS. ABC';
        data.Source_System__c = 'RLS';
        data.External_ID__c = '12345-77700144';
        data.Policy_Number__c = '77700144';
        insert data;
        
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Qualtrics').getRecordTypeId();
        testICFParam.Interval_Completed_Month__c = '1';
        testICFParam.Entity__c = 'AMFS';
        testICFParam.Status__c = 'Active';
        testICFParam.Status_Cases__c = 'Closed';
        insert testICFParam;
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'Survey Request I Claim Individu Cashless';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master New Onboarding').getRecordTypeId();
        setSurvey.URL__c = 'https://axaid-ccc--fullsb.sandbox.my.salesforce-sites.com/survey/TakeSurveyDynamic?';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Status__c = 'Active';
        insert setSurvey;
        
        Email_SMS_Template__c template = new Email_SMS_Template__c();
        template.Name = 'ICF Email (AMFS) 2024';
        template.Category__c = 'ICF';
        template.Detail_Link__c = '[SURVEY_LINK]';
        template.Email_Body__c = '[CONTACT_GENDER] [CONTACT_NAME] [CASE_NUMBER] [POLICY_NO] [MOT_SERVICE] [SURVEY_LINK]';
        template.Entity__c = 'AMFS';
        template.Subject__c = 'Survey Kepuasan Nasabah [MOT_SERVICE]';
        insert template;
        
        List<Email_SMS_Log__c> list_esl = new List<Email_SMS_Log__c>();
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = 'ICF';
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Claim';
        esl.MOT__c = 'I Claim';
        esl.Request_Date__c = Date.Today();
        esl.Survey__c = setSurvey.Id;
        esl.Email_SMS_Template__c = template.Id;
        esl.Email_Text__c = '[CONTACT_GENDER] [CONTACT_NAME] [CASE_NUMBER] [POLICY_NO] [MOT_SERVICE] [SURVEY_LINK]';
        
        Email_SMS_Log__c esl1 = new Email_SMS_Log__c();
        esl1.Status__c = 'Draft';
        esl1.Contact__c = contact2.Id;
        esl1.Account__c = contact2.AccountId;
        esl1.Entity__c = contact2.Entity__c;
        esl1.Email__c = contact2.Email;
        esl1.Mobile__c = contact2.MobilePhone;
        esl1.Send_Flag__c = true;
        esl1.Category__c = 'ICF';
        esl1.Type__c = 'CCC';
        esl1.Method__c = 'Whatsapp';
        esl1.Survey_Type__c = 'I Claim';
        esl1.MOT__c = 'I Claim';
        esl1.Request_Date__c = Date.Today();
        esl1.Survey__c = setSurvey.Id;
        esl1.Email_SMS_Template__c = template.Id;
        esl1.Email_Text__c = '[CONTACT_GENDER] [CONTACT_NAME] [CASE_NUMBER] [POLICY_NO] [MOT_SERVICE] [SURVEY_LINK] [SHORT_URL]';
        
        list_esl.add(esl);
        list_esl.add(esl1);
        insert list_esl; 
        
        Set<Id> idICF = new Set<Id>();
        idICF.add(esl.id);
        idICF.add(esl1.id);
        
        Test.startTest();
        CreateEmailSMSLogClaimReject.send(idICF);
        
        Test.stopTest();
    }
    
    /*static testmethod void testSendMethodThrowsException() {
        // Buat Email_SMS_Log__c dengan Survey__c pointing ke ID yang tidak valid
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'Survey Request I Claim Individu Cashless';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master New Onboarding').getRecordTypeId();
        setSurvey.URL__c = 'https://axaid-ccc--fullsb.sandbox.my.salesforce-sites.com/survey/TakeSurveyDynamic?';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Status__c = 'Active';
        insert setSurvey;
        
        Email_SMS_Log__c log = new Email_SMS_Log__c();
        log.Method__c = 'Whatsapp';
        log.Mobile__c = '08123456789';
        log.Survey__c = setSurvey.Id; // ID tidak valid untuk memicu exception saat query
        log.Contact__c = null; // bisa juga menyebabkan error saat URL dibentuk
        log.Email_Text__c = '[SHORT_URL]';
        insert log;

        Set<Id> emailLogs = new Set<Id>{log.Id};

        Test.startTest();
        CreateEmailSMSLogClaimReject.testBoolean = false;
        CreateEmailSMSLogClaimReject.testBoolean2 = true;
        CreateEmailSMSLogClaimReject.send(emailLogs);
        Test.stopTest();

    }*/

}