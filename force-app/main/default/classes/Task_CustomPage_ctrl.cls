/*---------------------------------------------------------------
    Author      : Fikri Hailal
    Company     : MII
    Description : Custom Task Record detail page
    Inputs      : -none-
    Test Class  : -

    <History>
    <Date>      <Authors Name>     <Brief Description of Change>    
    07102021    Fikri Hailal          Created
---------------------------------------------------------------*/
public class Task_CustomPage_ctrl {
    public String id {get;set;}
    public String parent_id {get;set;} 
    // public List<Task> activity_history {get;set;}
    // public List<Task> open_activity {get;set;} 
    public List<AXAAPI011A_response.Data> list_task_res {get;set;} 
    public List<AXAAPI005B_response.Data> list_attachment {get;set;}
    // public List<Data> listData {get;set;}
    // public Data taskData {get;set;}
    
    public AXAAPI011B_response task_res {get;set;} 
    public boolean isConsole {get;set;}
    
    
    public String processTime {get;set;}
    public Integer skip {get;set;}
    public Integer take {get;set;} 
    public Integer total_page {get;set;}
    public Integer current_page {get;set;}
    public String to_page {get;set;}
    public List<string> list_page {get;set;}
    public static final Integer SIZE_DATA_RELATED_LIST = Integer.valueOf(Label.AXASFDC_RowLimitRelatedList);   
    
    
    public Long mulai {get;set;}
    public Long selesai {get;set;}
    public Integer totalRow {get;set;} 
    public boolean reloadActivityHistory{get;set;}
    public boolean reloadOpenActivity{get;set;}
    
    /* 
     public class Data {
        public data() {}
        public String id {get;set;}
		public String OwnerId {get;set;} 
		public Integer CallDurationInSeconds {get;set;} 
		public String CallObject {get;set;} 
		public String CallDisposition {get;set;} 
		public String CallType {get;set;} 
		public String Description {get;set;} 
		public Datetime CompletedDateTime {get;set;} 
		public Boolean IsRecurrence {get;set;} 
		public String CreatedById {get;set;} 
		public Datetime ActivityDate {get;set;} 
        public String LastModifiedById {get;set;}
        public String WhoId {get;set;}
        public String Priority {get;set;}
		public String WhatId {get;set;} 
		public Boolean IsReminderSet {get;set;} 
		public String RecurrenceRegeneratedType {get;set;} 
		public String Status {get;set;} 
		public String Subject {get;set;} 
		public String RecordTypeId {get;set;} 
		public String TaskSubtype {get;set;} 
        
    }
	*/
    
    
    
    
    public Task_CustomPage_ctrl(ApexPages.StandardController controller){
        refresh();
        //id = ApexPages.currentPage().getParameters().get('id');
        //entity = [SELECT Entity__c FROM Contact WHERE Id=:id].Entity__c;
        id = ApexPages.currentPage().getParameters().get('id');  
        Cache.SessionPartition sessionPart = Cache.Session.getPartition('local.axaPartition');
        
        // if(id.left(3) == Schema.SObjectType.Task.getKeyPrefix()){ task_res = getTaskDetail(id);}
        // system.debug('taskData:'+taskData);
         
    }
    public Task_CustomPage_ctrl(){
        
        refresh();
       id = ApexPages.currentPage().getParameters().get('id');  
        Cache.SessionPartition sessionPart = Cache.Session.getPartition('local.axaPartition');
        
        if(id.left(3) == Schema.SObjectType.Task.getKeyPrefix() || test.isRunningTest()){ 
            String uniqueId = ApexPages.currentPage().getParameters().get('lastId'); 
            System.debug('::uniqueId:'+uniqueId);
            System.debug('::id.length():'+id.length());
            if (id.length() > 14 && id.length() < 18 && uniqueId != null) {
                id = id+uniqueId;
            }  
            task_res = getTaskDetail(id);
        }
        // system.debug('taskData:'+taskData);
        
        String urlVal = Apexpages.currentPage().getUrl();
        system.debug(':::URl:'+urlVal);
        if(urlVal != null && urlVal.contains('console')) {
             isConsole = false;  
        } else {
            isConsole = true;    
        }   
    }
    
    
    public void refresh(){  
        processTime = ''; 
        totalRow = 0;
        skip = 0;
        current_page = 1;
        total_page = 1; 
        take = SIZE_DATA_RELATED_LIST;
        list_page = new List<String>();    
    }
    
