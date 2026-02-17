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
        
        String endpoint = NAMED_CREDENTIAL + API_BASE_PATH + reportId + '?includeDetails=true';
        
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
            
            return (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            
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
        
        HttpResponse response;
        Exception lastException;
        
        for (Integer i = 0; i < MAX_RETRIES; i++) {
            try {
                response = new Http().send(req);
                
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
