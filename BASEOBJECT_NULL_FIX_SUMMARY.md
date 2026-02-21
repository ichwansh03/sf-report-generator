# Fix Summary: baseObject Null Issue

## Problem Statement
The code was throwing a null value for `baseObject` when calling:
```apex
SecurityEnforcer.validateSecurityContext(
    reportData.baseObject,
    reportData.detailColumns,
    reportId
);
```

## Root Causes Identified

### 1. **Incomplete reportType Extraction** (ReportMetadataParser.cls)
**Issue**: The code only handled the case where `reportType` is a `Map<String, Object>`, but didn't handle when it's a simple `String` (which is what the Salesforce Analytics API actually returns).

```apex
// BEFORE - Incomplete
Object types = reportMetadata.get('reportType');
String reportType;

if (types instanceof Map<String, Object>) {
    // Only this case was handled
}
// reportType remained null if API returned a String!
```

**Impact**: When `reportType` remained null, the fallback mapping in `extractBaseObject()` couldn't work, causing the method to return null.

### 2. **Missing reportType Assignment**
**Issue**: Even if `reportType` was extracted, it was never assigned to `reportData.reportType`.
- The validation logic was commented out
- The extracted value wasn't stored in the ReportData object

### 3. **Silent Failure in extractBaseObject**
**Issue**: The method had three fallback mechanisms but no validation:
1. Try to get `baseObject` from metadata directly ❌ (usually not present)
2. Try to get `sobjectType` from metadata ❌ (usually not present)
3. Use fallback mapping from `reportType` ❌ (failed because reportType was null)
4. Return `null` silently ❌ (caused the crash later)

## Solutions Implemented

### 1. **Complete reportType Extraction** ✅
Added handling for all possible cases:
```apex
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
        reportType = typesMap.containsKey('label') ? String.valueOf(typesMap.get('label')) : null;
    }
}
// Case 3: types is a List of maps
else if (types instanceof List<Object>) {
    List<Object> typesList = (List<Object>) types;
    if (!typesList.isEmpty() && typesList.get(0) instanceof Map<String, Object>) {
        Map<String, Object> typesMap = (Map<String, Object>) typesList.get(0);
        reportType = String.valueOf(typesMap.get('type') ?? typesMap.get('label'));
    }
}
```

### 2. **Added reportType Validation & Assignment** ✅
```apex
// Validate reportType
validateReportType(reportType, reportId);
reportData.reportType = reportType;
```

This ensures:
- reportType is validated against unsupported types
- reportType is properly stored in the ReportData object
- Invalid reports are caught early with meaningful errors

### 3. **Added baseObject Extraction Validation** ✅
```apex
reportData.baseObject = extractBaseObject(reportType, reportMetadata);

// Validate that baseObject was successfully extracted
if (String.isBlank(reportData.baseObject)) {
    throw new ReportToSoqlException(
        ReportToSoqlException.ExceptionType.PARSING_ERROR,
        'Could not determine base object from report metadata. ' +
        'Checked: baseObject, sobjectType in metadata, and reportType mapping. ' +
        'ReportType: ' + reportType,
        'extractBaseObject',
        null
    );
}
```

### 4. **Enhanced Logging in extractBaseObject** ✅
```apex
system.debug('baseObject found in metadata: ' + objectName);
system.debug('baseObject derived from reportType mapping: ' + reportType + ' => ' + objectName);
system.debug('WARNING: Could not determine baseObject from reportType: ' + reportType + 
            ', metadata keys: ' + reportMetadata.keySet());
```

### 5. **Enhanced API Response Logging** ✅ (ReportApiClient.cls)
```apex
Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
system.debug('API Response - Full structure: ' + JSON.serializePretty(responseMap));

// Log the key fields to help debug baseObject extraction
if (responseMap.containsKey('reportMetadata')) {
    Map<String, Object> metadata = (Map<String, Object>) responseMap.get('reportMetadata');
    system.debug('API Response - reportMetadata keys: ' + metadata.keySet());
    system.debug('API Response - reportType: ' + metadata.get('reportType'));
    system.debug('API Response - baseObject: ' + metadata.get('baseObject'));
    system.debug('API Response - sobjectType: ' + metadata.get('sobjectType'));
}
```

This helps you see exactly what the Analytics API is returning and what the parser is extracting.

## Expected Flow Now

1. **API Response** → Salesforce Analytics `/describe` endpoint returns metadata
2. **reportType Extraction** → Properly handles String, Map, or List formats
3. **baseObject Extraction** → 
   - First tries direct metadata extraction
   - Falls back to reportType mapping
   - Throws meaningful error if none work
4. **Validation** → baseObject is guaranteed to be non-null before SecurityEnforcer.validateSecurityContext() is called

## Debug Steps if Issue Persists

1. Check the system debug logs for:
   - `API Response - reportMetadata keys:` to see what fields the API returns
   - `API Response - reportType:` to see the actual reportType value
   - `API Response - baseObject:` to see if baseObject exists in the API response

2. If `baseObject` is in the API response but still null:
   - Add the object name to the direct extraction in `extractBaseObject()`

3. If `reportType` is null:
   - Check the Analytics API response structure
   - The reportType might be nested differently than expected

## Files Modified
- [ReportMetadataParser.cls](force-app/main/default/classes/ReportMetadataParser.cls)
- [ReportApiClient.cls](force-app/main/default/classes/ReportApiClient.cls)
