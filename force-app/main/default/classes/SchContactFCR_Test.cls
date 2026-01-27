@isTest //(seeAllData=true)
public class SchContactFCR_Test {
      
    static testMethod void myTest() {
              
	    Test.startTest();        
        Contact ct = new Contact();
        ct.LastName = 'Test';
        ct.Entity__c = 'AFI';
        ct.Policy_No__c = '123456789';
        ct.Policy_No_Numeric__c = '123456789';
        ct.Insured_Name__c = 'Test';
        insert ct;
        
        // Create Case
        case cs = new case();
        cs.Subject = 'Test Class';
        cs.ContactId = ct.id;
        cs.Case_Type__c = 'Account Balance';
        insert cs;
        
        SchContactFCR sc1 = new SchContactFCR();
        sc1.Execute(null);

        Test.stopTest();
    }
}