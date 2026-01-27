trigger Trigger_CallList on Call_List__c (Before Update) {
    for(Call_List__c x:trigger.new){
        // Delete Data
        if(system.isFuture()==false && x.delete_Call_Line__c){
            x.delete_Call_Line__c = FALSE;
            List<Call_Line__c> cl = [SELECT id FROM Call_Line__c WHERE Call_List__c =: x.id];
            if (cl.size() > 0) delete cl;
        }
        if(system.isFuture()==false && x.refresh_Parent__c){
            x.refresh_Parent__c = FALSE;
            CallLineGroupByALI.CallLine(x.id, x.entity__c);
        }

        if(system.isFuture()==false && x.Update_Agent_Child__c){
            x.Update_Agent_Child__c = FALSE;
            TriggerFuture.CallLineUpdateChild(x.id);
        }
                
    }
}