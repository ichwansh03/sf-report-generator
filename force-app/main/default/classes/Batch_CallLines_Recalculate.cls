global class Batch_CallLines_Recalculate implements Database.Batchable<sobject>{
    Public List<Call_Line__c> newCall {get; set;}
    Public List<Call_Line__c> oldCall {get; set;}
    Boolean finished = false;
    
    global Batch_CallLines_Recalculate(List<Call_Line__c> newList, List<Call_Line__c> oldList){
        newCall = newList;
        oldCall = oldList;
    }
    
    global List<Call_Line__c> start(Database.BatchableContext bc){
        return newCall;
    }
    
    global void execute(Database.BatchableContext bc, List<Call_Line__c> scope){
        Map<String,Decimal> mapCallOld = new Map<String,Decimal>();
        Map<String,Decimal> mapCallNew = new Map<String,Decimal>();
        Set<String> setAgent = new Set<String>();
        
        //Loop call line lama
        for (Call_Line__c oldCl : oldCall){
            setAgent.add(oldCl.OwnerId);
            Decimal tempAmount = 0;
            Decimal oldApeConvert = 0;
            Decimal oldApe = 0;
            if(mapCallOld.containsKey(oldCl.OwnerId)){
                if (oldCl.APE_Convert__c != null){
                    oldApeConvert = oldCl.APE_Convert__c;
                }
                if (mapCallOld.get(oldCl.OwnerId) != null){
                    oldApe = mapCallOld.get(oldCl.OwnerId);
                }
                tempAmount = oldApe + oldApeConvert;
            }
            else {
                mapCallOld.put(oldCl.OwnerId,oldCl.APE_Convert__c);
            }
        }
        
        //Loop call line baru
        for (Call_Line__c newCl : newCall){
            setAgent.add(newCl.OwnerId);
            Decimal tempAmount = 0;
            Decimal newApeConvert = 0;
            Decimal newApe = 0;
            if(mapCallNew.containsKey(newCl.OwnerId)){
                if (newCl.APE_Convert__c != null){
                    newApeConvert = newCl.APE_Convert__c;
                }
                if (mapCallNew.get(newCl.OwnerId) != null){
                    newApe = mapCallNew.get(newCl.OwnerId);
                }
                tempAmount = newApe + newApeConvert;
            }
            else {
                mapCallNew.put(newCl.OwnerId,newCl.APE_Convert__c);
            }
        }
        
        String campaignId = oldCall[0].Call_List__c;
        List<Agent_Distribution_History__c> listAdh = [SELECT Id,Campaign__c,User_Detail__r.User__c,User_Detail__c,Amount__c FROM Agent_Distribution_History__c WHERE User_Detail__r.User__c IN :setAgent AND Campaign__c = :campaignId];
        //Loop agent
        List<Agent_Distribution_History__c> adhToUpdate = new list<Agent_Distribution_History__c>();
        for (Agent_Distribution_History__c adh : listAdh){
            if (mapCallOld.containsKey(adh.User_Detail__r.User__c)){
                adh.Amount__c = adh.Amount__c - mapCallOld.get(adh.User_Detail__r.User__c);
                adhToUpdate.add(adh);
            }
            if (mapCallNew.containsKey(adh.User_Detail__r.User__c)){
                adh.Amount__c = adh.Amount__c + mapCallNew.get(adh.User_Detail__r.User__c);
                adhToUpdate.add(adh);
            }
        }
        if (adhToUpdate.size() > 0) update adhToUpdate;
    }
    
    Public void finish(Database.BatchableContext bc){ 
        System.debug('Process Update Telah Selesai');
        finished = true;
    }
}