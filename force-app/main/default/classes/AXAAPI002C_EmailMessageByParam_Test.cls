@isTest
public class AXAAPI002C_EmailMessageByParam_Test {

    // Mock class untuk mensimulasikan response dari callout
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"status":"success","messages":[{"id":"001","subject":"Test Email"}]}');
            res.setStatusCode(200);
            return res;
        }
    }

    @isTest
    static void testGetEmailByParam() {
        // Simulasi data Access_Token__c agar query tidak error
        Access_Token__c token = new Access_Token__c(Token__c = 'mock-token');
        insert token;

        // Set mock untuk callout
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        Test.startTest();
        AXAAPI002C_response result = AXAAPI002C_EmailMessageByParam.getEmailByParam('?param=test');
        Test.stopTest();

        System.assertNotEquals(null, result, 'Response tidak boleh null');
        // Tambahkan assert tambahan jika AXAAPI002C_response punya field yang bisa diverifikasi
    }
}