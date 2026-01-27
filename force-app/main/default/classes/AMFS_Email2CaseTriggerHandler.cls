/**
 * @description       : 
 * @author            : Sugeng Purnomo
 * @group             : 
 * @last modified on  : 08-04-2025
 * @last modified by  : Ahmad Yazid Munif
**/

public with sharing class AMFS_Email2CaseTriggerHandler {
    
    @TestVisible private static Boolean bypassTrigger = false;
    @TestVisible private static List<EmailMessage> testRelevantEmail;
    @TestVisible private static BusinessHours testInjectBhour;
    @TestVisible private static Boolean testInjectBhNull;
    @TestVisible private static Boolean isHoursMock = false;
    @TestVisible private static Date testInjectDate;
    @TestVisible private static Datetime testInjectCreatedDate;
    /**
     * Handle before insert events
     */

    public static void handleBeforeInsert(List<Case> newCases) {
        User userObj = [select id, Entity__c from user where id = :UserInfo.getUserId()];
        String entity = userObj.Entity__c;
        System.debug('####AMFS AMFS_Email2CaseTriggerHandler #### bypass: ' +  bypassTrigger);
        if(Test.isRunningTest()){
            if (bypassTrigger) {
                return;
            }
        }
        
        boolean isAMFS = false;
        Map<String, string> caseMot = new Map<String, string>();
        for(Case row :  newCases){  
            system.debug('####AMFS AMFS_Email2CaseTriggerHandler #### row:'+row.Entity__c);
            if (row.Entity__c == 'AMFS' || entity == 'AMFS') {
                isAMFS = true;
                String caseType= row.Case_Type__c;
                if (string.isblank(caseType)) caseType = row.Case_Type_Config__c;
                caseMot.put(caseType, '');
            } 
        } 
        
        system.debug('####AMFS AMFS_Email2CaseTriggerHandler #### isAMFS:'+isAMFS);
        
        if (isAMFS == true && caseMot.size() > 0) { 

            
            
            for(Case row :  newCases){  
                
                String CaseType = row.Case_Type__c;
          

           
                // Untuk Mengalih ke QUeue 
                RecordType rt = [SELECT Id, Name FROM RecordType where SobjectType ='Case' and Name =:System.Label.AMFS_Case_Type LIMIT 1];
           
                if(row.Origin == 'Email' && row.Status== 'New'  && row.RecordTypeId == rt.Id ) {
                    // Skip AMFS logic if new trigger handler is active
                    
                    List<Group> queueList = [
                        SELECT Id, Name, DeveloperName
                        FROM Group
                        WHERE Type = 'Queue'
                        AND Id = :row.OwnerId
                        LIMIT 1
                    ];
                    
                    
                    Group queue = queueList[0];

                    System.debug('####AMFS AMFS_Email2CaseTriggerHandler #### row.Owner.Name: ' + queue.Name);
                    BusinessHours bh = [
                        SELECT Id, Name, MondayStartTime, MondayEndTime, TuesdayStartTime, TuesdayEndTime,
                        WednesdayStartTime, WednesdayEndTime, ThursdayStartTime, ThursdayEndTime,
                        FridayStartTime, FridayEndTime, SaturdayStartTime, SaturdayEndTime,
                        SundayStartTime, SundayEndTime
                        FROM BusinessHours 
                        WHERE IsActive = true AND Name =:queue.Name LIMIT 1
                    ];

                    // Define the target date (e.g., today, May 15, 2025, Thursday)
                    Date targetDate = Date.today(); // Use Date.today() for dynamic scheduling

                    if(Test.isRunningTest()){
                        System.debug('####AMFS AMFS_Email2CaseTriggerHandler !! Inject found >> '+testInjectDate+' - '+testInjectCreatedDate);
                        if(testInjectDate != null){
                            targetDate = testInjectDate;
                        }
                        if(testInjectBhNull == true){
                            bh = null;
                        }
                    }
                    
                    if (bh == null) {
                        System.debug('####AMFS AMFS_Email2CaseTriggerHandler No active Business Hours found.');
                        return;
                    }
                    
                    // Get the day of the week (e.g., 'Thursday')
                    DateTime targetDateTime = DateTime.newInstance(targetDate, Time.newInstance(0, 0, 0, 0));
                    String dayOfWeek = targetDateTime.format('EEEE'); // Returns 'Thursday'
                    
                    // Map day to BusinessHours start and end times
                    Time startTime;
                    Time endTime;
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
                        //     System.debug('####AMFS AMFS_Email2CaseTriggerHandler Invalid day of week: ' + dayOfWeek);
                        //     return;
                        // }
                    }

                    Boolean isHours = true;
                    // Check if business hours are defined for the day

                    

                    if(Test.isRunningTest()){
                       
                        if(isHoursMock == false){
                            // Mocking for test purposes
                            // This is where you can set the startTime and endTime for testing
                            // For example, you can set them to null or specific times          
                            startTime = null; // Mock start time
                            endTime = null;
                        }
                    }
                    System.debug('####AMFS AMFS_Email2CaseTriggerHandler Business hours: ' + startTime + ' - ' + endTime);

                    if (startTime == null || endTime == null) {
                        System.debug('####AMFS AMFS_Email2CaseTriggerHandler Business hours not defined for ' + dayOfWeek + '.');
                        isHours = false;
                    }

                    Boolean isHoliday = false;
                    Boolean isExtended = false;
                    Date today = Date.today();
                    if(Test.isRunningTest()){
                        if(testInjectDate != null){
                            today = testInjectDate;
                        }
                    }
                    // Query the Holiday object for today's date
                    List<Holiday> holidays = [ SELECT Id, Name, ActivityDate,StartTimeInMinutes,EndTimeInMinutes,IsAllDay FROM Holiday WHERE ActivityDate = :today LIMIT 1 ];
                    System.debug('####AMFS AMFS_Email2CaseTriggerHandler holidays: ' + holidays.size());
                    if (!holidays.isEmpty() ) {
                        // If the list is not empty, it means today is a holiday
                        for (Holiday holiday : holidays) {
                            system.debug('####AMFS AMFS_Email2CaseTriggerHandler Holiday: ' + holiday.Name);
                            
                            if(holiday.isAllDay == true) {
                                // Check if the holiday is an all-day holiday
                                // Set the isHoliday flag to true
                                isHoliday = true;
                                system.debug('####AMFS AMFS_Email2CaseTriggerHandler isHoliday: ' + isHoliday);
                            } 
                            

                        }
                    }

                    //check the extended hours
                    System.debug('####AMFS AMFS_Email2CaseTriggerHandler ####AMFS CaseBeforeUpdate Business ID: ' + bh.Id);
                    System.debug('####AMFS AMFS_Email2CaseTriggerHandler ####AMFS CaseBeforeUpdate Now : ' + today);
                    
                    DateTime nowDT = System.now(); // Adjust for timezone if necessary
                    if(Test.isRunningTest()){
                        if(testInjectCreatedDate != null){
                            nowDT = testInjectCreatedDate;
                        }
                    }

                    System.debug('####AMFS AMFS_Email2CaseTriggerHandler Create Date on Case: ' + row.CreatedDate);
                    System.debug('####AMFS AMFS_Email2CaseTriggerHandler ####AMFS CaseBeforeUpdate Now DateTime: ' + nowDT);
                    List<Business_Hours_Adjustment__c> bhAdjustments = [
                        SELECT Id, Name, Start_Date__c, End_Date__c
                        FROM Business_Hours_Adjustment__c
                        WHERE Business_Hours__c = :bh.Id
                        AND Start_Date__c <= :nowDT
                        AND End_Date__c >= :nowDT
                        
                    ];

                    System.debug('####AMFS AMFS_Email2CaseTriggerHandler ####AMFS CaseBeforeUpdate bhAdjustments: ' + bhAdjustments.size());
                    // Cek apakah hari ini adalah extended day dan apakah sekarang di jam lembur
                   
                    if (!bhAdjustments.isEmpty()) {
                       isExtended = true;
                    }
                    System.debug('####AMFS AMFS_Email2CaseTriggerHandler ####AMFS CaseBeforeUpdate isExtended: ' + isExtended);
                    Id afterHoursOwnerId;
                    String likeAOH = '%' + queue.DeveloperName + '%';
                    System.debug('####AMFS AMFS_Email2CaseTriggerHandler like AOH: ' + queue.DeveloperName);
                    List<Group> queueAOHs = [
                        SELECT Id, Name, DeveloperName
                        FROM Group
                        WHERE Type = 'Queue'
                        AND DeveloperName LIKE :likeAOH
                        LIMIT 2
                    ];
                    for (Group qg : queueAOHs) {
                        System.debug('####AMFS AMFS_Email2CaseTriggerHandler Queue AOH ID: ' + qg.Id + ', Name: ' + qg.Name);
                        if(qg.DeveloperName.contains(System.Label.AMFS_Queue_AOH)) {
                            afterHoursOwnerId = qg.Id;
                            break;
                        }
                    }

                    
                    DateTime createdDate = System.now();
                    if(Test.isRunningTest()){
                        if(testInjectCreatedDate != null){
                            createdDate = testInjectCreatedDate;
                        }
                    }
                    Boolean isAfterHours = !BusinessHours.isWithin(bh.Id, createdDate);
                    // Check if the current time is outside business hours
                    System.debug('####AMFS AMFS_Email2CaseTriggerHandler !! '+createdDate + isAfterHours + ' isExtended ' + isExtended+ ' isHoliday ' + isHoliday);
                    System.debug('####AMFS AMFS_Email2CaseTriggerHandler ####AMFS CaseBeforeUpdate isAfterHours: ' + isAfterHours);
                    System.debug('####AMFS AMFS_Email2CaseTriggerHandler ####AMFS CaseBeforeUpdate isHours: ' + isHours);
                    
                    Boolean assignToAfterHours = false;

                    // 1. Jika hari ini holiday all day, langsung after hours
                    if (isHoliday && !isExtended) {
                        System.debug('####AMFS AMFS_Email2CaseTriggerHandler ### Holiday all day, assign to after hours');
                        assignToAfterHours = true;
                    }
                    // 2. Jika tidak ada jam kerja (isHours == false), after hours
                    else if (isHours == false && isExtended == false) {
                        System.debug('####AMFS AMFS_Email2CaseTriggerHandler ### No business hours defined, assign to after hours');
                        assignToAfterHours = true;
                    }
                    // 3. Jika di luar jam kerja (after hours) dan BUKAN jam lembur (extended), after hours
                    else if (isHours  && isAfterHours && isExtended == false) {
                        System.debug('####AMFS AMFS_Email2CaseTriggerHandler ### Outside business hours and not extended, assign to after hours');
                        assignToAfterHours = true;
                    }
                    // 4. Jika holiday + extended, tapi waktu sekarang TIDAK di jam lembur, after hours
                    // else if (isHoliday && isExtended == false) {
                    //     System.debug('####AMFS AMFS_Email2CaseTriggerHandler ### Holiday with extended but not in extended hours, assign to after hours');
                    //     assignToAfterHours = true;
                    // } 
                    // else if (isAfterHours == true && isExtended == true) {
                    //     // 4. Jika extended, tapi waktu sekarang di jam extended, tidak perlu after hours
                    //     System.debug('####AMFS AMFS_Email2CaseTriggerHandler ### Extended and within extended hours, do not assign to after hours');
                    //     assignToAfterHours = false;
                    // }
                    else {
                        System.debug('####AMFS AMFS_Email2CaseTriggerHandler #### Not after hours, do not assign to after hours');
                    }
                    
                    // 5. Jika extended, tapi waktu sekarang TIDAK di jam extended, after hours
                    // else if (isExtended == false && isAfterHours == true) {
                    //     System.debug('####AMFS AMFS_Email2CaseTriggerHandler ### Extended but outside extended hours, assign to after hours');
                    //     assignToAfterHours = true;
                    // } 

                    // Jika perlu debug
          
                    System.debug('####AMFS AMFS_Email2CaseTriggerHandler #### assignToAfterHours: ' + assignToAfterHours);
                    if (assignToAfterHours) {
                        // if(!Test.isRunningTest()){

                            row.OwnerId = afterHoursOwnerId;
                            row.BusinessHoursId = bh.Id;
                            // add by Yazid MII receive emailToCase
                            row.AMFS_Receive_on_Business_Hours__c = false;
                        // }
                    }else{
                        row.AMFS_Receive_on_Business_Hours__c = true;
                    }
                }
            } 
        }
    }
    
    /**
     * Handle before update events
     */
    public static void handleBeforeUpdate(List<Case> newCases, Map<Id, Case> oldCaseMap) {
        system.debug('####AMFS AMFS_Email2CaseTriggerHandler ------AMFS Update CloseCase START-------');
        Boolean isFirstResponse = false;
        boolean isEmailtoCaseClosed = false;
        Set<Id> caseIds = new Set<Id>();
        List<Datetime> createdDList = new List<Datetime>();
        RecordType recordType = [SELECT Id, Name FROM RecordType where SobjectType ='Case' and Name = 'AMFSEmailtoCase' LIMIT 1];

        for(Case row :  newCases){
            Case oldCase = oldCaseMap.get(row.Id);
            if (row.RecordTypeId == recordType.Id) {
                if(row.Status == 'Closed' && row.Status != oldCase.Status){
                    isEmailtoCaseClosed = true;
                    createdDList.add(row.CreatedDate);
                    caseIds.add(row.Id);
                }else if(oldCase.Email_First_Response_Date__c == null){
                    isFirstResponse = true;
                }
            }else{
                System.debug('####AMFS AMFS_Email2CaseTriggerHandler AMFS : Bukan EmailtoCase '+row.RecordTypeId+' - '+oldCase.RecordType.Name);
            }
        }
        System.debug('####AMFS AMFS_Email2CaseTriggerHandler AMFS : isEmailtoCaseClosed '+isEmailtoCaseClosed);
        if(isEmailtoCaseClosed){
            AMFS_SLACalculator slaCalculatorInitial = new AMFS_SLACalculator();
            Map<Id, List<EmailMessage>> caseIdToAllEmailMessagesMap = AMFS_SLACalculator.getRelevantEmailMessagesByParentId(caseIds);

            createdDList.sort();
            DateTime closedDate = DateTime.Now();
            DateTime lowestDatetime = createdDList[0];
            List<String> e2cEmailToAddress = new List<String>();
            for(Case row :  newCases){
                e2cEmailToAddress.add(row.e2cEmailToAddress__c);
            }
            
            AMFS_SLACalculator.getFullHolidayDates(lowestDatetime, closedDate);
            System.debug('####AMFS AMFS_Email2CaseTriggerHandler AMFS : Holiday >>> '+AMFS_SLACalculator.loadedHolidaysByDate);
            AMFS_SLACalculator.getBussinessHoursAdjusment(lowestDatetime, closedDate);
            System.debug('####AMFS AMFS_Email2CaseTriggerHandler AMFS : BussinessHoursAdjusment >>> '+AMFS_SLACalculator.extendHours);
            Map<String,String> ownerMap = new Map<String,String>();
            List<AMFS_E2C_Setting__mdt> emailtoCase = [SELECT Id, DeveloperName, MasterLabel, Email_Case__c, Business_Hour_Name__c FROM AMFS_E2C_Setting__mdt];
            System.debug('####AMFS AMFS_Email2CaseTriggerHandler AMFS : emailtoCase '+emailtoCase);
            
            for(AMFS_E2C_Setting__mdt setting : emailtoCase) {
                // ownerMap.put(setting.Email_Case__c,setting.MasterLabel);
                ownerMap.put(setting.MasterLabel,setting.Business_Hour_Name__c);
            }
            System.debug('####AMFS AMFS_Email2CaseTriggerHandler AMFS : ownerMap '+ownerMap);

            Map<String, BusinessHours> bhours = AMFS_SLACalculator.getBHours(ownerMap);
            System.debug('####AMFS AMFS_Email2CaseTriggerHandler AMFS : getBHours '+bhours);
            
            for(Case caseData :  newCases){
                Long totalSlaTargetMs = 0L;
                Integer emailCountWithSlaTarget = 0;
                List<EmailMessage> relevantEmails = caseIdToAllEmailMessagesMap.get(caseData.Id);
                if (Test.isRunningTest()) {
                    if(testRelevantEmail != null){
                        relevantEmails = testRelevantEmail;
                    }
                }
                if (relevantEmails != null && !relevantEmails.isEmpty()) {
                    System.debug('####AMFS AMFS_Email2CaseTriggerHandler AMFS : Memproses Case Id: ' + caseData.Id + ' dengan ' + relevantEmails.size() + ' email yang relevan.');
                    
                    for (EmailMessage email : relevantEmails) {
                        Long slaTargetMs = 0;
                        slaTargetMs = AMFS_SLACalculator.convertDurationStringToMs(email.AMFS_Handling_Time_Duration__c);

                        if (slaTargetMs != null) {
                            totalSlaTargetMs += slaTargetMs;
                            emailCountWithSlaTarget++;
                            System.debug('####AMFS AMFS_Email2CaseTriggerHandler AMFS : totalSlaTargetMs' + totalSlaTargetMs);
                        }
                    }
                } else {
                    System.debug('####AMFS AMFS_Email2CaseTriggerHandler AMFS : Tidak ada EmailMessage yang relevan (Incoming = TRUE) ditemukan untuk Case Id: ' + caseData.Id);
                }
                Long averageSlaTargetMs = 0;
                if (emailCountWithSlaTarget > 0) {
                    averageSlaTargetMs = totalSlaTargetMs / emailCountWithSlaTarget;
                    System.debug('####AMFS AMFS_Email2CaseTriggerHandler AMFS : Rata-rata AMFS_SLA_Target__c untuk Case ' + caseData.Id + ': ' + averageSlaTargetMs + ' ms');
                } else {
                    System.debug('####AMFS AMFS_Email2CaseTriggerHandler AMFS : Tidak ada AMFS_SLA_Target__c yang valid untuk dihitung rata-ratanya pada Case ' + caseData.Id);
                }
                System.debug('####AMFS AMFS_Email2CaseTriggerHandler AMFS : caseData.e2cEmailToAddress__c'+caseData.e2cEmailToAddress__c);
                System.debug('####AMFS AMFS_Email2CaseTriggerHandler AMFS : caseData.e2cEmailToAddress__c'+caseData.AMFS_SLA_Target__c);
                BusinessHours bhCloseCase = bhours.get(caseData.AMFS_SLA_Target__c);
                if (Test.isRunningTest()) {
                    if(testInjectBhour != null){
                        bhCloseCase = testInjectBhour;
                    }
                }
                System.debug('####AMFS AMFS_Email2CaseTriggerHandler AMFS : bhCloseCase');
                String slaEstimate = AMFS_SLACalculator.calculateSLAClosedCase(caseData, bhCloseCase);
                String timeAverage = AMFS_SLACalculator.SLACalculator(averageSlaTargetMs);
                System.debug('####AMFS AMFS_Email2CaseTriggerHandler AMFS : slaEstimate >>> '+slaEstimate);
                System.debug('####AMFS AMFS_Email2CaseTriggerHandler AMFS : averageSlaTargetMs >>> '+timeAverage+' - emailCount : '+emailCountWithSlaTarget);
                // pasang di field case : 
                caseData.AMFS_Total_Case_Time_Duration__c = slaEstimate; 
                caseData.AMFS_Average_Handling_Time_Duration__c = timeAverage;
            }
        }
        system.debug('####AMFS AMFS_Email2CaseTriggerHandler ------AMFS Update CloseCase END-------');
    }
    
}