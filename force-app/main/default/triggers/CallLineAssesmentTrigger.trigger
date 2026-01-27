trigger CallLineAssesmentTrigger on Call_Line__c (after update) {
    
    List<Call_Line__c> clAssesment = new List<Call_Line__c>();
    
    if (Test.isRunningTest()) CallLineTriggerHelper.skipMultipleUpdate = true;
    
    if (CallLineTriggerHelper.skipMultipleUpdate) {
        CallLineTriggerHelper.skipMultipleUpdate = false;
        system.debug('Call Line Assesment Trigger Multiple Update: '+CallLineTriggerHelper.skipMultipleUpdate);
        for(Call_Line__c cl : Trigger.new) {
            
            Call_Line__c old = Trigger.oldMap.get(cl.Id);
            Call_Line__c newCl = Trigger.newMap.get(cl.id);
            
            Boolean changeRemark = (newCl.get('Call_Remarks__c') != '' && newCl.get('Call_Remarks__c') != null) && (newCl.get('Call_Remarks__c') != old.get('Call_Remarks__c'));
            Boolean changeNotes = (newCl.get('Notes__c') != '' && newCl.get('Notes__c') != null) && (newCl.get('Notes__c') != old.get('Notes__c'));
            Boolean isNotTakeout = (cl.Activity_Result__c != 'Takeout' || cl.Activity_Result__c != '');
            Boolean filterWecall = (cl.WelcomeCall_Call_Line_Status__c == 'Progress' || cl.WelcomeCall_Call_Line_Status__c == 'Closed') 
                && ((cl.Activity_Result__c != '' && cl.Verification__c != '') || (cl.Activity_Result__c == 'Hold' && cl.Verification__c == ''));
            Boolean changeStatus = (old.get('Activity_Result__c') == 'Cancel' && (newCl.get('Activity_Result__c') != '' && newCl.get('Activity_Result__c') != null) && (newCl.get('Activity_Result__c') != old.get('Activity_Result__c')));
            system.debug('change status: '+changeStatus);
            if (cl.Entity__c == 'AMFS' && (((isNotTakeout && changeRemark) || (filterWeCall && changeNotes)) && cl.Activity_Result__c != 'Cancel') || changeStatus) clAssesment.add(cl);
             
        }
        
        if (clAssesment.size() > 0) System.enqueueJob(new RequestAssesmentQueueable(clAssesment));
    }
}