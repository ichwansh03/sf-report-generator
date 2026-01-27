/**
 * @description       : 
 * @author            : Muh Syafiq Hidayatullah
 * @group             : 
 * @last modified on  : 15-07-2025
 * @last modified by  : Muh Syafiq Hidayatullah
**/
public without sharing class AMFS_SignatureUploadController {
    @AuraEnabled
    public static String uploadSignature(String fileData, String fileName, Id SigLogBookActivityDetailId) {
        try {
            if (String.isBlank(fileData)) {
                throw new AuraHandledException('Data kosong.');
            }

            ContentVersion cv = new ContentVersion();
            cv.Title = fileName;
            cv.PathOnClient = '/' + fileName;
            cv.VersionData = EncodingUtil.base64Decode(fileData);
            cv.firstPublishLocationId= UserInfo.getUserId();
            insert cv;
            
            // Query for Content Document Id from Content Version
            Id cdId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id].ContentDocumentId;
    
            ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.ContentDocumentId = cdId;
            cdl.LinkedEntityId = SigLogBookActivityDetailId;
            cdl.ShareType = 'V'; // Viewer
            cdl.Visibility = 'AllUsers';
            insert cdl;
            
            List<Log_Book_Activitiy_Detail__c> lbads = new List<Log_Book_Activitiy_Detail__c>();
            Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Sign_ID__c FROM Log_Book_Activitiy_Detail__c WHERE Id = : SigLogBookActivityDetailId LIMIT 1];
            lbad.Sign_ID__c = cv.Id;
            lbads.add(lbad);

            if(!lbads.isEmpty()){
                update lbads;
            }
            return cdId;
        } catch (Exception e) {
            // Handle for error
            throw new AuraHandledException('Error uploading file: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static void deleteFile(Id cdId) {
        try {
            ContentDocument cd = [SELECT Id FROM ContentDocument WHERE Id = :cdId LIMIT 1];
            system.debug('Ini cd: ' + cd);
            delete cd;
        } catch (Exception e) {
            throw new AuraHandledException('Gagal menghapus file: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static String nameOfPolicyNumber(Id SigLogBookActivityDetailId){
        try {
            Log_Book_Activitiy_Detail__c eForm = [SELECT id, Policy_Number__c FROM Log_Book_Activitiy_Detail__c WHERE id = :SigLogBookActivityDetailId LIMIT 1];
            String pulNum = eForm.Policy_Number__c;
            if(pulNum!=null){
                return pulNum;
            }
            else{
                return 'Null Policy Number';
            }
        } catch (Exception e) {
            throw new AuraHandledException('Error Get Record: '+e.getMessage());
        }
    }
}