@isTest
global class RestCaseTest {
    
    global static void createContact(){
        Contact con = new Contact(LastName='Just Test AMFS',Policy_No__c = '514-8459257', entity__c = 'AMFS');
        Contact con1 = new Contact(LastName='Just Test AFI',Policy_No__c = '308-0079084', entity__c = 'AFI');
        insert con;
        insert con1;
    }
    
    // Start Case Inquiry Test
    @isTest
    global static void CaseInquiryEntityAMFS(){
        createContact();
        CaseWrapper.Response response = new CaseWrapper.Response();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CaseWrapper.Request requestObject = new CaseWrapper.Request();
        requestObject.transactionType = 'inquiry';
        requestObject.policyNo = '514-8459257';
        requestObject.entity = 'amfs';
        requestObject.status = 'd';
        requestObject.description = 'e';
        requestObject.subject = 'test';
        CaseWrapper.CaseRequest caseObject = new CaseWrapper.CaseRequest();
        caseObject.caseInquiry = requestObject;
        String testJson = (JSON.serialize(caseObject));
        
        Test.startTest();
        response = RestCaseInquiry.createCaseInquiry(requestObject);
        Test.stopTest();
    }
    
    @isTest
    global static void CaseInquiryEntityAFI(){
        createContact();
        CaseWrapper.Response response = new CaseWrapper.Response();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CaseWrapper.Request requestObject = new CaseWrapper.Request();
        requestObject.transactionType = 'inquiry';
        requestObject.policyNo = '308-0079084';
        requestObject.entity = 'afi';
        requestObject.status = 'd';
        requestObject.description = 'e';
        requestObject.subject = 'test';
        CaseWrapper.CaseRequest caseObject = new CaseWrapper.CaseRequest();
        caseObject.caseInquiry = requestObject;
        String testJson = (JSON.serialize(caseObject));
        
        Test.startTest();
        response = RestCaseInquiry.createCaseInquiry(requestObject);
        Test.stopTest();
    }
    
    @isTest
    global static void CaseInquiryToCatchError(){
        createContact();
        CaseWrapper.Response response = new CaseWrapper.Response();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CaseWrapper.Request requestObject = new CaseWrapper.Request();
        requestObject.policyNo = '514-8459257';
        requestObject.status = 'd';
        requestObject.description = 'e';
        requestObject.subject = 'test';
        CaseWrapper.CaseRequest caseObject = new CaseWrapper.CaseRequest();
        caseObject.caseInquiry = requestObject;
        String testJson = (JSON.serialize(caseObject));
        
        Test.startTest();
        response = RestCaseInquiry.createCaseInquiry(requestObject);
        Test.stopTest();
    }
    
    @isTest
    global static void CaseInquiryEntityElse(){
        createContact();
        CaseWrapper.Response response = new CaseWrapper.Response();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CaseWrapper.Request requestObject = new CaseWrapper.Request();
        requestObject.transactionType = 'inquiry';
        requestObject.entity = 'a';
        requestObject.policyNo = '514-8459257';
        requestObject.status = 'd';
        requestObject.description = 'e';
        requestObject.subject = 'test';
        CaseWrapper.CaseRequest caseObject = new CaseWrapper.CaseRequest();
        caseObject.caseInquiry = requestObject;
        String testJson = (JSON.serialize(caseObject));
        
        Test.startTest();
        response = RestCaseInquiry.createCaseInquiry(requestObject);
        Test.stopTest();
    }
    
    @isTest
    global static void CaseInquiryNullPolicyNo(){
        createContact();
        CaseWrapper.Response response = new CaseWrapper.Response();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CaseWrapper.Request requestObject = new CaseWrapper.Request();
        requestObject.transactionType = 'inquiry';
        requestObject.entity = 'amfs';
        requestObject.status = 'd';
        requestObject.description = 'e';
        requestObject.subject = 'test';
        CaseWrapper.CaseRequest caseObject = new CaseWrapper.CaseRequest();
        caseObject.caseInquiry = requestObject;
        String testJson = (JSON.serialize(caseObject));
        
        Test.startTest();
        response = RestCaseInquiry.createCaseInquiry(requestObject);
        Test.stopTest();
    }
    
    @isTest
    global static void CaseInquiryPolicyNoNotFound(){
        createContact();
        CaseWrapper.Response response = new CaseWrapper.Response();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CaseWrapper.Request requestObject = new CaseWrapper.Request();
        requestObject.transactionType = 'inquiry';
        requestObject.entity = 'amfs';
        requestObject.policyNo = '123-1234567';
        requestObject.status = 'd';
        requestObject.description = 'e';
        requestObject.subject = 'test';
        CaseWrapper.CaseRequest caseObject = new CaseWrapper.CaseRequest();
        caseObject.caseInquiry = requestObject;
        String testJson = (JSON.serialize(caseObject));
        
        Test.startTest();
        response = RestCaseInquiry.createCaseInquiry(requestObject);
        Test.stopTest();
    }
    
    // End Case Inquiry Test
    
    // Start Case Complaint Test
    @isTest
    global static void CaseComplaintEntityAMFS(){
        createContact();
        CaseWrapper.Response response = new CaseWrapper.Response();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CaseWrapper.Request requestObject = new CaseWrapper.Request();
        requestObject.transactionType = 'complaint';
        requestObject.policyNo = '514-8459257';
        requestObject.entity = 'amfs';
        requestObject.status = 'd';
        requestObject.description = 'e';
        requestObject.subject = 'test';
        CaseWrapper.CaseRequest caseObject = new CaseWrapper.CaseRequest();
        caseObject.caseComplaint = requestObject;
        String testJson = (JSON.serialize(caseObject));
        
        Test.startTest();
        response = RestCaseComplaint.createCaseInquiry(requestObject);
        Test.stopTest();
    }
    
    @isTest
    global static void CaseComplaintEntityAFI(){
        createContact();
        CaseWrapper.Response response = new CaseWrapper.Response();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CaseWrapper.Request requestObject = new CaseWrapper.Request();
        requestObject.transactionType = 'complaint';
        requestObject.policyNo = '308-0079084';
        requestObject.entity = 'afi';
        requestObject.status = 'd';
        requestObject.description = 'e';
        requestObject.subject = 'test';
        CaseWrapper.CaseRequest caseObject = new CaseWrapper.CaseRequest();
        caseObject.caseComplaint = requestObject;
        String testJson = (JSON.serialize(caseObject));
        
        Test.startTest();
        response = RestCaseComplaint.createCaseInquiry(requestObject);
        Test.stopTest();
    }
    
    @isTest
    global static void CaseComplaintNoTransactionType(){
        createContact();
        CaseWrapper.Response response = new CaseWrapper.Response();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CaseWrapper.Request requestObject = new CaseWrapper.Request();
        requestObject.policyNo = 'b';
        requestObject.entity = 'amfs';
        requestObject.status = 'd';
        requestObject.description = 'e';
        requestObject.subject = 'test';
        CaseWrapper.CaseRequest caseObject = new CaseWrapper.CaseRequest();
        caseObject.caseComplaint = requestObject;
        String testJson = (JSON.serialize(caseObject));
        
        Test.startTest();
        response = RestCaseComplaint.createCaseInquiry(requestObject);
        Test.stopTest();
    }
    
    @isTest
    global static void CaseComplaintEntityElse(){
        createContact();
        CaseWrapper.Response response = new CaseWrapper.Response();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CaseWrapper.Request requestObject = new CaseWrapper.Request();
        requestObject.transactionType = 'complaint';
        requestObject.entity = 'a';
        requestObject.policyNo = '514-8459257';
        requestObject.status = 'd';
        requestObject.description = 'e';
        requestObject.subject = 'test';
        CaseWrapper.CaseRequest caseObject = new CaseWrapper.CaseRequest();
        caseObject.caseComplaint = requestObject;
        String testJson = (JSON.serialize(caseObject));
        
        Test.startTest();
        response = RestCaseComplaint.createCaseInquiry(requestObject);
        Test.stopTest();
    }
    
    @isTest
    global static void CaseComplaintNullPolicyNo(){
        createContact();
        CaseWrapper.Response response = new CaseWrapper.Response();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CaseWrapper.Request requestObject = new CaseWrapper.Request();
        requestObject.transactionType = 'complaint';
        requestObject.entity = 'amfs';
        requestObject.status = 'd';
        requestObject.description = 'e';
        requestObject.subject = 'test';
        CaseWrapper.CaseRequest caseObject = new CaseWrapper.CaseRequest();
        caseObject.caseComplaint = requestObject;
        String testJson = (JSON.serialize(caseObject));
        
        Test.startTest();
        response = RestCaseComplaint.createCaseInquiry(requestObject);
        Test.stopTest();
    }
    
    @isTest
    global static void CaseComplaintPolicyNoNotFound(){
        createContact();
        CaseWrapper.Response response = new CaseWrapper.Response();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CaseWrapper.Request requestObject = new CaseWrapper.Request();
        requestObject.transactionType = 'complaint';
        requestObject.entity = 'amfs';
        requestObject.policyNo = '123-1234567';
        requestObject.status = 'd';
        requestObject.description = 'e';
        requestObject.subject = 'test';
        CaseWrapper.CaseRequest caseObject = new CaseWrapper.CaseRequest();
        caseObject.caseComplaint = requestObject;
        String testJson = (JSON.serialize(caseObject));
        
        Test.startTest();
        response = RestCaseComplaint.createCaseInquiry(requestObject);
        Test.stopTest();
    }
    // End Case Complaint Test
    
    // Start Case Request Test
    @isTest
    global static void CaseRequestEntityAMFS(){
        createContact();
        CaseWrapper.Response response = new CaseWrapper.Response();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CaseWrapper.Request requestObject = new CaseWrapper.Request();
        requestObject.transactionType = 'request';
        requestObject.policyNo = '514-8459257';
        requestObject.entity = 'amfs';
        requestObject.status = 'd';
        requestObject.description = 'e';
        requestObject.subject = 'test';
        CaseWrapper.CaseRequest caseObject = new CaseWrapper.CaseRequest();
        caseObject.caseRequest = requestObject;
        String testJson = (JSON.serialize(caseObject));
        
        Test.startTest();
        response = RestCaseRequest.createCaseInquiry(requestObject);
        Test.stopTest();
    }
    
    @isTest
    global static void CaseRequestEntityAFI(){
        createContact();
        CaseWrapper.Response response = new CaseWrapper.Response();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CaseWrapper.Request requestObject = new CaseWrapper.Request();
        requestObject.transactionType = 'request';
        requestObject.policyNo = '308-0079084';
        requestObject.entity = 'afi';
        requestObject.status = 'd';
        requestObject.description = 'e';
        requestObject.subject = 'test';
        CaseWrapper.CaseRequest caseObject = new CaseWrapper.CaseRequest();
        caseObject.caseRequest = requestObject;
        String testJson = (JSON.serialize(caseObject));
        
        Test.startTest();
        response = RestCaseRequest.createCaseInquiry(requestObject);
        Test.stopTest();
    }
    
    @isTest
    global static void CaseRequestNoTransactionType(){
        createContact();
        CaseWrapper.Response response = new CaseWrapper.Response();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CaseWrapper.Request requestObject = new CaseWrapper.Request();
        requestObject.policyNo = 'b';
        requestObject.entity = 'amfs';
        requestObject.status = 'd';
        requestObject.description = 'e';
        requestObject.subject = 'test';
        CaseWrapper.CaseRequest caseObject = new CaseWrapper.CaseRequest();
        caseObject.caseRequest = requestObject;
        String testJson = (JSON.serialize(caseObject));
        
        Test.startTest();
        response = RestCaseRequest.createCaseInquiry(requestObject);
        Test.stopTest();
    }
    
    @isTest
    global static void CaseRequestEntityElse(){
        createContact();
        CaseWrapper.Response response = new CaseWrapper.Response();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CaseWrapper.Request requestObject = new CaseWrapper.Request();
        requestObject.transactionType = 'request';
        requestObject.entity = 'a';
        requestObject.policyNo = '514-8459257';
        requestObject.status = 'd';
        requestObject.description = 'e';
        requestObject.subject = 'test';
        CaseWrapper.CaseRequest caseObject = new CaseWrapper.CaseRequest();
        caseObject.caseRequest = requestObject;
        String testJson = (JSON.serialize(caseObject));
        
        Test.startTest();
        response = RestCaseRequest.createCaseInquiry(requestObject);
        Test.stopTest();
    }
    
    @isTest
    global static void CaseRequestNullPolicyNo(){
        createContact();
        CaseWrapper.Response response = new CaseWrapper.Response();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CaseWrapper.Request requestObject = new CaseWrapper.Request();
        requestObject.transactionType = 'request';
        requestObject.entity = 'amfs';
        requestObject.status = 'd';
        requestObject.description = 'e';
        requestObject.subject = 'test';
        CaseWrapper.CaseRequest caseObject = new CaseWrapper.CaseRequest();
        caseObject.caseRequest = requestObject;
        String testJson = (JSON.serialize(caseObject));
        
        Test.startTest();
        response = RestCaseRequest.createCaseInquiry(requestObject);
        Test.stopTest();
    }
    
    @isTest
    global static void CaseRequestPolicyNoNotFound(){
        createContact();
        CaseWrapper.Response response = new CaseWrapper.Response();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CaseWrapper.Request requestObject = new CaseWrapper.Request();
        requestObject.transactionType = 'request';
        requestObject.entity = 'amfs';
        requestObject.policyNo = '123-1234567';
        requestObject.status = 'd';
        requestObject.description = 'e';
        requestObject.subject = 'test';
        CaseWrapper.CaseRequest caseObject = new CaseWrapper.CaseRequest();
        caseObject.caseRequest = requestObject;
        String testJson = (JSON.serialize(caseObject));
        
        Test.startTest();
        response = RestCaseRequest.createCaseInquiry(requestObject);
        Test.stopTest();
    }
    // End Case Request Test

    global class RestMock implements HttpCalloutMock{
        
        global HttpResponse respond(HttpRequest req){
            Contact kontakBaru = new Contact();
            kontakBaru.Policy_No__c = '514-8459257';
            
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            String sJsonResponse = '{"status": "00","stackTrace": null,"message": "Success created case","caseNumber": "1234567","caseId": "1234567890ABC"}}';
            
            res.setBody(sJsonResponse);
            res.setStatusCode(200);
            
            return res; 
        }
    }
}