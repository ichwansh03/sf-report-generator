@isTest
public class AMFS_PemulihanPolis_ControllerTest {



    @TestSetup
    static void makeData(){
         Log_Book_Activitiy__c lba = new Log_Book_Activitiy__c();
        lba.Time_In__c = Time.newInstance(1, 1, 0, 0);
        lba.Queue_No__c = 'A001';
        lba.Touch_Point__c = 'CCC Bandung';
        insert lba;
        
        Contact con = new Contact();
        con.Entity__c = 'AMFS';
        con.PolicyApp__c = 'RLS';
        con.Policy_No__c = '520-4931835';
        con.LastName = 'John';
        insert con;

        Case c = new Case();
        c.Case_Type__c = 'Request_POS Pemulihan Polis';
        insert c;

        Log_Book_Activitiy_Detail__c lbad = new Log_Book_Activitiy_Detail__c();
        lbad.Log_Book_Activitiy__c = lba.Id;
        lbad.EForm__c = true;
        lbad.Customer_Mood__c = 'Normal';
        lbad.Customer_Name__c = 'JOHN DUMMY AMFS';
        lbad.Customer_Relation__c = 'Pasangan';
        lbad.Department__c = 'POS';
        lbad.Segmentation__c = 'Reguler';
        lbad.Policy_Number__c = '520-4931835';
        lbad.Contact_Policy__c = con.Id;
        lbad.Log_Case__c = c.Id;
        insert lbad;

        E_Form_Master_Data__c eform = new E_Form_Master_Data__c();
        eform.Name = 'Pemulihan Polis - 520-4931835';
        eform.Transaction_Type__c = 'Request_POS Pemulihan Polis';
        eform.Pengkinian_Data__c = 'Pemegang Polis';
        eform.Nama_Pemilik_Polis__c = 'JOHN DUMMY AMFS RLS';
        eform.Nomor_Telpon__c = '039482';
        eform.alamat__c ='Jalan X';
        eform.Email__c = 'test@gmail.com';
        eform.informasi_pajak_luar_negeri__c = 'Tidak';
        eform.Nama_Produk__c = 'ASURANSI MANDIRI ELITE PLAN';
        eform.Nomor_Kartu_Identitas__c = '123123123123123';
        eform.Segmentation__c = 'PBC';
        eform.Nama_Perusahaan__c = 'tenis sehat';
        eform.Jabatan__c = 'coach';
        eform.Pekerjaan__c = 'petenis';
        eform.Bidang_Usaha__c = 'olahraga';
        eform.Rincian_Tugas__c = 'ngelatih aja';
        eform.Alat_bantu_yang_digunakan__c = 'raket';
        eform.Tinggi_Badan__c = '170';
        eform.Tinggi_Badan_tahun_lalu__c = '170';
        eform.Berat_Badan__c = '67';
        eform.Berat_Badan_tahun_lalu__c = '67';
       // eform.Alasan_perubahan_tinggi_berat_badan__c = 'perubahan tinggi dan berat badan Pemegang Polis';

        //DATA PRIBADI dan KEBIASAAN
        eform.Pertanyaan_dt_pribadi_kebiasaan1__c = 'Tidak';
        eform.Pertanyaan_dt_pribadi_kebiasaan2__c = 'Tidak';
		eform.Pertanyaan_dt_pribadi_kebiasaan3__c = 'Ya';
		eform.Pertanyaan_dt_pribadi_kebiasaan4__c = 'Tidak';
		eform.Pertanyaan_dt_pribadi_kebiasaan5__c = 'Ya';
        eform.Pertanyaan_dt_pribadi_kebiasaan6__c = 'Tidak';
        //rokok
        eform.Berapa_Batang_PP__c = '9';
        eform.Sejak_PP__c = '2009';
        eform.Rokok_Elektrik_PP__c = '2';
        eform.sejak_elektrik_PP__c = '2019';
        eform.Tanpa_asap_pp__c = '19';
        //data pribadi dan kebiasaan penjelasan
        // eform.Penjelasan_dt_pribadi_kebiasaan__c = '';
		// eform.Penjelasan_dt_pribadi_kebiasaan1__c = '';
		// eform.Penjelasan_dt_pribadi_kebiasaan2__c = 'merokok atau menggunakan tembakau jenis apapun atau tembakau tanpa asap';
		// eform.Penjelasan_dt_pribadi_kebiasaan3__c = '';
		// eform.Penjelasan_dt_pribadi_kebiasaan4__c = 'mengkonsumsi minuman alkohol';
		// eform.Penjelasan_dt_pribadi_kebiasaan5__c = '';

        //DATA KESEHATAN
        eform.Pertanyaan_dt_kesehatan1__c = 'Tidak';
		eform.Pertanyaan_dt_kesehatan2__c = 'Tidak';
		eform.Pertanyaan_dt_kesehatan3__c = 'Ya';
		eform.Pertanyaan_dt_kesehatan4__c = 'Tidak';
		eform.Pertanyaan_dt_kesehatan5__c = 'Tidak';
		
        // DATA KESEHATAN SECTION PENJELASAN 
		// eform.Penjelasan_dt_kesehatan__c = '';
		// eform.Penjelasan_dt_kesehatan1__c = '';
		// eform.Penjelasan_dt_kesehatan2__c = 'Anda Sedang menunggu hasil/test investigasi mengenai kesehatan Anda';
		// eform.Penjelasan_dt_kesehatan3__c = '';
		// eform.Penjelasan_dt_kesehatan4__c = '';

        //data kesahatan tambahan
        eform.Pertanyaan_dt_kesehatan_tambahan1__c = 'Tidak';
		eform.Pertanyaan_dt_kesehatan_tambahan2__c = 'Tidak';
		eform.Pertanyaan_dt_kesehatan_tambahan3__c = 'Tidak';
		eform.Pertanyaan_dt_kesehatan_tambahan4__c = 'Tidak';
		eform.Pertanyaan_dt_kesehatan_tambahan5__c = 'Tidak';
		eform.Pertanyaan_dt_kesehatan_tambahan6__c = 'Tidak';
		eform.Pertanyaan_dt_kesehatan_tambahan7__c = 'Tidak';
		eform.Pertanyaan_dt_kesehatan_tambahan8__c = 'Tidak';
		eform.Pertanyaan_dt_kesehatan_tambahan9__c = 'Tidak';
		eform.Pertanyaan_dt_kesehatan_tambahan10__c = 'Tidak';
		eform.Pertanyaan_dt_kesehatan_tambahan11__c = 'Tidak';
		eform.Pertanyaan_dt_kesehatan_tambahan12__c = 'Tidak';
		eform.Pertanyaan_dt_kesehatan_tambahan13__c = 'Tidak';
		eform.Pertanyaan_dt_kesehatan_tambahan14__c = 'Tidak';
		eform.Pertanyaan_dt_kesehatan_tambahan15__c = 'Tidak';

        // eform.Penjelasan_dt_kesehatan_tambahan__c  = '';
		// eform.Penjelasan_dt_kesehatan_tambahan1__c = '';
		// eform.Penjelasan_dt_kesehatan_tambahan2__c = '';
		// eform.Penjelasan_dt_kesehatan_tambahan3__c = '';
		// eform.Penjelasan_dt_kesehatan_tambahan4__c = '';
		// eform.Penjelasan_dt_kesehatan_tambahan5__c = '';
		// eform.Penjelasan_dt_kesehatan_tambahan6__c = '';
		// eform.Penjelasan_dt_kesehatan_tambahan7__c = '';
		// eform.Penjelasan_dt_kesehatan_tambahan8__c = '';
		// eform.Penjelasan_dt_kesehatan_tambahan9__c = '';
		// eform.Penjelasan_dt_kesehatan_tambahan10__c = '';
		// eform.Penjelasan_dt_kesehatan_tambahan11__c = '';
		// eform.Penjelasan_dt_kesehatan_tambahan12__c = '';
		// eform.Penjelasan_dt_kesehatan_tambahan13__c = '';
		// eform.Penjelasan_dt_kesehatan_tambahan14__c = '';

        //data kesehatan khusus wanita
        eform.Pertanyaan_dt_khusus_wanita__c = 'Tidak';
		//eform.Penjelasan_dt_khusus_wanita__c = '';
		//data riwayat keluarga
        eform.Pertanyaan_dt_riwayat_keluarga__c = 'Tidak';
		//eform.Penjelasan_dt_rwyt_keluarga__c = '';

         eform.Sign_ID__c = '068BK0000049nAbYAI';

        insert eform;
    }
    


