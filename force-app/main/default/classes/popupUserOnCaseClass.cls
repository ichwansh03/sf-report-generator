public class popupUserOnCaseClass {
    public Case currentCase {get; set;}
    public String primaryTabId {get; set;}
    public Case_Internal_Comment__c cic {get; set;}
    public String tempNamedUser {get; set;}
    
    public popupUserOnCaseClass(ApexPages.StandardController controller) {
        currentCase = (Case) controller.getRecord();
        primaryTabId = ApexPages.currentPage().getParameters().get('pTabId');
        System.debug('primaryTabId : ' + primaryTabId);
        
        cic = new Case_Internal_Comment__c();
    }
    
    public PageReference updateCase() {
        List<Case> flagCase;
        if(cic.Named_User__c != null) {
            Named_User__c nu = [SELECT Id, Name, Department__c, Department__r.Name FROM Named_User__c WHERE Id = :cic.Named_User__c LIMIT 1];
            currentCase.Named_User__c = nu.Name;
            currentCase.Division__c = nu.Department__r.name; //nu.Division__c; // taufik, 19 Jan 2019
            
            flagCase = [SELECT Id, OwnerId, Named_User__c FROM Case WHERE Id = :currentCase.Id AND OwnerId = :currentCase.OwnerId AND Named_User__c = :nu.Name];
            System.debug('Case Id : ' + currentCase.Id);
            System.debug('Case Owner Id : ' + currentCase.OwnerId);
            System.debug('CIC Name : ' + nu.Name);
            
            // Taufik, 29 April 2021, Update First Response
            list<CaseMilestone> CM = [SELECT Id, CaseId, CompletionDate, MilestoneTypeId FROM CaseMilestone
			WHERE CaseId =: currentCase.Id and MilestoneTypeId =: label.AMFS_First_Response and CompletionDate = NULL limit 1]; //5575D00000003MD
            if (CM.size() > 0) {
                CM[0].CompletionDate = datetime.now();
                
                update CM;
            }
            
        } else {
            cic.Named_User__c.addError('Select user cannot be empty!');
            return null;
        }

        if(flagCase.size() == 0) {
            currentCase.OwnerId = UserInfo.getUserId();
            update currentCase;
            return new PageReference('javascript:window.close()');
        } else {
            cic.Named_User__c.addError('Named User already accepted the case!');
            return null;
        }
    }
}