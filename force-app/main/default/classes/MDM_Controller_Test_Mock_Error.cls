@isTest
global class MDM_Controller_Test_Mock_Error implements HttpCalloutMock{
    global HttpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatus('Service Unavailable');
        String sJsonRequest = req.getBody();
        EIPJson eipJson = (EIPJson) System.JSON.deserializeStrict(sJsonRequest, EIPJson.class);
        String operation = EIPJson.Body.operation;
        res.setBody('{"message":"Unable to get response from Backend server","reasonCode":"ESG_ERR-009","reason":"Unable to get response from Backend server"}');
        res.setStatusCode(503);
        
        return res; 
    }
}