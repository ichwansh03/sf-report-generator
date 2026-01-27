trigger validationGroup_trigger on WelcomeCall_Group__c (Before insert, before Update) {
    Public String criteriagroup{get;set;}
    Public String idgroup{get;set;}
    Public String namegroup{get;set;}
    for(WelcomeCall_Group__c  i:trigger.new) {
        idgroup = i.Id;
        criteriagroup = i.WelcomeCall_Criteria__c;
        System.debug('criteriagroup'+ criteriagroup);
    }
    if(Trigger.isBefore && Trigger.isInsert){
        System.debug('before insert');
        List<WelcomeCall_Criteria__c> criteria =[select id, name from WelcomeCall_Criteria__c where name = :trigger.new[0].WelcomeCall_Criteria__c];
        List<WelcomeCall_Group__c> wgroup =[select id, name, WelcomeCall_Criteria__c from WelcomeCall_Group__c where WelcomeCall_Criteria__c = :trigger.new[0].WelcomeCall_Criteria__c];
        System.debug('criteria : '+criteria);
        if(criteria.isEmpty()){
            Trigger.New[0].WelcomeCall_Criteria__c.addError('Criteria does not exists');
        }
        if(!wgroup.isEmpty()){
            Trigger.New[0].WelcomeCall_Criteria__c.addError('Criteria already assign into other group, pick another one!');
        }
    }
    else if(Trigger.isBefore && Trigger.isUpdate){
        System.debug('before update');
        recordtype rectype = [select id, name from recordtype where name= 'Agent Group'];
        List<Agent_Group__c> ag = [select WelcomeCall_Priority__c from Agent_Group__c where recordtypeid = :rectype.id 
                                   and WelcomeCall_Priority__c =:trigger.new[0].WelcomeCall_Last_Priority__c
                                  and WelcomeCall_Group__c =: trigger.new[0].Id ];
        WelcomeCall_Group__c welgp = [select id, name, WelcomeCall_Last_Priority__c, WelcomeCall_Entity__c from WelcomeCall_Group__c where id= :trigger.new[0].id];
        List<WelcomeCall_Criteria__c> criteria =[select id, name from WelcomeCall_Criteria__c where name = :trigger.new[0].WelcomeCall_Criteria__c];
        List<Agent_Group__c > checkEntity = [select id, name, WelcomeCall_Group__r.name, WelcomeCall_Group__c from Agent_Group__c 
                                             where WelcomeCall_Group__c = :trigger.new[0].id];
        if(!checkEntity.isEmpty() && welgp.WelcomeCall_Entity__c != trigger.new[0].WelcomeCall_Entity__c){
            Trigger.New[0].WelcomeCall_Entity__c.addError('Entity can not change where group has agent!');
        }
        if(criteria.isEmpty()){
            Trigger.New[0].WelcomeCall_Criteria__c.addError('Criteria does not exists');
        }
        System.debug('welgp.WelcomeCall_Criteria__c' +welgp.WelcomeCall_Last_Priority__c );
        System.debug('welgp.WelcomeCall_Last_Priority__c ' +trigger.new[0].WelcomeCall_Last_Priority__c);
        if(welgp.WelcomeCall_Last_Priority__c != trigger.new[0].WelcomeCall_Last_Priority__c){
            if(ag.isEmpty()){
                System.debug('Group '+trigger.new[0].Name+' '+trigger.new[0].WelcomeCall_Last_Priority__c);
                Trigger.New[0].WelcomeCall_Last_Priority__c.addError('Last Priority does not exists');
            }
        }
    }
    
}