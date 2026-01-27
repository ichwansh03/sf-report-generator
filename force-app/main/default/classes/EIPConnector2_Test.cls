@isTest (seeAllData = true)
public class EIPConnector2_Test {
    
    static testmethod void testJson(){
        EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
        
        // construct for object Body
        eipRequestBody.service = 'service';
        eipRequestBody.transactionId = '123456789';
        eipRequestBody.entity = 'entity';
        eipRequestBody.appID = 'appId';
        eipRequestBody.operation = 'operation';
        
        // construct policy number
        EIPJson.EIP_AgSa_InsurancePolicy policyNumberJson = new EIPJson.EIP_AgSa_InsurancePolicy();
        policyNumberJson.policyNO = 'policyNumber';
        
        // construct customer type
        EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson= new EIPJson.EIP_IcAx_AXAAsiaCustomer();
        customerTypeJson.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{policyNumberJson};
            eipRequestBody.IcAx_AXAAsiaCustomer_Type = customerTypeJson;
        
        
        EIPJson requestPolicyDetail = new EIPJson();
        requestPolicyDetail.Body = eipRequestBody;
        
        String requestJsonEIP = requestPolicyDetail.toStringJSON();
        EIPConnector.getRequestPrettyPrint();
		EIPConnector.getResponsePrettyPrint();
        EIPConnector.getSignature();
        System.debug(requestJsonEIP);
        System.assert(null != requestJsonEIP);
    }
    
    static testmethod void testGetAccessToken(){
       	// Set mock callout class 
    	// Set mock response
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());

