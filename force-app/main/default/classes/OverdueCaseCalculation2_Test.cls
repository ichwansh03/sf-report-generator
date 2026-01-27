@isTest (seealldata=true)
public class OverdueCaseCalculation2_Test {

     public static testMethod void muTest(){
        
        Test.startTest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        string afiRT = '';
        string amfsRT = '';
        string magiRT = '';
        
        List<RecordType> caseRecordTypeList = [SELECT Name, Id, DeveloperName, SobjectType FROM RecordType where SobjectType = 'Case' and name like 'Inquiry%'];
        for(RecordType rt: caseRecordTypeList){
            if(rt.name.indexof('AFI')!=-1){
                afiRT = rt.Id;  
            }else if(rt.name.indexof('AMFS')!=-1){
                amfsRT = rt.Id; 
            }else if(rt.name.indexof('MAGI')!=-1){
                magiRT = rt.Id; 
            }
        }
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like '%Agent%AFI' limit 1];
        
        List<User> usrList = new List<User>();
        User usr1 = new User(Alias = 'agent1', Email='agent01@axa.co.id', 
                EmailEncodingKey='UTF-8', LastName='agent01', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, Entity__c = 'AFI', 
                TimeZoneSidKey='Asia/Jakarta', UserName='agent01@axa.co.id', isActive = true);
        usrList.add(usr1);
        User usr3 = new User(Alias = 'agent3', Email='agent03@axa.co.id', 
                EmailEncodingKey='UTF-8', LastName='agent03', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, Entity__c = 'AFI', 
                TimeZoneSidKey='Asia/Jakarta', UserName='agent03@axa.co.id', isActive = true);
        usrList.add(usr3);
        insert usrList;
        
        List<SLA_Setting__c> slaList = new List<SLA_Setting__c>();
        
        SLA_Setting__c sla2 = new SLA_Setting__c();
        sla2.Case_Type__c = 'Bukti Transfer';
        sla2.Entity__c = 'AFI';
        sla2.Type__c = 'Request';
        sla2.Is_Calendar__c = true;
        sla2.Service_SLA__c = 2;
        sla2.Unit__c = 'Hour';
        sla2.End_Working_Hour__c = 11;
        slaList.add(sla2);
        
        SLA_Setting__c sla3 = new SLA_Setting__c();
        sla3.Entity__c = 'AFI';
        sla3.Type__c = 'Complaint';
        sla3.Is_Calendar__c = false;
        sla3.Service_SLA__c = 2;
        sla3.Unit__c = 'Hour';
        sla3.End_Working_Hour__c = 13;
        sla3.Complaint_Type__c = 'Complex Case';
        slaList.add(sla3);
        
        SLA_Setting__c sla4 = new SLA_Setting__c();
        sla4.Entity__c = 'AFI';
        sla4.Type__c = 'Complaint';
        sla4.Is_Calendar__c = true;
        sla4.Service_SLA__c = 2;
        sla4.Unit__c = 'Hour';
        sla4.End_Working_Hour__c = 16;
        sla4.Complaint_Type__c = 'Complex Case';
        slaList.add(sla4);
        
        insert slaList;
        
        List<Contact> contactList = new List<Contact>();
        
        Contact con1 = new Contact();
        con1.FirstName = 'Hamfree';
        con1.LastName = 'Lantwo';
        contactList.add(con1);
        
        Contact con2 = new Contact();
        con2.FirstName = 'Hamfree';
        con2.LastName = 'Lantu';
        contactList.add(con2);
                
        insert contactList;
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'hamfry.lantoe@gmail.com';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 24;
        ec1.Entity__c = 'AFI';
        ec1.SLA__c = '1';
        ec1.Unit__c = 'Day';
        emailConfigList.add(ec1);
        
        Email_Config__c ec2 = new Email_Config__c();
        ec2.Email_Address__c = 'testo.axa@gmail.com';
        ec2.Distribution_Type__c = 'Automatic';
        ec2.Start_Working_Hour__c = 8;
        ec2.End_Working_Hour__c = 24;
        ec2.Entity__c = 'AFI';
        ec2.SLA__c = '1';
        ec2.Unit__c = 'Day';
        emailConfigList.add(ec2);
        
