public class AttachmentMoveParentToContactBatch implements Database.Batchable<sObject>{
    
    Integer LIMIT_QUERY;
    Integer YEAR_TO_PROCESS;
    String query;
    
    public AttachmentMoveParentToContactBatch(Integer limitQuery, Integer yearToProcess){
        LIMIT_QUERY = limitQuery;
        YEAR_TO_PROCESS = yearToProcess;
        query = 'Select id, parent.contactid, parentid, parent.entity_backup__c from EmailMessage where CALENDAR_YEAR(CreatedDate) ='+YEAR_TO_PROCESS+' and hasAttachment = true limit '+LIMIT_QUERY;
    }

    
    public Database.QueryLocator start(Database.BatchableContext BS){
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BS, List<EmailMessage> scope) {
        Map<ID,EmailMessage> emails = new Map<ID,EmailMessage>();
        // put map
        for(EmailMessage email : scope){
            emails.put(email.id,email);
        }
        Set<ID> emailId = emails.keySet();
        
        List<Attachment> oldAttachmentList = [Select Id, Body, Name, ParentId, description, OwnerId FROM Attachment WHERE parentid =: emailId];
        List<Attachment> newAttachmentList = new List<Attachment>();
        system.debug('attachment count : '+oldAttachmentList.size());
        
        // start manipulate attachment
        for(Attachment att: oldAttachmentList){
            EmailMessage emailSingle = emails.get(att.ParentId);
            Attachment newAttachment = new Attachment();
            newAttachment.Body = att.Body;
            newAttachment.name = att.name;
            newAttachment.description = att.Id;
            newAttachment.OwnerId = att.OwnerId;
            if(String.isNotBlank(emailSingle.parent.contactid)){
                // move to contact
                newAttachment.parentId = emailSingle.parent.contactid;
            }else{
                // move to contact non customer by entity_backup__c
                if(String.isNotBlank(emailSingle.parent.entity_backup__c)){
                    if(emailSingle.parent.entity_backup__c == 'AMFS'){
                        newAttachment.parentId = System.LABEL.CONTACT_NON_CUSTOMER_AMFS;
                    }else if(emailSingle.parent.entity_backup__c == 'AFI'){
                        newAttachment.parentId = System.LABEL.CONTACT_NON_CUSTOMER_AFI;
                    }else if(emailSingle.parent.entity_backup__c == 'MAGI'){
                        newAttachment.parentId = System.LABEL.CONTACT_NON_CUSTOMER_MAGI;
                    }else if(emailSingle.parent.entity_backup__c == 'AGI'){
                        newAttachment.parentId = System.LABEL.CONTACT_NON_CUSTOMER_AGI;
                    }else if(emailSingle.parent.entity_backup__c == 'ALI'){
                        newAttachment.parentId = System.LABEL.CONTACT_NON_CUSTOMER_ALI;
                    }
                }
            }
            newAttachmentList.add(newAttachment);
        }
        
        insert newAttachmentList;
        delete oldAttachmentList;
    }
    
    public void finish(Database.BatchableContext BS) {
        System.debug('Done');
    }
    
}