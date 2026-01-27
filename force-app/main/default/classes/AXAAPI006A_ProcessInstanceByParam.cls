/* 
*  @author  Ranti Dwi Putri <rdpranntiii@gmail.com>
*  @Param   INT Id targetObjId
*  @Desc    Get list Process Instance
*  @Class   AXAAPI006A_response 
*  @Return  Array
*/
public class AXAAPI006A_ProcessInstanceByParam {
	public static FINAL string ENDPOINT = LABEL.AXASFDC_Endpoint +'process-instance?';
  
    public static FINAL string HTTP_SUCCESS_CODE = '2';
    public static FINAL integer CALLOUT_TIMEOUT = Integer.valueOf(Label.AXASFDC_CalloutTimeout);
    
    public static AXAAPI006A_response getProcessInstance(String paramCase, String relationId){
        AXAAPI006A_response apires;
        
        if (paramCase == null || relationId == null) return null;
        List<String> paramAPI = new List<String>();
        
        paramAPI.add('key='+paramCase);
        paramAPI.add('value='+relationId);
        paramAPI.add('skip=0');
        paramAPI.add('take=10'); 
        
        String returnParam = String.join(paramAPI,'&');
        System.debug('Param='+returnParam); 
        try{
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
                    apires = AXAAPI006A_response.parse(res.getBody());
                	system.debug('apires:'+apires);
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