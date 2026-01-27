trigger CaseTypeUpdateOnCampaign on Call_List__c (after insert, before update) {
     Set<Id> campaignIds = new Set<Id>();
    
    for(Call_List__c cl : Trigger.new) {
        if(cl.Id != null) {
            campaignIds.add(cl.Id);
        }
    }

    Map<Id, Call_List__c> myCampaign = new Map<Id, Call_List__c> ([Select ID, Case_Type__c, Case_Type_Config__c FROM Call_List__c WHERE Id IN :campaignIds]);
    
    if(Trigger.isAfter){
        for(Call_List__c campaign : Trigger.new) {
            if(campaign.Id != null && myCampaign.containsKey(campaign.Id)){
                myCampaign.get(campaign.Id).Case_Type__c = campaign.Case_Type_Config__c;
            }
        }
        update myCampaign.values();
    }
    
    if(Trigger.isBefore){
        for(Call_List__c callist : Trigger.new) {
            Call_List__c oldCampaign = Trigger.oldMap.get(callist.Id);
            
            if(callist.Case_Type_Config__c != oldCampaign.Case_Type_Config__c){
                callist.Case_Type__c = callist.Case_Type_Config__c;
            }
        }
    }
}