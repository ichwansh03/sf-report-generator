/*---------------------------------------------------------------
    Author      : Fikri Hailal
    Company     : MII
    Description : Get Mid Secure Payment by policy number
    Inputs      : -none-
    Test Class  : AXAAPI003_test

    <History>
    <Date>      <Authors Name>     <Brief Description of Change>    
    21102021    Andy Putra          Created
---------------------------------------------------------------*/
public class AXAAPI016A_MidSecurePaymentByPolNum {
    //public static FINAL string ENDPOINT = LABEL.AXASFDC_Endpoint +'mid-secure-payment-c?key=policy_No__c&value=';
     public static FINAL string ENDPOINT = LABEL.AXASFDC_Endpoint +'mid-secure-payment-c?key=contact__c&value=';
    public static FINAL string HTTP_SUCCESS_CODE = '2';
    public static FINAL integer CALLOUT_TIMEOUT = Integer.valueOf(Label.AXASFDC_CalloutTimeout);
    
    public static AXAAPI016A_response getMidSecurePaymentByPolNum(String id, integer skip, integer take){
        AXAAPI016A_response apires;
       system.debug('::: Midsecure By Contact');
        try{
            //get access token
            AXAAPI000_GenerateAccessToken.AXAAPI000_response restoken = AXAAPI000_GenerateAccessToken.generateAccessToken();
            
            if (test.isRunningTest() && restoken.access_token == NULL) restoken.access_token = LABEL.AXASFDC_TokenTest;
            if(restoken.access_token != NULL){
                //set http request
                HttpRequest req = new HttpRequest();
                req.setHeader('Authorization', 'Bearer ' + restoken.access_token);
                req.setMethod('GET');
                req.setEndpoint(ENDPOINT+id+'&skip='+skip+'&take='+take); 
                req.setTimeout(CALLOUT_TIMEOUT);
                
                system.debug('::: Midsecure req:'+req);
                //execute outbound call
                Http http = new Http();
                HttpResponse res = http.send(req);
                
                system.debug('::: Midsecure res:'+res);
                system.debug('::: Midsecure ENDPOINT:'+ENDPOINT+id+'&skip=0&take=10');
                
                // HTTP Callout Successfully with Unity return
                if(res.getBody() != null && String.valueOf(res.getStatusCode()).startsWith(HTTP_SUCCESS_CODE)){
                    apires = AXAAPI016A_response.parse(res.getBody());
                }
                // HTTP Callout Error with body response
                else if(res.getBody() != null && !String.valueOf(res.getStatusCode()).startsWith(HTTP_SUCCESS_CODE)){
                    
                }else{
                    // HTTP Callout Error without body response                
                }
            }
            
        }catch(System.CalloutException e) {
            
                system.debug('::: Midsecure Catch:'+e);
        }
        return apires;
    }
}