/* Adi Wijaya 20250609
 * Controller class to accommodate TelUW Rest API Logic
 */ 
public with sharing class CallLineTeluwHelper {

    public String FAILED_INVALID_DATE = 'Invalid Date / Time';
    public String ERROR_NO_CONTACT = 'Nomor Polis tidak ditemukan';
    public String ERROR_NO_CALL_LINE = 'Call Line tidak ditemukan';
    public String ERROR_DATE_EXPIRED = 'Tanggal sudah melewati masa cooling off: ';
    public String ERROR_DATE_WEEKEND = 'Mohon pilih Tanggal dalam rentang Hari Kerja';
    public String ERROR_HOUR_NOT_AVAIL = 'Tidak tersedia jadwal reschedule pada Tanggal ';
    public String ERROR_DATE_YESTERDAY = 'Tidak dapat reschedule pada tanggal [TODAY] atau sebelumnya, silakan pilih setelah tanggal tersebut';
    public String ERROR_POLICY_PASSED_TELUW = 'Polis sudah melewati periode TelUW';
    public String ERROR_CALL_LINE_CLOSED = 'Tidak bisa Reschedule karena call line sudah closed';
    public String ERROR_TELUW_RESCHEDULED = 'Call Line TelUW sudah dalam antrian Reschedule pada tanggal ';
    public String ERROR_AGENT_BUSY = 'Sudah ada jadwal Reschedule pada jam tersebut';
    public String ERROR_SYSTEM = 'Terjadi kesalahan pada system, silakan menghubungi Administrator';
    public String ERROR_GENERATE_CONTACT = 'Contact gagal dibentuk';
    public String ERROR_GENERATE_CALL_LINE = 'Call Line gagal dibentuk';
    public String ERROR_RESCHEDULE_CALL_LINE = 'Call Line gagal di-reschedule';
    public String STATUS_SUCCESS = '200';
    public String STATUS_DATE_ERROR = '401';
    public String STATUS_TIME_ERROR = '402';
    public String STATUS_NOT_FOUND = '404';
    public String STATUS_SERVER_ERROR = '501';
    public String STATUS_CALL_ERROR = '502';
    public String CREATE_MESSAGE_SUCCESS = 'success';

    public String AMFS = 'AMFS';
    public String TelUW = 'TelUW';
    public String WelcomeCall = 'Welcome Call';
    public String CALL_LINE_CLOSED = 'Closed';
    public String CALL_LINE_PROGRESS = 'Progress';
    public String CALL_LINE_OPEN = 'Open';
    public List<String> AllConfirmationPhase = new List<String>();
    public String WEEKEND = 'Saturday, Sunday';
    public String AUTOMATIC = 'Automatic';
    public Integer hourlyRescheduleLimit = Integer.valueOf(Label.TelUW_Hourly_Reschedule_Limit);
    public Account amfsAcc = [SELECT Id, MasterRecordId, Name, Type, OwnerId, CreatedDate, LastModifiedDate, Entity__c FROM Account where entity__c ='AMFS' and name = 'Account AMFS' limit 1];

    static ID telUWRtId = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('TelUW').getRecordTypeId();

    
    public class CallLineException extends Exception {}
    public class NoDataException extends Exception {}
    public class NoDateException extends Exception {}
    public class NoHourException extends Exception {}
    
    public CallLineTelUWHelper() {
        
    }
    
    public void init() {
        AllConfirmationPhase.add(TelUW);
        AllConfirmationPhase.add(WelcomeCall);
    }
    
    /* 
     * Create Contact and Request call TelUW Call Line
     */ 
    public CLTelUWWrapper.TelUWCallLineData requestTelUW(CLTelUWWrapper.Request telUWRequest) {
        init();
        DateTime nowDtDefault = DateTime.now();
        TimeZone tz = TimeZone.getTimeZone('Asia/Jakarta');
		String localTime = nowDtDefault.format('yyyy-MM-dd HH:mm:ss', tz.getID());
        DateTime nowDt = DateTime.valueOf(localTime);

        Date now = nowDt.Date();
        Time nowt = nowDt.Time();
        system.debug('==================== request teluw =====================');
        system.debug('nowDtDefault ==>' + nowDtDefault);
        system.debug('tz ==>' + tz);
        system.debug('localTime ==>' + localTime);
        system.debug('nowDt ==>' + nowDt);
        CLTelUWWrapper.TelUWCallLineData res = new CLTelUWWrapper.TelUWCallLineData();
        CampaignTelUW ctClass = new CampaignTelUW();
        List<Call_Line__c> checkClList;
        Call_Line__c checkCl;
        Call_Line__c resCl;
        Contact currentCont = doContact(telUWRequest);
        system.debug('currentCont ==> ' + currentCont);
        
        String caseType;
        String caseTypeConfig;
        String activity;
        Id campaignId;
        
        try {
            checkClList = [Select Id, ownerId, CreatedDate, Entity__c, Contact__c, Campaign_Type__c, Call_List__c, Case_Type__c, Case_Type_Config__c, Contacted_Number__c, Phone__c, Home_Phone__c, Other_Phone__c, Activity__c, Policy_no__c, Call_Line_Status_TelUW__c, TelUW_Status_Call__c, WelcomeCall_Call_Line_Status__c, Activity_Result__c, Verification__c, WelcomeCall_Detail_Status__c, WelcomeCall_Reason_Detail_Status__c, RecordTypeId, WelcomeCall_Schedule_Date__c, Reschedule_Date__c, Date_Reschedule__c, Time_Reschedule__c, WelcomeCall_Cooling_Off2__c, Call_Date__c FROM Call_Line__c WHERE Policy_no__c = :currentCont.Policy_No__c and recordType.Name = :AllConfirmationPhase and Entity__c = :currentCont.Entity__c ORDER BY CreatedDate DESC LIMIT 1];
            system.debug('checkClList ==> ' + checkClList);
            system.debug('checkClList size ==> ' + checkClList.size());
            checkCl = null;
            if (checkClList != null) {
                if (checkClList.size() >= 1) checkCl = checkClList[0];
            } 
            system.debug('checkCl ==> ' + checkCl);
            if (checkCl != null) {
                system.debug('=== Call Line Exists ===');
                resCl = checkCl;
            } else {
                system.debug('=== Create new Call Line ===');
                //ctClass.generateMonthlyCampaign(AUTOMATIC);
            
                // get current teluw campaign
                String formatName = TelUW;
                String monthNow = Datetime.now().format('yyMM');
                formatName = formatName + monthNow + AUTOMATIC;
            	system.debug('formatName ==> ' + formatName);
                List<Call_List__c> campaignDetail = [SELECT id, name, case_type__c,Case_Type_Config__c, Activity__c, Campaign_Name__c FROM Call_List__c WHERE Campaign_Name__c = :formatName AND WelcomeCall_Fg_Automatic__c = true LIMIT 1];
                system.debug('campaignDetail ==> ' + campaignDetail);
                
                if (campaignDetail != null & campaignDetail.size() > 0) {
                    campaignId = campaignDetail[0].Id;
                    caseType = campaignDetail[0].case_type__c;
                    caseTypeConfig = campaignDetail[0].Case_Type_Config__c;
                    activity = campaignDetail[0].Activity__c;
                } else {
                    Date next_month = now.addMonths(1);
                    Date expiry_date = Date.valueOf(next_month.year() + '-' + next_month.month() + '-' + System.Label.Welcome_Call_Expired_Days);
                    System.debug('[?][Format Name]' + formatName);
                    RecordType recId = ctClass.getRecordTypeId('Confirmation AMFS', 'Call_List__c');
                    
                    Call_List__c calist = new Call_List__c(Activity__c = 'Confirmation',
                                                       Campaign_Name__c = formatName, 
                                                       Case_Type_Config__c = TelUW,
                                                       Expired_Date__c = expiry_date,
                                                       Entity__c = AMFS,
                                                       RecordTypeId = recId.Id,
                                                       WelcomeCall_Fg_Automatic__c = true);
                    Database.insert(calist, false);
                    
                    campaignId = calist.ID;
                    caseType = calist.case_type__c;
                    caseTypeConfig = calist.Case_Type_Config__c;
                    activity = calist.Activity__c;
                }
            
                // check criteria and create call line
                List<Call_Line__c> newAutoCL = new List<Call_Line__c>();
                DateTime callDate = DateTime.now();
                Integer nowH = nowt.hour();
                Integer requestLimitH = Integer.valueOf(Label.Request_Limit_Time_Resch_TelUW);// 14
                system.debug('nowH ==>' + nowH);
                system.debug('requestLimitH ==>' + requestLimitH);
                if (nowH >= requestLimitH) {
                    Date callD = nowDt.Date().addDays(1);
                    Time callT = Time.newInstance(8,0,0,0);
                    callDate = DateTime.newInstance(callD, callT);
                }
                if(ctClass.checkApeExistInCriteria(currentCont.APE_TelUW__c, currentCont.Currency_TelUW__c, currentCont.Product_Code_Plant_TelUW__c)){
                	system.debug('=== generate Call Line ===');
                    Call_Line__c calin = new Call_Line__c(RecordTypeId = telUWRtId,
                                                          Contact__c = currentCont.Id,
                                                          Call_List__c = campaignId,
                                                          Call_Line_Status_TelUW__c = 'Open',
                                                          WelcomeCall_Call_Line_Status__c = 'Open',
                                                          Case_Type__c = caseType,
                                                          Case_Type_Config__c = caseTypeConfig,
                                                          Contacted_Number__c = currentCont.mobilePhone,
                                                          Phone__c = currentCont.phone,
                                                          Activity__c = activity,
                                                          Policy_no__c = currentCont.Policy_No__c,
                                                          //WelcomeCall_Schedule_Date__c = callDate,
                                                          call_date__c = callDate.Date(),
                                                          Entity__c = currentCont.Entity__c);
                    newAutoCL.add(calin);
            		system.debug('calin ==> ' + calin);
            		system.debug('newAutoCL ==> ' + newAutoCL);
                    
                    Database.insert(newAutoCL, false);
                    ctClass.roundRobinDist();
                    
                    calin.WelcomeCall_Schedule_Date__c = callDate;
                    Call_Line__c clTbu = new Call_Line__c();
                    clTbu.id = calin.Id;
                    clTbu.WelcomeCall_Schedule_Date__c = callDate;
                    Database.update(clTbu, false);
                    
                    resCl = calin;
                } else {
                	system.debug('=== criteria does not exists ===');
                    throw new SObjectException(ERROR_SYSTEM + ': ' + ERROR_GENERATE_CALL_LINE + '| Criteria Categorization failed. ');
                }
            } 
            
            system.debug('resCl ==>: ' + resCl);
            res.callLineStatus = resCl.TelUW_Status_Call__c;//res.callLineStatus = resCl.Call_Line_Status_TelUW__c;
            res.callStatus = resCl.Activity_Result__c;
            res.campaignType = getRecordTypeName(resCl);
            res.detailStatus = resCl.WelcomeCall_Detail_Status__c;
            res.policyNo = resCl.Policy_No__c;
            res.reasonDetailStatus = resCl.WelcomeCall_Reason_Detail_Status__c;
            res.reasonStatus = resCl.Verification__c;
            res.scheduleDate = String.valueOf(resCl.WelcomeCall_Schedule_Date__c); //resCl.Call_Date__c
        } catch (Exception e) {
            throw new SObjectException(ERROR_SYSTEM + ': ' + ERROR_GENERATE_CALL_LINE + '|' + e.getMessage() + '|' + e.getStackTraceString());
        }
        
        return res;
    }
    
    /* 
     * Reschedule TelUW Call Line
     */ 
    public void rescheduleTelUW(String policyNo, DateTime rescheduleDateTime, String note, String strSource) {
        init();
        Date rescheduleDate = rescheduleDateTime.Date();
        Time rescheduleTime = rescheduleDateTime.Time();
        String rescheduleTimeStr = String.valueOf(rescheduleDateTime.hour()).leftPad(2, '0') + ':' + String.valueOf(rescheduleDateTime.minute()).leftPad(2, '0');
        
        Contact c = getContactByPolicy(policyNo);
        Call_Line__c cl = getCallLineTelUWByPolicy(policyNo, rescheduleDate);
        if (cl == null) throw new NoDataException(ERROR_NO_CALL_LINE);
        
        // Call Line already passed to Wecall Phase
        String clRecordType = getRecordTypeName(cl);
        if (!clRecordType.equalsIgnoreCase(TelUW)) throw new CallLineException(ERROR_POLICY_PASSED_TELUW);
        
        // Call Line already closed 
        String callLineStatus = cl.TelUW_Status_Call__c;
        if (callLineStatus.equalsIgnoreCase(CALL_LINE_CLOSED)) throw new CallLineException(ERROR_CALL_LINE_CLOSED); 
        
        // Call Line already rescheduled
        if ((cl.Reschedule_Date__c != null && cl.TelUW_Status_Call__c == CALL_LINE_OPEN) || cl.TelUW_Status_Call__c == CALL_LINE_OPEN) {
            DateTime notValidDate = cl.Reschedule_Date__c == null ? (DateTime) cl.Call_Date__c : cl.Reschedule_Date__c;   
            String notValidDateStr = notValidDate.format('yyyy-MM-dd');
            throw new CallLineException(ERROR_TELUW_RESCHEDULED + notValidDateStr); 
        }
        
        checkWeekDays(rescheduleDate, cl.WelcomeCall_Schedule_Date__c);
        
        // Check agent's schedule
        List<Call_Line__c> agentClList = getAgentCallLineList(cl.OwnerId, rescheduleDate);
        if (agentClList != null) {
            Integer countCl = 0;
            for (Call_Line__c agentCl : agentClList) {
                if (agentCl.Time_Reschedule__c == rescheduleTimeStr) {
                    //throw new NoDateException(ERROR_AGENT_BUSY);
                    countCl++;
                }
            }
            if (countCl >= hourlyRescheduleLimit) throw new NoDateException(ERROR_AGENT_BUSY);
        }
        
        doReschedule(cl, rescheduleDateTime, rescheduleDate, rescheduleTimeStr, strSource, note);
    }
    
    /* 
     * check agent availability based on policy and reschedule date
     */ 
	public CLTelUWWrapper.CheckTimeAvailability getAvailabilityTime(String policyNo, Date checkDate) {
        init();
        CLTelUWWrapper.CheckTimeAvailability resData = new CLTelUWWrapper.CheckTimeAvailability();
        
        Call_Line__c cl = getCallLineTelUWByPolicy(policyNo, checkDate);
        if (cl == null) throw new NoDataException(ERROR_NO_CALL_LINE);
        checkWeekDays(checkDate, cl.WelcomeCall_Schedule_Date__c);
        List<String> timeAvailList = getAllTimeReschedule();
        List<String> timeAvailListNotSelected = new List<String>();
        List<Call_Line__c> agentClList = getAgentCallLineList(cl.OwnerId, checkDate);
        system.debug('agentClList ==> ' + agentClList);
        if (agentClList != null) {
            /*for (Call_Line__c agentCl : agentClList) {
                String timeResch = agentCl.Time_Reschedule__c;
                Integer listIndex = timeAvailList.indexOf(timeResch);
                system.debug('listIndex | timeResch ==> ' + listIndex + ' | ' + timeResch);
                timeAvailList.remove(listIndex);
            }*/
            for (String timeAvail : timeAvailList) {
                Integer taCount = 0;
                for (Call_Line__c agentCl : agentClList) {
                    if (agentCl.Time_Reschedule__c == timeAvail) taCount++; 
                }
                if (taCount < hourlyRescheduleLimit) timeAvailListNotSelected.add(timeAvail);
            }
        }
        system.debug('timeAvailList ==> ' + timeAvailList);
        
        if (timeAvailListNotSelected.size() == 0) throw new NoHourException(ERROR_HOUR_NOT_AVAIL + checkDate.format());
        resData.availibility = timeAvailListNotSelected;
        
        system.debug('resData ===>' + resData);
        
        return resData;
    }
    
    /* 
     * get recent Call Line data based on Policy
     */ 
    public CLTelUWWrapper.TelUWCallLineData getTelUW(String PolicyNo) {
        init();
        CLTelUWWrapper.TelUWCallLineData resData = new CLTelUWWrapper.TelUWCallLineData();
        Call_Line__c cl = getCallLineTelUWByPolicy(policyNo, null);
        if (cl == null) throw new NoDataException(ERROR_NO_CALL_LINE);
        String campaignType = getRecordTypeName(cl);
        DateTime scheduleDate = null;
        
        system.debug('Call Line ==> ' + cl);
        
        if (cl.Reschedule_Date__c == null && cl.Date_Reschedule__c == null && cl.Time_Reschedule__c == null) {
            scheduleDate = cl.WelcomeCall_Schedule_Date__c != null ? cl.WelcomeCall_Schedule_Date__c : cl.Call_Date__c;
        } else {
            if (cl.Date_Reschedule__c != null && cl.Time_Reschedule__c != null) {
                Date d = cl.Date_Reschedule__c;
                String[] tString = cl.Time_Reschedule__c.split(':');
                Time t = Time.newInstance(Integer.valueOf(tString[0]), Integer.valueOf(tString[1]), 0, 0);
                scheduleDate = DateTime.newInstance(d, t);
            } else {
                scheduleDate = cl.Reschedule_Date__c != null ? cl.Reschedule_Date__c : null;
            }
        }
        system.debug('Call Line ==> ' + scheduleDate);
        system.debug('campaignType ==> ' + campaignType);
        
        resData.policyNo = cl.Policy_No__c;
        resData.callLineStatus = campaignType == TelUW ? cl.TelUW_Status_Call__c : cl.WelcomeCall_Call_Line_Status__c;
        resData.callStatus = cl.Activity_Result__c;
        resData.reasonStatus = cl.Verification__c;
        resData.detailStatus = cl.WelcomeCall_Detail_Status__c;
        resData.reasonDetailStatus = cl.WelcomeCall_Reason_Detail_Status__c;
        resData.campaignType = campaignType;
        resData.scheduleDate = scheduleDate.format('yyyy-MM-dd HH:mm:ss');
 
        return resData;
    }
    
    /* 
     * get record type name
     */ 
    public String getRecordTypeName(Call_Line__c cl) {
        String recordTypeName = null;
        List<RecordType> checkRecordTypes = [SELECT Id, DeveloperName FROM RecordType WHERE Id = :cl.RecordTypeId];
        if (checkRecordTypes.size() > 0) {
            recordTypeName = checkRecordTypes[0].DeveloperName;
        }
        return recordTypeName;
    }
    
    /*
     * Get Available Reschedule Time
     */
    public List<String> getAllTimeReschedule() {
        List<String> ret = new List<String>();
        
        Schema.DescribeFieldResult fieldResult = Call_Line__c.Time_Reschedule__c.getDescribe();
        List<Schema.PicklistEntry> picklistValues = fieldResult.getPicklistValues();
        
        for (Schema.PicklistEntry entry : picklistValues) {
			String entrySt = entry.getLabel();
            String[] entrySta = entrySt.split(':');
            Integer hourEntry = Integer.valueOf(entrySta[0]);
            if (hourEntry >= 8 && hourEntry < 15 && hourEntry != 12) ret.add(entry.getLabel());
        }
        
        return ret;
	}
    
    public List<String> getAllTimeRescheduleNew() {
        system.debug('GET ALL AVAILABLE TIME');
        List<String> ret = new List<String>();
        
        Schema.DescribeFieldResult fieldResult = Call_Line__c.Time_Reschedule__c.getDescribe();
        List<Schema.PicklistEntry> picklistValues = fieldResult.getPicklistValues();
        
        for (Schema.PicklistEntry entry : picklistValues) {
			String entrySt = entry.getLabel();
            list<String> entrySta = entrySt.split(':');
            system.debug('entrySt==>' + entrySt);
            system.debug('entrySta ==>' + entrySta);
            Integer hourEntry = Integer.valueOf(entrySta[0]);
            Integer minuteEntry = Integer.valueOf(entrySta[1].trim());
            system.debug('hourEntry ==>' + hourEntry);
            system.debug('minuteEntry ==>' + minuteEntry);
            if (hourEntry >= 8 && hourEntry < 15 && hourEntry != 12 && minuteEntry == 0) ret.add(entry.getLabel());
        }
        
        return ret;
	}
    
    /*
     * Validate Weekend Date and cannot pick today or before
     */
    public void checkWeekDays(Date checkDate, DateTime scheduleDate) {
        system.debug('checkDate ==>' + checkDate);
        system.debug('scheduleDate ==>' + scheduleDate);
        DateTIme dtToday = DateTime.now();
        Date dToday = dtToday.Date();
        Time t = Time.newInstance(0,0,0,0);
        DateTime checkDT = DateTime.newInstance(checkDate, t); 
        String dayName = checkDT.format('EEEE');
        system.debug(dayName);
        
        if (checkDate <= dToday) throw new NoDateException(ERROR_DATE_YESTERDAY.replace('[TODAY]', String.valueOf(dToday))); 
        if (checkDate <= scheduleDate.Date()) throw new NoDateException(ERROR_DATE_YESTERDAY.replace('[TODAY]', String.valueOf(scheduleDate.Date()))); 
        if (WEEKEND.contains(dayName)) throw new NoDateException(ERROR_DATE_WEEKEND);
    }
    
    /*
     * Get A Contact data by Policy  
     */
    public Contact getContactByPolicy(String policyNo) {
        Contact c = new Contact();
        try {
            c = [SELECT Id, CreatedDate, Policy_No__c, Campaign_Type__c, WelcomeCall_Issued_Date__c, Issued_Date_TelUw__c FROM Contact WHERE Policy_No__c = :policyNo AND Entity__c = :AMFS LIMIT 1];
        } catch (Exception e) {
            throw new NoDataException(ERROR_NO_CONTACT);
        }
        return c;
    }
    
    /*
     * Get A Call Line data by Policy and check validate cooling off 
     */
    public Call_Line__c getCallLineTelUWByPolicy(String policyNo, Date checkDate) {
        system.debug('policyNo ==>' + policyNo);
        system.debug('checkDate ==>' + checkDate);
        system.debug('AllConfirmationPhase ==>' + AllConfirmationPhase);
        Call_Line__c cl = new Call_Line__c();
        try {
            cl = [Select Id, ownerId, CreatedDate, Entity__c, Contact__c, Call_List__c, Case_Type__c, Case_Type_Config__c, Contacted_Number__c, Phone__c, Home_Phone__c, Other_Phone__c, Activity__c, Policy_no__c, Call_Line_Status_TelUW__c, TelUW_Status_Call__c, WelcomeCall_Call_Line_Status__c, Activity_Result__c, Verification__c, WelcomeCall_Detail_Status__c, WelcomeCall_Reason_Detail_Status__c, RecordTypeId, WelcomeCall_Schedule_Date__c, Reschedule_Date__c, Date_Reschedule__c, Time_Reschedule__c, WelcomeCall_Cooling_Off2__c, Call_Date__c, WelcomeCall_Criteria__c, Currency__c FROM Call_Line__c WHERE Policy_no__c = :PolicyNo and recordType.Name = :AllConfirmationPhase and Entity__c = :AMFS ORDER BY CreatedDate DESC LIMIT 1];
        } catch(Exception e){
            //throw new NoDataException(ERROR_NO_CALL_LINE);
            cl = null;
        }
        
        if (checkDate != null) {
            Date coolingOffDate = cl.WelcomeCall_Cooling_Off2__c;
            String coolingOffDateSt = coolingOffDate.format();
            if (checkDate > cl.WelcomeCall_Cooling_Off2__c) throw new NoDateException(ERROR_DATE_EXPIRED + coolingOffDateSt);
        }
        
        return cl;
    }
    
    /*
     * Get Call Line list handled by an Agent on specific date
     */
    public List<Call_Line__c> getAgentCallLineList(String OwnerId, Date checkDate) {
        List<Call_Line__c> clList = new List<Call_Line__c>();
        try {
            clList = [Select Id, ownerId, CreatedDate, Policy_no__c, Reschedule_Date__c, Date_Reschedule__c, Time_Reschedule__c, WelcomeCall_Cooling_Off2__c FROM Call_Line__c WHERE ownerId = :OwnerId and recordType.Name = :TelUW and Date_reschedule__c = :checkDate and Entity__c = :AMFS];
        } catch (Exception e) {
            throw new NoDataException(ERROR_NO_CALL_LINE);
        }
        return clList;
    }

    public void doReschedule(Call_Line__c cl, DateTime dtResch, Date dResch, String tStrResch, String strSource, String note){
        try {
            Call_Line__c newCl = new Call_Line__c(ownerId = cl.OwnerId, 
                                                  Entity__c = cl.Entity__c, 
                                                  Contact__c = cl.Contact__c, 
                                                  Call_List__c = cl.Call_List__c, 
                                                  Case_Type__c = cl.Case_Type__c, 
                                                  Case_Type_Config__c = cl.Case_Type_Config__c, 
                                                  Contacted_Number__c = cl.Contacted_Number__c, 
                                                  Phone__c = cl.Phone__c, 
                                                  Home_Phone__c = cl.Home_Phone__c, 
                                                  Other_Phone__c = cl.Other_Phone__c, 
                                                  Activity__c = cl.Activity__c, 
                                                  Policy_no__c = cl.Policy_No__c, 
                                                  Call_Line_Status_TelUW__c = 'Open', 
                                                  WelcomeCall_Call_Line_Status__c = 'Open', 
                                                  RecordTypeId = cl.RecordTypeId, 
                                                  WelcomeCall_Schedule_Date__c = dtResch, 
                                                  Reschedule_Date__c = dtResch, 
                                                  Date_Reschedule__c = dResch, 
                                                  Time_Reschedule__c = tStrResch,
                                                  Notes__c = note,
                                                  WelcomeCall_Fg_Schedule__c = true,
                                                  Currency__c = cl.Currency__c,
                                                  WelcomeCall_Criteria__c = cl.WelcomeCall_Criteria__c,
                                                  WelcomeCall_Reschedule_Source__c = strSource);
            Database.insert(newCl, false);
            
            cl.Call_Line_Status_TelUW__c = 'Closed';
            cl.Activity_Result__c = 'Contacted';
            cl.Verification__c = 'Reschedule';
            update cl;
            
            doReminder(newCl);
            
        } catch(Exception e) {
            throw new SObjectException(ERROR_SYSTEM + ': ' + ERROR_RESCHEDULE_CALL_LINE + '|' + e.getMessage());
        }
    }
    
    public void doReminder(Call_Line__c cl){
        DateTime reminderDT = cl.WelcomeCall_Schedule_Date__c;
        reminderDT = reminderDT.addMinutes(-15);
        try {
            Event clReminder = new Event(WhatId = cl.Id, 
                                     Subject = 'Reschedule Call Line - ' + cl.Name + ' in 15 minutes', 
                                     ActivityDateTime = cl.WelcomeCall_Schedule_Date__c, 
                                     ActivityDate = cl.Date_Reschedule__c, 
                                     StartDateTime = cl.WelcomeCall_Schedule_Date__c, 
                                     EndDateTime = cl.WelcomeCall_Schedule_Date__c,
                                     Description = 'Reminder Schedule Call Line', 
                                     OwnerId = cl.OwnerId, 
                                     ReminderDateTime = reminderDT, 
                                     IsReminderSet = true,  
                                     Policy_No__c = cl.Policy_No__c);
            
            Database.insert(clReminder, false);
        } catch (Exception e) {
            throw new SObjectException(ERROR_SYSTEM + ': ' + ERROR_RESCHEDULE_CALL_LINE + '|' + e.getMessage());
        }
    }
    
    public Contact doContact(CLTelUWWrapper.Request reqCont) {
        List<Contact> checkContList; 
        Contact checkCont;
        system.debug('===== do Contact =====');
        system.debug('reqCont ==> ' + reqCont);
        try {
            checkContList = [SELECT Id, LastName, Policy_No__c, Policy_No_Numeric__c, Entity__c, Phone, MobilePhone, Email, Insured_Name__c, Insured_Email__c, PolicyApp__c, Product_Code_Plant_TelUW__c, Total_Premium__c, Premium__c, WelcomeCall_Payment_Type__c, WelcomeCall_Gender__c, Campaign_Type__c, Issued_Date_TelUw__c, APE_TelUW__c, Currency_TelUW__c FROM Contact WHERE Policy_No_Numeric__c = :reqCont.policyNoNumeric AND Entity__c = :reqCont.entity ORDER BY CreatedDate DESC limit 1];
            if (checkContList != null && checkContList.size() >= 1 ) checkCont = checkContList[0];
            system.debug('checkContList ==> ' + checkContList);
            if (checkCont == null) {
                
                Contact newCont = new Contact(AccountId = amfsAcc.Id,
                                              LastName = reqCont.lastName,
                                              Policy_No__c = reqCont.policyNo,
                                              Policy_No_Numeric__c = reqCont.policyNoNumeric,
                                              Entity__c = reqCont.entity,
                                              Phone = reqCont.phone,
                                              MobilePhone = reqCont.mobilePhone,
                                              Email = reqCont.email,
                                              Insured_Name__c = reqCont.insuredName,
                                              Insured_Email__c = reqCont.insuredEmail,
                                              PolicyApp__c = reqCont.policyApp,
                                              Product_Code_Plant_TelUW__c = reqCont.productCodePlan,
                                              Total_Premium__c = Decimal.valueOf(reqCont.totalPremium),
                                              Premium__c = Decimal.valueOf(reqCont.premium),
                                              WelcomeCall_Payment_Type__c = reqCont.paymentType,
                                              WelcomeCall_Gender__c = reqCont.gender,
                                              Campaign_Type__c = reqCont.campaignType,
                                              Issued_Date_TelUw__c = Date.valueOf(reqCont.issuedDate),
                                              APE_TelUW__c = Decimal.valueOf(reqCont.ape),
                                              Currency_TelUW__c = reqCont.contactCurrency);
                
                Database.insert(newCont, false);
                system.debug('newCont ===> ' + newCont);
                return newCont;
            } else {
                return checkCont;
            }
        } catch(Exception e) {
            throw new SObjectException(ERROR_SYSTEM + ': ' + ERROR_GENERATE_CONTACT);
        }
        
    }
}