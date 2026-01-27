@isTest
public class Avantbox_Create_Email_Scoring8_Test{
    //Refactored by Phincon 2018-03-16
    public static String[] emailAMFSCustomerLong = system.label.EMAIL_AMFS_Customer_Long.split('\\|\\|');
    public static String[] emailAMFSNasabahLong = system.label.EMAIL_AMFS_Nasabah_Long.split('\\|\\|');
    public static String[] emailAMFSPriorityLong = system.label.EMAIL_AMFS_Priority_Long.split('\\|\\|');
    public static String[] emailAFICustomerLong = system.label.EMAIL_AFI_Customer_Long.split('\\|\\|');
    public static String[] emailAFIHelplineLong = system.label.EMAIL_AFI_Helpline_Long.split('\\|\\|');
    public static String[] emailMAGILong = system.label.EMAIL_MAGI_Long.split('\\|\\|');
    public static String[] emailALILong = system.label.EMAIL_ALI_LONG.split('\\|\\|');
    
    public static Id AfiInquiry = Schema.SObjectType.Case.getRecordTypeInfosByName().get('InquiryAFICase').getRecordTypeId();
    public static Id AliInquiry = Schema.SObjectType.Case.getRecordTypeInfosByName().get('InquiryALICase').getRecordTypeId();
    public static Id AmfsInquiry = Schema.SObjectType.Case.getRecordTypeInfosByName().get('InquiryAMFSCase').getRecordTypeId();
    public static Id MagiInquiry = Schema.SObjectType.Case.getRecordTypeInfosByName().get('InquiryMAGICase').getRecordTypeId();
    public static Id AfiComplaint = Schema.SObjectType.Case.getRecordTypeInfosByName().get('AFIComplaintCase').getRecordTypeId();
    public static Id AmfsComplaint = Schema.SObjectType.Case.getRecordTypeInfosByName().get('AMFSComplaintCase').getRecordTypeId();
    public static Id MagiComplaint = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MAGIComplaintCase').getRecordTypeId();
    public static Id ALIComplaint = Schema.SObjectType.Case.getRecordTypeInfosByName().get('ALIComplaintCase').getRecordTypeId();
    public static Id AfiRequest = Schema.SObjectType.Case.getRecordTypeInfosByName().get('RequestAFICase').getRecordTypeId();
    public static Id AmfsRequest = Schema.SObjectType.Case.getRecordTypeInfosByName().get('RequestAMFSCase').getRecordTypeId();
    public static Id ALIRequest = Schema.SObjectType.Case.getRecordTypeInfosByName().get('RequestALICase').getRecordTypeId();
 
    
    public static string emailCustomerAFI = System.Label.CustomerEmail_AFI_ALI;
    public static string emailHelplineAFI = system.Label.HelplineEmail_AFI_ALI;
     
