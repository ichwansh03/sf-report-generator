global class SingleCaseServiceBatchable implements Database.batchable<sObject> {
    
    public List<Case> casesId = new List<Case>();
    
    public SingleCaseServiceBatchable(List<Case> casesId) {
        this.casesId = casesId;
    }
    
    global Iterable<sObject> start(Database.BatchableContext bc) {
        
        DescribeSObjectResult describeResult = Case.getSObjectType().getDescribe();
        List<String> fieldList = new List<String>(describeResult.fields.getMap().keySet());
        String fieldStr = String.join(fieldList, ',');
        String query = ' SELECT ' + fieldStr + ' FROM Case WHERE id =:casesId ORDER BY CaseNumber DESC';
        
        List<Case> cases = Database.query(query);
        system.debug('cases: '+cases);
        return cases;
    }
    
    global void execute(Database.BatchableContext bc, List<Case> cases) {
        system.debug('EXECUTE SINGLE CALL NOTE BATCHABLE');
        
        try {
            Map<String, List<Case>> singleNoteMap = new Map<String, List<Case>>();
            List<Case> submitSingleCase = new List<Case>();
            
            for (Case cse : cases) {
                
                if (!singleNoteMap.containsKey(cse.Policy_Numbers__c) && validateCaseTM(cse)) {
                    singleNoteMap.put(cse.Policy_Numbers__c, new List<Case>()); 
                }
                singleNoteMap.get(cse.Policy_Numbers__c).add(cse);
            }
            
            for (String policy : singleNoteMap.keySet()) {
                List<Case> addCases = singleNoteMap.get(policy);
                submitSingleCase.add(addCases[0]);
            }
            
            Id jobId = System.enqueueJob(new SubmitCaseServiceQueueable(submitSingleCase));
            system.debug('jobId Trigger_CustomizeCase : '+jobId);
            
        } catch (Exception e) {
            system.debug('Error single call note: '+e.getMessage());
        }
    }
    
    public static Boolean validateCaseTM(Case cs) {
        Boolean isCorrespond = false;
        Boolean isInbound = false;
        Boolean isUserCorr = false;
        Boolean isQuickResponse = false;
        Boolean isNotNull = false;
        
        Set<String> allowedUserInbound = new Set<String>();
        Set<String> allowedUserCorrespond = new Set<String>();
        String allowedOriginCorr;
        String allowedOriginInb;
        
        Id conId = cs.ContactId;
        String queryContact = 'SELECT Id, PolicyApp__c FROM Contact WHERE id =:conId';
        Contact ct = Database.query(queryContact);

        if (Test.isRunningTest()) {
            allowedUserInbound = new Set<String>{'Test'};
                allowedUserCorrespond = new Set<String>{'Test'};
            allowedOriginCorr = 'Email,Walk-In';
            allowedOriginInb = 'Phone,Phone-Data Callback';
        } else {
            if (ct.PolicyApp__c == 'DMTM') {
                allowedUserInbound = new Set<String>(BaseCoreServiceController.getValueFilterReport(Label.Report_Inbound_DMTM, 'Case.CreatedBy.Name').split(','));
                allowedUserCorrespond = new Set<String>(BaseCoreServiceController.getValueFilterReport(Label.Report_Correspondence_DMTM, 'Case.CreatedBy.Name').split(','));
                allowedOriginCorr = BaseCoreServiceController.getValueFilterReport(Label.Report_Correspondence_DMTM, 'Case.Origin');
                allowedOriginInb = BaseCoreServiceController.getValueFilterReport(Label.Report_Inbound_DMTM, 'Case.Origin');       
            }
            /*if (ct.PolicyApp__c == 'RLS') {
                allowedUserInbound = new Set<String>(BaseCoreServiceController.getValueFilterReport(Label.Report_Inbound_RLS, 'Case.CreatedBy.Name').split(','));
                allowedUserCorrespond = new Set<String>(BaseCoreServiceController.getValueFilterReport(Label.Report_Correspondence_RLS, 'Case.CreatedBy.Name').split(','));
                allowedOriginCorr = BaseCoreServiceController.getValueFilterReport(Label.Report_Correspondence_RLS, 'Case.Origin');
                allowedOriginInb = BaseCoreServiceController.getValueFilterReport(Label.Report_Inbound_RLS, 'Case.Origin');       
            }*/
        }
                
        isUserCorr = allowedUserCorrespond.contains(cs.Case_Owner_CCC__c.trim());
        isQuickResponse = cs.Department__c == 'Quick Response' && cs.Status == 'Closed';
        isNotNull = cs.Policy_Numbers__c != null && cs.Policy_Numbers__c != 'Anonymous AMFS' && cs.Description != null;
        
        if (((isUserCorr && allowedOriginCorr.contains(cs.Origin)) || isQuickResponse) && isNotNull) {
            system.debug('Trigger_CustomizeCase CHECK CORRESPONDENCE CASE');
            isCorrespond = true;
        }
        
        if ((allowedUserInbound.contains(cs.Case_Owner_CCC__c.trim()) && cs.Case_Owner_CCC__c != null) && allowedOriginInb.contains(cs.Origin) && isNotNull) {
            system.debug('Trigger_CustomizeCase CHECK INBOUND CASE');
            isInbound = true;
        }
        
        return (isCorrespond || isInbound);
    }
    
    global void finish(Database.BatchableContext bc){
        
    }
}