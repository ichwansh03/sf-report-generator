@IsTest
private class CaseComplaintViewAttachment_Test {

    public class MockGetAttachments implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();

            Account accObj = new Account();
            accObj.Name = 'Account AMFS';
            accObj.Entity__c = 'AMFS';
            insert accObj;
            
            Contact contactObj = new Contact();
            contactObj.AccountId = accObj.Id;
            contactObj.LastName = 'Person B';
            contactObj.Phone = '+6281000000014';
            contactObj.Email = 'personb@email.test';
            contactObj.Policy_No__c = '520-1877778';
            contactObj.Insured_Name__c = 'Person B';
            contactObj.Priority_Customer__c = 'No';
            contactObj.Policy_Effective_Date__c = Date.today().addDays(-10);
            contactObj.Cust_Segmentation__c = 'Regular';
            contactObj.MobilePhone = '+6281000000014';
            contactObj.Entity__c = 'AMFS';
            contactObj.Sensitive_Customer__c = 'YES';
            insert contactObj;
            
            /*
            Id entitlementProcessId = [SELECT Id FROM SlaProcess WHERE SObjectType = 'Case' AND Name LIKE '%Entitlement%' ORDER BY CreatedDate DESC LIMIT 1].Id;

            Entitlement ent = new Entitlement();
            ent.AccountId = accObj.Id;
            ent.SLAProcessId = entitlementProcessId;
            ent.Name = 'Entitlement AMFS';
            insert ent;
			*/

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
            //caseObj.EntitlementId = ent.Id;
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
            
            List<Attachment> attList = new List<Attachment>();
            Attachment attObj = new Attachment();
            attObj.Name = '[v]_KTP_513-8049944_20210507141201.jpg';
            attObj.ParentId = caseObj.Id;
            attObj.IsPrivate = false;
            attObj.ContentType = 'image/jpeg';
            attObj.Body = Blob.valueOf('file-content');
            attObj.Description = 'KTP';
            attList.add(attObj);
            insert attList;

            List<Attachment> attCheckList = [SELECT Id, ParentId, Name, IsPrivate, ContentType, Description, LastModifiedDate, Parent.Name, LastModifiedBy.Name FROM Attachment WHERE ParentId = :caseObj.id ORDER BY CreatedDate ASC];
            String jsonBody = JSON.serialize(attCheckList);
            //String jsonBody = JSON.serialize(attList);
            System.debug('***MockGetAttachments: jsonBody : ' + jsonBody);
            res.setBody(jsonBody);
            res.setStatus('OK');
            res.setStatusCode(200);
            res.setHeader('cache-control', 'no-cache');
            return res;
        }
    }

    public class MockSyncAttachments implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            CaseComplaintAPI.SyncAttachmentResponse saRes = new CaseComplaintAPI.SyncAttachmentResponse();
            saRes.success = true;
            saRes.errors = null;
            saRes.parent_id = '5000k00000DF085';
            String jsonBody = JSON.serialize(saRes);
            res.setBody(jsonBody);
            res.setStatus('OK');
            res.setStatusCode(200);
            res.setHeader('cache-control', 'no-cache');
            return res;
        }
    }

    static testmethod void testLoadViewAttachmentPage() {
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
        
        /*
        Id entitlementProcessId = [SELECT Id FROM SlaProcess WHERE SObjectType = 'Case' AND Name LIKE '%Entitlement%' ORDER BY CreatedDate DESC LIMIT 1].Id;

        Entitlement ent = new Entitlement();
        ent.AccountId = accObj.Id;
        ent.SLAProcessId = entitlementProcessId;
        ent.Name = 'Entitlement AMFS';
        insert ent;
		*/

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
        //caseObj.EntitlementId = ent.Id;
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

        CaseComplaintService.mock = new MockGetAttachments();
        PageReference pageRef = Page.CaseComplaintViewAttachment;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('Id', String.valueOf(caseObj.Id));
        ApexPages.StandardController sc = new ApexPages.StandardController(caseObj);
        CaseComplaintViewAttachmentController ccvac = new CaseComplaintViewAttachmentController(sc);

        ccvac.retrieveAttachment();
        Double offset = ccvac.offset;
        System.assert(String.isNotBlank(ccvac.attListStr));
        System.assert(offset != null);
        Test.stopTest();
    }

    static testMethod void testSyncAttachments() {
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
        
        /*
        Id entitlementProcessId = [SELECT Id FROM SlaProcess WHERE SObjectType = 'Case' AND Name LIKE '%Entitlement%' ORDER BY CreatedDate DESC LIMIT 1].Id;

        Entitlement ent = new Entitlement();
        ent.AccountId = accObj.Id;
        ent.SLAProcessId = entitlementProcessId;
        ent.Name = 'Entitlement AMFS';
        insert ent;
		*/

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
        //caseObj.EntitlementId = ent.Id;
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

        PageReference pageRef = Page.CaseComplaintViewAttachment;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('Id', String.valueOf(caseObj.Id));
        ApexPages.StandardController sc = new ApexPages.StandardController(caseObj);
        CaseComplaintViewAttachmentController ccvac = new CaseComplaintViewAttachmentController(sc);

        PageReference pr = ccvac.syncAttachments();
        System.assert(pr == null);
        CaseComplaintService.mock = new MockSyncAttachments();
        pr = ccvac.syncAttachments();
        System.assert(pr == null);
        Test.stopTest();
    }
}