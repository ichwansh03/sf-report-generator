@isTest(SeeAllData = true) 
public class CCCRESTWebserviceConnectors_Test {
    
    static testMethod void testCustomerInfo() {
		
		string jsonStrRespond;
		string jsonStrRequest;
		Map<String, Object> packageData = new  Map<String, Object>();
		
		string policyNo; string entity; string operation; string appID;
		string startDateTime; string endDateTime;
		Integer rowPerPage; Integer startOfRecords; Integer numberOfRecords;Integer pageNumber;
		
		Test.startTest();

		policyNo='CMS019090000407'; entity='AFI'; operation='Customer Profile'; appID='BIS';
		startDateTime=''; endDateTime='';
		rowPerPage=0; startOfRecords=1; numberOfRecords=0; pageNumber=1;		
		
		CCCRESTWebserviceConnectors.CustomerInfo objWS = new CCCRESTWebserviceConnectors.CustomerInfo();
		jsonStrRespond = objWS.getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
		jsonStrRequest = objWS.requestJSON;
		
		packageData = objWS.getPackageData (policyNo, entity, operation, appID, startDateTime,  endDateTime, 
				 rowPerPage,  startOfRecords,numberOfRecords,  pageNumber) ;
    	Test.stopTest();
    }
    
    static testMethod void testPolicyDetailLife() {
		
		string jsonStrRespond;
		string jsonStrRequest;
		Map<String, Object> packageData = new  Map<String, Object>();
		
		string policyNo; string entity; string operation; string appID;
		string startDateTime; string endDateTime;
		Integer rowPerPage; Integer startOfRecords; Integer numberOfRecords;Integer pageNumber;
		
		Test.startTest();

		policyNo='100-103-0000105'; entity='AFI'; operation='Policy Details'; appID='RLS';
		startDateTime=''; endDateTime='';
		rowPerPage=0; startOfRecords=1; numberOfRecords=0; pageNumber=1;		
		
		CCCRESTWebserviceConnectors.PolicyDetailLife objWS = new CCCRESTWebserviceConnectors.PolicyDetailLife();
		jsonStrRespond = objWS.getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
		jsonStrRequest = objWS.requestJSON;
		
		packageData = objWS.getPackageData (policyNo, entity, appID, operation, startDateTime,  endDateTime, 
				 rowPerPage,  startOfRecords,numberOfRecords,  pageNumber) ;
    	Test.stopTest();
    }
    