        Email_Config__c ec3 = new Email_Config__c();
        ec3.Email_Address__c = 'hamfry.4ever@gmail.com';
        ec3.Distribution_Type__c = 'Automatic';
        ec3.Start_Working_Hour__c = 8;
        ec3.End_Working_Hour__c = 14;
        ec3.Entity__c = 'AFI';
        ec3.SLA__c = '1';
        ec3.Unit__c = 'Day';
        emailConfigList.add(ec3);
        
        insert emailConfigList;
        
        
        List<Case> caseList3 = new List<Case>();
        Case cs3 = new Case();
        cs3.Entity_Backup__c = 'AFI';
        cs3.Origin = 'Phone';
        cs3.Status ='New';
        //cs3.ContactId = con2.Id;
        cs3.Subject = 'testing 123';
        cs3.Type = 'Complaint';
        cs3.Complaint_type__c = 'Complex Case';
        cs3.Nature_Config__c = 'Claim';
        cs3.Category_Config__c = 'Claim Delay';
        insert cs3;
         //caseList3.add(cs3);
        
        Case cs4 = new Case();
        cs4.Entity_Backup__c = 'AFI';
        cs4.Origin = 'Email';
        cs4.Status ='New';
        cs4.Subject = 'testing 123';
        cs4.Type = 'Inquiry';
        cs4.Priority = 'Medium';
        cs4.SuppliedEmail = 'testingabc@yahoo.com';
        cs4.Description = 'Testing only';
        cs4.E2CP__AdditionalTo__c = 'hamfry.lantoe@gmail.com;testo.axa@gmail.com;testingabc@yahoo.com';
        cs4.E2CP__AdditionalCC__c = 'hamfry.4ever@gmail.com';
        cs4.e2cEmailTo_New__c = 'hamfry.lantoe@gmail.com;testo.axa@gmail.com';
        cs4.Email_Inbox__c = 'hamfry.lantoe@gmail.com';
        cs4.First_Inbox__c = 'hamfry.lantoe@gmail.com';
        cs4.RecordTypeId = afiRT;
        cs4.Created_Out_Of_Office_Hour__c = false;
        insert cs4;
         //caseList3.add(cs4);
        Test.stopTest();
     }
    
     public static testMethod void emailConfig(){
        
        Test.startTest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        string afiRT = '';
        string amfsRT = '';
        string magiRT = '';
        
        List<RecordType> caseRecordTypeList = [SELECT Name, Id, DeveloperName, SobjectType FROM RecordType where SobjectType = 'Case' and name like 'Inquiry%'];
        for(RecordType rt: caseRecordTypeList){
            if(rt.name.indexof('AFI')!=-1){
                afiRT = rt.Id;  
            }else if(rt.name.indexof('AMFS')!=-1){
                amfsRT = rt.Id; 
            }else if(rt.name.indexof('MAGI')!=-1){
                magiRT = rt.Id; 
            }
        }
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like '%Agent%AFI' limit 1];
        
        List<User> usrList = new List<User>();
        User usr1 = new User(Alias = 'agent1', Email='agent01@axa.co.id', 
                EmailEncodingKey='UTF-8', LastName='agent01', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, Entity__c = 'AFI', 
                TimeZoneSidKey='Asia/Jakarta', UserName='agent01@axa.co.id', isActive = true);
        usrList.add(usr1);
        User usr3 = new User(Alias = 'agent3', Email='agent03@axa.co.id', 
                EmailEncodingKey='UTF-8', LastName='agent03', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, Entity__c = 'AFI', 
                TimeZoneSidKey='Asia/Jakarta', UserName='agent03@axa.co.id', isActive = true);
        usrList.add(usr3);
        insert usrList;
        
        List<SLA_Setting__c> slaList = new List<SLA_Setting__c>();
        
        SLA_Setting__c sla2 = new SLA_Setting__c();
        sla2.Case_Type__c = 'Bukti Transfer';
        sla2.Entity__c = 'AFI';
        sla2.Type__c = 'Request';
        sla2.Is_Calendar__c = true;
        sla2.Service_SLA__c = 2;
        sla2.Unit__c = 'Hour';
        sla2.End_Working_Hour__c = 11;
        slaList.add(sla2);
        
        SLA_Setting__c sla3 = new SLA_Setting__c();
        sla3.Entity__c = 'AFI';
        sla3.Type__c = 'Complaint';
        sla3.Is_Calendar__c = false;
        sla3.Service_SLA__c = 2;
        sla3.Unit__c = 'Hour';
        sla3.End_Working_Hour__c = 13;
        sla3.Complaint_Type__c = 'Complex Case';
        slaList.add(sla3);
        
        SLA_Setting__c sla4 = new SLA_Setting__c();
        sla4.Entity__c = 'AFI';
        sla4.Type__c = 'Complaint';
        sla4.Is_Calendar__c = true;
        sla4.Service_SLA__c = 2;
        sla4.Unit__c = 'Hour';
        sla4.End_Working_Hour__c = 16;
        sla4.Complaint_Type__c = 'Complex Case';
        slaList.add(sla4);
        
        insert slaList;
        
        List<Contact> contactList = new List<Contact>();
        
        Contact con1 = new Contact();
        con1.FirstName = 'Hamfree';
        con1.LastName = 'Lantwo';
        contactList.add(con1);
        
        Contact con2 = new Contact();
        con2.FirstName = 'Hamfree';
        con2.LastName = 'Lantu';
        contactList.add(con2);
                
        insert contactList;
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'hamfry.lantoe@gmail.com';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 24;
        ec1.Entity__c = 'AFI';
        ec1.SLA__c = '1';
        ec1.Unit__c = 'Day';
        emailConfigList.add(ec1);
        insert emailConfigList;
        
        
        List<Case> caseList3 = new List<Case>();
        Case cs3 = new Case();
        cs3.Entity_Backup__c = 'AFI';
        cs3.Origin = 'Phone';
        cs3.Status ='New';
        //cs3.ContactId = con2.Id;
        cs3.Subject = 'testing 123';
        cs3.Type = 'Complaint';
        cs3.Complaint_type__c = 'Complex Case';
        cs3.Nature_Config__c = 'Claim';
        cs3.Category_Config__c = 'Claim Delay';
        cs3.Created_Out_Of_Office_Hour__c = true;
        insert cs3;
         //caseList3.add(cs3);
        
        Case cs4 = new Case();
        cs4.Entity_Backup__c = 'AFI';
        cs4.Origin = 'Email';
        cs4.Status ='New';
        cs4.Subject = 'testing 123';
        cs4.Type = 'Inquiry';
        cs4.Priority = 'Medium';
        cs4.SuppliedEmail = 'testingabc@yahoo.com';
        cs4.Description = 'Testing only';
        cs4.E2CP__AdditionalTo__c = 'hamfry.lantoe@gmail.com;testo.axa@gmail.com;testingabc@yahoo.com';
        cs4.E2CP__AdditionalCC__c = 'hamfry.4ever@gmail.com';
        cs4.e2cEmailTo_New__c = 'hamfry.lantoe@gmail.com;testo.axa@gmail.com';
        cs4.Email_Inbox__c = 'hamfry.lantoe@gmail.com';
        cs4.First_Inbox__c = 'hamfry.lantoe@gmail.com';
        cs4.RecordTypeId = afiRT;
        cs4.Created_Out_Of_Office_Hour__c = false;
        insert cs4;
         //caseList3.add(cs4);
        Test.stopTest();
     }
    
    
     public static testMethod void emailConfigv2(){
        
        Test.startTest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
         Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
         string afiRT = '';
         string amfsRT = '';
         string magiRT = '';
         
         List<RecordType> caseRecordTypeList = [SELECT Name, Id, DeveloperName, SobjectType FROM RecordType where SobjectType = 'Case' and name like 'Inquiry%'];
         for(RecordType rt: caseRecordTypeList){
             if(rt.name.indexof('AFI')!=-1){
                 afiRT = rt.Id;  
             }else if(rt.name.indexof('AMFS')!=-1){
                 amfsRT = rt.Id; 
             }else if(rt.name.indexof('MAGI')!=-1){
                 magiRT = rt.Id; 
             }
         }
         
         Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like '%Agent%AFI' limit 1];
         
         List<User> usrList = new List<User>();
         User usr1 = new User(Alias = 'agent1', Email='agent01@axa.co.id', 
                              EmailEncodingKey='UTF-8', LastName='agent01', LanguageLocaleKey='en_US', 
                              LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, Entity__c = 'AFI', 
                              TimeZoneSidKey='Asia/Jakarta', UserName='agent01@axa.co.id', isActive = true);
         usrList.add(usr1);
         User usr3 = new User(Alias = 'agent3', Email='agent03@axa.co.id', 
                              EmailEncodingKey='UTF-8', LastName='agent03', LanguageLocaleKey='en_US', 
                              LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, Entity__c = 'AFI', 
                              TimeZoneSidKey='Asia/Jakarta', UserName='agent03@axa.co.id', isActive = true);
         usrList.add(usr3);
         insert usrList;
         
         List<SLA_Setting__c> slaList = new List<SLA_Setting__c>();
         
         SLA_Setting__c sla2 = new SLA_Setting__c();
         sla2.Case_Type__c = 'Bukti Transfer';
         sla2.Entity__c = 'AFI';
         sla2.Type__c = 'Request';
         sla2.Is_Calendar__c = true;
         sla2.Service_SLA__c = 2;
         sla2.Unit__c = 'Hour';
         sla2.End_Working_Hour__c = 11;
         slaList.add(sla2);
         
         SLA_Setting__c sla3 = new SLA_Setting__c();
         sla3.Entity__c = 'AFI';
         sla3.Type__c = 'Complaint';
         sla3.Is_Calendar__c = false;
         sla3.Service_SLA__c = 2;
         sla3.Unit__c = 'Hour';
         sla3.End_Working_Hour__c = 13;
         sla3.Complaint_Type__c = 'Complex Case';
         slaList.add(sla3);
         
         SLA_Setting__c sla4 = new SLA_Setting__c();
         sla4.Entity__c = 'AFI';
         sla4.Type__c = 'Complaint';
         sla4.Is_Calendar__c = true;
         sla4.Service_SLA__c = 2;
         sla4.Unit__c = 'Hour';
         sla4.End_Working_Hour__c = 16;
         sla4.Complaint_Type__c = 'Complex Case';
         slaList.add(sla4);
         
         insert slaList;
         
         List<Contact> contactList = new List<Contact>();
         
         Contact con1 = new Contact();
         con1.FirstName = 'Hamfree';
         con1.LastName = 'Lantwo';
         contactList.add(con1);
         
         Contact con2 = new Contact();
         con2.FirstName = 'Hamfree';
         con2.LastName = 'Lantu';
         contactList.add(con2);
         
         insert contactList;
         
         List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
         Email_Config__c ec1 = new Email_Config__c();
         ec1.Email_Address__c = 'hamfry.lantoe@gmail.com';
         ec1.Distribution_Type__c = 'Automatic';
         ec1.Start_Working_Hour__c = 8;
         ec1.End_Working_Hour__c = 24;
         ec1.Entity__c = 'AFI';
         ec1.SLA__c = '1';
         ec1.Unit__c = 'Day';
         emailConfigList.add(ec1);
         insert emailConfigList;
         
         
         List<Case> caseList3 = new List<Case>();
         Case cs3 = new Case();
         cs3.Entity_Backup__c = 'AFI';
         cs3.Origin = 'Phone';
         cs3.Status ='New';
         //cs3.ContactId = con2.Id;
         cs3.Subject = 'testing 123';
         cs3.Type = 'Complaint';
         cs3.Complaint_type__c = 'Complex Case';
         cs3.Nature_Config__c = 'Claim';
         cs3.Category_Config__c = 'Claim Delay';
         cs3.Created_Out_Of_Office_Hour__c = true;
         insert cs3;
         //caseList3.add(cs3);
         
         Case cs4 = new Case();
         cs4.Entity_Backup__c = 'AFI';
         cs4.Origin = 'Email';
         cs4.Status ='New';
         cs4.Subject = 'testing 123';
         cs4.Type = 'Inquiry';
         cs4.e2cEmailToAddress__c = 'hamfry.lantoe@gmail.com';
         cs4.Priority = 'Medium';
         cs4.SuppliedEmail = 'testingabc@yahoo.com';
         cs4.Description = 'Testing only';
         cs4.E2CP__AdditionalTo__c = 'hamfry.lantoe@gmail.com;testo.axa@gmail.com;testingabc@yahoo.com';
         cs4.E2CP__AdditionalCC__c = 'hamfry.4ever@gmail.com';
         cs4.e2cEmailTo_New__c = 'hamfry.lantoe@gmail.com;testo.axa@gmail.com';
         cs4.Email_Inbox__c = 'hamfry.lantoe@gmail.com';
         cs4.First_Inbox__c = 'hamfry.lantoe@gmail.com';
         cs4.RecordTypeId = afiRT;
         cs4.Created_Out_Of_Office_Hour__c = false;
         insert cs4;
         //caseList3.add(cs4);
         Test.stopTest();
     }
    
    
    public static testMethod void muTest2(){
        
        Test.startTest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        string afiRT = '';
        string amfsRT = '';
        string magiRT = '';
        
        List<RecordType> caseRecordTypeList = [SELECT Name, Id, DeveloperName, SobjectType FROM RecordType where SobjectType = 'Case' and name like 'Inquiry%'];
        for(RecordType rt: caseRecordTypeList){
            if(rt.name.indexof('AFI')!=-1){
                afiRT = rt.Id;  
            }else if(rt.name.indexof('AMFS')!=-1){
                amfsRT = rt.Id; 
            }else if(rt.name.indexof('MAGI')!=-1){
                magiRT = rt.Id; 
            }
        }
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like '%Agent%AFI' limit 1];
        
        List<User> usrList = new List<User>();
        User usr1 = new User(Alias = 'agent1', Email='agent01@axa.co.id', 
                EmailEncodingKey='UTF-8', LastName='agent01', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, Entity__c = 'AFI', 
                TimeZoneSidKey='Asia/Jakarta', UserName='agent01@axa.co.id', isActive = true);
        usrList.add(usr1);
        User usr3 = new User(Alias = 'agent3', Email='agent03@axa.co.id', 
                EmailEncodingKey='UTF-8', LastName='agent03', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, Entity__c = 'AFI', 
                TimeZoneSidKey='Asia/Jakarta', UserName='agent03@axa.co.id', isActive = true);
        usrList.add(usr3);
        insert usrList;
        
        List<SLA_Setting__c> slaList = new List<SLA_Setting__c>();
        
        SLA_Setting__c sla2 = new SLA_Setting__c();
        sla2.Case_Type__c = 'Bukti Transfer';
        sla2.Entity__c = 'AFI';
        sla2.Type__c = 'Request';
        sla2.Is_Calendar__c = true;
        sla2.Service_SLA__c = 2;
        sla2.Unit__c = 'Hour';
        sla2.End_Working_Hour__c = 11;
        slaList.add(sla2);
        
        SLA_Setting__c sla3 = new SLA_Setting__c();
        sla3.Entity__c = 'AFI';
        sla3.Type__c = 'Complaint';
        sla3.Is_Calendar__c = false;
        sla3.Service_SLA__c = 2;
        sla3.Unit__c = 'Hour';
        sla3.End_Working_Hour__c = 13;
        sla3.Complaint_Type__c = 'Complex Case';
        slaList.add(sla3);
        
        SLA_Setting__c sla4 = new SLA_Setting__c();
        sla4.Entity__c = 'AFI';
        sla4.Type__c = 'Complaint';
        sla4.Is_Calendar__c = true;
        sla4.Service_SLA__c = 2;
        sla4.Unit__c = 'Hour';
        sla4.End_Working_Hour__c = 16;
        sla4.Complaint_Type__c = 'Complex Case';
        slaList.add(sla4);
        
        insert slaList;
        
        List<Contact> contactList = new List<Contact>();
        
        Contact con1 = new Contact();
        con1.FirstName = 'Hamfree';
        con1.LastName = 'Lantwo';
        contactList.add(con1);
        
        Contact con2 = new Contact();
        con2.FirstName = 'Hamfree';
        con2.LastName = 'Lantu';
        contactList.add(con2);
                
        insert contactList;
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'hamfry.lantoe@gmail.com';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 24;
        ec1.Entity__c = 'AFI';
        ec1.SLA__c = '1';
        ec1.Unit__c = 'Day';
        emailConfigList.add(ec1);
        
        insert emailConfigList;
        
        Case cs5 = new Case();
        cs5.Entity_Backup__c = 'AFI';
        cs5.Origin = 'Email';
        cs5.Status ='New';
        cs5.Subject = 'testing 123';
        cs5.Type = 'Inquiry';
        cs5.Priority = 'Medium';
        cs5.SuppliedEmail = 'testingabc@yahoo.com';
        cs5.Description = 'Testing only';
        cs5.E2CP__AdditionalTo__c = 'hamfry.lantoe@gmail.com;testo.axa@gmail.com;testingabc@yahoo.com';
        cs5.E2CP__AdditionalCC__c = 'hamfry.4ever@gmail.com';
        cs5.e2cEmailTo_New__c = 'hamfry.lantoe@gmail.com;testo.axa@gmail.com';
        cs5.Email_Inbox__c = 'hamfry.lantoe@gmail.com';
        cs5.First_Inbox__c = 'hamfry.lantoe@gmail.com';
        cs5.RecordTypeId = afiRT;
        cs5.Created_Out_Of_Office_Hour__c = false;
         insert cs5;
        //caseList3.add(cs5);
        
        Case cs6 = new Case();
        cs6.Entity_Backup__c = 'AFI';
        cs6.Origin = 'Email';
        cs6.Status ='New';
        cs6.Subject = 'testing 123';
        cs6.Type = 'Inquiry';
        cs6.Priority = 'Medium';
        cs6.SuppliedEmail = 'testingabc@yahoo.com';
        cs6.Description = 'Testing only';
        cs6.E2CP__AdditionalTo__c = 'hamfry.lantoe@gmail.com;testo.axa@gmail.com;testingabc@yahoo.com';
        cs6.E2CP__AdditionalCC__c = 'hamfry.4ever@gmail.com;hammvai@yahoo.com';
        cs6.e2cEmailTo_New__c = 'hamfry.lantoe@gmail.com;testo.axa@gmail.com';
        cs6.Email_Inbox__c = 'hamfry.lantoe@gmail.com';
        cs6.First_Inbox__c = 'hamfry.lantoe@gmail.com';
        cs6.RecordTypeId = afiRT;
        cs6.Created_Out_Of_Office_Hour__c = false;
        insert cs6;
         //caseList3.add(cs6);
        
        //insert caseList3;
        
        List<Incoming_Email_Checker__c> incomingEmailList = new List<Incoming_Email_Checker__c>();
        Incoming_Email_Checker__c iec = new Incoming_Email_Checker__c();
        iec.Case_Id__c = cs6.Id;
        iec.Case_Email_Inbox__c = 'hamfry.lantoe@gmail.com';
        iec.Case_Owner_ID__c = usr3.Id;
        iec.Case_Subject__c = 'testing 123';
        iec.Case_ToAddress__c = 'hamfry.lantoe@gmail.com;testo.axa@gmail.com';
        iec.Email_Config_ID__c = ec1.Id;
        iec.Email_Config_Last_Order__c = 2;
        incomingEmailList.add(iec);
        
        insert incomingEmailList;       
        Test.stopTest();
     }
    
    /* public static testMethod void muTest3(){
        
        Test.startTest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        string afiRT = '';
        string amfsRT = '';
        string magiRT = '';
        
        List<RecordType> caseRecordTypeList = [SELECT Name, Id, DeveloperName, SobjectType FROM RecordType where SobjectType = 'Case' and name like 'Inquiry%'];
        for(RecordType rt: caseRecordTypeList){
            if(rt.name.indexof('AFI')!=-1){
                afiRT = rt.Id;  
            }else if(rt.name.indexof('AMFS')!=-1){
                amfsRT = rt.Id; 
            }else if(rt.name.indexof('MAGI')!=-1){
                magiRT = rt.Id; 
            }
        }
        
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like '%Agent%AMFS' limit 1]; 
        
        List<User> usrList = new List<User>();
        User usr2 = new User(Alias = 'agent2', Email='agent02@axa.co.id', 
                EmailEncodingKey='UTF-8', LastName='agent02', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, Entity__c = 'AMFS', 
                TimeZoneSidKey='Asia/Jakarta', UserName='agent02@axa.co.id', isActive = true);
        insert usr2;
        //usrList.add(usr2);
        User usr4 = new User(Alias = 'agent4', Email='agent04@axa.co.id', 
                EmailEncodingKey='UTF-8', LastName='agent04', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, Entity__c = 'AMFS', 
                TimeZoneSidKey='Asia/Jakarta', UserName='agent04@axa.co.id', isActive = true);
        insert usr4;
        //usrList.add(usr4);
        //insert usrList;
        
        List<SLA_Setting__c> slaList = new List<SLA_Setting__c>();
        SLA_Setting__c sla1 = new SLA_Setting__c();
        sla1.Case_Type__c = 'Request_Other';
        sla1.Entity__c = 'AMFS';
        sla1.Type__c = 'Request';
        sla1.Is_Calendar__c = false;
        sla1.Service_SLA__c = 1;
        sla1.Unit__c = 'Day';
        slaList.add(sla1);
        
        insert slaList;
        
        
        // create master holiday 1 holiday afi
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Helpline';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';   
        
        mh.Start_Date_Time__c = System.now().addDays(-1);
        mh.End_Date_Time__c = System.now().addDays(3);
        mh.Active_Date__c = System.today().addDays(4);
         
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        List<Contact> contactList = new List<Contact>();
        
        Contact con1 = new Contact();
        con1.FirstName = 'Hamfree';
        con1.LastName = 'Lantwo';
        contactList.add(con1);
        
        Contact con2 = new Contact();
        con2.FirstName = 'Hamfree';
        con2.LastName = 'Lantu';
        contactList.add(con2);
                
        insert contactList;
        
        List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'hamfry.lantoe@gmail.com';
        ec1.Distribution_Type__c = 'Automatic';
        ec1.Start_Working_Hour__c = 8;
        ec1.End_Working_Hour__c = 24;
        ec1.Entity__c = 'AMFS';
        ec1.SLA__c = '1';
        ec1.Unit__c = 'Day';
        emailConfigList.add(ec1);
        insert emailConfigList;
        
        List<Case> caseList3 = new List<Case>();
        Case cs3 = new Case();
        cs3.Entity_Backup__c = 'AMFS';
        cs3.Origin = 'Phone';
        cs3.Status ='New';
        cs3.ContactId = con2.Id;
        cs3.Subject = 'testing 123';
        cs3.Type = 'Complaint';
        cs3.Complaint_type__c = 'Complex Case';
        cs3.Nature_Config__c = 'Claim';
        cs3.Category_Config__c = 'Claim Delay';
        insert cs3;
         //caseList3.add(cs3);
        
        Case cs4 = new Case();
        cs4.Entity_Backup__c = 'AMFS';
        cs4.Origin = 'Email';
        cs4.Status ='New';
        cs4.Subject = 'testing 123';
        cs4.Type = 'Inquiry';
        cs4.Priority = 'Medium';
        cs4.SuppliedEmail = 'testingabc@yahoo.com';
        cs4.Description = 'Testing only';
        cs4.E2CP__AdditionalTo__c = 'hamfry.lantoe@gmail.com;testo.axa@gmail.com;testingabc@yahoo.com';
        cs4.E2CP__AdditionalCC__c = 'hamfry.4ever@gmail.com';
        cs4.e2cEmailTo_New__c = 'hamfry.lantoe@gmail.com;testo.axa@gmail.com';
        cs4.Email_Inbox__c = 'hamfry.lantoe@gmail.com';
        cs4.First_Inbox__c = 'hamfry.lantoe@gmail.com';
        cs4.RecordTypeId = afiRT;
        cs4.Created_Out_Of_Office_Hour__c = false;
        insert cs4;
    
        
        
        Test.stopTest();
     } */
}