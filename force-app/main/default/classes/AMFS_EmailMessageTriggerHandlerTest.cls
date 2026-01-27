/**
 * @description       : Test Class for AMFS_EmailMessageTriggerHandler
 * @author            : Ahmad Yazid Munif
 * @group             : 
 * @last modified on  : 07-31-2025
 * @last modified by  : Ahmad Yazid Munif
**/
@isTest
public class AMFS_EmailMessageTriggerHandlerTest{
    public static BusinessHours bh;
    public static RecordType recordType;
    public static Group testQ;
    public static Contact con1;
    public static Map<String, BusinessHours> ownerMap;

    public static String testEmailAddress = '';
    public static List<AMFS_E2C_Setting__mdt> emailtoCase;
    public static String[] emailAMFSCustomerLong = system.label.EMAIL_AMFS_Customer_Long.split('\\|\\|');
    public static String[] emailAMFSNasabahLong = system.label.EMAIL_AMFS_Nasabah_Long.split('\\|\\|');
    public static String[] emailAMFSPriorityLong = system.label.EMAIL_AMFS_Priority_Long.split('\\|\\|');
    
    // public static Id AmfsInquiry = Schema.SObjectType.Case.getRecordTypeInfosByName().get('InquiryAMFSCase').getRecordTypeId();
    // public static Id AmfsComplaint = Schema.SObjectType.Case.getRecordTypeInfosByName().get('AMFSComplaintCase').getRecordTypeId();
    public static Id caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('AMFSEmailtoCase').getRecordTypeId();

    public static List<Case> caselist = new List<Case>();
    public static Case case1 = new Case();
    public static Map<Id, Case> prebuiltCaseMap = new Map<Id, Case>();
    @TestVisible private static Id caseId;
    @TestSetup
    static void makeData(){
        emailtoCase = AMFS_E2C_Setting__mdt.getAll().values();
        System.debug('emailtoCase'+emailtoCase);
        String nameLabel= '';
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

        // List<Case> caselist = new List<Case>();
        case1 = new Case();
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
        prebuiltCaseMap = new Map<Id, Case>{
            case1.Id => case1
        };
    }
    public static Case selectCase(){
        case1 = [SELECT Id,e2cEmailToAddress__c,AMFS_SLA_Target__c FROM Case WHERE Entity_Backup__c = 'AMFS' LIMIT 1];
        return case1;
    }

    @IsTest
    static void test_IncomingEmail_FirstReceiveInBHRE() {
        emailtoCase = AMFS_E2C_Setting__mdt.getAll().values();
        System.debug('emailtoCase'+emailtoCase);
        String nameLabel= '';
        for (AMFS_E2C_Setting__mdt setting : emailtoCase) {
            if (setting.Label == 'CS') {
                testEmailAddress=setting.Email_Case__c;
                nameLabel=setting.Business_Hour_Name__c;
                break;
            }
        }
        bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = :nameLabel LIMIT 1
        ];
        
        ownerMap = new Map<String, BusinessHours>();
        ownerMap.put(nameLabel, bh);
        AMFS_EmailMessageTriggerHandler.testInjectBHours = ownerMap;
        
        Datetime emailDate = Datetime.newInstance(2025, 7, 28, 10, 0, 0);
        // case1 = [SELECT Id FROM Case WHERE Entity_Backup__c = 'AMFS' LIMIT 1];
        Case getCase = selectCase();
        // case1 = [SELECT Id FROM Case WHERE Entity_Backup__c = 'AMFS' LIMIT 1];
        // caseId = case1.Id;
        System.debug('AMFStest caseId make : '+getCase.Id);
        
        List<EmailMessage> emailMsgList = new List<EmailMessage>();
        emailMsgList.add(new EmailMessage(FromAddress = 'test1@abc.org', Incoming = true, 
            ToAddress= 'zzzz@yahoo.co.id; asd2@gmail.com', 
            Headers='salesforce1.com',
            Subject = 'From TestClass', TextBody = '23456 ', 
            ParentId = getCase.Id, MessageDate = emailDate, CreatedDate = emailDate.addHours(1))); 

        // insert emailMsgList;

