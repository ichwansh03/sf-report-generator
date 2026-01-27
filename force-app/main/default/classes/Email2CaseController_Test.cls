@isTest
public class Email2CaseController_Test {

     public static testMethod void Email2CaseControllerTest(){
     	Test.startTest();
        List<Case> caseList = new List<Case>();
    	List<Contact> contactList = new List<Contact>();
    	
    	Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AFI' limit 1]; 
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AMFS' limit 1]; 
        Profile agentProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%MAGI' limit 1]; 
        
        Profile spvProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AFI' limit 1]; 
        Profile spvProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Supervisor%AMFS' limit 1]; 
        Profile spvProfileMAGI = [SELECT Id FROM Profile WHERE Name like 'Supervisor%MAGI' limit 1]; 
         
        List<User> spvList = new List<User>();
        User loginAFIUser = new User(Alias = 'spv1', Email='spvAfi@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='spvAfi', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = spvProfileAFI.Id, Entity__c = 'AFI', 
      			TimeZoneSidKey='Asia/Jakarta', UserName='spvAfi@axa.co.id', isActive = true);
		spvList.add(loginAFIUser);

        User loginAMFSUser = new User(Alias = 'spv2', Email='spvAmfs@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='spvAmfs', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = spvProfileAMFS.Id, Entity__c = 'AMFS',
      			TimeZoneSidKey='Asia/Jakarta', UserName='spvAmfs@axa.co.id', isActive = true);
		spvList.add(loginAMFSUser);

        User loginMAGIUser = new User(Alias = 'spv3', Email='spvMagi@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='spvMagi', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = spvProfileMAGI.Id, Entity__c = 'MAGI',
      			TimeZoneSidKey='Asia/Jakarta', UserName='spvMagi@axa.co.id', isActive = true);
		spvList.add(loginMAGIUser);
		insert spvList;
		  
    	List<User> agentList = new List<User>();
        User subOrdinateAFIUser = new User(Alias = 'agent1', Email='agentAfi@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentAfi', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileAFI.Id, managerId = loginAFIUser.id, Entity__c = 'AFI',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentAfi@axa.co.id', Agent__c = true, isActive = true);
		agentList.add(subOrdinateAFIUser);

        User subOrdinateAMFSUser = new User(Alias = 'agent2', Email='agentAmfs@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentAmfs', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileAMFS.Id, managerId = loginAMFSUser.id, Entity__c = 'AMFS',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentAmfs@axa.co.id', Agent__c = true, isActive = true);
		agentList.add(subOrdinateAMFSUser);

        User subOrdinateMAGIUser = new User(Alias = 'agent3', Email='agentMagi@axa.co.id', 
      			EmailEncodingKey='UTF-8', LastName='agentMagi', LanguageLocaleKey='en_US', 
      			LocaleSidKey='en_US', ProfileId = agentProfileMAGI.Id, managerId = loginMAGIUser.id, Entity__c = 'MAGI',
      			TimeZoneSidKey='Asia/Jakarta', UserName='agentMagi@axa.co.id', Agent__c = true, isActive = true);
		agentList.add(subOrdinateMAGIUser);
		insert agentList;
		
		Contact con1 = new Contact();
		con1.FirstName = 'Hamfry';
		con1.LastName = 'Lantu';
		contactList.add(con1);
		
		Contact con2 = new Contact();
		con2.FirstName = 'Hamfry';
		con2.LastName = 'Lantoe';
		contactList.add(con2);
		
		Contact con3 = new Contact();
		con3.FirstName = 'Hamfree';
		con3.LastName = 'Lantwo';
		contactList.add(con3);
				
		insert contactList;
		
    	Case cs1 = new Case();
    	cs1.Entity_Backup__c = 'AFI';
    	cs1.Origin = 'Email';
    	cs1.Status ='New';
    	cs1.suppliedEmail = 'testing123@nyaho.com';
    	cs1.ContactId = con1.Id;
		cs1.Status = 'New';
		cs1.Subject = 'testing';
		cs1.Type = 'Inquiry';
		cs1.Case_Type_Config__c = 'Inquiry Status';
		cs1.Description = 'testing for test class';
		cs1.OwnerId = subOrdinateAFIUser.Id;
		cs1.e2cEmailTo__c = 'customer@axa-financial.co.id';
    	caseList.add(cs1);
    	
    	Case cs2 = new Case();
    	cs2.Entity_Backup__c = 'AMFS';
    	cs2.Origin = 'Email';
    	cs2.Status ='New';
    	cs2.suppliedEmail = 'testing234@nyaho.com';
    	cs2.ContactId = con2.Id;
		cs2.Status = 'New';
		cs2.Subject = 'testing 2';
		cs2.Type = 'Inquiry';
		cs2.Case_Type_Config__c = 'Inquiry Status';
		cs2.Description = '';
		cs2.OwnerId = subOrdinateAMFSUser.Id;
    	cs2.e2cEmailTo__c = 'customer@axa-mandiri.co.id';
    	caseList.add(cs2);
		
		Case cs3 = new Case();
    	cs3.Entity_Backup__c = 'MAGI';
    	cs3.Origin = 'Email';
    	cs3.Status ='New';
    	cs3.suppliedEmail = 'testing345@nyaho.com';
    	cs3.ContactId = con3.Id;
		cs3.Status = 'New';
		cs3.Subject = 'testing 3';
		cs3.Type = 'Inquiry';
		cs3.Case_Type_Config__c = 'Inquiry Status';
		cs3.Description = 'testing for test class';
		cs3.OwnerId = subOrdinateMAGIUser.Id;
    	cs3.e2cEmailTo__c = 'customer-general@axa-mandiri.co.id';
    	caseList.add(cs3);
    	
    	insert caseList;
        //Test.stopTest();
 
        List<Email_Config__c> emailCfgList = new List<Email_Config__c>();
        Email_Config__c ec1 = new Email_Config__c();
        ec1.Email_Address__c = 'customer@axa-financial.co.id';
        ec1.Entity__c = 'AFI';
        ec1.Distribution_Type__c = 'Manual';
        ec1.SLA__c = '2';
        ec1.Unit__c = 'Day';
        emailCfgList.add(ec1);
        
        Email_Config__c ec2 = new Email_Config__c();
        ec2.Email_Address__c = 'customer@axa-financial.co.id';
        ec2.Entity__c = 'AFI';
        ec2.Distribution_Type__c = 'Automatic';
        ec2.SLA__c = '2';
        ec2.Unit__c = 'Hour';
        emailCfgList.add(ec2);
         
        insert emailCfgList;
        
        system.runAs(loginAFIUser){
        	Email2CaseController.CaseWrapper wrap = new Email2CaseController.CaseWrapper();
	        wrap.id = cs1.Id;
	        wrap.isSelected = true;
		    wrap.indikator = cs1.Indicator__c;
            wrap.followUp = cs1.Follow_Up_Flag__c;
            wrap.caseNumber = cs1.CaseNumber ; 
            wrap.senderEmail = cs1.SuppliedEmail;
            wrap.toAddress = 'customer@axa-financial.co.id'; 
            wrap.customerName = cs1.Contact.Name;
            wrap.status = cs1.Status; 
            wrap.subject = cs1.Subject; 
            wrap.type = cs1.Type; 
            wrap.Entity = cs1.Entity__c; 
            wrap.createdDate = cs1.createdDate;
            wrap.assignedTo = cs1.Owner.Name;
            wrap.Description = cs1.Description; 
            
        	Email2CaseController e2c = new Email2CaseController();
	        e2c.getCaseRecords();
	        //e2c.assignUser();
	        e2c.agentPicklist();
	        e2c.refreshList();
	        e2c.getPagingButtons();
	        //e2c.selectedInbox();
	        e2c.refreshGrid();
	        e2c.Previous();
	        e2c.Next();
	        e2c.End();
	        e2c.getDisablePrevious();
	        e2c.getDisableNext();
	        e2c.getNoOfRecords();
	        e2c.getPageNumber();
	        e2c.getTotalPages();
	        e2c.assignedInbox = 'customer@axa-financial.co.id';
	        e2c.assignedAgent = subOrdinateAFIUser.Id;
	        e2c.assignUser();
	        e2c.calculateEmailSLA('customer@axa-financial.co.id');
	        e2c.selectedInbox();
        }
        
        system.runAs(loginAMFSUser){
        	Email2CaseController e2c2 = new Email2CaseController();
	        e2c2.getCaseRecords();
	        //e2c2.assignUser();
	        e2c2.agentPicklist();
	        e2c2.refreshList();
	        e2c2.getPagingButtons();
	        //e2c2.selectedInbox();
	        e2c2.refreshGrid();
	        e2c2.Previous();
	        e2c2.Next();
	        e2c2.End();
	        e2c2.getDisablePrevious();
	        e2c2.getDisableNext();
	        e2c2.getNoOfRecords();
	        e2c2.getPageNumber();
	        e2c2.getTotalPages();
	        e2c2.calculateEmailSLA('customer@axa-mandiri.co.id');
	        e2c2.assignedInbox = 'nasabah@axa-mandiri.co.id';
	        e2c2.assignedAgent = subOrdinateAMFSUser.Id;
	        e2c2.assignUser();
	        e2c2.selectedInbox();
	        
	        Email2CaseController.CaseWrapper wrap2 = new Email2CaseController.CaseWrapper();
	        wrap2.id = cs2.Id;
	        wrap2.isSelected = false;
		    wrap2.indikator = cs2.Indicator__c;
            wrap2.followUp = cs2.Follow_Up_Flag__c;
            wrap2.caseNumber = cs2.CaseNumber ; 
            wrap2.senderEmail = cs2.SuppliedEmail;
            wrap2.toAddress = 'customer@axa-mandiri.co.id'; 
            wrap2.customerName = cs2.Contact.Name;
            wrap2.status = cs2.Status; 
            wrap2.subject = cs2.Subject; 
            wrap2.type = cs2.Type; 
            wrap2.Entity = cs2.Entity__c; 
            wrap2.createdDate = cs2.createdDate;
            wrap2.assignedTo = cs2.Owner.Name;
            wrap2.Description = cs2.Description; 
        }
        
        system.runAs(subOrdinateMAGIUser){
        	Email2CaseController e2c3 = new Email2CaseController();
	        e2c3.getCaseRecords();
	        e2c3.assignUser();
	        e2c3.agentPicklist();
	        e2c3.refreshList();
	        e2c3.getPagingButtons();
	        e2c3.selectedInbox();
	        e2c3.refreshGrid();
	        e2c3.Previous();
	        e2c3.Next();
	        e2c3.End();
	        e2c3.getDisablePrevious();
	        e2c3.getDisableNext();
	        e2c3.getNoOfRecords();
	        e2c3.getPageNumber();
	        e2c3.getTotalPages();
	        e2c3.assignedInbox = 'All';
	        e2c3.calculateEmailSLA('customer-general@axa-mandiri.co.id');
	        
	        Email2CaseController.CaseWrapper wrap3 = new Email2CaseController.CaseWrapper();
	        wrap3.id = cs3.Id;
	        wrap3.isSelected = false;
		    wrap3.indikator = cs3.Indicator__c;
            wrap3.followUp = cs3.Follow_Up_Flag__c;
            wrap3.caseNumber = cs3.CaseNumber ; 
            wrap3.senderEmail = cs3.SuppliedEmail ; 
            wrap3.customerName = cs3.Contact.Name;
            wrap3.status = cs3.Status; 
            wrap3.subject = cs3.Subject; 
            wrap3.type = cs3.Type; 
            wrap3.Entity = cs3.Entity__c; 
            wrap3.createdDate = cs3.createdDate;
            wrap3.assignedTo = cs3.Owner.Name;
            wrap3.Description = cs3.Description; 
        }
        
       Test.stopTest();
     }
}