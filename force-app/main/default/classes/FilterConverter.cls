/**
 * @description Converts report filters to SOQL WHERE clause conditions.
 * Handles operator mapping, relative dates, multi-select picklists, and injection prevention.
 */
public class FilterConverter {
    
    /**
     * @description Represents a converted filter condition
     */
    public class FilterCondition {
        public Integer filterId { get; set; }
        public String soqlCondition { get; set; }
    }
    
    private static final Map<String, String> OPERATOR_MAP = new Map<String, String> {
        'equals' => '=',
        'not_equal' => '!=',
        'lt' => '<',
        'lte' => '<=',
        'gt' => '>',
        'gte' => '>=',
        'contains' => 'LIKE',
        'not_contains' => 'NOT LIKE',
        'starts_with' => 'LIKE',
        'ends_with' => 'LIKE',
        'in' => 'IN',
        'not_in' => 'NOT IN',
        'includes' => 'INCLUDES',
        'excludes' => 'EXCLUDES'
    };
    
    /**
     * @description Converts a single report filter to a SOQL condition
     * @param filter The filter object from reportMetadata.reportFilters
     * @param baseObject The base object name
     * @param reportId The report ID (for error context)
     * @return The converted filter condition
     * @throws ReportToSoqlException on conversion errors
     */
    public static FilterCondition convertFilter(
        Map<String, Object> filter,
        String baseObject,
        Id reportId
    ) {
        try {
            if (filter == null || filter.isEmpty()) {
                throw new ReportToSoqlException(
                    ReportToSoqlException.ExceptionType.FILTER_ERROR,
                    'Filter object is null or empty',
                    'convertFilter',
                    reportId
                );
            }
            
            FilterCondition condition = new FilterCondition();
            
            // Extract filter ID
            Object filterIdObj = filter.get('id');
            if (filterIdObj instanceof Integer) {
                condition.filterId = (Integer) filterIdObj;
            } else if (filterIdObj instanceof String) {
                condition.filterId = Integer.valueOf((String) filterIdObj);
            }
            
            // Extract field, operator, and value
            String fieldName = (String) filter.get('column');
            String operator = (String) filter.get('operator');
            Object value = filter.get('value');
            
            if (String.isBlank(fieldName) || String.isBlank(operator)) {
                throw new ReportToSoqlException(
                    ReportToSoqlException.ExceptionType.FILTER_ERROR,
                    'Filter missing required field or operator',
                    String.valueOf(filter),
                    reportId
                );
            }
            
            // Convert the field reference to handle relationships
            String soqlField = convertFieldReference(fieldName, baseObject);
            
            // Convert operator
            String soqlOperator = convertOperator(operator);
            
            // Convert value, handling special cases like relative dates
            String soqlValue = convertValue(value, operator, filter.get('type'));
            
            // Build the condition
            condition.soqlCondition = buildCondition(soqlField, soqlOperator, soqlValue, operator);
            
            return condition;
            
        } catch (ReportToSoqlException e) {
            throw e;
        } catch (Exception e) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.FILTER_ERROR,
                'Failed to convert filter: ' + e.getMessage(),
                String.valueOf(filter),
                reportId
            );
        }
    }
    
    /**
     * @description Converts a report field reference to SOQL field notation
     * Handles relationship traversal (e.g., Account.Owner__r.Email)
     */
    private static String convertFieldReference(String fieldName, String baseObject) {
        if (String.isBlank(fieldName)) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.VALIDATION_ERROR,
                'Field name cannot be blank'
            );
        }
        
        // Already in correct format, just return it
        return fieldName;
    }
    
    /**
     * @description Converts report filter operator to SOQL operator
     */
    private static String convertOperator(String reportOperator) {
        if (String.isBlank(reportOperator)) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.FILTER_ERROR,
                'Report operator cannot be blank'
            );
        }
        
        String operatorLower = reportOperator.toLowerCase();
        if (!OPERATOR_MAP.containsKey(operatorLower)) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.FILTER_ERROR,
                'Unknown report operator: ' + reportOperator
            );
        }
        
        return OPERATOR_MAP.get(operatorLower);
    }
    
    /**
     * @description Converts filter value, handling special types like relative dates
     * and multi-select picklists. Prevents SOQL injection.
     */
    private static String convertValue(Object value, String operator, Object typeObj) {
        if (value == null) {
            return 'null';
        }
        
        String valueStr = String.valueOf(value);
        String operatorLower = String.valueOf(operator).toLowerCase();
        String typeStr = String.valueOf(typeObj).toLowerCase();
        
        // Handle relative date literals
        if (typeStr.contains('date') && isRelativeDateLiteral(valueStr)) {
            return convertRelativeDateLiteral(valueStr);
        }
        
        // Handle multi-select picklists (INCLUDES/EXCLUDES operators)
        if (operatorLower == 'includes' || operatorLower == 'excludes') {
            return handleMultiSelectPicklist(valueStr);
        }
        
        // Handle IN/NOT IN operators with multiple values
        if (operatorLower == 'in' || operatorLower == 'not_in') {
            return handleInOperator(valueStr);
        }
        
        // Regular string/number values - sanitize and quote if necessary
        return sanitizeAndQuoteValue(valueStr);
    }
    
    /**
     * @description Detects if a value is a relative date literal
     */
    private static Boolean isRelativeDateLiteral(String value) {
        return value.containsIgnoreCase('LAST_N_DAYS:') ||
               value.containsIgnoreCase('THIS_MONTH') ||
               value.containsIgnoreCase('THIS_QUARTER') ||
               value.containsIgnoreCase('THIS_YEAR') ||
               value.containsIgnoreCase('LAST_MONTH') ||
               value.containsIgnoreCase('LAST_90_DAYS') ||
               value.containsIgnoreCase('N_DAYS_AGO:') ||
               value.containsIgnoreCase('NEXT_N_DAYS:') ||
               value.containsIgnoreCase('FISCAL_');
    }
    
    /**
     * @description Converts a relative date literal to SOQL format
     */
    private static String convertRelativeDateLiteral(String value) {
        // Value might be in format like "LAST_N_DAYS:30"
        // In SOQL, it would be used as-is: WHERE CreatedDate >= LAST_N_DAYS:30
        String result = value.toUpperCase();
        
        // Validate absolute minimum safety
        if (result.containsIgnoreCase('UNION') || result.containsIgnoreCase('SELECT')) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.FILTER_ERROR,
                'Potential injection detected in date literal: ' + value
            );
        }
        
        return result;
    }
    
    /**
     * @description Handles multi-select picklist values for INCLUDES/EXCLUDES
     */
    private static String handleMultiSelectPicklist(String value) {
        // Value might be a semicolon-separated list like "Value1;Value2"
        List<String> values = value.split(';');
        List<String> sanitizedValues = new List<String>();
        
        for (String v : values) {
            sanitizedValues.add(sanitizeAndQuoteValue(v.trim()));
        }
        
        return '(' + String.join(sanitizedValues, ',') + ')';
    }
    
    /**
     * @description Handles IN and NOT IN operators with list of values
     */
    private static String handleInOperator(String value) {
        // Value might be comma or semicolon separated
        List<String> values = value.contains(';') ? 
            value.split(';') : 
            value.split(',');
        
        List<String> sanitizedValues = new List<String>();
        for (String v : values) {
            sanitizedValues.add(sanitizeAndQuoteValue(v.trim()));
        }
        
        return '(' + String.join(sanitizedValues, ',') + ')';
    }
    
    /**
     * @description Sanitizes values to prevent SOQL injection and applies proper quoting
     */
    private static String sanitizeAndQuoteValue(String value) {
        if (String.isBlank(value)) {
            return 'null';
        }
        
        // Basic injection prevention - reject suspicious patterns
        String upperValue = value.toUpperCase();
        if (upperValue.contains('UNION') || 
            upperValue.contains('SELECT') || 
            upperValue.contains('FROM') || 
            upperValue.contains('WHERE') ||
            upperValue.contains('INSERT') ||
            upperValue.contains('UPDATE') ||
            upperValue.contains('DELETE') ||
            upperValue.contains(';')) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.FILTER_ERROR,
                'Potential SOQL injection detected in filter value'
            );
        }
        
        // Check if it's a numeric value
        if (value.isNumeric()) {
            return value;
        }
        
        // Boolean values
        if (value.equalsIgnoreCase('true') || value.equalsIgnoreCase('false')) {
            return value;
        }
        
        // Date values in ISO format (YYYY-MM-DD)
        if (isIsoDate(value)) {
            return value;
        }
        
        // String values - escape single quotes and wrap in quotes
        return '\'' + value.replace('\'', '\\\'') + '\'';
    }
    
    /**
     * @description Checks if a value is a valid ISO date format
     */
    private static Boolean isIsoDate(String value) {
        if (String.isBlank(value) || value.length() < 10) {
            return false;
        }
        return value.matches('^\\d{4}-\\d{2}-\\d{2}$');
    }
    
    /**
     * @description Builds the complete condition string
     */
    private static String buildCondition(String field, String operator, String value, String originalOperator) {
        String condition;
        
        String operatorLower = originalOperator.toLowerCase();
        
        if (value == 'null') {
            if (operatorLower == 'equals' || operatorLower == 'not_equal' || 
                operatorLower == 'includes' || operatorLower == 'excludes') {
                condition = field + ' ' + operator + ' ' + value;
            } else {
                condition = field + ' IS ' + value;
            }
        } else if (operatorLower == 'starts_with') {
            condition = field + ' ' + operator + ' ' + value + '%\'';
        } else if (operatorLower == 'ends_with') {
            condition = field + ' ' + operator + ' \'%' + value;
        } else if (operatorLower == 'contains' || operatorLower == 'not_contains') {
            condition = field + ' ' + operator + ' \'%' + value + '%\'';
        } else {
            condition = field + ' ' + operator + ' ' + value;
        }
        
        return condition;
    }
}
