/**
 * @description Main service for converting Salesforce Reports to dynamic SOQL queries.
 * 
 * This production-ready service:
 * - Calls the Analytics REST API to fetch report metadata
 * - Parses and validates the report structure
 * - Converts report filters to SOQL WHERE clauses
 * - Validates field and object access
 * - Enforces sharing rules
 * - Generates a fully executable SOQL query
 * 
 * @example
 * String reportId = '00O1X000000IZkUAW';
 * try {
 *     String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
 *     List<SObject> results = Database.query(soqlQuery);
 * } catch (ReportToSoqlException e) {
 *     System.debug('Error: ' + e.getFullErrorMessage());
 * }
 */
public with sharing class ReportToSoqlConverter {
    
    private static final String LOG_PREFIX = '[ReportToSoqlConverter] ';
    
    /**
     * @description Main entry point - generates SOQL from a Salesforce Report
     * @param reportId The ID of the report to convert
     * @return A fully executable SOQL query string
     * @throws ReportToSoqlException on any error during conversion
     */
    public static String generateSoqlFromReport(Id reportId) {
        Long startTime = System.now().getTime();
        
        try {
            if (reportId == null) {
                throw new ReportToSoqlException(
                    ReportToSoqlException.ExceptionType.VALIDATION_ERROR,
                    'Report ID cannot be null'
                );
            }
            
            logInfo('Starting report to SOQL conversion for report: ' + reportId);
            
            // Step 1: Fetch report metadata from Analytics API
            logInfo('Fetching report metadata from Analytics API');
            Map<String, Object> apiResponse = ReportApiClient.fetchReportMetadata(reportId);
            
            // Step 2: Parse the response
            logInfo('Parsing report metadata');
            ReportMetadataParser.ReportData reportData = 
                ReportMetadataParser.parseReportResponse(apiResponse, reportId);
            
            // Step 3: Validate security context
            logInfo('Validating security context for object: ' + reportData.baseObject);
            SecurityEnforcer.validateSecurityContext(
                reportData.baseObject,
                reportData.detailColumns,
                reportId
            );
            
            // Step 4: Build SOQL query
            logInfo('Building SOQL query');
            String soqlQuery = SoqlQueryBuilder.buildSoqlQuery(reportData, reportId);
            
            // Step 5: Validate the generated query
            logInfo('Validating generated SOQL query');
            validateQuery(soqlQuery);
            
            // Step 6: Final security check
            if (!SecurityEnforcer.validateQueryExecution(soqlQuery)) {
                throw new ReportToSoqlException(
                    ReportToSoqlException.ExceptionType.SECURITY_ERROR,
                    'Generated query failed security validation',
                    soqlQuery
                );
            }
            
            Long duration = System.now().getTime() - startTime;
            logInfo('Report to SOQL conversion completed successfully in ' + duration + 'ms');
            SecurityEnforcer.logSecurityEvent('REPORT_CONVERTED', reportData.baseObject, 
                'ReportId: ' + reportId + ' | Duration: ' + duration + 'ms');
            
            return soqlQuery;
            
        } catch (ReportToSoqlException e) {
            logError('ReportToSoqlException: ' + e.getFullErrorMessage());
            SecurityEnforcer.logSecurityEvent('REPORT_CONVERSION_FAILED', 'Unknown',
                'ReportId: ' + reportId + ' | Error: ' + e.getFullErrorMessage());
            throw e;
        } catch (Exception e) {
            String errorMsg = 'Unexpected error during report conversion: ' + e.getMessage() + 
                              '\n' + e.getStackTraceString();
            logError(errorMsg);
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.SOQL_GENERATION_ERROR,
                'Unexpected error: ' + e.getMessage(),
                e.getStackTraceString(),
                reportId
            );
        }
    }
    
    /**
     * @description Validates the generated SOQL query for common issues
     */
    private static void validateQuery(String soqlQuery) {
        if (String.isBlank(soqlQuery)) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.SOQL_GENERATION_ERROR,
                'Generated SOQL query is empty'
            );
        }
        
        String upperQuery = soqlQuery.toUpperCase();
        
        // Validate basic structure
        if (!upperQuery.startsWith('SELECT')) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.SOQL_GENERATION_ERROR,
                'Generated query does not start with SELECT'
            );
        }
        
        if (!upperQuery.contains('FROM')) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.SOQL_GENERATION_ERROR,
                'Generated query is missing FROM clause'
            );
        }
        
        // Check for suspicious patterns
        if (upperQuery.contains('INSERT') || 
            upperQuery.contains('UPDATE') || 
            upperQuery.contains('DELETE') ||
            upperQuery.contains('UPSERT')) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.SOQL_GENERATION_ERROR,
                'Generated query contains invalid DML operations',
                soqlQuery
            );
        }
    }
    
    /**
     * @description Helper method for logging information
     */
    private static void logInfo(String message) {
        System.debug(LoggingLevel.INFO, LOG_PREFIX + message);
    }
    
    /**
     * @description Helper method for logging errors
     */
    private static void logError(String message) {
        System.debug(LoggingLevel.ERROR, LOG_PREFIX + message);
    }
    
    /**
     * @description Utility method to safely execute a generated SOQL query
     * This is a convenience method for common use cases
     * 
     * @param reportId The report ID to convert and query
     * @return List of SObjects matching the report criteria
     * @throws ReportToSoqlException on any error
     */
    public static List<SObject> queryFromReport(Id reportId) {
        String soqlQuery = generateSoqlFromReport(reportId);
        
        try {
            return Database.query(soqlQuery);
        } catch (QueryException e) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.SOQL_GENERATION_ERROR,
                'Query execution failed: ' + e.getMessage(),
                soqlQuery,
                reportId
            );
        }
    }
    
    /**
     * @description Utility method to safely execute a generated SOQL query with pagination
     * 
     * @param reportId The report ID to convert and query
     * @param pageSize The number of records per page
     * @return QueryLocator for use with Database.getQueryLocator in batch jobs
     * @throws ReportToSoqlException on conversion errors (not execution errors)
     */
    public static Database.QueryLocator queryLocatorFromReport(Id reportId, Integer pageSize) {
        String soqlQuery = generateSoqlFromReport(reportId);
        
        if (pageSize > 0) {
            soqlQuery += ' LIMIT ' + pageSize;
        }
        
        try {
            return Database.getQueryLocator(soqlQuery);
        } catch (QueryException e) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.SOQL_GENERATION_ERROR,
                'QueryLocator creation failed: ' + e.getMessage(),
                soqlQuery,
                reportId
            );
        }
    }
}
