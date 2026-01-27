/*----------------------------------------
* @author 	Ranti Dwi Putri <rdpranntiii@gmail.com>
* @desc 	Test class CaseBeforeUpdate
* -------------------------------------- */
@isTest
public class caseBeforeUpdate_Test {
    
    public static Id AfiInquiry = Schema.SObjectType.Case.getRecordTypeInfosByName().get('InquiryAFICase').getRecordTypeId();
    public static Id AliInquiry = Schema.SObjectType.Case.getRecordTypeInfosByName().get('InquiryALICase').getRecordTypeId();
    public static Id AmfsInquiry = Schema.SObjectType.Case.getRecordTypeInfosByName().get('InquiryAMFSCase').getRecordTypeId(); 
    public static Id AfiComplaint = Schema.SObjectType.Case.getRecordTypeInfosByName().get('AFIComplaintCase').getRecordTypeId();
    public static Id AmfsComplaint = Schema.SObjectType.Case.getRecordTypeInfosByName().get('AMFSComplaintCase').getRecordTypeId();
    public static Id ALIComplaint = Schema.SObjectType.Case.getRecordTypeInfosByName().get('ALIComplaintCase').getRecordTypeId();
    public static Id AfiRequest = Schema.SObjectType.Case.getRecordTypeInfosByName().get('RequestAFICase').getRecordTypeId();
    public static Id AmfsRequest = Schema.SObjectType.Case.getRecordTypeInfosByName().get('RequestAMFSCase').getRecordTypeId();
    public static Id ALIRequest = Schema.SObjectType.Case.getRecordTypeInfosByName().get('RequestALICase').getRecordTypeId();
    
    
    public static testmethod void testCaseRequestAMFS() { 
        Test.startTest(); 
                
        //Insert Account
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Entity__c = 'AMFS';
        Insert acc;
        
        Contact con1 = new Contact();
        con1.FirstName = 'Testing';
        con1.LastName = '123';
        con1.Policy_No__c = '365-7298157';
        con1.MobilePhone = '081122334455';
        con1.Entity__c = 'AMFS';
        con1.AccountId = acc.id;
        insert con1;
        
        case cs = new case(); 
        cs = new Case();
        cs.contactId = con1.id;
        cs.Status = 'New';
        cs.type = 'Request';
        cs.Priority = 'Medium';
        cs.Service_Type__c = null;
        cs.origin = 'phone';
        cs.Case_Type_Config__c = 'Claims';
        cs.Subject = 'TEST';
        cs.Description = 'Ini TEST';
        cs.PIC_Department_LU__c = UserInfo.getUserId(); 
        cs.Waktu_Kejadian__c = null;
        cs.Detail_of_Claim_Damage__c = null;
        cs.Accident_Place_Claim__c	 = null;
        cs.Lokasi_Survey__c = null;
        cs.Coverage__c = null;
        cs.Bengkel__c = null;
        cs.Driver_of_claim__c	= null;
        cs.Vehicle_Registration_Number__c = null;
        cs.Internal_Comment__c = null;
        cs.accountId = acc.id;
        cs.recordTypeId = AmfsRequest;
        cs.createdbyId = UserInfo.getUserId(); 
        
        insert cs;
        
        Test.stopTest();
    }
    public static testmethod void testCaseRequestAFI() { 
        Test.startTest();        
        
        //Insert Account
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Entity__c = 'AFI';
        Insert acc;
        
        Contact con1 = new Contact();
        con1.FirstName = 'Testing';
        con1.LastName = '123';
        con1.Policy_No__c = '365-7298157';
        con1.MobilePhone = '081122334455';
        con1.Entity__c = 'AFI';
        con1.AccountId = acc.id;
        insert con1;
        
        case cs = new case(); 
        cs = new Case();
        cs.contactId = con1.id;
        cs.Status = 'New';
        cs.entity_backup__c = 'AFI';
        cs.type = 'Request';
        cs.Priority = 'Medium';
        cs.Service_Type__c = 'Helpline';
        cs.origin = 'phone';
        cs.Case_Type_Config__c = 'Claims';
        cs.Subject = 'TEST';
        cs.Description = 'Ini TEST';
        cs.PIC_Department_LU__c = UserInfo.getUserId(); 
        cs.Waktu_Kejadian__c = null;
        cs.Detail_of_Claim_Damage__c = null;
        cs.Accident_Place_Claim__c	 = null;
        cs.Lokasi_Survey__c = null;
        cs.Coverage__c = null;
        cs.Bengkel__c = null;
        cs.Driver_of_claim__c	= null;
        cs.Vehicle_Registration_Number__c = null;
        cs.Internal_Comment__c = null;
        cs.accountId = acc.id;
        cs.recordTypeId = AfiRequest;
        cs.createdbyId = UserInfo.getUserId(); 
        insert cs;
        
        Test.stopTest();
    }
    public static testmethod void testCaseRequestALI() { 
        Test.startTest();        
        //Insert Account
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Entity__c = 'AMFS';
        Insert acc;
        
        Contact con1 = new Contact();
        con1.FirstName = 'Testing';
        con1.LastName = '123';
        con1.Policy_No__c = '365-7298157';
        con1.MobilePhone = '081122334455';
        con1.Entity__c = 'AMFS';
        con1.AccountId = acc.id;
        insert con1;
        
        case cs = new case(); 
        cs = new Case();
        cs.entity_backup__c = 'ALI';
        cs.contactId = con1.id;
        cs.Status = 'New';
        cs.type = 'Request';
        cs.Priority = 'Medium';
        cs.Service_Type__c = 'Helpline';
        cs.origin = 'phone';
        cs.Case_Type_Config__c = 'Claims';
        cs.Subject = 'TEST';
        cs.Description = 'Ini TEST';
        cs.PIC_Department_LU__c = UserInfo.getUserId(); 
        cs.Waktu_Kejadian__c = null;
        cs.Detail_of_Claim_Damage__c = null;
        cs.Accident_Place_Claim__c	 = null;
        cs.Lokasi_Survey__c = null;
        cs.Coverage__c = null;
        cs.Bengkel__c = null;
        cs.Driver_of_claim__c	= null;
        cs.Vehicle_Registration_Number__c = null;
        cs.Internal_Comment__c = null;
        cs.accountId = acc.id;
        cs.recordTypeId = ALIRequest;
        cs.createdbyId = UserInfo.getUserId(); 
        insert cs;
        
        
        Test.stopTest();
    }
    
