@isTest
private class targetDateEntitlementTest {
static testMethod void testMilestoneTimeCalculator() {        
        // Select an existing milestone type to test with
        MilestoneType[] mtLst = [SELECT Id, Name FROM MilestoneType LIMIT 1];      
        if(mtLst.size() == 0) { return; }
        MilestoneType mt = mtLst[0];
        
        // Create case data.
        // Typically, the milestone type is related to the case, 
        // but for simplicity, the case is created separately for this test.
        Case c = new Case(priority = 'High', status = 'New');
        insert c;
        
        targetDateEntitlement calculator = new targetDateEntitlement();
        Integer actualTriggerTime = calculator.calculateMilestoneTriggerTime(c.Id, mt.Id);
        
        if(mt.name != null && mt.Name.equals('m1')) {
            System.assertEquals(actualTriggerTime, 10000);
        }
        else {
            System.assertEquals(actualTriggerTime, 10000);
        }
        
        c.priority = 'Low';
        update c;
        actualTriggerTime = calculator.calculateMilestoneTriggerTime(c.Id, mt.Id);
        System.assertEquals(actualTriggerTime, 10000);
    }	
}