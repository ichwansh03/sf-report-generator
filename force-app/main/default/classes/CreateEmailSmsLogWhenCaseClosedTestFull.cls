@isTest
public class CreateEmailSmsLogWhenCaseClosedTestFull {
    @testSetup static void setupRecord() {
        User u = new User();
        u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'CMU-AFI'].Id;
        u.LastName = 'LN';
        u.Email = 'afiuser@axa.com';
        u.Username = 'afiuser@axaxa.com' + System.currentTimeMillis();
        u.CompanyName = 'AXAX';
        u.Title = 'user';
        u.Alias = 'afiuser';
        u.TimeZoneSidKey = 'America/Los_Angeles';
        u.EmailEncodingKey = 'UTF-8';
        u.LanguageLocaleKey = 'en_US';
        u.LocaleSidKey = 'en_US';
        u.Entity__c = 'AFI';
        insert u;
        
        User adm = new User();
        adm.ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id;
        adm.LastName = 'ADM';
        adm.Email = 'admuser@axa.com';
        adm.Username = 'admuser@axaxa.com' + System.currentTimeMillis();
        adm.CompanyName = 'AXAX';
        adm.Title = 'admuser';
        adm.Alias = 'admuser';
        adm.TimeZoneSidKey = 'America/Los_Angeles';
        adm.EmailEncodingKey = 'UTF-8';
        adm.LanguageLocaleKey = 'en_US';
        adm.LocaleSidKey = 'en_US';
        adm.Entity__c = 'AFI';
        insert adm;
        
        Recordtype rtIcf = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Email & SMS'];
        ICF_Parameter__c icfParam = new ICF_Parameter__c();
        icfParam.RecordTypeId = rtIcf.Id;
        icfParam.Status__c = 'Active';
        icfParam.Status_Cases__c = 'Open';
        icfParam.Entity__c = 'AFI';
        icfParam.Description__c = 'ICF Description';
        icfParam.User_ID__c = 'axacccafi';
        icfParam.Password__c = 'axacccafi789';
        icfParam.Division__c = 'CCCAFI';
        icfParam.Sender__c = 'AXA_FIN_IND';
        icfParam.Batchname__c = 'ICF_SMS_AFI';
        icfParam.Uploadby__c = 'Salesforce_AFI';
        icfParam.Channel__c = '0';
        icfParam.Login_1__c = 'axamii4';
        icfParam.API_Key_1__c ='R_76b949e73be6442fb388476e3ec5727d';
        icfParam.Send_ICF_Flag__c = true;
        icfParam.Send_Thanks_Note_Flag__c = true;
        insert icfParam;
        
        Account acc = new Account();
        acc.Name = 'Test Account XYZ';
        acc.Entity__c = 'AFI';
        insert acc;
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'LastName';
        con.FirstName = 'FirstName';
        con.Email = 'email@domain.com';
        con.MobilePhone = '08123456789';
        con.Policy_No__c = '511-7179717';
        con.Entity__c = 'AFI';
        insert con;
        
        //======
        
        Account acc2 = new Account();
        acc2.Name = 'Test Account XYZ AMFS';
        acc2.Entity__c = 'AMFS';
        insert acc2;
        
        Contact con2 = new Contact();
        con2.AccountId = acc2.Id;
        con2.LastName = 'LastName AMFS';
        con2.FirstName = 'FirstName';
        con2.Email = 'emailamfs@domain.com';
        con2.MobilePhone = '08123456780';
        con2.Policy_No__c = '511-7179718';
        con2.Entity__c = 'AMFS';
        insert con2;
        
        Contact con3 = new Contact();
        con3.AccountId = acc2.Id;
        con3.LastName = 'LastName AMFS 2';
        con3.FirstName = 'FirstName';
        con3.Email = 'emailamfs2@domain.com';
        con3.MobilePhone = '08123456781';
        con3.Policy_No__c = '511-7179719';
        con3.Entity__c = 'AMFS';
        insert con3;
        
        //======
        String RECORD_TYPE_EMAIL_SMS = 'Master - Email & SMS';
        
        String userId = UserInfo.getUserId(); 
        User userObj = [Select id,Entity__c from  User WHERE Id = :userId ORDER BY CreatedDate DESC Limit 1];
        String entity = userObj.Entity__c;
        
        Account ac1 = new Account();
        ac1.Name = 'Test Account XYZ2';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'FirstName2';
        contact1.LastName = 'LastName2';
        contact1.Email = 'billgates@email.com';
        contact1.MobilePhone = '0891667363';
        contact1.Policy_No__c = '77700136';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId();
        testICFParam.Interval_Completed_Month__c = '1';
        testICFParam.Entity__c = entity;
        testICFParam.Status__c = 'Active';
        testICFParam.Send_ICF_Flag__c = true;
        testICFParam.Send_Thanks_Note_Flag__c = true;
        insert testICFParam;
         
