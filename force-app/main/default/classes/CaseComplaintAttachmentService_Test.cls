@IsTest
private class CaseComplaintAttachmentService_Test {

    static testmethod void testUpdateAttachmentStatus() {
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

        String attFilename = CaseComplaintAttachmentService.ATT_SUBMITTED.replaceAll(CaseComplaintAttachmentService.DELIMITER, '');
        attFilename += CaseComplaintAttachmentService.DELIMITER + 'KTP'.replaceAll(CaseComplaintAttachmentService.DELIMITER, '');
        attFilename += CaseComplaintAttachmentService.DELIMITER + '520-1877777'.replaceAll(CaseComplaintAttachmentService.DELIMITER, '');
        String timestampStr1 = System.now().format('yyyyMMddHHmmss');
        String filename1 = attFilename + CaseComplaintAttachmentService.DELIMITER + timestampStr1 + '.jpg';

        Attachment attObj = new Attachment();
        attObj.ParentId = caseObj.Id;
        attObj.Name = filename1;
        attObj.IsPrivate = false;
        attObj.ContentType = 'image/jpeg';
        attObj.Body = Blob.valueOf('blob-contents-of-ktp');
        attObj.Description = 'KTP';
        insert attObj;

        String timestampStr2 = System.now().format('yyyyMMddHHmmss');
        String filename2 = attFilename + CaseComplaintAttachmentService.DELIMITER + timestampStr2 + '.jpg';

        Attachment attObj2 = new Attachment();
        attObj2.ParentId = caseObj.Id;
        attObj2.Name = filename2;
        attObj2.IsPrivate = false;
        attObj2.ContentType = 'image/jpeg';
        attObj2.Body = Blob.valueOf('blob-contents-of-ktp');
        attObj2.Description = 'KTP';
        insert attObj2;

        Test.stopTest();
    }
}