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
private class AMFS_AccountDetailsService_Test {

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
        lbad.Dokumen_Tambahan__c = 'FP5';
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
    static void testGetAccountDetailsFalse() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBody();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_AccountDetailsService.InputData input = new AMFS_AccountDetailsService.InputData();
        input.isLastCallout = false;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_AccountDetailsService.InputData> inputs = new List<AMFS_AccountDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_AccountDetailsService.OutputData> outputs = AMFS_AccountDetailsService.getAccountDetails(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetAccountDetailsTrue() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBody();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));
        
        // Create test input
        AMFS_AccountDetailsService.InputData input = new AMFS_AccountDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_AccountDetailsService.InputData> inputs = new List<AMFS_AccountDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_AccountDetailsService.OutputData> outputs = AMFS_AccountDetailsService.getAccountDetails(inputs);
        Test.stopTest();
    }
    @isTest
    static void testGetAccountDetailsTrueGuest() {
        User guestUser = [SELECT Id FROM User WHERE UserType = 'Guest' LIMIT 1];
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBody();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));
        
        // Create test input
        AMFS_AccountDetailsService.InputData input = new AMFS_AccountDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_AccountDetailsService.InputData> inputs = new List<AMFS_AccountDetailsService.InputData>{ input };
        
        Test.startTest();
        System.runAs(guestUser){
            List<AMFS_AccountDetailsService.OutputData> outputs = AMFS_AccountDetailsService.getAccountDetails(inputs);
            
        }
        Test.stopTest();
    }
    @isTest
    static void testGetAccountDetailsTrueCC() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyCC();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));
        
        // Create test input
        AMFS_AccountDetailsService.InputData input = new AMFS_AccountDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_AccountDetailsService.InputData> inputs = new List<AMFS_AccountDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_AccountDetailsService.OutputData> outputs = AMFS_AccountDetailsService.getAccountDetails(inputs);
        Test.stopTest();
    }
    @isTest
    static void testGetAccountDetailsTrueADS() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS ADS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBody();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));
        
        // Create test input
        AMFS_AccountDetailsService.InputData input = new AMFS_AccountDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_AccountDetailsService.InputData> inputs = new List<AMFS_AccountDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_AccountDetailsService.OutputData> outputs = AMFS_AccountDetailsService.getAccountDetails(inputs);
        Test.stopTest();
    }
    @isTest
    static void testGetAccountDetailsTrueADSCC() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS ADS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyCC();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));
        
        // Create test input
        AMFS_AccountDetailsService.InputData input = new AMFS_AccountDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_AccountDetailsService.InputData> inputs = new List<AMFS_AccountDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_AccountDetailsService.OutputData> outputs = AMFS_AccountDetailsService.getAccountDetails(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetAccountDetailsTrueDataNull() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataNull();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));
        
        // Create test input
        AMFS_AccountDetailsService.InputData input = new AMFS_AccountDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_AccountDetailsService.InputData> inputs = new List<AMFS_AccountDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_AccountDetailsService.OutputData> outputs = AMFS_AccountDetailsService.getAccountDetails(inputs);
        Test.stopTest();
    }
    @isTest
    static void testGetAccountDetailsTrueDataNullADS() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS ADS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataNull();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));
        
        // Create test input
        AMFS_AccountDetailsService.InputData input = new AMFS_AccountDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_AccountDetailsService.InputData> inputs = new List<AMFS_AccountDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_AccountDetailsService.OutputData> outputs = AMFS_AccountDetailsService.getAccountDetails(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetAccountDetailsTrueDataNotComplete() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataNotComplete();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_AccountDetailsService.InputData input = new AMFS_AccountDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_AccountDetailsService.InputData> inputs = new List<AMFS_AccountDetailsService.InputData>{ input };
        
        Test.startTest();
        AMFS_AccountDetailsService.throwEx = true;
        List<AMFS_AccountDetailsService.OutputData> outputs = AMFS_AccountDetailsService.getAccountDetails(inputs);
        Test.stopTest();
        
    }
    @isTest
    static void testGetAccountDetailsTrueDataNotCompleteADS() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS ADS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataNotComplete();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_AccountDetailsService.InputData input = new AMFS_AccountDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_AccountDetailsService.InputData> inputs = new List<AMFS_AccountDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_AccountDetailsService.OutputData> outputs = AMFS_AccountDetailsService.getAccountDetails(inputs);
        Test.stopTest();
        
    }

    @isTest
    static void testGetAccountDetailsTrueDataMissing() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataNotMissing();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_AccountDetailsService.InputData input = new AMFS_AccountDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_AccountDetailsService.InputData> inputs = new List<AMFS_AccountDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_AccountDetailsService.OutputData> outputs = AMFS_AccountDetailsService.getAccountDetails(inputs);
        Test.stopTest();
        
    }
    @isTest
    static void testGetAccountDetailsTrueDataMissingADS() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS ADS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataNotMissing();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_AccountDetailsService.InputData input = new AMFS_AccountDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_AccountDetailsService.InputData> inputs = new List<AMFS_AccountDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_AccountDetailsService.OutputData> outputs = AMFS_AccountDetailsService.getAccountDetails(inputs);
        Test.stopTest();
    }
    
    @isTest
    static void testGetAccountDetailsNoResponse() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', null));

        // Create test input
        AMFS_AccountDetailsService.InputData input = new AMFS_AccountDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_AccountDetailsService.InputData> inputs = new List<AMFS_AccountDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_AccountDetailsService.OutputData> outputs = AMFS_AccountDetailsService.getAccountDetails(inputs);
        Test.stopTest();
    }
    @isTest
    static void testGetAccountDetailsNoResponseCatch2() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        Test.startTest();
        AMFS_AccountDetailsService.successResponse('{ "name": "Test User", ');
        AMFS_AccountDetailsService.successResponseDMTM('{ "name": "Test User", ');
        Test.stopTest();
    }
    @isTest
    static void testGetAccountDetailsNoResponseADS() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS ADS' LIMIT 1];
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', null));

        // Create test input
        AMFS_AccountDetailsService.InputData input = new AMFS_AccountDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_AccountDetailsService.InputData> inputs = new List<AMFS_AccountDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_AccountDetailsService.OutputData> outputs = AMFS_AccountDetailsService.getAccountDetails(inputs);
        Test.stopTest();
        
    }

    @isTest
    static void testGetAccountDetailsLogTrue200Fail() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String exceptionBody = '{"Body": {"exception": {"code": "VALIDATION_ERROR", "message": "Data tidak valid"}}}';

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', exceptionBody));

        // Create test input
        AMFS_AccountDetailsService.InputData input = new AMFS_AccountDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_AccountDetailsService.InputData> inputs = new List<AMFS_AccountDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_AccountDetailsService.OutputData> outputs = AMFS_AccountDetailsService.getAccountDetails(inputs);
        Test.stopTest();
        
    }
    @isTest
    static void testGetAccountDetailsLogTrue200FailADS() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS ADS' LIMIT 1];
        
        String exceptionBody = '{"Body": {"exception": {"code": "VALIDATION_ERROR", "message": "Data tidak valid"}}}';

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', exceptionBody));

        // Create test input
        AMFS_AccountDetailsService.InputData input = new AMFS_AccountDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_AccountDetailsService.InputData> inputs = new List<AMFS_AccountDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_AccountDetailsService.OutputData> outputs = AMFS_AccountDetailsService.getAccountDetails(inputs);
        Test.stopTest();
        
    }

    @isTest
    static void testGetAccountDetailsLogTrue500Fail() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String errorBody = '{"Body": {"exception": {"code": "SERVER_ERROR", "message": "Internal server error"}}}';

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(500, 'OK', errorBody));

        // Create test input
        AMFS_AccountDetailsService.InputData input = new AMFS_AccountDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_AccountDetailsService.InputData> inputs = new List<AMFS_AccountDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_AccountDetailsService.OutputData> outputs = AMFS_AccountDetailsService.getAccountDetails(inputs);
        Test.stopTest();
        
    }

    @isTest
    static void testGetAccountDetailsLogTrue401Fail() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String errorBody = '{"errorCode": "AUTH_FAILED", "errorMessage": "Authentication failed", "Body": {}}';
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(401, 'OK', errorBody));

        // Create test input
        AMFS_AccountDetailsService.InputData input = new AMFS_AccountDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_AccountDetailsService.InputData> inputs = new List<AMFS_AccountDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_AccountDetailsService.OutputData> outputs = AMFS_AccountDetailsService.getAccountDetails(inputs);
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
        AMFS_AccountDetailsService.CustomerDetailResponseWrapper response = mockResponseDataComplete();
        return JSON.serialize(response);
    }
    private static String createMockSuccessResponseBodyCC() {
        AMFS_AccountDetailsService.CustomerDetailResponseWrapper response = mockResponseDataCompleteCC();
        return JSON.serialize(response);
    }

    private static String createMockSuccessResponseBodyDataNull() {
        AMFS_AccountDetailsService.CustomerDetailResponseWrapper response = mockResponseDataNull();
        return JSON.serialize(response);
    }

    private static String createMockSuccessResponseBodyDataNotComplete() {
        AMFS_AccountDetailsService.CustomerDetailResponseWrapper response = mockResponseDataNotComplete();
        return JSON.serialize(response);
    }

    private static String createMockSuccessResponseBodyDataNotMissing() {
        AMFS_AccountDetailsService.CustomerDetailResponseWrapper response = mockResponseDataMissing();
        return JSON.serialize(response);
    }

    private static AMFS_AccountDetailsService.CustomerDetailResponseWrapper mockResponseDataComplete() {
        AMFS_AccountDetailsService.CustomerDetailResponseWrapper response = new AMFS_AccountDetailsService.CustomerDetailResponseWrapper();
        response.Body = new AMFS_AccountDetailsService.ResponseBody();
        response.Body.Customer = new AMFS_AccountDetailsService.CustomerResponseWrapper();
        response.Body.Customer.hasPolicyAccount = new List<AMFS_AccountDetailsService.PolicyAccountWrapper>();
        
        AMFS_AccountDetailsService.PolicyAccountWrapper policyAccount1 = new AMFS_AccountDetailsService.PolicyAccountWrapper();
        policyAccount1.hasPartyDetailsIn = new List<AMFS_AccountDetailsService.PartyDetailsWrapper>();
        
        system.debug('INI DATA BENAR');
        AMFS_AccountDetailsService.PartyDetailsWrapper partyDetails1 = new AMFS_AccountDetailsService.PartyDetailsWrapper();
        partyDetails1.canBeIndividual = new AMFS_AccountDetailsService.IndividualWrapper();
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn = new AMFS_AccountDetailsService.PartyAccountDetailsInWrapper();
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.accountNO = '1234567890';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM = 'John';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM = 'Doe';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.bankName = 'Bank Central Asia';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.accountBankCD = 'B';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.accountStatusCD = 'B';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.accountTypeCD = 'SAVING';

        AMFS_AccountDetailsService.PartyDetailsWrapper partyDetails11 = new AMFS_AccountDetailsService.PartyDetailsWrapper();
        partyDetails11.canBeIndividual = new AMFS_AccountDetailsService.IndividualWrapper();
        partyDetails11.canBeIndividual.hasPartyAccountDetailsIn = new AMFS_AccountDetailsService.PartyAccountDetailsInWrapper();
        partyDetails11.canBeIndividual.hasPartyAccountDetailsIn.accountNO = '987653';
        partyDetails11.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM = 'MAMA';
        partyDetails11.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM = 'RIA';
        partyDetails11.canBeIndividual.hasPartyAccountDetailsIn.bankName = 'BMD';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.accountBankCD = 'B';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.accountStatusCD = 'B';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.accountTypeCD = 'SAVING';
        
        
        policyAccount1.hasPartyDetailsIn.add(partyDetails1);
        policyAccount1.hasPartyDetailsIn.add(partyDetails11);
        response.Body.Customer.hasPolicyAccount.add(policyAccount1);
        
        return response;
    }
    private static AMFS_AccountDetailsService.CustomerDetailResponseWrapper mockResponseDataCompleteCC() {
        AMFS_AccountDetailsService.CustomerDetailResponseWrapper response = new AMFS_AccountDetailsService.CustomerDetailResponseWrapper();
        response.Body = new AMFS_AccountDetailsService.ResponseBody();
        response.Body.Customer = new AMFS_AccountDetailsService.CustomerResponseWrapper();
        response.Body.Customer.hasPolicyAccount = new List<AMFS_AccountDetailsService.PolicyAccountWrapper>();
        
        AMFS_AccountDetailsService.PolicyAccountWrapper policyAccount1 = new AMFS_AccountDetailsService.PolicyAccountWrapper();
        policyAccount1.hasPartyDetailsIn = new List<AMFS_AccountDetailsService.PartyDetailsWrapper>();
        
        system.debug('INI DATA BENAR');
        AMFS_AccountDetailsService.PartyDetailsWrapper partyDetails1 = new AMFS_AccountDetailsService.PartyDetailsWrapper();
        partyDetails1.canBeIndividual = new AMFS_AccountDetailsService.IndividualWrapper();
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn = new AMFS_AccountDetailsService.PartyAccountDetailsInWrapper();
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.accountNO = '1234567890';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM = 'John';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM = 'Doe';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.bankName = 'Bank Central Asia';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.accountBankCD = 'B';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.accountStatusCD = 'B';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.accountTypeCD = 'CREDITCARD';

        AMFS_AccountDetailsService.PartyDetailsWrapper partyDetails11 = new AMFS_AccountDetailsService.PartyDetailsWrapper();
        partyDetails11.canBeIndividual = new AMFS_AccountDetailsService.IndividualWrapper();
        partyDetails11.canBeIndividual.hasPartyAccountDetailsIn = new AMFS_AccountDetailsService.PartyAccountDetailsInWrapper();
        partyDetails11.canBeIndividual.hasPartyAccountDetailsIn.accountNO = '987653';
        partyDetails11.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM = 'MAMA';
        partyDetails11.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM = 'RIA';
        partyDetails11.canBeIndividual.hasPartyAccountDetailsIn.bankName = 'BMD';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.accountBankCD = 'B';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.accountStatusCD = 'B';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.accountTypeCD = 'CREDITCARD';
        
        
        policyAccount1.hasPartyDetailsIn.add(partyDetails1);
        policyAccount1.hasPartyDetailsIn.add(partyDetails11);
        response.Body.Customer.hasPolicyAccount.add(policyAccount1);
        
        return response;
    }

    private static AMFS_AccountDetailsService.CustomerDetailResponseWrapper mockResponseDataNotComplete() {
        AMFS_AccountDetailsService.CustomerDetailResponseWrapper response = new AMFS_AccountDetailsService.CustomerDetailResponseWrapper();
        response.Body = new AMFS_AccountDetailsService.ResponseBody();
        response.Body.Customer = new AMFS_AccountDetailsService.CustomerResponseWrapper();
        response.Body.Customer.hasPolicyAccount = new List<AMFS_AccountDetailsService.PolicyAccountWrapper>();
        
        AMFS_AccountDetailsService.PolicyAccountWrapper policyAccount1 = new AMFS_AccountDetailsService.PolicyAccountWrapper();
        policyAccount1.hasPartyDetailsIn = new List<AMFS_AccountDetailsService.PartyDetailsWrapper>();
        system.debug('INI DATA Anomali 1');
        AMFS_AccountDetailsService.PartyDetailsWrapper partyDetails1 = new AMFS_AccountDetailsService.PartyDetailsWrapper();
        partyDetails1.canBeIndividual = new AMFS_AccountDetailsService.IndividualWrapper();
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn = new AMFS_AccountDetailsService.PartyAccountDetailsInWrapper();
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.accountNO =  '                             ';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM =  '                              ';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM = '      ';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.bankName = '       ';
        
        
        policyAccount1.hasPartyDetailsIn.add(partyDetails1);
        response.Body.Customer.hasPolicyAccount.add(policyAccount1);
        
        return response;
    }

    private static AMFS_AccountDetailsService.CustomerDetailResponseWrapper mockResponseDataNull() {
        AMFS_AccountDetailsService.CustomerDetailResponseWrapper response = new AMFS_AccountDetailsService.CustomerDetailResponseWrapper();
        response.Body = new AMFS_AccountDetailsService.ResponseBody();
        response.Body.Customer = new AMFS_AccountDetailsService.CustomerResponseWrapper();
        response.Body.Customer.hasPolicyAccount = new List<AMFS_AccountDetailsService.PolicyAccountWrapper>();
        Datetime dummy = Datetime.now();
        String dummyFormat = dummy.format('dd/MM/yyyy');
        AMFS_AccountDetailsService.PolicyAccountWrapper policyAccount1 = new AMFS_AccountDetailsService.PolicyAccountWrapper();
        policyAccount1.hasPartyDetailsIn = new List<AMFS_AccountDetailsService.PartyDetailsWrapper>();
        system.debug('INI DATA Anomali 1 dengan null');
        AMFS_AccountDetailsService.PartyDetailsWrapper partyDetails1 = new AMFS_AccountDetailsService.PartyDetailsWrapper();
        partyDetails1.canBeIndividual = new AMFS_AccountDetailsService.IndividualWrapper();
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn = new AMFS_AccountDetailsService.PartyAccountDetailsInWrapper();
        
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.accountNO = dummyFormat;
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM = null;
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM = null;
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.bankName = null;
        
        
        policyAccount1.hasPartyDetailsIn.add(partyDetails1);
        response.Body.Customer.hasPolicyAccount.add(policyAccount1);
        
        return response;
    }

    private static AMFS_AccountDetailsService.CustomerDetailResponseWrapper mockResponseDataMissing() {
        AMFS_AccountDetailsService.CustomerDetailResponseWrapper response = new AMFS_AccountDetailsService.CustomerDetailResponseWrapper();
        response.Body = new AMFS_AccountDetailsService.ResponseBody();
        response.Body.Customer = new AMFS_AccountDetailsService.CustomerResponseWrapper();
        response.Body.Customer.hasPolicyAccount = new List<AMFS_AccountDetailsService.PolicyAccountWrapper>();
        
        AMFS_AccountDetailsService.PolicyAccountWrapper policyAccount1 = new AMFS_AccountDetailsService.PolicyAccountWrapper();
        policyAccount1.hasPartyDetailsIn = new List<AMFS_AccountDetailsService.PartyDetailsWrapper>();
        system.debug('INI DATA Anomali 2');
        AMFS_AccountDetailsService.PartyDetailsWrapper partyDetails1 = new AMFS_AccountDetailsService.PartyDetailsWrapper();
        partyDetails1.canBeIndividual = new AMFS_AccountDetailsService.IndividualWrapper();
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn = new AMFS_AccountDetailsService.PartyAccountDetailsInWrapper();
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.accountNO = '         ';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM = 'John John Data Missing';
        partyDetails1.canBeIndividual.hasPartyAccountDetailsIn.bankName = 'Bank Central Asia';
        
        policyAccount1.hasPartyDetailsIn.add(partyDetails1);
        response.Body.Customer.hasPolicyAccount.add(policyAccount1);
        
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