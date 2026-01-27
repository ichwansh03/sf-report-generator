@isTest
public class SchStartICFNonCCC_test {
    @testSetup static void testData() {
        RecordType svMaster = [SELECT Id FROM RecordType WHERE SObjectType = 'Survey__c' AND Name = 'Master' LIMIT 1];
        RecordType prmMasterEmailSms = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Email & SMS' LIMIT 1];
        RecordType prmMasterNonCCC = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Non CCC' LIMIT 1];
        
        Datetime dTime = Datetime.newInstance(2019, 03, 10, 0, 0, 0);
        Date crDate = Date.newInstance(2019, 1, 1);
        
        //--Account
        Account acc = new Account();
        acc.Name = 'Account AFI';
        acc.Entity__c = 'AFI';
        insert acc;
        
        //--Contact
        Contact con = new Contact();
        con.LastName = 'ICF Non CCC AFI';
        con.Email = 'email@host.com';
        con.Policy_No__c = '500-1234567';
        con.Entity__c = 'AFI';
        con.AccountId = acc.Id;
        insert con;
        
        //--ICF Non CCC Record
        ICF_Non_CCC__c icf = new ICF_Non_CCC__c();
        icf.Status__c = 'Check';
        icf.Policy_Number__c = '500-1234567';
        icf.Application__c = 'RLS';
        icf.Approved_Date__c = dTime;
        icf.Entity__c = 'AFI';
        icf.MOT__c = 'I Ask';
        icf.Transaction_Code__c = 'Q';
        icf.Captured_Date__c = dTime;
        icf.Submitted_Date__c = dTime;
        icf.ICF_Send_Value__c = '5';
        icf.ICF_Send_Field__c = 'Approved Date';
        icf.ICF_Status__c = 'Ready to Send';
        insert icf;
        Test.setCreatedDate(icf.Id, crDate);
        
        ICF_Non_CCC__c icf2 = new ICF_Non_CCC__c();
        icf2.Status__c = 'Draft';
        icf2.Policy_Number__c = '500-1234567';
        icf2.Application__c = 'RLS';
        icf2.Approved_Date__c = dTime;
        icf2.Entity__c = 'AFI';
        icf2.MOT__c = 'I Buy';
        icf2.Transaction_Code__c = 'Q';
        icf2.Captured_Date__c = dTime;
        icf2.Submitted_Date__c = dTime;
        icf2.ICF_Send_Value__c = '5';
        icf2.ICF_Send_Field__c = 'Approved Date';
        insert icf2;
        Test.setCreatedDate(icf2.Id, crDate);
        
        //--Survey Record
        Survey__c sv = new Survey__c();
        sv.Name = 'I ASK (AFI)';
        sv.Entity__c = 'AFI';
        sv.RecordTypeId = svMaster.Id; //--'Master'
        sv.Hide_Survey_Name__c = TRUE;
        sv.Survey_Type__c = 'I Ask';
        sv.Submit_Response__c = 'empty';
        sv.URL__c = 'http://axaindonesia.force.com/survey/TakeSurvey?';
        sv.Status__c = 'Active';
        sv.Answer_Type__c = 'Image';
        insert sv;
        
        //--Email Template
        Email_SMS_Template__c emailTp = new Email_SMS_Template__c();
        emailTp.Name = 'Email AFI';
        emailTp.Category__c = 'ICF';
        emailTp.Entity__c = 'AFI';
        emailTp.Subject__c = 'Email Subject';
        emailTp.Method__c = 'Email';
        emailTp.Detail_Link__c = '[SURVEY_LINK]';
        insert emailTp;
        
        //--SMS Template
        Email_SMS_Template__c smsTp = new Email_SMS_Template__c();
        smsTp.Name = 'SMS AFI';
        smsTp.Category__c = 'ICF';
        smsTp.Entity__c = 'AFI';
        smsTp.Subject__c = 'SMS Subject';
        smsTp.Method__c = 'SMS';
        smsTp.Detail_Link__c = '[SURVEY_LINK]';
        insert smsTp;
        
        //--ICF Parameter Record
        ICF_Parameter__c prm = new ICF_Parameter__c();
        prm.Entity__c = 'AFI';
        prm.RecordTypeId = prmMasterEmailSms.Id; //--'Master - Email & SMS'
        prm.Status__c = 'Active';
        prm.User_ID__c = 'axacccafi';
        prm.Password__c = 'axacccafi789';
        prm.Division__c = 'CCCAFI';
        prm.Sender__c = 'AXA_FIN_IND';
        prm.Batchname__c = 'ICF_SMS_AFI';
        prm.Uploadby__c = 'Salesforce_AFI';
        prm.Channel__c = '0';
        prm.ICF_Method__c = 'Email';
        prm.Login_1__c = 'axamii4';
        prm.API_Key_1__c = 'R_76b949e73be6442fb388476e3ec5727d';
        prm.ICF_Email_Template__c = emailTp.Id;
        prm.ICF_SMS_Template__c = smsTp.Id;
        prm.Countdown_Send__c = 0;
        insert prm;
        
        ICF_Parameter__c prmNC = new ICF_Parameter__c();
        prmNC.Entity__c = 'AFI';
        prmNC.RecordTypeId = prmMasterNonCCC.Id; //--'Master - Non CCC'
        prmNC.Status__c = 'Active';
        prmNC.ICF_Email_Template__c = emailTp.Id;
        prmNC.ICF_SMS_Template__c = smsTp.Id;
        prmNC.Countdown_Send__c = 0;
        insert prmNC;
        
        //--ICF Parameterized Filter Criteria
        ICF_Parameterized_Filter_Criteria__c prmFilter1 = new ICF_Parameterized_Filter_Criteria__c();
        prmFilter1.Category__c = ''; 
        prmFilter1.Type__c = 'Schedule - I Buy';
        prmFilter1.Send_Field__c = 'Issued Date';
        prmFilter1.Seq__c = 1;
        prmFilter1.Field__c = 'Application';
        prmFilter1.Operator__c = 'Equal';
        prmFIlter1.Value_Custom__c = 'RLS';
        prmFilter1.Parameterized__c = prmNC.Id;
        insert prmFilter1;
        /*
        ICF_Parameterized_Filter_Criteria__c prmFilter2 = new ICF_Parameterized_Filter_Criteria__c();
        prmFilter2.Category__c = ''; 
        prmFilter2.Type__c = 'Schedule - I Ask';
        prmFilter2.Send_Field__c = 'Approved Date';
        prmFilter2.Seq__c = 1;
        prmFilter2.Field__c = 'Application';
        prmFilter2.Operator__c = 'Equal';
        prmFIlter2.Value_Custom__c = 'RLS';
        prmFilter2.Parameterized__c = prmNC.Id;
        insert prmFilter2;
        */
        ICF_Parameterized_Filter_Criteria__c prmFilter5 = new ICF_Parameterized_Filter_Criteria__c();
        prmFilter5.Category__c = ''; 
        prmFilter5.Type__c = 'Exclude - I Buy';
        prmFilter5.Seq__c = 1;
        prmFilter5.Field__c = 'Application';
        prmFilter5.Operator__c = 'Equal';
        prmFIlter5.Value_Custom__c = 'RLS';
        prmFilter5.Parameterized__c = prmNC.Id;
        insert prmFilter5;
    }
    
