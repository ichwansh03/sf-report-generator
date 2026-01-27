@isTest
public class listAgentChat_Test {
    public static TestMethod void useCase1(){
        Account acc = new Account(Name='Test acc Live Chat'); insert acc;
        contact con = new Contact(LastName='test contact chat', AccountId=acc.Id); insert con;
        
        Case cs = new Case(Subject='test case chat', Origin ='Web', ContactId=con.Id, Chat_Key__c='');
        insert cs;
        DateTime d = DateTime.now();
        Test.setCreatedDate(cs.Id, d);
        
        Case s = [select Id, CreatedDate, ContactId, Origin, Chat_Key__c from Case where Id=:cs.id];
        
        
        LiveChatVisitor lv = new LiveChatVisitor(); 
        try{
            insert lv;
        }catch(exception e){
            System.debug('lv '+lv);
        }
        
        LiveChatTranscript lt = new LiveChatTranscript(LiveChatVisitorId = lv.Id, RequestTime=datetime.now(), StartTime=dateTime.now(), EndTime=dateTime.now(), ContactId = s.ContactId,
                                                      Body='<p>Chat Started: Monday, May 07, 2018, 10:54:45 (+0700)</p><p>Chat Origin: Chat_ALI</p><p>Agent AXA Financial Indonesia</p>\n( 5s ) AXA Financial Indonesia: AXA Financial Indonesia. Selamat datang di live chat AXA Financial Indonesia. Nama saya Gunawan ada yang bisa saya bantu?<br>( 1m 0s ) Fahmi firdausi putri: Saya mau merubah data kartu kredit untuk polis 100-100-0039764 dan 103-427-0002153.<br>( 1m 16s ) AXA Financial Indonesia: baik ibu<br>( 1m 47s ) AXA Financial Indonesia: untuk perubahan data kartu kredit, mohon ibu dapat informasikan data berikut ;<br>( 1m 59s ) AXA Financial Indonesia: Nomor kartu kredit :<br>Masa berlaku kartu :<br>Nama pemegang kartu :<br>( 2m 2s ) Fahmi firdausi putri: Saya sudah kirim email tp blm ada tanggapan<br>( 2m 19s ) AXA Financial Indonesia: mohon maaf atas ketidaknyamanannya<br>( 3m 37s ) Fahmi firdausi putri: Nomor kartu kredit : 4137190304727628<br>Masa berlaku kartu : 10/18<br>Nama pemegang kartu : Fahmi Firdausi Putri<br>( 5m 34s ) AXA Financial Indonesia: untuk perubahan data kartu kredit untuk nomor polis 100-100-0039764 dan 103-427-0002153 akan kami bantu lakukan menjadi dengan nomor kartu 413719######7628 Exp 10/18 tertanggal 07 Mei 2018<br>( 5m 56s ) AXA Financial Indonesia: ada yang dapat kami bantu kembali?<br>( 6m 31s ) Fahmi firdausi putri: Untuk tagihannya perbulan ini atau bulan dpn ya?soalnya saya mau tutup untuk kartu kredit yg sebelumnya<br>( 7m 18s ) AXA Financial Indonesia: untuk nomor polis 100-100-0039764 akan kami bantu lakukan pendebetan tertanggal 09/05/2018 dan untuk nomor polis 103-427-0002153 akan kami bantu lakukan pendebetan tertanggal 11/05/2018<br>( 9m 6s ) Fahmi firdausi putri: Yg 100-100-0039764 sudah saya lunasi td di bank kartu kredit yg sebelumnya. Nah untuk 103-427-0002153 apa bisa lgs didebet ke kartu yg baru?<br>( 9m 38s ) Fahmi firdausi putri: Soalnya td kata CS dr bank sudah ada tagihan 160rb dr axa');
        insert lt;
        
        LiveChatTranscriptEvent le = new LiveChatTranscriptEvent(Type='Accept', LiveChatTranscriptId = lt.Id, Time=dateTime.now(), AgentId=UserInfo.getUserId());
        insert le;
    }
}