    public static testmethod void testCaseInquiryAMFS() { 
        Test.startTest();        
        
        //Insert Account
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Entity__c = 'AMFS';
        Insert acc;
        
        Contact con1 = new Contact();
        con1.FirstName = 'Testing';
        con1.LastName = '123';
        con1.Policy_No__c = '365-7298157';
        con1.MobilePhone = '081122334455';
        con1.Entity__c = 'AMFS';
        con1.AccountId = acc.id;
        insert con1;
        
        case cs = new case(); 
        cs = new Case();
        cs.contactId = con1.id;
        cs.Status = 'New';
        cs.type = 'Inquiry';
        cs.Priority = 'Medium';
        cs.Service_Type__c = null;
        cs.origin = 'phone';
        cs.Case_Type_Config__c = 'Claims';
        cs.Subject = 'TEST';
        cs.Description = 'Ini TEST';
        cs.PIC_Department_LU__c = UserInfo.getUserId(); 
        cs.Waktu_Kejadian__c = null;
        cs.Detail_of_Claim_Damage__c = null;
        cs.Accident_Place_Claim__c	 = null;
        cs.Lokasi_Survey__c = null;
        cs.Coverage__c = null;
        cs.Bengkel__c = null;
        cs.Driver_of_claim__c	= null;
        cs.Vehicle_Registration_Number__c = null;
        cs.Internal_Comment__c = null;
        cs.accountId = acc.id;
        cs.recordTypeId = AmfsInquiry;
        cs.createdbyId = UserInfo.getUserId(); 
        insert cs;         	
        Test.stopTest();
    }
    
