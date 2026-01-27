public with sharing class CaseInquiryController_AGI {
 public String availableCaseTypeKeeper {get; set;}
 public String selectedCaseTypeKeeper {get; set;}
 public String caseTypeFieldId {get; set;}
 public Case cs {get; set;}
 public String firstLoad {get; set;}
 public String retURL {get; set;}
 public String entity {get;set;}
 public String selectedQueueDept {get; set;}
 public String QueueDept {get; set;}

 
 ///CaseInquiry?retURL=/{!Contact.Id}&def_contact_id={!Contact.Id}&def_account_id={!Account.Id}&RecordType={!Contact.Inquiry_RecordTypeId_Keeper__c}&cas5=Inquiry
 public CaseInquiryController_AGI(ApexPages.StandardController std){
     cs = new Case();
     caseTypeFieldId=System.Label.CaseTypeFieldId;
     cs.contactId = Apexpages.currentPage().getParameters().get('def_contact_id');  
     cs.accountId = Apexpages.currentPage().getParameters().get('def_account_id');  
     cs.recordTypeId = Apexpages.currentPage().getParameters().get('RecordType');
     system.debug('Record Type =='+cs.recordTypeId);
     cs.type = Apexpages.currentPage().getParameters().get('cas5');  
     retURL = Apexpages.currentPage().getParameters().get('retURL');
     firstLoad = Apexpages.currentPage().getParameters().get('firstLoad');
     entity =  Apexpages.currentPage().getParameters().get('entity');
     cs.status = 'New';
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
         }else{
             //for(String caseType : cs.MultiSelect__c.split(';')){
             integer temp = 0;
             boolean temp2 = FALSE;

             for(String caseType : selectedCaseTypeKeeper.split('<br />')){
                 temp += 1;
                 if (temp > 1) temp2 = TRUE;
                 system.debug('ENTITY: '+entity);
                 
                 List<Master_Case_Type_Regional__c> mctr = [SELECT Id, PIC_Department__c, TAT__c, Product__c, Business_Channel__c, Department_Queue__c FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :caseType AND Entity__c = :entity AND Product__c = :cs.Product__c AND Business_Channel__c = :cs.Business_Channel__c AND Active__c = TRUE AND Department_Queue__c != '' LIMIT 1];

                 system.debug('>>> caseType : '+caseType);
                 cse = new Case();
                 cse.contactId = cs.contactId;
                 cse.Status = 'Closed';
                 cse.type = cs.type;
                 cse.Priority = cs.Priority;
                 cse.Service_Type__c = cs.Service_Type__c;
                 cse.origin = cs.origin;
                 cse.Case_Type__c = caseType;
                 cse.Case_Type_Config__c = caseType;
                 /*Before:*/ //cse.Case_Type__c = caseType;  //--> Edited by Hamfry (CCC Wave 2 project)
                 cse.Subject = cs.Subject;
                 cse.Product__c = cs.Product__c;
                 cse.Description = cs.Description;
                 cse.accountId = cs.accountId;
                 cse.recordTypeId = cs.recordTypeId;
                 cse.createdbyId = UserInfo.getUserId();
                 cse.Negative_Feedback__c = cs.Negative_Feedback__c;
                 cse.parentid = cs.parentid;
                 cse.NonPP__c = cs.NonPP__c; //added by catur
                 cse.MultiCreate__c = TRUE; // taufik, track multi create.
                 cse.X2nd_Record__c = temp2; // taufik, track multi create, record ke-2
                 /*cse.Escalated_Flow__c = esalatedFlowGenerator(caseType, entity);
                 cse.Escalated_Flow_TAT__c = esalatedFlowTATGenerator(caseType, entity);*/
                 cse.Entity_Backup__c = entity;
                 cse.OwnerId = UserInfo.getUserId();
                 Id userId = Userinfo.getUserId();
                 String userName=[Select Id, Name from User where Id =: userId].Name;
                 system.debug('userName: '+userName);
                 cse.Case_Escalation__c = userName;
                 
                 /*if(mctr.size() > 0) {
                    cse.PIC_Department_LU__c = mctr[0].PIC_Department__c;
                    cse.TAT__c = mctr[0].TAT__c;
                    cse.Division__c = mctr[0].Department_Queue__c;
                    selectedQueueDept = mctr[0].Department_Queue__c;
                 } else {
                    //List<User> u = [SELECT Id FROM User WHERE IsActive = true AND Entity__c = :entity AND UserRole.Name LIKE '%CCC Manager%' LIMIT 1];
                    String qDefCaseType = entity + ' Default Case Type';
                    List<Master_Case_Type_Regional__c> altmctr = [SELECT Id, PIC_Department__c, TAT__c, Department_Queue__c FROM Master_Case_Type_Regional__c WHERE Entity__c = :entity AND Name = :qDefCaseType AND Active__c = TRUE AND Department_Queue__c != '' LIMIT 1];
                    if(altmctr.size() > 0) {
                        cse.PIC_Department_LU__c = altmctr[0].PIC_Department__c;            
                    } else {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'No Master Case Type Regional found, please contact your Administrator.'));
                    }
                    selectedQueueDept = 'Temporary';
                 }
                 QueueDept = selectedQueueDept.replaceAll( '\\s+', '_');
                 System.debug('*********** QueueDept: ' + QueueDept);
                 String qDevName = entity + '_' + QueueDept + '_Queue';
                 List<Group> gQueue = [SELECT Id FROM Group WHERE Type = 'Queue' AND DeveloperName = :qDevName];
                 if(gQueue.size() > 0) {
                    cse.OwnerId = gQueue[0].Id;
                 } else {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'No Queue available, please contact your Administrator.'));
                 }
                 */
                 
                 cse.Branch_AGI__c = cs.Branch_AGI__c;
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
             integer temp = 0;
             boolean temp2 = FALSE;
             
             for(String caseType : selectedCaseTypeKeeper.split('<br />')){
                 temp += 1;
                 if (temp > 1) temp2 = TRUE;
                 
                 System.debug('Entity: '+entity);
                 System.debug('Product: '+cs.Product__c);
                 System.debug('Case Type: '+cs.Case_Type__c);
                 System.debug('Business Channel: '+cs.Business_Channel__c);
                 System.debug('Entity Backup: '+cs.Entity_Backup__c);
                 System.debug('Type: '+cs.Type);
                 
                 List<Master_Case_Type_Regional__c> mctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Product__c, Business_Channel__c, Department_Queue__c FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :caseType AND Entity__c = :entity AND Product__c = :cs.Product__c AND Business_Channel__c = :cs.Business_Channel__c AND Active__c = TRUE AND Department_Queue__c != '' LIMIT 1];
                 
                 system.debug('>>> caseType : '+caseType);
                 system.debug('MCTR ==>'+mctr);
                 system.debug('MCTR Size ==>'+mctr.size());
                 cse = new Case();
                 cse.contactId = cs.contactId;
                 cse.Status = cs.Status;
                 cse.type = cs.type;
                 cse.Priority = cs.Priority;
                 cse.Service_Type__c = cs.Service_Type__c;
                 cse.origin = cs.origin;
                 cse.Case_Type__c = caseType;
                 cse.Case_Type_Config__c = caseType;  
                 /*Before:*/ //cse.Case_Type__c = caseType;  //--> Edited by Hamfry (CCC Wave 2 project)
                 cse.Subject = cs.Subject;
                 cse.Description = cs.Description;
                 cse.accountId = cs.accountId;
                 cse.recordTypeId = cs.recordTypeId;
                 cse.createdbyId = UserInfo.getUserId();
                 cse.Negative_Feedback__c = cs.Negative_Feedback__c;
                 cse.parentid = cs.parentid;
                 cse.NonPP__c = cs.NonPP__c; //added by catur
                 cse.MultiCreate__c = TRUE; // taufik, track multi create.
                 cse.X2nd_Record__c = temp2; // taufik, track multi create, record ke-2
                 cse.Escalated_Flow__c = esalatedFlowGenerator(caseType, entity);
                 cse.Escalated_Flow_TAT__c = esalatedFlowTATGenerator(caseType, entity);
                 cse.Entity_Backup__c = entity;
                 
                 // Taufik - Next Department
                 Map<String, Object> mapJs = (Map<String, Object>) JSON.deserializeUntyped(cse.Escalated_Flow__c);
                 System.debug('mapJs : ' + mapJs);
                 String mapIndex = String.valueOf(2);
            
                 if (mapJs.get(mapIndex) == NULL) cse.Next_Department__c = 'CCC';
                 else if (mapJs.get(mapIndex) == 'null') cse.Next_Department__c = 'CCC';
                 else cse.Next_Department__c = string.valueof(mapJs.get(mapIndex)); // <-- isi di sini, hasil Break dari Escalated Flow
                 // End Taufik - Next Department
                 
                 //Modif by Daniel, 16 Januri 2019
                 if(mctr.size() > 0) {
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
                        cse.PIC_Department_LU__c = altmctr[0].PIC_Department__c;
                        cse.TAT__c = altmctr[0].TAT__c;
                        cse.SLA_Case_Closed__c = altmctr[0].SLA__c;
                        cse.Division__c = altmctr[0].Department_Queue__c;
                        selectedQueueDept = altmctr[0].Department_Queue__c;
                    } else {
                        selectedQueueDept = 'Temporary';
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
                 }
                
                 cse.Product__c = cs.Product__c;
                 cse.Branch_AGI__c = cs.Branch_AGI__c;
                 cse.Business_channel__c = cs.Business_channel__c;
                 cse.Complainant__c = cs.Complainant__c;
                 cse.Others_Detail__c = cs.Others_Detail__c;
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
        }
        
        return jsonValue;
    }
}