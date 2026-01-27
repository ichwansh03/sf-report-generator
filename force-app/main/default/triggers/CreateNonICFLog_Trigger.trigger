trigger CreateNonICFLog_Trigger on ICF_Non_CCC__c (Before Update) {
    if (Trigger.isBefore) {
        for (ICF_Non_CCC__c nonccc : trigger.new){
            if (nonccc.Status__c == 'Start') {
                nonccc.Status__c = 'Closed';
                String Status = 'Draft';
                String ExcludeFrom = '';
                Date Datetoday = date.today();

                // Survey
                Survey__c sv = [SELECT id, URL__c, createddate FROM Survey__c WHERE RecordType.Name = 'Master' and Survey_Type__c =: nonccc.MOT__c and Entity__c =: nonccc.Entity__c order by createddate limit 1 ];

                // ICF Master_Email_SMS
                ICF_Parameter__c icfES = [SELECT id, ICF_Email_Template__c, ICF_SMS_Template__c, 
                    User_ID__c, Password__c, Division__c, Sender__c, Batchname__c, Uploadby__c, Channel__c, 
                    Login_1__c, API_Key_1__c, Login_2__c, API_Key_2__c, 
                    ICF_Method__c 
                FROM ICF_Parameter__c WHERE Record_Type_Name__c = 'Master_Email_SMS' and Entity__c =: nonccc.Entity__c];
                    
                // Check Contact
                List<Contact> co = [SELECT id, Name, LastName, MobilePhone, Email, Survey_Method__c, Other_Email__c,
                                    Freeze_Ask_End_Date__c, Freeze_Buy_End_Date__c, Freeze_Claim_End_Date__c, Freeze_Complaint_End_Date__c, Freeze_Renew_End_Date__c,
                                    AccountId
                                    FROM Contact WHERE Policy_No__c =: nonccc.Policy_Number__c and Entity__c =: nonccc.Entity__c];
                if (co.size() > 0) {
                    if (nonccc.MOT__c == 'I BUY') {
                        if (co[0].Freeze_Buy_End_Date__c > Datetoday && co[0].Freeze_Buy_End_Date__c != NULL){
                            Status = 'Cancel';
                            ExcludeFrom = 'Freeze Until: '+co[0].Freeze_Buy_End_Date__c;
                        }
                    }
                    
                    if (nonccc.MOT__c == 'I RENEW'){
                        if (co[0].Freeze_Renew_End_Date__c > Datetoday && co[0].Freeze_Renew_End_Date__c != NULL){
                            Status = 'Cancel';
                            ExcludeFrom = 'Freeze Until: '+co[0].Freeze_Renew_End_Date__c;                            
                        }
                    }
                    if (nonccc.MOT__c == 'I ASK'){
                        if (co[0].Freeze_Ask_End_Date__c > Datetoday && co[0].Freeze_Ask_End_Date__c != NULL){
                            Status = 'Cancel';
                            ExcludeFrom = 'Freeze Until: '+co[0].Freeze_Ask_End_Date__c;
                        }
                    }
                    if (nonccc.MOT__c == 'I CLAIM'){
                        if (co[0].Freeze_Claim_End_Date__c > Datetoday && co[0].Freeze_Claim_End_Date__c != NULL){
                            Status = 'Cancel';
                            ExcludeFrom = 'Freeze Until: '+co[0].Freeze_Claim_End_Date__c;

                        }
                    }
                }
                
                // check exclude ICF
                if (nonccc.ICF_ExcludeFrom__c != NUll && nonccc.ICF_ExcludeFrom__c != ''){
                    Status = 'Cancel';
                    ExcludeFrom = 'Exclude: '+nonccc.ICF_ExcludeFrom__c;
                }                
                
                // check Schedule ICF
                Date RequestDate = Date.Today();
                /*
                if (mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-ISSUED_DATE_F__C') != NULL){
                    String CheckData = mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-ISSUED_DATE_F__C').Value_Custom__c;
                    RequestDate = nonccc.Issued_Date_F__c + integer.valueof(CheckData);
                }
                else if (mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-APPROVED_DATE_F__C') != NULL){
                    String CheckData = mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-APPROVED_DATE_F__C').Value_Custom__c;
                    RequestDate = nonccc.APPROVED_DATE_F__C + integer.valueof(CheckData);
                }
                else if (mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-CAPTURED_DATE_F__C') != NULL){
                    String CheckData = mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-CAPTURED_DATE_F__C').Value_Custom__c;
                    RequestDate = nonccc.CAPTURED_DATE_F__C + integer.valueof(CheckData);
                }
                else if (mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-CLAIM_APPROVED_DATE_F__C') != NULL){
                    String CheckData = mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-CLAIM_APPROVED_DATE_F__C').Value_Custom__c;
                    RequestDate = nonccc.CLAIM_APPROVED_DATE_F__C + integer.valueof(CheckData);
                }
                else if (mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-CLAIM_PAYMENT_DATE_F__C') != NULL){
                    String CheckData = mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-CLAIM_PAYMENT_DATE_F__C').Value_Custom__c;
                    RequestDate = nonccc.CLAIM_PAYMENT_DATE_F__C + integer.valueof(CheckData);
                }
                else if (mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-CLAIM_SUBMITTED_DATE_F__C') != NULL){
                    String CheckData = mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-CLAIM_SUBMITTED_DATE_F__C').Value_Custom__c;
                    RequestDate = nonccc.CLAIM_SUBMITTED_DATE_F__C + integer.valueof(CheckData);
                }
                else if (mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-DUE_DATE_F__C') != NULL){
                    String CheckData = mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-DUE_DATE_F__C').Value_Custom__c;
                    RequestDate = nonccc.DUE_DATE_F__C + integer.valueof(CheckData);
                }
                else if (mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-REVERSAL_DATE_F__C') != NULL){
                    String CheckData = mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-REVERSAL_DATE_F__C').Value_Custom__c;
                    RequestDate = nonccc.REVERSAL_DATE_F__C + integer.valueof(CheckData);
                }
                else if (mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-SUBMITTED_DATE_F__C') != NULL){
                    String CheckData = mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-SUBMITTED_DATE_F__C').Value_Custom__c;
                    RequestDate = nonccc.SUBMITTED_DATE_F__C + integer.valueof(CheckData);
                }
                else if (mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-SEND_DATE_F__C') != NULL){
                    String CheckData = mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-SEND_DATE_F__C').Value_Custom__c;
                    RequestDate = nonccc.SEND_DATE_F__C + integer.valueof(CheckData);
                }
                else if (mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-RECEIVED_DATE_F__C') != NULL){
                    String CheckData = mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-RECEIVED_DATE_F__C').Value_Custom__c;
                    RequestDate = nonccc.RECEIVED_DATE_F__C + integer.valueof(CheckData);
                }
                else if (mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-PAY_TO_DATE_F__C') != NULL){
                    String CheckData = mapicfparam.get('SCHEDULE - '+nonccc.MOT__c+'-PAY_TO_DATE_F__C').Value_Custom__c;
                    RequestDate = nonccc.PAY_TO_DATE_F__C + integer.valueof(CheckData);
                }
                */
                if (nonccc.ICF_Send_Value__c != NUll && nonccc.ICF_Send_Value__c != ''){
                    RequestDate += integer.valueof(nonccc.ICF_Send_Value__c);
                    if (nonccc.ICF_Send_Field__c == 'Submitted Date') RequestDate = nonccc.Submitted_Date_F__c + integer.valueof(nonccc.ICF_Send_Value__c);
                    if (nonccc.ICF_Send_Field__c == 'Issued Date') RequestDate = nonccc.Issued_Date_F__c + integer.valueof(nonccc.ICF_Send_Value__c);
                    if (nonccc.ICF_Send_Field__c == 'Due Date') RequestDate = nonccc.Due_Date_F__c + integer.valueof(nonccc.ICF_Send_Value__c);
                    if (nonccc.ICF_Send_Field__c == 'Captured Date') RequestDate = nonccc.Captured_Date_F__c + integer.valueof(nonccc.ICF_Send_Value__c);
                    if (nonccc.ICF_Send_Field__c == 'Approved Date') RequestDate = nonccc.Approved_Date_F__c + integer.valueof(nonccc.ICF_Send_Value__c);
                    if (nonccc.ICF_Send_Field__c == 'Claim Payment Date') RequestDate = nonccc.Claim_Payment_Date_F__c + integer.valueof(nonccc.ICF_Send_Value__c);
                    if (nonccc.ICF_Send_Field__c == 'Claim Approved Date') RequestDate = nonccc.Claim_Approved_Date_F__c + integer.valueof(nonccc.ICF_Send_Value__c);
                    if (nonccc.ICF_Send_Field__c == 'Claim Submitted Date') RequestDate = nonccc.Claim_Submitted_Date_F__c + integer.valueof(nonccc.ICF_Send_Value__c);
                    if (nonccc.ICF_Send_Field__c == 'Send Date') RequestDate = nonccc.Send_Date_F__c + integer.valueof(nonccc.ICF_Send_Value__c);
                    if (nonccc.ICF_Send_Field__c == 'Received Date') RequestDate = nonccc.Received_Date_F__c + integer.valueof(nonccc.ICF_Send_Value__c);
                    if (nonccc.ICF_Send_Field__c == 'Pay To Date') RequestDate = nonccc.Pay_To_Date_F__c + integer.valueof(nonccc.ICF_Send_Value__c);
                    if (nonccc.ICF_Send_Field__c == 'Claim Transfer Date') RequestDate = nonccc.Claim_Tr_Date__c + integer.valueof(nonccc.ICF_Send_Value__c);
                }
                
                // add validation email address for AFI by Beni R 11052023
                if(nonccc.Entity__c == 'AFI' || nonccc.Entity__c == 'ALI'){
                    if(Status == 'Draft'){
                        try{
                            if(co[0].Email != null){
                                String emailValue = co[0].Email;
								String Day_Check_AFI = Label.ICF_Day_Check_Email_SMS_Log_Draft_Send_Exist_AFI;
                                Integer dayCheck = Integer.valueOf(Day_Check_AFI.trim());
                                if(dayCheck != 0){
                                    Date checkDate = RequestDate.addDays(-1*dayCheck);
                                    List<Email_SMS_Log__c> emailSmsLogByEmailExist = [SELECT Id, Email__c, CreatedDate, Status__c FROM Email_SMS_Log__c 
                                                                                      where Email__c =:emailValue and Request_Date__c >=:checkDate and Category__c ='ICF'
                                                                                      and Entity__c in ('AFI','ALI') and Status__c in ('Send','Draft') order by CreatedDate desc];
                                    if(emailSmsLogByEmailExist.size() > 0){
                                       Status = 'Cancel';
                                       ExcludeFrom = 'Have Email & Sms Log Draft/Send for Email Address within day(s): '+dayCheck;
                                    }
                                }
                            }
                        }catch(Exception e){
                            System.debug('Error validation AFI '+e.getMessage());
                        }
                    }
                }
                
                // insert Email_SMS_Log__c
                Email_SMS_Log__c ESLog = new Email_SMS_Log__c();
                // Information
                ESLog.Status__c = Status;
                ESLog.MOT__c = nonccc.MOT__c;
                ESLog.Exclude_From__c = ExcludeFrom;
                ESLog.Template_Email__c = icfes.ICF_Email_Template__c;
                ESLog.Template_SMS__c = icfes.ICF_SMS_Template__c;
                ESLog.Entity__c = nonccc.Entity__c;
                ESLog.Insurance_Type__c = nonccc.Insurance_Type__c;
                
                // Respondent Information
                if (co.size() > 0) ESLog.Account__c = co[0].AccountId;
                if (co.size() > 0) ESLog.Contact__c = co[0].id;
                if (co.size() > 0) ESLog.Contact_Short_Name__c = co[0].LastName;
                if (co.size() > 0) ESLog.Email__c = co[0].Email;
                if (co.size() > 0) ESLog.Mobile__c = co[0].MobilePhone;
                
                // Instant Customer Feedback Configuration
                ESLog.Category__c = 'ICF';
                ESLog.Type__c = 'Non-CCC';
                
                if (nonccc.Entity__c == 'AMFS') {
                    if (ESLog.Mobile__c != NULL) {
                    	ESLog.Method__c = 'Whatsapp';
                    } else {
                        ESLog.Method__c = 'Email';
                    }                    
                } else {
                    ESLog.Method__c = 'Email';
                    if (ESLog.Email__c == NULL) {
                        ESLog.Method__c = 'SMS';
                    }
                }
                
                ESLog.Survey_Type__c = nonccc.MOT__c;
                if (nonccc.ICF_Survey_Template__c == NULL)
                    ESLog.Survey__c = sv.id;
                else
                    ESLog.Survey__c = nonccc.ICF_Survey_Template__c;
                String contacttxt = '';
                if (ESLog.Contact__c == NULL) contacttxt = 'None';
                else contacttxt = ESLog.Contact__c;
                ESLog.Request_Date__c = RequestDate;
                ESLog.Start_Date__c = ESLog.Request_Date__c;
                ESLog.ICF_Non_CCC__c = nonccc.Id;
                ESLog.Survey_URL__c = '[SURVEY_LINK]';
                
                ESLog.Template_Email__c = nonccc.ICF_Email_Template__c;
                ESLog.Template_SMS__c = nonccc.ICF_SMS_Template__c;
                ESLog.Survey_URL__c = sv.URL__c+'id='+ESLog.Survey__c+'&cId='+contacttxt+'&caId=none&eId=none&nonId='+nonccc.id;
                
                insert ESLog;
                // taufik: hide
                //ESLog.Survey_URL__c = sv.URL__c+'id='+ESLog.Survey__c+'&cId='+contacttxt+'&caId=none&eId='+ESLog.id+'&nonId='+nonccc.id;
                //update ESLog;
            }
        }
    }    
}