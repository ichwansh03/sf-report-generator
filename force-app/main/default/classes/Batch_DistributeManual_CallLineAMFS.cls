global class Batch_DistributeManual_CallLineAMFS implements Database.Batchable<sObject>, Database.Stateful{

	public List <Agent_Distribution_History__c> finalListAdhFinal = new List<Agent_Distribution_History__c>();
    public List <Call_Line__c> callLineListFinal = new List<Call_Line__c>();
    public Map<Id,Agent_Distribution_History__c> mapAgentHistory = new Map<Id,Agent_Distribution_History__c>();
    public String choosen_campaign;
    public Map<integer, string> agentOrderMap = new Map<integer,string>();

    global Batch_DistributeManual_CallLineAMFS(List<Agent_Distribution_History__c> finalListAdh,List<Call_Line__c> callLineList,Map<integer, string> agentOrderMap,Map<Id,Agent_Distribution_History__c> mapAgentHistory,String choosen_campaign){
        this.callLineListFinal = callLineList;
    	this.finalListAdhFinal = finalListAdh;   
        this.mapAgentHistory = mapAgentHistory;
        this.choosen_campaign = choosen_campaign;
        this.agentOrderMap = agentOrderMap;
    }
    
    global List<Call_Line__c> start(Database.BatchableContext BC) {
        return callLineListFinal;
    }
    
    global void execute(Database.BatchableContext BC, List<Call_Line__c> scope){
		system.debug('***Call Line List Size: '+callLineListFinal.size());
        system.debug('***Final List ADH Size: '+finalListAdhFinal.size());
        system.debug('***Map Agent History: '+mapAgentHistory.size());
        system.debug('***Choosen Campaign: '+choosen_campaign);
        
        List<Agent_Distribution_History__c> upsertAdhFinal = new list<Agent_Distribution_History__c>();
        
        string surveyURL = '';
        List<Call_Line__c> tosaveCallLineList = new List<Call_Line__c>();  //added by WK, 20150417
        Call_Line__c tosaveCallLine = null; //added by WK, 20150417
        
        integer k=0;
            Map<Id,Decimal> mapAA = new Map<Id,Decimal>();
            for(Call_Line__c dis : scope){
                dis.Agent__c = agentOrderMap.get(k);
                dis.ownerId = dis.Agent__c;

                if(mapAA.containsKey(dis.Agent__c)){
                	Decimal tempTotal = mapAA.get(dis.Agent__c) + dis.APE_Total_Child__c;	
                    mapAA.put(dis.Agent__c, tempTotal);
                }
                else {
                	mapAA.put(dis.Agent__c, dis.APE_Total_Child__c);        
                }
                
                if(dis.Agent__c!=null){
                    tosaveCallLine = new Call_Line__c();
                    tosaveCallLine.id = dis.id;
                    tosaveCallLine.Agent__c = dis.Agent__c;
                    tosaveCallLine.ownerId = dis.Agent__c;
                    //tosaveCallLine.survey_url__c = dis.survey_url__c;
                    tosaveCallLineList.add(tosaveCallLine);
                }
                k++;
            }
            
            for (Agent_Distribution_History__c adh : finalListAdhFinal){ 
                Agent_Distribution_History__c tosaveAdh = new Agent_Distribution_History__c();
                tosaveAdh.External_Key__c = adh.External_Key__c;
                if (mapAA.get(adh.User_Detail__r.User__c) != null){
                    tosaveAdh.User_Detail__c = mapAgentHistory.get(adh.User_Detail__r.User__c).User_Detail__c;
                    if (adh.Amount__c == NULL) adh.Amount__c = 0;  tosaveAdh.Amount__c = adh.Amount__c + mapAA.get(adh.User_Detail__r.User__c);
                    tosaveAdh.Campaign__c = choosen_campaign;
                    upsertAdhFinal.add(tosaveAdh);        
                }
                else {
                    tosaveAdh.Amount__c = 0;
                }
            }
            upsert upsertAdhFinal External_Key__c;
        
        Set<call_line__c> myset = new Set<call_line__c>();
        List<call_line__c> result = new List<call_line__c>();
        myset.addAll(tosaveCallLineList);
        result.addAll(myset);
        
        if(test.isRunningTest()==false) update result;
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}