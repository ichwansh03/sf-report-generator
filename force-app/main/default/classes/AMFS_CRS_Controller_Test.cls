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
private class AMFS_CRS_Controller_Test {

    @testSetup
    static void setupTestData() {
        
        Log_Book_Activitiy__c lba = new Log_Book_Activitiy__c();
        lba.Time_In__c = Time.newInstance(1, 1, 0, 0);
        lba.Queue_No__c = 'A001';
        lba.Touch_Point__c = 'Head Office';
        insert lba;
        
        Contact con = new Contact();
        con.Entity__c = 'AMFS';
        con.PolicyApp__c = 'RLS';
        con.Policy_No__c = '520-4931835';
        con.LastName = 'John';
        insert con;

        Case c = new Case();
        c.Case_Type__c = 'Request_POS_Withdrawal';
        insert c;

        Log_Book_Activitiy_Detail__c lbad = new Log_Book_Activitiy_Detail__c();
        lbad.Log_Book_Activitiy__c = lba.Id;
        lbad.EForm__c = true;
        lbad.Customer_Mood__c = 'Happy';
        lbad.Customer_Name__c = 'JOHN DUMMY AMFS RLS';
        lbad.Customer_Relation__c = 'Diri Sendiri';
        lbad.Department__c = 'POS';
        lbad.Segmentation__c = 'Reguler';
        lbad.Policy_Number__c = '520-4931835';
        lbad.Contact_Policy__c = con.Id;
        lbad.Log_Case__c = c.Id;
        insert lbad;

        E_Form_Master_Data__c eform = new E_Form_Master_Data__c();
        eform.Name = 'Withdrawal - 520-4931835';
        eform.Transaction_Type__c = 'Request_POS_Withdrawal';
        eform.Nama_Pemilik_Polis__c = 'JOHN DUMMY AMFS RLS';
        eform.Nomor_Telpon__c = '039482';
        eform.alamat__c ='Jalan X';
        eform.Email__c = 'test@gmail.com';
        eform.informasi_pajak_luar_negeri__c = 'Tidak';
        eform.Nama_Produk__c = 'ASURANSI MANDIRI ELITE PLAN';
        eform.Payment_Method__c = 'Transfer';
        eform.Jumlah_Penarikan_Dana__c = 50000000;
        eform.Biaya_Transaksi__c = 0;
        eform.Sisa_Dana__c = 25000000;
        eform.Nilai_Tunai_Sementara__c = 100000000;
        eform.Jumlah_Setelah_Biaya_Transaksi__c = 45000000;
        eform.nama_rekening__c = 'NamaRekening';
        eform.Nama_Bank__c = 'NamaBank';
        eform.No_Rekening__c = '03928';
        eform.Mata_Uang__c = 'Rp';
        eform.Nama_Tertanggung__c = 'TestNamaTertanggung';
        eform.Sign_ID__c = '068BK0000000000YAC';
        eform.Nama_Lengkap__c = 'JOHN DUMMY AMFS RLS';
        eform.Nama_Pihak_Berwenang_Pemegang_Polis__c = 'JOHN';
        eform.Tempat_Lahir__c = 'Jakarta';
        eform.Tanggal_Lahir__c = Date.valueOf('2025-07-22');
        eform.Jenis_Identitas__c = 'KTP';
        eform.Nomor_Kartu_Identitas__c = '123123';
        eform.Alamat_Domisili__c = 'Jakarta';
        eform.Kota__c = 'Jakarta';
        eform.Kota_Controlling_Person__c = 'Jakarta';
        eform.Kewarganegaraan__c = 'INDONESIA';
        eform.Kedudukan_Polis__c = 'Pemegang Polis';
        eform.Negara_Terdaftar_Wajib_Pajak__c = 'Singapura';
        eform.Negara_Terdaftar_Wajib_Pajak1__c = 'Malaysia';
        eform.Negara_Terdaftar_Wajib_Pajak2__c = 'Australia';
        eform.NPWP__c = '123';
        eform.NPWP1__c = '123';
        eform.NPWP2__c = '123';
        eform.Alasan_Tidak_Ada_NPWP__c = 'Tidak';
        eform.Alasan_Tidak_Ada_NPWP1__c = 'Tidak';
        eform.Alasan_Tidak_Ada_NPWP2__c = 'Tidak';
        eform.Nama_Perusahaan__c = 'PT.AIA';
        eform.Nomor_Anggaran_Dasar_Perusahaan__c = '1242';
        eform.Nomor_TDP_SDP__c = '52314';
        eform.Negara_Domisili__c = 'INDONESIA';
        eform.Jabatan__c = 'AC';
        eform.Nama_Controlling_Person_Perusahaan__c = 'BAYU';
        eform.Jenis_Identitas_Controlling_Person__c = 'KTP';
        eform.Nomor_Identitas_Controlling_Person__c = '325213';
        eform.Tempat_Lahir_Controlling_Person__c = 'Jakarta';
        eform.Tanggal_Lahir_Controlling_Person__c = Date.valueOf('2025-07-22');
        eform.Alamat_Domisili_Controlling_Person__c = 'Jakarta';
        eform.Negara_Domisili_Controlling_Person__c = 'INDONESIA';
        eform.Jenis_Bdn_Usaha__c = 'Lembaga Non Keuangan Pasif.';
        eform.Apakah_Badan_Usaha_ini_melakukan_pelapor__c = 'Ya';
        eform.Kode_Pos__c = '12324';
        eform.Kode_Pos_Controlling_Persong__c = '12324';
        eform.Pasport__c = '123423';
        eform.Apakah_Controlling_Person_ini_melakukan__c = 'Ya';
        eform.Negara_Terdaftar_Wajib_Pajak_CP_1__c = 'Indo';
        eform.Negara_Terdaftar_Wajib_Pajak_CP_2__c = 'Indo';
        eform.Negara_Terdaftar_Wajib_Pajak_CP_3__c = 'Indo';
        eform.NPWP_CP_1__c = '123423';
        eform.NPWP_CP_2__c = '123423';
        eform.NPWP_CP_3__c = '123423';
        eform.Alasan_CP_1__c = 'Tidak Ada';
        eform.Alasan_CP_2__c = 'Tidak Ada';
        eform.Alasan_CP_3__c = 'Tidak Ada';




        insert eform;
    }


