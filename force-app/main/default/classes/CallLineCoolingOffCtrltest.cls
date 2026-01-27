@isTest
public class CallLineCoolingOffCtrltest {
    @isTest static void test1(){
        Id recTypeWC = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
            
        Contact contt = new Contact();
        contt.Policy_No__c = '515-3932503';
        contt.entity__c = 'AMFS'; 
        contt.policyApp__c = 'RLS';
        contt.phone = '45678'; 
        contt.Agent_Code__c = '675849';
        //contt.Welcomecall_Ape__c = 10000000;
        contt.WelcomeCall_Payment_Type__c ='M';
        contt.Premium__c=10000000;
        contt.welcomecall_issued_date__c = date.today();
        contt.welcomecall_product_code_plan__c = 'HONMN';
        contt.email = 'asdasd@gmail.com';
        contt.LastName = 'Telat';
        
        insert contt;
        
        Call_Line__c callL = new Call_Line__c();
        callL.Policy_No__c = contt.Policy_No__c;
        callL.WelcomeCall_Schedule_Date__c = datetime.now();
        callL.WelcomeCall_Call_Line_Status__c = 'Open';
        callL.RecordTypeId = recTypeWC;
        callL.Contact__c = contt.Id;
        
        insert callL;
            
        Test.setMock(HttpCalloutMock.class, new DetailNasabahCtrl_TestMock());
        test.startTest();
        apexpages.StandardController stdCon = new ApexPages.StandardController(callL);
        CallLineCoolingOffCtrl testDNC = new CallLineCoolingOffCtrl(stdCon);
         
        
        testDNC.populateDetailNasabah();
        test.stopTest();
    
    }
    
    
    @isTest static void test2(){
        test.startTest();
        // Test the addWorkingDays method
        Date startDate = Date.today();
        Integer numDays = 5;

        Date resultDate = CallLineCoolingOffCtrl.addWorkingDays(startDate, numDays);
        test.stopTest();

    }
    
    @isTest static void test3(){
        test.startTest();
        // Test the isWeekend method
        Date weekendDate = Date.newInstance(2023, 10, 28); // A Saturday
        Date weekdayDate = Date.newInstance(2023, 10, 27);  // A Friday

        Boolean isWeekendResult = CallLineCoolingOffCtrl.isWeekend(weekendDate);
        Boolean isWeekdayResult = CallLineCoolingOffCtrl.isWeekend(weekdayDate); 
        test.stopTest();

    }
     
    @isTest static void test4(){
        test.startTest();
        // Test the isHoliday method
        Date holidayDate = Date.newInstance(2023, 12, 25); // Christmas (assumed holiday)
        Date nonHolidayDate = Date.newInstance(2023, 11, 1); // Non-holiday

        Boolean isHolidayResult = CallLineCoolingOffCtrl.isHoliday(holidayDate);
        Boolean isNonHolidayResult = CallLineCoolingOffCtrl.isHoliday(nonHolidayDate); 
        test.stopTest();
    }

    @isTest static void test5(){
        test.startTest();
        // Test the isHoliday method
        String dateString = '01 Dec 2023';
        Date expectedDate = Date.newInstance(2023, 12, 1);

        Date resultDate = CallLineCoolingOffCtrl.convertStringToDate(dateString);
 
        test.stopTest();

    }

    @isTest static void test6(){
        test.startTest();// Test the convertDateFormat method
        String inputDate = '2023-12-01';

        String resultDate = CallLineCoolingOffCtrl.convertDateFormat(inputDate);
 
        test.stopTest();

    }
    
    @isTest
    static void testJSON_MAP_CONVERT_EPOLICY() {
        test.startTest();
        // Example JSON string for testing
        String jsonString = '{ "Body": { "service": "TestService", "appID": "TestAppID", "IcAx_AXAAsiaCustomer_Type": null, "operation": "TestOperation", "transactionId": "TestTransactionId", "entity": "TestEntity", "status": "TestStatus" } }';

        // Call the parse method
        JSON_MAP_CONVERT_EPOLICY result = JSON_MAP_CONVERT_EPOLICY.parse(jsonString);

        // Verify that the result is not null
        System.assertNotEquals(null, result);

        // Verify that the properties of the result are as expected
        System.assertEquals('TestService', result.Body.service);
        System.assertEquals('TestAppID', result.Body.appID); 
        
        test.stopTest();
    }
    
}