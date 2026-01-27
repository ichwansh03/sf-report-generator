@isTest
public class ClaimApproveSch_Test {
    static testMethod void TestClass(){
        String entity = 'AMFS';
        Date YESTERDAYS = Date.today().addDays(-1);
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest20';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Adi';
        contact1.LastName = 'Wijaya';
        contact1.Email = 'adiwijaya@email.com';
        contact1.MobilePhone = '6285716222996';
        contact1.Policy_No__c = '77700144';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        contact1.WelcomeCall_Issued_Date__c = YESTERDAYS;
        insert contact1;
        
        ICF_Claim_Approve__c data2 = new ICF_Claim_Approve__c();
        data2.Claim_Number__c = null;
        data2.Proceed_ICF__c = false;
        data2.Policy_Number__c = '77700144';
        insert data2;
        
        Test.startTest();
        ClaimApproveSch sch = new ClaimApproveSch();
        sch.execute(null);
        Test.stopTest();
    }
    
    static testMethod void TestClass2(){
        String entity = 'AMFS';
        Date YESTERDAYS = Date.today().addDays(-1);
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest20';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Adi';
        contact1.LastName = 'Wijaya';
        contact1.Email = 'adiwijaya@email.com';
        contact1.MobilePhone = '6285716222996';
        contact1.Policy_No__c = '77700144';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        contact1.WelcomeCall_Issued_Date__c = YESTERDAYS;
        insert contact1;
               
        ICF_Claim_Approve__c data2 = new ICF_Claim_Approve__c();
        data2.Claim_Number__c = null;
        data2.Proceed_ICF__c = false;
        data2.Policy_Number__c = '77700144';
        insert data2;
        
        Test.startTest();
        ClaimApproveSch sch = new ClaimApproveSch();
        sch.execute(null);
        Test.stopTest();
    }
    
    /*static testmethod void testExecuteThrowsException() {
        // Buat data dummy ICF_Claim_Approve__c
        ICF_Claim_Approve__c claim = new ICF_Claim_Approve__c();
        claim.Policy_Number__c = '';
        claim.Claim_Number__c = '';
        insert claim;

        // Tidak membuat Contact, RecordType, atau User yang dibutuhkan
        // Sehingga query akan gagal dan masuk ke blok catch

        Test.startTest();
        ClaimApproveSch sch = new ClaimApproveSch();
        sch.execute(null);
        Test.stopTest();

        // Verifikasi bahwa flag Proceed_ICF__c tetap di-set meskipun exception terjadi
        claim = [SELECT Proceed_ICF__c FROM ICF_Claim_Approve__c WHERE Id = :claim.Id];
        System.assertEquals(true, claim.Proceed_ICF__c, 'Flag Proceed_ICF__c harus true meskipun terjadi exception');
    }*/


}