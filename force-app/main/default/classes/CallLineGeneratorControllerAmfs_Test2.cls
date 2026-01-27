@isTest
public class CallLineGeneratorControllerAmfs_Test2 {
    
    static ID rtCustSegCampaign = Schema.SObjectType.Call_list__c.getRecordTypeInfosByName().get('Customer Segmentation AMFS').getRecordTypeId();
    static ID rtConfirmationAMFS = Schema.SObjectType.Call_list__c.getRecordTypeInfosByName().get('Confirmation AMFS').getRecordTypeId();
    static ID rtCallLineWC = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
    static ID rtCallLineAMFS1 = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('AMFS 1').getRecordTypeId();
    static ID rtype = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
    static ID usdRtype = Schema.SObjectType.User_Detail__c.getRecordTypeInfosByName().get('User Detail Collection AMFS').getRecordTypeId();
    static Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Outbound Agent%AMFS' limit 1];
    static Profile spvProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AMFS' limit 1]; 
    
    @TestSetup
    static void makeData(){
        
        User us = new User(Alias = 'spv1', Email='spvAMFS@axa.co.id', 
                           EmailEncodingKey='UTF-8', LastName='spvAMFSTEST', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = spvProfileAMFS.Id, Entity__c = 'AMFS', 
                           TimeZoneSidKey='Asia/Jakarta', UserName='spvAMFSTEST1@axa.co.id');
        insert us;
        
        User agent = new User(Alias = 'agent1', Email='agentAMFSTEST@axa.co.id', 
                              EmailEncodingKey='UTF-8', LastName='agentAMFSTEST', LanguageLocaleKey='en_US', 
                              LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = us.id, Entity__c = 'AMFS',
                              TimeZoneSidKey='Asia/Jakarta', UserName='agentAMFSTEST1@axa.co.id', isActive = true, Agent__c = true,
                              Outbound_Activity_Case_type__c = 'Collection');
        insert agent;
        
        User agent2 = new User(Alias = 'agent1', Email='agentAMFSTEST12@axa.co.id', 
                              EmailEncodingKey='UTF-8', LastName='agentAMFSTEST', LanguageLocaleKey='en_US', 
                              LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = us.id, Entity__c = 'AMFS',
                              TimeZoneSidKey='Asia/Jakarta', UserName='agentAMFSTEST12@axa.co.id', isActive = true, Agent__c = true,
                              Outbound_Activity_Case_type__c = 'Collection');
        insert agent2;
        
        
        User agent3 = new User(Alias = 'agent1', Email='agentAMFSTEST123@axa.co.id', 
                              EmailEncodingKey='UTF-8', LastName='agentAMFSTEST', LanguageLocaleKey='en_US', 
                              LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = us.id, Entity__c = 'AMFS',
                              TimeZoneSidKey='Asia/Jakarta', UserName='agentAMFSTEST123@axa.co.id', isActive = true, Agent__c = true,
                              Outbound_Activity_Case_type__c = 'Collection');
        insert agent3;
        
        //Insert Account
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Entity__c = 'AMFS';
        Insert acc;
        
        //Insert Contact
        Contact con = new Contact();
        con.LastName = 'test mus';
        con.AccountId = acc.Id;
        con.Policy_No__c = 'AMFS001';
        con.Entity__c = 'AMFS';
        con.Email = 'musmus@gmail.com';
        con.MobilePhone = '123456789';
        con.HomePhone = '123456789';
        Insert con;
        
        
        
        //Insert Contact
        Contact con2 = new Contact();
        con2.LastName = 'test mus';
        con2.AccountId = acc.Id;
        con2.Policy_No__c = '517-8475322';
        con2.Entity__c = 'AMFS';
        con2.Email = 'musmus@gmail.com';
        con2.MobilePhone = '123456789';
        con2.HomePhone = '123456789';
        Insert con2;
        
        User_Detail__c ud = new User_Detail__c();
        ud.Name = 'TEST';
        ud.User__c = agent.id;
        ud.Outbound_Activity_Case_type__c = 'Collection - Redemption TM';
        insert ud;
        
        
        User_Detail__c ud2 = new User_Detail__c();
        ud2.Name = 'TEST';
        ud2.User__c = agent2.id;
        ud2.Outbound_Activity_Case_type__c = 'Collection - Redemption TM';
        insert ud2;
        
        User_Detail__c ud3 = new User_Detail__c();
        ud3.Name = 'TEST';
        ud3.User__c = agent3.id;
        ud3.Outbound_Activity_Case_type__c = 'Collection - Redemption TM';
        insert ud3;
        
        Call_List__c cl = new Call_List__c();
        cl.RecordTypeId = rtype;
        cl.Activity__c = 'Collection';
        cl.Case_Type__c = 'Redemption TM';
        cl.Expired_Date__c = system.today() + 30;
        cl.Entity__c = 'AMFS';
        cl.Campaign_Name__c = 'Redemption TM';
        insert cl;
        
        Call_Line__c cLine = new Call_Line__c();
        cLine.Call_List__c = cl.id;
        cLine.ownerid = us.id;
        cLine.Activity__c = 'Collection';
        cLine.Policy_No__c = 'AMFS001';
        cLine.APE_Total_Child__c = 100000;
        cLine.Agent__c  = agent.Id;
        cLine.Call_Remarks__c = 'OK';
        cLine.Entity__c = 'AMFS';
        cLine.APE__c = 1000;
        cLine.Currency__c = 'IDR';
        insert cLine;
        
        
        //Insert Call Line
        Call_Line__c cl2 = new Call_Line__c();
        cl2.Call_Status_Config__c = 'Hold';
        cl2.Policy_No__c = con.Policy_No__c;
        cl2.Contact__c = con2.Id;
        cl2.Remark_Hold_Debet__c = 'test';
        cl2.Call_List__c = cl.Id;
        cl2.OwnerId = us.Id;
        cl2.APE_Total_Child__c = 1000000;
        cl2.Entity__c = 'AMFS';
        cl2.Activity__c = 'Collection';
        cl2.Policy_No__c = 'test';
        cl2.Contacted_Number__c = '123456789';
        cl2.Home_Phone__c = '1234567'; 
        Insert cl2;
        
        //Insert Call Line
        Call_Line__c cl3 = new Call_Line__c();
        cl3.Call_Status_Config__c = 'Hold';
        cl3.Policy_No__c = '517-8400022';
        cl3.Contact__c = con.Id;
        cl3.Remark_Hold_Debet__c = 'test';
        cl3.Call_List__c = cl.Id;
        cl3.OwnerId = us.Id; 
        cl3.APE_Total_Child__c = 1000000;
        cl3.Entity__c = 'AMFS';
        cl3.Activity__c = 'Collection';
        cl3.Policy_No__c = 'test';
        cl3.Contacted_Number__c = '123456789';
        cl3.Home_Phone__c = '1234567';
        Insert cl3; 
    }

