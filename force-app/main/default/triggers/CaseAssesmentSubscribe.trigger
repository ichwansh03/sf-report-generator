/**
 * @description       : Subsribe PE AssessmentCase from CreateEmailSmsLogWhenCaseClosed 
 * @author            : Ichwan Sholihin
 * @testClass		  : CustomizeCaseServiceController_Test
**/
trigger CaseAssesmentSubscribe on Assessment_Case__e (after insert) {

    List<Case> cases = new List<Case>();
    
    for (Assessment_Case__e ac : Trigger.new) {
        Case cs = new Case();
        cs.Id = ac.Case_ID__c;
        cases.add(cs);
    }
    system.debug('cases: '+cases);
    if (cases.size() > 0) System.enqueueJob(new SubmitCaseServiceQueueable(cases));
}