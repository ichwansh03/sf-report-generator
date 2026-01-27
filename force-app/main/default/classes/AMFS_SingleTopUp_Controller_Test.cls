/**
 * @description       : 
 * @author            : Mario Carlos Eyo
 * @group             : 
 * @last modified on  : 18-07-2025
 * @last modified by  : Mario Carlos Eyo
**/
@isTest
public with sharing class AMFS_SingleTopUp_Controller_Test {
    public static testMethod void runTest() {
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
        logBookDetail.Segmentation__c = 'Reguler';
        logBookDetail.Department__c = dept;
        logBookDetail.Kind_Of_Transaction__c = transactionType;
        logBookDetail.Document_Type__c = 'New Submission';
        logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];';
        logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logBookDetail.Stamp__c = 2;
         
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
            Jenis_Badan_Usaha__c = 'Regular',
            Jenis_Identitas_Controlling_Person__c = 'KTP',
            jumlah__c = 1000000,
            Jumlah_Penarikan_Dana__c = 4000000,
            Jumlah_Setelah_Biaya_Transaksi__c = 5000000,
            Kedudukan_Polis__c = 'Regular',
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
            nomor_rekening__c = 785562,
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
            TIN__c = 48525,
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
            Tujuan_Lainnya__c = 'ALAMAT'
            );
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
            Jenis_Badan_Usaha__c = 'Regular',
            Jenis_Identitas_Controlling_Person__c = 'KTP',
            jumlah__c = 1000000,
            Jumlah_Penarikan_Dana__c = 4000000,
            Jumlah_Setelah_Biaya_Transaksi__c = 5000000,
            Kedudukan_Polis__c = 'Regular',
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
            nomor_rekening__c = 785562,
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
            sumberdana__c = 'Lainnya',
            Tempat_Lahir__c = 'ALAMAT',
            Tempat_Lahir_Controlling_Person__c = 'ALAMAT',
            TIN__c = 48525,
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
            Tujuan_Lainnya__c = 'ALAMAT'
            );
        return eform;
    }
}