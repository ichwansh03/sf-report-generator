trigger CreateCampaignRetry on Call_List__c (before update) {
    Map<String, String> campaignMap = new Map<String, String>();
    //List<Call_List__c> CampaignList = [SELECT Id, Entity__c, Campaign_Name__c, Case_Type_Config__c, Activity__c FROM Call_List__c WHERE IsExpired__c = true];
    //List<Call_Line__c> calList = [SELECT Id, Entity__c, Total_Uncontacted_New__c, Call_List__r.IsExpired__c FROM Call_Line__c WHERE Activity_Result__c = 'Uncontacted' AND Call_List__r.IsExpired__c = true];
    List<Call_List__c> newCampaignList = new List<Call_List__c>();
    List<Call_Line__c> newCallLine = new List<Call_Line__c>();
    string totalRetryAFI = System.label.Total_Campaign_Retry_AFI;
    string totalRetryAMFS = System.label.Total_Campaign_Retry_AMFS;
    string totalRetryMAGI = System.label.Total_Campaign_Retry_MAGI;
    User userObj = [select id, Entity__c from user where id = :UserInfo.getUserId()];
    string entity = userObj.Entity__c;
    String recordIdAMFS = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
    
    for(Call_List__c currentCampaign : trigger.new){
        Call_List__c oldCampaignMap = Trigger.oldMap.get(currentCampaign.Id);
        
        if (currentCampaign.IsExpired__c == TRUE && entity != 'ALI' && currentCampaign.RecordTypeId != recordIdAMFS) {     //if (currentCampaign.IsExpired__c != oldCampaignMap.IsExpired__c) {
            Call_List__c newCampaign = new Call_List__c();
            newCampaign.Campaign_Name__c = currentCampaign.Campaign_Name__c+'_Retry';
            //newCampaign.Activity_Config__c = currentCampaign.Activity_Config__c;
            newCampaign.Activity__c = currentCampaign.Activity__c;
            newCampaign.Case_Type_Config__c = currentCampaign.Case_Type_Config__c;
            newCampaign.IsExpired__c = false;
            newCampaign.Expired_Date__c = system.today() + 3;
            newCampaignList.add(newCampaign);
        }
    }
    if(newCampaignList.size() > 0){
        insert newCampaignList;
    }
    
    for(Call_List__c clist : newCampaignList){
        if(clist.Id != null){
            if(!campaignMap.containsKey(clist.Id)){
                campaignMap.put(clist.id, clist.id);
            }
        }
    }
    
    //List<Call_Line__c> calList = [SELECT Id, Entity__c, Total_Uncontacted_New__c, Call_List__r.IsExpired__c FROM Call_Line__c WHERE Call_Status_Config__c = 'Uncontacted' AND Call_List__c IN :campaignMap.keySet()];
    List<Call_Line__c> calList = [SELECT Id, Entity__c, Total_Uncontacted_New__c, Call_List__r.IsExpired__c FROM Call_Line__c WHERE Call_Status_Config__c = 'Uncontacted' AND Call_List__c in :trigger.new AND Entity__c = :entity AND createddate > 2015-03-01T23:59:59Z];
    
    for(string newCampaignid : campaignMap.keySet()){
        for(Call_Line__c cll : calList){
            //if((cll.Entity__c == 'AFI' && cll.Total_Uncontacted_New__c < 2) || (cll.Entity__c == 'AMFS' && cll.Total_Uncontacted_New__c < 3)){
            if((cll.Entity__c == 'AFI' && cll.Total_Uncontacted_New__c < integer.valueOf(totalRetryAFI)) || (cll.Entity__c == 'AMFS' && cll.Total_Uncontacted_New__c < integer.valueOf(totalRetryAMFS)) || (cll.Entity__c == 'MAGI' && cll.Total_Uncontacted_New__c < integer.valueOf(totalRetryMAGI))){    
                Call_Line__c call = new Call_Line__c();
                call.Id = cll.Id;
                //call.Call_List__c = cll.Call_List__c;
                call.Call_List__c = newCampaignid;
                newCallLine.add(call);
            }
        }   
    }
    update newCallLine;
}