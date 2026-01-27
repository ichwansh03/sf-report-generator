/**
 * @description       : Form FP5
 * @author            : Ahmad Yazid Munif
 * @group             : 
 * @last modified on  : 09-18-2025
 * @last modified by  : Ahmad Yazid Munif
**/
public class AMFS_FP5_Controller {
    public String touchPoint {get; set;}
    public String touchPointName {get; set;}
    public String polisNo {get; set;}
    public String sign {get; set;}
    public String signTP {get; set;}
    public String imgUrl {get; set;}
    public String imgUrlTP {get; set;}
    public String transNo {get; set;}
    public String namaLengkapPemegangPolis {get; set;}
    public String namaLengkapTertanggung {get; set;}
    public String noTelepon {get; set;}
    public String email {get; set;}
    public String alamatDomisili {get; set;}
    public String noIdentitas {get; set;}
    public String tambahanInformasi {get; set;}
    public String tanggalLahir {get; set;}
    public String segmentasi {get; set;}
    public String formatTempatTanggal {get; set;}
    public String formUtama {get; set;}
    public String lbdDokumenTambahan {get; set;}
    public List<String> listDokumenTambahan {get; set;}
    public AMFS_FP5_Controller(ApexPages.StandardController controller) {
        touchPoint = getParam('touchPoint');
        if(touchPoint!=''){
            touchPointName = 'CCC - '+touchPoint.toUpperCase();
        }
        polisNo = getParam('polisNo');
        String temptransNo = getParam('transNo');
        transNo = 'FP5 - '+temptransNo;
        tambahanInformasi = getUpperParam('tambahanInformasi');
        namaLengkapPemegangPolis = getUpperParam('fullname');
        
        noTelepon = getStripParam('noTelpPolisFP5');
        email = getStripParam('emailPolisFP5');
        alamatDomisili = getStripParam('alamatPolisFP5');
        noIdentitas = getStripParam('noIdentitasKtp');
        segmentasi = getStripParam('segmentasi');
        tanggalLahir = getStripParam('tanggalLahir');
        formUtama = getStripParam('formUtama');
        
        sign = ApexPages.currentPage().getParameters().get('sign');
        signTP = ApexPages.currentPage().getParameters().get('signTP');
        imgUrl = '/sfc/servlet.shepherd/version/download/' + sign;
        if(signTP != ''){
            imgUrlTP = '/sfc/servlet.shepherd/version/download/' + signTP;
            namaLengkapTertanggung = getUpperParam('fullnameTT');
        }else{
            System.debug('#### AMFS Tertanggung ');
            imgUrlTP = '';
            namaLengkapTertanggung = '';
        }
        String tempat = '';
        formatTempatTanggal = touchPoint+', '+getParam('inputDate');

        lbdDokumenTambahan = getParam('dokumenTambahanFP5');
        listDokumenTambahan = new List<String>();
        if (lbdDokumenTambahan != null) listDokumenTambahan = lbdDokumenTambahan.split(';');
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
        return val != null && val != '' ? val.toUpperCase() : '-';
    }
    private static String getSafeString(String paramName) {
        if (String.isBlank(paramName) || paramName == '') {
            return ' ';
        }
        return String.valueOf(paramName);
    }
    private static String getSafeDate(Date paramName) {
        try {
            DateTime myDateTime = DateTime.newInstance(paramName.year(), paramName.month(), paramName.day());
            String formattedDate = myDateTime.format('MM/dd/yyyy');
            return formattedDate;
        } catch (Exception e) {
            return ' ';
        }
    }
    // public static void generateMetadata(Id eformIds) { // future
    // List<E_Form_Data__c> eformRecords = [SELECT Id, Name, Mapping_Metadata__c FROM E_Form_Data__c WHERE Id = :eformIds];
    public static void generateMetadata(E_Form_Master_Data__c eform) {
        System.debug('#### EForm Generate Metadata');
        E_Form_Master_Data__c updateEform = new E_Form_Master_Data__c();
        updateEform.Id = eform.Id;
        Map<String, Object> apiPayload = new Map<String, Object>();
        apiPayload.put('EFORM Id',getSafeString(eform.Id));
        apiPayload.put('EFORM Name',getSafeString(eform.Name));
        apiPayload.put('EFORM Log Book Activitiy Detail', getSafeString(eForm.Log_Book_Activitiy_Detail__c));
        apiPayload.put('EFORM Informasi Tambahan',getSafeString(eform.Alasan__c));
        apiPayload.put('EFORM Pemegang Polis',getSafeString(eform.Nama_Pemilik_Polis__c));
        apiPayload.put('EFORM Alamat Domisili Polis',getSafeString(eform.Alamat_Domisili__c));
        apiPayload.put('EFORM Telepon Polis',getSafeString(eform.Nomor_Telpon__c));
        apiPayload.put('EFORM Email Polis',getSafeString(eform.Email__c));
        apiPayload.put('EFORM Tanggal Lahir Polis', getSafeDate(eform.Tanggal_Lahir__c));
        apiPayload.put('EFORM Segmentation',getSafeString(eform.Segmentation__c));
        apiPayload.put('EFORM Nama Tertanggung',getSafeString(eform.Nama_Tertanggung__c));

        // generate JSON
        String jsonBody = JSON.serialize(apiPayload);
        updateEform.Metadata__c = jsonBody;
        update updateEform;
    }
}