/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class AMFS_DeleteDataLBADBatch_Test {

    @testSetup
    static void setupTestData() {

        
        List<Log_Book_Activitiy__c> lba35 = new List<Log_Book_Activitiy__c>();
        // Create LBA records that are 35 days old with EForm = TRUE (should be deleted)
        for (Integer i = 0; i < 5; i++) {
            Log_Book_Activitiy__c lba = new Log_Book_Activitiy__c();
            lba.Time_In__c = Time.newInstance(1, 1, 0, 0);
            lba.Queue_No__c = 'A00'+i;
            lba.Touch_Point__c = 'Head Office';
            
            lba35.add(lba);
        }
        insert lba35;
        // Create test data in setupTestData method
        List<Log_Book_Activitiy_Detail__c> lbad35 = new List<Log_Book_Activitiy_Detail__c>();
        List<Log_Book_Activitiy_Detail__c> lbad5 = new List<Log_Book_Activitiy_Detail__c>();
        List<Log_Book_Activitiy_Detail__c> lbadNoEForm = new List<Log_Book_Activitiy_Detail__c>();

        // Create LBAD records that are 35 days old with EForm = TRUE (should be deleted)
        for (Integer i = 0; i < 5; i++) {
            Log_Book_Activitiy_Detail__c lbad = new Log_Book_Activitiy_Detail__c();
            lbad.Log_Book_Activitiy__c = lba35[0].Id;
            lbad.EForm__c = true;
            lbad.Customer_Mood__c = 'Happy';
            lbad.Customer_Name__c = 'JOHN DUMMY AMFS RLS';
            lbad.Customer_Relation__c = 'Diri Sendiri';
            lbad.Department__c = 'POS';
            lbad.Segmentation__c = 'Reguler';
            lbad35.add(lbad);
        }
        insert lbad35;
        
        // Update CreatedDate to 35 days ago using Test.setCreatedDate
        for (Log_Book_Activitiy_Detail__c lbad : lbad35) {
            Test.setCreatedDate(lbad.Id, Date.today().addDays(-35));
        }

        // Create LBAD records that are 5 days old with EForm = TRUE (should NOT be deleted)
        for (Integer i = 0; i < 5; i++) {
            Log_Book_Activitiy_Detail__c lbad = new Log_Book_Activitiy_Detail__c();
            lbad.Log_Book_Activitiy__c = lba35[1].Id;
            lbad.EForm__c = true;
            lbad.Customer_Mood__c = 'Happy';
            lbad.Customer_Name__c = 'JOHN DUMMY AMFS RLS';
            lbad.Customer_Relation__c = 'Diri Sendiri';
            lbad.Department__c = 'POS';
            lbad.Segmentation__c = 'Reguler';
            lbad5.add(lbad);
        }
        insert lbad5;
        
        // Update CreatedDate to 5 days ago
        for (Log_Book_Activitiy_Detail__c lbad : lbad5) {
            Test.setCreatedDate(lbad.Id, Date.today().addDays(-5));
        }

        // Create LBAD records that are 35 days old but EForm = FALSE (should NOT be deleted)
        for (Integer i = 0; i < 3; i++) {
            Log_Book_Activitiy_Detail__c lbad = new Log_Book_Activitiy_Detail__c();
            lbad.Log_Book_Activitiy__c = lba35[3].Id;
            lbad.EForm__c = false;
            lbad.Customer_Mood__c = 'Happy';
            lbad.Customer_Name__c = 'JOHN DUMMY AMFS RLS';
            lbad.Customer_Relation__c = 'Diri Sendiri';
            lbad.Department__c = 'POS';
            lbad.Segmentation__c = 'Reguler';
            lbadNoEForm.add(lbad);
        }
        insert lbadNoEForm;
        
        // Update CreatedDate to 35 days ago
        for (Log_Book_Activitiy_Detail__c lbad : lbadNoEForm) {
            Test.setCreatedDate(lbad.Id, Date.today().addDays(-35));
        }

        // Create ContentVersion (files) for the 35-day old records with EForm = TRUE
        String x = 'VGVzdCBmaWxlIGNvbnRlbnQgZm9yIExCQUQ='; // Base64 encoded "Test file content for LBAD"
        Blob fileBody = EncodingUtil.base64Decode(x);

        List<ContentVersion> cvs = new List<ContentVersion>();
        for (Log_Book_Activitiy_Detail__c lbad : lbad35) {
            for (Integer i = 0; i < 2; i++) { // 2 files per LBAD record
                ContentVersion cv = new ContentVersion();
                cv.Title = 'LBAD File ' + i;
                cv.PathOnClient = 'LBAD File ' + i + '.txt';
                cv.VersionData = fileBody;
                cvs.add(cv);
            }
        }
        insert cvs;

        // Query ContentVersion to get ContentDocumentId
        List<ContentVersion> insertedCvs = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id IN :cvs];
        
        // Create ContentDocumentLink to link files to LBAD records
        List<ContentDocumentLink> cdls = new List<ContentDocumentLink>();
        Integer index = 0;
        for (Log_Book_Activitiy_Detail__c lbad : lbad35) {
            for (Integer j = 0; j < 2; j++) { // 2 files per LBAD record
                if (index < insertedCvs.size()) {
                    ContentDocumentLink cdl = new ContentDocumentLink();
                    cdl.ContentDocumentId = insertedCvs[index].ContentDocumentId;
                    cdl.LinkedEntityId = lbad.Id;
                    cdl.ShareType = 'V'; // Viewer
                    cdl.Visibility = 'AllUsers';
                    cdls.add(cdl);
                    index++;
                }
            }
        }
        insert cdls;
    }

    @isTest
    static void testDeleteDataLBADBatch() {
        // Query initial data
        List<Log_Book_Activitiy_Detail__c> initialLbads = [SELECT Id FROM Log_Book_Activitiy_Detail__c];
        
        Test.startTest();
        
        // Execute the batch
        AMFS_DeleteDataLBADBatch batchJob = new AMFS_DeleteDataLBADBatch();
        Id batchId = Database.executeBatch(batchJob, 200);
        
        Test.stopTest();
        
    }
    
    @isTest
    static void testRunBatchMethod() {
        Test.startTest();
        
        // Test the static runBatch method
        AMFS_DeleteDataLBADBatch.runBatch();
        
        Test.stopTest();
        
    }
}