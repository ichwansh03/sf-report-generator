/**
 * @description       : 
 * @author            : Mario Carlos Eyo
 * @group             : 
 * @last modified on  : 15-10-2025
 * @last modified by  : Mario Carlos Eyo
**/
Public class AMFS_PengajuanPenarikanDana_Controller {
    Public String subject {get; set;}
    Public String polisNo {get; set;}
    Public String phName {get; set;}
    Public String phone {get; set;}
    Public String addr {get; set;}
    Public String email {get; set;}
    Public String pajak{get; set;}
    Public String inputdt{get; set;}
    Public String inputDate{get; set;}
    Public String inputdtmmss{get; set;}
    Public String transNo{get; set;}
    Public String alasan{get; set;}
    Public String jumlah{get; set;}
    Public String biaya{get; set;}
    Public String sisa{get; set;}
    Public String awal{get; set;}
    Public String setelah{get; set;}


    Public String namaRekening {get; set;}
    Public String namaBank {get; set;}
    Public String nomorRekening {get; set;}
    Public String mataUang {get; set;}
    Public String tertanggung{get; set;}
    Public String prodName {get; set;}

    Public String sign {get; set;}
    Public String imgUrl {get; set;}
    Public String csName {get; set;}
    Public String touchPoint{get; set;}
    Public String segmentation {get; set;}
    Public String tanggalLahir {get; set;}
    Public String noIdentitas {get; set;}
    Public String type {get; set;}
    //Public String jenisKartu {get; set;}
    Public String paymentMethod {get; set;}
    Public String dataType {get; set;}
    public String transactionsString {get; set;}
    public List<String> transactionsList { get; set; }
    public String dokumenTambahan {get; set;}
    public List<String> dokumenTambahanList { get; set; }
    Public String pengajuan {get; set;}
    Public String dmtm {get;set;}
    Public String department {get;set;}


    Public AMFS_PengajuanPenarikanDana_Controller(ApexPages.StandardController controller) {
        String recordid = ApexPages.currentPage().getParameters().get('id');
        polisNo = getParam('polisNo');

        subject = getUpperParam('subject');
        phName = getStripParam('phName');
        phone = getStripParam('phone');
        addr = getStripParam('addr');
        email = getStripParam('email');
        pajak = getUpperParam('pajak');
        inputdt = getParam('inputdt');
        inputDate = getParam('inputDate');
        inputdtmmss = getParam('inputdtmmss');
        transNo = getStripParam('transNo');
        alasan = getUpperParam('alasan');
        jumlah = getParam('jumlah');
        biaya = getParam('biaya');
        sisa = getParam('sisa');
        awal = getParam('awal');
        setelah = getParam('setelah');
        namaRekening = getUpperParam('namaRekening');
        namaBank = getUpperParam('namaBank');
        nomorRekening = getParam('nomorRekening');
        mataUang = getUpperParam('mataUang');
        tertanggung = getUpperParam('tertanggung');
        prodName = getUpperParam('prodName');
        touchPoint = getUpperParam('touchPoint');
        csName = getUpperParam('csName');
        sign = getParam('sign');
        transactionsString = getStripParam('listTransactions');
        
        transactionsList = new List<String>();
        if (transactionsString != null && transactionsString != '-') {
            transactionsList = transactionsString.split(',');
        }else{
            transactionsList.add('-');
        }
        dokumenTambahan = getStripParam('dokumenTambahanList');
        System.debug('dokumenTambahan >> '+dokumenTambahan);
        dokumenTambahanList = new List<String>();
        if (transactionsString != null && dokumenTambahan != '-') {
            dokumenTambahanList = dokumenTambahan.split(';');
        } else{
            dokumenTambahanList.add('-');
        }
        if(Test.isRunningTest()){
            subject = getStripParam('subjectTest');
        }

        imgUrl = '/sfc/servlet.shepherd/version/download/' + Sign;

        segmentation = getUpperParam('segmentation');
        tanggalLahir = getUpperParam('tanggalLahir');
        noIdentitas = getStripParam('noIdentitas');
        type = getUpperParam('type');
        if(type == 'REDEMPTION'){
            pengajuan = 'Surrender';
        }else{
            pengajuan = 'Cooling Off';
        }
        //jenisKartu = getUpperParam('jenisKartu');
        paymentMethod = getUpperParam('paymentMethod');
        dataType = getUpperParam('dataType');
        dmtm = getUpperParam('dmtm');
        department = getUpperParam('department');

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
        DateTime myDateTime = paramName!= null ? DateTime.newInstance(paramName.year(), paramName.month(), paramName.day()) : null;
        String formattedDate = '';
        if(myDateTime != null){
            formattedDate = myDateTime.format('MM/dd/yyyy');
        }
        return formattedDate;
    }

    private static String getSafeDecimal(Decimal paramName) {
        System.debug('paramName'+paramName);
        if (paramName == NULL) {
            return ' ';
        }
        return String.valueOf(paramName);
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
        prop.put('EFORM Nomor Kartu Identitas', getSafeString(eForm.Nomor_Kartu_Identitas__c));
        prop.put('EFORM Tanggal Lahir', getSafeDate(eForm.Tanggal_Lahir__c));
        prop.put('EFORM Alamat', getSafeString(eForm.Alamat_Domisili__c));
        prop.put('EFORM Email', getSafeString(eForm.Email__c));
        prop.put('EFORM Nama Produk', getSafeString(eForm.Nama_Produk__c));

        if(eForm.name.Contains('Redemption') || eform.name.Contains('Cooling')){
            prop.put('EFORM Mata Uang', getSafeString(eForm.Mata_Uang__c));
        }

        if(eForm.SKDR_SKDKK__c == 'SKDR' || eForm.name.contains('Withdrawal')){
            prop.put('EFORM Nama Bank', getSafeString(eForm.Nama_Bank__c));
            prop.put('EFORM Nomor Rekening', getSafeString(eForm.No_Rekening__c));
        }else if(eForm.SKDR_SKDKK__c == 'SKDKK'){
            prop.put('EFORM Nama Kartu Kredit', getSafeString(eForm.Nama_Bank__c));
            prop.put('EFORM Nomor Kartu Kredit', getSafeString(eForm.No_Rekening__c));
        }
        prop.put('EFORM Nama Rekening', getSafeString(eForm.nama_rekening__c));
        prop.put('EFORM Nilai Tunai Sementara', getSafeDecimal(eForm.Nilai_Tunai_Sementara__c));

        if(eForm.name.contains('Withdrawal')){
            prop.put('EFORM Biaya Transaksi', getSafeDecimal(eForm.Nilai_Tunai_Sementara__c));
            prop.put('EFORM Jumlah Penarikan Dana', getSafeDecimal(eForm.Jumlah_Penarikan_Dana__c));
            prop.put('EFORM Jumlah Setelah Biaya Transaksi', getSafeDecimal(eForm.Jumlah_Setelah_Biaya_Transaksi__c));
            prop.put('EFORM Sisa Dana', getSafeDecimal(eForm.Sisa_Dana__c));
            prop.put('EFORM Mata Uang', getSafeString(eForm.Currency__c));
        }

        String jsonBody = JSON.serialize(prop);
        E_Form_Master_Data__c updateEform = new E_Form_Master_Data__c();
        updateEform.Id = eForm.Id;
        updateEform.Metadata__c = jsonBody;
        update updateEform;
    }
}