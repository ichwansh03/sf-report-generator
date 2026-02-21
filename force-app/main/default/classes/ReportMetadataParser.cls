/**
* @description Parses the JSON response from the Analytics Report API and extracts relevant metadata.
* Handles validation and type conversion of report structure.
*/
public class ReportMetadataParser {
    
    /**
* @description Represents the parsed report metadata
*/
    public class ReportData {
        public String reportType { get; set; }
        public String reportBooleanFilter { get; set; }
        public Map<String, Object> reportMetadata { get; set; }
        public Map<String, Object> reportTypeMetadata { get; set; }
        public List<Map<String, Object>> reportFilters { get; set; }
        public List<String> detailColumns { get; set; }
        public String baseObject { get; set; }
    }
    
    /**
* @description Parses the API response into structured report data
* @param apiResponse The raw API response as a Map
* @param reportId The ID of the report being parsed
* @return The parsed ReportData object
* @throws ReportToSoqlException on parsing errors
*/
    public static ReportData parseReportResponse(Map<String, Object> apiResponse, Id reportId) {
        if (apiResponse == null || apiResponse.isEmpty()) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.PARSING_ERROR,
                'API response is null or empty',
                'parseReportResponse',
                reportId
            );
        }
        
        //try {
        ReportData reportData = new ReportData();
        
        // Extract reportMetadata
        Map<String, Object> reportMetadata = (Map<String, Object>) apiResponse.get('reportMetadata');
        if (reportMetadata == null) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.PARSING_ERROR,
                'Missing reportMetadata in API response',
                'parseReportResponse',
                reportId
            );
        }
        reportData.reportMetadata = reportMetadata;
        
        // Extract reportTypeMetadata - contains objects and objectRelations
        Map<String, Object> reportTypeMetadata = (Map<String, Object>) apiResponse.get('reportTypeMetadata');
        if (reportTypeMetadata != null) {
            reportData.reportTypeMetadata = reportTypeMetadata;
            system.debug('reportTypeMetadata found with keys: ' + reportTypeMetadata.keySet());
        } else {
            system.debug('WARNING: reportTypeMetadata not found in API response');
        }
        
        // Extract reportType
        Object types = reportMetadata.get('reportType');
        system.debug('types: '+types);
        String reportType;
        
        // Case 1: types is a String (most common case from API)
        if (types instanceof String) {
            reportType = (String) types;
        }
        // Case 2: types is a Map<String, Object>
        else if (types instanceof Map<String, Object>) {
            Map<String, Object> typesMap = (Map<String, Object>) types;
            if (typesMap.containsKey('type')) {
                reportType = String.valueOf(typesMap.get('type'));
            } else {
                // fallback if key name differs
                reportType = typesMap.containsKey('label') ? String.valueOf(typesMap.get('label')) : null;
            }
        }
        // Case 3: types is a List of maps (e.g., multiple type entries)
        else if (types instanceof List<Object>) {
            List<Object> typesList = (List<Object>) types;
            if (!typesList.isEmpty() && typesList.get(0) instanceof Map<String, Object>) {
                Map<String, Object> typesMap = (Map<String, Object>) typesList.get(0);
                reportType = String.valueOf(typesMap.get('type') ?? typesMap.get('label'));
            }
        }
        
        // Validate reportType
        validateReportType(reportType, reportId);
        reportData.reportType = reportType;
        system.debug('report type: '+reportType);
        // Extract reportBooleanFilter
        reportData.reportBooleanFilter = (String) reportMetadata.get('reportBooleanFilter');
        if (String.isBlank(reportData.reportBooleanFilter)) {
            reportData.reportBooleanFilter = '1'; // Default to first filter if none specified
        }
        
        // Extract reportFilters as List<Map<String, Object>>
        List<Object> filtersObj = (List<Object>) reportMetadata.get('reportFilters');
        reportData.reportFilters = new List<Map<String, Object>>();
        if (filtersObj != null) {
            for (Object filterObj : filtersObj) {
                reportData.reportFilters.add((Map<String, Object>) filterObj);
            }
        }
        system.debug('filterObj: '+filtersObj);
        // Extract detailColumns
        List<Object> columnsObj = (List<Object>) reportMetadata.get('detailColumns');
        reportData.detailColumns = new List<String>();
        if (columnsObj != null) {
            for (Object colObj : columnsObj) {
                reportData.detailColumns.add((String) colObj);
            }
        }
        system.debug('columnsObj: '+columnsObj);
        // Extract base object name from reportType, metadata, reportTypeMetadata, or detailColumns
        reportData.baseObject = extractBaseObject(
            reportType, 
            reportMetadata, 
            reportTypeMetadata,
            reportData.detailColumns
        );
        
        // Validate that baseObject was successfully extracted
        if (String.isBlank(reportData.baseObject)) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.PARSING_ERROR,
                'Could not determine base object from report metadata. ' +
                'Checked: reportMetadata.baseObject, reportTypeMetadata.objects, detailColumns, and reportType mapping. ' +
                'ReportType: ' + reportType,
                'extractBaseObject',
                null
            );
        }
        
        system.debug('reportData: '+reportData);            
        return reportData;
        
        /*} catch (ReportToSoqlException e) {
throw e;
} catch (Exception e) {
throw new ReportToSoqlException(
ReportToSoqlException.ExceptionType.PARSING_ERROR,
'Failed to parse report metadata: ' + e.getMessage(),
'parseReportResponse',
reportId
);
}*/
    }
    
    /**
* @description Validates that the report type is supported (TabularReport)
*/
    private static void validateReportType(String reportType, Id reportId) {
        if (String.isBlank(reportType)) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.PARSING_ERROR,
                'Report type is missing',
                'validateReportType',
                reportId
            );
        }
        
        // List of unsupported report types
        Set<String> unsupportedTypes = new Set<String> {
            'JoinedReport',
                'SummaryReport',
                'MatrixReport',
                'BucketFieldReport'
                };
                    
                    if (unsupportedTypes.contains(reportType)) {
                        throw new ReportToSoqlException(
                            ReportToSoqlException.ExceptionType.UNSUPPORTED_REPORT_TYPE,
                            'Report type "' + reportType + '" is not supported. Only TabularReport is supported.',
                            reportType,
                            reportId
                        );
                    }
    }
    
    /**
* @description Extracts the base object from multiple sources in order of priority:
* 1. reportMetadata.baseObject (direct)
* 2. reportTypeMetadata.objects (root object from report type)
* 3. detailColumns (parse first column to extract object reference - e.g., "Account.Name" => "Account")
* 4. reportType mapping (fallback for known report types)
*/
    private static String extractBaseObject(
        String reportType, 
        Map<String, Object> reportMetadata,
        Map<String, Object> reportTypeMetadata,
        List<String> detailColumns
    ) {
        // Strategy 1: Try to get baseObject directly from reportMetadata
        String objectName = (String) reportMetadata.get('baseObject');
        if (String.isNotBlank(objectName)) {
            system.debug('baseObject found in reportMetadata: ' + objectName);
            return objectName;
        }
        
        // Strategy 2: Try sobjectType from reportMetadata
        objectName = (String) reportMetadata.get('sobjectType');
        if (String.isNotBlank(objectName)) {
            system.debug('sobjectType found in reportMetadata: ' + objectName);
            return objectName;
        }
        
        // Strategy 3: Extract from reportTypeMetadata.objects (root object)
        if (reportTypeMetadata != null && reportTypeMetadata.containsKey('objects')) {
            Object objectsObj = reportTypeMetadata.get('objects');
            system.debug('Found objects in reportTypeMetadata: ' + objectsObj);
            
            // objects could be a List or Map
            if (objectsObj instanceof List<Object>) {
                List<Object> objList = (List<Object>) objectsObj;
                if (!objList.isEmpty()) {
                    Object firstObj = objList.get(0);
                    if (firstObj instanceof Map<String, Object>) {
                        Map<String, Object> objMap = (Map<String, Object>) firstObj;
                        // The root object usually has 'name' or 'label' field
                        objectName = (String) (objMap.get('name') ?? objMap.get('label'));
                        if (String.isNotBlank(objectName)) {
                            system.debug('baseObject extracted from reportTypeMetadata.objects[0]: ' + objectName);
                            return objectName;
                        }
                    } else if (firstObj instanceof String) {
                        objectName = (String) firstObj;
                        if (String.isNotBlank(objectName)) {
                            system.debug('baseObject extracted from reportTypeMetadata.objects[0]: ' + objectName);
                            return objectName;
                        }
                    }
                }
            } else if (objectsObj instanceof Map<String, Object>) {
                Map<String, Object> objMap = (Map<String, Object>) objectsObj;
                // If it's a map, the root object might be the first entry
                for (String key : objMap.keySet()) {
                    objectName = key;
                    if (String.isNotBlank(objectName)) {
                        system.debug('baseObject extracted from reportTypeMetadata.objects (first key): ' + objectName);
                        return objectName;
                    }
                }
            }
        }
        
        // Strategy 4: Extract from detailColumns
        // Detail columns are typically formatted as "FieldName" or "ObjectName.FieldName"
        if (detailColumns != null && !detailColumns.isEmpty()) {
            String firstColumn = detailColumns.get(0);
            system.debug('Attempting to extract object from detailColumns. First column: ' + firstColumn);
            
            // if column contains a dot, it's a relationship field
            if (firstColumn != null && firstColumn.contains('.')) {
                String[] parts = firstColumn.split('\\.');
                if (parts.size() > 0) {
                    objectName = parts.get(0);
                    if (String.isNotBlank(objectName)) {
                        system.debug('baseObject extracted from detailColumns (relationship): ' + objectName);
                        return objectName;
                    }
                }
            } else {
                // If no dot, it's a root object field - use the reportType mapping to find the object
                system.debug('detailColumn has no relationship: ' + firstColumn + ', will use reportType mapping');
            }
        }
        
        // Strategy 5: Fall back to derived mapping from reportType
        if (String.isNotBlank(reportType)) {
            Map<String, String> reportTypeToObject = new Map<String, String> {
                'AccountList' => 'Account',
                'ContactList' => 'Contact',
                'OpportunityList' => 'Opportunity',
                'LeadList' => 'Lead',
                'CaseList' => 'Case',
                'TaskList' => 'Task',
                'EventList' => 'Event',
                'ActivityList' => 'Activity'
            };
            
            if (reportTypeToObject.containsKey(reportType)) {
                objectName = reportTypeToObject.get(reportType);
                system.debug('baseObject derived from reportType mapping: ' + reportType + ' => ' + objectName);
                return objectName;
            }
        }
        
        // If we get here, we couldn't find the baseObject
        String typeMetadataKeys = reportTypeMetadata != null ? String.valueOf(reportTypeMetadata.keySet()) : 'null';
        system.debug('ERROR: Could not determine baseObject from any source. ' +
                    'ReportType: ' + reportType + 
                    ', reportTypeMetadata keys: ' + typeMetadataKeys +
                    ', detailColumns: ' + detailColumns);
        return null;
    }
}