/*---------------------------------------------------------------
    Author      : Andy Putra
    Company     : MII
    Description : generate access token
    Inputs      : -none-
    Test Class  : AXAAPI000_test

    <History>
    <Date>      <Authors Name>     <Brief Description of Change>    
    28102021    Andy Putra          Created
---------------------------------------------------------------*/
public class AXAAPI000_GenerateAccessToken {
	public static FINAL string API_ENDPOINT = LABEL.AXASFDC_Endpoint + 'connect/token';
    public static FINAL string API_GRANTTYPE = LABEL.AXASFDC_GrantType;
    public static FINAL string API_SCOPE = LABEL.AXASFDC_Scope;
    public static FINAL string API_CLIENTID = LABEL.AXASFDC_ClientId;
    public static FINAL string API_CLIENTSECRET = LABEL.AXASFDC_ClientSecret;
    
    public static FINAL string HTTP_SUCCESS_CODE = '2';
    public static FINAL integer CALLOUT_TIMEOUT = Integer.valueOf(Label.AXASFDC_CalloutTimeout);
        
    public static AXAAPI000_response generateAccessToken(){
        AXAAPI000_response resapi = new AXAAPI000_response();
        try{
            //set http request
            String body = 'grant_type='+EncodingUtil.urlEncode(API_GRANTTYPE, 'UTF-8')+
                '&scope='+EncodingUtil.urlEncode(API_SCOPE, 'UTF-8')+
                '&client_id='+EncodingUtil.urlEncode(API_CLIENTID, 'UTF-8')+
                '&client_secret='+EncodingUtil.urlEncode(API_CLIENTSECRET, 'UTF-8');
            
            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
            req.setEndpoint(API_ENDPOINT); 
            req.setTimeout(CALLOUT_TIMEOUT);
            req.setBody(body);
            
            //execute outbound call
            Http http = new Http();
            HttpResponse res = http.send(req);
            
            if(res.getBody() != null && String.valueOf(res.getStatusCode()).startsWith(HTTP_SUCCESS_CODE)){
                resapi = (AXAAPI000_response) JSON.deserialize(res.getBody(), AXAAPI000_response.class);
            }
        }catch(Exception ex){
            system.debug('error:'+ex.getMessage());
        }
        return resapi;
    }
    
    public class AXAAPI000_response {
        public AXAAPI000_response(){}
        
        public String access_token;
        public Integer expires_in;
        public String token_type;
        public String scope;
    }
}