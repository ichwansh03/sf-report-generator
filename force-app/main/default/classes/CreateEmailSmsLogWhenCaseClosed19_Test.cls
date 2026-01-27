@isTest 
public class CreateEmailSmsLogWhenCaseClosed19_Test {
    @testSetup
    static void setup() {
        String RECORD_TYPE_EMAIL_SMS = 'Master - Email & SMS';
        
        String userId = UserInfo.getUserId(); 
        User userObj = [Select id,Entity__c from  User WHERE Id = :userId ORDER BY CreatedDate DESC Limit 1];
        String entity = userObj.Entity__c;
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest17';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com';
        contact1.MobilePhone = '0891667363';
        contact1.Policy_No__c = '77700136';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        
        ICF_Parameter__c testICFParam = new ICF_Parameter__c();
        testICFParam.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId();
        testICFParam.Interval_Completed_Month__c = '1';
        testICFParam.Entity__c = entity;
        testICFParam.Status__c = 'Active';
        testICFParam.Send_ICF_Flag__c = true;
        testICFParam.Send_Thanks_Note_Flag__c = true;
        insert testICFParam;
         
        ICF_Parameter__c testICFParam2 = new ICF_Parameter__c();
        testICFParam2.CCC_I_Ask_Exculde__c = 'Product Knowledge_MRS'; 
        testICFParam2.RecordTypeId = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - CCC').getRecordTypeId();
        testICFParam2.Interval_Completed_Month__c = '1';
        testICFParam2.Entity__c = entity;
        testICFParam2.Status__c = 'Active';
        testICFParam2.Send_ICF_Flag__c = true;
        testICFParam2.Send_Thanks_Note_Flag__c = true;
        insert testICFParam2;
    }

    public static testmethod void createEmailSmsLogWhenCaseClosedTestComplaint() {
        Test.startTest();
        String COMPLAINT = 'Complaint';
        String STATUS = 'Closed';
         
        String userId = UserInfo.getUserId(); 
        User userObj = [Select id,Entity__c from  User WHERE Id = :userId ORDER BY CreatedDate DESC Limit 1];
        String entity = userObj.Entity__c;

        Contact contact1 = [Select id,AccountId from Contact limit 1];
        
        Case setCase = new Case();
        setCase.ContactId = contact1.Id;
        setCase.Type = COMPLAINT;
        setCase.Status = STATUS;
        setCase.Priority = 'Medium';
        setCase.Origin = 'Phone';
        setCase.Case_Type__c = 'MV Claim Report';
        setCase.Case_Type_Config__c = 'MV Claim Report';
        setCase.PIC_Department_LU__c = UserInfo.getUserId();
        setCase.AccountId = contact1.AccountId;
        setCase.Already_Send_Survey__c = false;
        
        insert setCase; 
        
        Test.stopTest();
    }
    
    
    public static testmethod void createEmailSmsLogWhenCaseClosedTestComplaint2() {
        Test.startTest();
        String COMPLAINT = 'Complaint';
        String STATUS = 'Closed';

        String userId = UserInfo.getUserId(); 
        User userObj = [Select id,Entity__c from  User WHERE Id = :userId ORDER BY CreatedDate DESC Limit 1];
        String entity = userObj.Entity__c;

        Contact contact1 = [Select id,AccountId from Contact limit 1];
        
        String RTMasterEmailSMS = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId(); 
        
        ICF_Parameter__c updateICF = [Select id from ICF_Parameter__c where RecordTypeId=: RTMasterEmailSMS and Entity__c =: entity];
        updateICF.Send_ICF_Flag__c = false;
        update updateICF;

        Case setCase = new Case();
        setCase.ContactId = contact1.Id;
        setCase.Type = COMPLAINT;
        setCase.Status = STATUS;
        setCase.Priority = 'Medium';
        setCase.Origin = 'Phone';
        setCase.Case_Type__c = 'MV Claim Report';
        setCase.Case_Type_Config__c = 'MV Claim Report';
        setCase.PIC_Department_LU__c = UserInfo.getUserId();
        setCase.AccountId = contact1.AccountId;
        setCase.Already_Send_Survey__c = false;
        
        insert setCase; 
        
        Test.stopTest();
    }
     
