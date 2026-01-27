@isTest
public class CallLineGeneratorControllerAGI_Test {
    private static testMethod void setupTestData() {
        Test.startTest();
        
        String recordTypeAGI = [select Id,Name from RecordType where sObjectType='Call_List__c' And Name = 'ActivityAGI'].Id;
        system.debug('Record Type AGI ==>'+recordtypeAGI);
        CallLineGeneratorControllerAGI fucAGI = new CallLineGeneratorControllerAGI();
        Document testDocument = fucAGI.document;
        
        CallLineGeneratorControllerAGI.OutboundCall oc = new CallLineGeneratorControllerAGI.OutboundCall();
        oc.policyNo = '';
        oc.phoneNo= '';
        oc.campaignName= '';
        oc.agentId= '';
        oc.agentName= '';
        
        CallLineGeneratorControllerAGI.Welcome wc = new CallLineGeneratorControllerAGI.Welcome();
        wc.policyNo= '';
        wc.Product= '';   
        wc.Name1= '';
        wc.InceptionDate= '';
        wc.TransactionDate= '';
        wc.Phone1= '';
        wc.Phone2= '';
        wc.Phone3= '';
        wc.Email1= '';
        wc.chanel= '';
        
        CallLineGeneratorControllerAGI.Callback cb = new CallLineGeneratorControllerAGI.Callback();
        cb.phoneNo= '';
        cb.preferredPhoneNo= '';
        cb.callDate= Date.today();
        
        CallLineGeneratorControllerAGI.Survey_AGI sv = new CallLineGeneratorControllerAGI.Survey_AGI();
        sv.PolicyNo = '';
        sv.Name1 = ''; 
        sv.Phone1 = '';
        sv.Remark = '';
        sv.Q1 = '';
        sv.Q2 = '';
        sv.Q3 = '';
        sv.Q4 = '';
        
        CallLineGeneratorControllerAGI.SMSAGI sms = new CallLineGeneratorControllerAGI.SMSAGI();
        sms.PolicyNo = '';
        sms.Name1 = '';
        sms.Phone1 = '';
        sms.Remark = '';
        sms.Q1 = '';
        
        CallLineGeneratorControllerAGI.ComplaintFollowUp cfu = new CallLineGeneratorControllerAGI.ComplaintFollowUp();
        cfu.No = '';
        cfu.TanggalEMailComplaint = '';
        cfu.ReferensiPolis = '';
        cfu.PolicyNo = '';
        cfu.LOB = '';
        cfu.Product = '';
        cfu.Channel = '';
        cfu.Source = '';
        cfu.Insured = '';
        cfu.Name1 = '';
        cfu.Email1 = '';
        cfu.Phone1 = '';
        cfu.PICTravel = '';
        
        CallLineGeneratorControllerAGI.Claim claim1 = new CallLineGeneratorControllerAGI.Claim();
        claim1.TanggalPengajuan = '';
        claim1.ReferensiPolis = '';
        claim1.PolicyNo = '';
        claim1.Tertanggung = '';
        claim1.Email1 = '';
        claim1.Phone1 = '';
        claim1.Status = '';
        claim1.TanggalEskalasi1 = '';  
        claim1.TanggalEskalasi2 = '';
        claim1.TanggalEskalasi3 = '';
        claim1.Remarks = '';
        claim1.TanggalClosed = '';
        
        CallLineGeneratorControllerAGI.UpdateData ud = new CallLineGeneratorControllerAGI.UpdateData();
		ud.PolicyNo = '';
        ud.No = ''; 
        ud.Name1 = ''; 
        ud.Phone1 = ''; 
        ud.Email1 = ''; 
        ud.Address1 = ''; 
        ud.Product = ''; 
		        
        CallLineGeneratorControllerAGI.AgentAssignment aa = new CallLineGeneratorControllerAGI.AgentAssignment();
        aa.agentId= '';
        aa.agentName= '';
        aa.policyTotal= 0;
        
        CallLineGeneratorControllerAGI.ReloadWrapper rw = new CallLineGeneratorControllerAGI.ReloadWrapper();
        rw.id= '';
        rw.agentName= '';
        rw.policyNo= '';
        rw.isSelected= false;
        rw.callStatus= '';
        rw.reasonStatus= '';
        
        Profile spvProfileAGI = [SELECT Id FROM Profile WHERE Name like '%Supervisor Inbound & Outbound AGI%' limit 1];
        Profile agentProfileAGI = [SELECT Id FROM Profile WHERE Name like '%Inbound & Outbound Agent AGI%' limit 1]; 
        
        User loginAGIUser = new User(Alias = 'spv1', Email='spvAGI1@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='spvAGI', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = spvProfileAGI.Id, Entity__c = 'AGI', 
      			TimeZoneSidKey='Asia/Jakarta', UserName='spvAGI@axa.co.id');
        insert loginAGIUser;
        
        User subOrdinateAGIUser = new User(Alias = 'agent1', Email='agentAGI@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentAGI', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileAGI.Id, managerId = loginAGIUser.id, Entity__c = 'AGI',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentAGI2@axa.co.id', isActive = true, Agent__c = true,
                Outbound_Activity_Case_type__c = 'Confirmation');
        insert subOrdinateAGIUser;
        
        String contactRecordTypeAGI = [select Id,Name from RecordType where sObjectType='Contact' And Name = 'Contact AGI'].Id;
        
        Contact c1 = new Contact();
        c1.LastName = 'test3';
        c1.Entity__c = 'AGI';
        c1.Policy_No__c = 'AGI123';
        c1.RecordTypeId = contactRecordTypeAGI;
        insert c1;
        
        Contact c2 = new Contact();
        c2.LastName = 'test4';
        c2.Entity__c = 'AGI';
        c2.Policy_No__c = 'AGI122';
        c2.RecordTypeId = contactRecordTypeAGI;
        insert c2;
        
        User_Detail__c udetail1 = new User_Detail__c();
        udetail1.User__c = loginAGIUser.Id;
        udetail1.Outbound_Activity_Case_type__c = 'Confirmation';
        insert udetail1;
        
        User_Detail__c udetail2 = new User_Detail__c();
        udetail2.User__c = subOrdinateAGIUser.Id;
        udetail2.Outbound_Activity_Case_type__c = 'Confirmation';
        insert udetail2;
        
        //Create Campaign
        Call_List__c campAGI = new Call_List__c();
         campAGI.Campaign_Name__c = 'test campaign AGI';
         campAGI.Entity__c = 'AGI';
         campAGI.Activity__c = 'Confirmation';
         campAGI.Case_Type_Config__c = 'Claim';
         campAGI.Case_Type__c = 'Claim';
         campAGI.ownerid = loginAGIUser.id;
         campAGI.IsExpired__c = false;
         campAGI.Expired_Date__c = Datetime.now().addDays(30).date();
         campAGI.CreatedDate = system.today()-1;
         campAGI.CreatedById = loginAGIUser.id;
         campAGI.RecordTypeId = recordtypeAGI;
        insert campAGI;
        
        Call_List__c campAGI2 = new Call_List__c();
         campAGI2.Campaign_Name__c = 'test campaign AGI2';
         campAGI2.Entity__c = 'AGI';
         campAGI2.Activity__c = 'Confirmation';
         campAGI2.Case_Type_Config__c = 'Claim';
         campAGI2.Case_Type__c = 'Claim';
         campAGI2.ownerid = loginAGIUser.id;
         campAGI2.IsExpired__c = false;
         campAGI2.Expired_Date__c = Datetime.now().addDays(30).date();
         campAGI2.CreatedDate = system.today()-1;
         campAGI2.CreatedById = loginAGIUser.id;
         campAGI2.RecordTypeId = recordtypeAGI;
        insert campAGI2;
        
        //create distribution call
        Call_Line__c callAGI1 = new Call_Line__c();
         callAGI1.Call_List__c = campAGI.id;
         callAGI1.ownerid = loginAGIUser.id;
         callAGI1.Activity__c = 'Confirmation';
         callAGI1.Policy_No__c = 'AGI123';
         callAGI1.Contact__c = c1.id;
         callAGI1.Agent__c  = null;
         callAGI1.Call_Status_Config__c = 'Contacted';		//callAFI1.Activity_Result__c = 'Contacted';
         callAGI1.Reason_Status_Config__c = 'Agree'; 		//callAFI1.Verification__c = 'Agree'; 
         callAGI1.Call_Remarks__c = 'OK';
         callAGI1.Entity__c = 'AGI';
         callAGI1.Parent_Campaign__c = campAGI.Id;
        insert callAGI1;
        
        Call_Line__c callAGI2 = new Call_Line__c();
         callAGI2.Call_List__c = campAGI2.id;
         callAGI2.ownerid = loginAGIUser.id;
         callAGI2.Activity__c = 'Confirmation';
         callAGI2.Contact__c = c1.id;
         callAGI2.Policy_No__c = 'AGI122';
         callAGI2.Agent__c  = null;
         callAGI2.Call_Status_Config__c = 'Contacted';		//callAFI1.Activity_Result__c = 'Contacted';
         callAGI2.Reason_Status_Config__c = 'Agree'; 		//callAFI1.Verification__c = 'Agree'; 
         callAGI2.Call_Remarks__c = 'OK';
         callAGI2.Entity__c = 'AGI';
         callAGI2.Parent_Campaign__c = campAGI2.Id;
        insert callAGI2;
        
        fucAGI.choosen_campaign = campAGI.Id;
        fucAGI.populateFreshData();
        fucAGI.populateReloadFreshData();
        fucAGI.populateCallAndReasonStatus();
        
        fucAGI.choosen_method = 'Automatic';
        fucAGI.distribute();
        fucAGI.choosen_method = 'Manual';
        fucAGI.distribute();
        fucAGI.choosen_method = 'Specific';
        fucAGI.distribute();
        
        fucAGI.reset();
        
        List<CallLineGeneratorControllerAGI.ReloadWrapper> rwList = new List<CallLineGeneratorControllerAGI.ReloadWrapper>();
        CallLineGeneratorControllerAGI.ReloadWrapper rw1 = new CallLineGeneratorControllerAGI.ReloadWrapper();
        rw1.isSelected = true;
        rw1.Id = callAGI2.Id;
        rwList.add(rw1);
        fucAGI.reloadWrap = rwList;
        
        fucAGI.release();
        fucAGI.releaseReload();
        
        fucAGI.choosen_agent = 'All';
        List<Id> agList = new List<Id>();
        agList.add(subOrdinateAGIUser.Id);
        fucAGI.agentIDList = agList;
        System.debug('***choosen_campaign: ' + campAGI.Id);
     	System.debug('***agentIDList: ' + agList);
        
        Call_Line__c callAGI3 = new Call_Line__c();
         callAGI3.Call_List__c = campAGI.id;
         callAGI3.ownerid = loginAGIUser.id;
         callAGI3.Activity__c = 'Confirmation';
         callAGI3.Policy_No__c = 'AGI002';
         callAGI3.Agent__c  = subOrdinateAGIUser.Id;
         callAGI3.Call_Status_Config__c = 'Contacted';		//callAFI1.Activity_Result__c = 'Contacted';
         callAGI3.Reason_Status_Config__c = 'Agree'; 		//callAFI1.Verification__c = 'Agree'; 
         callAGI3.Call_Remarks__c = 'OK';
         callAGI3.Entity__c = 'AGI';
         callAGI3.Parent_Campaign__c = campAGI.Id;
        insert callAGI3;
        fucAGI.getListToReload();
        
        fucAGI.upload();
        
        Document doc1 = new Document();
        doc1.Name = 'Test_Doc.csv';
        doc1.Body = Blob.valueOf('Unit Test Document Body');
        doc1.ContentType = 'text/csv';
        fucAGI.document = doc1;
        Map<String,Call_List__c> clMap = new Map<string,Call_List__c>();
        clMap.put(campAGI.Id, campAGI);
        fucAGI.campaignObjectMap = clMap;
        fucAGI.upload();
        
        fucAGI.choosen_campaign = '';
        fucAGI.upload();
        
        fucAGI.isMethodChoosen = false;
        fucAGI.save();
        fucAGI.isMethodChoosen = true;
        fucAGI.choosen_method = 'Manual';
        fucAGI.save();
        
        fucAGI.cumaUntukTestClass();
        
        Test.stopTest();
    }
    
