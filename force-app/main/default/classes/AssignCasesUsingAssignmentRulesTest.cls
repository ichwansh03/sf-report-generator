@isTest
private class AssignCasesUsingAssignmentRulesTest {

    private static testMethod void doTest() {

        Test.startTest();
        Case l = new Case(Subject = 'Test Case',
                     Description = 'Test Company');
        insert l;

        List<Id> CaseIds = new List<Id>();
        CaseIds.Add(l.id);
        //AssignCasesUsingAssignmentRules.CaseAssign(New Case[]{l});
        AssignCasesUsingAssignmentRules.CaseAssign(CaseIds);

        Test.stopTest();

        l = [Select OwnerID From Case where ID = :l.id];
        //system.assertEquals(WHATYOUEXPECT, l.OwnerID);

    }
}