@istest
public class CheckSurveyICFFutureTest2 {
    @testSetup static void setupRecord() {
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest10';
        ac1.Entity__c = entity;
        insert ac1;

        Account ac2 = new Account();
        ac2.Name = 'AccountTest20';
        ac2.Entity__c = entity;
        insert ac2;
        
        Account ac3 = new Account();
        ac3.Name = 'AccountTest30';
        ac3.Entity__c = entity;
        insert ac3;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Jeff';
        contact1.LastName = 'Bezos';
        contact1.Email = 'jeffbezos@email.com'; 
        contact1.Policy_No__c = '520-4931835';
        contact1.PolicyApp__c = 'RLS';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        Contact contact2 = new Contact();
        contact2.FirstName = 'Bill';
        contact2.LastName = 'Gates';
        contact2.Email = 'billgates@email.com';
        contact2.MobilePhone = '0891667364';
        contact2.Policy_No__c = '77700102';
        contact2.Entity__c = entity;
        contact2.AccountId = ac2.Id;
        insert contact2;
        
        Contact contact3 = new Contact();
        contact3.FirstName = 'Bill';
        contact3.LastName = 'Gates No Phone';
        contact3.Email = 'billgatesnophone@email.com';
        contact3.MobilePhone = '';
        contact3.Policy_No__c = '77700103';
        contact3.Entity__c = entity;
        contact3.AccountId = ac2.Id;
        insert contact3;
                  
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Qualtrics').getRecordTypeId();
        testICFParam.Interval_Completed_Month__c = '1';
        testICFParam.Entity__c = 'AMFS';
        testICFParam.Status__c = 'Active';
        testICFParam.Status_Cases__c = 'Closed';
        insert testICFParam;
        
        ICF_Parameter__c testICFParam2 = new ICF_Parameter__c();
        testICFParam2.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam2.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId();
        testICFParam2.Interval_Completed_Month__c = '1';
        testICFParam2.Entity__c = 'AMFS';
        testICFParam2.Status__c = 'Active';
        testICFParam2.Status_Cases__c = 'Closed';
        insert testICFParam2;
        
        ICF_Parameter__c testICFParam3 = new ICF_Parameter__c();
        testICFParam3.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam3.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - CCC').getRecordTypeId();
        testICFParam3.Interval_Completed_Month__c = '1';
        testICFParam3.Entity__c = 'AMFS';
        testICFParam3.Status__c = 'Active';
        testICFParam3.Status_Cases__c = 'Closed';
        insert testICFParam3;
                
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'Survey POS/Request';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master New Onboarding').getRecordTypeId();
        setSurvey.URL__c = 'https://axaid-ccc--fullsb.sandbox.my.salesforce-sites.com/survey/TakeSurveyDynamic?';
        setSurvey.Entity__c = 'AMFS';
        setSurvey.Status__c = 'Active';
        insert setSurvey;

        Survey__c setSurvey2 = new Survey__c();
        setSurvey2.name = 'testing';
        setSurvey2.Submit_Response__c = 'empty';
        setSurvey2.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master Qualtrics').getRecordTypeId();
        setSurvey2.URL__c = 'https://axaid-ccc--fullsb.sandbox.my.salesforce-sites.com/survey/TakeSurvey?';
        setSurvey2.Entity__c = 'AMFS';
        setSurvey2.Status__c = 'Active';
        insert setSurvey2;
            
        RecordType masterRecordType = [SELECT Id FROM RecordType WHERE SobjectType = 'Survey__c' AND DeveloperName = 'Master' LIMIT 1];
        Survey__c setSurvey3 = new Survey__c();
        setSurvey3.name = 'testing 2';
        setSurvey3.Submit_Response__c = 'empty';
        setSurvey3.RecordTypeId = masterRecordType.Id;
        setSurvey3.URL__c = 'https://axaid-ccc--fullsb.sandbox.my.salesforce-sites.com/survey/TakeSurvey?';
        setSurvey3.Entity__c = 'AMFS';
        setSurvey3.Status__c = 'Active';
        insert setSurvey3;

        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        setCaseType.name = 'Case Type I Buy';
        setCaseType.Case_Type__c = 'Case Type I Buy';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Buy';
        setCaseType.Qualtrics__c  = true;
        INSERT setCaseType;

        Master_Case_Type_Regional__c setCaseType2 = new Master_Case_Type_Regional__c();
        setCaseType2.name = 'Case Type I Renew';
        setCaseType2.Case_Type__c = 'Case Type I Renew';
        setCaseType2.Entity__c = 'AMFS';
        setCaseType2.MOT__c = 'I Renew';
        setCaseType2.Qualtrics__c  = true;
        INSERT setCaseType2;

        Master_Case_Type_Regional__c setCaseType3 = new Master_Case_Type_Regional__c();
        setCaseType3.name = 'Case Type I Claim';
        setCaseType3.Case_Type__c = 'Case Type I Claim';
        setCaseType3.Entity__c = 'AMFS';
        setCaseType3.MOT__c = 'I Claim';
        setCaseType3.Qualtrics__c  = true;
        INSERT setCaseType3;

        Master_Case_Type_Regional__c setCaseType4 = new Master_Case_Type_Regional__c();
        setCaseType4.name = 'Case Type I Complaint';
        setCaseType4.Case_Type__c = 'Case Type I Complaint';
        setCaseType4.Entity__c = 'AMFS';
        setCaseType4.MOT__c = 'I Complaint';
        setCaseType4.Qualtrics__c  = true;
        INSERT setCaseType4;

        Master_Case_Type_Regional__c setCaseType5 = new Master_Case_Type_Regional__c();
        setCaseType5.name = 'Case Type I Ask';
        setCaseType5.Case_Type__c = 'Case Type I Ask';
        setCaseType5.Entity__c = 'AMFS';
        setCaseType5.MOT__c = 'I Ask';
        setCaseType5.Qualtrics__c  = true;
        setCaseType5.type__c  = 'Inquiry';
        INSERT setCaseType5;

        Master_Case_Type_Regional__c setCaseType6 = new Master_Case_Type_Regional__c();
        setCaseType6.name = 'Case Type I Ask 2';
        setCaseType6.Case_Type__c = 'Case Type I Ask 2';
        setCaseType6.Entity__c = 'AMFS';
        setCaseType6.MOT__c = 'I Ask';
        setCaseType6.Qualtrics__c  = true;
        INSERT setCaseType6;

        Email_SMS_Template__c template = new Email_SMS_Template__c();
        template.Name = 'ICF Email (AMFS) 2024';
        template.Category__c = 'ICF';
        template.Detail_Link__c = '[SURVEY_LINK]';
        template.Email_Body__c = '[CONTACT_GENDER] [CONTACT_NAME] [CASE_NUMBER] [POLICY_NO] [MOT_SERVICE] [SURVEY_LINK]';
        template.Entity__c = 'AMFS';
        template.Subject__c = 'Survey Kepuasan Nasabah [MOT_SERVICE]';
        insert template;
    }