    static testMethod void runScheduleBatch() {
        String CRON_EXP = '0 0 0 15 3 ? *';
        
        Test.startTest();

            String jobId = System.schedule('SchStartICFNonCCCTest',  CRON_EXP, new SchStartICFNonCCC());
            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
            System.assertEquals(CRON_EXP, ct.CronExpression);
            System.assertEquals(0, ct.TimesTriggered);

        Test.stopTest();
    }
    
    static testMethod void runScheduleBatch2() {
        String CRON_EXP = '0 0 0 15 3 ? *';
        
        Test.startTest();

            String jobId = System.schedule('SchDeleteICFNonCCCTest',  CRON_EXP, new SchDeleteICFNonCCC());
            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
            System.assertEquals(CRON_EXP, ct.CronExpression);
            System.assertEquals(0, ct.TimesTriggered);

        Test.stopTest();
    }
    
    static testMethod void runScheduleBatch3() {
        String CRON_EXP = '0 0 0 15 3 ? *';
        
        Test.startTest();

            String jobId = System.schedule('SchCheckICFNonCCCTest',  CRON_EXP, new SchCheckICFNonCCC());
            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
            System.assertEquals(CRON_EXP, ct.CronExpression);
            System.assertEquals(0, ct.TimesTriggered);

        Test.stopTest();
    }
    
    static testMethod void runScheduleBatch3a() {
        ICF_Parameter__c prmNC = [SELECT Id FROM ICF_Parameter__c WHERE Record_Type_Name__c = 'Master_Non_CCC'];
        
        ICF_Parameterized_Filter_Criteria__c prmFilter2 = new ICF_Parameterized_Filter_Criteria__c();
        prmFilter2.Category__c = ''; 
        prmFilter2.Type__c = 'Schedule - I Ask';
        prmFilter2.Send_Field__c = 'Approved Date';
        prmFilter2.Seq__c = 1;
        prmFilter2.Field__c = 'Application';
        prmFilter2.Operator__c = 'Equal';
        prmFIlter2.Value_Custom__c = 'RLS';
        prmFilter2.Parameterized__c = prmNC.Id;
        insert prmFilter2;
        
        Test.startTest();
        
        	SchCheckScheduleICFNonCCC schBatch = new SchCheckScheduleICFNonCCC();
        	Database.executeBatch(schBatch, 2);
        
        Test.stopTest();
    }
}