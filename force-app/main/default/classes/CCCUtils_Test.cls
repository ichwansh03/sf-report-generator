@isTest
public class CCCUtils_Test {
    
    static testMethod void testMthod1() {
    	
    	//CCCUtils CCCUtil = new CCCUtils();
    	String JSONStringInput ='{"Body":{"operation":"Customer Profile","transactionId":"1234","status":"1","entity":"AFI","service":"getCustomerInfo","IcAx_AXAAsiaCustomer_Type":{"processedDttm":"2016-10-28T19:14:05","canBeIndividual":{"genderCD":"F","hasAddressesIn":[{"addressLine4":"Indonesia Raya","addressLine3":"Indonesia","addressLine2":"jakarta selatan","addressLine1":"kebayoran baru"}],"birthPlace":"Jakarta","birthDT":"19800327"},"hasPolicyAccount":[{"hasPartyDetailsIn":[{"canBeIndividual":{"hasPartyAccountDetailsIn":{"payorLastNM":"Bagus","branchCD":"Jakarta","rejectCD":"A1","accountEffectiveDT":"20100727","accountTypeCD":"1040002003189","accountStatusCD":"active","bankName":"Mandiri","accountNO":"104000200318","accountExpirationDT":"20150727","rejectDT":"20161026","payorFirstNM":"Bagus"}},"servicingCD":"000373","producingCD":"0003737"}],"policyNO":"100-103-0000038"},{"hasPartyDetailsIn":[{"canBeIndividual":{"hasPartyAccountDetailsIn":{"payorLastNM":"Bagus","branchCD":"Jakarta","rejectCD":"A1","accountEffectiveDT":"20100727","accountTypeCD":"1040002003189","accountStatusCD":"active","bankName":"Mandiri","accountNO":"104000200318","accountExpirationDT":"20150727","rejectDT":"20161026","payorFirstNM":"Bagus"}},"servicingCD":"000373","producingCD":"0003737"}],"policyNO":"100-103-0000038"}],"customerID":"000000000093836"},"appID":"RLS","AXAAsiaPagination_Type":{"rowPerPage":"","numberOfRecords":"","startDateTime":"","pageNumber":"","endDateTime":"","startOfRecords":""}}}';
    	String JSONStringOutput='';
    	
    	Test.startTest();
    	JSONStringOutput = CCCUtils.stripJsonNulls(JSONStringInput);
 		system.debug('JSONStringOutput : ' + JSONStringOutput);
    	
    	Map<String, Object> m = new Map<String, Object>();
    	m = CCCUtils.getMapPackageFromJSON (JSONStringOutput);
    	
    	String status = CCCUtils.getStringDataOnMap(m, 'Body::status');
    	
    	String addressLine4 = CCCUtils.getStringDataOnMap(m, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn[0]::addressLine4');
    	
    	
    	List<Object> lo = CCCUtils.getListDataOnMap(m, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount') ;
    	
    	Date d1 = CCCUtils.strToDate('20160101', '');
    	Date d2 = CCCUtils.strToDate('2016-01-01', 'yyyy-mm-dd');
    	Date d3 = CCCUtils.strToDate('20160101', 'yyyymmdd');
    	Date d4 = CCCUtils.strToDate('2016/01/01', 'yyyy/mm/dd');
    	Date d5 = CCCUtils.strToDate('2016/01/01', '--');
    	
    	Date d6 = CCCUtils.strToDate('', 'yyyymmdd');
    	Date d7 = CCCUtils.strToDate('', 'yyyy/mm/dd');

    	DateTime dt1 = CCCUtils.strToDateTime('20160101', '');
    	DateTime dt2 = CCCUtils.strToDateTime('2016-01-01', 'yyyy-mm-dd');
    	DateTime dt3 = CCCUtils.strToDateTime('20160101', 'yyyymmdd');
    	DateTime dt4 = CCCUtils.strToDateTime('2016-01-01 10:11:12', 'yyyy-mm-dd hh:mm:ss');
    	DateTime dt5 = CCCUtils.strToDateTime('20160101103112', 'yyyymmddhhmmss');
    	
    	DateTime dt6 = CCCUtils.strToDateTime('', 'yyyy-mm-dd');
    	DateTime dt7 = CCCUtils.strToDateTime('', 'yyyymmdd');
    	DateTime dt8 = CCCUtils.strToDateTime('', 'yyyy-mm-dd hh:mm:ss');
    	DateTime dt9 = CCCUtils.strToDateTime('', 'yyyymmddhhmmss');

    	
    	Date bd = CCCUtils.strToDate('19781010', 'yyyymmdd');
    	string age = CCCUtils.birthToAge( bd);
    	string age1 = CCCUtils.birthToAge( null);
    	
    	decimal dc1 = CCCUtils.strToDec('10.10'); 
    	
    	string guid = CCCUtils.getNewGUID() ;
    	string unmr = CCCUtils.getUniqueNumber();
		string sessionID = CCCUtils.getSessionID();    

/*
		CCCUtils.SecurityKeys sk = new CCCUtils.SecurityKeys();
		String username = sk.userName;  
		String password = sk.password; 
		String token = sk.token; 
	*/			
		List<Data_Load_Sequence__c> dls = CCCUtils.getDataLoadSequenceList('Backend', 'AFI', 'BIS', 'Policy Details', 'PolicyInfoPage');
		List<Data_Load_Sequence__c> dls2 = CCCUtils.getDataLoadSequenceList('Backend', 'AFI', 'Clipper', 'Policy Details', 'PolicyInfoPage');
		List<Data_Load_Sequence__c> dls3 = CCCUtils.getDataLoadSequenceList('Backend', 'AFI', 'RLS', 'Policy Details', 'PolicyInfoPage');
		List<Data_Load_Sequence__c> dls4 = CCCUtils.getDataLoadSequenceList('Backend', 'AFI', 'DMTM', 'Policy Details', 'PolicyInfoPage');
		List<Data_Load_Sequence__c> dls5 = CCCUtils.getDataLoadSequenceList('Backend', 'MAGI', 'CARE', 'Policy Details', 'PolicyInfoPage');
		List<Data_Load_Sequence__c> dls6 = CCCUtils.getDataLoadSequenceList('Backend', 'MAGI', 'PSEA', 'Policy Details', 'PolicyInfoPage');
		
		
		Integer rpp = CCCUtils.getRowPerPage('Backend', 'AFI', 'BIS', 'Policy Details', 'PolicyInfoPage');


		//Integer se = GetSecondsElapsed(Time startTime, Time endTime) ;

		//Time et GetElapsedTime(Time startTime, Time endTime)
		//public static Datetime getGMT(Datetime l)
    	Datetime assDT = CCCUtils.addHours(dt5, 7);
    	decimal dnn1 = CCCUtils.getDecimalOrNull ('40.20');
    	decimal dnn2 = CCCUtils.getDecimalOrNull (null);
    	String sn1 = CCCUtils.getStringOrNull ('doddy');
    	String sn2 = CCCUtils.getStringOrNull (null);
    	
    	List<Session_Data__c> sessionDataList = new List<Session_Data__c>(); 
		sessionDataList = CCCUtils.addSessionDataToList (sessionDataList, 'sessionID', 'service', 'operation', 'classType', 'refNo',
			'dataName', 'dataTittle', 'entity', 'pageName', 'sequenceNo', 1, 'pageNo', 'stringRespondData', 'stringRequestData');
    	
    	 //public static  List<Session_Data__c> addSessionDataToList (List<Session_Data__c> sessionDataList, string sessionID, string service, string operation, string classType, string refNo,
    	//string dataName, string dataTittle, string entity, string pageName, string sequenceNo, integer orderNo, string pageNo, string stringRespondData, string stringRequestData){
    
    	CCCUtils.debugDataLoad('start', 'service', 'operation', 'entity', 'policyApp', dt4, dt5  );
    	boolean isNoDataErrorV = CCCUtils.isNoDataError ('123');

	Test.stopTest();
    	
    }
    
    static testMethod void getContactByPolicyNumberTest(){
        
    }
    
    static testMethod void testPrintableFormat(){
        Test.startTest();
        DateTime dtToday = DateTime.now();
        String logBookDate = dtToday.format('yyyy-MM-dd');
        // format dd MMMM yyyy
        CCCUtils.printableDate(logBookDate,'dd MMMM yyyy');
        Test.stopTest();
    }
    
    static testMethod void testGeneralUtils() {
        Test.StartTest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id contactRtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        Contact c = new Contact();
        c.RecordTypeId = contactRtId;
        c.LastName = 'Wati';
        c.FirstName = 'Konto';
        c.Policy_No__c = '123-1234567';
        c.PolicyApp__c = 'RLS';
        c.Insured_Name__c = 'Konto Wati';
        c.Entity__c = 'AMFS';
        c.Email = 'kontowati@gmail.com';
        c.MobilePhone = '085156080110';
        insert c;
        Id retId = CCCUtils.getRecordTypeCaseId('InquiryAMFSCase');
        
        Id retContactId = CCCUtils.getContactIdByPolicyNo('123-1234567', 'AMFS');
        
        String renderStringTest = CCCUtils.renderLineSpaceToHtml('Pada Suatu Hari, Kita ingin deploy tapi code coverage nya kurang.');
        Test.StopTest();
    }
    
}