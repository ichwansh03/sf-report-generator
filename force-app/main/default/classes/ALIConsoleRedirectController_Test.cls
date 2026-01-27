@isTest
public class ALIConsoleRedirectController_Test {
    private static testMethod void setupTestData() {
        Test.startTest();
        
        Log_CTI_Valdo__c lcv = new Log_CTI_Valdo__c();
        lcv.Answer__c = false;
        lcv.Current_Phone__c = '12345';
        lcv.Duration_Call__c = 123;
        lcv.Duration_Dialing__c = 1234;
        lcv.Duration_Hold__c = 12;
        lcv.End_Calling__c = Datetime.now();
        lcv.Error_API__c = '';
        lcv.From__c = 'test1';
        lcv.ID_Valdo__c = 'VLD00001';
        lcv.Recording_ID__c = 'REC000001';
        lcv.Relation_Id__c = 'REL000001';
        lcv.Response_API__c = 'test2';
        lcv.SIP__c = 'test sip';
        lcv.Start_Calling__c = Datetime.now();
        lcv.Start_Dialling__c = Datetime.now();
        lcv.To__c = 'test3';
        lcv.Transfer_Date__c = Datetime.now();
        lcv.Transfer_From__c = 'a';
        lcv.Transfer_To__c = 'b';
        lcv.ValdoDailyData__c = false;
        insert lcv;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(lcv);
        ALIConsoleRedirectController acrc = new ALIConsoleRedirectController(sc);
        
        Test.stopTest();
    }
}