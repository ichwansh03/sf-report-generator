public class MIDSecurePayment_CustomPage_ctrl {
	public String id {get;set;}
    public String parent_id {get;set;} 
    
    public List<AXAAPI016A_response.Data> mid_pays {get;set;}
    public List<AXAAPI026A_response.Data> mid_secure_history {get;set;}
    public List<AXAAPI027A_response.Data> mid_custom_history {get;set;}
    public AXAAPI016B_response mid_pay {get;set;}
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
   
    
    
        
    public MIDSecurePayment_CustomPage_ctrl(ApexPages.StandardController controller){
        refresh();    
       id = ApexPages.currentPage().getParameters().get('id');
        system.debug(id+'|'+ Schema.SObjectType.MID_Secure_Payment__c.getKeyPrefix());
         // if(id != NULL && id.left(3) == Schema.SObjectType.MID_Secure_Payment__c.getKeyPrefix()) mid_pay = getPaymentDetail(id); 
    } 
    
    public MIDSecurePayment_CustomPage_ctrl(){
        refresh();    
        id = ApexPages.currentPage().getParameters().get('id');
        system.debug(id+'|'+ Schema.SObjectType.MID_Secure_Payment__c.getKeyPrefix());
        
        
        String urlVal = Apexpages.currentPage().getUrl();
        system.debug(':::URl:'+urlVal);
        if(urlVal != null && urlVal.contains('console')) {
             isConsole = false;  
        } else {
            isConsole = true;    
        }           
        if(id != NULL && id.left(3) == Schema.SObjectType.MID_Secure_Payment__c.getKeyPrefix()) {
            
            String uniqueId = ApexPages.currentPage().getParameters().get('lastId'); 
            System.debug('::uniqueId:'+uniqueId);
            System.debug('::id.length():'+id.length());
            if (id.length() > 14 && id.length() < 18 && uniqueId != null) {
                id = id+uniqueId;
            }  
            
            mid_pay = getPaymentDetail(id);
            system.debug('MID PAY:'+mid_pay);
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
    
    public AXAAPI016B_response getPaymentDetail(String case_id){
        mid_pay = AXAAPI016A_MidSecurePaymentByID.getMidSecurePaymentById(case_id);
        system.debug('ISI: ' + mid_pay.data.parent_c);
        return mid_pay;
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
        loadMIDSecurePayments();
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
        loadMIDSecurePayments();
         
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
        loadMIDSecurePayments();
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
        loadMIDSecurePayments();
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
        loadMIDSecurePayments();
         
    } 
    
    public void loadMIDSecurePayments(){
       //payments = getMIDSecurePayments(parent_id);
       mulai =  DateTime.now().getTime(); 
       	mid_pays = new List<AXAAPI016A_response.Data>();
        /* List<Contact> list_con = [SELECT Id, Policy_No__c FROM Contact WHERE Id=:id LIMIT 1];
        if(list_con.size()>0){
            Contact con = list_con[0];
            //AXAAPI016A_response res = AXAAPI016A_MidSecurePaymentByPolNum.getMidSecurePaymentByPolNum(con.Policy_No__c);
            AXAAPI016A_response res = AXAAPI016A_MidSecurePaymentByPolNum.getMidSecurePaymentByPolNum(con.id);
            
            if(res != NULL && res.data != NULL){
                mid_pays = res.data;
                
            }
        } */
        
		System.debug(':::MidSecure Contact Id:'+id);
        AXAAPI016A_response res = AXAAPI016A_MidSecurePaymentByPolNum.getMidSecurePaymentByPolNum(id, skip, take); 
        if(res != NULL && res.data != NULL){
            mid_pays = res.data; 
            
            system.debug(':::mid_pays:'+mid_pays);
            
            totalRow = res.counts; 
            system.debug(':::totalRow:'+totalRow);
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
    
    public void loadMidSecurePaymentHistory(){
        id = ApexPages.currentPage().getParameters().get('id');
        mid_secure_history = new List<AXAAPI026A_response.Data>(); 
        AXAAPI026A_response res = AXAAPI026A_MidSecureHistoryByParent.getMidSecureHistory('ParentId',id,0,10);
        if(res != NULL && res.data != NULL){
            //system.debug('isinya: ' + res.data.oldValue);
            /*for(AXAAPI026A_response.Data data : mid_secure_history){
                
                system.debug('ISI: ' + data.action);
            }*/
            
            mid_secure_history = res.data;
        }
    }
    
    public void loadMidCustomHistory(){
        id = ApexPages.currentPage().getParameters().get('id');
        mid_custom_history = new List<AXAAPI027A_response.Data>(); 
        AXAAPI027A_response res = AXAAPI027A_MidCustomHistoryByKey.getMidCustomHistory('miD_Secure_Payment__c',id,0,10);
        if(res != NULL && res.data != NULL){
            //system.debug('isinya: ' + res.data.oldValue);
            /*for(AXAAPI026A_response.Data data : mid_secure_history){
                
                system.debug('ISI: ' + data.action);
            }*/
            
            mid_custom_history = res.data;
        }
    }
    
    
   
}