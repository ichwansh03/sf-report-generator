@isTest
public class File_Update_AMFS_Ctrl_TestClass {
    private static testMethod void trueTest() {
        Test.startTest();
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Outbound Agent%AMFS' limit 1];
        UserRole agentRoleAMFS = [SELECT Id FROM UserRole WHERE Name like 'Outbound Agent%AMFS' limit 1];
        
        //Insert user
        User usr = new User(
            ProfileId = agentProfileAMFS.Id,
            LastName = 'last',
            Email = 'puser000@amamama.com',
            Username = 'puser000@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            UserRoleId = agentRoleAMFS.Id,
            Entity__c = 'AMFS',
            isActive = true,
            Agent__c = true
        );
        Insert usr;
        
        System.runAs(usr){            
            //Insert User Detail
            User_Detail__c usrD = new User_Detail__c();
            usrD.Name = 'test';
            usrD.User__c = usr.Id;
            usrD.F_Entity__c = 'AMFS';
            usrD.Entity__c = 'AMFS';
            usrD.Outbound_Activity_Case_type__c = 'Collection - Renewal Reminder';
            usrD.Level__c = '2';
            usrD.Amount_Level__c = 1000;
            Insert usrD;
            
            //Insert Account
            Account acc = new Account();
            acc.Name = 'Test Account';
            acc.Entity__c = 'AMFS';
            Insert acc;
            
            //Insert Contact
            Contact con = new Contact();
            con.LastName = 'test mus';
            con.AccountId = acc.Id;
            con.Policy_No__c = 'test';
            con.Entity__c = 'AMFS';
            con.Email = 'musmus@gmail.com';
            con.MobilePhone = '123456789';
            con.HomePhone = '123456789';
            Insert con;
            
            //Insert Campaign
            Call_List__c cmp = new Call_List__c();
            cmp.RecordTypeId = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
            cmp.Campaign_Name__c = 'Lapse Konven';
            cmp.Activity__c = 'Collection';
            cmp.Case_Type_Config__c = 'Lapse Konven';
            cmp.Expired_Date__c = System.today() + 100000;
            cmp.Entity__c = 'AMFS';
            cmp.IsExpired__c = false;
            Insert cmp;
            
            //Insert Call Line
            Call_Line__c cl = new Call_Line__c();
            cl.Call_Status_Config__c = 'Hold';
            cl.Policy_No__c = '517-8475322';
            cl.Contact__c = con.Id;
            cl.Remark_Hold_Debet__c = 'test';
            cl.Call_List__c = cmp.Id;
            cl.OwnerId = usr.Id;
            cl.Agent__c = usr.Id;
            cl.APE_Total_Child__c = 1000000;
            cl.Entity__c = 'AMFS';
            cl.Activity__c = 'Collection';
            cl.Policy_No__c = 'test';
            cl.Contacted_Number__c = '123456789';
            cl.Home_Phone__c = '1234567';
            Insert cl;
            
            //Insert Call Line
            Call_Line__c cl2 = new Call_Line__c();
            cl2.Call_Status_Config__c = 'Hold';
            cl2.Policy_No__c = '517-8475322';
            cl2.Contact__c = con.Id;
            cl2.Remark_Hold_Debet__c = 'test';
            cl2.Call_List__c = cmp.Id;
            cl2.OwnerId = usr.Id;
            cl2.APE_Total_Child__c = 1000000;
            cl2.Entity__c = 'AMFS';
            cl2.Activity__c = 'Collection';
            cl2.Policy_No__c = 'test';
            cl2.Contacted_Number__c = '123456789';
            cl2.Home_Phone__c = '1234567';
            cl2.Parent_Call_Line__c = cl.Id;
            Insert cl2;
            
            //Insert Call Line
            Call_Line__c cl3 = new Call_Line__c();
            cl3.Call_Status_Config__c = 'Hold';
            cl3.Policy_No__c = '517-8400022';
            cl3.Contact__c = con.Id;
            cl3.Remark_Hold_Debet__c = 'test';
            cl3.Call_List__c = cmp.Id;
            cl3.OwnerId = usr.Id;
            cl3.Agent__c = usr.Id;
            cl3.APE_Total_Child__c = 1000000;
            cl3.Entity__c = 'AMFS';
            cl3.Activity__c = 'Collection';
            cl3.Policy_No__c = 'test';
            cl3.Contacted_Number__c = '123456789';
            cl3.Home_Phone__c = '1234567';
            Insert cl3;
            
            //Update Document
            File_Update_AMFS_Ctrl cgc = new File_Update_AMFS_Ctrl();
            cgc.choosen_campaign = 'Lapse Konven';
            Document testDocument = cgc.document;
            testDocument.Body = Blob.valueOf('1234567890,"""\' 123456789,"""\' dan \'""\' hehehe "');
            testDocument.Name = 'test.csv';
            
            File_Update_AMFS_Ctrl.CollectionTask cgcC = new File_Update_AMFS_Ctrl.CollectionTask();
            cgcC.PolicyNo = '';
            cgcC.statusPaid = '';
            
            File_Update_AMFS_Ctrl.invalidPolicy cgcI = new File_Update_AMFS_Ctrl.invalidPolicy('policyNo','status');        
            
            cgc.Upload();
            cgc.parseCollectionTaskCSV('1234567890,"""\' 123456789,"""\' dan \'""\' hehehe "', false);
            
            cgc.reset();
        }
        Test.stopTest();
    }
}