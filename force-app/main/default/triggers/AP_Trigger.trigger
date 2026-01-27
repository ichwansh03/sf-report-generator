trigger AP_Trigger on Agent_Performance__c (Before Insert, Before Update) {
    for (Agent_Performance__c ap : trigger.new) {
        //if (trigger.isInsert){
        ap.RecordTypeId = ap.RecordTypeId__c;
        ap.Agent_Parameter__c = ap.Agent_Parameter_Id__c;
        //}
        ap.Name = ap.Agent_Name__c+'-'+ap.Entity__c+'-'+ap.Periode__c;
        ap.Ext_Id__c = ap.Agent__c+'-'+ap.Entity__c+'-'+ap.Periode__c;
        ap.Entity__c = ap.Entity_f__c;        
        
        // Data by System : Auto or Manual
        if (ap.Agree_to_Redebet_Data_Auto__c == 'Yes' && ap.Agree_to_Redebet_Data_System__c != NULL)            ap.Agree_to_Redebet_Data__c = ap.Agree_to_Redebet_Data_System__c;

        if (ap.Agree_to_Reinstate_Data_Auto__c == 'Yes' && ap.Agree_to_Reinstate_Data_System__c != NULL)            ap.Agree_to_Reinstate_Data__c = ap.Agree_to_Reinstate_Data_System__c;

        if (ap.AHT_Data_Auto__c == 'Yes' && ap.AHT_Data_System__c != NULL)            ap.AHT_Data__c = ap.AHT_Data_System__c;

        if (ap.Attempt_Call_Data_Auto__c == 'Yes' && ap.Attempt_Call_Data_System__c != NULL)            ap.Attempt_Call_Data__c = ap.Attempt_Call_Data_System__c;

        if (ap.Attendance_Data_Auto__c == 'Yes' && ap.Attendance_Data_System__c != NULL)            ap.Attendance_Data__c = ap.Attendance_Data_System__c;

        if (ap.Aux_Data_Auto__c == 'Yes' && ap.Aux_Data_System__c != NULL)            ap.Aux_Data__c = ap.Aux_Data_System__c;

        if (ap.Call_Monitoring_Data_Auto__c == 'Yes' && ap.Call_Monitoring_Data_System__c != NULL)            ap.Call_Monitoring_Data__c = ap.Call_Monitoring_Data_System__c;

        if (ap.Cases_Data_Auto__c == 'Yes' && ap.Cases_Data_System__c != NULL)            ap.Cases_Data__c = ap.Cases_Data_System__c;

        if (ap.Contact_Rate_Data_Auto__c == 'Yes' && ap.Contact_Rate_Data_System__c != NULL)            ap.Contact_Rate_Data__c = ap.Contact_Rate_Data_System__c;

        if (ap.Email_WA_Data_Auto__c == 'Yes' && ap.Email_WA_Data_System__c != NULL)            ap.Email_WA_Data__c = ap.Email_WA_Data_System__c;

        if (ap.Error_Rate_Data_Auto__c == 'Yes' && ap.Error_Rate_Data_System__c != NULL)            ap.Error_Rate_Data__c = ap.Error_Rate_Data_System__c;

        if (ap.Error_Rate_Data_Auto__c == 'Yes' && ap.Error_Rate_Data_System__c != NULL)            ap.Error_Rate_Data__c = ap.Error_Rate_Data_System__c;

        if (ap.Inforce_Data_Auto__c == 'Yes' && ap.Inforce_Data_System__c != NULL)            ap.Inforce_Data__c = ap.Inforce_Data_System__c;

        if (ap.Late_Time_Data_Auto__c == 'Yes' && ap.Late_Time_Data_System__c != NULL)            ap.Late_Time_Data__c = ap.Late_Time_Data_System__c;

        if (ap.Quiz_Data_Auto__c == 'Yes' && ap.Quiz_Data_System__c != NULL)            ap.Quiz_Data__c = ap.Quiz_Data_System__c;

        if (ap.Referral_Data_Auto__c == 'Yes' && ap.Referral_Data_System__c != NULL)            ap.Referral_Data__c = ap.Referral_Data_System__c;

        if (ap.Survey_Push_Rate_Data_Auto__c == 'Yes' && ap.Survey_Push_Rate_Data_System__c != NULL)            ap.Survey_Push_Rate_Data__c = ap.Survey_Push_Rate_Data_System__c;
                        
        // Score by System : Auto or Manual
        if (ap.Agree_to_Redebet_Score_Auto__c == 'Yes' ) ap.Agree_to_Redebet_Score__c = string.valueof(ap.Agree_to_Redebet_Score_F__c);
        if (ap.Agree_to_Reinstate_Score_Auto__c == 'Yes' ) ap.Agree_to_Reinstate_Score__c = string.valueof(ap.Agree_to_Reinstate_Score_F__c);
        if (ap.AHT_Score_Auto__c == 'Yes' ) ap.AHT_Score__c = string.valueof(ap.AHT_Score_F__c);
        if (ap.Attempt_Call_Score_Auto__c == 'Yes' ) ap.Attempt_Call_Score__c = string.valueof(ap.Attempt_Call_Score_F__c);
        if (ap.Attendance_Score_Auto__c == 'Yes' ) ap.Attendance_Score__c = string.valueof(ap.Attendance_Score_F__c);
        if (ap.Aux_Score_Auto__c == 'Yes' ) ap.Aux_Score__c = string.valueof(ap.Aux_Score_F__c);
        if (ap.Call_Monitoring_Score_Auto__c == 'Yes' ) ap.Call_Monitoring_Score__c = string.valueof(ap.Call_Monitoring_Score_F__c);
        if (ap.Cases_Score_Auto__c == 'Yes' ) ap.Cases_Score__c = string.valueof(ap.Cases_Score_F__c);
        if (ap.Contact_Rate_Score_Auto__c == 'Yes' ) ap.Contact_Rate_Score__c = string.valueof(ap.Contact_Rate_Score_F__c);
        if (ap.Email_WA_Score_Auto__c == 'Yes' ) ap.Email_WA_Score__c = string.valueof(ap.Email_WA_Score_F__c);
        if (ap.Error_Rate_Score_Auto__c == 'Yes' ) ap.Error_Rate_Score__c = string.valueof(ap.Error_Rate_Score_F__c);
        if (ap.Inforce_Score_Auto__c == 'Yes' ) ap.Inforce_Score__c = string.valueof(ap.Inforce_Score_F__c);
        if (ap.Late_Time_Score_Auto__c == 'Yes' ) ap.Late_Time_Score__c = string.valueof(ap.Late_Time_Score_F__c);
        if (ap.Quiz_Score_Auto__c == 'Yes' ) ap.Quiz_Score__c = string.valueof(ap.Quiz_Score_F__c);
        if (ap.Referral_Score_Auto__c == 'Yes' ) ap.Referral_Score__c = string.valueof(ap.Referral_Score_F__c);
        if (ap.Survey_Push_Rate_Score_Auto__c == 'Yes' ) ap.Survey_Push_Rate_Score__c = string.valueof(ap.Survey_Push_Rate_Score_F__c);

        // Hitung Final Rating
        if (ap.Final_Score__c > 89) ap.Final_Rating__c = 'A';
        else if (ap.Final_Score__c > 79) ap.Final_Rating__c = 'B';
        else if (ap.Final_Score__c > 69) ap.Final_Rating__c = 'C';
        else if (ap.Final_Score__c > 59) ap.Final_Rating__c = 'D';
        else if (ap.Final_Score__c == 0) ap.Final_Rating__c = '';
        else ap.Final_Rating__c = 'E';
        
        
        // exec Batch
        if (!System.isBatch() && trigger.isUpdate) {
            String q = 'select id, Agent__c, Document_Date__c, Periode__c, Entity__c, ';
            q = q + ' Agree_to_Redebet_Data_Auto__c, Agree_to_Reinstate_Data_Auto__c, AHT_Data_Auto__c, Attempt_Call_Data_Auto__c, Attendance_Data_Auto__c, Aux_Data_Auto__c, Call_Monitoring_Data_Auto__c, Cases_Data_Auto__c, Contact_Rate_Data_Auto__c, Email_WA_Data_Auto__c, Error_Rate_Data_Auto__c, Inforce_Data_Auto__c, Late_Time_Data_Auto__c, Quiz_Data_Auto__c, Referral_Data_Auto__c, Survey_Push_Rate_Data_Auto__c, ';
            q = q + ' Agree_to_Redebet_Data_System__c, Agree_to_Reinstate_Data_System__c, AHT_Data_System__c, Attempt_Call_Data_System__c, Attendance_Data_System__c, Aux_Data_System__c, Call_Monitoring_Data_System__c, Cases_Data_System__c, Contact_Rate_Data_System__c, Email_WA_Data_System__c, Error_Rate_Critical_Data_System__c, Error_Rate_Data_System__c, Inforce_Data_System__c, Late_Time_Data_System__c, Quiz_Data_System__c, Referral_Data_System__c, Survey_Push_Rate_Data_System__c ';
            q = q +' from Agent_Performance__c where id ='+'\''+ap.id+'\''+' ';
            KPIGetSystemBatch kpi = new KPIGetSystemBatch(q);
            Database.executeBatch(kpi,1);
        }
        
    } // end for
} // end trigger