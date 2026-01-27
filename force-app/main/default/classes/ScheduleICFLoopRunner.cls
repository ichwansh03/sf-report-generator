global class ScheduleICFLoopRunner Implements Schedulable {
    global void execute(SchedulableContext sc) {
        String sch1 = '0 30 1 * * ?';
        ScheduleICFLoopService sils1 = new ScheduleICFLoopService();
        System.schedule('ICF loop check every day at 01:30', sch1, sils1);
    }
}