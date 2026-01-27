trigger insertToActivityResult on Call_Line__c (after update) {
    if(!CallLineTriggerControl.skipCaseTypeUpdate){
    List<Activity_History__c> historyList = new List<Activity_History__c>();
    Activity_History__c history = null;
    List<Task> taskList = new List<Task>();
    for(Call_Line__c callLine : Trigger.new){
        system.debug('cek: '+callLine);
        history = new Activity_History__c();
        history.Activity_Result__c = callLine.Activity_Result__c;
        history.Agent__c = callLine.Agent__c;
        history.Call_Bucket__c = callLine.id;
        history.Call_Date__c = callLine.Call_Date__c;
        //history.Activity__c = callLine.Activity__c;
        history.Call_Result__c = callLine.Call_Result__c;
        history.Campaign_Type__c = callLine.Campaign_Type__c;
        history.Call_Duration_Minutes__c = callLine.Call_Duration_Minutes__c;
        history.Entity__c = callLine.Entity__c;
        
        historyList.add(history); 
        
        string recordtypename = Schema.SObjectType.Call_Line__c.getRecordTypeInfosById().get(callLine.recordtypeid).getname();
        String tempStatus = '';
        if (recordtypename.Contains('Collection AMFS')){
            tempStatus = callLine.Status_Retry__c;
        }
        else {
            tempStatus = callLine.Activity_Result__c;
        }
        
        // updated by Ranti
        // dibuatkan utk task tidak double record
        if(tempStatus == 'Rescheduled'){
            
            /* Task t = new Task();
            t.ReminderDateTime = callLine.Reschedule_Date__c;
            t.OwnerId = callLine.Agent__c;
            t.Subject = 'Need to follow up call: '+callLine.Policy_No__c;
            t.Status = 'Open';
            t.Priority = 'Normal';
            t.WhatId = callLine.Id;
            t.Type = 'Call';
            t.IsReminderSet = true;
            t.ownerid = callLine.ownerid;
            taskList.add(t); */
            if (callLine.Reschedule_Date__c != null) { 
                DateTime newSchedule = callLine.Reschedule_Date__c;   
                createReminderPopup.triggerCreateTask(newSchedule, callLine.id);
            }
        }  
        
    }
    
    insert historyList;
    if(taskList.size()>0 && !Test.isRunningTest()){
        insert taskList;
    }
    }
}