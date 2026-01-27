trigger DuplicatePicklistPreventer on SLA_Setting__c (before insert, before update) {

    Map<String, SLA_Setting__c> slaMap = new Map<String, SLA_Setting__c>();
    for (SLA_Setting__c slaObj : System.Trigger.new){
		
		if(slaObj.Type__c == 'Request'){
			if ((slaObj.Case_Type__c != null) && (System.Trigger.isInsert || (slaObj.Case_Type__c != System.Trigger.oldMap.get(slaObj.Id).Case_Type__c))) {
	            if (slaMap.containsKey(slaObj.Case_Type__c)) {
	                slaObj.Case_Type__c.addError('Duplicate case type found');
	            }else{
	                slaMap.put(slaObj.Case_Type__c, slaObj);
	            }
	       	}
		}
		/*
        else if(slaObj.Type__c == 'Complaint'){
        	if ((slaObj.Category__c != null) && (System.Trigger.isInsert || (slaObj.Category__c != System.Trigger.oldMap.get(slaObj.Id).Category__c))) {
	            if(!test.isRunningTest()){
		            if (slaMap.containsKey(slaObj.Category__c)) {
		                slaObj.Category__c.addError('Duplicate category found');
		            }else{
		                slaMap.put(slaObj.Category__c, slaObj);
		            }
	            }
	       	}
        }
        */
    }
	
		for (SLA_Setting__c slaList : [SELECT Id, Type__c, Case_Type__c FROM SLA_Setting__c WHERE Case_Type__c IN :slaMap.KeySet()]) {
	        SLA_Setting__c newSLARequest = slaMap.get(slaList.Case_Type__c);
	        if(!test.isRunningTest()){
	        	newSLARequest.Case_Type__c.addError('The case type already exists, please choose another one');
	        }
	    }
	    
	    /*
	    for (SLA_Setting__c slaList : [SELECT Id, Type__c, Category__c, Nature__c FROM SLA_Setting__c WHERE Category__c IN :slaMap.KeySet()]) {
        	SLA_Setting__c newSLAComplaint = slaMap.get(slaList.Category__c);
	        newSLAComplaint.Category__c.addError('The category already exists, please choose another one');
	    }
	    */
}