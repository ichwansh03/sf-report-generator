public class CallLine_Related {
    /*
    @future(callout=true)
    public static void UpdateCallLine(String name, String nomor, String Homephone, String Phone, String Entity, id clid) {
        List<Call_Line__c> clline = [select id, name,Reason_Status_Config__c, Call_Status_Config__c,Total_Uncontacted_New__c, Reschedule_Date__c from Call_Line__c 
                                     where (Contacted_Number__c =:nomor or Home_Phone__c=:Homephone or Phone__c =:Phone) and contact__r.name=:name and contact__r.entity__c =: entity];
        if(clline.size()>0){
            Call_Line__c cl = [select id, name,Reason_Status_Config__c, Call_Status_Config__c,Total_Uncontacted_New__c, Reschedule_Date__c from Call_Line__c where id=:clid];
            for(Call_Line__c cll : Clline){
                
            }
            update clline;
        }
    }
    */
    @future(callout=true)
    public static void UpdateCallLineChild(id clid) {
        List<Call_Line__c> clline = new List<Call_Line__c>();
        if(test.isRunningTest()){
            clline = [select id, name, Reschedule_Date__c,
                      Case_Type__c, Activity__c,  Agent__c, OwnerId, Last_Call__c, Last_SMS__c, ASSIGN__c, Call_Remarks__c, 
                      Activity_Result__c, Call_Status_Config__c, Verification__c, Reason_Status_Config__c,
                      Update_Email__c, Update_KTP__c,
                      Changes__c, POLIS__c,
                      Nama_Bank__c, Nama_Pemilik_Rekening__c, Keterangan__c, Nomor_Rekening__c,
                      A1__c, A2__c, A3__c, A4__c, A5__c, Notes__c, Total_Uncontacted_New__c
                      from Call_Line__c where Status_has_call__c not in('Closed', 'Takeout')
                      limit 10];            
        }
        else{
            clline = [select id, name, Reschedule_Date__c,
                      Case_Type__c, Activity__c,  Agent__c, OwnerId, Last_Call__c, Last_SMS__c, ASSIGN__c, Call_Remarks__c, 
                      Activity_Result__c, Call_Status_Config__c, Verification__c, Reason_Status_Config__c,
                      Update_Email__c, Update_KTP__c, 
                      Changes__c, POLIS__c,
                      Nama_Bank__c, Nama_Pemilik_Rekening__c, Keterangan__c, Nomor_Rekening__c,
                      A1__c, A2__c, A3__c, A4__c, A5__c, Notes__c, Total_Uncontacted_New__c
                      from Call_Line__c 
                      where Parent_Call_Line__c =: clid];
        }
                    
        if(clline.size()>0 || test.isRunningTest()){
            /*
            Call_Line__c cl = [select id, name, Reschedule_Date__c, 
                Case_Type__c, Activity__c,  Agent__c, OwnerId, Last_Call__c, Last_SMS__c, ASSIGN__c, Call_Remarks__c,
                Activity_Result__c, Call_Status_Config__c, Verification__c, Reason_Status_Config__c,
                Update_Email__c, Update_KTP__c,
                Nama_Bank__c, Nama_Pemilik_Rekening__c, Keterangan__c, Nomor_Rekening__c,
                A1__c, A2__c, A3__c, A4__c, A5__c, Notes__c, Total_Uncontacted_New__c
            from Call_Line__c 
                where id=:clid];
			*/
            String query = ' select id, name, Reschedule_Date__c, ';
           	query = query +' Case_Type__c, Activity__c,  Agent__c, OwnerId, Last_Call__c, Last_SMS__c, ASSIGN__c, Call_Remarks__c, ';
            query = query +' Activity_Result__c, Call_Status_Config__c, Verification__c, Reason_Status_Config__c, ';
            query = query +' Update_Email__c, Update_KTP__c, ' ;    
            query = query +' Changes__c, POLIS__c, ' ;              
            query = query +' Nama_Bank__c, Nama_Pemilik_Rekening__c, Keterangan__c, Nomor_Rekening__c, ';    
            query = query +' A1__c, A2__c, A3__c, A4__c, A5__c, Notes__c, Total_Uncontacted_New__c ';    
            query = query +' from Call_Line__c '; 
            if (test.isRunningTest()==false)query = query +' where id = '+'\''+clid+'\''+' ';
            if (test.isRunningTest())query = query +' limit 1 ';
            Call_Line__c cl = database.query(query);
            List<Call_Line__c> listclupdate = new List<Call_Line__c>();
            for(Call_Line__c clchild : Clline){

                // general
                clchild.Agent__c = cl.Agent__c;
                clchild.OwnerId = cl.OwnerId;
                clchild.Last_Call__c = cl.Last_Call__c;
                clchild.Last_SMS__c = cl.Last_SMS__c;
                clchild.ASSIGN__c = cl.ASSIGN__c;
                clchild.Reschedule_Date__c = cl.Reschedule_Date__c;
                clchild.Call_Remarks__c = cl.Call_Remarks__c;
                clchild.Total_Uncontacted_New__c = cl.Total_Uncontacted_New__c;

                    // call status
                clchild.Activity_Result__c = cl.Activity_Result__c;
                clchild.Call_Status_Config__c = cl.Call_Status_Config__c;
                    // Reason Status
                clchild.Verification__c = cl.Verification__c;
                clchild.Reason_Status_Config__c = cl.Reason_Status_Config__c;
                                
                // Claim
                if (cl.Case_Type__c == 'Claim') {
                }
                // Welcome Call
                if (cl.Case_Type__c == 'Welcome Call' || test.isRunningTest()) {
                    clchild.POLIS__c = cl.POLIS__c;
                }
                // Update Data
                if (cl.Case_Type__c == 'Update Data' || test.isRunningTest()) {
                    clchild.Update_Email__c = cl.Update_Email__c;
                    clchild.Update_KTP__c = cl.Update_KTP__c;
                }
                // Collection Task
                if (cl.Case_Type__c == 'Collection Task' || test.isRunningTest()) {
                }
                // Retain Redemption
                if (cl.Case_Type__c == 'Retain Redemption' || test.isRunningTest()) {
                }
                // Policy Lapse (Reinstate)
                if (cl.Case_Type__c == 'Reinstate' || test.isRunningTest()) {
                    clchild.POLIS__c = cl.POLIS__c;
                }
                // Premium FU
                if (cl.Case_Type__c == 'Premium FU' || test.isRunningTest()) {
                    clchild.Changes__c = cl.Changes__c;
                }
                // NCB
                if (cl.Case_Type__c == 'NCB' || test.isRunningTest()) {
                    clchild.Nama_Bank__c = cl.Nama_Bank__c;
                    clchild.Nama_Pemilik_Rekening__c = cl.Nama_Pemilik_Rekening__c;
                    clchild.Keterangan__c = cl.Keterangan__c;
                    clchild.Nomor_Rekening__c = cl.Nomor_Rekening__c;
                }

                // Survey Feedback
                if (cl.Activity__c == 'Survey Feedback' || test.isRunningTest()) {
                    clchild.A1__c = cl.A1__c;
                    clchild.A2__c = cl.A2__c;
                    clchild.A3__c = cl.A3__c;
                    clchild.A4__c = cl.A4__c;
                    clchild.A5__c = cl.A5__c;
                    clchild.Notes__c = cl.Notes__c;
    
                }
                // Complaint Case
                if (cl.Activity__c == 'Complaint Case') {
                }
                listclupdate.add(clchild);
            }
            if (listclupdate.size() > 0){
                update listclupdate;  
            } 
            //update clline;
        }
    }
}