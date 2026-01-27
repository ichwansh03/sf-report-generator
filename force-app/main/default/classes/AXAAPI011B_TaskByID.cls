/*---------------------------------------------------------------
    Author      : Fikri Hailal
    Company     : MII
    Description : get list of Task by Owner
    Inputs      : -none-
    Test Class  : AXAAPI011_test

    <History>
    <Date>      <Authors Name>     <Brief Description of Change>    
    19102021    Andy Putra          Created
---------------------------------------------------------------*/
public class AXAAPI011B_TaskByID {
    public static FINAL string ENDPOINT = LABEL.AXASFDC_Endpoint +'task/id?value=';
    public static FINAL string HTTP_SUCCESS_CODE = '2';
    public static FINAL integer CALLOUT_TIMEOUT = Integer.valueOf(Label.AXASFDC_CalloutTimeout);
    
    public static AXAAPI011B_response getTaskByID(String id){
        AXAAPI011B_response apires;
        try{
            //get access token
            AXAAPI000_GenerateAccessToken.AXAAPI000_response restoken = AXAAPI000_GenerateAccessToken.generateAccessToken();
            
            if (test.isRunningTest() && restoken.access_token == NULL) restoken.access_token = LABEL.AXASFDC_TokenTest;
            if(restoken.access_token != NULL){
                //set http request
                HttpRequest req = new HttpRequest();
                req.setHeader('Authorization', 'Bearer ' + restoken.access_token);
                req.setMethod('GET');
                req.setEndpoint(ENDPOINT+id); 
                req.setTimeout(CALLOUT_TIMEOUT);
                
                //execute outbound call
                Http http = new Http();
                HttpResponse res = http.send(req);
                
                // HTTP Callout Successfully with Unity return
                if(res.getBody() != null && String.valueOf(res.getStatusCode()).startsWith(HTTP_SUCCESS_CODE)){
                    apires = AXAAPI011B_response.parse(res.getBody());
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