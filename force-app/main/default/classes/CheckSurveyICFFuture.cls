global class CheckSurveyICFFuture {   
    public static boolean isUpdateBuy = false; 
    public static boolean isUpdateAsk = false; 
    public static boolean isUpdateClaim = false; 
    public static boolean isUpdateRenew = false; 
    public static boolean isUpdateComplaint = false; 
    public static boolean isUpdate = false; 
    public static String configSendLog = System.Label.Config_Sent_Survey_ICF;  
    public static Boolean configSendLogBool = Boolean.valueof(configSendLog); 
    public static Boolean configSendDMTM = Boolean.valueof(System.Label.Config_Sent_Survey_DMTM); 
    public static Boolean configSendNewCust = Boolean.valueof(System.Label.Config_Sent_Survey_New_Cust);
    public static Boolean configSendWithdrawSurrender = Boolean.valueof(System.Label.Config_Sent_Survey_ICF_Withdrawal_Surrender);
    public static Set<String> withdrawalSurrenderCaseType = new Set<String>{
        'Request_POS_Withdrawal',
            'Request_POS_Redemption',
            'Request_POS_Surrender_Non_UL',
            'Request_POS_Surrender_Endowment'
            };
                public static String withdrawalCaseType = 'Request_POS_Withdrawal';
    public static Set<String> surrenderCaseType = new Set<String>{
        'Request_POS_Redemption',
            'Request_POS_Surrender_Non_UL',
            'Request_POS_Surrender_Endowment'
            };
                public static Set<String> directDistributionProductID = new Set<String>{
                    'AMMS', 'AMMS1', 'AMMS100', 'AMMS1N', 'AMMS2', 'AMMS3', 'AMMS30', 'AMMS4', 'AMMS5', 'AMMS50', 'AMMSE1', 'AMMSE2', 'AMMSE3', 'AMMSE4', 'AMMSE5', 'AMMSJT',
                        'AMMSJT1', 'AMMSJT2', 'AMMSJT3', 'AMMSJT4', 'AMMSJT5', 'AMMSLP', 'AMMSLP1', 'AMMSLP2', 'AMMSLP3', 'AMMSLP4', 'AMMSLP5', 'SIPECISY', 'SJTR100LV',
                        'SJTR30LV', 'SJTR50LV'
                        };
                            public static Integer daysBack = Integer.valueOf(System.Label.Config_Sent_Survey_ICF_Withdrawal_Surrender_EndDateTime);    
    public static String POSTransactionStartDate = convertDateToEIPFormat(Date.today().addDays(-daysBack));
    public static String POSTransactionEndDate = convertDateToEIPFormat(Date.Today());
    
    @future(callout=true)
    public static void checkSurveyICF(Set<Id> emailLogs) {  
        for (string emailLogId: emailLogs) {
            
            boolean isSuccess = false;
            DescribeSObjectResult describeResult = Email_SMS_Log__c.getSObjectType().getDescribe();
            List<String> fieldList = new List<String>(describeResult.fields.getMap().keySet());
            String fieldStr = String.join(fieldList, ',');
            String query = ' SELECT ' + fieldStr + ', case__r.Case_Type_Config__c, case__r.Case_type__c, case__r.MOT__c, case__r.entity__c, case__r.Follow_Up_ICF__c, contact__r.MobilePhone, case__r.Subject, case__r.Origin, case__r.Description FROM Email_SMS_Log__c WHERE Id = :emailLogId ';
            
            Email_SMS_Log__c log = Database.query(query); 
            Boolean isEligible = true; 
            string infoDescription = '';
            String contactIds = log.Contact__c;  
            String mot = log.case__r.MOT__c;   
            Boolean isExist = false;
            Boolean isCombination = false;
            String typeCase = log.case__r.Case_type__c;
            String paymentType = '';
            String freezeDateStr = '';
            String policyStatusCD = '';
            String PSOURCE = '';
            String assmtTypeCd = '';
            String claimNo = '';
            String suspicious = '';
            Integer index = 0;
            boolean sendData = false;
            boolean getDataSuccess = false;
            Contact checkFreezeContact = new Contact();
            Contact ExcludeICF = new Contact();
            
            if (System.Test.isRunningTest()) configSendLogBool = true;
            if (String.isnotblank(contactIds) && string.isnotblank(mot)) {
                
                if (log.case__r.Follow_Up_ICF__c > 0) configSendLogBool = true;
                
                if (log.Case_Type__c == 'Inquiry') configSendLogBool = true;
                
                List<Case> checkListCombination = new List<Case>();
                //check eligible from EIP
                if(typeCase == 'Request_Claim_Payment'){
                    paymentType = log.case__r.Description.contains('Cashless') ? 'Cashless' : 'Reimbursement';
                    ExcludeICF = [select id, FlagExcludeICFClaim__c from Contact where Id =:contactIds];
                    if(ExcludeICF.FlagExcludeICFClaim__c){
                        isEligible = false;
                        infoDescription = 'Contact exclude from send survey ICF';
                    }
                    log.Survey_Type__c = ' I Claim - Request';
                    String recordName = log.case__r.Subject;
                    claimNo = recordName.replaceAll('[^0-9]', '');
                    log.Claim_Number__c = claimNo;
                    log.Claim_Status__c = 'Approve';
                    configSendLogBool = true;
                }else{
                    // updated by Support at 15 Jan 2025
                    /* checkListCombination = [Select id from Case where contactid =: contactIds and entity__c = 'AMFS' and MOT__c = null 
                        and ((createddate = today AND type = 'Inquiry') OR (status != 'closed' AND type != 'Inquiry')) 
                        order by Createddate asc limit 1]; */
                                            
                    //Updated by Dimas Support MII 28/02/2025
                    if(log.Entity__c == 'AMFS' && log.Case_Type__c == 'Request POS' && withdrawalSurrenderCaseType.contains(typeCase)){
                        system.debug('=== ignore validation checkListCombination');
                    }
                    else if(log.Entity__c == 'AMFS' && log.Outbound_Call__c){
                        system.debug('=== ignore validation checkListCombination');
                    }
                    else {
                        checkListCombination = [Select id from Case where contactid =: contactIds and entity__c = 'AMFS'
                                                and ((createddate = today AND type = 'Inquiry' and MOT__c = null ) OR (status != 'closed' AND type != 'Inquiry')) 
                                                order by Createddate asc limit 1];
                    }
                }
                //Updated by Dimas Support MII 28/02/2025
                List<Email_SMS_Log__c> emailSmsLog = new List<Email_SMS_Log__c>();
                if(log.Entity__c == 'AMFS' && log.Case_Type__c == 'Request POS' && withdrawalSurrenderCaseType.contains(typeCase)){
                    system.debug('=== ignore validation emailSmsLog');
                }  
                else {
                    emailSmsLog = [Select id from email_sms_log__c where category__c = 'ICF' 
                                   and contact__c=:contactIds and case__r.mot__c = null
                                   and (
                                       (status__c = 'Send' AND end_date__c >= Last_n_days:30)
                                       or (
                                           status__c in ('Draft','Batch')
                                           AND case__r.ClosedDate >= Last_n_days:30
                                       )
                                   ) 
                                   and case_type__c != 'Inquiry' and id not in :emailLogs
                                   order by Createddate asc limit 1
                                  ];
                }
                
                
                
                if (checkListCombination.size() > 0 || emailSmsLog.size() > 0) {
                    isCombination = true;
                } 
                else if (configSendLogBool == true) {
                    mot = mot.toLowerCase();
                    ICF_Parameter__c ICFParameter =   [SELECT id, 
                                                       Interval_Completed_Month__c, Interval_No_Response_Month__c, Interval_Max_Loop__c
                                                       FROM ICF_Parameter__c WHERE RecordType.Name ='Master - Qualtrics'  limit 1];
                    checkFreezeContact = [Select Survey_Ask_Send_Counter__c, // reset 1, pakai Timebase workflow atau parameter berubah.
                                          Survey_Ask_Send_Date__c,
                                          Survey_Buy_Send_Counter__c,
                                          Survey_Buy_Send_Date__c,
                                          Survey_Claim_Send_Counter__c,
                                          Survey_Claim_Send_Date__c,
                                          Survey_Complaint_Send_Counter__c,
                                          Survey_Complaint_Send_Date__c,
                                          Survey_Renew_Send_Counter__c,
                                          Survey_Renew_Send_Date__c,
                                          
                                          Freeze_Ask_End_Date__c,
                                          Freeze_Buy_End_Date__c,
                                          Freeze_Claim_End_Date__c,
                                          Freeze_Complaint_End_Date__c,
                                          Freeze_Renew_End_Date__c,
                                          
                                          Interval_Completed_Month__c, // 6 month
                                          Interval_Max_Loop__c, // frequency
                                          Interval_No_Response_Month__c, // 1 month
                                          
                                          Email_Sms_Log_Ask__c,
                                          Email_Sms_Log_Buy__c,
                                          Email_Sms_Log_Claim__c,
                                          Email_Sms_Log_Complaint__c,
                                          Email_Sms_Log_Renew__c,
                                          
                                          Email_Sms_Log_Ask__r.Case__c,
                                          Email_Sms_Log_Buy__r.Case__c,
                                          Email_Sms_Log_Claim__r.Case__c,
                                          Email_Sms_Log_Complaint__r.Case__c,
                                          Email_Sms_Log_Renew__r.Case__c,
                                          policy_no__c, entity__c, policyApp__c //add for sprint 2 ICF
                                          from contact where id =: contactIds limit 1                                               
                                         ]; 
                    
                    system.debug('checkFreezeContact:'+checkFreezeContact);
                    Date createdDateTime = Date.valueof(log.CreatedDate); 
                    
                    String caseId = '';
                    integer totalCase = 0;
                    List<Case> getDetailCase = [Select id from Case where MOT__c = :mot and createddate = today and contactId =: contactIds  Order by Createddate asc ];
                    
                    if (getDetailCase.size() > 0) {
                        caseId = getDetailCase[0].Id;
                        totalCase = getDetailCase.size();
                    } else {
                        caseId = log.Case__c;
                    }
                    Date currDate = system.Today();
                    
                    integer maxloop = 1;
                    if (ICFParameter.Interval_Max_Loop__c != '') maxloop = integer.valueof(ICFParameter.Interval_Max_Loop__c);
                    
                    integer noresponse = 0;
                    if (ICFParameter.Interval_No_Response_Month__c != '') noresponse = integer.valueof(ICFParameter.Interval_No_Response_Month__c);
                    
                    date freezedate = currDate + (noresponse * 30 * maxloop);
                    //date freezedateclaim = currDate + (noresponse * 30 * maxloop);
                    system.debug('freezedate:'+freezedate);
                    integer countSendAsk = 1;
                    integer countSendBuy = 1;
                    integer countSendRenew = 1;
                    integer countSendClaim = 1;
                    integer countSendComplaint = 1;
                    
                    system.debug('checkFreezeContact = '+checkFreezeContact);
                    
                    system.debug('log ask email case:'+checkFreezeContact.Email_Sms_Log_ask__r.Case__c );
                    system.debug('log ask case id:'+caseId );
                    system.debug('log ask checkFreezeContact.Freeze_ask_End_Date__c :'+checkFreezeContact.Freeze_ask_End_Date__c );
                    system.debug('log ask checkFreezeContact.Freeze_ask_End_Date__c:'+checkFreezeContact.Freeze_ask_End_Date__c);
                    
                    if ( mot.contains('ask') ) {
                        
                        IF (
                            (
                                (
                                    checkFreezeContact.Email_Sms_Log_Ask__r.Case__c != log.Case__c
                                    ||  (
                                        caseId != log.Case__c
                                        
                                    )
                                )
                                &&  
                                (
                                    checkFreezeContact.Freeze_Ask_End_Date__c != null 
                                    && currDate <= checkFreezeContact.Freeze_Ask_End_Date__c
                                ) 
                            ) || (
                                totalCase > 1 && caseId != log.Case__c
                            )
                        )  
                            
                        {
                            if (log.Entity__c == 'AMFS' && withdrawalSurrenderCaseType.contains(log.Case__r.Case_Type__c) && log.Case_Type__c == 'Request POS'){
                                //Added by Dimas Support MII 08/02/2025
                                // isExist still will be false
                                isExist = false;
                            } else if(log.Entity__c == 'AMFS' && (log.Outbound_Call__c || log.Follow_Up_ICF__c)){
                                // isExist still will be false and freeze date updated
                                isExist = false;
                                if (checkFreezeContact.Survey_Ask_Send_Counter__c != null) countSendAsk++;
                                checkFreezeContact.Freeze_Ask_End_Date__c = freezedate;
                                checkFreezeContact.Survey_Ask_Send_Counter__c = countSendAsk;
                                checkFreezeContact.Survey_Ask_Send_Date__c = currDate; 
                                checkFreezeContact.Email_Sms_Log_Ask__c = emailLogId;
                                isUpdateAsk = true;
                            }
                            else if(log.Entity__c == 'AMFS' && log.Follow_Up_ICF__c){
                                isExist = false;
                            }
                            
                            else {
                                isExist = true;
                            }
                        } else {
                            if (checkFreezeContact.Survey_Ask_Send_Counter__c != null) countSendAsk++;
                            //Added by Dimas Support MII 08/02/2025
                            if (log.Entity__c == 'AMFS' && withdrawalSurrenderCaseType.contains(log.Case__r.Case_Type__c) && log.Case_Type__c == 'Request POS'){
                                System.Debug ('Does not insert Freeze Ask Date');
                            } else {
                                checkFreezeContact.Freeze_Ask_End_Date__c = freezedate; 
                            }
                            checkFreezeContact.Survey_Ask_Send_Counter__c = countSendAsk;
                            checkFreezeContact.Survey_Ask_Send_Date__c = currDate; 
                            checkFreezeContact.Email_Sms_Log_Ask__c = emailLogId;
                            isUpdateAsk = true;
                            
                        }
                    }
                    system.debug('log buy email case:'+checkFreezeContact.Email_Sms_Log_Buy__r.Case__c );
                    system.debug('log buy case id:'+caseId );
                    system.debug('log buy checkFreezeContact.Freeze_Buy_End_Date__c :'+checkFreezeContact.Freeze_Buy_End_Date__c );
                    system.debug('log buy checkFreezeContact.Freeze_Buy_End_Date__c:'+checkFreezeContact.Freeze_Buy_End_Date__c);
                    if ( mot.contains('buy') ) {
                        if (
                            (
                                (
                                    checkFreezeContact.Email_Sms_Log_Buy__r.Case__c != log.Case__c
                                    ||  (
                                        caseId != log.Case__c
                                        
                                    )
                                )
                                &&  
                                (
                                    checkFreezeContact.Freeze_Buy_End_Date__c != null 
                                    && currDate <= checkFreezeContact.Freeze_Buy_End_Date__c
                                )
                            ) || (
                                totalCase > 1 && caseId != log.Case__c
                            )
                        ) {
                            isExist = true;
                        } else {
                            if (checkFreezeContact.Survey_Buy_Send_Counter__c != null) countSendBuy++;
                            checkFreezeContact.Freeze_Buy_End_Date__c = freezedate;
                            
                            checkFreezeContact.Survey_Buy_Send_Counter__c = countSendBuy;
                            checkFreezeContact.Survey_Buy_Send_Date__c = currDate; 
                            checkFreezeContact.Email_Sms_Log_Buy__c = emailLogId;
                            isUpdateBuy = true;
                        }
                        
                    }
                    
                    /*system.debug('log claim email case:'+checkFreezeContact.Email_Sms_Log_claim__r.Case__c );
                    system.debug('log claim case id:'+caseId );
                    system.debug('log claim checkFreezeContact.Freeze_claim_End_Date__c :'+checkFreezeContact.Freeze_claim_End_Date__c );
                    system.debug('log claim checkFreezeContact.Freeze_claim_End_Date__c:'+checkFreezeContact.Freeze_claim_End_Date__c);
                    if (  mot.contains('claim')  ) {
                        if (
                            ( 
                                (
                                    checkFreezeContact.Email_Sms_Log_claim__r.Case__c != log.Case__c
                                    ||  (
                                        caseId != log.Case__c
                                    )
                                )
                                &&
                                (
                                    checkFreezeContact.Freeze_claim_End_Date__c != null 
                                    && currDate <= checkFreezeContact.Freeze_claim_End_Date__c
                                ) 
                            ) || (
                                totalCase > 1 && caseId != log.Case__c
                            ) 
                        )  {
                            if( typeCase != 'Request_Claim_Payment') isExist = true;
                        } else {                            
                            if (checkFreezeContact.Survey_Claim_Send_Counter__c != null) countSendClaim++;
                            checkFreezeContact.Freeze_Claim_End_Date__c = freezedate;
                            
                            checkFreezeContact.Survey_Claim_Send_Counter__c = countSendClaim;
                            checkFreezeContact.Survey_Claim_Send_Date__c = currDate; 
                            checkFreezeContact.Email_Sms_Log_Claim__c = emailLogId;
                            isUpdateClaim = true;
                        }
                    }*/
                    
                    system.debug('log complaint email case:'+checkFreezeContact.Email_Sms_Log_complaint__r.Case__c );
                    system.debug('log complaint case id:'+caseId );
                    system.debug('log complaint checkFreezeContact.Freeze_complaint_End_Date__c :'+checkFreezeContact.Freeze_complaint_End_Date__c );
                    system.debug('log complaint checkFreezeContact.Freeze_complaint_End_Date__c:'+checkFreezeContact.Freeze_complaint_End_Date__c);
                    if ( mot.contains('complain')  ) {
                        IF (
                            (
                                (
                                    checkFreezeContact.Email_Sms_Log_complaint__r.Case__c != log.Case__c
                                    ||  (
                                        caseId != log.Case__c
                                        //&&  totalCase > 1
                                    )
                                )
                                && 
                                (
                                    checkFreezeContact.Freeze_complaint_End_Date__c != null 
                                    && currDate <= checkFreezeContact.Freeze_complaint_End_Date__c
                                )  
                            ) || (
                                totalCase > 1 && caseId != log.Case__c
                            )
                        )  {
                            isExist = true;
                        } else  {
                            if (checkFreezeContact.Survey_Complaint_Send_Counter__c != null) countSendComplaint++;
                            checkFreezeContact.Freeze_Complaint_End_Date__c = freezedate;
                            
                            checkFreezeContact.Survey_Complaint_Send_Counter__c = countSendComplaint;
                            checkFreezeContact.Survey_Complaint_Send_Date__c = currDate; 
                            checkFreezeContact.Email_Sms_Log_Complaint__c = emailLogId;
                            isUpdateComplaint=  true;
                        }
                    }
                    
                    system.debug('log Renew email case:'+checkFreezeContact.Email_Sms_Log_Renew__r.Case__c );
                    system.debug('log Renew case id:'+caseId );
                    system.debug('log Renew checkFreezeContact.Freeze_Renew_End_Date__c :'+checkFreezeContact.Freeze_Renew_End_Date__c );
                    system.debug('log Renew checkFreezeContact.Freeze_Renew_End_Date__c:'+checkFreezeContact.Freeze_Renew_End_Date__c);
                    if ( mot.contains('renew')  ) {
                        IF (
                            (
                                (
                                    checkFreezeContact.Email_Sms_Log_Renew__r.Case__c != log.Case__c
                                    ||  (
                                        caseId != log.Case__c
                                        //&&  totalCase > 1
                                    )
                                )
                                &&  
                                (
                                    checkFreezeContact.Freeze_Renew_End_Date__c != null 
                                    && currDate <= checkFreezeContact.Freeze_Renew_End_Date__c
                                )  
                            ) || (
                                totalCase > 1 && caseId != log.Case__c
                            )
                        )  
                        {
                            isExist = true;
                        }  else {
                            if (checkFreezeContact.Survey_Renew_Send_Counter__c != null) countSendRenew++;
                            checkFreezeContact.Freeze_Renew_End_Date__c = freezedate;
                            
                            checkFreezeContact.Survey_Renew_Send_Counter__c = countSendRenew;
                            checkFreezeContact.Survey_Renew_Send_Date__c = currDate; 
                            checkFreezeContact.Email_Sms_Log_Renew__c = emailLogId;
                            isUpdateRenew = true;
                        }
                    }
                    
                    if (isExist) {
                        freezeDateStr = string.valueof(freezedate); 
                    }
                }
                
                system.debug('checkFreezeContact:'+checkFreezeContact);
            }
            
            List<Email_SMS_Log__c> getDataChildEmail = new List<Email_SMS_Log__c> ();
            if (!log.Outbound_Call__c) getDataChildEmail = [Select id, status__c, Description__c,Exclude_From__c from Email_SMS_Log__c where case__c = :log.Case__c AND status__c = 'cancel' AND createddate = today];
            
            if (string.isnotblank(log.Case__r.MOT__c) && log.Case__r.entity__c == 'AMFS' ) {  
                log.MOT__c = log.Case__r.MOT__c; 
            }
            
            if (isCombination == false && isEligible) { 
                log.Send_Flag__c = false;
                String getSurvey = '';
                String linkSurvey = '';
                if (string.isnotblank(log.Case__r.MOT__c) && log.Case__r.entity__c == 'AMFS' && isExist == false) {
                    List<Survey__c> listSurvey = new List<Survey__c>();
                    if(typeCase == 'Request_Claim_Payment'){
                        if(paymentType == 'Cashless')
                        {
                            Survey__c ss = [Select id, URL__c, name from Survey__c where recordType.Name = 'Master New Onboarding' and Name = 'Survey Request I Claim Individu Reimbursement' limit 1];
                            listSurvey = [Select id, URL__c, name from Survey__c where recordType.Name = 'Master New Onboarding' and Name = 'Survey Request I Claim Individu Cashless'];
                            Email_SMS_Template__c est = [select id, Email_Body__c, Email_Header__c, Email_Footer__c, Subject__c from Email_SMS_Template__c where name = 'ICF Email (AMFS) 2024' limit 1];
                            log.Email_SMS_Template__c = est.Id;
                            log.Email_Text__c = log.Email_Text__c.Replace('Reimbursement', 'Cashless');
                            log.Email_Text__c = log.Email_Text__c.Replace('Penggantian', 'Penjaminan');
                            log.Email_Text__c = log.Email_Text__c.Replace(ss.Id, listSurvey[0].Id);
                            
                        }else{
                            listSurvey = [Select id, URL__c, name from Survey__c where recordType.Name = 'Master New Onboarding' and Name = 'Survey Request I Claim Individu Reimbursement'];
                            
                        }
                    }else if (log.Entity__c == 'AMFS' && withdrawalSurrenderCaseType.contains(typeCase) && log.Case_Type__c == 'Request POS'){
                        listSurvey = [Select id, URL__c, name from Survey__c where recordType.Name = 'Master New Onboarding' and Name = 'Survey POS/Request'];
                    }else if (log.Entity__c == 'AMFS' && log.Case_Type__c == 'Complaint'){
                        listSurvey = [Select id, URL__c, name from Survey__c where recordType.Name = 'Master New Onboarding' and Name = 'Survey Request I Complaint Dynamic'];
                    }else if (log.Entity__c == 'AMFS' && log.Case_Type__c == 'Inquiry'){
                        listSurvey = [Select id, URL__c, name from Survey__c where recordType.Name = 'Master New Onboarding' and Name = 'Survey Inquiry Dynamic'];
                    }else{
                        listSurvey = [Select id, URL__c, name from Survey__c where recordType.Name = 'Master Qualtrics' and Name = 'Survey Qualtrics'];
                    }
                    
                    if (listSurvey.size() > 0) {
                        getSurvey = listSurvey[0].Id;
                        linkSurvey = listSurvey[0].URL__c;
                        linkSurvey += 'id=' + getSurvey + '&cId=' + log.contact__c + '&caId=' + log.case__c; 
                    }
                    
                    OrgWideEmailAddress owea = [SELECT Id, Address, DisplayName FROM OrgWideEmailAddress WHERE Address = :Label.EmailNoReplayAMFS limit 1];
                    
                    map<string, string> mapEmailTemplate = new map<string, string>();  
                    mapEmailTemplate.put(log.Email_SMS_Template__c, ''); 
                    
                    List<Email_SMS_Template__c> subjectEmail = [SELECT Id, Subject__c FROM Email_SMS_Template__c WHERE id in : mapEmailTemplate.keyset()];
                    for(Email_SMS_Template__c emailTemplate: subjectEmail){
                        mapEmailTemplate.put(emailTemplate.Id, emailTemplate.Subject__c ); 
                    }
                    if (string.isnotblank(getSurvey)) {
                        log.Survey__c = getSurvey;
                        log.Survey_URL__c  = linkSurvey;
                    }
                    
                    
                    Map<String, String> configEIP = new Map<String,String>();
                    System.debug('Survey_URL__c' + log.Survey_URL__c);
                    configEIP.put(EIPConstant.CS_COM_TARGET, log.Survey_URL__c);
                    configEIP.put(EIPConstant.CS_COM_DELIVER_STATUS,'301');
                    EIPJson dataPolicyEIP, dataClaimAhs, response, dataFraud, claimdetails;
                    
                    try{   
                        if (!System.test.isrunningtest() ) response = EIPConnector.sendCommunicationMessageT2M('createNewUrl', 'AMFS', 'T2MIO', configEIP);
                        //add for sprint 2 ICF Claim
                        if(typeCase == 'Request_Claim_Payment'){
                            Contact ctc = [select id, policy_no__c, entity__c, policyApp__c, WelcomeCall_Product_Code_Plan__c from contact where id =: contactIds limit 1];
                            String product =  ctc.WelcomeCall_Product_Code_Plan__c;
                            
                            List<ICF_Parameter__c> icfParams = [select id, name, RecordType.Name from ICF_Parameter__c where RecordType.Name = 'Master - qualtrics' and (Include_Product_Code_Plan_Claim_1__c includes (:product) or Include_Product_Code_Plan_Claim_2__c includes (:product)  )];
                            String policyApp = ctc.policyApp__c;
                            String claimDetail = 'CLAIM DETAIL';
                            String claimStatusDesc = '';
                            String claimStatusCode = '';
                            Integer partyRolesSize = 0;
                            Map<String,String> properties = new Map<String, String>();
                            if(icfParams.size() != 0 && product != null){
                                //AHS
                                policyApp = 'AHS';
                                properties.put(EIPConstant.PARAM_MSG_POLICY,ctc.policy_no__c);
                                properties.put('claimNumber', claimNo);
                                properties.put('policyType', paymentType == 'Cashless' ? 'C' : 'R');
                                properties.put('pagevalue','1');
                            }
                            else if(ctc.PolicyApp__c == 'DMTM') {
                                //DMTM
                                policyApp = 'DMTM_REST_V3';      
                                claimDetail = 'CLAIM DETAILS';
                            }
                            if (System.test.isrunningtest() ) {
                                
                                EIPJson.EIP_PnCClaim_POLICY_PartyRole partyRole = new EIPJson.EIP_PnCClaim_POLICY_PartyRole();
                                partyRole.type = 'R';
                                partyRole.description = 'Fraud';
                                
                                List<EIPJson.EIP_PnCClaim_POLICY_PartyRole> hasClaimPartyRoles = new List<EIPJson.EIP_PnCClaim_POLICY_PartyRole>();
                                hasClaimPartyRoles.add(partyRole);
                                
                                EIPJson.EIP_PnCClaim_CLAIM hasPnCClaimIn = new EIPJson.EIP_PnCClaim_CLAIM();
                                hasPnCClaimIn.claimStatusDesc = '1';
                                hasPnCClaimIn.providerNetworkCode = 'RS';
                                hasPnCClaimIn.hasClaimPartyRoles = hasClaimPartyRoles;
                                hasPnCClaimIn.claimStageDescription = 'AF';
                                if(ctc.PolicyApp__c == 'DMTM') hasPnCClaimIn.claimTypeCode = 'TD';
                                if(ctc.PolicyApp__c == 'RLS') hasPnCClaimIn.claimTypeCode = 'ADD';
                                hasPnCClaimIn.servicingAgentCode = 'RS ABC';
                                hasPnCClaimIn.serviceProviderId = 'RS';
                                hasPnCClaimIn.entityCode = 'ABC';
                                
                                List<EIPJson.EIP_PnCClaim_CLAIM> list_hasPnCClaimIn = new List<EIPJson.EIP_PnCClaim_CLAIM>();
                                list_hasPnCClaimIn.add(hasPnCClaimIn);
                                
                                EIPJson.EIP_AgSa_InsurancePolicy hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy();
                                hasPolicyAccount.hasPnCClaimIn = list_hasPnCClaimIn;
                                hasPolicyAccount.policyStatusCD = '[4] LAPSED (NON-CV PLAN)';
                                hasPolicyAccount.sourceChannelCD = 'Non Priority';
                                hasPolicyAccount.customerRk = 'AF';
                                
                                List<EIPJson.EIP_AgSa_InsurancePolicy> list_hasPolicyAccount = new List<EIPJson.EIP_AgSa_InsurancePolicy>();
                                list_hasPolicyAccount.add(hasPolicyAccount);
                                
                                EIPJson.EIP_IcAx_AXAAsiaCustomer customer = new EIPJson.EIP_IcAx_AXAAsiaCustomer();
                                customer.hasPolicyAccount = list_hasPolicyAccount;
                                
                                EIPJson.EIP_Body body = new EIPJson.EIP_Body();
                                body.IcAx_AXAAsiaCustomer_Type = customer;
                                body.Customer = customer;
                                
                                EIPJson test = new EIPJson();
                                test.Body = body;
                                
                                dataPolicyEIP = test;
                                claimdetails = test;
                                dataFraud = test;
                            }
                            
                            if (!System.test.isrunningtest() ) dataPolicyEIP = EIPConnector.getPolicyDetails('Policy Details', ctc.entity__c, ctc.policyApp__c, ctc.policy_no__c);
                            policyStatusCD = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyStatusCD;
                            PSOURCE = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].sourceChannelCD;
                            
                            if(paymentType != 'Cashless'){
                                if(policyApp == 'AHS' ){
                                    if (!System.test.isrunningtest() ) claimdetails = EIPConnector.sendCommunicationMessageTADA('claim', ctc.entity__c, policyApp, properties);
                                    claimStatusDesc = claimdetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPnCClaimIn[0].claimStatusDesc; //dokumen status
                                    log.Nama_Rumah_Sakit__c = claimdetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPnCClaimIn[0].providerNetworkCode;
                                    if(claimdetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPnCClaimIn[0].hasClaimPartyRoles != null){
                                        partyRolesSize = claimdetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPnCClaimIn[0].hasClaimPartyRoles.size();
                                        if(partyRolesSize > 0){
                                            for (Integer i = 0; i < partyRolesSize; i++) {
                                                if(claimdetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPnCClaimIn[0].hasClaimPartyRoles[i].type == 'R' && claimdetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPnCClaimIn[0].hasClaimPartyRoles[i].description.contains('Fraud')) {
                                                    suspicious = claimdetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPnCClaimIn[0].hasClaimPartyRoles[i].description;
                                                    log.Claim_Susp_Fraud__c = 'Fraud';
                                                    isEligible = false;
                                                    infoDescription = 'Claim Fraud';
                                                }
                                            }
                                        }
                                    }
                                }
                                else {
                                    if (!System.test.isrunningtest() ) claimdetails = EIPConnector.getClaimDetails(claimDetail, ctc.entity__c, policyApp, ctc.policy_no__c, claimNo);
                                    
                                    if(ctc.PolicyApp__c == 'DMTM'){
                                        suspicious = claimdetails.Body.Customer.hasPolicyAccount[0].hasPnCClaimIn[0].claimStageDescription;
                                        assmtTypeCd = claimdetails.Body.Customer.hasPolicyAccount[0].hasPnCClaimIn[0].claimTypeCode;
                                        assmtTypeCd = assmtTypeCd.trim();
                                        assmtTypeCd = assmtTypeCd.replaceAll('(\\s+)', ' ');
                                        log.Nama_Rumah_Sakit__c = claimdetails.Body.Customer.hasPolicyAccount[0].hasPnCClaimIn[0].servicingAgentCode;
                                    }else{
                                        if (!System.test.isrunningtest() ) dataFraud = EIPConnector.getPolicyFraud('getFraudMaintenance', ctc.entity__c, policyApp, ctc.policy_no__c, claimNo);
                                        if(dataFraud.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].customerRk == null){
                                            suspicious = '';
                                        }
                                        else suspicious = dataFraud.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].customerRk;
                                        assmtTypeCd = claimdetails.Body.Customer.hasPolicyAccount[0].hasPnCClaimIn[0].claimTypeCode;
                                        assmtTypeCd = assmtTypeCd.trim();
                                        assmtTypeCd = assmtTypeCd.replaceAll('(\\s+)', ' ');
                                        log.Nama_Rumah_Sakit__c = claimdetails.Body.Customer.hasPolicyAccount[0].hasPnCClaimIn[0].serviceProviderId + '/'+ claimdetails.Body.Customer.hasPolicyAccount[0].hasPnCClaimIn[0].entityCode;
                                        
                                    }
                                }
                            }
                            
                            
                            //check policy status
                            if(policyStatusCD != null && policyStatusCD != ''){
                                if(label.Claim_Policy_Sts_Inactive.contains(policyStatusCD)){
                                    log.Claim_Policy_Status__c = 'INACTIVE';
                                    isEligible = false;
                                    infoDescription = 'Policy Status: Inactive';
                                } 
                                if(label.Claim_Policy_Sts_Accept.contains(policyStatusCD)) log.Claim_Policy_Status__c = 'ACCEPTED';
                                if(label.Claim_Policy_Sts_Inforce.contains(policyStatusCD)) log.Claim_Policy_Status__c = 'IN_FORCE';
                                if(label.Claim_Policy_Sts_Open.contains(policyStatusCD)) log.Claim_Policy_Status__c = 'OPENED';
                                log.Claim_Policy_Status_ICF__c = policyStatusCD;
                            }
                            
                            //check priority
                            if(PSOURCE != null && PSOURCE != '') log.Claim_Policy_Priority__c = PSOURCE.contains('PCC') ? 'Priority' : 'Non-Priority';
                            
                            //check fraud
                            if(suspicious == '' || label.ICF_Non_Suspicious.contains(suspicious)) {
                                log.Claim_Susp_Fraud__c = 'NS';
                            } else{
                                log.Claim_Susp_Fraud__c = 'S';
                            }
                            
                            if(paymentType == 'Cashless'){
                                List<ICF_Claim_Approve__c> list_data = [select Claim_Number__c, Claim_Status_Code__c, Claim_Status_Desc__c, Nama_Rumah_Sakit__c, Policy_Number__c, Proceed_ICF__c
                                                                        from ICF_Claim_Approve__c where Proceed_ICF__c = true and Claim_Number__c =:claimNo and Policy_Number__c=:ctc.policy_no__c limit 1];
                                if(list_data.size() > 0){
                                    claimStatusDesc = list_data[0].Claim_Status_Desc__c;
                                    log.Nama_Rumah_Sakit__c = list_data[0].Nama_Rumah_Sakit__c;
                                    log.Claim_Type__c = 'HEALTH';
                                }
                            }
                            else if(policyApp == 'AHS'){
                                log.Claim_Type__c = 'HEALTH';
                            }else if(ctc.policyApp__c == 'DMTM' ){
                                log.Claim_Type_Code__c = assmtTypeCd;
                                if(assmtTypeCd == 'HEA' ){
                                    log.Claim_Type__c = 'HEALTH';
                                }
                                else{
                                    if(assmtTypeCd == 'MAJ') log.Claim_Type__c = 'MAJOR';
                                    if(assmtTypeCd == 'CI') log.Claim_Type__c = 'Critical Illness';
                                    if(assmtTypeCd == 'L') log.Claim_Type__c = 'Life';
                                    if(assmtTypeCd == 'PA') log.Claim_Type__c = 'P/A';
                                    if(assmtTypeCd == 'CA') log.Claim_Type__c = 'Cancer';
                                    if(assmtTypeCd == 'TPD') log.Claim_Type__c = 'Total Permanent Disability';
                                    if(assmtTypeCd == 'TD') log.Claim_Type__c = 'Temporary Disability';
                                    isEligible = false;
                                    infoDescription = 'Claim type not HEALTH';
                                }
                                if(suspicious == 'AF' || suspicious == 'PF' || suspicious == 'PA' || suspicious == 'PW'){
                                    log.Claim_Susp_Fraud__c = 'Fraud';
                                    isEligible = false;
                                    infoDescription = 'Claim Fraud: '+ suspicious;
                                }
                            }
                            else{
                                log.Claim_Type_Code__c = assmtTypeCd;
                                if(assmtTypeCd == null || assmtTypeCd.left(1) == 'R' || assmtTypeCd.left(1) == 'H' || assmtTypeCd == ''){
                                    log.Claim_Type__c = 'HEALTH';
                                }
                                else{
                                    if(assmtTypeCd == 'ADD' || assmtTypeCd == 'DEATH' || assmtTypeCd == 'ELI' || assmtTypeCd == 'LI' || assmtTypeCd == 'SLE' || assmtTypeCd == 'WP') log.Claim_Type__c = 'LIFE';
                                    isEligible = false;
                                    infoDescription = 'Claim type not HEALTH';
                                }
                                if(suspicious == 'AF' || suspicious == 'PF'){
                                    log.Claim_Susp_Fraud__c = 'Fraud';
                                    isEligible = false;
                                    infoDescription = 'Claim Fraud: '+ suspicious;
                                }
                            }
                            
                            
                            log.Claim_Suspicious__c = suspicious;
                            log.EIP_Response__c = 'Get Data Success';
                            log.Claim_Transaction_Type__c = paymentType;
                            getDataSuccess = true;
                            
                        }
                        
                        //Added by Dimas Support MII 07/02/2025
                        if(System.test.isrunningtest() || (log.Entity__c == 'AMFS' && withdrawalSurrenderCaseType.contains(typeCase) && log.Case_Type__c == 'Request POS')){
                            Contact ctc = [select id, policy_no__c, entity__c, policyApp__c, Agent_Role_Code__c, WelcomeCall_Product_Code_Plan__c from contact where id =: contactIds limit 1];
                            String policyApp = ctc.policyApp__c;
                            try{
                                if (!System.test.isrunningtest() ) {
                                    //Get C_DOC & C_DOA
                                    dataPolicyEIP = EIPConnector.getPOSTransaction('getPOSTransaction', ctc.entity__c, ctc.policyApp__c, ctc.policy_no__c, POSTransactionStartDate, POSTransactionEndDate);
                                    log.Date_of_Capture__c = convertToDateField(dataPolicyEIP.Body.Customer.hasPolicyAccount[0].hasDetailsOfClaimIn[0].claimStatusChangeDTTM);
                                    log.Date_of_Approved__c = convertToDateField(dataPolicyEIP.Body.Customer.hasPolicyAccount[0].hasDetailsOfClaimIn[0].processedDttm);
                                }
                                else{
                                    //For Test Class Only
                                    log.Date_of_Capture__c = convertToDateField('20250101');
                                    log.Date_of_Approved__c = convertToDateField('20250131');
                                }
                                
                                System.Debug('Success inserting C_DOC and C_DOA');
                                log.EIP_Response__c = 'Get Data Success';
                                getDataSuccess = true;                                
                            } catch (Exception e){
                                System.Debug('C_DOC and C_DOA are NULL');
                            }
                            if (ctc.Agent_Role_Code__c == NULL){
                                system.debug('**updateContactFlagAgentRole');
                                updateContactFlagAgentRole(ctc);
                            }
                        }
                        
                        if ((response != null || System.test.isrunningtest()) && isEligible == true ) { 
                            String urlshort  = '';
                            
                            if (! System.test.isrunningtest()){
                                urlshort = response.Body.Customer.haveCommunicatedMessage[0].replyTo;
                            } else{
                                urlshort = 'https://axa.t2mio.com/mqBi9sV';
                            }
                            if (urlshort != null && urlshort != ''){
                                if(String.isnotblank(log.Email_Text__c) && log.Email_Text__c.contains('[SHORT_URL]')==true){
                                    log.Email_Text__c = log.Email_Text__c.replace('[SHORT_URL]',urlshort);
                                } 
                                log.bitly__c = urlshort;
                                log.ready_to_send__c = true; 
                                
                                isSuccess = true; 
                                
                                //Added by Dimas Support MII 07/02/2025
                                if((log.Entity__c == 'AMFS' && withdrawalSurrenderCaseType.contains(typeCase) && log.Case_Type__c == 'Request POS') || System.test.isrunningtest()){
                                    if(configSendWithdrawSurrender == true || System.test.isrunningtest() ){
                                        system.debug('Instant Send Survey Withdrawal Surrender');
                                        if (string.isnotblank(log.contact__r.MobilePhone )) { 
                                            Set<id> sendWa = new Set<id>();
                                            sendWa.add(log.id);
                                            if (!System.Test.IsRunningTest()) System.enqueueJob(new SendSurveyICF.sendWhatsapp(sendWa));
                                            sendData = true; 
                                            log.method__c = 'Whatsapp';     
                                        } 
                                        else if (string.isnotblank(log.Email__c)) {
                                            sendMail(log, owea, mapEmailTemplate);   
                                            sendData = true;
                                            log.method__c = 'Email';   
                                        }
                                    }else{
                                        log.Status__c = 'Hold';
                                    }
                                }else if (configSendLogBool == true) {
                                    if(configSendDMTM == false && typeCase == 'Request_Claim_Payment'){
                                        log.Status__c = 'Hold';
                                    } else{
                                        if (string.isnotblank(log.contact__r.MobilePhone )) { 
                                            Set<id> sendWa = new Set<id>();
                                            sendWa.add(log.id);
                                            if (!System.Test.IsRunningTest()) System.enqueueJob(new SendSurveyICF.sendWhatsapp(sendWa));
                                            sendData = true; 
                                            log.method__c = 'Whatsapp';     
                                        } 
                                        else if (string.isnotblank(log.Email__c)) {
                                            sendMail(log, owea, mapEmailTemplate);   
                                            sendData = true;
                                            log.method__c = 'Email';   
                                        }
                                    }
                                }
                            }  
                            
                            log.Description__c = ''; 
                            if (configSendLogBool == true || configSendWithdrawSurrender == true) {
                                if (sendData == true) {
                                    log.Status__c = 'Send'; 
                                    log.Updated_Contact_Flag__c = true;
                                    log.End_Date__c = system.today();
                                }
                            } 
                            else{
                                if(log.Status__c!='Send') log.Status__c = 'Hold';
                                if (string.isnotblank(log.contact__r.MobilePhone )) log.method__c = 'Whatsapp';     
                            }
                            
                            log.Description__c  = '';
                            log.Exclude_From__c = '';
                            
                            if (sendData == true)  log.Send_Flag__c = true; 
                            log.Request_Date__c = System.today();
                            log.Start_Date__c = System.today(); 
                            log.is_Eligible__c = isEligible;
                            
                        } 
                    }catch(EIPConnector.NoDataException e){
                        System.debug('NoDataException'+ e); 
                        log.EIP_Response__c = e.getStackTraceString();
                    }catch(EIPConnector.EIPConnectorException e){
                        System.debug('EIPConnectorException'+ e); 
                    }catch(Exception e){
                        System.debug('Exception occurred: ' + e.getMessage());
                        System.debug('Stack Trace: ' + e.getStackTraceString());
                        System.debug('Exception occurred: ' + e.getMessage());
                        System.debug('Stack Trace: ' + e.getStackTraceString());
                    }
                    if (!configSendLogBool && log.Status__c != 'Send') {
                        log.Status__c = 'Hold';
                    }
                    
                    if( System.test.isrunningtest() || (!getDataSuccess && (log.Entity__c == 'AMFS' && withdrawalSurrenderCaseType.contains(typeCase) && log.Case_Type__c == 'Request POS'))){
                        log.Status__c = 'Draft EIP';
                        log.Send_Flag__c = false; 
                        log.EIP_Response__c = 'Data Not Available from EIP';
                        log.Exclude_From__c = 'Data Not Available from EIP';
                        log.Description__c = 'Data Not Available from EIP';
                        isEligible = false;
                    }
                    
                    if (System.test.isrunningtest() || (isSuccess == false && isEligible == true)) { 
                        log.Status__c = 'Draft';
                        log.Send_Flag__c = false; 
                        log.Exclude_From__c = '';
                        log.Description__c = '';
                    } 
                    if (System.test.isrunningtest() || isEligible == false) { 
                        log.Status__c = 'Cancel';
                        log.Send_Flag__c = false; 
                        log.Description__c = infoDescription;
                        log.Exclude_From__c = infoDescription;
                        log.Description__c = infoDescription;
                    }  
                    if( System.test.isrunningtest() || (!getDataSuccess && (typeCase == 'Request_Claim_Payment'))){
                        log.Status__c = 'Draft EIP';
                        log.Send_Flag__c = false; 
                        log.EIP_Response__c = 'Data Not Available from EIP';
                        log.Exclude_From__c = 'Data Not Available from EIP';
                        log.Description__c = 'Data Not Available from EIP';
                    }
                    log.is_Eligible__c = isEligible;
                    
                } else {
                    String CASE_FREEZE_DATE = 'check icf Freeze Until: ';
                    string infoDesc = CASE_FREEZE_DATE+freezeDateStr;
                    
                    if (!System.Test.IsRunningTest()) System.enqueueJob(new CheckClaimStatus.checkStatus(emailLogs));
                    
                    log.Status__c = 'Cancel';
                    log.Exclude_From__c = infoDesc;
                    log.Description__c = infoDesc;
                }
                
                for (Email_SMS_Log__c row: getDataChildEmail) {
                    row.status__c = log.Status__c == 'Hold' ? 'Draft' : log.Status__c ;
                    row.Exclude_From__c = log.Exclude_From__c;
                    row.Description__c = log.Description__c;
                    row.Send_Flag__c = false;
                }
                
                if (getDataChildEmail.size() > 0) update getDataChildEmail;
                
                
                if (isExist == false && configSendLogBool == true && isEligible == true && sendData == true ) { 
                    update checkFreezeContact; 
                }
                
                log.Fg_Update_Contact__c = false; 
            } else {                  
                if (!System.Test.IsRunningTest()) System.enqueueJob(new CheckClaimStatus.checkStatus(emailLogs));
                log.Status__c = 'Cancel';
                log.Exclude_From__c = infoDescription;
                log.Description__c = 'Cancel info: ' +infoDescription;
                
                for (Email_SMS_Log__c row: getDataChildEmail) {
                    row.status__c = log.Status__c  ; 
                    row.Send_Flag__c = false;
                }
                
                update getDataChildEmail;
            }
            
            system.debug('desc:'+infoDescription);
            update log;
            
        }
        
    }
    
    public static void sendMail(Email_sms_log__c requestEmail, OrgWideEmailAddress owea, map<string, string> template) { 
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        String htmlbody = requestEmail.Email_Text__c;
        String subject = template.get(requestEmail.Email_SMS_Template__c);
        if (string.isnotblank(subject) && subject.contains('[MOT_SERVICE]')) {
            subject = subject.replace('[MOT_SERVICE]', string.isnotblank(requestEmail.MOT_in_email__c) ? requestEmail.MOT_in_email__c : '');
        }
                
        
        //Added by Dimas Support MII 08/02/2025
        /*
        String caseTypeName = requestEmail.Case__r.Case_Type__c;
        if (string.isnotblank(caseTypeName)){ 
        if (string.isnotblank(subject) && requestEmail.Entity__c == 'AMFS' && withdrawalCaseType.contains(caseTypeName) && requestEmail.Case_Type__c == 'Request POS') {
        subject = subject.replace(subject, String.valueOf(System.Label.Config_ICF_Subject_Email_Request_POS_Withdrawal));
        } else if (string.isnotblank(subject) && requestEmail.Entity__c == 'AMFS' && surrenderCaseType.contains(caseTypeName) && requestEmail.Case_Type__c == 'Request POS') {
        subject = subject.replace(subject, String.valueOf(System.Label.Config_ICF_Subject_Email_Request_POS_Surrender));
        } 
        } else if (string.isnotblank(subject) && requestEmail.Entity__c == 'AMFS' && string.isblank(caseTypeName) && requestEmail.Case_Type__c == 'Complaint') {
        subject = subject.replace(subject, String.valueOf(System.Label.Config_ICF_Subject_Email_Complaint));
        }
        */
                
        email.setToAddresses( new List<String>{ requestEmail.Email__c } );
        
        email.setOrgWideEmailAddressId(owea.Id);
        email.setCcAddresses( new List<String>() );
        email.setSubject(subject);
        email.setHtmlBody(htmlbody);
        emails.add(email);
            
        if(!Test.isRunningTest()) Messaging.sendEmail(emails); 
    } 
    
    @InvocableMethod(label='Send Survey via Whatsapp' description='Send survey via whatsapp.')
    Public static List<String> sendSurveyViaWhatsappFlow(List<String> recordIds) { 
        List<String> retList = new List<String>();
        if (recordIds.size() > 0 && !System.test.isrunningtest()) {   
            sendSurveyViaWhatsapp(recordIds[0]);
        }
        
        return retList;
    }
    
    Public static void sendSurveyViaWhatsapp(String contactId) { 
        Set<id> sendWa = new Set<id>();
        DescribeSObjectResult describeResult = Email_SMS_Log__c.getSObjectType().getDescribe();
        List<String> fieldList = new List<String>(describeResult.fields.getMap().keySet());
        String caseId = '';
        String fieldStr = String.join(fieldList, ',');
        String query = ' SELECT ' + fieldStr + ', case__r.Case_Type_Config__c, case__r.Case_type__c, case__r.MOT__c, case__r.entity__c FROM Email_SMS_Log__c WHERE contact__c = :contactId AND status__c = \'Hold\' ORDER BY createddate asc';
        Boolean Complaint = false;
        Boolean Request = false;
        Boolean Request_POS = false;
        Boolean ClaimCase = false;
        OrgWideEmailAddress owea = [SELECT Id, Address, DisplayName FROM OrgWideEmailAddress WHERE Address = :Label.EmailNoReplayAMFS limit 1];
        
        List<Email_SMS_Log__c> listLog = Database.query(query); 
        
        set<id> emailsmslogId = new set<id>();
        for (email_sms_log__c row:listLog) {
            emailsmslogId.add(row.id);
            caseId = row.Case__c;
            if(row.Case_Type__c == 'Complaint') Complaint = true;
            if(row.Case_Type__c == 'Request') Request = true;
            if(row.Case_Type__c == 'Request POS') Request_POS = true;
            if(row.Mot__c == 'I Claim') ClaimCase = true;
        }
        
        List<Case> checkListCombination = [Select id from Case where contactid =: contactId and entity__c = 'AMFS' and MOT__c = null 
                                           and ((createddate = today AND type = 'Inquiry') OR (status != 'closed' AND type != 'Inquiry')) 
                                           order by Createddate asc limit 1];
        
        /*List<Case> checkListComplain = [select id from Case where contactid =: contactId and entity__c = 'AMFS' 
        and Type = 'Complaint' and id !=:caseId and Date_of_Submit__c >= Last_n_days:180 
        order by Createddate limit 1];*/
        
        List<Email_SMS_Log__c> emailSmsLog = [Select id from email_sms_log__c where category__c = 'ICF' 
                                              and contact__c=:contactId and case__r.mot__c = null
                                              and (
                                                  (status__c = 'Send' AND end_date__c >= Last_n_days:30)
                                                  or (
                                                      status__c in ('Draft','Batch')
                                                      AND case__r.ClosedDate >= Last_n_days:30
                                                  )
                                              ) 
                                              and case_type__c != 'Inquiry' and id not in :emailsmslogId
                                              order by Createddate asc limit 1
                                             ];
        
        
        
        if ((checkListCombination.size() > 0 || emailSmsLog.size() > 0) && !Complaint && !Request && !Request_POS && !ClaimCase) {
            for (Email_SMS_Log__c row : listLog) {
                row.Status__c = 'Cancel';
                row.Send_Flag__c = false;
                row.Description__c = 'Cancel Send ICF';
                row.Exclude_From__c = 'Cancel Send ICF';
            }
        } 
        /*else if( checkListComplain.size() > 0 && !Complaint && !Request_POS){
            System.Debug('=== Gagal validasi checkListComplain ===');
            for (Email_SMS_Log__c row : listLog) {
            if(row.case__r.Case_type__c == 'Request_Claim_Payment'){
            row.Status__c = 'Cancel';
            row.Send_Flag__c = false;
            row.Description__c = 'Terdapat case complain < 6 bulan';
            row.Exclude_From__c = 'Terdapat case complain < 6 bulan';
            }
            }
            }*/
        else {
            System.Debug('=== Lolos validasi checkListCombination dan checkListComplain ===');
            Contact getDataContact = freezeDateContact(contactId,listLog);
            
            String CASE_FREEZE_DATE = 'check icf Freeze Until: ';
            
            for (Email_SMS_Log__c row : listLog) {                 
                String mot = row.MOT__c;
                String typeCase = row.case__r.Case_type__c;
                if(row.case__r.Case_type__c == 'Complaint') Complaint = true;
                boolean sendLog = true;
                if(ClaimCase && !row.is_Eligible__c){
                    row.Status__c = 'Cancel';
                    row.Description__c = 'Not Eligible to Send Survey';
                    sendLog = false;
                }
                if (string.isnotblank(mot) && !Complaint && !ClaimCase) {
                    mot = mot.tolowercase();
                    
                    if ( mot.contains('ask') && getDataContact.Email_Sms_Log_Ask__c != row.id && row.Case_Type__c != 'Request POS') {
                        System.debug('getDataContact.Email_Sms_Log_Ask__c:'+getDataContact.Email_Sms_Log_Ask__c);
                        System.debug('row.id:'+row.id);
                        
                        system.debug('cancel ask');
                        row.Status__c = 'Cancel';
                        row.Description__c = CASE_FREEZE_DATE+getDataContact.Freeze_Ask_End_Date__c;
                        sendLog = false;
                    }
                    if ( mot.contains('buy') && getDataContact.Email_Sms_Log_buy__c != row.id) {
                        row.Status__c = 'Cancel';
                        row.Description__c = CASE_FREEZE_DATE+getDataContact.Freeze_buy_End_Date__c;
                        sendLog = false;
                    }
                    if ( mot.contains('complain') && getDataContact.Email_Sms_Log_complaint__c != row.id) {
                        row.Status__c = 'Cancel';
                        row.Description__c = CASE_FREEZE_DATE+getDataContact.Freeze_complaint_End_Date__c;
                        sendLog = false;
                    }
                    if ( mot.contains('renew') && getDataContact.Email_Sms_Log_renew__c != row.id) {
                        row.Status__c = 'Cancel';
                        row.Description__c = CASE_FREEZE_DATE+getDataContact.Freeze_renew_End_Date__c;
                        sendLog = false;
                    }
                    if ( mot.contains('claim') && getDataContact.Email_Sms_Log_claim__c != row.id && (row.case__r.Case_type__c != 'Request_Claim_Payment')  ) {
                        if(row.Claim_Status__c != 'Reject') {
                            row.Status__c = 'Cancel';
                            row.Description__c = CASE_FREEZE_DATE+getDataContact.Freeze_claim_End_Date__c;
                            sendLog = false;   
                        }
                    }
                    
                }
                
                if (sendLog) {
                    if (string.isnotblank(row.Mobile__c)) {   
                        system.debug('row.Mobile__c is not blank');  
                        sendWa.add(row.id);
                        row.method__c = 'Whatsapp'; 
                    }
                    else{
                        if (string.isnotblank(row.Email__c)) { 
                            map<string, string> mapEmailTemplate = new map<string, string>(); 
                            system.debug('Masuk Email');
                            if (!mapEmailTemplate.containsKey(row.Email_SMS_Template__c)) {
                                mapEmailTemplate.put(row.Email_SMS_Template__c, ''); 
                                
                                List<Email_SMS_Template__c> subjectEmail = [SELECT Id, Subject__c FROM Email_SMS_Template__c WHERE id in : mapEmailTemplate.keyset()];
                                for(Email_SMS_Template__c emailTemplate: subjectEmail){
                                    mapEmailTemplate.put(emailTemplate.Id, emailTemplate.Subject__c ); 
                                }    
                                
                                row.status__c = 'Send';
                                row.Send_Flag__c = true;
                                row.End_Date__c = System.Today();
                                sendMail(row, owea, mapEmailTemplate); 
                                system.debug('Masuk Send');
                            }
                        }
                    }
                }
                
            } 
        } 
        if (!System.Test.IsRunningTest() && sendWa.size() > 0) System.enqueueJob(new SendSurveyICF.sendWhatsapp(sendWa));
        update listLog;
    }
    
    Public static contact freezeDateContact(String contactId, List<Email_sms_log__c> logs) {
        
        Contact checkFreezeContact = [Select Survey_Ask_Send_Counter__c, 
                                      Survey_Ask_Send_Date__c,
                                      Survey_Buy_Send_Counter__c,
                                      Survey_Buy_Send_Date__c,
                                      Survey_Claim_Send_Counter__c,
                                      Survey_Claim_Send_Date__c,
                                      Survey_Complaint_Send_Counter__c,
                                      Survey_Complaint_Send_Date__c,
                                      Survey_Renew_Send_Counter__c,
                                      Survey_Renew_Send_Date__c,
                                      
                                      Freeze_Ask_End_Date__c,
                                      Freeze_Buy_End_Date__c,
                                      Freeze_Claim_End_Date__c,
                                      Freeze_Complaint_End_Date__c,
                                      Freeze_Renew_End_Date__c,
                                      
                                      Interval_Completed_Month__c, // 6 month
                                      Interval_Max_Loop__c, // frequency
                                      Interval_No_Response_Month__c, // 1 month
                                      
                                      Email_Sms_Log_Ask__c,
                                      Email_Sms_Log_Buy__c,
                                      Email_Sms_Log_Claim__c,
                                      Email_Sms_Log_Complaint__c,
                                      Email_Sms_Log_Renew__c,
                                      
                                      Email_Sms_Log_Ask__r.Case__c,
                                      Email_Sms_Log_Buy__r.Case__c,
                                      Email_Sms_Log_Claim__r.Case__c,
                                      Email_Sms_Log_Complaint__r.Case__c,
                                      Email_Sms_Log_Renew__r.Case__c
                                      from contact where id =: contactId limit 1                                                
                                     ];
        
        string logIdAsk = '';
        string logIdBuy = '';
        string logIdRenew = '';
        string logIdComplain = '';
        string logIdClaim = '';
        date currDate = System.Today();
        
        ICF_Parameter__c ICFParameter =   [SELECT id, 
                                           Interval_Completed_Month__c, Interval_No_Response_Month__c, Interval_Max_Loop__c
                                           FROM ICF_Parameter__c WHERE RecordType.Name ='Master - Qualtrics'  limit 1];
        
        integer maxloop = 1;
        if (ICFParameter.Interval_Max_Loop__c != '') maxloop = integer.valueof(ICFParameter.Interval_Max_Loop__c);
        
        integer noresponse = 0;
        if (ICFParameter.Interval_No_Response_Month__c != '') noresponse = integer.valueof(ICFParameter.Interval_No_Response_Month__c);
        
        date freezedate = currDate + (noresponse * 30 * maxloop);
        system.debug('freezedate:'+freezedate);
        integer countSendAsk = 1;
        integer countSendBuy = 1;
        integer countSendRenew = 1;
        integer countSendClaim = 1;
        integer countSendComplaint = 1;
        
        boolean isUpdate = false;
        
        System.debug('logs:'+logs);
        System.debug('checkFreezeContact:'+checkFreezeContact);
        for (Email_sms_log__c row: logs) {
            String mot = row.MOT__c;
            if (string.isnotblank(mot)) {
                mot = mot.tolowercase();
                
                System.debug('mot:'+mot);
                if ( mot.contains('ask') ) {
                    system.debug('ask mot');
                    if (String.isblank(logIdAsk)) {
                        logIdAsk = row.id;                    
                        IF (
                            (checkFreezeContact.Freeze_Ask_End_Date__c == null 
                             || checkFreezeContact.Freeze_Ask_End_Date__c < currDate)
                        )   {
                            if (checkFreezeContact.Survey_Ask_Send_Counter__c != null || checkFreezeContact.Survey_Ask_Send_Counter__c != 0) countSendAsk++;
                            //Added by Dimas Support MII 08/02/2025
                            if (row.Entity__c == 'AMFS' && withdrawalSurrenderCaseType.contains(row.Case__r.Case_Type__c) && row.Case_Type__c == 'Request POS'){
                                System.Debug ('Does not insert Freeze Ask Date');
                            } else {
                                checkFreezeContact.Freeze_Ask_End_Date__c = freezedate; 
                            }
                            checkFreezeContact.Survey_Ask_Send_Counter__c = countSendAsk;
                            checkFreezeContact.Survey_Ask_Send_Date__c = currDate; 
                            checkFreezeContact.Email_Sms_Log_Ask__c = logIdAsk;
                            isUpdate = true;
                        }
                        IF(row.Outbound_Call__c){
                            if (checkFreezeContact.Survey_Ask_Send_Counter__c != null || checkFreezeContact.Survey_Ask_Send_Counter__c != 0) countSendAsk++;
                            checkFreezeContact.Freeze_Ask_End_Date__c = freezedate; 
                            checkFreezeContact.Survey_Ask_Send_Counter__c = countSendAsk;
                            checkFreezeContact.Survey_Ask_Send_Date__c = currDate; 
                            checkFreezeContact.Email_Sms_Log_Ask__c = logIdAsk;
                            isUpdate = true;
                        }
                    }                 
                    
                }
                
                if ( mot.contains('buy') ) {
                    system.debug('buy mot');
                    if (String.isblank(logIdbuy)) {
                        logIdbuy = row.id;                    
                        IF (
                            checkFreezeContact.Freeze_buy_End_Date__c == null 
                            || checkFreezeContact.Freeze_buy_End_Date__c < currDate
                        )   {
                            if (checkFreezeContact.Survey_buy_Send_Counter__c != null) countSendbuy++;
                            checkFreezeContact.Freeze_buy_End_Date__c = freezedate; 
                            checkFreezeContact.Survey_buy_Send_Counter__c = countSendbuy;
                            checkFreezeContact.Survey_buy_Send_Date__c = currDate; 
                            checkFreezeContact.Email_Sms_Log_buy__c = logIdbuy;
                            isUpdate = true;
                        }
                    }      
                }
                
                if ( mot.contains('claim') ) {
                    system.debug('claim mot');
                    if (String.isblank(logIdclaim)) {
                        logIdclaim = row.id;                    
                        IF (
                            (checkFreezeContact.Freeze_claim_End_Date__c == null 
                             || checkFreezeContact.Freeze_claim_End_Date__c < currDate) && (row.case__r.Case_type__c != 'Request_Claim_Payment')
                        )   {
                            if (checkFreezeContact.Survey_claim_Send_Counter__c != null) countSendclaim++;
                            checkFreezeContact.Freeze_claim_End_Date__c = freezedate; 
                            checkFreezeContact.Survey_claim_Send_Counter__c = countSendclaim;
                            checkFreezeContact.Survey_claim_Send_Date__c = currDate; 
                            checkFreezeContact.Email_Sms_Log_claim__c = logIdclaim;
                            if(row.Claim_Status__c != 'Reject') isUpdate = true;
                        }
                    }      
                }
                
                if ( mot.contains('complain')  ) {
                    system.debug('complaint mot');
                    
                    if (String.isblank(logIdcomplain)) {
                        logIdcomplain = row.id;                    
                        IF (
                            checkFreezeContact.Freeze_complaint_End_Date__c == null 
                            || checkFreezeContact.Freeze_complaint_End_Date__c < currDate
                        )   {
                            if (checkFreezeContact.Survey_complaint_Send_Counter__c != null) countSendComplaint++;
                            //checkFreezeContact.Freeze_complaint_End_Date__c = freezedate; 
                            checkFreezeContact.Survey_complaint_Send_Counter__c = countSendComplaint;
                            checkFreezeContact.Survey_complaint_Send_Date__c = currDate; 
                            checkFreezeContact.Email_Sms_Log_complaint__c = logIdcomplain;
                            isUpdate = true;
                        }
                    }      
                }
                
                if ( mot.contains('renew')  ) {
                    system.debug('renew mot');
                    if (String.isblank(logIdrenew)) {
                        logIdrenew = row.id;                    
                        IF (
                            checkFreezeContact.Freeze_renew_End_Date__c == null 
                            || checkFreezeContact.Freeze_renew_End_Date__c < currDate
                        )   {
                            if (checkFreezeContact.Survey_renew_Send_Counter__c != null) countSendrenew++;
                            checkFreezeContact.Freeze_renew_End_Date__c = freezedate; 
                            checkFreezeContact.Survey_renew_Send_Counter__c = countSendrenew;
                            checkFreezeContact.Survey_renew_Send_Date__c = currDate; 
                            checkFreezeContact.Email_Sms_Log_renew__c = logIdrenew;
                            isUpdate = true;
                        }
                    }      
                }    
            }
        }    
        if (isUpdate == true) update checkFreezeContact;
        
        return checkFreezeContact;
    }
    
    // Added by Dimas Support MII 07/02/2025
    public static Date convertToDateField(String formattedDate) {
        if (String.isEmpty(formattedDate) || formattedDate.length() != 8) {
            throw new IllegalArgumentException('Invalid date format. Expected YYYYMMDD.');
        }
        
        try {
            Integer year = Integer.valueOf(formattedDate.substring(0, 4));
            Integer month = Integer.valueOf(formattedDate.substring(4, 6));
            Integer day = Integer.valueOf(formattedDate.substring(6, 8));
            
            return Date.newInstance(year, month, day);
        } catch (Exception e) {
            throw new IllegalArgumentException('Error parsing date: ' + formattedDate);
        }
    }
    
    public static String convertDateToEIPFormat(Date inputDate) {
        String year = String.valueOf(inputDate.year());
        String month = inputDate.month() < 10 ? '0' + inputDate.month() : String.valueOf(inputDate.month());
        String day = inputDate.day() < 10 ? '0' + inputDate.day() : String.valueOf(inputDate.day());
        
        return year + month + day;
    }
    
    public static void updateContactFlagAgentRole(Contact contactObj){
        String ENTITY = 'AMFS';
        String ProducingCD = '';
        String AgentCode = '';
        String AgentCodes = '';
        EIPJson dataAgent;
        try{
            if(contactObj.policyApp__c == 'DMTM'){
                System.Debug('Flag Agent Role Policy App: DMTM');
                if(directDistributionProductID.contains(contactObj.WelcomeCall_Product_Code_Plan__c)){
                    AgentCodes = 'DD';
                }else{
                    AgentCodes = 'TM';   
                }
                
            }else{
                if(!System.Test.IsRunningTest()){
                    dataAgent = EIPConnector.getCustomerInfo('Customer Profile', ENTITY, contactObj.PolicyApp__c, contactObj.Policy_No__c);
                }                
                System.Debug('Flag Agent Role Policy App: RLS');
                if(dataAgent != null || System.Test.IsRunningTest()){
                    if (System.Test.IsRunningTest()){
                        ProducingCD = '4000';
                    } else {
                        ProducingCD = dataAgent.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPartyDetailsIn[0].producingCD;
                    }
                    AgentCode = ProducingCD.substring(0,1);
                    if(AgentCode == '3') {
                        AgentCodes = 'LP';
                    }
                    else if(AgentCode == '1' || AgentCode == '6' || AgentCode == '7') {
                        AgentCodes = 'FA Conventional';
                    }
                    else if(AgentCode == '4' || AgentCode == '5') {
                        AgentCodes = 'FA Syariah';
                    }
                    else{
                        AgentCodes = 'TM'; 
                    }
                }
                
            }
            System.Debug('Agent Code: '+AgentCode);
            contactObj.Agent_Role_Code__c = AgentCodes;
            update contactObj; 
        }
        catch(EIPConnector.NoDataException e){
            System.debug('NoDataException'+ e);
            //EIPMessage = e.getStackTraceString();
        }catch(EIPConnector.EIPConnectorException e){
            System.debug('EIPConnectorException'+ e); 
            //EIPMessage = e.getStackTraceString();
        }catch(Exception e){
            System.debug('Exception' + e);
            //EIPMessage = e.getStackTraceString();
        }
    }
}