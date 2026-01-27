public class AssignCasesUsingAssignmentRules
{
    @InvocableMethod
    public static void CaseAssign(List<Id> CaseIds)
    {
            Database.DMLOptions dmo = new Database.DMLOptions();
            dmo.assignmentRuleHeader.useDefaultRule= true;          
            list<case> listcs = new list<case>();
            for (Case Cases : [select id from Case where Case.id in :CaseIds]) {
                Cases.setOptions(dmo);
                listcs.add(Cases);
            }
            //update Cases;
            update listcs;
   }
}