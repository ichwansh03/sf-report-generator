trigger validateSurveyName on Survey__c (before insert, before update) {
    Map<string,string> surveyNameMap = new Map<string,string>();
    for(Survey__c survey : system.trigger.new){
        surveyNameMap.put(survey.Name, survey.id);
    }
    List<Survey__c> surveyList = [select id, name from Survey__c where name in :surveyNameMap.keySet()];
    for(Survey__c survey : system.trigger.new){
        for(Survey__c srvy : surveyList){
            if(survey.Name == srvy.Name){
                survey.Name.addError(survey.Name+' sudah ada. Silahkan pilih nama lain.');    
            }
        }
    }
}