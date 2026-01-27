@isTest
public class RESTWebserviceService_Test {
    
    static testMethod void testMthod1() {
    	
    	Test.startTest();
    	
    	string endPoint = Label.REST_WS_Endpoint /*+ 'biz='*/ + Label.Biz_getCustomerInfo ; //'https://axacccw2-dummy-api-doddyprima.c9users.io/GetCustomerInfo/pno-100-103-0000040.json' ; //comment biz by Beni Rama 14/04/2022
    	string requestJSON='{"Header":{"SecurityContext":{"username":"RLSUser","password":"12345eefohghh","token":"1234RLS"}},"Body":{"IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"3010704051100001","certificateNo":"000009"}]},"AXAAsiaPagination_Type":{"startDateTime":"","endDateTime":"","rowPerPage":"","startOfRecords":"","numberOfRecords":"","pageNumber":""},"operation":"Customer Profile","appID":"RLS","entity":"AFI","transactionId":"1234","service":"getCustomerInfo"}}';
    	string method = 'POST';
    	RESTWebserviceService rws = new RESTWebserviceService(endPoint, requestJSON, method, Integer.ValueOf(Label.WS_Callout_Timeout));
    	rws.setEndPoint(endPoint);
    	rws.setBody(requestJSON);
    	rws.setMethod(method);
		rws.send();
		
		string res= rws.getResponseBody();

    	
    	Test.stopTest();
    	
    }
    
    static testMethod void testMthod2() {
    	
    	Test.startTest();
    	
    	string endPoint = Label.REST_WS_Endpoint + Label.Biz_getCustomerInfo ; //'https://axacccw2-dummy-api-doddyprima.c9users.io/GetCustomerInfo/pno-100-103-0000040.json' ; //comment biz by Beni Rama 14/04/2022
    	string requestJSON='{"Header":{"SecurityContext":{"username":"RLSUser","password":"12345eefohghh","token":"1234RLS"}},"Body":{"IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"3010704051100001","certificateNo":"000009"}]},"AXAAsiaPagination_Type":{"startDateTime":"","endDateTime":"","rowPerPage":"","startOfRecords":"","numberOfRecords":"","pageNumber":""},"operation":"Customer Profile","appID":"RLS","entity":"AMFS","transactionId":"1234","service":"getCustomerInfo"}}';
    	string method = 'POST';
        
         Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());

        EIPCONNECTOR.getAccessTokenAMFS();
        
    	RESTWebserviceService rws = new RESTWebserviceService(endPoint, requestJSON, method, Integer.ValueOf(Label.WS_Callout_Timeout));
    	rws.setEndPoint(endPoint);
    	rws.setBody(requestJSON);
    	rws.setMethod(method);
		rws.send();
		
		string res= rws.getResponseBody();
        string resReplace = rws.getResponseBodyReplace();
    	
    	Test.stopTest();
    	
    }
    
    static testMethod void testMthod3() {
    	
    	Test.startTest();
        
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        // Instantiate the StandardController with the test record
        ApexPages.StandardController sc = new ApexPages.StandardController(testAccount);
        
        // Call the constructor
        RESTWebserviceService service = new RESTWebserviceService(sc);
        
        // Optionally, add assertions if the constructor does something
        System.assertNotEquals(null, service);

    	Test.stopTest();
    	
    }
    
    static testMethod void testMthod4() {
    	
    	Test.startTest();
    	
    	string endPoint = Label.REST_WS_Endpoint + Label.Biz_getCustomerInfo ; //'https://axacccw2-dummy-api-doddyprima.c9users.io/GetCustomerInfo/pno-100-103-0000040.json' ; //comment biz by Beni Rama 14/04/2022
    	string requestJSON='editWorkingTimeConfiguration';
    	string method = 'POST';
        
         Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());

        EIPCONNECTOR.getAccessTokenAMFS();
        
    	RESTWebserviceService rws = new RESTWebserviceService(endPoint, requestJSON, method, Integer.ValueOf(Label.WS_Callout_Timeout));
    	rws.setEndPoint(endPoint);
    	rws.setBody(requestJSON);
    	rws.setMethod(method);
		rws.send();
		
		string res= rws.getResponseBody();
        string resReplace = rws.getResponseBodyReplace();
    	
    	Test.stopTest();
    	
    }
    
    static testMethod void testMthod5() {
    	
    	Test.startTest();
        
        Access_Token__c token = new Access_Token__c(Endpoint__c = Label.Endpoint_SAG, Token__c = 'old-token');
        insert token;
    	
    	string endPoint = Label.REST_WS_Endpoint + Label.Biz_getCustomerInfo ; //'https://axacccw2-dummy-api-doddyprima.c9users.io/GetCustomerInfo/pno-100-103-0000040.json' ; //comment biz by Beni Rama 14/04/2022
    	string requestJSON='Live Chat';
    	string method = 'POST';
        
         Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());

        EIPCONNECTOR.getAccessTokenAMFS();
        
    	RESTWebserviceService rws = new RESTWebserviceService(endPoint, requestJSON, method, Integer.ValueOf(Label.WS_Callout_Timeout));
    	rws.setEndPoint(endPoint);
    	rws.setBody(requestJSON);
    	rws.setMethod(method);
		rws.send();
		
		string res= rws.getResponseBody();
        string resReplace = rws.getResponseBodyReplace();
    	
    	Test.stopTest();
    	
    }
    
    static testMethod void testMthod6() {
        Test.startTest();
        RESTWebserviceService svc = new RESTWebserviceService(Label.REST_WS_Endpoint, '{"Body":{"entity":"AFI"}}', 'POST', Integer.valueOf(Label.WS_Callout_Timeout));
        svc.username = 'testUser';
        svc.password = 'testPass';
        System.assertEquals('testUser', svc.username);
        System.assertEquals('testPass', svc.password);
        Test.stopTest();
    }

    
}