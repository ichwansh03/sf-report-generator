public with sharing class CaseInquiryController {
 public String availableCaseTypeKeeper {get; set;}
 public String selectedCaseTypeKeeper {get; set;}
 public String caseTypeFieldId {get; set;}
 public Case cs {get; set;}
 public String firstLoad {get; set;}
 public String retURL {get; set;}
 public String entity {get;set;}

 
 ///CaseInquiry?retURL=/{!Contact.Id}&def_contact_id={!Contact.Id}&def_account_id={!Account.Id}&RecordType={!Contact.Inquiry_RecordTypeId_Keeper__c}&cas5=Inquiry
 public CaseInquiryController(ApexPages.StandardController std){
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
 }
  
 public PageReference save() {
     system.debug('>>>firstLoad: '+firstLoad);
     system.debug('>>>caseTypeFieldId: '+caseTypeFieldId);
     system.debug('>>>recordTypeId: '+cs.recordTypeId);
     //selectedCaseTypeKeeper=selectedCaseTypeKeeper.replaceAll('&#124;&#124;', '||');
     system.debug('>>>selectedCaseTypeKeeper: '+selectedCaseTypeKeeper);
     List<Case> caseList = new List<Case>();
     Case cse = null;
     try {
         if(firstLoad == 'save'){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.info, 'You cannot save record that already saved. Please click Cancel button.' ));
         }else{
             //for(String caseType : cs.MultiSelect__c.split(';')){
             for(String caseType : selectedCaseTypeKeeper.split('<br />')){
                 system.debug('>>> caseType : '+caseType);
                 cse = new Case();
                 cse.contactId = cs.contactId;
                 cse.Status = cs.Status;
                 cse.type = cs.type;
                 cse.Priority = cs.Priority;
                 cse.Service_Type__c = cs.Service_Type__c;
                 cse.origin = cs.origin;
                 cse.Case_Type_Config__c = caseType;	//Before: cse.Case_Type__c = caseType;	--> Edited by Hamfry (CCC Wave 2 project)
                 cse.Subject = cs.Subject;
                 cse.Description = cs.Description;
                 cse.accountId = cs.accountId;
                 cse.recordTypeId = cs.recordTypeId;
                 cse.createdbyId = UserInfo.getUserId();
                 
                 caseList.add(cse);
             }
             insert caseList;
             firstLoad = 'save';
        
             ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.info, 'Saving Case Inquiry is success.' ));
          }
     } catch(Exception e){
         firstLoad = 'error';
         ApexPages.addMessages(e);
     }
     return null;
  }

 public PageReference cancel() {
    return new PageReference(retURL);
 } 
}