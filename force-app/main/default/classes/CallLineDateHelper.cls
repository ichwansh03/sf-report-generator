public class CallLineDateHelper {
    public static Date getNextWorkingDay(Date startDate) {
        Date nextDate = startDate;
        while (true) {
            system.debug('MASUK LOOP');
            nextDate = nextDate.addDays(1);
            if (nextDate.toStartOfWeek().addDays(5) > nextDate) {
                system.debug('nextDate ' + nextDate);
                return nextDate;
            }
        }
        return null;
    }
}