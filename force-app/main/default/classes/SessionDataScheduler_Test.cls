@isTest
public class SessionDataScheduler_Test {
    
     public static testmethod void testSchedul(){
        Test.StartTest();
        SessionDataScheduler sh1 = new SessionDataScheduler();      
        String sch = '0 0 23 * * ?';
		System.schedule('Session Data Sch Test', sch, sh1);
        Test.stopTest();
     }

}