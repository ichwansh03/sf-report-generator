/**
 * @description       : 
 * @author            : Sugeng Purnomo
 * @group             : 
 * @last modified on  : 08-22-2025
 * @last modified by  : Ahmad Yazid Munif
**/
trigger AMFS_Email2CaseTrigger on Case (before insert, before update) {
    List<AMFS_E2C_Setting__mdt> emailtoCase = AMFS_E2C_Setting__mdt.getAll().values();
    List<String> listEmailAMFS = new List<String>();
    for (AMFS_E2C_Setting__mdt setting : emailtoCase) {
        listEmailAMFS.add(setting.Email_Case__c.toLowerCase());
    }
    System.debug('AMFS: EmailTrigger check Email >>'+listEmailAMFS);
    
    // Trigger untuk auto assignment Case berdasarkan business hours
    // if (Trigger.isBefore && Trigger.isInsert) {
    //     System.debug('AMFS: EmailTrigger Handler Insert is running');
    //     List<Case> filteredEmailMessages = new List<Case>();
    //     for (Case newCase : (List<Case>)Trigger.new) {
    //         System.debug('AMFS: EmailTrigger check Email >>'+newCase.e2cEmailToAddress__c);
    //         System.debug('AMFS: EmailTrigger check SLA Target >>'+newCase.Entity__c +' - '+ newCase.AMFS_SLA_Target__c);
    //         Boolean isRelevantEmailFound = false;
    //         if (newCase.e2cEmailToAddress__c != null) {
    //             List<String> toAddresses = newCase.e2cEmailToAddress__c.split(';');
    //             System.debug('AMFS Trigger : '+toAddresses);
    //             for (String individualEmailAddress : toAddresses) {
    //                 String cleanedEmail = individualEmailAddress.toLowerCase().trim();
    //                 if (listEmailAMFS.contains(cleanedEmail)) {
    //                     isRelevantEmailFound = true;
    //                     break;
    //                 }
    //             }
    //         }
    //         if (isRelevantEmailFound) {
    //             filteredEmailMessages.add(newCase);
    //         }
    //     }

    //     System.debug('####AMFSe3c filteredEmailMessages: ' + filteredEmailMessages.size());
    //     if (!filteredEmailMessages.isEmpty()) {
    //         AMFS_Email2CaseTriggerHandler.handleBeforeInsert(Trigger.new);
    //     }
    // }
    if (Trigger.isBefore && Trigger.isUpdate) {
        System.debug('AMFS: EmailTrigger Handler Update is running');
        List<Case> filteredEmailMessages = new List<Case>();
        for (Case newEmail : (List<Case>)Trigger.new) {
            Boolean isRelevantEmailFound = false;
            if (newEmail.e2cEmailToAddress__c != null) {
                List<String> toAddresses = newEmail.e2cEmailToAddress__c.split(';');
                for (String individualEmailAddress : toAddresses) {
                    String cleanedEmail = individualEmailAddress.toLowerCase().trim();
                    if (listEmailAMFS.contains(cleanedEmail)) {
                        isRelevantEmailFound = true;
                        break;
                    }
                }
            }
            if (isRelevantEmailFound) {
                filteredEmailMessages.add(newEmail);
            }
        }
        
        if (!filteredEmailMessages.isEmpty()) {
            AMFS_Email2CaseTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
        }
    }

    // Trigger untuk auto assignment Case berdasarkan business hours
    if (Trigger.isBefore && Trigger.isInsert) {
        System.debug('AMFS: EmailTrigger Handler Insert is running');
        AMFS_Email2CaseTriggerHandler.handleBeforeInsert(Trigger.new);
    }
    // if (Trigger.isBefore && Trigger.isUpdate) {
    //     System.debug('AMFS: EmailTrigger Handler Update is running');
    //     AMFS_Email2CaseTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
    // }
}