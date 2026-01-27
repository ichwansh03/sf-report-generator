@isTest(seeAllData = true)
class SchCaseSnapshotFCR_MAGI_test {

   static testmethod void test() {
   Test.startTest();
  
      String jobId = System.schedule('SchCaseSnapshotFCR MAGI Test',
      SchCaseSnapshotFCR_MAGI.CRON_EXP, 
         new SchCaseSnapshotFCR_MAGI());

   Test.stopTest();

   }
}