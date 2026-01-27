@istest
public class SurveyICFComplaintFuture_Test {
    public static testmethod void createCaseAsk() {
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
        
        String STATUS = 'Closed';
         
        Contact contact2 = [Select id, AccountId from Contact limit 1];
        
        Case setCase = new Case();
        setCase.ContactId = contact1.Id;
        setCase.Type = COMPLAINT;
        setCase.Status = STATUS;
        setCase.Priority = 'Medium';
        setCase.Origin = 'Phone';
        setCase.Case_Type__c = 'MV Claim Report';
        setCase.Case_Type_Config__c = 'MV Claim Report';
        setCase.PIC_Department_LU__c = UserInfo.getUserId();
        setCase.AccountId = contact2.AccountId;
        setCase.Already_Send_Survey__c = false;
        insert setCase; 
        
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
        
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = setCase.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.MOT__c = 'I Complain';
        esl.Request_Date__c = todayDate;
        insert esl; 
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        SurveyICFComplaintFuture.checkSurveyICF(emailIds);
        
        Test.stopTest();
    }
    
    public static testmethod void createCaseComplaintApproveEmail() {
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
        contact1.Policy_No__c = '77700101';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'ICF Email (AMFS) 2024';
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
        
        String STATUS = 'Closed';
         
        Contact contact2 = [Select id, AccountId from Contact limit 1];
        
        Case setCase = new Case();
        setCase.ContactId = contact1.Id;
        setCase.Type = COMPLAINT;
        setCase.Status = STATUS;
        setCase.Priority = 'Medium';
        setCase.Origin = 'Phone';
        setCase.Case_Type__c = 'MV Claim Report';
        setCase.Case_Type_Config__c = 'MV Claim Report';
        setCase.PIC_Department_LU__c = UserInfo.getUserId();
        setCase.AccountId = contact2.AccountId;
        setCase.Already_Send_Survey__c = false;
        setCase.Subject = 'Subject REQ';
        setCase.CHS_Status__c = 'Closed - Valid';
        setCase.Complaint_Decision_AMFS__c = 'Approve & Paid';
        setCase.Complaint_Decision__c = 'Approved';
        setCase.Financial_Lost__c = 0;
        setCase.Conclusion__c = 'Approved';
        setCase.Corrective_Action__c = 'Approved';
        setCase.Other_Information__c = 'Approved';
        setCase.Reason_Root_Cause__c = 'Approved';
        setCase.NDA_Date__c = Date.today();
        setCase.Paid_Amount__c = 0;
        setCase.Sub_Status__c = 'Approved Paid';
        insert setCase; 
        
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
        
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = setCase.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.MOT__c = 'I Complain';
        esl.Request_Date__c = todayDate;
        insert esl; 
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        SurveyICFComplaintFuture.checkSurveyICF(emailIds);
        
        Test.stopTest();
    }
    
    public static testmethod void createCaseComplaintApproveWhatsapp() {
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
        setSurvey.name = 'ICF Email (AMFS) 2024';
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
        
        String STATUS = 'Closed';
         
        Contact contact2 = [Select id, AccountId from Contact limit 1];
        
        Case setCase = new Case();
        setCase.ContactId = contact1.Id;
        setCase.Type = COMPLAINT;
        setCase.Status = STATUS;
        setCase.Priority = 'Medium';
        setCase.Origin = 'Phone';
        setCase.Case_Type__c = 'MV Claim Report';
        setCase.Case_Type_Config__c = 'MV Claim Report';
        setCase.PIC_Department_LU__c = UserInfo.getUserId();
        setCase.AccountId = contact2.AccountId;
        setCase.Already_Send_Survey__c = false;
        setCase.Subject = 'Subject REQ';
        setCase.CHS_Status__c = 'Closed - Valid';
        setCase.Complaint_Decision_AMFS__c = 'Approve & Paid';
        setCase.Complaint_Decision__c = 'Approved';
        setCase.Financial_Lost__c = 0;
        setCase.Conclusion__c = 'Approved';
        setCase.Corrective_Action__c = 'Approved';
        setCase.Other_Information__c = 'Approved';
        setCase.Reason_Root_Cause__c = 'Approved';
        setCase.NDA_Date__c = Date.today();
        setCase.Paid_Amount__c = 0;
        setCase.Sub_Status__c = 'Approved Paid';
        insert setCase; 
        
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
        
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = setCase.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.MOT__c = 'I Complain';
        esl.Request_Date__c = todayDate;
        insert esl; 
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        SurveyICFComplaintFuture.checkSurveyICF(emailIds);
        
        Test.stopTest();
    }
	
