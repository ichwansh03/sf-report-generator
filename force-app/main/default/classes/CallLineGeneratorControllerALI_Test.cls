@isTest(seeAllData=true)
public class CallLineGeneratorControllerALI_Test {
    private static testMethod void setupTestData() {
        Test.startTest();
        
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();
        Document testDocument = fucAli.document;
        
        CallLineGeneratorControllerALI.OutboundCall oc = new CallLineGeneratorControllerALI.OutboundCall();
        oc.policyNo = '';
        oc.phoneNo= '';
        oc.campaignName= '';
        oc.agentId= '';
        oc.agentName= '';
        CallLineGeneratorControllerALI.Welcome wc = new CallLineGeneratorControllerALI.Welcome();
        wc.policyNo= '';
        wc.Product= '';
        wc.Description= '';
        wc.EffectiveDate= '';
        wc.Name1= '';
        wc.Name2= '';
        wc.Line1= '';
        wc.Line11= '';
        wc.Line12= '';
        wc.Line13= '';
        wc.City= '';
        wc.ZipCode= '';
        wc.MOBILEPHONE= '';
        wc.MOBILEPHONE2= '';
        wc.OFFICEPHONE= '';
        wc.OFFICEPHONE2= '';
        wc.HOMEPHONE= '';
        wc.HOMEPHONE2= '';
        wc.EMAIL= '';
        wc.Correspond= '';
        wc.delivereddate= '';
        wc.ReportPolicy= '';
        wc.Method= '';
        CallLineGeneratorControllerALI.Reinstate reins = new CallLineGeneratorControllerALI.Reinstate();
        reins.Priority= '';
        reins.Offering= '';
        reins.ReffNo= '';
        reins.policyNo= '';
        reins.Product= '';
        reins.Effective_Date= '';
        reins.Status_Polis= '';
        reins.Name_1= '';
        //reins.Premium= 0;
        //reins.RejReason= '';
        //reins.MobilePhone= '';
        //reins.MobilePhone2= '';
        //reins.OfficePhone= '';
        //reins.OfficePhone2= '';
        //reins.HomePhone= '';
        //reins.HomePhone2= '';
        //reins.Email= '';
        //reins.Agent= '';
        reins.Status= '';
        //reins.Remarks= '';
        //reins.Changes= '';
        //reins.LastCall= '';
        //reins.LastSMS= '';
        //reins.UploadDate= '';
        //reins.ResultDate= '';
        reins.Old_Result= '';
        CallLineGeneratorControllerALI.PremiumFU pfu = new CallLineGeneratorControllerALI.PremiumFU();
        pfu.Priority= '';
        pfu.Offering= '';
        pfu.ReffNo= '';
        pfu.policyNo= '';
        pfu.Product= '';
        pfu.Effective_Date= '';
        pfu.StatusPolis= '';
        //pfu.Month= '';
        pfu.Name_1= '';
        pfu.Premium= 0;
        pfu.RejReason= '';
        //pfu.MobilePhone= '';
        //pfu.MobilePhone2= '';
        //pfu.OfficePhone= '';
        //pfu.OfficePhone2= '';
        //pfu.HomePhone= '';
        //pfu.HomePhone2= '';
        //pfu.Email= '';
        //pfu.Agent= '';
        pfu.Status= '';
        //pfu.Remarks= '';
        //pfu.Changes= '';
        //pfu.LastCall= '';
        //pfu.LastSMS= '';
        //pfu.UploadDate= '';
        //pfu.ResultDate= '';
        pfu.Old_Result= '';
        CallLineGeneratorControllerALI.Conservation consv = new CallLineGeneratorControllerALI.Conservation();
        consv.policyNo= '';
        consv.prevAccBalance= 0;
        consv.totalWithdrawn= 0;
        consv.premium= 0;
        consv.currcy= '';
        CallLineGeneratorControllerALI.Callback cb = new CallLineGeneratorControllerALI.Callback();
        cb.phoneNo= '';
        cb.preferredPhoneNo= '';
        cb.callDate= Date.today();
        CallLineGeneratorControllerALI.Claim claim1 = new CallLineGeneratorControllerALI.Claim();
        claim1.Request_Date= '';
        claim1.Claim_No= '';
        claim1.Policy_No= '';
        claim1.Policy_Holder_Name= '';
        claim1.Follow_Up_Information= '';
        claim1.Dateline= '';
        claim1.No= 0;
        claim1.FollowUpResult= '';
        CallLineGeneratorControllerALI.UpdateData ud = new CallLineGeneratorControllerALI.UpdateData();
        ud.Policy_No= '';
        ud.TITLE= '';
        ud.NAME_1= '';
        ud.BIRTHDATE= '';
        ud.EMAIL= '';
        ud.MOBILEPHONE= '';
        ud.REMARKS= '';
        ud.UpdateEmail= '';
        ud.KTP= '';
        ud.FU= '';
        ud.ASSIGN= '';
        CallLineGeneratorControllerALI.NCB ncb1 = new CallLineGeneratorControllerALI.NCB();
        ncb1.POLICY_NO= '';
        ncb1.Name_1= '';
        ncb1.MOBILEPHONE= '';
        ncb1.MOBILEPHONE2= '';
        ncb1.EMAIL= '';
        ncb1.IDENTITYNO= '';
        ncb1.EFFECTIVEDATE= '';
        ncb1.PAIDTODATE= '';
        ncb1.MONTHSPAID= '';
        ncb1.TOTALNCB= '';
        ncb1.PRODUCT= '';
        ncb1.STATUS= '';
        ncb1.NamaBank= '';
        ncb1.NomorRekening= '';
        ncb1.NamaPemilikRekening= '';
        ncb1.Keterangan= '';
        ncb1.Agent= '';
        CallLineGeneratorControllerALI.SurveyFeedback sfbk = new CallLineGeneratorControllerALI.SurveyFeedback();
        sfbk.Date_Time= '';
        sfbk.MobilePhone= '';
        sfbk.Q1= '';
        sfbk.Q2= '';
        sfbk.Topic= '';
        sfbk.Remarks= '';
        sfbk.Policy_No= '';
        sfbk.No= 0;
        sfbk.Agent_ID= '';
        CallLineGeneratorControllerALI.CollectionTask ct = new CallLineGeneratorControllerALI.CollectionTask();
        ct.ReturPayment= '';
        ct.policyNo= '';
        ct.PolicyHolder= '';
        ct.StatusPolis= '';
        ct.Nominal= 0;
        ct.PeriodeTerdebet= '';
        ct.BANKNAME= '';
        ct.BANKACCNUMBER= '';
        ct.BANKACCNAME= '';
        CallLineGeneratorControllerALI.AgentAssignment aa = new CallLineGeneratorControllerALI.AgentAssignment();
        aa.agentId= '';
        aa.agentName= '';
        aa.policyTotal= 0;
        CallLineGeneratorControllerALI.ReloadWrapper rw = new CallLineGeneratorControllerALI.ReloadWrapper();
        rw.id= '';
        rw.agentName= '';
        rw.policyNo= '';
        rw.isSelected= false;
        rw.callStatus= '';
        rw.reasonStatus= '';
        
        Profile spvProfileALI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%ALI' limit 1];
        Profile agentProfileALI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%ALI' limit 1]; 
        
        User loginALIUser = new User(Alias = 'spv1', Email='spvAli@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='spvAli', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = spvProfileALI.Id, Entity__c = 'ALI', 
      			TimeZoneSidKey='Asia/Jakarta', UserName='spvAli@axa.co.id');
        insert loginALIUser;
        
        User subOrdinateALIUser = new User(Alias = 'agent1', Email='agentAli@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentAli', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileALI.Id, managerId = loginALIUser.id, Entity__c = 'ALI',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentAli@axa.co.id', isActive = true, Agent__c = true,
                Outbound_Activity_Case_type__c = 'Confirmation');
        insert subOrdinateALIUser;
        
        User_Detail__c udetail1 = new User_Detail__c();
        udetail1.User__c = loginALIUser.Id;
        udetail1.Outbound_Activity_Case_type__c = 'Confirmation';
        insert udetail1;
        
        User_Detail__c udetail2 = new User_Detail__c();
        udetail2.User__c = subOrdinateALIUser.Id;
        udetail2.Outbound_Activity_Case_type__c = 'Confirmation';
        insert udetail2;
        
        //Create Campaign
        Call_List__c campALI = new Call_List__c();
         campALI.Campaign_Name__c = 'test campaign ali';
         campALI.Entity__c = 'ALI';
         campALI.Activity__c = 'Confirmation';
         campALI.Case_Type_Config__c = 'Claim';
         campALI.Case_Type__c = 'Claim';
         campALI.ownerid = loginALIUser.id;
         campALI.IsExpired__c = false;
         campALI.Expired_Date__c = Datetime.now().addDays(1).date();
         campALI.CreatedDate = system.today() - 10;
         campALI.CreatedById = loginALIUser.id;
        insert campALI;
        
        Call_List__c campALI2 = new Call_List__c();
         campALI2.Campaign_Name__c = 'test campaign ali2';
         campALI2.Entity__c = 'ALI';
         campALI2.Activity__c = 'Confirmation';
         campALI2.Case_Type_Config__c = 'Claim';
         campALI2.Case_Type__c = 'Claim';
         campALI2.ownerid = loginALIUser.id;
         campALI2.IsExpired__c = false;
         campALI2.Expired_Date__c = Datetime.now().addDays(1).date();
         campALI2.CreatedDate = system.today() - 10;
         campALI2.CreatedById = loginALIUser.id;
        insert campALI2;
        
        //create distribution call
        Call_Line__c callALI1 = new Call_Line__c();
         callALI1.Call_List__c = campALI.id;
         callALI1.ownerid = loginALIUser.id;
         callALI1.Activity__c = 'Confirmation';
         callALI1.Policy_No__c = 'ali001';
         callALI1.Agent__c  = null;
         callALI1.Call_Status_Config__c = 'Contacted';		//callAFI1.Activity_Result__c = 'Contacted';
         callALI1.Reason_Status_Config__c = 'Agree'; 		//callAFI1.Verification__c = 'Agree'; 
         callALI1.Call_Remarks__c = 'OK';
         callALI1.Entity__c = 'ALI';
         callALI1.Parent_Campaign__c = campALI.Id;
        insert callALI1;
        
        Call_Line__c callALI2 = new Call_Line__c();
         callALI2.Call_List__c = campALI2.id;
         callALI2.ownerid = loginALIUser.id;
         callALI2.Activity__c = 'Confirmation';
         callALI2.Policy_No__c = 'ali002';
         callALI2.Agent__c  = null;
         callALI2.Call_Status_Config__c = 'Contacted';		//callAFI1.Activity_Result__c = 'Contacted';
         callALI2.Reason_Status_Config__c = 'Agree'; 		//callAFI1.Verification__c = 'Agree'; 
         callALI2.Call_Remarks__c = 'OK';
         callALI2.Entity__c = 'ALI';
         callALI2.Parent_Campaign__c = campALI2.Id;
        insert callALI2;
        
        fucAli.choosen_campaign = campALI.Id;
        fucAli.populateFreshData();
        fucAli.populateReloadFreshData();
        fucAli.populateCallAndReasonStatus();
        
        fucAli.choosen_method = 'Automatic';
        fucAli.distribute();
        fucAli.choosen_method = 'Manual';
        fucAli.distribute();
        fucAli.choosen_method = 'Specific';
        fucAli.distribute();
        
        fucAli.reset();
        
        List<CallLineGeneratorControllerALI.ReloadWrapper> rwList = new List<CallLineGeneratorControllerALI.ReloadWrapper>();
        CallLineGeneratorControllerALI.ReloadWrapper rw1 = new CallLineGeneratorControllerALI.ReloadWrapper();
        rw1.isSelected = true;
        rw1.Id = callALI2.Id;
        rwList.add(rw1);
        fucAli.reloadWrap = rwList;
        
        fucAli.release();
        fucAli.releaseReload();
        
        fucAli.choosen_agent = 'All';
        List<Id> agList = new List<Id>();
        agList.add(subOrdinateALIUser.Id);
        fucAli.agentIDList = agList;
        System.debug('***choosen_campaign: ' + campALI.Id);
     	System.debug('***agentIDList: ' + agList);
        
        Call_Line__c callALI3 = new Call_Line__c();
         callALI3.Call_List__c = campALI.id;
         callALI3.ownerid = loginALIUser.id;
         callALI3.Activity__c = 'Confirmation';
         callALI3.Policy_No__c = 'ali002';
         callALI3.Agent__c  = subOrdinateALIUser.Id;
         callALI3.Call_Status_Config__c = 'Contacted';		//callAFI1.Activity_Result__c = 'Contacted';
         callALI3.Reason_Status_Config__c = 'Agree'; 		//callAFI1.Verification__c = 'Agree'; 
         callALI3.Call_Remarks__c = 'OK';
         callALI3.Entity__c = 'ALI';
         callALI3.Parent_Campaign__c = campALI.Id;
        insert callALI3;
        fucAli.getListToReload();
        
        fucAli.upload();
        
        Document doc1 = new Document();
        doc1.Name = 'Test_Doc.csv';
        doc1.Body = Blob.valueOf('Unit Test Document Body');
        doc1.ContentType = 'text/csv';
        fucAli.document = doc1;
        Map<String,Call_List__c> clMap = new Map<string,Call_List__c>();
        clMap.put(campALI.Id, campALI);
        fucAli.campaignObjectMap = clMap;
        fucAli.upload();
        
        fucAli.choosen_campaign = '';
        fucAli.upload();
        
        fucAli.isMethodChoosen = false;
        fucAli.save();
        fucAli.isMethodChoosen = true;
        fucAli.choosen_method = 'Manual';
        fucAli.save();
        
        fucAli.cumaUntukTestClass();
        
        Test.stopTest();
    }
    