    @isTest
    static void testControllerWithSubjectParameterFTP() {

        Datetime eFormDt = system.now().addHours(7);
        String inputdt = eFormDt.format('dd/MM/yyyy, HH:mm');
        String inputDate = eFormDt.format('dd/MM/yyyy');
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id,Policy_Number__c,Log_Case__r.CaseNumber FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c =: '520-4931835' LIMIT 1];
        E_Form_Master_Data__c eform = [SELECT 
        Id,
        Email__c,
        Sign_ID__c,
        Nama_Produk__c,
        No_Rekening__c,
        informasi_pajak_luar_negeri__c,
        Nama_Pemilik_Polis__c,Nomor_Telpon__c,
         alamat__c , Nama_Perusahaan__c,Bidang_Usaha__c,Rincian_Tugas__c,Alat_bantu_yang_digunakan__c,Jabatan__c,pekerjaan__c, Pengkinian_Data__c,Tinggi_Badan__c,Berat_Badan__c,Tinggi_Badan_tahun_lalu__c,Berat_Badan_tahun_lalu__c,
         //Alasan_perubahan_tinggi_berat_badan__c,
         Pertanyaan_dt_pribadi_kebiasaan1__c,Pertanyaan_dt_pribadi_kebiasaan2__c,Pertanyaan_dt_pribadi_kebiasaan3__c,Pertanyaan_dt_pribadi_kebiasaan4__c,Pertanyaan_dt_pribadi_kebiasaan5__c,Pertanyaan_dt_pribadi_kebiasaan6__c,
        //  Penjelasan_dt_pribadi_kebiasaan__c,
        //  Penjelasan_dt_pribadi_kebiasaan1__c,
        //  Penjelasan_dt_pribadi_kebiasaan2__c,
        //  Penjelasan_dt_pribadi_kebiasaan3__c,
        //  Penjelasan_dt_pribadi_kebiasaan4__c,
        //  Penjelasan_dt_pribadi_kebiasaan5__c,
         Berapa_Batang_PP__c,Sejak_PP__c,Rokok_Elektrik_PP__c,sejak_elektrik_PP__c,Tanpa_asap_pp__c,Pertanyaan_dt_kesehatan1__c,Pertanyaan_dt_kesehatan2__c,Pertanyaan_dt_kesehatan3__c,Pertanyaan_dt_kesehatan4__c,Pertanyaan_dt_kesehatan5__c,
        //  Penjelasan_dt_kesehatan__c,
        //  Penjelasan_dt_kesehatan1__c,
        //  Penjelasan_dt_kesehatan2__c,
        //  Penjelasan_dt_kesehatan3__c,
        //  Penjelasan_dt_kesehatan4__c,
         Pertanyaan_dt_khusus_wanita__c,
        // Penjelasan_dt_khusus_wanita__c,
         Pertanyaan_dt_kesehatan_tambahan1__c,Pertanyaan_dt_kesehatan_tambahan2__c,Pertanyaan_dt_kesehatan_tambahan3__c,Pertanyaan_dt_kesehatan_tambahan4__c,Pertanyaan_dt_kesehatan_tambahan5__c,Pertanyaan_dt_kesehatan_tambahan6__c,Pertanyaan_dt_kesehatan_tambahan7__c,Pertanyaan_dt_kesehatan_tambahan8__c,Pertanyaan_dt_kesehatan_tambahan9__c,Pertanyaan_dt_kesehatan_tambahan10__c,Pertanyaan_dt_kesehatan_tambahan11__c,Pertanyaan_dt_kesehatan_tambahan12__c,Pertanyaan_dt_kesehatan_tambahan13__c,Pertanyaan_dt_kesehatan_tambahan14__c,Pertanyaan_dt_kesehatan_tambahan15__c,
        //  Penjelasan_dt_kesehatan_tambahan__c,
        //  Penjelasan_dt_kesehatan_tambahan1__c,
        //  Penjelasan_dt_kesehatan_tambahan2__c,
        //  Penjelasan_dt_kesehatan_tambahan3__c,
        //  Penjelasan_dt_kesehatan_tambahan4__c,
        //  Penjelasan_dt_kesehatan_tambahan5__c,
        //  Penjelasan_dt_kesehatan_tambahan6__c,
        //  Penjelasan_dt_kesehatan_tambahan7__c,
        //  Penjelasan_dt_kesehatan_tambahan8__c,
        //  Penjelasan_dt_kesehatan_tambahan9__c,
        //  Penjelasan_dt_kesehatan_tambahan10__c,
        //  Penjelasan_dt_kesehatan_tambahan11__c,
        //  Penjelasan_dt_kesehatan_tambahan12__c,
        //  Penjelasan_dt_kesehatan_tambahan13__c,
        //  Penjelasan_dt_kesehatan_tambahan14__c,
         Pertanyaan_dt_riwayat_keluarga__c
         //Penjelasan_dt_rwyt_keluarga__c
         FROM E_Form_Master_Data__c WHERE Nama_Pemilik_Polis__c=:'JOHN DUMMY AMFS RLS' LIMIT 1];
        // Setup: Create a test page and set parameter
        PageReference testPage = Page.VF_PemulihanPolis;
        Test.setCurrentPage(testPage);


