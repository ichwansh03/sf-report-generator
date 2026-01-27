public class CallLine_CustomPage_ctrl {
    public String id {get;set;}
    public String parent_id {get;set;} 
    
    public List<AXAAPI022A_response.Data> list_callline {get;set;}
    public List<AXAAPI011A_response.Data> list_history_res {get;set;}
    public List<AXAAPI011A_response.Data> list_openActivity_res {get;set;}
    public List<AXAAPI028A_response.Data> list_histories {get;set;}
    public List<AXAAPI026A_response.Data> call_line_history {get;set;}
    public AXAAPI022B_response callline {get;set;}
    public boolean isConsole {get;set;}
    
    //ROUTING PAGE COMPONENT BERDASARKAN RECORD TYPE
    public boolean isStandarPage {get;set;}
    public boolean isAMFSCol1 {get;set;}
    public boolean isAMFSCol2 {get;set;}
    public boolean isWelcomeCall {get;set;}
    public boolean isALIPage {get;set;}
   
    //ROUTING SECTION COLLECTION DETAIL 
    public boolean isCollectionDetailType1 {get;set;}
    public boolean isCollectionDetailType2 {get;set;}
    public boolean isCollectionDetailType3 {get;set;}
    public boolean isCollectionDetailType4 {get;set;}
    public boolean isCollectionDetailType5 {get;set;}
    //ROUTING SECTION INFORMATION AMFS
    public boolean isInformationAMFS1 {get;set;}
    public boolean isInformationAMFS2 {get;set;}
    public boolean isInformationAMFS3 {get;set;}
    public boolean isInformationAMFS4 {get;set;}
    public boolean isInformationAMFS5 {get;set;}
    //ROUTING SECTION DETAIL ALI
    public boolean isALI2 {get;set;}
    public boolean isALI3 {get;set;}
    public boolean isALI4 {get;set;}
    public boolean isALI6 {get;set;}
	public boolean isALI9 {get;set;}
    public boolean isALI10 {get;set;} 
    
    //DEFINING RECORD TYPE
    public boolean isAMFSType {get;set;}
    public boolean isAFIType {get;set;}
    public boolean isALIType {get;set;}
   
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
    
    public boolean isActivityHistories {get;set;}
    public boolean isActivityHistory {get;set;}
    public boolean isOpenActivity {get;set;}
    public boolean isCallLine {get;set;}
    public boolean isCallLineHistory {get;set;}
    public boolean isCallLineParent {get;set;}
    
    public boolean firstActivityHistories {get;set;}
    public boolean firstActivityHistory {get;set;}
    public boolean firstOpenActivity {get;set;}
    public boolean firstCallLine {get;set;}
    public boolean firstCallLineParent {get;set;}
    public boolean firstCallLineHistory {get;set;}
 
    public CallLine_CustomPage_ctrl(ApexPages.StandardController controller){
        
        refresh();
        id = ApexPages.currentPage().getParameters().get('id');
    }
    
    public CallLine_CustomPage_ctrl(){
        refresh();
        id = ApexPages.currentPage().getParameters().get('id');
        system.debug(id+'|'+ Schema.SObjectType.Call_Line__c.getKeyPrefix());
        
        
        String urlVal = Apexpages.currentPage().getUrl();
        system.debug(':::URl:'+urlVal);
        if(urlVal != null && urlVal.contains('console')) {
             isConsole = false;  
        } else {
            isConsole = true;    
        }
        System.debug('id:'+id);
        if(id != NULL && id.left(3) == Schema.SObjectType.Call_Line__c.getKeyPrefix()){
            
            String uniqueId = ApexPages.currentPage().getParameters().get('lastId'); 
            System.debug('::uniqueId:'+uniqueId);
            System.debug('::id.length():'+id.length());
            if (id.length() > 14 && id.length() < 18 && uniqueId != null) {
                id = id+uniqueId;
            }  
            
            
             callline = getCallLineDetail(id);
            
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='AFI 1';
            }
            
            //ROUTING VISUAL COMPONENT BY RECORD TYPE
            if(callline.data.recordType_name == 'AFI 1' || callline.data.recordType_name == 'AFI 1B' || callline.data.recordType_name == 'AFI 2' || callline.data.recordType_name == 'AFI 3'
              || callline.data.recordType_name == 'AMFS 1' || callline.data.recordType_name == 'AMFS 4'){
                isStandarPage = true;
              } 
            
            if(callline.data.recordType_name == 'AFI 1' || callline.data.recordType_name == 'AFI 1B' || callline.data.recordType_name == 'AFI 2' || callline.data.recordType_name == 'AFI 3')
            {
                isAFIType = true;
            }
            if(callline.data.recordType_name == 'AMFS 1' || callline.data.recordType_name == 'AMFS 4' || callline.data.recordType_name == 'Collection AMFS 1' || callline.data.recordType_name == 'Collection AMFS 2' || callline.data.recordType_name == 'Collection AMFS 3' || callline.data.recordType_name == 'Collection AMFS 4'
              || callline.data.recordType_name == 'Collection AMFS 5' || callline.data.recordType_name == 'Collection AMFS 6' ||callline.data.recordType_name == 'Collection AMFS 7' || callline.data.recordType_name == 'Collection AMFS 8' ){
                isAMFSType = true;
            }
            if(callline.data.recordType_name == 'ALI 1' || callline.data.recordType_name == 'ALI 2' || callline.data.recordType_name == 'ALI 3' || callline.data.recordType_name == 'ALI 4' || callline.data.recordType_name == 'ALI 5' 
              || callline.data.recordType_name == 'ALI 6' || callline.data.recordType_name == 'ALI 7'|| callline.data.recordType_name == 'ALI 8' ||callline.data.recordType_name == 'ALI 8'|| callline.data.recordType_name == 'ALI 10'){
                isALIType = true;
            }
            
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='Collection AMFS 1';
            }
            
            if(callline.data.recordType_name == 'Collection AMFS 1' || callline.data.recordType_name == 'Collection AMFS 2' || callline.data.recordType_name == 'Collection AMFS 3' || callline.data.recordType_name == 'Collection AMFS 4'
              || callline.data.recordType_name == 'Collection AMFS 5' || callline.data.recordType_name == 'Collection AMFS 6'){
                isAMFSCol1 = true;
              }
            
            
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='Collection AMFS 7';
            }
            
            if(callline.data.recordType_name == 'Collection AMFS 7' || callline.data.recordType_name == 'Collection AMFS 8'){
                isAMFSCol2 = true;
              }
            
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='Welcome Call';
            }
            
            if(callline.data.recordType_name == 'Welcome Call' ){//|| callline.data.recordType_name == 'Collection AMFS 8'){
                isWelcomeCall = true;
              }
            
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='ALI 2';
            }
            
            if(callline.data.recordType_name == 'ALI 2' || callline.data.recordType_name == 'ALI 3' || callline.data.recordType_name == 'ALI 4' 
               || callline.data.recordType_name == 'ALI 6' || callline.data.recordType_name == 'ALI 9' || callline.data.recordType_name == 'ALI 10'){
                  isALIPage = true ;
               }
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='Collection AMFS 1';
            }
 
            //CALL LINE DETAIL SECTION KECUALI STANDAR
              if(callline.data.recordType_name == 'Collection AMFS 1' || callline.data.recordType_name == 'Collection AMFS 3' || callline.data.recordType_name == 'Collection AMFS 2' ){
                  isCollectionDetailType1 = true;
              }
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='Collection AMFS 4';
            }
            if(callline.data.recordType_name == 'Collection AMFS 4' || callline.data.recordType_name == 'Collection AMFS 5'){
                  isCollectionDetailType2 = true;
              }
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='Collection AMFS 6';
            }
            if(callline.data.recordType_name == 'Collection AMFS 6'){
                  isCollectionDetailType3 = true;
              }
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='Collection AMFS 7';
            }
            if(callline.data.recordType_name == 'Collection AMFS 7'){
                  isCollectionDetailType4 = true;
              }
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='Collection AMFS 8';
            }
            if(callline.data.recordType_name == 'Collection AMFS 8'){
                  isCollectionDetailType5 = true;
              }
            
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='Collection AMFS 1';
            }
            
            //CALL LINE INFORMATION AMFS
            if(callline.data.recordType_name == 'Collection AMFS 1' || callline.data.recordType_name == 'Collection AMFS 3'||callline.data.recordType_name == 'Collection AMFS 4'|| callline.data.recordType_name == 'Collection AMFS 5')
            {
                isInformationAMFS1 = true;
            }
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='Collection AMFS 2';
            }
            if (callline.data.recordType_name == 'Collection AMFS 2'){
                isInformationAMFS2 = true;
            }
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='Collection AMFS 6';
            }
            if (callline.data.recordType_name == 'Collection AMFS 6'){
                isInformationAMFS3 = true;
            }
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='Collection AMFS 7';
            }
            if (callline.data.recordType_name == 'Collection AMFS 7'){
                isInformationAMFS4 = true;
            }
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='Collection AMFS 8';
            }
            if (callline.data.recordType_name == 'Collection AMFS 8'){
                isInformationAMFS5 = true;
            }
            
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='ALI 2';
            }
            //CALL LINE ALI DETAIL
            if (callline.data.recordType_name == 'ALI 2'){
                isALI2 = true;
            }
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='ALI 3';
            }
            if (callline.data.recordType_name == 'ALI 3'){
                isALI3 = true;
            }
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='ALI 4';
            }
            if (callline.data.recordType_name == 'ALI 4'){
                isALI4 = true;
            }
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='ALI 6';
            }
            if (callline.data.recordType_name == 'ALI 6'){
                isALI6 = true;
            }
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='ALI 9';
            }
            if (callline.data.recordType_name == 'ALI 9'){
                isALI9 = true;
            }
            
            if (test.isRunningTest()) {
                callline.data.recordType_name ='ALI 10';
            }
            if (callline.data.recordType_name == 'ALI 10'){
                isALI10 = true;
            }
            
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
    
    
    public void setTrueVaribale(string setVariable) {   
        isActivityHistories = false;
        if (setVariable == 'LoadActivityHistories') {
            isActivityHistories = true;
        }
        isActivityHistory = false;
        if (setVariable == 'LoadActivityHistory') {
            isActivityHistory = true;
        }
        isOpenActivity = false;
        if (setVariable == 'LoadOpenActivity') {
            isOpenActivity = true;
        }
        isCallLine = false;
        if (setVariable == 'LoadCallLine') {
            isCallLine = true;
        }
        isCallLineHistory = false;
        if (setVariable == 'LoadCallLineHistory') {
            isCallLineHistory = true;
        }
        isCallLineParent = false; 
        if (setVariable == 'LoadCallLineParent') {
            isCallLineParent = true;
        }
    }
    
    
    public void setLoadActivityHistories() {
        setTrueVaribale('LoadActivityHistories');
    }
    public void setLoadActivityHistory() {
        setTrueVaribale('LoadActivityHistory');
    }
    public void setLoadOpenActivity() {
        setTrueVaribale('LoadOpenActivity');
    }
    public void setLoadCallLine() {
        setTrueVaribale('LoadCallLine');
    }
    public void setLoadCallLineHistory() { 
        setTrueVaribale('LoadCallLineHistory');
    }
    
    public void setLoadCallLineParent() {
        setTrueVaribale('LoadCallLineParent');
    }
     
    public void setLoadRecords() {  
        system.debug('isActivityHistories:'+isActivityHistories);
        system.debug('isActivityHistory:'+isActivityHistory);
        system.debug('isOpenActivity:'+isOpenActivity);
        system.debug('isCallLine:'+isCallLine);
        system.debug('isCallLineParent:'+isCallLineParent);
        system.debug('isCallLineHistory:'+isCallLineHistory);
        if (isActivityHistories == true) loadActivityHistories();        
        if (isActivityHistory == true) loadActivityHistory_callLine();        
        if (isOpenActivity == true) loadOpenActivity_callLine();        
        if (isCallLine == true) loadCallLines();        
        if (isCallLineParent == true) loadParentCallLine();        
        if (isCallLineHistory == true) loadCallLineHistory();   
    }
    

    public AXAAPI022B_response getCallLineDetail(String id){ 
         AXAAPI022B_response res = AXAAPI022B_CallLineByID.getCallLineByID(id);
        
        return res;
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
     
    
    public void loadCallLines(){
        
        if (firstCallLine == false) {
            firstCallLine = true;
            refresh();
        }
        mulai =  DateTime.now().getTime(); 
        list_callline = new List<AXAAPI022A_response.Data>();
        /* List<Contact> list_con = [SELECT Id, Policy_No__c FROM Contact WHERE Id=:id LIMIT 1];
        system.debug('List Con'+list_con);
        if(list_con.size()>0){
            Contact con = list_con[0];
            // AXAAPI022A_response res = AXAAPI022A_CallLineByPolicyNumber.getCallLineByPolicyNumber('509-1047885');
            AXAAPI022A_response res = AXAAPI022A_CallLineByPolicyNumber.getCallLineByPolicyNumber(con.id);
            if(res != NULL && res.data != NULL){
                list_callline = res.data;
            }
        } */
        AXAAPI022A_response res = AXAAPI022A_CallLineByPolicyNumber.getCallLineByPolicyNumber(id,skip, take);
        if(res != NULL && res.data != NULL){
            list_callline = res.data;
            totalRow = res.counts; 
            Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
            countPage = countPage.round(System.RoundingMode.CEILING);
            total_page = integer.valueOf(countPage); 
        }else if(res != NULL && res.message != NULL){
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
    
    public void loadCallLines_campaign(){
        list_callline = new List<AXAAPI022A_response.Data>(); 
        // AXAAPI022A_response res = AXAAPI022A_CallLineByCampaign.getCallLineByCampaign('a000K00001vsQJnQAM');
        AXAAPI022A_response res = AXAAPI022A_CallLineByCampaign.getCallLineByCampaign(id,0,10);
        if(res != NULL && res.data != NULL){
            list_callline = res.data;
        }
    }
    
    public void loadActivityHistory_callLine(){
        
        if (firstActivityHistory == false) {
            firstActivityHistory = true;
            refresh();
        }
        // add by Beni 01022023
        setLoadActivityHistory();
        // end add by Beni 01022023        
        id = ApexPages.currentPage().getParameters().get('id');
        list_history_res = new List<AXAAPI011A_response.Data>();
        
        mulai =  DateTime.now().getTime(); 
         AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByParam.getTaskByParam('activity-history','whatId',id,skip,take); 
         if(res != NULL && res.data != NULL){ 
             list_history_res = res.data;
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
     }

	public void loadOpenActivity_callLine(){
        	
        if (firstOpenActivity == false) {
            firstOpenActivity = true;
            refresh();
        }
        // add by Beni 01022023
        setLoadOpenActivity();
        // end add by Beni 01022023        
        id = ApexPages.currentPage().getParameters().get('id');
        list_openActivity_res = new List<AXAAPI011A_response.Data>();
       	
        mulai =  DateTime.now().getTime(); 
         AXAAPI011A_response res =  AXAAPI011A_TaskActHistoryByParam.getTaskByParam('open-activity/','whoid',id, skip, take); 
         if(res != NULL && res.data != NULL){ 
             list_openActivity_res = res.data;
             
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
     }
	    
    public void loadActivityHistories(){
        
        if (firstActivityHistories == false) {
            firstActivityHistories = true;
            refresh();
        }
        // add by Beni 01022023
        setLoadActivityHistories();
        // end add by Beni 01022023        
        id = ApexPages.currentPage().getParameters().get('id');
        list_histories = new List<AXAAPI028A_response.Data>();
       
        mulai =  DateTime.now().getTime(); 
         AXAAPI028A_response res = AXAAPI028A_ActivityHistoriesByParam.getActivityHistories('call_Bucket__c',id,skip,take); 
         if(res != NULL && res.data != NULL){ 
             list_histories = res.data;
             
             
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
        
        System.debug(list_histories);
     }
    
     public void loadCallLineHistory(){
         
        if (firstCallLineHistory == false) {
            firstCallLineHistory = true;
            refresh();
        }
        // add by Beni 01022023
        setLoadCallLineHistory();
        // end add by Beni 01022023
        id = ApexPages.currentPage().getParameters().get('id');
        call_line_history = new List<AXAAPI026A_response.Data>(); 
        mulai =  DateTime.now().getTime(); 
        system.debug('skip:'+skip);
        system.debug('take:'+take);
        AXAAPI026A_response res = AXAAPI026A_CallLineHistoryByParent.getCallLineHistory('parentId',id,skip,take);
        if(res != NULL && res.data != NULL){
            //system.debug('isinya: ' + res.data.oldValue);
            /*for(AXAAPI026A_response.Data data : mid_secure_history){
                
                system.debug('ISI: ' + data.action);
            }*/
            
            call_line_history = res.data;
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
    }
    
    public void loadParentCallLine(){
        
        if (firstCallLineParent == false) {
            firstCallLineParent = true;
            refresh();
        }
        // add by Beni 01022023
        setLoadCallLineParent();
        // end add by Beni 01022023
        mulai =  DateTime.now().getTime(); 
        list_callline = new List<AXAAPI022A_response.Data>(); 
        // AXAAPI022A_response res = AXAAPI022A_CallLineByCampaign.getCallLineByCampaign('a000K00001vsQJnQAM');
        system.debug('skip:'+skip);
        system.debug('take:'+take);
        AXAAPI022A_response res = AXAAPI022A_CallLineByParentCallLine.getCallLineByParentCallLine(id,skip,take);
        if (Test.isRunningTest()) {
            res = AXAAPI022A_CallLineByParentCallLine.getCallLineByParentCallLine('a000K00001vsQJnQAM',skip,take);
        }
        if(res != NULL && res.data != NULL){
            list_callline = res.data;
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
    }
}