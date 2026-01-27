@isTest
public class CaseComplaintLayoutNegativeFeedback_Test {
    @testSetup static void setTestData() {
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
            Agent__c = TRUE,
            Entity__c = 'AMFS'
        );
        insert u;
        
        
        User u2 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%AFI%' LIMIT 1].Id,
            LastName = 'TEST AFI',
            Email = 'testerAFI1@email.com',
            Username = 'testerAFI1827@email.com' + System.currentTimeMillis(),
            CompanyName = 'The Company',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            Agent__c = TRUE,
            Entity__c = 'AFI'
        );
        insert u2;
        
        Account a = new Account();
        a.Name = 'Account AMFS';
        a.Entity__c = 'AMFS';
        insert a;
        
        Contact c = new Contact();
        c.AccountId = a.Id;
        c.LastName = 'LastName';
        c.FirstName = 'FirstName';
        c.Entity__c = 'AMFS';
        insert c;
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.Subject = 'Subject T';
        cs.Type = 'Complaint';
        
        //added by Ranti at 2021/10/29
        // cs.Description__c = callLine[0].Call_Remarks__c;
        cs.Channel__c = 'Verbal (Call)';
        cs.Customer__c = 'Customer';
        cs.Complainant__c = 'Customer';
        cs.Priority = 'Medium';
        cs.Appeal__c = 'No';
        cs.Complaint_type__c = 'New';
        cs.Customer_type__c = 'Regular';
        insert cs;
        
        //--MCTR Default
        Master_Case_Type_Regional__c mctr0 = new Master_Case_Type_Regional__c();
        mctr0.Name = 'AMFS Default Case Type';
        mctr0.Entity__c = 'AMFS';
        mctr0.Product__c = '';
        mctr0.Business_Channel__c = '';
        mctr0.Active__c = TRUE;
        mctr0.Case_Type__c = '';
        mctr0.Type__c = '';
        
        mctr0.Department_Queue__c = 'Collection CR';
        mctr0.PIC_Department__c = u.Id;
        mctr0.TAT__c = 5;
        
        insert mctr0;
        
        //--MCTR Complaint
        Master_Case_Type_Regional__c mctr2 = new Master_Case_Type_Regional__c();
        mctr2.Name = 'Complaint-CS-Missing document';
        mctr2.Entity__c = 'AMFS';
        mctr2.Active__c = TRUE;
        mctr2.Case_Type__c = 'CS-Missing document';
        mctr2.Type__c = 'Complaint';
        
        mctr2.Department_Queue__c = 'Claim Property';
        mctr2.PIC_Department__c = u.Id;
        mctr2.TAT__c = 3;
        insert mctr2;
    }
    
    public static testmethod void caseComplaintLayoutNegativeFeedbackTest() {
        //Test.startTest();
        String caseComplaintLayoutVF = '/apex/CaseComplaintLayoutNegativeFeedback';
        String parentPageName = 'parentPageName';
        String firstLoad = 'firstLoad';
        String sourceContact = 'contact';
        String sourceEmail = 'email';
        String entity = 'MAGI';
        String ptype = 'Request';
        
        DescribeSObjectResult describeResultCase = Case.getSObjectType().getDescribe();
        List<String> caseFieldList = new List<String>(describeResultCase.fields.getMap().keySet());
        String caseFields = String.join(caseFieldList, ',');
        String caseQuery = ' SELECT ' + caseFields + ' FROM Case WHERE Type != :ptype ORDER BY CreatedDate DESC LIMIT 1 ';
        Case caseObj = Database.query(caseQuery);
        System.debug('***case_id: ' + caseObj.Id);
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest2';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com';
        contact1.MobilePhone = '0891667363';
        contact1.Policy_No__c = '100000012';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        PageReference pageRef = new PageReference(caseComplaintLayoutVF);
        pageRef.getParameters().put('parentPageName', parentPageName);
        pageRef.getParameters().put('RecordType', caseObj.RecordTypeId);
        pageRef.getParameters().put('cas5', caseObj.Type);
        pageRef.getParameters().put('retURL', '/' + caseObj.Id);
        pageRef.getParameters().put('firstLoad', firstLoad);
        pageRef.getParameters().put('entity', caseObj.Entity__c);
        pageRef.getParameters().put('cas11', sourceContact);
        pageRef.getParameters().put('cas3', contact1.Id);
        pageRef.getParameters().put('def_contact_id', contact1.Id);
        pageRef.getParameters().put('def_account_id', ac1.Id);
        Test.setCurrentPage(pageRef);
        
        Profile p = [SELECT Id FROM Profile WHERE Name = 'CMU-ALI' LIMIT 1];
        User u = new User(Alias = 'standt', Email='standarduser@axa.co.id', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@axa.co.id',
            Entity__c = 'ALI');
        insert u;
        System.debug('***u:' + u);
        caseObj.PIC_Department_LU__c = u.Id;
        ApexPages.StandardController sc = new ApexPages.StandardController(caseObj);
        CaseComplaintLayoutNegativeFeedback controller = new CaseComplaintLayoutNegativeFeedback(sc);
        
        Test.startTest();
        controller.save();
        //controller.SaveAndNew();
        controller.cancel();
        
        Test.stopTest();
    }
    
    public static testMethod void caseComplaintMasterCaseType_1() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'LastName'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'AMFSComplaintCase'];
        
        String retURL = 'www.url.com/return';
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.OwnerId = u.Id;
        cs.Subject = 'Subject Test Case';
        cs.Entity_Backup__c = 'AMFS';
        cs.Case_Type__c = 'CS-Missing document';
        cs.Type = 'Complaint';
        cs.Origin = 'Email';
        cs.PIC_Department_LU__c = u2.Id;
        cs.Category_Config__c = 'DC-Misrepresentation';
        //insert cs;
        
        
        System.runAs(u) {
            Test.startTest();
            Test.setCurrentPage(Page.CaseComplaintLayoutContact);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AMFS');
            Apexpages.currentPage().getParameters().put('cas5', 'Complaint');
            Apexpages.currentPage().getParameters().put('cas11', 'email');
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseComplaintLayoutNegativeFeedback con = new CaseComplaintLayoutNegativeFeedback(stdController);
            con.cs.Case_Type_Config__c = 'CS-Missing document';
            con.cs.Category_Config__c = 'CS-Missing document';
            con.save();
            Test.stopTest();
        }   
    }

    public static testMethod void caseComplaintMasterCaseType_2() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'LastName'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'AMFSComplaintCase'];
        
        String retURL = 'www.url.com/return';
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.OwnerId = u.Id;
        cs.Subject = 'Subject Test Case';
        cs.Entity_Backup__c = 'AMFS';
        cs.Case_Type__c = 'CS-Missing document';
        cs.Type = 'Complaint';
        cs.Origin = 'Email';
        cs.PIC_Department_LU__c = u2.Id;
        cs.Category_Config__c = 'DC-Misrepresentation';
        //insert cs;
        
        System.runAs(u) {
            Test.startTest();
            Test.setCurrentPage(Page.CaseComplaintLayoutContact);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AMFS');
            Apexpages.currentPage().getParameters().put('cas5', 'Complaint');
            Apexpages.currentPage().getParameters().put('cas11', 'email');
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseComplaintLayoutNegativeFeedback con = new CaseComplaintLayoutNegativeFeedback(stdController);
            con.cs.Case_Type_Config__c = 'CS-Missing document';
            con.cs.Category_Config__c = 'CS-Missing document';
            con.cs.Complaint_type__c = 'Soft Complaint';
            con.cs.ContactId = c.Id;
            con.save();
            con.SaveAndNew();
            Test.stopTest();
        }   
    }

    public static testMethod void caseComplaintMasterCaseType_3() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'LastName'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'AMFSComplaintCase'];
        
        String retURL = 'www.url.com/return';
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.OwnerId = u.Id;
        cs.Subject = 'Subject Test Case';
        cs.Entity_Backup__c = 'AMFS';
        cs.Case_Type__c = 'CS-Missing document';
        cs.Type = 'Complaint';
        cs.Origin = 'Email';
        cs.PIC_Department_LU__c = u2.Id;
        cs.Category_Config__c = 'DC-Misrepresentation';
        //insert cs;
        
        System.runAs(u) {
            Test.startTest();
            Test.setCurrentPage(Page.CaseComplaintLayoutContact);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AMFS');
            Apexpages.currentPage().getParameters().put('cas5', 'Complaint');
            Apexpages.currentPage().getParameters().put('cas11', 'email');
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseComplaintLayoutNegativeFeedback con = new CaseComplaintLayoutNegativeFeedback(stdController);
            con.cs.Case_Type_Config__c = 'CS-Missing document';
            con.cs.Channel__c = 'Walk IN';
            con.cs.Category_Config__c = 'CS-Missing document';
            con.cs.Complaint_type__c = 'Soft Complaint';
            con.cs.ContactId = c.Id;

            con.save();
            Test.stopTest();
        }   
    }
    
    public static testMethod void caseComplaintMasterCaseType_4() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id, Agent__c, Entity__c FROM User WHERE LastName = 'LastName'];
        u.Agent__c = TRUE;
        u.Entity__c = 'ALI';
        update u;
        User u2 = [SELECT Id FROM User WHERE LastName = 'LastName'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'AMFSComplaintCase'];
        
        String retURL = 'www.url.com/return';
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.OwnerId = u.Id;
        cs.Subject = 'Subject Test Case';
        cs.Entity_Backup__c = 'ALI';
        cs.Case_Type__c = 'CS-Missing document';
        cs.Type = 'Complaint';
        cs.Origin = 'Email';
        cs.PIC_Department_LU__c = u2.Id;
        cs.Category_Config__c = 'DC-Misrepresentation';
        //insert cs;
        
        System.runAs(u) {
            Test.startTest();
            Test.setCurrentPage(Page.CaseComplaintLayoutContact);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'ALI');
            Apexpages.currentPage().getParameters().put('cas5', 'Complaint');
            Apexpages.currentPage().getParameters().put('cas11', 'email');
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseComplaintLayoutNegativeFeedback con = new CaseComplaintLayoutNegativeFeedback(stdController);
            con.cs.Case_Type_Config__c = 'CS-Missing document';
            con.cs.Channel__c = 'Walk IN';
            con.cs.Category_Config__c = 'CS-Missing document';
            con.cs.Complaint_type__c = 'Soft Complaint';
            con.cs.ContactId = c.Id;

            con.save();
            Test.stopTest();
        }   
    }
    
    public static testMethod void caseRelatedCallLineTest(){
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id, Agent__c, Entity__c FROM User WHERE LastName = 'LastName'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'LastName'];
        String retURL = 'www.url.com/return';
        Call_List__c cmp = new Call_List__c();
        cmp.RecordTypeId = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
        cmp.Campaign_Name__c = 'Lapse TM';
        cmp.Activity__c = 'Collection';
        cmp.Case_Type_Config__c = 'Lapse TM';
        cmp.Expired_Date__c = System.today() + 100000;
        cmp.Entity__c = 'AMFS';
        Insert cmp;
        
        Call_Line__c cl = new Call_Line__c();
        cl.Contact__c = c.Id;
        cl.Call_List__c = cmp.Id;
        cl.Policy_No__c = '517-8475322';
        cl.Call_Remarks__c = 'Test Remarks Related';
        cl.Entity__c = 'AMFS';
        cl.OwnerId = u.Id;
        cl.Agent__c = u.Id;
        insert cl;

        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.OwnerId = u.Id;
        cs.Subject = 'Subject Test Case';
        cs.Entity_Backup__c = 'ALI';
        cs.Case_Type__c = 'CS-Missing document';
        cs.Type = 'Complaint';
        cs.Origin = 'Email';
        cs.PIC_Department_LU__c = u2.Id;
        cs.Category_Config__c = 'DC-Misrepresentation';
        
        System.runAs(u) {
            Test.startTest();
            Test.setCurrentPage(Page.CaseComplaintLayoutContact);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('entity', 'AMFS');
            Apexpages.currentPage().getParameters().put('cas5', 'Complaint');
            Apexpages.currentPage().getParameters().put('cas11', 'email');
            Apexpages.currentPage().getParameters().put('call_line', cl.Id);
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseComplaintLayoutNegativeFeedback con = new CaseComplaintLayoutNegativeFeedback(stdController);
            con.cs.Case_Type_Config__c = 'CS-Missing document';
            con.cs.Channel__c = 'Walk IN';
            con.cs.Category_Config__c = 'CS-Missing document';
            con.cs.Complaint_type__c = 'Soft Complaint';
            con.cs.ContactId = c.Id;

            con.validateCallLineRelated();
            Test.stopTest();
        }
    }
    
    
    /* public static testMethod void caseComplaintAFI() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'TEST AFI'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'TEST AFI'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'AFIComplaintCase'];
        
        String retURL = 'www.url.com/return';
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.OwnerId = u.Id;
        cs.Subject = 'Subject Test Case';
        cs.Entity_Backup__c = 'AFI'; 
        cs.Type = 'Complaint';
        cs.Origin = 'Email';
        cs.PIC_Department_LU__c = u2.Id; 
        //insert cs;
        
        
        System.runAs(u) {
            Test.startTest();
            
            
            Department__c d = new Department__c();
            d.name = 'test1';
            insert d;
            
            Named_User__c nu = new Named_User__c();
            nu.Name = 'test';
            nu.Department__c = d.id;
            insert nu;
            
            Test.setCurrentPage(Page.CaseComplaintLayoutContact);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AFI');
            Apexpages.currentPage().getParameters().put('cas5', 'Complaint');
            Apexpages.currentPage().getParameters().put('cas11', 'email');
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseComplaintLayoutNegativeFeedback con = new CaseComplaintLayoutNegativeFeedback(stdController); 
            con.cs.Complaint_type__c = 'Simple';
            con.cs.ContactId = c.Id;
            con.save();
            con.SaveAndNew();
            
            Case getCase = [Select id,OwnerId,Named_User__c,Division__c from case limit 1];
                
            ApexPages.StandardController stdController2 = new ApexPages.StandardController(getCase);
            popupUserOnCaseClass popCls = new popupUserOnCaseClass(stdController2);
            popCls.cic.Named_User__c = nu.id;
            popCls.updateCase();
             
            Test.stopTest();
        }   
    } */
   
}