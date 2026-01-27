@isTest
global class AccountInfoCallLineController_TestMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req)
    {
        HttpResponse res = new HttpResponse();
        res.setStatus('OK');
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        
        String sJsonRequest = req.getBody();
        EIPJson eipJson = (EIPJson) System.JSON.deserializeStrict(sJsonRequest, EIPJson.class);
        String operation = EIPJson.Body.operation;
        
        if(operation == 'getAccountDetail'){
            res.setBody('{"Body":{"operation":"getAccountDetail","transactionId":"0056F000008o9L1QAI-20210907-43a208442d2381a3f9f520e84ef3836e","status":"1","entity":"AMFS","service":"getCustomerInfo","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"hasPartyDetailsIn":[{"canBeIndividual":{"hasPartyAccountDetailsIn":{"accountTypeCD":"Saving","accountNO":"9000029934727","payorFirstNM":"HERTI WITA FELIAN"}}}],"policyNO":"100-500-0249926"}]},"appID":"DMTM"}}');
        }else if(operation == 'Account Detail'){
            res.setBody('{"Body":{"operation":"getAccountDetail","transactionId":"0056F000008o9L1QAI-20210907-43a208442d2381a3f9f520e84ef3836e","status":"1","entity":"AMFS","service":"getCustomerInfo","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"hasPartyDetailsIn":[{"canBeIndividual":{"hasPartyAccountDetailsIn":{"accountTypeCD":"Saving","accountNO":"9000029934727","payorFirstNM":"HERTI WITA FELIAN"}}}],"policyNO":"100-500-0249926"}]},"appID":"DMTM"}}');
        }
        return res;
    }
}