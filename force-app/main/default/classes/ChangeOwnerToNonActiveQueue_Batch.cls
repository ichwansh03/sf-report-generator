global class ChangeOwnerToNonActiveQueue_Batch implements Database.Batchable<sObject>,Database.Stateful {
	global List<Case> start(Database.BatchableContext BC) {
    	//String query = 'SELECT Id, CaseNumber, Entity_Backup__c, Owner.Name FROM Case WHERE Origin = \'Email\' AND isClosed = TRUE AND (Entity_Backup__c = \'AFI\' OR Entity_Backup__c = \'ALI\' ) AND (Owner.Name = \'AFI - Email Agency VIP Queue\' OR Owner.Name = \'AFI - Email Customer VIP Queue\' OR Owner.Name = \'AFI - Email Other Queue\' OR Owner.Name = \'AFI TM - Email Priority Queue\' OR Owner.Name = \'AFI TM - Email Regular Queue\' OR Owner.Name = \'AFI TM - Email Other Queue\' OR Owner.Name = \'AFI - Email Combine Queue\')';
    	//return Database.getQueryLocator(query);
        
        
        /**** QUERY CASE ****/
        List<Case> scope = new List<Case>();
        /* ******* OLD ******* */
        /*scope.addAll([SELECT Id, CaseNumber, Entity_Backup__c, First_Queue__c, First_Queue_ID__c, Non_Active_Queue_Name__c, Owner.Name, CreatedDate FROM Case 
                      WHERE Type = 'Inquiry' AND Origin = 'Email' AND isClosed = FALSE AND (Entity_Backup__c = 'AFI' OR Entity_Backup__c = 'ALI' ) AND (NOT Owner.Name LIKE '%Queue%') ORDER BY CreatedDate ASC LIMIT 50000]);*/
        /* ******* END - OLD ******* */
        
        /*scope.addAll([SELECT Id, CaseNumber, Entity_Backup__c, First_Queue__c, First_Queue_ID__c, Non_Active_Queue_Name__c, Non_Active_Queue_ID__c, Owner.Name, CreatedDate FROM Case 
                      WHERE Type = 'Inquiry' AND Origin = 'Email' AND isClosed = FALSE AND (Entity_Backup__c = 'AFI' OR Entity_Backup__c = 'ALI' ) ORDER BY CreatedDate ASC LIMIT 50000]);*/
        
        /* ******* NEW ******* */
        scope.addAll([SELECT Id, CaseNumber, Entity_Backup__c, First_Queue__c, First_Queue_ID__c, Non_Active_Queue_Name__c, Non_Active_Queue_ID__c, Email_Inbox__c, Owner.Name, CreatedDate FROM Case 
        			WHERE Type = 'Inquiry' AND Origin = 'Email' AND isClosed = FALSE AND (Entity_Backup__c = 'AFI' OR Entity_Backup__c = 'ALI' ) AND (RecordType.Name = 'InquiryAFICase' OR RecordType.Name = 'InquiryALICase') AND CALENDAR_YEAR(CreatedDate) >= 2020 ORDER BY CreatedDate ASC LIMIT 50000]);
        /* ******* END - NEW ******* */
        
        return scope; 
    }
    
    
    global void execute(Database.BatchableContext BC, List<Case> scope) {
        List<Case> listCase = (List<Case>) scope;
        List<Case> updateListCase = new List<Case>();
        Map<String, String> mapQueueName = new Map<String, String>();
        List<String> listQueueName = new List<String>();
        List<String> listCategoryQueue = new List<String>();
        
        //List<Group> l_group = new List<Group>();
        Map<String, String> mapGroup = new Map<String, String>();
        
        /* ******* OLD ******* */
        /*for(Case cs : listCase) {
            if(cs.First_Queue__c != null || cs.First_Queue__c != ''){
                mapQueueName.put(cs.Id, cs.First_Queue__c);
                listQueueName.add(cs.First_Queue__c);
                listCategoryQueue.add(cs.Non_Active_Queue_Name__c);
            }
        }
        system.debug('listQueueName: '+listQueueName);
        system.debug('count listQueueName: '+listQueueName.size());
        system.debug('listCategoryQueue: '+listCategoryQueue);
        
        
        if(listQueueName.size() > 0){
            //l_group = [SELECT Id, Name, DeveloperName, Type from GROUP WHERE Type = 'Queue' AND Name IN: listCategoryQueue];
            
            for(Group gr : [SELECT Id, Name from GROUP WHERE Type = 'Queue' AND Name IN: listCategoryQueue]){
                mapGroup.put(gr.Name, gr.Id);
            }
            system.debug('mapGroup: '+mapGroup);
        }
        
        for(Case cse : listCase){
            if(mapGroup.containsKey(cse.Non_Active_Queue_Name__c)){
                Case caseNew = new Case();
                caseNew.Id = cse.Id;
                caseNew.OwnerId = mapGroup.get(cse.Non_Active_Queue_Name__c);
                
                updateListCase.add(caseNew);
            }
        }
        system.debug('updateListCase: '+updateListCase);*/
        /* ******* END - OLD ******* */
        
        /* ******* NEW ******* */
        if(listCase.size() > 0 && listCase != null){
            for(Case cse : listCase) {
                Case caseNew = new Case();
                caseNew.Id = cse.Id;
                system.debug('cse.Non_Active_Queue_ID__c: '+cse.Non_Active_Queue_ID__c);
                system.debug('cse.Email_Inbox__c: '+cse.Email_Inbox__c);
                
                if(cse.Non_Active_Queue_ID__c != 'Have not Non Active Queue'){
                    caseNew.OwnerId = cse.Non_Active_Queue_ID__c;
                } else if(cse.Non_Active_Queue_ID__c == 'Have not Non Active Queue' && (cse.Email_Inbox__c == null || cse.Email_Inbox__c == '')){
                    caseNew.OwnerId = system.Label.NonActive_CombineQueueID; //---> Queue ID "AFI - Email Non Active Combine Queue"
                } else if(cse.Non_Active_Queue_ID__c == 'Have not Non Active Queue' && cse.Email_Inbox__c == system.Label.CustomerEmail_AFI_ALI){
                    caseNew.OwnerId = system.Label.NonActive_CombineQueueID; //---> Queue ID "AFI - Email Non Active Combine Queue"
                } else if(cse.Non_Active_Queue_ID__c == 'Have not Non Active Queue' && cse.Email_Inbox__c == system.Label.HelplineEmail_AFI_ALI){
                    caseNew.OwnerId = system.Label.NonActive_StandartQueueID; //---> Queue ID "AFI - Email Non Active Standart Queue"
                }
                
                updateListCase.add(caseNew);
            }
        }
        system.debug('updateListCase: '+updateListCase);
        /* ******* END - NEW ******* */
        
        if(updateListCase.size() > 0){
            update updateListCase;
            system.debug('=======UPDATE DONE=======');
        }
    }
    
    
    global void finish(Database.BatchableContext BC) {
          
    }
    
    
    /*global void execute(SchedulableContext sc) {
        //--Call the batch class to be scheduled
        Type t = Type.forName('ChangeOwnerToNonActiveQueue_Batch');
        Database.Batchable<sObject> batchClass = ((Database.Batchable<sObject>) t.newInstance());
        
        //--Parameters of ExecuteBatch(context,BatchSize)
        Database.executeBatch(batchClass, 20);
    }*/
}