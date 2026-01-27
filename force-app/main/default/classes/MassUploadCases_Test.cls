@isTest(SeeAllData=true)
public class MassUploadCases_Test {

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
    
    private static String policyNo = '519-0123123';

    static testMethod void initPage() {
        System.runAs(user) {
            Case cs = new Case();
            ApexPages.StandardController sc = new ApexPages.StandardController(cs);
            MassUploadCasesController controller = new MassUploadCasesController(sc);
            Test.setCurrentPage(Page.MassUploadCases);
            controller.getEntityList();
            controller.getStatusList();
            controller.getTypeList();
            controller.getCaseTypeList();
            controller.getPriorityList();
            controller.getGeneralAttitudeList();
            controller.getRootCauseList();
            controller.getDepartmentList();
            controller.getOriginList();
        }
    }
    
    static void insertContact(){
        Contact con = new Contact(LastName='Just Test 6',
                                   Policy_No__c ='519-0123123');
        insert con;
    }
    
    // RES NEW REQUEST
    static testMethod void massInquiryUpload() {
        
        System.runAs(user) {
            System.debug('Current User: ' + UserInfo.getUserName());
            // run as DMU Supervisor
            Case cs = new Case();
            ApexPages.StandardController sc = new ApexPages.StandardController(cs);
            MassUploadCasesController controller = new MassUploadCasesController(sc);
            insertContact();
            controller.csDepartment = 'CCC';
            controller.cs.Entity_Backup__c = 'AMFS';
            controller.cs.Type = 'Inquiry';
            controller.cs.Status = 'New';
            controller.cs.Origin = 'Email';
            controller.cs.General_Attitude__c = 'Happy';
            controller.cs.Priority = 'High';
            controller.cs.Root_Cause__c = 'DISASTER';
            controller.checkRecordType();

            controller.massInqUploadfileSize = 1;
            controller.massInqUploadfileName = 'test_case1.csv';
            controller.massInqUploadFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n'+ policyNo +',nasabah req duplicate policy ke alamat DSN PONCO RT004/RW001 DESA SUCIHARJO KEC. PARENGAN KAB. TUBAN 62366 (DEKAT MASJID TONANG BONANG) UP. BPK. MOCH. MAKIN dan nomor yang dapat di hubungi 082330530593,Test');
            controller.massCaseUpload();

            // negative test file size
            controller.massInqUploadfileSize = 0;
            controller.massInqUploadfileName = 'test_case1.csv';
            controller.massInqUploadFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n'+ policyNo +',nasabah req duplicate policy ke alamat DSN PONCO RT004/RW001 DESA SUCIHARJO KEC. PARENGAN KAB. TUBAN 62366 (DEKAT MASJID TONANG BONANG) UP. BPK. MOCH. MAKIN dan nomor yang dapat di hubungi 082330530593,Test');
            controller.massCaseUpload();

            // negative test file name
            controller.massInqUploadfileSize = 1;
            controller.massInqUploadfileName = 'test_case1.xlsx';
            controller.massInqUploadFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n'+ policyNo +',nasabah req duplicate policy ke alamat DSN PONCO RT004/RW001 DESA SUCIHARJO KEC. PARENGAN KAB. TUBAN 62366 (DEKAT MASJID TONANG BONANG) UP. BPK. MOCH. MAKIN dan nomor yang dapat di hubungi 082330530593,Test');
            controller.massCaseUpload();

            // negative test data case number is not numeric
            controller.massInqUploadfileSize = 1;
            controller.massInqUploadfileName = 'test_case1.csv';
            controller.massInqUploadFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n'+policyNo+',nasabah req duplicate policy ke alamat DSN PONCO RT004/RW001 DESA SUCIHARJO KEC. PARENGAN KAB. TUBAN 62366 (DEKAT MASJID TONANG BONANG) UP. BPK. MOCH. MAKIN dan nomor yang dapat di hubungi 082330530593,Test');
            controller.massCaseUpload();

            // negative test data case number is empty
            controller.massInqUploadfileSize = 1;
            controller.massInqUploadfileName = 'test_case1.csv';
            controller.massInqUploadFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n'+policyNo+',nasabah req duplicate policy 082330530593,Test');
            controller.massCaseUpload();

            // negative test data case number is not found
            controller.massInqUploadfileSize = 1;
            controller.massInqUploadfileName = 'test_case1.csv';
            controller.massInqUploadFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n'+policyNo+',nasabah req duplicate policy 082330530593\n'+ policyNo +',nasabah req duplicate policy di hubungi 082330530593\n02551822,BANJAR KEBILBIL PACUNG DESA BELALANG KEC. KEDIRI KAB. TABANAN - BALI 82171 (085237471985),Test');
            controller.massCaseUpload();

            // postive test
            controller.massInqUploadfileSize = 1;
            controller.massInqUploadfileName = 'test_case1.csv';
            controller.massInqUploadFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n'+ policyNo +',nasabah req duplicate policy ke alamat DSN PONCO RT004/RW001 DESA SUCIHARJO KEC. PARENGAN KAB. TUBAN 62366 (DEKAT MASJID TONANG BONANG) UP. BPK. MOCH. MAKIN dan nomor yang dapat di hubungi 082330530593,Test');
            controller.massCaseUpload();
        }
    }

