@isTest
public class CallLineGeneratorControllerTest{
    static ID rtCustSegCampaign = Schema.SObjectType.Call_list__c.getRecordTypeInfosByName().get('Customer Segmentation AMFS').getRecordTypeId();
    static ID rtConfirmationAMFS = Schema.SObjectType.Call_list__c.getRecordTypeInfosByName().get('Confirmation AMFS').getRecordTypeId();
    static ID rtCallLineWC = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
    static ID rtCallLineAMFS1 = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('AMFS 1').getRecordTypeId();
    
    @testSetup
    static void setupRecord() {
        Profile p2 = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User u2 = new User(
            LastName='Testing2',
            Alias = 'standt2', 
            Email='standarduser1@axa.com', 
            EmailEncodingKey='UTF-8', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US',
            ProfileId = p2.Id,
            TimeZoneSidKey='America/Los_Angeles',
            Entity__c ='AMFS',
            UserName='standarduser1@axa.com'
        );
        insert u2;
    }
    
    public static testMethod void testCustSegmentationUpload(){
        User u = [SELECT Id FROM User WHERE UserName = 'standarduser1@axa.com' LIMIT 1];
        System.runAs(u) {
            Test.startTest();
            Contact con1 = new Contact();
            con1.FirstName = 'Testing';
            con1.LastName = '123';
            con1.Policy_No__c = '511-7298157';
            con1.MobilePhone = '081122334455';
            con1.Entity__c = 'AMFS';
            insert con1;
            
            Case cs = new Case();
            cs.ContactId = con1.Id;
            cs.Status ='New';
            insert cs;
            
            Call_List__c cl = new Call_List__c();
            cl.Campaign_Name__c ='Customer Segmentation';
            cl.Entity__c ='AMFS';
            cl.Activity__c ='Customer Segmentation';
            cl.Case_Type__c ='Update Data';
            cl.IsExpired__c = false;
            cl.Expired_Date__c = Date.newInstance(2028, 5, 23);
            cl.RecordTypeId = rtCustSegCampaign;
            insert cl;
            
            CallLineGeneratorController controlAMFSCust = new CallLineGeneratorController(); 
            controlAMFSCust.choosen_campaign =cl.Id;
            Document document = new Document();
            String body='Policy No, Cust Segmentation \n';
            body = body + '511-7298157,Private \n';
            document.Body = Blob.valueOf(body);
            document.ContentType ='text/plain; charset=UTF-8';
            document.Name = 'Testing Customer Segmentation.csv';
            controlAMFSCust.document = document;
            controlAMFSCust.upload();
            
            controlAMFSCust.Nxtbtn();
            controlAMFSCust.Firstbtn();
            controlAMFSCust.lstbtn();
            controlAMFSCust.getNxt();
            controlAMFSCust.prvbtn();
            controlAMFSCust.getPrv();
            
            
            PageReference openCs = Page.OpenCaseDetail; 
            openCs.getParameters().put('ct', con1.Id);
            Test.setCurrentPage(openCs);
            
            OpenCaseDetailsCtrl openCtrl = new OpenCaseDetailsCtrl();
            openCtrl.Nxtbtn();	
            openCtrl.Firstbtn();
            openCtrl.lstbtn();
            openCtrl.getNxt();
            openCtrl.getPrv();
            
            Call_Line__c call_liner = new Call_Line__c();
            call_liner.Contact__c = con1.id;
            call_liner.Policy_No__c = con1.Policy_No__c;
            call_liner.Contacted_Number__c = con1.MobilePhone;
            call_liner.Home_Phone__c = con1.HomePhone;
            call_liner.Phone__c = con1.Phone;
            call_liner.Entity__c = con1.Entity__c;
            call_liner.Call_List__c = cl.Id;
            call_liner.Activity__c = cl.Activity__c;
            call_liner.Case_Type__c = cl.Case_Type__c; 
            call_liner.Case_Type_Config__c = cl.Case_Type_Config__c;
            LiST<Call_line__c> listCL = new LIST<CALL_LINE__C>();
            listCL.add(call_liner);
            System.enqueueJob(new DMLoperationQueueable(listCL, false));
            
            Test.stopTest();
        }
    }
    
