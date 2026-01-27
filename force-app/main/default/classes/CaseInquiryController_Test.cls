@isTest(seeAllData = true)
public class CaseInquiryController_Test {
    public static testmethod void caseInquiryTest() {
        Test.startTest();
        String caseInquiryVF = '/apex/CaseInquiry';
        String parentPageName = 'parentPageName';
        String firstLoad = 'firstLoad';
        String sourceContact = 'contact';
        String sourceEmail = 'email';
        String caseTypeConfig = '<br />Claim Procedure<br />Property Product';
        
        DescribeSObjectResult describeResultCase = Case.getSObjectType().getDescribe();
        List<String> caseFieldList = new List<String>(describeResultCase.fields.getMap().keySet());
        String caseFields = String.join(caseFieldList, ',');
        String caseQuery = ' SELECT ' + caseFields + ' FROM Case ORDER BY CreatedDate DESC LIMIT 1 ';
        Case caseObj = Database.query(caseQuery);
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = userObj.Entity__c;
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest10';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com';
        contact1.MobilePhone = '0891667363';
        contact1.Policy_No__c = '100000019';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        PageReference pageRef = new PageReference(caseInquiryVF);
        pageRef.getParameters().put('def_contact_id', contact1.Id);
        pageRef.getParameters().put('def_account_id', caseObj.AccountId);
        pageRef.getParameters().put('RecordType', caseObj.RecordTypeId);
        pageRef.getParameters().put('cas5', caseObj.Type);
        pageRef.getParameters().put('retURL', '/' + caseObj.Id);
        pageRef.getParameters().put('parentPageName', parentPageName);
        pageRef.getParameters().put('firstLoad', firstLoad);
        pageRef.getParameters().put('entity', caseObj.Entity__c);
        pageRef.getParameters().put('cas11', sourceContact);
        pageRef.getParameters().put('cas3', contact1.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(caseObj);
        CaseInquiryController controller = new CaseInquiryController(sc);
        controller.selectedCaseTypeKeeper = caseTypeConfig;
        controller.save();
        controller.cancel();
        
        Test.stopTest();
    }
}