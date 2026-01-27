/* 
*  @author  Ranti Dwi Putri <rdpranntiii@gmail.com>
*  @Param   INT Id negative feedback
*  @Desc    Get Detail negative feedback
*  @Class   AXAAPI013B_response
*  @Ctrl    NegativeFeedback_CustomPage_ctrl
*  @Return  Array
*/
public class AXAAPI013B_NegativeFeedbackByID {
	public static FINAL string ENDPOINT = LABEL.AXASFDC_Endpoint +'negative-feedback-c/id?value=';
    public static FINAL string HTTP_SUCCESS_CODE = '2';
    public static FINAL integer CALLOUT_TIMEOUT = Integer.valueOf(Label.AXASFDC_CalloutTimeout);
    
    public static AXAAPI013B_response getNegativeFeedbackId(String id){
        AXAAPI013B_response apires;
        try{
            //get access token
            AXAAPI000_GenerateAccessToken.AXAAPI000_response restoken = AXAAPI000_GenerateAccessToken.generateAccessToken();
            
            if (test.isRunningTest() && restoken.access_token == NULL) restoken.access_token = LABEL.AXASFDC_TokenTest;
            if(restoken.access_token != NULL){
                //set http request
                HttpRequest req = new HttpRequest();
                req.setHeader('Authorization', 'Bearer ' + restoken.access_token);
                req.setMethod('GET');
                req.setEndpoint(ENDPOINT+id+'&skip=0&take=10'); 
                req.setTimeout(CALLOUT_TIMEOUT);
                
                //execute outbound call
                Http http = new Http();
                HttpResponse res = http.send(req);
                
                // HTTP Callout Successfully with Unity return
                if(res.getBody() != null && String.valueOf(res.getStatusCode()).startsWith(HTTP_SUCCESS_CODE)){
                    apires = AXAAPI013B_response.parse(res.getBody());
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