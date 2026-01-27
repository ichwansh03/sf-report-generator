@isTest(seeAllData = true)
public class CreateEmailSmsLogWhenCaseClosed18_Test {
    public static testmethod void createEmailSmsLogWhenCaseClosedTest18() {
        Test.startTest();
        String INQUIRY = 'Inquiry';
        String REQUEST = 'Request';
        String COMPLAINT = 'Complaint';
        String NEW_STATUS = 'New';
        String CLOSED = 'Closed';
        String RECORD_TYPE_EMAIL_SMS = 'Master - Email & SMS';
        String CLOSE_VALID = 'Closed - Valid';
        
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
                ac1.Name = 'AccountTest18';
                ac1.Entity__c = entity;
                insert ac1;
                
                Contact contact1 = new Contact();
                contact1.FirstName = 'Bill';
                contact1.LastName = 'Gates';
                contact1.Email = 'billgates@email.com';
                contact1.MobilePhone = '0891667363';
                contact1.Policy_No__c = '77700137';
                contact1.Entity__c = entity;
                contact1.AccountId = ac1.Id;
                insert contact1;
                
                EmailSmsLogUtil emailSmsLogutil = new EmailSmsLogUtil();
                ICF_Parameter__c icfParamObj = emailSmsLogutil.getICFParamByRecordType(RECORD_TYPE_EMAIL_SMS, entity);
                //icfParamObj.Send_ICF_Flag__c = false;
                //update icfParamObj;
                
                ICF_Parameter__c icfParamNew = new ICF_Parameter__c();
                icfParamNew = icfParamObj.clone();
                icfParamNew.Send_Thanks_Note_Flag__c = false;
                insert icfParamNew;
                
                //CREATED-OPEN | COMPLAINT =============================================================================
                Case complaintCreateOpen = new Case();
                complaintCreateOpen.ContactId = contact1.Id;
                complaintCreateOpen.Type = COMPLAINT;
                complaintCreateOpen.Status = NEW_STATUS;
                complaintCreateOpen.CHS_Status__c = 'New';
                complaintCreateOpen.Priority = 'Medium';
                complaintCreateOpen.Origin = 'Phone';
                complaintCreateOpen.Nature__c = 'Courier Delivery';
                complaintCreateOpen.Nature_Config__c = 'Courier Delivery';
                complaintCreateOpen.Category__c = 'Courier Delivery - Delivery';
                complaintCreateOpen.Category_Config__c = 'Courier Delivery - Delivery';
                complaintCreateOpen.Complaint_type__c = 'Simple';
                complaintCreateOpen.Received_date__c = Date.parse('12/24/2016');
                complaintCreateOpen.AccountId = contact1.AccountId;
                insert complaintCreateOpen;
                
                //UPDATED TO CLOSED==============================================================================================
                complaintCreateOpen.Status = CLOSED;
                complaintCreateOpen.CHS_Status__c = CLOSE_VALID;
                update complaintCreateOpen;
            }
        }
        Test.stopTest();
    }
}