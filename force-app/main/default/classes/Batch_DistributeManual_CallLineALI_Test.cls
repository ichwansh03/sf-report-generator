@isTest
public class Batch_DistributeManual_CallLineALI_Test {
    public static testMethod void myTest() {
        Id rtype = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Conservation').getRecordTypeId();
        
        Profile spvProfileALI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%ALI' limit 1];
        Profile agentProfileALI = [SELECT Id FROM Profile WHERE Name like 'Outbound Agent %ALI' or name like 'Inbound Agent %ALI' limit 1]; 
        
        User us = new User(Alias = 'spv1', Email='spvALI@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='spvALITEST', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = spvProfileALI.Id, Entity__c = 'ALI', 
      			TimeZoneSidKey='Asia/Jakarta', UserName='spvALITEST@axa.co.id');
        insert us;
        
        User agent = new User(Alias = 'agent1', Email='agentALITEST@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentALISTEST', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileALI.Id, managerId = us.id, Entity__c = 'ALI',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentALITEST@axa.co.id', isActive = true, Agent__c = true,
                Outbound_Activity_Case_type__c = 'Collection');
        insert agent;
        
        User_Detail__c ud = new User_Detail__c();
        ud.Name = 'TEST';
        ud.User__c = agent.id;
        ud.Outbound_Activity_Case_type__c = 'Collection - Lapse Konven';
        insert ud;
        
        Call_List__c cl = new Call_List__c();
        cl.RecordTypeId = rtype;
        cl.Activity__c = 'Conservation';
        cl.Case_Type__c = 'Premium FU';
        cl.Expired_Date__c = system.today() + 30;
        cl.Entity__c = 'ALI';
        cl.Campaign_Name__c = 'ALI - Premium FU Test';
        insert cl;
        
        Call_Line__c cLine = new Call_Line__c();
        cLine.Call_List__c = cl.id;
        cLine.ownerid = us.id;
        cLine.Activity__c = 'Conservation';
        cLine.Policy_No__c = 'ALI001';
        cLine.Agent__c  = agent.Id;
        cLine.Call_Remarks__c = 'OK';
        cLine.Entity__c = 'ALI';
        cLine.APE__c = 1000;
        cLine.Currency__c = 'IDR';
        insert cLine;
        
        Agent_Distribution_History__c adhx = new Agent_Distribution_History__c();
        adhx.Campaign__c = cl.id;
        adhx.User_Detail__c = ud.id;
        insert adhx;
        
        List<Agent_Distribution_History__c> finalListAdh = new list <Agent_Distribution_History__c>();
        finalListAdh.add(adhx);
        
        map <Id,Agent_Distribution_History__c> mapAgentHistory = new map <Id,Agent_Distribution_History__c>();
            for (Agent_Distribution_History__c adh : finalListAdh){
                if (adh.User_Detail__c != NULL)
                    mapAgentHistory.put(adh.User_Detail__r.User__c, adh);
                }
        
        Map<Id,Decimal> mapAA = new Map<Id,Decimal>();
        mapAA.put(us.id, 1000000);    
        
        List<Call_Line__c> callLineList = new list <Call_Line__c>();
        callLineList.add(cLine);
        
        String choosen_campaign = cl.Id;
        Map<integer, string> agentOrderMap = new Map<integer,string>();
        agentOrderMap.put(1,agent.id);
        
        Map<Id, string> setAgentMap = new Map<Id, string>();
        integer k = 1;
        for(Call_Line__c cl2 : callLineList){
            setAgentMap.put(cl2.Id, agentOrderMap.get(1));
        }
        
        Batch_DistributeManual_CallLineALI bb = new Batch_DistributeManual_CallLineALI(callLineList,setAgentMap);
		Database.executeBatch(bb,100);
    }
}