    private static testMethod void setupTestWelcomeCall() {
        Test.startTest();
        String recordTypeAGI = [select Id,Name from RecordType where sObjectType='Call_List__c' And Name = 'ActivityAGI'].Id;
        system.debug('Record Type AGI ==>'+recordtypeAGI);
        CallLineGeneratorControllerAGI fucAGI = new CallLineGeneratorControllerAGI();
        //welcome call
        Call_List__c campAGI3 = new Call_List__c();
         campAGI3.Campaign_Name__c = 'test campaign AGI3';
         campAGI3.Entity__c = 'AGI';
         campAGI3.Activity__c = 'Confirmation';
         campAGI3.Case_Type_Config__c = 'Welcome Call';
         campAGI3.Case_Type__c = 'Welcome Call';
         campAGI3.IsExpired__c = false;
         campAGI3.Expired_Date__c = Datetime.now().addDays(1).date();
         campAGI3.CreatedDate = system.today() - 10;
         campAGI3.RecordTypeId = recordtypeAGI;
        
        insert campAGI3;
        Document doc3 = new Document();
        doc3.Name = 'Test_Doc3.csv';
        doc3.Body = Blob.valueOf('Unit Test Document Body3');
        doc3.ContentType = 'text/csv';
        fucAGI.document = doc3;
        Map<String,Call_List__c> clMap3 = new Map<string,Call_List__c>();
        clMap3.put(campAGI3.Id, campAGI3);
        fucAGI.campaignObjectMap = clMap3;
        fucAGI.choosen_campaign = campAGI3.Id;
        fucAGI.upload();
        Test.stopTest();
    }
    
    
    private static testMethod void setupTestPremiumFU() {
        Test.startTest();
        String recordTypeAGI = [select Id,Name from RecordType where sObjectType='Call_List__c' And Name = 'ActivityAGI'].Id;
        system.debug('Record Type AGI ==>'+recordtypeAGI);
        CallLineGeneratorControllerAGI fucAGI = new CallLineGeneratorControllerAGI();
        //premium fuuuu
        Call_List__c campAGI5 = new Call_List__c();
         campAGI5.Campaign_Name__c = 'test campaign AGI5';
         campAGI5.Entity__c = 'AGI';
         campAGI5.Activity__c = 'Confirmation';
         campAGI5.Case_Type_Config__c = 'Premium FU';
         campAGI5.Case_Type__c = 'Premium FU';
         campAGI5.IsExpired__c = false;
         campAGI5.Expired_Date__c = Datetime.now().addDays(1).date();
         campAGI5.CreatedDate = system.today() - 10;
         campAGI5.RecordTypeId = recordtypeAGI;
        
        insert campAGI5;
        Document doc5 = new Document();
        doc5.Name = 'Test_Doc5.csv';
        doc5.Body = Blob.valueOf('Unit Test Document Body5');
        doc5.ContentType = 'text/csv';
        fucAGI.document = doc5;
        Map<String,Call_List__c> clMap5 = new Map<string,Call_List__c>();
        clMap5.put(campAGI5.Id, campAGI5);
        fucAGI.campaignObjectMap = clMap5;
        fucAGI.choosen_campaign = campAGI5.Id;
        fucAGI.upload();
        Test.stopTest();
    }
    
