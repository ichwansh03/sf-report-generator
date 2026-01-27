global class SchPopUpEmailNotReply implements Database.Batchable<sObject>,Database.Stateful {
	global List<Case> start(Database.BatchableContext BC) {
    	/**** QUERY CASE ****/
        List<Case> scope = new List<Case>();
        scope.addAll([SELECT Id, CaseNumber, Entity_Backup__c, First_Queue__c, First_Queue_ID__c, Non_Active_Queue_Name__c, Agent_Queue_ID_Log_Notification__c, Owner.Name, OwnerId, CreatedDate FROM Case 
                      WHERE isClosed = FALSE AND (Entity_Backup__c = 'AFI' OR Entity_Backup__c = 'ALI' ) AND Origin = 'Email' AND Type = 'Inquiry' AND Email_Status__c != 'Replied' AND (NOT Owner.Name LIKE '%Queue%') AND OwnerId IN (SELECT Id FROM User WHERE Agent__c = TRUE AND is_Backoffice__c = FALSE) AND Agent_Queue_ID_Log_Notification__c != null AND HOUR_IN_DAY(LastModifiedDate) > 3 ORDER BY CreatedDate ASC LIMIT 50000]);
        system.debug('scope: '+scope);
        
        return scope; 
    }
    
    
    global void execute(Database.BatchableContext BC, List<Case> scope) {
        /* ***** OLD *****
         * 
         *List<Log_Notification__c> newLogNotification = new List<Log_Notification__c>();
        List<Case> listCase = (List<Case>) scope;
        
        //Group l_group = [SELECT Id, Name, DeveloperName, Type from GROUP WHERE Type = 'Queue' AND Name = 'AFI - CCC Queue'];
        system.debug('listCase (Size): '+listCase.size());
        
        List<String> OwnerCaseEmailNoReply_list = new List<String>();
        for(Case cs : listCase){
            OwnerCaseEmailNoReply_list.add('%'+cs.Owner.Name+'%');
        }
        
        List<Group> l_group = [SELECT Id FROM Group WHERE Type = 'Queue' AND NAME LIKE: OwnerCaseEmailNoReply_list];
        System.debug('l_group: '+l_group);
        
        if(listCase.size() > 0 && listCase != null){
            for(Case cs : listCase){ // this is the loop
                for(Group gr : l_group){
                    system.debug('=====ADA listCase=====');
                    Log_Notification__c logNotif = new Log_Notification__c();
                    logNotif.Size__c = listCase.size();
                    logNotif.Name__c = 'Email Not Reply with-in 3 hours';
                    logNotif.OwnerId = gr.Id;
                    
                    newLogNotification.add(logNotif);
                }
            }
        }
        system.debug('newLogNotification: '+newLogNotification);
        system.debug('newLogNotification (Size): '+newLogNotification.size());
        
        if(!newLogNotification.isEmpty()){
            insert newLogNotification;
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
        List<String> OwnerCaseEmailNoReply_list = new List<String>();
        
        if(listCase.size() > 0 && listCase != null){
            for(String str : leaderCCCList){
                //OwnerCaseEmailNoReply_list.add('%'+str.trim()+'%');
                OwnerCaseEmailNoReply_list.add(str.trim());
            }
            System.debug('LeadCCC_list: '+OwnerCaseEmailNoReply_list);
            
            //Add Owner Name (backoffice) in Case
            for(Case cs : listCase){
                //OwnerCaseEmailNoReply_list.add('%'+cs.Owner.Name+'%');
                OwnerCaseEmailNoReply_list.add(cs.Agent_Queue_ID_Log_Notification__c);
            }
            System.debug('OwnerCaseEmailNoReply_list: '+OwnerCaseEmailNoReply_list);
        }
        
        Set<String> AddOwnerLogNotification_list = new Set<String>();
        if(OwnerCaseEmailNoReply_list.size() > 0 && OwnerCaseEmailNoReply_list != null){
            AddOwnerLogNotification_list.addAll(OwnerCaseEmailNoReply_list);
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
                    logNotif.Type__c = 'Email No Reply with-in 3 hours';
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
                logNotif.Type__c = 'Email No Reply with-in 3 hours';
                logNotif.OwnerId = ownerLogNotif;
                
                newLogNotification.add(logNotif);
            }
        }
        system.debug('newLogNotification: '+newLogNotification);
        
        if(!newLogNotification.isEmpty()){
            insert newLogNotification;
            system.debug('=======INSERT DONE=======');
        }
    }
    
    
    global void finish(Database.BatchableContext BC) {
          
    }
}