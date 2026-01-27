@isTest(SeeAllData=true)
public class DMUUploadController_TEST {

    private static UserRole userRole = [SELECT Id FROM UserRole WHERE Name = 'DMU Manager AMFS' LIMIT 1];
    private static User user = [SELECT Id FROM User WHERE UserRoleId =: userRole.id and isActive = true LIMIT 1];

    private static List<Case> caseRequests = [SELECT Id, CaseNumber FROM Case WHERE Type = 'Request' AND Status = 'New' AND Entity__c = 'AMFS' LIMIT 2];
    private static String caseNumberRequest1 = caseRequests[0].CaseNumber;
    private static String caseNumberRequest = caseRequests[1].CaseNumber;
    private static String caseNumberRequest2 = caseNumberRequest.substring(1);

    private static List<Case> caseComplaints = [SELECT Id, CaseNumber FROM Case WHERE Type = 'Complaint' AND CHS_Status__c = 'New' AND Entity__c = 'AMFS' LIMIT 2];
    private static String caseNumberComplaint1 = caseComplaints[0].CaseNumber;
    private static String caseNumberComplaint = caseComplaints[1].CaseNumber;
    private static String caseNumberComplaint2 = caseNumberComplaint.substring(1);

    // RES NEW REQUEST
    static testMethod void resInquiryUploadCsv() {
        
        System.runAs(user) {
            System.debug('Current User: ' + UserInfo.getUserName());
            // run as DMU Supervisor
            DMUUploadController controller = new DMUUploadController();
            Test.setCurrentPage(Page.DmuUploadCases);

            // catch
            controller.resInquiryfileSize = 1;
            controller.resInquiryFileName = 'test_case1.csv';
            controller.resChsFileBody = Blob.valueOf('REQUEST_NO,REMARK\n'+ caseNumberRequest2 +',nasabah req duplicate policy ke alamat DSN PONCO RT004/RW001 DESA SUCIHARJO KEC. PARENGAN KAB. TUBAN 62366 (DEKAT MASJID TONANG BONANG) UP. BPK. MOCH. MAKIN dan nomor yang dapat di hubungi 082330530593');
            controller.resInquiryUploadCsv();

            // negative test file size
            controller.resInquiryfileSize = 0;
            controller.resInquiryFileName = 'test_case1.csv';
            controller.resInquiryFileBody = Blob.valueOf('REQUEST_NO,REMARK\n'+ caseNumberRequest1 +',nasabah req duplicate policy ke alamat DSN PONCO RT004/RW001 DESA SUCIHARJO KEC. PARENGAN KAB. TUBAN 62366 (DEKAT MASJID TONANG BONANG) UP. BPK. MOCH. MAKIN dan nomor yang dapat di hubungi 082330530593');
            controller.resInquiryUploadCsv();

            // negative test file name
            controller.resInquiryfileSize = 1;
            controller.resInquiryFileName = 'test_case1.xlsx';
            controller.resInquiryFileBody = Blob.valueOf('REQUEST_NO,REMARK\n'+ caseNumberRequest1 +',nasabah req duplicate policy ke alamat DSN PONCO RT004/RW001 DESA SUCIHARJO KEC. PARENGAN KAB. TUBAN 62366 (DEKAT MASJID TONANG BONANG) UP. BPK. MOCH. MAKIN dan nomor yang dapat di hubungi 082330530593');
            controller.resInquiryUploadCsv();

            // negative test data case number is not numeric
            controller.resInquiryfileSize = 1;
            controller.resInquiryFileName = 'test_case1.csv';
            controller.resInquiryFileBody = Blob.valueOf('REQUEST_NO,REMARK\n0155180X,nasabah req duplicate policy ke alamat DSN PONCO RT004/RW001 DESA SUCIHARJO KEC. PARENGAN KAB. TUBAN 62366 (DEKAT MASJID TONANG BONANG) UP. BPK. MOCH. MAKIN dan nomor yang dapat di hubungi 082330530593');
            controller.resInquiryUploadCsv();

            // negative test data case number is empty
            controller.resInquiryfileSize = 1;
            controller.resInquiryFileName = 'test_case1.csv';
            controller.resInquiryFileBody = Blob.valueOf('REQUEST_NO,REMARK\n02551807,nasabah req duplicate policy 082330530593');
            controller.resInquiryUploadCsv();

            // negative test data case number is not found
            controller.resInquiryfileSize = 1;
            controller.resInquiryFileName = 'test_case1.csv';
            controller.resInquiryFileBody = Blob.valueOf('REQUEST_NO,REMARK\n02551807,nasabah req duplicate policy 082330530593\n'+ caseNumberRequest2 +',nasabah req duplicate policy di hubungi 082330530593\n02551822,BANJAR KEBILBIL PACUNG DESA BELALANG KEC. KEDIRI KAB. TABANAN - BALI 82171 (085237471985)');
            controller.resInquiryUploadCsv();

            // postive test
            controller.resInquiryfileSize = 1;
            controller.resInquiryFileName = 'test_case1.csv';
            controller.resInquiryFileBody = Blob.valueOf('REQUEST_NO,REMARK\n'+ caseNumberRequest2 +',nasabah req duplicate policy ke alamat DSN PONCO RT004/RW001 DESA SUCIHARJO KEC. PARENGAN KAB. TUBAN 62366 (DEKAT MASJID TONANG BONANG) UP. BPK. MOCH. MAKIN dan nomor yang dapat di hubungi 082330530593');
            controller.resInquiryUploadCsv();
        }
    }

