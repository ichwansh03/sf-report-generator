@isTest(seeAllData = true)
class SchCaseSnapshotFCR_AFI_test {

   static testmethod void test() {
   Test.startTest();
  
      String jobId = System.schedule('SchCaseSnapshotFCR AFI Test',
      SchCaseSnapshotFCR_AFI.CRON_EXP, 
         new SchCaseSnapshotFCR_AFI());

   Test.stopTest();

   }
}