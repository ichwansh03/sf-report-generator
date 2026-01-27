public class CallLineRescheduleAPI {
    public String userID = UserInfo.getUserId();
    public datetime newSchedule {get; set;}
    public Id callPick {get; set;}
    public Call_Line__c newCallDate {get; set;}
    public Call_Line__c currentCL {get; set;}
    public Boolean isAPI {get;set;}
    
    Id recTypeWC = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
    Id recTypeUW = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('TelUW').getRecordTypeId();
    
    public List<Call_Line__c> currentScheduleAtas {get; set;}
    public List<Call_Line__c> currentSchedule {get; set;}
    public List<Call_Line__c> duplicateReschedule {get; set;}
    
    //added by Fajar Salam 16/04/2022
    private boolean isTelUW;
    
    
    private Id clId;
    public String polNo {get;set;}
    public Boolean isRender {get;set;}
    public Boolean isRenderDateTime {get;set;}
    
    public Boolean detailStatus {get;set;}
    public Boolean reasonDetailStatus {get;set;}
    public Boolean isChecked {get;set;}
    public Boolean isCheckedDuplicateProgress {get;set;}
    public String activityDisabled {get;set;}
    private String statusBefore;
    
    public String redirectClId {get;set;}
    public String dateReschedule {get;set;}
    public Time timeRescheduleTime {get;set;}
    public String timeReschedule {get;set;}
    public Date dateRescheduleDate {get;set;}
    public String callLineSource {get;set;}
    
    public Map<String,String> newMap = new Map<String,String>();
    
    public CallLineRescheduleAPI(){
        
    }
    public void callLineRescheduleAPI(String polNo,Call_Line__c newCallLine){
        
        this.newCallDate = newCallLine;
        /*
         * edited by Fajar 16/04/2022
         * checking call no polis telUW
        */ 
        if(checkTelUWPolice(polNo)){
            this.polNo =  polNo.subString(0, polNo.indexOf('#'));
        }else{
             this.polNo = polNo;       
        }
        
        this.isChecked = true;
        this.isCheckedDuplicateProgress = true;
        callLineReschedulePage();
    }
    
    public Map<String,String> checkAvailibility(String polNo, String scheduleDate, String callLineSource){
        /*
         * edited by Fajar 16/04/2022
         * checking call no polis telUW
        */ 
        if(checkTelUWPolice(polNo)){
            this.polNo =  polNo.subString(0, polNo.indexOf('#'));
        }else{
             this.polNo = polNo;       
        }
        
        //this.polNo = polNo;
        this.dateReschedule = scheduleDate;
        this.isAPI = true;
        this.isChecked = false;
        this.callLineSource = callLineSource;
        this.isCheckedDuplicateProgress = scheduleDate != null && scheduleDate != '' ? true : false;
        callLineReschedulePage();
        return newMap;
    }
    
    //added by Fajar Salam 16/04/2022
    private boolean checkTelUWPolice(String noPolice){
        if(noPolice.contains('#TelUW')){
            isTelUW = true;
            return true;
        }
        isTelUW = false;
        return false;
    }
    // end added
    
    public void callLineReschedulePage(){
        //Faizir (08-04-2021)
        // from call line reschedule page
        List<String> calllinestringlist = new List<String>();
        List<SelectOption> tempOption = new List<SelectOption>();
        List<Contact> contactList = new List<Contact>();
        //callLineReschedulePage();
        
        // parameter ischecked untuk flagging bahwa polis ini sudah dicek untuk availability nya
        isChecked = isChecked != null ? isChecked : ApexPages.CurrentPage().getParameters().get('isCheck') != null ? Boolean.valueOf(ApexPages.CurrentPage().getParameters().get('isCheck')) : false;
        isAPI = isAPI != null ? isAPI : false;
        isCheckedDuplicateProgress = isCheckedDuplicateProgress != null ? isCheckedDuplicateProgress : false;
        //different format from API and CCC
        try{
            List<Call_Line__c> newCallLineList = new List<Call_Line__c>();
            
            if(polNo != null){
                contactList = [Select Id from Contact where Policy_No__c =: polNo limit 1];
                if(contactList.size() > 0){
                    // edited by Fajar salam 16/04/2022
                    // filtering for data TelUW
                    system.debug('[?] isTelUW = ' +isTelUW);
                    System.debug('[?] Polno = '+ PolNo);
                    if(isTelUW){
                        newCallLineList = new List<Call_Line__c>([SELECT Id, Name, Contact__r.name, Policy_No__c, Call_Date__c, WelcomeCall_Schedule_Date__C, WelcomeCall_Reference__c, OwnerId,
                                                              welcomecall_call_line_status__c, Call_Line_Status_TelUW__c, Activity_Result__c, Verification__c, WelcomeCall_Detail_Status__c,isWelcomeCallPeriod__c,
                                                              WelcomeCall_Reason_Detail_Status__c, Notes__c, WelcomeCall_Cooling_Off2__c
                                                              FROM Call_Line__c where policy_no__c =: polNo and recordtypeid =:recTypeUW]);
                    }else{
                        newCallLineList = new List<Call_Line__c>([SELECT Id, Name, Contact__r.name, Policy_No__c, Call_Date__c, WelcomeCall_Schedule_Date__C, WelcomeCall_Reference__c, OwnerId,
                                                              welcomecall_call_line_status__c, Activity_Result__c, Verification__c, WelcomeCall_Detail_Status__c,isWelcomeCallPeriod__c,
                                                              WelcomeCall_Reason_Detail_Status__c, Notes__c, WelcomeCall_Cooling_Off2__c
                                                              FROM Call_Line__c where policy_no__c =: polNo and WelcomeCall_Reference__c = null and recordtypeid =:recTypeWC]);
                    }
                    
                    
                    
                }else{
                    if(!isAPI){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Nomor Polis tidak ditemukan'));
                    }
                    newMap = new Map<String,String>();
                    newMap.put('402','Nomor Polis tidak ditemukan');
                }
            }
            System.debug('newCallLineList = :'+newCallLineList);
            if(newCallLineList.size() > 0){
                currentCL = newCallLineList[0];
                userID = newCallLineList[0].OwnerId;
                if(!currentCL.isWelcomeCallPeriod__c){
                    
                    newMap.put('403', 'Polis sudah melewati periode welcome call '+currentCL.WelcomeCall_Cooling_Off2__c.day()+'-'+currentCL.WelcomeCall_Cooling_Off2__c.month()+'-'+currentCL.WelcomeCall_Cooling_Off2__c.year());
                    if(!isAPI){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,'Polis sudah melewati periode welcome call'));
                    }
                    isRender = false;
                    return;
                }else{
                    // edited by Fajar salam 16/04/2022
                    // filtering for data TelUW
                    if(isTelUW){
                        duplicateReschedule = [SELECT Id, Name, Contact__r.name, Policy_No__c, Call_Date__c, WelcomeCall_Schedule_Date__C, WelcomeCall_Reference__c, OwnerId,
                                           welcomecall_call_line_status__c, Activity_Result__c, Verification__c, WelcomeCall_Detail_Status__c,isWelcomeCallPeriod__c,
                                           WelcomeCall_Reason_Detail_Status__c, Notes__c, WelcomeCall_Cooling_Off2__c,WelcomeCall_Hour_Schedule_Date__c  
                                           from Call_Line__c 
                                           where OwnerId =: userID
                                           and TelUW_Status_Call__c != 'Closed' and Policy_No__c = :polNo and recordtypeid =:recTypeUW ORDER BY createddate DESC];
                    }else{
                        duplicateReschedule = [SELECT Id, Name, Contact__r.name, Policy_No__c, Call_Date__c, WelcomeCall_Schedule_Date__C, WelcomeCall_Reference__c, OwnerId,
                                           welcomecall_call_line_status__c, Activity_Result__c, Verification__c, WelcomeCall_Detail_Status__c,isWelcomeCallPeriod__c,
                                           WelcomeCall_Reason_Detail_Status__c, Notes__c, WelcomeCall_Cooling_Off2__c,WelcomeCall_Hour_Schedule_Date__c  
                                           from Call_Line__c 
                                           where WelcomeCall_Fg_Schedule__c = TRUE and OwnerId =: userID
                                           and WelcomeCall_Call_Line_Status__c != 'Closed' and Policy_No__c = :polNo and recordtypeid =:recTypeWC ORDER BY createddate DESC];
                    }
                    
                    //controller.getRecord();
                    if(duplicateReschedule.size() > 0){
                        System.debug('[?] Data Duplicate !');
                        currentCL = duplicateReschedule[0];
                    }
                    
                    newCallDate = newCallDate == null ? new Call_Line__c() : newCallDate;//(Call_Line__c) controller.getRecord();
                    
                    if(currentCL.WelcomeCall_Call_Line_Status__c == 'Closed'){
                        activityDisabled = 'disabled';
                        //currentCL.Activity_Result__c = '';
                    }
                    if((currentCL.WelcomeCall_Detail_Status__c == null) || (currentCL.WelcomeCall_Detail_Status__c == ''))
                        detailStatus = false;
                    else
                        detailStatus = true;
                    
                    if((currentCL.WelcomeCall_Reason_Detail_Status__c == null) || (currentCL.WelcomeCall_Reason_Detail_Status__c == ''))
                        reasonDetailStatus = false;
                    else
                        reasonDetailStatus = true;
                        isRender = true;
                    if(dateReschedule != null && dateReschedule != ''){
                        try{
                            Datetime dtReschedule;
                            if(!isChecked){
                                if(!isAPI){
                                    dateRescheduleDate = dateRescheduleDate !=null ? dateRescheduleDate : Date.newInstance(Integer.valueOf(dateReschedule.substring(6,10)), Integer.valueOf(dateReschedule.substring(3,5)), Integer.valueOf(dateReschedule.substring(0,2)));
                                }else if(isAPI){
                                    System.debug('dateRescheduleDate :'+dateReschedule);
                                    dateRescheduleDate = dateRescheduleDate !=null ? dateRescheduleDate : Date.newInstance(Integer.valueOf(dateReschedule.substring(0,4)), Integer.valueOf(dateReschedule.substring(5,7)), Integer.valueOf(dateReschedule.substring(8,10)));
                                    dtReschedule = (Datetime) dateRescheduleDate;
                                    if(dtReschedule.format('EEE') == 'Sat' || dtReschedule.format('EEE') == 'Sun'){
                                        newMap = new Map<String,String>();
                                        newMap.put('404', 'Pilih waktu hanya dalam hari kerja');
                                        return;
                                    }
                                    if(dtReschedule > currentCL.WelcomeCall_Cooling_Off2__c){
                                        if(callLineSource == 'SMARTS'){
                                            if(!isAPI){
                                                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,'Polis sudah melewati masa cooling off. Tanggal Cooling Off ('+currentCL.WelcomeCall_Cooling_Off2__c.day()+'-'+currentCL.WelcomeCall_Cooling_Off2__c.month()+'-'+currentCL.WelcomeCall_Cooling_Off2__c.year()+')'));
                                            }
                                        }
                                        newMap.put('403', 'Tanggal yang dipilih sudah melewati masa cooling off untuk polis ini.(Tanggal Cooling Off : '+currentCL.WelcomeCall_Cooling_Off2__c.day()+'-'+currentCL.WelcomeCall_Cooling_Off2__c.month()+'-'+currentCL.WelcomeCall_Cooling_Off2__c.year()+'). Silahkan eskalasikan ke Sales Leader');
                                        return;
                                    }
                                }
                                if(dtReschedule <= Date.today()){
                                    System.debug('cannot call someone yesterday today.');
                                    system.debug('dtReschedule :'+dtReschedule);
                                    newMap = new Map<String,String>();
                                    if(!isAPI){
                                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Tidak bisa memilih hari sebelum hari ini atau pada hari ini.'));
                                    }
                                    newMap.put('405', 'Hari yang dipilih tidak valid. Silahkan memilih hari sesudah hari ini.');
                                    return;
                                }
                                
                                
                                // validasi untuk menampilkan jam available pada agent yang Welcome Call nya hendak direschedule
                                Date dateAfter = (dateRescheduleDate+1);
                                for(String hoursList : hourslList()){
                                    Decimal hourDec = Decimal.valueOf(hoursList);
                                    List<Call_Line__c> checkSchedule = new List<Call_Line__c>([SELECT Id FROM Call_Line__c WHERE WelcomeCall_Call_Line_Status__c != 'Closed' AND OwnerId =: userID and (WelcomeCall_Schedule_Date__c >= :dateRescheduleDate and WelcomeCall_Schedule_Date__c < :dateAfter) and WelcomeCall_Hour_Schedule_Date__c =: hourDec]);
                                    System.debug('size nya checkSchedule :'+checkSchedule.size());
                                    if(checkSchedule.size() < 4){
                                        if(!hoursList.equals('12')){
                                        	calllinestringlist.add(hoursList);
                                            tempOption.add(new SelectOption(hoursList,hoursList+':00-'+hoursList+':59'));
                                        }
                                    }
                                }
                                getHourList = tempOption;
                            }
                        }catch(Exception e){
                            newMap = new Map<String,String>();
                            newMap.put('500', e.getMessage()+' in line '+e.getLineNumber());
                            System.debug(e.getMessage()+' in line '+e.getLineNumber());
                            if(!isAPI){
                                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()+' in line '+e.getLineNumber()));  
                            }
                            return;
                        }   
                    }
                }
                System.debug('currentCL in line 225 '+currentCL);
                if(currentCL.WelcomeCall_Call_Line_Status__c == 'Closed'){
                    if(isAPI){
                        newMap = new Map<String,String>();
                        newMap.put('401', 'Tidak bisa mengganti jadwal karena proses Welcome Call pada polis ini sudah Closed');
                        return;
                    }
                    return;
                }else if(dateReschedule != null){
                    if(calllinestringlist.size() > 0){
                        newMap = new Map<String,String>();
                        newMap.put('204', 'Jadwal yang available pada jam : '+calllinestringlist);
                        return;
                    }else{
                        newMap = new Map<String,String>();
                        newMap.put('408', 'Jadwal di hari ini sudah penuh, silakan pilih tanggal lainnya');
                        return;
                    }
                    
                }else if(dateReschedule == null && duplicateReschedule.size()>0){
                    newMap = new Map<String,String>();
                    newMap.put('203', 'Polis ini sudah ada jadwal telpon pada tanggal '+currentCL.WelcomeCall_Schedule_Date__C.format('yyyy-MM-dd')+' '+currentCL.WelcomeCall_Hour_Schedule_Date__c+':00 - '+currentCL.WelcomeCall_Hour_Schedule_Date__c+':59 WIB, Apakah ingin diubah jadwal?');
                    return;
                }else if(dateReschedule == null && newCallDate.WelcomeCall_Schedule_Date__c == null){
                    newMap = new Map<String,String>();
                    newMap.put('205', 'Masukkan Jadwal Telepon');
                    return;
                }
                
            }else{
                newMap = new Map<String,String>();
                // edited by Fajar Salam 27-04-2022
                if(isTelUW){
                    newMap.put('406',checkTypePolis(polNo));
                }else{
                    if(!isAPI){
                    	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Nomor polis masih dalam proses pembentukan NAV (unit link)'));
                	}	
                    newMap.put('406','Nomor polis masih dalam proses pembentukan NAV (unit link)');
                }               
                
                return;
            }
        }catch(Exception e){
            if(!isAPI){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unknown Error. Line '+e.getLineNumber()));   
            }
            newMap = new Map<String,String>();
            newMap.put('500',e.getMessage()+' in line '+e.getLineNumber());
        }
    }
    // adding chcek Polis is MSW and not TeleUW
    // adding by Fajar salam Fajar Salam 27-04-2022
    public String checkTypePolis(String polis){
        String message = 'Polis dalam proses pembetukan call system';
        //check on MSW 
       List<Call_Line__c> callLineList = new List<Call_Line__c>([SELECT Id, Name, Contact__r.name, Policy_No__c, Call_Date__c, WelcomeCall_Schedule_Date__C, WelcomeCall_Reference__c, OwnerId,
                                                              welcomecall_call_line_status__c, Activity_Result__c, Verification__c, WelcomeCall_Detail_Status__c,isWelcomeCallPeriod__c,
                                                              WelcomeCall_Reason_Detail_Status__c, Notes__c, WelcomeCall_Cooling_Off2__c
                                                              FROM Call_Line__c where policy_no__c =: polis and WelcomeCall_Reference__c = null and recordtypeid =:recTypeWC]);
        if(callLineList == null || callLineList.size() <= 0){
            return message;
        }else{
            message = 'Polis tidak terdaftar Sebagai TeleUW';
            return message;
        }
    }
    
    public PageReference saveReschedule(Boolean isAPI, Call_Line__c newCallLineDate){
        newCallDate = newCallDate.WelcomeCall_Schedule_Date__c != null ? newCallDate : newCallLineDate;
        if(newCallDate.WelcomeCall_Schedule_Date__c == null && dateReschedule == null){
            newMap.put('405', 'Tidak ada tanggal yang dipilih.');
            if(!isAPI){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Tidak ada tanggal yang dipilih.'));
            }
            return null;
        }else if (dateReschedule != null){
            newCallDate.WelcomeCall_Schedule_Date__c = Datetime.valueOf(dateReschedule);
        }
        String dateStr = String.valueOf(newCallDate.WelcomeCall_Schedule_Date__c);
        String dateTerpilih = String.valueOf(newCallDate.WelcomeCall_Schedule_Date__c.date());
        String dayofDate = newCallDate.WelcomeCall_Schedule_Date__c.format('EEE');
        Integer timeofDate = Integer.valueOf(newCallDate.WelcomeCall_Schedule_Date__c.format('kk'));
        Integer minofDate = Integer.valueOf(newCallDate.WelcomeCall_Schedule_Date__c.format('mm'));
        String timeofDatestr = String.valueOf(timeofDate);
        String timeofDatestr2 = String.valueOf(timeofDate + 1);
        Datetime startSelector = Datetime.valueOf(dateStr.substring(0, 10)+' '+timeofDatestr+':00:00');
        Datetime endSelector = Datetime.valueOf(dateStr.substring(0, 10)+' '+timeofDatestr2+':00:00');
        Datetime now = Datetime.now();
        String minLabel = System.Label.Welcome_Call_Schedule_Duration;
        Integer hourofNow = now.hour();
        Integer minofNow = now.minute();
        String dateofNow = String.valueOf(now.date());
        Integer minuteDiff = Integer.valueOf(minLabel);
        List<AggregateResult> jadwalSebelumnya2 = new List<AggregateResult>();
        Integer jumlahJadwalSblmnya2 = 0;
        //validasi kalau minute nya bukan 0 maka dilakukan validasi existing
        if(minofDate > 0){
            Datetime selectedTimeStart = newCallDate.WelcomeCall_Schedule_Date__c;
            Datetime selectedTimeEnd = newCallDate.WelcomeCall_Schedule_Date__c.addMinutes(minuteDiff);
            
            jadwalSebelumnya2 = [SELECT count(id) from call_line__c 
                                                       WHERE ((OwnerId =: userID AND
                                                              WelcomeCall_Schedule_Date__c >=: selectedTimeStart AND
                                                              WelcomeCall_Schedule_Date__c <=: selectedTimeEnd)
                                                       OR (OwnerId =: userID AND 
                                                           endCall__c >=: selectedTimeStart AND
                                                           endCall__c <=: selectedTimeEnd)) and recordtypeid =:recTypeWC];
            
            Decimal hasiljdwalsblmnya2 = jadwalSebelumnya2[0].get('expr0')==null ? 0 : (decimal)jadwalSebelumnya2[0].get('expr0');
            jumlahJadwalSblmnya2 = hasiljdwalsblmnya2.intvalue();   
        }
        //add custom config for office hour and weekend
        // get top 1
        List<WelcomeCal_Schedule__c> scheduleHours = [Select Start_Hour__c, End_Hour__c, FgWeekend__c from WelcomeCal_Schedule__c];
        // end
        if(!scheduleHours.isEmpty()){
            if(isAPI){
                newCallDate.WelcomeCall_Schedule_Date__c = Datetime.valueOf(newCallDate.WelcomeCall_Schedule_Date__c.formatGmt('yyyy-MM-dd HH:mm:ss'));   
            }else{
                newCallDate.WelcomeCall_Schedule_Date__c = Datetime.valueOf(newCallDate.WelcomeCall_Schedule_Date__c.format('yyyy-MM-dd HH:mm:ss'));   
            }
            System.debug('after : '+newCallDate.WelcomeCall_Schedule_Date__c);
            
            if((dayofDate == 'Sun' || dayofDate == 'Sat') && scheduleHours.get(0).FgWeekend__c){
                System.debug('weekend day choosen');
                newMap.put('404', 'Pilih hari hanya dalam rentang hari kerja.');
                if(!isAPI){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Pilih hari hanya dalam rentang hari kerja.'));
                }
                return null;
            }
            if(newCallDate.WelcomeCall_Schedule_Date__c.time() < scheduleHours.get(0).Start_Hour__c.time() 
               || newCallDate.WelcomeCall_Schedule_Date__c.time() >= scheduleHours.get(0).End_Hour__c.time()){
                   System.debug('outside work hours');
                   newMap.put('407', 'Pilih waktu hanya dalam rentang jam kerja.');
                   if(!isAPI){
                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Pilih waktu hanya dalam rentang jam kerja.'));
                   }
                   return null;
               }   
        }
        System.debug('schedule date :'+newCallDate.WelcomeCall_Schedule_Date__c.date());
        System.debug('Date today :'+Date.today());
        System.debug('dateTerpilih :'+dateTerpilih);
        System.debug('dateofNow :'+dateofNow);
        System.debug('timeofDate :'+timeofDate);
        System.debug('hourofNow :'+hourofNow);
        System.debug('minofDate :'+minofDate);
        System.debug('minofNow :'+minofNow);
        if(jumlahJadwalSblmnya2 > 0){
            System.debug('previous schedule existed? '+jadwalSebelumnya2.size());
            System.debug(jadwalSebelumnya2);
            newMap.put('500', 'Sudah ada jadwal di jam ini.');
            if(!isAPI){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Sudah ada jadwal di jam ini.'));
            }
            return null;
        }
        
        Call_Line__c selectedSchedule = [SELECT Id, Name, Contact__c, Policy_No__c, Contacted_Number__c, Home_Phone__c, Phone__c, Other_Phone__c, Call_List__c, 
                                         Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, WelcomeCall_Criteria__c, WelcomeCall_Schedule_Date__c, WelcomeCall_Reschedule_Source__c,
                                         WelcomeCall_Call_Line_Status__c, Call_Date__c, OwnerId , Verification__c, RecordTypeId
                                         FROM Call_Line__c WHERE Id =: currentCL.Id ];
        
        Call_Line__c newSchedule = new Call_Line__c();
        
        List<Call_Line__c> newDuplicateReschedule = [SELECT Id, Name, Contact__c, Policy_No__c, Contacted_Number__c, Home_Phone__c, Phone__c, Other_Phone__c, Call_List__c, 
                                                  Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, WelcomeCall_Criteria__c, WelcomeCall_Schedule_Date__c, WelcomeCall_Reschedule_Source__c,
                                                  WelcomeCall_Call_Line_Status__c, Call_Date__c, OwnerId , Verification__c, RecordTypeId 
                                                  FROM Call_Line__c WHERE Policy_No__c =: selectedSchedule.Policy_No__c AND WelcomeCall_Reference__c =: selectedSchedule.Id AND WelcomeCall_Fg_Schedule__c = true order by createddate desc limit 1];
        
        if(newDuplicateReschedule.size()>0){
            selectedSchedule = newDuplicateReschedule[0];
            if(newDuplicateReschedule[0].WelcomeCall_Call_Line_Status__c == 'Closed'){
                newMap = new Map<String,String>();
                newMap.put('401', 'Tidak bisa mengganti jadwal karena Call Line pada polis ini sudah Closed');
                if(!isAPI){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Tidak bisa mengganti jadwal karena Call Line pada polis ini sudah Closed'));
                }
            }
        }
        
        newSchedule.Contact__c = selectedSchedule.Contact__c;
        newSchedule.Policy_No__c = selectedSchedule.Policy_No__c;
        newSchedule.Contacted_Number__c = selectedSchedule.Contacted_Number__c;
        newSchedule.Home_Phone__c = selectedSchedule.Home_Phone__c;
        newSchedule.Phone__c = selectedSchedule.Phone__c;
        newSchedule.Other_Phone__c = selectedSchedule.Other_Phone__c;
        newSchedule.Call_List__c = selectedSchedule.Call_List__c;
        newSchedule.Entity__c = selectedSchedule.Entity__c;
        newSchedule.Activity__c = selectedSchedule.Activity__c;
        newSchedule.Case_Type__c = selectedSchedule.Case_Type__c; 
        newSchedule.Case_Type_Config__c = selectedSchedule.Case_Type_Config__c;
        newSchedule.WelcomeCall_Schedule_Date__c = newCallDate.WelcomeCall_Schedule_Date__c;
        newSchedule.WelcomeCall_Criteria__c = selectedSchedule.WelcomeCall_Criteria__c;
        newSchedule.WelcomeCall_Fg_Round_Robin__c = True;
        newSchedule.WelcomeCall_Call_Line_Status__c = 'Progress';
        newSchedule.RecordTypeId = selectedSchedule.RecordTypeId;
        newSchedule.WelcomeCall_Reference__c = selectedSchedule.Id;
        newSchedule.OwnerId = selectedSchedule.OwnerId;
        newSchedule.WelcomeCall_Fg_Schedule__c = True;
        newSchedule.WelcomeCall_Reschedule_Source__c = newCallDate.WelcomeCall_Reschedule_Source__c;
        insertReschedule(selectedSchedule,newSchedule);
        return null;
    }
    
    public void insertReschedule(Call_Line__c selectedSchedule, Call_Line__c newSchedule){
        try{
            currentCL.WelcomeCall_Call_Line_Status__c = 'Closed';
            currentCL.Activity_Result__c = 'Contacted';
            currentCL.Verification__c = 'Reschedule';
            List<Call_line__c> upsertCL = New List<Call_line__c>();
            upsertCL.add(currentCL);
            upsertCL.add(newSchedule);
            
            upsert(upsertCL);
            
            currentCL.Activity_Result__c = '';
            newMap.put('200', 'Jadwal Berhasil Diganti.');
            if(!isAPI){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Jadwal berhasil diganti.'));
            }
            System.debug('dah insert dan update');
        } catch(Exception e){
            System.debug('oops : '+ e.getMessage()+ ' in line '+e.getLineNumber());
            newMap = new Map<String,String>();
            newMap.put('500', e.getMessage());
            if(!isAPI){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));   
            }
        }
    }
    
    /*
    public PageReference saveReschedule(){
        this.isAPI = false;
        Call_Line__c newCallLine = new Call_Line__c();
        String jamKerja = '';
        if(timeReschedule != null){
            jamKerja = (Integer.valueOf(timeReschedule) >= 12 ? timeReschedule+':00 PM' : timeReschedule+':00 AM');
        }
        dateReschedule = dateReschedule != null && dateReschedule != '' ? Datetime.parse(dateReschedule).format('yyyy-MM-dd HH:mm:ss') : jamKerja != '' ? (Datetime.parse(dateRescheduleDate.month()+'/'+(dateRescheduleDate.day())+'/'+dateRescheduleDate.year()+' '+jamKerja).format('yyyy-MM-dd HH:mm:ss')) :'';
        //return null;
        return saveReschedule(isAPI,newCallLine);
    }
	*/
    
    public Map<String,String> restSaveReschedule(String polNo, Boolean isAPI,Call_Line__c newCallLine){
        currentCL = new Call_Line__c();
        this.isAPI = isAPI;
        callLineRescheduleAPI(polNo, newCallLine);
        saveReschedule(isAPI,newCallLine);
        return newMap;
    }
    
    /*
     * Commented because this function is only work with Call Line Reschedule UI
    public PageReference UpdateCallLineStatus(){
        update currentCL;
        
        return null;
    }
    
    public PageReference redirectCallLine() { 
        //String value = apexpages.currentPage().getParameters().get('redClId');
        String value = System.currentPageReference().getParameters().get('redClId');
        system.debug('red '+value);
        PageReference ReturnPage = new PageReference('/'+value ); 
        ReturnPage.setRedirect(true); 
        return ReturnPage; 
    }
	*/
    
    public List<SelectOption> getHourList{get;set;}
    public List<SelectOption> getHourList(){
        List<SelectOption> tempList = new List<SelectOption>(getHourList);
        return tempList;
    }
    
    public List<String> hourslList() {
        List<String> tempList = new List<String>();
        tempList.add('08');
        tempList.add('09');
        tempList.add('10');
        tempList.add('11');
        tempList.add('12');
        tempList.add('13');
        tempList.add('14');
        tempList.add('15');
        tempList.add('16');
        return tempList;
    }
}