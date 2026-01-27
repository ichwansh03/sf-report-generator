/**
 * @description       : 
 * @author            : Ahmad Yazid Munif
 * @group             : 
 * @last modified on  : 09-09-2025
 * @last modified by  : Ahmad Yazid Munif
**/
@isTest
private class AMFS_FP5_ControllerTest {

    @isTest
    static void testConstructorHappyPath() {
        ApexPages.currentPage().getParameters().put('touchPoint', 'Surabaya');
        ApexPages.currentPage().getParameters().put('polisNo', 'P12345');
        ApexPages.currentPage().getParameters().put('transNo', '302-0048025');
        ApexPages.currentPage().getParameters().put('tambahanInformasi', 'Tambahan info test');
        ApexPages.currentPage().getParameters().put('fullname', 'anderson');
        ApexPages.currentPage().getParameters().put('noTelpPolisFP5', '08123456789');
        ApexPages.currentPage().getParameters().put('emailPolisFP5', 'anderson@example.com');
        ApexPages.currentPage().getParameters().put('alamatPolisFP5', 'Jl. Sudirman');
        ApexPages.currentPage().getParameters().put('noIdentitasKtp', '3500112233445566');
        ApexPages.currentPage().getParameters().put('segmentasi', 'VIP');
        ApexPages.currentPage().getParameters().put('tanggalLahir', '2000-01-01');
        ApexPages.currentPage().getParameters().put('formUtama', 'form1');
        ApexPages.currentPage().getParameters().put('sign', 'a0s000000000001');
        ApexPages.currentPage().getParameters().put('signTP', 'a0s000000000002');
        ApexPages.currentPage().getParameters().put('fullnameTT', 'teresa');
        ApexPages.currentPage().getParameters().put('inputDate', '2025-01-01');
        // ApexPages.currentPage().getParameters().put('dokumenTambahanFP5', 'DokumenA;DokumenB;DokumenC');
        
        Account dummyAcc = new Account(Name = 'Test Account');
        insert dummyAcc;

        Test.startTest();
        ApexPages.StandardController stdController = new ApexPages.StandardController(dummyAcc);
        AMFS_FP5_Controller controller = new AMFS_FP5_Controller(stdController);
        Test.stopTest();

        // System.assertEquals('Surabaya', controller.touchPoint);
        // System.assertEquals('CCC - SURABAYA', controller.touchPointName);
        // System.assertEquals('P12345', controller.polisNo);
        // System.assertEquals('FP5 - 302-0048025', controller.transNo);
        // System.assertEquals('Tambahan info test', controller.tambahanInformasi);
        // System.assertEquals('ANDERSON', controller.namaLengkapPemegangPolis);
        // System.assertEquals('08123456789', controller.noTelepon);
        // System.assertEquals('ANDRES@EXAMPLE.COM', controller.email);
        // System.assertEquals('JL. SUDIRMAN', controller.alamatDomisili);
        // System.assertEquals('3500112233445566', controller.noIdentitas);
        // System.assertEquals('VIP', controller.segmentasi);
        // System.assertEquals('2000-01-01', controller.tanggalLahir);
        // System.assertEquals('FORM1', controller.formUtama);
        // System.assertEquals('TERESA', controller.namaLengkapTertanggung);
        // System.assertEquals('/sfc/servlet.shepherd/version/download/a0s000000000001', controller.imgUrl);
        // System.assertEquals('/sfc/servlet.shepherd/version/download/a0s000000000002', controller.imgUrlTP);
        // System.assertEquals('Surabaya, 2025-01-01', controller.formatTempatTanggal);
        // System.assertEquals('DokumenA;DokumenB;DokumenC', controller.lbdDokumenTambahan);
        // System.assertEquals(3, controller.listDokumenTambahan.size());
    }
    
    @isTest
    static void testConstructorNullAndEmptyParams() {
        ApexPages.currentPage().getParameters().put('signTP', '');
        ApexPages.currentPage().getParameters().put('dokumenTambahanFP5', null);
        ApexPages.currentPage().getParameters().put('noTelpPolisFP5', '');
        
        Account dummyAcc = new Account(Name = 'Test Acc');
        insert dummyAcc;
        
        Test.startTest();
        ApexPages.StandardController stdController = new ApexPages.StandardController(dummyAcc);
        AMFS_FP5_Controller controller = new AMFS_FP5_Controller(stdController);
        Test.stopTest();
        
    }

    @isTest
    static void testGenerateMetadata() {
        E_Form_Master_Data__c testEform = new E_Form_Master_Data__c(
            Nama_Pemilik_Polis__c = 'Tester',
            Alamat_Domisili__c = 'Jl. Contoh No. 123',
            Nomor_Telpon__c = '081111111',
            Email__c = 'test@example.com',
            Tanggal_Lahir__c = Date.newInstance(1990, 5, 20)
        );
        insert testEform;

        Test.startTest();
        AMFS_FP5_Controller.generateMetadata(testEform);
        Test.stopTest();

        E_Form_Master_Data__c updatedEform = [SELECT Metadata__c FROM E_Form_Master_Data__c WHERE Id = :testEform.Id];
        
        Map<String, Object> jsonMap = (Map<String, Object>)JSON.deserializeUntyped(updatedEform.Metadata__c);
        
    }
    @isTest
    static void testGenerateMetadata2() {
        E_Form_Master_Data__c testEform = new E_Form_Master_Data__c(
            Nama_Pemilik_Polis__c = 'Tester',
            Alamat_Domisili__c = 'Jl. Contoh No. 123',
            Nomor_Telpon__c = '081111111',
            Email__c = ''
        );
        insert testEform;

        Test.startTest();
        AMFS_FP5_Controller.generateMetadata(testEform);
        Test.stopTest();

        E_Form_Master_Data__c updatedEform = [SELECT Metadata__c FROM E_Form_Master_Data__c WHERE Id = :testEform.Id];
        
        Map<String, Object> jsonMap = (Map<String, Object>)JSON.deserializeUntyped(updatedEform.Metadata__c);
        
    }
}