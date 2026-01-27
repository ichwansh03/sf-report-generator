@isTest
public class CreateCampaignRetry_Test {
    
    public static testMethod void CreateCampaignRetryTest(){
        Test.startTest();
        String useruser = UserInfo.getUserId();
        User usr = [Select Id from User Where Id = :useruser];
        usr.Entity__c = 'MAGI';
        Update usr;
        
        //Insert Call_List__c
        List<Call_List__c> campaignList = new List<Call_List__c>();
        Call_List__c clist1 = new Call_List__c();
        clist1.Activity__c = 'Confirmation';
        clist1.Case_Type_Config__c = 'Premium';
        clist1.IsExpired__c = false;
        clist1.Entity__c = 'MAGI';
        clist1.RecordTypeId = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Confirmation MAGI').getRecordTypeId();
        clist1.Expired_Date__c = system.today();
        campaignList.add(clist1);
        insert campaignList;
        
        //Insert Call Line
        Call_Line__c cl = new Call_Line__c();
        cl.Call_Status_Config__c = 'Hold';
        cl.Policy_No__c = '517-8475322';
        cl.Remark_Hold_Debet__c = 'test';
        cl.Call_List__c = clist1.Id;
        cl.APE_Total_Child__c = 1000000;
        cl.Entity__c = 'AMFS';
        cl.Activity__c = 'Collection';
        Insert cl;
                
        List<Call_Line__c> callList = new List<Call_Line__c>();
        Call_Line__c cl1 = new Call_Line__c();
        cl1.Entity__c = 'AMFS';
        cl1.Total_Uncontacted_New__c = 1;
        cl1.Call_List__c = clist1.Id;
        cl1.Call_Status_Config__c = 'Uncontacted';
        cl1.Parent_Call_Line__c = cl.Id;
        cl1.Agent__c = useruser;
        cl1.OwnerId = useruser;
        callList.add(cl1);
        
        Call_Line__c cl2 = new Call_Line__c();
        cl2.Entity__c = 'MAGI';
        cl2.Total_Uncontacted_New__c = 1;
        cl2.Call_List__c = clist1.Id;
        cl2.Call_Status_Config__c = 'Uncontacted';
        callList.add(cl2);
        
        Call_Line__c cl3 = new Call_Line__c();
        cl3.Entity__c = 'AMFS';
        cl3.Total_Uncontacted_New__c = 1;
        cl3.Call_List__c = clist1.Id;
        cl3.Call_Status_Config__c = 'Uncontacted';
        cl3.Parent_Call_Line__c = cl.Id;
        cl3.Agent__c = useruser;
        cl3.OwnerId = useruser;
        cl3.Call_Remarks__c = 'test';
        callList.add(cl3);
        
        insert callList;
                
        cl3.Call_Remarks__c = 'test 2';
        update cl3;
        
        clist1.IsExpired__c = true;
        update clist1;
        
        System.runAs(usr){
            cl1.Call_Status_Config__c = 'Hold';
            update cl1;
        }
        
        Test.stopTest();
    }
}