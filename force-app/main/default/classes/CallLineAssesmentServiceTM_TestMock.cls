@isTest
global class CallLineAssesmentServiceTM_TestMock implements HttpCalloutMock {

    global HttpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setHeader('Authentication', 'Bearer qwerty123');
        
        System.debug('CALL LINE ASSESMENT DMTM MOCK REQUEST: '+req.getBody());
        String sJsonResponse='';

        if (req.getBody().contains(EIPConstant.OPERATION_REQUEST_INQUIRY)){
            sJsonResponse = '{"Body":{"Customer":{"relatedPolicy":"561","hasPolicyAccount":[{"hasCustomerInformationIn":[{"validFromDttm":"2024-03-26T09:51:55.587","dependentAdultCnt":"0","relatedPolicy":"300-101-0213785","firstBecameCustomerDt":"2024-03-26T09:51:55.587","staffStatusCD":"admin","customerStatusCD":"CV","sourceCInd":"U","contactableFlg":"MICROSVC","custLifeTimeValue":"Approved by Change List","customerRK":"2024-03-26T09:51:55.587","customerID":"20240326-000003","relatedPolicyholdersCnt":"Portal","customerTypeCD":"CV","terminationDt":"2024-03-26T09:51:55.587"}],"policyNO":"300-101-0213785","producerRk":"1","applicationRk":"10"}],"numRelations":"56","key":"baa8184e-5324-44d3-b6b7-e175b5b6ad1c#10.47.130.71#SFDCEIP","haveCommunicatedMessage":[{"messageID":"200","message":"OK"}]},"service":"getPolicyDetails","appID":"DMTM_REST_V3","operation":"get transaction status","transactionId":"0056F000008o9L1QAI-20250915-207a1f3dda06951eff71d0fc94525bbf","entity":"AMFS","status":"1"}}';
        } else if (req.getBody().contains(EIPConstant.OPERATION_INSERT_CALLNOTE)) {
            sJsonResponse = '{"Body":{"transactionId":"888-1726713446","appID":"DMTM_REST_V3","entity":"AMFS","service":"addCustomer","operation":"insert call notes","Customer":{"processedDttm":"2024-09-19T02:37:27","key":"f4a178c2-52b3-42fe-9630-75568712a32e#10.144.5.15#SFDCEIP","hasPolicyAccount":[{"policyVersion":"false","policyRK":"Diisi dengan Note","registeredBy":"Created By","accountNo":"192381983","renewalDt":"1999-07-01T00:00:00","policyDueDt":"1999-07-01T00:00:00","policyNO":"300-107-5561401","hasNameValue":[{"value":"2010080201"},{"value":"2010080201"}],"terminationDt":"1999-07-01T00:00:00","policyStatusCD":"Y"}],"haveCommunicatedMessage":[{"message":"Success","messageID":"200"}]},"status":"1"}}';
        } else if (req.getBody().contains(EIPConstant.OPERATION_INSERT_CONSERVATION)){
            sJsonResponse = '{"Body":{"transactionId":"888-1725526288","appID":"DMTM_REST_V3","entity":"AMFS","service":"addCustomer","operation":"conservation","Customer":{"processedDttm":"2024-09-05T08:51:28","key":"731531d4-a0b5-4f61-8a38-c79bd7e980a6#100.74.7.210#SFDCEIP","hasPolicyAccount":[{"policyRK":"test remark yaa","statusReasonCd":"IN","processedDttm":"1999-07-01T00:00:00","policyNO":"300-107-5561401","uwTypeCd":"UNCO","otherInsuredInd":"20240307-000005"}],"haveCommunicatedMessage":[{"message":"Ok","messageID":"200"}]},"status":"1"}}';
        }    
        
        res.setBody(sJsonResponse);
        
        return res;
    }
}