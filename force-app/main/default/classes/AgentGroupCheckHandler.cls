public class AgentGroupCheckHandler {
    Static Id agentRtId = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent').getRecordTypeId();
    String grup {get;set;}
    String entity {get;set;}
    
    
	/*public void before(List<Agent_Group__c> agents){
    }*/
    public void validate(List<Agent_Group__c> agents){
        // populate for agent record
        LIST<Agent_group__c> existingAgent = [Select id, welcomecall_user__c, welcomecall_user__r.name 
                                              from Agent_group__c where recordTypeId =: agentRtId ];
        Map<Id, Agent_group__c> mapAgentUserId = new Map<Id, Agent_group__c>();
        for(Agent_group__c agg : existingAgent){
            mapAgentUserId.put(agg.welcomecall_user__c, agg);
        }
        //=== validation for Agent Record Type ===
        for(Agent_Group__c agent : agents){
            if(agent.RecordTypeId == agentRtId){
                Agent_group__c existAgent =mapAgentUserId.get(agent.WelcomeCall_User__c);
                if(existAgent != null && existAgent.Id != agent.Id){
                   agent.addError('Agent with user '+existAgent.welcomecall_user__r.name+' already Exist.');
                }
            }
        }
        //=== validation for Agent Record Type ===

        //=== validation for Agent Group Record Type ===
        Map<Id, WelcomeCall_Group__c> groups = new Map<Id, WelcomeCall_Group__c>([select id, WelcomeCall_Last_Priority__c from WelcomeCall_Group__c]);
        
        //=== validation for Agent Group Record Type ===
        
    }
    //beforeInsert
    public void validateAgentGroup(List<Agent_Group__c> agents){
        //List<User> u = [select id, name, entity__c from user];
        String agentGroupRecord = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent Group').getRecordTypeId();
        
        for(Agent_Group__c agrup : agents){
            WelcomeCall_Group__c wgrup = [select id, name, WelcomeCall_Entity__c from WelcomeCall_Group__c where id = :agrup.WelcomeCall_Group__c];
            Agent_Group__c ag = [Select id, name, WelcomeCall_Priority__c, WelcomeCall_Group__c,WelcomeCall_User__r.entity__c from Agent_Group__c where  id = :agrup.agent__c];
            
            
            if(ag.WelcomeCall_User__r.entity__c != wgrup.WelcomeCall_Entity__c){
                //agrup.addError('entity not match!');
                agrup.agent__c.addError('Can not assign user from different entity');
            }
            List<Agent_Group__c> agrp = [Select id, name, WelcomeCall_Priority__c, WelcomeCall_Group__c from Agent_Group__c where WelcomeCall_Group__c = :agrup.WelcomeCall_Group__c and
                                        WelcomeCall_Priority__c = :agrup.WelcomeCall_Priority__c];
            if(!agrp.isEmpty()){
                agrup.WelcomeCall_Priority__c.addError('Priority already Exist');
            }
            
            System.debug('= :agrup.WelcomeCall_Group__c'+agrup.WelcomeCall_Group__c);
            List<Agent_Group__c> a = [select id, name, WelcomeCall_Group__c, WelcomeCall_Priority__c, recordtypeid from Agent_Group__c 
                                where recordtypeid = :agentGroupRecord and WelcomeCall_Group__c = :agrup.WelcomeCall_Group__c order by WelcomeCall_Priority__c desc Limit 1];
            List<Agent_Group__c> agentList = [select id, name, WelcomeCall_Group__c, WelcomeCall_Priority__c, recordtypeid from Agent_Group__c 
                                where recordtypeid = :agentGroupRecord and agent__c = :agrup.agent__c and WelcomeCall_Group__c = :agrup.WelcomeCall_Group__c];
            if(!agentList.isEmpty()){
                agrup.agent__c.addError('Agent can not assign in one group');
            }
            if(a.isEmpty()){
                agrup.WelcomeCall_Priority__c = 1;
            }
            else{
                System.debug('WelcomeCall_Group__c = :agrup.WelcomeCall_Group__c'+a[0].WelcomeCall_Group__c );
                Integer prioritycount = Integer.valueOf(a[0].WelcomeCall_Priority__c +1);
                System.debug('priority count : ' +prioritycount);
                agrup.WelcomeCall_Priority__c = prioritycount;
            }
        }
        
    }
    
    //before Update
    public void validateUpdate(List<Agent_Group__c> agents){
        //List<User> u = [select id, name, entity__c from user];
        String agentGroupRecord = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent Group').getRecordTypeId();
        
        for(Agent_Group__c agrup : agents){
            WelcomeCall_Group__c wgrup = [select id, name, WelcomeCall_Entity__c from WelcomeCall_Group__c where id = :agrup.WelcomeCall_Group__c];
            Agent_Group__c ag = [Select id, name, WelcomeCall_Priority__c, WelcomeCall_Group__c,WelcomeCall_User__r.entity__c
                                 from Agent_Group__c where  id = :agrup.agent__c];
            
            System.debug('ag '+ag);
            if(ag.WelcomeCall_User__r.entity__c != wgrup.WelcomeCall_Entity__c){
                //agrup.addError('entity not match!');
                agrup.agent__c.addError('Can not assign user from different entity');
            }
            List<Agent_Group__c> agrp = [Select id, name, WelcomeCall_Priority__c, WelcomeCall_Group__c from Agent_Group__c where WelcomeCall_Group__c = :agrup.WelcomeCall_Group__c and
                                        WelcomeCall_Priority__c = :agrup.WelcomeCall_Priority__c and id!=:agrup.id];
            if(!agrp.isEmpty()){
                agrup.WelcomeCall_Priority__c.addError('Priority already Exist');
            }
            List<Agent_Group__c> othersAgentGrp = [select id, name, WelcomeCall_Group__c, WelcomeCall_Priority__c, recordtypeid from Agent_Group__c 
                                where recordtypeid = :agentGroupRecord and id != :agrup.id and WelcomeCall_Group__c = :agrup.WelcomeCall_Group__c
                                order by WelcomeCall_Priority__c desc Limit 1];
            Agent_Group__c gr = [select id, name, WelcomeCall_Group__c, WelcomeCall_Priority__c, recordtypeid from Agent_Group__c 
                                where recordtypeid = :agentGroupRecord and id = :agrup.id and WelcomeCall_Group__c = :agrup.WelcomeCall_Group__c];

            System.debug('gr: '+gr.WelcomeCall_Priority__c);
            System.debug('agrup.WelcomeCall_Priority__c: '+agrup.WelcomeCall_Priority__c);
            if(gr.WelcomeCall_Priority__c!=agrup.WelcomeCall_Priority__c){
                Decimal prioritycount = 1;
                if(!othersAgentGrp.isEmpty()) prioritycount = othersAgentGrp.get(0).WelcomeCall_Priority__c + 1;
                System.debug('priority count : ' +prioritycount);
                agrup.WelcomeCall_Priority__c = prioritycount;
            }

        }
        
    }
}