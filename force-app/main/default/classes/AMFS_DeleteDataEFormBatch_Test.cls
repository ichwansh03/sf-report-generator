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
private class AMFS_DeleteDataEFormBatch_Test {

    @testSetup
    static void setup() {
        
        List<E_Form_Master_Data__c> eform35 = new List<E_Form_Master_Data__c>();
        List<E_Form_Master_Data__c> eform5 = new List<E_Form_Master_Data__c>();

        // Create E_Form records that are 35 days old (should be deleted)
        for (Integer i = 0; i < 5; i++) {
            E_Form_Master_Data__c form = new E_Form_Master_Data__c();
            form.Name = 'Test Eform - 35 days ' + i;
            eform35.add(form);
        }
        insert eform35;
        
        // Update CreatedDate to 35 days ago using Test.setCreatedDate
        for (E_Form_Master_Data__c form : eform35) {
            Test.setCreatedDate(form.Id, Date.today().addDays(-35));
        }

        // Create E_Form records that are 5 days old (should NOT be deleted)
        for (Integer i = 0; i < 5; i++) {
            E_Form_Master_Data__c form = new E_Form_Master_Data__c();
            form.Name = 'Test Eform - 5 days ' + i;
            eform5.add(form);
        }
        insert eform5;
        
        // Update CreatedDate to 5 days ago
        for (E_Form_Master_Data__c form : eform5) {
            Test.setCreatedDate(form.Id, Date.today().addDays(-5));
        }

        String x = 'INI ADALAH BLOB';
        Blob fileBody = EncodingUtil.base64Decode(x);

        List<ContentVersion> cvs = new List<ContentVersion>();
        for (E_Form_Master_Data__c e : eform35) {
            for (Integer i = 0; i < 2; i++) { // 2 files per E_Form record
                ContentVersion cv = new ContentVersion();
                cv.Title = 'File Name ' + i;
                cv.PathOnClient = 'File Name ' + i + '.txt';
                cv.VersionData = fileBody;
                cvs.add(cv);
            }
        }
        insert cvs;
        
        // Query ContentVersion to get ContentDocumentId
        List<ContentVersion> insertedCvs = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id IN :cvs];
        
        // Create ContentDocumentLink to link files to E_Form records
        List<ContentDocumentLink> cdls = new List<ContentDocumentLink>();
        Integer index = 0;
        for (E_Form_Master_Data__c e : eform35) {
            for (Integer j = 0; j < 2; j++) { // 2 files per E_Form record
                if (index < insertedCvs.size()) {
                    ContentDocumentLink cdl = new ContentDocumentLink();
                    cdl.ContentDocumentId = insertedCvs[index].ContentDocumentId;
                    cdl.LinkedEntityId = e.Id;
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
    static void testDeleteDataEFormBatch() {
        // Query initial data
        List<E_Form_Master_Data__c> initialEforms = [SELECT Id FROM E_Form_Master_Data__c];
        // List<ContentDocumentLink> initialFiles = [SELECT Id FROM ContentDocumentLink];
        
        System.debug('Initial E_Forms: ' + initialEforms.size());
        
        Test.startTest();
        
        // Execute the batch
        AMFS_DeleteDataEFormBatch batchJob = new AMFS_DeleteDataEFormBatch();
        Id batchId = Database.executeBatch(batchJob, 100);
        
        Test.stopTest();
    }

    @isTest
    static void testRunBatchMethod() {
        Test.startTest();
        
        // Test the static runBatch method
        AMFS_DeleteDataEFormBatch.runBatch();
        
        Test.stopTest();
        
        // Verify batch was executed
        List<E_Form_Master_Data__c> remainingEforms = [SELECT Id, Name FROM E_Form_Master_Data__c];
        System.assertEquals(5, remainingEforms.size(), 'Should have 5 remaining E_Forms after runBatch');
    }
}