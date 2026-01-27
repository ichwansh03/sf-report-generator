public class EmailAutoReply {   
  //capture the user id
    public ID caseID {get; set;}
    //public Email_SMS_Template__c emailTemplate = new Email_SMS_Template__c();
    public Case emailTemplate = new Case();

    public Case getEmailTemplate() {
        //emailTemplate = [SELECT Id, Name, Email_Header__c, Email_Body__c, Email_Footer__c, Category__c, Entity__c, CreatedDate FROM Case WHERE Id =: idEmailTemplate];        
        emailTemplate = [SELECT Id, CaseNumber, Email_Text_Holiday_Weekend__c, Entity_Backup__c, CreatedDate FROM Case WHERE Id =: caseID];        
        return emailTemplate;
    }
}