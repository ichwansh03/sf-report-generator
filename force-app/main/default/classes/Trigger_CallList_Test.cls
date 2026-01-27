@isTest (seeAllData=true)
private class Trigger_CallList_Test{
    static testMethod void myTest(){
        
        Test.startTest();
        id currentUser = UserInfo.GetUserID();
        User us = [SELECT id, Entity__c FROM User WHERE id =: CurrentUser];
        
        Call_List__c cl = new Call_List__c();
        cl.Entity__c = us.Entity__c;
        cl.Activity__c = 'Confirmation';
        cl.Case_Type_Config__c = 'Welcome Call';
        cl.Expired_Date__c = date.today() + 1;
        insert cl;
        
        Call_Line__c cl2 = new Call_Line__c();
        cl2.Call_List__c = cl.id;
        cl2.Entity__c = us.Entity__c;
        insert cl2;
        
        cl.Update_Agent_Child__c = TRUE;
        update cl;
        
        cl.refresh_Parent__c = TRUE;
        update cl;
        
        cl2.Date_Reschedule__c = date.today() + 2;
        update cl2;
        
        cl2.Activity_Result__c = 'DONE';
        cl2.Update_Child__c = TRUE;
        update cl2;

        cl.delete_Call_Line__c = TRUE;
        update cl;

        Test.stopTest();
        
    }
}