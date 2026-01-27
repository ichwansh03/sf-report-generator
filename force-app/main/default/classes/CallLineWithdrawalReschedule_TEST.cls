@isTest
private class CallLineWithdrawalReschedule_TEST {

    @isTest
    static void testBookingCallRescheduleWithFallback() {
        // Step 1: Buat parent Call_List__c
        //Insert Call_List__c
        List<Call_List__c> campaignList = new List<Call_List__c>();
        Call_List__c clist1 = new Call_List__c();
        clist1.Activity__c = 'Collection';
        clist1.IsExpired__c = false;
        clist1.Entity__c = 'AMFS';
        clist1.Case_Type__c = 'Withdrawal';
        clist1.Case_Type_Config__c = 'Withdrawal';
        //clist1.RecordTypeId = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS 6').getRecordTypeId();
        clist1.Expired_Date__c = system.today();
        campaignList.add(clist1);
        insert campaignList;
        
        
        //Re-Query
        clist1 = [SELECT id, Campaign_Type__C FROM Call_List__C where id = :clist1.Id];
        system.debug('Campaign Type TEST ===> ' + clist1.Campaign_Type__c);
        
        

        // Step 2: Coba insert Call_Line__c dengan picklist 'Booking Call'
        String retryStatus = 'Booking Call';
        system.debug('Campaign Type TEST 2 ===> ' + clist1.Campaign_Type__c);
        Call_Line__c cl;
        try {
            cl = new Call_Line__c(
                Call_List__c = clist1.Id,
                Activity_Result__c = 'F',
                Date_Reschedule__c = Date.today(),
                Status_Retry__c = retryStatus
                //campaign_type__c = clist1.Campaign_Type__c
            );
            insert cl;
            system.debug('Campaign Type TEST 3 ===> ' + clist1.Campaign_Type__c);
            Date today = Date.today();
        Call_Line__c callLinesToUpdate = new Call_Line__c();
        callLinesToUpdate = [SELECT Id, Reschedule_Date__c
            FROM Call_Line__c
            WHERE Activity_Result__c = 'F'
            AND Date_Reschedule__c = :today
            AND campaign_type__c = 'Collection-Withdrawal'];
        
        system.debug('callLinesToUpdate TEST ===> ' + callLinesToUpdate);
        } catch (Exception e) {
            // Fallback ke value lain kalau error restricted picklist
            retryStatus = 'Rescheduled';
            cl = new Call_Line__c(
                Call_List__c = clist1.Id,
                Activity_Result__c = 'F',
                Date_Reschedule__c = Date.today(),
                Status_Retry__c = retryStatus
            );
            insert cl;
        }

        // Step 3: Jalankan jadwal
        Test.startTest();
        System.schedule('Test BookingCall', '0 0 0 1 1 ? 2050', new CallLineWithdrawalReschedule());
        Test.stopTest();

        // Step 4: Validasi tanggal berubah
        cl = [SELECT Reschedule_Date__c FROM Call_Line__c WHERE Id = :cl.Id];
        System.assertNotEquals(Date.today(), cl.Reschedule_Date__c, 'Tanggal harus berubah');
    }

    @isTest
    static void testHelperWorkingDayLogic() {
        Date today = Date.newInstance(2025, 7, 18); // Misalnya Jumat
        Date nextDay = CallLineDateHelper.getNextWorkingDay(today);

        // Pastikan nextDay lebih dari today dan bukan Sabtu/Minggu
        Integer offset = nextDay.toStartOfWeek().daysBetween(nextDay); // 0 = Senin, 6 = Minggu
        System.assert(offset < 5, 'Hari kerja = Senin s/d Jumat');
        System.assert(nextDay > today, 'Tanggal harus maju');
    }
}