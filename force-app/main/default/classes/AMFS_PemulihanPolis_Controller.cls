/**
 * @description       : 
 * @author            : Mario Carlos Eyo
 * @group             : 
 * @last modified on  : 30-09-2025
 * @last modified by  : Muh Syafiq Hidayatullah
**/
public class AMFS_PemulihanPolis_Controller {
    Public String subject {get; set;} 
    Public String jenisKel {get; set;} 
    Public String jenisKelTP {get; set;}
    Public String noTelp {get; set;}
    Public String polisNo {get; set;}
    Public String transNo{get; set;}
    Public String namaLengkap{get; set;}
    Public String inputDate{get; set;}
    Public String segmentasi{get; set;}
    Public String pajak{get; set;}
    Public String touchPoint{get; set;}
    Public String noIdentitas {get; set;}
    Public String tglLahir {get; set;}
    Public String inputdtmmss{get; set;}
    
   	Public String rokokTP{get; set;}
    Public String sejakTP{get; set;}
    Public String rokokElektrikTP{get; set;}
    Public String sejekElektrikTP{get; set;}
    Public String tanpaAsapTP{get; set;}
    
    Public String rokokPP{get; set;}
    Public String sejakPP{get; set;}
    Public String rokokElektrikPP{get; set;}
    Public String sejekElektrikPP{get; set;}
    Public String tanpaAsapPP{get; set;}
    
    
    Public String csName {get; set;}
    Public String phone{get; set;}
    Public String prodName{get; set;}
    Public String email{get; set;}
    Public String addr{get; set;}
    Public String namaPihakPemegangPolis{get; set;}
    Public String jabatanPP{get; set;}
    Public String phName{get; set;}
    Public String jenisPengkinianData{get; set;}
    Public String sign{get; set;}
    Public String signTP {get; set;}
    Public String imgUrl{get; set;}
    Public String imgUrlTP{get; set;}   
    Public String transactionsString {get; set;}
    Public List<String> transactionsList { get; set; }
    Public String dokumenTambahan {get; set;}
    Public List<String> dokumenTambahanList { get; set; }

    Public String alasanPemulihanPolis {get; set;}



    // pemegang polis
        Public String pekerjaanPP{get; set;}
        Public String namaPerusahaanPP{get; set;}
        Public String bidangUsahaPP{get; set;}
        Public String rincianTugasPP{get; set;}
        Public String alatBantuPP{get; set;}
        Public String tinggiBadanSaatIniPP{get; set;}
        Public String beratBadanSaatIniPP{get; set;}
        Public String tinggiBadanTahunLaluPP{get; set;}
        Public String beratBadanTahunLaluPP{get; set;}
        //Public String alasanPerubahanPP{get; set;}

        //DATA PRIBADI dan KEBIASAAN
        Public String DTPKPPRBPP1{get; set;}
        Public String DTPKPPRBPP2{get; set;}
        Public String DTPKPPRBPP3{get; set;}
        Public String DTPKPPRBPP4{get; set;}
        Public String DTPKPPRBPP5{get; set;}
        Public String DTPKPPRBPP6{get; set;}
            //DATA PRIBADI DAN KEBIASAAN PENJELASAN
        // Public String DTPKPPTAPP1{get; set;}
        // Public String DTPKPPTAPP2{get; set;}
        // Public String DTPKPPTAPP3{get; set;}
        // Public String DTPKPPTAPP4{get; set;}
        // Public String DTPKPPTAPP5{get; set;}
        // Public String DTPKPPTAPP6{get; set;}

        //DATA KESEHATAN
        Public String DTKESRBPP1{get; set;}
        Public String DTKESRBPP2{get; set;}
        Public String DTKESRBPP3{get; set;}
        Public String DTKESRBPP4{get; set;}
        Public String DTKESRBPP5{get; set;}
        //DATA KESEHATAN PENJELASAN
        // Public String DTKESTAPP1{get; set;}
        // Public String DTKESTAPP2{get; set;}
        // Public String DTKESTAPP3{get; set;}
        // Public String DTKESTAPP4{get; set;}
        // Public String DTKESTAPP5{get; set;}

        //DATA KESEHATAN TAMBAHAN
        Public String DTKESTAMRBPP1{get; set;}
        Public String DTKESTAMRBPP2{get; set;}
        Public String DTKESTAMRBPP3{get; set;}
        Public String DTKESTAMRBPP4{get; set;}
        Public String DTKESTAMRBPP5{get; set;}
        Public String DTKESTAMRBPP6{get; set;}
        Public String DTKESTAMRBPP7{get; set;}
        Public String DTKESTAMRBPP8{get; set;}
        Public String DTKESTAMRBPP9{get; set;}
        Public String DTKESTAMRBPP10{get; set;}
        Public String DTKESTAMRBPP11{get; set;}
        Public String DTKESTAMRBPP12{get; set;}
        Public String DTKESTAMRBPP13{get; set;}
        Public String DTKESTAMRBPP14{get; set;}
        Public String DTKESTAMRBPP15{get; set;}
        
        //DATA KESEHATAN TAMBAHAN PENJELASAN
        // Public String DTKESTAMTAPP1{get; set;}
        // Public String DTKESTAMTAPP2{get; set;}
        // Public String DTKESTAMTAPP3{get; set;}
        // Public String DTKESTAMTAPP4{get; set;}
        // Public String DTKESTAMTAPP5{get; set;}
        // Public String DTKESTAMTAPP6{get; set;}
        // Public String DTKESTAMTAPP7{get; set;}
        // Public String DTKESTAMTAPP8{get; set;}
        // Public String DTKESTAMTAPP9{get; set;}
        // Public String DTKESTAMTAPP10{get; set;}
        // Public String DTKESTAMTAPP11{get; set;}
        // Public String DTKESTAMTAPP12{get; set;}
        // Public String DTKESTAMTAPP13{get; set;}
        // Public String DTKESTAMTAPP14{get; set;}
        // Public String DTKESTAMTAPP15{get; set;}

