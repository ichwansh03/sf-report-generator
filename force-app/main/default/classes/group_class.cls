public class group_class {
    public map<String, List<MyWrapper>> mapMW {get;set;}
    public boolean displayButton {get; set;}  
    public String agentname {get;set;}
    public String act {get;set;}
    public WelcomeCall_Leave__c leavereason{get;set;}
   // public WelcomeCall_Leave__c leavedesc{get;set;}
    public string agentid{get;set;}
    public List<id> idagent{get;set;}
    public List<Boolean> wel{get;set;}
    Public String baseUrl{get;set;}
   // Public String agName{get;set;}
    public ApexPages.StandardController controller {get;set;}
    
    private Map<String, WelcomeCall_Leave__c> getMapLeavebyToday(){
        Date tdy = System.today();
        
        List<WelcomeCall_Leave__c> leaves = [select id, name, WelcomeCall_Agent__c, WelcomeCall_Reason__c, 
                                             WelcomeCall_Description__c, Active_Leave__c 
                 							 from WelcomeCall_Leave__c 
                                             where WelcomeCall_Start_Date__c <= :tdy and WelcomeCall_End_Date__c >= :tdy];
        Map<String, WelcomeCall_Leave__c> mapOfLeaves = new Map<String, WelcomeCall_Leave__c>();
        System.debug('list leaves : '+mapOfLeaves);
        for(WelcomeCall_Leave__c leave : leaves){
            mapOfLeaves.put(leave.WelcomeCall_Agent__c, leave);
        }
		return mapOfLeaves;
    }
    public group_class(){
        
        //get user id
        //String userid = UserInfo.getUserId();
        //
        
        baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
        String userid = UserInfo.getUserId();
        System.debug('user id :'+userid);
        Agent_Group__c agrr = [select id, name, agent__r.WelcomeCall_Supervisor__c, agent__c, isActive__c, recordtypeid, WelcomeCall_User__c, 
                               WelcomeCall_Fg_Head__c 
                               FROM Agent_Group__c 
                               WHERE WelcomeCall_User__c = :userid];
        System.debug('agrr' +agrr.name);
        idagent = new List<id>();
        wel = new List<Boolean>();
        for(Agent_Group__c agr :[select id, name, WelcomeCall_Supervisor__c, WelcomeCall_User__c 
                                 FROM Agent_Group__c 
                                 WHERE agent__r.WelcomeCall_User__c != :userid
                                 AND WelcomeCall_Supervisor__c = true]){
            System.debug('spv : '+agr.WelcomeCall_Supervisor__c);
            idagent.add(agr.id);
            wel.add(agr.WelcomeCall_Supervisor__c);
        }
      
        this.leavereason = new WelcomeCall_Leave__c();
        //this.leavedesc = (WelcomeCall_Leave__c)controller.getRecord();
        String agentRecord = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent').getRecordTypeId();
        Map<String, WelcomeCall_Leave__c> mapOfLeaves = getMapLeavebyToday();
        mapMW = new map<String, List<MyWrapper>>();
        //System.debug('agentid : '+agentid);
        for(Agent_Group__c agr : [select id, name, agent__c, isActive__c, recordtypeid, WelcomeCall_User__c, 
                                  WelcomeCall_Supervisor__c , WelcomeCall_Group__c 
                                  FROM Agent_Group__c where agent__c = :agrr.id and 
                                  WelcomeCall_Supervisor__c = true  and 
                                  WelcomeCall_Fg_Head__c =false and WelcomeCall_Resign__c=false]){
                                      System.debug('agr'+agr);
                                      for(WelcomeCall_Group__c w :[select id, name from WelcomeCall_Group__c where id = :agr.WelcomeCall_Group__c]){
                                          
                                          if(agrr.WelcomeCall_Fg_Head__c == false){
                                              List<Agent_Group__c> agents = [select id, name, agent__c, isActive__c, WelcomeCall_Supervisor__c 
                                                                             from Agent_Group__c 
                                                                             where WelcomeCall_Group__r.Name= :w.name 
                                                                             and agent__r.WelcomeCall_Fg_Head__c= false 
                                                                             and agent__r.WelcomeCall_Resign__c = false] ;
                                                                             //and id not in :idagent
                                              System.debug('agents :'+agents);
                                              List<MyWrapper> wrappers = new List<MyWrapper>();
                                              //List<Agent_Group__c> ag = [select id, name, agent__c, isActive__c from Agent_Group__c where WelcomeCall_Resign__c= false and recordtypeid = '0125D0000004vVTQAY'];
                                              for(Agent_Group__c agent : agents){
                                                  wrappers.add(new MyWrapper(agent, mapOfLeaves.get(agent.agent__c)));
                                              }
                                              mapMW.put(w.name, wrappers);
                                              
                                          }
                                          else{
                                              List<Agent_Group__c> agents = [select id, name, agent__c, isActive__c, WelcomeCall_Supervisor__c from Agent_Group__c where WelcomeCall_Group__r.Name= :w.name 
                                                                             and agent__r.WelcomeCall_Fg_Head__c= false and agent__r.WelcomeCall_Resign__c = false];
                                              List<MyWrapper> wrappers = new List<MyWrapper>();
                                              for(Agent_Group__c agent : agents){
                                                  wrappers.add(new MyWrapper(agent, mapOfLeaves.get(agent.agent__c)));
                                              }
                                              mapMW.put(w.name, wrappers);
                                          }

                                              
                                              //}

                                          
                                      }  
                                      System.debug('MAP RESULT '+mapMW);
                                  }
        AgentName = apexpages.currentpage().getparameters().get('name');
        
    }   
    
    public PageReference closePopup() {        
       // displayPopup = false;
        this.leavereason = new WelcomeCall_Leave__c();
        PageReference pageRef = ApexPages.currentPage();
        return pageRef;
        
        
    }     
    public void showPopup() {        
        //displayPopup = true;
        act = ApexPages.CurrentPage().getParameters().get('clickDate');
        Agent_Group__c agents = [select id, name, agent__c, isActive__c from Agent_Group__c where id =:act];
        
        System.debug('act : '+act);
        System.debug('agentname : '+agents);
    }
    
    public void editpg(){
        Date tdy = System.today();
        agentid = apexpages.currentpage().getparameters().get('id');
        /*String a =System.currentPageReference().getParameters().get('reasonleave');
        System.debug('reason :'+System.currentPageReference().getParameters().get('reasonleave'));*/
        
        System.debug('agentid : '+agentid);
        RECORDTYPE rectype = [select id, name from recordtype where name = 'Agent'];
        Agent_Group__c agr = [select id, name, agent__c, isActive__c, recordtypeid, WelcomeCall_User__c, WelcomeCall_Supervisor__c , WelcomeCall_Group__c 
                                    FROM Agent_Group__c where id = :agentid];
		agentname = agr.name;
        System.debug('AGR : '+agr);
        System.debug('REASON : '+leavereason.WelcomeCall_Reason__c);
        System.debug('agr.agent__c : '+agr.agent__c);
        System.debug('leavereason.WelcomeCall_Description__c : '+leavereason.WelcomeCall_Description__c);
        WelcomeCall_Leave__c wl = new WelcomeCall_Leave__c();
        wl.WelcomeCall_Start_Date__c = tdy;
        wl.WelcomeCall_End_Date__c = tdy;
        wl.WelcomeCall_Agent__c = agr.agent__c;
        wl.WelcomeCall_Reason__c = leavereason.WelcomeCall_Reason__c;
        wl.WelcomeCall_Description__c = leavereason.WelcomeCall_Description__c;
        insert wl; 
            
        // set agent as inactive
        //agr.isActive__c = false;
        //update agr;
        //List<Call_Line__c> callLine = [select id, name, ownerid from Call_Line__c where recordtype.name = 'Welcome Call' and ownerid=:agr.Agent__c];
        
        // get user id of agent
        // 
        ID rtAgentGroup = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent Group').getRecordTypeId();
        Agent_Group__c userAgentId = [SELECT id, name, Agent__r.welcomecall_user__r.id
                                 FROM agent_group__c
                                WHERE id= :agentid AND recordtypeID = :rtAgentGroup];
        // run round robin for each agent group
        LeaveRoundRobin lrr = new LeaveRoundRobin();
        lrr.distributeChangeBySup(userAgentId.Agent__r.welcomecall_user__r.id);
        
        
        this.leavereason = new WelcomeCall_Leave__c();
        
        /*String baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
        PageReference pageRef = new PageReference(baseUrl+'/apex/GroupLeave');
        pageRef.setRedirect(true);
        return pageRef;*/
        //displayPopup = false;

        //return null;
    }
    
    public class MyWrapper{
        public String agentName {get;set;}
        Public String agentid{get;set;}
        //Public Boolean agentid{get;set;}
        public Boolean isAvailable {get;set;}
        public String leaveStatus {get;set;}
        public String description {get;set;}
        Public String role {get;set;}
        
        public MyWrapper(Agent_Group__c agent , WelcomeCall_Leave__c lv)
        {
            
                this.agentName = agent.Name;
                this.agentid = agent.id;
                //this.agentid = agent.WelcomeCall_Supervisor__c;
            	 if(agent.WelcomeCall_Supervisor__c != TRUE){
                    this.role = 'Agent';
                } else {
                   this.role =  'Supervisor';
                }

            
                this.isAvailable = agent.isActive__c;
                if(lv != null){
                    this.leaveStatus = lv.WelcomeCall_Reason__c;
                    this.description = lv.WelcomeCall_Description__c; 
                } else {
                    this.leaveStatus = 'Available';
                    this.description = '-'; 
                }
            
        }
        
    }
    
    
}