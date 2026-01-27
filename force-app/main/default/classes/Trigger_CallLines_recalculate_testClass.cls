@isTest
public class Trigger_CallLines_recalculate_testClass {
    @isTest static void test(){
        Test.startTest();
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Outbound Agent%AMFS' limit 1];
        UserRole agentRoleAMFS = [SELECT Id FROM UserRole WHERE Name like 'Outbound Agent%AMFS' limit 1];
        
        //List<User> usr = [Select Id From User Where IsActive = true AND UserRoleId = '00E90000001QoEXEA0' AND ProfileId = '00e90000001ypjCAAQ' Limit 2];
        List<User> usr = [Select Id From User Where IsActive = true AND UserRoleId = :agentRoleAMFS.Id AND ProfileId = :agentProfileAMFS.Id Limit 2];
        
        /*
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Outbound Agent%AMFS' limit 1];
        UserRole agentRoleAMFS = [SELECT Id FROM UserRole WHERE Name like 'Outbound Agent%AMFS' limit 1];
        
        User us = new User(Alias = 'spv1', Email='spvAMFS@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='spvAMFSTEST', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, Entity__c = 'AMFS', 
      			TimeZoneSidKey='Asia/Jakarta', UserName='spvAMFSTEST@axa.co.id', UserRoleId = agentRoleAMFS.Id);
        insert us;
		*/
        
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
        Insert cl;
        
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
        //cl2.Activity__c = 'Collection';
        Insert cl2;
        
        Call_Line__c cl3 = new Call_Line__c();
        cl3.Call_Status_Config__c = 'Hold';
        cl3.Policy_No__c = '517-8475321';
        cl3.Contact__c = con.Id;
        cl3.Remark_Hold_Debet__c = 'test2';
        cl3.Call_List__c = cmp.Id;
        cl3.OwnerId = usr[0].Id;
        cl3.Agent__c = usr[0].Id;
        cl3.APE_Total_Child__c = 1000000;
        cl3.Entity__c = 'AMFS';
        //cl2.Activity__c = 'Collection';
        Insert cl3;
        
        //Update Call Line
        cl.OwnerId = usr[1].Id;
        cl.Agent__c = usr[1].Id;
        cl2.OwnerId = usr[1].Id;
        cl2.Agent__c = usr[1].Id;
        List<Call_Line__c> clList = new List<Call_Line__c>();
        clList.add(cl);
        clList.add(cl2);
        Update clList;
        
        //Update Call Line Custom Remark
        System.runAs(usr[1]){
            cl.Call_Status_Config__c = 'N';
            Update cl;
            
            cl.Call_Remarks__c = 'hehheh coba';
            Update cl;
        }
        
        //Update Campaign
        cmp.IsExpired__c = true;
        update cmp;
        
        //Delete Call Line
        Delete clList;
        
        Test.stopTest();
    }
}