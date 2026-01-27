@isTest
public class DMU_MANIFEST_KOMPLAIN_ControllerTest {
    static testMethod void myTest (){
        
        Contact ct = new Contact();
        ct.LastName = '520-3026637';
        ct.Policy_No__c = '520-3026637';
        ct.PolicyApp__c = 'RLS';
        ct.Entity__c = 'AMFS';
        insert ct;
        
        Case cs = new Case();
        cs.Subject = 'Test Class';
        cs.Description = 'Test Class';
        cs.Entity_Backup__c = 'AMFS';
        id rt = Schema.SObjectType.Case.getRecordTypeInfosByName().get('RequestAMFSCase').getRecordTypeId();
        cs.RecordTypeId = rt;
        cs.ContactId = ct.id;
        cs.Type = 'Request';
        cs.Case_Type__c = 'Request_Courier Delivery ? Change of Address';
        cs.PIC_Department_LU__c = UserInfo.getUserId();
        insert cs;        
                
        Test.startTest();
        DMU_MANIFEST_KOMPLAIN_Controller test = new DMU_MANIFEST_KOMPLAIN_Controller();
        
        // Summary - Daily
        test.filterdata.Due_Date__c = date.today()-1; //date.newInstance(2021, 1, 1);
        test.filterdata.Closed_Date__c = date.today()+1; //date.newInstance(2021, 1, 10);
        test.getdata();
        
        test.exportAll();
        
        string temp = test.xlsHeader;
        string temp2 = test.xlsHeader2;

    }
}