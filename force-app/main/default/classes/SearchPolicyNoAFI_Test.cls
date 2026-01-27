@isTest
public class SearchPolicyNoAFI_Test {
    
    static testmethod void testCase1(){
        Test.setMock(HttpCalloutMock.class, new MockPolicyNoAFI());
        SearchPolicyNoAFI spnAFI = new SearchPolicyNoAFI();
        Test.startTest();
        spnAFI.searchPolicyNo = '570-4758779';
        spnAFI.selectedPolicyNo();
        Test.stopTest();
    }
    
    static testmethod void testRequestCase(){
        Test.startTest();
        SearchPolicyNoAFI spnAFI = new SearchPolicyNoAFI();
        
        spnAFI.searchPolicyNo = '570-4758779';
        
        PageReference myVfPage = Page.SearchPolicyNoAFI_RHSInfo;
        Test.setCurrentPage(myVfPage);
        
        // Put Policy No into the current page Parameters
        ApexPages.currentPage().getParameters().put('policyNo',spnAFI.searchPolicyNo);
        
        spnAFI.initRHSInfo();
        Test.stopTest();
    }
    
    static testmethod void testComplaintCase(){
        Test.startTest();
        SearchPolicyNoAFI spnAFI = new SearchPolicyNoAFI();
        
        spnAFI.searchPolicyNo = '570-4758779';
        
        PageReference myVfPage = Page.SearchPolicyNoAFI_CHSInfo;
        Test.setCurrentPage(myVfPage);
        
        // Put Policy No into the current page Parameters
        ApexPages.currentPage().getParameters().put('policyNo',spnAFI.searchPolicyNo);
        
        spnAFI.initCHSInfo();
        Test.stopTest();
    }
    
    static testmethod void testInquiryCase(){
        Test.startTest();
        SearchPolicyNoAFI spnAFI = new SearchPolicyNoAFI();
        
        spnAFI.searchPolicyNo = '570-4758779';
        
        PageReference myVfPage = Page.SearchPolicyNoAFI_InquiryInfo;
        Test.setCurrentPage(myVfPage);
        
        // Put Policy No into the current page Parameters
        ApexPages.currentPage().getParameters().put('policyNo',spnAFI.searchPolicyNo);
        
        spnAFI.initInquiryInfo();
        Test.stopTest();
    }
}