public class CaseRequestLayoutNegativeFeedbackALI {
  public String availableCaseTypeKeeper {get; set;}
  public String selectedCaseTypeKeeper {get; set;}
  public String caseTypeFieldId {get; set;}
  public Case cs {get; set;}
  public String firstLoad {get; set;}
  public String retURL {get; set;}
  public String entity {get;set;}
  public String source {get;set;}
  public String contactId {get;set;}
  public String comment {get;set;}
  public String CurrentId {get;set;}
  public String accId {get;set;}
  public String caseId {get;set;}
  public User userObj {get; set;}
  public boolean IsAFIAndAMFS {get; set;}
  public boolean IsMAGI {get; set;}
  public boolean isAMFS {get; set;}
  public boolean isAFI {get; set;}
  //public String encodedString {get;set;}
  public String selectedQueueDept {get; set;}
  
  ApexPages.StandardController controller;
   
  public CaseRequestLayoutNegativeFeedbackALI(ApexPages.StandardController std){
    userObj = [SELECT id, Entity__c, Profile.Name FROM user WHERE id = :UserInfo.getUserId()];
    entity = userObj.Entity__c;
    controller = std;
    cs = new Case();
    caseTypeFieldId=System.Label.CaseTypeFieldId;
    //cs.AccountId = Apexpages.currentPage().getParameters().get('cas4');
    cs.recordTypeId = Apexpages.currentPage().getParameters().get('RecordType');
    cs.type = Apexpages.currentPage().getParameters().get('cas5'); 
    retURL = Apexpages.currentPage().getParameters().get('retURL');
    firstLoad = Apexpages.currentPage().getParameters().get('firstLoad');
    //entity =  Apexpages.currentPage().getParameters().get('entity');
    source = Apexpages.currentPage().getParameters().get('cas11');
    contactId = Apexpages.currentPage().getParameters().get('cas3');
    cs.status = 'New';
    cs.parentid = Apexpages.currentPage().getParameters().get('idcase');
    //caseId = retURL.substring(1, retURL.length());
    String negative = Apexpages.currentPage().getParameters().get('isnegative');
    if(negative == 'yes'){
       cs.origin = 'Negative Feedback';
    }
    cs.accountId= ApexPages.currentPage().getParameters().get('def_account_id');
     //caseId = retURL.substring(1, retURL.length());
    cs.Negative_Feedback__c = Apexpages.currentPage().getParameters().get('nfid'); 
    cs.Contactid = ApexPages.currentPage().getParameters().get('def_contact_id');
    if(entity=='MAGI'){
      IsMAGI = true;
    }else if(entity=='AMFS'){   // catur, 20170703 - CR Modify Type Request (AMFS Only)
      isAMFS = true;
      IsAFIAndAMFS = true;
    }else{
      isAFI = true;
      IsAFIAndAMFS = true;
    }
    String   a1  ;
    String  a2  ;
    String  a3  ;
    String  a4  ;
    String  a5  ;


    /*
    if(source=='none'){
        cs.Contactid = ApexPages.currentPage().getParameters().get('def_contact_id');
        accId = ApexPages.currentPage().getParameters().get('def_account_id');
    }
    else if(source=='email'){
     if(contactId != null && contactId != ''){
       cs.ContactId = contactId;
     }else{
       cs.ContactId = null;
     }
     cs.accountId= ApexPages.currentPage().getParameters().get('def_account_id');
     caseId = retURL.substring(1, retURL.length());
     //cs.Origin = ApexPages.currentPage().getParameters().get('cas11');
      //cs.Subject = ApexPages.currentPage().getParameters().get('cas14');  
     //Case c = [SELECT Id, Description FROM Case WHERE Id = :caseId];
    //cs.Description = c.Description;
    }
    */
  }
    
  public PageReference save() {
    try{
      collectiveSave();

      //controller.save();
      PageReference redirectPG = new PageReference('/' + CurrentId);
      redirectPG.setRedirect(true);
      return redirectPG;  
    }catch(DmlException ex){
      ApexPages.addMessages(ex);  //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
      return null;
    }
  }
  
