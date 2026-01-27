@isTest(seeAllData=true)
public class ScheduleICFLoopService_Test {
    private static final String JOB_NAME = 'ICF loop check every day at 01:30';
    
    public static testMethod void scheduleICFTest() {
        Test.startTest();
        List<CronTrigger> ctList = [SELECT Id, CronJobDetail.Name, CronJobDetail.Id, State 
                                    FROM CronTrigger WHERE CronJobDetail.Name = :JOB_NAME AND State != 'COMPLETE'];
        if (ctList.size() == 0) {
            ScheduleICFLoopRunner silr = new ScheduleICFLoopRunner();
        	silr.execute(null);
        }
        
        ScheduleICFLoopService sils = new ScheduleICFLoopService();
        sils.execute(null);
        
        Test.stopTest();
    }
}