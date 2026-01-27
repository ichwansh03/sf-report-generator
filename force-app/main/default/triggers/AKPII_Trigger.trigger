trigger AKPII_Trigger on Agent_KPI_Item__c (Before Insert, Before Update) {
    for (Agent_KPI_Item__c kpi : trigger.new){
        if (!kpi.Master__c) {
            id AgentID = id.valueof(kpi.agent_Id__c); //'005p0000002OXgx';//
        
            // Quality Control - DONE
            if (kpi.Data_Source__c == 'Quality Control') {
                AggregateResult[] groupedResults = [SELECT AVG(Group_Total__c) aver FROM Quality_Control__c WHERE Periode__c =: kpi.Periode__c and Agent__c =: AgentID];
                //List<Quality_Control__c> qc = [SELECT id, Group_Total__c FROM Quality_Control__c WHERE Periode__c =: kpi.Periode__c and Agent__c =: AgentID];
                
                kpi.Quality_Control_Data__c = integer.valueof(groupedResults[0].get('aver'));
                kpi.Actual_Data__c = kpi.Quality_Control_Data__c;
            }
            // PureCloud - Attendance
            if (kpi.Data_Source__c == 'PureCloud - Attendance') {
                //list<PureCloud__c> pc = [SELECT id FROM PureCloud__c WHERE Periode__c =: kpi.Periode__c and Agent__c =: AgentID];
                kpi.PureCloud_Count_Attendance__c = [SELECT count() FROM PureCloud__c WHERE Periode__c =: kpi.Periode__c and Agent_Name__c =: AgentID and Attend__c = TRUE];
                // kpi.PureCloud_Target_Attendance__c = 0;
                
                if (kpi.PureCloud_Target_Attendance__c == 0) kpi.Actual_Data__c = 0;
                if (kpi.PureCloud_Target_Attendance__c > 0) kpi.Actual_Data__c = kpi.PureCloud_Count_Attendance__c / kpi.PureCloud_Target_Attendance__c * 100;
            }
            // PureCloud - Latetime
            if (kpi.Data_Source__c == 'PureCloud - Latetime') {
                kpi.PureCloud_Count_Days__c = [SELECT count() FROM PureCloud__c WHERE Periode__c =: kpi.Periode__c and Agent_Name__c =: AgentID and Attend__c = TRUE];

                AggregateResult[] groupedResults = [SELECT SUM(Late_Duration_Minute__c) aver FROM PureCloud__c WHERE Periode__c =: kpi.Periode__c and Agent_Name__c =: AgentID];

                kpi.PureCloud_Sum_Latetime__c = integer.valueof(groupedResults[0].get('aver'));
                
                kpi.Actual_Data__c = kpi.PureCloud_Sum_Latetime__c;
            }
            // PureCloud - Productivity
            if (kpi.Data_Source__c == 'PureCloud - Productivity') {
                kpi.PureCloud_Count_Days__c = [SELECT count() FROM PureCloud__c WHERE Periode__c =: kpi.Periode__c and Agent_Name__c =: AgentID and Attend__c = TRUE];

                AggregateResult[] groupedResults = [SELECT SUM(Productivity__c) aver FROM PureCloud__c WHERE Periode__c =: kpi.Periode__c and Agent_Name__c =: AgentID];

                kpi.PureCloud_Sum_Minute__c = integer.valueof(groupedResults[0].get('aver'));
                
                if (kpi.PureCloud_Count_Days__c > 0)
                kpi.Actual_Data__c = kpi.PureCloud_Sum_Minute__c / kpi.PureCloud_Count_Days__c;
            }
            // PureCloud - AHT
            if (kpi.Data_Source__c == 'PureCloud - AHT') {
                AggregateResult[] groupedResults = [SELECT SUM(AHT_Sum__c) aver FROM PureCloud__c WHERE Periode__c =: kpi.Periode__c and Agent_Name__c =: AgentID];
                kpi.PureCloud_Sum_AHT__c = integer.valueof(integer.valueof(groupedResults[0].get('aver'))/60);
                kpi.PureCloud_Count_Days__c = [SELECT count() FROM PureCloud__c WHERE Periode__c =: kpi.Periode__c and Agent_Name__c =: AgentID and Attend__c = TRUE];
                
                if (kpi.PureCloud_Count_Days__c > 0)
                kpi.Actual_Data__c = kpi.PureCloud_Sum_AHT__c / kpi.PureCloud_Count_Days__c;
            }
            // ICF - Negative Feedback
            if (kpi.Data_Source__c == 'ICF - Negative Feedback') {
            
                kpi.ICF_Negative_Feedback__c = [SELECT Count() FROM Negative_Feedback__c WHERE Case__r.Periode__c =: kpi.Periode__c and (Case__r.OwnerId =: AgentID OR Case__r.CreatedById =: AgentID)];
                
                kpi.Actual_Data__c = kpi.ICF_Negative_Feedback__c;
            }
            // Case - Email
            if (kpi.Data_Source__c == 'Case - Email') {
                kpi.Case_Count_Email__c = [SELECT Count() FROM Case WHERE Periode__c =: kpi.Periode__c and (OwnerId =: AgentID OR CreatedById =: AgentID) and Origin = 'Email'];

                kpi.Actual_Data__c = kpi.Case_Count_Email__c;
            }
            // Case - LiveChat
            if (kpi.Data_Source__c == 'Case - LiveChat') {
                //kpi.Case_Count_Email__c = [SELECT Count() FROM Negative_Feedback__c WHERE Case__r.Periode__c =: kpi.Periode__c and Case__r.OwnerId =: AgentID and Origin = 'Live Agent'];

                kpi.Case_Count_LiveChat__c = [SELECT Count() FROM Case WHERE Periode__c =: kpi.Periode__c and (OwnerId =: AgentID OR CreatedById =: AgentID) and Origin = 'Live Agent'];
                kpi.Actual_Data__c = kpi.Case_Count_LiveChat__c;
            }
            // Case - Email and LiveChat
            if (kpi.Data_Source__c == 'Case - Email and LiveChat') {
                kpi.Case_Count_Email__c = [SELECT Count() FROM Case WHERE Periode__c =: kpi.Periode__c and (OwnerId =: AgentID OR CreatedById =: AgentID) and Origin = 'Email'];
                kpi.Case_Count_LiveChat__c = [SELECT Count() FROM Case WHERE Periode__c =: kpi.Periode__c and (OwnerId =: AgentID OR CreatedById =: AgentID) and Origin = 'Live Agent'];
                
                kpi.Actual_Data__c = kpi.Case_Count_Email__c + kpi.Case_Count_LiveChat__c;
            }
            // Case - Inquiry
            if (kpi.Data_Source__c == 'Case - Inquiry') {
                kpi.Case_Inquiry__c = [SELECT Count() FROM Case WHERE Periode__c =: kpi.Periode__c and (OwnerId =: AgentID OR CreatedById =: AgentID) and Type = 'Inquiry'];
                
                kpi.Actual_Data__c = kpi.Case_Inquiry__c;
            }
            // Case - Request
            if (kpi.Data_Source__c == 'Case - Request') {
                kpi.Case_Request__c = [SELECT Count() FROM Case WHERE Periode__c =: kpi.Periode__c and (OwnerId =: AgentID OR CreatedById =: AgentID) and Type = 'Request'];
                
                kpi.Actual_Data__c = kpi.Case_Request__c;
            }
            // Case - CHS
            if (kpi.Data_Source__c == 'Case - CHS') {
                kpi.Case_CHS__c = [SELECT Count() FROM Case WHERE Periode__c =: kpi.Periode__c and (OwnerId =: AgentID OR CreatedById =: AgentID) and Type = 'CHS'];
                
                kpi.Actual_Data__c = kpi.Case_CHS__c;
            }
            //Case - Contact
            if (kpi.Data_Source__c == 'Case - Contact') {
                Integer CountCaseContact = 0;
                string tempcontact = '';
                for (Case cs : [SELECT ContactId FROM Case WHERE Periode__c =: kpi.Periode__c and (OwnerId =: AgentID OR CreatedById =: AgentID) and ContactId != NULL order by ContactId])
                {
                    if (cs.ContactId == tempcontact) { CountCaseContact += 1; tempcontact = string.valueof(cs.Contactid);}
                }
                //kpi.Case_Contact__c = [SELECT Count(ContactId) FROM Case WHERE Periode__c =: kpi.Periode__c and OwnerId =: AgentID];
                kpi.Case_Contact__c = CountCaseContact;
                kpi.Actual_Data__c = CountCaseContact;
            }
        }
    }
}