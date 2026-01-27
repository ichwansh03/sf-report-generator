@isTest(seeAllData = true)
public class SchCMUReminderNotification_Test {
    public static testMethod void test1(){
        SchCMUReminderNotification runner = new SchCMUReminderNotification();
        runner.execute(null);
    }
    public static testmethod void testInsert(){
        Test.startTest();
        
        
        Case cs = new Case();
        cs.Status='New';
        cs.Complaint_type__c='Priority';
        cs.Nature_Config__c='Processing Times';
        cs.ContactId='0030K00002CKOYjQAP';
        cs.Customer_type__c='Priority Banking Customer';
        insert cs;
        
        String jobId = System.schedule('SchSendWhatsappLog Test', Label.SchSendWhatssapLog_Cron, new SchCMUReminderNotification());

        Test.stopTest();
    }
    
}