global class SchPopUpFollowUpBackoffice implements Database.Batchable<sObject>,Database.Stateful {
    global List<Case> start(Database.BatchableContext BC) {
    	/***** QUERY CASE *****/
        List<Case> scope = new List<Case>();
        /* ***** OLD *****
         * scope.addAll([SELECT Id, CaseNumber, Entity_Backup__c, First_Queue__c, First_Queue_ID__c, Non_Active_Queue_Name__c, Owner.Name, CreatedDate FROM Case 
                      WHERE isClosed = FALSE AND (Entity_Backup__c = 'AFI' OR Entity_Backup__c = 'ALI' ) AND (NOT Owner.Name LIKE '%Queue%') ORDER BY CreatedDate ASC LIMIT 50000]);*/
        scope.addAll([SELECT Id, CaseNumber, Entity_Backup__c, First_Queue__c, First_Queue_ID__c, Non_Active_Queue_Name__c, Owner.Name, CreatedDate FROM Case 
                      WHERE isClosed = FALSE AND (Entity_Backup__c = 'AFI' OR Entity_Backup__c = 'ALI' ) AND Origin = 'Email' AND Type = 'Request' AND (NOT Owner.Name LIKE '%Queue%') AND OwnerId IN (SELECT Id FROM User WHERE Agent__c = FALSE AND is_Backoffice__c = TRUE) ORDER BY CreatedDate ASC LIMIT 50000]);
        system.debug('scope: '+scope);
        
        return scope; 
    }
    
    
    global void execute(Database.BatchableContext BC, List<Case> scope) {
        
        /* ***** OLD *****
         * 
         * List<Log_Notification__c> newLogNotification = new List<Log_Notification__c>();
        List<Case> listCase = (List<Case>) scope;
        
        Group l_group = [SELECT Id, Name, DeveloperName, Type from GROUP WHERE Type = 'Queue' AND Name = 'AFI - CCC Queue'];
        
        //for(Case cs : listCase){ // this is the loop
        if(listCase.size() > 0){
            system.debug('=====ADA listCase=====');
            Log_Notification__c logNotif = new Log_Notification__c();
            logNotif.Type__c = 'Follow-up Backoffice';
            logNotif.OwnerId = l_group.Id;
            
            newLogNotification.add(logNotif);
        }
        //}
        system.debug('newLogNotification: '+newLogNotification);
        
        if(!newLogNotification.isEmpty()){
            database.insert(newLogNotification,false);
            system.debug('=======INSERT DONE=======');
        }*/
        
        
        //----------------------------------------------------------------------------------------------------------------------
        //----------------------------------------------------------------------------------------------------------------------
        //----------------------------------------------------------------------------------------------------------------------
        
        
        /* ***** NEW *****
         *
		 */
        List<Log_Notification__c> newLogNotification = new List<Log_Notification__c>();
        List<Case> listCase = (List<Case>) scope;
        
        //LEADER CCC in Custom Label
        String LEADER_CCC = Label.LEADER_CCC;
        System.debug('LEADER_CCC (custom label): '+LEADER_CCC);
        List<String> leaderCCCList = LEADER_CCC.split(';');
        System.debug('leaderCCCList: '+leaderCCCList);
        Integer manyRecord = 0;
        List<String> OwnerCaseBackoffice_list = new List<String>();
        
        if(listCase.size() > 0 && listCase != null){
            for(String str : leaderCCCList){
                //OwnerCaseBackoffice_list.add('%'+str.trim()+'%');
                OwnerCaseBackoffice_list.add(str.trim());
            }
            System.debug('LeadCCC_list: '+OwnerCaseBackoffice_list);
            
            //Add Owner Name (backoffice) in Case
            /*for(Case cs : listCase){
                //OwnerCaseBackoffice_list.add('%'+cs.Owner.Name+'%');
				OwnerCaseEmailNoReply_list.add(cs.Agent_Queue_ID_Log_Notification__c);
            }*/
            System.debug('OwnerCaseBackoffice_list: '+OwnerCaseBackoffice_list);
        }
        
        Set<String> AddOwnerLogNotification_list = new Set<String>();
        if(OwnerCaseBackoffice_list.size() > 0 && OwnerCaseBackoffice_list != null){
            AddOwnerLogNotification_list.addAll(OwnerCaseBackoffice_list);
        }
        System.debug('AddOwnerLogNotification_list: '+AddOwnerLogNotification_list);
        
        /*List<Group> l_group = [SELECT Id FROM Group WHERE Type = 'Queue' AND NAME LIKE: AddOwnerLogNotification_list];
        System.debug('l_group: '+l_group);
        
        if(listCase.size() > 0 && listCase != null){
            if(l_group.size() > 0 && l_group != null){
                for(Group gr : l_group){
                    system.debug('=====ADA listCase=====');
                    Log_Notification__c logNotif = new Log_Notification__c();
                    logNotif.Size__c = listCase.size();
                    logNotif.Type__c = 'Follow-up Backoffice';
                    logNotif.OwnerId = gr.Id;
                    
                    newLogNotification.add(logNotif);
                }
            }
        }
        system.debug('newLogNotification: '+newLogNotification);*/
        
        
        if(listCase.size() > 0 && listCase != null){
            for(String ownerLogNotif : AddOwnerLogNotification_list){
                system.debug('=====ADA listCase=====');
                Log_Notification__c logNotif = new Log_Notification__c();
                logNotif.Size__c = listCase.size();
                logNotif.Type__c = 'Follow-up Backoffice';
                logNotif.OwnerId = ownerLogNotif;
                
                newLogNotification.add(logNotif);
            }
        }
        system.debug('newLogNotification: '+newLogNotification);
        
        if(!newLogNotification.isEmpty()){
            database.insert(newLogNotification,false);
            system.debug('=======INSERT DONE=======');
        }
        
    }
    
    
    global void finish(Database.BatchableContext BC) {
          
    }
}