/*---------------------------------------------------------------
    Author      : Andy Putra
    Company     : MII
    Description : test class for Apex class 

    <History>
    <Date>      <Authors Name>     <Brief Description of Change>    
    ddMMyyyy    Andy Putra          Created
---------------------------------------------------------------*/
@isTest
public class AXAAPI000_test {
    @testsetup static void setup(){
        //data setup
        Profile p = [SELECT Id FROM Profile LIMIT 1]; 
        User u = new User(Alias = 'alias', Email='migrationdata@muliaraya.com', 
                          EmailEncodingKey='UTF-8', LastName='migration', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='migrationdata@axa.com', Entity__c='AFI');
        insert u;
         
        Contact con1 = new Contact();
        con1.FirstName = 'Testing';
        con1.LastName = '123';
        con1.Policy_No__c = '511-7298157';
        con1.MobilePhone = '081122334455';
        con1.Entity__c = 'AMFS';
        insert con1; 
        
        Call_List__c cl = new Call_List__c();
        cl.Campaign_Name__c ='Customer Segmentation';
        cl.Entity__c ='AMFS';
        cl.Activity__c ='Customer Segmentation';
        cl.Case_Type__c ='Update Data';
        cl.IsExpired__c = false;
        cl.Expired_Date__c = Date.newInstance(2028, 5, 23);
        cl.RecordTypeId = Schema.SObjectType.Call_list__c.getRecordTypeInfosByName().get('Customer Segmentation AMFS').getRecordTypeId();
        insert cl;
         
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
         insert call_liner;
    }
    
    @isTest static void testAXAAPI_UtilityClass(){
        Test.startTest();
        User u = [SELECT Id, Name FROM User LIMIT 1];
        AXAAPI_UtilityClass.getsObjectNameById(u.Id, 'User', 'Name');
        AXAAPI_UtilityClass.getsObjectNameByIds(new Set<Id>{u.Id}, 'User', 'Name');
        AXAAPI_UtilityClass.stringToBoolean('true');
        AXAAPI_UtilityClass.stringToDate('2017-09-29');
        AXAAPI_UtilityClass.stringToDatetime('2017-09-29 14:16:10.000');
        
        AXAAPI_UtilityClass.getsObjectNameById(u.Id, 'Users', 'Name');
        AXAAPI_UtilityClass.getsObjectNameByIds(new Set<Id>{u.Id}, 'Users', 'Name');
        AXAAPI_UtilityClass.stringToBoolean('trues');
        AXAAPI_UtilityClass.stringToBoolean('');
        AXAAPI_UtilityClass.stringToDate('2017-0929');
        AXAAPI_UtilityClass.stringToDatetime('2017-092914:16:10.000');
        AXAAPI_UtilityClass.getsMilestoneNameByTypeId('5556F00000JvNwGQAV');
        AXAAPI_UtilityClass.getsMilestoneNameByTypeId('5556F00000JvNwG25V'); // id asal
        Test.stopTest();
    }
        
	@isTest static void testAXAAPI000_GenerateAccessToken(){
		Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        AXAAPI000_GenerateAccessToken.generateAccessToken();
        Test.stopTest();
    }
    
    @isTest static void testAXAAPI001A_CaseByPolicyNumber(){
		Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        AXAAPI001A_CaseByPolicyNumber.getCaseByPolicyNumber('policy_number',0,10);
        Test.stopTest();
    }
    
    @isTest static void testAXAAPI001B_CaseById(){
		Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        AXAAPI001B_CaseById.getCaseById('id');
        Test.stopTest();
    }
    
    @isTest static void testAXAAPI001C_CaseByParam(){
		Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        AXAAPI001C_CaseByParam.getCaseByParam('?key=entity__c&value=AFI&skip=0&take=10');
        Test.stopTest();
    }
    
    @isTest static void testAXAAPI002A_EmailMessageById(){
		Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        AXAAPI002A_EmailMessageById.getEmailById('id');
        Test.stopTest();
    }
    
