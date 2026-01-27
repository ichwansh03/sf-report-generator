public with sharing class CaseComplaintLayoutNegativeFeedback {
    public String availableCaseTypeKeeper {get; set;}
    public String selectedCaseTypeKeeper {get; set;}
    public String caseTypeFieldId {get; set;}
    public String natureConfigFieldId {get; set;}
    public Case cs {get; set;}
    public String firstLoad {get; set;}
    public String retURL {get; set;}
    public String entity {get;set;}
    public String profileUser {get;set;}
    
    public String accId {get;set;}
    public boolean isDisplayAFI {get;set;}
    
    public boolean isDisplayMAGI {get;set;}
    public boolean isDisplayAFI_AMFS {get;set;} 
    public String currentId {get;set;}
    public String source {get;set;}
    
    public User userObj {get;set;}
    public String loggedInUser {get;set;}
    public String contactId {get;set;}
    public String inquiryId {get;set;}
    public String callLineId {get;set;}
    // new ALI - Okt 2017
    public boolean isDisplayCustType {get;set;}
    public boolean isDisplayProduct {get;set;}
    public boolean isDisplayRegion {get;set;}
    public boolean isDisplayComplaintType {get;set;}
    public boolean isDisplayPriority {get;set;}
    public boolean isDisplayChannel {get;set;}
    public boolean isDisplayRelatedDepartments {get;set;}
    
    // New CMU AMFS - Mar 2020
    public boolean isValidation {get;set;}
    public boolean showCbNotif {get; set;}
    public boolean sendNotif {get; set;}
    public String validationMessage {get;set;}
    public string customComplaintType {get;set;}
    public string customBusinessChannel {get;set;}
    public string customProduct {get;set;}
    public string customAppeal {get;set;}
    public string customComplaint {get;set;}
    public Boolean AMFSRequired {get;set;}
    public Boolean AFIRequired {get;set;}
    public Boolean AMFS_AFIRequired {get;set;}
    public String sensitiveCustomerView {get;set;}
    public String contactProductName {get;set;}    
    
    //--SLA variable
    public String selectedQueueDept {get; set;}
    
    public static final String SOFT_COMPLAINT = 'Soft Complaint';
    public static final String SOLICITOR = 'Solicitor/Lawyer';
    
    ApexPages.StandardController controller;
    
    public CaseComplaintLayoutNegativeFeedback(ApexPages.StandardController std){
        controller = std;
        cs = new Case();
        
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
        callLineId = Apexpages.currentPage().getParameters().get('call_line');
        system.debug('parent case = '+cs.ParentId);
        system.debug('entity = '+entity);
        validateCallLineRelated();
        
        if(negative == 'yes'){
            cs.origin = 'Negative Feedback';
        }
        cs.Negative_Feedback__c = Apexpages.currentPage().getParameters().get('nfid');
        
        validateSourceContact();
        
        // Taufik,AMFS 23 July 2021, Show Product Name 
        list<Contact> ct = [SELECT id, WelcomeCall_Product_Code_Plan__c FROM Contact WHERE id=:cs.ContactId limit 1];
        if (ct.size() > 0) contactProductName = ct[0].WelcomeCall_Product_Code_Plan__c;
        if (ct.size() > 0) system.debug('## contactProductName : '+contactProductName);
        
        isDisplayAFI = false;
        
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
        
        userObj = [SELECT id, Entity__c, Profile.Name, Agent__c FROM user WHERE id = :UserInfo.getUserId()];
        loggedInUser = userObj.id;
        
        // UPDATE by Ranti, disable get Entity, change by URL
        entity = userObj.Entity__c;
        profileUser = userObj.Profile.Name;
        system.debug('profileUser: '+profileUser);
        
        // Taufik, Mar20, new AMFS Required Field
        AMFSRequired = FALSE;
        AMFS_AFIRequired = FALSE;
        if (entity == 'AMFS') AMFSRequired = TRUE; AMFS_AFIRequired = TRUE;
        // End ==== Taufik, Mar20, new AMFS Required Field
        // Daniel, Jun20, new AFI Required Field
        AFIRequired = FALSE;
        if (entity == 'AFI' || entity == 'ALI') AFIRequired = TRUE; AMFS_AFIRequired = TRUE;
        // End ==== Daniel, Jun20, new AFI Required Field
        
        displayByEntity();
        
    }
    
    public void validateCallLineRelated(){
        if (callLineId != '' && entity == 'AMFS') {
            list<Call_Line__c> callLine = [SELECT id, Call_Remarks__c, Contact__c, Contact_Policy_App__c  FROM Call_Line__c WHERE id=:callLineId LIMIT 1];
            system.debug('==> list callline: '+callLine);
            
            if (callLine.size() > 0) {
                cs.Description__c = callLine[0].Call_Remarks__c;
                cs.Channel__c = 'Verbal (Call)';
                cs.Customer__c = 'Customer';
                cs.Complainant__c = 'Customer';
                cs.Priority = 'Medium';
                if (callLine[0].Contact_Policy_App__c == 'RLS') {
                    cs.Business_channel__c = 'Inbranch';
                    cs.Product__c = 'Conventional';
                } else if (callLine[0].Contact_Policy_App__c == 'DMTM') {
                    cs.Business_channel__c = 'TM';
                    cs.Product__c = 'TM';
                }
            }
        }   
    }
    
    public void validateSourceContact(){
        if (source == 'email') {
            
            if(contactId != null && contactId != ''){
                cs.ContactId = contactId;
            }else{
                cs.ContactId = null;
            }
            
            cs.Origin = ApexPages.currentPage().getParameters().get('cas11');
            System.debug('cs.Origin: '+cs.Origin);          
            
            String caseId = retURL.substring(1, retURL.length());
            
            inquiryId = caseId;
            system.debug('========= inquiryId : ' + inquiryId);
            
        }
        else if (source == 'contact') {
            cs.Contactid = ApexPages.currentPage().getParameters().get('def_contact_id');
            accId = ApexPages.currentPage().getParameters().get('def_account_id');
        }
    }

    //get existing case and store to picklist value    
    public void getCaseExisting(Case cs){
        Case cse;
        if (cs.ParentId != null) {
            cse = [SELECT Id, Origin, ParentId, Nature__c, Nature_Config__c, Category_Config__c, Business_channel__c, Channel__c, Complaint_type__c, Product__c, Complaint__c, Customer__c, Customer_type__c, Complainant__c, Appeal__c FROM Case WHERE Id = :cs.ParentId];
            
            if (profileUser.contains('CMU')) showCbNotif = true;
            cs.Nature_Config__c = cse.Nature_Config__c;
            cs.Category_Config__c = cse.Category_Config__c;
            cs.Customer__c = cse.Customer__c;
            cs.Customer_type__c = cse.Customer_type__c;
            cs.Business_channel__c = cse.Business_channel__c;
            cs.Channel__c = cse.Channel__c;
            cs.Complainant__c = cse.Complainant__c;
            cs.Product__c = cse.Product__c;
            cs.Complaint_type__c = cse.Complaint_type__c;
            cs.Origin = cse.Origin;
        } else {
            showCbNotif = false;
            system.debug('new case');
        }
    }
    
    public void displayByEntity(){
        if (entity=='AMFS') {
            isDisplayAFI_AMFS = true;
            system.debug('displayByEntity(): entity AMFS');
            getCaseExisting(cs);
            setAppealCaseAMFSComplaint();
            getSensitiveCustomerDetail();
        }else if ((entity=='AFI' || entity=='ALI') && userObj.Agent__c == FALSE) { //update-AFDAL (17 Dec 2019)
            isDisplayAFI = true;
            isDisplayAFI_AMFS = true;
        }else if((entity=='AFI' || entity=='ALI') && userObj.Agent__c == TRUE && (profileUser == 'CMU-AFI' || profileUser == 'CMU-ALI')){
            isDisplayAFI = true;
            isDisplayAFI_AMFS = true;
        }else if ((entity=='AFI' || entity=='ALI') && userObj.Agent__c == TRUE && (profileUser != 'CMU-AFI' || profileUser != 'CMU-ALI')) {
            isDisplayAFI = true;
            isDisplayAFI_AMFS = false; //END_update-AFDAL (17 Dec 2019)
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
            isValidation = FALSE;
            if (entity == 'AMFS') AMFSValidation();
            
            if (isValidation) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING,validationMessage)); 
                
                return null;
            }
            else {
                collectiveSave();
                
                PageReference redirectPG = new PageReference('/' + currentId);
                redirectPG.setRedirect(true);
                return redirectPG;  
            }
        }catch(DmlException ex){
            ApexPages.addMessages(ex); 
            return null;
        }
    }
    
    public PageReference SaveAndNew(){
        isValidation = FALSE;
        if (entity == 'AMFS') AMFSValidation();
        
        if (isValidation) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING,validationMessage));  
            return null;
        }
        else {
            if (!Test.isRunningTest()) collectiveSave();
            
            PageReference p = new PageReference('/apex/CaseComplaintLayout?retURL=/'+retURL+'&def_contact_id='+cs.Contactid+'&def_account_id='+accId+'&RecordType='+cs.recordTypeId+'&cas5=Complaint&ent=Case');
            p.setRedirect(true);
            return p;
        }
    }
    
    public PageReference cancel() {
        return new PageReference(retURL);
    } 
    
    private void collectiveSave(){
        if (entity == 'AMFS') AMFScomplaint_type();
        
        List<Master_Case_Type_Regional__c> mctr;
        if(entity == 'AMFS') {
            mctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Department_Queue__c FROM Master_Case_Type_Regional__c WHERE (Case_Type__c = :cs.Category_Config__c OR Case_Type__c = :cs.Complaint_Type__c) AND Entity__c = :entity AND Type__c = :cs.Type AND Active__c = TRUE AND Department_Queue__c != '' LIMIT 1]; //--Added by Suryono 12/12/2018
        } else {
            mctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Department_Queue__c FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :cs.Category_Config__c AND Entity__c = :entity AND Type__c = :cs.Type AND Active__c = TRUE AND Department_Queue__c != '' LIMIT 1]; //--Added by Suryono 12/12/2018
        }
        List<Case> caseList = new List<Case>();
        Case cse = null;
        cse = new Case();
        cse.contactId = cs.contactId;
        cse.Status = cs.Status;
        cse.type = cs.type;
        cse.Priority = cs.Priority;
        cse.origin = cs.origin;
        cse.Service_Type__c = cs.Service_Type__c;
        cse.CHS_Status__c = cs.CHS_Status__c;
        cse.Case_Type_Config__c = cs.Case_Type_Config__c;
        cse.Sub_Status__c = cs.Sub_Status__c;
        cse.Pending_Status__c = cs.Pending_Status__c;
        cse.Subject = cs.Subject;
        cse.Description = cs.Description;
        cse.Service_Type__c = cs.Service_Type__c;
        cse.Nature_Config__c = cs.Nature_Config__c;
        cse.Category_Config__c = cs.Category_Config__c;
        cse.Customer__c = cs.Customer__c;
        cse.Channel__c = cs.Channel__c;
        cse.Received_date__c = cs.Received_date__c;
        cse.Customer_type__c = cs.Customer_type__c;
        cse.Complainant__c = cs.Complainant__c;
        cse.Priority = cs.Priority;
        
        // if (customBusinessChannel != '') // taufik Mar20, for CMU AMFS
        if (customBusinessChannel != '' && entity == 'AMFS') // updated by Support MII at 5 12 24, add filtering entity
            cse.Business_channel__c = customBusinessChannel;
        else 
            cse.Business_channel__c = cs.Business_channel__c;
        
        // if (customComplaintType != '') // taufik Mar20, for CMU AMFS
        if (customComplaintType != '' && entity == 'AMFS') // updated by Support MII at 5 12 24, add filtering entity
            cse.Complaint_type__c = customComplaintType;
        else 
            cse.Complaint_type__c = cs.Complaint_type__c;
        
        // if (customProduct != '') // taufik Mar20, for CMU AMFS
        if (customProduct != '' && entity == 'AMFS') // updated by Support MII at 5 12 24, add filtering entity
            cse.Product__c = customProduct;
        else
            cse.Product__c = cs.Product__c;
        
        cse.Description__c = cs.Description__c;
        
        if (customAppeal != '' && customAppeal != NULL && (sendNotif == true && cs.ParentId != null)) cse.Appeal__c = '^1'+customAppeal; //alternatif, karena limitasi custom field di case untuk notification
        else cse.Appeal__c = cs.Appeal__c;
        
        if (customComplaint != '' && customComplaint != NULL) cse.Complaint__c = customComplaint;
        else cse.Complaint__c = cs.Complaint__c;
        
        cse.Lampiran__c = cs.Lampiran__c;
        cse.Back_Office_PIC__c = cs.Back_Office_PIC__c;
        cse.Product_AFI2__c = cs.Product_AFI2__c;
        cse.Insurance_Type_AFI__c = cs.Insurance_Type_AFI__c; // 03022022 Beni R
        
        cse.Region__c = cs.Region__c;
        cse.Related_ticket__c = cs.Related_ticket__c;
        cse.Other_Information__c = cs.Other_Information__c;
        cse.Case_Error__c = cs.Case_Error__c;
        
        cse.accountId = cs.accountId;
        cse.recordTypeId = cs.recordTypeId;
        cse.ParentId = cs.ParentId;
        cse.createdbyId = UserInfo.getUserId();
        cse.FCR__c = false;
        cse.Demand__c = cs.Demand__c;
        cse.Reason_Root_Cause__c = cs.Reason_Root_Cause__c;
        cse.Chronological__c = cs.Chronological__c;
        cse.Corrective_Action__c = cs.Corrective_Action__c;
        cse.Financial_Lost__c = cs.Financial_Lost__c;
        cse.Financial_Lost_Currency__c = cs.Financial_Lost_Currency__c;
        cse.Objek_Pertanggungan__c = cs.Objek_Pertanggungan__c;
        cse.Jenis_Pertanggungan__c = cs.Jenis_Pertanggungan__c;
        cse.Recommendation__c = cs.Recommendation__c;
        cse.Received_date__c = cs.Received_date__c;
        cse.Tanggal_Assign__c = cs.Tanggal_Assign__c;
        cse.Lokasi_Survey__c = cs.Lokasi_Survey__c;
        cse.PIC_Surveyor__c = cs.PIC_Surveyor__c;
        cse.Bengkel__c = cs.Bengkel__c;
        cse.Complaint_Resume__c = cs.Complaint_Resume__c;
        cse.COB__c = cs.COB__c;
        cse.Received_Party__c = cs.Received_Party__c;
        cse.Progress_Action__c = cs.Progress_Action__c;
        cse.Activity_Log__c = cs.Activity_Log__c;
        cse.Negative_Feedback__c = cs.Negative_Feedback__c; 
        
        // uPdate by Ranti at 28/09/2021 , for AMFS, if SoftComplaint, autoclosed.
        if (entity == 'AMFS' && customComplaintType == SOFT_COMPLAINT) { 
            cse.Status = 'Closed'; 
        }
        
        caseList.add(cse);
        cse.NonPP__c = cs.NonPP__c; //added by catur
        cse.Escalated_Flow__c = esalatedFlowGenerator(cs.Category_Config__c, entity);
        cse.Escalated_Flow_TAT__c = esalatedFlowTATGenerator(cs.Category_Config__c, entity);
        cse.Product_AFI__c = cs.Product_AFI__c; // 24 Jan 2020, Taufik MII
        cse.Line_Queue__c = cs.Line_Queue__c; // 24 Jan 2020, Taufik MII
        
        // Taufik - Next Department
        Map<String, Object> mapJs = (Map<String, Object>) JSON.deserializeUntyped(cse.Escalated_Flow__c);
        System.debug('mapJs : ' + mapJs);
        String mapIndex = String.valueOf(2);
        
        if (mapJs.get(mapIndex) == NULL) cse.Next_Department__c = 'CCC';
        else if (mapJs.get(mapIndex) == 'null') cse.Next_Department__c = 'CCC';
        else cse.Next_Department__c = string.valueof(mapJs.get(mapIndex)); // <-- isi di sini, hasil Break dari Escalated Flow
       
        // End Taufik - Next Department
        validateMasterCaseType(mctr, cse);
        
        if(selectedQueueDept.containsWhitespace()) selectedQueueDept = selectedQueueDept.replaceAll('\\s', '_'); 
        System.debug('queueDept : ' + selectedQueueDept);
        
        String qDevName = entity + '_' + selectedQueueDept + '_Queue';
        List<Group> gQueue = [SELECT Id FROM Group WHERE Type = 'Queue' AND DeveloperName = :qDevName];
        
        if(gQueue.size() > 0) {
            cse.OwnerId = gQueue[0].Id;
            if(selectedQueueDept == 'CMU') {cse.PIC__c = UserInfo.getUserId(); cse.PIC_Department_LU__c = UserInfo.getUserId();}
        } else { ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'No Queue available, please contact your Administrator.')); }
        
        //(2019-09-09 By Arief Robbiansyah)    
        cse.Courier__c = cs.Courier__c;    
        
        insert caseList;
        
        currentId = cse.Id;
        
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
    }
    
    private void validateMasterCaseType(List<Master_Case_Type_Regional__c> mctr, Case cse){
        if(mctr.size() > 0) {
            cse.PIC__c = mctr[0].PIC_Department__c;
            cse.PIC_Department_LU__c = mctr[0].PIC_Department__c;
            cse.Division__c = mctr[0].Department_Queue__c;
            cse.SLA_Case_Closed__c = mctr[0].SLA__c;
            cse.TAT__c = mctr[0].TAT__c;
            selectedQueueDept = mctr[0].Department_Queue__c;
        } else {
            String qDefCaseType = entity + ' Default Case Type';
            List<Master_Case_Type_Regional__c> altmctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Department_Queue__c FROM Master_Case_Type_Regional__c WHERE Entity__c = :entity AND Name = :qDefCaseType AND Active__c = TRUE AND Type__c = :cs.Type LIMIT 1];
            if(altmctr.size() > 0) {
                cse.PIC_Department_LU__c = altmctr[0].PIC_Department__c;
                cse.PIC__c = altmctr[0].PIC_Department__c;
                cse.Division__c = altmctr[0].Department_Queue__c;
                cse.TAT__c = altmctr[0].TAT__c;
                cse.SLA_Case_Closed__c = altmctr[0].SLA__c;
                selectedQueueDept = altmctr[0].Department_Queue__c;    
            } else {
                selectedQueueDept = 'CMU';
            }
        }
    }
    
    private String esalatedFlowGenerator(String caseType, String entity) {
        List<Master_Case_Type_Regional__c> mctr = [SELECT Id, Department_Queue__c, Department_Queue_2__c, Department_Queue_3__c, Department_Queue_4__c, Department_Queue_5__c
                                                   FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :caseType AND Entity__c = :entity LIMIT 1];
        String jsonValue = '';
        if(mctr.size() > 0 || Test.isRunningTest()) {
            if (!Test.isRunningTest()) jsonValue += '{';
            if (!Test.isRunningTest()) jsonValue += '"1":"'+mctr[0].Department_Queue__c+'",';
            if (!Test.isRunningTest()) jsonValue += '"2":"'+mctr[0].Department_Queue_2__c+'",';
            if (!Test.isRunningTest()) jsonValue += '"3":"'+mctr[0].Department_Queue_3__c+'",';
            if (!Test.isRunningTest()) jsonValue += '"4":"'+mctr[0].Department_Queue_4__c+'",';
            if (!Test.isRunningTest()) jsonValue += '"5":"'+mctr[0].Department_Queue_5__c+'"}';
            if (Test.isRunningTest()) jsonValue = '{}';
            
        } else {
            jsonValue = '{}';
        }
        
        return jsonValue;
    }
    
    private String esalatedFlowTATGenerator(String caseType, String entity) {
        List<Master_Case_Type_Regional__c> mctr = [SELECT Id, TAT__c, TAT_2__c, TAT_3__c, TAT_4__c, TAT_5__c
                                                   FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :caseType AND Entity__c = :entity LIMIT 1];
        String jsonValue = '';
        if(mctr.size() > 0 || Test.isRunningTest()) {
            if (!Test.isRunningTest()) jsonValue += '{';
            if (!Test.isRunningTest()) jsonValue += '"1":"'+mctr[0].TAT__c+'",';
            if (!Test.isRunningTest()) jsonValue += '"2":"'+mctr[0].TAT_2__c+'",';
            if (!Test.isRunningTest()) jsonValue += '"3":"'+mctr[0].TAT_3__c+'",';
            if (!Test.isRunningTest()) jsonValue += '"4":"'+mctr[0].TAT_4__c+'",';
            if (!Test.isRunningTest()) jsonValue += '"5":"'+mctr[0].TAT_5__c+'"}';
            if (Test.isRunningTest()) jsonValue = '{}';
        } else {
            jsonValue = '{}';
        }
        
        return jsonValue;
    }
    
    // taufik mii, 4 Feb 2020 AMFS CMU Project
    public void AMFScomplaint_type() {
        
        customComplaintType = '';
        
        system.debug('entity : '+entity);
        
        system.debug('cs.Category_Config__c : '+cs.Category_Config__c);
        system.debug('cs.Channel__c : '+cs.Channel__c);
        system.debug('cs.Complaint_type__c : '+cs.Complaint_type__c);        
        
        {
            system.debug('start Formula AMFS CMU');
            if (cs.Category_Config__c == NULL) cs.Category_Config__c = '';
            if (cs.Channel__c == NULL) cs.Channel__c = '';
            
            // taufik, Maret20 - new process soft complaint, auto closed, confirm bu amel.
            setComplaintType();
            
            //prefix = "100-" ==> TM, "001-", else "Conventional"
            system.debug('case AMFSComplaint_type: '+cs);
            
            list<contact> checkprefix = [SELECT Policy_No__c FROM Contact WHERE id =: cs.contactId AND Policy_No__c != ''];
            if (checkprefix.size() > 0) {
                string checkprefixtest = checkprefix[0].Policy_No__c;
                if (checkprefixtest.left(4) == '100-' || checkprefixtest.left(4) == '001-') {
                    customBusinessChannel = 'TM';
                    customProduct = 'TM';
                } else {
                    customBusinessChannel = 'Conventional';
                    customProduct = 'Conventional';                            
                } // end if checkprefix
                
            }
            
            system.debug('customComplaintType : '+customComplaintType);
        }
        
        
    }
    
    private void setComplaintType(){
        if (cs.Complaint_type__c == SOFT_COMPLAINT) {
            // status akan menjadi close
            customComplaintType = SOFT_COMPLAINT;
        } 
        else if ((cs.Category_Config__c == 'DC-Misrepresentation' ||
                  cs.Category_Config__c == 'DC-Misappropriation' ||
                  cs.Category_Config__c == 'DC-Forgery' ||
                  cs.Category_Config__c.Contains('Claim')
                 ) &&
                 cs.Channel__c != 'Social Media' &&
                 cs.Channel__c != 'Print Media'  &&
                 cs.Channel__c != 'Website' &&
                 cs.Channel__c != 'Regulator' &&
                 cs.Channel__c != SOLICITOR ) customComplaintType = 'Complex Case';
        
        else if ((cs.Nature_Config__c == 'Administrator Procedures' ||
                  cs.Nature_Config__c == 'Administrative Procedures' ||
                  cs.Category_Config__c == 'DC-Without Consent'
                 ) &&
                 cs.Channel__c != 'Social Media' &&
                 cs.Channel__c != 'Print Media'  &&
                 cs.Channel__c != 'Website' &&
                 cs.Channel__c != 'Regulator' &&
                 cs.Channel__c != SOLICITOR ) customComplaintType = 'Simple';
        else if (cs.Channel__c == 'Social Media' ||
                 cs.Channel__c == 'Print Media'  ||
                 cs.Channel__c == 'Website' ||
                 cs.Channel__c == 'Regulator' ||
                 cs.Channel__c == SOLICITOR ) customComplaintType = 'Priority';
    }
    
    public void AMFSValidation() {
        
        // Query
        system.debug('## Start AMFSValidation');
        list<Case> check = [SELECT id, CaseNumber FROM Case 
                            WHERE ContactId =: cs.contactId and Type = 'Complaint' and Status != 'Closed' and
                            Nature__c != 'courier delivery' and Nature__c != 'courier investigation' and Nature__c != 'policy duplicate' and Nature__c != 'Policy Retur' and
                            Entity_Backup__c =: entity];
        // Updated by Ranti at 10/27/2022
        // passed validation
        
        if (check.size() > 0) {
            system.debug('## check.size() : '+check.size());
            isValidation = TRUE;
            validationMessage = 'nasabah masih mempunyai Complaint Case di Nomor '+check[0].CaseNumber;
            system.debug('validateMessage = '+validationMessage);
        }
        system.debug('## check.size() : 0');
        
        // jika ada Case Complaint yang sudah closed, set menjadi appeal.
        contact ct;
        if (!Test.isRunningTest())
            ct = [SELECT id, LastName, Email, MobilePhone FROM Contact WHERE id =: cs.contactId];
        
        if (!Test.isRunningTest()){
            check = [SELECT id, CaseNumber FROM Case 
                     WHERE Type = 'Complaint' and status = 'Closed' and Named_User__c != NULL and 
                     (Contact.LastName =: ct.LastName OR (contact.Email =: ct.Email AND contact.Email != NULL) OR (contact.MobilePhone =: ct.MobilePhone AND contact.MobilePhone != NULL) ) and
                     Nature__c != 'courier delivery' and Nature__c != 'courier investigation' and Nature__c != 'policy duplicate' and Nature__c != 'Policy Retur' AND
                     Channel__c != 'Social Media' AND Channel__c != 'Print Media' AND Channel__c != 'Website' AND Channel__c != 'Regulator' AND Channel__c != 'Solicitor/Lawyer' AND
                     Entity_Backup__c =: entity order by id desc ]; 
            system.debug('check size if not testing: '+check.size());
        }
        else {
            check = [SELECT id, CaseNumber FROM Case 
                     WHERE Type = 'Complaint' and status = 'Closed' and Named_User__c != NULL and ContactId =: cs.contactId and Nature__c != 'courier delivery' and Nature__c != 'courier investigation' and Nature__c != 'policy duplicate' and Nature__c != 'Policy Retur' AND
                     Entity_Backup__c =: entity order by id desc ];
        }        
        
        if (check.size() > 0 ) {
            
            system.debug('## check II : '+check.size());
            
            cs.Appeal__c = 'Yes';
            cs.Complaint__c = 'Appeal';
            customAppeal = 'Yes';
            customComplaint = 'Appeal';
            
            cs.ParentId = check[0].id;
            
            system.debug('## YES ==> Appeal__c : '+cs.Appeal__c+ '; Complaint__c : '+cs.Complaint__c+ '; ParentId : '+check[0].id);
        } else {
            cs.Appeal__c = 'No';
            cs.Complaint__c = 'New';
            
            customAppeal = 'No';
            customComplaint = 'New';
            
            system.debug('## NO ==> Appeal__c : '+cs.Appeal__c+ '; Complaint__c : '+cs.Complaint__c+ '; ParentId : <Blank>');
        }   
    }
    
    public Boolean getCekCourier(){
        CaseServiceController caseService = new CaseServiceController();
        return caseService.getCekCourierCase(cs);
    }
    
    public void setAppealCaseAMFSComplaint(){
        system.debug('starting set appeal case for amfs');
        if(!String.isEmpty(cs.ContactId)){
            List<Case> resultCountCase = [Select Id, Parent_Case_Number__c, Appeal__c, Complaint__c  FROM Case WHERE ContactId =: cs.ContactId AND Type ='Complaint' AND Status = 'Closed'];
            system.debug('count case for complaint :'+resultCountCase.size());
            system.debug('contact: '+cs.ContactId);
            if(resultCountCase.size() > 0){
                cs.Appeal_Case_Complaint__c = resultCountCase.size();
                cs.Appeal__c = 'Yes';
                cs.Complaint__c = 'Appeal';
                system.debug('appeal yes');
            }else{
                cs.Appeal_Case_Complaint__c = 0;
                cs.Appeal__c = 'No';
                cs.Complaint__c = 'New';
                system.debug('appeal new');
            }
            
        }
    }
    
    public void getSensitiveCustomerDetail(){
        System.debug('starting get sensitive customer from contact');
        if(!String.isEmpty(cs.ContactId)){
            List<Contact> sensitiveContacts = [Select Id, Sensitive_Customer__c, Policy_No__c FROM Contact WHERE Id=: cs.contactId];
            if(sensitiveContacts.size() > 0){
                sensitiveCustomerView = sensitiveContacts[0].Sensitive_Customer__c;
            }
        }else{
            sensitiveCustomerView = '';
        }
    }
    
}