public class ArchiveData_Search_ctrl {
    
    public String obj {get;set;}
    public String key {get;set;}
    public String value {get;set;}
    public String processTime {get;set;}
    public String contactId {get;set;}
    public String contactName {get;set;}
    
    public Integer skip {get;set;}
    public Integer take {get;set;}
    public static final Integer SIZE_DATA = Integer.valueOf(Label.AXASFDC_RowLimit);
    public static final Integer SIZE_DATA_purecloud = 20;
    public static final Integer MIN_CHAR = Integer.valueOf(Label.AXASFDC_MinCharParam);
    public Integer total_page {get;set;}
    public Integer current_page {get;set;}
    public String to_page {get;set;}
    public List<String> list_page {get;set;}
    
    
    public Long mulai {get;set;}
    public Long selesai {get;set;}
    public Integer totalRow {get;set;}
    //public Boolean isConsole {get;set;}
    
    public List<AXAAPI001C_response.Data> list_case {get;set;}
    public List<AXAAPI002C_response.Data> list_email {get;set;}
    public List<AXAAPI023A_response.Data> list_campaign {get;set;}
    
    // added by ranti at 12/08/2021
    public List<AXAAPI020A_response.Data> listDataPureCloudAgent {get;set;}  
    public List<AXAAPI024A_response.Data> list_pureCallService {get;set;}
    public boolean showKeyword {get;set;}
    
    public string urlParam {get;set;}
    public string postUrl {get;set;}
    public string postUrlEmail {get;set;}
    
    
    public ArchiveData_Search_ctrl() {
        obj = 'Case';
        refresh();
        take = SIZE_DATA;
        //String urlVal = Apexpages.currentPage().getUrl();
        //system.debug('urlVal:'+urlVal);
        //if(urlVal.contains('console')) isConsole = TRUE; else isConsole = FALSE;
    }
    
    public void refresh(){ 
        list_case = new List<AXAAPI001C_response.Data>();
        list_email = new List<AXAAPI002C_response.Data>();
        list_campaign = new List<AXAAPI023A_response.Data>();
        listDataPureCloudAgent = new List<AXAAPI020A_response.Data>();
        list_pureCallService = new List<AXAAPI024A_response.Data>();
        
        processTime = '';
        value = '';
        totalRow = 0;
        skip = 0;
        current_page = 1;
        total_page = 1;
        list_page = new List<String>();   
        System.debug('Key == '+key); 
        
        if (obj == 'Case' && key == 'contactId') {
            showKeyword = false;
        } 
        /* else if ((obj == 'Purecloud__c' || obj == 'PureCloud_Call_Service__c') && (key == 'Entity__c' || key == 'Date__c')) */
        else if ((obj == 'Purecloud__c') && (key == 'Entity__c' || key == 'Date__c')){
            showKeyword = false;
        } else {
            showKeyword = true;
        }
    }
    
    public List<SelectOption> getObjectList() {
        List<SelectOption> tempList = new List<SelectOption>();
        tempList.add(new SelectOption('Case', 'Case'));
        tempList.add(new SelectOption('EmailMessage', 'Email Message'));
        tempList.add(new SelectOption('Call_List__c', 'Campaign'));
        tempList.add(new SelectOption('Purecloud__c', 'PureCloud-Call Agent'));
        tempList.add(new SelectOption('PureCloud_Call_Service__c', 'PureCloud-Call Service'));
        return tempList;
    }
    
