@isTest(seeAllData = true)
public class CustomCaseLookupController_Test {
    public static testmethod void createCustomCaseLookupControllerTest() {
        
        
        Test.startTest();
        Account ac1 = new Account();
        ac1.Name = 'AccountTest10';
        ac1.Entity__c = 'MAGI';
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com';
        contact1.MobilePhone = '0891667363';
        contact1.Policy_No__c = '100000015';
        contact1.Entity__c = 'MAGI';
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        String frm = 'Form';
        String txt = 'Text';
        
        String oppCustomLookupVF = '/apex/CustomCaseLookupLayout';
        PageReference pageRef = new PageReference(oppCustomLookupVF);
        pageRef.getParameters().put('lksrch', '');
        pageRef.getParameters().put('contactId', contact1.Id);
        pageRef.getParameters().put('frm', frm);
        pageRef.getParameters().put('txt', txt);
        Test.setCurrentPage(pageRef);
        
        CustomCaseLookupController copl = new CustomCaseLookupController();
        
        //init search
        PageReference initSearchResult = copl.search();
        System.assertEquals(null, initSearchResult);
        
        //perform search with param
        List<Case> searchResult = copl.performSearch('1');
        System.assertNotEquals(null, searchResult);
        
        //test formtag
        String formTag = copl.getFormTag();
        System.assertNotEquals(null, formTag);
        
        //test textbox
        String textBox = copl.getTextBox();
        System.assertNotEquals(null, textBox);
        
        Test.stopTest();
    }
}