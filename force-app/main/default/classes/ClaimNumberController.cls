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
        cl = [SELECT Id, Name, Policy_No__c, Case_Type__c, Description__c, Entity__c, Claim_Remark__c FROM Call_Line__c WHERE Id = :cl.Id];
        if (cl.Case_Type__c == 'Teleclaim' && cl.Entity__c == 'AMFS') isTeleclaim = true;
        claimWrappers = new List<ClaimWrapper>();
        claimResponses = new List<SelectOption>();
        
        initClaimWrappers(); 
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
            
            /*claimWrappers.clear();
            if (claimWrappers.isEmpty()) claimWrappers.add(new ClaimWrapper(0, '', ''));
            if (!claimResponses.isEmpty()) {
                claimWrappers[0].claimNumber = claimResponses[0].getValue();
            }*/
            if (!claimWrappers.isEmpty() && !claimResponses.isEmpty()) {
                for (ClaimWrapper cw : claimWrappers) {
                    if (String.isBlank(cw.claimNumber)) {
                        cw.claimNumber = claimResponses[0].getValue();
                    }
                }
            }
            
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Error, 'Ada masalah ketika pengambilan data, silakan hubungi admin: '+e));
        }
        
        return null;
    }

    public PageReference onLoad() {
        // hanya ambil claim number utk dropdown
        loadClaimNumbers(false);
        return null;
    }
    
    public void loadClaimNumbers(Boolean overrideEmptyOnly) {
        
        if (String.isBlank(cl.Policy_No__c)) return;
        
        claimResponses.clear();
        
        List<String> claimNumbers = new List<String>();
        
        EIPJson responseClaim = EIPConnector.getClaimDetails(
            EIPConstant.OPERATION_CLAIM,
            EIPConstant.ENTITY_AMFS,
            EIPConstant.APP_DMTM_REST_V3,
            cl.Policy_No__c
        );
        
        for (EIPJson.EIP_AgSa_InsurancePolicy hasPolis : responseClaim.Body.Customer.hasPolicyAccount) {
            if (hasPolis.hasPnCClaimIn != null) {
                for (EIPJson.EIP_PnCClaim_CLAIM claim : hasPolis.hasPnCClaimIn) {
                    if (claim?.claimNumber != null) {
                        claimNumbers.add(claim.claimNumber);
                    }
                }
            }
        }
        
        for (String cn : claimNumbers) {
            claimResponses.add(new SelectOption(cn, cn));
        }
        
        // ⚠️ OPTIONAL: isi default hanya kalau kosong
        if (overrideEmptyOnly && !claimResponses.isEmpty()) {
            for (ClaimWrapper cw : claimWrappers) {
                if (String.isBlank(cw.claimNumber)) {
                    cw.claimNumber = claimResponses[0].getValue();
                }
            }
        }
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
    
    private void initClaimWrappers() {
        claimWrappers = new List<ClaimWrapper>();
        
        // Kalau ada data lama
        if (String.isNotBlank(cl.Claim_Remark__c)) {
            
            List<String> rawClaims = cl.Claim_Remark__c.split('#');
            
            for (String raw : rawClaims) {
                if (String.isBlank(raw)) continue;
                
                List<String> parts = raw.split(';', 2);
                if (parts.size() < 2) continue;
                
                ClaimWrapper cw = new ClaimWrapper();
                cw.claimNumber = parts[0].trim();
                cw.description = parts[1].trim();
                
                claimWrappers.add(cw);
            }
        }
        
        // Kalau tetap kosong (tidak ada data lama)
        if (claimWrappers.isEmpty()) {
            claimWrappers.add(new ClaimWrapper());
        }
        
        refreshIndexes();
    }

    
    private void refreshIndexes() {
        for (Integer i = 0; i < claimWrappers.size(); i++) {
            claimWrappers[i].idx = i;
        }
    }

    
    public PageReference submitSelected() {
        System.debug('=== submitSelected method called ===');
        
        List<String> claimDataList = new List<String>();
        Set<String> uniqueClaims = new Set<String>();
        Boolean hasError = false;
        
        // ===== CASE 1: data dari claimsDataJson (jika ada) =====
        if (String.isNotBlank(claimsDataJson)) {
            
            List<String> claimsArray = claimsDataJson.split('~');
            
            for (String claimPair : claimsArray) {
                if (String.isBlank(claimPair)) {
                    continue;
                }
                
                List<String> parts = claimPair.split('\\|');
                String claimNum = parts.size() > 0 ? parts[0].trim() : '';
                String description = parts.size() > 1 ? parts[1].trim() : '';
                
                // Claim number wajib
                if (String.isBlank(claimNum)) {
                    ApexPages.addMessage(
                        new ApexPages.Message(
                            ApexPages.Severity.ERROR,
                            'Claim number tidak boleh kosong.'
                        )
                    );
                    hasError = true;
                    continue;
                }
                
                // Description wajib
                if (String.isBlank(description)) {
                    ApexPages.addMessage(
                        new ApexPages.Message(
                            ApexPages.Severity.ERROR,
                            'Description wajib diisi untuk claim ' + claimNum
                        )
                    );
                    hasError = true;
                    continue;
                }
                
                // Duplicate check
                if (uniqueClaims.contains(claimNum)) {
                    ApexPages.addMessage(
                        new ApexPages.Message(
                            ApexPages.Severity.ERROR,
                            'Duplicate claim number ditemukan: ' + claimNum
                        )
                    );
                    hasError = true;
                    continue;
                }
                
                uniqueClaims.add(claimNum);
                claimDataList.add('#' + claimNum + ';' + description);
            }
            
        }
        // ===== CASE 2: fallback ke claimWrappers =====
        else {
            
            for (ClaimWrapper cw : claimWrappers) {
                
                // Claim number wajib
                if (String.isBlank(cw.claimNumber)) {
                    ApexPages.addMessage(
                        new ApexPages.Message(
                            ApexPages.Severity.ERROR,
                            'Claim number tidak boleh kosong.'
                        )
                    );
                    hasError = true;
                    continue;
                }
                
                // Description wajib
                if (String.isBlank(cw.description)) {
                    ApexPages.addMessage(
                        new ApexPages.Message(
                            ApexPages.Severity.ERROR,
                            'Description wajib diisi untuk claim ' + cw.claimNumber
                        )
                    );
                    hasError = true;
                    continue;
                }
                
                // Duplicate check
                if (uniqueClaims.contains(cw.claimNumber)) {
                    ApexPages.addMessage(
                        new ApexPages.Message(
                            ApexPages.Severity.ERROR,
                            'Duplicate claim number ditemukan: ' + cw.claimNumber
                        )
                    );
                    hasError = true;
                    continue;
                }
                
                uniqueClaims.add(cw.claimNumber);
                claimDataList.add('#' + cw.claimNumber + ';' + cw.description);
            }
        }
        
        // ===== HENTIKAN PROSES JIKA ADA ERROR =====
        if (hasError) {
            return null;
        }
        
        // ===== SIMPAN DATA =====
        cl.Claim_Remark__c = String.join(claimDataList, '');
        
        try {
            update cl;
            
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.CONFIRM,
                    'Claim berhasil disimpan: ' + String.join(new List<String>(uniqueClaims), ', ')
                )
            );
        } catch (DmlException e) {
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    'Gagal menyimpan claim: ' + e.getMessage()
                )
            );
            return null;
        }
        
        return null;
    }

    
    public class ClaimWrapper {
        public Integer idx {get; set;}
        public String description { get; set; }
        public String claimNumber { get; set; }
        public ClaimWrapper(){}
        public ClaimWrapper(Integer idx, String c, String des) {
            this.idx = idx;
            claimNumber = c;
            description = des;
        }
    }
}