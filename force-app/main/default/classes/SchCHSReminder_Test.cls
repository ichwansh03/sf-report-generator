@isTest(SeeAllData=True)
private class SchCHSReminder_Test{
    static testMethod void test_execute_UseCase1(){
        /*
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'REMINDER_CMU_ID_AFI_1';
        est.Category__c = 'Reminder CMU';
        est.Email_Header__c = 'Header';
        est.Email_Body__c = 'Body';
        est.Email_Footer__c = 'Footer';
        est.Entity__c = 'AFI';
        insert est;
        */
        
        
        Email_SMS_Template__c emt = new Email_SMS_Template__c();
        emt.name = System.label.AFI_CMU_Reminder_1;
        emt.Category__c = 'Reminder CMU';
        emt.Email_Body__c = '[CONTACT_NAME] [POLICY_NO] [CASE_NUMBER] [CREATEDDATE]';
        emt.Subject__c = 'test';
        insert emt;
        
        

        SchCHSReminder sch = new SchCHSReminder();
        sch.execute(null);
    }
}