@isTest()
public class ChangeOwnerToNonActiveQueue_Batch_Test {
	static testmethod void schedulerTest(){
        Test.StartTest();
        
        Group gr = new Group();
        gr.Name='Group Name Agent AFI Queue';
        gr.Type='Queue';
        insert gr;
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AFI' limit 1];
        
        User userAgentAFI = new User();
        userAgentAFI.Alias = 'spv1';
        userAgentAFI.Email='agentAfi@axa.co.id';
        userAgentAFI.EmailEncodingKey='UTF-8';
        userAgentAFI.LastName='agentAfi';
        userAgentAFI.LanguageLocaleKey='en_US';
        userAgentAFI.LocaleSidKey='en_US';
        userAgentAFI.ProfileId = agentProfileAFI.Id;
        userAgentAFI.Entity__c = 'AFI';
        userAgentAFI.TimeZoneSidKey='Asia/Jakarta';
        userAgentAFI.UserName='agentAfi@axa.co.id';
        userAgentAFI.isActive = TRUE;
        userAgentAFI.Agent__c = TRUE;
        userAgentAFI.Is_Backoffice__c = FALSE;
        userAgentAFI.Agent_Queue_ID_Log_Notification__c = '00G0k000009bOms';	//to CRM2
        //userAgentAFI.Agent_Queue_ID_Log_Notification__c = '00G0k000009bOms';	//to FullSB
        //userAgentAFI.Agent_Queue_ID_Log_Notification__c = '00G0k000009bOms';	//to Production
        insert userAgentAFI;
        
        
        Contact con1 = new Contact();
        con1.FirstName = 'Hamfry';
        con1.LastName = 'Lantu';
        con1.Policy_No__c = '1234-56781';
        insert con1;
        
        Case cs1 = new Case();
        cs1.Status = 'New';
        cs1.Entity_Backup__c = 'AFI';
        cs1.Origin = 'Email';
        cs1.Type = 'Inquiry';
        cs1.OwnerId = userAgentAFI.Id;
        cs1.PIC_Department_LU__c = userAgentAFI.Id;
        cs1.Subject = 'ILCCYS';
        cs1.Email_Status__c = 'Unread';
        cs1.CreatedDate = DateTime.newInstance(2020,2,1);
        cs1.LastModifiedDate = DateTime.newInstance(2020,2,1);
        cs1.RecordTypeId = '01290000000mOgZ';
        cs1.Assignment_Rules__c = TRUE;
        cs1.Update_First_Queue__c = TRUE;
        cs1.Send_Auto_Reply__c = TRUE;
        cs1.Email_Text_Holiday_Weekend__c = '<img src="https://c.ap4.content.force.com/servlet/servlet.ImageServer?id=0156F00000HPeZF&oid=00D90000000zAlz&lastMod=1551859137000" alt="" width="50" /> <br/><br/><br/> <table width="100%"> <tbody> <tr style="height: 117.449px;"> <td style="width: 30%; height: 117.449px;" colspan="3"> Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/> Sehubungan dengan <b> Selamat Hari Mencoba Customer </b> maka pada tanggal 12 Februari 2020 layanan tidak beroperasi.<br/> Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal 4 Maret 2020 atau selambat-lambatnya pada hari kerja berikutnya. <br/><br/> Hormat kami, <br/><br/> Customer Care AXA Financial Indonesia <br/><br/> <i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i> <br/> <br/> </td> </tr> </tbody> </table> <hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /> <table width="100%"> <tbody> <tr style="height: 117.372px;"> <td style="width: 30.0705%; height: 117.372px;" colspan="3"> <br/> Dear sir / madam,<br/><br/><br/> In connection with <b> Happy Trying Customer </b>then on February 12, 2020 the service does not operate.<br/> We will be operating back and responding your email on March 04, 2020 or on the next business day.<br/><br/> Best regards,<br/> AXA Financial Indonesia Customer Care<br/><br/> <i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i> </td> </tr> </tbody> </table> <img src="https://c.ap4.content.force.com/servlet/servlet.ImageServer?id=0156F00000HPeZF&oid=00D90000000zAlz&lastMod=1551859137000" alt="" width="50" /> <br/><br/><br/> <table width="100%"> <tbody> <tr style="height: 117.449px;"> <td style="width: 30%; height: 117.449px;" colspan="3"> Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/> Sehubungan dengan <b> Selamat Hari Mencoba Customer </b> maka pada tanggal 12 Februari 2020 layanan tidak beroperasi.<br/> Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal 4 Maret 2020 atau selambat-lambatnya pada hari kerja berikutnya. <br/><br/> Hormat kami, <br/><br/> Customer Care AXA Financial Indonesia <br/><br/> <i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i> <br/> <br/> </td> </tr> </tbody> </table> <hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /> <table width="100%"> <tbody> <tr style="height: 117.372px;"> <td style="width: 30.0705%; height: 117.372px;" colspan="3"> <br/> Dear sir / madam,<br/><br/><br/> In connection with <b> Happy Trying Customer </b>then on February 12, 2020 the service does not operate.<br/> We will be operating back and responding your email on March 04, 2020 or on the next business day.<br/><br/> Best regards,<br/> AXA Financial Indonesia Customer Care<br/><br/> <i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i> </td> </tr> </tbody> </table>';
        cs1.First_Queue__c = 'AFI - Email Other Queue';
        cs1.First_Queue_ID__c = '00G0k000009TgIbEAK';
        cs1.Email_Inbox__c = system.Label.CustomerEmail_AFI_ALI;
        insert cs1;
        
        
        SchChangeOwnerToNonActiveQueue m = new SchChangeOwnerToNonActiveQueue();
        String sch = '0 0 6 ? * *';
        String jobID = system.schedule('SCHEDULE JOB SchChangeOwnerToNonActiveQueue 2', sch, m);
        Test.stopTest();
    }
    