    public static testmethod void createCaseAsk() {
        Test.startTest();
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';

        Account Account1 = [SELECT Id FROM Account WHERE Name = 'AccountTest20' limit 1];
        Contact contact1 = [SELECT Id, AccountId, Entity__c, Email, MobilePhone FROM Contact WHERE LastName = 'Gates' limit 1];
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = 'Inquiry';
        inquiryCreateOpen.Status = 'New';
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen.Case_Type_Config__c = 'Inquiry_CS Info Manfaat Polis' ;
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        insert inquiryCreateOpen;
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = 'ICF';
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Ask';
        esl.MOT__c = 'I Ask';
        esl.Request_Date__c = Date.Today();
        insert esl; 
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        esl.status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        Test.stopTest();
    }

    public static testmethod void createCaseAsk2() {
        Test.startTest();
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';
        
        Account Account1 = [SELECT Id FROM Account WHERE Name = 'AccountTest20' limit 1];
        Contact contact1 = [SELECT Id, AccountId, Entity__c, Email, MobilePhone FROM Contact WHERE LastName = 'Gates' limit 1];
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = 'Inquiy';
        inquiryCreateOpen.Status = 'New';
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        insert inquiryCreateOpen;
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = 'ICF';
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Ask';
        esl.MOT__c = 'I Ask';
        esl.Request_Date__c = Date.Today();
        insert esl;
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        esl.status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        Test.stopTest();
    }

    public static testmethod void createCaseBuy() {
        Test.startTest();
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';
        
        Account Account1 = [SELECT Id FROM Account WHERE Name = 'AccountTest20' limit 1];
        Contact contact1 = [SELECT Id, AccountId, Entity__c, Email, MobilePhone FROM Contact WHERE LastName = 'Gates' limit 1];
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = 'Inquiry';
        inquiryCreateOpen.Status = 'New';
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.MOT__c = 'I Buy';
        inquiryCreateOpen.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        insert inquiryCreateOpen;
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = 'ICF';
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Buy'; 
        esl.MOT__c = 'I Buy';
        esl.Request_Date__c = Date.Today();
        insert esl;
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        esl.status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        Test.stopTest();
    }

