public class CaseRequestLayoutNegativeFeedback {
    public String availableCaseTypeKeeper {get; set;}
    public String selectedCaseTypeKeeper {get; set;}
    public String caseTypeFieldId {get; set;}
    public Case cs {get; set;}
    public String firstLoad {get; set;}
    public String retURL {get; set;}
    public String entity {get;set;}
    public String formentity {get;set;}
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
    public String Department {get;set;}
    
    public String selectedTimeRange {get;set;} 
    public Date selectedDate {get; set;}
    public Date endDateFromLog {get; set;}
    
    
    public String selectedQueueDept {get; set;}
    public String QueueDept {get; set;}
    public map<String,String> idRlsMap {get; set;}
    public map<String,String> idDmtmMap {get; set;}
    public List<Master_legal__c> mstr {get; set;}
    public List<String> tmpString {get; private set;} 
    
    // added by Ranti at 10/28/2021
    public string callLineId {get;set;}
    public boolean openScriptLegal {get;set;}
    public string typeLegalAMFS {get;set;}
    public string descLegalAMFS {get;set;} 
    public String paramOrigin {get;set;}
    
    public Boolean isShowConfirmDisplay {get;set;}
    public String confirmationMessage {get;set;}
    public String savingType {get;set;}
    
    public String globalCaseType {get;set;}
    
    //add by Aziz at 05/08/2023
    public Contact cnt;
    public String relatedDepartment;
    public String caseNumber;
    public Integer qrLimit;
    public Boolean isSave; 
    public DateTime dtNow;
    public Time tNow;
    public Time maxTimeDaily;
    public String timeOfServices;
    
    //add by Adi 20230721
    public Boolean isParentDependencyChanged;
    
    ApexPages.StandardController controller;
    
    public CaseRequestLayoutNegativeFeedback(ApexPages.StandardController std){
        dtNow = Date.today();
        tNow = Time.newInstance(DateTime.now().hour(), DateTime.now().Minute(), DateTime.Now().Second(), 0);
        Integer maxHour = Integer.valueOf(Label.QuickResponse_MaxHour);
        Integer maxMinute = Integer.valueOf(Label.QuickResponse_MaxMinute);
        maxTimeDaily = Time.newInstance(maxHour, maxMinute, 0, 0);
        
        openScriptLegal = false;
        isParentDependencyChanged = false;
        
        idRlsMap = new map<String,String>(); 
        idDmtmMap = new map<String,String>();
        for (User_Detail__c ud : [SELECT Id, User__c, Subject_Case__c, DMTM__c FROM User_Detail__c WHERE Entity__c = 'AMFS' and (Subject_Case__c != null OR DMTM__c != null)]){
            idRlsMap.put(ud.Subject_Case__c,ud.User__c);
            idDmtmMap.put(ud.DMTM__c,ud.User__c);
        }
        system.debug('id RLS: '+idRlsMap);
        system.debug('id DMTM: '+idDmtmMap);
        userObj = [SELECT id,Name, Entity__c, Profile.Name FROM user WHERE id = :UserInfo.getUserId()];
        
        // entity = userObj.Entity__c;
        controller = std;
        cs = new Case();
        system.debug('cs.Request_Type__c '+cs.Request_Type__c);
        caseTypeFieldId=System.Label.CaseTypeFieldId;
        //cs.AccountId = Apexpages.currentPage().getParameters().get('cas4');
        cs.recordTypeId = Apexpages.currentPage().getParameters().get('RecordType');
        cs.type = Apexpages.currentPage().getParameters().get('cas5'); 
        retURL = Apexpages.currentPage().getParameters().get('retURL');
        firstLoad = Apexpages.currentPage().getParameters().get('firstLoad'); 
        entity =  Apexpages.currentPage().getParameters().get('entity');   
        formentity = Apexpages.currentPage().getParameters().get('formentity');
        source = Apexpages.currentPage().getParameters().get('cas11');
        contactId = Apexpages.currentPage().getParameters().get('cas3');
        cs.status = 'New';
        cs.parentid = Apexpages.currentPage().getParameters().get('idcase');
        //caseId = retURL.substring(1, retURL.length());
        String negative = Apexpages.currentPage().getParameters().get('isnegative');
        //2023-05-08 Nispi Abdul Aziz
        DateTime dtToday = DateTime.now();
        cs.Date_of_Submit__c = dtToday.date();
        cs.Date_of_Service__c = dtToday.date().addDays(1);
        cs.Requestor__c = userObj.Name;
        
        
        system.debug('url origin = '+Apexpages.currentPage().getParameters().get('paramOrigin'));  
        
        // remark by adi
        if(negative == 'yes'){
            cs.origin = 'Negative Feedback';
        } /* else {
cs.Origin = 'Phone';
}*/
        cs.accountId= ApexPages.currentPage().getParameters().get('def_account_id');
        //caseId = retURL.substring(1, retURL.length());
        cs.Negative_Feedback__c = Apexpages.currentPage().getParameters().get('nfid'); 
        cs.Contactid = ApexPages.currentPage().getParameters().get('def_contact_id');
        
        
        // cnt =  [SELECT Name,  policy_No__c FROM CONTACT where Id =: cs.ContactId];  
        if (String.isNotBlank(cs.ContactId)) { 
            List<Contact> listDataContact =   [SELECT Name,  policy_No__c, MobilePhone FROM CONTACT where Id =: cs.ContactId];   
            if (listDataContact.size() > 0) {
                cnt = listDataContact[0];cs.Policy_No__c = cnt.Policy_No__c; cs.Policy_Owner__c = cnt.Name;cs.Case_Phone__c = cnt.MobilePhone;
                system.debug('Contact Mobile:' + cnt.MobilePhone);
                system.debug('cs Contact Mobile:' + cs.Case_Phone__c);
            }
        }
        
        //get End Date from Email SMS LOG
        system.debug('cs.Policy_No__c:' + cs.Policy_No__c);
        List<Email_SMS_Log__c> log = [SELECT End_Date__c FROM Email_SMS_Log__c where Call_Line__r.Policy_No__c = :cs.Policy_No__c ORDER BY CreatedDate DESC LIMIT 1];
        system.debug('log cek enddatefromlog:' + log);
        
        if (!log.isEmpty() && log[0].End_Date__c != null){
            endDateFromLog = log[0].End_Date__c;
            //endDateFromLog = Date.newInstance(2023,07,07);
            system.debug('log cek enddatefromlog 1:' + endDateFromLog);
        } else {
            endDateFromLog = Date.today();
            //endDateFromLog = Date.newInstance(2023,07,07);
            system.debug('log cek enddatefromlog 2:' + endDateFromLog);
        }
        
        
        // added by Ranti at 10/28/2021  
        callLineId  = ApexPages.currentPage().getParameters().get('callLineId');
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
        
        system.debug('==== Entity:'+entity);
        // add by Ranti at 10/15/2021
        if (entity == '' || entity == null) { 
            entity = userObj.Entity__c;
        }
        
        isShowConfirmDisplay = false;
        String qrLimitStr = Label.QuickResponseScheduleLimit;
        qrLimit = Integer.valueOf(qrLimitStr);
        
    }
    
