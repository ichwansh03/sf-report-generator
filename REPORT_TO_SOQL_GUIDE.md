# Report to SOQL Converter - Production-Ready Service

## Overview

The **ReportToSoqlConverter** is a production-ready Apex service that dynamically generates valid SOQL queries from Salesforce Reports using the Analytics REST API. It provides secure, validated conversion with comprehensive error handling and security enforcement.

## Architecture

The solution follows clean architecture principles with clear separation of concerns:

```
ReportToSoqlConverter (Main Service)
├── ReportApiClient (API Communication)
├── ReportMetadataParser (Data Parsing)
├── FilterConverter (Filter Transformation)
├── SchemaValidator (Schema Validation)
├── SecurityEnforcer (Security & Access Control)
└── SoqlQueryBuilder (Query Construction)
```

## Components

### 1. ReportToSoqlException
Custom exception class providing categorized error handling with detailed context.

**Exception Types:**
- `API_ERROR` - HTTP callout failures
- `PARSING_ERROR` - JSON parsing issues
- `VALIDATION_ERROR` - Schema validation failures
- `SECURITY_ERROR` - Access control violations
- `UNSUPPORTED_REPORT_TYPE` - Joined, Summary, Matrix reports
- `FIELD_NOT_FOUND` - Missing fields on object
- `OBJECT_NOT_FOUND` - Invalid object references
- `FILTER_ERROR` - Filter conversion issues
- `SOQL_GENERATION_ERROR` - Query generation failures
- `INSUFFICIENT_PERMISSIONS` - FLS/OLS violations

### 2. ReportApiClient
Handles authenticated HTTP callouts to the Salesforce Analytics REST API.

**Features:**
- Uses Named Credential for secure authentication
- Automatic retry logic with exponential backoff for transient failures
- 30-second timeout
- Comprehensive error handling

**Required Named Credential:**
```
Name: AnalyticsAPI
URL: https://your-instance.salesforce.com
Type: OAuth 2.0
```

**Endpoint:**
```
/services/data/v62.0/analytics/reports/{REPORT_ID}?includeDetails=true
```

### 3. ReportMetadataParser
Parses JSON response and extracts relevant report metadata.

**Extracted Data:**
- `reportType` - Type of report (validates TabularReport only)
- `reportBooleanFilter` - Logical grouping (e.g., "1 AND (2 OR 3)")
- `reportFilters` - Filter definitions with operators and values
- `detailColumns` - Fields to include in SELECT clause
- `baseObject` - Primary object for FROM clause

**Validation:**
- Rejects unsupported report types:
  - JoinedReport
  - SummaryReport
  - MatrixReport
  - BucketFieldReport

### 4. FilterConverter
Transforms report filters to SOQL WHERE clause conditions.

**Operator Mapping:**
| Report Operator | SOQL Operator | Notes |
|---|---|---|
| equals | = | Exact match |
| not_equal | != | Not equal |
| lt | < | Less than |
| lte | <= | Less than or equal |
| gt | > | Greater than |
| gte | >= | Greater than or equal |
| contains | LIKE | Contains substring |
| not_contains | NOT LIKE | Excludes substring |
| starts_with | LIKE | Prefix match |
| ends_with | LIKE | Suffix match |
| in | IN | List of values |
| not_in | NOT IN | Exclude list |
| includes | INCLUDES | Multi-select picklist |
| excludes | EXCLUDES | Multi-select picklist |

**Supported Filter Types:**
- **Text Fields** - String values with optional wildcard
- **Numeric Fields** - Integer and decimal values
- **Date Fields** - ISO format (YYYY-MM-DD)
- **Relative Dates** - LAST_N_DAYS:30, THIS_MONTH, THIS_QUARTER, etc.
- **Picklists** - Single and multi-select
- **Lookups/References** - Account.Name, Owner.Email
- **Booleans** - true/false values

**SOQL Injection Prevention:**
- Detects and rejects suspicious patterns:
  - UNION, SELECT, FROM, WHERE, INSERT, UPDATE, DELETE keywords
  - String injection attempts in filter values
  - Escapes single quotes in string values

### 5. SchemaValidator
Validates fields, objects, and relationships using Schema.DescribeFResult.