    private static testMethod void setupTestUpdateData() {
        Test.startTest();
        String recordTypeAGI = [select Id,Name from RecordType where sObjectType='Call_List__c' And Name = 'ActivityAGI'].Id;
        system.debug('Record Type AGI ==>'+recordtypeAGI);
        CallLineGeneratorControllerAGI fucAGI = new CallLineGeneratorControllerAGI();
        //update data
        Call_List__c campAGI6 = new Call_List__c();
         campAGI6.Campaign_Name__c = 'test campaign AGI6';
         campAGI6.Entity__c = 'AGI';
         campAGI6.Activity__c = 'Confirmation';
         campAGI6.Case_Type_Config__c = 'Update Data';
         campAGI6.Case_Type__c = 'Update Data';
         campAGI6.IsExpired__c = false;
         campAGI6.Expired_Date__c = Datetime.now().addDays(1).date();
         campAGI6.CreatedDate = system.today() - 10;
         campAGI6.RecordTypeId = recordtypeAGI;
        
        insert campAGI6;
        Document doc6 = new Document();
        doc6.Name = 'Test_Doc6.csv';
        doc6.Body = Blob.valueOf('Unit Test Document Body6');
        doc6.ContentType = 'text/csv';
        fucAGI.document = doc6;
        Map<String,Call_List__c> clMap6 = new Map<string,Call_List__c>();
        clMap6.put(campAGI6.Id, campAGI6);
        fucAGI.campaignObjectMap = clMap6;
        fucAGI.choosen_campaign = campAGI6.Id;
        fucAGI.upload();
        Test.stopTest();
    }
    
    
    private static testMethod void setupTestSurveyFeedback() {
        Test.startTest();
        String recordTypeAGI = [select Id,Name from RecordType where sObjectType='Call_List__c' And Name = 'ActivityAGI'].Id;
        system.debug('Record Type AGI ==>'+recordtypeAGI);
        CallLineGeneratorControllerAGI fucAGI = new CallLineGeneratorControllerAGI();
        //update data
        Call_List__c campAGI6 = new Call_List__c();
         campAGI6.Campaign_Name__c = 'test campaign AGI6';
         campAGI6.Entity__c = 'AGI';
         campAGI6.Activity__c = 'Survey Feedback';
         campAGI6.Case_Type_Config__c = 'Survey - I Claim';
         campAGI6.Case_Type__c = 'Survey - I Claim';
         campAGI6.IsExpired__c = false;
         campAGI6.Expired_Date__c = Datetime.now().addDays(1).date();
         campAGI6.CreatedDate = system.today() - 10;
         campAGI6.RecordTypeId = recordtypeAGI;
        
        insert campAGI6;
        Document doc6 = new Document();
        doc6.Name = 'Test_Doc6.csv';
        doc6.Body = Blob.valueOf('Unit Test Document Body6');
        doc6.ContentType = 'text/csv';
        fucAGI.document = doc6;
        Map<String,Call_List__c> clMap6 = new Map<string,Call_List__c>();
        clMap6.put(campAGI6.Id, campAGI6);
        fucAGI.campaignObjectMap = clMap6;
        fucAGI.choosen_campaign = campAGI6.Id;
        fucAGI.upload();
        Test.stopTest();
    }
    