    public static testmethod void testCaseInquiryAFIServiceTypeHelpline() {  
        Test.startTest();         
        //Insert Account
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Entity__c = 'AFI';
        Insert acc;
        
        Contact con1 = new Contact();
        con1.FirstName = 'Testing';
        con1.LastName = '123';
        con1.Policy_No__c = '365-7298157';
        con1.MobilePhone = '081122334455';
        con1.Entity__c = 'AFI';
        con1.AccountId = acc.id;
        insert con1; 
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = system.Label.HelplineEmail_AFI_ALI;
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = UserInfo.getUserId(); 
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList; 
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3"><font face = "calibri" font color="black" font size=2px>Kepada Bapak/Ibu [CONTACT_NAME] Yang Terhormat, <br/><br/>Terima kasih atas kepercayaan Anda kepada AXA Financial Indonesia sebagai mitra perlindungan jiwa bagi Anda dan keluarga. Pertanyaan dan permasalahan yang Anda sampaikan melalui email akan segera kami pelajari.<br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] hingga [END_DATE_ID]  layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br><br><b> PT AXA Financial Indonesia</b> <br><br>Call Center : <b>1500945</b> (kemudian tekan 1 untuk Agent dan tekan 2 untuk SOE   ) [START_DATE_EN]  [END_DATE_EN]  <br/>Email : <a href="mailto:helpline@axa-financial.co.id"><b>helpline@axa-financial.co.id</a></b><br><br>Jam Operasional [ACTIVE_DATE_EN]  Customer Care : Senin – Jumat pukul 08.00 – 17.00 WIB (tidak beroperasi di Sabtu Minggu dan Hari Libur Nasional)<br><br><br><img src= "https://axaid-ccc--c.ap11.content.force.com/servlet/servlet.ImageServer?id=0152s000000MPAt&oid=00D90000000zAlz&lastMod=1612940455000" width="600"/><br><br><b><br>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3"><font face = "calibri" font color="black" font size=2px>Kepada Bapak/Ibu [CONTACT_NAME] Yang Terhormat, <br/><br/>Terima kasih atas kepercayaan Anda kepada AXA Financial Indonesia sebagai mitra perlindungan jiwa bagi Anda dan keluarga. Pertanyaan dan permasalahan yang Anda sampaikan melalui email akan segera kami pelajari.<br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] hingga [END_DATE_ID]  layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br><br><b> PT AXA Financial Indonesia</b> <br><br>Call Center : <b>1500945</b> (kemudian tekan 1 untuk Agent dan tekan 2 untuk SOE   ) [START_DATE_EN]  [END_DATE_EN]  <br/>Email : <a href="mailto:helpline@axa-financial.co.id"><b>helpline@axa-financial.co.id</a></b><br><br>Jam Operasional [ACTIVE_DATE_EN]  Customer Care : Senin – Jumat pukul 08.00 – 17.00 WIB (tidak beroperasi di Sabtu Minggu dan Hari Libur Nasional)<br><br><br><img src= "https://axaid-ccc--c.ap11.content.force.com/servlet/servlet.ImageServer?id=0152s000000MPAt&oid=00D90000000zAlz&lastMod=1612940455000" width="600"/><br><br><b><br>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Helpline';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        /* mh.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
mh.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
mh.Active_Date__c = date.newInstance(2019, 12, 14); */ 
        
        
        mh.Start_Date_Time__c = System.now().addDays(-1);
        mh.End_Date_Time__c = System.now().addDays(3);
        mh.Active_Date__c = System.today().addDays(4);
        
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Helpline';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        /* mh2.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
mh2.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
mh2.Active_Date__c = date.newInstance(2019, 12, 14);*/
        
        
        
        mh2.Start_Date_Time__c = System.now().addDays(-1);
        mh2.End_Date_Time__c = System.now().addDays(3);
        mh2.Active_Date__c = System.today().addDays(4);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        Master_Holiday__c mh3 = new Master_Holiday__c();
        mh3.Name = 'Tes Master Holiday 3';
        mh3.Entity__c = 'AFI';
        mh3.Service_Type__c = 'Helpline';
        mh3.Type__c = 'Weekday';
        mh3.Description_ID__c = 'Tes Master Holiday 3';
        mh3.Description_EN__c = 'Tes Master Holiday 3';
        //mh3.Email_SMS_Template__c = listest[1].id;
        mh3.Email_SMS_Template__c = est2.id;
        mh3.Start_Date_Time__c = null;
        mh3.End_Date_Time__c = null;
        mh3.Active_Date__c = null;
        mh3.Email_Header__c = est2.Email_Header__c;
        mh3.Email_Body__c = est2.Email_Body__c;
        mh3.Email_Footer__c = est2.Email_Footer__c;
        mh3.Description_ID__c = 'Ada Peristiwa';
        mh3.Description_ID__c = 'There are Event';
        insert mh3;
        
        
        
        case cs = new case(); 
        cs = new Case();
        cs.contactId = con1.id;
        cs.Status = 'New';
        cs.type = 'Inquiry';
        cs.Priority = 'Medium';
        cs.Service_Type__c = null;
        cs.origin = 'phone';
        cs.entity_backup__c = 'AFI';
        cs.Case_Type_Config__c = 'Claims';
        cs.Subject = 'TEST';
        cs.Description = 'Ini TEST';
        cs.PIC_Department_LU__c = UserInfo.getUserId(); 
        cs.Waktu_Kejadian__c = null;
        cs.Detail_of_Claim_Damage__c = null;
        cs.Accident_Place_Claim__c	 = null;
        cs.Lokasi_Survey__c = null;
        cs.Coverage__c = null;
        cs.Bengkel__c = null;
        cs.Driver_of_claim__c	= null;
        cs.Vehicle_Registration_Number__c = null;
        cs.Internal_Comment__c = null;
        cs.accountId = acc.id;
        cs.recordTypeId = AfiInquiry;
        cs.createdbyId = UserInfo.getUserId();
        cs.Email_Inbox__c = system.Label.HelplineEmail_AFI_ALI;
        cs.e2cEmailToAddress__c  = system.Label.HelplineEmail_AFI_ALI;
        insert cs;         	
        
        EmailMessage emailMsg = new EmailMessage();
        emailMsg.FromAddress = 'testafi@abc.org'; 
        emailMsg.Incoming = true; 
        emailMsg.ToAddress= system.Label.HelplineEmail_AFI_ALI;
        emailMsg.Headers = system.Label.HelplineEmail_AFI_ALI;
        emailMsg.CCAddress = 'testing123@yahoo.com'; 
        emailMsg.MessageDate = system.today(); 
        emailMsg.Subject = ''; 
        emailMsg.TextBody = '23456'; 
        emailMsg.ParentId = cs.id; 
        insert emailMsg;
        Test.stopTest();
    }
    
    
    public static testmethod void testCaseInquiryAFIServiceTypeCustomer() {  
        Test.startTest();         
        //Insert Account
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Entity__c = 'AFI';
        Insert acc;
        
        Contact con1 = new Contact();
        con1.FirstName = 'Testing';
        con1.LastName = '123';
        con1.Policy_No__c = '365-7298157';
        con1.MobilePhone = '081122334455';
        con1.Entity__c = 'AFI';
        con1.AccountId = acc.id;
        insert con1; 
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = system.Label.CustomerEmail_AFI_ALI;
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = UserInfo.getUserId(); 
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList; 
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3"><font face = "calibri" font color="black" font size=2px>Kepada Bapak/Ibu [CONTACT_NAME] Yang Terhormat, <br/><br/>Terima kasih atas kepercayaan Anda kepada AXA Financial Indonesia sebagai mitra perlindungan jiwa bagi Anda dan keluarga. Pertanyaan dan permasalahan yang Anda sampaikan melalui email akan segera kami pelajari.<br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] hingga [END_DATE_ID]  layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br><br><b> PT AXA Financial Indonesia</b> <br><br>Call Center : <b>1500945</b> (kemudian tekan 1 untuk Agent dan tekan 2 untuk SOE   ) [START_DATE_EN]  [END_DATE_EN]  <br/>Email : <a href="mailto:helpline@axa-financial.co.id"><b>helpline@axa-financial.co.id</a></b><br><br>Jam Operasional [ACTIVE_DATE_EN]  Customer Care : Senin – Jumat pukul 08.00 – 17.00 WIB (tidak beroperasi di Sabtu Minggu dan Hari Libur Nasional)<br><br><br><img src= "https://axaid-ccc--c.ap11.content.force.com/servlet/servlet.ImageServer?id=0152s000000MPAt&oid=00D90000000zAlz&lastMod=1612940455000" width="600"/><br><br><b><br>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3"><font face = "calibri" font color="black" font size=2px>Kepada Bapak/Ibu [CONTACT_NAME] Yang Terhormat, <br/><br/>Terima kasih atas kepercayaan Anda kepada AXA Financial Indonesia sebagai mitra perlindungan jiwa bagi Anda dan keluarga. Pertanyaan dan permasalahan yang Anda sampaikan melalui email akan segera kami pelajari.<br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] hingga [END_DATE_ID]  layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br><br><b> PT AXA Financial Indonesia</b> <br><br>Call Center : <b>1500945</b> (kemudian tekan 1 untuk Agent dan tekan 2 untuk SOE   ) [START_DATE_EN]  [END_DATE_EN]  <br/>Email : <a href="mailto:helpline@axa-financial.co.id"><b>helpline@axa-financial.co.id</a></b><br><br>Jam Operasional [ACTIVE_DATE_EN]  Customer Care : Senin – Jumat pukul 08.00 – 17.00 WIB (tidak beroperasi di Sabtu Minggu dan Hari Libur Nasional)<br><br><br><img src= "https://axaid-ccc--c.ap11.content.force.com/servlet/servlet.ImageServer?id=0152s000000MPAt&oid=00D90000000zAlz&lastMod=1612940455000" width="600"/><br><br><b><br>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Customer AFI';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = system.today();
        mh.End_Date_Time__c = system.today();
        mh.Active_Date__c = system.today();
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Customer AFI';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        /*mh2.Email_SMS_Template__c = est2.id;
mh2.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
mh2.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
mh2.Active_Date__c = date.newInstance(2019, 12, 14);*/
        
        mh2.Start_Date_Time__c = System.now().addDays(-1);
        mh2.End_Date_Time__c = System.now().addDays(3);
        mh2.Active_Date__c = System.today().addDays(4);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        Master_Holiday__c mh3 = new Master_Holiday__c();
        mh3.Name = 'Tes Master Holiday 3';
        mh3.Entity__c = 'AFI';
        mh3.Service_Type__c = 'Customer AFI';
        mh3.Type__c = 'Weekday';
        mh3.Description_ID__c = 'Tes Master Holiday 3';
        mh3.Description_EN__c = 'Tes Master Holiday 3';
        //mh3.Email_SMS_Template__c = listest[1].id;
        mh3.Email_SMS_Template__c = est2.id;
        mh3.Start_Date_Time__c = null;
        mh3.End_Date_Time__c = null;
        mh3.Active_Date__c = null;
        mh3.Email_Header__c = est2.Email_Header__c;
        mh3.Email_Body__c = est2.Email_Body__c;
        mh3.Email_Footer__c = est2.Email_Footer__c;
        mh3.Description_ID__c = 'Ada Peristiwa';
        mh3.Description_ID__c = 'There are Event';
        insert mh3;
        
        
        
        case cs = new case(); 
        cs = new Case();
        cs.contactId = con1.id;
        cs.Status = 'New';
        cs.type = 'Inquiry';
        cs.Priority = 'Medium';
        cs.Service_Type__c = null;
        cs.origin = 'phone';
        cs.entity_backup__c = 'AFI';
        cs.Case_Type_Config__c = 'Claims';
        cs.Subject = 'TEST';
        cs.Description = 'Ini TEST';
        cs.PIC_Department_LU__c = UserInfo.getUserId(); 
        cs.Waktu_Kejadian__c = null;
        cs.Detail_of_Claim_Damage__c = null;
        cs.Accident_Place_Claim__c	 = null;
        cs.Lokasi_Survey__c = null;
        cs.Coverage__c = null;
        cs.Bengkel__c = null;
        cs.Driver_of_claim__c	= null;
        cs.Vehicle_Registration_Number__c = null;
        cs.Internal_Comment__c = null;
        cs.accountId = acc.id;
        cs.recordTypeId = AfiInquiry;
        cs.createdbyId = UserInfo.getUserId(); 
        cs.Email_Inbox__c = system.Label.CustomerEmail_AFI_ALI;
        cs.e2cEmailToAddress__c  = system.Label.CustomerEmail_AFI_ALI;
        // cs.Assignment_Rules__c = true; 
        insert cs;         	
        
        EmailMessage emailMsg = new EmailMessage();
        emailMsg.FromAddress = 'testafi@abc.org'; 
        emailMsg.Incoming = true; 
        emailMsg.ToAddress= system.Label.CustomerEmail_AFI_ALI;
        emailMsg.Headers = system.Label.CustomerEmail_AFI_ALI;
        emailMsg.CCAddress = 'testing123@yahoo.com';  
        emailMsg.MessageDate = system.today();
        emailMsg.Subject = 'Tes'; 
        emailMsg.TextBody = '23456'; 
        emailMsg.ParentId = cs.id; 
        insert emailMsg;   
        Test.stopTest();
    }     
    
