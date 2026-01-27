@isTest(seeAllData = true)
class SchCaseSnapshotFCR_AMFS_test {

   static testmethod void test() {
   Test.startTest();
  
      String jobId = System.schedule('SchCaseSnapshotFCR AMFS Test',
      SchCaseSnapshotFCR_AMFS.CRON_EXP, 
         new SchCaseSnapshotFCR_AMFS());

   Test.stopTest();

   }
}