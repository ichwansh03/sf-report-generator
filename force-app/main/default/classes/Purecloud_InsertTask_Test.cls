@isTest
public class Purecloud_InsertTask_Test {
    static testMethod void myTest (){
        
        task tk = new task();
        tk.Subject = 'Test';
        tk.CallObject = '01f38141-d85b-4e43-a04a-8f87a4712011';
        tk.Purecloud_Participant_ID__c = '7c029ac9-72e3-4a40-9405-82fcaf7c4740';
        insert tk;
        
        String conversationId = tk.CallObject;
        String TaskId = tk.id;
        // added by Ranti at 01/31/2022
    	Boolean isTransfer = false;
        String ParticipantId = tk.Purecloud_Participant_ID__c;
        
        Purecloud_Connector__c pc = new Purecloud_Connector__c();
        pc.name = 'Purecloud Token';
        pc.Access_Token__c = '123123123123';
        insert pc;
        
        User u = new User(
             ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
             LastName = 'last',
             Email = 'puser000@amamama.com',
             Username = 'puser000@amamama.com',
             CompanyName = 'TEST',
             Title = 'title',
             Alias = 'alias',
             TimeZoneSidKey = 'America/Los_Angeles',
             EmailEncodingKey = 'UTF-8',
             LanguageLocaleKey = 'en_US',
             LocaleSidKey = 'en_US',
             isActive = True,
             Softphone_Type__c = 'Purecloud'
        );
        
        Purecloud_Connector__c presence = new Purecloud_Connector__c();
        presence.name = 'AUX';
        presence.Presence_ID__c = '6a3af858-942f-489d-9700-5f9bcdcdae9b';
        presence.AUX_Name__c = 'Available';
        insert presence;
        
        Purecloud__c agent = new Purecloud__c();
        agent.name = 'Arief_2018-11-02';
        agent.External_ID__c = 'f81eb6e2-5f0b-4d17-86f4-f572f58aaa4d_2018-11-2';
        insert agent;
        
        Purecloud_Master_Queue__c queue = new Purecloud_Master_Queue__c();
        queue.Name = 'QUEUE TEST';
        queue.Queue_ID__c = 'f7866f57-3522-487e-9a62-7889cd68f782';
        queue.Entity__c = 'AFI';
        queue.Languange__c = 'English';
        queue.Skill__c = 'Telemarketing';
        queue.Type__c = 'Inbound';
        insert queue;
        
        Purecloud_Master_Queue__c queue2 = new Purecloud_Master_Queue__c();
        queue2.Name = 'QUEUE TEST';
        queue2.Queue_ID__c = 'f7866f57-3522-487e-9a62-7889cd68f782';
        queue2.Entity__c = 'AFI';
        queue2.Languange__c = 'English';
        queue2.Skill__c = 'Telemarketing';
        queue2.Type__c = 'Callback';
        insert queue2;
        
        StaticResourceCalloutMock mock3 = new StaticResourceCalloutMock();
        mock3.setStaticResource('ResBody_Task');
        mock3.setStatusCode(200);
        mock3.setHeader('Content-Type', 'application/json');
        
       	Test.setMock(HttpCalloutMock.class, mock3);
       
        Test.startTest();
        Purecloud_InsertTask.getTest(conversationId, taskId, participantId,tk.ownerId, tk.Whatid, tk.Subject);
        Test.stopTest();  
        
    }
    
    
    static testMethod void callLineTest (){
        	String rtCustSegCampaign = Schema.SObjectType.Call_list__c.getRecordTypeInfosByName().get('Customer Segmentation AMFS').getRecordTypeId();
 
            Contact con1 = new Contact();
            con1.FirstName = 'Testing';
            con1.LastName = '123';
            con1.Policy_No__c = '511-7298157';
            con1.MobilePhone = '081122334455';
            con1.Entity__c = 'AMFS';
            insert con1;
        
            
            Call_List__c cl = new Call_List__c();
            cl.Campaign_Name__c ='Customer Segmentation';
            cl.Entity__c ='AMFS';
            cl.Activity__c ='Customer Segmentation';
            cl.Case_Type__c ='Update Data';
            cl.IsExpired__c = false;
            cl.Expired_Date__c = Date.newInstance(2028, 5, 23);
            cl.RecordTypeId = rtCustSegCampaign;
            insert cl;
        
        Call_Line__c call_liner = new Call_Line__c();
        call_liner.Contact__c = con1.id;
        call_liner.Policy_No__c = con1.Policy_No__c;
        call_liner.Contacted_Number__c = con1.MobilePhone;
        call_liner.Home_Phone__c = con1.HomePhone;
        call_liner.Phone__c = con1.Phone;
        call_liner.Entity__c = con1.Entity__c;
        call_liner.Call_List__c = cl.Id;
        call_liner.Activity__c = cl.Activity__c;
        call_liner.Case_Type__c = cl.Case_Type__c; 
        call_liner.Case_Type_Config__c = cl.Case_Type_Config__c;
        
        insert call_liner;
        
        task tk = new task();
        tk.whatId = call_liner.id;
        tk.Subject = 'Test';
        tk.CallObject = '01f38141-d85b-4e43-a04a-8f87a4712011';
        tk.Purecloud_Participant_ID__c = '7c029ac9-72e3-4a40-9405-82fcaf7c4740';
        insert tk;
        
        String conversationId = tk.CallObject;
        String TaskId = tk.id;
        // added by Ranti at 01/31/2022
    	Boolean isTransfer = false;
        String ParticipantId = tk.Purecloud_Participant_ID__c;
        
        Purecloud_Connector__c pc = new Purecloud_Connector__c();
        pc.name = 'Purecloud Token';
        pc.Access_Token__c = '123123123123';
        insert pc;
        
        User u = new User(
             ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
             LastName = 'last',
             Email = 'puser000@amamama.com',
             Username = 'puser000@amamama.com',
             CompanyName = 'TEST',
             Title = 'title',
             Alias = 'alias',
             TimeZoneSidKey = 'America/Los_Angeles',
             EmailEncodingKey = 'UTF-8',
             LanguageLocaleKey = 'en_US',
             LocaleSidKey = 'en_US',
             isActive = True,
             Softphone_Type__c = 'Purecloud'
        );
        
        Purecloud_Connector__c presence = new Purecloud_Connector__c();
        presence.name = 'AUX';
        presence.Presence_ID__c = '6a3af858-942f-489d-9700-5f9bcdcdae9b';
        presence.AUX_Name__c = 'Available';
        insert presence;
        
        Purecloud__c agent = new Purecloud__c();
        agent.name = 'Arief_2018-11-02';
        agent.External_ID__c = 'f81eb6e2-5f0b-4d17-86f4-f572f58aaa4d_2018-11-2';
        insert agent;
        
        Purecloud_Master_Queue__c queue = new Purecloud_Master_Queue__c();
        queue.Name = 'QUEUE TEST';
        queue.Queue_ID__c = 'f7866f57-3522-487e-9a62-7889cd68f782';
        queue.Entity__c = 'AFI';
        queue.Languange__c = 'English';
        queue.Skill__c = 'Telemarketing';
        queue.Type__c = 'Inbound';
        insert queue;
        
        Purecloud_Master_Queue__c queue2 = new Purecloud_Master_Queue__c();
        queue2.Name = 'QUEUE TEST';
        queue2.Queue_ID__c = 'f7866f57-3522-487e-9a62-7889cd68f782';
        queue2.Entity__c = 'AFI';
        queue2.Languange__c = 'English';
        queue2.Skill__c = 'Telemarketing';
        queue2.Type__c = 'Callback';
        insert queue2;
        
        StaticResourceCalloutMock mock3 = new StaticResourceCalloutMock();
        mock3.setStaticResource('ResBody_Task');
        mock3.setStatusCode(200);
        mock3.setHeader('Content-Type', 'application/json');
        
       	Test.setMock(HttpCalloutMock.class, mock3);
       
        Test.startTest();
        Purecloud_InsertTask.getTest(conversationId, taskId, participantId,tk.ownerId, tk.Whatid, tk.Subject);
        Test.stopTest();  
        
    }
}