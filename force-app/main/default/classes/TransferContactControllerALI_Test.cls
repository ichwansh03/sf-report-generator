@isTest(seeAllData = true)
public class TransferContactControllerALI_Test {

    public static testmethod void test1() {
        user us = [SELECT id, SIP__c FROM User WHERE id =:UserInfo.getUserId()];
        string userSIP = 'SIP '+us.SIP__c;
        //Id gp = [select id from Group WHERE Type = 'Queue' and Name = :userSIP limit 1].Id;
        
        Test.startTest();
        User u = createUser();
        u.UserName='sysadmin1@testorg.com';
        u.Entity__c = 'ALI';
        insert u;
        System.runAs(u){
            Assign_Log__c newLog = new Assign_Log__c();
            newLog.Contact__c = ApexPages.currentPage().getParameters().get('id');
            newLog.From_User__c = UserInfo.getUserId();
            newLog.Entity__c = u.Entity__c;
        
            PageReference pageRef = Page.TransferContactALI;
            system.debug(pageRef);
            Test.setCurrentPage(pageRef);
            TransferContactControllerALI obj01 = new TransferContactControllerALI();
            obj01.newLog = newLog;
            obj01.retURL = String.valueOf(pageRef);
            obj01.save();
        }
        Test.stopTest();
    }
    
    // =========================================================== USER SYSTEM ADMINISTRATOR ===================================================================================
    public static User createUser(){
        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User u = new User();
        u.Alias = 'sysadmin';
        u.Email = 'sysadmin@testorg.com';
        u.EmailEncodingKey = 'UTF-8';
        u.LastName = 'Testing';
        u.LanguageLocaleKey = 'en_US';
        u.LocaleSidKey = 'en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey = 'Asia/Jakarta';
        u.UserName='sysadmin@testorg.com';
        U.SIP__c = '703';
        return u;
    }

}