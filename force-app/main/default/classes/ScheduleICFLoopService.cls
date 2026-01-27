global class ScheduleICFLoopService implements Schedulable {
	
    private static Date todayDate = Date.today();
    private static Date tomorrowDate = todayDate.addDays(1);
    private static final String SEND = 'Send';
    private static final String RECEIVED = 'Received';
    private static final String ICF = 'ICF';
    
    global void execute(SchedulableContext sc) {
        DescribeSObjectResult describeResultEsl = Email_SMS_Log__c.getSObjectType().getDescribe();
        List<String> eslFieldList = new List<String>(describeResultEsl.fields.getMap().keySet());
        String eslFields = String.join(eslFieldList, ',');
        String qEsl = '';
        if (Test.isRunningTest()) {
            qEsl = ' SELECT ' + eslFields + ' FROM Email_SMS_Log__c WHERE (Loop_Date_1__c = :tomorrowDate OR Loop_Date_2__c = :tomorrowDate OR Loop_Date_3__c = :tomorrowDate) AND Status__c in (:SEND, :RECEIVED) AND Category__c = :ICF AND Taken__c = false LIMIT 100 ';
        }
        else {
            qEsl = ' SELECT ' + eslFields + ' FROM Email_SMS_Log__c WHERE (Loop_Date_1__c = :tomorrowDate OR Loop_Date_2__c = :tomorrowDate OR Loop_Date_3__c = :tomorrowDate) AND Status__c in (:SEND, :RECEIVED) AND Category__c = :ICF AND Taken__c = false ';
        }
        //apex batch
        UpdateRequestDateBatch urdb = new UpdateRequestDateBatch(qEsl);
        Database.executeBatch(urdb, 100);
    }
}