    static testMethod void resChsUploadCsv() {
        System.runAs(user) {
            DMUUploadController controller = new DMUUploadController();
            Test.setCurrentPage(Page.DmuUploadCases);

            // catch
            controller.resChsfileSize = 1;
            controller.resChsFileName = 'test_case2.csv';
            controller.resInquiryFileBody = Blob.valueOf('REQUEST_NO,REMARK\n' + caseNumberComplaint2 + ',"REQ SPEED UP TO KURIR KE Dr. TOM layanan 119 gedung adhyatma, lantai 5 KEMENKES republik indonesia jl. hr rasuna said blok. X5, kav.4-9 jakarta selatan.12950"');
            controller.resChsUploadCsv();

            // invalid file
            controller.resChsfileSize = 0;
            controller.resChsFileName = 'test_case2.csv';
            controller.resChsFileBody = Blob.valueOf('REQUEST_NO,REMARK\n' + caseNumberComplaint2 + ',"REQ SPEED UP TO KURIR KE Dr. TOM layanan 119 gedung adhyatma, lantai 5 KEMENKES republik indonesia jl. hr rasuna said blok. X5, kav.4-9 jakarta selatan.12950"');
            controller.resChsUploadCsv();

            // invalid data
            controller.resChsfileSize = 1;
            controller.resChsFileName = 'test_case2.csv';
            controller.resChsFileBody = Blob.valueOf('REQUEST_NO,REMARK\n' + caseNumberComplaint2 + ',"REQ SPEED UP TO KURIR KE Dr. TOM layanan 119 gedung adhyatma, lantai 5 KEMENKES republik indonesia jl. hr rasuna said blok. X5, kav.4-9 jakarta selatan.12950"');
            controller.resChsUploadCsv();

            // positive
            controller.resChsfileSize = 1;
            controller.resChsFileName = 'test_case2.csv';
            controller.resChsFileBody = Blob.valueOf('REQUEST_NO,REMARK\n'+ caseNumberComplaint1 +',req speed up to NCS Test 7');
            controller.resChsUploadCsv();
        }
    }

    static testMethod void resUploadCsv() {
        System.runAs(user) {
            DMUUploadController controller = new DMUUploadController();
            Test.setCurrentPage(Page.DmuUploadCases);

            // catch
            controller.investigationfileSize = 1;
            controller.investigationFileName = 'test_case3.csv';
            controller.resInquiryFileBody = Blob.valueOf('REQUEST_NO,REMARK\n' + caseNumberComplaint2 + ',"REQ SPEED UP TO KURIR KE Dr. TOM layanan 119 gedung adhyatma, lantai 5 KEMENKES republik indonesia jl. hr rasuna said blok. X5, kav.4-9 jakarta selatan.12950"');
            controller.resUploadCsv();

            // invalid file
            controller.investigationfileSize = 0;
            controller.investigationFileName = 'test_case3.csv';
            controller.investigationFileBody = Blob.valueOf('REQUEST_NO,REMARK\n' + caseNumberComplaint2 + ',"REQ SPEED UP TO KURIR KE Dr. TOM layanan 119 gedung adhyatma, lantai 5 KEMENKES republik indonesia jl. hr rasuna said blok. X5, kav.4-9 jakarta selatan.12950"');
            controller.resUploadCsv();

            // invalid data
            controller.investigationfileSize = 1;
            controller.investigationFileName = 'test_case3.csv';
            controller.investigationFileBody = Blob.valueOf('REQUEST_NO,REMARK\n' + caseNumberComplaint2 + ',"REQ SPEED UP TO KURIR KE Dr. TOM layanan 119 gedung adhyatma, lantai 5 KEMENKES republik indonesia jl. hr rasuna said blok. X5, kav.4-9 jakarta selatan.12950"');
            controller.resUploadCsv();

            // positive
            controller.investigationfileSize = 1;
            controller.investigationFileName = 'test_case3.csv';
            controller.investigationFileBody = Blob.valueOf('REQUEST_NO,REMARK\n'+ caseNumberComplaint1 +',DMU: Req Investigasi to Kurir');
            controller.resUploadCsv();
        }
    }

