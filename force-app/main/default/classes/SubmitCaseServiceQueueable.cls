/**
 * @description       : Refresh data from CaseAssessmentSubsriber, validate records and mapping to single case inquiry 
 * @author            : Ichwan Sholihin
 * @testClass		  : CustomizeCaseServiceController_Test
**/
public class SubmitCaseServiceQueueable implements Queueable, Database.AllowsCallouts {
    
    private List<Case> cases;
    
    public SubmitCaseServiceQueueable(List<Case> cases) {
        this.cases = [SELECT Id, Policy_Numbers__c, Case_Owner_CCC__c, Department__c, Origin, Status, Contact.PolicyApp__c FROM Case WHERE Id IN :cases];
        system.debug('cases: '+cases);
    }
    
    public void execute(QueueableContext qc) {

        Map<String, Case> singleNoteMap = new Map<String, Case>();
        List<Case> submitSingleCase = new List<Case>();
        
        try {
            for (Case cse : cases) {
                System.debug('[SubmitCaseServiceQueueable] Process Case from Trigger: '+cse);
                
                if (validateCase(cse)) CustomizeCaseServiceController.sendRequest(cse.Id);
            }
            
        } catch (Exception e) {
            system.debug('Error SubmitCaseServiceQueueable: '+e.getMessage());
        }
        
    }
    
    public static Boolean validateCase(Case cse) {
        Boolean isCorrespond = false;
        Boolean isInbound = false;
        Boolean isUserCor = false;
        Boolean isUserInb = false;
        Boolean isOriginCor = false;
        Boolean isOriginInb = false;
        Boolean isQuickResponse = false;
        Boolean isNotNull = false;
        
        String policyApp = cse.Contact.PolicyApp__c;
        system.debug('policyApp: '+policyApp);
        
        if (policyApp == 'DMTM') {
            isUserCor = BaseCoreServiceController.getValueFilterReport('Customize Correspondence Robot(DMTM)', 'Case.CreatedBy.Name').toUpperCase().contains(cse.Case_Owner_CCC__c.toUpperCase().trim());
            isUserInb = BaseCoreServiceController.getValueFilterReport('Customize Inbound Robot(DMTM)', 'Case.CreatedBy.Name').toUpperCase().contains(cse.Case_Owner_CCC__c.toUpperCase().trim());
            isOriginCor = BaseCoreServiceController.getValueFilterReport('Customize Correspondence Robot(DMTM)', 'Case.Origin').contains(cse.Origin);
            isOriginInb = BaseCoreServiceController.getValueFilterReport('Customize Inbound Robot(DMTM)', 'Case.Origin').contains(cse.Origin);    
        } else {
            isUserCor = BaseCoreServiceController.getValueFilterReport('Customize Correspondence Robot', 'Case.CreatedBy.Name').toUpperCase().contains(cse.Case_Owner_CCC__c.toUpperCase().trim());
            isUserInb = BaseCoreServiceController.getValueFilterReport('Customize Inbound Robot (RLS)', 'Case.CreatedBy.Name').toUpperCase().contains(cse.Case_Owner_CCC__c.toUpperCase().trim());
            isOriginCor = BaseCoreServiceController.getValueFilterReport('Customize Correspondence Robot', 'Case.Origin').contains(cse.Origin);
            isOriginInb = BaseCoreServiceController.getValueFilterReport('Customize Inbound Robot (RLS)', 'Case.Origin').contains(cse.Origin);    
        }
        
        isQuickResponse = cse.Department__c == 'Quick Response' && cse.Status == 'Closed';
        isNotNull = cse.Policy_Numbers__c != null && cse.Policy_Numbers__c != 'Anonymous AMFS';
        
        if (((isUserCor && isOriginCor) || isQuickResponse) && isNotNull) {
            system.debug('Trigger_CustomizeCase CHECK CORRESPONDENCE CASE');
            isCorrespond = true;
        }
        
        if ((isUserInb && cse.Case_Owner_CCC__c != null) && isOriginInb && isNotNull) {
            system.debug('Trigger_CustomizeCase CHECK INBOUND CASE');
            isInbound = true;
        }
        
        return (isCorrespond || isInbound);
    }
    
}