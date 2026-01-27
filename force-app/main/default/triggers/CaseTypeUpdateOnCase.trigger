trigger CaseTypeUpdateOnCase on Case (after insert, before update) {
    Set<Id> caseIds = new Set<Id>();
    Set<Id> contactIds = new Set<Id>();
    System.debug('==== On Trigger');
    
    for(Case cs : Trigger.new) {
        if(cs.Id != null) {
            caseIds.add(cs.Id);
        }
    }
	system.debug(' ------CASE ID:'+caseIds);
	/* Map<Id, Case> myCase = new Map<Id, Case> ([Select ID, Case_Type__c, Case_Type_Config__c, ContactId, cust_segmentation__c 
                                               FROM Case WHERE Id IN :caseIds FOR UPDATE]); */
    Map<Id, Case> myCase = new Map<Id, Case> ([Select ID, Case_Type__c, Case_Type_Config__c, ContactId, cust_segmentation__c 
                                               FROM Case WHERE Id IN :caseIds]);
    List<Case> updateCase = new list<Case>();
    
    if(Trigger.isAfter){
        for(Case c : Trigger.new) {
            // auto-populate cust_segmentation
            // update case count on call liner
            // ===Populate contact Id===
            // added by Phincon
            if(myCase.get(c.Id).ContactId != null){
                contactIds.add(myCase.get(c.Id).ContactId);
            }
            
            system.debug('=== Contact Id'+contactIds);
            
            if(c.Id != null && (c.Type == 'Request' || c.Type == 'Inquiry') && myCase.containsKey(c.Id)){
                myCase.get(c.Id).Case_Type__c = c.Case_Type_Config__c;
            }         
            else if(c.Id != null && c.Type == 'Complaint' && myCase.containsKey(c.Id)){
                myCase.get(c.Id).Category__c = c.Category_Config__c;
                myCase.get(c.Id).Nature__c = c.Nature_Config__c;
            }
            
            // add trigger change update by Ranti at 10/19/2021
            // update myCase.get(c.Id);
            
            system.debug('=== Contact Id'+myCase);
            updateCase.add(myCase.get(c.Id));
        }
        
        update updateCase;
        
        // auto-populate cust_segmentation
        // ===get contact datas then set Cust_segmentation to Case===
        // added by Phincon
        Map<Id, Contact> contactDatas = new Map<Id, Contact> ([Select ID, cust_segmentation__c  FROM Contact WHERE Id IN :contactIds]);
        for(Case cs : myCase.values()){
            if(cs.ContactId != null){
                cs.Cust_Segmentation__c = contactDatas.get(cs.ContactId).cust_segmentation__c;
                system.debug('cs massupload? :'+cs.isMassUpload__c);
            }
        }
        
        //update myCase.values();
    }
    
    if(Trigger.isBefore){
        for(Case cs : Trigger.new) {

            // update case count on call liner
            // ===Populate contact Id===
            // added by Phincon
            if(myCase.get(cs.Id).ContactId != null){
                contactIds.add(myCase.get(cs.Id).ContactId);
            }
            
            Case oldCase = Trigger.oldMap.get(cs.Id);
            
            if((cs.Type == 'Request' || cs.Type == 'Inquiry') && cs.Case_Type_Config__c != oldCase.Case_Type_Config__c){
                cs.Case_Type__c = cs.Case_Type_Config__c;
            }
            if(cs.Type == 'Complaint' && cs.Category_Config__c != oldCase.Category_Config__c){
                cs.Category__c = cs.Category_Config__c;
            }
            if(cs.Type == 'Complaint' && cs.Nature_Config__c != oldCase.Nature_Config__c){
                cs.Nature__c = cs.Nature_Config__c;
            }
        }
    }
    
    // to update case open on call liner based on contact id
    if(!contactIds.isEmpty()){
        // TODO update open case count on call liner here.
        RmToolsCall rc = new RmToolsCall();
        rc.populateAndUpdateCallLiner(contactIds);
    }
}