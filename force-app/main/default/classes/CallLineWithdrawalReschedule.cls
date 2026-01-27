global class CallLineWithdrawalReschedule implements Schedulable {
    global void execute(SchedulableContext sc) {
        Date today = Date.today();

        List<Call_Line__c> callLinesToUpdate = [
            SELECT Id, Reschedule_Date__c
            FROM Call_Line__c
            WHERE Activity_Result__c = 'F'
            AND Date_Reschedule__c = :today
            AND campaign_type__c = 'Collection-Withdrawal'
        ];
        system.debug('callLinesToUpdate ' + callLinesToUpdate.size());
        for (Call_Line__c cl : callLinesToUpdate) {
            //cl.Reschedule_Date__c = CallLineDateHelper.getNextWorkingDay(today);
            cl.Date_Reschedule__c = CallLineDateHelper.getNextWorkingDay(today);
            system.debug('cl.Reschedule_Date__c ' + cl.Reschedule_Date__c);
        }

        if (!callLinesToUpdate.isEmpty()) {
            system.debug('update call line Booking Call');
            update callLinesToUpdate;
        }
    }

}