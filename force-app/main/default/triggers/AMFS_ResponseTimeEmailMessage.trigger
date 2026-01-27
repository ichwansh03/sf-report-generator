/**
 * @description       : Trigger after insert Email Message
 * @author            : Ahmad Yazid Munif
 * @group             : 
 * @last modified on  : 08-21-2025
 * @last modified by  : Ahmad Yazid Munif
**/
trigger AMFS_ResponseTimeEmailMessage on EmailMessage (after insert) {
    List<AMFS_E2C_Setting__mdt> emailtoCase = AMFS_E2C_Setting__mdt.getAll().values();
    List<String> listEmailAMFS = new List<String>();
    for (AMFS_E2C_Setting__mdt setting : emailtoCase) {
        listEmailAMFS.add(setting.Email_Case__c.toLowerCase());
    }
    System.debug('AMFS Trigger : listEmailAMFS '+listEmailAMFS);
    
    if (Trigger.isAfter && Trigger.isInsert) {
        System.debug('AMFS Trigger : After Insert Email Message');
        List<EmailMessage> filteredEmailMessages = new List<EmailMessage>();
        for (EmailMessage newEmail : (List<EmailMessage>)Trigger.new) {
            Boolean isRelevantEmailFound = false;
            if (newEmail.ToAddress != null) {
                List<String> toAddresses = newEmail.ToAddress.split(';');
                for (String individualEmailAddress : toAddresses) {
                    System.debug('AMFS Trigger : After Insert Email Message '+toAddresses);
                    String cleanedEmail = individualEmailAddress.toLowerCase().trim();
                    if (listEmailAMFS.contains(cleanedEmail)) {
                        isRelevantEmailFound = true;
                        break;
                    }
                }
            }
            if (!isRelevantEmailFound && newEmail.FromAddress != null) {
                String cleanedFromAddress = newEmail.FromAddress.toLowerCase().trim();
                if (listEmailAMFS.contains(cleanedFromAddress)) {
                    isRelevantEmailFound = true;
                }
            }
            if(isRelevantEmailFound) {
                filteredEmailMessages.add(newEmail);
            }
        }
        
        if (!filteredEmailMessages.isEmpty()) {
            AMFS_EmailMessageTriggerHandler.onAfterInsertAndUpdate(filteredEmailMessages);
        }
    }
    // if (Trigger.isAfter) {
    //     if (Trigger.isInsert) {
    //         System.debug('AMFS Trigger : After Insert Email Message');

    //         AMFS_EmailMessageTriggerHandler.onAfterInsertAndUpdate(Trigger.new);
    //     }
    // }
}