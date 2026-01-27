global class ReviewContactSendSurveyBatching implements Database.batchable<sObject> {
    private final datetime currDatetime = System.Now();
    public List<string> contactIds = new List<String>();
    
    Public ReviewContactSendSurveyBatching(List<String> contactIds) {
        this.contactIds = contactIds;
    }
    
    global Iterable<sObject> start(Database.BatchableContext bc){
        List<Contact> data = [Select id, New_Customer_Onboarding__c from contact where id in:contactIds];
        return data;
    }
    
    global void execute(Database.BatchableContext BC, List<Contact> data){
        Set<Id> idContact = new Set<Id>();
        for (Contact row: data) {
            if(row.New_Customer_Onboarding__c){
                idContact.add(row.id);
            }else{
                if (!System.Test.isRunningTest()) CheckSurveyICFFuture.sendSurveyViaWhatsapp(row.id);
            }
        }
        if(idContact.size() > 0){
            CreateEmailSMSLogNewCust.sendSurveyNewCustomer(idContact);
        }
    }


    global void finish(Database.BatchableContext BC){
        
    }
  
}