    @testSetup
    static void setupRecord() {
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like '%Agent%AFI' limit 1]; 
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like '%Agent%AMFS' limit 1]; 
        
        List<User> usrList = new List<User>();
        User usr1 = new User(Alias = 'agent1', Email='agent01@axa.co.id', 
                EmailEncodingKey='UTF-8', LastName='agent01', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, Entity__c = 'AFI', /*Agent_Queue_ID_Email_Reply_Customer__c = '00G0k000009bOmY', //CRM2*/
                             /*Agent_Queue_ID_Email_Reply_Customer__c = gr1.Id,*/ //FULLSB
                TimeZoneSidKey='Asia/Jakarta', UserName='agent01@axa.co.id', isActive = true, Agent__c = TRUE);
        usrList.add(usr1);
        User usr2 = new User(Alias = 'agent2', Email='agent02@axa.co.id', 
                EmailEncodingKey='UTF-8', LastName='agent02', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, Entity__c = 'AMFS', 
                TimeZoneSidKey='Asia/Jakarta', UserName='agent02@axa.co.id', isActive = true);
        usrList.add(usr2);
        User usr3 = new User(Alias = 'agent3', Email='agent03@axa.co.id', 
                EmailEncodingKey='UTF-8', LastName='agent03', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, Entity__c = 'AFI', /*Agent_Queue_ID_Email_Reply_Customer__c = '00G0k000009awyd', //CRM2*/
                             /*Agent_Queue_ID_Email_Reply_Customer__c = gr2.Id,*/ //FULLSB
                TimeZoneSidKey='Asia/Jakarta', UserName='agent03@axa.co.id', isActive = true, Agent__c = TRUE);
        usrList.add(usr3);
        User usr4 = new User(Alias = 'agent4', Email='agent04@axa.co.id', 
                EmailEncodingKey='UTF-8', LastName='agent04', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, Entity__c = 'AMFS', 
                TimeZoneSidKey='Asia/Jakarta', UserName='agent04@axa.co.id', isActive = true);
        usrList.add(usr4);
        
        insert usrList;
    }
    
    public static testMethod void testAvantboxMagiCustomer() {
       
		User usr2 = [SELECT Id FROM User WHERE UserName = 'agent02@axa.co.id' LIMIT 1];
        User usr4 = [SELECT Id FROM User WHERE UserName = 'agent04@axa.co.id' LIMIT 1];
        Test.startTest();
        
        //Added by Hamfry (2015-05-04)
        String caseid = '';
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-mandiri.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr2.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AMFS';
        con1.Email = 'test1@abc.org';
        con1.MobilePhone = '11111';
        contactList.add(con1);
        insert contactList;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AmfsInquiry;
            case1.Entity_Backup__c = 'AMFS';
            case1.Type = 'Inquiry';
            caselist.add(case1);
		    
            insert caselist;
            List<EmailMessage> emailMsgList = new List<EmailMessage>();
            emailMsgList.add(new EmailMessage(FromAddress = 'test1@abc.org', Incoming = true, ToAddress= 'nasabah@axa-mandiri.co.id;hammvai@yahoo.com', 
                                              CCAddress = 'testing123@yahoo.com;testo.axa@gmail.com', 
                                          	  Headers='magi.mandiri.customer@ewd6y87heyrqpsf1v5mt0n9oftarjjjd4ncgajs1tdaaj2z4x.0k-crveeak.cs57.apex.sandbox.salesforce.com,magi_customer@9-vghghyr0p87lepmwchdifhinoenq6d7rtnrb07xo8vw8kr3h2.9-zalzeae.ap1.apex.salesforce.com',
                                              BccAddress = 'testing123@yahoo.com;testo.axa@gmail.com', Subject = 'Test P0000011', TextBody = '23456 ', ParentId = case1.id)); 
            system.debug('Insert 1 done');
            
            insert emailMsgList;    
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsgList.get(0));
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }
    
    public static testMethod void testAvantboxAmfsCustomer() {
       
		User usr2 = [SELECT Id FROM User WHERE UserName = 'agent02@axa.co.id' LIMIT 1];
        User usr4 = [SELECT Id FROM User WHERE UserName = 'agent04@axa.co.id' LIMIT 1];
        Test.startTest();
        
        //Added by Hamfry (2015-05-04)
        String caseid = '';
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-mandiri.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr2.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AMFS';
        con1.Email = 'test1@abc.org';
        con1.MobilePhone = '11111';
        contactList.add(con1);
        insert contactList;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AmfsInquiry;
            case1.Entity_Backup__c = 'AMFS';
            case1.Type = 'Inquiry';
            caselist.add(case1);
		    
            insert caselist;
            List<EmailMessage> emailMsgList = new List<EmailMessage>();
            emailMsgList.add(new EmailMessage(FromAddress = 'test1@abc.org', Incoming = true, ToAddress= 'nasabah@axa-mandiri.co.id;hammvai@yahoo.com', 
                                              CCAddress = 'testing123@yahoo.com;testo.axa@gmail.com', 
                                          	  Headers=emailAMFSCustomerLong[1],
                                              BccAddress = 'testing123@yahoo.com;testo.axa@gmail.com', Subject = 'Test P0000011', TextBody = '23456 ', ParentId = case1.id)); 
            system.debug('Insert 1 done');
            
            insert emailMsgList;    
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsgList.get(0));
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }
        
    public static testMethod void testAvantboxAmfsNasabah() {
        
		User usr2 = [SELECT Id FROM User WHERE UserName = 'agent02@axa.co.id' LIMIT 1];
        User usr4 = [SELECT Id FROM User WHERE UserName = 'agent04@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'nasabah@axa-mandiri.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr2.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AMFS';
        con1.Email = 'test1@abc.org';
        con1.MobilePhone = '11111';
        contactList.add(con1);
        insert contactList;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AmfsInquiry;
            case1.Entity_Backup__c = 'AMFS';
            case1.Type = 'Inquiry';
        	case1.Origin ='Email';
            caselist.add(case1);
		    
            insert caselist;

            EmailMessage emailMsg = new EmailMessage(FromAddress = 'test1@abc.org', Incoming = true, ToAddress= 'customer@axa-mandiri.co.id;hammvai@yahoo.com', 
                                              Headers =emailAMFSNasabahLong[1] ,CCAddress = 'testing123@yahoo.com;testo.axa@gmail.com', 
                                              Subject = 'Test P0000011', TextBody = '23456 ', ParentId = case1.id);
            system.debug('Insert 1 done');
            insert emailMsg;
        
            Attachment attach1 = new Attachment();
            attach1.ParentId = emailMsg.Id;
            attach1.Name = 'testing123.pdf';
            attach1.ContentType = 'image/tiff';
            attach1.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
            insert attach1;
        
        	Attachment attach2 = new Attachment();
            attach2.ParentId = emailMsg.Id;
            attach2.Name = 'testing123.pdf';
            attach2.ContentType = 'image/tiff';
            attach2.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
        	insert attach2;
        
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsg);
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }
    
    public static testMethod void testAvantboxAmfsPriority() {
       
		User usr2 = [SELECT Id FROM User WHERE UserName = 'agent02@axa.co.id' LIMIT 1];
        User usr4 = [SELECT Id FROM User WHERE UserName = 'agent04@axa.co.id' LIMIT 1];
        Test.startTest();
        
        //Added by Hamfry (2015-05-04)
        String caseid = '';
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-mandiri.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr2.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AMFS';
        con1.Email = 'test1@abc.org';
        con1.MobilePhone = '11111';
        contactList.add(con1);
        insert contactList;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AmfsInquiry;
            case1.Entity_Backup__c = 'AMFS';
            case1.Type = 'Inquiry';
            caselist.add(case1);
		    
            insert caselist;
            List<EmailMessage> emailMsgList = new List<EmailMessage>();
            emailMsgList.add(new EmailMessage(FromAddress = 'test1@abc.org', Incoming = true, ToAddress= 'nasabah@axa-mandiri.co.id;hammvai@yahoo.com', 
                                              CCAddress = 'testing123@yahoo.com;testo.axa@gmail.com', 
                                          	  Headers=emailAMFSPriorityLong[1],
                                              BccAddress = 'testing123@yahoo.com;testo.axa@gmail.com', Subject = 'Test P0000011', TextBody = '23456 ', ParentId = case1.id)); 
            system.debug('Insert 1 done');
            
            insert emailMsgList;    
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsgList.get(0));
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }
    
    public static testMethod void testAvantboxAmfs_Complaint() {
        
		User usr2 = [SELECT Id FROM User WHERE UserName = 'agent02@axa.co.id' LIMIT 1];
        User usr4 = [SELECT Id FROM User WHERE UserName = 'agent04@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'nasabah@axa-mandiri.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr2.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AMFS';
        con1.Email = 'test1@abc.org';
        con1.MobilePhone = '11111';
        contactList.add(con1);
        insert contactList;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AfiComplaint;
            case1.Entity_Backup__c = 'AMFS';
            case1.Type = 'Complaint';
        	case1.Origin = 'Walk-In';
            caselist.add(case1);
		    
            insert caselist;
        
        Test.stopTest();
    }
    
    
    public static testMethod void testAvantboxALICustomer_Holiday_noSubject() {
        User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-financial.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr1.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Customer AFI';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = system.today();
        mh.End_Date_Time__c = system.today()+1;
        mh.Active_Date__c = date.valueOf(system.today()+2);
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Customer AFI';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = system.today();
        mh2.End_Date_Time__c = system.today()+1;
        mh2.Active_Date__c = date.valueOf(system.today()+2);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AfiInquiry;
            case1.Entity_Backup__c = 'AFI';
            case1.Type = 'Inquiry';
        	case1.Origin ='Email';
        	case1.Email_Inbox__c = 'customer@axa-financial.co.id';
            caselist.add(case1);
		    
            insert caselist;

            EmailMessage emailMsg = new EmailMessage(FromAddress = 'testafi@abc.org', Incoming = true, ToAddress= 'customer@axa-financial.co.id', 
                                              Headers =emailAFICustomerLong[1] ,CCAddress = 'testing123@yahoo.com', MessageDate = system.today(),
                                              Subject = '', TextBody = '23456 ', ParentId = case1.id);
            system.debug('Insert 1 done');
            insert emailMsg;
        
            Attachment attach1 = new Attachment();
            attach1.ParentId = emailMsg.Id;
            attach1.Name = 'testing123.pdf';
            attach1.ContentType = 'image/tiff';
            attach1.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
            insert attach1;
        
        	Attachment attach2 = new Attachment();
            attach2.ParentId = emailMsg.Id;
            attach2.Name = 'testing123.pdf';
            attach2.ContentType = 'image/tiff';
            attach2.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
        	insert attach2;
        
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsg);
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }
    
    
    public static testMethod void testAvantboxALICustomer_Holiday_not_RE() {
        User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-financial.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr1.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Customer AFI';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = system.today();
        mh.End_Date_Time__c = system.today()+1;
        mh.Active_Date__c = date.valueOf(system.today()+2);
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Customer AFI';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = system.today();
        mh2.End_Date_Time__c = system.today()+1;
        mh2.Active_Date__c = date.valueOf(system.today()+2);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AfiInquiry;
            case1.Entity_Backup__c = 'AFI';
            case1.Type = 'Inquiry';
        	case1.Origin ='Email';
        	case1.Email_Inbox__c = 'customer@axa-financial.co.id';
            caselist.add(case1);
		    
            insert caselist;

            EmailMessage emailMsg = new EmailMessage(FromAddress = 'testafi@abc.org', Incoming = true, ToAddress= 'customer@axa-financial.co.id', 
                                              Headers =emailAFICustomerLong[1] ,CCAddress = 'testing123@yahoo.com', MessageDate = system.today(),
                                              Subject = 'Test P0000011', TextBody = '23456 ', ParentId = case1.id);
            system.debug('Insert 1 done');
            insert emailMsg;
        
            Attachment attach1 = new Attachment();
            attach1.ParentId = emailMsg.Id;
            attach1.Name = 'testing123.pdf';
            attach1.ContentType = 'image/tiff';
            attach1.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
            insert attach1;
        
        	Attachment attach2 = new Attachment();
            attach2.ParentId = emailMsg.Id;
            attach2.Name = 'testing123.pdf';
            attach2.ContentType = 'image/tiff';
            attach2.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
        	insert attach2;
        
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsg);
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }
    
    /*public static testMethod void testAvantboxALICustomer_Holiday_RE() {
        User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-financial.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr1.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Customer AFI';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = system.today();
        mh.End_Date_Time__c = system.today()+1;
        mh.Active_Date__c = date.valueOf(system.today()+2);
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Customer AFI';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = system.today();
        mh2.End_Date_Time__c = system.today()+1;
        mh2.Active_Date__c = date.valueOf(system.today()+2);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AfiInquiry;
            case1.Entity_Backup__c = 'AFI';
            case1.Type = 'Inquiry';
        	case1.Origin ='Email';
        	//case1.OwnerId = '0056F000007cd8E';
            caselist.add(case1);
		    
            insert caselist;

            EmailMessage emailMsg = new EmailMessage(FromAddress = 'testafi@abc.org', Incoming = true, ToAddress= 'customer@axa-financial.co.id', 
                                              Headers =emailAFICustomerLong[1] ,CCAddress = 'testing123@yahoo.com',MessageDate = system.today(),
                                              Subject = 'RE: Test P0000088', TextBody = '23456 ', ParentId = case1.id);
            system.debug('Insert 1 done');
            insert emailMsg;
        
            Attachment attach1 = new Attachment();
            attach1.ParentId = emailMsg.Id;
            attach1.Name = 'testing123.pdf';
            attach1.ContentType = 'image/tiff';
            attach1.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
            insert attach1;
        
        	Attachment attach2 = new Attachment();
            attach2.ParentId = emailMsg.Id;
            attach2.Name = 'testing123.pdf';
            attach2.ContentType = 'image/tiff';
            attach2.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
        	insert attach2;
        
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsg);
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }*/
    
    public static testMethod void testAvantboxALICustomer_Event_not_RE() {
        User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-financial.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr1.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Customer AFI';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
        mh.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
        mh.Active_Date__c = date.newInstance(2019, 12, 14);
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Customer AFI';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = system.today();
        mh2.End_Date_Time__c = system.today()+1;
        mh2.Active_Date__c = date.valueOf(system.today()+2);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AfiInquiry;
            case1.Entity_Backup__c = 'AFI';
            case1.Type = 'Inquiry';
        	case1.Origin ='Email';
        	case1.Assignment_Rules__c = FALSE;
        	case1.First_Queue__c = '';
        	case1.Email_Inbox__c = 'customer@axa-financial.co.id';
            caselist.add(case1);
		    
            insert caselist;

            EmailMessage emailMsg = new EmailMessage(FromAddress = 'testafi@abc.org', Incoming = true, ToAddress= 'customer@axa-financial.co.id', 
                                              Headers =emailAFICustomerLong[1] ,CCAddress = 'testing123@yahoo.com', MessageDate = system.today(),
                                              Subject = 'Test P0000011', TextBody = '23456 ', ParentId = case1.id);
            system.debug('Insert 1 done');
            insert emailMsg;
        
            Attachment attach1 = new Attachment();
            attach1.ParentId = emailMsg.Id;
            attach1.Name = 'testing123.pdf';
            attach1.ContentType = 'image/tiff';
            attach1.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
            insert attach1;
        
        	Attachment attach2 = new Attachment();
            attach2.ParentId = emailMsg.Id;
            attach2.Name = 'testing123.pdf';
            attach2.ContentType = 'image/tiff';
            attach2.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
        	insert attach2;
        
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsg);
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }
    
    /*public static testMethod void testAvantboxALICustomer_Event_RE() {
        //User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        //User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like '%Agent%AFI' limit 1]; 
        
        Group gr1 = new Group();
        gr1.Name = 'Group 1 Queue';
        gr1.Type = 'Queue';
        insert gr1;
        
        Group gr2 = new Group();
        gr2.Name = 'Group 2 Queue';
        gr2.Type = 'Queue';
        insert gr2;
        
        system.debug('gr1: '+gr1);
        system.debug('gr2: '+gr2);
        
        User usr1 = new User();
        usr1.Alias = 'agent1';
        usr1.Email='agent01@axa.co.id'; 
        usr1.EmailEncodingKey='UTF-8';
        usr1.LastName='agent01';
        usr1.LanguageLocaleKey='en_US';
        usr1.LocaleSidKey='en_US';
        usr1.ProfileId = agentProfileAFI.Id;
        usr1.Entity__c = 'AFI';
        usr1.Agent_Queue_ID_Email_Reply_Customer__c = gr1.Id; //FULLSB
        usr1.TimeZoneSidKey='Asia/Jakarta';
        usr1.UserName='agent10@axa.co.id';
        usr1.isActive = true;
        usr1.Agent__c = TRUE;
        insert usr1;
        system.debug('usr1: '+usr1);
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-financial.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr1.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Customer AFI';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
        mh.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
        mh.Active_Date__c = date.newInstance(2019, 12, 14);
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Customer AFI';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = system.today();
        mh2.End_Date_Time__c = system.today()+1;
        mh2.Active_Date__c = date.valueOf(system.today()+2);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        //system.runAs(usr){
            //List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AfiInquiry;
            case1.Entity_Backup__c = 'AFI';
            case1.Type = 'Inquiry';
        	case1.Origin ='Email';
        	case1.OwnerId = usr1.Id; //fullsb
        	case1.First_Case_Origin__c = '';
            //caselist.add(case1);
            insert case1;
		    
            //insert caselist;
        
        	system.debug('case1: '+case1);

            EmailMessage emailMsg = new EmailMessage();
            emailMsg.ParentId = case1.Id;
        	emailMsg.FromAddress = 'testafi@abc.org';
        	emailMsg.Incoming = true;
        	emailMsg.ToAddress= 'customer@axa-financial.co.id';
        	emailMsg.MessageDate = system.today();
            emailMsg.Subject = 'RE: Test P0000088';
        	emailMsg.TextBody = '23456 ';
            insert emailMsg;
        
            system.debug('Insert 1 done');
        	system.debug('emailMsg: '+emailMsg);
        
            Attachment attach1 = new Attachment();
            attach1.ParentId = emailMsg.Id;
            attach1.Name = 'testing123.pdf';
            attach1.ContentType = 'image/tiff';
            attach1.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
            insert attach1;
        
        	Attachment attach2 = new Attachment();
            attach2.ParentId = emailMsg.Id;
            attach2.Name = 'testing123.pdf';
            attach2.ContentType = 'image/tiff';
            attach2.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
        	insert attach2;
        
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsg);
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }*/
    
    public static testMethod void testAvantboxALIHelpline_Holiday_not_RE() {
        User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'helpline@axa-financial.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr1.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Helpline';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = system.today();
        mh.End_Date_Time__c = system.today()+1;
        mh.Active_Date__c = date.valueOf(system.today()+2);
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Helpline';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = system.today();
        mh2.End_Date_Time__c = system.today()+1;
        mh2.Active_Date__c = date.valueOf(system.today()+2);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AfiInquiry;
            case1.Entity_Backup__c = 'AFI';
            case1.Type = 'Inquiry';
        	case1.Origin ='Email';
        	case1.Email_Inbox__c = 'helpline@axa-financial.co.id';
            caselist.add(case1);
		    
            insert caselist;

            EmailMessage emailMsg = new EmailMessage(FromAddress = 'testafi@abc.org', Incoming = true, ToAddress= 'helpline@axa-financial.co.id', 
                                              Headers =emailAFIHelplineLong[1] ,CCAddress = 'testing123@yahoo.com', MessageDate = system.today(),
                                              Subject = 'Test P0000011', TextBody = '23456 ', ParentId = case1.id);
            system.debug('Insert 1 done');
            insert emailMsg;
        
            Attachment attach1 = new Attachment();
            attach1.ParentId = emailMsg.Id;
            attach1.Name = 'testing123.pdf';
            attach1.ContentType = 'image/tiff';
            attach1.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
            insert attach1;
        
        	Attachment attach2 = new Attachment();
            attach2.ParentId = emailMsg.Id;
            attach2.Name = 'testing123.pdf';
            attach2.ContentType = 'image/tiff';
            attach2.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
        	insert attach2;
        
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsg);
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }
    
    /*public static testMethod void testAvantboxALIHelpline_Holiday_RE() {
        User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'helpline@axa-financial.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr1.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Helpline';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = system.today();
        mh.End_Date_Time__c = system.today()+1;
        mh.Active_Date__c = date.valueOf(system.today()+2);
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Helpline';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = system.today();
        mh2.End_Date_Time__c = system.today()+1;
        mh2.Active_Date__c = date.valueOf(system.today()+2);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AfiInquiry;
            case1.Entity_Backup__c = 'AFI';
            case1.Type = 'Inquiry';
        	case1.Origin ='Email';
        	//case1.OwnerId = usr1.Id;
            caselist.add(case1);
		    
            insert caselist;

            EmailMessage emailMsg = new EmailMessage(FromAddress = 'testafi@abc.org', Incoming = true, ToAddress= 'helpline@axa-financial.co.id', 
                                              Headers =emailAFICustomerLong[1] ,CCAddress = 'testing123@yahoo.com',MessageDate = system.today(),
                                              Subject = 'RE: Test P0000088', TextBody = '23456 ', ParentId = case1.id);
            system.debug('Insert 1 done');
            insert emailMsg;
        
            Attachment attach1 = new Attachment();
            attach1.ParentId = emailMsg.Id;
            attach1.Name = 'testing123.pdf';
            attach1.ContentType = 'image/tiff';
            attach1.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
            insert attach1;
        
        	Attachment attach2 = new Attachment();
            attach2.ParentId = emailMsg.Id;
            attach2.Name = 'testing123.pdf';
            attach2.ContentType = 'image/tiff';
            attach2.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
        	insert attach2;
        
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsg);
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }*/
    
    public static testMethod void testAvantboxALIHelpline_Event_not_RE() {
        User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'helpline@axa-financial.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr1.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Helpline';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
        mh.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
        mh.Active_Date__c = date.newInstance(2019, 12, 14);
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Helpline';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = system.today();
        mh2.End_Date_Time__c = system.today()+1;
        mh2.Active_Date__c = date.valueOf(system.today()+2);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AfiInquiry;
            case1.Entity_Backup__c = 'AFI';
            case1.Type = 'Inquiry';
        	case1.Origin ='Email';
        	case1.Email_Inbox__c = 'helpline@axa-financial.co.id';
            caselist.add(case1);
		    
            insert caselist;

            EmailMessage emailMsg = new EmailMessage(FromAddress = 'testafi@abc.org', Incoming = true, ToAddress= 'helpline@axa-financial.co.id', 
                                              Headers =emailAFICustomerLong[1] ,CCAddress = 'testing123@yahoo.com', MessageDate = system.today(),
                                              Subject = 'Test P0000011', TextBody = '23456 ', ParentId = case1.id);
            system.debug('Insert 1 done');
            insert emailMsg;
        
            Attachment attach1 = new Attachment();
            attach1.ParentId = emailMsg.Id;
            attach1.Name = 'testing123.pdf';
            attach1.ContentType = 'image/tiff';
            attach1.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
            insert attach1;
        
        	Attachment attach2 = new Attachment();
            attach2.ParentId = emailMsg.Id;
            attach2.Name = 'testing123.pdf';
            attach2.ContentType = 'image/tiff';
            attach2.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
        	insert attach2;
        
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsg);
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }
    
    /*public static testMethod void testAvantboxALIHelpline_Event_RE() {
        User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'helpline@axa-financial.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr1.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Helpline';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
        mh.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
        mh.Active_Date__c = date.newInstance(2019, 12, 14);
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Helpline';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = system.today();
        mh2.End_Date_Time__c = system.today()+1;
        mh2.Active_Date__c = date.valueOf(system.today()+2);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AfiInquiry;
            case1.Entity_Backup__c = 'AFI';
            case1.Type = 'Inquiry';
        	case1.Origin ='Email';
        	//case1.OwnerId = usr1.Id;
            caselist.add(case1);
		    
            insert caselist;

            EmailMessage emailMsg = new EmailMessage(FromAddress = 'testafi@abc.org', Incoming = true, ToAddress= 'helpline@axa-financial.co.id', 
                                              Headers =emailAFICustomerLong[1] ,CCAddress = 'testing123@yahoo.com',MessageDate = system.today(),
                                              Subject = 'RE: Test P0000088', TextBody = '23456 ', ParentId = case1.id);
            system.debug('Insert 1 done');
            insert emailMsg;
        
            Attachment attach1 = new Attachment();
            attach1.ParentId = emailMsg.Id;
            attach1.Name = 'testing123.pdf';
            attach1.ContentType = 'image/tiff';
            attach1.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
            insert attach1;
        
        	Attachment attach2 = new Attachment();
            attach2.ParentId = emailMsg.Id;
            attach2.Name = 'testing123.pdf';
            attach2.ContentType = 'image/tiff';
            attach2.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
        	insert attach2;
        
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsg);
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }*/
    
    public static testMethod void testAvantboxALICustomer_Weekday_not_RE() {
        User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-financial.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Hour';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr1.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Customer AFI';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
        mh.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
        mh.Active_Date__c = date.newInstance(2019, 12, 14);
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Customer AFI';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
        mh2.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
        mh2.Active_Date__c = date.newInstance(2019, 12, 14);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        Master_Holiday__c mh3 = new Master_Holiday__c();
        mh3.Name = 'Tes Master Holiday 3';
        mh3.Entity__c = 'AFI';
        mh3.Service_Type__c = 'Customer AFI';
        mh3.Type__c = 'Weekday';
        mh3.Description_ID__c = 'Tes Master Holiday 1';
        mh3.Description_EN__c = 'Tes Master Holiday 1';
        //mh3.Email_SMS_Template__c = listest[0].id;
        mh3.Email_SMS_Template__c = est.id;
        mh3.Start_Date_Time__c = null;
        mh3.End_Date_Time__c = null;
        mh3.Active_Date__c = null;
        mh3.Email_Header__c = est.Email_Header__c;
        mh3.Email_Body__c = est.Email_Body__c;
        mh3.Email_Footer__c = est.Email_Footer__c;
        mh3.Description_ID__c = 'Selamat Berlibur';
        mh3.Description_ID__c = 'Happy Holiday';
        insert mh3;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AfiInquiry;
            case1.Entity_Backup__c = 'AFI';
            case1.Type = 'Inquiry';
        	case1.Origin ='Email';
        	case1.Email_Inbox__c = 'customer@axa-financial.co.id';
            caselist.add(case1);
		    
            insert caselist;

            EmailMessage emailMsg = new EmailMessage(FromAddress = 'testafi@abc.org', Incoming = true, ToAddress= 'customer@axa-financial.co.id', 
                                              Headers =emailAFICustomerLong[1] ,CCAddress = 'testing123@yahoo.com', MessageDate = system.today(),
                                              Subject = 'Test P0000011', TextBody = '23456 ', ParentId = case1.id);
            system.debug('Insert 1 done');
            insert emailMsg;
        
            Attachment attach1 = new Attachment();
            attach1.ParentId = emailMsg.Id;
            attach1.Name = 'testing123.pdf';
            attach1.ContentType = 'image/tiff';
            attach1.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
            insert attach1;
        
        	Attachment attach2 = new Attachment();
            attach2.ParentId = emailMsg.Id;
            attach2.Name = 'testing123.pdf';
            attach2.ContentType = 'image/tiff';
            attach2.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
        	insert attach2;
        
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsg);
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }
    
    /*public static testMethod void testAvantboxALICustomer_Weekday_RE() {
        User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-financial.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr1.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Customer AFI';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
        mh.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
        mh.Active_Date__c = date.newInstance(2019, 12, 14);
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Customer AFI';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
        mh2.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
        mh2.Active_Date__c = date.newInstance(2019, 12, 14);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        Master_Holiday__c mh3 = new Master_Holiday__c();
        mh3.Name = 'Tes Master Holiday 3';
        mh3.Entity__c = 'AFI';
        mh3.Service_Type__c = 'Customer AFI';
        mh3.Type__c = 'Weekday';
        mh3.Description_ID__c = 'Tes Master Holiday 2';
        mh3.Description_EN__c = 'Tes Master Holiday 2';
        //mh3.Email_SMS_Template__c = listest[1].id;
        mh3.Email_SMS_Template__c = est2.id;
        mh3.Start_Date_Time__c = null;
        mh3.End_Date_Time__c = null;
        mh3.Active_Date__c = null;
        mh3.Email_Header__c = est2.Email_Header__c;
        mh3.Email_Body__c = est2.Email_Body__c;
        mh3.Email_Footer__c = est2.Email_Footer__c;
        mh3.Description_ID__c = 'Ada Peristiwa';
        mh3.Description_ID__c = 'There are Event';
        insert mh3;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AfiInquiry;
            case1.Entity_Backup__c = 'AFI';
            case1.Type = 'Inquiry';
        	case1.Origin ='Email';
        	//case1.OwnerId = usr1.Id;
            caselist.add(case1);
		    
            insert caselist;

            EmailMessage emailMsg = new EmailMessage(FromAddress = 'testafi@abc.org', Incoming = true, ToAddress= 'customer@axa-financial.co.id', 
                                              Headers =emailAFICustomerLong[1] ,CCAddress = 'testing123@yahoo.com',MessageDate = system.today(),
                                              Subject = 'RE: Test P0000088', TextBody = '23456 ', ParentId = case1.id);
            system.debug('Insert 1 done');
            insert emailMsg;
        
            Attachment attach1 = new Attachment();
            attach1.ParentId = emailMsg.Id;
            attach1.Name = 'testing123.pdf';
            attach1.ContentType = 'image/tiff';
            attach1.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
            insert attach1;
        
        	Attachment attach2 = new Attachment();
            attach2.ParentId = emailMsg.Id;
            attach2.Name = 'testing123.pdf';
            attach2.ContentType = 'image/tiff';
            attach2.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
        	insert attach2;
        
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsg);
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }*/
    
    //////////////////////////////////////
    //////////////////////////////////////
    //////////////////////////////////////
    
    public static testMethod void testAvantboxALIHelpline_Weekday_not_RE() {
        User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'helpline@axa-financial.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr1.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<b>Kepada Bapak/Ibu Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, Pertanyaan/permasalahan yang Anda sampaikan akan segera kami pelajari. Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br> <br>Hormat kami,<br><br><b> AXA Financial Indonesia</b> <br><br>AXA Tower Lantai GF <br/>Jl. Prof Dr. Satrio Kav. 18 <br/>Kuningan City, Jakarta Selatan 12940 <br/> <br/><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<b>Kepada Bapak/Ibu Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, Pertanyaan/permasalahan yang Anda sampaikan akan segera kami pelajari. Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br> <br>Hormat kami,<br><br><b> AXA Financial Indonesia</b> <br><br>AXA Tower Lantai GF <br/>Jl. Prof Dr. Satrio Kav. 18 <br/>Kuningan City, Jakarta Selatan 12940 <br/> <br/><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Helpline';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
        mh.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
        mh.Active_Date__c = date.newInstance(2019, 12, 14);
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Helpline';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
        mh2.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
        mh2.Active_Date__c = date.newInstance(2019, 12, 14);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        Master_Holiday__c mh3 = new Master_Holiday__c();
        mh3.Name = 'Tes Master Holiday 3';
        mh3.Entity__c = 'AFI';
        mh3.Service_Type__c = 'Helpline';
        mh3.Type__c = 'Weekday';
        mh3.Description_ID__c = 'Tes Master Holiday 3';
        mh3.Description_EN__c = 'Tes Master Holiday 3';
        //mh3.Email_SMS_Template__c = listest[1].id;
        mh3.Email_SMS_Template__c = est2.id;
        mh3.Start_Date_Time__c = null;
        mh3.End_Date_Time__c = null;
        mh3.Active_Date__c = null;
        mh3.Email_Header__c = est2.Email_Header__c;
        mh3.Email_Body__c = est2.Email_Body__c;
        mh3.Email_Footer__c = est2.Email_Footer__c;
        mh3.Description_ID__c = 'Ada Peristiwa';
        mh3.Description_ID__c = 'There are Event';
        insert mh3;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AfiInquiry;
            case1.Entity_Backup__c = 'AFI';
            case1.Type = 'Inquiry';
        	case1.Origin ='Email';
        	case1.Email_Inbox__c = 'helpline@axa-financial.co.id';
            caselist.add(case1);
		    
            insert caselist;

            EmailMessage emailMsg = new EmailMessage(FromAddress = 'testafi@abc.org', Incoming = true, ToAddress= 'helpline@axa-financial.co.id', 
                                              Headers =emailAFICustomerLong[1] ,CCAddress = 'testing123@yahoo.com', MessageDate = system.today(),
                                              Subject = 'Test P0000011', TextBody = '23456 ', ParentId = case1.id);
            system.debug('Insert 1 done');
            insert emailMsg;
        
            Attachment attach1 = new Attachment();
            attach1.ParentId = emailMsg.Id;
            attach1.Name = 'testing123.pdf';
            attach1.ContentType = 'image/tiff';
            attach1.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
            insert attach1;
        
        	Attachment attach2 = new Attachment();
            attach2.ParentId = emailMsg.Id;
            attach2.Name = 'testing123.pdf';
            attach2.ContentType = 'image/tiff';
            attach2.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
        	insert attach2;
        
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsg);
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }
    
    /*public static testMethod void testAvantboxALIHelpline_Weekday_RE() {
        User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'helpline@axa-financial.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr1.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<b>Kepada Bapak/Ibu Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, Pertanyaan/permasalahan yang Anda sampaikan akan segera kami pelajari. Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br> <br>Hormat kami,<br><br><b> AXA Financial Indonesia</b> <br><br>AXA Tower Lantai GF <br/>Jl. Prof Dr. Satrio Kav. 18 <br/>Kuningan City, Jakarta Selatan 12940 <br/> <br/><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<b>Kepada Bapak/Ibu Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, Pertanyaan/permasalahan yang Anda sampaikan akan segera kami pelajari. Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br> <br>Hormat kami,<br><br><b> AXA Financial Indonesia</b> <br><br>AXA Tower Lantai GF <br/>Jl. Prof Dr. Satrio Kav. 18 <br/>Kuningan City, Jakarta Selatan 12940 <br/> <br/><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Helpline';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
        mh.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
        mh.Active_Date__c = date.newInstance(2019, 12, 14);
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Helpline';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
        mh2.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
        mh2.Active_Date__c = date.newInstance(2019, 12, 14);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        Master_Holiday__c mh3 = new Master_Holiday__c();
        mh3.Name = 'Tes Master Holiday 3';
        mh3.Entity__c = 'AFI';
        mh3.Service_Type__c = 'Helpline';
        mh3.Type__c = 'Weekday';
        mh3.Description_ID__c = 'Tes Master Holiday 3';
        mh3.Description_EN__c = 'Tes Master Holiday 3';
        //mh3.Email_SMS_Template__c = listest[1].id;
        mh3.Email_SMS_Template__c = est2.id;
        mh3.Start_Date_Time__c = null;
        mh3.End_Date_Time__c = null;
        mh3.Active_Date__c = null;
        mh3.Email_Header__c = est2.Email_Header__c;
        mh3.Email_Body__c = est2.Email_Body__c;
        mh3.Email_Footer__c = est2.Email_Footer__c;
        mh3.Description_ID__c = 'Ada Peristiwa';
        mh3.Description_ID__c = 'There are Event';
        insert mh3;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AfiInquiry;
            case1.Entity_Backup__c = 'AFI';
            case1.Type = 'Inquiry';
        	case1.Origin ='Email';
        	//case1.OwnerId = usr1.Id;
        	case1.CreatedDate = system.today();
            caselist.add(case1);
		    
            insert caselist;

            EmailMessage emailMsg = new EmailMessage(FromAddress = 'testafi@abc.org', Incoming = true, ToAddress= 'helpline@axa-financial.co.id', 
                                              Headers =emailAFICustomerLong[1] ,CCAddress = 'testing123@yahoo.com', MessageDate = system.today(),
                                              Subject = 'RE: Test P0000088', TextBody = '23456 ', ParentId = case1.id);
            system.debug('Insert 1 done');
            insert emailMsg;
        
            Attachment attach1 = new Attachment();
            attach1.ParentId = emailMsg.Id;
            attach1.Name = 'testing123.pdf';
            attach1.ContentType = 'image/tiff';
            attach1.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
            insert attach1;
        
        	Attachment attach2 = new Attachment();
            attach2.ParentId = emailMsg.Id;
            attach2.Name = 'testing123.pdf';
            attach2.ContentType = 'image/tiff';
            attach2.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
        	insert attach2;
        
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsg);
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }*/
    
    public static testMethod void testAvantboxALI_to_Email_NoReply() {
        User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-financial.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr1.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Customer AFI';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = system.today();
        mh.End_Date_Time__c = system.today()+1;
        mh.Active_Date__c = date.valueOf(system.today()+2);
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Customer AFI';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = system.today();
        mh2.End_Date_Time__c = system.today()+1;
        mh2.Active_Date__c = date.valueOf(system.today()+2);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AfiInquiry;
            case1.Entity_Backup__c = 'AFI';
            case1.Type = 'Inquiry';
        	case1.Origin = 'Email';
        	case1.First_Case_Origin__c = '';
            case1.Assignment_Rules__c = TRUE;
            case1.First_Queue__c = 'Queue';
        	case1.Email_Inbox__c = 'customer@axa-financial.co.id';
            caselist.add(case1);
		    
            insert caselist;

            EmailMessage emailMsg = new EmailMessage(FromAddress = 'testafi@abc.org', Incoming = true, ToAddress= 'no-reply@axa-financial.co.id', 
                                              Headers =emailAFICustomerLong[1] ,CCAddress = 'testing123@yahoo.com', MessageDate = system.today(),
                                              Subject = 'RE: Test P0000011', TextBody = '23456 ', ParentId = case1.id);
            system.debug('Insert 1 done');
            insert emailMsg;
        
            Attachment attach1 = new Attachment();
            attach1.ParentId = emailMsg.Id;
            attach1.Name = 'testing123.pdf';
            attach1.ContentType = 'image/tiff';
            attach1.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
            insert attach1;
        
        	Attachment attach2 = new Attachment();
            attach2.ParentId = emailMsg.Id;
            attach2.Name = 'testing123.pdf';
            attach2.ContentType = 'image/tiff';
            attach2.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
        	insert attach2;
        
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsg);
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }
    
    public static testMethod void testAvantboxALICustomer_OutboundEmailMessage() {
        User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-financial.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Hour';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr1.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Customer AFI';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
        mh.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
        mh.Active_Date__c = date.newInstance(2019, 12, 14);
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Customer AFI';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
        mh2.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
        mh2.Active_Date__c = date.newInstance(2019, 12, 14);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        Master_Holiday__c mh3 = new Master_Holiday__c();
        mh3.Name = 'Tes Master Holiday 3';
        mh3.Entity__c = 'AFI';
        mh3.Service_Type__c = 'Customer AFI';
        mh3.Type__c = 'Weekday';
        mh3.Description_ID__c = 'Tes Master Holiday 1';
        mh3.Description_EN__c = 'Tes Master Holiday 1';
        //mh3.Email_SMS_Template__c = listest[0].id;
        mh3.Email_SMS_Template__c = est.id;
        mh3.Start_Date_Time__c = null;
        mh3.End_Date_Time__c = null;
        mh3.Active_Date__c = null;
        mh3.Email_Header__c = est.Email_Header__c;
        mh3.Email_Body__c = est.Email_Body__c;
        mh3.Email_Footer__c = est.Email_Footer__c;
        mh3.Description_ID__c = 'Selamat Berlibur';
        mh3.Description_ID__c = 'Happy Holiday';
        insert mh3;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AfiInquiry;
            case1.Entity_Backup__c = 'AFI';
            case1.Type = 'Inquiry';
        	case1.Origin ='Email';
        	case1.Email_Inbox__c = 'customer@axa-financial.co.id';
            case1.Assignment_Rules__c = FALSE;
            case1.First_Queue__c = '';
            caselist.add(case1);
		    
            insert caselist;

            EmailMessage emailMsg = new EmailMessage(FromAddress = 'testafi@abc.org', Incoming = FALSE, ToAddress= 'customer@axa-financial.co.id', 
                                              Headers =emailAFICustomerLong[1] ,CCAddress = 'testing123@yahoo.com', MessageDate = system.today(),
                                              Subject = 'Test P0000011', TextBody = '23456 ', ParentId = case1.id);
            system.debug('Insert 1 done');
            insert emailMsg;
        
            Attachment attach1 = new Attachment();
            attach1.ParentId = emailMsg.Id;
            attach1.Name = 'testing123.pdf';
            attach1.ContentType = 'image/tiff';
            attach1.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
            insert attach1;
        
        	Attachment attach2 = new Attachment();
            attach2.ParentId = emailMsg.Id;
            attach2.Name = 'testing123.pdf';
            attach2.ContentType = 'image/tiff';
            attach2.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
        	insert attach2;
        
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsg);
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }
    
    
    public static testMethod void testAvantboxALICustomer_InboundEmailMessage1() {
        User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-financial.co.id';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Hour';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr1.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Customer AFI';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
        mh.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
        mh.Active_Date__c = date.newInstance(2019, 12, 14);
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Customer AFI';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = datetime.newInstance(2019, 12, 12, 0, 0, 0);
        mh2.End_Date_Time__c = datetime.newInstance(2019, 12, 13, 0, 0, 0);
        mh2.Active_Date__c = date.newInstance(2019, 12, 14);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        Master_Holiday__c mh3 = new Master_Holiday__c();
        mh3.Name = 'Tes Master Holiday 3';
        mh3.Entity__c = 'AFI';
        mh3.Service_Type__c = 'Customer AFI';
        mh3.Type__c = 'Weekday';
        mh3.Description_ID__c = 'Tes Master Holiday 1';
        mh3.Description_EN__c = 'Tes Master Holiday 1';
        //mh3.Email_SMS_Template__c = listest[0].id;
        mh3.Email_SMS_Template__c = est.id;
        mh3.Start_Date_Time__c = null;
        mh3.End_Date_Time__c = null;
        mh3.Active_Date__c = null;
        mh3.Email_Header__c = est.Email_Header__c;
        mh3.Email_Body__c = est.Email_Body__c;
        mh3.Email_Footer__c = est.Email_Footer__c;
        mh3.Description_ID__c = 'Selamat Berlibur';
        mh3.Description_ID__c = 'Happy Holiday';
        insert mh3;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AfiInquiry;
            case1.Entity_Backup__c = 'AFI';
            case1.Type = 'Inquiry';
        	case1.Origin ='Email';
        	case1.Email_Inbox__c = 'customer@axa-financial.co.id';
            caselist.add(case1);
		    
            insert caselist;

            EmailMessage emailMsg = new EmailMessage(FromAddress = 'testafi@abc.org', Incoming = TRUE, ToAddress= 'customer@axa-financial.co.id', 
                                              Headers =emailAFICustomerLong[1] ,CCAddress = 'testing123@yahoo.com', MessageDate = datetime.newInstance(2020, 2, 25, 0, 0, 0),
                                              Subject = 'Test P0000011', TextBody = '23456 ', ParentId = case1.id);
            system.debug('Insert Inbound done');
            insert emailMsg;
        
        	/*EmailMessage emailMsg2 = new EmailMessage(FromAddress = 'customer@axa-financial.co.id', Incoming = FALSE, ToAddress= 'testafi@abc.org', 
                                              Headers = emailAFICustomerLong[1] ,CCAddress = 'testing123@yahoo.com', MessageDate = datetime.newInstance(2020, 2, 25, 0, 5, 0),
                                              Subject = 'RE: Test P0000011', TextBody = '23456 ', ParentId = case1.id, ReplyToEmailMessageId = emailMsg.Id);
            system.debug('Insert Outbound done');
            insert emailMsg2;*/
        
            Attachment attach1 = new Attachment();
            attach1.ParentId = emailMsg.Id;
            attach1.Name = 'testing123.pdf';
            attach1.ContentType = 'image/tiff';
            attach1.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
            insert attach1;
        
        	Attachment attach2 = new Attachment();
            attach2.ParentId = emailMsg.Id;
            attach2.Name = 'testing123.pdf';
            attach2.ContentType = 'image/tiff';
            attach2.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
        	insert attach2;
        
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsg);
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    }
    
    public static testMethod void testAvantboxALICustomer_InboundEmailMessage2() {
        
        datetime currDate = system.today();

        User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = emailCustomerAFI;
        ec1.Distribution_Type__c = 'Automatic';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Days';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 16;
        ec1.Last_Order_No__c = 0;
        emailConfigList.add(ec1); 
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr1.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
         
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/>[CONTACT_NAME]<b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b><br/> [CONTACT_NAME] <br/> [DESCRIPTION_ID] <br/> [DESCRIPTION_EN] <br/> [START_DATE_ID] <br/> [START_DATE_EN] <br/> [END_DATE_ID] <br/> [END_DATE_EN] <br/> [ACTIVE_DATE_ID] <br/> [ACTIVE_DATE_EN] ';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        // create email sms template 3 holiday afi
        Email_SMS_Template__c est3 = new Email_SMS_Template__c();
        est3.Name = 'Tes Email SMS Template 3';
        //est3.Category__c = 'Holiday';
        est3.Entity__c = 'AFI';
        est3.Subject__c = 'Tes Subject Email SMS Template 3';
        est3.Email_Header__c = 'Tes Header Email SMS Template 3';
        est3.Email_Body__c = '<br/>[DESCRIPTION_ID]<br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b> ';
        est3.Email_Footer__c = 'Tes Footer Email SMS Template 3';
        est3.Method__c = 'Email';
        insert est3;
        
        
        // create email sms template 4 holiday afi
        Email_SMS_Template__c est4 = new Email_SMS_Template__c();
        est4.Name = 'Tes Email SMS Template 4';
        //est4.Category__c = 'Holiday';
        est4.Entity__c = 'AFI';
        est4.Subject__c = 'Tes Subject Email SMS Template 4';
        est4.Email_Header__c = 'Tes Header Email SMS Template 4';
        est4.Email_Body__c = '<br/>[DESCRIPTION_EN]<br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b> ';
        est4.Email_Footer__c = 'Tes Footer Email SMS Template 4';
        est4.Method__c = 'Email';
        insert est4;
        
        
        // create email sms template 5 holiday afi
        Email_SMS_Template__c est5 = new Email_SMS_Template__c();
        est5.Name = 'Tes Email SMS Template 5';
        //est5.Category__c = 'Holiday';
        est5.Entity__c = 'AFI';
        est5.Subject__c = 'Tes Subject Email SMS Template 5';
        est5.Email_Header__c = 'Tes Header Email SMS Template 5';
        est5.Email_Body__c = '<br/>[START_DATE_ID]<br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b> ';
        est5.Email_Footer__c = 'Tes Footer Email SMS Template 5';
        est5.Method__c = 'Email';
        insert est5;
        
        
        // create email sms template 6 holiday afi
        Email_SMS_Template__c est6 = new Email_SMS_Template__c();
        est6.Name = 'Tes Email SMS Template 6';
        //est6.Category__c = 'Holiday';
        est6.Entity__c = 'AFI';
        est6.Subject__c = 'Tes Subject Email SMS Template 6';
        est6.Email_Header__c = 'Tes Header Email SMS Template 6';
        est6.Email_Body__c = '<br/>[START_DATE_EN]<br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b> ';
        est6.Email_Footer__c = 'Tes Footer Email SMS Template 6';
        est6.Method__c = 'Email';
        insert est6;
        
        
        // create email sms template 7 holiday afi
        Email_SMS_Template__c est7 = new Email_SMS_Template__c();
        est7.Name = 'Tes Email SMS Template 7';
        //est7.Category__c = 'Holiday';
        est7.Entity__c = 'AFI';
        est7.Subject__c = 'Tes Subject Email SMS Template 7';
        est7.Email_Header__c = 'Tes Header Email SMS Template 7';
        est7.Email_Body__c = '<br/>[END_DATE_ID]<br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b> ';
        est7.Email_Footer__c = 'Tes Footer Email SMS Template 7';
        est7.Method__c = 'Email';
        insert est7;
        
        
        // create email sms template 8 holiday afi
        Email_SMS_Template__c est8 = new Email_SMS_Template__c();
        est8.Name = 'Tes Email SMS Template 8';
        //est8.Category__c = 'Holiday';
        est8.Entity__c = 'AFI';
        est8.Subject__c = 'Tes Subject Email SMS Template 8';
        est8.Email_Header__c = 'Tes Header Email SMS Template 8';
        est8.Email_Body__c = '<br/>[END_DATE_EN]<br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b> ';
        est8.Email_Footer__c = 'Tes Footer Email SMS Template 8';
        est8.Method__c = 'Email';
        insert est8;
        
        
        // create email sms template 9 holiday afi
        Email_SMS_Template__c est9 = new Email_SMS_Template__c();
        est9.Name = 'Tes Email SMS Template 9';
        //est9.Category__c = 'Holiday';
        est9.Entity__c = 'AFI';
        est9.Subject__c = 'Tes Subject Email SMS Template 9';
        est9.Email_Header__c = 'Tes Header Email SMS Template 9';
        est9.Email_Body__c = '<br/>[ACTIVE_DATE_ID]<br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b> ';
        est9.Email_Footer__c = 'Tes Footer Email SMS Template 9';
        est9.Method__c = 'Email';
        insert est9;
        
        
        // create email sms template 10 holiday afi
        Email_SMS_Template__c est10 = new Email_SMS_Template__c();
        est10.Name = 'Tes Email SMS Template 10';
        //est10.Category__c = 'Holiday';
        est10.Entity__c = 'AFI';
        est10.Subject__c = 'Tes Subject Email SMS Template 10';
        est10.Email_Header__c = 'Tes Header Email SMS Template 10';
        est10.Email_Body__c = '<br/>[ACTIVE_DATE_EN] <br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b> ';
        est10.Email_Footer__c = 'Tes Footer Email SMS Template 10';
        est10.Method__c = 'Email';
        insert est10; 
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Customer AFI';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = currDate;
        mh.End_Date_Time__c = currDate+1;
        mh.Active_Date__c = date.valueOf(currDate+2);
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
         
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Customer AFI';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = System.today();
        mh2.End_Date_Time__c = System.today()+1;
        mh2.Active_Date__c = date.valueOf(System.today()+2);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        Master_Holiday__c mh3 = new Master_Holiday__c();
        mh3.Name = 'Tes Master Holiday 3';
        mh3.Entity__c = 'AFI';
        mh3.Service_Type__c = 'Customer AFI';
        mh3.Type__c = 'Weekday';
        mh3.Description_ID__c = 'Tes Master Holiday 1';
        mh3.Description_EN__c = 'Tes Master Holiday 1';
        //mh3.Email_SMS_Template__c = listest[0].id;
        mh3.Email_SMS_Template__c = est.id;
        mh3.Start_Date_Time__c = null;
        mh3.End_Date_Time__c = null;
        mh3.Active_Date__c = null;
        mh3.Email_Header__c = est.Email_Header__c;
        mh3.Email_Body__c = est.Email_Body__c;
        mh3.Email_Footer__c = est.Email_Footer__c;
        mh3.Description_ID__c = 'Selamat Berlibur';
        mh3.Description_ID__c = 'Happy Holiday';
        insert mh3;

        
         
        // create master holiday 4 event afi
        Master_Holiday__c mh4 = new Master_Holiday__c();
        mh4.Name = 'Sabtu';
        mh4.Entity__c = 'AFI';
        mh4.Service_Type__c = 'Customer AFI';
        mh4.Type__c = 'Weekend';
        mh4.Description_ID__c = 'Sabtu';
        mh4.Description_EN__c = 'Saturday';
        //mh4.Email_SMS_Template__c = listest[1].id;
        mh4.Email_SMS_Template__c = est2.id;
        mh4.Start_Date_Time__c = null;
        mh4.End_Date_Time__c = null;
        mh4.Active_Date__c = null;
        mh4.Email_Header__c = est2.Email_Header__c;
        mh4.Email_Body__c = est2.Email_Body__c;
        mh4.Email_Footer__c = est2.Email_Footer__c;
        mh4.Description_ID__c = 'Ada Peristiwa';
        mh4.Description_ID__c = 'There are Event';
        insert mh4; 

		 
        // create master holiday 1 holiday afi
        Master_Holiday__c mh5 = new Master_Holiday__c();
        mh5.Name = 'Minggu';
        mh5.Entity__c = 'AFI';
        mh5.Service_Type__c = 'Customer AFI';
        mh5.Type__c = 'Weekend';
        mh5.Description_ID__c = 'Minggu';
        mh5.Description_EN__c = 'Minggu';
        //mh5.Email_SMS_Template__c = listest[0].id;
        mh5.Start_Date_Time__c = null;
        mh5.End_Date_Time__c = null;
        mh5.Active_Date__c = null;
        mh5.Email_Header__c = est3.Email_Header__c;
        mh5.Email_Body__c = est3.Email_Body__c;
        mh5.Email_Footer__c = est3.Email_Footer__c;
        mh5.Description_ID__c = 'Selamat Berlibur';
        mh5.Description_ID__c = 'Happy weekend!';
        insert mh5;
        
         
        // create master holiday 1 holiday afi
        Master_Holiday__c mh6 = new Master_Holiday__c();
        mh6.Name = 'Tes Master Holiday 6';
        mh6.Entity__c = 'AFI';
        mh6.Service_Type__c = 'Customer AFI';
        mh6.Type__c = 'Holiday';
        mh6.Description_ID__c = 'Tes Master Holiday 6';
        mh6.Description_EN__c = 'Tes Master Holiday 6';
        //mh6.Email_SMS_Template__c = listest[0].id;
        mh6.Email_SMS_Template__c = est4.id;
        mh6.Start_Date_Time__c = System.today();
        mh6.End_Date_Time__c = System.today()+1;
        mh6.Active_Date__c = date.valueOf(System.today()+2);
        mh6.Email_Header__c = est4.Email_Header__c;
        mh6.Email_Body__c = est4.Email_Body__c;
        mh6.Email_Footer__c = est4.Email_Footer__c;
        mh6.Description_ID__c = 'Selamat Berlibur';
        mh6.Description_ID__c = 'Happy Holiday';
        insert mh6;
        
         
        // create master holiday 1 holiday afi
        Master_Holiday__c mh7 = new Master_Holiday__c();
        mh7.Name = 'Tes Master Holiday 7';
        mh7.Entity__c = 'AFI';
        mh7.Service_Type__c = 'Customer AFI';
        mh7.Type__c = 'Event';
        mh7.Description_ID__c = 'Tes Master Holiday 7';
        mh7.Description_EN__c = 'Tes Master Holiday 7';
        //mh7.Email_SMS_Template__c = listest[0].id;
        mh7.Email_SMS_Template__c = est5.id;
        mh7.Start_Date_Time__c = System.today();
        mh7.End_Date_Time__c = System.today()+1;
        mh7.Active_Date__c = date.valueOf(System.today()+2);
        mh7.Email_Header__c = est5.Email_Header__c;
        mh7.Email_Body__c = est5.Email_Body__c;
        mh7.Email_Footer__c = est5.Email_Footer__c;
        mh7.Description_ID__c = 'Selamat Berlibur';
        mh7.Description_ID__c = 'Happy Holiday';
        insert mh7;
        
         
        // create master holiday 1 holiday afi
        Master_Holiday__c mh8 = new Master_Holiday__c();
        mh8.Name = 'Tes Master Holiday 8';
        mh8.Entity__c = 'AFI';
        mh8.Service_Type__c = 'Customer AFI';
        mh8.Type__c = 'Holiday';
        mh8.Description_ID__c = 'Tes Master Holiday 8';
        mh8.Description_EN__c = 'Tes Master Holiday 8';
        //mh8.Email_SMS_Template__c = listest[0].id;
        mh8.Email_SMS_Template__c = est6.id;
        mh8.Start_Date_Time__c = System.today();
        mh8.End_Date_Time__c = System.today()+1;
        mh8.Active_Date__c = date.valueOf(System.today()+2);
        mh8.Email_Header__c = est6.Email_Header__c;
        mh8.Email_Body__c = est6.Email_Body__c;
        mh8.Email_Footer__c = est6.Email_Footer__c;
        mh8.Description_ID__c = 'Selamat Berlibur';
        mh8.Description_ID__c = 'Happy Holiday';
        insert mh8;
        
         
        // create master holiday 1 holiday afi
        Master_Holiday__c mh9 = new Master_Holiday__c();
        mh9.Name = 'Tes Master Holiday 9';
        mh9.Entity__c = 'AFI';
        mh9.Service_Type__c = 'Customer AFI';
        mh9.Type__c = 'Holiday';
        mh9.Description_ID__c = 'Tes Master Holiday 9';
        mh9.Description_EN__c = 'Tes Master Holiday 9';
        //mh9.Email_SMS_Template__c = listest[0].id;
        mh9.Email_SMS_Template__c = est7.id;
        mh9.Start_Date_Time__c = System.today();
        mh9.End_Date_Time__c = System.today()+1;
        mh9.Active_Date__c = date.valueOf(System.today()+2);
        mh9.Email_Header__c = est7.Email_Header__c;
        mh9.Email_Body__c = est7.Email_Body__c;
        mh9.Email_Footer__c = est7.Email_Footer__c;
        mh9.Description_ID__c = 'Selamat Berlibur';
        mh9.Description_ID__c = 'Happy Holiday';
        insert mh9;
        
         
        // create master holiday 1 holiday afi
        Master_Holiday__c mh10 = new Master_Holiday__c();
        mh10.Name = 'Tes Master Holiday 10';
        mh10.Entity__c = 'AFI';
        mh10.Service_Type__c = 'Customer AFI';
        mh10.Type__c = 'Event';
        mh10.Description_ID__c = 'Tes Master Holiday 10';
        mh10.Description_EN__c = 'Tes Master Holiday 10';
        //mh10.Email_SMS_Template__c = listest[0].id;
        mh10.Email_SMS_Template__c = est8.id;
        mh10.Start_Date_Time__c = System.today();
        mh10.End_Date_Time__c = System.today()+1;
        mh10.Active_Date__c = date.valueOf(System.today()+2);
        mh10.Email_Header__c = est8.Email_Header__c;
        mh10.Email_Body__c = est8.Email_Body__c;
        mh10.Email_Footer__c = est8.Email_Footer__c;
        mh10.Description_ID__c = 'Selamat Berlibur';
        mh10.Description_ID__c = 'Happy Holiday';
        insert mh10;
        
         
        // create master holiday 1 holiday afi
        Master_Holiday__c mh11 = new Master_Holiday__c();
        mh11.Name = 'Tes Master Holiday 11';
        mh11.Entity__c = 'AFI';
        mh11.Service_Type__c = 'Customer AFI';
        mh11.Type__c = 'Holiday';
        mh11.Description_ID__c = 'Tes Master Holiday 11';
        mh11.Description_EN__c = 'Tes Master Holiday 11';
        //mh11.Email_SMS_Template__c = listest[0].id;
        mh11.Email_SMS_Template__c = est9.id;
        mh11.Start_Date_Time__c = currDate;
        mh11.End_Date_Time__c = currDate+1;
        mh11.Active_Date__c = date.valueOf(currDate+2);
        mh11.Email_Header__c = est9.Email_Header__c;
        mh11.Email_Body__c = est9.Email_Body__c;
        mh11.Email_Footer__c = est9.Email_Footer__c;
        mh11.Description_ID__c = 'Selamat Berlibur';
        mh11.Description_ID__c = 'Happy Holiday';
        insert mh11;
        
         
        // create master holiday 1 holiday afi
        Master_Holiday__c mh12 = new Master_Holiday__c();
        mh12.Name = 'Tes Master Holiday 12';
        mh12.Entity__c = 'AFI';
        mh12.Service_Type__c = 'Customer AFI';
        mh12.Type__c = 'Holiday';
        mh12.Description_ID__c = 'Tes Master Holiday 12';
        mh12.Description_EN__c = 'Tes Master Holiday 12';
        //mh12.Email_SMS_Template__c = listest[0].id;
        mh12.Email_SMS_Template__c = est10.id;
        mh12.Start_Date_Time__c = currDate;
        mh12.End_Date_Time__c = currDate+1;
        mh12.Active_Date__c = date.valueOf(currDate+2);
        mh12.Email_Header__c = est10.Email_Header__c;
        mh12.Email_Body__c = est10.Email_Body__c;
        mh12.Email_Footer__c = est10.Email_Footer__c;
        mh12.Description_ID__c = 'Selamat Berlibur';
        mh12.Description_ID__c = 'Happy Holiday';
        insert mh12;
        
         
        // create master holiday 13 holiday afi
        Master_Holiday__c mh13 = new Master_Holiday__c();
        mh13.Name = 'Tes Master Holiday 13';
        mh13.Entity__c = 'AFI';
        mh13.Service_Type__c = 'Customer AFI';
        mh13.Type__c = 'Event';
        mh13.Description_ID__c = 'Tes Master Holiday 13';
        mh13.Description_EN__c = 'Tes Master Holiday 13';
        //mh13.Email_SMS_Template__c = listest[0].id;
        mh13.Email_SMS_Template__c = est10.id;
        mh13.Start_Date_Time__c = currDate;
        mh13.End_Date_Time__c = currDate+1;
        mh13.Active_Date__c = date.valueOf(currDate+2);
        mh13.Email_Header__c = est10.Email_Header__c;
        mh13.Email_Body__c = est10.Email_Body__c;
        mh13.Email_Footer__c = est10.Email_Footer__c;
        mh13.Description_ID__c = 'Ada acara kantor!';
        mh13.Description_ID__c = 'Happy Holiday';
        insert mh13; 
        //system.runAs(usr){ 
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AfiInquiry;
            case1.Entity_Backup__c = 'AFI';
            case1.Type = 'Inquiry';
        	case1.Origin ='Email'; 
        	case1.Email_Inbox__c = emailCustomerAFI;
            case1.e2cEmailToAddress__c = emailCustomerAFI;
            case1.BOD_Type__c = 'Level 1';
            case1.IsApproved__c = true; 
		    
            insert case1; 

            EmailMessage emailMsg = new EmailMessage(FromAddress = 'testafi@abc.org', Incoming = TRUE, ToAddress= emailCustomerAFI, 
                                              Headers = emailAFICustomerLong[1] ,CCAddress = 'testing123@yahoo.com', MessageDate = system.today(),
                                              Subject = 'Test P0000011', TextBody = '23456 ', ParentId = case1.id);
            system.debug('Insert Inbound done');
            insert emailMsg;  
        
        Test.stopTest();
    } 
    
    public static testMethod void testAvantboxALIHelpline_InboundEmailMessage2() {
        
        datetime currDate = system.today();

        User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>(); 
         
        Email_Config__c ec2 = new Email_Config__c();
        ec2.Email_Address__c = emailHelplineAFI;
        ec2.Distribution_Type__c = 'Automatic';
        ec2.SLA__c = '2';
        ec2.Unit__c = 'Days';
        ec2.Start_Working_Hour__c = 8;
        ec2.End_Working_Hour__c = 16;
        ec2.Last_Order_No__c = 0;
        emailConfigList.add(ec2);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>(); 
        
        Email_Assignment__c ea2 = new Email_Assignment__c();
        ea2.Inbox__c = ec2.Id;
        ea2.User__c = usr1.Id;
        ea2.Is_Active__c = true;
        eaList.add(ea2);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
        
        // create email sms template 1 holiday afi
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/>[CONTACT_NAME]<b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b><br/> [CONTACT_NAME] <br/> [DESCRIPTION_ID] <br/> [DESCRIPTION_EN] <br/> [START_DATE_ID] <br/> [START_DATE_EN] <br/> [END_DATE_ID] <br/> [END_DATE_EN] <br/> [ACTIVE_DATE_ID] <br/> [ACTIVE_DATE_EN] ';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2;
        
        // create email sms template 3 holiday afi
        Email_SMS_Template__c est3 = new Email_SMS_Template__c();
        est3.Name = 'Tes Email SMS Template 3';
        //est3.Category__c = 'Holiday';
        est3.Entity__c = 'AFI';
        est3.Subject__c = 'Tes Subject Email SMS Template 3';
        est3.Email_Header__c = 'Tes Header Email SMS Template 3';
        est3.Email_Body__c = '<br/>[DESCRIPTION_ID]<br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b> ';
        est3.Email_Footer__c = 'Tes Footer Email SMS Template 3';
        est3.Method__c = 'Email';
        insert est3;
        
        
        // create email sms template 4 holiday afi
        Email_SMS_Template__c est4 = new Email_SMS_Template__c();
        est4.Name = 'Tes Email SMS Template 4';
        //est4.Category__c = 'Holiday';
        est4.Entity__c = 'AFI';
        est4.Subject__c = 'Tes Subject Email SMS Template 4';
        est4.Email_Header__c = 'Tes Header Email SMS Template 4';
        est4.Email_Body__c = '<br/>[DESCRIPTION_EN]<br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b> ';
        est4.Email_Footer__c = 'Tes Footer Email SMS Template 4';
        est4.Method__c = 'Email';
        insert est4;
        
        
        // create email sms template 5 holiday afi
        Email_SMS_Template__c est5 = new Email_SMS_Template__c();
        est5.Name = 'Tes Email SMS Template 5';
        //est5.Category__c = 'Holiday';
        est5.Entity__c = 'AFI';
        est5.Subject__c = 'Tes Subject Email SMS Template 5';
        est5.Email_Header__c = 'Tes Header Email SMS Template 5';
        est5.Email_Body__c = '<br/>[START_DATE_ID]<br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b> ';
        est5.Email_Footer__c = 'Tes Footer Email SMS Template 5';
        est5.Method__c = 'Email';
        insert est5;
        
        
        // create email sms template 6 holiday afi
        Email_SMS_Template__c est6 = new Email_SMS_Template__c();
        est6.Name = 'Tes Email SMS Template 6';
        //est6.Category__c = 'Holiday';
        est6.Entity__c = 'AFI';
        est6.Subject__c = 'Tes Subject Email SMS Template 6';
        est6.Email_Header__c = 'Tes Header Email SMS Template 6';
        est6.Email_Body__c = '<br/>[START_DATE_EN]<br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b> ';
        est6.Email_Footer__c = 'Tes Footer Email SMS Template 6';
        est6.Method__c = 'Email';
        insert est6;
        
        
        // create email sms template 7 holiday afi
        Email_SMS_Template__c est7 = new Email_SMS_Template__c();
        est7.Name = 'Tes Email SMS Template 7';
        //est7.Category__c = 'Holiday';
        est7.Entity__c = 'AFI';
        est7.Subject__c = 'Tes Subject Email SMS Template 7';
        est7.Email_Header__c = 'Tes Header Email SMS Template 7';
        est7.Email_Body__c = '<br/>[END_DATE_ID]<br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b> ';
        est7.Email_Footer__c = 'Tes Footer Email SMS Template 7';
        est7.Method__c = 'Email';
        insert est7;
        
        
        // create email sms template 8 holiday afi
        Email_SMS_Template__c est8 = new Email_SMS_Template__c();
        est8.Name = 'Tes Email SMS Template 8';
        //est8.Category__c = 'Holiday';
        est8.Entity__c = 'AFI';
        est8.Subject__c = 'Tes Subject Email SMS Template 8';
        est8.Email_Header__c = 'Tes Header Email SMS Template 8';
        est8.Email_Body__c = '<br/>[END_DATE_EN]<br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b> ';
        est8.Email_Footer__c = 'Tes Footer Email SMS Template 8';
        est8.Method__c = 'Email';
        insert est8;
        
        
        // create email sms template 9 holiday afi
        Email_SMS_Template__c est9 = new Email_SMS_Template__c();
        est9.Name = 'Tes Email SMS Template 9';
        //est9.Category__c = 'Holiday';
        est9.Entity__c = 'AFI';
        est9.Subject__c = 'Tes Subject Email SMS Template 9';
        est9.Email_Header__c = 'Tes Header Email SMS Template 9';
        est9.Email_Body__c = '<br/>[ACTIVE_DATE_ID]<br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b> ';
        est9.Email_Footer__c = 'Tes Footer Email SMS Template 9';
        est9.Method__c = 'Email';
        insert est9;
        
        
        // create email sms template 10 holiday afi
        Email_SMS_Template__c est10 = new Email_SMS_Template__c();
        est10.Name = 'Tes Email SMS Template 10';
        //est10.Category__c = 'Holiday';
        est10.Entity__c = 'AFI';
        est10.Subject__c = 'Tes Subject Email SMS Template 10';
        est10.Email_Header__c = 'Tes Header Email SMS Template 10';
        est10.Email_Body__c = '<br/>[ACTIVE_DATE_EN] <br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b> ';
        est10.Email_Footer__c = 'Tes Footer Email SMS Template 10';
        est10.Method__c = 'Email';
        insert est10; 
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Customer AFI';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';
        //mh.Email_SMS_Template__c = listest[0].id;
        mh.Email_SMS_Template__c = est.id;
        mh.Start_Date_Time__c = currDate;
        mh.End_Date_Time__c = currDate+1;
        mh.Active_Date__c = date.valueOf(currDate+2);
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
         
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Customer AFI';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = System.today()+1;
        mh2.End_Date_Time__c = System.today()+2;
        mh2.Active_Date__c = date.valueOf(System.today()+3);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
        
        Master_Holiday__c mh3 = new Master_Holiday__c();
        mh3.Name = 'Tes Master Holiday 3';
        mh3.Entity__c = 'AFI';
        mh3.Service_Type__c = 'Customer AFI';
        mh3.Type__c = 'Weekday';
        mh3.Description_ID__c = 'Tes Master Holiday 1';
        mh3.Description_EN__c = 'Tes Master Holiday 1';
        //mh3.Email_SMS_Template__c = listest[0].id;
        mh3.Email_SMS_Template__c = est.id;
        mh3.Start_Date_Time__c = null;
        mh3.End_Date_Time__c = null;
        mh3.Active_Date__c = null;
        mh3.Email_Header__c = est.Email_Header__c;
        mh3.Email_Body__c = est.Email_Body__c;
        mh3.Email_Footer__c = est.Email_Footer__c;
        mh3.Description_ID__c = 'Selamat Berlibur';
        mh3.Description_ID__c = 'Happy Holiday';
        insert mh3;

        
         
        // create master holiday 4 event afi
        Master_Holiday__c mh4 = new Master_Holiday__c();
        mh4.Name = 'Sabtu';
        mh4.Entity__c = 'AFI';
        mh4.Service_Type__c = 'Customer AFI';
        mh4.Type__c = 'Weekend';
        mh4.Description_ID__c = 'Sabtu';
        mh4.Description_EN__c = 'Saturday';
        //mh4.Email_SMS_Template__c = listest[1].id;
        mh4.Email_SMS_Template__c = est2.id;
        mh4.Start_Date_Time__c = null;
        mh4.End_Date_Time__c = null;
        mh4.Active_Date__c = null;
        mh4.Email_Header__c = est2.Email_Header__c;
        mh4.Email_Body__c = est2.Email_Body__c;
        mh4.Email_Footer__c = est2.Email_Footer__c;
        mh4.Description_ID__c = 'Ada Peristiwa';
        mh4.Description_ID__c = 'There are Event';
        insert mh4; 

		 
        // create master holiday 1 holiday afi
        Master_Holiday__c mh5 = new Master_Holiday__c();
        mh5.Name = 'Minggu';
        mh5.Entity__c = 'AFI';
        mh5.Service_Type__c = 'Customer AFI';
        mh5.Type__c = 'Weekend';
        mh5.Description_ID__c = 'Minggu';
        mh5.Description_EN__c = 'Minggu';
        //mh5.Email_SMS_Template__c = listest[0].id;
        mh5.Start_Date_Time__c = null;
        mh5.End_Date_Time__c = null;
        mh5.Active_Date__c = null;
        mh5.Active_Date__c = date.valueOf(currDate+2);
        mh5.Email_Header__c = est3.Email_Header__c;
        mh5.Email_Body__c = est3.Email_Body__c;
        mh5.Email_Footer__c = est3.Email_Footer__c;
        mh5.Description_ID__c = 'Selamat Berlibur';
        mh5.Description_ID__c = 'Happy weekend!';
        insert mh5;
        
         
        // create master holiday 1 holiday afi
        Master_Holiday__c mh6 = new Master_Holiday__c();
        mh6.Name = 'Tes Master Holiday 6';
        mh6.Entity__c = 'AFI';
        mh6.Service_Type__c = 'Customer AFI';
        mh6.Type__c = 'Holiday';
        mh6.Description_ID__c = 'Tes Master Holiday 6';
        mh6.Description_EN__c = 'Tes Master Holiday 6';
        //mh6.Email_SMS_Template__c = listest[0].id;
        mh6.Email_SMS_Template__c = est4.id;
        mh6.Start_Date_Time__c = System.today();
        mh6.End_Date_Time__c = System.today()+1;
        mh6.Active_Date__c = date.valueOf(System.today()+2);
        mh6.Email_Header__c = est4.Email_Header__c;
        mh6.Email_Body__c = est4.Email_Body__c;
        mh6.Email_Footer__c = est4.Email_Footer__c;
        mh6.Description_ID__c = 'Selamat Berlibur';
        mh6.Description_ID__c = 'Happy Holiday';
        insert mh6;
        
         
        // create master holiday 1 holiday afi
        Master_Holiday__c mh7 = new Master_Holiday__c();
        mh7.Name = 'Tes Master Holiday 7';
        mh7.Entity__c = 'AFI';
        mh7.Service_Type__c = 'Customer AFI';
        mh7.Type__c = 'Event';
        mh7.Description_ID__c = 'Tes Master Holiday 7';
        mh7.Description_EN__c = 'Tes Master Holiday 7';
        //mh7.Email_SMS_Template__c = listest[0].id;
        mh7.Email_SMS_Template__c = est5.id;
        mh7.Start_Date_Time__c = System.today();
        mh7.End_Date_Time__c = System.today()+1;
        mh7.Active_Date__c = date.valueOf(System.today()+2);
        mh7.Email_Header__c = est5.Email_Header__c;
        mh7.Email_Body__c = est5.Email_Body__c;
        mh7.Email_Footer__c = est5.Email_Footer__c;
        mh7.Description_ID__c = 'Selamat Berlibur';
        mh7.Description_ID__c = 'Happy Holiday';
        insert mh7;
        
         
        // create master holiday 1 holiday afi
        Master_Holiday__c mh8 = new Master_Holiday__c();
        mh8.Name = 'Tes Master Holiday 8';
        mh8.Entity__c = 'AFI';
        mh8.Service_Type__c = 'Customer AFI';
        mh8.Type__c = 'Holiday';
        mh8.Description_ID__c = 'Tes Master Holiday 8';
        mh8.Description_EN__c = 'Tes Master Holiday 8';
        //mh8.Email_SMS_Template__c = listest[0].id;
        mh8.Email_SMS_Template__c = est6.id;
        mh8.Start_Date_Time__c = System.today();
        mh8.End_Date_Time__c = System.today()+1;
        mh8.Active_Date__c = date.valueOf(System.today()+2);
        mh8.Email_Header__c = est6.Email_Header__c;
        mh8.Email_Body__c = est6.Email_Body__c;
        mh8.Email_Footer__c = est6.Email_Footer__c;
        mh8.Description_ID__c = 'Selamat Berlibur';
        mh8.Description_ID__c = 'Happy Holiday';
        insert mh8;
        
         
        // create master holiday 1 holiday afi
        Master_Holiday__c mh9 = new Master_Holiday__c();
        mh9.Name = 'Tes Master Holiday 9';
        mh9.Entity__c = 'AFI';
        mh9.Service_Type__c = 'Customer AFI';
        mh9.Type__c = 'Holiday';
        mh9.Description_ID__c = 'Tes Master Holiday 9';
        mh9.Description_EN__c = 'Tes Master Holiday 9';
        //mh9.Email_SMS_Template__c = listest[0].id;
        mh9.Email_SMS_Template__c = est7.id;
        mh9.Start_Date_Time__c = System.today();
        mh9.End_Date_Time__c = System.today()+1;
        mh9.Active_Date__c = date.valueOf(System.today()+2);
        mh9.Email_Header__c = est7.Email_Header__c;
        mh9.Email_Body__c = est7.Email_Body__c;
        mh9.Email_Footer__c = est7.Email_Footer__c;
        mh9.Description_ID__c = 'Selamat Berlibur';
        mh9.Description_ID__c = 'Happy Holiday';
        insert mh9;
        
         
        // create master holiday 1 holiday afi
        Master_Holiday__c mh10 = new Master_Holiday__c();
        mh10.Name = 'Tes Master Holiday 10';
        mh10.Entity__c = 'AFI';
        mh10.Service_Type__c = 'Customer AFI';
        mh10.Type__c = 'Event';
        mh10.Description_ID__c = 'Tes Master Holiday 10';
        mh10.Description_EN__c = 'Tes Master Holiday 10';
        //mh10.Email_SMS_Template__c = listest[0].id;
        mh10.Email_SMS_Template__c = est8.id;
        mh10.Start_Date_Time__c = System.today();
        mh10.End_Date_Time__c = System.today()+1;
        mh10.Active_Date__c = date.valueOf(System.today()+2);
        mh10.Email_Header__c = est8.Email_Header__c;
        mh10.Email_Body__c = est8.Email_Body__c;
        mh10.Email_Footer__c = est8.Email_Footer__c;
        mh10.Description_ID__c = 'Selamat Berlibur';
        mh10.Description_ID__c = 'Happy Holiday';
        insert mh10;
        
         
        // create master holiday 1 holiday afi
        Master_Holiday__c mh11 = new Master_Holiday__c();
        mh11.Name = 'Tes Master Holiday 11';
        mh11.Entity__c = 'AFI';
        mh11.Service_Type__c = 'Customer AFI';
        mh11.Type__c = 'Holiday';
        mh11.Description_ID__c = 'Tes Master Holiday 11';
        mh11.Description_EN__c = 'Tes Master Holiday 11';
        //mh11.Email_SMS_Template__c = listest[0].id;
        mh11.Email_SMS_Template__c = est9.id;
        mh11.Start_Date_Time__c = currDate;
        mh11.End_Date_Time__c = currDate+1;
        mh11.Active_Date__c = date.valueOf(currDate+2);
        mh11.Email_Header__c = est9.Email_Header__c;
        mh11.Email_Body__c = est9.Email_Body__c;
        mh11.Email_Footer__c = est9.Email_Footer__c;
        mh11.Description_ID__c = 'Selamat Berlibur';
        mh11.Description_ID__c = 'Happy Holiday';
        insert mh11;
        
         
        // create master holiday 1 holiday afi
        Master_Holiday__c mh12 = new Master_Holiday__c();
        mh12.Name = 'Tes Master Holiday 12';
        mh12.Entity__c = 'AFI';
        mh12.Service_Type__c = 'Customer AFI';
        mh12.Type__c = 'Holiday';
        mh12.Description_ID__c = 'Tes Master Holiday 12';
        mh12.Description_EN__c = 'Tes Master Holiday 12';
        //mh12.Email_SMS_Template__c = listest[0].id;
        mh12.Email_SMS_Template__c = est10.id;
        mh12.Start_Date_Time__c = currDate;
        mh12.End_Date_Time__c = currDate+1;
        mh12.Active_Date__c = date.valueOf(currDate+2);
        mh12.Email_Header__c = est10.Email_Header__c;
        mh12.Email_Body__c = est10.Email_Body__c;
        mh12.Email_Footer__c = est10.Email_Footer__c;
        mh12.Description_ID__c = 'Selamat Berlibur';
        mh12.Description_ID__c = 'Happy Holiday';
        insert mh12;
        
         
        // create master holiday 13 holiday afi
        Master_Holiday__c mh13 = new Master_Holiday__c();
        mh13.Name = 'Tes Master Holiday 13';
        mh13.Entity__c = 'AFI';
        mh13.Service_Type__c = 'Customer AFI';
        mh13.Type__c = 'Event';
        mh13.Description_ID__c = 'Tes Master Holiday 13';
        mh13.Description_EN__c = 'Tes Master Holiday 13';
        //mh13.Email_SMS_Template__c = listest[0].id;
        mh13.Email_SMS_Template__c = est10.id;
        mh13.Start_Date_Time__c = currDate;
        mh13.End_Date_Time__c = currDate+1;
        mh13.Active_Date__c = date.valueOf(currDate+2);
        mh13.Email_Header__c = est10.Email_Header__c;
        mh13.Email_Body__c = est10.Email_Body__c;
        mh13.Email_Footer__c = est10.Email_Footer__c;
        mh13.Description_ID__c = 'Ada acara kantor!';
        mh13.Description_ID__c = 'Happy Holiday';
        insert mh13;  

        //system.runAs(usr){
 
            Case case2 = new Case();
            case2.ContactId = con1.Id;
            case2.RecordTypeId = AfiInquiry;
            case2.Type = 'Inquiry';
        	case2.Origin ='Email';
        	case2.Email_Inbox__c = emailHelplineAFI;
            case2.e2cEmailToAddress__c = emailHelplineAFI;
            case2.BOD_Type__c = 'Level 1';
            case2.IsApproved__c = true;  
            insert case2;
 
            

            EmailMessage emailMsg2 = new EmailMessage(FromAddress = 'testafi@abc.org', Incoming = TRUE, ToAddress= emailHelplineAFI, 
                                              Headers = emailAFICustomerLong[1] ,CCAddress = 'testing123@yahoo.com', MessageDate = system.today(),
                                              Subject = 'Test P0000011', TextBody = '23456 ', ParentId = case2.id);
            system.debug('Insert Inbound done');
            insert emailMsg2; 

            
            case updateCase = new case(
                id = case2.id,
                BOD_Type__c = 'Level 2'
            );
        
        Test.stopTest();
    } 
    
    public static testMethod void testAvantboxALIHelpline_InboundEmailMessage3() {
        
        datetime currDate = system.today();

        User usr1 = [SELECT Id FROM User WHERE UserName = 'agent01@axa.co.id' LIMIT 1];
        User usr3 = [SELECT Id FROM User WHERE UserName = 'agent03@axa.co.id' LIMIT 1];
        Test.startTest();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>(); 
         
        Email_Config__c ec2 = new Email_Config__c();
        ec2.Email_Address__c = emailHelplineAFI;
        ec2.Distribution_Type__c = 'Automatic';
        ec2.SLA__c = '24';
        ec2.Unit__c = 'Hour';
        ec2.Start_Working_Hour__c = 8;
        ec2.End_Working_Hour__c = 16;
        ec2.Last_Order_No__c = 0;
        emailConfigList.add(ec2);
        
        insert emailConfigList;
        
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>(); 
        
        Email_Assignment__c ea2 = new Email_Assignment__c();
        ea2.Inbox__c = ec2.Id;
        ea2.User__c = usr1.Id;
        ea2.Is_Active__c = true;
        eaList.add(ea2);
        
        insert eaList;
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'testafi@abc.org';
        con1.MobilePhone = '88888';
        contactList.add(con1);
        insert contactList;
         
        // create email sms template 2 event afi
        Email_SMS_Template__c est2 = new Email_SMS_Template__c();
        est2.Name = 'Tes Email SMS Template 2';
        est2.Category__c = 'Other';
        est2.Entity__c = 'AFI';
        est2.Subject__c = 'Tes Subject Email SMS Template 2';
        est2.Email_Header__c = 'Tes Header Email SMS Template 2';
        est2.Email_Body__c = '<br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est2.Email_Footer__c = 'Tes Footer Email SMS Template 2';
        est2.Method__c = 'Email';
        insert est2; 
        
        
        // create email sms template 5 holiday afi
        Email_SMS_Template__c est5 = new Email_SMS_Template__c();
        est5.Name = 'Tes Email SMS Template 5';
        //est5.Category__c = 'Holiday';
        est5.Entity__c = 'AFI';
        est5.Subject__c = 'Tes Subject Email SMS Template 5';
        est5.Email_Header__c = 'Tes Header Email SMS Template 5';
        est5.Email_Body__c = '<br/>[START_DATE_ID]<br/><b>Kepada Nasabah Yang Terhormat,</b> <br><br>Terima kasih atas Email Anda, pertanyaan dan permasalahan yang Anda sampaikan akan segera kami pelajari.<br><br>Kami akan menjawab email Anda paling lambat pada hari kerja berikutnya.<br><br>Anda juga dapat menghubungi layanan Call Center AXA Financial Indonesia pada hari Senin – Jumat pukul 08.00 – 20.00 WIB, Sabtu pukul 08.00 – 12.00 WIB, kami tidak beroperasi pada hari Minggu dan Libur Nasional.<br><br>Hormat kami,<br><br><b>Customer Care AXA Financial Indonesia</b> <br><br>Call Centre Telemarketing : <b>1500 940</b> (kemudian <b>tekan 2</b>) | Email: <a href="mailto:nasabah@axa-financial.co.id" target="_top">nasabah@axa-financial.co.id</a> | Portal: <a href="https://portal.axa.co.id/direct">https://portal.axa.co.id/direct</a> <br><br><b>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b> ';
        est5.Email_Footer__c = 'Tes Footer Email SMS Template 5';
        est5.Method__c = 'Email';
        insert est5; 
        
        //search email sms template
        //List<Email_SMS_Template__c> listest = [SELECT id, name FROM Email_SMS_Template__c];
         
         
        // create master holiday 2 event afi
        Master_Holiday__c mh2 = new Master_Holiday__c();
        mh2.Name = 'Tes Master Holiday 2';
        mh2.Entity__c = 'AFI';
        mh2.Service_Type__c = 'Customer AFI';
        mh2.Type__c = 'Event';
        mh2.Description_ID__c = 'Tes Master Holiday 2';
        mh2.Description_EN__c = 'Tes Master Holiday 2';
        //mh2.Email_SMS_Template__c = listest[1].id;
        mh2.Email_SMS_Template__c = est2.id;
        mh2.Start_Date_Time__c = System.today()+1;
        mh2.End_Date_Time__c = System.today()+2;
        mh2.Active_Date__c = date.valueOf(System.today()+3);
        mh2.Email_Header__c = est2.Email_Header__c;
        mh2.Email_Body__c = est2.Email_Body__c;
        mh2.Email_Footer__c = est2.Email_Footer__c;
        mh2.Description_ID__c = 'Ada Peristiwa';
        mh2.Description_ID__c = 'There are Event';
        insert mh2;
            
         
        // create master holiday 1 holiday afi
        Master_Holiday__c mh7 = new Master_Holiday__c();
        mh7.Name = 'Tes Master Holiday 7';
        mh7.Entity__c = 'AFI';
        mh7.Service_Type__c = 'Customer AFI';
        mh7.Type__c = 'Event';
        mh7.Description_ID__c = 'Tes Master Holiday 7';
        mh7.Description_EN__c = 'Tes Master Holiday 7';
        //mh7.Email_SMS_Template__c = listest[0].id;
        mh7.Email_SMS_Template__c = est5.id;
        mh7.Start_Date_Time__c = System.today()+2;
        mh7.End_Date_Time__c = System.today()+3;
        mh7.Active_Date__c = date.valueOf(System.today()+4);
        mh7.Email_Header__c = est5.Email_Header__c;
        mh7.Email_Body__c = est5.Email_Body__c;
        mh7.Email_Footer__c = est5.Email_Footer__c;
        mh7.Description_ID__c = 'Selamat Berlibur';
        mh7.Description_ID__c = 'Happy Holiday';
        insert mh7;
        
              
          
        //system.runAs(usr){
  
            Case case2 = new Case();
            case2.ContactId = con1.Id;
            case2.RecordTypeId = AfiInquiry;
            case2.Entity_Backup__c = 'AFI';
            case2.Type = 'Inquiry';
        	case2.Origin = 'Email';
        	case2.First_Case_Origin__c = '';
            case2.Assignment_Rules__c = TRUE;
            case2.First_Queue__c = 'Queue';
        	case2.Email_Inbox__c = emailHelplineAFI;
            insert case2;
   
            EmailMessage emailMsg2 = new EmailMessage(FromAddress = 'testafi@abc.org', Incoming = TRUE, ToAddress= emailHelplineAFI, 
                                              Headers = emailAFICustomerLong[1] ,CCAddress = 'testing123@yahoo.com', MessageDate = system.today(),
                                              Subject = 'Test HELPLINE!!', TextBody = '23456 ', ParentId = case2.id);
            system.debug('Insert Inbound done');
            insert emailMsg2;  
        
            Attachment attach1 = new Attachment();
            attach1.ParentId = emailMsg2.Id;
            attach1.Name = 'testing123.pdf';
            attach1.ContentType = 'image/tiff';
            attach1.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
            insert attach1;
        
        	Attachment attach2 = new Attachment();
            attach2.ParentId = emailMsg2.Id;
            attach2.Name = 'testing123.pdf';
            attach2.ContentType = 'image/tiff';
            attach2.Body = Blob.valueOf('/services/data/v40.0/sobjects/Attachment/00Pp0000005NBzEEAW/Body');
        	insert attach2;
        
        ApexPages.StandardController con = new ApexPages.StandardController(emailMsg2);
        deletedAttachmentController delAtt = new deletedAttachmentController(con);
        
        Test.stopTest();
    } 

    
    public static testMethod void testCaseBODTypeAMFS() {
        
        Test.startTest();
        
        //Added by Hamfry (2015-05-04)
        String caseid = '';
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId(); 
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AMFS';
        con1.Email = 'test1@abc.org';
        con1.MobilePhone = '11111';
        contactList.add(con1);
        insert contactList;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AmfsInquiry;
            case1.Entity_Backup__c = 'AMFS';
            case1.Type = 'Inquiry';
            case1.BOD_Type__c = 'Level 1';
            case1.IsApproved__c = true;
            caselist.add(case1);
		    
            insert caselist;  
        Test.stopTest();
    }
 
    public static testMethod void testCaseBODTypeMAGI() {
        
        Test.startTest();
        
        //Added by Hamfry (2015-05-04)
        String caseid = '';
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId(); 
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'MAGI';
        con1.Email = 'test1@abc.org';
        con1.MobilePhone = '11111';
        contactList.add(con1);
        insert contactList;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = MagiInquiry;
            case1.Entity_Backup__c = 'MAGI';
            case1.Type = 'Inquiry';
            case1.BOD_Type__c = 'Level 1';
            case1.IsApproved__c = true;
            caselist.add(case1);
		    
            insert caselist;  
        Test.stopTest();
    }

    
    public static testMethod void testCaseEmptyEntity() {
        
        Test.startTest();
        
        //Added by Hamfry (2015-05-04)
        String caseid = '';
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId(); 
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AMFS';
        con1.Email = 'test1@abc.org';
        con1.MobilePhone = '11111';
        contactList.add(con1);
        insert contactList;
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AmfsInquiry;
            case1.Type = 'Inquiry'; 
            case1.Nature_Config__c = 'Claim';
            caselist.add(case1);
		    
            insert caselist;  

            case updateCase = new case(
                id = case1.id,
                Nature_Config__c = 'Claims'
            );
        Test.stopTest();
    }
    
    public static testMethod void testCaseSkill() {
        
        Test.startTest();
        
        //Added by Hamfry (2015-05-04)
        String caseid = '';
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId(); 
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AMFS';
        con1.Email = 'test1@abc.org';
        con1.MobilePhone = '11111';
        contactList.add(con1);
        insert contactList;

        // skillList = [SELECT Name, Last_Order_No__c, Nature__c, Category__c FROM Skill_of_Nature_Category__c WHERE Entity__c=:entityCase AND  Status__c =: 'Active'];

        Skill_of_Nature_Category__c skill = new Skill_of_Nature_Category__c();
        skill.Name = 'Skill 1';
        skill.Last_Order_No__c = 1;
        skill.Nature__c = 'All';
        skill.Category__c = 'All';
        skill.Entity__c = 'AMFS';
        skill.Status__c = 'Active';
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AmfsInquiry;
            case1.Type = 'Inquiry'; 
            caselist.add(case1);
		    
            insert caselist;   
        Test.stopTest();
    }

    
    
    public static testMethod void testCaseUpdateSkill() {
        
        Test.startTest();
        
        //Added by Hamfry (2015-05-04)
        String caseid = '';
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId(); 
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AMFS';
        con1.Email = 'test1@abc.org';
        con1.MobilePhone = '11111';
        contactList.add(con1);
        insert contactList;

        // skillList = [SELECT Name, Last_Order_No__c, Nature__c, Category__c FROM Skill_of_Nature_Category__c WHERE Entity__c=:entityCase AND  Status__c =: 'Active'];

        Skill_of_Nature_Category__c skill = new Skill_of_Nature_Category__c();
        skill.Name = 'Skill 1';
        skill.Last_Order_No__c = 1;
        skill.Nature__c = 'All';
        skill.Category__c = 'All';
        skill.Entity__c = 'AMFS';
        skill.Status__c = 'Active';
        
        //system.runAs(usr){
            List<Case> caselist = new List<Case>();
            Case case1 = new Case();
            case1.ContactId = con1.Id;
            case1.RecordTypeId = AmfsInquiry;
            case1.Type = 'Inquiry'; 
            case1.Nature__c = 'Claim';
            case1.Nature_Config__c = 'All';
            caselist.add(case1);
		    
            insert caselist;   
        Test.stopTest();
    }
}