    public List<SelectOption> getParamList() {
        List<SelectOption> tempList = new List<SelectOption>();
        if(this.obj != NULL && this.obj == 'Case'){
            tempList.add(new SelectOption('subject', 'Subject Case'));
            tempList.add(new SelectOption('policy_Numbers__c', 'Policy Number'));
            tempList.add(new SelectOption('caseNumber', 'Case Number'));
            tempList.add(new SelectOption('contactId', 'Contact Name'));
            tempList.add(new SelectOption('insured_Name__c', 'Insured Name'));
            tempList.add(new SelectOption('contact_Mobile__c', 'Mobile'));
            tempList.add(new SelectOption('suppliedPhone', 'Phone'));
            //tempList.add(new SelectOption('social-account', 'Social Personal'));
        }else if(this.obj != NULL && this.obj == 'EmailMessage'){
            tempList.add(new SelectOption('fromAddress', 'Email Address'));
            //tempList.add(new SelectOption('toAddress', 'Email To'));
            tempList.add(new SelectOption('subject', 'Subject Email'));
        }else if(this.obj != NULL && this.obj == 'Call_List__c'){
            tempList.add(new SelectOption('name', 'Campaign Number'));
            tempList.add(new SelectOption('campaign_Name__c', 'Campaign Name'));
            //tempList.add(new SelectOption('toAddress', 'Email To'));
            //tempList.add(new SelectOption('subject', 'Subject Email'));
        } else if(this.obj != NULL && this.obj == 'Purecloud__c'){ 
        	tempList.add(new SelectOption('Name', 'PureCloud Name'));
            tempList.add(new SelectOption('Date__c', 'Date'));
            // tempList.add(new SelectOption('Entity__c', 'Entity'));
        } else if(this.obj != NULL && this.obj == 'PureCloud_Call_Service__c'){  
            tempList.add(new SelectOption('Name', 'PureCloud Call Number')); 
            // tempList.add(new SelectOption('Entity__c', 'Entity'));
        }
        return tempList;
    }
    
    // Kebutuhan untuk purecloud
    /* public List<SelectOption> getEntityList() {
        List<SelectOption> tempList = new List<SelectOption>();
        tempList.add(new SelectOption('AFI', 'AFI'));
        tempList.add(new SelectOption('ALI', 'ALI'));
        tempList.add(new SelectOption('AMFS', 'AMFS'));
        tempList.add(new SelectOption('MAGI', 'MAGI'));
        return tempList;
    } */
    
