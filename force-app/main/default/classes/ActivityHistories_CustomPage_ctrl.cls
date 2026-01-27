public class ActivityHistories_CustomPage_ctrl {

    public String id {get;set;}
    public boolean isConsole {get;set;}
    public AXAAPI028B_response activity_histories {get;set;}

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
    
    public ActivityHistories_CustomPage_ctrl(){
        refresh();    
        id = ApexPages.currentPage().getParameters().get('id');
        system.debug(id+'|'+ Schema.SObjectType.Activity_History__c.getKeyPrefix());
        
        
        String urlVal = Apexpages.currentPage().getUrl();
        system.debug(':::URl:'+urlVal);
        if(urlVal != null && urlVal.contains('console')) {
             isConsole = false;  
        } else {
            isConsole = true;    
        }           
        //if(id != NULL && id.left(3) == Schema.SObjectType.Activity_History__c.getKeyPrefix()) {
            
            String uniqueId = ApexPages.currentPage().getParameters().get('lastId'); 
            String bucketName = ApexPages.currentPage().getParameters().get('bucketName');
            System.debug('::uniqueId:'+uniqueId);
            System.debug('::id.length():'+id.length());
            if (id.length() > 14 && id.length() < 18 && uniqueId != null) {
                id = id+uniqueId;
            }  
            
            activity_histories = getHistoriesDetail(id, bucketName);
            system.debug('MID PAY:'+activity_histories);
        //}
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
    
    public AXAAPI028B_response getHistoriesDetail(String recordid, String bucketName){
        activity_histories = AXAAPI028B_ActivityHistoriesByID.getActivityHistories(recordid);
        activity_histories.data.call_Bucket_c_name = bucketName;
        System.debug('BucketName: ' + bucketName);
        return activity_histories;
    }
}