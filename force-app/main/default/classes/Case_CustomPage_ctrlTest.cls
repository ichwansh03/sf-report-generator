@isTest
public class Case_CustomPage_ctrlTest {
    @testsetup static void setup(){
        //data setup
        Profile p = [SELECT Id FROM Profile LIMIT 1]; 
        User u = new User(Alias = 'alias', Email='migrationdata@muliaraya.com', 
                          EmailEncodingKey='UTF-8', LastName='migration', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='migrationdata@axa.com', Entity__c='AFI');
        insert u;
          
    }
    
    @isTest static void testCase_CustomPage_ctrl(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        Contact con = new Contact();
        con.LastName = 'admin';
        con.Entity__c = 'AFI';
        insert con;
        
       	// contact con = [select id, name from contact where id = '0036F00002t4HZQQA2' limit 1];
        ApexPages.StandardController stc = new ApexPages.StandardController(con);
        ApexPages.currentPage().getParameters().put('id','0036F00002t4HZQQA2');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl(stc);
        cls.refresh();          
        cls.setLoadCases();
        cls.loadCases();
         
        System.debug(':::ALL');
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrlLoadRelatedCaseByContact2(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        ApexPages.currentPage().getParameters().put('id','0036F00002t4HZQQA2');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl();
        cls.refresh();          
        cls.setLoadCases();
        cls.loadCases();
         
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrlLoadRelatedCase(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        ApexPages.currentPage().getParameters().put('id','5000K00001jM7TNQA0');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl();
        cls.setLoadCases_c();
        cls.loadCases_c(); 
        Test.stopTest();
    }
    
    @isTest static void testCase_CustomPage_ctrlDetails(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        ApexPages.currentPage().getParameters().put('id','5000K00001jM7TNQA0');
        Case_CustomPage_ctrl cls = new Case_CustomPage_ctrl();
        cls.redirect();
        cls.getCaseDetail('5000K00001jM7TNQA0'); 
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
}