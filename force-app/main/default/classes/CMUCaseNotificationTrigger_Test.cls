@isTest
public class CMUCaseNotificationTrigger_Test {
    @testSetup static void setTestData() {
        
        Contact c = new Contact();
        c.LastName = 'Wijaya';
        c.FirstName = 'Adi';
        c.Entity__c = 'AMFS';
        c.MobilePhone = '085156080110';
        c.Email = 'adi.wijaya@axa-mandiri.co.id';
        insert c;
        
        Email_SMS_Template__c emailTemplate = new Email_SMS_Template__c();
        emailTemplate.Name = 'CMU AMFS CLOSED EMAIL';
        emailTemplate.Category__c = 'Reminder CMU';
        emailTemplate.Detail_Link__c = '[SURVEY_LINK]';
        emailTemplate.Email_Body__c = 'Nasabah Yth.</br> </br>Pengaduan yang kami terima pada tanggal [CREATED_DATE] dengan nomor Pengaduan [CASE_NO] telah kami proses sesuai ketentuan dan peraturan yang berlaku.</br>';
        emailTemplate.Email_Footer__c = 'Info lebih lanjut dapat menghubungi kami melalui e-mail : [CMU_CASE_EMAIL] atau hubungi 1500803';
        emailTemplate.Email_Header__c = '<table width="100%"><tr><td colspan="1"><img src="https://c.ap4.content.force.com/servlet/servlet.ImageServer?id=0156F000009kIHq&oid=00D90000000zAlz&lastMod=1489725420000" width="250" align="right" /></td></tr><tr><td>';
        emailTemplate.Entity__c = 'AMFS';
        emailTemplate.Method__c = 'EMAIL';
        emailTemplate.Subject__c = 'Closed Case Complaint';
        insert emailTemplate;
        
        Email_SMS_Template__c smsTemplate = new Email_SMS_Template__c();
        smsTemplate.Name = 'CMU AMFS CLOSED SMS';
        smsTemplate.Category__c = 'Reminder CMU';
        smsTemplate.Detail_Link__c = '[SURVEY_LINK]';
        smsTemplate.Email_Body__c = 'Nasabah Yth.Pengaduan yang kami terima pada tanggal [CREATED_DATE] dengan nomor Pengaduan [CASE_NO] telah kami proses sesuai ketentuan dan peraturan yang berlaku.Info lebih lanjut dapat menghubungi kami melalui e-mail : [CMU_CASE_EMAIL] atau hubungi 1500803';
        smsTemplate.Entity__c = 'AMFS';
        smsTemplate.Method__c = 'SMS';
        smsTemplate.Subject__c = 'Closed Case Complaint';
        insert smsTemplate;
        
        Email_SMS_Template__c emailTemplateNew = new Email_SMS_Template__c();
        emailTemplateNew.Name = 'CMU AMFS NEW EMAIL';
        emailTemplateNew.Category__c = 'Reminder CMU';
        emailTemplateNew.Detail_Link__c = '[SURVEY_LINK]';
        emailTemplateNew.Email_Body__c = 'Nasabah Yth.</br> </br>Pengaduan yang kami terima pada tanggal [CREATED_DATE] dengan nomor Pengaduan [CASE_NO] telah kami proses sesuai ketentuan dan peraturan yang berlaku.</br>';
        emailTemplateNew.Email_Footer__c = 'Info lebih lanjut dapat menghubungi kami melalui e-mail : [CMU_CASE_EMAIL] atau hubungi 1500803';
        emailTemplateNew.Email_Header__c = '<table width="100%"><tr><td colspan="1"><img src="https://c.ap4.content.force.com/servlet/servlet.ImageServer?id=0156F000009kIHq&oid=00D90000000zAlz&lastMod=1489725420000" width="250" align="right" /></td></tr><tr><td>';
        emailTemplateNew.Entity__c = 'AMFS';
        emailTemplateNew.Method__c = 'EMAIL';
        emailTemplateNew.Subject__c = 'New Case Complaint';
        insert emailTemplateNew;
        
        Email_SMS_Template__c smsTemplateNew = new Email_SMS_Template__c();
        smsTemplateNew.Name = 'CMU AMFS NEW SMS';
        smsTemplateNew.Category__c = 'Reminder CMU';
        smsTemplateNew.Detail_Link__c = '[SURVEY_LINK]';
        smsTemplateNew.Email_Body__c = 'Nasabah Yth.Pengaduan yang kami terima pada tanggal [CREATED_DATE] dengan nomor Pengaduan [CASE_NO] telah kami proses sesuai ketentuan dan peraturan yang berlaku.Info lebih lanjut dapat menghubungi kami melalui e-mail : [CMU_CASE_EMAIL] atau hubungi 1500803';
        smsTemplateNew.Entity__c = 'AMFS';
        smsTemplateNew.Method__c = 'SMS';
        smsTemplateNew.Subject__c = 'New Case Complaint';
        insert smsTemplateNew;
        
        ICF_Parameter__c icfp = new ICF_Parameter__c();
        icfp.ICF_Email_Template__c = emailTemplate.Id;
        icfp.ICF_SMS_Template__c = smsTemplate.Id;
        icfp.user_ID__c = 'SFDCAPI';
        icfp.Password__c = 'SFDCAPI8765';
        icfp.Division__c = 'CCC';
        icfp.Sender__c = 'AXA_MANDIRI';
        icfp.Batchname__c = 'CMU_SMS_AMFS';
        icfp.Uploadby__c = 'Salesforce_AMFS';
        icfp.Channel__c = '1';
        icfp.Description__c = 'Test';
        icfp.ICF_Method__c = 'SMS';
        icfp.Entity__c = 'AMFS';
        icfp.RecordTypeId = '0122s0000008UqBAAU'; //prod: 0122s0000008UqBAAU, non-prod:012F8000001SIEiIAO
        insert icfp;
        
        ICF_Parameter__c icfpNew = new ICF_Parameter__c();
        icfpNew.ICF_Email_Template__c = emailTemplateNew.Id;
        icfpNew.ICF_SMS_Template__c = smsTemplateNew.Id;
        icfpNew.user_ID__c = 'SFDCAPI';
        icfpNew.Password__c = 'SFDCAPI8765';
        icfpNew.Division__c = 'CCC';
        icfpNew.Sender__c = 'AXA_MANDIRI';
        icfpNew.Batchname__c = 'CMU_SMS_AMFS';
        icfpNew.Uploadby__c = 'Salesforce_AMFS';
        icfpNew.Channel__c = '1';
        icfpNew.Description__c = 'Test';
        icfpNew.ICF_Method__c = 'SMS';
        icfpNew.Entity__c = 'AMFS';
        icfpNew.RecordTypeId = '0122s0000008UqBAAU'; //prod: 0122s0000008UqBAAU, non-prod:012F8000001SIEiIAO
        insert icfpNew;
        
        //new case parent
        Email_SMS_Log__c ESLog = new Email_SMS_Log__c();
        ESLog.Status__c = 'Draft';
        ESLog.Template_Email__c = emailTemplateNew.Id;
        ESLog.Template_SMS__c = smsTemplateNew.Id;
        ESLog.Entity__c = icfpNew.Entity__c;
        ESLog.Contact__c = c.Id;
        ESLog.Category__c = 'Reminder CMU';
        ESLog.Email__c = c.Email;
        ESLog.Mobile__c = c.MobilePhone;
        
        //close case
        Email_SMS_Log__c ESLogClose = new Email_SMS_Log__c();
        ESLogClose.Status__c = 'Draft';
        ESLogClose.Template_Email__c = emailTemplate.Id;
        ESLogClose.Template_SMS__c = smsTemplate.Id;
        ESLogClose.Entity__c = icfp.Entity__c;
        ESLogClose.Contact__c = c.Id;
        ESLogClose.Category__c = 'Reminder CMU';
        ESLogClose.Email__c = c.Email;
        ESLogClose.Mobile__c = c.MobilePhone;
    }
    
