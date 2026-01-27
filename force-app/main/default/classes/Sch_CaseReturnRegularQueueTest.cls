/**
 * @description       : 
 * @author            : Ahmad Yazid Munif
 * @group             : 
 * @last modified on  : 08-03-2025
 * @last modified by  : Ahmad Yazid Munif
**/
@isTest
private class Sch_CaseReturnRegularQueueTest {

    // Removed test setup to avoid SOQL limit issues with Case triggers/flows
    @TestSetup
    static void setup() {
        AMFS_Email2CaseTriggerHandler.bypassTrigger = true;
        Group amfsQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS - AOH' LIMIT 1];

        RecordType rt = [SELECT Id, Name FROM RecordType WHERE SObjectType = 'Case' AND Name = 'AMFSEmailtoCase' LIMIT 1];
        Case c = new Case(
            RecordTypeId = rt.Id, 
            Subject = 'Test', 
            Status = 'New', 
            Priority = 'Medium', 
            origin = 'Email',
            OwnerId = amfsQueue.Id,
            AMFS_Receive_on_Business_Hours__c = false  // Field ini harus di-set agar query menemukan Case
            );
        System.debug('####AMFS SchCaseCSAO Case to insert: ' + c);
        insert c;
        
        // Insert EmailMessage related to Case
        EmailMessage em = new EmailMessage(
            ParentId = c.Id,
            Status = '3', // Sent
            FromAddress = 'test@example.com',
            ToAddress = 'customer@example.com',
            Subject = 'Test Email',
            TextBody = 'This is a test email message.',
            Incoming = true
        );
        insert em;

      

    }

    @isTest
    static void testExecuteSchedulableRegular() {
        List<Holiday> listHoliday = new List<Holiday>();
     Date testDate = Date.newInstance(2025, 8, 4); // Tuesday
        Test.startTest();
        Sch_CaseReturnRegularQueue job = new Sch_CaseReturnRegularQueue();
        AMFS_Email2CaseTriggerHandler.bypassTrigger = true;
        Sch_CaseReturnRegularQueue.testInjectholidays = listHoliday;
        Sch_CaseReturnRegularQueue.testInjectDateToday = testDate;
        Sch_CaseReturnRegularQueue.testInjectCurrentDateTime = DateTime.newInstance(testDate, Time.newInstance(13, 0, 0, 0)); // Mock time to after hours
        
        job.execute(null);
        
        Test.stopTest();
    }
    @isTest
    static void testExecuteSchedulableWithHolidayAndLembur() {
         Date testDate = Date.newInstance(2025, 8, 5); // Tuesday
        List<Holiday> listHoliday = new List<Holiday>();
         Holiday publicHoliday = new Holiday(
             Name = 'Hari Rabu Libur',
             ActivityDate =testDate,
             IsAllDay = true
         );
         
         listHoliday.add(publicHoliday);
        BusinessHours bh = [
            SELECT Id
            FROM BusinessHours 
            WHERE IsActive = true AND Name = 'AMFS E2C - CS' LIMIT 1
        ];
       
        Datetime extendedStartTime = DateTime.newInstance(testDate, Time.newInstance(18, 0, 0, 0)); // 18:00
        Datetime extendedEndTime = DateTime.newInstance(testDate, Time.newInstance(21, 0, 0, 0));   // 21:00

        Business_Hours_Adjustment__c overlappingAdjustment = new Business_Hours_Adjustment__c(
            Name = 'After Hours Extension',
            Start_Date__c = extendedStartTime,
            End_Date__c = extendedEndTime,
            Business_Hours__c = bh.Id
        );
        insert overlappingAdjustment;
         
        Test.startTest();
        Sch_CaseReturnRegularQueue job = new Sch_CaseReturnRegularQueue();
        AMFS_Email2CaseTriggerHandler.bypassTrigger = true;
        Sch_CaseReturnRegularQueue.testInjectholidays = listHoliday;
        Sch_CaseReturnRegularQueue.testInjectCurrentDateTime = DateTime.newInstance(testDate, Time.newInstance(19, 0, 0, 0)); // Mock time to after hours
        Sch_CaseReturnRegularQueue.testInjectDateToday = testDate;
        job.execute(null);
        Test.stopTest();
    }


