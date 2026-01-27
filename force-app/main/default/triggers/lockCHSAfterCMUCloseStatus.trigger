trigger lockCHSAfterCMUCloseStatus on Case (after update) {
    List<Approval.ProcessSubmitRequest> requests = new List<Approval.ProcessSubmitRequest> (); //added by WK, 20150424 to lock the CHS record after CMU change CHS Status to be either Closed-Invalid or Closed-Valid.
    
    for(Case cs : trigger.new){
        Case oldCs = Trigger.oldMap.get(cs.Id);
        if( oldCs.CHS_Status__c != cs.CHS_Status__c && ( cs.CHS_Status__c == 'Closed - Invalid' || cs.CHS_Status__c == 'Closed - Valid') ) {
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Submitted for approval. Please approve.');
            req.setObjectId(cs.Id);
            
            requests.add(req);
        }
    }
    
    if(requests.size()>0){
        Approval.ProcessResult[] processResults = null;
        try {
            processResults = Approval.process(requests, true);
        }catch (System.DmlException e) {
            System.debug('Exception Is ' + e.getMessage());
        }
    }

}