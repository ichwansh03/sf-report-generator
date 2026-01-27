trigger AgentGroupCheck on Agent_Group__c (before insert, before update) {
    String recordtype{get;set;}
    String agentRecord = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent').getRecordTypeId();
    String agentGroupRecord = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent Group').getRecordTypeId();
    for(Agent_Group__c  i:trigger.new) {
        recordtype = i.RecordTypeId;
    }
    if(Trigger.isBefore && Trigger.isInsert){
        if(recordtype == agentRecord){
            AgentGroupCheckHandler agC = new AgentGroupCheckHandler();
            agC.validate(trigger.new);
        }
        else if(recordtype == agentGroupRecord){
            AgentGroupCheckHandler agC = new AgentGroupCheckHandler();
            agc.validateAgentGroup(trigger.new);
        }
    }
    else if(Trigger.isBefore && Trigger.isUpdate){
        if(recordtype == agentRecord){
            AgentGroupCheckHandler agC = new AgentGroupCheckHandler();
            agC.validate(trigger.new);
        }
        else if(recordtype == agentGroupRecord){
            AgentGroupCheckHandler agC = new AgentGroupCheckHandler();
            agc.validateUpdate(trigger.new);
        }
    }
}