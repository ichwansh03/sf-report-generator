@isTest
public class CaseClaimCashlessSch_Test {
    static testMethod void TestClass(){
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        Test.startTest();
        CaseClaimCashlessSch sch = new CaseClaimCashlessSch();
        sch.execute(null);
        Test.stopTest();
    }

}