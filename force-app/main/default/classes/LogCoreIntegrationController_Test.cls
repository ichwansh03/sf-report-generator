@isTest
public class LogCoreIntegrationController_Test {

    @testSetup
    static void init(){
        
        Contact con = new Contact();
        con.Lastname = 'someone';
        con.Policy_No__c = '939939';
        con.Entity__c = 'AMFS';
        insert con;
        
        List<AppLog__c> logs = new List<AppLog__c>();
        for (Integer i = 0; i<100; i++){
            logs.add(new AppLog__c(
                Id__c = con.Id, 
                Policy_No__c = con.Policy_No__c, 
                Entity__c = 'AMFS', 
                Report_Name__c = 'DMTM Report',
                Status__c = 'Success',
                StartLongTime__c = system.now().getTime(),
                EndLongTime__c = system.now().getTime()
            ));
        }
        insert logs;
        
        AppLog__c logError = new AppLog__c();
        logError.Id__c = con.Id;
        logError.Policy_No__c = con.Policy_No__c; 
        logError.Entity__c = 'AMFS';
        logError.Report_Name__c = 'AMFS Collection Robot DMTM';
        logError.Status__c = 'Error';
        logError.StartLongTime__c = system.now().getTime();
        logError.EndLongTime__c = system.now().getTime();
        insert logError;
    }
    
    @isTest
    static void controllerTest(){
        LogCoreIntegrationController ctrl = new LogCoreIntegrationController();
        AppLog__c log = [SELECT Id, Name, Policy_No__c, Error_Message__c, Status__c, Report_Name__c, end_date__c, start_date__c, LastModifiedDate FROM AppLog__c WHERE Status__c = 'Error' LIMIT 1];
        
        Test.startTest();
        ctrl.logId = log.Id;
        ctrl.statusOpt = log.Status__c;
        ctrl.reportName = log.Report_Name__c;
        ctrl.startDate = log.LastModifiedDate;
        ctrl.endDate = log.LastModifiedDate.addDays(1);
        ctrl.policy = log.Policy_No__c;
        
        ctrl.entries();
        ctrl.getLogs();
        ctrl.exportLogs();
        ctrl.searchPolicy();
        ctrl.showReport();
        ctrl.updateToInvalid();
        ctrl.filterQueryLog();
        Test.stopTest();
    }
    
    @isTest
    static void paginationTest() {
        Test.startTest();
        LogCoreIntegrationController controller = new LogCoreIntegrationController();
        controller.first();
        controller.last();
        controller.next();
        controller.previous();
        System.assertEquals(25, controller.logList.getPageSize());

        System.assertEquals(1, controller.pageNumber);
        System.assertEquals(0, controller.resultSize);
        
        controller.selectSize = '50';
        controller.logList.setPageSize(50);
        System.assertEquals(Integer.valueof(controller.selectSize), controller.logList.getPageSize());
        
        controller.selectSize = '100';
        controller.logList.setPageSize(100);
        System.assertEquals(100, controller.logList.getPageSize());
        Test.stopTest();
    }
}