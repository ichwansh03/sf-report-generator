@isTest //(SeeAllData = TRUE)
public class chatDuration_Test {
    @testSetup static void setTestData() {
        String chatBody1 = '';
        chatBody1 += '<p align="center">Chat Transferred From AXA Financial Indonesia To AXA Financial Indonesia</p>';
        chatBody1 += '<br><p>Chat Started: Friday, February 15, 2019, 16:48:24 (+0700)</p>\n';
        chatBody1 += '<br><p>Chat Origin: Chat_ALI</p>\n';
        chatBody1 += '<br><p>Agent AXA Financial Indonesia</p>\n';
        chatBody1 += '<br>( 1m 37s ) AXA Financial Indonesia: Selamat datang di live chat AXA Financial Indonesia. Nama saya Ramadhan Ada yang bisa saya bantu?';
        chatBody1 += '<br>( 1m 38s ) Iya, saya minta tolong ini.';
        chatBody1 += '<br>( 1m 39s ) Ok, tunggu sebentar ya';
        chatBody1 += '<br>( 1m 40s ) Terima kasih.';
        
        String chatBody2 = '';
        chatBody2 += '<p align="center">Chat Transferred From AXA Financial Indonesia To AXA Financial Indonesia</p>';
        chatBody2 += '<br><p>Chat Started: Friday, February 15, 2019, 16:48:24 (+0700)</p>\n';
        chatBody2 += '<br>( 1m 37s ) AXA Financial Indonesia: Selamat datang di live chat AXA Financial Indonesia. Nama saya Ramadhan Ada yang bisa saya bantu?';
        chatBody2 += '<br>( 1m 38s ) Customer: Iya, saya minta tolong ini.';
        chatBody2 += '<br>( 1m 39s ) AXA Financial Indonesia: Ok, tunggu sebentar ya';
        chatBody2 += '<br>Transffered ( 1m 40s ) Customer: Terima kasih.';
        chatBody2 += '<br>Transferred ( 1m 50s ) AXA Financial Indonesia: Ok, tunggu sebentar ya';
        
        String chatBody3 = '';
        chatBody3 += '<p align="center">Chat Transferred From AXA Financial Indonesia To AXA Financial Indonesia</p>';
        chatBody3 += '<br><p>Chat Started: Friday, February 15, 2019, 16:48:24 (+0700)</p>\n';
        chatBody3 += '<br>( 1m 37s ) AXA Financial Indonesia: Selamat datang di live chat AXA Financial Indonesia. Nama saya Ramadhan Ada yang bisa saya bantu?';
        chatBody3 += '<br>( 1m 38s ) Customer: Iya, saya minta tolong ini.';
        chatBody3 += '<br>( 1m 39s ) AXA Financial Indonesia: Ok, tunggu sebentar ya';
        chatBody3 += '<br>Transferred ( 1m 40s ) AXA Financial Indonesia:: Terima kasih.';
        chatBody3 += '<br>( 1m 50s ) AXA Financial Indonesia:: Ok, tunggu sebentar ya';
        
        LiveChatVisitor lcv = new LiveChatVisitor();
        insert lcv;
        
        LiveChatTranscript lct1 = new LiveChatTranscript();
        lct1.LiveChatVisitorId = lcv.Id;
        lct1.Body = chatBody1;
        lct1.List_Agent__c = '';
        lct1.TriggerOff__c = FALSE;
        lct1.Status = 'Completed';
        lct1.RequestTime = datetime.now();
        lct1.StartTime = datetime.now();
        insert lct1;
        
        LiveChatTranscript lct2 = new LiveChatTranscript();
        lct2.LiveChatVisitorId = lcv.Id;
        lct2.Body = chatBody2;
        lct2.List_Agent__c = 'Taufik Susanto';
        lct2.TriggerOff__c = FALSE;
        lct2.Status = 'Completed';
        lct2.RequestTime = datetime.now();
        lct2.StartTime = datetime.now();
        insert lct2;
        
        LiveChatTranscript lct3 = new LiveChatTranscript();
        lct3.LiveChatVisitorId = lcv.Id;
        lct3.Body = chatBody3;
        lct3.List_Agent__c = 'Suryono';
        lct3.TriggerOff__c = FALSE;
        lct3.Status = 'Completed';
        lct3.RequestTime = datetime.now();
        lct3.StartTime = datetime.now();
        insert lct3;
    }
    
    private static testMethod void runUpdateTranscript_1() {
        LIst<LiveChatTranscript> currentLCT1 = [SELECT Id, Body, List_Agent__c, TriggerOff__c FROM LiveChatTranscript WHERE List_Agent__c = '' and RequestTime != NULL LIMIT 1];
        update currentLCT1;
    }
    
