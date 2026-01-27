@isTest(seealldata=true)
public class EmailSenderUtil_Test {
    static testMethod void testBatch(){
        String emailAddress='irwan.irwan@axa-mandiri.co.id';
        String emailBody='Nasabah Yth. </br> </br> Kami telah menerima pengaduan pada tanggal 20 Feb 2024 dengan nomor Pengaduan </br> 05413864 dan saat ini pengaduan tersebut dalam proses penanganan lebih lanjut. </br></br>  Terima kasih</br> PT AXA Mandiri Financial Services'; 
        String subject='New Case';
        EmailSenderUtil.sendEmail(emailAddress, emailBody, subject);
    }
}