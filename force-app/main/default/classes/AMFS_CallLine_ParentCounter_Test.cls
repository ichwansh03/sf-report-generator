@isTest
public class AMFS_CallLine_ParentCounter_Test {
    public static testMethod void myTest() {
        Id rtype = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
        Id usdRtype = Schema.SObjectType.User_Detail__c.getRecordTypeInfosByName().get('User Detail Collection AMFS').getRecordTypeId();
        
        Profile spvProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AMFS' limit 1];
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Outbound Agent %AMFS' or name like 'Inbound Agent %AMFS' limit 1]; 
        
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
        
        User_Detail__c ud = new User_Detail__c();
        ud.Name = 'TEST';
        ud.User__c = agent.id;
        ud.Outbound_Activity_Case_type__c = 'Collection - Lapse Konven';
        insert ud;
        
        System.runAs(us){
        	Call_List__c cl = new Call_List__c();
            cl.RecordTypeId = rtype;
            cl.Activity__c = 'Collection';
            cl.Case_Type__c = 'Lapse Konven';
            cl.Expired_Date__c = system.today() + 30;
            cl.Entity__c = 'AMFS';
            cl.Campaign_Name__c = 'Lapse Konven';
            insert cl;
            
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
            insert cLine;
            
            Call_Line__c cLine2 = new Call_Line__c();
            cLine2.Call_List__c = cl.id;
            cLine2.ownerid = us.id;
            cLine2.Activity__c = 'Collection';
            cLine2.Policy_No__c = 'AMFS001';
            cLine2.Agent__c  = agent.Id;
            cLine2.Call_Remarks__c = 'OK';
            cLine2.Entity__c = 'AMFS';
            cLine2.APE__c = 1000;
            cLine2.Currency__c = 'IDR';
            cLine2.Parent_Call_Line__c = cLine.Id;
            insert cLine2;
            
            Test.startTest();
            //AMFS_CallLine_ParentCounter.countParent(cl.Id, us.Id);
            Test.stopTest();
        }
    }
}