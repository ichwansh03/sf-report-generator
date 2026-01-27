/**
 * @description       : 
 * @author            : Mario Carlos Eyo
 * @group             : 
 * @last modified on  : 15-10-2025
 * @last modified by  : Mario Carlos Eyo
**/
global without Sharing class AMFS_GeneratePDF {

    global static PageReference pdfPage;
    
    @InvocableMethod(label='Generate PDF' )
    global static void AMFS_GeneratePDF(List<E_Form_Master_Data__c> eform) {
        List<Log_Book_Activitiy_Detail__c> detail = [SELECT ID, Contact_Policy__c, Department__c, Email_PP__c,Phone_PP__c, Policy_Number__c, Policy_Name_Holder__c, Log_Book_Activitiy__r.Log_Book_Date__c,
                                                    Log_Case__r.CaseNumber, Sign_ID__c, Dokumen_Tambahan__c, Document_Information__c, Log_Book_Activitiy__r.Touch_Point_City__c, Kind_Of_Transaction__c,
                                                    CreatedBy.FirstName, CreatedBy.Lastname, Is_Policy_Holder__c, Form_Tambahan__c, Segmentation__c, form_utama__C
                                                    FROM Log_Book_Activitiy_Detail__c where id =: eform[0].Log_Book_Activitiy_Detail__c];
        List<Contact> cont = [SELECT Id, Name, MobilePhone, Email,Insured_Name__c FROM Contact WHERE Id =: detail[0].Contact_Policy__c];
        
        // --- Keterangan Tambahan ---
        // List<Log_Book_Activitiy_Detail__c> keteranganTambahan = [
        //     SELECT id,Kind_Of_Transaction__c,Department__c,Policy_Number__c from Log_Book_Activitiy_Detail__c 
        //     Where Log_Book_Activitiy__c = :detail[0].Log_Book_Activitiy__c AND Id != :detail[0].Id 
        //     AND Department__c = :detail[0].Department__c AND Policy_Number__c = :detail[0].Policy_Number__c
        // ];
        // system.debug('FORM Check KeteranganTambahan: ' + keteranganTambahan);
        
        String formName = eform[0].Name;
        //PageReference pdfPage;
        system.debug('FORM NAME: ' + formName);
        if(formName.contains('Lumpsum')){
            pdfPage = Page.VF_SingleTopUp;
            AMFS_SingleTopUp_Controller.generateMetadata(eform[0]);
        }else if(formName.contains('Switching') || formName.contains('Redirection')){
            pdfPage = Page.VF_SwitchingRedirection;
            AMFS_SingleTopUp_Controller.generateMetadata(eform[0]);
        }else if(formname.contains('Withdrawal')){ //WITHDRAWAL
            pdfPage = Page.VF_Pengajuan_Penarikan_Dana;
            AMFS_PengajuanPenarikanDana_Controller.generateMetadata(eform[0]);
        }else if(formname.contains('Badan Usaha')){ //Badan Usaha
            pdfPage = Page.VF_Form_CRS_Deklarasi_BU;
            AMFS_CRS_Controller.generateMetadata(eform[0]);
        }else if(formname.contains('Individu')){ //Individu
            pdfPage = Page.VF_Form_CRS_Deklarasi_Individu;
            AMFS_CRS_Controller.generateMetadata(eform[0]);
        }else if(formname.Contains('Keberatan')){ //Keberatan
            pdfPage = Page.VF_Form_CRS_Keberatan;
            AMFS_CRS_Controller.generateMetadata(eform[0]);
        }else if(formname.Contains('Redemption') || formname.Contains('Cooling')){ 
            pdfPage = Page.VF_PembatalanPolisPembelajaranPolis;
            AMFS_PengajuanPenarikanDana_Controller.generateMetadata(eform[0]);
        }else if(formname.Contains('Perubahan Alamat Email') 
                || formname.Contains('Perubahan Nomor Kontak')
                || formname.Contains('Perubahan Alamat Koresponden')
                || formname.Contains('Perubahan ID KTP')
                || formname.Contains('Pengajuan Cuti Premi')
                || formname.Contains('Perubahan Termaslahat (Penerima Manfaat)')){ 
            pdfPage = Page.VF_PerubahanDataPolisNew;
            AMFS_PerubahanDataPolis_Controller.generateMetadata(eform[0]);
        } else if(formName.contains('Pemulihan Polis')){ 
                String jenisPengkinian = eform[0].Pengkinian_Data__c;
                if(jenisPengkinian == 'PPTP') {
                    pdfPage = Page.VF_PemulihanPolis_PPTP;
                } else {
                    pdfPage = Page.VF_PemulihanPolis; // Pemulihan  Polis
                }
            
                AMFS_PemulihanPolis_Controller.generateMetadata(eform[0]);

        }  else if(formName.contains('FP5')){ 
            pdfPage = Page.VF_Form_FP5;
            AMFS_FP5_Controller.generateMetadata(eform[0]);
        }
        pdfPage.getParameters().put('Id', eform[0].Id);
        pdfPage.getParameters().put('polisNo', detail[0].Policy_Number__c);
        String phName = eform[0].Nama_Pemilik_Polis__c!=null ? eform[0].Nama_Pemilik_Polis__c : cont[0].Name;
        pdfPage.getParameters().put('phName', phName);
        String phone = eform[0].Nomor_Telpon__c!=null ? eform[0].Nomor_Telpon__c : cont[0].MobilePhone;
        pdfPage.getParameters().put('phone', phone);
        pdfPage.getParameters().put('addr', eform[0].alamat__c);
        String email = eform[0].Email__c!=null ? eform[0].Email__c : cont[0].email;
        pdfPage.getParameters().put('email', email);
        pdfPage.getParameters().put('pajak', eform[0].informasi_pajak_luar_negeri__c);

        Integer hourOffset = Integer.valueOf(Label.AMFS_Add_Hour);
        Datetime eFormDt;
        if(UserInfo.getUserType() == 'Guest'){
            eFormDt = system.now().addHours(hourOffset);
        }else {
            eFormDt = system.now().addHours(0);
        }
        String inputdt = eFormDt.format('dd/MM/yyyy, HH:mm');
        String inputdtmmss = eFormDt.format('dd/MM/yyyy, HH:mm:ss');
        String inputDate = eFormDt.format('dd/MM/yyyy');

        pdfPage.getParameters().put('inputdt', inputdt);
        pdfPage.getParameters().put('inputDate', inputDate);
        pdfPage.getParameters().put('inputdtmmss', inputdtmmss);
        pdfPage.getParameters().put('transNo', detail[0].Log_Case__r.CaseNumber);
        pdfPage.getParameters().put('prodName', eform[0].Nama_Produk__c);
        pdfPage.getParameters().put('paymentMethod', eform[0].Payment_Method__c);
        pdfPage.getParameters().put('sign', eform[0].Sign_ID__c);
        String signTP = eform[0].Sign_ID_TP__c != null ? eform[0].Sign_ID_TP__c  : '';
        pdfPage.getParameters().put('signTP', signTP);
        System.debug('####AMFS signTP >> '+signTP);
        pdfPage.getParameters().put('dokumenTambahanList', detail[0].Dokumen_Tambahan__c);
        pdfPage.getParameters().put('touchPoint', detail[0].Log_Book_Activitiy__r.Touch_Point_City__c);
        String firstName = detail[0].CreatedBy.FirstName != NULL ? detail[0].CreatedBy.FirstName  : '';
        String lastName = detail[0].CreatedBy.LastName != NULL ? detail[0].CreatedBy.LastName  : '';
        String csName = firstName + lastName;
        pdfPage.getParameters().put('csName', csName);


        String listTransactions = getKeteranganTambahanAsString(detail[0]) != '' ? getKeteranganTambahanAsString(detail[0]) : '-';
        pdfPage.getParameters().put('listTransactions', listTransactions);
        if(detail[0].Segmentation__c == 'Reguler' || detail[0].Segmentation__c == 'Corporate'){
                pdfPage.getParameters().put('segmentation', 'Non PBC');
        }else{
            pdfPage.getParameters().put('segmentation', 'PBC');
        }

        pdfPage.getParameters().put('department', detail[0].Department__c);

        

        

        String subject;
        //PAYDI
        if(formName.contains('Lumpsum') || formName.contains('Switching') || formName.contains('Redirection')){
           
            if(detail[0].Kind_Of_Transaction__c == 'Request_POS Lumpsum' ||detail[0].form_utama__C == 'Request_POS Lumpsum'){
                subject = 'Top Up - ' + detail[0].Log_Case__r.CaseNumber;
            } else if(detail[0].Kind_Of_Transaction__c == 'Request_POS_Pengalihan Dana (Switching)' ||detail[0].form_utama__C == 'Request_POS_Pengalihan Dana (Switching)'){
               subject = 'Switching - ' + detail[0].Log_Case__r.CaseNumber;
            } else if(detail[0].Kind_Of_Transaction__c == 'Request_POS_Perubahan Alokasi Dana (Redirection)' ||detail[0].form_utama__C == 'Request_POS_Perubahan Alokasi Dana (Redirection)'){
                subject = 'Redirection - ' + detail[0].Log_Case__r.CaseNumber;
            } else if (detail[0].Kind_Of_Transaction__c == 'Request_POS_Switching & Redirection' ||detail[0].form_utama__C == 'Request_POS_Switching & Redirection'){
                subject = 'Switching & Redirection - ' + detail[0].Log_Case__r.CaseNumber;
            }
            pdfPage.getParameters().put('subject', subject);

            if(eform[0].nominal__c != NULL)pdfPage.getParameters().put('nominal', String.valueof(eform[0].nominal__c.format()));

            if(eform[0].tujuan__c == 'Lainnya'){
                String tujuan = eform[0].tujuan__c + ', '+ eform[0].tujuan_lainnya__c;
                pdfPage.getParameters().put('tujuan', tujuan);
            }
            else{
                pdfPage.getParameters().put('tujuan', eform[0].tujuan__c);
            }

            if(eform[0].sumberdana__c == 'Lainnya'){
                String sumberDana = eform[0].sumberdana__c + ', '+ eform[0].Sumber_Dana_Lainnya__c;
                pdfPage.getParameters().put('sumberDana', sumberDana);
            }
            else{
            pdfPage.getParameters().put('sumberDana', eform[0].sumberdana__c);
            }

            if(eform[0].Currency__c != NULL)pdfPage.getParameters().put('currency', eform[0].Currency__c);

            if(eform[0].Top_Up_Currency__c != NULL)pdfPage.getParameters().put('currencyPendapatan', eform[0].Top_Up_Currency__c);
            if(eform[0].Pendapatan__c != NULL)pdfPage.getParameters().put('penghasilan', eform[0].Pendapatan__c.format());

            pdfPage.getParameters().put('pekerjaan', eform[0].pekerjaan__c);
            pdfPage.getParameters().put('caseType', eform[0].case_type__c);
            
            if(formName.contains('Switching') || formName.contains('Redirection')){
                system.debug('SUBDANA: ' + eform[0].Subdana_Tambahan_1__c);
                system.debug('SUBDANA: ' + eform[0].Subdana_Tambahan_2__c);
                system.debug('SUBDANA: ' + eform[0].Subdana_Tambahan_3__c);
                system.debug('SUBDANA: ' + eform[0].Subdana_Tambahan_4__c);
                
                if(eform[0].Subdana_Tambahan_1__c != NULL || eform[0].Subdana_Tambahan_2__c != NULL || eform[0].Subdana_Tambahan_3__c != NULL ||eform[0].Subdana_Tambahan_4__c != NULL){
                    pdfPage.getParameters().put('codeOld1', '-');
                    if(eform[0].code_subdana_1__c != NULL){
                        pdfPage.getParameters().put('codeOld1', eform[0].code_subdana_1__c);
                    }
                    pdfPage.getParameters().put('subdanaOld1', '-');
                    if(eform[0].nama_subdana_1__c != NULL){
                        pdfPage.getParameters().put('subdanaOld1', eform[0].nama_subdana_1__c);
                    }
                    pdfPage.getParameters().put('percentageOld1', '-');
                    if(eform[0].persentase_1__c > 0)pdfPage.getParameters().put('percentageOld1', String.valueOf(eform[0].persentase_1__c.setScale(0)) + '%');

                    pdfPage.getParameters().put('codeOld2', eform[0].code_subdana_2__c);
                    pdfPage.getParameters().put('subdanaOld2', eform[0].nama_subdana_2__c);
                    pdfPage.getParameters().put('percentageOld2', '-');
                    if(eform[0].persentase_2__c > 0)pdfPage.getParameters().put('percentageOld2', String.valueOf(eform[0].persentase_2__c.setScale(0)) + '%');

                    pdfPage.getParameters().put('codeOld3', eform[0].code_subdana_3__c);
                    pdfPage.getParameters().put('subdanaOld3', eform[0].nama_subdana_3__c);
                    pdfPage.getParameters().put('percentageOld3', '-');
                    if(eform[0].persentase_3__c > 0)pdfPage.getParameters().put('percentageOld3', String.valueOf(eform[0].persentase_3__c.setScale(0)) + '%');

                    pdfPage.getParameters().put('codeOld4', eform[0].code_subdana_4__c);
                    pdfPage.getParameters().put('subdanaOld4', eform[0].nama_subdana_4__c);
                    
                    pdfPage.getParameters().put('percentageOld4', '-');
                    if(eform[0].persentase_4__c > 0)pdfPage.getParameters().put('percentageOld4', String.valueOf(eform[0].persentase_4__c.setScale(0)) + '%');

                    pdfPage.getParameters().put('code1','-');
                    pdfPage.getParameters().put('subdana1', '-');
                    pdfPage.getParameters().put('percentage1', '-');
                    if(eform[0].Subdana_Tambahan_1__c != NULL){
                        Master_Fund_Code__c mfc1 = [SELECT Id, Name, Desc_Fun_Code__c, Name_Code__c FROM Master_Fund_Code__c WHERE Name_Code__c =: eform[0].Subdana_Tambahan_1__c AND Plan_Code__c =: eform[0].Plan_Code__c];
                        pdfPage.getParameters().put('code1',mfc1.Name);
                        pdfPage.getParameters().put('subdana1', mfc1.Desc_Fun_Code__c);
                        if(eform[0].Persentase_Tambahan_1__c > 0)pdfPage.getParameters().put('percentage1', String.valueOf(eform[0].Persentase_Tambahan_1__c.setScale(0)) + '%');
                        
                    }
                    pdfPage.getParameters().put('code2','-');
                    pdfPage.getParameters().put('subdana2', '-');
                    pdfPage.getParameters().put('percentage2', '-');
                    if(eform[0].Subdana_Tambahan_2__c != NULL){
                        Master_Fund_Code__c mfc2 = [SELECT Id, Name, Desc_Fun_Code__c, Name_Code__c FROM Master_Fund_Code__c WHERE Name_Code__c =: eform[0].Subdana_Tambahan_2__c AND Plan_Code__c =: eform[0].Plan_Code__c];
                        pdfPage.getParameters().put('code2',mfc2.Name);
                        pdfPage.getParameters().put('subdana2', mfc2.Desc_Fun_Code__c);
                        if(eform[0].Persentase_Tambahan_2__c > 0)pdfPage.getParameters().put('percentage2', String.valueOf(eform[0].Persentase_Tambahan_2__c.setScale(0)) + '%');
                    }
                    pdfPage.getParameters().put('code3','-');
                    pdfPage.getParameters().put('subdana3', '-');
                    pdfPage.getParameters().put('percentage3', '-');
                    if(eform[0].Subdana_Tambahan_3__c != NULL){
                        Master_Fund_Code__c mfc3 = [SELECT Id, Name, Desc_Fun_Code__c, Name_Code__c FROM Master_Fund_Code__c WHERE Name_Code__c =: eform[0].Subdana_Tambahan_3__c AND Plan_Code__c =: eform[0].Plan_Code__c];
                        pdfPage.getParameters().put('code3',mfc3.Name);
                        pdfPage.getParameters().put('subdana3', mfc3.Desc_Fun_Code__c);
                        if(eform[0].Persentase_Tambahan_3__c > 0)pdfPage.getParameters().put('percentage3', String.valueOf(eform[0].Persentase_Tambahan_3__c.setScale(0)) + '%');
                    } 
                    pdfPage.getParameters().put('code4','-');
                    pdfPage.getParameters().put('subdana4', '-');
                    pdfPage.getParameters().put('percentage4', '-');
                    if(eform[0].Subdana_Tambahan_4__c != NULL){
                        Master_Fund_Code__c mfc4 = [SELECT Id, Name, Desc_Fun_Code__c, Name_Code__c FROM Master_Fund_Code__c WHERE Name_Code__c =: eform[0].Subdana_Tambahan_4__c AND Plan_Code__c =: eform[0].Plan_Code__c];
                        pdfPage.getParameters().put('code4',mfc4.Name);
                        pdfPage.getParameters().put('subdana4', mfc4.Desc_Fun_Code__c);
                        if(eform[0].Persentase_Tambahan_4__c > 0)pdfPage.getParameters().put('percentage4', String.valueOf(eform[0].Persentase_Tambahan_4__c.setScale(0)) + '%');
                    } 
                }
                else {
                    pdfPage.getParameters().put('codeOld1', eform[0].code_subdana_1__c);
                    pdfPage.getParameters().put('subdanaOld1', eform[0].nama_subdana_1__c);
                    
                    pdfPage.getParameters().put('percentageOld1', '-');
                    if(eform[0].persentase_1__c > 0)pdfPage.getParameters().put('percentageOld1', String.valueOf(eform[0].persentase_1__c.setScale(0)) + '%');


                    pdfPage.getParameters().put('code1','-');
                    pdfPage.getParameters().put('subdana1', '-');
                    pdfPage.getParameters().put('percentage1', '-');
    
                    pdfPage.getParameters().put('codeOld2', eform[0].code_subdana_2__c);
                    pdfPage.getParameters().put('subdanaOld2', eform[0].nama_subdana_2__c);
                    
                    pdfPage.getParameters().put('percentageOld2', '-');
                    if(eform[0].persentase_2__c > 0)pdfPage.getParameters().put('percentageOld2', String.valueOf(eform[0].persentase_2__c.setScale(0)) + '%');
                    pdfPage.getParameters().put('code2','-');
                    pdfPage.getParameters().put('subdana2', '-');
                    pdfPage.getParameters().put('percentage2', '-');
    
                    pdfPage.getParameters().put('codeOld3', eform[0].code_subdana_3__c);
                    pdfPage.getParameters().put('subdanaOld3', eform[0].nama_subdana_3__c);
                    pdfPage.getParameters().put('percentageOld3', '-');
                    if(eform[0].persentase_3__c > 0)pdfPage.getParameters().put('percentageOld3', String.valueOf(eform[0].persentase_3__c.setScale(0)) + '%');

                    pdfPage.getParameters().put('code3','-');
                    pdfPage.getParameters().put('subdana3', '-');
                    pdfPage.getParameters().put('percentage3', '-');
    
                    pdfPage.getParameters().put('codeOld4', eform[0].code_subdana_4__c);
                    pdfPage.getParameters().put('subdanaOld4', eform[0].nama_subdana_4__c);
                    pdfPage.getParameters().put('percentageOld4', '-');
                    if(eform[0].persentase_4__c > 0)pdfPage.getParameters().put('percentageOld4', String.valueOf(eform[0].persentase_4__c.setScale(0)) + '%');
                     
                    pdfPage.getParameters().put('code4','-');
                    pdfPage.getParameters().put('subdana4', '-');
                    pdfPage.getParameters().put('percentage4', '-');
                }
            }
            else {
                if(eform[0].Subdana_Tambahan_1__c != NULL || eform[0].Subdana_Tambahan_2__c != NULL || eform[0].Subdana_Tambahan_3__c != NULL ||eform[0].Subdana_Tambahan_4__c != NULL){
                    pdfPage.getParameters().put('code1','-');
                    pdfPage.getParameters().put('subdana1', '-');
                    pdfPage.getParameters().put('percentage1', '-');
                    if(eform[0].Subdana_Tambahan_1__c != NULL){
                        Master_Fund_Code__c mfc1 = [SELECT Id, Name, Desc_Fun_Code__c, Name_Code__c FROM Master_Fund_Code__c WHERE Name_Code__c =: eform[0].Subdana_Tambahan_1__c AND Plan_Code__c =: eform[0].Plan_Code__c];
                        pdfPage.getParameters().put('code1',mfc1.Name);
                        pdfPage.getParameters().put('subdana1', mfc1.Desc_Fun_Code__c);
                        if(eform[0].Persentase_Tambahan_1__c > 0)pdfPage.getParameters().put('percentage1', String.valueOf(eform[0].Persentase_Tambahan_1__c.setScale(0)) + '%');
                    }
                    pdfPage.getParameters().put('code2','-');
                    pdfPage.getParameters().put('subdana2', '-');
                    pdfPage.getParameters().put('percentage2', '-');
                    if(eform[0].Subdana_Tambahan_2__c != NULL){
                        Master_Fund_Code__c mfc2 = [SELECT Id, Name, Desc_Fun_Code__c, Name_Code__c FROM Master_Fund_Code__c WHERE Name_Code__c =: eform[0].Subdana_Tambahan_2__c AND Plan_Code__c =: eform[0].Plan_Code__c];
                        pdfPage.getParameters().put('code2',mfc2.Name);
                        pdfPage.getParameters().put('subdana2', mfc2.Desc_Fun_Code__c);
                        if(eform[0].Persentase_Tambahan_2__c > 0)pdfPage.getParameters().put('percentage2', String.valueOf(eform[0].Persentase_Tambahan_2__c.setScale(0)) + '%');
                    }
                    pdfPage.getParameters().put('code3','-');
                    pdfPage.getParameters().put('subdana3', '-');
                    pdfPage.getParameters().put('percentage3', '-');
                    if(eform[0].Subdana_Tambahan_3__c != NULL){
                        Master_Fund_Code__c mfc3 = [SELECT Id, Name, Desc_Fun_Code__c, Name_Code__c FROM Master_Fund_Code__c WHERE Name_Code__c =: eform[0].Subdana_Tambahan_3__c AND Plan_Code__c =: eform[0].Plan_Code__c];
                        pdfPage.getParameters().put('code3',mfc3.Name);
                        pdfPage.getParameters().put('subdana3', mfc3.Desc_Fun_Code__c);
                        if(eform[0].Persentase_Tambahan_3__c > 0)pdfPage.getParameters().put('percentage3', String.valueOf(eform[0].Persentase_Tambahan_3__c.setScale(0)) + '%');
                    }
                    pdfPage.getParameters().put('code4','-');
                    pdfPage.getParameters().put('subdana4', '-');
                    pdfPage.getParameters().put('percentage4', '-');
                    if(eform[0].Subdana_Tambahan_4__c != NULL){
                        Master_Fund_Code__c mfc4 = [SELECT Id, Name, Desc_Fun_Code__c, Name_Code__c FROM Master_Fund_Code__c WHERE Name_Code__c =: eform[0].Subdana_Tambahan_4__c AND Plan_Code__c =: eform[0].Plan_Code__c];
                        pdfPage.getParameters().put('code4',mfc4.Name);
                        pdfPage.getParameters().put('subdana4', mfc4.Desc_Fun_Code__c);
                        if(eform[0].Persentase_Tambahan_4__c > 0)pdfPage.getParameters().put('percentage4', String.valueOf(eform[0].Persentase_Tambahan_4__c.setScale(0)) + '%');
                    }

                }else {
                    pdfPage.getParameters().put('code1', eform[0].code_subdana_1__c);
                    pdfPage.getParameters().put('subdana1', eform[0].nama_subdana_1__c);
                    if(eform[0].persentase_1__c > 0)pdfPage.getParameters().put('percentage1', String.valueOf(eform[0].persentase_1__c.setScale(0)) + '%');
                    pdfPage.getParameters().put('code2', eform[0].code_subdana_2__c);
                    pdfPage.getParameters().put('subdana2', eform[0].nama_subdana_2__c);
                    if(eform[0].persentase_2__c > 0)pdfPage.getParameters().put('percentage2', String.valueOf(eform[0].persentase_2__c.setScale(0)) + '%');
                    pdfPage.getParameters().put('code3', eform[0].code_subdana_3__c);
                    pdfPage.getParameters().put('subdana3', eform[0].nama_subdana_3__c);
                    if(eform[0].persentase_3__c > 0)pdfPage.getParameters().put('percentage3', String.valueOf(eform[0].persentase_3__c.setScale(0)) + '%');
                    pdfPage.getParameters().put('code4', eform[0].code_subdana_4__c);
                    pdfPage.getParameters().put('subdana4', eform[0].nama_subdana_4__c);
                    if(eform[0].persentase_4__c > 0)pdfPage.getParameters().put('percentage4', String.valueOf(eform[0].persentase_4__c.setScale(0)) + '%');
                }
            }
        }
        else if(formname.contains('Withdrawal') || formname.Contains('Redemption') || formname.Contains('Cooling')){ 
            if(formname.contains('Withdrawal')){
                if(eform[0].Jumlah_Penarikan_Dana__c >= Integer.valueof(label.AMFS_Batas_Penentuan_Transaksi)){
                subject = 'Withdrawal Big Amount - ' + detail[0].Log_Case__r.CaseNumber;
                }else{
                    subject = 'Withdrawal - ' + detail[0].Log_Case__r.CaseNumber;
                }
            }else if(formName.contains('Cooling')){
                subject = 'FORMULIR PEMBATALAN POLIS PADA MASA PEMBELAJARAN POLIS (COOLING OFF)';
                pdfPage.getParameters().put('type', 'COOLING');  
            }else if(formName.contains('Redemption')){
                subject = 'PENUTUPAN POLIS (SURRENDER)';
                pdfPage.getParameters().put('type', 'REDEMPTION');  
            }
            
            pdfPage.getParameters().put('subject',subject);
            
            String alasanCustom;
            if(eform[0].Alasan_Lainnya__c!=null){
                alasanCustom = eform[0].Alasan_Penarikan_Dana__c+ ' : '+ eform[0].Alasan_Lainnya__c;
            }
            else {
                alasanCustom = eform[0].Alasan_Penarikan_Dana__c;
            }
            pdfPage.getParameters().put('alasan', alasanCustom);
            if(eform[0].Nilai_Tunai_Sementara__c > 0)pdfPage.getParameters().put('awal', String.valueOf(eform[0].Nilai_Tunai_Sementara__c.format()));
            if(eform[0].Jumlah_Penarikan_Dana__c > 0)pdfPage.getParameters().put('jumlah', String.valueOf(eform[0].Jumlah_Penarikan_Dana__c.format()));
            if(eform[0].Jumlah_Setelah_Biaya_Transaksi__c > 0)pdfPage.getParameters().put('setelah', String.valueOf(eform[0].Jumlah_Setelah_Biaya_Transaksi__c.format()));
            if(eform[0].Sisa_Dana__c > 0)pdfPage.getParameters().put('sisa', String.valueOf(eform[0].Sisa_Dana__c.format()));
            if(eform[0].Biaya_Transaksi__c >= 0)pdfPage.getParameters().put('biaya', String.valueOf(eform[0].Biaya_Transaksi__c.format()));

            // pdfPage.getParameters().put('sisa', String.valueof(eform[0].Sisa_Dana__c));

            pdfPage.getParameters().put('tertanggung', String.valueof(eform[0].Nama_Tertanggung__c));

            

            pdfPage.getParameters().put('namaRekening', String.valueof(eform[0].nama_rekening__c));
            pdfPage.getParameters().put('namaBank', String.valueof(eform[0].Nama_Bank__c));
            pdfPage.getParameters().put('nomorRekening', String.valueof(eform[0].No_Rekening__c));
            pdfPage.getParameters().put('mataUang', String.valueof(eform[0].Mata_Uang__c));
            
            String tanggalLahir = (eform[0].Tanggal_Lahir__c != null) ? String.valueOf(eform[0].Tanggal_Lahir__c.format()) : '-';
            pdfPage.getParameters().put('tanggalLahir', tanggalLahir);
            pdfPage.getParameters().put('noIdentitas',  eform[0].Nomor_Kartu_Identitas__c );  
            //pdfPage.getParameters().put('jenisKartu', eform[0].Jenis_Kartu__c);  
            pdfPage.getParameters().put('paymentMethod', eform[0].Payment_Method__c);  
            Boolean isDmtm = (eform[0].DMTM__c != null && eform[0].DMTM__c == true);
            pdfPage.getParameters().put('dmtm', isDmtm ? 'DMTM' : 'NOTDMTM');


            pdfPage.getParameters().put('dataType', eform[0].SKDR_SKDKK__c);
        }
        else if(formName.contains('Deklarasi')){
            pdfPage.getParameters().put('namaPerusahaanAnggaran', eform[0].Nama_Perusahaan__c);
            pdfPage.getParameters().put('nomorAnggaranDasar', eform[0].Nomor_Anggaran_Dasar_Perusahaan__c);
            if(eform[0].Tanggal_Anggaran_Dasar_Perusahaan__c != NULL)pdfPage.getParameters().put('tanggalAnggaranDasar', String.valueOf(eform[0].Tanggal_Anggaran_Dasar_Perusahaan__c.format()));
            pdfPage.getParameters().put('noTdpSdp', eform[0].Nomor_TDP_SDP__c);
            pdfPage.getParameters().put('alamatDomisili', eform[0].Alamat_Domisili__c);
            pdfPage.getParameters().put('kota', eform[0].Kota__c);
            pdfPage.getParameters().put('kotaCP', eform[0].Kota_Controlling_Person__c);
            pdfPage.getParameters().put('negaraDomisili', eform[0].Negara_Domisili__c);
            pdfPage.getParameters().put('namaPihakPemegangPolis', eform[0].Nama_Pihak_Berwenang_Pemegang_Polis__c);
            pdfPage.getParameters().put('jabatan', eform[0].Jabatan__c);
            pdfPage.getParameters().put('namaCPPerusahaan', eform[0].Nama_Controlling_Person_Perusahaan__c);
            pdfPage.getParameters().put('jenisIdentitas', eform[0].Jenis_Identitas__c);
            pdfPage.getParameters().put('jenisIdentitasCP', eform[0].Jenis_Identitas_Controlling_Person__c);
            String nomorIdentitasCP = (eform[0].Jenis_Identitas_Controlling_Person__c == 'KTP') ? eform[0].Nomor_Identitas_Controlling_Person__c : eform[0].Pasport_CP__c;
            pdfPage.getParameters().put('nomorIdentitasCP', nomorIdentitasCP);
            String noIdentitas = (eform[0].Jenis_Identitas__c == 'KTP') ? eform[0].Nomor_Kartu_Identitas__c : eform[0].Pasport__c;
            pdfPage.getParameters().put('noIdentitas', noIdentitas);  
                   

            pdfPage.getParameters().put('templahirCP', eform[0].Tempat_Lahir_Controlling_Person__c);
            if(eform[0].Tanggal_Lahir_Controlling_Person__c != NULL)pdfPage.getParameters().put('tanggalLahirCP', String.valueOf(eform[0].Tanggal_Lahir_Controlling_Person__c.format()));
            pdfPage.getParameters().put('alamatDomisiliCP', eform[0].Alamat_Domisili_Controlling_Person__c);
            pdfPage.getParameters().put('negaraDomisiliCP', eform[0].Negara_Domisili_Controlling_Person__c);
            
            // pdfPage.getParameters().put('phName', detail[0].Log_Book_Activitiy__r.Touch_Point__c);
            
            pdfPage.getParameters().put('jenisBadanUsaha', eform[0].Jenis_Bdn_Usaha__c);
            pdfPage.getParameters().put('laporPajakBU', eform[0].Apakah_Badan_Usaha_ini_melakukan_pelapor__c);
            String negara = (eform[0].Negara_Terdaftar_Wajib_Pajak__c == NULL) ? '-' : eform[0].Negara_Terdaftar_Wajib_Pajak__c;
            pdfPage.getParameters().put('negara1', negara);
            pdfPage.getParameters().put('negara2', eform[0].Negara_Terdaftar_Wajib_Pajak1__c);
            pdfPage.getParameters().put('negara3', eform[0].Negara_Terdaftar_Wajib_Pajak2__c);
            
            if(eform[0].Negara_Terdaftar_Wajib_Pajak__c != NULL){
                pdfPage.getParameters().put('npwp1', checkNULL(eform[0].NPWP__c));
                pdfPage.getParameters().put('alasan1', checkNULL(eform[0].Alasan_Tidak_Ada_NPWP__c));
            }
            if(eform[0].Negara_Terdaftar_Wajib_Pajak1__c != NULL){
                pdfPage.getParameters().put('npwp2', checkNULL(eform[0].NPWP1__c));
                pdfPage.getParameters().put('alasan2', checkNULL(eform[0].Alasan_Tidak_Ada_NPWP1__c));
            }
            if(eform[0].Negara_Terdaftar_Wajib_Pajak2__c != NULL){
                pdfPage.getParameters().put('npwp3', checkNULL(eform[0].NPWP2__c));
                pdfPage.getParameters().put('alasan3', checkNULL(eform[0].Alasan_Tidak_Ada_NPWP2__c));
            }
           
            pdfPage.getParameters().put('warganegara', eform[0].Kewarganegaraan__c);


            pdfPage.getParameters().put('namaLengkap', eform[0].Nama_Lengkap__c);
            pdfPage.getParameters().put('namaLengkapBU', eform[0].Nama_Pihak_Berwenang_Pemegang_Polis__c);
            //concate tempat tanggal lahir  
            String tempat = (eform[0].Tempat_Lahir__c != null) ? String.valueOf(eform[0].Tempat_Lahir__c) : '-';
            String tanggal = (eform[0].Tanggal_Lahir__c != null) ? String.valueOf(eform[0].Tanggal_Lahir__c.format()) : '-';
            String tempatTanggal = tempat + ', ' + tanggal;
            pdfPage.getParameters().put('tempatTanggal', tempatTanggal);
            pdfPage.getParameters().put('tempatLahir', tempat);
            pdfPage.getParameters().put('tanggalLahir', tanggal);

          //  pdfPage.getParameters().put('jenisIdentitas', eform[0].Jenis_Identitas__c);
            pdfPage.getParameters().put('alamat', eform[0].Alamat_Domisili__c);
            pdfPage.getParameters().put('kedudukan', eform[0].Kedudukan_Polis__c);

            pdfPage.getParameters().put('kodepos', eform[0].Kode_Pos__c);
            pdfPage.getParameters().put('kodeposCP', eform[0].Kode_Pos_Controlling_Persong__c);

            pdfPage.getParameters().put('laporPajakCP', eform[0].Apakah_Controlling_Person_ini_melakukan__c);
            String negaraCP = (eform[0].Negara_Terdaftar_Wajib_Pajak_CP_1__c == NULL) ? '-' : eform[0].Negara_Terdaftar_Wajib_Pajak_CP_1__c;
            pdfPage.getParameters().put('negara1CP', negaraCP);
            pdfPage.getParameters().put('negara2CP', eform[0].Negara_Terdaftar_Wajib_Pajak_CP_2__c);
            pdfPage.getParameters().put('negara3CP', eform[0].Negara_Terdaftar_Wajib_Pajak_CP_3__c);
            
            if(eform[0].Negara_Terdaftar_Wajib_Pajak_CP_1__c != NULL){
                pdfPage.getParameters().put('npwp1CP', checkNULL(eform[0].NPWP_CP_1__c));
                pdfPage.getParameters().put('alasan1CP', checkNULL(eform[0].Alasan_CP_1__c));
            }
            if(eform[0].Negara_Terdaftar_Wajib_Pajak_CP_2__c != NULL){
                pdfPage.getParameters().put('npwp2CP', checkNULL(eform[0].NPWP_CP_2__c));
                pdfPage.getParameters().put('alasan2CP', checkNULL(eform[0].Alasan_CP_2__c));
            }
            if(eform[0].Negara_Terdaftar_Wajib_Pajak_CP_3__c != NULL){
                pdfPage.getParameters().put('npwp3CP', checkNULL(eform[0].NPWP_CP_3__c));
                pdfPage.getParameters().put('alasan3CP', checkNULL(eform[0].Alasan_CP_3__c));
            }  
        }
        else if(formname.Contains('Perubahan Alamat Email') 
                || formname.Contains('Perubahan Nomor Kontak')
                || formname.Contains('Perubahan Alamat Korespondensi')
                || formname.Contains('Perubahan ID KTP')
                || formname.Contains('Pengajuan Cuti Premi')
                || formname.Contains('Perubahan Termaslahat (Penerima Manfaat)')){
            pdfPage.getParameters().put('formName', eform[0].Name);
            pdfPage.getParameters().put('nameTT', eform[0].Nama_Tertanggung__c!=null ? eform[0].Nama_Tertanggung__c : cont[0].Insured_Name__c);
            pdfPage.getParameters().put('subjectTransaction', eform[0].Subdana_Tambahan_1__c);
            pdfPage.getParameters().put('subjectTransactionNumber', eform[0].Subdana_Tambahan_2__c);
            pdfPage.getParameters().put('alasan', eform[0].Alasan__c);
            // String formTambahan = (detail[0].Form_Tambahan__c != null) ? detail[0].Form_Tambahan__c : '-';
            String formTambahan = getKeteranganTambahanAsString(detail[0]) != '' ? getKeteranganTambahanAsString(detail[0]) : '-';
            system.debug('INI ADALAH FORM TAMBAHAN:::::'+formTambahan);
            pdfPage.getParameters().put('formTambahan', formTambahan);
            String dokumenTambahan = (detail[0].Dokumen_Tambahan__c != null) ? detail[0].Dokumen_Tambahan__c : '-';
            system.debug('INI ADALAH DOKUMEN TAMBAHAN:::::'+dokumenTambahan);
            pdfPage.getParameters().put('dokumenTambahan', dokumenTambahan);
            
            //Informasi Pemegang Polis
            String NIK = (eform[0].Nomor_Kartu_Identitas__c != null) ? eform[0].Nomor_Kartu_Identitas__c : '-';
            pdfPage.getParameters().put('NIK', NIK);
            Datetime tanggalLahir = (eform[0].Tanggal_Lahir__c != null) ? eform[0].Tanggal_Lahir__c : null;
            String tanggalLahirFormat = tanggalLahir!= null ? tanggalLahir.format('dd/MM/yyyy') : '-';
            pdfPage.getParameters().put('tanggalLahir', tanggalLahirFormat);
            pdfPage.getParameters().put('segmentasi', eform[0].Segmentation__c);

            
            if(formname.Contains('Perubahan Alamat Email')){
                String emailSebelumnya = eform[0].Email__c != null ? eform[0].Email__c : '-';
                pdfPage.getParameters().put('emailSebelumnya', emailSebelumnya);
                String emailSebelumnyaTP = eform[0].Email_Sebelumnya_TP__c != null ? eform[0].Email_Sebelumnya_TP__c : '-';
                pdfPage.getParameters().put('emailSebelumnyaTP', emailSebelumnyaTP);
                String emailPP = eform[0].Email_Terbaru__c != null ? eform[0].Email_Terbaru__c : '-';
                pdfPage.getParameters().put('emailTerbaru', emailPP);
                String emailTP = eform[0].Email_Terbaru_TP__c != null ? eform[0].Email_Terbaru_TP__c : '-';
                pdfPage.getParameters().put('emailTerbaruTP', emailTP);
            }
            else if(formname.Contains('Perubahan Alamat Korespondensi')){
                String alamatSebelumnya = eform[0].Alamat__c != null ? eform[0].Alamat__c : '-';
                pdfPage.getParameters().put('alamatSebelumnya', alamatSebelumnya);
                String alamatSebelumnyaTP = eform[0].Alamat_Domisili_Controlling_Person__c != null ? eform[0].Alamat_Domisili_Controlling_Person__c : '-';
                pdfPage.getParameters().put('alamatSebelumnyaTP', alamatSebelumnyaTP);
                String alamatPP = eform[0].Alamat_Terbaru__c != null ? eform[0].Alamat_Terbaru__c : '-';
                pdfPage.getParameters().put('alamatTerbaru', alamatPP);
                String alamatTP = eform[0].Alamat_Terbaru_TP__c != null ? eform[0].Alamat_Terbaru_TP__c : '-';
                pdfPage.getParameters().put('alamatTerbaruTP', alamatTP);
            }
            else if(formname.Contains('Perubahan Nomor Kontak')){
                String nomorRumahSebelumnya = eform[0].NPWP__c != null ? eform[0].NPWP__c : '-';
                pdfPage.getParameters().put('nomorRumahSebelumnya', nomorRumahSebelumnya);
                String nomorRumahSebelumnyaTP = eform[0].NPWP_CP_1__c != null ? eform[0].NPWP_CP_1__c : '-';
                pdfPage.getParameters().put('nomorRumahSebelumnyaTP', nomorRumahSebelumnyaTP);
                String nomorKantorSebelumnya = eform[0].NPWP1__c != null ? eform[0].NPWP1__c : '-';
                pdfPage.getParameters().put('nomorKantorSebelumnya', nomorKantorSebelumnya);
                String nomorKantorSebelumnyaTP = eform[0].NPWP_CP_2__c != null ? eform[0].NPWP_CP_2__c : '-';
                pdfPage.getParameters().put('nomorKantorSebelumnyaTP', nomorKantorSebelumnyaTP);
                String nomorSelulerSebelumnya = eform[0].Nomor_Telpon__c != null ? eform[0].Nomor_Telpon__c : '-';
                pdfPage.getParameters().put('nomorSelulerSebelumnya', nomorSelulerSebelumnya);
                String nomorSelulerSebelumnyaTP = eform[0].Nomor_Identitas_Controlling_Person__c != null ? eform[0].Nomor_Identitas_Controlling_Person__c : '-';
                pdfPage.getParameters().put('nomorSelulerSebelumnyaTP', nomorSelulerSebelumnyaTP);
                String nomorRumahTerbaru = eform[0].Telepon_Rumah_Terbaru__c != null ? eform[0].Telepon_Rumah_Terbaru__c : '-';
                pdfPage.getParameters().put('nomorRumahTerbaru', nomorRumahTerbaru);
                String nomorRumahTerbaruTP = eform[0].Telepon_Rumah_Terbaru_TP__c != null ? eform[0].Telepon_Rumah_Terbaru_TP__c : '-';
                pdfPage.getParameters().put('nomorRumahTerbaruTP', nomorRumahTerbaruTP);
                String nomorKantorTerbaru = eform[0].Telepon_Kantor_Terbaru__c != null ? eform[0].Telepon_Kantor_Terbaru__c : '-';
                pdfPage.getParameters().put('nomorKantorTerbaru', nomorKantorTerbaru);
                String nomorKantorTerbaruTP = eform[0].Telepon_Kantor_Terbaru_TP__c != null ? eform[0].Telepon_Kantor_Terbaru_TP__c : '-';
                pdfPage.getParameters().put('nomorKantorTerbaruTP', nomorKantorTerbaruTP);
                String nomorSelulerTerbaru = eform[0].Telepon_Seluler_Terbaru__c != null ? eform[0].Telepon_Seluler_Terbaru__c : '-';
                pdfPage.getParameters().put('nomorSelulerTerbaru', nomorSelulerTerbaru);
                String nomorSelulerTerbaruTP = eform[0].Telepon_Seluler_Terbaru_TP__c != null ? eform[0].Telepon_Seluler_Terbaru_TP__c : '-';
                pdfPage.getParameters().put('nomorSelulerTerbaruTP', nomorSelulerTerbaruTP);
                String jenisPilihan;
                
                if((nomorKantorTerbaru != '-' || nomorRumahTerbaru != '-' || nomorSelulerTerbaru != '-') &&
                    nomorKantorTerbaruTP == '-' && nomorRumahTerbaruTP == '-' && nomorSelulerTerbaruTP == '-'){
                    jenisPilihan = 'PP';
                }
                else if(nomorKantorTerbaru == '-' && nomorRumahTerbaru == '-' && nomorSelulerTerbaru == '-' &&
                    (nomorKantorTerbaruTP != '-' || nomorRumahTerbaruTP != '-' || nomorSelulerTerbaruTP != '-')){
                    jenisPilihan = 'TP';
                }
                else if((nomorKantorTerbaru != '-' || nomorRumahTerbaru != '-' || nomorSelulerTerbaru != '-') &&
                    (nomorKantorTerbaruTP != '-' || nomorRumahTerbaruTP != '-' || nomorSelulerTerbaruTP != '-')){
                    jenisPilihan = 'PPTP';
                }
                system.debug(nomorKantorTerbaru);
                system.debug(nomorKantorTerbaruTP);
                system.debug(nomorRumahTerbaru);
                system.debug(nomorRumahTerbaruTP);
                system.debug(nomorSelulerTerbaru);
                system.debug(nomorSelulerTerbaruTP);
                system.debug(jenisPilihan);
                pdfPage.getParameters().put('jenisPilihan', jenisPilihan);
            }
            else if(formname.Contains('Perubahan ID KTP')){
                String nomorKTPSebelumnya = eform[0].Nomor_Kartu_Identitas__c != null ? eform[0].Nomor_Kartu_Identitas__c : '-';
                pdfPage.getParameters().put('nomorKTPSebelumnya', nomorKTPSebelumnya);
                String nomorKTPSebelumnyaTP = eform[0].Nomor_Identitas_Controlling_Person__c != null ? eform[0].Nomor_Identitas_Controlling_Person__c : '-';
                pdfPage.getParameters().put('nomorKTPSebelumnyaTP', nomorKTPSebelumnyaTP);
                String NamaPP = eform[0].Nama_Lengkap__c != null ? eform[0].Nama_Lengkap__c : '-';
                pdfPage.getParameters().put('namaLengkapPP', NamaPP);
                String NamaTP = eform[0].Nama_Tertanggung__c != null ? eform[0].Nama_Tertanggung__c : '-';
                pdfPage.getParameters().put('namaLengkapTP', NamaTP);
                String KTPPP = eform[0].Nomor_KTP_Terbaru__c != null ? eform[0].Nomor_KTP_Terbaru__c : '-';
                pdfPage.getParameters().put('nomorKTPTerbaru', KTPPP);
                String KTPTP = eform[0].Nomor_KTP_Terbaru_TP__c != null ? eform[0].Nomor_KTP_Terbaru_TP__c : '-';
                pdfPage.getParameters().put('nomorKTPTerbaruTP', KTPTP);
            }
            else if(formname.Contains('Perubahan Termaslahat (Penerima Manfaat)')){
                pdfPage.getParameters().put('dataAhliWaris1', eform[0].Penerima_Manfaat_1__c);
                pdfPage.getParameters().put('dataAhliWaris2', eform[0].Penerima_Manfaat_2__c);
                pdfPage.getParameters().put('dataAhliWaris3', eform[0].Penerima_Manfaat_3__c);
                pdfPage.getParameters().put('dataAhliWaris4', eform[0].Penerima_Manfaat_4__c);
                pdfPage.getParameters().put('dataAhliWaris5', eform[0].Penerima_Manfaat_5__c);
            }
        }
        else if(formName.contains('FP5')){
            pdfPage.getParameters().put('dokumenTambahanFP5', detail[0].Dokumen_Tambahan__c);
            pdfPage.getParameters().put('tambahanInformasi', eform[0].Alasan__c);
            String fullnamePolis = eform[0].Nama_Pemilik_Polis__c!=null ? eform[0].Nama_Pemilik_Polis__c : cont[0].Name;
            pdfPage.getParameters().put('fullname', fullnamePolis);
            pdfPage.getParameters().put('fullnameTT', eform[0].Nama_Tertanggung__c!=null ? eform[0].Nama_Tertanggung__c : cont[0].Insured_Name__c);
            pdfPage.getParameters().put('noTelpPolisFP5', eform[0].Nomor_Telpon__c!=null ? eform[0].Nomor_Telpon__c : cont[0].MobilePhone);
            pdfPage.getParameters().put('alamatPolisFP5', eform[0].Alamat_Domisili__c != null ? eform[0].Alamat_Domisili__c:'');
            pdfPage.getParameters().put('emailPolisFP5', eform[0].Email__c != null ? eform[0].Email__c : (cont[0].email != null ? cont[0].email : ''));
            pdfPage.getParameters().put('segmentasi', eform[0].Segmentation__c);
            String tanggalLahir = (eform[0].Tanggal_Lahir__c != null) ? String.valueOf(eform[0].Tanggal_Lahir__c.format()) : '';
            pdfPage.getParameters().put('tanggalLahir', tanggalLahir);
            pdfPage.getParameters().put('noIdentitasKtp', eform[0].Nomor_Kartu_Identitas__c !=null?eform[0].Nomor_Kartu_Identitas__c:'');
            pdfPage.getParameters().put('formUtama', eform[0].Tujuan_Lainnya__c);
        }
        else if(formName.contains('Pemulihan Polis')) {
            String jenisPengkinianData;
            if(eform[0].Pengkinian_Data__c == 'Pemegang Polis'){
                jenisPengkinianData = 'PP';
            } else if(eform[0].Pengkinian_Data__c == 'Tertanggung/Peserta'){
                jenisPengkinianData = 'TP';
            } else {
                jenisPengkinianData = 'PPTP';
            }
            pdfPage.getParameters().put('jenisPengkinianData', jenisPengkinianData);
            // PEMEGANG POLIS
                   //Informasi Pekerjaan
            pdfPage.getParameters().put(
                    'noTelp',
                    !String.isBlank(eform[0].Nomor_Telpon__c) ? eform[0].Nomor_Telpon__c :
                    !String.isBlank(cont[0].MobilePhone)       ? cont[0].MobilePhone       : '-'
                );
            String tglLahir = (eform[0].Tanggal_Lahir__c != null) ? String.valueOf(eform[0].Tanggal_Lahir__c.format()) : '-';
            pdfPage.getParameters().put('alasanPemulihanPolis',  eform[0].Alasan__c);
            pdfPage.getParameters().put('jenisKel',  eform[0].Gender__c);
            pdfPage.getParameters().put('jenisKelTP',  eform[0].GenderTP__c);
            pdfPage.getParameters().put('noIdentitas',  eform[0].Nomor_Kartu_Identitas__c );  
            pdfPage.getParameters().put('segmentasi', eform[0].Segmentation__c);
            pdfPage.getParameters().put('tglLahir', tglLahir);
            pdfPage.getParameters().put('sign', eform[0].Sign_ID__c);
            pdfPage.getParameters().put('signTP', eform[0].Sign_ID_TP__c);
            pdfPage.getParameters().put('namaPerusahaanPP', eform[0].Nama_Perusahaan__c);
            pdfPage.getParameters().put('jabatanPP', eform[0].Jabatan__c);
            pdfPage.getParameters().put('pekerjaanPP', eform[0].Pekerjaan__c);
            pdfPage.getParameters().put('bidangUsahaPP', eform[0].Bidang_Usaha__c);
            pdfPage.getParameters().put('rincianTugasPP', eform[0].Rincian_Tugas__c);
            pdfPage.getParameters().put('alatBantuPP', eform[0].Alat_bantu_yang_digunakan__c);
                   //DATA FISIK
            pdfPage.getParameters().put('tinggiBadanSaatIniPP', eform[0].Tinggi_Badan__c);
            pdfPage.getParameters().put('beratBadanSaatIniPP', eform[0].Berat_Badan__c);
            pdfPage.getParameters().put('tinggiBadanTahunLaluPP', eform[0].Tinggi_Badan_tahun_lalu__c);
            pdfPage.getParameters().put('beratBadanTahunLaluPP', eform[0].Berat_Badan_tahun_lalu__c);
           // pdfPage.getParameters().put('alasanPerubahanPP', eform[0].Alasan_perubahan_tinggi_berat_badan__c);
                   //DATA PRIBADI dan KEBIASAAN
                       //dataPKPPRB = data pribadi kebiasaan pemegang polis radio button
            pdfPage.getParameters().put('DTPKPPRBPP1', eform[0].Pertanyaan_dt_pribadi_kebiasaan1__c);
            pdfPage.getParameters().put('DTPKPPRBPP2', eform[0].Pertanyaan_dt_pribadi_kebiasaan2__c);
            pdfPage.getParameters().put('DTPKPPRBPP3', eform[0].Pertanyaan_dt_pribadi_kebiasaan3__c);
            pdfPage.getParameters().put('DTPKPPRBPP4', eform[0].Pertanyaan_dt_pribadi_kebiasaan4__c);
            pdfPage.getParameters().put('DTPKPPRBPP5', eform[0].Pertanyaan_dt_pribadi_kebiasaan5__c);
            pdfPage.getParameters().put('DTPKPPRBPP6', eform[0].Pertanyaan_dt_pribadi_kebiasaan6__c);
            	//section pribadi dan kebiasaan point c DTPKRBTP3
            pdfPage.getParameters().put('rokokPP', eform[0].Berapa_Batang_PP__c);
            pdfPage.getParameters().put('sejakPP', eform[0].Sejak_PP__c);
            pdfPage.getParameters().put('rokokElektrikPP', eform[0].Rokok_Elektrik_PP__c);
            pdfPage.getParameters().put('sejekElektrikPP', eform[0].sejak_elektrik_PP__c);
            pdfPage.getParameters().put('tanpaAsapPP', eform[0].Tanpa_asap_pp__c);
            
            //     //PENJELASAN SECTION DATA PRIBADI dan KEBIASAAN
            // pdfPage.getParameters().put('DTPKPPTAPP1', eform[0].Penjelasan_dt_pribadi_kebiasaan__c);
            // pdfPage.getParameters().put('DTPKPPTAPP2', eform[0].Penjelasan_dt_pribadi_kebiasaan1__c);
            // pdfPage.getParameters().put('DTPKPPTAPP3', eform[0].Penjelasan_dt_pribadi_kebiasaan2__c);
            // pdfPage.getParameters().put('DTPKPPTAPP4', eform[0].Penjelasan_dt_pribadi_kebiasaan3__c);
            // pdfPage.getParameters().put('DTPKPPTAPP5', eform[0].Penjelasan_dt_pribadi_kebiasaan4__c);
            // pdfPage.getParameters().put('DTPKPPTAPP6', eform[0].Penjelasan_dt_pribadi_kebiasaan5__c);
                  //DATA KESEHATAN
            pdfPage.getParameters().put('DTKESRBPP1', eform[0].Pertanyaan_dt_kesehatan1__c);
            pdfPage.getParameters().put('DTKESRBPP2', eform[0].Pertanyaan_dt_kesehatan2__c);
            pdfPage.getParameters().put('DTKESRBPP3', eform[0].Pertanyaan_dt_kesehatan3__c);
            pdfPage.getParameters().put('DTKESRBPP4', eform[0].Pertanyaan_dt_kesehatan4__c);
            pdfPage.getParameters().put('DTKESRBPP5', eform[0].Pertanyaan_dt_kesehatan5__c);

            //     // DATA KESEHATAN SECTION PENJELASAN 
            // pdfPage.getParameters().put('DTKESTAPP1', eform[0].Penjelasan_dt_kesehatan__c);
            // pdfPage.getParameters().put('DTKESTAPP2', eform[0].Penjelasan_dt_kesehatan1__c);
            // pdfPage.getParameters().put('DTKESTAPP3', eform[0].Penjelasan_dt_kesehatan2__c);
            // pdfPage.getParameters().put('DTKESTAPP4', eform[0].Penjelasan_dt_kesehatan3__c);
            // pdfPage.getParameters().put('DTKESTAPP5', eform[0].Penjelasan_dt_kesehatan4__c);

               // DATA KESEHATAN TAMBAHAN
            pdfPage.getParameters().put('DTKESTAMRBPP1', eform[0].Pertanyaan_dt_kesehatan_tambahan1__c);
            pdfPage.getParameters().put('DTKESTAMRBPP2', eform[0].Pertanyaan_dt_kesehatan_tambahan2__c);
            pdfPage.getParameters().put('DTKESTAMRBPP3', eform[0].Pertanyaan_dt_kesehatan_tambahan3__c);
            pdfPage.getParameters().put('DTKESTAMRBPP4', eform[0].Pertanyaan_dt_kesehatan_tambahan4__c);
            pdfPage.getParameters().put('DTKESTAMRBPP5', eform[0].Pertanyaan_dt_kesehatan_tambahan5__c);
            pdfPage.getParameters().put('DTKESTAMRBPP6', eform[0].Pertanyaan_dt_kesehatan_tambahan6__c);
            pdfPage.getParameters().put('DTKESTAMRBPP7', eform[0].Pertanyaan_dt_kesehatan_tambahan7__c);
            pdfPage.getParameters().put('DTKESTAMRBPP8', eform[0].Pertanyaan_dt_kesehatan_tambahan8__c);
            pdfPage.getParameters().put('DTKESTAMRBPP9', eform[0].Pertanyaan_dt_kesehatan_tambahan9__c);
            pdfPage.getParameters().put('DTKESTAMRBPP10', eform[0].Pertanyaan_dt_kesehatan_tambahan10__c);
            pdfPage.getParameters().put('DTKESTAMRBPP11', eform[0].Pertanyaan_dt_kesehatan_tambahan11__c);
            pdfPage.getParameters().put('DTKESTAMRBPP12', eform[0].Pertanyaan_dt_kesehatan_tambahan12__c);
            pdfPage.getParameters().put('DTKESTAMRBPP13', eform[0].Pertanyaan_dt_kesehatan_tambahan13__c);
            pdfPage.getParameters().put('DTKESTAMRBPP14', eform[0].Pertanyaan_dt_kesehatan_tambahan14__c);
            pdfPage.getParameters().put('DTKESTAMRBPP15', eform[0].Pertanyaan_dt_kesehatan_tambahan15__c);

               //DATA KESEHATAN TAMBAHAN SECTION PENJELASAN
            // pdfPage.getParameters().put('DTKESTAMTAPP1', eform[0].Penjelasan_dt_kesehatan_tambahan__c);
            // pdfPage.getParameters().put('DTKESTAMTAPP2', eform[0].Penjelasan_dt_kesehatan_tambahan1__c);
            // pdfPage.getParameters().put('DTKESTAMTAPP3', eform[0].Penjelasan_dt_kesehatan_tambahan2__c);
            // pdfPage.getParameters().put('DTKESTAMTAPP4', eform[0].Penjelasan_dt_kesehatan_tambahan3__c);
            // pdfPage.getParameters().put('DTKESTAMTAPP5', eform[0].Penjelasan_dt_kesehatan_tambahan4__c);
            // pdfPage.getParameters().put('DTKESTAMTAPP6', eform[0].Penjelasan_dt_kesehatan_tambahan5__c);
            // pdfPage.getParameters().put('DTKESTAMTAPP7', eform[0].Penjelasan_dt_kesehatan_tambahan6__c);
            // pdfPage.getParameters().put('DTKESTAMTAPP8', eform[0].Penjelasan_dt_kesehatan_tambahan7__c);
            // pdfPage.getParameters().put('DTKESTAMTAPP9', eform[0].Penjelasan_dt_kesehatan_tambahan8__c);
            // pdfPage.getParameters().put('DTKESTAMTAPP10', eform[0].Penjelasan_dt_kesehatan_tambahan9__c);
            // pdfPage.getParameters().put('DTKESTAMTAPP11', eform[0].Penjelasan_dt_kesehatan_tambahan10__c);
            // pdfPage.getParameters().put('DTKESTAMTAPP12', eform[0].Penjelasan_dt_kesehatan_tambahan11__c);
            // pdfPage.getParameters().put('DTKESTAMTAPP13', eform[0].Penjelasan_dt_kesehatan_tambahan12__c);
            // pdfPage.getParameters().put('DTKESTAMTAPP14', eform[0].Penjelasan_dt_kesehatan_tambahan13__c);
            // pdfPage.getParameters().put('DTKESTAMTAPP15', eform[0].Penjelasan_dt_kesehatan_tambahan14__c);
                // END DATA KESAHATAN TAMBAHAN PP
            // END PEMEGANG POLIS


            // TERTANGGUNG/PESERTA
                   //Informasi Pekerjaan
            pdfPage.getParameters().put('namaTP', eform[0].Nama_Tertanggung__c);
            pdfPage.getParameters().put('namaPerusahaanTP', eform[0].Nama_Perusahaan_TP__c);
            pdfPage.getParameters().put('jabatanTP', eform[0].Jabatan_TP__c);
            pdfPage.getParameters().put('pekerjaanTP', eform[0].Pekerjaan_TP__c);
            pdfPage.getParameters().put('bidangUsahaTP', eform[0].Bidang_Usaha_TP__c);
            pdfPage.getParameters().put('rincianTugasTP', eform[0].Rincian_Tugas_TP__c);
            pdfPage.getParameters().put('alatBantuTP', eform[0].Alat_bantu_TP__c);
                   //DATA FISIK
            pdfPage.getParameters().put('tinggiBadanSaatIniTP', eform[0].Tinggi_Badan_TP__c);
            pdfPage.getParameters().put('beratBadanSaatIniTP', eform[0].Berat_Badan_TP__c);
            pdfPage.getParameters().put('tinggiBadanTahunLaluTP', eform[0].Tinggi_Badan_tahun_lalu_TP__c);
            pdfPage.getParameters().put('beratBadanTahunLaluTP', eform[0].Berat_Badan_tahun_lalu_TP__c);
           // pdfPage.getParameters().put('alasanPerubahanTP', eform[0].Alasan_perubahan_tinggi_berat_badan_TP__c);
                     //DATA PRIBADI dan KEBIASAAN
                          //dataPKPTRB = data pribadi kebiasaan tertanggung radio button
            pdfPage.getParameters().put('DTPKRBTP1', eform[0].Pertanyaan_dt_pribadi_kebiasaan1_TP__c);
            pdfPage.getParameters().put('DTPKRBTP2', eform[0].Pertanyaan_dt_pribadi_kebiasaan2_TP__c);
            pdfPage.getParameters().put('DTPKRBTP3', eform[0].Pertanyaan_dt_pribadi_kebiasaan3_TP__c);
            pdfPage.getParameters().put('DTPKRBTP4', eform[0].Pertanyaan_dt_pribadi_kebiasaan4_TP__c);
            pdfPage.getParameters().put('DTPKRBTP5', eform[0].Pertanyaan_dt_pribadi_kebiasaan5_TP__c);
            pdfPage.getParameters().put('DTPKRBTP6', eform[0].Pertanyaan_dt_pribadi_kebiasaan6_TP__c);
            
            			//section pribadi dan kebiasaan point c DTPKRBTP3
            pdfPage.getParameters().put('rokokTP', eform[0].Berapa_Batang_TP__c);
            pdfPage.getParameters().put('sejakTP', eform[0].Sejak_TP__c);
            pdfPage.getParameters().put('rokokElektrikTP', eform[0].Rokok_Elektrik_TP__c);
            pdfPage.getParameters().put('sejekElektrikTP', eform[0].sejak_elektrik_TP__c);
            pdfPage.getParameters().put('tanpaAsapTP', eform[0].Tanpa_asap_TP__c);
                //PENJELASAN SECTION DATA PRIBADI dan KEBIASAAN
            // pdfPage.getParameters().put('DTPKTATP1', eform[0].Penjelasan_dt_pribadi_kebiasaan_TP__c);
            // pdfPage.getParameters().put('DTPKTATP2', eform[0].Penjelasan_dt_pribadi_kebiasaan1_TP__c);
            // pdfPage.getParameters().put('DTPKTATP3', eform[0].Penjelasan_dt_pribadi_kebiasaan2_TP__c);
            // pdfPage.getParameters().put('DTPKTATP4', eform[0].Penjelasan_dt_pribadi_kebiasaan3_TP__c);
            // pdfPage.getParameters().put('DTPKTATP5', eform[0].Penjelasan_dt_pribadi_kebiasaan4_TP__c);
            // pdfPage.getParameters().put('DTPKTATP6', eform[0].Penjelasan_dt_pribadi_kebiasaan5_TP__c);
            
               //DATA KESEHATAN
            pdfPage.getParameters().put('DTKESRBTP1', eform[0].Pertanyaan_dt_kesehatan1_TP__c);
            pdfPage.getParameters().put('DTKESRBTP2', eform[0].Pertanyaan_dt_kesehatan2_TP__c);
            pdfPage.getParameters().put('DTKESRBTP3', eform[0].Pertanyaan_dt_kesehatan3_TP__c);
            pdfPage.getParameters().put('DTKESRBTP4', eform[0].Pertanyaan_dt_kesehatan4_TP__c);
            pdfPage.getParameters().put('DTKESRBTP5', eform[0].Pertanyaan_dt_kesehatan5_TP__c);

                // DATA KESEHATAN SECTION PENJELASAN 
            // pdfPage.getParameters().put('DTKESTATP1', eform[0].Penjelasan_dt_kesehatan_TP__c);
            // pdfPage.getParameters().put('DTKESTATP2', eform[0].Penjelasan_dt_kesehatan1_TP__c);
            // pdfPage.getParameters().put('DTKESTATP3', eform[0].Penjelasan_dt_kesehatan2_TP__c);
            // pdfPage.getParameters().put('DTKESTATP4', eform[0].Penjelasan_dt_kesehatan3_TP__c);
            // pdfPage.getParameters().put('DTKESTATP5', eform[0].Penjelasan_dt_kesehatan4_TP__c);

                // DATA KESEHATAN TAMBAHAN
            pdfPage.getParameters().put('DTKESTAMRBTP1', eform[0].Pertanyaan_dt_kesehatan_tambahan1_TP__c);
            pdfPage.getParameters().put('DTKESTAMRBTP2', eform[0].Pertanyaan_dt_kesehatan_tambahan2_TP__c);
            pdfPage.getParameters().put('DTKESTAMRBTP3', eform[0].Pertanyaan_dt_kesehatan_tambahan3_TP__c);
            pdfPage.getParameters().put('DTKESTAMRBTP4', eform[0].Pertanyaan_dt_kesehatan_tambahan4_TP__c);
            pdfPage.getParameters().put('DTKESTAMRBTP5', eform[0].Pertanyaan_dt_kesehatan_tambahan5_TP__c);
            pdfPage.getParameters().put('DTKESTAMRBTP6', eform[0].Pertanyaan_dt_kesehatan_tambahan6_TP__c);
            pdfPage.getParameters().put('DTKESTAMRBTP7', eform[0].Pertanyaan_dt_kesehatan_tambahan7_TP__c);
            pdfPage.getParameters().put('DTKESTAMRBTP8', eform[0].Pertanyaan_dt_kesehatan_tambahan8_TP__c);
            pdfPage.getParameters().put('DTKESTAMRBTP9', eform[0].Pertanyaan_dt_kesehatan_tambahan9_TP__c);
            pdfPage.getParameters().put('DTKESTAMRBTP10', eform[0].Pertanyaan_dt_kesehatan_tambahan10_TP__c);
            pdfPage.getParameters().put('DTKESTAMRBTP11', eform[0].Pertanyaan_dt_kesehatan_tambahan11_TP__c);
            pdfPage.getParameters().put('DTKESTAMRBTP12', eform[0].Pertanyaan_dt_kesehatan_tambahan12_TP__c);
            pdfPage.getParameters().put('DTKESTAMRBTP13', eform[0].Pertanyaan_dt_kesehatan_tambahan13_TP__c);
            pdfPage.getParameters().put('DTKESTAMRBTP14', eform[0].Pertanyaan_dt_kesehatan_tambahan14_TP__c);
            pdfPage.getParameters().put('DTKESTAMRBTP15', eform[0].Pertanyaan_dt_kesehatan_tambahan15_TP__c);

                //DATA KESEHATAN TAMBAHAN SECTION PENJELASAN
            // pdfPage.getParameters().put('DTKESTAMTATP1', eform[0].Penjelasan_dt_kesehatan_tambahan_TP__c);
            // pdfPage.getParameters().put('DTKESTAMTATP2', eform[0].Penjelasan_dt_kesehatan_tambahan1_TP__c);
            // pdfPage.getParameters().put('DTKESTAMTATP3', eform[0].Penjelasan_dt_kesehatan_tambahan2_TP__c);
            // pdfPage.getParameters().put('DTKESTAMTATP4', eform[0].Penjelasan_dt_kesehatan_tambahan3_TP__c);
            // pdfPage.getParameters().put('DTKESTAMTATP5', eform[0].Penjelasan_dt_kesehatan_tambahan4_TP__c);
            // pdfPage.getParameters().put('DTKESTAMTATP6', eform[0].Penjelasan_dt_kesehatan_tambahan5_TP__c);
            // pdfPage.getParameters().put('DTKESTAMTATP7', eform[0].Penjelasan_dt_kesehatan_tambahan6_TP__c);
            // pdfPage.getParameters().put('DTKESTAMTATP8', eform[0].Penjelasan_dt_kesehatan_tambahan7_TP__c);
            // pdfPage.getParameters().put('DTKESTAMTATP9', eform[0].Penjelasan_dt_kesehatan_tambahan8_TP__c);
            // pdfPage.getParameters().put('DTKESTAMTATP10', eform[0].Penjelasan_dt_kesehatan_tambahan9_TP__c);
            // pdfPage.getParameters().put('DTKESTAMTATP11', eform[0].Penjelasan_dt_kesehatan_tambahan10_TP__c);
            // pdfPage.getParameters().put('DTKESTAMTATP12', eform[0].Penjelasan_dt_kesehatan_tambahan11_TP__c);
            // pdfPage.getParameters().put('DTKESTAMTATP13', eform[0].Penjelasan_dt_kesehatan_tambahan12_TP__c);
            // pdfPage.getParameters().put('DTKESTAMTATP14', eform[0].Penjelasan_dt_kesehatan_tambahan13_TP__c);
            // pdfPage.getParameters().put('DTKESTAMTATP15', eform[0].Penjelasan_dt_kesehatan_tambahan14_TP__c);

            
               // DATA KHUSUS WANITA
            pdfPage.getParameters().put('DTWARBPP', eform[0].Pertanyaan_dt_khusus_wanita__c);
            pdfPage.getParameters().put('DTWARBTP', eform[0].Pertanyaan_dt_khusus_wanita_TP__c);
                // DATA KHUSUS WANITA SECTION PENJELASAN
            // pdfPage.getParameters().put('DTWATAPP', eform[0].Penjelasan_dt_khusus_wanita__c);
            // pdfPage.getParameters().put('DTWATATP', eform[0].Penjelasan_dt_khusus_wanita_TP__c);

               // DATA RIWAYAT KESEHATAN KELUARGA
            pdfPage.getParameters().put('DTKRKRBPP1', eform[0].Pertanyaan_dt_riwayat_keluarga__c);
            pdfPage.getParameters().put('DTKRKRBTP1', eform[0].Pertanyaan_dt_riwayat_keluarga_TP__c);

              // DATA RIWAYAT KESEHATAN KELUARGA SECTION PENJELASAN
            // pdfPage.getParameters().put('DTKRKTAPP1', eform[0].Penjelasan_dt_rwyt_keluarga__c);
            // pdfPage.getParameters().put('DTKRKTATP1', eform[0].Penjelasan_dt_rwyt_keluarga_TP__c);
    
        }
        // --- Set Parameter Keterangan Tambahan ---
        // String otherTransactionsString = '';
        // List<String> listOtherTransaction = new List<String>();
        // if(keteranganTambahan.size() > 0){
        //     for (Log_Book_Activitiy_Detail__c item : keteranganTambahan) {
        //         listOtherTransaction.add(item.Kind_Of_Transaction__c);
        //     }
        //     otherTransactionsString = String.join(listOtherTransaction, ',');
        // }
        // pdfPage.getParameters().put('listTransactions', otherTransactionsString);

        pdfPage.setRedirect(true);

        // Get E-Form id
        String eFormId = eform[0].Id;
        system.debug('Eform Id:'+eFormId);

        deletePreviousFile(eFormId);
        GeneratingPDF(formName, eFormId);
        system.debug('FINISH GENERATING PDF');

        /*
        // Query for Get ContentDocumentLink in E-Form
        List<ContentDocumentLink> checkCDL = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =:eFormId];
        // Query for Get ContentDocumentId
        List<String> cdId = new List<String>();
        for(ContentDocumentLink cdl : checkCDL){
            cdId.add(cdl.ContentDocumentId);
        }
        List<ContentDocument> checkCD = [SELECT Id FROM ContentDocument WHERE Id = : cdId];
        // Delete Previous File E-Form
        if(!checkCD.isEmpty()){
            delete checkCD;
        }
        */
        /*
        Blob pdfBlob;   
        if (!Test.isRunningTest()) { 
            pdfBlob = pdfPage.getContent(); 
        } else { 
            pdfBlob = Blob.valueOf('Test File');
        }

        ContentVersion contentVersion = new ContentVersion();
        contentVersion.ContentLocation = 'S'; // S = Stored in Salesforce
        contentVersion.PathOnClient = formName + '.' + 'pdf';
        contentVersion.Title = formName + '.' + 'pdf';
        contentVersion.VersionData = pdfBlob;    
        contentVersion.firstPublishLocationId= UserInfo.getUserId();
        insert  contentVersion;

        string contentVersionID = '';
        if(!Test.isRunningTest()){
            contentVersionID = contentVersion.Id;
        }else{
            contentVersionID = 'TestContentVersion';
        }
        
        ContentVersion con = new ContentVersion();
        if(!Test.isRunningTest())
            con = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersionID LIMIT 1];
        else 
            con = [SELECT Id, Title, ContentDocumentId FROM ContentVersion LIMIT 1];
        ContentDocumentLink doc = new ContentDocumentLink();
        doc.ContentDocumentId = con.ContentDocumentId;
        doc.LinkedEntityId = eform[0].id;
        doc.visibility = 'AllUsers';
        insert doc;*/

        
    }

    Global Static String checkNULL(String param){
        String result = '-' ;
        if(param != NULL){
            result = param;
        }

        return result;
    }

    Global Static void deletePreviousFile(String eformId){
        // Query for Get ContentDocumentLink in E-Form
        List<ContentDocumentLink> checkCDL = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =:eFormId];
        system.debug('CDL: '+checkCDL);
        // Query for Get ContentDocumentId
        List<String> cdId = new List<String>();
        for(ContentDocumentLink cdl : checkCDL){
            cdId.add(cdl.ContentDocumentId);
        }
        List<ContentDocument> checkCD = [SELECT Id FROM ContentDocument WHERE Id = : cdId];
        system.debug('CD: '+checkCD);
        // Delete Previous File E-Form
        if(!checkCD.isEmpty()){
            delete checkCD;
        }
    }

    Global Static void GeneratingPDF(String formName, String eformId){
        Blob pdfBlob;   
        if (!Test.isRunningTest()) { 
            system.debug('START GENERATING PDF');
            system.debug('pdfPage ' + pdfPage);
            pdfBlob = pdfPage.getContent(); 
        } else { 
            pdfBlob = Blob.valueOf('Test File');
        }

        ContentVersion contentVersion = new ContentVersion();
        contentVersion.ContentLocation = 'S'; // S = Stored in Salesforce
        contentVersion.PathOnClient = formName + '.' + 'pdf';
        contentVersion.Title = formName + '.' + 'pdf';
        contentVersion.VersionData = pdfBlob;    
        contentVersion.firstPublishLocationId= UserInfo.getUserId();
        insert  contentVersion;

        System.debug('contentVersion ID ' + contentVersion.Id);
        string contentVersionID = '';
        if(!Test.isRunningTest()){
            contentVersionID = contentVersion.Id;
        }else{
            contentVersionID = 'TestContentVersion';
        }
        
        ContentVersion con = new ContentVersion();
        if(!Test.isRunningTest())
            con = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersionID LIMIT 1];
        else 
            con = [SELECT Id, Title, ContentDocumentId FROM ContentVersion LIMIT 1];
        ContentDocumentLink doc = new ContentDocumentLink();
        doc.ContentDocumentId = con.ContentDocumentId;
        doc.LinkedEntityId = eformId;
        doc.visibility = 'AllUsers';
        insert doc;
    }

    public static String getKeteranganTambahanAsString(Log_Book_Activitiy_Detail__c detail){
        List<Log_Book_Activitiy_Detail__c> keteranganTambahan = [
            SELECT id,Kind_Of_Transaction__c,Department__c,Policy_Number__c from Log_Book_Activitiy_Detail__c 
            Where Log_Book_Activitiy__c = :detail.Log_Book_Activitiy__c AND Id != :detail.Id AND Canceled__c = false
            AND Department__c = :detail.Department__c AND Policy_Number__c = :detail.Policy_Number__c AND EForm__c = true
        ];
        String otherTransactionsString = '';
        List<String> listOtherTransaction = new List<String>();
        if(keteranganTambahan.size() > 0){
            system.debug('FORM cek KeteranganTambahan: ' + keteranganTambahan);
            for (Log_Book_Activitiy_Detail__c item : keteranganTambahan) {
                listOtherTransaction.add(item.Kind_Of_Transaction__c);
            }
            otherTransactionsString = String.join(listOtherTransaction, ',');
        }

        return otherTransactionsString;
        // --- Example to set parameter ---
        // pdfPage.getParameters().put('listTransactions', otherTransactionsString);

        // --- Example to get value in controller pdf ---
        // transactionsString = getParam('listTransactions');
        // if (transactionsString != null) {
        //     transactionsList = transactionsString.split(',');
        // } else {
        //     transactionsList = new List<String>();
        // }

        // --- Example to set in visual force ---
        // <div>
        //     <ol>
        //         <apex:repeat value="{!transactionsList}" var="transaction">
        //             <li>{!transaction}</li>
        //         </apex:repeat>
        //     </ol>
        // </div>
    }
}