/**
 * @description       : Test Class For AMFS_EmailGenerateController
 * @author            : Ahmad Yazid Munif
 * @group             : 
 * @last modified on  : 09-15-2025
 * @last modified by  : Ahmad Yazid Munif
**/

@isTest
private class AMFS_EmailGenerateController_Test {
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
        
        Log_Book_Activitiy__c logBook2 = new Log_Book_Activitiy__c();
        logBook2.Touch_Point__c = 'Head Office';
        logBook2.Log_Book_Date__c = Date.today();
        logBook2.Queue_No__c = 'A002';
        logBook2.Time_In__c = Time.newInstance(15, 0, 0, 0);
        logBook2.Time_Served__c = Time.newInstance(15, 3, 0, 0);
        logBook2.Time_Out__c = Time.newInstance(15, 20, 0, 0);
        logBook2.Waiting_Time__c = '0 hours 3 minutes';
        logBook2.Handling_Time__c = '0 hours 17 minutes';
        logBook2.Type__c = 'Walk-In';
        
        Database.SaveResult lbResultAds = Database.insert(logBook2);

        Log_Book_Activitiy__c logbook3 = new Log_Book_Activitiy__c();
        logbook3.Touch_Point__c = 'Head Office';
        logbook3.Log_Book_Date__c = Date.today();
        logbook3.Queue_No__c = 'A003';
        logbook3.Time_In__c = Time.newInstance(15, 0, 0, 0);
        logbook3.Time_Served__c = Time.newInstance(15, 3, 0, 0);
        logbook3.Time_Out__c = Time.newInstance(15, 20, 0, 0);
        logbook3.Waiting_Time__c = '0 hours 3 minutes';
        logbook3.Handling_Time__c = '0 hours 17 minutes';
        logbook3.Type__c = 'Walk-In';
        
        Database.SaveResult lbResultAds2 = Database.insert(logbook3);

        System.debug('lbResult.success ? '+lbResult.isSuccess());
        System.debug('lbResult.id ? '+lbResult.getId());
        
        Log_Book_Activitiy_Detail__c  logBookDetail = new Log_Book_Activitiy_Detail__c();
        // logBookDetail.Policy_Number__c = '100-123-1234567';
        // logBookDetail.Policy_Name_Holder__c = 'RIRIN LINDAWATI';
        // logBookDetail.Product_Type__c = 'RLS';
        // logBookDetail.Customer_Name__c = 'ririn';
        // logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        // logBookDetail.Is_Policy_Holder__c =  true;
        // logBookDetail.Segmentation__c = 'Reguler';
        // logBookDetail.Department__c = 'POS';
        // logBookDetail.Kind_Of_Transaction__c = 'Request_ADS - Rekening Penerimaan NCB';
        // logBookDetail.Document_Type__c = 'New Submission';
        // logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];Fotokopi Buku Nikah[Copy]';
        // logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        // logBookDetail.Stamp__c = 2;
        // logBookDetail.Dokumen_Tambahan__c = 'FP5';
        // logBookDetail.Customer_Mood__c = 'Normal';
        // logBookDetail.Status__c = 'New';
        // logBookDetail.Log_Book_Activitiy__c = lbResult.getId();
        // logBookDetail.Contact_Policy__c = cont.Id;
        // logBookDetail.Transaction_Type__c = 'Request';
        // listDetail.add(logBookDetail);
        
