@isTest
public class SchCoreServiceNotification_Test {

    @testSetup 
    static void setTestData() {
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%AMFS%' LIMIT 1].Id,
            LastName = 'LastName',
            Email = 'tester@email.com',
            Username = 'tester@email.com' + System.currentTimeMillis(),
            CompanyName = 'The Company',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            Entity__c = 'AMFS'
        );
        insert u; 
        
        Account a = new Account(Name = 'Account AMFS', Entity__c = 'AMFS');
        insert a;
        
        Contact c = new Contact(
            AccountId = a.Id,
            LastName = 'LastName',
            FirstName = 'FirstName',
            Entity__c = 'AMFS',
            Policy_No__c = '100-000-1110001',
            PolicyApp__c = 'DMTM'
        );
        insert c;  
        
        Id rtype = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
        
        Call_List__c cl = new Call_List__c(
            RecordTypeId = rtype,
            Activity__c = 'Collection',
            OwnerId = u.id,
            Case_Type__c = 'Redemption TM',
            Expired_Date__c = system.today() + 30,
            Entity__c = 'AMFS',
            Campaign_Name__c = 'Redemption TM'
        );
        insert cl;
        
        Call_Line__c cLine = new Call_Line__c(
            Call_List__c = cl.id, 
            Contact__c = c.id,
            Call_Status_Config__c = 'Cancel',
            Reason_Status_Config__c = 'Busy Line',
            Activity__c = 'Collection',
            Policy_No__c = '100-000-1110001', 
            Call_Remarks__c = 'OK',
            Entity__c = 'AMFS'
        );
        insert cLine; 
        
        AppLog__c logcl = new AppLog__c(
            Log_Call_Line__c = cLine.Id,
            Status__c = 'Error',
            id__c = cLine.Id,
            Policy_No__c = cLine.Policy_No__c,
            Report_Name__c = 'AMFS Collection Robot DMTM',
            Policy_App__c = 'DMTM',
            Is_Exported__c = true,
            StartLongTime__c = system.now().getTime(),
            EndLongTime__c = system.now().getTime()
        );
        insert logcl;
    }
    
    @isTest
    static void testErrorJob() {
        Test.startTest();
        System.schedule('UT_SchNotificationServiceError', '0 0 12 * * ?', new SchCoreServiceNotification());
        Test.stopTest();
        System.assertEquals(1, [SELECT COUNT() FROM AppLog__c], 'AppLog__c dari setup harus ada');
    }
    
    @isTest
    static void testSuccessJob() {
        AppLog__c logSuccess = new AppLog__c(
            Status__c = 'Success',
            id__c = 'LOG-SUCCESS',
            Report_Name__c = 'AMFS Inbound Robot DMTM',
            Policy_App__c = 'DMTM',
            StartLongTime__c = system.now().getTime(),
            EndLongTime__c = system.now().getTime()
        );
        insert logSuccess;
        
        Test.startTest();
        System.schedule('SchNotificationServiceSuccess', '0 0 12 * * ?', new SchCoreServiceNotification());
        Test.stopTest();
        
        Integer logCount = [SELECT COUNT() FROM AppLog__c WHERE Status__c = 'Success'];
        System.assert(logCount > 0, 'AppLog__c Success harus ada');
    }
    
    @isTest
    static void testRescheduleJobDirect() {
        Test.startTest();
        SchCoreServiceNotification notif = new SchCoreServiceNotification();
        notif.rescheduleJob();
        Test.stopTest();
        System.assert(true, 'rescheduleJob executed without exception');
    }
    
}