trigger InsertClaimNumberTrigger on Call_Line__c (after insert, after update) {

    for (Call_Line__c cl : trigger.new) {
        
    }
}