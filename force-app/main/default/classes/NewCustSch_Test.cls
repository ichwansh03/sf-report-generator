@isTest
public class NewCustSch_Test {
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
        contact1.MobilePhone = '6285716222996';
        contact1.Policy_No__c = '77700144';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        contact1.WelcomeCall_Issued_Date__c = YESTERDAYS;
        insert contact1;
        
        Test.startTest();
        NewCustSch sch = new NewCustSch();
        sch.execute(null);
        Test.stopTest();
    }
    
    static testMethod void TestClassSch(){
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
        contact1.MobilePhone = '6285716222996';
        contact1.Policy_No__c = '77700144';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        contact1.WelcomeCall_Issued_Date__c = YESTERDAYS;
        insert contact1;
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'Survey Nasabah Onboarding';
        setSurvey.Survey_Type__c = 'I Buy';
        setSurvey.Status__c = 'Active';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master New Onboarding').getRecordTypeId();
        insert setSurvey;
        
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
        
        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        setCaseType.name = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Ask';
        setCaseType.Qualtrics__c  = true;
        INSERT setCaseType;
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = 'Inquiry';
        inquiryCreateOpen.Status = 'New';
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
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
        esl.Category__c = 'ICF';
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Ask';
        esl.Request_Date__c = Date.today();
        insert esl;
        
        Surveytaker__c setSurveyParent = new Surveytaker__c();
        setSurveyParent.Contact__c = contact1.Id;
        setSurveyParent.Case__c = inquiryCreateOpen.id;
        setSurveyParent.Email_SMS_Log__c = esl.id;
        setSurveyParent.Survey__c = setSurvey.id;
        setSurveyParent.Update_Call_Line__c = false;
		insert setSurveyParent;
        
        Survey_Response__c setSurveyResponse = new Survey_Response__c();
        setSurveyResponse.Survey__c =setSurvey.id;
        setSurveyResponse.SurveyTaker__c =setSurveyParent.id; 
        setSurveyResponse.Email_SMS_Log__c = esl.id;
        setSurveyResponse.isQualtrics__c = true;
        setSurveyResponse.Answer_1__c = '3';
        insert setSurveyResponse;
        
        UserRole agentRoleAMFS = [SELECT Id FROM UserRole WHERE Name like 'Outbound Agent%AMFS' limit 1]; 
        User agentUserAMFS = [Select id, managerId from User where isactive = true and managerId != null and userRoleId =: agentRoleAMFS.id Limit 1];
        
        Call_Line__c cl = new Call_Line__c();
        cl.Call_Status_Config__c = 'Hold';
        cl.Policy_No__c = '77700144';
        cl.Contact__c = contact1.Id;
        cl.Remark_Hold_Debet__c = 'test';
        cl.OwnerId = agentUserAMFS.Id;
        cl.Agent__c = agentUserAMFS.Id;
        cl.APE_Total_Child__c = 1000000;
        cl.Entity__c = 'AMFS';
        cl.Activity__c = 'Collection';
        cl.Policy_No__c = 'test';
        cl.Contacted_Number__c = '123456789';
        cl.Home_Phone__c = '1234567';
        cl.RecordTypeId = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
        Insert cl; 
        
        Test.startTest();
        UpdateCallLineSch sch = new UpdateCallLineSch();
        sch.execute(null);
        Test.stopTest();
    }

}