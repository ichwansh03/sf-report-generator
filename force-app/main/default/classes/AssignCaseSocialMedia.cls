global class AssignCaseSocialMedia {
    webservice static boolean assign(Id CaseId, String Entity, String Origin) {
        boolean result = false;
        
        if(CaseId != null && Entity != null) {
            try {
                String contactName = 'Anonymous ' + Entity;
                String accountName = 'Account ' + Entity;
                String queueName = Entity + ' ' + Origin + ' Queue';
                String recTypeCase = 'SocialPost-' + Entity;
                
            	Case CurrentCase = [SELECT Id, OwnerId, ContactId, AccountId, Entity_Backup__c FROM Case WHERE Id = :CaseId LIMIT 1];
            	Contact targetContact = [SELECT Id, Name FROM Contact WHERE Name = :contactName LIMIT 1];
                Account targetAccount = [SELECT Id, Name FROM Account WHERE Name = :accountName LIMIT 1];
                Group targetOwner = [SELECT Id, Name FROM Group WHERE Name = :queueName LIMIT 1];
                RecordType targetRecType = [SELECT Id, Name FROM RecordType WHERE Name = :recTypeCase LIMIT 1];
                
                CurrentCase.ContactId = targetContact.Id;
                CurrentCase.AccountId = targetAccount.Id;
            	CurrentCase.OwnerId = targetOwner.Id;
                CurrentCase.RecordTypeId = targetRecType.Id;
                CurrentCase.Entity_Backup__c = Entity;
                
                update CurrentCase;
            	result = true;
            } catch (Exception e) {
                result = false;
            }
        }
        return result;
    }
}