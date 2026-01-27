global class Batch_DistributeManual_CallLineALI implements Database.Batchable<sObject>, Database.Stateful{

	public List <Agent_Distribution_History__c> finalListAdhFinal = new List<Agent_Distribution_History__c>();
    public List <Call_Line__c> callLineListFinal = new List<Call_Line__c>();
    public Map<Id,Agent_Distribution_History__c> mapAgentHistory = new Map<Id,Agent_Distribution_History__c>();
    public String choosen_campaign;
    public Map<Id, string> setAgentMap = new Map<Id,string>();

    global Batch_DistributeManual_CallLineALI(List<Call_Line__c> callLineList,Map<Id, string> setAgentMap){
        this.callLineListFinal = callLineList;
        this.setAgentMap = setAgentMap;
    }
    
    global List<Call_Line__c> start(Database.BatchableContext BC) {
        return callLineListFinal;
    }
    
    global void execute(Database.BatchableContext BC, List<Call_Line__c> scope){
		system.debug('***Call Line List Size: '+callLineListFinal.size());
        system.debug('***scope: '+scope);
        system.debug('***setAgentMap: '+setAgentMap);
        system.debug('***setAgentMap (Size): '+setAgentMap.size());
        
        List<Agent_Distribution_History__c> upsertAdhFinal = new list<Agent_Distribution_History__c>();
        
        string surveyURL = '';
        List<Call_Line__c> tosaveCallLineList = new List<Call_Line__c>();  //added by WK, 20150417
        Call_Line__c tosaveCallLine = null; //added by WK, 20150417
        
        integer k=0;
        system.debug('k: '+k);
        Map<Id,Decimal> mapAA = new Map<Id,Decimal>();
        for(Call_Line__c dis : scope){
            system.debug('==============');
            system.debug('Call Line ('+k+'): '+dis.Id);
            system.debug('==============');
            system.debug('k (2): '+k);
            system.debug('dis.Agent__c (old): '+dis.Agent__c);
            dis.Agent__c = setAgentMap.get(dis.Id);
            system.debug('dis.Agent__c (update): '+dis.Agent__c);
            dis.ownerId = dis.Agent__c;
            system.debug('dis.ownerId: '+dis.ownerId);
            
            if(dis.Agent__c!=null){
                tosaveCallLine = new Call_Line__c();
                tosaveCallLine.id = dis.id;
                tosaveCallLine.Agent__c = dis.Agent__c;
                tosaveCallLine.ownerId = dis.Agent__c;
                //tosaveCallLine.survey_url__c = dis.survey_url__c;
                tosaveCallLineList.add(tosaveCallLine);
            }
            k++;
            system.debug('k (3): '+k);
        }
        
        system.debug('tosaveCallLineList: '+tosaveCallLineList);
        Set<call_line__c> myset = new Set<call_line__c>();
        List<call_line__c> result = new List<call_line__c>();
        myset.addAll(tosaveCallLineList);
        system.debug('myset: '+myset);
        result.addAll(myset);
        system.debug('result: '+result);
        
        if(test.isRunningTest()==false) update result; system.debug('DONE Update Call Line (Manual).');
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}