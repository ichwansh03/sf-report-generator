@isTest
public class NegativeFeedback_CustomPage_ctrltest
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
     
    
    @isTest static void testNegativeFeedback_CustomPage_ctrlList(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Negative Feedback List');
        // ApexPages.currentPage().getParameters().put('id','a0l0K00000Ekg5tQAB');
        ApexPages.currentPage().getParameters().put('id','a0l0K00000Ekg5t');
        NegativeFeedback_CustomPage_ctrl cls = new NegativeFeedback_CustomPage_ctrl();  
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
     
    
    @isTest static void testNegativeFeedback_CustomPage_ctrl_Detail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Negative Feedback Detail');
        // ApexPages.currentPage().getParameters().put('id','a0l0K00000Ekg5tQAB');
        ApexPages.currentPage().getParameters().put('id','a0l0K00000Ekg5t');
        NegativeFeedback_CustomPage_ctrl cls = new NegativeFeedback_CustomPage_ctrl();  
        cls.redirect(); 
        Test.stopTest();
    }
}