        Test.startTest();
        EIPJSON result = EIPCONNECTOR.getAccessTokenAMFS();
        Test.stopTest();
    }
    
    static testMethod void testSendRequestUpdate() {
        // Arrange
        Session_Data__c session = new Session_Data__c();
        session.signature_data__c = 'test-signature';
        session.data_request__c = '{"request":"data"}';
        session.data__c = '{"response":"data"}';
        insert session;
        
        // Act
        Test.startTest();
        EIPJson result = EIPConnector.sendRequest('test-signature', '{"request":"data"}', 'testDomain');
        Test.stopTest();
        
        // Assert
        System.assertNotEquals(null, result);
    }
    
    static testMethod void testSendRequestInsert() {
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        EIPConnector.allowInsertSession = true;
        
        // Act
        Test.startTest();
        // EIPJson result = EIPConnector.sendRequest('new-signature', '{"request":"data"}', 'testDomain');
        Test.stopTest();
        
        // Verify that a new session was inserted
        // List<Session_Data__c> sessions = [SELECT Id FROM Session_Data__c LIMIT 1];
        // System.assertEquals(1, sessions.size());
        
        // Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        /* try{
            EIPConnector.sendRequest('TRIGGER_OFFLINE', 'TRIGGER_OFFLINE', 'testDomain');
        } catch (EIPConnector.NoDataException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
        
        try{
            EIPConnector.sendRequest('TRIGGER_EIPEXC', 'TRIGGER_EIPEXC', 'testDomain');
        } catch (EIPConnector.EIPConnectorException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        } */
    }

    
    static testmethod void testGetPaymentHistory(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getPaymentHistory');
            result =  EIPConnector.getPaymentHistory('Payment', 'AFI', 'BIS', 'CMS051130334853');
            System.debug('getPaymentHistory is success');
            System.debug('response :' + result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getPaymentHistory is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetPremiumBreakdown(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getPremiumBreakdown');
            result =  EIPConnector.getPremiumBreakdown('Premium Breakdown', 'AFI', 'RLS', '509-1031335');
            System.debug('getPremiumBreakdown is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getPremiumBreakdown is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetBeneficiaryDetail(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getBeneficiaryDetail');
            result =  EIPConnector.getBeneficiaryDetail('Beneficiary', 'AFI', 'RLS', '509-1031335');
            System.debug('getBeneficiaryDetail is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getBeneficiaryDetail is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetFundDetail(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getFundDetail');
            result =  EIPConnector.getFundDetail('Fund', 'AMFS', 'RLS', '515-7682187');
            System.debug('getFundDetail is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getFundDetail is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetCustomerInfo(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getCustomerInfo');
            result =  EIPConnector.getCustomerInfo('Customer Profile', 'AMFS', 'RLS', '515-3881890');
            
            System.debug('getCustomerInfo is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getCustomerInfo is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
        
        // Error paths (three independent throws)
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        Boolean c1=false, c2=false, c3=false;
        
        /* try {
            EIPConnector.getCustomerInfo('Customer Profile', 'AMFS', 'RLS', 'TRIGGER_EIPEXC');
            System.assert(false, 'getCustomerInfo should have thrown');
        } catch (EIPConnector.EIPConnectorException e) { c1 = true; }
        
        try {
            EIPConnector.getCustomerInfo('Customer Profile', 'AMFS', 'RLS', 'TRIGGER_OFFLINE');
            System.assert(false, 'getCustomerInfo should have thrown');
        } catch (EIPConnector.NoDataException e) { c2 = true; }
        
        try {
            EIPConnector.getCustomerInfo('Customer Profile', 'AMFS', 'RLS', 'TRIGGER_BADJSON');
            System.assert(false, 'getCustomerInfo should have thrown');
        } catch (EIPConnector.EIPException e) { c3 = true; } */
        
        // System.assertEquals(true, c1 && c2 && c3, 'All three error paths must throw');
    }
    
    static testmethod void testGetPolicyDetails(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getPolicyDetails');
            result =  EIPConnector.getPolicyDetails('Policy Details', 'AMFS', 'RLS', '515-3881890');
            System.debug('getPolicyDetails is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getPolicyDetails is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetFraud(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getPolicyDetails');
            result =  EIPConnector.getPolicyFraud('Policy Details', 'AMFS', 'RLS', '315-4220754', '167531');
            System.debug('getFraud is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getPolicyDetails is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
        
        // Error paths (three independent throws)
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        Boolean c1=false, c2=false, c3=false;
        
    }
    
    static testmethod void testGetPolicyDetailsDMU(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getPolicyDetails');
            //adding map data
            Map<String,String> maping = new Map<String,String>();
            maping.put('applicationRk','DMU');
            maping.put('validFromDttm',String.valueOF(date.today()));
            maping.put('validToDttm',String.valueOF(date.today()));
            maping.put('sourceCInd','001');
            maping.put('documentID','DOC001');
            maping.put('customerClassCD','CLN001');
            
            
            result =  EIPConnector.getPolicyDetails('Policy Details', 'AMFS', 'RLS','501-223122', maping);
            System.debug('getPolicyDetails is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getPolicyDetails is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetClaimDetails(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getClaimDetails');
            result =  EIPConnector.getClaimDetails('Claim', 'AMFS', 'RLS', '515-3881890','');
            System.debug('getClaimDetails is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getClaimDetails is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetAgentInfo(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getAgentInfo');
            result =  EIPConnector.getAgentInfo('Agent Info', 'AMFS', 'RLS', '010206', null);
            System.debug('getAgentInfo is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getAgentInfo is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetFundHistory(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getFundHistory');
            result =  EIPConnector.getFundHistory('Fund', 'AMFS', 'RLS', '510-0387991', '2016-02-01', '2018-11-16');
            System.debug('getFundHistory is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getFundHistory is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetFundPriceHistory(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getFundPriceHistory');
            result =  EIPConnector.getFundPriceHistory('Fund', 'AMFS', 'RLS', '','20180102');
            System.debug('getFundPriceHistory is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getFundPriceHistory is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetFundPriceHistoryWithFund(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getFundPriceHistory');
            result = EIPConnector.getFundPriceHistory(EIPConstant.OPERATION_FUND, 'AFI', 'RLS', 'ARP', '20200801','20200901');
            System.debug('getFundPriceHistory is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getFundPriceHistory is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetAssNotes(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getAssNotes');
            result =  EIPConnector.getAssNotes('Detail', 'AMFS', 'RLS', '515-3881890', 'CLM', '0141123', null);
            System.debug('getAssNotes is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getAssNotes is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetGIClaimDetail(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        EIPJson result2 = new EIPJson();
        EIPJson result3 = new EIPJson();
        try{
            System.debug('========== callout - getGIClaimDetail');
            Map<String,String> validDttm = new Map<String,String>();
            validDttm.put(EIPConstant.VALID_FROM_DTTM, '20010728');
            validDttm.put(EIPConstant.VALID_TO_DTTM, '20200728');
            // result2 = EIPConnector.getGIClaimDetail('Claim', 'MAGI', 'PSEA', '00204302');
            result =  EIPConnector.getGIClaimDetail('Claim', 'MAGI', 'PSEA', '00204302', validDttm);
            System.debug('getGIClaimDetail is success');
            System.debug('response :'+result);
            System.debug('response :'+result2);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getGIClaimDetail is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetGIPolicyDetail(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getGIPolicyDetail');
            result =  EIPConnector.getGIPolicyDetail('Policy Details', 'MAGI', 'PSEA', '00191247', null);
            System.debug('getGIPolicyDetail is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getGIPolicyDetail is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetToken(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getToken');
            Map<String,String> mapParamMidtrans = new Map<String,String>();
            mapParamMidtrans.put(EIPConstant.CUSTOM_FIELD_1, 'XXX');
            mapParamMidtrans.put(EIPConstant.FINISH, 'PaymentMidtrans');
            result =  EIPConnector.getToken('VSNAPToken', 'AMFS', 'MIDTRANS', '10000', 'ref0001', mapParamMidtrans);
            System.debug('getToken is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getToken is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testDoOrder(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - doOrder');
            result =  EIPConnector.doOrder(EIPConstant.OPERATION_STATUS, 'AMFS', 'VERITRANS', 'orderId0001');
            System.debug('doOrder is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('doOrder is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        //System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testDoOrderSubmitData(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - doOrderSubmitData');
            String method = 'saving';
            String status = 'accept';
            String trxRefNo = 'SFDC_TEST20191217000001';
            
            Map<String, String> params = new Map<String, String>();
            params.put(EIPConstant.STATUS_CODE, '200');
            params.put(EIPConstant.TRANSACTION_TIME, '2019-12-17 19:10:10');
            params.put(EIPConstant.SIGANTURE_KEY, 'saioduhalskdjiqmaslkcioqewiqejdio12j8eu398');
            params.put(EIPConstant.BANK, 'bca');
            params.put(EIPConstant.VA_NUMBER, '41000');
            params.put(EIPConstant.CUSTOM_FIELD_1, 'cobaaaaa');
            params.put(EIPConstant.CUSTOM_FIELD_2, 'testing');
            params.put(EIPConstant.STATUS_MESSAGE, 'veritrans payment notification');
            params.put(EIPConstant.ORDER_ID, trxRefNo);
            params.put(EIPConstant.TRANSACTION_ID, '20191217000001');
            params.put(EIPConstant.SAVED_TOKEN_ID, 'test-token');
            params.put(EIPConstant.SAVED_TOKEN_ID_EXPIRED_AT, '2020-09-01 23:00:00');
            params.put(EIPConstant.GROSS_AMOUNT, '1.00');
            params.put(EIPConstant.TRANSACTION_STATUS, 'expire');
            params.put(EIPConstant.PAYMENT_TYPE, 'bank_transfer');
            
            result = EIPConnector.doOrder(EIPConstant.OPERATION_SUBMIT_DATA, EIPConstant.ENTITY_AMFS, EIPConstant.APP_TOKEN, trxRefNo, method, status, params);
            System.debug('doOrderSubmitData is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('doOrderSubmitData is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        //System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetRequestId(){
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        
        try {
            Map<String, String> properties = new Map<String, String>();
            properties.put(EIPConstant.PARAM_TYPE, '10');
            properties.put(EIPConstant.PARAM_MSG_POLICY, '512-1234567');
            properties.put(EIPConstant.PARAM_MSG_PRODUCER, '1');  
            
            result = EIPConnector.getRequest(EIPConstant.OPERATION_REQUEST_INQUIRY, EIPConstant.ENTITY_AMFS, EIPConstant.APP_DMTM_REST_V3, properties);
            System.debug('response :'+result);
            isSuccess = true;
        } catch (Exception e) {
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        
        // Error paths (three independent throws)
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        Boolean c1=false, c2=false, c3=false;
        
        /* try {
            EIPConnector.getRequest('get transaction status','AMFS','DMTM', new Map<String,String>{ 'policyNO' => 'TRIGGER_EIPEXC' });
            // System.assert(false, 'getRequest should have thrown');
        } catch (EIPConnector.EIPConnectorException e) { c1 = true; }
        
        try {
            EIPConnector.getRequest('get transaction status','AMFS','DMTM', new Map<String,String>{ 'policyNO' => 'TRIGGER_OFFLINE' });
          //  System.assert(false, 'getRequest should have thrown');
        } catch (EIPConnector.NoDataException e) { c2 = true; }
        
        try {
            EIPConnector.getRequest('get transaction status','AMFS','DMTM', new Map<String,String>{ 'policyNO' => 'TRIGGER_BADJSON' });
            System.assert(false, 'getRequest should have thrown');
        } catch (EIPConnector.EIPException e) { c3 = true; } */
        
        // System.assertEquals(true, c1 && c2 && c3, 'All three error paths must throw');
    }
    
    static testmethod void testSubmitCallNote(){
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        
        try {
            Map<String, String> properties = new Map<String, String>();
            properties.put(EIPConstant.PARAM_MSG_POLICYRK, 'Update V1');
            properties.put(EIPConstant.PARAM_MSG_REGISTERED, 'Cristiano Ronaldo');
            properties.put(EIPConstant.PARAM_MSG_ACCOUNTNO, '081213141516');
            properties.put(EIPConstant.PARAM_MSG_POLICY, '512-1234567');
            
            result = EIPConnector.addCustomerCallNote(EIPConstant.OPERATION_INSERT_CALLNOTE, EIPConstant.ENTITY_AMFS, EIPConstant.APP_DMTM_REST_V3, properties);
            System.debug('response :'+result);
            isSuccess = true;
        } catch (Exception e) {
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        
        // Error paths (three independent throws)
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        Boolean c1=false, c2=false, c3=false;
        
        /* try {
            EIPConnector.addCustomerCallNote('insert call notes','AMFS','DMTM', new Map<String,String>{'policyNO'=>'TRIGGER_EIPEXC'});
            // System.assert(false, 'addCustomerCallNote should have thrown');
        } catch (EIPConnector.EIPConnectorException e) { c1 = true; }
        
        try {
            EIPConnector.addCustomerCallNote('insert call notes','AMFS','DMTM', new Map<String,String>{'policyNO'=>'TRIGGER_OFFLINE'});
            System.assert(false, 'addCustomerCallNote should have thrown');
        } catch (EIPConnector.NoDataException e) { c2 = true; }
        
        try {
            EIPConnector.addCustomerCallNote('insert call notes','AMFS','DMTM', new Map<String,String>{'policyNO'=>'TRIGGER_BADJSON'});
            System.assert(false, 'addCustomerCallNote should have thrown');
        } catch (EIPConnector.EIPException e) { c3 = true; } */
        
        // System.assertEquals(true, c1 && c2 && c3, 'All three error paths must throw');
    }
    
    static testmethod void testSubmitConservation(){
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        
        try {
            Map<String, String> properties = new Map<String, String>();
            properties.put(EIPConstant.PARAM_MSG_POLICYRK, 'Update V1');
            properties.put(EIPConstant.PARAM_STATUS_REASON, 'PE');
            properties.put(EIPConstant.PARAM_MSG_DTTM, system.now().toString());
            properties.put(EIPConstant.PARAM_MSG_POLICY, '512-1234567');
            properties.put(EIPConstant.PARAM_MSG_UWTYPE, 'DOCS');
            properties.put(EIPConstant.PARAM_MSG_OTHER_IND, '20231122-000006');        
            
            result = EIPConnector.addCustomerConservation(EIPConstant.OPERATION_INSERT_CONSERVATION, EIPConstant.ENTITY_AMFS, EIPConstant.APP_DMTM_REST_V3, properties);
            System.debug('response :'+result);
            isSuccess = true;
        } catch (Exception e) {
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        
        // Error paths (three independent throws)
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        Boolean c1=false, c2=false, c3=false;
        
        /* try {
            EIPConnector.addCustomerConservation('conservation','AMFS','DMTM', new Map<String,String>{'policyNO'=>'TRIGGER_EIPEXC'});
            // System.assert(false, 'addCustomerConservation should have thrown');
        } catch (EIPConnector.EIPConnectorException e) { c1 = true; }
        
        try {
            EIPConnector.addCustomerConservation('conservation','AMFS','DMTM', new Map<String,String>{'policyNO'=>'TRIGGER_OFFLINE'});
            System.assert(false, 'addCustomerConservation should have thrown');
        } catch (EIPConnector.NoDataException e) { c2 = true; }
        
        try {
            EIPConnector.addCustomerConservation('conservation','AMFS','DMTM', new Map<String,String>{'policyNO'=>'TRIGGER_BADJSON'});
            System.assert(false, 'addCustomerConservation should have thrown');
        } catch (EIPConnector.EIPException e) { c3 = true; } */
        
        // System.assertEquals(true, c1 && c2 && c3, 'All three error paths must throw');
    }
    
    static testmethod void testQueueRelease(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - queueRelease');
            result =  EIPConnector.queueRelease(EIPConstant.OPERATION_QUEUE_RELEASER, EIPConstant.ENTITY_AMFS, EIPConstant.APP_CHATBOT);
            System.debug('queueRelease is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('queueRelease is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testMethod void testLoanHistory(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getPolicyDetails');
            result =EIPConnector.getPolicyDetails(EIPConstant.OPERATION_LOAN_HISTORY,
                                                  EIPConstant.ENTITY_AFI,
                                                  EIPConstant.APP_RLS,
                                                  '101-1275276',
                                                  '20000526',
                                                  '20200526');
            System.debug('getPolicyDetails is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getPolicyDetails is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testMethod void testGetPaymentHistoryWithRange(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getFundPriceHistory');
            result =  EIPConnector.getPaymentHistory(EIPConstant.OPERATION_PAYMENT,
                                                     EIPConstant.ENTITY_AFI,
                                                     EIPConstant.APP_RLS,
                                                     '508-8597835',
                                                     '2015-03-03',
                                                     '2016-08-24');
            System.debug('getFundPriceHistory is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getFundPriceHistory is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testMethod void testSendCommunicationMessageTada(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - sendCommunicationMessageTADA');
            // reset password page
            Map<String,String> properties = new Map<String,String>();
            properties.put(EIPConstant.PARAM_MSG_LOGIN_ID, 'LUCIAPAR3213');
            properties.put(EIPConstant.PARAM_MSG_DOB, '1990-08-18T00:00:00');
            properties.put(EIPConstant.PARAM_MSG_CIF, 'CIF-402');
            properties.put(EIPConstant.PARAM_MSG_EMAIL, 'lucia.paraswati@axa-mandiri.co.id');
            result = EIPConnector.sendCommunicationMessageTADA(EIPConstant.OPERATION_RESET_PASSWORD_PAGE,
                                                               EIPConstant.ENTITY_AMFS,
                                                               EIPConstant.APP_SLS,
                                                               properties);
            
            // block
            //Map<String,String> properties = new Map<String,String>();
            properties.put(EIPConstant.PARAM_MSG_CIF, 'CIF-402');
            properties.put(EIPConstant.PARAM_MSG_LOGIN_ID, 'LUCIAPAR3213');
            properties.put(EIPConstant.PARAM_MSG_CHANNEL, 'ID');
            result = EIPConnector.sendCommunicationMessageTADA(EIPConstant.OPERATION_BLOCK,
                                                               EIPConstant.ENTITY_AMFS,
                                                               EIPConstant.APP_SLS,
                                                               properties);
            
            // Unblock
            //Map<String,String> properties = new Map<String,String>();
            properties.put(EIPConstant.PARAM_MSG_CIF, 'CIF-402');
            properties.put(EIPConstant.PARAM_MSG_LOGIN_ID, 'LUCIAPAR3213');
            result = EIPConnector.sendCommunicationMessageTADA(EIPConstant.OPERATION_UNBLOCK,
                                                               EIPConstant.ENTITY_AMFS,
                                                               EIPConstant.APP_SLS,
                                                               properties);
            
            
            // reactivation
            //Map<String,String> properties = new Map<String,String>();
            properties.put(EIPConstant.PARAM_MSG_DOB, '1990-08-18T00:00:00');
            properties.put(EIPConstant.PARAM_MSG_POLICY, '512-1231231');
            properties.put(EIPConstant.PARAM_MSG_EMAIL, 'lucia.paraswati@axa-mandiri.co.id');
            result = EIPConnector.sendCommunicationMessageTADA(EIPConstant.OPERATION_REACTIVATION,
                                                               EIPConstant.ENTITY_AMFS,
                                                               EIPConstant.APP_SLS,
                                                               properties);
            
            // Update email & Phone
            //Map<String,String> properties = new Map<String,String>();
            properties.put(EIPConstant.PARAM_MSG_LOGIN_ID, 'LUCIAPAR3213');
            properties.put(EIPConstant.PARAM_MSG_PHONE, '628211111');
            properties.put(EIPConstant.PARAM_MSG_EMAIL, 'lucia.paraswati@axa-mandiri.co.id');
            result = EIPConnector.sendCommunicationMessageTADA(EIPConstant.OPERATION_UPDATE,
                                                               EIPConstant.ENTITY_AMFS,
                                                               EIPConstant.APP_SLS,
                                                               properties);
            
            // inquiry User
            properties.put(EIPConstant.PARAM_MSG_LOGIN_ID, 'LUCIAPAR3213');
            properties.put(EIPConstant.PARAM_MSG_PHONE, '628211111');
            properties.put(EIPConstant.PARAM_MSG_POLICY,'531-000211');
            properties.put(EIPConstant.PARAM_MSG_DOB, String.valueOf(Date.today()));
            properties.put(EIPConstant.PARAM_MSG_GENDER, 'M'); 
            properties.put(EIPConstant.PARAM_MSG_EMAIL, 'lucia.paraswati@axa-mandiri.co.id');
            result = EIPConnector.sendCommunicationMessageTADA(EIPConstant.SERVICE_GET_ADD_USER,
                                                               EIPConstant.ENTITY_AMFS,
                                                               EIPConstant.APP_SLS,
                                                               properties);
            
            // Inquiry Status Tracking
            properties.put(EIPConstant.PARAM_MSG_POLICY,'531-000211');
            properties.put(EIPConstant.PARAM_MSG_EMAIL, 'lucia.paraswati@axa-mandiri.co.id');
            result = EIPConnector.sendCommunicationMessageTADA(EIPConstant.SERVICE_CHECK_USER_ADDHOCK,
                                                               EIPConstant.ENTITY_AMFS,
                                                               EIPConstant.APP_SLS,
                                                               properties);
            // Inquiry Status Tracking List       
            properties.put(EIPConstant.PARAM_MSG_START_DATE, String.valueOf(Date.today() - 30) );
            properties.put(EIPConstant.PARAM_MSG_END_DATE,String.valueOf(Date.today()));
            properties.put(EIPConstant.PARAM_MSG_EMAIL, 'lucia.paraswati@axa-mandiri.co.id');
            result = EIPConnector.sendCommunicationMessageTADA(EIPConstant.SERVICE_LIST_USER_ADDHOCK,
                                                               EIPConstant.ENTITY_AMFS,
                                                               EIPConstant.APP_SLS,
                                                               properties);
            
            properties.put(EIPConstant.PARAM_PAGE_NUMBER, '1');
            properties.put(EIPConstant.PARAM_ROW_PER_PAGE, '10');
            properties.put(EIPConstant.PARAM_MSG_CIF, '1234567891011');
            properties.put(EIPConstant.PARAM_MSG_EMAIL, 'email.test@email.com');
            properties.put(EIPConstant.PARAM_MSG_POLICY, '123-1234567');
            result = EIPConnector.sendCommunicationMessageTADA(EIPConstant.SERVICE_GET_HISTORY_REGISTER,
                                                               EIPConstant.ENTITY_AMFS,
                                                               EIPConstant.APP_SLS,
                                                               properties);
            
            properties.put(EIPConstant.PARAM_MSG_CIF, '1234567891011');
            properties.put(EIPConstant.PARAM_MSG_POLICY, '123-1234567');
            properties.put(EIPConstant.PARAM_MSG_PHONE, '085156080110');
            result = EIPConnector.sendCommunicationMessageTADA(EIPConstant.SERVICE_CUSTOMER_PROFILE,
                                                               EIPConstant.ENTITY_AMFS,
                                                               EIPConstant.APP_SLS,
                                                               properties);
            
            properties.put(EIPConstant.PARAM_MSG_POLICY, '123-1234567');
            properties.put(EIPConstant.PARAM_MSG_CIF, '1234567891011');
            properties.put(EIPConstant.PARAM_MSG_PHONE, '085156080110');
            properties.put(EIPConstant.PARAM_MSG_DOB, '1990-01-01');
            properties.put(EIPConstant.PARAM_MSG_GENDER, 'M');
            properties.put(EIPConstant.PARAM_PAGE_NUMBER, '1');
            properties.put(EIPConstant.PARAM_ROW_PER_PAGE, '15');
            result = EIPConnector.sendCommunicationMessageTADA(EIPConstant.SERVICE_ADD_POLICY,
                                                               EIPConstant.ENTITY_AMFS,
                                                               EIPConstant.APP_SLS,
                                                               properties);
            
            properties.put(EIPConstant.PARAM_MSG_POLICY, '123-1234567');
            properties.put('claimNumber', '1234567891011');
            properties.put('policyType', 'C');
            properties.put('pagevalue', '1');
            result = EIPConnector.sendCommunicationMessageTADA('claim',
                                                               EIPConstant.ENTITY_AMFS,
                                                               EIPConstant.APP_SLS,
                                                               properties);
            
            System.debug('sendCommunicationMessageTADA is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getFundPsendCommunicationMessageTADAriceHistory is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetCustomerList(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        String operation1 = EIPConstant.OPERATION_RETRIEVE_CUSTOMER;
        String appId = 'MDM';
        String customerID = '70901234';
        String polisNo = '709-01234';
        String entity = 'AMFS';
        String sourceCInd = 'MDM_ID';
        String relatedPolicy = '';
        try{
            System.debug('========== callout - getCustomerInfo');
            Map<String,List<String>> mapMDMID = new Map<String,List<String>>();
            List<String> mdmIdList = new List<String>();
            result =  EIPConnector.getCustomerList(operation1, entity, appId, relatedPolicy, mapMDMID);
            System.debug('getCustomerList is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getCustomerList is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
        
        
    }
    
    
    static testmethod void testSendCommTADAFailed(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - Send TADA');
            Map<String, String> properties = new Map<String, String>();
            result =  EIPConnector.sendCommunicationMessageTADA(EIPConstant.OPERATION_REACTIVATION, 'AMFS', 'SLS', properties);
            System.debug('sendCommunicationMessageTADA is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getCustomerList is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetCustomerInfoFullerton(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getCustomer Info Fullerton');
            Map<String, String> properties = new Map<String, String>();
            String firstName = 'rose';
            String lastName = 'rose';
            String username = 'rose';
            String uniqueNumber = 'rose';
            String mobileNumber = '081222121';
            Date dob = Date.today();
            String dobString = '2021-01-01';
            properties.put(EIPConstant.PARAM_FIRST_NAME, firstName);
            properties.put(EIPConstant.PARAM_LAST_NAME, lastName);
            properties.put(EIPConstant.PARAM_USERNAME, username);
            properties.put(EIPConstant.PARAM_UNIQUE_NUMBER, uniqueNumber);
            properties.put(EIPConstant.PARAM_MOBILE_NUMBER, mobileNumber);
            properties.put(EIPConstant.PARAM_MSG_DOB, (dob != null ? Datetime.newInstance(dob, Time.newInstance(0,0,0,0)).format('yyyy-MM-dd') : ''));
            
            properties.put(EIPConstant.PARAM_ORDER_BY, 'username');
            properties.put(EIPConstant.PARAM_ORDER_DIR, 'asc');
            properties.put(EIPConstant.PARAM_PAGE_NUMBER, '1');
            properties.put(EIPConstant.PARAM_ROW_PER_PAGE, '15');
            result =  EIPConnector.getCustomerInfoFullerton(EIPConstant.OPERATION_SEARCH_PERSONAL, 
                                                            EIPConstant.ENTITY_AMFS, 
                                                            EIPConstant.APP_FULLERTON, 
                                                            properties);
            System.debug('getCustomer Info Fullerton is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getCustomer Info Fullerton is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    static testMethod void testInsetLogPCIDSS(){
        DateTime dtStart = DateTime.now();
        
        DateTime dtEnd = DateTime.now();
        EIPConnector.insertLogPcidss(dtStart, dtEnd, '', '',
                                     'dataMID.SFDC_Order_Id__c', EIPConstant.APP_TOKEN, EIPConstant.ENTITY_AMFS, 
                                     EIPConstant.OPERATION_SUBMIT_DATA, EIPConstant.SERVICE_GET_TOKEN);
    }
    
    static testMethod void testSendCommunicationMessageWhatsapp(){
        // Set mock callout class 
        //Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - sendCommunicationMessageWhatsapp');
            // send whatsapp message
            Map<String,String> properties = new Map<String,String>();
            properties.put(EIPConstant.WA_CUSTOMER_NAME, 'Diandra');
            properties.put(EIPConstant.WA_SURVEY_URL_LINK, 'Testing kedua');
            properties.put(EIPConstant.WA_PHONE_TO, '087783348562');
            result = EIPConnector.sendCommunicationMessageWhatsapp(EIPConstant.OPERATION_SEND_WHATSAPP,
                                                                   EIPConstant.ENTITY_AMFS,
                                                                   EIPConstant.APP_JATIS,
                                                                   properties);
            
            System.debug('sendCommunicationMessageWhatsapp is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getFundPsendCommunicationMessageTADAriceHistory is failed');
            System.debug('error :' + e.getMessage());
        }
        //System.assertEquals(true, isSuccess);
        //System.assertEquals('1', result.Body.status);
    }
    
    static testMethod void testGetCustomerInfoDukcapil(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - sendCommunicationMessageWhatsapp');
            // send whatsapp message
            String policyNumber = '123-1234567';
            Map<String, String> params = new Map<String, String>();
            params.put(EIPConstant.PARAM_MSG_CIF, '1234567891011');
            params.put(EIPConstant.PARAM_MSG_PASSWORD, Label.Dukcapil_Username);
            params.put(EIPConstant.PARAM_PASSPORT_NO, Label.Dukcapil_Pwd);
            params.put(EIPConstant.PARAM_TITLE_TXT, 'DASHBOARD');
            result = EIPConnector.getCustomerInfo(EIPConstant.OPERATION_DUKCAPIL_DIRECT_VERIFICATION, 
                                                  EIPConstant.ENTITY_AMFS,
                                                  EIPConstant.APP_DUKCAPIL, 
                                                  policyNumber, 
                                                  false, 
                                                  params);
            
            System.debug('sendCommunicationMessageWhatsapp is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getFundPsendCommunicationMessageTADAriceHistory is failed');
            System.debug('error :' + e.getMessage());
        }
        //System.assertEquals(true, isSuccess);
        //System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetAssNotesRLSWEB(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getAssNotes');
            result =  EIPConnector.getAssNotes('Notification Remarks', 'AMFS', 'RLS_WEB', '123-1234567', 'POS', '0141123', null);
            System.debug('getAssNotes is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getAssNotes is failed');
            System.debug('error :' + e.getMessage());
        }
        //System.assertEquals(true, isSuccess);
        //System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetAssNotesRLSWEBFailed(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getAssNotes');
            result =  EIPConnector.getAssNotes('Notification Remarks', 'AMFS', 'RLS_WEB', '321-7654321', 'POS', '0141123', null);
            System.debug('getAssNotes is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getAssNotes is failed');
            System.debug('error :' + e.getMessage());
        }
        //System.assertEquals(true, isSuccess);
        //System.assertEquals('1', result.Body.status);
    }
    
    static testMethod void testGetPOSTransaction(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getFundPriceHistory');
            result =  EIPConnector.GetPOSTransaction(EIPConstant.OPERATION_PAYMENT,
                                                     EIPConstant.ENTITY_AFI,
                                                     EIPConstant.APP_RLS,
                                                     '508-8597835',
                                                     '2015-03-03',
                                                     '2016-08-24');
            System.debug('getFundPriceHistory is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getFundPriceHistory is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
    }
    
    /*static testmethod void testUpdatePolicyCommunication(){
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        
        try {
            Map<String, String> properties = new Map<String, String>();
            properties.put(EIPConstant.PARAM_MSG_POLICYRK, 'Update V1');
            properties.put(EIPConstant.PARAM_STATUS_REASON, 'PE');
            properties.put(EIPConstant.PARAM_MSG_DTTM, system.now().toString());
            properties.put(EIPConstant.PARAM_MSG_POLICY, '512-1234567');
            properties.put(EIPConstant.PARAM_MSG_UWTYPE, 'DOCS');
            properties.put(EIPConstant.PARAM_MSG_OTHER_IND, '20231122-000006');
            properties.put(EIPConstant.PARAM_LENGTH, '2');
            
            Map<String, List<String>> arrProperties = new Map<String, List<String>>();
            arrProperties.put(EIPConstant.ASSESSMENT_DETAIL, new List<String>{'Test1', 'Test2', 'Test3'});
            arrProperties.put(EIPConstant.PARAM_LINE_NUMBER, new List<String>{'001', '002', '003'});
            
            
            //result = EIPConnector.updatePolicyCommunication(EIPConstant.OPERATION_INSERT_CONSERVATION, EIPConstant.ENTITY_AMFS, EIPConstant.APP_DMTM_REST_V3, properties);
            result = EIPConnector.updatePolicyCommunication(properties, arrProperties);
            System.debug('response :'+result);
            isSuccess = true;
        } catch (Exception e) {
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
    }*/
    
    static testmethod void testGetPolicyDetailsFailed(){
        // Set mock callout class 
        //Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getPolicyDetails');
            result =  EIPConnector.getPolicyDetails('Policy Details', 'AMFS', 'RLS', '');
            System.debug('getPolicyDetails is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getPolicyDetails is failed');
            System.debug('error :' + e.getMessage());
        }
        //System.assertEquals(false, isSuccess);
        //System.assertEquals('1', result.Body.status);
        //
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        /* try{
            EIPConnector.getPolicyDetails('Policy Details', 'AMFS', 'RLS', 'TRIGGER_OFFLINE');
        } catch (EIPConnector.NoDataException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
        
        try{
            EIPConnector.getPolicyDetails('Policy Details', 'AMFS', 'RLS', 'TRIGGER_EIPEXC');
        } catch (EIPConnector.EIPConnectorException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }*/
    }
    
    static testmethod void testGetFraudFailed(){
        // Set mock callout class 
        //Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getPolicyDetails');
            result =  EIPConnector.getPolicyFraud('Policy Details', 'AMFS', 'RLS', '', '167531');
            System.debug('getFraud is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getPolicyDetails is failed');
            System.debug('error :' + e.getMessage());
        }
        
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        /* try{
            EIPConnector.getPolicyFraud('Policy Details', 'AMFS', 'RLS', 'TRIGGER_OFFLINE', '167531');
        } catch (EIPConnector.NoDataException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
        
        try{
            EIPConnector.getPolicyFraud('Policy Details', 'AMFS', 'RLS', 'TRIGGER_EIPEXC', '167531');
        } catch (EIPConnector.EIPConnectorException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        } */
        //System.assertEquals(false, isSuccess);
        //System.assertEquals('1', result.Body.status);
    }
    
    static testmethod void testGetPaymentHistoryFailed(){
        // Set mock callout class 
        //Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getPaymentHistory');
            result =  EIPConnector.getPaymentHistory('Payment', 'AFI', 'BIS', 'CMS051130334853');
            System.debug('getPaymentHistory is success');
            System.debug('response :' + result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getPaymentHistory is failed');
            System.debug('error :' + e.getMessage());
        }
        //System.assertEquals(false, isSuccess);
        //System.assertEquals('1', result.Body.status);
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        try{
            EIPConnector.getPaymentHistory('Payment', 'AFI', 'BIS', 'TRIGGER_OFFLINE');
        } catch (EIPConnector.NoDataException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
        
        try{
            EIPConnector.getPaymentHistory('Payment', 'AFI', 'BIS', 'TRIGGER_EIPEXC');
        } catch (EIPConnector.EIPConnectorException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
    }
    
    static testMethod void testGetPaymentHistoryWithRangeFailed(){
        // Set mock callout class 
        //Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getFundPriceHistory');
            result =  EIPConnector.getPaymentHistory(EIPConstant.OPERATION_PAYMENT,
                                                     EIPConstant.ENTITY_AFI,
                                                     EIPConstant.APP_RLS,
                                                     '508-8597835',
                                                     '',
                                                     '');
            System.debug('getFundPriceHistory is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getFundPriceHistory is failed');
            System.debug('error :' + e.getMessage());
        }
        //System.assertEquals(true, isSuccess);
        //System.assertEquals('1', result.Body.status);
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        try{
            EIPConnector.getPaymentHistory(EIPConstant.OPERATION_PAYMENT,
                                                     EIPConstant.ENTITY_AFI,
                                                     EIPConstant.APP_RLS,
                                                     'TRIGGER_OFFLINE',
                                                     '',
                                                     '');
        } catch (EIPConnector.NoDataException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
        
        try{
            EIPConnector.getPaymentHistory(EIPConstant.OPERATION_PAYMENT,
                                                     EIPConstant.ENTITY_AFI,
                                                     EIPConstant.APP_RLS,
                                                     'TRIGGER_EIPEXC',
                                                     '',
                                                     '');
        } catch (EIPConnector.EIPConnectorException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
    }
    
    static testMethod void testGetPOSTransactionFailed(){
        // Set mock callout class 
        //Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getFundPriceHistory');
            result =  EIPConnector.GetPOSTransaction(EIPConstant.OPERATION_PAYMENT,
                                                     EIPConstant.ENTITY_AFI,
                                                     EIPConstant.APP_RLS,
                                                     '',
                                                     '',
                                                     '');
            System.debug('getFundPriceHistory is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getFundPriceHistory is failed');
            System.debug('error :' + e.getMessage());
        }
        //System.assertEquals(true, isSuccess);
        //System.assertEquals('1', result.Body.status);
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        /* try{
            EIPConnector.GetPOSTransaction(EIPConstant.OPERATION_PAYMENT,
                                                     EIPConstant.ENTITY_AFI,
                                                     EIPConstant.APP_RLS,
                                                     'TRIGGER_OFFLINE',
                                                     '',
                                                     '');
        } catch (EIPConnector.NoDataException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
        
        try{
            EIPConnector.GetPOSTransaction(EIPConstant.OPERATION_PAYMENT,
                                                     EIPConstant.ENTITY_AFI,
                                                     EIPConstant.APP_RLS,
                                                     'TRIGGER_EIPEXC',
                                                     '',
                                                     '');
        } catch (EIPConnector.EIPConnectorException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        } */
    }
    
    static testmethod void testQueueReleaseFailed(){
        // Set mock callout class 
        //Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - queueRelease');
            result =  EIPConnector.queueRelease(EIPConstant.OPERATION_QUEUE_RELEASER, EIPConstant.ENTITY_AMFS, EIPConstant.APP_CHATBOT);
            System.debug('queueRelease is success');
            System.debug('response :'+result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('queueRelease is failed');
            System.debug('error :' + e.getMessage());
        }
        //System.assertEquals(true, isSuccess);
        //System.assertEquals('1', result.Body.status);
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        try{
            EIPConnector.queueRelease(EIPConstant.OPERATION_QUEUE_RELEASER, EIPConstant.ENTITY_AMFS, 'TRIGGER_OFFLINE');
        } catch (EIPConnector.NoDataException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
        
        try{
            EIPConnector.queueRelease(EIPConstant.OPERATION_QUEUE_RELEASER, EIPConstant.ENTITY_AMFS, 'TRIGGER_EIPEXC');
        } catch (EIPConnector.EIPConnectorException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
    }
    
    static testmethod void testGetPremiumBreakdownFailed(){
        // Set mock callout class 
        //Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getPremiumBreakdown');
            result =  EIPConnector.getPremiumBreakdown('Premium Breakdown', 'AFI', 'RLS', '');
            System.debug('getPremiumBreakdown is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getPremiumBreakdown is failed');
            System.debug('error :' + e.getMessage());
        }
        //System.assertEquals(true, isSuccess);
        //System.assertEquals('1', result.Body.status);
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        try{
            EIPConnector.getPremiumBreakdown('Premium Breakdown', 'AFI', 'RLS', 'TRIGGER_OFFLINE');
        } catch (EIPConnector.NoDataException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
        
        try{
            EIPConnector.getPremiumBreakdown('Premium Breakdown', 'AFI', 'RLS', 'TRIGGER_EIPEXC');
        } catch (EIPConnector.EIPConnectorException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
    }
    
    static testmethod void testGetBeneficiaryDetailFailed(){
        // Set mock callout class 
        //Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getBeneficiaryDetail');
            result =  EIPConnector.getBeneficiaryDetail('Beneficiary', 'AFI', 'RLS', '');
            System.debug('getBeneficiaryDetail is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getBeneficiaryDetail is failed');
            System.debug('error :' + e.getMessage());
        }
        //System.assertEquals(true, isSuccess);
        //System.assertEquals('1', result.Body.status);
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        try{
            EIPConnector.getBeneficiaryDetail('Beneficiary', 'AFI', 'RLS', 'TRIGGER_OFFLINE');
        } catch (EIPConnector.NoDataException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
        
        try{
            EIPConnector.getBeneficiaryDetail('Beneficiary', 'AFI', 'RLS', 'TRIGGER_EIPEXC');
        } catch (EIPConnector.EIPConnectorException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
    }
    
    static testmethod void testGetFundDetailFailed(){
        // Set mock callout class 
        //Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getFundDetail');
            result =  EIPConnector.getFundDetail('', 'AMFS', 'RLS', '');
            System.debug('getFundDetail is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getFundDetail is failed');
            System.debug('error :' + e.getMessage());
        }
        //System.assertEquals(true, isSuccess);
        //System.assertEquals('1', result.Body.status);
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        try{
            EIPConnector.getFundDetail('', 'AMFS', 'RLS', 'TRIGGER_OFFLINE');
        } catch (EIPConnector.NoDataException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
        
        try{
            EIPConnector.getFundDetail('', 'AMFS', 'RLS', 'TRIGGER_EIPEXC');
        } catch (EIPConnector.EIPConnectorException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
    }
    
    
    static testmethod void testGetClaimDetailsFailed(){
        // Set mock callout class 
        //Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        //SELECT session_id__c, data_request__c, data__c FROM Session_Data__c WHERE signature_data__c =:signature LIMIT 1
        Session_Data__c signature = new Session_Data__c();
        signature.session_id__c = 'test';
        signature.data_request__c = 'test';
        signature.data__c = 'test';
        insert signature;
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getClaimDetails');
            result =  EIPConnector.getClaimDetails('Claim', 'AMFS', 'RLS', '','');
            System.debug('getClaimDetails is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getClaimDetails is failed');
            System.debug('error :' + e.getMessage());
        }
        //System.assertEquals(true, isSuccess);
        //System.assertEquals('1', result.Body.status);
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        try{
            EIPConnector.getClaimDetails('Claim', 'AMFS', 'RLS', 'TRIGGER_OFFLINE','');
        } catch (EIPConnector.NoDataException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
        
        try{
            EIPConnector.getClaimDetails('Claim', 'AMFS', 'RLS', 'TRIGGER_EIPEXC','');
        } catch (EIPConnector.EIPConnectorException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
    }
    
    static testmethod void testGetAgentInfoFailed(){
        // Set mock callout class 
        //Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        try{
            System.debug('========== callout - getAgentInfo');
            result =  EIPConnector.getAgentInfo('Agent Info', 'AMFS', 'RLS', '', null);
            System.debug('getAgentInfo is success');
            System.debug('response :'+ result);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getAgentInfo is failed');
            System.debug('error :' + e.getMessage());
        }
        //System.assertEquals(true, isSuccess);
        //System.assertEquals('1', result.Body.status);
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        try{
            EIPConnector.getAgentInfo('Agent Info', 'AMFS', 'RLS', 'TRIGGER_OFFLINE', null);
        } catch (EIPConnector.NoDataException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
        
        try{
            EIPConnector.getAgentInfo('Agent Info', 'AMFS', 'RLS', 'TRIGGER_EIPEXC', null);
        } catch (EIPConnector.EIPConnectorException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
    }
    
    static testmethod void testGetGIClaimDetail2(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        EIPJson result2 = new EIPJson();
        EIPJson result3 = new EIPJson();
        try{
            System.debug('========== callout - getGIClaimDetail');
            Map<String,String> validDttm = new Map<String,String>();
            validDttm.put(EIPConstant.VALID_FROM_DTTM, '20010728');
            validDttm.put(EIPConstant.VALID_TO_DTTM, '20200728');
            // result2 = EIPConnector.getGIClaimDetail('Claim', 'MAGI', 'PSEA', '00204302');
            result =  EIPConnector.getGIClaimDetail('Claim', 'MAGI', 'PSEA', '00204302');
            System.debug('getGIClaimDetail is success');
            System.debug('response :'+result);
            System.debug('response :'+result2);
            isSuccess = true;
        }catch(Exception e){
            System.debug('getGIClaimDetail is failed');
            System.debug('error :' + e.getMessage());
        }
        // System.assertEquals(true, isSuccess);
        // System.assertEquals('1', result.Body.status);
        
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock_Error());
        try{
            EIPConnector.getGIClaimDetail('Claim', 'MAGI', 'PSEA', 'TRIGGER_OFFLINE');
        } catch (EIPConnector.NoDataException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
        
        try{
            EIPConnector.getGIClaimDetail('Claim', 'MAGI', 'PSEA', 'TRIGGER_EIPEXC');
        } catch (EIPConnector.EIPConnectorException e) {
            // System.assertEquals(EIPConstant.ERROR_MSG_NODATA, e.getMessage());
        }
    }
    
    
    static testmethod void testAdsCustomer(){
        //Test.setMock(HttpCalloutMock.class, new CallLineAssesmentDMTM_TestMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        
        try {
            Map<String, String> properties = new Map<String, String>();
            properties.put(EIPConstant.PARAM_MSG_POLICYRK, 'Update V1');
            properties.put(EIPConstant.PARAM_MSG_REGISTERED, 'Cristiano Ronaldo');
            properties.put(EIPConstant.PARAM_MSG_ACCOUNTNO, '081213141516');
            properties.put(EIPConstant.PARAM_MSG_POLICY, '512-1234567');
            
            
            // Menggunakan Blob kosong sebagai input
            Blob fileImage = Blob.valueOf('dummyimagecontent');
            
            
            result = EIPConnector.addCustomer(EIPConstant.OPERATION_INSERT_CALLNOTE, EIPConstant.ENTITY_AMFS, EIPConstant.APP_DMTM_REST_V3, fileImage, properties);
            System.debug('response :'+result);
            isSuccess = true;
        } catch (Exception e) {
            System.debug('error :' + e.getMessage());
        } 
         
    }
    
    static testmethod void testSubmietData(){
        //Test.setMock(HttpCalloutMock.class, new CallLineAssesmentDMTM_TestMock());
        
        boolean isSuccess = false;
        EIPJson result = new EIPJson();
        
        try {
            Map<String, String> properties = new Map<String, String>();
            properties.put(EIPConstant.PARAM_MSG_POLICYRK, 'Update V1');
            properties.put(EIPConstant.PARAM_MSG_REGISTERED, 'Cristiano Ronaldo');
            properties.put(EIPConstant.PARAM_MSG_ACCOUNTNO, '081213141516');
            properties.put(EIPConstant.PARAM_MSG_POLICY, '512-1234567');
              
            result = EIPConnector.submitMetadata(EIPConstant.OPERATION_INSERT_CALLNOTE, EIPConstant.ENTITY_AMFS, EIPConstant.APP_DMTM_REST_V3,  properties);
            System.debug('response :'+result);
            isSuccess = true;
        } catch (Exception e) {
            System.debug('error :' + e.getMessage());
        } 
         
    }
   
}