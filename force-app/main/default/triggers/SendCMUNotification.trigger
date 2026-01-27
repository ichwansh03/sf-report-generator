/*--------------------------------------------------------------------
 * Trigger Send Email CMU 
 * Trigger 		: Email & SMS Log
 * Test Class   : SendCMUNotificationTest
 * Log
 * -------------------------------------------------------------------
 * 		Author		|     Modified  	| 			Description
 * 	Support MII		|	02 12 24		| create trigger, send email when accept case
*/
trigger SendCMUNotification on Email_SMS_Log__c (after insert) {
	Map<String, Email_SMS_Log__c> mapEmailLog = new  Map<String, Email_SMS_Log__c>();
    
    for (Email_SMS_Log__c row: trigger.new) {
        if (
            row.entity__c == 'AFI'
            && row.Category__c == 'Reminder CMU'
        ) mapEmailLog.put(row.id, row);
    }
    
    if (mapEmailLog.size() > 0) {          
        String labelEmailTemplateClosedCase = System.label.AFI_CMU_Closed_Case;
        String labelEmailTemplateAcceptCase = System.label.AFI_CMU_Accept_Case;
        List<Email_SMS_Template__c> getEmailTemplate = [SELECT id, Name, Subject__c, Email_Header__c, Email_Body__c, Email_Footer__c, Entity__c
                                          FROM Email_SMS_Template__c WHERE Category__c = 'Reminder CMU' AND ( Name =: labelEmailTemplateAcceptCase OR Name =: labelEmailTemplateClosedCase)];
         
        if (getEmailTemplate.size() > 0) { 
            List<Messaging.SingleEmailMessage> sendmails = new List<Messaging.SingleEmailMessage>();
            
            map<string,Email_SMS_Template__c> setMapTemplate = new map<string,Email_SMS_Template__c>();
            for (Email_SMS_Template__c et : getEmailTemplate) { 
                setMapTemplate.put(et.id, et);
            }
            
            for (String row : mapEmailLog.keySet()) {
                Email_SMS_Log__c detail = mapEmailLog.get(row);
                
                if (setMapTemplate.containskey(detail.Email_SMS_Template__c)) {
                    Email_SMS_Template__c emailTemplate = setMapTemplate.get(detail.Email_SMS_Template__c);
                    if (detail.Email_SMS_Template__c == emailTemplate.id) { 
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        
                        // process the merge fields
                        String subject = emailTemplate.Subject__c; 
                        String htmlBody = detail.email_text__c;
                        
                        String sender = id.valueof(system.label.EmailOWE_AFI); 
                        list<string> receipt = new list<string>();
                        receipt.add(detail.Email__c);
                        mail.setOrgWideEmailAddressId(sender);
                        mail.setToAddresses(receipt);
                        
                        mail.setSubject(subject);
                        mail.setHtmlBody(htmlBody);
                        
                        sendmails.add(mail);
                    } 
                }
                
            }
            
            
            if (sendmails.size() > 0) Messaging.sendEmail(sendmails);
        }
    }
}