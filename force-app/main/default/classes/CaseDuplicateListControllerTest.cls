/**
 * @description       : 
 * @author            : Ahmad Yazid Munif
 * @group             : 
 * @last modified on  : 08-06-2025
 * @last modified by  : Ahmad Yazid Munif
**/
@isTest
class CaseDuplicateListControllerTest {
    @testSetup
    static void setup() {
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AMFS';
        con1.Email = 'test1@abc.org';
        con1.MobilePhone = '11111';
        contactList.add(con1);
        insert contactList;
    }

    @isTest
    static void testControllerWithDuplicate() {
        Contact con1 = [SELECT Id FROM Contact WHERE LastName = 'cust01' LIMIT 1];
        Group testQ = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - PBC' LIMIT 1];
        
        List<AMFS_E2C_Setting__mdt> emailtoCase = AMFS_E2C_Setting__mdt.getAll().values();
        System.debug('emailtoCase'+emailtoCase);
        String testEmailAddress= '';
        for (AMFS_E2C_Setting__mdt setting : emailtoCase) {
            if (setting.Label == 'CS') {
                testEmailAddress=setting.Email_Case__c;
                break;
            }
        }

        String RecordTypeTxt=System.Label.AMFS_Case_Type;
        Id caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(RecordTypeTxt).getRecordTypeId();
    
        // RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Case'  AND Name = :System.Label.AMFS_Case_Type LIMIT 1];

        Datetime emailDate = System.now().addHours(-2);
        Datetime emailDate2 = System.now().addHours(-1);

        // Create test cases
        List<Case> caselist = new List<Case>();
        Case case1 = new Case();
        case1.Status = 'New';
        case1.Subject = 'Test Subject';
        case1.Origin = 'Email';
        case1.ContactId = con1.Id;
        case1.OwnerId = testQ.Id;
        case1.RecordTypeId = caseRecordTypeId;
        case1.Entity_Backup__c = 'AMFS';
        case1.Type = 'Inquiry';
        case1.e2cEmailToAddress__c = testEmailAddress;
        case1.Email_Message_Date__c = emailDate;
        case1.AMFS_Receive_on_Business_Hours__c = true;
        caselist.add(case1);

        Case case2 = new Case();
        case2.Status = 'New';
        case2.Subject = 'Test Subject';
        case2.Origin = 'Email';
        case2.ContactId = con1.Id;
        case2.OwnerId = testQ.Id;
        case2.RecordTypeId = caseRecordTypeId;
        case2.Entity_Backup__c = 'AMFS';
        case2.Type = 'Inquiry';
        case2.e2cEmailToAddress__c = testEmailAddress;
        case2.Email_Message_Date__c = emailDate2;
        case2.AMFS_Receive_on_Business_Hours__c = true;
        caselist.add(case2);
        insert caselist;
        // Case c1 = new Case(
        //     RecordTypeId = caseRecordTypeId,
        //     Subject = 'Test Subject',
        //     SuppliedEmail = 'test@example.com',
        //     Status = 'New',
        //     Priority = 'Medium'

        // );
        // insert c1;

        // // Duplicate case (same subject & email, different Id)
        // Case c2 = new Case(
        //     RecordTypeId = caseRecordTypeId,
        //     Subject = 'Test Subject',
        //     SuppliedEmail = 'test@example.com',
        //     Status = 'New',
        //     Priority = 'High'
           
        // );
        // insert c2;

        Case c = [SELECT Id FROM Case LIMIT 1];
        Test.setCurrentPage(Page.VF_Case_Duplicate_List);
        ApexPages.currentPage().getParameters().put('id', c.Id);
        
        Test.startTest();
        CaseDuplicateListController ctrl = new CaseDuplicateListController();
        Test.stopTest();
        
        System.assertNotEquals(null, ctrl.caseItem, 'caseItem should be set');
        System.assert(ctrl.cases.size() > 0, 'Should find duplicate cases');
    }

   
}