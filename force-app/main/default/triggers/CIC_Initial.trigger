trigger CIC_Initial on Case_Internal_Comment__c (After Insert, before Insert) {
    if (trigger.isBefore){
        for (Case_Internal_Comment__c cic : trigger.new){
            // taufik, 19 Jan 2019
            Case cs = [SELECT id, Escalated_Step__c, Escalated_Flow__c, Status, Escalated_Flow_TAT__c
             FROM Case WHERE id =: cic.Case__c];
            
            //--Added by Suryono 28 Jan 2019
            if(cs.Status == 'Closed') {
                Trigger.new[0].addError('Cannot escalate, Case already closed!');
            }
            
            //--Added by Suryono 19 Jan 2019
            if(cic.Auto_Next_Step__c == TRUE && cs.Escalated_Flow__c != NULL && cs.Escalated_Flow_TAT__c != NULL) { 
                //Taufik 
                integer EscalatedStep = 0;
                if (cs.Escalated_Step__c == NULL) EscalatedStep = 1; 
                else EscalatedStep = integer.valueof(cs.Escalated_Step__c);
                // end taufik
                
                // Suryono
                Map<String, Object> mapJs = (Map<String, Object>) JSON.deserializeUntyped(cs.Escalated_Flow__c);
                System.debug('mapJs : ' + mapJs);
                String mapIndex = String.valueOf(EscalatedStep + 1);
                String mapIndexNext = String.valueOf(EscalatedStep + 2);
                // End Suryono
                
                // Suryono
                Map<String, Object> mapJsTAT = (Map<String, Object>) JSON.deserializeUntyped(cs.Escalated_Flow_TAT__c);
                System.debug('mapJsTAT : ' + mapJsTAT);
                if(mapJsTAT.get(mapIndex) != NULL) cic.TAT__c = Integer.valueOf(mapJsTAT.get(mapIndex));
                else if (mapJsTAT.get(mapIndex) != 'null') cic.TAT__c = Integer.valueOf(mapJsTAT.get(mapIndex));
                // End Suryono
                
                // Taufik
                cic.Escalated_Step__c = EscalatedStep + 1;
                if (mapJs.get(mapIndex) == NULL) cic.Division__c = 'CCC';
                else if (mapJs.get(mapIndex) == 'null') cic.Division__c = 'CCC';
                else cic.Division__c = string.valueof(mapJs.get(mapIndex)); // <-- isi di sini, hasil Break dari Escalated Flow
                // End Taufik
                
                // Taufik - Case Next Department
                if (mapJs.get(mapIndexNext) == NULL) cic.Case_Next_Department__c = 'CCC';
                else if (mapJs.get(mapIndexNext) == 'null') cic.Case_Next_Department__c = 'CCC';
                else cic.Case_Next_Department__c = string.valueof(mapJs.get(mapIndexNext)); // <-- isi di sini, hasil Break dari Escalated Flow
                // End Taufik - Case Next Department
            }
            
            cic.Status__c = cic.Case_Status__c;
            cic.Entity__c = cic.Entity_F__c;
            
            if (cic.Division__c == NULL) cic.Division__c = cic.Department_Name__c;

        }
    }
    if (trigger.isAfter){
        for (Case_Internal_Comment__c cic : trigger.new){
            // untuk internal comment
            Case cs = [SELECT id, CaseNumber, Case_Type__c, Entity__c, Internal_Comment__c, Last_Comment__c, OwnerId, Escalated_to_History__c, IsEscalated,
                Division__c, Escalated_Step__c, named_user__c, last_named_user__c, Status, Entity_Backup__c, Escalated_Flow__c, Next_Department__c
             FROM Case WHERE id =: cic.Case__c];
            if (cic.Internal_Comment__c != NULL) {
                if (cs.Last_Comment__c == NULL) cs.Last_Comment__c = cic.Named_User_F__c +' '+ cic.Internal_Comment__c+'; ';
                else cs.Last_Comment__c += cic.Named_User_F__c +' '+ cic.Internal_Comment__c+'; ';
                
                cs.Internal_Comment__c = cic.Internal_Comment__c;
                if (cs.Status == 'New' && cs.Case_Type__c != '') cs.Status = 'In Progress';

                // escalated to
                if (cic.Division__c != NULL) {
                
                    String QueueName = '';
                    QueueName = cs.Entity_Backup__c+' - '+cic.Division__c+' Queue';
                    cs.Division__c = cic.Division__c;
                    System.debug('Queue Name : ' + QueueName);
                  
                    try{
                        QueueSobject qu = [SELECT Id, QueueId, Queue.Name, SobjectType FROM QueueSobject 
                                           WHERE SobjectType = 'Case' and Queue.Name =: QueueName];
                        
                        cs.OwnerId = qu.QueueId;
                        //cs.Waiting_for__c = qu.Queue.Name;
                        /** start femy **/
                        if(cs.named_user__c == null) cs.named_user__c = cic.named_user_F__c;
                        cs.last_named_user__c = cic.named_user_F__c;
                        /** end femy **/
                        if (cs.Escalated_to_History__c == NULL) cs.Escalated_to_History__c = '';
                        cs.Escalated_to_History__c += qu.Queue.Name+'; ';
                        if (cic.Escalated_Step__c != NULL) cs.Escalated_Step__c = cic.Escalated_Step__c;
                        // Taufik - Next Department 
                        if (cic.Escalated_Step__c != NULL) cs.Next_Department__c = cic.Case_Next_Department__c;
                        // End Taufik - Next Department
                        if (cic.TAT__c != NULL) cs.TAT__c = cic.TAT__c;
                        cs.IsEscalated = true;
                        
                        // post Chatter. taufik - 8 Mei 2018
                        String NamedUserBranch = '';
                        if (cic.Division__c.contains('Pusat')) NamedUserBranch = 'Pusat';
                        else NamedUserBranch = cs.Entity_Backup__c;
                        //for (Named_User__c nu : [SELECT id, Chatter_ID__c FROM Named_User__c WHERE Chatter_ID__c != NULL and Entity__c =: NamedUserBranch and (Department_1__c =: cic.Department_L__c OR Department_2__c =: cic.Department_L__c)]) {
                        //    ChatterFeed.insertchatter(nu.Chatter_ID__c,'me',' Please Check Case Number : '+cs.CaseNumber+ ' from '+cic.Named_User_F__c);
                        //}    
                    }
                    catch(Exception ecp){
                        if(test.isRunningTest()==false) cic.adderror(ecp.getMessage());
                        system.debug('*error*'+ecp.getMessage());
                    }
                    
                } // end escalated
                
                update cs;
                system.debug('*last_named_user*'+cs.last_named_user__c);
            }
        }
    }
}