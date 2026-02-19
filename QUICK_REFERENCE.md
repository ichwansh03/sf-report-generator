 Report to SOQL Converter - Quick Reference Guide

 Quick Start

 Basic Usage (3 lines)
```apex
String reportId = '00O1X000000IZkUAW';
String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
List<SObject> results = Database.query(soqlQuery);
```

 With Error Handling
```apex
try {
    String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
    List<SObject> results = Database.query(soqlQuery);
} catch (ReportToSoqlException e) {
    System.debug('Error: ' + e.getFullErrorMessage());
}
```

 Common Use Cases

 1. Convert Report to SOQL Query
```apex
String reportId = '00O1X000000IZkUAW';
String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
// soqlQuery: "SELECT Id, Name, Phone FROM Account WHERE Industry = 'Technology' AND BillingState = 'CA'"
```

 2. Execute Report as Direct Query
```apex
List<SObject> results = ReportToSoqlConverter.queryFromReport('00O1X000000IZkUAW');
```

 3. Use QueryLocator for Batch Processing
```apex
Database.QueryLocator locator = ReportToSoqlConverter.queryLocatorFromReport(reportId, 10000);

// Use in batch job:
Database.executeBatch(new ReportQueryBatch(reportId));
```

 4. Get SOQL Query for Inspection
```apex
String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
// Can log, validate, or modify before execution
System.debug('Query: ' + soqlQuery);
```

 5. Handle Different Error Types
```apex
try {
    String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
} catch (ReportToSoqlException e) {
    switch on e.exceptionType {
        when API_ERROR {
            // Handle API connectivity issue
        }
        when UNSUPPORTED_REPORT_TYPE {
            // Report is not a simple tabular report
        }
        when SECURITY_ERROR {
            // User doesn't have access
        }
        when VALIDATION_ERROR {
            // Invalid report structure
        }
        when else {
            // Handle other errors
        }
    }
}
```

 Frequently Asked Questions

 Q: Which report types are supported?
**A:** Only **TabularReport** (standard tabular reports). Not supported:
- JoinedReport (multi-object)
- SummaryReport (grouped data)
- MatrixReport (pivot tables)
- BucketFieldReport (bucketed columns)

 Q: Can I modify the generated SOQL query?
**A:** Yes! You can capture the SOQL string and modify it:
```apex
String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
// Modify if needed
soqlQuery = soqlQuery.replace('LIMIT 10000', 'LIMIT 500');
List<SObject> results = Database.query(soqlQuery);
```

 Q: How do I handle large result sets?
**A:** Use QueryLocator with batch processing:
```apex
Database.executeBatch(
    new ReportQueryBatch(reportId),
    200 // batch size
);
```

 Q: What about report filters with special characters?
**A:** The service automatically escapes single quotes in filter values.

 Q: Can I cache the generated SOQL?
**A:** Yes. The SOQL output is deterministic for the same report:
```apex
private static Map<String, String> cache = new Map<String, String>();

public static String generateCached(String reportId) {
    if (!cache.containsKey(reportId)) {
        cache.put(reportId, ReportToSoqlConverter.generateSoqlFromReport(reportId));
    }
    return cache.get(reportId);
}
```

 Q: How do I prevent SOQL injection?
**A:** The service handles this automatically. All filter values are:
- Validated against keyword patterns (SELECT, UNION, etc.)
- String values are escaped and quoted
- Numeric and date values are validated

 Q: Can I use relative date filters?
**A:** Yes! Supported formats:
- `LAST_N_DAYS:30`
- `THIS_MONTH`, `THIS_QUARTER`, `THIS_YEAR`
- `LAST_MONTH`, `LAST_QUARTER`, `LAST_YEAR`
- `FISCAL_YEAR:2024`

 Q: What's the performance impact?
**A:** Minimal.
- API call: 200-500ms
- SOQL generation: <50ms
- Query execution: depends on data volume

 Operator Reference