        ApexPages.currentPage().getParameters().put('subject', 'Withdrawal');
        ApexPages.currentPage().getParameters().put('polisNo', lbad.Policy_Number__c);
        ApexPages.currentPage().getParameters().put('phName', eform.Nama_Pemilik_Polis__c);
        ApexPages.currentPage().getParameters().put('phone', eform.Nomor_Telpon__c);
        ApexPages.currentPage().getParameters().put('addr', eform.alamat__c);
        ApexPages.currentPage().getParameters().put('email', eform.Email__c);
        ApexPages.currentPage().getParameters().put('pajak', eform.informasi_pajak_luar_negeri__c);
        ApexPages.currentPage().getParameters().put('jabatanPP', eform.Jabatan__c);
        ApexPages.currentPage().getParameters().put('pekerjaanPP', eform.Pekerjaan__c);
        ApexPages.currentPage().getParameters().put('namaPerusahaanPP', eform.Nama_Perusahaan__c);
        ApexPages.currentPage().getParameters().put('bidangUsahaPP', eform.Bidang_Usaha__c);
        ApexPages.currentPage().getParameters().put('rincianTugasPP', eform.Rincian_Tugas__c);
        ApexPages.currentPage().getParameters().put('alatBantuPP', eform.Alat_bantu_yang_digunakan__c);
        ApexPages.currentPage().getParameters().put('tinggiBadanSaatIniPP', eform.Tinggi_Badan__c);
        ApexPages.currentPage().getParameters().put('beratBadanSaatIniPP', eform.Berat_Badan__c);
        ApexPages.currentPage().getParameters().put('tinggiBadanTahunLaluPP', eform.Tinggi_Badan_tahun_lalu__c);
        ApexPages.currentPage().getParameters().put('beratBadanTahunLaluPP', eform.Berat_Badan_tahun_lalu__c);
      //  ApexPages.currentPage().getParameters().put('alasanPerubahanPP', eform.Alasan_perubahan_tinggi_berat_badan__c);
        ApexPages.currentPage().getParameters().put('jenisPengkinianData', 'TP');
        ApexPages.currentPage().getParameters().put('jenisKelTP', 'F');
        ApexPages.currentPage().getParameters().put('inputdtmmss','2024-06-01T10:00:00.000Z');
        // ApexPages.currentPage().getParameters().put('dokumenTambahanList', null);
        // ApexPages.currentPage().getParameters().put('listTransactions', null);
        
        
        //DATA PRIBADI dan KEBIASAAN
        ApexPages.currentPage().getParameters().put('DTPKPPRBPP1', eform.Pertanyaan_dt_pribadi_kebiasaan1__c);
        ApexPages.currentPage().getParameters().put('DTPKPPRBPP2', eform.Pertanyaan_dt_pribadi_kebiasaan2__c);
        ApexPages.currentPage().getParameters().put('DTPKPPRBPP3', eform.Pertanyaan_dt_pribadi_kebiasaan3__c);
        ApexPages.currentPage().getParameters().put('DTPKPPRBPP4', eform.Pertanyaan_dt_pribadi_kebiasaan4__c);
        ApexPages.currentPage().getParameters().put('DTPKPPRBPP5', eform.Pertanyaan_dt_pribadi_kebiasaan5__c);
        ApexPages.currentPage().getParameters().put('DTPKPPRBPP6', eform.Pertanyaan_dt_pribadi_kebiasaan6__c);
        ApexPages.currentPage().getParameters().put('DTPKRBTP3', 'YA');
        
        //DATA PRIBADI dan KEBIASAAN Penjelasan
        // ApexPages.currentPage().getParameters().put('DTPKPPTAPP1', eform.Penjelasan_dt_pribadi_kebiasaan__c);
        // ApexPages.currentPage().getParameters().put('DTPKPPTAPP2', eform.Penjelasan_dt_pribadi_kebiasaan1__c);
        // ApexPages.currentPage().getParameters().put('DTPKPPTAPP3', eform.Penjelasan_dt_pribadi_kebiasaan2__c);
        // ApexPages.currentPage().getParameters().put('DTPKPPTAPP4', eform.Penjelasan_dt_pribadi_kebiasaan3__c);
        // ApexPages.currentPage().getParameters().put('DTPKPPTAPP5', eform.Penjelasan_dt_pribadi_kebiasaan4__c);
        // ApexPages.currentPage().getParameters().put('DTPKPPTAPP6', eform.Penjelasan_dt_pribadi_kebiasaan5__c);
		
		//Data rokok
        ApexPages.currentPage().getParameters().put('rokokPP', eform.Berapa_Batang_PP__c );
        ApexPages.currentPage().getParameters().put('sejakPP', eform.Sejak_PP__c );
        ApexPages.currentPage().getParameters().put('rokokElektrikPP',  eform.Rokok_Elektrik_PP__c );
        ApexPages.currentPage().getParameters().put('sejekElektrikPP',  eform.sejak_elektrik_PP__c );
        ApexPages.currentPage().getParameters().put('tanpaAsapPP',eform.Tanpa_asap_pp__c );

        //DATA KESEHATAN
        ApexPages.currentPage().getParameters().put('DTKESRBPP1', eform.Pertanyaan_dt_kesehatan1__c);
        ApexPages.currentPage().getParameters().put('DTKESRBPP2', eform.Pertanyaan_dt_kesehatan2__c);
        ApexPages.currentPage().getParameters().put('DTKESRBPP3', eform.Pertanyaan_dt_kesehatan3__c);
        ApexPages.currentPage().getParameters().put('DTKESRBPP4', eform.Pertanyaan_dt_kesehatan4__c);
        ApexPages.currentPage().getParameters().put('DTKESRBPP5', eform.Pertanyaan_dt_kesehatan5__c);

        //Data Kesehatan Penjelasan
        // ApexPages.currentPage().getParameters().put('DTKESTAPP1', eform.Penjelasan_dt_kesehatan__c );
        // ApexPages.currentPage().getParameters().put('DTKESTAPP2', eform.Penjelasan_dt_kesehatan1__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAPP3', eform.Penjelasan_dt_kesehatan2__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAPP4', eform.Penjelasan_dt_kesehatan3__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAPP5', eform.Penjelasan_dt_kesehatan4__c);