    //DATA KHUSUS WANITA
    Public String DTWARBPP{get; set;}
	//Public String DTWATAPP{get; set;}

    //DATA RIWAYAT KESEHATAN KELUARGA dan PENJELASAN
	Public String DTKRKRBPP1{get; set;}
	//Public String DTKRKTAPP1{get; set;}


    // TERTANGGUNG 
    Public String namaTP {get; set;}
    Public String namaPerusahaanTP {get; set;}
    Public String jabatanTP {get; set;}
    Public String pekerjaanTP {get; set;}
    Public String bidangUsahaTP {get; set;}
    Public String rincianTugasTP {get; set;}
    Public String alatBantuTP {get; set;}
    Public String tinggiBadanSaatIniTP {get; set;}
    Public String beratBadanSaatIniTP {get; set;}
    Public String tinggiBadanTahunLaluTP {get; set;}
    Public String beratBadanTahunLaluTP {get; set;}
   // Public String alasanPerubahanTP {get; set;}
         //DATA PRIBADI DAN KEBIASAAN
    Public String DTPKRBTP1 {get; set;}
    Public String DTPKRBTP2 {get; set;}
    Public String DTPKRBTP3 {get; set;}
    Public String DTPKRBTP4 {get; set;}
    Public String DTPKRBTP5 {get; set;}
    Public String DTPKRBTP6 {get; set;}
          //DATA PRIBADI DAN KEBIASAAN PENJELASAN
    // Public String DTPKTATP1 {get; set;}
    // Public String DTPKTATP2 {get; set;}
    // Public String DTPKTATP3 {get; set;}
    // Public String DTPKTATP4 {get; set;}
    // Public String DTPKTATP5 {get; set;}
    // Public String DTPKTATP6 {get; set;}

    //DATA KESEHATAN
    Public String DTKESRBTP1{get; set;}
    Public String DTKESRBTP2{get; set;}
    Public String DTKESRBTP3{get; set;}
    Public String DTKESRBTP4{get; set;}
    Public String DTKESRBTP5{get; set;}
    //DATA KESEHATAN PENJELASAN
    // Public String DTKESTATP1{get; set;}
    // Public String DTKESTATP2{get; set;}
    // Public String DTKESTATP3{get; set;}
    // Public String DTKESTATP4{get; set;}
    // Public String DTKESTATP5{get; set;}

    //DATA KESEHATAN TAMBAHAN
    Public String DTKESTAMRBTP1{get; set;}
    Public String DTKESTAMRBTP2{get; set;}
    Public String DTKESTAMRBTP3{get; set;}
    Public String DTKESTAMRBTP4{get; set;}
    Public String DTKESTAMRBTP5{get; set;}
    Public String DTKESTAMRBTP6{get; set;}
    Public String DTKESTAMRBTP7{get; set;}
    Public String DTKESTAMRBTP8{get; set;}
    Public String DTKESTAMRBTP9{get; set;}
    Public String DTKESTAMRBTP10{get; set;}
    Public String DTKESTAMRBTP11{get; set;}
    Public String DTKESTAMRBTP12{get; set;}
    Public String DTKESTAMRBTP13{get; set;}
    Public String DTKESTAMRBTP14{get; set;}
    Public String DTKESTAMRBTP15{get; set;}
    
    //DATA KESEHATAN TAMBAHAN PENJELASAN
    // Public String DTKESTAMTATP1{get; set;}
    // Public String DTKESTAMTATP2{get; set;}
    // Public String DTKESTAMTATP3{get; set;}
    // Public String DTKESTAMTATP4{get; set;}
    // Public String DTKESTAMTATP5{get; set;}
    // Public String DTKESTAMTATP6{get; set;}
    // Public String DTKESTAMTATP7{get; set;}
    // Public String DTKESTAMTATP8{get; set;}
    // Public String DTKESTAMTATP9{get; set;}
    // Public String DTKESTAMTATP10{get; set;}
    // Public String DTKESTAMTATP11{get; set;}
    // Public String DTKESTAMTATP12{get; set;}
    // Public String DTKESTAMTATP13{get; set;}
    // Public String DTKESTAMTATP14{get; set;}
    // Public String DTKESTAMTATP15{get; set;}

    //DATA KHUSUS WANITA
	Public String DTWARBTP{get; set;}
	//Public String DTWATATP{get; set;}

    //DATA RIWAYAT KESEHATAN KELUARGA dan PENJELASAN
	Public String DTKRKRBTP1{get; set;}
	//Public String DTKRKTATP1{get; set;}

    Public String FPP{get; set;}
    Public String FTP{get; set;}

   

