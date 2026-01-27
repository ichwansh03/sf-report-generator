public class LookupPopup_ctrl {
    public String query {get; set;}
    public List<Contact> contacts {get; set;}
    public Boolean doneLookup {get; set;}    
    
    
    public String processTime {get;set;}
    public Integer skip {get;set;}
    public Integer take {get;set;} 
    public Integer total_page {get;set;}
    public Integer current_page {get;set;}
    public String to_page {get;set;} 
    public static final Integer SIZE_DATA_RELATED_LIST = Integer.valueOf(Label.AXASFDC_RowLimitRelatedList);   
    public string infoPagination {get;set;}
    public integer countPagination {get;set;} 
    
    
    public Long mulai {get;set;}
    public Long selesai {get;set;}
    public Integer totalRow {get;set;} 
    public string currentEntity {get;set;}
    
    // constructor
    public LookupPopup_ctrl() {
        doneLookup=false;
        refresh();
        
        currentEntity = [Select entity__c From User Where Id = :UserInfo.getUserId()][0].entity__c;
        
        if (currentEntity.contains('AFI') || currentEntity.contains('ALI')) {
            currentEntity = 'a%i';
        } 
    }
    
    
    public void refresh(){  
        processTime = ''; 
        totalRow = 0;
        skip = 0;
        current_page = 1; 
        total_page = 1;
        take = SIZE_DATA_RELATED_LIST; 
        
    }
     
    
    // executes the search
    public PageReference runQuery() {
        
        mulai =  DateTime.now().getTime();
        
        query = query.trim();
        String searchString = query + '%';
        system.debug('::query'+searchString);
        system.debug('::SIZE_DATA_RELATED_LIST:'+SIZE_DATA_RELATED_LIST);
        system.debug('::skip:'+skip); 
        system.debug('::Select id, name, phone, mobilephone, email from Contact where name LIKE '+query+' limit '+SIZE_DATA_RELATED_LIST+' OFFSET '+skip); 
        List<Contact> searchResults= [ Select id, name, phone, Policy_No__c ,mobilephone, email from Contact where name LIKE :searchString and entity__c like :currentEntity  order by CreatedDate asc limit :SIZE_DATA_RELATED_LIST OFFSET :skip];
        
        system.debug('searchResults:'+searchResults);
         totalRow = [Select count() from Contact where name LIKE :searchString];  
        
        Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
        countPage = countPage.round(System.RoundingMode.CEILING);
        total_page = integer.valueOf(countPage);
        
        
        integer currentTotal = current_page*SIZE_DATA_RELATED_LIST;
        system.debug('current_page:'+current_page);
        system.debug('SIZE_DATA_RELATED_LIST:'+SIZE_DATA_RELATED_LIST);
        system.debug('skip:'+skip);
        system.debug('currentTotal:'+currentTotal);
        /* if (currentTotal < skip) { 
        	system.debug('currentTotal 1:');
        	infoPagination = '('+currentTotal+' - '+skip+')';
        } */
        if (current_page == countPage) { 
			integer nilaia = math.mod(totalRow, SIZE_DATA_RELATED_LIST); 
        	infoPagination = '('+skip+' - '+nilaia+')'; 
        } else {
        	system.debug('currentTotal 2:');
        	infoPagination = '('+skip+' - '+currentTotal+')'; 
        } 
        
         
        system.debug('totalRow == '+totalRow); 
        system.debug('countPage == '+countPage); 
        system.debug('total_page == '+total_page); 
        selesai =  Datetime.now().getTime();
        system.debug('selesai == '+selesai); 
        system.debug('mulai == '+mulai); 
        processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
        processTime += '<br/>Total : ' + totalRow + ' records';
        system.debug('processTime == '+processTime); 
        
        contacts=searchResults;
        doneLookup=true;
        return null;
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
        runQuery();
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
        runQuery();
         
    }
 
    /* public PageReference runQuery() {
        List<List<Contact>> searchResults=
            [FIND :query IN ALL FIELDS RETURNING 
             Contact (id, name, phone, mobilephone, email)];
        contacts=searchResults[0];
        doneLookup=true;
        return null;
    }*/
}