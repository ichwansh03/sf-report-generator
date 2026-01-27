@isTest(seeAllData = true)
public class MemoApprovalController_Test {
    public static testmethod void memoApprovalTest() {
        Test.startTest();
        String memoApprovalVF = '/apex/Memo_Approval_Print_MAGI';
        String INQUIRY = 'Inquiry';
        String REQUEST = 'Request';
        String COMPLAINT = 'Complaint';
        String NEW_STATUS = 'New';
        String CLOSED = 'Closed';
        String MASTER_EMAIL_SMS = 'Master - Email & SMS';
        String MASTER_CCC = 'Master - CCC';
        String OPEN = 'Open';
        String AMFS = 'AMFS';
        String AFI = 'AFI';
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = userObj.Entity__c;
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest20';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com';
        contact1.MobilePhone = '0891667363';
        contact1.Policy_No__c = '77700144';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        //CREATED-OPEN | INQUIRY =============================================================================
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = INQUIRY;
        inquiryCreateOpen.Status = NEW_STATUS;
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Phone';
        inquiryCreateOpen.Case_Type__c = 'Claim Procedure';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        insert inquiryCreateOpen;
        
        PageReference pageRef = new PageReference(memoApprovalVF);
        pageRef.getParameters().put('id', inquiryCreateOpen.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(inquiryCreateOpen);
        MemoApprovalController controller = new MemoApprovalController(sc);
        
        controller.getPrintView();
        
        controller.entitas = AMFS;
        controller.dmlOperation();
        controller.entitas = AFI;
        controller.dmlOperation();
        controller.dmlOperationMAGI();
        
        Test.stopTest();
    }
}