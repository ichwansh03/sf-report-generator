/**
 * @description Test class for SchemaValidator
 */
@isTest
private class SchemaValidator_Test {
    
    @isTest
    static void testValidateDirectField() {
        SchemaValidator.FieldDefinition fieldDef = SchemaValidator.validateField('Account', 'Name');
        
        Assert.isNotNull(fieldDef);
        Assert.areEqual('Name', fieldDef.fieldName);
        Assert.isTrue(fieldDef.isAccessible);
        Assert.isTrue(fieldDef.isQueryable);
    }
    
    @isTest
    static void testValidateIdField() {
        SchemaValidator.FieldDefinition fieldDef = SchemaValidator.validateField('Account', 'Id');
        
        Assert.isNotNull(fieldDef);
        Assert.areEqual('Id', fieldDef.fieldName);
        Assert.isTrue(fieldDef.isAccessible);
    }
    
    @isTest
    static void testValidateNonExistentField() {
        try {
            SchemaValidator.validateField('Account', 'NonExistentField__c');
            Assert.fail('Should have thrown exception for non-existent field');
        } catch (ReportToSoqlException e) {
            Assert.areEqual(ReportToSoqlException.ExceptionType.FIELD_NOT_FOUND, e.exceptionType);
        }
    }
    
    @isTest
    static void testValidateNonExistentObject() {
        try {
            SchemaValidator.validateField('NonExistentObject__c', 'Name');
            Assert.fail('Should have thrown exception for non-existent object');
        } catch (ReportToSoqlException e) {
            Assert.areEqual(ReportToSoqlException.ExceptionType.OBJECT_NOT_FOUND, e.exceptionType);
        }
    }
    
    @isTest
    static void testValidateObjectAccess() {
        // Should not throw exception for standard accessible object
        SchemaValidator.validateObjectAccess('Account');
    }
    
    @isTest
    static void testValidateObjectAccessFails() {
        try {
            SchemaValidator.validateObjectAccess('NonExistentObject__c');
            Assert.fail('Should have thrown exception');
        } catch (ReportToSoqlException e) {
            Assert.areEqual(ReportToSoqlException.ExceptionType.OBJECT_NOT_FOUND, e.exceptionType);
        }
    }
    
    @isTest
    static void testValidateMultipleFields() {
        List<String> fieldNames = new List<String> { 'Name', 'Phone', 'Website' };
        Map<String, SchemaValidator.FieldDefinition> validFields = 
            SchemaValidator.validateMultipleFields('Account', fieldNames);
        
        Assert.isNotNull(validFields);
        Assert.isTrue(validFields.size() > 0);
        Assert.isTrue(validFields.containsKey('Name'));
    }
    
    @isTest
    static void testValidateRelationshipField() {
        // Test Account.Owner relationship
        SchemaValidator.FieldDefinition fieldDef = SchemaValidator.validateField('Account', 'OwnerId');
        
        Assert.isNotNull(fieldDef);
        Assert.areEqual('OwnerId', fieldDef.fieldName);
    }
    
    @isTest
    static void testValidateBlankFieldName() {
        try {
            SchemaValidator.validateField('Account', '');
            Assert.fail('Should have thrown exception for blank field name');
        } catch (ReportToSoqlException e) {
            Assert.areEqual(ReportToSoqlException.ExceptionType.VALIDATION_ERROR, e.exceptionType);
        }
    }
}