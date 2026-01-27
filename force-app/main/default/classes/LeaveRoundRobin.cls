/***************************************************************************************
*    Class Name: LeaveRoundRobin
*	 Description: This class can be called using Scheduler or manual. It will distribute agent on leave in a specific date.
*    Author: Ocky Harliansyah
*	 Email: ocky.harliansyah@phincon.com | ocky.harli@gmail.com
*    Date: 27 September 2018
*    Code version: 1.0
*
***************************************************************************************/
global class LeaveRoundRobin implements Schedulable {
    
    private WelcomeCall_Group__c[] level;
    private Map<String, Decimal> lastPriorityUpdated = new Map<String, Decimal>();
    private Map<String, Decimal> maxPriorityInAgentGroup = new Map<String, Decimal>();
    private Map<String, List<Agent_Group__c>> agentInGroup = new Map<String, List<Agent_Group__c>>();
    static ID wcRtId = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
    
    global void execute(SchedulableContext SC) {
		system.debug('Check if any agents on leave today then distribute round robin each agent');
        List<Call_Line__c> calin = [SELECT Name, OwnerId, Contact__r.Name, WelcomeCall_Call_Line_Status__c, WelcomeCall_Criteria__c, Contact__r.Policy_No__c
                                    FROM Call_Line__C
                                    WHERE WelcomeCall_Call_Line_Status__c != 'Closed' 
                                    AND WelcomeCall_Schedule_Date__c = TODAY
                                	And welcomecall_fg_schedule__c = false
                                    AND OwnerId IN (SELECT OwnerId FROM Agent_Group__c WHERE isActive__c = false)
                                    ];
        startDistribute(calin);
    }
    
    public void distributeChangeBySup(Id agentOwnerId) {
        system.debug('Distributing...'+agentOwnerId);
        List<Call_Line__c> calin = [SELECT Name, OwnerId, Contact__r.Name, WelcomeCall_Call_Line_Status__c, WelcomeCall_Criteria__c, Contact__r.Policy_No__c
                                    FROM Call_Line__C
                                    WHERE WelcomeCall_Call_Line_Status__c != 'Closed' AND OwnerId = :agentOwnerId
                                    AND recordTypeId =: wcRtId
                                	And welcomecall_fg_schedule__c = false
                                    AND WelcomeCall_Schedule_Date__c = TODAY];
        startDistribute(calin);
    }
    
    public void startDistribute(List<Call_Line__c> calin){
        // get levels
        System.debug('getLevels');
        level = getLevels(); // soql
        // set map maximal priority
        System.debug('setMapMaxPriorityInAgentGroup');
        setMapMaxPriorityInAgentGroup();
        // set map agent in group
        System.debug('setMapAgentInGroup');
        setMapAgentInGroup();
        // set map last priority
        setMapLastPriority(); // soql
        // system.debug('data: '+calin);
        // processing each record
        Map<String, WelcomeCall_Group__c> updatedLevelGroup = new Map<String, WelcomeCall_Group__c>();
        for(Call_Line__c cl: calin) {
            String myCrit = cl.WelcomeCall_Criteria__c;
            if(myCrit != ''){ // hanya memproses APE yg masuk dalam kriteria
                //System.debug('APE: '+cl.Contact__r.WelcomeCall_APE__c);
                System.debug('Line Criteria: '+myCrit);
                String myLevel = getLineLevel(myCrit); // search in list
                System.debug('Level: '+myLevel);
                
                Agent_Group__c[] agents = agentInGroup.get(myLevel); // // search in map
                Decimal lastPriority = lastPriorityUpdated.get(myLevel); // search in map
                //Decimal lastPriority = getLastPriorityInLevel(myLevel); // soql
                WelcomeCall_Group__c levelGroup = getLevelGroupObject(myLevel); // search in list
                Decimal maxPriority = maxPriorityInAgentGroup.get(myLevel); // search in map
                    
                // loop to check the priority on each agent, then change the owner and update last priority
                Integer agentSize = agents.size();
                for(Agent_Group__c ag: agents){
                    Decimal agentPrio = ag.WelcomeCall_Priority__c;
                    
                    if(lastPriority >= maxPriority){
                        levelGroup.WelcomeCall_Last_Priority__c = 0;
                        lastPriority = 0;
                    }
                        
                    if(lastPriority < agentPrio){
                        cl.OwnerId = ag.Agent__r.WelcomeCall_User__r.Id;
                        
                        Date now = Date.today();
                        cl.WelcomeCall_Schedule_Date__c = now;
                        cl.WelcomeCall_Criteria__c = myCrit;
                        //cl.Policy_No__c = cl.Contact__r.Policy_No__c;
                        cl.WelcomeCall_Fg_Round_Robin__c = true;
                        
                        levelGroup.WelcomeCall_Last_Priority__c = agentPrio;
                        lastPriority = agentPrio;
                        lastPriorityUpdated.put(myLevel, lastPriority);                        
                        system.debug('Skipping trigger CaseTypeUpdateOnCallLine.');
        				CallLineTriggerControl.skipCaseTypeUpdate = true;
                        system.debug('Update call line owner. ID: '+cl.Id+'; Name: '+cl.Name+'; New ID: '+ag.Agent__r.WelcomeCall_User__r.Id+'; New Name: '+ag.Agent__r.Name+'; LastPrio: '+lastPriority);
                        update cl;
                        system.debug('Update group last priority');
                        //update levelGroup;
                        updatedLevelGroup.put(levelGroup.name, levelGroup);
    
                        break;
                    }
                    
                }
            } // end check myCrit
            
        }
        if(!updatedLevelGroup.isEmpty()){
            update updatedLevelGroup.values();
        }
        
        system.debug('Distribution done.');
    }
    
    private List<WelcomeCall_Group__c> getLevels() {
        WelcomeCall_Group__c[] levels = [SELECT id, Name, WelcomeCall_Criteria__c, WelcomeCall_Last_Priority__c
                                            FROM WelcomeCall_Group__c];
        return levels;
    }
    
    private List<Agent_Group__c> getAvailableAgentsInLevel(String levelName) {
        Date tdy = System.today();
        List<Agent_Group__c> agents = [SELECT id, Name, OwnerId, owner.name, WelcomeCall_Group__r.name, isActive__c, Active_Leave__c, 
                                       Agent__r.name, Agent__r.WelcomeCall_User__r.Id, 
                                       WelcomeCall_Assignment__c, WelcomeCall_Priority__c, WelcomeCall_Resign__c
                                       FROM Agent_Group__c WHERE WelcomeCall_Group__r.name = :levelName AND WelcomeCall_Assignment__c = true AND isActive__c = true AND Agent__c NOT IN (select WelcomeCall_Agent__c
                                                                                                                                                                                    from WelcomeCall_Leave__c 
                                                                                                                                                                                    where WelcomeCall_Start_Date__c <= :tdy and WelcomeCall_End_Date__c >= :tdy)
                                       ORDER BY WelcomeCall_Priority__c];
        System.debug(agents);
        return agents;
    }

    private void setMapAgentInGroup(){
        for(WelcomeCall_Group__c lev : level) {
            Agent_Group__c[] agents = getAvailableAgentsInLevel(lev.Name);
            agentInGroup.put(lev.Name, agents);
        }
    }
    
    private void setMapMaxPriorityInAgentGroup(){
        AggregateResult[] max = [SELECT WelcomeCall_Group__r.name, max(WelcomeCall_Priority__c)
                                    FROM Agent_Group__c
                                    WHERE WelcomeCall_Assignment__c = true AND isActive__c = true
                                    GROUP BY WelcomeCall_Group__r.name];
        for(AggregateResult a: max){
            maxPriorityInAgentGroup.put(String.valueOf(a.get('Name')), Decimal.valueOf(String.valueOf(a.get('expr0'))));
        }
        system.debug(maxPriorityInAgentGroup);
    }
    
    private String getLineLevel(String crit) {
        String result, levelName, critName = '';
        
        for(WelcomeCall_Group__c lev : level) {
            levelName = lev.Name;
            critName = lev.WelcomeCall_Criteria__c;
            
            if( crit.toLowerCase() == critName.toLowerCase()) {
                result = levelName;
                break;
            }
        }
        return result;
    }
    
    private WelcomeCall_Group__c getLevelGroupObject(String levelName) {
        WelcomeCall_Group__c result;
        
        for(WelcomeCall_Group__c lev : level) {
            if(levelName == lev.Name){
                result = lev;
                break;
            }
        }
        return result;
    }
    
    /**private Decimal getLastPriorityInLevel(String levelName) {
        WelcomeCall_Group__c[] prio = [SELECT Name, WelcomeCall_Last_Priority__c from WelcomeCall_Group__c WHERE Name = :levelName LIMIT 1];
        return prio[0].WelcomeCall_Last_Priority__c;
    }*/
    
    public void resetLastPriority() {
        WelcomeCall_Group__c[] levels = getLevels();
        for(WelcomeCall_Group__c gr: levels){
            gr.WelcomeCall_Last_Priority__c = 0;
            update gr;
        }
    }
    
    private void setMapLastPriority() {
        WelcomeCall_Group__c[] prio = [SELECT Name, WelcomeCall_Last_Priority__c from WelcomeCall_Group__c];
        for(WelcomeCall_Group__C p: prio){
            lastPriorityUpdated.put(p.Name, p.WelcomeCall_Last_Priority__c);
        }
    }
}