    @isTest
    static void UploadFile() {
        Test.startTest();  
            Call_List__c cmp = [SELECT Id, RecordTypeId, Campaign_Name__c, Activity__c, Case_Type_Config__c, Expired_Date__c, Entity__c, IsExpired__c, job_id__c FROM Call_List__c LIMIT 1];
            //Insert Document
            CallLineGeneratorControllerAMFS cgc = new CallLineGeneratorControllerAMFS();
            cgc.choosen_campaign = cmp.Id;

            Document testDocument = cgc.document;
            testDocument.Body = Blob.valueOf('1234567890,"""\' 123456789,"""\' dan \'""\' hehehe ","""\' 123456789,"""\' 123456789');
            testDocument.Name = 'test.csv';
            cgc.campaign_check = cmp; 
            cgc.campaignTarget = 10;
        Test.stopTest();
    }

    @isTest
    static void test2() {
        Test.startTest();  
            User usr = [SELECT Id FROM User limit 1];
            CallLineGeneratorControllerAMFS.tempUserAssignment cgcT = new CallLineGeneratorControllerAMFS.tempUserAssignment();
            cgcT.Agent_Id = usr.Id;
            cgcT.totalAPE = 12345;
            cgcT.totalPolicy = 12345;
            
            CallLineGeneratorControllerAMFS.CollectionTask cgcC = new CallLineGeneratorControllerAMFS.CollectionTask();
            cgcC.Amount = '';
            cgcC.AmountCurrency = '';
            cgcC.BatchNo = '';
            cgcC.CaseType = '';
            cgcC.HomePhone = '';
            cgcC.infoPending = '';
            cgcC.MobilePhone = '';
            cgcC.OtherPhone = '';
            cgcC.parentId = '';
            cgcC.PolicyNo = '';
            
            CallLineGeneratorControllerAMFS.OutboundCall cgcO = new CallLineGeneratorControllerAMFS.OutboundCall();
            cgcO.agentId = '';
            cgcO.agentName = '';
            cgcO.campaignName = 'Lapse TM';
            cgcO.phoneNo = '';
            cgcO.policyNo = '';
            
            CallLineGeneratorControllerAMFS.AgentAssignment cgcA = new CallLineGeneratorControllerAMFS.AgentAssignment();
            cgcA.agentId = '';
            cgcA.agentName = '';
            cgcA.apeDistributed = 12345;
            cgcA.policyTotal = 12345;
            cgcA.StringAPE_Distributed = '';
        Test.stopTest();
    }

