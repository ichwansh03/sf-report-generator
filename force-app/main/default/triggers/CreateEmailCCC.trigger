trigger CreateEmailCCC on Email_SMS_Log__c (before Insert, after insert, after update) {
    // added by Support at 16 Jan 25
    if (trigger.isBefore) {
        IF(Trigger.isInsert) {
            Map<String, string> mapCasetypeId = new Map<String, string>(); 
            Set<Id> caseIds = new Set<Id>();
            for(Email_SMS_Log__c row : trigger.new){
                if (row.Case__c != null  
                    && row.Entity__c == 'AMFS' 
                    && row.Category__c == 'ICF'
                    && ! System.isFuture()
                   ){
                    caseIds.add(row.Case__c);
                }
            }
            
            if (caseIds.size() > 0) {
                List<case> getDetailCases = [Select id,Case_Type_Config__c,Case_Type__c, type from case where id in: caseIds and entity__c = 'AMFS'];
                Map<String, string> setMapCaseType = new Map<String, string>();
                
                for(Case row: getDetailCases) {  
                    String caseType = row.Case_Type__c;
                    if (string.isblank(caseType)) caseType = row.Case_Type_Config__c;
                     
                    string concat = row.id; 
                    concat += '_'; 
                    concat += row.type; 
                    
                    setMapCaseType.put(concat, caseType);
                }
                  
                map<string, string> mapTypeCase = new map<string, string>();
                List<Master_Case_Type_Regional__c> masterCaseType = [SELECT Id, Qualtrics__c, Case_Type__c, mot__c, type__c, Remark__c  FROM Master_Case_Type_Regional__c where Qualtrics__c = true and Case_Type__c in :setMapCaseType.values()];
                for(Master_Case_Type_Regional__c row : masterCaseType) {   
                    string concat = row.Case_Type__c; 
                    concat += '_'; 
                    concat += row.type__c; 
                    mapTypeCase.put(concat, row.Remark__c);
                } 
                
                for (string row: setMapCaseType.keySet()) {
                    List<String> splitConcat = row.split('_');
                    if (splitConcat.size() > 1) {
                        String caseId = splitConcat[0];
                        String caseType = setMapCaseType.get(row);
                        
                        string checkConcat = caseType;
                        checkConcat += '_'; 
                        checkConcat += splitConcat[1]; 
                        
                        if (mapTypeCase.containsKey(checkConcat)) {
                            mapCasetypeId.put(caseId, mapTypeCase.get(checkConcat));
                        } 
                    }
                    
                }
                 
                 for(Email_SMS_Log__c row : trigger.new){
                     if ( mapCasetypeId.containsKey(row.Case__c) ){
                         row.Case_Type_Remark__c = mapCasetypeId.get(row.Case__c);
                     }
                 }
                
            }
            
        }
    }
    
    if (trigger.isAfter) { 
        IF(Trigger.isInsert){
            List<Email_SMS_Log__c> listEmail = trigger.new;
            map<string, string> mapCase = new map<string, string>();
            map<string, string> ComplaintCase = new map<string, string>();
            map<string, string> RequestPOSCase = new map<string, string>();
            map<string, string> RequestClaimRejectCase = new map<string, string>();
            Set<Id> emailrejectclaimIds = new Set<Id>();
            For(Email_SMS_Log__c EmailLog : listEmail){
                system.debug('Create Email CCC - EmailLog Id:'+EmailLog.Id);

                //Modified by Dimas Support MII 15/05/2025
                //Modified by Egie for Claim MII 19/08/2025
                if (EmailLog.Case__c != null 
                    && EmailLog.Case_Type__c != 'Request POS'
                    && EmailLog.Case_Type__c != 'Request_Claim_Payment'
                    && (EmailLog.Transaction_Type__c == NULL || EmailLog.Transaction_Type__c == '')
                    && EmailLog.Status__c == 'Draft' 
                    && EmailLog.Entity__c == 'AMFS' 
                    && EmailLog.Category__c == 'ICF'
                    && ! System.isFuture()
                   ){
                       mapCase.put(EmailLog.Case__c, '');
                   }
                if (EmailLog.Case__c != null 
                    && EmailLog.Case_Type__c == 'Request_Claim_Payment'
                    && EmailLog.Status__c != 'Send' 
                    && EmailLog.Entity__c == 'AMFS' 
                    && EmailLog.Category__c == 'ICF'
                    && ! System.isFuture()
                   ){
                       mapCase.put(EmailLog.Case__c, '');
                   }
                if (EmailLog.Case__c != null 
                    && EmailLog.Case_Type__c != 'Request POS'
                    && (EmailLog.Transaction_Type__c == NULL || EmailLog.Transaction_Type__c == '')
                    && EmailLog.Status__c != 'Send' 
                    && EmailLog.Entity__c == 'AMFS' 
                    && EmailLog.Category__c == 'ICF'
                    && EmailLog.MOT__c == 'I Complain'
                    && ! System.isFuture()
                   ){
                       ComplaintCase.put(EmailLog.Case__c, '');
                   }
                if (EmailLog.Case__c != null
                    && EmailLog.Case_Type__c == 'Request POS'
                    && (EmailLog.Transaction_Type__c == NULL || EmailLog.Transaction_Type__c == '')
                    && EmailLog.Status__c != 'Send' 
                    && EmailLog.Entity__c == 'AMFS' 
                    && EmailLog.Category__c == 'ICF'
                    && EmailLog.MOT__c == 'I Ask'
                    && ! System.isFuture()
                   ){
                       RequestPOSCase.put(EmailLog.Case__c, '');
                   }
                if (EmailLog.Case__c != null
                    && EmailLog.Case_Type__c != 'Request POS'
                    && EmailLog.Transaction_Type__c != NULL 
                    && EmailLog.Transaction_Type__c != ''
                    && EmailLog.Case_Type__c == 'Request'
                    && EmailLog.Status__c != 'Send' 
                    && EmailLog.Entity__c == 'AMFS' 
                    && EmailLog.Category__c == 'ICF'
                    && EmailLog.MOT__c == 'I Ask'
                    && ! System.isFuture()
                   ){
                       RequestClaimRejectCase.put(EmailLog.Case__c, '');
                   }
                
                //add for reject claim without case
                if (EmailLog.Case__c == null 
                    && EmailLog.MOT__c == 'I Claim'
                    && EmailLog.Claim_Status__c == 'Reject'
                    && EmailLog.Status__c == 'Draft' 
                    && EmailLog.Entity__c == 'AMFS' 
                    && EmailLog.Category__c == 'ICF'
                    && ! System.isFuture()
                   ){
                       emailrejectclaimIds.add(EmailLog.Id);
                   }
            }
            If(mapCase.size() > 0) {
                List<String> CaseType = new List<string>();
                List<Master_Case_Type_Regional__c> masterCaseType = [SELECT Id, Qualtrics__c, Case_Type__c, mot__c FROM Master_Case_Type_Regional__c where Qualtrics__c = true];
                for(Master_Case_Type_Regional__c row : masterCaseType) {
                    CaseType.add(row.Case_Type__c);
                }
                
                List <Case> detailCases = [SELECT Id, ContactId, Type, Case_Type__c, MOT__c FROM Case WHERE id in : mapCase.keyset() and Case_Type__c in : CaseType];
                system.debug('Create Email CCC - detailCases: '+detailCases.size());
                for(Case Cases : detailCases){
                    if(mapCase.containsKey(Cases.Id)) mapCase.put(Cases.Id, Cases.MOT__c);
                }
                Set<Id> emailIds = new Set<Id>();
                for(Email_SMS_Log__c EmailLogCheck: listEmail){
                    if (EmailLogCheck.Case__c != null ) system.debug('CCC - Case__c');
                    if (EmailLogCheck.Entity__c == 'AMFS' ) system.debug('CCC - Entity__c');
                    if ( String.isnotblank(mapCase.get(EmailLogCheck.Case__C)) ) system.debug('CCC - mapCase');
                    if (mapCase.containsKey(EmailLogCheck.Case__C) ) system.debug('CCC - containsKey');
                    if (EmailLogCheck.Category__c == 'ICF' ) system.debug('CCC - Category__c');
                    if (EmailLogCheck.Status__c == 'Draft' ) system.debug('CCC - Status__c');
                    if (EmailLogCheck.Case_Type__c != 'Request_Claim_Payment') system.debug('CCC - Case_Type__c');
                    if (
                        EmailLogCheck.Case__c != null 
                        && EmailLogCheck.Entity__c == 'AMFS' 
                        && mapCase.containsKey(EmailLogCheck.Case__C)
                        && String.isnotblank(mapCase.get(EmailLogCheck.Case__C))
                        && EmailLogCheck.Category__c == 'ICF' 
                        && EmailLogCheck.Status__c == 'Draft' 
                        && EmailLogCheck.Case_Type__c != 'Request_Claim_Payment'
                        &&  ! System.isFuture()
                    ){  
                        emailIds.add(EmailLogCheck.id);
                    }
                    //for claim case
                    if (
                        EmailLogCheck.Case__c != null 
                        && EmailLogCheck.Entity__c == 'AMFS' 
                        && mapCase.containsKey(EmailLogCheck.Case__C)
                        && String.isnotblank(mapCase.get(EmailLogCheck.Case__C))
                        && EmailLogCheck.Category__c == 'ICF' 
                        && EmailLogCheck.Status__c != 'Draft' 
                        && EmailLogCheck.Case_Type__c == 'Request_Claim_Payment'
                        &&  ! System.isFuture()
                    ){  
                        emailIds.add(EmailLogCheck.id);
                    }
                    //for outbound call
                    if (
                        EmailLogCheck.Case__c != null 
                        && EmailLogCheck.Entity__c == 'AMFS' 
                        && mapCase.containsKey(EmailLogCheck.Case__C)
                        && String.isnotblank(mapCase.get(EmailLogCheck.Case__C))
                        && EmailLogCheck.Category__c == 'ICF' 
                        && EmailLogCheck.Status__c == 'Draft' 
                        && EmailLogCheck.Outbound_Call__c
                        &&  ! System.isFuture()
                    ){  
                        emailIds.add(EmailLogCheck.id);
                    }
                }
                system.debug('Create Email CCC - emailIds:'+emailIds.size());
                if (emailIds.size() > 0 && ! System.isFuture()) { 
                    CheckSurveyICFFuture.checkSurveyICF(emailIds);
                }
            }   
            
            //add sprint 3, October 2024
            If(ComplaintCase.size() > 0){
                Set<Id> emailIdsComplaint = new Set<Id>();
                List <Case> ComplaintCases = [SELECT Id, ContactId, Type, MOT__c FROM Case WHERE id in : ComplaintCase.keyset() and Type = 'Complaint'
                                              and (CHS_Status__c = 'Closed - Invalid' OR CHS_Status__c = 'Closed - Valid')
                                              and (Complaint_Decision_AMFS__c = 'Invalid & Paid' OR Complaint_Decision_AMFS__c = 'Approve & Paid')
                                             ];
                for(Case cc : ComplaintCases){
                    if(ComplaintCase.containsKey(cc.Id)) ComplaintCase.put(cc.Id, cc.MOT__c);
                }
                for(Email_SMS_Log__c EmailLogCheck: listEmail){
                    if(
                        EmailLogCheck.Case__c != null 
                        && EmailLogCheck.Entity__c == 'AMFS' 
                        && EmailLogCheck.Category__c == 'ICF' 
                        && EmailLogCheck.Status__c != 'Send' 
                        && ComplaintCase.containsKey(EmailLogCheck.Case__C)
                        && !System.isFuture()
                    ){
                        emailIdsComplaint.add(EmailLogCheck.id);
                    }
                }
                if (emailIdsComplaint.size() > 0 && !System.isFuture()) { 
                    SurveyICFComplaintFuture.checkSurveyICF(emailIdsComplaint);
                }
            }
            
            //Added by Dimas Support MII 15/05/2025
            If(RequestPOSCase.size() > 0){
                Set<Id> emailIdsRequestPOS = new Set<Id>();
                List <Case> RequestPOSCases = [SELECT Id, ContactId, Type, MOT__c FROM Case WHERE id in : RequestPOSCase.keyset() and Type = 'Request POS'];
                for(Case posc : RequestPOSCases){
                    if(RequestPOSCase.containsKey(posc.Id)) RequestPOSCase.put(posc.Id, posc.MOT__c);
                }
                for(Email_SMS_Log__c EmailLogCheck: listEmail){
                    if(
                        EmailLogCheck.Case__c != null 
                        && EmailLogCheck.Entity__c == 'AMFS' 
                        && EmailLogCheck.Category__c == 'ICF' 
                        && EmailLogCheck.Status__c != 'Send' 
                        && RequestPOSCase.containsKey(EmailLogCheck.Case__C)
                        && !System.isFuture()
                    ){
                        emailIdsRequestPOS.add(EmailLogCheck.id);
                    }
                }
                if (emailIdsRequestPOS.size() > 0 && !System.isFuture()) { 
                    CheckSurveyICFFuture.checkSurveyICF(emailIdsRequestPOS);
                }
            }
            
            If(RequestClaimRejectCase.size() > 0){
                Set<Id> emailIdsRequestClaimReject = new Set<Id>();
                List <Case> RequestClaimRejectCases = [SELECT Id, ContactId, Type, MOT__c FROM Case WHERE id in : RequestClaimRejectCase.keyset() and Type = 'Request_Claim_Payment_Reject'];
                for(Case rcrc : RequestClaimRejectCases){
                    if(RequestClaimRejectCase.containsKey(rcrc.Id)) RequestClaimRejectCase.put(rcrc.Id, rcrc.MOT__c);
                }
                for(Email_SMS_Log__c EmailLogCheck: listEmail){
                    if(
                        EmailLogCheck.Case__c != null 
                        && EmailLogCheck.Entity__c == 'AMFS' 
                        && EmailLogCheck.Category__c == 'ICF' 
                        && EmailLogCheck.Status__c != 'Send' 
                        && RequestClaimRejectCase.containsKey(EmailLogCheck.Case__C)
                        && !System.isFuture()
                    ){
                        emailIdsRequestClaimReject.add(EmailLogCheck.id);
                    }
                }
                if (emailIdsRequestClaimReject.size() > 0 && !System.isFuture()) { 
                    CheckSurveyICFFuture.checkSurveyICF(emailIdsRequestClaimReject);
                }
            }
            
            //for claim reject 
            if (emailrejectclaimIds.size() > 0 && !System.isFuture()) { 
                CreateEmailSMSLogClaimReject.send(emailrejectclaimIds);
            }
        } 
        else if(Trigger.isupdate){ 
            
            Set<id> sendWa = new Set<id>();
            
            for (Email_SMS_Log__c row : trigger.new) {
                Email_SMS_Log__c old = Trigger.oldMap.get(row.Id);
                
                if (row.Entity__c == 'AMFS' && row.status__c == 'Send' && old.get('status__c') == 'Hold' && row.MOT__c != 'I Buy'
                    && row.status__c != old.get('status__c') && !System.isFuture() && !system.isQueueable() && string.isnotblank(row.Mobile__c)) {
                        sendWa.add(row.id);   
                    }
            }
            
            if (!System.Test.IsRunningTest() && sendWa.size() > 0) System.enqueueJob(new SendSurveyICF.sendWhatsapp(sendWa));
            
        } 
    }
}