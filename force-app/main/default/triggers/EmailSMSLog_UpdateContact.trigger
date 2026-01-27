trigger EmailSMSLog_UpdateContact on Email_SMS_Log__c (Before update) {
    if (trigger.isBefore){
        for (Email_SMS_Log__c tsk : trigger.new) {
            if (tsk.Fg_Update_Contact__c && tsk.Category__c == 'ICF'){
                
                system.debug('test mot');
                tsk.Fg_Update_Contact__c = FALSE;
                
                Contact ct = [SELECT id, 
                        Survey_Ask_Send_Counter__c, // reset 1, pakai Timebase workflow atau parameter berubah.
                        Survey_Ask_Send_Date__c,
                        Survey_Buy_Send_Counter__c,
                        Survey_Buy_Send_Date__c,
                        Survey_Claim_Send_Counter__c,
                        Survey_Claim_Send_Date__c,
                        Survey_Complaint_Send_Counter__c,
                        Survey_Complaint_Send_Date__c,
                        Survey_Renew_Send_Counter__c,
                        Survey_Renew_Send_Date__c,
                        
                        Freeze_Ask_End_Date__c,
                        Freeze_Buy_End_Date__c,
                        Freeze_Claim_End_Date__c,
                        Freeze_Complaint_End_Date__c,
                        Freeze_Renew_End_Date__c,
                        
                        Interval_Completed_Month__c, // 6 month
                        Interval_Max_Loop__c, // frequency
                        Interval_No_Response_Month__c, // 1 month
                        
                        Email_Sms_Log_Ask__c,
                        Email_Sms_Log_Buy__c,
                        Email_Sms_Log_Claim__c,
                        Email_Sms_Log_Complaint__c,
                        Email_Sms_Log_Renew__c
                    FROM Contact 
                    WHERE id = : tsk.Contact__c
                ];
                
                // add/update Support MII at 27 03 24
                String recordTypeICF = 'Master_Email_SMS';
                if (string.isnotblank(tsk.Case__c)) {
                    Case cs = [select id,RecordTypeId, MOT__c, Entity__c FROM Case WHERE id = : tsk.Case__c ];    
                    recordTypeICF = cs.MOT__c != null && cs.Entity__c == 'AMFS' ? 'Master_Qualtrics' : 'Master_Email_SMS';
                }
                
                
                 
                /* for (ICF_Parameter__c param : [SELECT id,
                        //Send_ICF_Day__c, 
                                               Interval_Completed_Month__c, Interval_No_Response_Month__c, Interval_Max_Loop__c
                    FROM ICF_Parameter__c WHERE Record_Type_Name__c = 'Master_Email_SMS' and (Entity__c = :tsk.Entity__c or Entity__c = '')
                    order by Entity__c desc
                    limit 1
                ]) { */
                for (ICF_Parameter__c param : [SELECT id,
                        //Send_ICF_Day__c, 
                                               Interval_Completed_Month__c, Interval_No_Response_Month__c, Interval_Max_Loop__c
                    FROM ICF_Parameter__c WHERE Record_Type_Name__c =:recordTypeICF and (Entity__c = :tsk.Entity__c or Entity__c = '')
                    order by Entity__c desc
                    limit 1
                ]) {
                    date todaydate = date.today();
                    integer maxloop = 1;
                    if (param.Interval_Max_Loop__c != '') maxloop = integer.valueof(param.Interval_Max_Loop__c);
                    
                    integer noresponse = 0;
                    if (param.Interval_No_Response_Month__c != '') noresponse = integer.valueof(param.Interval_No_Response_Month__c);
                    
                    date freezedate = todaydate + (noresponse * 30 * maxloop);
                    
                    if (tsk.Survey_Type__c == 'I Ask') {
                        // reset 1, pakai Timebase workflow atau parameter berubah.
                        if (ct.Survey_Ask_Send_Counter__c == NULL) ct.Survey_Ask_Send_Counter__c = 0;
                        ct.Survey_Ask_Send_Counter__c += 1;
                        ct.Survey_Ask_Send_Date__c = todaydate;
                
                        ct.Freeze_Ask_End_Date__c = freezedate;
                        ct.Email_Sms_Log_Ask__c = tsk.id;
                    }
                    if (tsk.Survey_Type__c == 'I Buy') {
                        if (ct.Survey_Buy_Send_Counter__c == NULL) ct.Survey_Buy_Send_Counter__c = 0;                    
                        ct.Survey_Buy_Send_Counter__c += 1;
                        ct.Survey_Buy_Send_Date__c = todaydate;
    
                        ct.Freeze_Buy_End_Date__c = freezedate;
                        ct.Email_Sms_Log_Buy__c = tsk.id;
                    }
                    if (tsk.Survey_Type__c == 'I Claim') {
                        if (ct.Survey_Claim_Send_Counter__c == NULL) ct.Survey_Claim_Send_Counter__c = 0;
                        ct.Survey_Claim_Send_Counter__c += 1;
                        ct.Survey_Claim_Send_Date__c = todaydate;
    
                        ct.Freeze_Claim_End_Date__c = freezedate;
                        ct.Email_Sms_Log_Claim__c = tsk.id;
    
                    }
                    if (tsk.Survey_Type__c == 'I Complain') {
                        if (ct.Survey_Complaint_Send_Counter__c == NULL) ct.Survey_Complaint_Send_Counter__c = 0;
                        ct.Survey_Complaint_Send_Counter__c += 1;
                        ct.Survey_Complaint_Send_Date__c = todaydate;
    
                        ct.Freeze_Complaint_End_Date__c = freezedate;
                        ct.Email_Sms_Log_Complaint__c = tsk.id;
    
                    }
                    if (tsk.Survey_Type__c == 'I Renew') {
                        if (ct.Survey_Renew_Send_Counter__c == NULL) ct.Survey_Renew_Send_Counter__c = 0;
                        ct.Survey_Renew_Send_Counter__c += 1;
                        ct.Survey_Renew_Send_Date__c = todaydate;
    
                        ct.Freeze_Renew_End_Date__c = freezedate;
                        ct.Email_Sms_Log_Renew__c = tsk.id;
                    }
                    integer icm = 0;
                    if (param.Interval_Completed_Month__c != '')
                        icm = integer.valueof(param.Interval_Completed_Month__c);
                    ct.Interval_Completed_Month__c = icm; // 6 month
                    ct.Interval_Max_Loop__c = maxloop; // frequency
                    ct.Interval_No_Response_Month__c = noresponse; // 1 month
            
                    update ct;
                } // end for parameter.
            } // true
        } //end for
    } // if
} // end trigger