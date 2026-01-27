/****************************************************************************************
 * Controller	: Trigger_setFirstOwner
 * Class 		: Apex Trigger
 * Test Class 	: DistributeNegativeFeedbackTest
 * =====================================================================================
 * ------------------------------------ Log --------------------------------------------
 * ===================================================================================== 
 * MII       	- 20/09/24    	- set first owner tracking
 * **************************************************************************************/

trigger Trigger_setFirstOwner on Call_Line__c (before insert, before update) {    
    // added by Support MII at 20 09 24
    // add tracking first owner
    if (trigger.isBefore) {          
        Boolean checkSurveyAMFS = false;
        
        String RTTeleServiceCallLine =  Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('TeleService').getRecordTypeId();
        for (Call_Line__c row : trigger.new) {
            if (row.recordtypeId == RTTeleServiceCallLine) {
                checkSurveyAMFS = true; 
            }
        }
        if (checkSurveyAMFS == true) {           
            Map<string, String> mapFeedbackCase = new Map<string, String>();
            Map<string, String> mapSurvey = new Map<string, String>();
            List<Survey__c> listSurvey = [Select id, URL__c  from  Survey__c where recordType.Name = 'Master Qualtrics'];
            for (Survey__c row: listSurvey) {
                mapSurvey.put(row.id,row.id);
            }
            
            for (Call_Line__c row : trigger.new) {
                if (String.isnotblank(row.Case__c) && row.Entity__c == 'AMFS' && row.recordtypeid == RTTeleServiceCallLine) {
                    String ownerId = String.valueof(row.ownerid);
                    if (trigger.isupdate && String.isnotblank(ownerId) && ownerId.substring(0, 3) == '005') { 
                        Call_Line__c old = Trigger.oldMap.get(row.Id);
                        if (old.get('OwnerId') != row.owner 
							&& ! System.test.isrunningTest()
                            && String.isnotblank(string.valueof(old.get('OwnerId')))
                            && string.valueof(old.get('OwnerId')).substring(0, 3) == '005'
                           ) {
                         	row.First_Owner__c = old.ownerid;   
                        }
                    }

                }
            }
        }
    }
}