    public static testMethod void testCallLineGeneratorControllerAFI(){
        CallLineGeneratorController callGenController = new CallLineGeneratorController();
        CallLineGeneratorController.ReloadWrapper rw = new CallLineGeneratorController.ReloadWrapper();
        rw.isSelected = true;	
        callGenController.parseCustSegmentationCSV('Testing', true);
        callGenController.parseCSV('Testing', true);
        callGenController.parseConservationCSV('Testing', true);
        callGenController.parseCallbackCSV('Testing', true);
        callGenController.distributeSpecific();
        callGenController.distributeAuto();
        callGenController.distributeManual();
        String[] phoneNo = new String[] {'081122334455', '082233445566'};
            callGenController.processPhone(phoneNo);
        callGenController.isPhoneNumberValid('081122334455');
        callGenController.convertString2Date('2016/11/10');	
        callGenController.cumaUntukTestClass();
        callGenController.refreshList();
        /*

CallLineGeneratorController.OutboundCall oc = new CallLineGeneratorController.OutboundCall();
oc.agentName = 'abcde';
oc.campaignName = 'testing123';
oc.phoneNo = '081122334455';
oc.policyNo = '54321';

CallLineGeneratorController.Conservation conserv = new CallLineGeneratorController.Conservation();
conserv.currcy = 'IDR';
conserv.policyNo = '54321';
conserv.premium = 1000000;
conserv.prevAccBalance = 1000000;
conserv.totalWithdrawn = 700000;

CallLineGeneratorController.Callback callback =  new CallLineGeneratorController.Callback();
callback.callDate = system.today();
callback.phoneNo = '081122334455';
callback.preferredPhoneNo = '081213141516';

CallLineGeneratorController.AgentAssignment agentAssign = new CallLineGeneratorController.AgentAssignment();
agentAssign.agentId = '5150';
agentAssign.agentName = 'James Bond';
agentAssign.policyTotal = 500;
*/
        Test.startTest(); 
        List<Contact> conList = new List<Contact>();
        Contact con1 = new Contact();
        con1.FirstName = 'Testing';
        con1.LastName = '123';
        con1.Policy_No__c = '500-12345';
        con1.MobilePhone = '081122334455';
        con1.Entity__c = 'AFI';
        conList.add(con1);
        
        Contact con2 = new Contact();
        con2.FirstName = 'Testing';
        con2.LastName = '234';
        con2.Policy_No__c = '500-23456';
        con2.MobilePhone = '082233445566';
        con2.Entity__c = 'AFI';
        conList.add(con2);
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AFI' limit 1];
        
        Profile spvProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AFI' limit 1];
        
        List<User> spvList = new List<User>();
        User loginAFIUser = new User(Alias = 'spv1', Email='spvAfi@axa.co.id', 
                                     EmailEncodingKey='UTF-8', LastName='spvAfi', LanguageLocaleKey='en_US', 
                                     LocaleSidKey='en_US', ProfileId = spvProfileAFI.Id, Entity__c = 'AFI', 
                                     TimeZoneSidKey='Asia/Jakarta', UserName='spvAfi@axa.co.id');
        spvList.add(loginAFIUser);
        insert spvList;
        
        List<User> agentList = new List<User>();
        User subOrdinateAFIUser = new User(Alias = 'agent1', Email='agentAfi@axa.co.id', 
                                           EmailEncodingKey='UTF-8', LastName='agentAfi', LanguageLocaleKey='en_US', 
                                           LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, managerId = loginAFIUser.id, Entity__c = 'AFI',
                                           TimeZoneSidKey='Asia/Jakarta', UserName='agentAfi@axa.co.id', isActive = true, Agent__c = true);
        agentList.add(subOrdinateAFIUser);
        insert agentList;
        
        /*
User subOrdinateAFIUser = [select id, managerId, Entity__c from user where isActive = true and managerId!=null and Manager.isActive = true and entitY__c = 'AFI' and Agent__c = true limit 1];
system.debug('>>> subOrdinateAFIUser id : '+subOrdinateAFIUser.id); 
User loginAFIUser = [select id, Entity__c from user where isActive = true and id = :subOrdinateAFIUser.managerId and entitY__c = 'AFI' limit 1];
system.debug('>>> loginAFIUser id : '+loginAFIUser.id); 
*/
        
        //Create Campaign
        List<Call_List__c> callList = new List<Call_List__c>();
        Call_List__c campAFI = new Call_List__c();
        campAFI.Campaign_Name__c = 'test campaign afi';
        campAFI.Entity__c = 'AFI';
        campAFI.Activity__c = 'Renewal';
        campAFI.Case_Type_Config__c = 'Renewal';
        campAFI.ownerid = loginAFIUser.id;
        campAFI.IsExpired__c = false;
        campAFI.Expired_Date__c = Datetime.now().addDays(1).date();
        campAFI.CreatedDate = system.today() - 10;
        campAFI.CreatedById = loginAFIUser.id;
        callList.add(campAFI);
        
        insert callList;
        
        //create distribution call
        List<Call_Line__c> disList = new List<Call_Line__c>();
        Call_Line__c callAFI1 = new Call_Line__c();
        callAFI1.Call_List__c = campAFI.id;
        callAFI1.ownerid = loginAFIUser.id;
        callAFI1.Activity__c = 'Renewal';
        callAFI1.Policy_No__c = 'afi001';
        callAFI1.Agent__c  = subOrdinateAFIUser.id;
        callAFI1.Call_Status_Config__c = 'Contacted';		//callAFI1.Activity_Result__c = 'Contacted';
        callAFI1.Reason_Status_Config__c = 'Agree'; 		//callAFI1.Verification__c = 'Agree'; 
        callAFI1.Call_Remarks__c = 'OK';
        callAFI1.Entity__c = 'AFI';
        disList.add(callAFI1);
        
        Call_Line__c callAFI2 = new Call_Line__c();
        callAFI2.Call_List__c = campAFI.id;
        callAFI2.ownerid = loginAFIUser.id;
        callAFI2.Activity__c = 'Renewal';
        callAFI2.Policy_No__c = 'afi002';
        //callAFI2.Agent__c  = subOrdinateAFIUser.id; 
        callAFI2.Call_Status_Config__c = 'Contacted'; 		//callAFI2.Activity_Result__c = 'Contacted'; 
        callAFI2.Reason_Status_Config__c = 'Agree'; 		//callAFI2.Verification__c = 'Agree'; 
        callAFI2.Call_Remarks__c = 'OK';
        callAFI2.Entity__c = 'AFI';
        disList.add(callAFI2);
        
        Call_Line__c callAFI3 = new Call_Line__c();
        callAFI3.Call_List__c = campAFI.id;
        callAFI3.ownerid = loginAFIUser.id;
        callAFI3.Activity__c = 'Renewal';
        callAFI3.Policy_No__c = 'afi003';
        //callAFI3.Agent__c  = subOrdinateAFIUser.id; 
        callAFI3.Call_Status_Config__c = 'Contacted'; 		//callAFI3.Activity_Result__c = 'Contacted'; 
        callAFI3.Reason_Status_Config__c = 'Agree'; 		//callAFI3.Verification__c = 'Agree'; 
        callAFI3.Call_Remarks__c = 'OK';
        callAFI3.Entity__c = 'AFI';
        disList.add(callAFI3);
        
        insert disList;
        
        String policyBody = 'POLICY_NO\n12345\n67890';
        String phoneBody = 'PHONE_NO,PREFERRED_PHONE_NO,CALL_DATE\n081722266998,,2015-02-01\n02193883993,,';
        String conservationBody = 'POLICY_NO,PREV_ACC_BLC,TOTAL_WITHDRAWN,PREMIUM,CURRENCY\n938839,10000000,5000000,750000,IDR';
        
        CallLineGeneratorController.OutboundCall oc = new CallLineGeneratorController.OutboundCall();
        oc.agentName = 'abcde';
        oc.campaignName = 'testing123';
        oc.phoneNo = '081122334455';
        oc.policyNo = '54321';
        
        CallLineGeneratorController.Conservation conserv = new CallLineGeneratorController.Conservation();
        conserv.currcy = 'IDR';
        conserv.policyNo = '54321';
        conserv.premium = 1000000;
        conserv.prevAccBalance = 1000000;
        conserv.totalWithdrawn = 700000;
        
        CallLineGeneratorController.Callback callback =  new CallLineGeneratorController.Callback();
        callback.callDate = system.today();
        callback.phoneNo = '081122334455';
        callback.preferredPhoneNo = '081213141516';
        
        CallLineGeneratorController.AgentAssignment agentAssign = new CallLineGeneratorController.AgentAssignment();
        agentAssign.agentId = '5150';
        agentAssign.agentName = 'James Bond';
        agentAssign.policyTotal = 500;
        
        system.runAs(loginAFIUser){
            try{
                /*
CallLineGeneratorController.ReloadWrapper rw = new CallLineGeneratorController.ReloadWrapper();
rw.agentName = 'testingAFI';
rw.policyNo = 'afi001';
rw.callStatus = 'Uncontacted';
rw.isSelected = true;	
*/
                CallLineGeneratorController controlAFI = new CallLineGeneratorController(); 
                controlAFI.choosen_campaign = campAFI.Id;
                controlAFI.choosen_agent = subOrdinateAFIUser.Id;
                controlAFI.getListToReload();
                
                //system.assertNotEquals(0, controlAFI.totalAgents);
                system.debug('>>>> loggedInUser id : '+controlAFI.loggedInUser);   
                system.debug('>>>> loginAFIUser id : '+loginAFIUser.id);   
                system.debug('>>> total agent : '+controlAFI.totalAgents); 
                system.debug('>>> entity : '+controlAFI.entity); 
                system.assertEquals('AFI', controlAFI.entity);
                system.assertEquals(0, controlAFI.uploadedNum );
                system.assertEquals(0, controlAFI.validNum );
                system.assertEquals(0, controlAFI.invalidNum );
                controlAFI.document = null;
                
                /*
controlAFI.document = new Document();
controlAFI.document.body = Blob.valueOf(policyBody);
controlAFI.document.FolderId = UserInfo.getUserId();
controlAFI.document.Name = 'Testing AFI';
system.assertEquals(null, controlAFI.upload());
*/
                controlAFI.distribute();
                controlAFI.populateCallAndReasonStatus();
                controlAFI.releaseReload();
                controlAFI.reset();
                controlAFI.populateReloadFreshData();
                
                controlAFI.document = new Document();
                controlAFI.document.body = Blob.valueOf(phoneBody);
                controlAFI.document.FolderId = UserInfo.getUserId();
                controlAFI.document.Name = 'Testing AFI 1';
                controlAFI.choosen_campaign = campAFI.id;
                controlAFI.upload();
                
                //system.assertEquals(null, controlAFI.populateReloadFreshData());
                system.assertEquals(null, controlAFI.populateFreshData());
                system.assertEquals(false, controlAFI.isMethodChoosen);
                
                String[] polNo1 = new String[] {'afi001', 'afi002'};
                    callGenController.processPolicy(polNo1);
                String[] polNo2 = new String[] {'500-12345', '500-23456'};
                    callGenController.processConservation(polNo2);
                String[] polNo3 = new String[] {'500-34567'};
                    callGenController.welcomecallAssign(polNo3);
                //String[] phoneNo = new String[] {'081122334455', '082233445566'};
                //callGenController.processPhone(phoneNo);	
                controlAFI.choosen_method = 'Automatic';
                controlAFI.save();
                system.assertEquals(null, controlAFI.distribute());
                system.assertEquals(true, controlAFI.isMethodChoosen);
                system.assertEquals(null, controlAFI.release());
                controlAFI.choosen_method = 'Manual';
                controlAFI.save();
                system.assertEquals(true, controlAFI.isMethodChoosen);
                system.assertEquals(null, controlAFI.distribute());
                //system.assertEquals(true, controlAFI.isMethodChoosen);
                system.assertEquals(null, controlAFI.release());
                /*
controlAFI.choosen_method = 'Specific';
system.assertEquals(null, controlAFI.distribute());
system.assertEquals(null, controlAFI.release());
controlAFI.save();

controlAFI.distribute();
controlAFI.populateCallAndReasonStatus();
controlAFI.releaseReload();
controlAFI.reset();
controlAFI.populateReloadFreshData();
/*
CallLineGeneratorController.ReloadWrapper rw = new CallLineGeneratorController.ReloadWrapper();
rw.agentName = subOrdinateAFIUser.Id;
rw.policyNo = 'afi001';
rw.callStatus = 'Uncontacted';
rw.isSelected = true;	
*/
                controlAFI.release();
                
                CallLineGeneratorController controlAFI2 = new CallLineGeneratorController(); 
                controlAFI2.choosen_campaign = campAFI.Id;
                controlAFI2.choosen_agent = 'All';
                controlAFI2.getListToReload();
            }catch(Exception e){
                System.debug('e: ' + e.getLineNumber() + '# ' + e.getMessage());
            }
            //system.assertEquals('Renewal', controlAFI.activity);
            //system.assertEquals(3, controlAFI.totalRecords);
        }
    }
    