    @isTest
    public static void testInsert(){
        //01290000000msDDAAY
        Test.startTest();
        //query case
        Contact contact = [select id,name,Policy_No__c from contact where lastname = 'Wijaya'];
        ICF_Parameter__c icfpNew;
        Case CMUCase = new Case();
        CMUCase.status='New';
        CMUCase.ContactId = contact.id;
        CMUCase.Complaint_type__c='Simple';
        CMUCase.RecordTypeId = '01290000000msDDAAY';
        CMUCase.Nature_Config__c = 'POS';
        CMUCase.Entity_Backup__c = 'AMFS';
        CMUCase.ParentId = null;
        CMUCase.Description__c = 'created parent case';
        CMUCase.Origin = 'Phone';
        CMUCase.Appeal__c = 'No';
        insert CMUCase;
        
        Test.stopTest();
    }
    
    @isTest
    public static void testUpdate(){
        Test.startTest();
        //query case
        Contact contact = [select id,name,Policy_No__c from contact where lastname = 'Wijaya'];
        Case CMUCase = new Case();
        CMUCase.status='New';
        CMUCase.ContactId = contact.id;
        CMUCase.Complaint_type__c='Simple';
        CMUCase.RecordTypeId = '01290000000msDDAAY';
        CMUCase.Nature_Config__c = 'POS';
        CMUCase.Description__c = 'updated parent case';
        CMUCase.Appeal__c = 'Yes';
        CMUCase.Origin = 'Phone';
        CMUCase.Entity_Backup__c = 'AMFS';
        insert CMUCase;
        
        CMUCase.Status = 'Closed';
        update CMUCase;
        Test.stopTest();
    }
    
