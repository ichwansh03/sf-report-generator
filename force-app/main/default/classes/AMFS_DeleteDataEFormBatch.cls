/**
 * @description       : 
 * @author            : Muh Syafiq Hidayatullah
 * @group             : 
 * @last modified on  : 11-07-2025
 * @last modified by  : Muh Syafiq Hidayatullah
**/
global class AMFS_DeleteDataEFormBatch implements Database.Batchable<SObject> {
    global database.QueryLocator start(database.BatchableContext BC) {
        Date targetDelete = Date.today().addDays(-30);
        system.debug('TARGET TANGGAL EFORM : ' + targetDelete);
        // return Database.getQueryLocator([SELECT Id FROM E_Form_Master_Data__c WHERE DAY_ONLY(CreatedDate) =: targetDelete]);
        return Database.getQueryLocator([SELECT Id FROM E_Form_Master_Data__c WHERE CreatedDate <=: targetDelete]);
    }

    global void execute(database.BatchableContext BC, List<SObject> scope) {
        List<String> eformId = new List<String>();
        for(SObject s : scope){
            E_Form_Master_Data__c efmd = (E_Form_Master_Data__c)s;
            eformId.add(efmd.Id);
        }
        system.debug('TOTAL EFORM :'+ eformId.size());
        // Query File di Eform
        List<ContentDocumentLink> fileEform = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId IN: eformId];
        List<String> cdIdFileEform = new List<String>();
        if(!fileEform.isEmpty()){
            for(ContentDocumentLink cdl : fileEform){
                cdIdFileEform.add(cdl.ContentDocumentId);
            }
            List<ContentDocument> cdFileEform = [SELECT Id FROM ContentDocument WHERE Id IN: cdIdFileEform];
            // Delete File Eform
            if(!cdFileEform.isEmpty()){
                system.debug('FILE EFORM :'+ cdFileEform);
                system.debug('TOTAL FILE EFORM :'+ cdFileEform.size());
                Database.delete(cdFileEform);
                system.debug('------');
            }
        }

        List<E_Form_Master_Data__c> listEform = [SELECT Id FROM E_Form_Master_Data__c WHERE Id IN: eformId];
        // Delete Eform
        if(!listEform.isEmpty()){
            system.debug('LIST EFORM :'+ listEform);
            system.debug('TOTAL LIST EFORM :'+ listEform.size());
            Database.delete(listEform);
            system.debug('------');
        }
    }

    global void finish(database.BatchableContext BC) {
        system.debug('DELETE BATCH EFROM FINISHED');
        AMFS_DeleteDataLBADBatch batchLBAD = new AMFS_DeleteDataLBADBatch();
        Database.executeBatch(batchLBAD,100);
    }

    public static void runBatch(){
        AMFS_DeleteDataEFormBatch batchJob = new AMFS_DeleteDataEFormBatch();
        Database.executeBatch(batchJob);
    }
}