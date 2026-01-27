@isTest
public class TodoAgent_Test {
    
    static ID rtype = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
    static Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Outbound Agent%AMFS' limit 1];
    static Profile spvProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AMFS' limit 1];
    
    @testSetup
    static void setup(){
        User us = new User(Alias = 'spv1', Email='spvAMFS@axa.co.id', 
                           EmailEncodingKey='UTF-8', LastName='spvAMFSTEST', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = spvProfileAMFS.Id, Entity__c = 'AMFS', 
                           TimeZoneSidKey='Asia/Jakarta', UserName='spvAMFSTEST1@axa.co.id');
        insert us;
        
        User agent = new User(Alias = 'agent1', Email='agentAMFSTEST@axa.co.id', 
                              EmailEncodingKey='UTF-8', LastName='agentAMFSTEST', LanguageLocaleKey='en_US', 
                              LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = us.id, Entity__c = 'AMFS',
                              TimeZoneSidKey='Asia/Jakarta', UserName='agentAMFSTEST1@axa.co.id', isActive = true, Agent__c = true,
                              Outbound_Activity_Case_type__c = 'Collection');
        insert agent;
        
        Call_List__c cl = new Call_List__c();
        cl.RecordTypeId = rtype;
        cl.Activity__c = 'Collection';
        cl.Case_Type__c = 'Redemption TM';
        cl.Expired_Date__c = system.today() + 30;
        cl.Entity__c = 'AMFS';
        cl.Campaign_Name__c = 'Redemption TM';
        insert cl;
        
        Call_Line__c cLine = new Call_Line__c();
        cLine.Call_List__c = cl.id;
        cLine.ownerid = us.id;
        cLine.Call_Status_Config__c = 'Pending';
        cLine.Status_has_call__c = 'Pending';
        cLine.Call_Remarks__c = 'Test';
        cLine.Reason_Status_Config__c = 'Client Did Not Received Renewal Notice';
        cLine.Case_Type__c = 'Redemption TM';
        cLine.Activity__c = 'Collection';
        cLine.Policy_No__c = 'AMFS001';
        cLine.APE_Total_Child__c = 100000;
        cLine.Agent__c  = agent.Id;
        cLine.Call_Remarks__c = 'OK';
        cLine.Entity__c = 'AMFS';
        insert cLine;    
    }
    
    @isTest
    static void todoList_Progress() {
        Test.startTest();
        Map<Object, List<String>> dependValues = DependentPicklistController.getDependentPicklistValues('Call_List__c', 'Todo_List_Config__c');
        Call_Line__c callLine = [SELECT Id, Case_Type__c, Status_has_call__c, Call_Status_Config__c, Reason_Status_Config__c, Call_Remarks__c, Progress__c, Call_List__c, Todo_Item__c, Todo_Item_Status__c, Campaign_Name__c FROM Call_Line__c LIMIT 1];
        PageReference pageRef = Page.Todo_Agent;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('Id', String.valueOf(callLine.Id));
        ApexPages.StandardController sc = new ApexPages.StandardController(callLine);
        TodoAgent todo = new TodoAgent(sc);
        todo.cl = callLine;
        todo.items = dependValues.get('Redemption TM');
        todo.statuses = new List<String>{'true','true','true','false','false','false','false'};
            callLine.Todo_Item__c = String.join(todo.items, ',');
        callLine.Todo_Item_Status__c = String.join(todo.statuses,',');
        
        todo.loadItems();
        todo.save();
        todo.checkTask();
        
        System.assertNotEquals(callLine.Todo_Item__c, null);
        System.assertNotEquals(callLine.Todo_Item_Status__c, null);
        System.assertEquals(todo.items.size(), 8);
        System.assertEquals(todo.statuses[0], 'true');
        Test.stopTest();
    }
    
    @isTest
    static void todoList_Null() {
        Test.startTest();
        Call_Line__c callLine = [SELECT Id, Case_Type__c, Todo_Item__c, Todo_Item_Status__c FROM Call_Line__c LIMIT 1];
        PageReference pageRef = Page.Todo_Agent;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('Id', String.valueOf(callLine.Id));
        ApexPages.StandardController sc = new ApexPages.StandardController(callLine);
        TodoAgent todo = new TodoAgent(sc);
        todo.campaign = [SELECT Id, Case_Type__c, Todo_List_Config__c FROM Call_List__c LIMIT 1];
        Map<Object, List<String>> dependValues = DependentPicklistController.getDependentPicklistValues('Call_List__c', 'Todo_List_Config__c');
        TodoAgent.TodoListWrapper wrapper = new TodoAgent.TodoListWrapper(null, null);
        callLine.Todo_Item__c = null;
        callLine.Todo_Item_Status__c = null;
        todo.loadItems();
        todo.save();
        todo.checkTask();
        Test.stopTest();
        
        System.assertEquals(callLine.Todo_Item__c, null);
        System.assertEquals(callLine.Todo_Item_Status__c, null);
    }
}