    public static testmethod void testCaseInquiryAFIServiceTypeCustomer2() {  
        Test.startTest();         
        //Insert Account
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Entity__c = 'AFI';
        Insert acc;
        
        Contact con1 = new Contact();
        con1.FirstName = 'Testing';
        con1.LastName = '123';
        con1.Policy_No__c = '365-7298157';
        con1.MobilePhone = '081122334455';
        con1.Entity__c = 'AFI';
        con1.AccountId = acc.id;
        insert con1; 
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = system.Label.CustomerEmail_AFI_ALI;
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = UserInfo.getUserId(); 
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList; 
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3"><font face = "calibri" font color="black" font size=2px>Kepada Bapak/Ibu [CONTACT_NAME] Yang Terhormat, <br/><br/>Terima kasih atas kepercayaan Anda kepada AXA Financial Indonesia sebagai mitra perlindungan jiwa bagi Anda dan keluarga. Pertanyaan dan permasalahan yang Anda sampaikan melalui email akan segera kami pelajari.<br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] hingga [END_DATE_ID]  layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br><br><b> PT AXA Financial Indonesia</b> <br><br>Call Center : <b>1500945</b> (kemudian tekan 1 untuk Agent dan tekan 2 untuk SOE   ) [START_DATE_EN]  [END_DATE_EN]  <br/>Email : <a href="mailto:helpline@axa-financial.co.id"><b>helpline@axa-financial.co.id</a></b><br><br>Jam Operasional [ACTIVE_DATE_EN]  Customer Care : Senin – Jumat pukul 08.00 – 17.00 WIB (tidak beroperasi di Sabtu Minggu dan Hari Libur Nasional)<br><br><br><img src= "https://axaid-ccc--c.ap11.content.force.com/servlet/servlet.ImageServer?id=0152s000000MPAt&oid=00D90000000zAlz&lastMod=1612940455000" width="600"/><br><br><b><br>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3"><font face = "calibri" font color="black" font size=2px>Kepada Bapak/Ibu [CONTACT_NAME] Yang Terhormat, <br/><br/>Terima kasih atas kepercayaan Anda kepada AXA Financial Indonesia sebagai mitra perlindungan jiwa bagi Anda dan keluarga. Pertanyaan dan permasalahan yang Anda sampaikan melalui email akan segera kami pelajari.<br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] hingga [END_DATE_ID]  layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br><br><b> PT AXA Financial Indonesia</b> <br><br>Call Center : <b>1500945</b> (kemudian tekan 1 untuk Agent dan tekan 2 untuk SOE   ) [START_DATE_EN]  [END_DATE_EN]  <br/>Email : <a href="mailto:helpline@axa-financial.co.id"><b>helpline@axa-financial.co.id</a></b><br><br>Jam Operasional [ACTIVE_DATE_EN]  Customer Care : Senin – Jumat pukul 08.00 – 17.00 WIB (tidak beroperasi di Sabtu Minggu dan Hari Libur Nasional)<br><br><br><img src= "https://axaid-ccc--c.ap11.content.force.com/servlet/servlet.ImageServer?id=0152s000000MPAt&oid=00D90000000zAlz&lastMod=1612940455000" width="600"/><br><br><b><br>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Customer AFI';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = system.today();
        mh.End_Date_Time__c = system.today();
        mh.Active_Date__c = system.today();
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Customer AFI';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        /*mh2.Email_SMS_Template__c = est2.id;
mh2.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
mh2.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
mh2.Active_Date__c = date.newInstance(2019, 12, 14);*/
        
        mh2.Start_Date_Time__c = System.now().addDays(-1);
        mh2.End_Date_Time__c = System.now().addDays(3);
        mh2.Active_Date__c = System.today().addDays(4);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        Master_Holiday__c mh3 = new Master_Holiday__c();
        mh3.Name = 'Tes Master Holiday 3';
        mh3.Entity__c = 'AFI';
        mh3.Service_Type__c = 'Customer AFI';
        mh3.Type__c = 'Weekday';
        mh3.Description_ID__c = 'Tes Master Holiday 3';
        mh3.Description_EN__c = 'Tes Master Holiday 3';
        //mh3.Email_SMS_Template__c = listest[1].id;
        mh3.Email_SMS_Template__c = est2.id;
        mh3.Start_Date_Time__c = null;
        mh3.End_Date_Time__c = null;
        mh3.Active_Date__c = null;
        mh3.Email_Header__c = est2.Email_Header__c;
        mh3.Email_Body__c = est2.Email_Body__c;
        mh3.Email_Footer__c = est2.Email_Footer__c;
        mh3.Description_ID__c = 'Ada Peristiwa';
        mh3.Description_ID__c = 'There are Event';
        insert mh3;
        
        
        
        case cs = new case(); 
        cs = new Case();
        cs.contactId = con1.id;
        cs.Status = 'New';
        cs.type = 'Inquiry';
        cs.Priority = 'Medium';
        cs.Service_Type__c = null;
        cs.origin = 'Email';
        cs.entity_backup__c = 'AFI';
        cs.Case_Type_Config__c = 'Claims';
        cs.Subject = 'TEST';
        cs.Description = 'Ini TEST';
        cs.PIC_Department_LU__c = UserInfo.getUserId(); 
        cs.Waktu_Kejadian__c = null;
        cs.Detail_of_Claim_Damage__c = null;
        cs.Accident_Place_Claim__c	 = null;
        cs.Lokasi_Survey__c = null;
        cs.Coverage__c = null;
        cs.Bengkel__c = null;
        cs.Driver_of_claim__c	= null;
        cs.Vehicle_Registration_Number__c = null;
        cs.Internal_Comment__c = null;
        cs.accountId = acc.id;
        cs.recordTypeId = AfiInquiry;
        cs.createdbyId = UserInfo.getUserId(); 
        cs.Email_Inbox__c = system.Label.CustomerEmail_AFI_ALI;
        cs.e2cEmailToAddress__c  = system.Label.CustomerEmail_AFI_ALI;
        cs.Assignment_Rules__c = true; 
        insert cs;         	
        
        EmailMessage emailMsg = new EmailMessage();
        emailMsg.FromAddress = 'testafi@abc.org'; 
        emailMsg.Incoming = true; 
        emailMsg.ToAddress= 'noreplydummy8@gmail.com';
        emailMsg.Headers = system.Label.CustomerEmail_AFI_ALI;
        emailMsg.CCAddress = 'testing123@yahoo.com';  
        emailMsg.MessageDate = system.today();
        emailMsg.Subject = 'Tes'; 
        emailMsg.TextBody = '23456'; 
        emailMsg.ParentId = cs.id; 
        insert emailMsg;   
        Test.stopTest();
    }    
    