    @isTest
    static void testExecuteSchedulableWithLemburAndNoHoliday() {
         Date testDate = Date.newInstance(2025, 8, 6); // Tuesday
        List<Holiday> listHoliday = new List<Holiday>();
    
        BusinessHours bh = [
            SELECT Id
            FROM BusinessHours 
            WHERE IsActive = true AND Name = 'AMFS E2C - CS' LIMIT 1
        ];
       
        Datetime extendedStartTime = DateTime.newInstance(testDate, Time.newInstance(18, 0, 0, 0)); // 18:00
        Datetime extendedEndTime = DateTime.newInstance(testDate, Time.newInstance(21, 0, 0, 0));   // 21:00

        Business_Hours_Adjustment__c overlappingAdjustment = new Business_Hours_Adjustment__c(
            Name = 'After Hours Extension',
            Start_Date__c = extendedStartTime,
            End_Date__c = extendedEndTime,
            Business_Hours__c = bh.Id
        );
        insert overlappingAdjustment;
         
        Test.startTest();
        Sch_CaseReturnRegularQueue job = new Sch_CaseReturnRegularQueue();
        AMFS_Email2CaseTriggerHandler.bypassTrigger = true;
        Sch_CaseReturnRegularQueue.testInjectholidays = listHoliday;
        Sch_CaseReturnRegularQueue.testInjectCurrentDateTime = DateTime.newInstance(testDate, Time.newInstance(19, 0, 0, 0)); // Mock time to after hours
        Sch_CaseReturnRegularQueue.testInjectDateToday = testDate;
        job.execute(null);
        Test.stopTest();
    }   
    @isTest
    static void testExecuteSchedulableOnSunday() {
         Date testDate = Date.newInstance(2025, 8, 3); // Sunday
        List<Holiday> listHoliday = new List<Holiday>();
    
    
        Test.startTest();
        Sch_CaseReturnRegularQueue job = new Sch_CaseReturnRegularQueue();
        AMFS_Email2CaseTriggerHandler.bypassTrigger = true;
        Sch_CaseReturnRegularQueue.testInjectholidays = listHoliday;
        Sch_CaseReturnRegularQueue.testInjectCurrentDateTime = DateTime.newInstance(testDate, Time.newInstance(19, 0, 0, 0)); // Mock time to after hours
        Sch_CaseReturnRegularQueue.testInjectDateToday = testDate;
        job.execute(null);
        Test.stopTest();
    }    
     @isTest
    static void testExecuteSchedulableOnWed() {
         Date testDate = Date.newInstance(2025, 8, 6); // Sunday
        List<Holiday> listHoliday = new List<Holiday>();
    
    
        Test.startTest();
        Sch_CaseReturnRegularQueue job = new Sch_CaseReturnRegularQueue();
        AMFS_Email2CaseTriggerHandler.bypassTrigger = true;
        Sch_CaseReturnRegularQueue.testInjectholidays = listHoliday;
        Sch_CaseReturnRegularQueue.testInjectCurrentDateTime = DateTime.newInstance(testDate, Time.newInstance(19, 0, 0, 0)); // Mock time to after hours
        Sch_CaseReturnRegularQueue.testInjectDateToday = testDate;
        job.execute(null);
        Test.stopTest();
    } 
     @isTest
    static void testExecuteSchedulableOnThu() {
         Date testDate = Date.newInstance(2025, 8, 7); // thursday
        List<Holiday> listHoliday = new List<Holiday>();
    
    
        Test.startTest();
        Sch_CaseReturnRegularQueue job = new Sch_CaseReturnRegularQueue();
        AMFS_Email2CaseTriggerHandler.bypassTrigger = true;
        Sch_CaseReturnRegularQueue.testInjectholidays = listHoliday;
        Sch_CaseReturnRegularQueue.testInjectCurrentDateTime = DateTime.newInstance(testDate, Time.newInstance(19, 0, 0, 0)); // Mock time to after hours
        Sch_CaseReturnRegularQueue.testInjectDateToday = testDate;
        job.execute(null);
        Test.stopTest();
    } 
    @isTest
    static void testExecuteSchedulableOnFriday() {
         Date testDate = Date.newInstance(2025, 8, 8); // friday
        List<Holiday> listHoliday = new List<Holiday>();
    
    
        Test.startTest();
        Sch_CaseReturnRegularQueue job = new Sch_CaseReturnRegularQueue();
        AMFS_Email2CaseTriggerHandler.bypassTrigger = true;
        Sch_CaseReturnRegularQueue.testInjectholidays = listHoliday;
        Sch_CaseReturnRegularQueue.testInjectCurrentDateTime = DateTime.newInstance(testDate, Time.newInstance(19, 0, 0, 0)); // Mock time to after hours
        Sch_CaseReturnRegularQueue.testInjectDateToday = testDate;
        job.execute(null);
        Test.stopTest();
    } 
    @isTest
    static void testExecuteSchedulableOnSat() {
         Date testDate = Date.newInstance(2025, 8, 9); // Saturday
        List<Holiday> listHoliday = new List<Holiday>();
    
    
        Test.startTest();
        Sch_CaseReturnRegularQueue job = new Sch_CaseReturnRegularQueue();
        AMFS_Email2CaseTriggerHandler.bypassTrigger = true;
        Sch_CaseReturnRegularQueue.testInjectholidays = listHoliday;
        Sch_CaseReturnRegularQueue.testInjectCurrentDateTime = DateTime.newInstance(testDate, Time.newInstance(19, 0, 0, 0)); // Mock time to after hours
        Sch_CaseReturnRegularQueue.testInjectDateToday = testDate;
        job.execute(null);
        Test.stopTest();
    } 
    // @isTest
    // static void testExecuteSchedulableWithExtendWorkingDayAfterBusinessHours() {
    //     Test.startTest();       
    //     // Test basic execution without creating any test data
    //     // This avoids SOQL limit issues with triggers/flows

