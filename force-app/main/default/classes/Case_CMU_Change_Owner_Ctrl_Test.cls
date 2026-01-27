@isTest
public class Case_CMU_Change_Owner_Ctrl_Test {
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

        System.runas(us) {
    
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
                
        	Case_CMU_Change_Owner_Ctrl obj01 = new Case_CMU_Change_Owner_Ctrl();
            obj01.getNamedUserAlllist();            
            obj01.getNamedUserlist();
            obj01.populateFreshData();
            obj01.save();
            obj01.totalData = 1;
            obj01.totalGAP = 1;
            obj01.totalAgents = 1;
            obj01.choosen_campaign = 'test';
            obj01.choosen_user = 'test';
            obj01.choosen_method = 'test';
            obj01.CollectionTaskArr = 'test';
            list<string> temp = new list<String>();
            obj01.invalidPolicyList = temp;
            obj01.invalidPolicyTempList = temp;
            obj01.agentList = new List<User_Detail__c>();
            obj01.agentIDList = new List<Id>();
            obj01.agentOptList = new List<SelectOption>();
            obj01.distributeOptionList = new List<SelectOption>();
            obj01.list_policyNo = temp;
            obj01.map_campaignObj = new Map<Id, Call_List__c>();
            obj01.mapContactList = new Map<string,Contact>();
            obj01.agentMap = new Map<string,string>();
            obj01.map_callLine = new Map<String, Case>();

            obj01.Total_APE = 0;
            obj01.String_APE = 'Test';
            obj01.campaignTarget = 0;
            obj01.agentListView = new List<User_Detail__c>();
            obj01.finalListAdh = new List<Agent_Distribution_History__c>();
            obj01.mapAgentHistory = new map<Id,Agent_Distribution_History__c>();
            
            integer testdata = 0;
            //obj01.tempCase();
        }
  }
}