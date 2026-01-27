public class InvokeCaseServiceQueueable {

    @InvocableMethod(label='Invoke Cases' description='Assessment Cases to Core System.')
    public static void invokeCases(List<String> recordIds){
        
        List<Case> cases = SOQL.of(Case.SObjectType)
            .with('Id, Policy_Numbers__c, Case_Owner_CCC__c, Department__c, Origin, Status, Contact.PolicyApp__c')
            .whereAre(SOQL.Filter.with(Case.Id).isIn(recordIds))
            .toList();
        system.debug('flow nya kepanggil kah?');
        system.debug('recordIds: '+recordIds);
        //System.enqueueJob(new SubmitCaseServiceQueueable(cases));
        system.debug('cases: '+cases);
    }
}