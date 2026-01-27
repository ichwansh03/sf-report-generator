public class Call_Line_AMFS_ChangeOwner_Ctrl2 {
	public Integer AMFScampaignPeriod = Integer.valueOf(System.Label.CampaignPeriodForDistributionAMFS);
    public Integer uploadedNum {get; set;}
    public Integer validNum {get; set;}
    public Integer invalidNum {get; set;}
    public Integer totalPolicies {get;set;}
    public Integer totalData {get;set;}
    public Integer totalGAP {get;set;}
    public Integer inputValue {get;set;}
    public Integer totalAgents {get;set;}
    public Boolean isMaxRecord {get;set;}
    public Boolean isMethodChoosen{get;set;}
    public String entity {get; set;}
    public String choosen_campaign {get;set;}
    public String choosen_user{get;set;}
    public String prev_user{get;set;}
    public String choosen_method {get; set;}
    public String CollectionTaskArr {get; set;}
    public String url = 'https://'+system.URL.getSalesforceBaseUrl().getHost()+'/apex/TakeSurvey?id=SURVEYID&cId=CONTACTID&caId=none';
    public List<Call_List__c> campaign_list {get;set;}
    public List<Call_Line__c> callLineList {get;set;}
    public List<SelectOption> optionCampaign_list {get;set;}
    public List<String> invalidPolicyList {get;set;}
    public List<String> invalidPolicyTempList {get;set;}
    public List<AgentAssignment> assignmentList {get;set;}
    public List<User_Detail__c> agentList {get;set;}
    public List<Id> agentIDList {get;set;}
    public List<SelectOption> agentOptList {get; set;}
    public List<SelectOption> distributeOptionList {get; set;}
    public List<String> list_policyNo {get;set;}
    public Map<Id, Call_List__c> map_campaignObj {get;set;}
    public Map<string,Contact> mapContactList {get;set;}
    public Map<string,string> agentMap {get; set;}
    public Map<String, Call_Line__c> map_callLine {get;set;}
    
    Public Integer checkLoop = 0;
    Public String AMFS = 'AMFS';
    Public Decimal Total_APE {get;set;}
    Public String String_APE {get;set;}
    Public Integer campaignTarget {get;set;}
    public List<User_Detail__c> agentListView {get;set;}
    public List<Agent_Distribution_History__c> finalListAdh {get;set;}
    public map<Id,Agent_Distribution_History__c> mapAgentHistory {get;set;}
    public List<SelectOption> optionUser_list {get;set;}
    public List<SelectOption> prevUser_list {get;set;}
    public Boolean WithdrawalOrRedemptionKonven {get;set;}
    public Boolean LapseTmOrRedemptionTm {get;set;}
    public Boolean restCampaign {get;set;}
    Public List<SelectOption> statusHasCall_List {get;set;}
    Public String statusHasCall {get;set;}
    
    Public List<tempCallLine> tempCallLineList {get;set;}
    
    //coba mus
    Public Integer tempCallLineListSize {get;set;}
    Public Integer allDataSize {get; set;}
    Public Integer selectSize {get; set;}
    Public String CallStatusSet{get; set;}
    Public String ReasonStatusSet{get; set;}
    public integer index {get;set;}
    public integer blockSize {get;set;}
    public Integer pageOf {get;set;}
    public Integer allPage {get;set;}
    public Map<String, tempCallLine> mapList {get; set;}
    public List<String> selectedList {get; set;}
    
    Public boolean selectAll {get;set;}
    
    public Document document {
        get {
            if (document == null){
                document = new Document();
            }
            return document;
        }
        set;
    }
    
    public Call_Line_AMFS_ChangeOwner_Ctrl2(){
        WithdrawalOrRedemptionKonven = false;
        LapseTmOrRedemptionTm = false;
        restCampaign = false;
        
        index = 0;
        blockSize = 10;
        uploadedNum = 0;
        validNum = 0;
        invalidNum = 0;
        totalPolicies = 0;
        pageOf = 0;
        allPage = 0;
        selectAll = false;
        map_campaignObj = new Map<Id, Call_List__c>();
        User userObj = [select id, Entity__c from user where id = :UserInfo.getUserId()];
        Entity = userObj.Entity__c;
        String loggedInUser = userObj.id;
        campaign_list = Database.query('SELECT id, Name, Campaign_Name__c, Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, Survey_ID__c, Call_Line_RecordTypeID__c FROM Call_List__c WHERE Entity__c = :AMFS AND createdby.id = :loggedInUser AND IsExpired__c = false AND Is_Expired_F__c = false order by CreatedDate desc'); //AND Expired_Date__c <= system.today();
        
        optionCampaign_list = new List<SelectOption>();
        optionUser_list = new List<SelectOption>();
        prevUser_list = new List<SelectOption>();
        tempCallLineList = new List<tempCallLine>();
        selectedList = new List<String>();
        
        //coba mus
        tempCallLineListSize = 0;
        allDataSize = 0;
        selectSize = 0;
        System.debug('choosen_campaign = ' +choosen_campaign);
        
        if (campaign_list.size() > 0){
        	for(Call_List__c cl : campaign_list){
                optionCampaign_list.add(new SelectOption(cl.id, cl.Campaign_Name__c));
                map_campaignObj.put(cl.Id, cl);
            }    
        }
        else {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'There`s no campaign / call line available'));   
        }    
        // default
        isMaxRecord = FALSE;
        inputValue = 0;
        
    }
   	
    public void populateFreshData(){
        prevUser_list.clear();
        optionUser_list.clear();
        
        WithdrawalOrRedemptionKonven = false;
        LapseTmOrRedemptionTm = false;
        restCampaign = false;
        
        String campaignName = '';
        if(choosen_campaign != Null && choosen_campaign != '') campaignName = [Select id, Campaign_Name__c from Call_List__c where id = :choosen_campaign limit 1].Campaign_Name__c;
        system.debug('***Prev Agent:'+prev_user);
        
        if (campaignName.contains('Withdrawal') || campaignName.contains('Redemption Konven')) WithdrawalOrRedemptionKonven = true;
        else if (campaignName.contains('Lapse TM') || campaignName.contains('Redemption TM')) LapseTmOrRedemptionTm = true;
        else restCampaign = true;
        
        if (tempCallLineList.size() > 0) tempCallLineList.clear();
                
        checkLoop += 1;
        if(choosen_campaign != '' && choosen_campaign != Null){
            campaignTarget = Integer.valueof([SELECT Id, Max_Count_Coll_AMFS__c FROM Call_List__c WHERE Id = :choosen_campaign LIMIT 1].Max_Count_Coll_AMFS__c);
			//callLineList = [select id,owner.Name,APE__c,Parent_Call_Line__c, Agent__c,Agent__r.Name,APE_Convert__c,APE_Total_Child__c,Child_Count__c, Call_List__r.Case_Type__c, Call_List__c, F_User_Detail__c, Activity__c, Case_Type__c, Entity__c, Policy_No__c, Contact__c,Contact__r.Name, Contacted_Number__c, Survey_Type__c, Survey_ID__c,OwnerId,Owner.Name from Call_Line__c where Call_List__c = :choosen_campaign AND APE_Total_Child__c != 0 AND isOwnerQueue__c = FALSE AND Agent__c != null];
	        // 11 Maret 2020, taufik, tambah limit 1000, nanti akan di ubah pakai paging.
            //String query = 'select id,Currency__c,Name,Amount__c,APE__c,Parent_Call_Line__c, Agent__c,Agent__r.Name,APE_Convert__c,APE_Total_Child__c,Child_Count__c, Call_List__r.Case_Type__c, Call_List__c, F_User_Detail__c, Activity__c, Case_Type__c, Entity__c, Policy_No__c, Contact__c,Contact__r.Name, Contacted_Number__c, Survey_Type__c, Survey_ID__c,OwnerId,Owner.Name from Call_Line__c where Call_Status_Config__c = NULL AND Call_List__c = :choosen_campaign AND Agent__c != null and isOwnerQueue__c = FALSE AND APE_Total_Child__c != 0 '; 
        	
            String query = 'select id, Child_Count_Formula__c, Reason_Status_Config__c,Call_Status_Config__c,Currency__c,Name,Amount__c,APE__c,Parent_Call_Line__c, Agent__c,Agent__r.Name,APE_Convert__c,APE_Total_Child__c,Child_Count__c, Call_List__r.Case_Type__c, Call_List__c, F_User_Detail__c, Activity__c, Case_Type__c, Entity__c, Policy_No__c, Contact__c,Contact__r.Name, Contact__r.WelcomeCall_Effective_Date__c, Contacted_Number__c, Survey_Type__c, Survey_ID__c,OwnerId,Owner.Name, CreatedDate, Formula_Product__c from Call_Line__c where Call_List__c = :choosen_campaign AND Parent_Call_Line__c = Null '; 
        	String countQuery = 'Select count() from Call_Line__c where Call_List__c = :choosen_campaign AND Parent_Call_Line__c = Null ';
            
            if(prev_user != null){
                if(prev_user.left(3) == '00G'){
                    query += 'AND OwnerId = :prev_user';
                    System.debug('masuk owner');
                    countQuery += 'AND OwnerId = :prev_user';
                } else {
                    query += 'AND Agent__c != null AND APE_Total_Child__c != 0 AND isOwnerQueue__c = FALSE AND Agent__c = :prev_user';
                    System.debug('masuk agen');
                    countQuery += 'AND Agent__c != null AND APE_Total_Child__c != 0 AND isOwnerQueue__c = FALSE AND Agent__c = :prev_user';
                }
            }
            
            if (statusHasCall == '(none)'){
                query += ' AND Status_Has_Call__c = NULL';
                countQuery += ' AND Status_Has_Call__c = NULL';
            }
            else if (statusHasCall != NULL){
                query += ' AND Status_Has_Call__c = :statusHasCall';
                countQuery += ' AND Status_Has_Call__c = :statusHasCall';
            }
            
            //coba mus
            if(CallStatusSet != Null && CallStatusSet != '' && CallStatusSet != 'All'){
                if(CallStatusSet == '(none)'){
                    query += ' AND Call_Status_Config__c = null';
                    countQuery += ' AND Call_Status_Config__c = null';
                }else{
                    query += ' AND Call_Status_Config__c = :CallStatusSet';
                    countQuery += ' AND Call_Status_Config__c = :CallStatusSet';
                }
            }
            
            if(ReasonStatusSet != Null && ReasonStatusSet != '' && ReasonStatusSet != 'All'){
                if(ReasonStatusSet == '(none)'){
                    query += ' AND Reason_Status_Config__c = null';
                    countQuery += ' AND Reason_Status_Config__c = null';
                }else{
                    query += ' AND Reason_Status_Config__c = :ReasonStatusSet';
                    countQuery += ' AND Reason_Status_Config__c = :ReasonStatusSet';
                }
            }
            
            else{
                //query += ' ORDER BY APE_Total_Child__c DESC';
                query += ' ORDER BY '+SortField+' '+sortDir;
            }
            //coba mus
            
			query += ' limit 1000';
            callLineList = Database.query(query);
            allDataSize = Database.countQuery(countQuery);
            
            System.debug('query = ' +query);
            
            map<String,String> mapAgentCallLine = new map<String,String>();
            for (Call_Line__c cl : callLineList){
                mapAgentCallLine.put(cl.Agent__c,cl.Agent__r.Name);
                
                tempCallLine tcl = new tempCallLine();
                tcl.cl_id = cl.Id;
                if(cl.Agent__c != Null)tcl.cl_AgentName = cl.Agent__r.Name;
                else tcl.cl_AgentName = cl.Owner.Name;
                tcl.cl_Number = cl.Name;
                
                List<String> args = new String[]{'0','number','###,###,##0.00'};
                    
                // updated by Ranti MII at 2023 03 07
                // pre define ape total child is null
                double apeTotalChild = cl.APE_Total_Child__c;
                apeTotalChild = apeTotalChild == null ? 0 : apeTotalChild;
                //tcl.cl_TotalAmount = String.format(cl.APE_Total_Child__c.format(), args);      
                tcl.cl_TotalAmount = String.format(apeTotalChild.format(), args);      
                
                tcl.cl_PolicyNo = cl.Policy_No__c;
                tcl.cl_isSelected = false;
                tcl.cl_newOwner = '';
              	tcl.cl_ContactName = cl.Contact__r.Name;
                tcl.cl_ContactId = cl.Contact__c;
                tcl.cl_currency = cl.Currency__c;
                tcl.cl_callStatus = cl.Call_Status_Config__c;
                tcl.cl_ReasonStatus = cl.Reason_Status_Config__c;
                Date CreatedDate = date.newinstance(cl.CreatedDate.year(), cl.CreatedDate.month(), cl.CreatedDate.day());
                tcl.cl_createdDate = String.valueOf(CreatedDate);
                tcl.cl_product = cl.Formula_Product__c;
                tcl.cl_effectiveDate = String.valueOf(cl.Contact__r.WelcomeCall_Effective_Date__c);
                
                //if (cl.Child_Count__c == 0 || cl.Child_Count__c == null) tcl.childCount = 1;
                //else tcl.childCount = cl.Child_Count__c;
                tcl.childCount = cl.Child_Count_Formula__c;
                
				tempCallLineList.add(tcl);
            }
            
            system.debug('***Call Line List Size:'+callLineList.size()); 
            if (Total_APE == null) Total_APE = 0;
            if (checkLoop < 2){
                Decimal tempAPE = 0;
            	for (Call_Line__c cl : callLineList){
                    tempAPE = cl.APE_Total_Child__c;
                    Total_APE += tempAPE;
            	} 
                List<String> args = new String[]{'0','number','###,###,##0.00'};
                String_APE = String.format(Total_APE.format(), args);
                System.debug(String_APE);
            }
            
            String query2 = 'select id from Call_Line__c where Call_List__c = :choosen_campaign and isOwnerQueue__c = FALSE and Agent__c= null and Parent_Call_Line__c != NULL';
            if (prev_user != null) query2 += 'AND Agent__c = :prev_user';
            
            List<Call_Line__c> checkGAP = Database.query(query);
            totalGAP = checkGAP.size();
            
            String FilterResult = ''; 
            if (callLineList.size() > 0) {
                FilterResult = callLineList[0].F_User_Detail__c;
            }
            agentList = [SELECT id, User__c,Max_Capacity_Amount__c, User__r.Name, Name FROM User_Detail__c WHERE Entity__c = :AMFS AND Outbound_Activity_Case_type__c != null AND Outbound_Activity_Case_type__c includes (:FilterResult) ];
            
            String nameCamp = '%' +map_campaignObj.get(choosen_campaign).Case_Type_Config__c +'%';
            List<Group> queue = [Select Id, Name From Group Where type = 'Queue' and Name like :nameCamp and Name like 'AMFS CR%'];
            
            Schema.DescribeFieldResult Status_Has_Call_Field = Call_Line__c.Status_Has_Call__c.getDescribe();
   			List<Schema.PicklistEntry> ple = Status_Has_Call_Field.getPicklistValues();
        	statusHasCall_List = new list<SelectOption>();
            statusHasCall_List.add(new SelectOption('(none)', 'Blank (none)'));
            
   			for( Schema.PicklistEntry f : ple){
      			statusHasCall_List.add(new SelectOption(f.getLabel(), f.getValue()));
   			}       
            
            totalAgents = agentList.size();
            agentListView = agentList.clone();
            system.debug('## Query Useer Detail : '+FilterResult);
            
            //List<AggregateResult> getCallLineOwner = [SELECT Agent__r.Name,Agent__c, Count(Id) hasCallLine FROM Call_Line__c where call_list__c = :choosen_campaign AND Parent_Call_Line__c = NULL GROUP BY Agent__r.Name,Agent__c ORDER BY Agent__r.Name LIMIT 10000]; 
            List<AggregateResult> getCallLineOwner = [SELECT Owner.Name, OwnerId, Count(Id) hasCallLine FROM Call_Line__c where call_list__c = :choosen_campaign AND Parent_Call_Line__c = NULL GROUP BY Owner.Name, OwnerId ORDER BY Owner.Name LIMIT 10000]; 
            
            for (AggregateResult prvOwner : getCallLineOwner){
                //prevUser_list.add(new SelectOption((String)prvOwner.get('Agent__c'),(String)prvOwner.get('Name')));
                prevUser_list.add(new SelectOption((String)prvOwner.get('OwnerId'),(String)prvOwner.get('Name')));
            }
            
            for(Group test : queue){
                //prevUser_list.add(new SelectOption(test.Id, test.Name));
                optionUser_list.add(new SelectOption(test.Id, test.Name));
            }
            
            for (user_detail__c ud : agentList){
                //prevUser_list.add(new SelectOption(ud.User__c, ud.Name));	
                optionUser_list.add(new SelectOption(ud.User__c, ud.Name));
            }
        }
        system.debug('**ASLINYA: '+tempCallLineList.size());
    }
    
    //coba mus
    public void selectedSizeCount(){
        selectSize = 0;
        for (tempCallLine tcl : tempCallLineList){
            if(tcl.cl_isSelected == true){
                selectSize = selectSize + 1;
            }
        }
    }
    //coba mus
    
    public void selectAll(){
        system.debug('**selectAll: '+mapList);
        selectSize = mapList.size();
    	for (tempCallLine tcl : tempCallLineList){
            if(mapList.get(tcl.cl_id) != null){
                tcl.cl_isSelected = true;
                selectedList.add(tcl.cl_id);
                System.debug('tcl tcl.cl_isSelected 1 ' +tcl.cl_isSelected);
            }
        } 
    }
    
    public PageReference save() {  
        //Coba mus
        String jobId = [Select Id, job_id__c From Call_List__c where Id =:choosen_campaign].job_id__c;
        if(jobId != Null && jobId != ''){
            List<AsyncApexJob> jobList = [SELECT Id, Status FROM AsyncApexJob Where Id = :jobId];
            if(jobList.size() > 0){
                String batchStatus = jobList[0].Status;
                if(batchStatus != 'Completed'){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please Wait Until The Previous Process Is Complete'));
                    return null;
                }
            }
        }
        //Coba mus
        
        List<Call_Line__c> clUpdate = new list <Call_Line__c>();
        for (tempCallLine tcl : tempCallLineList){
            system.debug('**PAS SAVE: '+tcl.cl_isSelected);     
            if (tcl.cl_isSelected == true){
            	Call_Line__c ncl = new Call_Line__c();
                ncl.id = tcl.cl_id;
                if (choosen_user.left(3) != '00G') ncl.Agent__c = choosen_user;
                else ncl.Agent__c = NULL;
                ncl.OwnerId = choosen_user;
                clUpdate.add(ncl);
            }
        } 
        Set<Call_Line__c> myset = new Set<Call_Line__c>();
        List<Call_Line__c> result = new List<Call_Line__c>();
        myset.addAll(clUpdate);
        result.addAll(myset);
        system.debug('***result: '+result.size());
        if (result.size() > 0) {
            //update result;  
            //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please don\'t Change Owner, Wait Until Process Finished'));
            Batch_ChangeOwner_CallLine_AMFS bb = new Batch_ChangeOwner_CallLine_AMFS(result);
            //Database.executeBatch(bb,100);
            
            //coba mus
            String job_Id = Database.executeBatch(bb,100);
            
            Call_List__c clJob = new Call_List__c();
            clJob.Id = choosen_campaign;
            clJob.job_id__c = job_Id;
            Update clJob;
            //coba mus
            
            PageReference tempPage = ApexPages.currentPage();
            tempPage.setRedirect(true);
            return tempPage;
            //return null;
        }
        else {
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Please select at least 1 call line'));  
            return null;
        } 
    }
    
    //coba mus
    public List<SelectOption> CallStatusConfig{
        get{
            List<SelectOption> options = new List<SelectOption>();
            
            if(choosen_campaign == Null || choosen_campaign == ''){
                
            } else{
                List<AggregateResult> CallStatusConfigList = [Select Call_Status_Config__c from Call_line__c where Parent_Campaign__c = :choosen_campaign group by Call_Status_Config__c];
                for(AggregateResult bn : CallStatusConfigList){
                    String batch = String.ValueOf(bn.get('Call_Status_Config__c'));
                    if(batch == Null) batch = '(none)';
                    options.add(new SelectOption(batch, batch));
                }
            }
            return options;
        }
    }
    
    public List<SelectOption> ReasonStatusConfig{
        get{
            List<SelectOption> options = new List<SelectOption>();
            
            if(choosen_campaign == Null || choosen_campaign == ''){
                
            } else{
                List<AggregateResult> ReasonStatusConfigList = [Select Reason_Status_Config__c from Call_line__c where Parent_Campaign__c = :choosen_campaign group by Reason_Status_Config__c];
                for(AggregateResult bn : ReasonStatusConfigList){
                    String batch = String.ValueOf(bn.get('Reason_Status_Config__c'));
                    if(batch == Null) batch = '(none)';
                    options.add(new SelectOption(batch, batch));
                }
            }
            return options;
        }
    }
    //coba mus
    
    //coba pagination
    public String sortDir {
        get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
        set;
    }
    public void toggleSort() {
        sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
        populateFreshData();
    }
    public String sortField {
        get  { if (sortField == null) {sortField = 'CreatedDate'; } return sortField;  }
        set;
    }
    
    public void beginning(){
        index = 0;
        selectedList = new List<String>();
        selectSize = 0;
    }
    
    public void previous(){
        index = index - blockSize;
        selectedList = new List<String>();
        selectSize = 0;
    }
    
    public void next()
    {
        index = index + blockSize;
        selectedList = new List<String>();
        selectSize = 0;
    }
    
    public void end(){
        index = allDataSize - math.mod(allDataSize,blockSize);
        selectedList = new List<String>();
        selectSize = 0;
    }
    
    public boolean getprev(){
        if(index == 0)
            return true;
        else
            return false;
    }
    
    public boolean getnxt(){
        if((index + blockSize) >= allDataSize)
            return true;
        else
            return false;
    }
    
    public void reloadPage(){
        selectedList = new List<String>();
        selectSize = 0;
    }
    
    public List<SelectOption> getBlock_Size(){
        List<SelectOption> options = new List<SelectOption>();
        //String opsi = label.CL_BlockSize; --> change blocksize to amfs collection only (catur, 20210708)
        String opsi = label.CL_BlockSize_AMFS_Collection;
        
        //added by Ranti MII 8/5/2023
        User checkUser = [select id, UserRoleId, UserRole.Name from User where id =: userInfo.getUserId()];
        String roleName = checkUser.UserRole.Name;
        if (String.isNotBlank(roleName) && roleName.contains('Outbound')) {
            opsi = label.CL_BlockSize_AMFS_outbound;
        }
        
        List<String> listopsi = new List<String>();
        if(opsi!=null && opsi!='') listopsi = opsi.split(';');
        if(listopsi.size()>0){
            for(String s:listopsi){
                options.add(new SelectOption(s,s));
            }
        }
		return options;   
     }
    
    public List<tempCallLine> getListCall(){
        if(choosen_campaign == null || choosen_campaign == '') {
            pageOf = 0;
            allPage = 0;
            allDataSize = 0;
        } else {
            pageOf = index/BlockSize + 1;
            allPage = (allDataSize/BlockSize) + 1;
        }

        mapList = new Map<String, tempCallLine>();
        populateFreshData();
        List<tempCallLine> listcl2 = new List<tempCallLine>();
        listcl2 = tempCallLineList;
        tempCallLineListSize = listcl2.size();
        Integer endblock = blockSize + index;
        if(endblock>=tempCallLineListSize) endblock = tempCallLineListSize;
        for(Integer i = index ; i < endblock ; i++){
            mapList.put(listcl2.get(i).cl_id, listcl2.get(i));
            System.debug('tcl tcl.cl_isSelected 2 ' +listcl2.get(i).cl_isSelected);
        }
        
        tempCallLineListSize = mapList.size();
        if(selectedList.size() > 0){
            for(String idList : selectedList){
                if(mapList.get(idList) != Null){
                    mapList.get(idList).cl_isSelected = true;
                }
            }
        }
        
        return mapList.values();
    }
    //coba pagination
    
    public class tempUserAssignment{
        public Integer totalPolicy;
        public Decimal totalAPE;
    }

    public class AgentAssignment{
        public string agentId {get; set;}    
        public string agentName {get; set;}      
        public integer policyTotal {get; set;}
        public decimal apeDistributed {get; set;}
        public string StringAPE_Distributed {get;set;}
    }
    
    public class tempCallLine{
        Public id cl_id {get;set;}
        Public String cl_AgentName {get;set;}
        Public String cl_TotalAmount {get;set;}
        Public boolean cl_isSelected {get;set;}
        Public String cl_PolicyNo {get;set;}
        Public String cl_newOwner {get;set;}
        Public id cl_ContactId {get;set;}
        Public String cl_ContactName {get;set;}
        Public String cl_Number {get;set;}
        Public Decimal childCount {get;set;}
        Public String cl_Currency {get;set;}
        Public String cl_callStatus {get;set;}
        Public String cl_ReasonStatus {get;set;}
        Public String cl_createdDate {get;set;}
        Public String cl_product {get;set;}
        Public String cl_effectiveDate {get;set;}
    }
}