    @isTest
    static void trueTest() {
        Test.startTest(); 
              
            CallLineGeneratorControllerAMFS.invalidPolicy cgcI = new CallLineGeneratorControllerAMFS.invalidPolicy('policyNo','status');
            Call_List__c cmp = [SELECT Id, RecordTypeId, Campaign_Name__c, Activity__c, Case_Type_Config__c, Expired_Date__c, Entity__c, IsExpired__c, job_id__c FROM Call_List__c LIMIT 1];
            //Insert Document
            CallLineGeneratorControllerAMFS cgc = new CallLineGeneratorControllerAMFS();
            cgc.choosen_campaign = cmp.Id;
            cgc.Upload();
            cgc.parseCollectionTaskCSV('1234567890,"""\' 123456789,"""\' dan \'""\' hehehe ","""\' 123456789,"""\' 123456789', false);
        Test.stopTest();
    } 

    @isTest
    static void testFunction() {
        Test.startTest(); 
            Call_List__c cmp = [SELECT Id, RecordTypeId, Campaign_Name__c, Activity__c, Case_Type_Config__c, Expired_Date__c, Entity__c, IsExpired__c, job_id__c FROM Call_List__c LIMIT 1];
            //Insert Document
         	Contact con = [select id, Policy_No__c from Contact limit 1];
        
            
        	ApexPages.currentPage().getParameters().put('upload','success');
        	ApexPages.currentPage().getParameters().put('uploadedNum','5');
        	ApexPages.currentPage().getParameters().put('validNum','1');
        	ApexPages.currentPage().getParameters().put('invalidNum','0');
        	ApexPages.currentPage().getParameters().put('list_invalidPolicy','0');
        	ApexPages.currentPage().getParameters().put('status_invalid','0');
        	ApexPages.currentPage().getParameters().put('list_invalidPolicy','EM1');
        	ApexPages.currentPage().getParameters().put('campaigntemp',cmp.id); 
        	ApexPages.currentPage().getParameters().put('Grouping','true'); 
            CallLineGeneratorControllerAMFS cgc = new CallLineGeneratorControllerAMFS();
            cgc.choosen_campaign = cmp.Id; 
            Document document = new Document();
            String body='Policy No \n';
            body = body + con.Policy_No__c+' \n' + '500-23456 \n' + '500-34567';
            document.Body = Blob.valueOf(body);
            document.ContentType ='text/plain; charset=UTF-8';
            document.Name = 'Testing Welcome Call.csv';
            cgc.document = document;
            cgc.Upload();
            cgc.parseCollectionTaskCSV('1234567890,"""\' 123456789,"""\' dan \'""\' hehehe ","""\' 123456789,"""\' 123456789', false); 
            cgc.groupingCallLine();
            cgc.reset();
        Test.stopTest();
    }
    

