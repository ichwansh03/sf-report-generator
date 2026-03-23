@isTest
private class ReportToSOQLConverterTest {

    @isTest
    static void testFullFlowWithTernary() {
        String mockJSON = '{' +
            '"detailColumns": ["Name", "Status", "CreatedBy.Name"],' +
            '"reportType": {"label": "Case"},' +
            '"reportFilters": [' +
                '{"column": "Status", "operator": "equals", "value": "New"},' +
                '{"column": "Subject", "operator": "contains", "value": "Test"},' +
                '{"column": "Owner", "operator": "equals", "value": "Test1, Test2, Test3"}' +            
            ']' +
            '}';
        String mockJSON2 = '{"detailColumns": ["Id"], "reportType": {"label": "Account"}, "reportFilters": []}';
        ReportToSOQLConverter.testMetadata = (Reports.ReportMetadata)JSON.deserialize(mockJSON, Reports.ReportMetadata.class);

        Test.startTest();
        String result = ReportToSOQLConverter.getSOQLFromReport('00O000000000000AAA');
        
        ReportToSOQLConverter.testMetadata = (Reports.ReportMetadata)JSON.deserialize(mockJSON2, Reports.ReportMetadata.class);
        Test.stopTest();

        System.assert(result.contains('SELECT Name, Status'), 'SELECT salah');
        System.assertEquals('=', ReportToSOQLConverter.convertOperator('unknown_operator'));
    }

}