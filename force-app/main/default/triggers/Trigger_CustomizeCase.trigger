trigger Trigger_CustomizeCase on Case (after insert, after update) {
    
    List<Case> cases = new List<Case>();
    
    if (trigger.isAfter) {
        
        if (trigger.isInsert) {
            system.debug('Trigger_CustomizeCase INSERT');
            for (Case cs : trigger.new) {
                if (cs.Entity__c == 'AMFS' && cs.Description != null && cs.Description != 'Claim Status: Cashless') cases.add(cs);
            }
        }
        
        if (trigger.isUpdate) {
            //if (CallLineTriggerHelper.firstRun == true || Test.isRunningTest()) {
                //CallLineTriggerHelper.firstRun = false;
                system.debug('Trigger_CustomizeCase UPDATE');
                
                for (Case cs : trigger.new) {
                    
                    Case old = Trigger.oldMap.get(cs.Id);
                    Case newCs = Trigger.newMap.get(cs.id);
                    
                    if (cs.Entity__c == 'AMFS' && newCs.get('Description') != null && (newCs.get('Description') != old.get('Description'))) cases.add(cs);
                    
                }
            //}
            
        }
        
        if (cases != null && cases.size() > 0){            
            Id jobId = System.enqueueJob(new SubmitCaseServiceQueueable(cases));
            system.debug('jobId Trigger_CustomizeCase : '+jobId);
        }
    }
    
}