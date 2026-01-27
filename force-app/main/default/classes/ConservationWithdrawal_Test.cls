@isTest
public class ConservationWithdrawal_Test {
    
    public static Id rmRTCL= Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Call Line Customer Segmentation').getRecordTypeId();
    public static Id  rtCustSegCampaign = Schema.SObjectType.Call_list__c.getRecordTypeInfosByName().get('Customer Segmentation AMFS').getRecordTypeId();
    public static Id rtContactAFI = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Contact').getRecordTypeId();
    
    public static testMethod void testConservationWithdrawal(){
        Test.startTest();
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AFI' limit 1]; 
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AMFS' limit 1]; 
        Profile agentProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%MAGI' limit 1];
        Profile rmAgentAmfs = [SELECT Id FROM Profile WHERE Name like 'RM Agent AMFS' limit 1];  
        
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
                                           TimeZoneSidKey='Asia/Jakarta', UserName='agentAfi@axa.co.id');
        agentList.add(subOrdinateAFIUser);
        
        User subOrdinateAFIUser2 = new User(Alias = 'agent2', Email='agentAfi2@axa.co.id', 
                                           EmailEncodingKey='UTF-8', LastName='agentAfi2', LanguageLocaleKey='en_US', 
                                           LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, managerId = loginAFIUser.id, Entity__c = 'AFI',
                                           TimeZoneSidKey='Asia/Jakarta', UserName='agentAfi2@axa.co.id');
        agentList.add(subOrdinateAFIUser2);
        
        User subOrdinateAFIUser3 = new User(Alias = 'agent3', Email='agentAfi3@axa.co.id', 
                                           EmailEncodingKey='UTF-8', LastName='agentAfi3', LanguageLocaleKey='en_US', 
                                           LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, managerId = loginAFIUser.id, Entity__c = 'AFI',
                                           TimeZoneSidKey='Asia/Jakarta', UserName='agentAfi3@axa.co.id');
        agentList.add(subOrdinateAFIUser3);
        
        User subOrdinateAMFSUser = new User(Alias = 'agent2', Email='agentAmfs@axa.co.id', 
                                            EmailEncodingKey='UTF-8', LastName='agentAmfs', LanguageLocaleKey='en_US', 
                                            LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = loginAMFSUser.id, Entity__c = 'AMFS',
                                            TimeZoneSidKey='Asia/Jakarta', UserName='agentAmfs@axa.co.id');
        agentList.add(subOrdinateAMFSUser);
        
        User subOrdinateRMAMFSUser = new User(Alias = 'agentRM', Email='agentRMAmfs@axa.co.id', 
                                              EmailEncodingKey='UTF-8', LastName='agentRMAmfs', LanguageLocaleKey='en_US', 
                                              LocaleSidKey='en_US', ProfileId = rmAgentAmfs.Id, managerId = loginAMFSUser.id, Entity__c = 'AMFS',
                                              TimeZoneSidKey='Asia/Jakarta', UserName='agentRMAmfs@axa.co.id');
        agentList.add(subOrdinateRMAMFSUser);
        
        User subOrdinateMAGIUser = new User(Alias = 'agent3', Email='agentMagi@axa.co.id', 
                                            EmailEncodingKey='UTF-8', LastName='agentMagi', LanguageLocaleKey='en_US', 
                                            LocaleSidKey='en_US', ProfileId = agentProfileMAGI.Id, managerId = loginMAGIUser.id, Entity__c = 'MAGI',
                                            TimeZoneSidKey='Asia/Jakarta', UserName='agentMagi@axa.co.id');
        agentList.add(subOrdinateMAGIUser);
        insert agentList;
        
        /*       
        User subOrdinateAFIUser = [select id, managerId, Entity__c from user where isActive = true and managerId!=null and Manager.isActive = true and entitY__c = 'AFI' and Agent__c = true limit 1];
        system.debug('>>> subOrdinateAFIUser id : '+subOrdinateAFIUser.id); 
        User loginAFIUser = [select id, Entity__c from user where isActive = true and id = :subOrdinateAFIUser.managerId and entitY__c = 'AFI' limit 1];
        system.debug('>>> loginAFIUser id : '+loginAFIUser.id); 
        
        User subOrdinateAMFSUser = [select id, managerId, Entity__c from user where isActive = true and managerId!=null and Manager.isActive = true and entitY__c = 'AMFS' and Agent__c = true limit 1];
        system.debug('>>> subOrdinateAMFSUser id : '+subOrdinateAMFSUser.id); 
        User loginAMFSUser = [select id, Entity__c from user where isActive = true and id = :subOrdinateAMFSUser.managerId and entitY__c = 'AMFS' limit 1];
        system.debug('>>> loginAMFSUser id : '+loginAMFSUser.id); 
        
        User subOrdinateMAGIUser = [select id, managerId, Entity__c from user where isActive = true and managerId!=null and Manager.isActive = true and entitY__c = 'MAGI' and Agent__c = true limit 1];
        system.debug('>>> subOrdinateMAGIUser id : '+subOrdinateMAGIUser.id); 
        User loginMAGIUser = [select id, Entity__c from user where isActive = true and id = :subOrdinateMAGIUser.managerId and entitY__c = 'MAGI' limit 1];
        system.debug('>>> loginMAGIUser id : '+loginMAGIUser.id); 
        */
        
