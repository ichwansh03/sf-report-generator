/**
 * Trigger to handle automatic claim data processing when Call_Line__c is saved
 * This ensures claims are processed regardless of how the record is saved
 */
trigger CallLineSaveHandler on Call_Line__c (before update) {
    
    for (Call_Line__c newRecord : Trigger.new) {
        Call_Line__c oldRecord = Trigger.oldMap.get(newRecord.Id);
        
        // Detect if any significant field has changed (indicating a save)
        boolean hasChanges = false;
        
        if (newRecord.Name != oldRecord.Name) hasChanges = true;
        if (newRecord.Policy_No__c != oldRecord.Policy_No__c) hasChanges = true;
        if (newRecord.Case_Type__c != oldRecord.Case_Type__c) hasChanges = true;
        if (newRecord.Entity__c != oldRecord.Entity__c) hasChanges = true;
        if (newRecord.Description__c != oldRecord.Description__c) hasChanges = true;
        
        if (hasChanges && newRecord.Case_Type__c == 'Teleclaim' && newRecord.Entity__c == 'AMFS') {
            System.debug('=== CallLineSaveHandler: Processing claim data ===');
            System.debug('Record ID: ' + newRecord.Id);
            System.debug('Description before: ' + oldRecord.Description__c);
            System.debug('Description after: ' + newRecord.Description__c);
            
            // Validate and format claim data
            processClaimDataFormat(newRecord);
        }
    }
    
    /**
     * Validate and format claim data in Description__c field
     */
    private static void processClaimDataFormat(Call_Line__c record) {
        String claimData = record.Description__c;
        
        if (String.isBlank(claimData)) {
            System.debug('No claim data to process');
            return;
        }
        
        try {
            Set<String> uniqueClaims = new Set<String>();
            List<String> formattedClaims = new List<String>();
            
            // Remove leading # if present
            if (claimData.startsWith('#')) {
                claimData = claimData.substring(1);
            }
            
            // Parse claim pairs
            List<String> parts = claimData.split('#');
            
            for (Integer i = 0; i < parts.size(); i += 2) {
                String claimNum = parts[i].trim();
                String description = '';
                
                if ((i + 1) < parts.size()) {
                    description = parts[i + 1].trim();
                }
                
                if (String.isBlank(claimNum)) {
                    continue;
                }
                
                // Check for duplicates
                if (uniqueClaims.contains(claimNum)) {
                    System.debug('⚠ Duplicate claim found: ' + claimNum);
                    record.addError('Duplicate claim number: ' + claimNum);
                    return;
                }
                
                uniqueClaims.add(claimNum);
                formattedClaims.add('#' + claimNum + '#' + description);
            }
            
            // Reconstruct formatted data
            String formattedData = String.join(formattedClaims, '');
            record.Description__c = formattedData;
            
            System.debug('✓ Claim data processed successfully');
            System.debug('  Claim count: ' + uniqueClaims.size());
            System.debug('  Claims: ' + String.join(uniqueClaims, ', '));
            System.debug('  Formatted data: ' + formattedData);
            
        } catch (Exception e) {
            System.debug('✗ Error processing claim data: ' + e.getMessage());
            record.addError('Error processing claim data: ' + e.getMessage());
        }
    }
}
