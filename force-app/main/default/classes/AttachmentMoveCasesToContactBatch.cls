public class AttachmentMoveCasesToContactBatch implements Database.Batchable<sObject>{
    
    Integer LIMIT_QUERY;
    Integer YEAR_TO_PROCESS;
    String query;
    
    public AttachmentMoveCasesToContactBatch(Integer limitQuery, Integer yearToProcess){
        LIMIT_QUERY = limitQuery;
        YEAR_TO_PROCESS = yearToProcess;
        // parent id = case id
       // query = 'Select id, contactid, entity__c from Case where CALENDAR_YEAR(CreatedDate) ='+YEAR_TO_PROCESS+' limit '+LIMIT_QUERY;
        query = 'Select id, Body, Name, parentId, description, OwnerId from Attachment where parentId in (select id from Case where Calendar_Year(createdDate) = '+YEAR_TO_PROCESS+') limit '+LIMIT_QUERY+'';
        //String dumy = '00P6F00002SA9ijUAD';
        //query = 'Select id, Body, Name, ParentId, description, OwnerId from Attachment where parentId in (select id from Case where Calendar_Year(createdDate) = '+YEAR_TO_PROCESS+') and id = \'00P6F00002SA9ijUAD\' limit '+LIMIT_QUERY+'';
   
    }
    
    public Database.QueryLocator start(Database.BatchableContext BS){
        return Database.getQueryLocator(query);
    }
    
    // this helper method for checking atachment for cases
    private Map<Id, Case> checkAvaibleAttachment(Set<Id> parentId){
        Map<Id,Case> mapCase = new Map<Id, Case>([Select Id, contactId, entity_backup__c from Case where id =: parentId and CALENDAR_YEAR(createdDate) =:YEAR_TO_PROCESS]);
        return mapCase;
    }
    
    
    public void execute(Database.BatchableContext BS, List<Attachment> oldAttachmentList) {
        Map<ID,Attachment> cases = new Map<ID,Attachment>();
        Set<Id> setParentId = new Set<Id>();
        for(Attachment obj : oldAttachmentList){
            setParentId.add(obj.parentId);
        }
        
        Map<id, Case> mapCase = checkAvaibleAttachment(setParentId);
    
        
        List<Attachment> newAttachmentList = new List<Attachment>();
        system.debug('attachment count : '+oldAttachmentList.size());
        // start manipulate attachment

        for(Attachment att: oldAttachmentList){
            Case caseSingle = MapCase.get(att.ParentId);

            Attachment newAttachment = new Attachment();
            newAttachment.Body = att.Body;
            newAttachment.name = att.name;
            newAttachment.description = att.Id;
            newAttachment.OwnerId = att.OwnerId;

            if(String.isNotBlank(caseSingle.contactid)){
                // move to contact
                System.debug('[?] Contact :'+ caseSingle.contactid);
                newAttachment.parentId = caseSingle.contactid;
            }else{
                // move to contact non customer by entity_backup__c
                if(String.isNotBlank(caseSingle.entity_backup__c)){
                    if(caseSingle.entity_backup__c == 'AMFS'){
                        newAttachment.parentId = System.LABEL.CONTACT_NON_CUSTOMER_AMFS;
                    }else if(caseSingle.entity_backup__c == 'AFI'){
                        newAttachment.parentId = System.LABEL.CONTACT_NON_CUSTOMER_AFI;
                    }else if(caseSingle.entity_backup__c == 'MAGI'){
                        newAttachment.parentId = System.LABEL.CONTACT_NON_CUSTOMER_MAGI;
                    }else if(caseSingle.entity_backup__c == 'AGI'){
                        newAttachment.parentId = System.LABEL.CONTACT_NON_CUSTOMER_AGI;
                    }else if(caseSingle.entity_backup__c == 'ALI'){
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