| Report Operator | SOQL Equivalent | Example |
|---|---|---|
| equals | = | Name = 'Acme' |
| not_equal | != | Status != 'Closed' |
| contains | LIKE | Email LIKE '%@example.com%' |
| starts_with | LIKE | Name LIKE 'A%' |
| ends_with | LIKE | Email LIKE '%@gmail.com' |
| in | IN | Status IN ('Open', 'Pending') |
| not_in | NOT IN | Industry NOT IN ('Tech', 'Finance') |
| includes | INCLUDES | Skills INCLUDES ('Apex', 'Visualforce') |
| excludes | EXCLUDES | Status EXCLUDES ('Closed', 'Won') |

 Common Error Messages

| Error | Cause | Solution |
|---|---|---|
| `API Error: 401 Unauthorized` | Named Credential not authorized | Re-authorize Named Credential |
| `Report not found with ID: ...` | Wrong report ID | Verify report ID |
| `No object-level read access` | User lacks OLS | Check user permissions |
| `No field-level read access` | User lacks FLS | Check field permissions |
| `Unsupported report type` | Not a tabular report | Use simple tabular report |
| `Field not found` | Field doesn't exist on object | Verify field API name |

 Integration Examples

 Lightning Web Component
```javascript
import { LightningElement, wire } from 'lwc';
import generateSoqlFromReport from '@salesforce/apex/ReportToSoqlConverter.generateSoqlFromReport';

export default class ReportConverter extends LightningElement {
    reportId = '00O1X000000IZkUAW';
    soqlQuery = '';
    error = null;
    
    @wire(generateSoqlFromReport, { reportId: '$reportId' })
    wiredSoql({ error, data }) {
        if (data) {
            this.soqlQuery = data;
        } else if (error) {
            this.error = error.body.message;
        }
    }
}
```

 Flow Integration
1. Create Flow variable of type `Text` named `reportId`
2. Add `Action` element calling `ReportToSoqlConverter` Apex method
3. Map `reportId` input and capture output to new variable
4. Use SOQL query in subsequent Record Query action

 Process Builder / Automated Actions
```apex
// Triggered by process builder
public class ReportConvertAction {
    @InvocableMethod(label='Convert Report to SOQL')
    public static List<String> convertReports(List<String> reportIds) {
        List<String> results = new List<String>();
        
        for (String reportId : reportIds) {
            try {
                String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
                results.add(soqlQuery);
            } catch (Exception e) {
                results.add('ERROR: ' + e.getMessage());
            }
        }
        
        return results;
    }
}
```

 Scheduled Batch Job
```apex
public class ScheduledReportQuery implements Schedulable {
    public void execute(SchedulableContext context) {
        String reportId = '00O1X000000IZkUAW';
        Database.executeBatch(new ReportQueryBatch(reportId), 200);
    }
}

// Schedule it:
// Scheduled Actions > New Scheduled Action
// Class: ScheduledReportQuery
// Frequency: Daily at 2 AM
```

 Best Practices

 ✅ DO
- Use try-catch blocks around conversions
- Validate report ID before conversion
- Cache SOQL queries for repeated use
- Add LIMIT clause to queries
- Log errors for monitoring
- Grant minimal required permissions
- Test with real report data

 ❌ DON'T
- Hardcode report IDs in production
- Modify generated SOQL without validation
- Use summary/matrix reports
- Grant excessive permissions
- Ignore security exceptions
- Execute unlimited queries
- Assume all report types work

 Limits & Constraints

| Limit | Value | Note |
|---|---|---|
| HTTP Callouts | 100 per transaction | Governed by Salesforce |
| Query Execution | 100 per transaction | Standard governor limit |
| SOQL Statement Length | 20,000 characters | Hard limit |
| Query Result Rows | 50,000 default | Use LIMIT clause |
| API Response Time | 30 seconds | Timeout configured |

 Additional Resources

- **Full Documentation:** See `REPORT_TO_SOQL_GUIDE.md`
- **Setup Guide:** See `SETUP_AND_CONFIGURATION.md`
- **Test Examples:** See `_Test.cls` files for code examples
- **Analytics API:** https://developer.salesforce.com/docs/atlas.en-us.api_analytics.meta/api_analytics/

 Version Information

- **API Version:** 62.0
- **Release Date:** February 2026
- **Supported from:** Salesforce v62.0 and later

---

**Need help?** Check the error message in your debug logs, then refer to the "Common Error Messages" section above.
