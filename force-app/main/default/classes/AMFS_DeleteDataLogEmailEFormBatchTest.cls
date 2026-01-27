/**
 * @description       : AMFS_DeleteDataLogEmailEFormBatch
 * @author            : Ahmad Yazid Munif
 * @group             : 
 * @last modified on  : 09-15-2025
 * @last modified by  : Ahmad Yazid Munif
**/
@isTest
private class AMFS_DeleteDataLogEmailEFormBatchTest {

    @isTest
    static void testBatchDeleteOldLogs() {
        List<E_Form_Log__c> logsToDelete = new List<E_Form_Log__c>();
        List<E_Form_Log__c> logsToKeep = new List<E_Form_Log__c>();
        
        for (Integer i = 0; i < 10; i++) {
            logsToDelete.add(new E_Form_Log__c());
        }

        for (Integer i = 0; i < 5; i++) {
            logsToKeep.add(new E_Form_Log__c());
        }

        insert logsToDelete;
        insert logsToKeep;

        for (E_Form_Log__c log : logsToDelete) {
            Test.setCreatedDate(log.Id, System.now().addDays(-31));
        }
        
        for (E_Form_Log__c log : logsToKeep) {
            Test.setCreatedDate(log.Id, System.now());
        }
        
        Test.startTest();
        
        AMFS_DeleteDataLogEmailEFormBatch batchJob = new AMFS_DeleteDataLogEmailEFormBatch();
        Database.executeBatch(batchJob, 200);
        AMFS_DeleteDataLogEmailEFormBatch.runBatch();

        AMFS_DeleteDataLogEmailEFormScheduler scheduler = new AMFS_DeleteDataLogEmailEFormScheduler();
        scheduler.execute(null);
        
        Test.stopTest();

        Integer remainingLogs = [SELECT COUNT() FROM E_Form_Log__c];
        
        System.assertEquals(5, remainingLogs, 'Hanya record yang dibuat dalam 30 hari terakhir yang harus tersisa.');
    }
}