/**
 * @description Real-world example implementations of the ReportToSoqlConverter service
 * These examples demonstrate common use cases and best practices
 */

/**
 * Example 1: Simple Report Conversion in Apex
 * Convert a single report to SOQL and execute
 */
public class Example1_SimpleConversion {
    
    public static void convertAndQueryAccountReport() {
        String reportId = '00O1X000000IZkUAW';
        
        try {
            // Step 1: Generate SOQL from report
            String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
            
            System.debug('Generated SOQL: ' + soqlQuery);
            // Output: SELECT Id, Name, Phone, Industry FROM Account 
            //         WHERE BillingCountry = 'USA' AND AnnualRevenue > 1000000
            
            // Step 2: Execute the query
            List<Account> activeAccounts = Database.query(soqlQuery);
            
            // Step 3: Process results
            System.debug('Found ' + activeAccounts.size() + ' accounts');
            for (Account acc : activeAccounts) {
                System.debug('Account: ' + acc.Name + ' | Industry: ' + acc.Industry);
            }
            
        } catch (ReportToSoqlException e) {
            System.debug('Conversion Error: ' + e.getFullErrorMessage());
            // Implement error handling/logging
        }
    }
}

/**
 * Example 2: Batch Processing with QueryLocator
 * Process large result sets efficiently
 */
public class Example2_BatchProcessing implements Database.Batchable<SObject> {
    
    private Id reportId;
    
    public Example2_BatchProcessing(Id reportId) {
        this.reportId = reportId;
    }
    
    public Database.QueryLocator start(Database.BatchableContext context) {
        // Convert report to SOQL and get QueryLocator for batch processing
        return ReportToSoqlConverter.queryLocatorFromReport(reportId, 10000);
    }
    
    public void execute(Database.BatchableContext context, List<SObject> scope) {
        // Process each batch of records
        List<Account> accounts = (List<Account>) scope;
        
        for (Account acc : accounts) {
            // Example: Update owner based on region
            if (acc.BillingCountry == 'USA') {
                acc.OwnerId = getUSAQueueId();
            } else if (acc.BillingCountry == 'USA') {
                acc.OwnerId = getEmEAQueueId();
            }
        }
        
        // Batch update
        update accounts;
        
        System.debug('Processed ' + scope.size() + ' records');
    }
    
    public void finish(Database.BatchableContext context) {
        System.debug('Batch job completed: ' + context.getJobId());
        // Send completion email, log results, etc.
    }
    
    private String getUSAQueueId() {
        // Get queue ID for USA region
        return [SELECT Id FROM Group WHERE Name = 'USA Sales Queue' LIMIT 1].Id;
    }
    
    private String getEmEAQueueId() {
        // Get queue ID for EMEA region
        return [SELECT Id FROM Group WHERE Name = 'EMEA Sales Queue' LIMIT 1].Id;
    }
    
    // Schedule this job
    public static void scheduleReportBatch() {
        String reportId = '00O1X000000IZkUAW';
        String cronExpression = '0 0 2 * * ?'; // Daily at 2 AM
        
        System.schedule('Daily Report Processing', cronExpression, 
            new ScheduleReportBatch(reportId));
    }
}

/**
 * Example 3: Schedulable Job
 * Run report conversion on a schedule
 */
public class Example3_ScheduledJob implements Schedulable {
    
    public void execute(SchedulableContext context) {
        String reportId = '00O1X000000IZkUAW';
        
        try {
            Database.executeBatch(new Example2_BatchProcessing(reportId), 200);
        } catch (Exception e) {
            System.debug('Scheduled job error: ' + e.getMessage());
            sendErrorNotification(e);
        }
    }
    
    private void sendErrorNotification(Exception e) {
        // Send email to admins on failure
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { 'admin@example.com' });
        mail.setSubject('Report to SOQL Conversion Job Failed');
        mail.setPlainTextBody('Error: ' + e.getMessage() + '\n\nStack: ' + e.getStackTraceString());
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}

/**
 * Scheduling utility
 */
public class ScheduleReportBatch implements Schedulable {
    private Id reportId;
    
    public ScheduleReportBatch(Id reportId) {
        this.reportId = reportId;
    }
    
    public void execute(SchedulableContext context) {
        Database.executeBatch(new Example2_BatchProcessing(reportId), 200);
    }
}

/**
 * Example 4: REST API Endpoint
 * Expose report conversion as a REST service
 */
