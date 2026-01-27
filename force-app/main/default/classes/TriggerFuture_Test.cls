@isTest (seeAllData=true)
private class TriggerFuture_Test{
    static testMethod void myTest(){
        
        Test.startTest();
        
        Case cs = [SELECT id, ParentId FROM Case WHERE ParentId != NULL Limit 1];
        TriggerFuture.UpdateParentCase(cs.id, cs.ParentId);

        Agent_Scheduling__c ags = new Agent_Scheduling__c();
        insert ags;
        
        triggerFuture.AgentScheduling(ags.id);
        
        Call_List__c cl = new Call_List__c();
        cl.Entity__c = 'ALI';
        cl.Activity__c = 'Confirmation';
        cl.Case_Type_Config__c = 'Welcome Call';
        cl.Expired_Date__c = date.today() + 1;
        insert cl;

        Call_Line__c cl2 = new Call_Line__c();
        cl2.Call_List__c = cl.id;
        cl2.Agent__c = cl.Ownerid;
        insert cl2;
        
        Call_Line__c cl3 = new Call_Line__c();
        cl3.Call_List__c = cl.id;
        cl3.Parent_Call_Line__c = cl2.id;
        insert cl3;

        triggerFuture.CallLineUpdateChild(cl3.Call_List__c);

        Score_Card__c sc = [SELECT id, Agent__c, Status__c FROM Score_Card__c where Agent__c != NULL LIMIT 1];
        triggerfuture.ShareScoreCard(sc.id, sc.Agent__c, sc.Agent__c, 'Edit');

        Agent_Performance__c ap = [SELECT id, Agent__c, Status__c FROM Agent_Performance__c where Agent__c != NULL LIMIT 1];
        triggerfuture.ShareAgentPerformance(ap.id, ap.Agent__c, ap.Agent__c, 'Edit');

        Quality_Control__c qc = [SELECT id, Agent__c, Status__c FROM Quality_Control__c where Agent__c != NULL LIMIT 1];
        triggerfuture.ShareQualityControl(qc.id, qc.Agent__c, qc.Agent__c, 'Edit');

        Agent_KPI__c ak = [SELECT id, Agent__c, Status__c FROM Agent_KPI__c where Agent__c != NULL LIMIT 1];
        triggerfuture.ShareAgentKPI(ak.id, ak.Agent__c, ak.Agent__c, 'Edit');
        
        Test.stopTest();
        
    }
}