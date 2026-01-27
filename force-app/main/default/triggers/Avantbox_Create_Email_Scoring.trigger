trigger Avantbox_Create_Email_Scoring on EmailMessage (before insert, after insert) {
    Email_Scoring__c CP_Email = null;
    string emailmagi = '';
    string emailafi = '';
    string emailamfs = '';
    string emailali = ''; //add ALI by MII
    
    string emailaskmagi = '';
    string emailaskafi = '';
    string emailaskamfs = '';
    string emailaskali = ''; //add ALI by MII
    
    string emailAFICustomerLong = '';
    string emailAFIHelplineLong = '';
    /** START add ALI by MII**/
    string emailALICustomerLong = '';
    string emailALIHelplineLong = '';
    /** FINISH add ALI by MII**/
    string emailAMFSNasabahLong = '';
    string emailAMFSCustomerLong = '';
    string emailAMFSPriorityLong = '';
    string emailMAGILong = '';
    //string emailTestingLong = '';
    string emailTestingNormal = '';
    string emailALILong = '';
    
    string nonholidaytemplatemagi = '';
    string nonholidaytemplateafi = '';
    string nonholidaytemplateali = ''; //add ALI by MII
    string nonholidaytemplateamfs = '';
    
    string holidaytemplatemagi = '';
    string holidaytemplateafi = '';
    string holidaytemplateali = ''; //add ALI by MII
    string holidaytemplateamfs = '';
    
    string templateId = '';
    integer startWorkingHour = null;
    integer endWorkingHour = null;
    
    //begin:added by WK, 20170223 to fix problem on email inbox determination based on 'email to address', 'email cc address'
    Set<String> comparingValues = new Set<String>(); 
    String comparedValue = '';
    //end
    
    //string inquiryrecordtype = '';
    string inquiryrecordtypeAFI = '';
    string inquiryrecordtypeALI = ''; // add ALI by MII
    string inquiryrecordtypeAMFS = '';
    string inquiryrecordtypeMAGI = '';

    emailafi = system.label.EMAIL_AFI;
    emailali = system.label.EMAIL_ALI; //add ALI by MII
    emailamfs = system.label.EMAIL_AMFS;
    emailmagi = system.label.EMAIL_MAGI;
    
    emailAFICustomerLong = system.label.EMAIL_AFI_Customer_Long;
    emailAFIHelplineLong = system.label.EMAIL_AFI_Helpline_Long;
    /** START add ALI by MII **/
    //emailALICustomerLong = system.label.EMAIL_ALI_Customer_Long;
    //emailALIHelplineLong = system.label.EMAIL_ALI_Helpline_Long;
    /** FINISH **/
    emailAMFSCustomerLong = system.label.EMAIL_AMFS_Customer_Long;
    emailAMFSNasabahLong = system.label.EMAIL_AMFS_Nasabah_Long;
    emailAMFSPriorityLong = system.label.EMAIL_AMFS_Priority_Long;
    emailMAGILong = system.label.EMAIL_MAGI_Long;
    emailALILong = system.label.EMAIL_ALI_LONG;
    //emailTestingLong = system.label.Email_Testing_Long;
    
    //inquiryrecordtype = system.label.INQUIRY_RECORD_TYPE;
    inquiryrecordtypeAFI = system.label.INQUIRY_RECORD_TYPE_AFI;
    inquiryrecordtypeALI = system.label.INQUIRY_RECORD_TYPE_ALI;
    inquiryrecordtypeAMFS = system.label.INQUIRY_RECORD_TYPE_AMFS;
    inquiryrecordtypeMAGI = system.label.INQUIRY_RECORD_TYPE_MAGI;
    emailaskafi = system.label.EMAIL_AFI_ASK;
    //emailaskali = system.label.EMAIL_ALI_ASK;//add ALI by MII
    emailaskamfs = system.label.EMAIL_AMFS_ASK;
    emailaskmagi = system.label.EMAIL_MAGI_ASK;
    
    String[] afiCustomerArr = emailAFICustomerLong.split('\\|\\|');
    String[] afiHelplineArr = emailAFIHelplineLong.split('\\|\\|');
    /** START add ALI by MII **/
    //String[] aliCustomerArr = emailALICustomerLong.split('\\|\\|');
    //String[] aliHelplineArr = emailALIHelplineLong.split('\\|\\|');
    /** FINISH **/
    String[] amfsCustomerArr = emailAMFSCustomerLong.split('\\|\\|');
    String[] amfsNasabahArr = emailAMFSNasabahLong.split('\\|\\|');
    String[] amfsPriorityArr = emailAMFSPriorityLong.split('\\|\\|');
    String[] magiArr = emailMAGILong.split('\\|\\|');
    String[] aliArr = emailALILong.split('\\|\\|');
    //String[] emailTestingArr = emailTestingLong.split('\\|\\|');
    
    /* ---------------------------Added by Hamfry in CCC Wave 2------------------------------ */
    Set<String> toAddressList = new Set<String>();
    Set<String> ccAddressList = new Set<String>();
    Set<String> bccAddressList = new Set<String>();
    Set<String> allEmails = new Set<String>();
    Map<string, String> emailAssignId = new Map<string, String>();
    List<Email_Config__c> emailConfigList = new List<Email_Config__c>();
    List<AggregateResult> Result; 
    Decimal min = 0;
    Decimal max = 0;
    integer slaEmailDuration = 0;
    integer slaEmailDurationBeforeLoop = 0;
    integer totalAdditionalDays = 0;
    Datetime dueDateEmail;
    Datetime emailCounter;
    Date holiday = null;
    String dueDateEmailInLocal;
    List<Messaging.SingleEmailMessage> maillist =  new List<Messaging.SingleEmailMessage>();
    List<Messaging.SingleEmailMessage> lstMsgsToSend = new List<Messaging.SingleEmailMessage>();
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    Contact dummyContact = new Contact();
    Set<String> caseIdSet = new Set<String>();
    Set<string> emailConfigComparingValues = new Set<string>();
    //Map<String, Email_Config__c> emailConfigMap = new Map<String, Email_Config__c>();
    Map<String, EmailMessage> emaiMsglMap = new Map<String, EmailMessage>();
    Map<String, EmailMessage> emailMap = new Map<String, EmailMessage>();
    Map<String, EmailMessage> toAddressMap = new Map<String, EmailMessage>();
    List<EmailMessage> updatedEmailMsgList = new List<EmailMessage>();
    List<Email_Assignment__c> emailAssign = new List<Email_Assignment__c>();
    List<Email_Assignment__c> emailAssignmentList = new List<Email_Assignment__c>();
    List <EmailMessage> emList = new list <EmailMessage>();
    List<Incoming_Email_Checker__c> incomingEmailList = new List<Incoming_Email_Checker__c>();
    //List<Email2Case_Log__c> email2caseLogList = new List<Email2Case_Log__c>();
    string addressInAggregate = '';
        Integer i = 1;
    
    /*-------------------------------------------Finish----------------------------------------------*/
    
    List<Email_Scoring__c> emailScoringList = new List<Email_Scoring__c>();
    Map<string,string> caseIdMap = new Map<string,string>();
    
    List<Case> caselist = new List<Case>();
    string entity = null;
    string policyNo = null;
    string subjectmsg = null;
    string recordType = null;
    string[] subjectmsgArr = null;
    Map<string, string> entityMap = new Map<string, string>(); //(msgId, entity)
    Map<string, EmailMessage> policyMap = new Map<string, EmailMessage>(); //(policyNo, msg)
    Map<string, Case> caseMap = new Map<string, Case>(); //(policyNo, case)
    //EmailTemplate templateAFI = [SELECT id FROM EmailTemplate WHERE developerName = 'Auto_Reply_After_Office_Hours_AFI'];
    //EmailTemplate templateALI = [SELECT id FROM EmailTemplate WHERE developerName = 'Auto_Reply_After_Office_Hours_ALI']; // ADD ALI by MII
    //EmailTemplate templateAMFS = [SELECT id FROM EmailTemplate WHERE developerName = 'Auto_Reply_After_Office_Hours_AMFS'];
    //EmailTemplate templateMAGI = [SELECT id FROM EmailTemplate WHERE developerName = 'Auto_Reply_After_Office_Hours_MAGI'];

    // added by ranti at 11/08/2021
    integer totalTarget = 0; 
    Date mst_holiday = null;
    List<Date> listMstHoliday = new List<Date>();
    list<date> cekMstHoliday = new list<date>();
    integer removeIndexCekMstHoliday = 0;
    
    /* ----------------------- Added by Hamfry in CCC Wave 2 -------------------------
* (the following logic is used to handle the automatic incoming email distribution)---------*/
    for(EmailMessage em: trigger.new){
        system.debug('=== TEST 1 ===');
        if(em.Incoming){
            if(em.ToAddress != null){
                if(em.ToAddress.contains(';')){
                    String[] toAddressSplit = em.ToAddress.split(';');
                    for(string address: toAddressSplit){
                        toAddressList.add(address.trim());  
                    }
                }else{
                    toAddressList.add(em.ToAddress);
                }
            }
            if(em.CcAddress != null){
                if(em.CcAddress.contains(';')){
                    String[] ccAddressSplit = em.CcAddress.split(';');
                    for(string ccAddress: ccAddressSplit){
                        ccAddressList.add(ccAddress.trim());  
                    }
                }else{
                    ccAddressList.add(em.CcAddress);
                }
            }
            if(em.BccAddress != null){
                if(em.BccAddress.contains(';')){
                    String[] bccAddressSplit = em.BccAddress.split(';');
                    for(string bccAddress: bccAddressSplit){
                        bccAddressList.add(bccAddress.trim());  
                    }
                }else{
                    bccAddressList.add(em.BccAddress);
                }
            }
        }
    }
    //insert dummyContact;
    
    List<Holiday> holidayList = [SELECT ID, Name, ActivityDate, IsAllDay FROM Holiday WHERE ActivityDate > today];
    
    for(Holiday hol : holidayList){
        if(hol.ActivityDate != null){
            holiday = hol.ActivityDate;     
        }
    }
    
    // added by ranti at 11/30/2021 
    // khusus untuk afi saja
    List<Master_Holiday__c> mst_holidayList = [SELECT Id, end_Date_time__c, Active_Date__c  FROM Master_Holiday__c where Active_Date_F__c > TODAY AND (service_type__c = 'Helpline' OR service_type__c = 'Customer AFI') AND Type__c = 'Holiday' AND Entity__c = 'AFI' ORDER by Active_Date_F__c DESC]; 
    for(Master_Holiday__c hol : mst_holidayList){
        if(hol.end_Date_time__c != null){
            // mst_holiday = date.valueOf(hol.end_Date_time__c);     
           // mst_holiday = hol.end_Date_time__c.date();     
            mst_holiday = hol.Active_Date__c;     
            listMstHoliday.add(mst_holiday);
        }
    }
    
    //Check if ToAddress/CCAddress/BCCAddress  = email addresses in the inbox already configured
    /* Update, 17 Feb 2020*/
    /*List<Email_Config__c> emailCfgList = [SELECT Id, Email_Address__c, Entity__c, Distribution_Type__c, SLA__c, Unit__c, Start_Working_Hour__c, End_Working_Hour__c, Last_Order_No__c FROM Email_Config__c WHERE Distribution_Type__c = 'Automatic' AND (Email_Address__c IN :toAddressList OR Email_Address__c IN :ccAddressList OR Email_Address__c IN :bccAddressList)];*/
    List<Email_Config__c> emailCfgList2 = [SELECT Id, Email_Address__c, Entity__c, Distribution_Type__c, SLA__c, Unit__c, Start_Working_Hour__c, End_Working_Hour__c, Last_Order_No__c FROM Email_Config__c WHERE (Email_Address__c IN :toAddressList OR Email_Address__c IN :ccAddressList OR Email_Address__c IN :bccAddressList)];
    List<Email_Config__c> email_configList = new List<Email_Config__c>();
    system.debug('==== emailCfgList2: '+emailCfgList2);
    
    /*for(Email_Config__c ec : emailCfgList) {*/
    for(Email_Config__c ec2 : emailCfgList2){
        if(ec2.Distribution_Type__c == 'Automatic'){

            email_configList.add(ec2);
            system.debug('===== DISTRIBUTION TYPE = "AUTOMATIC" =====');
            system.debug('===== email_configList: '+email_configList);
            
            /* for(Email_Config__c ec : email_configList){
                emailConfigComparingValues.add(ec.Email_Address__c + ' ' +ec.Last_Order_No__c);
                
                slaEmailDuration = Integer.valueOf(ec.SLA__c);
                slaEmailDurationBeforeLoop = slaEmailDuration;
                
                if(ec.Email_Address__c !=null){
                    allEmails.add(ec.Email_Address__c);
                    system.debug('allEmails set in Email Config: '+allEmails);
                    
                    if(ec.SLA__c !=null && ec.Unit__c == 'Day'){
                        
                        for(integer i=1; i<=slaEmailDuration; i++){
                            emailCounter = system.now().addDays(i);     
                            
                            if(emailCounter.format('E') == 'Sat' || emailCounter.format('E') == 'Sun' || emailCounter.date() == holiday){
                                slaEmailDuration++;
                            }
                        }
                        totalAdditionalDays = slaEmailDuration - slaEmailDurationBeforeLoop;
                        dueDateEmail = system.now() + slaEmailDurationBeforeLoop + totalAdditionalDays; 
                        dueDateEmailInLocal = dueDateEmail.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');   //change to local timezone
                    }
                    else if(ec.SLA__c !=null && ec.Unit__c == 'Hour'){
                        system.debug('Unit is Hour');
                        dueDateEmail = system.now().addHours(slaEmailDuration);
                        dueDateEmailInLocal = dueDateEmail.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
                        
                        Integer divYear = Integer.valueOf(dueDateEmailInLocal.substring(6, 10));
                        Integer divMonth = Integer.valueOf(dueDateEmailInLocal.substring(3, 5));
                        Integer divDay = Integer.valueOf(dueDateEmailInLocal.substring(0, 2));
                        Integer divHours = Integer.valueOf(dueDateEmailInLocal.substring(11, 13));
                        Integer divMins = Integer.valueOf(dueDateEmailInLocal.substring(14, 16));
                        
                        //Check if the email due date time / SLA exceeds office hour (8-16 PM)
                        if(divHours == integer.valueOf(ec.End_Working_Hour__c) && divMins > 0 || test.isRunningTest()){
                            //integer surplusMin = 60 - divMins;
                            dueDateEmail = Datetime.newInstance(divYear, divMonth, divDay + 1, integer.valueOf(ec.Start_Working_Hour__c), divMins, 0);
                            
                            while(dueDateEmail.date() == holiday || dueDateEmail.format('E') == 'Sat' || dueDateEmail.format('E') == 'Sun'){
                                dueDateEmail = dueDateEmail + 1;
                            }
                            dueDateEmailInLocal = dueDateEmail.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
                        }
                        if(divHours > integer.valueOf(ec.End_Working_Hour__c) || test.isRunningTest()){
                            integer surplusHour = divHours - integer.valueOf(ec.End_Working_Hour__c);
                            dueDateEmail = Datetime.newInstance(divYear, divMonth, divDay + 1, integer.valueOf(ec.Start_Working_Hour__c) + surplusHour, divMins, 0);
                            
                            while(dueDateEmail.date() == holiday || dueDateEmail.format('E') == 'Sat' || dueDateEmail.format('E') == 'Sun'){
                                dueDateEmail = dueDateEmail + 1;
                            }
                            dueDateEmailInLocal = dueDateEmail.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
                        }
                    }
                }
            } */
        }
    
    /* END - Update, 17 Feb 2020*/
    }   //End of For Loop in emailCfgList

    if (email_configList.size() > 0) {
        for(Email_Config__c ec : email_configList){
            emailConfigComparingValues.add(ec.Email_Address__c + ' ' +ec.Last_Order_No__c);
            
            slaEmailDuration = Integer.valueOf(ec.SLA__c);
            slaEmailDurationBeforeLoop = slaEmailDuration;

            
            // added by Ranti at 11/08/2021
            totalTarget = slaEmailDuration; 
            
            if(ec.Email_Address__c !=null){
                allEmails.add(ec.Email_Address__c);
                system.debug('allEmails set in Email Config: '+allEmails);
                
                if(ec.SLA__c !=null && ec.Unit__c == 'Day'){
                    
                    for(integer i=1; i<=slaEmailDuration; i++){
                        emailCounter = system.now().addDays(i);     
                        
                        //updated by Ranti at 11/30/2021
                        // if(emailCounter.format('E') == 'Sat' || emailCounter.format('E') == 'Sun' || emailCounter.date() == holiday){
                        if(emailCounter.format('E') == 'Sat' || emailCounter.format('E') == 'Sun' || emailCounter.date() <= holiday || emailCounter.date() <= mst_holiday){
                            slaEmailDuration++;
                        }
                    }
                    totalAdditionalDays = slaEmailDuration - slaEmailDurationBeforeLoop;
                    dueDateEmail = system.now() + slaEmailDurationBeforeLoop + totalAdditionalDays; 

                    System.debug('------- total Additional Days:'+totalAdditionalDays);
                    System.debug('------- Due date email:'+dueDateEmail); 
                    dueDateEmailInLocal = dueDateEmail.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');   //change to local timezone

                    // added by Ranti at 11/08/2021
                    // change target TAT by Sla email config 
                    totalTarget = ((slaEmailDurationBeforeLoop+totalAdditionalDays)*24);
                    System.debug('------- Total target count:'+dueDateEmail);
                }
                else if(ec.SLA__c !=null && ec.Unit__c == 'Hour'){
                    system.debug('Unit is Hour');
                    
                    cekMstHoliday = listMstHoliday; 
                    removeIndexCekMstHoliday = cekMstHoliday.size();
                    
                    dueDateEmail = system.now().addHours(slaEmailDuration);
                    dueDateEmailInLocal = dueDateEmail.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
                    
                    Integer divYear = Integer.valueOf(dueDateEmailInLocal.substring(6, 10));
                    Integer divMonth = Integer.valueOf(dueDateEmailInLocal.substring(3, 5));
                    Integer divDay = Integer.valueOf(dueDateEmailInLocal.substring(0, 2));
                    Integer divHours = Integer.valueOf(dueDateEmailInLocal.substring(11, 13));
                    Integer divMins = Integer.valueOf(dueDateEmailInLocal.substring(14, 16));
                    
                    //Check if the email due date time / SLA exceeds office hour (8-16 PM)
                    if(divHours == integer.valueOf(ec.End_Working_Hour__c) && divMins > 0 || test.isRunningTest()){
                        //integer surplusMin = 60 - divMins;
                        dueDateEmail = Datetime.newInstance(divYear, divMonth, divDay + 1, integer.valueOf(ec.Start_Working_Hour__c), divMins, 0);
                        
                        // updated by Ranti at 11/30/2021
                        // while(dueDateEmail.date() == holiday || dueDateEmail.format('E') == 'Sat' || dueDateEmail.format('E') == 'Sun'){
                        while(dueDateEmail.date() <= holiday || dueDateEmail.date() <= mst_holiday || dueDateEmail.format('E') == 'Sat' || dueDateEmail.format('E') == 'Sun'){
                            dueDateEmail = dueDateEmail + 1;
                            // added by Ranti at 11/08/2021
                            // change target TAT by Sla email config 
                    		totalTarget = totalTarget+24; 
                            if (removeIndexCekMstHoliday > 0) {  
                                removeIndexCekMstHoliday = removeIndexCekMstHoliday - 1;
                                cekMstHoliday.remove(removeIndexCekMstHoliday); 
                                if (cekMstHoliday.size() > 0) {    
                                    removeIndexCekMstHoliday = cekMstHoliday.size() - 1;
                                    mst_holiday = cekMstHoliday[removeIndexCekMstHoliday];
                                }  
                            }
                        } 
                        dueDateEmailInLocal = dueDateEmail.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
                    }
                    
                     cekMstHoliday = listMstHoliday; 
                    removeIndexCekMstHoliday = cekMstHoliday.size();
                    if(divHours > integer.valueOf(ec.End_Working_Hour__c) || test.isRunningTest()){
                        integer surplusHour = divHours - integer.valueOf(ec.End_Working_Hour__c);
                        dueDateEmail = Datetime.newInstance(divYear, divMonth, divDay + 1, integer.valueOf(ec.Start_Working_Hour__c) + surplusHour, divMins, 0);
                        
                        // updated by Ranti at 11/30/2021
                        // while(dueDateEmail.date() == holiday || dueDateEmail.format('E') == 'Sat' || dueDateEmail.format('E') == 'Sun'){
                        while(dueDateEmail.date() <= holiday || dueDateEmail.date() <= mst_holiday || dueDateEmail.format('E') == 'Sat' || dueDateEmail.format('E') == 'Sun'){
                            dueDateEmail = dueDateEmail + 1; 
                            // added by Ranti at 11/08/2021
                            // change target TAT by Sla email config 
                    		totalTarget = totalTarget+24; 
                            if (removeIndexCekMstHoliday > 0) {  
                                removeIndexCekMstHoliday = removeIndexCekMstHoliday - 1;
                                cekMstHoliday.remove(removeIndexCekMstHoliday); 
                                if (cekMstHoliday.size() > 0) {    
                                    removeIndexCekMstHoliday = cekMstHoliday.size() - 1;
                                    mst_holiday = cekMstHoliday[removeIndexCekMstHoliday];
                                }  
                            }
                        }
                        dueDateEmailInLocal = dueDateEmail.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
                    }  
                    
                    
                    
                     cekMstHoliday = listMstHoliday; 
                    removeIndexCekMstHoliday = cekMstHoliday.size();
                    // added by Ranti at 11/08/2021
                    // change SLA 1x24
                    if((divHours >= integer.valueOf(ec.Start_Working_Hour__c) && divHours <= integer.valueOf(ec.End_Working_Hour__c)) || test.isRunningTest()){ 	 
                        while(dueDateEmail.date() <= holiday || dueDateEmail.date() <= mst_holiday || dueDateEmail.format('E') == 'Sat' || dueDateEmail.format('E') == 'Sun'){
                            dueDateEmail = dueDateEmail + 1;
                            // added by Ranti at 11/08/2021
                            // change target TAT by Sla email config 
                    		totalTarget = totalTarget+24; 
                            if (removeIndexCekMstHoliday > 0) {  
                                removeIndexCekMstHoliday = removeIndexCekMstHoliday - 1;
                                cekMstHoliday.remove(removeIndexCekMstHoliday); 
                                if (cekMstHoliday.size() > 0) {    
                                    removeIndexCekMstHoliday = cekMstHoliday.size() - 1;
                                    mst_holiday = cekMstHoliday[removeIndexCekMstHoliday];
                                }  
                            }
                        } 
                        dueDateEmailInLocal = dueDateEmail.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
                    }   
                    system.debug('Total Target:'+totalTarget);
                }  
            }  
        }
    }
    
    /*
//Get all users who've been assigned to the inbox
if(toAddressList.size() > 1 || ccAddressList.size() > 1){
emailAssign = [SELECT Id, User__c, Inbox__c, Inbox__r.Name, Order__c, Inbox__r.Email_Address__c, Inbox__r.Last_Order_No__c FROM Email_Assignment__c WHERE Inbox__r.Email_Address__c IN :allEmails AND Is_Active__c = true order by Inbox__r.Email_Address__c asc ];
system.debug('toAddressList size > 1');
}else{
emailAssign = [SELECT Id, User__c, Inbox__c, Inbox__r.Name, Order__c, Inbox__r.Email_Address__c, Inbox__r.Last_Order_No__c FROM Email_Assignment__c WHERE Inbox__r.Email_Address__c IN :allEmails AND Is_Active__c = true order by Order__c asc ];
system.debug('toAddressList size = 1');     
}
*/
    
    for(Email_Assignment__c eAssign : emailAssign){
        if(eAssign.id != null && !emailAssignId.containsKey(eAssign.id)){
            emailAssignId.put(eAssign.id, eAssign.Inbox__r.Email_Address__c);
        }   
    }
    
    //Find the maximum and minimum order numbers to be used in the automatic distribution
    /*----------old query-----------*/ //Result = [SELECT MIN(Order__c) minOrder, MAX(Order__c) maxOrder FROM Email_Assignment__c WHERE Id IN :emailAssignId.keySet()];
    //Result = [SELECT Inbox__r.Email_Address__c addr, MIN(Order__c) minOrder, MAX(Order__c) maxOrder FROM Email_Assignment__c WHERE Inbox__r.Email_Address__c IN :emailAssignId.values() AND Is_Active__c = true group by Inbox__r.Email_Address__c];
    /*
for(AggregateResult aggRes : Result) {
addressInAggregate = (String)aggRes.get('addr');
min = (Decimal) aggRes.get('minOrder'); 
max = (Decimal) aggRes.get('maxOrder');
}
*/
    if(!Test.isRunningTest()){
        /* Update, 17 Feb 2020*/
        //List<Email_Config__c> emailCfgList2 = [SELECT Id, Email_Address__c, Entity__c, Distribution_Type__c, SLA__c, Unit__c, Start_Working_Hour__c, End_Working_Hour__c FROM Email_Config__c WHERE (Email_Address__c IN :toAddressList OR Email_Address__c IN :ccAddressList OR Email_Address__c IN :bccAddressList)];
        /* END - Update, 17 Feb 2020*/
        
        for(Email_Config__c ec : emailCfgList2) {
            startWorkingHour = integer.valueOf(ec.Start_Working_Hour__c);
            endWorkingHour = integer.valueOf(ec.End_Working_Hour__c);
        }
    }
    /*-----------------------------------------------------------Finish----------------------------------------------------------*/
    
    if(Trigger.isBefore){
        DateTime dt = null;
        for(EmailMessage emailMsg: Trigger.new) {
            if((!emailMsg.Incoming && emailMsg.Parent.Entity__c == 'AFI' && emailafi.indexOf(emailMsg.FromAddress)==-1) ||
               (!emailMsg.Incoming && emailMsg.Parent.Entity__c == 'ALI' && emailali.indexOf(emailMsg.FromAddress)==-1) || //add ALI by MII
               (!emailMsg.Incoming && emailMsg.Parent.Entity__c == 'AMFS' && emailamfs.indexOf(emailMsg.FromAddress)==-1) ||
               (!emailMsg.Incoming && emailMsg.Parent.Entity__c == 'MAGI' && emailmagi.indexOf(emailMsg.FromAddress)==-1) ){
                   emailMsg.addError('You cannot use this email address : \''+emailMsg.FromAddress+'\' due to it\'s belong to other entity.');
               }
            /* ----------------------------------- Added by Hamfry in CCC Wave 2 --------------------------------------*/
            emailMsg.Email_Due_Date_In_Datetime__c = dueDateEmail;
            emailMsg.Email_Due_Date__c = dueDateEmailInLocal;   // Set email SLA in EmailMessage object

            // added by Ranti at 11/08/2021
            // change by Target TAT of email config
            if (emailMsg.Incoming==true && (emailMsg.ToAddress.contains(label.CustomerEmail_AFI_ALI) || emailMsg.ToAddress.contains(label.HelplineEmail_AFI_ALI))) {
            	emailMsg.Target_TAT__c = totalTarget;// Set email SLA in target TaT EmailMessage object    
            }
            
            /* add by MII */
            if(emailMsg.Incoming==true && emailMsg.ToAddress == label.email_service_ALI) emailMsg.ToAddress = label.email_replace_to;
            /* FINISH */
            if(!emailMsg.Incoming){
                emaiMsglMap.put(emailMsg.ParentId, emailMsg);
                dt = emailMsg.MessageDate;
                system.debug('emaiMsglMap: '+emaiMsglMap);
                system.debug('emaiMsglMap (Key Set): '+emaiMsglMap.keySet());
            }
            
            
            /* Update by MII, 18 Feb 2020 */
            if(emailMsg.ToAddress != null){
                if(emailMsg.Incoming == true && (emailMsg.ToAddress.contains(label.CustomerEmail_AFI_ALI) || emailMsg.ToAddress.contains(label.HelplineEmail_AFI_ALI) || emailMsg.ToAddress.contains(label.NoReplyEmail_AFI_ALI))){
                    system.debug('=== Check MessageDate in Business Hours AFI or not ===');
                    datetime dt_MessageDate = emailMsg.MessageDate;
                    datetime dt_NextDate = emailMsg.MessageDate + 1;
                    datetime dt_StartNextDate = DateTime.newInstance(dt_MessageDate.year(),dt_MessageDate.month(),dt_MessageDate.day(),0,0,0);
                    datetime dt_EndNextDate = DateTime.newInstance(dt_MessageDate.year(),dt_MessageDate.month(),dt_MessageDate.day(),8,0,0);
                    datetime dtime_cutOff_AFI = DateTime.newInstance(dt_MessageDate.year(),dt_MessageDate.month(),dt_MessageDate.day(),16,0,0);
                    
                    datetime nextStartBusinessHours;
                    //if it is within the business hours. The returned time will be in the local time zone
                    //UPDATED BY RANTI AT 12/07/2021
                    /* if(emailMsg.ToAddress.contains(label.CustomerEmail_AFI_ALI) || emailMsg.ToAddress.contains(label.NoReplyEmail_AFI_ALI)){
                        nextStartBusinessHours = BusinessHours.nextStartDate(system.label.BusinessHoursAFI_Customer, emailMsg.MessageDate);
                    } else if(emailMsg.ToAddress.contains(label.HelplineEmail_AFI_ALI)){
                        nextStartBusinessHours = BusinessHours.nextStartDate(system.label.BusinessHoursAFI_Helpline, emailMsg.MessageDate);
                    }*/
                    
                    if(emailMsg.ToAddress.contains(label.CustomerEmail_AFI_ALI) || emailMsg.ToAddress.contains(label.HelplineEmail_AFI_ALI)){
                        nextStartBusinessHours = emailMsg.MessageDate;
                    } else if(emailMsg.ToAddress.contains(label.NoReplyEmail_AFI_ALI)){
                        nextStartBusinessHours = BusinessHours.nextStartDate(system.label.BusinessHoursAFI_Customer, emailMsg.MessageDate);
                    } 
                    
                    system.debug('check (dt_MessageDate): '+dt_MessageDate);
                    system.debug('check (dt_NextDate): '+dt_NextDate);
                    system.debug('check (dt_StartNextDate): '+dt_StartNextDate);
                    system.debug('check (dt_EndNextDate): '+dt_EndNextDate);
                    system.debug('check (dtime_cutOff_AFI): '+dtime_cutOff_AFI);
                    system.debug('check (nextStartBusinessHours): '+nextStartBusinessHours);
                    
                    if(emailMsg.MessageDate <= dtime_cutOff_AFI && emailMsg.MessageDate >= dt_EndNextDate && (dt_MessageDate.format('E') != 'Sat' && dt_MessageDate.format('E') != 'Sun') && emailMsg.MessageDate_Temporary__c == null){
                        system.debug('=== In Business Hours (>=8.00 AM && <=4.00 PM) ===');
                        emailMsg.MessageDate_Temporary__c = emailMsg.MessageDate;
                    } else if(emailMsg.MessageDate <= dtime_cutOff_AFI && emailMsg.MessageDate < dt_EndNextDate && (dt_MessageDate.format('E') != 'Sat' && dt_MessageDate.format('E') != 'Sun') && emailMsg.MessageDate_Temporary__c == null){
                        system.debug('=== Before Business Hours (<8.00 AM && <=4.00 PM) ===');
                        emailMsg.MessageDate_Temporary__c = nextStartBusinessHours;
                    } else if(emailMsg.MessageDate <= dtime_cutOff_AFI && (dt_MessageDate.format('E') == 'Sat' || dt_MessageDate.format('E') == 'Sun') && emailMsg.MessageDate_Temporary__c == null){
                        system.debug('=== After Business Hours (> 4.00 PM) === (1)');
                        emailMsg.MessageDate_Temporary__c = nextStartBusinessHours;
                    } else if(emailMsg.MessageDate > dtime_cutOff_AFI && (dt_MessageDate.format('E') != 'Sat' && dt_MessageDate.format('E') != 'Sun') && emailMsg.MessageDate_Temporary__c == null){
                        system.debug('=== After Business Hours (> 4.00 PM) === (2)');
                        emailMsg.MessageDate_Temporary__c = nextStartBusinessHours;
                    } else if(emailMsg.MessageDate > dtime_cutOff_AFI && (dt_MessageDate.format('E') == 'Sat' || dt_MessageDate.format('E') == 'Sun') && emailMsg.MessageDate_Temporary__c == null){
                        system.debug('=== After Business Hours (> 4.00 PM) === (3)');
                        emailMsg.MessageDate_Temporary__c = nextStartBusinessHours;
                    }
                    
                    /*if(emailMsg.MessageDate <= dtime_cutOff_AFI && emailMsg.MessageDate_Temporary__c == null){
                        system.debug('=== In Business Hours (4.00 PM) ===');
                        emailMsg.MessageDate_Temporary__c = emailMsg.MessageDate;
                    } else if(emailMsg.MessageDate > dtime_cutOff_AFI && emailMsg.MessageDate_Temporary__c == null){
                        system.debug('=== After Business Hours (> 4.00 PM) ===');
                        emailMsg.MessageDate_Temporary__c = nextStartBusinessHours;
                    }*/
                    
                    
                    system.debug('=== Update emailMsg.MessageDate_Temporary__c: '+emailMsg.MessageDate_Temporary__c);
                }
            }
            /* END - Update by MII, 18 Feb 2020*/
            
        }
        
        /* Update by MII, 18 Feb 2020*/
        List<EmailMessage> emailMsgList = [SELECT Id, ParentId, status, First_Response_Date_In_Datetime__c, Last_Response_Date__c, MessageDate, Incoming, MessageDate_Temporary__c FROM EmailMessage WHERE ParentId in :emaiMsglMap.keySet() AND Incoming = true ORDER BY CreatedDate DESC LIMIT 1];
        //List<EmailMessage> emailMsgList = [SELECT Id, ParentId, status, First_Response_Date_In_Datetime__c, Last_Response_Date__c, MessageDate, Incoming, MessageDate_Temporary__c FROM EmailMessage WHERE ParentId in :emaiMsglMap.keySet() ORDER BY CreatedDate DESC];
        system.debug('emailMsgList: '+emailMsgList);
        
        /*List<EmailMessage> InboundMsgList = new List<EmailMessage>();
        List<EmailMessage> OutboundMsgList = new List<EmailMessage>();
        //AND Incoming = true AND First_Response_Date_In_Datetime__c = null
        
        for(EmailMessage em : emailMsgList){
            if(em.Incoming == TRUE && em.First_Response_Date_In_Datetime__c == null){
                InboundMsgList.add(em);
            } else {
                OutboundMsgList.add(em);
            }
        }
        system.debug('InboundMsgList: '+InboundMsgList);
        system.debug('OutboundMsgList: '+OutboundMsgList);*/
        
        for(EmailMessage emOne: emailMsgList){
            for(EmailMessage emTwo: emaiMsglMap.values()){
                if(emTwo.Id != emOne.Id && emTwo.ParentId == emOne.ParentId /*&& emTwo.ReplyToEmailMessageId == emOne.Id*/){
                    if(emOne.MessageDate < emTwo.MessageDate && emOne.status=='2' && emOne.First_Response_Date_In_Datetime__c == null){
                        emOne.First_Response_Date_In_Datetime__c = emTwo.MessageDate;
                    }
                    emOne.Last_Response_Date__c = emTwo.MessageDate;
                    updatedEmailMsgList.add(emOne);
                }
                system.debug('===emOne.First_Response_Date_In_Datetime__c: '+emOne.First_Response_Date_In_Datetime__c);
                system.debug('===emOne.Last_Response_Date__c: '+emOne.Last_Response_Date__c);
            }
        }
        system.debug('updatedEmailMsgList: '+updatedEmailMsgList);  
        update updatedEmailMsgList; 
        /* END - Update by MII, 18 Feb 2020*/
        
        /*------------------------------------------------------Finish--------------------------------------------------*/
    }else{      //-----------> if(Trigger.isAfter){
        updatedEmailMsgList = new List<EmailMessage>();
        for(EmailMessage emailMsg: Trigger.new) {
            if(!emailMsg.Incoming){
                CP_Email = new Email_Scoring__c();
                CP_Email.EmailID__c = emailMsg.Id;
                CP_Email.Subject__c = emailMsg.Subject;
                //CP_Email.Status__c = 'Unread';
                CP_Email.Date__c = emailMsg.CreatedDate;  
                CP_Email.Case__c = emailMsg.ParentId;
                
                CP_Email.Message_Date__c = emailMsg.MessageDate; //datetime
                CP_Email.Status__c = emailMsg.Status; //status : 0, 2, 3 ??
                CP_Email.Email_Content__c = emailMsg.TextBody; //status : email content
                CP_Email.Incoming__c = emailMsg.Incoming; //true/false
                
                CP_Email.Agent__c = emailMsg.createdbyId;
                CP_Email.Supervisor__c = emailMsg.createdby.managerid;
                CP_Email.Entity__c = emailMsg.Parent.Entity__c; 
                emailScoringList.add(CP_Email);
                system.debug('*scoring*'+emailScoringList);
                if(!caseIdMap.containsKey(emailMsg.ParentId)){
                    caseIdMap.put(emailMsg.ParentId,emailMsg.ParentId);
                }
            }
            else{
                string currentOwner = null;
                Case cs = new Case();
                cs.id = emailMsg.parentId;
                cs.type = 'Inquiry';
                System.debug('IsAfter '+Trigger.isAfter);
                System.debug('Toaddress '+emailMsg.toaddress);
                System.debug('ccaddress '+emailMsg.ccaddress);
                System.debug('bccaddress '+emailMsg.bccaddress);
                
                Boolean isUsingForwaderAddress = false;
                String headers = emailMsg.Headers == null ? '' : emailMsg.Headers.replace('=', '@').trim();
                System.debug('headers : '+headers);
                
                // currently headers contains different value from different email server (gmail, outlook, etc).
                if(headers.indexOf(afiCustomerArr[1].trim()) != -1){
                    entity = 'AFI';
                    recordType = inquiryrecordtypeAFI;
                    cs.Email_Inbox__c = afiCustomerArr[0].trim();
                    System.debug('Email_Inbox__c '+cs.Email_Inbox__c +' ' + entity);
                    isUsingForwaderAddress = true;
                } else if(headers.indexOf(afiHelplineArr[1].trim()) != -1){
                    entity = 'AFI';
                    recordType = inquiryrecordtypeAFI;
                    cs.Email_Inbox__c = afiHelplineArr[0].trim();
                    isUsingForwaderAddress = true;
                    System.debug('Email_Inbox__c '+cs.Email_Inbox__c +' ' + entity);
                } else if(headers.indexOf(amfsCustomerArr[1].trim()) != -1){
                    entity = 'AMFS';
                    recordType = inquiryrecordtypeAMFS;
                    cs.Email_Inbox__c = amfsCustomerArr[0].trim();
                    isUsingForwaderAddress = true;
                    System.debug('Email_Inbox__c '+cs.Email_Inbox__c +' ' + entity);
                } else if(headers.indexOf(amfsNasabahArr[1].trim()) != -1){
                    entity = 'AMFS';
                    recordType = inquiryrecordtypeAMFS;
                    cs.Email_Inbox__c = amfsNasabahArr[0].trim();
                    isUsingForwaderAddress = true;
                    System.debug('Email_Inbox__c '+cs.Email_Inbox__c +' ' + entity);
                } else if(headers.indexOf(amfsPriorityArr[1].trim()) != -1){
                    entity = 'AMFS';
                    recordType = inquiryrecordtypeAMFS;
                    cs.Email_Inbox__c = amfsPriorityArr[0].trim();
                    isUsingForwaderAddress = true;
                    System.debug('Email_Inbox__c '+cs.Email_Inbox__c +' ' + entity);
                } else if(headers.indexOf(magiArr[1].trim()) != -1){
                    entity = 'MAGI';
                    recordType = inquiryrecordtypeMAGI;
                    cs.Email_Inbox__c = magiArr[0].trim();
                    isUsingForwaderAddress = true;
                    System.debug('Email_Inbox__c '+cs.Email_Inbox__c +' ' + entity);
                } else if(headers.indexOf(aliArr[1].trim()) != -1){
                    entity = 'ALI';
                    recordType = inquiryrecordtypeALI;
                    cs.Email_Inbox__c = aliArr[0].trim();
                    isUsingForwaderAddress = true;
                    System.debug('Email_Inbox__c '+cs.Email_Inbox__c +' ' + entity);
                }
                    System.debug('Email_Inbox__c 2 '+cs.Email_Inbox__c +' ' + entity);
                
                /*-------------------------------- Added by Hamfry in CCC Wave 2  -----------------------------
                //Checking the CC Address
                if(emailMsg.CcAddress != null && !isUsingForwaderAddress){
                    if(emailMsg.CcAddress.contains(';')){
                        system.debug('CC Address contains semicolon: '+emailMsg.CcAddress);
                        
                        String[] ccAddressSplit = emailMsg.CcAddress.split(';');
                        system.debug('ccAddressSplit: '+ccAddressSplit);
                        
                        //begin:modified by WK, 20170223 to fix problem on email inbox determination based on 'email to address', 'email cc address'
                        for(string address: ccAddressSplit){
                            comparedValue = address+'#'+emailMsg.Subject;                           
                            
                            if((emailafi.indexOf(address.trim())!= -1 || address.trim() == emailaskafi) && !comparingValues.contains(comparedValue)){
                                entity = 'AFI';
                                recordType = inquiryrecordtypeAFI;
                                system.debug('Entity = AFI, found in CC Address with semicolon');
                                
                                /* ----------- Checking long email address ----------- 
                                if(address == afiCustomerArr[1].trim()){
                                    cs.Email_Inbox__c = afiCustomerArr[0].trim();   
                                }
                                else if(address == afiHelplineArr[1].trim()){
                                    cs.Email_Inbox__c = afiHelplineArr[0].trim();   
                                }
                                else{
                                    cs.Email_Inbox__c = address.trim();
                                }
                                System.debug('masuk multi cc address AFI '+comparedValue);
                                comparingValues.add(comparedValue); 
                                break;
                            }
                            /** START add ALI by MII
                            else if((emailali.indexOf(address.trim())!= -1 || address.trim() == emailaskali) && !comparingValues.contains(comparedValue)){
                                entity = 'ALI';
                                //recordType = inquiryrecordtypeAFI;
                                system.debug('Entity = ALI, found in CC Address with semicolon');
                                
                                /* ----------- Checking long email address ----------- 
                                /*
                                if(address == aliCustomerArr[1].trim()){
                                    cs.Email_Inbox__c = aliCustomerArr[0].trim();   
                                }
                                else if(address == aliHelplineArr[1].trim()){
                                    cs.Email_Inbox__c = aliHelplineArr[0].trim();   
                                }
                                else{
                                  
                                    cs.Email_Inbox__c = address.trim();
                                //}
                                System.debug('masuk multi cc address ALI '+comparedValue);
                                comparingValues.add(comparedValue); 
                                break;
                            }
                            /** FINISH 
                            else if((emailamfs.indexOf(address.trim()) != -1 || address.trim() == emailaskamfs) && !comparingValues.contains(comparedValue)){
                                entity = 'AMFS';
                                recordType = inquiryrecordtypeAMFS;
                                system.debug('Entity = AMFS, found in CC Address with semicolon');
                                
                                if(address == amfsCustomerArr[1].trim()){                                    cs.Email_Inbox__c = amfsCustomerArr[0].trim(); 
                                }
                                else if(address == amfsNasabahArr[1].trim()){                                    cs.Email_Inbox__c = amfsNasabahArr[0].trim();  
                                }
                                else if(address == amfsPriorityArr[1].trim()){                                    cs.Email_Inbox__c = amfsPriorityArr[0].trim();    
                                }
                                else{
                                    cs.Email_Inbox__c = address.trim(); 
                                }
                                System.debug('masuk multi cc address AMFS '+comparedValue);
                                comparingValues.add(comparedValue); 
                                break;
                            }else if((emailmagi.indexOf(address.trim()) != -1 || address.trim() == emailaskmagi) && !comparingValues.contains(comparedValue)){
                                entity = 'MAGI';                                recordType = inquiryrecordtypeMAGI;
                                system.debug('Entity = MAGI, found in CC Address with semicolon');
                                
                                if(address == magiArr[1].trim()){                                    cs.Email_Inbox__c = magiArr[0].trim(); 
                                }
                                else{                                    cs.Email_Inbox__c = address.trim(); 
                                }
                                System.debug('masuk multi cc address MAGI '+comparedValue);
                                comparingValues.add(comparedValue);
                                break;
                            }     
                        }
                        system.debug('Case email inbox: '+cs.Email_Inbox__c);
                    }else{
                        system.debug('If CC Address doesnt contain semicolon');
                        comparedValue = emailMsg.CcAddress+'#'+emailMsg.Subject;
                        
                        if((emailafi.indexOf(emailMsg.CcAddress)!= -1 || emailMsg.CcAddress == emailaskafi) && !comparingValues.contains(comparedValue)){
                            entity = 'AFI';                            recordType = inquiryrecordtypeAFI;
                            system.debug('Entity = AFI, found in CC Address without semicolon');
                            
                            if(emailMsg.CcAddress == afiCustomerArr[1].trim()){                                cs.Email_Inbox__c = afiCustomerArr[0].trim();    
                            }
                            else if(emailMsg.CcAddress == afiHelplineArr[1].trim()){                                cs.Email_Inbox__c = afiHelplineArr[0].trim();   
                            }
                            else{                                cs.Email_Inbox__c = emailMsg.CcAddress; 
                            }
                            System.debug('masuk single cc address AFI '+comparedValue);
                            comparingValues.add(comparedValue);
                        }else if((emailamfs.indexOf(emailMsg.CcAddress) != -1 || emailMsg.CcAddress == emailaskamfs) && !comparingValues.contains(comparedValue)){
                            entity = 'AMFS';
                            recordType = inquiryrecordtypeAMFS;
                            system.debug('Entity = AMFS, found in CC Address without semicolon');
                            
                            if(emailMsg.CcAddress == amfsCustomerArr[1].trim()){                                cs.Email_Inbox__c = amfsCustomerArr[0].trim();  
                            }
                            else if(emailMsg.CcAddress == amfsNasabahArr[1].trim()){                                cs.Email_Inbox__c = amfsNasabahArr[0].trim();   
                            }
                            else if(emailMsg.CcAddress == amfsPriorityArr[1].trim()){                                cs.Email_Inbox__c = amfsPriorityArr[0].trim(); 
                            }
                            else{
                                cs.Email_Inbox__c = emailMsg.CcAddress; 
                            }
                            System.debug('masuk single cc address AMFS '+comparedValue);
                            comparingValues.add(comparedValue);
                        }
                        /** START add ALI by MII 
                        else if((emailali.indexOf(emailMsg.CcAddress)!= -1 || emailMsg.CcAddress == emailaskali) && !comparingValues.contains(comparedValue)){
                            entity = 'ALI'; cs.Email_Inbox__c = emailMsg.CcAddress; comparingValues.add(comparedValue);
                            //recordType = inquiryrecordtypeAFI;
                            system.debug('Entity = ALI, found in CC Address without semicolon');
                            /*
                            if(emailMsg.CcAddress == aliCustomerArr[1].trim()){
                                cs.Email_Inbox__c = aliCustomerArr[0].trim();   
                            }
                            else if(emailMsg.CcAddress == aliHelplineArr[1].trim()){
                                cs.Email_Inbox__c = aliHelplineArr[0].trim();   
                            }
                            else{
                              
                                //cs.Email_Inbox__c = emailMsg.CcAddress; 
                            //}
                            //comparingValues.add(comparedValue);
                            System.debug('masuk single cc address ALI '+comparedValue);
                        }
                        /** FINISH 
                        else if((emailmagi.indexOf(emailMsg.CcAddress) != -1 || emailMsg.CcAddress == emailaskmagi) && !comparingValues.contains(comparedValue)){
                            entity = 'MAGI';
                            recordType = inquiryrecordtypeMAGI;
                            system.debug('Entity = MAGI, found in CC Address without semicolon');
                            
                            if(emailMsg.CcAddress == magiArr[1].trim()){                                cs.Email_Inbox__c = magiArr[0].trim();  
                            }
                            else{
                                cs.Email_Inbox__c = emailMsg.CcAddress; 
                            }
                            System.debug('masuk single cc address MAGI '+comparedValue);
                            comparingValues.add(comparedValue);
                        }
                        
                        system.debug('Case email inbox: '+cs.Email_Inbox__c);
                        //end:modified by WK, 20170223 to fix problem on email inbox determination based on 'email to address', 'email cc address'
                    }
                }
                
                //Checking the To Address
                if(emailMsg.ToAddress != null && !isUsingForwaderAddress){
                    if(emailMsg.ToAddress.contains(';')){
                        String[] toAddressSplit = emailMsg.ToAddress.split(';');
                        system.debug('toAddressSplit: '+toAddressSplit);
                        
                        //begin: modified by WK, 20170223 to fix problem on email inbox determination based on 'email to address', 'email cc address'
                        for(string address: toAddressSplit){
                            comparedValue = address+'#'+emailMsg.Subject;                           
                            
                            if((emailafi.indexOf(address.trim())!= -1 || address.trim() == emailaskafi) && !comparingValues.contains(comparedValue)){
                                entity = 'AFI';                                recordType = inquiryrecordtypeAFI;
                                
                                if(address == afiCustomerArr[1].trim()){                                    cs.Email_Inbox__c = afiCustomerArr[0].trim();   
                                }
                                else if(address == afiHelplineArr[1].trim()){                                    cs.Email_Inbox__c = afiHelplineArr[0].trim();  
                                }
                                else{                                    cs.Email_Inbox__c = address.trim();
                                }
                                System.debug('masuk multi to address AFI '+comparedValue);
                                comparingValues.add(comparedValue);
                                break;
                            }else if((emailmagi.indexOf(address.trim()) != -1 || address.trim() == emailaskmagi) && !comparingValues.contains(comparedValue)){
                                entity = 'MAGI';                                recordType = inquiryrecordtypeMAGI;
                                
                                if(address == magiArr[1].trim()){                                    cs.Email_Inbox__c = magiArr[0].trim(); 
                                }
                                else{                                    cs.Email_Inbox__c = address.trim(); 
                                }
                                System.debug('masuk multi to address MAGI '+comparedValue);
                                comparingValues.add(comparedValue);
                                break;
                            }
                            /** START add ALI by MII 
                            else if((emailali.indexOf(address.trim())!= -1 || address.trim() == emailaskali) && !comparingValues.contains(comparedValue)){
                                entity = 'ALI'; cs.Email_Inbox__c = address.trim(); comparingValues.add(comparedValue); break;
                                //recordType = inquiryrecordtypeAFI;
                              /*  
                                if(address == aliCustomerArr[1].trim()){
                                    cs.Email_Inbox__c = aliCustomerArr[0].trim();   
                                }
                                else if(address == aliHelplineArr[1].trim()){
                                    cs.Email_Inbox__c = aliHelplineArr[0].trim();   
                                }
                                else{
                                
                                    //cs.Email_Inbox__c = address.trim();
                                //}
                                //comparingValues.add(comparedValue);
                                //break;
                                System.debug('masuk multi to address ALI '+comparedValue);
                            }
                            /** finish 
                            else if((emailamfs.indexOf(address.trim()) != -1 || address.trim() == emailaskamfs) && !comparingValues.contains(comparedValue)){
                                entity = 'AMFS';
                                recordType = inquiryrecordtypeAMFS;
                                
                                if(address == amfsCustomerArr[1].trim()){                                    cs.Email_Inbox__c = amfsCustomerArr[0].trim(); 
                                }
                                else if(address == amfsNasabahArr[1].trim()){                                    cs.Email_Inbox__c = amfsNasabahArr[0].trim();  
                                }
                                else if(address == amfsPriorityArr[1].trim()){                                    cs.Email_Inbox__c = amfsPriorityArr[0].trim();    
                                }
                                else{
                                    cs.Email_Inbox__c = address.trim(); 
                                }
                                System.debug('masuk multi to address AMFS '+comparedValue);
                                comparingValues.add(comparedValue);
                                break;
                            }
                        }
                        system.debug('Case email inbox: '+cs.Email_Inbox__c);
                    }else{
                        comparedValue = emailMsg.ToAddress+'#'+emailMsg.Subject;
                        
                        if((emailafi.indexOf(emailMsg.ToAddress)!= -1 || emailMsg.ToAddress == emailaskafi) && !comparingValues.contains(comparedValue)){
                            entity = 'AFI';
                            recordType = inquiryrecordtypeAFI;
                            system.debug('Entity = AFI, found in To Address without semicolon');
                            
                            if(emailMsg.ToAddress == afiCustomerArr[1].trim()){                                cs.Email_Inbox__c = afiCustomerArr[0].trim();    
                            }
                            else if(emailMsg.ToAddress == afiHelplineArr[1].trim()){                                cs.Email_Inbox__c = afiHelplineArr[0].trim();   
                            }
                            else{
                                cs.Email_Inbox__c = emailMsg.ToAddress; 
                            }
                            System.debug('masuk single to address AFI '+comparedValue);
                            comparingValues.add(comparedValue);
                        }else if((emailamfs.indexOf(emailMsg.ToAddress) != -1 || emailMsg.ToAddress == emailaskamfs) && !comparingValues.contains(comparedValue)){
                            entity = 'AMFS';
                            recordType = inquiryrecordtypeAMFS;
                            system.debug('Entity = AMFS, found in To Address without semicolon');
                            
                            if(emailMsg.ToAddress == amfsCustomerArr[1].trim()){                                cs.Email_Inbox__c = amfsCustomerArr[0].trim();  
                            }
                            else if(emailMsg.ToAddress == amfsNasabahArr[1].trim()){                                cs.Email_Inbox__c = amfsNasabahArr[0].trim();   
                            }
                            else if(emailMsg.ToAddress == amfsPriorityArr[1].trim()){                                cs.Email_Inbox__c = amfsPriorityArr[0].trim(); 
                            }
                            else{
                                cs.Email_Inbox__c = emailMsg.ToAddress; 
                            }
                            System.debug('masuk single to address AMFS '+comparedValue);
                            comparingValues.add(comparedValue);
                        }else if((emailmagi.indexOf(emailMsg.ToAddress) != -1 || emailMsg.ToAddress == emailaskmagi) && !comparingValues.contains(comparedValue)){
                            entity = 'MAGI';
                            recordType = inquiryrecordtypeMAGI;
                            system.debug('Entity = MAGI, found in To Address without semicolon');
                            
                            if(emailMsg.ToAddress == magiArr[1].trim()){                                cs.Email_Inbox__c = magiArr[0].trim();  
                            }
                            else{
                                cs.Email_Inbox__c = emailMsg.ToAddress; 
                            }
                            System.debug('masuk single to address MAGI '+comparedValue);
                            comparingValues.add(comparedValue);
                        }
                        /** start add ali by MII 
                        else if((emailali.indexOf(emailMsg.ToAddress)!= -1 || emailMsg.ToAddress == emailaskali) && !comparingValues.contains(comparedValue)){
                            entity = 'ALI'; cs.Email_Inbox__c = emailMsg.fromaddress; comparingValues.add(comparedValue);
                            //recordType = inquiryrecordtypeAFI;
                            system.debug('Entity = ALI, found in To Address without semicolon');
                            /*
                            if(emailMsg.ToAddress == aliCustomerArr[1].trim()){
                                cs.Email_Inbox__c = aliCustomerArr[0].trim();   
                            }
                            else if(emailMsg.ToAddress == aliHelplineArr[1].trim()){
                                cs.Email_Inbox__c = aliHelplineArr[0].trim();   
                            }
                            else{
                            
                               // cs.Email_Inbox__c = emailMsg.ToAddress; 
                            //}
                            // comparingValues.add(comparedValue);
                            System.debug('masuk single to address ALI '+comparedValue);
                        }
                        /** FINISH 
                        system.debug('Case email inbox: '+cs.Email_Inbox__c);
                        //end: modified by WK, 20170223 to fix problem on email inbox determination based on 'email to address', 'email cc address'
                    }
                }
                ---------------------------------------------Finish-------------------------------------------*/
                
                cs.Entity_Backup__c = entity;
                system.debug('Entity backup set for the first time: '+cs.Entity_Backup__c);
                
                //cs.recordtypeid = recordType;
                if(recordType!=null) cs.recordtypeid = recordType;
                cs.Origin = 'Email';
                cs.e2cIsAutoReply__c = true;
                cs.First_Inbox__c = cs.Email_Inbox__c; 
                cs.Email_Message_Date__c = emailMsg.CreatedDate;
                /*
if(emailMsg.ToAddress != null && emailMsg.ToAddress.length() > 255){
cs.e2cEmailTo_New__c = emailMsg.ToAddress.Substring(0,255);
}else{
cs.e2cEmailTo_New__c = emailMsg.ToAddress;
}
if(emailMsg.CCAddress != null && emailMsg.CCAddress.length() > 255){
cs.e2cEmailCC__c = emailMsg.CCAddress.Substring(0,255);
}else{
cs.e2cEmailCC__c = emailMsg.CCAddress;
}
*/
                cs.e2cEmailToAddress__c = emailMsg.ToAddress;
                cs.e2cEmailCCAddress__c = emailMsg.CCAddress;
                
                /*--------------------------- Added by Hamfry in CCC Wave 2  -------------------------*/
                String createDate = emailMsg.CreatedDate.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
                String[] toAddresses = new String[] {emailMsg.ToAddress};
                    Integer hours = Integer.valueOf(createDate.substring(11, 13));
                Integer minutes = Integer.valueOf(createDate.substring(14, 16));
                
                if(emailMsg.CreatedDate.format('E') != 'Sat' && emailMsg.CreatedDate.format('E') != 'Sun' && emailMsg.CreatedDate.date() != holiday){
                    if(hours < integer.valueOf(startWorkingHour) || hours >= integer.valueOf(endWorkingHour)){
                        
                        cs.Created_Out_Of_Office_Hour__c = true;
                        
                        if(entity == 'MAGI'){
                            /*--------------- Trigger for sending auto-reply email after hours (template provided in the Email Template) ---------------
dummyContact = [select id, Email from Contact where Email like '%yahoo.co.id' and Policy_No_Numeric__c like '%00%' AND Entity__c = :entity limit 1];
mail = new Messaging.SingleEmailMessage();
mail.setToAddresses(toAddresses);
if(emailMsg.ToAddress != null){
if(emailmagi.indexOf(emailMsg.ToAddress) != -1 || emailMsg.ToAddress == emailaskmagi){
mail.setTemplateId(templateMAGI.id);
}  
}
if(emailMsg.CcAddress != null){
if(emailmagi.indexOf(emailMsg.CcAddress) != -1 || emailMsg.CcAddress == emailaskmagi){
mail.setTemplateId(templateMAGI.id);
} 
}
mail.setTargetObjectId(dummyContact.id); 
mail.setSaveAsActivity(false);
mail.setWhatId(emailMsg.ParentId);
maillist.add(mail);
if(!Test.isRunningTest()){
// Send dummy email in a transaction, then roll it back
Savepoint sp = Database.setSavepoint();
Messaging.sendEmail(maillist);
Database.rollback(sp);

//Send actual email
for (Messaging.SingleEmailMessage email : maillist) {
Messaging.SingleEmailMessage emailToSend = new Messaging.SingleEmailMessage();
emailToSend.setToAddresses(email.getToAddresses());
emailToSend.setPlainTextBody(email.getPlainTextBody());
emailToSend.setHTMLBody(email.getHTMLBody());
emailToSend.setSubject(email.getSubject());
lstMsgsToSend.add(emailToSend);
}
}
*/
                        }
                    }else{
                        cs.Email_Due_Date_In_Datetime__c = dueDateEmail;
                        cs.Email_Due_Date__c = dueDateEmailInLocal; // Set email SLA in Case object
                    }    
                    /*
//Start looping for email automatic distribution    -----> Old codes
for(Email_Assignment__c eaLoop: emailAssign){
system.debug('eaLoop.Inbox__r.Email_Address__c: '+eaLoop.Inbox__r.Email_Address__c);

if(eaLoop.Inbox__r.Email_Address__c == cs.Email_Inbox__c){
cs.OwnerId = eaLoop.User__c;    

Email_Config__c ec = new Email_Config__c();
ec.Id = eaLoop.Inbox__c;

if(eaLoop.Inbox__r.Last_Order_No__c >= max){
ec.Last_Order_No__c = min;
}
else{
if(eaLoop.Inbox__r.Last_Order_No__c >= eaLoop.Order__c){
continue;
}
ec.Last_Order_No__c = eaLoop.Order__c;
system.debug('Setting last order in trigger Avantbox..');
}
emailConfigList.add(ec);
break;
}
}
*/
                }else{
                    cs.Created_Out_Of_Office_Hour__c = true;
                    system.debug('Today is weekend/holiday, emailMsg.CreatedDate.format(E) : '+emailMsg.CreatedDate.format('E'));
                }
                /*---------------------Start looping for email automatic distribution --------------------*/  
                for(AggregateResult aggRes : [SELECT Inbox__r.Email_Address__c addr, MIN(Order__c) minOrder, MAX(Order__c) maxOrder FROM Email_Assignment__c WHERE Inbox__r.Email_Address__c = :cs.Email_Inbox__c AND Is_Active__c = true group by Inbox__r.Email_Address__c]) {
                    addressInAggregate = (String)aggRes.get('addr');
                    min = (Decimal) aggRes.get('minOrder'); 
                    max = (Decimal) aggRes.get('maxOrder');
                    //break;
                }
                
                //for(Email_Assignment__c eaLoop: emailAssign){
                for(Email_Assignment__c eaLoop: [SELECT Id, User__c, user__r.isactive, Inbox__c, Order__c, Inbox__r.Email_Address__c, Inbox__r.Entity__c, Inbox__r.Last_Order_No__c FROM Email_Assignment__c WHERE Inbox__r.Email_Address__c = :cs.Email_Inbox__c AND Is_Active__c = true order by Order__c]){
                    system.debug('eaLoop list in trigger Avantbox: '+eaLoop);
                    system.debug('eaLoop.Inbox__r.Email_Address__c: '+eaLoop.Inbox__r.Email_Address__c);
                    
                    if(eaLoop.Inbox__r.Email_Address__c == cs.Email_Inbox__c){
                        system.debug('addressInAggregate in trigger Avantbox: '+addressInAggregate);
                        system.debug('Minimum value: '+min+ ', maximum value: '+max);
                        System.debug('User__c id '+eaLoop.User__c+' active? '+eaLoop.user__r.isactive);
                        
                        //Update, 17 Feb 2020
                        if(cs.Entity_Backup__c != 'AFI' && cs.Entity_Backup__c != 'ALI'){
                            cs.OwnerId = eaLoop.User__c;    /*----------------------- the working code ------------------------*/
                        }
                        //END - Update, 17 Feb 2020
                        
                        Email_Config__c ec = new Email_Config__c();
                        ec.Id = eaLoop.Inbox__c;
                        
                        system.debug('eaLoop.Inbox__r.Last_Order_No__c in trigger Avantbox: '+eaLoop.Inbox__r.Last_Order_No__c);
                        
                        if(eaLoop.Inbox__r.Last_Order_No__c >= max){
                            ec.Last_Order_No__c = min;
                            system.debug('Setting ec.Last_Order_No__c to min: '+ec.Last_Order_No__c);
                        }
                        else{
                            if(eaLoop.Inbox__r.Last_Order_No__c >= eaLoop.Order__c){
                                continue;
                            }
                            system.debug('eaLoop.Order__c in trigger Avantbox: '+eaLoop.Order__c);
                            system.debug('Setting last order in trigger Avantbox..');
                            ec.Last_Order_No__c = eaLoop.Order__c;
                        }
                        system.debug('Setting case owner ID in Trigger Avantbox: '+cs.OwnerId);
                        system.debug('ec.Last_Order_No__c in trigger Avantbox: '+ec.Last_Order_No__c);
                        emailConfigList.add(ec);
                        
                        Incoming_Email_Checker__c iec = new Incoming_Email_Checker__c();
                        iec.Case_Id__c = cs.Id;
                        iec.Case_Email_Inbox__c = cs.Email_Inbox__c;
                        iec.Case_Owner_ID__c = cs.OwnerId;
                        iec.Case_Subject__c = emailMsg.Subject;
                        if(emailMsg.Subject != null && emailMsg.Subject.length() > 255){
                            iec.Case_Subject__c = emailMsg.Subject.Substring(0,255);
                        }else{
                            iec.Case_Subject__c = emailMsg.Subject;
                        }
                        if(emailMsg.ToAddress != null && emailMsg.ToAddress.length() > 255){
                            iec.Case_ToAddress__c = emailMsg.ToAddress.Substring(0,255);
                        }else{
                            iec.Case_ToAddress__c = emailMsg.ToAddress;
                        }
                        iec.Email_Config_ID__c = ec.Id;
                        iec.Email_Config_Last_Order__c = ec.Last_Order_No__c;
                        iec.Email_Config_Last_Order_Original__c = eaLoop.Inbox__r.Last_Order_No__c;
                        incomingEmailList.add(iec);
                        
                        break;
                    }
                }
                /*--------------------------------------------------Finish--------------------------------------------------*/
                
                CommonClass commonCls = new CommonClass();
                if(!Test.isRunningTest()){
                    if(emailMsg.ToAddress != null){
                        if(emailafi.indexOf(emailMsg.ToAddress)!= -1 || emailamfs.indexOf(emailMsg.ToAddress) != -1 || emailmagi.indexOf(emailMsg.ToAddress) != -1){
                            
                            boolean isWorkingDay = commonCls.checkifItisWorkingDay(system.today());
                            system.debug('>>> entity : '+entity );            
                            system.debug('>>> isWorkingDay : '+isWorkingDay);            
                            //commonCls.doSendEmail (''+emailMsg.FromAddress, ''+emailMsg.ToAddress, templateId, entity) ;  //TODO: nanti diubah ke bentuk bulk
                            
                            cs.e2cIsHoliday__c = !isWorkingDay;
                            cs.e2cAutoReplyType__c = 'WithoutData';
                            cs.e2cEmailFrom__c = emailMsg.FromAddress;
                        }else if(emailMsg.ToAddress == emailaskafi || emailMsg.ToAddress == emailaskamfs || emailMsg.ToAddress == emailaskmagi){
                            cs.e2cAutoReplyType__c = 'WithData';
                            cs.e2cSubject__c = emailMsg.subject;
                            cs.e2cEmailFrom__c = emailMsg.FromAddress;
                            if(entity == 'MAGI'){
                                //!!--> using workflow rule : if(case.entity_backup__c == 'MAGI') then email this message (use specific template)
                                //'Mohon maaf, layanan ini tidak berlaku untuk nasabah MAGI. Silahkan hubungi Customer Care Centre kami di '+email;
                                continue;
                            }
                            entityMap.put(emailMsg.id, entity);
                            system.debug('>>> emailMsg.subject : '+emailMsg.subject);
                            if(emailMsg.subject!='' && (emailMsg.subject.indexof('SALDO')!=-1 || emailMsg.subject.indexof('PAYDT')!=-1 || emailMsg.subject.indexof('NAV')!=-1) ){
                                subjectmsgArr = emailMsg.subject.split(' '); 
                                policyNo = subjectmsgArr[1];    
                                cs.e2cPolicy_No__c = policyNo;
                            }   
                            else {
                                cs.e2cNav__c = '<p>Mohon maaf, format penulisan salah. Silahkan ulangi dengan format yang sesuai.<br>'+
                                    'Cek Saldo, kirim email dengan subject SALDO<Spasi><No Polis> Contoh: SALDO 510-9999999, SALDO 510-9999999<br>'+
                                    'Cek Pay To Date, kirim email dengan subject PAYDT<Spasi><No Polis> Contoh: PAYDT 510-9999999<br>'+
                                    'Cek harga unit, kirim email dengan subject NAV<Spasi><No Polis> Contoh: NAV 510-9999999</p>';
                                continue;
                            }  
                            if(policyNo!=null && policyNo!='' && !policyMap.containsKey(policyNo)){
                                policyMap.put(policyNo, emailMsg);
                                caseMap.put(policyNo, cs);
                            }
                        }
                    }
                }
                System.debug('CS : '+cs);
                caselist.add(cs);
                
                /*
Email2Case_Log__c e2c = new Email2Case_Log__c();
e2c.Case_ID__c = cs.Id;
e2c.Case_Number__c = Decimal.valueOf(cs.CaseNumber);
e2c.Received_Date__c = emailMsg.CreatedDate;
e2c.Status__c = 'Success';
if(emailMsg.Subject != null && emailMsg.Subject.length() > 255){
e2c.Email_Subject__c = emailMsg.Subject.Substring(0,255);
}else{
e2c.Email_Subject__c = emailMsg.Subject;
}
if(emailMsg.ToAddress != null && emailMsg.ToAddress.length() > 255){
e2c.To_Address__c = emailMsg.ToAddress.Substring(0,255);
}else{
e2c.To_Address__c = emailMsg.ToAddress;
}
if(emailMsg.CcAddress != null && emailMsg.CcAddress.length() > 255){
e2c.CC_Address__c = emailMsg.CcAddress.Substring(0,255);
}else{
e2c.CC_Address__c = emailMsg.CcAddress;
}
email2caseLogList.add(e2c);
*/
            }
            i++;
            
        }   //end of Else (line 311)
        
        system.debug('Entity after insert: '+entity);
        system.debug('Record type after insert: ' +recordType);
        
        List<Contact> contactList = [select id, policy_no__c, entity__c, policyapp__c, email from contact where Policy_No__c in :policyMap.keySet() ]; 
        EmailMessage msg = null;
        boolean isExist = false;
        List<Case> casesToBeProcessed = new List<Case>();
        String caseidarr = '';
        Case currCase = null;
        String mode = 'NAV';
        for(string polNo : policyMap.keySet()){
            isExist = false;
            msg = policyMap.get(polNo); 
            currCase = caseMap.get(polNo);
            for(Contact con : contactList){
                if(con.policy_no__c.touppercase() == polNo.touppercase()){
                    isExist = true;
                    system.debug('>>> isExist : '+isExist);
                }
                if(isExist && msg.FromAddress.toUpperCase() != con.email.toUpperCase() ){
                    //!!--> using workflow rule : if(contact.email != case.e2cEmailFrom__c) then email this message (use specific template)
                    //'Mohon maaf, alamat email Anda belum terdaftar. Silahkan hubungi Customer Care Centre kami di '+emailMap.get(con.entity__c);
                    break;
                }
                if((isExist && con.entity__c == 'AFI' && ( con.policyapp__c.touppercase() == 'RLS' || con.policyapp__c.touppercase() == 'CLIPPER' )) || (isExist && con.entity__c == 'AMFS' && con.policyapp__c.touppercase() == 'RLS' ) ){
                    system.debug('>>> call controller.callDataviaWS() ');
                    currCase.e2cIsProcessedByBatch__c = true;
                    currcase.e2cContactId__c = con.id;
                    casesToBeProcessed.add(currCase);
                    caseidarr = caseidarr +'::'+ currCase.id;
                    break;
                }else {
                    //!!--> using workflow rule : if(contact.policy_no__c == case.e2cPolicy_no__c && contact.policy_no__c == case.e2cPolicy_no__c && con.entity__c == 'AFI' && ( con.policyapp__c == 'RLS' || con.policyapp__c == 'CLIPPER' )) || (con.entity__c == 'AMFS' && con.policyapp__c == 'RLS' ) ) then email this message (use specific template)
                    //'Mohon maaf, format subject email yang Anda tuliskan tidak sesuai. Silahkan hubungi Customer Care Centre kami di '+emailMap.get(con.entity__c);;
                    //continue;
                }
            }
        }
        insert emailScoringList;
        system.debug('*system*'+emailScoringList);
        insert incomingEmailList;
        System.debug('Repeatition i : '+i);
        System.debug('Caselist : '+caselist);
        System.debug('total Caselist : '+caselist.size());
        update caselist;
        update casesToBeProcessed;
        
        caseidarr.replaceFirst('::','');
        //update emailConfigList; 
        Map<Id,Email_Config__c> mapEmailConfig = new Map<Id,Email_Config__c>();
        for(Email_Config__c emCon : emailConfigList){
            mapEmailConfig.put(emCon.Id, emCon);
        }
        if(!mapEmailConfig.values().isEmpty()){
            update mapEmailConfig.values();
        }
        /*
if(entity == 'MAGI'){   
Messaging.sendEmail(lstMsgsToSend); //Messaging.sendEmail(maillist);  
}
*/
    }
    
}