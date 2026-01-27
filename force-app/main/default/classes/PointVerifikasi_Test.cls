@isTest
public class PointVerifikasi_Test {
    
    public static Id rmRTCL= Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Call Line Customer Segmentation').getRecordTypeId();
    public static Id  rtCustSegCampaign = Schema.SObjectType.Call_list__c.getRecordTypeInfosByName().get('Customer Segmentation AMFS').getRecordTypeId();
    
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
        callAFI1.Error_Nama_PP_TT__c = 'Internal';
        callAFI1.Error_DOB__c = 'Internal';
        callAFI1.Error_Alamat__c = 'Internal';
        callAFI1.Error_Telepon__c = 'Internal';
        callAFI1.Error_Email__c = 'Internal';
        callAFI1.Error_Agent_Validation__c = 'Eksternal';
        callAFI1.Error_Understand_Product__c = 'Eksternal';
        callAFI1.Error_ePolicy_Buku_Polis__c = 'Eksternal';
        callAFI1.Jawaban_Nama_PP_TT__c = 'Ya';
        callAFI1.Jawaban_DOB__c = 'Ya';
        callAFI1.Jawaban_Alamat__c = 'Ya';
        callAFI1.Jawaban_Telepon__c = 'Ya';
        callAFI1.Jawaban_Email__c = 'Tidak';
        callAFI1.Jawaban_Agent_Validation__c = 'Tidak';
        callAFI1.Jawaban_Understand_Product__c = 'Tidak';
        callAFI1.Jawaban_ePolicy_Buku_Polis__c = 'Tidak';
        callAFI1.Remarks_Nama_PP_TT__c = 'test Remarks Nama';
        callAFI1.Remarks_DOB__c = 'test Remarks DOB';
        callAFI1.Remarks_Alamat__c = 'test Remarks Alamat';
        callAFI1.Remarks_Telepon__c = 'test Remarks Telepon';
        callAFI1.Remarks_Email__c = 'test Remarks Email';
        callAFI1.Remarks_Agent_Validation__c = 'test Remarks Agent Validation';
        callAFI1.Remarks_Understand_Product__c = 'test Remarks Understand Product';
        callAFI1.Remarks_ePolicy_Buku_Polis__c = 'test Remarks ePolicy/Buku Polis';
        callAFI1.Call_Status_Config__c = 'Contacted';
        callAFI1.Reason_Status_Config__c = 'Agree - Koreksi data polis';
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
        
        
        system.runAs(subOrdinateAFIUser){
            ApexPages.StandardController sc = new ApexPages.StandardController(callAFI1);
            PageReference pageRef = Page.Point_Verifikasi; // Add your VF page Name here
            pageRef.getParameters().put('Id', String.valueOf(callAFI1.Id));
            Test.setCurrentPage(pageRef);
            
            PointVerifikasi pointVerifikasiAFI = new PointVerifikasi();
            pointVerifikasiAFI.getJawabanOptions();
            pointVerifikasiAFI.updateFieldVisibility();
            pointVerifikasiAFI.save();
            pointVerifikasiAFI.cancel();
            system.debug('>>>> loggedInUser id : '+subOrdinateAFIUser);
            system.debug('>>>> loginAFIUser id : '+subOrdinateAFIUser.id);
        }
        
        Test.stopTest(); 
    }
}