    public static testmethod void testCaseInquiryAFIServiceTypeCustomer3() {  
        Test.startTest();         
        //Insert Account
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Entity__c = 'AFI';
        Insert acc;
        
        Contact con1 = new Contact();
        con1.FirstName = 'Testing';
        con1.LastName = '123';
        con1.Policy_No__c = '365-7298157';
        con1.MobilePhone = '081122334455';
        con1.Entity__c = 'AFI';
        con1.AccountId = acc.id;
        insert con1; 
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = system.Label.CustomerEmail_AFI_ALI;
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = UserInfo.getUserId(); 
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList; 
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3"><font face = "calibri" font color="black" font size=2px>Kepada Bapak/Ibu [CONTACT_NAME] Yang Terhormat, <br/><br/>Terima kasih atas kepercayaan Anda kepada AXA Financial Indonesia sebagai mitra perlindungan jiwa bagi Anda dan keluarga. Pertanyaan dan permasalahan yang Anda sampaikan melalui email akan segera kami pelajari.<br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] hingga [END_DATE_ID]  layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br><br><b> PT AXA Financial Indonesia</b> <br><br>Call Center : <b>1500945</b> (kemudian tekan 1 untuk Agent dan tekan 2 untuk SOE   ) [START_DATE_EN]  [END_DATE_EN]  <br/>Email : <a href="mailto:helpline@axa-financial.co.id"><b>helpline@axa-financial.co.id</a></b><br><br>Jam Operasional [ACTIVE_DATE_EN]  Customer Care : Senin – Jumat pukul 08.00 – 17.00 WIB (tidak beroperasi di Sabtu Minggu dan Hari Libur Nasional)<br><br><br><img src= "https://axaid-ccc--c.ap11.content.force.com/servlet/servlet.ImageServer?id=0152s000000MPAt&oid=00D90000000zAlz&lastMod=1612940455000" width="600"/><br><br><b><br>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3"><font face = "calibri" font color="black" font size=2px>Kepada Bapak/Ibu [CONTACT_NAME] Yang Terhormat, <br/><br/>Terima kasih atas kepercayaan Anda kepada AXA Financial Indonesia sebagai mitra perlindungan jiwa bagi Anda dan keluarga. Pertanyaan dan permasalahan yang Anda sampaikan melalui email akan segera kami pelajari.<br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] hingga [END_DATE_ID]  layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br><br><b> PT AXA Financial Indonesia</b> <br><br>Call Center : <b>1500945</b> (kemudian tekan 1 untuk Agent dan tekan 2 untuk SOE   ) [START_DATE_EN]  [END_DATE_EN]  <br/>Email : <a href="mailto:helpline@axa-financial.co.id"><b>helpline@axa-financial.co.id</a></b><br><br>Jam Operasional [ACTIVE_DATE_EN]  Customer Care : Senin – Jumat pukul 08.00 – 17.00 WIB (tidak beroperasi di Sabtu Minggu dan Hari Libur Nasional)<br><br><br><img src= "https://axaid-ccc--c.ap11.content.force.com/servlet/servlet.ImageServer?id=0152s000000MPAt&oid=00D90000000zAlz&lastMod=1612940455000" width="600"/><br><br><b><br>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Customer AFI';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = system.today();
        mh.End_Date_Time__c = system.today();
        mh.Active_Date__c = system.today();
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Customer AFI';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        /*mh2.Email_SMS_Template__c = est2.id;
mh2.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
mh2.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
mh2.Active_Date__c = date.newInstance(2019, 12, 14);*/
        
        mh2.Start_Date_Time__c = System.now().addDays(-1);
        mh2.End_Date_Time__c = System.now().addDays(3);
        mh2.Active_Date__c = System.today().addDays(4);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        Master_Holiday__c mh3 = new Master_Holiday__c();
        mh3.Name = 'Tes Master Holiday 3';
        mh3.Entity__c = 'AFI';
        mh3.Service_Type__c = 'Customer AFI';
        mh3.Type__c = 'Weekday';
        mh3.Description_ID__c = 'Tes Master Holiday 3';
        mh3.Description_EN__c = 'Tes Master Holiday 3';
        //mh3.Email_SMS_Template__c = listest[1].id;
        mh3.Email_SMS_Template__c = est2.id;
        mh3.Start_Date_Time__c = null;
        mh3.End_Date_Time__c = null;
        mh3.Active_Date__c = null;
        mh3.Email_Header__c = est2.Email_Header__c;
        mh3.Email_Body__c = est2.Email_Body__c;
        mh3.Email_Footer__c = est2.Email_Footer__c;
        mh3.Description_ID__c = 'Ada Peristiwa';
        mh3.Description_ID__c = 'There are Event';
        insert mh3;
        
        
        List<User> getDataAgent = [Select id from user where Agent__c  = true and isactive = true];
        
        case cs = new case(); 
        cs = new Case();
        cs.contactId = con1.id;
        cs.Status = 'New';
        cs.type = 'Inquiry';
        cs.Priority = 'Medium';
        cs.Service_Type__c = null;
        cs.origin = 'phone';
        cs.entity_backup__c = 'AFI';
        cs.Case_Type_Config__c = 'Claims';
        cs.Subject = 'TEST';
        cs.Description = 'Ini TEST';
        cs.PIC_Department_LU__c = UserInfo.getUserId(); 
        cs.Waktu_Kejadian__c = null;
        cs.Detail_of_Claim_Damage__c = null;
        cs.Accident_Place_Claim__c	 = null;
        cs.Lokasi_Survey__c = null;
        cs.Coverage__c = null;
        cs.Bengkel__c = null;
        cs.Driver_of_claim__c	= null;
        cs.Vehicle_Registration_Number__c = null;
        cs.Internal_Comment__c = null;
        cs.accountId = acc.id;
        cs.recordTypeId = AfiInquiry;
        cs.createdbyId = UserInfo.getUserId(); 
        cs.Email_Inbox__c = system.Label.CustomerEmail_AFI_ALI;
        cs.e2cEmailToAddress__c  = system.Label.CustomerEmail_AFI_ALI; 
        if (getDataAgent.size() > 0) {
            cs.OwnerId  = getDataAgent[0].id;
        }
        // cs.Assignment_Rules__c = true; 
        insert cs;         	
        
        EmailMessage emailMsg = new EmailMessage();
        emailMsg.FromAddress = 'testafi@abc.org'; 
        emailMsg.Incoming = true; 
        emailMsg.ToAddress= system.Label.CustomerEmail_AFI_ALI;
        emailMsg.Headers = system.Label.CustomerEmail_AFI_ALI;
        emailMsg.CCAddress = 'testing123@yahoo.com';  
        emailMsg.MessageDate = system.today();
        emailMsg.Subject = 'Tes';  
        emailMsg.TextBody = '23456'; 
        emailMsg.ParentId = cs.id; 
        emailMsg.Incoming = true;
        insert emailMsg;   
        Test.stopTest();
    }    
    
    
    public static testmethod void testCaseInquiryAFIServiceTypeCustomer4() {  
        Test.startTest();         
        //Insert Account
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Entity__c = 'AFI';
        Insert acc;
        
        Contact con1 = new Contact();
        con1.FirstName = 'Testing';
        con1.LastName = '123';
        con1.Policy_No__c = '365-7298157';
        con1.MobilePhone = '081122334455';
        con1.Entity__c = 'AFI';
        con1.AccountId = acc.id;
        insert con1; 
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = system.Label.CustomerEmail_AFI_ALI;
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = UserInfo.getUserId(); 
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList; 
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3"><font face = "calibri" font color="black" font size=2px>Kepada Bapak/Ibu [CONTACT_NAME] Yang Terhormat, <br/><br/>Terima kasih atas kepercayaan Anda kepada AXA Financial Indonesia sebagai mitra perlindungan jiwa bagi Anda dan keluarga. Pertanyaan dan permasalahan yang Anda sampaikan melalui email akan segera kami pelajari.<br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] hingga [END_DATE_ID]  layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br><br><b> PT AXA Financial Indonesia</b> <br><br>Call Center : <b>1500945</b> (kemudian tekan 1 untuk Agent dan tekan 2 untuk SOE   ) [START_DATE_EN]  [END_DATE_EN]  <br/>Email : <a href="mailto:helpline@axa-financial.co.id"><b>helpline@axa-financial.co.id</a></b><br><br>Jam Operasional [ACTIVE_DATE_EN]  Customer Care : Senin – Jumat pukul 08.00 – 17.00 WIB (tidak beroperasi di Sabtu Minggu dan Hari Libur Nasional)<br><br><br><img src= "https://axaid-ccc--c.ap11.content.force.com/servlet/servlet.ImageServer?id=0152s000000MPAt&oid=00D90000000zAlz&lastMod=1612940455000" width="600"/><br><br><b><br>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3"><font face = "calibri" font color="black" font size=2px>Kepada Bapak/Ibu [CONTACT_NAME] Yang Terhormat, <br/><br/>Terima kasih atas kepercayaan Anda kepada AXA Financial Indonesia sebagai mitra perlindungan jiwa bagi Anda dan keluarga. Pertanyaan dan permasalahan yang Anda sampaikan melalui email akan segera kami pelajari.<br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] hingga [END_DATE_ID]  layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br><br><b> PT AXA Financial Indonesia</b> <br><br>Call Center : <b>1500945</b> (kemudian tekan 1 untuk Agent dan tekan 2 untuk SOE   ) [START_DATE_EN]  [END_DATE_EN]  <br/>Email : <a href="mailto:helpline@axa-financial.co.id"><b>helpline@axa-financial.co.id</a></b><br><br>Jam Operasional [ACTIVE_DATE_EN]  Customer Care : Senin – Jumat pukul 08.00 – 17.00 WIB (tidak beroperasi di Sabtu Minggu dan Hari Libur Nasional)<br><br><br><img src= "https://axaid-ccc--c.ap11.content.force.com/servlet/servlet.ImageServer?id=0152s000000MPAt&oid=00D90000000zAlz&lastMod=1612940455000" width="600"/><br><br><b><br>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Customer AFI';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = system.today();
        mh.End_Date_Time__c = system.today();
        mh.Active_Date__c = system.today();
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Customer AFI';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        /*mh2.Email_SMS_Template__c = est2.id;
mh2.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
mh2.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
mh2.Active_Date__c = date.newInstance(2019, 12, 14);*/
        
        mh2.Start_Date_Time__c = System.now().addDays(-1);
        mh2.End_Date_Time__c = System.now().addDays(3);
        mh2.Active_Date__c = System.today().addDays(4);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        Master_Holiday__c mh3 = new Master_Holiday__c();
        mh3.Name = 'Tes Master Holiday 3';
        mh3.Entity__c = 'AFI';
        mh3.Service_Type__c = 'Customer AFI';
        mh3.Type__c = 'Weekday';
        mh3.Description_ID__c = 'Tes Master Holiday 3';
        mh3.Description_EN__c = 'Tes Master Holiday 3';
        //mh3.Email_SMS_Template__c = listest[1].id;
        mh3.Email_SMS_Template__c = est2.id;
        mh3.Start_Date_Time__c = null;
        mh3.End_Date_Time__c = null;
        mh3.Active_Date__c = null;
        mh3.Email_Header__c = est2.Email_Header__c;
        mh3.Email_Body__c = est2.Email_Body__c;
        mh3.Email_Footer__c = est2.Email_Footer__c;
        mh3.Description_ID__c = 'Ada Peristiwa';
        mh3.Description_ID__c = 'There are Event';
        insert mh3;
        
        
        List<User> getDataAgent = [Select id from user where Agent__c  = true and isactive = true];
        
        case cs = new case(); 
        cs = new Case();
        cs.contactId = con1.id;
        cs.Status = 'New';
        cs.type = 'Inquiry';
        cs.Priority = 'Medium';
        cs.Service_Type__c = null;
        cs.origin = 'Phone';
        cs.entity_backup__c = 'AFI';
        cs.Case_Type_Config__c = 'Claims';
        cs.Subject = 'TEST';
        cs.Description = 'Ini TEST';
        cs.PIC_Department_LU__c = UserInfo.getUserId(); 
        cs.Waktu_Kejadian__c = null;
        cs.Detail_of_Claim_Damage__c = null;
        cs.Accident_Place_Claim__c	 = null;
        cs.Lokasi_Survey__c = null;
        cs.Coverage__c = null;
        cs.Bengkel__c = null;
        cs.Driver_of_claim__c	= null;
        cs.Vehicle_Registration_Number__c = null;
        cs.Internal_Comment__c = null;
        cs.accountId = acc.id;
        cs.recordTypeId = AfiInquiry;
        cs.createdbyId = UserInfo.getUserId(); 
        cs.Email_Inbox__c = system.Label.CustomerEmail_AFI_ALI;
        cs.e2cEmailToAddress__c  = system.Label.CustomerEmail_AFI_ALI; 
        if (getDataAgent.size() > 0) {
            cs.OwnerId  = getDataAgent[0].id;
        }
        cs.Assignment_Rules__c = true; 
        insert cs;         	
        
        EmailMessage emailMsg = new EmailMessage();
        emailMsg.FromAddress = 'testafi@abc.org'; 
        emailMsg.Incoming = true; 
        emailMsg.ToAddress= system.Label.CustomerEmail_AFI_ALI;
        emailMsg.Headers = system.Label.CustomerEmail_AFI_ALI;
        emailMsg.CCAddress = 'testing123@yahoo.com';  
        emailMsg.MessageDate = system.today();
        emailMsg.Subject = 'Tes';  
        emailMsg.TextBody = '23456'; 
        emailMsg.ParentId = cs.id; 
        emailMsg.Incoming = true;
        insert emailMsg;   
        Test.stopTest();
    }    
    
    
    public static testmethod void testCaseInquiryALI() { 
        Test.startTest();        
        
        //Insert Account
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Entity__c = 'ALI';
        Insert acc;
        
        Contact con1 = new Contact();
        con1.FirstName = 'Testing';
        con1.LastName = '123';
        con1.Policy_No__c = '365-7298157';
        con1.MobilePhone = '081122334455';
        con1.Entity__c = 'ALI';
        con1.AccountId = acc.id;
        insert con1;
        
        case cs = new case(); 
        cs = new Case();
        cs.contactId = con1.id;
        cs.Status = 'New';
        cs.type = 'Inquiry';
        cs.entity_backup__c = 'ALI';
        cs.Priority = 'Medium';
        cs.Service_Type__c = null;
        cs.origin = 'phone';
        cs.Case_Type_Config__c = 'Claims';
        cs.Subject = 'TEST';
        cs.Description = 'Ini TEST';
        cs.PIC_Department_LU__c = UserInfo.getUserId(); 
        cs.Waktu_Kejadian__c = null;
        cs.Detail_of_Claim_Damage__c = null;
        cs.Accident_Place_Claim__c	 = null;
        cs.Lokasi_Survey__c = null;
        cs.Coverage__c = null;
        cs.Bengkel__c = null;
        cs.Driver_of_claim__c	= null;
        cs.Vehicle_Registration_Number__c = null;
        cs.Internal_Comment__c = null;
        cs.accountId = acc.id;
        cs.recordTypeId = AliInquiry;
        cs.createdbyId = UserInfo.getUserId(); 
        insert cs;         
        
        Test.stopTest();
    }
    