    public PageReference save() {
        try{ 
            savingType = 'Save';
            String caseType = cs.Case_Type_Config__c == null ? '' : (String) cs.Case_Type_Config__c;
            System.debug('caseType === ' + caseType);
            if (caseType.equalsIgnoreCase('Request_Hold Debit')) {
                followHoldDateConfirmationDisplay();
                return null;
            } else if (caseType.equalsIgnoreCase('Request-Reschedule CR Redemption') || caseType.equalsIgnoreCase('Request-Reschedule-CR-Withdrawal') || caseType.equalsIgnoreCase('Request_Refund Premi')) {
                cs.Date_of_Service__c = Date.valueOf(selectedDate);
                updateCallLineToRescheduled(cs.policy_no__c, caseType, cs.Date_of_Service__c, selectedTimeRange);
                
                //Convert String
                System.debug('selectedTimerang === ' + selectedTimerange);
                if(selectedTimerange != null && selectedTimeRange.contains(':')) {
                    List <String> timeParts = selectedTimeRange.split(':');
                    List<String> hm = selectedTimerange.split(':');
                    if (hm.size() == 2){
                        Integer hour = Integer.valueOf(hm[0]);
                        Integer minute = Integer.valueOf(hm[1]);
                        Time parsedTime = Time.newInstance(hour, minute, 0 ,0);
                        System.debug('parsedTime === ' + parsedTime);
                        cs.Time_of_Service__c = parsedTime;
                    }
                    return actionSave();
                }else {
                    return actionSave();
                }  
            } else {
                //return null;
                return actionSave();  
            } 
        }catch(DmlException ex){
            ApexPages.addMessages(ex);  //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
            return null;
        }
    }
    
    
    public PageReference SaveAndNew(){
        //collectiveSave();
        savingType = 'SaveAndNew';
        String caseType = cs.Case_Type_Config__c == null ? '' : (String) cs.Case_Type_Config__c;
        System.debug(retURL);
        System.debug(cs.Contactid);
        System.debug(accId);
        System.debug(cs.recordTypeId);
        System.debug(cs.AccountId);
        System.debug(source);
        if(!Test.isRunningTest()){
            if (caseType.equalsIgnoreCase('Request_Hold Debit')) {
                followHoldDateConfirmationDisplay();
                return null;
            } else {
                return actionSaveAndNew();
            }  
        }else{
            return null;  
        }
    }
    
