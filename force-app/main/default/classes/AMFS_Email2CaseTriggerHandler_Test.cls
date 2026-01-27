/**
 * @description       : 
 * @author            : Sugeng Purnomo
 * @group             : 
 * @last modified on  : 08-02-2025
 * @last modified by  : Ahmad Yazid Munif
**/

@IsTest
public with sharing class AMFS_Email2CaseTriggerHandler_Test {
    public static BusinessHours bh;
    public static RecordType recordType;
    public static Group testQ;
    public static Contact con1;
    public static Map<String, BusinessHours> ownerMap;
    public static Id caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('AMFSEmailtoCase').getRecordTypeId();
    
    @TestSetup
    static void setup() {
        // Create test data in separate context to avoid mixed DML
        List<AMFS_E2C_Setting__mdt> emailtoCase = AMFS_E2C_Setting__mdt.getAll().values();
        System.debug('emailtoCase'+emailtoCase);
        String testEmailAddress= '';
        for (AMFS_E2C_Setting__mdt setting : emailtoCase) {
            if (setting.Label == 'CS') {
                testEmailAddress=setting.Email_Case__c;
                break;
            }
        }

        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like '%Agent%AMFS' limit 1]; 
        
        Datetime now = System.now();
        Datetime testRangeStartDate = Datetime.newInstance(
            now.year(),
            now.month(),
            now.day(),
            0, 0, 0
        );
        Datetime testRangeEndDate = Datetime.newInstance(
            now.year(),
            now.month(),
            now.day(),
            23, 59, 59
        );
        Business_Hours_Adjustment__c overlappingAdjustment = new Business_Hours_Adjustment__c(
            Name = 'Overtime Adjustment',
            Start_Date__c = testRangeStartDate,
            End_Date__c = testRangeEndDate
        );
        insert overlappingAdjustment;
        
        List<User> usrList = new List<User>();
        User usr1 = new User(
            Alias = 'agent2', Email='agent02@axa.co.id', 
            EmailEncodingKey='UTF-8', LastName='agent02', 
            LanguageLocaleKey='en_US', LocaleSidKey='en_US', 
            ProfileId = agentProfileAMFS.Id, Entity__c = 'AMFS', 
            TimeZoneSidKey='Asia/Jakarta', UserName='agent02@axa.co.id', isActive = true
        );
        usrList.add(usr1);
        User usr2 = new User(
            Alias = 'agent4', Email='agent04@axa.co.id', 
            EmailEncodingKey='UTF-8', LastName='agent04', 
            LanguageLocaleKey='en_US', LocaleSidKey='en_US', 
            ProfileId = agentProfileAMFS.Id, Entity__c = 'AMFS', 
            TimeZoneSidKey='Asia/Jakarta', UserName='agent04@axa.co.id', isActive = true
        );
        usrList.add(usr2);
        
        insert usrList;

        Email_SMS_Template__c emailTemplate = new Email_SMS_Template__c(
            Name = 'Test Holiday Template',
            Entity__c = 'AMFS',
            Email_Body__c = 'body email',
            Email_Footer__c = 'email footer',
            Email_Header__c = 'email header'
        );
        insert emailTemplate;
        
        Master_Holiday__c holidayRecord = new Master_Holiday__c(
            Name = 'Idul Adha Holiday Test',
            Type__c = 'Holiday',
            Entity__c = 'AMFS',
            Start_Date_Time__c = DateTime.newInstance(2025,05,29,00,00,00),
            End_Date_Time__c = DateTime.newInstance(2025,05,29,24,00,00),
            Description_ID__c = 'Hari Raya Idul Adha 1446 H',
            Description_EN__c = 'Eid al-Adha 1446 H Celebration',
            Email_SMS_Template__c = emailTemplate.Id,
            Email_Header__c = 'Dear Customer,',
            Email_Body__c = 'Please be informed that our services will be adjusted due to the holiday. Details: [DESCRIPTION_ID]',
            Email_Footer__c = 'Thank you for your understanding.'
        );
        insert holidayRecord;

        // List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        // Email_Config__c ec1 = new Email_Config__c();
        // ec1.Email_Address__c = 'customer@axa-mandiri.co.id';
        // ec1.Distribution_Type__c = 'Automatic';
        // ec1.SLA__c = '2';
        // ec1.Unit__c = 'Day';
        // ec1.Start_Working_Hour__c = 8;
        // ec1.End_Working_Hour__c = 16;
        // ec1.Last_Order_No__c = 0;
        // emailConfigList.add(ec1);
        
        // insert emailConfigList;

        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();

        List<contact> contactList = new List<contact>();
        con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AMFS';
        con1.Email = 'test1@abc.org';
        con1.MobilePhone = '11111';
        contactList.add(con1);
        insert contactList;

        recordType = [SELECT Id, Name FROM RecordType where SobjectType ='Case' and Name = 'AMFSEmailtoCase' LIMIT 1];
        testQ = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
        System.debug('AMFStest testQ : '+testQ);
        
        System.debug('AMFStest : '+recordType);
        Contact selectCon1 = [SELECT Id FROM Contact WHERE Policy_No__c = 'P0000011' LIMIT 1];
        Datetime emailDate = System.now().addHours(-2);

        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.Status = 'New';
        case1.Origin = 'Email';
        case1.ContactId = selectCon1.Id;
        case1.OwnerId = testQ.Id;
        case1.RecordTypeId = caseRecordTypeId;
        // case1.RecordTypeId = recordType.Id;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        caselist.add(case1);
        
        insert caselist;
    }

    @isTest
    static void testUpdateCaseClosedAMFS() {
        List<AMFS_E2C_Setting__mdt> emailtoCase = AMFS_E2C_Setting__mdt.getAll().values();
        // System.debug('emailtoCase'+emailtoCase);
        String nameLabel= '';
        String testEmailAddress= '';
        for (AMFS_E2C_Setting__mdt setting : emailtoCase) {
            if (setting.Label == 'CS') {
                testEmailAddress=setting.Email_Case__c;
                nameLabel=setting.Business_Hour_Name__c;
                break;
            }
        }
        BusinessHours bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = :nameLabel LIMIT 1
        ];

        Datetime emailDate = Datetime.newInstance(2025, 7, 28, 10, 0, 0);
        Case caseToUpdate = [SELECT Id,e2cEmailToAddress__c,AMFS_SLA_Target__c FROM Case WHERE Entity_Backup__c = 'AMFS' LIMIT 1];
        List<EmailMessage> emailMsgList = new List<EmailMessage>();
        emailMsgList.add(new EmailMessage(FromAddress = 'test1@abc.org', Incoming = true, 
            ToAddress= 'zzzz@yahoo.co.id; asd2@gmail.com', 
            Headers='salesforce1.com',
            Subject = 'From TestClass', TextBody = '23456 ', 
            ParentId = caseToUpdate.Id, 
            MessageDate = emailDate, 
            AMFS_First_Response_Time_Duration__c = '1 jam',
            AMFS_Handling_Time_Duration__c = '1 jam',
            CreatedDate = emailDate.addHours(1))); 

        Test.startTest();
        AMFS_Email2CaseTriggerHandler.testRelevantEmail = emailMsgList;
        AMFS_Email2CaseTriggerHandler.testInjectBhour = bh;
        caseToUpdate.Status = 'Closed';
        update caseToUpdate;
        Test.stopTest();
    }
    @IsTest
    static void testByPassTrigger() {
        AMFS_Email2CaseTriggerHandler.bypassTrigger = true;
        // Get record type and queue
        RecordType rt = [SELECT Id, Name FROM RecordType 
                        WHERE SobjectType = 'Case' 
                        AND Name = 'AMFSEmailtoCase' 
                        LIMIT 1];
        
       
        
        Test.startTest();
        
        // Create case during regular business hours - trigger will handle assignment
       Group amfsQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
      

       
        Case c = new Case(
            RecordTypeId = rt.Id, 
            Subject = 'Test', 
            Status = 'New', 
            Priority = 'Medium', 
            origin = 'Email',
            OwnerId = amfsQueue.Id
              // Field ini harus di-set agar query menemukan Case
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

       
       
        
        Test.stopTest();
        
        // Verify case was assigned correctly
        Case insertedCase = [SELECT Id, OwnerId, AMFS_Receive_on_Business_Hours__c 
                            FROM Case WHERE Id = :c.Id];
        
        System.assertNotEquals(null, insertedCase.OwnerId, 'Case should be assigned to a queue');
        System.assertEquals(false, insertedCase.AMFS_Receive_on_Business_Hours__c, 
                           'AMFS_Receive_on_Business_Hours__c should be set to false');
    }
    @IsTest
    static void testBeforeInsertRegularHoursNull() {
        AMFS_Email2CaseTriggerHandler.testInjectDate = Date.newInstance(2025, 7, 28);
        AMFS_Email2CaseTriggerHandler.testInjectBhNull = true;

        // Get record type and queue
        RecordType rt = [SELECT Id, Name FROM RecordType 
                        WHERE SobjectType = 'Case' 
                        AND Name = 'AMFSEmailtoCase' 
                        LIMIT 1];
        Test.startTest();
        
        // Create case during regular business hours - trigger will handle assignment
       Group amfsQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
      

       
        Case c = new Case(
            RecordTypeId = rt.Id, 
            Subject = 'Test', 
            Status = 'New', 
            Priority = 'Medium', 
            origin = 'Email',
            OwnerId = amfsQueue.Id
              // Field ini harus di-set agar query menemukan Case
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


        Test.stopTest();
        
    }
    @IsTest
    static void testBeforeInsertRegularHours() {
        
        // Get record type and queue
        RecordType rt = [SELECT Id, Name FROM RecordType 
                        WHERE SobjectType = 'Case' 
                        AND Name = 'AMFSEmailtoCase' 
                        LIMIT 1];
        
       
        
        Test.startTest();
        
        // Create case during regular business hours - trigger will handle assignment
       Group amfsQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
      

       
        Case c = new Case(
            RecordTypeId = rt.Id, 
            Subject = 'Test', 
            Status = 'New', 
            Priority = 'Medium', 
            origin = 'Email',
            OwnerId = amfsQueue.Id
              // Field ini harus di-set agar query menemukan Case
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

       
       
        
        Test.stopTest();
        
        // Verify case was assigned correctly
        Case insertedCase = [SELECT Id, OwnerId, AMFS_Receive_on_Business_Hours__c 
                            FROM Case WHERE Id = :c.Id];
        
        System.assertNotEquals(null, insertedCase.OwnerId, 'Case should be assigned to a queue');
        System.assertEquals(false, insertedCase.AMFS_Receive_on_Business_Hours__c, 
                           'AMFS_Receive_on_Business_Hours__c should be set to false');
    }
    
    @IsTest 
    static void testBeforeInsertWithHoliday() {
        
        // Create holiday for testing
        System.runAs(new User(Id = UserInfo.getUserId())) {
            try {
                Holiday testHoliday = new Holiday(
                    Name = 'Test Holiday',
                    ActivityDate = Date.today(),
                    IsAllDay = true
                );
                insert testHoliday;
            } catch (Exception e) {
                System.debug('Holiday creation skipped: ' + e.getMessage());
            }
        }
        
        RecordType rt = [SELECT Id, Name FROM RecordType 
                        WHERE SobjectType = 'Case' 
                        AND Name = 'AMFSEmailtoCase' 
                        LIMIT 1];
        
        Group ohQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - OH' LIMIT 1];
        
        
        
        Case testCase = new Case(
            Subject = 'Test Holiday Case',
            Description = 'Test Description',
            Origin = 'Email',
            Status = 'New',
            Priority = 'Medium',
            OwnerId = ohQueue.Id, // Set OwnerId to OH queue
            RecordTypeId = rt.Id
        );
        insert testCase;
        
        Case insertedCase = [SELECT Id, OwnerId FROM Case WHERE Id = :testCase.Id];
        System.assertNotEquals(null, insertedCase.OwnerId, 'Case should be assigned during holiday');
    }
    
    @IsTest
    static void testBeforeInsertWithExtendedHours() {
           Group amfsQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - OH' LIMIT 1];
        // Create Business Hours Adjustment for extended hours
        BusinessHours ohBH = [SELECT Id FROM BusinessHours WHERE Name = 'AMFS E2C - OH' LIMIT 1];
        
        Business_Hours_Adjustment__c adjustment = new Business_Hours_Adjustment__c(
            Name = 'Test Extended Hours',
            Business_Hours__c = ohBH.Id,
            Start_Date__c = DateTime.now().addHours(-1),
            End_Date__c = DateTime.now().addHours(2)
        );
        insert adjustment;
        
        RecordType rt = [SELECT Id, Name FROM RecordType 
                        WHERE SobjectType = 'Case' 
                        AND Name = 'AMFSEmailtoCase' 
                        LIMIT 1];
                
        Case testCase = new Case(
            Subject = 'Test Extended Hours Case',
            Description = 'Test Description', 
            Origin = 'Email',
            Status = 'New',
            Priority = 'Medium',
            RecordTypeId = rt.Id,
            OwnerId = amfsQueue.Id // Set OwnerId to OH queue

        );
        insert testCase;
        

        
        Case insertedCase = [SELECT Id, OwnerId FROM Case WHERE Id = :testCase.Id];
        System.assertNotEquals(null, insertedCase.OwnerId, 'Case should be assigned during extended hours');
    }
      
    @IsTest
    static void testBeforeInsertWithNoHours() {
        AMFS_Email2CaseTriggerHandler.isHoursMock = false; // Mocking for test
        Group amfsQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - OH' LIMIT 1];
        // Create Business Hours Adjustment for extended hours
        BusinessHours ohBH = [SELECT Id FROM BusinessHours WHERE Name = 'AMFS E2C - OH' LIMIT 1];
        

        RecordType rt = [SELECT Id, Name FROM RecordType 
                        WHERE SobjectType = 'Case' 
                        AND Name = 'AMFSEmailtoCase' 
                        LIMIT 1];
                
        Case testCase = new Case(
            Subject = 'Test Extended Hours Case',
            Description = 'Test Description', 
            Origin = 'Email',
            Status = 'New',
            Priority = 'Medium',
            RecordTypeId = rt.Id,
            OwnerId = amfsQueue.Id // Set OwnerId to OH queue

        );
        insert testCase;
        
        Case insertedCase = [SELECT Id, OwnerId FROM Case WHERE Id = :testCase.Id];
        System.assertNotEquals(null, insertedCase.OwnerId, 'Case should be assigned during extended hours');
    }
    @IsTest
    static void testBeforeInsertAfterHours() {
        AMFS_Email2CaseTriggerHandler.testInjectDate = Date.newInstance(2025, 7, 28);
        AMFS_Email2CaseTriggerHandler.testInjectCreatedDate = Datetime.newInstance(2025, 7, 28, 20, 0, 0);
        // Create case during regular business hours - trigger will handle assignment
        Group amfsQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
      
        Case c = new Case(
            RecordTypeId = caseRecordTypeId, 
            Subject = 'Test', 
            Status = 'New', 
            Priority = 'Medium', 
            origin = 'Email',
            OwnerId = amfsQueue.Id
              // Field ini harus di-set agar query menemukan Case
        );
        System.debug('####AMFS SchCaseCSAO Case to insert: ' + c);

        insert c;

        Test.startTest();
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
        
        Test.stopTest();
        
        Case insertedCase = [SELECT Id, OwnerId, AMFS_Receive_on_Business_Hours__c 
                            FROM Case WHERE Id = :c.Id];
        
        System.assertNotEquals(null, insertedCase.OwnerId, 'Case should be assigned to a queue');
        System.assertEquals(false, insertedCase.AMFS_Receive_on_Business_Hours__c, 
                           'AMFS_Receive_on_Business_Hours__c should be set to false');
    }
    @IsTest
    static void testBeforeInsertRegularHoursMonday() {
        AMFS_Email2CaseTriggerHandler.testInjectDate = Date.newInstance(2025, 7, 28);
        Test.startTest();
        
        // Create case during regular business hours - trigger will handle assignment
        Group amfsQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
      
        Case c = new Case(
            RecordTypeId = caseRecordTypeId, 
            Subject = 'Test', 
            Status = 'New', 
            Priority = 'Medium', 
            origin = 'Email',
            OwnerId = amfsQueue.Id
              // Field ini harus di-set agar query menemukan Case
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
        
        Test.stopTest();
        
        Case insertedCase = [SELECT Id, OwnerId, AMFS_Receive_on_Business_Hours__c 
                            FROM Case WHERE Id = :c.Id];
        
        System.assertNotEquals(null, insertedCase.OwnerId, 'Case should be assigned to a queue');
        System.assertEquals(false, insertedCase.AMFS_Receive_on_Business_Hours__c, 
                           'AMFS_Receive_on_Business_Hours__c should be set to false');
    }
    @IsTest
    static void testBeforeInsertRegularHoursTuesday() {
        AMFS_Email2CaseTriggerHandler.testInjectDate = Date.newInstance(2025, 7, 29);
        Test.startTest();
        
        // Create case during regular business hours - trigger will handle assignment
        Group amfsQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
      
        Case c = new Case(
            RecordTypeId = caseRecordTypeId, 
            Subject = 'Test', 
            Status = 'New', 
            Priority = 'Medium', 
            origin = 'Email',
            OwnerId = amfsQueue.Id
              // Field ini harus di-set agar query menemukan Case
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
        
        Test.stopTest();
    }
    @IsTest
    static void testBeforeInsertRegularHoursWednesday() {
        AMFS_Email2CaseTriggerHandler.testInjectDate = Date.newInstance(2025, 7, 30);
        Test.startTest();
        
        // Create case during regular business hours - trigger will handle assignment
        Group amfsQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
      
        Case c = new Case(
            RecordTypeId = caseRecordTypeId, 
            Subject = 'Test', 
            Status = 'New', 
            Priority = 'Medium', 
            origin = 'Email',
            OwnerId = amfsQueue.Id
              // Field ini harus di-set agar query menemukan Case
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
        
        Test.stopTest();
        
        Case insertedCase = [SELECT Id, OwnerId, AMFS_Receive_on_Business_Hours__c 
                            FROM Case WHERE Id = :c.Id];
        
        System.assertNotEquals(null, insertedCase.OwnerId, 'Case should be assigned to a queue');
        System.assertEquals(false, insertedCase.AMFS_Receive_on_Business_Hours__c, 
                           'AMFS_Receive_on_Business_Hours__c should be set to false');
    }
    @IsTest
    static void testBeforeInsertRegularHoursThursday() {
        Date testDate = Date.newInstance(2025, 8, 7); 
        AMFS_Email2CaseTriggerHandler.isHoursMock = true;
        AMFS_Email2CaseTriggerHandler.testInjectDate = testDate;
        AMFS_Email2CaseTriggerHandler.testInjectCreatedDate = DateTime.newInstance(testDate, Time.newInstance(19, 0, 0, 0)); // Mock time to after hour
        // Create case during regular business hours - trigger will handle assignment
        Test.startTest();
        Group amfsQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
      
        Case c = new Case(
            RecordTypeId = caseRecordTypeId, 
            Subject = 'Test', 
            Status = 'New', 
            Priority = 'Medium', 
            origin = 'Email',
            OwnerId = amfsQueue.Id
              // Field ini harus di-set agar query menemukan Case
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
        
        Test.stopTest();
        
        Case insertedCase = [SELECT Id, OwnerId, AMFS_Receive_on_Business_Hours__c 
                            FROM Case WHERE Id = :c.Id];
        
        System.assertNotEquals(null, insertedCase.OwnerId, 'Case should be assigned to a queue');
        System.assertEquals(false, insertedCase.AMFS_Receive_on_Business_Hours__c, 
                           'AMFS_Receive_on_Business_Hours__c should be set to false');
    }
    @IsTest
    static void testBeforeInsertRegularHoursFriday() {
        AMFS_Email2CaseTriggerHandler.testInjectDate = Date.newInstance(2025, 8, 1);
        Test.startTest();
        
        // Create case during regular business hours - trigger will handle assignment
        Group amfsQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
      
        Case c = new Case(
            RecordTypeId = caseRecordTypeId, 
            Subject = 'Test', 
            Status = 'New', 
            Priority = 'Medium', 
            origin = 'Email',
            OwnerId = amfsQueue.Id
              // Field ini harus di-set agar query menemukan Case
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
        
        Test.stopTest();
        
        Case insertedCase = [SELECT Id, OwnerId, AMFS_Receive_on_Business_Hours__c 
                            FROM Case WHERE Id = :c.Id];
        
        System.assertNotEquals(null, insertedCase.OwnerId, 'Case should be assigned to a queue');
        System.assertEquals(false, insertedCase.AMFS_Receive_on_Business_Hours__c, 
                           'AMFS_Receive_on_Business_Hours__c should be set to false');
    }
    @IsTest
    static void testBeforeInsertRegularHoursSaturday() {
        AMFS_Email2CaseTriggerHandler.testInjectDate = Date.newInstance(2025, 8, 2);
        Test.startTest();
        
        // Create case during regular business hours - trigger will handle assignment
        Group amfsQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
      
        Case c = new Case(
            RecordTypeId = caseRecordTypeId, 
            Subject = 'Test', 
            Status = 'New', 
            Priority = 'Medium', 
            origin = 'Email',
            OwnerId = amfsQueue.Id
              // Field ini harus di-set agar query menemukan Case
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
        
        Test.stopTest();
        
        Case insertedCase = [SELECT Id, OwnerId, AMFS_Receive_on_Business_Hours__c 
                            FROM Case WHERE Id = :c.Id];
        
        System.assertNotEquals(null, insertedCase.OwnerId, 'Case should be assigned to a queue');
        System.assertEquals(false, insertedCase.AMFS_Receive_on_Business_Hours__c, 
                           'AMFS_Receive_on_Business_Hours__c should be set to false');
    }
    @IsTest
    static void testBeforeInsertRegularHoursSunday() {
        AMFS_Email2CaseTriggerHandler.testInjectDate = Date.newInstance(2025, 8, 3);
        Test.startTest();
        
        // Create case during regular business hours - trigger will handle assignment
        Group amfsQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
      
        Case c = new Case(
            RecordTypeId = caseRecordTypeId, 
            Subject = 'Test', 
            Status = 'New', 
            Priority = 'Medium', 
            origin = 'Email',
            OwnerId = amfsQueue.Id
              // Field ini harus di-set agar query menemukan Case
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
        
        Test.stopTest();
        
        Case insertedCase = [SELECT Id, OwnerId, AMFS_Receive_on_Business_Hours__c 
                            FROM Case WHERE Id = :c.Id];
        
        System.assertNotEquals(null, insertedCase.OwnerId, 'Case should be assigned to a queue');
        System.assertEquals(false, insertedCase.AMFS_Receive_on_Business_Hours__c, 
                           'AMFS_Receive_on_Business_Hours__c should be set to false');
    }
   
}