    @isTest static void testAXAAPI002B_EmailMessageByParentId(){
		Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        AXAAPI002B_EmailMessageByParentId.getEmailByParentId('id',0,10);
        Test.stopTest();
    }
    
    @isTest static void testAXAAPI002C_EmailMessageByParam(){
		Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        //AXAAPI002C_EmailMessageByParam.getEmailByParam('key', 'value', 1, 1);
        Test.stopTest();
    }

    @isTest static void testLookupPopup_ctrl(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        LookupPopup_ctrl cls = new LookupPopup_ctrl();
        cls.query = 'admin';
        cls.runQuery();
        cls.getDataNext();
        cls.getDataPrevious();
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        Contact con = new Contact();
        con.LastName = 'admin';
        con.Entity__c = 'AFI';
        insert con;
        
       	// contact con = [select id, name from contact where id = '0039000001XRdnsAAD' limit 1];
        ApexPages.StandardController stc = new ApexPages.StandardController(con);
        ApexPages.currentPage().getParameters().put('id',con.Id);
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl(stc);
        cls.refresh();
        
        cls.setLoadCases();
        cls.loadCases();
        cls.getCaseDetail('5000K00001jM7TNQA0');
        cls.id = '5000K00001ylTGwQAM';
        cls.refresh();
        
        cls.setLoadCases_c();
        cls.loadCases_c(); 
        cls.getCaseDetails('5000K00001ylTGwQAM');  
        System.debug(':::ALL');
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl2(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        ApexPages.currentPage().getParameters().put('id','5000K00001jM7TNQA0');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl();
        cls.redirect();
        System.debug(':::ALL 2');
        Test.stopTest();
    }
    
    @isTest static void testEmail_CustomPage_ctrl(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        Case cs = new Case();
        cs.Subject = 'subject';
        insert cs;
        
        EmailMessage em = new EmailMessage(FromAddress = 'test@abc.org', Incoming = True, ToAddress= 'hello@670ocglw7xhomi4oyr5yw2zvf.8kp7yeag.8.case.salesforce.com', Subject = 'Test email', TextBody = '23456 ', ParentId = cs.Id);
        insert em;
        
        ApexPages.StandardController stc = new ApexPages.StandardController(em);
        ApexPages.currentPage().getParameters().put('id',em.Id);
        Email_CustomPage_ctrl cls = new Email_CustomPage_ctrl(stc);
        cls.loadEmails();
        cls.getEmailDetail(em.Id);
        cls.removeNewLine('text');
        Test.stopTest();
    }
    
    @isTest static void testEmail_CustomPage_ctrl2(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        ApexPages.currentPage().getParameters().put('id','5000K00001jM7TNQA0');
        Email_CustomPage_ctrl cls = new Email_CustomPage_ctrl();
        cls.redirect();
        cls.getEmailDetail('em.Id');
        Test.stopTest();
    }
    
    @isTest static void testArchiveData_Search_ctrl(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        ApexPages.currentPage().getParameters().put('id','5000K00001jM7TNQA0');
        ArchiveData_Search_ctrl cls = new ArchiveData_Search_ctrl();
        cls.refresh();
         
        cls.getObjectList();
        cls.getParamList(); 
        cls.obj = 'Case';
        cls.key = 'caseNumber';
        cls.value = '003';
        cls.getData();
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        
        Test.stopTest();
    }
    
    
    
    @isTest static void testArchiveData_Search_ctrl_searchEmail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
         
        ArchiveData_Search_ctrl cls = new ArchiveData_Search_ctrl();
        cls.refresh();
        
        cls.obj = 'EmailMessage';
        cls.key = 'subject';
        cls.value = 'Policy';
        cls.getData();
        cls.getParamList(); 
        cls.MultiParamApiEmail('subject','Policy');
        /* cls.getObjectList();
        cls.getParamList();
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast(); */
        Test.stopTest();
    }

     
        
