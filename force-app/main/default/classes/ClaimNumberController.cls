public class ClaimNumberController {
    
    public List<ClaimWrapper> claimWrappers { get; set; }
    public List<SelectOption> claimResponses {get; set; }
    public Integer deleteClaim {get; set;}
    public boolean isTeleclaim {get; set;}
    public Call_Line__c cl { get; set; }

    public ClaimNumberController(ApexPages.StandardController pages) {
        isTeleclaim = false;
        claimWrappers = new List<ClaimWrapper>();
        claimResponses = new List<SelectOption>();
        
        cl = (Call_Line__c) pages.getRecord();
        cl = [SELECT Id, Name, Policy_No__c, Case_Type__c, Description__c, Entity__c FROM Call_Line__c WHERE Id = :cl.Id];
        if (cl.Case_Type__c == 'Teleclaim' && cl.Entity__c == 'AMFS') isTeleclaim = true;
        populateSavedClaims();
        if (claimWrappers.isEmpty()) claimWrappers.add(new ClaimWrapper(0,'',''));
    }

    public PageReference getClaimNumber() {
        if (String.isBlank(cl.Policy_No__c)) return null;

        system.debug('policy no: '+cl.Policy_No__c);
        
        try {
            
            claimResponses.clear();
            List<String> claimNumbers = new List<String>();
            
            EIPJson responseClaim = EIPConnector.getClaimDetails(
                EIPConstant.OPERATION_CLAIM,
                EIPConstant.ENTITY_AMFS,
                EIPConstant.APP_DMTM_REST_V3,
                cl.Policy_No__c
            );
            system.debug('response claim: '+responseClaim);
            for (EIPJson.EIP_AgSa_InsurancePolicy hasPolis : responseClaim.Body.Customer.hasPolicyAccount) {
                if (hasPolis.hasPnCClaimIn != null) {
                    for (EIPJson.EIP_PnCClaim_CLAIM claim : hasPolis.hasPnCClaimIn) {
                        if (claim != null && claim.claimNumber != null) {
                            system.debug('claim number get');
                            claimNumbers.add(claim.claimNumber);
                            //claimWrappers.add(new ClaimWrapper(claim.claimNumber,''));
                        }
                    }
                }
            }
            
            for (String cn : claimNumbers) {
                claimResponses.add(new SelectOption(cn, cn));
            }
            
            claimWrappers.clear();
            if (claimWrappers.isEmpty()) claimWrappers.add(new ClaimWrapper(0, '', ''));
            if (!claimResponses.isEmpty()) {
                claimWrappers[0].claimNumber = claimResponses[0].getValue();
            }
            
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Error, 'Ada masalah ketika pengambilan data, silakan hubungi admin: '+e));
        }
        
        return null;
    }
    
    public void addClaimRow() {
        if (claimResponses == null || claimResponses.isEmpty()) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'No claim numbers available.'));
            return;
        }
        Integer available = claimResponses.size();
        Integer current = claimWrappers.size();
        
        if (current < available) {
            claimWrappers.add(new ClaimWrapper(current, '', ''));
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'All available claim numbers have been added.'));
        }
    }
    
    public void removeClaimRow() {
        if (claimWrappers.size() > 1 && deleteClaim != null) {
            claimWrappers.remove(deleteClaim);
            for (Integer i = 0; i < claimWrappers.size(); i++) {
                claimWrappers[i].idx = i;
            }
        }
    }
    
    private void populateSavedClaims() {
        if (String.isBlank(cl.Description__c)) return;
        
        List<String> savedClaims = cl.Description__c.split(';');
        
        for (String claimData : savedClaims) {
            if (String.isBlank(claimData)) continue;
            
            List<String> parts = claimData.split('#');
            String savedClaimNum = parts[0];
            String savedDesc = parts.size() > 1 ? parts[1] : '';
            
            for (ClaimWrapper cw : claimWrappers) {
                if (cw.claimNumber == savedClaimNum) {
                    
                    cw.description = savedDesc;
                    break;
                }
            }
        }
    }

    public void submitSelected() {
        List<String> selectedClaims = new List<String>();
        Set<String> uniqueClaims = new Set<String>();
        for (ClaimWrapper cw : claimWrappers) {
            if (uniqueClaims.contains(cw.claimNumber)) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'Duplicate claim numbers in: '+cw.claimNumber));
                throw new IllegalArgumentException('Duplicate claim number: '+cw.claimNumber);
            }
            uniqueClaims.add(cw.claimNumber);
            selectedClaims.add(cw.claimNumber);
            //if (cw.selected) selectedClaims.add(cw.claimNumber+'#'+cw.description);
        }

        cl.Description__c = String.join(selectedClaims,';');
        update cl;
        ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.CONFIRM, 'Selected: ' + String.join(selectedClaims, ', ')));
    }
    
    public class ClaimWrapper {
        public Integer idx {get; set;}
        public String description { get; set; }
        public String claimNumber { get; set; }
        public ClaimWrapper(Integer idx, String c, String des) {
            this.idx = idx;
            claimNumber = c;
            description = des;
        }
    }
}