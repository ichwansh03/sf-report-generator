@isTest
public class Attachment_CustomPage_ctrlTest
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
}