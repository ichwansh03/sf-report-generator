@isTest
public class UserManagement_Test {
    public testMethod static void testInit(){
        Test.startTest();
        UserManagement um = new UserManagement();
        Contact con = getContact();
        PageReference myVfPage = Page.UserManagement;
        Test.setCurrentPage(myVfPage);
        ApexPages.currentPage().getParameters().put('contact_id',con.ID);
        um.init();
        um.getTypeOfRequestList();
        um.phone = '083897456200';
        um.getTypeOfDataList();
        test.stopTest();
    }
    
    public testMethod static void testSubmitResend(){
        Test.startTest();
        UserManagement um = new UserManagement();
        Contact con = getContact();
        PageReference myVfPage = Page.UserManagement;
        Test.setCurrentPage(myVfPage);
        um.dob = Date.valueOf('2020-02-01');
        um.typeOfRequest = 'Resend Activation Link';
        um.phone = '6283897456200';
        ApexPages.currentPage().getParameters().put('contact_id',con.ID);
        um.init();
        um.submit();
        Test.stopTest();
    }
    
    public testMethod static void testSubmitReset(){
        Test.startTest();
        UserManagement um = new UserManagement();
        Contact con = getContact();
        PageReference myVfPage = Page.UserManagement;
        Test.setCurrentPage(myVfPage);
        ApexPages.currentPage().getParameters().put('contact_id',con.ID);
        um.dob = Date.valueOf('2020-02-01');
        um.typeOfRequest = 'Request for Reset Password';
        um.phone = '6283897456200';
        um.init();
        um.submit();
        test.stopTest();
    }
    
    public testMethod static void testSubmitBlock(){
        Test.startTest();
        UserManagement um = new UserManagement();
        Contact con = getContact();
        PageReference myVfPage = Page.UserManagement;
        Test.setCurrentPage(myVfPage);
        ApexPages.currentPage().getParameters().put('contact_id',con.ID);
        um.dob = Date.valueOf('2020-02-01');
        um.typeOfRequest = 'Block User';
        um.phone = '6283897456200';
        um.init();
        um.submit();
        test.stopTest();
    }
    
    public testMethod static void testSubmitUnblock(){
        Test.startTest();
        UserManagement um = new UserManagement();
        Contact con = getContact();
        PageReference myVfPage = Page.UserManagement;
        Test.setCurrentPage(myVfPage);
        ApexPages.currentPage().getParameters().put('contact_id',con.ID);
        um.dob = Date.valueOf('2020-02-01');
        um.typeOfRequest = 'Unblock User';
        um.phone = '6283897456200';
        um.init();
        um.submit();
        test.stopTest();
    }
    
    public testMethod static void testSubmitUpdateKorespondensi(){
        Test.startTest();
        UserManagement um = new UserManagement();
        Contact con = getContact();
        PageReference myVfPage = Page.UserManagement;
        Test.setCurrentPage(myVfPage);
        ApexPages.currentPage().getParameters().put('contact_id',con.ID);
        um.dob = Date.valueOf('2020-02-01');
        um.typeOfRequest = 'Update Data';
        um.typeOfData = 'Alamat Korespondensi';
        Postal_Code__c post = getListKorespondensi();
        um.getProvincesSelectList();
        um.getCitiesSelectList();
        um.getSubDistrictsSelectList();
        um.getVillagesSelectList();
        um.phone = '6283897456200';
        um.address = 'Jl. Prof Satrio';
        um.subDistrict = post.Sub_District__c;
        um.village = post.Village__c;
        um.city = post.City__c;
        um.province = post.Province__c;
        um.getPostalCode();
        um.init();
        um.submit();
        test.stopTest();
    }
    
    public testMethod static void testNullSubmitUpdateKorespondensi(){
        Test.startTest();
        UserManagement um = new UserManagement();
        Contact con = getContact();
        PageReference myVfPage = Page.UserManagement;
        Test.setCurrentPage(myVfPage);
        ApexPages.currentPage().getParameters().put('contact_id',con.ID);
        um.dob = Date.valueOf('2020-02-01');
        um.typeOfRequest = 'Update Data';
        um.typeOfData = 'Alamat Korespondensi';
        um.phone = '6283897456200';
        um.init();
        um.submit();
        test.stopTest();
    }
    
    public testMethod static void testSubmitUpdateEmail(){
        Test.startTest();
        UserManagement um = new UserManagement();
        Contact con = getContact();
        PageReference myVfPage = Page.UserManagement;
        Test.setCurrentPage(myVfPage);
        ApexPages.currentPage().getParameters().put('contact_id',con.ID);
        um.dob = Date.valueOf('2020-02-01');
        um.typeOfRequest = 'Update Data';
        um.typeOfData = 'Alamat Email';
        um.newEmail = 'abcde@gmail.com';
        um.phone = '6283897456200';
        um.init();
        um.submit();
        test.stopTest();
    }
    
    public testMethod static void testSubmitUpdateNoHP(){
        Test.startTest();
        UserManagement um = new UserManagement();
        Contact con = getContact();
        PageReference myVfPage = Page.UserManagement;
        Test.setCurrentPage(myVfPage);
        ApexPages.currentPage().getParameters().put('contact_id',con.ID);
        um.dob = Date.valueOf('2020-02-01');
        um.typeOfRequest = 'Update Data';
        um.typeOfData = 'Nomor Handphone';
        um.phone = '6283897456200';
        um.init();
        um.submit();
        test.stopTest();
    }
    
