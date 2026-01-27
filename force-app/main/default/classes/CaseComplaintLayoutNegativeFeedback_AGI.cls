public with sharing class CaseComplaintLayoutNegativeFeedback_AGI {
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
// new ALI - Okt 2017
 public boolean isDisplayCustType {get;set;}
 public boolean isDisplayProduct {get;set;}
 public boolean isDisplayRegion {get;set;}
 public boolean isDisplayComplaintType {get;set;}
 public boolean isDisplayPriority {get;set;}
 public boolean isDisplayChannel {get;set;}
 public boolean isDisplayRelatedDepartments {get;set;}
 
 public String selectedQueueDept {get; set;}
 public String QueueDept {get; set;}

  
 ApexPages.StandardController controller;
    
 public CaseComplaintLayoutNegativeFeedback_AGI(ApexPages.StandardController std){
    controller = std;
    cs = new Case();
    
    //&parentPageName=contact
    String parentPageName = ApexPages.currentPage().getParameters().get('parentPageName'); 
    System.debug('===========parentPageName : '+parentPageName);
    
   caseTypeFieldId=System.Label.CaseTypeFieldId;
   natureConfigFieldId = System.Label.NatureConfigFieldId;
   cs.recordTypeId = Apexpages.currentPage().getParameters().get('RecordType');
   cs.type = Apexpages.currentPage().getParameters().get('cas5'); 
   retURL = Apexpages.currentPage().getParameters().get('retURL');
   firstLoad = Apexpages.currentPage().getParameters().get('firstLoad');
   entity =  Apexpages.currentPage().getParameters().get('entity');
   source = Apexpages.currentPage().getParameters().get('cas11');
   cs.CHS_Status__c ='New';
   contactId = Apexpages.currentPage().getParameters().get('cas3');
   String negative = Apexpages.currentPage().getParameters().get('isnegative');
   cs.ParentId = Apexpages.currentPage().getParameters().get('idcase');
   if(negative == 'yes'){
       cs.origin = 'Negative Feedback';
   }
   cs.Negative_Feedback__c = Apexpages.currentPage().getParameters().get('nfid');
       
           
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
       //Case c = [SELECT Id, Description FROM Case WHERE Id = :caseId];
     //cs.Description__c = c.Description;
     
     inquiryId = caseId;
     system.debug('========= inquiryId : ' + inquiryId);
     
     
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

// new ALI - Okt 2017
  isDisplayCustType = True;
  isDisplayProduct = TRUE;
  isDisplayRegion = TRUE;
  isDisplayComplaintType = TRUE;
  isDisplayPriority = TRUE;
  isDisplayChannel = TRUE;
  isDisplayRelatedDepartments = FALSE;

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
  }else if (entity=='ALI') {
    isDisplayCustType = False; // hide.
    isDisplayProduct = FALSE; // hide.
    isDisplayRegion = FALSE; // hide.

    // pindah ke CMU.
    isDisplayComplaintType = FALSE;
    isDisplayPriority = FALSE;
    isDisplayChannel = FALSE;

    isDisplayRelatedDepartments = TRUE;
    
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
      ApexPages.addMessages(ex);  //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
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
     List<Master_Case_Type_Regional__c> mctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Product__c, Business_Channel__c, Department_Queue__c, Current_User__c FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :cs.Category_Config__c AND Entity__c = :entity AND Product__c = :cs.Product__c AND Business_Channel__c = :cs.Business_Channel__c AND Active__c = TRUE AND (Department_Queue__c != '' OR Current_User__c = TRUE) LIMIT 1];
     //List<CaseComment> cases = [Select Id, ParentId, IsPublished, CommentBody, CreatedById, CreatedDate, SystemModstamp, LastModifiedDate, LastModifiedById, IsDeleted From CaseComment LIMIT 1000];
     List<Case> caseList = new List<Case>();
     Case cse = null;
     cse = new Case();
     cse.contactId = cs.contactId;
     cse.Status = cs.Status;
     cse.type = cs.type;
     cse.Priority = cs.Priority;
     cse.Service_Type__c = cs.Service_Type__c;
     cse.origin = cs.origin;
     cse.Case_Type_Config__c = cs.Case_Type_Config__c;
     cse.CHS_Status__c = cs.CHS_Status__c;
     //cse.PIC__c = cs.PIC__c;
     cse.Pending_Status__c = cs.Pending_Status__c;
     cse.Sub_Status__c = cs.Sub_Status__c;
     cse.Service_Type__c = cs.Service_Type__c;
     cse.Subject = cs.Subject;
     cse.Description = cs.Description;
     //cse.Nature__c = cs.Nature__c;
     //cse.Nature_AGI__c = cs.Nature__c;
     cse.Nature_Config__c = cs.Nature_Config__c;
     cse.Customer__c = cs.Customer__c;
     //cse.Category__c = cs.Category__c;
     cse.Category_Config__c = cs.Category_Config__c;
     //cse.Category_AGI__c = cs.Category__c;
     cse.Customer_type__c = cs.Customer_type__c;
     cse.Business_channel__c = cs.Business_channel__c;
     cse.Complainant__c = cs.Complainant__c;
     cse.Others_Detail__c = cs.Others_Detail__c;
     cse.Channel__c = cs.Channel__c;
     cse.Received_date__c = cs.Received_date__c;
     cse.Complaint_type__c = cs.Complaint_type__c;
     cse.Priority = cs.Priority;
     cse.Product__c = cs.Product__c;
     cse.Escalated_Flow__c = esalatedFlowGenerator(cs.Category_Config__c, entity);
     cse.Escalated_Flow_TAT__c = esalatedFlowTATGenerator(cs.Category_Config__c, entity);
     //cse.Product_AGI__c = cs.Product_AGI__c;
     //cse.Complaint_Type_AGI__c = cs.Complaint_Type_AGI__c;
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
     cse.createdbyId = UserInfo.getUserId();
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
     cse.ParentId = cs.ParentId;
     cse.Negative_Feedback__c = cs.Negative_Feedback__c;
     
     // Taufik - Next Department
     Map<String, Object> mapJs = (Map<String, Object>) JSON.deserializeUntyped(cse.Escalated_Flow__c);
     System.debug('mapJs : ' + mapJs);
     String mapIndex = String.valueOf(2);

     if (mapJs.get(mapIndex) == NULL) cse.Next_Department__c = 'CCC';
     else if (mapJs.get(mapIndex) == 'null') cse.Next_Department__c = 'CCC';
     else cse.Next_Department__c = string.valueof(mapJs.get(mapIndex)); // <-- isi di sini, hasil Break dari Escalated Flow
     // End Taufik - Next Department
     
     /*if(mctr.size() > 0) {
        cse.PIC_Department_LU__c = mctr[0].PIC_Department__c;
        cse.TAT__c = mctr[0].TAT__c;
        cse.SLA_Case_Closed__c = mctr[0].SLA__c;
        cse.Division__c = mctr[0].Department_Queue__c;
        selectedQueueDept = mctr[0].Department_Queue__c;
     } else {
        //List<User> u = [SELECT Id FROM User WHERE IsActive = true AND Entity__c = :entity AND UserRole.Name LIKE '%CCC Manager%' LIMIT 1];
        String qDefCaseType = entity + ' Default Case Type';
        List<Master_Case_Type_Regional__c> altmctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Department_Queue__c FROM Master_Case_Type_Regional__c WHERE Entity__c = :entity AND Name = :qDefCaseType AND Active__c = TRUE AND Department_Queue__c != '' LIMIT 1];
        if(altmctr.size() > 0) {
             cse.PIC__c = altmctr[0].PIC_Department__c;
             cse.TAT__c = altmctr[0].TAT__c;
             cse.SLA_Case_Closed__c = altmctr[0].SLA__c;
             cse.Division__c = altmctr[0].Department_Queue__c;
             selectedQueueDept = altmctr[0].Department_Queue__c;    
         } else {
             selectedQueueDept = 'CMU';
             //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'No Master Case Type Regional found, please contact your Administrator.'));
         }
     }
     QueueDept = selectedQueueDept.replaceAll( '\\s+', '_');
     System.debug('*********** QueueDept: ' + QueueDept);
     String qDevName = entity + '_' + QueueDept + '_Queue';
     List<Group> gQueue = [SELECT Id FROM Group WHERE Type = 'Queue' AND DeveloperName = :qDevName];
     if(gQueue.size() > 0) {
         cse.OwnerId = gQueue[0].Id;
     } else {
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'No Queue available, please contact your Administrator.'));
     }*/
     
     //Updated 11 Februari 2019  
     if(mctr.size() > 0) {
         if(mctr[0].Current_User__c) {
             cse.PIC__c = UserInfo.getUserId();
             cse.PIC_Department_LU__c = UserInfo.getUserId();
         } else {
             cse.PIC__c = mctr[0].PIC_Department__c;
             cse.PIC_Department_LU__c = mctr[0].PIC_Department__c;
         }
         cse.TAT__c = mctr[0].TAT__c;
         cse.SLA_Case_Closed__c = mctr[0].SLA__c;
         cse.Division__c = mctr[0].Department_Queue__c;
         if(mctr[0].Current_User__c) {
             selectedQueueDept = 'Current User';
         } else {
             selectedQueueDept = mctr[0].Department_Queue__c;
         }
     } else {
         //List<User> u = [SELECT Id FROM User WHERE IsActive = true AND Entity__c = :entity AND UserRole.Name LIKE '%CCC Manager%' LIMIT 1];
         String qDefCaseType = entity + ' Default Case Type';
         List<Master_Case_Type_Regional__c> altmctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Department_Queue__c, Current_User__c FROM Master_Case_Type_Regional__c WHERE Entity__c = :entity AND Name = :qDefCaseType AND Active__c = TRUE AND Type__c = :cs.Type LIMIT 1];
         if(altmctr.size() > 0) {
             if(altmctr[0].Current_User__c) {
                 cse.PIC__c = UserInfo.getUserId();
                 cse.PIC_Department_LU__c = UserInfo.getUserId();
             } else {
                 cse.PIC__c = altmctr[0].PIC_Department__c;
                 cse.PIC_Department_LU__c = altmctr[0].PIC_Department__c;
             }
             
             cse.TAT__c = altmctr[0].TAT__c;
             cse.SLA_Case_Closed__c = altmctr[0].SLA__c;
             cse.Division__c = altmctr[0].Department_Queue__c;
             
             if(altmctr[0].Current_User__c) {
                 selectedQueueDept = 'Current User';
             } else {
                 selectedQueueDept = altmctr[0].Department_Queue__c;
             }
         } else {
             selectedQueueDept = 'Temporary';
             //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'No Master Case Type Regional found, please contact your Administrator.'));
         }
     }
     if(selectedQueueDept != 'Current User') {
         if(selectedQueueDept.contains('&')){
             QueueDept = 'Product_Dev_Marketing';
         }
         else {
             QueueDept = selectedQueueDept.replaceAll( '\\s+', '_');
         }
         System.debug('*********** QueueDept: ' + QueueDept);
         String qDevName = entity + '_' + QueueDept + '_Queue';
         List<Group> gQueue = [SELECT Id FROM Group WHERE Type = 'Queue' AND DeveloperName = :qDevName];
         if(gQueue.size() > 0) {
             cse.OwnerId = gQueue[0].Id;
             if (selectedQueueDept == 'Temporary') {cse.PIC_Department_LU__c = UserInfo.getUserId();}
         } else {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'No Queue available, please contact your Administrator.'));
         }
     }
     
     caseList.add(cse);
     cse.NonPP__c = cs.NonPP__c; //added by catur
     insert caseList;
     
     CurrentId = cse.Id;
     
     //update Inquiry record become REAL Inquiry  
     if (inquiryId != null || inquiryID == '' ) {
         List<Case> inquiryCase = [select id, Non_Inquiry__c from Case where id=:inquiryId];

      if (!inquiryCase.isEmpty()) {
         Case c=inquiryCase[0];
         
         system.debug('=== c.Non_Inquiry__c BEFORE : ' + c.Non_Inquiry__c);
         c.Non_Inquiry__c = true;
         system.debug('=== c.Non_Inquiry__c AFTER : ' + c.Non_Inquiry__c);
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
 
 private String esalatedFlowGenerator(String caseType, String entity) {
        List<Master_Case_Type_Regional__c> mctr = [SELECT Id, Department_Queue__c, Department_Queue_2__c, Department_Queue_3__c, Department_Queue_4__c, Department_Queue_5__c
                                                   FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :caseType AND Entity__c = :entity AND Product__c = :cs.Product__c AND
                                                   Business_Channel__c = :cs.Business_Channel__c AND Type__c = :cs.type AND Active__c = TRUE AND Department_Queue__c != '' LIMIT 1];
        String jsonValue = '';
        if(mctr.size() > 0) {
            jsonValue += '{';
            jsonValue += '"1":"'+mctr[0].Department_Queue__c+'",';
            jsonValue += '"2":"'+mctr[0].Department_Queue_2__c+'",';
            jsonValue += '"3":"'+mctr[0].Department_Queue_3__c+'",';
            jsonValue += '"4":"'+mctr[0].Department_Queue_4__c+'",';
            jsonValue += '"5":"'+mctr[0].Department_Queue_5__c+'"}';
        } else {
            jsonValue = '{}';
        }
        
        return jsonValue;
    }
    
    private String esalatedFlowTATGenerator(String caseType, String entity) {
        List<Master_Case_Type_Regional__c> mctr = [SELECT Id, TAT__c, TAT_2__c, TAT_3__c, TAT_4__c, TAT_5__c
                                                   FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :caseType AND Entity__c = :entity AND Product__c = :cs.Product__c AND
                                                   Business_Channel__c = :cs.Business_Channel__c AND Type__c = :cs.type AND Active__c = TRUE AND Department_Queue__c != '' LIMIT 1];
        String jsonValue = '';
        if(mctr.size() > 0) {
            jsonValue += '{';
            jsonValue += '"1":"'+mctr[0].TAT__c+'",';
            jsonValue += '"2":"'+mctr[0].TAT_2__c+'",';
            jsonValue += '"3":"'+mctr[0].TAT_3__c+'",';
            jsonValue += '"4":"'+mctr[0].TAT_4__c+'",';
            jsonValue += '"5":"'+mctr[0].TAT_5__c+'"}';
        } else {
            jsonValue = '{}';
        }
        
        return jsonValue;
    }
}