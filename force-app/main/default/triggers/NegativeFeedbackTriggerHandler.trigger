/****************************************************************************************
 * Controller	: NegativeFeedbackTriggerHandler
 * Class 		: Apex Trigger
 * Test Class 	: NegativeFeedbackTriggerHandlerTest
 * =====================================================================================
 * ------------------------------------ Log --------------------------------------------
 * ===================================================================================== 
 * MII       	- 11/03/24    	- Related Data Negative Feedback to Case
 * MII       	- 20/09/24    	- remove first owner tracking
 * **************************************************************************************/
trigger NegativeFeedbackTriggerHandler on Negative_Feedback__c (after insert) {
    
    /* if (trigger.isBefore) {          
        List<Group> dataGroup = [SELECT Id, Name FROM Group where name = 'AMFS - Tele Service Queue'];
        if (dataGroup.size() > 0 ){
            Map<string, String> mapFeedbackCase = new Map<string, String>();
            Map<string, String> mapSurvey = new Map<string, String>();
            List<Survey__c> listSurvey = [Select id, URL__c  from  Survey__c where recordType.Name = 'Master Qualtrics'];
            for (Survey__c row: listSurvey) {
                mapSurvey.put(row.id,row.id);
            }
            
            String groupid = dataGroup[0].id;
            
            for (Negative_Feedback__c row : trigger.new) {
                if (String.isnotblank(row.Case__c) && row.Entity__c == 'AMFS' && mapSurvey.containskey(row.Survey_Form__c)) {
                    String ownerId = String.valueof(row.ownerid);
                    if (trigger.isInsert) { 
                        row.ownerid = groupid;
                    } else if (trigger.isupdate && String.isnotblank(ownerId) && ownerId.substring(0, 3) == '005') { 
                        system.debug('##### Masuk distribution');
                        Negative_Feedback__c old = Trigger.oldMap.get(row.Id);
                        system.debug('#### old.get(OwnerId):'+old.get('OwnerId'));
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
    } else */
    if (trigger.isafter && UserInfo.getUserId() != System.Label.User_Id_Public_Site ) {

        Map<string, String> mapFeedbackCase = new Map<string, String>();
        for (Negative_Feedback__c row : trigger.new) {
            if (String.isnotblank(row.Case__c) && row.Entity__c == 'AMFS') {
                mapFeedbackCase.put(row.Case__c, row.Id);
            }
        }
        
        if (mapFeedbackCase.size() > 0) {
            List<Case> updateNegativeFeedback = [Select id, Negative_Feedback__c from Case where id in : mapFeedbackCase.keySet() and ICF_Negative_Feedback__c = true];
            for (Case row: updateNegativeFeedback) {
                row.Negative_Feedback__c = mapFeedbackCase.get(row.Id); 
            }
            
            update updateNegativeFeedback;
        } 
    }
    
}