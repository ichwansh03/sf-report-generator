/**
 * @description Constructs a complete SOQL query from report metadata.
 * Handles SELECT, FROM, WHERE clauses and logical grouping based on reportBooleanFilter.
 */
public class SoqlQueryBuilder {
    
    private String selectClause;
    private String fromClause;
    private List<String> whereConditions = new List<String>();
    private String booleanFilter;
    private String baseObject;
    
    /**
     * @description Builds a SOQL query from report metadata
     * @param reportData The parsed report data
     * @return The constructed SOQL query string
     * @throws ReportToSoqlException on query construction errors
     */
    public static String buildSoqlQuery(ReportMetadataParser.ReportData reportData, Id reportId) {
        try {
            if (reportData == null) {
                throw new ReportToSoqlException(
                    ReportToSoqlException.ExceptionType.SOQL_GENERATION_ERROR,
                    'Report data cannot be null',
                    'buildSoqlQuery',
                    reportId
                );
            }
            
            SoqlQueryBuilder builder = new SoqlQueryBuilder();
            builder.baseObject = reportData.baseObject;
            
            if (String.isBlank(builder.baseObject)) {
                throw new ReportToSoqlException(
                    ReportToSoqlException.ExceptionType.VALIDATION_ERROR,
                    'Cannot determine base object from report',
                    reportData.reportType,
                    reportId
                );
            }
            
            // Build SELECT clause
            builder.buildSelectClause(reportData.detailColumns);
            
            // Build FROM clause
            builder.buildFromClause(builder.baseObject);
            
            // Build WHERE clause(s) from filters
            builder.buildWhereClause(reportData.reportFilters, builder.baseObject, reportId);
            
            // Store boolean filter for logical grouping
            builder.booleanFilter = reportData.reportBooleanFilter;
            
            // Construct the final query
            return builder.constructQuery();
            
        } catch (ReportToSoqlException e) {
            throw e;
        } catch (Exception e) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.SOQL_GENERATION_ERROR,
                'Error building SOQL query: ' + e.getMessage(),
                'buildSoqlQuery',
                reportId
            );
        }
    }
    
    /**
     * @description Builds the SELECT clause from report columns
     */
    private void buildSelectClause(List<String> detailColumns) {
        if (detailColumns == null || detailColumns.isEmpty()) {
            // Default to all fields if no columns specified
            selectClause = 'SELECT Id';
        } else {
            // Validate and filter columns
            Map<String, SchemaValidator.FieldDefinition> validFields = 
                SchemaValidator.validateMultipleFields(baseObject, detailColumns);
            
            List<String> selectFields = new List<String>();
            selectFields.add('Id'); // Always include Id
            
            for (String column : detailColumns) {
                if (validFields.containsKey(column)) {
                    selectFields.add(column);
                }
            }
            
            selectClause = 'SELECT ' + String.join(selectFields, ', ');
        }
    }
    
    /**
     * @description Builds the FROM clause
     */
    private void buildFromClause(String objectName) {
        if (String.isBlank(objectName)) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.VALIDATION_ERROR,
                'Object name cannot be blank for FROM clause'
            );
        }
        
        fromClause = 'FROM ' + objectName;
    }
    
    /**
     * @description Builds the WHERE clause from report filters
     */
    private void buildWhereClause(List<Map<String, Object>> reportFilters, String objectName, Id reportId) {
        if (reportFilters == null || reportFilters.isEmpty()) {
            // No filters, no WHERE clause needed
            return;
        }
        
        Map<Integer, String> filterConditions = new Map<Integer, String>();
        
        for (Map<String, Object> filter : reportFilters) {
            try {
                FilterConverter.FilterCondition condition = 
                    FilterConverter.convertFilter(filter, objectName, reportId);
                
                if (condition != null && String.isNotBlank(condition.soqlCondition)) {
                    filterConditions.put(condition.filterId, condition.soqlCondition);
                }
            } catch (ReportToSoqlException e) {
                System.debug(LoggingLevel.WARN, 'Filter conversion error: ' + e.getFullErrorMessage());
                // Continue processing other filters
            }
        }
        
        if (!filterConditions.isEmpty()) {
            // Apply boolean filter logic to group conditions
            String groupedCondition = applyBooleanFilter(filterConditions);
            if (String.isNotBlank(groupedCondition)) {
                whereConditions.add(groupedCondition);
            }
        }
    }
    
    /**
     * @description Applies logical grouping based on reportBooleanFilter
     * Example: booleanFilter "1 AND (2 OR 3)" with filters {1: "...", 2: "...", 3: "..."}
     */
    private String applyBooleanFilter(Map<Integer, String> filterConditions) {
        if (String.isBlank(booleanFilter)) {
            // No specific boolean filter, just AND all conditions
            return buildSimpleAndCondition(filterConditions);
        }
        
        try {
            // Parse and apply the boolean filter
            String result = booleanFilter;
            
            // Replace filter IDs with actual conditions while preserving logical operators and parentheses
            for (Integer filterId : filterConditions.keySet()) {
                String condition = filterConditions.get(filterId);
                // Wrap condition in parentheses if it contains OR at top level
                if (condition.containsIgnoreCase(' OR ')) {
                    condition = '(' + condition + ')';
                }
                result = result.replace(String.valueOf(filterId), '(' + condition + ')');
            }
            
            return result;
            
        } catch (Exception e) {
            System.debug(LoggingLevel.WARN, 'Error applying boolean filter: ' + e.getMessage());
            return buildSimpleAndCondition(filterConditions);
        }
    }
    
    /**
     * @description Builds a simple AND condition when no boolean filter is specified
     */
    private String buildSimpleAndCondition(Map<Integer, String> filterConditions) {
        if (filterConditions.isEmpty()) {
            return null;
        }
        
        List<String> conditions = new List<String>();
        for (Integer filterId : new List<Integer>(filterConditions.keySet())) {
            conditions.add(filterConditions.get(filterId));
        }
        
        return String.join(conditions, ' AND ');
    }
    
    /**
     * @description Constructs the complete SOQL query
     */
    private String constructQuery() {
        String query = selectClause; // e.g., "SELECT Id, Name, ..."
        query += ' ' + fromClause;   // e.g., "FROM Account"
        
        if (!whereConditions.isEmpty()) {
            query += ' WHERE ' + String.join(whereConditions, ' AND ');
        }
        
        // Add ORDER BY and LIMIT for safer execution
        // These can be customized as needed
        // query += ' ORDER BY Id LIMIT 10000';
        
        return query;
    }
    
    /**
     * @description Gets the constructed SELECT clause
     */
    public String getSelectClause() {
        return selectClause;
    }
    
    /**
     * @description Gets the constructed FROM clause
     */
    public String getFromClause() {
        return fromClause;
    }
    
    /**
     * @description Gets the WHERE conditions
     */
    public List<String> getWhereConditions() {
        return whereConditions;
    }
}