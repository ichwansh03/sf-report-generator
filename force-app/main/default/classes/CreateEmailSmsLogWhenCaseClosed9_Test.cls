@isTest(seeAllData = true)
public class CreateEmailSmsLogWhenCaseClosed9_Test {
    public static testmethod void createEmailSmsLogWhenCaseClosedTest9() {
        Test.startTest();
        String INQUIRY = 'Inquiry';
        String REQUEST = 'Request';
        String COMPLAINT = 'Complaint';
        String NEW_STATUS = 'New';
        String CLOSED = 'Closed';
        String RECORD_TYPE_EMAIL_SMS = 'Master - Email & SMS';
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = userObj.Entity__c;
        
        List<User> userList = [SELECT Id, Name, UserRole.Name FROM User WHERE UserRole.Name = 'CMU SPV MAGI'];
        if (userList.size() > 0) {
            System.runAs(userList.get(0)) {
                Account ac1 = new Account();
                ac1.Name = 'AccountTest9';
                ac1.Entity__c = entity;
                insert ac1;
                
                Contact contact1 = new Contact();
                contact1.FirstName = 'Bill';
                contact1.LastName = 'Gates';
                contact1.Email = 'billgates@email.com';
                contact1.MobilePhone = '0891667363';
                contact1.Policy_No__c = '77700127';
                contact1.Entity__c = entity;
                contact1.AccountId = ac1.Id;
                insert contact1;
                
                Contact contact2 = new Contact();
                contact2.FirstName = 'Bill2';
                contact2.LastName = 'Gates2';
                contact2.Email = 'billgates@email.com';
                contact2.MobilePhone = '0891667363';
                contact2.Policy_No__c = '77700128';
                contact2.Entity__c = entity;
                contact2.AccountId = ac1.Id;
                insert contact2;
                
                EmailSmsLogUtil emailSmsLogutil = new EmailSmsLogUtil();
                ICF_Parameter__c icfParamObj = emailSmsLogutil.getICFParamByRecordType(RECORD_TYPE_EMAIL_SMS, entity);
                //icfParamObj.Send_Thanks_Note_Flag__c = false;
                //update icfParamObj;
                
                ICF_Parameter__c icfParamNew = new ICF_Parameter__c();
                icfParamNew = icfParamObj.clone();
                icfParamNew.Send_Thanks_Note_Flag__c = false;
                insert icfParamNew;
                
                //CREATED-OPEN&CLOSED | COMPLAINT =============================================================================
                Case complaintCreateClosed = new Case();
                complaintCreateClosed.ContactId = contact1.Id;
                complaintCreateClosed.Type = COMPLAINT;
                complaintCreateClosed.Status = CLOSED;
                complaintCreateClosed.CHS_Status__c = 'Closed - Valid';
                complaintCreateClosed.Priority = 'Medium';
                complaintCreateClosed.Origin = 'Phone';
                complaintCreateClosed.Nature__c = 'Claims';
                complaintCreateClosed.Nature_Config__c = 'Claims';
                complaintCreateClosed.Category__c = 'Claims Delay - Others';
                complaintCreateClosed.Category_Config__c = 'Claims Delay - Others';
                complaintCreateClosed.Complaint_type__c = 'Simple';
                complaintCreateClosed.Received_date__c = Date.parse('12/24/2016');
                complaintCreateClosed.AccountId = contact1.AccountId;
                insert complaintCreateClosed;
                
                Case complaintCreateOpen = new Case();
                complaintCreateOpen.ContactId = contact2.Id;
                complaintCreateOpen.Type = COMPLAINT;
                complaintCreateOpen.Status = NEW_STATUS;
                complaintCreateOpen.CHS_Status__c = 'New';
                complaintCreateOpen.Priority = 'Medium';
                complaintCreateOpen.Origin = 'Phone';
                complaintCreateOpen.Nature__c = 'Claims';
                complaintCreateOpen.Nature_Config__c = 'Claims';
                complaintCreateOpen.Category__c = 'Claims Delay - Others';
                complaintCreateOpen.Category_Config__c = 'Claims Delay - Others';
                complaintCreateOpen.Complaint_type__c = 'Simple';
                complaintCreateOpen.Received_date__c = Date.parse('12/24/2016');
                complaintCreateOpen.AccountId = contact2.AccountId;
                insert complaintCreateOpen;
            }
        }
        
        Test.stopTest();
    }
}