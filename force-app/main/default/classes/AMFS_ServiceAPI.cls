/**
 * @description       : 
 * @author            : Muh Syafiq Hidayatullah
 * @group             : 
 * @last modified on  : 18-07-2025
 * @last modified by  : Muh Syafiq Hidayatullah
**/
public with sharing class AMFS_ServiceAPI {
    // Integration response wrapper
    public class IntegrationResponse {
        public String responseBody { get; set; }
        public String errorMessage { get; set; }
        public String requestBody { get; set; }
        public String httpMethod { get; set; }
        public String status { get; set; }
        public String policyNo { get; set; }
        public String policyApp { get; set; }
        public String entity { get; set; }
        public Long startLongTime { get; set; }
        public Long endLongTime { get; set; }
        public Integer statusCode { get; set; }
        public String caseId { get; set; }
        public String contactSFID { get; set; }
    }
    // Build HTTP Callout
    public static IntegrationResponse makeHttpCallout(String endpoint, String method, String requestBody, Map<String, String> headers,Integer timeout, String policyNo, String policeApp, String entity, String caseId, Long startLongTime){
        IntegrationResponse response = new IntegrationResponse();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        try {
            // Setup HTTP request
            req.setEndpoint(endpoint);
            req.setMethod(method);
            req.setTimeout(timeout != null ? timeout : 60000); // Default 60 seconds
            // Set headers
            if (headers != null && !headers.isEmpty()) {
                for (String key : headers.keySet()) {
                    req.setHeader(key, headers.get(key));
                }
            }
            // Set request body for POST/PUT methods
            if (String.isNotBlank(requestBody) && (method == 'POST' || method == 'PUT')) {
                req.setBody(requestBody);
            }
            // Make HTTP callout
            Http http = new Http();
            res = http.send(req);
            // Populate response
            response.responseBody = res.getBody();
            response.requestBody = requestBody;
            response.httpMethod = method;
            response.policyNo = policyNo;
            response.policyApp = policeApp;
            response.entity = entity;
            response.statusCode = res.getStatusCode();
            response.caseId = caseId;
            response.contactSFID = caseId;
            response.startLongTime = startLongTime;
            // Long startLongTime;
            if(UserInfo.getUserType() == 'Guest'){
                response.endLongTime = System.now().addHours(7).getTime();
            }else {
                response.endLongTime = System.now().getTime();
            }
            // Check if successful
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            Map<String, Object> body =(Map<String, Object>) result.get('Body');
            if (res.getStatusCode() >= 200 && res.getStatusCode() < 300) {
                if(body.get('exception') != null){
                    Map<String, Object> exceptionJSON =(Map<String, Object>) body.get('exception');
                    String errorCode1 = (String) exceptionJSON.get('code');
                    String errorMessageJSON1 = (String) exceptionJSON.get('message'); 
                    response.status = 'Error' +  ' - ' + errorCode1;
                    response.errorMessage = 'HTTP Error: ' + res.getStatusCode() + ' - ' + errorMessageJSON1;
                } else {
                    response.status = 'Success' +  ' - ' + res.getStatusCode();
                }
            } else {
                if (result.containsKey('errorCode') && result.containsKey('errorMessage')){
                    String errorCode0 = (String) result.get('errorCode');
                    String errorMessageJSON0 = (String) result.get('errorMessage');
                    response.status = 'Error' +  ' - ' + errorCode0;
                    response.errorMessage = 'HTTP Error: ' + res.getStatusCode() + ' - ' + errorMessageJSON0;
                }else {
                    Map<String, Object> exceptionJSON =(Map<String, Object>) body.get('exception');
                    String errorCode1 = (String) exceptionJSON.get('code');
                    String errorMessageJSON1 = (String) exceptionJSON.get('message'); 
                    response.status = 'Error' +  ' - ' + errorCode1;
                    response.errorMessage = 'HTTP Error: ' + res.getStatusCode() + ' - ' + errorMessageJSON1;   
                }
            }
        } catch (Exception e) {
            response.status = 'Error';
            response.errorMessage = 'Exception: ' + e.getMessage();
        }
        return response;
    }
    // Build header
    public static Map<String, String> getDefaultHeaders() {
        Map<String, String> headers = new Map<String, String>();
        headers.put('Content-Type', 'application/json');
        headers.put('Accept', '*/*');
        return headers;
    }
    // Store Log
    public static List<AppLog__c> logList = new List<AppLog__c>();
    public static void logTransaction(IntegrationResponse response) {
        try {
            AppLog__c log = new AppLog__c();
            log.Entity__c = response.entity;
            log.Error_Message__c = response.errorMessage;
            log.Method__c = response.httpMethod;
            log.Policy_App__c = response.policyApp;
            log.Policy_No__c = response.policyNo;
            log.Request_Value__c = response.requestBody;
            log.Response_Payload__c = response.responseBody;
            log.Status__c = response.status;
            log.StartLongTime__c = response.startLongTime;
            log.EndLongTime__c = response.endLongTime;
            log.Log_Case__c = response.caseId;
            log.id__c = response.contactSFID;
            // log.Report_Name__c = UserInfo.getUserType();
            logList.add(log);
            
        } catch (Exception e) {
            System.debug('Error logging transaction: ' + e.getMessage());
            System.debug('Trace: ' + e.getStackTraceString());
        }
    }

    public static AMFS_Service_API__mdt getIntegrationSettings(String developerName) {
        try {
            List<AMFS_Service_API__mdt> settings = [SELECT Endpoint__c, Timeout__c, Username__c, Password__c, Method__c FROM AMFS_Service_API__mdt WHERE DeveloperName = :developerName LIMIT 1];
            return settings[0];
        } catch (Exception e) {
            System.debug('Error retrieving integration settings: ' + e.getMessage());
            return null;
        }
    }

}