    public static testmethod void createCaseRenew() {
        Test.startTest();
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';
        
        Account Account1 = [SELECT Id FROM Account WHERE Name = 'AccountTest20' limit 1];
        Contact contact1 = [SELECT Id, AccountId, Entity__c, Email, MobilePhone FROM Contact WHERE LastName = 'Gates' limit 1];
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = 'Inquiry';
        inquiryCreateOpen.Status = 'New';
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.MOT__c = 'I Renew';
        inquiryCreateOpen.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        insert inquiryCreateOpen;     
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = 'ICF';
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Renew'; 
        esl.MOT__c = 'I Renew';
        esl.Request_Date__c = Date.Today();
        insert esl;
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        esl.status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        Test.stopTest();
    }

    public static testmethod void createCaseClaim() {
        Test.startTest();
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';
        
        Account Account1 = [SELECT Id FROM Account WHERE Name = 'AccountTest20' limit 1];
        Contact contact1 = [SELECT Id, AccountId, Entity__c, Email, MobilePhone FROM Contact WHERE LastName = 'Gates' limit 1];
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = 'Inquiry';
        inquiryCreateOpen.Status = 'New';
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.MOT__c = 'I Claim';
        inquiryCreateOpen.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        insert inquiryCreateOpen;
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = 'ICF';
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Claim'; 
        esl.MOT__c = 'I Claim';
        esl.Request_Date__c = Date.Today();
        insert esl;
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        esl.status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        Test.stopTest();
    }

    public static testmethod void createCaseClaim2() {
        Test.startTest();
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';
        
        Account Account1 = [SELECT Id FROM Account WHERE Name = 'AccountTest20' limit 1];
        Contact contact1 = [SELECT Id, AccountId, Entity__c, Email, MobilePhone FROM Contact WHERE LastName = 'Gates' limit 1];
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = 'Request';
        inquiryCreateOpen.Status = 'Closed';
        inquiryCreateOpen.MOT__c = 'I Claim';
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Entity_Backup__c = 'AMFS';
        inquiryCreateOpen.Case_Type__c = 'Request_Claim_Payment';
        inquiryCreateOpen.Case_Type_Config__c = 'Request_Claim_Payment' ;
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        insert inquiryCreateOpen;
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = 'ICF';
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Ask';
        esl.MOT__c = 'I Ask';
        esl.Request_Date__c = Date.Today();
        esl.Email_Text__c = '<table width="100%"> <tr> <td colspan="2"><img src="https://c.ap4.content.force.com/servlet/servlet.ImageServer?id=0156F00000HhS59&oid=00D90000000zAlz&lastMod=1556081666000" width="250" align="right" /></td> </tr> <tr> <td> <table width="100%"> <tr> <td colspan="3"> <b>Yth. Ibu LASINEM , </b><br/> Terima kasih telah mempercayakan perlindungan Anda & keluarga kepada AXA Mandiri. <br/> Untuk meningkatkan kualitas pelayanan kami, mohon berikan penilaian Anda kepada kami dengan mengisi survei singkat ini. <br/> Berikut informasi interaksi Anda [SHORT_URL] / <i>Your case information </i> :<br/> </td> </tr> <tr> <td width="10%">Nomor / <i>Case no</i></td> <td width="1%">:</td> <td><i><b> 05417543 </b> </i></td> </tr> <tr> <td>Nomor Polis / <i>Policy no </i></td> <td>:</td> <td><i><b> 514-5863659 </b> </i></td> </tr> <tr> <td>Transaksi/ <i>Transaction</i></td> <td>:</td> <td><i><b> Pembayaran Claim </b> </i></td> </tr> <tr> <td colspan="3"><br/> Klik link berikut : <a href=" https://axaid-ccc--fullsb.sandbox.my.salesforce-sites.com/survey/TakeSurvey?id=a0PF800000Aqna2MAB&cId=0039000001XlvbkAAB&caId=500F800000AROtdIAH "><b>Link Survei</b> </a><br/><br/> <b>PT AXA Mandiri Financial Services</b><br/><br/> <img src="https://c.ap4.content.force.com/servlet/servlet.ImageServer?id=0156F00000HhS59&oid=00D90000000zAlz&lastMod=1556081666000" width="250" style="margin: 0 0 0 0"/> </td> </tr> </table> <br/> <tr> <td colspan="2"><b>INFO : </b><br/> Apabila Anda membutuhkan informasi lebih lanjut, kami siap membantu Anda di layanan <b>Customer Care Centre</b> atau <b>Layanan Live Chat</b> <a href="www.axa-mandiri.co.id">www.axa-mandiri.co.id</a> atau Anda dapat mengirimkan email ke <a href="mailto:customer@axa-mandiri.co.id">customer@axa-mandiri.co.id</a> <br/> <i>For more info, please contact <b>Customer Care Centre</b> or <b>Live Chat Service</b> <a href="www.axa-mandiri.co.id">www.axa-mandiri.co.id</a> or email to <a href="mailto:customer@axa-mandiri.co.id">customer@axa-mandiri.co.id</a></i> </td> </tr></table>';
        insert esl;
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        esl.status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        Test.stopTest();
    }

