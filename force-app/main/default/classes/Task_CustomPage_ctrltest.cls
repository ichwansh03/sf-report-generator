@isTest
public class Task_CustomPage_ctrltest
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
        ApexPages.currentPage().getParameters().put('id','02s6F00000fTo4GQAS');
        Task_CustomPage_ctrl cls = new Task_CustomPage_ctrl();  
        cls.redirect();
        cls.id = '02s6F00000fTo4GQAS';
        cls.loadAttachments();
        Test.stopTest();
    }
    
    
}