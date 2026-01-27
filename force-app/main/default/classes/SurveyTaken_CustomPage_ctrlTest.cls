@isTest
public class SurveyTaken_CustomPage_ctrlTest {
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
    
    
    
    @isTest static void testSurveyTaken_CustomPage_ctrlList(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Survey Taken List'); 
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
    
    @isTest static void testSurveyTaken_CustomPage_ctrlDetail(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Survey Taken Detail'); 
        ApexPages.currentPage().getParameters().put('id','a0N2s000000rBmW');
        SurveyTaken_CustomPage_ctrl cls = new SurveyTaken_CustomPage_ctrl();  
        cls.redirect(); 
        
        Test.stopTest();
    }

}