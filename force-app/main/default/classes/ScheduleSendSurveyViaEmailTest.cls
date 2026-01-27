@isTest
public class ScheduleSendSurveyViaEmailTest { 
    public static testmethod void sendSurvey() {
        Test.startTest();
        String ICF = 'ICF';
        String I_ASK = 'I Ask';
        String I_BUY = 'I Buy';
        String I_CLAIM = 'I Claim';
        String I_COMPLAIN = 'I Complain';
        String I_RENEW = 'I Renew';
        Date todayDate = Date.today();
        String INQUIRY = 'Inquiry';
        String REQUEST = 'Request';
        String COMPLAINT = 'Complaint';
        String NEW_STATUS = 'New';
        String RECORD_TYPE_MASTER_QUALTRICS = 'Master - Qualtrics';
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest20';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com';
        contact1.MobilePhone = '0891667363';
        contact1.Policy_No__c = '77700101';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master Qualtrics').getRecordTypeId();
        insert setSurvey;
        
        
        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        setCaseType.name = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Ask';
        setCaseType.Qualtrics__c  = true;
        INSERT setCaseType;
        
        Case inquiryCreateOpen = new Case();
        inquiryCreateOpen.ContactId = contact1.Id;
        inquiryCreateOpen.Type = INQUIRY;
        inquiryCreateOpen.Status = NEW_STATUS;
        inquiryCreateOpen.Priority = 'Medium';
        inquiryCreateOpen.Origin = 'Email';
        inquiryCreateOpen.MOT__c = 'I Ask';
        inquiryCreateOpen.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        inquiryCreateOpen.Subject = 'Case Subject 23456';
        inquiryCreateOpen.AccountId = contact1.AccountId;
        insert inquiryCreateOpen;
        
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Qualtrics').getRecordTypeId();
        testICFParam.Interval_Completed_Month__c = '1';
        testICFParam.Entity__c = 'AMFS';
        testICFParam.Status__c = 'Active';
        insert testICFParam;
        
        ICF_Parameter__c testICFParam2 = new ICF_Parameter__c();
        testICFParam2.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam2.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId();
        testICFParam2.Interval_Completed_Month__c = '1';
        testICFParam2.Entity__c = 'AMFS';
        testICFParam2.Status__c = 'Active';
        insert testICFParam2;
        
        ICF_Template_and_Namespace__c setTemplate = new ICF_Template_and_Namespace__c();
        setTemplate.Survey_Type__c = 'I Ask';
        setTemplate.Template_ID__c = 'test';
        setTemplate.Namespace__c = 'test'; 
        insert setTemplate;
        
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1'; 
        est.Entity__c = 'AMFS';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3">Kepada Bapak/Ibu Yang Terhormat, <br/><br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] - [END_DATE_ID] layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br/><br/>Customer Care AXA Financial Indonesia<br/><br/><i> *Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini. </i><br/><br/></td></tr></tbody></table><hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /><table width="100%"><tbody><tr style="height: 117.372px;"><td style="width: 30.0705%; height: 117.372px;" colspan="3"><br/> Dear sir / madam,<br/><br/><br/>In connection with <b> [DESCRIPTION_EN], </b>then on [START_DATE_EN] - [END_DATE_EN] the service does not operate.<br/>We will be operating back and responding your email on [ACTIVE_DATE_EN] or on the next business day.<br/><br/>Best regards,<br/>AXA Financial Indonesia Customer Care<br/><br/><i> *This email was sent automatically by the System, please do not reply this email.<br/><br/> </i></td></tr></tbody></table>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = inquiryCreateOpen.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.MOT__c = 'I Ask';
        esl.Send_Flag__c = false;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Email_SMS_Template__c = est.id;
        esl.Method__c = 'Whatsapp';
        esl.Survey_Type__c = I_ASK;
        esl.Request_Date__c = todayDate; 
        insert esl;
        
        Database.executeBatch(new ScheduleSendSurveyViaEmail(), 200);
        
        Test.stopTest();
    }
     
}