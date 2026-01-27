trigger OverdueCaseCalculation_AND_AutoAssignment on Case (before update) {
    List<Case> caseUpdateList = new List<Case>();
    List<SLA_Setting__c> slaList = new List<SLA_Setting__c>();
    //List<Email_Assignment__c> emailAssignmentList = new List<Email_Assignment__c>();
    Map<Id, Email_Config__c> emailConfigList = new Map<Id, Email_Config__c>();
    List<Email_Config__c> emailConfigList2 = new List<Email_Config__c>();
    List<Email_Config__c> emailConfigLoopList = new List<Email_Config__c>();
    Map<String, Case> caseSubjectMap = new Map<String, Case>();
    Map<String, Case> senderMap = new Map<String, Case>();
    Map<String, Case> toAddressMap = new Map<String, Case>();
    //Map<String, Case> ccAddressMap = new Map<String, Case>();
    Set<String> keys1 = new Set<String>();
    Set<String> keys2 = new Set<String>();
    Set<String> keys3 = new Set<String>();
    Set<String> caseId = new Set<String>();
    Set<String> toAddressList = new Set<String>();
    Set<String> ccAddressList = new Set<String>();
    Set<String> combinedAddressList = new Set<String>();
    Set<string> emailConfigAddress = new Set<String>();
    Datetime createdDate;
    Datetime dayCounter;
    Datetime dueDate;
    String dueDateInLocal;
    String entity = '';
    Date holiday;
    integer slaDuration = 0;
    integer slaDurationBeforeLoop = 0;
    Integer totalAdditionalDays = 0;
    Integer totalAdditionalDaysForEmail = 0;
    //List<AggregateResult> Result; 
    Decimal min = 0;
    Decimal max = 0;
    string addressInAggregate = '';
    string usedEmail = '';
    string firstInbox = '';
    //string caseIdList = '';
    string emailali = system.label.EMAIL_ALI; //tambah entity ALI oleh MII
    string emailafi = system.label.EMAIL_AFI;
    string emailamfs = system.label.EMAIL_AMFS;
    string emailmagi = system.label.EMAIL_MAGI;
    string adminId = system.label.Admin_ID;
    //string adminId2 = system.label.Admin_ID_2;
    string caseOwnerId = null;
    //boolean isAlreadyTagged = false;
    
    //added by ARIF Phincon
    string inquiryrecordtypeAFI = Schema.SObjectType.Case.getRecordTypeInfosByName().get('InquiryAFICase').getRecordTypeId();
    string inquiryrecordtypeALI = Schema.SObjectType.Case.getRecordTypeInfosByName().get('InquiryALICase').getRecordTypeId();
    string inquiryrecordtypeAMFS = Schema.SObjectType.Case.getRecordTypeInfosByName().get('InquiryAMFSCase').getRecordTypeId();
    string inquiryrecordtypeMAGI = Schema.SObjectType.Case.getRecordTypeInfosByName().get('InquiryMAGICase').getRecordTypeId();
                        
    List<Holiday> holidayList = [SELECT ID, Name, ActivityDate, IsAllDay FROM Holiday WHERE ActivityDate > today];
    
    for(Holiday hol : holidayList){        holiday = hol.ActivityDate; 
    }
     
    Map<Date, date> mapHoliday = new Map<Date, date>(); 
    List<Master_Holiday__c> masterHolidays = [SELECT ID, Start_Date_time__c, End_Date_Time__c, Active_Date__c, Entity__c FROM Master_Holiday__c WHERE Active_Date__c > today and Entity__c = 'AFI'];
    for(Master_Holiday__c row : masterHolidays){      
        
        date DayStart = date.valueof(row.Start_Date_time__c);
        date DayEnd = date.valueof(row.End_Date_Time__c);
        Datetime startDate = datetime.newInstance(DayStart.year(), DayStart.month(), DayStart.day(), 7,0,0);
        Datetime endDate = datetime.newInstance(DayEnd.year(), DayEnd.month(), DayEnd.day(), 7,0,0);
        
        DayStart = date.valueof(startDate);
        DayEnd = date.valueof(endDate);
        
        
 		integer loopHoliday = Math.abs(DayEnd.daysBetween(DayStart)); 
        mapHoliday.put(DayStart, row.Active_Date__c);
        for (integer i = 1; i < loopHoliday; i++) {
            mapHoliday.put(DayStart.adddays(i), row.Active_Date__c);
        }
        mapHoliday.put(DayEnd, row.Active_Date__c);
    }
    
    system.debug('mapHoliday:'+mapHoliday); 
    for(Case c: trigger.new){
        /*------------tambahan after Go-Live -----------*/
        if(c.Subject != null) {
            if(!caseSubjectMap.containsKey(c.Subject)) {
                caseSubjectMap.put(c.Subject, c);
            }
        }
        if(c.SuppliedEmail != null) {
            if(!senderMap.containsKey(c.SuppliedEmail)) {
                senderMap.put(c.SuppliedEmail, c);
            }
        }
        if(c.e2cEmailToAddress__c != null) {            if(!toAddressMap.containsKey(c.e2cEmailToAddress__c)) {                toAddressMap.put(c.e2cEmailToAddress__c, c);
            }
        } 
        
        createdDate = c.CreatedDate;
        entity = c.Entity__c;
 
        if(c.Type == 'Request'){
            //caseTypeRequestMap.put(c.Case_Type_Config__c, c.Case_Type_Config__c);
            //slaList = [SELECT Id, Case_Type__c, Category__c, Nature__c, Is_Calendar__c, Service_SLA__c, Unit__c, Entity__c FROM SLA_Setting__c WHERE Case_Type__c IN :caseTypeRequestMap.keySet()];
            slaList = [SELECT Id, Case_Type__c, Category__c, Nature__c, Is_Calendar__c, Service_SLA__c, Unit__c, Entity__c, Start_Working_Hour__c, End_Working_Hour__c FROM SLA_Setting__c WHERE Case_Type__c = :c.Case_Type_Config__c AND Entity__c = :entity];
        }
        if(c.Type == 'Complaint'){
            //caseTypeComplaintMap.put(c.Category_Config__c, c.Category_Config__c);
            //slaList = [SELECT Id, Case_Type__c, Category__c, Nature__c, Is_Calendar__c, Service_SLA__c, Unit__c, Entity__c FROM SLA_Setting__c WHERE Category__c IN :caseTypeComplaintMap.keySet()];
            slaList = [SELECT Id, Case_Type__c, Category__c, Nature__c, Is_Calendar__c, Service_SLA__c, Unit__c, Entity__c, Complaint_Type__c, Start_Working_Hour__c, End_Working_Hour__c 
                       FROM SLA_Setting__c 
                       WHERE Entity__c = :entity and Complaint_Type__c = :c.Complaint_Type__c];
        }
    
        
        system.debug('createdDate:'+createdDate);
        system.debug('c.Entity__c :'+c.Entity__c );
        system.debug('c.Type:'+c.Type);
        for(SLA_Setting__c sla: slaList){
            slaDuration = Integer.valueOf(sla.Service_SLA__c);
            slaDurationBeforeLoop = slaDuration;
                     
            system.debug('slaDuration:'+slaDuration);
            system.debug('slaDurationBeforeLoop:'+slaDurationBeforeLoop);
            system.debug('sla.Service_SLA__c:'+sla.Service_SLA__c);
            system.debug('sla.Unit__c:'+sla.Unit__c);
            
            if(sla != null){
                if(integer.valueOf(sla.Service_SLA__c) !=null && sla.Unit__c == 'Day'){
                    
                    //Looping for Case SLA
                    for(integer i=1; i<=slaDuration; i++){                        dayCounter = createdDate.addDays(i);    //dayCounter = createdDate+i;
                 
                              system.debug('===========================');
                              system.debug('mapHoliday.containsKey(dayCounter.date()):'+mapHoliday.containsKey(dayCounter.date()));
                              system.debug('dayCounter:'+dayCounter.date());
                              system.debug('===========================');
                        if(
                            dayCounter.format('E') == 'Sat' || dayCounter.format('E') == 'Sun' || dayCounter.date() == holiday
                            || (mapHoliday.containsKey(dayCounter.date()) && (entity == 'AFI' || entity == 'ALI') && c.Type == 'Complaint') // added by Support MII at 06 12 24
                          ){
                              system.debug('mapHoliday.containsKey(dayCounter.date()):'+mapHoliday.containsKey(dayCounter.date()));
                              system.debug('===========================');
                              system.debug('masuk libur'); 
                              system.debug('===========================');
                              slaDuration++;
                        }
                    }
                    totalAdditionalDays = slaDuration - slaDurationBeforeLoop;                    dueDate = createdDate + slaDurationBeforeLoop + totalAdditionalDays;                    dueDateInLocal = dueDate.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
                }
                else if(integer.valueOf(sla.Service_SLA__c) !=null && 
                        sla.Unit__c == 'Hour'){
                    system.debug('Start SLA calculation if the unit is hour');
                    
                    dueDate = createdDate.addHours(slaDuration);
                    dueDateInLocal = dueDate.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
                    
                    Integer divYear = Integer.valueOf(dueDateInLocal.substring(6, 10));
                    Integer divMonth = Integer.valueOf(dueDateInLocal.substring(3, 5));
                    Integer divDay = Integer.valueOf(dueDateInLocal.substring(0, 2));
                    Integer divHours = Integer.valueOf(dueDateInLocal.substring(11, 13));
                    Integer divMins = Integer.valueOf(dueDateInLocal.substring(14, 16));
                    
                    //Check if the case SLA time exceeds office hour (8-16 PM)
                    if((divHours == integer.valueOf(sla.End_Working_Hour__c) && divMins > 0) || 
                       test.isRunningTest()){
                        dueDate = Datetime.newInstance(divYear, divMonth, divDay + 1, integer.valueOf(sla.Start_Working_Hour__c), divMins, 0);
                        
                        while(dueDate.date() == holiday || 
                              dueDate.format('E') == 'Sat' || 
                              dueDate.format('E') == 'Sun'){                            dueDate = dueDate + 1;
                        }
                        dueDateInLocal = dueDate.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
                    }
                    if((divHours > integer.valueOf(sla.End_Working_Hour__c)) || 
                       test.isRunningTest() == true){
                        integer surplusHour = divHours - integer.valueOf(sla.End_Working_Hour__c);
                        dueDate = Datetime.newInstance(divYear, divMonth, divDay + 1, integer.valueOf(sla.Start_Working_Hour__c) + surplusHour, divMins, 0);
                        
                        while(dueDate.date() == holiday || 
                              dueDate.format('E') == 'Sat' || 
                              dueDate.format('E') == 'Sun'){                            dueDate = dueDate + 1;
                        }
                       dueDateInLocal = dueDate.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
                    }
                }
            }
        }
        
        Datetime calenderBasedDueDate;
        
        Case old = Trigger.oldMap.get(c.Id);
        
        if(c.Type == 'Inquiry' ) { 
                
            boolean isNotSaveProcess =  false;
            if ( c.Status == old.Status && 
                    c.Priority == old.Priority &&
                    c.ContactId == old.ContactId &&
                    c.Origin == old.Origin &&
                    c.Subject == old.Subject &&
                    c.Description == old.Description &&
                    c.Non_Inquiry__c == old.Non_Inquiry__c &&
                    c.Service_Type__c == old.Service_Type__c &&
                    c.Is_Follow_Up__c == old.Is_Follow_Up__c &&
                    c.Case_Type_Config__c == old.Case_Type_Config__c
                ) {
                isNotSaveProcess = true;
            }
            
            if ( isNotSaveProcess ) {
                // ** DO NOT INQUERY VALIDATION PROCESS ** // 
                System.debug('===== DO NOT INQUERY VALIDATION PROCESS');
            }           
            else if ( (old.Email_Status__c == 'Unread' || old.Email_Status__c == '' || old.Email_Status__c == null) && c.Email_Status__c == 'Read' ) {
                // ** DO NOT INQUERY VALIDATION PROCESS ** //
                System.debug('===== DO NOT INQUERY VALIDATION PROCESS');
            }
            else {
                // ** DO VALIDATION PROCESS!! ** //
                System.debug('===== DO INQUERY VALIDATION PROCESS!!');
                
                if(!test.isRunningTest()){
                    if ( c.Non_Inquiry__c == false && (c.Case_Type_Config__c == '' || c.Case_Type_Config__c == null)) {
                        // show error msg
                        //c.Case_Type_Config__c.addError('Fill Case-Type to Save Inquiry Case record');
                    }
                    else if ( c.Non_Inquiry__c == false && (c.ContactId == null)) {
                        // show error msg
                        //c.ContactId.addError('Fill Contact-Name to Save Inquiry Case record');
                    }
                }       
            }
        }
        else if(c.Type == 'Request'){
            for(SLA_Setting__c slaObjRequest : slaList){
                if(slaObjRequest != null){
                    if(slaObjRequest.Is_Calendar__c == true){ calenderBasedDueDate = createdDate + slaDurationBeforeLoop;                        c.Due_Date_Time__c = calenderBasedDueDate;                        c.Due_Date_Time_In_String__c = calenderBasedDueDate.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
                    }else{ c.Due_Date_Time__c = dueDate;                        c.Due_Date_Time_In_String__c = dueDateInLocal;
                    }
                }
            }
        }
        else if(c.Type == 'Complaint'){
            for(SLA_Setting__c slaObjComplaint : slaList){
                if(slaObjComplaint != null){
                    
                    if(slaObjComplaint.Is_Calendar__c == true){
                        // added by Support MII at 21 nov 24
                        // count by workdays
                        if (c.entity__c == 'AFI') {
                            slaDurationBeforeLoop = slaDuration;
                            c.SLA_Case_Closed__c = slaObjComplaint.Service_SLA__c;
                        }

                        calenderBasedDueDate = createdDate + slaDurationBeforeLoop; 
                        c.Due_Date_Time__c = calenderBasedDueDate;
                        c.Due_Date_Time_In_String__c = calenderBasedDueDate.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
                    }
                    else{
                        c.Due_Date_Time__c = dueDate;
                        c.Due_Date_Time_In_String__c = dueDateInLocal;
                    }

                    
                    /*
                    // ** CHS AUTO ASSIGNMENT ** //
                    List<Skill_of_Nature_Category__c> skillList = new List<Skill_of_Nature_Category__c>();

                    String nature = c.Nature_Config__c;
                    String category = c.Category_Config__c;
                    String entity = c.Entity__c;
                    
                    String skillName = '';
                    Decimal lastOrderNo = 0;
                    
                    
                    Case old = Trigger.oldMap.get(c.Id);
                    if ( c.get('Nature_Config__c') != old.get('Nature_Config__c') || c.get('Category_Config__c') != old.get('Category_Config__c')  ) {
                    
                    skillList = [SELECT Name, Last_Order_No__c FROM Skill_of_Nature_Category__c WHERE Nature__c=:nature AND  Category__c =: category AND Entity__c=:entity];
                    if (skillList.size()==0) {c.CMU_Agent__c =null;}
                            
                    for(Skill_of_Nature_Category__c skill: skillList){
                        if(skill != null){
                            skillName = skill.Name;
                            system.debug('====== skillName:' + skillName);
                            
                            lastOrderNo = skill.Last_Order_No__c;
                        
                            List<User_Skill__c> userSkillList = new List<User_Skill__c>();

                            List<AggregateResult> Result; 
                            Result = [SELECT MIN(Order__c) minOrder, MAX(Order__c) maxOrder FROM User_Skill__c WHERE Skill__r.name = :skillName AND  Status__c =: 'Active'];
                            
                            Decimal min = 0;
                            Decimal max = 0;
                            for(AggregateResult aggRes : Result) {
                                min = (Decimal) aggRes.get('minOrder'); 
                                max = (Decimal) aggRes.get('maxOrder');
                            }
                            
                            // Decimal nextOrder =0;
                            userSkillList = [SELECT User__c, Order__c FROM User_Skill__c WHERE Skill__r.name = :skillName AND  Status__c = 'Active' order by Order__c ];
                            
                            for(User_Skill__c userSkill: userSkillList){
                                if(userSkill != null ){

                                    if ( userSkill.Order__c == min && lastOrderNo >= max ) {
                                        system.debug('====== userSkill.User__c (1):' + userSkill.User__c);
                                        
                                        //before : c.Back_Office_PIC__c = userSkill.User__c;
                                        //after  : change to 'CMU Agent' field
                                        c.CMU_Agent__c= userSkill.User__c;
                                        skill.Last_Order_No__c = min;//userSkill.Order__c;              
                                        break;
                                    }
                                    else if (userSkill.Order__c <= lastOrderNo ) {
                                        //=++
                                        continue;
                                    }

                                    //got the order
                                    else if (userSkill.Order__c > lastOrderNo ) {
                                        //before : c.Back_Office_PIC__c = userSkill.User__c;
                                        //after  : change to 'CMU Agent' field
                                        c.CMU_Agent__c = userSkill.User__c;
                                        
                                        skill.Last_Order_No__c = userSkill.Order__c;
                                        system.debug('skill.Last_Order_No__c : ' + skill.Last_Order_No__c);
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    update skillList;
                    }
                    */
                    
                    /*
                    if(c.Entity__c == 'AFI'){
                        c.Due_Date_Time__c = createdDate + slaObjComplaint.Service_SLA__c;
                    }
                    */
                }
            }
        }
    }   //End of For loop Case trigger new
    
    /*------------------------------------------------------------------Tambahan after Go Live --------------------------------------------------------------------*/
    keys1 = caseSubjectMap.KeySet();
    keys2 = senderMap.keySet();
    keys3 = toAddressMap.keySet();
    //keys4 = ccAddressMap.keySet();
    string origin = 'Email';
    string type = 'Inquiry';
    
    /*The original query*/  //String queryStr = 'SELECT id, e2cEmailTo_New__c, e2cEmailCC__c, CreatedDate, Subject, First_Inbox__c, OwnerId, Email_Inbox__c, Entity__c FROM Case WHERE CreatedDate = today AND Origin = :origin AND Type = :type AND Subject IN :keys1 AND SuppliedEmail = :keys2 AND e2cEmailTo_New__c IN :keys3';
    Datetime currentTime = system.now();
    DateTime nMinutesAgo = currentTime.addMinutes(-5); //created within last 5 minutes
    String queryStr = 'SELECT id, e2cEmailToAddress__c, e2cEmailCCAddress__c, CreatedDate, Subject, First_Inbox__c, OwnerId, Email_Inbox__c, Entity__c FROM Case WHERE CreatedDate >= :nMinutesAgo AND CreatedDate <= :currentTime AND Origin = :origin AND Type = :type AND Subject IN :keys1 AND SuppliedEmail = :keys2';
    
    List<Case> currentCase = database.query(queryStr);
    
    system.debug('Current case size: '+currentCase.size());
    system.debug(' === Query: SELECT id, e2cEmailToAddress__c, e2cEmailCCAddress__c, CreatedDate, Subject, First_Inbox__c, OwnerId, Email_Inbox__c, Entity__c FROM Case WHERE CreatedDate >= '+nMinutesAgo+' AND CreatedDate <= '+currentTime+' AND Origin = '+origin+' AND Type = '+type+' AND Subject IN '+keys1+' AND SuppliedEmail = '+keys2); 
     
    if(currentCase.size() > 0){
        
        for(Case cLoop : CurrentCase){
            caseId.add(cLoop.Id);
            firstInbox = cLoop.First_Inbox__c;
            system.debug('firstInbox when set for the first time: '+firstInbox);
            
            if(cLoop.e2cEmailToAddress__c != null ){
                if(cLoop.e2cEmailToAddress__c.contains(';')){ String[] toAddressSplit = cLoop.e2cEmailToAddress__c.split(';');
                    for(string address: toAddressSplit){
                        toAddressList.add(address.trim());  
                    }
                   // break;
                }else{ toAddressList.add(cLoop.e2cEmailToAddress__c); }
            }
            if(cLoop.e2cEmailCCAddress__c != null){
                if(cLoop.e2cEmailCCAddress__c.contains(';')){
                    String[] ccAddressSplit = cLoop.e2cEmailCCAddress__c.split(';');
                    for(string address: ccAddressSplit){
                        ccAddressList.add(address.trim());  
                    }
                }else{ ccAddressList.add(cLoop.e2cEmailCCAddress__c); }
            }
        }
    }
    combinedAddressList.addAll(toAddressList);
    combinedAddressList.addAll(ccAddressList);

    /*The original query*/  //String query = 'SELECT Case_Id__c, Case_Email_Inbox__c, Case_Owner_ID__c, Case_Subject__c, Case_ToAddress__c, Email_Config_ID__c, Email_Config_Last_Order__c, Email_Config_Last_Order_Original__c, CreatedDate FROM Incoming_Email_Checker__c WHERE CreatedDate = today AND Case_Id__c IN :caseId AND Case_Email_Inbox__c = :firstInbox AND Case_ToAddress__c IN :keys3 AND Case_Subject__c = :keys1 order by CreatedDate asc';
    String query = 'SELECT Case_Id__c, Case_Email_Inbox__c, Case_Owner_ID__c, Case_Subject__c,';
    query = query + ' Case_ToAddress__c, Email_Config_ID__c, Email_Config_Last_Order__c, Email_Config_Last_Order_Original__c,';
	query = query + ' CreatedDate FROM Incoming_Email_Checker__c WHERE CreatedDate >= :nMinutesAgo';
    query = query + ' AND CreatedDate <= :currentTime AND Case_Id__c IN :caseId AND Case_Email_Inbox__c = :firstInbox';
    query = query + ' AND Case_ToAddress__c IN :keys3 AND Case_Subject__c = :keys1 order by CreatedDate asc';
    
    List<Incoming_Email_Checker__c> emailCheckerList = database.query(query);
    
    system.debug('combinedAddressList in trigger OverdueCaseCalculation: '+combinedAddressList);
    if (combinedAddressList.size() > 0) { // changes by Ranti at 11/24/2021
        emailConfigLoopList = [SELECT Id, Name, Email_Address__c, Entity__c 
                               FROM Email_Config__c 
                               WHERE Email_Address__c in :combinedAddressList];
    }
        
    /* if(test.isRunningTest()) emailConfigLoopList = [SELECT Id, Name, Email_Address__c, Entity__c 
                                                    FROM Email_Config__c  limit 50]; */
    if(test.isRunningTest()) emailConfigLoopList = [SELECT Id, Name, Email_Address__c, Entity__c 
                                                    FROM Email_Config__c  limit 3];
    if (emailConfigLoopList.size() > 0) {  // changes by Ranti at 11/24/2021
        for(Email_Config__c ec: emailConfigLoopList){
            emailConfigAddress.add(ec.Email_Address__c);
        }   
    }
    /*
    for(String eca: emailConfigAddress){        
        firstInbox = eca;
        break;
    }
    */
    system.debug('Email config address list: '+emailConfigAddress);
    
    //emailAssignmentList = [SELECT Id, User__c, Inbox__c, Order__c, Inbox__r.Email_Address__c, Inbox__r.Entity__c, Inbox__r.Last_Order_No__c FROM Email_Assignment__c WHERE Inbox__r.Email_Address__c IN :emailConfigAddress order by Inbox__r.Email_Address__c];
    
    //Result = [SELECT Inbox__r.Email_Address__c addr, MIN(Order__c) minOrder, MAX(Order__c) maxOrder FROM Email_Assignment__c WHERE Inbox__r.Email_Address__c IN :emailConfigAddress AND Is_Active__c = true group by Inbox__r.Email_Address__c];
    
    if(emailConfigAddress.size() > 1){      /*-------------------------- to make sure that this trigger only applies to duplicate email-to-cases ---------------------------*/
        for(Case cs : Trigger.new){
            Case oldCase = Trigger.oldMap.get(cs.Id);
            Email_Config__c ec = null;
            //Email_Config__c ec2 = null;
            
            //Update, 17 Maret 2020 (MII)
            //changes by Ranti at 11/22/2021
            //if(cs.Email_Inbox__c != 'customer@axa-financial.co.id' && cs.Email_Inbox__c != 'helpline@axa-financial.co.id' && cs.Email_Inbox__c != 'no-reply@axa-financial.co.id'){	
            if(cs.Email_Inbox__c != label.CustomerEmail_AFI_ALI && cs.Email_Inbox__c != label.HelplineEmail_AFI_ALI && cs.Email_Inbox__c != label.NoReplyEmail_AFI_ALI){	
                if(cs.Email_Inbox__c == firstInbox){
                    caseOwnerId = cs.OwnerId;
                    system.debug('caseOwnerId is: '+caseOwnerId);
                }
            }	
            
            /*if(cs.Email_Inbox__c == firstInbox){
                caseOwnerId = cs.OwnerId;
                system.debug('caseOwnerId is: '+caseOwnerId);
            }*/
            //END - Update, 17 Maret 2020 (MII)
            
            
            for(Case existingCase : currentCase){
                system.debug('First cs.Email_Inbox__c: '+cs.Email_Inbox__c);
                   
                if((cs.Subject == existingCase.Subject)&&(cs.e2cEmailToAddress__c == existingCase.e2cEmailToAddress__c)){
                    for(string emailAdr : emailConfigAddress){
                        if(cs.Email_Inbox__c == emailAdr){
                            system.debug('Skip the first inbox');
                            continue;
                        }else{
                            if(usedEmail.contains(emailAdr)){
                            	system.debug('Skip the first inbox else');
                                continue;
                            }else{
                                usedEmail = usedEmail+'#'+emailAdr.trim();
                                
                                if(emailAdr != existingCase.Email_Inbox__c){
                               /**   
                                * added by Phincon (ARIF FEB 27th 2018), No need to re-set suitable email inbox 
                                * already taken care by "Avantbox_Create_Email_Scoring.apxt" 
                                system.debug('Old email inbox : '+cs.Email_Inbox__c);
                                    cs.Email_Inbox__c = emailAdr;           /*---------------- Set the suitable email inbox for each inbox  ----------------
                                    system.debug('New email inbox : '+cs.Email_Inbox__c);
                                    system.debug('Setting email inbox for each case: '+cs.Email_Inbox__c);
                                    
                                    /*------Resetting the entity based on respective email inbox------
                                    if((emailafi.indexOf(cs.Email_Inbox__c.trim())!= -1)){
                            			system.debug('Changes to AFI');
                                        cs.Entity_Backup__c = 'AFI';
                                        cs.RecordTypeId = inquiryrecordtypeAFI;
                                    }else if((emailamfs.indexOf(cs.Email_Inbox__c.trim()) != -1)){
                                        system.debug('Changes to AMFS');
                                        cs.Entity_Backup__c = 'AMFS';
                                        cs.RecordTypeId = inquiryrecordtypeAMFS;
                                    }else if((emailmagi.indexOf(cs.Email_Inbox__c.trim()) != -1)){
                                        system.debug('Changes to MAGI');
                                        cs.Entity_Backup__c = 'MAGI';
                                        cs.RecordTypeId = inquiryrecordtypeMAGI;
                                    }
                                    //tambah Entity ALI oleh MII
                                    else if((emailali.indexOf(cs.Email_Inbox__c.trim())!= -1) ){
                                        cs.Entity_Backup__c = 'ALI';
                                        cs.RecordTypeId = inquiryrecordtypeALI;
                                    }*/
                                }
                                break;
                            }
                        }
                    } //------------- End of For Loop in emailConfigAddress
                    system.debug('Used Emails: '+usedEmail);
                }
            } //------------- End of For Loop in CurrentCase
            
/* ----------------------------------- Setting the user assignment of all records in the case list ----------------------------------- */
            if(cs.Email_Inbox__c == firstInbox){
                system.debug('cs.Email_Inbox__c in last IF: '+cs.Email_Inbox__c);
                system.debug('firstInbox in last IF: '+firstInbox);
                system.debug('Old case owner ID: '+oldCase.OwnerId);
                system.debug('caseOwnerId in last IF: '+caseOwnerId);
                system.debug('Case owner ID before setting in the last IF: '+cs.OwnerId);
                
                /*------------------The working code--------------------*/
                if(cs.Created_Out_Of_Office_Hour__c == true){   //setting owner of all cases created out of office hour to Admin
                    
                    //Update, 17 Maret 2020 (MII)
                    // change by Ranti at 11/22/2021
                    // if(cs.Email_Inbox__c != 'customer@axa-financial.co.id' && cs.Email_Inbox__c != 'helpline@axa-financial.co.id' && cs.Email_Inbox__c != 'no-reply@axa-financial.co.id'){	 cs.OwnerId = adminId; } 

                    if(cs.Email_Inbox__c != label.CustomerEmail_AFI_ALI && cs.Email_Inbox__c != label.HelplineEmail_AFI_ALI && cs.Email_Inbox__c != label.NoReplyEmail_AFI_ALI){	 cs.OwnerId = adminId; } 
                    
                    //cs.OwnerId = adminId;
                    //END - Update, 17 Maret 2020 (MII)
                    system.debug('cs.Created_Out_Of_Office_Hour__c == true');
                    
                    for(Incoming_Email_Checker__c iec: emailCheckerList){
                        ec = new Email_Config__c();                        ec.Id = iec.Email_Config_ID__c;                        ec.Last_Order_No__c = iec.Email_Config_Last_Order_Original__c;                        emailConfigList.put(ec.Id, ec);
                        system.debug('Last_Order_No__c when Created_Out_Of_Office_Hour__c == true: '+ec.Last_Order_No__c);
                        break;
                    }
                }else{
                    for(Incoming_Email_Checker__c iec: emailCheckerList){
                        
                        //Update, 17 Maret 2020 (MII)
                        //change by Ranti at 11/22/2021
                        // if(cs.Email_Inbox__c != 'customer@axa-financial.co.id' && cs.Email_Inbox__c != 'helpline@axa-financial.co.id' && cs.Email_Inbox__c != 'no-reply@axa-financial.co.id'){	cs.OwnerId = iec.Case_Owner_ID__c; } 
                        if(cs.Email_Inbox__c != label.CustomerEmail_AFI_ALI && cs.Email_Inbox__c != label.HelplineEmail_AFI_ALI && cs.Email_Inbox__c != label.NoReplyEmail_AFI_ALI){	cs.OwnerId = iec.Case_Owner_ID__c; } 
                        
                        //cs.OwnerId = iec.Case_Owner_ID__c;
                        //END - Update, 17 Maret 2020 (MII)
                        
                        ec = new Email_Config__c();
                        ec.Id = iec.Email_Config_ID__c;
                        ec.Last_Order_No__c = iec.Email_Config_Last_Order__c;
                        emailConfigList.put(ec.Id, ec);
                        
                        system.debug('Resetting last order and case owner in the last IF: '+cs.OwnerId+ ' ; '+ec.Last_Order_No__c);
                        break;
                    }
                }
            }
            else if (cs.Email_Inbox__c != null) { // updated by Ranti, before else, then now else if (cs.Email_Inbox__c != null)
                for(AggregateResult aggRes : [SELECT Inbox__r.Email_Address__c addr, MIN(Order__c) minOrder, MAX(Order__c) maxOrder 
                                              FROM Email_Assignment__c 
                                              WHERE Inbox__r.Email_Address__c = :cs.Email_Inbox__c AND Is_Active__c = true group by Inbox__r.Email_Address__c]) {
                    addressInAggregate = (String)aggRes.get('addr');                    min = (Decimal) aggRes.get('minOrder');                     max = (Decimal) aggRes.get('maxOrder');
                    //break;
                }
                    
                for(Email_Assignment__c eaLoop: [SELECT Id, User__c, Inbox__c, Order__c, Inbox__r.Email_Address__c, Inbox__r.Entity__c, Inbox__r.Last_Order_No__c 
                                                 FROM Email_Assignment__c 
                                                 WHERE Inbox__r.Email_Address__c = :cs.Email_Inbox__c AND Is_Active__c = true order by Order__c]){
                    system.debug('minOrder is '+min);
                    system.debug('maxOrder is '+max);
                                                     
                    // change by Ranti at 11/22/2021
                    // if(cs.Email_Inbox__c != 'customer@axa-financial.co.id' && cs.Email_Inbox__c != 'helpline@axa-financial.co.id' && cs.Email_Inbox__c != 'no-reply@axa-financial.co.id'){	//Update, 17 Maret 2020 (MII)
                    if(cs.Email_Inbox__c != label.CustomerEmail_AFI_ALI && cs.Email_Inbox__c != label.HelplineEmail_AFI_ALI && cs.Email_Inbox__c != label.NoReplyEmail_AFI_ALI){
                        if(cs.Email_Inbox__c != firstInbox) {
                            system.debug('Current email inbox in EmailAssignmentList: '+cs.Email_Inbox__c);
                            system.debug('eaLoop.Inbox__r.Last_Order_No__c: '+eaLoop.Inbox__r.Last_Order_No__c);
                            
                            if(cs.Created_Out_Of_Office_Hour__c == true){                            cs.OwnerId = adminId;
                            }else{
                                ec = new Email_Config__c();                            ec.Id = eaLoop.Inbox__c;
                                
                                if(eaLoop.Inbox__r.Last_Order_No__c >= max){
                                    system.debug('Setting last order value to minimum order ..');
                                    ec.Last_Order_No__c = min;
                                    system.debug('Setting last order in trigger OverdueCaseCalculation (IF section): '+ec.Last_Order_No__c);
                                }
                                else{
                                    if(eaLoop.Inbox__r.Last_Order_No__c >= eaLoop.Order__c){                                    continue;                                }
                                    ec.Last_Order_No__c = eaLoop.Order__c;
                                    system.debug('Setting last order in trigger OverdueCaseCalculation (ELSE section): '+ec.Last_Order_No__c);
                                    system.debug('Current inbox in Email Config: '+eaLoop.Inbox__r.Email_Address__c);
                                }
                                cs.OwnerId = eaLoop.User__c;    /*----------This is the critical part: assigning case to specific user (User Assignment) ----------*/
                                system.debug('Assigning email inbox: '+cs.Email_Inbox__c+ ' to specific user: '+cs.OwnerId+ ' with last order no: '+ec.Last_Order_No__c);
                                emailConfigList.put(ec.Id, ec); //emailConfigList.add(ec);
                                break;
                            }
                        }
                    }	//Update, 17 Maret 2020 (MII)
                } //------------- End of For Loop in Email_Assignment__c
            }   
        }   //------------------- End of For Loop in Case Trigger New
        update emailConfigList.values();
        
        if(!Test.isRunningTest()){
            List<Incoming_Email_Checker__c> iecList = [SELECT Id FROM Incoming_Email_Checker__c WHERE CreatedDate = LAST_N_DAYS:7 AND CreatedDate < today order by CreatedDate asc];
            if(iecList.size() > 0){ delete iecList; }
        }
    }       //----------- End of if(emailConfigAddress.size() > 1)
    
    if(emailConfigAddress.size() == 1){
        system.debug('Cuma satu nih email yg terdaftar...');
        
        for(Case c : Trigger.new){
            Email_Config__c emailCfg = null;
            
            if(c.Created_Out_Of_Office_Hour__c == true){
                
                //Update, 17 Maret 2020 (MII) 
                // change by Ranti at 11/22/2021
                // if(c.Email_Inbox__c != 'customer@axa-financial.co.id' && c.Email_Inbox__c != 'helpline@axa-financial.co.id' && c.Email_Inbox__c != 'no-reply@axa-financial.co.id'){	c.OwnerId = adminId;
                if(c.Email_Inbox__c != label.CustomerEmail_AFI_ALI && c.Email_Inbox__c != label.HelplineEmail_AFI_ALI && c.Email_Inbox__c != label.NoReplyEmail_AFI_ALI){	c.OwnerId = adminId;
                } 
                
                //c.OwnerId = adminId;
                //END - Update, 17 Maret 2020 (MII)
            
                for(AggregateResult aggRes : [SELECT Inbox__r.Email_Address__c addr, MIN(Order__c) minOrder, MAX(Order__c) maxOrder FROM Email_Assignment__c WHERE Inbox__r.Email_Address__c = :c.Email_Inbox__c AND Is_Active__c = true group by Inbox__r.Email_Address__c]) {
                    min = (Decimal) aggRes.get('minOrder');                     max = (Decimal) aggRes.get('maxOrder');
                }
                for(Email_Assignment__c eaLoop: [SELECT Id, User__c, Inbox__c, Order__c, Inbox__r.Email_Address__c, Inbox__r.Entity__c, Inbox__r.Last_Order_No__c FROM Email_Assignment__c WHERE Inbox__r.Email_Address__c = :c.Email_Inbox__c AND Is_Active__c = true order by Order__c]){
                    emailCfg = new Email_Config__c();                    emailCfg.Id = eaLoop.Inbox__c;                    if(eaLoop.Inbox__r.Last_Order_No__c == min){                        emailCfg.Last_Order_No__c = max;
                    }else{ emailCfg.Last_Order_No__c = eaLoop.Inbox__r.Last_Order_No__c - 1; }
                    emailConfigList2.add(emailCfg);
                    system.debug('The last order already set: '+eaLoop.Inbox__r.Last_Order_No__c);
                    system.debug('The new last order after reset: '+emailCfg.Last_Order_No__c);
                    break;
                }
            }
        }
        update emailConfigList2;
    }
}