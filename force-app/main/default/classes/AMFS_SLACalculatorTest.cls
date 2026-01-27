/**
 * @description       : Test Class for AMFS_SLACalculator
 * @author            : Ahmad Yazid Munif
 * @group             : 
 * @last modified on  : 07-31-2025
 * @last modified by  : Ahmad Yazid Munif
**/
@isTest
private class AMFS_SLACalculatorTest {
    public static String testEmailAddress = '';
    public static String[] emailAMFSCustomerLong = system.label.EMAIL_AMFS_Customer_Long.split('\\|\\|');
    public static String[] emailAMFSNasabahLong = system.label.EMAIL_AMFS_Nasabah_Long.split('\\|\\|');
    public static String[] emailAMFSPriorityLong = system.label.EMAIL_AMFS_Priority_Long.split('\\|\\|');
    
    public static Id AmfsInquiry = Schema.SObjectType.Case.getRecordTypeInfosByName().get('InquiryAMFSCase').getRecordTypeId();
    public static Id AmfsComplaint = Schema.SObjectType.Case.getRecordTypeInfosByName().get('AMFSComplaintCase').getRecordTypeId();
    public static Id caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('AMFSEmailtoCase').getRecordTypeId();
    
    public static AMFS_SLACalculator slaCalculatorInitial;
    
    @TestSetup
    static void makeData(){
        List<AMFS_E2C_Setting__mdt> emailtoCase = AMFS_E2C_Setting__mdt.getAll().values();
        System.debug('emailtoCase'+emailtoCase);
        String nameLabel= '';
        for (AMFS_E2C_Setting__mdt setting : emailtoCase) {
            if (setting.Label == 'CS') {
                testEmailAddress=setting.Email_Case__c;
                break;
            }
        }
        
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

        slaCalculatorInitial = new AMFS_SLACalculator();
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like '%Agent%AMFS' limit 1]; 
        
        RecordType recordType = [SELECT Id, Name FROM RecordType where SobjectType ='Case' and Name = 'AMFSEmailtoCase' LIMIT 1];
        System.debug('AMFStest : '+recordType);
        
