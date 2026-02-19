/**
 * @description Test class for ReportToSoqlException
 */
@isTest
private class ReportToSoqlException_Test {
    
    @isTest
    static void testExceptionCreation() {
        ReportToSoqlException e = new ReportToSoqlException(
            ReportToSoqlException.ExceptionType.API_ERROR,
            'Test message'
        );
        
        Assert.areEqual(ReportToSoqlException.ExceptionType.API_ERROR, e.exceptionType);
        Assert.areEqual('Test message', e.getMessage());
    }
    
    @isTest
    static void testExceptionWithContext() {
        ReportToSoqlException e = new ReportToSoqlException(
            ReportToSoqlException.ExceptionType.PARSING_ERROR,
            'Parse failed',
            'detailColumns'
        );
        
        Assert.areEqual(ReportToSoqlException.ExceptionType.PARSING_ERROR, e.exceptionType);
        Assert.areEqual('detailColumns', e.context);
    }
    
    @isTest
    static void testGetFullErrorMessage() {
        ReportToSoqlException e = new ReportToSoqlException(
            ReportToSoqlException.ExceptionType.SECURITY_ERROR,
            'No access',
            'Account',
            '00O1X000000IZkUAW'
        );
        
        String fullMsg = e.getFullErrorMessage();
        Assert.isTrue(fullMsg.contains('SECURITY_ERROR'));
        Assert.isTrue(fullMsg.contains('No access'));
        Assert.isTrue(fullMsg.contains('Account'));
        Assert.isTrue(fullMsg.contains('00O1X000000IZkUAW'));
    }
}