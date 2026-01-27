public class RESTWebserviceService {
    /* :: Attributes :: */
    public Http h {get; set;}
    public HttpRequest request {get; set;}
    public HttpResponse response {get; set;}
    
    public string method {get; set;}
    public string endPoint {get; set;}
    
    public string username {get; set;}
    public string password {get; set;}
    
    
    /* ::  Methods :: */
    public void setEndPoint (string endPoint) {
        this.request.setEndPoint (endPoint);
        this.endPoint = endPoint;
    }
    
    public void setBody (string body) {
        this.request.setBody (body);
    }
    
    public void setMethod (string method) {
        this.method = method;
        this.request.setMethod (method);
    } 
        
    public void send () {
        
        DateTime dtStart = DateTime.now();
        
        system.debug('.');
        system.debug('====================================================================================================================================');
        system.debug('============ WEB SERVICE CALL OUT');
        system.debug('============ End Point             : ' + request.getEndpoint());
        system.debug('============ Method                : ' + request.getMethod());
        system.debug('============ Header                : Content-type=' + request.getHeader('Content-type') + ', Authorization=' + request.getHeader('Authorization') );
        system.debug('============ Request Body          : ' + request.getBody());
        system.debug('============ Request String        : ' + request.toString());
        system.debug('=');
        try {
            this.response = h.send(request);
        }
        catch  (Exception e) {
            system.debug ('================ REQUEST SEND ERROR - WEB SERVICE CALL OUT  :  ' + e.getMessage());
            system.debug('================ response status : '+e.getCause());
        }
        
        DateTime dtEnd = DateTime.now();
        long d =  dtEnd.getTime() - dtStart.getTime() ;
        
        system.debug('=');
        system.debug('============ Request Starting at   : ' + dtStart + ' ('+ dtStart.addHours(7) +')');
        system.debug('============ Request End at        : ' + dtEnd + ' ('+ dtEnd.addHours(7) +')');
        system.debug('============ Call Request Duration : ' + d + ' milliseconds'); 
        
    }
    
    public string getResponseBody() {
        system.debug('============ List Header           : ' + response.getHeaderKeys());
        system.debug('============ Respond Header x-invocationtime : ' + response.getHeader('x-invocationtime'));
        system.debug('============ Respond Header x-executiontime : ' + response.getHeader('x-executiontime'));
        system.debug('============ Respond Body          : ' + response.getBody());
        system.debug('====================================================================================================================================');
        system.debug('.');
        
        return response.getBody();
    }
  
    public string getResponseBodyReplace() {
        system.debug('============ List Header           : ' + response.getHeaderKeys());
        system.debug('============ Respond Header x-invocationtime : ' + response.getHeader('x-invocationtime'));
        system.debug('============ Respond Header x-executiontime : ' + response.getHeader('x-executiontime'));
        system.debug('============ Respond Body          : ' + response.getBody());
        system.debug('====================================================================================================================================');
        system.debug('.');
        
        String resBody = response.getBody(); 
        Integer resBodySize = resBody.length();
        system.debug('resBodySize  '+ resBodySize);
        //system.debug(resBody.substring(0, 149));
        //system.debug(resBody.substring(149, 299));
        //system.debug(resBody.substring(299, 449));
        //system.debug(resBody.substring(499, 599));
        //system.debug(resBody.substring(599, resBodySize));
        system.debug('ini response====================================================================================================================================');
        system.debug('.'); 
        
        
        String responseReplace = response.getBody();
        responseReplace = responseReplace.replaceFirst('"exception": {0,1}\\{', '"exceptionObj": {');
        return responseReplace;
    }  
    
    /* :: Constructor :: */
    public RESTWebserviceService(String endPoint, String body, String method, Integer timeOut) {
        try {
            h = new Http();
            request = new HttpRequest();
            response = new HttpResponse();
            
            System.debug('Body Rest: ' + body);
            
            Boolean isLiveChat = body == 'Live Chat';
            Boolean isEditWorkingTime = endPoint.contains('editWorkingTimeConfiguration');
            Boolean isBodyValid = !String.isBlank(body);
            
            Boolean isAmfsCase = false;
            
            if (isBodyValid && !isLiveChat && !isEditWorkingTime) {
                EIPJson convertReqJson = (EIPJson) JSON.deserialize(body, EIPJson.class);
                isAmfsCase = (convertReqJson.Body != null && convertReqJson.Body.entity == 'AMFS');
                
                if (isAmfsCase) {
                    endPoint = endPoint.replace(Label.REST_WS_Endpoint, Label.REST_WS_Endpoint_AMFS);
                    System.debug('===== Get AMFS Token =====');
                }
            }
            
            if (isAmfsCase || isLiveChat || isEditWorkingTime) {
                Access_Token__c at = [SELECT Token__c FROM Access_Token__c LIMIT 1];
                request.setHeader('Authorization', 'Bearer ' + at.Token__c);
            }
            
            request.setEndPoint(endPoint);
            request.setMethod(method);
            
            if (method == 'POST') {
                request.setBody(body);
            }
            
            request.setHeader('Content-type', 'application/json');
            request.setHeader('Accept', 'application/json'); // Add for config EIP Cloud by Beni Rama 02/12/2022
            request.setTimeout(timeOut);
            
        } catch (Exception e) {
            System.debug('RESTWebserviceService Error Message: ' + e.getMessage());
            System.debug('RESTWebserviceService Stack Trace: ' + e.getStackTraceString());
        }
    }
    
    public RESTWebserviceService(String endPoint, String body, String method, String flag, Integer timeOut) {
        try {
            h = new Http();
            request = new HttpRequest();
            response = new HttpResponse();
            
            request.setEndPoint('callout:RecordPolicyNotes/life-api/policy/v2/policies/notes');
            request.setMethod(method);
            if (method == 'POST') {
                request.setBody(body);
            }
            request.setHeader('X-Axa-Entity','IB');
            request.setHeader('X-Axa-CallbackFlag', 'N');
            request.setHeader('X-Axa-ContextHeader-CustomData-TargetSystem', 'RLS');
            request.setHeader('X-Axa-ContextHeader-CustomData-SourceSystem', 'SCRM');
            request.setHeader('X-Axa-LOB', 'Life');
            request.setHeader('X-Axa-Env','NFT3');
            request.setHeader('X-Axa-MsgId','RecordPolicyNotes_IB-WwxtAjZMnQZ1');
            request.setHeader('X-Axa-InitialMsgId','RecordPolicyNotes_IB-WwxtAjZMnQZ1');
            request.setHeader('X-Axa-RequestingChannel', 'SFDC');
            request.setHeader('X-Axa-ResubmissionFlag', flag);
            request.setHeader('Content-type', 'application/json');
            request.setHeader('Accept', 'application/json');
            request.setTimeout(timeOut);    
        } catch (Exception e) {
            System.debug('RESTWebserviceService Error Message: ' + e.getMessage());
            System.debug('RESTWebserviceService Stack Trace: ' + e.getStackTraceString());
        }
    }    
   
    public RESTWebserviceService(ApexPages.StandardController controller) {
        
    }
       
}