    static testmethod void schedulerTest2(){
        Test.StartTest();
        
        Group gr = new Group();
        gr.Name='Group Name Agent AFI Queue';
        gr.Type='Queue';
        insert gr;
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AFI' limit 1];
        
        User userAgentAFI = new User();
        userAgentAFI.Alias = 'spv1';
        userAgentAFI.Email='agentAfi@axa.co.id';
        userAgentAFI.EmailEncodingKey='UTF-8';
        userAgentAFI.LastName='agentAfi';
        userAgentAFI.LanguageLocaleKey='en_US';
        userAgentAFI.LocaleSidKey='en_US';
        userAgentAFI.ProfileId = agentProfileAFI.Id;
        userAgentAFI.Entity__c = 'AFI';
        userAgentAFI.TimeZoneSidKey='Asia/Jakarta';
        userAgentAFI.UserName='agentAfi@axa.co.id';
        userAgentAFI.isActive = TRUE;
        userAgentAFI.Agent__c = TRUE;
        userAgentAFI.Is_Backoffice__c = FALSE;
        userAgentAFI.Agent_Queue_ID_Log_Notification__c = '00G0k000009bOms';	//to CRM2
        //userAgentAFI.Agent_Queue_ID_Log_Notification__c = '00G0k000009bOms';	//to FullSB
        //userAgentAFI.Agent_Queue_ID_Log_Notification__c = '00G0k000009bOms';	//to Production
        insert userAgentAFI;
        
        
        Contact con1 = new Contact();
        con1.FirstName = 'Hamfry';
        con1.LastName = 'Lantu';
        con1.Policy_No__c = '1234-56781';
        insert con1;
        
        Case cs1 = new Case();
        cs1.Status = 'New';
        cs1.Entity_Backup__c = 'AFI';
        cs1.Origin = 'Email';
        cs1.Type = 'Inquiry';
        cs1.OwnerId = userAgentAFI.Id;
        cs1.PIC_Department_LU__c = userAgentAFI.Id;
        cs1.Subject = 'ILCCYS';
        cs1.Email_Status__c = 'Unread';
        cs1.CreatedDate = DateTime.newInstance(2020,2,1);
        cs1.LastModifiedDate = DateTime.newInstance(2020,2,1);
        cs1.RecordTypeId = '01290000000mOgZ';
        cs1.Assignment_Rules__c = TRUE;
        cs1.Update_First_Queue__c = TRUE;
        cs1.Send_Auto_Reply__c = TRUE;
        cs1.Email_Text_Holiday_Weekend__c = '<img src="https://c.ap4.content.force.com/servlet/servlet.ImageServer?id=0156F00000HPeZF&oid=00D90000000zAlz&lastMod=1551859137000" alt="" width="50" /> <br/><br/><br/> <table width="100%"> <tbody> <tr style="height: 117.449px;"> <td style="width: 30%; height: 117.449px;" colspan="3"> Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/> Sehubungan dengan <b> Selamat Hari Mencoba Customer </b> maka pada tanggal 12 Februari 2020 layanan tidak beroperasi.<br/> Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal 4 Maret 2020 atau selambat-lambatnya pada hari kerja berikutnya. <br/><br/> Hormat kami, <br/><br/> Customer Care AXA Financial Indonesia <br/><br/> <i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i> <br/> <br/> </td> </tr> </tbody> </table> <hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /> <table width="100%"> <tbody> <tr style="height: 117.372px;"> <td style="width: 30.0705%; height: 117.372px;" colspan="3"> <br/> Dear sir / madam,<br/><br/><br/> In connection with <b> Happy Trying Customer </b>then on February 12, 2020 the service does not operate.<br/> We will be operating back and responding your email on March 04, 2020 or on the next business day.<br/><br/> Best regards,<br/> AXA Financial Indonesia Customer Care<br/><br/> <i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i> </td> </tr> </tbody> </table> <img src="https://c.ap4.content.force.com/servlet/servlet.ImageServer?id=0156F00000HPeZF&oid=00D90000000zAlz&lastMod=1551859137000" alt="" width="50" /> <br/><br/><br/> <table width="100%"> <tbody> <tr style="height: 117.449px;"> <td style="width: 30%; height: 117.449px;" colspan="3"> Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/> Sehubungan dengan <b> Selamat Hari Mencoba Customer </b> maka pada tanggal 12 Februari 2020 layanan tidak beroperasi.<br/> Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal 4 Maret 2020 atau selambat-lambatnya pada hari kerja berikutnya. <br/><br/> Hormat kami, <br/><br/> Customer Care AXA Financial Indonesia <br/><br/> <i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i> <br/> <br/> </td> </tr> </tbody> </table> <hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /> <table width="100%"> <tbody> <tr style="height: 117.372px;"> <td style="width: 30.0705%; height: 117.372px;" colspan="3"> <br/> Dear sir / madam,<br/><br/><br/> In connection with <b> Happy Trying Customer </b>then on February 12, 2020 the service does not operate.<br/> We will be operating back and responding your email on March 04, 2020 or on the next business day.<br/><br/> Best regards,<br/> AXA Financial Indonesia Customer Care<br/><br/> <i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i> </td> </tr> </tbody> </table>';
        cs1.First_Queue__c = '';
        cs1.First_Queue_ID__c = '';
        cs1.Email_Inbox__c = system.Label.CustomerEmail_AFI_ALI;
        insert cs1;
        
        
        SchChangeOwnerToNonActiveQueue m = new SchChangeOwnerToNonActiveQueue();
        String sch = '0 0 6 ? * *';
        String jobID = system.schedule('SCHEDULE JOB SchChangeOwnerToNonActiveQueue 2', sch, m);
        Test.stopTest();
    }
    
