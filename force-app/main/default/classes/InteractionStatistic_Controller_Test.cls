@isTest
public class InteractionStatistic_Controller_Test {
    public static testMethod void populateCaseData() {
        Account a = new Account();
        a.Name = 'Account TestData';
        insert a;
        
        Contact con = new Contact();
        con.LastName = 'Contact LastName';
        con.FirstName = 'Contact FirstName';
        insert con;
        
        Case cs1 = new Case();
        cs1.contactId = con.Id;
        cs1.Subject = 'Subject 1';
        cs1.Origin = 'Mail';
        cs1.Case_Type__c = 'AMFS Customer';
        cs1.General_Attitude__c = 'Happy';
        insert cs1;
        
        Test.startTest();
        
        PageReference pageRef = Page.InteractionStatistic;
		Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', String.valueOf(con.Id));
        ApexPages.StandardController sc = new ApexPages.StandardController(con);
        InteractionStatistic_Controller controller = new InteractionStatistic_Controller(sc);
        controller.listPieData();
        
        Test.stopTest();
    }
}