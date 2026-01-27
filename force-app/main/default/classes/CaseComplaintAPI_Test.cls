@IsTest
private class CaseComplaintAPI_Test {

    static testmethod void testGetCaseHistoryWithContact() {
        Test.startTest();
        Account accObj = new Account();
        accObj.Name = 'Account AMFS';
        accObj.Entity__c = 'AMFS';
        insert accObj;
        
        Contact contactObj = new Contact();
        contactObj.AccountId = accObj.Id;
        contactObj.LastName = 'Person A';
        contactObj.Phone = '+6281000000013';
        contactObj.Email = 'persona@email.test';
        contactObj.Policy_No__c = '520-1877777';
        contactObj.Insured_Name__c = 'Person A';
        contactObj.Priority_Customer__c = 'No';
        contactObj.Policy_Effective_Date__c = Date.today().addDays(-10);
        contactObj.Cust_Segmentation__c = 'Regular';
        contactObj.MobilePhone = '+6281000000013';
        contactObj.Entity__c = 'AMFS';
        contactObj.Sensitive_Customer__c = 'YES';
        insert contactObj;
        
        Id entitlementProcessId = [SELECT Id FROM SlaProcess WHERE SObjectType = 'Case' AND Name LIKE '%Entitlement%' ORDER BY CreatedDate DESC LIMIT 1].Id;

        Entitlement ent = new Entitlement();
        ent.AccountId = accObj.Id;
        ent.SLAProcessId = entitlementProcessId;
        ent.Name = 'Entitlement AMFS';
        insert ent;

        Case caseObj = new Case();
        caseObj.ContactId = contactObj.Id;
        caseObj.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('AMFSComplaintCase').getRecordTypeId();
        caseObj.CHS_Status__c = 'Revised';
        caseObj.Status = 'Escalated';
        caseObj.Origin = 'SMART FA';
        caseObj.Type = 'Complaint';
        caseObj.Cust_Segmentation__c = 'Regular';
        caseObj.Case_Sensitive_Customer__c = 'YES';
        caseObj.Occupation__c = 'PNS';
        caseObj.EntitlementId = ent.Id;
        caseObj.Nature_Config__c = 'Service Provide By 3rd Parties';
        caseObj.Category_Config__c = 'CS-3rd parties related';
        caseObj.Business_channel__c = 'TM';
        caseObj.Channel__c = 'Verbal (Call)';
        caseObj.Priority = 'High';
        caseObj.Customer_Signature_Date__c = Date.today();
        caseObj.Delivery_Tracking__c = 'Policy';
        caseObj.Customer__c = 'Customer';
        caseObj.Customer_type__c = 'Regular';
        caseObj.Complainant__c = 'Customer';
        caseObj.Received_date__c = Date.today();
        caseObj.Complaint_type__c = 'Complex Case';
        caseObj.Product__c = 'TM';
        caseObj.Policy_Number__c = '520-1877777';
        insert caseObj;

        Case caseCreated = CaseComplaintAPI.getCaseById(caseObj.Id);
        RestRequest restReq = new RestRequest();
        restReq.addParameter('policy_no', '520-1877777');
        RestResponse restResp = new RestResponse();
        RestContext.request = restReq;
        RestContext.response = restResp;
        CaseComplaintAPI.CaseModel cm = CaseComplaintAPI.getCaseHistory();
        System.assert(cm.contactObj != null);
        System.assert(cm.cases != null && cm.cases.size() > 0);
        Test.stopTest();
    }

