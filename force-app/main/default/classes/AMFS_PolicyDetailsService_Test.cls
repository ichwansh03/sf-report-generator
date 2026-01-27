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
private class AMFS_PolicyDetailsService_Test {


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

        Master_Fund_Code__c mfc = new Master_Fund_Code__c();
        mfc.Name = 'ZRSM';
        mfc.Plan_Code__c = 'HONMPH';
        mfc.Currency__c = 'RP';
        mfc.Desc_Fun_Code__c = 'MANDIRI SECURE FIXED INCOME MONEY RUPIAH';
        insert mfc;
    }


    @isTest
    static void testGetPolicyDetailsFalse() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBody();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_PolicyDetailsService.InputData input = new AMFS_PolicyDetailsService.InputData();
        input.isLastCallout = false;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_PolicyDetailsService.InputData> inputs = new List<AMFS_PolicyDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_PolicyDetailsService.OutputData> outputs = AMFS_PolicyDetailsService.getPolicyDetails(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetPolicyDetailsTrueGuest() {
        User guestUser = [SELECT Id FROM User WHERE UserType = 'Guest' LIMIT 1];
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBody();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_PolicyDetailsService.InputData input = new AMFS_PolicyDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_PolicyDetailsService.InputData> inputs = new List<AMFS_PolicyDetailsService.InputData>{ input };
        
        Test.startTest();
        System.runAs(guestUser){
            List<AMFS_PolicyDetailsService.OutputData> outputs = AMFS_PolicyDetailsService.getPolicyDetails(inputs);

        }
        Test.stopTest();
    }
    @isTest
    static void testGetPolicyDetailsTrue() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBody();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_PolicyDetailsService.InputData input = new AMFS_PolicyDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_PolicyDetailsService.InputData> inputs = new List<AMFS_PolicyDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_PolicyDetailsService.OutputData> outputs = AMFS_PolicyDetailsService.getPolicyDetails(inputs);
        Test.stopTest();
    }
    @isTest
    static void testGetPolicyDetailsTrueADS() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS ADS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBody();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_PolicyDetailsService.InputData input = new AMFS_PolicyDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_PolicyDetailsService.InputData> inputs = new List<AMFS_PolicyDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_PolicyDetailsService.OutputData> outputs = AMFS_PolicyDetailsService.getPolicyDetails(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetPolicyDetailsTrueDataNotComplete() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataNotComplete();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_PolicyDetailsService.InputData input = new AMFS_PolicyDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_PolicyDetailsService.InputData> inputs = new List<AMFS_PolicyDetailsService.InputData>{ input };
        
        Test.startTest();
        AMFS_PolicyDetailsService.throwEx = true;
        List<AMFS_PolicyDetailsService.OutputData> outputs = AMFS_PolicyDetailsService.getPolicyDetails(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetPolicyDetailsTrueDataNull() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataNull();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_PolicyDetailsService.InputData input = new AMFS_PolicyDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_PolicyDetailsService.InputData> inputs = new List<AMFS_PolicyDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_PolicyDetailsService.OutputData> outputs = AMFS_PolicyDetailsService.getPolicyDetails(inputs);
        Test.stopTest();   
    }

    @isTest
    static void testGetPolicyDetailsTrueDataMissing() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataMissing();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_PolicyDetailsService.InputData input = new AMFS_PolicyDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_PolicyDetailsService.InputData> inputs = new List<AMFS_PolicyDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_PolicyDetailsService.OutputData> outputs = AMFS_PolicyDetailsService.getPolicyDetails(inputs);
        Test.stopTest();   
    }
    @isTest
    static void testGetPolicyDetailsTrueDataMissingADS() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS ADS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataMissing();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_PolicyDetailsService.InputData input = new AMFS_PolicyDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_PolicyDetailsService.InputData> inputs = new List<AMFS_PolicyDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_PolicyDetailsService.OutputData> outputs = AMFS_PolicyDetailsService.getPolicyDetails(inputs);
        Test.stopTest();   
    }

    @isTest
    static void testGetPolicyDetailsTrueDataNoResponse() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', null));

        // Create test input
        AMFS_PolicyDetailsService.InputData input = new AMFS_PolicyDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_PolicyDetailsService.InputData> inputs = new List<AMFS_PolicyDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_PolicyDetailsService.OutputData> outputs = AMFS_PolicyDetailsService.getPolicyDetails(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetPolicyDetailsTrueResponse500Fail() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String errorBody = '{"Body": {"exception": {"code": "SERVER_ERROR", "message": "Internal server error"}}}';

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(500, 'OK', errorBody));

        // Create test input
        AMFS_PolicyDetailsService.InputData input = new AMFS_PolicyDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_PolicyDetailsService.InputData> inputs = new List<AMFS_PolicyDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_PolicyDetailsService.OutputData> outputs = AMFS_PolicyDetailsService.getPolicyDetails(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetPolicyDetailsTrueResponse401Fail() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String errorBody = '{"errorCode": "AUTH_FAILED", "errorMessage": "Authentication failed", "Body": {}}';
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(401, 'OK', errorBody));

        // Create test input
        AMFS_PolicyDetailsService.InputData input = new AMFS_PolicyDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_PolicyDetailsService.InputData> inputs = new List<AMFS_PolicyDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_PolicyDetailsService.OutputData> outputs = AMFS_PolicyDetailsService.getPolicyDetails(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetPolicyDetailsTrueResponse200Fail() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String exceptionBody = '{"Body": {"exception": {"code": "VALIDATION_ERROR", "message": "Data tidak valid"}}}';

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', exceptionBody));

        // Create test input
        AMFS_PolicyDetailsService.InputData input = new AMFS_PolicyDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_PolicyDetailsService.InputData> inputs = new List<AMFS_PolicyDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_PolicyDetailsService.OutputData> outputs = AMFS_PolicyDetailsService.getPolicyDetails(inputs);
        Test.stopTest();
    }
    @isTest
    static void testGetPolicyDetailsTrueResponse200FailADS() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS ADS' LIMIT 1];
        
        String exceptionBody = '{"Body": {"exception": {"code": "VALIDATION_ERROR", "message": "Data tidak valid"}}}';

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', exceptionBody));

        // Create test input
        AMFS_PolicyDetailsService.InputData input = new AMFS_PolicyDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_PolicyDetailsService.InputData> inputs = new List<AMFS_PolicyDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_PolicyDetailsService.OutputData> outputs = AMFS_PolicyDetailsService.getPolicyDetails(inputs);
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
        AMFS_PolicyDetailsService.PolicyDetailResponseWrapper response = mockResponseDataComplete();
        return JSON.serialize(response);
    }

    private static String createMockSuccessResponseBodyDataNotComplete() {
        AMFS_PolicyDetailsService.PolicyDetailResponseWrapper response = mockResponseDataNotComplete();
        return JSON.serialize(response);
    }

    private static String createMockSuccessResponseBodyDataNull() {
        AMFS_PolicyDetailsService.PolicyDetailResponseWrapper response = mockResponseDataNull();
        return JSON.serialize(response);
    }

    private static String createMockSuccessResponseBodyDataMissing() {
        AMFS_PolicyDetailsService.PolicyDetailResponseWrapper response = mockResponseDataMissing();
        return JSON.serialize(response);
    }

    private static AMFS_PolicyDetailsService.PolicyDetailResponseWrapper mockResponseDataComplete() {
        AMFS_PolicyDetailsService.PolicyDetailResponseWrapper response = new AMFS_PolicyDetailsService.PolicyDetailResponseWrapper();
        response.Body = new AMFS_PolicyDetailsService.ResponseBody();
        response.Body.Customer = new AMFS_PolicyDetailsService.CustomerResponseWrapper();
        system.debug('INI DATA BENAR');
        AMFS_PolicyDetailsService.BeIndividual ind = new AMFS_PolicyDetailsService.BeIndividual();
        ind.socialSecurityNO = '14785265412361477852';
        
        response.Body.Customer.hasPolicyAccount = new List<AMFS_PolicyDetailsService.PolicyAccountResponseWrapper>();
        AMFS_PolicyDetailsService.PolicyAccountResponseWrapper pol = new AMFS_PolicyDetailsService.PolicyAccountResponseWrapper();
        pol.downPaymentPct = '30.00';
        pol.hasDetailsOfRisksIn = new List<AMFS_PolicyDetailsService.HasDetailsOfRisksInResponseWrapper>();

        AMFS_PolicyDetailsService.HasDetailsOfRisksInResponseWrapper detail = new AMFS_PolicyDetailsService.HasDetailsOfRisksInResponseWrapper();
        detail.insuredID = '123123123';
        detail.hasPersonalDetailsIn = new List<AMFS_PolicyDetailsService.HasPersonalDetailsInResponseWrapper>();

        AMFS_PolicyDetailsService.HasPersonalDetailsInResponseWrapper personnn = new AMFS_PolicyDetailsService.HasPersonalDetailsInResponseWrapper();
        personnn.birthDT = '12032000';
        personnn.birthPlace = 'place';
        personnn.firstNM = 'John';
        personnn.lastNM = 'am';
        personnn.genderCD = 'M';
        personnn.hasAddressesIn = new List<AMFS_PolicyDetailsService.HasAddressesInResponseWrapper>();

        AMFS_PolicyDetailsService.HasAddressesInResponseWrapper ad = new AMFS_PolicyDetailsService.HasAddressesInResponseWrapper();
        ad.emailAddress = 'email';
        ad.mobilePhoneNO = '123123';
        personnn.hasAddressesIn.add(ad);
        detail.hasPersonalDetailsIn.add(personnn);
        pol.hasDetailsOfRisksIn.add(detail);

        response.Body.Customer.canBeIndividual = ind;
        response.Body.Customer.hasPolicyAccount.add(pol);

        return response;
    }

    private static AMFS_PolicyDetailsService.PolicyDetailResponseWrapper mockResponseDataNotComplete() {
        AMFS_PolicyDetailsService.PolicyDetailResponseWrapper response = new AMFS_PolicyDetailsService.PolicyDetailResponseWrapper();
        response.Body = new AMFS_PolicyDetailsService.ResponseBody();
        response.Body.Customer = new AMFS_PolicyDetailsService.CustomerResponseWrapper();
        system.debug('INI DATA Anomali 1');
        AMFS_PolicyDetailsService.BeIndividual ind = new AMFS_PolicyDetailsService.BeIndividual();
        ind.socialSecurityNO = '                              ';
        
        response.Body.Customer.hasPolicyAccount = new List<AMFS_PolicyDetailsService.PolicyAccountResponseWrapper>();
        AMFS_PolicyDetailsService.PolicyAccountResponseWrapper pol = new AMFS_PolicyDetailsService.PolicyAccountResponseWrapper();
        pol.downPaymentPct = '-';
        
        response.Body.Customer.canBeIndividual = ind;
        response.Body.Customer.hasPolicyAccount.add(pol);

        return response;
    }

    private static AMFS_PolicyDetailsService.PolicyDetailResponseWrapper mockResponseDataNull() {
        AMFS_PolicyDetailsService.PolicyDetailResponseWrapper response = new AMFS_PolicyDetailsService.PolicyDetailResponseWrapper();
        response.Body = new AMFS_PolicyDetailsService.ResponseBody();
        response.Body.Customer = new AMFS_PolicyDetailsService.CustomerResponseWrapper();
        system.debug('INI DATA Anomali null');
        AMFS_PolicyDetailsService.BeIndividual ind = new AMFS_PolicyDetailsService.BeIndividual();
        ind.socialSecurityNO = null;
        
        response.Body.Customer.hasPolicyAccount = new List<AMFS_PolicyDetailsService.PolicyAccountResponseWrapper>();
        AMFS_PolicyDetailsService.PolicyAccountResponseWrapper pol = new AMFS_PolicyDetailsService.PolicyAccountResponseWrapper();
        pol.downPaymentPct = null;
        
        response.Body.Customer.canBeIndividual = ind;
        response.Body.Customer.hasPolicyAccount.add(pol);

        return response;
    }

    private static AMFS_PolicyDetailsService.PolicyDetailResponseWrapper mockResponseDataMissing() {
        AMFS_PolicyDetailsService.PolicyDetailResponseWrapper response = new AMFS_PolicyDetailsService.PolicyDetailResponseWrapper();
        response.Body = new AMFS_PolicyDetailsService.ResponseBody();
        response.Body.Customer = new AMFS_PolicyDetailsService.CustomerResponseWrapper();
        system.debug('INI DATA Anomali 2');
        AMFS_PolicyDetailsService.BeIndividual ind = new AMFS_PolicyDetailsService.BeIndividual();
        ind.socialSecurityNO = '123123123123';
        
        response.Body.Customer.hasPolicyAccount = new List<AMFS_PolicyDetailsService.PolicyAccountResponseWrapper>();
        AMFS_PolicyDetailsService.PolicyAccountResponseWrapper pol = new AMFS_PolicyDetailsService.PolicyAccountResponseWrapper();
        
        
        response.Body.Customer.canBeIndividual = ind;
        response.Body.Customer.hasPolicyAccount.add(pol);

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