    public static testMethod void testCallLineGeneratorControllerMAGI(){
        CallLineGeneratorController callGenController = new CallLineGeneratorController();
        CallLineGeneratorController.ReloadWrapper rw = new CallLineGeneratorController.ReloadWrapper();
        rw.isSelected = true;	
        callGenController.parseCustSegmentationCSV('Testing', true);
        callGenController.parseCSV('Testing', true);
        callGenController.parseConservationCSV('Testing', true);
        callGenController.parseCallbackCSV('Testing', true);
        callGenController.distributeSpecific();
        callGenController.distributeAuto();
        callGenController.distributeManual();
        String[] phoneNo = new String[] {'081122334455', '082233445566'};
            callGenController.processPhone(phoneNo);
        callGenController.isPhoneNumberValid('081122334455');
        callGenController.convertString2Date('2016/11/10');	
        callGenController.cumaUntukTestClass();
        callGenController.refreshList();
        /*
CallLineGeneratorController.ReloadWrapper rw = new CallLineGeneratorController.ReloadWrapper();
rw.agentName = 'testing';
rw.policyNo = 'amfs001';
rw.callStatus = 'Uncontacted';
rw.isSelected = true;

CallLineGeneratorController.OutboundCall oc = new CallLineGeneratorController.OutboundCall();
oc.agentName = 'abcde';
oc.campaignName = 'testing123';
oc.phoneNo = '081122334455';
oc.policyNo = '54321';

CallLineGeneratorController.Conservation conserv = new CallLineGeneratorController.Conservation();
conserv.currcy = 'IDR';
conserv.policyNo = '54321';
conserv.premium = 1000000;
conserv.prevAccBalance = 1000000;
conserv.totalWithdrawn = 700000;

CallLineGeneratorController.Callback callback =  new CallLineGeneratorController.Callback();
callback.callDate = system.today();
callback.phoneNo = '081122334455';
callback.preferredPhoneNo = '081213141516';

CallLineGeneratorController.AgentAssignment agentAssign = new CallLineGeneratorController.AgentAssignment();
agentAssign.agentId = '5150';
agentAssign.agentName = 'James Bond';
agentAssign.policyTotal = 500;
*/
        Test.startTest(); 
        Profile agentProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%MAGI' limit 1]; 
        
        Profile spvProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%MAGI' limit 1]; 
        
        List<User> spvList = new List<User>();
        
        User loginMAGIUser = new User(Alias = 'spv3', Email='spvMagi@axa.co.id', 
                                      EmailEncodingKey='UTF-8', LastName='spvMagi', LanguageLocaleKey='en_US', 
                                      LocaleSidKey='en_US', ProfileId = spvProfileMAGI.Id, Entity__c = 'MAGI', 
                                      TimeZoneSidKey='Asia/Jakarta', UserName='spvMagi@axa.co.id');
        spvList.add(loginMAGIUser);
        insert spvList;
        
        List<User> agentList = new List<User>();
        User subOrdinateMAGIUser = new User(Alias = 'agent3', Email='agentMagi@axa.co.id', 
                                            EmailEncodingKey='UTF-8', LastName='agentMagi', LanguageLocaleKey='en_US', 
                                            LocaleSidKey='en_US', ProfileId = agentProfileMAGI.Id, managerId = loginMAGIUser.id, Entity__c = 'MAGI',
                                            TimeZoneSidKey='Asia/Jakarta', UserName='agentMagi@axa.co.id', isActive = true, Agent__c = true);
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
        
        //Create Campaign
        List<Call_List__c> callList = new List<Call_List__c>();
        Call_List__c campMAGI = new Call_List__c();
        campMAGI.Campaign_Name__c = 'test campaign magi';
        campMAGI.Entity__c = 'MAGI';
        campMAGI.Activity__c = 'Survey';
        campMAGI.Case_Type_Config__c = 'Survey of Claim Service';
        campMAGI.ownerid = loginMAGIUser.id;
        campMAGI.IsExpired__c = false;
        campMAGI.Expired_Date__c = Datetime.now().addDays(1).date();
        campMAGI.CreatedById = loginMAGIUser.id;
        callList.add(campMAGI);
        
        Call_List__c campMAGICallback = new Call_List__c();
        campMAGICallback.Campaign_Name__c = 'test campaign callback';
        campMAGICallback.Entity__c = 'MAGI';
        campMAGICallback.Activity__c = 'Callback';
        campMAGICallback.Case_Type_Config__c = null;
        campMAGICallback.ownerid = loginMAGIUser.id;
        campMAGICallback.IsExpired__c = false;
        campMAGICallback.Expired_Date__c = Datetime.now().addDays(1).date();
        callList.add(campMAGICallback);
        
        insert callList;
        
        List<Call_Line__c> disList = new List<Call_Line__c>();
        Call_Line__c callMAGI1 = new Call_Line__c();
        callMAGI1.Call_List__c = campMAGI.id;
        callMAGI1.ownerid = loginMAGIUser.id;
        callMAGI1.Activity__c = 'Survey';
        callMAGI1.Policy_No__c = 'magi001';
        //callMAGI1.Agent__c  = subOrdinateMAGIUser.id; 
        callMAGI1.Call_Status_Config__c = 'Contacted'; 		//callMAGI1.Activity_Result__c = 'Contacted'; 
        callMAGI1.Reason_Status_Config__c = 'Agree'; 		//callMAGI1.Verification__c = 'Agree'; 
        callMAGI1.Call_Remarks__c = 'OK';
        callMAGI1.Entity__c = 'MAGI';
        disList.add(callMAGI1);
        
        Call_Line__c callMAGICallback = new Call_Line__c();
        callMAGICallback.Call_List__c = campMAGI.id;
        callMAGICallback.ownerid = loginMAGIUser.id;
        callMAGICallback.Activity__c = 'Callback';
        callMAGICallback.Policy_No__c = 'magi001';
        //callMAGICallback.Agent__c  = subOrdinateMAGIUser.id; 
        //callMAGICallback.Activity_Result__c = 'Rescheduled'; 
        callMAGICallback.Call_Remarks__c = 'OK';
        callMAGICallback.Entity__c = 'MAGI';
        disList.add(callMAGICallback);
        
        insert disList;
        
        String policyBody = 'POLICY_NO\n12345\n67890';
        String phoneBody = 'PHONE_NO,PREFERRED_PHONE_NO,CALL_DATE\n081722266998,,2015-02-01\n02193883993,,';
        String conservationBody = 'POLICY_NO,PREV_ACC_BLC,TOTAL_WITHDRAWN,PREMIUM,CURRENCY\n938839,10000000,5000000,750000,IDR';
        
        CallLineGeneratorController.OutboundCall oc = new CallLineGeneratorController.OutboundCall();
        oc.agentName = 'abcde';
        oc.campaignName = 'testing123';
        oc.phoneNo = '081122334455';
        oc.policyNo = '54321';
        
        CallLineGeneratorController.Conservation conserv = new CallLineGeneratorController.Conservation();
        conserv.currcy = 'IDR';
        conserv.policyNo = '54321';
        conserv.premium = 1000000;
        conserv.prevAccBalance = 1000000;
        conserv.totalWithdrawn = 700000;
        
        CallLineGeneratorController.Callback callback =  new CallLineGeneratorController.Callback();
        callback.callDate = system.today();
        callback.phoneNo = '081122334455';
        callback.preferredPhoneNo = '081213141516';
        
        CallLineGeneratorController.AgentAssignment agentAssign = new CallLineGeneratorController.AgentAssignment();
        agentAssign.agentId = '5150';
        agentAssign.agentName = 'James Bond';
        agentAssign.policyTotal = 500;
        
        system.runAs(loginMAGIUser){
            try{
                CallLineGeneratorController controlMAGI = new CallLineGeneratorController(); 
                controlMAGI.getListToReload();
                
                system.debug('>>>> loggedInUser id : '+subOrdinateMAGIUser);   
                system.debug('>>>> loginAFIUser id : '+subOrdinateMAGIUser.id);   
                system.debug('>>> entity : '+controlMAGI.entity); 
                system.assertEquals('MAGI', controlMAGI.entity);
                system.assertEquals(0, controlMAGI.uploadedNum );
                system.assertEquals(0, controlMAGI.validNum );
                system.assertEquals(0, controlMAGI.invalidNum );
                system.assertEquals(0, controlMAGI.totalPolicies);
                system.assertEquals(loginMAGIUser.id, controlMAGI.loggedInUser);
                controlMAGI.document = null;
                controlMAGI.choosen_agent = '';
                controlMAGI.distribute();
                //controlMAGI.upload();
                controlMAGI.populateCallAndReasonStatus();
                controlMAGI.releaseReload();
                controlMAGI.reset();
                controlMAGI.populateReloadFreshData();
                
                controlMAGI.document = new Document();
                controlMAGI.document.body = Blob.valueOf(policyBody);
                controlMAGI.choosen_campaign = campMAGI.id;
                controlMAGI.upload();
                system.assertEquals(null, controlMAGI.upload());
                system.assertEquals(null, controlMAGI.reset());
                
                controlMAGI.document = new Document();
                controlMAGI.document.body = Blob.valueOf(phoneBody);
                controlMAGI.document.FolderId = UserInfo.getUserId();
                controlMAGI.document.Name = 'Testing MAGi';
                controlMAGI.choosen_campaign = campMAGI.id;
                controlMAGI.upload();		//system.assertEquals(null, controlMAGI.upload());
                
                system.assertEquals(null, controlMAGI.populateReloadFreshData());
                system.assertEquals(null, controlMAGI.isMethodChoosen);
                
                system.assertEquals(null, controlMAGI.populateFreshData());
                system.assertEquals(false, controlMAGI.isMethodChoosen);
                
                controlMAGI.choosen_method = 'Automatic';
                controlMAGI.save();
                system.assertEquals(null, controlMAGI.distribute());
                system.assertEquals(true, controlMAGI.isMethodChoosen);
                system.assertEquals(null, controlMAGI.release());
                controlMAGI.choosen_method = 'Manual';
                system.assertEquals(true, controlMAGI.isMethodChoosen);
                system.assertEquals(null, controlMAGI.distribute());
                system.assertEquals(true, controlMAGI.isMethodChoosen);
                system.assertEquals(null, controlMAGI.release());
                controlMAGI.choosen_method = 'Specific';
                //system.assertEquals(null, controlMAGI.distribute());
                system.assertEquals(null, controlMAGI.release());
                controlMAGI.save();
            }catch(Exception e){
            }
        }
        /*
        system.runAs(loginAFIUser){
            try{
*/
                /*	
CallLineGeneratorController.ReloadWrapper rw = new CallLineGeneratorController.ReloadWrapper();
rw.agentName = 'testingAFI';
rw.policyNo = 'afi001';
rw.callStatus = 'Uncontacted';
rw.isSelected = true;	
*/
                
                /*
controlAFI.document = new Document();
controlAFI.document.body = Blob.valueOf(policyBody);
controlAFI.document.FolderId = UserInfo.getUserId();
controlAFI.document.Name = 'Testing AFI';
system.assertEquals(null, controlAFI.upload());
*/
                /*
controlAFI.choosen_method = 'Specific';
system.assertEquals(null, controlAFI.distribute());
system.assertEquals(null, controlAFI.release());
controlAFI.save();

controlAFI.distribute();
controlAFI.populateCallAndReasonStatus();
controlAFI.releaseReload();
controlAFI.reset();
controlAFI.populateReloadFreshData();
/*
CallLineGeneratorController.ReloadWrapper rw = new CallLineGeneratorController.ReloadWrapper();
rw.agentName = subOrdinateAFIUser.Id;
rw.policyNo = 'afi001';
rw.callStatus = 'Uncontacted';
rw.isSelected = true;	
*/
                
                Test.stopTest();         
                
            //}
    
        }
            
