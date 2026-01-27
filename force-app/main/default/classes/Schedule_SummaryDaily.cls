global class Schedule_SummaryDaily Implements Schedulable {
    global void execute(SchedulableContext sc) {
        Date yesterday = date.today().addDays(-1);
        String tgl = String.valueof(yesterday.day());
        String bln = String.valueof(yesterday.month());
        String thn = String.valueof(yesterday.year());
        Valdo_SummaryDaily.getSummaryDaily(tgl, bln, thn);
    }
}