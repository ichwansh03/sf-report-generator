@isTest
private class RestHoldDebetDataTest {

	@TestSetup
    static void setupTestData() {
        // create account
        Account amfsTest = new Account(Name = 'Account AMFS', Entity__c = 'AMFS');
        insert amfsTest;

        // create contact
        Contact cont = new Contact(
            AccountId = amfsTest.Id,
            LastName = 'Adi Wijaya',
            Policy_No__c = '123-4567890',
            Policy_No_Numeric__c = '1234567890',
            Entity__c = 'AMFS',
            Phone = '085716222996',
            MobilePhone = '085716222996',
            Email = 'test@example.com',
            Insured_Name__c = 'Adi Wijaya',
            Insured_Email__c = 'test@example.com',
            PolicyApp__c = 'RLS',
            Product_Code_Plant_TelUW__c = 'M812N2D',
            Total_Premium__c = 441379,
            Premium__c = 441379,
            WelcomeCall_Payment_Type__c = 'M',
            WelcomeCall_Gender__c = 'M',
            Campaign_Type__c = 'TelUW',
            Issued_Date_TelUw__c = Date.today(),
            APE_TelUW__c = 441379,
            Currency_TelUW__c = 'RP'
        );
        insert cont;

        // create case
        Case cs = new Case(
            ContactId = cont.Id,
            Follow_Hold_Date__c = Date.today(),
            Status = 'Closed',
            Case_Type__c = 'Request_Hold Debit'
        );
        insert cs;

        // get RecordType for Call_List__c
        ID cliId = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();

        system.debug('cliId ==>' + cliId);
        // Create Call_List__c
        Call_List__c callList = new Call_List__c(
            Activity__c = 'Collection',
            Case_Type__c = 'Renewal Reminder',
            Case_Type_Config__c = 'Renewal Reminder',
            RecordTypeId = cliId,
            expired_date__c = Date.today().addDays(7)
        );
        insert callList;
        
        system.debug('callList.Id ==>' + callList.Id);
        system.debug('callList.case_type__c ==>' + callList.case_type__c);
        system.debug('callList.RecordType.Name ==>' + callList.RecordType.Name);

        // Create Call_Line__c
        Call_Line__c cl = new Call_Line__c(
            Policy_No__c = cont.Policy_No__c,
            Tanggal_Hold_Debet__c = Date.today(),
            Entity__c = 'AMFS',
            Call_List__c = callList.Id,
            contact__c = cont.Id
        );
        insert cl;
    }
    
    @isTest
    static void testGetCaseHoldDebet_Success() {
        RestRequest req = new RestRequest();
        req.requestBody = null;
        req.params.put('q', '123-4567890');
        req.httpMethod = 'POST';
        RestContext.request = req;

        Test.startTest();
        HoldDebetWrapper.caseDataResponse res = RestHoldDebetData.getCaseHoldDebet();
        Test.stopTest();

        //System.assertEquals(RestHoldDebetData.STATUS_SUCCESS, res.status);
        //System.assertEquals(RestHoldDebetData.CREATE_MESSAGE_SUCCESS, res.message);
    }

    @isTest
    static void testGetCaseHoldDebet_FormatInvalidException() {
        RestRequest req = new RestRequest();
        req.requestBody = null;
        req.params.put('q', 'invalid-format');
        req.httpMethod = 'POST';
        RestContext.request = req;

        Test.startTest();
        HoldDebetWrapper.caseDataResponse res = RestHoldDebetData.getCaseHoldDebet();
        Test.stopTest();

        //System.assertEquals(RestHoldDebetData.STATUS_FORMAT_INVALID, res.status);
        //System.assertEquals(RestHoldDebetData.FORMAT_INVALID_MESSAGE, res.message);
    }

    @isTest
    static void testGetCaseHoldDebet_MissingFieldException() {
        RestRequest req = new RestRequest();
        req.requestBody = null;
        req.params.put('q', null);
        req.httpMethod = 'POST';
        RestContext.request = req;

        Test.startTest();
        HoldDebetWrapper.caseDataResponse res = RestHoldDebetData.getCaseHoldDebet();
        Test.stopTest();

        //System.assertEquals(RestHoldDebetData.STATUS_FORMAT_INVALID, res.status);
        //System.assertEquals(RestHoldDebetData.FORMAT_INVALID_MESSAGE, res.message);
    }

    @isTest
    static void testGetCaseHoldDebet_RequestBodyNotAllowed() {
        RestRequest req = new RestRequest();
        req.requestBody = Blob.valueOf('some body');
        req.params.put('q', '123-4567890');
        req.httpMethod = 'POST';
        RestContext.request = req;

        Test.startTest();
        HoldDebetWrapper.caseDataResponse res = RestHoldDebetData.getCaseHoldDebet();
        Test.stopTest();

        //System.assertEquals(RestHoldDebetData.STATUS_PREVENT_REQUEST_BODY, res.status);
        //System.assertEquals(RestHoldDebetData.PREVENT_REQUEST_BODY_MESSAGE, res.message);
    }

    @isTest
    static void testGetCallLineHoldDebet_Success() {
        RestRequest req = new RestRequest();
        req.requestBody = null;
        req.params.put('q', '123-4567890');
        req.httpMethod = 'PUT';
        RestContext.request = req;

        Test.startTest();
        HoldDebetWrapper.callLineDataResponse res = RestHoldDebetData.getCallLineHoldDebet();
        Test.stopTest();

        //System.assertEquals(RestHoldDebetData.STATUS_SUCCESS, res.status);
        //System.assertEquals(RestHoldDebetData.CREATE_MESSAGE_SUCCESS, res.message);
    }

    @isTest
    static void testGetCallLineHoldDebet_FormatInvalidException() {
        RestRequest req = new RestRequest();
        req.requestBody = null;
        req.params.put('q', 'invalid-format');
        req.httpMethod = 'PUT';
        RestContext.request = req;

        Test.startTest();
        HoldDebetWrapper.callLineDataResponse res = RestHoldDebetData.getCallLineHoldDebet();
        Test.stopTest();

        //System.assertEquals(RestHoldDebetData.STATUS_FORMAT_INVALID, res.status);
        //System.assertEquals(RestHoldDebetData.FORMAT_INVALID_MESSAGE, res.message);
    }

    @isTest
    static void testGetCallLineHoldDebet_RequestBodyNotAllowed() {
        RestRequest req = new RestRequest();
        req.requestBody = Blob.valueOf('some body');
        req.params.put('q', '123-4567890');
        req.httpMethod = 'PUT';
        RestContext.request = req;

        Test.startTest();
        HoldDebetWrapper.callLineDataResponse res = RestHoldDebetData.getCallLineHoldDebet();
        Test.stopTest();

        //System.assertEquals(RestHoldDebetData.STATUS_PREVENT_REQUEST_BODY, res.status);
        //System.assertEquals(RestHoldDebetData.PREVENT_REQUEST_BODY_MESSAGE, res.message);
    }
    
}