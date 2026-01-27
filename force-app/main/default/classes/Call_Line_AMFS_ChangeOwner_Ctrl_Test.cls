@isTest
public class Call_Line_AMFS_ChangeOwner_Ctrl_Test {

    Public static testMethod void myTest() {
        Id rtype = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
        
        Call_List__c cl = new Call_List__c();
        cl.RecordTypeId = rtype;
        cl.Activity__c = 'Collection';
        cl.Case_Type__c = 'Renewal Reminder';
        cl.Expired_Date__c = system.today() + 30;
        cl.Entity__c = 'AMFS';
        insert cl;
        
        Profile spvProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AMFS' limit 1];
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AMFS' OR Name like 'Outbound Agent%AMFS' limit 1]; 
        
        User us = new User(Alias = 'spv1', Email='spvAMFS@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='spvAMFSTEST', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = spvProfileAMFS.Id, Entity__c = 'AMFS', 
      			TimeZoneSidKey='Asia/Jakarta', UserName='spvAMFSTEST@axa.co.id');
        insert us;
        
        User agent = new User(Alias = 'agent1', Email='agentAMFSTEST@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentAMFSTEST', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = us.id, Entity__c = 'AMFS',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentAMFSTEST@axa.co.id', isActive = true, Agent__c = true,
                Outbound_Activity_Case_type__c = 'Collection');
        insert agent;
        
        User_Detail__c usd = new User_Detail__c();
        usd.User__c = agent.id;
        usd.Outbound_Activity_Case_type__c = 'Renewal Reminder';
        insert usd;
        
        Call_Line__c cLine = new Call_Line__c();
        cLine.Call_List__c = cl.id;
        cLine.ownerid = us.id;
        cLine.Activity__c = 'Collection';
        cLine.Policy_No__c = 'AMFS001';
        cLine.Agent__c  = agent.Id;
        cLine.Call_Remarks__c = 'OK';
        cLine.Entity__c = 'AMFS';
        cLine.APE__c = 1000;
        cLine.Currency__c = 'IDR';
        cLine.Call_Status_Config__c = '';
        cLine.Reason_Status_Config__c = '';
        insert cLine;
        
        Call_Line__c cLine1 = new Call_Line__c();
        cLine1.Call_List__c = cl.id;
        cLine1.ownerid = us.id;
        cLine1.Activity__c = 'Collection';
        cLine1.Policy_No__c = 'AMFS001';
        cLine1.Agent__c  = agent.Id;
        cLine1.Call_Remarks__c = 'OK';
        cLine1.Entity__c = 'AMFS';
        cLine1.APE__c = 1000;
        cLine1.Currency__c = 'IDR';
        cLine1.Call_Status_Config__c = 'Contacted';
        cLine1.Reason_Status_Config__c = 'Unit Price Fluctuation';
        insert cLine1;
        
    	Call_Line_AMFS_ChangeOwner_Ctrl ctrl = new Call_Line_AMFS_ChangeOwner_Ctrl(); 
        ctrl.choosen_campaign = cl.id;
        ctrl.choosen_user = us.id;
        ctrl.SortingBy = '';
        ctrl.CallStatusSet = '(none)';
        ctrl.ReasonStatusSet = '(none)';
        ctrl.populateFreshData();
        ctrl.selectedSizeCount();
        ctrl.selectAll();
        ctrl.save();
        
        List<SelectOption> test = ctrl.CallStatusConfig;
        List<SelectOption> test2 = ctrl.ReasonStatusConfig;
        
        ctrl.CallStatusSet = 'Contacted';
        ctrl.ReasonStatusSet = 'Unit Price Fluctuation';
        ctrl.SortingBy = 'ContactNameAsc';
        ctrl.populateFreshData();
        ctrl.SortingBy = 'ContactNameDesc';
        ctrl.populateFreshData();
        ctrl.SortingBy = 'APEAsc';
        ctrl.populateFreshData();
        ctrl.SortingBy = 'APEDesc';
        ctrl.populateFreshData();
        
        cLine.Status_Retry__c = 'Rescheduled';
        update cLine;
        
        Call_Line_AMFS_ChangeOwner_Ctrl.AgentAssignment aas = new Call_Line_AMFS_ChangeOwner_Ctrl.AgentAssignment();
        aas.agentId = 'test';
        aas.agentName = 'test';
        aas.apeDistributed = 1000;
        aas.policyTotal = 5;
        aas.StringAPE_Distributed = 'test';
    }
}