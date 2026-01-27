@isTest(seealldata=true)
private class BatchUpdateNoTelpTelUW_Test {
    static testmethod void test() {
        Test.startTest();
        System.debug('>>>> MASUK TEST <<<<');
        Test.setMock(HttpCalloutMock.class, new EIPConnectorMock());
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest20';
        ac1.Entity__c = entity;
        insert ac1;
        
        String polis='520-6350141';
        
        List<Contact> contList = [select Policy_No__c,PolicyApp__c,MobilePhone,Campaign_Type__c from Contact where policy_no__c = :polis limit 1];
        Contact cont = contList[0];

        cont.AccountId = ac1.Id;
        cont.PolicyApp__c='RLS';
        cont.MobilePhone='082119787243';
        update cont;
        
        List<String> listPolicyNumber = new List<String>();
        listPolicyNumber.add(cont.Policy_No__c);
        
        BatchUpdateNoTelpTelUW runner = new BatchUpdateNoTelpTelUW(listPolicyNumber);
        Database.executeBatch(runner, 10);
        
        //Email_SMS_Log__c logAfterSend = [select id, Status__c from Email_SMS_Log__c where id = :whatsappLog.Id limit 1];
        //Assert.areEqual('Send', logAfterSend.Status__c);
        Test.stopTest();
    }
}