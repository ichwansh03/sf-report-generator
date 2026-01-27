@isTest
public class popupUserOnCaseClassTest {
    public static testMethod void clickButton() {
        Case cs = new Case();
        cs.Subject = 'Subject Test Case';
        cs.Division__c = 'CCC';
        cs.Named_User__c = 'test';
        insert cs;
        
        Department__c d = new Department__c();
        d.name = 'test1';
        insert d;
        
        //Case_Internal_Comment__c cic = new Case_Internal_Comment__c();
        Named_User__c nu = new Named_User__c();
        nu.Name = 'test';
        nu.Department__c = d.id;
        insert nu;
        
        Test.setCurrentPage(Page.popupUserOnCase);
        ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
        popupUserOnCaseClass popCls = new popupUserOnCaseClass(stdController);
		popCls.cic.Named_User__c = nu.id;
        popCls.updateCase();
    }
}