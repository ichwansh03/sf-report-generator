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
private class AMFS_FundDetailsService_Test {


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
    static void testGetFundDetailsFalse() {
        Master_Fund_Code__c nameFund = [SELECT Id, Name, Desc_Fun_Code__c, Plan_Code__c FROM Master_Fund_Code__c WHERE Plan_Code__c = : 'HONMPH' AND Name =:'ZRSM' LIMIT 1];
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBody();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_FundDetailsService.InputData input = new AMFS_FundDetailsService.InputData();
        input.isLastCallout = false;
        input.logBookActivityDetailId = lbad.Id;
        input.fundCode = nameFund.Plan_Code__c;

        List<AMFS_FundDetailsService.InputData> inputs = new List<AMFS_FundDetailsService.InputData>{ input };
        
        Test.startTest();
        system.debug('testGetFundDetailsFalse');
        List<AMFS_FundDetailsService.OutputData> outputs = AMFS_FundDetailsService.getFundDetails(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetFundDetailsTrue() {
        Master_Fund_Code__c nameFund = [SELECT Id, Name, Desc_Fun_Code__c, Plan_Code__c FROM Master_Fund_Code__c WHERE Plan_Code__c = : 'HONMPH' AND Name =:'ZRSM' LIMIT 1];
                
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBody();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_FundDetailsService.InputData input = new AMFS_FundDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;
        input.fundCode = nameFund.Plan_Code__c;

        List<AMFS_FundDetailsService.InputData> inputs = new List<AMFS_FundDetailsService.InputData>{ input };
        
        Test.startTest();
        system.debug('testGetFundDetailsTrue');
        List<AMFS_FundDetailsService.OutputData> outputs = AMFS_FundDetailsService.getFundDetails(inputs);
        Test.stopTest();
    }
    @isTest
    static void testGetFundDetailsTrueGuest() {
        User guestUser = [SELECT Id FROM User WHERE UserType = 'Guest' LIMIT 1];
        Master_Fund_Code__c nameFund = [SELECT Id, Name, Desc_Fun_Code__c, Plan_Code__c FROM Master_Fund_Code__c WHERE Plan_Code__c = : 'HONMPH' AND Name =:'ZRSM' LIMIT 1];
                
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBody();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_FundDetailsService.InputData input = new AMFS_FundDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;
        input.fundCode = nameFund.Plan_Code__c;

        List<AMFS_FundDetailsService.InputData> inputs = new List<AMFS_FundDetailsService.InputData>{ input };
        
        Test.startTest();
        system.debug('testGetFundDetailsTrue');
        System.runAs(guestUser){
            List<AMFS_FundDetailsService.OutputData> outputs = AMFS_FundDetailsService.getFundDetails(inputs);
        }
        Test.stopTest();
    }

    @isTest
    static void testGetFundDetailsTrueDataNotComplete() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataNotComplete();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_FundDetailsService.InputData input = new AMFS_FundDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_FundDetailsService.InputData> inputs = new List<AMFS_FundDetailsService.InputData>{ input };
        
        Test.startTest();
        system.debug('testGetFundDetailsTrueDataNotComplete');
        AMFS_FundDetailsService.throwEx = true;
        List<AMFS_FundDetailsService.OutputData> outputs = AMFS_FundDetailsService.getFundDetails(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetFundDetailsTrueDataNull() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataNull();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_FundDetailsService.InputData input = new AMFS_FundDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_FundDetailsService.InputData> inputs = new List<AMFS_FundDetailsService.InputData>{ input };
        
        Test.startTest();
        system.debug('testGetFundDetailsTrueDataNull');
        List<AMFS_FundDetailsService.OutputData> outputs = AMFS_FundDetailsService.getFundDetails(inputs);
        Test.stopTest();   
    }
    @isTest
    static void testGetFundDetailsTrueDataEx() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataEx();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_FundDetailsService.InputData input = new AMFS_FundDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_FundDetailsService.InputData> inputs = new List<AMFS_FundDetailsService.InputData>{ input };
        
        Test.startTest();
        system.debug('testGetFundDetailsTrueDataNull');
        List<AMFS_FundDetailsService.OutputData> outputs = AMFS_FundDetailsService.getFundDetails(inputs);
        Test.stopTest();   
    }

    @isTest
    static void testGetFundDetailsTrueDataMissing() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String mockResponseBody = createMockSuccessResponseBodyDataMissing();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', mockResponseBody));

        // Create test input
        AMFS_FundDetailsService.InputData input = new AMFS_FundDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_FundDetailsService.InputData> inputs = new List<AMFS_FundDetailsService.InputData>{ input };
        
        Test.startTest();
        system.debug('testGetFundDetailsTrueDataMissing');
        List<AMFS_FundDetailsService.OutputData> outputs = AMFS_FundDetailsService.getFundDetails(inputs);
        Test.stopTest();   
    }

