public class ArchivedObject_CustomPage_ctrl { 
    public List<AXAAPI029A_response.Data> customObjects {get;set;}
     
    public ArchivedObject_CustomPage_ctrl(){
       loadCustomObjects();
    }
        
    public void loadCustomObjects(){
        
        String date_string = String.valueOf(date.today());
        customObjects = new List<AXAAPI029A_response.Data>();
        AXAAPI029A_response res = AXAAPI029A_GetCustomObjectDetail.getCustomObjectList(date_string);
        
        if(res != NULL && res.data != NULL){
            customObjects = res.data;
        }
    }
    
  
}