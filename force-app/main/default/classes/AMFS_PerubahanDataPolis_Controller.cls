/**
 * @description       : 
 * @author            : Muh Syafiq Hidayatullah
 * @group             : 
 * @last modified on  : 24-09-2025
 * @last modified by  : Mario Carlos Eyo
**/
Public class AMFS_PerubahanDataPolis_Controller {
    Public List<DokumenTambahanWrapper> dokumenTambahan{get; set;}
    Public List<DokumenTambahanWrapper> formTambahan{get; set;}
    Public String sign {get; set;}
    Public String signTP {get; set;}
    Public String imgUrl {get; set;}
    Public String imgUrlTP {get; set;}
    Public String formName {get; set;}
    Public String polisNo {get; set;}
    Public String subjectTransaction {get; set;}
    Public String subjectTransactionTable {get; set;}
    Public String subjectTransactionLower {get; set;}
    Public String subjectTransactionNumber {get; set;}
    Public List<ValueAlasanWrapper> subjectDesc {get; set;}
    Public List<ValueAlasanWrapper> valueAlasan {get; set;}
    Public List<ValueAlasanWrapper> valueAlasanCuti {get; set;}
    Public List<ValueAlasanWrapper> valueAlasanAhli {get; set;}
    Public List<ValueAlasanWrapper> subjectDescCuti {get; set;}
    Public List<ValueAlasanWrapper> subjectAlasanCuti {get; set;}

    Public String transNo {get; set;}
    Public String inputdtmmss {get; set;}
    Public String inputDate {get; set;}
    Public String csName {get; set;}
    Public String touchPoint {get; set;}

    Public String pajak {get; set;}
    Public String alasan {get; set;}
    Public String centangTelepon {get; set;}
    Public String centangNIK {get; set;}
    Public String centangAlamat {get; set;}
    Public String centangEmail {get; set;}
    
    // Informasi Pemegang Polis
    Public String phName {get; set;}
    Public String nameTT {get; set;}
    Public String phone {get; set;}
    Public String tempPhone {get; set;}
    Public String tempNIK {get; set;}
    Public String NIK {get; set;}
    Public String tanggalLahir {get; set;}
    Public String addr {get; set;}
    Public String tempAddr {get; set;}
    Public String email {get; set;}
    Public String tempEmail {get; set;}
    Public String prodName {get; set;}
    Public String segmentasi {get; set;}
    Public String jenisPilihan {get; set;}
    
    // Use for List
    Public List<DoublePerubahanWrapper> doublePerubahan {get; set;}
    Public List<SinglePerubahanWrapper> singlePerubahan {get; set;}
    // Perubahan Alamat Email 
    Public String headerPerubahan {get; set;}
    Public String headerSingle {get; set;}
    // Ahli Waris
    Public List<AhliWarisWrapper> ahliWaris {get; set;}
    // Cuti Premi
    Public List<ValueAlasanWrapper> valueFooter {get; set;}

    Public static Map<String, String> prop = new Map<String, String>();


    Public AMFS_PerubahanDataPolis_Controller(ApexPages.StandardController controller){
        String recordid = ApexPages.currentPage().getParameters().get('id');
        sign = ApexPages.currentPage().getParameters().get('sign');
        signTP = ApexPages.currentPage().getParameters().get('signTP');
        imgUrl = '/sfc/servlet.shepherd/version/download/' + sign;
        imgUrlTP = '/sfc/servlet.shepherd/version/download/' + signTP;
        polisNo = ApexPages.currentPage().getParameters().get('polisNo');
        formName = ApexPages.currentPage().getParameters().get('formName');

        transNo = getStripParam('transNo');
        inputdtmmss = getParam('inputdtmmss');
        inputDate = getParam('inputDate');
        csName = getStripParam('csName');
        touchPoint = getStripParam('touchPoint');
        pajak = getUpperParam('pajak');
        alasan = getUpperParam('alasan');

        // Informasi Pemegang Polis
        phName = getStripParam('phName');
        nameTT = getStripParam('nameTT');
        tempPhone = ApexPages.currentPage().getParameters().get('phone');
        phone = (tempPhone != null && String.isNotEmpty(tempPhone)) ? tempPhone : '-';
        tempNIK = ApexPages.currentPage().getParameters().get('NIK');
        NIK = (tempNIK != null && String.isNotEmpty(tempNIK)) ? tempNIK : '-';
        tanggalLahir = ApexPages.currentPage().getParameters().get('tanggalLahir');
        tempAddr = getUpperParam('addr');
        system.debug('####### TEMPADDR #'+tempAddr);
        addr = (tempAddr != null && String.isNotEmpty(tempAddr)) ? tempAddr : '-';
        system.debug('####### ADDR #'+addr);
        tempEmail = getUpperParam('email');
        email = (tempEmail != null && String.isNotEmpty(tempEmail)) ? tempEmail : '-';
        prodName = getUpperParam('prodName');
        segmentasi = getUpperParam('segmentasi');

        // Dokumen Tambahan
        dokumenTambahan = new List<DokumenTambahanWrapper>();
        Integer numberDokumenTambahan = 1;
        // String dokumenParam = ApexPages.currentPage().getParameters().get('dokumenTambahan');
        String dokumenParam = getUpperParam('dokumenTambahan');
        if (!String.isBlank(dokumenParam)) {
            for (String d : dokumenParam.split(';')) {
                if (!String.isBlank(d)) {
                    dokumenTambahan.add(new DokumenTambahanWrapper(numberDokumenTambahan, d.trim()));
                    numberDokumenTambahan++;
                }
            }
        }
        system.debug('Dokumen Tambahan========' + dokumenTambahan);
        

        // Form Tambahan
        formTambahan = new List<DokumenTambahanWrapper>();
        Integer numberFormTambahan = 1;
        // String ketParam = ApexPages.currentPage().getParameters().get('formTambahan');
        String ketParam = getUpperParam('formTambahan');
        if (!String.isBlank(ketParam)) {
            for (String d : ketParam.split(',')) {
                if (!String.isBlank(d)) {
                    formTambahan.add(new DokumenTambahanWrapper(numberFormTambahan, d.trim()));
                    numberFormTambahan++;
                }
            }
        }
        system.debug('FORM Tambahan========' + formTambahan);


        // Map<String, String> prop = new Map<String,String>();
        prop.put('EFORM ID', recordid);
        prop.put('EFORM Name ', formName);
        

        if(formname.Contains('Perubahan Alamat Email')){
            
            subjectTransaction = getUpperParam('subjectTransaction');
            subjectTransactionTable = getUpperParam('subjectTransaction');
            subjectTransactionLower = getParam('subjectTransaction');
            subjectTransactionNumber = getParam('subjectTransactionNumber');

            subjectDesc = new List<ValueAlasanWrapper>();
            String subject = getParam('subjectTransactionNumber');
            ValueAlasanWrapper tempSub = new ValueAlasanWrapper();
            tempSub.alasan = subject;
            subjectDesc.add(tempSub);
            
            valueAlasan = new List<ValueAlasanWrapper>();
            ValueAlasanWrapper tempSubAla = new ValueAlasanWrapper();
            tempSubAla.alasan = alasan;
            valueAlasan.add(tempSubAla);
            
            String emailSebelumnya = getUpperParam('emailSebelumnya');
            String emailSebelumnyaTP = getUpperParam('emailSebelumnyaTP');
            String emailTerbaru = getUpperParam('emailTerbaru');
            String emailTerbaruTP = getUpperParam('emailTerbaruTP');

            headerPerubahan = 'Alamat Email';

            if(emailTerbaru != '-' && emailTerbaruTP != '-'){
                system.debug('masuk 1');
                centangEmail = 'yes';
                doublePerubahan = new List<DoublePerubahanWrapper>();
                DoublePerubahanWrapper p = new DoublePerubahanWrapper();
                p.nama = 'Email Sebelumnya';
                p.val1 = emailSebelumnya;
                p.val2 = emailSebelumnyaTP;
                DoublePerubahanWrapper p2 = new DoublePerubahanWrapper();
                p2.nama = 'Email Terbaru';
                p2.val1 = emailTerbaru;
                p2.val2 = emailTerbaruTP;
                doublePerubahan.add(p);
                doublePerubahan.add(p2);
            }
            else if(emailTerbaru != '-' && emailTerbaruTP == '-'){
                system.debug('masuk 2');
                centangEmail = 'yes';
                singlePerubahan = new List<SinglePerubahanWrapper>();
                headerSingle = 'Pemegang Polis';
                SinglePerubahanWrapper p = new SinglePerubahanWrapper();
                p.nama = 'Email Sebelumnya';
                p.val1 = emailSebelumnya;
                SinglePerubahanWrapper p2 = new SinglePerubahanWrapper();
                p2.nama = 'Email Terbaru';
                p2.val1 = emailTerbaru;
                singlePerubahan.add(p);
                singlePerubahan.add(p2);
            }
            else if(emailTerbaru == '-' && emailTerbaruTP != '-'){
                system.debug('masuk 3');
                centangEmail = 'no';
                singlePerubahan = new List<SinglePerubahanWrapper>();
                headerSingle = 'Tertanggung/Peserta';
                SinglePerubahanWrapper p = new SinglePerubahanWrapper();
                p.nama = 'Email Sebelumnya';
                p.val1 = emailSebelumnya;
                SinglePerubahanWrapper p2 = new SinglePerubahanWrapper();
                p2.nama = 'Email Terbaru';
                p2.val1 = emailTerbaruTP;
                singlePerubahan.add(p);
                singlePerubahan.add(p2);
            }
        }
        else if(formname.Contains('Perubahan Alamat Koresponden')){
            subjectTransaction = getUpperParam('subjectTransaction');
            subjectTransactionTable = getUpperParam('subjectTransaction');
            subjectTransactionLower = getParam('subjectTransaction');
            subjectTransactionNumber = getParam('subjectTransactionNumber');

            subjectDesc = new List<ValueAlasanWrapper>();
            String subject = getParam('subjectTransactionNumber');
            ValueAlasanWrapper tempSub = new ValueAlasanWrapper();
            tempSub.alasan = subject;
            subjectDesc.add(tempSub);
            
            valueAlasan = new List<ValueAlasanWrapper>();
            ValueAlasanWrapper tempSubAla = new ValueAlasanWrapper();
            tempSubAla.alasan = alasan;
            valueAlasan.add(tempSubAla);
            
            String alamatSebelumnya = getUpperParam('alamatSebelumnya');
            String alamatSebelumnyaTP = getUpperParam('alamatSebelumnyaTP');
            String alamatTerbaru = getUpperParam('alamatTerbaru');
            String alamatTerbaruTP = getUpperParam('alamatTerbaruTP');

            headerPerubahan = '';

            if(alamatTerbaru != '-' && alamatTerbaruTP != '-'){
                system.debug('masuk 1');
                centangAlamat = 'yes';
                doublePerubahan = new List<DoublePerubahanWrapper>();
                DoublePerubahanWrapper p = new DoublePerubahanWrapper();
                p.nama = 'Alamat Sebelumnya';
                p.val1 = alamatSebelumnya;
                p.val2 = alamatSebelumnyaTP;
                DoublePerubahanWrapper p2 = new DoublePerubahanWrapper();
                p2.nama = 'Alamat Terbaru';
                p2.val1 = alamatTerbaru;
                p2.val2 = alamatTerbaruTP;
                doublePerubahan.add(p);
                doublePerubahan.add(p2);
            }
            else if(alamatTerbaru != '-' && alamatTerbaruTP == '-'){
                system.debug('masuk 2');
                centangAlamat = 'yes';
                singlePerubahan = new List<SinglePerubahanWrapper>();
                headerSingle = 'Pemegang Polis';
                SinglePerubahanWrapper p = new SinglePerubahanWrapper();
                p.nama = 'Alamat Sebelumnya';
                p.val1 = alamatSebelumnya;
                SinglePerubahanWrapper p2 = new SinglePerubahanWrapper();
                p2.nama = 'Alamat Terbaru';
                p2.val1 = alamatTerbaru;
                singlePerubahan.add(p);
                singlePerubahan.add(p2);
            }
            else if(alamatTerbaru == '-' && alamatTerbaruTP != '-'){
                system.debug('masuk 3');
                centangAlamat = 'no';
                singlePerubahan = new List<SinglePerubahanWrapper>();
                headerSingle = 'Tertanggung/Peserta';
                SinglePerubahanWrapper p = new SinglePerubahanWrapper();
                p.nama = 'Alamat Sebelumnya';
                p.val1 = alamatSebelumnyaTP;
                SinglePerubahanWrapper p2 = new SinglePerubahanWrapper();
                p2.nama = 'Alamat Terbaru';
                p2.val1 = alamatTerbaruTP;
                singlePerubahan.add(p);
                singlePerubahan.add(p2);
            }
        }
        else if(formname.Contains('Perubahan Nomor Kontak')){
            
            subjectTransaction = getUpperParam('subjectTransaction');
            subjectTransactionTable = getUpperParam('subjectTransaction');
            subjectTransactionLower = getParam('subjectTransaction');
            subjectTransactionNumber = getParam('subjectTransactionNumber');

            subjectDesc = new List<ValueAlasanWrapper>();
            String subject = getParam('subjectTransactionNumber');
            ValueAlasanWrapper tempSub = new ValueAlasanWrapper();
            tempSub.alasan = subject;
            subjectDesc.add(tempSub);
            
            valueAlasan = new List<ValueAlasanWrapper>();
            ValueAlasanWrapper tempSubAla = new ValueAlasanWrapper();
            tempSubAla.alasan = alasan;
            valueAlasan.add(tempSubAla);

            String nomorRumahSebelumnya = getParam('nomorRumahSebelumnya');
            String nomorRumahSebelumnyaTP = getParam('nomorRumahSebelumnyaTP');
            String nomorKantorSebelumnya = getParam('nomorKantorSebelumnya');
            String nomorKantorSebelumnyaTP = getParam('nomorKantorSebelumnyaTP');
            String nomorSelulerSebelumnya = getParam('nomorSelulerSebelumnya');
            String nomorSelulerSebelumnyaTP = getParam('nomorSelulerSebelumnyaTP');
            String nomorRumahTerbaru = getParam('nomorRumahTerbaru');
            String nomorRumahTerbaruTP = getParam('nomorRumahTerbaruTP');
            String nomorKantorTerbaru = getParam('nomorKantorTerbaru');
            String nomorKantorTerbaruTP = getParam('nomorKantorTerbaruTP');
            String nomorSelulerTerbaru = getParam('nomorSelulerTerbaru');
            String nomorSelulerTerbaruTP = getParam('nomorSelulerTerbaruTP');
            headerPerubahan = '';
            jenisPilihan =  getParam('jenisPilihan');
            if(jenisPilihan=='PP'){
                
                singlePerubahan = new List<SinglePerubahanWrapper>();
                headerSingle = 'Pemegang Polis';
                SinglePerubahanWrapper p = new SinglePerubahanWrapper();
                p.nama = 'Telepon Rumah Sebelumnya';
                p.val1 = nomorRumahSebelumnya;
                SinglePerubahanWrapper p2 = new SinglePerubahanWrapper();
                p2.nama = 'Telepon Rumah Terbaru';
                p2.val1 = nomorRumahTerbaru;
                if(p2.val1 != '-'){
                    singlePerubahan.add(p);
                    singlePerubahan.add(p2);
                }
                SinglePerubahanWrapper p3 = new SinglePerubahanWrapper();
                p3.nama = 'Telepon Kantor Sebelumnya';
                p3.val1 = nomorKantorSebelumnya;
                SinglePerubahanWrapper p4 = new SinglePerubahanWrapper();
                p4.nama = 'Telepon Kantor Terbaru';
                p4.val1 = nomorKantorTerbaru;
                if(p4.val1 != '-'){
                    singlePerubahan.add(p3);
                    singlePerubahan.add(p4);
                }
                SinglePerubahanWrapper p5 = new SinglePerubahanWrapper();
                p5.nama = 'Telepon Seluler Sebelumnya';
                p5.val1 = nomorSelulerSebelumnya;
                SinglePerubahanWrapper p6 = new SinglePerubahanWrapper();
                p6.nama = 'Telepon Seluler Terbaru';
                p6.val1 = nomorSelulerTerbaru;
                if(p6.val1 != '-'){
                    centangTelepon = 'yes';
                    singlePerubahan.add(p5);
                    singlePerubahan.add(p6);
                }
            }else if(jenisPilihan == 'TP'){
                centangTelepon = 'no';
                singlePerubahan = new List<SinglePerubahanWrapper>();
                headerSingle = 'Tertanggung/Peserta';
                SinglePerubahanWrapper p = new SinglePerubahanWrapper();
                p.nama = 'Telepon Rumah Sebelumnya';
                p.val1 = nomorRumahSebelumnyaTP;
                SinglePerubahanWrapper p2 = new SinglePerubahanWrapper();
                p2.nama = 'Telepon Rumah Terbaru';
                p2.val1 = nomorRumahTerbaruTP;
                if(p2.val1 != '-'){
                    singlePerubahan.add(p);
                    singlePerubahan.add(p2);
                }
                SinglePerubahanWrapper p3 = new SinglePerubahanWrapper();
                p3.nama = 'Telepon Kantor Sebelumnya';
                p3.val1 = nomorKantorSebelumnyaTP;
                SinglePerubahanWrapper p4 = new SinglePerubahanWrapper();
                p4.nama = 'Telepon Kantor Terbaru';
                p4.val1 = nomorKantorTerbaruTP;
                if(p4.val1 != '-'){
                    singlePerubahan.add(p3);
                    singlePerubahan.add(p4);
                }
                SinglePerubahanWrapper p5 = new SinglePerubahanWrapper();
                p5.nama = 'Telepon Seluler Sebelumnya';
                p5.val1 = nomorSelulerSebelumnyaTP;
                SinglePerubahanWrapper p6 = new SinglePerubahanWrapper();
                p6.nama = 'Telepon Seluler Terbaru';
                p6.val1 = nomorSelulerTerbaruTP;
                if(p6.val1 != '-'){
                    singlePerubahan.add(p5);
                    singlePerubahan.add(p6);
                }
            }
            else if(jenisPilihan == 'PPTP'){
                
                doublePerubahan = new List<DoublePerubahanWrapper>();
                DoublePerubahanWrapper p = new DoublePerubahanWrapper();
                p.nama = 'Telepon Rumah Sebelumnya';
                p.val1 = nomorRumahSebelumnya;
                p.val2 = nomorRumahSebelumnyaTP;
                DoublePerubahanWrapper p2 = new DoublePerubahanWrapper();
                p2.nama = 'Telepon Rumah Terbaru';
                p2.val1 = nomorRumahTerbaru;
                p2.val2 = nomorRumahTerbaruTP;
                if(p2.val1 != '-' || p2.val2!= '-'){
                    doublePerubahan.add(p);
                    doublePerubahan.add(p2);
                }
                DoublePerubahanWrapper p3 = new DoublePerubahanWrapper();
                p3.nama = 'Telepon Kantor Sebelumnya';
                p3.val1 = nomorKantorSebelumnya;
                p3.val2 = nomorKantorSebelumnyaTP;
                DoublePerubahanWrapper p4 = new DoublePerubahanWrapper();
                p4.nama = 'Telepon Kantor Terbaru';
                p4.val1 = nomorKantorTerbaru;
                p4.val2 = nomorKantorTerbaruTP;
                if(p4.val1 != '-' || p4.val2 != '-'){
                    doublePerubahan.add(p3);
                    doublePerubahan.add(p4);
                }
                DoublePerubahanWrapper p5 = new DoublePerubahanWrapper();
                p5.nama = 'Telepon Seluler Sebelumnya';
                p5.val1 = nomorSelulerSebelumnya;
                p5.val2 = nomorSelulerSebelumnyaTP;
                DoublePerubahanWrapper p6 = new DoublePerubahanWrapper();
                p6.nama = 'Telepon Seluler Terbaru';
                p6.val1 = nomorSelulerTerbaru;
                p6.val2 = nomorSelulerTerbaruTP;
                if(p6.val1 != '-' || p6.val2 != '-'){
                    centangTelepon = 'yes';
                    doublePerubahan.add(p5);
                    doublePerubahan.add(p6);
                }
            }
        }
        else if(formname.Contains('Perubahan ID KTP')){
            
            subjectTransaction = getUpperParam('subjectTransaction');
            subjectTransactionTable = getUpperParam('subjectTransaction');
            subjectTransactionLower = getParam('subjectTransaction');
            subjectTransactionNumber = getParam('subjectTransactionNumber');

            subjectDesc = new List<ValueAlasanWrapper>();
            String subject = getParam('subjectTransactionNumber');
            ValueAlasanWrapper tempSub = new ValueAlasanWrapper();
            tempSub.alasan = subject;
            subjectDesc.add(tempSub);
            
            valueAlasan = new List<ValueAlasanWrapper>();
            ValueAlasanWrapper tempSubAla = new ValueAlasanWrapper();
            tempSubAla.alasan = alasan;
            valueAlasan.add(tempSubAla);
            
            String nomorKTPSebelumnya = getParam('nomorKTPSebelumnya');
            String nomorKTPSebelumnyaTP = getParam('nomorKTPSebelumnyaTP');
            String namaLengkapPP = getUpperParam('namaLengkapPP');
            String namaLengkapTP = getUpperParam('namaLengkapTP');
            String nomorKTPTerbaru = getParam('nomorKTPTerbaru');
            String nomorKTPTerbaruTP = getParam('nomorKTPTerbaruTP');

            headerPerubahan = '';

            if(nomorKTPTerbaru != '-' && nomorKTPTerbaruTP != '-'){
                system.debug('masuk 1');
                centangNIK = 'yes';
                doublePerubahan = new List<DoublePerubahanWrapper>();
                DoublePerubahanWrapper p = new DoublePerubahanWrapper();
                p.nama = 'Nama lengkap (Sesuai nama di kartu identitas)';
                p.val1 = namaLengkapPP;
                p.val2 = namaLengkapTP;
                DoublePerubahanWrapper p2 = new DoublePerubahanWrapper();
                p2.nama = 'Nomor KTP Sebelumnya';
                p2.val1 = nomorKTPSebelumnya;
                p2.val2 = nomorKTPSebelumnyaTP;
                DoublePerubahanWrapper p3 = new DoublePerubahanWrapper();
                p3.nama = 'Nomor KTP Terbaru';
                p3.val1 = nomorKTPTerbaru;
                p3.val2 = nomorKTPTerbaruTP;
                doublePerubahan.add(p);
                doublePerubahan.add(p2);
                doublePerubahan.add(p3);
            }
            else if(nomorKTPTerbaru != '-' && nomorKTPTerbaruTP == '-'){
                system.debug('masuk 2');
                centangNIK = 'yes';
                singlePerubahan = new List<SinglePerubahanWrapper>();
                headerSingle = 'Pemegang Polis';
                SinglePerubahanWrapper p = new SinglePerubahanWrapper();
                p.nama = 'Nama lengkap (Sesuai nama di kartu identitas)';
                p.val1 = namaLengkapPP;
                SinglePerubahanWrapper p2 = new SinglePerubahanWrapper();
                p2.nama = 'Nomor KTP Sebelumnya';
                p2.val1 = nomorKTPSebelumnya;
                SinglePerubahanWrapper p3 = new SinglePerubahanWrapper();
                p3.nama = 'Nomor KTP Terbaru';
                p3.val1 = nomorKTPTerbaru;
                singlePerubahan.add(p);
                singlePerubahan.add(p2);
                singlePerubahan.add(p3);
            }
            else if(nomorKTPTerbaru == '-' && nomorKTPTerbaruTP != '-'){
                system.debug('masuk 2');
                centangNIK = 'no';
                singlePerubahan = new List<SinglePerubahanWrapper>();
                headerSingle = 'Tertanggung/Peserta';
                SinglePerubahanWrapper p = new SinglePerubahanWrapper();
                p.nama = 'Nama lengkap (Sesuai nama di kartu identitas)';
                p.val1 = namaLengkapTP;
                SinglePerubahanWrapper p2 = new SinglePerubahanWrapper();
                p2.nama = 'Nomor KTP Sebelumnya';
                p2.val1 = nomorKTPSebelumnyaTP;
                SinglePerubahanWrapper p3 = new SinglePerubahanWrapper();
                p3.nama = 'Nomor KTP Terbaru';
                p3.val1 = nomorKTPTerbaruTP;
                singlePerubahan.add(p);
                singlePerubahan.add(p2);
                singlePerubahan.add(p3);
            }
        }
        else if(formname.Contains('Pengajuan Cuti Premi')){
            // Header
            subjectTransaction = getUpperParam('subjectTransaction');
            subjectTransactionTable = getUpperParam('subjectTransaction');
            subjectTransactionLower = getParam('subjectTransaction');
            subjectTransactionNumber = getParam('subjectTransactionNumber');
            subjectDescCuti = new List<ValueAlasanWrapper>();
            subjectAlasanCuti = new List<ValueAlasanWrapper>();

            // subjectDesc = new List<ValueAlasanWrapper>();
            // String subject = getParam('subjectTransactionNumber');
            // ValueAlasanWrapper tempSub = new ValueAlasanWrapper();
            // tempSub.alasan = subject;
            // subjectDesc.add(tempSub);
            
            valueAlasanCuti = new List<ValueAlasanWrapper>();
            ValueAlasanWrapper tempSubAla = new ValueAlasanWrapper();
            tempSubAla.alasan = alasan;
            valueAlasanCuti.add(tempSubAla);

            valueFooter = new List<ValueAlasanWrapper>();
            ValueAlasanWrapper tempFooter = new ValueAlasanWrapper();
            tempFooter.alasan = 'Dengan ini saya mengajukan cuti premi dan menyetujui syarat dan ketentuan cuti premi yang berlaku.';
            valueFooter.add(tempFooter);
        }
        else if(formname.Contains('Perubahan Termaslahat (Penerima Manfaat)')){
            
            subjectTransaction = getUpperParam('subjectTransaction');
            subjectTransactionTable = 'PERUBAHAN '+getUpperParam('subjectTransactionNumber');
            subjectTransactionLower = 'Perubahan '+getParam('subjectTransactionNumber');
            subjectTransactionNumber = getParam('subjectTransactionNumber');
            subjectDesc = new List<ValueAlasanWrapper>();
            valueAlasanAhli = new List<ValueAlasanWrapper>();
            String subject = getParam('subjectTransactionNumber');
            ValueAlasanWrapper tempSub = new ValueAlasanWrapper();
            tempSub.alasan = subject;
            subjectDesc.add(tempSub);

            ValueAlasanWrapper tempSubAla = new ValueAlasanWrapper();
            tempSubAla.alasan = alasan;
            valueAlasanAhli.add(tempSubAla);

            ahliWaris = new List<AhliWarisWrapper>();
            // String ketParam1 = ApexPages.currentPage().getParameters().get('dataAhliWaris1');
            String ketParam1 = getUpperParam('dataAhliWaris1');
            List<String> temp1 = new List<String>();
            if (ketParam1!=';//;;;;') {
                for (String d : ketParam1.split(';')) {
                    if (!String.isBlank(d)) {
                        temp1.add(d.trim());
                    }
                }
                ahliWaris.add(new AhliWarisWrapper(temp1[0],temp1[1],temp1[2],temp1[3],temp1[4],temp1[5]));
            }
            // String ketParam2 = ApexPages.currentPage().getParameters().get('dataAhliWaris2');
            String ketParam2 = getUpperParam('dataAhliWaris2');
            List<String> temp2 = new List<String>();
            if (ketParam2!=';//;;;;') {
                for (String d : ketParam2.split(';')) {
                    if (!String.isBlank(d)) {
                        temp2.add(d.trim());
                    }
                }
                ahliWaris.add(new AhliWarisWrapper(temp2[0],temp2[1],temp2[2],temp2[3],temp2[4],temp2[5]));
            }
            // String ketParam3 = ApexPages.currentPage().getParameters().get('dataAhliWaris3');
            String ketParam3 = getUpperParam('dataAhliWaris3');
            List<String> temp3 = new List<String>();
            if (ketParam3!=';//;;;;') {
                for (String d : ketParam3.split(';')) {
                    if (!String.isBlank(d)) {
                        temp3.add(d.trim());
                    }
                }
                ahliWaris.add(new AhliWarisWrapper(temp3[0],temp3[1],temp3[2],temp3[3],temp3[4],temp3[5]));
            }
            // String ketParam4 = ApexPages.currentPage().getParameters().get('dataAhliWaris4');
            String ketParam4 = getUpperParam('dataAhliWaris4');
            List<String> temp4 = new List<String>();
            if (ketParam4!=';//;;;;') {
                for (String d : ketParam4.split(';')) {
                    if (!String.isBlank(d)) {
                        temp4.add(d.trim());
                    }
                }
                ahliWaris.add(new AhliWarisWrapper(temp4[0],temp4[1],temp4[2],temp4[3],temp4[4],temp4[5]));
            }
            // String ketParam5 = ApexPages.currentPage().getParameters().get('dataAhliWaris5');
            String ketParam5 = getUpperParam('dataAhliWaris5');
            List<String> temp5 = new List<String>();
            if (ketParam5!=';//;;;;') {
                for (String d : ketParam5.split(';')) {
                    if (!String.isBlank(d)) {
                        temp5.add(d.trim());
                    }
                }
                ahliWaris.add(new AhliWarisWrapper(temp5[0],temp5[1],temp5[2],temp5[3],temp5[4],temp5[5]));
            }
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

    Public class DokumenTambahanWrapper {
        Public Integer numberAdd { get; set; }
        Public String namaDokumen { get; set; }

        Public DokumenTambahanWrapper(Integer numberAdd, String namaDokumen) {
            this.numberAdd = numberAdd;
            this.namaDokumen = namaDokumen;
        }
    }

    Public class AhliWarisWrapper {
        Public String nama { get; set; }
        Public String tanggal { get; set; }
        Public String jenisKel { get; set; }
        Public String nomorIdentitas { get; set; }
        Public String persentase { get; set; }
        Public String hubungan { get; set; }
        Public AhliWarisWrapper(String nama,String tanggal,String jenisKel,String nomorIdentitas,String persentase,String hubungan) {
            this.nama = nama;
            this.tanggal = tanggal;
            this.jenisKel = jenisKel;
            this.nomorIdentitas = nomorIdentitas;
            this.persentase = persentase;
            this.hubungan = hubungan;
        }
    }

    // Public class AlamatWrapper {
    //     Public String nama { get; set; }
    //     Public String val1 { get; set; }
    //     Public String val2 { get; set; }
    // }

    // Public class PerubahanWrapper {
    //     Public String header { get; set; }
    //     Public List<DetailPerubahanWrapper> details { get; set; }
    // }

    // Public class DetailPerubahanWrapper {
    //     Public String namePerubahan { get; set; }
    //     Public String valuePerubahan { get; set; }
    // }

    Public class ValueAlasanWrapper {
        Public String alasan { get; set; }
    }

    Public class DoublePerubahanWrapper {
        Public String nama { get; set; }
        Public String val1 { get; set; }
        Public String val2 { get; set; }
    }
    Public class SinglePerubahanWrapper {
        Public String nama { get; set; }
        Public String val1 { get; set; }
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
        prop.put('EFORM Alamat', getSafeString(eForm.Alamat__c));
        prop.put('EFORM Email', getSafeString(eForm.Email__c));
        prop.put('EFORM Nama Produk', getSafeString(eForm.Nama_Produk__c));
        if(eForm.Name.Contains('Perubahan Alamat Email')){
            prop.put('EFORM Email PP Sebelumnya', getSafeString(eForm.Email__c));
            prop.put('EFORM Email TP Sebelumnya', getSafeString(eForm.Email_Sebelumnya_TP__c));
            prop.put('EFORM Email PP Terbaru', getSafeString(eForm.Email_Terbaru__c));
            prop.put('EFORM Email TP Terbaru', getSafeString(eForm.Email_Terbaru_TP__c));
            prop.put('EFORM Alasan', getSafeString(eForm.Alasan__c));
        }
        else if(eForm.Name.Contains('Perubahan Alamat Koresponden')){
            prop.put('EFORM Alamat PP Sebelumnya', getSafeString(eForm.Alamat__c));
            prop.put('EFORM Alamat TP Sebelumnya', getSafeString(eForm.Alamat_Domisili_Controlling_Person__c));
            prop.put('EFORM Alamat PP Terbaru', getSafeString(eForm.Alamat_Terbaru__c));
            prop.put('EFORM Alamat TP Terbaru', getSafeString(eForm.Alamat_Terbaru_TP__c));
            prop.put('EFORM Alasan', getSafeString(eForm.Alasan__c));
        }
        else if(eForm.Name.Contains('Perubahan Nomor Kontak')){
            prop.put('EFORM Nomor Telepon Seluler PP Sebelumnya', getSafeString(eForm.Nomor_Telpon__c));
            prop.put('EFORM Nomor Telepon Seluler TP Sebelumnya', getSafeString(eForm.Nomor_Identitas_Controlling_Person__c));
            prop.put('EFORM Nomor Telepon Kantor PP Sebelumnya', getSafeString(eForm.NPWP1__c));
            prop.put('EFORM Nomor Telepon Kantor TP Sebelumnya', getSafeString(eForm.NPWP_CP_2__c));
            prop.put('EFORM Nomor Telepon Rumah PP Sebelumnya', getSafeString(eForm.NPWP__c));
            prop.put('EFORM Nomor Telepon Rumah TP Sebelumnya', getSafeString(eForm.NPWP_CP_1__c));
            prop.put('EFORM Nomor Telepon Seluler PP Terbaru', getSafeString(eForm.Telepon_Seluler_Terbaru__c));
            prop.put('EFORM Nomor Telepon Seluler TP Terbaru', getSafeString(eForm.Telepon_Seluler_Terbaru_TP__c));
            prop.put('EFORM Nomor Telepon Kantor PP Terbaru', getSafeString(eForm.Telepon_Kantor_Terbaru__c));
            prop.put('EFORM Nomor Telepon Kantor TP Terbaru', getSafeString(eForm.Telepon_Kantor_Terbaru_TP__c));
            prop.put('EFORM Nomor Telepon Rumah PP Terbaru', getSafeString(eForm.Telepon_Rumah_Terbaru__c));
            prop.put('EFORM Nomor Telepon Rumah TP Terbaru', getSafeString(eForm.Telepon_Rumah_Terbaru_TP__c));
            prop.put('EFORM Alasan', getSafeString(eForm.Alasan__c));
        }
        else if(eForm.Name.Contains('Perubahan ID KTP')){
            prop.put('EFORM Nama Lengkap PP', getSafeString(eForm.Nama_Lengkap__c));
            prop.put('EFORM Name Lengkap TP', getSafeString(eForm.Nama_Tertanggung__c));
            prop.put('EFORM Nomor KTP PP Sebelumnya', getSafeString(eForm.Nomor_Kartu_Identitas__c));
            prop.put('EFORM Nomor KTP TP Sebelumnya', getSafeString(eForm.Nomor_Identitas_Controlling_Person__c));
            prop.put('EFORM Nomor KTP PP Terbaru', getSafeString(eForm.Nomor_KTP_Terbaru__c));
            prop.put('EFORM Nomor KTP TP Terbaru', getSafeString(eForm.Nomor_KTP_Terbaru_TP__c));
            prop.put('EFORM Alasan', getSafeString(eForm.Alasan__c));
        }
        else if(eForm.Name.Contains('Pengajuan Cuti Premi')){
            prop.put('EFORM Alasan', getSafeString(eForm.Alasan__c));
        }
        else if(eForm.Name.Contains('Perubahan Termaslahat (Penerima Manfaat)')){
            String pM1 = eForm.Penerima_Manfaat_1__c != ';//;;;;' ? getSafeString(eForm.Penerima_Manfaat_1__c) : ' ';
            String pM2 = eForm.Penerima_Manfaat_2__c != ';//;;;;' ? getSafeString(eForm.Penerima_Manfaat_2__c) : ' ';
            String pM3 = eForm.Penerima_Manfaat_3__c != ';//;;;;' ? getSafeString(eForm.Penerima_Manfaat_3__c) : ' ';
            String pM4 = eForm.Penerima_Manfaat_4__c != ';//;;;;' ? getSafeString(eForm.Penerima_Manfaat_4__c) : ' ';
            String pM5 = eForm.Penerima_Manfaat_5__c != ';//;;;;' ? getSafeString(eForm.Penerima_Manfaat_5__c) : ' ';
            
            prop.put('EFORM Penerima Manfaat 1', getSafeString(pM1));
            prop.put('EFORM Penerima Manfaat 2', getSafeString(pM2));
            prop.put('EFORM Penerima Manfaat 3', getSafeString(pM3));
            prop.put('EFORM Penerima Manfaat 4', getSafeString(pM4));
            prop.put('EFORM Penerima Manfaat 5', getSafeString(pM5));
            prop.put('EFORM Alasan', getSafeString(eForm.Alasan__c));
        }


        String jsonBody = JSON.serialize(prop);
        E_Form_Master_Data__c updateEform = new E_Form_Master_Data__c();
        updateEform.Id = eform.Id;
        updateEform.Metadata__c = jsonBody;
        update updateEform;
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
    private static String getSafeString(String paramName) {
        if (String.isBlank(paramName) || paramName == '-') {
            return ' ';
        }
        return String.valueOf(paramName);
    }
    
}