    public static testmethod void createCaseClaim3() {
        Test.startTest();
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master Qualtrics').getRecordTypeId();
        insert setSurvey;
        
        Account Account1 = [SELECT Id FROM Account WHERE Name = 'AccountTest10' limit 1];
        Contact contact1 = [SELECT Id, AccountId, Entity__c, Email, MobilePhone FROM Contact WHERE LastName = 'Bezos' limit 1];
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = 'Request';
        inquiryCreateOpen.Status = 'New';
        inquiryCreateOpen.MOT__c = 'I Claim';
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Entity_Backup__c = 'AMFS';
        inquiryCreateOpen.Case_Type__c = 'Request_Claim_Payment';
        inquiryCreateOpen.Case_Type_Config__c = 'Request_Claim_Payment' ;
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        insert inquiryCreateOpen;
        
        Case inquiryCreateOpen2 = new Case();
        inquiryCreateOpen2.ContactId = contact1.Id;
        inquiryCreateOpen2.Type = 'Complaint';
        inquiryCreateOpen2.Status = 'New';
        inquiryCreateOpen2.MOT__c = 'I Claim';
        inquiryCreateOpen2.Priority = 'Medium';
        inquiryCreateOpen2.Entity_Backup__c = 'AMFS';
        inquiryCreateOpen2.Case_Type__c = 'Request_Claim_Payment';
        inquiryCreateOpen2.Case_Type_Config__c = 'Request_Claim_Payment' ;
        inquiryCreateOpen2.Origin = 'Email';
        inquiryCreateOpen2.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen2.Subject = 'Case Subject 234567';
        inquiryCreateOpen2.AccountId = contact1.AccountId;
        inquiryCreateOpen2.PIC_Department_LU__c = userObj.Id;
        inquiryCreateOpen2.Date_of_Submit__c = Date.Today();
        insert inquiryCreateOpen2;      
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = 'ICF';
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Ask';
        esl.MOT__c = 'I Ask';
        esl.Request_Date__c = Date.Today();
        esl.Email_Text__c = '<table width="100%"> <tr> <td colspan="2"><img src="https://c.ap4.content.force.com/servlet/servlet.ImageServer?id=0156F00000HhS59&oid=00D90000000zAlz&lastMod=1556081666000" width="250" align="right" /></td> </tr> <tr> <td> <table width="100%"> <tr> <td colspan="3"> <b>Yth. Ibu LASINEM , </b><br/> Terima kasih telah mempercayakan perlindungan Anda & keluarga kepada AXA Mandiri. <br/> Untuk meningkatkan kualitas pelayanan kami, mohon berikan penilaian Anda kepada kami dengan mengisi survei singkat ini. <br/> Berikut informasi interaksi Anda [SHORT_URL] / <i>Your case information </i> :<br/> </td> </tr> <tr> <td width="10%">Nomor / <i>Case no</i></td> <td width="1%">:</td> <td><i><b> 05417543 </b> </i></td> </tr> <tr> <td>Nomor Polis / <i>Policy no </i></td> <td>:</td> <td><i><b> 514-5863659 </b> </i></td> </tr> <tr> <td>Transaksi/ <i>Transaction</i></td> <td>:</td> <td><i><b> Pembayaran Claim </b> </i></td> </tr> <tr> <td colspan="3"><br/> Klik link berikut : <a href=" https://axaid-ccc--fullsb.sandbox.my.salesforce-sites.com/survey/TakeSurvey?id=a0PF800000Aqna2MAB&cId=0039000001XlvbkAAB&caId=500F800000AROtdIAH "><b>Link Survei</b> </a><br/><br/> <b>PT AXA Mandiri Financial Services</b><br/><br/> <img src="https://c.ap4.content.force.com/servlet/servlet.ImageServer?id=0156F00000HhS59&oid=00D90000000zAlz&lastMod=1556081666000" width="250" style="margin: 0 0 0 0"/> </td> </tr> </table> <br/> <tr> <td colspan="2"><b>INFO : </b><br/> Apabila Anda membutuhkan informasi lebih lanjut, kami siap membantu Anda di layanan <b>Customer Care Centre</b> atau <b>Layanan Live Chat</b> <a href="www.axa-mandiri.co.id">www.axa-mandiri.co.id</a> atau Anda dapat mengirimkan email ke <a href="mailto:customer@axa-mandiri.co.id">customer@axa-mandiri.co.id</a> <br/> <i>For more info, please contact <b>Customer Care Centre</b> or <b>Live Chat Service</b> <a href="www.axa-mandiri.co.id">www.axa-mandiri.co.id</a> or email to <a href="mailto:customer@axa-mandiri.co.id">customer@axa-mandiri.co.id</a></i> </td> </tr></table>';
        insert esl;
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        //esl.status__c = 'Hold';
        //update esl;
        //CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        Test.stopTest();
    }

