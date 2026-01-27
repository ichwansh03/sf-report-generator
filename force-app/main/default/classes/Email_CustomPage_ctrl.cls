public class Email_CustomPage_ctrl {
	public String id {get;set;}
    public String parent_id {get;set;}
    public List<AXAAPI002B_response.Data> emails {get;set;}
    public AXAAPI002A_response email {get;set;}
    
    public String Body_HTML {get;set;}
    
    public Email_CustomPage_ctrl(ApexPages.StandardController controller){
        id = ApexPages.currentPage().getParameters().get('id');
    }
    
    public Email_CustomPage_ctrl(){
        id = ApexPages.currentPage().getParameters().get('id');
        system.debug(id+'|'+ Schema.SObjectType.EmailMessage.getKeyPrefix());
        if(id != NULL && id.left(3) == Schema.SObjectType.EmailMessage.getKeyPrefix()) {
            String uniqueId = ApexPages.currentPage().getParameters().get('lastId'); 
            System.debug('::uniqueId:'+uniqueId);
            System.debug('::id.length():'+id.length());
            if (id.length() > 14 && id.length() < 18 && uniqueId != null) {
                id = id+uniqueId;
            }  
            
            email = getEmailDetail(id);
        } 
        
        Cache.SessionPartition sessionPart = Cache.Session.getPartition('local.axaPartition');
        if(Cache.Session.get('BodyHTML') != NULL) Body_HTML = (String)sessionPart.get('BodyHTML');
        system.debug(Body_HTML);
    }
    
    public PageReference redirect(){
        List<EmailMessage> list_email = [SELECT Id FROM EmailMessage WHERE Id=:id limit 1];
        if(list_email.size() > 0){
            PageReference pageRef = new PageReference('/'+id);
            return pageRef;
            //return NULL;
        }else{
            return NULL;
        }
    }
    
    public AXAAPI002A_response getEmailDetail(String email_id){
        AXAAPI002A_response res = AXAAPI002A_EmailMessageById.getEmailById(email_id);
        if(res != NULL && res.data != NULL){
            res.data.Body_Short = removeNewLine(res.data.textBody).left(100);
            // res.data.Parent_Name = AXAAPI_UtilityClass.getsObjectNameById(res.data.ParentId, 'Case', 'CaseNumber');
            res.data.lastModifiedById_Name = AXAAPI_UtilityClass.getsObjectNameById(res.data.lastModifiedById, 'User', 'Name');
            res.data.createdById_Name = AXAAPI_UtilityClass.getsObjectNameById(res.data.createdById, 'User', 'Name');
            
            Cache.SessionPartition sessionPart = Cache.Session.getPartition('local.axaPartition');
            sessionPart.put('BodyHTML', res.data.htmlBody);
        }else{
            res = new AXAAPI002A_response();
            res.data = new AXAAPI002A_response.Data();
        }
        //res.data.contact_name = AXAAPI_UtilityClass.getsObjectNameById(res.data.contactId, 'Contact', 'Name');
        //res.data.RecordType_Name = Schema.SObjectType.Case.getRecordTypeInfosById().get(res.data.recordtypeid).getname();
        return res;
    }
     
    public void loadEmails(){
        emails = new List<AXAAPI002B_response.Data>();
        AXAAPI002B_response res = AXAAPI002B_EmailMessageByParentId.getEmailByParentId(id, 0, 10);
        //AXAAPI002B_response res = AXAAPI002B_EmailMessageByParentId.getEmailByParentId('5006F00001TsffrQAB');
        if(res != NULL && res.data != NULL){
            emails = res.data;
        }
    }
    
    public void loadEmails_vf_case(){
        emails = new List<AXAAPI002B_response.Data>();
        AXAAPI002B_response res = AXAAPI002B_EmailMessageByParentId.getEmailByParentId(id,0,10);
        //AXAAPI002B_response res = AXAAPI002B_EmailMessageByParentId.getEmailByParentId('5006F00001TscutQAB');
        if(res != NULL && res.data != NULL){
            emails = res.data;
        }
    }
 
    public String removeNewLine(String text){
        text = text.replace('\r\n', ' ');
        text = text.replace('\n', ' ');
        text = text.replace('\r', ' ');
        
        return text;
    }
}