    private static testMethod void setupTestCollectionTask() {
        Test.startTest();
        String recordTypeAGI = [select Id,Name from RecordType where sObjectType='Call_List__c' And Name = 'ActivityAGI'].Id;
        system.debug('Record Type AGI ==>'+recordtypeAGI);
        CallLineGeneratorControllerAGI fucAGI = new CallLineGeneratorControllerAGI();
        //update data
        Call_List__c campAGI6 = new Call_List__c();
         campAGI6.Campaign_Name__c = 'test campaign AGI6';
         campAGI6.Entity__c = 'AGI';
         campAGI6.Activity__c = 'Confirmation';
         campAGI6.Case_Type_Config__c = 'Collection Task';
         campAGI6.Case_Type__c = 'Collection Task';
         campAGI6.IsExpired__c = false;
         campAGI6.Expired_Date__c = Datetime.now().addDays(1).date();
         campAGI6.CreatedDate = system.today() - 10;
         campAGI6.RecordTypeId = recordtypeAGI;
        insert campAGI6;
        Document doc6 = new Document();
        doc6.Name = 'Test_Doc6.csv';
        doc6.Body = Blob.valueOf('Unit Test Document Body6');
        doc6.ContentType = 'text/csv';
        fucAGI.document = doc6;
        Map<String,Call_List__c> clMap6 = new Map<string,Call_List__c>();
        clMap6.put(campAGI6.Id, campAGI6);
        fucAGI.campaignObjectMap = clMap6;
        fucAGI.choosen_campaign = campAGI6.Id;
        fucAGI.upload();
        Test.stopTest();
    }

