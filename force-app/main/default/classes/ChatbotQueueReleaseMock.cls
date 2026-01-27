@isTest
global class ChatbotQueueReleaseMock implements HttpCalloutMock{
	global HttpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
      
        String sJsonResponse = '{"Body":{"operation":"Queue Releaser","transactionId":"005p0000003CeNRAA0-20200123-767b41de97bfded486b669624fd36dc7","status":"1","entity":"AMFS","service":"sendCommunicationMessage","IcAx_AXAAsiaCustomer_Type":{"canBeIndividual":{"hasPartyAccountDetailsIn":{"accessToken":"a9641fa0"},"hasProspectIndividual":[{"hasProductDetails":[{"totalRecordCount":"0"}]}]},"haveCommunicatedMessage":[{}],"customerTypeCD":"GENERAL","hasPolicyAccount":[{"hasAXAAsiaPolicyPaymentAccount":[{"statusCD":"success"}],"hasDetailsOfPolicyTransactionIn":[{"ccInstalmentIND":"21","batchID":"3","sourceSystemCD":"facebook","transactionNo":"c42eafd9-b676-408b-bc02-a61f3f306b83","producerCreditLimitUseIND":"40","transTypeCD":"false","key":"c42eafd9-b676-408b-bc02-a61f3f306b83!1579772370769!nnggVmUWybp8QPUWYpx5TClxRK8\u003d","referenceNO":"1000009"}]}],"customerRK":"admin@Dolphin123","customerID":"admin@inmotion.co.id"},"appID":"CHATBOT"}}';
        
        res.setBody(sJsonResponse);
        res.setStatusCode(200);
        
        return res; 
    }
}