@isTest(seeAllData=true)
private class ContactCheck_Test {

    static testMethod void myTest() { 
    
        Account ac = new Account();
        ac.Name = 'Company';
        insert ac;

        Contact ld = New Contact();
        ld.FirstName = 'FirstName';
        ld.LastName = 'LastName';        
        ld.AccountId = ac.id;
        ld.Policy_No__c = '12345-67890';
        ld.Email = 'taufik.susanto@mii.co.id';
        ld.Entity__c = 'ALI';
        ld.MobilePhone = '081234567890';
        insert ld;

        Contact ct = new Contact();
        ct.AccountId = ac.id;
        ct.Policy_No__c = '67890-12345';
        ct.FirstName = 'FirstName';
        ct.LastName = 'LastName';        
        ct.Email = 'taufik.susanto@mii.co.id';
        ct.MobilePhone = '081234567890';
        ct.Entity__c = 'ALI';        
        insert ct;


        contact br = New contact();
        br.FirstName = 'FirstName';
        br.LastName = 'LastName';        
        br.AccountId = ac.id;
        br.Email = 'taufik.susanto@mii.co.id';
        br.MobilePhone = '081234567890';
        br.Entity__c = 'ALI';        
        br.Policy_No__c = '67890-67890';
        insert br;

        ApexPages.StandardController stc = new ApexPages.StandardController(br);
        
        ContactCheck b = new ContactCheck(stc);
        Test.startTest();
        String sP = b.idContact;
        Test.stopTest();

    }
    
    
    static testMethod void myTest2() { 
    
        Account ac = new Account();
        ac.Name = 'Company';
        insert ac;

        Contact ld = New Contact();
        ld.FirstName = 'FirstNameMAGI';
        ld.LastName = 'LastNameMAGI';        
        ld.AccountId = ac.id;
        ld.Policy_No__c = '54321-67890';
        ld.Email = 'test@gmail.co.id';
        ld.Entity__c = 'MAGI';
        ld.MobilePhone = '085734567857';
        insert ld;

        Contact ct = new Contact();
        ct.AccountId = ac.id;
        ct.Policy_No__c = '78890-54321';
        ct.FirstName = 'FirstNameMAGI';
        ct.LastName = 'LastNameMAGI';        
        ct.Email = 'test@gmail.co.id';
        ct.MobilePhone = '085734567857';
        ct.Entity__c = 'MAGI';        
        insert ct;


        contact br = New contact();
        br.FirstName = 'FirstNameMAGI';
        br.LastName = 'LastNameMAGI';        
        br.AccountId = ac.id;
        br.Email = 'test@gmail.co.id';
        br.MobilePhone = '085734567857';
        br.Entity__c = 'MAGI';        
        br.Policy_No__c = '78890-67890';
        insert br;

        ApexPages.StandardController stc = new ApexPages.StandardController(br);
        
        ContactCheck b = new ContactCheck(stc);
        Test.startTest();
        String sP = b.idContact;
        Test.stopTest();

    }
    
    
    static testMethod void myTest3() { 
    
        Account ac = new Account();
        ac.Name = 'Company';
        insert ac;

        Contact ld = New Contact();
        ld.FirstName = 'FirstNameAMFS';
        ld.LastName = 'LastNameAMFS';        
        ld.AccountId = ac.id;
        ld.Policy_No__c = '89201-67890';
        ld.Email = 'test2@gmail.co.id';
        ld.Entity__c = 'AMFS';
        ld.MobilePhone = '085734567857';
        insert ld;

        Contact ct = new Contact();
        ct.AccountId = ac.id;
        ct.Policy_No__c = '5555-89201';
        ct.FirstName = 'FirstNameAMFS';
        ct.LastName = 'LastNameAMFS';        
        ct.Email = 'test2@gmail.co.id';
        ct.MobilePhone = '085734567857';
        ct.Entity__c = 'AMFS';        
        insert ct;


        contact br = New contact();
        br.FirstName = 'FirstNameAMFS';
        br.LastName = 'LastNameAMFS';        
        br.AccountId = ac.id;
        br.Email = 'test2@gmail.co.id';
        br.MobilePhone = '085734567857';
        br.Entity__c = 'AMFS';        
        br.Policy_No__c = '5555-67890';
        insert br;

        ApexPages.StandardController stc = new ApexPages.StandardController(br);
        
        ContactCheck b = new ContactCheck(stc);
        Test.startTest();
        String sP = b.idContact;
        Test.stopTest();

    }
}