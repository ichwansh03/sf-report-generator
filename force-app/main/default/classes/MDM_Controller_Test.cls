@isTest
public class MDM_Controller_Test {
    public testMethod static void testInit(){
        Test.startTest();
        MDM_Controller mdmCtrl = new MDM_Controller();
        Contact con = getContact();
        PageReference myVfPage = Page.MDM_VFP;
        Test.setCurrentPage(myVfPage);
        ApexPages.currentPage().getParameters().put('contact_id',con.ID);
        mdmCtrl.getEntityList();
        mdmCtrl.getRelatedPolicyList();
        mdmCtrl.getSourceCIndList();
        mdmCtrl.getGenderCDList();
        mdmCtrl.getAddressTypeCDList();
        test.stopTest();
    }
    
    public testMethod static void testInitGetDataByMDMID(){
        Test.startTest();
        // Set mock callout class 
    	Test.setMock(HttpCalloutMock.class, new MDM_Controller_Test_Mock());
        MDM_Controller mdmCtrl = new MDM_Controller();
        //Contact con = getContact();
        PageReference myVfPage = Page.MDM_VFP;
        Test.setCurrentPage(myVfPage);
        ApexPages.currentPage().getParameters().put('mdmId','70123456');
        ApexPages.currentPage().getParameters().put('entity','AMFS');
        ApexPages.currentPage().getParameters().put('policyNo','123-1234567');
        mdmCtrl.initGetData();
        test.stopTest();
    }
    
    public testMethod static void testInitGetDataByPolicyNo(){
        Test.startTest();
        // Set mock callout class 
    	Test.setMock(HttpCalloutMock.class, new MDM_Controller_Test_Mock());
        MDM_Controller mdmCtrl = new MDM_Controller();
        //Contact con = getContact();
        PageReference myVfPage = Page.MDM_VFP;
        Test.setCurrentPage(myVfPage);
        //ApexPages.currentPage().getParameters().put('mdmId','70123456');
        ApexPages.currentPage().getParameters().put('entity','AMFS');
        ApexPages.currentPage().getParameters().put('policyNo','123-1234567');
        mdmCtrl.initGetData();
        PageReference myVfPageNew = Page.MDM_CustomerPortofolio;
        Test.setCurrentPage(myVfPageNew);
        mdmCtrl.previous();
        test.stopTest();
    }
    
    public testMethod static void testInitGetDataSearchMDMBySocNumber(){
        Test.startTest();
        // Set mock callout class 
    	Test.setMock(HttpCalloutMock.class, new MDM_Controller_Test_Mock());
        MDM_Controller mdmCtrl = new MDM_Controller();
        //Contact con = getContact();
        mdmCtrl.polisNo = '123-1234567';
        mdmCtrl.entity = 'AMFS';
        mdmCtrl.relatedPolicy = 'test';
        mdmCtrl.sourceCInd = EIPConstant.ID_DOC;
        mdmCtrl.customerID = 'test';
        mdmCtrl.customerRK = 'test';
        mdmCtrl.socialSecurityNO = '12345678';
        mdmCtrl.firstNM = 'test';
        mdmCtrl.birthDT = 'test';
        mdmCtrl.genderCD = 'test';
        mdmCtrl.accountNO = 'test';
        mdmCtrl.addressTypeCD = 'test';
        mdmCtrl.telephoneNo = 'test';
        mdmCtrl.emailAddress = 'test';
        mdmCtrl.getData();
        test.stopTest();
    }
    
    public testMethod static void testInitGetDataSearchMDMByAccNo(){
        Test.startTest();
        // Set mock callout class 
    	Test.setMock(HttpCalloutMock.class, new MDM_Controller_Test_Mock());
        MDM_Controller mdmCtrl = new MDM_Controller();
        //Contact con = getContact();
        mdmCtrl.polisNo = '123-1234567';
        mdmCtrl.entity = 'AMFS';
        mdmCtrl.relatedPolicy = 'test';
        mdmCtrl.sourceCInd = EIPConstant.ACC_NO;
        mdmCtrl.customerID = 'test';
        mdmCtrl.customerRK = 'test';
        mdmCtrl.socialSecurityNO = 'test';
        mdmCtrl.firstNM = 'test';
        mdmCtrl.birthDT = 'test';
        mdmCtrl.genderCD = 'test';
        mdmCtrl.accountNO = '12345678';
        mdmCtrl.addressTypeCD = 'test';
        mdmCtrl.telephoneNo = 'test';
        mdmCtrl.emailAddress = 'test';
        mdmCtrl.getData();
        test.stopTest();
    }
    