    @isTest
    static void testFunction2() {
        Test.startTest(); 
            Call_List__c cmp = [SELECT Id, RecordTypeId, Campaign_Name__c, Activity__c, Case_Type_Config__c, Expired_Date__c, Entity__c, IsExpired__c, job_id__c FROM Call_List__c LIMIT 1];
            //Insert Document
            CallLineGeneratorControllerAMFS cgc = new CallLineGeneratorControllerAMFS();
            cgc.choosen_campaign = cmp.Id;
            cgc.Upload();
            cgc.parseCollectionTaskCSV('1234567890,"""\' 123456789,"""\' dan \'""\' hehehe ","""\' 123456789,"""\' 123456789', false);
                        
            cgc.populateFreshData();
            cgc.resetAgent();
        Test.stopTest();
    }

    @isTest
    static void testFunction3() {
        Test.startTest(); 
            Call_List__c cmp = [SELECT Id, RecordTypeId, Campaign_Name__c, Activity__c, Case_Type_Config__c, Expired_Date__c, Entity__c, IsExpired__c, job_id__c FROM Call_List__c LIMIT 1];
            //Insert Document
            CallLineGeneratorControllerAMFS cgc = new CallLineGeneratorControllerAMFS();
            cgc.choosen_campaign = cmp.Id;
            cgc.Upload();
            cgc.parseCollectionTaskCSV('1234567890,"""\' 123456789,"""\' dan \'""\' hehehe ","""\' 123456789,"""\' 123456789', false);
                        
            cgc.populateFreshData();
            cgc.reorder();
            cgc.distribute();
        Test.stopTest();
    }

