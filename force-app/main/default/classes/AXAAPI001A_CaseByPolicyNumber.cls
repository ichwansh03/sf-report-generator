/*---------------------------------------------------------------
    Author      : Andy Putra
    Company     : MII
    Description : get list of case by policy number
    Inputs      : -none-
    Test Class  : AXAAPI001_test

    <History>
    <Date>      <Authors Name>     <Brief Description of Change>    
    19102021    Andy Putra          Created
---------------------------------------------------------------*/
public class AXAAPI001A_CaseByPolicyNumber {
    public static FINAL string ENDPOINT = LABEL.AXASFDC_Endpoint +'case?key=contactId&value=';
    public static FINAL string HTTP_SUCCESS_CODE = '2';
    public static FINAL integer CALLOUT_TIMEOUT = Integer.valueOf(Label.AXASFDC_CalloutTimeout);
    
    public static AXAAPI001A_response getCaseByPolicyNumber(String policy_number, integer skip, integer take){
        AXAAPI001A_response apires;
        String debug;
        try{
            //get access token
            AXAAPI000_GenerateAccessToken.AXAAPI000_response restoken = AXAAPI000_GenerateAccessToken.generateAccessToken();
             
            if (test.isRunningTest() && restoken.access_token == NULL) restoken.access_token = LABEL.AXASFDC_TokenTest;
            if(restoken.access_token != NULL){
                
                System.debug('ENDPOINT CASE BY CONTACT:'+ENDPOINT+policy_number+'&skip='+skip+'&take='+take);
                //set http request
                HttpRequest req = new HttpRequest();
                req.setHeader('Authorization', 'Bearer ' + restoken.access_token);
                req.setMethod('GET');
                req.setEndpoint(ENDPOINT+policy_number+'&skip='+skip+'&take='+take); 
                req.setTimeout(CALLOUT_TIMEOUT);
                
                //execute outbound call
                Http http = new Http();
                HttpResponse res = http.send(req);
                
                // HTTP Callout Successfully with Unity return
                if(res.getBody() != null && String.valueOf(res.getStatusCode()).startsWith(HTTP_SUCCESS_CODE)){
                    apires = AXAAPI001A_response.parse(res.getBody());
                	debug = 'HTTP Callout Successfully with Unity return ';
                }
                // HTTP Callout Error with body response
                else if(res.getBody() != null && !String.valueOf(res.getStatusCode()).startsWith(HTTP_SUCCESS_CODE)){
                    
                	debug = 'HTTP Callout Error with body response    ';
                }else{
                	debug = 'HTTP Callout Error without body response    ';
                    // HTTP Callout Error without body response                
                }
            }else{
                debug = 'NULL';
            }            
        }catch(System.CalloutException e) {
            debug = 'catch:'+e.getMessage();
        }
        
        System.debug('Debug:' + debug);
        return apires;
    }
}