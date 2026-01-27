@isTest
public class Call_Line_AMFS_Collection_Test {
    Public static testMethod void myTest(){
        
        Id rtype = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
        
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
        
        System.runas(us) {
        	Call_Line_AMFS_Collection obj01 = new Call_Line_AMFS_Collection();
            obj01.filcampname = cl.Id;
            obj01.campaignName = 'Lapse Konven';
            obj01.getCampaignlist();
            obj01.getCallStatus();
            obj01.getListCall();            
            obj01.getStatusRetry();
            obj01.getStatus_Polis();
            obj01.UpdateCallLine();
            obj01.beginning();
            obj01.fetch();
            obj01.previous();
            obj01.getnxt();
            obj01.getprev();
            obj01.getBlock_Size();            
            //string check1 = obj01.infoPendingan;
            string check2 = obj01.campName;
            
            //obj01.end();
            
            obj01.idparam = 'test data';
            obj01.index = 10;
            obj01.blockSize = 10;
            obj01.totalRecs = 10;
            obj01.filcampname = 'test data';
            obj01.filcallstatus = 'test data';
            obj01.pro = new Profile();
            obj01.SOQL = 'test data';
            obj01.sortDir = 'test data';
            obj01.sortField = 'test data';
            obj01.fetchCalled = false;
            obj01.toggleSort();
            obj01.getOffering_pick();
            obj01.getStatus_Polis(); 
        }
  }
}