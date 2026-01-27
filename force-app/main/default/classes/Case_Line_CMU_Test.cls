@isTest
public class Case_Line_CMU_Test {
    Public static testMethod void myTest(){
        
        Id rtype = Schema.SObjectType.Case.getRecordTypeInfosByName().get('AMFSComplaintCase').getRecordTypeId();
        
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

        Named_User__c nu = new Named_User__c();
        nu.Name = 'Test';
        nu.User__c = UserInfo.getUserId();
        nu.Entity__c = 'AMFS';
        nu.Division__c = 'CMU';
        nu.Status__c = 'Active';
        insert nu;
        
        Case cs = new Case();
        cs.RecordTypeId = rtype;
        cs.Subject = 'New CMU';
        cs.Type = 'Complaint';
        cs.Entity_Backup__c = 'AMFS';
        insert cs;
                
        System.runas(us) {
        	Case_Line_CMU obj01 = new Case_Line_CMU();
            obj01.getListCall();            
            obj01.getStatus_Polis();
            obj01.UpdateCallLine();
            obj01.getNamedUserlist();
            obj01.getRequestStatus();
            obj01.beginning();
            obj01.fetch();
            obj01.previous();
            obj01.getnxt();
            obj01.getprev();
            obj01.next();
            obj01.getBlock_Size();            
            obj01.getOffering_pick();
            //string check1 = obj01.infoPendingan;
            
            obj01.idparam = 'test data';
            obj01.index = 10;
            obj01.blockSize = 10;
            obj01.totalRecs = 10;
            obj01.sortDir = 'test data';
            obj01.sortField = 'test data';
            obj01.fetchCalled = false;
            obj01.toggleSort();
            obj01.getOffering_pick();
            obj01.getStatus_Polis(); 
        }
  }
}