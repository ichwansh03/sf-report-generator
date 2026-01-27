global class targetDateEntitlement implements Support.MilestoneTriggerTimeCalculator{
  global Integer calculateMilestoneTriggerTime(String caseId, String milestoneTypeId){
        Integer targetDuration;
      Case listCase = [select Id, Status, SLA_Case_Closed__c from Case where Id =:caseId];
        if(listCase.Status.Contains('Closed') == FALSE)
        {
            if (listCase.SLA_Case_Closed__c == NULL) listCase.SLA_Case_Closed__c = 10000;
            targetDuration = integer.valueof(listCase.SLA_Case_Closed__c);
            if (targetDuration == 0) targetDuration = 10000;
        }
        return targetDuration;
    }
}