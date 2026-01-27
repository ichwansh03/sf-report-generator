public class CallList_CustomPage_ctrl {
	public String id {get;set;}
    public String parent_id {get;set;}
    
    public List<AXAAPI023A_response.Data> list_calllist {get;set;}
    public AXAAPI023B_response calllist {get;set;}
    public List<AXAAPI022A_response.Data> list_callline {get;set;}
    public List<AXAAPI022A_response.Data> list_callline2 {get;set;}
    
   /* public CallList_CustomPage_ctrl(ApexPages.StandardController controller){
        id = ApexPages.currentPage().getParameters().get('id');
    }*/
    
    
   
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
    public boolean firstcallLine {get;set;}
    public boolean firstcallLineParent {get;set;}
    
    public boolean iscallLine {get;set;}
    public boolean iscallLineParent {get;set;}
    
    public CallList_CustomPage_ctrl(){
        id = ApexPages.currentPage().getParameters().get('id');
        Cache.SessionPartition sessionPart = Cache.Session.getPartition('local.axaPartition');
        
        
        if(id != NULL && id.left(3) == Schema.SObjectType.Call_List__c.getKeyPrefix()) 
        {
            calllist = getCallListDetail(id);
            refresh();  
        }
    }
    
     public void setLoadRecords() {  
         
         system.debug('::aaaaa');
         system.debug('::iscallLine:'+iscallLine);
        if (iscallLine == true) loadCallLines_campaign();         
        if (iscallLineParent == true) loadCallLines_Parent();        
    }
    
    public void setLoadCallLine() {
        iscallLine = true;
        iscallLineParent = false;
        
         system.debug('::iscallLine setLoadCallLine:'+iscallLine);
    }
    
    
    public void setLoadCallLineParent() {
        iscallLineParent = true;
        iscallLine = false;
        
         system.debug('::iscallLine setLoadCallLineParent:'+iscallLine);
    }
   
    public void loadCallLines_campaign(){ 
        setLoadCallLine();
         system.debug('::aaaaa');
        if (firstcallLine  == false ){
            firstcallLine = true;
            refresh();
        }
        
        list_callline = new List<AXAAPI022A_response.Data>();
 
 		mulai =  DateTime.now().getTime(); 
        // AXAAPI022A_response res = AXAAPI022A_CallLineByCampaign.getCallLineByCampaign('a000K00001vsQJnQAM');
        AXAAPI022A_response res = AXAAPI022A_CallLineByCampaign.getCallLineByCampaign(id,skip,take); 
        system.debug('::skip'+skip);
        system.debug('::take'+take);
        system.debug('::res'+res);
        system.debug('::current_page'+current_page);
        if(res != NULL && res.data != NULL){
            list_callline = res.data;
            totalRow = res.counts; 
            Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
            countPage = countPage.round(System.RoundingMode.CEILING);
            total_page = integer.valueOf(countPage);
                
            system.debug('::current_page'+current_page);
            system.debug('::total_page'+total_page);
            list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page); 
            
            selesai =  Datetime.now().getTime();
            system.debug('selesai == '+selesai); 
            system.debug('mulai == '+mulai); 
            processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
            processTime += '<br/>Total : ' + totalRow + ' records';
            system.debug('processTime == '+processTime);
        }
        
        system.debug('List:'+list_callline);
    }
    
    
    public void loadCallLines_Parent(){
        setLoadCallLineParent();
         
        if (firstcallLineParent  == false ){
            firstcallLineParent = true;
            refresh();
        }
        list_callline2 = new List<AXAAPI022A_response.Data>();
 		mulai =  DateTime.now().getTime(); 
        // AXAAPI022A_response res = AXAAPI022A_CallLineByCampaign.getCallLineByCampaign('a000K00001vsQJnQAM');
        AXAAPI022A_response res = AXAAPI022A_CallLineByParent.getCallLineByParent(id,skip,take); 
        if (Test.isRunningTest()) {
            res = AXAAPI022A_CallLineByParent.getCallLineByParent('a000K00001vsQJnQAM',skip,take); 
        }
        if(res != NULL && res.data != NULL){
            list_callline2 = res.data;
            totalRow = res.counts; 
            Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
            countPage = countPage.round(System.RoundingMode.CEILING);
            total_page = integer.valueOf(countPage);
                
            list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page); 
            
            selesai =  Datetime.now().getTime();
            system.debug('selesai == '+selesai); 
            system.debug('mulai == '+mulai); 
            processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
            processTime += '<br/>Total : ' + totalRow + ' records';
            system.debug('processTime == '+processTime);
        } 
        system.debug('List:'+list_callline);
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
        setLoadRecords();
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
        setLoadRecords();
         
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
        setLoadRecords();
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
        setLoadRecords();
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
        setLoadRecords();
         
    } 

    
    public AXAAPI023B_response getCallListDetail(String id){ 
        AXAAPI023B_response res = AXAAPI023B_CallListByID.getCallListByID(id);
        
        return res;
    }
    
}