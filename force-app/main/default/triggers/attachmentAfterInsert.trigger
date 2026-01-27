trigger attachmentAfterInsert on Attachment (after insert) {
    //Create by Phincon
    //to handle duplication on email's attachment under same Case
	List<Attachment> attList = new List<Attachment>();
	Set<ID> deleteAttList = new Set<ID>();
    List<EmailMessage> emList = new List<EmailMessage>();
    List<Case> csList = new List<Case>();
    Map<ID, List<Attachment>> mapCurrCsAtt = new Map<ID, List<Attachment>>();
    Map<ID, List<Attachment>> mapSavedCsAtt = new Map<ID, List<Attachment>>();
	Set<ID> currAttIds = new Set<ID>();
    Map<ID, EmailMessage> mapCurrEM = new Map<ID, EmailMessage>();
    attList.addAll(trigger.new);
    
    
    if(!attList.isEmpty()){
        Set<ID> emIDs = new Set<ID>();
        for(Attachment att : attList){
            emIDS.add(att.ParentId);
            currAttIds.add(att.Id);
        }
        System.debug('current attachment\'s Ids'+currAttIds);
       // get list parent(case) of attachment
       List<EmailMessage> temList = [select id, fromAddress, hasattachment, parentid, parent.casenumber, parent.origin,
                                    (select id, parentid from attachments), DeletedAttachmentId__c, DeletedAttachmentName__c
                  					from emailmessage where id IN :emIDs and parent.origin ='Email'];
        Map<ID,Boolean> tempMap = new Map<ID,Boolean>();
        if(!temList.isEmpty()){
            Set<ID> csIDs = new Set<ID>();
            //to populate attachments after to map based on Case id
            for(EmailMessage em : temList){
                csIDS.add(em.parentid);
                mapCurrEM.put(em.Id, em);
                List<attachment> tempAtts = new List<attachment>();
                for(attachment att : attList){
                    if(em.Id == att.ParentId){
                        tempAtts.add(att);
                        //compare current attachment to each other under same email.
                        for(Attachment currAtt : attList){
                            if(att.Body == currAtt.Body && att.Id != currAtt.Id && tempMap.get(att.Id) == null){
                                deleteAttList.add(currAtt.Id);
                                tempMap.put(currAtt.Id, true);
                                EmailMessage currEm = mapCurrEM.get(currAtt.ParentId);
                                if(currEm != null){
                                    currEm.DeletedAttachmentId__c = (currEm.DeletedAttachmentId__c==null?'': currEm.DeletedAttachmentId__c)
                                        + att.Id+';';
                                    currEm.DeletedAttachmentName__c = (currEm.DeletedAttachmentName__c==null?'': currEm.DeletedAttachmentName__c)
                                        + currAtt.Name+';';
                                }
                            }
                        }
                    }
                }
				mapCurrCsAtt.put(em.ParentId, tempAtts);
            }
            System.debug('current Deleted list id '+deleteAttList);
            //get list email message which has attachment from case
            emList = [select id, parentid from emailmessage
                      where hasattachment = true AND parentid IN :csIDS ];
            List<attachment> savedAttachment = new List<attachment>();
            if(!emList.isEmpty()){
                emIds = new Set<ID>();
                for(EmailMessage em : emList){
                    emIDs.add(em.id);
                }
                //using different soql to retrieve attachment 
                //because Binary fields cannot be selected in join queries
                //add bodyLength for check size validation limit apex heap by Beni R
                savedAttachment = [Select id, parentid, body, bodyLength
                                   from Attachment 
                                   where isdeleted = false and parentid in : emIds and id not in : currAttIds];
                System.debug('savedAttachment '+savedAttachment);
                //populate all saved attachment under case --> emailmessage
                for(EmailMessage em : emList){
                    LIST<Attachment> atts = new LIST<Attachment>();
                    if(mapSavedCsAtt.get(em.ParentId) != null){
                        atts.addAll(mapSavedCsAtt.get(em.ParentId));
                    }
                    for(Attachment att :savedAttachment){
                        if(em.Id == att.ParentId){
                            atts.add(att);
                        }
                    }
                    mapSavedCsAtt.put(em.ParentId, atts);
                }
            }
            if(!mapCurrCsAtt.isEmpty() && !mapSavedCsAtt.isEmpty()){
                for(ID csId : mapCurrCsAtt.keySet()){
                    List<Attachment> currAtts = mapCurrCsAtt.get(csId);
                    List<Attachment> savedAtts = mapSavedCsAtt.get(csId);
                    for(Attachment att : currAtts){
                        for(Attachment svAtt : savedAtts){
                            System.debug('===Loop for check if duplicate attachment under same Case.===');
                            //add check size validation for fix limit apex heap by Beni R
                            Integer totalSize = att.BodyLength + svAtt.BodyLength;
                            System.debug('Total Size :' + totalSize);
                            if (totalSize < 10000000) {
                                String attBody64 = EncodingUtil.Base64Encode(att.Body);
                                String svAttBody64 = EncodingUtil.Base64Encode(svAtt.Body);
                                if(attBody64 == svAttBody64 && att.Id != svAtt.Id){
                                    System.debug('===Add delete attachment to list===' +att);
                                    deleteAttList.add(att.Id);
                                    EmailMessage currEm = mapCurrEM.get(att.ParentId);
                                    if(currEm != null){
                                        currEm.DeletedAttachmentId__c = (currEm.DeletedAttachmentId__c==null?'': currEm.DeletedAttachmentId__c)
                                            + svAtt.Id+';';
                                        currEm.DeletedAttachmentName__c = (currEm.DeletedAttachmentName__c==null?'': currEm.DeletedAttachmentName__c)
                                            + att.Name+';';
                                    }
                                }
                            }                            
                        }
                    }
                }
            }
        }
    }
    if(!deleteAttList.isEmpty()){
        System.debug('===This is duplicate list of attachment which will be deleted===');
        System.debug(deleteAttList);
        System.debug('size '+deleteAttList.size());
        
        delete [select id from Attachment where id in :deleteAttList];
        List<EmailMessage> updateEm = new List<EmailMessage>();
        for(String idEm : mapCurrEM.keySet()){
            if(mapCurrEM.get(idEm) != null){
                updateEm.add(mapCurrEM.get(idEm));
            }
        }
        update(updateEm);
    }
}