    //     BusinessHours bh = [
    //         SELECT Id
    //         FROM BusinessHours 
    //         WHERE IsActive = true AND Name = 'AMFS E2C - CS' LIMIT 1
    //     ];
        
    //     // Set tanggal ke hari kerja (Tuesday) dan waktu di after hours tapi dalam extended hours
    //     Date testDate = Date.newInstance(2025, 8, 5); // Tuesday
    //     DateTime afterHoursTime = DateTime.newInstance(testDate, Time.newInstance(19, 0, 0, 0)); // 19:00 (7 PM) - after regular hours
        
    //     // Create Business Hours Adjustment untuk extended hours (lembur)
    //     // Misal: jam kerja normal sampai 17:00, extended sampai 21:00
    //     Datetime extendedStartTime = DateTime.newInstance(testDate, Time.newInstance(18, 0, 0, 0)); // 18:00
    //     Datetime extendedEndTime = DateTime.newInstance(testDate, Time.newInstance(21, 0, 0, 0));   // 21:00

    //     Business_Hours_Adjustment__c overlappingAdjustment = new Business_Hours_Adjustment__c(
    //         Name = 'After Hours Extension',
    //         Start_Date__c = extendedStartTime,
    //         End_Date__c = extendedEndTime,
    //         Business_Hours__c = bh.Id
    //     );
    //     insert overlappingAdjustment;
        
    //     // Mock waktu saat ini berada di extended hours (jam 19:00 - after regular hours)
    //     List<Holiday> listHoliday = new List<Holiday>();
        
    //     Sch_CaseReturnRegularQueue job = new Sch_CaseReturnRegularQueue();  
    //     AMFS_Email2CaseTriggerHandler.bypassTrigger = true;
        
    //     // Inject mock data untuk simulasi after business hours tapi dalam extended hours
    //     Sch_CaseReturnRegularQueue.testInjectholidays = listHoliday;
    //     Sch_CaseReturnRegularQueue.testInjectDateToday = testDate;
    //     Sch_CaseReturnRegularQueue.testInjectCurrentDateTime = afterHoursTime; // Mock time to after hours
        
    //     job.execute(null);
    //     Test.stopTest();
        
    //     // Basic assertion that the method executed without throwing exceptions
    //     System.assert(true, 'Schedulable should execute during extended hours after regular business hours');
    // }
    
    // @isTest
    // static void testExecuteSchedulableCompletelyAfterBusinessHours() {
    //     // Test scenario ketika benar-benar di luar jam kerja (tidak ada extended hours)
    //     Test.startTest();
        
    //     // Set tanggal ke hari kerja tapi waktu completely after hours (misal jam 22:00)
    //     Date testDate = Date.newInstance(2025, 8, 5); // Tuesday
    //     List<Holiday> listHoliday = new List<Holiday>();
        
    //     Sch_CaseReturnRegularQueue job = new Sch_CaseReturnRegularQueue();
    //     AMFS_Email2CaseTriggerHandler.bypassTrigger = true;
        
    //     // Inject mock data untuk simulasi completely after business hours
    //     Sch_CaseReturnRegularQueue.testInjectholidays = listHoliday;
    //     Sch_CaseReturnRegularQueue.testInjectDateToday = testDate;
        
    //     job.execute(null);
    //     Test.stopTest();
        
    //     System.assert(true, 'Schedulable should handle completely after business hours scenario');
    // }
    
    // @isTest
    // static void testExecuteSchedulableWeekendDay() {
    //     // Test scenario weekend (Saturday)
    //     Test.startTest();
        
    //     Date testDate = Date.newInstance(2025, 8, 9); // Saturday
    //     List<Holiday> listHoliday = new List<Holiday>();
        
    //     Sch_CaseReturnRegularQueue job = new Sch_CaseReturnRegularQueue();
    //     AMFS_Email2CaseTriggerHandler.bypassTrigger = true;
        
    //     // Inject mock data untuk weekend
    //     Sch_CaseReturnRegularQueue.testInjectholidays = listHoliday;
    //     Sch_CaseReturnRegularQueue.testInjectDateToday = testDate;
        
    //     job.execute(null);
    //     Test.stopTest();
        
    //     System.assert(true, 'Schedulable should handle weekend scenario');
    // }   
}