        //Data Kesehatan khusus wanita 
        ApexPages.currentPage().getParameters().put('DTWARBPP', eform.Pertanyaan_dt_khusus_wanita__c);
       // ApexPages.currentPage().getParameters().put('DTWATAPP', eform.Penjelasan_dt_khusus_wanita__c);
        
        //Data Kesehatan Tambahan
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP1',eform.Pertanyaan_dt_kesehatan_tambahan1__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP2',eform.Pertanyaan_dt_kesehatan_tambahan2__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP3',eform.Pertanyaan_dt_kesehatan_tambahan3__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP4',eform.Pertanyaan_dt_kesehatan_tambahan4__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP5',eform.Pertanyaan_dt_kesehatan_tambahan5__c);
		ApexPages.currentPage().getParameters().put('DTKESTAMRBPP6',eform.Pertanyaan_dt_kesehatan_tambahan6__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP7',eform.Pertanyaan_dt_kesehatan_tambahan7__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP8',eform.Pertanyaan_dt_kesehatan_tambahan8__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP9',eform.Pertanyaan_dt_kesehatan_tambahan9__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP10',eform.Pertanyaan_dt_kesehatan_tambahan10__c);
		ApexPages.currentPage().getParameters().put('DTKESTAMRBPP11',eform.Pertanyaan_dt_kesehatan_tambahan11__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP12',eform.Pertanyaan_dt_kesehatan_tambahan12__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP13',eform.Pertanyaan_dt_kesehatan_tambahan13__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP14',eform.Pertanyaan_dt_kesehatan_tambahan14__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP15',eform.Pertanyaan_dt_kesehatan_tambahan15__c);

        //Data Kesehatan Tambahan Penjelasan
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP1',eform.Penjelasan_dt_kesehatan_tambahan__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP2',eform.Penjelasan_dt_kesehatan_tambahan1__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP3',eform.Penjelasan_dt_kesehatan_tambahan2__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP4',eform.Penjelasan_dt_kesehatan_tambahan3__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP5',eform.Penjelasan_dt_kesehatan_tambahan4__c);
		// ApexPages.currentPage().getParameters().put('DTKESTAMTAPP6',eform.Penjelasan_dt_kesehatan_tambahan5__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP7',eform.Penjelasan_dt_kesehatan_tambahan6__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP8',eform.Penjelasan_dt_kesehatan_tambahan7__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP9',eform.Penjelasan_dt_kesehatan_tambahan8__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP10',eform.Penjelasan_dt_kesehatan_tambahan9__c);
		// ApexPages.currentPage().getParameters().put('DTKESTAMTAPP11',eform.Penjelasan_dt_kesehatan_tambahan10__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP12',eform.Penjelasan_dt_kesehatan_tambahan11__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP13',eform.Penjelasan_dt_kesehatan_tambahan12__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP14',eform.Penjelasan_dt_kesehatan_tambahan13__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP15',eform.Penjelasan_dt_kesehatan_tambahan14__c);

        //Data Riwayat Keluarga
        ApexPages.currentPage().getParameters().put('DTKRKRBPP1', eform.Pertanyaan_dt_riwayat_keluarga__c);
       // ApexPages.currentPage().getParameters().put('DTKESTAPP4', eform.Penjelasan_dt_rwyt_keluarga__c);


         ApexPages.StandardController standardController = new ApexPages.StandardController(eform);
        
        Test.startTest();
        
        // Initialize controller
        AMFS_PemulihanPolis_Controller controller = new AMFS_PemulihanPolis_Controller(standardController);
        
