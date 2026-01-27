public class Attachment_CustomPage_ctrl {
    public String id {get;set;}
    public String parent_id {get;set;}
	public List<AXAAPI005B_response.Data> list_attachment {get;set;}
    public AXAAPI005A_response att {get;set;}
   
    public boolean firstLoadAttachments {get;set;}
    
    
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
    
    public Attachment_CustomPage_ctrl(ApexPages.StandardController controller){
        id = ApexPages.currentPage().getParameters().get('id');
        if(id != NULL && id.left(3) == Schema.SObjectType.Attachment.getKeyPrefix()) att = getAttachmentDetail(id);
    }
    public Attachment_CustomPage_ctrl(){
        id = ApexPages.currentPage().getParameters().get('id');
        if(id != NULL && id.left(3) == Schema.SObjectType.Attachment.getKeyPrefix()) att = getAttachmentDetail(id);
    }
    
   public void loadAttachments(){
        
        
            refresh();
        
        //setTrueVaribale('LoadAttachments'); 
        mulai =  DateTime.now().getTime(); 
       id = ApexPages.currentPage().getParameters().get('id');
       id = id+'%';
       system.debug('AttachMentId: ' + id + 'Skip: ' + skip + ' || Take: ' + take);
       list_attachment = new List<AXAAPI005B_response.Data>(); 
        // AXAAPI005B_response res = AXAAPI005B_AttachmentByCaseID.getAttachmentByCaseID('02s6F00000fTo4GQAS');
        AXAAPI005B_response res = AXAAPI005B_AttachmentByCaseID.getAttachmentByCaseID(id, skip, take);
		system.debug('Res: ' + res.data);
       if(res != NULL && res.data != NULL){
            list_attachment = res.data; 
             
            totalRow = res.counts; 
            Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
            countPage = countPage.round(System.RoundingMode.CEILING);
            total_page = integer.valueOf(countPage);
                 
        } else if(res != NULL && res.message != NULL){
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
    
    
    public AXAAPI005A_response getAttachmentDetail(String id){
        AXAAPI005A_response res = AXAAPI005A_AttachmentById.getAttachmentById(id);  
        res.data.Owner_Name = AXAAPI_UtilityClass.getsObjectNameById(res.data.OwnerId, 'User', 'Name');
        string parentId = res.data.ParentId;
        String parentName = '';
        if (parentId != null &&  parentId.left(3) == Schema.SObjectType.Case.getKeyPrefix()) {  
            /* AXAAPI001B_response cs_byID = new AXAAPI001B_response();
            cs_byID = AXAAPI001B_CaseById.getCaseById(parentId);  
            if(cs_byID != null && cs_byID.data != null ) parentName = cs_byID.data.caseNumber;   */
            res.data.Parent_Name = AXAAPI_UtilityClass.getsObjectNameById(parentId, 'Case', 'CaseNumber'); 
        } else if (parentId != null &&  parentId.left(3) == Schema.SObjectType.EmailMessage.getKeyPrefix()) {
            
            /* AXAAPI002A_response dataEmail = AXAAPI002A_EmailMessageById.getEmailById(parentId);   
            if(dataEmail != null && dataEmail.data != null ) parentName = dataEmail.data.subject;   */
            
        	res.data.Parent_Name = AXAAPI_UtilityClass.getsObjectNameById(res.data.ParentId, 'EmailMessage', 'subject'); 
        } else if (parentId != null && parentId.left(3) == Schema.SObjectType.Email_sms_log__c.getKeyPrefix()) {
            
            /* AXAAPI003B_response dataEmail = AXAAPI003B_EmailSMSLogById.getEmailSMSLogById(parentId);   
            if(dataEmail != null && dataEmail.data != null ) parentName = dataEmail.data.name;   */
            
        	res.data.Parent_Name = AXAAPI_UtilityClass.getsObjectNameById(res.data.ParentId, 'Email_sms_log__c', 'name'); 
        }
        
        res.data.Parent_Name = parentName;
        res.data.Size = (Integer.valueOf(res.data.bodyLength) / 1000 ) + 'KB';
        // res.data.url = '/servlet/servlet.FileDownload?file='+id;
        res.data.url = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+'/servlet/servlet.FileDownload?file='+id;
        
        res.data.CreatedBy_Name = AXAAPI_UtilityClass.getsObjectNameById(res.data.CreatedById, 'User', 'Name');
        res.data.LastModifiedBy_Name = AXAAPI_UtilityClass.getsObjectNameById(res.data.LastModifiedById, 'User', 'Name');
        
        return res;
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
        setLoadRecords();
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
        setLoadRecords();
         
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
        setLoadRecords();
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
        setLoadRecords();
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
        setLoadRecords();
         
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
    
    public void setLoadRecords() { 
        LoadAttachments(); 
    }
}