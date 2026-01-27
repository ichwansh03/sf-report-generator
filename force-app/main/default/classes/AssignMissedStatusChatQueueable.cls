public class AssignMissedStatusChatQueueable implements Queueable {

    private List<UserServicePresence> usp;
    
    public AssignMissedStatusChatQueueable(List<UserServicePresence> usp) {
        this.usp = usp;
    }
    
    public void execute(QueueableContext qc) {
        List<UserServicePresence> uspUpdate = new List<UserServicePresence>();
        
        system.debug('usp: '+usp);
        for (UserServicePresence presence : usp) {
            system.debug('missed chat: '+presence.Missed_Chat__c);
            if (presence.Missed_Chat__c == null) presence.Missed_Chat__c = 0;
            presence.Missed_Chat__c += 1;
            uspUpdate.add(presence);
        }
        
        if (!uspUpdate.isEmpty()) update uspUpdate;
        system.debug('uspUpdate: '+uspUpdate);
    }
}