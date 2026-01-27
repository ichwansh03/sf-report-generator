@isTest(seeAllData = true)
class SchCaseSnapshotFCR_test {

   static testmethod void test() {
   Test.startTest();
  
      String jobId = System.schedule('SchCaseSnapshotFCR Test',
      SchCaseSnapshotFCR.CRON_EXP, 
         new SchCaseSnapshotFCR());

   Test.stopTest();

   }
}