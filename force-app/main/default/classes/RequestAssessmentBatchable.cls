// Use this if you need to process many records
public class RequestAssessmentBatchable implements Database.Batchable<sObject>, Database.AllowsCallouts {
    
    private List<Call_line__c> callLineIds;
    
    public RequestAssessmentBatchable(List<Call_line__c> callLineIds) {
        this.callLineIds = callLineIds;
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Contact_Policy_App__c, Case_Type__c 
            FROM Call_Line__c 
            WHERE Id IN :callLineIds
        ]);
    }
    
    public void execute(Database.BatchableContext bc, List<Call_Line__c> scope) {
        for (Call_Line__c cl : scope) {
            try {
                if(cl.Contact_Policy_App__c == 'DMTM') {
                    CallLineAssesmentServiceTM.requestPolicyTM(cl.Id);       
                }
                
                if (cl.Contact_Policy_App__c == 'RLS') {
                    if (cl.Case_Type__c == 'Welcome Call') {
                        CallLineAssesmentServiceWecall.requestWecall(cl.Id);
                    } else if (cl.Case_Type__c == 'TelUW') {
                        CallLineAssesmentServiceTelUw.requestTelUW(cl.Id);
                    } else {
                        CallLineAssesmentServiceCR.requestPolicyRLS(cl.Id);
                    }
                }
            } catch (Exception e) {
                System.debug('Error processing Call_Line__c ' + cl.Id + ': ' + e.getMessage());
                // Log error to a custom object for tracking
            }
        }
    }
    
    public void finish(Database.BatchableContext bc) {
        // Any post-processing logic
    }
}