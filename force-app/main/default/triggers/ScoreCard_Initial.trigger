trigger ScoreCard_Initial on Score_Card__c (After Update) {
    for (Score_Card__c sc : trigger.new) {
        if (sc.Status__c == 'Approved' || sc.Status__c == 'Published')
            triggerfuture.ShareScoreCard(sc.id, sc.Agent__c, sc.Agent__c, 'Edit');
        else {
            list <Score_Card__Share> acs = [SELECT id FROM Score_Card__Share WHERE ParentId =: sc.id and UserOrGroupId =: sc.Agent__c];
            if (acs.size() > 0 && !Test.isRunningTest()) delete acs;
        }
    }
}