    public static testmethod void testCaseCollectionAMFS() { 
        Test.startTest();        
        
        Test.stopTest();
    }
    public static testmethod void testCaseCollectionAFI() { 
        Test.startTest();        
        
        Test.stopTest();
    }
    public static testmethod void testCaseCollectionALI() { 
        Test.startTest();        
        
        Test.stopTest();
    }
    
    
    public static testMethod void muTest(){
        
        Test.startTest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        string afiRT = '';
        string amfsRT = '';
        string magiRT = '';
        
        List<RecordType> caseRecordTypeList = [SELECT Name, Id, DeveloperName, SobjectType FROM RecordType where SobjectType = 'Case' and name like 'Inquiry%'];
        for(RecordType rt: caseRecordTypeList){
            if(rt.name.indexof('AFI')!=-1){
                afiRT = rt.Id;  
            }else if(rt.name.indexof('AMFS')!=-1){
                amfsRT = rt.Id; 
            }else if(rt.name.indexof('MAGI')!=-1){
                magiRT = rt.Id; 
            }
        }
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like '%Agent%AFI' limit 1];
        
        List<User> usrList = new List<User>();
        User usr1 = new User(Alias = 'agent1', Email='agent01@axa.co.id', 
                             EmailEncodingKey='UTF-8', LastName='agent01', LanguageLocaleKey='en_US', 
                             LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, Entity__c = 'AFI', 
                             TimeZoneSidKey='Asia/Jakarta', UserName='agent01@axa.co.id', isActive = true);
        usrList.add(usr1);
        User usr3 = new User(Alias = 'agent3', Email='agent03@axa.co.id', 
                             EmailEncodingKey='UTF-8', LastName='agent03', LanguageLocaleKey='en_US', 
                             LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, Entity__c = 'AFI', 
                             TimeZoneSidKey='Asia/Jakarta', UserName='agent03@axa.co.id', isActive = true);
        usrList.add(usr3);
        insert usrList;
        
