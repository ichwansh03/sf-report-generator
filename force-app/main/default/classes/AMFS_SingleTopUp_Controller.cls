/**
 * @description       : 
 * @author            : Mario Carlos Eyo
 * @group             : 
 * @last modified on  : 23-09-2025
 * @last modified by  : Muh Syafiq Hidayatullah
**/
Public class AMFS_SingleTopUp_Controller {
    Public List<DokumenTambahanWrapper> dokumenTambahanList{get; set;}
    public List<SubdanaWrapper> subdanaOld{get; set;}
    public List<SubdanaWrapper> subdanaNew{get; set;}

    Public String polisNo {get; set;}
    Public String phName {get; set;}
    Public String phone {get; set;}
    Public String alamat {get; set;}
    Public String addr {get; set;}
    Public String email {get; set;}
    Public String pajak{get; set;}
    Public String inputdt{get; set;}
    Public String nominal{get; set;}
    Public String tujuan{get; set;}
    Public String sumberDana{get; set;}
    Public String penghasilan{get; set;}
    Public String pekerjaan{get; set;}
    Public String caseType{get; set;}
    Public String subdana1{get; set;}
    Public String subdana2{get; set;}
    Public String subdana3{get; set;}
    Public String subdana4{get; set;}
    Public String percentage1{get; set;}
    Public String percentage2{get; set;}
    Public String percentage3{get; set;}
    Public String percentage4{get; set;}
    Public String code1{get; set;}
    Public String code2{get; set;}
    Public String code3{get; set;}
    Public String code4{get; set;}
    Public String subdanaOld1{get; set;}
    Public String subdanaOld2{get; set;}
    Public String subdanaOld3{get; set;}
    Public String subdanaOld4{get; set;}
    Public String percentageOld1{get; set;}
    Public String percentageOld2{get; set;}
    Public String percentageOld3{get; set;}
    Public String percentageOld4{get; set;}
    Public String codeOld1{get; set;}
    Public String codeOld2{get; set;}
    Public String codeOld3{get; set;}
    Public String codeOld4{get; set;}
    Public String touchPoint{get; set;}
    Public String transNo{get; set;}
    Public String prodName {get; set;}
    Public String paymentMethod {get; set;}
    Public String sign {get; set;}
    Public String imgUrl {get; set;}
    Public String subject {get; set;}
    Public String currencyPendapatan {get; set;}
    Public String curr {get; set;}
    Public String csName {get; set;}

    Public AMFS_SingleTopUp_Controller(ApexPages.StandardController controller){
        String recordid = ApexPages.currentPage().getParameters().get('id');
        polisNo = ApexPages.currentPage().getParameters().get('polisNo');


        subject = getUpperParam('subject');
        touchPoint = getUpperParam('touchPoint');
        csName = getUpperParam('csName');
        phName = getUpperParam('phName');
        pajak = (ApexPages.currentPage().getParameters().get('pajak') != null)? ApexPages.currentPage().getParameters().get('pajak').toUpperCase(): '';
        inputdt = getParam('inputdt');
        nominal = getParam('nominal');
        tujuan = getUpperParam('tujuan');
        sumberDana = getUpperParam('sumberDana');
        penghasilan = getParam('penghasilan');
        currencyPendapatan = getUpperParam('currencyPendapatan');
        pekerjaan = getUpperParam('pekerjaan');
        caseType = getUpperParam('caseType');
        curr = getUpperParam('curr');
        paymentMethod = getUpperParam('paymentMethod');
        prodName = getUpperParam('prodName');
        transNo = getParam('transNo');
        phone = getStripParam('phone');
        alamat = getStripParam('alamat');
        addr = getStripParam('addr');
        email = getStripParam('email');

        sign = ApexPages.currentPage().getParameters().get('sign');
        imgUrl = '/sfc/servlet.shepherd/version/download/' + Sign;

        code1 = ApexPages.currentPage().getParameters().get('code1');
        code2 = ApexPages.currentPage().getParameters().get('code2');
        code3 = ApexPages.currentPage().getParameters().get('code3');
        code4 = ApexPages.currentPage().getParameters().get('code4');

        codeOld1 = ApexPages.currentPage().getParameters().get('codeOld1');
        codeOld2 = ApexPages.currentPage().getParameters().get('codeOld2');
        codeOld3 = ApexPages.currentPage().getParameters().get('codeOld3');
        codeOld4 = ApexPages.currentPage().getParameters().get('codeOld4');

        subdana1 = ApexPages.currentPage().getParameters().get('subdana1');
        subdana2 = ApexPages.currentPage().getParameters().get('subdana2');
        subdana3 = ApexPages.currentPage().getParameters().get('subdana3');
        subdana4 = ApexPages.currentPage().getParameters().get('subdana4');

        subdanaOld1 = ApexPages.currentPage().getParameters().get('subdanaOld1');
        subdanaOld2 = ApexPages.currentPage().getParameters().get('subdanaOld2');
        subdanaOld3 = ApexPages.currentPage().getParameters().get('subdanaOld3');
        subdanaOld4 = ApexPages.currentPage().getParameters().get('subdanaOld4');

        percentage1 = ApexPages.currentPage().getParameters().get('percentage1');
        percentage2 = ApexPages.currentPage().getParameters().get('percentage2');
        percentage3 = ApexPages.currentPage().getParameters().get('percentage3');
        percentage4 = ApexPages.currentPage().getParameters().get('percentage4');

        percentageOld1 = ApexPages.currentPage().getParameters().get('percentageOld1');
        percentageOld2 = ApexPages.currentPage().getParameters().get('percentageOld2');
        percentageOld3 = ApexPages.currentPage().getParameters().get('percentageOld3');
        percentageOld4 = ApexPages.currentPage().getParameters().get('percentageOld4');

        // code1 = getParam('code1');
        // code2 = getParam('code2');
        // code3 = getParam('code3');
        // code4 = getParam('code4');

        // codeOld1 = getParam('codeOld1');
        // codeOld2 = getParam('codeOld2');
        // codeOld3 = getParam('codeOld3');
        // codeOld4 = getParam('codeOld4');

        // subdana1 = getUpperParam('subdana1');
        // subdana2 = getUpperParam('subdana2');
        // subdana3 = getUpperParam('subdana3');
        // subdana4 = getUpperParam('subdana4');

        // subdanaOld1 = getParam('subdanaOld1');
        // subdanaOld2 = getParam('subdanaOld2');
        // subdanaOld3 = getParam('subdanaOld3');
        // subdanaOld4 = getParam('subdanaOld4');

        // percentage1 = getParam('percentage1');
        // percentage2 = getParam('percentage2');
        // percentage3 = getParam('percentage3');
        // percentage4 = getParam('percentage4');

        // percentageOld1 = getParam('percentageOld1');
        // percentageOld2 = getParam('percentageOld2');
        // percentageOld3 = getParam('percentageOld3');
        // percentageOld4 = getParam('percentageOld4');
        
        
        dokumenTambahanList = new List<DokumenTambahanWrapper>();
        String dokumenParam = ApexPages.currentPage().getParameters().get('dokumenTambahanList');
        if (!String.isBlank(dokumenParam)) {
            Integer count = 1;
            for (String d : dokumenParam.split(';')) {
                if (!String.isBlank(d)) {
                    dokumenTambahanList.add(new DokumenTambahanWrapper(count, d.trim()));
                    count++;
                }
            }
        }
        
        subdanaOld = new List<SubdanaWrapper>();
        if(codeOld1 != null) subdanaOld.add(new SubdanaWrapper(codeOld1, subdanaOld1, percentageOld1));
        if(codeOld2 != null && codeOld2 != '-') subdanaOld.add(new SubdanaWrapper(codeOld2, subdanaOld2, percentageOld2));
        if(codeOld3 != null && codeOld3 != '-') subdanaOld.add(new SubdanaWrapper(codeOld3, subdanaOld3, percentageOld3));
        if(codeOld4 != null && codeOld4 != '-') subdanaOld.add(new SubdanaWrapper(codeOld4, subdanaOld4, percentageOld4));
        subdanaNew = new List<SubdanaWrapper>();
        if(code1 != null) subdanaNew.add(new SubdanaWrapper(code1, subdana1, percentage1));
        if(code2 != null && code2 != '-') subdanaNew.add(new SubdanaWrapper(code2, subdana2, percentage2));
        if(code3 != null && code3 != '-') subdanaNew.add(new SubdanaWrapper(code3, subdana3, percentage3));
        if(code4 != null && code4 != '-') subdanaNew.add(new SubdanaWrapper(code4, subdana4, percentage4));
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

    Public class DokumenTambahanWrapper {
        Public Integer nomor { get; set; }
        Public String namaDokumen { get; set; }
        
        Public DokumenTambahanWrapper(Integer nomor, String namaDokumen) {
            this.nomor = nomor;
            this.namaDokumen = namaDokumen;
        }
    }

    Public class SubdanaWrapper {
        Public String code { get; set; }
        Public String subdana { get; set; }
        Public String precentage { get; set; }
        
        Public SubdanaWrapper(String code, String subdana, String precentage) {
            this.code = code;
            this.subdana = subdana;
            this.precentage = precentage;
        }
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

    private static String getSafeDecimal(Decimal paramName) {
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
        prop.put('EFORM Metode Pembayaran', getSafeString(eForm.Payment_Method__c));
        prop.put('EFORM Penghasilan', getSafeDecimal(eForm.Pendapatan__c));
        prop.put('EFORM Top Up Currency', getSafeString(eForm.Top_Up_Currency__c));
        prop.put('EFORM Nominal Top Up', getSafeDecimal(eForm.Nominal__c));
        prop.put('EFORM Tujuan', getSafeString(eForm.tujuan__c	));
        prop.put('EFORM Sumber Dana', getSafeString(eForm.sumberdana__c));
        prop.put('EFORM Pekerjaan', getSafeString(eForm.pekerjaan__c));


        prop.put('EFORM Code Subdana 1', getSafeString(eForm.code_subdana_1__c));
        prop.put('EFORM Code Subdana 2', getSafeString(eForm.code_subdana_2__c));
        prop.put('EFORM Code Subdana 3', getSafeString(eForm.code_subdana_3__c));
        prop.put('EFORM Code Subdana 4', getSafeString(eForm.code_subdana_4__c));

        prop.put('EFORM Subdana 1', getSafeString(eForm.nama_subdana_1__c));
        prop.put('EFORM Subdana 2', getSafeString(eForm.nama_subdana_2__c));
        prop.put('EFORM Subdana 3', getSafeString(eForm.nama_subdana_3__c));
        prop.put('EFORM Subdana 4', getSafeString(eForm.nama_subdana_4__c));

        prop.put('EFORM Percentage 1', getSafeDecimal(eForm.persentase_1__c));
        prop.put('EFORM Percentage 2', getSafeDecimal(eForm.persentase_2__c));
        prop.put('EFORM Percentage 3', getSafeDecimal(eForm.persentase_3__c));
        prop.put('EFORM Percentage 4', getSafeDecimal(eForm.persentase_4__c));

        

        String jsonBody = JSON.serialize(prop);
        E_Form_Master_Data__c updateEform = new E_Form_Master_Data__c();
        updateEform.Id = eform.Id;
        updateEform.Metadata__c = jsonBody;
        update updateEform;
    }
}