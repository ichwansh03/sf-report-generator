@IsTest
public class AccountInfoCallLineController_Test {
    static testMethod void testViewAccountInfo(){
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
        callL.RecordTypeId = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Collection AMFS 1').getRecordTypeId();
        callL.Contact__c = contt.Id;
        insert callL;
        
        Test.setMock(HttpCalloutMock.class, new AccountInfoCallLineController_TestMock());
        test.startTest();
        apexpages.StandardController stdCon = new ApexPages.StandardController(callL);
        AccountInfoCallLineController testAccountInfoController = new AccountInfoCallLineController(stdCon);
        test.stopTest();
    }
	
}