trigger CaseTypeUpdateOnCallLine on Call_Line__c (after insert, before update) {
    Set<Id> callLineIds = new Set<Id>();
    if(!CallLineTriggerControl.skipCaseTypeUpdate){
        if (trigger.new[0].Entity__c != 'ALI' || trigger.isUpdate) {
            for(Call_Line__c cl : Trigger.new) {
                if(cl.Id != null) {
                    callLineIds.add(cl.Id);
                }
            }
        
            Map<Id, Call_Line__c> myCallLine = new Map<Id, Call_Line__c> ([Select ID, Reason_Status_Config__c, Call_Status_Config__c, Verification__c, Activity_Result__c FROM Call_Line__c WHERE Id IN :callLineIds]);
            string entity = '';
            
            if(Trigger.isAfter){
                for(Call_Line__c call : Trigger.new) {
                    entity = call.entity__c;
                    if(call.Id != null && myCallLine.containsKey(call.Id)){
                        myCallLine.get(call.Id).Verification__c = call.Reason_Status_Config__c;
                        myCallLine.get(call.Id).Activity_Result__c = call.Call_Status_Config__c;
                    }
                }
                if (entity != 'ALI') update myCallLine.values();
            }
            
            if(Trigger.isBefore){
                for(Call_Line__c callist : Trigger.new) {
                    Call_Line__c oldCall = Trigger.oldMap.get(callist.Id);
                    
                    if(callist.Reason_Status_Config__c != oldCall.Reason_Status_Config__c){
                        callist.Verification__c = callist.Reason_Status_Config__c;
                    }
                    if(callist.Call_Status_Config__c != oldCall.Call_Status_Config__c){
                        callist.Activity_Result__c = callist.Call_Status_Config__c;
                    }
                }
            }
        }
    }
}