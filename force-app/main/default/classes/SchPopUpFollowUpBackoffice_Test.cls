@isTest()
public class SchPopUpFollowUpBackoffice_Test {
	static testmethod void schedulerTest(){
        Test.StartTest();
        
        Profile backofficeProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AFI' limit 1];
        
        User userBackofficeAFI = new User();
        userBackofficeAFI.Alias = 'spv1';
        userBackofficeAFI.Email='agentAfi@axa.co.id';
        userBackofficeAFI.EmailEncodingKey='UTF-8';
        userBackofficeAFI.LastName='agentAfi';
        userBackofficeAFI.LanguageLocaleKey='en_US';
        userBackofficeAFI.LocaleSidKey='en_US';
        userBackofficeAFI.ProfileId = backofficeProfileAFI.Id;
        userBackofficeAFI.Entity__c = 'AFI';
        userBackofficeAFI.TimeZoneSidKey='Asia/Jakarta';
        userBackofficeAFI.UserName='agentAfi@axa.co.id';
        userBackofficeAFI.isActive = TRUE;
        userBackofficeAFI.Agent__c = FALSE;
        userBackofficeAFI.Is_Backoffice__c = TRUE;
        insert userBackofficeAFI;
        
        
        Contact con1 = new Contact();
        con1.FirstName = 'Hamfry';
        con1.LastName = 'Lantu';
        con1.Policy_No__c = '1234-56781';
        insert con1;
        
        Case cs1 = new Case();
        cs1.Status = 'New';
        cs1.Entity_Backup__c = 'AFI';
        cs1.Origin = 'Email';
        cs1.Type = 'Request';
        cs1.OwnerId = userBackofficeAFI.Id;
        cs1.PIC_Department_LU__c = userBackofficeAFI.Id;
        cs1.Subject = 'ILCCYS';
        insert cs1;
        
        SchFollowUpBackoffice m = new SchFollowUpBackoffice();
        String sch = '0 0 6 ? * MON-FRI';
        String jobID = system.schedule('SCHEDULE JOB SchPopUpFollowUpBackoffice 2', sch, m);
        Test.stopTest();
    }
}