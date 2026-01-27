/* 
*  @author  Ranti Dwi Putri <rdpranntiii@gmail.com>
*  @Param   INT Id Case
*  @Desc    Get list Purecloud
*  @Class   AXAAPI020A_response 
*  @Return  Array
*/
public class AXAAPI020A_PureCloudByParam {
	public static FINAL string ENDPOINT = LABEL.AXASFDC_Endpoint +'pure-cloud';
  
    public static FINAL string HTTP_SUCCESS_CODE = '2';
    public static FINAL integer CALLOUT_TIMEOUT = Integer.valueOf(Label.AXASFDC_CalloutTimeout);
    
    public static AXAAPI020A_response getPureCloudByParam(String postUrl){
        AXAAPI020A_response apires;
        
        /*if (paramCase == null || valueFilter == null) return null;
        List<String> paramAPI = new List<String>();
        
        paramAPI.add('key='+paramCase);
        paramAPI.add('value='+EncodingUtil.urlEncode(valueFilter, 'UTF-8'));
        paramAPI.add('skip='+skip);
        paramAPI.add('take='+take); 
        
        String returnParam = String.join(paramAPI,'&');
        System.debug('Param='+returnParam); 
		*/
        try{ 
            //get access token
            AXAAPI000_GenerateAccessToken.AXAAPI000_response restoken = AXAAPI000_GenerateAccessToken.generateAccessToken();
            if (test.isRunningTest() && restoken.access_token == NULL) restoken.access_token = LABEL.AXASFDC_TokenTest;
            if(restoken.access_token != NULL){
                //set http request
                HttpRequest req = new HttpRequest();
                req.setHeader('Authorization', 'Bearer ' + restoken.access_token);
                req.setMethod('GET');
                req.setEndpoint(ENDPOINT+postUrl);  
                req.setTimeout(CALLOUT_TIMEOUT);
                
                System.debug(':::Url Purecloud Agent:'+ENDPOINT+postUrl);
                 
                //execute outbound call
                Http http = new Http();
                HttpResponse res = http.send(req);
                
                // HTTP Callout Successfully with Unity return
                if(res.getBody() != null && String.valueOf(res.getStatusCode()).startsWith(HTTP_SUCCESS_CODE)){
                    apires = AXAAPI020A_response.parse(res.getBody());
                	system.debug('apires:'+apires);
                }
                // HTTP Callout Error with body response
                else if(res.getBody() != null && !String.valueOf(res.getStatusCode()).startsWith(HTTP_SUCCESS_CODE)){
                    
                	system.debug('Not Success:');
                }else{
                    
                	system.debug('BLANK');
                    // HTTP Callout Error without body response                
                }
            }
            
        }catch(System.CalloutException e) {
            
        }
        return apires;
    }
}