        List<SLA_Setting__c> slaList = new List<SLA_Setting__c>();
        
        SLA_Setting__c sla2 = new SLA_Setting__c();
        sla2.Case_Type__c = 'Bukti Transfer';
        sla2.Entity__c = 'AFI';
        sla2.Type__c = 'Request';
        sla2.Is_Calendar__c = true;
        sla2.Service_SLA__c = 2;
        sla2.Unit__c = 'Hour';
        sla2.End_Working_Hour__c = 11;
        slaList.add(sla2);
        
        SLA_Setting__c sla3 = new SLA_Setting__c();
        sla3.Entity__c = 'AFI';
        sla3.Type__c = 'Complaint';
        sla3.Is_Calendar__c = false;
        sla3.Service_SLA__c = 2;
        sla3.Unit__c = 'Hour';
        sla3.End_Working_Hour__c = 13;
        sla3.Complaint_Type__c = 'Complex Case';
        slaList.add(sla3);
        
        SLA_Setting__c sla4 = new SLA_Setting__c();
        sla4.Entity__c = 'AFI';
        sla4.Type__c = 'Complaint';
        sla4.Is_Calendar__c = true;
        sla4.Service_SLA__c = 2;
        sla4.Unit__c = 'Hour';
        sla4.End_Working_Hour__c = 16;
        sla4.Complaint_Type__c = 'Complex Case';
        slaList.add(sla4);
        