    public static testmethod void createCaseComplaint() {
        Test.startTest();
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';
        
        Account Account1 = [SELECT Id FROM Account WHERE Name = 'AccountTest20' limit 1];
        Contact contact1 = [SELECT Id, AccountId, Entity__c, Email, MobilePhone FROM Contact WHERE LastName = 'Gates' limit 1];

        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = 'Inquiry';
        inquiryCreateOpen.Status = 'New';
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.MOT__c = 'I Complaint';
        inquiryCreateOpen.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        insert inquiryCreateOpen; 
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = 'ICF';
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Complaint'; 
        esl.MOT__c = 'I Complaint';
        esl.Request_Date__c = Date.Today();
        insert esl;
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        esl.status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        Test.stopTest();
    }

    public static testmethod void createCaseRequestWhatsapp() {
        Test.startTest();
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';
                  
        Account Account1 = [SELECT Id FROM Account WHERE Name = 'AccountTest20' limit 1];
        Contact contact1 = [SELECT Id, AccountId, Entity__c, Email, MobilePhone FROM Contact WHERE LastName = 'Gates' limit 1];
        Email_SMS_Template__c template1 = [SELECT Id, Name, Category__c, Detail_Link__c, Email_Body__c, Entity__c, Subject__c FROM Email_SMS_Template__c WHERE Name = 'ICF Email (AMFS) 2024' limit 1];
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = 'Request POS';
        inquiryCreateOpen.Status = 'Closed';
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.Case_Type__c = 'Request_POS_Withdrawal';
        inquiryCreateOpen.Case_Type_Config__c = 'Request_POS_Withdrawal' ;
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        inquiryCreateOpen.MOT__c = 'I Ask';
        inquiryCreateOpen.Description = 'Transfer Status: success / Transfer Date: 18-03-2025 / Payment Code: PC04 / Claim Number: 1803202504';
        insert inquiryCreateOpen;
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = 'ICF';
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Ask';
        esl.MOT__c = 'I Ask';
        esl.Request_Date__c = Date.Today();
        esl.Email_SMS_Template__c = template1.Id;
        esl.Email_Text__c = '[CONTACT_GENDER] [CONTACT_NAME] [CASE_NUMBER] [POLICY_NO] [MOT_SERVICE] [SURVEY_LINK]';
        insert esl; 
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        esl.status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        Test.stopTest();
    }

