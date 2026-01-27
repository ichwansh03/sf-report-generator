@isTest(SeeAllData=True)
private class SchCMUDispatchCheck_Test{
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
        
        Contact ct = new Contact();
        ct.Entity__c = 'AMFS';
        ct.LastName = 'Contact Test';
        ct.MobilePhone = '0819123456789';
        ct.Email = 'customer@gmail.com';
        insert ct;
        
        Named_User__c nu = new Named_User__c();
        nu.Name = 'Test';
        nu.User__c = UserInfo.getUserId();
        nu.Entity__c = 'AMFS';
        nu.Division__c = 'CMU';
        nu.Status__c = 'Active';
        insert nu;

        Id rtype = Schema.SObjectType.Case.getRecordTypeInfosByName().get('AMFSComplaintCase').getRecordTypeId();
        
        Case cs = new Case();
        cs.RecordTypeId = rtype;
        cs.Subject = 'New CMU';
        cs.Type = 'Complaint';
        cs.Entity_Backup__c = 'AMFS';
        cs.Named_User__c = NULL;
        cs.Type = 'Complaint';
        cs.contactid = ct.id;
        //cs.Complaint_type__c = 'Soft Complaint';
        insert cs;

        SchCMUDispatchCheck sch = new SchCMUDispatchCheck();
        sch.execute(null);
    }

    static testMethod void test_execute_UseCase2(){
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
        Named_User__c nu = new Named_User__c();
        nu.Name = 'Test2';
        nu.User__c = UserInfo.getUserId();
        nu.Entity__c = 'AMFS';
        nu.Division__c = 'CMU';
        nu.Status__c = 'Active';
        nu.Channel_Digital__c = TRUE;
        insert nu;

        Id rtype = Schema.SObjectType.Case.getRecordTypeInfosByName().get('AMFSComplaintCase').getRecordTypeId();
        
        Case cs = new Case();
        cs.RecordTypeId = rtype;
        cs.Subject = 'New CMU';
        cs.Type = 'Complaint';
        cs.Entity_Backup__c = 'AMFS';
        cs.Named_User__c = NULL;
        cs.Type = 'Complaint';
        cs.Channel__c = 'Social Media';
        //cs.Complaint_type__c = 'Soft Complaint';
        insert cs;

        SchCMUDispatchCheck sch = new SchCMUDispatchCheck();
        sch.execute(null);
    }
}