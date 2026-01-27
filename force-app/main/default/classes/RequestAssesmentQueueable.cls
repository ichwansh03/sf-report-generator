public class RequestAssesmentQueueable implements Queueable, Database.AllowsCallouts{
    
    private List<Call_Line__c> clineIds;
    
    public RequestAssesmentQueueable(List<Call_Line__c> clineIds) {
        this.clineIds = clineIds;
    }
    
    
    public void execute(QueueableContext qc) {
        
        try {
            for (Call_Line__c cl : clineIds) {
                if(cl.Contact_Policy_App__c == 'DMTM') {
                    system.debug('get transaction call line DMTM: '+cl.Id);
                    CallLineAssesmentServiceTM.requestPolicyTM(cl.Id);       
                }
                
                if (cl.Contact_Policy_App__c == 'RLS') {
                    system.debug('get transaction call line RLS: '+cl);
                    if (cl.Case_Type__c == 'Welcome Call') CallLineAssesmentServiceWecall.requestWecall(cl.Id);
                    else if (cl.Case_Type__c == 'TelUW') CallLineAssesmentServiceTelUw.insertAssesmentTelUW(cl.Id);
                    else if (cl.Activity_Result__c != 'Takeout') CallLineAssesmentServiceCR.insertAssessment(cl.Id);
                }
            }
        } catch (Exception e) {
            system.debug('RequestAssesmentQueueable Error '+e.getMessage());
        }
    }
}