public class createReminderPopup {
// Gunakan variabel statis untuk menyimpan status trigger
    private static Boolean isExecuting = false;

    public static void triggerCreateTask(Datetime newSchedule, string callLineId) {
        system.debug('isExecuting:'+isExecuting);
              
        // Cek apakah trigger telah dieksekusi sebelumnya
        if (isExecuting) {
            return; // Jika sudah dieksekusi, keluar dari trigger
        }

        isExecuting = true; // Set variabel status menjadi true untuk menandakan trigger sedang dieksekusi
		
        List<Task> createTask = new List<Task>(); // added by Ranti at 2023 jul 26
        Call_Line__c cl = [Select id, Reschedule_Date__c, Policy_No__c,OwnerId, Agent__c, Entity__c from Call_Line__c where id =: callLineId ]; 
        List<Task> listExistingTask = [SELECT ID, Reminder_DateTime__c, ActivityDate, Subject, Status, WhatId, entity__c,  IsReminderSet, Resechedule_Call_Line__c 
                                       FROM Task where WhatId =: callLineId AND Resechedule_Call_Line__c =: newSchedule];
        
        if (listExistingTask.size () < 1)  { 
            Datetime taskTime = newSchedule.addMinutes(-5);
            Task t = new Task(); 
            
            // Atur bidang-bidang yang relevan pada objek Task 
            t.ActivityDate = date.valueOf(newSchedule); 
            t.Subject = 'Need to follow up call: '+cl.Policy_No__c;
            t.Status = 'Open';
            t.Priority = 'Normal';
            t.WhatId = cl.Id;
            t.entity__c = cl.Entity__c;
            t.Type = 'Call';
            t.IsReminderSet = true;
            t.ownerid = cl.Agent__c; 
            t.Policy_No__c = cl.Policy_No__c;
             
            if (cl.Entity__c == 'AFI') { 
            	t.Time_Reminder__c = 5;
                t.Reminder_DateTime__c = taskTime;
                t.Resechedule_Call_Line__c = newSchedule; 
            	t.ReminderDateTime = taskTime; 
            } else { 
            	t.ReminderDateTime = newSchedule; 
            }
        
      	  insert t;	
        }  
        // Lakukan aksi l 
        isExecuting = false; // Set variabel status kembali ke false setelah trigger selesai dieksekusi
    }
}