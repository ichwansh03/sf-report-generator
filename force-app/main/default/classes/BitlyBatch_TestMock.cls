@isTest
global class BitlyBatch_TestMock implements HttpCalloutMock{
	 global HttpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setStatus('OK');
        res.setHeader('Content-Type', 'application/json');
    	res.setStatusCode(200);
        
        String sJsonRequest = req.getBody();
        EIPJson eipJson = (EIPJson) System.JSON.deserializeStrict(sJsonRequest, EIPJson.class);
        String operation = EIPJson.Body.operation;
        
        if(operation == 'createNewUrl'){
          res.setBody('{"Body":{"Customer":{"haveCommunicatedMessage":[{"messageID": "AMFSEDOCSDEV001","replyTo": "http://axa.t2mio.com/AMFSEDOCSDEV001","additionalRk": "No","deliveryStatusCD": "301","channelID": "2775358","target": "http://test","deliveryDT": "2020-08-14 10:29:53","chargeAmt": "0"}]},"operation": "createNewUrl","transactionId": "transaction-001","status": "1","entity": "AFI","service": "sendCommunicationMessage","appID": "T2MIO"}}');
        }
        return res;
    }
}