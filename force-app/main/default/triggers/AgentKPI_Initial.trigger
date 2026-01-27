trigger AgentKPI_Initial on Agent_KPI__c (after update) {
    for(Agent_KPI__c ak : Trigger.new) {
        if(ak.Status__c == 'Active' || ak.Status__c == 'Approved' || ak.Status__c == 'Published') {
            TriggerFuture.ShareAgentKpi(ak.id, ak.Agent__c, ak.Agent__c, 'Edit');
        } else {
            List<Agent_KPI__Share> aksList = [SELECT Id FROM Agent_KPI__Share WHERE ParentId = :ak.Id AND UserOrGroupId = :ak.Agent__c];
            if(aksList.size() > 0 && !Test.isRunningTest()) delete aksList;
        }
    }	
}