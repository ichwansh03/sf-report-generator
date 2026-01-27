@isTest
global class ErecieptNotifController_MockTest implements HttpCalloutMock {
    global HttpResponse respond(HTTPRequest req){ 
        HttpResponse res = new HttpResponse(); 
        if(req.getEndpoint().contains('preprodapwsg.axa-tech.com')) { 
            String body = '{"Body":{"Customer":{"haveCommunicatedMessage":[{"messageID":"Test-240122-01","replyTo":"https://axa.t2mio.com/Test-240122-01","additionalRk":"No","deliveryStatusCD":"301","channelID":"10755339","target":"www.google.com","deliveryDT":"2022-01-24 01:24:16","chargeAmt":"0"}]},"operation":"createNewUrl","transactionId":"Test-240122-01","status":"1","entity":"AMFS","service":"sendCommunicationMessage","appID":"T2MIO"}}';
            res.setStatus('OK');
            res.setStatusCode(200);
            res.setBody(body);
        } else if(req.getEndpoint().contains('gateway.axa.co.id')) { 
            String body = '{"Body":{"Customer":{"haveCommunicatedMessage":[{"messageID":"Test-240122-01","replyTo":"https://axa.t2mio.com/Test-240122-01","additionalRk":"No","deliveryStatusCD":"301","channelID":"10755339","target":"www.google.com","deliveryDT":"2022-01-24 01:24:16","chargeAmt":"0"}]},"operation":"createNewUrl","transactionId":"Test-240122-01","status":"1","entity":"AMFS","service":"sendCommunicationMessage","appID":"T2MIO"}}';
            res.setStatus('OK');
            res.setStatusCode(200);
            res.setBody(body);
        } else if(req.getEndpoint().contains('sms-api.jatismobile.com')) { 
            String body = '"Status=1&MessageId=PU1471rTRRWOEPDESSUMES"';
            res.setStatus('OK');
            res.setStatusCode(200);
            res.setBody(body);
        } 
        return res;
    }
}