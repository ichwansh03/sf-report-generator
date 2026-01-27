/* 
*  @author  Ranti Dwi Putri <rdpranntiii@gmail.com>
*  @Param   String  paramField field
*  @Param   String paramValue value
*  @Desc    Get list Survey taken
*  @Class   AXAAPI014A_response
*  @Ctrl    SurveyTaken_CustomPage_ctrl
*  @Return  Array
*/
public class AXAAPI014A_SurveyTakenByParam {  
    
    public static FINAL string ENDPOINT = LABEL.AXASFDC_Endpoint +'survey-taker-c?';
  
    public static FINAL string HTTP_SUCCESS_CODE = '2';
    public static FINAL integer CALLOUT_TIMEOUT = Integer.valueOf(Label.AXASFDC_CalloutTimeout);
    
    
    public static AXAAPI014A_response getSurveyTakenByParam(String paramField, String paramValue, integer skip, integer take){
        AXAAPI014A_response apires;
        try{
            
            if (paramField == null || paramValue == null) return null;
            List<String> paramAPI = new List<String>();
            
            paramAPI.add('key='+paramField);
            paramAPI.add('value='+paramValue);
            paramAPI.add('skip='+skip);
            paramAPI.add('take='+take); 
            
            String returnParam = String.join(paramAPI,'&');
            System.debug('Param='+returnParam); 
            //get access token
            AXAAPI000_GenerateAccessToken.AXAAPI000_response restoken = AXAAPI000_GenerateAccessToken.generateAccessToken();
            
            if (test.isRunningTest() && restoken.access_token == NULL) restoken.access_token = LABEL.AXASFDC_TokenTest;
            if(restoken.access_token != NULL){
                //set http request
                HttpRequest req = new HttpRequest();
                req.setHeader('Authorization', 'Bearer ' + restoken.access_token);
                req.setMethod('GET');
                req.setEndpoint(ENDPOINT+returnParam);  
                req.setTimeout(CALLOUT_TIMEOUT);
                
                //execute outbound call
                Http http = new Http();
                HttpResponse res = http.send(req);
                
                // HTTP Callout Successfully with Unity return
                if(res.getBody() != null && String.valueOf(res.getStatusCode()).startsWith(HTTP_SUCCESS_CODE)){
                    apires = AXAAPI014A_response.parse(res.getBody());
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