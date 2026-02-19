/**
 * @description Test class for ReportMetadataParser
 */
@isTest
private class ReportMetadataParser_Test {
    
    @isTest
    static void testParseValidReportResponse() {
        Map<String, Object> apiResponse = new Map<String, Object> {
            'reportMetadata' => new Map<String, Object> {
                'reportType' => 'AccountList',
                'reportBooleanFilter' => '1 AND (2 OR 3)',
                'reportFilters' => new List<Object> {
                    new Map<String, Object> {
                        'id' => 1,
                        'column' => 'Name',
                        'operator' => 'equals',
                        'value' => 'Test'
                    }
                },
                'detailColumns' => new List<Object> { 'Name', 'Phone', 'Website' },
                'baseObject' => 'Account'
            }
        };
        
        ReportMetadataParser.ReportData reportData = 
            ReportMetadataParser.parseReportResponse(apiResponse, '00O1X000000IZkUAW');
        
        Assert.isNotNull(reportData);
        Assert.areEqual('AccountList', reportData.reportType);
        Assert.areEqual('1 AND (2 OR 3)', reportData.reportBooleanFilter);
        Assert.areEqual('Account', reportData.baseObject);
        Assert.areEqual(1, reportData.reportFilters.size());
        Assert.areEqual(3, reportData.detailColumns.size());
    }
    
    @isTest
    static void testParseWithNullMetadata() {
        Map<String, Object> apiResponse = new Map<String, Object> {
            'reportMetadata' => null
        };
        
        try {
            ReportMetadataParser.parseReportResponse(apiResponse, '00O1X000000IZkUAW');
            Assert.fail('Should have thrown exception for null metadata');
        } catch (ReportToSoqlException e) {
            Assert.areEqual(ReportToSoqlException.ExceptionType.PARSING_ERROR, e.exceptionType);
        }
    }
    
    @isTest
    static void testParseWithUnsupportedReportType() {
        Map<String, Object> apiResponse = new Map<String, Object> {
            'reportMetadata' => new Map<String, Object> {
                'reportType' => 'MatrixReport',
                'reportFilters' => new List<Object>(),
                'detailColumns' => new List<Object>()
            }
        };
        
        try {
            ReportMetadataParser.parseReportResponse(apiResponse, '00O1X000000IZkUAW');
            Assert.fail('Should have thrown exception for unsupported report type');
        } catch (ReportToSoqlException e) {
            Assert.areEqual(ReportToSoqlException.ExceptionType.UNSUPPORTED_REPORT_TYPE, e.exceptionType);
        }
    }
    
    @isTest
    static void testParseWithEmptyFiltersAndColumns() {
        Map<String, Object> apiResponse = new Map<String, Object> {
            'reportMetadata' => new Map<String, Object> {
                'reportType' => 'AccountList',
                'reportBooleanFilter' => null,
                'reportFilters' => new List<Object>(),
                'detailColumns' => new List<Object>(),
                'baseObject' => 'Account'
            }
        };
        
        ReportMetadataParser.ReportData reportData = 
            ReportMetadataParser.parseReportResponse(apiResponse, '00O1X000000IZkUAW');
        
        Assert.isNotNull(reportData);
        Assert.areEqual('1', reportData.reportBooleanFilter); // Default value
        Assert.areEqual(0, reportData.reportFilters.size());
        Assert.areEqual(0, reportData.detailColumns.size());
    }
    
    @isTest
    static void testParseWithMultipleFilters() {
        Map<String, Object> apiResponse = new Map<String, Object> {
            'reportMetadata' => new Map<String, Object> {
                'reportType' => 'ContactList',
                'reportBooleanFilter' => '1 AND 2',
                'reportFilters' => new List<Object> {
                    new Map<String, Object> {
                        'id' => 1,
                        'column' => 'FirstName',
                        'operator' => 'contains',
                        'value' => 'John'
                    },
                    new Map<String, Object> {
                        'id' => 2,
                        'column' => 'LastName',
                        'operator' => 'contains',
                        'value' => 'Doe'
                    }
                },
                'detailColumns' => new List<Object>(),
                'baseObject' => 'Contact'
            }
        };
        
        ReportMetadataParser.ReportData reportData = 
            ReportMetadataParser.parseReportResponse(apiResponse, '00O1X000000IZkUAW');
        
        Assert.areEqual('ContactList', reportData.reportType);
        Assert.areEqual(2, reportData.reportFilters.size());
        Assert.areEqual('Contact', reportData.baseObject);
    }
}