    private static testMethod void runUpdateTranscript_2() {
        LIst<LiveChatTranscript> currentLCT2 = [SELECT Id, Body, List_Agent__c, TriggerOff__c FROM LiveChatTranscript WHERE List_Agent__c = 'Taufik Susanto' and RequestTime != NULL LIMIT 1];
        update currentLCT2;
    }
    
    private static testMethod void runUpdateTranscript_3() {
        LIst<LiveChatTranscript> currentLCT3 = [SELECT Id, Body, List_Agent__c, TriggerOff__c FROM LiveChatTranscript WHERE List_Agent__c = 'Suryono' and RequestTime != NULL LIMIT 1];
        update currentLCT3;
    }
    
    
    
    
    
    
    /*private static testMethod void TestData() {
        Test.startTest();
        LiveChatTranscript lct = [SELECT id FROM LiveChatTranscript WHERE Status = 'Missed' limit 1];
        
        update lct;

        LiveChatTranscript lct2 = [SELECT id, Body, TriggerOff__c FROM LiveChatTranscript WHERE ChatDuration > 100 and Skill.DeveloperName = 'ALI' and List_Agent__c != NULL and TriggerOff__c = FALSE AND Status = 'Completed' Limit 1];
        
        lct2.TriggerOff__c = FALSE;
lct2.Body += '</p>\n';
        
lct2.Body += 'Chat Started: Friday, February 15, 2019, 16:48:24 (+0700) <br>';

lct2.Body += 'Chat Origin: Chat_ALI <br>';

lct2.Body += 'Agent AXA Financial Indonesia <br>';

lct2.Body += '( 1m 37s ) AXA Financial Indonesia: Selamat datang di live chat AXA Financial Indonesia. Nama saya Ramadhan Ada yang bisa saya bantu? <br>';
lct2.Body += '( 2m 26s ) Sophia Sung: Saya mau tanya mengenai polis2 yang langsung di deduct lewat kartu kredit BCA <br>';
lct2.Body += '( 3m 6s ) AXA Financial Indonesia: selamat sore, ada yang bisa kami bantu <br>';
lct2.Body += '( 4m 9s ) Sophia Sung: Sore. <br>';
lct2.Body += '( 4m 31s ) Sophia Sung: Jadi saya ada 4 Polis yang setiap bulan di tagih lewat kartu kredit BCA <br>';
lct2.Body += '( 5m 5s ) Sophia Sung: Cuman saya agak bingung ini Polis buat apa? Karena tidak pernah terima buku AXA <br>';
lct2.Body += '( 7m 22s ) AXA Financial Indonesia: kami informasikan untuk polis dengan nomor 1030401-0899044 , 1030401-0899064 , 1030401-0899073 dan 1030401-0899083 , polis kami kirimkan berupa E policy ke alamat email SOPHIASUNG1107@YAHOO.COM pada tanggal 14/02/2017 . polis tersebut dengan program Hospital Plus Life, yang aktif sejak tanggal 13/02/2017 . program Hospital Plus Life, merupakan Asuransi kesehatan dan jiwa murni dengan masa program selama 12 tahun, tetapi cukup bayar premi di tahun ke 1-4 saja, tahun ke 5-12 gratis/bebas premi. Tahun ke 1-4 kesehatan dan jiwa yang kami cover, tahun ke 5-12 hanya jiwa nya saja, klaim atau tidak pernah klaim kesehatan dan polis aktif sampai akhir masa pertanggungan maka untuk premi yang terdebet akan kembali 100% di akhir tahun ke 12. <br>';
lct2.Body += '( 10m 29s ) Sophia Sung: Ok jadi tahun ini sudah tahun ke 2 <br>';
lct2.Body += '( 11m 55s ) AXA Financial Indonesia: benar bu, aktifnya polis 13/02/2017, saat ini sudah masuk tahun ke 2. <br>';
lct2.Body += '( 12m 17s ) Sophia Sung: Bagaimana kita klaim kembali 100% di akhir tahun ke 12? <br>';
lct2.Body += '( 12m 51s ) AXA Financial Indonesia: di akhir tahun ke 12 nanti ada notifikasi melalui email atau sms bu ke nomor yang sudah terdaftar pada polis tersebut. <br>';
lct2.Body += '( 14m 0s ) Sophia Sung: Oh ok terima kasih. Sophia <br>';
lct2.Body += '( 14m 32s ) AXA Financial Indonesia: baik Ibu sophia, terima kasih kembali <br>';

        update lct2;

        Transcript_Chat__c tc = [SELECT id, Live_Chat_Transcript__c FROM Transcript_Chat__c LIMIT 1];
        
        LiveChatTranscript lct3 = [SELECT id, Body, TriggerOff__c FROM LiveChatTranscript WHERE id =: tc.Live_Chat_Transcript__c ];
        update lct3;
                
        Test.stopTest();

    }*/
}