@isTest
public class SchICFSendMonthlyReport_Test {
	public static testmethod void sendingTest(){
        Test.StartTest();
        SchICFSendMonthlyReport psr = new SchICFSendMonthlyReport();
        psr.execute(null);
        Test.StopTest();
    }
}