@RestResource(urlMapping='/api/v1/reports/convert/*')
public class Example4_ReportConvertService {
    
    @HttpGet
    global static void convertReport() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        try {
            // Get report ID from query parameter or URL
            String reportId = req.getParameter('reportId');
            
            if (String.isBlank(reportId)) {
                res.statusCode = 400;
                res.responseBody = Blob.valueOf(JSON.serialize(new Map<String, Object> {
                    'success' => false,
                    'error' => 'reportId query parameter is required'
                }));
                return;
            }
            
            // Convert report to SOQL
            String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
            
            // Return success response
            res.statusCode = 200;
            res.responseBody = Blob.valueOf(JSON.serialize(new Map<String, Object> {
                'success' => true,
                'reportId' => reportId,
                'soqlQuery' => soqlQuery,
                'timestamp' => DateTime.now().getTime()
            }));
            
        } catch (ReportToSoqlException e) {
            res.statusCode = 400;
            res.responseBody = Blob.valueOf(JSON.serialize(new Map<String, Object> {
                'success' => false,
                'error' => e.getMessage(),
                'type' => String.valueOf(e.exceptionType),
                'context' => e.context
            }));
        } catch (Exception e) {
            res.statusCode = 500;
            res.responseBody = Blob.valueOf(JSON.serialize(new Map<String, Object> {
                'success' => false,
                'error' => 'Unexpected error: ' + e.getMessage()
            }));
        }
    }
    
    // Usage:
    // GET /services/apexrest/api/v1/reports/convert?reportId=00O1X000000IZkUAW
}

/**
 * Example 5: Lightning Controller
 * Expose functionality to Lightning Web Components
 */
public with sharing class Example5_ReportConvertController {
    
    @AuraEnabled
    public static String convertReport(String reportId) {
        try {
            return ReportToSoqlConverter.generateSoqlFromReport(reportId);
        } catch (ReportToSoqlException e) {
            throw new AuraHandledException(e.getFullErrorMessage());
        }
    }
    
    @AuraEnabled
    public static List<Map<String, Object>> executeReportQuery(String reportId) {
        try {
            List<SObject> results = ReportToSoqlConverter.queryFromReport(reportId);
            
            List<Map<String, Object>> data = new List<Map<String, Object>>();
            for (SObject record : results) {
                data.add(record.getPopulatedFieldsAsMap());
            }
            
            return data;
            
        } catch (ReportToSoqlException e) {
            throw new AuraHandledException(e.getFullErrorMessage());
        }
    }
}

/**
 * Example 6: Caching Implementation
 * Cache SOQL queries to improve performance
 */
public class Example6_CachedReportConverter {
    
    private static final Integer CACHE_DURATION_HOURS = 24;
    private static Map<String, CachedQuery> queryCache = new Map<String, CachedQuery>();
    
    public class CachedQuery {
        public String soqlQuery { get; set; }
        public DateTime cachedTime { get; set; }
    }
    
    public static String generateSoqlWithCache(Id reportId) {
        String cacheKey = reportId.to15();
        
        // Check if cached and still valid
        if (queryCache.containsKey(cacheKey)) {
            CachedQuery cached = queryCache.get(cacheKey);
            DateTime expiryTime = cached.cachedTime.addHours(CACHE_DURATION_HOURS);
            
            if (DateTime.now() < expiryTime) {
                System.debug('Returning cached SOQL for report: ' + reportId);
                return cached.soqlQuery;
            }
        }
        
        // Generate and cache
        String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
        
        CachedQuery cached = new CachedQuery();
        cached.soqlQuery = soqlQuery;
        cached.cachedTime = DateTime.now();
        
        queryCache.put(cacheKey, cached);
        
        return soqlQuery;
    }
    
    public static void clearCache(Id reportId) {
        queryCache.remove(reportId.to15());
    }
    
    public static void clearAllCache() {
        queryCache.clear();
    }
}

/**
 * Example 7: Error Handling & Retry Logic
 * Handle transient failures with retry logic
 */
public class Example7_RobustConversion {
    
    private static final Integer MAX_RETRIES = 3;
    private static final Integer RETRY_DELAY_MS = 1000;
    
