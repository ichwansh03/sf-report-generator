trigger CaseUpdateParent on Case(after insert, after update) {
    
    list<case> casenew = new list<case>();
    
    if (Trigger.isAfter && Trigger.isUpdate) {
    	for (Case tsk : Trigger.new) {    
            IF (tsk.Origin == 'SMART FA') {
                casenew.add(tsk);
            }
        }
    }
     /*
     * SMART FA - CHS Enhancement
     * MII Taufik
     * April, 2021
     */
    
    // 22 Aug, only running, if not future or batch.
    if (!System.isFuture() && !System.isBatch()) 
		if (casenew.size() > 0) CaseComplaintService.syncFACase(casenew, Trigger.oldMap);

/* // inactive Trigger from "4/15/2020 11:22 AM"
	Map<String, String> mapUserDetail = new Map<String, String> (); //for AMFS CCC only
	for (User_Detail__c ud : [SELECT Id, User__c, Subject_Case__c FROM User_Detail__c WHERE Entity__c = 'AMFS' AND Subject_Case__c != NULL]) {
		mapUserDetail.put(ud.Subject_Case__c, ud.User__c);
	}

	List<Call_Line__c > listCl = new List<Call_Line__c>();
	for (Case tsk : Trigger.new) {
        
		string recordtypename = Schema.SObjectType.Case.getRecordTypeInfosById().get(tsk.recordtypeid).getname();

		if (Trigger.isAfter) {
			// Taufik MII, Maret20, if execute by scheduler, not running
			if (!System.isFuture() && !System.isBatch()) {
                if (tsk.ParentId != NULL) TriggerFuture.UpdateParentCase(tsk.id, tsk.ParentId);
            }
/*
			/*
			if (trigger.isInsert && recordtypename != null && recordtypename.contains('AMFS')){
			    String campaignName;
			    String subjectName;
			    Id userId;

			    if (!String.isBlank(tsk.Subject) || !String.isEmpty(tsk.Subject)){
			        if (tsk.Subject.Contains('ILCCDN') || Test.isRunningTest()){
			            campaignName = 'Renewal Reminder';
			            subjectName = 'ILCCDN';
			            userId = mapUserDetail.get(subjectName);
			        }
			        if (tsk.Subject.Contains('ILCCROS') || Test.isRunningTest()){
			            campaignName = 'Renewal Reminder';
			            subjectName = 'ILCCROS';
			            userId = mapUserDetail.get(subjectName);
			        }
			        if (tsk.Subject.Contains('ILCCWS') || Test.isRunningTest()){
			            campaignName = 'Renewal Reminder';
			            subjectName = 'ILCCWS';
			            userId = mapUserDetail.get(subjectName);
			        }
			        if (tsk.Subject.Contains('ILCCYU') || Test.isRunningTest()){
			            campaignName = 'Renewal Reminder';
			            subjectName = 'ILCCYU';
			            userId = mapUserDetail.get(subjectName);
			        }
			        if (tsk.Subject.Contains('ILCCHIK') || Test.isRunningTest()){
			            campaignName = 'Lapse Konven';
			            subjectName = 'ILCCHIK';
			            userId = mapUserDetail.get(subjectName);
			        }
			        if (tsk.Subject.Contains('ILCCKRO') || Test.isRunningTest()){
			            campaignName = 'Lapse Konven';
			            subjectName = 'ILCCKRO';
			            userId = mapUserDetail.get(subjectName);
			        }
			        if (tsk.Subject.Contains('ILCCMAM') || Test.isRunningTest()){
			            campaignName = 'Lapse Konven';
			            subjectName = 'ILCCMAM';
			            userId = mapUserDetail.get(subjectName);
			        }
			        if (tsk.Subject.Contains('ILCCANL') || Test.isRunningTest()){
			            campaignName = 'Lapse Konven';
			            subjectName = 'ILCCANL';
			            userId = mapUserDetail.get(subjectName);
			        }
			        if (tsk.Subject.Contains('ILCCSRA') || Test.isRunningTest()){
			            campaignName = 'Lapse Konven';
			            subjectName = 'ILCCSRA';
			            userId = mapUserDetail.get(subjectName);
			        }
			        if (tsk.Subject.Contains('ILCCSIS') || Test.isRunningTest()){
			            campaignName = 'Lapse Konven';
			            subjectName = 'ILCCSIS';
			            userId = mapUserDetail.get(subjectName);
			        }
			        if (tsk.Subject.Contains('ILCCYS') || Test.isRunningTest()){
			            campaignName = 'Lapse Konven';
			            subjectName = 'ILCCYS';
			            userId = mapUserDetail.get(subjectName);
			        }
			        if (tsk.Subject.Contains('ILCCDEK') || Test.isRunningTest()){
			            campaignName = 'Redemption Konven';
			            subjectName = 'ILCCDEK';
			            userId = mapUserDetail.get(subjectName);
			        }
			        if (tsk.Subject.Contains('ILCCDEY') || Test.isRunningTest()){
			            campaignName = 'Redemption Konven';
			            subjectName = 'ILCCDEY';
			            userId = mapUserDetail.get(subjectName);
			        }
			        if (tsk.Subject.Contains('ILCCINL') || Test.isRunningTest()){
			            campaignName = 'Redemption Konven';
			            subjectName = 'ILCCINL';
			            userId = mapUserDetail.get(subjectName);
			        }
			        if (tsk.Subject.Contains('ILCCTJ') || Test.isRunningTest()){
			            campaignName = 'Redemption Konven';
			            subjectName = 'ILCCTJ';
			            userId = mapUserDetail.get(subjectName);     
			        }
			        if (tsk.Subject.Contains('ILCCEKN') || Test.isRunningTest()){
			            campaignName = 'Redemption Konven';
			            subjectName = 'ILCCEKN';
			            userId = mapUserDetail.get(subjectName);
			        }
			        if (tsk.Subject.Contains('ILCCEPH') || Test.isRunningTest()){
			            campaignName = 'Redemption Konven';
			            subjectName = 'ILCCEPH';
			            userId = mapUserDetail.get(subjectName);
			        }
			        if (tsk.Subject.Contains('ILCCWHB') || Test.isRunningTest()){
			            campaignName = 'Redemption Konven';
			            subjectName = 'ILCCWHB';
			            userId = mapUserDetail.get(subjectName);
			        }
			        if (tsk.Subject.Contains('ILCCKAI') || Test.isRunningTest()){
			            campaignName = 'Redemption Konven';
			            subjectName = 'ILCCKAI';
			            userId = mapUserDetail.get(subjectName);
			        }
			        String filterCampaign = '\'%'+campaignName+'%\'';
			        String query;
			        if (tsk.Policy_Numbers__c == null){

			        }
			        else{
			            query = 'SELECT Id,Policy_No__c,Contact__c,Case__c,Call_List__c,Agent__c,OwnerId,Status_Retry__c FROM Call_Line__c WHERE Campaign_Name__c LIKE '+filterCampaign+' AND Entity__c = \'AMFS\' AND Policy_No__c = \''+tsk.Policy_Numbers__c+'\'';    
			        }
			        system.debug('***QUERY:'+query);
			        List<Call_Line__c> checkCallLine = Database.query(query);
			        if (checkCallLine.size() > 0){ 
			            list<Call_Line__c> toBeUpdateCL = new list<Call_Line__c>();
			            for (Call_Line__c cl : checkCallLine){
			                Call_Line__c updateCl = new Call_Line__c();
			                updateCl.id = cl.Id;
			                updateCl.Status_Retry__c = 'Callback From CCC';
			                updateCl.Agent__c = userId;
			                updateCl.OwnerId = userId;
			                toBeUpdateCL.add(updateCl);
			            }
			            update toBeUpdateCL;
			        }
			        else{
			            query = 'SELECT Id,Call_Line_RecordTypeID__c FROM Call_List__c WHERE Campaign_Name__c LIKE '+filterCampaign+' AND Entity__c = \'AMFS\' ORDER BY CREATEDDATE DESC LIMIT 1';
			            if (Test.isRunningTest()) {
			            	query = 'SELECT Id,Call_Line_RecordTypeID__c FROM Call_List__c WHERE Entity__c = \'AMFS\' LIMIT 1';
			                userId = userInfo.getUserId();
			            }
			            if (campaignName != NULL){
			            	Call_List__c cpn = Database.query(query);
			                Call_Line__c insertCl = new Call_Line__c();
			                insertCl.RecordTypeId = cpn.Call_Line_RecordTypeID__c;
			                insertCl.Contact__c = tsk.ContactId;
			                if (cpn != null) insertCl.Call_List__c = cpn.Id; 
			                if (tsk.ContactId != null) insertCl.Contact__c = tsk.ContactId;
			                if (tsk.Policy_Number__c != null) insertCl.Policy_No__c = tsk.Policy_Number__c; 
			                insertCl.Case__c = tsk.Id;
			                insertCl.Status_Retry__c = 'Callback From CCC';
			                insertCl.Agent__c = userId;
			                insertCl.OwnerId = userId;
			                insert insertCl;   
			            }
			        }    
			    }
			}*/
/*
		}
	} // end for
*/
} // end trigger