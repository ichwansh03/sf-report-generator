/*
*  @author  Ranti Dwi Putri <rdpranntiii@gmail.com> 
*  @Desc    Controller Data Survey Taken
*/
public class SurveyTaken_CustomPage_ctrl { 
    public String id {get;set;}
    public String parent_id {get;set;} 
    public List<SurveyTaker__c> listSurvey {get;set;}  
    public AXAAPI014B_response detail {get;set;} 
    public String Body_HTML {get;set;}  
    public List<Survey_Response__c> listSurveyResponse {get;set;}    
    public String entityContact {get;set;}   
    
    
    public List<AXAAPI014A_response.Data> listSurveyTaken {get;set;}  
    
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

    public SurveyTaken_CustomPage_ctrl (ApexPages.StandardController controller) {
        id = ApexPages.currentPage().getParameters().get('id');  
        if(id != NULL && id.left(3) == Schema.SObjectType.Contact.getKeyPrefix()) {
            system.debug('contact');
            Contact getContact = new Contact();
            If (Test.isRunningTest()) {
                getContact = [Select id, entity__c from Contact limit 1];
            } else { 
                getContact = [Select id, entity__c from Contact where id = :id limit 1];
            }
            id = getContact.id;
            entityContact = getContact.entity__c;
            system.debug('entityContact contact:'+entityContact);
        }
        refresh();
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
        loadSurvey();
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
        loadSurvey();
         
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
        loadSurvey();
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
        loadSurvey();
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
        loadSurvey();
         
    } 
    
    
    public SurveyTaken_CustomPage_ctrl(){
        id = ApexPages.currentPage().getParameters().get('id');  

        /* if(id != NULL && id.left(3) == Schema.SObjectType.Contact.getKeyPrefix()) {
            system.debug('contact');
            Contact getContact = new Contact();
            If (Test.isRunningTest()) {
                getContact = [Select id, entity__c from Contact limit 1];
            } else { 
                getContact = [Select id, entity__c from Contact where id = :id limit 1];
            }
            id = getContact.id;
            entityContact = getContact.entity__c;
            system.debug('entityContact:'+entityContact);
        } */
        
        Cache.SessionPartition sessionPart = Cache.Session.getPartition('local.axaPartition');  
        system.debug('---Id'+id);
        if(id != NULL && id.left(3) == Schema.SObjectType.SurveyTaker__c.getKeyPrefix()) {
            system.debug('detail');
            detail = getSTDetail(id);
            system.debug('Detail:'+detail);
            listSurveyResponse = [SELECT Id, Name, Survey__c, Answer_1__c, Answer_2__c, Negative_Answer__c, Negative_Question__c, Negative_Result__c, Question_1__c, Question_2__c, SurveyTaker__c FROM Survey_Response__c where SurveyTaker__c =: id];
        }  
        system.debug('parent_id:'+parent_id); 
    }  
    
    
    public void loadSurvey(){     
        mulai =  DateTime.now().getTime();  
        listSurveyTaken = new List<AXAAPI014A_response.Data>(); 
        AXAAPI014A_response res = AXAAPI014A_SurveyTakenByParam.getSurveyTakenByParam('contact__c',id, skip, take); 
        if (Test.isRunningTest()) {
            res = AXAAPI014A_SurveyTakenByParam.getSurveyTakenByParam('contact__c','0036F000020ueMlQAI', skip, take); 
        } 
        
        
        // AXAAPI014A_response res = AXAAPI014A_SurveyTakenByCase.getSurveyTakenByCase('5000K000028Qp7EQAS'); 
        if(res != NULL && res.data != NULL){ 
            listSurveyTaken = res.data; 
            
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
    public PageReference redirect(){
            system.debug('ULALALA:');
        List<SurveyTaker__c> listSurvey = [SELECT Id FROM SurveyTaker__c WHERE Id=:id];
        if(listSurvey.size() > 0){
            PageReference pageRef = new PageReference('/'+id);
            // return pageRef;
            return NULL;
        }else{
            return NULL;
        }
    }
    
    
    
    public AXAAPI014B_response getSTDetail(String surveyId){  
        AXAAPI014B_response res = AXAAPI014B_SurveyTakenById.getSurveyTakenById(surveyId);
        if(res != NULL && res.data != NULL){ 
            Cache.SessionPartition sessionPart = Cache.Session.getPartition('local.axaPartition'); 
        }else{ 
            res = new AXAAPI014B_response();
            res.data = new AXAAPI014B_response.Data();
        } 
        return res;
    } 
    
    
}