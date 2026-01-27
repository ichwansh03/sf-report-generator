global class Purecloud_GetSurveyResult_Batch implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
	global String query;
    
    global Purecloud_GetSurveyResult_Batch(String q) {
        this.query = q;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug(LoggingLevel.DEBUG, '***QUERY BATCH: ' + query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Task> scope){
     	List <Task> updateTaskSurveyWithoutDuplicates = new List<Task>();
        List<Task> updatedTask = new List<Task>();
        
        For (Task tk : scope){
            Task updateTask = new Task();
            updateTask.Id = tk.id;
            System.debug(tk);
            
        	String url = Label.API_Purecloud+'api/v2/conversations/'+tk.CallObject;
            String clientid = Label.Purecloud_ClientId;
            String clientSecret = Label.Purecloud_ClientSecret;
            String token = [SELECT Access_token__c FROM Purecloud_Connector__c WHERE Name ='Purecloud Token' LIMIT 1].Access_token__c;
            system.debug(LoggingLevel.DEBUG,'*url*'+url);
            system.debug('TOKEN ==>'+token); 
            
             	Http h = new Http();
                HttpRequest req = new HttpRequest();
                req.setEndpoint(url);
                req.setMethod('GET');
                req.setTimeout(120000);
                req.setHeader('content-type', 'application/json');
                req.setHeader('Authorization', 'Bearer '+ token);
            
            	 	try{
                    HttpResponse res = new HttpResponse();
                    res = h.send(req);
                        system.debug('*res ==>*'+res);
        
                        String parser;
                        parser = res.getBody();
                        system.debug('*body ==>*'+parser);
                        
                        //Get survey value from IVR
                        //Level 1 -- PARTICIPANTS
                            Map<String, Object> MapLv1 = (Map<String, Object>) JSON.deserializeUntyped(parser);
                            system.debug('MapLv1 Conversation Summary ==>'+MapLv1);
                            
                            String temp;
                            List<Object> arrayConversationSummary = new list <Object>(); 
                            List<Object> arrayConversationPurpose = new list <Object>();
                            for(Object o : (List<Object>)Maplv1.get('participants')){
                                Map<String, Object> keyMap = (Map<String, Object>)o;
                                temp = (String)keyMap.get('userId');
                                String responseParticipantId = (String)keyMap.get('id');
                                String purposeResponse = (String)KeyMap.get('purpose');
                                
                                if (purposeResponse == 'customer') {
                                    arrayConversationPurpose.add(o);
                                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q1Answer=Yes')) updateTask.PureCloud_Question1__c = 'Yes';
                                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q1Answer=No')) updateTask.PureCloud_Question1__c = 'Yes';
                                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q1Answer=No Response')) updateTask.PureCloud_Question1__c = 'No Response';
                                    
                                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q2Answer=Yes')) updateTask.PureCloud_Question2__c = 'Yes'; 
                                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q2Answer=No')) updateTask.PureCloud_Question2__c = 'No';
                                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q2Answer=No Response')) updateTask.PureCloud_Question2__c = 'No Response'; 
                                    
                                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q3Answer=Yes')) updateTask.PureCloud_Question3__c = 'Yes'; 
                                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q3Answer=No')) updateTask.PureCloud_Question3__c = 'No';
                                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q3Answer=No Response')) updateTask.PureCloud_Question3__c = 'No Response'; 
                                    
                                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q4Answer=Yes')) updateTask.PureCloud_Question4__c = 'Yes'; 
                                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q4Answer=No')) updateTask.PureCloud_Question4__c = 'No';
                                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q4Answer=No Response')) updateTask.PureCloud_Question4__c = 'No Response'; 
                                    
                                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q5Answer=Yes')) updateTask.PureCloud_Question5__c = 'Yes'; 
                                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q5Answer=No')) updateTask.PureCloud_Question5__c = 'No';
                                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q5Answer=No Response')) updateTask.PureCloud_Question5__c = 'No Response'; 
                                }
                            }
                        	updateTask.API_Status__c = 'Okay';
                        	updateTask.Running_By__c = 'Scheduler';
                        	updatedTask.add(updateTask);
                        	//Update updateTask;
                    }
            	
            	catch(exception e){
                        system.debug('*error*'+e);
                    	updateTask.API_Status__c = 'Error: ' + e;
                    	updateTask.Running_By__c = 'Scheduler';
                    	updatedTask.add(updateTask);
                    	//update updateTask;
				}
        }
        	Set<Task> myset = new Set<Task>(); 
        	System.debug('list updatedtask: ' + updatedTask);
            myset.addAll(updatedTask);
       	 	System.debug('set myset: ' + mySet);
            updateTaskSurveyWithoutDuplicates.addAll(myset);
        	System.debug('list updatedtasksurveywithoutduplicates: ' + updateTaskSurveyWithoutDuplicates);
        	
        	Update updateTaskSurveyWithoutDuplicates;
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}