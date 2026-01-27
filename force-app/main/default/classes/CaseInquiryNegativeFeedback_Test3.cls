@isTest(seeAllData = true)
public class CaseInquiryNegativeFeedback_Test3 {
	public static testmethod void caseInquiryNegativeFeedbackTestAFI() {
        Test.startTest();
        String caseInquiryNegativeVF = '/apex/CaseInquiryNegativeFeedback';
        String parentPageName = 'parentPageName';
        String firstLoad = 'firstLoad';
        String sourceContact = 'contact';
        String sourceEmail = 'email';
        String caseTypeConfig = '<br />Claim Procedure<br />Property Product';
         
        RecordType RecTypeId = [SELECT Id
                                     FROM RecordType
                                    WHERE SobjectType='Case'
                                          and Name ='InquiryAFICase'
                                    LIMIT 1];
        
        Case caseObj = [SELECT RecordTypeId,Type,Id,Entity__c FROM Case where RecordTypeId =:RecTypeId.Id ORDER BY CreatedDate DESC LIMIT 1];
 
        String entity = 'AFI';
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest10';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bills';
        contact1.LastName = 'Gatesx';
        contact1.Email = 'billgatesx@email.com';
        contact1.MobilePhone = '0891667362';
        contact1.Policy_No__c = '100000016';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        Negative_Feedback__c nf1 = new Negative_Feedback__c();
        nf1.Entity__c = entity;
        nf1.Description__c = 'Desc';
        nf1.Case__c = caseObj.Id;
        nf1.Contact__c = contact1.Id;
        
        PageReference pageRef = new PageReference(caseInquiryNegativeVF);
        pageRef.getParameters().put('def_contact_id', contact1.Id);
        pageRef.getParameters().put('def_account_id', ac1.Id);
        pageRef.getParameters().put('RecordType', caseObj.RecordTypeId);
        pageRef.getParameters().put('cas5', caseObj.Type);
        pageRef.getParameters().put('retURL', '/' + caseObj.Id);
        pageRef.getParameters().put('parentPageName', parentPageName);
        pageRef.getParameters().put('firstLoad', firstLoad);
        pageRef.getParameters().put('entity', entity);
        pageRef.getParameters().put('cas11', sourceContact);
        pageRef.getParameters().put('cas3', contact1.Id);
        pageRef.getParameters().put('nfid', nf1.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(caseObj);
        CaseInquiryControllerNegativeFeedback controller = new CaseInquiryControllerNegativeFeedback(sc);
        controller.selectedCaseTypeKeeper = caseTypeConfig;
        controller.save();
        controller.save_n_close();
        controller.cancel();
        Test.stopTest();
    }
    
	public static testmethod void caseInquiryNegativeFeedbackTestAMFS() {
        Test.startTest();
        String caseInquiryNegativeVF = '/apex/CaseInquiryNegativeFeedback';
        String parentPageName = 'parentPageName';
        String firstLoad = 'firstLoad';
        String sourceContact = 'contact';
        String sourceEmail = 'email';
        String caseTypeConfig = '<br />Claim Procedure<br />Property Product';
         
        RecordType RecTypeId = [SELECT Id
                                     FROM RecordType
                                    WHERE SobjectType='Case'
                                          and Name ='InquiryAMFSCase'
                                    LIMIT 1];
        
        Case caseObj = [SELECT RecordTypeId,Type,Id,Entity__c FROM Case where RecordTypeId =:RecTypeId.Id ORDER BY CreatedDate DESC LIMIT 1];
  
        String entity = 'AMFS';
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest10';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bills';
        contact1.LastName = 'Gatesx';
        contact1.Email = 'billgatesx@email.com';
        contact1.MobilePhone = '0891667362';
        contact1.Policy_No__c = '100000016';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        Negative_Feedback__c nf1 = new Negative_Feedback__c();
        nf1.Entity__c = entity;
        nf1.Description__c = 'Desc';
        nf1.Case__c = caseObj.Id;
        nf1.Contact__c = contact1.Id;
        
        PageReference pageRef = new PageReference(caseInquiryNegativeVF);
        pageRef.getParameters().put('def_contact_id', contact1.Id);
        pageRef.getParameters().put('def_account_id', ac1.Id);
        pageRef.getParameters().put('RecordType', caseObj.RecordTypeId);
        pageRef.getParameters().put('cas5', caseObj.Type);
        pageRef.getParameters().put('retURL', '/' + caseObj.Id);
        pageRef.getParameters().put('parentPageName', parentPageName); 
        pageRef.getParameters().put('entity', entity);
        pageRef.getParameters().put('cas11', sourceContact);
        pageRef.getParameters().put('cas3', contact1.Id);
        pageRef.getParameters().put('nfid', nf1.Id);
        pageRef.getParameters().put('isnegative', 'yes');
        pageRef.getParameters().put('firstLoad', 'save');
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(caseObj);
        CaseInquiryControllerNegativeFeedback controller = new CaseInquiryControllerNegativeFeedback(sc);
        controller.selectedCaseTypeKeeper = caseTypeConfig;
        controller.save(); 
        controller.cancel();
        Test.stopTest();
    }
    
	public static testmethod void caseInquiryNegativeFeedbackTestAMFSSaveNClosed() {
        Test.startTest();
        String caseInquiryNegativeVF = '/apex/CaseInquiryNegativeFeedback';
        String parentPageName = 'parentPageName';
        String firstLoad = 'firstLoad';
        String sourceContact = 'contact';
        String sourceEmail = 'email';
        String caseTypeConfig = '<br />Claim Procedure<br />Property Product';
         
        RecordType RecTypeId = [SELECT Id
                                     FROM RecordType
                                    WHERE SobjectType='Case'
                                          and Name ='InquiryAMFSCase'
                                    LIMIT 1];
        
        Case caseObj = [SELECT RecordTypeId,Type,Id,Entity__c FROM Case where RecordTypeId =:RecTypeId.Id ORDER BY CreatedDate DESC LIMIT 1];
  
        String entity = 'AMFS';
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest10';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bills';
        contact1.LastName = 'Gatesx';
        contact1.Email = 'billgatesx@email.com';
        contact1.MobilePhone = '0891667362';
        contact1.Policy_No__c = '100000016';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        Negative_Feedback__c nf1 = new Negative_Feedback__c();
        nf1.Entity__c = entity;
        nf1.Description__c = 'Desc';
        nf1.Case__c = caseObj.Id;
        nf1.Contact__c = contact1.Id;
        
        PageReference pageRef = new PageReference(caseInquiryNegativeVF);
        pageRef.getParameters().put('def_contact_id', contact1.Id);
        pageRef.getParameters().put('def_account_id', ac1.Id);
        pageRef.getParameters().put('RecordType', caseObj.RecordTypeId);
        pageRef.getParameters().put('cas5', caseObj.Type);
        pageRef.getParameters().put('retURL', '/' + caseObj.Id);
        pageRef.getParameters().put('parentPageName', parentPageName); 
        pageRef.getParameters().put('entity', entity);
        pageRef.getParameters().put('cas11', sourceContact);
        pageRef.getParameters().put('cas3', contact1.Id);
        pageRef.getParameters().put('nfid', nf1.Id);
        pageRef.getParameters().put('isnegative', 'yes');
        pageRef.getParameters().put('firstLoad', 'closed');
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(caseObj);
        CaseInquiryControllerNegativeFeedback controller = new CaseInquiryControllerNegativeFeedback(sc);
        // controller.selectedCaseTypeKeeper = caseTypeConfig;
        controller.save_n_close(); 
        controller.cancel();
        Test.stopTest();
    }
    
	public static testmethod void caseInquiryNegativeFeedbackTestAFIKeeper() {
        Test.startTest();
        String caseInquiryNegativeVF = '/apex/CaseInquiryNegativeFeedback';
        String parentPageName = 'parentPageName';
        String firstLoad = 'firstLoad';
        String sourceContact = 'contact';
        String sourceEmail = 'email';
        String caseTypeConfig = '<br />Claim Procedure<br />Property Product';
         
        RecordType RecTypeId = [SELECT Id
                                     FROM RecordType
                                    WHERE SobjectType='Case'
                                          and Name ='InquiryAFICase'
                                    LIMIT 1];
        
        Case caseObj = [SELECT RecordTypeId,Type,Id,Entity__c FROM Case where RecordTypeId =:RecTypeId.Id ORDER BY CreatedDate DESC LIMIT 1];
  
        String entity = 'AFI';
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest10';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bills';
        contact1.LastName = 'Gatesx';
        contact1.Email = 'billgatesx@email.com';
        contact1.MobilePhone = '0891667362';
        contact1.Policy_No__c = '100000016';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        Negative_Feedback__c nf1 = new Negative_Feedback__c();
        nf1.Entity__c = entity;
        nf1.Description__c = 'Desc';
        nf1.Case__c = caseObj.Id;
        nf1.Contact__c = contact1.Id;
        
        PageReference pageRef = new PageReference(caseInquiryNegativeVF);
        pageRef.getParameters().put('def_contact_id', contact1.Id);
        pageRef.getParameters().put('def_account_id', ac1.Id);
        pageRef.getParameters().put('RecordType', caseObj.RecordTypeId);
        pageRef.getParameters().put('cas5', caseObj.Type);
        pageRef.getParameters().put('retURL', '/' + caseObj.Id);
        pageRef.getParameters().put('parentPageName', parentPageName); 
        pageRef.getParameters().put('entity', entity);
        pageRef.getParameters().put('cas11', sourceContact);
        pageRef.getParameters().put('cas3', contact1.Id);
        pageRef.getParameters().put('nfid', nf1.Id);
        pageRef.getParameters().put('isnegative', 'yes');
        pageRef.getParameters().put('firstLoad', 'save');
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(caseObj);
        CaseInquiryControllerNegativeFeedback controller = new CaseInquiryControllerNegativeFeedback(sc);
        controller.selectedCaseTypeKeeper = caseTypeConfig;
        controller.save(); 
        controller.cancel();
        Test.stopTest();
    }
    
	public static testmethod void caseInquiryNegativeFeedbackTestAMFSSaveNClosedKepper() {
        Test.startTest();
        String caseInquiryNegativeVF = '/apex/CaseInquiryNegativeFeedback';
        String parentPageName = 'parentPageName';
        String firstLoad = 'firstLoad';
        String sourceContact = 'contact';
        String sourceEmail = 'email';
        String caseTypeConfig = '<br />Claim Procedure<br />Property Product';
         
        RecordType RecTypeId = [SELECT Id
                                     FROM RecordType
                                    WHERE SobjectType='Case'
                                          and Name ='InquiryAMFSCase'
                                    LIMIT 1];
        
        Case caseObj = [SELECT RecordTypeId,Type,Id,Entity__c FROM Case where RecordTypeId =:RecTypeId.Id ORDER BY CreatedDate DESC LIMIT 1];
  
        String entity = 'AMFS';
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest10';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bills';
        contact1.LastName = 'Gatesx';
        contact1.Email = 'billgatesx@email.com';
        contact1.MobilePhone = '0891667362';
        contact1.Policy_No__c = '100000016';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        Negative_Feedback__c nf1 = new Negative_Feedback__c();
        nf1.Entity__c = entity;
        nf1.Description__c = 'Desc';
        nf1.Case__c = caseObj.Id;
        nf1.Contact__c = contact1.Id;
        
        PageReference pageRef = new PageReference(caseInquiryNegativeVF);
        pageRef.getParameters().put('def_contact_id', contact1.Id);
        pageRef.getParameters().put('def_account_id', ac1.Id);
        pageRef.getParameters().put('RecordType', caseObj.RecordTypeId);
        pageRef.getParameters().put('cas5', caseObj.Type);
        pageRef.getParameters().put('retURL', '/' + caseObj.Id);
        pageRef.getParameters().put('parentPageName', parentPageName); 
        pageRef.getParameters().put('entity', entity);
        pageRef.getParameters().put('cas11', sourceContact);
        pageRef.getParameters().put('cas3', contact1.Id);
        pageRef.getParameters().put('nfid', nf1.Id);
        pageRef.getParameters().put('isnegative', 'yes');
        pageRef.getParameters().put('firstLoad', 'closed');
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(caseObj);
        CaseInquiryControllerNegativeFeedback controller = new CaseInquiryControllerNegativeFeedback(sc);
        controller.selectedCaseTypeKeeper = caseTypeConfig;
        controller.save_n_close(); 
        controller.cancel();
        Test.stopTest();
    }
}