    public static testMethod void acceptCaseAFI() { 
        Email_SMS_Template__c emt = new Email_SMS_Template__c();
        emt.name = System.label.AFI_CMU_Accept_Case;
        emt.Category__c = 'Reminder CMU';
        emt.Email_Body__c = '[CONTACT_NAME] [POLICY_NO] [CASE_NUMBER] [CREATEDDATE]';
        emt.Subject__c = 'test';
        insert emt;
        
        Contact c = new Contact();
        c.LastName = 'Test';
        c.FirstName = 'AFI';
        c.Entity__c = 'AFI';
        c.MobilePhone = '085156080110';
        c.Email = 'testmail@mail.com';
        insert c;
        
        
        Case cs = new Case();
        cs.Subject = 'Subject Test Case';
        cs.Division__c = 'CCC'; 
        cs.ContactId = c.id;
        cs.type = 'Complaint';
        cs.entity_backup__c = 'AFI';
        insert cs; 
        
        Department__c d = new Department__c();
        d.name = 'test1';
        insert d;
        
        //Case_Internal_Comment__c cic = new Case_Internal_Comment__c();
        Named_User__c nu = new Named_User__c();
        nu.Name = 'test';
        nu.Department__c = d.id;
        insert nu;
        
        Test.setCurrentPage(Page.popupUserOnCase);
        ApexPages.StandardController stdController = new ApexPages.StandardController(cs);
        popupUserOnCaseClass popCls = new popupUserOnCaseClass(stdController);
		popCls.cic.Named_User__c = nu.id;
        popCls.updateCase();
    }
    
    
    public static testMethod void ClosedCaseAFI() { 
        Email_SMS_Template__c emt = new Email_SMS_Template__c();
        emt.name = System.label.AFI_CMU_Closed_Case;
        emt.Category__c = 'Reminder CMU';
        emt.Email_Body__c = '[CONTACT_NAME] [POLICY_NO] [CASE_NUMBER] [CREATEDDATE]';
        emt.Subject__c = 'test';
        insert emt;
        
        Contact c = new Contact();
        c.LastName = 'Test';
        c.FirstName = 'AFI';
        c.Entity__c = 'AFI';
        c.MobilePhone = '085156080110';
        c.Email = 'testmail@mail.com';
        insert c;
        
        Case cs = new Case();
        cs.Subject = 'Subject Test Case';
        cs.Division__c = 'CCC'; 
        cs.ContactId = c.id;
        cs.type = 'Complaint';
        cs.entity_backup__c = 'AFI';        
        cs.CHS_Status__c = 'Closed - Valid';
        cs.Closed_Date__c = system.today(); 
        insert cs; 
        
    }
}