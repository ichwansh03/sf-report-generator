/**
 * @description       : 
 * @author            : Ahmad Yazid Munif
 * @group             : 
 * @last modified on  : 09-22-2025
 * @last modified by  : Ahmad Yazid Munif
**/
@isTest
private class AMFS_PreviewLogBookDokumenControllerTest {
    @testSetup
    static void setupTestData() {
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
         
        System.debug('lbResult.success ? '+lbResult.isSuccess());
        System.debug('lbResult.id ? '+lbResult.getId());
        
        Log_Book_Activitiy_Detail__c  logBookDetail = new Log_Book_Activitiy_Detail__c();
        logBookDetail.Policy_Number__c = '100-123-1234567';
        logBookDetail.Policy_Name_Holder__c = 'RIRIN LINDAWATI';
        logBookDetail.Product_Type__c = 'DMTM';
        logBookDetail.Customer_Name__c = 'ririn';
        logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        logBookDetail.Is_Policy_Holder__c =  true;
        logBookDetail.Segmentation__c = 'Reguler';
        logBookDetail.Department__c = 'ADS';
        logBookDetail.Kind_Of_Transaction__c = 'Request_ADS Pemulihan Polis';
        logBookDetail.Document_Type__c = 'New Submission';
        logBookDetail.Dokumen_Tambahan__c = 'KTP (Copy)';
        logBookDetail.Preview_Document__c = true;
        logBookDetail.Canceled__c = false;
        // logBookDetail.Form_Tambahan__c = 'Formulir Deklarasi Individu (CRS)';
        logBookDetail.EForm__c = true;
        logBookDetail.E_Form__c = true;
        logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];';
        logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logBookDetail.Stamp__c = 2;
        logBookDetail.Customer_Mood__c = 'Normal';
        logBookDetail.Status__c = 'Closed';
        logBookDetail.Log_Book_Activitiy__c = lbResult.getId();
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
        logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];';
        logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logBookDetail.Stamp__c = 1; 
        logBookDetail.Customer_Mood__c = 'Normal';
        logBookDetail.Need_CR__c = 'Yes';
        logBookDetail.Status__c = 'Closed';
        logBookDetail.Dokumen_Tambahan__c = 'KTP (Copy)';
        logBookDetail.Preview_Document__c = true;
        logBookDetail.Canceled__c = false;
        logBookDetail.Form_Tambahan__c = 'Formulir Deklarasi Individu (CRS)';
        logBookDetail.EForm__c = true;
        logBookDetail.E_Form__c = true;
        logBookDetail.Status_to_Metadata__c = 'Success';
        logBookDetail.Status_Metadata__c = '{"068BK000004CwSXYA0":{"status":"Success","id":"068BK000004CwSXYA0"},"068BK000004CwPJYA0":{"status":"Success","id":"068BK000004CwPJYA0"},"068BK000004CwU9YAK":{"status":"Success","id":"068BK000004CwU9YAK"}}';
        logBookDetail.Contact_Policy__c = cont.Id;
        logBookDetail.Log_Book_Activitiy__c = lbResult.getId();
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
        logBookDetail.Kind_Of_Transaction__c = 'Request_POS_Redemption';
        logBookDetail.Document_Type__c = 'Japen';
        logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];';
        logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logBookDetail.Stamp__c = 1; 
        logBookDetail.Customer_Mood__c = 'Normal';
        logBookDetail.Need_CR__c = 'Yes';
        logBookDetail.Status__c = 'Closed';
        logBookDetail.Dokumen_Tambahan__c = 'KTP (Copy)';
        logBookDetail.Form_Tambahan__c = 'Formulir Deklarasi Individu (CRS)';
        logBookDetail.EForm__c = true;
        logBookDetail.E_Form__c = true;
        logBookDetail.Preview_Document__c = true;
        logBookDetail.Canceled__c = false;
        logBookDetail.Status_to_Metadata__c = 'Failed';
        logBookDetail.Status_Metadata__c = '{"068BK000004CwSXYA0":{"status":"Failed","id":"068BK000004CwSXYA0"},"068BK000004CwPJYA0":{"status":"Failed","id":"068BK000004CwPJYA0"},"068BK000004CwU9YAK":{"status":"Failed","id":"068BK000004CwU9YAK"}}';
        logBookDetail.Contact_Policy__c = cont.Id;
        logBookDetail.Log_Book_Activitiy__c = lbResult.getId();
        listDetail.add(logBookDetail);
        
        Log_Book_Activitiy__c logbook2 = new Log_Book_Activitiy__c();
        logbook2.Touch_Point__c = 'Head Office';
        logbook2.Log_Book_Date__c = Date.today();
        logbook2.Queue_No__c = 'A101';
        logbook2.Time_In__c = Time.newInstance(15, 0, 0, 0);
        logbook2.Time_Served__c = Time.newInstance(15, 3, 0, 0);
        logbook2.Time_Out__c = Time.newInstance(15, 20, 0, 0);
        logbook2.Waiting_Time__c = '0 hours 3 minutes';
        logbook2.Handling_Time__c = '0 hours 17 minutes';
        logbook2.Type__c = 'Walk-In';
        Database.SaveResult lbResult2 = Database.insert(logbook2);
         
        Log_Book_Activitiy_Detail__c  logbookDetail2 = new Log_Book_Activitiy_Detail__c();
        logbookDetail2.Policy_Number__c = '100-123-1234555';
        logbookDetail2.Policy_Name_Holder__c = 'RIRIN LINDAWATI';
        logbookDetail2.Product_Type__c = 'DMTM';
        logbookDetail2.Customer_Name__c = 'ririn';
        logbookDetail2.Customer_Relation__c = 'Diri Sendiri';
        logbookDetail2.Is_Policy_Holder__c =  true;
        logbookDetail2.Segmentation__c = 'Reguler';
        logbookDetail2.Department__c = 'ADS';
        logbookDetail2.Kind_Of_Transaction__c = 'Request_ADS - Rekening Penerimaan NCB';
        logbookDetail2.Document_Type__c = 'New Submission';
        logbookDetail2.Document_Information__c = 'Fotokopi KTP[Copy];';
        logbookDetail2.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logbookDetail2.Dokumen_Tambahan__c = 'KTP (Copy);';
        logbookDetail2.Stamp__c = 2;
        logBookDetail2.EForm__c = true;
        logbookDetail2.Customer_Mood__c = 'Normal';
        logbookDetail2.Status__c = 'Closed';
        logbookDetail2.Log_Book_Activitiy__c = lbResult2.getId();
        listDetail.add(logbookDetail2);
        
        LogBookActivitiyController ctrl2 = new LogBookActivitiyController();
        ctrl2.getListOfKYC();
        List<Database.SaveResult> lbdResults = Database.insert(listDetail);

        // insert detail;
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
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
        ctrl.selectedDokumen = 'Fotokopi KTP';
        ctrl.selectedForm = 'Formulir Deklarasi Individu (CRS)';
        ctrl.selectedCaseTypeKeeper = 'Tanya Mekanisme Prosedur <br />';
        ctrl.addPolicy();
        pageRef = ctrl.done();

        Log_Book_Activitiy_Detail__c detail = [SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = '100-321-7654321' LIMIT 1];
        // 3. Buat record E_Form_Master_Data__c yang terkait dengan detail
        E_Form_Master_Data__c eForm = new E_Form_Master_Data__c(
            Name = 'Lumpsum - 100-321-7654321',
            Log_Book_Activitiy_Detail__c = detail.Id,
            Metadata__c = '{"EFORM Nama Tertanggung":"SITTI HAJAR","EFORM Segmentation":"NON PBC","EFORM Tanggal Lahir Polis":"04/10/1980","EFORM Email Polis":" ","EFORM Telepon Polis":"085262649482","EFORM Alamat Domisili Polis":"DSN.KESEHATAN DS.TANOH ANOU KEC.IDI RAYEUK ACEH TIMUR.NAD","EFORM Pemegang Polis":"RODRIGO DUMMY","EFORM Informasi Tambahan":"testing fp5 perubahan alamat email","EFORM Log Book Activitiy Detail":"a1xBK0000018PiDYAU","EFORM Name":"FP5 - 100-120-1883808","EFORM Id":"a3aBK000000QIxNYAW"}'
        );
        insert eForm;

        Log_Book_Activitiy_Detail__c detail2 = [SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = '100-123-1234555' LIMIT 1];
        E_Form_Master_Data__c eForm2 = new E_Form_Master_Data__c(
            Name = 'Lumpsum - 100-321-7654321',
            Log_Book_Activitiy_Detail__c = detail2.Id,
            Metadata__c = '{"EFORM Nama Tertanggung":"SITTI HAJAR","EFORM Segmentation":"NON PBC","EFORM Tanggal Lahir Polis":"04/10/1980","EFORM Email Polis":" ","EFORM Telepon Polis":"085262649482","EFORM Alamat Domisili Polis":"DSN.KESEHATAN DS.TANOH ANOU KEC.IDI RAYEUK ACEH TIMUR.NAD","EFORM Pemegang Polis":"RODRIGO DUMMY","EFORM Informasi Tambahan":"testing fp5 perubahan alamat email","EFORM Log Book Activitiy Detail":"a1xBK0000018PiDYAU","EFORM Name":"FP5 - 100-120-1883808","EFORM Id":"a3aBK000000QIxNYAW"}'
        );
        insert eForm2;
        Log_Book_Activitiy_Detail__c detail3a = [SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Kind_Of_Transaction__c = 'Request_ADS Pemulihan Polis' LIMIT 1];
        E_Form_Master_Data__c eForm3 = new E_Form_Master_Data__c(
            Name = 'Pemulihan Polis - 100-321-7654321',
            Log_Book_Activitiy_Detail__c = detail3a.Id,
            Metadata__c = '{"EFORM Nama Tertanggung":"SITTI HAJAR","EFORM Segmentation":"NON PBC","EFORM Tanggal Lahir Polis":"04/10/1980","EFORM Email Polis":" ","EFORM Telepon Polis":"085262649482","EFORM Alamat Domisili Polis":"DSN.KESEHATAN DS.TANOH ANOU KEC.IDI RAYEUK ACEH TIMUR.NAD","EFORM Pemegang Polis":"RODRIGO DUMMY","EFORM Informasi Tambahan":"testing fp5 perubahan alamat email","EFORM Log Book Activitiy Detail":"a1xBK0000018PiDYAU","EFORM Name":"FP5 - 100-120-1883808","EFORM Id":"a3aBK000000QIxNYAW"}'
        );
        insert eForm3;

        E_Form_Master_Data__c eForm4= new E_Form_Master_Data__c(
            Name = 'Keberatan Usaha - 100-321-7654321',
            Log_Book_Activitiy_Detail__c = detail3a.Id,
            Metadata__c = '{"EFORM Nama Tertanggung":"SITTI HAJAR","EFORM Segmentation":"NON PBC","EFORM Tanggal Lahir Polis":"04/10/1980","EFORM Email Polis":" ","EFORM Telepon Polis":"085262649482","EFORM Alamat Domisili Polis":"DSN.KESEHATAN DS.TANOH ANOU KEC.IDI RAYEUK ACEH TIMUR.NAD","EFORM Pemegang Polis":"RODRIGO DUMMY","EFORM Informasi Tambahan":"testing fp5 perubahan alamat email","EFORM Log Book Activitiy Detail":"a1xBK0000018PiDYAU","EFORM Name":"FP5 - 100-120-1883808","EFORM Id":"a3aBK000000QIxNYAW"}'
        );
        insert eForm4;
        // 4. Buat ContentVersion record.
        ContentVersion cv = new ContentVersion(
            Title = 'Lumpsum - 100-321-7654321',
            PathOnClient = 'Lumpsum - 100-321-7654321.pdf',
            VersionData = Blob.valueOf('Test file content')
        );
        insert cv;
        ContentVersion cv2 = new ContentVersion(
            Title = 'KTP (Copy) - 100-321-7654321',
            PathOnClient = 'KTP (Copy) - 100-321-7654321.pdf',
            VersionData = Blob.valueOf('Test file KTP')
        );
        insert cv2;
        ContentVersion cv3 = new ContentVersion(
            Title = 'KTP (Copy) - 100-123-1234567',
            PathOnClient = 'KTP (Copy) - 100-123-1234567.pdf',
            VersionData = Blob.valueOf('Test file KTP 100-123-1234567')
        );
        insert cv3;
        ContentVersion cv4 = new ContentVersion(
            Title = 'KK (Copy) - 100-123-1234567',
            PathOnClient = 'KK (Copy) - 100-123-1234567.pdf',
            VersionData = Blob.valueOf('Test file KK 100-123-1234567')
        );
        insert cv4;
        ContentVersion cv5 = new ContentVersion(
            Title = 'Pemulihan Polis - 100-123-1234567',
            PathOnClient = 'Pemulihan Polis - 100-123-1234567.pdf',
            VersionData = Blob.valueOf('Test file KK 100-123-1234567')
        );
        insert cv5;
        ContentVersion cv6 = new ContentVersion(
            Title = 'Formulir Keberatan - 100-123-1234567',
            PathOnClient = 'Bukti Transfer - 100-123-1234567.pdf',
            VersionData = Blob.valueOf('Test file KK 100-123-1234567')
        );
        insert cv6;

        cv = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id LIMIT 1];
        cv2 = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :cv2.Id LIMIT 1];
        cv3 = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :cv3.Id LIMIT 1];
        cv4 = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :cv4.Id LIMIT 1];
        cv5 = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :cv5.Id LIMIT 1];
        cv6 = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :cv6.Id LIMIT 1];
        // 5. Buat ContentDocumentLink record dengan mengaitkan ContentDocument ke E_Form_Master_Data__c
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

        Log_Book_Activitiy_Detail__c detail3 = [SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = '100-123-1234567' LIMIT 1];
        ContentDocumentLink cdl3 = new ContentDocumentLink(
            ContentDocumentId = cv3.ContentDocumentId,
            LinkedEntityId = detail3.Id,
            ShareType = 'V',
            Visibility = 'AllUsers'
        );
        insert cdl3;
        ContentDocumentLink cdl4 = new ContentDocumentLink(
            ContentDocumentId = cv4.ContentDocumentId,
            LinkedEntityId = detail3.Id,
            ShareType = 'V',
            Visibility = 'AllUsers'
        );
        insert cdl4;
        
        ContentDocumentLink cdl6 = new ContentDocumentLink(
            ContentDocumentId = cv6.ContentDocumentId,
            LinkedEntityId = eForm4.Id,
            ShareType = 'V',
            Visibility = 'AllUsers'
        );
        insert cdl6;

        ContentDocumentLink cdl5 = new ContentDocumentLink(
            ContentDocumentId = cv5.ContentDocumentId,
            LinkedEntityId = eForm3.Id,
            ShareType = 'V',
            Visibility = 'AllUsers'
        );
        insert cdl5;
        Log_Book_Activitiy_Detail__c detail4 = [SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Kind_Of_Transaction__c = 'Request_ADS Pemulihan Polis' LIMIT 1];

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

        List<Master_Document_Type__c> docTypeData = new List<Master_Document_Type__c>();
        docTypeData.add(new Master_Document_Type__c(
            Name = 'KTP (Copy)',
            Document_Type_ADS__c = 'ADSID1POSSD1',
            Document_Type_POS__c = 'POSID1AFTKTP'
        ));
        docTypeData.add(new Master_Document_Type__c(
            Name = 'Lumpsum',
            Document_Type_ADS__c = '',
            Document_Type_POS__c = 'POSID1PPADI1'
        ));
        docTypeData.add(new Master_Document_Type__c(
            Name = 'Pemulihan Polis',
            Document_Type_ADS__c = 'ADSID1POSSD1',
            Document_Type_POS__c = 'POSID1PPADI1'
        ));
        insert docTypeData;

        // for submit metadata
        Log_Book_Activitiy__c logBookSuccess = new Log_Book_Activitiy__c();
        logBookSuccess.Touch_Point__c = 'Head Office';
        logBookSuccess.Log_Book_Date__c = Date.today();
        logBookSuccess.Queue_No__c = 'C1000';
        logBookSuccess.Time_In__c = Time.newInstance(15, 0, 0, 0);
        logBookSuccess.Time_Served__c = Time.newInstance(15, 3, 0, 0);
        logBookSuccess.Time_Out__c = Time.newInstance(15, 20, 0, 0);
        logBookSuccess.Waiting_Time__c = '0 hours 3 minutes';
        logBookSuccess.Handling_Time__c = '0 hours 17 minutes';
        logBookSuccess.Type__c = 'Walk-In';
        Database.SaveResult lbResultSuccess = Database.insert(logBookSuccess);

        Log_Book_Activitiy__c logBookFailed = new Log_Book_Activitiy__c();
        logBookFailed.Touch_Point__c = 'Head Office';
        logBookFailed.Log_Book_Date__c = Date.today();
        logBookFailed.Queue_No__c = 'C2000';
        logBookFailed.Time_In__c = Time.newInstance(15, 0, 0, 0);
        logBookFailed.Time_Served__c = Time.newInstance(15, 3, 0, 0);
        logBookFailed.Time_Out__c = Time.newInstance(15, 20, 0, 0);
        logBookFailed.Waiting_Time__c = '0 hours 3 minutes';
        logBookFailed.Handling_Time__c = '0 hours 17 minutes';
        logBookFailed.Type__c = 'Walk-In';
        Database.SaveResult lbResultFailed = Database.insert(logBookFailed);

        Log_Book_Activitiy_Detail__c  logBookDetailSuccess = new Log_Book_Activitiy_Detail__c();
        logBookDetailSuccess.Policy_Number__c = '100-321-76534433';
        logBookDetailSuccess.Policy_Name_Holder__c = 'RITA DWININGTIAS';
        logBookDetailSuccess.Product_Type__c = 'DMTM';
        logBookDetailSuccess.Customer_Name__c = 'ririn';
        logBookDetailSuccess.Customer_Relation__c = 'Diri Sendiri';
        logBookDetailSuccess.Is_Policy_Holder__c =  true;
        logBookDetailSuccess.Segmentation__c = 'Reguler';
        logBookDetailSuccess.Department__c = 'POS';
        logBookDetailSuccess.Kind_Of_Transaction__c = 'Request_POS_Redemption';
        logBookDetailSuccess.Document_Type__c = 'Japen';
        logBookDetailSuccess.Document_Information__c = 'Fotokopi KTP[Copy];';
        logBookDetailSuccess.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logBookDetailSuccess.Stamp__c = 1; 
        logBookDetailSuccess.Customer_Mood__c = 'Normal';
        logBookDetailSuccess.Need_CR__c = 'Yes';
        logBookDetailSuccess.Status__c = 'Closed';
        logBookDetailSuccess.Dokumen_Tambahan__c = 'KTP (Copy)';
        logBookDetailSuccess.Form_Tambahan__c = 'Formulir Deklarasi Individu (CRS)';
        logBookDetailSuccess.EForm__c = true;
        logBookDetailSuccess.E_Form__c = true;
        logBookDetailSuccess.Preview_Document__c = true;
        logBookDetailSuccess.Canceled__c = false;
        logBookDetailSuccess.Status_to_Metadata__c = 'Success';
        logBookDetailSuccess.Status_Metadata__c = '{"068BK000004CwSXYA0":{"status":"Success","id":"068BK000004CwSXYA0"},"068BK000004CwPJYA0":{"status":"Success","id":"068BK000004CwPJYA0"},"068BK000004CwU9YAK":{"status":"Success","id":"068BK000004CwU9YAK"}}';
        logBookDetailSuccess.Contact_Policy__c = cont.Id;
        logBookDetailSuccess.Log_Book_Activitiy__c = lbResultSuccess.getId();
        insert logBookDetailSuccess;

        Log_Book_Activitiy_Detail__c  logBookDetailFailed = new Log_Book_Activitiy_Detail__c();
        logBookDetailFailed.Policy_Number__c = '100-321-76536644';
        logBookDetailFailed.Policy_Name_Holder__c = 'RITA DWININGTIAS';
        logBookDetailFailed.Product_Type__c = 'DMTM';
        logBookDetailFailed.Customer_Name__c = 'ririn';
        logBookDetailFailed.Customer_Relation__c = 'Diri Sendiri';
        logBookDetailFailed.Is_Policy_Holder__c =  true;
        logBookDetailFailed.Segmentation__c = 'Reguler';
        logBookDetailFailed.Department__c = 'POS';
        logBookDetailFailed.Kind_Of_Transaction__c = 'Request_POS_Redemption';
        logBookDetailFailed.Document_Type__c = 'Japen';
        logBookDetailFailed.Document_Information__c = 'Fotokopi KTP[Copy];';
        logBookDetailFailed.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logBookDetailFailed.Stamp__c = 1; 
        logBookDetailFailed.Customer_Mood__c = 'Normal';
        logBookDetailFailed.Need_CR__c = 'Yes';
        logBookDetailFailed.Status__c = 'Closed';
        logBookDetailFailed.Dokumen_Tambahan__c = 'KTP (Copy)';
        logBookDetailFailed.Form_Tambahan__c = 'Formulir Deklarasi Individu (CRS)';
        logBookDetailFailed.EForm__c = true;
        logBookDetailFailed.E_Form__c = true;
        logBookDetailFailed.Preview_Document__c = true;
        logBookDetailFailed.Canceled__c = false;
        logBookDetailFailed.Status_to_Metadata__c = 'Failed';
        logBookDetailFailed.Status_Metadata__c = '{"068BK000004CwSXYA0":{"status":"Failed","id":"068BK000004CwSXYA0"},"068BK000004CwPJYA0":{"status":"Failed","id":"068BK000004CwPJYA0"},"068BK000004CwU9YAK":{"status":"Failed","id":"068BK000004CwU9YAK"}}';
        logBookDetailFailed.Contact_Policy__c = cont.Id;
        logBookDetailFailed.Log_Book_Activitiy__c = lbResultFailed.getId();
        insert logBookDetailFailed;
    }

    static testMethod void testConstructorWithRecordId() {
        Log_Book_Activitiy__c testLogBook = [SELECT Id FROM Log_Book_Activitiy__c LIMIT 1];
        
        PageReference pageRef = new PageReference('/apex/AMFS_PreviewLogBookDokumen?recordId=' + testLogBook.Id);
        Test.setCurrentPage(pageRef);
        
        AMFS_PreviewLogBookDokumenController controller = new AMFS_PreviewLogBookDokumenController();
        
        System.assertEquals(testLogBook.Id, controller.recordId, 'recordId harus sama dengan parameter yang diberikan.');
        System.assert(controller.errorMessage == null || controller.errorMessage == '', 
            'errorMessage harus kosong jika recordId valid.');
    }
    
    static testMethod void testConstructorWithoutRecordId() {
        AMFS_PreviewLogBookDokumenController controller;
        try {
            PageReference pageRef = new PageReference('/apex/AMFS_PreviewLogBookDokumen?recordId=' + null);
            Test.setCurrentPage(pageRef);
            controller = new AMFS_PreviewLogBookDokumenController();
        } catch (Exception e) {
            System.assertEquals(null, controller.recordId, 'recordId harus null jika tidak ada parameter.');
            System.assertEquals('Oops! Please save your data first to generate an ID.', 
                controller.errorMessage, 
                'Pesan error harus muncul karena recordId tidak ada.');
        }
    }


    static testMethod void testConstructorWithDE() {
        Log_Book_Activitiy__c testLogBook = [SELECT Id FROM Log_Book_Activitiy__c LIMIT 1];
        
        PageReference pageRef = new PageReference('/apex/AMFS_PreviewLogBookDokumen?documentId=' + testLogBook.Id);
        Test.setCurrentPage(pageRef);
        
        AMFS_PreviewLogBookDokumenController controller = new AMFS_PreviewLogBookDokumenController();
        
        System.assertEquals(testLogBook.Id, controller.recordId, 'recordId harus sama dengan parameter yang diberikan.');
        System.assert(controller.errorMessage == null || controller.errorMessage == '', 
            'errorMessage harus kosong jika recordId valid.');
    }

    @isTest
    static void testCreateContentDistribution_Success() {
        Log_Book_Activitiy__c testLogBook = [SELECT Id FROM Log_Book_Activitiy__c LIMIT 1];
        AMFS_PreviewLogBookDokumenController controller = new AMFS_PreviewLogBookDokumenController();
        controller.recordId = testLogBook.Id;
        
        Test.startTest();
        controller.loadData('logbook');
        controller.createContentDistribution();
        Test.stopTest();

        List<ContentDistribution> distributions = [SELECT Id FROM ContentDistribution];
        System.assertNotEquals(0, distributions.size(), 'ContentDistribution harus dibuat.');
    }

    @isTest
    static void testCreateContentDistributionMDT_Success() {
        Log_Book_Activitiy__c testLogBook = [SELECT Id FROM Log_Book_Activitiy__c LIMIT 1];
        AMFS_PreviewLogBookDokumenController controller = new AMFS_PreviewLogBookDokumenController();
        Id logbookId = testLogBook.Id;
        controller.recordId = logbookId;
        
        Test.startTest();
        AMFS_PreviewLogBookDokumenController controller2 = new AMFS_PreviewLogBookDokumenController(logbookId);
        controller2.getActivityDetails(logbookId);
        controller.loadData('metadata');
        controller.createContentDistribution();
        Test.stopTest();

        List<ContentDistribution> distributions = [SELECT Id FROM ContentDistribution];
        // System.assertNotEquals(0, distributions.size(), 'ContentDistribution harus dibuat.');
    }

    @isTest
    static void testCreateContentDistribution_NoRecordId() {
        AMFS_PreviewLogBookDokumenController controller = new AMFS_PreviewLogBookDokumenController();
        controller.recordId = null; 

        Test.startTest();
        controller.createContentDistribution();
        Test.stopTest();

        System.assertEquals('Oops! Please save your data first to generate an ID.', controller.errorMessage, 'Error message harus muncul jika recordId null.');
    }

    @IsTest
    static void testCheckPreviewDocumentFound() {
        Log_Book_Activitiy__c testLogBook = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001'];
        Log_Book_Activitiy__c testLogBook2 = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A101'];

        List<String> recordIds = new List<String>{testLogBook.Id};
        List<String> record2Ids = new List<String>{testLogBook2.Id};
        List<String> record3Ids = new List<String>{'xxxx'};
        Test.startTest();
        List<String> resultMessages = AMFS_PreviewLogBookDokumenController.checkPreviewDocument(recordIds);
        List<String> resultMessages2 = AMFS_PreviewLogBookDokumenController.checkPreviewDocument(record2Ids);
        
        AMFS_PreviewLogBookDokumenController.bypassTrigger = true;
        List<String> resultMessages3 = AMFS_PreviewLogBookDokumenController.checkPreviewDocument(record3Ids);
        Test.stopTest();

        System.assertEquals(1, resultMessages.size(), 'Harus mengembalikan 1 pesan.');
        System.assertEquals('Ready', resultMessages[0], 'Pesan harus \'Ready\'.');
    }

    @isTest
    static void testCreateContentDistributionMDT_Error() {
        Log_Book_Activitiy__c testLogBook = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A101'];
        AMFS_PreviewLogBookDokumenController controller = new AMFS_PreviewLogBookDokumenController();
        Id logbookId = testLogBook.Id;
        System.debug('logbookId'+logbookId);
        controller.recordId = logbookId;
        
        Test.startTest();
        controller.loadData('logbook');
        controller.createContentDistribution();
        Test.stopTest();

        List<ContentDistribution> distributions = [SELECT Id FROM ContentDistribution];
        // System.assertNotEquals(0, distributions.size(), 'ContentDistribution harus dibuat.');
    }

    @isTest
    static void testgenerateResponseData() {
        Log_Book_Activitiy_Detail__c detail = [SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = '100-123-1234567' LIMIT 1];
        List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper> successResponseList = new List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper>();
        AMFS_PreviewLogBookDokumenController.APIResponseWrapper res1 = new AMFS_PreviewLogBookDokumenController.APIResponseWrapper();
        res1.id = '123'; 
        res1.status = 'Success';
        successResponseList.add(res1);
        res1 = new AMFS_PreviewLogBookDokumenController.APIResponseWrapper();
        res1.id = '456'; 
        res1.status = 'Success'; 
        successResponseList.add(res1);

        List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper> failedResponseList = new List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper>();
        AMFS_PreviewLogBookDokumenController.APIResponseWrapper res2 = new AMFS_PreviewLogBookDokumenController.APIResponseWrapper();
        res2.id = '123'; 
        res2.status = 'Failed';
        failedResponseList.add(res2);
        res2 = new AMFS_PreviewLogBookDokumenController.APIResponseWrapper();
        res2.id = '456'; 
        res2.status = 'Failed'; 
        failedResponseList.add(res2);

        List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper> onProcessResponseList = new List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper>();
        AMFS_PreviewLogBookDokumenController.APIResponseWrapper res4 = new AMFS_PreviewLogBookDokumenController.APIResponseWrapper();
        res4.id = '123'; 
        res4.status = 'On Process';
        onProcessResponseList.add(res4);
        res4 = new AMFS_PreviewLogBookDokumenController.APIResponseWrapper();
        res4.id = '456'; 
        res4.status = 'On Process'; 
        onProcessResponseList.add(res4);

        List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper> partialResponseList = new List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper>();
        AMFS_PreviewLogBookDokumenController.APIResponseWrapper res3 = new AMFS_PreviewLogBookDokumenController.APIResponseWrapper();
        res3.id = '123'; 
        res3.NameFile = 'KTP (Copy)';
        res3.status = 'Success';
        partialResponseList.add(res3);
        res3 = new AMFS_PreviewLogBookDokumenController.APIResponseWrapper();
        res3.id = '456'; 
        res3.NameFile = 'KK (Copy)';
        res3.status = 'Failed'; 
        partialResponseList.add(res3);

        List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper> partialResponseListNull = new List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper>();
        Test.startTest();
        AMFS_PreviewLogBookDokumenController.generateResponseData(detail.Id, 'SUCCESS', successResponseList);
        AMFS_PreviewLogBookDokumenController.generateResponseData(detail.Id, 'SUCCESS', failedResponseList);
        AMFS_PreviewLogBookDokumenController.generateResponseData(detail.Id, 'SUCCESS', partialResponseList);
        AMFS_PreviewLogBookDokumenController.generateResponseData(detail.Id, 'SUCCESS', onProcessResponseList);
        AMFS_PreviewLogBookDokumenController.generateResponseData(detail.Id, 'SUCCESS', partialResponseListNull);
        // AMFS_PreviewLogBookDokumenController.throwDML = true;
        delete detail;
        try {
            AMFS_PreviewLogBookDokumenController.generateResponseData(detail.id, 'SUCCESS', successResponseList);
            // System.assert(false, 'Seharusnya melempar exception');
        } catch (DmlException e) {
            // System.assert(true, 'Exception ditangkap sesuai harapan');
        }
        Test.stopTest();
    }
    
    @isTest
    static void testDeleteDistribution_NoDistributionFound() {
        Log_Book_Activitiy__c testLogBook = [SELECT Id FROM Log_Book_Activitiy__c LIMIT 1];
        Log_Book_Activitiy_Detail__c detail = [SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = '100-123-1234567' LIMIT 1];
        AMFS_PreviewLogBookDokumenController controller = new AMFS_PreviewLogBookDokumenController();
        controller.recordId = testLogBook.Id;
        AMFS_PreviewLogBookDokumenController.bypassTrigger = true;
        ApexPages.currentPage().getParameters().put('lbdId', detail.Id);
        ApexPages.currentPage().getParameters().put('documentId', 'xxxx');

        Test.startTest();
        PageReference resultPage = controller.deleteDistribution();
        Test.stopTest();

        System.assertEquals(null, resultPage, 'PageReference seharusnya null.');
    }
    @isTest
    static void testDeleteDistribution_NoDistributionFound2() {
        Log_Book_Activitiy__c testLogBook = [SELECT Id FROM Log_Book_Activitiy__c LIMIT 1];
        Log_Book_Activitiy_Detail__c detail = [SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = '100-123-1234567' LIMIT 1];
        AMFS_PreviewLogBookDokumenController controller = new AMFS_PreviewLogBookDokumenController();
        controller.recordId = testLogBook.Id;
        AMFS_PreviewLogBookDokumenController.bypassTrigger = true;
        ApexPages.currentPage().getParameters().put('lbdId', detail.Id);
        ApexPages.currentPage().getParameters().put('documentId', 'xxx;//x');

        Test.startTest();
        PageReference resultPage = controller.deleteDistribution();
        Test.stopTest();

        System.assertEquals(null, resultPage, 'PageReference seharusnya null.');
    }
    @isTest
    static void testDeleteDistribution_NoDistributionFound3() {
        Log_Book_Activitiy__c testLogBook = [SELECT Id FROM Log_Book_Activitiy__c LIMIT 1];
        Log_Book_Activitiy_Detail__c detail = [SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = '100-123-1234567' LIMIT 1];
        AMFS_PreviewLogBookDokumenController controller = new AMFS_PreviewLogBookDokumenController();
        controller.recordId = testLogBook.Id;
        AMFS_PreviewLogBookDokumenController.bypassTrigger = true;
        ApexPages.currentPage().getParameters().put('lbdId', null);
        ApexPages.currentPage().getParameters().put('documentId', 'xxx;//x');

        Test.startTest();
        PageReference resultPage = controller.deleteDistribution();
        Test.stopTest();

        System.assertEquals(null, resultPage, 'PageReference seharusnya null.');
    }
    
    @isTest
    static void testSubmitMetadata() {
        EIPJson.EIP_Body theBody2 = new EIPJson.EIP_Body();
        theBody2.operation = 'upload image';
        theBody2.transactionId = '0056F000004TDzzQAG-20250921-772bdcd046f96f4e78c5ab18d23aa8e8';
        theBody2.status = '1';
        theBody2.entity = 'AMFS';
        theBody2.service = 'addCustomer';
        theBody2.appID = 'DIPCAD';
        EIPJson dataResponse2 = new EIPJson();
        dataResponse2.Body = theBody2;

        List<EIPJson> responseListSuccess = new List<EIPJson>();
        responseListSuccess.add(dataResponse2);
        
        Log_Book_Activitiy__c testLogBook = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001'];
        AMFS_PreviewLogBookDokumenController controller = new AMFS_PreviewLogBookDokumenController();
        Id logbookId = testLogBook.Id;
        System.debug('logbookId'+logbookId);
        controller.recordId = logbookId;
        
        Test.startTest();
        AMFS_SubmitMetadataService.submitMetadataService(logbookId);
        AMFS_SubmitMetadataService.responseJson(logbookId,responseListSuccess);
        Test.stopTest();
    }
    @isTest
    static void testSubmitMetadataQueue() {
        Log_Book_Activitiy__c lba = new Log_Book_Activitiy__c();
        lba.Time_In__c = Time.newInstance(1, 1, 0, 0);
        lba.Queue_No__c = 'A00';
        lba.Touch_Point__c = 'Head Office';
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = new Log_Book_Activitiy_Detail__c();
        lbad.Log_Book_Activitiy__c = lba.Id;
        lbad.EForm__c = true;
        lbad.Customer_Mood__c = 'Happy';
        lbad.Customer_Name__c = 'JOHN DUMMY AMFS RLS';
        lbad.Customer_Relation__c = 'Diri Sendiri';
        lbad.Department__c = 'POS';
        lbad.Segmentation__c = 'Reguler';
        lbad.Policy_Number__c = 'POL-12345';
        insert lbad;
        
        String x = 'VGVzdCBmaWxlIGNvbnRlbnQgZm9yIExCQUQ='; 
        Blob fileBody = EncodingUtil.base64Decode(x);

        ContentVersion cvttd = new ContentVersion();
        cvttd.Title = 'Buku_Tabungan_(Copy) - 100-402-0963481.jpg';
        cvttd.PathOnClient = 'LBAD File.txt';
        cvttd.VersionData = fileBody;
        insert cvttd;
        Id cdIdttd = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvttd.Id].ContentDocumentId;
        ContentDocumentLink cdlttd = new ContentDocumentLink();
        cdlttd.ContentDocumentId = cdIdttd;
        cdlttd.LinkedEntityId = lbad.Id;
        cdlttd.ShareType = 'V'; // Viewer
        cdlttd.Visibility = 'AllUsers';
        insert cdlttd;
        
        E_Form_Master_Data__c form = new E_Form_Master_Data__c();
        form.Name = 'Test Eform - 5 days ';
        insert form;
        ContentVersion cvt = new ContentVersion();
        cvt.Title = 'Buku_Tabungan_(Copy) - 100-402-0963481.jpg';
        cvt.PathOnClient = 'LBAD File.txt';
        cvt.VersionData = fileBody;
        insert cvt;
        Id cdIdt = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvt.Id].ContentDocumentId;
        ContentDocumentLink cdlt = new ContentDocumentLink();
        cdlt.ContentDocumentId = cdIdt;
        cdlt.LinkedEntityId = form.Id;
        cdlt.ShareType = 'V'; // Viewer
        cdlt.Visibility = 'AllUsers';
        insert cdlt;
        
        Integer index = 0;
        String inputs = lba.id;
        List<Map<String,String>> propertiesMetadata = AMFS_SubmitMetadataService.propertiesMap(inputs);
        List<Map<String,String>> propertiesImage = AMFS_SubmitMetadataService.propertiesMapImage(inputs);
        List<Id> propertiesImageCV = AMFS_SubmitMetadataService.propertiesMapImageCV(inputs);
        List<Id> LBDIds = AMFS_SubmitMetadataService.propertiesLBDID(inputs);
        List<Map<String,String>> listMapResStatusLBAD = new List<Map<String,String>>();
        List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper> resResult = new List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper>();
        List<Id> idLbad = new List<Id>();
        idLbad.add(lba.id);
        Test.startTest();
        System.enqueueJob(new AMFS_SubmitImageServiceQueueable(idLbad,LBDIds,propertiesMetadata,propertiesImage,propertiesImageCV,0));
        // System.enqueueJob(new AMFS_SubmitImageServiceQueueable(listMapResStatusLBAD,LBDIds,propertiesMetadata,propertiesImage,propertiesImageCV,1,'sendMetadata'));
        // System.enqueueJob(new AMFS_SubmitImageServiceQueueable(resResult,listMapResStatusLBAD,LBDIds,propertiesImage,propertiesImageCV,0,'sendImage'));
            
        Test.stopTest();
    }
    @isTest
    static void testSubmitMetadataQueueImageSucc() {
        Log_Book_Activitiy__c lba = new Log_Book_Activitiy__c();
        lba.Time_In__c = Time.newInstance(1, 1, 0, 0);
        lba.Queue_No__c = 'A00';
        lba.Touch_Point__c = 'Head Office';
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = new Log_Book_Activitiy_Detail__c();
        lbad.Log_Book_Activitiy__c = lba.Id;
        lbad.EForm__c = true;
        lbad.Customer_Mood__c = 'Happy';
        lbad.Customer_Name__c = 'JOHN DUMMY AMFS RLS';
        lbad.Customer_Relation__c = 'Diri Sendiri';
        lbad.Department__c = 'POS';
        lbad.Segmentation__c = 'Reguler';
        lbad.Policy_Number__c = 'POL-12345';
        insert lbad;
        
        String x = 'VGVzdCBmaWxlIGNvbnRlbnQgZm9yIExCQUQ='; 
        Blob fileBody = EncodingUtil.base64Decode(x);

        ContentVersion cvttd = new ContentVersion();
        cvttd.Title = 'Buku_Tabungan_(Copy) - 100-402-0963481.jpg';
        cvttd.PathOnClient = 'LBAD File.txt';
        cvttd.VersionData = fileBody;
        insert cvttd;
        Id cdIdttd = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvttd.Id].ContentDocumentId;
        ContentDocumentLink cdlttd = new ContentDocumentLink();
        cdlttd.ContentDocumentId = cdIdttd;
        cdlttd.LinkedEntityId = lbad.Id;
        cdlttd.ShareType = 'V'; // Viewer
        cdlttd.Visibility = 'AllUsers';
        insert cdlttd;
        
        E_Form_Master_Data__c form = new E_Form_Master_Data__c();
        form.Name = 'Test Eform - 5 days ';
        insert form;
        ContentVersion cvt = new ContentVersion();
        cvt.Title = 'Buku_Tabungan_(Copy) - 100-402-0963481.jpg';
        cvt.PathOnClient = 'LBAD File.txt';
        cvt.VersionData = fileBody;
        insert cvt;
        Id cdIdt = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvt.Id].ContentDocumentId;
        ContentDocumentLink cdlt = new ContentDocumentLink();
        cdlt.ContentDocumentId = cdIdt;
        cdlt.LinkedEntityId = form.Id;
        cdlt.ShareType = 'V'; // Viewer
        cdlt.Visibility = 'AllUsers';
        insert cdlt;

        List<Id> lbdIds = new List<Id>();
        List<Map<String,String>> propertiesMetadata = new List<Map<String,String>>();
        List<Map<String,String>> propertiesImage = new List<Map<String,String>>();
        List<Id> propertiesImageCV = new List<Id>();
        List<Map<String,String>> mapResStatusLBADTotal = new List<Map<String,String>>();
        Map<String, String> prop = new  Map<String, String>();
        prop.put('LBA ID', lba.Id);
        prop.put('LBAD ID', lbad.Id);
        propertiesMetadata.add(prop);

        Map<String, String> propImage = new  Map<String, String>();
        prop.put(EIPConstant.PARAM_DOCUMENT_NAME, cvt.Title);
        propertiesImage.add(prop);

        propertiesImageCV.add(cvt.id);

        Map<String,String> statusMap = new Map<String,String>{
            lba.Id => 'Success'
        };
        mapResStatusLBADTotal.add(statusMap);
        List<Map<String,String>> listMapResStatusLBAD = new List<Map<String,String>>();
        List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper> resResult = new List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper>();
        AMFS_PreviewLogBookDokumenController.APIResponseWrapper result = new AMFS_PreviewLogBookDokumenController.APIResponseWrapper();

        result.status = 'Success';
        result.nameFile = propertiesImage[0].get(EIPConstant.PARAM_DOCUMENT_NAME);
        result.id = propertiesImageCV[0];
        resResult.add(result);
        List<Id> idLbad = new List<Id>();
        idLbad.add(lba.id);
        Test.setMock(HttpCalloutMock.class, new AMFS_MockHttpResponseGeneratorSuccess());
        Test.startTest();
        System.enqueueJob(new AMFS_SubmitImageServiceQueueable(idLbad,resResult,mapResStatusLBADTotal,LBDIds ,propertiesImage, propertiesImageCV, 0, 'sendImage'));
        Test.stopTest();
    }
    @isTest
    static void testSubmitMetadataQueueImageSuccChain() {
        Log_Book_Activitiy__c lba = new Log_Book_Activitiy__c();
        lba.Time_In__c = Time.newInstance(1, 1, 0, 0);
        lba.Queue_No__c = 'A00';
        lba.Touch_Point__c = 'Head Office';
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = new Log_Book_Activitiy_Detail__c();
        lbad.Log_Book_Activitiy__c = lba.Id;
        lbad.EForm__c = true;
        lbad.Customer_Mood__c = 'Happy';
        lbad.Customer_Name__c = 'JOHN DUMMY AMFS RLS';
        lbad.Customer_Relation__c = 'Diri Sendiri';
        lbad.Department__c = 'POS';
        lbad.Segmentation__c = 'Reguler';
        lbad.Policy_Number__c = 'POL-12345';
        insert lbad;
        
        String x = 'VGVzdCBmaWxlIGNvbnRlbnQgZm9yIExCQUQ='; 
        Blob fileBody = EncodingUtil.base64Decode(x);

        ContentVersion cvttd = new ContentVersion();
        cvttd.Title = 'Buku_Tabungan_(Copy) - 100-402-0963481.jpg';
        cvttd.PathOnClient = 'LBAD File.txt';
        cvttd.VersionData = fileBody;
        insert cvttd;
        Id cdIdttd = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvttd.Id].ContentDocumentId;
        ContentDocumentLink cdlttd = new ContentDocumentLink();
        cdlttd.ContentDocumentId = cdIdttd;
        cdlttd.LinkedEntityId = lbad.Id;
        cdlttd.ShareType = 'V'; // Viewer
        cdlttd.Visibility = 'AllUsers';
        insert cdlttd;
        
        E_Form_Master_Data__c form = new E_Form_Master_Data__c();
        form.Name = 'Test Eform - 5 days ';
        insert form;
        ContentVersion cvt = new ContentVersion();
        cvt.Title = 'Buku_Tabungan_(Copy) - 100-402-0963481.jpg';
        cvt.PathOnClient = 'LBAD File.txt';
        cvt.VersionData = fileBody;
        insert cvt;
        Id cdIdt = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvt.Id].ContentDocumentId;
        ContentDocumentLink cdlt = new ContentDocumentLink();
        cdlt.ContentDocumentId = cdIdt;
        cdlt.LinkedEntityId = form.Id;
        cdlt.ShareType = 'V'; // Viewer
        cdlt.Visibility = 'AllUsers';
        insert cdlt;

        List<Id> lbdIds = new List<Id>();
        lbdIds.add((lbad.id));
        List<Map<String,String>> propertiesMetadata = new List<Map<String,String>>();
        List<Map<String,String>> propertiesImage = new List<Map<String,String>>();
        List<Id> propertiesImageCV = new List<Id>();
        List<Map<String,String>> mapResStatusLBADTotal = new List<Map<String,String>>();
        Map<String, String> prop = new  Map<String, String>();
        prop.put('LBA ID', lba.Id);
        prop.put('LBAD ID', lbad.Id);
        propertiesMetadata.add(prop);

        Map<String, String> propImage = new  Map<String, String>();
        prop.put(EIPConstant.PARAM_DOCUMENT_NAME, cvt.Title);
        propertiesImage.add(prop);

        propertiesImageCV.add(cvt.id);

        Map<String,String> statusMap = new Map<String,String>{
            lba.Id => 'Success'
        };
        mapResStatusLBADTotal.add(statusMap);
        List<Map<String,String>> listMapResStatusLBAD = new List<Map<String,String>>();
        List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper> resResult = new List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper>();
        AMFS_PreviewLogBookDokumenController.APIResponseWrapper result = new AMFS_PreviewLogBookDokumenController.APIResponseWrapper();

        result.status = 'Success';
        result.nameFile = propertiesImage[0].get(EIPConstant.PARAM_DOCUMENT_NAME);
        result.id = propertiesImageCV[0];
        resResult.add(result);
        List<Id> idLbad = new List<Id>();
        idLbad.add(lba.id);
        Test.setMock(HttpCalloutMock.class, new AMFS_MockHttpResponseGeneratorSuccess());
        Test.startTest();
        // AMFS_SubmitImageServiceQueueable.disableChaining=true;
        System.enqueueJob(new AMFS_SubmitImageServiceQueueable(idLbad,resResult,mapResStatusLBADTotal,LBDIds ,propertiesImage, propertiesImageCV, 1, 'sendImage'));
        Test.stopTest();
    }
    @isTest
    static void testSubmitMetadataQueueImageFail() {
        Log_Book_Activitiy__c lba = new Log_Book_Activitiy__c();
        lba.Time_In__c = Time.newInstance(1, 1, 0, 0);
        lba.Queue_No__c = 'A00';
        lba.Touch_Point__c = 'Head Office';
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = new Log_Book_Activitiy_Detail__c();
        lbad.Log_Book_Activitiy__c = lba.Id;
        lbad.EForm__c = true;
        lbad.Customer_Mood__c = 'Happy';
        lbad.Customer_Name__c = 'JOHN DUMMY AMFS RLS';
        lbad.Customer_Relation__c = 'Diri Sendiri';
        lbad.Department__c = 'POS';
        lbad.Segmentation__c = 'Reguler';
        lbad.Policy_Number__c = 'POL-12345';
        insert lbad;
        
        String x = 'VGVzdCBmaWxlIGNvbnRlbnQgZm9yIExCQUQ='; 
        Blob fileBody = EncodingUtil.base64Decode(x);

        ContentVersion cvttd = new ContentVersion();
        cvttd.Title = 'Buku_Tabungan_(Copy) - 100-402-0963481.jpg';
        cvttd.PathOnClient = 'LBAD File.txt';
        cvttd.VersionData = fileBody;
        insert cvttd;
        Id cdIdttd = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvttd.Id].ContentDocumentId;
        ContentDocumentLink cdlttd = new ContentDocumentLink();
        cdlttd.ContentDocumentId = cdIdttd;
        cdlttd.LinkedEntityId = lbad.Id;
        cdlttd.ShareType = 'V'; // Viewer
        cdlttd.Visibility = 'AllUsers';
        insert cdlttd;
        
        E_Form_Master_Data__c form = new E_Form_Master_Data__c();
        form.Name = 'Test Eform - 5 days ';
        insert form;
        ContentVersion cvt = new ContentVersion();
        cvt.Title = 'Buku_Tabungan_(Copy) - 100-402-0963481.jpg';
        cvt.PathOnClient = 'LBAD File.txt';
        cvt.VersionData = fileBody;
        insert cvt;
        Id cdIdt = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvt.Id].ContentDocumentId;
        ContentDocumentLink cdlt = new ContentDocumentLink();
        cdlt.ContentDocumentId = cdIdt;
        cdlt.LinkedEntityId = form.Id;
        cdlt.ShareType = 'V'; // Viewer
        cdlt.Visibility = 'AllUsers';
        insert cdlt;

        List<Id> lbdIds = new List<Id>();
        List<Map<String,String>> propertiesMetadata = new List<Map<String,String>>();
        List<Map<String,String>> propertiesImage = new List<Map<String,String>>();
        List<Id> propertiesImageCV = new List<Id>();
        List<Map<String,String>> mapResStatusLBADTotal = new List<Map<String,String>>();
        Map<String, String> prop = new  Map<String, String>();
        prop.put('LBA ID', lba.Id);
        prop.put('LBAD ID', lbad.Id);
        propertiesMetadata.add(prop);

        Map<String, String> propImage = new  Map<String, String>();
        prop.put(EIPConstant.PARAM_DOCUMENT_NAME, cvt.Title);
        propertiesImage.add(prop);

        propertiesImageCV.add(cvt.id);

        Map<String,String> statusMap = new Map<String,String>{
            lba.Id => 'Success'
        };
        mapResStatusLBADTotal.add(statusMap);
        List<Map<String,String>> listMapResStatusLBAD = new List<Map<String,String>>();
        List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper> resResult = new List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper>();
        AMFS_PreviewLogBookDokumenController.APIResponseWrapper result = new AMFS_PreviewLogBookDokumenController.APIResponseWrapper();

        result.status = 'Success';
        result.nameFile = propertiesImage[0].get(EIPConstant.PARAM_DOCUMENT_NAME);
        result.id = propertiesImageCV[0];
        resResult.add(result);
        List<Id> idLbad = new List<Id>();
        idLbad.add(lba.id);
        Test.setMock(HttpCalloutMock.class, new AMFS_MockHttpResponseGeneratorFailed());
        Test.startTest();
        System.enqueueJob(new AMFS_SubmitImageServiceQueueable(idLbad,resResult,mapResStatusLBADTotal,LBDIds ,propertiesImage, propertiesImageCV, 0, 'sendImage'));
        Test.stopTest();
    }
    @isTest
    static void testSubmitMetadataQueueImageNoResponse() {
        Log_Book_Activitiy__c lba = new Log_Book_Activitiy__c();
        lba.Time_In__c = Time.newInstance(1, 1, 0, 0);
        lba.Queue_No__c = 'A00';
        lba.Touch_Point__c = 'Head Office';
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = new Log_Book_Activitiy_Detail__c();
        lbad.Log_Book_Activitiy__c = lba.Id;
        lbad.EForm__c = true;
        lbad.Customer_Mood__c = 'Happy';
        lbad.Customer_Name__c = 'JOHN DUMMY AMFS RLS';
        lbad.Customer_Relation__c = 'Diri Sendiri';
        lbad.Department__c = 'POS';
        lbad.Segmentation__c = 'Reguler';
        lbad.Policy_Number__c = 'POL-12345';
        insert lbad;
        
        String x = 'VGVzdCBmaWxlIGNvbnRlbnQgZm9yIExCQUQ='; 
        Blob fileBody = EncodingUtil.base64Decode(x);

        ContentVersion cvttd = new ContentVersion();
        cvttd.Title = 'Buku_Tabungan_(Copy) - 100-402-0963481.jpg';
        cvttd.PathOnClient = 'LBAD File.txt';
        cvttd.VersionData = fileBody;
        insert cvttd;
        Id cdIdttd = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvttd.Id].ContentDocumentId;
        ContentDocumentLink cdlttd = new ContentDocumentLink();
        cdlttd.ContentDocumentId = cdIdttd;
        cdlttd.LinkedEntityId = lbad.Id;
        cdlttd.ShareType = 'V'; // Viewer
        cdlttd.Visibility = 'AllUsers';
        insert cdlttd;
        
        E_Form_Master_Data__c form = new E_Form_Master_Data__c();
        form.Name = 'Test Eform - 5 days ';
        insert form;
        ContentVersion cvt = new ContentVersion();
        cvt.Title = 'Buku_Tabungan_(Copy) - 100-402-0963481.jpg';
        cvt.PathOnClient = 'LBAD File.txt';
        cvt.VersionData = fileBody;
        insert cvt;
        Id cdIdt = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvt.Id].ContentDocumentId;
        ContentDocumentLink cdlt = new ContentDocumentLink();
        cdlt.ContentDocumentId = cdIdt;
        cdlt.LinkedEntityId = form.Id;
        cdlt.ShareType = 'V'; // Viewer
        cdlt.Visibility = 'AllUsers';
        insert cdlt;

        List<Id> lbdIds = new List<Id>();
        lbdIds.add(lbad.id);
        List<Map<String,String>> propertiesMetadata = new List<Map<String,String>>();
        List<Map<String,String>> propertiesImage = new List<Map<String,String>>();
        List<Id> propertiesImageCV = new List<Id>();
        List<Map<String,String>> mapResStatusLBADTotal = new List<Map<String,String>>();
        Map<String, String> prop = new  Map<String, String>();
        prop.put('LBA ID', lba.Id);
        prop.put('LBAD ID', lbad.Id);
        propertiesMetadata.add(prop);

        Map<String, String> propImage = new  Map<String, String>();
        prop.put(EIPConstant.PARAM_DOCUMENT_NAME, cvt.Title);
        propertiesImage.add(prop);

        propertiesImageCV.add(cvt.id);

        Map<String,String> statusMap = new Map<String,String>{
            lba.Id => 'Success'
        };
        mapResStatusLBADTotal.add(statusMap);
        List<Map<String,String>> listMapResStatusLBAD = new List<Map<String,String>>();
        List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper> resResult = new List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper>();
        AMFS_PreviewLogBookDokumenController.APIResponseWrapper result = new AMFS_PreviewLogBookDokumenController.APIResponseWrapper();

        result.status = 'Success';
        result.nameFile = propertiesImage[0].get(EIPConstant.PARAM_DOCUMENT_NAME);
        result.id = propertiesImageCV[0];
        resResult.add(result);
        List<Id> idLbad = new List<Id>();
        idLbad.add(lba.id);
        Test.setMock(HttpCalloutMock.class, new AMFS_MockHttpResponseGeneratorNoBody());
        Test.startTest();
        System.enqueueJob(new AMFS_SubmitImageServiceQueueable(idLbad,resResult,mapResStatusLBADTotal,LBDIds ,propertiesImage, propertiesImageCV, 0, 'sendImage'));
        Test.stopTest();
    }
    @isTest
    static void testSubmitMetadataQueueMetadataNoResponse() {
        Log_Book_Activitiy__c lba = new Log_Book_Activitiy__c();
        lba.Time_In__c = Time.newInstance(1, 1, 0, 0);
        lba.Queue_No__c = 'A00';
        lba.Touch_Point__c = 'Head Office';
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = new Log_Book_Activitiy_Detail__c();
        lbad.Log_Book_Activitiy__c = lba.Id;
        lbad.EForm__c = true;
        lbad.Customer_Mood__c = 'Happy';
        lbad.Customer_Name__c = 'JOHN DUMMY AMFS RLS';
        lbad.Customer_Relation__c = 'Diri Sendiri';
        lbad.Department__c = 'POS';
        lbad.Segmentation__c = 'Reguler';
        lbad.Policy_Number__c = 'POL-12345';
        insert lbad;
        
        String x = 'VGVzdCBmaWxlIGNvbnRlbnQgZm9yIExCQUQ='; 
        Blob fileBody = EncodingUtil.base64Decode(x);

        ContentVersion cvttd = new ContentVersion();
        cvttd.Title = 'Buku_Tabungan_(Copy) - 100-402-0963481.jpg';
        cvttd.PathOnClient = 'LBAD File.txt';
        cvttd.VersionData = fileBody;
        insert cvttd;
        Id cdIdttd = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvttd.Id].ContentDocumentId;
        ContentDocumentLink cdlttd = new ContentDocumentLink();
        cdlttd.ContentDocumentId = cdIdttd;
        cdlttd.LinkedEntityId = lbad.Id;
        cdlttd.ShareType = 'V'; // Viewer
        cdlttd.Visibility = 'AllUsers';
        insert cdlttd;
        
        E_Form_Master_Data__c form = new E_Form_Master_Data__c();
        form.Name = 'Test Eform - 5 days ';
        insert form;
        ContentVersion cvt = new ContentVersion();
        cvt.Title = 'Buku_Tabungan_(Copy) - 100-402-0963481.jpg';
        cvt.PathOnClient = 'LBAD File.txt';
        cvt.VersionData = fileBody;
        insert cvt;
        Id cdIdt = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvt.Id].ContentDocumentId;
        ContentDocumentLink cdlt = new ContentDocumentLink();
        cdlt.ContentDocumentId = cdIdt;
        cdlt.LinkedEntityId = form.Id;
        cdlt.ShareType = 'V'; // Viewer
        cdlt.Visibility = 'AllUsers';
        insert cdlt;

        List<Id> lbdIds = new List<Id>();
        lbdIds.add(lbad.id);
        List<Map<String,String>> propertiesMetadata = new List<Map<String,String>>();
        List<Map<String,String>> propertiesImage = new List<Map<String,String>>();
        List<Id> propertiesImageCV = new List<Id>();
        List<Map<String,String>> mapResStatusLBADTotal = new List<Map<String,String>>();
        Map<String, String> prop = new  Map<String, String>();
        prop.put('LBA ID', lba.Id);
        prop.put('LBAD ID', lbad.Id);
        propertiesMetadata.add(prop);

        Map<String, String> propImage = new  Map<String, String>();
        prop.put(EIPConstant.PARAM_DOCUMENT_NAME, cvt.Title);
        propertiesImage.add(prop);

        propertiesImageCV.add(cvt.id);

        Map<String,String> statusMap = new Map<String,String>{
            lba.Id => 'Success'
        };
        mapResStatusLBADTotal.add(statusMap);
        List<Map<String,String>> listMapResStatusLBAD = new List<Map<String,String>>();
        List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper> resResult = new List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper>();
        AMFS_PreviewLogBookDokumenController.APIResponseWrapper result = new AMFS_PreviewLogBookDokumenController.APIResponseWrapper();

        result.status = 'Success';
        result.nameFile = propertiesImage[0].get(EIPConstant.PARAM_DOCUMENT_NAME);
        result.id = propertiesImageCV[0];
        resResult.add(result);
        List<Id> idLbad = new List<Id>();
        idLbad.add(lba.id);
        Test.setMock(HttpCalloutMock.class, new AMFS_MockHttpResponseGeneratorNoBody());
        Test.startTest();
        System.enqueueJob(new AMFS_SubmitImageServiceQueueable(idLbad,LBDIds, propertiesMetadata,propertiesImage, propertiesImageCV, 0));
        Test.stopTest();
    }
    @isTest
    static void testSubmitMetadataQueueMetadataFail() {
        Log_Book_Activitiy__c lba = new Log_Book_Activitiy__c();
        lba.Time_In__c = Time.newInstance(1, 1, 0, 0);
        lba.Queue_No__c = 'A00';
        lba.Touch_Point__c = 'Head Office';
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = new Log_Book_Activitiy_Detail__c();
        lbad.Log_Book_Activitiy__c = lba.Id;
        lbad.EForm__c = true;
        lbad.Customer_Mood__c = 'Happy';
        lbad.Customer_Name__c = 'JOHN DUMMY AMFS RLS';
        lbad.Customer_Relation__c = 'Diri Sendiri';
        lbad.Department__c = 'POS';
        lbad.Segmentation__c = 'Reguler';
        lbad.Policy_Number__c = 'POL-12345';
        insert lbad;
        
        String x = 'VGVzdCBmaWxlIGNvbnRlbnQgZm9yIExCQUQ='; 
        Blob fileBody = EncodingUtil.base64Decode(x);

        ContentVersion cvttd = new ContentVersion();
        cvttd.Title = 'Buku_Tabungan_(Copy) - 100-402-0963481.jpg';
        cvttd.PathOnClient = 'LBAD File.txt';
        cvttd.VersionData = fileBody;
        insert cvttd;
        Id cdIdttd = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvttd.Id].ContentDocumentId;
        ContentDocumentLink cdlttd = new ContentDocumentLink();
        cdlttd.ContentDocumentId = cdIdttd;
        cdlttd.LinkedEntityId = lbad.Id;
        cdlttd.ShareType = 'V'; // Viewer
        cdlttd.Visibility = 'AllUsers';
        insert cdlttd;
        
        E_Form_Master_Data__c form = new E_Form_Master_Data__c();
        form.Name = 'Test Eform - 5 days ';
        insert form;
        ContentVersion cvt = new ContentVersion();
        cvt.Title = 'Buku_Tabungan_(Copy) - 100-402-0963481.jpg';
        cvt.PathOnClient = 'LBAD File.txt';
        cvt.VersionData = fileBody;
        insert cvt;
        Id cdIdt = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvt.Id].ContentDocumentId;
        ContentDocumentLink cdlt = new ContentDocumentLink();
        cdlt.ContentDocumentId = cdIdt;
        cdlt.LinkedEntityId = form.Id;
        cdlt.ShareType = 'V'; // Viewer
        cdlt.Visibility = 'AllUsers';
        insert cdlt;

        List<Id> lbdIds = new List<Id>();
        lbdIds.add(lbad.id);
        List<Map<String,String>> propertiesMetadata = new List<Map<String,String>>();
        List<Map<String,String>> propertiesImage = new List<Map<String,String>>();
        List<Id> propertiesImageCV = new List<Id>();
        List<Map<String,String>> mapResStatusLBADTotal = new List<Map<String,String>>();
        Map<String, String> prop = new  Map<String, String>();
        prop.put('LBA ID', lba.Id);
        prop.put('LBAD ID', lbad.Id);
        propertiesMetadata.add(prop);

        Map<String, String> propImage = new  Map<String, String>();
        prop.put(EIPConstant.PARAM_DOCUMENT_NAME, cvt.Title);
        propertiesImage.add(prop);

        propertiesImageCV.add(cvt.id);

        Map<String,String> statusMap = new Map<String,String>{
            lba.Id => 'Success'
        };
        mapResStatusLBADTotal.add(statusMap);
        List<Map<String,String>> listMapResStatusLBAD = new List<Map<String,String>>();
        List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper> resResult = new List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper>();
        AMFS_PreviewLogBookDokumenController.APIResponseWrapper result = new AMFS_PreviewLogBookDokumenController.APIResponseWrapper();

        result.status = 'Success';
        result.nameFile = propertiesImage[0].get(EIPConstant.PARAM_DOCUMENT_NAME);
        result.id = propertiesImageCV[0];
        resResult.add(result);
        List<Id> idLbad = new List<Id>();
        idLbad.add(lba.id);
        Test.setMock(HttpCalloutMock.class, new AMFS_MockHttpResponseGeneratorFailed());
        Test.startTest();
        AMFS_SubmitImageServiceQueueable.throwEx=true;
        AMFS_SubmitImageServiceQueueable.logThrowEx=true;
        System.enqueueJob(new AMFS_SubmitImageServiceQueueable(idLbad,LBDIds, propertiesMetadata,propertiesImage, propertiesImageCV, 0));
        Test.stopTest();
    }
    @isTest
    static void testSubmitMetadataQueueMetadataSuccess() {
        Log_Book_Activitiy__c lba = new Log_Book_Activitiy__c();
        lba.Time_In__c = Time.newInstance(1, 1, 0, 0);
        lba.Queue_No__c = 'A00';
        lba.Touch_Point__c = 'Head Office';
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = new Log_Book_Activitiy_Detail__c();
        lbad.Log_Book_Activitiy__c = lba.Id;
        lbad.EForm__c = true;
        lbad.Customer_Mood__c = 'Happy';
        lbad.Customer_Name__c = 'JOHN DUMMY AMFS RLS';
        lbad.Customer_Relation__c = 'Diri Sendiri';
        lbad.Department__c = 'POS';
        lbad.Segmentation__c = 'Reguler';
        lbad.Policy_Number__c = 'POL-12345';
        insert lbad;
        
        String x = 'VGVzdCBmaWxlIGNvbnRlbnQgZm9yIExCQUQ='; 
        Blob fileBody = EncodingUtil.base64Decode(x);

        ContentVersion cvttd = new ContentVersion();
        cvttd.Title = 'Buku_Tabungan_(Copy) - 100-402-0963481.jpg';
        cvttd.PathOnClient = 'LBAD File.txt';
        cvttd.VersionData = fileBody;
        insert cvttd;
        Id cdIdttd = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvttd.Id].ContentDocumentId;
        ContentDocumentLink cdlttd = new ContentDocumentLink();
        cdlttd.ContentDocumentId = cdIdttd;
        cdlttd.LinkedEntityId = lbad.Id;
        cdlttd.ShareType = 'V'; // Viewer
        cdlttd.Visibility = 'AllUsers';
        insert cdlttd;
        
        E_Form_Master_Data__c form = new E_Form_Master_Data__c();
        form.Name = 'Test Eform - 5 days ';
        insert form;
        ContentVersion cvt = new ContentVersion();
        cvt.Title = 'Buku_Tabungan_(Copy) - 100-402-0963481.jpg';
        cvt.PathOnClient = 'LBAD File.txt';
        cvt.VersionData = fileBody;
        insert cvt;
        Id cdIdt = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvt.Id].ContentDocumentId;
        ContentDocumentLink cdlt = new ContentDocumentLink();
        cdlt.ContentDocumentId = cdIdt;
        cdlt.LinkedEntityId = form.Id;
        cdlt.ShareType = 'V'; // Viewer
        cdlt.Visibility = 'AllUsers';
        insert cdlt;

        List<Id> lbdIds = new List<Id>();
        lbdIds.add(lbad.id);
        List<Map<String,String>> propertiesMetadata = new List<Map<String,String>>();
        List<Map<String,String>> propertiesImage = new List<Map<String,String>>();
        List<Id> propertiesImageCV = new List<Id>();
        List<Map<String,String>> mapResStatusLBADTotal = new List<Map<String,String>>();
        Map<String, String> prop = new  Map<String, String>();
        prop.put('LBA ID', lba.Id);
        prop.put('LBAD ID', lbad.Id);
        propertiesMetadata.add(prop);

        Map<String, String> propImage = new  Map<String, String>();
        prop.put(EIPConstant.PARAM_DOCUMENT_NAME, cvt.Title);
        propertiesImage.add(prop);

        propertiesImageCV.add(cvt.id);

        Map<String,String> statusMap = new Map<String,String>{
            lba.Id => 'Success'
        };
        mapResStatusLBADTotal.add(statusMap);
        List<Map<String,String>> listMapResStatusLBAD = new List<Map<String,String>>();
        Map<String,String> mapResStatusLBAD = new Map<String,String>();
        mapResStatusLBAD.put(propertiesMetadata[0].get('LBAD ID'),'Success');
        listMapResStatusLBAD.add(mapResStatusLBAD);

        List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper> resResult = new List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper>();
        AMFS_PreviewLogBookDokumenController.APIResponseWrapper result = new AMFS_PreviewLogBookDokumenController.APIResponseWrapper();

        result.status = 'Success';
        result.nameFile = propertiesImage[0].get(EIPConstant.PARAM_DOCUMENT_NAME);
        result.id = propertiesImageCV[0];
        resResult.add(result);
        List<Id> idLbad = new List<Id>();
        idLbad.add(lba.id);
        Test.setMock(HttpCalloutMock.class, new AMFS_MockHttpResponseGeneratorSuccess());
        Test.startTest();
        System.enqueueJob(new AMFS_SubmitImageServiceQueueable(idLbad,listMapResStatusLBAD,LBDIds, propertiesMetadata,propertiesImage, propertiesImageCV, 0, 'sendMetadata'));
        Test.stopTest();
    }
    @isTest
    static void testSubmitMetadataQueueMetadataSuccessPlus() {
        Log_Book_Activitiy__c lba = new Log_Book_Activitiy__c();
        lba.Time_In__c = Time.newInstance(1, 1, 0, 0);
        lba.Queue_No__c = 'A00';
        lba.Touch_Point__c = 'Head Office';
        insert lba;
        Log_Book_Activitiy_Detail__c lbad = new Log_Book_Activitiy_Detail__c();
        lbad.Log_Book_Activitiy__c = lba.Id;
        lbad.EForm__c = true;
        lbad.Customer_Mood__c = 'Happy';
        lbad.Customer_Name__c = 'JOHN DUMMY AMFS RLS';
        lbad.Customer_Relation__c = 'Diri Sendiri';
        lbad.Department__c = 'POS';
        lbad.Segmentation__c = 'Reguler';
        lbad.Policy_Number__c = 'POL-12345';
        insert lbad;
        
        String x = 'VGVzdCBmaWxlIGNvbnRlbnQgZm9yIExCQUQ='; 
        Blob fileBody = EncodingUtil.base64Decode(x);

        ContentVersion cvttd = new ContentVersion();
        cvttd.Title = 'Buku_Tabungan_(Copy) - 100-402-0963481.jpg';
        cvttd.PathOnClient = 'LBAD File.txt';
        cvttd.VersionData = fileBody;
        insert cvttd;
        Id cdIdttd = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvttd.Id].ContentDocumentId;
        ContentDocumentLink cdlttd = new ContentDocumentLink();
        cdlttd.ContentDocumentId = cdIdttd;
        cdlttd.LinkedEntityId = lbad.Id;
        cdlttd.ShareType = 'V'; // Viewer
        cdlttd.Visibility = 'AllUsers';
        insert cdlttd;
        
        E_Form_Master_Data__c form = new E_Form_Master_Data__c();
        form.Name = 'Test Eform - 5 days ';
        insert form;
        ContentVersion cvt = new ContentVersion();
        cvt.Title = 'Buku_Tabungan_(Copy) - 100-402-0963481.jpg';
        cvt.PathOnClient = 'LBAD File.txt';
        cvt.VersionData = fileBody;
        insert cvt;
        Id cdIdt = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvt.Id].ContentDocumentId;
        ContentDocumentLink cdlt = new ContentDocumentLink();
        cdlt.ContentDocumentId = cdIdt;
        cdlt.LinkedEntityId = form.Id;
        cdlt.ShareType = 'V'; // Viewer
        cdlt.Visibility = 'AllUsers';
        insert cdlt;

        List<Id> lbdIds = new List<Id>();
        lbdIds.add(lbad.id);
        List<Map<String,String>> propertiesMetadata = new List<Map<String,String>>();
        List<Map<String,String>> propertiesImage = new List<Map<String,String>>();
        List<Id> propertiesImageCV = new List<Id>();
        List<Map<String,String>> mapResStatusLBADTotal = new List<Map<String,String>>();
        Map<String, String> prop = new  Map<String, String>();
        prop.put('LBA ID', lba.Id);
        prop.put('LBAD ID', lbad.Id);
        propertiesMetadata.add(prop);

        Map<String, String> propImage = new  Map<String, String>();
        prop.put(EIPConstant.PARAM_DOCUMENT_NAME, cvt.Title);
        propertiesImage.add(prop);

        propertiesImageCV.add(cvt.id);

        Map<String,String> statusMap = new Map<String,String>{
            lba.Id => 'Success'
        };
        mapResStatusLBADTotal.add(statusMap);
        List<Map<String,String>> listMapResStatusLBAD = new List<Map<String,String>>();
        Map<String,String> mapResStatusLBAD = new Map<String,String>();
        mapResStatusLBAD.put(propertiesMetadata[0].get('LBAD ID'),'Success');
        listMapResStatusLBAD.add(mapResStatusLBAD);

        List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper> resResult = new List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper>();
        AMFS_PreviewLogBookDokumenController.APIResponseWrapper result = new AMFS_PreviewLogBookDokumenController.APIResponseWrapper();

        result.status = 'Success';
        result.nameFile = propertiesImage[0].get(EIPConstant.PARAM_DOCUMENT_NAME);
        result.id = propertiesImageCV[0];
        resResult.add(result);
        List<Id> idLbad = new List<Id>();
        idLbad.add(lba.id);
        Test.setMock(HttpCalloutMock.class, new AMFS_MockHttpResponseGeneratorSuccess());
        Test.startTest();
        System.enqueueJob(new AMFS_SubmitImageServiceQueueable(idLbad,LBDIds, propertiesMetadata,propertiesImage, propertiesImageCV, 0));
        Test.stopTest();
    }
    @isTest
    static void testSubmitMetadatacatch() {
        EIPJson.EIP_Body theBody2 = new EIPJson.EIP_Body();
        theBody2.operation = 'upload image';
        theBody2.transactionId = '0056F000004TDzzQAG-20250921-772bdcd046f96f4e78c5ab18d23aa8e8';
        theBody2.status = '1';
        theBody2.entity = 'AMFS';
        theBody2.service = 'addCustomer';
        theBody2.appID = 'DIPCAD';
        EIPJson dataResponse2 = new EIPJson();
        dataResponse2.Body = theBody2;

        List<EIPJson> responseListSuccess = new List<EIPJson>();
        responseListSuccess.add(dataResponse2);
        
        Log_Book_Activitiy__c testLogBook = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001'];
        AMFS_PreviewLogBookDokumenController controller = new AMFS_PreviewLogBookDokumenController();
        Id logbookId = testLogBook.Id;
        System.debug('logbookId'+logbookId);
        controller.recordId = logbookId;
        
        Test.startTest();
        AMFS_SubmitMetadataService.throwEx = true;
        AMFS_SubmitMetadataService.submitMetadataService(logbookId);
        AMFS_SubmitMetadataService.responseJson(logbookId,responseListSuccess);
        Test.stopTest();
    }

    @isTest
    static void testSubmitMetadatacatch2() {
        EIPJson.EIP_Body theBody2 = new EIPJson.EIP_Body();
        theBody2.operation = 'upload image';
        theBody2.transactionId = '0056F000004TDzzQAG-20250921-772bdcd046f96f4e78c5ab18d23aa8e8';
        theBody2.status = '1';
        theBody2.entity = 'AMFS';
        theBody2.service = 'addCustomer';
        theBody2.appID = 'DIPCAD';
        EIPJson dataResponse2 = new EIPJson();
        dataResponse2.Body = theBody2;

        List<EIPJson> responseListSuccess = new List<EIPJson>();
        responseListSuccess.add(dataResponse2);
        
        Log_Book_Activitiy__c testLogBook = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001'];
        AMFS_PreviewLogBookDokumenController controller = new AMFS_PreviewLogBookDokumenController();
        Id logbookId = testLogBook.Id;
        System.debug('logbookId'+logbookId);
        controller.recordId = logbookId;
        
        Test.startTest();
        AMFS_SubmitMetadataService.throwEx = true;
        AMFS_SubmitMetadataService.logThrowEx = true;
        AMFS_SubmitMetadataService.submitMetadataService(logbookId);
        AMFS_SubmitMetadataService.responseJson(logbookId,responseListSuccess);
        Test.stopTest();
    }

    @isTest
    static void testSubmitMetadataOP() {
        Log_Book_Activitiy__c testLogBook = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001'];
        Id logbookId = testLogBook.Id;
        Test.startTest();
        AMFS_SubmitMetadataService.submitMetadataServiceOP(logbookId);
        Test.stopTest();
    }
    @isTest
    static void testSubmitMetadataPM() {
        Log_Book_Activitiy__c testLogBook = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001'];
        Id logbookId = testLogBook.Id;
        Test.startTest();
        AMFS_SubmitMetadataService.propertiesMap(logbookId);
        Test.stopTest();
    }

    @isTest
    static void testSubmitMetadata2() {
        EIPJson.EIP_Body theBody = new EIPJson.EIP_Body();
        theBody.operation = 'upload image';
        theBody.transactionId = '0056F000004TDzzQAG-20250921-772bdcd046f96f4e78c5ab18d23aa8e8';
        theBody.status = '0';
        theBody.entity = 'AMFS';
        theBody.service = 'addCustomer';
        theBody.appID = 'DIPCAD';
        EIPJson dataResponse = new EIPJson();
        dataResponse.Body = theBody;

        EIPJson.EIP_Body theBody2 = new EIPJson.EIP_Body();
        theBody2.operation = 'upload image';
        theBody2.transactionId = '0056F000004TDzzQAG-20250921-772bdcd046f96f4e78c5ab18d23aa8e8';
        theBody2.status = '1';
        theBody2.entity = 'AMFS';
        theBody2.service = 'addCustomer';
        theBody2.appID = 'DIPCAD';
        EIPJson dataResponse2 = new EIPJson();
        dataResponse2.Body = theBody2;
        EIPJson dataResponse3 = new EIPJson();
        dataResponse3.Body = null;

        List<EIPJson> responseListFailed = new List<EIPJson>();
        responseListFailed.add(dataResponse);
        List<EIPJson> responseListPartial = new List<EIPJson>();
        responseListPartial.add(dataResponse);
        responseListPartial.add(dataResponse2);
        List<EIPJson> responseListNull = new List<EIPJson>();
        responseListNull.add(dataResponse3);
        
        Log_Book_Activitiy__c testLogBook = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001'];
        AMFS_PreviewLogBookDokumenController controller = new AMFS_PreviewLogBookDokumenController();
        Id logbookId = testLogBook.Id;
        System.debug('logbookId'+logbookId);
        controller.recordId = logbookId;
        
        Test.startTest();
        
        AMFS_SubmitMetadataService.responseJson(logbookId,responseListFailed);
        AMFS_SubmitMetadataService.responseJson(logbookId,responseListPartial);
        AMFS_SubmitMetadataService.responseJson(logbookId,responseListNull);

        String response = '{"status": "Success"}';
        String request = 'Error';
        Long startTime = 1672531200000L;
        Long endTime = 1672531201000L;
        String policyNo = 'POL12345';
        String caseNumber = 'CS54321';
        String logLabel = 'TestLabel';
        AMFS_SubmitMetadataService.getMessageResponse(logbookId);
        AMFS_SubmitMetadataService.logTransaction(response, request, startTime, endTime, policyNo, caseNumber, logLabel);
        Test.stopTest();
    }
    
    @isTest
    static void testGetMetadata() {
        Log_Book_Activitiy__c testLogBook = [SELECT Id FROM Log_Book_Activitiy__c WHERE Queue_No__c = 'A001'];
        AMFS_PreviewLogBookDokumenController controller = new AMFS_PreviewLogBookDokumenController();
        Id logbookId = testLogBook.Id;
        System.debug('logbookId'+logbookId);
        controller.recordId = logbookId;
        
        Test.startTest();
        List<Object> ress = controller.getMetadata(logbookId);
        Test.stopTest();
    }

    public class AMFS_MockHttpResponseGeneratorSuccess implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"Body": {"status": "1","message":"Success","data":{}}}');
            res.setStatusCode(200);
            return res;
        }
    }
    public class AMFS_MockHttpResponseGeneratorFailed implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"Body": {"status": "0","message":"Success","data":{}}}');
            res.setStatusCode(200);
            return res;
        }
    }
    public class AMFS_MockHttpResponseGeneratorNoBody implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{}');
            res.setStatusCode(200);
            return res;
        }
    }
}