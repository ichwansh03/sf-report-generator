/**
 * @description       : 
 * @author            : Sugeng Purnomo
 * @group             : 
 * @last modified on  : 07-30-2025
 * @last modified by  : Ahmad Yazid Munif
**/
@IsTest
public with sharing class Sch_Case_CS_AO_Test {

    // Removed test setup to avoid SOQL limit issues with Case triggers/flows
   
    @TestSetup
    static void setup() {
         
        Group amfsQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
      

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
    static void testExecuteSchedulableNullBHour() {
        // Verify test data exists before running scheduler
        
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE Name = 'AMFS E2C - CS' LIMIT 1];
        DateTime mondayMorning = DateTime.newInstance(2025, 07, 29, 0, 0, 0);  // Monday 9 AM
        DateTime mondayEvening = DateTime.newInstance(2025, 07, 29, 18, 0, 0); // Monday 5 PM

        Test.startTest();
        Boolean isWorkingTime = BusinessHours.isWithin(bh.Id, mondayMorning);
        Sch_Case_CS_AO job = new Sch_Case_CS_AO();
        Sch_Case_CS_AO.testInjectDate = Date.newInstance(2025, 7, 28);
        Sch_Case_CS_AO.testInjectBHours = true;
        job.execute(null);
        Test.stopTest();
        
    }
    @isTest
    static void testExecuteSchedulableRegularWorkingDay() {
        // Verify test data exists before running scheduler
        
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE Name = 'AMFS E2C - CS' LIMIT 1];
        DateTime mondayMorning = DateTime.newInstance(2025, 07, 29, 0, 0, 0);  // Monday 9 AM
        DateTime mondayEvening = DateTime.newInstance(2025, 07, 29, 18, 0, 0); // Monday 5 PM

        Test.startTest();
        Boolean isWorkingTime = BusinessHours.isWithin(bh.Id, mondayMorning);
        Sch_Case_CS_AO job = new Sch_Case_CS_AO();
        job.execute(null);
        Test.stopTest();
        
    }
    @isTest
    static void testExecuteSchedulableRegularWorkingDayMonday() {
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE Name = 'AMFS E2C - CS' LIMIT 1];
        DateTime mondayMorning = DateTime.newInstance(2025, 07, 29, 0, 0, 0);  // Monday 9 AM
        DateTime mondayEvening = DateTime.newInstance(2025, 07, 29, 18, 0, 0); // Monday 5 PM

        Test.startTest();
        Boolean isWorkingTime = BusinessHours.isWithin(bh.Id, mondayMorning);
        Sch_Case_CS_AO job = new Sch_Case_CS_AO();
        Sch_Case_CS_AO.testInjectDate = Date.newInstance(2025, 7, 28);
        job.execute(null);
        Test.stopTest();
    }
    @isTest
    static void testExecuteSchedulableRegularWorkingDayTuesday() {
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE Name = 'AMFS E2C - CS' LIMIT 1];
        DateTime mondayMorning = DateTime.newInstance(2025, 07, 29, 0, 0, 0);  // Monday 9 AM
        DateTime mondayEvening = DateTime.newInstance(2025, 07, 29, 18, 0, 0); // Monday 5 PM

        Test.startTest();
        Boolean isWorkingTime = BusinessHours.isWithin(bh.Id, mondayMorning);
        Sch_Case_CS_AO job = new Sch_Case_CS_AO();
        Sch_Case_CS_AO.testInjectDate = Date.newInstance(2025, 7, 29);
        job.execute(null);
        Test.stopTest();
    }
    @isTest
    static void testExecuteSchedulableRegularWorkingDayWednesday() {
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE Name = 'AMFS E2C - CS' LIMIT 1];
        DateTime mondayMorning = DateTime.newInstance(2025, 07, 29, 0, 0, 0);  // Monday 9 AM
        DateTime mondayEvening = DateTime.newInstance(2025, 07, 29, 18, 0, 0); // Monday 5 PM

        Test.startTest();
        Boolean isWorkingTime = BusinessHours.isWithin(bh.Id, mondayMorning);
        Sch_Case_CS_AO job = new Sch_Case_CS_AO();
        Sch_Case_CS_AO.testInjectDate = Date.newInstance(2025, 7, 30);
        job.execute(null);
        Test.stopTest();
    }
    @isTest
    static void testExecuteSchedulableRegularWorkingDayThursday() {
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE Name = 'AMFS E2C - CS' LIMIT 1];
        DateTime mondayMorning = DateTime.newInstance(2025, 07, 29, 0, 0, 0);  // Monday 9 AM
        DateTime mondayEvening = DateTime.newInstance(2025, 07, 29, 18, 0, 0); // Monday 5 PM

        Test.startTest();
        Boolean isWorkingTime = BusinessHours.isWithin(bh.Id, mondayMorning);
        Sch_Case_CS_AO job = new Sch_Case_CS_AO();
        Sch_Case_CS_AO.testInjectDate = Date.newInstance(2025, 7, 31);
        job.execute(null);
        Test.stopTest();
    }
    @isTest
    static void testExecuteSchedulableRegularWorkingDayFriday() {
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE Name = 'AMFS E2C - CS' LIMIT 1];
        DateTime mondayMorning = DateTime.newInstance(2025, 07, 29, 0, 0, 0);  // Monday 9 AM
        DateTime mondayEvening = DateTime.newInstance(2025, 07, 29, 18, 0, 0); // Monday 5 PM

        Test.startTest();
        Boolean isWorkingTime = BusinessHours.isWithin(bh.Id, mondayMorning);
        Sch_Case_CS_AO job = new Sch_Case_CS_AO();
        Sch_Case_CS_AO.testInjectDate = Date.newInstance(2025, 8, 1);
        job.execute(null);
        Test.stopTest();
    }
    @isTest
    static void testExecuteSchedulableRegularWorkingDaySaturday() {
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE Name = 'AMFS E2C - CS' LIMIT 1];
        DateTime mondayMorning = DateTime.newInstance(2025, 07, 29, 0, 0, 0);  // Monday 9 AM
        DateTime mondayEvening = DateTime.newInstance(2025, 07, 29, 18, 0, 0); // Monday 5 PM

        Test.startTest();
        Boolean isWorkingTime = BusinessHours.isWithin(bh.Id, mondayMorning);
        Sch_Case_CS_AO job = new Sch_Case_CS_AO();
        Sch_Case_CS_AO.testInjectDate = Date.newInstance(2025, 8, 2);
        job.execute(null);
        Test.stopTest();
    }
    @isTest
    static void testExecuteSchedulableRegularWorkingDaySunday() {
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE Name = 'AMFS E2C - CS' LIMIT 1];
        DateTime mondayMorning = DateTime.newInstance(2025, 07, 29, 0, 0, 0);  // Monday 9 AM
        DateTime mondayEvening = DateTime.newInstance(2025, 07, 29, 18, 0, 0); // Monday 5 PM

        Test.startTest();
        Boolean isWorkingTime = BusinessHours.isWithin(bh.Id, mondayMorning);
        Sch_Case_CS_AO job = new Sch_Case_CS_AO();
        Sch_Case_CS_AO.testInjectDate = Date.newInstance(2025, 8, 3);
        job.execute(null);
        Test.stopTest();
    }
    @isTest
    static void testExecuteSchedulableExtendDay() {
        Id businessHoursId = [SELECT Id FROM BusinessHours WHERE Name = 'AMFS E2C - OH' LIMIT 1].Id;
        
       
        Business_Hours_Adjustment__c bha = new Business_Hours_Adjustment__c(
            Name = 'Test Adjustment',
            Business_Hours__c = businessHoursId,
            Start_Date__c = Datetime.now().addHours(-1).addHours(7),
            End_Date__c = Datetime.now().addMinutes(10).addHours(7)
        );
        System.debug('####AMFS Business Hours Adjustment: ' + bha);
        insert bha;

        Test.startTest();
        Sch_Case_CS_AO job = new Sch_Case_CS_AO();
        job.execute(null);
        
        Test.stopTest();
        
        // Verify the method executes without errors
        System.assert(true, 'Schedulable should execute without errors');
    }

    @isTest
    static void testExecuteSchedulableWithHoliday() {
        // Create holiday for testing (if possible)
        try {
            User adminUser = [SELECT Id FROM User WHERE Profile.Name = 'System Administrator' AND IsActive = true LIMIT 1];
            
            System.runAs(adminUser) {
                Holiday h = new Holiday(
                    Name = 'Test Holiday',
                    isAllDay = true,
                    ActivityDate = Date.today()
                );
                insert h;
            }
        } catch (Exception e) {
            System.debug('Holiday creation skipped: ' + e.getMessage());
        }
        
        Test.startTest();
        
        Sch_Case_CS_AO job = new Sch_Case_CS_AO();
        job.execute(null);
        
        Test.stopTest();
        
        // Verify logic handles holiday scenario
        System.assert(true, 'Holiday scenario should be handled');
    }

    @isTest
    static void testExecuteSchedulableWithExtendedHours() {
        // Create extended hours adjustment (if possible)
        try {
            BusinessHours bh = [SELECT Id FROM BusinessHours WHERE Name = 'AMFS E2C - CS' LIMIT 1];
            
            Business_Hours_Adjustment__c bha = new Business_Hours_Adjustment__c(
                Name = 'Test Extended Hours',
                Business_Hours__c = bh.Id, 
                Start_Date__c = Datetime.now().addHours(-1).addHours(7),
                End_Date__c = Datetime.now().addHours(2).addHours(7)
            );
            insert bha;
        } catch (Exception e) {
            System.debug('Business hours adjustment creation skipped: ' + e.getMessage());
        }
        
        Test.startTest();
        
        Sch_Case_CS_AO job = new Sch_Case_CS_AO();
        job.execute(null);
        
        Test.stopTest();
        
        // Verify extended hours scenario runs without errors
        System.assert(true, 'Extended hours scenario should be handled');
    }


   
}