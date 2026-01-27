public class Agent_Callback_Controller {

    public String show { get; set; }
    public List<AgentBucket> callbackList { get; set; }
    public List<SelectOption> campaignList {get; set;}
    public boolean displayPopup {get; set;}
    public User userObj {get; set;}

    public String showButton {get;set;}
    public List<Call_Line__c> showList {get; set;}
    public List<Call_Line__c> callLineList {get;set;}
	public List<Call_List__c> callList {get; set;}
	public Map<string,string> campaignMap {get; set;}
	public Map<id,Call_List__c> campaignObjectMap {get; set;}
	 
    public String reminder {get;set;}
	public String choosen_campaign {get; set;}
    public integer totalRecords {get;set;} 
    public String loggedInUser {get;set;}
    public Map<id,User> agentMap {get;set;}
    public String entity {get;set;}
    public String campaignName {get; set;}
    
    public class AgentBucket{
        public string agentId { get; set; }
        public string agentName { get; set; }
        public integer assignedSize { get; set; }
    }

    // -- constructor --
    public Agent_Callback_Controller(){
        displayPopup = false;
        userObj = [SELECT id, Entity__c FROM user WHERE id = :UserInfo.getUserId()];
		loggedInUser = userObj.id;
		entity = userObj.Entity__c;
		Call_List__c clist = null;
   
		//get all subordinate of logged-in user (if any)
        agentMap = new Map<id,User> ([SELECT id, Entity__c, Name FROM user WHERE Entity__c = :entity AND isActive = true AND ManagerId = :loggedInUser AND Agent__c = true]);
        
        if(callList == null){
            callLineList = [SELECT Call_List__r.id, Call_List__r.Campaign_Name__c, Call_List__r.Entity__c, Call_List__r.Activity__c, Call_List__r.Case_Type__c, Call_List__r.Survey_ID__c FROM Call_Line__c WHERE Entity__c = :entity AND (ownerid = :loggedInUser or ownerid in :agentMap.keySet()) AND Call_List__r.IsExpired__c = false AND Activity__c = 'Callback'];
            callList = new List<Call_List__c>();
            campaignList = new List<SelectOption>();
            campaignMap = new Map<string,string>();
            campaignObjectMap = new Map<id,Call_List__c>(); 

            for(Call_Line__c cline : callLineList){
                if(!campaignObjectMap.containsKey(cline.Call_List__r.id)){
                    clist = new Call_List__c();
                    clist.id = cline.Call_List__r.id; 
                    clist.Campaign_Name__c = cline.Call_List__r.Campaign_Name__c;
                    clist.Entity__c = cline.Call_List__r.Entity__c; 
                    clist.Activity__c = cline.Call_List__r.Activity__c; 
                    clist.Case_Type__c = cline.Call_List__r.Case_Type__c; 
                    clist.Survey_ID__c = cline.Call_List__r.Survey_ID__c;   
                    callList.add(clist); 
                    campaignList.add(new SelectOption(clist.id, clist.Campaign_Name__c));
                    campaignMap.put(clist.id, clist.Campaign_Name__c);
                    campaignObjectMap.put(clist.id, clist);
                    campaignName = clist.Campaign_Name__c;
                }    
            } 
        }
     }
     
     public void close(){
        displayPopup = false;  
     }
	 
	 public PageReference populateAssignment(){
        AgentBucket agentBucket = null;
        callbackList =  new List<AgentBucket>();
        Call_List__c cl = campaignObjectMap.get(choosen_campaign);
 		system.debug('>>> choosen_campaign : '+choosen_campaign);
 		
        if(choosen_campaign != '' && choosen_campaign != null){
 			system.debug('>>> cl.id : '+cl.id);
 			system.debug('>>> userObj.Entity__c : '+userObj.Entity__c);
 			system.debug('>>> userObj.id : '+userObj.id);
        	AggregateResult[] groupedResults = [SELECT Agent__r.id agentId, Agent__r.Name agentName, count(Id) num FROM Call_Line__c WHERE Is_Calledback_Already__c = false AND Is_Expired__c = false AND Call_List__c = :cl.id AND Agent__c != null AND Entity__c = :userObj.Entity__c  AND createdby.id = :userObj.id group by Agent__r.id, Agent__r.Name];
        	
        	for (AggregateResult ar : groupedResults){
	        	agentBucket = new AgentBucket();
		        agentBucket.agentId = (string) ar.get('agentId');
		        agentBucket.agentName = (string) ar.get('agentName');
		        agentBucket.assignedSize = (Integer) ar.get('num');
		        callbackList.add(agentBucket);
        	}
        }
        return null;
    }
    
    public void show() {
    	String campaign = campaignMap.get(choosen_campaign);
	 	String agentid = ApexPages.currentPage().getParameters().get('agentid');
        system.debug('#agentid : '+agentid);
        showList = [SELECT  Agent__c, Agent__r.Name, Campaign_Type__c, Contact__c, Contact__r.Name, Contacted_Number__c, Entity__c, Expired_Date__c, Is_Expired__c, Policy_No__c, Id FROM Call_Line__c WHERE Is_Calledback_Already__c = false AND Is_Expired__c = false AND Agent__c = :agentid AND Entity__c = :userObj.Entity__c AND call_list__r.Campaign_Name__c = :campaign];
        
        displayPopup = true;  
    }
}