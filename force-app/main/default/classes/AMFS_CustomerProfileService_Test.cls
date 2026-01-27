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
private class AMFS_CustomerProfileService_Test {

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
        Contact conADS = new Contact();
        conADS.Entity__c = 'AMFS';
        conADS.PolicyApp__c = 'DMTM';
        conADS.Policy_No__c = '100-402-0963481';
        conADS.LastName = 'ANI';
        insert conADS;

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
        Log_Book_Activitiy_Detail__c lbadAds = new Log_Book_Activitiy_Detail__c();
        lbadAds.Log_Book_Activitiy__c = lba.Id;
        lbadAds.EForm__c = true;
        lbadAds.Customer_Mood__c = 'Happy';
        lbadAds.Customer_Name__c = 'JOHN DUMMY AMFS ADS';
        lbadAds.Customer_Relation__c = 'Diri Sendiri';
        lbadAds.Department__c = 'POS';
        lbadAds.Segmentation__c = 'Reguler';
        lbadAds.Dokumen_Tambahan__c = 'FP5';
        lbadAds.Contact_Policy__c = conADS.Id;
        insert lbadAds;
    }

    @isTest
    static void testGetAccountDetailsNoResponseCatch2() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        Test.startTest();
        AMFS_CustomerProfileService.successResponse('{ "name": "Test User", ');
        AMFS_CustomerProfileService.successResponseDMTM('{ "name": "Test User", ');
        Test.stopTest();
    }
    @isTest
    static void testGetCustomerProfileFalse() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBody();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_CustomerProfileService.InputData input = new AMFS_CustomerProfileService.InputData();
        input.isLastCallout = false;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_CustomerProfileService.InputData> inputs = new List<AMFS_CustomerProfileService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_CustomerProfileService.OutputData> outputs = AMFS_CustomerProfileService.getCustomerProfile(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetCustomerProfileTrue() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBody();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_CustomerProfileService.InputData input = new AMFS_CustomerProfileService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_CustomerProfileService.InputData> inputs = new List<AMFS_CustomerProfileService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_CustomerProfileService.OutputData> outputs = AMFS_CustomerProfileService.getCustomerProfile(inputs);
        Test.stopTest();
    }
    @isTest
    static void testGetCustomerProfileTrueGuest() {
        User guestUser = [SELECT Id FROM User WHERE UserType = 'Guest' LIMIT 1];
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBody();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_CustomerProfileService.InputData input = new AMFS_CustomerProfileService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_CustomerProfileService.InputData> inputs = new List<AMFS_CustomerProfileService.InputData>{ input };
        
        Test.startTest();
        System.runAs(guestUser){
            List<AMFS_CustomerProfileService.OutputData> outputs = AMFS_CustomerProfileService.getCustomerProfile(inputs);

        }
        Test.stopTest();
    }
    @isTest
    static void testGetCustomerProfileTrueADS() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS ADS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBody();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_CustomerProfileService.InputData input = new AMFS_CustomerProfileService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_CustomerProfileService.InputData> inputs = new List<AMFS_CustomerProfileService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_CustomerProfileService.OutputData> outputs = AMFS_CustomerProfileService.getCustomerProfile(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetCustomerProfileTrueDataNotComplete() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataNotComplete();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_CustomerProfileService.InputData input = new AMFS_CustomerProfileService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_CustomerProfileService.InputData> inputs = new List<AMFS_CustomerProfileService.InputData>{ input };
        
        Test.startTest();
        AMFS_CustomerProfileService.throwEx = true;
        List<AMFS_CustomerProfileService.OutputData> outputs = AMFS_CustomerProfileService.getCustomerProfile(inputs);
        Test.stopTest();
    }
    @isTest
    static void testGetCustomerProfileTrueDataNotCompleteADS() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS ADS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataNotComplete();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_CustomerProfileService.InputData input = new AMFS_CustomerProfileService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_CustomerProfileService.InputData> inputs = new List<AMFS_CustomerProfileService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_CustomerProfileService.OutputData> outputs = AMFS_CustomerProfileService.getCustomerProfile(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetCustomerProfileTrueDataNull() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataNull();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_CustomerProfileService.InputData input = new AMFS_CustomerProfileService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_CustomerProfileService.InputData> inputs = new List<AMFS_CustomerProfileService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_CustomerProfileService.OutputData> outputs = AMFS_CustomerProfileService.getCustomerProfile(inputs);
        Test.stopTest();   
    }

    @isTest
    static void testGetCustomerProfileTrueDataMissing() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataMissing();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_CustomerProfileService.InputData input = new AMFS_CustomerProfileService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_CustomerProfileService.InputData> inputs = new List<AMFS_CustomerProfileService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_CustomerProfileService.OutputData> outputs = AMFS_CustomerProfileService.getCustomerProfile(inputs);
        Test.stopTest();   
    }
    @isTest
    static void testGetCustomerProfileTrueDataMissingADS() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS ADS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataMissing();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_CustomerProfileService.InputData input = new AMFS_CustomerProfileService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_CustomerProfileService.InputData> inputs = new List<AMFS_CustomerProfileService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_CustomerProfileService.OutputData> outputs = AMFS_CustomerProfileService.getCustomerProfile(inputs);
        Test.stopTest();   
    }

    @isTest
    static void testGetCustomerProfileTrueDataNoResponse() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', null));

        // Create test input
        AMFS_CustomerProfileService.InputData input = new AMFS_CustomerProfileService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_CustomerProfileService.InputData> inputs = new List<AMFS_CustomerProfileService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_CustomerProfileService.OutputData> outputs = AMFS_CustomerProfileService.getCustomerProfile(inputs);
        Test.stopTest();
    }
    @isTest
    static void testGetCustomerProfileTrueDataNoResponseRLS() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', '{ invalid json }'));

        // Create test input
        AMFS_CustomerProfileService.InputData input = new AMFS_CustomerProfileService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_CustomerProfileService.InputData> inputs = new List<AMFS_CustomerProfileService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_CustomerProfileService.OutputData> outputs = AMFS_CustomerProfileService.getCustomerProfile(inputs);
        Test.stopTest();
    }
    @isTest
    static void testGetCustomerProfileTrueDataNoResponseADS() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS ADS' LIMIT 1];
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', '{ invalid json }'));

        // Create test input
        AMFS_CustomerProfileService.InputData input = new AMFS_CustomerProfileService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_CustomerProfileService.InputData> inputs = new List<AMFS_CustomerProfileService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_CustomerProfileService.OutputData> outputs = AMFS_CustomerProfileService.getCustomerProfile(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetCustomerProfileTrueResponse500Fail() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String errorBody = '{"Body": {"exception": {"code": "SERVER_ERROR", "message": "Internal server error"}}}';

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(500, 'OK', errorBody));

        // Create test input
        AMFS_CustomerProfileService.InputData input = new AMFS_CustomerProfileService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_CustomerProfileService.InputData> inputs = new List<AMFS_CustomerProfileService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_CustomerProfileService.OutputData> outputs = AMFS_CustomerProfileService.getCustomerProfile(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetCustomerProfileTrueResponse401Fail() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String errorBody = '{"errorCode": "AUTH_FAILED", "errorMessage": "Authentication failed", "Body": {}}';
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(401, 'OK', errorBody));

        // Create test input
        AMFS_CustomerProfileService.InputData input = new AMFS_CustomerProfileService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_CustomerProfileService.InputData> inputs = new List<AMFS_CustomerProfileService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_CustomerProfileService.OutputData> outputs = AMFS_CustomerProfileService.getCustomerProfile(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetCustomerProfileTrueResponse200Fail() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String exceptionBody = '{"Body": {"exception": {"code": "VALIDATION_ERROR", "message": "Data tidak valid"}}}';

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', exceptionBody));

        // Create test input
        AMFS_CustomerProfileService.InputData input = new AMFS_CustomerProfileService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_CustomerProfileService.InputData> inputs = new List<AMFS_CustomerProfileService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_CustomerProfileService.OutputData> outputs = AMFS_CustomerProfileService.getCustomerProfile(inputs);
        Test.stopTest();
    }
    @isTest
    static void testGetCustomerProfileTrueResponse200FailADS() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS ADS' LIMIT 1];
        
        String exceptionBody = '{"Body": {"exception": {"code": "VALIDATION_ERROR", "message": "Data tidak valid"}}}';

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', exceptionBody));

        // Create test input
        AMFS_CustomerProfileService.InputData input = new AMFS_CustomerProfileService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_CustomerProfileService.InputData> inputs = new List<AMFS_CustomerProfileService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_CustomerProfileService.OutputData> outputs = AMFS_CustomerProfileService.getCustomerProfile(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetAccountDetailsCatchMetadata() {
        Test.startTest();
        AMFS_Service_API__mdt result = AMFS_ServiceAPI.getIntegrationSettings(null);
        Test.stopTest();
        System.assertEquals(null, result, 'Should be null when catch block is triggered');
    }

    private static String createMockSuccessResponseBody() {
        AMFS_CustomerProfileService.CustomerDetailResponseWrapper response = mockResponseDataComplete();
        return JSON.serialize(response);
    }
    private static String createMockSuccessResponseBodyDataNotComplete() {
        AMFS_CustomerProfileService.CustomerDetailResponseWrapper response = mockResponseDataNotComplete();
        return JSON.serialize(response);
    }
    private static String createMockSuccessResponseBodyDataNull() {
        AMFS_CustomerProfileService.CustomerDetailResponseWrapper response = mockResponseDataNull();
        return JSON.serialize(response);
    }
    private static String createMockSuccessResponseBodyDataMissing() {
        AMFS_CustomerProfileService.CustomerDetailResponseWrapper response = mockResponseDataMissing();
        return JSON.serialize(response);
    }

    private static AMFS_CustomerProfileService.CustomerDetailResponseWrapper mockResponseDataComplete() {
        AMFS_CustomerProfileService.CustomerDetailResponseWrapper response = new AMFS_CustomerProfileService.CustomerDetailResponseWrapper();
        response.Body = new AMFS_CustomerProfileService.ResponseBody();
        response.Body.Customer = new AMFS_CustomerProfileService.CustomerResponseWrapper();
        system.debug('INI DATA BENAR');
        AMFS_CustomerProfileService.BeIndividual indi = new AMFS_CustomerProfileService.BeIndividual();
        indi.birthPlace = 'Ini Place';
        indi.birthDT = '19991201';
        indi.fullNM = 'Joko';
        indi.hasAddressesIn = new List<AMFS_CustomerProfileService.AddressInWrapper>();
        
        AMFS_CustomerProfileService.AddressInWrapper addr = new AMFS_CustomerProfileService.AddressInWrapper();
        addr.addressLine1 = 'Ini';
        addr.addressLine2 = 'adalah';
        addr.addressLine3 = 'Alamat';
        addr.addressLine4 = 'Nya';
        addr.emailAddress = 'Email';
        addr.mobilePhoneNO = '0293';

        indi.hasAddressesIn.add(addr);
        response.Body.Customer.canBeIndividual = indi;

        return response;
    }

    private static AMFS_CustomerProfileService.CustomerDetailResponseWrapper mockResponseDataNotComplete() {
        AMFS_CustomerProfileService.CustomerDetailResponseWrapper response = new AMFS_CustomerProfileService.CustomerDetailResponseWrapper();
        response.Body = new AMFS_CustomerProfileService.ResponseBody();
        response.Body.Customer = new AMFS_CustomerProfileService.CustomerResponseWrapper();
        system.debug('INI DATA Anomali 1');
        AMFS_CustomerProfileService.BeIndividual indi = new AMFS_CustomerProfileService.BeIndividual();
        indi.birthPlace = '                              ';
        indi.birthDT = '2025/09/21';
        indi.fullNM = '                              ';
        indi.hasAddressesIn = new List<AMFS_CustomerProfileService.AddressInWrapper>();
        
        AMFS_CustomerProfileService.AddressInWrapper addr = new AMFS_CustomerProfileService.AddressInWrapper();
        addr.addressLine1 = '                              ';
        addr.addressLine2 = '                              ';
        addr.addressLine3 = '                              ';
        addr.addressLine4 = '                              ';
        addr.emailAddress = '                              ';
        addr.mobilePhoneNO = '                              ';

        indi.hasAddressesIn.add(addr);
        response.Body.Customer.canBeIndividual = indi;

        return response;
    }

    private static AMFS_CustomerProfileService.CustomerDetailResponseWrapper mockResponseDataNull() {
        AMFS_CustomerProfileService.CustomerDetailResponseWrapper response = new AMFS_CustomerProfileService.CustomerDetailResponseWrapper();
        response.Body = new AMFS_CustomerProfileService.ResponseBody();
        response.Body.Customer = new AMFS_CustomerProfileService.CustomerResponseWrapper();
        system.debug('INI DATA Anomali dengan null');
        AMFS_CustomerProfileService.BeIndividual indi = new AMFS_CustomerProfileService.BeIndividual();
        indi.birthPlace = '                              ';
        indi.birthDT = null;
        indi.fullNM = 'FullName';
        indi.hasAddressesIn = new List<AMFS_CustomerProfileService.AddressInWrapper>();
        
        AMFS_CustomerProfileService.AddressInWrapper addr = new AMFS_CustomerProfileService.AddressInWrapper();
        addr.addressLine1 = 'Ini';
        addr.addressLine2 = 'adalah';
        addr.addressLine3 = null;
        addr.addressLine4 = 'Nya';
        addr.emailAddress = 'Email@gmail.com';
        addr.mobilePhoneNO = null;

        indi.hasAddressesIn.add(addr);
        response.Body.Customer.canBeIndividual = indi;

        return response;
    }

    private static AMFS_CustomerProfileService.CustomerDetailResponseWrapper mockResponseDataMissing() {
        AMFS_CustomerProfileService.CustomerDetailResponseWrapper response = new AMFS_CustomerProfileService.CustomerDetailResponseWrapper();
        response.Body = new AMFS_CustomerProfileService.ResponseBody();
        response.Body.Customer = new AMFS_CustomerProfileService.CustomerResponseWrapper();
        system.debug('INI DATA anomali 2');
        AMFS_CustomerProfileService.BeIndividual indi = new AMFS_CustomerProfileService.BeIndividual();
        indi.birthPlace = '                              ';
        indi.fullNM = 'FullName';
        indi.hasAddressesIn = new List<AMFS_CustomerProfileService.AddressInWrapper>();
        
        AMFS_CustomerProfileService.AddressInWrapper addr = new AMFS_CustomerProfileService.AddressInWrapper();
        addr.addressLine1 = 'Ini';
        addr.addressLine2 = 'adalah';
        addr.addressLine4 = 'Nya';
        addr.emailAddress = 'Email@gmail.com';

        indi.hasAddressesIn.add(addr);
        response.Body.Customer.canBeIndividual = indi;

        return response;
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