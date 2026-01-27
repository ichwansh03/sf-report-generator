@isTest
public class ClaimRejectSch_Test {
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
        
        ICF_Non_Real_Time__c data = new ICF_Non_Real_Time__c();
        data.Claim_Number__c = '12345';
        data.Claim_Type__c = 'Health';
        data.Fraud__c = 'AF';
        data.Jenis_Transaksi__c = 'CASHLESS';
        data.Nama_RS_Provider__c = 'RS. ABC';
        data.Source_System__c = 'RLS';
        data.External_ID__c = '12345-77700144';
        data.Policy_Number__c = '77700144';
        data.Proceed_ICF__c = false;
        insert data;
        
        Test.startTest();
        ClaimRejectSch sch = new ClaimRejectSch();
        sch.execute(null);
        Test.stopTest();
    }

}