    static testMethod void massCHSUpload() {
        System.runAs(user) {
            Case cs = new Case();
            ApexPages.StandardController sc = new ApexPages.StandardController(cs);
            MassUploadCasesController controller = new MassUploadCasesController(sc);
            Test.setCurrentPage(Page.MassUploadCases);
            insertContact();
            controller.csDepartment = 'CCC';
            controller.cs.Entity_Backup__c = 'AFI';
            controller.cs.Type = 'Complaint';
            controller.cs.Status = 'New';
            controller.cs.Origin = 'Email';
            controller.cs.General_Attitude__c = 'Happy';
            controller.cs.Priority = 'High';
            controller.cs.Root_Cause__c = 'DISASTER';
            controller.isDisplayAFI = true;
            controller.AFIRequired = true;
            controller.AMFS_AFIRequired = true;
            controller.AMFSRequired = false;
            controller.checkRecordType();
            
            // catch
            controller.massCompUploadfileSize = 1;
            controller.massCompUploadFileName = 'test_case2.csv';
            controller.massCompUploadFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n' + policyNo + ',"REQ SPEED UP TO KURIR KE Dr. TOM layanan 119 gedung adhyatma, lantai 5 KEMENKES republik indonesia jl. hr rasuna said blok. X5, kav.4-9 jakarta selatan.12950",Test');
            controller.massCaseUpload();

            // invalid file
            controller.massCompUploadfileSize = 0;
            controller.massCompUploadFileName = 'test_case2.xlxs';
            controller.massCompUploadFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n' + policyNo + ',"REQ SPEED UP TO KURIR KE Dr. TOM layanan 119 gedung adhyatma, lantai 5 KEMENKES republik indonesia jl. hr rasuna said blok. X5, kav.4-9 jakarta selatan.12950",Test');
            controller.massCaseUpload();

            // invalid data
            controller.massCompUploadfileSize = 1;
            controller.massCompUploadFileName = 'test_case2.csv';
            controller.massCompUploadFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n' + policyNo + ',"REQ SPEED UP TO KURIR KE Dr. TOM layanan 119 gedung adhyatma, lantai 5 KEMENKES republik indonesia jl. hr rasuna said blok. X5, kav.4-9 jakarta selatan.12950",Test');
            controller.massCaseUpload();

            // positive
            controller.massCompUploadfileSize = 1;
            controller.massCompUploadFileName = 'test_case2.csv';
            controller.massCompUploadFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n'+ policyNo +',req speed up to NCS Test 7,Test');
            controller.massCaseUpload();
        }
    }
    
