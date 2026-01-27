@isTest(seeAllData = true)
public class Avantbox_Create_Email_Scoring3_Test {
    public static testmethod void AvantboxTest3() {
        Test.startTest();
        
        String caseid = '';
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        string afiRT = '';
        string amfsRT = '';
        string magiRT = '';
        
        /*
        List<Holiday> holidayList = new List<Holiday>();
        Holiday hol1 = new Holiday();
        hol1.Name = 'Libur-liburan';
        hol1.ActivityDate = system.today() + 1;
        holidayList.add(hol1);
        
        Holiday hol2 = new Holiday();
        hol2.Name = 'Libur-liburan 2';
        hol2.ActivityDate = system.today();
        holidayList.add(hol2);
        
        insert holidayList;
        */
        
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
        
        Email_Config__c ec2 = new Email_Config__c();
        ec2.Email_Address__c = 'helpline@axa-financial.co.id';
        ec2.Distribution_Type__c = 'Automatic';
        ec2.SLA__c = '2';
        ec2.Unit__c = 'Hour';
        ec2.Start_Working_Hour__c = 8;
        ec2.End_Working_Hour__c = 13;
        emailConfigList.add(ec2);
        
        insert emailConfigList;
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like '%Agent%AFI' limit 1]; 
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like '%Agent%AMFS' limit 1]; 
        
        List<User> usrList = new List<User>();
        User usr1 = new User(Alias = 'agent1', Email='agent01@axa.co.id', 
            EmailEncodingKey='UTF-8', LastName='agent01', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, Entity__c = 'AFI', 
            TimeZoneSidKey='Asia/Jakarta', UserName='agent01@axa.co.id', isActive = true);
        usrList.add(usr1);
        User usr2 = new User(Alias = 'agent2', Email='agent02@axa.co.id', 
            EmailEncodingKey='UTF-8', LastName='agent02', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, Entity__c = 'AMFS', 
            TimeZoneSidKey='Asia/Jakarta', UserName='agent02@axa.co.id', isActive = true);
        usrList.add(usr2);
        User usr3 = new User(Alias = 'agent3', Email='agent03@axa.co.id', 
            EmailEncodingKey='UTF-8', LastName='agent03', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, Entity__c = 'AFI', 
            TimeZoneSidKey='Asia/Jakarta', UserName='agent03@axa.co.id', isActive = true);
        usrList.add(usr3);
        User usr4 = new User(Alias = 'agent4', Email='agent04@axa.co.id', 
            EmailEncodingKey='UTF-8', LastName='agent04', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, Entity__c = 'AMFS', 
            TimeZoneSidKey='Asia/Jakarta', UserName='agent04@axa.co.id', isActive = true);
        usrList.add(usr4);
    
        insert usrList;
    
        List<Email_Assignment__c> eaList = new List<Email_Assignment__c>();
        Email_Assignment__c ea1 = new Email_Assignment__c();
        ea1.Inbox__c = ec1.Id;
        ea1.User__c = usr2.Id;
        ea1.Is_Active__c = true;
        eaList.add(ea1);
        
        Email_Assignment__c ea2 = new Email_Assignment__c();
        ea2.Inbox__c = ec1.Id;
        ea2.User__c = usr4.Id;
        ea2.Is_Active__c = true;
        eaList.add(ea2);
        
        Email_Assignment__c ea3 = new Email_Assignment__c();
        ea3.Inbox__c = ec2.Id;
        ea3.User__c = usr1.Id;
        ea3.Is_Active__c = true;
        eaList.add(ea3);
        
        Email_Assignment__c ea4 = new Email_Assignment__c();
        ea4.Inbox__c = ec2.Id;
        ea4.User__c = usr3.Id;
        ea4.Is_Active__c = true;
        eaList.add(ea4);
        
        insert eaList;
        
        List<RecordType> caseRecordTypeList = [SELECT Name, Id, DeveloperName, SobjectType FROM RecordType where SobjectType = 'Case' and name like 'Inquiry%'];
        for (RecordType rt: caseRecordTypeList) {
            if (rt.name.indexof('AFI')!=-1) {
                afiRT = rt.Id;
            }
            else if (rt.name.indexof('AMFS')!=-1) {
                amfsRT = rt.Id;
            }
            else if(rt.name.indexof('MAGI')!=-1) {
                magiRT = rt.Id;
            }
        }
        system.debug('>>> afiRT : '+afiRT);
        system.debug('>>> amfsRT : '+amfsRT);
        system.debug('>>> magiRT : '+magiRT);
        /*        
        Schema.DescribeSObjectResult caseSchema = Schema.SObjectType.Case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = caseSchema.getRecordTypeInfosByName(); 
        Id rtId2 = CaseRecordTypeInfo.get('AFIComplaintCase').getRecordTypeId();
        system.debug('Case Record Type: '+rtId2);
        
        Profile profil = [SELECT Id FROM Profile WHERE Name='Email Agent-AMFS']; 
        User agen = [select id, Entity__c from user where ProfileId = :profil.id AND Entity__c = 'AMFS' limit 1];
        User usr = [select id, Entity__c from user where Entity__c = 'AMFS' limit 1];
        */
        
        //Test.startTest();
        List<contact> contactList = new List<contact>();
        Contact con1 = new Contact();
        con1.RecordTypeId = rtId;
        con1.LastName = 'cust01';
        con1.Policy_No__c = 'P0000011';
        con1.PolicyApp__c = 'RLS';
        con1.Entity__c = 'AFI';
        con1.Email = 'test1@abc.org';
        con1.MobilePhone = '11111';
        contactList.add(con1);
        
        Contact con2 = new Contact();
        con2.RecordTypeId = rtId;
        con2.LastName = 'cust02';
        con2.Policy_No__c = 'P0000022';
        con2.PolicyApp__c = 'RLS';
        con2.Entity__c = 'AMFS';
        con2.Email = 'test2@abc.org';
        con2.MobilePhone = '22222';
        contactList.add(con2);

        Contact con3 = new Contact();
        con3.RecordTypeId = rtId;
        con3.LastName = 'cust03';
        con3.Policy_No__c = 'P0000033';
        con3.PolicyApp__c = 'PSEA';
        con3.Entity__c = 'MAGI';
        con3.Email = 'test3@abc.org';
        con3.MobilePhone = '33333';
        contactList.add(con3);

        Contact con4 = new Contact();
        con4.RecordTypeId = rtId;
        con4.LastName = 'cust04';
        con4.Policy_No__c = 'P0000044';
        con4.PolicyApp__c = 'BIS';
        con4.Entity__c = 'AFI';
        con4.Email = 'test4@abc.org';
        con4.MobilePhone = '44444';
        contactList.add(con4);

        Contact con5 = new Contact();
        con5.RecordTypeId = rtId;
        con5.LastName = 'cust05';
        con5.Policy_No__c = 'P0000055';
        con5.PolicyApp__c = 'DMTM';
        con5.Entity__c = 'AMFS';
        con5.Email = 'test5@abc.org';
        con5.MobilePhone = '55555';
        contactList.add(con5);

        Contact con6 = new Contact();
        con6.RecordTypeId = rtId;
        con6.LastName = 'cust06';
        con6.Policy_No__c = 'P0000066';
        con6.PolicyApp__c = 'CARE';
        con6.Entity__c = 'MAGI';
        con6.Email = 'test6@abc.org';
        con6.MobilePhone = '66666';
        contactList.add(con6);
        insert contactList;
        
        Case case3 = new Case();
        case3.ContactId = con3.Id;
        case3.RecordTypeId = magiRT;
        case3.Entity_Backup__c = 'MAGI';
        case3.Type = 'Inquiry';
        insert case3;
        
        List<EmailMessage> emailMsgList = new List<EmailMessage>();
        emailMsgList.add(new EmailMessage(FromAddress = 'test2@abc.org', Incoming = true, 
                                          ToAddress= 'customer.general@axa-mandiri.co.id', Subject = 'Test email 02', 
                                          Headers ='amfs.nasabah@q-2iy0pz7b84etizjdlw0x884i140m0lirudsyqsyqkc4t1x0a6r.0k-crveeak.cs57.apex.sandbox.salesforce.com,amfs_customer@2ccm1v8j0mv7d15y0cp80lkhc3g0f7hw3cqv4ujzpz1bkt14ve.9-zalzeae.ap1.apex.salesforce.com',
                                          TextBody = '23456 ', ParentId = case3.id));
        insert emailMsgList;
        
        Test.stopTest();
    }
}