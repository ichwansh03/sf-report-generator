@isTest(seeAllData = true)
public class CaseComplaintLayoutController_Test {
    public static testmethod void caseComplaintLayoutTest() {
        Test.startTest();
        String caseComplaintLayoutVF = '/apex/CaseComplaintLayout';
        String parentPageName = 'parentPageName';
        String firstLoad = 'firstLoad';
        String sourceContact = 'contact';
        String sourceEmail = 'email';
        
        String INQUIRY = 'Inquiry';
        String REQUEST = 'Request';
        String COMPLAINT = 'Complaint';
        String NEW_STATUS = 'New';
        String CLOSED = 'Closed';
        String entity = 'MAGI';
        
        DescribeSObjectResult describeResultCase = Case.getSObjectType().getDescribe();
        List<String> caseFieldList = new List<String>(describeResultCase.fields.getMap().keySet());
        String caseFields = String.join(caseFieldList, ',');
        String caseQuery = ' SELECT ' + caseFields + ' FROM Case ORDER BY CreatedDate DESC LIMIT 1 ';
        Case caseObj = Database.query(caseQuery);
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com';
        contact1.MobilePhone = '0891667363';
        contact1.Policy_No__c = '100000014';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        PageReference pageRef = new PageReference(caseComplaintLayoutVF);
        pageRef.getParameters().put('parentPageName', parentPageName);
        pageRef.getParameters().put('RecordType', caseObj.RecordTypeId);
        pageRef.getParameters().put('cas5', caseObj.Type);
        pageRef.getParameters().put('retURL', '/' + caseObj.Id);
        pageRef.getParameters().put('firstLoad', firstLoad);
        pageRef.getParameters().put('entity', caseObj.Entity__c);
        pageRef.getParameters().put('cas11', sourceContact);
        pageRef.getParameters().put('cas3', contact1.Id);
        pageRef.getParameters().put('def_contact_id', contact1.Id);
        pageRef.getParameters().put('def_account_id', ac1.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(caseObj);
        CaseComplaintLayoutController controller = new CaseComplaintLayoutController(sc);
        
        controller.save();
        controller.SaveAndNew();
        controller.cancel();
        //controller.collectiveSave();
        
        Test.stopTest();
    }
}