        List<EmailMessage> replyEmailList = new List<EmailMessage>();
        replyEmailList.add(new EmailMessage(FromAddress = 'asd2@gmail.com', Incoming = false, 
            ToAddress= 'test1@abc.org; test2@abc.org',
            Headers='salesforce2.com',
            Subject = 'RE: From TestClass', TextBody = '23456 ',
            ParentId = getCase.Id, CreatedDate = emailDate.addHours(1)));
            
        Holiday publicHoliday = new Holiday(
            Name = 'Hari Senin Libur',
            ActivityDate = Date.newInstance(2025, 7, 28),
            IsAllDay = true
        );
        Map<Date, Holiday> testHolidays = new Map<Date, Holiday>();
        testHolidays.put(publicHoliday.ActivityDate, publicHoliday);
        AMFS_SLACalculator.loadedHolidaysByDate = testHolidays;

        Map<Id, Case> prebuiltCaseMap = new Map<Id, Case>{
            getCase.Id => getCase
        };

        AMFS_EmailMessageTriggerHandler.testRelevantEmail = emailMsgList;
        AMFS_EmailMessageTriggerHandler.testInjectRelevantSize = 1;
        AMFS_EmailMessageTriggerHandler.testInjectSLATarget = 'CS';
        AMFS_EmailMessageTriggerHandler.testInjectedCaseMap = prebuiltCaseMap;
        AMFS_EmailMessageTriggerHandler.testInjectCreatedDateEmail = emailDate.addHours(1);
        AMFS_SLACalculator.getBussinessHoursAdjusment(emailDate, emailDate.addHours(1));
        AMFS_EmailMessageTriggerHandler.testInjectResponseDate = Datetime.newInstance(2025, 7, 28, 10, 0, 0);
        AMFS_EmailMessageTriggerHandler.onAfterInsertAndUpdate(emailMsgList);
        // AMFS_EmailMessageTriggerHandler.onAfterInsertAndUpdate(replyEmailList);
        // insert replyEmailList;
    }

    @IsTest
    static void test_IncomingEmail_FirstReceiveInBHRENull() {
        emailtoCase = AMFS_E2C_Setting__mdt.getAll().values();
        System.debug('emailtoCase'+emailtoCase);
        String nameLabel= '';
        for (AMFS_E2C_Setting__mdt setting : emailtoCase) {
            if (setting.Label == 'CS') {
                testEmailAddress=setting.Email_Case__c;
                nameLabel=setting.Business_Hour_Name__c;
                break;
            }
        }
        bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = :nameLabel LIMIT 1
        ];
        
        ownerMap = new Map<String, BusinessHours>();
        ownerMap.put(nameLabel, bh);
        AMFS_EmailMessageTriggerHandler.testInjectBHours = ownerMap;
        
        Datetime emailDate = Datetime.newInstance(2025, 7, 28, 10, 0, 0);
        // case1 = [SELECT Id FROM Case WHERE Entity_Backup__c = 'AMFS' LIMIT 1];
        Case getCase = selectCase();
        // case1 = [SELECT Id FROM Case WHERE Entity_Backup__c = 'AMFS' LIMIT 1];
        // caseId = case1.Id;
        System.debug('AMFStest caseId make : '+getCase.Id);
        
        List<EmailMessage> emailMsgList = new List<EmailMessage>();
        emailMsgList.add(new EmailMessage(FromAddress = 'test1@abc.org', Incoming = true, 
            ToAddress= 'zzzz@yahoo.co.id; asd2@gmail.com', 
            Headers='salesforce1.com',
            Subject = 'From TestClass', TextBody = '23456 ', 
            ParentId = getCase.Id, MessageDate = emailDate, CreatedDate = emailDate.addHours(1))); 

        // insert emailMsgList;

        List<EmailMessage> replyEmailList = new List<EmailMessage>();
        replyEmailList.add(new EmailMessage(FromAddress = 'asd2@gmail.com', Incoming = false, 
            ToAddress= 'test1@abc.org; test2@abc.org',
            Headers='salesforce2.com',
            Subject = 'RE: From TestClass', TextBody = '23456 ',
            ParentId = getCase.Id, CreatedDate = emailDate.addHours(1)));
            
        Holiday publicHoliday = new Holiday(
            Name = 'Hari Senin Libur',
            ActivityDate = Date.newInstance(2025, 7, 28),
            IsAllDay = true
        );
        Map<Date, Holiday> testHolidays = new Map<Date, Holiday>();
        testHolidays.put(publicHoliday.ActivityDate, publicHoliday);
        AMFS_SLACalculator.loadedHolidaysByDate = testHolidays;

        Map<Id, Case> prebuiltCaseMap = new Map<Id, Case>{
            getCase.Id => getCase
        };

        AMFS_EmailMessageTriggerHandler.testRelevantEmail = emailMsgList;
        AMFS_EmailMessageTriggerHandler.testInjectRelevantSize = 1;
        AMFS_EmailMessageTriggerHandler.testInjectSLATarget = 'CS';
        AMFS_EmailMessageTriggerHandler.testInjectedCaseMap = prebuiltCaseMap;
        AMFS_EmailMessageTriggerHandler.testInjectCreatedDateEmail = emailDate.addHours(1);
        AMFS_SLACalculator.getBussinessHoursAdjusment(emailDate, emailDate.addHours(1));
        AMFS_EmailMessageTriggerHandler.testInjectResponseDate = Datetime.newInstance(2025, 7, 28, 10, 0, 0);
        // AMFS_EmailMessageTriggerHandler.onAfterInsertAndUpdate(emailMsgList);
        AMFS_EmailMessageTriggerHandler.onAfterInsertAndUpdate(replyEmailList);
        // insert replyEmailList;
    }

    @IsTest
    static void test_IncomingEmail_FirstReceiveInBHFW() {
        emailtoCase = AMFS_E2C_Setting__mdt.getAll().values();
        System.debug('emailtoCase'+emailtoCase);
        String nameLabel= '';
        for (AMFS_E2C_Setting__mdt setting : emailtoCase) {
            if (setting.Label == 'CS') {
                testEmailAddress=setting.Email_Case__c;
                nameLabel=setting.Business_Hour_Name__c;
                break;
            }
        }
        bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = :nameLabel LIMIT 1
        ];
        
        ownerMap = new Map<String, BusinessHours>();
        ownerMap.put(nameLabel, bh);
        AMFS_EmailMessageTriggerHandler.testInjectBHours = ownerMap;
        
        Datetime emailDate = Datetime.newInstance(2025, 7, 28, 10, 0, 0);
        // case1 = [SELECT Id FROM Case WHERE Entity_Backup__c = 'AMFS' LIMIT 1];
        Case getCase = selectCase();
        // case1 = [SELECT Id FROM Case WHERE Entity_Backup__c = 'AMFS' LIMIT 1];
        // caseId = case1.Id;
        System.debug('AMFStest caseId make : '+getCase.Id);
        
        List<EmailMessage> emailMsgList = new List<EmailMessage>();
        emailMsgList.add(new EmailMessage(FromAddress = 'test1@abc.org', Incoming = true, 
            ToAddress= 'zzzz@yahoo.co.id; asd2@gmail.com', 
            Headers='salesforce1.com',
            Subject = 'From TestClass', TextBody = '23456 ', 
            ParentId = getCase.Id, MessageDate = emailDate, CreatedDate = emailDate.addHours(1))); 

        // insert emailMsgList;

        List<EmailMessage> replyEmailList = new List<EmailMessage>();
        replyEmailList.add(new EmailMessage(FromAddress = 'asd2@gmail.com', Incoming = false, 
            ToAddress= 'test1@abc.org; test2@abc.org',
            Headers='salesforce2.com',
            Subject = 'FW: From TestClass', TextBody = '23456 ',
            ParentId = getCase.Id, CreatedDate = emailDate.addHours(1)));
            
        Holiday publicHoliday = new Holiday(
            Name = 'Hari Senin Libur',
            ActivityDate = Date.newInstance(2025, 7, 28),
            IsAllDay = true
        );
        Map<Date, Holiday> testHolidays = new Map<Date, Holiday>();
        testHolidays.put(publicHoliday.ActivityDate, publicHoliday);
        AMFS_SLACalculator.loadedHolidaysByDate = testHolidays;

        Map<Id, Case> prebuiltCaseMap = new Map<Id, Case>{
            getCase.Id => getCase
        };

        AMFS_EmailMessageTriggerHandler.testRelevantEmail = emailMsgList;
        AMFS_EmailMessageTriggerHandler.testInjectRelevantSize = 1;
        AMFS_EmailMessageTriggerHandler.testInjectSLATarget = 'CS';
        AMFS_EmailMessageTriggerHandler.testInjectedCaseMap = prebuiltCaseMap;
        AMFS_EmailMessageTriggerHandler.testInjectCreatedDateEmail = emailDate.addHours(1);
        AMFS_SLACalculator.getBussinessHoursAdjusment(emailDate, emailDate.addHours(1));
        AMFS_EmailMessageTriggerHandler.testInjectResponseDate = Datetime.newInstance(2025, 7, 28, 10, 0, 0);
        // AMFS_EmailMessageTriggerHandler.onAfterInsertAndUpdate(emailMsgList);
        AMFS_EmailMessageTriggerHandler.onAfterInsertAndUpdate(replyEmailList);
        // insert replyEmailList;
    }

    @IsTest
    static void test_IncomingEmail_FirstReceiveInBHFW2() {
        emailtoCase = AMFS_E2C_Setting__mdt.getAll().values();
        System.debug('emailtoCase'+emailtoCase);
        String nameLabel= '';
        for (AMFS_E2C_Setting__mdt setting : emailtoCase) {
            if (setting.Label == 'CS') {
                testEmailAddress=setting.Email_Case__c;
                nameLabel=setting.Business_Hour_Name__c;
                break;
            }
        }
        bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = :nameLabel LIMIT 1
        ];
        
        ownerMap = new Map<String, BusinessHours>();
        ownerMap.put(nameLabel, bh);
        AMFS_EmailMessageTriggerHandler.testInjectBHours = ownerMap;
        
        Datetime emailDate = Datetime.newInstance(2025, 7, 28, 10, 0, 0);
        // case1 = [SELECT Id FROM Case WHERE Entity_Backup__c = 'AMFS' LIMIT 1];
        Case getCase = selectCase();
        // case1 = [SELECT Id FROM Case WHERE Entity_Backup__c = 'AMFS' LIMIT 1];
        // caseId = case1.Id;
        System.debug('AMFStest caseId make : '+getCase.Id);
        
        List<EmailMessage> emailMsgList = new List<EmailMessage>();
        emailMsgList.add(new EmailMessage(FromAddress = 'test1@abc.org', Incoming = true, 
            ToAddress= 'zzzz@yahoo.co.id; asd2@gmail.com', 
            Headers='salesforce1.com',
            Subject = 'From TestClass', TextBody = '23456 ', 
            ParentId = getCase.Id, MessageDate = emailDate, 
            AMFS_First_Forward_TIme_Duration__c = '1 jam', CreatedDate = emailDate.addHours(1))); 

        // insert emailMsgList;

        List<EmailMessage> replyEmailList = new List<EmailMessage>();
        replyEmailList.add(new EmailMessage(FromAddress = 'asd2@gmail.com', Incoming = false, 
            ToAddress= 'test1@abc.org; test2@abc.org',
            Headers='salesforce2.com',
            Subject = 'FW: From TestClass', TextBody = '23456 ',
            ParentId = getCase.Id, CreatedDate = emailDate.addHours(1)));
            
        Holiday publicHoliday = new Holiday(
            Name = 'Hari Senin Libur',
            ActivityDate = Date.newInstance(2025, 7, 28),
            IsAllDay = true
        );
        Map<Date, Holiday> testHolidays = new Map<Date, Holiday>();
        testHolidays.put(publicHoliday.ActivityDate, publicHoliday);
        AMFS_SLACalculator.loadedHolidaysByDate = testHolidays;

        Map<Id, Case> prebuiltCaseMap = new Map<Id, Case>{
            getCase.Id => getCase
        };

        AMFS_EmailMessageTriggerHandler.testRelevantEmail = emailMsgList;
        AMFS_EmailMessageTriggerHandler.testInjectRelevantSize = 1;
        AMFS_EmailMessageTriggerHandler.testInjectSLATarget = 'CS';
        AMFS_EmailMessageTriggerHandler.testInjectedCaseMap = prebuiltCaseMap;
        AMFS_EmailMessageTriggerHandler.testInjectCreatedDateEmail = emailDate.addHours(1);
        AMFS_SLACalculator.getBussinessHoursAdjusment(emailDate, emailDate.addHours(1));
        AMFS_EmailMessageTriggerHandler.testInjectResponseDate = Datetime.newInstance(2025, 7, 28, 10, 0, 0);
        // AMFS_EmailMessageTriggerHandler.onAfterInsertAndUpdate(emailMsgList);
        AMFS_EmailMessageTriggerHandler.onAfterInsertAndUpdate(replyEmailList);
        // insert replyEmailList;
    }

    @IsTest
    static void test_IncomingEmail_FirstReceiveInBHRE2() {
        emailtoCase = AMFS_E2C_Setting__mdt.getAll().values();
        System.debug('emailtoCase'+emailtoCase);
        String nameLabel= '';
        for (AMFS_E2C_Setting__mdt setting : emailtoCase) {
            if (setting.Label == 'CS') {
                testEmailAddress=setting.Email_Case__c;
                nameLabel=setting.Business_Hour_Name__c;
                break;
            }
        }
        bh = [
            SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE IsActive = true AND Name = :nameLabel LIMIT 1
        ];
        
        ownerMap = new Map<String, BusinessHours>();
        ownerMap.put(nameLabel, bh);
        AMFS_EmailMessageTriggerHandler.testInjectBHours = ownerMap;
        
        Datetime emailDate = Datetime.newInstance(2025, 7, 28, 10, 0, 0);
        // case1 = [SELECT Id FROM Case WHERE Entity_Backup__c = 'AMFS' LIMIT 1];
        Case getCase = selectCase();
        // case1 = [SELECT Id FROM Case WHERE Entity_Backup__c = 'AMFS' LIMIT 1];
        // caseId = case1.Id;
        System.debug('AMFStest caseId make : '+getCase.Id);
        
        List<EmailMessage> emailMsgList = new List<EmailMessage>();
        emailMsgList.add(new EmailMessage(FromAddress = 'test1@abc.org', Incoming = true, 
            ToAddress= 'zzzz@yahoo.co.id; asd2@gmail.com', 
            Headers='salesforce1.com',
            Subject = 'From TestClass', TextBody = '23456 ', 
            ParentId = getCase.Id, MessageDate = emailDate, 
            AMFS_First_Response_Time_Duration__c = '2 jam', CreatedDate = emailDate.addHours(1))); 

        // insert emailMsgList;

        List<EmailMessage> replyEmailList = new List<EmailMessage>();
        replyEmailList.add(new EmailMessage(FromAddress = 'asd2@gmail.com', Incoming = false, 
            ToAddress= 'test1@abc.org; test2@abc.org',
            Headers='salesforce2.com',
            Subject = 'RE: From TestClass', TextBody = '23456 ',
            ParentId = getCase.Id, CreatedDate = emailDate.addHours(1)));
            
        Holiday publicHoliday = new Holiday(
            Name = 'Hari Senin Libur',
            ActivityDate = Date.newInstance(2025, 7, 28),
            IsAllDay = true
        );
        Map<Date, Holiday> testHolidays = new Map<Date, Holiday>();
        testHolidays.put(publicHoliday.ActivityDate, publicHoliday);
        AMFS_SLACalculator.loadedHolidaysByDate = testHolidays;

        Map<Id, Case> prebuiltCaseMap = new Map<Id, Case>{
            getCase.Id => getCase
        };

        AMFS_EmailMessageTriggerHandler.testRelevantEmail = emailMsgList;
        AMFS_EmailMessageTriggerHandler.testInjectRelevantSize = 1;
        AMFS_EmailMessageTriggerHandler.testInjectSLATarget = 'CS';
        AMFS_EmailMessageTriggerHandler.testInjectedCaseMap = prebuiltCaseMap;
        AMFS_EmailMessageTriggerHandler.testInjectCreatedDateEmail = emailDate.addHours(1);
        AMFS_SLACalculator.getBussinessHoursAdjusment(emailDate, emailDate.addHours(1));
        AMFS_EmailMessageTriggerHandler.testInjectResponseDate = Datetime.newInstance(2025, 7, 28, 10, 0, 0);
        // AMFS_EmailMessageTriggerHandler.onAfterInsertAndUpdate(emailMsgList);
        AMFS_EmailMessageTriggerHandler.onAfterInsertAndUpdate(replyEmailList);
        // insert replyEmailList;
    }
}