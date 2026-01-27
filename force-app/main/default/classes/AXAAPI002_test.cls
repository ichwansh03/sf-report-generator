/*---------------------------------------------------------------
    Author      : Andy Putra
    Company     : MII
    Description : test class for Apex class AXAAPI002

    <History>
    <Date>      <Authors Name>     <Brief Description of Change>    
    ddMMyyyy    Andy Putra          Created
---------------------------------------------------------------*/
@isTest
public class AXAAPI002_test {
	@testsetup static void setup(){
        //data setup
        Profile p = [SELECT Id FROM Profile LIMIT 1]; 
        User u = new User(Alias = 'alias', Email='standardusertest@muliaraya.com', 
                          EmailEncodingKey='UTF-8', LastName='admin', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='admin@axa.com', Entity__c='AFI');
        insert u;
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
        AXAAPI_UtilityClass.stringToDate('2017-0929');
        AXAAPI_UtilityClass.stringToDatetime('2017-092914:16:10.000');
        Test.stopTest();
    }
    
    @isTest static void testAXAAPI000_GenerateAccessToken(){
		Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        AXAAPI000_GenerateAccessToken.generateAccessToken();
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
        //AXAAPI002B_EmailMessageByParentId.getEmailByParentId('id');
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
        cls.obj = 'Case';
        cls.key = 'subject';
        cls.value = 'search';
        cls.getData();
        cls.getObjectList();
        cls.getParamList();
        cls.getDataNext();
        cls.getDataPrevious();
        cls.to_page = '1';
        cls.getDataToPage();
        cls.getDataFirst();
        cls.getDataLast();
        
        Test.stopTest();
    }
    
    @isTest static void testAXAAPI001C_CaseByParam(){
		Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AXAAPI_CallOutMock());
        //AXAAPI001C_CaseByParam.getCaseByParam('key', 'value', 1, 1);
        Test.stopTest();
    }
}