    public AMFS_PemulihanPolis_Controller(ApexPages.StandardController controller) {
       // String recordid = ApexPages.currentPage().getParameters().get('id');
        
        Id recordId = (controller != null) ? controller.getId() : null;
        jenisKel = getUpperParam('jenisKel');
        jenisKelTP = getUpperParam('jenisKelTP');
        subject = getUpperParam('subject');
        segmentasi = getUpperParam('segmentasi');
        noTelp = getUpperParam('noTelp');
        inputdtmmss = getParam('inputdtmmss');
        noIdentitas = getUpperParam('noIdentitas');
        tglLahir = getParam('tglLahir');
        polisNo = getStripParam('polisNo');
        transNo = getStripParam('transNo');
        touchPoint = getUpperParam('touchPoint');
        namaLengkap = getStripParam('namaLengkap');
        pajak = getUpperParam('pajak');
        inputDate = getParam('inputDate');
        touchPoint = getUpperParam('touchPoint');
        csName = getUpperParam('csName');
        sign = getParam('sign');
        signTP = getParam('signTP');
        phone = getParam('phone');
        prodName = getUpperParam('prodName');
        email = getUpperParam('email')  != '' ? getUpperParam('email') : '-' ;
        addr = getStripParam('addr');
        namaPihakPemegangPolis = getUpperParam('namaPihakPemegangPolis');
        
        phName = getUpperParam('phName');
        namaPerusahaanPP = getUpperParam('namaPerusahaanPP');
        jabatanPP = getUpperParam('jabatanPP');
        pekerjaanPP = getUpperParam('pekerjaanPP');
        bidangUsahaPP = getUpperParam('bidangUsahaPP');
        rincianTugasPP = getUpperParam('rincianTugasPP');
        alatBantuPP = getUpperParam('alatBantuPP');
        tinggiBadanSaatIniPP = getUpperParam('tinggiBadanSaatIniPP');
        beratBadanSaatIniPP = getUpperParam('beratBadanSaatIniPP');
        tinggiBadanTahunLaluPP = getUpperParam('tinggiBadanTahunLaluPP');
        beratBadanTahunLaluPP = getUpperParam('beratBadanTahunLaluPP');
        //alasanPerubahanPP = getUpperParam('alasanPerubahanPP');

        //TERTANGGUNG DATA INFORMASI PEKERJAAN DAN FISIK 

        namaTP = getUpperParam('namaTP');
        namaPerusahaanTP = getUpperParam('namaPerusahaanTP');
        jabatanTP	= getUpperParam('jabatanTP');		
        pekerjaanTP		= getUpperParam('pekerjaanTP');
        bidangUsahaTP	= getUpperParam('bidangUsahaTP');	
        rincianTugasTP	= getUpperParam('rincianTugasTP');	
        alatBantuTP		= getUpperParam('alatBantuTP');
        tinggiBadanSaatIniTP	= getUpperParam('tinggiBadanSaatIniTP');
        beratBadanSaatIniTP	= getUpperParam('beratBadanSaatIniTP');
        tinggiBadanTahunLaluTP	= getUpperParam('tinggiBadanTahunLaluTP');
        beratBadanTahunLaluTP	= getUpperParam('beratBadanTahunLaluTP');
        //alasanPerubahanTP	= getUpperParam('alasanPerubahanTP');	
        alasanPemulihanPolis = getUpperParam('alasanPemulihanPolis');


        //DATA PRIBADI DAN KEBIASAAN TP
        DTPKRBTP1 = getUpperParam('DTPKRBTP1');
        DTPKRBTP2 = getUpperParam('DTPKRBTP2');
        DTPKRBTP3 = getUpperParam('DTPKRBTP3');
        DTPKRBTP4 = getUpperParam('DTPKRBTP4');
        DTPKRBTP5 = getUpperParam('DTPKRBTP5');
        DTPKRBTP6 = getUpperParam('DTPKRBTP6');
        
        rokokTP   = getUpperParam('rokokTP');
        sejakTP	  = getUpperParam('sejakTP');
        rokokElektrikTP = getUpperParam('rokokElektrikTP');
        sejekElektrikTP = getUpperParam('sejekElektrikTP');
        tanpaAsapTP = getUpperParam('tanpaAsapTP');

            //data penjelasan
        // DTPKTATP1 = getUpperParam('DTPKTATP1');
        // DTPKTATP2 = getUpperParam('DTPKTATP2');
        // DTPKTATP3 = getUpperParam('DTPKTATP3');
        // DTPKTATP4 = getUpperParam('DTPKTATP4');
        // DTPKTATP5 = getUpperParam('DTPKTATP5');
        // DTPKTATP6 = getUpperParam('DTPKTATP6');
        //DATA KESEHATAN TP
        DTKESRBTP1 = getUpperParam('DTKESRBTP1');
        DTKESRBTP2 = getUpperParam('DTKESRBTP2');
        DTKESRBTP3 = getUpperParam('DTKESRBTP3');
        DTKESRBTP4 = getUpperParam('DTKESRBTP4');
        DTKESRBTP5 = getUpperParam('DTKESRBTP5');
            //DATA KESEHATAN PENJELASAN TP
        // DTKESTATP1 = getUpperParam('DTKESTATP1');
        // DTKESTATP2 = getUpperParam('DTKESTATP2');
        // DTKESTATP3 = getUpperParam('DTKESTATP3');
        // DTKESTATP4 = getUpperParam('DTKESTATP4');
        // DTKESTATP5 = getUpperParam('DTKESTATP5');

        //DATA KESEHATAN TAMBAHAN TP
        DTKESTAMRBTP1 = getUpperParam('DTKESTAMRBTP1');
        DTKESTAMRBTP2 = getUpperParam('DTKESTAMRBTP2');
        DTKESTAMRBTP3 = getUpperParam('DTKESTAMRBTP3');
        DTKESTAMRBTP4 = getUpperParam('DTKESTAMRBTP4');
        DTKESTAMRBTP5 = getUpperParam('DTKESTAMRBTP5');
        DTKESTAMRBTP6 = getUpperParam('DTKESTAMRBTP6');
        DTKESTAMRBTP7 = getUpperParam('DTKESTAMRBTP7');
        DTKESTAMRBTP8 = getUpperParam('DTKESTAMRBTP8');
        DTKESTAMRBTP9 = getUpperParam('DTKESTAMRBTP9');
        DTKESTAMRBTP10 = getUpperParam('DTKESTAMRBTP10');
        DTKESTAMRBTP11 = getUpperParam('DTKESTAMRBTP11');
        DTKESTAMRBTP12 = getUpperParam('DTKESTAMRBTP12');
        DTKESTAMRBTP13 = getUpperParam('DTKESTAMRBTP13');
        DTKESTAMRBTP14 = getUpperParam('DTKESTAMRBTP14');
        DTKESTAMRBTP15 = getUpperParam('DTKESTAMRBTP15');

        //DATA KESEHATAN TAMBAHAN PENJELASAN TP
        // DTKESTAMTATP1 = getUpperParam('DTKESTAMTATP1');
        // DTKESTAMTATP2 = getUpperParam('DTKESTAMTATP2');
        // DTKESTAMTATP3 = getUpperParam('DTKESTAMTATP3');
        // DTKESTAMTATP4 = getUpperParam('DTKESTAMTATP4');
        // DTKESTAMTATP5 = getUpperParam('DTKESTAMTATP5');
        // DTKESTAMTATP6 = getUpperParam('DTKESTAMTATP6');
        // DTKESTAMTATP7 = getUpperParam('DTKESTAMTATP7');
        // DTKESTAMTATP8 = getUpperParam('DTKESTAMTATP8');
        // DTKESTAMTATP9 = getUpperParam('DTKESTAMTATP9');
        // DTKESTAMTATP10 = getUpperParam('DTKESTAMTATP10');
        // DTKESTAMTATP11 = getUpperParam('DTKESTAMTATP11');
        // DTKESTAMTATP12 = getUpperParam('DTKESTAMTATP12');
        // DTKESTAMTATP13 = getUpperParam('DTKESTAMTATP13');
        // DTKESTAMTATP14 = getUpperParam('DTKESTAMTATP14');
        // DTKESTAMTATP15 = getUpperParam('DTKESTAMTATP15');

        //DATA KHUSUS WANITA
        DTWARBTP = getUpperParam('DTWARBTP');
        //DTWATATP = getUpperParam('DTWATATP');

        //DATA RIWAYAT KESEHATAN KELUARGA dan PENJELASAN
        DTKRKRBTP1 = getUpperParam('DTKRKRBTP1');
        //DTKRKTATP1 = getUpperParam('DTKRKTATP1');

        //PEMEGANG POLIS
        		//DATA PRIBADI dan KEBIASAAN PP
        DTPKPPRBPP1 = getUpperParam('DTPKPPRBPP1');
		DTPKPPRBPP2 = getUpperParam('DTPKPPRBPP2');
		DTPKPPRBPP3 = getUpperParam('DTPKPPRBPP3');
		DTPKPPRBPP4 = getUpperParam('DTPKPPRBPP4');
		DTPKPPRBPP5 = getUpperParam('DTPKPPRBPP5');
		DTPKPPRBPP6 = getUpperParam('DTPKPPRBPP6');
        
        //DATA PRIBADI DAN KEBIASAAN PENJELASAN PP
        // DTPKPPTAPP1 = getUpperParam('DTPKPPTAPP1');
		// DTPKPPTAPP2 = getUpperParam('DTPKPPTAPP2');
		// DTPKPPTAPP3 = getUpperParam('DTPKPPTAPP3');
		// DTPKPPTAPP4 = getUpperParam('DTPKPPTAPP4');
		// DTPKPPTAPP5 = getUpperParam('DTPKPPTAPP5');
		// DTPKPPTAPP6 = getUpperParam('DTPKPPTAPP6');
        	//SECTION ROKOK POINT DTPKPPTAPP3
        rokokPP   = getUpperParam('rokokPP');
        sejakPP	  = getUpperParam('sejakPP');
        rokokElektrikPP = getUpperParam('rokokElektrikPP');
        sejekElektrikPP = getUpperParam('sejekElektrikPP');
        tanpaAsapPP = getUpperParam('tanpaAsapPP');

        	//SECTION ROKOK POINT DTPKPPRBPP3
        //DATA KESEHATAN PP
        DTKESRBPP1 = getUpperParam('DTKESRBPP1');
		DTKESRBPP2 = getUpperParam('DTKESRBPP2');
		DTKESRBPP3 = getUpperParam('DTKESRBPP3');
		DTKESRBPP4 = getUpperParam('DTKESRBPP4');
		DTKESRBPP5 = getUpperParam('DTKESRBPP5');
            //DATA KESEHATAN PENJELASAN
		// DTKESTAPP1 = getUpperParam('DTKESTAPP1');
		// DTKESTAPP2 = getUpperParam('DTKESTAPP2');
	    // DTKESTAPP3 = getUpperParam('DTKESTAPP3');
		// DTKESTAPP4 = getUpperParam('DTKESTAPP4');
		// DTKESTAPP5 = getUpperParam('DTKESTAPP5');

        //DATA KESEHATAN TAMBAHAN PP
        DTKESTAMRBPP1 = getUpperParam('DTKESTAMRBPP1');
        DTKESTAMRBPP2 = getUpperParam('DTKESTAMRBPP2');
        DTKESTAMRBPP3 = getUpperParam('DTKESTAMRBPP3');
        DTKESTAMRBPP4 = getUpperParam('DTKESTAMRBPP4');
        DTKESTAMRBPP5 = getUpperParam('DTKESTAMRBPP5');
        DTKESTAMRBPP6 = getUpperParam('DTKESTAMRBPP6');
        DTKESTAMRBPP7 = getUpperParam('DTKESTAMRBPP7');
        DTKESTAMRBPP8 = getUpperParam('DTKESTAMRBPP8');
        DTKESTAMRBPP9 = getUpperParam('DTKESTAMRBPP9');
        DTKESTAMRBPP10 = getUpperParam('DTKESTAMRBPP10');
        DTKESTAMRBPP11 = getUpperParam('DTKESTAMRBPP11');
        DTKESTAMRBPP12 = getUpperParam('DTKESTAMRBPP12');
        DTKESTAMRBPP13 = getUpperParam('DTKESTAMRBPP13');
        DTKESTAMRBPP14 = getUpperParam('DTKESTAMRBPP14');
        DTKESTAMRBPP15 = getUpperParam('DTKESTAMRBPP15');

        //DATA KESAHATAN TAMBAHAN PENJELASAN PP
        // DTKESTAMTAPP1 = getUpperParam('DTKESTAMTAPP1');
        // DTKESTAMTAPP2 = getUpperParam('DTKESTAMTAPP2');
        // DTKESTAMTAPP3 = getUpperParam('DTKESTAMTAPP3');
        // DTKESTAMTAPP4 = getUpperParam('DTKESTAMTAPP4');
        // DTKESTAMTAPP5 = getUpperParam('DTKESTAMTAPP5');
        // DTKESTAMTAPP6 = getUpperParam('DTKESTAMTAPP6');
        // DTKESTAMTAPP7 = getUpperParam('DTKESTAMTAPP7');
        // DTKESTAMTAPP8 = getUpperParam('DTKESTAMTAPP8');
        // DTKESTAMTAPP9 = getUpperParam('DTKESTAMTAPP9');
        // DTKESTAMTAPP10 = getUpperParam('DTKESTAMTAPP10');
        // DTKESTAMTAPP11 = getUpperParam('DTKESTAMTAPP11');
        // DTKESTAMTAPP12 = getUpperParam('DTKESTAMTAPP12');
        // DTKESTAMTAPP13 = getUpperParam('DTKESTAMTAPP13');
        // DTKESTAMTAPP14 = getUpperParam('DTKESTAMTAPP14');
        // DTKESTAMTAPP15 = getUpperParam('DTKESTAMTAPP15');

        // //data khusus wanita pp dan penejelasan
        DTWARBPP = getUpperParam('DTWARBPP');
	    // DTWATAPP = getUpperParam('DTWATAPP');
		
        // //data riwayat kesehatan keluarga dan penjelasan
         DTKRKRBPP1 = getUpperParam('DTKRKRBPP1');
	    // DTKRKTAPP1 = getUpperParam('DTKRKTAPP1');


         



        //SECTION DATA PRIBADI DAN KEBIASAAN POINT 3 ROKOK
        
        if (DTPKRBTP3 == 'YA'){
           rokokTP = ApexPages.currentPage().getParameters().get('rokokTP');
           sejakTP = ApexPages.currentPage().getParameters().get('sejakTP');
           rokokElektrikTP = ApexPages.currentPage().getParameters().get('rokokElektrikTP');
           sejekElektrikTP = ApexPages.currentPage().getParameters().get('sejekElektrikTP');
        } 
        
        if (DTPKPPRBPP3 =='YA') {
           rokokPP = ApexPages.currentPage().getParameters().get('rokokPP');
           sejakPP = ApexPages.currentPage().getParameters().get('sejakPP');
           rokokElektrikPP = ApexPages.currentPage().getParameters().get('rokokElektrikPP');
           sejekElektrikPP = ApexPages.currentPage().getParameters().get('sejekElektrikPP');
        }
        
        // keterangan tambahan
       
        transactionsString = getParam('listTransactions');
        System.debug('transactionString: ' + transactionsString);
        if (transactionsString != null) {
            transactionsList = transactionsString.split(',');
        }  
        //  else {
        //     transactionsList.add('-');
        // }
        
        dokumenTambahan = getStripParam('dokumenTambahanList');
          System.debug('dokumenTambahan: ' + dokumenTambahan);
        if (dokumenTambahan != null) {
            dokumenTambahanList = dokumenTambahan.split(';');
        }
        //  else {
        //     dokumenTambahanList.add('-');
        // }

       
        if(Test.isRunningTest()){
            subject = getStripParam('subjectTest');
        }

        imgUrlTP = '/sfc/servlet.shepherd/version/download/' + signTP;
        imgUrl = '/sfc/servlet.shepherd/version/download/' + sign;
        jenisPengkinianData = getParam('jenisPengkinianData');

        FPP = '';

        System.debug('jenisKel: ' + jenisKel + ' jenisPengkinianData: ' + jenisPengkinianData);
        if(jenisKel == 'F' && (jenisPengkinianData == 'PP' || jenisPengkinianData == 'PPTP')){
            FPP = 'FPP';
        }
        FTP = '';
        if(jenisKelTP == 'F' && (jenisPengkinianData == 'TP' || jenisPengkinianData == 'PPTP')){
            FTP = 'FTP';
        }

    }

