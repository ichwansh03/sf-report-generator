@isTest(seealldata=true)
private class JatisWhatsappBatch_Test {
    static testmethod void test() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AFI';
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest20';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Adi';
        contact1.LastName = 'Wijaya';
        contact1.Email = 'adiwijaya@email.com';
        contact1.MobilePhone = '6285716222996';
        contact1.Policy_No__c = '77700144';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        Email_SMS_Log__c whatsappLog = new Email_SMS_Log__c();
        whatsappLog.Entity__c = entity;
        whatsappLog.Contact__c = contact1.Id;
        whatsappLog.ready_to_send__c = true;
        whatsappLog.Category__c = 'ICF';
        whatsappLog.Send_Admin_Flag__c = false;
        whatsappLog.Mobile__c = contact1.MobilePhone;
        whatsappLog.Survey_URL__c = 'https://linksurvey.co.id';
        insert whatsappLog;
        
        list<ID> listWA = new List<ID>();
        //Email_SMS_Log__c idsms = [select id from Email_SMS_Log__c where id = :whatsappLog.Id limit 1];
        listWA.add(whatsappLog.Id);
        JatisWhatsappBatch bb = new JatisWhatsappBatch(listWA);
        Database.executeBatch(bb, 10);
        
        //Email_SMS_Log__c logAfterSend = [select id, Status__c from Email_SMS_Log__c where id = :whatsappLog.Id limit 1];
        //Assert.areEqual('Send', logAfterSend.Status__c);
        Test.stopTest();
    }
}