        //Create Contact
        Contact con = new Contact();
        con.RecordTypeId = rtContactAFI;
        con.LastName = '123';
        con.FirstName = 'Testing';
        con.Policy_No__c = '515-3881890';
        con.PolicyApp__c = 'RLS';
        con.Insured_Name__c = 'Frys4';
        con.Entity__c = 'AFi';
        con.Email = 'testing123@gmail.com';
        con.MobilePhone = '085657585950';
        insert con;
        
        
        //Create Campaign
        List<Call_List__c> callList = new List<Call_List__c>();
        Call_List__c campAFI = new Call_List__c();
        campAFI.Campaign_Name__c = 'test campaign afi';
        campAFI.Entity__c = 'AFI';
        campAFI.Activity__c = 'Renewal';
        campAFI.Case_Type__c = 'Renewal';
        campAFI.ownerid = subOrdinateAFIUser.id;
        campAFI.IsExpired__c = false;
        campAFI.Expired_Date__c = Datetime.now().addDays(1).date();
        callList.add(campAFI);
        
        Call_List__c campAMFS = new Call_List__c();
        campAMFS.Campaign_Name__c = 'test campaign amfs';
        campAMFS.Entity__c = 'AMFS';
        campAMFS.Activity__c = 'Confirmation';
        campAMFS.Case_Type__c = 'Welcome Call';
        campAMFS.ownerid = subOrdinateAMFSUser.id;
        campAMFS.IsExpired__c = false;
        campAMFS.Expired_Date__c = Datetime.now().addDays(1).date();
        callList.add(campAMFS);
        
        Call_List__c campRMAMFS = new Call_List__c();
        campRMAMFS.Campaign_Name__c = 'test RM campaign amfs';
        campRMAMFS.Entity__c = 'AMFS';
        campRMAMFS.Activity__c = 'Customer Segmentation';
        campRMAMFS.Case_Type__c = 'Update';
        campRMAMFS.ownerid = subOrdinateRMAMFSUser.id;
        campRMAMFS.IsExpired__c = false;
        campRMAMFS.Expired_Date__c = Datetime.now().addDays(1).date();
        campRMAMFS.RecordTypeId = rtCustSegCampaign;
        callList.add(campRMAMFS);
        
        Call_List__c campMAGI = new Call_List__c();
        campMAGI.Campaign_Name__c = 'test campaign magi';
        campMAGI.Entity__c = 'MAGI';
        campMAGI.Activity__c = 'Survey';
        campMAGI.Case_Type__c = 'Survey of Claim Service';
        campMAGI.ownerid = subOrdinateMAGIUser.id;
        campMAGI.IsExpired__c = false;
        campMAGI.Expired_Date__c = Datetime.now().addDays(1).date();
        callList.add(campMAGI);
        
        insert callList;
        
        //create distribution call
        Call_Line__c callAFI1 = new Call_Line__c();
        callAFI1.Call_List__c = campAFI.id;
        callAFI1.ownerid = subOrdinateAFIUser.id;
        callAFI1.Activity__c = 'Renewal';
        callAFI1.Policy_No__c = 'afi001';
        callAFI1.Agent__c  = subOrdinateAFIUser.id;
        callAFI1.Activity_Result__c = 'Rescheduled'; 
        callAFI1.Call_Remarks__c = 'OK';
        callAFI1.Entity__c = 'AFI';
        callAFI1.Nilai_Conservation__c = 5000; 
        callAFI1.Nilai_Withdrawal__c = 4000;
        callAFI1.Selisih__c = 1000;
        callAFI1.Offering_Retain__c = 'Retain with withdrawal';
        callAFI1.Call_Status_Config__c = 'Contacted';
        callAFI1.Reason_Status_Config__c = 'Agree - Koreksi data polis';
        callAFI1.Contact__c = con.Id;
        Insert callAFI1;
        
