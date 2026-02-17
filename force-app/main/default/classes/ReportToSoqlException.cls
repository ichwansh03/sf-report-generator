/**
 * @description Custom exception class for Report to SOQL conversion errors.
 * Provides detailed error context and categorization for different failure scenarios.
 */
public class ReportToSoqlException extends Exception {
    
    /**
     * @description Exception category for different error types
     */
    public enum ExceptionType {
        API_ERROR,
        PARSING_ERROR,
        VALIDATION_ERROR,
        SECURITY_ERROR,
        UNSUPPORTED_REPORT_TYPE,
        FIELD_NOT_FOUND,
        OBJECT_NOT_FOUND,
        FILTER_ERROR,
        SOQL_GENERATION_ERROR,
        INSUFFICIENT_PERMISSIONS
    }
    
    public ExceptionType exceptionType { get; private set; }
    public String context { get; private set; }
    public String reportId { get; private set; }
    private String errorMessage { get; set; }
    
    /**
     * @description Constructor with exception type and message
     */
    public ReportToSoqlException(ExceptionType type, String message) {
        this.exceptionType = type;
        this.errorMessage = message;
    }
    
    /**
     * @description Constructor with exception type, message, and context
     */
    public ReportToSoqlException(ExceptionType type, String message, String context) {
        this.exceptionType = type;
        this.context = context;
        this.errorMessage = message;
    }
    
    /**
     * @description Constructor with exception type, message, context, and reportId
     */
    public ReportToSoqlException(ExceptionType type, String message, String context, String reportId) {
        this.exceptionType = type;
        this.context = context;
        this.reportId = reportId;
        this.errorMessage = message;
    }
    
    /**
     * @description Gets the full error message with context
     */
    public String getFullErrorMessage() {
        String msg = 'ReportToSoql Error [' + exceptionType + ']: ' + errorMessage;
        if (String.isNotBlank(context)) {
            msg += ' | Context: ' + context;
        }
        if (String.isNotBlank(reportId)) {
            msg += ' | ReportId: ' + reportId;
        }
        return msg;
    }
    
    /**
     * @description Override getMessage to return the stored error message
     */
    public override String getMessage() {
        return errorMessage;
    }
}
