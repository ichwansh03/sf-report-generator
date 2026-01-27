@isTest
public class CallLineFieldAgingTest {
	   @testSetup static void setTestData() {
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%AMFS%' LIMIT 1].Id,
            LastName = 'LastName',
            Email = 'tester@email.com',
            Username = 'tester@email.com' + System.currentTimeMillis(),
            CompanyName = 'The Company',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            Entity__c = 'AMFS'
        );
        insert u;
        
        User u2 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%AFI%' LIMIT 1].Id,
            LastName = 'LastName2',
            Email = 'tester2@email.com',
            Username = 'tester2@email.com' + System.currentTimeMillis(),
            CompanyName = 'The Company 2',
            Title = 'title2',
            Alias = 'alias2',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            Entity__c = 'AFI'
        );
        insert u2;
        
        User u3 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
            LastName = 'LastName3',
            Email = 'tester3@email.com',
            Username = 'tester3@email.com' + System.currentTimeMillis(),
            CompanyName = 'The Company 3',
            Title = 'title3',
            Alias = 'alias3',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            Entity__c = 'AFI'
        );
        insert u3;
        
        User u4 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
            LastName = 'LastName4',
            Email = 'tester4@email.com',
            Username = 'tester4@email.com' + System.currentTimeMillis(),
            CompanyName = 'The Company 4',
            Title = 'title4',
            Alias = 'alias4',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            Entity__c = 'AGI'
        );
        insert u4;
        
		Account a = new Account();
        a.Name = 'Account AMFS';
        a.Entity__c = 'AMFS';
        insert a;
        
        Contact c = new Contact();
        c.AccountId = a.Id;
        c.LastName = 'LastName';
        c.FirstName = 'FirstName';
        c.Entity__c = 'AMFS';
        c.WelcomeCall_Product_Code_Plan__c  = 'MJK';
        insert c;  
           
           
        Contact cont = new Contact();
        cont.Policy_No__c = '100-000-1110001';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP DMTM';
        cont.WelcomeCall_Product_Code_Plan__c  = 'HONMEPS';
        insert cont;
                    
        Contact cont2 = new Contact();
        cont2.Policy_No__c = '100-000-1110002';
        cont2.FirstName = 'DUMMY';
        cont2.LastName = 'LOOKUP DMTM';
        cont2.WelcomeCall_Product_Code_Plan__c  = 'MPJ';
        insert cont2;
          
        Contact cont3 = new Contact();
        cont3.Policy_No__c = '100-000-1110003';
        cont3.FirstName = 'DUMMY';
        cont3.LastName = 'LOOKUP DMTM';
        cont3.WelcomeCall_Product_Code_Plan__c  = 'MSL';
        insert cont3;
          
          
        
        Id rtype = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
        Id usdRtype = Schema.SObjectType.User_Detail__c.getRecordTypeInfosByName().get('User Detail Collection AMFS').getRecordTypeId();
        
        Call_List__c cl = new Call_List__c();
        cl.RecordTypeId = rtype;
        cl.Activity__c = 'Collection';
        //cl.Case_Type__c = 'Lapse Konven';			//update 11/09/2020 - ganti jadi "Redemption Konven"
        cl.Case_Type__c = 'Redemption Konven';
        cl.Expired_Date__c = system.today() + 30;
        cl.Entity__c = 'AMFS';
        //cl.Campaign_Name__c = 'Lapse Konven';
        //cl.Campaign_Name__c = 'Lapse Konven';
        cl.Campaign_Name__c = 'Redemption Konven';
        cl.Activity__c = 'Collection';
        insert cl;
        
        Call_Line__c cLine = new Call_Line__c();
        cLine.Call_List__c = cl.id; 
        cLine.Contact__c = cont.id;
        cLine.Activity__c = 'Collection';
        cLine.Policy_No__c = '100-000-1110001'; 
        cLine.Call_Remarks__c = 'OK';
        cLine.Entity__c = 'AMFS';
        cLine.APE__c = 1000;
        cLine.Currency__c = 'IDR';
        insert cLine;
           
           
        Call_Line__c cLine2 = new Call_Line__c();
        cLine2.Call_List__c = cl.id; 
        cLine2.Contact__c = c.id;
        cLine2.Activity__c = 'Collection';
        cLine2.Policy_No__c = '100-000-1110001'; 
        cLine2.Call_Remarks__c = 'OK';
        cLine2.Entity__c = 'AMFS';
        cLine2.APE__c = 1000;
        cLine2.Currency__c = 'IDR';
        insert cLine2;
            
        Call_Line__c cLine3 = new Call_Line__c();
        cLine3.Call_List__c = cl.id; 
        cLine3.Contact__c = cont2.id;
        cLine3.Activity__c = 'Collection';
        cLine3.Policy_No__c = '100-000-1110002'; 
        cLine3.Call_Remarks__c = 'OK';
        cLine3.Entity__c = 'AMFS';
        cLine3.APE__c = 1000;
        cLine3.Currency__c = 'IDR';
        insert cLine3;
        
        
        Call_Line__c cLine4 = new Call_Line__c();
        cLine4.Call_List__c = cl.id; 
        cLine4.Contact__c = cont3.id;
        cLine4.Activity__c = 'Collection';
        cLine4.Policy_No__c = '100-000-1110003'; 
        cLine4.Call_Remarks__c = 'OK';
        cLine4.Entity__c = 'AMFS';
        cLine4.APE__c = 1000;
        cLine4.Currency__c = 'IDR';
        insert cLine4;
        
        Master_Pinalty__c mp = new Master_Pinalty__c(); 
           mp.Kode__c = 'MJK';
           mp.IsActive__c = true;
           mp.Description__c = 'MJK';
           mp.IDR__c = '0';
           mp.IDR_2__c = '0';
           mp.Percentage__c = '0';
           mp.Product__c = '0'; 
           mp.Type_Product__c = 'NCB';
           mp.USD__c = '0'; 
           mp.USD_2__c = '0'; 
           mp.Protection__c = '0'; 
           mp.Variabel__c = '0';  
        insert mp;
           
           
        Master_Pinalty__c mp2 = new Master_Pinalty__c(); 
           mp2.Kode__c = 'HONMEPS';
           mp2.IsActive__c = true;
           mp2.Description__c = 'HONMEPS';
           mp2.IDR__c = '0';
           mp2.IDR_2__c = '0';
           mp2.Percentage__c = '0';
           mp2.Product__c = '0'; 
           mp2.Type_Product__c = 'Finalty';
           mp2.USD__c = '0';  
           mp2.sub_type__c = 'Finalti Surrender/Withdrawal'; 
           mp2.USD_2__c = '0'; 
           mp2.Protection__c = '0';  
           mp2.Prime__c  = '0'; 
        insert mp2;
           
           
        Master_Pinalty__c mp3 = new Master_Pinalty__c(); 
           mp3.Kode__c = 'MPJ';
           mp3.IsActive__c = true;
           mp3.Description__c = 'MPJ';
           mp3.IDR__c = '0';
           mp3.IDR_2__c = '0';
           mp3.Percentage__c = '0';
           mp3.Product__c = '0'; 
           mp3.Type_Product__c = 'Finalty';
           mp3.USD__c = '0';  
           mp3.sub_type__c = 'Finalti Surrender/Withdrawal'; 
           mp3.USD_2__c = '0'; 
           mp3.Protection__c = '0'; 
        insert mp3;
        
        Master_Pinalty__c mp4 = new Master_Pinalty__c(); 
           mp4.Kode__c = 'MSL';
           mp4.IsActive__c = true;
           mp4.Description__c = 'MSL';
           mp4.IDR__c = '0';
           mp4.IDR_2__c = '0';
           mp4.Percentage__c = '0';
           mp4.Product__c = '0'; 
           mp4.Type_Product__c = 'Finalty';
           mp4.USD__c = '0';  
           mp4.sub_type__c = 'Finalti/Surrender'; 
           mp4.USD_2__c = '0'; 
           mp4.Protection__c = '0'; 
        insert mp4;
    }

    public static testmethod void testFieldAgingNCB(){
        Test.startTest(); 
            Call_line__c getRecord = [Select id, Formula_Product__c from Call_line__c where Formula_Product__c = 'HONMEPS'];
            ApexPages.StandardController stdController = new ApexPages.StandardController(getRecord);
            CallLineFieldAging con = new CallLineFieldAging(stdController);  
        Test.stopTest();
    }

    public static testmethod void testFieldAgingFinalty(){
        Test.startTest(); 
            Call_line__c getRecord = [Select id, Formula_Product__c from Call_line__c where Formula_Product__c = 'MJK'];
            ApexPages.StandardController stdController = new ApexPages.StandardController(getRecord);
            CallLineFieldAging con = new CallLineFieldAging(stdController);  
        Test.stopTest();
    }

    public static testmethod void testFieldAgingMPJ(){
        Test.startTest(); 
            Call_line__c getRecord = [Select id, Formula_Product__c from Call_line__c where Formula_Product__c = 'MPJ'];
            ApexPages.StandardController stdController = new ApexPages.StandardController(getRecord);
            CallLineFieldAging con = new CallLineFieldAging(stdController);  
        Test.stopTest();
    }
    

    public static testmethod void testFieldAgingMSL(){
        Test.startTest(); 
            Call_line__c getRecord = [Select id, Formula_Product__c from Call_line__c where Formula_Product__c = 'MSL'];
            ApexPages.StandardController stdController = new ApexPages.StandardController(getRecord);
            CallLineFieldAging con = new CallLineFieldAging(stdController);  
        Test.stopTest();
    }
    
     
}