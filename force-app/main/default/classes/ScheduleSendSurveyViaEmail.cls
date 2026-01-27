global class ScheduleSendSurveyViaEmail implements Schedulable, Database.Batchable<sObject>{
    global void execute(SchedulableContext sc) { 
        // To start the batch job: 
        Database.executeBatch(new ScheduleSendSurveyViaEmail(), 200);
    }
    
    public Iterable<sObject> start(Database.BatchableContext context){ 
        
        
        List<Id> surveyIds = new List<Id>();
        List<Survey__c> getListSurvey = [Select id from Survey__c where recordType.name = 'Master Qualtrics'];
        for (survey__c row : getListSurvey) {
            surveyIds.add(row.id);
        }
        
        List<Email_sms_log__c> listEmail = new List<Email_sms_log__c>();
        if (System.test.isRunningtest()) {
            listEmail = [
                SELECT Id, Email__c, Email_SMS_Template__c, Email_Text__c, Method__c,
                Status__c, Send_Flag__c 
                FROM Email_sms_log__c
            ]; 
        } else {
            listEmail = [
                SELECT Id, Email__c, Email_SMS_Template__c, Email_Text__c, Method__c,
                Status__c, Send_Flag__c, MOT_in_Email__c
                FROM Email_sms_log__c
                WHERE entity__c = 'AMFS' AND Category__c = 'ICF'  AND case__c != null 
                AND case__r.isSurvey__c = false 
                and survey__c != null
                and Email__c != null
                and survey__c in :surveyIds
                AND Case__r.MOT__c != null AND method__c = 'Whatsapp'
                AND Start_Date__c >= last_n_days:4
                AND Start_Date__c < today
                // AND createddate = today
                AND Email_SMS_Template__c != null
                AND (
                    (status__c = 'Draft' AND Send_Flag__c = false) 
                    OR (status__c = 'Send')
                )
            ];
        }
        
        return listEmail;
    }
    
    public void execute(Database.BatchableContext context, List<Email_sms_log__c> scope) {
        if (scope.size() > 0) {
            
            OrgWideEmailAddress owea = [SELECT Id, Address, DisplayName FROM OrgWideEmailAddress WHERE Address = :Label.EmailNoReplayAMFS limit 1];
            
            map<string, string> mapEmailTemplate = new map<string, string>(); 
            for (Email_sms_log__c row: scope) { 
                mapEmailTemplate.put(row.Email_SMS_Template__c, '');
            }
            List<Email_SMS_Template__c> SubjectEmail = [SELECT Id, Subject__c FROM Email_SMS_Template__c WHERE id in : mapEmailTemplate.keyset()];
            for(Email_SMS_Template__c emailTemplate: SubjectEmail){
                mapEmailTemplate.put(emailTemplate.Id, emailTemplate.Subject__c ); 
            }
            
            for (Email_sms_log__c row: scope) {  
                CheckSurveyICFFuture.sendMail(row, owea, mapEmailTemplate); 
                row.Method__c = 'Email';
                row.Status__c = 'Send';
                row.Send_Flag__c = true;
                row.End_Date__c = system.today();
            } 
            update scope; 
        }
    }
    
    public void finish(Database.BatchableContext context)  {
        
    }
}