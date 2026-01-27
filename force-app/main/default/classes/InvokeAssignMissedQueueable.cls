public class InvokeAssignMissedQueueable {

    public class UserParam {
        @InvocableVariable public String ownerId;
        @InvocableVariable public DateTime requestDate;
    }
    
    @InvocableMethod(label = 'Invoke User Presence' description = 'Update missed chat in user presence')
    public static void invokeCases(List<UserParam> params) {
        UserParam param = params[0];
        List<UserServicePresence> usp = [SELECT Id, Missed_Chat__c, StatusStartDate, StatusEndDate, OwnerId FROM UserServicePresence WHERE StatusStartDate <= :param.requestDate AND OwnerId = :param.ownerId ORDER BY LastModifiedDate DESC LIMIT 1];
        system.debug('usp current'+usp);
        
        if (!usp.isEmpty()) System.enqueueJob(new AssignMissedStatusChatQueueable(usp));
    }
}