    static testmethod void schedulerTest3(){
        Test.StartTest();
        
        Group gr = new Group();
        gr.Name='Group Name Agent AFI Queue';
        gr.Type='Queue';
        insert gr;
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AFI' limit 1];
        
        User userAgentAFI = new User();
        userAgentAFI.Alias = 'spv1';
        userAgentAFI.Email='agentAfi@axa.co.id';
        userAgentAFI.EmailEncodingKey='UTF-8';
        userAgentAFI.LastName='agentAfi';
        userAgentAFI.LanguageLocaleKey='en_US';
        userAgentAFI.LocaleSidKey='en_US';
        userAgentAFI.ProfileId = agentProfileAFI.Id;
        userAgentAFI.Entity__c = 'AFI';
        userAgentAFI.TimeZoneSidKey='Asia/Jakarta';
        userAgentAFI.UserName='agentAfi@axa.co.id';
        userAgentAFI.isActive = TRUE;
        userAgentAFI.Agent__c = TRUE;
        userAgentAFI.Is_Backoffice__c = FALSE;
        userAgentAFI.Agent_Queue_ID_Log_Notification__c = '00G0k000009bOms';	//to CRM2
        //userAgentAFI.Agent_Queue_ID_Log_Notification__c = '00G0k000009bOms';	//to FullSB
        //userAgentAFI.Agent_Queue_ID_Log_Notification__c = '00G0k000009bOms';	//to Production
        insert userAgentAFI;
        
        
        Contact con1 = new Contact();
        con1.FirstName = 'Hamfry';
        con1.LastName = 'Lantu';
        con1.Policy_No__c = '1234-56781';
        insert con1;
        
        Case cs1 = new Case();
        cs1.Status = 'New';
        cs1.Entity_Backup__c = 'AFI';
        cs1.Origin = 'Email';
        cs1.Type = 'Inquiry';
        cs1.OwnerId = userAgentAFI.Id;
        cs1.PIC_Department_LU__c = userAgentAFI.Id;
        cs1.Subject = 'ILCCYS';
        cs1.Email_Status__c = 'Unread';
        cs1.CreatedDate = DateTime.newInstance(2020,2,1);
        cs1.LastModifiedDate = DateTime.newInstance(2020,2,1);
        cs1.RecordTypeId = '01290000000mOgZ';
        cs1.Assignment_Rules__c = TRUE;
        cs1.Update_First_Queue__c = TRUE;
        cs1.Send_Auto_Reply__c = TRUE;
        cs1.Email_Text_Holiday_Weekend__c = '<img src="https://c.ap4.content.force.com/servlet/servlet.ImageServer?id=0156F00000HPeZF&oid=00D90000000zAlz&lastMod=1551859137000" alt="" width="50" /> <br/><br/><br/> <table width="100%"> <tbody> <tr style="height: 117.449px;"> <td style="width: 30%; height: 117.449px;" colspan="3"> Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/> Sehubungan dengan <b> Selamat Hari Mencoba Customer </b> maka pada tanggal 12 Februari 2020 layanan tidak beroperasi.<br/> Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal 4 Maret 2020 atau selambat-lambatnya pada hari kerja berikutnya. <br/><br/> Hormat kami, <br/><br/> Customer Care AXA Financial Indonesia <br/><br/> <i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i> <br/> <br/> </td> </tr> </tbody> </table> <hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /> <table width="100%"> <tbody> <tr style="height: 117.372px;"> <td style="width: 30.0705%; height: 117.372px;" colspan="3"> <br/> Dear sir / madam,<br/><br/><br/> In connection with <b> Happy Trying Customer </b>then on February 12, 2020 the service does not operate.<br/> We will be operating back and responding your email on March 04, 2020 or on the next business day.<br/><br/> Best regards,<br/> AXA Financial Indonesia Customer Care<br/><br/> <i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i> </td> </tr> </tbody> </table> <img src="https://c.ap4.content.force.com/servlet/servlet.ImageServer?id=0156F00000HPeZF&oid=00D90000000zAlz&lastMod=1551859137000" alt="" width="50" /> <br/><br/><br/> <table width="100%"> <tbody> <tr style="height: 117.449px;"> <td style="width: 30%; height: 117.449px;" colspan="3"> Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/> Sehubungan dengan <b> Selamat Hari Mencoba Customer </b> maka pada tanggal 12 Februari 2020 layanan tidak beroperasi.<br/> Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal 4 Maret 2020 atau selambat-lambatnya pada hari kerja berikutnya. <br/><br/> Hormat kami, <br/><br/> Customer Care AXA Financial Indonesia <br/><br/> <i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i> <br/> <br/> </td> </tr> </tbody> </table> <hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /> <table width="100%"> <tbody> <tr style="height: 117.372px;"> <td style="width: 30.0705%; height: 117.372px;" colspan="3"> <br/> Dear sir / madam,<br/><br/><br/> In connection with <b> Happy Trying Customer </b>then on February 12, 2020 the service does not operate.<br/> We will be operating back and responding your email on March 04, 2020 or on the next business day.<br/><br/> Best regards,<br/> AXA Financial Indonesia Customer Care<br/><br/> <i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i> </td> </tr> </tbody> </table>';
        cs1.First_Queue__c = '';
        cs1.First_Queue_ID__c = '';
        cs1.Email_Inbox__c = system.Label.HelplineEmail_AFI_ALI;
        insert cs1;
        
        
        SchChangeOwnerToNonActiveQueue m = new SchChangeOwnerToNonActiveQueue();
        String sch = '0 0 6 ? * *';
        String jobID = system.schedule('SCHEDULE JOB SchChangeOwnerToNonActiveQueue 2', sch, m);
        Test.stopTest();
    }
}