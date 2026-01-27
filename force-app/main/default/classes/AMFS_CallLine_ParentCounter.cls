global class AMFS_CallLine_ParentCounter implements Database.Batchable<Call_Line__c> {
  Public string choosenCampaign;
  Public string userId;
  public List <Call_Line__c> callLineListFinal = new List<Call_Line__c>();
    
  global AMFS_CallLine_ParentCounter(String choosenCampaign, String userId,List<Call_Line__c> callLineListFinal) {
        this.choosenCampaign = choosenCampaign;
      	this.userId = userId;
      	this.callLineListFinal = callLineListFinal;
  }
  
  global List<Call_Line__c> start(Database.BatchableContext BS) {
        return callLineListFinal;
  }
    
  global void execute(Database.BatchableContext BS, List<Call_Line__c> scope) {
      	system.debug('***Choosen Campaign: '+choosenCampaign);
      	system.debug('***User Id: '+userId);
      
        String campaignName = [Select id, Campaign_Name__c from Call_List__c where id = :choosenCampaign limit 1].Campaign_Name__c;
        set<Id> setParent = new set<Id>();
        map<Id,Decimal> mapAPE = new map<Id,Decimal>();
        
      	List<Call_Line__c> updateCallLine = new list <Call_Line__c>(); 
        list<Call_Line__c> listCallLine = [SELECT id, Amount__c, Parent_Call_Line__c,APE_Convert__c FROM Call_Line__C WHERE call_list__c = :choosenCampaign AND Parent_Call_Line__c != null AND Createddate = TODAY AND CreatedById = :userId ORDER BY CreatedDate DESC LIMIT 50000];
        system.debug('***List Call Line Size: '+listCallLine.size());
      	for (Call_Line__c x : listCallLine){
            if (x.Parent_Call_Line__c != null) {                
                setParent.add(x.Parent_Call_Line__c);
                    if (mapAPE.containsKey(x.Parent_Call_Line__c) && x.APE_Convert__c != null){
                            Decimal tempAPE = mapAPE.get(x.Parent_Call_Line__c) + x.APE_Convert__c;
                            mapAPE.put(x.Parent_Call_Line__c,tempAPE); 
                    }
                    else {
                            mapAPE.put(x.Parent_Call_Line__c, x.APE_Convert__c);
                    }
            }
        } 

        map<Id,Integer> mapParent = new Map<Id,Integer>();
        list<Call_Line__c> listCallLineParent = [SELECT Id,Amount__c,APE_Convert__c,APE_Total_Child__c,Child_Count__c, Parent_Call_Line__c FROM Call_Line__c WHERE Id in :setParent];
        system.debug('***List Parent Size: '+listCallLineParent.size());
      	for(Call_Line__c x : listCallLine){
            if (mapParent.containsKey(x.Parent_Call_Line__c)){
                Integer countChild = mapParent.get(x.Parent_Call_Line__c) + 1;
                mapParent.put(x.Parent_Call_Line__c, countChild);
            }
            else {
            mapParent.put(x.Parent_Call_Line__c,1);
            }
        }
   
        for (Call_Line__c x : listCallLineParent){
            Call_Line__c newCl = new Call_Line__c();
            newCl.Id = x.Id;
            newCl.Child_Count__c = 0;
                if (mapParent.get(x.Id) != null){
                    newCl.Child_Count__c = mapParent.get(x.Id)+1; //di tambah diri sendiri
                    if (x.APE_Convert__c != null) {
                     	newCl.APE_Total_Child__c = mapAPE.get(x.Id)+ x.APE_Convert__c; //di tambah APE diri sendiri     
                    }  
                }updateCallLine.add(newCl);
        } update updateCallLine;
  	}
    
    global void finish(Database.BatchableContext BC){
        
    }
}