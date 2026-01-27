global class Purecloud_Connector{
    @future (callout=true)
    public static void execute(){   

    String clientId = label.Purecloud_ClientId;
    String clientSecret = label.Purecloud_ClientSecret;
    String connId = label.PureCloud_connId;

    String accessToken;
        
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
    
        req.setHeader('Authorization', 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(clientId + ':' + clientSecret)));
        //req.setHeader('Host','https://login.mypurecloud.jp/oauth'); //unsupported header by suryono 15 oct 2020
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        req.setEndpoint('https://login.mypurecloud.jp/oauth/token?grant_type=client_credentials'); //add param by suryono 15 oct 2020
    
        //req.setBody('grant_type=client_credentials'); //moved to endpoint url by suryono 15 oct 2020
        System.debug(req.getBody());
        System.debug(req.getHeader('content-type'));
        System.debug(req.getHeader('Authorization'));
        Http http = new Http();
        
        try{
            HTTPResponse res = http.send(req);
            System.debug('res:' + res);
            System.debug('body:' + res.getBody());
            JSONParser parser;
            if (Test.isRunningTest()) parser = JSON.createParser('{   "access_token": "123123123123",   "token_type": "bearer",   "expires_in": 3600,   "error": "optional-error-message" }');
            else parser = JSON.createParser(res.getBody());
            integer x = 0;
            while (parser.nextToken() != null) {
                x++;
                system.debug('countLoop:' + x);
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'access_token')){
                        parser.nextToken();
                        accessToken = parser.getText();
                }
                
                Purecloud_Connector__c conn = new Purecloud_Connector__c();
                conn.id = connId;
                conn.Access_Token__c = accessToken;
                update conn;
            }  
        } catch(System.CalloutException e){
            System.debug('exception:' + e);
            // do something useful here
        }
    }
}