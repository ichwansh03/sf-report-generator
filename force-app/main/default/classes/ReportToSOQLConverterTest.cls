@isTest
private class ReportToSOQLConverterTest {

    @isTest
    static void testFullFlowWithTernary() {
        String mockJSON = '{' +
            '"detailColumns": ["Name", "Status"],' +
            '"reportType": {"label": "Case"},' +
            '"reportFilters": [' +
                '{"column": "Status", "operator": "equals", "value": "New"},' +
                '{"column": "Subject", "operator": "contains", "value": "Test"}' +
            ']' +
        '}';
        
        ReportToSOQLConverter.testMetadata = (Reports.ReportMetadata)JSON.deserialize(mockJSON, Reports.ReportMetadata.class);

        Test.startTest();
        String result = ReportToSOQLConverter.getSOQLFromReport('00O000000000000AAA');
        Test.stopTest();

        System.assert(result.contains('SELECT Name, Status'), 'SELECT salah');
    }

    @isTest
    static void testEmptyFilters() {
        String mockJSON = '{"detailColumns": ["Id"], "reportType": {"label": "Account"}, "reportFilters": []}';
        ReportToSOQLConverter.testMetadata = (Reports.ReportMetadata)JSON.deserialize(mockJSON, Reports.ReportMetadata.class);

    }
    
    @isTest
    static void testOperatorFallback() {
        System.assertEquals('=', ReportToSOQLConverter.convertOperator('unknown_operator'));
    }
}