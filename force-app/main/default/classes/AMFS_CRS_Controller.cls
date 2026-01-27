/**
 * @description       : 
 * @author            : Ahmad Yazid Munif
 * @group             : 
 * @last modified on  : 24-09-2025
 * @last modified by  : Muh Syafiq Hidayatullah
**/
Public class AMFS_CRS_Controller {

    Public String polisNo {get; set;}
    Public String transNo{get; set;}
    Public String namaLengkap{get; set;}
    Public String namaLengkapBU{get; set;}
    Public String tempatLahir{get; set;}
    Public String tanggalLahir{get; set;}
    Public String tempatTanggal{get; set;}
    Public String jenisIdentitas{get; set;}
    Public String noIdentitas{get; set;}
    Public String alamat{get; set;}
    Public String kota{get; set;}
    Public String kotaCP{get; set;}
    Public String warganegara{get; set;}
    Public String inputdt{get; set;}
    Public String kedudukan {get; set;}
    Public String imgUrl {get; set;}
    Public String negara1 {get; set;}
    Public String negara2 {get; set;}
    Public String negara3 {get; set;}
    Public String npwp1 {get; set;}
    Public String npwp2 {get; set;}
    Public String npwp3 {get; set;}
    Public String alasan1 {get; set;}
    Public String alasan2 {get; set;}
    Public String alasan3 {get; set;}
    // Badan Usaha
    Public String namaPerusahaanAnggaran {get; set;}
    Public String nomorAnggaranDasar {get; set;}
    Public String tanggalAnggaranDasar {get; set;}
    Public String noTdpSdp {get; set;}
    Public String alamatDomisili {get; set;}
    Public String negaraDomisili {get; set;}
    Public String namaPihakPemegangPolis {get; set;}
    Public String jabatan {get; set;}
    Public String namaCPPerusahaan {get; set;}
    Public String jenisIdentitasCP {get; set;}
    Public String nomorIdentitasCP {get; set;}
    Public String tempLahirCP {get; set;}
    Public String tanggalLahirCP {get; set;}
    Public String alamatDomisiliCP {get; set;}
    Public String negaraDomisiliCP {get; set;}
    Public String jenisBadanUsaha {get; set;}
    Public String phName {get; set;}
    Public String laporPajakBU {get; set;}
    Public String touchPoint {get; set;}
    Public String sign {get; set;}

    Public List<NegaraPajakWrapper> negaraPajakList {get; set;}
    Public Integer countNegaraPajak {get;set;}
    Public String kodepos {get; set;}
    Public String kodeposCP {get; set;}
    Public String eFormDt {get; set;}
    Public String inputDate {get; set;}
    Public String pasport {get; set;}


    //controlling person

    Public String laporPajakCP {get; set;}
    Public String negara1CP {get; set;}
    Public String negara2CP {get; set;}
    Public String negara3CP {get; set;}
    Public String npwp1CP {get; set;}
    Public String alasan1CP {get; set;}
    Public String npwp2CP {get; set;}
    Public String alasan2CP {get; set;}
    Public String npwp3CP {get; set;}
    Public String alasan3CP {get; set;}
    Public List<NegaraPajakCPWrapper> negaraPajakCPList {get; set;}
    Public Integer countNegaraPajakCP {get;set;}
    Public String pasportCP {get; set;}

    


    Public AMFS_CRS_Controller(ApexPages.StandardController controller) {
        if(Test.isRunningTest()){
            polisNo = getStripParam('polisNoTest');
        }
        polisNo = getParam('polisNo');
        transNo = getParam('transNo');
        namaLengkap = getUpperParam('NamaLengkap');
        namaLengkapBU = getUpperParam('namaLengkapBU');
        tempatLahir = getUpperParam('tempatLahir');
        tanggalLahir = getParam('tanggalLahir');
        jenisIdentitas = getUpperParam('jenisIdentitas');
        noIdentitas = getParam('noIdentitas');
        alamat = getUpperParam('alamat');
        kota = getUpperParam('kota');
        warganegara = getUpperParam('warganegara');
        inputdt = getParam('inputdt');
        kedudukan = getUpperParam('kedudukan');
        inputDate = getParam('inputDate');
        tempatTanggal = getParam('tempatTanggal'); // tambahan concate


        //Deklarasi Individu
        negara1 = getUpperParam('negara1');
        negara2 = getUpperParam('negara2');
        negara3 = getUpperParam('negara3');
        npwp1 = getUpperParam('npwp1');
        npwp2 = getUpperParam('npwp2');
        npwp3 = getUpperParam('npwp3');
        alasan1 = getUpperParam('kedudalasan1ukan'); // double-check this parameter name
        alasan2 = getUpperParam('alasan2');
        alasan3 = getUpperParam('alasan3');
        pasport = getUpperParam('pasport');
        


        // Badan Usaha
        // NOTE: CP = Controlling Person
        namaPerusahaanAnggaran = getUpperParam('namaPerusahaanAnggaran');
        nomorAnggaranDasar = getUpperParam('nomorAnggaranDasar');
        tanggalAnggaranDasar = getUpperParam('tanggalAnggaranDasar');
        noTdpSdp = getUpperParam('noTdpSdp');
        alamatDomisili = getUpperParam('alamatDomisili');
        negaraDomisili = getUpperParam('negaraDomisili');
        namaPihakPemegangPolis = getUpperParam('namaPihakPemegangPolis');
        jabatan = getUpperParam('jabatan');
        namaCPPerusahaan = getUpperParam('namaCPPerusahaan');
        jenisIdentitasCP = getUpperParam('jenisIdentitasCP');
        nomorIdentitasCP = getUpperParam('nomorIdentitasCP');
        tempLahirCP = getUpperParam('templahirCP');
        tanggalLahirCP = getUpperParam('tanggalLahirCP');
        alamatDomisiliCP = getUpperParam('alamatDomisiliCP');
        negaraDomisiliCP = getUpperParam('negaraDomisiliCP');
        jenisBadanUsaha = getUpperParam('jenisBadanUsaha');
        phName = getUpperParam('phName');
        touchPoint = getUpperParam('touchPoint');
        laporPajakBU = getUpperParam('laporPajakBU');
        sign = getParam('sign');
        kodepos = getUpperParam('kodepos');
        kodeposCP = getUpperParam('kodeposCP');
        eFormDt = getUpperParam('eFormDt');
        kotaCP = getUpperParam('kotaCP');
        pasportCP = getUpperParam('pasportCP');




        system.debug('LAPOR PAJAK BU: ' + laporPajakBU);
        negaraPajakList = new List<NegaraPajakWrapper>();
        if(laporPajakBU == 'YA' || Test.isRunningTest()){
            negara1 = ApexPages.currentPage().getParameters().get('negara1');
            system.debug('MASUK+ '  + negara1);
            negara2 = ApexPages.currentPage().getParameters().get('negara2');
            negara3 = ApexPages.currentPage().getParameters().get('negara3');
            npwp1 = ApexPages.currentPage().getParameters().get('npwp1');
            npwp2 = ApexPages.currentPage().getParameters().get('npwp2');
            npwp3 = ApexPages.currentPage().getParameters().get('npwp3');
            alasan1 = ApexPages.currentPage().getParameters().get('alasan1');
            alasan2 = ApexPages.currentPage().getParameters().get('alasan2');
            alasan3 = ApexPages.currentPage().getParameters().get('alasan3');
            if(negara1 != null) negaraPajakList.add(new NegaraPajakWrapper(negaraPajakList.size()+1,negara1, npwp1, alasan1));
            if(negara2 != null) negaraPajakList.add(new NegaraPajakWrapper(negaraPajakList.size()+1,negara2, npwp2, alasan2));
            if(negara3 != null) negaraPajakList.add(new NegaraPajakWrapper(negaraPajakList.size()+1,negara3, npwp3, alasan3));
        }
        laporPajakCP = getUpperParam('laporPajakCP');
        system.debug('LAPOR PAJAK CP: ' + laporPajakCP);
        negaraPajakCPList = new List<NegaraPajakCPWrapper>();
        if(laporPajakCP == 'YA' || Test.isRunningTest()){
            negara1CP = ApexPages.currentPage().getParameters().get('negara1CP');
            negara2CP = ApexPages.currentPage().getParameters().get('negara2CP');
            negara3CP = ApexPages.currentPage().getParameters().get('negara3CP');
            npwp1CP = ApexPages.currentPage().getParameters().get('npwp1CP');
            npwp2CP = ApexPages.currentPage().getParameters().get('npwp2CP');
            npwp3CP = ApexPages.currentPage().getParameters().get('npwp3CP');
            alasan1CP = ApexPages.currentPage().getParameters().get('alasan1CP');
            alasan2CP = ApexPages.currentPage().getParameters().get('alasan2CP');
            alasan3CP = ApexPages.currentPage().getParameters().get('alasan3CP');
            if(negara1CP != null) negaraPajakCPList.add(new NegaraPajakCPWrapper(negaraPajakCPList.size()+1,negara1CP, npwp1CP, alasan1CP));
            if(negara2CP != null) negaraPajakCPList.add(new NegaraPajakCPWrapper(negaraPajakCPList.size()+1,negara2CP, npwp2CP, alasan2CP));
            if(negara3CP != null) negaraPajakCPList.add(new NegaraPajakCPWrapper(negaraPajakCPList.size()+1,negara3CP, npwp3CP, alasan3CP));
       
        }
        countNegaraPajak = negaraPajakList.size();
        countNegaraPajakCP = negaraPajakCPList.size();
        imgUrl = '/sfc/servlet.shepherd/version/download/' + Sign;
    }

    Public class NegaraPajakWrapper {
        Public Integer index { get; set; }
        Public String negara { get; set; }
        Public String nomorTIN { get; set; }
        Public String alasan { get; set; }
        
        Public NegaraPajakWrapper(Integer i, String negara, String nomorTIN, String alasan) {
            this.index = i;
            this.negara = negara;
            this.nomorTIN = nomorTIN;
            this.alasan = alasan;
        }
    }

     Public class NegaraPajakCPWrapper {
        Public Integer index { get; set; }
        Public String negara { get; set; }
        Public String nomorTIN { get; set; }
        Public String alasan { get; set; }
        
        Public NegaraPajakCPWrapper(Integer i, String negara, String nomorTIN, String alasan) {
            this.index = i;
            this.negara = negara;
            this.nomorTIN = nomorTIN;
            this.alasan = alasan;
        }
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

    private static String getSafeString(String paramName) {

            if (String.isBlank(paramName) || paramName == '-') {
                return ' ';
            }
            return String.valueOf(paramName);
    }
    private static String getSafeDate(Date paramName) {
        DateTime myDateTime ;
        if (paramName != null) {
            myDateTime = DateTime.newInstance(paramName.year(), paramName.month(), paramName.day());
        }
        String formattedDate = '';
        if(myDateTime != null){
            formattedDate = myDateTime.format('MM/dd/yyyy');
        }
        return formattedDate;
    }

    public static void generateMetadata(E_Form_Master_Data__c eForm){
        Map<String, Object> prop = new Map<String, Object>();
        prop.put('EFORM Id', getSafeString(eForm.Id));
        prop.put('EFORM Name', getSafeString(eForm.Name));
        prop.put('EFORM Log Book Activitiy Detail', getSafeString(eForm.Log_Book_Activitiy_Detail__c));
        prop.put('EFORM Informasi Pajak Luar Negeri', getSafeString(eForm.informasi_pajak_luar_negeri__c));
        prop.put('EFORM Negara Pelaporan Pajak', getSafeString(eForm.Negara_Pelaporan_Pajak__c));
        prop.put('EFORM Transaction Type', getSafeString(eForm.Transaction_Type__c));
        prop.put('EFORM Nomor Polis', getSafeString(eForm.Nomor_Polis__c));
        prop.put('EFORM Plan Code', getSafeString(eForm.Plan_Code__c));
        prop.put('EFORM Segmentation', getSafeString(eForm.Segmentation__c));
        prop.put('EFORM Tanggal Pengajuan', getSafeDate(eForm.Tanggal_Pengajuan__c));
        prop.put('EFORM Nomor Telpon', getSafeString(eForm.Nomor_Telpon__c));
        prop.put('EFORM Name Pemegang Polis', getSafeString(eForm.Nama_Pemilik_Polis__c));
        prop.put('EFORM Jenis Identitas', getSafeString(eForm.Jenis_Identitas__c));
        prop.put('EFORM Nomor Kartu Identitas', getSafeString(eForm.Nomor_Kartu_Identitas__c));
        prop.put('EFORM Tanggal Lahir', getSafeDate(eForm.Tanggal_Lahir__c));
        prop.put('EFORM Alamat', getSafeString(eForm.Alamat_Domisili__c));
        prop.put('EFORM Email', getSafeString(eForm.Email__c));
        prop.put('EFORM Nama Produk', getSafeString(eForm.Nama_Produk__c));
        prop.put('EFORM Tempat Lahir', getSafeString(eForm.Tempat_Lahir__c));
        prop.put('EFORM Tanggal Lahir', getSafeDate(eForm.Tanggal_Lahir__c));


        prop.put('EFORM Kedudukan Polis', getSafeString(eForm.Kedudukan_Polis__c));
        prop.put('EFORM Nama Lengkap', getSafeString(eForm.Nama_Lengkap__c));
        prop.put('EFORM Nama Lengkap Badan Usaha', getSafeString(eForm.Nama_Pihak_Berwenang_Pemegang_Polis__c));
        prop.put('EFORM Kode Pos', getSafeString(eForm.Kode_Pos__c));


        prop.put('EFORM Kewarganegaraan', getSafeString(eForm.Kewarganegaraan__c));

        prop.put('EFORM Jenis Badan Usaha', getSafeString(eForm.Jenis_Bdn_Usaha__c));
        prop.put('EFORM Lapor Pajak Badan Usaha', getSafeString(eForm.Apakah_Badan_Usaha_ini_melakukan_pelapor__c));
        prop.put('EFORM Negara Lapor Pajak 1', getSafeString(eForm.Negara_Terdaftar_Wajib_Pajak__c));
        prop.put('EFORM Negara Lapor Pajak 2', getSafeString(eForm.Negara_Terdaftar_Wajib_Pajak1__c));
        prop.put('EFORM Negara Lapor Pajak 3', getSafeString(eForm.Negara_Terdaftar_Wajib_Pajak2__c));
        prop.put('EFORM NPWP 1', getSafeString(eForm.NPWP__c));
        prop.put('EFORM NPWP 2', getSafeString(eForm.NPWP1__c));
        prop.put('EFORM NPWP 3', getSafeString(eForm.NPWP2__c));
        prop.put('EFORM Alasan Tidak Lapor Pajak 1', getSafeString(eForm.Alasan_Tidak_Ada_NPWP__c));
        prop.put('EFORM Alasan Tidak Lapor Pajak 2', getSafeString(eForm.Alasan_Tidak_Ada_NPWP1__c));
        prop.put('EFORM Alasan Tidak Lapor Pajak 3', getSafeString(eForm.Alasan_Tidak_Ada_NPWP2__c));
        prop.put('EFORM Nama Pikah Pemehang Polis', getSafeString(eForm.Nama_Pihak_Berwenang_Pemegang_Polis__c));
        

        prop.put('EFORM Kode Pos Controlling Person', getSafeString(eForm.Kode_Pos_Controlling_Persong__c));
        prop.put('EFORM Lapor Pajak Controlling Person', getSafeString(eForm.Apakah_Controlling_Person_ini_melakukan__c));
        prop.put('EFORM Jabatan', getSafeString(eForm.Jabatan__c));
        prop.put('EFORM Nama Perusahaan', getSafeString(eForm.Nama_Perusahaan__c));
        prop.put('EFORM Nomor TDPSDP', getSafeString(eForm.Nomor_TDP_SDP__c));

        prop.put('EFORM Nomor Anggaran Dasar', getSafeString(eForm.Nomor_Anggaran_Dasar_Perusahaan__c));
        prop.put('EFORM Negara Lapor Pajak CP 1', getSafeString(eForm.Negara_Terdaftar_Wajib_Pajak_CP_1__c));
        prop.put('EFORM Negara Lapor Pajak CP 2', getSafeString(eForm.Negara_Terdaftar_Wajib_Pajak_CP_2__c));
        prop.put('EFORM Negara Lapor Pajak CP 3', getSafeString(eForm.Negara_Terdaftar_Wajib_Pajak_CP_3__c));
        prop.put('EFORM NPWP CP 1', getSafeString(eForm.NPWP_CP_1__c));
        prop.put('EFORM NPWP CP 2', getSafeString(eForm.NPWP_CP_2__c));
        prop.put('EFORM NPWP CP 3', getSafeString(eForm.NPWP_CP_3__c));
        prop.put('EFORM Alasan Tidak Lapor Pajak CP 1', getSafeString(eForm.Alasan_CP_1__c));
        prop.put('EFORM Alasan Tidak Lapor Pajak CP 2', getSafeString(eForm.Alasan_CP_2__c));
        prop.put('EFORM Alasan Tidak Lapor Pajak CP 3', getSafeString(eForm.Alasan_CP_3__c));


        prop.put('EFORM Tempat Lahir CP', getSafeString(eForm.Tempat_Lahir_Controlling_Person__c));
        prop.put('EFORM Alamat Domisili CP', getSafeString(eForm.Alamat_Domisili_Controlling_Person__c));
        prop.put('EFORM Negara Domisili CP', getSafeString(eForm.Negara_Domisili_Controlling_Person__c));
        if(eForm.Jenis_Identitas_Controlling_Person__c == 'KTP'){
            prop.put('EFORM Nomor Identitas CP', getSafeString(eForm.Nomor_Identitas_Controlling_Person__c));
        }else{
        prop.put('EFORM Nomor Identitas CP', getSafeString(eForm.Pasport_CP__c));

        }
        if(eForm.Jenis_Identitas__c == 'KTP'){
            prop.put('EFORM Nomor', getSafeString(eForm.Nomor_Kartu_Identitas__c));
        }else{
        prop.put('EFORM Nomor Identitas CP', getSafeString(eForm.Pasport__c));

        }
        prop.put('EFORM Jenis Identitas CP', getSafeString(eForm.Jenis_Identitas_Controlling_Person__c));
        prop.put('EFORM Kota CP', getSafeString(eForm.Kota_Controlling_Person__c));
        prop.put('EFORM Kota', getSafeString(eForm.Kota__c));
        prop.put('EFORM Tanggal Anggaran Dasar', getSafeDate(eForm.Tanggal_Anggaran_Dasar_Perusahaan__c));
        prop.put('EFORM Negara Domisili', getSafeString(eForm.Negara_Domisili__c));
        prop.put('EFORM Nama CP', getSafeString(eForm.Nama_Controlling_Person_Perusahaan__c));     

        String jsonBody = JSON.serialize(prop);
        E_Form_Master_Data__c updateEform = new E_Form_Master_Data__c();
        updateEform.Id = eform.Id;
        updateEform.Metadata__c = jsonBody;
        update updateEform;
    }
}