    private static String getSafeString(String paramName) {
        //try {
            if (String.isBlank(paramName) || paramName == '') {
                return ' ';
            }
            return String.valueOf(paramName);
        // } catch (Exception e) {
        //     return ' ';
        // }
    }

    public static void generateMetadata(E_Form_Master_Data__c eform) {
        // Buatkan mapping metadata berdasarkan AMFS_GeneratePDF.cls untuk Pemulihan Polis
        Map<String, String> paramMap = new Map<String, String>();

        // Determine jenis pengkinian dat
        E_Form_Master_Data__c updateEform = new E_Form_Master_Data__c();
        updateEform.Id = eform.Id;
        // Basic Information
        paramMap.put('EFORM jenisPengkinianData',  getSafeString(eform.Pengkinian_Data__c));
        paramMap.put('EFORM Nomor Telpon', getSafeString(eform.Nomor_Telpon__c));
        paramMap.put('EFORM Nomor Kartu Identitas', getSafeString(eform.Nomor_Kartu_Identitas__c));
        paramMap.put('EFORM Segmentation', getSafeString(eform.Segmentation__c));
        paramMap.put('EFORM Tanggal Lahir', eform.Tanggal_Lahir__c != null ? String.valueOf(eform.Tanggal_Lahir__c.format()) : '-');
        paramMap.put('EFORM Sign ID', getSafeString(eform.Sign_ID__c));
        paramMap.put('EFORM Sign ID TP', getSafeString(eform.Sign_ID_TP__c));

        // PEMEGANG POLIS - Informasi Pekerjaan
        paramMap.put('EFORM Nama Perusahaan', getSafeString(eform.Nama_Perusahaan__c));
        paramMap.put('EFORM Jabatan', getSafeString(eform.Jabatan__c));
        paramMap.put('EFORM Pekerjaan', getSafeString(eform.Pekerjaan__c));
        paramMap.put('EFORM Bidang Usaha', getSafeString(eform.Bidang_Usaha__c));
        paramMap.put('EFORM Rincian Tugas', getSafeString(eform.Rincian_Tugas__c));
        paramMap.put('EFORM Alat bantu yang digunakan', getSafeString(eform.Alat_bantu_yang_digunakan__c));

        // PEMEGANG POLIS - Data Fisik
        paramMap.put('EFORM Tinggi Badan', getSafeString(eform.Tinggi_Badan__c));
        paramMap.put('EFORM Berat Badan', getSafeString(eform.Berat_Badan__c));
        paramMap.put('EFORM Tinggi Badan tahun lalu', getSafeString(eform.Tinggi_Badan_tahun_lalu__c));
        paramMap.put('EFORM Berat Badan tahun lalu', getSafeString(eform.Berat_Badan_tahun_lalu__c));
       // paramMap.put('EFORM Alasan perubahan tinggi berat badan', getSafeString(eform.Alasan_perubahan_tinggi_berat_badan__c));

        // PEMEGANG POLIS - Data Pribadi dan Kebiasaan
        paramMap.put('EFORM Pertanyaan dt pribadi kebiasaan1', getSafeString(eform.Pertanyaan_dt_pribadi_kebiasaan1__c));
        paramMap.put('EFORM Pertanyaan dt pribadi kebiasaan2', getSafeString(eform.Pertanyaan_dt_pribadi_kebiasaan2__c));
        paramMap.put('EFORM Pertanyaan dt pribadi kebiasaan3', getSafeString(eform.Pertanyaan_dt_pribadi_kebiasaan3__c));
        paramMap.put('EFORM Pertanyaan dt pribadi kebiasaan4', getSafeString(eform.Pertanyaan_dt_pribadi_kebiasaan4__c));
        paramMap.put('EFORM Pertanyaan dt pribadi kebiasaan5', getSafeString(eform.Pertanyaan_dt_pribadi_kebiasaan5__c));
        paramMap.put('EFORM Pertanyaan dt pribadi kebiasaan6', getSafeString(eform.Pertanyaan_dt_pribadi_kebiasaan6__c));

        // PEMEGANG POLIS - Section Rokok
        paramMap.put('EFORM Berapa Batang PP', getSafeString(eform.Berapa_Batang_PP__c));
        paramMap.put('EFORM Sejak PP', getSafeString(eform.Sejak_PP__c));
        paramMap.put('EFORM Rokok Elektrik PP', getSafeString(eform.Rokok_Elektrik_PP__c));
        paramMap.put('EFORM sejak elektrik PP', getSafeString(eform.sejak_elektrik_PP__c));
        paramMap.put('EFORM Tanpa asap pp', getSafeString(eform.Tanpa_asap_pp__c));

        // PEMEGANG POLIS - Penjelasan Data Pribadi dan Kebiasaan
        // paramMap.put('EFORM Penjelasan dt pribadi kebiasaan', getSafeString(eform.Penjelasan_dt_pribadi_kebiasaan__c));
        // paramMap.put('EFORM Penjelasan dt pribadi kebiasaan1', getSafeString(eform.Penjelasan_dt_pribadi_kebiasaan1__c));
        // paramMap.put('EFORM Penjelasan dt pribadi kebiasaan2', getSafeString(eform.Penjelasan_dt_pribadi_kebiasaan2__c));
        // paramMap.put('EFORM Penjelasan dt pribadi kebiasaan3', getSafeString(eform.Penjelasan_dt_pribadi_kebiasaan3__c));
        // paramMap.put('EFORM Penjelasan dt pribadi kebiasaan4', getSafeString(eform.Penjelasan_dt_pribadi_kebiasaan4__c));
        // paramMap.put('EFORM Penjelasan dt pribadi kebiasaan5', getSafeString(eform.Penjelasan_dt_pribadi_kebiasaan5__c));

        // PEMEGANG POLIS - Data Kesehatan
        paramMap.put('EFORM Pertanyaan dt kesehatan1', getSafeString(eform.Pertanyaan_dt_kesehatan1__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan2', getSafeString(eform.Pertanyaan_dt_kesehatan2__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan3', getSafeString(eform.Pertanyaan_dt_kesehatan3__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan4', getSafeString(eform.Pertanyaan_dt_kesehatan4__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan5', getSafeString(eform.Pertanyaan_dt_kesehatan5__c));

        // PEMEGANG POLIS - Penjelasan Data Kesehatan
        // paramMap.put('EFORM Penjelasan dt kesehatan', getSafeString(eform.Penjelasan_dt_kesehatan__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan1', getSafeString(eform.Penjelasan_dt_kesehatan1__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan2', getSafeString(eform.Penjelasan_dt_kesehatan2__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan3', getSafeString(eform.Penjelasan_dt_kesehatan3__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan4', getSafeString(eform.Penjelasan_dt_kesehatan4__c));

        // PEMEGANG POLIS - Data Kesehatan Tambahan
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan1', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan1__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan2', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan2__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan3', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan3__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan4', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan4__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan5', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan5__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan6', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan6__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan7', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan7__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan8', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan8__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan9', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan9__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan10', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan10__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan11', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan11__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan12', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan12__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan13', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan13__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan14', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan14__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan15', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan15__c));

        // PEMEGANG POLIS - Penjelasan Data Kesehatan Tambahan
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan1', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan1__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan2', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan2__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan3', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan3__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan4', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan4__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan5', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan5__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan6', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan6__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan7', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan7__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan8', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan8__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan9', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan9__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan10', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan10__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan11', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan11__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan12', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan12__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan13', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan13__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan14', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan14__c));

        // TERTANGGUNG/PESERTA - Informasi Pekerjaan
        paramMap.put('EFORM Nama Tertanggung', getSafeString(eform.Nama_Tertanggung__c));
        paramMap.put('EFORM Nama Perusahaan TP', getSafeString(eform.Nama_Perusahaan_TP__c));
        paramMap.put('EFORM Jabatan TP', getSafeString(eform.Jabatan_TP__c));
        paramMap.put('EFORM Pekerjaan TP', getSafeString(eform.Pekerjaan_TP__c));
        paramMap.put('EFORM Bidang Usaha TP', getSafeString(eform.Bidang_Usaha_TP__c));
        paramMap.put('EFORM Rincian Tugas TP', getSafeString(eform.Rincian_Tugas_TP__c));
        paramMap.put('EFORM Alat bantu TP', getSafeString(eform.Alat_bantu_TP__c));

        // TERTANGGUNG/PESERTA - Data Fisik
        paramMap.put('EFORM Tinggi Badan TP', getSafeString(eform.Tinggi_Badan_TP__c));
        paramMap.put('EFORM Berat Badan TP', getSafeString(eform.Berat_Badan_TP__c));
        paramMap.put('EFORM Tinggi Badan tahun lalu TP', getSafeString(eform.Tinggi_Badan_tahun_lalu_TP__c));
        paramMap.put('EFORM Berat Badan tahun lalu TP', getSafeString(eform.Berat_Badan_tahun_lalu_TP__c));
       // paramMap.put('EFORM Alasan perubahan tinggi berat badan TP', getSafeString(eform.Alasan_perubahan_tinggi_berat_badan_TP__c));

        // TERTANGGUNG/PESERTA - Data Pribadi dan Kebiasaan
        paramMap.put('EFORM Pertanyaan dt pribadi kebiasaan1 TP', getSafeString(eform.Pertanyaan_dt_pribadi_kebiasaan1_TP__c));
        paramMap.put('EFORM Pertanyaan dt pribadi kebiasaan2 TP', getSafeString(eform.Pertanyaan_dt_pribadi_kebiasaan2_TP__c));
        paramMap.put('EFORM Pertanyaan dt pribadi kebiasaan3 TP', getSafeString(eform.Pertanyaan_dt_pribadi_kebiasaan3_TP__c));
        paramMap.put('EFORM Pertanyaan dt pribadi kebiasaan4 TP', getSafeString(eform.Pertanyaan_dt_pribadi_kebiasaan4_TP__c));
        paramMap.put('EFORM Pertanyaan dt pribadi kebiasaan5 TP', getSafeString(eform.Pertanyaan_dt_pribadi_kebiasaan5_TP__c));
        paramMap.put('EFORM Pertanyaan dt pribadi kebiasaan6 TP', getSafeString(eform.Pertanyaan_dt_pribadi_kebiasaan6_TP__c));

        // TERTANGGUNG/PESERTA - Section Rokok
        paramMap.put('EFORM Berapa Batang TP', getSafeString(eform.Berapa_Batang_TP__c));
        paramMap.put('EFORM Sejak TP', getSafeString(eform.Sejak_TP__c));
        paramMap.put('EFORM Rokok Elektrik TP', getSafeString(eform.Rokok_Elektrik_TP__c));
        paramMap.put('EFORM sejak elektrik TP', getSafeString(eform.sejak_elektrik_TP__c));
        paramMap.put('EFORM Tanpa asap TP', getSafeString(eform.Tanpa_asap_TP__c));

        // TERTANGGUNG/PESERTA - Penjelasan Data Pribadi dan Kebiasaan
        // paramMap.put('EFORM Penjelasan dt pribadi kebiasaan TP', getSafeString(eform.Penjelasan_dt_pribadi_kebiasaan_TP__c));
        // paramMap.put('EFORM Penjelasan dt pribadi kebiasaan1 TP', getSafeString(eform.Penjelasan_dt_pribadi_kebiasaan1_TP__c));
        // paramMap.put('EFORM Penjelasan dt pribadi kebiasaan2 TP', getSafeString(eform.Penjelasan_dt_pribadi_kebiasaan2_TP__c));
        // paramMap.put('EFORM Penjelasan dt pribadi kebiasaan3 TP', getSafeString(eform.Penjelasan_dt_pribadi_kebiasaan3_TP__c));
        // paramMap.put('EFORM Penjelasan dt pribadi kebiasaan4 TP', getSafeString(eform.Penjelasan_dt_pribadi_kebiasaan4_TP__c));
        // paramMap.put('EFORM Penjelasan dt pribadi kebiasaan5 TP', getSafeString(eform.Penjelasan_dt_pribadi_kebiasaan5_TP__c));

        // TERTANGGUNG/PESERTA - Data Kesehatan
        paramMap.put('EFORM Pertanyaan dt kesehatan1 TP', getSafeString(eform.Pertanyaan_dt_kesehatan1_TP__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan2 TP', getSafeString(eform.Pertanyaan_dt_kesehatan2_TP__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan3 TP', getSafeString(eform.Pertanyaan_dt_kesehatan3_TP__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan4 TP', getSafeString(eform.Pertanyaan_dt_kesehatan4_TP__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan5 TP', getSafeString(eform.Pertanyaan_dt_kesehatan5_TP__c));

        // TERTANGGUNG/PESERTA - Penjelasan Data Kesehatan
        // paramMap.put('EFORM Penjelasan dt kesehatan TP', getSafeString(eform.Penjelasan_dt_kesehatan_TP__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan1 TP', getSafeString(eform.Penjelasan_dt_kesehatan1_TP__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan2 TP', getSafeString(eform.Penjelasan_dt_kesehatan2_TP__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan3 TP', getSafeString(eform.Penjelasan_dt_kesehatan3_TP__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan4 TP', getSafeString(eform.Penjelasan_dt_kesehatan4_TP__c));

        // TERTANGGUNG/PESERTA - Data Kesehatan Tambahan
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan1 TP', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan1_TP__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan2 TP', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan2_TP__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan3 TP', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan3_TP__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan4 TP', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan4_TP__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan5 TP', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan5_TP__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan6 TP', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan6_TP__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan7 TP', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan7_TP__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan8 TP', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan8_TP__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan9 TP', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan9_TP__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan10 TP', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan10_TP__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan11 TP', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan11_TP__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan12 TP', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan12_TP__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan13 TP', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan13_TP__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan14 TP', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan14_TP__c));
        paramMap.put('EFORM Pertanyaan dt kesehatan tambahan15 TP', getSafeString(eform.Pertanyaan_dt_kesehatan_tambahan15_TP__c));

        // TERTANGGUNG/PESERTA - Penjelasan Data Kesehatan Tambahan
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan TP', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan_TP__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan1 TP', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan1_TP__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan2 TP', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan2_TP__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan3 TP', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan3_TP__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan4 TP', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan4_TP__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan5 TP', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan5_TP__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan6 TP', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan6_TP__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan7 TP', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan7_TP__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan8 TP', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan8_TP__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan9 TP', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan9_TP__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan10 TP', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan10_TP__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan11 TP', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan11_TP__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan12 TP', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan12_TP__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan13 TP', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan13_TP__c));
        // paramMap.put('EFORM Penjelasan dt kesehatan tambahan14 TP', getSafeString(eform.Penjelasan_dt_kesehatan_tambahan14_TP__c));

        // Data Khusus Wanita
        paramMap.put('EFORM Pertanyaan dt khusus wanita', getSafeString(eform.Pertanyaan_dt_khusus_wanita__c));
        paramMap.put('EFORM Pertanyaan dt khusus wanita TP', getSafeString(eform.Pertanyaan_dt_khusus_wanita_TP__c));
        // paramMap.put('EFORM Penjelasan dt khusus wanita', getSafeString(eform.Penjelasan_dt_khusus_wanita__c));
        // paramMap.put('EFORM Penjelasan dt khusus wanita TP', getSafeString(eform.Penjelasan_dt_khusus_wanita_TP__c));

        // Data Riwayat Kesehatan Keluarga
        paramMap.put('EFORM Pertanyaan dt riwayat keluarga', getSafeString(eform.Pertanyaan_dt_riwayat_keluarga__c));
        paramMap.put('EFORM Pertanyaan dt riwayat keluarga TP', getSafeString(eform.Pertanyaan_dt_riwayat_keluarga_TP__c));
        // paramMap.put('EFORM Penjelasan dt rwyt keluarga', getSafeString(eform.Penjelasan_dt_rwyt_keluarga__c));
        // paramMap.put('EFORM Penjelasan dt rwyt keluarga TP', getSafeString(eform.Penjelasan_dt_rwyt_keluarga_TP__c));

        System.debug('Generated metadata mapping with ' + paramMap.size() + ' parameters');
         String jsonBody = JSON.serialize(paramMap );
        updateEform.Metadata__c = jsonBody;
        update updateEform;
    }


    
    private String getUpperParam(String paramName) {
        String val = ApexPages.currentPage().getParameters().get(paramName);
        return val != null ? val.toUpperCase() : '';
    }
    private String getParam(String paramName) {
        String val = ApexPages.currentPage().getParameters().get(paramName);
        return val != null ? val : '';
    }

    private String getStripParam(String paramName) {
        String val = ApexPages.currentPage().getParameters().get(paramName);
        return val != null ? val.toUpperCase() : '-';
    }


}