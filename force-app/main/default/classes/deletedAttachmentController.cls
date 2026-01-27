public class deletedAttachmentController {
    //Create by Phincon
    public Map<String, String> objMap {get;set;}
    public deletedAttachmentController(ApexPages.StandardController controller){
        objMap = new Map<String, String>();
        EmailMessage getEM = (EmailMessage) controller.getRecord();
        try{
            EmailMessage eM = [Select id, DeletedAttachmentId__c, DeletedAttachmentName__c from EmailMessage
                            where id =: getEM.Id];
            if(eM.DeletedAttachmentId__c != null){
                String[] eMAttId = eM.DeletedAttachmentId__c.split(';');
                String[] eMAttName = eM.DeletedAttachmentName__c.split(';');
                System.debug('Email Message '+eM + eMAttName);
            	Integer i = eMAttId.size() <= eMAttName.size() ? eMAttId.size() : eMAttName.size();
                if(i > 0){
                    // to track ids size != names size
                    // because an id's length is 19 char.
                    // but name of attachment is dynamic.
                    // related to "attachmentAfterInsert.apxt"
                    if(eMAttId.size() != eMAttName.size()){
                        System.debug('There are some deleted attachment which were not saved!');
                    }
                    for(Integer j=0; j< i; j++){
                        System.debug('deleted Attachment '+eMAttId[j] +eMAttName[j]);
                        objMap.put(eMAttId[j], eMAttName[j]);
                    }
                } else {
                    System.debug('Deleted attachment list is Empty.');
                }
            }
        } catch (Exception E){
            System.debug('===Error when populate deleted attachment==='+e);
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,'There are some deleted attachment which are not displayed!'));
        }
    }
}