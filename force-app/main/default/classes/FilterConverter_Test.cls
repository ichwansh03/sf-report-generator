/**
 * @description Test class for FilterConverter
 */
@isTest
private class FilterConverter_Test {
    
    @isTest
    static void testConvertFilterWithEqualsOperator() {
        Map<String, Object> filter = new Map<String, Object> {
            'id' => 1,
            'column' => 'Name',
            'operator' => 'equals',
            'value' => 'Test Account',
            'type' => 'text'
        };
        
        FilterConverter.FilterCondition condition = FilterConverter.convertFilter(filter, 'Account', null);
        
        Assert.areEqual(1, condition.filterId);
        Assert.isTrue(condition.soqlCondition.contains('Name'));
        Assert.isTrue(condition.soqlCondition.contains('='));
        Assert.isTrue(condition.soqlCondition.contains('Test Account'));
    }
    
    @isTest
    static void testConvertFilterWithInOperator() {
        Map<String, Object> filter = new Map<String, Object> {
            'id' => 1,
            'column' => 'Status',
            'operator' => 'in',
            'value' => 'Open,Closed,In Progress',
            'type' => 'picklist'
        };
        
        FilterConverter.FilterCondition condition = FilterConverter.convertFilter(filter, 'Case', null);
        
        Assert.isTrue(condition.soqlCondition.contains('IN'));
        Assert.isTrue(condition.soqlCondition.contains('('));
    }
    
    @isTest
    static void testSanitizeAndQuoteValue() {
        // Test string value
        String quoted = FilterConverter.sanitizeAndQuoteValue('Test');
        Assert.isTrue(quoted.startsWith('\''));
        Assert.isTrue(quoted.endsWith('\''));
    }
    
    @isTest
    static void testSanitizeNumericValue() {
        String numeric = FilterConverter.sanitizeAndQuoteValue('123');
        Assert.areEqual('123', numeric);
    }
    
    @isTest
    static void testIsoDateValue() {
        String isoDate = FilterConverter.sanitizeAndQuoteValue('2024-01-15');
        Assert.areEqual('2024-01-15', isoDate);
    }
    
    @isTest
    static void testInjectionAttemptDetection() {
        Map<String, Object> filter = new Map<String, Object> {
            'id' => 1,
            'column' => 'Name',
            'operator' => 'equals',
            'value' => 'Test\'; DROP TABLE Account; --',
            'type' => 'text'
        };
        
        try {
            FilterConverter.convertFilter(filter, 'Account', null);
            Assert.fail('Should have thrown exception for injection attempt');
        } catch (ReportToSoqlException e) {
            Assert.areEqual(ReportToSoqlException.ExceptionType.FILTER_ERROR, e.exceptionType);
        }
    }
    
    @isTest
    static void testUnknownOperatorError() {
        Map<String, Object> filter = new Map<String, Object> {
            'id' => 1,
            'column' => 'Name',
            'operator' => 'unknown_operator',
            'value' => 'Test',
            'type' => 'text'
        };
        
        try {
            FilterConverter.convertFilter(filter, 'Account', null);
            Assert.fail('Should have thrown exception for unknown operator');
        } catch (ReportToSoqlException e) {
            Assert.areEqual(ReportToSoqlException.ExceptionType.FILTER_ERROR, e.exceptionType);
        }
    }
    
    @isTest
    static void testRelativeDateLiteral() {
        Map<String, Object> filter = new Map<String, Object> {
            'id' => 1,
            'column' => 'CreatedDate',
            'operator' => 'gte',
            'value' => 'LAST_N_DAYS:30',
            'type' => 'date'
        };
        
        FilterConverter.FilterCondition condition = FilterConverter.convertFilter(filter, 'Account', null);
        Assert.isTrue(condition.soqlCondition.contains('LAST_N_DAYS:30'));
    }
}