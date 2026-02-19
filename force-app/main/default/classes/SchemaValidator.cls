/**
 * @description Validates fields, relationships, and schema metadata using Schema.DescribeFieldResult.
 * Ensures field-level security and resolves relationship fields.
 */
public class SchemaValidator {
    
    /**
     * @description Represents validated field information
     */
    public class FieldDefinition {
        public String fieldName { get; set; }
        public String displayType { get; set; }
        public Boolean isAccessible { get; set; }
        public Boolean isFilterable { get; set; }
        public Boolean isQueryable { get; set; }
        public String relationshipName { get; set; }
    }
    
    private static final Map<String, Schema.SObjectType> GLOBAL_DESCRIBE = Schema.getGlobalDescribe();
    
    /**
     * @description Validates that a field exists on the object and is accessible
     * @param objectName The SObject API name
     * @param fieldName The field API name (supports relationship notation)
     * @return The validated field definition
     * @throws ReportToSoqlException on validation errors
     */
    public static FieldDefinition validateField(String objectName, String fieldName) {
        if (String.isBlank(objectName) || String.isBlank(fieldName)) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.VALIDATION_ERROR,
                'Object name and field name cannot be blank'
            );
        }
        
        try {
            // Handle relationship fields (e.g., Account.Owner.Email)
            if (fieldName.contains('.')) {
                return validateRelationshipField(objectName, fieldName);
            }
            
            return validateDirectField(objectName, fieldName);
            
        } catch (ReportToSoqlException e) {
            throw e;
        } catch (Exception e) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.FIELD_NOT_FOUND,
                'Error validating field ' + fieldName + ' on ' + objectName + ': ' + e.getMessage(),
                fieldName + ' on ' + objectName
            );
        }
    }
    
    /**
     * @description Validates a direct field on the object
     */
    private static FieldDefinition validateDirectField(String objectName, String fieldName) {
        Schema.SObjectType objType = GLOBAL_DESCRIBE.get(objectName);
        
        if (objType == null) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.OBJECT_NOT_FOUND,
                'Object not found: ' + objectName
            );
        }
        
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        Map<String, Schema.SObjectField> fields = objDescribe.fields.getMap();
        
        // Try exact match first (case-insensitive in Salesforce)
        Schema.SObjectField field = fields.get(fieldName);
        
        if (field == null) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.FIELD_NOT_FOUND,
                'Field not found: ' + fieldName + ' on object ' + objectName,
                fieldName
            );
        }
        
        Schema.DescribeFieldResult fieldDescribe = field.getDescribe();
        
        // Check field-level security
        if (!fieldDescribe.isAccessible()) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.SECURITY_ERROR,
                'No field-level read access to ' + fieldName + ' on ' + objectName,
                fieldName
            );
        }
        
        // Build field definition
        FieldDefinition fieldDef = new FieldDefinition();
        fieldDef.fieldName = fieldName;
        fieldDef.displayType = String.valueOf(fieldDescribe.getType());
        fieldDef.isAccessible = fieldDescribe.isAccessible();
        fieldDef.isFilterable = fieldDescribe.isFilterable();
        fieldDef.isQueryable = fieldDescribe.isAccessible();
        
        // Get relationship name if this is a lookup/master-detail
        if (fieldDescribe.getType() == Schema.DisplayType.REFERENCE) {
            List<Schema.SObjectType> references = fieldDescribe.getReferenceTo();
            if (references != null && !references.isEmpty()) {
                fieldDef.relationshipName = fieldDescribe.getRelationshipName();
            }
        }
        
        return fieldDef;
    }
    
    /**
     * @description Validates a relationship field (e.g., Account.Owner.Email)
     */
    private static FieldDefinition validateRelationshipField(String objectName, String fieldPath) {
        String[] pathParts = fieldPath.split('\\.');
        
        String currentObject = objectName;
        String currentPath = '';
        
        // Traverse the relationship hierarchy
        for (Integer i = 0; i < pathParts.size(); i++) {
            String part = pathParts[i];
            currentPath += (currentPath == '' ? '' : '.') + part;
            
            FieldDefinition fieldDef = validateDirectField(currentObject, part);
            
            // If this is the last part of the path, return it
            if (i == pathParts.size() - 1) {
                fieldDef.fieldName = fieldPath;
                return fieldDef;
            }
            
            // If not the last part, this must be a relationship field
            if (String.isBlank(fieldDef.relationshipName)) {
                throw new ReportToSoqlException(
                    ReportToSoqlException.ExceptionType.VALIDATION_ERROR,
                    'Cannot traverse relationship through non-reference field: ' + part,
                    fieldPath
                );
            }
            
            // Get the related object for the next iteration
            Schema.SObjectType objType = GLOBAL_DESCRIBE.get(currentObject);
            Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
            Map<String, Schema.SObjectField> fields = objDescribe.fields.getMap();
            Schema.DescribeFieldResult fieldDescribe = fields.get(part).getDescribe();
            
            List<Schema.SObjectType> references = fieldDescribe.getReferenceTo();
            if (references.isEmpty()) {
                throw new ReportToSoqlException(
                    ReportToSoqlException.ExceptionType.VALIDATION_ERROR,
                    'Field is not a valid relationship: ' + part,
                    fieldPath
                );
            }
            
            currentObject = references[0].getDescribe().getName();
        }
        
        throw new ReportToSoqlException(
            ReportToSoqlException.ExceptionType.VALIDATION_ERROR,
            'Invalid field path: ' + fieldPath,
            fieldPath
        );
    }
    
    /**
     * @description Validates that the object is readable (object-level security)
     * @param objectName The SObject API name
     * @throws ReportToSoqlException if object is not accessible
     */
    public static void validateObjectAccess(String objectName) {
        if (String.isBlank(objectName)) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.VALIDATION_ERROR,
                'Object name cannot be blank'
            );
        }
        
        Schema.SObjectType objType = GLOBAL_DESCRIBE.get(objectName);
        
        if (objType == null) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.OBJECT_NOT_FOUND,
                'Object not found: ' + objectName
            );
        }
        
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        
        if (!objDescribe.isAccessible()) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.SECURITY_ERROR,
                'No object-level read access to ' + objectName
            );
        }
        
        if (!objDescribe.isQueryable()) {
            throw new ReportToSoqlException(
                ReportToSoqlException.ExceptionType.SECURITY_ERROR,
                'Object is not queryable: ' + objectName
            );
        }
    }
    
    /**
     * @description Validates multiple fields and returns a map of valid fields
     * @param objectName The SObject API name
     * @param fieldNames List of field API names
     * @return Map of valid field names to their definitions
     */
    public static Map<String, FieldDefinition> validateMultipleFields(String objectName, List<String> fieldNames) {
        Map<String, FieldDefinition> validFields = new Map<String, FieldDefinition>();
        
        if (fieldNames == null || fieldNames.isEmpty()) {
            return validFields;
        }
        
        for (String fieldName : fieldNames) {
            try {
                FieldDefinition fieldDef = validateField(objectName, fieldName);
                validFields.put(fieldName, fieldDef);
            } catch (ReportToSoqlException e) {
                // Log but continue - not all report columns may be relevant
                System.debug(LoggingLevel.WARN, 'Field validation failed: ' + e.getFullErrorMessage());
            }
        }
        
        return validFields;
    }
}