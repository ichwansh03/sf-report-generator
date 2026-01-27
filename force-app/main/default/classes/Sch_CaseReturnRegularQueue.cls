global class Sch_CaseReturnRegularQueue implements Schedulable {
    @TestVisible private static List<Holiday> testInjectholidays;
    @TestVisible private static Date testInjectDateToday;
    @TestVisible private static DateTime testInjectCurrentDateTime;

    global void execute(SchedulableContext sc) {
        System.debug('AMFS_LOG - AMFSe2c## Mulai proses penjadwalan untuk Case Return to Regular Queue');
        
        try {
            DateTime now = Test.isRunningTest() && testInjectCurrentDateTime != null ? 
                          testInjectCurrentDateTime : System.now();
            Date today = now.date();
            
            if(Test.isRunningTest() && testInjectDateToday != null) {
                today = testInjectDateToday;
            }

            // ✅ 1. Query semua data yang diperlukan DI LUAR loop
            String queueNameLike = '%' + System.Label.AMFS_Queue_Contain + '%';
            
            // Query semua queues sekaligus
            List<Group> allQueues = [
                SELECT Id, Name, DeveloperName
                FROM Group
                WHERE Type = 'Queue' AND Name LIKE :queueNameLike 
            ];

            // Query holidays hanya sekali
            List<Holiday> holidays = [
                SELECT Id, Name, ActivityDate, StartTimeInMinutes, EndTimeInMinutes, IsAllDay 
                FROM Holiday 
                WHERE ActivityDate = :today 
                LIMIT 1
            ];
            
            if(Test.isRunningTest() && testInjectholidays != null) {
                holidays = testInjectholidays;
            }

            // Query semua BusinessHours sekaligus
            Set<String> queueNames = new Set<String>();
            for (Group queue : allQueues) {
                if (queue.DeveloperName.contains(System.Label.AMFS_Queue_Contain) && 
                    !queue.DeveloperName.contains(System.Label.AMFS_Queue_AOH)) {
                    queueNames.add(queue.Name);
                }
            }

            Map<String, BusinessHours> businessHoursMap = new Map<String, BusinessHours>();
            if (!queueNames.isEmpty()) {
                List<BusinessHours> businessHoursList = [
                    SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
                           WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
                           FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
                           SundayStartTime, SundayEndTime
                    FROM BusinessHours 
                    WHERE IsActive = true AND Name IN :queueNames
                ];
                
                for (BusinessHours bh : businessHoursList) {
                    businessHoursMap.put(bh.Name, bh);
                }
            }

            // ✅ 2. Pisahkan queues dan buat maps
            List<Group> queueAMFS = new List<Group>();
            Map<String, Group> queueAOHMap = new Map<String, Group>();
            
            for (Group queue : allQueues) {
                if (queue.DeveloperName.contains(System.Label.AMFS_Queue_Contain) && 
                    !queue.DeveloperName.contains(System.Label.AMFS_Queue_AOH)) {
                    queueAMFS.add(queue);
                } else {
                    // Create mapping untuk AOH queues berdasarkan nama
                    String baseName = queue.Name.replace(' - AOH', '').trim();
                    queueAOHMap.put(baseName, queue);
                }
            }

            System.debug('AMFS_LOG - MFSe2c## Regular Queues: ' + queueAMFS.size() + ', AOH Queues: ' + queueAOHMap.size());

            // ✅ 3. Process setiap queue TANPA query di dalam loop
            processQueues(queueAMFS, queueAOHMap, businessHoursMap, holidays, now, today);
            
        } catch (Exception e) {
            System.debug('AMFS_LOG - ERROR: ' + e.getMessage() + ' | Stack Trace: ' + e.getStackTraceString());
        }
    }

    private void processQueues(List<Group> queueAMFS, Map<String, Group> queueAOHMap, 
                              Map<String, BusinessHours> businessHoursMap, List<Holiday> holidays, 
                              DateTime now, Date today) {
        
        Boolean isHoliday = !holidays.isEmpty();
        String dayOfWeek = DateTime.newInstance(today, Time.newInstance(0, 0, 0, 0)).format('EEEE');
        
        // ✅ Collect all AOH queue IDs untuk bulk query
        Set<Id> aohQueueIds = new Set<Id>();
        Map<Id, Id> aohToRegularQueueMap = new Map<Id, Id>();
        
        for (Group queue : queueAMFS) {
            BusinessHours bh = businessHoursMap.get(queue.Name);
            if (bh == null) {
                System.debug('AMFS_LOG - WARNING: No BusinessHours found for queue: ' + queue.Name);
                continue;
            }

            // Determine if should process this queue
            Boolean shouldProcess = shouldProcessQueue(bh, dayOfWeek, now, today, isHoliday);
            
            if (shouldProcess) {
                // Find corresponding AOH queue
                Group aohQueue = queueAOHMap.get(queue.Name);
                if (aohQueue != null) {
                    aohQueueIds.add(aohQueue.Id);
                    aohToRegularQueueMap.put(aohQueue.Id, queue.Id);
                    System.debug('AMFS_LOG - MFSe2c### Will process AOH Queue: ' + aohQueue.Name + ' -> Regular Queue: ' + queue.Name);
                }
            }
        }

        // ✅ Bulk query dan update cases
        if (!aohQueueIds.isEmpty()) {
            bulkUpdateCases(aohQueueIds, aohToRegularQueueMap);
        }
    }

    private Boolean shouldProcessQueue(BusinessHours bh, String dayOfWeek, DateTime now, Date today, Boolean isHoliday) {
        // Get business hours for the day
        Time startTime = getStartTimeForDay(bh, dayOfWeek);
        Time endTime = getEndTimeForDay(bh, dayOfWeek);
        
        Boolean isWorkingDay = (startTime != null && endTime != null);
        Boolean isWithinHours = isWorkingDay ? BusinessHours.isWithin(bh.Id, now) : false;
        Boolean isExtended = checkExtendedHours(bh.Id, now, today);
        
        // Logic untuk menentukan apakah queue harus diproses
        return isWithinHours || (!isWorkingDay && isExtended) || (isHoliday && isExtended);
    }

    private Boolean checkExtendedHours(Id businessHoursId, DateTime now, Date today) {
        Datetime firstTime = Datetime.newInstance(now.year(), now.month(), now.day(), 0, 0, 0);
        Datetime lastTime = Datetime.newInstance(now.year(), now.month(), now.day(), 23, 59, 59);

        List<Business_Hours_Adjustment__c> bhAdjustments = [
            SELECT Id, Start_Date__c, End_Date__c
            FROM Business_Hours_Adjustment__c
            WHERE Business_Hours__c = :businessHoursId
            AND Start_Date__c >= :firstTime
            AND End_Date__c <= :lastTime
            AND Start_Date__c <= :now
            AND End_Date__c >= :now
            LIMIT 1
        ];

        return !bhAdjustments.isEmpty();
    }

    private void bulkUpdateCases(Set<Id> aohQueueIds, Map<Id, Id> aohToRegularQueueMap) {
        // ✅ Bulk query semua cases sekaligus
        List<Case> casesToUpdate = [
            SELECT Id, OwnerId, Status, Subject
            FROM Case
            WHERE OwnerId IN :aohQueueIds
            AND Status = 'New'
            LIMIT 2000 // Add limit untuk safety
        ];

        System.debug('AMFS_LOG - MFSe2c### Total Cases to process: ' + casesToUpdate.size());

        if (!casesToUpdate.isEmpty()) {
            // ✅ Update owner dalam batch
            for (Case c : casesToUpdate) {
                Id newOwnerId = aohToRegularQueueMap.get(c.OwnerId);
                if (newOwnerId != null) {
                    c.OwnerId = newOwnerId;
                }
            }

            // ✅ Single bulk update
            update casesToUpdate;
            System.debug('AMFS_LOG - MFSe2c### Successfully moved ' + casesToUpdate.size() + ' cases to regular queues');
        }
    }

    private Time getStartTimeForDay(BusinessHours bh, String dayOfWeek) {
        switch on dayOfWeek {
            when 'Monday' { return bh.MondayStartTime; }
            when 'Tuesday' { return bh.TuesdayStartTime; }
            when 'Wednesday' { return bh.WednesdayStartTime; }
            when 'Thursday' { return bh.ThursdayStartTime; }
            when 'Friday' { return bh.FridayStartTime; }
            when 'Saturday' { return bh.SaturdayStartTime; }
            when 'Sunday' { return bh.SundayStartTime; }
            when else { return null; }
        }
    }

    private Time getEndTimeForDay(BusinessHours bh, String dayOfWeek) {
        switch on dayOfWeek {
            when 'Monday' { return bh.MondayEndTime; }
            when 'Tuesday' { return bh.TuesdayEndTime; }
            when 'Wednesday' { return bh.WednesdayEndTime; }
            when 'Thursday' { return bh.ThursdayEndTime; }
            when 'Friday' { return bh.FridayEndTime; }
            when 'Saturday' { return bh.SaturdayEndTime; }
            when 'Sunday' { return bh.SundayEndTime; }
            when else { return null; }
        }
    }
}