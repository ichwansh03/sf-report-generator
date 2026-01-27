@isTest()
public class EmailAutoReply_Test {
	static testmethod void myMethodTest(){
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
        userAgentAFI.Agent_Queue_ID_Log_Notification__c = '00G0k000009bOms';	//to CRM2
        //userAgentAFI.Agent_Queue_ID_Log_Notification__c = '00G0k000009bOms';	//to FullSB
        //userAgentAFI.Agent_Queue_ID_Log_Notification__c = '00G0k000009bOms';	//to Production
        insert userAgentAFI;
        
        
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
        cs1.OwnerId = userAgentAFI.Id;
        cs1.PIC_Department_LU__c = userAgentAFI.Id;
        cs1.Subject = 'ILCCYS';
        cs1.Email_Status__c = 'Unread';
        cs1.CreatedDate = DateTime.newInstance(2019,2,1);
        cs1.LastModifiedDate = DateTime.newInstance(2019,2,1);
        cs1.Email_Text_Holiday_Weekend__c = '<b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>';
        cs1.Send_Auto_Reply__c = FALSE;
        cs1.First_Queue__c = '';
        cs1.RecordTypeId = '01290000000mOgZ';	//to CRM2 "InquiryAFICase"
        insert cs1;
        
        ApexPages.currentPage().getParameters().put('id',cs1.id);
        EmailAutoReply ear = new EmailAutoReply();
        ear.caseID = cs1.Id;
        ear.getEmailTemplate();
        
        Test.stopTest();
    }
}