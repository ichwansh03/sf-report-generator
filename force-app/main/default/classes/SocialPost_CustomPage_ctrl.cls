public class SocialPost_CustomPage_ctrl {
    public String id {get;set;}
    public String parent_id {get;set;} 
    public AXAAPI019B_response detail {get;set;} 
    public List<SocialPost> listDataSocial {get;set;}
    
    public SocialPost_CustomPage_ctrl(){  
        id = ApexPages.currentPage().getParameters().get('id');
        system.debug(id+'|'+ Schema.SObjectType.SocialPost.getKeyPrefix());
        if(id != NULL && id.left(3) == Schema.SObjectType.SocialPost.getKeyPrefix()) {
            detail = getSPDetail(id); 
            listDataSocial = [SELECT Id, ReplyToId,Content,handle,parent.name,postUrl,posted,personaId,parentId FROM SocialPost where ReplyToId =:id];
        } 
    }  
    
    public PageReference redirect(){
        List<SocialPost> listSurvey = [SELECT Id FROM SocialPost WHERE Id=:id];
        if(listSurvey.size() > 0){
            PageReference pageRef = new PageReference('/'+id);
            // return pageRef;
            return NULL;
        }else{
            return NULL;
        }
    }
    
    public AXAAPI019B_response getSPDetail(String socialId){  
        AXAAPI019B_response res = AXAAPI019B_SocialPostById.getSocialById(socialId);
        system.debug('Social: '+res);
        if(res != NULL && res.data != NULL){ 
            Cache.SessionPartition sessionPart = Cache.Session.getPartition('local.axaPartition'); 
        }else{ 
            res = new AXAAPI019B_response();
            res.data = new AXAAPI019B_response.Data();
        } 
        return res;
    }  
}