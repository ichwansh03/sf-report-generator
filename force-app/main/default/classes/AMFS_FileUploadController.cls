/**
 * @description       : 
 * @author            : Muh Syafiq Hidayatullah
 * @group             : 
 * @last modified on  : 10-09-2025
 * @last modified by  : Muh Syafiq Hidayatullah
**/
public without sharing class AMFS_FileUploadController {
    @AuraEnabled
    public static String uploadFile(String fileData, String fileName, Id LogBookActivityDetailId) {
        try {
            Blob fileBody = EncodingUtil.base64Decode(fileData);
            // Create Content Version
            ContentVersion cv = new ContentVersion();
            cv.Title = fileName;
            cv.PathOnClient = '/' + fileName;
            cv.VersionData = fileBody;
            cv.SharingOption = 'A';
            cv.SharingPrivacy = 'N'; 
            cv.firstPublishLocationId= UserInfo.getUserId();
            insert cv;

            // Query for Content Document Id from Content Version
            Id cdId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id].ContentDocumentId;

            // Create Content Document Link
            ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.ContentDocumentId = cdId;
            cdl.LinkedEntityId = LogBookActivityDetailId;
            cdl.ShareType = 'I'; // Viewer
            cdl.Visibility = 'AllUsers';
            insert cdl;
            
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
            delete cd;
        } catch (Exception e) {
            throw new AuraHandledException('Gagal menghapus file: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static String nameOfPolicyNumber(Id LogBookActivityDetailId){
        try {
            Log_Book_Activitiy_Detail__c eForm = [SELECT id, Policy_Number__c FROM Log_Book_Activitiy_Detail__c WHERE id = :LogBookActivityDetailId LIMIT 1];
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

    @AuraEnabled
    public static String documentUploaded(Id LogBookActivityDetailId){
        try {
            // Query multipicklist document tambahan
            Log_Book_Activitiy_Detail__c doc = [SELECT Dokumen_Tambahan__c FROM Log_Book_Activitiy_Detail__c WHERE id = :LogBookActivityDetailId];
            
            String docs = doc.Dokumen_Tambahan__c;
            List<String> docTambahan = docs.split(';');
            List<String> docTambahanClean = new List<String>();
            for(String item:docTambahan){
                String cleaned = item.replace('/', '').trim();
                docTambahanClean.add(cleaned);
            }
            System.debug('Ini Dokumen Tambahan:'+docTambahanClean);
            // Query File di LBD
            List<ContentDocumentLink> fileLBD = [SELECT ContentDocument.Title FROM ContentDocumentLink WHERE LinkedEntityId =: LogBookActivityDetailId];
            List<String> fileNewestRaw = new List<String>();
            
            for(ContentDocumentLink cdl : fileLBD){
                fileNewestRaw.add(cdl.ContentDocument.Title);
            }

            List<String> fileNewestClean = new List<String>();
            for(String item : fileNewestRaw){
                Integer dashIndex = item.indexOf('-');
                if (dashIndex > 0) {
                    String beforeDash = item.substring(0, dashIndex).trim();
                    beforeDash = beforeDash.replace('_', ' ');
                    if(beforeDash != 'Tanda Tangan'){
                        fileNewestClean.add(beforeDash);
                    }
                }
            }
            system.debug('File Saat Ini: '+fileNewestClean);

            List<String> missingValues = new List<String>();
            for (String option : docTambahanClean) {
                if (!fileNewestClean.contains(option)) {
                    missingValues.add(option);
                }
            }
            system.debug('File yang Kurang:'+ missingValues);

            String missingValueString = String.join(missingValues, ';');
            return missingValueString;
            
            
        } catch (Exception e) {
            throw new AuraHandledException('Error Get Record: '+e.getMessage());
        }
    }
}