    @isTest
    static void testFunctionAutomaticRedemTM() {
        Test.startTest(); 
            Call_List__c cmp = [SELECT Id, RecordTypeId, Campaign_Name__c, Activity__c, Case_Type_Config__c, Expired_Date__c, Entity__c, IsExpired__c, job_id__c FROM Call_List__c LIMIT 1];
            //Insert Document
            CallLineGeneratorControllerAMFS cgc = new CallLineGeneratorControllerAMFS();
            cgc.choosen_campaign = cmp.Id; 
        	
        
            cgc.populateFreshData();
            cgc.distributeAuto();    
            cgc.choosen_method = 'Automatic';
            cgc.isMethodChoosen = true;
            // cgc.save();
        Test.stopTest();
    }
    
    
    @isTest
    static void testFunctionAutomaticRedemKonven() {
        Test.startTest(); 
        
         	Contact con = [select id, Policy_No__c from Contact limit 1];
        
            Call_List__c cl = new Call_List__c();
            cl.RecordTypeId = rtype;
            cl.Activity__c = 'Collection';
            cl.Case_Type__c = 'Redemption Konven';
            cl.Expired_Date__c = system.today() + 30;
            cl.Entity__c = 'AMFS';
            cl.Campaign_Name__c = 'Redemption Konven';
            insert cl; 
        
            Call_Line__c cLine = new Call_Line__c();
            cLine.Call_List__c = cl.id;
            cLine.Activity__c = 'Collection';
            cLine.Policy_No__c = 'AMFS001';
            cLine.APE_Total_Child__c = 100000; 
            cLine.Call_Remarks__c = 'OK';
            cLine.Entity__c = 'AMFS';
            cLine.APE__c = 1000;
            cLine.Currency__c = 'IDR';
            insert cLine;
            
            
            //Insert Call Line
            Call_Line__c cl2 = new Call_Line__c();
            cl2.Call_Status_Config__c = 'Hold';
            cl2.Policy_No__c = con.Policy_No__c;
            cl2.Contact__c = con.Id;
            cl2.Remark_Hold_Debet__c = 'test';
            cl2.Call_List__c = cl.Id;
            cl2.APE_Total_Child__c = 1000000;
            cl2.Entity__c = 'AMFS';
            cl2.Activity__c = 'Collection';
            cl2.Policy_No__c = 'test';
            cl2.Contacted_Number__c = '123456789';
            cl2.Home_Phone__c = '1234567'; 
            Insert cl2;
            
            //Insert Call Line
            Call_Line__c cl3 = new Call_Line__c();
            cl3.Call_Status_Config__c = 'Hold';
            cl3.Policy_No__c = '517-8400022';
            cl3.Contact__c = con.Id;
            cl3.Remark_Hold_Debet__c = 'test';
            cl3.Call_List__c = cl.Id;
            cl3.APE_Total_Child__c = 1000000;
            cl3.Entity__c = 'AMFS';
            cl3.Activity__c = 'Collection';
            cl3.Policy_No__c = 'test';
            cl3.Contacted_Number__c = '123456789';
            cl3.Home_Phone__c = '1234567';
            Insert cl3;
            
            //Insert Document
            CallLineGeneratorControllerAMFS cgc = new CallLineGeneratorControllerAMFS();
            cgc.choosen_campaign = cl.Id; 
        	         
            cgc.Upload();
            cgc.parseCollectionTaskCSV(con.Policy_No__c+',"""\' 123456789,"""\' dan \'""\' hehehe ","""\' 123456789,"""\' 123456789', false);
            cgc.populateFreshData();
            cgc.distributeAuto();    
            cgc.groupingCallLine();
            cgc.choosen_method = 'Automatic';
            cgc.isMethodChoosen = true;
            // cgc.save();
        Test.stopTest();
    }
    
    
    @isTest
    static void testFunctionAutomaticLapseKonven() {
        Test.startTest(); 
        
         	Contact con = [select id, Policy_No__c from Contact limit 1];
        
            Call_List__c cl = new Call_List__c();
            cl.RecordTypeId = rtype;
            cl.Activity__c = 'Collection';
            cl.Case_Type__c = 'Lapse Konven';
            cl.Expired_Date__c = system.today() + 30;
            cl.Entity__c = 'AMFS';
            cl.Campaign_Name__c = 'Lapse Konven';
            insert cl; 
        
            Call_Line__c cLine = new Call_Line__c();
            cLine.Call_List__c = cl.id;
            cLine.Activity__c = 'Collection';
            cLine.Policy_No__c = 'AMFS001';
            cLine.APE_Total_Child__c = 100000; 
            cLine.Call_Remarks__c = 'OK';
            cLine.Entity__c = 'AMFS';
            cLine.APE__c = 1000;
            cLine.Currency__c = 'IDR';
            insert cLine;
            
            
            //Insert Call Line
            Call_Line__c cl2 = new Call_Line__c();
            cl2.Call_Status_Config__c = 'Hold';
            cl2.Policy_No__c = con.Policy_No__c;
            cl2.Contact__c = con.Id;
            cl2.Remark_Hold_Debet__c = 'test';
            cl2.Call_List__c = cl.Id;
            cl2.APE_Total_Child__c = 1000000;
            cl2.Entity__c = 'AMFS';
            cl2.Activity__c = 'Collection';
            cl2.Policy_No__c = 'test';
            cl2.Contacted_Number__c = '123456789';
            cl2.Home_Phone__c = '1234567'; 
            Insert cl2;
            
            //Insert Call Line
            Call_Line__c cl3 = new Call_Line__c();
            cl3.Call_Status_Config__c = 'Hold';
            cl3.Policy_No__c = con.Policy_No__c;
            cl3.Contact__c = con.Id;
            cl3.Remark_Hold_Debet__c = 'test';
            cl3.Call_List__c = cl.Id;
            cl3.APE_Total_Child__c = 1000000;
            cl3.Entity__c = 'AMFS';
            cl3.Activity__c = 'Collection';
            cl3.Policy_No__c = 'test';
            cl3.Contacted_Number__c = '123456789';
            cl3.Home_Phone__c = '1234567';
            Insert cl3;
            
            //Insert Document
            CallLineGeneratorControllerAMFS cgc = new CallLineGeneratorControllerAMFS();
            cgc.choosen_campaign = cl.Id; 
        	         
            cgc.Upload();
            cgc.parseCollectionTaskCSV('1234567890,"""\' 123456789,"""\' dan \'""\' hehehe ","""\' 123456789,"""\' 123456789', false);
            cgc.populateFreshData();
            cgc.distributeAuto();    
            cgc.groupingCallLine();
            cgc.choosen_method = 'Automatic';
            cgc.isMethodChoosen = true;
            // cgc.save();
        Test.stopTest();
    }
    
    
    @isTest
    static void testFunctionAutomaticCutiPremi() {
        Test.startTest(); 
        
         	Contact con = [select id, Policy_No__c from Contact limit 1];
        
            Call_List__c cl = new Call_List__c();
            cl.RecordTypeId = rtype;
            cl.Activity__c = 'Collection';
            cl.Case_Type__c = 'Cuti Premi';
            cl.Expired_Date__c = system.today() + 30;
            cl.Entity__c = 'AMFS';
            cl.Campaign_Name__c = 'Cuti Premi';
            insert cl; 
        
            Call_Line__c cLine = new Call_Line__c();
            cLine.Call_List__c = cl.id;
            cLine.Activity__c = 'Collection';
            cLine.Policy_No__c = 'AMFS001';
            cLine.APE_Total_Child__c = 100000; 
            cLine.Call_Remarks__c = 'OK';
            cLine.Entity__c = 'AMFS';
            cLine.APE__c = 1000;
            cLine.Currency__c = 'IDR';
            insert cLine;
            
            
            //Insert Call Line
            Call_Line__c cl2 = new Call_Line__c();
            cl2.Call_Status_Config__c = 'Hold';
            cl2.Policy_No__c = con.Policy_No__c;
            cl2.Contact__c = con.Id;
            cl2.Remark_Hold_Debet__c = 'test';
            cl2.Call_List__c = cl.Id;
            cl2.APE_Total_Child__c = 1000000;
            cl2.Entity__c = 'AMFS';
            cl2.Activity__c = 'Collection';
            cl2.Policy_No__c = 'test';
            cl2.Contacted_Number__c = '123456789';
            cl2.Home_Phone__c = '1234567'; 
            Insert cl2;
            
            //Insert Call Line
            Call_Line__c cl3 = new Call_Line__c();
            cl3.Call_Status_Config__c = 'Hold';
            cl3.Policy_No__c = con.Policy_No__c;
            cl3.Contact__c = con.Id;
            cl3.Remark_Hold_Debet__c = 'test';
            cl3.Call_List__c = cl.Id;
            cl3.APE_Total_Child__c = 1000000;
            cl3.Entity__c = 'AMFS';
            cl3.Activity__c = 'Collection';
            cl3.Policy_No__c = 'test';
            cl3.Contacted_Number__c = '123456789';
            cl3.Home_Phone__c = '1234567';
            Insert cl3;
            
            //Insert Document
            CallLineGeneratorControllerAMFS cgc = new CallLineGeneratorControllerAMFS();
            cgc.choosen_campaign = cl.Id; 
        	         
            cgc.Upload();
            cgc.parseCollectionTaskCSV('1234567890,"""\' 123456789,"""\' dan \'""\' hehehe ","""\' 123456789,"""\' 123456789', false);
            cgc.populateFreshData();
            cgc.distributeAuto();    
            cgc.groupingCallLine();
            cgc.choosen_method = 'Automatic';
            cgc.isMethodChoosen = true;
            // cgc.save();
        Test.stopTest();
    }
    
    
    @isTest
    static void testFunctionManual() {
        Test.startTest(); 
            Call_List__c cmp = [SELECT Id, RecordTypeId, Campaign_Name__c, Activity__c, Case_Type_Config__c, Expired_Date__c, Entity__c, IsExpired__c, job_id__c FROM Call_List__c LIMIT 1];
            //Insert Document
            CallLineGeneratorControllerAMFS cgc = new CallLineGeneratorControllerAMFS();
            cgc.choosen_campaign = cmp.Id;
            cgc.Upload();
            cgc.parseCollectionTaskCSV('1234567890,"""\' 123456789,"""\' dan \'""\' hehehe ","""\' 123456789,"""\' 123456789', false);
                        
            cgc.populateFreshData(); 
            cgc.distributeManualByCount();
          
            cgc.choosen_method = 'Manual by Count';
            cgc.isMethodChoosen = true;   
        	cgc.save();
        Test.stopTest();
    }
     
