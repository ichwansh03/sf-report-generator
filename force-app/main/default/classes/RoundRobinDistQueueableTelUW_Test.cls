@isTest()
public class RoundRobinDistQueueableTelUW_Test {
    static testmethod void testScheduledJob() {
    	System.enqueueJob(new RoundRobinDistQueueableTelUW());
    }
	
}