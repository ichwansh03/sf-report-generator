trigger QC_Initial on Quality_Control__c (after update) {
    for(Quality_Control__c qc : Trigger.new) {
        if(qc.Status__c == 'Active' || qc.Status__c == 'Approved' || qc.Status__c == 'Published') {
            TriggerFuture.ShareQualityControl(qc.id, qc.Agent__c, qc.Agent__c, 'Edit');
        } else {
            List<Quality_Control__Share> aksList = [SELECT Id FROM Quality_Control__Share WHERE ParentId = :qc.Id AND UserOrGroupId = :qc.Agent__c];
            if(aksList.size() > 0 && !Test.isRunningTest()) delete aksList;
        }
    }  
}