@isTest
public class UserOutboundTypeControllerALI_Test {
    static testMethod void testCase1(){
        User_Detail__c userDetail = new User_Detail__c(Name = 'Test User', Outbound_Activity_Case_type__c = 'Confirmation - Welcome Call');
        insert userDetail;
        List<User_Detail__c> uDetail = [Select Id, Outbound_Activity_Case_type__c from User_Detail__c where Id =: userDetail.Id];
        System.assertEquals(true,uDetail.size()>0);
        UserOutboundTypeControllerALI obj01 = new UserOutboundTypeControllerALI();
        obj01.UserList = uDetail;
        obj01.save();
    }
}