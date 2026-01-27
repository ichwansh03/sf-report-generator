public class EmailMessageHistoryController {
    public Case cs;
    public EmailMessage eMessage {get; set;}
    
	public EmailMessageHistoryController(ApexPages.StandardController controller) {
        cs = (Case)controller.getRecord();
        system.debug('Record Case: '+cs);
        
        eMessage = [SELECT Id, ParentId, Subject, TextBody, FromAddress, ToAddress, MessageDate FROM EmailMessage WHERE ParentId =: cs.Id ORDER BY MessageDate DESC LIMIT 1];
    }
}