/**
 * @description       : 
 * @author            : Ahmad Yazid Munif
 * @group             : 
 * @last modified on  : 09-18-2025
 * @last modified by  : Ahmad Yazid Munif
**/
global class AMFS_DeleteDataLogEmailEFormScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        AMFS_DeleteDataLogEmailEFormBatch batchJob = new AMFS_DeleteDataLogEmailEFormBatch();
        Database.executeBatch(batchJob,100);
    }
}