    private static testMethod void setupTestWelcomeCall() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();
        //welcome call
        Call_List__c campALI3 = new Call_List__c();
         campALI3.Campaign_Name__c = 'test campaign ali3';
         campALI3.Entity__c = 'ALI';
         campALI3.Activity__c = 'Confirmation';
         campALI3.Case_Type_Config__c = 'Welcome Call';
         campALI3.Case_Type__c = 'Welcome Call';
         campALI3.IsExpired__c = false;
         campALI3.Expired_Date__c = Datetime.now().addDays(1).date();
         campALI3.CreatedDate = system.today() - 10;
        insert campALI3;
        Document doc3 = new Document();
        doc3.Name = 'Test_Doc3.csv';
        doc3.Body = Blob.valueOf('Unit Test Document Body3');
        doc3.ContentType = 'text/csv';
        fucAli.document = doc3;
        Map<String,Call_List__c> clMap3 = new Map<string,Call_List__c>();
        clMap3.put(campALI3.Id, campALI3);
        fucAli.campaignObjectMap = clMap3;
        fucAli.choosen_campaign = campALI3.Id;
        fucAli.upload();
        Test.stopTest();
    }
    
    private static testMethod void setupTestReinstate() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();
        //reinstate
        Call_List__c campALI4 = new Call_List__c();
         campALI4.Campaign_Name__c = 'test campaign ali4';
         campALI4.Entity__c = 'ALI';
         campALI4.Activity__c = 'Confirmation';
         campALI4.Case_Type_Config__c = 'Reinstate';
         campALI4.Case_Type__c = 'Reinstate';
         campALI4.IsExpired__c = false;
         campALI4.Expired_Date__c = Datetime.now().addDays(1).date();
         campALI4.CreatedDate = system.today() - 10;
        insert campALI4;
        Document doc4 = new Document();
        doc4.Name = 'Test_Doc4.csv';
        doc4.Body = Blob.valueOf('Unit Test Document Body4');
        doc4.ContentType = 'text/csv';
        fucAli.document = doc4;
        Map<String,Call_List__c> clMap4 = new Map<string,Call_List__c>();
        clMap4.put(campALI4.Id, campALI4);
        fucAli.campaignObjectMap = clMap4;
        fucAli.choosen_campaign = campALI4.Id;
        fucAli.upload();
        Test.stopTest();
    }
    
    private static testMethod void setupTestPremiumFU() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();
        //Insert Account
        Account acc = new Account();
        acc.Name = 'Test Account ALI';
        acc.Entity__c = 'ALI';
        Insert acc;
        
        //Insert Contact
        Contact con = new Contact();
        con.LastName = 'test Contact LALI';
        con.AccountId = acc.Id;
        con.Policy_No__c = 'test';
        con.Entity__c = 'ALI';
        con.Email = 'contactali@gmail.com';
        con.MobilePhone = '123456789';
        con.HomePhone = '123456789';
        Insert con;
        
        //premium fuuuu
        Call_List__c campALI5 = new Call_List__c();
         campALI5.Campaign_Name__c = 'test campaign ali5';
         campALI5.Entity__c = 'ALI';
         campALI5.Activity__c = 'Confirmation';
         campALI5.Case_Type_Config__c = 'Premium FU';
         campALI5.Case_Type__c = 'Premium FU';
         campALI5.IsExpired__c = false;
         campALI5.Expired_Date__c = Datetime.now().addDays(1).date();
         campALI5.CreatedDate = system.today() - 10;
        insert campALI5;
        
        //Insert Call Line
        Call_Line__c cl = new Call_Line__c();
        cl.Call_Status_Config__c = 'Hold';
        cl.Policy_No__c = '517-8475390';
        cl.Contact__c = con.Id;
        cl.Remark_Hold_Debet__c = 'test';
        cl.Call_List__c = campALI5.Id;
        cl.APE_Total_Child__c = 1000000;
        cl.Entity__c = 'ALI';
        cl.Activity__c = 'Collection';
        cl.Policy_No__c = 'test';
        cl.Contacted_Number__c = '123456789';
        cl.Home_Phone__c = '1234567';
        cl.Name_1__c = '';
        Insert cl;
        
        
        Document doc5 = new Document();
        doc5.Name = 'Test_Doc5.csv';
        doc5.Body = Blob.valueOf('Unit Test Document Body5');
        doc5.ContentType = 'text/csv';
        fucAli.document = doc5;
        Map<String,Call_List__c> clMap5 = new Map<string,Call_List__c>();
        clMap5.put(campALI5.Id, campALI5);
        fucAli.campaignObjectMap = clMap5;
        fucAli.choosen_campaign = campALI5.Id;
        fucAli.upload();
        fucAli.groupingCallLine();
        Test.stopTest();
    }
    
    private static testMethod void setupTestUpdateData() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();
        //update data
        Call_List__c campALI6 = new Call_List__c();
         campALI6.Campaign_Name__c = 'test campaign ali6';
         campALI6.Entity__c = 'ALI';
         campALI6.Activity__c = 'Confirmation';
         campALI6.Case_Type_Config__c = 'Update Data';
         campALI6.Case_Type__c = 'Update Data';
         campALI6.IsExpired__c = false;
         campALI6.Expired_Date__c = Datetime.now().addDays(1).date();
         campALI6.CreatedDate = system.today() - 10;
        insert campALI6;
        Document doc6 = new Document();
        doc6.Name = 'Test_Doc6.csv';
        doc6.Body = Blob.valueOf('Unit Test Document Body6');
        doc6.ContentType = 'text/csv';
        fucAli.document = doc6;
        Map<String,Call_List__c> clMap6 = new Map<string,Call_List__c>();
        clMap6.put(campALI6.Id, campALI6);
        fucAli.campaignObjectMap = clMap6;
        fucAli.choosen_campaign = campALI6.Id;
        fucAli.upload();
        Test.stopTest();
    }
    
    private static testMethod void setupTestNCB() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();
        //update data
        Call_List__c campALI6 = new Call_List__c();
         campALI6.Campaign_Name__c = 'test campaign ali6';
         campALI6.Entity__c = 'ALI';
         campALI6.Activity__c = 'Conservation';
         campALI6.Case_Type_Config__c = 'NCB';
         campALI6.Case_Type__c = 'NCB';
         campALI6.IsExpired__c = false;
         campALI6.Expired_Date__c = Datetime.now().addDays(1).date();
         campALI6.CreatedDate = system.today() - 10;
        insert campALI6;
        Document doc6 = new Document();
        doc6.Name = 'Test_Doc6.csv';
        doc6.Body = Blob.valueOf('Unit Test Document Body6');
        doc6.ContentType = 'text/csv';
        fucAli.document = doc6;
        Map<String,Call_List__c> clMap6 = new Map<string,Call_List__c>();
        clMap6.put(campALI6.Id, campALI6);
        fucAli.campaignObjectMap = clMap6;
        fucAli.choosen_campaign = campALI6.Id;
        fucAli.upload();
        Test.stopTest();
    }
    
    private static testMethod void setupTestSurveyFeedback() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();
        //update data
        Call_List__c campALI6 = new Call_List__c();
         campALI6.Campaign_Name__c = 'test campaign ali6';
         campALI6.Entity__c = 'ALI';
         campALI6.Activity__c = 'Survey Feedback';
         campALI6.Case_Type_Config__c = '';
         campALI6.Case_Type__c = '';
         campALI6.IsExpired__c = false;
         campALI6.Expired_Date__c = Datetime.now().addDays(1).date();
         campALI6.CreatedDate = system.today() - 10;
        insert campALI6;
        Document doc6 = new Document();
        doc6.Name = 'Test_Doc6.csv';
        doc6.Body = Blob.valueOf('Unit Test Document Body6');
        doc6.ContentType = 'text/csv';
        fucAli.document = doc6;
        Map<String,Call_List__c> clMap6 = new Map<string,Call_List__c>();
        clMap6.put(campALI6.Id, campALI6);
        fucAli.campaignObjectMap = clMap6;
        fucAli.choosen_campaign = campALI6.Id;
        fucAli.upload();
        Test.stopTest();
    }
    
    private static testMethod void setupTestCollectionTask() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();
        //update data
        Call_List__c campALI6 = new Call_List__c();
         campALI6.Campaign_Name__c = 'test campaign ali6';
         campALI6.Entity__c = 'ALI';
         campALI6.Activity__c = 'Confirmation';
         campALI6.Case_Type_Config__c = 'Collection Task';
         campALI6.Case_Type__c = 'Collection Task';
         campALI6.IsExpired__c = false;
         campALI6.Expired_Date__c = Datetime.now().addDays(1).date();
         campALI6.CreatedDate = system.today() - 10;
        insert campALI6;
        Document doc6 = new Document();
        doc6.Name = 'Test_Doc6.csv';
        doc6.Body = Blob.valueOf('Unit Test Document Body6');
        doc6.ContentType = 'text/csv';
        fucAli.document = doc6;
        Map<String,Call_List__c> clMap6 = new Map<string,Call_List__c>();
        clMap6.put(campALI6.Id, campALI6);
        fucAli.campaignObjectMap = clMap6;
        fucAli.choosen_campaign = campALI6.Id;
        fucAli.upload();
        Test.stopTest();
    }

    private static testMethod void setupTestSurvey() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();
        //update data
        Call_List__c campALI6 = new Call_List__c();
         campALI6.Campaign_Name__c = 'test campaign ali6';
         campALI6.Entity__c = 'ALI';
         campALI6.Activity__c = 'Survey';
         campALI6.Case_Type_Config__c = '';
         campALI6.Case_Type__c = '';
         campALI6.IsExpired__c = false;
         campALI6.Expired_Date__c = Datetime.now().addDays(1).date();
         campALI6.CreatedDate = system.today() - 10;
        insert campALI6;
        Document doc6 = new Document();
        doc6.Name = 'Test_Doc6.csv';
        doc6.Body = Blob.valueOf('Unit Test Document Body6');
        doc6.ContentType = 'text/csv';
        fucAli.document = doc6;
        Map<String,Call_List__c> clMap6 = new Map<string,Call_List__c>();
        clMap6.put(campALI6.Id, campALI6);
        fucAli.campaignObjectMap = clMap6;
        fucAli.choosen_campaign = campALI6.Id;
        fucAli.upload();
        Test.stopTest();
    }
    
    private static testMethod void setupTestConservation() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();
        //update data
        Call_List__c campALI6 = new Call_List__c();
         campALI6.Campaign_Name__c = 'test campaign ali6';
         campALI6.Entity__c = 'ALI';
         campALI6.Activity__c = 'Conservation';
         campALI6.Case_Type_Config__c = '';
         campALI6.Case_Type__c = '';
         campALI6.IsExpired__c = false;
         campALI6.Expired_Date__c = Datetime.now().addDays(1).date();
         campALI6.CreatedDate = system.today() - 10;
        insert campALI6;
        Document doc6 = new Document();
        doc6.Name = 'Test_Doc6.csv';
        doc6.Body = Blob.valueOf('Unit Test Document Body6');
        doc6.ContentType = 'text/csv';
        fucAli.document = doc6;
        Map<String,Call_List__c> clMap6 = new Map<string,Call_List__c>();
        clMap6.put(campALI6.Id, campALI6);
        fucAli.campaignObjectMap = clMap6;
        fucAli.choosen_campaign = campALI6.Id;
        fucAli.upload();
        Test.stopTest();
    }
    
   private static testMethod void setupTestCallBack() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();
        //update data
        Call_List__c campALI6 = new Call_List__c();
         campALI6.Campaign_Name__c = 'test campaign ali6';
         campALI6.Entity__c = 'ALI';
         campALI6.Activity__c = 'CallBack';
         campALI6.Case_Type_Config__c = 'CallBack';
         campALI6.Case_Type__c = 'CallBack';
         campALI6.IsExpired__c = false;
         campALI6.Expired_Date__c = Datetime.now().addDays(1).date();
         campALI6.CreatedDate = system.today() - 10;
        insert campALI6;
        Document doc6 = new Document();
        doc6.Name = 'Test_Doc6.csv';
        doc6.Body = Blob.valueOf('Unit Test Document Body6');
        doc6.ContentType = 'text/csv';
        fucAli.document = doc6;
        Map<String,Call_List__c> clMap6 = new Map<string,Call_List__c>();
        clMap6.put(campALI6.Id, campALI6);
        fucAli.campaignObjectMap = clMap6;
        fucAli.choosen_campaign = campALI6.Id;
        fucAli.upload();
        Test.stopTest();
    }    
}