    @isTest
    static void testControllerWithSubjectParameter_VF_Form_CRS_Deklarasi_BU() {
        Datetime eFormDt = system.now().addHours(7);
        String inputdt = eFormDt.format('dd/MM/yyyy, HH:mm');
        String inputDate = eFormDt.format('dd/MM/yyyy');
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id,Policy_Number__c,Log_Case__r.CaseNumber FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c =: '520-4931835' LIMIT 1];
        E_Form_Master_Data__c eform = [SELECT Id,Pasport__c,Alasan_CP_3__c,Alasan_CP_2__c,Alasan_CP_1__c,NPWP_CP_3__c,NPWP_CP_2__c,NPWP_CP_1__c,Negara_Terdaftar_Wajib_Pajak_CP_3__c,Negara_Terdaftar_Wajib_Pajak_CP_2__c,Negara_Terdaftar_Wajib_Pajak_CP_1__c,Apakah_Controlling_Person_ini_melakukan__c,Kode_Pos_Controlling_Persong__c,Kode_Pos__c,Jenis_Bdn_Usaha__c,Apakah_Badan_Usaha_ini_melakukan_pelapor__c,Alamat_Domisili_Controlling_Person__c,Negara_Domisili_Controlling_Person__c,Tanggal_Lahir_Controlling_Person__c,Tempat_Lahir_Controlling_Person__c,Jabatan__c,Nomor_Identitas_Controlling_Person__c,Jenis_Identitas_Controlling_Person__c,Nama_Controlling_Person_Perusahaan__c,Nomor_TDP_SDP__c,Negara_Domisili__c,Nama_Perusahaan__c,Nomor_Anggaran_Dasar_Perusahaan__c,NPWP__c,Alasan_Tidak_Ada_NPWP1__c,Alasan_Tidak_Ada_NPWP2__c,Alasan_Tidak_Ada_NPWP__c,NPWP2__c,NPWP1__c,Kota__c,Negara_Terdaftar_Wajib_Pajak2__c,Negara_Terdaftar_Wajib_Pajak1__c,Negara_Terdaftar_Wajib_Pajak__c,Kedudukan_Polis__c,Kewarganegaraan__c,Kota_Controlling_Person__c,Email__c,Alamat_Domisili__c,Nomor_Kartu_Identitas__c,Jenis_Identitas__c,Tanggal_Lahir__c,Tempat_Lahir__c,Nama_Pihak_Berwenang_Pemegang_Polis__c,Nama_Lengkap__c,Sign_ID__c,Nama_Produk__c,No_Rekening__c,Nama_Tertanggung__c,Mata_Uang__c,nama_rekening__c,Nama_Bank__c,Sisa_Dana__c,Jumlah_Setelah_Biaya_Transaksi__c,Nilai_Tunai_Sementara__c,Biaya_Transaksi__c,Jumlah_Penarikan_Dana__c,informasi_pajak_luar_negeri__c, Nama_Pemilik_Polis__c,Nomor_Telpon__c,alamat__c FROM E_Form_Master_Data__c WHERE Nama_Pemilik_Polis__c=:'JOHN DUMMY AMFS RLS' LIMIT 1];
        // Setup: Create a test page and set parameter
        PageReference testPage = Page.VF_Form_CRS_Deklarasi_BU;
        Test.setCurrentPage(testPage);
        
