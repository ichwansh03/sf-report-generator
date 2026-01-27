@isTest
public class ChatTranscript_CustomPage_ctrlTest

 {
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
}