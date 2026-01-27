public with sharing class CaseInquiryControllerNegativeFeedback {
    public String availableCaseTypeKeeper {get; set;} 
    public String selectedCaseTypeKeeper {get; set;}
    public String caseTypeFieldId {get; set;}
    public Case cs {get; set;}
    public String firstLoad {get; set;}
    public String retURL {get; set;}
    public String entity {get;set;} 
    public String CallLineId {get;set;}
   
    
    ///CaseInquiry?retURL=/{!Contact.Id}&def_contact_id={!Contact.Id}&def_account_id={!Account.Id}&RecordType={!Contact.Inquiry_RecordTypeId_Keeper__c}&cas5=Inquiry
    // CaseInquiryContact?retURL=/{!Contact.Id}&def_contact_id={!Contact.Id}&def_account_id={!Account.Id}&RecordType={!Contact.Inquiry_RecordTypeId_Keeper__c}&cas5=Inquiry&firstLoad=new&entity={!Contact.Entity__c}
    //CaseComplaintLayoutContact?retURL=/{!Contact.Id}&def_contact_id={!Contact.Id}&def_account_id={!Account.Id}&RecordType={!Contact.Record_Type_Keeper__c}&00N9000000CD53R=0&cas5=Complaint&ent=Case&cas11=contact&entity={!Contact.Entity__c}
    public CaseInquiryControllerNegativeFeedback(ApexPages.StandardController std){
        cs = new Case();
        caseTypeFieldId=System.Label.CaseTypeFieldId;
        cs.contactId = Apexpages.currentPage().getParameters().get('def_contact_id');  
        cs.accountId = Apexpages.currentPage().getParameters().get('def_account_id');  
        cs.recordTypeId = Apexpages.currentPage().getParameters().get('RecordType');
        cs.type = Apexpages.currentPage().getParameters().get('cas5');  
        retURL = Apexpages.currentPage().getParameters().get('retURL');
        firstLoad = Apexpages.currentPage().getParameters().get('firstLoad');
        entity =  Apexpages.currentPage().getParameters().get('entity');
        CallLineId =  Apexpages.currentPage().getParameters().get('callLineId');
         
        // updated by Ranti	 at 28/09/2021 change default status closed
        
        if (entity == 'AMFS') {
        	cs.status = 'Closed';    
        }  
        
        String negative = Apexpages.currentPage().getParameters().get('isnegative');
        cs.ParentId = Apexpages.currentPage().getParameters().get('idcase');
      if(negative == 'yes'){
          cs.origin = 'Negative Feedback';
      }
        cs.Negative_Feedback__c = Apexpages.currentPage().getParameters().get('nfid');
        system.debug('>>>firstLoad: '+firstLoad);
        system.debug('>>>caseTypeFieldId: '+caseTypeFieldId);
        system.debug('>>>recordTypeId: '+cs.recordTypeId);
    }
     
    public PageReference save_n_close() {
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
            }
            else if (selectedCaseTypeKeeper == ''){
               firstLoad = 'new';
               ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.error, 'Choose case type minimum 1.' ));
               return null;
            }
            else{
               String[] caseTypes = selectedCaseTypeKeeper.split('<br />');
               CaseServiceController caseService = new CaseServiceController();
               List<Case> result = new List<Case>();
               result = caseService.processInquirySaveWithClosedStatus(cs, caseTypes);
               firstLoad = 'save';
           
               ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.info, 'Saving Case Inquiry is success.' ));
                 
             }
        } catch(Exception e){
            firstLoad = 'error';
            ApexPages.addMessages(e);
        }
        return null;
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
            }
            else if (selectedCaseTypeKeeper == ''){
               firstLoad = 'new';
               ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.error, 'Choose case type minimum 1.' ));
               return null;
            }
            else{
               String[] caseTypes = selectedCaseTypeKeeper.split('<br />');
               CaseServiceController caseService = new CaseServiceController();
               List<Case> result = new List<Case>();
               result = caseService.processInquirySave(cs, caseTypes);
                
               firstLoad = 'save';
            
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