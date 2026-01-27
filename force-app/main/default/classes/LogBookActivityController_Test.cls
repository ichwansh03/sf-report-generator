/**
 * @description       : 
 * @author            : AMFS
 * @group             : 
 * @last modified on  : 09-25-2025
 * @last modified by  : Ahmad Yazid Munif
**/
@isTest
public class LogBookActivityController_Test {
    @testSetup static void setup() {    
        id recordID = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Contact').getRecordTypeId();
        List<Contact> contList = new List<Contact>();
        Contact cont = new Contact();
        cont.Policy_No__c = '100-000-1110001';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP DMTM';
        cont.Entity__c = 'AMFS';
        cont.PolicyApp__c = 'RLS';
        cont.RecordTypeId = recordID;
        contList.add(cont);
        
        cont = new Contact();
        cont.Policy_No__c = '500-1110001';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP KONV';
        cont.Entity__c = 'AMFS';
        cont.PolicyApp__c = 'RLS';
        cont.RecordTypeId = recordID;
        contList.add(cont);
        
        cont = new Contact();
        cont.Policy_No__c = '300-1110001';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP SYA';
        cont.Entity__c = 'AMFS';
        cont.PolicyApp__c = 'RLS';
        cont.RecordTypeId = recordID;
        contList.add(cont);
        
        cont = new Contact();
        cont.Policy_No__c = '801-1110001';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP CORP';
        cont.Entity__c = 'AMFS';
        cont.PolicyApp__c = 'RLS';
        cont.RecordTypeId = recordID;
        contList.add(cont);
        Insert contList;
        
        List<Log_Book_Activitiy_Detail__c> listDetail = new List<Log_Book_Activitiy_Detail__c>();
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
        
        Database.SaveResult lbResult = Database.insert(logBook);
        
        Log_Book_Activitiy__c logbook2 = new Log_Book_Activitiy__c();
        logbook2.Touch_Point__c = 'Head Office';
        logbook2.Log_Book_Date__c = Date.today();
        logbook2.Queue_No__c = 'A002';
        logbook2.Time_In__c = Time.newInstance(15, 0, 0, 0);
        logbook2.Time_Served__c = Time.newInstance(15, 3, 0, 0);
        logbook2.Time_Out__c = Time.newInstance(15, 20, 0, 0);
        logbook2.Waiting_Time__c = '0 hours 3 minutes';
        logbook2.Handling_Time__c = '0 hours 17 minutes';
        logbook2.Type__c = 'Walk-In';
        
        Database.SaveResult lbResult2 = Database.insert(logbook2);

        Log_Book_Activitiy_Detail__c  logBookDetail = new Log_Book_Activitiy_Detail__c();
        logBookDetail = new Log_Book_Activitiy_Detail__c();
        logBookDetail.Policy_Number__c = '100-321-7654377';
        logBookDetail.Policy_Name_Holder__c = 'RITA DWI HASTATI';
        logBookDetail.Product_Type__c = 'DMTM';
        logBookDetail.Customer_Name__c = 'ririn';
        logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        logBookDetail.Is_Policy_Holder__c =  true;
        logBookDetail.Segmentation__c = 'Reguler';
        logBookDetail.Department__c = 'POS';
        logBookDetail.Form_Tambahan__c = 'Formulir FP5';
        logBookDetail.Kind_Of_Transaction__c = 'Request_POS_Withdrawal';
        logBookDetail.Document_Type__c = 'Japen';
        logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];Fotokopi Buku Nikah[Copy]';
        logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logBookDetail.Stamp__c = 1; 
        logBookDetail.Customer_Mood__c = 'Normal';
        logBookDetail.Need_CR__c = 'Yes';
        logBookDetail.Status__c = 'New';
        logBookDetail.email_pp__c = 'tes@gmail.com';
        logBookDetail.Dokumen_Tambahan__c = 'FP5';
        logBookDetail.E_Form__c = true;
        logBookDetail.EForm__c = true;
        logBookDetail.Contact_Policy__c = cont.Id;
        logBookDetail.Log_Book_Activitiy__c = lbResult2.getId();
        logBookDetail.Transaction_Type__c = 'Request';
        logBookDetail.Status_to_Metadata__c = 'Success';
        listDetail.add(logBookDetail);

