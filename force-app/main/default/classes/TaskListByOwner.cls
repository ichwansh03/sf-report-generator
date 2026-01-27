public class TaskListByOwner {
    Id agentRecordId = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent').getRecordTypeId();
    Id agentGroupRecord = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent Group').getRecordTypeId();
    public String selectedStatus {get;set;}
    public String selectedOwner {get;set;}
    public String selectedType {get;set;}
    //public String selectedOwnTask {get;set;}
    public String polisNo {get;set;}
    Public List<id> idAgent{get;set;}
    private List<Agent_Group__c > agentSVP = new List<Agent_Group__c >();
    //public List<call_line__c> cline {get;set;}
    Public Transient List<Call_Line__c> taskList {get;set;}
    public Transient Map<Integer, Call_Line__c> mapCallLine {get;set;}
    
    public TaskListByOwner(){
         agentSVP = new List<Agent_Group__c >();
        System.debug('UserInfo.getUserId() '+UserInfo.getUserId());
         agentSVP.addAll([Select id, name, Agent__c, Agent__r.WelcomeCall_User__c, welcomecall_group__c
                                       from Agent_Group__c 
                                       where Welcomecall_supervisor__c = true and Agent__r.WelcomeCall_User__c =: UserInfo.getUserId()
                                       and recordtypeid =: agentGroupRecord order by welcomecall_group__r.name]);
        Getcline();
        getListOfCallLine();
    }
    
    public List<call_line__c> Getcline()
    {
        List<call_line__c> result = new List<call_line__c>();
        Datetime now = Datetime.now();
        /*Integer offset = UserInfo.getTimezone().getOffset(now);
        Datetime local = now.addSeconds(offset/1000);*/
        String userinfo = UserInfo.getUserId();
        System.debug('userinfo : '+userinfo);
        
        datetime before_an_hour = Datetime.newInstance(now.year(), now.month(), now.day(), now.hour()-1, 0, 0);//now.addHours(-1);        
        datetime after_an_hour = Datetime.newInstance(now.year(), now.month(), now.day(), now.hour()+1, 0, 0);//now.addHours(1);
        System.debug('before_an_hour: '+before_an_hour);
        System.debug('before_an_hour: '+after_an_hour);
        list<call_line__c> Listcline = [select id, name, Case_Type__c, Contact__r.name, WelcomeCall_Schedule_Date__c, Policy_No__c, Contact__r.Insured_Name__c,
                 WelcomeCall_Reference__c from call_line__c 
                 where recordtype.name = 'welcome call'  AND WelcomeCall_Fg_Schedule__c = true 
                 and ownerid = :userinfo AND
                 WelcomeCall_Call_Line_Status__c <> 'closed'
                 and
                 (WelcomeCall_Schedule_Date__c >= :before_an_hour and
                  WelcomeCall_Schedule_Date__c <= :after_an_hour)
                 ORDER by WelcomeCall_Schedule_Date__c asc Limit 4 OFFSET 0
                ];
        System.debug('callline : '+Listcline);
        result = Listcline;
        System.debug('result : '+result);
        return result;
    }
    
    public List<call_line__c> Getcline2()
    {
        List<call_line__c> result = new List<call_line__c>();
        Datetime now = Datetime.now();
        /*Integer offset = UserInfo.getTimezone().getOffset(now);
        Datetime local = now.addSeconds(offset/1000);*/
        String userinfo = UserInfo.getUserId();
        System.debug('userinfo : '+userinfo);
        
        datetime before_an_hour = Datetime.newInstance(now.year(), now.month(), now.day(), now.hour()-1, 0, 0);//now.addHours(-1);        
        datetime after_an_hour = Datetime.newInstance(now.year(), now.month(), now.day(), now.hour()+1, 0, 0);//now.addHours(1);
        System.debug('before_an_hour: '+before_an_hour);
        System.debug('before_an_hour: '+after_an_hour);
        list<call_line__c> Listcline = [select id, name, Case_Type__c, Contact__r.name, WelcomeCall_Schedule_Date__c, Policy_No__c, Contact__r.Insured_Name__c,
                 WelcomeCall_Reference__c from call_line__c 
                 where recordtype.name = 'welcome call' AND WelcomeCall_Fg_Schedule__c = true and ownerid = :userinfo AND
                 WelcomeCall_Call_Line_Status__c <> 'closed'
                 and
                 (WelcomeCall_Schedule_Date__c >= :before_an_hour and
                  WelcomeCall_Schedule_Date__c <= :after_an_hour)
                 ORDER by WelcomeCall_Schedule_Date__c asc LIMIT 4 OFFSET 4
                ];
        System.debug('callline : '+Listcline);
        result = Listcline;
        System.debug('result : '+result);
        return result;
    }
    public List<call_line__c> Getcline3()
    {
        List<call_line__c> result = new List<call_line__c>();
        Datetime now = Datetime.now();
        /*Integer offset = UserInfo.getTimezone().getOffset(now);
        Datetime local = now.addSeconds(offset/1000);*/
        String userinfo = UserInfo.getUserId();
        System.debug('userinfo : '+userinfo);
        
        datetime before_an_hour = Datetime.newInstance(now.year(), now.month(), now.day(), now.hour()-1, 0, 0);//now.addHours(-1);        
        datetime after_an_hour = Datetime.newInstance(now.year(), now.month(), now.day(), now.hour()+1, 0, 0);//now.addHours(1);
        System.debug('before_an_hour: '+before_an_hour);
        System.debug('before_an_hour: '+after_an_hour);
        list<call_line__c> Listcline = [select id, name, Case_Type__c, Contact__r.name, WelcomeCall_Schedule_Date__c, Policy_No__c, Contact__r.Insured_Name__c,
                 WelcomeCall_Reference__c from call_line__c 
                 where recordtype.name = 'welcome call'  AND WelcomeCall_Fg_Schedule__c = true and ownerid = :userinfo AND
                 WelcomeCall_Call_Line_Status__c <> 'closed'
                 and
                 (WelcomeCall_Schedule_Date__c >= :before_an_hour and
                  WelcomeCall_Schedule_Date__c <= :after_an_hour)
                 ORDER by WelcomeCall_Schedule_Date__c asc LIMIT 4 OFFSET 8
                ];
        System.debug('callline : '+Listcline);
        result = Listcline;
        System.debug('result : '+result);
        return result;
    }
    public void refreshTaskList(){
        selectedStatus = ApexPages.CurrentPage().getParameters().get('status');
        selectedOwner = ApexPages.CurrentPage().getParameters().get('owner');
        polisNo = ApexPages.CurrentPage().getParameters().get('polis');
        getListOfCallLine();
    }
    
    public List<SelectOption> getListOwnTask() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('MyOwnTask','My Own Task')); return options;
    }
    
    //edited By Fajar Salam 13/04/2022
    public List<SelectOption> getListType() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('sc','Schedule'));
        options.add(new SelectOption('wc','Welcome Call'));
        options.add(new SelectOption('uw','Tele UW'));
        return options;
    }
    
    public List<Selectoption> getListOfAgentbySVP(){
        List<Agent_Group__c > agents = new List<Agent_Group__c >();
        idagent = new List<id>();
		String userinfo = UserInfo.getUserId();
        List<Agent_Group__c> agrr = [
            select id, name, agent__r.WelcomeCall_Supervisor__c, agent__c, isActive__c, recordtypeid, 
            	WelcomeCall_User__c, WelcomeCall_Fg_Head__c 
            FROM Agent_Group__c where WelcomeCall_User__c = :userinfo
        ];
        for(Agent_Group__c agr :[
            select id, name, WelcomeCall_Supervisor__c, WelcomeCall_User__c FROM Agent_Group__c 
            where agent__r.WelcomeCall_User__c != :userinfo and WelcomeCall_Supervisor__c = true
        ]){
            System.debug('spv : '+agr.WelcomeCall_Supervisor__c);
            idagent.add(agr.id);
        
        }
        if(!agentSVP.isEmpty()){
            if(!agrr.isEmpty() && agrr.get(0).WelcomeCall_Fg_Head__c == false){
                for(Agent_Group__c st : agentSVP){
                    agents.addAll([Select id, name, Agent__c, Agent__r.WelcomeCall_User__c, welcomecall_group__r.name
                                   from Agent_Group__c 
                                   where recordtypeid =: agentGroupRecord 
                                   and welcomecall_group__c =: st.welcomecall_group__c 
                                   and agent__r.WelcomeCall_Resign__c = false 
                                   and id not in :idagent
                                   order by name]);
                }
            }
            else{
                for(Agent_Group__c st : agentSVP){
                    agents.addAll([Select id, name, Agent__c, Agent__r.WelcomeCall_User__c, welcomecall_group__r.name
                                   from Agent_Group__c 
                                   where
                                   recordtypeid =: agentGroupRecord 
                                   and welcomecall_group__c =: st.welcomecall_group__c 
                                   and agent__r.WelcomeCall_Resign__c = false
                                   order by name]);
                }
            }
        }
		List<SelectOption> agentList = new List<SelectOption>();     
        agentList.add(new selectOption ('','- None -'));
        for(Agent_Group__c st : agents){
        	agentList.add(new selectOption (St.Agent__r.WelcomeCall_User__c, st.name+'#'+st.welcomecall_group__r.name));
        }   
        return agentList;
    }
    
    public List<Selectoption> getStatusOptions(){
        List<String> clStatus = getPickListValuesIntoList('Call_Line__c', 'WelcomeCall_Call_Line_Status__c');
        List<SelectOption> StatusOption = new List<SelectOption>();
        StatusOption.add(new selectOption ('','- None -'));
        for(String st : clStatus){
        	StatusOption.add(new selectOption (St,St));
        }
        return StatusOption;
    }
         
    public List<String> getPickListValuesIntoList(String objectType, String selectedField){
        List<String> pickListValuesList = new List<String>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectType);
        Schema.DescribeSObjectResult res = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = res.fields.getMap().get(selectedField).getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
        }     
        return pickListValuesList;
    }
    public Map<Integer, Call_Line__c> getListOfCallLine(){
        // if Agent login is not svp
        String days = System.Label.Day_Limit_Call_Line;
        System.debug('Call Line Limit Created Date = Last '+days+' days');
        if(agentSVP.isEmpty()){
            selectedOwner = UserInfo.getUserId();
        }
        System.debug('selectedOwner = '+ selectedOwner );
        //edited By Fajar Salam 13-04-2022
        String query ='SELECT id, CreatedDate, RecordTypeId, Name, Policy_No__c, Contact__c, Contact__r.Name, WelcomeCall_Attempt__c, '+
            			' WelcomeCall_Cooling_Off2__c, Call_Date__c, WelcomeCall_Call_Line_Status__c, Activity_Result__c, '+
            			' owner.name, welcomecall_schedule_date__c, Contact__r.welcomeCall_product_code_plan__c, Contact__r.Product_Code_Plant_TelUW__c, TelUW_Status_Call__c, '+
            			' welcomecall_first_call_date__c, Contact__r.WelcomeCall_Issued_Date__c, Contact__r.Issued_Date_TelUw__c, Contact__r.Insured_Name__c, Contact__r.LastModifiedDate  '+
                 		' FROM Call_Line__c where ';
        
        //added By Fajar Salam 13-04-2022
        if(String.isNotBlank(selectedType) && selectedType == 'uw'){
             query += 'Contact__r.Campaign_Type__c =\'TelUW\' AND createddate >= LAST_n_DAYS:'+days+' ';
             
        }else if(String.isNotBlank(selectedType) && selectedType == 'sc'){
        	query += 'Recordtype.name in(\'Welcome Call\', \'TelUW\') AND createddate >= LAST_n_DAYS:'+days+' ';
        }else{
             query += 'Recordtype.name =\'Welcome Call\' AND createddate >= LAST_n_DAYS:'+days+' ';
        }
        
        if(String.isNotBlank(polisNo)){
            query += ' AND policy_no__c =: polisNo ';
        }
        if(String.isNotBlank(selectedOwner)){
            query += ' AND ownerId =: selectedOwner ';
        }
        //edited By Fajar Salam 13-04-2022
        System.debug('[?][selectedType ] '+selectedType);
        if(String.isNotBlank(selectedType)){
            //Boolean Type = selectedType == 'True';
            //query += ' AND WelcomeCall_Fg_Schedule__c = True';
            if(selectedType == 'sc'){
                query += ' AND WelcomeCall_Fg_Schedule__c = true ';
            }else if(selectedType == 'wc'){
                query += ' AND WelcomeCall_Fg_Schedule__c = false ';
            }
            //else if(selectedType == 'uw'){
              //   query += ' AND WelcomeCall_Fg_Schedule__c = false ';
                
            //}
            
        }
        
        
        if(String.isNotBlank(selectedStatus)){
            if(selectedType == 'uw'){
               query += ' AND TelUW_Status_Call__c =: selectedStatus ';
            }else{
                query += ' AND WelcomeCall_Call_Line_Status__c =: selectedStatus ';
            }
        }
        
		if(String.isNotBlank(selectedType)){
            if(selectedType == 'uw'){
                query += ' ORDER BY welcomecall_schedule_date__c DESC, Call_Line_Status_TelUw__c ASC';
            }
        }else{
            query += ' ORDER BY welcomecall_schedule_date__c DESC, WelcomeCall_Call_Line_Status__c ASC';
        }
        
        
        taskList = new List<Call_Line__c>();
        System.debug('Query = '+ query);
        taskList = Database.query(query);
        
        // reconstrust data for teleuw
        if(String.isNotBlank(selectedType) && selectedType == 'uw'){
            taskList = reconstructDataTelUW(taskList);
        }
        
        
        System.debug('[?] data size = '+ taskList.size());
        System.debug(taskList);
        
        mapCallLine = new Map<Integer, Call_Line__c>();
        Integer i=1;
        for(Call_Line__c cl : taskList){
       		mapCallLine.put(i, cl);
            i++;
        }
        //return taskList;
        return mapCallLine;
    }
    // adde by Fajar Salam 13-04-2022
    private List<Call_Line__c> reconstructDataTelUW(List<Call_Line__c> cl){
        for(Integer i=0; i < cl.size(); i++){
            cl.get(i).WelcomeCall_Call_Line_Status__c = cl.get(i).TelUW_Status_Call__c;
            cl.get(i).Contact__r.welcomeCall_product_code_plan__c = cl.get(i).Contact__r.Product_Code_Plant_TelUW__c;
            cl.get(i).Contact__r.WelcomeCall_Issued_Date__c = cl.get(i).Contact__r.Issued_Date_TelUw__c;
                
        }
        return cl;
    }
}