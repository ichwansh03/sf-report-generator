@isTest (SeeAllData = true)
public class insertToActivityResult_Test {
    public static testMethod void myTest() {
        Id rtype = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
        Id rtypeCl = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Collection AMFS 2').getRecordTypeId();
        
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
        
        System.runAs(us) {
            
        Call_List__c cl = new Call_List__c();
        cl.RecordTypeId = rtype;
        cl.Activity__c = 'Collection';
        cl.Case_Type__c = 'Renewal Reminder';
        cl.Expired_Date__c = system.today() + 30;
        cl.Entity__c = 'AMFS';
        insert cl;
            
        Call_Line__c cLine = new Call_Line__c();
        cLine.Call_List__c = cl.id;
        cLine.RecordTypeId = rTypeCl;
        cLine.ownerid = us.id;
        cLine.Activity__c = 'Collection';
        cLine.Policy_No__c = 'AMFS001';
        cLine.Agent__c  = agent.Id;
        cLine.Call_Remarks__c = 'OK';
        cLine.Entity__c = 'AMFS';
        cLine.APE__c = 1000;
        cLine.Currency__c = 'IDR';
        insert cLine;
            
        cLine.Status_Retry__c = 'Rescheduled';
        update cLine;
    }
    }
}