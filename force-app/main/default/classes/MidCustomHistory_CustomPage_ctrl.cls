public class MidCustomHistory_CustomPage_ctrl {

    public String id {get;set;}
    public boolean isConsole {get;set;}
    
    //public List<AXAAPI02BA_response.Data> mid_custom_history {get;set;}
    public AXAAPI027B_response mid_custom {get;set;}
   
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
    
    public MidCustomHistory_CustomPage_ctrl(ApexPages.StandardController controller){
        refresh();    
       id = ApexPages.currentPage().getParameters().get('id');
        system.debug(id+'|'+ Schema.SObjectType.MID_Custom_History__c.getKeyPrefix());
         // if(id != NULL && id.left(3) == Schema.SObjectType.MID_Secure_Payment__c.getKeyPrefix()) mid_pay = getPaymentDetail(id); 
    } 
    
     public MidCustomHistory_CustomPage_ctrl(){
        refresh();    
        id = ApexPages.currentPage().getParameters().get('id');
        system.debug(id+'|'+ Schema.SObjectType.MID_Custom_History__c.getKeyPrefix());
        
        
        String urlVal = Apexpages.currentPage().getUrl();
        system.debug(':::URl:'+urlVal);
        if(urlVal != null && urlVal.contains('console')) {
             isConsole = false;  
        } else {
            isConsole = true;    
        }           
        if(id != NULL && id.left(3) == Schema.SObjectType.MID_Custom_History__c.getKeyPrefix()) {
            
            String uniqueId = ApexPages.currentPage().getParameters().get('lastId'); 
            System.debug('::uniqueId:'+uniqueId);
            System.debug('::id.length():'+id.length());
            if (id.length() > 14 && id.length() < 18 && uniqueId != null) {
                id = id+uniqueId;
            }  
            
            mid_custom = getPaymentDetail(id);
            system.debug('MID PAY:'+mid_custom);
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
    
    public AXAAPI027B_response getPaymentDetail(String recordid){
        mid_custom = AXAAPI027B_MidCustomHistoryByID.getMidCustomHistory(recordid);
        
        return mid_custom;
    }
    
    
}