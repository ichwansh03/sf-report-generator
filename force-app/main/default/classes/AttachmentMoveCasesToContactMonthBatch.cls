public class AttachmentMoveCasesToContactMonthBatch implements Database.Batchable<sObject>{
    
    Integer LIMIT_QUERY;
    Integer YEAR_TO_PROCESS;
    Integer START_MONTH_TO_PROCESS;
    Integer END_MONTH_TO_PROCESS;
    String query;
    
    public AttachmentMoveCasesToContactMonthBatch(Integer limitQuery, Integer yearToProcess, Integer startMonth, Integer endMonth){
        LIMIT_QUERY = limitQuery;
        YEAR_TO_PROCESS = yearToProcess;
        START_MONTH_TO_PROCESS = startMonth;
        END_MONTH_TO_PROCESS = endMonth;
        query = 'Select id, Body, Name, parentId, description, OwnerId from Attachment where parentId in (select id from Case where Calendar_Year(createdDate) = '+YEAR_TO_PROCESS+' and Calendar_Month(createdDate) >= '+START_MONTH_TO_PROCESS+' and Calendar_Month(createdDate) <= '+END_MONTH_TO_PROCESS+') limit '+LIMIT_QUERY+'';
    }
    
    public Database.QueryLocator start(Database.BatchableContext bs){
        return Database.getQueryLocator(query);
    }
    
    // this helper method for checking atachment for cases
    private Map<Id, Case> checkAvaibleAttachment(Set<Id> parentId){
        Map<Id,Case> mapCase = new Map<Id, Case>([Select Id, contactId, entity_backup__c from Case where id =: parentId and CALENDAR_YEAR(createdDate) =:YEAR_TO_PROCESS and CALENDAR_MONTH(createdDate) >= :START_MONTH_TO_PROCESS and CALENDAR_MONTH(createdDate) <= :END_MONTH_TO_PROCESS]);
        return mapCase;
    }
    
    
    public void execute(Database.BatchableContext bs, List<Attachment> oldAttachmentList) {
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
			
			String pId = getParentId(caseSingle);
			newAttachment.parentId = pId;
            
            newAttachmentList.add(newAttachment);
        }
        
        insert newAttachmentList;
        delete oldAttachmentList;
        
        
    }
	
	public String getParentId(Case caseSingle) {
        String pId;
		if(String.isNotBlank(caseSingle.contactid)){
            System.debug('[?] Contact :'+ caseSingle.contactid);
            pId = caseSingle.contactid;
        }else{
            // move to contact non customer by entity_backup__c
            if(String.isNotBlank(caseSingle.entity_backup__c)){
                if(caseSingle.entity_backup__c == 'AMFS'){
                    pId = System.LABEL.CONTACT_NON_CUSTOMER_AMFS;
                }else if(caseSingle.entity_backup__c == 'AFI'){
                    pId = System.LABEL.CONTACT_NON_CUSTOMER_AFI;
                }else if(caseSingle.entity_backup__c == 'MAGI'){
                    pId = System.LABEL.CONTACT_NON_CUSTOMER_MAGI;
                }else if(caseSingle.entity_backup__c == 'AGI'){
                    pId = System.LABEL.CONTACT_NON_CUSTOMER_AGI;
                }else if(caseSingle.entity_backup__c == 'ALI'){
                    pId = System.LABEL.CONTACT_NON_CUSTOMER_ALI;
                }
            }
        }
        return pId;
	}
    
    public void finish(Database.BatchableContext bs) {
        System.debug('Done');
    }
    
}