@isTest
public class OverdueCaseCalculation_Test {
    @testSetup
    public static void setup() {
        List<SLA_Setting__c> slaList = new List<SLA_Setting__c>();
     	SLA_Setting__c sla1 = new SLA_Setting__c();
     	sla1.Case_Type__c = 'Request_Other';
     	sla1.Entity__c = 'AMFS';
     	sla1.Type__c = 'Request';
     	sla1.Is_Calendar__c = false;
     	sla1.Service_SLA__c = 1;
     	sla1.Unit__c = 'Day';
     	slaList.add(sla1);
     	
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
        
        
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.Name = 'Tes Email SMS Template 1'; 
        est.Entity__c = 'AFI';
        est.Subject__c = 'Tes Subject Email SMS Template 1';
        est.Email_Header__c = 'Tes Header Email SMS Template 1';
        est.Email_Body__c = '<br/><br/><br/><table width="100%"><tbody><tr style="height: 117.449px;"><td style="width: 30%; height: 117.449px;" colspan="3"><font face = "calibri" font color="black" font size=2px>Kepada Bapak/Ibu [CONTACT_NAME] Yang Terhormat, <br/><br/>Terima kasih atas kepercayaan Anda kepada AXA Financial Indonesia sebagai mitra perlindungan jiwa bagi Anda dan keluarga. Pertanyaan dan permasalahan yang Anda sampaikan melalui email akan segera kami pelajari.<br/><br/>Sehubungan dengan <b> [DESCRIPTION_ID], </b> maka pada tanggal [START_DATE_ID] hingga [END_DATE_ID]  layanan tidak beroperasi.<br/>Kami akan beroperasi kembali dan merespon email Bapak/Ibu, pada tanggal [ACTIVE_DATE_ID] atau selambat-lambatnya pada hari kerja berikutnya.<br/><br/>Hormat kami,<br><br><b> PT AXA Financial Indonesia</b> <br><br>Call Center : <b>1500945</b> (kemudian tekan 1 untuk Agent dan tekan 2 untuk SOE   ) [START_DATE_EN]  [END_DATE_EN]  <br/>Email : <a href="mailto:helpline@axa-financial.co.id"><b>helpline@axa-financial.co.id</a></b><br><br>Jam Operasional [ACTIVE_DATE_EN]  Customer Care : Senin – Jumat pukul 08.00 – 17.00 WIB (tidak beroperasi di Sabtu Minggu dan Hari Libur Nasional)<br><br><br><img src= "https://axaid-ccc--c.ap11.content.force.com/servlet/servlet.ImageServer?id=0152s000000MPAt&oid=00D90000000zAlz&lastMod=1612940455000" width="600"/><br><br><b><br>*Email ini dikirim secara otomatis oleh Sistem, mohon agar tidak me-reply/membalas email ini.</b>';
        est.Email_Footer__c = 'Tes Footer Email SMS Template 1';
        est.Method__c = 'Email';
        insert est;
        
        Master_Holiday__c mh = new Master_Holiday__c();
        
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AFI';
        mh.Service_Type__c = 'Helpline';
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1'; 
        mh.Email_SMS_Template__c = est.id;  
        mh.Start_Date_Time__c = System.now().addDays(-1);
        mh.End_Date_Time__c = System.now().addDays(3);
        mh.Active_Date__c = System.today().addDays(4);
        
        mh.Email_Header__c = est.Email_Header__c;
        mh.Email_Body__c = est.Email_Body__c;
        mh.Email_Footer__c = est.Email_Footer__c;
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
    }
    
    
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
		
     	/* List<SLA_Setting__c> slaList = new List<SLA_Setting__c>();
     	SLA_Setting__c sla1 = new SLA_Setting__c();
     	sla1.Case_Type__c = 'Request_Other';
     	sla1.Entity__c = 'AMFS';
     	sla1.Type__c = 'Request';
     	sla1.Is_Calendar__c = false;
     	sla1.Service_SLA__c = 1;
     	sla1.Unit__c = 'Day';
     	slaList.add(sla1);
     	
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
     	
     	insert slaList; */
     	
     	/* List<Contact> contactList = new List<Contact>();
     	
     	Contact con1 = new Contact();
		con1.FirstName = 'Hamfree';
		con1.LastName = 'Lantwo';
		contactList.add(con1);
		
		Contact con2 = new Contact();
		con2.FirstName = 'Hamfree';
		con2.LastName = 'Lantu';
		contactList.add(con2);
				
		insert contactList; */
		
		/* List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
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
		
		insert emailConfigList; */
         
         Contact con1 = [select id from contact limit 1];
         Contact con2 = [select id from contact limit 1];
		
		system.runAs(usr2){
			List<Case> caseList1 = new List<Case>();
	    	Case cs1 = new Case();
	    	cs1.Entity_Backup__c = 'AMFS';
	    	cs1.Origin = 'Phone';
	    	cs1.Status ='New';
	    	cs1.ContactId = con1.Id;
			cs1.Subject = 'testing';
			cs1.Type = 'Request';
			cs1.Case_Type_Config__c = 'Request_Other';
			cs1.PIC_Department_LU__c = usr4.Id;
			caseList1.add(cs1);
			insert caseList1;
		}
		
		system.runAs(usr1){
			List<Case> caseList2 = new List<Case>();
			Case cs2 = new Case();
	    	cs2.Entity_Backup__c = 'AFI';
	    	cs2.Origin = 'Phone';
	    	cs2.Status ='New';
	    	cs2.ContactId = con2.Id;
			cs2.Subject = 'testing 123';
			cs2.Type = 'Request';
			cs2.Case_Type_Config__c = 'Bukti transfer';
			cs2.PIC_Department_LU__c = usr3.Id;
			cs2.Priority = 'Medium';
			cs2.Description = 'testing';
			cs2.Non_Inquiry__c = false; 
			cs2.Service_Type__c = 'Helpline'; 
			cs2.Is_Follow_Up__c = false;
			caseList2.add(cs2);
			insert caseList2;
		} 		
		Test.stopTest();
     }
    
    public static testmethod void test2() {
        
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
        Contact con1 = [select id from contact limit 1];
        Contact con2 = [select id from contact limit 1];
        
		List<Case> caseList3 = new List<Case>();
		Case cs3 = new Case();
    	cs3.Entity_Backup__c = 'AFI';
    	cs3.Origin = 'Phone';
    	cs3.Status ='New';
    	cs3.ContactId = con2.Id;
		cs3.Subject = 'testing 123';
		cs3.Type = 'Complaint';
		cs3.Complaint_type__c = 'Complex Case';
		cs3.Nature_Config__c = 'Claim';
		cs3.Category_Config__c = 'Claim Delay';
		caseList3.add(cs3);
		
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
		caseList3.add(cs4);
		
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
		caseList3.add(cs5);
		
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
		caseList3.add(cs6);
		
		insert caseList3;
        
     	Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like '%Agent%AFI' limit 1];
		User usr3 = new User(Alias = 'agent3', Email='agent03@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agent03', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, Entity__c = 'AFI', 
      			TimeZoneSidKey='Asia/Jakarta', UserName='agent03@axa.co.id', isActive = true);
         
        Email_Config__c ec1 = [select id from Email_Config__c where Entity__c = 'AFI' limit 1];
		
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
    
    
    
}