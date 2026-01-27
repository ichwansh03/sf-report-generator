trigger Trigger_ContactPolicyTakeout on Contact (after insert) {
    List<Call_Line_Retention__c> listclr = new List<Call_Line_Retention__c>();
    List<Call_Line_Retention__c> listclrtemp = new List<Call_Line_Retention__c>();
    Set<String> mdmid = new Set<String>();
    Set<String> policy = new Set<String>();
    for (Contact c : Trigger.new) {
        if (c.mdmid_owner__c != '') {
            mdmid.add(c.mdmid_owner__c);
            policy.add(c.Policy_No__c);
        }
    }
    
    listclr = [SELECT mdmid_owner__c, Policy_No__c, Remark_Description__c, Retention_Status__c FROM Call_Line_Retention__c WHERE mdmid_owner__c IN :mdmid];
    
    Map<String, Set<String>> mapMdmToPolicy = new Map<String, Set<String>>();
    Map<String, Call_Line_Retention__c> mapMdm = new Map<String, Call_Line_Retention__c>();
    for (Call_Line_Retention__c clr : listclr) {
        if (!mapMdmToPolicy.containsKey(clr.mdmid_owner__c)) {
            mapMdmToPolicy.put(clr.mdmid_owner__c, new Set<String>());
            mapMdm.put(clr.mdmid_owner__c, clr);
        }
        mapMdmToPolicy.get(clr.mdmid_owner__c).add(clr.Policy_No__c);
    }
    
    
    for (Contact c : Trigger.new) {
        System.debug('policy no = '+c.Policy_No__c);
        
        if (mapMdmToPolicy.containsKey(c.mdmid_owner__c) && !mapMdmToPolicy.get(c.mdmid_owner__c).contains(c.Policy_No__c) && !c.mdmid_owner__c.equals('') && c.PolicyApp__c == 'RLS' && c.Entity__c == 'AMFS') {
            Call_Line_Retention__c clr = mapMdm.get(c.mdmid_owner__c);
            //listclr = [SELECT mdmid_owner__c, Policy_No__c, Remark_Description__c, Retention_Status__c FROM Call_Line_Retention__c WHERE mdmid_owner__c = :c.mdmid_owner__c];
            
            Call_Line_Retention__c newclr = new Call_Line_Retention__c();
            newclr.Contact__c = c.Id;
            newclr.Remark_Description__c = clr.Remark_Description__c;
            if (clr.Retention_Status__c.equals('Takeout')){
                newclr.Retention_Status__c = 'Takeout';
                listclrtemp.add(newclr);
            }
            System.debug('new CLR = '+newclr);
        }   
    }
    
    insert listclrtemp;
}