  public PageReference SaveAndNew(){
    //collectiveSave();

    if(!Test.isRunningTest()){
      collectiveSave();

      PageReference p;

      if(source=='none'){
        p = new PageReference('/apex/CaseRequestLayout?retURL=/'+retURL+'&def_contact_id='+cs.Contactid+'&def_account_id='+accId+'&RecordType='+cs.recordTypeId+'&cas5=Request&ent=Case&cas11=none');
      }
      if(source=='email'){
        //p = new PageReference('/apex/CaseRequestLayout?retURL=/'+retURL+'&RecordType='+cs.recordTypeId+'&cas5=Request&cas11=Email&cas14='+cs.Subject+'&ent=Case&cas3='+cs.ContactId);
        p = new PageReference('/apex/CaseRequestLayout?retURL=/'+retURL+'&RecordType='+cs.recordTypeId+'&cas5=Request&cas11=Email&ent=Case&cas3='+cs.ContactId);
      }
      p.setRedirect(true);
      return p;
    }else{
      return null;  
    }
  }
      
  public PageReference cancel() {
    return new PageReference(retURL);
  } 
   
  public void collectiveSave(){
    System.debug('Case Type : ' + cs.Case_Type_Config__c + ', Entity : ' + entity + ', Type : ' + cs.Type);
    //List<Master_Case_Type_Regional__c> mctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Department_Queue__c FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :cs.Case_Type_Config__c AND Entity__c = :entity AND Type__c = :cs.Type AND Active__c = TRUE AND Department_Queue__c != '' LIMIT 1]; //--Added by Suryono 12/12/2018
    //List<CaseComment> cases = [Select Id, ParentId, IsPublished, CommentBody, CreatedById, CreatedDate, SystemModstamp, LastModifiedDate, LastModifiedById, IsDeleted From CaseComment];
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
    cse.Subject = cs.Subject;
    cse.Description = cs.Description;
    cse.PIC_Department_LU__c = cs.PIC_Department_LU__c; //--Edited by Suryono 12/12/2018
    //cse.Escalated_Flow__c = esalatedFlowGenerator(cs.Case_Type_Config__c, entity);
    //cse.Escalated_Flow_TAT__c = esalatedFlowTATGenerator(cs.Case_Type_Config__c, entity);
    cse.Waktu_Kejadian__c = cs.Waktu_Kejadian__c;
    cse.Detail_of_Claim_Damage__c = cs.Detail_of_Claim_Damage__c;
    cse.Accident_Place_Claim__c   = cs.Accident_Place_Claim__c;
    cse.Lokasi_Survey__c = cs.Lokasi_Survey__c;
    cse.Coverage__c = cs.Coverage__c;
    cse.Bengkel__c = cs.Bengkel__c;
    cse.Driver_of_claim__c  = cs.Driver_of_claim__c;
    cse.Vehicle_Registration_Number__c = cs.Vehicle_Registration_Number__c;
    cse.Internal_Comment__c = cs.Internal_Comment__c;
    cse.accountId = cs.accountId;
    cse.recordTypeId = cs.recordTypeId;
    cse.createdbyId = UserInfo.getUserId();
    //cse.ParentId = caseId;
    cse.ParentId = cs.ParentId;
    cse.Negative_Feedback__c = cs.Negative_Feedback__c;
    cse.NonPP__c = cs.NonPP__c; //added by catur
    cse.Account_Number__c = cs.Account_Number__c; //added by catur 20170707
    cse.Follow_Debit_Date__c = cs.Follow_Debit_Date__c; //added by catur 20170707
    cse.Follow_Hold_Date__c = cs.Follow_Hold_Date__c; //added by catur 20170707
    cse.Amount_to_be_Debited__c = cs.Amount_to_be_Debited__c; //added by catur 20170707
    // added by catur 20171207
    cse.TS_Send_To__c = cs.TS_Send_To__c;
    cse.TS_Period_From__c = cs.TS_Period_From__c;
    /*
    CaseComment csComment = new CaseComment();
    csComment.CommentBody = comment;
    csComment.ParentId = cse.id;
    */
    caseList.add(cse);
    insert caseList;

    CurrentId = cse.Id;

    List<Case> csInquiryList = [SELECT Id, Non_Inquiry__c FROM Case WHERE id = :caseId];

    for(Case c: csInquiryList){
      c.Non_Inquiry__c = true;
    }
    update csInquiryList;
  }
}