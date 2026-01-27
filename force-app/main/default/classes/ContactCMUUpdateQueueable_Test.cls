@isTest
public class ContactCMUUpdateQueueable_Test {
    
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
        
        Account a = new Account();
        a.Name = 'Account AMFS';
        a.Entity__c = 'AMFS';
        insert a;

        CMU_Contact__c cmu = new CMU_Contact__c();
        cmu.Policy_No__c = '100-000-1110001';
        cmu.Probable_Causes__c = 'Transaction Premium is 127.5 Mill. Rupiah, Policy Sum Insured in IDR is Less than Rp 300 Mill, Loss/Gain Value is Is LOSS (-0.406)';
        cmu.Prediction__c = '0';
        cmu.Complaint_Probability__c = '52.43 %';
        cmu.Complaint_Risk__c = 'Medium';
        cmu.Occupation__c = 'Wiraswasta';
        insert cmu;
        
        Contact c = new Contact();
        c.AccountId = a.Id;
        c.LastName = 'LastName';
        c.FirstName = 'FirstName';
        c.Entity__c = 'AMFS';
        c.Policy_No__c = '100-000-1110001';
        c.PolicyApp__c = 'DMTM';
        c.Probable_Causes__c = 'Transaction Premium is 127.5 Mill. Rupiah, Policy Sum Insured in IDR is Less than Rp 300 Mill, Loss/Gain Value is Is LOSS (-0.406)';
        c.Prediction__c = '0';
        c.Complaint_Probability__c = '52.43 %';
        c.Complaint_Risk__c = 'Medium';
        c.Occupation__c = 'Wiraswasta';
        insert c;  
        
    }
    
    @isTest
    static void testCMUInsert(){
        SchContactCMUUpdate sch = new SchContactCMUUpdate();
        sch.execute(null);
    }
}