/**
 * @description Test class for SoqlQueryBuilder
 */
@isTest
private class SoqlQueryBuilder_Test {
    
    @isTest
    static void testBuildSimpleSelectQuery() {
        ReportMetadataParser.ReportData reportData = new ReportMetadataParser.ReportData();
        reportData.baseObject = 'Account';
        reportData.reportType = 'AccountList';
        reportData.detailColumns = new List<String> { 'Name', 'Phone' };
        reportData.reportFilters = new List<Map<String, Object>>();
        reportData.reportBooleanFilter = '1';
        
        String soqlQuery = SoqlQueryBuilder.buildSoqlQuery(reportData, '00O1X000000IZkUAW');
        
        Assert.isNotNull(soqlQuery);
        Assert.isTrue(soqlQuery.startsWith('SELECT'));
        Assert.isTrue(soqlQuery.contains('FROM Account'));
        Assert.isTrue(soqlQuery.contains('Name'));
    }
    
    @isTest
    static void testBuildQueryWithoutColumns() {
        ReportMetadataParser.ReportData reportData = new ReportMetadataParser.ReportData();
        reportData.baseObject = 'Account';
        reportData.reportType = 'AccountList';
        reportData.detailColumns = new List<String>();
        reportData.reportFilters = new List<Map<String, Object>>();
        reportData.reportBooleanFilter = '1';
        
        String soqlQuery = SoqlQueryBuilder.buildSoqlQuery(reportData, '00O1X000000IZkUAW');
        
        Assert.isNotNull(soqlQuery);
        Assert.isTrue(soqlQuery.contains('SELECT Id'));
        Assert.isTrue(soqlQuery.contains('FROM Account'));
    }
    
    @isTest
    static void testBuildQueryWithoutFilters() {
        ReportMetadataParser.ReportData reportData = new ReportMetadataParser.ReportData();
        reportData.baseObject = 'Contact';
        reportData.reportType = 'ContactList';
        reportData.detailColumns = new List<String> { 'FirstName', 'LastName', 'Email' };
        reportData.reportFilters = new List<Map<String, Object>>();
        reportData.reportBooleanFilter = '1';
        
        String soqlQuery = SoqlQueryBuilder.buildSoqlQuery(reportData, '00O1X000000IZkUAW');
        
        Assert.isNotNull(soqlQuery);
        Assert.isTrue(soqlQuery.contains('FROM Contact'));
        Assert.isFalse(soqlQuery.contains('WHERE'));
    }
    
    @isTest
    static void testNullBaseObjectThrowsException() {
        ReportMetadataParser.ReportData reportData = new ReportMetadataParser.ReportData();
        reportData.baseObject = null;
        reportData.reportType = 'AccountList';
        reportData.detailColumns = new List<String>();
        reportData.reportFilters = new List<Map<String, Object>>();
        
        try {
            SoqlQueryBuilder.buildSoqlQuery(reportData, '00O1X000000IZkUAW');
            Assert.fail('Should have thrown exception for null baseObject');
        } catch (ReportToSoqlException e) {
            Assert.areEqual(ReportToSoqlException.ExceptionType.VALIDATION_ERROR, e.exceptionType);
        }
    }
    
    @isTest
    static void testNullReportDataThrowsException() {
        try {
            SoqlQueryBuilder.buildSoqlQuery(null, '00O1X000000IZkUAW');
            Assert.fail('Should have thrown exception for null reportData');
        } catch (ReportToSoqlException e) {
            Assert.areEqual(ReportToSoqlException.ExceptionType.SOQL_GENERATION_ERROR, e.exceptionType);
        }
    }
    
    @isTest
    static void testQueryStructureValidation() {
        ReportMetadataParser.ReportData reportData = new ReportMetadataParser.ReportData();
        reportData.baseObject = 'Account';
        reportData.reportType = 'AccountList';
        reportData.detailColumns = new List<String> { 'Name' };
        reportData.reportFilters = new List<Map<String, Object>>();
        reportData.reportBooleanFilter = '1';
        
        String soqlQuery = SoqlQueryBuilder.buildSoqlQuery(reportData, '00O1X000000IZkUAW');
        
        // Verify basic SOQL structure
        Assert.isTrue(soqlQuery.toUpperCase().startsWith('SELECT'));
        Assert.isTrue(soqlQuery.toUpperCase().contains('FROM'));
        
        // Verify no DML operations
        Assert.isFalse(soqlQuery.toUpperCase().contains('INSERT'));
        Assert.isFalse(soqlQuery.toUpperCase().contains('UPDATE'));
        Assert.isFalse(soqlQuery.toUpperCase().contains('DELETE'));
    }
}