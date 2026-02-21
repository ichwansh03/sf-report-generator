/**
 * @description Handles authenticated HTTP callouts to the Salesforce Analytics REST API.
 * Uses Named Credentials for secure authentication and retry logic for transient failures.
 */
public class ReportApiClient {
    
    private static final String API_BASE_PATH = '/services/data/v62.0/analytics/reports/';
    private static final String NAMED_CREDENTIAL = 'callout:AnalyticsAPI';
    private static final Integer MAX_RETRIES = 3;
    private static final Integer TIMEOUT_MS = 30000;
    
    /**
     * @description Fetches report metadata from the Analytics API
     * @param reportId The ID of the report to fetch
     * @return The parsed report metadata as a Map
     * @throws ReportToSoqlException on API errors
     */
    public static Map<String, Object> fetchReportMetadata(Id reportId) {
        if (reportId == null) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.VALIDATION_ERROR,
                'Report ID cannot be null'
            );
        }
        
        String endpoint = NAMED_CREDENTIAL + API_BASE_PATH + reportId + '/describe';
        
        try {
            HttpResponse response = executeRequestWithRetry(endpoint);
            
            if (response.getStatusCode() == 401) {
                throw new ReportToSoqlException(
                    ReportToSoqlException.ExceptionType.SECURITY_ERROR,
                    'Unauthorized: Invalid Named Credential or permissions insufficient to access report',
                    endpoint,
                    reportId
                );
            }
            
            if (response.getStatusCode() == 404) {
                throw new ReportToSoqlException(
                    ReportToSoqlException.ExceptionType.VALIDATION_ERROR,
                    'Report not found with ID: ' + reportId,
                    endpoint,
                    reportId
                );
            }
            
            if (response.getStatusCode() != 200) {
                throw new ReportToSoqlException(
                    ReportToSoqlException.ExceptionType.API_ERROR,
                    'API returned status ' + response.getStatusCode() + ': ' + response.getBody(),
                    endpoint,
                    reportId
                );
            }
            
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            system.debug('API Response - Full structure: ' + JSON.serializePretty(responseMap));
            
            // Log the key fields to help debug baseObject extraction
            if (responseMap.containsKey('reportMetadata')) {
                Map<String, Object> metadata = (Map<String, Object>) responseMap.get('reportMetadata');
                system.debug('API Response - reportMetadata keys: ' + metadata.keySet());
                system.debug('API Response - reportType: ' + metadata.get('reportType'));
                system.debug('API Response - baseObject: ' + metadata.get('baseObject'));
                system.debug('API Response - sobjectType: ' + metadata.get('sobjectType'));
                system.debug('API Response - detailColumns: ' + metadata.get('detailColumns'));
            }
            
            // Log reportTypeMetadata structure
            if (responseMap.containsKey('reportTypeMetadata')) {
                Map<String, Object> typeMetadata = (Map<String, Object>) responseMap.get('reportTypeMetadata');
                system.debug('API Response - reportTypeMetadata keys: ' + typeMetadata.keySet());
                system.debug('API Response - reportTypeMetadata.objects: ' + JSON.serializePretty(typeMetadata.get('objects')));
                if (typeMetadata.containsKey('objectRelations')) {
                    system.debug('API Response - reportTypeMetadata.objectRelations: ' + JSON.serializePretty(typeMetadata.get('objectRelations')));
                }
            }
            
            return responseMap;
            
        } catch (ReportToSoqlException e) {
            throw e;
        } catch (Exception e) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.API_ERROR,
                'HTTP callout failed: ' + e.getMessage(),
                endpoint,
                reportId
            );
        }
    }
    
    /**
     * @description Executes HTTP request with retry logic for transient failures
     * @param endpoint The endpoint URL
     * @return The HTTP response
     */
    private static HttpResponse executeRequestWithRetry(String endpoint) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        req.setTimeout(TIMEOUT_MS);
        req.setHeader('Authorization', 'Bearer 00DfV000000z9pe!AQEAQOsydI6KJduLQSZ.Hmfy.TKFyaeVAZORB5x7TMCdpAG0pKEydKW1_kOcuhDKzItDXMpwfpppBupS4lgwQKa3tk9YB4TP');
        HttpResponse response;
        Exception lastException;
        
        for (Integer i = 0; i < MAX_RETRIES; i++) {
            try {
                response = new Http().send(req);
                system.debug('response: '+response.getBody());
                system.debug('status code: '+response.getStatusCode());
                // Retry on transient failures (5xx errors)
                if (response.getStatusCode() >= 500 && response.getStatusCode() < 600 && i < MAX_RETRIES - 1) {
                    Integer backoffMs = (Integer) Math.pow(2, i) * 100;
                    wait(backoffMs);
                    continue;
                }
                
                return response;
                
            } catch (Exception e) {
                lastException = e;
                if (i < MAX_RETRIES - 1) {
                    Integer backoffMs = (Integer) Math.pow(2, i) * 100;
                    wait(backoffMs);
                }
            }
        }
        
        throw lastException != null ? lastException : 
            new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.API_ERROR,
                'Failed to execute API request after ' + MAX_RETRIES + ' retries'
            );
    }
    
    /**
     * @description Helper method to wait (simulates exponential backoff)
     * Note: In production, consider using Queueable for async retry pattern
     */
    private static void wait(Integer milliseconds) {
        Long startTime = System.now().getTime();
        while (System.now().getTime() - startTime < milliseconds) {
            // Busy wait (not ideal, but simplest approach for synchronous callouts)
        }
    }
}