    private static testMethod void setupTestSurvey() {
        Test.startTest();
        String recordTypeAGI = [select Id,Name from RecordType where sObjectType='Call_List__c' And Name = 'ActivityAGI'].Id;
        system.debug('Record Type AGI ==>'+recordtypeAGI);
        CallLineGeneratorControllerAGI fucAGI = new CallLineGeneratorControllerAGI();
        //update data
        Call_List__c campAGI6 = new Call_List__c();
         campAGI6.Campaign_Name__c = 'test campaign AGI6';
         campAGI6.Entity__c = 'AGI';
         campAGI6.Activity__c = 'Survey Feedback';
         campAGI6.Case_Type_Config__c = 'Survey - I Buy';
         campAGI6.Case_Type__c = 'Survey - I Buy';
         campAGI6.IsExpired__c = false;
         campAGI6.Expired_Date__c = Datetime.now().addDays(1).date();
         campAGI6.CreatedDate = system.today() - 10;
         campAGI6.RecordTypeId = recordtypeAGI;
        insert campAGI6;
        Document doc6 = new Document();
        doc6.Name = 'Test_Doc6.csv';
        doc6.Body = Blob.valueOf('Unit Test Document Body6');
        doc6.ContentType = 'text/csv';
        fucAGI.document = doc6;
        Map<String,Call_List__c> clMap6 = new Map<string,Call_List__c>();
        clMap6.put(campAGI6.Id, campAGI6);
        fucAGI.campaignObjectMap = clMap6;
        fucAGI.choosen_campaign = campAGI6.Id;
        fucAGI.upload();
        Test.stopTest();
    }
    
