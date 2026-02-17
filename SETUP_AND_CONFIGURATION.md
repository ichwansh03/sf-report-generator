# Report to SOQL Converter - Setup & Configuration Guide

## Prerequisites

- Salesforce org with API enabled
- User must have "API Enabled" user permission
- Access to Setup for creating Named Credentials
- Analytics API access enabled for your org

## Step 1: Create Named Credential

### Via Salesforce Setup UI

1. **Navigate to Named Credentials:**
   - Go to Setup → Apps → App Manager
   - Search for "Named Credentials" or go to Setup → Security → Named Credentials

2. **Create New Named Credential:**
   - Click "New Named Credential"
   - Fill in the following:
     ```
     Label: Analytics API
     Name: AnalyticsAPI
     URL: https://YOUR_INSTANCE.salesforce.com
     Identity Type: Named Principal
     Authentication Protocol: OAuth 2.0
     Authentication Provider: Salesforce
     ```

3. **OAuth 2.0 Configuration:**
   - Scope: `analytics_api_read refresh_token`
   - Start Authentication Flow: ☑ Checked
   - Save

4. **Authorize:**
   - After saving, you'll see an "Authorize" button
   - Click to authorize the connection with an admin account
   - Confirm the OAuth flow

### Via Metadata API (SFDX)

Create a `NamedCredential` metadata file:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<NamedCredential xmlns="http://soap.sforce.com/2006/04/metadata">
    <endpoint>https://YOUR_INSTANCE.salesforce.com</endpoint>
    <label>Analytics API</label>
    <principalType>NamedUser</principalType>
    <protocol>OAuth</protocol>
    <oauthProtocol>
        <oauthType>OAuth2</oauthType>
        <authorizationEndpoint>https://login.salesforce.com/services/oauth2/authorize</authorizationEndpoint>
        <tokenEndpoint>https://login.salesforce.com/services/oauth2/token</tokenEndpoint>
        <tokenEndpointHeaders>
            <entries>
                <key>Content-Type</key>
                <value>application/x-www-form-urlencoded</value>
            </entries>
        </tokenEndpointHeaders>
        <options>
            <canonicalUrl>false</canonicalUrl>
            <ownerRequired>false</ownerRequired>
            <useAsync>false</useAsync>
        </options>
        <oauthTokenEndpointAttributes>
            <attribute>refreshTokenValidity</attribute>
        </oauthTokenEndpointAttributes>
        <scope>analytics_api_read refresh_token</scope>
    </oauthProtocol>
</NamedCredential>
```

## Step 2: Deploy Apex Classes

### Using SFDX

```bash
# Deploy all Report to SOQL classes
sfdx force:source:deploy -p force-app/main/default/classes/ReportToSoql*.cls

# Or deploy entire package
sfdx force:source:deploy
```

### Using Metadata API (ANT)

Add to your `build.xml`:

```xml
<members>ReportToSoqlException</members>
<members>ReportApiClient</members>
<members>ReportMetadataParser</members>
<members>FilterConverter</members>
<members>SchemaValidator</members>
<members>SecurityEnforcer</members>
<members>SoqlQueryBuilder</members>
<members>ReportToSoqlConverter</members>
```

## Step 3: Verify Installation

### Run Validation Tests

```bash
# Run all Report to SOQL tests
sfdx force:apex:test:run -n "*Report*" --loglevel debug
```

### Test Named Credential Connection

Create a quick test:

```apex
@isTest
public class NamedCredentialTest {
    @isTest
    static void testNamedCredentialConnection() {
        Test.setMock(HttpCalloutMock.class, new ValidMockResponse());
        
        try {
            Map<String, Object> result = ReportApiClient.fetchReportMetadata('00O1X000000IZkUAW');
            System.debug('Connection successful: ' + result);
        } catch (Exception e) {
            System.debug('Connection failed: ' + e.getMessage());
        }
    }
    
    public class ValidMockResponse implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest request) {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setBody('{"reportMetadata": {"reportType": "AccountList"}}');
            return response;
        }
    }
}
```

## Step 4: Grant User Permissions

### Required OLS (Object Level Security)
Users need READ access to:
- Reports (to read report metadata)
- Base objects of the reports being converted (Account, Contact, etc.)

### Required FLS (Field Level Security)
Users need READ access to:
- All fields referenced in report filters
- All fields in report columns

### Grant Permissions via Profile or Permission Set

1. **Via Permission Set (Recommended):**
   - Create new Permission Set
   - Add object permissions (READ)
   - Add field permissions (READ) for relevant fields
   - Assign to users

2. **Via Profile:**
   - Edit profile
   - Enable "View Setup and Configuration"
   - Set object and field permissions

## Example: Minimal Permission Set

```xml
<?xml version="1.0" encoding="UTF-8"?>
<PermissionSet xmlns="http://soap.sforce.com/2006/04/metadata">
    <label>Report to SOQL Converter</label>
    <objectPermissions>
        <object>Account</object>
        <allowCreate>false</allowCreate>
        <allowDelete>false</allowDelete>
        <allowEdit>false</allowEdit>
        <allowRead>true</allowRead>
        <modifyAllRecords>false</modifyAllRecords>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>
    <objectPermissions>
        <object>Contact</object>
        <allowCreate>false</allowCreate>
        <allowDelete>false</allowDelete>
        <allowEdit>false</allowEdit>
        <allowRead>true</allowRead>
        <modifyAllRecords>false</modifyAllRecords>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>