        ICF_Parameter__c testICFParam2 = new ICF_Parameter__c();
        testICFParam2.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam2.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - CCC').getRecordTypeId();
        testICFParam2.Interval_Completed_Month__c = '1';
        testICFParam2.Entity__c = entity;
        testICFParam2.Status__c = 'Active';
        testICFParam2.Send_ICF_Flag__c = true;
        testICFParam2.Send_Thanks_Note_Flag__c = true;
        insert testICFParam2;
    }
    
    public static testMethod void insertCaseInquiry() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ' limit 1];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName' limit 1];
        
        Test.startTest();
        Case cs = new Case();
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject INQ';
        cs.Type = 'Inquiry';
        cs.Status = 'New';
        cs.Already_Send_Survey__c = true;
        insert cs;
        
        cs.Status = 'Closed';
        cs.Already_Send_Survey__c = false;
        cs.ManualClosedCase__c = false;
        update cs;
        
        Test.stopTest();
    }
    
    public static testMethod void insertCaseRequestNew() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ' limit 1];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName' limit 1];
        User u = [SELECT Id FROM User WHERE LastName = 'LN' limit 1];
        
        Test.startTest();
        Case cs = new Case();
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject REQ';
        cs.Type = 'Request';
        cs.Related_Departments__c  = 'CMU';
        cs.Case_Type__c = 'Procedure Claim';
        cs.Case_Type_Config__c = 'Procedure Claim';
        cs.Status = 'New';
        cs.Already_Send_Survey__c = false;
        cs.PIC_Department_LU__c = u.Id;
        insert cs;
        
        cs.Status = 'Closed';
        cs.ManualClosedCase__c = false;
        update cs;
        
        Test.stopTest();
    }
    
    /*
    public static testMethod void insertCaseComplaintNew() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ' limit 1];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName' limit 1];
        User adm = [SELECT Id FROM User WHERE LastName = 'ADM' limit 1];
        
        Test.startTest();
        Case cs = new Case();
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject COM';
        cs.Type = 'Complaint';
        cs.Status = 'New';
        cs.Already_Send_Survey__c = false;
        insert cs;
        
        System.runAs(adm) {
            cs.Status = 'Closed';
            cs.ManualClosedCase__c = false;
            update cs;
        }
        Test.stopTest();
    }
	*/
    
    public static testMethod void insertCaseRequestClosed() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ' limit 1];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName' limit 1];
        User u = [SELECT Id FROM User WHERE LastName = 'LN' limit 1];
        
        Test.startTest();
        Case cs = new Case();
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject REQ';
        cs.Type = 'Request';
        cs.Status = 'Closed';
        cs.Already_Send_Survey__c = false;
        cs.PIC_Department_LU__c = u.Id;
        insert cs;
        Test.stopTest();
    }
    
    public static testMethod void insertCaseComplaintClosed() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ' limit 1];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName' limit 1];
        
        Test.startTest();
        Case cs = new Case();
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject COM';
        cs.Type = 'Complaint';
        cs.Status = 'Closed';
        cs.CHS_Status__c = 'Closed - Invalid';
        cs.Already_Send_Survey__c = false;
        cs.Complaint_Decision_AMFS__c = 'Invalid & Reject';
        cs.Complaint_Decision__c = 'Reject';
        cs.Financial_Lost__c = 0;
        cs.Conclusion__c = 'Reject';
        cs.Corrective_Action__c = 'Reject';
        cs.Other_Information__c = 'Reject';
        cs.Reason_Root_Cause__c = 'Reject';
        cs.NDA_Date__c = Date.today();
        cs.Paid_Amount__c = 0;
        cs.Sub_Status__c = 'Invalid Paid';
        insert cs;
        Test.stopTest();
    }
    
    
    public static testMethod void insertCaseInquiry2() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ' limit 1];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName' limit 1];
         
        Recordtype rtIcf = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Email & SMS'];
        ICF_Parameter__c icfParam = new ICF_Parameter__c();
        icfParam.RecordTypeId = rtIcf.Id;
        icfParam.Status__c = 'Active';
        icfParam.Status_Cases__c = 'Open';
        icfParam.Entity__c = 'AMFS';
        icfParam.Description__c = 'ICF Description'; 
        icfParam.Channel__c = '0';
        icfParam.Login_1__c = 'axamii4'; 
        icfParam.Send_ICF_Flag__c = true;
        icfParam.Send_Thanks_Note_Flag__c = TRUE;
        insert icfParam;
        
        Recordtype rtIcf2 = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - CCC'];
        ICF_Parameter__c icfParam2 = new ICF_Parameter__c();
        icfParam2.RecordTypeId = rtIcf2.Id;
        icfParam2.Status__c = 'Active';
        icfParam2.Status_Cases__c = 'Open';
        icfParam2.Entity__c = 'AMFS';
        icfParam2.Description__c = 'ICF Description'; 
        icfParam2.Channel__c = '0';
        icfParam2.Login_1__c = 'axamii4'; 
        icfParam2.Send_ICF_Flag__c = true;
        icfParam2.Send_Thanks_Note_Flag__c = false;
        insert icfParam2;
        
        Test.startTest();
        Case cs = new Case();
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject INQ';
        cs.Type = 'Inquiry'; 
        cs.Status = 'Closed';
        cs.Already_Send_Survey__c = false; 
        insert cs; 
        
        Test.stopTest();
    }
    
    public static testMethod void insertCaseInquiry3() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ' limit 1];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName' limit 1];
         
        Recordtype rtIcf = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Email & SMS'];
        ICF_Parameter__c icfParam = new ICF_Parameter__c();
        icfParam.RecordTypeId = rtIcf.Id;
        icfParam.Status__c = 'Active';
        icfParam.Status_Cases__c = 'Open';
        icfParam.Entity__c = 'AMFS';
        icfParam.Description__c = 'ICF Description'; 
        icfParam.Channel__c = '0';
        icfParam.Login_1__c = 'axamii4'; 
        icfParam.Send_ICF_Flag__c = true;
        icfParam.Send_Thanks_Note_Flag__c = false;
        insert icfParam;
        
        Recordtype rtIcf2 = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - CCC'];
        ICF_Parameter__c icfParam2 = new ICF_Parameter__c();
        icfParam2.RecordTypeId = rtIcf2.Id;
        icfParam2.Status__c = 'Active';
        icfParam2.Status_Cases__c = 'Open';
        icfParam2.Entity__c = 'AMFS';
        icfParam2.Description__c = 'ICF Description'; 
        icfParam2.Channel__c = '0';
        icfParam2.Login_1__c = 'axamii4'; 
        icfParam2.Send_ICF_Flag__c = true;
        icfParam2.Send_Thanks_Note_Flag__c = false;
        insert icfParam2;
        
        
        Test.startTest();
        Case cs = new Case();
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject INQ';
        cs.Type = 'Inquiry'; 
        cs.Status = 'Closed';
        cs.Already_Send_Survey__c = false; 
        insert cs; 
        
        Test.stopTest();
    }
    
    
    public static testMethod void insertCaseInquiry4() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ' limit 1];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName' limit 1];
         
        Recordtype rtIcf = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Email & SMS'];
        ICF_Parameter__c icfParam = new ICF_Parameter__c();
        icfParam.RecordTypeId = rtIcf.Id;
        icfParam.Status__c = 'Active';
        icfParam.Status_Cases__c = 'Open';
        icfParam.Entity__c = 'AMFS';
        icfParam.CCC_I_Ask_Exculde__c = 'Request_Reprint Polis Convent';
        icfParam.CCC_I_Complain_Exculde__c = 'Request_Reprint Polis Convent';
        icfParam.Description__c = 'ICF Description'; 
        icfParam.Channel__c = '0';
        icfParam.Login_1__c = 'axamii4'; 
        icfParam.Send_ICF_Flag__c = false;
        icfParam.Send_Thanks_Note_Flag__c = TRUE;
        insert icfParam;
        
        Recordtype rtIcf2 = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - CCC'];
        ICF_Parameter__c icfParam2 = new ICF_Parameter__c();
        icfParam2.RecordTypeId = rtIcf2.Id;
        icfParam2.Status__c = 'Active';
        icfParam2.Status_Cases__c = 'Open';
        icfParam2.Entity__c = 'AMFS';
        icfParam2.Description__c = 'ICF Description'; 
        icfParam2.Channel__c = '0';
        icfParam2.Login_1__c = 'axamii4'; 
        icfParam2.Send_ICF_Flag__c = true;
        icfParam2.Send_Thanks_Note_Flag__c = false;
        insert icfParam2;
        
        
        Test.startTest();
        Case cs = new Case();
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject INQ';
        cs.Type = 'Inquiry'; 
        cs.Status = 'Closed';
        cs.Already_Send_Survey__c = false; 
        insert cs; 
        
        Test.stopTest();
    }
    
    
    public static testMethod void insertCaseInquiry5() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ' limit 1];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName' limit 1];
         
        Recordtype rtIcf = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Email & SMS'];
        ICF_Parameter__c icfParam = new ICF_Parameter__c();
        icfParam.RecordTypeId = rtIcf.Id;
        icfParam.Status__c = 'Active';
        icfParam.Status_Cases__c = 'Open';
        icfParam.Entity__c = 'AMFS';
        icfParam.CCC_I_Ask_Exculde__c = 'Request_Reprint Polis Convent';
        icfParam.CCC_I_Complain_Exculde__c = 'Request_Reprint Polis Convent';
        icfParam.Description__c = 'ICF Description'; 
        icfParam.Channel__c = '0';
        icfParam.Login_1__c = 'axamii4'; 
        icfParam.Send_ICF_Flag__c = false;
        icfParam.Send_Thanks_Note_Flag__c = TRUE;
        insert icfParam;
        
        Recordtype rtIcf2 = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - CCC'];
        ICF_Parameter__c icfParam2 = new ICF_Parameter__c();
        icfParam2.RecordTypeId = rtIcf2.Id;
        icfParam2.Status__c = 'Active';
        icfParam2.Status_Cases__c = 'Open';
        icfParam2.Entity__c = 'AMFS';
        icfParam2.Description__c = 'ICF Description'; 
        icfParam2.Channel__c = '0';
        icfParam2.Login_1__c = 'axamii4'; 
        icfParam2.Send_ICF_Flag__c = true;
        icfParam2.Send_Thanks_Note_Flag__c = false;
        icfparam2.CCC_I_Ask_Exculde__c = '(NB/UW) Information Status;Claim Information Status;Complaint Status;Delivery Status;Drop Call;IVR Utilization;Off Line Application';
        insert icfParam2;
        
        
        Test.startTest();
        Case cs = new Case();
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject INQ';
        cs.Type = 'Inquiry'; 
        cs.Status = 'New';
        cs.Already_Send_Survey__c = false; 
        insert cs; 
        
        Test.stopTest();
    }
    
    
    public static testMethod void insertCaseInquiry6() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ' limit 1];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName' limit 1];
         
        Recordtype rtIcf = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Email & SMS'];
        ICF_Parameter__c icfParam = new ICF_Parameter__c();
        icfParam.RecordTypeId = rtIcf.Id;
        icfParam.Status__c = 'Active';
        icfParam.Status_Cases__c = 'Open';
        icfParam.Entity__c = 'AMFS';
        icfParam.CCC_I_Ask_Exculde__c = 'Request_Reprint Polis Convent';
        icfParam.CCC_I_Complain_Exculde__c = 'Request_Reprint Polis Convent';
        icfParam.Description__c = 'ICF Description'; 
        icfParam.Channel__c = '0';
        icfParam.Login_1__c = 'axamii4'; 
        icfParam.Send_ICF_Flag__c = TRUE;
        icfParam.Send_Thanks_Note_Flag__c = TRUE;
        insert icfParam;
        
        Recordtype rtIcf2 = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - CCC'];
        ICF_Parameter__c icfParam2 = new ICF_Parameter__c();
        icfParam2.RecordTypeId = rtIcf2.Id;
        icfParam2.Status__c = 'Active';
        icfParam2.Status_Cases__c = 'Open';
        icfParam2.Entity__c = 'AMFS';
        icfParam2.Description__c = 'ICF Description'; 
        icfParam2.Channel__c = '0';
        icfParam2.Login_1__c = 'axamii4'; 
        icfParam2.Send_ICF_Flag__c = true;
        icfParam2.Send_Thanks_Note_Flag__c = false;
        icfparam2.CCC_I_Ask_Exculde__c = '(NB/UW) Information Status;Claim Information Status;Complaint Status;Delivery Status;Drop Call;IVR Utilization;Off Line Application';
        insert icfParam2;
        
        //String recordtypeid = System.label.RecordType_Master_Survey;
        //System.debug('Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get(Master Qualtrics).getRecordTypeId():'+Schema.SObjectType.Survey__c.getRecordTypeInfosByDeveloperName().get('Master').getRecordTypeId());
        
        Recordtype recordtypeid = [SELECT Id FROM RecordType WHERE SObjectType = 'Survey__c' AND Name = 'Master New Onboarding'];
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Status__c = 'Active';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.Survey_Type__c = 'I Ask'; 
        setSurvey.URL__c = 'https://axaid-ccc--fullsb.sandbox.my.salesforce-sites.com/survey/TakeSurveyDynamic?'; 
        
        setSurvey.RecordTypeId = recordtypeid.Id; 
        insert setSurvey; 
        
        Test.startTest();
        Case cs = new Case();
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject INQ';
        cs.Type = 'Inquiry'; 
        cs.Status = 'New';
        cs.Already_Send_Survey__c = false; 
        insert cs; 
        
        Test.stopTest();
    }
    
    
    public static testMethod void insertCaseInquiry7() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ' limit 1];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName' limit 1];
         
        Recordtype rtIcf = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Email & SMS'];
        ICF_Parameter__c icfParam = new ICF_Parameter__c();
        icfParam.RecordTypeId = rtIcf.Id;
        icfParam.Status__c = 'Active';
        icfParam.Status_Cases__c = 'Open';
        icfParam.Entity__c = 'AMFS';
        icfParam.CCC_I_Ask_Exculde__c = 'Request_Reprint Polis Convent';
        icfParam.CCC_I_Complain_Exculde__c = 'Request_Reprint Polis Convent';
        icfParam.Description__c = 'ICF Description'; 
        icfParam.Channel__c = '0';
        icfParam.Login_1__c = 'axamii4'; 
        icfParam.Send_ICF_Flag__c = TRUE;
        icfParam.Send_Thanks_Note_Flag__c = false;
        insert icfParam;
        
        Recordtype rtIcf2 = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - CCC'];
        ICF_Parameter__c icfParam2 = new ICF_Parameter__c();
        icfParam2.RecordTypeId = rtIcf2.Id;
        icfParam2.Status__c = 'Active';
        icfParam2.Status_Cases__c = 'Open';
        icfParam2.Entity__c = 'AMFS';
        icfParam2.Description__c = 'ICF Description'; 
        icfParam2.Channel__c = '0';
        icfParam2.Login_1__c = 'axamii4'; 
        icfParam2.Send_ICF_Flag__c = true;
        icfParam2.Send_Thanks_Note_Flag__c = false;
        icfparam2.CCC_I_Ask_Exculde__c = '(NB/UW) Information Status;Claim Information Status;Complaint Status;Delivery Status;Drop Call;IVR Utilization;Off Line Application';
        insert icfParam2;
        
        
        //System.debug('Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get(Master Qualtrics).getRecordTypeId():'+Schema.SObjectType.Survey__c.getRecordTypeInfosByDeveloperName().get('Master').getRecordTypeId());
        //String recordtypeid = System.label.RecordType_Master_Survey;
        
        Recordtype recordtypeid = [SELECT Id FROM RecordType WHERE SObjectType = 'Survey__c' AND Name = 'Master New Onboarding'];
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Status__c = 'Active';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Survey_Type__c = 'I Ask'; 
        setSurvey.URL__c = 'https://axaid-ccc--fullsb.sandbox.my.salesforce-sites.com/survey/TakeSurveyDynamic?';
        
        setSurvey.RecordTypeId = recordtypeid.Id;
        insert setSurvey;
        
        
        Test.startTest();
        Case cs = new Case();
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject INQ';
        cs.Type = 'Inquiry'; 
        cs.Status = 'New';
        cs.Already_Send_Survey__c = false; 
        insert cs; 
        
        Test.stopTest();
    }
    
    /*
    public static testMethod void insertCaseComplaint2() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ' limit 1];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName' limit 1];
        User adm = [SELECT Id FROM User WHERE LastName = 'ADM' limit 1];
        
        Recordtype rtIcf = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Qualtrics'];
        ICF_Parameter__c icfParam = new ICF_Parameter__c();
        icfParam.RecordTypeId = rtIcf.Id;
        icfParam.Status__c = 'Active';
        icfParam.Status_Cases__c = 'Open';
        icfParam.Entity__c = 'AMFS';
        icfParam.CCC_I_Ask_Exculde__c = 'Request_Reprint Polis Convent';
        icfParam.CCC_I_Complain_Exculde__c = 'Request_Reprint Polis Convent';
        icfParam.Description__c = 'ICF Description'; 
        icfParam.Channel__c = '0';
        icfParam.Login_1__c = 'axamii4'; 
        icfParam.Send_ICF_Flag__c = True;
        icfParam.Send_Thanks_Note_Flag__c = false;
        insert icfParam;
        
        Recordtype rtIcf2 = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - CCC'];
        ICF_Parameter__c icfParam2 = new ICF_Parameter__c();
        icfParam2.RecordTypeId = rtIcf2.Id;
        icfParam2.Status__c = 'Active';
        icfParam2.Status_Cases__c = 'Open';
        icfParam2.Entity__c = 'AMFS';
        icfParam2.Description__c = 'ICF Description'; 
        icfParam2.Channel__c = '0';
        icfParam2.Login_1__c = 'axamii4'; 
        icfParam2.Send_ICF_Flag__c = true;
        icfParam2.Send_Thanks_Note_Flag__c = false;
        icfparam2.CCC_I_Complain_Exculde__c = '(NB/UW) Information Status;Claim Information Status;Complaint Status;Delivery Status;Drop Call;IVR Utilization;Off Line Application';
        insert icfParam2;
        
        String recordtypeid = System.label.RecordType_Master_Survey;
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Status__c = 'Active';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Survey_Type__c = 'I Complain'; 
        
        setSurvey.RecordTypeId = recordtypeid; 
        insert setSurvey;
        
        Test.startTest();
        Case cs = new Case(); 
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject Complain';
        cs.Type = 'Complaint'; 
        cs.Status = 'New';
        cs.Already_Send_Survey__c = false; 
        cs.Entity_Backup__c = 'AMFS';
        cs.PIC_Department_LU__c = UserInfo.getUserId();
        cs.Origin = 'Phone';
        cs.Nature__c = 'Administrator Procedures';
        cs.Category__c = 'CS-Missing document';
        cs.Business_channel__c = 'TM';
        cs.Channel__c = 'Walk-In';
        cs.Complaint_type__c = 'Simple';	
        cs.Product__c = 'TM';
        cs.Customer__c = 'Customer';
        cs.Customer_type__c = 'Regular';
        cs.Complainant__c = 'Customer';
        cs.Received_date__c = system.today();
        cs.Priority = 'Medium';
        cs.Description__c = 'Testing';
        
        insert cs;
        
        
        cs.CHS_Status__c = 'Closed - Valid';
        cs.Complaint_Decision_AMFS__c = 'Approve & Paid';
        cs.Sub_Status__c = 'Approved Paid';
        cs.Case_Error__c = 'No';	
        cs.Complaint_Decision__c = 'Testing';
        cs.Other_Information__c = 'Test';
        cs.Paid_Amount__c = 100000;
        cs.NDA_Date__c = system.Today();
        cs.Reason_Root_Cause__c = 'Testing';
        cs.Corrective_Action__c = 'Testing';
        cs.Conclusion__c = 'Testing';
        cs.ManualClosedCase__c = false;
        cs.Financial_Lost__c = 10000;
        update cs;
        
        Test.stopTest();
    }
    
    public static testMethod void insertCaseComplaint3() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ' limit 1];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName' limit 1];
        User adm = [SELECT Id FROM User WHERE LastName = 'ADM' limit 1];
        
        Recordtype rtIcf = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Qualtrics'];
        ICF_Parameter__c icfParam = new ICF_Parameter__c();
        icfParam.RecordTypeId = rtIcf.Id;
        icfParam.Status__c = 'Active';
        icfParam.Status_Cases__c = 'Open';
        icfParam.Entity__c = 'AMFS';
        icfParam.CCC_I_Ask_Exculde__c = 'Request_Reprint Polis Convent';
        icfParam.CCC_I_Complain_Exculde__c = 'Request_Reprint Polis Convent';
        icfParam.Description__c = 'ICF Description'; 
        icfParam.Channel__c = '0';
        icfParam.Login_1__c = 'axamii4'; 
        icfParam.Send_ICF_Flag__c = True;
        icfParam.Send_Thanks_Note_Flag__c = True;
        insert icfParam;
        
        Recordtype rtIcf2 = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - CCC'];
        ICF_Parameter__c icfParam2 = new ICF_Parameter__c();
        icfParam2.RecordTypeId = rtIcf2.Id;
        icfParam2.Status__c = 'Active';
        icfParam2.Status_Cases__c = 'Open';
        icfParam2.Entity__c = 'AMFS';
        icfParam2.Description__c = 'ICF Description'; 
        icfParam2.Channel__c = '0';
        icfParam2.Login_1__c = 'axamii4'; 
        icfParam2.Send_ICF_Flag__c = true;
        icfParam2.Send_Thanks_Note_Flag__c = True;
        icfparam2.CCC_I_Complain_Exculde__c = '(NB/UW) Information Status;Claim Information Status;Complaint Status;Delivery Status;Drop Call;IVR Utilization;Off Line Application';
        insert icfParam2;
        
        String recordtypeid = System.label.RecordType_Master_Survey;
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Status__c = 'Active';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Survey_Type__c = 'I Complain'; 
        
        setSurvey.RecordTypeId = recordtypeid; 
        insert setSurvey;
        
        Test.startTest();
        Case cs = new Case(); 
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject Complain';
        cs.Type = 'Complaint'; 
        cs.Status = 'New';
        cs.Already_Send_Survey__c = false; 
        cs.Entity_Backup__c = 'AMFS';
        cs.PIC_Department_LU__c = UserInfo.getUserId();
        cs.Origin = 'Phone';
        cs.Nature__c = 'Administrator Procedures';
        cs.Category__c = 'CS-Missing document';
        cs.Business_channel__c = 'TM';
        cs.Channel__c = 'Walk-In';
        cs.Complaint_type__c = 'Simple';	
        cs.Product__c = 'TM';
        cs.Customer__c = 'Customer';
        cs.Customer_type__c = 'Regular';
        cs.Complainant__c = 'Customer';
        cs.Received_date__c = system.today();
        cs.Priority = 'Medium';
        cs.Description__c = 'Testing';
        
        insert cs;
        
        
        cs.CHS_Status__c = 'Closed - Valid';
        cs.Complaint_Decision_AMFS__c = 'Approve & Paid';
        cs.Sub_Status__c = 'Approved Paid';
        cs.Case_Error__c = 'No';	
        cs.Complaint_Decision__c = 'Testing';
        cs.Other_Information__c = 'Test';
        cs.Paid_Amount__c = 100000;
        cs.NDA_Date__c = system.Today();
        cs.Reason_Root_Cause__c = 'Testing';
        cs.Corrective_Action__c = 'Testing';
        cs.Conclusion__c = 'Testing';
        cs.ManualClosedCase__c = false;
        cs.Financial_Lost__c = 10000;
        update cs;
        
        Test.stopTest();
    }
	*/
   
    public static testmethod void createEmailSmsLogWhenCaseClosedTestComplaint() {
        Test.startTest();
        String COMPLAINT = 'Complaint';
        String STATUS = 'Closed';
         
        String userId = UserInfo.getUserId(); 
        User userObj = [Select id,Entity__c from  User WHERE Id = :userId ORDER BY CreatedDate DESC Limit 1];
        String entity = userObj.Entity__c;

        //Contact contact1 = [Select id,AccountId from Contact limit 1];
        //Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ2'];
        Contact contact1 = [SELECT Id, AccountId FROM Contact WHERE LastName = 'LastName2' limit 1];
        
        Case setCase = new Case();
        setCase.ContactId = contact1.Id;
        setCase.Type = COMPLAINT;
        setCase.Status = STATUS;
        setCase.Priority = 'Medium';
        setCase.Origin = 'Phone';
        setCase.Case_Type__c = 'MV Claim Report';
        setCase.Case_Type_Config__c = 'MV Claim Report';
        setCase.PIC_Department_LU__c = UserInfo.getUserId();
        setCase.AccountId = contact1.AccountId;
        setCase.Already_Send_Survey__c = false;
        
        insert setCase; 
        
        Test.stopTest();
    }
    
    
    public static testmethod void createEmailSmsLogWhenCaseClosedTestComplaint2() {
        Test.startTest();
        String COMPLAINT = 'Complaint';
        String STATUS = 'Closed';

        String userId = UserInfo.getUserId(); 
        User userObj = [Select id,Entity__c from  User WHERE Id = :userId ORDER BY CreatedDate DESC Limit 1];
        String entity = userObj.Entity__c;

        Contact contact1 = [SELECT Id, AccountId FROM Contact WHERE LastName = 'LastName2' limit 1];
        
        String RTMasterEmailSMS = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId(); 
        
        ICF_Parameter__c updateICF = [Select id from ICF_Parameter__c where RecordTypeId=: RTMasterEmailSMS and Entity__c =: entity];
        updateICF.Send_ICF_Flag__c = false;
        update updateICF;

        Case setCase = new Case();
        setCase.ContactId = contact1.Id;
        setCase.Type = COMPLAINT;
        setCase.Status = STATUS;
        setCase.Priority = 'Medium';
        setCase.Origin = 'Phone';
        setCase.Case_Type__c = 'MV Claim Report';
        setCase.Case_Type_Config__c = 'MV Claim Report';
        setCase.PIC_Department_LU__c = UserInfo.getUserId();
        setCase.AccountId = contact1.AccountId;
        setCase.Already_Send_Survey__c = false;
        
        insert setCase; 
        
        Test.stopTest();
    }
     
    public static testmethod void createEmailSmsLogWhenCaseClosedTestComplaint3() {
        Test.startTest();
        String COMPLAINT = 'Complaint';
        String STATUS = 'Closed';

        String userId = UserInfo.getUserId(); 
        User userObj = [Select id,Entity__c from  User WHERE Id = :userId ORDER BY CreatedDate DESC Limit 1];
        String entity = userObj.Entity__c;

        Contact contact1 = [SELECT Id, AccountId FROM Contact WHERE LastName = 'LastName2' limit 1];
        
        String RTMasterEmailSMS = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId(); 
        
        ICF_Parameter__c updateICF = [Select id from ICF_Parameter__c where RecordTypeId=: RTMasterEmailSMS and Entity__c =: entity];
        updateICF.Send_Thanks_Note_Flag__c = false;
        update updateICF;

        Case setCase = new Case();
        setCase.ContactId = contact1.Id;
        setCase.Type = COMPLAINT;
        setCase.Status = STATUS;
        setCase.Priority = 'Medium';
        setCase.Origin = 'Phone';
        setCase.Case_Type__c = 'MV Claim Report';
        setCase.Case_Type_Config__c = 'MV Claim Report';
        setCase.PIC_Department_LU__c = UserInfo.getUserId();
        setCase.AccountId = contact1.AccountId;
        setCase.Already_Send_Survey__c = false;
        
        insert setCase; 
        
        Test.stopTest();
    }

    public static testmethod void createEmailSmsLogWhenCaseClosedTestComplaint4() {
        Test.startTest();
        String COMPLAINT = 'Complaint';
        String STATUS = 'New';
         
        String userId = UserInfo.getUserId(); 
        User userObj = [Select id,Entity__c from  User WHERE Id = :userId ORDER BY CreatedDate DESC Limit 1];
        String entity = userObj.Entity__c;

        Contact contact1 = [SELECT Id, AccountId FROM Contact WHERE LastName = 'LastName2' limit 1];
        
        Case setCase = new Case();
        setCase.ContactId = contact1.Id;
        setCase.Type = COMPLAINT;
        setCase.Status = STATUS;
        setCase.Priority = 'Medium';
        setCase.Origin = 'Phone';
        setCase.Case_Type__c = 'MV Claim Report';
        setCase.Case_Type_Config__c = 'MV Claim Report';
        setCase.PIC_Department_LU__c = UserInfo.getUserId();
        setCase.AccountId = contact1.AccountId;
        setCase.Already_Send_Survey__c = false;
        
        insert setCase; 
        
        Test.stopTest();
    }

    public static testmethod void createEmailSmsLogWhenCaseClosedTestComplaint5() {
        Test.startTest();
        String COMPLAINT = 'Complaint';
        String STATUS = 'New';

        String userId = UserInfo.getUserId(); 
        User userObj = [Select id,Entity__c from  User WHERE Id = :userId ORDER BY CreatedDate DESC Limit 1];
        String entity = userObj.Entity__c;

        Contact contact1 = [SELECT Id, AccountId FROM Contact WHERE LastName = 'LastName2' limit 1];
        
        String RTMasterEmailSMS = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId(); 
        
        ICF_Parameter__c updateICF = [Select id from ICF_Parameter__c where RecordTypeId=: RTMasterEmailSMS and Entity__c =: entity];
        updateICF.Send_ICF_Flag__c = false;
        update updateICF;

        Case setCase = new Case();
        setCase.ContactId = contact1.Id;
        setCase.Type = COMPLAINT;
        setCase.Status = STATUS;
        setCase.Priority = 'Medium';
        setCase.Origin = 'Phone';
        setCase.Case_Type__c = 'MV Claim Report';
        setCase.Case_Type_Config__c = 'MV Claim Report';
        setCase.PIC_Department_LU__c = UserInfo.getUserId();
        setCase.AccountId = contact1.AccountId;
        setCase.Already_Send_Survey__c = false;
        
        insert setCase; 
        
        Test.stopTest();
    }
     
    public static testmethod void createEmailSmsLogWhenCaseClosedTestComplaint6() {
        Test.startTest();
        String COMPLAINT = 'Complaint';
        String STATUS = 'New';

        String userId = UserInfo.getUserId(); 
        User userObj = [Select id,Entity__c from  User WHERE Id = :userId ORDER BY CreatedDate DESC Limit 1];
        String entity = userObj.Entity__c;

        Contact contact1 = [SELECT Id, AccountId FROM Contact WHERE LastName = 'LastName2' limit 1];
        
        String RTMasterEmailSMS = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId(); 
        
        ICF_Parameter__c updateICF = [Select id from ICF_Parameter__c where RecordTypeId=: RTMasterEmailSMS and Entity__c =: entity];
        updateICF.Send_Thanks_Note_Flag__c = false;
        update updateICF;

        Case setCase = new Case();
        setCase.ContactId = contact1.Id;
        setCase.Type = COMPLAINT;
        setCase.Status = STATUS;
        setCase.Priority = 'Medium';
        setCase.Origin = 'Phone';
        setCase.Case_Type__c = 'MV Claim Report';
        setCase.Case_Type_Config__c = 'MV Claim Report';
        setCase.PIC_Department_LU__c = UserInfo.getUserId();
        setCase.AccountId = contact1.AccountId;
        setCase.Already_Send_Survey__c = false;
        
        insert setCase; 
        
        Test.stopTest();
    }
    
    public static testmethod void createEmailSmsLogWhenCaseClosedTest14() {
        Test.startTest();
        String INQUIRY = 'Inquiry';
        String REQUEST = 'Request';
        String COMPLAINT = 'Complaint';
        String NEW_STATUS = 'New';
        String CLOSED = 'Closed';
        String RECORD_TYPE_EMAIL_SMS = 'Master - Email & SMS';
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = userObj.Entity__c;
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest14';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com';
        contact1.MobilePhone = '0891667363';
        contact1.Policy_No__c = '77700133';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        EmailSmsLogUtil emailSmsLogutil = new EmailSmsLogUtil();
        ICF_Parameter__c icfParamObj = emailSmsLogutil.getICFParamByRecordType(RECORD_TYPE_EMAIL_SMS, entity);
        //icfParamObj.Send_ICF_Flag__c = false;
        //update icfParamObj;
        
        ICF_Parameter__c icfParamNew = new ICF_Parameter__c();
        icfParamNew = icfParamObj.clone();
        icfParamNew.Send_ICF_Flag__c = false;
        insert icfParamNew;
        
        //CREATED-OPEN | REQUEST =============================================================================
        Case requestCreateOpen = new Case();
        requestCreateOpen.ContactId = contact1.Id;
        requestCreateOpen.Type = REQUEST;
        requestCreateOpen.Status = NEW_STATUS;
        requestCreateOpen.Priority = 'Medium';
        requestCreateOpen.Origin = 'Phone';
        requestCreateOpen.Case_Type__c = 'MV Claim Report';
        requestCreateOpen.Case_Type_Config__c = 'MV Claim Report';
        requestCreateOpen.PIC_Department_LU__c = UserInfo.getUserId();
        requestCreateOpen.AccountId = contact1.AccountId;
        insert requestCreateOpen;
        
        //UPDATED TO CLOSED==============================================================================================
        requestCreateOpen.Status = CLOSED;
        update requestCreateOpen;
        
        Test.stopTest();
    }
    
    public static testmethod void createEmailSmsLogWhenCaseClosedTest17() {
        Test.startTest();
        String INQUIRY = 'Inquiry';
        String REQUEST = 'Request';
        String COMPLAINT = 'Complaint';
        String NEW_STATUS = 'New';
        String CLOSED = 'Closed';
        String RECORD_TYPE_EMAIL_SMS = 'Master - Email & SMS';
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = userObj.Entity__c;
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest172';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill2';
        contact1.LastName = 'Gates2';
        contact1.Email = 'billgates2@email.com';
        contact1.MobilePhone = '08916673632';
        contact1.Policy_No__c = '777001362';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        EmailSmsLogUtil emailSmsLogutil = new EmailSmsLogUtil();
        ICF_Parameter__c icfParamObj = emailSmsLogutil.getICFParamByRecordType(RECORD_TYPE_EMAIL_SMS, entity);
        //icfParamObj.Send_ICF_Flag__c = false;
        //update icfParamObj;
        
        ICF_Parameter__c icfParamNew = new ICF_Parameter__c();
        icfParamNew = icfParamObj.clone();
        icfParamNew.Send_Thanks_Note_Flag__c = false;
        insert icfParamNew;
        
        //CREATED-OPEN | REQUEST =============================================================================
        Case requestCreateOpen = new Case();
        requestCreateOpen.ContactId = contact1.Id;
        requestCreateOpen.Type = REQUEST;
        requestCreateOpen.Status = NEW_STATUS;
        requestCreateOpen.Priority = 'Medium';
        requestCreateOpen.Origin = 'Phone';
        requestCreateOpen.Case_Type__c = 'Request_Claim_Payment';
        requestCreateOpen.Case_Type_Config__c = 'Request_Claim_Payment';
        requestCreateOpen.PIC_Department_LU__c = UserInfo.getUserId();
        requestCreateOpen.AccountId = contact1.AccountId;
        insert requestCreateOpen;
        
        //UPDATED TO CLOSED==============================================================================================
        requestCreateOpen.Status = CLOSED;
        update requestCreateOpen;
                
        Test.stopTest();
    }
    
    public static testmethod void createEmailSmsLogWhenCaseClosedTest4() {
        Test.startTest();
        String INQUIRY = 'Inquiry';
        String REQUEST = 'Request';
        String COMPLAINT = 'Complaint';
        String NEW_STATUS = 'New';
        String CLOSED = 'Closed';
        String RECORD_TYPE_EMAIL_SMS = 'Master - Email & SMS';
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = userObj.Entity__c;
        
        Account ac1 = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ AMFS' limit 1];
        Contact contact1 = [SELECT Id, AccountId FROM Contact WHERE LastName = 'LastName AMFS' limit 1];
        Contact contact2 = [SELECT Id, AccountId FROM Contact WHERE LastName = 'LastName AMFS 2' limit 1];
        
        EmailSmsLogUtil emailSmsLogutil = new EmailSmsLogUtil();
        ICF_Parameter__c icfParamObj = emailSmsLogutil.getICFParamByRecordType(RECORD_TYPE_EMAIL_SMS, entity);
        //icfParamObj.Send_ICF_Flag__c = false;
        //update icfParamObj;
        
        ICF_Parameter__c icfParamNew = new ICF_Parameter__c();
        icfParamNew = icfParamObj.clone();
        icfParamNew.Send_ICF_Flag__c = false;
        insert icfParamNew;
        
        //CREATED-CLOSED | INQUIRY & REQUEST =============================================================================
        Case inquiryCreateClosed = new Case();
        inquiryCreateClosed.ContactId = contact1.Id;
        inquiryCreateClosed.Type = INQUIRY;
        inquiryCreateClosed.Status = CLOSED;
        inquiryCreateClosed.Priority = 'Medium';
        inquiryCreateClosed.Origin = 'Phone';
        inquiryCreateClosed.Case_Type__c = 'Claim Procedure';
        inquiryCreateClosed.Subject = 'Case Subject 23456';
        inquiryCreateClosed.AccountId = contact1.AccountId;
        insert inquiryCreateClosed;
        
        Case requestCreateClosed = new Case();
        requestCreateClosed.ContactId = contact2.Id;
        requestCreateClosed.Type = REQUEST;
        requestCreateClosed.Status = NEW_STATUS;
        requestCreateClosed.Priority = 'Medium';
        requestCreateClosed.Origin = 'Phone';
        requestCreateClosed.Case_Type__c = 'MV Claim Report';
        requestCreateClosed.Case_Type_Config__c = 'MV Claim Report';
        requestCreateClosed.PIC_Department_LU__c = UserInfo.getUserId();
        requestCreateClosed.AccountId = contact2.AccountId;
        insert requestCreateClosed;
        
        Test.stopTest();
    }
    
    public static testmethod void createEmailSmsLogWhenCaseClosedTest7() {
        Test.startTest();
        String INQUIRY = 'Inquiry';
        String REQUEST = 'Request';
        String COMPLAINT = 'Complaint';
        String NEW_STATUS = 'New';
        String CLOSED = 'Closed';
        String RECORD_TYPE_EMAIL_SMS = 'Master - Email & SMS';
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = userObj.Entity__c;
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest7';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill7';
        contact1.LastName = 'Gates7';
        contact1.Email = 'billgates7@email.com';
        contact1.MobilePhone = '08916673637';
        contact1.Policy_No__c = '777001237';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        Contact contact2 = new Contact();
        contact2.FirstName = 'Bill27';
        contact2.LastName = 'Gates27';
        contact2.Email = 'billgates27@email.com';
        contact2.MobilePhone = '089166736327';
        contact2.Policy_No__c = '7770012427';
        contact2.Entity__c = entity;
        contact2.AccountId = ac1.Id;
        insert contact2;
        
        EmailSmsLogUtil emailSmsLogutil = new EmailSmsLogUtil();
        ICF_Parameter__c icfParamObj = emailSmsLogutil.getICFParamByRecordType(RECORD_TYPE_EMAIL_SMS, entity);
        //icfParamObj.Send_Thanks_Note_Flag__c = false;
        //update icfParamObj;
        
        ICF_Parameter__c icfParamNew = new ICF_Parameter__c();
        icfParamNew = icfParamObj.clone();
        icfParamNew.Send_Thanks_Note_Flag__c = false;
        insert icfParamNew;
        
        //CREATED-CLOSED | INQUIRY & REQUEST =============================================================================
        Case inquiryCreateClosed = new Case();
        inquiryCreateClosed.ContactId = contact1.Id;
        inquiryCreateClosed.Type = INQUIRY;
        inquiryCreateClosed.Status = CLOSED;
        inquiryCreateClosed.Priority = 'Medium';
        inquiryCreateClosed.Origin = 'Phone';
        inquiryCreateClosed.Case_Type__c = 'Claim Procedure';
        inquiryCreateClosed.Subject = 'Case Subject 23456';
        inquiryCreateClosed.AccountId = contact1.AccountId;
        insert inquiryCreateClosed;
        
        Case requestCreateClosed = new Case();
        requestCreateClosed.ContactId = contact2.Id;
        requestCreateClosed.Type = REQUEST;
        requestCreateClosed.Status = CLOSED;
        requestCreateClosed.Priority = 'Medium';
        requestCreateClosed.Origin = 'Phone';
        requestCreateClosed.Case_Type__c = 'MV Claim Report';
        requestCreateClosed.Case_Type_Config__c = 'MV Claim Report';
        requestCreateClosed.PIC_Department_LU__c = UserInfo.getUserId();
        requestCreateClosed.AccountId = contact2.AccountId;
        insert requestCreateClosed;
        
        Test.stopTest();
    }
    
    public static testmethod void createEmailSmsLogWhenCaseClosedRequestPOS() {
        Test.startTest();
        String INQUIRY = 'Inquiry';
        String REQUEST = 'Request';
        String REQUEST_POS = 'Request POS';
        String COMPLAINT = 'Complaint';
        String NEW_STATUS = 'New';
        String CLOSED = 'Closed';
        String RECORD_TYPE_EMAIL_SMS = 'Master - Email & SMS';
        
        User userAMFS = new User();
        userAMFS.ProfileId = [SELECT Id FROM Profile WHERE Name = 'CMU-AFI'].Id;
        userAMFS.LastName = 'LN AMFS';
        userAMFS.Email = 'amfsuser@axa.com';
        userAMFS.Username = 'amfsuser@axaxa.com' + System.currentTimeMillis();
        userAMFS.CompanyName = 'AXAX';
        userAMFS.Title = 'user';
        userAMFS.Alias = 'amfsuser';
        userAMFS.TimeZoneSidKey = 'America/Los_Angeles';
        userAMFS.EmailEncodingKey = 'UTF-8';
        userAMFS.LanguageLocaleKey = 'en_US';
        userAMFS.LocaleSidKey = 'en_US';
        userAMFS.Entity__c = 'AMFS';
        insert userAMFS;
        
        User adminAMFS = new User();
        adminAMFS.ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id;
        adminAMFS.LastName = 'ADMIN AMFS';
        adminAMFS.Email = 'admAMFS@axa.com';
        adminAMFS.Username = 'admAMFS@axaxa.com' + System.currentTimeMillis();
        adminAMFS.CompanyName = 'AXAX';
        adminAMFS.Title = 'admuser';
        adminAMFS.Alias = 'admAMFS';
        adminAMFS.TimeZoneSidKey = 'America/Los_Angeles';
        adminAMFS.EmailEncodingKey = 'UTF-8';
        adminAMFS.LanguageLocaleKey = 'en_US';
        adminAMFS.LocaleSidKey = 'en_US';
        adminAMFS.Entity__c = 'AMFS';
        insert adminAMFS;
        
        Recordtype rtIcf = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Email & SMS'];
        ICF_Parameter__c icfParam = new ICF_Parameter__c();
        icfParam.RecordTypeId = rtIcf.Id;
        icfParam.Status__c = 'Active';
        icfParam.Status_Cases__c = 'Closed';
        icfParam.Entity__c = 'AMFS';
        icfParam.Description__c = 'ICF Description';
        icfParam.Send_ICF_Flag__c = true;
        icfParam.Send_Thanks_Note_Flag__c = true;
        insert icfParam;
        
        Account acc = new Account();
        acc.Name = 'Test Account XYZ AMFS';
        acc.Entity__c = 'AMFS';
        insert acc;
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'LastName AMFS';
        con.FirstName = 'FirstName';
        con.Email = 'emailAMFS@domain.com';
        con.MobilePhone = '0812345000';
        con.Policy_No__c = '511-7179000';
        con.Entity__c = 'AMFS';
        insert con;
        
        //======
        
        //String userId = UserInfo.getUserId(); 
        //User userObj = [Select id,Entity__c from  User WHERE Id = :userId ORDER BY CreatedDate DESC Limit 1];
        //String entity = userObj.Entity__c;
        
        //Account ac1 = new Account();
        //ac1.Name = 'Test Account XYZ2';
        //ac1.Entity__c = entity;
        //insert ac1;
        
        //Contact contact1 = new Contact();
        //contact1.FirstName = 'FirstName2';
        //contact1.LastName = 'LastName2';
        //contact1.Email = 'billgates@email.com';
        //contact1.MobilePhone = '0891667363';
        //contact1.Policy_No__c = '77700136';
        //contact1.Entity__c = entity;
        //contact1.AccountId = ac1.Id;
        //insert contact1;
        
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId();
        testICFParam.Interval_Completed_Month__c = '1';
        testICFParam.Entity__c = 'AMFS';
        testICFParam.Status__c = 'Active';
        testICFParam.Send_ICF_Flag__c = true;
        testICFParam.Send_Thanks_Note_Flag__c = true;
        insert testICFParam;
         
        ICF_Parameter__c testICFParam2 = new ICF_Parameter__c();
        testICFParam2.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam2.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Qualtrics').getRecordTypeId();
        testICFParam2.Interval_Completed_Month__c = '1';
        testICFParam2.Entity__c = 'AMFS';
        testICFParam2.Status__c = 'Active';
        testICFParam2.Send_ICF_Flag__c = true;
        testICFParam2.Send_Thanks_Note_Flag__c = true;
        testICFParam2.Status_Cases__c  = 'Closed';
        insert testICFParam2;
        
        //CREATED-CLOSED | REQUEST_POS =============================================================================
        
        Case requestCreateClosed = new Case();
        requestCreateClosed.ContactId = con.Id;
        requestCreateClosed.Type = REQUEST_POS;
        requestCreateClosed.Status = CLOSED;
        requestCreateClosed.Priority = 'Medium';
        requestCreateClosed.Origin = 'Phone';
        requestCreateClosed.Case_Type__c = 'Request_POS_Withdrawal';
        requestCreateClosed.Case_Type_Config__c = 'Request_POS_Withdrawal';
        requestCreateClosed.PIC_Department_LU__c = UserInfo.getUserId();
        requestCreateClosed.AccountId = con.AccountId;
        insert requestCreateClosed;
        
        Test.stopTest();
    }
}