global class Batch_DistributeAuto_CallLineALI implements Database.Batchable<sObject>, Database.Stateful{

	public List <Agent_Distribution_History__c> finalListAdhFinal = new List<Agent_Distribution_History__c>();
    public List <Call_Line__c> callLineListFinal = new List<Call_Line__c>();
    public Map<Id,Decimal> mapAA = new Map<Id,Decimal>();
    public Map<Id,Agent_Distribution_History__c> mapAgentHistory = new Map<Id,Agent_Distribution_History__c>();
    public String choosen_campaign;

    global Batch_DistributeAuto_CallLineALI(List<Call_Line__c> callLineList){
        this.callLineListFinal = callLineList;
    }
    
    global List<Call_Line__c> start(Database.BatchableContext BC) {
        return callLineListFinal;
    }
    
    global void execute(Database.BatchableContext BC, List<Call_Line__c> scope){
        
        List<Agent_Distribution_History__c> upsertAdhFinal = new list<Agent_Distribution_History__c>();
        
        string surveyURL = '';
        List<Call_Line__c> tosaveCallLineList = new List<Call_Line__c>();  //added by WK, 20150417
        Call_Line__c tosaveCallLine = null; //added by WK, 20150417
        
        for(Call_Line__c dis : scope){
            dis.ownerId = dis.Agent__c;
            if(dis.Agent__c!=null){
                tosaveCallLine = new Call_Line__c();
                tosaveCallLine.id = dis.id;
                tosaveCallLine.Agent__c = dis.Agent__c;
                tosaveCallLine.ownerId = dis.Agent__c;
                tosaveCallLineList.add(tosaveCallLine); 
            }
        }
        
        Set<call_line__c> myset = new Set<call_line__c>();
        List<call_line__c> result = new List<call_line__c>();
        myset.addAll(tosaveCallLineList);
        result.addAll(myset);
        
        if(test.isRunningTest()==false) update result;
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}