        insert slaList;
        
        List<Contact> contactList = new List<Contact>();
        
        Contact con1 = new Contact();
        con1.FirstName = 'Hamfree';
        con1.LastName = 'Lantwo';
        contactList.add(con1);
        
        Contact con2 = new Contact();
        con2.FirstName = 'Hamfree';
        con2.LastName = 'Lantu';
        contactList.add(con2);
        
        insert contactList;
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'hamfry.lantoe@gmail.com';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 24;
        ec1.Entity__c = 'AFI';
        ec1.SLA__c = '1';
        ec1.Unit__c = 'Day';
        emailConfigList.add(ec1);
        
        Email_Config__c ec2 = new Email_Config__c();
        ec2.Email_Address__c = 'testo.axa@gmail.com';
        ec2.Distribution_Type__c = 'Automatic';
        ec2.Start_Working_Hour__c = 8;
        ec2.End_Working_Hour__c = 24;
        ec2.Entity__c = 'AFI';
        ec2.SLA__c = '1';
        ec2.Unit__c = 'Day';
        emailConfigList.add(ec2);
        
        Email_Config__c ec3 = new Email_Config__c();
        ec3.Email_Address__c = 'hamfry.4ever@gmail.com';
        ec3.Distribution_Type__c = 'Automatic';
        ec3.Start_Working_Hour__c = 8;
        ec3.End_Working_Hour__c = 14;
        ec3.Entity__c = 'AFI';
        ec3.SLA__c = '1';
        ec3.Unit__c = 'Day';
        emailConfigList.add(ec3);
        
        insert emailConfigList;
        
        
        List<Case> caseList3 = new List<Case>();
        Case cs3 = new Case();
        cs3.Entity_Backup__c = 'AFI';
        cs3.Origin = 'Phone';
        cs3.Status ='New';
        //cs3.ContactId = con2.Id;
        cs3.Subject = 'testing 123';
        cs3.Type = 'Complaint';
        cs3.Complaint_type__c = 'Complex Case';
        cs3.Nature_Config__c = 'Claim';
        cs3.Category_Config__c = 'Claim Delay';
        insert cs3;
        //caseList3.add(cs3);
        
        Case cs4 = new Case();
        cs4.Entity_Backup__c = 'AFI';
        cs4.Origin = 'Email';
        cs4.Status ='New';
        cs4.Subject = 'testing 123';
        cs4.Type = 'Inquiry';
        cs4.Priority = 'Medium';
        cs4.SuppliedEmail = 'testingabc@yahoo.com';
        cs4.Description = 'Testing only';
        cs4.E2CP__AdditionalTo__c = 'hamfry.lantoe@gmail.com;testo.axa@gmail.com;testingabc@yahoo.com';
        cs4.E2CP__AdditionalCC__c = 'hamfry.4ever@gmail.com';
        cs4.e2cEmailTo_New__c = 'hamfry.lantoe@gmail.com;testo.axa@gmail.com';
        cs4.Email_Inbox__c = 'hamfry.lantoe@gmail.com';
        cs4.First_Inbox__c = 'hamfry.lantoe@gmail.com';
        cs4.RecordTypeId = afiRT;
        cs4.Created_Out_Of_Office_Hour__c = false;
        insert cs4;
        //caseList3.add(cs4);
        Test.stopTest();
    }
    
    
    
    public static testMethod void testCaseSkill() {
        
        Test.startTest();
        
        //Added by Hamfry (2015-05-04)
        String caseid = '';
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId(); 
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AMFS';
        con1.Email = 'test1@abc.org';
        con1.MobilePhone = '11111';
        contactList.add(con1);
        insert contactList;
        
        // skillList = [SELECT Name, Last_Order_No__c, Nature__c, Category__c FROM Skill_of_Nature_Category__c WHERE Entity__c=:entityCase AND  Status__c =: 'Active'];
        
        Skill_of_Nature_Category__c skill = new Skill_of_Nature_Category__c();
        skill.Name = 'Skill 1';
        skill.Last_Order_No__c = 1;
        skill.Nature__c = 'All';
        skill.Category__c = 'All';
        skill.Entity__c = 'AMFS';
        skill.Status__c = 'Active';
        insert skill;
        
        //system.runAs(usr){
        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.ContactId = con1.Id;
        case1.RecordTypeId = AmfsInquiry;
        case1.Type = 'Inquiry';  
        caselist.add(case1);
        
        insert caselist;   
        Test.stopTest();
    }
    
    
}