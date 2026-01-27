public class CaseServiceController {    
    public class ApplicationException extends Exception{}
    
    public CaseServiceController(){}
    
    public class attachmentData {
        public blob body;
        public string name;
    }

    public List<Case> processInquirySaveWithClosedStatus(Case cs, String[] caseTypes){
      cs.Status = 'Closed';
        return processInquirySave(cs, caseTypes);
    }
    
    public List<Case> processInquirySave(Case cs, String[] caseTypes){
        List<Case> caseList = new List<Case>();
        Case cse = null;
        integer temp = 0;
        boolean temp2 = FALSE;
        system.debug('>>> processInquirySave outside loop Case : '+ cs);
        system.debug('>>> processInquirySave outside loop caseType : '+caseTypes);
        for(String caseType : caseTypes){
            temp += 1;
            if (temp > 1) temp2 = TRUE;
            
            system.debug('>>> processInquirySave caseType : '+caseType + ' cs.type ' + cs.type);
            cse = new Case();
            cse.contactId = cs.contactId;
            cse.Status = cs.Status;
            //cse.type = cs.type;
            cse.type = cs.type == 'Request' ? null : cs.type;
            cse.Priority = cs.Priority;
            cse.Service_Type__c = cs.Service_Type__c;
            cse.origin = cs.origin;
            cse.Case_Type_Config__c = caseType;
            cse.Case_Type__c = caseType;
            cse.Subject = cs.Subject;
            cse.Description = cs.Description;
            cse.accountId = cs.accountId;
            cse.recordTypeId = cs.recordTypeId;
            cse.createdbyId = UserInfo.getUserId();
            cse.Negative_Feedback__c = cs.Negative_Feedback__c;
            cse.parentid = cs.parentid;
            cse.NonPP__c = cs.NonPP__c; //added by catur
            cse.General_Attitude__c = cs.General_Attitude__c; // Taufik, new Okt 2018, Cust 360
            cse.MultiCreate__c = TRUE; // taufik, track multi create.
            cse.X2nd_Record__c = temp2; // taufik, track multi create, record ke-2
            cse.Product__c = cs.Product__c; // 24 Jan 2020, Taufik MII
            cse.Product_AFI__c = cs.Product_AFI__c; // 24 Jan 2020, Taufik MII                 
            cse.Line_Queue__c = cs.Line_Queue__c; // 24 Jan 2020, Taufik MII
            cse.Root_Cause__c = cs.Root_Cause__c; // 2020031-Arief
            cse.Product_AFI2__c = cs.Product_AFI2__c; // 10/15/2021-Ranti
            cse.Insurance_Type_AFI__c = cs.Insurance_Type_AFI__c; // 04/02/2022-Beni R
            cse.Data_Correction__c = cs.Data_Correction__c; // 29/02/2024-Beni R
            // add by Ranti at 10/14/2021 
            // add sent receipt
           	cse.Email_Non_PP__c = cs.Email_Non_PP__c;
            cse.Phone_Non_PP__c = cs.Phone_Non_PP__c; 


            caseList.add(cse);
        }
        
        system.debug('caseList before insert' + caseList);
        insert caseList;
        system.debug('caseList after insert' + caseList);
        return caseList;
    } 
    
    public Case processRequestSave(Case cs, String entity){
        return processRequestCollectiveSave(cs, entity, null, null);
    }
    
    
    
    public Case processRequestCollectiveSave(Case cs, String entity, String formentity, id idCaseInquiry){
        String selectedQueueDept = null; 
        String QueueDept = null;
        List<Master_Case_Type_Regional__c> mctr = new List<Master_Case_Type_Regional__c>();
            System.debug('Case Type : ' + cs.Case_Type_Config__c + ', Entity : ' + entity + ', Type : ' + cs.Type);
        if(entity == 'AGI') { 
            //--Added by Daniel 28/02/2019
            mctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Product__c, Business_Channel__c, Department_Queue__c, Current_User__c 
                    FROM Master_Case_Type_Regional__c 
                    WHERE Case_Type__c = :cs.Case_Type_Config__c AND Entity__c = :entity AND Product__c = :cs.Product__c AND Business_Channel__c = :cs.Business_Channel__c AND Active__c = TRUE AND (Department_Queue__c != '' OR Current_User__c = TRUE) 
                    LIMIT 1];
         } else {
             //--Added by Suryono 12/12/2018
            mctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Department_Queue__c, Current_User__c 
                    FROM Master_Case_Type_Regional__c 
                    WHERE Case_Type__c = :cs.Case_Type_Config__c AND Entity__c = :entity AND Type__c = :cs.Type AND Active__c = TRUE AND (Department_Queue__c != '' OR Current_User__c = TRUE) 
                    LIMIT 1];
        }
        //List<CaseComment> cases = [Select Id, ParentId, IsPublished, CommentBody, CreatedById, CreatedDate, SystemModstamp, LastModifiedDate, LastModifiedById, IsDeleted From CaseComment];

        Case cse = null;
        cse = new Case();
        cse.contactId = cs.contactId;
        cse.Status = cs.Status;
        cse.type = cs.type;
        cse.Priority = cs.Priority;
        cse.Service_Type__c = cs.Service_Type__c;
        cse.origin = cs.origin;
        cse.Case_Type__c = cs.Case_Type__c;
        cse.Case_Type_Config__c = cs.Case_Type_Config__c;
        cse.Subject = cs.Subject;
        cse.Description = cs.Description;
        
        //input unit__c dan request_type__c di entity AMFS - 08/09/2020, MII
        //
        //Di Comment karna selalu true 
        /*if(String.isEmpty(cse.Department__c)){
            // mapping unit & request type from case type config.
        }else{
            cse.Related_Department__c = cs.Related_Department__c;
        	cse.Request_Type__c = cs.Request_Type__c;  
       	}*/
        
        if(entity == 'AGI') {
            cse.Product__c = cs.Product__c;
            cse.Category__c = cs.Category__c;
            cse.Business_Channel__c = cs.Business_Channel__c;
            cse.Branch_AGI__c = cs.Branch_AGI__c;  
        } 
        //cse.PIC_Department_LU__c = cs.PIC_Department_LU__c; //--Edited by Suryono 12/12/2018
        // 9 Okt 2019, taufik add formentity
        if (formentity == NULL || formentity == '') formentity = entity;
    
        cse.Escalated_Flow__c = esalatedFlowGenerator(cs, formentity);
        cse.Escalated_Flow_TAT__c = esalatedFlowTATGenerator(cs, formentity);          
    
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
            if(mctr[0].Current_User__c) {
                cse.PIC_Department_LU__c = UserInfo.getUserId();
            } else {
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
                    cse.PIC_Department_LU__c = UserInfo.getUserId();
                } else {
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
            } else {
                QueueDept = selectedQueueDept.replaceAll( '\\s+', '_');
            }
            System.debug('*********** QueueDept: ' + QueueDept);
            String qDevName = entity + '_' + QueueDept + '_Queue';
            List<Group> gQueue = [SELECT Id FROM Group WHERE Type = 'Queue' AND DeveloperName = :qDevName];
            if(gQueue.size() > 0) {
                cse.OwnerId = gQueue[0].Id;
                if (selectedQueueDept == 'Temporary') {cse.PIC_Department_LU__c = UserInfo.getUserId();}
            } else {
                throw new ApplicationException('No Queue available, please contact your Administrator.');
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
        cse.Product_AFI__c = cs.Product_AFI__c; // 24 Jan 2020, Taufik MII
        cse.Line_Queue__c = cs.Line_Queue__c; // 24 Jan 2020, Taufik MII
        
        cse.Product_AFI2__c = cs.Product_AFI2__c; // 10/15/2021-Ranti
        cse.Insurance_Type_AFI__c = cs.Insurance_Type_AFI__c; // 04/02/2022-Beni R
        cse.Data_Correction__c = cs.Data_Correction__c; // 29/02/2024-Beni R
        
        //(2019-09-09 By Arief Robbiansyah)
        cse.Courier__c = cs.Courier__c;
        /*
        CaseComment csComment = new CaseComment();
        csComment.CommentBody = comment;
        csComment.ParentId = cse.id;
        */
        cse.Already_Send_Survey__c = cs.Already_Send_Survey__c;

        // add by Ranti at 10/14/2021 
        // add sent receipt
        cse.Email_Non_PP__c = cs.Email_Non_PP__c;
        cse.Phone_Non_PP__c = cs.Phone_Non_PP__c;
        // cse.Type_Sent_E_Receipt__c = cs.Type_Sent_E_Receipt__c;
		
        try {
            insert cse;

            if(String.isNotBlank(idCaseInquiry)){
                List<Case> csInquiryList = [SELECT Id, Non_Inquiry__c FROM Case WHERE id = :idCaseInquiry];
                for(Integer i =0; i < csInquiryList.size(); i++){
                Case c = csInquiryList.get(i);
                c.Non_Inquiry__c = true;
                }
            update csInquiryList;
            }
        } catch (Exception e) {
            String stackTrace = e.getStackTraceString();
            String errorTypeName = e.getTypeName();
            String errMsg = ' Failed Create Case: [LINE ' + e.getLineNumber() + '] ' + e.getMessage() + 
                            ' type error '+errorTypeName+
                            '\nFULL STACK TRACE:\n' + stackTrace;
            System.debug('#### Error! Create Case: '+errMsg);
        }
        
        system.debug('== Case id:'+cse.id);
        return cse;
    }
    
    
    public Case processComplaintSave(Case cs, String entity){
        return processComplaintCollectiveSave(cs, entity, null);
    }
    
    public Case processComplaintCollectiveSave(Case cs, String entity, id idCaseInquiry){
        String selectedQueueDept = null;
        List<Master_Case_Type_Regional__c> mctr;
        if(entity == 'AMFS') {
            //--Added by Suryono 12/12/2018
            mctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Department_Queue__c 
                    FROM Master_Case_Type_Regional__c 
                    WHERE (Case_Type__c = :cs.Category_Config__c OR Case_Type__c = :cs.Complaint_Type__c) AND Entity__c = :entity AND Type__c = :cs.Type AND Active__c = TRUE AND Department_Queue__c != '' 
                    LIMIT 1]; 
        } else {
            //--Added by Suryono 12/12/2018
            mctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Department_Queue__c 
                    FROM Master_Case_Type_Regional__c 
                    WHERE Case_Type__c = :cs.Category_Config__c AND Entity__c = :entity AND Type__c = :cs.Type AND Active__c = TRUE AND Department_Queue__c != '' 
                    LIMIT 1]; 
        }
        List<CaseComment> cases = [Select Id, ParentId, IsPublished, CommentBody, CreatedById, CreatedDate, SystemModstamp, LastModifiedDate, LastModifiedById, IsDeleted From CaseComment LIMIT 1000];
        //List<Case> caseList = new List<Case>();
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
        //cse.PIC__c = cs.PIC__c; //--Edited by Suryono 3/1/2019
        cse.Pending_Status__c = cs.Pending_Status__c;
        cse.Sub_Status__c = cs.Sub_Status__c;
        cse.Service_Type__c = cs.Service_Type__c;
        cse.Subject = cs.Subject;
        cse.Description = cs.Description;
        cse.Nature_Config__c = cs.Nature_Config__c;
        cse.Customer__c = cs.Customer__c;
        cse.Category_Config__c = cs.Category_Config__c;
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
        //caseList.add(cse);
        cse.NonPP__c = cs.NonPP__c; //added by catur
        cse.Escalated_Flow__c = esalatedFlowGenerator(cs, entity);
        cse.Escalated_Flow_TAT__c = esalatedFlowTATGenerator(cs, entity);
        cse.Product_AFI__c = cs.Product_AFI__c; // 24 Jan 2020, Taufik MII  
        cse.Line_Queue__c = cs.Line_Queue__c; // 24 Jan 2020, Taufik MII     
        cse.Product_AFI2__c = cs.Product_AFI2__c; // 10/15/2021-Ranti
        cse.Insurance_Type_AFI__c = cs.Insurance_Type_AFI__c; // 04/02/2022-Beni R
        
        // Taufik - Next Department
        Map<String, Object> mapJs = (Map<String, Object>) JSON.deserializeUntyped(cse.Escalated_Flow__c);
        System.debug('mapJs : ' + mapJs);
        String mapIndex = String.valueOf(2);
    
        if (mapJs.get(mapIndex) == NULL) cse.Next_Department__c = 'CCC';
        else if (mapJs.get(mapIndex) == 'null') cse.Next_Department__c = 'CCC';
        else cse.Next_Department__c = string.valueof(mapJs.get(mapIndex)); // <-- isi di sini, hasil Break dari Escalated Flow
        // End Taufik - Next Department
     
        if(mctr.size() > 0) {
            cse.PIC__c = mctr[0].PIC_Department__c;
            cse.PIC_Department_LU__c = mctr[0].PIC_Department__c;
            cse.TAT__c = mctr[0].TAT__c;
            cse.SLA_Case_Closed__c = mctr[0].SLA__c;
            cse.Division__c = mctr[0].Department_Queue__c;
            selectedQueueDept = mctr[0].Department_Queue__c;
        } else {
            //List<User> u = [SELECT Id FROM User WHERE IsActive = true AND Entity__c = :entity AND UserRole.Name LIKE '%CCC Manager%' LIMIT 1];
            String qDefCaseType = entity + ' Default Case Type';
            List<Master_Case_Type_Regional__c> altmctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Department_Queue__c FROM Master_Case_Type_Regional__c WHERE Entity__c = :entity AND Name = :qDefCaseType AND Active__c = TRUE AND Type__c = :cs.Type LIMIT 1];
            if(altmctr.size() > 0) {
                cse.PIC__c = altmctr[0].PIC_Department__c;
                cse.PIC_Department_LU__c = altmctr[0].PIC_Department__c;
                cse.TAT__c = altmctr[0].TAT__c;
                cse.SLA_Case_Closed__c = altmctr[0].SLA__c;
                cse.Division__c = altmctr[0].Department_Queue__c;
                selectedQueueDept = altmctr[0].Department_Queue__c;    
            } else {
                selectedQueueDept = 'CMU';
                //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'No Master Case Type Regional found, please contact your Administrator.'));
            }
        }
     
        if(selectedQueueDept.containsWhitespace()) { selectedQueueDept = selectedQueueDept.replaceAll('\\s', '_'); }
        System.debug('queueDept : ' + selectedQueueDept);
        String qDevName = entity + '_' + selectedQueueDept + '_Queue';
        List<Group> gQueue = [SELECT Id FROM Group WHERE Type = 'Queue' AND DeveloperName = :qDevName];
        if(gQueue.size() > 0) {
            cse.OwnerId = gQueue[0].Id;
            if(selectedQueueDept == 'CMU') {cse.PIC__c = UserInfo.getUserId(); cse.PIC_Department_LU__c = UserInfo.getUserId();}
        } else {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'No Queue available, please contact your Administrator.'));
        }
    
        //(2019-09-09 By Arief Robbiansyah)
        cse.Courier__c = cs.Courier__c;

    
        // add by Ranti at 10/14/2021 
        // add sent receipt
        cse.Email_Non_PP__c = cs.Email_Non_PP__c;
        cse.Phone_Non_PP__c = cs.Phone_Non_PP__c;
        // cse.Type_Sent_E_Receipt__c = cs.Type_Sent_E_Receipt__c;

    
        //List<Database.SaveResult> sr = DataBase.insert(caseList);
        insert cse;
     
        //update Inquiry record become REAL Inquiry  
        if (String.isNotBlank(idCaseInquiry)) {
            List<Case> inquiryCase = [select id, Non_Inquiry__c from Case where id=:idCaseInquiry];
    
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
      return cse;
    }

    
    public Boolean getCekCourierCase(Case cs){
        Boolean cek = false;
        String key = null;
        String dependencyCourier = null;
        
        if('Request'.equalsIgnoreCase(cs.Type)){
            key = cs.Case_Type_Config__c;
            dependencyCourier = Label.Courier_Dependency_Request_Case;
        }else if('Complaint'.equalsIgnoreCase(cs.Type)){
            key = cs.Nature_Config__c;
            dependencyCourier = Label.Courier_Dependency_Complaint_Case;
            if(cs.Category_Config__c != null){
                key += ','+cs.Category_Config__c;
            }
        }
        
        if(key != null && dependencyCourier != null){
            key = ((key.replace(' ', '')).trim()).toUpperCase();
            String[] dependencies = dependencyCourier.split(';');
            for(String dependency : dependencies){
                dependency = ((dependency.replace(' ', '')).trim()).toUpperCase();
                System.debug('key : '+key+' == dependency : '+dependency);
                cek = dependency.equalsIgnoreCase(key);
                System.debug('cek : '+cek);
                if(cek) break;
            }
        }
        return cek;
    }
    
    private String esalatedFlowGenerator(Case cs, String entity) {
        List<Master_Case_Type_Regional__c> mctr = new List<Master_Case_Type_Regional__c>();
        if(cs.Type == 'Complaint'){
            mctr = [SELECT Id, Department_Queue__c, Department_Queue_2__c, Department_Queue_3__c, Department_Queue_4__c, Department_Queue_5__c 
                    FROM Master_Case_Type_Regional__c 
                    WHERE Case_Type__c = :cs.Category_Config__c AND Entity__c = :entity 
                    LIMIT 1];
        } else {
            if(entity == 'AGI') {
                mctr = [SELECT Id, Department_Queue__c, Department_Queue_2__c, Department_Queue_3__c, Department_Queue_4__c, Department_Queue_5__c 
                        FROM Master_Case_Type_Regional__c 
                        WHERE Case_Type__c = :cs.Case_Type_Config__c AND Entity__c = :entity AND Product__c = :cs.Product__c AND Business_Channel__c = :cs.Business_Channel__c AND Type__c = :cs.type AND Active__c = TRUE AND Department_Queue__c != '' 
                        LIMIT 1];
            } else {
                mctr = [SELECT Id, Department_Queue__c, Department_Queue_2__c, Department_Queue_3__c, Department_Queue_4__c, Department_Queue_5__c 
                        FROM Master_Case_Type_Regional__c
                        WHERE Case_Type__c = :cs.Case_Type_Config__c AND Entity__c = :entity 
                        LIMIT 1];
            }
        }
        
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
    
    private String esalatedFlowTATGenerator(Case cs, String entity) {
        List<Master_Case_Type_Regional__c> mctr = new List<Master_Case_Type_Regional__c>();
        if(cs.Type == 'Complaint'){
            mctr = [SELECT Id, TAT__c, TAT_2__c, TAT_3__c, TAT_4__c, TAT_5__c 
                    FROM Master_Case_Type_Regional__c 
                    WHERE Case_Type__c = :cs.Category_Config__c AND Entity__c = :entity 
                    LIMIT 1];
        } else {
            if(entity == 'AGI') {
              mctr = [SELECT Id, TAT__c, TAT_2__c, TAT_3__c, TAT_4__c, TAT_5__c 
                      FROM Master_Case_Type_Regional__c 
                      WHERE Case_Type__c = :cs.Case_Type_Config__c AND Entity__c = :entity AND Product__c = :cs.Product__c AND Business_Channel__c = :cs.Business_Channel__c AND Type__c = :cs.type AND Active__c = TRUE AND Department_Queue__c != '' 
                      LIMIT 1];
            } else {
              mctr = [SELECT Id, TAT__c, TAT_2__c, TAT_3__c, TAT_4__c, TAT_5__c 
                      FROM Master_Case_Type_Regional__c 
                      WHERE Case_Type__c = :cs.Case_Type_Config__c AND Entity__c = :entity 
                      LIMIT 1];    
            }
        }
        
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