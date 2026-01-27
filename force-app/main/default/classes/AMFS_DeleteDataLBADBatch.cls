/**
 * @description       : 
 * @author            : Muh Syafiq Hidayatullah
 * @group             : 
 * @last modified on  : 11-07-2025
 * @last modified by  : Muh Syafiq Hidayatullah
**/
global class AMFS_DeleteDataLBADBatch implements Database.Batchable<SObject> {
    global database.QueryLocator start(database.BatchableContext BC) {
        Date targetDelete = Date.today().addDays(-30);
        system.debug('TARGET TANGGAL LBAD : ' + targetDelete);
        // return Database.getQueryLocator([SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE DAY_ONLY(CreatedDate) =: targetDelete AND EForm__c = TRUE]);
        return Database.getQueryLocator([SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE CreatedDate <=: targetDelete AND EForm__c = TRUE]);
    }

    global void execute(database.BatchableContext BC, List<SObject> scope) {
        List<String> lbadId = new List<String>();
        for(SObject s : scope){
            Log_Book_Activitiy_Detail__c lbad = (Log_Book_Activitiy_Detail__c)s;
            lbadId.add(lbad.Id);
        }
        system.debug('TOTAL LBAD :'+ lbadId.size());
        // Query File di LBAD
        List<ContentDocumentLink> fileLbad = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId IN: lbadId];
        List<String> cdIdFileLbad = new List<String>();
        if(!fileLbad.isEmpty()){
            for(ContentDocumentLink cdl : fileLbad){
                cdIdFileLbad.add(cdl.ContentDocumentId);
            }
            List<ContentDocument> cdFileLbad = [SELECT Id FROM ContentDocument WHERE Id IN: cdIdFileLbad];
            // Delete File LABD
            if(!cdFileLbad.isEmpty()){
                system.debug('FILE LBAD :'+ cdFileLbad);
                system.debug('TOTAL FILE LBAD :'+ cdFileLbad.size());
                Database.delete(cdFileLbad);
                system.debug('------');
            }
        }
    }

    global void finish(database.BatchableContext BC) {
        system.debug('DELETE BATCH LBAD FINISHED');
    }

    public static void runBatch(){
        AMFS_DeleteDataLBADBatch batchJob = new AMFS_DeleteDataLBADBatch();
        Database.executeBatch(batchJob);
    }
}