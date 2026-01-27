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
private class AMFS_SignatureUploadController_Test {

    @testSetup
    static void setupTestData() {

        List<Log_Book_Activitiy__c> lba35 = new List<Log_Book_Activitiy__c>();
        for (Integer i = 0; i < 2; i++) {
            Log_Book_Activitiy__c lba = new Log_Book_Activitiy__c();
            lba.Time_In__c = Time.newInstance(1, 1, 0, 0);
            lba.Queue_No__c = 'A00'+i;
            lba.Touch_Point__c = 'Head Office';
            
            lba35.add(lba);
        }
        insert lba35;

        // Create test Log_Book_Activitiy_Detail__c records
        List<Log_Book_Activitiy_Detail__c> testLbads = new List<Log_Book_Activitiy_Detail__c>();
        Log_Book_Activitiy_Detail__c lbad = new Log_Book_Activitiy_Detail__c();
        lbad.Log_Book_Activitiy__c = lba35[0].Id;
        lbad.EForm__c = true;
        lbad.Customer_Mood__c = 'Happy';
        lbad.Customer_Name__c = 'JOHN DUMMY AMFS RLS';
        lbad.Customer_Relation__c = 'Diri Sendiri';
        lbad.Department__c = 'POS';
        lbad.Segmentation__c = 'Reguler';
        lbad.Policy_Number__c = 'POL-12345';
        testLbads.add(lbad);
        insert testLbads;
        // Create LBAD without Policy Number
        Log_Book_Activitiy_Detail__c lbadWP = new Log_Book_Activitiy_Detail__c();
        lbadWP.Log_Book_Activitiy__c = lba35[1].Id;
        lbadWP.EForm__c = true;
        lbadWP.Customer_Mood__c = 'Happy';
        lbadWP.Customer_Name__c = 'NoPolicy';
        lbadWP.Customer_Relation__c = 'Diri Sendiri';
        lbadWP.Department__c = 'POS';
        lbadWP.Segmentation__c = 'Reguler';
        
        insert lbadWP;
    }

    @isTest
    static void testUploadSignatureSuccess() {
        // Get test data
        Log_Book_Activitiy_Detail__c testLbad = [SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = 'POL-12345' LIMIT 1];
        
        // Prepare test data
        String testFileData = 'VGVzdCBzaWduYXR1cmUgZGF0YQ=='; // Base64 encoded "Test signature data"
        String testFileName = 'signature.png';
        
        Test.startTest();
        
        // Call the method
        String result = AMFS_SignatureUploadController.uploadSignature(testFileData, testFileName, testLbad.Id);
        
        Test.stopTest();
    }

    @isTest
    static void testUploadSignatureNullFileData() {
        // Get test data
        Log_Book_Activitiy_Detail__c testLbad = [SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = 'POL-12345' LIMIT 1];
        
        // Prepare test data
        String testFileName = 'signature.png';
        
        Test.startTest();
        
        try {
            AMFS_SignatureUploadController.uploadSignature(null, testFileName, testLbad.Id);
            System.assert(false, 'Should throw exception for blank file data');
        } catch (AuraHandledException e) {
            // System.assertEquals('Data kosong.', e.getMessage(), 'Should throw correct error message');
        }

        Test.stopTest();
    }

    @isTest
    static void testUploadSignatureNull() {
        
        Test.startTest();

        try {
            AMFS_SignatureUploadController.uploadSignature(null, null, null);
            System.assert(false, 'Should throw exception for blank file data');
        } catch (AuraHandledException e) {
            // System.assertEquals('Data kosong.', e.getMessage(), 'Should throw correct error message');
        }
        
        Test.stopTest();
    }

