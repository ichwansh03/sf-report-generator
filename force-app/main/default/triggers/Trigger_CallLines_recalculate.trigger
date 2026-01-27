trigger Trigger_CallLines_recalculate on Call_Line__c (after update, before delete) {
    System.debug('***test');
    List<String> ownerOld = new List<String>();
    Boolean recordTypeCollection = false;

    for(Call_Line__c cid : Trigger.Old){
        ownerOld.add(cid.OwnerId);
        if(cid.Activity__c != Null && cid.Activity__c != ''){
            if(cid.Activity__c.Contains('Collection')){
                recordTypeCollection = true;
            }
        }
    }
    
    //New initiation process for batch; Arief Gunawan [MII]
    List<Call_Line__c> TriggerNew = new List<Call_Line__c>();
    List<Call_Line__c> TriggerOld = new List<Call_Line__c>();
    if(recordTypeCollection){
        if(Trigger.isUpdate){
            for(Call_Line__c cl : Trigger.new){
                Call_Line__c oldCl = Trigger.oldMap.get(cl.Id);
                if(!System.isbatch() && !System.isFuture() && oldCl.OwnerId != cl.OwnerId){
                    TriggerNew.add(Cl);
                    TriggerOld.add(oldCl);
                }
            }
            system.debug('***SIZE: '+TriggerNew.size()+';'+TriggerOld.size());
            if (TriggerNew.size() > 0 && TriggerOld.size() > 0){
                Batch_CallLines_Recalculate updateAdhUpdateNew = new Batch_CallLines_Recalculate(TriggerNew, TriggerOld);
                Database.executeBatch(updateAdhUpdateNew, 50);   
            }
        }
    }
    //End; Arief Gunawan [MII]
    
    List<Agent_Distribution_History__c> adhListOld = [Select Id, Amount__c, Campaign__c, User_Detail__r.User__c From Agent_Distribution_History__c Where User_Detail__r.User__c In :ownerOld];
    List<Agent_Distribution_History__c> adhUpdateNew = new List<Agent_Distribution_History__c>();
    List<Agent_Distribution_History__c> adhUpdateOld = new List<Agent_Distribution_History__c>();
    List<Agent_Distribution_History__c> callDel = new List<Agent_Distribution_History__c>();
    
    if(recordTypeCollection){
        /*if(Trigger.isUpdate){
            for (Call_Line__c cl : Trigger.new){
                Call_Line__c oldCl = Trigger.oldMap.get(cl.Id);
            	if(!System.isbatch() && !System.isFuture() && oldCl.OwnerId != cl.OwnerId){
                    Batch_CallLines_Recalculate updateAdhUpdateNew = new Batch_CallLines_Recalculate(Trigger.new, Trigger.Old);
                    Database.executeBatch(updateAdhUpdateNew, 50);   
            	}    
            }
        }*/
        
        if(Trigger.isDelete){/*
            Map <Id, Agent_Distribution_History__c> amountCall = new Map <Id, Agent_Distribution_History__c>();
            for(Call_Line__c cl : Trigger.Old){
                for(Agent_Distribution_History__c adh : adhListOld){
                    if(cl.OwnerId == adh.User_Detail__r.User__c && cl.Agent__c != Null && cl.Entity__c == 'AMFS'){
                        Agent_Distribution_History__c adhUpdate = new Agent_Distribution_History__c();
                        adhUpdate.Id = adh.Id;
                        
                        if(adh.Amount__c == Null){
                            adh.Amount__c = 0;
                        }
                        if(cl.APE_Total_Child__c == Null){
                            cl.APE_Total_Child__c = 0;
                        }
                        adhUpdate.Amount__c = adh.Amount__c - cl.APE_Total_Child__c;
                        adhUpdate.Re_Calculate__c = true;
                        
                        if(amountCall.size() > 0){
                            if(amountCall.get(adhUpdate.Id) == Null){
                                amountCall.put(adhUpdate.Id, adhUpdate);
                            } else {
                                Agent_Distribution_History__c edit = amountCall.get(adhUpdate.Id);
                                Double amountTmp = edit.Amount__c;
                                edit.Amount__c = amountTmp - cl.APE_Total_Child__c;
                                amountCall.put(edit.Id, edit);
                            }
                        } else {
                            amountCall.put(adhUpdate.Id, adhUpdate);
                        }
                    }
                }
            }
            callDel = amountCall.values();
            //Update callDel;
            List<Call_Line__c> call = new List<Call_Line__c>();
            //Batch_CallLines_Recalculate updateCallDel = new Batch_CallLines_Recalculate(call, call, callDel);
            //Database.executeBatch(updateCallDel, 50);*/
        }
    }
    //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Wait Until The Process is Complete!'));
}