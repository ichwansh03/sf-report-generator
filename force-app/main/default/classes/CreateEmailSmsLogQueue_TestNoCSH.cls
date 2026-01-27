@isTest
public class CreateEmailSmsLogQueue_TestNoCSH {
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
    }
    
    
    public static testMethod void insertCaseInquiry() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ'];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        
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
        
        System.debug('Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get(Master Qualtrics).getRecordTypeId():'+Schema.SObjectType.Survey__c.getRecordTypeInfosByDeveloperName().get('Master').getRecordTypeId());
        
        String recordtypeid = System.label.RecordType_Master_Survey;
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Status__c = 'Active';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Survey_Type__c = 'I Ask'; 
        
        setSurvey.RecordTypeId = recordtypeid; 
        insert setSurvey;
        
        
        Test.startTest();
        Case cs = new Case();
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject INQ';
        cs.Description = 'Testing';
        cs.Origin = 'Phone';
        cs.Type = 'Inquiry'; 
        cs.Status = 'Closed';
        cs.Already_Send_Survey__c = false; 
        insert cs; 
        system.debug('entity log queue case: '+cs.Entity__c);
        
        System.enqueueJob(new CreateEmailSmsLogQueue(cs));
        
        Test.stopTest();
    }
    
    public static testMethod void insertCaseInquiry2() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ'];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        
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
        icfParam.Send_Thanks_Note_Flag__c = true;
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
        
        System.debug('Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get(Master Qualtrics).getRecordTypeId():'+Schema.SObjectType.Survey__c.getRecordTypeInfosByDeveloperName().get('Master').getRecordTypeId());
        
        String recordtypeid = System.label.RecordType_Master_Survey;
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Status__c = 'Active';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Survey_Type__c = 'I Ask'; 
        
        setSurvey.RecordTypeId = recordtypeid; 
        insert setSurvey;
        
        
        Test.startTest();
        Case cs = new Case();
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject INQ 2';
        cs.Description = 'Testing 2';
        cs.Origin = 'Email';
        cs.Type = 'Inquiry'; 
        cs.Status = 'Closed';
        cs.Already_Send_Survey__c = false; 
        insert cs; 
        
        System.enqueueJob(new CreateEmailSmsLogQueue(cs));
        
        Test.stopTest();
    }
    
    public static testMethod void insertCaseRequest() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ'];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User pic = [SELECT Id FROM User WHERE LastName = 'ADM'];
        
        ICF_Parameter__c icfParam = new ICF_Parameter__c();
        icfParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        icfParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId();
        icfParam.Interval_Completed_Month__c = '1';
        icfParam.Entity__c = 'AMFS';
        icfParam.Status__c = 'Active';
        icfParam.Send_ICF_Flag__c = true;
        icfParam.Send_Thanks_Note_Flag__c = true;
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
        icfParam2.Send_ICF_Flag__c = false;
        icfParam2.Send_Thanks_Note_Flag__c = true;
        icfparam2.CCC_I_Ask_Exculde__c = '(NB/UW) Information Status;Claim Information Status;Complaint Status;Delivery Status;Drop Call;IVR Utilization;Off Line Application';
        insert icfParam2;
        
        System.debug('Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get(Master Qualtrics).getRecordTypeId():'+Schema.SObjectType.Survey__c.getRecordTypeInfosByDeveloperName().get('Master').getRecordTypeId());
        
        String recordtypeid = System.label.RecordType_Master_Survey;
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Status__c = 'Active';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Survey_Type__c = 'I Ask'; 
        
        setSurvey.RecordTypeId = recordtypeid; 
        insert setSurvey;
        
        
        Test.startTest();
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.AccountId = a.Id;
        cs.Type = 'Request';
        cs.Status = 'Closed';
        cs.Priority = 'Medium';
        cs.Origin = 'Phone';
        cs.Case_Type__c = 'Request_Claim_Payment';
        cs.Case_Type_Config__c = 'Request_Claim_Payment';
        cs.Subject = 'Subject REQ';
        cs.Description = 'Testing';
        cs.Already_Send_Survey__c = false;
        cs.PIC_Department_LU__c = pic.Id;
        insert cs;
        
        System.enqueueJob(new CreateEmailSmsLogQueue(cs));
        
        Test.stopTest();
    }
    
    public static testMethod void insertCaseRequest2() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ'];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User pic = [SELECT Id FROM User WHERE LastName = 'ADM'];
        
        ICF_Parameter__c icfParam = new ICF_Parameter__c();
        icfParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        icfParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId();
        icfParam.Interval_Completed_Month__c = '1';
        icfParam.Entity__c = 'AMFS';
        icfParam.Status__c = 'Active';
        icfParam.Send_ICF_Flag__c = true;
        icfParam.Send_Thanks_Note_Flag__c = true;
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
        icfParam2.Send_ICF_Flag__c = false;
        icfParam2.Send_Thanks_Note_Flag__c = true;
        icfparam2.CCC_I_Ask_Exculde__c = '(NB/UW) Information Status;Claim Information Status;Complaint Status;Delivery Status;Drop Call;IVR Utilization;Off Line Application';
        insert icfParam2;
        
        System.debug('Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get(Master Qualtrics).getRecordTypeId():'+Schema.SObjectType.Survey__c.getRecordTypeInfosByDeveloperName().get('Master').getRecordTypeId());
        
        String recordtypeid = System.label.RecordType_Master_Survey;
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Status__c = 'Active';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Survey_Type__c = 'I Ask'; 
        
        setSurvey.RecordTypeId = recordtypeid; 
        insert setSurvey;
        
        
        Test.startTest();
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.AccountId = a.Id;
        cs.Type = 'Request';
        cs.Status = 'New';
        cs.Priority = 'Medium';
        cs.Origin = 'Phone';
        cs.Case_Type__c = 'Request_Claim_Payment';
        cs.Case_Type_Config__c = 'Request_Claim_Payment';
        cs.Subject = 'Subject REQ';
        cs.Description = 'Testing';
        cs.Already_Send_Survey__c = false;
        cs.PIC_Department_LU__c = pic.Id;
        insert cs;
        
        System.enqueueJob(new CreateEmailSmsLogQueue(cs));
        
        Test.stopTest();
    }
    
    public static testMethod void insertCaseRequest3() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ'];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User pic = [SELECT Id FROM User WHERE LastName = 'ADM'];
        
        ICF_Parameter__c icfParam = new ICF_Parameter__c();
        icfParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        icfParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId();
        icfParam.Interval_Completed_Month__c = '1';
        icfParam.Entity__c = 'AMFS';
        icfParam.Status__c = 'Active';
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
        icfParam2.Send_ICF_Flag__c = false;
        icfParam2.Send_Thanks_Note_Flag__c = true;
        icfparam2.CCC_I_Ask_Exculde__c = '(NB/UW) Information Status;Claim Information Status;Complaint Status;Delivery Status;Drop Call;IVR Utilization;Off Line Application';
        insert icfParam2;
        
        System.debug('Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get(Master Qualtrics).getRecordTypeId():'+Schema.SObjectType.Survey__c.getRecordTypeInfosByDeveloperName().get('Master').getRecordTypeId());
        
        String recordtypeid = System.label.RecordType_Master_Survey;
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Status__c = 'Active';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Survey_Type__c = 'I Ask'; 
        
        setSurvey.RecordTypeId = recordtypeid; 
        insert setSurvey;
        
        
        Test.startTest();
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.AccountId = a.Id;
        cs.Type = 'Request';
        cs.Status = 'New';
        cs.Priority = 'Medium';
        cs.Origin = 'Phone';
        cs.Case_Type__c = 'Request_Claim_Payment';
        cs.Case_Type_Config__c = 'Request_Claim_Payment';
        cs.Subject = 'Subject REQ';
        cs.Description = 'Testing';
        cs.Already_Send_Survey__c = false;
        cs.PIC_Department_LU__c = pic.Id;
        insert cs;
        
        System.enqueueJob(new CreateEmailSmsLogQueue(cs));
        
        Test.stopTest();
    }
    
    public static testMethod void insertCaseComplaint() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ'];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        
        ICF_Parameter__c icfParam = new ICF_Parameter__c();
        icfParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        icfParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Qualtrics').getRecordTypeId();
        icfParam.Interval_Completed_Month__c = '1';
        icfParam.Entity__c = 'AMFS';
        icfParam.Status__c = 'Active';
        icfParam.Send_ICF_Flag__c = true;
        icfParam.Send_Thanks_Note_Flag__c = true;
        insert icfParam;
        
        Recordtype rtIcf2 = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Qualtrics'];
        ICF_Parameter__c icfParam2 = new ICF_Parameter__c();
        icfParam2.RecordTypeId = rtIcf2.Id;
        icfParam2.Status__c = 'Active';
        icfParam2.Status_Cases__c = 'Open';
        icfParam2.Entity__c = 'AMFS';
        icfParam2.Description__c = 'ICF Description'; 
        icfParam2.Channel__c = '0';
        icfParam2.Login_1__c = 'axamii4'; 
        icfParam2.Send_ICF_Flag__c = false;
        icfParam2.Send_Thanks_Note_Flag__c = true;
        icfparam2.CCC_I_Ask_Exculde__c = '(NB/UW) Information Status;Claim Information Status;Complaint Status;Delivery Status;Drop Call;IVR Utilization;Off Line Application';
        insert icfParam2;
        
        System.debug('Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get(Master Qualtrics).getRecordTypeId():'+Schema.SObjectType.Survey__c.getRecordTypeInfosByDeveloperName().get('Master').getRecordTypeId());
        
        String recordtypeid = System.label.RecordType_Master_Survey;
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Status__c = 'Active';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Survey_Type__c = 'I Ask'; 
        
        setSurvey.RecordTypeId = recordtypeid; 
        insert setSurvey;
        
        
        Test.startTest();
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.AccountId = a.Id;
        cs.Type = 'Complaint';
        cs.Status = 'Closed';
        cs.Priority = 'Medium';
        cs.Origin = 'Phone';
        cs.Subject = 'Subject REQ';
        cs.Already_Send_Survey__c = false;
        cs.CHS_Status__c = 'Closed - Invalid';
        cs.Complaint_Decision_AMFS__c = 'Invalid & Paid';
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
        
        System.enqueueJob(new CreateEmailSmsLogQueue(cs));
        
        Test.stopTest();
    }
    
    public static testMethod void insertCaseComplaint2() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ'];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        
        ICF_Parameter__c icfParam = new ICF_Parameter__c();
        icfParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        icfParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Qualtrics').getRecordTypeId();
        icfParam.Interval_Completed_Month__c = '1';
        icfParam.Entity__c = 'AMFS';
        icfParam.Status__c = 'Active';
        icfParam.Send_ICF_Flag__c = false;
        icfParam.Send_Thanks_Note_Flag__c = true;
        insert icfParam;
        
        Recordtype rtIcf2 = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Qualtrics'];
        ICF_Parameter__c icfParam2 = new ICF_Parameter__c();
        icfParam2.RecordTypeId = rtIcf2.Id;
        icfParam2.Status__c = 'Active';
        icfParam2.Status_Cases__c = 'Open';
        icfParam2.Entity__c = 'AMFS';
        icfParam2.Description__c = 'ICF Description'; 
        icfParam2.Channel__c = '0';
        icfParam2.Login_1__c = 'axamii4'; 
        icfParam2.Send_ICF_Flag__c = false;
        icfParam2.Send_Thanks_Note_Flag__c = true;
        icfparam2.CCC_I_Ask_Exculde__c = '(NB/UW) Information Status;Claim Information Status;Complaint Status;Delivery Status;Drop Call;IVR Utilization;Off Line Application';
        insert icfParam2;
        
        System.debug('Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get(Master Qualtrics).getRecordTypeId():'+Schema.SObjectType.Survey__c.getRecordTypeInfosByDeveloperName().get('Master').getRecordTypeId());
        
        String recordtypeid = System.label.RecordType_Master_Survey;
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Status__c = 'Active';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Survey_Type__c = 'I Ask'; 
        
        setSurvey.RecordTypeId = recordtypeid; 
        insert setSurvey;
        
        
        Test.startTest();
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.AccountId = a.Id;
        cs.Type = 'Complaint';
        cs.Status = 'Closed';
        cs.Priority = 'Medium';
        cs.Origin = 'Phone';
        cs.Subject = 'Subject REQ';
        cs.Already_Send_Survey__c = false;
        cs.CHS_Status__c = 'Closed - Invalid';
        cs.Complaint_Decision_AMFS__c = 'Invalid & Paid';
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
        
        System.enqueueJob(new CreateEmailSmsLogQueue(cs));
        
        Test.stopTest();
    }
    
    public static testMethod void insertCaseComplaint3() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ'];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        
        ICF_Parameter__c icfParam = new ICF_Parameter__c();
        icfParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        icfParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Qualtrics').getRecordTypeId();
        icfParam.Interval_Completed_Month__c = '1';
        icfParam.Entity__c = 'AMFS';
        icfParam.Status__c = 'Active';
        icfParam.Send_ICF_Flag__c = true;
        icfParam.Send_Thanks_Note_Flag__c = false;
        insert icfParam;
        
        Recordtype rtIcf2 = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Qualtrics'];
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
        
        System.debug('Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get(Master Qualtrics).getRecordTypeId():'+Schema.SObjectType.Survey__c.getRecordTypeInfosByDeveloperName().get('Master').getRecordTypeId());
        
        String recordtypeid = System.label.RecordType_Master_Survey;
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Status__c = 'Active';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Survey_Type__c = 'I Ask'; 
        
        setSurvey.RecordTypeId = recordtypeid; 
        insert setSurvey;
        
        
        Test.startTest();
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.AccountId = a.Id;
        cs.Type = 'Complaint';
        cs.Status = 'Closed';
        cs.Priority = 'Medium';
        cs.Origin = 'Phone';
        cs.Subject = 'Subject REQ';
        cs.Already_Send_Survey__c = false;
        cs.CHS_Status__c = 'Closed - Invalid';
        cs.Complaint_Decision_AMFS__c = 'Invalid & Paid';
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
        
        System.enqueueJob(new CreateEmailSmsLogQueue(cs));
        
        Test.stopTest();
    }
    
    public static testMethod void insertCaseInquiryOpen() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ'];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        
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
        icfParam.Send_Thanks_Note_Flag__c = true;
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
        icfParam2.Send_Thanks_Note_Flag__c = true;
        icfparam2.CCC_I_Ask_Exculde__c = '(NB/UW) Information Status;Claim Information Status;Complaint Status;Delivery Status;Drop Call;IVR Utilization;Off Line Application';
        insert icfParam2;
        
        System.debug('Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get(Master Qualtrics).getRecordTypeId():'+Schema.SObjectType.Survey__c.getRecordTypeInfosByDeveloperName().get('Master').getRecordTypeId());
        
        String recordtypeid = System.label.RecordType_Master_Survey;
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Status__c = 'Active';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Survey_Type__c = 'I Ask'; 
        
        setSurvey.RecordTypeId = recordtypeid; 
        insert setSurvey;
        
        
        Test.startTest();
        Case cs = new Case();
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject INQ';
        cs.Description = 'Testing';
        cs.Origin = 'Phone';
        cs.Type = 'Inquiry'; 
        cs.Status = 'Open';
        cs.Already_Send_Survey__c = false; 
        insert cs; 
        system.debug('entity log queue case: '+cs.Entity__c);
        
        System.enqueueJob(new CreateEmailSmsLogQueue(cs));
        
        Test.stopTest();
    }
    
    public static testMethod void insertCaseInquiryOpen2() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ'];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        
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
        icfParam.Send_Thanks_Note_Flag__c = true;
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
        icfParam2.Send_ICF_Flag__c = false;
        icfParam2.Send_Thanks_Note_Flag__c = true;
        icfparam2.CCC_I_Ask_Exculde__c = '(NB/UW) Information Status;Claim Information Status;Complaint Status;Delivery Status;Drop Call;IVR Utilization;Off Line Application';
        insert icfParam2;
        
        System.debug('Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get(Master Qualtrics).getRecordTypeId():'+Schema.SObjectType.Survey__c.getRecordTypeInfosByDeveloperName().get('Master').getRecordTypeId());
        
        String recordtypeid = System.label.RecordType_Master_Survey;
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Status__c = 'Active';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Survey_Type__c = 'I Ask'; 
        
        setSurvey.RecordTypeId = recordtypeid; 
        insert setSurvey;
        
        
        Test.startTest();
        Case cs = new Case();
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject INQ';
        cs.Description = 'Testing';
        cs.Origin = 'Phone';
        cs.Type = 'Inquiry'; 
        cs.Status = 'Open';
        cs.Already_Send_Survey__c = false; 
        insert cs; 
        system.debug('entity log queue case: '+cs.Entity__c);
        
        System.enqueueJob(new CreateEmailSmsLogQueue(cs));
        
        Test.stopTest();
    }
    
    public static testMethod void insertCaseInquiryOpen3() {
        Account a = [SELECT Id FROM Account WHERE Name = 'Test Account XYZ'];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        
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
        
        System.debug('Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get(Master Qualtrics).getRecordTypeId():'+Schema.SObjectType.Survey__c.getRecordTypeInfosByDeveloperName().get('Master').getRecordTypeId());
        
        String recordtypeid = System.label.RecordType_Master_Survey;
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Status__c = 'Active';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Survey_Type__c = 'I Ask'; 
        
        setSurvey.RecordTypeId = recordtypeid; 
        insert setSurvey;
        
        
        Test.startTest();
        Case cs = new Case();
        cs.AccountId = a.Id;
        cs.ContactId = c.Id;
        cs.Subject = 'Subject INQ';
        cs.Description = 'Testing';
        cs.Origin = 'Phone';
        cs.Type = 'Inquiry'; 
        cs.Status = 'Open';
        cs.Already_Send_Survey__c = false; 
        insert cs; 
        system.debug('entity log queue case: '+cs.Entity__c);
        
        System.enqueueJob(new CreateEmailSmsLogQueue(cs));
        
        Test.stopTest();
    }
}