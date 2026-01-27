/**
 * @description       : 
 * @author            : Ahmad Yazid Munif
 * @group             : 
 * @last modified on  : 09-18-2025
 * @last modified by  : Ahmad Yazid Munif
**/
global class AMFS_DeleteDataLogEmailEFormBatch implements Database.Batchable<SObject> {
    global database.QueryLocator start(database.BatchableContext BC) {
        Date targetDelete = Date.today().addDays(-10);
        system.debug('TARGET TANGGAL LOG EFORM : ' + targetDelete);
        return Database.getQueryLocator([SELECT Id FROM E_Form_Log__c WHERE CreatedDate <=: targetDelete]);
    }

    global void execute(database.BatchableContext BC, List<SObject> scope) {
        System.debug('#### AMFS Log Email EForm yang akan dihapus: ' + scope.size());
        if(!scope.isEmpty()){
            Database.delete(scope);
        }
    }

    global void finish(database.BatchableContext BC) {
        system.debug('DELETE BATCH EFROM FINISHED');
    }

    // System.schedule('Delete EmailLog EForm', '0 0 19 * * ?', new AMFS_DeleteDataLogEmailEFormScheduler());
    public static void runBatch(){
        AMFS_DeleteDataLogEmailEFormBatch batchJob = new AMFS_DeleteDataLogEmailEFormBatch();
        Database.executeBatch(batchJob);
    }
}