trigger CallBackCallLineTrigger on Call_Line__c (after insert, after update) { 
    
    List<String> caseTypeCriteria = new List<String>();
    caseTypeCriteria.add('Request_CR_Redemption');
    caseTypeCriteria.add('Request_CR_Withdrawal Big Amount');
    caseTypeCriteria.add('Request_Collection CR_Redemption');
	caseTypeCriteria.add('Request_CR_Redemption TM'); 
     
    if (Trigger.isInsert || trigger.isUpdate) { 
        List<String> caseIds = new List<String>();
        Map<String, String> mapCallLineCaseId = new Map<String, String>();
        for (Call_Line__c cl : Trigger.new) {  
            if (cl.Entity__c == 'AMFS') {                 
                if (String.isNotBlank(cl.Case__c) && trigger.isInsert) {
                    caseIds.add(cl.case__c);
                    mapCallLineCaseId.put(cl.case__c, cl.id);
                } else if (Trigger.isUpdate) { 
                    Call_Line__c old = Trigger.oldMap.get(cl.Id);
                    Call_Line__c newCl = Trigger.newMap.get(cl.id);
                    
                    if (old.Case__c != newCl.Case__c && String.isNotBlank(newCl.Case__c)) { 
                        caseIds.add(cl.case__c);
                        mapCallLineCaseId.put(cl.case__c, cl.id);
                    }
                }
            }
            
        }
        
        if (caseIds.size() > 0) { 
            List<case> csList = [SELECT id FROM case  WHERE  id in :caseIds AND Case_Type__c in :caseTypeCriteria  AND Type = 'Request'   LIMIT 1]; 
            if (csList.size() > 0) {
                for (case row: csList) {
                    if (mapCallLineCaseId.containsKey(row.id) && string.isnotblank(mapCallLineCaseId.get(row.id))) {
                        NotifyAssignTaskAMFS.SendEmail(mapCallLineCaseId.get(row.id),'Request');
                    }
                }
            }
        }
    }
    
    
    if (Trigger.isUpdate) {   
        List<String> caseIdList = new List<String>();
        List<case> updateCase = new List<Case>();
        List<String> clNotesId = new List<String>();
        List<Call_Line__c> clToQuery = new List<Call_Line__c>();
        List<Call_Line__c> clToInsertHist = new List<Call_Line__c>();
        List<Call_Line__c> clToUpdateHist = new List<Call_Line__c>();
        List<Call_Line__c> clToAssessment = new List<Call_Line__c>();
        String recordTypeHistory = Label.CL_History_Record_Type;
        String weCallId = Label.CL_WeCall_Id;
        string uid = userinfo.getUserId();
        ID rtClTelUW = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('TelUW').getRecordTypeId();
        
        if (CallLineTriggerHelper.firstRun) {
            CallLineTriggerHelper.firstRun = false;
            for(Call_Line__c cl : Trigger.new) {
                
                Call_Line__c old = Trigger.oldMap.get(cl.Id);
                Call_Line__c newCl = Trigger.newMap.get(cl.id);
                
                if(cl.Entity__c == 'AMFS' ) {
                    system.debug('Masuk ke call line');
                    Boolean changeRemark = (newCl.get('Call_Remarks__c') != '' && newCl.get('Call_Remarks__c') != null) && (newCl.get('Call_Remarks__c') != old.get('Call_Remarks__c'));
                    Boolean changeNotes = (newCl.get('Notes__c') != '' && newCl.get('Notes__c') != null) && (newCl.get('Notes__c') != old.get('Notes__c'));
                    Boolean isNotTakeout = (cl.Activity_Result__c != 'Takeout' || cl.Activity_Result__c != '' || cl.Reason_Status_Config__c != 'Tidak Berkenan Dihubungi');
                    Boolean filterWecall = (cl.WelcomeCall_Call_Line_Status__c == 'Progress' || cl.WelcomeCall_Call_Line_Status__c == 'Closed') 
                        && ((cl.Activity_Result__c != '' && cl.Verification__c != '') || (cl.Activity_Result__c == 'Hold' && cl.Verification__c == ''));
                    Boolean filterTeluW = cl.RecordTypeId == rtClTelUW && old.Modified_Date__c != newCl.Modified_Date__c;
                    // for exclude Cancel REDEMPTION TM
                    Boolean changeStatus = (old.get('Activity_Result__c') == 'Cancel' && (newCl.get('Activity_Result__c') != '' && newCl.get('Activity_Result__c') != null) && (newCl.get('Activity_Result__c') != old.get('Activity_Result__c')));
                    
                    if (changeRemark && cl.Case__c != null) {
                        clToQuery.add(cl);
                        caseIdList.add(cl.case__c);
                    }
                    
                    
                    if (recordTypeHistory.contains(cl.RecordTypeId) && newCl.Notes__c != null ) {
                        if (uid.equals(newCl.OwnerId)) {
                            if (newCl.Notes__c != old.Notes__c) {
                                Boolean isInclude = false;
                                for (Call_Line__c clcCheck : clToInsertHist) {
                                    if (clcCheck.Policy_No__c == cl.Policy_No__c) isInclude = true;
                                }
                                if (!isInclude) clToInsertHist.add(cl);
                            } else {
                                Boolean isInclude = false;
                                if (newCl.Activity_Result__c != old.Activity_Result__c || 
                                    newCl.Verification__c != old.Verification__c) {
                                        for (Call_Line__c clcCheck : clToUpdateHist) {
                                            if (clcCheck.Policy_No__c == cl.Policy_No__c) isInclude = true;
                                        }
                                        if (!isInclude) {
                                            clToUpdateHist.add(cl);
                                            clNotesId.add(cl.Id);
                                        }
                                    }
                            }
                        }
                    }
                    
                     if (((((isNotTakeout && changeRemark) || ((filterWeCall || filterTelUW) && changeNotes)) && cl.Activity_Result__c != 'Cancel') || changeStatus)) clToAssessment.add(cl);
                } 
            }
        } 
        
        // update Cases
        List<case> csList = [SELECT status  FROM case  WHERE  id in :caseIdList AND Case_Type__c in :caseTypeCriteria  AND Type = 'Request'   LIMIT 1]; 
        if (csList.size() > 0) {
            List<caseComment> cmList = new List<caseComment>();
            for (Case cs : csList) {
                caseComment cm = new caseComment();
                for (Call_Line__c cl2 : clToQuery) {
                    if (cl2.Case__c == cs.Id) {
                        cm.parentId = cl2.Case__c;
                        cm.commentBody = cl2.Call_Remarks__c;
                        // clToQuery.remove(clToQuery.indexOf(cl2));
                    }
                }
                cmList.add(cm); 
                
                cs.status = 'Closed';
                updateCase.add(cs);
            }
             
            if (cmList.size() > 0) insert cmList;
        }  
        
        List<Call_Line_History__c> clhUpsert = new List<Call_Line_History__c>();
        if (clToInsertHist.size() > 0) {
            for (Call_Line__c cl3 : clToInsertHist) {
                Call_Line_History__c clh = new Call_Line_History__c();
                clh.Call_Line__c = cl3.Id;
                clh.Call_Line_Status__c = cl3.RecordTypeId == weCallId ? cl3.WelcomeCall_Call_Line_Status__c : null;
                clh.call_Status__c = cl3.RecordTypeId == weCallId ? cl3.Activity_Result__c : null;
                clh.Detail_Status__c = cl3.RecordTypeId == weCallId ? cl3.WelcomeCall_Detail_Status__c : null;
                clh.Notes__c = cl3.Notes__c;
                clh.Reason_Detail_Status__c = cl3.RecordTypeId == weCallId ? cl3.WelcomeCall_Reason_Detail_Status__c : null;
                clh.Reason_Status__c = cl3.RecordTypeId == weCallId ? cl3.Verification__c : null;
                clh.Call_Remarks__c = cl3.Call_Remarks__c;
                clhUpsert.add(clh);
            }
        }
        
        //if (clNotesId.size() > 0) { 
        // update not history
        List<String> fields = new List<String>(Call_Line_History__c.SObjectType.getDescribe().fields.getMap().keySet());
        String clhQuery = 'SELECT ' + String.join(fields, ',') + ' FROM Call_Line_History__c where call_line__c in(\'' + String.join(clNotesId, '\',\'') + '\')';
        List<Call_Line_History__c> clhUpdList = Database.query(clhQuery);
        List<Call_Line_History__c> clhTbuList = new List<Call_Line_History__c>();
        if (clhUpdList.size() > 0 && clToUpdateHist.size() > 0) {
            for (Call_Line__c cl4 : clToUpdateHist) {
                Integer clhIndex = -1;
                for (Call_Line_History__c clhToCheck : clhUpdList) {
                    if (clhToCheck.Call_Line__c == cl4.Id) {
                        if (clhIndex < 0) {clhIndex = clhUpdList.indexOf(clhToCheck);
                                          } else {
                                              if (clhToCheck.CreatedDate > clhUpdList.get(clhIndex).CreatedDate) clhIndex = clhUpdList.indexOf(clhToCheck);
                                          }
                    }
                }
                if (clhIndex >= 0) { Call_Line_History__c callLineHist = clhUpdList.get(clhIndex); callLineHist.Call_Line_Status__c = cl4.RecordTypeId == weCallId ? cl4.WelcomeCall_Call_Line_Status__c : null; callLineHist.call_Status__c = cl4.RecordTypeId == weCallId ? cl4.Activity_Result__c : null; callLineHist.Detail_Status__c = cl4.RecordTypeId == weCallId ? cl4.WelcomeCall_Detail_Status__c : null; callLineHist.Notes__c = cl4.Notes__c;callLineHist.Reason_Detail_Status__c = cl4.RecordTypeId == weCallId ? cl4.WelcomeCall_Reason_Detail_Status__c : null;callLineHist.Reason_Status__c = cl4.RecordTypeId == weCallId ? cl4.Verification__c : null;callLineHist.Call_Remarks__c = cl4.Call_Remarks__c;clhUpsert.add(callLineHist);
                                   }
            }
        }
        if (clhUpsert.size() > 0) upsert clhUpsert;
        
        if (updateCase.size() > 0) update updateCase;
        
        if (clToAssessment.size() > 0 && system.label.Activate_Event_CL == 'true') {
            system.debug('Masuk ke Assessment');
            for (Call_Line__c cl : clToAssessment) {
                publishCallLineAssessment(cl);
            }
        } else if (system.label.Activate_Event_CL != 'true') System.enqueueJob(new RequestAssesmentQueueable(clToAssessment));
        
    }
    
    public static void publishCallLineAssessment(Call_Line__c cl){
        Assessment_Call_Line__e acl = new Assessment_Call_Line__e();
        acl.Call_Line_ID__c = cl.Id;
        
        Database.SaveResult sr = EventBus.publish(acl);
        
        if (sr.isSuccess()) {
            System.debug('Successfully published event.');
        } else {
            for(Database.Error err : sr.getErrors()) {
                System.debug('Error returned: ' + err.getStatusCode() );
            }
        }
    }
}