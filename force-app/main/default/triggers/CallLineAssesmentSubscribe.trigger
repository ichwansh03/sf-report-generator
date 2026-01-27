trigger CallLineAssesmentSubscribe on Assessment_Call_Line__e (after insert) {

    List<Call_Line__c> clines = new List<Call_Line__c>();
    
    for (Assessment_Call_Line__e acl : Trigger.new) {
        Call_Line__c cl = new Call_Line__c();
        cl.Id = acl.Call_Line_ID__c;
        clines.add(cl);
    }
    
    List<Call_Line__c> callLines = [
        SELECT Id, Contact_Policy_App__c, Case_Type__c, Activity_Result__c 
        FROM Call_Line__c 
        WHERE Id IN :clines
    ];

    if (callLines.size() > 0) System.enqueueJob(new RequestAssesmentQueueable(callLines));
}