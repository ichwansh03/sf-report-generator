public class CallLineReport_c {
    Id rtWelcomCallId = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
    Id agentGroupRecord = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent Group').getRecordTypeId();
    public date startDate{get;set;}
    public date endDate{get;set;}
    public String startStr{get;set;}
    public String endStr{get;set;}
    public Integer attemptc{get;set;}
    public List<Call_Line__c> calline{get;set;}
    public List<AggregateResult> calls{get;set;}
    Public List<AggregateResult> contacted{get;set;}
    Public List<AggregateResult> unContacted{get;set;}
    Public List<AggregateResult> closed{get;set;}
    Public List<AggregateResult> attemptCalls{get;set;}
    public Id own{get;set;}
    Datetime firstDayOfMonth = System.today().toStartOfMonth();
    Datetime lastDayOfMonth = firstDayOfMonth.addDays(Date.daysInMonth(firstDayOfMonth.year(), firstDayOfMonth.month()) - 1);
    public CallLineReport_c(){
        startDate = date.valueOf(firstDayOfMonth);
        endDate = date.valueOf(lastDayOfMonth);
        date today = date.today();
        own = UserInfo.getUserId();
        
        filter();
    }
    public class AgentName{
        public Id idx {get;set;}
        public String name {get;set;}
        
        public AgentName(Id idx, String name){
            this.idx =idx;
            this.name = name;
        }
    }
    public List<Selectoption> getListOfAgentbySVP(){
        List<Agent_Group__c > agents = new List<Agent_Group__c >();
        Set<selectOption> setAgents = new Set<selectOption>();
        List<Id> idagent = new List<id>();
		Id userinfo = UserInfo.getUserId();
        List<Agent_Group__c> currentAgents = [
            select id, name,WelcomeCall_Supervisor__c, agent__r.WelcomeCall_Supervisor__c, agent__c, isActive__c, recordtypeid, 
            	WelcomeCall_User__c, WelcomeCall_Fg_Head__c 
            FROM Agent_Group__c where agent__r.WelcomeCall_User__c = :userinfo
        ];
        if(!currentAgents.isEmpty()){
            if(currentAgents.get(0).WelcomeCall_Supervisor__c){
                    agents.addAll([Select id, name, Agent__c, Agent__r.WelcomeCall_User__c, Agent__r.WelcomeCall_User__r.name , welcomecall_group__r.name
                                   from Agent_Group__c 
                                   where recordtypeid =: agentGroupRecord
                                   and agent__r.WelcomeCall_Resign__c = false 
                                   and WelcomeCall_Fg_Head__c = false
                                   and Agent__r.WelcomeCall_User__c != : userinfo
                                   order by name]);
            }
            else{
                
            }
        }
		List<SelectOption> agentList = new List<SelectOption>();     
        agentList.add(new selectOption (userinfo,'My Productivity'));
        for(Agent_Group__c st : agents){
            setAgents.add(new selectOption(St.Agent__r.WelcomeCall_User__c, st.Agent__r.WelcomeCall_User__r.name));
        }
        for(selectOption so : setAgents){
        	agentList.add(new selectOption(so.getvalue(), so.getlabel()));
        }
        return agentList;
    }
    public void filter(){
        if(startDate<= enddate){
            startStr = startDate.format();
            endStr = endDate.format();
            System.debug('own '+own);
            calls = [select count(id) idline
                     from Call_Line__c
                     where recordTypeId =: rtWelcomCallId and ownerid = :own
                     and (WelcomeCall_Schedule_Date__c >= :startDate and WelcomeCall_Schedule_Date__c < :endDate.addDays(1))];
            calline = new List<Call_Line__c>();
            Call_Line__c cl = new Call_Line__c();
            cl.Case_Type__c = 'All Calls';
            cl.Call_Generated_Counter__c = (Integer)calls[0].get('idline');
            calline.add(cl);
            
            contacted = [select count(id) idline
                         from Call_Line__c
                         where recordTypeId =: rtWelcomCallId
                         and Activity_Result__c = 'contacted' and ownerid = :own
                         and (WelcomeCall_Schedule_Date__c >= :startDate and WelcomeCall_Schedule_Date__c < :endDate.addDays(1))];
            Call_Line__c con = new Call_Line__c();
            con.Case_Type__c = 'Contacted';
            con.Activity_Result__c = 'contacted';
            con.Call_Generated_Counter__c = (Integer)contacted[0].get('idline');
            calline.add(con);
            
            unContacted = [select count(id) idline
                           from Call_Line__c
                           where recordTypeId =: rtWelcomCallId
                           and Activity_Result__c = 'uncontacted' and ownerid = :own
                           and (WelcomeCall_Schedule_Date__c >= :startDate and WelcomeCall_Schedule_Date__c < :endDate.addDays(1))];
            Call_Line__c uncon = new Call_Line__c();
            uncon.Case_Type__c = 'Uncontacted';
            uncon.Call_Generated_Counter__c = (Integer)unContacted[0].get('idline');
            calline.add(uncon);
            
            closed = [select count(id) idline
                      from Call_Line__c
                      where recordTypeId =: rtWelcomCallId
                      and WelcomeCall_Call_Line_Status__c = 'closed' and ownerid = :own
                      and (WelcomeCall_Schedule_Date__c >= :startDate and WelcomeCall_Schedule_Date__c < :endDate.addDays(1))];
            Call_Line__c close = new Call_Line__c();
            close.Case_Type__c = 'Closed';
            close.Call_Generated_Counter__c = (Integer)closed[0].get('idline');
            calline.add(close);
            
            attemptCalls = [select sum(WelcomeCall_Attempt__c) idline
                            from Call_Line__c
                            where recordTypeId =: rtWelcomCallId and ownerid = :own
                            and (WelcomeCall_Schedule_Date__c >= :startDate and WelcomeCall_Schedule_Date__c < :endDate.addDays(1))];
            Decimal attCalls = attemptCalls[0].get('idline')==null?0:(decimal)attemptCalls[0].get('idline');
            attemptc = attCalls.intvalue();
            Call_Line__c cal = new Call_Line__c();
            cal.Case_Type__c = 'Attempt';
            cal.Call_Generated_Counter__c = attemptc;
            calline.add(cal);
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'End Date tidak boleh lebih awal dari start date'));
        }
        
    }
    
}