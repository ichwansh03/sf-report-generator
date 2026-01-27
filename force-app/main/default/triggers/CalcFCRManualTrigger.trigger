trigger CalcFCRManualTrigger on Calc_FCR_Manual__c (after insert) {
    for (Calc_FCR_Manual__c data : trigger.new) {
        List<id> listId = new list<id>();
        listId.add(id.valueof(data.Contact_ID__c));
        if (data.Contact_ID__c != '0056F000004TDzz') SchCalc.FCRCaseDate(data.Case_Date__c, listId);
    }
}