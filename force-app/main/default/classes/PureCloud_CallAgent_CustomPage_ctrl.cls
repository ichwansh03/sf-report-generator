public class PureCloud_CallAgent_CustomPage_ctrl {
    public String id {get;set;} 
    public AXAAPI020B_response detail {get;set;} 
    public List<AXAAPI011A_response.data> listOpenTask {get;set;} 
    public List<AXAAPI011A_response.data> listHistoryTask {get;set;} 
     
    public PureCloud_CallAgent_CustomPage_ctrl(){  
        id = ApexPages.currentPage().getParameters().get('id'); 
        if(id != NULL && id.left(3) == Schema.SObjectType.Purecloud__c.getKeyPrefix()) {
            detail = getPureCloud(id);
            
            // id = 'a012s000003lHNbAAM';
            AXAAPI011A_response resListOpen = AXAAPI011A_TaskActHistoryByParam.getTaskByParam('open-activity/','whatId',id,0,10); 
            if(resListOpen != NULL && resListOpen.data != NULL){ 
                listOpenTask = resListOpen.data;
            } 
            AXAAPI011A_response resListHistory = AXAAPI011A_TaskActHistoryByParam.getTaskByParam('activity-history','whatId',id,0,10); 
            if(resListHistory != NULL && resListHistory.data != NULL){ 
                listHistoryTask = resListHistory.data;
            }   
        } 
    } 
     
     
    
    public PageReference redirect(){
        List<purecloud__c> listSurvey = [SELECT Id FROM purecloud__c WHERE Id=:id];
        if(listSurvey.size() > 0){
            PageReference pageRef = new PageReference('/'+id);
            // return pageRef;
            return NULL;
        }else{
            return NULL;
        }
    }
    
    public AXAAPI020B_response getPureCloud(String pureCloudId){  
        AXAAPI020B_response res = AXAAPI020B_PurecloudById.getPureCloudbyid(pureCloudId);
        system.debug('Social: '+res);
        if(res != NULL && res.data != NULL){ 
            Cache.SessionPartition sessionPart = Cache.Session.getPartition('local.axaPartition'); 
        }else{ 
            res = new AXAAPI020B_response();
            res.data = new AXAAPI020B_response.Data();
        } 
        return res;
    }    
    
     
}