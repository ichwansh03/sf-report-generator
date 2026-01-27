public class ChatTranscript_CustomPage_ctrl {
	public String id {get;set;}
    public String parent_id {get;set;}
    public boolean isConsole {get;set;}
    
	public AXAAPI021B_response chat_transcript {get;set;}
    public List<AXAAPI025A_response.Data> list_chat_events {get;set;}
    public List<AXAAPI021A_response.Data> list_chat_transcript {get;set;}
    
   
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
   
        
    public ChatTranscript_CustomPage_ctrl(ApexPages.StandardController controller){
        
        refresh();
        id = ApexPages.currentPage().getParameters().get('id');
        system.debug(id+'|'+ Schema.SObjectType.LiveChatTranscript.getKeyPrefix());
        // if(id != NULL && id.left(3) == Schema.SObjectType.LiveChatTranscript.getKeyPrefix()) chat_transcript = getChatTranscriptDetail(id);
    }
    
    public ChatTranscript_CustomPage_ctrl(){
        
        refresh();
        id = ApexPages.currentPage().getParameters().get('id');
        system.debug(id+'|'+ Schema.SObjectType.LiveChatTranscript.getKeyPrefix());
        if(id != NULL && id.left(3) == Schema.SObjectType.LiveChatTranscript.getKeyPrefix()) {
             
            String uniqueId = ApexPages.currentPage().getParameters().get('lastId'); 
            System.debug('::uniqueId:'+uniqueId);
            System.debug('::id.length():'+id.length());
            if (id.length() > 14 && id.length() < 18 && uniqueId != null) {
                id = id+uniqueId;
            }  
            
            chat_transcript = getChatTranscriptDetail(id);
        } 
        
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
        loadChatTranscripts();
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
        loadChatTranscripts();
         
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
        loadChatTranscripts();
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
        loadChatTranscripts();
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
        loadChatTranscripts();
         
    } 
    
    
    public AXAAPI021B_response getChatTranscriptDetail(String id){
        
        AXAAPI021B_response res = AXAAPI021B_ChatTranscriptByID.getChatTranscriptByID(id);
        /*if(res != NULL && res.data != NULL){
                String arrComment = '';
                String comment = '';
                
                    comment = res.data.body;
                    arrComment = comment.replace('\n','<br/>'); 
                    res.data.body = arrComment; 
                
        }*/
        return res;
    }
    
    public void loadChatTranscripts(){
        mulai =  DateTime.now().getTime(); 
        list_chat_transcript = new List<AXAAPI021A_response.Data>();
        /* List<Contact> list_contact = [SELECT Id FROM Contact WHERE Id=:id LIMIT 1];
        if(list_contact.size()>0){
            Contact con = list_contact[0];
            // AXAAPI021A_response res = AXAAPI021A_ChatTranscriptByContactID.getChatTranscriptByContactID('0039000001XRdns');
            AXAAPI021A_response res = AXAAPI021A_ChatTranscriptByContactID.getChatTranscriptByContactID(id);
            if(res != NULL && res.data != NULL){
                list_chat_transcript = res.data;
             
            }
        } */
        
        AXAAPI021A_response res = AXAAPI021A_ChatTranscriptByContactID.getChatTranscriptByContactID(id,skip,take);
        if(res != NULL && res.data != NULL){
            list_chat_transcript = res.data;
            
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
    
    public void loadChatTranscripts_case(){
        list_chat_transcript = new List<AXAAPI021A_response.Data>();
        //List<Case> list_case = [SELECT Id FROM Case WHERE Id='5000K00001vJQEEQA4' LIMIT 1];
        //if(list_case.size()>0){
            //Case cas = list_case[0];
            AXAAPI021A_response res = AXAAPI021A_ChatTranscriptByCase.getChatTranscriptByCase(id);
            // AXAAPI021A_response res = AXAAPI021A_ChatTranscriptByCase.getChatTranscriptByCase('5006F00001oRpeCQAS');
            if(res != NULL && res.data != NULL){
                list_chat_transcript = res.data;
             
            }
        //}
    }
    
    public void loadChatTranscriptEvent(){
        id = ApexPages.currentPage().getParameters().get('id');
        list_chat_events = new List<AXAAPI025A_response.Data>();
       
         AXAAPI025A_response res = AXAAPI025A_ChatTranscriptEventByParentid.getChatTranscriptEventByParent(id); 
         if(res != NULL && res.data != NULL){ 
             list_chat_events = res.data; 
             
         }   
     }
     
}