    static testMethod void testGIPolicyDetail() {
		
		string jsonStrRespond;
		string jsonStrRequest;
		Map<String, Object> packageData = new  Map<String, Object>();
		
		string policyNo; string entity; string operation; string appID; string certificateNo;
		string startDateTime; string endDateTime;
		Integer rowPerPage; Integer startOfRecords; Integer numberOfRecords;Integer pageNumber;
		
		Test.startTest();

		policyNo='3010704051100001'; entity='MAGI'; operation='Policy Details'; appID='PSEA'; certificateNo='000009';
		startDateTime=''; endDateTime='';
		rowPerPage=0; startOfRecords=1; numberOfRecords=0; pageNumber=1;		
		
		CCCRESTWebserviceConnectors.GIPolicyDetail objWS = new CCCRESTWebserviceConnectors.GIPolicyDetail();
		jsonStrRespond = objWS.getJSON(policyNo, entity, appID, operation, certificateNo, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
		jsonStrRequest = objWS.requestJSON;
		
		packageData = objWS.getPackageData (policyNo, entity, operation, appID, certificateNo, startDateTime,  endDateTime, 
				 rowPerPage,  startOfRecords,numberOfRecords,  pageNumber) ;
    	Test.stopTest();
    	
    }    
    

    static testMethod void testAgentInfo() {
		
		string jsonStrRespond;
		string jsonStrRequest;
		Map<String, Object> packageData = new  Map<String, Object>();
		
		string policyNo; string entity; string operation; string appID;
		string startDateTime; string endDateTime;
		Integer rowPerPage; Integer startOfRecords; Integer numberOfRecords;Integer pageNumber;
		
		Test.startTest();

		policyNo='1001030000038'; entity='AFI'; operation='Agent Info'; appID='RLS';
		startDateTime=''; endDateTime='';
		rowPerPage=0; startOfRecords=1; numberOfRecords=0; pageNumber=1;		
		
		CCCRESTWebserviceConnectors.AgentInfo objWS = new CCCRESTWebserviceConnectors.AgentInfo();
		jsonStrRespond = objWS.getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
		jsonStrRequest = objWS.requestJSON;
		
		packageData = objWS.getPackageData (policyNo, entity, operation, appID, startDateTime,  endDateTime, 
				 rowPerPage,  startOfRecords,numberOfRecords,  pageNumber) ;
    	Test.stopTest();
    }

    static testMethod void testBeneficiaryDetail() {
		
		string jsonStrRespond;
		string jsonStrRequest;
		Map<String, Object> packageData = new  Map<String, Object>();
		
		string policyNo; string entity; string operation; string appID;
		string startDateTime; string endDateTime;
		Integer rowPerPage; Integer startOfRecords; Integer numberOfRecords;Integer pageNumber;
		
		Test.startTest();

		policyNo='100-103-0000022'; entity='AFI'; operation='Beneficiary'; appID='RLS';
		startDateTime=''; endDateTime='';
		rowPerPage=10; startOfRecords=1; numberOfRecords=10; pageNumber=1;		
		
		CCCRESTWebserviceConnectors.BeneficiaryDetail objWS = new CCCRESTWebserviceConnectors.BeneficiaryDetail();
		jsonStrRespond = objWS.getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
		jsonStrRequest = objWS.requestJSON;
		
		packageData = objWS.getPackageData (policyNo, entity, operation, appID, startDateTime,  endDateTime, 
				 rowPerPage,  startOfRecords,numberOfRecords,  pageNumber) ;
    	Test.stopTest();
    }


    static testMethod void testPremiumBreakdown() {
		
		string jsonStrRespond;
		string jsonStrRequest;
		Map<String, Object> packageData = new  Map<String, Object>();
		
		string policyNo; string entity; string operation; string appID;
		string startDateTime; string endDateTime;
		Integer rowPerPage; Integer startOfRecords; Integer numberOfRecords;Integer pageNumber;
		
		Test.startTest();

		policyNo='100-103-0000022'; entity='AFI'; operation='Premium Breakdown'; appID='RLS';
		startDateTime=''; endDateTime='';
		rowPerPage=10; startOfRecords=1; numberOfRecords=10; pageNumber=1;		
		
		CCCRESTWebserviceConnectors.PremiumBreakdown objWS = new CCCRESTWebserviceConnectors.PremiumBreakdown();
		jsonStrRespond = objWS.getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
		jsonStrRequest = objWS.requestJSON;
		
		packageData = objWS.getPackageData (policyNo, entity, operation, appID, startDateTime,  endDateTime, 
				 rowPerPage,  startOfRecords,numberOfRecords,  pageNumber) ;
    	Test.stopTest();
    }
    
    static testMethod void testClaimDetailLife() {
		
		string jsonStrRespond;
		string jsonStrRequest;
		Map<String, Object> packageData = new  Map<String, Object>();
		
		string policyNo; string entity; string operation; string appID;
		string startDateTime; string endDateTime;
		Integer rowPerPage; Integer startOfRecords; Integer numberOfRecords;Integer pageNumber;
		
		Test.startTest();

		policyNo='100-103-0000031'; entity='AFI'; operation='Claim'; appID='RLS';
		startDateTime=''; endDateTime='';
		rowPerPage=10; startOfRecords=1; numberOfRecords=10; pageNumber=1;		
		
		CCCRESTWebserviceConnectors.ClaimDetailLife objWS = new CCCRESTWebserviceConnectors.ClaimDetailLife();
		jsonStrRespond = objWS.getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
		jsonStrRequest = objWS.requestJSON;
		
		packageData = objWS.getPackageData (policyNo, entity, operation, appID, startDateTime,  endDateTime, 
				 rowPerPage,  startOfRecords,numberOfRecords,  pageNumber) ;
    	Test.stopTest();
    } 

    static testMethod void testClaimDetailGI() {
		
		string jsonStrRespond;
		string jsonStrRequest;
		Map<String, Object> packageData = new  Map<String, Object>();
		
		string policyNo; string entity; string operation; string appID;
		string startDateTime; string endDateTime;
		Integer rowPerPage; Integer startOfRecords; Integer numberOfRecords;Integer pageNumber;
		
		Test.startTest();

		policyNo='100-103-0000036'; entity='AFI'; operation='Claim'; appID='RLS';
		startDateTime=''; endDateTime='';
		rowPerPage=10; startOfRecords=1; numberOfRecords=10; pageNumber=1;		
		
		CCCRESTWebserviceConnectors.ClaimDetailGI objWS = new CCCRESTWebserviceConnectors.ClaimDetailGI();
		jsonStrRespond = objWS.getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
		jsonStrRequest = objWS.requestJSON;
		
		packageData = objWS.getPackageData (policyNo, entity, operation, appID, startDateTime,  endDateTime, 
				 rowPerPage,  startOfRecords,numberOfRecords,  pageNumber) ;
    	Test.stopTest();
    }

    static testMethod void testPaymentHistory() {
		
		string jsonStrRespond;
		string jsonStrRequest;
		Map<String, Object> packageData = new  Map<String, Object>();
		
		string policyNo; string entity; string operation; string appID;
		string startDateTime; string endDateTime;
		Integer rowPerPage; Integer startOfRecords; Integer numberOfRecords;Integer pageNumber;
		
		Test.startTest();

		policyNo='100-103-0000036'; entity='AFI'; operation='Payment'; appID='RLS';
		startDateTime=''; endDateTime='';
		rowPerPage=10; startOfRecords=1; numberOfRecords=10; pageNumber=1;		
		
		CCCRESTWebserviceConnectors.PaymentHistory objWS = new CCCRESTWebserviceConnectors.PaymentHistory();
		jsonStrRespond = objWS.getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
		jsonStrRequest = objWS.requestJSON;
		
		packageData = objWS.getPackageData (policyNo, entity, operation, appID, startDateTime,  endDateTime, 
				 rowPerPage,  startOfRecords,numberOfRecords,  pageNumber) ;
    	Test.stopTest();
    }
    
    static testMethod void testFundHistory() {
		
		string jsonStrRespond;
		string jsonStrRequest;
		Map<String, Object> packageData = new  Map<String, Object>();
		
		string policyNo; string entity; string operation; string appID;
		string startDateTime; string endDateTime;
		Integer rowPerPage; Integer startOfRecords; Integer numberOfRecords;Integer pageNumber;
		
		Test.startTest();

		policyNo='100-103-0000036'; entity='AFI'; operation='Fund'; appID='RLS';
		startDateTime='2016-08-16 14:43:00'; endDateTime='2016-08-17 14:45:00';
		rowPerPage=10; startOfRecords=1; numberOfRecords=10; pageNumber=1;		
		
		CCCRESTWebserviceConnectors.FundHistory objWS = new CCCRESTWebserviceConnectors.FundHistory();
		jsonStrRespond = objWS.getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
		jsonStrRequest = objWS.requestJSON;
		
		packageData = objWS.getPackageData (policyNo, entity, operation, appID, startDateTime,  endDateTime, 
				 rowPerPage,  startOfRecords,numberOfRecords,  pageNumber) ;
    	Test.stopTest();
    }

    static testMethod void testFundDetail() {
		
		string jsonStrRespond;
		string jsonStrRequest;
		Map<String, Object> packageData = new  Map<String, Object>();
		
		string policyNo; string entity; string operation; string appID;
		string startDateTime; string endDateTime;
		Integer rowPerPage; Integer startOfRecords; Integer numberOfRecords;Integer pageNumber;
		
		Test.startTest();

		policyNo='100-103-0000036'; entity='AFI'; operation='Fund'; appID='RLS';
		startDateTime=''; endDateTime='';
		rowPerPage=10; startOfRecords=1; numberOfRecords=10; pageNumber=1;		
		
		CCCRESTWebserviceConnectors.FundDetail objWS = new CCCRESTWebserviceConnectors.FundDetail();
		jsonStrRespond = objWS.getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
		jsonStrRequest = objWS.requestJSON;
		
		packageData = objWS.getPackageData (policyNo, entity, operation, appID, startDateTime,  endDateTime, 
				 rowPerPage,  startOfRecords,numberOfRecords,  pageNumber) ;
    	Test.stopTest();
    }
    
    static testMethod void testProductFundDetail() {
		
		string jsonStrRespond;
		string jsonStrRequest;
		Map<String, Object> packageData = new  Map<String, Object>();
		
		string policyNo; string entity; string operation; string appID;
		string startDateTime; string endDateTime; string fundCode;
		Integer rowPerPage; Integer startOfRecords; Integer numberOfRecords;Integer pageNumber;
		
		Test.startTest();

		policyNo='100-103-0000036'; entity='AMFS'; operation='Fund'; appID='RLS';
		startDateTime='2016-08-16 14:43:00'; endDateTime='2016-08-17 14:45:00'; fundCode='999';
		rowPerPage=10; startOfRecords=1; numberOfRecords=10; pageNumber=1;		
		
		CCCRESTWebserviceConnectors.ProductFundDetail objWS = new CCCRESTWebserviceConnectors.ProductFundDetail();
		jsonStrRespond = objWS.getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, fundCode, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
		jsonStrRequest = objWS.requestJSON;
		
		packageData = objWS.getPackageData (policyNo, entity, operation, appID, startDateTime,  endDateTime, fundCode, 
				 rowPerPage,  startOfRecords,numberOfRecords,  pageNumber) ;
    	Test.stopTest();
    }
}