    public void getDataNext(){    
        Map<string,integer> pagination = AXAAPI_UtilityClass.getDataNext(current_page); 
        if (pagination.containsKey('skip')) {
            skip = pagination.get('skip');
        } 
        if (pagination.containsKey('take')) {
            take = pagination.get('take');
        } 
        if (pagination.containsKey('current_page')) {
            current_page = pagination.get('current_page');
        }  
        
        system.debug('::reloadActivityHistory:'+reloadActivityHistory);
        system.debug('::reloadOpenActivity:'+reloadOpenActivity);
        if (reloadActivityHistory == true) loadActivityHistory();
        if (reloadOpenActivity == true) loadOpenActivity();
    }
     
    public void getDataPrevious(){  
        Map<string,integer> pagination = AXAAPI_UtilityClass.getDataPrevious(current_page); 
        
        if (pagination.containsKey('skip')) {
            skip = pagination.get('skip');
        } 
        if (pagination.containsKey('take')) {
            take = pagination.get('take');
        } 
        if (pagination.containsKey('current_page')) {
            current_page = pagination.get('current_page');
        } 
        
        system.debug('::reloadActivityHistory:'+reloadActivityHistory);
        system.debug('::reloadOpenActivity:'+reloadOpenActivity);
        if (reloadActivityHistory == true) loadActivityHistory();
        if (reloadOpenActivity == true) loadOpenActivity();
         
    }
    
    
    public void getDataToPage(){  
        Map<string,integer> pagination = AXAAPI_UtilityClass.getDataToPage(current_page, to_page); 
        if (pagination.containsKey('skip')) {
            skip = pagination.get('skip');
        } 
        if (pagination.containsKey('take')) {
            take = pagination.get('take');
        } 
        if (pagination.containsKey('current_page')) {
            current_page = pagination.get('current_page');
        }  
        
        system.debug('::reloadActivityHistory:'+reloadActivityHistory);
        system.debug('::reloadOpenActivity:'+reloadOpenActivity);
        if (reloadActivityHistory == true) loadActivityHistory();
        if (reloadOpenActivity == true) loadOpenActivity();
    }
    
    public void getDataFirst(){ 
  
        Map<string,integer> pagination = AXAAPI_UtilityClass.getDataFirst(current_page); 
        if (pagination.containsKey('skip')) {
            skip = pagination.get('skip');
        } 
        if (pagination.containsKey('take')) {
            take = pagination.get('take');
        } 
        if (pagination.containsKey('current_page')) {
            current_page = pagination.get('current_page');
        }  
        
        system.debug('::reloadActivityHistory:'+reloadActivityHistory);
        system.debug('::reloadOpenActivity:'+reloadOpenActivity);
        if (reloadActivityHistory == true) loadActivityHistory();
        if (reloadOpenActivity == true) loadOpenActivity();
    }
    
    public void getDataLast(){  
        Map<string,integer> pagination = AXAAPI_UtilityClass.getDataLast(total_page); 
        
        if (pagination.containsKey('skip')) {
            skip = pagination.get('skip');
        } 
        if (pagination.containsKey('take')) {
            take = pagination.get('take');
        } 
        if (pagination.containsKey('current_page')) {
            current_page = pagination.get('current_page');
        } 
        
        system.debug('::reloadActivityHistory:'+reloadActivityHistory);
        system.debug('::reloadOpenActivity:'+reloadOpenActivity);
        if (reloadActivityHistory == true) loadActivityHistory();
        if (reloadOpenActivity == true) loadOpenActivity();
    } 
    
    
    public void setOpenActivity() { 
         reloadOpenActivity = true;
         reloadActivityHistory = false;
    }
    
    public void setActivityHistory() { 
         reloadActivityHistory = true;
         reloadOpenActivity = false;
    }
    
    
     