    public static testmethod void createCaseComplaintRejectEmail() {
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
        contact1.Policy_No__c = '77700101';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'ICF Email (AMFS) 2024';
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
        
        String STATUS = 'Closed';
         
        Contact contact2 = [Select id, AccountId from Contact limit 1];
        
        Case setCase = new Case();
        setCase.ContactId = contact1.Id;
        setCase.Type = COMPLAINT;
        setCase.Status = STATUS;
        setCase.Priority = 'Medium';
        setCase.Origin = 'Phone';
        setCase.Case_Type__c = 'MV Claim Report';
        setCase.Case_Type_Config__c = 'MV Claim Report';
        setCase.PIC_Department_LU__c = UserInfo.getUserId();
        setCase.AccountId = contact2.AccountId;
        setCase.Already_Send_Survey__c = false;
        setCase.Subject = 'Subject REQ';
        setCase.CHS_Status__c = 'Closed - Invalid';
        setCase.Complaint_Decision_AMFS__c = 'Invalid & Reject';
        setCase.Complaint_Decision__c = 'Reject';
        setCase.Financial_Lost__c = 0;
        setCase.Conclusion__c = 'Reject';
        setCase.Corrective_Action__c = 'Reject';
        setCase.Other_Information__c = 'Reject';
        setCase.Reason_Root_Cause__c = 'Reject';
        setCase.NDA_Date__c = Date.today();
        setCase.Paid_Amount__c = 0;
        setCase.Sub_Status__c = 'Cancelled';
        insert setCase; 
        
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
        
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = setCase.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.MOT__c = 'I Complain';
        esl.Request_Date__c = todayDate;
        insert esl; 
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        SurveyICFComplaintFuture.checkSurveyICF(emailIds);
        
        Test.stopTest();
    }
    
    public static testmethod void createCaseComplaintRejectWhatsapp() {
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
        setSurvey.name = 'ICF Email (AMFS) 2024';
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
        
        String STATUS = 'Closed';
         
        Contact contact2 = [Select id, AccountId from Contact limit 1];
        
        Case setCase = new Case();
        setCase.ContactId = contact1.Id;
        setCase.Type = COMPLAINT;
        setCase.Status = STATUS;
        setCase.Priority = 'Medium';
        setCase.Origin = 'Phone';
        setCase.Case_Type__c = 'MV Claim Report';
        setCase.Case_Type_Config__c = 'MV Claim Report';
        setCase.PIC_Department_LU__c = UserInfo.getUserId();
        setCase.AccountId = contact2.AccountId;
        setCase.Already_Send_Survey__c = false;
        setCase.Subject = 'Subject REQ';
        setCase.CHS_Status__c = 'Closed - Invalid';
        setCase.Complaint_Decision_AMFS__c = 'Invalid & Reject';
        setCase.Complaint_Decision__c = 'Reject';
        setCase.Financial_Lost__c = 0;
        setCase.Conclusion__c = 'Reject';
        setCase.Corrective_Action__c = 'Reject';
        setCase.Other_Information__c = 'Reject';
        setCase.Reason_Root_Cause__c = 'Reject';
        setCase.NDA_Date__c = Date.today();
        setCase.Paid_Amount__c = 0;
        setCase.Sub_Status__c = 'Cancelled';
        insert setCase; 
        
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
        
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.Status__c = 'Draft';
        esl.Contact__c = contact1.Id;
        esl.case__c = setCase.id;
        esl.Account__c = contact1.AccountId;
        esl.Entity__c = contact1.Entity__c;
        esl.Email__c = contact1.Email;
        esl.Mobile__c = contact1.MobilePhone;
        esl.Send_Flag__c = true;
        esl.Category__c = ICF;
        esl.Type__c = 'CCC';
        esl.Method__c = 'Email';
        esl.MOT__c = 'I Complain';
        esl.Request_Date__c = todayDate;
        insert esl; 
        
        Set<Id> emailIds = new Set<Id>();
        emailIds.add(esl.id); 
        SurveyICFComplaintFuture.checkSurveyICF(emailIds);
        
        Test.stopTest();
    }
}