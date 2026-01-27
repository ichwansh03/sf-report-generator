trigger Trigger_CallLine on Call_Line__c (before insert, before update, after update) { 
    // updated by MII at 14 11 23
    // User profileUser = [Select id, name, profileId, profile.name from user where Id = :UserInfo.getUserId()];
    User profileUser = [Select id, name, profileId, profile.name, userRoleid, userRole.Name from user where Id = :UserInfo.getUserId()];
     
    if(!CallLineTriggerControl.skipCaseTypeUpdate){
        
        List<Task> createTask = new List<Task>(); // added by Ranti at 2023 jul 26
        
        for(Call_Line__c x:trigger.new){
            
            if (trigger.isBefore && trigger.isInsert){
                if (x.Parent_Call_Line__c == null){
                    //if (x.Campaign_Name__c.contains('Withdrawal') || x.Campaign_Name__c.contains('Redemption Konven')){
                    //    x.APE_Total_Child__c = x.Amount__c;       
                    //}
                    //else {
                        x.APE_Total_Child__c = x.APE_Convert__c;        
                    //}
                } 
                else x.APE_Total_Child__c = 0;
                
            }
            if(trigger.isafter){
                if(system.isFuture()==false && (x.Activity_Result__c != '' && x.Activity_Result__c != NULL) && x.Update_Child__c){
                    //CallLine_Related.UpdateCallLine(x.contact__r.name, x.entity__c, x.Contacted_Number__c,  x.Home_Phone__c, x.Phone__c, x.id);
                    if (!system.isFuture() && !system.isBatch() && x.Activity__c != 'Collection') CallLine_Related.UpdateCallLineChild(x.id);
                }    
            }
            else{
                if (x.Parent_Call_Line__c != null) x.APE_Total_Child__c = 0;
                //if (x.Agent__c != null) if (x.OwnerId != x.Agent__c) x.OwnerId = x.Agent__c;
                if(system.isFuture()==false && x.Date_Reschedule__c!=null && x.Time_Reschedule__c !=null){
                    x.Reschedule_Date__c = DATETIME.valueOf(x.Date_Reschedule__c.YEAR()+'-'+x.Date_Reschedule__c.month()+'-'+x.Date_Reschedule__c.DAY()+' '+X.Time_Reschedule__c+':00');
                }
                /*==================Mus Trigger Update Custom Remark=====================*/
                if(Trigger.isBefore && Trigger.isUpdate){                    
                    if(x.Entity__c == 'AMFS' && x.Agent__c != Null && x.Call_Status_Config__c != Trigger.oldMap.get(x.Id).Call_Status_Config__c){
                        if(UserInfo.getUserId() == x.Agent__c && Trigger.oldMap.get(x.Id).Status_has_call__c != 'Closed'){
                            DateTime dateNow = System.now();
                            x.Collection_Call_Date__c = dateNow;
                            String colDateFormat = dateNow.format('dd/MM/yyyy HH:mm');
                            x.Custom_Remarks__c = x.Name +'-' +x.Case_Type_Config__c +'-' +colDateFormat +'-' +x.ID_User_RLS_DMTM__c +'-' +Trigger.oldMap.get(x.Id).Call_Remarks__c;
                            
                            if(x.Call_Remarks__c != Null){
                                x.Custom_Remarks__c = x.Name +'-' +x.Case_Type_Config__c +'-' +colDateFormat +'-' +x.ID_User_RLS_DMTM__c +'-' +x.Call_Remarks__c;
                            }
                        }
                    }
                    if(x.Entity__c == 'AMFS' && x.Agent__c != Null && x.Call_Remarks__c != Trigger.oldMap.get(x.Id).Call_Remarks__c){
                        if(UserInfo.getUserId() == x.Agent__c && Trigger.oldMap.get(x.Id).Status_has_call__c != 'Closed'){
                            DateTime dateNow = System.now();
                            x.Collection_Call_Date__c = dateNow;
                            String colDateFormat = dateNow.format('dd/MM/yyyy HH:mm');
                            x.Custom_Remarks__c = x.Name +'-' +x.Case_Type_Config__c +'-' +colDateFormat +'-' +x.ID_User_RLS_DMTM__c +'-' +Trigger.oldMap.get(x.Id).Call_Remarks__c;
                            
                            if(x.Call_Remarks__c != Null){
                                x.Custom_Remarks__c = x.Name +'-' +x.Case_Type_Config__c +'-' +colDateFormat +'-' +x.ID_User_RLS_DMTM__c +'-' +x.Call_Remarks__c;
                            }
                        }
                    }
                    
                    //Update SMS date
                    if(x.Entity__c == 'AMFS' && x.Agent__c != Null && x.Message__c != Trigger.oldMap.get(x.Id).Message__c){
                        DateTime dateNow = System.now();
                        x.SMS_Date__c = dateNow;
                    }
                    
                    //Untuk manual change owner (standard)
                    if (x.Entity__c == 'AMFS' && x.Agent__c != NULL && x.OwnerId != x.Agent__c && !System.isBatch() && !System.isFuture()){
                        if (String.valueof(x.OwnerId).left(3) != '00G') x.Agent__c = x.OwnerId;
                        else x.Agent__c = NULL;
                    }
                    //Untuk batch process
                    if (x.Entity__c == 'AMFS' && x.Agent__c != NULL && x.OwnerId != x.Agent__c){
                        x.ownerId = x.Agent__c;
                    }
                      
                    //Request Yenny, pemindahan formula PB untuk status has call
                    //coba mus
                    Boolean isSPV = false;
                    if(profileUser.profile.name == 'Supervisor Collection-AMFS'){
                        isSPV = true;
                    }
                    //coba mus
                    if(!isSPV){
                        if (x.Call_Status_Config__c == 'Approved' || x.Call_Status_Config__c == 'Not Approved' || x.Call_Status_Config__c == 'Sudah Pay By System' || x.Call_Status_Config__c == 'N' || x.Call_Status_Config__c == 'Y' || x.Call_Status_Config__c == 'Cancel By System' || x.Call_Status_Config__c == 'Cancel' || x.Call_Status_Config__c == 'Inforced' || (x.Call_Status_Config__c == 'Pending' && x.Reason_Status_Config__c == 'Surrender Wait NCB')){
                            x.Status_Has_Call__c = 'Closed';
                        }
                        if (x.Call_Status_Config__c == 'Uncontacted' || x.Call_Status_Config__c == 'F' || x.Call_Status_Config__c == 'P' || x.Call_Status_Config__c == 'Retry' || (x.Call_Status_Config__c == 'Pending' && x.Reason_Status_Config__c != 'Surrender Wait NCB')){
                            x.Status_Has_Call__c = 'Pending';
                        }
                        if (x.Call_Status_Config__c == 'Takeout'){
                            x.Status_has_call__c = 'Takeout';
                        }
                    }
                }
            }
             
                   
            // added by MII at 26 Jul 2023
            if (string.isnotblank(userinfo.getUserRoleId()) && x.Entity__c == 'AFI' && !system.isFuture() && !system.isBatch() && trigger.isUpdate ) { 
                // UserRole getRole = [Select id, Name from UserRole where id =: userinfo.getUserRoleId()];
                if (
                    String.isnotblank(profileUser.userRoleid) 
                    && (
                        profileUser.UserRole.Name == System.Label.Role_Name_Outbount_agent_AFI 
                        || profileUser.UserRole.Name == System.Label.Role_Name_Outbount_SPV_AFI
                   )) { 
                     
                    Call_Line__c old = Trigger.oldMap.get(x.Id);
                    Call_Line__c newCl = Trigger.newMap.get(x.id);
                    
                    if (trigger.isBefore) {  
                        string remarksold = String.valueof(old.get('Call_Remarks__c'));                 
                        string remarksNew = x.Call_Remarks__c;   
                          string callStatusOld = String.valueof(old.get('Activity_Result__c'));                 
                        string callStatusNew = x.Activity_Result__c;   
                        string reasonStatusOld = String.valueof(old.get('Reason_Status_Config__c'));                 
                        string reasonStatusNew = x.Reason_Status_Config__c;   
                        
                        
                        system.debug('remarksold:'+remarksold);
                        system.debug('remarksNew:'+remarksNew);
                        system.debug('statusOld:'+callStatusOld);
                        system.debug('statusNew:'+callStatusNew);
                        system.debug('statusOld:'+reasonStatusOld);
                        system.debug('statusNew:'+reasonStatusNew);
                        
                        Date contactedDate = Date.valueof(old.get('Update_uncontacting__c'));  
                        boolean isUpdate = false;
                        system.debug('contactedDate:'+contactedDate);
                        system.debug('contactedDate new:'+x.Update_uncontacting__c);
                        
                        
                        Integer totalUncontacted = Integer.valueOf(old.get('Total_Uncontacted_New__c'));
                        if (totalUncontacted == null) totalUncontacted = 0;
                        Integer countUncontacted = totalUncontacted+1;
                        
                        // if (statusOld != statusNew && remarksold != remarksNew && contactedDate != System.today()) { 
                        if (
                            //(callStatusOld != callStatusNew || reasonStatusOld != reasonStatusNew)
                            // && 
                            remarksold != remarksNew && contactedDate != System.today()
                        ) { 
                            isUpdate = true;
                        }
                        
                        system.debug('isUpdate:'+isUpdate);
                        system.debug('totalUncontacted:'+old.get('Total_Uncontacted_New__c'));
                        system.debug('totalUncontacted:'+totalUncontacted);
                        if (String.isNotBlank(callStatusNew) && isUpdate == true && (countUncontacted <= (totalUncontacted +1))) {  
                            system.debug('Add new');
                            x.Total_Uncontacted_New__c = countUncontacted;
                            x.Update_uncontacting__c = system.today();
                        } else {
                            x.Total_Uncontacted_New__c = totalUncontacted;
                        }
                    }
                    
                    
                    // added by Ranti at 26 Jul 2023
                    if ( trigger.isAfter ) {        
                        system.debug('userinfo.getUserRoleId():'+userinfo.getUserRoleId());
                        system.debug('System.Label.Role_Name_Outbount_agent_AFI:'+System.Label.Role_Name_Outbount_agent_AFI );
                        
                        if (profileUser.UserRole.Name == System.Label.Role_Name_Outbount_agent_AFI || System.Test.isrunningtest()) { 
                            
                            DateTime oldSchedule = DateTime.valueof(old.get('Reschedule_Date__c'));      
                            DateTime newSchedule = x.Reschedule_Date__c;   
                            
                            system.debug('oldSchedule:'+oldSchedule); 
                            system.debug('newSchedule:'+newSchedule);
                            
                            if (newSchedule != null && oldSchedule != newSchedule) { 
                                createReminderPopup.triggerCreateTask(newSchedule, x.id);
                            }
                            
                        }
                    }
                }
            }
        }
        
        if (createTask.size() > 0 ) insert createTask;
    }
    
    public class tempChild{
        public Integer totalChild;
        public Decimal totalAPEChild;
    }
}