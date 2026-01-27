@isTest
public class EmailSMSLog_CustomPage_ctrlTest
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
     
    @isTest static void testEmailSMSLog_CustomPage_ctrlListByContact(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        
        System.debug(':::Email SMS Log List'); 
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
    
       
}