**Validation Checks:**
- Object exists and is queryable
- Field exists on object
- Field is field-level readable (FLS)
- Object is object-level readable (OLS)
- Relationship paths are valid
- Field is filterable and queryable

**Supported Field Types:**
- Standard fields (Name, Phone, Email)
- Custom fields (CustomField__c)
- Relationship fields (Account.Owner)
- Multi-level relationships (Account.Owner.Manager)

### 6. SecurityEnforcer
Enforces object-level access, field-level security, and sharing rules.

**`with sharing` Declaration:**
Respects organization's sharing rules through the `with sharing` keyword.

**Security Checks:**
- Object-level read access validation
- Field-level read access for each column and filter
- Query structure validation
- DML operation prevention

**Audit Logging:**
- Logs all conversion attempts for security audit
- Records user ID and timestamp
- Categorizes events as successes or failures

### 7. SoqlQueryBuilder
Constructs complete SOQL query from parsed report metadata.

**Query Components:**
```
SELECT [validated columns]
FROM [base object]
WHERE [converted filters with boolean logic]
```

**Boolean Filter Logic:**
- Supports parenthetical grouping: `(2 OR 3)`
- Supports AND/OR composition: `1 AND (2 OR 3)`
- Defaults to AND for all conditions if not specified

**Error Handling:**
- Gracefully skips invalid columns (logs warnings)
- Falls back to simple AND if boolean filter is malformed
- Includes ID field in SELECT if not specified

## Usage

### Basic Usage
```apex
try {
    String reportId = '00O1X000000IZkUAW';
    String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
    
    // Execute the query
    List<Account> results = Database.query(soqlQuery);
} catch (ReportToSoqlException e) {
    System.debug('Error: ' + e.getFullErrorMessage());
}
```

### Query Execution
```apex
// Method 1: Direct query
List<SObject> results = ReportToSoqlConverter.queryFromReport(reportId);

// Method 2: With QueryLocator (for batch jobs)
Database.QueryLocator locator = ReportToSoqlConverter.queryLocatorFromReport(reportId, 10000);
```

### Error Handling
```apex
try {
    String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
} catch (ReportToSoqlException e) {
    ReportToSoqlException.ExceptionType type = e.exceptionType;
    String context = e.context;
    String reportId = e.reportId;
    String fullMsg = e.getFullErrorMessage();
    
    // Handle different error types
    if (type == ReportToSoqlException.ExceptionType.SECURITY_ERROR) {
        // Handle security violation
    } else if (type == ReportToSoqlException.ExceptionType.UNSUPPORTED_REPORT_TYPE) {
        // Handle unsupported report
    } else {
        // Handle other errors
    }
}
```

## Requirements

### Salesforce Configuration

1. **Named Credential Setup:**
   - Create a Named Credential named `AnalyticsAPI`
   - Configure OAuth 2.0 with your Salesforce instance
   - Grant `analytics_api_read` scope

2. **API Version:**
   - Minimum: Salesforce v62.0 (API v62.0)

3. **User Permissions:**
   - Must have access to run reports
   - Must have read access to Report and Dashboard List
   - May require "Run Reports" permission

4. **Field-Level Security:**
   - User must have read access to all report columns
   - User must have read access to all filter fields

5. **Object-Level Security:**
   - User must have read access to the base object

### Limitations & Constraints

**Supported Report Types:**
- ✅ TabularReport (standard tabular reports)

**Unsupported Report Types:**
- ❌ JoinedReport (multi-object reports)
- ❌ SummaryReport (grouped reports with aggregations)
- ❌ MatrixReport (pivot-style reports)
- ❌ BucketFieldReport (reports with bucketed fields)
- ❌ Custom report types with cross-filters

**Field Limitations:**
- No aggregation fields (SUM, COUNT, AVG) - use standard reports instead
- No custom summary formulas
- No grouping functions
- No ranking functions

## Testing

All components include comprehensive unit tests:

| Class | Test File | Coverage |
|---|---|---|
| ReportToSoqlException | ReportToSoqlException_Test | Exception creation & formatting |
| ReportApiClient | (Mocked in integration tests) | HTTP communication |
| ReportMetadataParser | ReportMetadataParser_Test | Parsing, validation, error handling |
| FilterConverter | FilterConverter_Test | Operator mapping, injection prevention |
| SchemaValidator | SchemaValidator_Test | Field & object validation |
| SecurityEnforcer | (Implicit via converter tests) | Security checks |
| SoqlQueryBuilder | SoqlQueryBuilder_Test | Query structure & logic |
| ReportToSoqlConverter | ReportToSoqlConverter_Test | Integration testing |

### Running Tests
```bash
# Run all tests for this feature
sfdx force:apex:test:run -n "*Report*"

# Run specific test class
sfdx force:apex:test:run -n ReportToSoqlConverter_Test

# With code coverage reporting
sfdx force:apex:test:run -n "*Report*" --codecoverage --resultformat json
```

## Example Implementation

### Scenario: Convert Account Report to SOQL

**Report Setup:**
- Report Name: "Active Accounts"
- Base Object: Account
- Filters: 
  - Industry equals "Technology"
  - Revenue > 1000000
- Columns: Name, Phone, Website, Industry

**Code:**
```apex
String reportId = '00O1X000000IZkUAW';

try {
    String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
    
    // Results in something like:
    // SELECT Id, Name, Phone, Website, Industry FROM Account 
    // WHERE Industry = 'Technology' AND Revenue > 1000000
    
    List<Account> results = Database.query(soqlQuery);
    System.debug('Found ' + results.size() + ' active accounts');
    
} catch (ReportToSoqlException e) {
    System.debug('Conversion failed: ' + e.getFullErrorMessage());
}
```

## Performance Considerations

1. **API Callout Time:**
   - Typically 200-500ms per report fetch
   - Include in governor limit calculations
   - Consider caching report metadata if used repeatedly

2. **Query Execution Time:**
   - Depends on report filters and base object size
   - Always include LIMIT clause for safety
   - Use LIMIT 10000 by default

3. **Governor Limits:**
   - 1 HTTP callout per conversion
   - Query execution counts against SOQL governor limit
   - Schema.getGlobalDescribe() cached at each test method execution

## Security Best Practices

1. **Always Use Named Credential:**
   - Never hardcode authentication in code
   - Leverage Salesforce's secure credential management

2. **Validate User Permissions:**
   - Always catch SecurityExceptions for permission errors
   - Log security violations for audit

3. **Limit Query Scope:**
   - Add explicit LIMIT clause to generated queries
   - Consider WHERE clause restrictions

4. **Audit Access:**
   - Monitor SecurityEnforcer log events
   - Track report conversions by user

5. **Prevent Injection:**
   - Built-in SOQL injection prevention
   - String values are escaped automatically
   - Validates against suspicious SQL keywords

## Troubleshooting

### Common Issues

**401 Unauthorized Error:**
- Verify Named Credential is configured correctly
- Check OAuth token scope includes analytics API access
- Verify user has "Run Reports" permission

**404 Report Not Found:**
- Confirm report ID is correct
- Verify user has access to the report
- Check report hasn't been deleted

**Field Not Found Error:**
- Verify all columns exist on base object
- Check field names are exact (case-insensitive in Salesforce)
- Ensure user has field-level read access

**UNSUPPORTED_REPORT_TYPE:**
- Only TabularReport types are supported
- Use standard tabular reports, not summary/matrix
- Consider breaking complex reports into simpler ones

**Insufficient Permissions:**
- Verify user has object and field read access
- Confirm OLS/FLS settings allow the user
- Check sharing rules for the base object

## Future Enhancements

Potential improvements for future versions:

1. **Support for Additional Report Types:**
   - Cross-filter handling for joined reports
   - Aggregation functions for summary reports

2. **Advanced Features:**
   - Built-in LIMIT and OFFSET support
   - ORDER BY clause generation
   - Field aliasing support

3. **Performance:**
   - Metadata caching mechanism
   - Batch report conversion
   - Async callout support

4. **Extended Operators:**
   - Custom Salesforce functions
   - Complex formula field conversion

## Support & Maintenance

For issues, questions, or enhancement requests:
1. Review the test classes for usage examples
2. Check error messages and exception types
3. Verify Named Credential configuration
4. Consult Salesforce Analytics API documentation

Current API Version: **62.0**
Last Updated: **February 2026**
