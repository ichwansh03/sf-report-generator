global class DuplicateActiveLeave implements Schedulable{
	global void execute(SchedulableContext SC) {
    	duplicateLeaveActiveStatus();
    }
    
    private void duplicateLeaveActiveStatus(){
        List<Welcomecall_Leave__c> leaves =[Select id, active_leave__c, active__c from Welcomecall_Leave__c where welcomecall_end_date__c >= YESTERDAY];
        for(Welcomecall_Leave__c leave : leaves){
            leave.active__c = leave.active_leave__c;
        }
        
        update leaves;
        System.debug('=== DONE DUPLICATE LEAVE ACTIVE STATUS===');
    }
}