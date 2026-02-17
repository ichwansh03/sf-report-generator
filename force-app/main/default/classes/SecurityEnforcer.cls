/**
 * @description Enforces security policies: object-level access, field-level security, and sharing rules.
 * Uses "with sharing" principle to respect organization's sharing rules.
 */
public with sharing class SecurityEnforcer {
    
    /**
     * @description Validates comprehensive security for SOQL query generation
     * @param objectName The SObject API name
     * @param fieldNames The field API names
     * @param reportId The report ID (for error context)
     * @throws ReportToSoqlException on security violations
     */
    public static void validateSecurityContext(String objectName, List<String> fieldNames, Id reportId) {
        // Validate object-level read access
        validateObjectReadAccess(objectName, reportId);
        
        // Validate field-level read access for each field
        if (fieldNames != null && !fieldNames.isEmpty()) {
            validateFieldReadAccess(objectName, fieldNames, reportId);
        }
    }
    
    /**
     * @description Validates object-level read access
     */
    private static void validateObjectReadAccess(String objectName, Id reportId) {
        try {
            SchemaValidator.validateObjectAccess(objectName);
        } catch (ReportToSoqlException e) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.INSUFFICIENT_PERMISSIONS,
                'Insufficient permissions to query object: ' + objectName,
                objectName,
                reportId
            );
        }
    }
    
    /**
     * @description Validates field-level read access for multiple fields
     */
    private static void validateFieldReadAccess(String objectName, List<String> fieldNames, Id reportId) {
        List<String> inaccessibleFields = new List<String>();
        
        for (String fieldName : fieldNames) {
            try {
                SchemaValidator.validateField(objectName, fieldName);
            } catch (ReportToSoqlException e) {
                inaccessibleFields.add(fieldName);
            }
        }
        
        if (!inaccessibleFields.isEmpty()) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.INSUFFICIENT_PERMISSIONS,
                'Insufficient field-level read access: ' + String.join(inaccessibleFields, ', '),
                String.join(inaccessibleFields, ', '),
                reportId
            );
        }
    }
    
    /**
     * @description Validates that the current user can execute a SOQL query
     * This method respects the organization's sharing rules through "with sharing" declaration
     * @param soqlQuery The SOQL query to validate
     * @return true if the current user should be able to execute the query
     */
    public static Boolean validateQueryExecution(String soqlQuery) {
        try {
            // Validate that query doesn't contain dangerous patterns
            String upperQuery = soqlQuery.toUpperCase();
            
            // Check for injection attempts
            if (upperQuery.contains('INSERT') || 
                upperQuery.contains('UPDATE') || 
                upperQuery.contains('DELETE') || 
                upperQuery.contains('UPSERT') ||
                upperQuery.contains('MERGE')) {
                return false;
            }
            
            // Check that it's a valid SELECT query
            if (!upperQuery.startsWith('SELECT')) {
                return false;
            }
            
            return true;
            
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Query validation error: ' + e.getMessage());
            return false;
        }
    }
    
    /**
     * @description Logs security-relevant events for audit purposes
     */
    public static void logSecurityEvent(String eventType, String objectName, String details) {
        try {
            System.debug(
                LoggingLevel.INFO,
                'SecurityEvent: ' + eventType + ' | Object: ' + objectName + ' | Details: ' + details + ' | User: ' + UserInfo.getUserId()
            );
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Failed to log security event: ' + e.getMessage());
        }
    }
}