    static testMethod void massRequestUpload() {
        System.runAs(user) {
            Case cs = new Case();
            ApexPages.StandardController sc = new ApexPages.StandardController(cs);
            MassUploadCasesController controller = new MassUploadCasesController(sc);
            Test.setCurrentPage(Page.MassUploadCases);
            insertContact();
            controller.csDepartment = 'CCC';
            controller.cs.Entity_Backup__c = 'AMFS';
            controller.cs.Type = 'Request';
            controller.cs.Status = 'New';
            controller.cs.Origin = 'Email';
            controller.cs.General_Attitude__c = 'Happy';
            controller.cs.Priority = 'High';
            controller.cs.Root_Cause__c = 'DISASTER';
            controller.cs.Case_Type__c = 'Request_CCC_Call Back DMU';
            controller.cs.Case_Type_Config__c = 'Request_CCC_Call Back DMU';
            controller.cs.PIC_Department_LU__c = UserInfo.getUserId();
            controller.checkRecordType();
            
            // catch
            controller.massReqUploadfileSize = 1;
            controller.massReqUploadFileName = 'test_case2.csv';
            controller.massReqUploadFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n' + policyNo + ',"REQ SPEED UP TO KURIR KE Dr. TOM layanan 119 gedung adhyatma, lantai 5 KEMENKES republik indonesia jl. hr rasuna said blok. X5, kav.4-9 jakarta selatan.12950",Test');
            controller.massCaseUpload();

            // invalid file
            controller.massReqUploadfileSize = 0;
            controller.massReqUploadFileName = 'test_case2.xlxs';
            controller.massReqUploadFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n' + policyNo + ',"REQ SPEED UP TO KURIR KE Dr. TOM layanan 119 gedung adhyatma, lantai 5 KEMENKES republik indonesia jl. hr rasuna said blok. X5, kav.4-9 jakarta selatan.12950",Test');
            controller.massCaseUpload();

            // invalid data
            controller.massReqUploadfileSize = 1;
            controller.massReqUploadFileName = 'test_case2.csv';
            controller.massReqUploadFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n' + policyNo + ',"REQ SPEED UP TO KURIR KE Dr. TOM layanan 119 gedung adhyatma, lantai 5 KEMENKES republik indonesia jl. hr rasuna said blok. X5, kav.4-9 jakarta selatan.12950",Test');
            controller.massCaseUpload();

            // positive
            controller.massReqUploadfileSize = 1;
            controller.massReqUploadFileName = 'test_case2.csv';
            controller.massReqUploadFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n'+ policyNo +',req speed up to NCS Test 7,Test');
            controller.massCaseUpload();
        }
    }
    
    static testMethod void reqCloseUpload() {
        System.runAs(user) {
            Case cs = new Case();
            ApexPages.StandardController sc = new ApexPages.StandardController(cs);
            MassUploadCasesController controller = new MassUploadCasesController(sc);
            Test.setCurrentPage(Page.MassUploadCases);
            insertContact();
            controller.csDepartment = 'CCC';
            controller.cs.Entity_Backup__c = 'AMFS';
            controller.cs.Type = 'Request';
            controller.cs.Status = 'Closed';
            controller.cs.Origin = 'Email';
            controller.cs.General_Attitude__c = 'Happy';
            controller.cs.Priority = 'High';
            controller.cs.Root_Cause__c = 'DISASTER';
            controller.checkRecordType();
            
            // catch
            controller.reqCloseFileSize = 1;
            controller.reqCloseFileName = 'test_case2.csv';
            controller.reqCloseFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n' + policyNo + ',"REQ SPEED UP TO KURIR KE Dr. TOM layanan 119 gedung adhyatma, lantai 5 KEMENKES republik indonesia jl. hr rasuna said blok. X5, kav.4-9 jakarta selatan.12950",Test');
            //controller.reqCloseUpload();

            // invalid file
            controller.reqCloseFileSize = 0;
            controller.reqCloseFileName = 'test_case2.xlxs';
            controller.reqCloseFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n' + policyNo + ',"REQ SPEED UP TO KURIR KE Dr. TOM layanan 119 gedung adhyatma, lantai 5 KEMENKES republik indonesia jl. hr rasuna said blok. X5, kav.4-9 jakarta selatan.12950",Test');
            //controller.reqCloseUpload();

            // invalid data
            controller.reqCloseFileSize = 1;
            controller.reqCloseFileName = 'test_case2.csv';
            controller.reqCloseFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n' + policyNo + ',"REQ SPEED UP TO KURIR KE Dr. TOM layanan 119 gedung adhyatma, lantai 5 KEMENKES republik indonesia jl. hr rasuna said blok. X5, kav.4-9 jakarta selatan.12950",Test');
            //controller.reqCloseUpload();

            // positive
            controller.reqCloseFileSize = 1;
            controller.reqCloseFileName = 'test_case2.csv';
            controller.reqCloseFileBody = Blob.valueOf('REQUEST_NO,Subject,Description\n'+ policyNo +',req speed up to NCS Test 7,Test');
            //controller.reqCloseUpload();
        }
    }
}