    @isTest
    static void testUploadSignatureWithInvalidRecordId() {
        // Create a fake Id (this will cause DML exception)
        Id fakeId = '001000000000000AAA'; // Fake Id format
        
        // Prepare test data
        String testFileData = 'VGVzdCBzaWduYXR1cmUgZGF0YQ==';
        String testFileName = 'signature.png';
        
        Test.startTest();
        
        // Call the method and expect exception
        try {
            AMFS_SignatureUploadController.uploadSignature(testFileData, testFileName, fakeId);
            System.assert(false, 'Should throw exception for invalid record Id');
        } catch (AuraHandledException e) {
            // System.assert(e.getMessage().contains('Error uploading file:'), 'Should throw error uploading file message');
        }
        
        Test.stopTest();
    }

    @isTest
    static void testDeleteFileSuccess() {
        // First create a file to delete
        Log_Book_Activitiy_Detail__c testLbad = [SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = 'POL-12345' LIMIT 1];
        
        // Create ContentVersion
        ContentVersion cv = new ContentVersion();
        cv.Title = 'Test File to Delete';
        cv.PathOnClient = '/test-file.png';
        cv.VersionData = EncodingUtil.base64Decode('VGVzdCBmaWxlIGRhdGE=');
        cv.FirstPublishLocationId = UserInfo.getUserId();
        insert cv;
        
        // Get ContentDocument Id
        Id cdId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id].ContentDocumentId;
        
        Test.startTest();
        
        // Call delete method
        AMFS_SignatureUploadController.deleteFile(cdId);
        
        Test.stopTest();
        
        // Verify file was deleted
        List<ContentDocument> remainingFiles = [SELECT Id FROM ContentDocument WHERE Id = :cdId];
        System.assertEquals(0, remainingFiles.size(), 'File should be deleted');
    }
    
    @isTest
    static void testDeleteFileWithInvalidId() {
        // Create a fake ContentDocument Id
        Id fakeId = '069000000000000AAA'; // Fake ContentDocument Id format
        
        Test.startTest();
        
        // Call the method and expect exception
        try {
            AMFS_SignatureUploadController.deleteFile(fakeId);
            System.assert(false, 'Should throw exception for invalid file Id');
        } catch (AuraHandledException e) {
            // System.assert(e.getMessage().contains('Gagal menghapus file:'), 'Should throw correct error message');
        }
        
        Test.stopTest();
    }

    @isTest
    static void testNameOfPolicyNumberWithValidPolicy() {
        // Get test data with policy number
        Log_Book_Activitiy_Detail__c testLbad = [SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = 'POL-12345' LIMIT 1];
        
        Test.startTest();
        
        // Call the method
        String result = AMFS_SignatureUploadController.nameOfPolicyNumber(testLbad.Id);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('POL-12345', result, 'Should return correct policy number');
    }

    @isTest
    static void testNameOfPolicyNumberWithNullPolicy() {
        // Get test data without policy number
        Log_Book_Activitiy_Detail__c testLbad = [SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Customer_Name__c = 'NoPolicy' LIMIT 1];
        
        Test.startTest();
        
        // Call the method
        String result = AMFS_SignatureUploadController.nameOfPolicyNumber(testLbad.Id);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('Null Policy Number', result, 'Should return null policy message');
    }

    @isTest
    static void testNameOfPolicyNumberWithFakeId() {
        Id fakeId = '069000000000000AAA';
        Test.startTest();
        
        // Call the method
        try {
            AMFS_SignatureUploadController.nameOfPolicyNumber(fakeId);
            System.assert(false, 'Should throw exception for invalid file Id');
        } catch (AuraHandledException e) {
            // System.assert(e.getMessage().contains('Gagal menghapus file:'), 'Should throw correct error message');
        }
        
        Test.stopTest();
        
    }

    @isTest
    static void testNameOfPolicyNumberWithNullId() {
        Test.startTest();
        
        // Call the method
        try {
            AMFS_SignatureUploadController.nameOfPolicyNumber(null);
            System.assert(false, 'Should throw exception for invalid null Id');
        } catch (AuraHandledException e) {
            // System.assert(e.getMessage().contains('Gagal menghapus file:'), 'Should throw correct error message');
        }
        
        Test.stopTest();
        
    }
}