@isTest
public class AsyncCCCWebserviceConnectors10Ali_Test {
    private static testMethod void setupTestData() {
        Test.startTest();
        
        AsyncCCCWebserviceConnectors10Ali cccws = new AsyncCCCWebserviceConnectors10Ali();
        
        AsyncCCCWebserviceConnectors10Ali.GetPolicyDetailsLifeRLSResponse_elementFuture lifeRls = new AsyncCCCWebserviceConnectors10Ali.GetPolicyDetailsLifeRLSResponse_elementFuture();
        //lifeRls.getValue();
        AsyncCCCWebserviceConnectors10Ali.GetPolicyDetailsNonRLSALIResponse_elementFuture nonRls = new AsyncCCCWebserviceConnectors10Ali.GetPolicyDetailsNonRLSALIResponse_elementFuture();
        //nonRls.getValue();
        AsyncCCCWebserviceConnectors10Ali.GetPolicyDetailsLifeNONRLSResponse_elementFuture lifeNonRls = new AsyncCCCWebserviceConnectors10Ali.GetPolicyDetailsLifeNONRLSResponse_elementFuture();
        //lifeNonRls.getValue();
        AsyncCCCWebserviceConnectors10Ali.GetPolicyDetailsGIResponse_elementFuture gi = new AsyncCCCWebserviceConnectors10Ali.GetPolicyDetailsGIResponse_elementFuture();
        //gi.getValue();
        
        // Endpoint of long-running service
        String LONG_RUNNING_SERVICE_URL = 'http://axasfdc.com/IWSAXA_MAIN_W_ALI/iService.asmx';
        // Create continuation with a timeout
        Continuation con = new Continuation(40);
        // Set callback method
        con.continuationMethod = 'processResponse';
        // Create callout request
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint(LONG_RUNNING_SERVICE_URL);
        // Add callout request to continuation
        con.addHttpRequest(req);
        
        AsyncCCCWebserviceConnectors10Ali.AsynciServiceSoap asyncSoap = new AsyncCCCWebserviceConnectors10Ali.AsynciServiceSoap();
        asyncSoap.beginGetPolicyDetailsLifeRLS(con,'1030401-0957584','DMTM','ALI','4DA7DD83665644DBC58542DF1481CB02');
        asyncSoap.beginGetPolicyDetailsNonRLSALI(con,'1030401-0957584','DMTM','ALI','4DA7DD83665644DBC58542DF1481CB02');
        asyncSoap.beginGetPolicyDetailsLifeNONRLS(con,'1030401-0957584','DMTM','ALI','4DA7DD83665644DBC58542DF1481CB02');
        asyncSoap.beginGetPolicyDetailsGI(con,'1030401-0957584','DMTM','ALI','4DA7DD83665644DBC58542DF1481CB02');
        
        Test.stopTest();
    }
    
}