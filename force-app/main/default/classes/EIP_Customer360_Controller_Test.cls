@isTest
global class EIP_Customer360_Controller_Test {
	private static testMethod void setupTestData() {
        Account a = new Account();
        a.Name = 'Account TestData';
        insert a;
        
        Contact con = new Contact();
        con.AccountId = a.Id;
        con.LastName = 'Contact LastName';
        con.FirstName = 'Contact FirstName';
        con.Entity__c = 'AMFS';
        con.PolicyApp__c = 'RLS';
        con.Policy_No__c = '505-101707';
        insert con;
        
        Case cs = new Case();
        cs.ContactId = con.Id;
        cs.General_Attitude__c = 'Happy';
        insert cs;
        
        Test.startTest();
        
        PageReference pageRef = Page.EIP_InformationPanelCustomer;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', String.valueOf(con.Id));
        ApexPages.StandardController sc = new ApexPages.StandardController(con);
        EIP_Customer360_Controller ext = new EIP_Customer360_Controller(sc);
        EIP_Customer360_Controller.PolicyDetailCls polDetCls = ext.policyDetail;
        
        ext.getListPolicyNo();
        
        Date dt = Date.today();
        Decimal dec = 100;
        
        EIP_Customer360_Controller.PolicyDetailCls pdc = new EIP_Customer360_Controller.PolicyDetailCls();
        pdc.policyNumber = '123456789';
        pdc.SourceCode = 'sourceCode';
        pdc.PlanCode = 'planCode';
        pdc.PlanName = 'planName';
        pdc.PolicyStatus = 'policyStatus';
        pdc.ApplicationDate = dt;
        pdc.IssueDate = dt;
        pdc.EffectiveDate = dt;
        pdc.ExpiredDate = dt;
        pdc.DueDate = dt;
        pdc.TerminationDate = dt;
        pdc.TotalPremium = dec;
        pdc.TotalSumInsured = dec;
        pdc.TopUpPremium = dec;
        pdc.InitialLumpSum = dec;
        pdc.PaymentMethod = 'paymentMethod';
        pdc.PaymentMode = 'paymentMode';
        pdc.StatusDescription = 'statusDescription';
        pdc.PremiumHolidayStartDate = dt;
        pdc.PremiumHolidayEndDate = dt;
        pdc.ePolicy = 'ePolicy';
        pdc.MataUang = 'mataUang';
        pdc.currencyCode = 'currencyCode';
        pdc.RegularTopUp = dec;
        

        EIPJson eipCustomer = new EIPJson();
        
        
        ext.initData();
        
        Test.stopTest();
    }
}