            // comment this test to avoid maximum query
            /* commented on 20200508 by Faizir
public static testMethod void testCallLineGeneratorController(){
CallLineGeneratorController callGenController = new CallLineGeneratorController();
CallLineGeneratorController.ReloadWrapper rw = new CallLineGeneratorController.ReloadWrapper();
rw.isSelected = true;	
callGenController.parseCustSegmentationCSV('Testing', true);
callGenController.parseCSV('Testing', true);
callGenController.parseConservationCSV('Testing', true);
callGenController.parseCallbackCSV('Testing', true);
callGenController.distributeSpecific();
callGenController.distributeAuto();
callGenController.distributeManual();
String[] phoneNo = new String[] {'081122334455', '082233445566'};
callGenController.processPhone(phoneNo);
callGenController.isPhoneNumberValid('081122334455');
callGenController.convertString2Date('2016/11/10');	
callGenController.cumaUntukTestClass();
callGenController.refreshList();
*/
            /*
CallLineGeneratorController.ReloadWrapper rw = new CallLineGeneratorController.ReloadWrapper();
rw.agentName = 'testing';
rw.policyNo = 'amfs001';
rw.callStatus = 'Uncontacted';
rw.isSelected = true;

CallLineGeneratorController.OutboundCall oc = new CallLineGeneratorController.OutboundCall();
oc.agentName = 'abcde';
oc.campaignName = 'testing123';
oc.phoneNo = '081122334455';
oc.policyNo = '54321';

CallLineGeneratorController.Conservation conserv = new CallLineGeneratorController.Conservation();
conserv.currcy = 'IDR';
conserv.policyNo = '54321';
conserv.premium = 1000000;
conserv.prevAccBalance = 1000000;
conserv.totalWithdrawn = 700000;

CallLineGeneratorController.Callback callback =  new CallLineGeneratorController.Callback();
callback.callDate = system.today();
callback.phoneNo = '081122334455';
callback.preferredPhoneNo = '081213141516';

CallLineGeneratorController.AgentAssignment agentAssign = new CallLineGeneratorController.AgentAssignment();
agentAssign.agentId = '5150';
agentAssign.agentName = 'James Bond';
agentAssign.policyTotal = 500;
*/
            /* commented on 20200508 by Faizir
Test.startTest(); 
List<Contact> conList = new List<Contact>();
Contact con1 = new Contact();
con1.FirstName = 'Testing';
con1.LastName = '123';
con1.Policy_No__c = '500-12345';
con1.MobilePhone = '081122334455';
con1.Entity__c = 'AFI';
conList.add(con1);

Contact con2 = new Contact();
con2.FirstName = 'Testing';
con2.LastName = '234';
con2.Policy_No__c = '500-23456';
con2.MobilePhone = '082233445566';
con2.Entity__c = 'AFI';
conList.add(con2);

Contact con3 = new Contact();
con3.FirstName = 'Testing';
con3.LastName = '345';
con3.Policy_No__c = '500-34567';
con3.MobilePhone = '083344556677';
con3.Entity__c = 'AMFS';
conList.add(con3);

Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AFI' limit 1]; 
Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AMFS' limit 1]; 
Profile agentProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%MAGI' limit 1]; 

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
*/
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
            /* commented on 20200508 by Faizir
//Create Campaign
List<Call_List__c> callList = new List<Call_List__c>();
Call_List__c campAFI = new Call_List__c();
campAFI.Campaign_Name__c = 'test campaign afi';
campAFI.Entity__c = 'AFI';
campAFI.Activity__c = 'Renewal';
campAFI.Case_Type_Config__c = 'Renewal';
campAFI.ownerid = loginAFIUser.id;
campAFI.IsExpired__c = false;
campAFI.Expired_Date__c = Datetime.now().addDays(1).date();
campAFI.CreatedDate = system.today() - 10;
campAFI.CreatedById = loginAFIUser.id;
callList.add(campAFI);

Call_List__c campAMFS = new Call_List__c();
campAMFS.Campaign_Name__c = 'test campaign amfs';
campAMFS.Entity__c = 'AMFS';
campAMFS.Activity__c = 'Conservation';
campAMFS.Case_Type_Config__c = 'Policy Elapse';
campAMFS.ownerid = loginAMFSUser.id;
campAMFS.IsExpired__c = false;
campAMFS.Expired_Date__c = Datetime.now().addDays(1).date();
campAMFS.CreatedById = loginAMFSUser.id;
callList.add(campAMFS);

Call_List__c campMAGI = new Call_List__c();
campMAGI.Campaign_Name__c = 'test campaign magi';
campMAGI.Entity__c = 'MAGI';
campMAGI.Activity__c = 'Survey';
campMAGI.Case_Type_Config__c = 'Survey of Claim Service';
campMAGI.ownerid = loginMAGIUser.id;
campMAGI.IsExpired__c = false;
campMAGI.Expired_Date__c = Datetime.now().addDays(1).date();
campMAGI.CreatedById = loginMAGIUser.id;
callList.add(campMAGI);

Call_List__c campMAGICallback = new Call_List__c();
campMAGICallback.Campaign_Name__c = 'test campaign callback';
campMAGICallback.Entity__c = 'MAGI';
campMAGICallback.Activity__c = 'Callback';
campMAGICallback.Case_Type_Config__c = null;
campMAGICallback.ownerid = loginMAGIUser.id;
campMAGICallback.IsExpired__c = false;
campMAGICallback.Expired_Date__c = Datetime.now().addDays(1).date();
callList.add(campMAGICallback);

insert callList;

//create distribution call
List<Call_Line__c> disList = new List<Call_Line__c>();
Call_Line__c callAFI1 = new Call_Line__c();
callAFI1.Call_List__c = campAFI.id;
callAFI1.ownerid = loginAFIUser.id;
callAFI1.Activity__c = 'Renewal';
callAFI1.Policy_No__c = 'afi001';
callAFI1.Agent__c  = subOrdinateAFIUser.id;
callAFI1.Call_Status_Config__c = 'Contacted';		//callAFI1.Activity_Result__c = 'Contacted';
callAFI1.Reason_Status_Config__c = 'Agree'; 		//callAFI1.Verification__c = 'Agree'; 
callAFI1.Call_Remarks__c = 'OK';
callAFI1.Entity__c = 'AFI';
disList.add(callAFI1);

Call_Line__c callAFI2 = new Call_Line__c();
callAFI2.Call_List__c = campAFI.id;
callAFI2.ownerid = loginAFIUser.id;
callAFI2.Activity__c = 'Renewal';
callAFI2.Policy_No__c = 'afi002';
//callAFI2.Agent__c  = subOrdinateAFIUser.id; 
callAFI2.Call_Status_Config__c = 'Contacted'; 		//callAFI2.Activity_Result__c = 'Contacted'; 
callAFI2.Reason_Status_Config__c = 'Agree'; 		//callAFI2.Verification__c = 'Agree'; 
callAFI2.Call_Remarks__c = 'OK';
callAFI2.Entity__c = 'AFI';
disList.add(callAFI2);

Call_Line__c callAFI3 = new Call_Line__c();
callAFI3.Call_List__c = campAFI.id;
callAFI3.ownerid = loginAFIUser.id;
callAFI3.Activity__c = 'Renewal';
callAFI3.Policy_No__c = 'afi003';
//callAFI3.Agent__c  = subOrdinateAFIUser.id; 
callAFI3.Call_Status_Config__c = 'Contacted'; 		//callAFI3.Activity_Result__c = 'Contacted'; 
callAFI3.Reason_Status_Config__c = 'Agree'; 		//callAFI3.Verification__c = 'Agree'; 
callAFI3.Call_Remarks__c = 'OK';
callAFI3.Entity__c = 'AFI';
disList.add(callAFI3);

Call_Line__c callAMFS1 = new Call_Line__c();
callAMFS1.Call_List__c = campAMFS.id;
callAMFS1.ownerid = loginAMFSUser.id;
callAMFS1.Activity__c = 'Confirmation';
callAMFS1.Policy_No__c = 'amfs001';
callAMFS1.Agent__c  = subOrdinateAMFSUser.id; 
callAMFS1.Call_Status_Config__c = 'Contacted'; 		//callAMFS1.Activity_Result__c = 'Contacted'; 
callAMFS1.Reason_Status_Config__c = 'Agree'; 			//callAMFS1.Verification__c = 'Agree'; 
callAMFS1.Call_Remarks__c = 'OK';
callAMFS1.Entity__c = 'AMFS';
disList.add(callAMFS1);

Call_Line__c callAMFS2 = new Call_Line__c();
callAMFS2.Call_List__c = campAMFS.id;
callAMFS2.ownerid = loginAMFSUser.id;
callAMFS2.Activity__c = 'Confirmation';
callAMFS2.Policy_No__c = 'amfs002';
//callAMFS2.Agent__c  = subOrdinateAMFSUser.id; 
callAMFS2.Call_Status_Config__c = 'Contacted'; 		//callAMFS2.Activity_Result__c = 'Contacted'; 
callAMFS2.Reason_Status_Config__c = 'Agree'; 		//callAMFS2.Verification__c = 'Agree'; 
callAMFS2.Call_Remarks__c = 'OK';
callAMFS2.Entity__c = 'AMFS';
disList.add(callAMFS2);

Call_Line__c callMAGI1 = new Call_Line__c();
callMAGI1.Call_List__c = campMAGI.id;
callMAGI1.ownerid = loginMAGIUser.id;
callMAGI1.Activity__c = 'Survey';
callMAGI1.Policy_No__c = 'magi001';
//callMAGI1.Agent__c  = subOrdinateMAGIUser.id; 
callMAGI1.Call_Status_Config__c = 'Contacted'; 		//callMAGI1.Activity_Result__c = 'Contacted'; 
callMAGI1.Reason_Status_Config__c = 'Agree'; 		//callMAGI1.Verification__c = 'Agree'; 
callMAGI1.Call_Remarks__c = 'OK';
callMAGI1.Entity__c = 'MAGI';
disList.add(callMAGI1);

Call_Line__c callMAGICallback = new Call_Line__c();
callMAGICallback.Call_List__c = campMAGI.id;
callMAGICallback.ownerid = loginMAGIUser.id;
callMAGICallback.Activity__c = 'Callback';
callMAGICallback.Policy_No__c = 'magi001';
//callMAGICallback.Agent__c  = subOrdinateMAGIUser.id; 
//callMAGICallback.Activity_Result__c = 'Rescheduled'; 
callMAGICallback.Call_Remarks__c = 'OK';
callMAGICallback.Entity__c = 'MAGI';
disList.add(callMAGICallback);

insert disList;

String policyBody = 'POLICY_NO\n12345\n67890';
String phoneBody = 'PHONE_NO,PREFERRED_PHONE_NO,CALL_DATE\n081722266998,,2015-02-01\n02193883993,,';
String conservationBody = 'POLICY_NO,PREV_ACC_BLC,TOTAL_WITHDRAWN,PREMIUM,CURRENCY\n938839,10000000,5000000,750000,IDR';

CallLineGeneratorController.OutboundCall oc = new CallLineGeneratorController.OutboundCall();
oc.agentName = 'abcde';
oc.campaignName = 'testing123';
oc.phoneNo = '081122334455';
oc.policyNo = '54321';

CallLineGeneratorController.Conservation conserv = new CallLineGeneratorController.Conservation();
conserv.currcy = 'IDR';
conserv.policyNo = '54321';
conserv.premium = 1000000;
conserv.prevAccBalance = 1000000;
conserv.totalWithdrawn = 700000;

CallLineGeneratorController.Callback callback =  new CallLineGeneratorController.Callback();
callback.callDate = system.today();
callback.phoneNo = '081122334455';
callback.preferredPhoneNo = '081213141516';

CallLineGeneratorController.AgentAssignment agentAssign = new CallLineGeneratorController.AgentAssignment();
agentAssign.agentId = '5150';
agentAssign.agentName = 'James Bond';
agentAssign.policyTotal = 500;

system.runAs(loginAFIUser){
try{
*/
            /*	
CallLineGeneratorController.ReloadWrapper rw = new CallLineGeneratorController.ReloadWrapper();
rw.agentName = 'testingAFI';
rw.policyNo = 'afi001';
rw.callStatus = 'Uncontacted';
rw.isSelected = true;	
*/
            /* commented on 20200508 by Faizir
CallLineGeneratorController controlAFI = new CallLineGeneratorController(); 
controlAFI.choosen_campaign = campAFI.Id;
controlAFI.choosen_agent = subOrdinateAFIUser.Id;
controlAFI.getListToReload();

//system.assertNotEquals(0, controlAFI.totalAgents);
system.debug('>>>> loggedInUser id : '+controlAFI.loggedInUser);   
system.debug('>>>> loginAFIUser id : '+loginAFIUser.id);   
system.debug('>>> total agent : '+controlAFI.totalAgents); 
system.debug('>>> entity : '+controlAFI.entity); 
system.assertEquals('AFI', controlAFI.entity);
system.assertEquals(0, controlAFI.uploadedNum );
system.assertEquals(0, controlAFI.validNum );
system.assertEquals(0, controlAFI.invalidNum );
controlAFI.document = null;
*/
            /*
controlAFI.document = new Document();
controlAFI.document.body = Blob.valueOf(policyBody);
controlAFI.document.FolderId = UserInfo.getUserId();
controlAFI.document.Name = 'Testing AFI';
system.assertEquals(null, controlAFI.upload());
*/
            /* commented on 20200508 by Faizir
controlAFI.distribute();
controlAFI.populateCallAndReasonStatus();
controlAFI.releaseReload();
controlAFI.reset();
controlAFI.populateReloadFreshData();

controlAFI.document = new Document();
controlAFI.document.body = Blob.valueOf(phoneBody);
controlAFI.document.FolderId = UserInfo.getUserId();
controlAFI.document.Name = 'Testing AFI 1';
controlAFI.choosen_campaign = campAFI.id;
controlAFI.upload();

//system.assertEquals(null, controlAFI.populateReloadFreshData());
system.assertEquals(null, controlAFI.populateFreshData());
system.assertEquals(false, controlAFI.isMethodChoosen);

String[] polNo1 = new String[] {'afi001', 'afi002'};
callGenController.processPolicy(polNo1);
String[] polNo2 = new String[] {'500-12345', '500-23456'};
callGenController.processConservation(polNo2);
String[] polNo3 = new String[] {'500-34567'};
callGenController.welcomecallAssign(polNo3);
//String[] phoneNo = new String[] {'081122334455', '082233445566'};
//callGenController.processPhone(phoneNo);	
controlAFI.choosen_method = 'Automatic';
controlAFI.save();
system.assertEquals(null, controlAFI.distribute());
system.assertEquals(true, controlAFI.isMethodChoosen);
system.assertEquals(null, controlAFI.release());
controlAFI.choosen_method = 'Manual';
controlAFI.save();
system.assertEquals(true, controlAFI.isMethodChoosen);
system.assertEquals(null, controlAFI.distribute());
//system.assertEquals(true, controlAFI.isMethodChoosen);
system.assertEquals(null, controlAFI.release());
*/
            /*
controlAFI.choosen_method = 'Specific';
system.assertEquals(null, controlAFI.distribute());
system.assertEquals(null, controlAFI.release());
controlAFI.save();

controlAFI.distribute();
controlAFI.populateCallAndReasonStatus();
controlAFI.releaseReload();
controlAFI.reset();
controlAFI.populateReloadFreshData();
/*
CallLineGeneratorController.ReloadWrapper rw = new CallLineGeneratorController.ReloadWrapper();
rw.agentName = subOrdinateAFIUser.Id;
rw.policyNo = 'afi001';
rw.callStatus = 'Uncontacted';
rw.isSelected = true;	
*/
            /* commented on 20200508 by Faizir
controlAFI.release();

CallLineGeneratorController controlAFI2 = new CallLineGeneratorController(); 
controlAFI2.choosen_campaign = campAFI.Id;
controlAFI2.choosen_agent = 'All';
controlAFI2.getListToReload();
}catch(Exception e){
System.debug('e: ' + e.getLineNumber() + '# ' + e.getMessage());
}
//system.assertEquals('Renewal', controlAFI.activity);
//system.assertEquals(3, controlAFI.totalRecords);
}
system.runAs(loginAMFSUser){
try{
CallLineGeneratorController controlAMFS = new CallLineGeneratorController(); 
controlAMFS.choosen_campaign = campAMFS.Id;
controlAMFS.choosen_agent = 'All';	//controlAMFS.choosen_agent = subOrdinateAMFSUser.Id;
controlAMFS.getListToReload();
system.debug('>>>> loggedInUser id : '+subOrdinateAMFSUser);   
system.debug('>>>> loginAMFSUser id : '+subOrdinateAMFSUser.id);   
system.debug('>>> entity : '+controlAMFS.entity); 
system.assertEquals('AMFS', controlAMFS.entity);
system.assertEquals(0, controlAMFS.uploadedNum );
system.assertEquals(0, controlAMFS.validNum );
system.assertEquals(0, controlAMFS.invalidNum );
system.assertEquals(loginAMFSUser.id, controlAMFS.loggedInUser);
controlAMFS.document = null;

//controlAMFS.choosen_campaign = campAMFS.id;
//controlAMFS.choosen_agent = subOrdinateAMFSUser.Id;
controlAMFS.distribute();
controlAMFS.populateCallAndReasonStatus();
controlAMFS.releaseReload();
controlAMFS.reset();
controlAMFS.populateReloadFreshData();

controlAMFS.document = new Document();
controlAMFS.document.body = Blob.valueOf(conservationBody);
controlAMFS.document.FolderId = UserInfo.getUserId();
controlAMFS.document.Name = 'Testing AMFS';
controlAMFS.upload();

system.assertEquals(null, controlAMFS.populateReloadFreshData());
system.assertEquals(null, controlAMFS.isMethodChoosen);

system.assertEquals(null, controlAMFS.populateFreshData());
system.assertEquals(false, controlAMFS.isMethodChoosen);
*/
            /*	
controlAMFS.choosen_method = 'Automatic';
system.assertEquals(null, controlAMFS.distribute());
system.assertEquals(true, controlAMFS.isMethodChoosen);
system.assertEquals(2, controlAMFS.totalPolicies);
system.assertEquals(null, controlAMFS.release());
*/
            /* commented on 20200508 by Faizir
controlAMFS.choosen_method = 'Manual';
controlAMFS.save();
system.debug('controlAMFS Data =='+controlAMFS);
system.assertEquals(null, controlAMFS.distribute());
system.assertEquals(true, controlAMFS.isMethodChoosen);
system.assertEquals(null, controlAMFS.release());
controlAMFS.choosen_method = 'Automatic';
controlAMFS.save();
controlAMFS.choosen_method = 'Specific';
controlAMFS.save();
controlAMFS.release();
*/
            /*
controlAMFS.choosen_method = 'Specific';
system.assertEquals(null, controlAMFS.distribute());
system.assertEquals(true, controlAMFS.isMethodChoosen);
system.assertEquals(null, controlAMFS.release());
*/
            /* commented on 20200508 by Faizir
}catch(Exception e){
}
}
*/
            /*** Comment, 7 April 2020 ***/
            /*system.runAs(loginMAGIUser){
try{
CallLineGeneratorController controlMAGI = new CallLineGeneratorController(); 
controlMAGI.getListToReload();

system.debug('>>>> loggedInUser id : '+subOrdinateMAGIUser);   
system.debug('>>>> loginAFIUser id : '+subOrdinateMAGIUser.id);   
system.debug('>>> entity : '+controlMAGI.entity); 
system.assertEquals('MAGI', controlMAGI.entity);
system.assertEquals(0, controlMAGI.uploadedNum );
system.assertEquals(0, controlMAGI.validNum );
system.assertEquals(0, controlMAGI.invalidNum );
system.assertEquals(0, controlMAGI.totalPolicies);
system.assertEquals(loginMAGIUser.id, controlMAGI.loggedInUser);
controlMAGI.document = null;
controlMAGI.choosen_agent = '';
controlMAGI.distribute();
//controlMAGI.upload();
controlMAGI.populateCallAndReasonStatus();
controlMAGI.releaseReload();
controlMAGI.reset();
controlMAGI.populateReloadFreshData();

controlMAGI.document = new Document();
controlMAGI.document.body = Blob.valueOf(policyBody);
controlMAGI.choosen_campaign = campMAGI.id;
controlMAGI.upload();
system.assertEquals(null, controlMAGI.upload());
system.assertEquals(null, controlMAGI.reset());

controlMAGI.document = new Document();
controlMAGI.document.body = Blob.valueOf(phoneBody);
controlMAGI.document.FolderId = UserInfo.getUserId();
controlMAGI.document.Name = 'Testing MAGi';
controlMAGI.choosen_campaign = campMAGI.id;
controlMAGI.upload();		//system.assertEquals(null, controlMAGI.upload());

system.assertEquals(null, controlMAGI.populateReloadFreshData());
system.assertEquals(null, controlMAGI.isMethodChoosen);

system.assertEquals(null, controlMAGI.populateFreshData());
system.assertEquals(false, controlMAGI.isMethodChoosen);

controlMAGI.choosen_method = 'Automatic';
controlMAGI.save();
system.assertEquals(null, controlMAGI.distribute());
system.assertEquals(true, controlMAGI.isMethodChoosen);
system.assertEquals(null, controlMAGI.release());
controlMAGI.choosen_method = 'Manual';
system.assertEquals(true, controlMAGI.isMethodChoosen);
system.assertEquals(null, controlMAGI.distribute());
system.assertEquals(true, controlMAGI.isMethodChoosen);
system.assertEquals(null, controlMAGI.release());
controlMAGI.choosen_method = 'Specific';
//system.assertEquals(null, controlMAGI.distribute());
system.assertEquals(null, controlMAGI.release());
controlMAGI.save();
}catch(Exception e){
}
}*/
            /*** END - Comment, 7 April 2020 ***/
            /* commented on 20200508 by Faizir
Test.stopTest();         

}
*/
            