        logBookDetail = new Log_Book_Activitiy_Detail__c();
        logBookDetail.Policy_Number__c = '100-321-7654377';
        logBookDetail.Policy_Name_Holder__c = 'RITA DWI HASTATI';
        logBookDetail.Product_Type__c = 'DMTM';
        logBookDetail.Customer_Name__c = 'ririn';
        logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        logBookDetail.Is_Policy_Holder__c =  true;
        logBookDetail.Segmentation__c = 'Reguler';
        logBookDetail.Department__c = 'POS';
        logBookDetail.Kind_Of_Transaction__c = 'Request_POS Lumpsum';
        logBookDetail.Document_Type__c = 'Japen';
        logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];Fotokopi Buku Nikah[Copy]';
        logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logBookDetail.Form_Tambahan__c = 'Formulir FP5';
        logBookDetail.Stamp__c = 1; 
        logBookDetail.Customer_Mood__c = 'Normal';
        logBookDetail.Need_CR__c = 'Yes';
        logBookDetail.Status__c = 'New';
        logBookDetail.email_pp__c = 'tes@gmail.com';
        logBookDetail.Dokumen_Tambahan__c = 'FP5';
        logBookDetail.E_Form__c = false;
        logBookDetail.EForm__c = true;
        logBookDetail.Contact_Policy__c = cont.Id;
        logBookDetail.Log_Book_Activitiy__c = lbResult2.getId();
        logBookDetail.Transaction_Type__c = 'Request';
        logBookDetail.Status_to_Metadata__c = 'Success';
        listDetail.add(logBookDetail);

        logBookDetail = new Log_Book_Activitiy_Detail__c();
        logBookDetail.Policy_Number__c = '100-321-7654377';
        logBookDetail.Policy_Name_Holder__c = 'RITA DWI HASTATI';
        logBookDetail.Product_Type__c = 'DMTM';
        logBookDetail.Customer_Name__c = 'ririn';
        logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        logBookDetail.Is_Policy_Holder__c =  true;
        logBookDetail.Segmentation__c = 'Reguler';
        logBookDetail.Department__c = 'ADS';
        logBookDetail.Kind_Of_Transaction__c = 'Request_ADS - Rekening Penerimaan NCB';
        logBookDetail.Document_Type__c = 'New Submission';
        logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];Fotokopi Buku Nikah[Copy]';
        logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logBookDetail.Stamp__c = 2;
        logBookDetail.Dokumen_Tambahan__c = 'FP5';
        logBookDetail.Customer_Mood__c = 'Normal';
        logBookDetail.Status__c = 'New';
        logBookDetail.Log_Book_Activitiy__c = lbResult2.getId();
        logBookDetail.Contact_Policy__c = cont.Id;
        logBookDetail.Transaction_Type__c = 'Request';
        logBookDetail.Status_to_Metadata__c = 'Success';
        listDetail.add(logBookDetail);

        System.debug('lbResult.success ? '+lbResult.isSuccess());
        System.debug('lbResult.id ? '+lbResult.getId());
        
        logBookDetail = new Log_Book_Activitiy_Detail__c();
        logBookDetail.Policy_Number__c = '100-123-1234567';
        logBookDetail.Policy_Name_Holder__c = 'RIRIN LINDAWATI';
        logBookDetail.Product_Type__c = 'DMTM';
        logBookDetail.Customer_Name__c = 'ririn';
        logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        logBookDetail.Is_Policy_Holder__c =  true;
        logBookDetail.Segmentation__c = 'Reguler';
        logBookDetail.Department__c = 'ADS';
        logBookDetail.Kind_Of_Transaction__c = 'Request_ADS - Rekening Penerimaan NCB';
        logBookDetail.Document_Type__c = 'New Submission';
        logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];Fotokopi Buku Nikah[Copy]';
        logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logBookDetail.Stamp__c = 2;
        logBookDetail.Dokumen_Tambahan__c = 'FP5';
        logBookDetail.Customer_Mood__c = 'Normal';
        logBookDetail.Status__c = 'New';
        logBookDetail.Log_Book_Activitiy__c = lbResult.getId();
        logBookDetail.Contact_Policy__c = cont.Id;
        logBookDetail.Transaction_Type__c = 'Request';
        logBookDetail.Status_to_Metadata__c = 'Success';
        listDetail.add(logBookDetail);
        
        logBookDetail = new Log_Book_Activitiy_Detail__c();
        logBookDetail.Policy_Number__c = '100-321-7654321';
        logBookDetail.Policy_Name_Holder__c = 'RITA DWI HASTATI';
        logBookDetail.Product_Type__c = 'DMTM';
        logBookDetail.Customer_Name__c = 'ririn';
        logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        logBookDetail.Is_Policy_Holder__c =  true;
        logBookDetail.Segmentation__c = 'Reguler';
        logBookDetail.Department__c = 'POS';
        logBookDetail.Kind_Of_Transaction__c = 'Request_POS_Withdrawal';
        logBookDetail.Document_Type__c = 'Japen';
        logBookDetail.Form_Tambahan__c = 'Formulir FP5';
        logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];Fotokopi Buku Nikah[Copy]';
        logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logBookDetail.Stamp__c = 1; 
        logBookDetail.Customer_Mood__c = 'Normal';
        logBookDetail.Need_CR__c = 'Yes';
        logBookDetail.Status__c = 'New';
        logBookDetail.email_pp__c = 'tes@gmail.com';
        logBookDetail.Dokumen_Tambahan__c = 'FP5';
        logBookDetail.E_Form__c = true;
        logBookDetail.EForm__c = true;
        logBookDetail.Contact_Policy__c = cont.Id;
        logBookDetail.Log_Book_Activitiy__c = lbResult.getId();
        logBookDetail.Transaction_Type__c = 'Request';
        logBookDetail.Status_to_Metadata__c = 'Success';
        listDetail.add(logBookDetail);
        
        logBookDetail = new Log_Book_Activitiy_Detail__c();
        logBookDetail.Policy_Number__c = '100-321-7654321';
        logBookDetail.Policy_Name_Holder__c = 'RITA DWI HASTATI';
        logBookDetail.Product_Type__c = 'RLS';
        logBookDetail.Customer_Name__c = 'ririn';
        logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        logBookDetail.Is_Policy_Holder__c =  true;
        logBookDetail.Segmentation__c = 'Reguler';
        logBookDetail.Department__c = 'POS';
        logBookDetail.Kind_Of_Transaction__c = 'Request_POS_Japen Non Financial';
        logBookDetail.Form_Utama__c = 'Request_POS_ Perubahan Alamat email';
        logBookDetail.Form_Tambahan__c = 'Formulir FP5';
        logBookDetail.Document_Type__c = 'Japen';
        logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];Fotokopi Buku Nikah[Copy]';
        logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logBookDetail.Stamp__c = 1; 
        logBookDetail.Customer_Mood__c = 'Normal';
        logBookDetail.Need_CR__c = 'Yes';
        logBookDetail.Status__c = 'New';
        logBookDetail.email_pp__c = 'tes@gmail.com';
        logBookDetail.Dokumen_Tambahan__c = 'KTP Tertanggung (Copy)';
        logBookDetail.E_Form__c = true;
        logBookDetail.EForm__c = false;
        logBookDetail.Contact_Policy__c = cont.Id;
        logBookDetail.Log_Book_Activitiy__c = lbResult.getId();
        logBookDetail.Transaction_Type__c = 'Request';
        logBookDetail.Status_to_Metadata__c = 'Success';
        listDetail.add(logBookDetail);

        LogBookActivitiyController ctrl = new LogBookActivitiyController(); 
        ctrl.isTanpaFormUtama = false;
        //ctrl.fetchContactDetail();
        ctrl.getListOfKYC();
        List<Database.SaveResult> lbdResults = Database.insert(listDetail);
        System.debug('lbdResults ? '+lbdResults);
        
        // added by ranti at 01/05/2022
        
        Email_SMS_Template__c setEmail = new Email_SMS_Template__c();
        setEmail.Method__c = 'Email';
        setEmail.Subject__c = '[SFDC] AXA - E-Receipt';
        setEmail.Email_Body__c = '<table style="width: 100%;"><tr><td style="width: 100%;">Kepada Yth : <br />Bapak/Ibu [CONTACT_NAME]<br /><br />Terimakasih atas kunjungan Bapak/Ibu ke Layanan Customer Service AXA Mandiri. Untuk tanda terima dari transaksi yang Bapak/Ibu lakukan pada [CREATED_DATE], mohon klik tautan berikut ini :<br /><br /><a href="[LINKPAGE]">Klik Link Ini</a><br /><br /> Atas perhatian, kepercayaan dan kerjasama Bapak/Ibu, kami ucapkan terima kasih.<br /><br /><i><b>&#34;Nikmati layanan mengakses informasi Polis Asuransi dan status Klaim Anda dengan cepat &amp; mudah melalui Emma – Teknologi Mudah dan Nyaman untuk Sehat juga Terlindungi di portal nasabah melalui Login Emma di www.axa-mandiri.co.id serta Whatsapp di 0815-8608-6801&#34; #nyamandirumahsaja</b></i></td></tr></table>';
        setEmail.Email_Footer__c = '<br/><table style="width: 100%;"><tr><td style="width: 100%;">  <b>PT  AXA Mandiri Financial Services</b><br/>  AXA Tower Ground Floor<br/>  Jl. Prof. Dr. Satrio Kav. 18, Kuningan City<br/>  Jakarta 12940, Indonesia<br/><table>    <tr>        <td>Email</td>        <td>: customer@axa-mandiri.co.id</td>    </tr>    <tr>        <td>Livechat</td>        <td>: www.axa-mandiri.co.id</td>    </tr>    <tr>        <td>Telp</td>        <td>: 021 – 1500 803</td>    </tr></table><br/><br/></td></tr></table>';
        insert setEmail;
        
        // system.debug('setEmail:'+setEmail.id);
        
        Email_SMS_Template__c setSms = new Email_SMS_Template__c();
        setSms.Method__c = 'SMS';
        setSms.Subject__c = '[SFDC] AXA - E-Receipt';
        setSms.Email_Body__c = 'Nasabah Yth, Mohon klik tautan ini utk mendapatkan tanda terima atas transaksi Bpk/Ibu di Customer Service AXA Mandiri : [LINKPAGE]>';
        insert setSms;
        
        system.debug('setSms:'+setSms.id);
        
        system.debug('::setEmail.id:'+setEmail.id);
        system.debug('::setSms.id:'+setSms.id);
        ICF_Parameter__c setTemplateEmail = new ICF_Parameter__c();
        setTemplateEmail.Sender__c = 'AXA_MANDIRI';
        setTemplateEmail.Password__c = 'axaccc567';
        setTemplateEmail.Division__c = 'CCC';
        setTemplateEmail.Batchname__c = 'ICF_SMS_AMFS';
        setTemplateEmail.Uploadby__c = 'Salesforce_AMFS';
        setTemplateEmail.Entity__c  = 'AMFS E-Receipt'; 
        setTemplateEmail.recordTypeId  = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId(); 
        setTemplateEmail.ICF_Email_Template__c = setEmail.id;
        setTemplateEmail.ICF_SMS_Template__c = setSms.id; 
        insert setTemplateEmail;

        Log_Book_Activitiy_Detail__c detail = [SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = '100-321-7654321' LIMIT 1];
        E_Form_Master_Data__c eForm = new E_Form_Master_Data__c(
            Name = 'Test E-Form',
            Log_Book_Activitiy_Detail__c = detail.Id
        );
        insert eForm;
        ContentVersion cv = new ContentVersion(
            Title = 'Test File',
            PathOnClient = 'TestFile.pdf',
            VersionData = Blob.valueOf('Test file content')
        );
        insert cv;
        ContentVersion cv2 = new ContentVersion(
            Title = 'Test File KTP',
            PathOnClient = 'TestFileKTP.pdf',
            VersionData = Blob.valueOf('Test file KTP')
        );
        insert cv2;
        cv = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id LIMIT 1];
        cv2 = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :cv2.Id LIMIT 1];
        ContentDocumentLink cdl = new ContentDocumentLink(
            ContentDocumentId = cv.ContentDocumentId,
            LinkedEntityId = eForm.Id,
            ShareType = 'V',
            Visibility = 'AllUsers'
        );
        insert cdl;
        ContentDocumentLink cdl2 = new ContentDocumentLink(
            ContentDocumentId = cv2.ContentDocumentId,
            LinkedEntityId = detail.Id,
            ShareType = 'V',
            Visibility = 'AllUsers'
        );
        insert cdl2;

        // dipcad Code
        List<Master_Dipcad_Code__c> testDipcadCodes = new List<Master_Dipcad_Code__c>();
        testDipcadCodes.add(new Master_Dipcad_Code__c(
            Name = 'REGWTH',
            Kind_of_Transaction__c = 'Request_POS_Withdrawal',
            Deskripsi__c = 'Withdrawal (Penarikan Dana)',
            Document__c = 'Formulir Penarikan Sebagian Unit atau Pembatalan Polis',
            Department__c = 'POS',
            Is_E_Form__c = true
        ));

        testDipcadCodes.add(new Master_Dipcad_Code__c(
            Name = 'TOPUPLS',
            Kind_of_Transaction__c = 'Request_POS Lumpsum',
            Deskripsi__c = 'Lumpsum Top Up (Top Up Sekaligus)',
            Department__c = 'POS',
            Document__c = 'Formulir Penarikan Sebagian Unit atau Pembatalan Polis',
            Is_E_Form__c = true
        ));
        testDipcadCodes.add(new Master_Dipcad_Code__c(
            Name = 'REINST',
            Kind_of_Transaction__c = 'Request_POS Pemulihan Polis',
            Deskripsi__c = 'Pemulihan Polis',
            Document__c = 'Formulir Pernyataan Kesehatan dan Perubahan Data Polis',
            Department__c = 'POS',
            Is_E_Form__c = true
        ));
        testDipcadCodes.add(new Master_Dipcad_Code__c(
            Name = 'CHANGES-ADS',
            Kind_of_Transaction__c = 'Request_ADS_Perubahan Ahli waris',
            Department__c = 'ADS',
            Document__c = 'Formulir Perubahan Data Polis',
            Is_E_Form__c = true
        ));
        testDipcadCodes.add(new Master_Dipcad_Code__c(
            Name = 'COAD',
            Kind_of_Transaction__c = 'Request_POS_Japen Non Financial',
            Form_Utama__c = 'Request_POS_ Perubahan Alamat email',
            Department__c = 'POS',
            Is_E_Form__c = true,
            Document__c = 'Formulir Perubahan Data Polis',
            Deskripsi__c = 'Japen Non Financial'
        ));
        insert testDipcadCodes;
    }
    
    public static testmethod void testInquiry(){
        Test.startTest();
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        PageReference pageRef = Page.LogBookActivitiy;
        pageRef.getParameters().put('editQ', 'true');
        pageRef.getParameters().put('editQTimeServed', '12:12');
        pageRef.getParameters().put('tabletEmail', 'amfs@gmail.com');
        Test.setCurrentPage(pageRef);
        ctrl.getTouchPoints();
        ctrl.getKindOfTransaction();
        ctrl.init();
        System.assertEquals(6, ctrl.listDetail.size());
        ctrl.logBookDate = String.valueOf(Date.today());
        ctrl.logBook.Touch_Point__c = 'All';
        // ctrl.logBookDetail.Kind_Of_Transaction__c = 'All';
        ctrl.logBookDetail.Policy_Number__c = '100-123-1234567';
        ctrl.inquirySearch(); 
        System.assertEquals(1, ctrl.listDetail.size());
        System.assertEquals('100-123-1234567', ctrl.listDetail.get(0).Policy_Number__c);
        Test.stopTest();
    }
    
    //added by Ranti at 11/09/2021
    public static testmethod void testFetchContact(){
        Test.startTest();
        id recordID = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Contact').getRecordTypeId();
        List<Contact> contList = new List<Contact>();
        Contact cont = new Contact();
        cont.Policy_No__c = '801-542641';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP DMTM';
        cont.Entity__c = 'AMFS';
        cont.PolicyApp__c = 'RLS';
        cont.RecordTypeId = recordID;
        contList.add(cont);
        
        cont = new Contact();
        cont.Policy_No__c = '801-681064';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP KONV';
        cont.Entity__c = 'AMFS';
        cont.PolicyApp__c = 'RLS';
        cont.RecordTypeId = recordID;
        contList.add(cont);
        
        cont = new Contact();
        cont.Policy_No__c = '801-369541';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP SYA';
        cont.Entity__c = 'AMFS';
        cont.PolicyApp__c = 'RLS';
        cont.RecordTypeId = recordID;
        contList.add(cont);
        
        cont = new Contact();
        cont.Policy_No__c = '801-555555';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP CORP';
        cont.Entity__c = 'AMFS';
        cont.PolicyApp__c = 'RLS';
        cont.RecordTypeId = recordID;
        contList.add(cont);
        Insert contList;
        
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        PageReference pageRef = Page.LogBookActivitiy;
        Test.setCurrentPage(pageRef);
        ctrl.logBookDetail.Contact_Policy__c = cont.Id;
        
        ctrl.fetchContactDetail(); 
        Test.stopTest();
    }
    
    static testmethod void testEdit(){
        Test.startTest();
        List<Log_Book_Activitiy_Detail__c> results = [SELECT ID, Policy_Number__c FROM Log_Book_Activitiy_Detail__c LIMIT 1];
        Log_Book_Activitiy_Detail__c logDetailResult = results.get(0);
        
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.isTanpaFormUtama = false;
        PageReference pageRef = Page.EditLogBookActivitiy;
        pageRef.getParameters().put('id', logDetailResult.id);
        pageRef.getParameters().put('state', 'd');
        Test.setCurrentPage(pageRef);
        ctrl.initEdit();
        System.assert(ctrl.visibleDetail);
        System.assertEquals(logDetailResult.id, ctrl.logBookDetail.Id);
        ctrl.edit();
        System.assert(ctrl.visibleEdit);
        String theNote = 'note for ' + logDetailResult.Policy_Number__c;
        ctrl.logBookDetail.Notes__c = theNote;
        ctrl.edit();
        System.assertEquals(theNote, ctrl.logBookDetail.Notes__c);
        Test.stopTest();
    }
    
    static testmethod void testCreateTypeRequest(){
        Test.startTest();
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.isTanpaFormUtama = false;
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        Test.setCurrentPage(pageRef);
        Datetime dtNow = Datetime.now();
        ctrl.logBook.Touch_Point__c = 'Head Office';
        ctrl.logBook.Log_Book_Date__c = Date.today();
        ctrl.logBook.Queue_No__c = 'A002';
        ctrl.logBook.Time_In__c = dtNow.time();
        
        ctrl.logBookDetail.Policy_Number__c = '100-000-1110001';
        ctrl.logBookDetail.Policy_Name_Holder__c = 'JACK JHON';
        ctrl.logBookDetail.Product_Type__c = 'DMTM';
        ctrl.logBookDetail.Is_Policy_Holder__c = true;
        ctrl.logBookDetail.Customer_Name__c = 'JACK JHON';
        ctrl.logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        ctrl.logBookDetail.Is_Policy_Holder__c =  true;
        ctrl.logBookDetail.Segmentation__c = 'Reguler';
        ctrl.logBookDetail.Department__c = 'ADS';
        ctrl.changeDepart();
        ctrl.logBookDetail.Kind_Of_Transaction__c = 'Request_ADS_Document NCB';
        ctrl.checkCaseType();
        List<String> docTest = new List<String>();
        docTest.add('abc');
        docTest.add('bcd');
        ctrl.setDocInformation(docTest);
        ctrl.getDocSpec();
        ctrl.logBookDetail.Document_Type__c = 'Japen';
        ctrl.logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];Fotokopi Buku Nikah[Copy]';
        ctrl.logBookDetail.Stamp__c = 1;
        ctrl.logBookDetail.Customer_Mood__c = 'Normal'; 
        ctrl.logBookDetail.Status__c = 'Closed';

        ctrl.attachmentStrBody = 'bodyPart1,bodyPart2,bodyPart3';
        ctrl.attachmentStrName = '["file1.pdf", "image.jpg", "doc.txt"]';
        ctrl.attachmentStrType = '["application/pdf", "image/jpeg", "text/plain"]';
        
        ctrl.addPolicyandAutoPopulate();
        ctrl.addPolicy();
        
        pageRef = ctrl.done();
        System.assert(pageRef != null);
        System.assertEquals(Page.LogBookActivitiy.getURL(), pageRef.getURL());
        Test.stopTest();
    }
    
    static testmethod void testCreateTypeCollection(){
        Test.startTest();
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.isTanpaFormUtama = false;
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        Test.setCurrentPage(pageRef);
        Datetime dtNow = Datetime.now();
        ctrl.logBook.Touch_Point__c = 'Head Office';
        ctrl.logBook.Log_Book_Date__c = Date.today();
        ctrl.logBook.Queue_No__c = 'A002';
        ctrl.logBook.Time_In__c = dtNow.time();
        
        ctrl.logBookDetail.Policy_Number__c = '100-000-1110001';
        ctrl.logBookDetail.Policy_Name_Holder__c = 'JACK JHON';
        ctrl.logBookDetail.Product_Type__c = 'DMTM';
        ctrl.logBookDetail.Is_Policy_Holder__c = true;
        ctrl.logBookDetail.Customer_Name__c = 'JACK JHON';
        ctrl.logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        ctrl.logBookDetail.Is_Policy_Holder__c =  true;
        ctrl.logBookDetail.Segmentation__c = 'Reguler';
        ctrl.logBookDetail.Department__c = 'Collection & CR';
        ctrl.logBookDetail.Kind_Of_Transaction__c = 'Request_Hold Debit';
        ctrl.changeDepart();
        
        ctrl.checkCaseType();
        List<String> docTest = new List<String>();
        docTest.add('abc');
        docTest.add('bcd');
        ctrl.setDocInformation(docTest);
        ctrl.getDocSpec();
        ctrl.logBookDetail.Document_Type__c = 'Japen';
        ctrl.logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];Fotokopi Buku Nikah[Copy]';
        ctrl.logBookDetail.Stamp__c = 1;
        ctrl.logBookDetail.Customer_Mood__c = 'Normal'; 
        ctrl.logBookDetail.Status__c = 'Closed';

        ctrl.attachmentStrBody = 'bodyPart1,bodyPart2,bodyPart3';
        ctrl.attachmentStrName = '["file1.pdf", "image.jpg", "doc.txt"]';
        ctrl.attachmentStrType = '["application/pdf", "image/jpeg", "text/plain"]';

        ctrl.addPolicyandAutoPopulate();
        ctrl.addPolicy();
        
        pageRef = ctrl.done();
        System.assert(pageRef != null);
        System.assertEquals(Page.LogBookActivitiy.getURL(), pageRef.getURL());
        Test.stopTest();
    }
    
    static testmethod void testCreateTypeComplaint(){
        Test.startTest();
        System.debug('======================= START testCreateTypeComplaint =======================');
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.isTanpaFormUtama = false;
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        Test.setCurrentPage(pageRef);
        Datetime dtNow = Datetime.now();
        ctrl.logBook.Touch_Point__c = 'Head Office';
        ctrl.logBook.Log_Book_Date__c = Date.today();
        ctrl.logBook.Queue_No__c = 'A003';
        ctrl.logBook.Time_In__c = dtNow.time();
        
        ctrl.logBookDetail.Policy_Number__c = '100-000-1110001';
        ctrl.logBookDetail.Policy_Name_Holder__c = 'JACK JHON';
        ctrl.logBookDetail.Product_Type__c = 'DMTM';
        ctrl.logBookDetail.Is_Policy_Holder__c = true;
        ctrl.logBookDetail.Customer_Name__c = 'JACK JHON';
        ctrl.logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        ctrl.logBookDetail.Is_Policy_Holder__c =  true;
        ctrl.logBookDetail.Segmentation__c = 'Reguler';
        ctrl.logBookDetail.Department__c = 'CMU';
        ctrl.changeDepart();
        ctrl.logBookDetail.Kind_Of_Transaction__c = 'Complaint';
        ctrl.logBookDetail.Transaction_Type__c = 'Complaint';
        ctrl.checkCaseType();
        ctrl.getDocSpec();
        ctrl.logBookDetail.Document_Type__c = 'New Submission';
        ctrl.logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];Fotokopi Buku Nikah[Copy]';
        ctrl.logBookDetail.Stamp__c = 1;
        ctrl.logBookDetail.Customer_Mood__c = 'Angry'; 
        
        // Faizir 20210812 Add Field Status and Transaction Type for Complaint
        ctrl.logBookDetail.Status__c = 'New';
        // Ends
        
        ctrl.cs.Nature_Config__c = 'Administrative procedures';
        ctrl.cs.Category_Config__c = 'CS-Missing document';
        ctrl.cs.Customer_type__c = 'Regular';
        ctrl.cs.Product__c = 'TM';
        ctrl.cs.Business_channel__c = 'TM';
        ctrl.cs.Complaint_type__c = 'Soft Complaint';
        ctrl.cs.Description__c = 'Test Complaint';
        ctrl.cs.Priority = 'Medium';

        ctrl.attachmentStrBody = 'bodyPart1,bodyPart2,bodyPart3';
        ctrl.attachmentStrName = '["file1.pdf", "image.jpg", "doc.txt"]';
        ctrl.attachmentStrType = '["application/pdf", "image/jpeg", "text/plain"]';

        ctrl.addPolicyandAutoPopulate();
        ctrl.addPolicy();
        
        pageRef = ctrl.done();
        System.assert(pageRef != null);
        System.assertEquals(Page.LogBookActivitiy.getURL(), pageRef.getURL());
        System.debug('======================= END testCreateTypeComplaint =======================');
        Test.stopTest();
    }
    
    static testmethod void testCreateTypeInquiry(){
        Test.startTest();
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.isTanpaFormUtama = false;
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        Test.setCurrentPage(pageRef);
        Datetime dtNow = Datetime.now();
        ctrl.logBook.Touch_Point__c = 'Head Office';
        ctrl.logBook.Log_Book_Date__c = Date.today();
        ctrl.logBook.Queue_No__c = 'A004';
        ctrl.logBook.Time_In__c = dtNow.time();
        
        ctrl.logBookDetail.Policy_Number__c = '100-000-1110001';
        ctrl.logBookDetail.Policy_Name_Holder__c = 'JACK JHON';
        ctrl.logBookDetail.Product_Type__c = 'DMTM';
        ctrl.logBookDetail.Is_Policy_Holder__c = true;
        ctrl.logBookDetail.Customer_Name__c = 'JACK JHON';
        ctrl.logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        ctrl.logBookDetail.Is_Policy_Holder__c =  true;
        ctrl.logBookDetail.Segmentation__c = 'Reguler';
        ctrl.logBookDetail.Department__c = 'CCC';
        ctrl.changeDepart();
        ctrl.logBookDetail.Kind_Of_Transaction__c = 'Tanya Mekanisme Prosedur';
        ctrl.checkCaseType();
        ctrl.getDocSpec();
        ctrl.logBookDetail.Customer_Mood__c = 'Happy'; 
        ctrl.selectedCaseTypeKeeper = 'Tanya Mekanisme Prosedur <br />';

        ctrl.attachmentStrBody = 'bodyPart1,bodyPart2,bodyPart3';
        ctrl.attachmentStrName = '["file1.pdf", "image.jpg", "doc.txt"]';
        ctrl.attachmentStrType = '["application/pdf", "image/jpeg", "text/plain"]';

        ctrl.addPolicy();
        ctrl.addPolicyandAutoPopulate();
        
        pageRef = ctrl.done();
        // System.assert(pageRef != null);
        // System.assertEquals(Page.LogBookActivitiy.getURL(), pageRef.getURL());
        Test.stopTest();
    }
    
    static testmethod void testCreateTypeInquiryNonCustomer(){
        Test.startTest();
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.isTanpaFormUtama = false;
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        Test.setCurrentPage(pageRef);
        Datetime dtNow = Datetime.now();
        ctrl.logBook.Touch_Point__c = 'Head Office';
        ctrl.logBook.Log_Book_Date__c = Date.today();
        ctrl.logBook.Queue_No__c = 'A004';
        ctrl.logBook.Time_In__c = dtNow.time();
        
        ctrl.logBookDetail.Policy_Number__c = '100-000-1110001';
        ctrl.logBookDetail.Policy_Name_Holder__c = 'JACK JHON';
        ctrl.isValidCustomer = false;
        ctrl.logBookDetail.Is_Non_Customer__c = true;
        ctrl.logBookDetail.Product_Type__c = 'DMTM';
        ctrl.logBookDetail.Is_Policy_Holder__c = false;
        ctrl.logBookDetail.Customer_Name__c = 'SITI';
        ctrl.logBookDetail.Customer_Relation__c = 'Tunangan';
        //ctrl.logBookDetail.Is_Policy_Holder__c =  true;
        ctrl.logBookDetail.Segmentation__c = 'Reguler';
        ctrl.logBookDetail.Department__c = 'CCC';
        ctrl.changeDepart();
        ctrl.logBookDetail.Kind_Of_Transaction__c = 'Tanya Mekanisme Prosedur';
        ctrl.checkCaseType();
        ctrl.getDocSpec();
        ctrl.logBookDetail.Customer_Mood__c = 'Happy'; 
        ctrl.selectedCaseTypeKeeper = 'Tanya Mekanisme Prosedur <br />';

        ctrl.attachmentStrBody = 'bodyPart1,bodyPart2,bodyPart3';
        ctrl.attachmentStrName = '["file1.pdf", "image.jpg", "doc.txt"]';
        ctrl.attachmentStrType = '["application/pdf", "image/jpeg", "text/plain"]';

        ctrl.addPolicyandAutoPopulate();
        ctrl.addPolicy();
        pageRef = ctrl.done();
        // System.assert(pageRef != null);
        // System.assertEquals(Page.LogBookActivitiy.getURL(), pageRef.getURL());
        Test.stopTest();
    }
    
    static testmethod void testCreateTypeRequestSentEReceiptEmail(){
        Test.startTest();
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.isTanpaFormUtama = false;
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        Test.setCurrentPage(pageRef);
        Datetime dtNow = Datetime.now();
        ctrl.logBook.Touch_Point__c = 'Head Office';
        ctrl.logBook.Log_Book_Date__c = Date.today();
        ctrl.logBook.Queue_No__c = 'A002';
        ctrl.logBook.Time_In__c = dtNow.time();
        
        ctrl.logBookDetail.Policy_Number__c = '100-000-1110001';
        ctrl.logBookDetail.Policy_Name_Holder__c = 'JACK JHON';
        ctrl.logBookDetail.Product_Type__c = 'DMTM';
        ctrl.logBookDetail.Is_Policy_Holder__c = true;
        ctrl.logBookDetail.Customer_Name__c = 'JACK JHON';
        ctrl.logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        ctrl.logBookDetail.Is_Policy_Holder__c =  true;
        ctrl.logBookDetail.Segmentation__c = 'Reguler';
        ctrl.logBookDetail.Department__c = 'ADS';
        ctrl.changeDepart();
        ctrl.logBookDetail.Kind_Of_Transaction__c = 'Request_ADS Pemulihan Polis';
        ctrl.checkCaseType();
        ctrl.getDocSpec();
        ctrl.logBookDetail.Document_Type__c = 'Japen';
        ctrl.logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];';
        ctrl.logBookDetail.Stamp__c = 1;
        ctrl.logBookDetail.Customer_Mood__c = 'Normal'; 
        ctrl.logBookDetail.Status__c = 'Closed';
        ctrl.logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        ctrl.logBookDetail.email_pp__c = 'tes@gmail.com';

        ctrl.attachmentStrBody = 'bodyPart1,bodyPart2,bodyPart3';
        ctrl.attachmentStrName = '["file1.pdf", "image.jpg", "doc.txt"]';
        ctrl.attachmentStrType = '["application/pdf", "image/jpeg", "text/plain"]';

        ctrl.addPolicyandAutoPopulate();
        ctrl.addPolicy();
        System.debug('logBookDetail email :'+ctrl.logBookDetail);
        // System.debug('logBookDetail id :'+ctrl.logBookDetail.getId());
        pageRef = ctrl.done();
        System.assert(pageRef != null);
        System.assertEquals(Page.LogBookActivitiy.getURL(), pageRef.getURL());
        
        
        ctrl.sendType = 'Email';
        PageReference pageRefPDF = Page.LogBookActivitiyPDF;
        pageRefPDF.getParameters().put('queue', 'A002');
        pageRefPDF.getParameters().put('touchPoint', 'Head Office');
        pageRefPDF.getParameters().put('dateLog', '2021-01-20');
        pageRefPDF.getParameters().put('sendType', 'Email');
        pageRefPDF.getParameters().put('paramQueue', 'A002');
        pageRefPDF.getParameters().put('paramTouchPoint', 'Head Office');
        pageRefPDF.getParameters().put('paramDateLog', '2021-01-20'); 
        // pageRefPDF.getParameters().put('lbdId', '1'); 
        
        System.debug('pageRef : '+pageRef.getParameters());
        Test.setCurrentPage(pageRefPDF); 
        ctrl.sendNotif(); 
        Test.stopTest();
    }
     
    static testmethod void testCreateTypeRequestSentEReceiptSMS(){
        Test.startTest();
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.isTanpaFormUtama = false;
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        Test.setCurrentPage(pageRef);
        Datetime dtNow = Datetime.now();
        ctrl.logBook.Touch_Point__c = 'Head Office';
        ctrl.logBook.Log_Book_Date__c = Date.today();
        ctrl.logBook.Queue_No__c = 'A002';
        ctrl.logBook.Time_In__c = dtNow.time();
        
        ctrl.logBookDetail.Policy_Number__c = '100-000-1110001';
        ctrl.logBookDetail.Policy_Name_Holder__c = 'JACK JHON';
        ctrl.logBookDetail.Product_Type__c = 'DMTM';
        ctrl.logBookDetail.Is_Policy_Holder__c = true;
        ctrl.logBookDetail.Customer_Name__c = 'JACK JHON';
        ctrl.logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        ctrl.logBookDetail.Is_Policy_Holder__c =  true;
        ctrl.logBookDetail.Segmentation__c = 'Reguler';
        ctrl.logBookDetail.Department__c = 'ADS';
        ctrl.changeDepart();
        ctrl.logBookDetail.Kind_Of_Transaction__c = 'Request_ADS Pemulihan Polis';
        ctrl.checkCaseType();
        ctrl.getDocSpec();
        ctrl.logBookDetail.Document_Type__c = 'Japen';
        ctrl.logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];';
        ctrl.logBookDetail.Stamp__c = 1;
        ctrl.logBookDetail.Customer_Mood__c = 'Normal'; 
        ctrl.logBookDetail.Status__c = 'Closed';
        ctrl.logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        ctrl.logBookDetail.email_pp__c = 'tes@gmail.com';
        ctrl.logBookDetail.Phone_PP__c = '085156080110';

        ctrl.selectedDokumen = 'FP5, Buku Polis';
        ctrl.selectedForm = 'Formulir Deklarasi Individu (CRS), Formulir Deklarasi Badan Usaha (CRS)';

        ctrl.attachmentStrBody = 'bodyPart1,bodyPart2,bodyPart3';
        ctrl.attachmentStrName = '["file1.pdf", "image.jpg", "doc.txt"]';
        ctrl.attachmentStrType = '["application/pdf", "image/jpeg", "text/plain"]';

        ctrl.addPolicyandAutoPopulate();
        ctrl.addPolicy();
        System.debug('logBookDetail email :'+ctrl.logBookDetail);
        // System.debug('logBookDetail id :'+ctrl.logBookDetail.getId());
        pageRef = ctrl.done();
        // System.assert(pageRef != null);
        // System.assertEquals(Page.LogBookActivitiy.getURL(), pageRef.getURL());
        
        
        ctrl.sendType = 'SMS';
        PageReference pageRefPDF = Page.LogBookActivitiyPDF;
        pageRefPDF.getParameters().put('queue', 'A002');
        pageRefPDF.getParameters().put('touchPoint', 'Head Office');
        pageRefPDF.getParameters().put('dateLog', '2021-01-20');
        pageRefPDF.getParameters().put('sendType', 'SMS');
        pageRefPDF.getParameters().put('paramQueue', 'A002');
        pageRefPDF.getParameters().put('paramTouchPoint', 'Head Office');
        pageRefPDF.getParameters().put('paramDateLog', '2021-01-20'); 
        // pageRefPDF.getParameters().put('lbdId', '1'); 
        
        // System.debug('pageRef : '+pageRef.getParameters());
        Test.setCurrentPage(pageRefPDF); 
        ctrl.sendNotif(); 
        Test.stopTest();
    }
    
    
    static testmethod void testLookup(){
        Test.startTest();
        LogBookPolicyLookupController ctrlLookup = new LogBookPolicyLookupController();
        PageReference pageRef = Page.LogBookPolicyLookup;
        pageRef.getParameters().put('spno', '');
        Test.setCurrentPage(pageRef);
        ctrlLookup.searchString = '1';
        ctrlLookup.search();
        ctrlLookup.searchString = '5';
        ctrlLookup.search();
        ctrlLookup.searchString = '3';
        ctrlLookup.search();
        ctrlLookup.searchString = '80';
        ctrlLookup.search();
        System.assert(ctrlLookup.policyResult != null && ctrlLookup.policyResult.size() > 0);
        Test.stopTest();
    }  
    
    // added by Ranti at 16/06/2023
    static testmethod void testEditQueue(){
        Test.startTest();
            log_book_activitiy__c getdetail =[select id  from log_book_activitiy__c limit 1]; 
            LogBookActivitiyController ctrlLookup = new LogBookActivitiyController();
            
            PageReference pageRef2 = Page.CreateLogBookActivitiy; 
            pageRef2.getParameters().put('logbookactivitiyid', getdetail.Id);
            Test.setCurrentPage(pageRef2);
              
        Test.stopTest();
    }  
    
    static testmethod void testIdentityValidate() {
        id recordID = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Contact').getRecordTypeId();
        Contact cont = new Contact();
        cont.Policy_No__c = '123-1234567';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP RLS';
        cont.Entity__c = 'AMFS';
        cont.PolicyApp__c = 'RLS';
        cont.RecordTypeId = recordID;
        insert cont;
        
        Test.StartTest();
        Test.setMock(HttpCalloutMock.class, new LogBookActivityControllerMock());
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        Test.setCurrentPage(pageRef);
        Datetime dtNow = Datetime.now();
        ctrl.logBook.Touch_Point__c = 'Head Office';
        ctrl.logBook.Log_Book_Date__c = Date.today();
        ctrl.logBook.Queue_No__c = 'A004';
        ctrl.logBook.Time_In__c = dtNow.time();
        
        ctrl.logBookDetail.Policy_Number__c = '123-1234567';
        ctrl.logBookDetail.Policy_Name_Holder__c = 'JACK JHON';
        ctrl.isValidCustomer = false;
        ctrl.logBookDetail.Is_Non_Customer__c = true;
        ctrl.logBookDetail.Product_Type__c = 'RLS';
        ctrl.logBookDetail.Is_Policy_Holder__c = false;
        ctrl.logBookDetail.Customer_Name__c = 'SITI';
        ctrl.logBookDetail.Customer_Relation__c = 'Tunangan';
        //ctrl.logBookDetail.Is_Policy_Holder__c =  true;
        ctrl.logBookDetail.Segmentation__c = 'Reguler';
        ctrl.logBookDetail.Department__c = 'CCC';
        ctrl.changeDepart();
        ctrl.logBookDetail.Kind_Of_Transaction__c = 'Tanya Mekanisme Prosedur';
        ctrl.checkCaseType();
        ctrl.getDocSpec();
        ctrl.logBookDetail.Customer_Mood__c = 'Happy'; 
        ctrl.selectedCaseTypeKeeper = 'Tanya Mekanisme Prosedur <br />';
        
        ctrl.generateSecNo();
        ctrl.identityValidate();
        Test.StopTest();
    }

    // Add by Yazid MII
    @isTest
    static void remoteActionFunction(){
        Log_Book_Activitiy__c dataExisting = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001' LIMIT 1];
        Log_Book_Activitiy__c dataExisting2 = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A002' LIMIT 1];
        

        Test.startTest();
        LogBookActivitiyController.PicklistEntryWrapper wrapp = new LogBookActivitiyController.PicklistEntryWrapper();
        wrapp.active = 'active';
        wrapp.defaultValue = 'defaultValue';
        wrapp.label = 'label';
        wrapp.value = 'value';
        wrapp.validFor = 'validFor';

        Integer boolDetail = LogBookActivitiyController.checkDetail(dataExisting.Id);
        Integer boolDetailBelumSelesai = LogBookActivitiyController.checkDetail(dataExisting2.Id);
        Integer boolDetailNull = LogBookActivitiyController.checkDetail(null);
        List<String> formTambahan = LogBookActivitiyController.getFormTambahan();
        List<String> dokTambahan = LogBookActivitiyController.getDokumenTambahan();
        System.assertEquals(1, boolDetail);
        Test.stopTest();
    }

    @isTest
    static void testCreatePOS(){
        Contact policyContact = [SELECT id FROM Contact WHERE Policy_No__c = '801-1110001' LIMIT 1];
        Log_Book_Activitiy__c dataExisting = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001' LIMIT 1];
        
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        pageRef.getParameters().put('editQ', 'true');
        pageRef.getParameters().put('editQTimeServed', '12:12');
        pageRef.getParameters().put('tabletEmail', 'amfs@gmail.com');
        pageRef.getParameters().put('policyId', policyContact.Id);
        pageRef.getParameters().put('csSubject', 'csSubject');
        pageRef.getParameters().put('policyNumber', '123123123');
        pageRef.getParameters().put('emailP', 'emailP@email.com');
        pageRef.getParameters().put('telpP', '088822224344');
        pageRef.getParameters().put('nameHolderP', 'nameHolderP');
        pageRef.getParameters().put('productType', 'productType');
        pageRef.getParameters().put('isPolicyHolder', 'true');
        pageRef.getParameters().put('customerName', 'JHONNY DUMMY');
        pageRef.getParameters().put('customerRelation', 'customer');
        pageRef.getParameters().put('emailNonPP', 'emailNonPP@mail.com');
        pageRef.getParameters().put('phoneNonPP', '0888222243333');
        pageRef.getParameters().put('description', 'remark test');
        pageRef.getParameters().put('logbookactivitiyid', dataExisting.Id);

        Test.setCurrentPage(pageRef);
        Test.startTest();
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.isTanpaFormUtama = true;
        ctrl.isJapenPOS = true;
        ctrl.isEditQueue = true;
        ctrl.saveSearchPolicyId = '123123123';
        Datetime dtNow = Datetime.now();
        ctrl.logBook.Touch_Point__c = 'Head Office';
        ctrl.logBook.Log_Book_Date__c = Date.today();
        ctrl.logBook.Queue_No__c = 'A100';
        ctrl.logBook.Time_In__c = dtNow.time();
        
        ctrl.logBookDetail.Policy_Number__c = '101-000-1110001';
        ctrl.logBookDetail.Policy_Name_Holder__c = 'JACK BROWN';
        ctrl.logBookDetail.Product_Type__c = 'RLS';
        ctrl.logBookDetail.Is_Policy_Holder__c = true;
        ctrl.logBookDetail.Customer_Name__c = 'JACK BROWN';
        ctrl.logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        ctrl.logBookDetail.Is_Policy_Holder__c =  true;
        ctrl.logBookDetail.Segmentation__c = 'Reguler';
        ctrl.logBookDetail.Department__c = 'POS';
        ctrl.changeDepart();
        ctrl.logBookDetail.Kind_Of_Transaction__c = 'Request_POS_Japen Non Financial';
        ctrl.logBookDetail.Form_Utama__c = 'Request_POS_ Perubahan Alamat email';
        ctrl.logBookDetail.Form_Tambahan__c = 'FP5';
        ctrl.checkCaseType();
        ctrl.getDocSpec();
        ctrl.logBookDetail.Document_Type__c = 'Japen';
        ctrl.logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];Fotokopi Buku Nikah[Copy]';
        ctrl.logBookDetail.Stamp__c = 1;
        ctrl.logBookDetail.Customer_Mood__c = 'Normal'; 
        ctrl.logBookDetail.Status__c = 'New';
        ctrl.logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        ctrl.logBookDetail.email_pp__c = 'tes@gmail.com';
        ctrl.logBookDetail.Dokumen_Tambahan__c = 'Bukti Transfer/VA/OB;Fotokopi KTP PP';
        ctrl.logBookDetail.E_Form__c = true;
        ctrl.logBookDetail.EForm__c = true;
        ctrl.logBookDetail.Transaction_Type__c = 'Request';


        ctrl.selectedDokumen = 'FP5, Buku Polis';
        ctrl.selectedForm = 'Formulir Deklarasi Individu (CRS)';
        ctrl.attachmentStrBody = 'bodyPart1,bodyPart2,bodyPart3';
        ctrl.attachmentStrName = '["file1.pdf", "image.jpg", "doc.txt"]';
        ctrl.attachmentStrType = '["application/pdf", "image/jpeg", "text/plain"]';


        
        ctrl.getCekCourier();
        System.debug('logBookDetail email :'+ctrl.logBookDetail);
        
        ctrl.onChangeTouchpoint();
        ctrl.getItems();
        ctrl.getDokumen();

        ctrl.addPolicyandAutoPopulate();
        ctrl.addPolicy();

        pageRef = ctrl.done();
        System.assert(pageRef != null);
        System.assertEquals(Page.LogBookActivitiy.getURL(), pageRef.getURL());
        Test.stopTest();
    }
    @isTest
    static void testCreatePOSJapenNull(){
        Contact policyContact = [SELECT id FROM Contact WHERE Policy_No__c = '801-1110001' LIMIT 1];
        Log_Book_Activitiy__c dataExisting = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001' LIMIT 1];
        
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        pageRef.getParameters().put('editQ', 'true');
        pageRef.getParameters().put('editQTimeServed', '12:12');
        pageRef.getParameters().put('tabletEmail', 'amfs@gmail.com');
        pageRef.getParameters().put('policyId', policyContact.Id);
        pageRef.getParameters().put('csSubject', 'csSubject');
        pageRef.getParameters().put('policyNumber', '123123123');
        pageRef.getParameters().put('emailP', 'emailP@email.com');
        pageRef.getParameters().put('telpP', '088822224344');
        pageRef.getParameters().put('nameHolderP', 'nameHolderP');
        pageRef.getParameters().put('productType', 'productType');
        pageRef.getParameters().put('isPolicyHolder', 'true');
        pageRef.getParameters().put('customerName', 'JHONNY DUMMY');
        pageRef.getParameters().put('customerRelation', 'customer');
        pageRef.getParameters().put('emailNonPP', 'emailNonPP@mail.com');
        pageRef.getParameters().put('phoneNonPP', '0888222243333');
        pageRef.getParameters().put('description', 'remark test');
        pageRef.getParameters().put('logbookactivitiyid', dataExisting.Id);

        Test.setCurrentPage(pageRef);
        Test.startTest();
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.isTanpaFormUtama = true;
        ctrl.isJapenPOS = true;
        ctrl.isEditQueue = true;
        ctrl.saveSearchPolicyId = '123123123';
        Datetime dtNow = Datetime.now();
        ctrl.logBook.Touch_Point__c = 'Head Office';
        ctrl.logBook.Log_Book_Date__c = Date.today();
        ctrl.logBook.Queue_No__c = 'A100';
        ctrl.logBook.Time_In__c = dtNow.time();
        
        ctrl.logBookDetail.Policy_Number__c = '101-000-1110001';
        ctrl.logBookDetail.Policy_Name_Holder__c = 'JACK BROWN';
        ctrl.logBookDetail.Product_Type__c = 'RLS';
        ctrl.logBookDetail.Is_Policy_Holder__c = true;
        ctrl.logBookDetail.Customer_Name__c = 'JACK BROWN';
        ctrl.logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        ctrl.logBookDetail.Is_Policy_Holder__c =  true;
        ctrl.logBookDetail.Segmentation__c = 'Reguler';
        ctrl.logBookDetail.Department__c = 'POS';
        ctrl.changeDepart();
        ctrl.logBookDetail.Kind_Of_Transaction__c = 'Request_POS_Japen Non Financial';
        ctrl.logBookDetail.Form_Tambahan__c = 'FP5';
        ctrl.checkCaseType();
        ctrl.getDocSpec();
        ctrl.logBookDetail.Document_Type__c = 'Japen';
        ctrl.logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];Fotokopi Buku Nikah[Copy]';
        ctrl.logBookDetail.Stamp__c = 1;
        ctrl.logBookDetail.Customer_Mood__c = 'Normal'; 
        ctrl.logBookDetail.Status__c = 'New';
        ctrl.logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        ctrl.logBookDetail.email_pp__c = 'tes@gmail.com';
        ctrl.logBookDetail.Dokumen_Tambahan__c = 'Bukti Transfer/VA/OB;Fotokopi KTP PP';
        ctrl.logBookDetail.E_Form__c = true;
        ctrl.logBookDetail.EForm__c = true;
        ctrl.logBookDetail.Transaction_Type__c = 'Request';

        ctrl.selectedDokumen = 'FP5, Buku Polis';
        ctrl.selectedForm = 'Formulir Deklarasi Individu (CRS)';
        ctrl.attachmentStrBody = 'bodyPart1,bodyPart2,bodyPart3';
        ctrl.attachmentStrName = '["file1.pdf", "image.jpg", "doc.txt"]';
        ctrl.attachmentStrType = '["application/pdf", "image/jpeg", "text/plain"]';


        
        ctrl.getCekCourier();
        System.debug('logBookDetail email :'+ctrl.logBookDetail);
        
        ctrl.onChangeTouchpoint();
        ctrl.getItems();
        ctrl.getDokumen();

        ctrl.addPolicyandAutoPopulate();
        ctrl.addPolicy();

        pageRef = ctrl.done();
        System.assert(pageRef != null);
        System.assertEquals(Page.LogBookActivitiy.getURL(), pageRef.getURL());
        Test.stopTest();
    }
    @isTest
    static void testCreatePOSMulti(){
        Contact policyContact = [SELECT id FROM Contact WHERE Policy_No__c = '801-1110001' LIMIT 1];
        Log_Book_Activitiy__c dataExisting = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001' LIMIT 1];
        
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        pageRef.getParameters().put('editQ', 'true');
        pageRef.getParameters().put('editQTimeServed', '12:12');
        pageRef.getParameters().put('tabletEmail', 'amfs@gmail.com');
        pageRef.getParameters().put('policyId', policyContact.Id);
        pageRef.getParameters().put('csSubject', 'csSubject');
        pageRef.getParameters().put('policyNumber', '123123123');
        pageRef.getParameters().put('emailP', 'emailP@email.com');
        pageRef.getParameters().put('telpP', '088822224344');
        pageRef.getParameters().put('nameHolderP', 'nameHolderP');
        pageRef.getParameters().put('productType', 'productType');
        pageRef.getParameters().put('isPolicyHolder', 'true');
        pageRef.getParameters().put('customerName', 'JHONNY DUMMY');
        pageRef.getParameters().put('customerRelation', 'customer');
        pageRef.getParameters().put('emailNonPP', 'emailNonPP@mail.com');
        pageRef.getParameters().put('phoneNonPP', '0888222243333');
        pageRef.getParameters().put('description', 'remark test');
        pageRef.getParameters().put('logbookactivitiyid', dataExisting.Id);

        Test.setCurrentPage(pageRef);
        Test.startTest();
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.isTanpaFormUtama = false;
        ctrl.isEditQueue = true;
        ctrl.saveSearchPolicyId = '123123123';
        Datetime dtNow = Datetime.now();
        ctrl.logBook.Touch_Point__c = 'Head Office';
        ctrl.logBook.Log_Book_Date__c = Date.today();
        ctrl.logBook.Queue_No__c = 'A100';
        ctrl.logBook.Time_In__c = dtNow.time();
        
        ctrl.logBookDetail.Policy_Number__c = '101-000-1110001';
        ctrl.logBookDetail.Policy_Name_Holder__c = 'JACK BROWN';
        ctrl.logBookDetail.Product_Type__c = 'RLS';
        ctrl.logBookDetail.Is_Policy_Holder__c = true;
        ctrl.logBookDetail.Customer_Name__c = 'JACK BROWN';
        ctrl.logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        ctrl.logBookDetail.Is_Policy_Holder__c =  true;
        ctrl.logBookDetail.Segmentation__c = 'Reguler';
        ctrl.logBookDetail.Department__c = 'POS';
        ctrl.changeDepart();
        ctrl.logBookDetail.Kind_Of_Transaction__c = 'Request_POS Pemulihan Polis';
        ctrl.logBookDetail.Form_Tambahan__c = 'Formulir FP5;Formulir Deklarasi Individu (CRS);Formulir Deklarasi Badan Usaha (CRS);Form Keberatan CRS';
        ctrl.checkCaseType();
        ctrl.getDocSpec();
        ctrl.logBookDetail.Document_Type__c = 'Japen';
        ctrl.logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];Fotokopi Buku Nikah[Copy]';
        ctrl.logBookDetail.Stamp__c = 1;
        ctrl.logBookDetail.Customer_Mood__c = 'Normal'; 
        ctrl.logBookDetail.Status__c = 'New';
        ctrl.logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        ctrl.logBookDetail.email_pp__c = 'tes@gmail.com';
        ctrl.logBookDetail.Dokumen_Tambahan__c = 'Bukti Transfer/VA/OB;Fotokopi KTP PP';
        ctrl.logBookDetail.E_Form__c = true;
        ctrl.logBookDetail.EForm__c = true;
        ctrl.logBookDetail.Transaction_Type__c = 'Request';

        ctrl.isMultiple = true;
        ctrl.selectedDokumen = 'FP5, Buku Polis';
        ctrl.selectedForm = 'Formulir Deklarasi Individu (CRS)';
        ctrl.attachmentStrBody = 'bodyPart1,bodyPart2,bodyPart3';
        ctrl.attachmentStrName = '["file1.pdf", "image.jpg", "doc.txt"]';
        ctrl.attachmentStrType = '["application/pdf", "image/jpeg", "text/plain"]';


        
        ctrl.getCekCourier();
        System.debug('logBookDetail email :'+ctrl.logBookDetail);
        
        ctrl.onChangeTouchpoint();
        ctrl.getItems();
        ctrl.getDokumen();

        ctrl.addPolicyandAutoPopulate();

        pageRef = ctrl.done();
        System.assert(pageRef != null);
        System.assertEquals(Page.LogBookActivitiy.getURL(), pageRef.getURL());
        Test.stopTest();
    }

    @isTest
    static void testCreatePOSAutoPopulate(){
        Contact policyContact = [SELECT id FROM Contact WHERE Policy_No__c = '801-1110001' LIMIT 1];
        Log_Book_Activitiy__c dataExisting = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001' LIMIT 1];
        
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        pageRef.getParameters().put('editQ', 'true');
        pageRef.getParameters().put('editQTimeServed', '12:12');
        pageRef.getParameters().put('tabletEmail', 'amfs@gmail.com');
        pageRef.getParameters().put('policyId', policyContact.Id);
        pageRef.getParameters().put('csSubject', 'csSubject');
        pageRef.getParameters().put('policyNumber', '123123123');
        pageRef.getParameters().put('emailP', 'emailP@email.com');
        pageRef.getParameters().put('telpP', '088822224344');
        pageRef.getParameters().put('nameHolderP', 'nameHolderP');
        pageRef.getParameters().put('productType', 'productType');
        pageRef.getParameters().put('isPolicyHolder', 'true');
        pageRef.getParameters().put('customerName', 'JHONNY DUMMY');
        pageRef.getParameters().put('customerRelation', 'customer');
        pageRef.getParameters().put('emailNonPP', 'emailNonPP@mail.com');
        pageRef.getParameters().put('phoneNonPP', '0888222243333');
        pageRef.getParameters().put('description', 'remark test');
        pageRef.getParameters().put('logbookactivitiyid', dataExisting.Id);

        Test.setCurrentPage(pageRef);
        Test.startTest();
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.isTanpaFormUtama = true;
        ctrl.isEditQueue = true;
        ctrl.saveSearchPolicyId = '123123123';
        Datetime dtNow = Datetime.now();
        ctrl.logBook.Touch_Point__c = 'Head Office';
        ctrl.logBook.Log_Book_Date__c = Date.today();
        ctrl.logBook.Queue_No__c = 'A100';
        ctrl.logBook.Time_In__c = dtNow.time();
        
        ctrl.logBookDetail.Policy_Number__c = '101-000-1110001';
        ctrl.logBookDetail.Policy_Name_Holder__c = 'JACK BROWN';
        ctrl.logBookDetail.Product_Type__c = 'RLS';
        ctrl.logBookDetail.Is_Policy_Holder__c = true;
        ctrl.logBookDetail.Customer_Name__c = 'JACK BROWN';
        ctrl.logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        ctrl.logBookDetail.Is_Policy_Holder__c =  true;
        ctrl.logBookDetail.Segmentation__c = 'Reguler';
        ctrl.logBookDetail.Department__c = 'POS';
        ctrl.changeDepart();
        ctrl.logBookDetail.Kind_Of_Transaction__c = 'Request_POS Lumpsum';
        ctrl.checkCaseType();
        ctrl.getDocSpec();
        ctrl.logBookDetail.Document_Type__c = 'Japen';
        ctrl.logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];';
        ctrl.logBookDetail.Stamp__c = 1;
        ctrl.logBookDetail.Customer_Mood__c = 'Normal'; 
        ctrl.logBookDetail.Status__c = 'Closed';
        ctrl.logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        ctrl.logBookDetail.email_pp__c = 'tes@gmail.com';
        ctrl.logBookDetail.Dokumen_Tambahan__c = 'Bukti Transfer/VA/OB;Fotokopi KTP PP';
        ctrl.logBookDetail.E_Form__c = true;
        ctrl.logBookDetail.EForm__c = true;
        ctrl.logBookDetail.Transaction_Type__c = 'Request';

        ctrl.selectedDokumen = 'FP5, Buku Polis';
        ctrl.selectedForm = 'Formulir Deklarasi Individu (CRS)';
        ctrl.isMultiple = true;
        
        ctrl.attachmentStrBody = 'bodyPart1,bodyPart2,bodyPart3';
        ctrl.attachmentStrName = '["file1.pdf", "image.jpg", "doc.txt"]';
        ctrl.attachmentStrType = '["application/pdf", "image/jpeg", "text/plain"]';

        
        ctrl.getCekCourier();
        System.debug('logBookDetail email :'+ctrl.logBookDetail);
        
        ctrl.onChangeTouchpoint();
        ctrl.getItems();
        ctrl.getDokumen();
        
        ctrl.addPolicyandAutoPopulate();
        pageRef = ctrl.done();
        System.assert(pageRef != null);
        System.assertEquals(Page.LogBookActivitiy.getURL(), pageRef.getURL());
        Test.stopTest();
    }

    @isTest
    static void testCreatePOSAutoPopulateError(){
        Contact policyContact = [SELECT id FROM Contact WHERE Policy_No__c = '801-1110001' LIMIT 1];
        Log_Book_Activitiy__c dataExisting = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001' LIMIT 1];
        
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        pageRef.getParameters().put('editQ', 'true');
        pageRef.getParameters().put('editQTimeServed', '12:12');
        pageRef.getParameters().put('tabletEmail', 'amfs@gmail.com');
        pageRef.getParameters().put('policyId', policyContact.Id);
        pageRef.getParameters().put('csSubject', 'csSubject');
        pageRef.getParameters().put('policyNumber', '123123123');
        pageRef.getParameters().put('emailP', 'emailP@email.com');
        pageRef.getParameters().put('telpP', '088822224344');
        pageRef.getParameters().put('nameHolderP', 'nameHolderP');
        pageRef.getParameters().put('productType', 'productType');
        pageRef.getParameters().put('isPolicyHolder', 'true');
        pageRef.getParameters().put('customerName', 'JHONNY DUMMY');
        pageRef.getParameters().put('customerRelation', 'customer');
        pageRef.getParameters().put('emailNonPP', 'emailNonPP@mail.com');
        pageRef.getParameters().put('phoneNonPP', '0888222243333');
        pageRef.getParameters().put('description', 'remark test');
        pageRef.getParameters().put('logbookactivitiyid', dataExisting.Id);

        Test.setCurrentPage(pageRef);
        Test.startTest();
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.isTanpaFormUtama = false;
        ctrl.isEditQueue = true;
        ctrl.saveSearchPolicyId = '123123123';
        Datetime dtNow = Datetime.now();
        ctrl.logBook.Touch_Point__c = 'Head Office';
        ctrl.logBook.Log_Book_Date__c = Date.today();
        ctrl.logBook.Queue_No__c = 'A100';
        ctrl.logBook.Time_In__c = dtNow.time();
        
        ctrl.logBookDetail.Policy_Number__c = '101-000-1110001';
        ctrl.logBookDetail.Policy_Name_Holder__c = 'JACK BROWN';
        ctrl.logBookDetail.Product_Type__c = 'RLS';
        ctrl.logBookDetail.Is_Policy_Holder__c = true;
        ctrl.logBookDetail.Customer_Name__c = 'JACK BROWN';
        ctrl.logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        ctrl.logBookDetail.Is_Policy_Holder__c =  true;
        ctrl.logBookDetail.Segmentation__c = 'Reguler';
        ctrl.logBookDetail.Department__c = 'POS';
        ctrl.changeDepart();
        ctrl.logBookDetail.Kind_Of_Transaction__c = 'Request_POS Lumpsum';
        ctrl.checkCaseType();
        ctrl.getDocSpec();
        ctrl.logBookDetail.Document_Type__c = 'Japen';
        ctrl.logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];';
        ctrl.logBookDetail.Stamp__c = 1;
        ctrl.logBookDetail.Customer_Mood__c = 'Normal'; 
        // ctrl.logBookDetail.Status__c = 'Closed';
        ctrl.logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        ctrl.logBookDetail.email_pp__c = 'tes@gmail.com';
        ctrl.logBookDetail.Dokumen_Tambahan__c = 'Bukti Transfer/VA/OB;Fotokopi KTP PP';
        ctrl.logBookDetail.E_Form__c = true;
        ctrl.logBookDetail.EForm__c = true;
        ctrl.logBookDetail.Transaction_Type__c = 'Request';

        ctrl.selectedDokumen = 'FP5, Buku Polis';
        ctrl.selectedForm = 'Formulir Deklarasi Individu (CRS)';
        ctrl.isMultiple = true;
        
        ctrl.attachmentStrBody = 'bodyPart1,bodyPart2,bodyPart3';
        ctrl.attachmentStrName = '["file1.pdf", "image.jpg", "doc.txt"]';
        ctrl.attachmentStrType = '["application/pdf", "image/jpeg", "text/plain"]';

        
        ctrl.getCekCourier();
        System.debug('logBookDetail email :'+ctrl.logBookDetail);
        
        ctrl.onChangeTouchpoint();
        ctrl.getItems();
        ctrl.getDokumen();
        
        ctrl.addPolicyandAutoPopulate();
        pageRef = ctrl.done();
        System.assert(pageRef != null);
        // System.assertEquals(Page.LogBookActivitiy.getURL(), pageRef.getURL());
        Test.stopTest();
    }

    @isTest
    static void testUntukCoverageFunctionPrivate(){
        Contact testContact = [SELECT Id FROM Contact LIMIT 1];
        Date todayDate = Date.today();
        String formattedDate = String.valueOf(todayDate);
        String validJson = '{' +
            '"logBookId": "a00XXXXXXXXXXXX",' +
            '"contactId": "' + testContact.Id + '",' + 
            '"subject": "Minimal Test Case Subject",' +
            '"transactionType": "Request",' +
            '"description": "This is a minimal test case description.",' +
            '"origin": "Email",' +
            '"status": "New",' +
            '"nonPP": true,' +
            '"receivedDate": "' + formattedDate + '"' +
        '}';
        Id caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('InquiryAMFSCase').getRecordTypeId();
        // String testEmailAddress = 'amfsemailtocase2@gmail.com';
        Datetime emailDate = System.now();
        
        Log_Book_Activitiy__c dataExisting = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001' LIMIT 1];
        
        Log_Book_Activitiy_Detail__c detailCurrent = [
            SELECT Id,Transaction_Type__c,Case_Type__c,Status__c,Is_Policy_Holder__c,
            Department__c,Kind_Of_Transaction__c,
            Email_Non_PP__c,Phone_Non_PP__c,Contact_Policy__c,Is_Non_Customer__c,
            Policy_Number__c,Remarks_Long_Text__c,Customer_Mood__c
            FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = '100-123-1234567'
            LIMIT 1
        ];
        
        Case case1 = new Case();
        case1.Status = 'New';
        case1.Origin = 'Email';
        case1.ContactId = testContact.Id;
        case1.RecordTypeId = caseRecordTypeId;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        // case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        // insert case1;
        

        Test.startTest();
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.isTanpaFormUtama = false;
        ctrl.untukCoverageFunctionPrivate(validJson,detailCurrent,case1);
        Test.stopTest();
    }

    @isTest
    static void testCreateTypeRequestPreviewPDF(){
        Test.startTest();
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.isTanpaFormUtama = false;
        Datetime myDT = Datetime.now();
        String myDTString = myDT.format('yyyy-MM-dd');

        PageReference pageRefPDF = Page.LogBookActivitiyPDF;
        pageRefPDF.getParameters().put('queue', 'A001');
        pageRefPDF.getParameters().put('touchPoint', 'Head Office');
        pageRefPDF.getParameters().put('dateLog', myDTString);
        // System.debug('pageRef : '+pageRef.getParameters());
        Test.setCurrentPage(pageRefPDF);
        ctrl.previewPDF(); 
        Test.stopTest();
    }

    @isTest
    static void testCreateTypeRequestSentEReceiptLandingPage(){
        Test.startTest();
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.isTanpaFormUtama = false;
        ctrl.isJapenPOS = true;
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        Test.setCurrentPage(pageRef);
        Datetime dtNow = Datetime.now();
        ctrl.logBook.Touch_Point__c = 'Head Office';
        ctrl.logBook.Log_Book_Date__c = Date.today();
        ctrl.logBook.Queue_No__c = 'A002';
        ctrl.logBook.Time_In__c = dtNow.time();
        
        ctrl.logBookDetail.Policy_Number__c = '100-000-1110001';
        ctrl.logBookDetail.Policy_Name_Holder__c = 'JACK JHON';
        ctrl.logBookDetail.Product_Type__c = 'DMTM';
        ctrl.logBookDetail.Is_Policy_Holder__c = true;
        ctrl.logBookDetail.Customer_Name__c = 'JACK JHON';
        ctrl.logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        ctrl.logBookDetail.Is_Policy_Holder__c =  true;
        ctrl.logBookDetail.Segmentation__c = 'Reguler';
        ctrl.logBookDetail.Department__c = 'ADS';
        ctrl.changeDepart();
        ctrl.logBookDetail.Kind_Of_Transaction__c = 'Request_POS_Japen Non Financial';
        ctrl.logBookDetail.Form_Utama__c = 'Request_POS_ Perubahan Alamat email';
        ctrl.logBookDetail.Form_Tambahan__c = 'Formulir FP5';
        ctrl.checkCaseType();
        ctrl.getDocSpec();
        ctrl.logBookDetail.Document_Type__c = 'Japen';
        ctrl.logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];Fotokopi Buku Nikah[Copy]';
        ctrl.logBookDetail.Stamp__c = 1;
        ctrl.logBookDetail.Customer_Mood__c = 'Normal'; 
        ctrl.logBookDetail.Status__c = 'Closed';
        ctrl.logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        ctrl.logBookDetail.email_pp__c = 'tes@gmail.com';
        ctrl.isMultiple = true;
        ctrl.selectedDokumen = 'FP5, Buku Polis';
        ctrl.selectedForm = 'Formulir Deklarasi Individu (CRS), Formulir Deklarasi Badan Usaha (CRS)';
        ctrl.attachmentStrBody = 'bodyPart1,bodyPart2,bodyPart3';
        ctrl.attachmentStrName = '["file1.pdf", "image.jpg", "doc.txt"]';
        ctrl.attachmentStrType = '["application/pdf", "image/jpeg", "text/plain"]';

        ctrl.addPolicyandAutoPopulate();
        ctrl.addPolicy();
        ctrl.getCekCourier();
        System.debug('logBookDetail email :'+ctrl.logBookDetail);
        pageRef = ctrl.done();
        // System.assert(pageRef != null);
        // System.assertEquals(Page.LogBookActivitiy.getURL(), pageRef.getURL());
        
         
        PageReference pageRefPDF = Page.LogBookActivitiyPDF;
        pageRefPDF.getParameters().put('queue', 'A001');
        pageRefPDF.getParameters().put('touchPoint', 'Head Office');
        pageRefPDF.getParameters().put('dateLog', '2021-01-20');  
        // System.debug('pageRef : '+pageRef.getParameters());
        Test.setCurrentPage(pageRefPDF); 
        ctrl.landingPage(); 
        Test.stopTest();
    }
    @isTest
    static void testSetupVariable(){
        Test.startTest();
        Contact testContact = new Contact(
            FirstName = 'Test',
            LastName = 'User',
            Email = 'testuser@example.com'
        );
        insert testContact;

        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.isTanpaFormUtama = false;
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        pageRef.getParameters().put('editQ', 'true');
        pageRef.getParameters().put('editQTimeServed', '12:12');
        pageRef.getParameters().put('tabletEmail', 'amfs@gmail.com');
        
        ctrl.sensitiveCustomer = 'Yes';
        ctrl.caseTypeFieldId = '0000';
        ctrl.csoName = 'expectedCsoName';
        ctrl.city = 'expectedCity';
        ctrl.isInsert = false;
        ctrl.contacts = testContact;

        DateTime testTime = DateTime.newInstance(2025, 7, 18, 10, 30, 0);

        DateTime initialDateTimeTest = ctrl.datetimenow;
        ctrl.datetimenow = testTime;
        ctrl.mapLogBookDetailList = new Map<String,Log_Book_Activitiy_Detail__c>();
        ctrl.logCase = new Case(Subject = 'Test Case Subject', Status = 'New', Origin = 'Web');
        ctrl.showbuttonPCIDSS = true;
        ctrl.SendEmail = true;
        ctrl.ContactKYC = 'Test KYC';
        ctrl.beneficialOwner = true;
        ctrl.caseId = '500000000000001AAA'; // ID dummy
        ctrl.totalAttach = 5;

        List<String> expectedDocInfo = new List<String>{'Doc A', 'Doc B', 'Doc C'};
        ctrl.docInformation = expectedDocInfo;
        ctrl.TabletEmail = 'test@example.com';
        ctrl.saveIsPolicyHolder = true;
        ctrl.saveCustomerName = 'Customer Name';
        ctrl.saveCustomerRelation = 'Self';
        ctrl.saveEmailNonPP = 'nonpp@example.com';
        ctrl.savePhoneNonPP = '1234567890';
        ctrl.saveCSSubject = 'CS Subject';
        ctrl.saveDescription = 'Test Description';
        ctrl.labelEmailTemplateCustomer = 'Template A';
        ctrl.labelEmailTemplateDipcad = 'Template B';
        ctrl.isButtonDisabled = true;
        
        List<String> retrievedDocInfo = ctrl.getDocInformation();
        List<Attachment> cekAttc = ctrl.getNewAttachments();
        Test.setCurrentPage(pageRef);

        ctrl.getRedirectToOtherPage();
        ctrl.getRedirectToLBA();
        ctrl.getMultiPicklist();
        ctrl.onChangeTouchpoint();
        ctrl.getItems();
        ctrl.getDokumen();

        ctrl.getTouchPoints();
        ctrl.getKindOfTransaction();
        ctrl.init();
        
        System.assertEquals(6, ctrl.listDetail.size());
        ctrl.logBookDate = String.valueOf(Date.today());
        ctrl.logBook.Touch_Point__c = 'All';
        // ctrl.logBookDetail.Kind_Of_Transaction__c = 'All';
        ctrl.logBookDetail.Policy_Number__c = '100-123-1234567';
        ctrl.inquirySearch(); 
        System.assertEquals(1, ctrl.listDetail.size());
        System.assertEquals('100-123-1234567', ctrl.listDetail.get(0).Policy_Number__c);
        Test.stopTest();
    }

    
    @isTest
    static void testsendEmailDipcad(){
        Log_Book_Activitiy__c dataExisting = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001' LIMIT 1];
        Log_Book_Activitiy_Detail__c detailCurrent = [
            SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = '100-123-1234567'
        ];

        Test.startTest();
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.logBook = dataExisting;
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        pageRef.getParameters().put('lbdId', dataExisting.Id);
        // PageReference dipcadBtn = ctrl.sendEmailtoDipcad();
        PageReference dipcadBtnTest = ctrl.sendMetadatatoDipcad();
        LogBookActivitiyController.sendEmailandMetadata(dataExisting.Id);
        // System.assertEquals(null, dipcadBtn);
        Test.stopTest();
    }
    @isTest
    static void testSendEmailtoTablet(){
        Log_Book_Activitiy__c dataExisting = [SELECT Id,Touch_Point__c,Queue_No__c FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001' LIMIT 1];
        Log_Book_Activitiy_Detail__c detailCurrent = [
            SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = '100-123-1234567'
        ];
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        ctrl.logBook = dataExisting;
        Test.setCurrentPage(pageRef);
        Test.startTest();
        PageReference clickBtn = ctrl.sendEmail();
        ctrl.sendEmail(dataExisting.Id,'detail');
        System.assertEquals(null, clickBtn);
        Test.stopTest();
    }

    @isTest
    static void testsendEmailTabletDetail(){
        Log_Book_Activitiy__c dataExisting = [SELECT Id,Touch_Point__c,Queue_No__c FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001' LIMIT 1];
        Log_Book_Activitiy_Detail__c detailCurrent = [
            SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = '100-123-1234567'
        ];
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        ctrl.logBook = dataExisting;
        Test.setCurrentPage(pageRef);
        Test.startTest();
        PageReference clickBtn = ctrl.sendEmail();
        ctrl.sendEmail('xxxxx','detail');
        System.assertEquals(null, clickBtn);
        Test.stopTest();
    }

    /* NOT USED
    @isTest
    static void testsendEmailDipcadActivity(){
        Log_Book_Activitiy__c dataExisting = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001' LIMIT 1];
        Log_Book_Activitiy_Detail__c detailCurrent = [
            SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = '100-123-1234567'
        ];
        Test.startTest();
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.logBook = dataExisting;
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        pageRef.getParameters().put('lbdId', detailCurrent.Id);
        Test.setCurrentPage(pageRef);

        PageReference dipcadBtn = ctrl.sendEmailtoDipcad();
        String getPdf = ctrl.getContentType('PDF');
        String getPng = ctrl.getContentType('PNG');
        String getJpg = ctrl.getContentType('JPG');
        System.assertEquals(null, dipcadBtn);
        System.assertEquals('application/pdf', getPdf);
        System.assertEquals('image/png', getPng);
        System.assertEquals('image/jpeg', getJpg);
        Test.stopTest();
    }

    @isTest
    static void testsendEmailDipcadLargeSize(){
        Log_Book_Activitiy__c dataExisting = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001' LIMIT 1];
        Log_Book_Activitiy_Detail__c detailCurrent = [
            SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = '100-123-1234567'
        ];

        Test.startTest();
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        ctrl.logBook = dataExisting;
        LogBookActivitiyController.injectSizeAttachment = 5;
        LogBookActivitiyController.injectTotalSizeAttachment = 20;
        PageReference pageRef = Page.CreateLogBookActivitiy;
        pageRef.getParameters().put('type', 'Walk-In');
        PageReference dipcadBtn = ctrl.sendEmailtoDipcad();
        System.assertEquals(null, dipcadBtn);
        Test.stopTest();
    }
    */

}