public class PureCloudCallService_CustomPage_ctrl {
    public String id {get;set;}
    public String parent_id {get;set;} 
    
    public AXAAPI024B_response pureCallService {get;set;}
    public List<AXAAPI011A_response.data> listOpenTask {get;set;} 
    public List<AXAAPI011A_response.data> listHistoryTask {get;set;} 
        
    public PureCloudCallService_CustomPage_ctrl(ApexPages.StandardController controller){
        id = ApexPages.currentPage().getParameters().get('id');
    }
    
    public PureCloudCallService_CustomPage_ctrl(){
        id = ApexPages.currentPage().getParameters().get('id');
        system.debug(id+'|'+ Schema.SObjectType.Call_Line__c.getKeyPrefix());
        if(id != NULL && id.left(3) == Schema.SObjectType.PureCloud_Call_Service__c.getKeyPrefix()) {
            pureCallService = getpureCallService(id);
        }
        
        AXAAPI011A_response resListOpen = AXAAPI011A_TaskActHistoryByParam.getTaskByParam('open-activity/','whatId',id,0,10); 
        if(resListOpen != NULL && resListOpen.data != NULL){ 
           listOpenTask = resListOpen.data;
        } 
        AXAAPI011A_response resListHistory = AXAAPI011A_TaskActHistoryByParam.getTaskByParam('activity-history','whatId',id,0,10); 
        if(resListHistory != NULL && resListHistory.data != NULL){ 
            listHistoryTask = resListHistory.data;
        }   
    }
   
    public AXAAPI024B_response getpureCallService(String id){
        
        AXAAPI024B_response res = AXAAPI024B_PureCloudCallServiceByID.getPureCloudCallServiceByID(id); 
        return res;
    } 
}