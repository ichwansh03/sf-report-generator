global class SessionDataScheduler implements Schedulable{
    global void execute(SchedulableContext sctx){
        delete [SELECT id FROM Session_Data__c LIMIT 10000];
    }
}