            @isTest static void testCallLineGeneratorWC(){
                User u = [SELECT Id FROM User WHERE UserName = 'standarduser1@axa.com' LIMIT 1];
                Profile spvProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AMFS' limit 1];
                List<User> spvList = new List<User>();
                User loginAMFSUser = new User(Alias = 'spv2', Email='spvAmfs@axa.co.id', 
                                              EmailEncodingKey='UTF-8', LastName='spvAmfs', LanguageLocaleKey='en_US', 
                                              LocaleSidKey='en_US', ProfileId = spvProfileAMFS.Id, Entity__c = 'AMFS', 
                                              TimeZoneSidKey='Asia/Jakarta', UserName='spvAmfs@axa.co.id');
                spvList.add(loginAMFSUser);
                insert loginAMFSUser;
                System.runAs(loginAMFSUser){
                    // Contact Existing record
                    List<Contact> conList = new List<Contact>();
                    Contact con1 = new Contact();
                    con1.FirstName = 'Testing 1';
                    con1.LastName = '123';
                    con1.Policy_No__c = '500-12345';
                    con1.MobilePhone = '081122334455';
                    con1.Entity__c = 'AMFS';
                    conList.add(con1);
                    
                    Contact con2 = new Contact();
                    con2.FirstName = 'Testing 2';
                    con2.LastName = '234';
                    con2.Policy_No__c = '500-23456';
                    con2.MobilePhone = '082233445566';
                    con2.Entity__c = 'AMFS';
                    conList.add(con2);
                    
                    Contact con3 = new Contact();
                    con3.FirstName = 'Testing 3';
                    con3.LastName = '345';
                    con3.Policy_No__c = '500-34567';
                    con3.MobilePhone = '083344556677';
                    con3.Entity__c = 'AMFS';
                    conList.add(con3);
                    insert conList;
                    
                    // Welcomecall Campaign existing record
                    List<Call_List__c> daftarCL = new List<Call_List__c>();
                    Call_List__c cl = new Call_List__c();
                    cl.Campaign_Name__c = 'Test one WC1';
                    cl.Entity__c = 'AMFS';
                    cl.Activity__c = 'Confirmation';
                    cl.Case_Type__c = 'Welcome Call';
                    cl.Case_Type_Config__c = 'Welcome Call';
                    cl.IsExpired__c = false;
                    cl.Expired_Date__c = Date.newInstance(2028, 5, 23);
                    cl.WelcomeCall_Fg_Automatic__c = false;
                    cl.RecordTypeId = rtConfirmationAMFS;
                    daftarCL.add(cl);
                    
                    Call_List__c cl2 = new Call_List__c();
                    cl2.Campaign_Name__c = 'Test one';
                    cl2.Entity__c = 'AMFS';
                    cl2.Activity__c = 'Confirmation';
                    cl2.Case_Type__c = 'Retain Redemption';
                    cl2.Case_Type_Config__c = 'Retain Redemption';
                    cl2.IsExpired__c = false;
                    cl2.Expired_Date__c = Date.newInstance(2028, 5, 23);
                    cl2.WelcomeCall_Fg_Automatic__c = false;
                    cl2.RecordTypeId = rtConfirmationAMFS;
                    daftarCL.add(cl2);
                    
                    insert daftarCL;
                    
                    //Welcomecall Call Line Existing Record
                    
                    Call_Line__c call_liner = new Call_Line__c();
                    call_liner.Contact__c = con1.id;
                    call_liner.Policy_No__c = con1.Policy_No__c;
                    call_liner.Contacted_Number__c = con1.MobilePhone;
                    call_liner.Home_Phone__c = con1.HomePhone;
                    call_liner.Phone__c = con1.Phone;
                    call_liner.Entity__c = con1.Entity__c;
                    call_liner.Call_List__c = cl.Id;
                    call_liner.Activity__c = cl.Activity__c;
                    call_liner.Case_Type__c = cl.Case_Type__c; 
                    call_liner.Case_Type_Config__c = cl.Case_Type_Config__c;
                    call_liner.WelcomeCall_Call_Line_Status__c = 'Open';
                    call_liner.RecordTypeId = rtCallLineWC;
                    insert call_liner;
                    
                    CallLineGeneratorController callGenController = new CallLineGeneratorController();
                    callGenController.choosen_campaign = cl.id;
                    Document document = new Document();
                    String body='Policy No \n';
                    body = body + '500-12345 \n' + '500-23456 \n' + '500-34567';
                    document.Body = Blob.valueOf(body);
                    document.ContentType ='text/plain; charset=UTF-8';
                    document.Name = 'Testing Welcome Call.csv';
                    callGenController.document = document;
                    callGenController.upload();
                }
                
            }
            
            
            @isTest static void testCallLineGeneratorAMFS1(){
                User u = [SELECT Id FROM User WHERE UserName = 'standarduser1@axa.com' LIMIT 1];
                Profile spvProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AMFS' limit 1];
                List<User> spvList = new List<User>();
                User loginAMFSUser = new User(Alias = 'spv2', Email='spvAmfs@axa.co.id', 
                                              EmailEncodingKey='UTF-8', LastName='spvAmfs', LanguageLocaleKey='en_US', 
                                              LocaleSidKey='en_US', ProfileId = spvProfileAMFS.Id, Entity__c = 'AMFS', 
                                              TimeZoneSidKey='Asia/Jakarta', UserName='spvAmfs@axa.co.id');
                spvList.add(loginAMFSUser);
                insert loginAMFSUser;
                System.runAs(loginAMFSUser){
                    // Contact Existing record
                    List<Contact> conList = new List<Contact>();
                    Contact con1 = new Contact();
                    con1.FirstName = 'Testing';
                    con1.LastName = '123';
                    con1.Policy_No__c = '500-12345';
                    con1.MobilePhone = '081122334455';
                    con1.Entity__c = 'AMFS';
                    conList.add(con1);
                    
                    Contact con2 = new Contact();
                    con2.FirstName = 'Testing';
                    con2.LastName = '234';
                    con2.Policy_No__c = '500-23456';
                    con2.MobilePhone = '082233445566';
                    con2.Entity__c = 'AMFS';
                    conList.add(con2);
                    
                    Contact con3 = new Contact();
                    con3.FirstName = 'Testing';
                    con3.LastName = '345';
                    con3.Policy_No__c = '500-34567';
                    con3.MobilePhone = '083344556677';
                    con3.Entity__c = 'AMFS';
                    conList.add(con3);
                    insert conList;
                    
                    // Welcomecall Campaign existing record
                    List<Call_List__c> daftarCL = new List<Call_List__c>();
                    Call_List__c cl = new Call_List__c();
                    cl.Campaign_Name__c = 'Test one';
                    cl.Entity__c = 'AMFS';
                    cl.Activity__c = 'Confirmation';
                    //cl.Case_Type__c = 'Welcome Call';
                    //cl.Case_Type_Config__c = 'Welcome Call';
                    cl.IsExpired__c = false;
                    cl.Expired_Date__c = Date.newInstance(2028, 5, 23);
                    //cl.WelcomeCall_Fg_Automatic__c = false;
                    cl.RecordTypeId = rtConfirmationAMFS;
                    daftarCL.add(cl);
                    
                    Call_List__c cl2 = new Call_List__c();
                    cl2.Campaign_Name__c = 'Test one AMFS1';
                    cl2.Entity__c = 'AMFS';
                    cl2.Activity__c = 'Confirmation';
                    //cl2.Case_Type__c = 'Retain Redemption';
                    //cl2.Case_Type_Config__c = 'Retain Redemption';
                    cl2.IsExpired__c = false;
                    cl2.Expired_Date__c = Date.newInstance(2028, 5, 23);
                    //cl2.WelcomeCall_Fg_Automatic__c = false;
                    cl2.RecordTypeId = rtConfirmationAMFS;
                    daftarCL.add(cl2);
                    
                    insert daftarCL;
                    
                    //Welcomecall Call Line Existing Record
                    
                    Call_Line__c call_liner = new Call_Line__c();
                    call_liner.Contact__c = con1.id;
                    call_liner.Policy_No__c = con1.Policy_No__c;
                    call_liner.Contacted_Number__c = con1.MobilePhone;
                    call_liner.Home_Phone__c = con1.HomePhone;
                    call_liner.Phone__c = con1.Phone;
                    call_liner.Entity__c = con1.Entity__c;
                    call_liner.Call_List__c = cl.Id;
                    call_liner.Activity__c = cl.Activity__c;
                    call_liner.Case_Type__c = cl.Case_Type__c; 
                    call_liner.Case_Type_Config__c = cl.Case_Type_Config__c;
                    call_liner.WelcomeCall_Call_Line_Status__c = 'Open';
                    call_liner.RecordTypeId = rtCallLineAMFS1;
                    insert call_liner;
                    
                    CallLineGeneratorController callGenController = new CallLineGeneratorController();
                    callGenController.choosen_campaign = cl.id;
                    Document document = new Document();
                    String body='Policy No \n';
                    body = body + '500-12345 \n' + '500-23456 \n' + '500-34567';
                    document.Body = Blob.valueOf(body);
                    document.ContentType ='text/plain; charset=UTF-8';
                    document.Name = 'Testing Welcome Call.csv';
                    callGenController.document = document;
                    callGenController.upload();
                }
                
            }
        }