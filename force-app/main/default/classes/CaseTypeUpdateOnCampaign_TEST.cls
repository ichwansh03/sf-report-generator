@isTest
public class CaseTypeUpdateOnCampaign_TEST {
    
    @isTest
    static void testInsertTrigger() {
        // Buat data Call_List__c baru
        Call_List__c calist = new Call_List__c(
            
            Activity__c = 'Collection',
            Case_Type_Config__c = 'Withdrawal',
            Expired_Date__c = Date.newInstance(2030, 9, 30),
            Entity__c = 'AMFS'
        );
        
        insert calist;

        // Query ulang record setelah insert dan update di trigger
        Call_List__c insertedCl = [SELECT Id, Case_Type__c, Case_Type_Config__c FROM Call_List__c WHERE Id = :calist.Id];
        System.assertEquals('Withdrawal', insertedCl.Case_Type__c, 'Case_Type__c harus sama dengan Case_Type_Config__c setelah insert dan update di trigger');
    }

    @isTest
    static void testUpdateTrigger() {
        // Buat dan insert data awal
        Call_List__c cl = new Call_List__c(
            
            Activity__c = 'Collection',
            Case_Type_Config__c = 'Type A',
            Expired_Date__c = Date.newInstance(2030, 9, 30),
            Entity__c = 'AMFS'
        );
        insert cl;

        // Update Case_Type_Config__c
        cl.Case_Type_Config__c = 'Type B';
        update cl;

        // Ambil kembali record untuk verifikasi
        Call_List__c updatedCl = [SELECT Id, Case_Type__c, Case_Type_Config__c FROM Call_List__c WHERE Id = :cl.Id];
        System.assertEquals('Type B', updatedCl.Case_Type__c, 'Case_Type__c harus diperbarui sesuai dengan Case_Type_Config__c saat update');
    }
}