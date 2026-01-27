@isTest
global class CustomizeCaseServiceController_TestMock implements HttpCalloutMock {

    global HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
    	
        System.debug('CUSTOMIZE CASE DMTM MOCK REQUEST: '+req.getBody());
        
        res.setBody('{"Body":{"transactionId":"888-1726713446","appID":"DMTM_REST_V3","entity":"AMFS","service":"addCustomer","operation":"insert call notes","Customer":{"processedDttm":"2024-09-19T02:37:27","key":"f4a178c2-52b3-42fe-9630-75568712a32e#10.144.5.15#SFDCEIP","hasPolicyAccount":[{"policyVersion":"false","policyRK":"Diisi dengan Note","registeredBy":"Created By","accountNo":"192381983","renewalDt":"1999-07-01T00:00:00","policyDueDt":"1999-07-01T00:00:00","policyNO":"300-107-5561401","hasNameValue":[{"value":"2010080201"},{"value":"2010080201"}],"terminationDt":"1999-07-01T00:00:00","policyStatusCD":"Y"}],"haveCommunicatedMessage":[{"message":"Success","messageID":"200"}]},"status":"1"}}');
        
        return res;
    }
}