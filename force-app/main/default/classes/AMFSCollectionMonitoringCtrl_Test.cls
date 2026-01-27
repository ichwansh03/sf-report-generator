@isTest
public class AMFSCollectionMonitoringCtrl_Test {

    // RES NEW REQUEST
    static testMethod void Test() {
        Test.startTest();

        //Insert user
        User usr = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Id = '00e90000001ypjCAAQ'].Id,
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
            UserRoleId = '00E90000001QoEXEA0',
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
            con.Email = 'Email@gmail.com';
            con.MobilePhone = '1234567';
            con.HomePhone = '1234567';
            Insert con;
    
            //Insert Campaign "Redemption Konven"
            Call_List__c cmp = new Call_List__c();
            cmp.RecordTypeId = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
            cmp.Campaign_Name__c = 'Redemption Konven';
            cmp.Activity__c = 'Collection';
            cmp.Case_Type_Config__c = 'Redemption Konven';
            cmp.Expired_Date__c = System.today() + 100000;
            cmp.Entity__c = 'AMFS';
            cmp.IsExpired__c = false;
            Insert cmp;
            
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
            
            date datetoday = date.today();
            AMFSCollectionMonitoringCtrl colmon = new AMFSCollectionMonitoringCtrl();
            colmon.getlistOfCaseType();
            colmon.filterdata.Case_Type__c = 'Lapse Konven';
            colmon.filterdata.List_Date__c = date.newInstance(datetoday.year(), datetoday.month(), 1);
            colmon.filterdata.Expired_Date__c = date.newInstance(datetoday.year(), datetoday.month(), 27);
            colmon.getdata();
            
            colmon.filterdata.Case_Type__c = 'Redemption & Withdrawal';
            colmon.getdata();
    
            colmon.filterdata.Case_Type__c = 'Lapse TM';
            colmon.getdata();
            
            colmon.getdata2();
            colmon.getdataLapse();
            colmon.getdataLapseAsOff();
            colmon.getdataLapse_RW();
            colmon.getdataLapseAsOff_RW();

        }
        
        Test.stopTest();
    }
    
}