        List<Call_Line__c> disList = new List<Call_Line__c>();
        /*Call_Line__c callAFI1 = new Call_Line__c();
        callAFI1.Call_List__c = campAFI.id;
        callAFI1.ownerid = subOrdinateAFIUser.id;
        callAFI1.Activity__c = 'Renewal';
        callAFI1.Policy_No__c = 'afi001';
        callAFI1.Agent__c  = subOrdinateAFIUser.id;
        callAFI1.Activity_Result__c = 'Rescheduled'; 
        callAFI1.Call_Remarks__c = 'OK';
        callAFI1.Entity__c = 'AFI';
        callAFI1.Nilai_Conservation__c = 5000; 
        callAFI1.Nilai_Withdrawal__c = 4000;
        callAFI1.Selisih__c = 1000;
        callAFI1.Offering_Retain__c = 'Retain with withdrawal';
        callAFI1.Call_Status_Config__c = 'Contacted';
        callAFI1.Reason_Status_Config__c = 'Agree - Koreksi data polis';
        disList.add(callAFI1);*/
        
        Call_Line__c callAFI2 = new Call_Line__c();
        callAFI2.Call_List__c = campAFI.id;
        callAFI2.ownerid = subOrdinateAFIUser.id;
        callAFI2.Activity__c = 'Renewal';
        callAFI2.Policy_No__c = 'afi002';
        callAFI2.Agent__c  = subOrdinateAFIUser.id; 
        callAFI2.Activity_Result__c = 'Rescheduled'; 
        callAFI2.Call_Remarks__c = 'OK';
        callAFI2.Entity__c = 'AFI';
        callAFI2.Nilai_Conservation__c = 10800; 
        callAFI2.Nilai_Withdrawal__c = 8800;
        callAFI2.Selisih__c = 2000;
        callAFI2.Offering_Retain__c = 'Retain with withdrawal';
        callAFI2.Call_Status_Config__c = 'Contacted';
        callAFI2.Reason_Status_Config__c = 'Agree - Update Email';
        disList.add(callAFI2);
        
        Call_Line__c callAFI3 = new Call_Line__c();
        callAFI3.Call_List__c = campAFI.id;
        callAFI3.ownerid = subOrdinateAFIUser.id;
        callAFI3.Activity__c = 'Renewal';
        callAFI3.Policy_No__c = 'afi003';
        callAFI3.Agent__c  = subOrdinateAFIUser.id; 
        callAFI3.Activity_Result__c = 'Rescheduled'; 
        callAFI3.Call_Remarks__c = 'OK';
        callAFI3.Entity__c = 'AFI';
        callAFI2.Nilai_Conservation__c = 3800; 
        callAFI2.Nilai_Withdrawal__c = 800;
        callAFI2.Selisih__c = 3000;
        callAFI2.Offering_Retain__c = 'Retain with withdrawal';
        callAFI2.Call_Status_Config__c = 'Contacted';
        callAFI2.Reason_Status_Config__c = 'Agree - Update Telepon & HP';
        disList.add(callAFI3);
        
        Call_Line__c callAMFS1 = new Call_Line__c();
        callAMFS1.Call_List__c = campAMFS.id;
        callAMFS1.ownerid = subOrdinateAMFSUser.id;
        callAMFS1.Activity__c = 'Confirmation';
        callAMFS1.Policy_No__c = 'amfs001';
        callAMFS1.Agent__c  = subOrdinateAMFSUser.id; 
        callAMFS1.Activity_Result__c = 'Rescheduled'; 
        callAMFS1.Call_Remarks__c = 'OK';
        callAMFS1.Entity__c = 'AMFS';
        disList.add(callAMFS1);
        
        Call_Line__c callAMFS2 = new Call_Line__c();
        callAMFS2.Call_List__c = campAMFS.id;
        callAMFS2.ownerid = subOrdinateAMFSUser.id;
        callAMFS2.Activity__c = 'Confirmation';
        callAMFS2.Policy_No__c = 'amfs002';
        callAMFS2.Agent__c  = subOrdinateAMFSUser.id; 
        callAMFS2.Activity_Result__c = 'Rescheduled'; 
        callAMFS2.Call_Remarks__c = 'OK';
        callAMFS2.Entity__c = 'AMFS';
        disList.add(callAMFS2);
        