    // UPDATE & REASSIGN
    static testMethod void uploadCsv() {

        System.runAs(user) {
            System.debug('Current User: ' + UserInfo.getUserName());
            DMUUploadController controller = new DMUUploadController();
            Test.setCurrentPage(Page.DmuUploadCases);
            controller.cs.PIC__c = user.Id;

            // catch
            controller.csvfileSize = 1;
            controller.csvFileName = 'test_case3.csv';
            controller.resInquiryFileBody = Blob.valueOf('REQUEST_NO,REMARK\n' + caseNumberComplaint2 + ',"REQ SPEED UP TO KURIR KE Dr. TOM layanan 119 gedung adhyatma, lantai 5 KEMENKES republik indonesia jl. hr rasuna said blok. X5, kav.4-9 jakarta selatan.12950"');
            controller.uploadCsv();

            // invalid file
            controller.csvfileSize = 0;
            controller.csvFileName = 'test_case3.csv';
            controller.csvFileBody = Blob.valueOf('REQUEST_NO,REMARK\n' + caseNumberComplaint2 + ',"REQ SPEED UP TO KURIR KE Dr. TOM layanan 119 gedung adhyatma, lantai 5 KEMENKES republik indonesia jl. hr rasuna said blok. X5, kav.4-9 jakarta selatan.12950"');
            controller.uploadCsv();

            // invalid data
            controller.csvfileSize = 1;
            controller.csvFileName = 'test_case3.csv';
            controller.csvFileBody = Blob.valueOf('REQUEST_NO,REMARK\n' + caseNumberComplaint2 + ',"REQ SPEED UP TO KURIR KE Dr. TOM layanan 119 gedung adhyatma, lantai 5 KEMENKES republik indonesia jl. hr rasuna said blok. X5, kav.4-9 jakarta selatan.12950"');
            controller.uploadCsv();

            // positive
            controller.csvfileSize = 1;
            controller.csvFileName = 'test_case3.csv';
            controller.csvFileBody = Blob.valueOf('REQUEST_NO,REMARK\n'+ caseNumberComplaint1 +',DMU: Req Investigasi to Kurir');
            controller.uploadCsv();
        }
    }

    // UPDATE & CLOSE NEW REQ
    static testMethod void reqCloseUploadCsv() {

        System.runAs(user) {
            System.debug('Current User: ' + UserInfo.getUserName());
            DMUUploadController controller = new DMUUploadController();
            Test.setCurrentPage(Page.DmuUploadCases);

            // catch
            controller.reqClosefileSize = 1;
            controller.reqCloseFileName = 'test_case3.csv';
            controller.isIcf = true;
            controller.resInquiryFileBody = Blob.valueOf('REQUEST_NO,REMARK\n' + caseNumberRequest2 + ',"REQ SPEED UP TO KURIR KE Dr. TOM",Closed');
            controller.reqCloseUploadCsv();

            // invalid file
            controller.reqClosefileSize = 0;
            controller.reqCloseFileName = 'test_case3.csv';
            controller.isIcf = true;
            controller.reqCloseFileBody = Blob.valueOf('REQUEST_NO,REMARK\n' + caseNumberRequest2 + ',"REQ SPEED UP TO KURIR KE Dr. TOM",Closed');
            controller.reqCloseUploadCsv();

            // invalid data
            controller.reqClosefileSize = 1;
            controller.reqCloseFileName = 'test_case3.csv';
            controller.isIcf = true;
            controller.reqCloseFileBody = Blob.valueOf('REQUEST_NO,REMARK\n' + caseNumberRequest2 + ',"REQ SPEED UP TO KURIR KE Dr. TOM",Closed');
            controller.reqCloseUploadCsv();

            // positive
            controller.reqClosefileSize = 1;
            controller.reqCloseFileName = 'test_case3.csv';
            controller.isIcf = true;
            controller.reqCloseFileBody = Blob.valueOf('REQUEST_NO,REMARK\n'+ caseNumberRequest1 +',req dupol kirim ke alamat sistem,Closed');
            controller.reqCloseUploadCsv();
        }

    }

