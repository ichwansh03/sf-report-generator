@isTest
public class ArchiveData_Search_ctrlTest {
 @testsetup static void setup(){
        //data setup
        Profile p = [SELECT Id FROM Profile LIMIT 1]; 
        User u = new User(Alias = 'alias', Email='migrationdata@muliaraya.com', 
                          EmailEncodingKey='UTF-8', LastName='migration', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='migrationdata@axa.com', Entity__c='AFI');
        insert u; 
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
        
        cls.getObjectList();
        cls.getParamList(); 
        cls.obj = 'EmailMessage';
        cls.key = 'subject';
        cls.value = 'Policy';
        cls.getData();  
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
        Test.stopTest();
    }
    
}