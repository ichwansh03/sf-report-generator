/**
 * @description       : 
 * @author            : Sugeng Purnomo
 * @group             : 
 * @last modified on  : 07-30-2025
 * @last modified by  : Ahmad Yazid Munif
**/
global  class Sch_Case_CS_AO  implements Schedulable {
  @TestVisible private static Date testInjectDate;
  @TestVisible private static Boolean testInjectBHours;

  global void execute(SchedulableContext sc) {
    // Your logic here (e.g., update records, call batch class, etc.)
    System.debug('Scheduled job is running');


    List<Group> queueAMFS = new List<Group>();
    List<Group> queueAOH = new List<Group>();
    Id penampunganQueueId;
    
    String queueNameLike = '%' + System.Label.AMFS_Queue_Contain + '%';
    List<Group> queues = [
        SELECT Id, Name, DeveloperName
        FROM Group
        WHERE Type = 'Queue'
        AND Name LIKE :queueNameLike 
    ];

    System.debug('####AMFS que Size: ' + queues.size());
        for (Group queue : queues) {
        if (queue.DeveloperName.contains( System.Label.AMFS_Queue_Contain) && !queue.DeveloperName.contains(System.Label.AMFS_Queue_AOH)) { // atau gunakan DeveloperName jika lebih konsisten
                queueAMFS.add(queue);
            }else{
                queueAOH.add(queue);
            }
        }

        // if (queueAOH.isEmpty()) {
        //     System.debug('Queue tidak ditemukan.');
        //     return;
        // }
    System.debug('####AMFS queueAMFS Size: ' + queueAMFS.size());
    for (Group queue : queueAMFS) {
        System.debug('####AMFS Queue ID: ' + queue.Id + ', Name: ' + queue.Name);
        RecordType rt = [SELECT Id, Name FROM RecordType where SobjectType ='Case' and Name =:System.Label.AMFS_Case_Type
        LIMIT 200];
        System.debug('Record Type:'+ rt.Id);
        BusinessHours bh = [SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
                                    WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
                                    FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
                                    SundayStartTime, SundayEndTime
                            FROM BusinessHours 
                            WHERE IsActive = true AND Name = :queue.Name
                            LIMIT 1];
        System.debug('####AMFS is BusinessHours? '+ bh);

        
        // Define the target date (e.g., today, May 15, 2025, Thursday)
        Date targetDate = Date.today(); // Use Date.today() for dynamic scheduling

        if(Test.isRunningTest()){
            if(testInjectDate != null){
                targetDate = testInjectDate;
            }
            if(testInjectBHours == true){
                bh = null;
            }
        }

        if (bh == null) {
            System.debug('No active Business Hours found.');
            return;
        }
        
        // Get the day of the week (e.g., 'Thursday')
        DateTime targetDateTime = DateTime.newInstance(targetDate, Time.newInstance(0, 0, 0, 0));
        String dayOfWeek = targetDateTime.format('EEEE'); // Returns 'Thursday'
        // Map day to BusinessHours start and end times
        Time startTime;
        Time endTime;
        // if(Test.isRunningTest()){
        //     if(queue.Name == 'AMFS E2C - PBC'){
        //         dayOfWeek = 'Friday';
        //     } 
        // }
        switch on dayOfWeek {
            when 'Monday' {
                startTime = bh.MondayStartTime;
                endTime = bh.MondayEndTime;
            }
            when 'Tuesday' {
                startTime = bh.TuesdayStartTime;
                endTime = bh.TuesdayEndTime;
            }
            when 'Wednesday' {
                startTime = bh.WednesdayStartTime;
                endTime = bh.WednesdayEndTime;
            }
            when 'Thursday' {
                startTime = bh.ThursdayStartTime;
                endTime = bh.ThursdayEndTime;
            }
            when 'Friday' {
                startTime = bh.FridayStartTime;
                endTime = bh.FridayEndTime;
            }
            when 'Saturday' {
                startTime = bh.SaturdayStartTime;
                endTime = bh.SaturdayEndTime;
            }
            when 'Sunday' {
                startTime = bh.SundayStartTime;
                endTime = bh.SundayEndTime;
            }
            // when else {
            //     System.debug('Invalid day of week: ' + dayOfWeek);
            //     return;
            // }
        }

        // Check if business hours are defined for the day
       
        Boolean isWorkingDay = false;
        
        if (startTime == null || endTime == null) {
            System.debug('Business hours not defined for ' + dayOfWeek + '.');
            isWorkingDay = false;
        }else{
            System.debug('####AMFS SchCaseCSAO Business hours defined for ' + dayOfWeek + ': ' + startTime + ' to ' + endTime);
            isWorkingDay =  (startTime != null && endTime != null && startTime != endTime);
        }

        //set start end date of  current date
        Date today = Date.today();
        DateTime scheduledTime = DateTime.now(); // Use current time for scheduling
        // Jika scheduledTime setelah endDateTimeGMT, berarti after hours

        Boolean isHoliday = false;
        Boolean isExtended = false;
        // Query the Holiday object for today's date
        List<Holiday> holidays = [ SELECT Id, Name, ActivityDate,StartTimeInMinutes,EndTimeInMinutes,IsAllDay FROM Holiday WHERE ActivityDate = :today LIMIT 1 ];
        System.debug('holidays: ' + holidays.size());
        if (!holidays.isEmpty() ) {
            // If the list is not empty, it means today is a holiday
            isHoliday = true;
        }

        Datetime nowDT = Datetime.now();
        System.debug('####AMFS - Current DateTime: ' + nowDT);
        // Dapatkan tanggal awal dan akhir bulan ini
        Datetime firstTime = Datetime.newInstance(nowDT.year(), nowDT.month(), nowDT.day(), 0, 0, 0);

        Datetime lastTime = firstTime.addHours(24); // 24 hours later, minus 1 second
        // Query Business_Hours_Adjustment__c dalam rentang bulan ini
        System.debug('####AMFS SchCaseCSOH - First Time: ' + firstTime);
        System.debug('####AMFS SchCaseCSOH - Last Time: ' + lastTime);
        System.debug('####AMFS SchCaseCSOH - Business Hours ID: ' + bh.Id);
        System.debug('####AMFS SchCaseCSOH - Queue Name: ' + queue.Name);
        List<Business_Hours_Adjustment__c> bhAdjustments = [
            SELECT Id, Name, Start_Date__c, End_Date__c
            FROM Business_Hours_Adjustment__c
            WHERE Business_Hours__c = :bh.Id
            AND Start_Date__c  >= :firstTime
            AND End_Date__c <= :lastTime

        ];

        System.debug('####AMFS SchCaseCSOH - ' + queue.Name +' Business Hours Adjustments: ' + bhAdjustments.size());

        if (!bhAdjustments.isEmpty()) {
            // If the list is not empty, it means there are adjustments for business hours
    
            for (Business_Hours_Adjustment__c adj : bhAdjustments) {
                DateTime startDate = adj.Start_Date__c;
                DateTime endDate = adj.End_Date__c;
                
                System.debug('####AMFS SchCaseCSOH - Adjustment Start Date: ' + startDate);
                System.debug('####AMFS SchCaseCSOH - Adjustment End Date: ' + endDate);

                if (nowDT >= startDate && nowDT <= endDate) {
                    isExtended = true;
                    break;
                }
            }
            
        }
        System.debug('Is Extended: ' + isExtended);

        if(isWorkingDay == true  || isExtended == true) {

            Datetime scheduledTimeGMT = scheduledTime; // e.g., 2025-05-15 09:00:00 GMT

            Datetime startDateTimeWIB;
            Datetime endDateTimeWIB;
            // Initialize GMT DateTime variables
            Datetime startDateTimeGMT;
            Datetime endDateTimeGMT;
            Boolean isRunning = false;

            System.debug('#####AMFS Is Working Day: ' + isWorkingDay);
            System.debug('#####AMFS Is Extended: ' + isExtended);
              Boolean isAfterHours = !BusinessHours.isWithin(bh.Id, scheduledTimeGMT);
                System.debug('#####AMFS isAfterHours: ' + isAfterHours);
            if(isAfterHours  && isExtended == false) {
                System.debug('####AMFS Scheduled time is after business hours (after hours).');
                isRunning = true;
            } 
            if(isExtended == true) {
                System.debug('Sekarang adalah extended working day.');
                endDateTimeWIB = bhAdjustments[0].End_Date__c;     // e.g., 2025-05-15 17:00:00 WIB
                startDateTimeWIB = bhAdjustments[0].Start_Date__c; // e.g., 2025-05-15 09:00:00 WIB
                
                System.debug('#####AMFS Scheduled Time: ' + scheduledTime);
                System.debug('#####AMFS End DateTime WIB: ' + endDateTimeWIB);
                // Convert to GMT (WIB is UTC+7, so subtract 7 hours)
                if(Test.isRunningTest()){
                    scheduledTimeGMT = Datetime.newInstance(endDateTimeWIB.year(), endDateTimeWIB.month(), endDateTimeWIB.day(), endDateTimeWIB.hour(), endDateTimeWIB.minute(), endDateTimeWIB.second()).addSeconds(1);
                }
                System.debug('####AMFS scheduledTime custom :' +scheduledTime);
                
                if(scheduledTimeGMT > endDateTimeWIB) {
                    System.debug('Scheduled time is after business hours (after hours).');
                    isRunning = true;
                }
              
            }
            System.debug('isRunning: ' + isRunning);
            // Create custom DateTime range in WIB (UTC+7), then convert to GMT
            System.debug('Sekarang adalah jam kerja atau extended working Day.');
            System.debug('Start DateTime GMT: ' + startDateTimeGMT);
            System.debug('End DateTime GMT: ' + endDateTimeGMT);
            System.debug('Today Compare: ' + (scheduledTime > endDateTimeGMT));
            

            if (isRunning == true) {
                System.debug('####AMFS SchCaseCSOH Scheduled time is after business hours (after hours).');
                System.debug('####AMFS SchCaseCSOH Processing cases for after-hours queue: ' + queue.Id );
                System.debug('####AMFS SchCaseCSOH RecordTyope Id Name: ' + rt.Id + ' ' + rt.Name);
                // Process cases for after-hours queue
                List<Case> cases = [ SELECT Id, CaseNumber, Subject, Status, Priority, CreatedDate, AccountId, ContactId ,AMFS_SLA_Target__c
                            FROM Case 
                            WHERE IsDeleted = false 
                            AND Origin ='Email'
                            AND Status = 'New' 
                            AND AMFS_Receive_On_Business_Hours__c = false
                            AND RecordTypeId= :rt.Id 
                            AND ownerId= :queue.Id
                ];
                System.debug('####AMFS SchCaseCSOH Queue :' + queue.Name + ', Cases found: ' + cases.size());

                if (!cases.isEmpty()) {
    
                    Group afterHoursOwnerId;
                    for (Group qg : queueAOH) {
                        System.debug('####AMFS SchCaseCSOH qg.Name: ' + qg.Name);
                        System.debug('####AMFS SchCaseCSOH Queue AOH ID: ' + qg.Id + ', Name: ' + qg.Name);
                         //Check if the queue name contains the queue name from queueAMFS
                        System.debug('####AMFS SchCaseCSOH Queue OH: ' + queue.Id + ', Name: ' + queue.Name);
                        System.debug('####AMFS SchCaseCSOH Queue AOH ID: ' + qg.Id + ', Name: ' + qg.Name);

                        if(qg.Name.contains(queue.Name) ) {
                            afterHoursOwnerId = qg;
                            break;
                        }
                    }
    
                    for (Case c : cases) {
                        System.debug('After Hours Owner ID: ' + afterHoursOwnerId.Name);
                        c.OwnerId = afterHoursOwnerId.Id; // Set the owner to the after-hours queue
                        // Log case details (replace with your logic)
                        System.debug('Case Number: ' + c.CaseNumber + 
                                    ', Subject: ' + c.Subject + 
                                    ', Status: ' + c.Status + 
                                    ', CreatedDate: ' + c.CreatedDate + 
                                    ', Day: ' + dayOfWeek + 'Updated');
                        
                        // Add your processing logic here (e.g., update records, send notifications)
                    }
                    update cases;
                } 
            
            } 
        }
    }
  }
}