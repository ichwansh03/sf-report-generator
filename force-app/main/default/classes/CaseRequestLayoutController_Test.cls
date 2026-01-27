@isTest
public class CaseRequestLayoutController_Test{

    public static testMethod void testCaseRequest() {
		string afiRecType = '';
        string amfsRecType = '';
        string magiRecType = '';
		        
		Test.startTest();
		
		List<RecordType> caseRecordTypeList = [SELECT Name, Id, DeveloperName, SobjectType FROM RecordType where SobjectType = 'Case' and name like 'Request%'];
        for(RecordType rt: caseRecordTypeList){
        	if(rt.name.indexof('AFI')!=-1){
        		afiRecType = rt.Id;	
        	}else if(rt.name.indexof('AMFS')!=-1){
        		amfsRecType = rt.Id;	
        	}else if(rt.name.indexof('MAGI')!=-1){
        		magiRecType = rt.Id;	
        	}
        }
		
		Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like '%Agent%AFI' limit 1];
		Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like '%Agent%AMFS' limit 1]; 
     	Profile agentProfileMAGI = [SELECT Id FROM Profile WHERE Name like '%Agent%MAGI' limit 1];
     	
     	Profile spvProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AFI' limit 1]; 
        Profile spvProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AMFS' limit 1]; 
        Profile spvProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%MAGI' limit 1]; 
		
		List<User> spvList = new List<User>();
        User loginAFIUser = new User(Alias = 'spv1', Email='spvAfi@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='spvAfi', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = spvProfileAFI.Id, Entity__c = 'AFI', 
      			TimeZoneSidKey='Asia/Jakarta', UserName='spvAfi@axa.co.id');
		spvList.add(loginAFIUser);

        User loginAMFSUser = new User(Alias = 'spv2', Email='spvAmfs@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='spvAmfs', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = spvProfileAMFS.Id, Entity__c = 'AMFS', 
      			TimeZoneSidKey='Asia/Jakarta', UserName='spvAmfs@axa.co.id');
		spvList.add(loginAMFSUser);

        User loginMAGIUser = new User(Alias = 'spv3', Email='spvMagi@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='spvMagi', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = spvProfileMAGI.Id, Entity__c = 'MAGI', 
      			TimeZoneSidKey='Asia/Jakarta', UserName='spvMagi@axa.co.id');
		spvList.add(loginMAGIUser);
		insert spvList;
		 
		 List<User> agentList = new List<User>();
         User subOrdinateAFIUser = new User(Alias = 'agent1', Email='agentAfi@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentAfi', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, managerId = loginAFIUser.id, Entity__c = 'AFI',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentAfi@axa.co.id', isActive = true, Agent__c = true);
		 agentList.add(subOrdinateAFIUser);

         User subOrdinateAMFSUser = new User(Alias = 'agent2', Email='agentAmfs@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentAmfs', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = loginAMFSUser.id, Entity__c = 'AMFS',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentAmfs@axa.co.id', isActive = true, Agent__c = true);
		 agentList.add(subOrdinateAMFSUser);

         User subOrdinateMAGIUser = new User(Alias = 'agent3', Email='agentMagi@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentMagi', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileMAGI.Id, managerId = loginMAGIUser.id, Entity__c = 'MAGI',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentMagi@axa.co.id', isActive = true, Agent__c = true);
		 agentList.add(subOrdinateMAGIUser);
		 insert agentList;
		
		List<Account> accList = new List<Account>();
		Account acc = new Account();
		acc.Name = 'Account AMFS';
		accList.add(acc);
		insert accList;
		
		List<Contact> conList = new List<Contact>();
		Contact con = new Contact();
		con.FirstName = 'Hamfry';
		con.LastName = 'Lantu';
		con.email = 'hamfry@saasten.com';
		con.Entity__c = 'AMFS';
		con.AccountId = acc.Id;
		conList.add(con);
		
		insert conList;
		
		system.runAs(loginAMFSUser){
			List<Case> caseList = new List<Case>();
	        Case cs1 = new Case();
	        //cs1.ContactId = con.Id;
		    cs1.Status = 'New';
		    cs1.type = 'Request';
		    cs1.Priority = 'Simple Case';
		    //cs1.Service_Type__c = 'Helpline';
		    cs1.origin = 'Phone';
		    cs1.Entity_Backup__c = 'AMFS';
		    cs1.Case_Type_Config__c = 'Bukti Transfer';
		    cs1.Subject = 'Testing only';
		 	cs1.Description = 'Not for Sale';
		    cs1.PIC_Department_LU__c = subOrdinateAMFSUser.Id;
		    //cs1.accountId = acc.Id;
		    cs1.RecordTypeId = amfsRecType;
		    cs1.Non_Inquiry__c = true;
		    caseList.add(cs1);
		    
		    insert caseList;
		    
	        Apexpages.currentPage().getParameters().put('cas3', con.Id);
	 		Apexpages.currentPage().getParameters().put('RecordType', amfsRecType);
		    Apexpages.currentPage().getParameters().put('cas5', 'Request'); 
		    Apexpages.currentPage().getParameters().put('retURL', '/' + cs1.Id);
		    Apexpages.currentPage().getParameters().put('cas11', 'email');
		    
		    ApexPages.StandardController sc1 = new ApexPages.StandardController(cs1);
	 		CaseRequestLayoutController caseRequest1 = new CaseRequestLayoutController(sc1);
	 		caseRequest1.save();
	 		caseRequest1.SaveAndNew();
	 		caseRequest1.cancel();
	     
	     	Apexpages.currentPage().getParameters().put('cas3', null);
	 		Apexpages.currentPage().getParameters().put('RecordType', amfsRecType);
		    Apexpages.currentPage().getParameters().put('cas5', 'Request'); 
		    Apexpages.currentPage().getParameters().put('retURL', '/' + cs1.Id);
		    Apexpages.currentPage().getParameters().put('cas11', 'email');
		    
		    ApexPages.StandardController sc2 = new ApexPages.StandardController(cs1);
	 		CaseRequestLayoutController caseRequest2 = new CaseRequestLayoutController(sc2);
	 		caseRequest2.save();
	 		caseRequest2.SaveAndNew();
	 		caseRequest2.cancel();
	     	
	        ApexPages.currentPage().getParameters().put('def_contact_id', con.Id);
	        ApexPages.currentPage().getParameters().put('def_account_id', acc.Id);
		    Apexpages.currentPage().getParameters().put('cas5', 'Request'); 
		    Apexpages.currentPage().getParameters().put('retURL', '/' + cs1.Id);
		    Apexpages.currentPage().getParameters().put('cas11', 'none');
		    
		    ApexPages.StandardController sc3 = new ApexPages.StandardController(cs1);
	 		CaseRequestLayoutController caseRequest3 = new CaseRequestLayoutController(sc3);
	 		caseRequest3.save();
	 		caseRequest3.cancel();
    	}
        Test.stopTest();
    }
}