/**
 * @description       : 
 * @author            : Mario Carlos Eyo
 * @group             : 
 * @last modified on  : 09-23-2025
 * @last modified by  : Ahmad Yazid Munif
**/
@isTest
public with sharing class AMFS_GeneratePDF_Test {
    
    @testSetup static void setup() {    
        
        Contact con = new Contact();
        con.Entity__c = 'AMFS';
        con.PolicyApp__c = 'RLS';
        con.Policy_No__c = '520-4931835';
        con.LastName = 'John';
        insert con;
        Contact cont = new Contact();
        cont.Entity__c = 'AMFS';
        cont.PolicyApp__c = 'DMTM';
        cont.Policy_No__c = '100-321-7654321';
        cont.LastName = 'John';
        insert cont;

        List<Log_Book_Activitiy_Detail__c> listDetail = new List<Log_Book_Activitiy_Detail__c>();
        Log_Book_Activitiy__c logBook = new Log_Book_Activitiy__c();
        logBook.Touch_Point__c = 'Head Office';
        logBook.Log_Book_Date__c = Date.today();
        logBook.Queue_No__c = 'A001';
        logBook.Time_In__c = Time.newInstance(15, 0, 0, 0);
        logBook.Time_Served__c = Time.newInstance(15, 3, 0, 0);
        logBook.Time_Out__c = Time.newInstance(15, 20, 0, 0);
        logBook.Waiting_Time__c = '0 hours 3 minutes';
        logBook.Handling_Time__c = '0 hours 17 minutes';
        logBook.Type__c = 'Walk-In';
        Database.SaveResult lbResult = Database.insert(logBook);

        Log_Book_Activitiy_Detail__c  logBookDetail = new Log_Book_Activitiy_Detail__c();
        logBookDetail.Policy_Number__c = '100-321-7654321';
        logBookDetail.Policy_Name_Holder__c = 'RITA DWI HASTATI';
        logBookDetail.Product_Type__c = 'DMTM';
        logBookDetail.Customer_Name__c = 'ririn';
        logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        logBookDetail.Is_Policy_Holder__c =  true;
        logBookDetail.Segmentation__c = 'Reguler';
        logBookDetail.Department__c = 'POS';
        logBookDetail.Kind_Of_Transaction__c = 'Request_POS_Redemption';
        logBookDetail.Document_Type__c = 'Japen';
        logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];';
        logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logBookDetail.Stamp__c = 1; 
        logBookDetail.Customer_Mood__c = 'Normal';
        logBookDetail.Need_CR__c = 'Yes';
        logBookDetail.Status__c = 'Closed';
        logBookDetail.Dokumen_Tambahan__c = 'KTP (Copy)';
        logBookDetail.Form_Tambahan__c = 'Formulir Deklarasi Individu (CRS)';
        logBookDetail.EForm__c = true;
        logBookDetail.E_Form__c = true;
        logBookDetail.Preview_Document__c = true;
        logBookDetail.Canceled__c = false;
        logBookDetail.Status_to_Metadata__c = 'Failed';
        logBookDetail.Status_Metadata__c = '{"068BK000004CwSXYA0":{"status":"Failed","id":"068BK000004CwSXYA0"},"068BK000004CwPJYA0":{"status":"Failed","id":"068BK000004CwPJYA0"},"068BK000004CwU9YAK":{"status":"Failed","id":"068BK000004CwU9YAK"}}';
        logBookDetail.Contact_Policy__c = cont.Id;
        logBookDetail.Log_Book_Activitiy__c = lbResult.getId();
        listDetail.add(logBookDetail);
        
        logBookDetail = new Log_Book_Activitiy_Detail__c();
        logBookDetail.Policy_Number__c = '100-321-7654321';
        logBookDetail.Policy_Name_Holder__c = 'RITA DWI HASTATI';
        logBookDetail.Product_Type__c = 'DMTM';
        logBookDetail.Customer_Name__c = 'ririn';
        logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        logBookDetail.Is_Policy_Holder__c =  true;
        logBookDetail.Segmentation__c = 'Reguler';
        logBookDetail.Department__c = 'POS';
        logBookDetail.Kind_Of_Transaction__c = 'Request_POS_Withdrawal';
        logBookDetail.Document_Type__c = 'Japen';
        logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];';
        logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logBookDetail.Stamp__c = 1; 
        logBookDetail.Customer_Mood__c = 'Normal';
        logBookDetail.Need_CR__c = 'Yes';
        logBookDetail.Status__c = 'Closed';
        logBookDetail.Dokumen_Tambahan__c = 'KTP (Copy)';
        logBookDetail.Preview_Document__c = true;
        logBookDetail.Canceled__c = false;
        logBookDetail.Form_Tambahan__c = 'Formulir Deklarasi Individu (CRS)';
        logBookDetail.EForm__c = true;
        logBookDetail.E_Form__c = true;
        logBookDetail.Status_to_Metadata__c = 'Success';
        logBookDetail.Status_Metadata__c = '{"068BK000004CwSXYA0":{"status":"Success","id":"068BK000004CwSXYA0"},"068BK000004CwPJYA0":{"status":"Success","id":"068BK000004CwPJYA0"},"068BK000004CwU9YAK":{"status":"Success","id":"068BK000004CwU9YAK"}}';
        logBookDetail.Contact_Policy__c = cont.Id;
        logBookDetail.Log_Book_Activitiy__c = lbResult.getId();
        listDetail.add(logBookDetail);
        List<Database.SaveResult> lbdResults = Database.insert(listDetail);
    }
    @isTest
    public static void getKeteranganTambahanTest(){
        Integer testIndex = 1;
        String testNegara = 'Indonesia';
        String testNomorTIN = '1234567890';
        String testAlasan = 'Tidak ada TIN';

        test.startTest();
        Log_Book_Activitiy_Detail__c getLBD = [SELECT Id,Kind_Of_Transaction__c,Log_Book_Activitiy__c,Canceled__c,EForm__c,Department__c,Policy_Number__c FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = '100-321-7654321' LIMIT 1];
        AMFS_GeneratePDF.getKeteranganTambahanAsString(getLBD);
        AMFS_CRS_Controller.NegaraPajakWrapper npw = new AMFS_CRS_Controller.NegaraPajakWrapper(testIndex, testNegara, testNomorTIN, testAlasan);
        AMFS_CRS_Controller.NegaraPajakCPWrapper npcpw = new AMFS_CRS_Controller.NegaraPajakCPWrapper(testIndex, testNegara, testNomorTIN, testAlasan);
        test.stopTest();
    }
    public static testMethod void runTestGeneratePDF() {
        Contact con = [SELECT ID FROM Contact where Policy_No__c = '520-4931835'];
        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_ Perubahan Alamat email', 'POS', con.id);
        insert lbad;
        E_Form_Master_Data__c eform = createEFORMPDP(lbad.id, 'Request_POS_ Perubahan Alamat email', 'Perubahan Alamat Email - 213', 'ifEmaail1');
        insert eform;
        system.debug('##### EFORM' + eform);

        ApexPages.StandardController stdController = new ApexPages.StandardController(eform);
        AMFS_GeneratePDFController controller = new AMFS_GeneratePDFController(stdController);

        test.startTest();
        AMFS_GeneratePDFController.generatePDF(eform.Id);
        test.stopTest();
    }
    public static testMethod void runTestPerubahanAlamatKoresponden() {
        Contact con = [SELECT ID FROM Contact where Policy_No__c = '520-4931835'];
        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_ADS_Perubahan Alamat Korespondensi', 'ADS', con.id);
        insert lbad;
        E_Form_Master_Data__c eform = createEFORMPDP(lbad.id, 'Request_ADS_Perubahan Alamat Korespondensi', 'Perubahan Alamat Korespondensi - 213', 'ifEmaail1');
        insert eform;
        system.debug('##### EFORM' + eform);

        ApexPages.StandardController stdController = new ApexPages.StandardController(eform);
        AMFS_GeneratePDFController controller = new AMFS_GeneratePDFController(stdController);

        test.startTest();
        AMFS_GeneratePDFController.generatePDF(eform.Id);
        test.stopTest();
    }
    
    public static testMethod void runTestLumpsum() {
        test.startTest();
        generatePDF('Request_POS Lumpsum', 'Lumpsum', 'ZRAC-MANDIRI ACTIVE BALANCED MONEY RUPIAH');
        test.stopTest();
        
    }
    
    public static testMethod void runTestLumpsumNull() {
        test.startTest();
        generatePDF('Request_POS Lumpsum', 'Lumpsum', 'nilaiTunaiNull');
        test.stopTest();
    }
    
    
    
    public static testMethod void runTesWithdrawal() {
        test.startTest();
        generatePDF('Request_POS_Withdrawal', 'Withdrawal', 'ZRAC-MANDIRI ACTIVE BALANCED MONEY RUPIAH');
        test.stopTest();
    }
    
    public static testMethod void runTesWithdrawalBigAmount() {
        test.startTest();
        generatePDF('Request_POS_Withdrawal', 'Withdrawal', '');
        test.stopTest();
    }
    public static testMethod void runTestBU() {
        test.startTest();
        generatePDF('Request_POS_Pengalihan Dana (Switching)', 'Deklarasi Badan Usaha', 'nilaiTunaiNull');
        test.stopTest();
    }
    public static testMethod void runTestIndividu() {
        test.startTest();
        generatePDF('Request_POS_Pengalihan Dana (Switching)', 'Deklarasi Individu', '');
        test.stopTest();
    }
    public static testMethod void runTestKeberatan() {
        test.startTest();
        generatePDF('Request_POS_Pengalihan Dana (Switching)', 'Deklarasi Keberatan', '');
        test.stopTest();
    }
    
    public static testMethod void runTestSwitching() {
        test.startTest();
        generatePDF('Request_POS_Pengalihan Dana (Switching)', 'Switching', '');
        test.stopTest();
    }
    
    public static testMethod void runTestRedirection() {
        test.startTest();
        generatePDF('Request_POS_Perubahan Alokasi Dana (Redirection)', 'Switching', 'ZRAC-MANDIRI ACTIVE BALANCED MONEY RUPIAH');
        test.stopTest();
    }
    public static testMethod void runTestSwitchRedir() {
        test.startTest();
        generatePDF('Request_POS_Switching & Redirection', 'Switching', 'None');
        test.stopTest();
    }
    
    public static testMethod void runTestCooling() {
        test.startTest();
        generatePDF('Request_POS Cooling off', 'Cooling Off', 'ZRAC-MANDIRI ACTIVE BALANCED MONEY RUPIAH');
        test.stopTest();
    }
    
    public static testMethod void runTestRedemption() {
        test.startTest();
        generatePDF('Request_POS_Redemption', 'Redemption POS', 'nilaiTunaiNull');
        test.stopTest();
    }
    
    public static testMethod void runTestRedemptionVF() {
        test.startTest();
        Contact con = [SELECT ID FROM Contact where Policy_No__c = '520-4931835'];
        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_Redemption', 'POS', con.id);
        insert lbad;
        E_Form_Master_Data__c eform = createEFORM(lbad.id, 'Request_POS_Redemption', 'Redemption', '');
        insert eform;
        
        ApexPages.StandardController stcs = new ApexPages.StandardController(eform);
        ApexPages.currentPage().getParameters().put('recordid',eform.Id);
        AMFS_PengajuanPenarikanDana_Controller cl3 = new AMFS_PengajuanPenarikanDana_Controller(stcs);
        
        test.stopTest();
    }
    
    public static testMethod void runTestPemulihanTP() {
        test.startTest();
        generatePDF('Request_POS Pemulihan Polis', 'Pemulihan Polis', 'TP');
        test.stopTest();
    }
    public static testMethod void runTestPemulihanPP() {
        test.startTest();
        generatePDF('Request_POS Pemulihan Polis', 'Pemulihan Polis', 'PP');
        test.stopTest();
    }
    public static testMethod void runTestPemulihanPPTP() {
        test.startTest();
        generatePDF('Request_POS Pemulihan Polis', 'Pemulihan Polis', 'PPTP');
        test.stopTest();
    }
    public static testMethod void runTestFP5() {
        test.startTest();
        generatePDF('Request_POS Pemulihan Polis', 'FP5', '');
        test.stopTest();
    }
    public static testMethod void runTestPerubahanEmail1() {
        Contact con = [SELECT ID FROM Contact where Policy_No__c = '520-4931835'];
        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_ Perubahan Alamat email', 'POS', con.id);
        insert lbad;
        E_Form_Master_Data__c eform = createEFORMPDP(lbad.id, 'Request_POS_ Perubahan Alamat email', 'Perubahan Alamat Email - 213', 'ifEmaail1');
        insert eform;
        system.debug('##### EFORM' + eform);
        List<E_Form_Master_Data__c> eformList = new List<E_Form_Master_Data__c>{eform};
        PageReference testPage = Page.VF_PerubahanDataPolisNew;
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('recordid',eformList[0].Id);
        ApexPages.currentPage().getParameters().put('dokumenTambahan','Form Tambahan');
        ApexPages.currentPage().getParameters().put('formTambahan','Form Tambahan');

        ApexPages.currentPage().getParameters().put('formName', eformList[0].Name);
        ApexPages.currentPage().getParameters().put('subjectTransaction', eformList[0].Subdana_Tambahan_1__c);
        ApexPages.currentPage().getParameters().put('subjectTransactionNumber', eformList[0].Subdana_Tambahan_2__c);
        ApexPages.currentPage().getParameters().put('nameTT', eformList[0].Nama_Tertanggung__c);
        ApexPages.currentPage().getParameters().put('alasan', eformList[0].Alasan__c);
        ApexPages.currentPage().getParameters().put('NIK', eformList[0].Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('tanggalLahir', String.valueOf(eformList[0].Tanggal_Lahir__c));
        ApexPages.currentPage().getParameters().put('segmentasi', eformList[0].Segmentation__c);
        ApexPages.currentPage().getParameters().put('emailSebelumnya', eformList[0].Email__c);
        ApexPages.currentPage().getParameters().put('emailSebelumnyaTP', eformList[0].Email_Sebelumnya_TP__c);
        ApexPages.currentPage().getParameters().put('emailTerbaru', eformList[0].Email_Terbaru__c);
        ApexPages.currentPage().getParameters().put('emailTerbaruTP', eformList[0].Email_Terbaru_TP__c);
        ApexPages.StandardController stcs = new ApexPages.StandardController(eformList[0]);
        test.startTest();
        AMFS_PerubahanDataPolis_Controller cal2 = new AMFS_PerubahanDataPolis_Controller(stcs);
        generatePDF('Request_POS_ Perubahan Alamat email', 'Perubahan Alamat Email', '');
        test.stopTest();
    }
    public static testMethod void runTestPerubahanEmail2() {
        Contact con = [SELECT ID FROM Contact where Policy_No__c = '520-4931835'];
        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_ Perubahan Alamat email', 'POS', con.id);
        insert lbad;
        E_Form_Master_Data__c eform = createEFORMPDP(lbad.id, 'Request_POS_ Perubahan Alamat email', 'Perubahan Alamat Email - 213', 'ifEmaail2');
        insert eform;
        system.debug('##### EFORM' + eform);
        List<E_Form_Master_Data__c> eformList = new List<E_Form_Master_Data__c>{eform};
        PageReference testPage = Page.VF_PerubahanDataPolisNew;
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('recordid',eformList[0].Id);
        ApexPages.currentPage().getParameters().put('formName', eformList[0].Name);
        ApexPages.currentPage().getParameters().put('subjectTransaction', eformList[0].Subdana_Tambahan_1__c);
        ApexPages.currentPage().getParameters().put('subjectTransactionNumber', eformList[0].Subdana_Tambahan_2__c);
        ApexPages.currentPage().getParameters().put('nameTT', eformList[0].Nama_Tertanggung__c);
        ApexPages.currentPage().getParameters().put('alasan', eformList[0].Alasan__c);
        ApexPages.currentPage().getParameters().put('NIK', eformList[0].Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('tanggalLahir', String.valueOf(eformList[0].Tanggal_Lahir__c));
        ApexPages.currentPage().getParameters().put('segmentasi', eformList[0].Segmentation__c);
        ApexPages.currentPage().getParameters().put('emailSebelumnya', eformList[0].Email__c);
        ApexPages.currentPage().getParameters().put('emailSebelumnyaTP', eformList[0].Email_Sebelumnya_TP__c);
        ApexPages.currentPage().getParameters().put('emailTerbaru', eformList[0].Email_Terbaru__c);
        ApexPages.currentPage().getParameters().put('emailTerbaruTP', eformList[0].Email_Terbaru_TP__c);
        ApexPages.StandardController stcs = new ApexPages.StandardController(eformList[0]);
        test.startTest();
        AMFS_PerubahanDataPolis_Controller cal2 = new AMFS_PerubahanDataPolis_Controller(stcs);
        test.stopTest();
    }
    public static testMethod void runTestPerubahanEmail3() {
        Contact con = [SELECT ID FROM Contact where Policy_No__c = '520-4931835'];
        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_ Perubahan Alamat email', 'POS', con.id);
        insert lbad;
        E_Form_Master_Data__c eform = createEFORMPDP(lbad.id, 'Request_POS_ Perubahan Alamat email', 'Perubahan Alamat Email - 213', 'ifEmaail3');
        insert eform;
        system.debug('##### EFORM' + eform);
        List<E_Form_Master_Data__c> eformList = new List<E_Form_Master_Data__c>{eform};
        PageReference testPage = Page.VF_PerubahanDataPolisNew;
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('recordid',eformList[0].Id);
        ApexPages.currentPage().getParameters().put('formName', eformList[0].Name);
        ApexPages.currentPage().getParameters().put('subjectTransaction', eformList[0].Subdana_Tambahan_1__c);
        ApexPages.currentPage().getParameters().put('subjectTransactionNumber', eformList[0].Subdana_Tambahan_2__c);
        ApexPages.currentPage().getParameters().put('nameTT', eformList[0].Nama_Tertanggung__c);
        ApexPages.currentPage().getParameters().put('alasan', eformList[0].Alasan__c);
        ApexPages.currentPage().getParameters().put('NIK', eformList[0].Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('tanggalLahir', String.valueOf(eformList[0].Tanggal_Lahir__c));
        ApexPages.currentPage().getParameters().put('segmentasi', eformList[0].Segmentation__c);
        ApexPages.currentPage().getParameters().put('emailSebelumnya', eformList[0].Email__c);
        ApexPages.currentPage().getParameters().put('emailSebelumnyaTP', eformList[0].Email_Sebelumnya_TP__c);
        ApexPages.currentPage().getParameters().put('emailTerbaru', eformList[0].Email_Terbaru__c);
        ApexPages.currentPage().getParameters().put('emailTerbaruTP', eformList[0].Email_Terbaru_TP__c);
        ApexPages.StandardController stcs = new ApexPages.StandardController(eformList[0]);
        test.startTest();
        AMFS_PerubahanDataPolis_Controller cal2 = new AMFS_PerubahanDataPolis_Controller(stcs);
        test.stopTest();
    }
    public static testMethod void runTestPerubahanAlamat2() {
        Contact con = [SELECT ID FROM Contact where Policy_No__c = '520-4931835'];
        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_ Perubahan Alamat Koresponden', 'POS', con.id);
        insert lbad;
        E_Form_Master_Data__c eform = createEFORMPDP(lbad.id, 'Request_POS_ Perubahan Alamat Koresponden', 'Perubahan Alamat Koresponden - 213', 'ifAlamat1');
        insert eform;
        system.debug('##### EFORM' + eform);
        List<E_Form_Master_Data__c> eformList = new List<E_Form_Master_Data__c>{eform};
        PageReference testPage = Page.VF_PerubahanDataPolisNew;
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('recordid',eformList[0].Id);
        ApexPages.currentPage().getParameters().put('formName', eformList[0].Name);
        ApexPages.currentPage().getParameters().put('subjectTransaction', eformList[0].Subdana_Tambahan_1__c);
        ApexPages.currentPage().getParameters().put('subjectTransactionNumber', eformList[0].Subdana_Tambahan_2__c);
        ApexPages.currentPage().getParameters().put('nameTT', eformList[0].Nama_Tertanggung__c);
        ApexPages.currentPage().getParameters().put('alasan', eformList[0].Alasan__c);
        ApexPages.currentPage().getParameters().put('NIK', eformList[0].Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('tanggalLahir', String.valueOf(eformList[0].Tanggal_Lahir__c));
        ApexPages.currentPage().getParameters().put('segmentasi', eformList[0].Segmentation__c);
        ApexPages.currentPage().getParameters().put('alamatSebelumnya', eformList[0].Alamat__c);
        ApexPages.currentPage().getParameters().put('alamatSebelumnyaTP', eformList[0].Alamat_Domisili_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('alamatTerbaru', eformList[0].Alamat_Terbaru__c);
        ApexPages.currentPage().getParameters().put('alamatTerbaruTP', eformList[0].Alamat_Terbaru_TP__c);
        ApexPages.StandardController stcs = new ApexPages.StandardController(eformList[0]);
        test.startTest();
        generatePDF('Request_POS_ Perubahan Alamat Koresponden', 'Perubahan Alamat Koresponden', '');
        AMFS_PerubahanDataPolis_Controller cal2 = new AMFS_PerubahanDataPolis_Controller(stcs);
        test.stopTest();
    }
    public static testMethod void runTestPerubahanAlamat3() {
        Contact con = [SELECT ID FROM Contact where Policy_No__c = '520-4931835'];
        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_ Perubahan Alamat Koresponden', 'POS', con.id);
        insert lbad;
        E_Form_Master_Data__c eform = createEFORMPDP(lbad.id, 'Request_POS_ Perubahan Alamat Koresponden', 'Perubahan Alamat Koresponden - 213', 'ifAlamat2');
        insert eform;
        system.debug('##### EFORM' + eform);
        List<E_Form_Master_Data__c> eformList = new List<E_Form_Master_Data__c>{eform};
        PageReference testPage = Page.VF_PerubahanDataPolisNew;
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('recordid',eformList[0].Id);
        ApexPages.currentPage().getParameters().put('formName', eformList[0].Name);
        ApexPages.currentPage().getParameters().put('subjectTransaction', eformList[0].Subdana_Tambahan_1__c);
        ApexPages.currentPage().getParameters().put('subjectTransactionNumber', eformList[0].Subdana_Tambahan_2__c);
        ApexPages.currentPage().getParameters().put('nameTT', eformList[0].Nama_Tertanggung__c);
        ApexPages.currentPage().getParameters().put('alasan', eformList[0].Alasan__c);
        ApexPages.currentPage().getParameters().put('NIK', eformList[0].Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('tanggalLahir', String.valueOf(eformList[0].Tanggal_Lahir__c));
        ApexPages.currentPage().getParameters().put('segmentasi', eformList[0].Segmentation__c);
        ApexPages.currentPage().getParameters().put('alamatSebelumnya', eformList[0].Alamat__c);
        ApexPages.currentPage().getParameters().put('alamatSebelumnyaTP', eformList[0].Alamat_Domisili_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('alamatTerbaru', eformList[0].Alamat_Terbaru__c);
        ApexPages.currentPage().getParameters().put('alamatTerbaruTP', eformList[0].Alamat_Terbaru_TP__c);
        ApexPages.StandardController stcs = new ApexPages.StandardController(eformList[0]);
        test.startTest();
        AMFS_PerubahanDataPolis_Controller cal2 = new AMFS_PerubahanDataPolis_Controller(stcs);
        test.stopTest();
    }
    public static testMethod void runTestPerubahanAlamat1() {
        Contact con = [SELECT ID FROM Contact where Policy_No__c = '520-4931835'];
        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_ Perubahan Alamat Koresponden', 'POS', con.id);
        insert lbad;
        E_Form_Master_Data__c eform = createEFORMPDP(lbad.id, 'Request_POS_ Perubahan Alamat Koresponden', 'Perubahan Alamat Koresponden - 213', 'ifAlamat3');
        insert eform;
        system.debug('##### EFORM' + eform);
        List<E_Form_Master_Data__c> eformList = new List<E_Form_Master_Data__c>{eform};
        PageReference testPage = Page.VF_PerubahanDataPolisNew;
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('recordid',eformList[0].Id);
        ApexPages.currentPage().getParameters().put('formName', eformList[0].Name);
        ApexPages.currentPage().getParameters().put('subjectTransaction', eformList[0].Subdana_Tambahan_1__c);
        ApexPages.currentPage().getParameters().put('subjectTransactionNumber', eformList[0].Subdana_Tambahan_2__c);
        ApexPages.currentPage().getParameters().put('nameTT', eformList[0].Nama_Tertanggung__c);
        ApexPages.currentPage().getParameters().put('alasan', eformList[0].Alasan__c);
        ApexPages.currentPage().getParameters().put('NIK', eformList[0].Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('tanggalLahir', String.valueOf(eformList[0].Tanggal_Lahir__c));
        ApexPages.currentPage().getParameters().put('segmentasi', eformList[0].Segmentation__c);
        ApexPages.currentPage().getParameters().put('alamatSebelumnya', eformList[0].Alamat__c);
        ApexPages.currentPage().getParameters().put('alamatSebelumnyaTP', eformList[0].Alamat_Domisili_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('alamatTerbaru', eformList[0].Alamat_Terbaru__c);
        ApexPages.currentPage().getParameters().put('alamatTerbaruTP', eformList[0].Alamat_Terbaru_TP__c);
        ApexPages.StandardController stcs = new ApexPages.StandardController(eformList[0]);
        test.startTest();
        AMFS_PerubahanDataPolis_Controller cal2 = new AMFS_PerubahanDataPolis_Controller(stcs);
        test.stopTest();
    }
    public static testMethod void runTestPerubahanNomor1() {
        Contact con = [SELECT ID FROM Contact where Policy_No__c = '520-4931835'];
        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_Perubahan Nomor Kontak', 'POS', con.id);
        insert lbad;
        E_Form_Master_Data__c eform = createEFORMPDP(lbad.id, 'Request_POS_Perubahan Nomor Kontak', 'Perubahan Nomor Kontak - 213', 'ifNomor1');

        // insert eform;
        system.debug('##### EFORM' + eform);
        List<E_Form_Master_Data__c> eformList = new List<E_Form_Master_Data__c>{eform};
        PageReference testPage = Page.VF_PerubahanDataPolisNew;
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('recordid',eformList[0].Id);
        ApexPages.currentPage().getParameters().put('formName', eformList[0].Name);
        ApexPages.currentPage().getParameters().put('subjectTransaction', eformList[0].Subdana_Tambahan_1__c);
        ApexPages.currentPage().getParameters().put('subjectTransactionNumber', eformList[0].Subdana_Tambahan_2__c);
        ApexPages.currentPage().getParameters().put('nameTT', eformList[0].Nama_Tertanggung__c);
        ApexPages.currentPage().getParameters().put('alasan', eformList[0].Alasan__c);
        ApexPages.currentPage().getParameters().put('NIK', eformList[0].Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('tanggalLahir', String.valueOf(eformList[0].Tanggal_Lahir__c));
        ApexPages.currentPage().getParameters().put('segmentasi', eformList[0].Segmentation__c);

        ApexPages.currentPage().getParameters().put('nomorRumahSebelumnya', eformList[0].NPWP__c);
        ApexPages.currentPage().getParameters().put('nomorRumahSebelumnyaTP', eformList[0].NPWP_CP_1__c);
        ApexPages.currentPage().getParameters().put('nomorKantorSebelumnya', eformList[0].NPWP1__c);
        ApexPages.currentPage().getParameters().put('nomorKantorSebelumnyaTP', eformList[0].NPWP_CP_2__c);
        ApexPages.currentPage().getParameters().put('nomorSelulerSebelumnya', eformList[0].Nomor_Telpon__c);
        ApexPages.currentPage().getParameters().put('nomorSelulerSebelumnyaTP', eformList[0].Nomor_Identitas_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('nomorRumahTerbaru', eformList[0].Telepon_Rumah_Terbaru__c);
        ApexPages.currentPage().getParameters().put('nomorRumahTerbaruTP', eformList[0].Telepon_Rumah_Terbaru_TP__c);
        ApexPages.currentPage().getParameters().put('nomorKantorTerbaru', eformList[0].Telepon_Kantor_Terbaru__c);
        ApexPages.currentPage().getParameters().put('nomorKantorTerbaruTP', eformList[0].Telepon_Kantor_Terbaru_TP__c);
        ApexPages.currentPage().getParameters().put('nomorSelulerTerbaru', eformList[0].Telepon_Seluler_Terbaru__c);
        ApexPages.currentPage().getParameters().put('nomorSelulerTerbaruTP', eformList[0].Telepon_Seluler_Terbaru_TP__c);
        ApexPages.currentPage().getParameters().put('jenisPilihan', 'PP');
        ApexPages.StandardController stcs = new ApexPages.StandardController(eformList[0]);
        test.startTest();
        generatePDF('Request_POS_Perubahan Nomor Kontak', 'Perubahan Nomor Kontak', 'PP');
        AMFS_PerubahanDataPolis_Controller cal2 = new AMFS_PerubahanDataPolis_Controller(stcs);
        test.stopTest();
    }
    public static testMethod void runTestPerubahanNomor2() {
        Contact con = [SELECT ID FROM Contact where Policy_No__c = '520-4931835'];
        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_Perubahan Nomor Kontak', 'POS', con.id);
        insert lbad;
        E_Form_Master_Data__c eform = createEFORMPDP(lbad.id, 'Request_POS_Perubahan Nomor Kontak', 'Perubahan Nomor Kontak - 213', 'ifNomor2');
        // insert eform;
        system.debug('##### EFORM' + eform);
        List<E_Form_Master_Data__c> eformList = new List<E_Form_Master_Data__c>{eform};
        PageReference testPage = Page.VF_PerubahanDataPolisNew;
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('recordid',eformList[0].Id);
        ApexPages.currentPage().getParameters().put('formName', eformList[0].Name);
        ApexPages.currentPage().getParameters().put('subjectTransaction', eformList[0].Subdana_Tambahan_1__c);
        ApexPages.currentPage().getParameters().put('subjectTransactionNumber', eformList[0].Subdana_Tambahan_2__c);
        ApexPages.currentPage().getParameters().put('nameTT', eformList[0].Nama_Tertanggung__c);
        ApexPages.currentPage().getParameters().put('alasan', eformList[0].Alasan__c);
        ApexPages.currentPage().getParameters().put('NIK', eformList[0].Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('tanggalLahir', String.valueOf(eformList[0].Tanggal_Lahir__c));
        ApexPages.currentPage().getParameters().put('segmentasi', eformList[0].Segmentation__c);

        ApexPages.currentPage().getParameters().put('nomorRumahSebelumnya', eformList[0].NPWP__c);
        ApexPages.currentPage().getParameters().put('nomorRumahSebelumnyaTP', eformList[0].NPWP_CP_1__c);
        ApexPages.currentPage().getParameters().put('nomorKantorSebelumnya', eformList[0].NPWP1__c);
        ApexPages.currentPage().getParameters().put('nomorKantorSebelumnyaTP', eformList[0].NPWP_CP_2__c);
        ApexPages.currentPage().getParameters().put('nomorSelulerSebelumnya', eformList[0].Nomor_Telpon__c);
        ApexPages.currentPage().getParameters().put('nomorSelulerSebelumnyaTP', eformList[0].Nomor_Identitas_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('nomorRumahTerbaru', eformList[0].Telepon_Rumah_Terbaru__c);
        ApexPages.currentPage().getParameters().put('nomorRumahTerbaruTP', eformList[0].Telepon_Rumah_Terbaru_TP__c);
        ApexPages.currentPage().getParameters().put('nomorKantorTerbaru', eformList[0].Telepon_Kantor_Terbaru__c);
        ApexPages.currentPage().getParameters().put('nomorKantorTerbaruTP', eformList[0].Telepon_Kantor_Terbaru_TP__c);
        ApexPages.currentPage().getParameters().put('nomorSelulerTerbaru', eformList[0].Telepon_Seluler_Terbaru__c);
        ApexPages.currentPage().getParameters().put('nomorSelulerTerbaruTP', eformList[0].Telepon_Seluler_Terbaru_TP__c);
        ApexPages.currentPage().getParameters().put('jenisPilihan', 'TP');
        ApexPages.StandardController stcs = new ApexPages.StandardController(eformList[0]);
        test.startTest();
        generatePDF('Request_POS_Perubahan Nomor Kontak', 'Perubahan Nomor Kontak', 'TP');
        AMFS_PerubahanDataPolis_Controller cal2 = new AMFS_PerubahanDataPolis_Controller(stcs);
        test.stopTest();
    }
    public static testMethod void runTestPerubahanNomor3() {
        Contact con = [SELECT ID FROM Contact where Policy_No__c = '520-4931835'];
        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_Perubahan Nomor Kontak', 'POS', con.id);
        insert lbad;
        E_Form_Master_Data__c eform = createEFORMPDP(lbad.id, 'Request_POS_Perubahan Nomor Kontak', 'Perubahan Nomor Kontak - 213', 'ifNomor3');
        // insert eform;
        system.debug('##### EFORM' + eform);
        List<E_Form_Master_Data__c> eformList = new List<E_Form_Master_Data__c>{eform};
        PageReference testPage = Page.VF_PerubahanDataPolisNew;
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('recordid',eformList[0].Id);
        ApexPages.currentPage().getParameters().put('formName', eformList[0].Name);
        ApexPages.currentPage().getParameters().put('subjectTransaction', eformList[0].Subdana_Tambahan_1__c);
        ApexPages.currentPage().getParameters().put('subjectTransactionNumber', eformList[0].Subdana_Tambahan_2__c);
        ApexPages.currentPage().getParameters().put('nameTT', eformList[0].Nama_Tertanggung__c);
        ApexPages.currentPage().getParameters().put('alasan', eformList[0].Alasan__c);
        ApexPages.currentPage().getParameters().put('NIK', eformList[0].Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('tanggalLahir', String.valueOf(eformList[0].Tanggal_Lahir__c));
        ApexPages.currentPage().getParameters().put('segmentasi', eformList[0].Segmentation__c);

        ApexPages.currentPage().getParameters().put('nomorRumahSebelumnya', eformList[0].NPWP__c);
        ApexPages.currentPage().getParameters().put('nomorRumahSebelumnyaTP', eformList[0].NPWP_CP_1__c);
        ApexPages.currentPage().getParameters().put('nomorKantorSebelumnya', eformList[0].NPWP1__c);
        ApexPages.currentPage().getParameters().put('nomorKantorSebelumnyaTP', eformList[0].NPWP_CP_2__c);
        ApexPages.currentPage().getParameters().put('nomorSelulerSebelumnya', eformList[0].Nomor_Telpon__c);
        ApexPages.currentPage().getParameters().put('nomorSelulerSebelumnyaTP', eformList[0].Nomor_Identitas_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('nomorRumahTerbaru', eformList[0].Telepon_Rumah_Terbaru__c);
        ApexPages.currentPage().getParameters().put('nomorRumahTerbaruTP', eformList[0].Telepon_Rumah_Terbaru_TP__c);
        ApexPages.currentPage().getParameters().put('nomorKantorTerbaru', eformList[0].Telepon_Kantor_Terbaru__c);
        ApexPages.currentPage().getParameters().put('nomorKantorTerbaruTP', eformList[0].Telepon_Kantor_Terbaru_TP__c);
        ApexPages.currentPage().getParameters().put('nomorSelulerTerbaru', eformList[0].Telepon_Seluler_Terbaru__c);
        ApexPages.currentPage().getParameters().put('nomorSelulerTerbaruTP', eformList[0].Telepon_Seluler_Terbaru_TP__c);
        ApexPages.currentPage().getParameters().put('jenisPilihan', 'PPTP');
        ApexPages.StandardController stcs = new ApexPages.StandardController(eformList[0]);
        test.startTest();
        generatePDF('Request_POS_Perubahan Nomor Kontak', 'Perubahan Nomor Kontak', 'PPTP');
        AMFS_PerubahanDataPolis_Controller cal2 = new AMFS_PerubahanDataPolis_Controller(stcs);
        test.stopTest();
    }
    public static testMethod void runTestPerubahanKTP1() {
        Contact con = [SELECT ID FROM Contact where Policy_No__c = '520-4931835'];
        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_Perubahan ID KTP', 'POS', con.id);
        insert lbad;
        E_Form_Master_Data__c eform = createEFORMPDP(lbad.id, 'Request_POS_Perubahan ID KTP', 'Perubahan ID KTP - 213', 'ifKTP1');
        insert eform;
        system.debug('##### EFORM' + eform);
        List<E_Form_Master_Data__c> eformList = new List<E_Form_Master_Data__c>{eform};
        PageReference testPage = Page.VF_PerubahanDataPolisNew;
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('recordid',eformList[0].Id);
        ApexPages.currentPage().getParameters().put('formName', eformList[0].Name);
        ApexPages.currentPage().getParameters().put('subjectTransaction', eformList[0].Subdana_Tambahan_1__c);
        ApexPages.currentPage().getParameters().put('subjectTransactionNumber', eformList[0].Subdana_Tambahan_2__c);
        ApexPages.currentPage().getParameters().put('nameTT', eformList[0].Nama_Tertanggung__c);
        ApexPages.currentPage().getParameters().put('alasan', eformList[0].Alasan__c);
        ApexPages.currentPage().getParameters().put('NIK', eformList[0].Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('tanggalLahir', String.valueOf(eformList[0].Tanggal_Lahir__c));
        ApexPages.currentPage().getParameters().put('segmentasi', eformList[0].Segmentation__c);

        ApexPages.currentPage().getParameters().put('nomorKTPSebelumnya', eformList[0].Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('nomorKTPSebelumnyaTP', eformList[0].Nomor_Identitas_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('namaLengkapPP', eformList[0].Nama_Lengkap__c);
        ApexPages.currentPage().getParameters().put('namaLengkapTP', eformList[0].Nama_Tertanggung__c);
        ApexPages.currentPage().getParameters().put('nomorKTPTerbaru', eformList[0].Nomor_KTP_Terbaru__c);
        ApexPages.currentPage().getParameters().put('nomorKTPTerbaruTP', eformList[0].Nomor_KTP_Terbaru_TP__c);
        ApexPages.StandardController stcs = new ApexPages.StandardController(eformList[0]);
        test.startTest();
        generatePDF('Request_POS_Perubahan ID KTP', 'Perubahan ID KTP', '');
        AMFS_PerubahanDataPolis_Controller cal2 = new AMFS_PerubahanDataPolis_Controller(stcs);
        test.stopTest();
    }
    public static testMethod void runTestPerubahanKTP2() {
        Contact con = [SELECT ID FROM Contact where Policy_No__c = '520-4931835'];
        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_Perubahan ID KTP', 'POS', con.id);
        insert lbad;
        E_Form_Master_Data__c eform = createEFORMPDP(lbad.id, 'Request_POS_Perubahan ID KTP', 'Perubahan ID KTP - 213', 'ifKTP2');
        insert eform;
        system.debug('##### EFORM' + eform);
        List<E_Form_Master_Data__c> eformList = new List<E_Form_Master_Data__c>{eform};
        PageReference testPage = Page.VF_PerubahanDataPolisNew;
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('recordid',eformList[0].Id);
        ApexPages.currentPage().getParameters().put('formName', eformList[0].Name);
        ApexPages.currentPage().getParameters().put('subjectTransaction', eformList[0].Subdana_Tambahan_1__c);
        ApexPages.currentPage().getParameters().put('subjectTransactionNumber', eformList[0].Subdana_Tambahan_2__c);
        ApexPages.currentPage().getParameters().put('nameTT', eformList[0].Nama_Tertanggung__c);
        ApexPages.currentPage().getParameters().put('alasan', eformList[0].Alasan__c);
        ApexPages.currentPage().getParameters().put('NIK', eformList[0].Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('tanggalLahir', String.valueOf(eformList[0].Tanggal_Lahir__c));
        ApexPages.currentPage().getParameters().put('segmentasi', eformList[0].Segmentation__c);

        ApexPages.currentPage().getParameters().put('nomorKTPSebelumnya', eformList[0].Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('nomorKTPSebelumnyaTP', eformList[0].Nomor_Identitas_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('namaLengkapPP', eformList[0].Nama_Lengkap__c);
        ApexPages.currentPage().getParameters().put('namaLengkapTP', eformList[0].Nama_Tertanggung__c);
        ApexPages.currentPage().getParameters().put('nomorKTPTerbaru', eformList[0].Nomor_KTP_Terbaru__c);
        ApexPages.currentPage().getParameters().put('nomorKTPTerbaruTP', eformList[0].Nomor_KTP_Terbaru_TP__c);
        ApexPages.StandardController stcs = new ApexPages.StandardController(eformList[0]);
        test.startTest();
        AMFS_PerubahanDataPolis_Controller cal2 = new AMFS_PerubahanDataPolis_Controller(stcs);
        test.stopTest();
    }
    public static testMethod void runTestPerubahanKTP3() {
        Contact con = [SELECT ID FROM Contact where Policy_No__c = '520-4931835'];
        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_Perubahan ID KTP', 'POS', con.id);
        insert lbad;
        E_Form_Master_Data__c eform = createEFORMPDP(lbad.id, 'Request_POS_Perubahan ID KTP', 'Perubahan ID KTP - 213', 'ifKTP3');
        insert eform;
        system.debug('##### EFORM' + eform);
        List<E_Form_Master_Data__c> eformList = new List<E_Form_Master_Data__c>{eform};
        PageReference testPage = Page.VF_PerubahanDataPolisNew;
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('recordid',eformList[0].Id);
        ApexPages.currentPage().getParameters().put('formName', eformList[0].Name);
        ApexPages.currentPage().getParameters().put('subjectTransaction', eformList[0].Subdana_Tambahan_1__c);
        ApexPages.currentPage().getParameters().put('subjectTransactionNumber', eformList[0].Subdana_Tambahan_2__c);
        ApexPages.currentPage().getParameters().put('nameTT', eformList[0].Nama_Tertanggung__c);
        ApexPages.currentPage().getParameters().put('alasan', eformList[0].Alasan__c);
        ApexPages.currentPage().getParameters().put('NIK', eformList[0].Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('tanggalLahir', String.valueOf(eformList[0].Tanggal_Lahir__c));
        ApexPages.currentPage().getParameters().put('segmentasi', eformList[0].Segmentation__c);

        ApexPages.currentPage().getParameters().put('nomorKTPSebelumnya', eformList[0].Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('nomorKTPSebelumnyaTP', eformList[0].Nomor_Identitas_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('namaLengkapPP', eformList[0].Nama_Lengkap__c);
        ApexPages.currentPage().getParameters().put('namaLengkapTP', eformList[0].Nama_Tertanggung__c);
        ApexPages.currentPage().getParameters().put('nomorKTPTerbaru', eformList[0].Nomor_KTP_Terbaru__c);
        ApexPages.currentPage().getParameters().put('nomorKTPTerbaruTP', eformList[0].Nomor_KTP_Terbaru_TP__c);
        ApexPages.StandardController stcs = new ApexPages.StandardController(eformList[0]);
        test.startTest();
        AMFS_PerubahanDataPolis_Controller cal2 = new AMFS_PerubahanDataPolis_Controller(stcs);
        test.stopTest();
    }
    public static testMethod void runTestPerubahanCuti1() {
        Contact con = [SELECT ID FROM Contact where Policy_No__c = '520-4931835'];
        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_Cuti Premi', 'POS', con.id);
        insert lbad;
        E_Form_Master_Data__c eform = createEFORMPDP(lbad.id, 'Request_POS_Cuti Premi', 'Pengajuan Cuti Premi - 213', 'ifCuti1');
        insert eform;
        system.debug('##### EFORM' + eform);
        List<E_Form_Master_Data__c> eformList = new List<E_Form_Master_Data__c>{eform};
        PageReference testPage = Page.VF_PerubahanDataPolisNew;
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('recordid',eformList[0].Id);
        ApexPages.currentPage().getParameters().put('formName', eformList[0].Name);
        ApexPages.currentPage().getParameters().put('subjectTransaction', eformList[0].Subdana_Tambahan_1__c);
        ApexPages.currentPage().getParameters().put('subjectTransactionNumber', eformList[0].Subdana_Tambahan_2__c);
        ApexPages.currentPage().getParameters().put('nameTT', eformList[0].Nama_Tertanggung__c);
        ApexPages.currentPage().getParameters().put('alasan', eformList[0].Alasan__c);
        ApexPages.currentPage().getParameters().put('NIK', eformList[0].Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('tanggalLahir', String.valueOf(eformList[0].Tanggal_Lahir__c));
        ApexPages.currentPage().getParameters().put('segmentasi', eformList[0].Segmentation__c);
        ApexPages.StandardController stcs = new ApexPages.StandardController(eformList[0]);
        test.startTest();
        generatePDF('Request_POS_Cuti Premi', 'Pengajuan Cuti Premi', '');
        AMFS_PerubahanDataPolis_Controller cal2 = new AMFS_PerubahanDataPolis_Controller(stcs);
        test.stopTest();
    }
    public static testMethod void runTestPerubahanAhli1() {
        Contact con = [SELECT ID FROM Contact where Policy_No__c = '520-4931835'];
        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_Perubahan Ahli waris', 'POS', con.id);
        insert lbad;
        E_Form_Master_Data__c eform = createEFORMPDP(lbad.id, 'Request_POS_Perubahan Ahli waris', 'Perubahan Termaslahat (Penerima Manfaat) - 213', 'ifAhli1');
        insert eform;
        system.debug('##### EFORM' + eform);
        List<E_Form_Master_Data__c> eformList = new List<E_Form_Master_Data__c>{eform};
        PageReference testPage = Page.VF_PerubahanDataPolisNew;
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('recordid',eformList[0].Id);
        ApexPages.currentPage().getParameters().put('formName', eformList[0].Name);
        ApexPages.currentPage().getParameters().put('subjectTransaction', eformList[0].Subdana_Tambahan_1__c);
        ApexPages.currentPage().getParameters().put('subjectTransactionNumber', eformList[0].Subdana_Tambahan_2__c);
        ApexPages.currentPage().getParameters().put('nameTT', eformList[0].Nama_Tertanggung__c);
        ApexPages.currentPage().getParameters().put('alasan', eformList[0].Alasan__c);
        ApexPages.currentPage().getParameters().put('NIK', eformList[0].Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('tanggalLahir', String.valueOf(eformList[0].Tanggal_Lahir__c));
        ApexPages.currentPage().getParameters().put('segmentasi', eformList[0].Segmentation__c);

        ApexPages.currentPage().getParameters().put('dataAhliWaris1', eformList[0].Penerima_Manfaat_1__c);
        ApexPages.currentPage().getParameters().put('dataAhliWaris2', eformList[0].Penerima_Manfaat_2__c);
        ApexPages.currentPage().getParameters().put('dataAhliWaris3', eformList[0].Penerima_Manfaat_3__c);
        ApexPages.currentPage().getParameters().put('dataAhliWaris4', eformList[0].Penerima_Manfaat_4__c);
        ApexPages.currentPage().getParameters().put('dataAhliWaris5', eformList[0].Penerima_Manfaat_5__c);
        ApexPages.StandardController stcs = new ApexPages.StandardController(eformList[0]);
        test.startTest();
        AMFS_PerubahanDataPolis_Controller cal2 = new AMFS_PerubahanDataPolis_Controller(stcs);
        test.stopTest();
    }
    public static testMethod void runTestPerubahanAhli2() {
        Contact con = [SELECT ID FROM Contact where Policy_No__c = '520-4931835'];
        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_Perubahan Ahli waris', 'POS', con.id);
        insert lbad;
        E_Form_Master_Data__c eform = createEFORMPDP(lbad.id, 'Request_POS_Perubahan Ahli waris', 'Perubahan Termaslahat (Penerima Manfaat) - 213', 'ifAhli2');
        insert eform;
        system.debug('##### EFORM' + eform);
        List<E_Form_Master_Data__c> eformList = new List<E_Form_Master_Data__c>{eform};
        PageReference testPage = Page.VF_PerubahanDataPolisNew;
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('recordid',eformList[0].Id);
        ApexPages.currentPage().getParameters().put('formName', eformList[0].Name);
        ApexPages.currentPage().getParameters().put('subjectTransaction', eformList[0].Subdana_Tambahan_1__c);
        ApexPages.currentPage().getParameters().put('subjectTransactionNumber', eformList[0].Subdana_Tambahan_2__c);
        ApexPages.currentPage().getParameters().put('nameTT', eformList[0].Nama_Tertanggung__c);
        ApexPages.currentPage().getParameters().put('alasan', eformList[0].Alasan__c);
        ApexPages.currentPage().getParameters().put('NIK', eformList[0].Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('tanggalLahir', String.valueOf(eformList[0].Tanggal_Lahir__c));
        ApexPages.currentPage().getParameters().put('segmentasi', eformList[0].Segmentation__c);

        ApexPages.currentPage().getParameters().put('dataAhliWaris1', eformList[0].Penerima_Manfaat_1__c);
        ApexPages.currentPage().getParameters().put('dataAhliWaris2', eformList[0].Penerima_Manfaat_2__c);
        ApexPages.currentPage().getParameters().put('dataAhliWaris3', eformList[0].Penerima_Manfaat_3__c);
        ApexPages.currentPage().getParameters().put('dataAhliWaris4', eformList[0].Penerima_Manfaat_4__c);
        ApexPages.currentPage().getParameters().put('dataAhliWaris5', eformList[0].Penerima_Manfaat_5__c);
        ApexPages.StandardController stcs = new ApexPages.StandardController(eformList[0]);
        test.startTest();
        generatePDF('Request_POS_Perubahan Ahli waris', 'Perubahan Termaslahat (Penerima Manfaat)', '');
        AMFS_PerubahanDataPolis_Controller cal2 = new AMFS_PerubahanDataPolis_Controller(stcs);
        AMFS_PerubahanDataPolis_Controller.generateMetadata(eform);
        test.stopTest();
    }

    private static Log_Book_Activitiy__c createLBA() {
        Log_Book_Activitiy__c logBook = new Log_Book_Activitiy__c();
        logBook.Touch_Point__c = 'Head Office';
        logBook.Log_Book_Date__c = Date.today();
        logBook.Queue_No__c = 'A001';
        logBook.Time_In__c = Time.newInstance(15, 0, 0, 0);
        logBook.Time_Served__c = Time.newInstance(15, 3, 0, 0);
        logBook.Time_Out__c = Time.newInstance(15, 20, 0, 0);
        logBook.Waiting_Time__c = '0 hours 3 minutes';
        logBook.Handling_Time__c = '0 hours 17 minutes';
        logBook.Type__c = 'Walk-In';

        return logBook;
    }
    
    private static Log_Book_Activitiy_Detail__c createLBAD(String lbid, String transactionType, String dept, String contID) {

        Log_Book_Activitiy_Detail__c  logBookDetail = new Log_Book_Activitiy_Detail__c();
        logBookDetail.Policy_Number__c = '100-123-1234567';
        logBookDetail.Policy_Name_Holder__c = 'RIRIN LINDAWATI';
        logBookDetail.Product_Type__c = 'DMTM';
        logBookDetail.Customer_Name__c = 'ririn';
        logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        logBookDetail.Is_Policy_Holder__c =  true;
        if(transactionType == 'Request_POS Cooling off'){
            logBookDetail.Segmentation__c = 'Reguler';
        }else{
            logBookDetail.Segmentation__c = 'Preferred Banking Customer';            
        }
        
        logBookDetail.Department__c = dept;
        logBookDetail.Kind_Of_Transaction__c = transactionType;
        logBookDetail.Document_Type__c = 'New Submission';
        logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];';
        logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logBookDetail.Stamp__c = 2;
        logBookDetail.Dokumen_Tambahan__c = null;
         
        logBookDetail.Customer_Mood__c = 'Normal';
        logBookDetail.Status__c = 'Closed';
        logBookDetail.Log_Book_Activitiy__c = lbid;
        logBookDetail.Contact_Policy__c = contID;
        return logBookDetail;
    }
    
    private static E_Form_Master_Data__c createEFORM(String lbid, String transactionType, String name, String subdana) {
        E_Form_Master_Data__c eform = new E_Form_Master_Data__c(
            Log_Book_Activitiy_Detail__c = lbid,
            Transaction_Type__c = transactionType,
            Name = name,

            Alamat__c = 'ALAMAT',
            Alamat_Domisili__c = 'ALAMAT',
            Alamat_Domisili_Controlling_Person__c = 'ALAMAT',
            Alasan_CP_1__c = 'ALAMAT',
            Alasan_CP_2__c = 'ALAMAT',
            Alasan_CP_3__c = 'ALAMAT',
            Alasan_Penarikan_Dana__c = 'Butuh dana',
            Alasan_Tidak_Ada_NPWP__c = 'ALAMAT',
            Alasan_Tidak_Ada_NPWP1__c = 'ALAMAT',
            Alasan_Tidak_Ada_NPWP2__c = 'ALAMAT',
            Apakah_Badan_Usaha_ini_melakukan_pelapor__c = 'YA',
            Apakah_Controlling_Person_ini_melakukan__c = 'YA',
            Biaya_Transaksi__c = 10000,
            case_type__c = 'Pengalihan subdana yang telah terhimpun saja (Pengalihan Dana)',
            code_subdana_1__c = 'ALAMAT',
            code_subdana_2__c = 'ALAMAT',
            code_subdana_3__c = 'ALAMAT',
            code_subdana_4__c = 'ALAMAT',
            Currency__c = 'Rp',
            Email__c = 'ALAMAT',
            hubungan_dengan_pemilik_rekening__c = 'Diri Sendiri',
            informasi_pajak_luar_negeri__c = 'YA',
            Jabatan__c = 'ALAMAT',
            Jenis_Identitas_Controlling_Person__c = 'KTP',
            Jumlah_Penarikan_Dana__c = 4000000,
            Jumlah_Setelah_Biaya_Transaksi__c = 5000000,
            Kewarganegaraan__c = 'ALAMAT',
            Kode_Pos__c = 'ALAMAT',
            Kode_Pos_Controlling_Persong__c = 'ALAMAT',
            Kota__c = 'ALAMAT',
            Kota_Controlling_Person__c = 'ALAMAT',
            lainnya__c = 'ALAMAT',
            Mata_Uang__c = 'ALAMAT',
            Nama_Bank__c = 'ALAMAT',
            Nama_Controlling_Person_Perusahaan__c = 'ALAMAT',
            Nama_Lengkap__c = 'ALAMAT',
            Nama_Pemilik_Polis__c = 'ALAMAT',
            Nama_Perusahaan__c = 'ALAMAT',
            Nama_Pihak_Berwenang_Pemegang_Polis__c = 'ALAMAT',
            Nama_Produk__c = 'ALAMAT',
            nama_rekening__c = 'ALAMAT',
            nama_subdana_1__c = subdana,
            nama_subdana_2__c = subdana,
            nama_subdana_3__c = subdana,
            nama_subdana_4__c = subdana,
            Nama_Tertanggung__c = 'ALAMAT',
            Negara_Domisili__c = 'ALAMAT',
            Negara_Domisili_Controlling_Person__c = 'ALAMAT',
            Negara_Pelaporan_Pajak__c = 'Amerika',
            Negara_Terdaftar_Wajib_Pajak__c = 'ALAMAT',
            Negara_Terdaftar_Wajib_Pajak_CP_1__c = 'ALAMAT',
            Negara_Terdaftar_Wajib_Pajak_CP_2__c = 'ALAMAT',
            Negara_Terdaftar_Wajib_Pajak_CP_3__c = 'ALAMAT',
            Negara_Terdaftar_Wajib_Pajak1__c = 'ALAMAT',
            Negara_Terdaftar_Wajib_Pajak2__c = 'ALAMAT',
            Nilai_Tunai_Sementara__c = 50000,
            No_Rekening__c = 'ALAMAT',
            Nominal__c = 50000,
            Nomor_Anggaran_Dasar_Perusahaan__c = 'ALAMAT',
            Nomor_Identitas_Controlling_Person__c = 'ALAMAT',
            Nomor_Kartu_Identitas__c = 'ALAMAT',
            Nomor_Polis__c = 'ALAMAT',
            Nomor_TDP_SDP__c = 'ALAMAT',
            Nomor_Telpon__c = 'ALAMAT',
            NPWP__c = 'ALAMAT',
            NPWP1__c = 'ALAMAT',
            NPWP2__c = 'ALAMAT',
            NPWP_CP_1__c = 'ALAMAT',
            NPWP_CP_2__c = 'ALAMAT',
            NPWP_CP_3__c = 'ALAMAT',
            Pasport__c = 'ALAMAT',
            Pasport_CP__c = 'ALAMAT',
            Payment_Method__c = 'Transfer',
            pekerjaan__c = 'ALAMAT',
            Pendapatan__c = 58000,
            Penghasilan_per_Bulan__c = '9908900',
            persentase_1__c = 10,
            persentase_2__c = 10,
            persentase_3__c = 10,
            persentase_4__c = 10,
            Persentase_Tambahan_1__c = 10,
            Persentase_Tambahan_2__c = 10,
            Persentase_Tambahan_3__c = 10,
            Persentase_Tambahan_4__c = 10,
            Plan_Code__c = 'HONMPH',
            Sisa_Dana__c = 785555,
            Subdana_Tambahan_1__c = 'ZRAC-MANDIRI ACTIVE BALANCED MONEY RUPIAH',
            Subdana_Tambahan_2__c = 'ZRAC-MANDIRI ACTIVE BALANCED MONEY RUPIAH',
            Subdana_Tambahan_3__c = 'ZRAC-MANDIRI ACTIVE BALANCED MONEY RUPIAH',
            Subdana_Tambahan_4__c = 'ZRAC-MANDIRI ACTIVE BALANCED MONEY RUPIAH',
            Sumber_Dana_Lainnya__c = 'ALAMAT',
            sumberdana__c = 'Lainnya',
            Tempat_Lahir__c = 'ALAMAT',
            Tempat_Lahir_Controlling_Person__c = 'ALAMAT',
            Tanggal_Anggaran_Dasar_Perusahaan__c = system.today(),
            Tanggal_Lahir__c = system.today(),
            Tanggal_Lahir_Controlling_Person__c = system.today(),
            Tanggal_Pengajuan__c = system.today(),
            Top_Up_Currency__c = 'Rp',
            Total_Dana_Awal__c = 485555,
            total_nominal_1__c = 485555,
            total_nominal_2__c = 485555,
            total_nominal_3__c = 485555,
            total_nominal_4__c = 485555,
            tujuan__c = 'Lainnya',
            Tujuan_Lainnya__c = 'ALAMAT',
            SKDR_SKDKK__c = 'SKDR'
            );
        return eform;
    }

    private static E_Form_Master_Data__c createEFORMPDP(String lbid, String transactionType, String name, String condition) {
        E_Form_Master_Data__c eform = new E_Form_Master_Data__c();
        eform.Log_Book_Activitiy_Detail__c = lbid;
        eform.Transaction_Type__c = transactionType;
        eform.Name = name;
        eform.informasi_pajak_luar_negeri__c = 'YA';
        eform.Negara_Pelaporan_Pajak__c = 'Amerika';
        eform.Nomor_Polis__c = '2323-2323';
        eform.Plan_Code__c = 'ABCD';
        eform.Segmentation__c = 'PBC';
        eform.Tanggal_Pengajuan__c = system.today();
        eform.Nomor_Telpon__c = '00000';
        eform.Nama_Pemilik_Polis__c = 'nama pemilik polis';
        eform.Nomor_Kartu_Identitas__c = '123123123';
        eform.Tanggal_Lahir__c = system.today();
        eform.Alamat__c = 'ALAMAT';
        eform.Email__c = 'Email@Emila.Email.df';
        eform.Nama_Produk__c = 'Nama Product';
        eform.Nama_Produk__c = 'Nama Product';
        eform.Nama_Tertanggung__c = 'Nama Tertanggung';
        eform.Subdana_Tambahan_1__c = 'Subject';
        eform.Subdana_Tambahan_2__c = 'Subject Number';
        if(name.contains('Perubahan Alamat Email')){
            if(condition == 'ifEmaail1'){
                system.debug('##### Masuk Kondisi 1');
                eform.Email_Sebelumnya_TP__c = 'email sebelumnya TP';
                eform.Email_Terbaru__c = 'email terbaru';
                eform.Email_Terbaru_TP__c = 'email terbaru TP';
                eform.Alasan__c = 'Alasan Email';
            }
            else if(condition == 'ifEmaail2'){
                system.debug('##### Masuk Kondisi 2');
                eform.Email_Sebelumnya_TP__c = 'email sebelumnya TP';
                eform.Email_Terbaru__c = 'email terbaru';
                eform.Email_Terbaru_TP__c = '-';
                eform.Alasan__c = 'Alasan Email';
            }
            else if(condition == 'ifEmaail3'){
                system.debug('##### Masuk Kondisi 3');
                eform.Email_Sebelumnya_TP__c = 'email sebelumnya TP';
                eform.Email_Terbaru__c = '-';
                eform.Email_Terbaru_TP__c = 'Email terbaru tp';
                eform.Alasan__c = 'Alasan Email';
            }
        }
        else if(name.contains('Perubahan Alamat Koresponden')){
            if(condition == 'ifAlamat1'){
                eform.Alamat_Domisili_Controlling_Person__c = 'email sebelumnya TP';
                eform.Alamat_Terbaru__c = 'email terbaru';
                eform.Alamat_Terbaru_TP__c = 'email terbaru TP';
                eform.Alasan__c = 'Alasan Email';
            }
            else if(condition == 'ifAlamat2'){
                eform.Alamat_Domisili_Controlling_Person__c = 'email sebelumnya TP';
                eform.Alamat_Terbaru__c = 'email terbaru';
                eform.Alamat_Terbaru_TP__c = '-';
                eform.Alasan__c = 'Alasan Email';
            }
            else if(condition == 'ifAlamat3'){
                eform.Alamat_Domisili_Controlling_Person__c = 'email sebelumnya TP';
                eform.Alamat_Terbaru__c = '-';
                eform.Alamat_Terbaru_TP__c = 'email terbaru TP';
                eform.Alasan__c = 'Alasan Email';
            }
        }
        else if(name.contains('Perubahan Nomor Kontak')){
            if(condition == 'ifNomor1'){
                eform.NPWP__c = 'nomorRumahSebelumnya';
                eform.NPWP_CP_1__c = 'nomorRumahSebelumnyaTP';
                eform.NPWP1__c = 'nomorKantorSebelumnya';
                eform.NPWP_CP_2__c = 'nomorKantorSebelumnyaTP';
                eform.Nomor_Telpon__c = 'nomorSelulerSebelumnya';
                eform.Nomor_Identitas_Controlling_Person__c = 'nomorSelulerSebelumnyaTP';
                eform.Telepon_Rumah_Terbaru__c = 'nomorRumahTerbaru';
                eform.Telepon_Rumah_Terbaru_TP__c = '-';
                eform.Telepon_Kantor_Terbaru__c = 'nomorKantorTerbaru';
                eform.Telepon_Kantor_Terbaru_TP__c = '-';
                eform.Telepon_Seluler_Terbaru__c = 'nomorSelulerTerbaru';
                eform.Telepon_Seluler_Terbaru_TP__c = '-';
                eform.Alasan__c = 'Alasan Email';
            }
            else if(condition == 'ifNomor2'){
                eform.NPWP__c = 'nomorRumahSebelumnya';
                eform.NPWP_CP_1__c = 'nomorRumahSebelumnyaTP';
                eform.NPWP1__c = 'nomorKantorSebelumnya';
                eform.NPWP_CP_2__c = 'nomorKantorSebelumnyaTP';
                eform.Nomor_Telpon__c = 'nomorSelulerSebelumnya';
                eform.Nomor_Identitas_Controlling_Person__c = 'nomorSelulerSebelumnyaTP';
                eform.Telepon_Rumah_Terbaru__c = '-';
                eform.Telepon_Rumah_Terbaru_TP__c = 'nomorRumahTerbaruTP';
                eform.Telepon_Kantor_Terbaru__c = '-';
                eform.Telepon_Kantor_Terbaru_TP__c = 'nomorKantorTerbaruTP';
                eform.Telepon_Seluler_Terbaru__c = '-';
                eform.Telepon_Seluler_Terbaru_TP__c = 'nomorSelulerTerbaruTP';
                eform.Alasan__c = 'Alasan Email';
            }
            else if(condition == 'ifNomor3'){
                eform.NPWP__c = 'nomorRumahSebelumnya';
                eform.NPWP_CP_1__c = 'nomorRumahSebelumnyaTP';
                eform.NPWP1__c = 'nomorKantorSebelumnya';
                eform.NPWP_CP_2__c = 'nomorKantorSebelumnyaTP';
                eform.Nomor_Telpon__c = 'nomorSelulerSebelumnya';
                eform.Nomor_Identitas_Controlling_Person__c = 'nomorSelulerSebelumnyaTP';
                eform.Telepon_Rumah_Terbaru__c = 'nomorRumahTerbaru';
                eform.Telepon_Rumah_Terbaru_TP__c = 'nomorRumahTerbaruTP';
                eform.Telepon_Kantor_Terbaru__c = 'nomorKantorTerbaru';
                eform.Telepon_Kantor_Terbaru_TP__c = 'nomorKantorTerbaruTP';
                eform.Telepon_Seluler_Terbaru__c = 'nomorSelulerTerbaru';
                eform.Telepon_Seluler_Terbaru_TP__c = 'nomorSelulerTerbaruTP';
                eform.Alasan__c = 'Alasan Email';
            }
        }
        else if(name.contains('Perubahan ID KTP')){
            if(condition == 'ifKTP1'){
                eform.Nomor_Kartu_Identitas__c = 'nomorRumahSebelumnya';
                eform.Nomor_Identitas_Controlling_Person__c = 'nomorRumahSebelumnyaTP';
                eform.Nama_Lengkap__c = 'nomorKantorSebelumnya';
                eform.Nama_Tertanggung__c = 'nomorKantorSebelumnyaTP';
                eform.Nomor_KTP_Terbaru__c = 'nomorSelulerSebelumnya';
                eform.Nomor_KTP_Terbaru_TP__c = 'nomorSelulerSebelumnyaTP';
                eform.Alasan__c = 'Alasan Email';
            }
            else if(condition == 'ifKTP2'){
                eform.Nomor_Kartu_Identitas__c = 'nomorRumahSebelumnya';
                eform.Nomor_Identitas_Controlling_Person__c = 'nomorRumahSebelumnyaTP';
                eform.Nama_Lengkap__c = 'nomorKantorSebelumnya';
                eform.Nama_Tertanggung__c = 'nomorKantorSebelumnyaTP';
                eform.Nomor_KTP_Terbaru__c = 'nomorSelulerSebelumnya';
                eform.Nomor_KTP_Terbaru_TP__c = '-';
                eform.Alasan__c = 'Alasan Email';
            }
            else if(condition == 'ifKTP3'){
                eform.Nomor_Kartu_Identitas__c = 'nomorRumahSebelumnya';
                eform.Nomor_Identitas_Controlling_Person__c = 'nomorRumahSebelumnyaTP';
                eform.Nama_Lengkap__c = 'nomorKantorSebelumnya';
                eform.Nama_Tertanggung__c = 'nomorKantorSebelumnyaTP';
                eform.Nomor_KTP_Terbaru__c = '-';
                eform.Nomor_KTP_Terbaru_TP__c = 'nomorSelulerSebelumnyaTP';
                eform.Alasan__c = 'Alasan Email';
            }
        }
        else if(name.contains('Pengajuan Cuti Premi')){
            if(condition == 'ifKTP1'){
                eform.Nomor_Kartu_Identitas__c = 'nomorRumahSebelumnya';
                eform.Nomor_Identitas_Controlling_Person__c = 'nomorRumahSebelumnyaTP';
                eform.Nama_Lengkap__c = 'nomorKantorSebelumnya';
                eform.Nama_Tertanggung__c = 'nomorKantorSebelumnyaTP';
                eform.Nomor_KTP_Terbaru__c = 'nomorSelulerSebelumnya';
                eform.Nomor_KTP_Terbaru_TP__c = 'nomorSelulerSebelumnyaTP';
                eform.Alasan__c = 'Alasan Email';
            }
        }
        else if(name.contains('Perubahan Termaslahat (Penerima Manfaat)')){
            if(condition == 'ifAhli1'){
                eform.Penerima_Manfaat_1__c = 'C;2/9/2025;L;2222222222222222;30;ANAK';
                eform.Penerima_Manfaat_2__c = 'C;2/9/2025;L;2222222222222222;30;ANAK';
                eform.Penerima_Manfaat_3__c = 'C;2/9/2025;L;2222222222222222;30;ANAK';
                eform.Penerima_Manfaat_4__c = 'C;2/9/2025;L;2222222222222222;30;ANAK';
                eform.Penerima_Manfaat_5__c = 'C;2/9/2025;L;2222222222222222;30;ANAK';
                eform.Alasan__c = 'Alasan Email';
            }
            if(condition == 'ifAhli2'){
                eform.Penerima_Manfaat_1__c = ';//;;;;';
                eform.Penerima_Manfaat_2__c = ';//;;;;';
                eform.Penerima_Manfaat_3__c = ';//;;;;';
                eform.Penerima_Manfaat_4__c = ';//;;;;';
                eform.Penerima_Manfaat_5__c = ';//;;;;';
                eform.Alasan__c = 'Alasan Email';
            }
        }
        
        return eform;
    }

    private static E_Form_Master_Data__c createEFORMNonSubdana(String lbid, String transactionType, String name, String subdana) {
        E_Form_Master_Data__c eform = new E_Form_Master_Data__c(
            Log_Book_Activitiy_Detail__c = lbid,
            Transaction_Type__c = transactionType,
            Name = name,

            Alamat__c = 'ALAMAT',
            Alamat_Domisili__c = 'ALAMAT',
            Alamat_Domisili_Controlling_Person__c = 'ALAMAT',
            Alasan_CP_1__c = 'ALAMAT',
            Alasan_CP_2__c = 'ALAMAT',
            Alasan_CP_3__c = 'ALAMAT',
            Alasan_Lainnya__c = 'ALAMAT',
            Alasan_Penarikan_Dana__c = 'Butuh dana',
            Alasan_Tidak_Ada_NPWP__c = 'ALAMAT',
            Alasan_Tidak_Ada_NPWP1__c = 'ALAMAT',
            Alasan_Tidak_Ada_NPWP2__c = 'ALAMAT',
            Apakah_Badan_Usaha_ini_melakukan_pelapor__c = 'Ya',
            Apakah_Controlling_Person_ini_melakukan__c = 'Ya',
            Biaya_Transaksi__c = 10000,
            case_type__c = 'Pengalihan subdana yang telah terhimpun saja (Pengalihan Dana)',
            code_subdana_1__c = 'ALAMAT',
            code_subdana_2__c = 'ALAMAT',
            code_subdana_3__c = 'ALAMAT',
            code_subdana_4__c = 'ALAMAT',
            Currency__c = 'Rp',
            Email__c = 'ALAMAT',
            hubungan_dengan_pemilik_rekening__c = 'Diri Sendiri',
            informasi_pajak_luar_negeri__c = 'YA',
            Jabatan__c = 'ALAMAT',
            Jenis_Identitas_Controlling_Person__c = 'KTP',
            Jumlah_Penarikan_Dana__c = 200000000,
            Jumlah_Setelah_Biaya_Transaksi__c = 5000000,
            Kewarganegaraan__c = 'ALAMAT',
            Kode_Pos__c = 'ALAMAT',
            Kode_Pos_Controlling_Persong__c = 'ALAMAT',
            Kota__c = 'ALAMAT',
            Kota_Controlling_Person__c = 'ALAMAT',
            lainnya__c = 'ALAMAT',
            Mata_Uang__c = 'ALAMAT',
            Nama_Bank__c = 'ALAMAT',
            Nama_Controlling_Person_Perusahaan__c = 'ALAMAT',
            Nama_Lengkap__c = 'ALAMAT',
            Nama_Pemilik_Polis__c = 'ALAMAT',
            Nama_Perusahaan__c = 'ALAMAT',
            Nama_Pihak_Berwenang_Pemegang_Polis__c = 'ALAMAT',
            Nama_Produk__c = 'ALAMAT',
            nama_rekening__c = 'ALAMAT',
            Nama_Tertanggung__c = 'ALAMAT',
            Negara_Domisili__c = 'ALAMAT',
            Negara_Domisili_Controlling_Person__c = 'ALAMAT',
            Negara_Pelaporan_Pajak__c = 'Amerika',
            Negara_Terdaftar_Wajib_Pajak__c = 'ALAMAT',
            Negara_Terdaftar_Wajib_Pajak_CP_1__c = 'ALAMAT',
            Negara_Terdaftar_Wajib_Pajak_CP_2__c = 'ALAMAT',
            Negara_Terdaftar_Wajib_Pajak_CP_3__c = 'ALAMAT',
            Negara_Terdaftar_Wajib_Pajak1__c = 'ALAMAT',
            Negara_Terdaftar_Wajib_Pajak2__c = 'ALAMAT',
            Nilai_Tunai_Sementara__c = 50000,
            No_Rekening__c = 'ALAMAT',
            Nominal__c = 50000,
            Nomor_Anggaran_Dasar_Perusahaan__c = 'ALAMAT',
            Nomor_Identitas_Controlling_Person__c = 'ALAMAT',
            Nomor_Kartu_Identitas__c = 'ALAMAT',
            Nomor_Polis__c = 'ALAMAT',
            Nomor_TDP_SDP__c = 'ALAMAT',
            Nomor_Telpon__c = 'ALAMAT',
            NPWP__c = 'ALAMAT',
            NPWP1__c = 'ALAMAT',
            NPWP2__c = 'ALAMAT',
            NPWP_CP_1__c = 'ALAMAT',
            NPWP_CP_2__c = 'ALAMAT',
            NPWP_CP_3__c = 'ALAMAT',
            Pasport__c = 'ALAMAT',
            Pasport_CP__c = 'ALAMAT',
            Payment_Method__c = 'Transfer',
            pekerjaan__c = 'ALAMAT',
            Pendapatan__c = 58000,
            Penghasilan_per_Bulan__c = '9908900',
            persentase_1__c = 10,
            persentase_2__c = 10,
            persentase_3__c = 10,
            persentase_4__c = 10,
            Persentase_Tambahan_1__c = 10,
            Persentase_Tambahan_2__c = 10,
            Persentase_Tambahan_3__c = 10,
            Persentase_Tambahan_4__c = 10,
            Plan_Code__c = 'HONMPH',
            Sisa_Dana__c = 785555,
            Sumber_Dana_Lainnya__c = 'ALAMAT',
            sumberdana__c = 'Gaji',
            Tempat_Lahir__c = 'ALAMAT',
            Tempat_Lahir_Controlling_Person__c = 'ALAMAT',
            Tanggal_Anggaran_Dasar_Perusahaan__c = system.today(),
            Tanggal_Lahir__c = system.today(),
            Tanggal_Lahir_Controlling_Person__c = system.today(),
            Tanggal_Pengajuan__c = system.today(),
            Top_Up_Currency__c = 'Rp',
            Total_Dana_Awal__c = 485555,
            total_nominal_1__c = 485555,
            total_nominal_2__c = 485555,
            total_nominal_3__c = 485555,
            total_nominal_4__c = 485555,
            tujuan__c = 'Tabungan',
            Tujuan_Lainnya__c = 'ALAMAT',
            SKDR_SKDKK__c = 'SKDKK',
            Subdana_Tambahan_1__c = NULL,
            Subdana_Tambahan_2__c = NULL,
            Subdana_Tambahan_3__c = NULL,
            Subdana_Tambahan_4__c = NULL
            );
        return eform;
    }
    private static Master_Fund_Code__c createmasterFund(){
        Master_Fund_Code__c fund = new Master_Fund_Code__c(
            Name = 'ZRAC', 
            Desc_Fun_Code__c = 'MANDIRI ACTIVE BALANCED MONEY RUPIAH', 
            Plan_Code__c = 'HONMPH'
        );
        return fund;
    }
    private static void generatePDF(String param, String name, String subdana){
        
        id recordID = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Contact').getRecordTypeId();
        List<Contact> contList = new List<Contact>();
        Contact cont = new Contact();
        cont.Policy_No__c = '100-000-1110001';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP DMTM';
        cont.Entity__c = 'AMFS';
        cont.PolicyApp__c = 'RLS';
        cont.RecordTypeId = recordID;
        contList.add(cont);
        Insert contList;
        

        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, param, 'POS', cont.id);
        insert lbad;
        E_Form_Master_Data__c eform = new E_Form_Master_Data__c();
        if(subdana == ''){
            eform = createEFORMNonSubdana(lbad.id, param, name , subdana);
        }else if(subdana == 'nilaiTunaiNull'){
            eform = createEFORMNonSubdana(lbad.id, param, name , subdana);
            eform.Nilai_Tunai_Sementara__c = null;
            eform.Pendapatan__c = null;
            eform.Jenis_Identitas_Controlling_Person__c = 'Pasport';
            eform.Nomor_Identitas_Controlling_Person__c = '123123';
            eform.Jenis_Identitas__c = 'KTP';
        }else if(subdana == 'PP'){
            eform = createEFORMNonSubdana(lbad.id, param, name , subdana);
            eform.Nilai_Tunai_Sementara__c = null;
            eform.Pendapatan__c = null;
            eform.Jenis_Identitas_Controlling_Person__c = 'Pasport';
            eform.Nomor_Identitas_Controlling_Person__c = '123123';
            eform.Jenis_Identitas__c = 'KTP';
            eform.Pengkinian_Data__c = 'Pemegang Polis';
            eform.Nomor_Telpon__c = '088899991111';
            eform.Telepon_Kantor_Terbaru__c = '088899991111';
            eform.Telepon_Rumah_Terbaru__c = '-';
            eform.Telepon_Seluler_Terbaru__c = '-';
            eform.Telepon_Kantor_Terbaru_TP__c = '-';
            eform.Telepon_Rumah_Terbaru_TP__c = '-';
            eform.Telepon_Seluler_Terbaru_TP__c = '-';
        }else if(subdana == 'TP'){
            eform = createEFORMNonSubdana(lbad.id, param, name , subdana);
            eform.Nilai_Tunai_Sementara__c = null;
            eform.Pendapatan__c = null;
            eform.Jenis_Identitas_Controlling_Person__c = 'Pasport';
            eform.Nomor_Identitas_Controlling_Person__c = '123123';
            eform.Jenis_Identitas__c = 'KTP';
            eform.Pengkinian_Data__c = 'Tertanggung/Peserta';
            eform.Nomor_Telpon__c = null;
            eform.Telepon_Kantor_Terbaru__c = '-';
            eform.Telepon_Rumah_Terbaru__c = '-';
            eform.Telepon_Seluler_Terbaru__c = '-';
            eform.Telepon_Kantor_Terbaru_TP__c = '088899991111';
            eform.Telepon_Rumah_Terbaru_TP__c = '-';
            eform.Telepon_Seluler_Terbaru_TP__c = '-';
        }else if(subdana == 'PPTP'){
            eform = createEFORMNonSubdana(lbad.id, param, name , subdana);
            eform.Nilai_Tunai_Sementara__c = null;
            eform.Pendapatan__c = null;
            eform.Jenis_Identitas_Controlling_Person__c = 'Pasport';
            eform.Nomor_Identitas_Controlling_Person__c = '123123';
            eform.Jenis_Identitas__c = 'KTP';
            eform.Nomor_Telpon__c = null;
            eform.Telepon_Kantor_Terbaru__c = '-';
            eform.Telepon_Rumah_Terbaru__c = '03100033333';
            eform.Telepon_Seluler_Terbaru__c = '-';
            eform.Telepon_Kantor_Terbaru_TP__c = '088899991111';
            eform.Telepon_Rumah_Terbaru_TP__c = '-';
            eform.Telepon_Seluler_Terbaru_TP__c = '-';
        }else{
            eform = createEFORM(lbad.id, param, name , subdana);
        }
       
        insert eform;
        Master_Fund_Code__c fund = createmasterFund();
        insert fund;

        // Get the describe for the object
        Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get('E_Form_Master_Data__c').getDescribe().fields.getMap();

        // Build the field list dynamically
        String fields = String.join(new List<String>(fieldMap.keySet()), ',');

        // Construct and execute the dynamic SOQL query
        string eformid = eform.id;
        String query = 'SELECT ' + fields + ' FROM E_Form_Master_Data__c WHERE Id = \'' + eformid + '\'';
        List<SObject> results = Database.query(query);

        // Optionally, cast the result to the actual type
        List<E_Form_Master_Data__c> eformData = new List<E_Form_Master_Data__c>();
        eformData.add((E_Form_Master_Data__c)results[0]);

        AMFS_GeneratePDF.AMFS_GeneratePDF(eformData);
        
    }

    private static List<E_Form_Master_Data__c> getEform(string eformid){
         // Get the describe for the object
        Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get('E_Form_Master_Data__c').getDescribe().fields.getMap();

        // Build the field list dynamically
        String fields = String.join(new List<String>(fieldMap.keySet()), ',');

        String query = 'SELECT ' + fields + ' FROM E_Form_Master_Data__c WHERE Id = \'' + eformid + '\'';
        List<SObject> results = Database.query(query);

        // Optionally, cast the result to the actual type
        List<E_Form_Master_Data__c> eformData = new List<E_Form_Master_Data__c>();
        eformData.add((E_Form_Master_Data__c)results[0]);

        return eformData;
    }

    
    public static testMethod void runTestVisualforce() {
        test.startTest();
        
        id recordID = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Contact').getRecordTypeId();
        List<Contact> contList = new List<Contact>();
        Contact cont = new Contact();
        cont.Policy_No__c = '100-000-1110001';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP DMTM';
        cont.Entity__c = 'AMFS';
        cont.PolicyApp__c = 'RLS';
        cont.RecordTypeId = recordID;
        contList.add(cont);
        Insert contList;
        

        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_Pengalihan Dana (Switching)', 'POS', cont.id);
        insert lbad;
        E_Form_Master_Data__c eform = new E_Form_Master_Data__c();
        createEFORM(lbad.id, 'Request_POS_Pengalihan Dana (Switching)', 'Lumpsum' , 'nilaiTunaiNull');
        insert eform;
        Master_Fund_Code__c fund = createmasterFund();
        insert fund;


        ApexPages.StandardController stcs = new ApexPages.StandardController(eform);
        ApexPages.currentPage().getParameters().put('recordid',eform.Id);
        ApexPages.currentPage().getParameters().put('listTransactions', 'Transaction1,dokumenTambahanList');
        ApexPages.currentPage().getParameters().put('dokumenTambahanList', 'dokumenTambahanList;dokumenTambahanList2');
        ApexPages.currentPage().getParameters().put('codeOld1', 'Test');
        ApexPages.currentPage().getParameters().put('subdanaOld1', 'Test');
        ApexPages.currentPage().getParameters().put('percentageOld1', '10%');

  
        
        AMFS_SingleTopUp_Controller cal2 = new AMFS_SingleTopUp_Controller(stcs);
        AMFS_CRS_Controller cal = new AMFS_CRS_Controller(stcs);
        AMFS_PengajuanPenarikanDana_Controller cl3 = new AMFS_PengajuanPenarikanDana_Controller(stcs);

        
        test.stopTest();
    }
    public static testMethod void runTestVisualforceRedemption() {
        test.startTest();
        
        id recordID = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Contact').getRecordTypeId();
        List<Contact> contList = new List<Contact>();
        Contact cont = new Contact();
        cont.Policy_No__c = '100-000-1110001';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP DMTM';
        cont.Entity__c = 'AMFS';
        cont.PolicyApp__c = 'RLS';
        cont.RecordTypeId = recordID;
        contList.add(cont);
        Insert contList;
        

        Log_Book_Activitiy__c lba = createLBA();
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = createLBAD(lba.id, 'Request_POS_Pengalihan Dana (Switching)', 'POS', cont.id);
        insert lbad;
        E_Form_Master_Data__c eform = new E_Form_Master_Data__c();
        createEFORMPDP(lbad.id, 'Request_POS_Pengalihan Dana (Switching)', 'Lumpsum' , 'nilaiTunaiNull');
        insert eform;
        Master_Fund_Code__c fund = createmasterFund();
        insert fund;


        ApexPages.StandardController stcs = new ApexPages.StandardController(eform);
        ApexPages.currentPage().getParameters().put('recordid',eform.Id);
        ApexPages.currentPage().getParameters().put('type', 'REDEMPTION');
        ApexPages.currentPage().getParameters().put('listTransactions', 'Transaction1,dokumenTambahanList');
        ApexPages.currentPage().getParameters().put('dokumenTambahanList', 'dokumenTambahanList;dokumenTambahanList2');
        // AMFS_SingleTopUp_Controller cal2 = new AMFS_SingleTopUp_Controller(stcs);
        // AMFS_CRS_Controller cal = new AMFS_CRS_Controller(stcs);
        AMFS_PengajuanPenarikanDana_Controller cl3 = new AMFS_PengajuanPenarikanDana_Controller(stcs);
        
        test.stopTest();
    }
    
}