@isTest 
public class PolicyDetailPagingALITest{   
    static testMethod void myUnitTest() {

        Test.startTest();
        PolicyDetailPagingALI tsk = new PolicyDetailPagingALI();
                
        tsk.idparam = '';
        tsk.index = 1;
        tsk.blockSize = 1;
        tsk.totalRecs = 1;
        tsk.totalAllRecs = 1;
        tsk.filcampname = '';
        tsk.filcallstatus = '';
        tsk.SOQL = '';
        tsk.PaymentView = FALSE;
        tsk.CallNoteView = FALSE;
        tsk.ClaimView = FALSE;
        tsk.PolicyHistoryView = FALSE;
                
        Test.stopTest();
    }
}