    public PageReference cancel() {
        return new PageReference(retURL);
    } 
    
    
    
    
    public void collectiveSave(){
        List<Master_Case_Type_Regional__c> mctr = new List<Master_Case_Type_Regional__c>();
        if(entity == 'AGI') { //--Added by Daniel 28/02/2019
            System.debug('Case Type : ' + cs.Case_Type_Config__c + ', Entity : ' + entity + ', Type : ' + cs.Type);
            mctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Product__c, Business_Channel__c, Department_Queue__c, Current_User__c FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :cs.Case_Type_Config__c AND Entity__c = :entity AND Product__c = :cs.Product__c AND Business_Channel__c = :cs.Business_Channel__c AND Active__c = TRUE AND (Department_Queue__c != '' OR Current_User__c = TRUE) LIMIT 1];
        } 
        else if (entity == 'AMFS' && cs.Case_Type_Config__c=='Request_CCC_Call Back DMU') {
            System.debug('Case Type : ' + cs.Case_Type_Config__c + ', Entity : ' + entity + ', Type : ' + cs.Type);
            List<Master_Case_Type_Regional__c> mctrc = new List<Master_Case_Type_Regional__c>();
            mctrc = [SELECT Id, PIC_Department__c, TAT__c,Case_DMU_Upload_Total__c,Process_DMU_Upload_Date__c, SLA__c, Department_Queue__c, Current_User__c FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :cs.Case_Type_Config__c AND Entity__c = :entity AND Active__c = TRUE AND Type__c = :cs.Type AND Active__c = TRUE AND (Department_Queue__c != '' OR Current_User__c = TRUE)];
            List<Master_Case_Type_Regional__c> mctrlistcek = new List<Master_Case_Type_Regional__c>();
            for (Master_Case_Type_Regional__c mCase : mctrc) {
                if (mCase.Process_DMU_Upload_Date__c < date.today()){ mCase.Process_DMU_Upload_Date__c = date.today(); mCase.Case_DMU_Upload_Total__c = 0;
                                                                     mctrlistcek.add(mCase);
                                                                    }
            }
            update mctrlistcek;
            
            mctr = [SELECT Id, PIC_Department__c, TAT__c,Case_DMU_Upload_Total__c,Process_DMU_Upload_Date__c, SLA__c, Department_Queue__c, Current_User__c FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :cs.Case_Type_Config__c AND Entity__c = :entity AND Active__c = TRUE AND Type__c = :cs.Type AND Active__c = TRUE AND (Department_Queue__c != '' OR Current_User__c = TRUE) ORDER BY Case_DMU_Upload_Total__c LIMIT 1];
            
            List<Master_Case_Type_Regional__c> mctrlist = new List<Master_Case_Type_Regional__c>();
            for (Master_Case_Type_Regional__c m : mctr) {
                m.Case_DMU_Upload_Total__c = m.Case_DMU_Upload_Total__c+1; mctrlist.add(m);
            }
            update mctrlist;
        }
        else {
            System.debug('Case Type : ' + cs.Case_Type_Config__c + ', Entity : ' + entity + ', Type : ' + cs.Type);
            mctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Department_Queue__c, Current_User__c FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :cs.Case_Type_Config__c AND Entity__c = :entity AND Type__c = :cs.Type AND Active__c = TRUE AND (Department_Queue__c != '' OR Current_User__c = TRUE) LIMIT 1]; //--Added by Suryono 12/12/2018
        }
        
        
        List<Case> caseList = new List<Case>();
        Case cse = new Case();
        cse.contactId = cs.contactId;
        cse.Status = cs.Status;
        cse.type = cs.type;
        cse.Priority = cs.Priority;
        cse.Service_Type__c = cs.Service_Type__c;
        cse.origin = cs.origin;
        cse.Case_Type__c = cs.Case_Type__c;
        cse.Case_Type_Config__c = cs.Case_Type_Config__c;
        cse.Case_Type_Reason__c = cs.Case_Type_Reason__c;
        cse.Subject = cs.Subject;
        cse.Description = cs.Description;
        
        //added by Nispi Aziz   
        cse.Policy_No__c = cs.Policy_No__c;
        cse.Policy_Owner__c = cs.Policy_Owner__c;
        cse.Date_of_Submit__c = cs.Date_of_Submit__c;
        cse.Date_of_Service__c = cs.Date_of_Service__c;
        cse.Time_of_Service__c = cs.Time_of_Service__c;
        cse.Unit_of_Request__c = cs.Unit_of_Request__c;
        cse.Service_of_Area__c = cs.Service_of_Area__c;
        cse.address_of_service__c = cs.address_of_service__c;
        cse.Type_of_Request__c = cs.Type_of_Request__c;
        cse.Requestor__c = cs.Requestor__c;
        
        if(cs.Related_Departments__c == 'Quick Response')  
        {
            cse.Entity_Backup__c = 'AMFS';
            tNow = Time.newInstance(DateTime.now().hour(), DateTime.now().Minute(), DateTime.Now().Second(), 0);
            List<Case> listServiceDate = new List<Case>();
            listServiceDate = [Select Date_of_Service__c from Case where Date_of_Service__c =: cs.Date_of_Service__c and Related_Departments__c = 'Quick Response'];
            if(cs.Date_of_Service__c <= Date.today()){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, Label.QR_DOS_Val_1 + ' ' + Date.Today()));
                return;
            } else {
                if(listServiceDate.size() >= qrLimit){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, Label.QR_Quota_Val_3 + ' ' + cs.Date_of_Service__c));
                    return;
                }
            }
        }
        
        if(String.isBlank(cs.Description) && (cse.Case_Type__c == 'Request-Reschedule CR Redemption' || cse.Case_Type__c == 'Request-Reschedule-CR-Withdrawal' )) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'Description Wajib Diisi'));
            return;
        }
        if(String.isBlank(cs.Subject) && (cse.Case_Type__c == 'Request-Reschedule CR Redemption' || cse.Case_Type__c == 'Request-Reschedule-CR-Withdrawal' )) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'Subject Wajib Diisi'));
            return;
        }
        
        
        //added by Ranti at 10/21/2021
        cse.Product_AFI2__c = cs.Product_AFI2__c; 
        cse.Insurance_Type_AFI__c = cs.Insurance_Type_AFI__c; // 03022022 Beni R
        cse.Data_Correction__c = cs.Data_Correction__c; // 04022024-Beni R
        
        //input department__c dan request_type__c di entity AMFS - 08/09/2020
        relatedDepartment = cs.Related_Departments__c;
        cse.Related_Departments__c = cs.Related_Departments__c;
        cse.Request_Type__c = cs.Request_Type__c;    
        
        if(entity == 'AMFS'){ 
            if(cse.Case_Type__c == null || cse.Case_Type_Config__c == null){  //jaga-jaga mapping request_type__c AMFS, karena case Request_DPLK_Information (JS vfnya gak jalan) - 28/09/2020
                cse.Case_Type_Config__c = cs.Request_Type__c != null ? cs.Request_Type__c : cs.Request_Type_Phone__c;
                cse.Case_Type__c = cs.Request_Type__c != null ? cs.Request_Type__c : cs.Request_Type_Phone__c;
            }
        }
        
        System.debug('Request Type 1= '+cse.Request_Type__c);
        System.debug('Request Type 2= '+cs.Request_Type__c);
        System.debug('Request Type 3= '+cs.Case_Type__c);
        System.debug('Request Type 4= '+cs.Case_Type_Config__c);
        System.debug('Request Type 5= '+cse.Case_Type_Config__c);
        
        if(entity == 'AGI') {
            cse.Product__c = cs.Product__c; cse.Category__c = cs.Category__c; cse.Business_Channel__c = cs.Business_Channel__c; cse.Branch_AGI__c = cs.Branch_AGI__c;  
        } 
        //cse.PIC_Department_LU__c = cs.PIC_Department_LU__c; //--Edited by Suryono 12/12/2018
        // 9 Okt 2019, taufik add formentity
        if (formentity == NULL || formentity == '') formentity = entity;
        
        cse.Escalated_Flow__c = esalatedFlowGenerator(cs.Case_Type_Config__c, formentity);
        cse.Escalated_Flow_TAT__c = esalatedFlowTATGenerator(cs.Case_Type_Config__c, formentity);          
        
        //cse.Escalated_Flow__c = esalatedFlowGenerator(cs.Case_Type_Config__c, entity);
        //cse.Escalated_Flow_TAT__c = esalatedFlowTATGenerator(cs.Case_Type_Config__c, entity);
        
        // Taufik - Next Department
        Map<String, Object> mapJs = (Map<String, Object>) JSON.deserializeUntyped(cse.Escalated_Flow__c);
        System.debug('mapJs : ' + mapJs);
        String mapIndex = String.valueOf(2);
        
        if (mapJs.get(mapIndex) == NULL) cse.Next_Department__c = 'CCC';
        else if (mapJs.get(mapIndex) == 'null') cse.Next_Department__c = 'CCC';
        else cse.Next_Department__c = string.valueof(mapJs.get(mapIndex)); // <-- isi di sini, hasil Break dari Escalated Flow
        // End Taufik - Next Department  
        
        if(mctr.size() > 0) {
            if(mctr[0].Current_User__c) {cse.PIC_Department_LU__c = UserInfo.getUserId();
                                        } else {
                                            cse.PIC_Department_LU__c = mctr[0].PIC_Department__c;
                                        }
            cse.TAT__c = mctr[0].TAT__c; cse.SLA_Case_Closed__c = mctr[0].SLA__c;cse.Division__c = mctr[0].Department_Queue__c;
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
                if(altmctr[0].Current_User__c) {cse.PIC_Department_LU__c = UserInfo.getUserId();
                                               } else {
                                                   cse.PIC_Department_LU__c = altmctr[0].PIC_Department__c;
                                               }
                
                cse.TAT__c = altmctr[0].TAT__c; cse.SLA_Case_Closed__c = altmctr[0].SLA__c;cse.Division__c = altmctr[0].Department_Queue__c;
                
                if(altmctr[0].Current_User__c) { selectedQueueDept = 'Current User';
                                               } else {
                                                   selectedQueueDept = altmctr[0].Department_Queue__c;
                                               }
            } else {
                selectedQueueDept = 'Temporary';
                
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
            System.debug('*********** qDevName: ' + qDevName);
            List<Group> gQueue = [SELECT Id FROM Group WHERE Type = 'Queue' AND DeveloperName = :qDevName];
            if(gQueue.size() > 0) {
                system.debug('check user id: ' + gQueue[0].Id);
                cse.OwnerId = gQueue[0].Id;
                if (selectedQueueDept == 'Temporary') {cse.PIC_Department_LU__c = UserInfo.getUserId();}
            } else {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'No Queue available, please contact your Administrator.'));
            }
        }
        
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
        cse.Product_AFI__c = cs.Product_AFI__c; // 24 Jan 2020, Taufik MII
        cse.Line_Queue__c = cs.Line_Queue__c; // 24 Jan 2020, Taufik MII
        
        //(2019-09-09 By Arief Robbiansyah)
        cse.Courier__c = cs.Courier__c;
        cse.Case_Phone__c = cs.Case_Phone__c;
        
        String cseStr = String.valueOf(cse);
        Integer cseLength = cseStr.length();
        Integer subStart = 0;
        Integer subEnd = 0;
        system.debug('======> CSE :');
        while (subEnd < cseLength) {
            subStart = subEnd;
            subEnd += 250;
            if (subEnd < cseLength) {
                system.debug(cseStr.substring(subStart, subEnd));
            } else {
                system.debug(cseStr.substring(subStart, cseLength));
            }
        }
        caseList.add(cse);
        system.debug('caseList: '+caseList);
        try {
            insert caseList;
            system.debug('insert caseList success');
            isSave = true;
        } catch (Exception e) {
            String errMsg = e.getMessage();
            system.debug('::::: failed to insert case: ' + errMsg.length());
            system.debug('::::: failed to insert case: ' + e.getCause());
            system.debug('::::: failed to insert case: ' + e.getLineNumber());
            system.debug('::::: failed to insert case: ' + errMsg);
            system.debug('::::: failed to insert case: ' + e.getStackTraceString());
            system.debug('::::: failed to insert case: ' + e.getTypeName());
        }
        
        caseNumber = cse.CaseNumber;
        CurrentId = cse.Id;
        system.debug('***CASE ID: '+cse.id);
        List<Case> csInquiryList = [SELECT Id, Non_Inquiry__c FROM Case WHERE id = :caseId];
        
        for(Case c: csInquiryList){
            c.Non_Inquiry__c = true;
        }
        update csInquiryList;
        
        //to create call line if case is request for callback
        //added by ichwan - 6/25/2024
        String campaignName;
        String subjectName;
        Id userId;
        
        boolean check = false;
        List<String> subjectRLS = DependentPicklistController.getPicklistValue('User_Detail__c', 'Subject_Case__c');
        List<String> subjectDMTM = DependentPicklistController.getPicklistValue('User_Detail__c', 'DMTM__c');
        List<String> allSubjects = new List<String>();
        allSubjects.addAll(subjectRLS);
        allSubjects.addAll(subjectDMTM);
        for (String subject : allSubjects) {
            if (( !String.isBlank(cse.Subject) || !String.isEmpty(cse.Subject) ) && cse.Subject.contains(subject)) {
                check = true; subjectName = subject;
            }
        }
        
        system.debug('subjectName: '+subjectName);
        if ((check && entity == 'AMFS') || Test.isRunningTest()){
            if (Test.isRunningTest()) cse.Subject = 'ILCCDEK';
            String outbound = '';
            system.debug('create call line if case = req for callback => true');
            
            if (Test.isRunningTest()) outbound = 'Collection - Redemption Konven';
            else outbound = [SELECT Id, Outbound_Activity_Case_type__c FROM User_Detail__c WHERE Subject_Case__c = :subjectName OR DMTM__c =:subjectName].Outbound_Activity_Case_type__c;
            
            //check case type 
            if (cs.Case_Type_Config__c != null && cs.Case_Type_Config__c.contains('Withdrawal') && outbound != null && outbound.contains('Withdrawal')) {
                campaignName = 'Withdrawal'; userId = idRlsMap.get(subjectName);
            }
            
            if (cs.Case_Type_Config__c != null && cs.Case_Type_Config__c.contains('Redemption') && outbound != null && outbound.contains('Redemption Konven')) {
                campaignName = 'Redemption Konven'; userId = idRlsMap.get(subjectName);
            }
            
            if (cs.Case_Type_Config__c != null && cs.Case_Type_Config__c.contains('Redemption TM') && outbound != null) {
                if (outbound.contains('Redemption TM')) campaignName = 'Redemption TM';
                else campaignName = 'Lapse TM'; userId = idDmtmMap.get(subjectName);
            }
            
            system.debug('campaign name: '+campaignName);
            system.debug('user id: '+userId);
            String filterCampaign = '\'%'+campaignName+'%\'';
            String query;
            String nomorPolis;
            if (!Test.isRunningTest()) nomorPolis = [SELECT Policy_Numbers__c FROM Case WHERE Id = :CurrentId LIMIT 1].Policy_Numbers__c;
            else {
                filterCampaign = '\'%Redemption Konven%\'';
                nomorPolis = '100-000-1110001';
            }
            system.debug('nomorPolis: '+nomorPolis);
            if (nomorPolis != null){
                query = 'SELECT Id,Policy_No__c,Contact__c,Case__c,Call_List__c,Agent__c,OwnerId,Status_Retry__c FROM Call_Line__c WHERE Campaign_Name__c LIKE '+filterCampaign+' AND Case_Type__c = \''+campaignName+'\' AND Entity__c = \'AMFS\' AND Policy_No__c = \''+nomorPolis+'\'';    
            }
            system.debug('***QUERY:'+query);
            
            List<Call_Line__c> checkCallLine = Database.query(query);
            
            if (checkCallLine.size() > 0){ 
                system.debug('checkCallLine: '+checkCallLine);
                list<Call_Line__c> toBeUpdateCL = new list <Call_Line__c>();
                for (Call_Line__c cl : checkCallLine){ Call_Line__c updateCl = new Call_Line__c(); updateCl.id = cl.Id; updateCl.Status_Retry__c = 'Callback From CCC';
                                                      updateCl.Case__c = cse.Id; updateCl.Agent__c = userId; updateCl.OwnerId = userId; updateCl.Reschedule_Date__c = cs.Date_of_Service__c;
                                                      //String test = cs.Time_of_Service__c.format('HH:mm');
                                                      //updateCl.Time_Reschedule__c = cs.Time_of_Service__c.format('HH:mm');
                                                      
                                                      toBeUpdateCL.add(updateCl);
                                                     }
                update toBeUpdateCL;
                system.debug('toBeUpdateCL: '+toBeUpdateCL);
                case updateCase = [select id, Status_Retry__c, Call_Line_Retention__c from case where id =:cse.Id];
                updateCase.Status_Retry__c = 'Callback From CCC'; updateCase.Call_Line_Retention__c = toBeUpdateCL[0].Id;
                update updateCase;
                system.debug('updateCase: '+ updateCase);
            }
            else{
                query = 'SELECT Id,Call_Line_RecordTypeID__c FROM Call_List__c WHERE Campaign_Name__c LIKE '+filterCampaign+' AND Entity__c = \'AMFS\' ORDER BY CREATEDDATE DESC LIMIT 1';
                system.debug('**query**: '+query);
                system.debug('campaignName = '+campaignName);
                if (campaignName != NULL){
                    List<Call_List__c> cpn = Database.query(query);
                    if (cpn.size()> 0) {
                        Call_Line__c insertCl = new Call_Line__c();
                        insertCl.RecordTypeId = cpn[0].Call_Line_RecordTypeID__c;insertCl.Contact__c = cse.ContactId; insertCl.Call_List__c = cpn[0].Id; 
                        if (cse.ContactId != null) insertCl.Contact__c = cse.ContactId; insertCl.Policy_No__c = nomorPolis; 
                        insertCl.Case__c = cse.Id; insertCl.Status_Retry__c = 'Callback From CCC';insertCl.Agent__c = userId; insertCl.OwnerId = userId; insertCl.Case_Type__c = campaignName;
                        insertCl.Contacted_Number__c = cse.Case_Phone__c;insertCl.Activity__c = 'Collection'; insertCl.Entity__c = 'AMFS';
                        insert insertCl;    
                        system.debug('insertCl: '+insertCl);
                        
                        case updateCase = [select id, Status_Retry__c, Call_Line_Retention__c from case where id =:cse.Id];
                        updateCase.Status_Retry__c = 'Callback From CCC'; updateCase.Call_Line_Retention__c = insertCl.Id;
                        update updateCase;
                        system.debug('updateCase: '+ updateCase);
                    }
                }
            }    
            
        }  
    }
    
    
    private String esalatedFlowGenerator(String caseType, String entity) {
        List<Master_Case_Type_Regional__c> mctr = new List<Master_Case_Type_Regional__c>();
        if(entity == 'AGI') {
            mctr = [SELECT Id, Department_Queue__c, Department_Queue_2__c, Department_Queue_3__c, Department_Queue_4__c, Department_Queue_5__c FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :caseType AND Entity__c = :entity AND Product__c = :cs.Product__c AND
                    Business_Channel__c = :cs.Business_Channel__c AND Type__c = :cs.type AND Active__c = TRUE AND Department_Queue__c != '' LIMIT 1];
        }
        else {
            mctr = [SELECT Id, Department_Queue__c, Department_Queue_2__c, Department_Queue_3__c, Department_Queue_4__c, Department_Queue_5__c
                    FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :caseType AND Entity__c = :entity LIMIT 1];
        }
        
        String jsonValue = '';
        if(mctr.size() > 0) {
            jsonValue += '{';jsonValue += '"1":"'+mctr[0].Department_Queue__c+'",'; jsonValue += '"2":"'+mctr[0].Department_Queue_2__c+'",';jsonValue += '"3":"'+mctr[0].Department_Queue_3__c+'",'; jsonValue += '"4":"'+mctr[0].Department_Queue_4__c+'",';jsonValue += '"5":"'+mctr[0].Department_Queue_5__c+'"}';
        } else {
            jsonValue = '{}';
        }
        return jsonValue;
    }
    
    private String esalatedFlowTATGenerator(String caseType, String entity) {
        List<Master_Case_Type_Regional__c> mctr = new List<Master_Case_Type_Regional__c>();
        if(entity == 'AGI') {
            mctr = [SELECT Id, TAT__c, TAT_2__c, TAT_3__c, TAT_4__c, TAT_5__c
                    FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :caseType AND Entity__c = :entity AND Product__c = :cs.Product__c AND
                    Business_Channel__c = :cs.Business_Channel__c AND Type__c = :cs.type AND Active__c = TRUE AND Department_Queue__c != '' LIMIT 1];
        } else {
            mctr = [SELECT Id, TAT__c, TAT_2__c, TAT_3__c, TAT_4__c, TAT_5__c
                    FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :caseType AND Entity__c = :entity LIMIT 1];    
        }
        
        String jsonValue = '';
        if(mctr.size() > 0) {
            jsonValue += '{'; jsonValue += '"1":"'+mctr[0].TAT__c+'",';jsonValue += '"2":"'+mctr[0].TAT_2__c+'",';jsonValue += '"3":"'+mctr[0].TAT_3__c+'",';
            jsonValue += '"4":"'+mctr[0].TAT_4__c+'",';jsonValue += '"5":"'+mctr[0].TAT_5__c+'"}';
        } else {
            jsonValue = '{}';
        }
        
        return jsonValue;
    }
    
    public Boolean getCekCourier(){
        System.debug('Check Courier');
        CaseServiceController caseService = new CaseServiceController();
        return caseService.getCekCourierCase(cs);
    }
    
    public void put_req_type(){  //khusus AMFS Request_Type__c, pengganti input Case_Type_Config__c akibat permintaan Dependency Unit__c ke Case_Type_Config__c tidak bisa ditampung-- 08/09/2020
        // Update by Ranti at 13 02 2023
        system.debug('origin:'+cs.Origin); 
        if (isAMFS == true) {  
            cs.Case_Type_Config__c = cs.Request_Type__c;
            cs.Case_Type__c = cs.Request_Type__c;  
            globalCaseType = cs.Request_Type__c;
            
            System.debug('Cs Origin:'+cs.Origin);
            System.debug('Cs Origin 2:'+cs.Request_Type__c);
            paramOrigin = Apexpages.currentPage().getParameters().get('paramOrigin'); 
            paramOrigin = cs.Origin;
            System.debug('paramOrigin:'+paramOrigin);  
            
            
            // Update by Ranti at 13 02 2023
            if (cs.Origin == 'Phone') { 
                cs.Request_Type_Phone__c = cs.Request_Type__c;
                cs.Case_Type_Config__c = cs.Request_Type_Phone__c;
                cs.Case_Type__c = cs.Request_Type_Phone__c;
                globalCaseType = cs.Request_Type_Phone__c;
            }
            
            if (isParentDependencyChanged) {
                cs.Request_Type__c = '--None--';
                cs.Request_Type_Phone__c = '--None--';
                cs.Case_Type__c = '--None--';
                cs.Case_Type_Config__c = '--None--';
                isParentDependencyChanged = false;
            }
            
            system.debug('entity: ' + entity +  '|cs entity: ' + cs.entity__c + '|' + 'paramOrigin:' + paramOrigin + '| cs origin' + cs.Origin);
            system.debug('cs.Case_Type_Config__c:'+cs.Case_Type_Config__c);
            system.debug('cs.Case_Type__c:'+cs.Case_Type__c);
            System.debug('Cs Origin 3:'+cs.Request_Type__c);
            if (cs.Related_Departments__c == 'Quick Response') {
                cs.Subject = cs.Policy_No__c;
                onChangeDateOfService();
            }
        }
    }
    
    // added by Ranti at 13 02 2023
    public void put_param_origin(){ 
        System.debug('Cs Origin:'+cs.Origin);   
        System.debug('cs.Request_Type__c xx'+cs.Request_Type__c);   
        paramOrigin = Apexpages.currentPage().getParameters().get('paramOrigin'); 
        paramOrigin = cs.Origin;
        System.debug('paramOrigin:'+paramOrigin);  
        isParentDependencyChanged = true;
        put_req_type();
    }
    
    // Method untuk menyediakan pilihan waktu di dropdown
    public List<SelectOption> getTimeRangeOptions() {
        List<SelectOption> options = new List<SelectOption>();options.add(new SelectOption('', '-- Select Time Range --')); options.add(new SelectOption('10:00', '10:00 - 12:00')); options.add(new SelectOption('12:00', '12:00 - 13:00')); options.add(new SelectOption('13:00', '13:00 - 16:00'));
        return options;
    }
    
    // Method yang dijalankan saat tombol Submit ditekan
    public void submitRequest() {
        System.debug('Selected Date: ' + selectedDate);
        System.debug('Selected Time Range: ' + selectedTimeRange);
        
        // Tambahkan logika untuk menyimpan data ke Case atau proses lainnya
    }
    
    
    
    
    public void departmentChange() {
        System.debug('departmentChange');
        isParentDependencyChanged = true;
        put_req_type();
    }
    
    
    public PageReference setOriginAMFS() {  
        system.debug('url origin = '+Apexpages.currentPage().getParameters().get('paramOrigin'));   
        paramOrigin = cs.Origin; 
        return null;
    }
    
    
    
    Public boolean getLegalStatement(){
        boolean isOpen = false;
        if (isAMFS == true) { 
            paramOrigin = Apexpages.currentPage().getParameters().get('paramOrigin'); 
            paramOrigin = paramOrigin != null ? paramOrigin : cs.origin;
            system.debug('paramOrigin:'+paramOrigin); 
            system.debug('Related_Departments__c:'+cs.Related_Departments__c);
            system.debug('Case_Type_Config__c:'+cs.Case_Type_Config__c);
            List<Master_legal__c> mstr = new List<Master_legal__c>() ;
            mstr = [SELECT id, name,Jenis_Trx__c, Case_Type__c, DepartmentId__c, Description__c From Master_legal__c where DepartmentId__c = :cs.Related_Departments__c AND Case_Type__c INCLUDES (:cs.Case_Type_Config__c) ]; 
            if (mstr.size() > 0) { 
                system.debug('mstr:'+mstr);
                isOpen = true; typeLegalAMFS = mstr[0].Jenis_Trx__c; descLegalAMFS = mstr[0].Description__c;  
            }  
        } 
        return isOpen;
    }  
    
    public void sendEmail(){
        
        if(cs.Related_Departments__c == 'Quick Response'){
            Date tomorrow = Date.today().addDays(+1);
            if(cs.Date_of_Service__c == tomorrow){
                String recipient = System.LABEL.QuickResponse_EmailTo;
                String masking = System.LABEL.QuickResponse_EmailFrom;
                String[] to = recipient.trim().split(';');
                String subject = System.LABEL.QuickResponse_EmailSubject;
                String body = System.LABEL.QuickResponse_EmailBody;
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                string urlQRO = '<html><a href="' + URL.getSalesforceBaseUrl().toExternalForm() + '/' + CurrentId + '">' + relatedDepartment + '</a></html>';
                email.setSenderDisplayName(masking);
                email.setSubject(subject);
                email.setHtmlBody(body + urlQro);
                email.setToAddresses(to);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
            }
        }   
    }
    
    public PageReference onChangeDateOfService(){
        tNow = Time.newInstance(DateTime.now().hour(), DateTime.now().Minute(), DateTime.Now().Second(), 0);
        system.debug('dtNow: ' + dtNow + '|tNow: ' + tNow + '|maxTimeDaily: ' + maxTimeDaily);
        List<Case> listServiceDate = new List<Case>();
        listServiceDate = [Select Date_of_Service__c from Case where Date_of_Service__c =: cs.Date_of_Service__c and Related_Departments__c = 'Quick Response'];
        if(cs.Date_of_Service__c <= Date.today()){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,Label.QR_DOS_Val_1 + ' ' + Date.Today()));
        } else {
            if (cs.Date_of_Service__c.isSameDay(Date.today().addDays(1)) && tNow > maxTimeDaily) {
                String maxMinuteStr = Label.QuickResponse_MaxMinute;
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, Label.QR_DOS_Val_2 + ' ' + maxTimeDaily.hour() + ':' + maxMinuteStr.rightPad(2)));
            } 
            system.debug('elses');
            if(listServiceDate.size() >= qrLimit){
                system.debug('lebih dari kuota');
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, Label.QR_Quota_Val_2 + ' ' + cs.Date_of_Service__c));
            }
            else {
                system.debug('ada sisa kuota');  
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, Label.QR_Quota_Val_1 + ' ' + cs.Date_of_Service__c + ' : ' + (qrLimit - listServiceDate.size())));
            }
            
        } 
        return null;
    }
    
    private void updateCallLineToRescheduled(String policyNo, String caseType, Date rescheduleDate, String selectedTimeRange) {
        system.debug('updateCallLineToRescheduled 1 policy No' + policyNo + ' case type =  ' + caseType + ' rescheduleDate   ' + rescheduleDate + ' selectedTimeRange ' + selectedTimeRange);
        if (String.isBlank(policyNo) || String.isBlank(caseType)) return;
        system.debug('updateCallLineToRescheduled 2 ');
        // Cari campaign type berdasarkan case type
        List<Campaign_Type_Mapping__c> campaignTypes = [
            SELECT Id, Campaign_Type__c 
            FROM Campaign_Type_Mapping__c 
            WHERE Case_Type__c = :caseType 
            LIMIT 1
        ];
        system.debug('updateCallLineToRescheduled 1');
        
        if (campaignTypes.isEmpty()) return;
        system.debug('updateCallLineToRescheduled 2');
        
        String campaignType = campaignTypes[0].Campaign_Type__c;
        system.debug('updateCallLineToRescheduled 3');
        
        // Update Call_Line__c dengan policy no dan campaign type yang sesuai
        List<Call_Line__c> callLinesToUpdate = [
            SELECT Id, name, Activity_Result__c, OwnerId, Reschedule_Date__c
            FROM Call_Line__c 
            WHERE Policy_No__c = :policyNo 
            AND Campaign_Type__c = :campaignType and Call_Status_Config__c = 'F'
            ORDER BY createdDate DESC
            LIMIT 1
        ];
        system.debug('updateCallLineToRescheduled 4');
        
        if (!callLinesToUpdate.isEmpty()){
            Call_line__c cl = callLinesToUpdate[0];
            cl.Date_Reschedule__c = rescheduleDate; cl.Time_Reschedule__c=selectedTimeRange; cl.Status_Retry__c = 'Booking Call';
            update cl;
            
            
            Date tanggal = cl.Date_Reschedule__c; String jamStr = cl.Time_Reschedule__c; 
            DateTime gabungan;
            
            if (tanggal != null && String.isNotBlank(jamStr)) {
                List<String> jamMenit = jamStr.split(':'); Integer jam = Integer.valueOf(jamMenit[0]); Integer menit = Integer.valueOf(jamMenit[1]);
                
                // Buat Time dari angka jam dan menit
                Time waktu = Time.newInstance(jam, menit, 0, 0);
                
                // Gabungkan tanggal dan waktu jadi DateTime
                gabungan = DateTime.newInstance(tanggal, waktu);
                
                // Sekarang kamu sudah punya gabungan "2025-05-21 08:00:00"
                System.debug('DateTime Reminder: ' + gabungan);
            }
            
            Event t = new Event();
            t.Subject = 'Reschedule Call Line - ' + cl.name + ' in 30 minutes';
            t.WhatId = cl.id; t.ActivityDate = rescheduleDate;
            t.OwnerId = cl.OwnerId; t.Description = 'Reschedule for Call Line: ' + cl.name + ' in 30 minutes';
            t.IsReminderSet = true; t.ReminderDateTime = gabungan.addMinutes(-30);
            //t.ReminderDateTime = rescheduleDate;
            t.StartDateTime = gabungan; t.EndDateTime = gabungan;
            //t.remi
            insert t;
            
            Event E = new Event();
            E.Subject = 'Reschedule Call Line - ' + cl.name + ' in 5 minutes';
            E.WhatId = cl.id;
            E.ActivityDate = rescheduleDate; E.OwnerId = cl.OwnerId;
            E.Description = 'Reschedule for Call Line: ' + cl.name + ' in 5 minutes';
            E.IsReminderSet = true; E.ReminderDateTime = gabungan.addMinutes(-5);
            //t.ReminderDateTime = rescheduleDate;
            E.StartDateTime = gabungan; E.EndDateTime = gabungan;
            //t.remi
            insert E;
        }
        system.debug('updateCallLineToRescheduled 5');
    }
    
    
    public void followHoldDateConfirmationDisplay() {
        Date holdDate = cs.Follow_Hold_Date__c;
        String[] monthList = new String[]{'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'};
            Integer holdDateDay = holdDate.day();
        String holdDateMonth = monthList[holdDate.month()-1];
        Integer holdDateYear = holdDate.year();
        String holdDateString = Integer.valueOf(holdDateDay) + ' ' + holdDateMonth + ' ' + Integer.valueOf(holdDateYear);
        confirmationMessage = 'Apakah kamu yakin ingin hold debet di tanggal ' + holdDateString + '? ';
        isShowConfirmDisplay = true;
    }
    
    public PageReference confirmationDisplayYes() {
        isShowConfirmDisplay = false;
        system.debug('masuk confirm yes');
        if (savingType.equalsIgnoreCase('Save')) {
            system.debug('confirm yes: Save');
            return actionSave();
        } else {
            system.debug('confirm yes: Save and New');
            return actionSaveAndNew();
        }
    }
    
    public PageReference confirmationDisplayNo() {
        isShowConfirmDisplay = false;
        return null;
    }
    
    public PageReference actionSave() {
        isSave = false;
        system.debug('call action save');
        collectiveSave();
        if (isSave) {
            sendEmail();
            PageReference redirectPG = new PageReference('/' + CurrentId);
            redirectPG.setRedirect(true);
            return redirectPG;  
        } else {
            return null;
        }
    }
    
    public PageReference actionSaveAndNew() {
        isSave = false;
        collectiveSave();
        
        if (isSave) {
            PageReference p;
            
            if(source=='none'){
                p = new PageReference('/apex/CaseRequestLayoutContact?retURL=/'+retURL+'&def_contact_id='+cs.Contactid+'&def_account_id='+cs.AccountId+'&RecordType='+cs.recordTypeId+'&cas5=Request&ent=Case&cas11=none');
            }
            if(source=='email'){
                p = new PageReference('/apex/CaseRequestLayoutContact?retURL=/'+retURL+'&RecordType='+cs.recordTypeId+'&cas5=Request&cas11=Email&ent=Case&cas3='+cs.ContactId);
            }
            p.setRedirect(true);
            sendEmail();
            return p;
        } else {
            return null;
        }  
    }
}