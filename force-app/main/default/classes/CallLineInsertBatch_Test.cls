@isTest
public class CallLineInsertBatch_Test {
    @isTest static void test(){
        Test.startTest();
        List<User> usr = [Select Id From User Where IsActive = true AND UserRoleId = '00E90000001QoEXEA0' AND ProfileId = '00e90000001ypjCAAQ' Limit 2];
        
        //Insert User Detail
        User_Detail__c usrD = new User_Detail__c();
        usrD.Name = 'test';
        usrD.User__c = usr[0].Id;
        usrD.F_Entity__c = 'AMFS';
        Insert usrD;
        
        User_Detail__c usrD2 = new User_Detail__c();
        usrD2.Name = 'test2';
        usrD2.User__c = usr[1].Id;
        usrD2.F_Entity__c = 'AMFS';
        Insert usrD2;
        
        //Insert Campaign
        Call_List__c cmp = new Call_List__c();
        cmp.RecordTypeId = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
        cmp.Activity__c = 'Collection';
        cmp.Case_Type__c = 'Withdrawal';
        cmp.Expired_Date__c = System.today() + 100000;
        cmp.Entity__c = 'AMFS';
        cmp.IsExpired__c = false;
        Insert cmp;
        
        //Insert Account
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Entity__c = 'AMFS';
        Insert acc;
        
        //Insert Contact
        Contact con = new Contact();
        con.LastName = 'test mus';
        con.AccountId = acc.Id;
        Insert con;
        
        //Insert Agent_Distribution_History__c
        Agent_Distribution_History__c adh = new Agent_Distribution_History__c();
        adh.Amount__c = 123456;
        adh.Campaign__c = cmp.Id;
        adh.User_Detail__c = usrD.Id;
        Insert adh;
        
        Agent_Distribution_History__c adh2 = new Agent_Distribution_History__c();
        adh2.Amount__c = 123456;
        adh2.Campaign__c = cmp.Id;
        adh2.User_Detail__c = usrD2.Id;
        Insert adh2;
        
        list<Call_Line__c> callLineList = new list<Call_Line__c>();

        //Insert Call Line
        Call_Line__c cl = new Call_Line__c();
        cl.Call_Status_Config__c = 'Hold';
        cl.Policy_No__c = '517-8475322';
        cl.Contact__c = con.Id;
        cl.Remark_Hold_Debet__c = 'test';
        cl.Call_List__c = cmp.Id;
        cl.OwnerId = usr[0].Id;
        cl.Agent__c = usr[0].Id;
        cl.APE_Total_Child__c = 1000000;
        cl.Entity__c = 'AMFS';
        cl.Activity__c = 'Collection';
        cl.Ext_Id__c = 'AMFS_Coll_01';
        //Insert cl;
        callLineList.add(cl);
        
        Call_Line__c cl2 = new Call_Line__c();
        cl2.Call_Status_Config__c = 'Hold';
        cl2.Policy_No__c = '517-8475321';
        cl2.Contact__c = con.Id;
        cl2.Remark_Hold_Debet__c = 'test2';
        cl2.Call_List__c = cmp.Id;
        cl2.OwnerId = usr[0].Id;
        cl2.Agent__c = usr[0].Id;
        cl2.APE_Total_Child__c = 1000000;
        cl2.Entity__c = 'AMFS';
        cl2.Ext_Id__c = 'AMFS_Coll_02';
        //cl2.Activity__c = 'Collection';
        //Insert cl2;
        callLineList.add(cl2);

        if (callLineList.size() > 0) {
            CallLineInsertBatch jb = new CallLineInsertBatch(callLineList);
            Database.executeBatch(jb, 100);
        }
        
        // For CallLineGrouping
        list<Call_Line__c> callLineList2 = new list<Call_Line__c>();

        //Insert Call Line
        Call_Line__c cl3 = new Call_Line__c();
        cl3.Call_Status_Config__c = 'Hold';
        cl3.Policy_No__c = '517-8475322';
        cl3.Contact__c = con.Id;
        cl3.Remark_Hold_Debet__c = 'test';
        cl3.Call_List__c = cmp.Id;
        cl3.OwnerId = usr[0].Id;
        cl3.Agent__c = usr[0].Id;
        cl3.APE_Total_Child__c = 1000000;
        cl3.Entity__c = 'AMFS';
        cl3.Activity__c = 'Collection';
        cl3.Ext_Id__c = 'AMFS_Coll_03';
        //Insert cl;
        callLineList2.add(cl3);
        
        Call_Line__c cl4 = new Call_Line__c();
        cl4.Call_Status_Config__c = 'Hold';
        cl4.Policy_No__c = '517-8475321';
        cl4.Contact__c = con.Id;
        cl4.Remark_Hold_Debet__c = 'test2';
        cl4.Call_List__c = cmp.Id;
        cl4.OwnerId = usr[0].Id;
        cl4.Agent__c = usr[0].Id;
        cl4.APE_Total_Child__c = 1000000;
        cl4.Entity__c = 'AMFS';
        cl4.Ext_Id__c = 'AMFS_Coll_02';
        //cl2.Activity__c = 'Collection';
        //Insert cl2;
        callLineList2.add(cl4);
        
        if (callLineList2.size() > 0) insert callLineList2;

        //List<Call_Line__c> listupdate = [SELECT id FROM Call_Line__c LIMIT 10];
        if (callLineList2.size() > 0) {
            //CallLineGroupingBatch jb = new CallLineGroupingBatch(callLineList2);
            //Database.executeBatch(jb, 100);
        }
        
        
        Test.stopTest();
    }
}