@isTest()
public class SchPopUpEmailNotReply_Test {
	static testmethod void schedulerTest(){
        Test.StartTest();
        
        Group gr = new Group();
        gr.Name='Group Name Agent AFI Queue';
        gr.Type='Queue';
        insert gr;
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AFI' limit 1];
        
        User userAgentAFI = new User();
        userAgentAFI.Alias = 'spv1';
        userAgentAFI.Email='agentAfi@axa.co.id';
        userAgentAFI.EmailEncodingKey='UTF-8';
        userAgentAFI.LastName='agentAfi';
        userAgentAFI.LanguageLocaleKey='en_US';
        userAgentAFI.LocaleSidKey='en_US';
        userAgentAFI.ProfileId = agentProfileAFI.Id;
        userAgentAFI.Entity__c = 'AFI';
        userAgentAFI.TimeZoneSidKey='Asia/Jakarta';
        userAgentAFI.UserName='agentAfi@axa.co.id';
        userAgentAFI.isActive = TRUE;
        userAgentAFI.Agent__c = TRUE;
        userAgentAFI.Is_Backoffice__c = FALSE;
        //userAgentAFI.Agent_Queue_ID_Log_Notification__c = '00G0k000009bOms';	//to CRM2
        userAgentAFI.Agent_Queue_ID_Log_Notification__c = '00GN0000006TgMq';	//to FullSB
        //userAgentAFI.Agent_Queue_ID_Log_Notification__c = '00G0k000009bOms';	//to Production
        insert userAgentAFI;
        system.debug('userAgentAFI: '+userAgentAFI);
        
        
        Contact con1 = new Contact();
        con1.FirstName = 'Hamfry';
        con1.LastName = 'Lantu';
        con1.Policy_No__c = '1234-56781';
        insert con1;
        
        Case cs1 = new Case();
        cs1.Status = 'New';
        cs1.Entity_Backup__c = 'AFI';
        cs1.Origin = 'Email';
        cs1.Type = 'Inquiry';
        //cs1.OwnerId = userAgentAFI.Id;
        cs1.OwnerId = '0056F000007cd8E';
        cs1.PIC_Department_LU__c = userAgentAFI.Id;
        cs1.Subject = 'ILCCYS';
        cs1.Email_Status__c = 'Unread';
        cs1.CreatedDate = DateTime.newInstance(2019,2,1);
        cs1.LastModifiedDate = DateTime.newInstance(2019,2,1);
        insert cs1;
        system.debug('cs1 (SchPopUpEmailNotReply_Test): '+cs1);
        
        
        SchEmailNotReply m = new SchEmailNotReply();
        String sch = '0 0 10-16/3 * * ?';
        String jobID = system.schedule('SCHEDULE JOB SchPopUpEmailNotReply 2', sch, m);
        Test.stopTest();
    }
}