@isTest
public class AXAAPI001C_CaseByParam_Test {

    // Mock class untuk mensimulasikan response dari callout
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"status":"success","cases":[{"id":"001","subject":"Test Case"}]}');
            res.setStatusCode(200);
            return res;
        }
    }

    @isTest
    static void testGetCaseByParam() {
        // Simulasi data Access_Token__c agar query tidak error
        Access_Token__c token = new Access_Token__c(Token__c = 'mock-token');
        insert token;

        // Set mock untuk callout
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        Test.startTest();
        AXAAPI001C_response result = AXAAPI001C_CaseByParam.getCaseByParam('?param=test');
        Test.stopTest();

        System.assertNotEquals(null, result, 'Response tidak boleh null');
        // Tambahkan assert tambahan jika AXAAPI001C_response punya field yang bisa diverifikasi
    }
}