    // UPDATE & CLOSE NEW CHS
    static testMethod void chsCloseUploadCsv() {

        System.runAs(user) {
            System.debug('Current User: ' + UserInfo.getUserName());
            DMUUploadController controller = new DMUUploadController();
            Test.setCurrentPage(Page.DmuUploadCases);

            // catch
            controller.chsClosefileSize = 1;
            controller.chsCloseFileName = 'test_case3.csv';
            controller.isIcf = true;
            controller.resInquiryFileBody = Blob.valueOf('REQUEST_NO,REMARK\n' + caseNumberComplaint2 + ',"REQ SPEED UP TO KURIR KE Dr. TOM",Closed - Valid');
            controller.chsCloseUploadCsv();

            // invalid file
            controller.chsClosefileSize = 0;
            controller.chsCloseFileName = 'test_case3.csv';
            controller.isIcf = true;
            controller.chsCloseFileBody = Blob.valueOf('REQUEST_NO,REMARK\n' + caseNumberComplaint2 + ',"REQ SPEED UP TO KURIR KE Dr. TOM",Closed - Valid');
            controller.chsCloseUploadCsv();

            // invalid data
            controller.chsClosefileSize = 1;
            controller.chsCloseFileName = 'test_case3.csv';
            controller.isIcf = true;
            controller.chsCloseFileBody = Blob.valueOf('REQUEST_NO,REMARK\n' + caseNumberComplaint2 + ',"REQ SPEED UP TO KURIR KE Dr. TOM",Closed - Valid');
            controller.chsCloseUploadCsv();

            // positive
            controller.chsClosefileSize = 1;
            controller.chsCloseFileName = 'test_case3.csv';
            controller.isIcf = true;
            controller.chsCloseFileBody = Blob.valueOf('REQUEST_NO,REMARK\n'+ caseNumberComplaint1 +',DMU Denny:Polis diterima oleh SEPTIAN SAUDARA SERUMAH 11042017,Closed - Valid');
            controller.chsCloseUploadCsv();
        }

    }

    // UPLOAD ATTACHMENT

    // indah 30Agustus2018 - Upload Functionality to Request Duplicate or re-Print Policy Book
    static testMethod void dmuUploadFunctionality_catch() {
        System.runAs(user) {
            DMUUploadController controller = new DMUUploadController();
            Test.setCurrentPage(Page.DmuUploadFunctionality);

            // catch
            controller.resDuplicatefileSize = 1;
            controller.resDuplicateFileName = 'test_case4.csv';
            controller.isIcf = true;
            controller.resInquiryFileBody = Blob.valueOf('44444444,dddddddddd');
            controller.dmuUploadFunctionality();
        }
    }
    
    static testMethod void dmuUploadFunctionality_invalidfile() {
        System.runAs(user) {
            DMUUploadController controller = new DMUUploadController();
            Test.setCurrentPage(Page.DmuUploadFunctionality);

            // invalid file
            controller.resDuplicatefileSize = 0;
            controller.resDuplicateFileName = 'test_case4.csv';
            controller.isIcf = true;
            controller.resInquiryFileBody = Blob.valueOf('44444444,dddddddddd');
            controller.dmuUploadFunctionality();
        }
    }

    static testMethod void dmuUploadFunctionality_headerinvalid() {
        System.runAs(user) {
            DMUUploadController controller = new DMUUploadController();
            Test.setCurrentPage(Page.DmuUploadFunctionality);

            // invalid data
            controller.resDuplicatefileSize = 1;
            controller.resDuplicateFileName = 'test_case4.csv';
            controller.isIcf = true;
            controller.resDuplicateFileBody = Blob.valueOf('44444444,dddddddddd');
            controller.dmuUploadFunctionality();
        }
    }
    
    static testMethod void dmuUploadFunctionality_invaliddata() {
        System.runAs(user) {
            DMUUploadController controller = new DMUUploadController();
            Test.setCurrentPage(Page.DmuUploadFunctionality);

            // invalid data
            controller.resDuplicatefileSize = 1;
            controller.resDuplicateFileName = 'test_case4.csv';
            controller.isIcf = true;
            controller.resDuplicateFileBody = Blob.valueOf('PolicyNo,Desc\n44444444,dddddddddd');
            controller.dmuUploadFunctionality();
        }
    }
    
    
    static testMethod void dmuUploadFunctionality_positive() {
        System.runAs(user) {
            DMUUploadController controller = new DMUUploadController();
            Test.setCurrentPage(Page.DmuUploadFunctionality);

            // positive
            controller.resDuplicatefileSize = 1;
            controller.resDuplicateFileName = 'test_case4.csv';
            controller.cs.type = 'Request';
            controller.cs.Case_Type_Config__c = 'Request_CCC_Call Back DMU';
            controller.cs.PIC__c = user.id;
            controller.cs.NonPP__c = false;
            controller.isIcf = true;
            controller.cs.General_Attitude__c = 'Happy';
            controller.resDuplicateFileBody = Blob.valueOf('PolicyNo,Desc\n514-8520694,diupload');
            controller.dmuUploadFunctionality();
        }
    }
    
}