        Call_Line__c callRMAMFS1 = new Call_Line__c();
        callRMAMFS1.Call_List__c = campRMAMFS.id;
        callRMAMFS1.ownerid = subOrdinateRMAMFSUser.id;
        callRMAMFS1.Activity__c = 'Confirmation';
        callRMAMFS1.Policy_No__c = 'amfs001';
        callRMAMFS1.Agent__c  = subOrdinateRMAMFSUser.id; 
        callRMAMFS1.Activity_Result__c = 'Rescheduled'; 
        callRMAMFS1.Call_Remarks__c = 'OK';
        callRMAMFS1.Entity__c = 'AMFS';
        callRMAMFS1.RecordTypeId = rmRTCL;
        disList.add(callRMAMFS1);
        
        Call_Line__c callMAGI1 = new Call_Line__c();
        callMAGI1.Call_List__c = campMAGI.id;
        callMAGI1.ownerid = subOrdinateMAGIUser.id;
        callMAGI1.Activity__c = 'Survey';
        callMAGI1.Policy_No__c = 'magi001';
        callMAGI1.Agent__c  = subOrdinateMAGIUser.id; 
        callMAGI1.Activity_Result__c = 'Rescheduled'; 
        callMAGI1.Call_Remarks__c = 'OK';
        callMAGI1.Entity__c = 'MAGI';
        disList.add(callMAGI1);
        
        insert disList;
        
        
        //Create Session Data
        Session_Data__c sd = new Session_Data__c();
        sd.data_name__c = 'test';
        sd.service__c = 'getFundDetail'; 
        sd.operation__c = 'Fund';
        sd.classType__c = 'test';
        sd.refNo__c = 'test';
        sd.session_id__c = '1010101';
        sd.page_name__c = 'Fund Info';
        sd.data__c = 'test';
        sd.data_request__c = 'test';
        insert sd;
        
        
        
        system.runAs(subOrdinateAFIUser){
            ApexPages.StandardController sc = new ApexPages.StandardController(callAFI1);
            PageReference pageRef = Page.Conservation_Withdrawal; // Add your VF page Name here
            pageRef.getParameters().put('Id', String.valueOf(callAFI1.Id));
            Test.setCurrentPage(pageRef);
            
            ConservationWithdrawal conservationAFI = new ConservationWithdrawal();
            conservationAFI.initFundInfo();
            conservationAFI.initMain();
            
            conservationAFI.fundDetailJSON='{"Body":{"operation":"Fund","transactionId":"12345","status":"","entity":"AFI","service":"getProductFundDetail","appID":"RLS","AgSa_InsurancePolicy_Type":{"policyNO":"100-104-1100068","hasAccountDetailsIn":[{"hasInvestmentFundDetailsIn":[{"investmentFundRk":"Anjay","fundCurrencyCd":"IDR","valuationDt":"20161010","investmentFundCd":"999","unitPrice":"100.00","unitPriceAsOfDt":"1500.00"},{"investmentFundRk":"Uhuy","fundCurrencyCd":"IDR","valuationDt":"20161110","investmentFundCd":"999","unitPrice":"200.00","unitPriceAsOfDt":"2500.00"}]}]},"AXAAsiaPagination_Type":{"rowPerPage":"15","numberOfRecords":"2","startDateTime":"2016-08-16 14:43:00","pageNumber":"1","endDateTime":"2016-08-17 14:45:00","startOfRecords":"1"}}}';
            conservationAFI.fundDetailJSON = '{"Body":{"operation":"Fund","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AMFS","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
            conservationAFI.fundDetailJSON = '{"Body":{"operation":"Fund","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AMFS","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
            
            conservationAFI.setJSONVariable( 'getFundHistory::Fund','test');
            conservationAFI.setJSONVariable('getFundDetail::Fund','test');
            conservationAFI.setJSONVariable('getProductFundDetail::Fund','test');
            
            ConservationWithdrawal.FundDetail fundDetailTest = new ConservationWithdrawal.FundDetail();
            fundDetailTest.FundCode = '';
            fundDetailTest.FundUnit = '';
            fundDetailTest.FundAllocation = 0.0;
            fundDetailTest.FundPrice = 0.0;
            fundDetailTest.TotalUnitFund = 0.0;
            fundDetailTest.TotalFundAmount = 0.0;
            fundDetailTest.NAVDate = Date.newInstance(2020, 4, 26);
            fundDetailTest.FundAmount = 0.0;
            fundDetailTest.FundTotal = 0.0;
            fundDetailTest.FundNAVDate = Date.newInstance(2020, 4, 26);
            
            
            conservationAFI.save();
            conservationAFI.cancel();
            system.debug('>>>> loggedInUser id : '+subOrdinateAFIUser);
            system.debug('>>>> loginAFIUser id : '+subOrdinateAFIUser.id);
        }
        
        Test.stopTest(); 
    }
}