        Test.stopTest();

    }


    @isTest
    static void testControllerWithSubjectParameter2FPP() {

        Datetime eFormDt = system.now().addHours(7);
        String inputdt = eFormDt.format('dd/MM/yyyy, HH:mm');
        String inputDate = eFormDt.format('dd/MM/yyyy');
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id,Policy_Number__c,Log_Case__r.CaseNumber FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c =: '520-4931835' LIMIT 1];
        E_Form_Master_Data__c eform = [SELECT 
        Id,
        Email__c,
        Sign_ID__c,
        Nama_Produk__c,
        No_Rekening__c,
        informasi_pajak_luar_negeri__c,
        Nama_Pemilik_Polis__c,Nomor_Telpon__c,
         alamat__c , Nama_Perusahaan__c,Bidang_Usaha__c,Rincian_Tugas__c,Alat_bantu_yang_digunakan__c,Jabatan__c,pekerjaan__c, Pengkinian_Data__c,Tinggi_Badan__c,Berat_Badan__c,Tinggi_Badan_tahun_lalu__c,Berat_Badan_tahun_lalu__c,Pertanyaan_dt_pribadi_kebiasaan1__c,Pertanyaan_dt_pribadi_kebiasaan2__c,Pertanyaan_dt_pribadi_kebiasaan3__c,Pertanyaan_dt_pribadi_kebiasaan4__c,Pertanyaan_dt_pribadi_kebiasaan5__c,Pertanyaan_dt_pribadi_kebiasaan6__c,Berapa_Batang_PP__c,Sejak_PP__c,Rokok_Elektrik_PP__c,sejak_elektrik_PP__c,Tanpa_asap_pp__c,Pertanyaan_dt_kesehatan1__c,Pertanyaan_dt_kesehatan2__c,Pertanyaan_dt_kesehatan3__c,Pertanyaan_dt_kesehatan4__c,Pertanyaan_dt_kesehatan5__c,
         Pertanyaan_dt_khusus_wanita__c,
         //Penjelasan_dt_khusus_wanita__c,
         Pertanyaan_dt_kesehatan_tambahan1__c,Pertanyaan_dt_kesehatan_tambahan2__c,Pertanyaan_dt_kesehatan_tambahan3__c,Pertanyaan_dt_kesehatan_tambahan4__c,Pertanyaan_dt_kesehatan_tambahan5__c,Pertanyaan_dt_kesehatan_tambahan6__c,Pertanyaan_dt_kesehatan_tambahan7__c,Pertanyaan_dt_kesehatan_tambahan8__c,Pertanyaan_dt_kesehatan_tambahan9__c,Pertanyaan_dt_kesehatan_tambahan10__c,Pertanyaan_dt_kesehatan_tambahan11__c,Pertanyaan_dt_kesehatan_tambahan12__c,Pertanyaan_dt_kesehatan_tambahan13__c,Pertanyaan_dt_kesehatan_tambahan14__c,Pertanyaan_dt_kesehatan_tambahan15__c,
         Pertanyaan_dt_riwayat_keluarga__c
         FROM E_Form_Master_Data__c WHERE Nama_Pemilik_Polis__c=:'JOHN DUMMY AMFS RLS' LIMIT 1];
        // Setup: Create a test page and set parameter

        eform.Pengkinian_Data__c = 'Pemegang Polis';
        eForm.Gender__c = 'F';
        update eform;

        PageReference testPage = Page.VF_PemulihanPolis;
        Test.setCurrentPage(testPage);


        ApexPages.currentPage().getParameters().put('subject', 'Withdrawal');
        ApexPages.currentPage().getParameters().put('polisNo', lbad.Policy_Number__c);
        ApexPages.currentPage().getParameters().put('phName', eform.Nama_Pemilik_Polis__c);
        ApexPages.currentPage().getParameters().put('phone', eform.Nomor_Telpon__c);
        ApexPages.currentPage().getParameters().put('addr', eform.alamat__c);
        ApexPages.currentPage().getParameters().put('email', eform.Email__c);
        ApexPages.currentPage().getParameters().put('pajak', eform.informasi_pajak_luar_negeri__c);
        ApexPages.currentPage().getParameters().put('jabatanPP', eform.Jabatan__c);
        ApexPages.currentPage().getParameters().put('pekerjaanPP', eform.Pekerjaan__c);
        ApexPages.currentPage().getParameters().put('namaPerusahaanPP', eform.Nama_Perusahaan__c);
        ApexPages.currentPage().getParameters().put('bidangUsahaPP', eform.Bidang_Usaha__c);
        ApexPages.currentPage().getParameters().put('rincianTugasPP', eform.Rincian_Tugas__c);
        ApexPages.currentPage().getParameters().put('alatBantuPP', eform.Alat_bantu_yang_digunakan__c);
        ApexPages.currentPage().getParameters().put('tinggiBadanSaatIniPP', eform.Tinggi_Badan__c);
        ApexPages.currentPage().getParameters().put('beratBadanSaatIniPP', eform.Berat_Badan__c);
        ApexPages.currentPage().getParameters().put('tinggiBadanTahunLaluPP', eform.Tinggi_Badan_tahun_lalu__c);
        ApexPages.currentPage().getParameters().put('beratBadanTahunLaluPP', eform.Berat_Badan_tahun_lalu__c);
        //ApexPages.currentPage().getParameters().put('alasanPerubahanPP', eform.Alasan_perubahan_tinggi_berat_badan__c);
        ApexPages.currentPage().getParameters().put('jenisPengkinianData', 'PP');
        ApexPages.currentPage().getParameters().put('jenisKel', 'F');
        
        //DATA PRIBADI dan KEBIASAAN
        ApexPages.currentPage().getParameters().put('DTPKPPRBPP1', eform.Pertanyaan_dt_pribadi_kebiasaan1__c);
        ApexPages.currentPage().getParameters().put('DTPKPPRBPP2', eform.Pertanyaan_dt_pribadi_kebiasaan2__c);
        ApexPages.currentPage().getParameters().put('DTPKPPRBPP3', eform.Pertanyaan_dt_pribadi_kebiasaan3__c);
        ApexPages.currentPage().getParameters().put('DTPKPPRBPP4', eform.Pertanyaan_dt_pribadi_kebiasaan4__c);
        ApexPages.currentPage().getParameters().put('DTPKPPRBPP5', eform.Pertanyaan_dt_pribadi_kebiasaan5__c);
        ApexPages.currentPage().getParameters().put('DTPKPPRBPP6', eform.Pertanyaan_dt_pribadi_kebiasaan6__c);
        
        //DATA PRIBADI dan KEBIASAAN Penjelasan
        // ApexPages.currentPage().getParameters().put('DTPKPPTAPP1', eform.Penjelasan_dt_pribadi_kebiasaan__c);
        // ApexPages.currentPage().getParameters().put('DTPKPPTAPP2', eform.Penjelasan_dt_pribadi_kebiasaan1__c);
        // ApexPages.currentPage().getParameters().put('DTPKPPTAPP3', eform.Penjelasan_dt_pribadi_kebiasaan2__c);
        // ApexPages.currentPage().getParameters().put('DTPKPPTAPP4', eform.Penjelasan_dt_pribadi_kebiasaan3__c);
        // ApexPages.currentPage().getParameters().put('DTPKPPTAPP5', eform.Penjelasan_dt_pribadi_kebiasaan4__c);
        // ApexPages.currentPage().getParameters().put('DTPKPPTAPP6', eform.Penjelasan_dt_pribadi_kebiasaan5__c);
		
		//Data rokok
        ApexPages.currentPage().getParameters().put('rokokPP', eform.Berapa_Batang_PP__c );
        ApexPages.currentPage().getParameters().put('sejakPP', eform.Sejak_PP__c );
        ApexPages.currentPage().getParameters().put('rokokElektrikPP',  eform.Rokok_Elektrik_PP__c );
        ApexPages.currentPage().getParameters().put('sejekElektrikPP',  eform.sejak_elektrik_PP__c );
        ApexPages.currentPage().getParameters().put('tanpaAsapPP',eform.Tanpa_asap_pp__c );

        //DATA KESEHATAN
        ApexPages.currentPage().getParameters().put('DTKESRBPP1', eform.Pertanyaan_dt_kesehatan1__c);
        ApexPages.currentPage().getParameters().put('DTKESRBPP2', eform.Pertanyaan_dt_kesehatan2__c);
        ApexPages.currentPage().getParameters().put('DTKESRBPP3', eform.Pertanyaan_dt_kesehatan3__c);
        ApexPages.currentPage().getParameters().put('DTKESRBPP4', eform.Pertanyaan_dt_kesehatan4__c);
        ApexPages.currentPage().getParameters().put('DTKESRBPP5', eform.Pertanyaan_dt_kesehatan5__c);

        //Data Kesehatan Penjelasan
        // ApexPages.currentPage().getParameters().put('DTKESTAPP1', eform.Penjelasan_dt_kesehatan__c );
        // ApexPages.currentPage().getParameters().put('DTKESTAPP2', eform.Penjelasan_dt_kesehatan1__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAPP3', eform.Penjelasan_dt_kesehatan2__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAPP4', eform.Penjelasan_dt_kesehatan3__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAPP5', eform.Penjelasan_dt_kesehatan4__c);

        //Data Kesehatan khusus wanita 
        ApexPages.currentPage().getParameters().put('DTWARBPP', eform.Pertanyaan_dt_khusus_wanita__c);
       // ApexPages.currentPage().getParameters().put('DTWATAPP', eform.Penjelasan_dt_khusus_wanita__c);
        
        //Data Kesehatan Tambahan
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP1',eform.Pertanyaan_dt_kesehatan_tambahan1__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP2',eform.Pertanyaan_dt_kesehatan_tambahan2__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP3',eform.Pertanyaan_dt_kesehatan_tambahan3__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP4',eform.Pertanyaan_dt_kesehatan_tambahan4__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP5',eform.Pertanyaan_dt_kesehatan_tambahan5__c);
		ApexPages.currentPage().getParameters().put('DTKESTAMRBPP6',eform.Pertanyaan_dt_kesehatan_tambahan6__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP7',eform.Pertanyaan_dt_kesehatan_tambahan7__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP8',eform.Pertanyaan_dt_kesehatan_tambahan8__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP9',eform.Pertanyaan_dt_kesehatan_tambahan9__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP10',eform.Pertanyaan_dt_kesehatan_tambahan10__c);
		ApexPages.currentPage().getParameters().put('DTKESTAMRBPP11',eform.Pertanyaan_dt_kesehatan_tambahan11__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP12',eform.Pertanyaan_dt_kesehatan_tambahan12__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP13',eform.Pertanyaan_dt_kesehatan_tambahan13__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP14',eform.Pertanyaan_dt_kesehatan_tambahan14__c);
        ApexPages.currentPage().getParameters().put('DTKESTAMRBPP15',eform.Pertanyaan_dt_kesehatan_tambahan15__c);

        //Data Kesehatan Tambahan Penjelasan
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP1',eform.Penjelasan_dt_kesehatan_tambahan__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP2',eform.Penjelasan_dt_kesehatan_tambahan1__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP3',eform.Penjelasan_dt_kesehatan_tambahan2__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP4',eform.Penjelasan_dt_kesehatan_tambahan3__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP5',eform.Penjelasan_dt_kesehatan_tambahan4__c);
		// ApexPages.currentPage().getParameters().put('DTKESTAMTAPP6',eform.Penjelasan_dt_kesehatan_tambahan5__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP7',eform.Penjelasan_dt_kesehatan_tambahan6__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP8',eform.Penjelasan_dt_kesehatan_tambahan7__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP9',eform.Penjelasan_dt_kesehatan_tambahan8__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP10',eform.Penjelasan_dt_kesehatan_tambahan9__c);
		// ApexPages.currentPage().getParameters().put('DTKESTAMTAPP11',eform.Penjelasan_dt_kesehatan_tambahan10__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP12',eform.Penjelasan_dt_kesehatan_tambahan11__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP13',eform.Penjelasan_dt_kesehatan_tambahan12__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP14',eform.Penjelasan_dt_kesehatan_tambahan13__c);
        // ApexPages.currentPage().getParameters().put('DTKESTAMTAPP15',eform.Penjelasan_dt_kesehatan_tambahan14__c);

        //Data Riwayat Keluarga
        ApexPages.currentPage().getParameters().put('DTKRKRBPP1', eform.Pertanyaan_dt_riwayat_keluarga__c);
      //  ApexPages.currentPage().getParameters().put('DTKESTAPP4', eform.Penjelasan_dt_rwyt_keluarga__c);


         ApexPages.StandardController standardController = new ApexPages.StandardController(eform);
        
        Test.startTest();
        
        // Initialize controller
        AMFS_PemulihanPolis_Controller controller = new AMFS_PemulihanPolis_Controller(standardController);

       
        Test.stopTest();

    }

    @isTest
    static void testGenerateMetadata() {
        Test.startTest();
        
        // Get the test data created in @TestSetup
        E_Form_Master_Data__c eform = [SELECT 
            Id, Name, Pengkinian_Data__c, Nomor_Telpon__c, Nomor_Kartu_Identitas__c,
            Segmentation__c, Tanggal_Lahir__c, Sign_ID__c, Sign_ID_TP__c,
            Nama_Perusahaan__c, Jabatan__c, Pekerjaan__c, Bidang_Usaha__c,
            Rincian_Tugas__c, Alat_bantu_yang_digunakan__c, Tinggi_Badan__c,
            Berat_Badan__c, Tinggi_Badan_tahun_lalu__c, Berat_Badan_tahun_lalu__c,
            //Alasan_perubahan_tinggi_berat_badan__c, 
            Pertanyaan_dt_pribadi_kebiasaan1__c,
            Pertanyaan_dt_pribadi_kebiasaan2__c, Pertanyaan_dt_pribadi_kebiasaan3__c,
            Pertanyaan_dt_pribadi_kebiasaan4__c, Pertanyaan_dt_pribadi_kebiasaan5__c,
            Pertanyaan_dt_pribadi_kebiasaan6__c, Berapa_Batang_PP__c, Sejak_PP__c,
            Rokok_Elektrik_PP__c, sejak_elektrik_PP__c, Tanpa_asap_pp__c,
            // Penjelasan_dt_pribadi_kebiasaan__c, Penjelasan_dt_pribadi_kebiasaan1__c,
            // Penjelasan_dt_pribadi_kebiasaan2__c, Penjelasan_dt_pribadi_kebiasaan3__c,
            // Penjelasan_dt_pribadi_kebiasaan4__c, Penjelasan_dt_pribadi_kebiasaan5__c,
            Pertanyaan_dt_kesehatan1__c, Pertanyaan_dt_kesehatan2__c, Pertanyaan_dt_kesehatan3__c,
            Pertanyaan_dt_kesehatan4__c, Pertanyaan_dt_kesehatan5__c,
            // Penjelasan_dt_kesehatan__c,
            // Penjelasan_dt_kesehatan1__c, 
            // Penjelasan_dt_kesehatan2__c,
            // Penjelasan_dt_kesehatan3__c,
            // Penjelasan_dt_kesehatan4__c,
             Pertanyaan_dt_kesehatan_tambahan1__c,
            Pertanyaan_dt_kesehatan_tambahan2__c, Pertanyaan_dt_kesehatan_tambahan3__c,
            Pertanyaan_dt_kesehatan_tambahan4__c, Pertanyaan_dt_kesehatan_tambahan5__c,
            Pertanyaan_dt_kesehatan_tambahan6__c, Pertanyaan_dt_kesehatan_tambahan7__c,
            Pertanyaan_dt_kesehatan_tambahan8__c, Pertanyaan_dt_kesehatan_tambahan9__c,
            Pertanyaan_dt_kesehatan_tambahan10__c, Pertanyaan_dt_kesehatan_tambahan11__c,
            Pertanyaan_dt_kesehatan_tambahan12__c, Pertanyaan_dt_kesehatan_tambahan13__c,
            Pertanyaan_dt_kesehatan_tambahan14__c, Pertanyaan_dt_kesehatan_tambahan15__c,
            // Penjelasan_dt_kesehatan_tambahan__c, Penjelasan_dt_kesehatan_tambahan1__c,
            // Penjelasan_dt_kesehatan_tambahan2__c, Penjelasan_dt_kesehatan_tambahan3__c,
            // Penjelasan_dt_kesehatan_tambahan4__c, Penjelasan_dt_kesehatan_tambahan5__c,
            // Penjelasan_dt_kesehatan_tambahan6__c, Penjelasan_dt_kesehatan_tambahan7__c,
            // Penjelasan_dt_kesehatan_tambahan8__c, Penjelasan_dt_kesehatan_tambahan9__c,
            // Penjelasan_dt_kesehatan_tambahan10__c, Penjelasan_dt_kesehatan_tambahan11__c,
            // Penjelasan_dt_kesehatan_tambahan12__c, Penjelasan_dt_kesehatan_tambahan13__c,
            // Penjelasan_dt_kesehatan_tambahan14__c,
            //Penjelasan_dt_khusus_wanita__c, 
            Pertanyaan_dt_khusus_wanita__c,
            Pertanyaan_dt_riwayat_keluarga__c,
            Nama_Tertanggung__c,Nama_Perusahaan_TP__c, Jabatan_TP__c, Pekerjaan_TP__c, Bidang_Usaha_TP__c,
            Rincian_Tugas_TP__c,
            Tinggi_Badan_tahun_lalu_TP__c, Berat_Badan_tahun_lalu_TP__c, 
            //Alasan_perubahan_tinggi_berat_badan_TP__c,
            Pertanyaan_dt_pribadi_kebiasaan1_TP__c, Pertanyaan_dt_pribadi_kebiasaan2_TP__c,
            Pertanyaan_dt_pribadi_kebiasaan3_TP__c, Pertanyaan_dt_pribadi_kebiasaan4_TP__c,
            Pertanyaan_dt_pribadi_kebiasaan5_TP__c, Pertanyaan_dt_pribadi_kebiasaan6_TP__c,
            // Penjelasan_dt_pribadi_kebiasaan_TP__c, Penjelasan_dt_pribadi_kebiasaan1_TP__c,
            // Penjelasan_dt_pribadi_kebiasaan2_TP__c, Penjelasan_dt_pribadi_kebiasaan3_TP__c,
            // Penjelasan_dt_pribadi_kebiasaan4_TP__c, Penjelasan_dt_pribadi_kebiasaan5_TP__c,
            Pertanyaan_dt_kesehatan1_TP__c, Pertanyaan_dt_kesehatan2_TP__c, Pertanyaan_dt_kesehatan3_TP__c,
            Pertanyaan_dt_kesehatan4_TP__c, Pertanyaan_dt_kesehatan5_TP__c, //Penjelasan_dt_kesehatan_TP__c,  
            Alat_bantu_TP__c,Tinggi_Badan_TP__c, Berat_Badan_TP__c,
            // Penjelasan_dt_kesehatan1_TP__c, Penjelasan_dt_kesehatan2_TP__c, Penjelasan_dt_kesehatan3_TP__c,
            // Penjelasan_dt_kesehatan4_TP__c,
            Pertanyaan_dt_kesehatan_tambahan1_TP__c,
            Pertanyaan_dt_kesehatan_tambahan2_TP__c, Pertanyaan_dt_kesehatan_tambahan3_TP__c,
            Pertanyaan_dt_kesehatan_tambahan4_TP__c, Pertanyaan_dt_kesehatan_tambahan5_TP__c,
            Pertanyaan_dt_kesehatan_tambahan6_TP__c, Pertanyaan_dt_kesehatan_tambahan7_TP__c,
            Pertanyaan_dt_kesehatan_tambahan8_TP__c, Pertanyaan_dt_kesehatan_tambahan9_TP__c,
            Pertanyaan_dt_kesehatan_tambahan10_TP__c, Pertanyaan_dt_kesehatan_tambahan11_TP__c,
            Pertanyaan_dt_kesehatan_tambahan12_TP__c, Pertanyaan_dt_kesehatan_tambahan13_TP__c,
            Pertanyaan_dt_kesehatan_tambahan14_TP__c, Pertanyaan_dt_kesehatan_tambahan15_TP__c,
            // Penjelasan_dt_kesehatan_tambahan_TP__c, Penjelasan_dt_kesehatan_tambahan1_TP__c,
            // Penjelasan_dt_kesehatan_tambahan2_TP__c, Penjelasan_dt_kesehatan_tambahan3_TP__c,
            // Penjelasan_dt_kesehatan_tambahan4_TP__c, Penjelasan_dt_kesehatan_tambahan5_TP__c,
            // Penjelasan_dt_kesehatan_tambahan6_TP__c, Penjelasan_dt_kesehatan_tambahan7_TP__c,
            // Penjelasan_dt_kesehatan_tambahan8_TP__c, Penjelasan_dt_kesehatan_tambahan9_TP__c,
            // Penjelasan_dt_kesehatan_tambahan10_TP__c, Penjelasan_dt_kesehatan_tambahan11_TP__c,
            // Penjelasan_dt_kesehatan_tambahan12_TP__c, Penjelasan_dt_kesehatan_tambahan13_TP__c,
            // Penjelasan_dt_kesehatan_tambahan14_TP__c,
            Berapa_Batang_TP__c, Sejak_TP__c, Rokok_Elektrik_TP__c, sejak_elektrik_TP__c, Tanpa_asap_TP__c,
            Pertanyaan_dt_khusus_wanita_TP__c, 
            //Penjelasan_dt_khusus_wanita_TP__c,
            Pertanyaan_dt_riwayat_keluarga_TP__c,
            //Penjelasan_dt_rwyt_keluarga__c, 
            Metadata__c
            //Penjelasan_dt_rwyt_keluarga_TP__c
            FROM E_Form_Master_Data__c 
            WHERE Name = 'Pemulihan Polis - 520-4931835' 
            LIMIT 1
        ];
        
        // Ensure the eform record exists
        System.assertNotEquals(null, eform, 'E_Form_Master_Data__c record should exist');
        
        // Call the generateMetadata method
        AMFS_PemulihanPolis_Controller.generateMetadata(eform);
        
        // Retrieve the updated record to verify metadata generation
        E_Form_Master_Data__c updatedEform = [SELECT Id, Metadata__c FROM E_Form_Master_Data__c WHERE Id = :eform.Id];
        
        // Verify that metadata was generated
        System.assertNotEquals(null, updatedEform.Metadata__c, 'Metadata should be generated');
        System.assert(updatedEform.Metadata__c.length() > 0, 'Metadata should not be empty');
        
        // Parse the JSON metadata to verify structure
        Map<String, Object> metadataMap = (Map<String, Object>) JSON.deserializeUntyped(updatedEform.Metadata__c);
        
        // Verify that the metadata contains expected keys
        System.assert(metadataMap.containsKey('EFORM jenisPengkinianData'), 'Metadata should contain jenisPengkinianData');
        System.assert(metadataMap.containsKey('EFORM Nomor Telpon'), 'Metadata should contain Nomor Telpon');
        System.assert(metadataMap.containsKey('EFORM Nomor Kartu Identitas'), 'Metadata should contain Nomor Kartu Identitas');
        System.assert(metadataMap.containsKey('EFORM Segmentation'), 'Metadata should contain Segmentation');
        System.assert(metadataMap.containsKey('EFORM Sign ID'), 'Metadata should contain Sign ID');
        
        // Verify PEMEGANG POLIS section
        System.assert(metadataMap.containsKey('EFORM Nama Perusahaan'), 'Metadata should contain Nama Perusahaan');
        System.assert(metadataMap.containsKey('EFORM Jabatan'), 'Metadata should contain Jabatan');
        System.assert(metadataMap.containsKey('EFORM Pekerjaan'), 'Metadata should contain Pekerjaan');
        System.assert(metadataMap.containsKey('EFORM Bidang Usaha'), 'Metadata should contain Bidang Usaha');
        
        // Verify Data Fisik section
        System.assert(metadataMap.containsKey('EFORM Tinggi Badan'), 'Metadata should contain Tinggi Badan');
        System.assert(metadataMap.containsKey('EFORM Berat Badan'), 'Metadata should contain Berat Badan');
        
        // Verify Data Pribadi dan Kebiasaan section
        System.assert(metadataMap.containsKey('EFORM Pertanyaan dt pribadi kebiasaan1'), 'Metadata should contain Pertanyaan dt pribadi kebiasaan1');
        System.assert(metadataMap.containsKey('EFORM Pertanyaan dt pribadi kebiasaan2'), 'Metadata should contain Pertanyaan dt pribadi kebiasaan2');
        
        // Verify rokok section
        System.assert(metadataMap.containsKey('EFORM Berapa Batang PP'), 'Metadata should contain Berapa Batang PP');
        System.assert(metadataMap.containsKey('EFORM Sejak PP'), 'Metadata should contain Sejak PP');
        
        // Verify Data Kesehatan section
        System.assert(metadataMap.containsKey('EFORM Pertanyaan dt kesehatan1'), 'Metadata should contain Pertanyaan dt kesehatan1');
        System.assert(metadataMap.containsKey('EFORM Pertanyaan dt kesehatan2'), 'Metadata should contain Pertanyaan dt kesehatan2');
        
        // Verify Data Kesehatan Tambahan section
        System.assert(metadataMap.containsKey('EFORM Pertanyaan dt kesehatan tambahan1'), 'Metadata should contain Pertanyaan dt kesehatan tambahan1');
        System.assert(metadataMap.containsKey('EFORM Pertanyaan dt kesehatan tambahan2'), 'Metadata should contain Pertanyaan dt kesehatan tambahan2');
        
        // Verify Data Khusus Wanita section
        System.assert(metadataMap.containsKey('EFORM Pertanyaan dt khusus wanita'), 'Metadata should contain Pertanyaan dt khusus wanita');
        
        // Verify Data Riwayat Kesehatan Keluarga section
        System.assert(metadataMap.containsKey('EFORM Pertanyaan dt riwayat keluarga'), 'Metadata should contain Pertanyaan dt riwayat keluarga');
        
        // Verify that the metadata contains expected values
        System.assertEquals('Pemegang Polis', metadataMap.get('EFORM jenisPengkinianData'), 'jenisPengkinianData should match test data');
        System.assertEquals('039482', metadataMap.get('EFORM Nomor Telpon'), 'Nomor Telpon should match test data');
        System.assertEquals('123123123123123', metadataMap.get('EFORM Nomor Kartu Identitas'), 'Nomor Kartu Identitas should match test data');
        System.assertEquals('PBC', metadataMap.get('EFORM Segmentation'), 'Segmentation should match test data');
        System.assertEquals('tenis sehat', metadataMap.get('EFORM Nama Perusahaan'), 'Nama Perusahaan should match test data');
        System.assertEquals('coach', metadataMap.get('EFORM Jabatan'), 'Jabatan should match test data');
        System.assertEquals('170', metadataMap.get('EFORM Tinggi Badan'), 'Tinggi Badan should match test data');
        System.assertEquals('67', metadataMap.get('EFORM Berat Badan'), 'Berat Badan should match test data');
        System.assertEquals('Tidak', metadataMap.get('EFORM Pertanyaan dt pribadi kebiasaan1'), 'Pertanyaan dt pribadi kebiasaan1 should match test data');
        System.assertEquals('Ya', metadataMap.get('EFORM Pertanyaan dt pribadi kebiasaan3'), 'Pertanyaan dt pribadi kebiasaan3 should match test data');
        
        // Verify the metadata map size is reasonable (should contain many parameters)
        System.assert(metadataMap.size() > 50, 'Metadata should contain multiple parameters');
        
        Test.stopTest();
    }

    @isTest
    static void testGenerateMetadataWithNullValues() {
        Test.startTest();
        
        // Create an E_Form_Master_Data__c record with minimal data (null values)
        E_Form_Master_Data__c eformMinimal = new E_Form_Master_Data__c();
        eformMinimal.Name = 'Test Minimal Data';
        eformMinimal.Transaction_Type__c = 'Request_POS Pemulihan Polis';
        // Leave most fields as null to test getSafeString handling
        insert eformMinimal;
        
        // Call the generateMetadata method with minimal data
        AMFS_PemulihanPolis_Controller.generateMetadata(eformMinimal);
        
        // Retrieve the updated record
        E_Form_Master_Data__c updatedEform = [SELECT Id, Metadata__c FROM E_Form_Master_Data__c WHERE Id = :eformMinimal.Id];
        
        // Verify that metadata was generated even with null values
        System.assertNotEquals(null, updatedEform.Metadata__c, 'Metadata should be generated even with null values');
        System.assert(updatedEform.Metadata__c.length() > 0, 'Metadata should not be empty');
        
        // Parse the JSON metadata
        Map<String, Object> metadataMap = (Map<String, Object>) JSON.deserializeUntyped(updatedEform.Metadata__c);
        
        // Verify that getSafeString handled null values properly (should return ' ')
        System.assert(metadataMap.containsKey('EFORM Nomor Telpon'), 'Metadata should contain Nomor Telpon key');
        System.assertEquals(' ', metadataMap.get('EFORM Nomor Telpon'), 'Null values should be converted to space by getSafeString');
        
        System.assert(metadataMap.containsKey('EFORM Nama Perusahaan'), 'Metadata should contain Nama Perusahaan key');
        System.assertEquals(' ', metadataMap.get('EFORM Nama Perusahaan'), 'Null values should be converted to space by getSafeString');
        
        Test.stopTest();
    }
}