    public void loadActivityHistory(){
        
         reloadOpenActivity = false;
         reloadActivityHistory = true;
        mulai =  DateTime.now().getTime(); 
        id = ApexPages.currentPage().getParameters().get('id');  
        list_task_res = new List<AXAAPI011A_response.Data>();
        // List<Contact> list_con = [SELECT Id, Policy_No__c FROM Contact WHERE Id='0039000001XRdns' LIMIT 1];
        /* List<Contact> list_con = [SELECT Id, Entity__c FROM Contact WHERE Id=:id LIMIT 1];
        if(list_con.size()>0){
            Contact con = list_con[0];
            // AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByPolicy.getTaskActHistoryByPolicy('00T2s00000LgHuFEAV'); //berikut adalah id user hendrik, setelah diperiksa dengan salesforce sb, idnya tidak sama
            
            //AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByParam.getTaskByParam('activity-history','entity__c',con.Entity__c);
            AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByParam.getTaskByParam('activity-history','whoid',con.Id); 
            if(res != NULL && res.data != NULL){
                
                //res.data.Owner_name  =  AXAAPI_UtilityClass.getsObjectNameById(res.data.Owner, 'Contact', 'Name');
       			//res.data.template_email_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.template_email_c, 'Email_SMS_Template__c', 'Name');
                
                list_task_res = res.data;
            }
        }*/ 
        // AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByPolicy.getTaskActHistoryByPolicy('00T2s00000LgHuFEAV'); //berikut adalah id user hendrik, setelah diperiksa dengan salesforce sb, idnya tidak sama
        
        //AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByParam.getTaskByParam('activity-history','entity__c',con.Entity__c);
        AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByParam.getTaskByParam('activity-history','whoid',Id,skip,take); 
        
        if(res != NULL && res.data != NULL){ 
            list_task_res = res.data;
            
            totalRow = res.counts; 
            Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
            countPage = countPage.round(System.RoundingMode.CEILING);
            total_page = integer.valueOf(countPage); 
        } else if(res != NULL && res.message != NULL){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, res.message));
        }else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'time out from server'));
        }
        
        list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page); 
        
        selesai =  Datetime.now().getTime();
        system.debug('selesai == '+selesai); 
        system.debug('mulai == '+mulai); 
        processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
        processTime += '<br/>Total : ' + totalRow + ' records';
        system.debug('processTime == '+processTime);

    }
    
     public void loadOpenActivity(){
         reloadOpenActivity = true;
         reloadActivityHistory = false;
        mulai =  DateTime.now().getTime(); 
        id = ApexPages.currentPage().getParameters().get('id');  
        list_task_res = new List<AXAAPI011A_response.Data>();
        // List<Contact> list_con = [SELECT Id, Policy_No__c FROM Contact WHERE Id='0039000001XRdns' LIMIT 1];
        /* List<Contact> list_con = [SELECT Id, Entity__c FROM Contact WHERE Id=:id LIMIT 1];
        if(list_con.size()>0){
            Contact con = list_con[0];
            // AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByPolicy.getTaskActHistoryByPolicy('00T2s00000LgHuFEAV'); //berikut adalah id user hendrik, setelah diperiksa dengan salesforce sb, idnya tidak sama
            //AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByParam.getTaskByParam('open-activity/','entity__c',con.Entity__c); 
            AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByParam.getTaskByParam('open-activity/','whoid',con.Id); 
            if(res != NULL && res.data != NULL){
                
                //res.data.Owner_name  =  AXAAPI_UtilityClass.getsObjectNameById(res.data.Owner, 'Contact', 'Name');
       			//res.data.template_email_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.template_email_c, 'Email_SMS_Template__c', 'Name');
                
                list_task_res = res.data;
            }
        } */ 
         // AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByPolicy.getTaskActHistoryByPolicy('00T2s00000LgHuFEAV'); //berikut adalah id user hendrik, setelah diperiksa dengan salesforce sb, idnya tidak sama
         //AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByParam.getTaskByParam('open-activity/','entity__c',con.Entity__c); 
         AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByParam.getTaskByParam('open-activity/','whoid',id, skip, take);  
         
         if(res != NULL && res.data != NULL){ 
             list_task_res = res.data;
             
             
            
            totalRow = res.counts; 
            Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
            countPage = countPage.round(System.RoundingMode.CEILING);
            total_page = integer.valueOf(countPage);
                 
         } else if(res != NULL && res.message != NULL){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, res.message));
        }else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'time out from server'));
        }
        
        list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page); 
        
        selesai =  Datetime.now().getTime();
        system.debug('selesai == '+selesai); 
        system.debug('mulai == '+mulai); 
        processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
        processTime += '<br/>Total : ' + totalRow + ' records';
        system.debug('processTime == '+processTime);
         
     }
    public PageReference redirect(){
        List<Task> listTask = [SELECT Id FROM Task WHERE Id=:id limit 1];
        if(listTask.size() > 0){
            PageReference pageRef = new PageReference('/'+id);
            // return pageRef;
            return NULL;
        }else{
            return NULL;
        }
    }
    
    
    /*public void loadOpenActivity(){
        id = ApexPages.currentPage().getParameters().get('id');  
        list_task_res = new List<AXAAPI011A_response.Data>();
        //List<Contact> list_con = [SELECT Id, Policy_No__c FROM Contact WHERE Id=:id LIMIT 1];
        List<Contact> list_con = [SELECT Id, Policy_No__c FROM Contact WHERE Id='0039000001XRdns' LIMIT 1];
        if(list_con.size()>0){
            Contact con = list_con[0];
            AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByPolicy.getTaskActHistoryByPolicy('509-5116520');
            if(res != NULL && res.data != NULL){
                
                //res.data.Owner_name  =  AXAAPI_UtilityClass.getsObjectNameById(res.data.Owner, 'Contact', 'Name');
       			//res.data.template_email_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.template_email_c, 'Email_SMS_Template__c', 'Name');
                
                list_task_res = res.data;
            }
    	}
    }*/
    
    
     /*public void loadPureCloudInbound(){
        id = ApexPages.currentPage().getParameters().get('id');  
        list_task_res = new List<AXAAPI011A_response.Data>();
        //List<Contact> list_con = [SELECT Id, Policy_No__c FROM Contact WHERE Id=:id LIMIT 1];
        List<Contact> list_con = [SELECT Id, Policy_No__c FROM Contact WHERE Id='0039000001XRdns' LIMIT 1];
         if(list_con.size()>0){
            Contact con = list_con[0];
            AXAAPI011A_response res = AXAAPI011A_TaskPureCloudInbound.getTaskPureCloudInbound(con.Id);
            if(res != NULL && res.data != NULL){
                
                //res.data.Owner_name  =  AXAAPI_UtilityClass.getsObjectNameById(res.data.Owner, 'Contact', 'Name');
       			//res.data.template_email_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.template_email_c, 'Email_SMS_Template__c', 'Name');
                
                list_task_res = res.data;
            }
    	}
    }*/
    
    /*public void loadPureCloudOutBound(){
        id = ApexPages.currentPage().getParameters().get('id');  
        list_task_res = new List<AXAAPI011A_response.Data>();
        //List<Contact> list_con = [SELECT Id, Policy_No__c FROM Contact WHERE Id=:id LIMIT 1];
        List<Contact> list_con = [SELECT Id, Policy_No__c FROM Contact WHERE Id='0039000001XRdns' LIMIT 1];
        if(list_con.size()>0){
            Contact con = list_con[0];
            AXAAPI011A_response res = AXAAPI011A_TaskPureCloudOutbound.getTaskPureCloudOutbound(con.Id);
            if(res != NULL && res.data != NULL){
                
                //res.data.Owner_name  =  AXAAPI_UtilityClass.getsObjectNameById(res.data.Owner, 'Contact', 'Name');
       			//res.data.template_email_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.template_email_c, 'Email_SMS_Template__c', 'Name');
                
                list_task_res = res.data;
            }
    	}
    }
    */
    
     public AXAAPI011B_response getTaskDetail(String task_id){
        task_res = AXAAPI011B_TaskByID.getTaskByID(task_id);
        
        return task_res;
    }
    
    /*public Data getTaskDetail(String TaskId){
        
        Task tah = [SELECT id,OwnerId,CallDurationInSeconds,CallObject,CallDisposition,CallType,Description,CompletedDateTime,IsRecurrence,CreatedById,ActivityDate,LastModifiedById,WhoId,Priority,RecurrenceInterval,WhatId,IsReminderSet,RecurrenceRegeneratedType,Status,Subject,RecordTypeId,TaskSubtype FROM Task where id =: TaskId limit 1 ]; 
			
        Data setData = new Data();
        setData.id = tah.id;
        setData.OwnerId = AXAAPI_UtilityClass.getsObjectNameById(tah.OwnerId, 'Contact', 'Name'); 
        setData.CallDurationInSeconds = tah.CallDurationInSeconds;
        setData.CallObject = tah.CallObject;
        setData.CallDisposition = tah.CallDisposition;
        setData.CallType = tah.CallType;
        setData.Description = tah.Description;
        setData.CompletedDateTime = tah.CompletedDateTime;
        setData.IsRecurrence = tah.IsRecurrence;
        setData.CreatedById = AXAAPI_UtilityClass.getsObjectNameById(tah.CreatedById, 'Contact', 'Name');  //tah.CreatedById;
        setData.ActivityDate = tah.ActivityDate;
        setData.LastModifiedById = tah.LastModifiedById;
        setData.WhoId = tah.WhoId;
        setData.Priority = tah.Priority;
        
        setData.WhatId = tah.WhatId;
        setData.IsReminderSet = tah.IsReminderSet;
        setData.RecurrenceRegeneratedType = tah.RecurrenceRegeneratedType;
        setData.Status = tah.Status;
        setData.Subject = tah.Subject;
        setData.RecordTypeId = tah.RecordTypeId;
        setData.TaskSubtype = tah.TaskSubtype;
        
        
        
        return setData;
    }*/
    
    public void loadAttachments(){
       id = ApexPages.currentPage().getParameters().get('id'); 
       list_attachment = new List<AXAAPI005B_response.Data>(); 
        // AXAAPI005B_response res = AXAAPI005B_AttachmentByCaseID.getAttachmentByCaseID('02s6F00000fTo4GQAS');
        AXAAPI005B_response res = AXAAPI005B_AttachmentByCaseID.getAttachmentByCaseID(id,0,10);
        if(res != NULL && res.data != NULL){
            list_attachment = res.data; 
        }
    }
    
    
}