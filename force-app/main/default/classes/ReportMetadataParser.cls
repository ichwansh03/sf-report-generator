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
        
        // Extract reportType
        Object types = reportMetadata.get('reportType');
        /*system.debug('types: '+types);
String reportType = (String) reportMetadata.get('reportType');
validateReportType(reportType, reportId);
reportData.reportType = reportType;
system.debug('report type: '+reportType);*/
        String reportType;
        
        // Case 1: types is a Map<String, Object>
        if (types instanceof Map<String, Object>) {
            Map<String, Object> typesMap = (Map<String, Object>) types;
            if (typesMap.containsKey('type')) {
                reportType = String.valueOf(typesMap.get('type'));
            } else {
                // fallback if key name differs
                reportType = typesMap.containsKey('label') ? String.valueOf(typesMap.get('label')) : null;
            }
            
            // Case 2: types is a List of maps (e.g., multiple type entries)
        }
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
        // Extract base object name from reportType or metadata
        reportData.baseObject = extractBaseObject(reportType, reportMetadata);
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
* @description Extracts the base object from report type or metadata
*/
    private static String extractBaseObject(String reportType, Map<String, Object> reportMetadata) {
        // First try to get it directly from metadata
        String objectName = (String) reportMetadata.get('baseObject') ?? 
            (String) reportMetadata.get('sobjectType');
        
        if (String.isNotBlank(objectName)) {
            return objectName;
        }
        
        // Fall back to derived mapping from reportType
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
                        return reportTypeToObject.get(reportType);
                    }
        
        // If custom report, might need explicit mapping from metadata
        return null;
    }
}