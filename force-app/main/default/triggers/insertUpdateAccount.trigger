trigger insertUpdateAccount on Contact (before update, before insert) {
	string contactRecordTypeId = system.label.Contact_Record_Type_ID;
	List<Account> accountList = [select id, entity__c, name from account where createdDate > 2014-12-31T23:59:59Z and name like 'Account%'];
	Map<string,string> accountMap = new Map<string,string>();
	for(Account acc : accountList){
		if(acc.entity__c!= null && !accountMap.containsKey(acc.entity__c)){
			accountMap.put(acc.entity__c, acc.id);
		}
	}
	for(Contact c : trigger.new){
		if(c.policy_no__c != null && c.policy_no__c != '' && c.entity__c!=null && c.entity__c!='' && c.accountid == null){
			c.accountid = accountMap.get(c.entity__c);
			c.recordtypeid = contactRecordTypeId;
		}
	}

	/*
    Map<string, Contact> contactMap = new Map<string, Contact>();
    Map<string,string> nameMap = new Map<string,string>();
    Map<string,string> phoneMap = new Map<string,string>();
    Map<date,date> dateMap = new Map<date,date>();
    Map<string,string> entityMap = new Map<string,string>();
    for(Contact contact : trigger.new){
        system.debug('>>> contact.Policy_No__c : '+contact.Policy_No__c);
        system.debug('>>> contact.Account : '+contact.Account);
        if(contact.Account == null){
            contactMap.put(contact.id,contact);
            if(contact.phone != null && !phoneMap.containsKey(contact.phone)){
                phoneMap.put(contact.phone, contact.phone);
            }
            if(contact.mobilephone != null && !phoneMap.containsKey(contact.mobilephone)){
                phoneMap.put(contact.mobilephone, contact.mobilephone);
            }
            if(contact.homephone != null && !phoneMap.containsKey(contact.homephone)){
                phoneMap.put(contact.homephone, contact.homephone);
            }
            if(contact.lastname != null && !nameMap.containsKey(contact.lastname)){
                nameMap.put(contact.lastname, contact.lastname);
            }
            if(contact.Birthdate != null && !dateMap.containsKey(contact.Birthdate)){
                dateMap.put(contact.Birthdate, contact.Birthdate);
            }
            if(contact.Entity__c != null && !entityMap.containsKey(contact.Entity__c)){
                entityMap.put(contact.Entity__c, contact.Entity__c);
            }
        }
    }
    
    List<Account> existingAccountList = new List<Account>();
    //List<Account> existingAccountList = [select id, name, PhoneCompound__c, Email__c, Entity__c from Account where Phone in :phoneMap.keySet() or Home_Phone__c in :phoneMap.keySet()  or Mobile_Phone__c in :phoneMap.keySet() or Other_Phone__c in :phoneMap.keySet()];
    //List<Account> existingAccountList = [select id, name, PhoneCompound__c, Email__c, Entity__c from Account where createdDate > 2014-12-31T00:00:01Z and name in :nameMap.keySet() and DoB__c in :dateMap.keySet() and (Phone in :phoneMap.keySet() or Home_Phone__c in :phoneMap.keySet()  or Mobile_Phone__c in :phoneMap.keySet() or Other_Phone__c in :phoneMap.keySet())];
    //List<Account> existingAccountList = [select id, name, PhoneCompound__c, Email__c, Entity__c from Account where createdDate > 2014-12-31T00:00:01Z and name in :nameMap.keySet() and DoB__c in :dateMap.keySet() and (Phone in :phoneMap.keySet() or Home_Phone__c in :phoneMap.keySet()  or Mobile_Phone__c in :phoneMap.keySet())];
    if(!phoneMap.isEmpty() && !dateMap.isEmpty() ){
        existingAccountList = [select id, name, PhoneCompound__c, Email__c, Entity__c from Account where createdDate > 2014-12-31T00:00:01Z and name in :nameMap.keySet() and entity__c in :entityMap.keySet() and DoB__c in :dateMap.keySet() and (Phone in :phoneMap.keySet() or Home_Phone__c in :phoneMap.keySet()  or Mobile_Phone__c in :phoneMap.keySet())];
    }else if(!phoneMap.isEmpty()){
        existingAccountList = [select id, name, PhoneCompound__c, Email__c, Entity__c from Account where createdDate > 2014-12-31T00:00:01Z and name in :nameMap.keySet() and entity__c in :entityMap.keySet() and (Phone in :phoneMap.keySet() or Home_Phone__c in :phoneMap.keySet()  or Mobile_Phone__c in :phoneMap.keySet())];
    }else if(!dateMap.isEmpty()){
        existingAccountList = [select id, name, PhoneCompound__c, Email__c, Entity__c from Account where createdDate > 2014-12-31T00:00:01Z and name in :nameMap.keySet() and entity__c in :entityMap.keySet() and DoB__c in :dateMap.keySet()];
    }else{
        existingAccountList = [select id, name, PhoneCompound__c, Email__c, Entity__c from Account where createdDate > 2014-12-31T00:00:01Z and name in :nameMap.keySet() and entity__c in :entityMap.keySet()];
    }
    List<Account> newAccountList = new List<Account>();
    Contact currentContact = null;
    Account newAccount = null;
    boolean isAccountExist = false;
    string fullname = '';
    string phoneNo = '';
    string homePhoneNo = '';
    string mobilePhoneNo = '';
    Date dob = null;
    for(string id : contactMap.keySet()){
        isAccountExist = false;
        currentContact = contactMap.get(id);
        fullname = currentContact.Lastname;
        system.debug('>>> currentContact.Lastname : '+currentContact.Lastname);
        system.debug('>>> currentContact.Firstname: '+currentContact.Firstname);
    
        if(currentContact.Firstname!=null && currentContact.Firstname!=''){
            fullname = currentContact.Firstname +' '+currentContact.Lastname;
        }
        system.debug('>>> fullname : '+fullname );

        for(Account account : existingAccountList){
            system.debug('>>> account.name : '+account.name );
            system.debug('>>> account.PhoneCompound__c : '+account.PhoneCompound__c);
            system.debug('>>> currentContact.Entity__c : '+currentContact.Entity__c);
            system.debug('>>> account.Entity__c : '+account.Entity__c);
            system.debug('>>> currentContact.phone : '+currentContact.phone);
            system.debug('>>> currentContact.phone : '+currentContact.mobilephone);
            system.debug('>>> currentContact.phone : '+currentContact.homephone);
            system.debug('>>> currentContact.phone : '+currentContact.OtherPhone);
            
            
            if(fullname == account.Name  && currentContact.Entity__c == account.Entity__c && 
                ((account.PhoneCompound__c!=null && currentContact.phone!= null && account.PhoneCompound__c.indexOf(currentContact.phone)!=-1) || 
                 (account.PhoneCompound__c!=null && currentContact.mobilephone!= null && account.PhoneCompound__c.indexOf(currentContact.mobilephone)!=-1) || 
                 (account.PhoneCompound__c!=null && currentContact.homephone!= null && account.PhoneCompound__c.indexOf(currentContact.homephone)!=-1) //|| 
//                 (account.PhoneCompound__c!=null && account.PhoneCompound__c.indexOf(currentContact.OtherPhone)!=-1))
                )){
                currentContact.AccountId = account.id;
                isAccountExist = true;    
                break;
            }else if(fullname == account.Name && currentContact.Entity__c == account.Entity__c) {
                currentContact.AccountId = account.id;
                isAccountExist = true;    
                break;
            }
        }
        //create new account
        if(!isAccountExist){
            newAccount = new Account();
            newAccount.name = fullname; //currentContact.Name;
            system.debug('>>> newAccount.name : '+newAccount.name );
            newAccount.Phone = currentContact.Phone;    
            newAccount.Mobile_Phone__c = currentContact.MObilePhone;    
            newAccount.Home_Phone__c = currentContact.HomePhone;    
            //newAccount.Other_Phone__c = currentContact.OtherPhone;    
            //newAccount.Email__c = currentContact.Email;
            newAccount.Entity__c = currentContact.Entity__c;
            newAccountList.add(newAccount);    
        }
    }
    insert newAccountList;
    for(Account acc : newAccountList){
        for(string id : contactMap.keySet()){
            isAccountExist = false;
            currentContact = contactMap.get(id);
            if(currentContact.AccountId!=null){
                continue;
            }
            fullname = currentContact.Lastname;
            if(currentContact.Firstname!=null && currentContact.Firstname!=''){
                fullname = currentContact.Firstname +' '+currentContact.Lastname;
            }
            if(fullname == acc.Name  && currentContact.Entity__c == acc.Entity__c && 
                ((acc.PhoneCompound__c!=null && currentContact.phone!= null && acc.PhoneCompound__c.indexOf(currentContact.phone)!=-1) || 
                 (acc.PhoneCompound__c!=null && currentContact.mobilephone!= null && acc.PhoneCompound__c.indexOf(currentContact.mobilephone)!=-1) || 
                 (acc.PhoneCompound__c!=null && currentContact.phone!= null && acc.PhoneCompound__c.indexOf(currentContact.homephone)!=-1 )//|| 
                 //(acc.PhoneCompound__c!=null && acc.PhoneCompound__c.indexOf(currentContact.OtherPhone)!=-1)
                 )){
                currentContact.AccountId = acc.id;
                isAccountExist = true;    
                break;
            }else if(fullname == acc.Name  && currentContact.Entity__c == acc.Entity__c) {
                currentContact.AccountId = acc.id;
                isAccountExist = true;    
                break;
            }
        }
    }
    */
}