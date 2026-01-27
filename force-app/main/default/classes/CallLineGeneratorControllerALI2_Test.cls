@isTest(seeAllData=true)
public class CallLineGeneratorControllerALI2_Test {
    private static testMethod void setupTestData() {
        Test.startTest();
        
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();
                
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
         callALI1.Call_Status_Config__c = 'Contacted';      //callAFI1.Activity_Result__c = 'Contacted';
         callALI1.Reason_Status_Config__c = 'Agree';        //callAFI1.Verification__c = 'Agree'; 
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
         callALI2.Call_Status_Config__c = 'Contacted';      //callAFI1.Activity_Result__c = 'Contacted';
         callALI2.Reason_Status_Config__c = 'Agree';        //callAFI1.Verification__c = 'Agree'; 
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
         callALI3.Call_Status_Config__c = 'Contacted';      //callAFI1.Activity_Result__c = 'Contacted';
         callALI3.Reason_Status_Config__c = 'Agree';        //callAFI1.Verification__c = 'Agree'; 
         callALI3.Call_Remarks__c = 'OK';
         callALI3.Entity__c = 'ALI';
         callALI3.Parent_Campaign__c = campALI.Id;
        insert callALI3;
        
        fucAli.getListToReload();
         
        fucAli.save();
        
        fucAli.cumaUntukTestClass();
        
        Test.stopTest();
    }
    private static testMethod void setupTestClaim() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();

        Document document;

        document = new Document();
        document.Body = Blob.valueOf('No,Request_Date,Claim_No,Policy_No,Policy_Holder_Name,Follow_Up_Information,Dateline,Follow_Up_Result \n'+
        '1,12-Oct-17,201710060001,100-100-0127089,TRIYANI NUVI ASTUTI,Pending Premium,13-Oct-17, \n'+
        '2,12-Oct-17,201710090028,1030414-0063127,MIRWAN,Pending Premium,16-Oct-17, \n'+
        '3,12-Oct-17,201710050001 & 201710090004,1030414-0031903,KOMARI,"PD. rincian biaya rawat inap, KTP PP, KTP TTG, KK yg lebih jelas",12-Oct-17, \n'+
        '3,12-Oct-17,201710050001 & 201710090004,1001114-0040507,KOMARI,"PD. rincian biaya rawat inap, KTP PP, KTP TTG, KK yg lebih jelas",12-Oct-17, \n'+
        '4,12-Oct-17,201710050012,1030401-1050781,YAUMIL FATHA,"PD. form klaim, form SKD, buku tab PP, hasil lab (jika diagnosa DHF)",12-Oct-17, \n'+
        '5,12-Oct-17,201710060011,1030401-0696537,PRABOWO BUDI UTOMO. SE,"PD. Form Klaim, SKD , Rincian Biaya , Copy Buk tab ",13-Oct-17, \n'+
        '6,12-Oct-17,201710090007,1030401-0119833,JONI,PD. KTP PP,16-Oct-17, \n'+
        '7,12-Oct-17,201710090012,1030401-0816614,HAMDAN NASRO. ST,"PD: Form Klaim, Copy buku tabungan ",16-Oct-17, \n'+
        '8,12-Oct-17,201710090016 & 201710090017,1030404-0003874,SUGENG RIYANTO,pending SKD dan hasil pemeriksaan penunjang dan copy buku tab beneficiary,16-Oct-17, \n'+
        '9,12-Oct-17,201710100002,1030401-0406769,IRMA SYAMSUDDIN,PD. akte lahir TTG/KK + Pending premi,17-Oct-17, \n'+
        '10,12-Oct-17,201710100024,1030401-0182107,DWITA ANDRIANI. S.PSI,"PD. KTP PP, buku tab PP",17-Oct-17, \n'+
        '11,12-Oct-17,201710100028,1030401-0710951,HARTINI SUTIKNO,PD. KTP PP,17-Oct-17, \n'+
        '12,12-Oct-17,201710110001 & 201710110005,1001107-0006353,LINIASIH,PD: Form Klaim + Form Klaim Rawat Jalan,18-Oct-17, \n'+
        '13,12-Oct-17,201710110008,1001107-0073826,LENNY MARLINA. SPD,PD. KK / akte Nikah,18-Oct-17, \n'+
        '');
        document.Name = 'Test_Doc.csv';
        document.ContentType = 'text/csv';
        document.DeveloperName = 'my_document';
        document.IsPublic = true;
        
