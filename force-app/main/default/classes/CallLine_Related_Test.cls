@isTest
private class CallLine_Related_Test {
    @testSetup
    static void setupRecord() {
        Profile p2 = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User u2 = new User(
            LastName='Testing2',
            Alias = 'standt2', 
            Email='standarduser1@axa.com', 
            EmailEncodingKey='UTF-8', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US',
            ProfileId = p2.Id,
            TimeZoneSidKey='America/Los_Angeles',
            Entity__c ='AMFS',
            UserName='standarduser1@axa.com'
        );
        insert u2;
    }
    static testMethod void test_execute_UseCase1(){
        test.startTest();
        id currentUser = UserInfo.GetUserID();
        
        User us = [SELECT Id, Entity__c FROM User WHERE UserName = 'standarduser1@axa.com' LIMIT 1];
        System.runAs(us) {
        Contact con1 = new Contact();
        con1.FirstName = 'Testing';
        con1.LastName = '123';
        con1.Policy_No__c = '511-729815799';
        con1.MobilePhone = '081122334455';
        con1.Entity__c = us.Entity__c;
       	insert con1;
        
        Call_Line__c call_line_Obj2 = new Call_Line__c ();
        call_line_Obj2.Is_Already_Assigned__c = false;
        call_line_Obj2.Is_Calledback_Already__c = false;
        call_line_Obj2.Entity__c = us.Entity__c;
        call_line_Obj2.Contact__c = con1.id;
        Insert call_line_Obj2; 
        call_line_Obj2.Activity_Result__c = 'test';
        Update call_line_Obj2;
        CallLine_Related.UpdateCallLineChild(call_line_Obj2.id);
        
        call_line_Obj2.Activity_Result__c = 'Rescheduled';
        call_line_Obj2.Call_Remarks__c = 'test reschedule';
        Update call_line_Obj2;
        }
        test.stopTest();
    }
}