    public static testmethod void createCaseRequestEmail() {
        Test.startTest();
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';
        
        Account Account1 = [SELECT Id FROM Account WHERE Name = 'AccountTest30' limit 1];
        Contact contact1 = [SELECT Id, AccountId, Entity__c, Email, MobilePhone FROM Contact WHERE LastName = 'Gates No Phone' limit 1];
        Email_SMS_Template__c template1 = [SELECT Id, Name, Category__c, Detail_Link__c, Email_Body__c, Entity__c, Subject__c FROM Email_SMS_Template__c WHERE Name = 'ICF Email (AMFS) 2024' limit 1];
        Survey__c Survey1 = [SELECT Id FROM Survey__c WHERE Name = 'Survey POS/Request' limit 1];
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = 'Request POS';
        inquiryCreateOpen.Status = 'Closed';
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.Case_Type__c = 'Request_POS_Withdrawal';
        inquiryCreateOpen.Case_Type_Config__c = 'Request_POS_Withdrawal' ;
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        inquiryCreateOpen.MOT__c = 'I Ask';
        inquiryCreateOpen.Description = 'Transfer Status: success / Transfer Date: 18-03-2025 / Payment Code: PC04 / Claim Number: 1803202504';
        insert inquiryCreateOpen;
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Hold';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = '';
        esl.Send_Flag__c = true;
        esl.Category__c = 'ICF';
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Ask';
        esl.MOT__c = 'I Ask';
        esl.Request_Date__c = Date.Today();
        esl.Email_SMS_Template__c = template1.Id;
        esl.Survey__c = Survey1.Id;
        esl.Email_Text__c = 'Test Replace Survey POS/Request [CONTACT_GENDER] [CONTACT_NAME] [CASE_NUMBER] [POLICY_NO] [MOT_SERVICE] [SURVEY_LINK]';
        insert esl; 
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        esl.Status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        Test.stopTest();
    }

    public static testmethod void createCaseCancelSend() {
        Test.startTest();
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';
                  
        Account Account1 = [SELECT Id FROM Account WHERE Name = 'AccountTest10' limit 1];
        Contact contact1 = [SELECT Id, AccountId, Entity__c, Email, MobilePhone FROM Contact WHERE LastName = 'Gates' limit 1];
        
        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        setCaseType.name = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Complaint';
        setCaseType.Qualtrics__c  = true;
        setCaseType.type__c  = 'Complaint';
        
        INSERT setCaseType;
        
        /*
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = 'Complaint';
        inquiryCreateOpen.Status = 'New';
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen.Case_Type_Config__c = 'Inquiry_CS Info Manfaat Polis' ;
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        inquiryCreateOpen.PIC_Department_LU__c = userObj.Id;
        insert inquiryCreateOpen;
		*/
        
        Case inquiryCreateOpen2 = new Case();
        inquiryCreateOpen2.ContactId = contact1.Id;
        inquiryCreateOpen2.Type = 'Request POS';
        inquiryCreateOpen2.Status = 'New';
        inquiryCreateOpen2.MOT__c = 'I Ask';
        inquiryCreateOpen2.Priority = 'Medium';
        inquiryCreateOpen2.Entity_Backup__c = 'AMFS';
        inquiryCreateOpen2.Case_Type__c = 'Request_Claim_Withdrawal';
        inquiryCreateOpen2.Case_Type_Config__c = 'Request_Claim_Withdrawal' ;
        inquiryCreateOpen2.Origin = 'Email';
        inquiryCreateOpen2.Subject = 'Case Subject 234567';
        inquiryCreateOpen2.AccountId = contact1.AccountId;
        inquiryCreateOpen2.PIC_Department_LU__c = userObj.Id;
        inquiryCreateOpen2.Date_of_Submit__c = Date.Today();
        insert inquiryCreateOpen2;
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Hold';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen2.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = 'ICF';
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.Survey_Type__c = 'I Ask';
        esl.MOT__c = 'I Ask';
        esl.Request_Date__c = Date.Today();
        insert esl; 
        
        Email_SMS_Log__c esl2 = new Email_SMS_Log__c();
        esl2.Status__c = 'Send';
        esl2.Contact__c = contact1.Id;
        esl2.case__c = inquiryCreateOpen2.id;
        esl2.Account__c = contact1.AccountId;
        esl2.Entity__c = contact1.Entity__c;
        esl2.Email__c = contact1.Email;
        esl2.Mobile__c = contact1.MobilePhone;
        esl2.Send_Flag__c = true;
        esl2.Category__c = 'ICF';
        esl2.Type__c = 'CCC';
        esl2.Method__c = 'Email';
        esl2.Survey_Type__c = 'Complaint';
        esl2.MOT__c = 'I Complaint';
        esl2.Request_Date__c = Date.Today();
        insert esl2; 
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        CheckSurveyICFFuture.checkSurveyICF(emailIds);
        esl.status__c = 'Hold';
        update esl;
        CheckSurveyICFFuture.sendSurveyViaWhatsapp(contact1.Id);
        
        Test.stopTest();
    }
}