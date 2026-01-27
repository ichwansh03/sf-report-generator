trigger AP_Initial on Agent_Performance__c (After Update) {
    for (Agent_Performance__c ap : trigger.new) {
        if (ap.Status__c == 'Approved')
            triggerfuture.ShareAgentPerformance(ap.id, ap.Agent__c, ap.Agent__c, 'Edit');
        else {
            list <Agent_Performance__Share> acs = [SELECT id FROM Agent_Performance__Share WHERE ParentId =: ap.id and UserOrGroupId =: ap.Agent__c];
            if (acs.size() > 0 && !Test.isRunningTest()) delete acs;
        }
    }
}