        List<User> usrList = new List<User>();
        User usr1 = new User(
            Alias = 'agent2', Email='agent02@axa.co.id', 
            EmailEncodingKey='UTF-8', LastName='agent02', 
            LanguageLocaleKey='en_US', LocaleSidKey='en_US', 
            ProfileId = agentProfileAMFS.Id, Entity__c = 'AMFS', 
            TimeZoneSidKey='Asia/Jakarta', UserName='agent02@axa.co.id', isActive = true
        );
        User usr2 = new User(
            Alias = 'agent4', Email='agent04@axa.co.id', 
            EmailEncodingKey='UTF-8', LastName='agent04', 
            LanguageLocaleKey='en_US', LocaleSidKey='en_US', 
            ProfileId = agentProfileAMFS.Id, Entity__c = 'AMFS', 
            TimeZoneSidKey='Asia/Jakarta', UserName='agent04@axa.co.id', isActive = true
        );
        usrList.add(usr1);
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

        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-mandiri.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AMFS';
        con1.Email = 'test1@abc.org';
        con1.MobilePhone = '11111';
        contactList.add(con1);
        insert contactList;
    }
    @isTest
    static void testClosedCaseWithHoliday() {
        BusinessHours bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = 'AMFS E2C - PBC' LIMIT 1
        ];
        Contact con1 = [SELECT Id FROM Contact WHERE LastName = 'cust01' LIMIT 1];
        Group testQ = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - PBC' LIMIT 1];

        Datetime emailDate = System.now().addHours(-2);
        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.Status = 'Closed';
        case1.Origin = 'Email';
        case1.ContactId = con1.Id;
        case1.OwnerId = testQ.Id;
        case1.RecordTypeId = caseRecordTypeId;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        case1.AMFS_Receive_on_Business_Hours__c = true;
        caselist.add(case1);
        insert caselist;
        Test.setCreatedDate(case1.Id, Datetime.newInstance(2025, 7, 1, 9, 0, 0));

        Test.startTest();

        Case getOneCase = [SELECT id, CreatedDate, AMFS_Receive_on_Business_Hours__c FROM Case LIMIT 1];
        System.debug('AMFStest with holiday : '+getOneCase);
        AMFS_SLACalculator.testInjectAOH = true;
        AMFS_SLACalculator.calculateSLAClosedCase(getOneCase, bh);

        Test.stopTest();

        Case updatedCase = [SELECT Id, Status FROM Case WHERE Id = :getOneCase.Id];
        
        System.assertEquals('Closed', updatedCase.Status, 'Status should be Closed Updated Case');
    }
    @isTest
    static void testClosedCaseInWeekday() {
        BusinessHours bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = 'AMFS E2C - CS' LIMIT 1
        ];
        Contact con1 = [SELECT Id FROM Contact WHERE LastName = 'cust01' LIMIT 1];
        Group testQ = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];

        Datetime emailDate = System.now().addHours(-2);
        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.Status = 'Closed';
        case1.Origin = 'Email';
        case1.ContactId = con1.Id;
        case1.OwnerId = testQ.Id;
        case1.RecordTypeId = caseRecordTypeId;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        case1.AMFS_Receive_on_Business_Hours__c = true;
        caselist.add(case1);
        insert caselist;
        Test.setCreatedDate(case1.Id, Datetime.newInstance(2025, 6, 27, 9, 0, 0));

        Test.startTest();

        Case getOneCase = [SELECT id, CreatedDate, AMFS_Receive_on_Business_Hours__c FROM Case LIMIT 1];
        System.debug('AMFStest 1 : '+getOneCase);
        AMFS_SLACalculator.testInjectAOH = false;
        AMFS_SLACalculator.calculateSLAClosedCase(getOneCase, bh);

        Test.stopTest();

        Case updatedCase = [SELECT Id, Status FROM Case WHERE Id = :getOneCase.Id];
        
        System.assertEquals('Closed', updatedCase.Status, 'Status should be Closed Updated Case');
    }
    @isTest
    static void testClosedCaseInWeekday2() {
        BusinessHours bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = 'AMFS E2C - CS' LIMIT 1
        ];
        Contact con1 = [SELECT Id FROM Contact WHERE LastName = 'cust01' LIMIT 1];
        Group testQ = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];

        Datetime emailDate = System.now().addHours(-2);
        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.Status = 'Closed';
        case1.Origin = 'Email';
        case1.ContactId = con1.Id;
        case1.OwnerId = testQ.Id;
        case1.RecordTypeId = caseRecordTypeId;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        case1.AMFS_Receive_on_Business_Hours__c = true;
        caselist.add(case1);
        insert caselist;
        Test.setCreatedDate(case1.Id, Datetime.newInstance(2025, 6, 27, 9, 0, 0));

        Test.startTest();

        Case getOneCase = [SELECT id, CreatedDate, AMFS_Receive_on_Business_Hours__c FROM Case LIMIT 1];
        System.debug('AMFStest 1 : '+getOneCase);
        AMFS_SLACalculator.testInjectAOH = false;
        AMFS_SLACalculator.calculateSLAClosedCase(getOneCase, bh);

        Test.stopTest();

        Case updatedCase = [SELECT Id, Status FROM Case WHERE Id = :getOneCase.Id];
        
        System.assertEquals('Closed', updatedCase.Status, 'Status should be Closed Updated Case');
    }
    @isTest
    static void testClosedCaseInWeekend() {
        BusinessHours bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = 'AMFS E2C - CS' LIMIT 1
        ];

        Contact con1 = [SELECT Id FROM Contact WHERE LastName = 'cust01' LIMIT 1];
        Group testQ = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];

        Datetime emailDate = System.now().addHours(-2);
        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.Status = 'Closed';
        case1.Origin = 'Email';
        case1.ContactId = con1.Id;
        case1.OwnerId = testQ.Id;
        case1.RecordTypeId = caseRecordTypeId;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        case1.AMFS_Receive_on_Business_Hours__c = false;
        caselist.add(case1);
        
        insert caselist;
        Test.setCreatedDate(case1.Id, Datetime.newInstance(2025, 6, 27, 20, 0, 0));
        
        Test.startTest();
        
        Case getOneCase = [SELECT id, CreatedDate, AMFS_Receive_on_Business_Hours__c FROM Case LIMIT 1];
        System.debug('AMFStest 2 : '+getOneCase);
        AMFS_SLACalculator.testInjectAOH = true;
        AMFS_SLACalculator.testInjectResponse = Datetime.newInstance(2025, 6, 27, 21, 0, 0);
        AMFS_SLACalculator.calculateSLAClosedCase(getOneCase, bh);

        Test.stopTest();

        Case updatedCase = [SELECT Id, Status FROM Case WHERE Id = :getOneCase.Id];
        
        System.assertEquals('Closed', updatedCase.Status, 'Status should be Closed Updated Case');
    }
    @isTest
    static void testClosedCaseInToday() {
        BusinessHours bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = 'AMFS E2C - CS' LIMIT 1
        ];

        Contact con1 = [SELECT Id FROM Contact WHERE LastName = 'cust01' LIMIT 1];
        Group testQ = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];

        Datetime emailDate = System.now().addHours(-2);
        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.Status = 'Closed';
        case1.Origin = 'Email';
        case1.ContactId = con1.Id;
        case1.OwnerId = testQ.Id;
        case1.RecordTypeId = caseRecordTypeId;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        case1.AMFS_Receive_on_Business_Hours__c = false;
        caselist.add(case1);
        
        insert caselist;
        Test.setCreatedDate(case1.Id, Datetime.newInstance(2025, 6, 28, 9, 0, 0));
        
        Test.startTest();
        
        Case getOneCase = [SELECT id, CreatedDate, AMFS_Receive_on_Business_Hours__c FROM Case LIMIT 1];
        System.debug('AMFStest 2 : '+getOneCase);
        AMFS_SLACalculator.testInjectAOH = true;
        AMFS_SLACalculator.testInjectResponse = Datetime.newInstance(2025, 6, 28, 12, 0, 0);
        AMFS_SLACalculator.calculateSLAClosedCase(getOneCase, bh);

        Test.stopTest();

        Case updatedCase = [SELECT Id, Status FROM Case WHERE Id = :getOneCase.Id];
        
        System.assertEquals('Closed', updatedCase.Status, 'Status should be Closed Updated Case');
    }
    @isTest
    static void testClosedCaseInWeekend2() {
        BusinessHours bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = 'AMFS E2C - CS' LIMIT 1
        ];

        Contact con1 = [SELECT Id FROM Contact WHERE LastName = 'cust01' LIMIT 1];
        Group testQ = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];

        Datetime emailDate = System.now().addHours(-2);
        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.Status = 'Closed';
        case1.Origin = 'Email';
        case1.ContactId = con1.Id;
        case1.OwnerId = testQ.Id;
        case1.RecordTypeId = caseRecordTypeId;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        case1.AMFS_Receive_on_Business_Hours__c = false;
        caselist.add(case1);
        
        insert caselist;
        Test.setCreatedDate(case1.Id, Datetime.newInstance(2025, 6, 28, 9, 0, 0));
        
        Test.startTest();
        
        Case getOneCase = [SELECT id, CreatedDate, AMFS_Receive_on_Business_Hours__c FROM Case LIMIT 1];
        System.debug('AMFStest 2 : '+getOneCase);
        AMFS_SLACalculator.testInjectAOH = true;
        AMFS_SLACalculator.testInjectResponse = Datetime.newInstance(2025, 6, 29, 9, 0, 0);
        AMFS_SLACalculator.calculateSLAClosedCase(getOneCase, bh);

        Test.stopTest();

        Case updatedCase = [SELECT Id, Status FROM Case WHERE Id = :getOneCase.Id];
        
        System.assertEquals('Closed', updatedCase.Status, 'Status should be Closed Updated Case');
    }
    @isTest
    static void testStartGreaterthanClosed() {
        BusinessHours bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = 'AMFS E2C - CS' LIMIT 1
        ];

        Contact con1 = [SELECT Id FROM Contact WHERE LastName = 'cust01' LIMIT 1];
        Group testQ = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];

        Datetime emailDate = System.now().addHours(-2);
        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.Status = 'Closed';
        case1.Origin = 'Email';
        case1.ContactId = con1.Id;
        case1.OwnerId = testQ.Id;
        case1.RecordTypeId = caseRecordTypeId;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        case1.AMFS_Receive_on_Business_Hours__c = false;
        caselist.add(case1);
        
        insert caselist;
        Test.setCreatedDate(case1.Id, Datetime.newInstance(2025, 6, 21, 20, 0, 0));
        
        Test.startTest();
        
        Case getOneCase = [SELECT id, CreatedDate, AMFS_Receive_on_Business_Hours__c FROM Case LIMIT 1];
        System.debug('AMFStest 2 : '+getOneCase);
        AMFS_SLACalculator.testInjectAOH = true;
        AMFS_SLACalculator.testInjectResponse = Datetime.newInstance(2025, 6, 24, 9, 0, 0);
        AMFS_SLACalculator.calculateSLAClosedCase(getOneCase, bh);

        Test.stopTest();

        Case updatedCase = [SELECT Id, Status FROM Case WHERE Id = :getOneCase.Id];
        
        System.assertEquals('Closed', updatedCase.Status, 'Status should be Closed Updated Case');
    }
    @isTest
    static void testRespondGreaterthanStartAOH() {
        BusinessHours bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = 'AMFS E2C - CS' LIMIT 1
        ];

        Contact con1 = [SELECT Id FROM Contact WHERE LastName = 'cust01' LIMIT 1];
        Group testQ = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];

        Datetime emailDate = System.now().addHours(-2);
        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.Status = 'Closed';
        case1.Origin = 'Email';
        case1.ContactId = con1.Id;
        case1.OwnerId = testQ.Id;
        case1.RecordTypeId = caseRecordTypeId;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        case1.AMFS_Receive_on_Business_Hours__c = false;
        caselist.add(case1);
        
        insert caselist;
        Test.setCreatedDate(case1.Id, Datetime.newInstance(2025, 6, 21, 20, 0, 0));
        
        Test.startTest();
        
        Case getOneCase = [SELECT id, CreatedDate, AMFS_Receive_on_Business_Hours__c FROM Case LIMIT 1];
        System.debug('AMFStest 2 : '+getOneCase);
        AMFS_SLACalculator.testInjectAOH = true;
        AMFS_SLACalculator.testInjectResponse = Datetime.newInstance(2025, 6, 21, 21, 0, 0);
        AMFS_SLACalculator.calculateSLAClosedCase(getOneCase, bh);

        Test.stopTest();

        Case updatedCase = [SELECT Id, Status FROM Case WHERE Id = :getOneCase.Id];
        
        System.assertEquals('Closed', updatedCase.Status, 'Status should be Closed Updated Case');
    }
    @IsTest
    static void testConvertDurationStringToMs() {
        Test.startTest();
        Long expectedMs = 103773000L;
        Long actualMs = AMFS_SLACalculator.convertDurationStringToMs('1 hari, 4 jam, 49 menit, 33 detik');
        Test.stopTest();

        System.assertEquals(expectedMs, actualMs, 'Should correctly convert hours, minutes, seconds to milliseconds.');
    }
    @IsTest
    static void testConvertMenit() {
        Long millisecondsInOneMinute = 60 * 1000L;
        Test.startTest();
        String result = AMFS_SLACalculator.SLACalculator(millisecondsInOneMinute);
        Test.stopTest();
    }
    @IsTest
    static void testConvertDurationStringToMsNull() {
        Test.startTest();
        Long actualMs = AMFS_SLACalculator.convertDurationStringToMs(null);
        Test.stopTest();
    }
    @IsTest
    static void testRelevantEmailMessagesByParentIdOH() {
        String testLabel = 'Test Label';
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();

        Test.startTest();
        Contact con1 = [SELECT Id FROM Contact WHERE LastName = 'cust01' LIMIT 1];
        Group testQ = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
        
        Datetime emailDate = System.now().addHours(-2);
        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.Status = 'New';
        case1.Origin = 'Email';
        case1.ContactId = con1.Id;
        case1.OwnerId = testQ.Id;
        case1.RecordTypeId = caseRecordTypeId;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        caselist.add(case1);
        
        insert caselist;
        System.debug('AMFStest : '+caselist);
        List<EmailMessage> emailMsgList = new List<EmailMessage>();
        emailMsgList.add(new EmailMessage(FromAddress = 'test1@abc.org', Incoming = true, 
            ToAddress= 'amfsemailtocase2@gmail.com', 
            Headers='magi.mandiri.customer@ewd6y87heyrqpsf1v5mt0n9oftarjjjd4ncgajs1tdaaj2z4x.0k-crveeak.cs57.apex.sandbox.salesforce.com,magi_customer@9-vghghyr0p87lepmwchdifhinoenq6d7rtnrb07xo8vw8kr3h2.9-zalzeae.ap1.apex.salesforce.com',
            Subject = 'From TestClass', TextBody = '23456 ', 
            ParentId = case1.id, MessageDate = emailDate)); 
        
        

        List<EmailMessage> replyEmailList = new List<EmailMessage>();
        replyEmailList.add(new EmailMessage(FromAddress = 'amfsemailtocase2@gmail.com', Incoming = false, 
            ToAddress= 'test1@abc.org', 
            Headers='magi.mandiri.customer@ewd6y87heyrqpsf1v5mt0n9oftarjjjd4ncgajs1tdaaj2z4x.0k-crveeak.cs57.apex.sandbox.salesforce.com,magi_customer@9-vghghyr0p87lepmwchdifhinoenq6d7rtnrb07xo8vw8kr3h2.9-zalzeae.ap1.apex.salesforce.com',
            Subject = 'RE: From TestClass', TextBody = '23456 ', 
            ParentId = case1.id, CreatedDate = emailDate.addHours(1)));

        AMFS_SLACalculator slaCalculatorInitial = new AMFS_SLACalculator();
        AMFS_SLACalculator.getBussinessHoursAdjusment(emailDate, emailDate.addHours(1));

        Map<Id, Case> prebuiltCaseMap = new Map<Id, Case>{
            case1.Id => case1
        };

        AMFS_SLACalculator.testInjectAOH = false;
        AMFS_EmailMessageTriggerHandler.testInjectedCaseMap = prebuiltCaseMap;

        try {
            insert emailMsgList;
            System.debug('Inside try block - success!');
        } catch (Exception e) {
            System.debug('Inside catch block - error!'+e.getMessage());
        } finally {
            System.debug('Inside finally block - always runs!');
        }
        
        Test.stopTest();
        // EmailMessage updatedEmail = [SELECT Id, AMFS_Receive_on_Business_Hours__c FROM EmailMessage WHERE Id = :emailMsgList[0].Id];
        // System.assertEquals(false, updatedEmail.AMFS_Receive_on_Business_Hours__c, 'AMFS_Receive_on_Business_Hours__c should be true for incoming email within BH.');
    }
    @IsTest
    static void testRelevantEmailMessagesByParentIdCS() {
        String testLabel = 'Test Label';
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();

        Test.startTest();
        Contact con1 = [SELECT Id FROM Contact WHERE LastName = 'cust01' LIMIT 1];
        Group testQ = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
        
        Datetime emailDate = System.now().addHours(-2);
        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.Status = 'New';
        case1.Origin = 'Email';
        case1.ContactId = con1.Id;
        case1.OwnerId = testQ.Id;
        case1.RecordTypeId = caseRecordTypeId;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        caselist.add(case1);
        
        insert caselist;
        System.debug('AMFStest : '+caselist);
        List<EmailMessage> emailMsgList = new List<EmailMessage>();
        emailMsgList.add(new EmailMessage(FromAddress = 'test1@abc.org', Incoming = true, 
            ToAddress= 'amfsemailtocase2@gmail.com', 
            Headers='magi.mandiri.customer@ewd6y87heyrqpsf1v5mt0n9oftarjjjd4ncgajs1tdaaj2z4x.0k-crveeak.cs57.apex.sandbox.salesforce.com,magi_customer@9-vghghyr0p87lepmwchdifhinoenq6d7rtnrb07xo8vw8kr3h2.9-zalzeae.ap1.apex.salesforce.com',
            Subject = 'From TestClass', TextBody = '23456 ', 
            ParentId = case1.id, MessageDate = emailDate)); 
        
        

        List<EmailMessage> replyEmailList = new List<EmailMessage>();
        replyEmailList.add(new EmailMessage(FromAddress = 'amfsemailtocase2@gmail.com', Incoming = false, 
            ToAddress= 'test1@abc.org', 
            Headers='magi.mandiri.customer@ewd6y87heyrqpsf1v5mt0n9oftarjjjd4ncgajs1tdaaj2z4x.0k-crveeak.cs57.apex.sandbox.salesforce.com,magi_customer@9-vghghyr0p87lepmwchdifhinoenq6d7rtnrb07xo8vw8kr3h2.9-zalzeae.ap1.apex.salesforce.com',
            Subject = 'RE: From TestClass', TextBody = '23456 ', 
            ParentId = case1.id, CreatedDate = emailDate.addHours(1)));

        AMFS_SLACalculator slaCalculatorInitial = new AMFS_SLACalculator();
        AMFS_SLACalculator.getBussinessHoursAdjusment(emailDate, emailDate.addHours(1));

        Map<Id, Case> prebuiltCaseMap = new Map<Id, Case>{
            case1.Id => case1
        };

        AMFS_SLACalculator.testInjectAOH = false;
        insert emailMsgList;
        
        Set<Id> idCase = new Set<Id>{case1.id};
        // AMFS_SLACalculator.testInjectRelevant = emailMsgList;
        AMFS_SLACalculator.getRelevantEmailMessagesByParentId(idCase);
        Test.stopTest();
    }
    @IsTest
    static void testSLAFlagCheck() {
        Map<String, AMFS_E2C_Setting__mdt> slaSettingsMap = AMFS_E2C_Setting__mdt.getAll();
        AMFS_E2C_Setting__mdt timeSLATargetPBC = slaSettingsMap.get('PBC');
        AMFS_E2C_Setting__mdt timeSLATargetCS = slaSettingsMap.get('CS');
        
        Test.startTest();
        Long millisecondsInOneMinute = 60 * 1000L;
        Boolean pbcMs = AMFS_SLACalculator.SLAFlagCheckAMFS(timeSLATargetPBC,millisecondsInOneMinute);
        Boolean csMs = AMFS_SLACalculator.SLAFlagCheckAMFS(timeSLATargetCS,millisecondsInOneMinute);
        Test.stopTest();
    }
    @isTest
    static void testgetFullHolidayDates() {
        Date today = Date.today();
        Holiday publicHoliday = new Holiday(
            Name = 'Hari Libur',
            ActivityDate = today,
            IsAllDay = true
        );
        insert publicHoliday;

        Datetime startDateTime = Datetime.newInstance(today.addDays(-1).year(), today.addDays(-1).month(), today.addDays(-1).day());
        Datetime endDateTime = Datetime.newInstance(today.year(), today.month(), today.day(), 23, 59, 59);

        Test.startTest();
        AMFS_SLACalculator.getFullHolidayDates(startDateTime,endDateTime);
        Test.stopTest();
    }
    @isTest
    static void testIsCurentOvertime() {
        BusinessHours bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = 'AMFS E2C - PBC' LIMIT 1
        ];

        Datetime now = System.now(); 
        Date todayDate = now.date();

        Business_Hours_Adjustment__c activeOvertime = new Business_Hours_Adjustment__c(
            Name = 'Active Overtime Today',
            Start_Date__c = Datetime.newInstance(todayDate.year(), todayDate.month(), todayDate.day(), 16, 0, 0), // 1:00 PM today
            End_Date__c = Datetime.newInstance(todayDate.year(), todayDate.month(), todayDate.day(), 19, 0, 0)   // 3:00 PM today
        );

        Date yesterdayDate = todayDate.addDays(-1);
        Map<Date, Business_Hours_Adjustment__c> dummyBhs = new Map<Date, Business_Hours_Adjustment__c>();
        dummyBhs.put(todayDate, activeOvertime);
        // dummyBhs.put(yesterdayDate, inactiveOvertime);
        AMFS_SLACalculator.testInjectExtendHours = dummyBhs;

        Datetime checkWithinOvertime = Datetime.newInstance(todayDate.year(), todayDate.month(), todayDate.day(), 14, 0, 0); // 2:00 PM today
        Datetime checkYesterday = Datetime.newInstance(yesterdayDate.year(), yesterdayDate.month(), yesterdayDate.day(), 10, 0, 0); // 2:00 PM today
        Datetime checkWithinOvertime2 = Datetime.newInstance(todayDate.year(), todayDate.month(), todayDate.day(), 17, 0, 0); // 2:00 PM today
        Boolean isOvertime = AMFS_SLACalculator.isCurrentlyOvertime('dummyBhId', checkWithinOvertime);
        Boolean isOvertime2 = AMFS_SLACalculator.isCurrentlyOvertime('dummyBhId', checkWithinOvertime2);
        Boolean isNoOvertime = AMFS_SLACalculator.isCurrentlyOvertime('dummyBhId', checkYesterday);
        Boolean isBhour = AMFS_SLACalculator.isInBusinessHours(checkWithinOvertime2,bh);
        Boolean isBhour2 = AMFS_SLACalculator.isInBusinessHours(checkYesterday,bh);
        System.debug('AMFS test >> '+isOvertime+isOvertime2);
        Test.startTest();
    }
    @isTest
    static void testIsCurrentlyHoliday() {
        BusinessHours bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = 'AMFS E2C - PBC' LIMIT 1
        ];
        
        Holiday publicHoliday = new Holiday(
            Name = 'Hari Senin Libur',
            ActivityDate = Date.newInstance(2025, 7, 28),
            IsAllDay = true
        );

        Map<Date, Holiday> testHolidays = new Map<Date, Holiday>();
        testHolidays.put(publicHoliday.ActivityDate, publicHoliday);

        Test.startTest();
        Datetime holidayDatetime = Datetime.newInstance(2025, 7, 28, 9, 0, 0);
        // AMFS_SLACalculator newObj = new AMFS_SLACalculator();
        AMFS_SLACalculator.loadedHolidaysByDate = testHolidays;
        Boolean isHoliday = AMFS_SLACalculator.isCurrentlyHoliday(holidayDatetime);
        System.debug('AMFS holiday test >> '+isHoliday);
        Boolean isBhour = AMFS_SLACalculator.isInBusinessHours(holidayDatetime,bh);
        Test.stopTest();
    }
    @IsTest
    static void testgetOfficeHoursRespond() {
        BusinessHours bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = 'AMFS E2C - PBC' LIMIT 1
        ];
        String testLabel = 'Test Label';
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();

        Test.startTest();
        Contact con1 = [SELECT Id FROM Contact WHERE LastName = 'cust01' LIMIT 1];
        Group testQ = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
        
        Datetime emailDate = System.now().addHours(-2);
        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.Status = 'New';
        case1.Origin = 'Email';
        case1.ContactId = con1.Id;
        case1.OwnerId = testQ.Id;
        case1.RecordTypeId = caseRecordTypeId;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        caselist.add(case1);
        
        insert caselist;
        System.debug('AMFStest : '+caselist);
        List<EmailMessage> emailMsgList = new List<EmailMessage>();
        emailMsgList.add(new EmailMessage(FromAddress = 'test1@abc.org', Incoming = true, 
            ToAddress= 'amfsemailtocase2@gmail.com', 
            Headers='magi.mandiri.customer@ewd6y87heyrqpsf1v5mt0n9oftarjjjd4ncgajs1tdaaj2z4x.0k-crveeak.cs57.apex.sandbox.salesforce.com,magi_customer@9-vghghyr0p87lepmwchdifhinoenq6d7rtnrb07xo8vw8kr3h2.9-zalzeae.ap1.apex.salesforce.com',
            Subject = 'From GetOHRespond', TextBody = '23456 ', 
            ParentId = case1.id, MessageDate = emailDate)); 
        
        

        List<EmailMessage> replyEmailList = new List<EmailMessage>();
        replyEmailList.add(new EmailMessage(FromAddress = 'amfsemailtocase2@gmail.com', Incoming = false, 
            ToAddress= 'test1@abc.org', 
            Headers='magi.mandiri.customer@ewd6y87heyrqpsf1v5mt0n9oftarjjjd4ncgajs1tdaaj2z4x.0k-crveeak.cs57.apex.sandbox.salesforce.com,magi_customer@9-vghghyr0p87lepmwchdifhinoenq6d7rtnrb07xo8vw8kr3h2.9-zalzeae.ap1.apex.salesforce.com',
            Subject = 'RE: From TestClass', TextBody = '23456 ', 
            ParentId = case1.id, CreatedDate = emailDate.addHours(1)));

        AMFS_SLACalculator slaCalculatorInitial = new AMFS_SLACalculator();
        AMFS_SLACalculator.getBussinessHoursAdjusment(emailDate, emailDate.addHours(1));

        Map<Id, Case> prebuiltCaseMap = new Map<Id, Case>{
            case1.Id => case1
        };

        Datetime createdDateEmail = Datetime.newInstance(2025, 7, 21, 9, 0, 0);

        AMFS_SLACalculator.testInjectAOH = false;
        AMFS_SLACalculator.testFrom = 'SLACalculatorTest';
        AMFS_EmailMessageTriggerHandler.testInjectedCaseMap = prebuiltCaseMap;
        AMFS_EmailMessageTriggerHandler.testRelevantEmail = emailMsgList;
        AMFS_SLACalculator.testInjectResponse = Datetime.newInstance(2025, 7, 28, 10, 0, 0);
        AMFS_SLACalculator.getOfficeHoursRespond(createdDateEmail,emailMsgList[0],bh);
        Test.stopTest();
    }
    @IsTest
    static void testgetOfficeHoursRespond2() {
        BusinessHours bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = 'AMFS E2C - PBC' LIMIT 1
        ];
        String testLabel = 'Test Label';
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();

        Test.startTest();
        Contact con1 = [SELECT Id FROM Contact WHERE LastName = 'cust01' LIMIT 1];
        Group testQ = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
        
        Datetime emailDate = System.now().addHours(-2);
        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.Status = 'New';
        case1.Origin = 'Email';
        case1.ContactId = con1.Id;
        case1.OwnerId = testQ.Id;
        case1.RecordTypeId = caseRecordTypeId;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        caselist.add(case1);
        
        insert caselist;
        System.debug('AMFStest : '+caselist);
        List<EmailMessage> emailMsgList = new List<EmailMessage>();
        emailMsgList.add(new EmailMessage(FromAddress = 'test1@abc.org', Incoming = true, 
            ToAddress= 'amfsemailtocase2@gmail.com', 
            Headers='magi.mandiri.customer@ewd6y87heyrqpsf1v5mt0n9oftarjjjd4ncgajs1tdaaj2z4x.0k-crveeak.cs57.apex.sandbox.salesforce.com,magi_customer@9-vghghyr0p87lepmwchdifhinoenq6d7rtnrb07xo8vw8kr3h2.9-zalzeae.ap1.apex.salesforce.com',
            Subject = 'From GetOHRespond', TextBody = '23456 ', 
            ParentId = case1.id, MessageDate = emailDate)); 
        
        

        List<EmailMessage> replyEmailList = new List<EmailMessage>();
        replyEmailList.add(new EmailMessage(FromAddress = 'amfsemailtocase2@gmail.com', Incoming = false, 
            ToAddress= 'test1@abc.org', 
            Headers='magi.mandiri.customer@ewd6y87heyrqpsf1v5mt0n9oftarjjjd4ncgajs1tdaaj2z4x.0k-crveeak.cs57.apex.sandbox.salesforce.com,magi_customer@9-vghghyr0p87lepmwchdifhinoenq6d7rtnrb07xo8vw8kr3h2.9-zalzeae.ap1.apex.salesforce.com',
            Subject = 'RE: From TestClass', TextBody = '23456 ', 
            ParentId = case1.id, CreatedDate = emailDate.addHours(1)));

        AMFS_SLACalculator slaCalculatorInitial = new AMFS_SLACalculator();
        AMFS_SLACalculator.getBussinessHoursAdjusment(emailDate, emailDate.addHours(1));

        Map<Id, Case> prebuiltCaseMap = new Map<Id, Case>{
            case1.Id => case1
        };

        Datetime createdDateEmail = Datetime.newInstance(2025, 7, 21, 9, 0, 0);

        AMFS_SLACalculator.testInjectAOH = true;
        AMFS_SLACalculator.testFrom = 'SLACalculatorTest';
        AMFS_EmailMessageTriggerHandler.testInjectedCaseMap = prebuiltCaseMap;
        AMFS_EmailMessageTriggerHandler.testRelevantEmail = emailMsgList;
        AMFS_SLACalculator.testInjectResponse = Datetime.newInstance(2025, 7, 28, 10, 0, 0);
        AMFS_SLACalculator.getOfficeHoursRespond(createdDateEmail,emailMsgList[0],bh);
        Test.stopTest();
    }
    @IsTest
    static void testgetOfficeHoursRespond3() {
        BusinessHours bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = 'AMFS E2C - PBC' LIMIT 1
        ];
        Holiday publicHoliday = new Holiday(
            Name = 'Hari Senin Libur',
            ActivityDate = Date.newInstance(2025, 7, 28),
            IsAllDay = true
        );

        Map<Date, Holiday> testHolidays = new Map<Date, Holiday>();
        testHolidays.put(publicHoliday.ActivityDate, publicHoliday);
        AMFS_SLACalculator.loadedHolidaysByDate = testHolidays;
        
        String testLabel = 'Test Label';
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();

        Test.startTest();
        Contact con1 = [SELECT Id FROM Contact WHERE LastName = 'cust01' LIMIT 1];
        Group testQ = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
        
        Datetime emailDate = System.now().addHours(-2);
        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.Status = 'New';
        case1.Origin = 'Email';
        case1.ContactId = con1.Id;
        case1.OwnerId = testQ.Id;
        case1.RecordTypeId = caseRecordTypeId;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        caselist.add(case1);
        
        insert caselist;
        System.debug('AMFStest : '+caselist);
        List<EmailMessage> emailMsgList = new List<EmailMessage>();
        emailMsgList.add(new EmailMessage(FromAddress = 'test1@abc.org', Incoming = true, 
            ToAddress= 'amfsemailtocase2@gmail.com', 
            Headers='magi.mandiri.customer@ewd6y87heyrqpsf1v5mt0n9oftarjjjd4ncgajs1tdaaj2z4x.0k-crveeak.cs57.apex.sandbox.salesforce.com,magi_customer@9-vghghyr0p87lepmwchdifhinoenq6d7rtnrb07xo8vw8kr3h2.9-zalzeae.ap1.apex.salesforce.com',
            Subject = 'From GetOHRespond', TextBody = '23456 ', 
            ParentId = case1.id, MessageDate = emailDate)); 
        
        

        List<EmailMessage> replyEmailList = new List<EmailMessage>();
        replyEmailList.add(new EmailMessage(FromAddress = 'amfsemailtocase2@gmail.com', Incoming = false, 
            ToAddress= 'test1@abc.org', 
            Headers='magi.mandiri.customer@ewd6y87heyrqpsf1v5mt0n9oftarjjjd4ncgajs1tdaaj2z4x.0k-crveeak.cs57.apex.sandbox.salesforce.com,magi_customer@9-vghghyr0p87lepmwchdifhinoenq6d7rtnrb07xo8vw8kr3h2.9-zalzeae.ap1.apex.salesforce.com',
            Subject = 'RE: From TestClass', TextBody = '23456 ', 
            ParentId = case1.id, CreatedDate = emailDate.addHours(1)));

        AMFS_SLACalculator slaCalculatorInitial = new AMFS_SLACalculator();
        AMFS_SLACalculator.getBussinessHoursAdjusment(emailDate, emailDate.addHours(1));

        Map<Id, Case> prebuiltCaseMap = new Map<Id, Case>{
            case1.Id => case1
        };

        Datetime createdDateEmail = Datetime.newInstance(2025, 7, 26, 9, 0, 0);

        AMFS_SLACalculator.testInjectAOH = true;
        AMFS_SLACalculator.testFrom = 'SLACalculatorTest';

        AMFS_EmailMessageTriggerHandler.testInjectedCaseMap = prebuiltCaseMap;
        AMFS_EmailMessageTriggerHandler.testRelevantEmail = emailMsgList;
        AMFS_SLACalculator.testInjectResponse = Datetime.newInstance(2025, 7, 26, 10, 0, 0);
        AMFS_SLACalculator.getOfficeHoursRespond(createdDateEmail,emailMsgList[0],bh);
        Test.stopTest();
    }
    @IsTest
    static void testgetOfficeHoursRespond4() {
        BusinessHours bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = 'AMFS E2C - PBC' LIMIT 1
        ];
        Holiday publicHoliday = new Holiday(
            Name = 'Hari Senin Libur',
            ActivityDate = Date.newInstance(2025, 7, 28),
            IsAllDay = true
        );

        Map<Date, Holiday> testHolidays = new Map<Date, Holiday>();
        testHolidays.put(publicHoliday.ActivityDate, publicHoliday);
        AMFS_SLACalculator.loadedHolidaysByDate = testHolidays;
        
        String testLabel = 'Test Label';
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();

        Test.startTest();
        Contact con1 = [SELECT Id FROM Contact WHERE LastName = 'cust01' LIMIT 1];
        Group testQ = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
        
        Datetime emailDate = System.now().addHours(-2);
        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.Status = 'New';
        case1.Origin = 'Email';
        case1.ContactId = con1.Id;
        case1.OwnerId = testQ.Id;
        case1.RecordTypeId = caseRecordTypeId;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        caselist.add(case1);
        
        insert caselist;
        System.debug('AMFStest : '+caselist);
        List<EmailMessage> emailMsgList = new List<EmailMessage>();
        emailMsgList.add(new EmailMessage(FromAddress = 'test1@abc.org', Incoming = true, 
            ToAddress= 'amfsemailtocase2@gmail.com', 
            Headers='magi.mandiri.customer@ewd6y87heyrqpsf1v5mt0n9oftarjjjd4ncgajs1tdaaj2z4x.0k-crveeak.cs57.apex.sandbox.salesforce.com,magi_customer@9-vghghyr0p87lepmwchdifhinoenq6d7rtnrb07xo8vw8kr3h2.9-zalzeae.ap1.apex.salesforce.com',
            Subject = 'From GetOHRespond', TextBody = '23456 ', 
            ParentId = case1.id, MessageDate = emailDate)); 
        
        

        List<EmailMessage> replyEmailList = new List<EmailMessage>();
        replyEmailList.add(new EmailMessage(FromAddress = 'amfsemailtocase2@gmail.com', Incoming = false, 
            ToAddress= 'test1@abc.org', 
            Headers='magi.mandiri.customer@ewd6y87heyrqpsf1v5mt0n9oftarjjjd4ncgajs1tdaaj2z4x.0k-crveeak.cs57.apex.sandbox.salesforce.com,magi_customer@9-vghghyr0p87lepmwchdifhinoenq6d7rtnrb07xo8vw8kr3h2.9-zalzeae.ap1.apex.salesforce.com',
            Subject = 'RE: From TestClass', TextBody = '23456 ', 
            ParentId = case1.id, CreatedDate = emailDate.addHours(1)));

        AMFS_SLACalculator slaCalculatorInitial = new AMFS_SLACalculator();
        AMFS_SLACalculator.getBussinessHoursAdjusment(emailDate, emailDate.addHours(1));

        Map<Id, Case> prebuiltCaseMap = new Map<Id, Case>{
            case1.Id => case1
        };

        Datetime createdDateEmail = Datetime.newInstance(2025, 7, 26, 9, 0, 0);

        AMFS_SLACalculator.testInjectAOH = true;
        AMFS_SLACalculator.testFrom = 'SLACalculatorTest';

        AMFS_EmailMessageTriggerHandler.testInjectedCaseMap = prebuiltCaseMap;
        AMFS_EmailMessageTriggerHandler.testRelevantEmail = emailMsgList;
        AMFS_SLACalculator.testInjectResponse = Datetime.newInstance(2025, 7, 29, 10, 0, 0);
        AMFS_SLACalculator.getOfficeHoursRespond(createdDateEmail,emailMsgList[0],bh);
        Test.stopTest();
    }
    @IsTest
    static void testgetOfficeHoursRespond5() {
        BusinessHours bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = 'AMFS E2C - PBC' LIMIT 1
        ];
        Holiday publicHoliday = new Holiday(
            Name = 'Hari Senin Libur',
            ActivityDate = Date.newInstance(2025, 7, 28),
            IsAllDay = true
        );

        Map<Date, Holiday> testHolidays = new Map<Date, Holiday>();
        testHolidays.put(publicHoliday.ActivityDate, publicHoliday);
        AMFS_SLACalculator.loadedHolidaysByDate = testHolidays;
        
        String testLabel = 'Test Label';
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();

        Test.startTest();
        Contact con1 = [SELECT Id FROM Contact WHERE LastName = 'cust01' LIMIT 1];
        Group testQ = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
        
        Datetime emailDate = System.now().addHours(-2);
        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.Status = 'New';
        case1.Origin = 'Email';
        case1.ContactId = con1.Id;
        case1.OwnerId = testQ.Id;
        case1.RecordTypeId = caseRecordTypeId;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        caselist.add(case1);
        
        insert caselist;
        System.debug('AMFStest : '+caselist);
        List<EmailMessage> emailMsgList = new List<EmailMessage>();
        emailMsgList.add(new EmailMessage(FromAddress = 'test1@abc.org', Incoming = true, 
            ToAddress= 'amfsemailtocase2@gmail.com', 
            Headers='magi.mandiri.customer@ewd6y87heyrqpsf1v5mt0n9oftarjjjd4ncgajs1tdaaj2z4x.0k-crveeak.cs57.apex.sandbox.salesforce.com,magi_customer@9-vghghyr0p87lepmwchdifhinoenq6d7rtnrb07xo8vw8kr3h2.9-zalzeae.ap1.apex.salesforce.com',
            Subject = 'From GetOHRespond', TextBody = '23456 ', 
            ParentId = case1.id, MessageDate = emailDate)); 
        
        

        List<EmailMessage> replyEmailList = new List<EmailMessage>();
        replyEmailList.add(new EmailMessage(FromAddress = 'amfsemailtocase2@gmail.com', Incoming = false, 
            ToAddress= 'test1@abc.org', 
            Headers='magi.mandiri.customer@ewd6y87heyrqpsf1v5mt0n9oftarjjjd4ncgajs1tdaaj2z4x.0k-crveeak.cs57.apex.sandbox.salesforce.com,magi_customer@9-vghghyr0p87lepmwchdifhinoenq6d7rtnrb07xo8vw8kr3h2.9-zalzeae.ap1.apex.salesforce.com',
            Subject = 'RE: From TestClass', TextBody = '23456 ', 
            ParentId = case1.id, CreatedDate = emailDate.addHours(1)));

        AMFS_SLACalculator slaCalculatorInitial = new AMFS_SLACalculator();
        AMFS_SLACalculator.getBussinessHoursAdjusment(emailDate, emailDate.addHours(1));

        Map<Id, Case> prebuiltCaseMap = new Map<Id, Case>{
            case1.Id => case1
        };

        Datetime createdDateEmail = Datetime.newInstance(2025, 7, 23, 18, 0, 0);

        AMFS_SLACalculator.testInjectAOH = true;
        AMFS_SLACalculator.testFrom = 'SLACalculatorTest';

        AMFS_EmailMessageTriggerHandler.testInjectedCaseMap = prebuiltCaseMap;
        AMFS_EmailMessageTriggerHandler.testRelevantEmail = emailMsgList;
        AMFS_SLACalculator.testInjectResponse = Datetime.newInstance(2025, 7, 23, 20, 0, 0);
        AMFS_SLACalculator.getOfficeHoursRespond(createdDateEmail,emailMsgList[0],bh);
        Test.stopTest();
    }
    @IsTest
    static void testgetOfficeHoursRespond6() {
        BusinessHours bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = 'AMFS E2C - PBC' LIMIT 1
        ];
        Holiday publicHoliday = new Holiday(
            Name = 'Hari Senin Libur',
            ActivityDate = Date.newInstance(2025, 7, 28),
            IsAllDay = true
        );

        Map<Date, Holiday> testHolidays = new Map<Date, Holiday>();
        testHolidays.put(publicHoliday.ActivityDate, publicHoliday);
        AMFS_SLACalculator.loadedHolidaysByDate = testHolidays;
        
        String testLabel = 'Test Label';
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();

        Test.startTest();
        Contact con1 = [SELECT Id FROM Contact WHERE LastName = 'cust01' LIMIT 1];
        Group testQ = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
        
        Datetime emailDate = System.now().addHours(-2);
        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.Status = 'New';
        case1.Origin = 'Email';
        case1.ContactId = con1.Id;
        case1.OwnerId = testQ.Id;
        case1.RecordTypeId = caseRecordTypeId;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        caselist.add(case1);
        
        insert caselist;
        System.debug('AMFStest : '+caselist);
        List<EmailMessage> emailMsgList = new List<EmailMessage>();
        emailMsgList.add(new EmailMessage(FromAddress = 'test1@abc.org', Incoming = true, 
            ToAddress= 'amfsemailtocase2@gmail.com', 
            Headers='magi.mandiri.customer@ewd6y87heyrqpsf1v5mt0n9oftarjjjd4ncgajs1tdaaj2z4x.0k-crveeak.cs57.apex.sandbox.salesforce.com,magi_customer@9-vghghyr0p87lepmwchdifhinoenq6d7rtnrb07xo8vw8kr3h2.9-zalzeae.ap1.apex.salesforce.com',
            Subject = 'From GetOHRespond', TextBody = '23456 ', 
            ParentId = case1.id, MessageDate = emailDate)); 
        
        

        List<EmailMessage> replyEmailList = new List<EmailMessage>();
        replyEmailList.add(new EmailMessage(FromAddress = 'amfsemailtocase2@gmail.com', Incoming = false, 
            ToAddress= 'test1@abc.org', 
            Headers='magi.mandiri.customer@ewd6y87heyrqpsf1v5mt0n9oftarjjjd4ncgajs1tdaaj2z4x.0k-crveeak.cs57.apex.sandbox.salesforce.com,magi_customer@9-vghghyr0p87lepmwchdifhinoenq6d7rtnrb07xo8vw8kr3h2.9-zalzeae.ap1.apex.salesforce.com',
            Subject = 'RE: From TestClass', TextBody = '23456 ', 
            ParentId = case1.id, CreatedDate = emailDate.addHours(1)));

        AMFS_SLACalculator slaCalculatorInitial = new AMFS_SLACalculator();
        AMFS_SLACalculator.getBussinessHoursAdjusment(emailDate, emailDate.addHours(1));

        Map<Id, Case> prebuiltCaseMap = new Map<Id, Case>{
            case1.Id => case1
        };

        Datetime createdDateEmail = Datetime.newInstance(2025, 7, 23, 18, 0, 0);

        AMFS_SLACalculator.testInjectAOH = true;
        AMFS_SLACalculator.testFrom = 'SLACalculatorTest';

        AMFS_EmailMessageTriggerHandler.testInjectedCaseMap = prebuiltCaseMap;
        AMFS_EmailMessageTriggerHandler.testRelevantEmail = emailMsgList;
        AMFS_SLACalculator.testInjectResponse = Datetime.newInstance(2025, 7, 26, 20, 0, 0);
        AMFS_SLACalculator.getOfficeHoursRespond(createdDateEmail,emailMsgList[0],bh);
        Test.stopTest();
    }
}