@isTest(seeAllData=true) 
public with sharing class GetCHSCurrentAssignee_Test {
    static testMethod void myUnitTest() {
        /*
        String caseid = '';
    
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        List<Contact> lst_contact = new List<Contact>();
        Contact con = new Contact();
        con.RecordTypeId = rtId;
        //con.AccountId = acc.id;
        con.LastName = 'Lantu';
        con.FirstName = 'Hamfry';
        con.Policy_No__c = '30012015';
        con.PolicyApp__c = 'RLS';
        con.Insured_Name__c = 'Frys';
        con.Entity__c = 'AFI';
        con.Email = 'hamfry.lantu@saasten.com';
        con.MobilePhone = '081213141516';
        lst_contact.add(con);
        
        Contact con2 = new Contact();
        con2.RecordTypeId = rtId;
        //con.AccountId = acc.id;
        con2.LastName = 'Abadi';
        con2.FirstName = 'Hamfry';
        con2.Policy_No__c = '30012016'; 
        con2.PolicyApp__c = 'Clipper';
        con2.Insured_Name__c = 'Frys2';
        con2.Entity__c = 'AMFS';
        con2.Email = 'hamfry.lantu@gmail.com';
        con2.MobilePhone = '081314151617'; 
        lst_contact.add(con2);
        
        PIC_Department__c pic = new PIC_Department__c();
        pic.Department__c = 'CLAIM';
        pic.Email__c = 'tester123@nyahoo.com';
        insert pic;
        /*
        Contact con3 = new Contact();
        con3.RecordTypeId = rtId;
        con3.LastName = 'Lantoe';
        con3.FirstName = 'Hamfree';
        con3.Policy_No__c = '20150430';
        con3.PolicyApp__c = 'PSEA';
        con3.Insured_Name__c = 'Frys3';
        con3.Entity__c = 'MAGI';
        con3.Email = 'hamfry.lantoe@yahoo.com';
        con3.MobilePhone = '081415161718';
        lst_contact.add(con3);
        *
        insert lst_contact;
        
        Profile profilAFI = [SELECT Id FROM Profile WHERE Name='CMU-AFI' limit 1];
        UserRole roleAFI  = [SELECT Id FROM UserRole WHERE Name='CMU AFI' limit 1];
        User usr1  = [select id, Entity__c from user where ProfileId = :profilAFI.id AND userRoleId = :roleAFI.id  AND isActive = true limit 1];
        
        Profile profilAFI2 = [SELECT Id FROM Profile WHERE Name='Inbound Agent-AFI' limit 1];
        UserRole roleAFI2  = [SELECT Id FROM UserRole WHERE Name='Inbound Agent AFI' limit 1];
        User usr2 = [select id, Entity__c from user where ProfileId = :profilAFI2.id AND userRoleId = :roleAFI2.id AND IsActive = true AND isActive = true limit 1];
        
        Profile profilAMFS = [SELECT Id FROM Profile WHERE Name like 'CMU%AMFS' limit 1];
        UserRole roleAMFS  = [SELECT Id FROM UserRole WHERE Name like 'CMU%AMFS' limit 1];
        User usr3 = [select id, Entity__c from user where ProfileId = :profilAMFS.id AND userRoleId = :roleAMFS.id AND IsActive = true limit 1];
        //User usr3 = new User(Alias = 'frys1', Email='user_amfs@test.com', EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
        //           LocaleSidKey='en_US', ProfileId = profilAMFS.Id, UserRoleid = roleAMFS.Id, TimeZoneSidKey='America/Los_Angeles', UserName='user_cmu@test.com', Entity__c = 'AMFS', IsActive = true);
                    
        Profile profilAMFS2 = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AMFS' limit 1];
        UserRole roleAMFS2 = [SELECT Id FROM UserRole WHERE Name like 'Inbound Agent%AMFS' limit 1];
        User usr4 = [select id, Entity__c from user where ProfileId = :profilAMFS2.id AND userRoleId = :roleAMFS2.id AND IsActive = true limit 1];
        //User usr4 = new User(Alias = 'frys2', Email='user_amfs@yahoo.com', EmailEncodingKey='UTF-8', LastName='Testing2', LanguageLocaleKey='en_US', 
         //           LocaleSidKey='en_US', ProfileId = profilAMFS2.Id, UserRoleid = roleAMFS2.Id, TimeZoneSidKey='America/Los_Angeles', UserName='user_amfs@test.com', Entity__c = 'AMFS', IsActive = true);
                    
        /*
        Profile profilMAGI = [SELECT Id FROM Profile WHERE Name='CMU-MAGI'];
        UserRole roleMAGI = [SELECT Id FROM UserRole WHERE Name='PIC CMU MAGI'];
        User usr5 = [select id, Entity__c from user where ProfileId = :profilMAGI.id AND userRoleId = :roleMAGI.id limit 1];
        
        Profile profilMAGI2 = [SELECT Id FROM Profile WHERE Name='Inbound Agent-MAGI'];
        UserRole roleMAGI2 = [SELECT Id FROM UserRole WHERE Name='Inbound Agent MAGI'];
        User usr6 = [select id, Entity__c from user where ProfileId = :profilMAGI2.id AND userRoleId = :roleMAGI2.id limit 1];
        *
        Schema.DescribeSObjectResult caseSchema = Schema.SObjectType.Case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = caseSchema.getRecordTypeInfosByName(); 
        Id rtId2 = CaseRecordTypeInfo.get('AFIComplaintCase').getRecordTypeId();
        
        Schema.DescribeSObjectResult caseSchema2 = Schema.SObjectType.Case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo2 = caseSchema2.getRecordTypeInfosByName(); 
        Id rtId3 = CaseRecordTypeInfo2.get('AMFSComplaintCase').getRecordTypeId();
        
        Schema.DescribeSObjectResult caseSchema3 = Schema.SObjectType.Case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo3 = caseSchema3.getRecordTypeInfosByName(); 
        Id rtId4 = CaseRecordTypeInfo3.get('MAGIComplaintCase').getRecordTypeId();
                
        System.runAs(usr2) {
            Case cs = new Case();
            cs.ContactId = con.Id;
            cs.RecordTypeId = rtId2;
            cs.Type = 'Complaint';
            cs.Complaint_Type__c = 'Simple';
            cs.Nature__c = 'Misrepresentation';
            cs.Category__c = 'Misrepresentation - Misrepresentation';
            insert cs;
            caseid = cs.id;
            system.debug('caseid: ' +caseid);
        }
        System.runAs(usr1) {
            Case cs2 = new Case();
            cs2.id = caseid;
            cs2.CHS_Status__c = 'Incomplete Information';
            cs2.Status = 'Escalated';
            cs2.Financial_Lost__c = 10000;
            update cs2;
        }
        System.runAs(usr1) {
            Case cs3 = new Case();
            cs3.id = caseid;
            cs3.CHS_Status__c = 'In Progress Back CMU';
            cs3.Status = 'Escalated';
            cs3.Financial_Lost__c = 10000;
            update cs3;
        }
        System.runAs(usr1) {
            Case cs3 = new Case();
            cs3.id = caseid;
            cs3.CHS_Status__c = 'In Progress Back Office';
            cs3.Status = 'Escalated';
            cs3.Financial_Lost__c = 10000;
            update cs3;
        }
        System.runAs(usr1) {
            Case cs3 = new Case();
            cs3.id = caseid;
            cs3.CHS_Status__c = 'Assigned to Back Office';
            cs3.Status = 'Escalated';
            cs3.Financial_Lost__c = 10000;
            update cs3;
        }
        System.runAs(usr1) {
            Case cs3 = new Case();
            cs3.id = caseid;
            cs3.CHS_Status__c = 'Escalated';
            cs3.Status = 'Escalated';
            cs3.Financial_Lost__c = 10000;
            update cs3;
        }
        
        System.runAs(usr4) {
            Case cs4 = new Case();
            cs4.ContactId = con2.Id;
            cs4.RecordTypeId = rtId3;
            cs4.Type = 'Complaint';
            cs4.Complaint_Type__c = 'Simple';
            cs4.Nature__c = 'Misrepresentation';
            cs4.Category__c = 'Misrepresentation - Misrepresentation';
            cs4.PIC_Department__c = pic.id;
            insert cs4;
            caseid = cs4.id;
        }
        System.runAs(usr3) {
            Case cs5 = new Case();
            cs5.id = caseid;
            cs5.CHS_Status__c = 'Assigned to Back Office';
            cs5.Status = 'Escalated';
            update cs5;
        }
        System.runAs(usr3) {
            Case cs6 = new Case();
            cs6.id = caseid;
            cs6.CHS_Status__c = 'In Progress Back CMU';
            cs6.Status = 'Escalated';
            update cs6;
        }
        /*
        System.runAs(usr6) {
            Case cs7 = new Case();
            cs7.ContactId = con3.Id;
            cs7.RecordTypeId = rtId4;
            cs7.Type = 'Complaint';
            cs7.Complaint_Type__c = 'Simple';
            cs7.Nature__c = 'Misrepresentation';
            cs7.Category__c = 'Misrepresentation - Misrepresentation';
            insert cs7;
            caseid = cs7.id;
            system.debug('caseid: ' +caseid);
        }
        System.runAs(usr5) {
            Case cs8 = new Case();
            cs8.id = caseid;
            cs8.CHS_Status__c = 'Incomplete Information';
            cs8.Status = 'Escalated';
            update cs8;
        }
        */
    }
}