global class SchContactCMUUpdate Implements Schedulable {

    global void execute(SchedulableContext sc) {
		System.enqueueJob(new ContactCMUUpdateQueueable()); 		
    }
    
}