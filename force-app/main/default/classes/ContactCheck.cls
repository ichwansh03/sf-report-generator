public without sharing class ContactCheck{
    private Final Contact opp;
    
    public List<Contact> lstContact{get; set;}
    
    public String idContact{
        get {
            return this.opp.id;
        }
        private set;
    }
   
    public ContactCheck(ApexPages.StandardController std){
        this.opp = (Contact)std.getRecord();
        lstContact = new List<Contact>();
        Contact ld = [SELECT Id, Name, FirstName, LastName, Account.Name, Entity__c, Email, MobilePhone, HomePhone, Other_Email__c, Policy_No__c, Policy_No_Numeric__c, Insured_Name__c, Priority_Customer__c FROM Contact WHERE id=:this.opp.id];
        // check Contact
        
        //Update 20 Dec 2019
        if(ld.Entity__c == 'AFI' || ld.Entity__c == 'ALI'){
            for (Contact temp : [SELECT Id, Name, FirstName, LastName, Account.Name, Entity__c, Email, MobilePhone, HomePhone, 
                                 Other_Email__c, Policy_No__c, Policy_No_Numeric__c, Insured_Name__c, Priority_Customer__c 
                                 FROM Contact WHERE ((Email =:ld.Email AND Email != NULL) OR (MobilePhone =:ld.MobilePhone AND MobilePhone != NULL)) AND (Entity__c = 'AFI' OR Entity__c = 'ALI') AND id != :this.opp.id
                                ]){
                                    lstContact.add(temp);
                                }        
        } else if(ld.Entity__c == 'MAGI' || ld.Entity__c == 'AGI'){
            for (Contact temp : [SELECT Id, Name, FirstName, LastName, Account.Name, Entity__c, Email, MobilePhone, HomePhone, 
                                 Other_Email__c, Policy_No__c, Policy_No_Numeric__c, Insured_Name__c, Priority_Customer__c 
                                 FROM Contact WHERE ((Email =:ld.Email AND Email != NULL) OR (MobilePhone =:ld.MobilePhone AND MobilePhone != NULL)) AND (Entity__c = 'MAGI' OR Entity__c = 'AGI') AND id != :this.opp.id
                                ]){
                                    lstContact.add(temp);
                                }        
        } else if(ld.Entity__c == 'AMFS'){
            for (Contact temp : [SELECT Id, Name, FirstName, LastName, Account.Name, Entity__c, Email, MobilePhone, HomePhone, 
                                 Other_Email__c, Policy_No__c, Policy_No_Numeric__c, Insured_Name__c, Priority_Customer__c 
                                 FROM Contact WHERE ((Email =:ld.Email AND Email != NULL) OR (MobilePhone =:ld.MobilePhone AND MobilePhone != NULL)) AND (Entity__c = 'AMFS') AND id != :this.opp.id
                                ]){
                                    lstContact.add(temp);
                                }        
        }
        //END - Update 20 Dec 2019
        
        //Coding existing - update 20 Dec 2019
        /*for (Contact temp : [SELECT Id, Name, FirstName, LastName, Account.Name, Entity__c, Email, MobilePhone, HomePhone, 
                                 Other_Email__c, Policy_No__c, Policy_No_Numeric__c, Insured_Name__c, Priority_Customer__c 
                                 FROM Contact WHERE ((Email =:ld.Email AND Email != NULL) OR (MobilePhone =:ld.MobilePhone AND MobilePhone != NULL)) AND id != :this.opp.id
                                ]){
                                    lstContact.add(temp);
                                }*/
        
        
    } //end StandardController.
} // end class