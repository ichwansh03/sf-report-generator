trigger updateSocialPostAndPersona on Case (after update) {
    for(Case c : Trigger.new) {
        Case oldCase = Trigger.oldMap.get(c.Id);
        Id socialRecordType = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SocialPost').getRecordTypeId();
        Id socialAMFS = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SocialPost-AMFS').getRecordTypeId();
        Id socialAFI = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SocialPost-AFI').getRecordTypeId();
        Id socialAGI = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SocialPost-AGI').getRecordTypeId();
        Id socialMAGI = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SocialPost-MAGI').getRecordTypeId();
        
        System.debug('------DEBUG VALUE-------');
        System.debug('Case RecordType : ' + c.RecordTypeId);
        System.debug('Schema RecordType : ' + socialRecordType);
        System.debug('Case ContactId : ' + c.ContactId);
        System.debug('Old Case ContactId : ' + oldCase.ContactId);
        System.debug('------------------------');
        
        if((c.RecordTypeId == socialRecordType || c.RecordTypeId == socialAMFS || c.RecordTypeId == socialAFI || c.RecordTypeId == socialAGI || c.RecordTypeId == socialMAGI) && c.ContactId != null && oldCase.ContactId != null && (c.ContactId != oldCase.ContactId)) {
            FutureUpdateSocialPostAndPersona.updateRecord(c.Id, oldCase.ContactId);
        }
    }
}