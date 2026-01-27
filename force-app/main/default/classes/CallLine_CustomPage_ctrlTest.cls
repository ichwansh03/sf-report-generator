@isTest
public class CallLine_CustomPage_ctrlTest
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
    
}