    @isTest static void testArchiveData_Search_ctrl_searchPurecloudCallService(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
         
        ArchiveData_Search_ctrl cls = new ArchiveData_Search_ctrl();
        cls.refresh();
        
        cls.obj = 'PureCloud_Call_Service__c';
        cls.key = 'Name';
        cls.value = '000207289';
        cls.getData();
        cls.getParamList(); 
        /* cls.getObjectList();
        cls.getParamList();
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast(); */
        Test.stopTest();
    }
    
    @isTest static void testArchiveData_Search_ctrl_searchCampaign(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
         
        ArchiveData_Search_ctrl cls = new ArchiveData_Search_ctrl();
        cls.refresh();
        
        cls.obj = 'Call_List__c';
        cls.key = 'Name';
        cls.value = 'Gen#';
        cls.getData();
        cls.getParamList(); 
        /* cls.getObjectList();
        cls.getParamList();
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast(); */
        Test.stopTest();
    }

    
    @isTest static void testArchiveData_Search_ctrl_searchPurecloudCallAgent(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
         
        ArchiveData_Search_ctrl cls = new ArchiveData_Search_ctrl();
        cls.refresh();
        
        cls.obj = 'Purecloud__c';
        cls.key = 'Name';
        cls.value = 'Afriandi';
        cls.getData();
        cls.getParamList(); 
        /* cls.getObjectList();
        cls.getParamList();
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast(); */
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_Milestone(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::loadMilestones');
        ApexPages.currentPage().getParameters().put('id','5006F000025ZMyZQAW');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl();
        // cls.id = '5006F000025ZMyZQAW';
        cls.refresh();
        cls.setLoadMilestones();
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        
        cls.loadMilestones(); 
        Test.stopTest();
    }
    

    
    @isTest static void testCase_CustomPage_ctrl_Email(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::loadEmails_vf_case');
        ApexPages.currentPage().getParameters().put('id','5006F00001TscutQAB');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl();
        // cls.id = '5006F00001TscutQAB';
        cls.refresh();
        cls.setLoadEmails_vf_case();
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        
        cls.loadEmails_vf_case();
        Test.stopTest();
    }
    
    
    @isTest static void testCase_CustomPage_ctrl_SocialPost(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::loadSocialPost');
        ApexPages.currentPage().getParameters().put('id','5000K000024aTspQAE');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl();
        // cls.id = '5000K000024aTspQAE';
        cls.refresh();
        cls.setLoadSocialPost();
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        
        cls.loadSocialPost();
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_ApprovalHistory(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::loadApprovalHistory');
        ApexPages.currentPage().getParameters().put('id','5009000000s7ZmOAAU');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl();
        // cls.id = '5009000000s7ZmOAAU';
        cls.refresh();
        
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        
        cls.loadApprovalHistory();
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_Escalation(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::loadCaseEscalation');
        ApexPages.currentPage().getParameters().put('id','5000K000021wN2uQAE');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl();
        // cls.id = '5000K000021wN2uQAE';
        cls.refresh();
        cls.setLoadCaseEscalation();
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        
        cls.loadCaseEscalation();
        Test.stopTest();
    }

    @isTest static void testCase_CustomPage_ctrl_openActivity(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::loadOpenActivity_case');
        ApexPages.currentPage().getParameters().put('id','5000K00001o7XR1QAM');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl();
        // cls.id = '5000K00001o7XR1QAM';
        cls.refresh();
        cls.setLoadOpenActivity_case();
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        
        cls.loadOpenActivity_case();
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_ActivityHistroy(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::loadActivityHistory_case');
        ApexPages.currentPage().getParameters().put('id','5000K00001o7XR1QAM');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl();
        // cls.id = '5000K00001o7XR1QAM';
        cls.refresh();
        cls.setLoadActivityHistory_case();
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        
        cls.loadActivityHistory_case();
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_comment(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::loadCaseComments');
        ApexPages.currentPage().getParameters().put('id','5009000000nvyLKAAY');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl();
        // cls.id = '5009000000nvyLKAAY';
        cls.refresh();
        cls.setLoadCaseComments();
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        
        cls.loadCaseComments();
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_Attach(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::loadAttachments');
        ApexPages.currentPage().getParameters().put('id','02s6F00001AC500QAD');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl();
        // cls.id = '02s6F00001AC500QAD';
        cls.refresh();
        cls.setLoadAttachments();
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        
        cls.loadAttachments();
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_Logs(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::loadLogs');
        ApexPages.currentPage().getParameters().put('id','5006F00001d4hHzQAI');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl();
        // cls.id = '5006F00001d4hHzQAI';
        cls.refresh(); 
        cls.loadLogs();
        cls.setLoadLogs();
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        cls.loadLogs();
        Test.stopTest();
    }
    
    
    @isTest static void testCase_CustomPage_ctrl_Negative(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::loadNegatives');
        ApexPages.currentPage().getParameters().put('id','5000K000028Qp7EQAS');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl();
        // cls.id = '5000K000028Qp7EQAS';
        cls.refresh();
        cls.setLoadNegatives();
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        
        cls.loadNegatives();
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_SurveyTaken(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::loadSurvey');
        ApexPages.currentPage().getParameters().put('id','5000K000028Qp7EQAS');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl();
        // cls.id = '5000K000028Qp7EQAS';
        cls.refresh();
        cls.setLoadSurvey();
        
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        cls.loadSurvey();
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_AFI_Inquiry(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::loadAFI_Inquiry');
        ApexPages.currentPage().getParameters().put('id','5000K00001jMKEa');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl(); 
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_AFI_Complaint(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::loadAFI_Complaint');
        ApexPages.currentPage().getParameters().put('id','5000K00001jMJlO');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl(); 
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_AFI_Request(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::loadAFI_Request');
        ApexPages.currentPage().getParameters().put('id','5000K00001jMKTQ');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl(); 
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_AFI_SocialPost(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::loadAFI_SocialPost');
        ApexPages.currentPage().getParameters().put('id','5000K00001mITIi');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl(); 
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_ALI_Inquiry(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::ALI Inquiry');
        ApexPages.currentPage().getParameters().put('id','5000K00001mIVf3');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl(); 
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_ALI_Request(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::ALI Request');
        ApexPages.currentPage().getParameters().put('id','5000K00001jMJne');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl(); 
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_ALI_Complaint(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::ALI Complaint');
        ApexPages.currentPage().getParameters().put('id','5000K00001jMMmtQAG');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl(); 
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_AMFS_Request(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::AMFS Request');
        ApexPages.currentPage().getParameters().put('id','5000K00001mIXI6');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl(); 
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_AMFS_Socialpost(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::AMFS Socialpost');
        ApexPages.currentPage().getParameters().put('id','5000K00001jMIiY');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl(); 
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_AMFS_Complaint(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::AMFS Complaint');
        ApexPages.currentPage().getParameters().put('id','5000K00001jMKpv');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl(); 
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrl_AMFS_Inquiry(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::AMFS Inquiry');
        ApexPages.currentPage().getParameters().put('id','5000K00001jMJeX');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl(); 
        Test.stopTest();
    }
    
    @isTest static void testAttachment_CustomPage_ctrlList(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Attach List');
        ApexPages.currentPage().getParameters().put('id','02s6F00000fTo4GQAS');
        Attachment_CustomPage_ctrl cls = new Attachment_CustomPage_ctrl(); 
        cls.loadAttachments();
         
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        
        Test.stopTest();
    }
    
    @isTest static void testAttachment_CustomPage_ctrlDetail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Attach Detail');
        ApexPages.currentPage().getParameters().put('id','00P6F00001VOwcxUAD');
        Attachment_CustomPage_ctrl cls = new Attachment_CustomPage_ctrl();  
        
        Test.stopTest();
    }
    
    @isTest static void  testCallLine_CustomPage_ctrlListByContact(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        Contact con = new Contact();
        con.LastName = 'admin';
        con.Entity__c = 'AFI';
        con.policy_no__c = '029-1928729';
        insert con;
        
        // contact con = [select id, name from contact where id = '0039000001XkRRWAA3' limit 1];
        
        ApexPages.StandardController stc = new ApexPages.StandardController(con);
        // ApexPages.currentPage().getParameters().put('id',con.Id);

        System.debug(':::Call Line List');
        CallLine_CustomPage_ctrl cls = new CallLine_CustomPage_ctrl(); 
        cls.id = '0039000001XkRRWAA3';
        cls.firstCallLine = false;
        cls.loadCallLines();
         
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        
        cls.setTrueVaribale('LoadActivityHistories');
        cls.setTrueVaribale('LoadActivityHistory');
        cls.setTrueVaribale('LoadOpenActivity');
        cls.setTrueVaribale('LoadCallLine');
        cls.setTrueVaribale('LoadCallLineHistory');
        cls.setTrueVaribale('LoadCallLineParent'); 
        
        Test.stopTest();
    }
    
    @isTest static void testCallLine_CustomPage_ctrlDetail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Call Line List');
        ApexPages.currentPage().getParameters().put('id','a016F00001DlgPTQAZ');
        CallLine_CustomPage_ctrl cls = new CallLine_CustomPage_ctrl();  
        
        Test.stopTest();
    }
    
    @isTest static void testCallLine_CustomPage_ctrlListByCampaign(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Call Line List');
        ApexPages.currentPage().getParameters().put('id','02s6F00000fTo4GQAS');
        CallLine_CustomPage_ctrl cls = new CallLine_CustomPage_ctrl(); 
        cls.loadCallLines_campaign();
        cls.id = 'a012s000003lHNbAAM';
        cls.firstActivityHistory = false;
        cls.loadActivityHistory_callLine();
        Test.stopTest();
    }
    
    
    @isTest static void testCallList_CustomPage_ctrlList(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Campaign List');
        CallList_CustomPage_ctrl cls = new CallList_CustomPage_ctrl(); 
        cls.id = '02s6F00000fTo4GQAS';
        cls.loadCallLines_campaign();
        cls.id = 'a000K00001vsdcdQAA';
        cls.loadCallLines_Parent();
        
        cls.current_page = 1;
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        
        Test.stopTest();
    }
    
    @isTest static void testCallList_CustomPage_ctrlDetail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Campaign Detail');
        ApexPages.currentPage().getParameters().put('id','a000K000020B7ChQAK');
        CallList_CustomPage_ctrl cls = new CallList_CustomPage_ctrl();  
        Test.stopTest();
    } 
    
        
    @isTest static void testCaseEscalation_CustomPage_ctrlDetail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Escalation Detail');
        ApexPages.currentPage().getParameters().put('id','a1q0K000002fbEEQAY');
        CaseEscalation_CustomPage_ctrl cls = new CaseEscalation_CustomPage_ctrl();  
        Test.stopTest();
    }
        
    @isTest static void testCaseMilestone_CustomPage_ctrlDetail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Milestone Detail');
        ApexPages.currentPage().getParameters().put('id','5556F00000JvNwGQAV');
        CaseMilestone_CustomPage_ctrl cls = new CaseMilestone_CustomPage_ctrl();  
        Test.stopTest();
    }
 
    
    @isTest static void testChatTranscript_CustomPage_ctrlListByContact(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        Contact con = new Contact();
        con.LastName = 'admin';
        con.Entity__c = 'AFI';
        con.policy_no__c = '029-1928729';
        insert con; 
        // contact con = [select id, name from contact where id = '0039000001XRdnsAAD' limit 1];
        
        ApexPages.StandardController stc = new ApexPages.StandardController(con);
        // ApexPages.currentPage().getParameters().put('id',con.Id);

        System.debug(':::ChatTranskip List');
        ChatTranscript_CustomPage_ctrl cls = new ChatTranscript_CustomPage_ctrl(); 
        cls.id = '0039000001XRdns';
        cls.loadChatTranscripts();
        
        
        cls.current_page = 1;
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        Test.stopTest();
    }
    
    @isTest static void testChatTranscript_CustomPage_ctrlListByCase(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::ChatTranskip List');
        ChatTranscript_CustomPage_ctrl cls = new ChatTranscript_CustomPage_ctrl(); 
        cls.id = '5000K00001vJQEEQA4';
        cls.loadChatTranscripts_case();
        Test.stopTest();
    }
    
    @isTest static void testChatTranscript_CustomPage_ctrlDetail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::ChatTranskip Detail');
        ApexPages.currentPage().getParameters().put('id','5706F0000005se7QAA');
        ChatTranscript_CustomPage_ctrl cls = new ChatTranscript_CustomPage_ctrl();  
        Test.stopTest();
    }
     
    @isTest static void testChatTranscript_CustomPage_ctrlListByEvent(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
 
        System.debug(':::ChatTranskip List EVent');
        ChatTranscript_CustomPage_ctrl cls = new ChatTranscript_CustomPage_ctrl(); 
        cls.id = '0039000001XRdns';
        cls.loadChatTranscriptEvent();
        Test.stopTest();
    }
    
    @isTest static void testEmailSMSLog_CustomPage_ctrlListByContact(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Email SMS Log List');
        /* Contact con = new Contact();
        con.LastName = 'admin';
        con.Entity__c = 'AFI';
        con.policy_no__c = '029-1928729';
        insert con; 
        contact con = [select id, name from contact where id = '0039000001XRdnsAAD' limit 1];
        
        ApexPages.StandardController stc = new ApexPages.StandardController(con);
        ApexPages.currentPage().getParameters().put('id',con.Id); */
        
        ApexPages.currentPage().getParameters().put('id','0030K00001tZOKp');
        
        
        EmailSMSLog_CustomPage_ctrl cls = new EmailSMSLog_CustomPage_ctrl(); 
        cls.id = '0030K00001tZOKp';
        cls.loadLogs_contact();
        
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        
        Test.stopTest();
    } 
    
    @isTest static void testEmailSMSLog_CustomPage_ctrlListByCase(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Email SMS Log List');
        
        ApexPages.currentPage().getParameters().put('id','0030K00001tZOKpQAO');
        EmailSMSLog_CustomPage_ctrl cls = new EmailSMSLog_CustomPage_ctrl(); 
        cls.id = '0030K00001tZOKpQAO';
        cls.loadLogs();
        Test.stopTest();
    } 

    @isTest static void testEmailSMSLog_CustomPage_ctrlDetail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Email SMS Log Detail');
        ApexPages.currentPage().getParameters().put('id','a0h6F00000Ht2uPQAR');
        EmailSMSLog_CustomPage_ctrl cls = new EmailSMSLog_CustomPage_ctrl();  
        Test.stopTest();
    }
    
       
    @isTest static void testEmail_CustomPage_ctrlListByCase(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Email List');
        Email_CustomPage_ctrl cls = new Email_CustomPage_ctrl(); 
        cls.id = '5006F00001TscutQAB';
        
        cls.loadEmails();
        cls.loadEmails_vf_case();
        Test.stopTest();
    } 

    @isTest static void testEmail_CustomPage_ctrlDetail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Email Detail');
        ApexPages.currentPage().getParameters().put('id','02s6F00000fSBxdQAG');
        Email_CustomPage_ctrl cls = new Email_CustomPage_ctrl();  
        Test.stopTest();
    }
 	
    
    @isTest static void testMIDSecurePayment_CustomPage_ctrlList(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        // contact con = [select id, name from contact where id = '0039000001XRdnsAAD' limit 1];
        
        // ApexPages.StandardController stc = new ApexPages.StandardController(con);
        // 
        // 
        
        /* Contact con = new Contact();
        con.LastName = 'admin';
        con.Entity__c = 'AFI';
        con.policy_no__c = '029-1928729';  
        insert con; */
        
        string conId = '0039000001XRdns';
        // string conId = con.id;
        ApexPages.currentPage().getParameters().put('id',conId);
        
        
        System.debug(':::MidSecure List');
        MIDSecurePayment_CustomPage_ctrl cls = new MIDSecurePayment_CustomPage_ctrl(); 
        cls.id = conId;
        cls.loadMIDSecurePayments();
        cls.current_page = 1;
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        Test.stopTest();
    }
    
    @isTest static void testMIDSecurePayment_CustomPage_ctrlDetail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::MidSecure Detail');
        // ApexPages.currentPage().getParameters().put('id','a1z0K000001sxU5QAI');
        ApexPages.currentPage().getParameters().put('id','a1z0K000001sxU5');
        MIDSecurePayment_CustomPage_ctrl cls = new MIDSecurePayment_CustomPage_ctrl();  
        Test.stopTest();
    }
    
    
    @isTest static void testNegativeFeedback_CustomPage_ctrl_Detail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Negative Feedback Detail');
        // ApexPages.currentPage().getParameters().put('id','a0l0K00000Ekg5tQAB');
        ApexPages.currentPage().getParameters().put('id','a0l0K00000Ekg5t');
        NegativeFeedback_CustomPage_ctrl cls = new NegativeFeedback_CustomPage_ctrl();  
        cls.redirect();
        cls.current_page = 1;
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        Test.stopTest();
    }
	  
    @isTest static void testPureCloudCallService_CustomPage_ctrlDetail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());

        
        /* Contact con = new Contact();
        con.LastName = 'admin';
        con.Entity__c = 'AFI';
        con.policy_no__c = '029-1928729';
        insert con;*/
        
        // ApexPages.StandardController stc = new ApexPages.StandardController(con);
  
        System.debug(':::purecloud Call Service Detail');
        // ApexPages.currentPage().getParameters().put('id','a1o0K0000010jWKQAY');
        ApexPages.currentPage().getParameters().put('id','a1o0K0000010jWK');
        PureCloudCallService_CustomPage_ctrl cls = new PureCloudCallService_CustomPage_ctrl();  
        Test.stopTest();
    }

      
    @isTest static void testPureCloud_CallAgent_CustomPage_ctrlDetail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::purecloud Call agent Detail');
        // ApexPages.currentPage().getParameters().put('id','a1n6F00000KfZnAQAV');
        ApexPages.currentPage().getParameters().put('id','a1n6F00000KfZnA');
        PureCloud_CallAgent_CustomPage_ctrl cls = new PureCloud_CallAgent_CustomPage_ctrl();  
        cls.redirect();
        Test.stopTest();
    }
    
    
    @isTest static void testSocialPost_CustomPage_ctrlDetail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::SOcial Post Detail');
        //ApexPages.currentPage().getParameters().put('id','0ST2s000001A0bkGAC');
        ApexPages.currentPage().getParameters().put('id','0ST2s000001A0bk');
        SocialPost_CustomPage_ctrl cls = new SocialPost_CustomPage_ctrl();  
        cls.redirect();
        Test.stopTest();
    }

    
    @isTest static void testSurveyTaken_CustomPage_ctrlDetail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Survey Taken Detail');
        // ApexPages.currentPage().getParameters().put('id','a0N2s000000rBmWEAU');
        ApexPages.currentPage().getParameters().put('id','a0N2s000000rBmW');
        SurveyTaken_CustomPage_ctrl cls = new SurveyTaken_CustomPage_ctrl();  
        cls.redirect();
        cls.refresh();
        cls.current_page = 1;
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        
        Test.stopTest();
    }

    @isTest static void  testTask_CustomPage_ctrlListByContact(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        /* tact con = new Contact();
        con.LastName = 'admin';
        con.Entity__c = 'AFI';
        con.policy_no__c = '029-1928729';
        insert con; 
        
        
        contact con2 = [select id, name from contact where id = '0039000001XRdns' limit 1];
        
        ApexPages.StandardController stc = new ApexPages.StandardController(con2);
        ApexPages.currentPage().getParameters().put('id',con2.Id); */
		ApexPages.currentPage().getParameters().put('id','0039000001XRcke');
        System.debug(':::Task List');
        Task_CustomPage_ctrl cls = new Task_CustomPage_ctrl(); 
        cls.id = '0039000001XRcke';
        cls.loadOpenActivity();
        cls.id = '0039000001XRdns';
        cls.loadActivityHistory(); 
        
        cls.current_page = 1;
        cls.total_page = 15;
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        Test.stopTest();
    }

    
    
    @isTest static void testTask_CustomPage_ctrlDetail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Task Detail');
        ApexPages.currentPage().getParameters().put('id','00T2s00000LgCNbEAN');
        Task_CustomPage_ctrl cls = new Task_CustomPage_ctrl();  
        cls.redirect();
        cls.id = '02s6F00000fTo4GQAS';
        cls.loadAttachments();
        Test.stopTest();
    }
    
    
    @isTest static void testCallLine_CustomPage_ctrlListByActivityHistory(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Call Line List');
        ApexPages.currentPage().getParameters().put('id','a012s000006f02SAAQ');
        CallLine_CustomPage_ctrl cls = new CallLine_CustomPage_ctrl();  
        cls.id = 'a012s000006f02SAAQ';
        cls.loadActivityHistories();
        Test.stopTest();
    }
    
    
    @isTest static void testActivityHistories_CustomPage_ctrlDetail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Call Line List');
        ApexPages.currentPage().getParameters().put('id','a012s000006f02SAAQ');
        ApexPages.currentPage().getParameters().put('bucketName','TEST');
        ActivityHistories_CustomPage_ctrl cls = new ActivityHistories_CustomPage_ctrl(); 
        cls.refresh(); 
        Test.stopTest();
    }
    
    
    @isTest static void testCallLine_CustomPage_ctrlListByParentHistory(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Call Line List');
        ApexPages.currentPage().getParameters().put('id','a012s000002NaP6AAK');
        CallLine_CustomPage_ctrl cls = new CallLine_CustomPage_ctrl();  
        cls.id = 'a012s000002NaP6AAK';
        cls.firstCallLineHistory = false;
        cls.loadCallLineHistory();
        cls.firstCallLineParent = false;
        cls.loadParentCallLine(); 
        cls.firstOpenActivity = false;
        cls.loadOpenActivity_callLine();
        Test.stopTest();
    }
 	 
    @isTest static void testMIDSecurePayment_CustomPage_ctrlListByCustomHistories(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
           
        ApexPages.currentPage().getParameters().put('id','a1z2s000000Xh1PAAS');
        MIDSecurePayment_CustomPage_ctrl cls = new MIDSecurePayment_CustomPage_ctrl(); 
        cls.id = 'a1z2s000000Xh1PAAS';
        cls.loadMidCustomHistory(); 
        cls.loadMidSecurePaymentHistory();
        Test.stopTest();
    }
    
    
    @isTest static void testMidCustomHistory_CustomPage_ctrlByDetail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
           
        ApexPages.currentPage().getParameters().put('id','a0S2s000000wX1sEAE');
        MidCustomHistory_CustomPage_ctrl cls = new MidCustomHistory_CustomPage_ctrl();  
        cls.refresh();
        Test.stopTest();
    }
    
    
    @isTest static void testGetAllObject(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
           
        ApexPages.currentPage().getParameters().put('id','a0S2s000000wX1sEAE');
        ArchivedObject_CustomPage_ctrl cls = new ArchivedObject_CustomPage_ctrl();  
        cls.loadCustomObjects();
        Test.stopTest();
    }
    
}