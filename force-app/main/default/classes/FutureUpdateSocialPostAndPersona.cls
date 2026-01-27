global class FutureUpdateSocialPostAndPersona {
	@future
    public static void updateRecord(Id caseId, Id oldContactId) {
        Case c = [SELECT Id, ContactId FROM Case WHERE Id = :caseId LIMIT 1];
        Id contactId = c.ContactId;
        
        
        //--Update all social post under the case where contactId = oldContactId
        List<SocialPost> spoList = [SELECT Id, WhoId, ParentId, PersonaId FROM SocialPost WHERE ParentId = :caseId AND WhoId = :oldContactId];
        Set<Id> personaIdSet = new Set<Id>();
        if(spoList.size() > 0) {
            for(SocialPost spo : spoList) {
                spo.WhoId = contactId;
                personaIdSet.add(spo.PersonaId);
            }
            update spoList;
        }
        
        //--Update all social persona on social post under the case
        if(personaIdSet.size() > 0) {
            List<SocialPersona> speList = [SELECT Id, ParentId FROM SocialPersona WHERE Id IN :personaIdSet];
            if(speList.size() > 0) {
                for(SocialPersona spe : speList) {
                    spe.ParentId = contactId;
                }
                update speList;
            }
        }
    }
}