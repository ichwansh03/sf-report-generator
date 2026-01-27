public class ClaimNumberController {
    
    public List<ClaimWrapper> claimWrappers { get; set; }
    public List<SelectOption> claimResponses {get; set; }
    public Integer deleteClaim {get; set;}
    public boolean isTeleclaim {get; set;}
    public Call_Line__c cl { get; set; }
    public String claimsDataJson {get; set;}

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
        String savedData = cl.Description__c;
        if (String.isBlank(savedData)) return;
        if (savedData.startsWith('#')) {
            savedData = savedData.substring(1);
        }
        List<String> parts = savedData.split('#');
        Set<String> savedClaimNumbers = new Set<String>();
        
        for (Integer i = 0; i < parts.size(); i += 2) {
            if (i < parts.size()) {
                String claimNum = parts[i];
                String newDesc = '';
                if ((i + 1) < parts.size()) {
                    newDesc = parts[i + 1];
                }
                if (!String.isBlank(claimNum)) {
                    claimWrappers.add(new ClaimWrapper(claimWrappers.size(), claimNum, newDesc));
                    savedClaimNumbers.add(claimNum);
                }
            }
        }
        
        // Add saved claim numbers to claimResponses so they appear in dropdown
        for (String claimNum : savedClaimNumbers) {
            claimResponses.add(new SelectOption(claimNum, claimNum));
        }
    }

    public void submitSelected() {
        System.debug('=== submitSelected method called ===');
        System.debug('claimsDataJson value: ' + claimsDataJson);
        
        List<String> claimDataList = new List<String>();
        Set<String> uniqueClaims = new Set<String>();
        
        // Parse the captured claims data from hidden field
        if (String.isNotBlank(claimsDataJson)) {
            List<String> claimsArray = claimsDataJson.split('~');
            
            for (String claimPair : claimsArray) {
                if (String.isBlank(claimPair)) continue;
                
                List<String> parts = claimPair.split('\\|');
                String claimNum = parts.size() > 0 ? parts[0].trim() : '';
                String description = parts.size() > 1 ? parts[1].trim() : '';
                
                if (String.isBlank(claimNum)) continue;
                
                if (uniqueClaims.contains(claimNum)) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'Duplicate claim numbers in: ' + claimNum));
                    throw new IllegalArgumentException('Duplicate claim number: ' + claimNum);
                }
                
                uniqueClaims.add(claimNum);
                String formattedClaim = '#' + claimNum + '#' + description;
                claimDataList.add(formattedClaim);
            }
        } else {
            // Fallback to claimWrappers if captured data is not available
            for (ClaimWrapper cw : claimWrappers) {
                if (String.isBlank(cw.claimNumber)) continue;
                
                if (uniqueClaims.contains(cw.claimNumber)) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'Duplicate claim numbers in: '+cw.claimNumber));
                    throw new IllegalArgumentException('Duplicate claim number: '+cw.claimNumber);
                }
                
                uniqueClaims.add(cw.claimNumber);
                String formattedClaim = '#' + cw.claimNumber + '#' + (String.isBlank(cw.description) ? '' : cw.description);
                claimDataList.add(formattedClaim);
            }
        }

        String formattedData = String.join(claimDataList, '');
        cl.Description__c = formattedData;
        
        try {
            update cl;
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.CONFIRM, 'Claim numbers saved successfully: ' + String.join(uniqueClaims, ', ')));
        } catch (DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'Error saving claim data: ' + e.getMessage()));
            throw e;
        }
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