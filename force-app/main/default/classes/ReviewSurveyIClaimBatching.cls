global class ReviewSurveyIClaimBatching implements Database.batchable<sObject> {
    private final datetime currDatetime = System.Now();
    public List<string> contactIds = new List<String>();
    
    Public ReviewSurveyIClaimBatching(List<String> contactIds) {
        this.contactIds = contactIds;
    }
    
    global Iterable<sObject> start(Database.BatchableContext bc){
        List<Contact> data = [Select id from contact where id in:contactIds];
        return data;
    }
    
    global void execute(Database.BatchableContext BC, List<Contact> data){
        Set<Id> idContact = new Set<Id>();
        for (Contact row: data) {
            idContact.add(row.id);
        }
        if (!System.Test.IsRunningTest()) System.enqueueJob(new CreateEmailSMSLogNewCust.CreateEmailSMSLog(idContact, 'Update'));
    }
    
    
    global void finish(Database.BatchableContext BC){
        
    }
    
}