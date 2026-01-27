@isTest
public with sharing class GenerateWordDocumentTest {
	public static testMethod void myTest(){
		Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        Schema.DescribeSObjectResult caseSchema = Schema.SObjectType.Case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = caseSchema.getRecordTypeInfosByName(); 
        Id rtId2 = CaseRecordTypeInfo.get('AFIComplaintCase').getRecordTypeId();
        
        Schema.DescribeSObjectResult caseSchema2 = Schema.SObjectType.Case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo2 = caseSchema2.getRecordTypeInfosByName(); 
        Id rtId3 = CaseRecordTypeInfo2.get('MAGIComplaintCase').getRecordTypeId();
        
        List<Contact> lst_contact = new List<Contact>();
		Contact conAFI = new Contact();
        conAFI.RecordTypeId = rtId;
        conAFI.LastName = 'Lantu';
        conAFI.FirstName = 'Hamfry';
        conAFI.Policy_No__c = '30012015';
        conAFI.PolicyApp__c = 'RLS';
        conAFI.Insured_Name__c = 'Frys';
        conAFI.Entity__c = 'AFI';
        conAFI.Email = 'hamfry.lantu@saasten.com';
        conAFI.MobilePhone = '081213141516';
        lst_contact.add(conAFI);
        
        Contact conMAGI = new Contact();
        conMAGI.RecordTypeId = rtId;
        conMAGI.LastName = 'Lantoe';
        conMAGI.FirstName = 'Hamfry';
        conMAGI.Policy_No__c = '30013016';
        conMAGI.PolicyApp__c = 'RLS';
        conMAGI.Insured_Name__c = 'Frys';
        conMAGI.Entity__c = 'MAGI';
        conMAGI.Email = 'hamfry.lantoe@gmail.com';
        conMAGI.MobilePhone = '081314151617';
        lst_contact.add(conMAGI);
        
        insert lst_contact;
        
		Case cs = new Case();
        cs.ContactId = conAFI.Id;
        cs.RecordTypeId = rtId2;
        cs.Type = 'Complaint';
        cs.Complaint_Type__c = 'Simple';
        cs.Nature__c = 'Misrepresentation';
        cs.Category__c = 'Misrepresentation - Misrepresentation';
        insert cs;
		
		Case csUpdate = new Case();
		csUpdate.id = cs.id;
		csUpdate.BOD_Type__c = 'Level 2';
		update csUpdate;
		
		Case csMagi = new Case();
        csMagi.ContactId = conMAGI.Id;
        csMagi.RecordTypeId = rtId3;
        csMagi.Type = 'Complaint';
        csMagi.Complaint_Type__c = 'Simple';
        csMagi.Nature__c = 'Misrepresentation';
        csMagi.Category__c = 'Misrepresentation - Misrepresentation';
        insert csMagi;
        
        Case csUpdate2 = new Case();
		csUpdate2.id = csMagi.id;
		csUpdate2.BOD_Type__c = 'Level 1';
		update csUpdate2;
		
		List<String> idList = new List<String>{cs.Id, csMagi.Id};
		
		GenerateWordDocument.doPost(idList);
		/*
		Case csMagi = new Case();
        csMagi.ContactId = conMAGI.Id;
        csMagi.RecordTypeId = rtId3;
        csMagi.Type = 'Complaint';
        csMagi.Complaint_Type__c = 'Simple';
        csMagi.Nature__c = 'Misrepresentation';
        csMagi.Category__c = 'Misrepresentation - Misrepresentation';
        insert csMagi;
        
        Case csUpdate2 = new Case();
		csUpdate2.id = csMagi.id;
		csUpdate2.BOD_Type__c = 'Level 1';
		update csUpdate2;
		
		List<String> idList2 = new List<String>{csMagi.Id, csUpdate2.Id};
		
		GenerateWordDocument.doPost(idList2);
		*/
	}
}