        logBookDetail = new Log_Book_Activitiy_Detail__c();
        logBookDetail.Policy_Number__c = '100-321-7654321';
        logBookDetail.Policy_Name_Holder__c = 'RITA DWI HASTATI';
        logBookDetail.Product_Type__c = 'RLS';
        logBookDetail.Customer_Name__c = 'ririn';
        logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        logBookDetail.Is_Policy_Holder__c =  true;
        logBookDetail.Segmentation__c = 'Reguler';
        logBookDetail.Department__c = 'POS';
        logBookDetail.Kind_Of_Transaction__c = 'Request_POS_Withdrawal';
        logBookDetail.Document_Type__c = 'Japen';
        logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];Fotokopi Buku Nikah[Copy]';
        logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logBookDetail.Form_Tambahan__c = 'Form Keberatan CRS';
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
        listDetail.add(logBookDetail);
        
        logBookDetail = new Log_Book_Activitiy_Detail__c();
        logBookDetail.Policy_Number__c = '100-321-7654322';
        logBookDetail.Policy_Name_Holder__c = 'RITA DWI HASTATI';
        logBookDetail.Product_Type__c = 'RLS';
        logBookDetail.Customer_Name__c = 'ririn';
        logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        logBookDetail.Is_Policy_Holder__c =  true;
        logBookDetail.Segmentation__c = 'Reguler';
        logBookDetail.Department__c = 'POS';
        logBookDetail.Kind_Of_Transaction__c = 'Request_POS_Japen Non Financial';
        logBookDetail.Form_Utama__c = 'Request_POS_ Perubahan Alamat email';
        logBookDetail.Input_Form_Utama__c = true;
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
        logBookDetail.EForm__c = false;
        logBookDetail.Contact_Policy__c = cont.Id;
        logBookDetail.Log_Book_Activitiy__c = lbResult.getId();
        logBookDetail.Transaction_Type__c = 'Request';
        listDetail.add(logBookDetail);

        logBookDetail = new Log_Book_Activitiy_Detail__c();
        logBookDetail.Policy_Number__c = '100-321-7654323';
        logBookDetail.Policy_Name_Holder__c = 'RITA DWI HASTATI';
        logBookDetail.Product_Type__c = 'DMTM';
        logBookDetail.Customer_Name__c = 'ririn';
        logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        logBookDetail.Is_Policy_Holder__c =  true;
        logBookDetail.Segmentation__c = 'Reguler';
        logBookDetail.Department__c = 'ADS';
        logBookDetail.Kind_Of_Transaction__c = 'Request_ADS_Perubahan Ahli waris';
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
        logBookDetail.Log_Book_Activitiy__c = lbResultAds.getId();
        logBookDetail.Transaction_Type__c = 'Request';
        listDetail.add(logBookDetail);

        List<Database.SaveResult> lbdResults = Database.insert(listDetail);
        System.debug('lbdResults ? '+lbdResults);
        
        Log_Book_Activitiy_Detail__c detail = [SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = '100-321-7654321' LIMIT 1];
        String x = '{"068BK000004V1K5YAK":{"status":"Success","nameFile":"KTP (Copy)","idLBAD":"'+detail.id+'","id":"068BK000004V1K5YAK"},"a1xBK000001D0T3YAK":{"status":"Success","nameFile":"LogBook Activity Detail","idLBAD":"'+detail.id+'","id":"'+detail.id+'"}}';
        detail.Status_Metadata__c = x;
        detail.Status_to_Metadata__c = 'Success';
        update detail;
        Log_Book_Activitiy_Detail__c detail3 = [SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Policy_Number__c = '100-321-7654323' LIMIT 1];
        String xx = '{"068BK000004V1K5YAK":{"status":"Success","nameFile":"KTP (Copy)","idLBAD":"'+detail3.id+'","id":"068BK000004V1K5YAK"},"a1xBK000001D0T3YAK":{"status":"Failed","nameFile":"LogBook Activity Detail","idLBAD":"'+detail3.id+'","id":"'+detail3.id+'"}}';
        detail3.Status_Metadata__c = xx;
        detail3.Status_to_Metadata__c = 'Failed';
        update detail3;
        List<E_Form_Master_Data__c> listEForms = new List<E_Form_Master_Data__c>();
        listEForms.add(new E_Form_Master_Data__c(
            Name = 'Perubahan Alamat Email Japen - 520-4931835',
            Log_Book_Activitiy_Detail__c = detail.Id
        ));
        listEForms.add(new E_Form_Master_Data__c(
            Name = 'Perubahan Ahli waris - 520-4931835',
            Log_Book_Activitiy_Detail__c = detail3.Id
        ));
        insert listEForms;
        // dipcad Code
        List<Master_Dipcad_Code__c> testDipcadCodes = new List<Master_Dipcad_Code__c>();
        testDipcadCodes.add(new Master_Dipcad_Code__c(
            Name = 'REGWTH',
            Kind_of_Transaction__c = 'Request_POS_Withdrawal',
            Deskripsi__c = 'Withdrawal (Penarikan Dana)',
            Department__c = 'POS',
            Is_E_Form__c = true
        ));

        testDipcadCodes.add(new Master_Dipcad_Code__c(
            Name = 'TOPUPLS',
            Kind_of_Transaction__c = 'Request_POS Lumpsum',
            Deskripsi__c = 'Lumpsum Top Up (Top Up Sekaligus)',
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
    @isTest
    static void testPOS() {
        Log_Book_Activitiy__c logbookPOS = [SELECT Id,Touch_Point__c,Queue_No__c FROM Log_Book_Activitiy__c WHERE Queue_No__c='A001'];
        Test.startTest();
        AMFS_EmailGenerateController.sendEmailtoDipcad(logbookPOS.Id,logbookPOS.Touch_Point__c,logbookPOS.Queue_No__c,'createLogBook');
        Test.stopTest();
    }

    @isTest
    static void testADS() {
        Log_Book_Activitiy__c logbookADS = [SELECT Id,Touch_Point__c,Queue_No__c FROM Log_Book_Activitiy__c WHERE Queue_No__c='A002'];
        Test.startTest();
        AMFS_EmailGenerateController.sendEmailtoDipcad(logbookADS.Id,logbookADS.Touch_Point__c,logbookADS.Queue_No__c,'createLogBook');
        Test.stopTest();
    }
    @isTest
    static void testError() {
        Log_Book_Activitiy__c logbookADS = [SELECT Id,Touch_Point__c,Queue_No__c FROM Log_Book_Activitiy__c WHERE Queue_No__c='A003'];
        Test.startTest();
        AMFS_EmailGenerateController.sendEmailtoDipcad(logbookADS.Id,logbookADS.Touch_Point__c,logbookADS.Queue_No__c,'createLogBook');
        Test.stopTest();
    }
}