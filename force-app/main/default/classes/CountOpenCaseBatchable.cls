global class CountOpenCaseBatchable implements Database.Batchable<sObject>, Database.stateful {
	Set<Id> contactIdList = new Set<Id>();
    List<Call_Line__c> callLineListRM = new List<Call_Line__c>();
    Map<Id,Call_Line__c> updateCallLineMapRM = new Map<Id,Call_Line__c>();
    Map<Integer,List<Call_Line__c>> CallLineMapRM = new Map<Integer,List<Call_Line__c>>();
    
    public countOpenCaseBatchable(Set<Id> contactIdList, List<Call_Line__c> callLineListRM){
        this.contactIdList.addAll(contactIdList);
        this.callLineListRM.addAll(callLineListRM);
    }
    
   global Database.QueryLocator start(Database.BatchableContext BC){
       String query='';
           query = 'SELECT id, contactid, status from Case ' +
					' where contactid in : contactIdList and (not status like \'%Closed%\') order by contactid';
      return Database.getQueryLocator(query);
   }
    global void execute(Database.BatchableContext BC, LIST<Case> scope){
    	Map<Id, Integer> openCases = new Map<Id, Integer>(); 
        for(Case cs : scope){
            Integer count = openCases.get(cs.contactid) == null ? 0 : openCases.get(cs.contactid);
            count = count + 1;
                    
            openCases.put(cs.contactid, count);
        }
        
        for(Call_Line__c cl : callLineListRM){
			cl.Open_Cases__c = openCases.get(cl.Contact__c) == null ? 0 : openCases.get(cl.Contact__c);
            updateCallLineMapRM.put(cl.Id, cl);
        }
        System.debug('callLineListRM '+callLineListRM);
    }
    
    global void finish(Database.BatchableContext BC){   
        populateListintoMap();
        System.debug('CallLineMapRM '+CallLineMapRM.values());
        System.debug('CallLineMapRM size '+CallLineMapRM.size());
        if(CallLineMapRM.size() <= 1 && !CallLineMapRM.isEmpty()){
            update(CallLineMapRM.values().get(0));
        } else {
            for(List<Call_Line__c> listCL : CallLineMapRM.values()){
                System.enqueueJob(new DMLoperationQueueable(listCL, true));
            }
        }
    }
    private void populateListintoMap(){
        try{
            List<Call_Line__c> tempList = new List<Call_line__c>();
            List<Call_Line__c> tempListForMap = new List<Call_line__c>();
            if(!updateCallLineMapRM.isEmpty()){
                System.debug('updateCallLineMapRM size '+updateCallLineMapRM.size());
                tempList = new List<Call_Line__c>(updateCallLineMapRM.values());
            } else {
                for(Call_Line__c cl : callLineListRM){
                    cl.Open_Cases__c = 0;
                }
                tempList = new List<Call_Line__c>(callLineListRM);
            }
            Integer i=1;
            Integer key=1;
            Integer maxCount=1;
            for(Call_Line__c cl : tempList){
                tempListForMap.add(cl);
                if(i == 9990 || i == tempList.size() || maxCount == tempList.size()){
                    CallLineMapRM.put(key, tempListForMap);
                    
                    tempListForMap = new List<Call_Line__c>();
                    key = key +1;
                    i=0;
                }
                i=i+1;
                maxCount = maxCount + 1;
            }
        } catch(exception e){
            System.debug('===ERROR when Count open cases for Call Liner=== '+e);
        }
    }
}