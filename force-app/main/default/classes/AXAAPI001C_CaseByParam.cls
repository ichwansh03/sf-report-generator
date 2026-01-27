/*---------------------------------------------------------------
    Author      : Andy Putra
    Company     : MII
    Description : get list of case by param
    Inputs      : -none-
    Test Class  : AXAAPI001_test

    <History>
    <Date>      <Authors Name>     <Brief Description of Change>    
    19102021    Andy Putra          Created
---------------------------------------------------------------*/
public class AXAAPI001C_CaseByParam {
    public static FINAL string ENDPOINT = LABEL.AXASFDC_Endpoint +'case';
    public static FINAL string HTTP_SUCCESS_CODE = '2';
    public static FINAL integer CALLOUT_TIMEOUT = Integer.valueOf(Label.AXASFDC_CalloutTimeout);
    
    public static AXAAPI001C_response getCaseByParam(String postUrl){
        AXAAPI001C_response apires;
        try{
            system.debug('::::postUrl Endpoint:'+ENDPOINT + postUrl); 
            //get access token
            //AXAAPI000_GenerateAccessToken.AXAAPI000_response restoken = AXAAPI000_GenerateAccessToken.generateAccessToken();
            Access_Token__c at = [SELECT Token__c FROM Access_Token__c LIMIT 1];
            
             //system.debug('restoken case by param=='+restoken);
            system.debug('::::postUrl Endpoint2:'+ENDPOINT);
            system.debug('::::postUrl Endpoint3:'+ postUrl); 
            //if (test.isRunningTest() && restoken.access_token == NULL) restoken.access_token = LABEL.AXASFDC_TokenTest;
            if (test.isRunningTest() && at.Token__c == NULL) at.Token__c = LABEL.AXASFDC_TokenTest;
            //if(restoken.access_token != NULL){
            if(at.Token__c != NULL){
                system.debug('restoken tidak null' + at.Token__c);
                //set http request
                HttpRequest req = new HttpRequest();
                //req.setHeader('Authorization', 'Bearer ' + restoken.access_token);
                req.setHeader('Authorization', 'Bearer '+at.Token__c);
                req.setMethod('GET');
                req.setEndpoint(ENDPOINT + postUrl); 
                req.setTimeout(CALLOUT_TIMEOUT);
                
                //execute outbound call
                Http http = new Http();
                HttpResponse res = http.send(req);
                System.debug('Respon multi param == ' + res);
                
                // HTTP Callout Successfully with Unity return
                if(res.getBody() != null && String.valueOf(res.getStatusCode()).startsWith(HTTP_SUCCESS_CODE)){
                    apires = AXAAPI001C_response.parse(res.getBody());
                }
                // HTTP Callout Error with body response
                else if(res.getBody() != null && !String.valueOf(res.getStatusCode()).startsWith(HTTP_SUCCESS_CODE)){
                    
                }else{
                    // HTTP Callout Error without body response                
                }
            }else{
                
            }            
        }catch(System.CalloutException e) {
            
        }
        return apires;
    }
}