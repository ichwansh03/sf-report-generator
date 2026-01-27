trigger setSurveyID on Call_List__c (before update, before insert) {
    Map<string,string> campaingMap = new Map<string,string>();
    Map<string,string> surveyMap = new Map<string,string>();
    //Map<string,string> userMap = new Map<string,string>();
    for(Call_List__c campaign : system.trigger.new){
        if(campaign.Activity__c == 'Survey'){
            campaingMap.put(campaign.id, campaign.Case_Type__c);
            if(!surveyMap.containsKey(campaign.Case_Type__c)){
                surveyMap.put(campaign.Case_Type__c, campaign.Case_Type__c);   
            }
        }
        system.debug('##>> createdby : '+campaign.createdbyid);
        //if(!userMap.containsKey(campaign.createdbyid)){
        //    userMap.put(campaign.createdbyid,campaign.createdbyid);
        //}        
    }
    //Survey_ID__c
    List<Survey__c> surveyList = [select id, name from Survey__c where name in :surveyMap.keySet()];
    Map<string,string> surveyNameMap = new Map<string,string>();
    for(Survey__c survey : surveyList){
        surveyNameMap.put(survey.name, survey.id);   
    }
    //User
    //List<User> userList = [select id, Entity__c from User where id in :userMap.keySet()];
    //Map<string,string> userEntityMap = new Map<string,string>();
    //for(User usr : userList){
    //    userEntityMap.put(usr.id, usr.Entity__c);   
    //}
    
    for(Call_List__c campaign : system.trigger.new){
        if(campaign.Activity__c == 'Survey'){
            campaign.Survey_ID__c = surveyNameMap.get(campaign.Case_Type__c);    
        }
        //campaign.Entity__c = userEntityMap.get(campaign.createdbyid);        
    }
}