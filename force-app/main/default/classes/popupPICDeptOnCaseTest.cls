@isTest
public class popupPICDeptOnCaseTest {
    @testSetup static void testData() {
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id,
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
        
        User u2 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%AMFS%' LIMIT 1].Id,
            LastName = 'CommonUser',
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
        insert u2;
        
        //--MCTR Default
        Master_Case_Type_Regional__c mctr0 = new Master_Case_Type_Regional__c();
        mctr0.Name = 'AMFS Default Case Type';
        mctr0.Entity__c = 'AMFS';
        mctr0.Product__c = '';
        mctr0.Business_Channel__c = '';
        mctr0.Active__c = TRUE;
        mctr0.Case_Type__c = '';
        mctr0.Type__c = 'Request';
        
        mctr0.Department_Queue__c = 'Collection CR';
        mctr0.PIC_Department__c = u2.Id;
        mctr0.TAT__c = 5;
        
        insert mctr0;
        
        //--MCTR Request
        Master_Case_Type_Regional__c mctr1 = new Master_Case_Type_Regional__c();
        mctr1.Name = 'Request_Claim';
        mctr1.Entity__c = 'AMFS';
        mctr1.Active__c = TRUE;
        mctr1.Case_Type__c = 'Request_Claim';
        mctr1.Type__c = 'Request';
        
        mctr1.Department_Queue__c = 'Claim';
        mctr1.PIC_Department__c = u2.Id;
        mctr1.TAT__c = 5;
        insert mctr1;
        
        //--MCTR Request 2
        Master_Case_Type_Regional__c mctr2 = new Master_Case_Type_Regional__c();
        mctr2.Name = 'Request_Claim2';
        mctr2.Entity__c = 'AMFS';
        mctr2.Active__c = TRUE;
        mctr2.Case_Type__c = 'Request_Claim2';
        mctr2.Type__c = 'Request';
        
        mctr2.Department_Queue__c = 'Claim';
        mctr2.PIC_Department__c = u2.Id;
        mctr2.TAT__c = 5;
        insert mctr2;
    }
    
    public static testMethod void selectingCaseType() {
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'CommonUser'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'RequestAMFSCase'];
        
        Case cs = new Case();
        cs.RecordTypeId = rt.Id;
        cs.PIC_Department_LU__c = u2.Id;
        cs.Subject = 'Subject Test Case';
        cs.Division__c = 'CCC';
        cs.Named_User__c = 'test';
        cs.Type = 'Request';
        cs.Case_Type_Config__c = 'Request_Claim';
        insert cs;
        
        Department__c d = new Department__c();
        d.name = 'test1';
        insert d;
        
        Named_User__c nu = new Named_User__c();
        nu.Name = 'test';
        nu.Department__c = d.id;
        insert nu;
        
        System.runAs(u) {
            Test.startTest();
            Test.setCurrentPage(Page.popupPICDeptOnCase);
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            popupPICDeptOnCaseClass popCls = new popupPICDeptOnCaseClass(stdController);
            popCls.selectedPicklist = 'Case_Type';
            popCls.updateCase();
            Test.stopTest();
        }
    }
    
    public static testMethod void defaultCaseType() {
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'CommonUser'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'RequestAMFSCase'];
        
        Case cs = new Case();
        cs.RecordTypeId = rt.Id;
        cs.PIC_Department_LU__c = u2.Id;
        cs.Subject = 'Subject Test Case';
        cs.Division__c = 'CCC';
        cs.Named_User__c = 'test';
        cs.Type = 'Request';
        cs.Case_Type_Config__c = 'Request_Default';
        insert cs;
        
        Department__c d = new Department__c();
        d.name = 'test1';
        insert d;
        
        Named_User__c nu = new Named_User__c();
        nu.Name = 'test';
        nu.Department__c = d.id;
        insert nu;
        
        System.runAs(u) {
            Test.startTest();
            Test.setCurrentPage(Page.popupPICDeptOnCase);
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            popupPICDeptOnCaseClass popCls = new popupPICDeptOnCaseClass(stdController);
            popCls.selectedPicklist = 'Case_Type';
            popCls.updateCase();
            Test.stopTest();
        }
    }
    
    public static testMethod void selectingPICDept() {
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'CommonUser'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'RequestAMFSCase'];
        
        Case cs = new Case();
        cs.RecordTypeId = rt.Id;
        cs.PIC_Department_LU__c = u2.Id;
        cs.Subject = 'Subject Test Case';
        cs.Division__c = 'CCC';
        cs.Named_User__c = 'test';
        cs.Type = 'Request';
        cs.Case_Type_Config__c = 'Request_Claim';
        insert cs;
        
        Department__c d = new Department__c();
        d.name = 'test1';
        insert d;
        
        Named_User__c nu = new Named_User__c();
        nu.Name = 'test';
        nu.Department__c = d.id;
        insert nu;
        
        Test.setCurrentPage(Page.popupPICDeptOnCase);
        ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
        popupPICDeptOnCaseClass popCls = new popupPICDeptOnCaseClass(stdController);
		popCls.selectedPicklist = 'PIC_Department';
        popCls.updateCase();
    }
}