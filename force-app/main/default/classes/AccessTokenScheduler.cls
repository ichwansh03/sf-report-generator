global class AccessTokenScheduler implements Schedulable{
    
    global void execute(SchedulableContext ctx) {
        
        callAccessToken();
    }
    
    @future(callout=true)
    public static void callAccessToken(){
        EIPJson eipResponse;
        String method = 'POST';
        try{
            EIPJson.EIP_GetToken tokenBody = new EIPJson.EIP_GetToken();
            tokenBody.client_id = System.Label.Client_Id;
            tokenBody.client_secret = System.Label.Client_Secret;
            tokenBody.grant_type = System.Label.Grant_Type;
            tokenBody.audience = System.Label.Audience_SAG;
            
            String requestJsonEIP = System.JSON.serialize(tokenBody, true);
            
            RESTWebserviceService rws = new RESTWebserviceService(System.Label.Endpoint_SAG, requestJsonEIP, method, Integer.ValueOf(Label.WS_Callout_Timeout));
            rws.send();
            eipResponse = (EIPJson) System.JSON.deserialize(rws.getResponseBodyReplace(), EIPJson.class);
            system.debug('rws get token: '+eipResponse);
            
            List<Access_Token__c> tokens = [SELECT Endpoint__c, Token__c FROM Access_Token__c WHERE Endpoint__c =:System.Label.Endpoint_SAG ORDER BY LastModifiedDate DESC LIMIT 1];
            if (Test.isRunningTest()) tokens = [SELECT Endpoint__c, Token__c FROM Access_Token__c ORDER BY LastModifiedDate DESC LIMIT 1];
            Access_Token__c at;
            
            if (!tokens.isEmpty()) {
                at = tokens[0];
                at.Token__c = eipResponse.access_token;
                update at;    
            } else {
                at = new Access_Token__c(Endpoint__c = System.Label.Endpoint_SAG, Token__c = eipResponse.access_token);
                insert at;
            }
            system.debug('access token: '+at);
        } catch (Exception e) {
            system.debug('error when access token: '+e.getMessage());
        }
    }
}