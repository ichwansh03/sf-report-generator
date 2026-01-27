@isTest
public class WS_TransferStatusWithdrawalFlipsTest {
	@isTest static void TestData(){
        Test.startTest();
        
        String entity = 'AMFS';
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest20';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com';
        contact1.MobilePhone = '0891667363';
        contact1.Policy_No__c = '315-4282671';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        Account ac2 = new Account();
        ac2.Name = 'AccountTest21';
        ac2.Entity__c = entity;
        insert ac2;
        
        Contact contact2 = new Contact();
        contact2.FirstName = 'Bill';
        contact2.LastName = 'Kevin';
        contact2.Email = 'billkevin@email.com';
        contact2.MobilePhone = '08916222222';
        contact2.Policy_No__c = '513-8265359';
        contact2.Entity__c = entity;
        contact2.AccountId = ac2.Id;
        insert contact2;
        
        Contact contact3 = new Contact();
        contact3.FirstName = 'Bill';
        contact3.LastName = 'Kevin';
        contact3.Email = 'billkevin@email.com';
        contact3.MobilePhone = '08916222222';
        contact3.Policy_No__c = '513-8265311';
        contact3.Entity__c = entity;
        contact3.AccountId = ac2.Id;
        contact3.PolicyApp__c = 'DMTM';
        insert contact3;
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = 'Request POS';
        inquiryCreateOpen.Status = 'Closed';
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Phone';
        inquiryCreateOpen.Case_Type__c = 'Request_POS_Withdrawal';
        inquiryCreateOpen.Case_Type_Config__c = 'Request_POS_Withdrawal' ;
        inquiryCreateOpen.Subject = 'Case Subject';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        //inquiryCreateOpen.ClosedDate = date.today();
        inquiryCreateOpen.Entity_Backup__c = 'AMFS';
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        insert inquiryCreateOpen;
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/TransferStatusWithdrawal/'; 
        req.httpMethod = 'POST';
        req.addHeader('Content-Type', 'application/json');
        string testbody = '{"payment_code":"PC04","policy_number":"315-4282671","claim_number":"172878","transfer_status":"success","transfer_date":"30-07-2024"}'; 
        
        req.requestBody = Blob.valueOf(testbody);
   
        RestContext.request = req;
        RestContext.response = res;
        
        WS_TransferStatusWithdrawalFlips.UpdateTransferStatus('PC04','315-4282671','172878','success','30-07-2024');
        WS_TransferStatusWithdrawalFlips.UpdateTransferStatus('PC05','513-8265359','150112','success','30-07-2024');
        WS_TransferStatusWithdrawalFlips.UpdateTransferStatus('PC10','','150112','success','30-07-2024');
        WS_TransferStatusWithdrawalFlips.UpdateTransferStatus('PC12','513-8265359','','success','30-07-2024');
        WS_TransferStatusWithdrawalFlips.UpdateTransferStatus('','513-8265359','','success','30-07-2024');
        WS_TransferStatusWithdrawalFlips.UpdateTransferStatus('PC00','513-8265359','','success','30-07-2024');
        WS_TransferStatusWithdrawalFlips.UpdateTransferStatus('PC04','513-8265311','','success','30-07-2024');
        WS_TransferStatusWithdrawalFlips.UpdateTransferStatus('PC04','000-0000000','','success','30-07-2024');
        Test.stopTest();
    }
    
    @isTest static void TestDataDMTM(){
        Test.startTest();
        
        String entity = 'AMFS';
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest20';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com';
        contact1.MobilePhone = '0891667363';
        contact1.Policy_No__c = '315-4282671';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        contact1.PolicyApp__c = 'DMTM';
        insert contact1;
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/TransferStatusWithdrawal/'; 
        req.httpMethod = 'POST';
        req.addHeader('Content-Type', 'application/json');
        string testbody = '{"payment_code":"PC04","policy_number":"315-4282671","claim_number":"172878","transfer_status":"success","transfer_date":"30-07-2024"}'; 
        
        req.requestBody = Blob.valueOf(testbody);
   
        RestContext.request = req;
        RestContext.response = res;
        
        WS_TransferStatusWithdrawalFlips.UpdateTransferStatus('PC04','315-4282671','172878','success','30-07-2024');
        Test.stopTest();
    }
    
    @isTest static void TestDataContactNull(){
        Test.startTest();
        
        String entity = 'AMFS';
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/TransferStatusWithdrawal/'; 
        req.httpMethod = 'POST';
        req.addHeader('Content-Type', 'application/json');
        string testbody = '{"payment_code":"PC04","policy_number":"315-4282671","claim_number":"172878","transfer_status":"success","transfer_date":"30-07-2024"}'; 
        
        req.requestBody = Blob.valueOf(testbody);
   
        RestContext.request = req;
        RestContext.response = res;
        
        WS_TransferStatusWithdrawalFlips.UpdateTransferStatus('PC04','315-4282671','172878','success','30-07-2024');
        Test.stopTest();
    }
}