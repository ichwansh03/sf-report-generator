/*
*  @author  Ranti Dwi Putri <rdpranntiii@gmail.com> 
*  @Desc    Controller Data Negative Feedback  
*/
public class NegativeFeedback_CustomPage_ctrl {
	public String id {get;set;}
    public String parent_id {get;set;}  
    public AXAAPI013B_response detail {get;set;}  
    public List<AXAAPI001C_response.Data> cases {get;set;} 
    public list<AXAAPI013A_response.Data> listData {get;set;}     
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
     
    public String Body_HTML {get;set;}  
    
    public NegativeFeedback_CustomPage_ctrl (ApexPages.StandardController controller) {
        id = ApexPages.currentPage().getParameters().get('id');  
        refresh();
    }
 
    public NegativeFeedback_CustomPage_ctrl(){
        id = ApexPages.currentPage().getParameters().get('id');  
        Cache.SessionPartition sessionPart = Cache.Session.getPartition('local.axaPartition');
        
        if(id != NULL && id.left(3) == Schema.SObjectType.Negative_Feedback__c.getKeyPrefix()) {
            detail = getNFDetail(id); 
            cases = new List<AXAAPI001C_response.Data>();
            list<String> setParamCase = new list<string>();
            setParamCase.add('key=negative_Feedback__c');
            setParamCase.add('value='+id);
            setParamCase.add('skip=0');
            setParamCase.add('take=10'); 
            String convertToString  = String.join(setParamCase,'&');
             
            AXAAPI001C_response res = AXAAPI001C_CaseByParam.getCaseByParam('?'+convertToString);  
            
            if(res != NULL && res.data != NULL){
                cases = res.data;  
            } 
        }
    }    
    public PageReference redirect(){
        List<Negative_Feedback__c> listNegative = [SELECT Id FROM Negative_Feedback__c WHERE Id=:id];
        if(listNegative.size() > 0){
            PageReference pageRef = new PageReference('/'+id);
            // return pageRef;
            return NULL;
        }else{
            return NULL;
        }
    } 
    
    public AXAAPI013B_response getNFDetail(String negativeId){  
        AXAAPI013B_response res = AXAAPI013B_NegativeFeedbackByID.getNegativeFeedbackId(negativeId);
        if(res != NULL && res.data != NULL){ 
            if (res.data.case_c != null && res.data.case_Owner_c != '' && res.data.case_Owner_c.contains('Admin SFDC')) {
                AXAAPI001B_response cases_c = AXAAPI001B_CaseById.getCaseById(res.data.case_c);  
                if(cases_c != NULL && cases_c.data != NULL) res.data.case_Owner_c = cases_c.data.case_Owner_c;
            }
            Cache.SessionPartition sessionPart = Cache.Session.getPartition('local.axaPartition');   
        }else{ 
            res = new AXAAPI013B_response();
            res.data = new AXAAPI013B_response.Data();
        } 
        return res;
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
        loadNegatives();
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
        loadNegatives();
         
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
        loadNegatives();
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
        loadNegatives();
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
        loadNegatives();
         
    } 

    public void loadNegatives(){   
        mulai =  DateTime.now().getTime(); 
        id = ApexPages.currentPage().getParameters().get('id'); 
        listData = new List<AXAAPI013A_response.Data>();    
        system.debug(id);
        AXAAPI013A_response res = AXAAPI013A_NegativeFeedbackByCase.getNegativeFeedbackByCaseId('Contact__c',id, skip, take);  
        if(res != NULL && res.data != NULL){
            listData = res.data; 
            
            totalRow = res.counts; 
            Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
            countPage = countPage.round(System.RoundingMode.CEILING);
            total_page = integer.valueOf(countPage);
                 
        }  else if(res != NULL && res.message != NULL){
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
    
}