    public testMethod static void testInitGetDataSearchMDMByPhoneNo(){
        Test.startTest();
        // Set mock callout class 
    	Test.setMock(HttpCalloutMock.class, new MDM_Controller_Test_Mock());
        MDM_Controller mdmCtrl = new MDM_Controller();
        //Contact con = getContact();
        mdmCtrl.polisNo = '123-1234567';
        mdmCtrl.entity = 'AMFS';
        mdmCtrl.relatedPolicy = 'test';
        mdmCtrl.sourceCInd = EIPConstant.PHONE_NO;
        mdmCtrl.customerID = 'test';
        mdmCtrl.customerRK = 'test';
        mdmCtrl.socialSecurityNO = 'test';
        mdmCtrl.firstNM = 'test';
        mdmCtrl.birthDT = 'test';
        mdmCtrl.genderCD = 'test';
        mdmCtrl.accountNO = 'test';
        mdmCtrl.addressTypeCD = 'PHONE';
        mdmCtrl.telephoneNo = '081122223333';
        mdmCtrl.emailAddress = 'test';
        mdmCtrl.getData();
        test.stopTest();
    }
    
    public testMethod static void testInitGetDataSearchMDMByEmail(){
        Test.startTest();
        // Set mock callout class 
    	Test.setMock(HttpCalloutMock.class, new MDM_Controller_Test_Mock());
        MDM_Controller mdmCtrl = new MDM_Controller();
        //Contact con = getContact();
        mdmCtrl.polisNo = '123-1234567';
        mdmCtrl.entity = 'AMFS';
        mdmCtrl.relatedPolicy = 'test';
        mdmCtrl.sourceCInd = EIPConstant.EMAIL;
        mdmCtrl.customerID = 'test';
        mdmCtrl.customerRK = 'test';
        mdmCtrl.socialSecurityNO = 'test';
        mdmCtrl.firstNM = 'test';
        mdmCtrl.birthDT = 'test';
        mdmCtrl.genderCD = 'test';
        mdmCtrl.accountNO = 'test';
        mdmCtrl.addressTypeCD = 'EMAIL';
        mdmCtrl.telephoneNo = 'test';
        mdmCtrl.emailAddress = 'test@gmail.com';
        mdmCtrl.getData();
        test.stopTest();
    }
    
    public testMethod static void testInitGetDataSearchMDMByNameDOBGender(){
        Test.startTest();
        // Set mock callout class 
    	Test.setMock(HttpCalloutMock.class, new MDM_Controller_Test_Mock());
        MDM_Controller mdmCtrl = new MDM_Controller();
        //Contact con = getContact();
        mdmCtrl.polisNo = '123-1234567';
        mdmCtrl.entity = 'AMFS';
        mdmCtrl.relatedPolicy = 'test';
        mdmCtrl.sourceCInd = EIPConstant.NAME_DOB_GENDER;
        mdmCtrl.customerID = 'test';
        mdmCtrl.customerRK = 'test';
        mdmCtrl.socialSecurityNO = 'test';
        mdmCtrl.firstNM = 'test';
        mdmCtrl.birthDT = '12/27/2009';
        mdmCtrl.genderCD = 'test';
        mdmCtrl.accountNO = 'test';
        mdmCtrl.addressTypeCD = 'test';
        mdmCtrl.telephoneNo = 'test';
        mdmCtrl.emailAddress = 'test';
        mdmCtrl.getData();
        test.stopTest();
    }
    
    public testMethod static void testNullGetCustomerList(){
        Test.startTest();
        // Set mock callout class 
    	Test.setMock(HttpCalloutMock.class, new MDM_Controller_Test_Mock_Error());
        MDM_Controller mdmCtrl = new MDM_Controller();
        //Contact con = getContact();
        mdmCtrl.polisNo = 'test';
        mdmCtrl.entity = 'test';
        mdmCtrl.relatedPolicy = 'test';
        mdmCtrl.sourceCInd = EIPConstant.MDM_ID;
        mdmCtrl.customerID = '70123456';
        mdmCtrl.customerRK = 'test';
        mdmCtrl.socialSecurityNO = 'test';
        mdmCtrl.firstNM = 'test';
        mdmCtrl.birthDT = 'test';
        mdmCtrl.genderCD = 'test';
        mdmCtrl.accountNO = 'test';
        mdmCtrl.addressTypeCD = 'test';
        mdmCtrl.telephoneNo = 'test';
        mdmCtrl.emailAddress = 'test';
        mdmCtrl.getData();
        test.stopTest();
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
}