    static testmethod void testGetCaseHistoryWithAnonymous() {
        Test.startTest();
        Account accObj = new Account();
        accObj.Name = 'Account AMFS';
        accObj.Entity__c = 'AMFS';
        insert accObj;
        
        Contact contactObj = new Contact();
        contactObj.AccountId = accObj.Id;
        contactObj.LastName = 'Anonymous AMFS';
        contactObj.Email = 'anonymous@email.test';
        contactObj.Insured_Name__c = 'Anonymous AMFS';
        contactObj.Priority_Customer__c = 'No';
        contactObj.Policy_Effective_Date__c = Date.today().addDays(-10);
        contactObj.Entity__c = 'AMFS';
        contactObj.Sensitive_Customer__c = 'YES';
        insert contactObj;
        
        Id entitlementProcessId = [SELECT Id FROM SlaProcess WHERE SObjectType = 'Case' AND Name LIKE '%Entitlement%' ORDER BY CreatedDate DESC LIMIT 1].Id;

        Entitlement ent = new Entitlement();
        ent.AccountId = accObj.Id;
        ent.SLAProcessId = entitlementProcessId;
        ent.Name = 'Entitlement AMFS';
        insert ent;

        Case caseObj = new Case();
        caseObj.ContactId = contactObj.Id;
        caseObj.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('AMFSComplaintCase').getRecordTypeId();
        caseObj.CHS_Status__c = 'Revised';
        caseObj.Status = 'Escalated';
        caseObj.Origin = 'SMART FA';
        caseObj.Type = 'Complaint';
        caseObj.Cust_Segmentation__c = 'Regular';
        caseObj.Case_Sensitive_Customer__c = 'YES';
        caseObj.Occupation__c = 'PNS';
        caseObj.EntitlementId = ent.Id;
        caseObj.Nature_Config__c = 'Service Provide By 3rd Parties';
        caseObj.Category_Config__c = 'CS-3rd parties related';
        caseObj.Business_channel__c = 'TM';
        caseObj.Channel__c = 'Verbal (Call)';
        caseObj.Priority = 'High';
        caseObj.Customer_Signature_Date__c = Date.today();
        caseObj.Delivery_Tracking__c = 'Policy';
        caseObj.Customer__c = 'Customer';
        caseObj.Customer_type__c = 'Regular';
        caseObj.Complainant__c = 'Customer';
        caseObj.Received_date__c = Date.today();
        caseObj.Complaint_type__c = 'Complex Case';
        caseObj.Product__c = 'TM';
        caseObj.Policy_Number__c = '520-1877777';
        insert caseObj;

        Case caseCreated = CaseComplaintAPI.getCaseById(caseObj.Id);
        RestRequest restReq = new RestRequest();
        restReq.addParameter('policy_no', '520-1877777');
        RestResponse restResp = new RestResponse();
        RestContext.request = restReq;
        RestContext.response = restResp;
        CaseComplaintAPI.CaseModel cm = CaseComplaintAPI.getCaseHistory();
        System.assert(cm.contactObj != null);
        System.assert(cm.cases != null && cm.cases.size() > 0);
        Test.stopTest();
    }

    static testmethod void testAddCase() {
        Test.startTest();
        Account accObj = new Account();
        accObj.Name = 'Account AMFS';
        accObj.Entity__c = 'AMFS';
        insert accObj;
        
        Contact contactObj = new Contact();
        contactObj.AccountId = accObj.Id;
        contactObj.LastName = 'Person A';
        contactObj.Phone = '+6281000000013';
        contactObj.Email = 'persona@email.test';
        contactObj.Policy_No__c = '520-1877777';
        contactObj.Insured_Name__c = 'Person A';
        contactObj.Priority_Customer__c = 'No';
        contactObj.Policy_Effective_Date__c = Date.today().addDays(-10);
        contactObj.Cust_Segmentation__c = 'Regular';
        contactObj.MobilePhone = '+6281000000013';
        contactObj.Entity__c = 'AMFS';
        contactObj.Sensitive_Customer__c = 'YES';
        insert contactObj;
        
        Id entitlementProcessId = [SELECT Id FROM SlaProcess WHERE SObjectType = 'Case' AND Name LIKE '%Entitlement%' ORDER BY CreatedDate DESC LIMIT 1].Id;

        Entitlement ent = new Entitlement();
        ent.AccountId = accObj.Id;
        ent.SLAProcessId = entitlementProcessId;
        ent.Name = 'Entitlement AMFS';
        insert ent;

        Case caseObj = new Case();
        caseObj.ContactId = contactObj.Id;
        caseObj.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('AMFSComplaintCase').getRecordTypeId();
        caseObj.CHS_Status__c = 'Revised';
        caseObj.Status = 'Escalated';
        caseObj.Origin = 'SMART FA';
        caseObj.Type = 'Complaint';
        caseObj.Cust_Segmentation__c = 'Regular';
        caseObj.Case_Sensitive_Customer__c = 'YES';
        caseObj.Occupation__c = 'PNS';
        caseObj.EntitlementId = ent.Id;
        caseObj.Nature_Config__c = 'Service Provide By 3rd Parties';
        caseObj.Category_Config__c = 'CS-3rd parties related';
        caseObj.Business_channel__c = 'TM';
        caseObj.Channel__c = 'Verbal (Call)';
        caseObj.Priority = 'High';
        caseObj.Customer_Signature_Date__c = Date.today();
        caseObj.Delivery_Tracking__c = 'Policy';
        caseObj.Customer__c = 'Customer';
        caseObj.Customer_type__c = 'Regular';
        caseObj.Complainant__c = 'Customer';
        caseObj.Received_date__c = Date.today();
        caseObj.Complaint_type__c = 'Complex Case';
        caseObj.Product__c = 'TM';
        caseObj.Policy_Number__c = '520-1877777';
        CaseComplaintAPI.CaseResponse cr = CaseComplaintAPI.addCase(caseObj);
        System.assertEquals(true, cr.success);
        System.assert(String.isNotBlank(cr.case_id));
        Test.stopTest();
    }

