/*---------------------------------------------------------------
    Author      : Fikri Hailal
    Company     : MII
    Description : get chat transcript by Case id
    Inputs      : -none-
    Test Class  : 

    <History>
    <Date>      <Authors Name>     <Brief Description of Change>    
    30112021    Fikri Hailal         Created
---------------------------------------------------------------*/
public class AXAAPI021A_ChatTranscriptByCase {
    public static FINAL string ENDPOINT = LABEL.AXASFDC_Endpoint +'live-chat-transcript?key=Caseid&value=';
    public static FINAL string HTTP_SUCCESS_CODE = '2';
    public static FINAL integer CALLOUT_TIMEOUT = Integer.valueOf(Label.AXASFDC_CalloutTimeout);
    
    public static AXAAPI021A_response getChatTranscriptByCase(String id){
        AXAAPI021A_response apires;
        try{
            //get access token
            AXAAPI000_GenerateAccessToken.AXAAPI000_response restoken = AXAAPI000_GenerateAccessToken.generateAccessToken();
            if (test.isRunningTest() && restoken.access_token == NULL) restoken.access_token = LABEL.AXASFDC_TokenTest;
            if(restoken.access_token != NULL){
                //set http request
                HttpRequest req = new HttpRequest();
                req.setHeader('Authorization', 'Bearer ' + restoken.access_token);
                req.setMethod('GET');
                req.setEndpoint(ENDPOINT+id+'&skip=0&take=5'); 
                req.setTimeout(CALLOUT_TIMEOUT);
                
                //execute outbound call
                Http http = new Http();
                HttpResponse res = http.send(req);
                
                // HTTP Callout Successfully with Unity return
                if(res.getBody() != null && String.valueOf(res.getStatusCode()).startsWith(HTTP_SUCCESS_CODE)){
                    apires = AXAAPI021A_response.parse(res.getBody());
                }
                // HTTP Callout Error with body response
                else if(res.getBody() != null && !String.valueOf(res.getStatusCode()).startsWith(HTTP_SUCCESS_CODE)){
                    
                }else{
                    // HTTP Callout Error without body response                
                }
            }
            
        }catch(System.CalloutException e) {
            
        }
        return apires;
    }
}