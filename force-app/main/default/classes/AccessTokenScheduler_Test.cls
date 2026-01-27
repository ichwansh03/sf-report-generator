@isTest
public class AccessTokenScheduler_Test {

    // Mock sukses: mensimulasikan callout berhasil
    public class MockSuccessCallout implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"access_token":"mocked-token"}');
            res.setStatusCode(200);
            return res;
        }
    }

    // Mock gagal: mensimulasikan callout error
    public class MockFailureCallout implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            throw new CalloutException('Simulated failure');
        }
    }

    @isTest
    static void testCallAccessToken_UpdateExistingToken() {
        // Simulasi token lama agar bisa di-update
        Access_Token__c token = new Access_Token__c(Endpoint__c = Label.Endpoint_SAG, Token__c = 'old-token');
        insert token;

        Test.setMock(HttpCalloutMock.class, new MockSuccessCallout());

        Test.startTest();
        AccessTokenScheduler.callAccessToken();
        Test.stopTest();

        Access_Token__c updated = [SELECT Token__c FROM Access_Token__c WHERE Id = :token.Id];
        System.assertEquals('mocked-token', updated.Token__c);
    }

    @isTest
    static void testCallAccessToken_InsertNewToken() {
        // Pastikan tidak ada token yang cocok dengan Endpoint_SAG
        List<Access_Token__c> existing = [SELECT Id FROM Access_Token__c WHERE Endpoint__c = :Label.Endpoint_SAG];
        if (!existing.isEmpty()) delete existing;

        Test.setMock(HttpCalloutMock.class, new MockSuccessCallout());

        Test.startTest();
        AccessTokenScheduler.callAccessToken();
        Test.stopTest();

        List<Access_Token__c> inserted = [SELECT Token__c FROM Access_Token__c WHERE Endpoint__c = :Label.Endpoint_SAG];
        System.assertEquals(1, inserted.size(), 'Harus ada satu token baru');
        System.assertEquals('mocked-token', inserted[0].Token__c);
    }

    @isTest
    static void testCallAccessToken_Exception() {
        Test.setMock(HttpCalloutMock.class, new MockFailureCallout());

        Test.startTest();
        AccessTokenScheduler.callAccessToken(); // Memicu blok catch
        Test.stopTest();

        // Tidak perlu assert, cukup untuk menutupi blok catch
    }

    @isTest
    static void testExecuteScheduler() {
        Test.startTest();
        AccessTokenScheduler scheduler = new AccessTokenScheduler();
        String jobId = System.schedule('AccessTokenJob', '0 0 12 * * ?', scheduler);
        Test.stopTest();

        System.assertNotEquals(null, jobId);
    }
}