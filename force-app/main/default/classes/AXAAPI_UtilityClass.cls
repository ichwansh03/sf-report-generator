public class AXAAPI_UtilityClass {
	
    
    // add by Ranti at 12/30/2021
    public static final Integer SIZE_DATA_RELATED_LIST = Integer.valueOf(Label.AXASFDC_RowLimitRelatedList);  
    // end by Ranti
    
    public static Datetime stringToDatetime(String s){
        try{
            if(s != NULL && s != '' && ! s.contains('1900')){
                String[] splitdate = s.split('-');
                //system.debug(Integer.valueOf(splitdate[0])+' '+Integer.valueOf(splitdate[1])+' '+ Integer.valueOf(splitdate[2]));
                //Date dt = (s != NULL) ? Date.newInstance(Integer.valueOf(splitdate[0]), Integer.valueOf(splitdate[1]), Integer.valueOf(splitdate[2])) : NULL;
                Datetime dt = Datetime.valueOfGmt(s);
                return dt;
            }else{
                return NULL;
            }
        }catch(Exception ex){
            system.debug('error:'+ex.getMessage());
            return NULL;
        }
    }
    
    public static Date stringToDate(String s){
        try{
            if(s != NULL && s != ''){
                String[] splitdate = s.split('-');
                //system.debug(Integer.valueOf(splitdate[0])+' '+Integer.valueOf(splitdate[1])+' '+ Integer.valueOf(splitdate[2]));
                //Date dt = (s != NULL) ? Date.newInstance(Integer.valueOf(splitdate[0]), Integer.valueOf(splitdate[1]), Integer.valueOf(splitdate[2])) : NULL;
                Date dt = Date.valueOf(splitdate[0]);
                return dt;
            }else{
                return NULL;
            }
        }catch(Exception ex){
            system.debug('error:'+ex.getMessage());
            return NULL;
        }
    }
    
    public static Boolean stringToBoolean(String s){
        try{
            if(s != NULL && s != ''){
                if (s.contains('1') || s.contains('true')) {
                    s = 'true';
                } else if (s.contains('0') || s.contains('false')) { 
                    s = 'false';
                }
                return Boolean.valueOf(s);
            }else{
                return NULL;
            }
        }catch(Exception ex){
            system.debug('error:'+ex.getMessage());
            return NULL;
        }
    }
    
        public static String getsObjectNameById(String Id, String sobjname, String fieldname){
        try{
            if(Id != NULL && Id != ''){
                String queryStr='SELECT Id, ' + fieldname + ' from ' + sobjname + ' WHERE Id = :Id LIMIT 1';
                List<sobject> list_sobj = Database.query(queryStr); 
                if(list_sobj.size()>0){ 
                    return (String)list_sobj[0].get(fieldname);
                }else{
                    // return Id;
                    return '';
                }
            }else{
                // return Id;
                return '';
            }
        }catch(Exception ex){
            system.debug('error:'+ex.getMessage());
            return '';
        }
    }
    
    public static String getsMilestoneNameByTypeId(String Id){
        try{
            if(Id != NULL && Id != ''){
                String queryStr='SELECT Id, MilestoneType.name from MilestoneType WHERE Id = :Id LIMIT 1';
                List<sobject> list_sobj = Database.query(queryStr);
                if(list_sobj.size()>0){
                    return (String)list_sobj[0].get('MilestoneType.name');
                }else{
                    return Id;
                }
            }else{
                return Id;
            }
        }catch(Exception ex){
            system.debug('error:'+ex.getMessage());
            return Id;
        }
    }
    
    
    public static String getNewAttachmentID(String Id){
       //Id = '00P6F00001zcpxbUAA';
        try{
            if(Id != NULL && Id != ''){
                String queryStr='SELECT Id from Attachment WHERE Description = :Id LIMIT 1';
               
                List<sobject> list_sobj = Database.query(queryStr);
                if(list_sobj.size()>0){
                    return (String)list_sobj[0].get('Id');
                }else{
                    return Id;
                }
            }else{
                return Id;
            }
        }catch(Exception ex){
            system.debug('error:'+ex.getMessage());
            return Id;
        }
    }
    
    public static Map<Id, String> getsObjectNameByIds(Set<Id> Ids, String sobjname, String fieldname){
        Map<Id, String> map_sobj = new Map<Id, String>();
        for(Id i:Ids){
            map_sobj.put(i, i);
        }
        try{
            if(Ids.size() > 0){
                String queryStr='SELECT Id, ' + fieldname + ' from ' + sobjname + ' WHERE Id IN :Ids';
                List<sobject> list_sobj = Database.query(queryStr);
                if(list_sobj.size()>0){
                    for(sobject obj:list_sobj){
                        map_sobj.put((Id)obj.get('Id'), (String)obj.get(fieldname));
                    }
                }
            }
        }catch(Exception ex){
            system.debug('error:'+ex.getMessage());
        }
        return map_sobj;
    }
     
    public static Map<string,integer> getDataNext(Integer current_page){
        Integer to_page = current_page + 1;
        Integer skip = (to_page - 1) * SIZE_DATA_RELATED_LIST + 1;
        current_page = to_page;
        Integer take = to_page * SIZE_DATA_RELATED_LIST;  
        
        Map<string,integer> paginationList2 = new Map<string,integer>();
        paginationList2.put('skip',skip);
        paginationList2.put('take',take);
        paginationList2.put('current_page',current_page); 
        return paginationList2; 
    }
     
    public static  Map<string,integer> getDataPrevious(Integer current_page){
        Integer to_page = current_page - 1;
        Integer skip = (to_page - 1) * SIZE_DATA_RELATED_LIST + 1;
        current_page = to_page;
        Integer take = to_page * SIZE_DATA_RELATED_LIST; 
        
        Map<string,integer> paginationList2 = new Map<string,integer>();
        paginationList2.put('skip',skip);
        paginationList2.put('take',take);
        paginationList2.put('current_page',current_page); 
        return paginationList2; 
    }
    
    
    public static  Map<string,integer> getDataToPage(Integer current_page, String to_page){
        Integer to_page2 = Integer.valueOf(to_page);
        Integer skip = (to_page2 - 1) * SIZE_DATA_RELATED_LIST + 1;
        current_page = to_page2;
        Integer take = to_page2 * SIZE_DATA_RELATED_LIST; 
         
        Map<string,integer> paginationList2 = new Map<string,integer>();
        paginationList2.put('skip',skip);
        paginationList2.put('take',take);
        paginationList2.put('current_page',current_page); 
        return paginationList2; 
    }
    
    public static  Map<string,integer> getDataFirst(Integer current_page){
        Integer skip = 0;
        current_page = 1;
        Integer take = SIZE_DATA_RELATED_LIST; 
        
        Map<string,integer> paginationList2 = new Map<string,integer>();
        paginationList2.put('skip',skip);
        paginationList2.put('take',take);
        paginationList2.put('current_page',current_page); 
        return paginationList2; 
    }
    
    public static  Map<string,integer> getDataLast(Integer totalPage){
        Integer to_page = totalPage;
        Integer skip = (to_page - 1) * SIZE_DATA_RELATED_LIST + 1;
        Integer current_page = to_page;
        Integer take = to_page * SIZE_DATA_RELATED_LIST; 
        
        Map<string,integer> paginationList2 = new Map<string,integer>();
        paginationList2.put('skip',skip);
        paginationList2.put('take',take);
        paginationList2.put('current_page',current_page); 
        return paginationList2; 
    } 
    
    public static List<String> showListPagination(Integer current_page, integer totalPage) {
        
    	List<string>  ShowPaginate = new List<string>();
        integer nilaiAwal  = 0;
        integer nilaiAkhir = 0;
         
        if ( (current_page != null && current_page > 0) && (totalPage != null && totalPage > 0)) {
        	Decimal middleTotalPage = ((double) totalPage)/current_page; 
            if (current_page == 1) { 
                if (totalPage > current_page) {
                    nilaiAwal = current_page;
                    if (totalPage > 1) nilaiAkhir = current_page+1;
                    if (totalPage > 2) nilaiAkhir = current_page+2; 
                } else { 
                    nilaiAwal = current_page;
                    nilaiAkhir = current_page;
                }
            } else if (middleTotalPage > 0) { 
                if (current_page == totalPage) {  
                    nilaiAkhir = current_page; 
                    if (current_page > 0) nilaiAwal = current_page-1;
                    if (nilaiAwal > 1) nilaiAwal = current_page-2;  
                } else {                  
                    nilaiAwal = current_page-1; 
                    nilaiAkhir = current_page+1; 
                }
            } 
            for (integer i = nilaiAwal; i <= nilaiAkhir; i++) {
                ShowPaginate.add(string.valueOf(i));
            } 
            /* for (integer i = 1; i <= totalPage; i++) {
                ShowPaginate.add(string.valueOf(i));
            } */
        } 
        return ShowPaginate;
    }
}