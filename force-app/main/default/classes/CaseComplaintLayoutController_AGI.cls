public with sharing class CaseComplaintLayoutController_AGI {
 public String availableCaseTypeKeeper {get; set;}
 public String selectedCaseTypeKeeper {get; set;}
 public String caseTypeFieldId {get; set;}
 public String natureConfigFieldId {get; set;}
 public Case cs {get; set;}
 public String firstLoad {get; set;}
 public String retURL {get; set;}
 public String entity {get;set;}
 //public String comment {get;set;}
 public String accId {get;set;}
 public boolean isDisplayAFI {get;set;}
 //public boolean isDisplayAMFS {get;set;}
 public boolean isDisplayMAGI {get;set;}
 public boolean isDisplayAFI_AMFS {get;set;} 
 public String CurrentId {get;set;}
 public String source {get;set;}
 //public List<CaseComment> caseCommentList {get;set;}
 public User userObj {get;set;}
 public String loggedInUser {get;set;}
 public String contactId {get;set;}
 public String inquiryId {get;set;}    
  
 ApexPages.StandardController controller;
    
 public CaseComplaintLayoutController_AGI(ApexPages.StandardController std){
     controller = std;
     cs = new Case();
     
     //&parentPageName=contact
     String parentPageName = ApexPages.currentPage().getParameters().get('parentPageName'); 
     System.debug('===========parentPageName : '+parentPageName);
     
     
     cs.recordTypeId = Apexpages.currentPage().getParameters().get('RecordType');
     cs.type = Apexpages.currentPage().getParameters().get('cas5'); 
     retURL = Apexpages.currentPage().getParameters().get('retURL');
     firstLoad = Apexpages.currentPage().getParameters().get('firstLoad');
     entity =  Apexpages.currentPage().getParameters().get('entity');
     source = Apexpages.currentPage().getParameters().get('cas11');
     cs.CHS_Status__c ='New';
     contactId = Apexpages.currentPage().getParameters().get('cas3');
     
     caseTypeFieldId=System.Label.CaseTypeFieldId;
     natureConfigFieldId = System.Label.NatureConfigFieldId;
     
     if (source == 'email') {
         //cs.Contactid = ApexPages.currentPage().getParameters().get('cas3');
         if(contactId != null && contactId != ''){
                cs.ContactId = contactId;
            }else{
                cs.ContactId = null;
            }
         
         
         //cs.Subject=ApexPages.currentPage().getParameters().get('cas14');
         cs.Origin = ApexPages.currentPage().getParameters().get('cas11');
         
         String caseId = retURL.substring(1, retURL.length());
         system.debug('Case ID ==>'+ caseId);
         //Case c = [SELECT Id, Description FROM Case WHERE Id = :caseId];
         //cs.Description__c = c.Description;
         
         inquiryId = caseId;
         //system.debug('========= inquiryId : ' + inquiryId);
         
         
         /*
         cs = new Case();
         caseTypeFieldId=System.Label.CaseTypeFieldId;
         cs.contactId = Apexpages.currentPage().getParameters().get('def_contact_id');  
         cs.accountId = Apexpages.currentPage().getParameters().get('def_account_id');  
         cs.recordTypeId = Apexpages.currentPage().getParameters().get('RecordType');
         cs.type = Apexpages.currentPage().getParameters().get('cas5');  
         retURL = Apexpages.currentPage().getParameters().get('retURL');
         firstLoad = Apexpages.currentPage().getParameters().get('firstLoad');
         entity =  Apexpages.currentPage().getParameters().get('entity');
         cs.status = 'New';
         
         
         system.debug('>>>firstLoad: '+firstLoad);
         system.debug('>>>caseTypeFieldId: '+caseTypeFieldId);
         system.debug('>>>recordTypeId: '+cs.recordTypeId);
         */
         
     }
     else if (source == 'contact') {
        cs.Contactid = ApexPages.currentPage().getParameters().get('def_contact_id');
        accId = ApexPages.currentPage().getParameters().get('def_account_id');
        
    }
     
    isDisplayAFI = false;
    //isDisplayAMFS = false;
    isDisplayMAGI = false;
    isDisplayAFI_AMFS = false;
    
    userObj = [SELECT id, Entity__c, Profile.Name FROM user WHERE id = :UserInfo.getUserId()];
    loggedInUser = userObj.id;
    entity = userObj.Entity__c;
     
    if (entity=='AMFS') {
        //isDisplayAMFS = true;
        isDisplayAFI_AMFS = true;
    }else if (entity=='AFI') {
        isDisplayAFI = true;
        isDisplayAFI_AMFS = true;
    }else if (entity=='MAGI') {
        isDisplayMAGI = true;
    } 
 }
  
 public PageReference save() {
     try{
         collectiveSave();
         
         //controller.save();
         //String CurrentId = cse.Id;
         PageReference redirectPG = new PageReference('/' + CurrentId);
         redirectPG.setRedirect(true);
         return redirectPG; 
     }catch(DmlException ex){
         ApexPages.addMessages(ex); //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
         return null;
     }
 }

 public PageReference SaveAndNew(){
    collectiveSave();
     
    PageReference p = new PageReference('/apex/CaseComplaintLayout?retURL=/'+retURL+'&def_contact_id='+cs.Contactid+'&def_account_id='+accId+'&RecordType='+cs.recordTypeId+'&cas5=Complaint&ent=Case');
    p.setRedirect(true);
    return p;
 }
    
 public PageReference cancel() {
    return new PageReference(retURL);
 } 
 
 private void collectiveSave(){
     List<CaseComment> cases = [Select Id, ParentId, IsPublished, CommentBody, CreatedById, CreatedDate, SystemModstamp, LastModifiedDate, LastModifiedById, IsDeleted From CaseComment LIMIT 1000];
     List<Case> caseList = new List<Case>();
     Case cse = null;
     cse = new Case();
     system.debug('Inquiry ID ==>'+ inquiryId);
     system.debug('Record Type ==>'+ cs.type);
     system.debug('Record Type ==>'+ cs.recordtypeid);
     cse.Id = inquiryId;
     cse.contactId = cs.contactId;
     cse.Status = cs.Status;
     cse.type = cs.type;
     cse.Priority = cs.Priority;
     cse.Service_Type__c = cs.Service_Type__c;
     cse.origin = cs.origin;
     //cse.Case_Type_AGI__c = cs.Case_Type_AGI__c;
     cse.CHS_Status__c = cs.CHS_Status__c;
     cse.PIC__c = cs.PIC__c;
     cse.Pending_Status__c = cs.Pending_Status__c;
     cse.Sub_Status__c = cs.Sub_Status__c;
     cse.Service_Type__c = cs.Service_Type__c;
     cse.Subject = cs.Subject;
     cse.Description = cs.Description;
     cse.Nature__c = cs.Nature__c;
     cse.Customer__c = cs.Customer__c;
     cse.Case_Type__c = '';
     cse.Category__c = cs.Category__c;
     cse.Customer_type__c = cs.Customer_type__c;
     cse.Business_channel__c = cs.Business_channel__c;
     cse.Complainant__c = cs.Complainant__c;
     cse.Channel__c = cs.Channel__c;
     cse.Received_date__c = cs.Received_date__c;
     cse.Complaint_type__c = cs.Complaint_type__c;
     cse.Priority = cs.Priority;
     cse.Product__c = cs.Product__c;
     cse.Description__c = cs.Description__c;
     cse.Lampiran__c = cs.Lampiran__c;
     cse.Back_Office_PIC__c = cs.Back_Office_PIC__c;
     cse.Appeal__c = cs.Appeal__c;
     cse.Region__c = cs.Region__c;
     cse.Related_ticket__c = cs.Related_ticket__c;
     cse.Other_Information__c = cs.Other_Information__c;
     cse.Case_Error__c = cs.Case_Error__c;
     cse.Complaint__c = cs.Complaint__c;
     cse.Demand__c = cs.Demand__c;
     cse.Chronological__c = cs.Chronological__c;
     cse.Financial_Lost__c = cs.Financial_Lost__c;
     cse.Financial_Lost_Currency__c = cs.Financial_Lost_Currency__c;
     cse.Reason_Root_Cause__c = cs.Reason_Root_Cause__c;
     cse.Corrective_Action__c = cs.Corrective_Action__c;
     cse.Recommendation__c = cs.Recommendation__c;
     cse.accountId = cs.accountId;
     cse.recordTypeId = cs.recordTypeId;
     //cse.createdbyId = UserInfo.getUserId();
     cse.FCR__c = false;
     cse.Received_date__c = cs.Received_date__c;
     cse.Objek_Pertanggungan__c = cs.Objek_Pertanggungan__c;
     cse.Jenis_Pertanggungan__c = cs.Jenis_Pertanggungan__c;
     cse.Tanggal_Assign__c = cs.Tanggal_Assign__c;
     cse.Bengkel__c = cs.Bengkel__c;
     cse.Lokasi_Survey__c = cs.Lokasi_Survey__c;
     cse.PIC_Surveyor__c = cs.PIC_Surveyor__c;
     cse.COB__c = cs.COB__c;
     cse.Received_Party__c = cs.Received_Party__c;
     cse.Activity_Log__c = cs.Activity_Log__c;
     cse.Complaint_Resume__c = cs.Complaint_Resume__c;
     cse.Progress_Action__c = cs.Progress_Action__c;
     //cse.ParentId= inquiryId;
     
     caseList.add(cse);
     update caseList;
     
     CurrentId = cse.Id;
     
     //update Inquiry record become REAL Inquiry  
     if (inquiryId != null || inquiryID == '' ) {
            List<Case> inquiryCase = [select id, Non_Inquiry__c from Case where id=:inquiryId];

            if (!inquiryCase.isEmpty()) {
               Case c=inquiryCase[0];   
               
               //system.debug('=== c.Non_Inquiry__c BEFORE : ' + c.Non_Inquiry__c);
               c.Non_Inquiry__c = true;
               //system.debug('=== c.Non_Inquiry__c AFTER : ' + c.Non_Inquiry__c);
               update c;
            }
        
     }
     
     /*
     for(Case cs: caseList){
        CaseComment csComment = new CaseComment();
        csComment.CommentBody = comment;
        csComment.ParentId = cs.id; 
        caseCommentList.add(csComment);
     }
     insert caseCommentList;
     */
     
 }
}