        call_List__c newcl = new call_List__c();
        newcl.Activity__c = 'Confirmation';
        newcl.Activity_Config__c = 'Confirmation';
        newcl.Case_Type_Config__c = 'Claim';
        newcl.Case_Type__c = 'Claim';
        newcl.Expired_Date__c = date.today()+20;
        newcl.Campaign_Name__c = 'Test Claim';
        newcl.Entity__c = 'ALI';
        insert newcl;
        call_List__c newcl2 = [SELECT id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Call_Line_RecordTypeID__c FROM call_List__c WHERE id=:newcl.id];
        Map<String,Call_List__c> clMap2 = new Map<string,Call_List__c>();
        clMap2.put(newcl.Id, newcl2);
        fucAli.campaignObjectMap = clMap2;
        fucAli.choosen_campaign = newcl2.Id;

        fucAli.document = document;
        fucAli.upload();
        
        Test.stopTest();
    }

    private static testMethod void setupTestWelcome() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();

        Document document;

        document = new Document();
        document.Body = Blob.valueOf('Policy_No,Product,DESCRIPTION,Effective_Date,Name_1,Name_2,LINE1,LINE11,LINE12,LINE13,CITY,ZIPCODE,MOBILEPHONE,MOBILEPHONE2,OFFICEPHONE,OFFICEPHONE2,HOMEPHONE,HOMEPHONE2,EMAIL,CORRESPONDENCETYPEID,delivereddate,REPORT \n'+
        '220-312-00000XX,HPE01,CC,28/08/2017 8:37,ANN MARIE,,,,,,,,,,,,,,,E,, \n'+
        '280-101-00099XX,DPPNB,CC,28/08/2017 10:01,HAKIM ADIL,,,,,,,,,,,,,,,E,, \n'+
        '280-101-00083XX,DPPNB,CC,28/08/2017 10:00,ARFFAA,,,,,,,,,,,,,,,E,, \n'+
        '1030401-10711XX,HPPNB,Saving,28/08/2017 10:03,RACHGYUI,,,,,,,,,,,,,,,E,, \n'+
        '1030401-10513XX,HPPNB,Saving,28/08/2017 10:03,YATRAGAH,,,,,,,,,,,,,,,E,, \n'+
        '');
        document.Name = 'Test_Doc.csv';
        document.ContentType = 'text/csv';
        document.DeveloperName = 'my_document';
        document.IsPublic = true;
        
        call_List__c newcl = new call_List__c();
        newcl.Activity__c = 'Confirmation';
        newcl.Activity_Config__c = 'Confirmation';
        newcl.Case_Type_Config__c = 'Welcome Call';
        newcl.Case_Type__c = 'Welcome Call';
        newcl.Expired_Date__c = date.today()+20;
        newcl.Campaign_Name__c = 'Test Claim';
        newcl.Entity__c = 'ALI';
        insert newcl;
        call_List__c newcl2 = [SELECT id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Call_Line_RecordTypeID__c FROM call_List__c WHERE id=:newcl.id];
        Map<String,Call_List__c> clMap2 = new Map<string,Call_List__c>();
        clMap2.put(newcl.Id, newcl2);
        fucAli.campaignObjectMap = clMap2;
        fucAli.choosen_campaign = newcl2.Id;

        fucAli.document = document;
        fucAli.upload();
        
        Test.stopTest();
    }

    private static testMethod void setupTestUpdateData() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();

        Document document;

        document = new Document();
        document.Body = Blob.valueOf('Policy_No,TITLE,NAME_1,BIRTHDATE,EMAIL,UPDATE EMAIL ,KTP,FU,ASSIGN,REMARKS \n'+
        ',Bapak,Ade Rusnandar,03/09/1982 12:00,xxxx@gmail.com,,,,,undelivered \n'+
        ',Bapak,Adhie Septiadi,02/09/1981 12:00,,,,,, \n'+
        '');
        document.Name = 'Test_Doc.csv';
        document.ContentType = 'text/csv';
        document.DeveloperName = 'my_document';
        document.IsPublic = true;
        
        call_List__c newcl = new call_List__c();
        newcl.Activity__c = 'Confirmation';
        newcl.Activity_Config__c = 'Confirmation';
        newcl.Case_Type_Config__c = 'Update Data';
        newcl.Case_Type__c = 'Update Data';
        newcl.Expired_Date__c = date.today()+20;
        newcl.Campaign_Name__c = 'Test Claim';
        newcl.Entity__c = 'ALI';
        insert newcl;
        call_List__c newcl2 = [SELECT id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Call_Line_RecordTypeID__c FROM call_List__c WHERE id=:newcl.id];
        Map<String,Call_List__c> clMap2 = new Map<string,Call_List__c>();
        clMap2.put(newcl.Id, newcl2);
        fucAli.campaignObjectMap = clMap2;
        fucAli.choosen_campaign = newcl2.Id;

        fucAli.document = document;
        fucAli.upload();
        
        Test.stopTest();
    }

    private static testMethod void setupTestCollectionTask() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();

        Document document;

        document = new Document();
        document.Body = Blob.valueOf('Retur Payment,No Polis,Policy Holder,Status Polis,Nominal ,Periode Terdebet,BANK NAME,BANK ACC NUMBER,BANK ACC NAME \n'+
        'CO,1030401-1089625,SYACHRIEL A RISKA,Cooling Off,360000,,MANDIRI,1080012815271,SYACHRIEL A RISKA \n'+
        'CO,1030401-1045194,ESAU KAKA,Cooling Off,280000,,MANDIRI,9000010615293,ESAU KAKA \n'+
        'CO,1030401-1024635,TITIK WISWORINI,Cooling Off,480000,,BCA (CC),4520560101064604,TITIK WISWORINI \n'+
        '');
        document.Name = 'Test_Doc.csv';
        document.ContentType = 'text/csv';
        document.DeveloperName = 'my_document';
        document.IsPublic = true;
        
        call_List__c newcl = new call_List__c();
        newcl.Activity__c = 'Confirmation';
        newcl.Activity_Config__c = 'Confirmation';
        newcl.Case_Type_Config__c = 'Collection Task';
        newcl.Case_Type__c = 'Collection Task';
        newcl.Expired_Date__c = date.today()+20;
        newcl.Campaign_Name__c = 'Test Collection Task';
        newcl.Entity__c = 'ALI';
        insert newcl;
        call_List__c newcl2 = [SELECT id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Call_Line_RecordTypeID__c FROM call_List__c WHERE id=:newcl.id];
        Map<String,Call_List__c> clMap2 = new Map<string,Call_List__c>();
        clMap2.put(newcl.Id, newcl2);
        fucAli.campaignObjectMap = clMap2;
        fucAli.choosen_campaign = newcl2.Id;

        fucAli.document = document;
        fucAli.upload();
        
        Test.stopTest();
    }

    private static testMethod void setupTestReinstate() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();

        Document document;

        document = new Document();
        document.Body = Blob.valueOf('Priority,Offering,Refference_No,Policy_No,Product,Effective_Date,Status_Polis,Name_1,Premium,RejReason,MobilePhone,MobilePhone2,OfficePhone,OfficePhone2,HomePhone,HomePhone2,Email,Agent,Status,Remarks,Changes,LastCall,LastSMS,UploadDate,ResultDate \n'+
        'PRIORITY 1,NEW,1030401-07061XX,1030401-07061XX,HPPNB,,LA,RICKY PXX,,,,,,,,,,,,,,,,, \n'+
        'PRIORITY 1,NEW,1030401-07128XX,1030401-07128XX,HPPNB,,LA,MUKROXX,,,,,,,,,,,,,,,,, \n'+
        'PRIORITY 1,NEW,1030401-07128XX,1030401-07128XX,HPPNB,,LA,MUKROXX,,,,,,,,,,,,,,,,, \n'+
        'PRIORITY 1,NEW,1030401-07128XX,1030401-07128XX,HPPNB,,LA,MUKROXX,,,,,,,,,,,,,,,,, \n'+
        'PRIORITY 1,OLD,2201010-00428XX,2201010-00428XX,HSOPNB,,LA,TXUXIXUXX,,,,,,,,,,,,,,,,, \n'+
        'PRIORITY 2,NEW,1030401-07448XX,1030401-07448XX,HPPNB,,LA,FRANSIAxx,,,,,,,,,,,,,,,,, \n'+
        'PRIORITY 2,OLD,1030401-07188XX,1030401-07188XX,HPPNB,,LA,SUWARXX,,,,,,,,,,,,,,,,, \n'+
        'PRIORITY 3,NEW,1001108-00094XX,1001108-00094XX,AXAHSBUM,,LA,TARIIANXXX,,,,,,,,,,,,,,,,, \n'+
        'PRIORITY 3,OLD,100-100-00164XX,100-100-00164XX,AXAHS,,LA,HEROWXX,,,,,,,,,,,,,,,,, \n'+
        'PRIORITY 4,NEW,100-100-00046XX,100-100-00046XX,AXAHS,,LA,IBU BUDI,,,,,,,,,,,,,,,,, \n'+
        'PRIORITY 4,OLD,1030401-05930XX,1030401-05930XX,HPPNB,,LA,YATIANXX,,,,,,,,,,,,,,,,, \n'+
        '');
        document.Name = 'Test_Doc.csv';
        document.ContentType = 'text/csv';
        document.DeveloperName = 'my_document';
        document.IsPublic = true;
        
        call_List__c newcl = new call_List__c();
        newcl.Activity__c = 'Conservation';
        newcl.Activity_Config__c = 'Conservation';
        newcl.Case_Type_Config__c = 'Reinstate';
        newcl.Case_Type__c = 'Reinstate';
        newcl.Expired_Date__c = date.today()+20;
        newcl.Campaign_Name__c = 'Test Reinstate';
        newcl.Entity__c = 'ALI';
        insert newcl;
        call_List__c newcl2 = [SELECT id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Call_Line_RecordTypeID__c FROM call_List__c WHERE id=:newcl.id];
        Map<String,Call_List__c> clMap2 = new Map<string,Call_List__c>();
        clMap2.put(newcl.Id, newcl2);
        fucAli.campaignObjectMap = clMap2;
        fucAli.choosen_campaign = newcl2.Id;

        fucAli.document = document;
        fucAli.upload();
        
        Test.stopTest();
    }
    
    private static testMethod void setupTestPremiumFU() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();

        Document document;

        document = new Document();
        document.Body = Blob.valueOf('Priority,Offering,Refference_No,Policy_No,Product,Effective_Date,Status_Polis,Name_1,Premium,RejReason,Mobile Phone,Mobile Phone1,Office Phone,Office Phone1,Home Phone,Home Phone1,Email,Agent,Status,Remarks,Changes,Last Call,Last SMS,Upload Date,Result Date \n'+
        'PRIORITY 2,OLD,04/08/17-1030401-07887XX,,HPPNB,,IN,AAH ROPIAH,,Inssufficient Funds,,,,,,,,,,,,,,, \n'+
        'PRIORITY 4,OLD,06/07/17-1030401-09641XX,,HPPNB,,IN,AAN HIDAYAT,,Declined / Do Not Honour,,,,,,,,,,,,,,, \n'+
        'PRIORITY 3,OLD,27/07/17-1030401-10739XX,,HPPNB,,PE,AANG GUNAEPI,,Declined / Do Not Honour,,,,,,,,,,,,,,, \n'+
        'PRIORITY 3,OLD,27/07/17-1030401-10739XX2,,HPPNB,,PE,AANG GUNAEPI,,Declined / Do Not Honour,,,,,,,,,,,,,,, \n'+
        'PRIORITY 4,OLD,29/06/17-1030401-05660XX,,HPPNB,,IN,AANG WAHYUDIN,,do not honour,,,,,,,,,,,,,,, \n'+
        'PRIORITY 4,OLD,29/06/17-1030401-05660XX2,,HPPNB,,IN,AANG WAHYUDIN,,do not honour,,,,,,,,,,,,,,, \n'+
        'PRIORITY 3,OLD,08/08/17-1030401-10840XX,,HPPNB,,PE,ABDI ROSALI R,,Customer account not sufficien,,,,,,,,,,,,,,, \n'+
        'PRIORITY 3,NEW,14/08/17-1030401-10913XX,,HPPNB,,PE,ABDON FERNANDO LUMBAN TOBING,,Customer account dormant,,,,,,,,,,,,,,, \n'+
        'PRIORITY 3,OLD,20/07/17-1030401-10672XX,,HPPNB,,PE,ABDUL AZIZ,,FIN ACCT MORE THAN 1,,,,,,,,,,,,,,, \n'+
        'PRIORITY 3,OLD,20/07/17-1030401-10672XX2,,HPPNB,,PE,ABDUL AZIZ,,FIN ACCT MORE THAN 1,,,,,,,,,,,,,,, \n'+
        'PRIORITY 3,NEW,15/08/17-1030401-10918XX,,HPPNB,,PE,ABDUL HAFID,,pick-up/pick-up,,,,,,,,,,,,,,, \n'+
        '');
        document.Name = 'Test_Doc.csv';
        document.ContentType = 'text/csv';
        document.DeveloperName = 'my_document';
        document.IsPublic = true;
        
        call_List__c newcl = new call_List__c();
        newcl.Activity__c = 'Conservation';
        newcl.Activity_Config__c = 'Conservation';
        newcl.Case_Type_Config__c = 'Premium FU';
        newcl.Case_Type__c = 'Premium FU';
        newcl.Expired_Date__c = date.today()+20;
        newcl.Campaign_Name__c = 'Test Reinstate';
        newcl.Entity__c = 'ALI';
        insert newcl;
        call_List__c newcl2 = [SELECT id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Call_Line_RecordTypeID__c FROM call_List__c WHERE id=:newcl.id];
        Map<String,Call_List__c> clMap2 = new Map<string,Call_List__c>();
        clMap2.put(newcl.Id, newcl2);
        fucAli.campaignObjectMap = clMap2;
        fucAli.choosen_campaign = newcl2.Id;

        fucAli.document = document;
        fucAli.upload();
        
        Test.stopTest();
    }    
    
    private static testMethod void setupTestNCB() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();

        Document document;

        document = new Document();
        document.Body = Blob.valueOf('POLICY_NO,Name_1,MOBILEPHONE,MOBILEPHONE2,EMAIL,IDENTITYNO,EFFECTIVEDATE,PAIDTODATE,MONTHSPAID,TOTALNCB,PRODUCT,STATUS,Nama_Bank,Nomor_Rekening,Nama_Pemilik_Rekening,Keterangan,Agent \n'+
        '100-100-0018089,ERWAN ABDILLAH,8161159575,93264204,ERONE_ABDILL@YAHOO.COM,3.17E+15,03-Jul-12,3-Aug-17,61,"16,492,050",AXA Hospital & Save,IN,,,,, \n'+
        '100-100-0019118,SYAHRIR ZACHRI,816913214,NULL,SYAHRIR.ZACHRI@YAHOO.CO.ID,3.07E+15,06-Jul-12,6-Aug-17,61,"12,512,350",AXA Hospital & Save,IN,,,,, \n'+
        '100-100-0020748,STEVEN ANTONI FERNANDO M,87776657433,NULL,steven.antony8272@yahoo.com,3.67E+15,10-Jul-12,10-Aug-17,61,"6,292,800",AXA Hospital & Save,IN,,,,, \n'+
        '100-100-0020544,ARY AFANDI WIRIADISASTRA,816876703,NULL,ary.afandi@msk.co.id,3.60E+15,11-Jul-12,11-Aug-17,61,"6,776,550",AXA Hospital & Save,IN,,,,, \n'+
        '100-100-0021204,T DENLEY SETIAWAN,8121856025,NULL,NULL,3.27E+15,11-Jul-12,11-Aug-17,61,"8,868,750",AXA Hospital & Save,IN,,,,, \n'+
        '');
        document.Name = 'Test_Doc.csv';
        document.ContentType = 'text/csv';
        document.DeveloperName = 'my_document';
        document.IsPublic = true;
        
        call_List__c newcl = new call_List__c();
        newcl.Activity__c = 'Conservation';
        newcl.Activity_Config__c = 'Conservation';
        newcl.Case_Type_Config__c = 'NCB';
        newcl.Case_Type__c = 'NCB';
        newcl.Expired_Date__c = date.today()+20;
        newcl.Campaign_Name__c = 'Test NCB';
        newcl.Entity__c = 'ALI';
        insert newcl;
        call_List__c newcl2 = [SELECT id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Call_Line_RecordTypeID__c FROM call_List__c WHERE id=:newcl.id];
        Map<String,Call_List__c> clMap2 = new Map<string,Call_List__c>();
        clMap2.put(newcl.Id, newcl2);
        fucAli.campaignObjectMap = clMap2;
        fucAli.choosen_campaign = newcl2.Id;

        fucAli.document = document;
        fucAli.upload();
        
        Test.stopTest();
    }    

    private static testMethod void setupTestSurveyFeedback() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();

        Document document;

        document = new Document();
        document.Body = Blob.valueOf('No,Date_Time,Agent ID,MobilePhone,Q1,Q2,Topic,Remarks,Policy_No \n'+
        '1,04/09/2017 16:56,vanisa.al,2157903642,memilih tidak,memilih tidak,ReInstate,Pemulihan Polis,1030401-0282367  \n'+
        '2,04/09/2017 9:29,vanisa.al,7174256845,memilih tidak,memilih tidak,Product Informationn,Free PA (data tidak lengkap), \n'+
        '3,05/09/2017 15:44,vanisa.al,2121472923,memilih tidak,memilih tidak,Product Informationn,Portal Axa Direct,1030401-0652276  \n'+
        '4,05/09/2017 8:58,nuur.cholik,2129018069,memilih tidak,memilih tidak,Product Informationn,Pembatalan Polis,1030401-1102589  \n'+
        '');
        document.Name = 'Test_Doc.csv';
        document.ContentType = 'text/csv';
        document.DeveloperName = 'my_document';
        document.IsPublic = true;
        
        call_List__c newcl = new call_List__c();
        newcl.Activity__c = 'Survey Feedback';
        newcl.Activity_Config__c = 'Survey Feedback';
        //newcl.Case_Type_Config__c = '';
        //newcl.Case_Type__c = '';
        newcl.Expired_Date__c = date.today()+20;
        newcl.Campaign_Name__c = 'Test Survey Feedback';
        newcl.Entity__c = 'ALI';
        insert newcl;
        call_List__c newcl2 = [SELECT id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Call_Line_RecordTypeID__c FROM call_List__c WHERE id=:newcl.id];
        Map<String,Call_List__c> clMap2 = new Map<string,Call_List__c>();
        clMap2.put(newcl.Id, newcl2);
        fucAli.campaignObjectMap = clMap2;
        fucAli.choosen_campaign = newcl2.Id;

        fucAli.document = document;
        fucAli.upload();
        
        Test.stopTest();
    }    
    
    private static testMethod void setupTestConservation() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();

        Document document;

        document = new Document();
        document.Body = Blob.valueOf('Policy_No \n'+
        '1030401-0282367  \n'+
        ' \n'+
        '1030401-0652276  \n'+
        '1030401-1102589  \n'+
        '');
        document.Name = 'Test_Doc.csv';
        document.ContentType = 'text/csv';
        document.DeveloperName = 'my_document';
        document.IsPublic = true;
        
        call_List__c newcl = new call_List__c();
        newcl.Activity__c = 'Conservation';
        newcl.Activity_Config__c = 'Conservation';
        //newcl.Case_Type_Config__c = '';
        //newcl.Case_Type__c = '';
        newcl.Expired_Date__c = date.today()+20;
        newcl.Campaign_Name__c = 'Test Renewal';
        newcl.Entity__c = 'ALI';
        insert newcl;
        call_List__c newcl2 = [SELECT id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Call_Line_RecordTypeID__c FROM call_List__c WHERE id=:newcl.id];
        Map<String,Call_List__c> clMap2 = new Map<string,Call_List__c>();
        clMap2.put(newcl.Id, newcl2);
        fucAli.campaignObjectMap = clMap2;
        fucAli.choosen_campaign = newcl2.Id;

        fucAli.document = document;
        fucAli.upload();
        
        Test.stopTest();
    }    

    private static testMethod void setupTestConfirmation() {
        Test.startTest();
        CallLineGeneratorControllerALI fucAli = new CallLineGeneratorControllerALI();

        Document document;

        document = new Document();
        document.Body = Blob.valueOf('Policy_No \n'+
        '1030401-0282367  \n'+
        ' \n'+
        '1030401-0652276  \n'+
        '1030401-1102589  \n'+
        '');
        document.Name = 'Test_Doc.csv';
        document.ContentType = 'text/csv';
        document.DeveloperName = 'my_document';
        document.IsPublic = true;
        
        call_List__c newcl = new call_List__c();
        newcl.Activity__c = 'Confirmation';
        newcl.Activity_Config__c = 'Confirmation';
        //newcl.Case_Type_Config__c = '';
        //newcl.Case_Type__c = '';
        newcl.Expired_Date__c = date.today()+20;
        newcl.Campaign_Name__c = 'Test Renewal';
        newcl.Entity__c = 'ALI';
        insert newcl;
        call_List__c newcl2 = [SELECT id, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Call_Line_RecordTypeID__c FROM call_List__c WHERE id=:newcl.id];
        Map<String,Call_List__c> clMap2 = new Map<string,Call_List__c>();
        clMap2.put(newcl.Id, newcl2);
        fucAli.campaignObjectMap = clMap2;
        fucAli.choosen_campaign = newcl2.Id;

        fucAli.document = document;
        fucAli.upload();
        
        Test.stopTest();
    }    
}