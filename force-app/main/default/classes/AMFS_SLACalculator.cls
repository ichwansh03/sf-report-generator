/**
 * @description       : Menghitung SLA untuk Close Case dan SLA Email Message
 * @author            : Ahmad Yazid Munif
 * @group             : 
 * @last modified on  : 08-14-2025
 * @last modified by  : Ahmad Yazid Munif
**/
public with sharing class AMFS_SLACalculator {
    @TestVisible private static String testFrom;
    @TestVisible private static Boolean testInjectAOH;
    @TestVisible private static DateTime testInjectResponse;
    @TestVisible private static List<EmailMessage> testInjectRelevant;
    @TestVisible private static Map<Date, Business_Hours_Adjustment__c> testInjectExtendHours;

    public static Map<Date, Holiday> loadedHolidaysByDate {get; set;}
    public static Map<Date, Business_Hours_Adjustment__c> extendHours {get; set;}
    public AMFS_SLACalculator() {
        loadedHolidaysByDate = new Map<Date, Holiday>();
        extendHours = new Map<Date, Business_Hours_Adjustment__c>();

    }
    
    public static String calculateSLAClosedCase(Case caseClosed, BusinessHours bHours){
        Case getDataCase = caseClosed;
        Boolean isAfterHours = false;
        Boolean isPaused = false;
        Boolean isHoliday = false;
        Boolean isRunning = false;
        // *create sabtu 24 Mei jam 21.37*
        DateTime createdDate = getDataCase.CreatedDate;
        isAfterHours = !caseClosed.AMFS_Receive_on_Business_Hours__c;
        DateTime responseDate = DateTime.Now();
        if (Test.isRunningTest()) {
            if(testInjectAOH != null){
                isAfterHours = testInjectAOH;
            }
        }
        if(Test.isRunningTest()){
            if(testInjectResponse != null){
                responseDate = testInjectResponse;
            }
        }
        
        Time startTime;
        Time endTime;

        DateTime startDateTemp = createdDate;
        Datetime startDate;
        Datetime endDate;
        Time tempSLA;
        List<Datetime> listStop = new List<Datetime>();
        List<Datetime> listStart = new List<Datetime>();
        while (startDateTemp < responseDate.addDays(1)) {
            String dayOfWeek = startDateTemp.format('EEEE');
            System.debug('AMFS dayOfWeek: '+dayOfWeek + bHours);
            List<Time> times = getNextBusinessDatetime(dayOfWeek, bHours);
            startTime = times[0];
            endTime = times[1];
            if(isAfterHours){
                System.debug('AMFS ClosedCase: this day '+startDateTemp);
                if(isCurrentlyHoliday(startDateTemp) || startTime == null){
                    if(startDateTemp.Date() == responseDate.Date()){
                        startDate = createdDate;
                        isAfterHours = false;
                        isRunning = true;
                        isHoliday = false;
                        System.debug('AMFS ClosedCase In Holiday '+dayOfWeek+', startTime : ' + startDateTemp+' endTime : ' + responseDate);
                        break;
                    }else{
                        System.debug('AMFS ClosedCase: this day isCurrentlyHoliday '+startDateTemp);
                        isHoliday = true;
                        startDateTemp = startDateTemp.addDays(1);
                        continue;
                    }
                }else{
                    DateTime endDateTimeFull = DateTime.newInstance(
                        startDateTemp.year(),
                        startDateTemp.month(),
                        startDateTemp.day(),
                        endTime.hour(),
                        endTime.minute(),
                        endTime.second()
                    );
                    System.debug('AMFS ClosedCase: this endDateTimeFull '+endDateTimeFull +' - '+startDateTemp);
                    if(startDateTemp>endDateTimeFull && startDateTemp.Date() != responseDate.Date()){
                        System.debug('AMFS ClosedCase: this time past BusinessHour '+startDateTemp);
                        startDateTemp = startDateTemp.addDays(1);
                        startDateTemp = DateTime.newInstance(
                            startDateTemp.year(),
                            startDateTemp.month(),
                            startDateTemp.day(),
                            startTime.hour(),
                            startTime.minute(),
                            startTime.second()
                        );
                        continue;
                    }else{
                        System.debug('AMFS ClosedCase: this time past BusinessHour closeCase else '+startDateTemp+' respond: '+responseDate);
                        if(responseDate>createdDate && 
                            responseDate>endDateTimeFull && createdDate.Date() == responseDate.Date()){
                            startDate = createdDate;
                        }else{
                            startDate = DateTime.newInstance(
                                startDateTemp.year(),
                                startDateTemp.month(),
                                startDateTemp.day(),
                                startTime.hour(),
                                startTime.minute(),
                                startTime.second()
                            );
                        }
                        isAfterHours = false;
                        isRunning = true;
                        isHoliday = false;
                        System.debug('AMFS ClosedCase nextDay '+dayOfWeek+', startTime : ' + startTime+' endTime : ' + endTime);
                        break;
                    }
                }
            }else{
                startDate = createdDate;
            }
            startDateTemp = startDateTemp.addDays(1);
        }
        System.debug('AMFS ClosedCase Selisih Waktu: ' +startDate + ' - '+responseDate);
        Long totalSlaAccumulated = getSlaBusinessMinutes(startDate, responseDate);
        String finalSLA = SLACalculator(totalSlaAccumulated);
        System.debug('AMFS ClosedCase Total: ' +finalSLA);
        return finalSLA;
    }
    
    public static Boolean isInBusinessHours(DateTime dateIncoming, BusinessHours bHours){
        Boolean isHours = BusinessHours.isWithin(bHours.Id, dateIncoming);
        System.debug('AMFS : isCurrentlyOvertime isHours '+isHours+bHours.Name);
        if(!isHours){
            System.debug('AMFS : overtime >>> '+isCurrentlyOvertime(bHours.Id,dateIncoming)+ '-' +dateIncoming);
            if(isCurrentlyOvertime(bHours.Id,dateIncoming)){
                isHours = true;
            }
        }else{
            if(isCurrentlyHoliday(dateIncoming)){
                isHours = false;
            }
        }
        System.debug('AMFS : create isInBusinessHours '+isHours);
        return isHours;
    }
    
    public static Datetime getOfficeHoursRespond(DateTime createdDateEmail, EmailMessage respondedEmail, BusinessHours bHours){

        Boolean isPaused = false;
        Boolean isHoliday = false;
        Boolean isRunning = false;
        DateTime createdDate = createdDateEmail;
        // Boolean isAfterHours = !BusinessHours.isWithin(bHours.Id, createdDate);
        Boolean isAfterHours = !respondedEmail.AMFS_Receive_on_Business_Hours__c;
        if (Test.isRunningTest()) {
            if(testInjectAOH != null && testFrom == 'SLACalculatorTest'){
                isAfterHours = testInjectAOH;
            }
        }
        DateTime responseDate = DateTime.Now();
        if(Test.isRunningTest()){
            if(testInjectResponse != null && testFrom == 'SLACalculatorTest'){
                responseDate = testInjectResponse;
            }
        }
        System.debug('AMFS >> isAfterHours'+isAfterHours +' - '+ createdDate);
        Time startTime;
        Time endTime;

        DateTime startDateTemp = createdDate;
        Datetime startDate;
        while (startDateTemp < responseDate.addDays(1)) {
            String dayOfWeek = startDateTemp.format('EEEE');
            List<Time> times = getNextBusinessDatetime(dayOfWeek, bHours);
            startTime = times[0];
            endTime = times[1];
            if(isAfterHours){
                System.debug('AMFS ClosedCase: this time isAfterHours if '+startDateTemp+' respond: '+responseDate);
                if(isCurrentlyHoliday(startDateTemp) || startTime == null){
                    if(startDateTemp.Date() == responseDate.Date()){
                        startDate = createdDate;
                        isAfterHours = false;
                        isRunning = true;
                        isHoliday = false;
                        System.debug('AMFS Response In Holiday '+dayOfWeek+', startTime : ' + startDateTemp+' endTime : ' + responseDate);
                        break;
                    }else{
                        System.debug('AMFS : this day isCurrentlyHoliday '+startDateTemp);
                        isHoliday = true;
                        startDateTemp = startDateTemp.addDays(1);
                        continue;
                    }
                }else{
                    DateTime endDateTimeFull = DateTime.newInstance(
                        startDateTemp.year(),
                        startDateTemp.month(),
                        startDateTemp.day(),
                        endTime.hour(),
                        endTime.minute(),
                        endTime.second()
                    );
                    System.debug('AMFS : this endDateTimeFull '+endDateTimeFull +' - '+startDateTemp + ' - ' +responseDate);
                    if(startDateTemp>endDateTimeFull && startDateTemp.Date() != responseDate.Date()){
                        System.debug('AMFS ClosedCase: this time isAfterHours else '+startDateTemp);
                        startDateTemp = startDateTemp.addDays(1);
                        startDateTemp = DateTime.newInstance(
                            startDateTemp.year(),
                            startDateTemp.month(),
                            startDateTemp.day(),
                            startTime.hour(),
                            startTime.minute(),
                            startTime.second()
                        );
                        continue;
                    }else{
                        System.debug('AMFS : this time past BusinessHour else '+startDateTemp + ' - '+responseDate);
                        if(responseDate>createdDate && 
                            responseDate>endDateTimeFull && createdDate.Date() == responseDate.Date()){
                            startDate = createdDate;
                        }else{
                            startDate = DateTime.newInstance(
                                startDateTemp.year(),
                                startDateTemp.month(),
                                startDateTemp.day(),
                                startTime.hour(),
                                startTime.minute(),
                                startTime.second()
                            );
                        }
                        isAfterHours = false;
                        isRunning = true;
                        isHoliday = false;
                        System.debug('AMFS next WorkingDay '+dayOfWeek+', startTime : ' + startTime+' endTime : ' + endTime);
                        break;
                    }
                }
            }else{
                startDate = createdDate;
            }
            startDateTemp = startDateTemp.addDays(1);
        }
        
        System.debug('AMFS : startDate '+startDate);
        return startDate;
    }
    public static Map<String, BusinessHours> getBHours(Map<String, String> groupList){
        List<String> valuesList = new List<String>();
        for (String value : groupList.values()) {
            valuesList.add(value);
        }
        // String valuesList = 'AMFS E2C - OH';
        Map<String, BusinessHours> bhMap = new Map<String, BusinessHours>();
        List<BusinessHours> bHours = [SELECT Id, Name,
            MondayStartTime, MondayEndTime,
            TuesdayStartTime, TuesdayEndTime,
            WednesdayStartTime, WednesdayEndTime,
            ThursdayStartTime, ThursdayEndTime,
            FridayStartTime, FridayEndTime,
            SaturdayStartTime, SaturdayEndTime,
            SundayStartTime, SundayEndTime
            FROM BusinessHours 
            WHERE Name IN :valuesList
        ];

        for (BusinessHours bh : bHours) {
            bhMap.put(bh.Name, bh);
        }
        System.debug('bHours List'+bhMap);

        Map<String, BusinessHours> finalBhMap = new Map<String, BusinessHours>();
        for (String key : groupList.keySet()) {
            String relevantName = groupList.get(key);
            System.debug('AMFS: relevantName'+relevantName);
            if (bhMap.containsKey(relevantName)) {
                BusinessHours foundBh = bhMap.get(relevantName);
                finalBhMap.put(key, foundBh);
            }
        }
        System.debug('finalBhMap'+finalBhMap);
        return finalBhMap;
    }

    public static void getBussinessHoursAdjusment(Datetime startDate, Datetime endDate) {
        extendHours = new Map<Date, Business_Hours_Adjustment__c>();
        List<Business_Hours_Adjustment__c> bhAdjustments = [
            SELECT Id, Name, Start_Date__c, End_Date__c, Business_Hours__c
            FROM Business_Hours_Adjustment__c
            WHERE Start_Date__c < :startDate
            AND End_Date__c > :endDate
        ];
        System.debug('AMFS >> exted startDate '+startDate + ' - '+ endDate);
        System.debug('AMFS >> bhAdjustments '+bhAdjustments);
        if(bhAdjustments.size()>0){
            for (Business_Hours_Adjustment__c bhExtend : bhAdjustments) {
                extendHours.put(bhExtend.Start_Date__c.date(), bhExtend);
            }
        }
    }
    public static Boolean isCurrentlyOvertime(String bhId, Datetime checkDatetime) {
        if (Test.isRunningTest()) {
            extendHours = testInjectExtendHours;
        }
        Date checkDate = checkDatetime.date();
        Integer currentHour = checkDatetime.hour();
        Integer currentMinute = checkDatetime.minute();
        System.debug('AMFS >> extendHours check'+extendHours);
        if (extendHours != null && extendHours.containsKey(checkDate)) {
            System.debug('AMFS >> extendHours containsKey '+extendHours);
            Business_Hours_Adjustment__c overtime = extendHours.get(checkDate);
            
            Boolean isWithinTimeRange = checkDatetime >= overtime.Start_Date__c && checkDatetime <= overtime.End_Date__c;
            return isWithinTimeRange;
        }
        return false; // Tidak ada overtime
    }
    public static void getFullHolidayDates(Datetime startD, Datetime endD) {
        Date startDate = startD.Date();
        Date endDate = endD.Date();
        loadedHolidaysByDate = new Map<Date, Holiday>();

        List<Holiday> holidaysInCaseRange = [
            SELECT Id, ActivityDate, StartTimeInMinutes, EndTimeInMinutes, IsAllDay 
            FROM Holiday 
            WHERE ActivityDate >= :startDate AND ActivityDate <= :endDate
        ];

        for (Holiday h : holidaysInCaseRange) {
            if(h.IsAllDay){
                loadedHolidaysByDate.put(h.ActivityDate, h);
            }
        }
    }
    public static Boolean isCurrentlyHoliday(Datetime checkDatetime) {
        Date checkDate = checkDatetime.date();
        Integer currentHour = checkDatetime.hour();
        Integer currentMinute = checkDatetime.minute();
        
        if (loadedHolidaysByDate != null && loadedHolidaysByDate.containsKey(checkDate)) {
            Holiday holiday = loadedHolidaysByDate.get(checkDate);
            return true;
        }
        return false; 
    }
    public static List<Time> getNextBusinessDatetime(String dayOfWeek, BusinessHours bHours) {
        Time startTime;
        Time endTime;
        if(dayOfWeek == 'Monday'){
            startTime = bHours.MondayStartTime;
            endTime = bHours.MondayEndTime;
        }else if(dayOfWeek == 'Tuesday'){
            startTime = bHours.TuesdayStartTime;
            endTime = bHours.TuesdayEndTime;
        }else if(dayOfWeek == 'Wednesday'){
            startTime = bHours.WednesdayStartTime;
            endTime = bHours.WednesdayEndTime;
        }else if(dayOfWeek == 'Thursday'){
            startTime = bHours.ThursdayStartTime;
            endTime = bHours.ThursdayEndTime;
        }else if(dayOfWeek == 'Friday'){
            startTime = bHours.FridayStartTime;
            endTime = bHours.FridayEndTime;
        }else if(dayOfWeek == 'Saturday'){
            startTime = bHours.SaturdayStartTime;
            endTime = bHours.SaturdayEndTime;
        }else if(dayOfWeek == 'Sunday'){
            startTime = bHours.SundayStartTime;
            endTime = bHours.SundayEndTime;
        }
        return new List<Time>{startTime, endTime};
    }
    public static Long getSlaBusinessMinutes(Datetime startT, Datetime endT){
        Long diffMs = endT.getTime() - startT.getTime();
        return diffMs;
    }
    public static Boolean SLAFlagCheckAMFS(AMFS_E2C_Setting__mdt slaSetting, Long diffMs){
        Boolean flag = false;
        Decimal slaHoursDecimal = slaSetting.SLA_Time_in_Hours__c;
        Long slaTargetInMs = (Long)(slaHoursDecimal * 60 * 60 * 1000);
        if (diffMs <= slaTargetInMs) {
            System.debug('Selisih waktu (' + diffMs + ' ms) kurang dari atau sama dengan ' + slaHoursDecimal + ' jam (' + slaTargetInMs + ' ms).');
            flag = true;
        } else {
            System.debug('Selisih waktu (' + diffMs + ' ms) lebih besar dari ' + slaHoursDecimal + ' jam (' + slaTargetInMs + ' ms).');
        }
        
        // Long threeHoursInMs = 3 * 60 * 60 * 1000;
        // Long sixHoursInMs = 6 * 60 * 60 * 1000; 
        // if(slaTarget == 'PBC'){
        //     if (diffMs <= threeHoursInMs) {
        //         System.debug('Selisih waktu kurang dari atau sama dengan 3 jam.');
        //         flag = true;
        //     }
        // } else {
        //     if (diffMs <= sixHoursInMs) {
        //         System.debug('Selisih waktu kurang dari atau sama dengan 6 jam.');
        //         flag = true;
        //     }
        // }
        return flag;
    }
    public static String SLACalculator(Long diffMs){
        // Konversi ke hari, jam, menit, detik
        Long diffSeconds = diffMs / 1000;
        Long diffMinutes = diffSeconds / 60;
        Long diffHours = diffMinutes / 60;
        Long diffDays = diffHours / 24;

        Long remainingHours = Math.mod(diffHours, 24);
        Long remainingMinutes = Math.mod(diffMinutes, 60);
        Long remainingSeconds = Math.mod(diffSeconds, 60);

        System.debug('diffMs'+diffMs);
        // System.debug('Selisih Waktu: ' + diffDays + ' hari, ' + remainingHours + ' jam, ' + remainingMinutes + ' menit, ' + remainingSeconds + ' detik');
        String wordingDuration = '';
        if(diffDays<1){
            if(remainingHours<1){
                wordingDuration = remainingMinutes + ' menit, ' + remainingSeconds + ' detik';
            }else{
                wordingDuration = remainingHours + ' jam, ' + remainingMinutes + ' menit, ' + remainingSeconds + ' detik';
            }
        }else{
            wordingDuration = diffDays + ' hari, ' + remainingHours + ' jam, ' + remainingMinutes + ' menit, ' + remainingSeconds + ' detik';
        }
        return wordingDuration;
    }
    public static Map<Id, List<EmailMessage>> getRelevantEmailMessagesByParentId(Set<Id> caseIds){
        Map<Id, List<EmailMessage>> emailMessagesByParentIdMap = new Map<Id, List<EmailMessage>>();
        List<EmailMessage> relevantEmailMessages;
        relevantEmailMessages = [
            SELECT Id, ParentId, CreatedDate, Incoming, ReplyToEmailMessageId,
                AMFS_First_Response_Time_Duration__c, AMFS_First_Forward_TIme_Duration__c, 
                AMFS_Receive_on_Business_Hours__c, AMFS_Handling_Time_Duration__c
            FROM EmailMessage 
            WHERE ParentId IN :caseIds 
            AND Incoming = TRUE
        ];
        // if (!Test.isRunningTest()) {
        //     relevantEmailMessages = [
        //         SELECT Id, ParentId, CreatedDate, Incoming, ReplyToEmailMessageId,
        //             AMFS_First_Response_Time_Duration__c, AMFS_First_Forward_TIme_Duration__c, 
        //             AMFS_Receive_on_Business_Hours__c, AMFS_Handling_Time_Duration__c
        //         FROM EmailMessage 
        //         WHERE ParentId IN :caseIds 
        //         AND Incoming = TRUE
        //     ];
        // }else{
        //     relevantEmailMessages = testInjectRelevant;
        // }
        for (EmailMessage email : relevantEmailMessages) {
            if (email.ParentId != null) {
                if (!emailMessagesByParentIdMap.containsKey(email.ParentId)) {
                    emailMessagesByParentIdMap.put(email.ParentId, new List<EmailMessage>());
                }
                emailMessagesByParentIdMap.get(email.ParentId).add(email);
            }
        }
        System.debug('EmailMessagesByParentIdMap created with ' + emailMessagesByParentIdMap + ' entries.');
        return emailMessagesByParentIdMap;
    }
    public static Long convertDurationStringToMs(String durationString) {
        if (String.isBlank(durationString)) {
            System.debug('Input duration string null.');
            return 0;
        }

        Long totalMilliseconds = 0L;
        Integer days = 0;
        Integer hours = 0;
        Integer minutes = 0;
        Integer seconds = 0;

        List<String> split = durationString.split(',');

        for (String part : split) {
            part = part.trim();
            if (part.contains('hari')) {
                String dayStr = part.replace('hari', '').trim();
                days = Integer.valueOf(dayStr);
            } else if (part.contains('jam')) {
                String hourStr = part.replace('jam', '').trim();
                hours = Integer.valueOf(hourStr);
            } else if (part.contains('menit')) {
                String minuteStr = part.replace('menit', '').trim();
                minutes = Integer.valueOf(minuteStr);
            } else if (part.contains('detik')) {
                String secondStr = part.replace('detik', '').trim();
                seconds = Integer.valueOf(secondStr);
            }
        }

        // Konversi ke milidetik
        totalMilliseconds += days * 24L * 60 * 60 * 1000; // Hari ke milidetik
        totalMilliseconds += hours * 60L * 60 * 1000;  // Jam ke milidetik
        totalMilliseconds += minutes * 60L * 1000;     // Menit ke milidetik
        totalMilliseconds += seconds * 1000L;          // Detik ke milidetik

        System.debug('AMFS totalMilliseconds: ' + totalMilliseconds);
        return totalMilliseconds;
    }
}