    private static testMethod void setupComplaintFollowUp() {
        Test.startTest();
        String recordTypeAGI = [select Id,Name from RecordType where sObjectType='Call_List__c' And Name = 'ActivityAGI'].Id;
        system.debug('Record Type AGI ==>'+recordtypeAGI);
        CallLineGeneratorControllerAGI fucAGI = new CallLineGeneratorControllerAGI();
        //update data
        Call_List__c campAGI6 = new Call_List__c();
         campAGI6.Campaign_Name__c = 'test campaign AGI9';
         campAGI6.Entity__c = 'AGI';
         campAGI6.Activity__c = 'Confirmation';
         campAGI6.Case_Type_Config__c = 'Complaint Follow Up';
         campAGI6.Case_Type__c = 'Complaint Follow Up';
         campAGI6.IsExpired__c = false;
         campAGI6.Expired_Date__c = Datetime.now().addDays(1).date();
         campAGI6.CreatedDate = system.today() - 10;
         campAGI6.RecordTypeId = recordtypeAGI;
        insert campAGI6;
        Document doc9 = new Document();
        doc9.Name = 'Test_Doc9.csv';
        doc9.Body = Blob.valueOf('Unit Test Document Body69');
        doc9.ContentType = 'text/csv';
        fucAGI.document = doc9;
        Map<String,Call_List__c> clMap9 = new Map<string,Call_List__c>();
        clMap9.put(campAGI6.Id, campAGI6);
        fucAGI.campaignObjectMap = clMap9;
        fucAGI.choosen_campaign = campAGI6.Id;
        fucAGI.upload();
        Test.stopTest();
    }
    
    private static testMethod void setupSMSAGI() {
        Test.startTest();
        String recordTypeAGI = [select Id,Name from RecordType where sObjectType='Call_List__c' And Name = 'ActivityAGI'].Id;
        system.debug('Record Type AGI ==>'+recordtypeAGI);
        CallLineGeneratorControllerAGI fucAGI = new CallLineGeneratorControllerAGI();
        //update data
        Call_List__c campAGI6 = new Call_List__c();
         campAGI6.Campaign_Name__c = 'test campaign AGI9';
         campAGI6.Entity__c = 'AGI';
         campAGI6.Activity__c = 'Confirmation';
         campAGI6.Case_Type_Config__c = 'SMS Pull Confirmation';
         campAGI6.Case_Type__c = 'SMS Pull Confirmation';
         campAGI6.IsExpired__c = false;
         campAGI6.Expired_Date__c = Datetime.now().addDays(1).date();
         campAGI6.CreatedDate = system.today() - 10;
         campAGI6.RecordTypeId = recordtypeAGI;
        insert campAGI6;
        Document doc9 = new Document();
        doc9.Name = 'Test_Doc9.csv';
        doc9.Body = Blob.valueOf('Unit Test Document Body69');
        doc9.ContentType = 'text/csv';
        fucAGI.document = doc9;
        Map<String,Call_List__c> clMap9 = new Map<string,Call_List__c>();
        clMap9.put(campAGI6.Id, campAGI6);
        fucAGI.campaignObjectMap = clMap9;
        fucAGI.choosen_campaign = campAGI6.Id;
        fucAGI.upload();
        Test.stopTest();
    }
}