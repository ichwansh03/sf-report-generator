trigger EmailAssignmentAutoNumber on Email_Assignment__c (before insert) {
    //Sets to store values to be checked for duplicates
    set<String> inboxId = new set<String>();
    
    for(Email_Assignment__c ea : Trigger.new){
        if(ea.Inbox__c != null){
            inboxId.add(ea.Inbox__c);
        }
    }
    
    //String queryString = 'SELECT ID, Inbox__c, Order__c FROM Email_Assignment__c WHERE Inbox__c IN :inboxId' ;
    
    List<Email_Assignment__c> existingEmailAssignment = new List<Email_Assignment__c>([SELECT ID, Inbox__c, Order__c FROM Email_Assignment__c WHERE Inbox__c IN :inboxId order by Order__c desc LIMIT 1]);
    
    //existingEmailAssignment = database.query(queryString);

    if(existingEmailAssignment.size() > 0){
        for(Email_Assignment__c newEmailAssign : trigger.new){
            for(Email_Assignment__c exisitingEmailAssign : existingEmailAssignment){
                if((newEmailAssign.Inbox__c == exisitingEmailAssign.Inbox__c)){
                    newEmailAssign.Order__c = exisitingEmailAssign.Order__c + 1;
                }
            }
        }
    }
    if(existingEmailAssignment.size() == 0){
        for(Email_Assignment__c newAssign : trigger.new){
            newAssign.Order__c = newAssign.Order__c + 1;
        }
    }
}