    public testMethod static void testSubmitUpdateNoWA(){
        Test.startTest();
        UserManagement um = new UserManagement();
        Contact con = getContact();
        PageReference myVfPage = Page.UserManagement;
        Test.setCurrentPage(myVfPage);
        ApexPages.currentPage().getParameters().put('contact_id',con.ID);
        um.dob = Date.valueOf('2020-02-01');
        um.typeOfRequest = 'Update Data';
        um.typeOfData = 'Nomor Whatsapp';
        um.phone = '083897456200';
        um.init();
        um.submit();
        test.stopTest();
    }
    
    static testMethod void testInquiryData(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new UserManagement_Mock());
        /*
        Contact con = new Contact();
        con = getContact();
        PageReference myVfPage = Page.UserManagement;
        Test.setCurrentPage(myVfPage);
        ApexPages.currentPage().getParameters().put('contact_id',con.ID);
		*/
        UserManagement um = new UserManagement();
        um.typeOfRequest = 'Inquiry Data';
        um.email = 'abcde@gmail.com';
        um.policyNo = '100-402-0426043';
        um.phone = '6283897456200';
        um.init();
        um.submit();
        Test.stopTest();
    }
    
    static testMethod void testInquiryDataOnlineRegistration(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new UserManagement_Mock());
        
        UserManagement um = new UserManagement();
        um.typeOfRequest = 'Inquiry Data Online Registration';
        um.email = 'abcde@gmail.com';
        um.policyNo = '100-402-0426043';
        um.phone = '6283897456200';
        um.init();
        um.submit();
        Test.stopTest();
    }
    
    static testMethod void testAddPolicy(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new UserManagement_Mock());
        UserManagement um = new UserManagement();
        um.typeOfRequest = 'Add Policy';
        um.email = 'abcde@gmail.com';
        um.policyNo = '100-402-0426043';
        um.phone = '6283897456200';
        um.dob = Date.today();
        um.gender = 'M';
        
        um.init();
        um.submit();
        
        Test.stopTest();
    }
    
    static testMethod void testInquiryDataGuest(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new UserManagement_Mock());
        
        UserManagement um = new UserManagement();
        um.typeOfRequest = 'Inquiry Data Guest';
        um.email = 'abcde@gmail.com';
        um.policyNo = '100-402-0426043';
        um.phone = '6283897456200';
        
        um.init();
        um.submit();
        Test.stopTest();
    }
    
    static testMethod void testInquiryStatusKaryawan(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new UserManagement_Mock());
        
        UserManagement um = new UserManagement();
        um.typeOfRequest = 'Inquiry Status Karyawan';
        um.email = 'abcde@gmail.com';
        um.policyNo = '100-402-0426043';
        um.phone = '6283897456200';
        
        um.init();
        um.submit();
        Test.stopTest();
    }
    
    static testMethod void testResendEmailEmployee(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new UserManagement_Mock());
        
        UserManagement um = new UserManagement();
        um.typeOfRequest = 'Resend Email Employee';
        um.email = 'abcde@gmail.com';
        um.policyNo = '100-402-0426043';
        um.phone = '6283897456200';
        
        um.init();
        um.submit();
        Test.stopTest();
    }
    
    static testMethod void testReqUserId(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new UserManagement_Mock());
        UserManagement um = new UserManagement();
        um.typeOfRequest = 'Request User ID';
        um.email = 'abcde@gmail.com';
        um.policyNo = '100-402-0426123';
        um.phone = '6283897456200';
        um.dob = Date.today();
        um.gender = 'M';
        um.init();
        um.submit();
        Test.stopTest();
    }
   	static testMethod void testTracking(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new UserManagement_Mock());
        
        UserManagement um = new UserManagement();
        um.policyNo = '100-402-042123';
        um.typeOfRequest = 'Inquiry Status Tracking';
        um.phone = '6283897456200';
        um.init();
        um.submit();
        Test.stopTest();
    }
    static testMethod void testTrackingList(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new UserManagement_Mock());
        UserManagement um = new UserManagement();
        um.startDate = Date.today() - 30;
        um.endDate = Date.today() ;
        um.typeOfRequest = 'Inquiry Tracking List';
        um.phone = '6283897456200';
        um.init();
        um.submit();
        Test.stopTest();
    }
    
    
    public static Contact getContact(){
        Contact con = new Contact(LastName='Just Test',
                                  Policy_No__c ='123-1234567',
                                  Email ='abc@gmail.com',
                                  mdmid_owner__c='70123456',
                                  Entity__c='AMFS');
        insert con;
        return con;
    }
    
    public static Postal_Code__c getListKorespondensi(){
        Postal_Code__c kor = new Postal_Code__c(Province__c = 'DKI Jakarta', City__c = 'Jakarta Selatan', Sub_District__c = 'Setiabudi', Village__c = 'Kuningan', Postal_Code__c = '12910');
        insert kor;
        return kor;
    }
}