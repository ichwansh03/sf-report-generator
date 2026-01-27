@isTest
public class CaseRequestLayoutNegativeFeedback_Test{
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
            Entity__c = 'AMFS'
        );
        insert u;
        
        User u2 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%AFI%' LIMIT 1].Id,
            LastName = 'LastName2',
            Email = 'tester2@email.com',
            Username = 'tester2@email.com' + System.currentTimeMillis(),
            CompanyName = 'The Company 2',
            Title = 'title2',
            Alias = 'alias2',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            Entity__c = 'AFI'
        );
        insert u2;
        
        User u3 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
            LastName = 'LastName3',
            Email = 'tester3@email.com',
            Username = 'tester3@email.com' + System.currentTimeMillis(),
            CompanyName = 'The Company 3',
            Title = 'title3',
            Alias = 'alias3',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            Entity__c = 'AFI'
        );
        insert u3;
        
        User u4 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
            LastName = 'LastName4',
            Email = 'tester4@email.com',
            Username = 'tester4@email.com' + System.currentTimeMillis(),
            CompanyName = 'The Company 4',
            Title = 'title4',
            Alias = 'alias4',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            Entity__c = 'AGI'
        );
        insert u4;
        
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
        
        Account a2 = new Account();
        a2.Name = 'Account AFI';
        a2.Entity__c = 'AFI';
        insert a2;
        
        Contact c2 = new Contact();
        c2.AccountId = a2.Id;
        c2.LastName = 'LastName2';
        c2.FirstName = 'FirstName2';
        c2.Entity__c = 'AFI';
        insert c2;
        
        Account a3 = new Account();
        a3.Name = 'Account AGI';
        a3.Entity__c = 'AGI';
        insert a3;
        
        Contact c3 = new Contact();
        c3.AccountId = a3.Id;
        c3.LastName = 'LastName3';
        c3.FirstName = 'FirstName3';
        c3.Entity__c = 'AGI';
        insert c3;
        
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
        
        //--MCTR Request
        Master_Case_Type_Regional__c mctr1 = new Master_Case_Type_Regional__c();
        mctr1.Name = 'Request_Claim';
        mctr1.Entity__c = 'AFI';
        mctr1.Active__c = TRUE;
        mctr1.Case_Type__c = 'Request_Claim';
        mctr1.Type__c = 'Request';
        
        mctr1.Department_Queue__c = 'Claim';
        mctr1.PIC_Department__c = u2.Id;
        mctr1.TAT__c = 5;
        insert mctr1;
        
        //--MCTR Request
        Master_Case_Type_Regional__c mctr2 = new Master_Case_Type_Regional__c();
        mctr2.Name = 'Request_Add Debit';
        mctr2.Entity__c = 'AMFS';
        mctr2.Active__c = TRUE;
        mctr2.Case_Type__c = 'Request_Add Debit';
        mctr2.Type__c = 'Request';
        
        mctr2.Department_Queue__c = 'CCC';
        mctr2.PIC_Department__c = u.Id;
        mctr2.TAT__c = 3;
        insert mctr2;
        
        //--MCTR Request
        Master_Case_Type_Regional__c mctr3 = new Master_Case_Type_Regional__c();
        mctr3.Name = 'New Claim';
        mctr3.Entity__c = 'AGI';
        mctr3.Active__c = TRUE;
        mctr3.Case_Type__c = 'New Claim';
        mctr3.Type__c = 'Request';
        
        mctr3.Department_Queue__c = 'Claim Lifestyle';
        mctr3.PIC_Department__c = u.Id;
        mctr3.TAT__c = 5;
        insert mctr3;
        
        Contact cont = new Contact();
        cont.Policy_No__c = '100-000-1110001';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP DMTM';
        insert cont;
        
        Id rtype = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
        Id usdRtype = Schema.SObjectType.User_Detail__c.getRecordTypeInfosByName().get('User Detail Collection AMFS').getRecordTypeId();
        
        Profile spvProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AMFS' limit 1];
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Outbound Agent %AMFS' or name like 'Inbound Agent %AMFS' limit 1]; 
        
        User us = new User(Alias = 'spv1', Email='spvAMFS@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='spvAMFSTEST', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = spvProfileAMFS.Id, Entity__c = 'AMFS', 
      			TimeZoneSidKey='Asia/Jakarta', UserName='spvAMFSTEST@axa.co.id');
        insert us;
        
        User agent = new User(Alias = 'agent1', Email='agentAMFSTEST@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentAMFSTEST', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = us.id, Entity__c = 'AMFS',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentAMFSTEST@axa.co.id', isActive = true, Agent__c = true,
                Outbound_Activity_Case_type__c = 'Collection');
        insert agent;
        
        User_Detail__c ud = new User_Detail__c();
        ud.Name = 'TEST';
        ud.User__c = agent.id;
        ud.Outbound_Activity_Case_type__c = 'Collection - Redemption Konven';
        ud.Entity__c = 'AMFS';
        ud.Subject_Case__c = 'ILCCYS';
        insert ud;
        
        Call_List__c cl = new Call_List__c();
        cl.RecordTypeId = rtype;
        cl.Activity__c = 'Collection';
        //cl.Case_Type__c = 'Lapse Konven';			//update 11/09/2020 - ganti jadi "Redemption Konven"
        cl.Case_Type__c = 'Redemption Konven';
        cl.Expired_Date__c = system.today() + 30;
        cl.Entity__c = 'AMFS';
        //cl.Campaign_Name__c = 'Lapse Konven';
        //cl.Campaign_Name__c = 'Lapse Konven';
        cl.Campaign_Name__c = 'Redemption Konven';
        cl.Activity__c = 'Collection';
        insert cl;
        
        Call_Line__c cLine = new Call_Line__c();
        cLine.Call_List__c = cl.id;
        cLine.ownerid = us.id;
        cLine.Activity__c = 'Collection';
        cLine.Policy_No__c = '100-000-1110001';
        cLine.Agent__c  = agent.Id;
        cLine.Call_Remarks__c = 'OK';
        cLine.Entity__c = 'AMFS';
        cLine.APE__c = 1000;
        cLine.Currency__c = 'IDR';
        insert cLine;
        
        Master_legal__c insertLegal = new Master_legal__c();
            insertLegal.Name = 'Test 1';
            insertLegal.Jenis_Trx__c = 'Perubahan Data';
            insertLegal.Case_Type__c = 'Request_Up Date Data Email address';
            insertLegal.DepartmentId__c = 'CCC';
            insertLegal.Description__c  = 'Test';
        insert insertLegal;
    }
    
    /*public static testMethod void testCaseRequest() {
        string afiRecType = '';
        string amfsRecType = '';
        string magiRecType = '';
        
        
        List<RecordType> caseRecordTypeList = [SELECT Name, Id, DeveloperName, SobjectType FROM RecordType where SobjectType = 'Case' and name like 'Request%'];
        for(RecordType rt: caseRecordTypeList){
            if(rt.name.indexof('AFI')!=-1){
                afiRecType = rt.Id;  
            }else if(rt.name.indexof('AMFS')!=-1){
                amfsRecType = rt.Id;  
            }else if(rt.name.indexof('MAGI')!=-1){
                magiRecType = rt.Id;  
            }
        }
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like '%Agent%AFI' limit 1];
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like '%Agent%AMFS' limit 1]; 
        Profile agentProfileMAGI = [SELECT Id FROM Profile WHERE Name like '%Agent%MAGI' limit 1];
        
        Profile spvProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AFI' limit 1]; 
        Profile spvProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AMFS' limit 1]; 
        Profile spvProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%MAGI' limit 1]; 
        
        List<User> spvList = new List<User>();
        User loginAFIUser = new User(Alias = 'spv1', Email='spvAfi@axa.co.id', 
                                     EmailEncodingKey='UTF-8', LastName='spvAfi', LanguageLocaleKey='en_US', 
                                     LocaleSidKey='en_US', ProfileId = spvProfileAFI.Id, Entity__c = 'AFI', 
                                     TimeZoneSidKey='Asia/Jakarta', UserName='spvAfi@axa.co.id');
        spvList.add(loginAFIUser);

        User loginAMFSUser = new User(Alias = 'spv2', Email='spvAmfs@axa.co.id', 
                                      EmailEncodingKey='UTF-8', LastName='spvAmfs', LanguageLocaleKey='en_US', 
                                      LocaleSidKey='en_US', ProfileId = spvProfileAMFS.Id, Entity__c = 'AMFS', 
                                      TimeZoneSidKey='Asia/Jakarta', UserName='spvAmfs@axa.co.id');
        spvList.add(loginAMFSUser);
        
        User loginMAGIUser = new User(Alias = 'spv3', Email='spvMagi@axa.co.id', 
                                      EmailEncodingKey='UTF-8', LastName='spvMagi', LanguageLocaleKey='en_US', 
                                      LocaleSidKey='en_US', ProfileId = spvProfileMAGI.Id, Entity__c = 'MAGI', 
                                      TimeZoneSidKey='Asia/Jakarta', UserName='spvMagi@axa.co.id');
        spvList.add(loginMAGIUser);
        insert spvList;
        
        List<User> agentList = new List<User>();
        User subOrdinateAFIUser = new User(Alias = 'agent1', Email='agentAfi@axa.co.id', 
                                           EmailEncodingKey='UTF-8', LastName='agentAfi', LanguageLocaleKey='en_US', 
                                           LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, managerId = loginAFIUser.id, Entity__c = 'AFI',
                                           TimeZoneSidKey='Asia/Jakarta', UserName='agentAfi@axa.co.id', isActive = true, Agent__c = true);
        agentList.add(subOrdinateAFIUser);
        
        User subOrdinateAMFSUser = new User(Alias = 'agent2', Email='agentAmfs@axa.co.id', 
                                            EmailEncodingKey='UTF-8', LastName='agentAmfs', LanguageLocaleKey='en_US', 
                                            LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = loginAMFSUser.id, Entity__c = 'AMFS',
                                            TimeZoneSidKey='Asia/Jakarta', UserName='agentAmfs@axa.co.id', isActive = true, Agent__c = true);
        agentList.add(subOrdinateAMFSUser);
        
        User subOrdinateMAGIUser = new User(Alias = 'agent3', Email='agentMagi@axa.co.id', 
                                            EmailEncodingKey='UTF-8', LastName='agentMagi', LanguageLocaleKey='en_US', 
                                            LocaleSidKey='en_US', ProfileId = agentProfileMAGI.Id, managerId = loginMAGIUser.id, Entity__c = 'MAGI',
                                            TimeZoneSidKey='Asia/Jakarta', UserName='agentMagi@axa.co.id', isActive = true, Agent__c = true);
        agentList.add(subOrdinateMAGIUser);
        insert agentList;
        
        List<Account> accList = new List<Account>();
        Account acc = new Account();
        acc.Name = 'Account AMFS';
        accList.add(acc);
        insert accList;
        
        List<Contact> conList = new List<Contact>();
        Contact con = new Contact();
        con.FirstName = 'Hamfry';
        con.LastName = 'Lantu';
        con.email = 'hamfry@saasten.com';
        con.Entity__c = 'AMFS';
        con.AccountId = acc.Id;
        conList.add(con);
        
        insert conList;
        
        List<Case> caseList = new List<Case>();
        Case cs1 = new Case();
        //cs1.ContactId = con.Id;
        cs1.Status = 'New';
        cs1.type = 'Request';
        cs1.Priority = 'Simple Case';
        //cs1.Service_Type__c = 'Helpline';
        cs1.origin = 'Phone';
        cs1.Entity_Backup__c = 'AMFS';
        cs1.Related_Departments__c = 'Quick Response';
        cs1.Case_Type__c = 'Request_QRO_Info Manfaat Polis';
        cs1.Case_Type_Config__c = 'Request_QRO_Info Manfaat Polis';
        cs1.Subject = 'Testing only';
        cs1.Description = 'Not for Sale';
        cs1.OwnerId = loginAMFSUser.Id;
        cs1.PIC_Department_LU__c = subOrdinateAMFSUser.Id;
        //cs1.accountId = acc.Id;
        cs1.RecordTypeId = amfsRecType;
        cs1.Non_Inquiry__c = true;
        cs1.Follow_Hold_Date__c = Date.today();
        caseList.add(cs1);
        
        insert caseList;
        
        system.runAs(loginAMFSUser){
            
            Test.startTest();
            Apexpages.currentPage().getParameters().put('cas3', null);
            Apexpages.currentPage().getParameters().put('RecordType', amfsRecType);
            Apexpages.currentPage().getParameters().put('cas5', 'Request'); 
            Apexpages.currentPage().getParameters().put('retURL', '/' + cs1.Id);
            Apexpages.currentPage().getParameters().put('cas11', 'email');
            
            ApexPages.StandardController sc2 = new ApexPages.StandardController(cs1);
            CaseRequestLayoutNegativeFeedback caseRequest2 = new CaseRequestLayoutNegativeFeedback(sc2);
            caseRequest2.cs.Status = 'New';
            caseRequest2.cs.type = 'Request';
            caseRequest2.cs.Priority = 'Simple Case';
            //cs1.Service_Type__c = 'Helpline';
            caseRequest2.cs.origin = 'Phone';
            caseRequest2.cs.Entity_Backup__c = 'AMFS';
            caseRequest2.cs.Related_Departments__c = 'Quick Response';
            caseRequest2.cs.Case_Type_Config__c = 'Request_QRO_Info Manfaat Polis';
            caseRequest2.cs.Request_Type_Phone__c = 'Request_QRO_Info Manfaat Polis';
            caseRequest2.cs.Subject = 'Testing only';
            caseRequest2.cs.Description = 'Not for Sale';
            caseRequest2.cs.PIC_Department_LU__c = subOrdinateAMFSUser.Id;
            //cs1.accountId = acc.Id;
            caseRequest2.cs.RecordTypeId = amfsRecType;
            caseRequest2.cs.Non_Inquiry__c = true;
            caseRequest2.cs.Follow_Hold_Date__c = Date.today();
            caseRequest2.cs.Date_of_Service__c = Date.today();
            caseRequest2.onChangeDateOfService();
            caseRequest2.cs.Date_of_Service__c = Date.today().addDays(1);
            caseRequest2.onChangeDateOfService();
            
            caseRequest2.departmentChange();
            caseRequest2.followHoldDateConfirmationDisplay();
            caseRequest2.put_req_type();
            caseRequest2.getCekCourier();
            caseRequest2.save();
            caseRequest2.cancel();
            
            ApexPages.currentPage().getParameters().put('def_contact_id', con.Id);
            ApexPages.currentPage().getParameters().put('def_account_id', acc.Id);
            Apexpages.currentPage().getParameters().put('cas5', 'Request'); 
            Apexpages.currentPage().getParameters().put('retURL', '/' + cs1.Id);
            Apexpages.currentPage().getParameters().put('cas11', 'none');
            
            ApexPages.StandardController sc3 = new ApexPages.StandardController(cs1);
            CaseRequestLayoutNegativeFeedback caseRequest3 = new CaseRequestLayoutNegativeFeedback(sc3);
            caseRequest3.save();
            caseRequest3.cancel();
            
            Test.stopTest();
            caseRequest2.SaveAndNew();
        }
    }*/
    
    public static testMethod void caseRequestCallBackTest() {
        Account acc = [SELECT Id FROM Account WHERE Name = 'Account AMFS'];
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'LastName'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'RequestAMFSCase'];
        
        String retURL = 'www.url.com/return';
        
        System.runAs(u) {
            Case cs = new Case();
            cs.recordTypeId = rt.Id;
            //cs.ContactId = c.Id;
            cs.OwnerId = u.Id;
            //cs.Subject = 'ILCCHIK';
            cs.Subject = 'ILCCKAI';	// updated subject type - 11/09/2020
            cs.Entity_Backup__c = 'AMFS';
            cs.Case_Type__c = 'Request_Add Debit';
            cs.Case_Type_Config__c = 'Request_Add Debit';
            cs.Request_Type__c = 'Request_Add Debit';
            cs.Type = 'Request';
            cs.Origin = 'Email';
            cs.PIC_Department_LU__c = u2.Id;
            insert cs;
            
            
            Test.startTest();
            Test.setCurrentPage(Page.CaseRequestLayoutContact);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AMFS');
            Apexpages.currentPage().getParameters().put('cas5', 'Request'); 
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseRequestLayoutNegativeFeedback con = new CaseRequestLayoutNegativeFeedback(stdController);
            con.IsMagi = false;
            con.Department = 'Collection & CR';
            con.confirmationMessage = '';
            con.typeLegalAMFS = '';
            con.descLegalAMFS = '';
            con.cs.Case_Type_Config__c = 'Request_Collection CR_Redemption';
            con.save();
            
            Apexpages.currentPage().getParameters().put('cas3', null);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('cas5', 'Request'); 
            Apexpages.currentPage().getParameters().put('retURL', '/' + cs.Id);
            Apexpages.currentPage().getParameters().put('cas11', 'email');
            
            ApexPages.StandardController sc2 = new ApexPages.StandardController(cs);
            CaseRequestLayoutNegativeFeedback caseRequest2 = new CaseRequestLayoutNegativeFeedback(sc2);
            caseRequest2.cs.Status = 'New';
            caseRequest2.cs.type = 'Request';
            caseRequest2.cs.Priority = 'Simple Case';
            //cs1.Service_Type__c = 'Helpline';
            caseRequest2.cs.origin = 'Phone';
            caseRequest2.cs.Entity_Backup__c = 'AMFS';
            caseRequest2.cs.Related_Departments__c = 'Quick Response';
            caseRequest2.cs.Case_Type_Config__c = 'Request_QRO_Info Manfaat Polis';
            caseRequest2.cs.Request_Type_Phone__c = 'Request_QRO_Info Manfaat Polis';
            caseRequest2.cs.Subject = 'Testing only';
            caseRequest2.cs.Description = 'Not for Sale';
            //caseRequest2.cs.PIC_Department_LU__c = subOrdinateAMFSUser.Id;
            cs.accountId = acc.Id;
            caseRequest2.cs.RecordTypeId = rt.Id;
            caseRequest2.cs.Non_Inquiry__c = true;
            caseRequest2.cs.Follow_Hold_Date__c = Date.today();
            caseRequest2.cs.Date_of_Service__c = Date.today();
            caseRequest2.onChangeDateOfService();
            caseRequest2.cs.Date_of_Service__c = Date.today().addDays(1);
            caseRequest2.onChangeDateOfService();
            caseRequest2.sendEmail();
            caseRequest2.departmentChange();
            caseRequest2.followHoldDateConfirmationDisplay();
            caseRequest2.put_req_type();
            caseRequest2.getCekCourier();
            caseRequest2.save();
            caseRequest2.cancel();
            caseRequest2.actionSaveAndNew();
            
            ApexPages.currentPage().getParameters().put('def_contact_id', c.Id);
            ApexPages.currentPage().getParameters().put('def_account_id', acc.Id);
            Apexpages.currentPage().getParameters().put('cas5', 'Request'); 
            Apexpages.currentPage().getParameters().put('retURL', '/' + cs.Id);
            Apexpages.currentPage().getParameters().put('cas11', 'none');
            
            ApexPages.StandardController sc3 = new ApexPages.StandardController(cs);
            CaseRequestLayoutNegativeFeedback caseRequest3 = new CaseRequestLayoutNegativeFeedback(sc3);
            caseRequest3.save();
            caseRequest3.cancel();
            caseRequest3.confirmationDisplayYes();
            caseRequest3.confirmationDisplayNo();
            Test.stopTest();
        }
    }
    
    public static testMethod void caseRequestMasterCaseType_1() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'LastName'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'RequestAMFSCase'];
        
        String retURL = 'www.url.com/return';
        
        System.runAs(u) {
            Case cs = new Case();
            cs.recordTypeId = rt.Id;
            //cs.ContactId = c.Id;
            cs.OwnerId = u.Id;
            //cs.Subject = 'ILCCHIK';
            cs.Subject = 'ILCCKAI';	// updated subject type - 11/09/2020
            cs.Entity_Backup__c = 'AMFS';
            cs.Case_Type__c = 'Request_Add Debit';
            cs.Case_Type_Config__c = 'Request_Add Debit';
            cs.Request_Type__c = 'Request_Add Debit';
            cs.Type = 'Request';
            cs.Origin = 'Email';
            cs.PIC_Department_LU__c = u2.Id;
            insert cs;
                  
        
            Test.startTest();
            Test.setCurrentPage(Page.CaseRequestLayoutContact);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AMFS');
            Apexpages.currentPage().getParameters().put('cas5', 'Request'); 
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseRequestLayoutNegativeFeedback con = new CaseRequestLayoutNegativeFeedback(stdController);
            con.IsMagi = false;
            con.Department = 'DMU';
            con.confirmationMessage = '';
            con.typeLegalAMFS = '';
            con.descLegalAMFS = '';
            con.cs.Case_Type_Config__c = 'Request_CCC_Call Back Customer';
            con.cs.request_type_phone__c = 'Request_CCC_Call Back Customer';
            con.save();
            Test.stopTest();
        }  
    }
    
    public static testMethod void caseRequestMasterCaseType_9() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'LastName'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'RequestAMFSCase'];
        
        String retURL = 'www.url.com/return';
        
        System.runAs(u) {
            Case cs = new Case();
            cs.recordTypeId = rt.Id;
            //cs.ContactId = c.Id;
            cs.OwnerId = u.Id;
            //cs.Subject = 'ILCCHIK';
            cs.Subject = 'ILCCKAI';	// updated subject type - 11/09/2020
            cs.Entity_Backup__c = 'AMFS';
            cs.Case_Type__c = 'Request-Reschedule-CR-Withdrawal';
            cs.Case_Type_Config__c = 'Request-Reschedule-CR-Withdrawal';
            cs.Request_Type__c = 'Request_Add Debit';
            cs.Type = 'Request';
            cs.Origin = 'Email';
            cs.PIC_Department_LU__c = u2.Id;
            cs.Policy_No__c = '123-4567890';
            insert cs;
            
            Campaign_Type_Mapping__c campaign = new Campaign_Type_Mapping__c();
            Campaign.Campaign_Type__c = 'Collection-Redemption Konven';
            Campaign.Case_Type__c = 'Request-Reschedule CR Redemption';
            Campaign.Name = 'Collection-Redemption Konven';
            insert Campaign;
            
            Campaign_Type_Mapping__c campaign2 = new Campaign_Type_Mapping__c();
            Campaign2.Campaign_Type__c = 'Collection-Withdrawal';
            Campaign2.Case_Type__c = 'Request-Reschedule-CR-Withdrawal';
            Campaign2.Name = 'Collection-Withdrawal';
            insert Campaign2;
                  
        
            Test.startTest();
            Test.setCurrentPage(Page.CaseRequestLayoutContact);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AMFS');
            Apexpages.currentPage().getParameters().put('cas5', 'Request'); 
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseRequestLayoutNegativeFeedback con = new CaseRequestLayoutNegativeFeedback(stdController);
            con.IsMagi = false;
            con.Department = 'DMU';
            con.confirmationMessage = '';
            con.typeLegalAMFS = '';
            con.descLegalAMFS = '';
            con.selectedDate = Date.today();
            con.selectedTimeRange = '10:00';
            con.cs.Case_Type_Config__c = 'Request-Reschedule-CR-Withdrawal';
            con.cs.request_type_phone__c = 'Request-Reschedule-CR-Withdrawal';
            con.cs.Policy_No__c = '123-4567890';
            
            /*
            List<Call_line__C> callLineLs = new List<Call_line__C>();
            Call_Line__c calin = new Call_Line__c(
                Call_Status_Config__c = 'F',
                Policy_No__c = '123-4567890',
                Contact__c = c.Id,
                Case_Type__c = 'Request-Reschedule-CR-Withdrawal',
                Case_Type_Config__c = 'Request-Reschedule-CR-Withdrawal',
                Contacted_Number__c = '1234567890',
                
                Entity__c = 'AMFS');
            callLineLs.add(calin);
            insert callLineLs;
            */
            
            con.save();
            con.SaveAndNew();
            Test.stopTest();
        }  
    }
    
    public static testMethod void caseRequestMasterCaseType_2() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName2'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName3'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'LastName2'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'RequestAFICase'];
        
        String retURL = 'www.url.com/return';
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.OwnerId = u.Id;
        //cs.Subject = 'ILCCHIK';
        cs.Subject = 'ILCCKAI';	// updated subject type - 11/09/2020
        cs.Entity_Backup__c = 'AFI';
        cs.Case_Type__c = 'Request_Claim';
        cs.Type = 'Request';
        cs.Origin = 'Phone';
        cs.PIC_Department_LU__c = u2.Id;
        //insert cs;
        
        System.runAs(u) {
            Test.startTest();
            Test.setCurrentPage(Page.CaseRequestLayoutContact);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AFI');
            Apexpages.currentPage().getParameters().put('cas5', 'Request'); 
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseRequestLayoutNegativeFeedback con = new CaseRequestLayoutNegativeFeedback(stdController);
        	con.availableCaseTypeKeeper = 'Request_Claim';
        	con.selectedCaseTypeKeeper = 'Request_Claim';
        	con.comment = 'comment';
            con.cs.Case_Type_Config__c = 'Request_Claim';
            con.save();
            Test.stopTest();
        } 
    }
    
    public static testMethod void caseRequestMasterCaseType_3() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName3'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName4'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'LastName2'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'RequestAGICase'];
        
        String retURL = 'www.url.com/return';
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.OwnerId = u.Id;
        //cs.Subject = 'ILCCHIK';
        cs.Subject = 'ILCCKAI';	// updated subject type - 11/09/2020
        cs.Entity_Backup__c = 'AGI';
        cs.Case_Type__c = 'New Claim';
        cs.Type = 'Request';
        cs.Origin = 'Phone';
        cs.PIC_Department_LU__c = u2.Id;
        //insert cs;
        
        System.runAs(u) {
            Test.startTest();
            Test.setCurrentPage(Page.CaseRequestLayoutContact);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AGI');
            Apexpages.currentPage().getParameters().put('cas5', 'Request'); 
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseRequestLayoutNegativeFeedback con = new CaseRequestLayoutNegativeFeedback(stdController);
        	con.availableCaseTypeKeeper = 'New Claim';
        	con.selectedCaseTypeKeeper = 'New Claim';
        	con.comment = 'comment';
            con.cs.Case_Type_Config__c = 'New Claim';
            con.save();
            Test.stopTest();
        } 
    }
    
    // added by Ranti MII at 16/6/2023
    public static testMethod void caseRequestMasterCaseType_4() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'LastName'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'RequestAMFSCase'];
        
        String retURL = 'www.url.com/return';
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.OwnerId = u.Id;
        //cs.Subject = 'ILCCHIK';
        cs.Subject = 'ILCCKAI';	// updated subject type - 11/09/2020
        cs.Entity_Backup__c = 'AMFS';
        cs.Case_Type__c = 'Request_Up Date Data Email address';
        cs.Type = 'Request';
        cs.Origin = 'Phone';
        cs.Related_Departments__c = 'CCC';
        cs.PIC_Department_LU__c = u2.Id;
        //insert cs;
        
        System.runAs(u) {
            Test.startTest();
            Test.setCurrentPage(Page.CaseRequestLayoutContact);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AMFS');
            Apexpages.currentPage().getParameters().put('cas5', 'Request'); 
            Apexpages.currentPage().getParameters().put('paramOrigin', 'Phone'); 
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseRequestLayoutNegativeFeedback con = new CaseRequestLayoutNegativeFeedback(stdController); 
            con.getLegalStatement();
            con.put_req_type();
            con.put_param_origin();
            con.setOriginAMFS();
            Test.stopTest();
        } 
    }
    
    public static testMethod void caseRequestMasterCaseType_5() {
        Contact c = [SELECT Id FROM Contact WHERE LastName = 'LastName'];
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        User u2 = [SELECT Id FROM User WHERE LastName = 'LastName'];
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'RequestAMFSCase'];
        
        String retURL = 'www.url.com/return';
        
        Case cs = new Case();
        cs.ContactId = c.Id;
        cs.OwnerId = u.Id;
        //cs.Subject = 'ILCCHIK';
        cs.Entity_Backup__c = 'AMFS';
        cs.Case_Type__c = 'Request_Up Date Data Email address';
        cs.Type = 'Request';
        cs.Origin = 'Phone';
        cs.Related_Departments__c = 'CCC';
        cs.PIC_Department_LU__c = u2.Id;
        //insert cs;
        
        System.runAs(u) {
            Test.startTest();
            Test.setCurrentPage(Page.CaseRequestLayoutContact);
            Apexpages.currentPage().getParameters().put('retURL', retURL);
            Apexpages.currentPage().getParameters().put('RecordType', rt.Id);
            Apexpages.currentPage().getParameters().put('entity', 'AMFS');
            Apexpages.currentPage().getParameters().put('cas5', 'Request'); 
            Apexpages.currentPage().getParameters().put('paramOrigin', 'Phone'); 
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
            CaseRequestLayoutNegativeFeedback con = new CaseRequestLayoutNegativeFeedback(stdController); 
            con.getLegalStatement();
            con.put_req_type();
            con.put_param_origin();
            con.setOriginAMFS();
            Test.stopTest();
        } 
    }
}