@isTest
public class RemoteDataController_Test {
    static testMethod void testMthod1() {
    	
    	//RemoteDataController rdc = new RemoteDataController();
    	
    	Test.startTest();
    	
    	string strJosn ='';
    	
    	string policyNo='';
    	string entity='';
    	string policyApp='';
    	string operation='';
    	string startDateTime='';
    	string endDateTime='';
    	integer rowPerPage=0;
    	integer startOfRecords=0;
    	integer numberOfRecords=10;
    	integer pageNumber=1;
    	
    	
    	
    	strJosn = RemoteDataController.getRemoteDataBeneficiaryDetail (policyNo, entity,  policyApp, operation,
    		startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords,  pageNumber);
		
		strJosn = RemoteDataController.getRemoteDataPremiumBreakdown (policyNo, entity,  policyApp, operation,
    		startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords,  pageNumber);
    
    	strJosn = RemoteDataController.getRemoteDataPolicyDetailLife (policyNo, entity,  policyApp, operation,
    		startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords,  pageNumber);
    		
    	string certificateNo='1234567';	
    	strJosn = RemoteDataController.getRemoteDataGIPolicyDetail (policyNo, entity,  policyApp, operation, certificateNo,
    		startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords,  pageNumber);
    		
    	strJosn = RemoteDataController.getRemoteDataCustomerInfo (policyNo, entity,  policyApp, operation,
    		startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords,  pageNumber);
    	
    	string classType='';
    	string refNo='';	
    	strJosn = RemoteDataController.getRemoteDataAssessmentNotes (policyNo, entity,  policyApp, operation, classType,  refNo,
    		startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords,  pageNumber);
    		
    	strJosn = RemoteDataController.getRemoteDataAgentInfo (policyNo, entity,  policyApp, operation,
    		startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords,  pageNumber);
    		
    	strJosn = RemoteDataController.getRemoteDataPaymentHistoryLife (policyNo, entity,  policyApp, operation,
    		startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords,  pageNumber);
    		
    	strJosn = RemoteDataController.getRemoteDataFundHistory (policyNo, entity,  policyApp, operation,
    		startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords,  pageNumber);
    		
    	strJosn = RemoteDataController.getRemoteDataFundDetail (policyNo, entity,  policyApp, operation,
    		startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords,  pageNumber);
    	
    	string fundCode='';	
    	strJosn = RemoteDataController.getRemoteDataProductFundDetail (policyNo, entity,  policyApp, operation,
    		startDateTime, endDateTime, fundCode, rowPerPage, startOfRecords, numberOfRecords,  pageNumber);
    		
    	strJosn = RemoteDataController.getRemoteDataClaimDetailLife (policyNo, entity,  policyApp, operation,
    		startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords,  pageNumber);
    		
    	strJosn = RemoteDataController.getRemoteDataClaimDetailGI (policyNo, entity,  policyApp, operation,
    		startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords,  pageNumber);
    		

    		
     		
    	
    	Test.stopTest();
    }
}