    static testmethod void testUpdateCase() {
        Test.startTest();
        Account accObj = new Account();
        accObj.Name = 'Account AMFS';
        accObj.Entity__c = 'AMFS';
        insert accObj;
        
        Contact contactObj = new Contact();
        contactObj.AccountId = accObj.Id;
        contactObj.LastName = 'Person A';
        contactObj.Phone = '+6281000000013';
        contactObj.Email = 'persona@email.test';
        contactObj.Policy_No__c = '520-1877777';
        contactObj.Insured_Name__c = 'Person A';
        contactObj.Priority_Customer__c = 'No';
        contactObj.Policy_Effective_Date__c = Date.today().addDays(-10);
        contactObj.Cust_Segmentation__c = 'Regular';
        contactObj.MobilePhone = '+6281000000013';
        contactObj.Entity__c = 'AMFS';
        contactObj.Sensitive_Customer__c = 'YES';
        insert contactObj;
        
        Id entitlementProcessId = [SELECT Id FROM SlaProcess WHERE SObjectType = 'Case' AND Name LIKE '%Entitlement%' ORDER BY CreatedDate DESC LIMIT 1].Id;

        Entitlement ent = new Entitlement();
        ent.AccountId = accObj.Id;
        ent.SLAProcessId = entitlementProcessId;
        ent.Name = 'Entitlement AMFS';
        insert ent;

        Case caseObj = new Case();
        caseObj.ContactId = contactObj.Id;
        caseObj.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('AMFSComplaintCase').getRecordTypeId();
        caseObj.CHS_Status__c = 'Revised';
        caseObj.Status = 'Escalated';
        caseObj.Origin = 'SMART FA';
        caseObj.Type = 'Complaint';
        caseObj.Cust_Segmentation__c = 'Regular';
        caseObj.Case_Sensitive_Customer__c = 'YES';
        caseObj.Occupation__c = 'PNS';
        caseObj.EntitlementId = ent.Id;
        caseObj.Nature_Config__c = 'Service Provide By 3rd Parties';
        caseObj.Category_Config__c = 'CS-3rd parties related';
        caseObj.Business_channel__c = 'TM';
        caseObj.Channel__c = 'Verbal (Call)';
        caseObj.Priority = 'High';
        caseObj.Customer_Signature_Date__c = Date.today();
        caseObj.Delivery_Tracking__c = 'Policy';
        caseObj.Customer__c = 'Customer';
        caseObj.Customer_type__c = 'Regular';
        caseObj.Complainant__c = 'Customer';
        caseObj.Received_date__c = Date.today();
        caseObj.Complaint_type__c = 'Complex Case';
        caseObj.Product__c = 'TM';
        caseObj.Policy_Number__c = '520-1877777';
        insert caseObj;

        CaseComplaintAPI.CaseRequest cReq = new CaseComplaintAPI.CaseRequest();
        cReq.existing_case = new Map<String, Object>();
        CaseComplaintAPI.SyncAttachmentRequest saReq = new CaseComplaintAPI.SyncAttachmentRequest();
        saReq.parent_id = caseObj.Id;
        CaseComplaintAPI.SyncAttachmentResponse saRes = new CaseComplaintAPI.SyncAttachmentResponse();
        saRes.success = true;
        saRes.errors = null;
        saRes.parent_id = caseObj.Id;
        Case caseCreated = CaseComplaintAPI.getCaseById(caseObj.Id);
        CaseComplaintAPI.CaseResponse cr = CaseComplaintAPI.addCase(caseCreated);
        System.assertEquals(true, cr.success);
        System.assert(String.isNotBlank(cr.case_id));
        Test.stopTest();
    }
}