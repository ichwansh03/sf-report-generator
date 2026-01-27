/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class AMFS_ServiceAPI_Test {

    @testSetup
    static void setupTestData() {
        
        Log_Book_Activitiy__c lba = new Log_Book_Activitiy__c();
        lba.Time_In__c = Time.newInstance(1, 1, 0, 0);
        lba.Queue_No__c = 'A001';
        lba.Touch_Point__c = 'Head Office';
        insert lba;
        
        Contact con = new Contact();
        con.Entity__c = 'AMFS';
        con.PolicyApp__c = 'RLS';
        con.Policy_No__c = '520-4931835';
        con.LastName = 'John';
        insert con;

        Log_Book_Activitiy_Detail__c lbad = new Log_Book_Activitiy_Detail__c();
        lbad.Log_Book_Activitiy__c = lba.Id;
        lbad.EForm__c = true;
        lbad.Customer_Mood__c = 'Happy';
        lbad.Customer_Name__c = 'JOHN DUMMY AMFS RLS';
        lbad.Customer_Relation__c = 'Diri Sendiri';
        lbad.Department__c = 'POS';
        lbad.Segmentation__c = 'Reguler';
        lbad.Contact_Policy__c = con.Id;
        insert lbad;

        Master_Fund_Code__c mfc = new Master_Fund_Code__c();
        mfc.Name = 'ZRSM';
        mfc.Plan_Code__c = 'HONMPH';
        mfc.Currency__c = 'RP';
        mfc.Desc_Fun_Code__c = 'MANDIRI SECURE FIXED INCOME MONEY RUPIAH';
        insert mfc;

    }

    @isTest
    static void testServiceAPI() {
        AMFS_Service_API__mdt config = AMFS_ServiceAPI.getIntegrationSettings('Policy_Detail_Service');
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Log_Case__r.Id FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c = : 'JOHN DUMMY AMFS RLS' LIMIT 1];
        Contact con = [SELECT Id, Entity__c, PolicyApp__c, Policy_No__c FROM Contact WHERE Entity__c =: 'AMFS' LIMIT 1];
        String requestBody = '{"Header": {"SecurityContext": {"username": "SFDCEIP","password": "SFDCEIP123!"}},"Body": {"transactionId": "unique 1751252736396","service": "getPolicyDetails","operation": "policy DETAILs","entity": "AMFS","appID": "RLS","Customer": {"hasPolicyAccount": [{"policyNO": "302-4513933"}]}}}';
        String res = '{"Body": {"Customer":"ADA"}}';
        String endpoint = config.Endpoint__c;
        String method = 'POST';
        Integer timeout = 120000;
        String policyNo = con.Policy_No__c;
        String entity = con.Entity__c;
        String policeApp = con.PolicyApp__c;
        String caseId = lbad.Log_Case__r.Id;

        Long startLongTime = System.now().getTime();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', res));

        // Create test input
        
        Test.startTest();
        AMFS_ServiceAPI.makeHttpCallout(endpoint, method, requestBody, AMFS_ServiceAPI.getDefaultHeaders(), timeout, policyNo, policeApp, entity, caseId, startLongTime);
        Test.stopTest();
    }

    @isTest
    static void testServiceAPIIntegration() {
        AMFS_Service_API__mdt config = AMFS_ServiceAPI.getIntegrationSettings('Test');
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Log_Case__r.Id FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c = : 'JOHN DUMMY AMFS RLS' LIMIT 1];
        Contact con = [SELECT Id, Entity__c, PolicyApp__c, Policy_No__c FROM Contact WHERE Entity__c =: 'AMFS' LIMIT 1];
        String requestBody = '{"Header": {"SecurityContext": {"username": "SFDCEIP","password": "SFDCEIP123!"}},"Body": {"transactionId": "unique 1751252736396","service": "getPolicyDetails","operation": "policy DETAILs","entity": "AMFS","appID": "RLS","Customer": {"hasPolicyAccount": [{"policyNO": "302-4513933"}]}}}';
        String res = '{"Body": {"Customer":"ADA"}}';
        // String endpoint = config.Endpoint__c;
        String method = 'POST';
        Integer timeout = 120000;
        String policyNo = con.Policy_No__c;
        String entity = con.Entity__c;
        String policeApp = con.PolicyApp__c;
        String caseId = lbad.Log_Case__r.Id;

        Long startLongTime = System.now().getTime();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', res));

        // Create test input
        
        Test.startTest();
        try {
            AMFS_ServiceAPI.makeHttpCallout(null, method, requestBody, AMFS_ServiceAPI.getDefaultHeaders(), timeout, policyNo, policeApp, entity, caseId, startLongTime);
            
        } catch (QueryException e) {
            System.debug('Exception caught: ' + e.getMessage());
        }
        Test.stopTest();
    }

    @isTest
    static void testServiceAPIIntegrationNull() {
        AMFS_Service_API__mdt config = AMFS_ServiceAPI.getIntegrationSettings(null);
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Log_Case__r.Id FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c = : 'JOHN DUMMY AMFS RLS' LIMIT 1];
        Contact con = [SELECT Id, Entity__c, PolicyApp__c, Policy_No__c FROM Contact WHERE Entity__c =: 'AMFS' LIMIT 1];
        String requestBody = '{"Header": {"SecurityContext": {"username": "SFDCEIP","password": "SFDCEIP123!"}},"Body": {"transactionId": "unique 1751252736396","service": "getPolicyDetails","operation": "policy DETAILs","entity": "AMFS","appID": "RLS","Customer": {"hasPolicyAccount": [{"policyNO": "302-4513933"}]}}}';
        String res = '{"Body": {"Customer":"ADA"}}';
        // String endpoint = config.Endpoint__c;
        String method = 'POST';
        Integer timeout = 120000;
        String policyNo = con.Policy_No__c;
        String entity = con.Entity__c;
        String policeApp = con.PolicyApp__c;
        String caseId = lbad.Log_Case__r.Id;

        Long startLongTime = System.now().getTime();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', res));

        // Create test input
        
        Test.startTest();
        try {
            AMFS_ServiceAPI.makeHttpCallout(null, method, requestBody, AMFS_ServiceAPI.getDefaultHeaders(), timeout, policyNo, policeApp, entity, caseId, startLongTime);
        } catch (QueryException e) {
            System.debug('Exception caught: ' + e.getMessage());
        }
            
        Test.stopTest();
    }

    @isTest
    static void testServiceAPI500() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Log_Case__r.Id FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c = : 'JOHN DUMMY AMFS RLS' LIMIT 1];
        Contact con = [SELECT Id, Entity__c, PolicyApp__c, Policy_No__c FROM Contact WHERE Entity__c =: 'AMFS' LIMIT 1];
        String errorBody = '{"Body": {"exception": {"code": "SERVER_ERROR", "message": "Internal server error"}}}';

        String requestBody = '{"Header": {"SecurityContext": {"username": "SFDCEIP","password": "SFDCEIP123!"}},"Body": {"transactionId": "unique 1751252736396","service": "getPolicyDetails","operation": "policy DETAILs","entity": "AMFS","appID": "RLS","Customer": {"hasPolicyAccount": [{"policyNO": "302-4513933"}]}}}';
        
        String endpoint = 'ini/endpoint/axa/test';
        String method = 'POST';
        Integer timeout = 120000;
        String policyNo = con.Policy_No__c;
        String entity = con.Entity__c;
        String policeApp = con.PolicyApp__c;
        String caseId = lbad.Log_Case__r.Id;

        Long startLongTime = System.now().getTime();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(500, 'OK', errorBody));

        // Create test input
        
        Test.startTest();
        AMFS_ServiceAPI.makeHttpCallout(endpoint, method, requestBody, AMFS_ServiceAPI.getDefaultHeaders(), timeout, policyNo, policeApp, entity, caseId, startLongTime);
        Test.stopTest();
    }

    @isTest
    static void testServiceAPI401() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Log_Case__r.Id FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c = : 'JOHN DUMMY AMFS RLS' LIMIT 1];
        Contact con = [SELECT Id, Entity__c, PolicyApp__c, Policy_No__c FROM Contact WHERE Entity__c =: 'AMFS' LIMIT 1];
        String errorBody = '{"errorCode": "AUTH_FAILED", "errorMessage": "Authentication failed", "Body": {}}';
        
        String requestBody = '{"Header": {"SecurityContext": {"username": "SFDCEIP","password": "SFDCEIP123!"}},"Body": {"transactionId": "unique 1751252736396","service": "getPolicyDetails","operation": "policy DETAILs","entity": "AMFS","appID": "RLS","Customer": {"hasPolicyAccount": [{"policyNO": "302-4513933"}]}}}';
        
        String endpoint = 'ini/endpoint/axa/test';
        String method = 'POST';
        Integer timeout = 120000;
        String policyNo = con.Policy_No__c;
        String entity = con.Entity__c;
        String policeApp = con.PolicyApp__c;
        String caseId = lbad.Log_Case__r.Id;

        Long startLongTime = System.now().getTime();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(401, 'OK', errorBody));

        // Create test input
        
        Test.startTest();
        AMFS_ServiceAPI.makeHttpCallout(endpoint, method, requestBody, AMFS_ServiceAPI.getDefaultHeaders(), timeout, policyNo, policeApp, entity, caseId, startLongTime);
        Test.stopTest();
    }

    @isTest
    static void testServiceAPI200() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Log_Case__r.Id FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c = : 'JOHN DUMMY AMFS RLS' LIMIT 1];
        Contact con = [SELECT Id, Entity__c, PolicyApp__c, Policy_No__c FROM Contact WHERE Entity__c =: 'AMFS' LIMIT 1];
        String exceptionBody = '{"Body": {"exception": {"code": "VALIDATION_ERROR", "message": "Data tidak valid"}}}';

        String requestBody = '{"Header": {"SecurityContext": {"username": "SFDCEIP","password": "SFDCEIP123!"}},"Body": {"transactionId": "unique 1751252736396","service": "getPolicyDetails","operation": "policy DETAILs","entity": "AMFS","appID": "RLS","Customer": {"hasPolicyAccount": [{"policyNO": "302-4513933"}]}}}';
        
        String endpoint = 'ini/endpoint/axa/test';
        String method = 'POST';
        Integer timeout = 120000;
        String policyNo = con.Policy_No__c;
        String entity = con.Entity__c;
        String policeApp = con.PolicyApp__c;
        String caseId = lbad.Log_Case__r.Id;

        Long startLongTime = System.now().getTime();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', exceptionBody));

        // Create test input
        
        Test.startTest();
        AMFS_ServiceAPI.makeHttpCallout(endpoint, method, requestBody, AMFS_ServiceAPI.getDefaultHeaders(), timeout, policyNo, policeApp, entity, caseId, startLongTime);
        Test.stopTest();
    }

    @isTest
    static void testServiceAPIException() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Log_Case__r.Id FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c = : 'JOHN DUMMY AMFS RLS' LIMIT 1];
        Contact con = [SELECT Id, Entity__c, PolicyApp__c, Policy_No__c FROM Contact WHERE Entity__c =: 'AMFS' LIMIT 1];
        
        String endpoint = 'ini/endpoint/axa/test';
        String method = 'POST';
        // Integer timeout = 120000;
        String policyNo = con.Policy_No__c;
        String entity = con.Entity__c;
        String policeApp = con.PolicyApp__c;
        String caseId = lbad.Log_Case__r.Id;

        Long startLongTime = System.now().getTime();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', null));

        // Create test input
        
        Test.startTest();
        AMFS_ServiceAPI.makeHttpCallout(endpoint, method, null, AMFS_ServiceAPI.getDefaultHeaders(), null, policyNo, policeApp, entity, caseId, startLongTime);
        Test.stopTest();
    }

    @isTest
    static void testServiceAPIAppLog() {
        Contact con = [SELECT Id, Entity__c, PolicyApp__c, Policy_No__c FROM Contact WHERE Entity__c =: 'AMFS' LIMIT 1];
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Log_Case__r.Id FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c = : 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        AMFS_ServiceAPI.IntegrationResponse res = new AMFS_ServiceAPI.IntegrationResponse();
        res.responseBody = '{"Body": {"Customer":"ADA"}}';
        res.errorMessage = '{"Body": {"exception": {"code": "VALIDATION_ERROR", "message": "Data tidak valid"}}}';
        res.requestBody = '{"Header": {"SecurityContext": {"username": "SFDCEIP","password": "SFDCEIP123!"}},"Body": {"transactionId": "unique 1751252736396","service": "getPolicyDetails","operation": "policy DETAILs","entity": "AMFS","appID": "RLS","Customer": {"hasPolicyAccount": [{"policyNO": "302-4513933"}]}}}';
        res.httpMethod = 'POST';
        res.status = 'OK';
        res.policyNo = con.Policy_No__c;
        res.entity = con.Entity__c;
        res.policyApp = con.PolicyApp__c;
        res.caseId = lbad.Log_Case__r.Id;
        res.startLongTime =  System.now().getTime();
        res.endLongTime =  System.now().getTime();
        res.contactSFID = lbad.Log_Case__r.Id;
        // Create test input
        
        Test.startTest();
        AMFS_ServiceAPI.logTransaction(res);
        Test.stopTest();
    }

    @isTest
    static void testServiceAPIAppLogNull() {
        Test.startTest();
        AMFS_ServiceAPI.logTransaction(null);
        Test.stopTest();
    }

    public class MockHttpResponseGenerator implements HttpCalloutMock {
        private Integer statusCode;
        private String status;
        private String body;
        
        public MockHttpResponseGenerator(Integer statusCode, String status, String body) {
            this.statusCode = statusCode;
            this.status = status;
            this.body = body;
        }
        
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(this.statusCode);
            res.setStatus(this.status);
            res.setBody(this.body);
            return res;
        }
    }
}