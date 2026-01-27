@isTest
public class AXAAPI_UtilityClassTest {
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
        AXAAPI_UtilityClass.stringToBoolean('');
        AXAAPI_UtilityClass.stringToDate('2017-0929');
        AXAAPI_UtilityClass.stringToDatetime('2017-092914:16:10.000');
        AXAAPI_UtilityClass.getsMilestoneNameByTypeId('5556F00000JvNwGQAV');
        AXAAPI_UtilityClass.getsMilestoneNameByTypeId('5556F00000JvNwG25V'); // id asal 
        AXAAPI_UtilityClass.getNewAttachmentID('5556F00000JvNwG25V'); // id asal
        AXAAPI_UtilityClass.getDataNext(2); // id asal 
        AXAAPI_UtilityClass.getDataPrevious(2); // id asal 
        AXAAPI_UtilityClass.getDataToPage(1,'2'); // id asal 
        AXAAPI_UtilityClass.getDataFirst(5); // id asal 
        AXAAPI_UtilityClass.getDataLast(4); // id asal 
        AXAAPI_UtilityClass.showListPagination(2,5); // id asal 
        Test.stopTest();
    }
        
}