    @isTest
    static void testProgress() {
        Test.startTest();  
            Call_List__c cmp = [SELECT Id, RecordTypeId, Campaign_Name__c, Activity__c, Case_Type_Config__c, Expired_Date__c, Entity__c, IsExpired__c, job_id__c FROM Call_List__c LIMIT 1];
            //Insert Document 
           
        	ApexPages.currentPage().getParameters().put('upload','success');
        	ApexPages.currentPage().getParameters().put('uploadedNum','5');
        	ApexPages.currentPage().getParameters().put('validNum','1');
        	ApexPages.currentPage().getParameters().put('invalidNum','0');
        	ApexPages.currentPage().getParameters().put('list_invalidPolicy','0');
        	ApexPages.currentPage().getParameters().put('status_invalid','0');
        	ApexPages.currentPage().getParameters().put('list_invalidPolicy','EM1');
        	ApexPages.currentPage().getParameters().put('campaigntemp',cmp.id); 
        	ApexPages.currentPage().getParameters().put('Grouping','true'); 
            CallLineGeneratorControllerAMFS cgc = new CallLineGeneratorControllerAMFS();
            cgc.choosen_campaign = cmp.Id;  
         
            User us = new User(Alias = 'spv1', Email='spvAMFS@axa.co.id', 
                    EmailEncodingKey='UTF-8', LastName='spvAMFSTEST', LanguageLocaleKey='en_US', 
                    LocaleSidKey='en_US', ProfileId = spvProfileAMFS.Id, Entity__c = 'AMFS', 
                    TimeZoneSidKey='Asia/Jakarta', UserName='spvAMFSTEST2@axa.co.id');
            insert us;
            
            User agent = new User(Alias = 'agent1', Email='agentAMFSTEST@axa.co.id', 
                    EmailEncodingKey='UTF-8', LastName='agentAMFSTEST', LanguageLocaleKey='en_US', 
                    LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = us.id, Entity__c = 'AMFS',
                    TimeZoneSidKey='Asia/Jakarta', UserName='agentAMFSTEST2@axa.co.id', isActive = true, Agent__c = true,
                    Outbound_Activity_Case_type__c = 'Collection');
            insert agent;
            
            User_Detail__c ud = new User_Detail__c();
            ud.Name = 'TEST';
            ud.User__c = agent.id;
            ud.Outbound_Activity_Case_type__c = 'Collection - Lapse Konven';
            insert ud;
            
            Call_List__c cl = new Call_List__c();
            cl.RecordTypeId = rtype;
            cl.Activity__c = 'Collection';
            cl.Case_Type__c = 'Lapse Konven';
            cl.Expired_Date__c = system.today() + 30;
            cl.Entity__c = 'AMFS';
            cl.Campaign_Name__c = 'Lapse Konven';
            insert cl;
            
            Call_Line__c cLine = new Call_Line__c();
            cLine.Call_List__c = cl.id;
            cLine.ownerid = us.id;
            cLine.Activity__c = 'Collection';
            cLine.Policy_No__c = 'AMFS001';
            cLine.Agent__c  = agent.Id;
            cLine.Call_Remarks__c = 'OK';
            cLine.Entity__c = 'AMFS';
            cLine.APE__c = 1000;
            cLine.Currency__c = 'IDR';
            insert cLine;
            
            Agent_Distribution_History__c adhx = new Agent_Distribution_History__c();
            adhx.Campaign__c = cl.id;
            adhx.User_Detail__c = ud.id;
            insert adhx;
            
            List<Agent_Distribution_History__c> finalListAdh = new list <Agent_Distribution_History__c>();
            finalListAdh.add(adhx);
            
            map <Id,Agent_Distribution_History__c> mapAgentHistory = new map <Id,Agent_Distribution_History__c>();
                for (Agent_Distribution_History__c adh : finalListAdh){
                    if (adh.User_Detail__c != NULL)
                        mapAgentHistory.put(adh.User_Detail__r.User__c, adh);
                    }
            
            Map<Id,Decimal> mapAA = new Map<Id,Decimal>();
            mapAA.put(us.id, 1000000);    
            
            List<Call_Line__c> callLineList = new list <Call_Line__c>();
            callLineList.add(cLine);
            
            String choosen_campaign = cl.Id;
            Map<integer, string> agentOrderMap = new Map<integer,string>();
            agentOrderMap.put(1,agent.id);
            
            Batch_DistributeManual_CallLineAMFS bb = new Batch_DistributeManual_CallLineAMFS(finalListAdh,callLineList,agentOrderMap,mapAgentHistory,choosen_campaign);
            Database.executeBatch(bb,100);
        	cgc.updateProgress();
        	cgc.getJobs();
        	cgc.progressUploadFile(); 
        	cgc.getShowProgressBar();    
        Test.stopTest();
    }
    
    
    @isTest
    static void testProgress2() {
        
            Call_List__c cmp = [SELECT Id, RecordTypeId, Campaign_Name__c, Activity__c, Case_Type_Config__c, Expired_Date__c, Entity__c, IsExpired__c, job_id__c FROM Call_List__c LIMIT 1];
            //Insert Document 
           
        	ApexPages.currentPage().getParameters().put('upload','success');
        	ApexPages.currentPage().getParameters().put('uploadedNum','5');
        	ApexPages.currentPage().getParameters().put('validNum','1');
        	ApexPages.currentPage().getParameters().put('invalidNum','0');
        	ApexPages.currentPage().getParameters().put('list_invalidPolicy','0');
        	ApexPages.currentPage().getParameters().put('status_invalid','0');
        	ApexPages.currentPage().getParameters().put('list_invalidPolicy','EM1');
        	ApexPages.currentPage().getParameters().put('campaigntemp',cmp.id); 
        	ApexPages.currentPage().getParameters().put('Grouping','true'); 
            CallLineGeneratorControllerAMFS cgc = new CallLineGeneratorControllerAMFS();
            cgc.choosen_campaign = cmp.Id;  
        	cgc.updateProgress();
        	cgc.progressUploadFile(); 
        	cgc.getShowProgressBar();     
    }
     
    @isTest
    static void  testUploadEmpty() {
            //campaign empty Document
            CallLineGeneratorControllerAMFS cgc = new CallLineGeneratorControllerAMFS();
        	cgc.upload();
    }
}