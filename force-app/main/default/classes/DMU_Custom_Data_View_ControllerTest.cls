@isTest
public class DMU_Custom_Data_View_ControllerTest {
    static testMethod void myTest (){
        
        Contact ct = new Contact();
        ct.LastName = '520-3026637';
        ct.Policy_No__c = '520-3026637';
        ct.PolicyApp__c = 'RLS';
        ct.Entity__c = 'AMFS';
        insert ct;
                
        Test.startTest();
        DMU_Custom_Data_View_Controller test = new DMU_Custom_Data_View_Controller();
        
        // Summary - Daily
        test.DataType = 'Summary';
        test.RangeDateType = 'Daily';
        test.filterdata.Filter_StartDate__c = date.newInstance(2021, 1, 1);
        test.filterdata.Filter_EndDate__c = date.newInstance(2021, 1, 10);
        test.filterdata.Type_Doc__c = 'polis hardcopy';
        test.typeControl();

        // Summary - Monthly
        test.DataType = 'Summary';
        test.RangeDateType = 'Monthly';
        test.filterdata.Filter_StartDate__c = date.newInstance(2021, 1, 1);
        test.filterdata.Filter_EndDate__c = date.newInstance(2021, 1, 10);
        test.filterdata.Type_Doc__c = 'polis hardcopy';
        test.hideData();
        test.typeControl();

        test.filterdata.Type_Doc__c = 'redelivery';
        test.hideData();
        test.typeControl();

        test.filterdata.Type_Doc__c = 'epolicy';
        test.hideData();
        test.typeControl();

        test.filterdata.Type_Doc__c = 'AXA Tower';
        test.hideData();
        test.typeControl();

        test.filterdata.Type_Doc__c = 'Kartu Kesehatan';
        test.hideData();
        test.typeControl();

        test.filterdata.Type_Doc__c = 'surat hardcopy';
        test.hideData();
        test.typeControl();

        test.filterdata.Type_Doc__c = 'e-letter';
        test.hideData();
        test.typeControl();

        test.filterdata.Type_Doc__c = 'transaction statement (hardcopy)';
        test.hideData();
        test.typeControl();

        test.filterdata.Type_Doc__c = 'transaction statement (email)';
        test.hideData();
        test.typeControl();

        test.filterdata.Type_Doc__c = 'SMS';
        test.hideData();
        test.typeControl();

        test.filterdata.Type_Doc__c = 'Policy BTO';
        test.hideData();
        test.typeControl();

        test.exportAll();

        // Detail - Policy Hardcopy
        test.DataType = 'Detail';
        test.cLookup = new MID_Secure_Payment__c();
        test.cLookup.Contact__c = ct.id;
        test.storeContactId();
        //test.filterdata.Filter_StartDate__c = date.newInstance(2021, 1, 1);
        //test.filterdata.Filter_EndDate__c = date.newInstance(2021, 1, 10);
        test.filterdata.Type_Doc__c = 'polis hardcopy';
        test.typeControl();

        test.filterdata.Type_Doc__c = 'redelivery';        
        test.typeControl();

        test.filterdata.Type_Doc__c = 'epolicy';
        test.typeControl();

        test.filterdata.Type_Doc__c = 'AXA Tower';
        test.typeControl();

        test.filterdata.Type_Doc__c = 'Kartu Kesehatan';
        test.typeControl();

        test.filterdata.Type_Doc__c = 'surat hardcopy';
        test.typeControl();

        test.filterdata.Type_Doc__c = 'e-letter';
        test.typeControl();

        test.filterdata.Type_Doc__c = 'transaction statement (hardcopy)';
        test.typeControl();

        test.filterdata.Type_Doc__c = 'transaction statement (email)';
        test.typeControl();

        test.filterdata.Type_Doc__c = 'SMS';
        test.typeControl();

        test.filterdata.Type_Doc__c = 'Policy BTO';
        test.typeControl();
        
        test.exportAll();
        test.SendAll();
        test.CheckJob();
        test.ExportAllBTO();

    }
}