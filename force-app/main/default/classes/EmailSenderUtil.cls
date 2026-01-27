public class EmailSenderUtil {
    public static void sendEmail(String emailAddress, String emailBody, String subject){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        List<String> listEmailTo = new List<String>();
        OrgWideEmailAddress owea = [SELECT Id, Address, DisplayName FROM OrgWideEmailAddress WHERE IsAllowAllProfiles = TRUE LIMIT 1];
        
        System.debug('EMAIL ADDRESS: '+emailAddress);
        listEmailTo.add(emailAddress);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setOrgWideEmailAddressId(owea.Id);
        //mail.setToAddresses(listEmailToTest);
        mail.setToAddresses(listEmailTo);
        mail.setSubject(subject);
        System.debug(' EMAIL BODY: '+subject);
        mail.setHtmlBody(emailBody);
        mails.add(mail);
        if(mails.size() > 0 && !Test.isRunningTest()) Messaging.sendEmail(mails);
    }
}