    public static testmethod void createEmailSmsLogWhenCaseClosedTestComplaint3() {
        Test.startTest();
        String COMPLAINT = 'Complaint';
        String STATUS = 'Closed';

        String userId = UserInfo.getUserId(); 
        User userObj = [Select id,Entity__c from  User WHERE Id = :userId ORDER BY CreatedDate DESC Limit 1];
        String entity = userObj.Entity__c;

        Contact contact1 = [Select id,AccountId from Contact limit 1];
        
        String RTMasterEmailSMS = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId(); 
        
        ICF_Parameter__c updateICF = [Select id from ICF_Parameter__c where RecordTypeId=: RTMasterEmailSMS and Entity__c =: entity];
        updateICF.Send_Thanks_Note_Flag__c = false;
        update updateICF;

        Case setCase = new Case();
        setCase.ContactId = contact1.Id;
        setCase.Type = COMPLAINT;
        setCase.Status = STATUS;
        setCase.Priority = 'Medium';
        setCase.Origin = 'Phone';
        setCase.Case_Type__c = 'MV Claim Report';
        setCase.Case_Type_Config__c = 'MV Claim Report';
        setCase.PIC_Department_LU__c = UserInfo.getUserId();
        setCase.AccountId = contact1.AccountId;
        setCase.Already_Send_Survey__c = false;
        
        insert setCase; 
        
        Test.stopTest();
    }

    public static testmethod void createEmailSmsLogWhenCaseClosedTestComplaint4() {
        Test.startTest();
        String COMPLAINT = 'Complaint';
        String STATUS = 'New';
         
        String userId = UserInfo.getUserId(); 
        User userObj = [Select id,Entity__c from  User WHERE Id = :userId ORDER BY CreatedDate DESC Limit 1];
        String entity = userObj.Entity__c;

        Contact contact1 = [Select id,AccountId from Contact limit 1];
        
        Case setCase = new Case();
        setCase.ContactId = contact1.Id;
        setCase.Type = COMPLAINT;
        setCase.Status = STATUS;
        setCase.Priority = 'Medium';
        setCase.Origin = 'Phone';
        setCase.Case_Type__c = 'MV Claim Report';
        setCase.Case_Type_Config__c = 'MV Claim Report';
        setCase.PIC_Department_LU__c = UserInfo.getUserId();
        setCase.AccountId = contact1.AccountId;
        setCase.Already_Send_Survey__c = false;
        
        insert setCase; 
        
        Test.stopTest();
    }

    public static testmethod void createEmailSmsLogWhenCaseClosedTestComplaint5() {
        Test.startTest();
        String COMPLAINT = 'Complaint';
        String STATUS = 'New';

        String userId = UserInfo.getUserId(); 
        User userObj = [Select id,Entity__c from  User WHERE Id = :userId ORDER BY CreatedDate DESC Limit 1];
        String entity = userObj.Entity__c;

        Contact contact1 = [Select id,AccountId from Contact limit 1];
        
        String RTMasterEmailSMS = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId(); 
        
        ICF_Parameter__c updateICF = [Select id from ICF_Parameter__c where RecordTypeId=: RTMasterEmailSMS and Entity__c =: entity];
        updateICF.Send_ICF_Flag__c = false;
        update updateICF;

        Case setCase = new Case();
        setCase.ContactId = contact1.Id;
        setCase.Type = COMPLAINT;
        setCase.Status = STATUS;
        setCase.Priority = 'Medium';
        setCase.Origin = 'Phone';
        setCase.Case_Type__c = 'MV Claim Report';
        setCase.Case_Type_Config__c = 'MV Claim Report';
        setCase.PIC_Department_LU__c = UserInfo.getUserId();
        setCase.AccountId = contact1.AccountId;
        setCase.Already_Send_Survey__c = false;
        
        insert setCase; 
        
        Test.stopTest();
    }
     
    public static testmethod void createEmailSmsLogWhenCaseClosedTestComplaint6() {
        Test.startTest();
        String COMPLAINT = 'Complaint';
        String STATUS = 'New';

        String userId = UserInfo.getUserId(); 
        User userObj = [Select id,Entity__c from  User WHERE Id = :userId ORDER BY CreatedDate DESC Limit 1];
        String entity = userObj.Entity__c;

        Contact contact1 = [Select id,AccountId from Contact limit 1];
        
        String RTMasterEmailSMS = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId(); 
        
        ICF_Parameter__c updateICF = [Select id from ICF_Parameter__c where RecordTypeId=: RTMasterEmailSMS and Entity__c =: entity];
        updateICF.Send_Thanks_Note_Flag__c = false;
        update updateICF;

        Case setCase = new Case();
        setCase.ContactId = contact1.Id;
        setCase.Type = COMPLAINT;
        setCase.Status = STATUS;
        setCase.Priority = 'Medium';
        setCase.Origin = 'Phone';
        setCase.Case_Type__c = 'MV Claim Report';
        setCase.Case_Type_Config__c = 'MV Claim Report';
        setCase.PIC_Department_LU__c = UserInfo.getUserId();
        setCase.AccountId = contact1.AccountId;
        setCase.Already_Send_Survey__c = false;
        
        insert setCase; 
        
        Test.stopTest();
    }
}