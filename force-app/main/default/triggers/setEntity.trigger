trigger setEntity on Call_List__c (after insert, after update) {
    Map<string,string> campaignMap = new Map<string,string>();
    Map<string,string> userMap = new Map<string,string>();
    String userPublic = System.label.User_Id_Public_Site; // added by Support MII at 6 9 24
    integer idx = 0;
    if(Trigger.isUpdate){
        for(Call_List__c campaign : trigger.new){
            system.debug('##>> createdby : '+campaign.createdbyid);
            if(trigger.old[idx].Entity__c == null 
               && !userMap.containsKey(campaign.createdbyid)
               && campaign.createdbyid != userPublic // added by Support MII at 6 9 24
              ){
                userMap.put(campaign.createdbyid,campaign.createdbyid);
                campaignMap.put(campaign.id, campaign.id);
            }
            idx++;        
        }
    }else if(Trigger.isInsert){
        for(Call_List__c campaign : trigger.new){
            system.debug('##>> createdby : '+campaign.createdbyid);
            if(
                !userMap.containsKey(campaign.createdbyid)
                && campaign.createdbyid != userPublic // added by Support MII at 6 9 24
              ){
                userMap.put(campaign.createdbyid,campaign.createdbyid);
                campaignMap.put(campaign.id, campaign.id);
            }
            idx++;        
        }
    }
    //campaign
    List<Call_List__c> campaignList = [select id, Entity__c, CreatedById from Call_List__c where id in :campaignMap.keySet()];
    
    //User
    List<User> userList = [select id, Entity__c from User where id in :userMap.keySet()];
    Map<string,string> userEntityMap = new Map<string,string>();
    for(User usr : userList){
        userEntityMap.put(usr.id, usr.Entity__c);   
    }
    
    for(Call_List__c campaign : campaignList){
        campaign.Entity__c = userEntityMap.get(campaign.createdbyid);        
    }
    update campaignList;
}