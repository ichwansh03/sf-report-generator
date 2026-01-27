public class MutualSSLTest {
    
    public static String execute(Map<String, String> properties){
        String endpoint = 'callout:RecordPolicyNotes/life-api/policy/v2/policies/notes';
        String response;
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        //req.setHeader('Authorization', 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImJVVzhQTkQwTlgzdVpJV3ZRRzJUdiJ9.eyJpc3MiOiJodHRwczovL2IyYnNzby10ZXN0LmF4YS5jby5pZC8iLCJzdWIiOiJFOGd6WmlUaXpLWDNHSVRhdGFCSnhLN3pDSFpRZ0xwNkBjbGllbnRzIiwiYXVkIjoiZXNnLWlkLWFtZnMiLCJpYXQiOjE3NjY1NDE2MDIsImV4cCI6MTc2NjU0NTIwMiwic2NvcGUiOiJnZW5lcmFsIiwiZ3R5IjoiY2xpZW50LWNyZWRlbnRpYWxzIiwiYXpwIjoiRThnelppVGl6S1gzR0lUYXRhQkp4Szd6Q0haUWdMcDYifQ.I7LnLkr9Jjt_m05NGUKkrB_tkWinZrt4FNKIWQG1bpukzIgbF8wReOkbcWX3ZMMMGsn7nDTGK59G44Bs_IiiPWyN9EuxvUDtd5Rro3ECAJM82fmCcqsUdyAAbcIHx6fYwV5F6BT1W3UBEcnfFMBdTrgDvODoAwDX2v924tcS-x12hetZLG9Rv7o46s3Q3QXta_DZLMiRYciSHtkR-JLuWqlD10hE7uoGayiYmSj8BtW-aKMGgO6kh567gkLl5NkAJy6WzbHOoXgbR4jQbFc5VWnIRBfAg6D3wH4eR-Ks1elSFLx7Ndv1e7AoxrHbDpZorX3kwUCndwG2GliRf_c2tw');
        req.setHeader('X-Axa-Entity', 'IB');
        req.setHeader('X-Axa-CallbackFlag', 'N');
        req.setHeader('X-Axa-ContextHeader-CustomData-TargetSystem', 'RLS');
        req.setHeader('X-Axa-ContextHeader-CustomData-SourceSystem', 'SCRM');
        req.setHeader('Accept', 'application/json');
        req.setHeader('X-Axa-LOB', 'Life');
        req.setHeader('X-Axa-Env', 'NFT3');
        req.setHeader('X-Axa-MsgId', 'RecordPolicyNotes_IB-WwxtAjZMnQZ1');
        req.setHeader('X-Axa-InitialMsgId', 'RecordPolicyNotes_IB-WwxtAjZMnQZ1');
        req.setHeader('X-Axa-RequestingChannel', 'SFDC');
        req.setHeader('X-Axa-ResubmissionFlag', 'Y');
        req.setHeader('Content-Type', 'application/json');
        
        // Raw JSON body (same as curl)
        String requestJsonEIP = '{' +
            '"RecordPolicyNotesRequest":{' +
            '"RLSPolicy":{' +
            '"policyNumber":"'+properties.get(EIPConstant.WA_POLICY_NUMBER)+'",' +
            '"underwritingRemarks":[{' +
            '"notificationTypeCode":"UN",' +
            '"referenceNumber":"",' +
            '"remarkCode":"'+properties.get(EIPConstant.PARAM_REMARK_CODE)+'",' +
            '"remarkDescription":"'+properties.get(EIPConstant.PARAM_REMARK_DESC)+'",' +
            '"departmentCode":"UW",' +
            '"lastUpdateDate":"'+properties.get(EIPConstant.PARAM_LASTUPDATE_DT)+'",' +
            '"completionDate":"'+properties.get(EIPConstant.PARAM_LASTUPDATE_DT)+'",' +
            '"completionStatus":"R",' +
            '"remarkIssueDate":"'+properties.get(EIPConstant.PARAM_LASTUPDATE_DT)+'"' +
            '}]' +
            '},' +
            '"STPRequestParameter":{' +
            '"languageCode":"E",' +
            '"countryCode":"IB"' +
            '}' +
            '}' +
            '}';
        req.setBody(requestJsonEIP);
        req.setTimeout(120000);
        
        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            System.debug('Status: ' + res.getStatus() + ' Body: ' + res.getBody());
            //return res;
            system.debug('req: '+req.getBody());
            system.debug('submission flag: '+req.getHeader('X-Axa-ResubmissionFlag'));
            response = res.getBody();
        } catch (System.CalloutException ex) {
            System.debug('Callout error: ' + ex.getMessage());
            throw ex;
        }
        
        return response;
    }
}