    @isTest
    static void testGetFundDetailsTrueDataNoResponse() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', null));

        // Create test input
        AMFS_FundDetailsService.InputData input = new AMFS_FundDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_FundDetailsService.InputData> inputs = new List<AMFS_FundDetailsService.InputData>{ input };
        
        Test.startTest();
        system.debug('testGetFundDetailsTrueDataNoResponse');
        List<AMFS_FundDetailsService.OutputData> outputs = AMFS_FundDetailsService.getFundDetails(inputs);
        Test.stopTest();
    }
    @isTest
    static void testGetAccountDetailsNoResponseCatch2() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        Test.startTest();
        AMFS_FundDetailsService.successResponse('{ "name": "Test User", ', 'ZRSM');
        // AMFS_FundDetailsService.successResponseDMTM('{ "name": "Test User", ');
        Test.stopTest();
    }
    @isTest
    static void testGetFundDetailsTrueDataNoResponseEx() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', ''));

        // Create test input
        AMFS_FundDetailsService.InputData input = new AMFS_FundDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_FundDetailsService.InputData> inputs = new List<AMFS_FundDetailsService.InputData>{ input };
        
        Test.startTest();
        system.debug('testGetFundDetailsTrueDataNoResponse');
        List<AMFS_FundDetailsService.OutputData> outputs = AMFS_FundDetailsService.getFundDetails(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetFundDetailsTrueResponse500Fail() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String errorBody = '{"Body": {"exception": {"code": "SERVER_ERROR", "message": "Internal server error"}}}';

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(500, 'OK', errorBody));

        // Create test input
        AMFS_FundDetailsService.InputData input = new AMFS_FundDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_FundDetailsService.InputData> inputs = new List<AMFS_FundDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_FundDetailsService.OutputData> outputs = AMFS_FundDetailsService.getFundDetails(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetFundDetailsTrueResponse401Fail() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String errorBody = '{"errorCode": "AUTH_FAILED", "errorMessage": "Authentication failed", "Body": {}}';
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(401, 'OK', errorBody));

        // Create test input
        AMFS_FundDetailsService.InputData input = new AMFS_FundDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_FundDetailsService.InputData> inputs = new List<AMFS_FundDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_FundDetailsService.OutputData> outputs = AMFS_FundDetailsService.getFundDetails(inputs);
        Test.stopTest();
    }

    @isTest
    static void testGetCustomerProfileTrueResponse200Fail() {
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c =: 'JOHN DUMMY AMFS RLS' LIMIT 1];
        
        String exceptionBody = '{"Body": {"exception": {"code": "VALIDATION_ERROR", "message": "Data tidak valid"}}}';

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'OK', exceptionBody));

        // Create test input
        AMFS_FundDetailsService.InputData input = new AMFS_FundDetailsService.InputData();
        input.isLastCallout = true;
        input.logBookActivityDetailId = lbad.Id;

        List<AMFS_FundDetailsService.InputData> inputs = new List<AMFS_FundDetailsService.InputData>{ input };
        
        Test.startTest();
        List<AMFS_FundDetailsService.OutputData> outputs = AMFS_FundDetailsService.getFundDetails(inputs);
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
        AMFS_FundDetailsService.FundDetailResponseWrapper response = mockResponseDataComplete();
        return JSON.serialize(response);
    }

    private static String createMockSuccessResponseBodyDataNotComplete() {
        AMFS_FundDetailsService.FundDetailResponseWrapper response = mockResponseDataNotComplete();
        return JSON.serialize(response);
    }

    private static String createMockSuccessResponseBodyDataNull() {
        AMFS_FundDetailsService.FundDetailResponseWrapper response = mockResponseDataNull();
        return JSON.serialize(response);
    }
    private static String createMockSuccessResponseBodyDataEx() {
        AMFS_FundDetailsService.FundDetailResponseWrapper response = mockResponseDataEx();
        return JSON.serialize(response);
    }

    private static String createMockSuccessResponseBodyDataMissing() {
        AMFS_FundDetailsService.FundDetailResponseWrapper response = mockResponseDataMissing();
        return JSON.serialize(response);
    }

    private static AMFS_FundDetailsService.FundDetailResponseWrapper mockResponseDataComplete() {
        AMFS_FundDetailsService.FundDetailResponseWrapper response = new AMFS_FundDetailsService.FundDetailResponseWrapper();
        response.Body = new AMFS_FundDetailsService.ResponseBody();
        response.Body.Policy = new AMFS_FundDetailsService.PolicyResponseWrapper();
        response.Body.Policy.hasAccountDetailsIn = new List<AMFS_FundDetailsService.AccountDetailWrapper>();
        system.debug('INI DATA BENAR');
        AMFS_FundDetailsService.AccountDetailWrapper acc = new AMFS_FundDetailsService.AccountDetailWrapper();
        acc.hasInvestmentFundDetailsIn = new List<AMFS_FundDetailsService.InvestmentFundDetailsInWrapper>();

        AMFS_FundDetailsService.InvestmentFundDetailsInWrapper invest0 = new AMFS_FundDetailsService.InvestmentFundDetailsInWrapper();
        invest0.fundAllocation = '25.00';
        invest0.investmentFundCd = 'ZRSM';
        invest0.totalFundAmount = '1738764.35';

        AMFS_FundDetailsService.InvestmentFundDetailsInWrapper invest1 = new AMFS_FundDetailsService.InvestmentFundDetailsInWrapper();
        invest1.fundAllocation = '25.00';
        invest1.investmentFundCd = 'ZRSM';
        invest1.totalFundAmount = '1738764.35';

        AMFS_FundDetailsService.InvestmentFundDetailsInWrapper invest2 = new AMFS_FundDetailsService.InvestmentFundDetailsInWrapper();
        invest2.fundAllocation = '25.00';
        invest2.investmentFundCd = 'ZRSM';
        invest2.totalFundAmount = '1738764.35';

        AMFS_FundDetailsService.InvestmentFundDetailsInWrapper invest3 = new AMFS_FundDetailsService.InvestmentFundDetailsInWrapper();
        invest3.fundAllocation = '25.00';
        invest3.investmentFundCd = 'ZRSM';
        invest3.totalFundAmount = '1738764.35';

        acc.hasInvestmentFundDetailsIn.add(invest0);
        acc.hasInvestmentFundDetailsIn.add(invest1);
        acc.hasInvestmentFundDetailsIn.add(invest2);
        acc.hasInvestmentFundDetailsIn.add(invest3);

        response.Body.Policy.hasAccountDetailsIn.add(acc);
        return response;
    }

    private static AMFS_FundDetailsService.FundDetailResponseWrapper mockResponseDataNotComplete() {
        AMFS_FundDetailsService.FundDetailResponseWrapper response = new AMFS_FundDetailsService.FundDetailResponseWrapper();
        response.Body = new AMFS_FundDetailsService.ResponseBody();
        response.Body.Policy = new AMFS_FundDetailsService.PolicyResponseWrapper();
        response.Body.Policy.hasAccountDetailsIn = new List<AMFS_FundDetailsService.AccountDetailWrapper>();
        system.debug('INI DATA Anomali 1');
        AMFS_FundDetailsService.AccountDetailWrapper acc = new AMFS_FundDetailsService.AccountDetailWrapper();
        acc.hasInvestmentFundDetailsIn = new List<AMFS_FundDetailsService.InvestmentFundDetailsInWrapper>();

        AMFS_FundDetailsService.InvestmentFundDetailsInWrapper invest0 = new AMFS_FundDetailsService.InvestmentFundDetailsInWrapper();
        invest0.fundAllocation = ' ';
        invest0.investmentFundCd = '                              ';
        invest0.totalFundAmount = ' ';

        AMFS_FundDetailsService.InvestmentFundDetailsInWrapper invest1 = new AMFS_FundDetailsService.InvestmentFundDetailsInWrapper();
        invest1.fundAllocation =' ';
        invest1.investmentFundCd = '                              ';
        invest1.totalFundAmount = ' ';

        AMFS_FundDetailsService.InvestmentFundDetailsInWrapper invest2 = new AMFS_FundDetailsService.InvestmentFundDetailsInWrapper();
        invest2.fundAllocation = ' ';
        invest2.investmentFundCd = '                              ';
        invest2.totalFundAmount =  ' ';

        AMFS_FundDetailsService.InvestmentFundDetailsInWrapper invest3 = new AMFS_FundDetailsService.InvestmentFundDetailsInWrapper();
        invest3.fundAllocation =  ' ';
        invest3.investmentFundCd = '                              ';
        invest3.totalFundAmount =  ' ';

        acc.hasInvestmentFundDetailsIn.add(invest0);
        acc.hasInvestmentFundDetailsIn.add(invest1);
        acc.hasInvestmentFundDetailsIn.add(invest2);
        acc.hasInvestmentFundDetailsIn.add(invest3);

        response.Body.Policy.hasAccountDetailsIn.add(acc);
        return response;
    }

    private static AMFS_FundDetailsService.FundDetailResponseWrapper mockResponseDataNull() {
        AMFS_FundDetailsService.FundDetailResponseWrapper response = new AMFS_FundDetailsService.FundDetailResponseWrapper();
        response.Body = new AMFS_FundDetailsService.ResponseBody();
        response.Body.Policy = new AMFS_FundDetailsService.PolicyResponseWrapper();
        response.Body.Policy.hasAccountDetailsIn = new List<AMFS_FundDetailsService.AccountDetailWrapper>();

        AMFS_FundDetailsService.AccountDetailWrapper acc = new AMFS_FundDetailsService.AccountDetailWrapper();
        acc.hasInvestmentFundDetailsIn = new List<AMFS_FundDetailsService.InvestmentFundDetailsInWrapper>();
        system.debug('INI DATA Anomali 1 dengan null');
        AMFS_FundDetailsService.InvestmentFundDetailsInWrapper invest0 = new AMFS_FundDetailsService.InvestmentFundDetailsInWrapper();
        invest0.fundAllocation = '2025/09/21';
        invest0.investmentFundCd = '2025/09/21';
        invest0.totalFundAmount = '2025/09/21';


        acc.hasInvestmentFundDetailsIn.add(invest0);

        response.Body.Policy.hasAccountDetailsIn.add(acc);
        return response;
    }
    private static AMFS_FundDetailsService.FundDetailResponseWrapper mockResponseDataEx() {
        AMFS_FundDetailsService.FundDetailResponseWrapper response = new AMFS_FundDetailsService.FundDetailResponseWrapper();
        response.Body = new AMFS_FundDetailsService.ResponseBody();
        response.Body.Policy = new AMFS_FundDetailsService.PolicyResponseWrapper();
        response.Body.Policy.hasAccountDetailsIn = new List<AMFS_FundDetailsService.AccountDetailWrapper>();

        AMFS_FundDetailsService.AccountDetailWrapper acc = new AMFS_FundDetailsService.AccountDetailWrapper();
        acc.hasInvestmentFundDetailsIn = new List<AMFS_FundDetailsService.InvestmentFundDetailsInWrapper>();
        system.debug('INI DATA Anomali 1 dengan null');
        AMFS_FundDetailsService.InvestmentFundDetailsInWrapper invest0 = new AMFS_FundDetailsService.InvestmentFundDetailsInWrapper();
        invest0.fundAllocation = null;
        invest0.investmentFundCd = null;
        invest0.totalFundAmount = null;

        AMFS_FundDetailsService.InvestmentFundDetailsInWrapper invest1 = new AMFS_FundDetailsService.InvestmentFundDetailsInWrapper();
        invest1.fundAllocation = null;
        invest1.investmentFundCd = null;
        invest1.totalFundAmount =  null;

        AMFS_FundDetailsService.InvestmentFundDetailsInWrapper invest2 = new AMFS_FundDetailsService.InvestmentFundDetailsInWrapper();
        invest2.fundAllocation = null;
        invest2.investmentFundCd = null;
        invest2.totalFundAmount = null;

        AMFS_FundDetailsService.InvestmentFundDetailsInWrapper invest3 = new AMFS_FundDetailsService.InvestmentFundDetailsInWrapper();
        invest3.fundAllocation =  null;
        invest3.investmentFundCd = null;
        invest3.totalFundAmount = null;

        acc.hasInvestmentFundDetailsIn.add(invest0);
        acc.hasInvestmentFundDetailsIn.add(invest1);
        acc.hasInvestmentFundDetailsIn.add(invest2);
        acc.hasInvestmentFundDetailsIn.add(invest3);

        response.Body.Policy.hasAccountDetailsIn.add(acc);
        return response;
    }
    private static AMFS_FundDetailsService.FundDetailResponseWrapper mockResponseDataMissing() {
        AMFS_FundDetailsService.FundDetailResponseWrapper response = new AMFS_FundDetailsService.FundDetailResponseWrapper();
        response.Body = new AMFS_FundDetailsService.ResponseBody();
        response.Body.Policy = new AMFS_FundDetailsService.PolicyResponseWrapper();
        response.Body.Policy.hasAccountDetailsIn = new List<AMFS_FundDetailsService.AccountDetailWrapper>();
        system.debug('INI DATA Anomali 2');
        AMFS_FundDetailsService.AccountDetailWrapper acc = new AMFS_FundDetailsService.AccountDetailWrapper();
        acc.hasInvestmentFundDetailsIn = new List<AMFS_FundDetailsService.InvestmentFundDetailsInWrapper>();

        AMFS_FundDetailsService.InvestmentFundDetailsInWrapper invest0 = new AMFS_FundDetailsService.InvestmentFundDetailsInWrapper();
        invest0.investmentFundCd = '                              ';

        AMFS_FundDetailsService.InvestmentFundDetailsInWrapper invest1 = new AMFS_FundDetailsService.InvestmentFundDetailsInWrapper();
        invest1.fundAllocation = '.00';
        invest1.totalFundAmount =   '.00';

        AMFS_FundDetailsService.InvestmentFundDetailsInWrapper invest2 = new AMFS_FundDetailsService.InvestmentFundDetailsInWrapper();
        invest2.totalFundAmount = '    ';

        AMFS_FundDetailsService.InvestmentFundDetailsInWrapper invest3 = new AMFS_FundDetailsService.InvestmentFundDetailsInWrapper();
        invest3.fundAllocation = '.00';
        invest3.totalFundAmount =  '     ';

        acc.hasInvestmentFundDetailsIn.add(invest0);
        acc.hasInvestmentFundDetailsIn.add(invest1);
        acc.hasInvestmentFundDetailsIn.add(invest2);
        acc.hasInvestmentFundDetailsIn.add(invest3);

        response.Body.Policy.hasAccountDetailsIn.add(acc);
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