</PermissionSet>
```

## Step 5: Basic Usage

### In Apex Code

```apex
public class ReportQueryExample {
    public static void convertAndQueryReport() {
        String reportId = '00O1X000000IZkUAW';
        
        try {
            // Convert report to SOQL
            String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
            
            // Execute the query
            List<Account> results = Database.query(soqlQuery);
            
            // Process results
            for (Account acc : results) {
                System.debug('Found account: ' + acc.Name);
            }
            
        } catch (ReportToSoqlException e) {
            System.debug('Error: ' + e.getFullErrorMessage());
            // Log error for monitoring
            logError(e);
        }
    }
    
    private static void logError(ReportToSoqlException e) {
        // Implement your error logging
        System.debug('Exception Type: ' + e.exceptionType);
        System.debug('Context: ' + e.context);
        System.debug('Report ID: ' + e.reportId);
    }
}
```

### In Flow

Create a Flow with Apex Action:

```
1. Flow Variable: reportId (text)
2. Apex Action: ReportToSoqlConverter.generateSoqlFromReport(reportId)
3. Flow Variable: generatedSoqlQuery (text) - captures output
4. Record Query: Execute SOQL query
```

### In REST API

Create REST endpoint:

```apex
@RestResource(urlMapping='/reports/convert/*')
global class ReportConvertService {
    @HttpGet
    global static void convertReport() {
        String reportId = RestContext.request.getParameter('reportId');
        
        try {
            String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
            
            Map<String, Object> response = new Map<String, Object> {
                'success' => true,
                'soqlQuery' => soqlQuery,
                'message' => 'Report converted successfully'
            };
            
            RestContext.response.responseBody = Blob.valueOf(JSON.serialize(response));
            
        } catch (ReportToSoqlException e) {
            RestContext.response.statusCode = 400;
            RestContext.response.responseBody = Blob.valueOf(
                JSON.serialize(new Map<String, Object> {
                    'success' => false,
                    'error' => e.getFullErrorMessage()
                })
            );
        }
    }
}
```

## Troubleshooting Setup Issues

### Issue: "Named Credential Not Found"

**Solution:**
1. Verify the Named Credential name is exactly: `AnalyticsAPI`
2. Check the URL matches your Salesforce instance
3. Ensure you're in the right sandbox/production org

### Issue: "401 Unauthorized"

**Solution:**
1. Re-authorize the Named Credential:
   - Go to Setup → Named Credentials
   - Click the Named Credential
   - Click "Authorize"
   - Complete OAuth flow
2. Verify the user account used for authorization has API access

### Issue: "Insufficient Permissions"

**Solution:**
1. Check user has "API Enabled" permission in their profile
2. Verify user is assigned appropriate permission sets
3. Check FLS for all report columns and filter fields
4. Verify OLS for base object

### Issue: "Report Not Found"

**Solution:**
1. Verify the report ID is correct and exists
2. Confirm the user running the code can access the report
3. Check the report hasn't been deleted or archived

## Performance Optimization

### Cache Report Metadata

For frequently used reports, implement caching:

```apex
public class CachedReportConverter {
    private static Map<String, String> reportCache = new Map<String, String>();
    private static final Integer CACHE_HOURS = 1;
    
    public static String generateSoqlCached(Id reportId) {
        String cacheKey = reportId + '_' + DateTime.now().formatGMT('yyyy-MM-dd HH:00');
        
        if (reportCache.containsKey(cacheKey)) {
            return reportCache.get(cacheKey);
        }
        
        String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);
        reportCache.put(cacheKey, soqlQuery);
        
        return soqlQuery;
    }
}
```

### Use Batch Processing

For large result sets:

```apex
public class ReportQueryBatch implements Database.Batchable<SObject> {
    private Id reportId;
    
    public ReportQueryBatch(Id reportId) {
        this.reportId = reportId;
    }
    
    public Database.QueryLocator start(Database.BatchableContext context) {
        return ReportToSoqlConverter.queryLocatorFromReport(reportId, 10000);
    }
    
    public void execute(Database.BatchableContext context, List<SObject> scope) {
        // Process batch of records
    }
    
    public void finish(Database.BatchableContext context) {
        // Handle completion
    }
}
```

## Monitoring & Logging

### Enable Debug Logging

```apex
// In your code
System.debug(LoggingLevel.DEBUG, 'Converting report: ' + reportId);

String soqlQuery = ReportToSoqlConverter.generateSoqlFromReport(reportId);

System.debug(LoggingLevel.DEBUG, 'Generated SOQL: ' + soqlQuery);
```

### Monitor Security Events

Check SecurityEnforcer logs in Debug Logs:

```
[ReportToSoqlConverter] SecurityEvent: REPORT_CONVERTED | 
Object: Account | 
Details: ReportId: 00O1X000000IZkUAW | Duration: 245ms | 
User: 005xx000001SZE
```

## Production Deployment Checklist

- [ ] Named Credential created and authorized
- [ ] All Apex classes deployed
- [ ] Tests running with >80% coverage
- [ ] Permission sets configured
- [ ] Named Credential tested with real report
- [ ] Error handling tested
- [ ] Logging configured
- [ ] Performance tested with typical report sizes
- [ ] Security reviewed by admin
- [ ] Documentation provided to end users
- [ ] Monitoring established for failures

## Support Resources

- **Salesforce Analytics API Docs:** [Link](https://developer.salesforce.com/docs/atlas.en-us.api_analytics.meta/api_analytics/)
- **Named Credentials:** [Setup Guide](https://help.salesforce.com/s/articleView?id=sf.named_credentials_create.htm)
- **Field-Level Security:** [Permission Setup](https://help.salesforce.com/s/articleView?id=sf.field_level_security.htm)