    public static String convertWithRetry(Id reportId) {
        for (Integer i = 0; i < MAX_RETRIES; i++) {
            try {
                return ReportToSoqlConverter.generateSoqlFromReport(reportId);
                
            } catch (ReportToSoqlException e) {
                // Log the attempt
                System.debug('Conversion attempt ' + (i + 1) + ' failed: ' + e.getMessage());
                
                // Don't retry if it's a permanent error
                if (isPermanentError(e.exceptionType)) {
                    throw e;
                }
                
                // Retry with exponential backoff
                if (i < MAX_RETRIES - 1) {
                    Long delayMs = (Long) (RETRY_DELAY_MS * Math.pow(2, i));
                    wait(delayMs);
                }
            }
        }
        
        throw new ReportToSoqlException(
            ReportToSoqlException.ExceptionType.API_ERROR,
            'Failed after ' + MAX_RETRIES + ' attempts',
            'convertWithRetry',
            reportId
        );
    }
    
    private static Boolean isPermanentError(ReportToSoqlException.ExceptionType type) {
        return type == ReportToSoqlException.ExceptionType.UNSUPPORTED_REPORT_TYPE ||
               type == ReportToSoqlException.ExceptionType.SECURITY_ERROR ||
               type == ReportToSoqlException.ExceptionType.INSUFFICIENT_PERMISSIONS;
    }
    
    private static void wait(Long milliseconds) {
        Long startTime = System.now().getTime();
        while (System.now().getTime() - startTime < milliseconds) {
            // Busy wait
        }
    }
}

/**
 * Example 8: Data Export Utility
 * Use reports to export data in different formats
 */
public class Example8_DataExport {
    
    public static String exportReport(Id reportId, String format) {
        String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
        List<SObject> records = Database.query(soqlQuery);
        
        switch on format.toLowerCase() {
            when 'json' {
                return JSON.serialize(records);
            }
            when 'csv' {
                return convertToCSV(records);
            }
            when 'xml' {
                return convertToXML(records);
            }
            when else {
                throw new ReportToSoqlException(
                    ReportToSoqlException.ExceptionType.VALIDATION_ERROR,
                    'Unsupported format: ' + format
                );
            }
        }
    }
    
    private static String convertToCSV(List<SObject> records) {
        // Implementation would convert records to CSV format
        return 'CSV export not implemented in this example';
    }
    
    private static String convertToXML(List<SObject> records) {
        // Implementation would convert records to XML format
        return 'XML export not implemented in this example';
    }
}

/**
 * Example 9: Validation & Quality Checks
 * Validate generated queries before execution
 */
public class Example9_QueryValidation {
    
    public static void validateAndExecute(Id reportId) {
        try {
            String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
            
            // Validate query
            validateQuery(soqlQuery);
            
            // Execute
            List<SObject> results = Database.query(soqlQuery);
            System.debug('Successfully executed query, returned ' + results.size() + ' records');
            
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
        }
    }
    
    private static void validateQuery(String soqlQuery) {
        // Check for suspicious patterns
        String upper = soqlQuery.toUpperCase();
        
        if (upper.contains(';') || upper.contains('--') || upper.contains('/*')) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.SOQL_GENERATION_ERROR,
                'Query contains suspicious characters'
            );
        }
        
        // Check query length
        if (soqlQuery.length() > 20000) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.SOQL_GENERATION_ERROR,
                'Query exceeds maximum length of 20000 characters'
            );
        }
        
        System.debug('Query validation passed');
    }
}

/**
 * Example 10: Monitoring & Metrics
 * Track usage and performance metrics
 */
public class Example10_MetricsTracking {
    
    public class ConversionMetrics {
        public long conversionTimeMs;
        public long queryExecutionTimeMs;
        public integer recordsReturned;
        public String reportId;
        public DateTime timestamp;
    }
    
    public static ConversionMetrics trackConversion(Id reportId) {
        ConversionMetrics metrics = new ConversionMetrics();
        metrics.reportId = reportId;
        metrics.timestamp = DateTime.now();
        
        // Track conversion time
        Long startTime = System.now().getTime();
        String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
        metrics.conversionTimeMs = System.now().getTime() - startTime;
        
        // Track query execution time
        startTime = System.now().getTime();
        List<SObject> results = Database.query(soqlQuery);
        metrics.queryExecutionTimeMs = System.now().getTime() - startTime;
        metrics.recordsReturned = results.size();
        
        // Log metrics
        logMetrics(metrics);
        
        return metrics;
    }
    
    private static void logMetrics(ConversionMetrics metrics) {
        System.debug('Metrics: ' + JSON.serialize(metrics));
        // Could also store in custom object for analytics
    }
}
