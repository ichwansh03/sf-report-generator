@isTest (seealldata=true)
private class Schedule_Report_Test {
    static testMethod void test_execute_UseCase1(){
        Schedule_SummaryDaily ssd = new Schedule_SummaryDaily();
        ssd.execute(null);
        schedule_dailyreportAgent sda = new Schedule_dailyreportAgent();
        sda.execute(null);
        schedule_dailyreportInterval sdi = new Schedule_DailyReportInterval();
        sdi.execute(null);
    }
}