        // Set parameter subject dengan nilai lowercase untuk test transformasi
        ApexPages.currentPage().getParameters().put('polisNo', lbad.Policy_Number__c);
        ApexPages.currentPage().getParameters().put('transNo', lbad.Log_Case__r.CaseNumber);
        ApexPages.currentPage().getParameters().put('namaLengkap', eform.Nama_Lengkap__c);
        ApexPages.currentPage().getParameters().put('namaLengkapBU', eform.Nama_Pihak_Berwenang_Pemegang_Polis__c);
        ApexPages.currentPage().getParameters().put('tempatLahir', eform.Tempat_Lahir__c);
        ApexPages.currentPage().getParameters().put('tanggalLahir', String.valueOf(eform.Tanggal_Lahir__c));
        ApexPages.currentPage().getParameters().put('tempatTanggal', eform.Tempat_Lahir__c+', '+eform.Tanggal_Lahir__c);
        ApexPages.currentPage().getParameters().put('jenisIdentitas', eform.Jenis_Identitas__c);
        ApexPages.currentPage().getParameters().put('noIdentitas', eform.Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('alamat', eform.Alamat_Domisili__c);
        ApexPages.currentPage().getParameters().put('kota', eform.Kota__c);
        ApexPages.currentPage().getParameters().put('kotaCP', eform.Kota_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('warganegara', eform.Kewarganegaraan__c);
        ApexPages.currentPage().getParameters().put('inputdt', inputdt);
        ApexPages.currentPage().getParameters().put('kedudukan', eform.Kedudukan_Polis__c);
        ApexPages.currentPage().getParameters().put('imgUrl', '/sfc/servlet.shepherd/version/download/');
        ApexPages.currentPage().getParameters().put('negara1', eform.Negara_Terdaftar_Wajib_Pajak__c);
        ApexPages.currentPage().getParameters().put('negara2', eform.Negara_Terdaftar_Wajib_Pajak1__c);
        ApexPages.currentPage().getParameters().put('negara3', eform.Negara_Terdaftar_Wajib_Pajak2__c);
        ApexPages.currentPage().getParameters().put('npwp1', eform.NPWP__c);
        ApexPages.currentPage().getParameters().put('npwp2', eform.NPWP1__c);
        ApexPages.currentPage().getParameters().put('npwp3', eform.NPWP2__c);
        ApexPages.currentPage().getParameters().put('alasan1', eform.Alasan_Tidak_Ada_NPWP__c);
        ApexPages.currentPage().getParameters().put('alasan2', eform.Alasan_Tidak_Ada_NPWP1__c);
        ApexPages.currentPage().getParameters().put('alasan3', eform.Alasan_Tidak_Ada_NPWP2__c);
        // Badan Usaha
        ApexPages.currentPage().getParameters().put('namaPerusahaanAnggaran', eform.Nama_Perusahaan__c);
        ApexPages.currentPage().getParameters().put('nomorAnggaranDasar', eform.Nomor_Anggaran_Dasar_Perusahaan__c);
        ApexPages.currentPage().getParameters().put('tanggalAnggaranDasar', inputDate);
        ApexPages.currentPage().getParameters().put('noTdpSdp', eform.Nomor_TDP_SDP__c);
        ApexPages.currentPage().getParameters().put('alamatDomisili', eform.Alamat_Domisili__c);
        ApexPages.currentPage().getParameters().put('negaraDomisili', eform.Negara_Domisili__c);
        ApexPages.currentPage().getParameters().put('namaPihakPemegangPolis', eform.Nama_Pihak_Berwenang_Pemegang_Polis__c);
        ApexPages.currentPage().getParameters().put('jabatan', eform.Jabatan__c);
        ApexPages.currentPage().getParameters().put('namaCPPerusahaan', eform.Nama_Controlling_Person_Perusahaan__c);
        ApexPages.currentPage().getParameters().put('jenisIdentitasCP', eform.Jenis_Identitas_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('nomorIdentitasCP', eform.Nomor_Identitas_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('tempLahirCP', eform.Tempat_Lahir_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('tanggalLahirCP', String.valueOf(eform.Tanggal_Lahir_Controlling_Person__c) );
        ApexPages.currentPage().getParameters().put('alamatDomisiliCP', eform.Alamat_Domisili_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('negaraDomisiliCP', eform.Negara_Domisili_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('jenisBadanUsaha', eform.Jenis_Bdn_Usaha__c);
        ApexPages.currentPage().getParameters().put('phName', eform.Nama_Pemilik_Polis__c);
        ApexPages.currentPage().getParameters().put('laporPajakBU', eform.Apakah_Badan_Usaha_ini_melakukan_pelapor__c);
        ApexPages.currentPage().getParameters().put('touchPoint', 'HeadOffice');
        ApexPages.currentPage().getParameters().put('sign', eform.Sign_ID__c);
        ApexPages.currentPage().getParameters().put('kodepos', eform.Kode_Pos__c);
        ApexPages.currentPage().getParameters().put('kodeposCP', eform.Kode_Pos_Controlling_Persong__c);
        ApexPages.currentPage().getParameters().put('eFormDt', String.valueOf(eFormDt));
        ApexPages.currentPage().getParameters().put('inputDate', inputDate);
        ApexPages.currentPage().getParameters().put('pasport', eform.Pasport__c);
        ApexPages.currentPage().getParameters().put('laporPajakCP', eform.Apakah_Controlling_Person_ini_melakukan__c);
        ApexPages.currentPage().getParameters().put('negara1CP', eform.Negara_Terdaftar_Wajib_Pajak_CP_1__c);
        ApexPages.currentPage().getParameters().put('negara2CP', eform.Negara_Terdaftar_Wajib_Pajak_CP_2__c);
        ApexPages.currentPage().getParameters().put('negara3CP', eform.Negara_Terdaftar_Wajib_Pajak_CP_3__c);
        ApexPages.currentPage().getParameters().put('npwp1CP', eform.NPWP_CP_1__c);
        ApexPages.currentPage().getParameters().put('alasan1CP', eform.Alasan_CP_1__c);
        ApexPages.currentPage().getParameters().put('npwp2CP', eform.NPWP_CP_2__c);
        ApexPages.currentPage().getParameters().put('alasan2CP', eform.Alasan_CP_2__c);
        ApexPages.currentPage().getParameters().put('npwp3CP', eform.NPWP_CP_3__c);
        ApexPages.currentPage().getParameters().put('alasan3CP', eform.Alasan_CP_3__c);
        ApexPages.currentPage().getParameters().put('pasportCP', '1237348');

        ApexPages.StandardController standardController = new ApexPages.StandardController(eform);
        
        Test.startTest();
        
        // Initialize controller
        AMFS_CRS_Controller controller = new AMFS_CRS_Controller(standardController);
        
        Test.stopTest();
    }
    @isTest
    static void testControllerWithSubjectParameter_VF_Form_CRS_Deklarasi_Individu() {
        Datetime eFormDt = system.now().addHours(7);
        String inputdt = eFormDt.format('dd/MM/yyyy, HH:mm');
        String inputDate = eFormDt.format('dd/MM/yyyy');
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id,Policy_Number__c,Log_Case__r.CaseNumber FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c =: '520-4931835' LIMIT 1];
        E_Form_Master_Data__c eform = [SELECT Id,Pasport__c,Alasan_CP_3__c,Alasan_CP_2__c,Alasan_CP_1__c,NPWP_CP_3__c,NPWP_CP_2__c,NPWP_CP_1__c,Negara_Terdaftar_Wajib_Pajak_CP_3__c,Negara_Terdaftar_Wajib_Pajak_CP_2__c,Negara_Terdaftar_Wajib_Pajak_CP_1__c,Apakah_Controlling_Person_ini_melakukan__c,Kode_Pos_Controlling_Persong__c,Kode_Pos__c,Jenis_Bdn_Usaha__c,Apakah_Badan_Usaha_ini_melakukan_pelapor__c,Alamat_Domisili_Controlling_Person__c,Negara_Domisili_Controlling_Person__c,Tanggal_Lahir_Controlling_Person__c,Tempat_Lahir_Controlling_Person__c,Jabatan__c,Nomor_Identitas_Controlling_Person__c,Jenis_Identitas_Controlling_Person__c,Nama_Controlling_Person_Perusahaan__c,Nomor_TDP_SDP__c,Negara_Domisili__c,Nama_Perusahaan__c,Nomor_Anggaran_Dasar_Perusahaan__c,NPWP__c,Alasan_Tidak_Ada_NPWP1__c,Alasan_Tidak_Ada_NPWP2__c,Alasan_Tidak_Ada_NPWP__c,NPWP2__c,NPWP1__c,Kota__c,Negara_Terdaftar_Wajib_Pajak2__c,Negara_Terdaftar_Wajib_Pajak1__c,Negara_Terdaftar_Wajib_Pajak__c,Kedudukan_Polis__c,Kewarganegaraan__c,Kota_Controlling_Person__c,Email__c,Alamat_Domisili__c,Nomor_Kartu_Identitas__c,Jenis_Identitas__c,Tanggal_Lahir__c,Tempat_Lahir__c,Nama_Pihak_Berwenang_Pemegang_Polis__c,Nama_Lengkap__c,Sign_ID__c,Nama_Produk__c,No_Rekening__c,Nama_Tertanggung__c,Mata_Uang__c,nama_rekening__c,Nama_Bank__c,Sisa_Dana__c,Jumlah_Setelah_Biaya_Transaksi__c,Nilai_Tunai_Sementara__c,Biaya_Transaksi__c,Jumlah_Penarikan_Dana__c,informasi_pajak_luar_negeri__c, Nama_Pemilik_Polis__c,Nomor_Telpon__c,alamat__c FROM E_Form_Master_Data__c WHERE Nama_Pemilik_Polis__c=:'JOHN DUMMY AMFS RLS' LIMIT 1];
        // Setup: Create a test page and set parameter
        PageReference testPage = Page.VF_Form_CRS_Deklarasi_Individu;
        Test.setCurrentPage(testPage);
        
        // Set parameter subject dengan nilai lowercase untuk test transformasi
        ApexPages.currentPage().getParameters().put('polisNo', lbad.Policy_Number__c);
        ApexPages.currentPage().getParameters().put('transNo', lbad.Log_Case__r.CaseNumber);
        ApexPages.currentPage().getParameters().put('namaLengkap', eform.Nama_Lengkap__c);
        ApexPages.currentPage().getParameters().put('namaLengkapBU', eform.Nama_Pihak_Berwenang_Pemegang_Polis__c);
        ApexPages.currentPage().getParameters().put('tempatLahir', eform.Tempat_Lahir__c);
        ApexPages.currentPage().getParameters().put('tanggalLahir', String.valueOf(eform.Tanggal_Lahir__c));
        ApexPages.currentPage().getParameters().put('tempatTanggal', eform.Tempat_Lahir__c+', '+eform.Tanggal_Lahir__c);
        ApexPages.currentPage().getParameters().put('jenisIdentitas', eform.Jenis_Identitas__c);
        ApexPages.currentPage().getParameters().put('noIdentitas', eform.Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('alamat', eform.Alamat_Domisili__c);
        ApexPages.currentPage().getParameters().put('kota', eform.Kota__c);
        ApexPages.currentPage().getParameters().put('kotaCP', eform.Kota_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('warganegara', eform.Kewarganegaraan__c);
        ApexPages.currentPage().getParameters().put('inputdt', inputdt);
        ApexPages.currentPage().getParameters().put('kedudukan', eform.Kedudukan_Polis__c);
        ApexPages.currentPage().getParameters().put('imgUrl', '/sfc/servlet.shepherd/version/download/');
        ApexPages.currentPage().getParameters().put('negara1', eform.Negara_Terdaftar_Wajib_Pajak__c);
        ApexPages.currentPage().getParameters().put('negara2', eform.Negara_Terdaftar_Wajib_Pajak1__c);
        ApexPages.currentPage().getParameters().put('negara3', eform.Negara_Terdaftar_Wajib_Pajak2__c);
        ApexPages.currentPage().getParameters().put('npwp1', eform.NPWP__c);
        ApexPages.currentPage().getParameters().put('npwp2', eform.NPWP1__c);
        ApexPages.currentPage().getParameters().put('npwp3', eform.NPWP2__c);
        ApexPages.currentPage().getParameters().put('alasan1', eform.Alasan_Tidak_Ada_NPWP__c);
        ApexPages.currentPage().getParameters().put('alasan2', eform.Alasan_Tidak_Ada_NPWP1__c);
        ApexPages.currentPage().getParameters().put('alasan3', eform.Alasan_Tidak_Ada_NPWP2__c);
        // Badan Usaha
        ApexPages.currentPage().getParameters().put('namaPerusahaanAnggaran', eform.Nama_Perusahaan__c);
        ApexPages.currentPage().getParameters().put('nomorAnggaranDasar', eform.Nomor_Anggaran_Dasar_Perusahaan__c);
        ApexPages.currentPage().getParameters().put('tanggalAnggaranDasar', inputDate);
        ApexPages.currentPage().getParameters().put('noTdpSdp', eform.Nomor_TDP_SDP__c);
        ApexPages.currentPage().getParameters().put('alamatDomisili', eform.Alamat_Domisili__c);
        ApexPages.currentPage().getParameters().put('negaraDomisili', eform.Negara_Domisili__c);
        ApexPages.currentPage().getParameters().put('namaPihakPemegangPolis', eform.Nama_Pihak_Berwenang_Pemegang_Polis__c);
        ApexPages.currentPage().getParameters().put('jabatan', eform.Jabatan__c);
        ApexPages.currentPage().getParameters().put('namaCPPerusahaan', eform.Nama_Controlling_Person_Perusahaan__c);
        ApexPages.currentPage().getParameters().put('jenisIdentitasCP', eform.Jenis_Identitas_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('nomorIdentitasCP', eform.Nomor_Identitas_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('tempLahirCP', eform.Tempat_Lahir_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('tanggalLahirCP', String.valueOf(eform.Tanggal_Lahir_Controlling_Person__c) );
        ApexPages.currentPage().getParameters().put('alamatDomisiliCP', eform.Alamat_Domisili_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('negaraDomisiliCP', eform.Negara_Domisili_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('jenisBadanUsaha', eform.Jenis_Bdn_Usaha__c);
        ApexPages.currentPage().getParameters().put('phName', eform.Nama_Pemilik_Polis__c);
        ApexPages.currentPage().getParameters().put('laporPajakBU', eform.Apakah_Badan_Usaha_ini_melakukan_pelapor__c);
        ApexPages.currentPage().getParameters().put('touchPoint', 'HeadOffice');
        ApexPages.currentPage().getParameters().put('sign', eform.Sign_ID__c);
        ApexPages.currentPage().getParameters().put('kodepos', eform.Kode_Pos__c);
        ApexPages.currentPage().getParameters().put('kodeposCP', eform.Kode_Pos_Controlling_Persong__c);
        ApexPages.currentPage().getParameters().put('eFormDt', String.valueOf(eFormDt));
        ApexPages.currentPage().getParameters().put('inputDate', inputDate);
        ApexPages.currentPage().getParameters().put('pasport', eform.Pasport__c);
        ApexPages.currentPage().getParameters().put('laporPajakCP', eform.Apakah_Controlling_Person_ini_melakukan__c);
        ApexPages.currentPage().getParameters().put('negara1CP', eform.Negara_Terdaftar_Wajib_Pajak_CP_1__c);
        ApexPages.currentPage().getParameters().put('negara2CP', eform.Negara_Terdaftar_Wajib_Pajak_CP_2__c);
        ApexPages.currentPage().getParameters().put('negara3CP', eform.Negara_Terdaftar_Wajib_Pajak_CP_3__c);
        ApexPages.currentPage().getParameters().put('npwp1CP', eform.NPWP_CP_1__c);
        ApexPages.currentPage().getParameters().put('alasan1CP', eform.Alasan_CP_1__c);
        ApexPages.currentPage().getParameters().put('npwp2CP', eform.NPWP_CP_2__c);
        ApexPages.currentPage().getParameters().put('alasan2CP', eform.Alasan_CP_2__c);
        ApexPages.currentPage().getParameters().put('npwp3CP', eform.NPWP_CP_3__c);
        ApexPages.currentPage().getParameters().put('alasan3CP', eform.Alasan_CP_3__c);
        ApexPages.currentPage().getParameters().put('pasportCP', '1237348');

        ApexPages.StandardController standardController = new ApexPages.StandardController(eform);
        
        Test.startTest();
        
        // Initialize controller
        AMFS_CRS_Controller controller = new AMFS_CRS_Controller(standardController);
        
        Test.stopTest();
    }
    @isTest
    static void testControllerWithSubjectParameter_VF_Form_CRS_Keberatan() {
        Datetime eFormDt = system.now().addHours(7);
        String inputdt = eFormDt.format('dd/MM/yyyy, HH:mm');
        String inputDate = eFormDt.format('dd/MM/yyyy');
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id,Policy_Number__c,Log_Case__r.CaseNumber FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c =: '520-4931835' LIMIT 1];
        E_Form_Master_Data__c eform = [SELECT Id,Pasport__c,Alasan_CP_3__c,Alasan_CP_2__c,Alasan_CP_1__c,NPWP_CP_3__c,NPWP_CP_2__c,NPWP_CP_1__c,Negara_Terdaftar_Wajib_Pajak_CP_3__c,Negara_Terdaftar_Wajib_Pajak_CP_2__c,Negara_Terdaftar_Wajib_Pajak_CP_1__c,Apakah_Controlling_Person_ini_melakukan__c,Kode_Pos_Controlling_Persong__c,Kode_Pos__c,Jenis_Bdn_Usaha__c,Apakah_Badan_Usaha_ini_melakukan_pelapor__c,Alamat_Domisili_Controlling_Person__c,Negara_Domisili_Controlling_Person__c,Tanggal_Lahir_Controlling_Person__c,Tempat_Lahir_Controlling_Person__c,Jabatan__c,Nomor_Identitas_Controlling_Person__c,Jenis_Identitas_Controlling_Person__c,Nama_Controlling_Person_Perusahaan__c,Nomor_TDP_SDP__c,Negara_Domisili__c,Nama_Perusahaan__c,Nomor_Anggaran_Dasar_Perusahaan__c,NPWP__c,Alasan_Tidak_Ada_NPWP1__c,Alasan_Tidak_Ada_NPWP2__c,Alasan_Tidak_Ada_NPWP__c,NPWP2__c,NPWP1__c,Kota__c,Negara_Terdaftar_Wajib_Pajak2__c,Negara_Terdaftar_Wajib_Pajak1__c,Negara_Terdaftar_Wajib_Pajak__c,Kedudukan_Polis__c,Kewarganegaraan__c,Kota_Controlling_Person__c,Email__c,Alamat_Domisili__c,Nomor_Kartu_Identitas__c,Jenis_Identitas__c,Tanggal_Lahir__c,Tempat_Lahir__c,Nama_Pihak_Berwenang_Pemegang_Polis__c,Nama_Lengkap__c,Sign_ID__c,Nama_Produk__c,No_Rekening__c,Nama_Tertanggung__c,Mata_Uang__c,nama_rekening__c,Nama_Bank__c,Sisa_Dana__c,Jumlah_Setelah_Biaya_Transaksi__c,Nilai_Tunai_Sementara__c,Biaya_Transaksi__c,Jumlah_Penarikan_Dana__c,informasi_pajak_luar_negeri__c, Nama_Pemilik_Polis__c,Nomor_Telpon__c,alamat__c FROM E_Form_Master_Data__c WHERE Nama_Pemilik_Polis__c=:'JOHN DUMMY AMFS RLS' LIMIT 1];
        // Setup: Create a test page and set parameter
        PageReference testPage = Page.VF_Form_CRS_Keberatan;
        Test.setCurrentPage(testPage);
        
        // Set parameter subject dengan nilai lowercase untuk test transformasi
        ApexPages.currentPage().getParameters().put('polisNo', lbad.Policy_Number__c);
        ApexPages.currentPage().getParameters().put('transNo', lbad.Log_Case__r.CaseNumber);
        ApexPages.currentPage().getParameters().put('namaLengkap', eform.Nama_Lengkap__c);
        ApexPages.currentPage().getParameters().put('namaLengkapBU', eform.Nama_Pihak_Berwenang_Pemegang_Polis__c);
        ApexPages.currentPage().getParameters().put('tempatLahir', eform.Tempat_Lahir__c);
        ApexPages.currentPage().getParameters().put('tanggalLahir', String.valueOf(eform.Tanggal_Lahir__c));
        ApexPages.currentPage().getParameters().put('tempatTanggal', eform.Tempat_Lahir__c+', '+eform.Tanggal_Lahir__c);
        ApexPages.currentPage().getParameters().put('jenisIdentitas', eform.Jenis_Identitas__c);
        ApexPages.currentPage().getParameters().put('noIdentitas', eform.Nomor_Kartu_Identitas__c);
        ApexPages.currentPage().getParameters().put('alamat', eform.Alamat_Domisili__c);
        ApexPages.currentPage().getParameters().put('kota', eform.Kota__c);
        ApexPages.currentPage().getParameters().put('kotaCP', eform.Kota_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('warganegara', eform.Kewarganegaraan__c);
        ApexPages.currentPage().getParameters().put('inputdt', inputdt);
        ApexPages.currentPage().getParameters().put('kedudukan', eform.Kedudukan_Polis__c);
        ApexPages.currentPage().getParameters().put('imgUrl', '/sfc/servlet.shepherd/version/download/');
        ApexPages.currentPage().getParameters().put('negara1', eform.Negara_Terdaftar_Wajib_Pajak__c);
        ApexPages.currentPage().getParameters().put('negara2', eform.Negara_Terdaftar_Wajib_Pajak1__c);
        ApexPages.currentPage().getParameters().put('negara3', eform.Negara_Terdaftar_Wajib_Pajak2__c);
        ApexPages.currentPage().getParameters().put('npwp1', eform.NPWP__c);
        ApexPages.currentPage().getParameters().put('npwp2', eform.NPWP1__c);
        ApexPages.currentPage().getParameters().put('npwp3', eform.NPWP2__c);
        ApexPages.currentPage().getParameters().put('alasan1', eform.Alasan_Tidak_Ada_NPWP__c);
        ApexPages.currentPage().getParameters().put('alasan2', eform.Alasan_Tidak_Ada_NPWP1__c);
        ApexPages.currentPage().getParameters().put('alasan3', eform.Alasan_Tidak_Ada_NPWP2__c);
        // Badan Usaha
        ApexPages.currentPage().getParameters().put('namaPerusahaanAnggaran', eform.Nama_Perusahaan__c);
        ApexPages.currentPage().getParameters().put('nomorAnggaranDasar', eform.Nomor_Anggaran_Dasar_Perusahaan__c);
        ApexPages.currentPage().getParameters().put('tanggalAnggaranDasar', inputDate);
        ApexPages.currentPage().getParameters().put('noTdpSdp', eform.Nomor_TDP_SDP__c);
        ApexPages.currentPage().getParameters().put('alamatDomisili', eform.Alamat_Domisili__c);
        ApexPages.currentPage().getParameters().put('negaraDomisili', eform.Negara_Domisili__c);
        ApexPages.currentPage().getParameters().put('namaPihakPemegangPolis', eform.Nama_Pihak_Berwenang_Pemegang_Polis__c);
        ApexPages.currentPage().getParameters().put('jabatan', eform.Jabatan__c);
        ApexPages.currentPage().getParameters().put('namaCPPerusahaan', eform.Nama_Controlling_Person_Perusahaan__c);
        ApexPages.currentPage().getParameters().put('jenisIdentitasCP', eform.Jenis_Identitas_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('nomorIdentitasCP', eform.Nomor_Identitas_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('tempLahirCP', eform.Tempat_Lahir_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('tanggalLahirCP', String.valueOf(eform.Tanggal_Lahir_Controlling_Person__c) );
        ApexPages.currentPage().getParameters().put('alamatDomisiliCP', eform.Alamat_Domisili_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('negaraDomisiliCP', eform.Negara_Domisili_Controlling_Person__c);
        ApexPages.currentPage().getParameters().put('jenisBadanUsaha', eform.Jenis_Bdn_Usaha__c);
        ApexPages.currentPage().getParameters().put('phName', eform.Nama_Pemilik_Polis__c);
        ApexPages.currentPage().getParameters().put('laporPajakBU', eform.Apakah_Badan_Usaha_ini_melakukan_pelapor__c);
        ApexPages.currentPage().getParameters().put('touchPoint', 'HeadOffice');
        ApexPages.currentPage().getParameters().put('sign', eform.Sign_ID__c);
        ApexPages.currentPage().getParameters().put('kodepos', eform.Kode_Pos__c);
        ApexPages.currentPage().getParameters().put('kodeposCP', eform.Kode_Pos_Controlling_Persong__c);
        ApexPages.currentPage().getParameters().put('eFormDt', String.valueOf(eFormDt));
        ApexPages.currentPage().getParameters().put('inputDate', inputDate);
        ApexPages.currentPage().getParameters().put('pasport', eform.Pasport__c);
        ApexPages.currentPage().getParameters().put('laporPajakCP', eform.Apakah_Controlling_Person_ini_melakukan__c);
        ApexPages.currentPage().getParameters().put('negara1CP', eform.Negara_Terdaftar_Wajib_Pajak_CP_1__c);
        ApexPages.currentPage().getParameters().put('negara2CP', eform.Negara_Terdaftar_Wajib_Pajak_CP_2__c);
        ApexPages.currentPage().getParameters().put('negara3CP', eform.Negara_Terdaftar_Wajib_Pajak_CP_3__c);
        ApexPages.currentPage().getParameters().put('npwp1CP', eform.NPWP_CP_1__c);
        ApexPages.currentPage().getParameters().put('alasan1CP', eform.Alasan_CP_1__c);
        ApexPages.currentPage().getParameters().put('npwp2CP', eform.NPWP_CP_2__c);
        ApexPages.currentPage().getParameters().put('alasan2CP', eform.Alasan_CP_2__c);
        ApexPages.currentPage().getParameters().put('npwp3CP', eform.NPWP_CP_3__c);
        ApexPages.currentPage().getParameters().put('alasan3CP', eform.Alasan_CP_3__c);
        ApexPages.currentPage().getParameters().put('pasportCP', '1237348');

        ApexPages.StandardController standardController = new ApexPages.StandardController(eform);
        
        Test.startTest();
        
        // Initialize controller
        AMFS_CRS_Controller controller = new AMFS_CRS_Controller(standardController);
        
        Test.stopTest();
    }
}