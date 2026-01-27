@isTest
public class Email2CaseController_AFI_ALI_Test {
    
    public static testMethod void Email2CaseControllerAFIALITest(){
        Test.startTest();
        List<Case> caseList = new List<Case>();
        List<Contact> contactList = new List<Contact>();
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AFI' limit 1]; 
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AMFS' limit 1]; 
        Profile agentProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%MAGI' limit 1];
        Profile agentProfileALI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%ALI' limit 1]; 
        
        Profile spvProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AFI' limit 1]; 
        Profile spvProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AMFS' limit 1]; 
        Profile spvProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%MAGI' limit 1]; 
        Profile spvProfileALI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%ALI' limit 1]; 
        
        List<User> spvList = new List<User>();
        User loginAFIUser = new User(Alias = 'spv1', Email='spvAfi@axa.co.id', 
                                     EmailEncodingKey='UTF-8', LastName='spvAfi', LanguageLocaleKey='en_US', 
                                     LocaleSidKey='en_US', ProfileId = spvProfileAFI.Id, Entity__c = 'AFI', 
                                     TimeZoneSidKey='Asia/Jakarta', UserName='spvAfi@axa.co.id', isActive = true);
        spvList.add(loginAFIUser);
        
        User loginAMFSUser = new User(Alias = 'spv2', Email='spvAmfs@axa.co.id', 
                                      EmailEncodingKey='UTF-8', LastName='spvAmfs', LanguageLocaleKey='en_US', 
                                      LocaleSidKey='en_US', ProfileId = spvProfileAMFS.Id, Entity__c = 'AMFS',
                                      TimeZoneSidKey='Asia/Jakarta', UserName='spvAmfs@axa.co.id', isActive = true);
        spvList.add(loginAMFSUser);
        
        User loginMAGIUser = new User(Alias = 'spv3', Email='spvMagi@axa.co.id', 
                                      EmailEncodingKey='UTF-8', LastName='spvMagi', LanguageLocaleKey='en_US', 
                                      LocaleSidKey='en_US', ProfileId = spvProfileMAGI.Id, Entity__c = 'MAGI',
                                      TimeZoneSidKey='Asia/Jakarta', UserName='spvMagi@axa.co.id', isActive = true);
        spvList.add(loginMAGIUser);
        
        User loginALIUser = new User(Alias = 'spv4', Email='spvAli@axa.co.id', 
                                     EmailEncodingKey='UTF-8', LastName='spvAli', LanguageLocaleKey='en_US', 
                                     LocaleSidKey='en_US', ProfileId = spvProfileALI.Id, Entity__c = 'ALI', 
                                     TimeZoneSidKey='Asia/Jakarta', UserName='spvAli@axa.co.id', isActive = true);
        spvList.add(loginALIUser);
        insert spvList;
        
        List<User> agentList = new List<User>();
        User subOrdinateAFIUser = new User(Alias = 'agent1', Email='agentAfi@axa.co.id', 
                                           EmailEncodingKey='UTF-8', LastName='agentAfi', LanguageLocaleKey='en_US', 
                                           LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, managerId = loginAFIUser.id, Entity__c = 'AFI',
                                           TimeZoneSidKey='Asia/Jakarta', UserName='agentAfi@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateAFIUser);
        
        User subOrdinateAMFSUser = new User(Alias = 'agent2', Email='agentAmfs@axa.co.id', 
                                            EmailEncodingKey='UTF-8', LastName='agentAmfs', LanguageLocaleKey='en_US', 
                                            LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = loginAMFSUser.id, Entity__c = 'AMFS',
                                            TimeZoneSidKey='Asia/Jakarta', UserName='agentAmfs@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateAMFSUser);
        
        User subOrdinateMAGIUser = new User(Alias = 'agent3', Email='agentMagi@axa.co.id', 
                                            EmailEncodingKey='UTF-8', LastName='agentMagi', LanguageLocaleKey='en_US', 
                                            LocaleSidKey='en_US', ProfileId = agentProfileMAGI.Id, managerId = loginMAGIUser.id, Entity__c = 'MAGI',
                                            TimeZoneSidKey='Asia/Jakarta', UserName='agentMagi@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateMAGIUser);
        
        User subOrdinateALIUser = new User(Alias = 'agent4', Email='agentAli@axa.co.id', 
                                           EmailEncodingKey='UTF-8', LastName='agentAli', LanguageLocaleKey='en_US', 
                                           LocaleSidKey='en_US', ProfileId = agentProfileALI.Id, managerId = loginALIUser.id, Entity__c = 'ALI',
                                           TimeZoneSidKey='Asia/Jakarta', UserName='agentAli@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateALIUser);
        insert agentList;
        
        Contact con1 = new Contact();
        con1.FirstName = 'Hamfry';
        con1.LastName = 'Lantu';
        con1.Policy_No__c = '1234-56781';
        contactList.add(con1);
        
        Contact con2 = new Contact();
        con2.FirstName = 'Hamfry';
        con2.LastName = 'Lantoe';
        con2.Policy_No__c = '1234-56782';
        contactList.add(con2);
        
        Contact con3 = new Contact();
        con3.FirstName = 'Hamfree';
        con3.LastName = 'Lantwo';
        con3.Policy_No__c = '1234-56783';
        contactList.add(con3);
        
        Contact con4 = new Contact();
        con4.FirstName = 'Hamfrees';
        con4.LastName = 'Lantwos';
        con4.Policy_No__c = '1234-56784';
        contactList.add(con4);
        insert contactList;
        
        
        User_Detail__c ud = new User_Detail__c();
        ud.Entity__c = 'AMFS';
        ud.Subject_Case__c = 'ILCCYS';
        ud.User__c = subOrdinateAMFSUser.Id;
        insert ud;
        
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Test Email SMS Template 1';
        //est.Category__c = 'Holiday';
        est.Entity__c = 'AFI';
        est.Email_Header__c = 'header';
        est.Email_Body__c = 'body';
        est.Email_Footer__c = 'footer';
        est.Method__c = 'Email';
        insert est;
        
        
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Test Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Customer AFI';
        mh.Type__c = 'Holiday';
        mh.Start_Date_Time__c = DateTime.newInstance(2020,1,30);
        mh.End_Date_Time__c = DateTime.newInstance(2020,2,4);
        mh.Email_SMS_Template__c = est.Id;
        insert mh;
        
        Id userId = ud.User__c;
        
        Case cs1 = new Case();
        cs1.Entity_Backup__c = 'AFI';
        cs1.Origin = 'Email';
        cs1.Status ='New';
        cs1.suppliedEmail = 'testing123@nyaho.com';
        cs1.Policy_Number__c = con1.Policy_No__c;
        cs1.ContactId = con1.Id;
        cs1.Status = 'New';
        cs1.Subject = 'ILCCYS';
        cs1.Type = 'Inquiry';
        cs1.Case_Type_Config__c = 'Inquiry Status';
        cs1.Description = 'testing for test class';
        cs1.OwnerId = subOrdinateAFIUser.Id;
        cs1.e2cEmailTo__c = 'customer@axa-financial.co.id';
        caseList.add(cs1);
        
        Case cs2 = new Case();
        cs2.Entity_Backup__c = 'AMFS';
        cs2.Origin = 'Email';
        cs2.Status ='New';
        cs2.suppliedEmail = 'testing234@nyaho.com';
        cs1.Policy_Number__c = con2.Policy_No__c;
        cs2.ContactId = con2.Id;
        cs2.Status = 'New';
        cs2.Subject = 'ILCCYS';
        cs2.Type = 'Inquiry';
        cs2.Case_Type_Config__c = 'Inquiry Status';
        cs2.Description = '';
        cs2.OwnerId = userId;
        cs2.e2cEmailTo__c = 'customer@axa-mandiri.co.id';
        caseList.add(cs2);
        
        Case cs3 = new Case();
        cs3.Entity_Backup__c = 'MAGI';
        cs3.Origin = 'Email';
        cs3.Status ='New';
        cs3.suppliedEmail = 'testing345@nyaho.com';
        cs3.Policy_Number__c = con3.Policy_No__c;
        cs3.ContactId = con3.Id;
        cs3.Status = 'New';
        cs3.Subject = 'ILCCYS';
        cs3.Type = 'Inquiry';
        cs3.Case_Type_Config__c = 'Inquiry Status';
        cs3.Description = 'testing for test class';
        cs3.OwnerId = subOrdinateMAGIUser.Id;
        cs3.e2cEmailTo__c = 'customer-general@axa-mandiri.co.id';
        caseList.add(cs3);
        
        Case cs4 = new Case();
        cs4.Entity_Backup__c = 'ALI';
        cs4.Origin = 'Email';
        cs4.Status ='New';
        cs4.suppliedEmail = 'testing564@nyaho.com';
        cs4.Policy_Number__c = con4.Policy_No__c;
        cs4.ContactId = con4.Id;
        cs4.Status = 'New';
        cs4.Subject = 'ILCCYS';
        cs4.Type = 'Inquiry';
        cs4.Case_Type_Config__c = 'Inquiry Status';
        cs4.Description = 'testing for test class';
        cs4.OwnerId = subOrdinateALIUser.Id;
        cs4.e2cEmailTo__c = 'customer@axa-financial.co.id';
        caseList.add(cs4);
        insert caseList;
        
        /*EmailMessage em = new EmailMessage();
        em.ParentId = cs1.Id;
        em.Subject = 'ILCCYS';
        em.ToAddress = 'customer@axa-mandiri.co.id';
        em.CreatedDate = DateTime.newInstance(2020,2,1);
        insert em;*/
        
        //Test.stopTest();
        
        List<Call_Line__c> callLineList = new List<Call_Line__c>();
        Call_Line__c cl1 = new Call_Line__c();
        cl1.Contact__c = cs2.ContactId;
        cl1.Policy_No__c = cs2.Policy_Number__c;
        cl1.OwnerId = cs2.OwnerId;
        callLineList.add(cl1);
        
        insert callLineList;
        
        List<Email_Config__c> emailCfgList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-financial.co.id';
        ec1.Entity__c = 'AFI';
        ec1.Distribution_Type__c = 'Manual';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        emailCfgList.add(ec1);
        
        Email_Config__c ec2 = new Email_Config__c();
        ec2.Email_Address__c = 'customer@axa-financial.co.id';
        ec2.Entity__c = 'AFI';
        ec2.Distribution_Type__c = 'Automatic';
        ec2.SLA__c = '2';
        ec2.Unit__c = 'Hour';
        emailCfgList.add(ec2);
        
        insert emailCfgList;
        
        system.runAs(loginAFIUser){
            Email2CaseController_AFI_ALI.CaseWrapper wrap = new Email2CaseController_AFI_ALI.CaseWrapper();
            wrap.id = cs1.Id;
            wrap.isSelected = true;
            wrap.indikator = cs1.Indicator__c;
            wrap.followUp = cs1.Follow_Up_Flag__c;
            wrap.caseNumber = cs1.CaseNumber ; 
            wrap.senderEmail = cs1.SuppliedEmail;
            wrap.toAddress = 'customer@axa-financial.co.id'; 
            wrap.customerName = cs1.Contact.Name;
            wrap.status = cs1.Status; 
            wrap.subject = cs1.Subject; 
            wrap.type = cs1.Type; 
            wrap.Entity = cs1.Entity__c; 
            wrap.createdDate = cs1.createdDate;
            wrap.assignedTo = cs1.Owner.Name;
            wrap.Description = cs1.Description; 
            
            Email2CaseController_AFI_ALI e2c = new Email2CaseController_AFI_ALI();
            e2c.assignedInbox = 'customer@axa-financial.co.id';
            e2c.searchCustomerName = 'Hamfry';
            e2c.searchStartDate = '2/1/2020 12:00 AM';
            e2c.searchEndDate = '2/2/2020 12:00 AM';
            e2c.searchPolicyNo = '1234-56781';
            e2c.searchSubjectandBody = 'ILCCYS';
            e2c.getCaseRecords();
            e2c.assignUser();
            e2c.agentPicklist();
            e2c.refreshList();
            e2c.getPagingButtons();
            //e2c.selectedInbox();
            e2c.refreshGrid();
            e2c.Previous();
            e2c.Next();
            e2c.End();
            e2c.getDisablePrevious();
            e2c.getDisableNext();
            e2c.getNoOfRecords();
            e2c.getPageNumber();
            e2c.getTotalPages();
            e2c.assignedAgent = subOrdinateAFIUser.Id;
            //e2c.assignUser();
            e2c.calculateEmailSLA('customer@axa-financial.co.id');
            //e2c.selectedInbox();
        }
        
        Test.stopTest();
    }
    
    
    public static testMethod void Email2CaseControllerAFIALITest2(){
        Test.startTest();
        List<Case> caseList = new List<Case>();
        List<Contact> contactList = new List<Contact>();
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AFI' limit 1]; 
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AMFS' limit 1]; 
        Profile agentProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%MAGI' limit 1];
        Profile agentProfileALI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%ALI' limit 1]; 
        
        Profile spvProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AFI' limit 1]; 
        Profile spvProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AMFS' limit 1]; 
        Profile spvProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%MAGI' limit 1]; 
        Profile spvProfileALI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%ALI' limit 1]; 
        
        List<User> spvList = new List<User>();
        User loginAFIUser = new User(Alias = 'spv1', Email='spvAfi@axa.co.id', 
                                     EmailEncodingKey='UTF-8', LastName='spvAfi', LanguageLocaleKey='en_US', 
                                     LocaleSidKey='en_US', ProfileId = spvProfileAFI.Id, Entity__c = 'AFI', 
                                     TimeZoneSidKey='Asia/Jakarta', UserName='spvAfi@axa.co.id', isActive = true);
        spvList.add(loginAFIUser);
        
        User loginAMFSUser = new User(Alias = 'spv2', Email='spvAmfs@axa.co.id', 
                                      EmailEncodingKey='UTF-8', LastName='spvAmfs', LanguageLocaleKey='en_US', 
                                      LocaleSidKey='en_US', ProfileId = spvProfileAMFS.Id, Entity__c = 'AMFS',
                                      TimeZoneSidKey='Asia/Jakarta', UserName='spvAmfs@axa.co.id', isActive = true);
        spvList.add(loginAMFSUser);
        
        User loginMAGIUser = new User(Alias = 'spv3', Email='spvMagi@axa.co.id', 
                                      EmailEncodingKey='UTF-8', LastName='spvMagi', LanguageLocaleKey='en_US', 
                                      LocaleSidKey='en_US', ProfileId = spvProfileMAGI.Id, Entity__c = 'MAGI',
                                      TimeZoneSidKey='Asia/Jakarta', UserName='spvMagi@axa.co.id', isActive = true);
        spvList.add(loginMAGIUser);
        
        User loginALIUser = new User(Alias = 'spv4', Email='spvAli@axa.co.id', 
                                     EmailEncodingKey='UTF-8', LastName='spvAli', LanguageLocaleKey='en_US', 
                                     LocaleSidKey='en_US', ProfileId = spvProfileALI.Id, Entity__c = 'ALI', 
                                     TimeZoneSidKey='Asia/Jakarta', UserName='spvAli@axa.co.id', isActive = true);
        spvList.add(loginALIUser);
        insert spvList;
        
        List<User> agentList = new List<User>();
        User subOrdinateAFIUser = new User(Alias = 'agent1', Email='agentAfi@axa.co.id', 
                                           EmailEncodingKey='UTF-8', LastName='agentAfi', LanguageLocaleKey='en_US', 
                                           LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, managerId = loginAFIUser.id, Entity__c = 'AFI',
                                           TimeZoneSidKey='Asia/Jakarta', UserName='agentAfi@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateAFIUser);
        
        User subOrdinateAMFSUser = new User(Alias = 'agent2', Email='agentAmfs@axa.co.id', 
                                            EmailEncodingKey='UTF-8', LastName='agentAmfs', LanguageLocaleKey='en_US', 
                                            LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = loginAMFSUser.id, Entity__c = 'AMFS',
                                            TimeZoneSidKey='Asia/Jakarta', UserName='agentAmfs@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateAMFSUser);
        
        User subOrdinateMAGIUser = new User(Alias = 'agent3', Email='agentMagi@axa.co.id', 
                                            EmailEncodingKey='UTF-8', LastName='agentMagi', LanguageLocaleKey='en_US', 
                                            LocaleSidKey='en_US', ProfileId = agentProfileMAGI.Id, managerId = loginMAGIUser.id, Entity__c = 'MAGI',
                                            TimeZoneSidKey='Asia/Jakarta', UserName='agentMagi@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateMAGIUser);
        
        User subOrdinateALIUser = new User(Alias = 'agent4', Email='agentAli@axa.co.id', 
                                           EmailEncodingKey='UTF-8', LastName='agentAli', LanguageLocaleKey='en_US', 
                                           LocaleSidKey='en_US', ProfileId = agentProfileALI.Id, managerId = loginALIUser.id, Entity__c = 'ALI',
                                           TimeZoneSidKey='Asia/Jakarta', UserName='agentAli@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateALIUser);
        insert agentList;
        
        Contact con1 = new Contact();
        con1.FirstName = 'Hamfry';
        con1.LastName = 'Lantu';
        con1.Policy_No__c = '1234-56781';
        contactList.add(con1);
        
        Contact con2 = new Contact();
        con2.FirstName = 'Hamfry';
        con2.LastName = 'Lantoe';
        con2.Policy_No__c = '1234-56782';
        contactList.add(con2);
        
        Contact con3 = new Contact();
        con3.FirstName = 'Hamfree';
        con3.LastName = 'Lantwo';
        con3.Policy_No__c = '1234-56783';
        contactList.add(con3);
        
        Contact con4 = new Contact();
        con4.FirstName = 'Hamfrees';
        con4.LastName = 'Lantwos';
        con4.Policy_No__c = '1234-56784';
        contactList.add(con4);
        insert contactList;
        
        
        User_Detail__c ud = new User_Detail__c();
        ud.Entity__c = 'AMFS';
        ud.Subject_Case__c = 'ILCCYS';
        ud.User__c = subOrdinateAMFSUser.Id;
        insert ud;
        
        Id userId = ud.User__c;
        
        Case cs1 = new Case();
        cs1.Entity_Backup__c = 'AFI';
        cs1.Origin = 'Email';
        cs1.Status ='New';
        cs1.suppliedEmail = 'testing123@nyaho.com';
        cs1.Policy_Number__c = con1.Policy_No__c;
        cs1.ContactId = con1.Id;
        cs1.Status = 'New';
        cs1.Subject = 'ILCCYS';
        cs1.Type = 'Inquiry';
        cs1.Case_Type_Config__c = 'Inquiry Status';
        cs1.Description = 'testing for test class';
        cs1.OwnerId = subOrdinateAFIUser.Id;
        cs1.e2cEmailTo__c = 'customer@axa-financial.co.id';
        caseList.add(cs1);
        
        Case cs2 = new Case();
        cs2.Entity_Backup__c = 'AMFS';
        cs2.Origin = 'Email';
        cs2.Status ='New';
        cs2.suppliedEmail = 'testing234@nyaho.com';
        cs1.Policy_Number__c = con2.Policy_No__c;
        cs2.ContactId = con2.Id;
        cs2.Status = 'New';
        cs2.Subject = 'ILCCYS';
        cs2.Type = 'Inquiry';
        cs2.Case_Type_Config__c = 'Inquiry Status';
        cs2.Description = '';
        cs2.OwnerId = userId;
        cs2.e2cEmailTo__c = 'customer@axa-mandiri.co.id';
        caseList.add(cs2);
        
        Case cs3 = new Case();
        cs3.Entity_Backup__c = 'MAGI';
        cs3.Origin = 'Email';
        cs3.Status ='New';
        cs3.suppliedEmail = 'testing345@nyaho.com';
        cs3.Policy_Number__c = con3.Policy_No__c;
        cs3.ContactId = con3.Id;
        cs3.Status = 'New';
        cs3.Subject = 'ILCCYS';
        cs3.Type = 'Inquiry';
        cs3.Case_Type_Config__c = 'Inquiry Status';
        cs3.Description = 'testing for test class';
        cs3.OwnerId = subOrdinateMAGIUser.Id;
        cs3.e2cEmailTo__c = 'customer-general@axa-mandiri.co.id';
        caseList.add(cs3);
        
        Case cs4 = new Case();
        cs4.Entity_Backup__c = 'ALI';
        cs4.Origin = 'Email';
        cs4.Status ='New';
        cs4.suppliedEmail = 'testing564@nyaho.com';
        cs4.Policy_Number__c = con4.Policy_No__c;
        cs4.ContactId = con4.Id;
        cs4.Status = 'New';
        cs4.Subject = 'ILCCYS';
        cs4.Type = 'Inquiry';
        cs4.Case_Type_Config__c = 'Inquiry Status';
        cs4.Description = 'testing for test class';
        cs4.OwnerId = subOrdinateALIUser.Id;
        cs4.e2cEmailTo__c = 'customer@axa-financial.co.id';
        caseList.add(cs4);
        
        insert caseList;
        //Test.stopTest();
        
        List<Call_Line__c> callLineList = new List<Call_Line__c>();
        Call_Line__c cl1 = new Call_Line__c();
        cl1.Contact__c = cs2.ContactId;
        cl1.Policy_No__c = cs2.Policy_Number__c;
        cl1.OwnerId = cs2.OwnerId;
        callLineList.add(cl1);
        
        insert callLineList;
        
        List<Email_Config__c> emailCfgList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-financial.co.id';
        ec1.Entity__c = 'AFI';
        ec1.Distribution_Type__c = 'Manual';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        emailCfgList.add(ec1);
        
        Email_Config__c ec2 = new Email_Config__c();
        ec2.Email_Address__c = 'customer@axa-financial.co.id';
        ec2.Entity__c = 'AFI';
        ec2.Distribution_Type__c = 'Automatic';
        ec2.SLA__c = '2';
        ec2.Unit__c = 'Hour';
        emailCfgList.add(ec2);
        
        insert emailCfgList;
        
        system.runAs(loginAFIUser){
            Email2CaseController_AFI_ALI.CaseWrapper wrap = new Email2CaseController_AFI_ALI.CaseWrapper();
            wrap.id = cs1.Id;
            wrap.isSelected = true;
            wrap.indikator = cs1.Indicator__c;
            wrap.followUp = cs1.Follow_Up_Flag__c;
            wrap.caseNumber = cs1.CaseNumber ; 
            wrap.senderEmail = cs1.SuppliedEmail;
            wrap.toAddress = 'customer@axa-financial.co.id'; 
            wrap.customerName = cs1.Contact.Name;
            wrap.status = cs1.Status; 
            wrap.subject = cs1.Subject; 
            wrap.type = cs1.Type; 
            wrap.Entity = cs1.Entity__c; 
            wrap.createdDate = cs1.createdDate;
            wrap.assignedTo = cs1.Owner.Name;
            wrap.Description = cs1.Description; 
            
            Email2CaseController_AFI_ALI e2c = new Email2CaseController_AFI_ALI();
            e2c.getCaseRecords();
            e2c.assignUser();
            e2c.agentPicklist();
            e2c.refreshList();
            e2c.getPagingButtons();
            e2c.selectedInbox();
            e2c.refreshGrid();
            e2c.Previous();
            e2c.Next();
            e2c.End();
            e2c.getDisablePrevious();
            e2c.getDisableNext();
            e2c.getNoOfRecords();
            e2c.getPageNumber();
            e2c.getTotalPages();
            e2c.assignedAgent = subOrdinateAFIUser.Id;
            e2c.assignUser();
            e2c.calculateEmailSLA('customer@axa-financial.co.id');
            //e2c.selectedInbox();
        }
        
        Test.stopTest();
    }
    
    
    public static testMethod void Email2CaseControllerAFIALITest3(){
        Test.startTest();
        List<Case> caseList = new List<Case>();
        List<Contact> contactList = new List<Contact>();
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AFI' limit 1]; 
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AMFS' limit 1]; 
        Profile agentProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%MAGI' limit 1];
        Profile agentProfileALI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%ALI' limit 1]; 
        
        Profile spvProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AFI' limit 1]; 
        Profile spvProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AMFS' limit 1]; 
        Profile spvProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%MAGI' limit 1]; 
        Profile spvProfileALI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%ALI' limit 1]; 
        
        List<User> spvList = new List<User>();
        User loginAFIUser = new User(Alias = 'spv1', Email='spvAfi@axa.co.id', 
                                     EmailEncodingKey='UTF-8', LastName='spvAfi', LanguageLocaleKey='en_US', 
                                     LocaleSidKey='en_US', ProfileId = spvProfileAFI.Id, Entity__c = 'AFI', 
                                     TimeZoneSidKey='Asia/Jakarta', UserName='spvAfi@axa.co.id', isActive = true);
        spvList.add(loginAFIUser);
        
        User loginAMFSUser = new User(Alias = 'spv2', Email='spvAmfs@axa.co.id', 
                                      EmailEncodingKey='UTF-8', LastName='spvAmfs', LanguageLocaleKey='en_US', 
                                      LocaleSidKey='en_US', ProfileId = spvProfileAMFS.Id, Entity__c = 'AMFS',
                                      TimeZoneSidKey='Asia/Jakarta', UserName='spvAmfs@axa.co.id', isActive = true);
        spvList.add(loginAMFSUser);
        
        User loginMAGIUser = new User(Alias = 'spv3', Email='spvMagi@axa.co.id', 
                                      EmailEncodingKey='UTF-8', LastName='spvMagi', LanguageLocaleKey='en_US', 
                                      LocaleSidKey='en_US', ProfileId = spvProfileMAGI.Id, Entity__c = 'MAGI',
                                      TimeZoneSidKey='Asia/Jakarta', UserName='spvMagi@axa.co.id', isActive = true);
        spvList.add(loginMAGIUser);
        
        User loginALIUser = new User(Alias = 'spv4', Email='spvAli@axa.co.id', 
                                     EmailEncodingKey='UTF-8', LastName='spvAli', LanguageLocaleKey='en_US', 
                                     LocaleSidKey='en_US', ProfileId = spvProfileALI.Id, Entity__c = 'ALI', 
                                     TimeZoneSidKey='Asia/Jakarta', UserName='spvAli@axa.co.id', isActive = true);
        spvList.add(loginALIUser);
        insert spvList;
        
        List<User> agentList = new List<User>();
        User subOrdinateAFIUser = new User(Alias = 'agent1', Email='agentAfi@axa.co.id', 
                                           EmailEncodingKey='UTF-8', LastName='agentAfi', LanguageLocaleKey='en_US', 
                                           LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, managerId = loginAFIUser.id, Entity__c = 'AFI',
                                           TimeZoneSidKey='Asia/Jakarta', UserName='agentAfi@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateAFIUser);
        
        User subOrdinateAMFSUser = new User(Alias = 'agent2', Email='agentAmfs@axa.co.id', 
                                            EmailEncodingKey='UTF-8', LastName='agentAmfs', LanguageLocaleKey='en_US', 
                                            LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = loginAMFSUser.id, Entity__c = 'AMFS',
                                            TimeZoneSidKey='Asia/Jakarta', UserName='agentAmfs@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateAMFSUser);
        
        User subOrdinateMAGIUser = new User(Alias = 'agent3', Email='agentMagi@axa.co.id', 
                                            EmailEncodingKey='UTF-8', LastName='agentMagi', LanguageLocaleKey='en_US', 
                                            LocaleSidKey='en_US', ProfileId = agentProfileMAGI.Id, managerId = loginMAGIUser.id, Entity__c = 'MAGI',
                                            TimeZoneSidKey='Asia/Jakarta', UserName='agentMagi@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateMAGIUser);
        
        User subOrdinateALIUser = new User(Alias = 'agent4', Email='agentAli@axa.co.id', 
                                           EmailEncodingKey='UTF-8', LastName='agentAli', LanguageLocaleKey='en_US', 
                                           LocaleSidKey='en_US', ProfileId = agentProfileALI.Id, managerId = loginALIUser.id, Entity__c = 'ALI',
                                           TimeZoneSidKey='Asia/Jakarta', UserName='agentAli@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateALIUser);
        insert agentList;
        
        Contact con1 = new Contact();
        con1.FirstName = 'Hamfry';
        con1.LastName = 'Lantu';
        con1.Policy_No__c = '1234-56781';
        contactList.add(con1);
        
        Contact con2 = new Contact();
        con2.FirstName = 'Hamfry';
        con2.LastName = 'Lantoe';
        con2.Policy_No__c = '1234-56782';
        contactList.add(con2);
        
        Contact con3 = new Contact();
        con3.FirstName = 'Hamfree';
        con3.LastName = 'Lantwo';
        con3.Policy_No__c = '1234-56783';
        contactList.add(con3);
        
        Contact con4 = new Contact();
        con4.FirstName = 'Hamfrees';
        con4.LastName = 'Lantwos';
        con4.Policy_No__c = '1234-56784';
        contactList.add(con4);
        insert contactList;
        
        
        User_Detail__c ud = new User_Detail__c();
        ud.Entity__c = 'AMFS';
        ud.Subject_Case__c = 'ILCCYS';
        ud.User__c = subOrdinateAMFSUser.Id;
        insert ud;
        
        Id userId = ud.User__c;
        
        Case cs1 = new Case();
        cs1.Entity_Backup__c = 'AFI';
        cs1.Origin = 'Email';
        cs1.Status ='New';
        cs1.suppliedEmail = 'testing123@nyaho.com';
        cs1.Policy_Number__c = con1.Policy_No__c;
        cs1.ContactId = con1.Id;
        cs1.Status = 'New';
        cs1.Subject = 'ILCCYS';
        cs1.Type = 'Inquiry';
        cs1.Case_Type_Config__c = 'Inquiry Status';
        cs1.Description = 'testing for test class';
        cs1.OwnerId = subOrdinateAFIUser.Id;
        cs1.e2cEmailTo__c = 'customer@axa-financial.co.id';
        caseList.add(cs1);
        
        Case cs2 = new Case();
        cs2.Entity_Backup__c = 'AMFS';
        cs2.Origin = 'Email';
        cs2.Status ='New';
        cs2.suppliedEmail = 'testing234@nyaho.com';
        cs1.Policy_Number__c = con2.Policy_No__c;
        cs2.ContactId = con2.Id;
        cs2.Status = 'New';
        cs2.Subject = 'ILCCYS';
        cs2.Type = 'Inquiry';
        cs2.Case_Type_Config__c = 'Inquiry Status';
        cs2.Description = '';
        cs2.OwnerId = userId;
        cs2.e2cEmailTo__c = 'customer@axa-mandiri.co.id';
        caseList.add(cs2);
        
        Case cs3 = new Case();
        cs3.Entity_Backup__c = 'MAGI';
        cs3.Origin = 'Email';
        cs3.Status ='New';
        cs3.suppliedEmail = 'testing345@nyaho.com';
        cs3.Policy_Number__c = con3.Policy_No__c;
        cs3.ContactId = con3.Id;
        cs3.Status = 'New';
        cs3.Subject = 'ILCCYS';
        cs3.Type = 'Inquiry';
        cs3.Case_Type_Config__c = 'Inquiry Status';
        cs3.Description = 'testing for test class';
        cs3.OwnerId = subOrdinateMAGIUser.Id;
        cs3.e2cEmailTo__c = 'customer-general@axa-mandiri.co.id';
        caseList.add(cs3);
        
        Case cs4 = new Case();
        cs4.Entity_Backup__c = 'ALI';
        cs4.Origin = 'Email';
        cs4.Status ='New';
        cs4.suppliedEmail = 'testing564@nyaho.com';
        cs4.Policy_Number__c = con4.Policy_No__c;
        cs4.ContactId = con4.Id;
        cs4.Status = 'New';
        cs4.Subject = 'ILCCYS';
        cs4.Type = 'Inquiry';
        cs4.Case_Type_Config__c = 'Inquiry Status';
        cs4.Description = 'testing for test class';
        cs4.OwnerId = subOrdinateALIUser.Id;
        cs4.e2cEmailTo__c = 'customer@axa-financial.co.id';
        caseList.add(cs4);
        
        insert caseList;
        //Test.stopTest();
        
        List<Call_Line__c> callLineList = new List<Call_Line__c>();
        Call_Line__c cl1 = new Call_Line__c();
        cl1.Contact__c = cs2.ContactId;
        cl1.Policy_No__c = cs2.Policy_Number__c;
        cl1.OwnerId = cs2.OwnerId;
        callLineList.add(cl1);
        
        insert callLineList;
        
        List<Email_Config__c> emailCfgList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-financial.co.id';
        ec1.Entity__c = 'AFI';
        ec1.Distribution_Type__c = 'Manual';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        emailCfgList.add(ec1);
        
        Email_Config__c ec2 = new Email_Config__c();
        ec2.Email_Address__c = 'customer@axa-financial.co.id';
        ec2.Entity__c = 'AFI';
        ec2.Distribution_Type__c = 'Automatic';
        ec2.SLA__c = '2';
        ec2.Unit__c = 'Hour';
        emailCfgList.add(ec2);
        
        insert emailCfgList;
        
        system.runAs(subOrdinateAFIUser){
            Email2CaseController_AFI_ALI.CaseWrapper wrap = new Email2CaseController_AFI_ALI.CaseWrapper();
            wrap.id = cs1.Id;
            wrap.isSelected = true;
            wrap.indikator = cs1.Indicator__c;
            wrap.followUp = cs1.Follow_Up_Flag__c;
            wrap.caseNumber = cs1.CaseNumber ; 
            wrap.senderEmail = cs1.SuppliedEmail;
            wrap.toAddress = 'customer@axa-financial.co.id'; 
            wrap.customerName = cs1.Contact.Name;
            wrap.status = cs1.Status; 
            wrap.subject = cs1.Subject; 
            wrap.type = cs1.Type; 
            wrap.Entity = cs1.Entity__c; 
            wrap.createdDate = cs1.createdDate;
            wrap.assignedTo = cs1.Owner.Name;
            wrap.Description = cs1.Description; 
            
            Email2CaseController_AFI_ALI e2c = new Email2CaseController_AFI_ALI();
            e2c.assignedInbox = 'customer@axa-financial.co.id';
            e2c.getCaseRecords();
            e2c.assignUser();
            e2c.agentPicklist();
            e2c.refreshList();
            e2c.getPagingButtons();
            e2c.selectedInbox();
            e2c.refreshGrid();
            e2c.Previous();
            e2c.Next();
            e2c.End();
            e2c.getDisablePrevious();
            e2c.getDisableNext();
            e2c.getNoOfRecords();
            e2c.getPageNumber();
            e2c.getTotalPages();
            e2c.assignedAgent = subOrdinateAFIUser.Id;
            e2c.assignUser();
            e2c.calculateEmailSLA('customer@axa-financial.co.id');
            //e2c.selectedInbox();
        }
        
        Test.stopTest();
    }
    
    
    public static testMethod void Email2CaseControllerAFIALITest4(){
        Test.startTest();
        List<Case> caseList = new List<Case>();
        List<Contact> contactList = new List<Contact>();
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AFI' limit 1]; 
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AMFS' limit 1]; 
        Profile agentProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%MAGI' limit 1];
        Profile agentProfileALI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%ALI' limit 1]; 
        
        Profile spvProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AFI' limit 1]; 
        Profile spvProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AMFS' limit 1]; 
        Profile spvProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%MAGI' limit 1]; 
        Profile spvProfileALI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%ALI' limit 1]; 
        
        List<User> spvList = new List<User>();
        User loginAFIUser = new User(Alias = 'spv1', Email='spvAfi@axa.co.id', 
                                     EmailEncodingKey='UTF-8', LastName='spvAfi', LanguageLocaleKey='en_US', 
                                     LocaleSidKey='en_US', ProfileId = spvProfileAFI.Id, Entity__c = 'AFI', 
                                     TimeZoneSidKey='Asia/Jakarta', UserName='spvAfi@axa.co.id', isActive = true);
        spvList.add(loginAFIUser);
        
        User loginAMFSUser = new User(Alias = 'spv2', Email='spvAmfs@axa.co.id', 
                                      EmailEncodingKey='UTF-8', LastName='spvAmfs', LanguageLocaleKey='en_US', 
                                      LocaleSidKey='en_US', ProfileId = spvProfileAMFS.Id, Entity__c = 'AMFS',
                                      TimeZoneSidKey='Asia/Jakarta', UserName='spvAmfs@axa.co.id', isActive = true);
        spvList.add(loginAMFSUser);
        
        User loginMAGIUser = new User(Alias = 'spv3', Email='spvMagi@axa.co.id', 
                                      EmailEncodingKey='UTF-8', LastName='spvMagi', LanguageLocaleKey='en_US', 
                                      LocaleSidKey='en_US', ProfileId = spvProfileMAGI.Id, Entity__c = 'MAGI',
                                      TimeZoneSidKey='Asia/Jakarta', UserName='spvMagi@axa.co.id', isActive = true);
        spvList.add(loginMAGIUser);
        
        User loginALIUser = new User(Alias = 'spv4', Email='spvAli@axa.co.id', 
                                     EmailEncodingKey='UTF-8', LastName='spvAli', LanguageLocaleKey='en_US', 
                                     LocaleSidKey='en_US', ProfileId = spvProfileALI.Id, Entity__c = 'ALI', 
                                     TimeZoneSidKey='Asia/Jakarta', UserName='spvAli@axa.co.id', isActive = true);
        spvList.add(loginALIUser);
        insert spvList;
        
        List<User> agentList = new List<User>();
        User subOrdinateAFIUser = new User(Alias = 'agent1', Email='agentAfi@axa.co.id', 
                                           EmailEncodingKey='UTF-8', LastName='agentAfi', LanguageLocaleKey='en_US', 
                                           LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, managerId = loginAFIUser.id, Entity__c = 'AFI',
                                           TimeZoneSidKey='Asia/Jakarta', UserName='agentAfi@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateAFIUser);
        
        User subOrdinateAMFSUser = new User(Alias = 'agent2', Email='agentAmfs@axa.co.id', 
                                            EmailEncodingKey='UTF-8', LastName='agentAmfs', LanguageLocaleKey='en_US', 
                                            LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = loginAMFSUser.id, Entity__c = 'AMFS',
                                            TimeZoneSidKey='Asia/Jakarta', UserName='agentAmfs@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateAMFSUser);
        
        User subOrdinateMAGIUser = new User(Alias = 'agent3', Email='agentMagi@axa.co.id', 
                                            EmailEncodingKey='UTF-8', LastName='agentMagi', LanguageLocaleKey='en_US', 
                                            LocaleSidKey='en_US', ProfileId = agentProfileMAGI.Id, managerId = loginMAGIUser.id, Entity__c = 'MAGI',
                                            TimeZoneSidKey='Asia/Jakarta', UserName='agentMagi@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateMAGIUser);
        
        User subOrdinateALIUser = new User(Alias = 'agent4', Email='agentAli@axa.co.id', 
                                           EmailEncodingKey='UTF-8', LastName='agentAli', LanguageLocaleKey='en_US', 
                                           LocaleSidKey='en_US', ProfileId = agentProfileALI.Id, managerId = loginALIUser.id, Entity__c = 'ALI',
                                           TimeZoneSidKey='Asia/Jakarta', UserName='agentAli@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateALIUser);
        insert agentList;
        
        Contact con1 = new Contact();
        con1.FirstName = 'Hamfry';
        con1.LastName = 'Lantu';
        con1.Policy_No__c = '1234-56781';
        contactList.add(con1);
        
        Contact con2 = new Contact();
        con2.FirstName = 'Hamfry';
        con2.LastName = 'Lantoe';
        con2.Policy_No__c = '1234-56782';
        contactList.add(con2);
        
        Contact con3 = new Contact();
        con3.FirstName = 'Hamfree';
        con3.LastName = 'Lantwo';
        con3.Policy_No__c = '1234-56783';
        contactList.add(con3);
        
        Contact con4 = new Contact();
        con4.FirstName = 'Hamfrees';
        con4.LastName = 'Lantwos';
        con4.Policy_No__c = '1234-56784';
        contactList.add(con4);
        insert contactList;
        
        
        User_Detail__c ud = new User_Detail__c();
        ud.Entity__c = 'AMFS';
        ud.Subject_Case__c = 'ILCCYS';
        ud.User__c = subOrdinateAMFSUser.Id;
        insert ud;
        
        Id userId = ud.User__c;
        
        Case cs1 = new Case();
        cs1.Entity_Backup__c = 'AFI';
        cs1.Origin = 'Email';
        cs1.Status ='New';
        cs1.suppliedEmail = 'testing123@nyaho.com';
        cs1.Policy_Number__c = con1.Policy_No__c;
        cs1.ContactId = con1.Id;
        cs1.Status = 'New';
        cs1.Subject = 'ILCCYS';
        cs1.Type = 'Inquiry';
        cs1.Case_Type_Config__c = 'Inquiry Status';
        cs1.Description = 'testing for test class';
        cs1.OwnerId = subOrdinateAFIUser.Id;
        cs1.e2cEmailTo__c = 'customer@axa-financial.co.id';
        caseList.add(cs1);
        
        Case cs2 = new Case();
        cs2.Entity_Backup__c = 'AMFS';
        cs2.Origin = 'Email';
        cs2.Status ='New';
        cs2.suppliedEmail = 'testing234@nyaho.com';
        cs1.Policy_Number__c = con2.Policy_No__c;
        cs2.ContactId = con2.Id;
        cs2.Status = 'New';
        cs2.Subject = 'ILCCYS';
        cs2.Type = 'Inquiry';
        cs2.Case_Type_Config__c = 'Inquiry Status';
        cs2.Description = '';
        cs2.OwnerId = userId;
        cs2.e2cEmailTo__c = 'customer@axa-mandiri.co.id';
        caseList.add(cs2);
        
        Case cs3 = new Case();
        cs3.Entity_Backup__c = 'MAGI';
        cs3.Origin = 'Email';
        cs3.Status ='New';
        cs3.suppliedEmail = 'testing345@nyaho.com';
        cs3.Policy_Number__c = con3.Policy_No__c;
        cs3.ContactId = con3.Id;
        cs3.Status = 'New';
        cs3.Subject = 'ILCCYS';
        cs3.Type = 'Inquiry';
        cs3.Case_Type_Config__c = 'Inquiry Status';
        cs3.Description = 'testing for test class';
        cs3.OwnerId = subOrdinateMAGIUser.Id;
        cs3.e2cEmailTo__c = 'customer-general@axa-mandiri.co.id';
        caseList.add(cs3);
        
        Case cs4 = new Case();
        cs4.Entity_Backup__c = 'ALI';
        cs4.Origin = 'Email';
        cs4.Status ='New';
        cs4.suppliedEmail = 'testing564@nyaho.com';
        cs4.Policy_Number__c = con4.Policy_No__c;
        cs4.ContactId = con4.Id;
        cs4.Status = 'New';
        cs4.Subject = 'ILCCYS';
        cs4.Type = 'Inquiry';
        cs4.Case_Type_Config__c = 'Inquiry Status';
        cs4.Description = 'testing for test class';
        cs4.OwnerId = subOrdinateALIUser.Id;
        cs4.e2cEmailTo__c = 'customer@axa-financial.co.id';
        caseList.add(cs4);
        
        insert caseList;
        //Test.stopTest();
        
        List<Call_Line__c> callLineList = new List<Call_Line__c>();
        Call_Line__c cl1 = new Call_Line__c();
        cl1.Contact__c = cs2.ContactId;
        cl1.Policy_No__c = cs2.Policy_Number__c;
        cl1.OwnerId = cs2.OwnerId;
        callLineList.add(cl1);
        
        insert callLineList;
        
        List<Email_Config__c> emailCfgList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-financial.co.id';
        ec1.Entity__c = 'AFI';
        ec1.Distribution_Type__c = 'Manual';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        emailCfgList.add(ec1);
        
        Email_Config__c ec2 = new Email_Config__c();
        ec2.Email_Address__c = 'customer@axa-financial.co.id';
        ec2.Entity__c = 'AFI';
        ec2.Distribution_Type__c = 'Automatic';
        ec2.SLA__c = '2';
        ec2.Unit__c = 'Hour';
        emailCfgList.add(ec2);
        
        insert emailCfgList;
        
        system.runAs(subOrdinateAFIUser){
            Email2CaseController_AFI_ALI.CaseWrapper wrap = new Email2CaseController_AFI_ALI.CaseWrapper();
            wrap.id = cs1.Id;
            wrap.isSelected = true;
            wrap.indikator = cs1.Indicator__c;
            wrap.followUp = cs1.Follow_Up_Flag__c;
            wrap.caseNumber = cs1.CaseNumber ; 
            wrap.senderEmail = cs1.SuppliedEmail;
            wrap.toAddress = 'customer@axa-financial.co.id'; 
            wrap.customerName = cs1.Contact.Name;
            wrap.status = cs1.Status; 
            wrap.subject = cs1.Subject; 
            wrap.type = cs1.Type; 
            wrap.Entity = cs1.Entity__c; 
            wrap.createdDate = cs1.createdDate;
            wrap.assignedTo = cs1.Owner.Name;
            wrap.Description = cs1.Description; 
            
            Email2CaseController_AFI_ALI e2c = new Email2CaseController_AFI_ALI();
            e2c.assignedInbox = 'All';
            e2c.getCaseRecords();
            e2c.assignUser();
            e2c.agentPicklist();
            e2c.refreshList();
            e2c.getPagingButtons();
            e2c.selectedInbox();
            e2c.refreshGrid();
            e2c.Previous();
            e2c.Next();
            e2c.End();
            e2c.getDisablePrevious();
            e2c.getDisableNext();
            e2c.getNoOfRecords();
            e2c.getPageNumber();
            e2c.getTotalPages();
            e2c.assignedAgent = subOrdinateAFIUser.Id;
            e2c.assignUser();
            e2c.calculateEmailSLA('customer@axa-financial.co.id');
            //e2c.selectedInbox();
        }
        
        Test.stopTest();
    }
        
    public static testMethod void Email2CaseControllerAFIALITest5(){
        Test.startTest();
        List<Case> caseList = new List<Case>();
        List<Contact> contactList = new List<Contact>();
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AFI' limit 1]; 
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AMFS' limit 1]; 
        Profile agentProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%MAGI' limit 1];
        Profile agentProfileALI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%ALI' limit 1]; 
        
        Profile spvProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AFI' limit 1]; 
        Profile spvProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AMFS' limit 1]; 
        Profile spvProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%MAGI' limit 1]; 
        Profile spvProfileALI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%ALI' limit 1]; 
        
        List<User> spvList = new List<User>();
        User loginAFIUser = new User(Alias = 'spv1', Email='spvAfi@axa.co.id', 
                                     EmailEncodingKey='UTF-8', LastName='spvAfi', LanguageLocaleKey='en_US', 
                                     LocaleSidKey='en_US', ProfileId = spvProfileAFI.Id, Entity__c = 'AFI', 
                                     TimeZoneSidKey='Asia/Jakarta', UserName='spvAfi@axa.co.id', isActive = true);
        spvList.add(loginAFIUser);
        
        User loginAMFSUser = new User(Alias = 'spv2', Email='spvAmfs@axa.co.id', 
                                      EmailEncodingKey='UTF-8', LastName='spvAmfs', LanguageLocaleKey='en_US', 
                                      LocaleSidKey='en_US', ProfileId = spvProfileAMFS.Id, Entity__c = 'AMFS',
                                      TimeZoneSidKey='Asia/Jakarta', UserName='spvAmfs@axa.co.id', isActive = true);
        spvList.add(loginAMFSUser);
        
        User loginMAGIUser = new User(Alias = 'spv3', Email='spvMagi@axa.co.id', 
                                      EmailEncodingKey='UTF-8', LastName='spvMagi', LanguageLocaleKey='en_US', 
                                      LocaleSidKey='en_US', ProfileId = spvProfileMAGI.Id, Entity__c = 'MAGI',
                                      TimeZoneSidKey='Asia/Jakarta', UserName='spvMagi@axa.co.id', isActive = true);
        spvList.add(loginMAGIUser);
        
        User loginALIUser = new User(Alias = 'spv4', Email='spvAli@axa.co.id', 
                                     EmailEncodingKey='UTF-8', LastName='spvAli', LanguageLocaleKey='en_US', 
                                     LocaleSidKey='en_US', ProfileId = spvProfileALI.Id, Entity__c = 'ALI', 
                                     TimeZoneSidKey='Asia/Jakarta', UserName='spvAli@axa.co.id', isActive = true);
        spvList.add(loginALIUser);
        insert spvList;
        
        List<User> agentList = new List<User>();
        User subOrdinateAFIUser = new User(Alias = 'agent1', Email='agentAfi@axa.co.id', 
                                           EmailEncodingKey='UTF-8', LastName='agentAfi', LanguageLocaleKey='en_US', 
                                           LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, managerId = loginAFIUser.id, Entity__c = 'AFI',
                                           TimeZoneSidKey='Asia/Jakarta', UserName='agentAfi@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateAFIUser);
        
        User subOrdinateAMFSUser = new User(Alias = 'agent2', Email='agentAmfs@axa.co.id', 
                                            EmailEncodingKey='UTF-8', LastName='agentAmfs', LanguageLocaleKey='en_US', 
                                            LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = loginAMFSUser.id, Entity__c = 'AMFS',
                                            TimeZoneSidKey='Asia/Jakarta', UserName='agentAmfs@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateAMFSUser);
        
        User subOrdinateMAGIUser = new User(Alias = 'agent3', Email='agentMagi@axa.co.id', 
                                            EmailEncodingKey='UTF-8', LastName='agentMagi', LanguageLocaleKey='en_US', 
                                            LocaleSidKey='en_US', ProfileId = agentProfileMAGI.Id, managerId = loginMAGIUser.id, Entity__c = 'MAGI',
                                            TimeZoneSidKey='Asia/Jakarta', UserName='agentMagi@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateMAGIUser);
        
        User subOrdinateALIUser = new User(Alias = 'agent4', Email='agentAli@axa.co.id', 
                                           EmailEncodingKey='UTF-8', LastName='agentAli', LanguageLocaleKey='en_US', 
                                           LocaleSidKey='en_US', ProfileId = agentProfileALI.Id, managerId = loginALIUser.id, Entity__c = 'ALI',
                                           TimeZoneSidKey='Asia/Jakarta', UserName='agentAli@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateALIUser);
        insert agentList;
        
        Contact con1 = new Contact();
        con1.FirstName = 'Hamfry';
        con1.LastName = 'Lantu';
        con1.Policy_No__c = '1234-56781';
        contactList.add(con1);
        
        Contact con2 = new Contact();
        con2.FirstName = 'Hamfry';
        con2.LastName = 'Lantoe';
        con2.Policy_No__c = '1234-56782';
        contactList.add(con2);
        
        Contact con3 = new Contact();
        con3.FirstName = 'Hamfree';
        con3.LastName = 'Lantwo';
        con3.Policy_No__c = '1234-56783';
        contactList.add(con3);
        
        Contact con4 = new Contact();
        con4.FirstName = 'Hamfrees';
        con4.LastName = 'Lantwos';
        con4.Policy_No__c = '1234-56784';
        contactList.add(con4);
        insert contactList;
        
        
        User_Detail__c ud = new User_Detail__c();
        ud.Entity__c = 'AMFS';
        ud.Subject_Case__c = 'ILCCYS';
        ud.User__c = subOrdinateAMFSUser.Id;
        insert ud;
        
        Id userId = ud.User__c;
        
        Case cs1 = new Case();
        cs1.Entity_Backup__c = 'AFI';
        cs1.Origin = 'Email';
        cs1.Status ='New';
        cs1.suppliedEmail = 'testing123@nyaho.com';
        cs1.Policy_Number__c = con1.Policy_No__c;
        cs1.ContactId = con1.Id;
        cs1.Status = 'New';
        cs1.Subject = 'ILCCYS';
        cs1.Type = 'Inquiry';
        cs1.Case_Type_Config__c = 'Inquiry Status';
        cs1.Description = 'testing for test class';
        cs1.OwnerId = subOrdinateAFIUser.Id;
        cs1.e2cEmailTo__c = 'customer@axa-financial.co.id';
        caseList.add(cs1);
        
        Case cs2 = new Case();
        cs2.Entity_Backup__c = 'AMFS';
        cs2.Origin = 'Email';
        cs2.Status ='New';
        cs2.suppliedEmail = 'testing234@nyaho.com';
        cs1.Policy_Number__c = con2.Policy_No__c;
        cs2.ContactId = con2.Id;
        cs2.Status = 'New';
        cs2.Subject = 'ILCCYS';
        cs2.Type = 'Inquiry';
        cs2.Case_Type_Config__c = 'Inquiry Status';
        cs2.Description = '';
        cs2.OwnerId = userId;
        cs2.e2cEmailTo__c = 'customer@axa-mandiri.co.id';
        caseList.add(cs2);
        
        Case cs3 = new Case();
        cs3.Entity_Backup__c = 'MAGI';
        cs3.Origin = 'Email';
        cs3.Status ='New';
        cs3.suppliedEmail = 'testing345@nyaho.com';
        cs3.Policy_Number__c = con3.Policy_No__c;
        cs3.ContactId = con3.Id;
        cs3.Status = 'New';
        cs3.Subject = 'ILCCYS';
        cs3.Type = 'Inquiry';
        cs3.Case_Type_Config__c = 'Inquiry Status';
        cs3.Description = 'testing for test class';
        cs3.OwnerId = subOrdinateMAGIUser.Id;
        cs3.e2cEmailTo__c = 'customer-general@axa-mandiri.co.id';
        caseList.add(cs3);
        
        Case cs4 = new Case();
        cs4.Entity_Backup__c = 'ALI';
        cs4.Origin = 'Email';
        cs4.Status ='New';
        cs4.suppliedEmail = 'testing564@nyaho.com';
        cs4.Policy_Number__c = con4.Policy_No__c;
        cs4.ContactId = con4.Id;
        cs4.Status = 'New';
        cs4.Subject = 'ILCCYS';
        cs4.Type = 'Inquiry';
        cs4.Case_Type_Config__c = 'Inquiry Status';
        cs4.Description = 'testing for test class';
        cs4.OwnerId = subOrdinateALIUser.Id;
        cs4.e2cEmailTo__c = 'customer@axa-financial.co.id';
        caseList.add(cs4);
        
        insert caseList;
        //Test.stopTest();
        
        List<Call_Line__c> callLineList = new List<Call_Line__c>();
        Call_Line__c cl1 = new Call_Line__c();
        cl1.Contact__c = cs2.ContactId;
        cl1.Policy_No__c = cs2.Policy_Number__c;
        cl1.OwnerId = cs2.OwnerId;
        callLineList.add(cl1);
        
        insert callLineList;
        
        List<Email_Config__c> emailCfgList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-financial.co.id';
        ec1.Entity__c = 'AFI';
        ec1.Distribution_Type__c = 'Manual';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        emailCfgList.add(ec1);
        
        Email_Config__c ec2 = new Email_Config__c();
        ec2.Email_Address__c = 'customer@axa-financial.co.id';
        ec2.Entity__c = 'AFI';
        ec2.Distribution_Type__c = 'Automatic';
        ec2.SLA__c = '2';
        ec2.Unit__c = 'Hour';
        emailCfgList.add(ec2);
        
        insert emailCfgList;
        
        system.runAs(subOrdinateAFIUser){
            Email2CaseController_AFI_ALI.CaseWrapper wrap = new Email2CaseController_AFI_ALI.CaseWrapper();
            wrap.id = cs1.Id;
            wrap.isSelected = true;
            wrap.indikator = cs1.Indicator__c;
            wrap.followUp = cs1.Follow_Up_Flag__c;
            wrap.caseNumber = cs1.CaseNumber ; 
            wrap.senderEmail = cs1.SuppliedEmail;
            wrap.toAddress = 'customer@axa-financial.co.id'; 
            wrap.customerName = cs1.Contact.Name;
            wrap.status = cs1.Status; 
            wrap.subject = cs1.Subject; 
            wrap.type = cs1.Type; 
            wrap.Entity = cs1.Entity__c; 
            wrap.createdDate = cs1.createdDate;
            wrap.assignedTo = cs1.Owner.Name;
            wrap.Description = cs1.Description; 
            
            Email2CaseController_AFI_ALI e2c = new Email2CaseController_AFI_ALI();
            e2c.assignedInbox = 'Only Assigned To Me';
            e2c.getCaseRecords();
            e2c.assignUser();
            e2c.agentPicklist();
            e2c.refreshList();
            e2c.getPagingButtons();
            e2c.selectedInbox();
            e2c.refreshGrid();
            e2c.Previous();
            e2c.Next();
            e2c.End();
            e2c.getDisablePrevious();
            e2c.getDisableNext();
            e2c.getNoOfRecords();
            e2c.getPageNumber();
            e2c.getTotalPages();
            e2c.assignedAgent = subOrdinateAFIUser.Id;
            e2c.assignUser();
            e2c.calculateEmailSLA('customer@axa-financial.co.id');
            //e2c.selectedInbox();
        }
        
        Test.stopTest();
    }
    
    
    public static testMethod void Email2CaseControllerAFIALITest6(){
        Test.startTest();
        List<Case> caseList = new List<Case>();
        List<Contact> contactList = new List<Contact>();
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AFI' limit 1]; 
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AMFS' limit 1]; 
        Profile agentProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%MAGI' limit 1];
        Profile agentProfileALI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%ALI' limit 1]; 
        
        Profile spvProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AFI' limit 1]; 
        Profile spvProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AMFS' limit 1]; 
        Profile spvProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'SPV CMU%MAGI' limit 1]; 
        Profile spvProfileALI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%ALI' limit 1]; 
        
        List<User> spvList = new List<User>();
        User loginAFIUser = new User(Alias = 'spv1', Email='spvAfi@axa.co.id', 
                                     EmailEncodingKey='UTF-8', LastName='spvAfi', LanguageLocaleKey='en_US', 
                                     LocaleSidKey='en_US', ProfileId = spvProfileAFI.Id, Entity__c = 'AFI', 
                                     TimeZoneSidKey='Asia/Jakarta', UserName='spvAfi@axa.co.id', isActive = true);
        spvList.add(loginAFIUser);
        
        User loginAMFSUser = new User(Alias = 'spv2', Email='spvAmfs@axa.co.id', 
                                      EmailEncodingKey='UTF-8', LastName='spvAmfs', LanguageLocaleKey='en_US', 
                                      LocaleSidKey='en_US', ProfileId = spvProfileAMFS.Id, Entity__c = 'AMFS',
                                      TimeZoneSidKey='Asia/Jakarta', UserName='spvAmfs@axa.co.id', isActive = true);
        spvList.add(loginAMFSUser);
        
        User loginMAGIUser = new User(Alias = 'spv3', Email='spvMagi@axa.co.id', 
                                      EmailEncodingKey='UTF-8', LastName='spvMagi', LanguageLocaleKey='en_US', 
                                      LocaleSidKey='en_US', ProfileId = spvProfileMAGI.Id, Entity__c = 'MAGI',
                                      TimeZoneSidKey='Asia/Jakarta', UserName='spvMagi@axa.co.id', isActive = true);
        spvList.add(loginMAGIUser);
        
        User loginALIUser = new User(Alias = 'spv4', Email='spvAli@axa.co.id', 
                                     EmailEncodingKey='UTF-8', LastName='spvAli', LanguageLocaleKey='en_US', 
                                     LocaleSidKey='en_US', ProfileId = spvProfileALI.Id, Entity__c = 'ALI', 
                                     TimeZoneSidKey='Asia/Jakarta', UserName='spvAli@axa.co.id', isActive = true);
        spvList.add(loginALIUser);
        insert spvList;
        
        List<User> agentList = new List<User>();
        User subOrdinateAFIUser = new User(Alias = 'agent1', Email='agentAfi@axa.co.id', 
                                           EmailEncodingKey='UTF-8', LastName='agentAfi', LanguageLocaleKey='en_US', 
                                           LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, managerId = loginAFIUser.id, Entity__c = 'AFI',
                                           TimeZoneSidKey='Asia/Jakarta', UserName='agentAfi@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateAFIUser);
        
        User subOrdinateAMFSUser = new User(Alias = 'agent2', Email='agentAmfs@axa.co.id', 
                                            EmailEncodingKey='UTF-8', LastName='agentAmfs', LanguageLocaleKey='en_US', 
                                            LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = loginAMFSUser.id, Entity__c = 'AMFS',
                                            TimeZoneSidKey='Asia/Jakarta', UserName='agentAmfs@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateAMFSUser);
        
        User subOrdinateMAGIUser = new User(Alias = 'agent3', Email='agentMagi@axa.co.id', 
                                            EmailEncodingKey='UTF-8', LastName='agentMagi', LanguageLocaleKey='en_US', 
                                            LocaleSidKey='en_US', ProfileId = agentProfileMAGI.Id, managerId = loginMAGIUser.id, Entity__c = 'MAGI',
                                            TimeZoneSidKey='Asia/Jakarta', UserName='agentMagi@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateMAGIUser);
        
        User subOrdinateALIUser = new User(Alias = 'agent4', Email='agentAli@axa.co.id', 
                                           EmailEncodingKey='UTF-8', LastName='agentAli', LanguageLocaleKey='en_US', 
                                           LocaleSidKey='en_US', ProfileId = agentProfileALI.Id, managerId = loginALIUser.id, Entity__c = 'ALI',
                                           TimeZoneSidKey='Asia/Jakarta', UserName='agentAli@axa.co.id', Agent__c = true, isActive = true);
        agentList.add(subOrdinateALIUser);
        insert agentList;
        
        Contact con1 = new Contact();
        con1.FirstName = 'Hamfry';
        con1.LastName = 'Lantu';
        con1.Policy_No__c = '1234-56781';
        contactList.add(con1);
        
        Contact con2 = new Contact();
        con2.FirstName = 'Hamfry';
        con2.LastName = 'Lantoe';
        con2.Policy_No__c = '1234-56782';
        contactList.add(con2);
        
        Contact con3 = new Contact();
        con3.FirstName = 'Hamfree';
        con3.LastName = 'Lantwo';
        con3.Policy_No__c = '1234-56783';
        contactList.add(con3);
        
        Contact con4 = new Contact();
        con4.FirstName = 'Hamfrees';
        con4.LastName = 'Lantwos';
        con4.Policy_No__c = '1234-56784';
        contactList.add(con4);
        insert contactList;
        
        
        User_Detail__c ud = new User_Detail__c();
        ud.Entity__c = 'AMFS';
        ud.Subject_Case__c = 'ILCCYS';
        ud.User__c = subOrdinateAMFSUser.Id;
        insert ud;
        
        Id userId = ud.User__c;
        
        Case cs1 = new Case();
        cs1.Entity_Backup__c = 'AFI';
        cs1.Origin = 'Email';
        cs1.Status ='New';
        cs1.suppliedEmail = 'testing123@nyaho.com';
        cs1.Policy_Number__c = con1.Policy_No__c;
        cs1.ContactId = con1.Id;
        cs1.Status = 'New';
        cs1.Subject = 'ILCCYS';
        cs1.Type = 'Inquiry';
        cs1.Case_Type_Config__c = 'Inquiry Status';
        cs1.Description = 'testing for test class';
        cs1.OwnerId = subOrdinateAFIUser.Id;
        cs1.e2cEmailTo__c = 'customer@axa-financial.co.id';
        caseList.add(cs1);
        
        Case cs2 = new Case();
        cs2.Entity_Backup__c = 'AMFS';
        cs2.Origin = 'Email';
        cs2.Status ='New';
        cs2.suppliedEmail = 'testing234@nyaho.com';
        cs1.Policy_Number__c = con2.Policy_No__c;
        cs2.ContactId = con2.Id;
        cs2.Status = 'New';
        cs2.Subject = 'ILCCYS';
        cs2.Type = 'Inquiry';
        cs2.Case_Type_Config__c = 'Inquiry Status';
        cs2.Description = '';
        cs2.OwnerId = userId;
        cs2.e2cEmailTo__c = 'customer@axa-mandiri.co.id';
        caseList.add(cs2);
        
        Case cs3 = new Case();
        cs3.Entity_Backup__c = 'MAGI';
        cs3.Origin = 'Email';
        cs3.Status ='New';
        cs3.suppliedEmail = 'testing345@nyaho.com';
        cs3.Policy_Number__c = con3.Policy_No__c;
        cs3.ContactId = con3.Id;
        cs3.Status = 'New';
        cs3.Subject = 'ILCCYS';
        cs3.Type = 'Inquiry';
        cs3.Case_Type_Config__c = 'Inquiry Status';
        cs3.Description = 'testing for test class';
        cs3.OwnerId = subOrdinateMAGIUser.Id;
        cs3.e2cEmailTo__c = 'customer-general@axa-mandiri.co.id';
        caseList.add(cs3);
        
        Case cs4 = new Case();
        cs4.Entity_Backup__c = 'ALI';
        cs4.Origin = 'Email';
        cs4.Status ='New';
        cs4.suppliedEmail = 'testing564@nyaho.com';
        cs4.Policy_Number__c = con4.Policy_No__c;
        cs4.ContactId = con4.Id;
        cs4.Status = 'New';
        cs4.Subject = 'ILCCYS';
        cs4.Type = 'Inquiry';
        cs4.Case_Type_Config__c = 'Inquiry Status';
        cs4.Description = 'testing for test class';
        cs4.OwnerId = subOrdinateALIUser.Id;
        cs4.e2cEmailTo__c = 'customer@axa-financial.co.id';
        caseList.add(cs4);
        
        insert caseList;
        //Test.stopTest();
        
        List<Call_Line__c> callLineList = new List<Call_Line__c>();
        Call_Line__c cl1 = new Call_Line__c();
        cl1.Contact__c = cs2.ContactId;
        cl1.Policy_No__c = cs2.Policy_Number__c;
        cl1.OwnerId = cs2.OwnerId;
        callLineList.add(cl1);
        
        insert callLineList;
        
        List<Email_Config__c> emailCfgList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-financial.co.id';
        ec1.Entity__c = 'AFI';
        ec1.Distribution_Type__c = 'Manual';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        emailCfgList.add(ec1);
        
        Email_Config__c ec2 = new Email_Config__c();
        ec2.Email_Address__c = 'customer@axa-financial.co.id';
        ec2.Entity__c = 'AFI';
        ec2.Distribution_Type__c = 'Automatic';
        ec2.SLA__c = '2';
        ec2.Unit__c = 'Hour';
        emailCfgList.add(ec2);
        
        insert emailCfgList;
        
        system.runAs(subOrdinateMAGIUser){
            Email2CaseController_AFI_ALI.CaseWrapper wrap = new Email2CaseController_AFI_ALI.CaseWrapper();
            wrap.id = cs3.Id;
            wrap.isSelected = true;
            wrap.indikator = cs3.Indicator__c;
            wrap.followUp = cs3.Follow_Up_Flag__c;
            wrap.caseNumber = cs3.CaseNumber ; 
            wrap.senderEmail = cs3.SuppliedEmail;
            wrap.toAddress = 'customer@axa-financial.co.id'; 
            wrap.customerName = cs3.Contact.Name;
            wrap.status = cs3.Status; 
            wrap.subject = cs3.Subject; 
            wrap.type = cs3.Type; 
            wrap.Entity = cs3.Entity__c; 
            wrap.createdDate = cs3.createdDate;
            wrap.assignedTo = cs3.Owner.Name;
            wrap.Description = cs3.Description; 
            
            Email2CaseController_AFI_ALI e2c = new Email2CaseController_AFI_ALI();
            e2c.getCaseRecords();
            e2c.assignUser();
            e2c.agentPicklist();
            e2c.refreshList();
            e2c.getPagingButtons();
            e2c.selectedInbox();
            e2c.refreshGrid();
            e2c.Previous();
            e2c.Next();
            e2c.End();
            e2c.getDisablePrevious();
            e2c.getDisableNext();
            e2c.getNoOfRecords();
            e2c.getPageNumber();
            e2c.getTotalPages();
            e2c.assignedInbox = 'customer-general@axa-mandiri.co.id';
            e2c.searchCustomerName = 'Hamfree';
            e2c.searchPolicyNo = '1234-56783';
            e2c.searchSubjectandBody = 'ILCCYS';
            e2c.assignedAgent = subOrdinateMAGIUser.Id;
            e2c.assignUser();
            //e2c.calculateEmailSLA('customer-general@axa-mandiri.co.id');
            //e2c.selectedInbox();
        }
        
        Test.stopTest();
    }
}