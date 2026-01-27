public class callLineReschedule {
    public String userID = UserInfo.getUserId();
    public datetime newSchedule {get; set;}
    public Id callPick {get; set;}
    public Call_Line__c newCallDate {get; set;}
    public Call_Line__c currentCL {get; set;}
    
    Id recTypeWC = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
    public List<Call_Line__c> currentScheduleAtas {get; set;}
    public List<Call_Line__c> currentSchedule {get; set;}
    
    private Id clId;
    
    public Boolean detailStatus {get;set;}
    public Boolean reasonDetailStatus {get;set;}
    public String activityDisabled {get;set;}
    private String statusBefore;
    
    public String redirectClId {get;set;}
    
    
    
    private static final String IN_HOUSE = 'In House';
    
    
    // added by MII - Ranti at 15 nov 22    
        public Integer skip {get;set;}
        public Integer take {get;set;} 
        public Integer total_page {get;set;}
        public Integer current_page {get;set;}
        public Integer to_page {get;set;}
        public List<string> list_page {get;set;}
        
        public Long mulai {get;set;}
        public Long selesai {get;set;}
        public Integer totalRow {get;set;} 
        public Integer SIZE_DATA {get;set;}
        public List<Integer> LIST_SIZE_DATA {get;set;}
    	public String processTime {get;set;} 
  		public List<Call_Line__c> listData {get;set;}
    	Public String joinFilter {get;set;}
    
    	Public Integer noOfRecords{get; set;} 
    	public List<SelectOption> paginationSizeOptions{get;set;}
    
    public callLineReschedule(ApexPages.StandardController controller){
        String sizeDataLabel = Label.Call_Line_Resch_DataList_Size;
        SIZE_DATA = Integer.valueOf(sizeDataLabel);
        
        paginationSizeOptions = new List<SelectOption>();
        paginationSizeOptions.add(new SelectOption('1','1'));
        paginationSizeOptions.add(new SelectOption('3','3'));
        paginationSizeOptions.add(new SelectOption('5','5'));
        paginationSizeOptions.add(new SelectOption('10','10'));
        paginationSizeOptions.add(new SelectOption('20','20'));
        paginationSizeOptions.add(new SelectOption('50','50'));
        paginationSizeOptions.add(new SelectOption('100','100'));
        
        clId = ApexPages.CurrentPage().getParameters().get('id');
        currentCL = new Call_LIne__c();
        // change by MII at 21 09 2023
        /*currentCL = [SELECT Id, Name, Contact__r.name, Policy_No__c, Call_Date__c, WelcomeCall_Schedule_Date__C, WelcomeCall_Reference__c, OwnerId,
                        welcomecall_call_line_status__c, Activity_Result__c, Verification__c, WelcomeCall_Detail_Status__c,
                        WelcomeCall_Reason_Detail_Status__c, Notes__c
                               FROM Call_Line__c where id =: clId]; */
        
        currentCL = [SELECT Id, Name, Contact__r.name, Policy_No__c, Call_Date__c, WelcomeCall_Schedule_Date__C, WelcomeCall_Reference__c, OwnerId,
                        welcomecall_call_line_status__c, Activity_Result__c, Verification__c, WelcomeCall_Detail_Status__c,
                        WelcomeCall_Reason_Detail_Status__c, Notes__c, Entity__c, Confirm__c
                               FROM Call_Line__c where id =: clId];
        callPick = currentCL.Id;
        populateAllReponseFromPreviousTab(currentCL.Id);
        refresh();
        loadData();

        
        
        //currentScheduleAtas = new List<Call_Line__c>();
        //currentSchedule = new List<Call_Line__c>();
        currentScheduleAtas = [SELECT Id, Name, Contact__r.name, Policy_No__c, Call_Date__c, WelcomeCall_Schedule_Date__C, WelcomeCall_Reference__c, OwnerId 
                               FROM Call_Line__c 
                           WHERE WelcomeCall_Call_Line_Status__c = 'Open' AND WelcomeCall_Fg_Schedule__c = false
                           ORDER BY Name ASC LIMIT 10];
    
        /*currentSchedule = [select name,Contact__r.name, WelcomeCall_Schedule_Date__c, Policy_No__c, WelcomeCall_Reference__r.name
                           from Call_Line__c 
                           where WelcomeCall_Fg_Schedule__c = TRUE 
                           and WelcomeCall_Call_Line_Status__c != 'Closed' ORDER BY Name DESC LIMIT 10]; */
        
        //controller.getRecord();
        newCallDate = new Call_Line__c();//(Call_Line__c) controller.getRecord();
        
        // readonly and call line status is closed
        statusBefore = currentCL.WelcomeCall_Call_Line_Status__c;
        activityDisabled = '';
        if(currentCL.WelcomeCall_Call_Line_Status__c == 'Closed'){
            activityDisabled = 'disabled';
            //currentCL.Activity_Result__c = '';
        }
        currentCL.WelcomeCall_Call_Line_Status__c = 'Closed'; // default jadi Closed
            
        if((currentCL.WelcomeCall_Detail_Status__c == null) || (currentCL.WelcomeCall_Detail_Status__c == ''))
            detailStatus = true;
        else
            detailStatus = false;
        
        if((currentCL.WelcomeCall_Reason_Detail_Status__c == null) || (currentCL.WelcomeCall_Reason_Detail_Status__c == ''))
            reasonDetailStatus = true;
        else
            reasonDetailStatus = false;
        System.debug('currentCL '+currentCL);
    }
    
    private void populateAllReponseFromPreviousTab(Id callId){
        List<Survey_Response__c> res = [SELECT WelcomeCall_Address_1__c, WelcomeCall_Address_2__c, WelcomeCall_Address_3__c, WelcomeCall_Address_4__c, 
                                    WelcomeCall_Email__c, WelcomeCall_Others__c, Answer_1__c, Answer_2__c,Answer_3__c ,Answer_4__c , WelcomeCall_Section__c, WelcomeCall_Tab__c,
                                    WelcomeCall_Note__c, Question_1__c
                                 FROM Survey_Response__c
                                 WHERE WelcomeCall_Call_Line__c = :callId and Answer_1__c <> null order by Question_1__c, createddate asc];
        Integer i=1;
        System.debug('count s'+res);
        Boolean isContacted = false;
        for(Survey_Response__c r : res){
            System.debug('r.Answer_1__c '+r.Answer_1__c+' '+r.Answer_2__c);
            //String tempStr='';
            if(r.WelcomeCall_Section__c == 'Pembuka'){
                currentCL.Activity_Result__c = r.Answer_1__c;
                if(r.Answer_1__c == 'Uncontacted'){
                    isContacted = true;
                    System.debug('isContacted '+isContacted);
                }
            }
            if((i == 2 || (i== 1 && r.Answer_2__c != null)) && isContacted){
                System.debug('count '+i);
                String tempStr = (i == 2 && r.Answer_1__c != null) ? r.Answer_1__c : r.Answer_2__c;
                currentCL.Verification__c = tempStr;
            }
            if((i ==3 || (i== 2 && r.Answer_2__c != null)) && isContacted){
                String tempStr = (i == 3 && r.Answer_1__c != null) ? r.Answer_1__c : r.Answer_2__c;
                currentCL.WelcomeCall_Detail_Status__c = tempStr;

            }
            if((i ==4 || (i== 3 && r.Answer_2__c != null)) && isContacted){
                String tempStr = (i == 4 && r.Answer_1__c != null) ? r.Answer_1__c : r.Answer_2__c;
                currentCL.WelcomeCall_Reason_Detail_Status__c = tempStr;
            }

            if(r.WelcomeCall_Note__c != null){
                currentCL.Notes__c = currentCL.Notes__c == null ? '': currentCL.Notes__c;
                currentCL.Notes__c = currentCL.Notes__c +' '+r.WelcomeCall_Note__c;
            }
            i++;
            
        }
    }
    
    public List<SelectOption> getcallOptions(){
        List<SelectOption> callOptions = new List<SelectOption>();
        callOptions.add(new selectOption(' ','- None -'));
        for(Call_Line__c call : currentScheduleAtas){
            callOptions.add(new SelectOption (call.Name, call.Name + ' - ' + call.Contact__r.name));
        }
        
        return callOptions;
    }    
        
    // added by MII - Ranti at 15 nov 22    
        Public void loadData() {
            mulai =  DateTime.now().getTime();
            
        	currentSchedule = new List<Call_Line__c>();
                         
        	currentSchedule = [select name,Contact__r.name, WelcomeCall_Schedule_Date__c, Policy_No__c, WelcomeCall_Reference__r.name
                           from Call_Line__c 
                           where WelcomeCall_Fg_Schedule__c = TRUE and OwnerId =: userID
                           and WelcomeCall_Call_Line_Status__c != 'Closed' ORDER BY WelcomeCall_Schedule_Date__C DESC Limit :SIZE_DATA offset :skip ];
           
            system.debug('LIMIT:'+take);
            system.debug('OFFSET:'+skip);
      		System.debug('currentSchedule:'+currentSchedule);
        	totalRow = 0;
            if (currentSchedule.size() > 0  ) {
                	//totalRow = currentSchedule.size();
                	String queryTotal = 'SELECT COUNT(id) intVal FROM Call_Line__c where WelcomeCall_Fg_Schedule__c = TRUE and OwnerId = \''+userID+'\' and WelcomeCall_Call_Line_Status__c != \'Closed\'';
                	System.debug('queryTotal:'+queryTotal);
                    for(AggregateResult result :Database.query(queryTotal))
                    {
                        totalRow+=(Integer)result.get('intVal');
                    }
                    system.debug('total:'+totalRow);
                    total_page = totalRow/SIZE_DATA;  
                    system.debug('total_page:'+total_page);
                    list_page = showListPagination();
                    system.debug('list_page:'+list_page);
                }
			selesai =  Datetime.now().getTime();
        	system.debug('current_page == '+current_page);
        	system.debug('selesai == '+selesai);
        	processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
        	processTime += '<br/>Total : ' + totalRow + ' records';
        	system.debug('processTime == '+processTime);
 
        }
    
        public void refresh(){  
            processTime = ''; 
            totalRow = 0;
            skip = 0;
            current_page = 1; 
            total_page = 1; 
            to_page = 0;
            take = SIZE_DATA;
            list_page = new List<String>();      
        }
        
        public void getDataNext(){
            system.debug('next');
            to_page = current_page + 1;
            skip = (to_page - 1) * SIZE_DATA + 1;
            current_page = to_page;
            take = to_page * SIZE_DATA;   
            loadData();
        }
         
        public void getDataPrevious(){
            to_page = current_page - 1;
            skip = (to_page - 1) * SIZE_DATA + 1;
            current_page = to_page;
            take = to_page * SIZE_DATA;  
            loadData();
        }
         
        public void getDataToPage(){ 
            skip = (to_page - 1) * SIZE_DATA + 1;
            current_page = to_page;
            take = to_page * SIZE_DATA;  
            loadData();
        }
        
        public void getDataFirst(){
            skip = 0;
            current_page = 1;
            take = SIZE_DATA;  
            loadData();
        }
        
        public void getDataLast(){
            to_page = total_page;
             skip = (to_page - 1) * SIZE_DATA + 1;
             current_page = to_page;
             take = to_page * SIZE_DATA;  
            loadData();
        } 
        
        public List<String> showListPagination() {
            
            List<string>  ShowPaginate = new List<string>();
            integer nilaiAwal  = 0;
            integer nilaiAkhir = 0;
             
            if ( (current_page != null && current_page > 0) && (total_page != null && total_page > 0)) {
                Decimal middletotal_page = ((double) total_page)/current_page; 
                if (current_page == 1) { 
                    if (total_page > current_page) {
                        nilaiAwal = current_page;
                        if (total_page > 1) nilaiAkhir = current_page+1;
                        if (total_page > 2) nilaiAkhir = current_page+2; 
                    } else { 
                        nilaiAwal = current_page;
                        nilaiAkhir = current_page;
                    }
                } else if (middletotal_page > 0) { 
                    if (current_page == total_page) {  
                        nilaiAkhir = current_page; 
                        if (current_page > 0) nilaiAwal = current_page-1;
                        if (nilaiAwal > 1) nilaiAwal = current_page-2;  
                    } else {                  
                        nilaiAwal = current_page-1; 
                        nilaiAkhir = current_page+1; 
                    }
                } 
                
                for (integer i = nilaiAwal; i <= nilaiAkhir; i++) {
                    ShowPaginate.add(string.valueOf(i));
                } 
                /*  for (integer i = 1; i <= total_page; i++) {
                    ShowPaginate.add(string.valueOf(i));
                } */
            } 
            return ShowPaginate;
        } 
    
    // end of Added
    
    /*public List<SelectOption> getCallTime(){
        List<SelectOption> callTime = new List<SelectOption>();
        integer menit = 1;
        for(Integer i = 0; i<7; i++){
            
        }
    }*/
    
    public PageReference saveReschedule(){
        
        System.debug('callPick: ' + callPick);
        System.debug('newCallDate: ' + newCallDate.WelcomeCall_Schedule_Date__c);
        
       /** if(statusBefore == 'Closed'){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Status call line sudah pernah Closed, perubahan data tidak disimpan.'));
            return null;
        }*/
        
        if(callPick == null){
            System.debug('no call line selected');
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Tidak ada Call Line yang dipilih.'));
            return null;
        }
        if(newCallDate.WelcomeCall_Schedule_Date__c == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Tidak ada tanggal yang dipilih.'));
            return null;
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
        Integer minuteDiff = Integer.valueOf(minLabel);
        Datetime selectedTimeStart = newCallDate.WelcomeCall_Schedule_Date__c;
        Datetime selectedTimeEnd = newCallDate.WelcomeCall_Schedule_Date__c.addMinutes(minuteDiff);
        Integer hourofNow = now.hour();
        Integer minofNow = now.minute();
        String dateofNow = String.valueOf(now.date());
        
        List<AggregateResult> jadwalSebelumnya2 = [SELECT count(id) from call_line__c 
                                                   WHERE (OwnerId =: userID AND 
                                                          WelcomeCall_Schedule_Date__c >=: selectedTimeStart AND
                                                          WelcomeCall_Schedule_Date__c <=: selectedTimeEnd)
                                                   OR (OwnerId =: userID AND 
                                                       endCall__c >=: selectedTimeStart AND
                                                       endCall__c <=: selectedTimeEnd)];
        
        Decimal hasiljdwalsblmnya2 = jadwalSebelumnya2[0].get('expr0')==null ? 0 : (decimal)jadwalSebelumnya2[0].get('expr0');
        Integer jumlahJadwalSblmnya2 = hasiljdwalsblmnya2.intvalue();
        //add custom config for office hour and weekend
        // get top 1
            List<WelcomeCal_Schedule__c> scheduleHours = [Select Start_Hour__c, End_Hour__c, FgWeekend__c from WelcomeCal_Schedule__c];
        // end
        if(!scheduleHours.isEmpty()){
            System.debug('scheduleHours '+scheduleHours);
            if((dayofDate == 'Sun' || dayofDate == 'Sat') && !scheduleHours.get(0).FgWeekend__c){
                System.debug('weekend day choosen');
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Pilih hari hanya dalam rentang hari kerja.'));
                return null;
            }
            if(newCallDate.WelcomeCall_Schedule_Date__c.time() < scheduleHours.get(0).Start_Hour__c.time() 
               || newCallDate.WelcomeCall_Schedule_Date__c.time() >= scheduleHours.get(0).End_Hour__c.time()){
                System.debug('outside work hours');
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Pilih waktu hanya dalam rentang jam kerja.'));
                return null;
            }   
        }
        if(newCallDate.WelcomeCall_Schedule_Date__c < Date.today()){
            System.debug('cannot call someone yesterday today.');
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Tidak bisa memilih hari sebelum hari ini.'));
            return null;
        }
        if(dateTerpilih == dateofNow){
            if(timeofDate < hourofNow){
                System.debug('cannot pick hour that has been passed.');
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Tidak bisa memilih jam yang sudah lewat.'));
                return null;
            }
            if(timeofDate == hourofNow){
                if(minofDate < minofNow || minofDate == minofNow){
                    System.debug('cannot pick minutes passed.');
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Tidak bisa memilih menit yang sudah lewat.'));
                    return null;
                }
            }
        }
        if(jumlahJadwalSblmnya2 > 0){
            System.debug('previous schedule existed? '+jadwalSebelumnya2.size());
            System.debug(jadwalSebelumnya2);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Sudah ada jadwal di jam ini.'));
            return null;
        }
        if(currentCL.Activity_Result__c == '' || currentCL.Activity_Result__c == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Call status harus diisi.'));
            return null;
        }
        if(currentCL.Verification__c == '' || currentCL.Verification__c == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Reason status harus diisi.'));
            return null;
        }
        system.debug('detail status: '+currentCL.WelcomeCall_Detail_Status__c);
        if(!detailStatus && ((currentCL.WelcomeCall_Detail_Status__c == '') || currentCL.WelcomeCall_Detail_Status__c == null)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Detail status harus diisi.'));
            return null;
        }
        if(!reasonDetailStatus && ((currentCL.WelcomeCall_Reason_Detail_Status__c == '') || currentCL.WelcomeCall_Reason_Detail_Status__c == null)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Reason detail status harus diisi.'));
            return null;
        }
        
        List<Call_Line__c> checkSchedule = [SELECT Id, Name, WelcomeCall_Schedule_Date__c FROM Call_Line__c 
                                            WHERE WelcomeCall_Schedule_Date__c >=: startSelector AND WelcomeCall_Schedule_Date__c <=: endSelector 
                                            AND WelcomeCall_Call_Line_Status__c = 'Open' 
                                            AND OwnerId =: userID];
        System.debug('cek jadwal : '+checkSchedule);
        System.debug('size checkSchedule : '+checkschedule.size());
        
        if(checkSchedule.size() > 5){
            System.debug('too much work for that hour');
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Sudah mencapai maksimal SLOT. Silakan pilih jam yang lain.'));
            return null;
        }
        
        /**List<Call_Line__c> duplicateReschedule = [SELECT Name, Policy_No__c FROM Call_Line__c
                                                  WHERE Policy_No__c =: newSchedule.Policy_No__c AND WelcomeCall_Call_Line_Status__c = 'Open'];
        
        if(duplicateReschedule.size()>1){
            System.debug('dupilicate reschedule is not allowed');
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Penjadwalan ulang untuk nomor polis '+newSchedule.Policy_No__c+' sudah ada.'));
            return null;
        }*/
        
        try{
            Call_Line__c selectedSchedule = [SELECT Id, Name, Contact__c, Policy_No__c, Contacted_Number__c, Home_Phone__c, Phone__c, Other_Phone__c, Call_List__c, 
                                         Entity__c, Activity__c, Case_Type__c, Case_Type_Config__c, WelcomeCall_Criteria__c, WelcomeCall_Schedule_Date__c, 
                                         WelcomeCall_Call_Line_Status__c, Call_Date__c, OwnerId , Verification__c, RecordTypeId
                                         FROM Call_Line__c WHERE Id =: callPick ];
        
            selectedSchedule.WelcomeCall_Call_Line_Status__c = 'Closed';
            selectedSchedule.Activity_Result__c = currentCL.Activity_Result__c;
            selectedSchedule.Verification__c ='Reschedule';
            selectedSchedule.Notes__c = currentCL.Notes__c;
            update currentCL;
            
            Call_Line__c newSchedule = new Call_Line__c();
            List<Call_Line__c> duplicateReschedule = [SELECT Id, Name, WelcomeCall_Schedule_Date__c
                                             FROM Call_Line__c WHERE WelcomeCall_Fg_Schedule__c = TRUE and
                                                      (WelcomeCall_Reference__c =: callPick) and WelcomeCall_Call_Line_Status__c != 'Closed'];
            
            if(!duplicateReschedule.isEmpty()){
                newSchedule.Id = duplicateReschedule.get(0).Id;
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
            newSchedule.WelcomeCall_Reschedule_Source__c = IN_HOUSE; 
            
            System.debug('referens : '+selectedSchedule.Id);
            
            List<Call_line__c> upsertCL = New List<Call_line__c>();
            //update currentCL;
            //upsertCL.add(currentCL);
            upsertCL.add(newSchedule);
            upsert(upsertCL);
            
            currentCL.Activity_Result__c = '';
            if((currentCL.WelcomeCall_Detail_Status__c == null) || (currentCL.WelcomeCall_Detail_Status__c == ''))
                detailStatus = false;
            else
                detailStatus = true;
            
            if((currentCL.WelcomeCall_Reason_Detail_Status__c == null) || (currentCL.WelcomeCall_Reason_Detail_Status__c == ''))
                reasonDetailStatus = false;
            else
                reasonDetailStatus = true;
            
            
            Task t = new Task();
            	Datetime timeSchedule = newSchedule.WelcomeCall_Schedule_Date__c;
            	
                t.ReminderDateTime = timeSchedule-0.005; 
                t.ActivityDate = Date.valueOf(newSchedule.WelcomeCall_Schedule_Date__c); 
                t.Subject = 'Need to follow up call: '+newSchedule.Policy_No__c;
                t.Status = 'Open';
                t.Priority = 'Normal';
                t.WhatId = newSchedule.Id;
                t.Type = 'Call';
                t.IsReminderSet = true;
                t.ownerid = newSchedule.OwnerId;
            
            	//add by MII at 21 09 23
            	t.Entity__c= currentCL.entity__c;
            	t.Policy_No__c = newSchedule.Policy_No__c;
            insert t;
             
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Jadwal berhasil diganti.'));
            System.debug('dah insert dan update');
        } catch(Exception e){
            System.debug('oops : '+ e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }
        
        return null;
    }
    
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
}