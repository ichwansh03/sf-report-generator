/**
 * @description       : 
 * @author            : Muh Syafiq Hidayatullah
 * @group             : 
 * @last modified on  : 16-07-2025
 * @last modified by  : Muh Syafiq Hidayatullah
**/
global class AMFS_DeleteDataLBADScheduler implements Schedulable{
    global void execute(SchedulableContext SC) {
        AMFS_DeleteDataEFormBatch batchEform = new AMFS_DeleteDataEFormBatch();
        Database.executeBatch(batchEform,100);
    }
}