@isTest
public class AXAAPI023A_CallListByParam_Test {

    // Mock class untuk simulasi response dari callout
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"status":"success","data":[{"id":"001","name":"Test Call"}]}');
            res.setStatusCode(200);
            return res;
        }
    }

    @isTest
    static void testGetCallListByParam() {
        // Simulasi data Access_Token__c
        Access_Token__c token = new Access_Token__c(Token__c = 'mock-token');
        insert token;

        // Set custom label token jika kosong
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        Test.startTest();
        AXAAPI023A_response result = AXAAPI023A_CallListByParam.getCallListByParam('?param=test');
        Test.stopTest();

        System.assertNotEquals(null, result, 'Response tidak boleh null');
        // Tambahkan assert sesuai struktur AXAAPI023A_response jika tersedia
    }
}