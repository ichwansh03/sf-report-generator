@isTest
public class ContactTrigger_Test {
    @testSetup static void setup(){
        id currentUser = UserInfo.GetUserID();
        User us = [SELECT id, Entity__c FROM User WHERE id =: CurrentUser];
        
        // campain wecall
        Call_List__c campaign = new Call_List__c();
        campaign.Entity__c = us.Entity__c;
        campaign.Activity__c = 'Confirmation';
        campaign.Case_Type_Config__c = 'Welcome Call';
        campaign.Expired_Date__c = date.today() + 1;
        insert campaign;
        
        // campaing teluw
        Call_List__c campaign2 = new Call_List__c();
        campaign2.Entity__c = us.Entity__c;
        campaign2.Activity__c = 'Confirmation';
        campaign2.Case_Type_Config__c = 'TelUW';
        campaign2.Expired_Date__c = date.today() + 1;
        insert campaign2;
        
        // data for open wecall test
        Contact c = new Contact();
        c.FirstName = 'Contact';
        c.LastName = '20220215';
        c.Policy_No__c = '510-20230215';
        c.MobilePhone = '085185105108';
        c.entity__c = us.Entity__c;
        insert c;
        
        Call_Line__c cl = new Call_Line__c();
        cl.Call_List__c = campaign.id;
        cl.Contact__c = c.Id;
        cl.Entity__c = us.Entity__c;
        cl.Policy_No__c = '510-20230215';
        cl.Contacted_Number__c = '085185105108';
        cl.welcomecall_call_line_status__c = 'Open';
        insert cl;
        
        // data for closed we call
        Contact c2 = new Contact();
        c2.FirstName = 'Contact';
        c2.LastName = '20220221';
        c2.Policy_No__c = '510-20230221';
        c2.MobilePhone = '085185105109';
        c2.entity__c = us.Entity__c;
        insert c2;
        
        Call_Line__c cl2 = new Call_Line__c();
        cl2.Call_List__c = campaign.id;
        cl2.Contact__c = c2.Id;
        cl2.Entity__c = us.Entity__c;
        cl2.Policy_No__c = '510-20230221';
        cl2.Contacted_Number__c = '085185105109';
        cl2.welcomecall_call_line_status__c = 'Closed';
        insert cl2;
        
        // data for open teluw
        Contact c3 = new Contact();
        c3.FirstName = 'Contact';
        c3.LastName = '20220216';
        c3.Policy_No__c = '510-20230216';
        c3.MobilePhone = '085185105110';
        c3.entity__c = us.Entity__c;
        insert c3;
        
        Call_Line__c cl3 = new Call_Line__c();
        cl3.Call_List__c = campaign2.id;
        cl3.Contact__c = c3.Id;
        cl3.Entity__c = us.Entity__c;
        cl3.Policy_No__c = '510-20230216';
        cl3.Contacted_Number__c = '085185105110';
        cl3.welcomecall_call_line_status__c = 'Open';
        cl3.Call_Line_Status_TelUW__c = 'Open';
        insert cl3;
        
        // data for closed teluw
        Contact c4 = new Contact();
        c4.FirstName = 'Contact';
        c4.LastName = '20220222';
        c4.Policy_No__c = '510-20230222';
        c4.MobilePhone = '085185105111';
        c4.entity__c = us.Entity__c;
        insert c4;
        
        Call_Line__c cl4 = new Call_Line__c();
        cl4.Call_List__c = campaign2.id;
        cl4.Contact__c = c4.Id;
        cl4.Entity__c = us.Entity__c;
        cl4.Policy_No__c = '510-20230222';
        cl4.Contacted_Number__c = '085185105111';
        cl4.welcomecall_call_line_status__c = 'Open';
        cl4.Call_Line_Status_TelUW__c = 'Closed';
        insert cl4;
    }
    
    static testMethod void afterUpdateOpenWeCallTest(){
        Test.startTest();
        String polis = '510-20230215';
        List<Contact> contList = [select id, policy_no__c, mobilephone from Contact where policy_no__c = :polis limit 1];
        Contact cont = contList[0];
        List<Call_Line__c> clListBeforeUpdate = [select id, policy_no__c, contacted_number__c from Call_Line__c where policy_no__c = :polis limit 1];
        Call_Line__c callLineBeforeUpdate = clListBeforeUpdate[0];
        
        assert.areEqual(callLineBeforeUpdate.Contacted_Number__c, cont.MobilePhone);
        
        // update mobile phone on contact;
        cont.MobilePhone = '085285205999';
        update cont;
        
        //get call line afte update contact
        List<Call_Line__c> clListAfterUpdate = [select id, policy_no__c, contacted_number__c from Call_Line__c where policy_no__c = :polis limit 1];
        Call_Line__c callLineAfterUpdate = clListAfterUpdate[0];
        
        assert.areEqual(callLineAfterUpdate.Contacted_Number__c, cont.MobilePhone);
        Test.stopTest();
    }
    
    static testMethod void afterUpdateClosedWeCallTest(){
        Test.startTest();
        String polis = '510-20230221';
        List<Contact> contList = [select id, policy_no__c, mobilephone from Contact where policy_no__c = :polis limit 1];
        Contact cont = contList[0];
        List<Call_Line__c> clListBeforeUpdate = [select id, policy_no__c, contacted_number__c, lastmodifieddate from Call_Line__c where policy_no__c = :polis limit 1];
        Call_Line__c callLineBeforeUpdate = clListBeforeUpdate[0];
        
        assert.areEqual(callLineBeforeUpdate.Contacted_Number__c, cont.MobilePhone);
        
        // update mobile phone on contact;
        cont.MobilePhone = '085285209999';
        update cont;
        
        //get call line afte update contact
        List<Call_Line__c> clListAfterUpdate = [select id, policy_no__c, contacted_number__c, lastmodifieddate from Call_Line__c where policy_no__c = :polis limit 1];
        Call_Line__c callLineAfterUpdate = clListAfterUpdate[0];
        
        assert.areNotEqual(callLineAfterUpdate.Contacted_Number__c, cont.MobilePhone);
        assert.areEqual(callLineAfterUpdate.Contacted_Number__c, callLineBeforeUpdate.Contacted_Number__c);
        assert.areEqual(callLineAfterUpdate.LastModifiedDate, callLineBeforeUpdate.LastModifiedDate);
        Test.stopTest();
    }
    
