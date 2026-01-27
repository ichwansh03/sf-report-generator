@isTest
private class CaseController_AGI_Test {
    @testSetup static void setTestData() {
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
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
            Entity__c = 'AGI'
        );
        insert u;
        
        User u2 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Back Office AGI'].Id,
            LastName = 'LN',
            Email = 'LN@email.com',
            Username = 'LN@email.com' + System.currentTimeMillis(),
            CompanyName = 'The Company',
            Title = 'title2',
            Alias = 'alias2',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            Entity__c = 'AGI'
        );
        insert u2;
        
        Account a = new Account();
        a.Name = 'Account AGI';
        a.Entity__c = 'AGI';
        insert a;
        
        Contact c = new Contact();
        c.AccountId = a.Id;
        c.LastName = 'LastName';
        c.FirstName = 'FirstName';
        c.Entity__c = 'AGI';
        insert c;
        
        //--MCTR Default
        Master_Case_Type_Regional__c mctr0 = new Master_Case_Type_Regional__c();
        mctr0.Name = 'AGI Default Case Type';
        mctr0.Entity__c = 'AGI';
        mctr0.Product__c = '';
        mctr0.Business_Channel__c = '';
        mctr0.Active__c = TRUE;
        mctr0.Case_Type__c = '';
        mctr0.Type__c = '';
        
        mctr0.Department_Queue__c = 'Claim MV';
        mctr0.PIC_Department__c = u.Id;
        mctr0.TAT__c = 5;
        
        mctr0.Department_Queue_2__c = 'Credit Control';
        mctr0.PIC_Department_2__c = u.Id;
        mctr0.TAT_2__c = 6;
        insert mctr0;
        
        //--MCTR Inquiry
        Master_Case_Type_Regional__c mctr1 = new Master_Case_Type_Regional__c();
        mctr1.Name = 'Excess Of Claim';
        mctr1.Entity__c = 'AGI';
        mctr1.Product__c = 'MV - Commercial';
        mctr1.Business_Channel__c = 'Bancassurance';
        mctr1.Current_User__c = FALSE;
        mctr1.Active__c = TRUE;
        mctr1.Case_Type__c = 'Excess Of Claim';
        mctr1.Type__c = 'Inquiry';
        
        mctr1.Department_Queue__c = 'Claim MV';
        mctr1.PIC_Department__c = u.Id;
        mctr1.TAT__c = 5;
        
        mctr1.Department_Queue_2__c = 'CMU';
        mctr1.PIC_Department_2__c = u.Id;
        mctr1.TAT_2__c = 6;
        
        mctr1.Department_Queue_3__c = 'CMU';
        mctr1.PIC_Department_3__c = u.Id;
        mctr1.TAT_3__c = 6;
        
        mctr1.Department_Queue_4__c = 'CMU';
        mctr1.PIC_Department_4__c = u.Id;
        mctr1.TAT_4__c = 6;
        
        mctr1.Department_Queue_5__c = 'CMU';
        mctr1.PIC_Department_5__c = u.Id;
        mctr1.TAT_5__c = 6;
        insert mctr1;
        
        //--MCTR Request
        Master_Case_Type_Regional__c mctr2 = new Master_Case_Type_Regional__c();
        mctr2.Name = 'New Claim';
        mctr2.Entity__c = 'AGI';
        mctr2.Product__c = 'Property - Commercial';
        mctr2.Business_Channel__c = 'TM';
        mctr2.Active__c = TRUE;
        mctr2.Case_Type__c = 'New Claim';
        mctr2.Type__c = 'Request';
        
        mctr2.Department_Queue__c = 'Claim Property';
        mctr2.PIC_Department__c = u.Id;
        mctr2.TAT__c = 3;
        
        mctr2.Department_Queue_2__c = 'Credit Control';
        mctr2.PIC_Department_2__c = u.Id;
        mctr2.TAT_2__c = 8;
        insert mctr2;
        
        //--MCTR Complaint
        Master_Case_Type_Regional__c mctr3 = new Master_Case_Type_Regional__c();
        mctr3.Name = 'Claim Delay';
        mctr3.Entity__c = 'AGI';
        mctr3.Product__c = 'Health Group - Local (GSC)';
        mctr3.Business_Channel__c = 'Agency Online';
        mctr3.Current_User__c = TRUE;
        mctr3.Active__c = TRUE;
        mctr3.Case_Type__c = 'Claim Delay';
        mctr3.Type__c = 'Complaint';
        
        mctr3.Department_Queue__c = 'AXA CMU';
        mctr3.PIC_Department__c = u.Id;
        mctr3.TAT__c = 1;
        
        mctr3.Department_Queue_2__c = 'Health CR';
        mctr3.PIC_Department_2__c = u.Id;
        mctr3.TAT_2__c = 9;
        insert mctr3;
        
        Group grp = new Group();
        grp.Name = 'Temporary Queue';
        grp.Type = 'Queue';
        insert grp;
    }
    
    static testMethod void caseInquiryAGI_1() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'InquiryAGICase'];
        Master_Case_Type_Regional__c mctrr = [SELECT Id, Name, Current_User__c, PIC_Department__c FROM Master_Case_Type_Regional__c WHERE Entity__c = 'AGI' AND Current_User__c = FALSE limit 1];
        
         String retURL = 'www.url.com/return';
        String selectedCaseTypeKeeper = 'Excess of Claim';

        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.OwnerId = u.Id;
        cs.Subject = 'Subject Test Case';
        cs.Entity_Backup__c = 'AGI';
        cs.Product__c = 'MV - Commercial';
        cs.Business_channel__c = 'Bancassurance';
        cs.Case_Type__c = 'Excess of Claim';
        cs.Type = 'Inquiry';
        cs.Origin = 'Email';
        cs.Priority = 'Medium';
        cs.Priority = '';
        cs.PIC_Department_LU__c = mctrr.PIC_Department__c;
        insert cs;
        
        
        Test.startTest();
        Test.setCurrentPage(Page.CaseInquiryContact_AGI);
        Apexpages.currentPage().getParameters().put('retURL', retURL);
        Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
        Apexpages.currentPage().getParameters().put('entity', 'AGI');
        ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
        CaseInquiryController_AGI con = new CaseInquiryController_AGI(stdController);
        con.selectedCaseTypeKeeper = selectedCaseTypeKeeper;
        con.cs.Product__c = 'MV - Commercial';
        con.cs.Business_channel__c = 'Bancassurance';
        con.cs.Type = 'Inquiry'; //--Added 29-04-2019
        con.save();
        con.cancel();
        Test.stopTest();
    }
    
    static testMethod void caseInquiryAGI_2() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'LN'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'InquiryAGICase'];
        Master_Case_Type_Regional__c mctrr = [SELECT Id, Name, Current_User__c, PIC_Department__c FROM Master_Case_Type_Regional__c WHERE Entity__c = 'AGI' AND Current_User__c = FALSE limit 1];
        
         String retURL = 'www.url.com/return';
        String selectedCaseTypeKeeper = 'Excess of Claim<br />Claim';

        System.runAs(u) {
            Case cs = new Case();
            cs.ContactId = c.Id;
            cs.OwnerId = u.Id;
            cs.Subject = 'Subject Test Case';
            cs.Entity_Backup__c = 'AGI';
            cs.Product__c = 'MV - Commercial';
            cs.Business_channel__c = 'Bancassurance';
            cs.Case_Type__c = 'Excess of Claim';
            cs.Type = 'Inquiry';
            cs.Origin = 'Email';
            cs.Priority = 'High';
            cs.PIC_Department_LU__c = mctrr.PIC_Department__c;
            //insert cs;
            
            Test.startTest();
            Test.setCurrentPage(Page.CaseInquiryContact_AGI);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AGI');
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseInquiryController_AGI con = new CaseInquiryController_AGI(stdController);
            con.selectedCaseTypeKeeper = selectedCaseTypeKeeper;
            con.cs.Product__c = 'MV - Commercial';
            con.cs.Business_channel__c = 'Bancassurance';
            con.cs.Type = 'Inquiry';
            con.save_n_close();
            Test.stopTest();
        }
    }
    
    static testMethod void caseInquiryAGI_3() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'LN'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'InquiryAGICase'];
        Master_Case_Type_Regional__c mctrr = [SELECT Id, Name, Current_User__c, PIC_Department__c FROM Master_Case_Type_Regional__c WHERE Entity__c = 'AGI' AND Current_User__c = FALSE limit 1];
        
         String retURL = 'www.url.com/return';
        String selectedCaseTypeKeeper = 'Excess of Claim<br />Claim';

        System.runAs(u2) {
            Case cs = new Case();
            cs.ContactId = c.Id;
            cs.OwnerId = u.Id;
            cs.Subject = 'Subject Test Case';
            cs.Entity_Backup__c = 'AGI';
            cs.Product__c = 'MV - Commercial';
            cs.Business_channel__c = 'Bancassurance';
            cs.Case_Type__c = 'Excess of Claim';
            cs.Type = 'Inquiry';
            cs.Origin = 'Email';
            cs.Priority = 'High';
            cs.PIC_Department_LU__c = mctrr.PIC_Department__c;
            //insert cs;
            
            Test.startTest();
            Test.setCurrentPage(Page.CaseInquiryContact_AGI);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AGI');
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseInquiryController_AGI con = new CaseInquiryController_AGI(stdController);
            con.selectedCaseTypeKeeper = selectedCaseTypeKeeper;
            con.cs.Product__c = 'MV - Commercial';
            con.cs.Business_channel__c = 'Bancassurance';
            con.cs.Type = 'Inquiry';
            con.save_n_close();
            Test.stopTest();
        }
    }
    
    static testMethod void caseRequestAGI_1() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'LN'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'RequestAGICase'];
        
        String retURL = 'www.url.com/return';
        
        System.runAs(u) {
            Case cs = new Case();
            cs.ContactId = c.Id;
            cs.OwnerId = u.Id;
            cs.Subject = 'Subject Test Case';
            cs.Entity_Backup__c = 'AGI';
            cs.Product__c = 'Property - Commercial';
            cs.Business_channel__c = 'TM';
            cs.Case_Type__c = 'New Claim';
            cs.Type = 'Request';
            cs.Origin = 'Email';
            cs.PIC_Department_LU__c = u2.Id;
            //insert cs;
        
        
            Test.startTest();
            Test.setCurrentPage(Page.CaseRequestLayoutContact_AGI);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AGI');
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseRequestLayoutNegativeFeedback_AGI con = new CaseRequestLayoutNegativeFeedback_AGI(stdController);
            con.availableCaseTypeKeeper = 'New Claim';
            con.selectedCaseTypeKeeper = 'New Claim';
            con.comment = 'comment';
            con.currentId = 'currentId';
            con.accId = 'accId';
            con.requestId = 'requestId';
            con.cs.Type = 'Request';
            con.cs.Case_Type_Config__c = 'New Claim';
            con.cs.Product__c = 'Property - Commercial';
            con.cs.Business_channel__c = 'TM';
            con.save();
            con.SaveAndNew();
            con.cancel();
            Test.stopTest();
        }
    }
    
    static testMethod void caseRequestAGI_2() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'LN'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'RequestAGICase'];
        
        String retURL = 'www.url.com/return';
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.OwnerId = u.Id;
        cs.Subject = 'Subject Test Case';
        cs.Entity_Backup__c = 'AGI';
        cs.Product__c = 'Property - Commercial';
        cs.Business_channel__c = 'MV';
        cs.Case_Type__c = 'New Claim';
        cs.Type = 'Request';
        cs.Origin = 'Email';
        cs.PIC_Department_LU__c = u2.Id;
        insert cs;
        
        //System.runAs(u) {
            Test.startTest();
            Test.setCurrentPage(Page.CaseRequestLayoutContact_AGI);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AGI');
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseRequestLayoutNegativeFeedback_AGI con = new CaseRequestLayoutNegativeFeedback_AGI(stdController);
            con.cs.Case_Type_Config__c = 'New Claim';
            con.SaveAndNew();
            Test.stopTest();
        //}
    }
    
    static testMethod void caseComplaintAGI_1() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'AGIComplaintCase'];
        Master_Case_Type_Regional__c mctrr = [SELECT Id, Name, Current_User__c, PIC_Department__c FROM Master_Case_Type_Regional__c WHERE Entity__c = 'AGI' AND Current_User__c = FALSE limit 1];
        
        String retURL = 'www.url.com/return';
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.OwnerId = u.Id;
        cs.Subject = 'Subject Test Case';
        cs.Entity_Backup__c = 'AGI';
        cs.Product__c = 'Health Group - Local (GSC)';
        cs.Business_channel__c = 'Agency Online';
        cs.Case_Type__c = 'Claim Delay';
        cs.Type = 'Complaint';
        cs.Origin = 'Email';
        insert cs;
        
        //System.runAs(u) {
            Test.startTest();
            Test.setCurrentPage(Page.CaseComplaintLayoutContactAGI);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AGI');
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseComplaintLayoutNegativeFeedback_AGI con = new CaseComplaintLayoutNegativeFeedback_AGI(stdController);
            con.availableCaseTypeKeeper = 'Claim Delay';
            con.selectedCaseTypeKeeper = 'Claim Delay';
            con.currentId = 'currentId';
            con.accId = 'accId';
            con.cs.Case_Type_Config__c = 'Claim Delay';
            con.cs.Product__c = 'Health Group - Local (GSC)';
            con.cs.Business_channel__c = 'Agency Online';
            con.save();
            con.SaveAndNew();
            con.cancel();
            Test.stopTest();
        //}
    }
    
    static testMethod void caseComplaintAGI_2() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'AGIComplaintCase'];
        Master_Case_Type_Regional__c mctr = [SELECT Id FROM Master_Case_Type_Regional__c WHERE Current_User__c = TRUE];
        
        String retURL = 'www.url.com/return';
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.OwnerId = u.Id;
        cs.Subject = 'Subject Test Case';
        cs.Entity_Backup__c = 'AGI';
        cs.Product__c = 'Health Group - Local (GSC)';
        cs.Business_channel__c = 'Agency Online';
        cs.Case_Type__c = 'Claim Delay';
        cs.Type = 'Complaint';
        cs.Origin = 'Email';
        insert cs;
        
        System.runAs(u) {
            Test.startTest();
            Test.setCurrentPage(Page.CaseComplaintLayoutContactAGI);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AGI');
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseComplaintLayoutNegativeFeedback_AGI con = new CaseComplaintLayoutNegativeFeedback_AGI(stdController);
            con.cs.Case_Type_Config__c = 'Claim Delay';
            con.SaveAndNew();
            Test.stopTest();
        }
    }
    
    static testMethod void caseRequestLayoutTestData() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'LN'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'RequestAGICase'];
        
        String retURL = 'www.url.com/return';
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.OwnerId = u.Id;
        cs.Subject = 'Subject Test Case';
        cs.Entity_Backup__c = 'AGI';
        cs.Product__c = 'Property - Commercial';
        cs.Business_channel__c = 'TM';
        cs.Case_Type__c = 'New Claim';
        cs.Type = 'Request';
        cs.Origin = 'Email';
        cs.PIC_Department_LU__c = u2.Id;
        insert cs;
        
        System.runAs(u) {
            Test.startTest();
            Test.setCurrentPage(Page.CaseRequestLayout_AGI);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AGI');
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseRequestLayout_AGI con = new CaseRequestLayout_AGI(stdController);
          con.IsMAGI = FALSE;
          con.IsAFI = FALSE;
            con.QueueDept = 'New Claim';
            con.selectedQueueDept = 'New Claim';
            con.availableCaseTypeKeeper = 'New Claim';
            con.selectedCaseTypeKeeper = 'New Claim';
            con.comment = 'comment';
            con.currentId = 'currentId';
            con.accId = 'accId';
            con.requestId = cs.Id;
            con.cs.Case_Type_Config__c = 'New Claim';
            con.cs.Product__c = 'Property - Commercial';
            con.cs.Business_channel__c = 'TM';
            con.save();
            con.SaveAndNew();
            con.cancel();
            Test.stopTest();
        }
    }
    
    static testMethod void caseComplaintLayoutControllerTestData() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'AGIComplaintCase'];
        
        String retURL = 'www.url.com/return';
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.OwnerId = u.Id;
        cs.Subject = 'Subject Test Case';
        cs.Entity_Backup__c = 'AGI';
        cs.Product__c = 'Health Group - Local (GSC)';
        cs.Business_channel__c = 'Agency Online';
        cs.Case_Type__c = 'Claim Delay';
        cs.Type = 'Complaint';
        cs.Origin = 'Email';
        insert cs;
        
        //System.runAs(u) {
            Test.startTest();
            Test.setCurrentPage(Page.CaseComplaintLayout_AGI);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AGI');
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseComplaintLayoutController_AGI con = new CaseComplaintLayoutController_AGI(stdController);
            con.availableCaseTypeKeeper = 'Claim Delay';
            con.selectedCaseTypeKeeper = 'Claim Delay';
            con.currentId = 'currentId';
            con.accId = 'accId';
          con.inquiryId = cs.Id;
            con.cs.Case_Type_Config__c = 'Claim Delay';
            con.cs.Product__c = 'Health Group - Local (GSC)';
            con.cs.Business_channel__c = 'Agency Online';
            con.save();
            con.SaveAndNew();
            con.cancel();
            Test.stopTest();
        //}
    }
}