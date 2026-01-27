@isTest(SeeAllData=false)
public class InsertUpdateAccountTest{
    public static testMethod void testInsertUpdateAccount(){
        Test.startTest();
        
        List<Account> acl = new List<Account>();
        Account acafi = new Account(name='Account AFI', entity__c = 'AFI');
        acl.add(acafi);
        Account acamfs = new Account(name='Account AMFS', entity__c = 'AMFS');
        acl.add(acamfs);
        Account acmagi = new Account(name='Account MAGI', entity__c = 'MAGI');
        acl.add(acmagi);
        insert acl;
        
        //existing contact
        List<contact> existingCon = new List<contact>();
        Contact econ = new Contact();
        econ.Lastname = 'someone';
        econ.Policy_No__c = '939939';
        econ.phone = '1111111';
        econ.homephone = '2222222';
        econ.mobilephone = '3333333';
        econ.OtherPhone = '4444444';
        econ.Entity__c = 'AFI';
        econ.AccountId = acafi.id;
        existingCon.add(econ);

        Contact econc = new Contact();
        econc.Lastname = 'someone';
        econc.Policy_No__c = '92929101';
        econc.Entity__c = 'AFI';
        econc.AccountId = acafi.id;
        existingCon.add(econc);

        Contact econx = new Contact();
        econx.Lastname = 'someone';
        econx.Policy_No__c = '434931';
        econx.phone = '7676767';
        econx.birthdate = datetime.newInstance(1980,1,1).date();
        econx.Entity__c = 'AFI';
        econx.AccountId = acafi.id;
        existingCon.add(econx);
        
        Contact econ2 = new Contact();
        econ2.Lastname = 'someone';
        econ2.Policy_No__c = '838383';
        econ2.Entity__c = 'MAGI';
        econ2.AccountId = acmagi.id;
        existingCon.add(econ2);

        Contact econ3 = new Contact();
        econ3.Lastname = 'someone';
        econ3.phone = '1111111';
        econ3.Policy_No__c = '727279';
        econ3.Entity__c = 'AMFS';
        econ3.AccountId = acamfs.id;
        existingCon.add(econ3);
        
        insert existingCon;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
        //end
                
        List<Contact> ctlist = new List<Contact>();
        Contact con1 = new Contact();
        con1.Firstname = 'bpk';
        con1.Lastname = 'someone1';
        con1.Policy_No__c = '559643';
        con1.mobilephone = '3333333';
        con1.Entity__c = 'AFI';
        con1.phone = '2424242';
        ctlist.add(con1);

        Contact con1x = new Contact();
        con1x.Lastname = 'someone';
        con1x.Policy_No__c = '339611';
        con1x.mobilephone = '7676767';
        con1x.Entity__c = 'AFI';
        con1x.birthdate = datetime.newInstance(1980,1,1).date();
        ctlist.add(con1x);

        Contact con2 = new Contact();
        con2.Lastname = 'someone';
        con2.Policy_No__c = '765643';
        con2.Entity__c = 'AFI';
        ctlist.add(con2);

        Contact con3 = new Contact();
        con3.Lastname = 'someone';
        con3.Policy_No__c = '764443';
        con3.Entity__c = 'AMFS';
        ctlist.add(con3);

        Contact con4 = new Contact();
        con4.Lastname = 'someone';
        con4.Policy_No__c = '264442';
        con4.mobilephone = '3333333';
        con4.Entity__c = 'MAGI';
        ctlist.add(con4);

        Contact con5 = new Contact();
        con5.Firstname = 'bpk';
        con5.Lastname = 'someone1';
        con5.Policy_No__c = '111643';
        con5.Entity__c = 'AFI';
        ctlist.add(con5);

        insert ctlist;
        
        
        Test.stopTest();
    }
}