    /* public void getDataNext(){
        Integer to_page = current_page + 1;
        skip = (to_page - 1) * SIZE_DATA + 1;
        current_page = to_page;
        take = to_page * SIZE_DATA;
        getData();
        system.debug('skip:'+skip);
        system.debug('current_page:'+current_page);
        system.debug('take:'+take);
    }
    
    public void getDataPrevious(){
        Integer to_page = current_page - 1;
        skip = (to_page - 1) * SIZE_DATA + 1;
        current_page = to_page;
        take = to_page * SIZE_DATA;
        getData();
        system.debug('skip:'+skip);
        system.debug('current_page:'+current_page);
        system.debug('take:'+take);
    }
    
    public void getDataToPage(){
        Integer to_page = Integer.valueOf(to_page);
        skip = (to_page - 1) * SIZE_DATA + 1;
        current_page = to_page;
        take = to_page * SIZE_DATA;
        getData();
        system.debug('skip:'+skip);
        system.debug('current_page:'+current_page);
        system.debug('take:'+take);
    }
    
    public void getDataFirst(){
        skip = 0;
        current_page = 1;
        take = SIZE_DATA;
        getData();
        system.debug('skip:'+skip);
        system.debug('current_page:'+current_page);
        system.debug('take:'+take);
    }
    
    public void getDataLast(){
        Integer to_page = list_page.size();
        skip = (to_page - 1) * SIZE_DATA + 1;
        current_page = to_page;
        take = to_page * SIZE_DATA;
        getData();
        system.debug('skip:'+skip);
        system.debug('current_page:'+current_page);
        system.debug('take:'+take);
    } */
      
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
        getData();
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
        getData();
         
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
        getData();
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
        getData();
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
        getData();
         
    } 
   
    public void getData(){
        
        system.debug('contactId:'+contactId);
        if(obj == 'Case' && key == 'contactId') value = contactId;
        
        //added by Ranti for purecloud call agent
       	
        if (key == 'Date__c') { 
            Date convertDate = date.parse(value);
            value = string.valueOf(convertDate); 
        }
        
        // remove space
        value = value.trim();
        
        if(value.length() < MIN_CHAR){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please enter at least 3 chars'));
        }else{
            mulai =  DateTime.now().getTime();
            system.debug('mulai == '+mulai);
            system.debug('obj == '+obj);
            list_case = new List<AXAAPI001C_response.Data>();
            list_email = new List<AXAAPI002C_response.Data>();
            list_campaign = new List<AXAAPI023A_response.Data>();
            list_page = new List<String>();
            totalRow = 0;
            
            if(obj == 'Case'){
                MultiParamApi(key, value);            
                system.debug('::postURl:'+posturl);
                AXAAPI001C_response res = AXAAPI001C_CaseByParam.getCaseByParam(posturl);
                Set<Id> ids = new Set<Id>();
                if(res != NULL && res.data != NULL){
                    //system.debug('case size:'+res.data.size());
                    // for(AXAAPI001C_response.Data dt:res.data){
                        // ids.add(dt.ownerId);
                    // }
                    // Map<Id, String> map_sobj = AXAAPI_UtilityClass.getsObjectNameByIds(Ids, 'User', 'Name');
                    
                    // for(AXAAPI001C_response.Data dt:res.data){
                        // system.debug('dt.ownerId:'+dt.ownerId+'|'+map_sobj.get(dt.ownerId));
                        //dt.case_owner = map_sobj.get(dt.ownerId);
                        // System.debug('Owner Name: ' +  dt.case_owner);
                    // }
                    list_case.addAll(res.data);
                    totalRow = res.counts;
                    //System.debug(':::total Row Case:'+totalRow);
                }else if(res != NULL && res.message != NULL){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, res.message));
                }else{
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'time out from server'));
                }
            }else if(obj == 'EmailMessage'){
                integer count = 1; 
                MultiParamApiEmail(key, value);
                AXAAPI002C_response res = AXAAPI002C_EmailMessageByParam.getEmailByParam(posturl);
                // AXAAPI002C_response res = AXAAPI002C_EmailMessageByParam.getEmailByParam(key, value, skip, take);
                if(res != NULL && res.data != NULL){
                    system.debug('email size:'+res.data.size());
                    list_email.addAll(res.data);
                    totalRow = res.counts;
                }else if(res != NULL && res.message != NULL){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, res.message));
                }else{
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'time out from server'));
                }
            }else if(obj == 'Call_List__c'){
                integer count = 1;
                MultiParamApi(key, value);            
                //AXAAPI023A_response res = AXAAPI023A_CallListByParam.getCallListByParam(key, value, skip, take);
                AXAAPI023A_response res = AXAAPI023A_CallListByParam.getCallListByParam(posturl);
                system.debug('::Res:'+res);
                if(res != NULL && res.data != NULL){
                    system.debug('Call List size:'+res.data.size());
                    list_campaign.addAll(res.data);
                    totalRow = res.counts;
                }else if(res != NULL && res.message != NULL){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, res.message));
                }else{
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'time out from server'));
                }
            }
            else if (obj == 'Purecloud__c') { 
                take = current_page*SIZE_DATA_purecloud;
                skip = take - (SIZE_DATA_purecloud - 1);
                
                MultiParamApi(key, value);
                
                if (test.isRunningTest()) {
					// postUrl = '?key=entity__c&value=AFI&skip=0&take=10';                    
                }
            	listDataPureCloudAgent = new List<AXAAPI020A_response.Data>();
            	AXAAPI020A_response res = AXAAPI020A_PureCloudByParam.getPureCloudByParam(postUrl);
                Set<Id> ids = new Set<Id>(); 
                if(res != NULL && res.data != NULL){ 
                    for(AXAAPI020A_response.Data dt:res.data){          
                        ids.add(dt.id);
                    }   
                    
                    /* Map<Id, PureCloud__c> map_sobj = new Map<id,PureCloud__c>([SELECT id,agent_name__c,agent_name__r.name,Agent__c,Start_Login__c,End_Login__c,ACD_Count__c,AVG_Talk__c,AVG_ACW__c,AVG_Hold__c,AHT__c,AHT_Sum__c,Handle_Sum__c,Total_Available_Time__c,Total_Available_Sum__c,Total_Time_Staffed__c,Talk_Sum__c,Hold_Sum__c, Queue_PureCloud__c FROM PureCloud__c WHERE id =:ids]);
                    for(AXAAPI020A_response.Data dt:res.data){
                        PureCloud__c retData = map_sobj.get(dt.id);
                        if (retData != null) {
                            dt.Agent_Name_c = retData.agent_name__c;
                            dt.agentName = retData.agent_name__r.name;
                            dt.Start_Login_c = retData.Start_Login__c;
                            dt.End_Login_c = retData.End_Login__c;
                            dt.ACD_Count_c = String.valueOf(retData.ACD_Count__c); 
                            dt.AVG_Talk_c = String.valueOf(retData.AVG_Talk__c); 
                            dt.AVG_ACW_c = String.valueOf(retData.AVG_ACW__c); 
                            dt.AVG_Hold_c = String.valueOf(retData.AVG_Hold__c); 
                            dt.AHT_c = String.valueOf(retData.AHT__c); 
                            dt.AHT_Sum_c = String.valueOf(retData.AHT_Sum__c); 
                            dt.Handle_Sum_c = String.valueOf(retData.Handle_Sum__c); 
                            dt.Total_Available_Time_c = String.valueOf(retData.Total_Available_Time__c); 
                            dt.Total_Available_Sum_c = String.valueOf(retData.Total_Available_Sum__c); 
                            dt.Total_Time_Staffed_c = String.valueOf(retData.Total_Time_Staffed__c); 
                            dt.Talk_Sum_c = String.valueOf(retData.Talk_Sum__c); 
                            dt.Hold_Sum_c = String.valueOf(retData.Hold_Sum__c); 
                            dt.Queue_PureCloud_c = String.valueOf(retData.Queue_PureCloud__c); 
                        } 
                    } */
                     
                    listDataPureCloudAgent.addAll(res.data);
                    totalRow = res.counts;
                }
                else if(res != NULL && res.message != NULL){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'Data not found'));
                }else{
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'time out from server'));
                }
            }
            else if (obj == 'PureCloud_Call_Service__c') {
                take = current_page*SIZE_DATA_purecloud;
                skip = take - (SIZE_DATA_purecloud - 1);
                MultiParamApi(key, value);        
                
                if (test.isRunningTest()) {
					// postUrl = '?key=name&value=000207952&skip=0&take=10';                    
                }
        		list_pureCallService = new List<AXAAPI024A_response.Data>();
                //AXAAPI024A_response res = AXAAPI024A_PureCloudCallServices.getPureCloudCallServices(key, value, skip, take);
                AXAAPI024A_response res = AXAAPI024A_PureCloudCallServices.getPureCloudCallServices(postUrl);
                system.debug('call service:'+res);
                Set<Id> ids = new Set<Id>();
                if(res != NULL && res.data != NULL){ 
                    /* for(AXAAPI024A_response.Data dt:res.data){
                        ids.add(dt.ownerId);
                    } 
                    Map<Id, String> map_sobj = AXAAPI_UtilityClass.getsObjectNameByIds(Ids, 'User', 'Name'); 
                    
                     */
                    list_pureCallService.addAll(res.data); 
                    totalRow = res.counts;
                }else if(res != NULL && res.message != NULL){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, res.message));
                }else{
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'time out from server'));
                }
            }
                    System.debug(':::obj:'+obj);             
            		system.debug('::postURl:'+posturl);
            
                    System.debug(':::total Row Case ALL:'+totalRow);
            
            //set pagination        
            if (obj == 'Purecloud__c' || obj == 'PureCloud_Call_Service__c') {
                total_page = totalRow/SIZE_DATA_purecloud;
            } else {
            	total_page = totalRow/SIZE_DATA;    
            }
            
            if( !test.isRunningTest() && math.mod(totalRow, take) > 0) total_page ++;
            /* for(Integer i=0;i<total_page;i++){
                list_page.add(String.valueOf(i+1));
            } */
                                          
            list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page);  
            
            selesai =  Datetime.now().getTime();
            system.debug('selesai == '+selesai);
            processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
            processTime += '<br/>Total : ' + totalRow + ' records';
            system.debug('processTime == '+processTime);
        }
    }
    
    public class paramUrl { 
        public string value {get;set;}
        public string key {get;set;}
    }  
    
    public void MultiParamApi(String field, string fieldvalue){
        string curr_entity = [Select entity__c From User Where Id = :UserInfo.getUserId()][0].entity__c;
        
        List<paramUrl> listofParam = new list<paramUrl>();
        List<paramUrl> listofParamOR = new list<paramUrl>();
        List<string> setListEntity = new list<string>();
        
        if (curr_entity.contains('AFI') || curr_entity.contains('ALI')) { 
            setListEntity.add('AFI');
            setListEntity.add('ALI');
            // curr_entity = 'a%i';
        } else { 
            setListEntity.add(curr_entity);
        }
        
        for (string entity : setListEntity) { 
            paramUrl p1 = new paramUrl();
            p1.key = 'Entity__c';
            p1.value = entity;
            listofParamOR.add(p1);
        }
        
        /* paramUrl p1 = new paramUrl();
        p1.value = curr_entity;
        p1.key = 'Entity__c';
        listofParam.add(p1); */
                    
        paramUrl p2 = new paramUrl();
        p2.value = fieldvalue;
        p2.key = field;
        listofParam.add(p2);
        
         
        String x = JSON.serialize(listofParam);
        system.debug(x);
                                
        String xOr = JSON.serialize(listofParamOR);
        system.debug('xOr:'+xOr);
        string params = '{"Params":'+x+'}';
        string paramsOr = '{"Params":'+xOr+'}';
        params = EncodingUtil.urlEncode(params, 'UTF-8');
        paramsOr = EncodingUtil.urlEncode(paramsOr, 'UTF-8');
        //String url = '/multi?skip=0&take=20&Params={"Params":';
        /* String url = '/multi?skip='+skip+'&take='+take+'&Params={"Params":';
        postUrl = url + x +'}';*/
        
        String url = '/multi?skip='+skip+'&take='+take+'&Params=';
        url += params;
        url += '&ParamsOR='+paramsOr;
        postUrl = url;
        system.debug(':::postUrl:'+postUrl); 
    }
    
    public void MultiParamApiEmail(String field, string fieldvalue){
        List<paramUrl> listofParamOR = new list<paramUrl>();

        string curr_entity = [Select entity__c From User Where Id = :UserInfo.getUserId()][0].entity__c;
        List<OrgWideEmailAddress> owea = new List<OrgWideEmailAddress>(); 
        List<paramUrl> listofParam = new list<paramUrl>();      
        if (curr_entity == 'AFI' || curr_entity == 'ALI'){
            List<String> emailAFIALI = new List<string>(); 
            owea = [SELECT Id, Address, DisplayName FROM OrgWideEmailAddress WHERE Address Like '%Axa-financial.co.id']; 
            
            
        }else if (curr_entity == 'AMFS'){ 
            owea = [SELECT Id, Address, DisplayName FROM OrgWideEmailAddress WHERE Address Like '%Axa-Mandiri.co.id'];  
        }
        if (owea.size() > 0) { 
        	for(OrgWideEmailAddress email: owea) { 
        		paramUrl p1 = new paramUrl();
                p1.key = 'toAddress';
                p1.value = email.Address;
            	listofParamOR.add(p1);
            }
        }
                    
        paramUrl p2 = new paramUrl();
        p2.key = field;
        p2.value = fieldvalue; 
        listofParam.add(p2);
          
        String x = JSON.serialize(listofParam);
        system.debug(x);
        String xOr = JSON.serialize(listofParamOR);
        system.debug('xOr:'+xOr);
        
        string params = '{"Params":'+x+'}';
        string paramsOr = '{"Params":'+xOr+'}';
        
        params = EncodingUtil.urlEncode(params, 'UTF-8');
        paramsOr = EncodingUtil.urlEncode(paramsOr, 'UTF-8');
        
        //String url = '/multi?skip=0&take=20&Params={"Params":';
        
        String url = '/multi?skip='+skip+'&take='+take+'&Params=';
        url += params;
        url += '&ParamsOR='+paramsOr;
        postUrl = url;
        system.debug(':::postUrl:'+postUrl); 
        
    }  
}