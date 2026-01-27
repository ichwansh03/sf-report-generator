@isTest
global class InquiryFullerton_testMock implements HttpCalloutMock {

    global HttpResponse respond(HttpRequest req)
    {
        HttpResponse res = new HttpResponse();
        res.setStatus('OK');
        res.setHeader('Content-Type', 'application/json');
    	res.setStatusCode(200);
        
        String sJsonRequest = req.getBody();
        EIPJson eipJson = (EIPJson) System.JSON.deserializeStrict(sJsonRequest, EIPJson.class);
        String operation = EIPJson.Body.operation;
        
        if(operation == 'searchPersonal'){
          res.setBody('{"Body":{"operation":"searchPersonal","transactionId":"005N0000008CRboIAG-20210129-a9d6d9f42ebda2d612e1ee7cdeb2b502","status":"1","entity":"AMFS","service":"addCustomer","IcAx_AXAAsiaCustomer_Type":{"hasNameValue":[{"name":"totalData","value":"2"},{"name":"page","value":"1"},{"name":"limit","value":"15"}],"canBeIndividual":{"firstNM":"rose"},"haveCommunicatedMessage":[{"deliveryStatusDesc":"success","message":"Data Successfully Found","deliveryDT":"1611894976612"}],"hasPolicyAccount":[{"hasCustomerInformationIn":[{"canBeIndividual":{"genderCD":"F","hasAddressesIn":[{"emailAddress":"nadia.rahmawati@axa.co.id"}],"firstNM":"Rose","socialSecurityNO":"FvFJAW","birthDT":"1999-09-09"}},{"canBeIndividual":{"genderCD":"FEMALE","hasAddressesIn":[{"emailAddress":"Lailimasma@gmail.com","mobilePhoneNO":"08568602030"}],"lastNM":"Park","localNM":"Rose","firstNM":"Rose","socialSecurityNO":"FvFJAW","birthDT":"1999-09-09"}}]}]},"appID":"FULLERTON"}}');
        }
        return res;
    }
}