    static testMethod void afterUpdateOpenTelUWTest(){
        Test.startTest();
        String polis = '510-20230216';
        List<Contact> contList = [select id, policy_no__c, mobilephone from Contact where policy_no__c = :polis limit 1];
        Contact cont = contList[0];
        List<Call_Line__c> clListBeforeUpdate = [select id, policy_no__c, contacted_number__c from Call_Line__c where policy_no__c = :polis limit 1];
        Call_Line__c callLineBeforeUpdate = clListBeforeUpdate[0];
        
        assert.areEqual(callLineBeforeUpdate.Contacted_Number__c, cont.MobilePhone);
        
        // update mobile phone on contact;
        cont.MobilePhone = '085285209999';
        update cont;
        
        //get call line afte update contact
        List<Call_Line__c> clListAfterUpdate = [select id, policy_no__c, contacted_number__c from Call_Line__c where policy_no__c = :polis limit 1];
        Call_Line__c callLineAfterUpdate = clListAfterUpdate[0];
        
        assert.areEqual(callLineAfterUpdate.Contacted_Number__c, cont.MobilePhone);
        Test.stopTest();
    }
    
    static testMethod void afterUpdateClosedTelUWTest(){
        Test.startTest();
        String polis = '510-20230222';
        List<Contact> contList = [select id, policy_no__c, mobilephone from Contact where policy_no__c = :polis limit 1];
        Contact cont = contList[0];
        List<Call_Line__c> clListBeforeUpdate = [select id, policy_no__c, contacted_number__c, lastmodifieddate from Call_Line__c where policy_no__c = :polis limit 1];
        Call_Line__c callLineBeforeUpdate = clListBeforeUpdate[0];
        
        assert.areEqual(callLineBeforeUpdate.Contacted_Number__c, cont.MobilePhone);
        
        // update mobile phone on contact;
        cont.MobilePhone = '085285209999';
        update cont;
        
        //get call line afte update contact
        List<Call_Line__c> clListAfterUpdate = [select id, policy_no__c, contacted_number__c, lastmodifieddate from Call_Line__c where policy_no__c = :polis limit 1];
        Call_Line__c callLineAfterUpdate = clListAfterUpdate[0];
        
        assert.areNotEqual(callLineAfterUpdate.Contacted_Number__c, cont.MobilePhone);
        assert.areEqual(callLineAfterUpdate.Contacted_Number__c, callLineBeforeUpdate.Contacted_Number__c);
        assert.areEqual(callLineAfterUpdate.LastModifiedDate, callLineBeforeUpdate.LastModifiedDate);
        Test.stopTest();
    }
    
    static testMethod void afterUpdateContactBulking(){
        Test.startTest();
        Set<String> polis = new Set<String>(); 
        polis.add('510-20230215'); 
        polis.add('510-20230221'); 
        polis.add('510-20230216');
        polis.add('510-20230222');
            
        List<Contact> contList = [select id, policy_no__c, mobilephone from Contact where policy_no__c in :polis];
        List<Contact> contListTbu = new List<Contact>();
        List<Call_Line__c> clListBeforeUpdate = [select id, policy_no__c, contacted_number__c, lastmodifieddate, campaign_type__c, WelcomeCall_Call_Line_Status__c, Call_Line_Status_TelUW__c from Call_Line__c where policy_no__c in :polis];
        
        for (Contact c : contList) {
            for (Call_Line__c cl : clListBeforeUpdate) {
                if (cl.Policy_No__c == c.Policy_No__c) {
                    assert.areEqual(cl.Contacted_Number__c, c.MobilePhone);
                }
            }
            c.MobilePhone = '99999999999';
            contListTbu.add(c);
        }
        
        update contListTbu;
        
        List<Call_Line__c> clListAfterUpdate = [select id, policy_no__c, contacted_number__c, lastmodifieddate, campaign_type__c, WelcomeCall_Call_Line_Status__c, Call_Line_Status_TelUW__c from Call_Line__c where policy_no__c in :polis];
        
        for (Contact c : contList) {
            for (Call_Line__c cl : clListAfterUpdate) {
                if (cl.Policy_No__c == c.Policy_No__c) {
                    if ((cl.Campaign_Type__c).contains('Welcome Call')) {
                        if (cl.WelcomeCall_Call_Line_Status__c != null && cl.WelcomeCall_Call_Line_Status__c != 'Closed') {
                        	assert.areEqual(cl.Contacted_Number__c, c.MobilePhone);   
                        } else {
                        	assert.areNotEqual(cl.Contacted_Number__c, c.MobilePhone); 
                        }
                    } else {
                        if (cl.Call_Line_Status_TelUW__c != null && cl.Call_Line_Status_TelUW__c != 'Closed') {
                        	assert.areEqual(cl.Contacted_Number__c, c.MobilePhone);   
                        } else {
                        	assert.areNotEqual(cl.Contacted_Number__c, c.MobilePhone); 
                        }
                    }
                }
            }
        }
    }
        
}