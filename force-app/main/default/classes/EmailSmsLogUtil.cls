public class EmailSmsLogUtil {
    
    //ICF Parameter
    private static final String INTERVAL_NO_RESPONSE_UNIT = 'WEEK';
    private static final String CUSTOMER = 'Customer';
    private static final String AGENT = 'Agent';
    private static final String EMAIL = 'Email';
    private static final String OTHER_EMAIL = 'Other Email';
    private static final String CLOSED = 'Closed';
    private static final String CREATED = 'Created';
    private static final String OPEN = 'Open';
    private static final String OPEN_CLOSED = 'Open & Closed';
    private static final String MASTER_CCC = 'Master - CCC';
    private static final String NON_CUSTOMER = 'Non Customer';
    //Email & Sms Log
    private static final String I_ASK = 'I Ask';
    private static final String I_BUY = 'I Buy';
    private static final String I_CLAIM = 'I Claim';
    private static final String I_COMPLAIN = 'I Complain';
    private static final String I_RENEW = 'I Renew';
    private static final String ICF = 'ICF';
    private static final String THANKS_NOTE = 'Thanks Note';
    private static final String DRAFT = 'Draft';
    private static final String CCC = 'CCC';
    private static final String NON_CCC = 'Non-CCC';
    private static final String GENERAL = 'General';
    private static final String I_ASK_INQUIRY = 'I Ask - Inquiry';
    private static final String I_ASK_REQUEST = 'I Ask - Request';
    private static final String CANCEL = 'Cancel';
    private static final String SMS = 'SMS';
    private static final String Whatsapp = 'Whatsapp';
    //Case
    private static final String INQUIRY = 'Inquiry';
    private static final String REQUEST = 'Request';
    private static final String REQUEST_POS = 'Request POS';
    private static final String COMPLAINT = 'Complaint';
    private static final String CUSTOMER_AFI = 'Customer AFI';
    private static final String HELPLINE = 'Helpline';
    private static final String SIMPLE = 'Simple';
    private static final String AUTOREPLY_AFI_NAME = 'AutoReplyAFI';
    private static final String AUTOREPLY_AMFS_NAME = 'AutoReplyAMFS';
    private static final String NEGATIVE_FEEDBACK = 'Negative Feedback';
    private static final String AMFS = 'AMFS';
    //Survey
    private static final String MASTER = 'Master';
    private static final String ACTIVE = 'Active';
    //Custom Labels
    private static final String CASE_EXCLUDED = Label.ICF_Cancel_Excluded;
    private static final String CASE_DOWN_PRIORITY = Label.ICF_Cancel_Down_Priority;
    private static final String CASE_CONTACTING = Label.ICF_Cancel_Case_Contacting;
    private static final String CASE_AUTOREPLY = Label.ICF_Cancel_Autoreply;
    private static final String CASE_CONTACT_STATUS = Label.ICF_Cancel_Contact_Status;
    private static final String CASE_NO_INTERACTION = Label.ICF_Cancel_No_Interaction;
    private static final String CASE_FREEZE_DATE = Label.ICF_Cancel_Freeze_Date;
    private static final String CASE_NEGATIVE_FEEDBACK = Label.ICF_Cancel_Negative_Feedback;
    private static final String CASE_HAVE_DRAFT = Label.ICF_Cancel_Have_Draft;
    private static final String CASE_SMS_METHOD = Label.ICF_Cancel_SMS_Method;
    private static final String Day_Check_AFI = Label.ICF_Day_Check_Email_SMS_Log_Draft_Send_Exist_AFI;
    
    //Added by Dimas Support MII 04/02/2025
    private static final String MASTER_NEW_ONBOARDING = 'Master New Onboarding';
    private static final Set<String> withdrawalSurrenderCaseType = new Set<String>{
                        'Request_POS_Withdrawal',
                        'Request_POS_Redemption',
                        'Request_POS_Surrender_Non_UL',
                        'Request_POS_Surrender_Endowment'
    };
    private static final String ORIGIN_WALKIN = 'Walk-In';
        
    public class ICFConfig {
        public Date todayDate;
        public String mot;
        public String caseServiceType;
        public String recordTypeName;
        public Integer tnDay;
        public Integer icfDay;
        public String tnSmsTemplate;
        public String tnEmailTemplate;
        public String icfSmsTemplate;
        public String icfEmailTemplate;
        public Date contactFreezeDate;
        public String method;
        public String emailValue;
        public Integer intervalPending;
        public Integer intervalCompleted;
        public Date pendingDateTn;
        public Date pendingDateICF;
    }
    
    public class ICFValidation {
        public Boolean allowSaveICF;
        public Boolean allowSaveTn;
        public Boolean isCancelledLog;
        public Boolean isCancelledLogTn;
        public Boolean isStatusCaseMatch;
        public Boolean isCustomerAccount;
        public Boolean isCreateTopPriority;
        public Boolean isCreateTopPriorityTn;
        public String excludeFrom;
        public String excludeDesc;
        public String excludeFromTn;
        public String excludeDescTn;
        public List<Email_SMS_Log__c> lowPriorityList;
        public List<Email_SMS_Log__c> lowPriorityListTn;
    }
    
    //Save Email SMS Log Start===================================================================================
    public void saveIcfTnInsert(Case caseObj, Contact contactObj, ICF_Parameter__c icfParamObj, ICF_Parameter__c icfParamCCC, String caseType, String caseStatus) {
        ICFConfig ic = initConfig(caseObj, contactObj, icfParamObj, caseType);
        ICFValidation iv = initValidation();
        iv = validateICF(iv, ic, caseObj, contactObj, icfParamObj, icfParamCCC, caseType, caseStatus);
        doICF(iv, ic, caseObj, contactObj, icfParamObj, caseType);
        doTN(iv, ic, caseObj, contactObj, icfParamObj, caseType);
    }
    
    public void saveIcfInsert(Case caseObj, Contact contactObj, ICF_Parameter__c icfParamObj, ICF_Parameter__c icfParamCCC, String caseType, String caseStatus) {
        ICFConfig ic = initConfig(caseObj, contactObj, icfParamObj, caseType);
        ICFValidation iv = initValidation();
        iv = validateICF(iv, ic, caseObj, contactObj, icfParamObj, icfParamCCC, caseType, caseStatus);
        doICF(iv, ic, caseObj, contactObj, icfParamObj, caseType);
    }
    
    public void saveTnInsert(Case caseObj, Contact contactObj, ICF_Parameter__c icfParamObj, ICF_Parameter__c icfParamCCC, String caseType, String caseStatus) {
        ICFConfig ic = initConfig(caseObj, contactObj, icfParamObj, caseType);
        ICFValidation iv = initValidation();
        iv = validateICF(iv, ic, caseObj, contactObj, icfParamObj, icfParamCCC, caseType, caseStatus);
        doTN(iv, ic, caseObj, contactObj, icfParamObj, caseType);
    }
    
    public void saveIcfTnUpdated(Case caseObj, Contact contactObj, ICF_Parameter__c icfParamObj, ICF_Parameter__c icfParamCCC, String caseType, String caseStatus) {
        ICFConfig ic = initConfig(caseObj, contactObj, icfParamObj, caseType);
        ICFValidation iv = initValidation();
        iv = validateICF(iv, ic, caseObj, contactObj, icfParamObj, icfParamCCC, caseType, caseStatus);
        doICF(iv, ic, caseObj, contactObj, icfParamObj, caseType);
        doTN(iv, ic, caseObj, contactObj, icfParamObj, caseType);
    }
    
    public void saveIcfUpdated(Case caseObj, Contact contactObj, ICF_Parameter__c icfParamObj, ICF_Parameter__c icfParamCCC, String caseType, String caseStatus) {
        ICFConfig ic = initConfig(caseObj, contactObj, icfParamObj, caseType);
        ICFValidation iv = initValidation();
        iv = validateICF(iv, ic, caseObj, contactObj, icfParamObj, icfParamCCC, caseType, caseStatus);
        doICF(iv, ic, caseObj, contactObj, icfParamObj, caseType);
    }
    
    public void saveTnUpdated(Case caseObj, Contact contactObj, ICF_Parameter__c icfParamObj, ICF_Parameter__c icfParamCCC, String caseType, String caseStatus) {
        ICFConfig ic = initConfig(caseObj, contactObj, icfParamObj, caseType);
        ICFValidation iv = initValidation();
        iv = validateICF(iv, ic, caseObj, contactObj, icfParamObj, icfParamCCC, caseType, caseStatus);
        doTN(iv, ic, caseObj, contactObj, icfParamObj, caseType);
    }
    //Save Email SMS Log End==========================================================================================
    
    public ICFConfig initConfig(Case caseObj, Contact contactObj, ICF_Parameter__c icfParamObj, String caseType) {
        ICFConfig iConfig = new ICFConfig();
        system.debug('case obj init config: '+caseObj);
        contactObj = getContactFromCase(caseObj);
        system.debug('contactObj init config: '+contactObj);
        //date & moment of truth
        iConfig.todayDate = Date.today();
        if(caseType.equals(COMPLAINT)) iConfig.mot = I_COMPLAIN;
        else if(caseObj.Case_Type__c.equals('Request_Claim_Payment')) iConfig.mot = I_CLAIM;
        else iConfig.mot = I_ASK;
        //case type
        iConfig.caseServiceType = getCaseServiceType(caseObj);
        //record type
        iConfig.recordTypeName = getRecordTypeName(caseObj);
        //thanks note
        iConfig.tnDay = Integer.valueOf(icfParamObj.Send_Thanks_Note_Day__c != null ? icfParamObj.Send_Thanks_Note_Day__c : '0');
        iConfig.tnSmsTemplate = icfParamObj.Thanks_SMS_Template__c;
        iConfig.tnEmailTemplate = icfParamObj.Thanks_Email_Template__c;
        //icf
        iConfig.icfDay = Integer.valueOf(icfParamObj.Send_ICF_Day__c != null ? icfParamObj.Send_ICF_Day__c : '0');
        iConfig.icfSmsTemplate = icfParamObj.ICF_SMS_Template__c;
        iConfig.icfEmailTemplate = icfParamObj.ICF_Email_Template__c;
        //contact
        Date contactFrzAskDate = contactObj.Freeze_Ask_End_Date__c;
        Date contactFrzClaimDate = contactObj.Freeze_Claim_End_Date__c;
        Date contactFrzComplaintDate = contactObj.Freeze_Complaint_End_Date__c;
        
         
        //pending date & freeze date
        Integer icfCompletedMonth = Integer.valueOf(icfParamObj.Interval_Completed_Month__c != null ? icfParamObj.Interval_Completed_Month__c : '1');
        Integer icfNoResponseMonth = Integer.valueOf(icfParamObj.Interval_No_Response_Month__c != null ? icfParamObj.Interval_No_Response_Month__c : '1');
        Integer icfMaxLoop = Integer.valueOf(icfParamObj.Interval_Max_Loop__c != null ? icfParamObj.Interval_Max_Loop__c : '1');
        icfCompletedMonth = icfCompletedMonth == 0 ? 1 : icfCompletedMonth;
        icfNoResponseMonth = icfNoResponseMonth == 0 ? 1 : icfNoResponseMonth;
        icfMaxLoop = icfMaxLoop == 0 ? 1 : icfMaxLoop;
        iConfig.contactFreezeDate = (caseType == COMPLAINT ? contactFrzComplaintDate : contactFrzAskDate );
        //iConfig.contactFreezeDate = (caseType == COMPLAINT ? contactFrzComplaintDate : ( caseType == REQUEST ? contactFrzClaimDate : contactFrzAskDate )); //complain: iclaim. inquiry&request: iask
        iConfig.intervalPending = (icfNoResponseMonth * icfMaxLoop);
        iConfig.intervalCompleted = icfCompletedMonth;
        iConfig.pendingDateTn = iConfig.tnDay == 0 ? iConfig.todayDate : iConfig.todayDate.addDays(iConfig.tnDay);
        iConfig.pendingDateICF = iConfig.icfDay == 0 ? iConfig.todayDate : iConfig.todayDate.addDays(iConfig.icfDay);
        //method & email
        if (String.isNotBlank(contactObj.Survey_Method__c)) {
            iConfig.method = contactObj.Survey_Method__c;
        }
        else if (String.isNotBlank(icfParamObj.ICF_Method__c)) {
            iConfig.method = icfParamObj.ICF_Method__c;
        }
        else {
            iConfig.method = EMAIL;
        }
        
		iConfig.emailValue = contactObj.Email;
        
        // added by Support at 18 04 2024
        
        if (caseObj != null && contactObj  != null) {
            Case getDetailCase = [select entity__c, mot__c, contact.Freeze_Buy_End_Date__c, contact.Freeze_Claim_End_Date__c, contact.Freeze_Renew_End_Date__c from Case where id =: caseObj.id];
            if (getDetailCase.Entity__c == 'AMFS' && String.isnotblank(getDetailCase.MOT__c)) {
                Date contactFrzBuyDate = getDetailCase.contact.Freeze_Buy_End_Date__c;
                //Date contactFrzClaimDate = getDetailCase.contact.Freeze_Claim_End_Date__c;
                Date contactFrzRenewDate = getDetailCase.contact.Freeze_Renew_End_Date__c;   
                
                if (getDetailCase.MOT__c == 'I Ask') {
                    iConfig.contactFreezeDate = contactFrzAskDate;
                }
                else if (getDetailCase.MOT__c == 'I Complaint') {
                    iConfig.contactFreezeDate = contactFrzComplaintDate;
                }
                else if (getDetailCase.MOT__c == 'I Buy') {
                    iConfig.contactFreezeDate = contactFrzBuyDate;
                }
                else if (getDetailCase.MOT__c == 'I Renew') {
                    iConfig.contactFreezeDate = contactFrzRenewDate;
                }
                else if (getDetailCase.MOT__c == 'I Claim') {
                    iConfig.contactFreezeDate = contactFrzClaimDate;
                }
            }
        }
          
        
        return iConfig;
    }
    
    public ICFValidation initValidation() {
        ICFValidation iValidation = new ICFValidation();
        iValidation.allowSaveICF = true;
        iValidation.allowSaveTn = true;
        iValidation.isCancelledLog = false;
        iValidation.isCancelledLogTn = false;
        iValidation.isStatusCaseMatch = true;
        iValidation.isCustomerAccount = true;
        iValidation.isCreateTopPriority = false;
        iValidation.isCreateTopPriorityTn = false;
        return iValidation;
    }
    
    public ICF_Parameter__c initICFParam(Case caseObj, String RECORD_TYPE_EMAIL_SMS) {
        system.debug('RECORD_TYPE_EMAIL_SMS:'+RECORD_TYPE_EMAIL_SMS);
        
        String entity = null;
        if (caseObj != null) {
            entity = caseObj.Entity__c;
        }        
        String status = 'Active';
        
        DescribeSObjectResult describeResultIcfParam = ICF_Parameter__c.getSObjectType().getDescribe();
        List<String> icfParamFieldList = new List<String>(describeResultIcfParam.fields.getMap().keySet());
        String icfParamFields = String.join(icfParamFieldList, ',');
        String icfParamQuery = '';
        ICF_Parameter__c icfParamObj = null;
        
        List<ICF_Parameter__c> icfParams = [SELECT Id, RecordType.Name FROM ICF_Parameter__c WHERE RecordType.Name = :RECORD_TYPE_EMAIL_SMS AND Status__c = :status AND Entity__c = :entity];
        
        if (icfParams.size() > 0) {
            icfParamQuery = ' SELECT ' + icfParamFields + ', RecordType.Name FROM ICF_Parameter__c WHERE RecordType.Name = :RECORD_TYPE_EMAIL_SMS AND Status__c = :status AND Entity__c = :entity ORDER BY CreatedDate DESC LIMIT 1 ';
            icfParamObj = Database.query(icfParamQuery);
            System.debug(LoggingLevel.DEBUG, '*** ICF PARAM OBJ NOT NULL: ' + icfParamObj);
        }
        else {
            List<ICF_Parameter__c> icfParams2 = [SELECT Id, RecordType.Name FROM ICF_Parameter__c WHERE RecordType.Name = :RECORD_TYPE_EMAIL_SMS AND Status__c = :status AND Entity__c = :GENERAL];
            
            if (icfParams2.size() > 0) {
                icfParamQuery = ' SELECT ' + icfParamFields + ', RecordType.Name FROM ICF_Parameter__c WHERE RecordType.Name = :RECORD_TYPE_EMAIL_SMS AND Status__c = :status AND Entity__c = :GENERAL ORDER BY CreatedDate DESC LIMIT 1 ';
                icfParamObj = Database.query(icfParamQuery);
                System.debug(LoggingLevel.DEBUG, '*** ICF PARAM OBJ GENERAL: ' + icfParamObj);
            }
        }
        return icfParamObj;
    }
    
        public ICF_Parameter__c getICFParamByRecordType(String recordType, String entity) {
        system.debug('*** recordType:'+recordType);
        
        ICF_Parameter__c icfParamObj = null;
        String status = 'Active';
        
        DescribeSObjectResult describeResultIcfParam = ICF_Parameter__c.getSObjectType().getDescribe();
        List<String> icfParamFieldList = new List<String>(describeResultIcfParam.fields.getMap().keySet());
        String icfParamFields = String.join(icfParamFieldList, ',');
        String icfParamQuery = '';
        
        List<ICF_Parameter__c> icfParams = [SELECT Id, RecordType.Name FROM ICF_Parameter__c WHERE RecordType.Name = :recordType AND Status__c = :status AND Entity__c = :entity];
        
        if (icfParams.size() > 0) {
            icfParamQuery = ' SELECT ' + icfParamFields + ', RecordType.Name FROM ICF_Parameter__c WHERE RecordType.Name = :recordType AND Status__c = :status AND Entity__c = :entity ORDER BY CreatedDate DESC LIMIT 1 ';
            icfParamObj = Database.query(icfParamQuery);
            System.debug(LoggingLevel.DEBUG, '*** ICF PARAM OBJ NOT NULL: ' + icfParamObj);
        }
        else {
            List<ICF_Parameter__c> icfParams2 = [SELECT Id, RecordType.Name FROM ICF_Parameter__c WHERE RecordType.Name = :recordType AND Status__c = :status AND Entity__c = :GENERAL];
            
            if (icfParams2.size() > 0) {
                icfParamQuery = ' SELECT ' + icfParamFields + ', RecordType.Name FROM ICF_Parameter__c WHERE RecordType.Name = :recordType AND Status__c = :status AND Entity__c = :GENERAL ORDER BY CreatedDate DESC LIMIT 1 ';
                icfParamObj = Database.query(icfParamQuery);
                System.debug(LoggingLevel.DEBUG, '*** ICF PARAM OBJ GENERAL: ' + icfParamObj);
            }
        }
        return icfParamObj;
    }
    
    public Contact getContactFromCase(Case caseObj) {
        Contact contactObj = null;
        String contactId = caseObj.ContactId;
        
        DescribeSObjectResult describeResultContact = Contact.getSObjectType().getDescribe();
        List<String> contactFieldList = new List<String>(describeResultContact.fields.getMap().keySet());
        String contactFields = String.join(contactFieldList, ',');
        String contactQuery = ' SELECT ' + contactFields + ', Account.Name, Account.Non_Customer_Flag__c FROM Contact WHERE Id = :contactId limit 1';
        system.debug('Contact Query:'+contactQuery);
        try {
            contactObj = Database.query(contactQuery);
        }
        catch (Exception e) {
            return contactObj;
        }
        system.debug('contactObj: '+contactObj);
        return contactObj;
    }
    
    public Survey__c getSurvey(Case caseObj, String recordType, String surveyType, String status) {
        Survey__c survey = null;
        String entity = caseObj.Entity__c;
        
        DescribeSObjectResult describeResultSurvey = Survey__c.getSObjectType().getDescribe();
        List<String> surveyFieldList = new List<String>(describeResultSurvey.fields.getMap().keySet());
        String surveyFields = String.join(surveyFieldList, ',');
        String surveyQuery = '';
        
        List<Survey__c> surveyList = [SELECT Id, RecordType.Name FROM Survey__c WHERE RecordType.Name = :recordType AND Survey_Type__c = :surveyType AND Status__c = :status AND Entity__c = :entity];
        
        if (surveyList.size() > 0) {
            surveyQuery = ' SELECT ' + surveyFields + ', RecordType.Name FROM Survey__c WHERE RecordType.Name = :recordType AND Survey_Type__c = :surveyType AND Status__c = :status AND Entity__c = :entity ORDER BY CreatedDate DESC LIMIT 1 ';
            survey = Database.query(surveyQuery);
            System.debug(LoggingLevel.DEBUG, '*** SURVEY OBJ NOT NULL: ' + survey);
        }
        else {
            List<Survey__c> surveyList2 = [SELECT Id, RecordType.Name FROM Survey__c WHERE RecordType.Name = :recordType AND Survey_Type__c = :surveyType AND Status__c = :status AND Entity__c = null];
            
            if (surveyList2.size() > 0) {
                surveyQuery = ' SELECT ' + surveyFields + ', RecordType.Name FROM Survey__c WHERE RecordType.Name = :recordType AND Survey_Type__c = :surveyType AND Status__c = :status AND Entity__c = null ORDER BY CreatedDate DESC LIMIT 1 ';
            	survey = Database.query(surveyQuery);
                System.debug(LoggingLevel.DEBUG, '*** SURVEY OBJ GENERAL: ' + survey);
            }
        }
        return survey;
    }
    
    public String getSurveyLink(Survey__c survey, Case caseObj) {
        String surveyUrl = '';
        String surveyUrlBase = survey.URL__c;
        
        String surveyUrlParam = '';
        if (survey != null) {
            surveyUrlParam = 'id=' + survey.Id + '&cId=' + caseObj.ContactId + '&caId=' + caseObj.Id;
        } 
        if (ORIGIN_WALKIN.equalsIgnoreCase(caseObj.Origin) && AMFS.equalsIgnoreCase(caseObj.Entity__c)) surveyUrlParam = surveyUrlParam + '&lbaId=' + getLogBookActivityId(caseObj);
        surveyUrl = surveyUrlBase + surveyUrlParam;
        return surveyUrl;
    }
    
    public String getLogBookActivityId(Case caseObj) {
        String lbaId = '';
        List<Log_Book_Activitiy_Detail__c> lbadList = [SELECT Id, Log_Book_Activitiy__c FROM Log_Book_Activitiy_Detail__c WHERE Log_Case__c = :caseObj.Id LIMIT 1];
        if (lbadList.size() > 0) {
            for (Log_Book_Activitiy_Detail__c lbad : lbadList) {
                lbaId = lbad.Log_Book_Activitiy__c;
            }
        }

        return lbaId;
    }
    
    public Survey__c getSurveyById(String surveyId) {
        Survey__c survey = null;
        
        DescribeSObjectResult describeResultSurvey = Survey__c.getSObjectType().getDescribe();
        List<String> surveyFieldList = new List<String>(describeResultSurvey.fields.getMap().keySet());
        String surveyFields = String.join(surveyFieldList, ',');
        String surveyQuery = '';
        
        List<Survey__c> surveyList = [SELECT Id FROM Survey__c WHERE Id = :surveyId];
        
        if (surveyList.size() > 0) {
            surveyQuery = ' SELECT ' + surveyFields + ' FROM Survey__c WHERE Id = :surveyId ORDER BY CreatedDate DESC LIMIT 1 ';
            survey = Database.query(surveyQuery);
        }
        return survey;
    }
    
    public Contact getContactById(String contactId) {
        Contact contactObj = null;
        
        DescribeSObjectResult describeResultContact = Contact.getSObjectType().getDescribe();
        List<String> contactFieldList = new List<String>(describeResultContact.fields.getMap().keySet());
        String contactFields = String.join(contactFieldList, ',');
        String contactQuery = '';
        
        List<Contact> contactList = [SELECT Id FROM Contact WHERE Id = :contactId];
        
        if (contactList.size() > 0) {
            contactQuery = ' SELECT ' + contactFields + ' FROM Contact WHERE Id = :contactId ORDER BY CreatedDate DESC LIMIT 1 ';
            contactObj = Database.query(contactQuery);
        }
        return contactObj;
    }
    
    public SurveyTaker__c getSurveyTakerById(String surveyTakerId) {
        DescribeSObjectResult describeResultSt = SurveyTaker__c.getSObjectType().getDescribe();
        List<String> stFieldList = new List<String>(describeResultSt.fields.getMap().keySet());
        String stFields = String.join(stFieldList, ',');
        String stQuery = ' SELECT ' + stFields + ' FROM SurveyTaker__c WHERE Id = :surveyTakerId ';
        SurveyTaker__c st = Database.query(stQuery);
        return st;
    }
    
    public Email_SMS_Log__c getEmailSmsLogByRequestDate(String category, Contact contactObj, Date requestDate) {
        String contactId = contactObj.Id;
        DescribeSObjectResult describeResultEsl = Email_SMS_Log__c.getSObjectType().getDescribe();
        List<String> eslFieldList = new List<String>(describeResultEsl.fields.getMap().keySet());
        String eslFields = String.join(eslFieldList, ',');
        String eslQuery = ' SELECT ' + eslFields + ' FROM Email_SMS_Log__c WHERE Category__c = :category and Contact__c = :contactId AND Request_Date__c = :requestDate ';
        Email_SMS_Log__c esl = Database.query(eslQuery);
        return esl;
    }
    
    public String getCaseServiceType(Case caseObj) {
        String caseServiceType = CUSTOMER;
        if ((CUSTOMER_AFI).equals(caseObj.Service_Type__c)) {
            caseServiceType = CUSTOMER;
        }
        else if ((HELPLINE).equals(caseObj.Service_Type__c)) {
            caseServiceType = AGENT;
        }
        return caseServiceType;
    }
    
    public String getRecordTypeName(Case caseObj) {
        String recordTypeName = null;
        List<RecordType> checkRecordTypes = [SELECT Id, DeveloperName FROM RecordType WHERE Id = :caseObj.RecordTypeId];
        if (checkRecordTypes.size() > 0) {
            recordTypeName = checkRecordTypes[0].DeveloperName;
        }
        return recordTypeName;
    }
    
    public String getEmailValueFromContact(Contact contactObj, String emailValue) {
        if (contactObj.Survey_Method__c != null) {
            String method = contactObj.Survey_Method__c;
            if (method.equals(EMAIL)) {
                if (contactObj.Survey_Submethod__c.equals(OTHER_EMAIL)) {
                    emailValue = contactObj.Other_Email__c;
                }
            }
        }
        return emailValue;
    }
    
    public Email_SMS_Log__c getLoopDate(Email_SMS_Log__c esl, ICF_Parameter__c icfParamObj, ICFConfig ic) {
        if (String.isNotBlank(icfParamObj.Interval_Max_Loop__c) && icfParamObj.Interval_Max_Loop__c.isNumeric()) {
            Integer interval = Integer.valueOf(icfParamObj.Interval_No_Response_Month__c != null ? icfParamObj.Interval_No_Response_Month__c : '1');
            Date loopDate = ic.todayDate;
            for (Integer i = 1; i <= Integer.valueOf(icfParamObj.Interval_Max_Loop__c); i++) {
                if ('MONTH' == INTERVAL_NO_RESPONSE_UNIT) {
                    loopDate = loopDate.addMonths(interval);
                }
                else if ('WEEK' == INTERVAL_NO_RESPONSE_UNIT) {
                    loopDate = loopDate.addDays(interval*7);
                }
                String loopDateField = 'Loop_Date_' + i + '__c';
                esl.put(loopDateField, loopDate);
            }
        }
        return esl;
    }
    
    public ICFValidation validateICF(ICFValidation iv, ICFConfig ic, Case caseObj, Contact contactObj, ICF_Parameter__c icfParamObj, ICF_Parameter__c icfParamCCC, String caseType, String caseStatus) {
        /*
         * Validation - Stage 1
         * Check the status of the case is match with the Status_Cases__c value in the ICF Parameter
         * Check the account name contains non customer or not
         * Check the account non customer flag
         * NOTE: within this validation, there is no cancelled log if the case is captured in stage 1
         */ 
        system.debug('ICF PARAM: ' + icfParamCCC);
        //system.debug('STATUS CASE: ' + icfParamCCC.Status_Cases__c);
        contactObj = getContactFromCase(caseObj);
        system.debug('contactObj init config: '+contactObj);
        if (icfParamCCC.Status_Cases__c != OPEN_CLOSED && icfParamCCC.Status_Cases__c != caseStatus) {
            iv.isStatusCaseMatch = false;
            iv.allowSaveICF = false;
            iv.isCancelledLog = false;
            iv.isCreateTopPriority = false;
        }
        if (contactObj.AccountId != null) {
            if (contactObj.Account.Name != null) {
                if (contactObj.Account.Name.contains(NON_CUSTOMER)) {
                    iv.isCustomerAccount = false;
                    iv.allowSaveICF = false;
                    iv.allowSaveTn = false;
                    iv.isCancelledLog = false;
            		iv.isCreateTopPriority = false;
                }
            }
        }
        if (contactObj.AccountId != null) {
            if (contactObj.Account.Non_Customer_Flag__c) {
                iv.isCustomerAccount = false;
                iv.allowSaveICF = false;
                iv.allowSaveTn = false;
                iv.isCancelledLog = false;
            	iv.isCreateTopPriority = false;
            }
        }
        
        /*
         * Validation - Stage 2
         * Check the case negative feedback
         * Check the case contacting in ICF Parameter
         * Check the record type of the case is autoreply or not
         * Check the case type is excluded or not based on ICF Parameter 
         * Check the contact status in the contact
         * Check the contact no interaction flag
         * Check the contact freeze
         * Check the case priority ICF / have email & sms log draft
         * Check the sms method (temporary)
         * NOTE: within this validation, if the case captured in any type of stage 2 validation will create cancelled log to Email & Sms Log object
         */ 
        if (iv.isStatusCaseMatch) {
            if (iv.isCustomerAccount) {
                Boolean cont = true;
                
                if (cont) {
                    //case negative feedback
                    if (caseObj.Origin == NEGATIVE_FEEDBACK) {
                        iv.allowSaveICF = false;
                        iv.isCancelledLog = true;
                        iv.isCreateTopPriority = false;
                        iv.excludeFrom = 'Negative Feedback';
                        iv.excludeDesc = CASE_NEGATIVE_FEEDBACK;
                        cont = false;
                    }
                }
                if (cont) {
                    //case contacting in ICF Parameter
                    icfParamObj.Send_to_Case_Contacting__c = String.isBlank(icfParamObj.Send_to_Case_Contacting__c) ? CUSTOMER : icfParamObj.Send_to_Case_Contacting__c;
                    if (icfParamObj.Send_to_Case_Contacting__c != ic.caseServiceType) {
                        iv.allowSaveICF = false;
                        iv.isCancelledLog = true;
                        iv.isCreateTopPriority = false;
                        iv.excludeFrom = 'Case Service Type: ' + caseObj.Service_Type__c + ' != ICF Parameter: ' +  icfParamObj.Send_to_Case_Contacting__c;
                        iv.excludeDesc = CASE_CONTACTING;
                        cont = false;
                    }
                }
                if (cont) {
                    //record type of the case is autoreply or not
                    if (caseType == REQUEST || caseType == COMPLAINT) {
                        if (ic.recordTypeName == AUTOREPLY_AFI_NAME || ic.recordTypeName == AUTOREPLY_AMFS_NAME) {
                            iv.allowSaveICF = false;
                            iv.allowSaveTn = false;
                            iv.isCancelledLog = true;
                            iv.isCreateTopPriority = false;
                            iv.excludeFrom = 'Record Type: ' + ic.recordTypeName;
                        	iv.excludeDesc = CASE_AUTOREPLY;
                            cont = false;
                        }
                    }
                }
                if (cont) {
                    //case type is excluded or not based on ICF Parameter
                    if (caseType == COMPLAINT) {
                        String[] iComplainExcludeArr = icfParamCCC.CCC_I_Complain_Exculde__c.split(';');
                        System.debug(LoggingLevel.DEBUG, '***Complaint_type__c: ' + caseObj.Complaint_type__c);
                        for (String iComplainExclude : iComplainExcludeArr) {
                            System.debug(LoggingLevel.DEBUG, '*** ICOMPLAINT Exclude Case: ' + caseObj.Complaint_type__c);
                        	System.debug(LoggingLevel.DEBUG, '*** ICOMPLAINT Exclude ICF Array: ' + iComplainExclude);
                            if (caseObj.Complaint_type__c == iComplainExclude) {
                                iv.allowSaveICF = false;
                                iv.isCancelledLog = true;
                                iv.isCreateTopPriority = false;
                                iv.excludeFrom = iComplainExclude;
                        		iv.excludeDesc = CASE_EXCLUDED;
                                cont = false;
                                break;
                            }
                        }
                    }
                    else {
                        String[] iAskExcludeArr = icfParamCCC.CCC_I_Ask_Exculde__c.split(';');
                        System.debug(LoggingLevel.DEBUG, '***Case_Type_Config__c: ' + caseObj.Case_Type_Config__c);
                        for (String iAskExclude : iAskExcludeArr) {
                            System.debug(LoggingLevel.DEBUG, '*** IASK Exclude Case: ' + caseObj.Case_Type_Config__c);
                        	System.debug(LoggingLevel.DEBUG, '*** IASK Exclude ICF Array: ' + iAskExclude);
                            if (caseObj.Case_Type_Config__c == iAskExclude) {
                                iv.allowSaveICF = false;
                                iv.isCancelledLog = true;
                                iv.isCreateTopPriority = false;
                                iv.excludeFrom = iAskExclude;
                        		iv.excludeDesc = CASE_EXCLUDED;
                                cont = false;
                                break;
                            }
                        }
                    }
                }
                if (cont) {
                    //contact status in the contact
                    if (String.isNotBlank(contactObj.Contact_Status__c)) {
                        iv.allowSaveICF = false;
                        iv.isCancelledLog = true;
                        iv.isCreateTopPriority = false;
                        iv.excludeFrom = 'Contact Status: ' + contactObj.Contact_Status__c;
                        iv.excludeDesc = CASE_CONTACT_STATUS;
                        cont = false;
                    }
                }
                if (cont) {
                    //contact no interaction flag
                    if (contactObj.No_Interaction_ICF__c) {
                        iv.allowSaveICF = false;
                        iv.isCancelledLog = true;
                        iv.isCreateTopPriority = false;
                        iv.excludeFrom = 'Contact No Interaction ICF: ' + contactObj.No_Interaction_ICF__c;
                        iv.excludeDesc = CASE_NO_INTERACTION;
                        cont = false;
                    }
                }
                if (cont) {
                    //contact freeze
                    if (!withdrawalSurrenderCaseType.contains(caseObj.Case_Type__c) && caseObj.Type != REQUEST_POS &&  caseObj.Case_Type__c != 'Request_Claim_Payment') {
                        
                        if (ic.contactFreezeDate >= ic.todayDate) {
                            iv.allowSaveICF = false;
                            iv.isCancelledLog = true;
                            iv.isCreateTopPriority = false;
                            iv.excludeFrom = 'Freeze until: ' + ic.contactFreezeDate;
                            iv.excludeDesc = CASE_FREEZE_DATE;
                            cont = false;
                        }
                        
                    }
                }
                if (cont) {
                    // Edited by Dimas Support MII 28/02/2025
                    if (caseObj.Entity__c == 'AMFS' && withdrawalSurrenderCaseType.contains(caseObj.Case_Type__c) && caseObj.Type == REQUEST_POS) {
                        //Continue
                    } else {
                        //case priority ICF
                        List<Email_SMS_Log__c> emailSmsLogChecks = [SELECT Id, Case_List__c FROM Email_SMS_Log__c WHERE Category__c = :ICF 
                                                                    and Contact__c = :contactObj.Id AND Request_Date__c <= :ic.pendingDateICF 
                                                                    and Status__c = :DRAFT AND Case_Number__c != :caseObj.CaseNumber
                                                                    ORDER BY CreatedDate DESC];
                        if (emailSmsLogChecks.size() > 0) {
                            if (String.isNotBlank(icfParamObj.Case_Priority_ICF__c)) {
                                if (caseType == icfParamObj.Case_Priority_ICF__c) {
                                    iv.isCreateTopPriority = true;
                                    iv.lowPriorityList = new List<Email_SMS_Log__c>();
                                    for (Email_SMS_Log__c lowEsl : emailSmsLogChecks) {
                                        lowEsl.Status__c = CANCEL;
                                        lowEsl.Exclude_From__c = 'Have Email & Sms Log Draft';
                                        lowEsl.Description__c = CASE_HAVE_DRAFT;
                                        iv.lowPriorityList.add(lowEsl);
                                    }
                                }
                                else {
                                    iv.allowSaveICF = false;
                                    iv.isCancelledLog = true;
                                    iv.excludeFrom = 'Have Email & Sms Log Draft';
                                    iv.excludeDesc = CASE_HAVE_DRAFT;
                                    cont = false;
                                }
                            }
                            else {
                                //handle the log here if case priority ICF is set to empty
                                //by default it will create any log when case is created/closed based on ICF Parameter
                            }
                        }
                    }
                }
                // add by Beni, 10052023, check if email already sent denying policy no only it's email address
                if(cont){
                    try{
                    	if(caseObj.entity__c.equals('AFI') || caseObj.entity__c.equals('ALI')) {
                            Integer dayCheck = Integer.valueOf(Day_Check_AFI.trim());
                            if(dayCheck != 0){
                                String emailValue = getEmailValueFromContact(contactObj, ic.emailValue);
                                Date checkDate = ic.pendingDateICF.addDays(-1*dayCheck);
                                List<Email_SMS_Log__c> emailSmsLogByEmailExist = [SELECT Id, Email__c, CreatedDate, Status__c FROM Email_SMS_Log__c 
                                                                                  where Email__c =:emailValue and Request_Date__c >=:checkDate and Category__c =:ICF
                                                                                  and Entity__c in ('AFI','ALI') and Status__c in ('Send','Draft') order by CreatedDate desc];
                                if(emailSmsLogByEmailExist.size() > 0){
                                    iv.allowSaveICF = false;
                                    iv.isCancelledLog = true;
                                    iv.excludeFrom = 'Have Email & Sms Log Draft/Send for Email Address within day(s): '+dayCheck;
                                    iv.excludeDesc = 'This ICF is cancelled because email address already have send/draft within day(s): '+dayCheck;
                                    cont = false;
                                }
                            }
                        }
                    }catch(Exception e){
                    	System.debug('Error validation AFI '+e.getMessage());
                    }
                    
                }
                /*
                if (cont) {
                    //cancel sms method
                    String emailValue = getEmailValueFromContact(contactObj, ic.emailValue);
                    String checkEmail = ic.caseServiceType.equals(AGENT) ? contactObj.Agent_Email__c : emailValue;
                    if (String.isBlank(checkEmail)) {
                        iv.allowSaveICF = false;
                        iv.isCancelledLog = true;
                        iv.isCreateTopPriority = false;
                        iv.excludeFrom = 'SMS Method Under Construction';
                       	iv.excludeDesc = CASE_SMS_METHOD;
                    }
                }
				*/
            }
        }
        
        /*
         * Validation - Stage 3
         * Check the send thanks note when case created/closed based on ICF Parameter
         * Check if thanks note exist and still draft, it will merge the thanks note and add case number list, then update the log lookup by thanks note priority
         * NOTE: this is thanks note validation only
         */ 
        if (iv.isCustomerAccount) {
            Boolean cont = true;
            
            if (cont) {
                if (caseStatus == CLOSED) {
                    if (icfParamObj.Send_Thanks_Note_When_Case__c != CLOSED) {
                        //continue
                    }
                }
                else {
                    if (icfParamObj.Send_Thanks_Note_When_Case__c == CLOSED) {
                        iv.allowSaveTn = false;
                        cont = false;
                    }
                }
            }
            if (cont) {
                if (icfParamObj.Merge_Thanks_Note__c) {
                    List<Email_SMS_Log__c> emailSmsLogChecks = [SELECT Id, Case_List__c FROM Email_SMS_Log__c 
                                                            WHERE Category__c = :THANKS_NOTE and Contact__c = :contactObj.Id 
                                                            AND Request_Date__c = :ic.pendingDateTn ORDER BY CreatedDate LIMIT 1];
                    if (emailSmsLogChecks.size() > 0) {
                        String existingCaseList = emailSmsLogChecks[0].Case_List__c;
                        Email_SMS_Log__c eslUpdate = new Email_SMS_Log__c();
                        eslUpdate.Id = emailSmsLogChecks[0].Id;
                        if (String.isNotBlank(existingCaseList)) {
                            if (!existingCaseList.contains(caseObj.CaseNumber)) {
                                eslUpdate.Case_List__c = existingCaseList + ';' + caseObj.CaseNumber;
                            }
                            if (icfParamObj.Case_Priority__c != null) {
                                if (caseType.equals(icfParamObj.Case_Priority__c)) {
                                    eslUpdate.Case__c = caseObj.Id;
                                    eslUpdate.Template_Email__c = icfParamObj.Thanks_Email_Template__c;
                                    eslUpdate.Template_SMS__c = icfParamObj.Thanks_SMS_Template__c;
                                    eslUpdate.Email_SMS_Template__c = eslUpdate.Method__c == EMAIL ? 
                                        icfParamObj.Thanks_Email_Template__c : icfParamObj.Thanks_SMS_Template__c;
                                    
                                }
                            }
                        }
                        if (iv.allowSaveTn) {
                            update eslUpdate;
                            iv.allowSaveTn = false;
                            cont = false;
                        }
                    }
                }
            }
            if (cont) {
                // Edited by Dimas Support MII 28/02/2025
                if (caseObj.Entity__c == 'AMFS' && withdrawalSurrenderCaseType.contains(caseObj.Case_Type__c) && caseObj.Type == REQUEST_POS) {
                    // Continue
                } else {
                    if (!icfParamObj.Merge_Thanks_Note__c) {
                        //case priority TN
                        List<Email_SMS_Log__c> emailSmsLogChecks = [SELECT Id, Case_List__c FROM Email_SMS_Log__c WHERE Category__c = :THANKS_NOTE 
                                                                    and Contact__c = :contactObj.Id AND Request_Date__c <= :ic.pendingDateTn 
                                                                    and Status__c = :DRAFT AND Case_Number__c != :caseObj.CaseNumber
                                                                    ORDER BY CreatedDate DESC];
                        if (emailSmsLogChecks.size() > 0) {
                            if (String.isNotBlank(icfParamObj.Case_Priority__c)) {
                                if (caseType == icfParamObj.Case_Priority__c) {
                                    iv.isCreateTopPriorityTn = true;
                                    iv.lowPriorityListTn = new List<Email_SMS_Log__c>();
                                    for (Email_SMS_Log__c lowEsl : emailSmsLogChecks) {
                                        lowEsl.Status__c = CANCEL;
                                        lowEsl.Exclude_From__c = 'Have Email & Sms Log Draft';
                                        lowEsl.Description__c = CASE_HAVE_DRAFT;
                                        iv.lowPriorityListTn.add(lowEsl);
                                    }
                                }
                                else {
                                    iv.allowSaveTn = false;
                                    iv.isCancelledLogTn = true;
                                    iv.excludeFromTn = 'Have Email & Sms Log Draft';
                                    iv.excludeDescTn = CASE_HAVE_DRAFT;
                                    cont = false;
                                }
                            }
                            else {
                                //handle the log here if case priority ICF is set to empty
                                //by default it will create any log when case is created/closed based on ICF Parameter
                            }
                        }
                    }
                }
            }
        }
        
        return iv;
    }
    
    public void doICF(ICFValidation iv, ICFConfig ic, Case caseObj, Contact contactObj, ICF_Parameter__c icfParamObj, String caseType) {
        system.debug('**CASE doICF');
        system.debug('**CASE allowSaveICF:'+iv.allowSaveICF);
        system.debug('**CASE isCancelledLog:'+iv.isCancelledLog);
        if (iv.allowSaveICF) {
            if (iv.isCreateTopPriority) {
                //priority ICF
                createLogDraft(ic, caseObj, contactObj, icfParamObj, caseType);
                if (iv.lowPriorityList.size() > 0) update iv.lowPriorityList;
            }
            else {
                //normal ICF
                system.debug('**CASE Normal ICF');
                createLogDraft(ic, caseObj, contactObj, icfParamObj, caseType);
            }
        }
        else {
            if (iv.isCancelledLog) {
                //cancelled ICF
                createLogCancel(ic, caseObj, contactObj, icfParamObj, caseType, iv.excludeFrom, iv.excludeDesc);
            }
        }
    }
    
    public void doTN(ICFValidation iv, ICFConfig ic, Case caseObj, Contact contactObj, ICF_Parameter__c icfParamObj, String caseType) {
        if (iv.allowSaveTn) {
            if (iv.isCreateTopPriorityTn) {
                //priority TN
                createLogTN(ic, caseObj, contactObj, icfParamObj, caseType);
                if (iv.lowPriorityListTn.size() > 0) update iv.lowPriorityListTn;
            }
            else {
                //normal TN
                createLogTN(ic, caseObj, contactObj, icfParamObj, caseType);
            }
            
        }
        else {
            if (iv.isCancelledLogTn) {
                createLogTNCancel(ic, caseObj, contactObj, icfParamObj, caseType, iv.excludeFromTn, iv.excludeDescTn);
            }
        }
    }
    
    public void updateContactFreezeDate(Contact contactObj, Date todayDate, Integer interval, String surveyType, String intervalUnit) {
        Date freezeDate = null;
        if ('MONTH' == intervalUnit) {
            freezeDate = todayDate.addMonths(interval);
        }
        else if ('WEEK' == intervalUnit) {
            freezeDate = todayDate.addDays(interval*7);
        }
        
        if (I_ASK == surveyType) {
            contactObj.Freeze_Ask_End_Date__c = freezeDate;
            contactObj.Survey_Ask_Send_Counter__c = 0;
            update contactObj;
        }
        else if (I_BUY == surveyType) {
            contactObj.Freeze_Buy_End_Date__c = freezeDate;
            contactObj.Survey_Buy_Send_Counter__c = 0;
            update contactObj;
        }
        else if (I_CLAIM == surveyType) {
            contactObj.Freeze_Claim_End_Date__c = freezeDate;
            contactObj.Survey_Claim_Send_Counter__c = 0;
            update contactObj;
        }
        else if (I_COMPLAIN == surveyType) {
            contactObj.Freeze_Complaint_End_Date__c = freezeDate;
            contactObj.Survey_Complaint_Send_Counter__c = 0;
            update contactObj;
        }
        else if (I_RENEW == surveyType) {
            contactObj.Freeze_Renew_End_Date__c = freezeDate;
            contactObj.Survey_Renew_Send_Counter__c = 0;
            update contactObj;
        }
    }
    
    public void updateContactFreezeDateToday(Contact contactObj, Date todayDate, Integer interval, String surveyType) {
        Date freezeDate = todayDate;
        
        if (I_ASK == surveyType) {
            contactObj.Freeze_Ask_End_Date__c = freezeDate;
            contactObj.Survey_Ask_Send_Counter__c = 0;
            update contactObj;
        }
        else if (I_BUY == surveyType) {
            contactObj.Freeze_Buy_End_Date__c = freezeDate;
            contactObj.Survey_Buy_Send_Counter__c = 0;
            update contactObj;
        }
        else if (I_CLAIM == surveyType) {
            contactObj.Freeze_Claim_End_Date__c = freezeDate;
            contactObj.Survey_Claim_Send_Counter__c = 0;
            update contactObj;
        }
        else if (I_COMPLAIN == surveyType) {
            contactObj.Freeze_Complaint_End_Date__c = freezeDate;
            contactObj.Survey_Complaint_Send_Counter__c = 0;
            update contactObj;
        }
        else if (I_RENEW == surveyType) {
            contactObj.Freeze_Renew_End_Date__c = freezeDate;
            contactObj.Survey_Renew_Send_Counter__c = 0;
            update contactObj;
        }
    }
    
    @future(callout=true)
    public static void updateContactFreezeDateFuture(String contactId, Date todayDate, Integer interval, String surveyType, String intervalUnit) {
        DescribeSObjectResult describeResultContact = Contact.getSObjectType().getDescribe();
        List<String> contactFieldList = new List<String>(describeResultContact.fields.getMap().keySet());
        String contactFields = String.join(contactFieldList, ',');
        String contactQuery = ' SELECT ' + contactFields + ' FROM Contact WHERE Id = :contactId ';
        Contact contactObj = Database.query(contactQuery);
        
        Date freezeDate = null;
        if ('MONTH' == intervalUnit) {
            freezeDate = todayDate.addMonths(interval);
        }
        else if ('WEEK' == intervalUnit) {
            freezeDate = todayDate.addDays(interval*7);
        }
        
        if (I_ASK == surveyType) {
            contactObj.Freeze_Ask_End_Date__c = freezeDate;
            contactObj.Survey_Ask_Send_Counter__c = 0;
            update contactObj;
        }
        else if (I_BUY == surveyType) {
            contactObj.Freeze_Buy_End_Date__c = freezeDate;
            contactObj.Survey_Buy_Send_Counter__c = 0;
            update contactObj;
        }
        else if (I_CLAIM == surveyType) {
            contactObj.Freeze_Claim_End_Date__c = freezeDate;
            contactObj.Survey_Claim_Send_Counter__c = 0;
            update contactObj;
        }
        else if (I_COMPLAIN == surveyType) {
            contactObj.Freeze_Complaint_End_Date__c = freezeDate;
            contactObj.Survey_Complaint_Send_Counter__c = 0;
            update contactObj;
        }
        else if (I_RENEW == surveyType) {
            contactObj.Freeze_Renew_End_Date__c = freezeDate;
            contactObj.Survey_Renew_Send_Counter__c = 0;
            update contactObj;
        }
    }
    
    public void createLogDraft(ICFConfig ic, Case caseObj, Contact contactObj, ICF_Parameter__c icfParamObj, String caseType) {
        contactObj = getContactFromCase(caseObj);
        system.debug('contactObj init config: '+contactObj);
        List<Email_SMS_Log__c> eslListEx = [SELECT Id FROM Email_SMS_Log__c WHERE Category__c = :ICF 
                                            AND Contact__c = :contactObj.Id AND Case_Number__c = :caseObj.CaseNumber 
                                            AND Request_Date__c <= :ic.pendingDateICF LIMIT 1];
        
        system.debug('**CASE createLogDraft');
        if (eslListEx.size() == 0) {
            Survey__c survey = new Survey__c();
            if(caseObj.Entity__c == 'AMFS' && ((withdrawalSurrenderCaseType.contains(caseObj.Case_Type__c) && caseObj.Type == REQUEST_POS) || caseObj.Type == COMPLAINT || caseObj.Type == INQUIRY || caseObj.Case_Type__c == 'Request_Claim_Payment')){
                survey = getSurvey(caseObj, MASTER_NEW_ONBOARDING, ic.mot, ACTIVE);
            } else {
                survey = getSurvey(caseObj, MASTER, ic.mot, ACTIVE);
            }	            
            String surveyUrl = getSurveyLink(survey, caseObj);
            //String surveyUrl = getShortUrl(survey, caseObj);
            String emailValue = getEmailValueFromContact(contactObj, ic.emailValue);
            
            Email_SMS_Log__c esl = new Email_SMS_Log__c();
            esl = getLoopDate(esl, icfParamObj, ic);
            esl.OwnerId = UserInfo.getUserId();
            esl.Account__c = caseObj.AccountId;
            esl.Case__c = caseObj.Id;
            esl.Category__c = ICF;
            esl.Contact__c = contactObj.Id;
            esl.Email_SMS_Template__c = ic.method == EMAIL ? 
                (esl.Category__c.equals(ICF) ? ic.icfEmailTemplate : ic.tnEmailTemplate) 
                : (esl.Category__c.equals(ICF) ? ic.icfSmsTemplate : ic.tnSmsTemplate);
            esl.Email__c = ic.caseServiceType.equals(AGENT) ? contactObj.Agent_Email__c : emailValue;
            esl.Entity__c = caseObj.Entity__c;
            esl.Method__c = String.isBlank(esl.Email__c) ? SMS : ic.method;
            //esl.Method__c = ic.method;
            esl.Mobile__c = contactObj.MobilePhone;
            esl.Request_Date__c = ic.pendingDateICF;
            esl.Send_Flag__c = true;
            esl.Start_Date__c = ic.pendingDateICF;
            esl.Status__c = DRAFT;
           
            if(caseObj.Case_Type__c == 'Request_Claim_Payment' ) esl.Survey_Type__c = 'I Claim - Request';
            else esl.Survey_Type__c = (caseType.equals(INQUIRY) ? I_ASK_INQUIRY : ic.mot);
            esl.Survey_URL__c = surveyUrl;
            system.debug('esl.Survey_URL__c: '+esl.Survey_URL__c);
            esl.Survey__c = survey.Id;
            system.debug('survey.Id: '+survey.Name);
            esl.Type__c = CCC;
            esl.Case_List__c = caseObj.CaseNumber;
            esl.Template_Email__c = esl.Category__c.equals(ICF) ? ic.icfEmailTemplate : ic.tnEmailTemplate;
            esl.Template_SMS__c = esl.Category__c.equals(ICF) ? ic.icfSmsTemplate : ic.tnSmsTemplate;
            esl.Department_Owner__c = ICF;
            esl.Topic__c = ICF;
            esl.MOT__c = ic.mot;
            
            //Added by Dimas Support MII 08/02/2025
            if(caseObj.Entity__c == 'AMFS' && withdrawalSurrenderCaseType.contains(caseObj.Case_Type__c) && caseObj.Type == REQUEST_POS){
                Map<String, Object> parsedData = parseDescriptionWithdrawalSurrender(caseObj.Description);   
                esl.Status_Payment__c = String.valueOf(parsedData.get('Transfer Status'));
                System.Debug(parsedData.get('Transfer Date'));
                esl.Date_Payment__c = (Date) parsedData.get('Transfer Date');
                esl.Payment_Code__c = String.valueOf(parsedData.get('Payment Code'));
            }
            
            if(caseObj.Entity__c == 'AMFS' && ((withdrawalSurrenderCaseType.contains(caseObj.Case_Type__c) && caseObj.Type == REQUEST_POS) || caseObj.Type == COMPLAINT)){
                if(String.isBlank(esl.Email__c) || String.isNotBlank(esl.Mobile__c)) {
                    esl.Method__c = Whatsapp;
                } else if(String.isNotBlank(esl.Email__c) || String.isBlank(esl.Mobile__c)) {
                    esl.Method__c = EMAIL;
				}
            }
            
            insert esl;
            system.debug('**ESL ID'+esl.Id);
            //change freeze date to inteval completed for every sending email & sms log
            //not update contact if create log draft, moved to icf log with status 'Send'
            //change freeze date to today if draft
            //disable the freeze today
            //updateContactFreezeDateToday(contactObj, ic.todayDate, ic.intervalCompleted, ic.mot);
        }
    }
    /*
    public string getShortURL() {
        
        String result = '';
        
        result = BitlyBatch.getURL();
        
        return result
    }
    */
    public void createLogCancel(ICFConfig ic, Case caseObj, Contact contactObj, ICF_Parameter__c icfParamObj, String caseType, String excludeFrom, String excludeDesc) {
        List<Email_SMS_Log__c> eslListEx = [SELECT Id FROM Email_SMS_Log__c WHERE Category__c = :ICF 
                                            AND Contact__c = :contactObj.Id AND Case_Number__c = :caseObj.CaseNumber 
                                            AND Request_Date__c <= :ic.pendingDateICF LIMIT 1];
        
        system.debug('**CASE createLogCancel');
        if (eslListEx.size() == 0) {
            Survey__c survey = new Survey__c();
            if(caseObj.Entity__c == 'AMFS' && ((withdrawalSurrenderCaseType.contains(caseObj.Case_Type__c) && caseObj.Type == REQUEST_POS) || caseObj.Type == COMPLAINT || caseObj.Type == INQUIRY || caseObj.Case_Type__c == 'Request_Claim_Payment')){
                survey = getSurvey(caseObj, MASTER_NEW_ONBOARDING, ic.mot, ACTIVE);
            }
            else {
                survey = getSurvey(caseObj, MASTER, ic.mot, ACTIVE);
            }
            
            String surveyUrl = getSurveyLink(survey, caseObj);
            String emailValue = getEmailValueFromContact(contactObj, ic.emailValue);
            
            Email_SMS_Log__c esl = new Email_SMS_Log__c();
            esl.OwnerId = UserInfo.getUserId();
            esl.Account__c = caseObj.AccountId;
            esl.Case__c = caseObj.Id;
            esl.Category__c = ICF;
            esl.Contact__c = contactObj.Id;
            esl.Email_SMS_Template__c = ic.method == EMAIL ? 
                (esl.Category__c.equals(ICF) ? ic.icfEmailTemplate : ic.tnEmailTemplate) 
                : (esl.Category__c.equals(ICF) ? ic.icfSmsTemplate : ic.tnSmsTemplate);
            esl.Email__c = ic.caseServiceType.equals(AGENT) ? contactObj.Agent_Email__c : emailValue;
            esl.Entity__c = caseObj.Entity__c;
            esl.Method__c = String.isBlank(esl.Email__c) ? SMS : ic.method;
            //esl.Method__c = ic.method;
            esl.Mobile__c = contactObj.MobilePhone;
            esl.Request_Date__c = ic.pendingDateICF;
            esl.Send_Flag__c = true;
            esl.Start_Date__c = ic.pendingDateICF;
            esl.Status__c = CANCEL;
            esl.Description__c = excludeDesc;
            esl.Exclude_From__c = excludeFrom;
            esl.Survey_Type__c = (caseType.equals(INQUIRY) ? I_ASK_INQUIRY : ic.mot);
            esl.Survey_URL__c = surveyUrl;
            esl.Survey__c = survey.Id;
            esl.Type__c = CCC;
            esl.Case_List__c = caseObj.CaseNumber;
            esl.Template_Email__c = esl.Category__c.equals(ICF) ? ic.icfEmailTemplate : ic.tnEmailTemplate;
            esl.Template_SMS__c = esl.Category__c.equals(ICF) ? ic.icfSmsTemplate : ic.tnSmsTemplate;
            esl.Department_Owner__c = ICF;
            esl.Topic__c = ICF;
            esl.MOT__c = ic.mot;
            
            //Added by Dimas Support MII 08/02/2025
            if(caseObj.Entity__c == 'AMFS' && withdrawalSurrenderCaseType.contains(caseObj.Case_Type__c) && caseObj.Type == REQUEST_POS){
                Map<String, Object> parsedData = parseDescriptionWithdrawalSurrender(caseObj.Description);   
                esl.Status_Payment__c = String.valueOf(parsedData.get('Transfer Status'));
                System.Debug(parsedData.get('Transfer Date'));
                esl.Date_Payment__c = (Date) parsedData.get('Transfer Date');
                esl.Payment_Code__c = String.valueOf(parsedData.get('Payment Code'));
            }
            
            if(caseObj.Entity__c == 'AMFS' && ((withdrawalSurrenderCaseType.contains(caseObj.Case_Type__c) && caseObj.Type == REQUEST_POS) || caseObj.Type == COMPLAINT)){
                if(String.isBlank(esl.Email__c) || String.isNotBlank(esl.Mobile__c)) {
                    esl.Method__c = Whatsapp;
                } else if(String.isNotBlank(esl.Email__c) || String.isBlank(esl.Mobile__c)) {
                    esl.Method__c = EMAIL;
				}
            }
            
            insert esl;
            system.debug('**ESL CANCEL ID'+esl.Id);
        }
    }
    
    public void createLogTN(ICFConfig ic, Case caseObj, Contact contactObj, ICF_Parameter__c icfParamObj, String caseType) {
        contactObj = getContactFromCase(caseObj);
        system.debug('contactObj init config: '+contactObj);
        List<Email_SMS_Log__c> eslListEx = [SELECT Id FROM Email_SMS_Log__c WHERE Category__c = :THANKS_NOTE 
                                            AND Contact__c = :contactObj.Id AND Case_Number__c = :caseObj.CaseNumber 
                                            AND Request_Date__c <= :ic.pendingDateTn LIMIT 1];
        if (eslListEx.size() == 0) {
            String emailValue = getEmailValueFromContact(contactObj, ic.emailValue);
            
            Email_SMS_Log__c esl = new Email_SMS_Log__c();
            esl.OwnerId = UserInfo.getUserId();
            esl.Account__c = caseObj.AccountId;
            esl.Case__c = caseObj.Id;
            esl.Category__c = THANKS_NOTE;
            esl.Contact__c = contactObj.Id;
            esl.Email_SMS_Template__c = ic.method == EMAIL ? 
                (esl.Category__c.equals(ICF) ? ic.icfEmailTemplate : ic.tnEmailTemplate) 
                : (esl.Category__c.equals(ICF) ? ic.icfSmsTemplate : ic.tnSmsTemplate);
            esl.Email__c = ic.caseServiceType.equals(AGENT) ? contactObj.Agent_Email__c : emailValue;
            esl.Entity__c = caseObj.Entity__c;
            esl.Method__c = String.isBlank(esl.Email__c) ? SMS : ic.method;
            //esl.Method__c = ic.method;
            esl.Mobile__c = contactObj.MobilePhone;
            esl.Request_Date__c = ic.pendingDateTn;
            esl.Send_Flag__c = true;
            esl.Start_Date__c = ic.pendingDateTn;
            esl.Status__c = DRAFT;
            esl.Survey_Type__c = THANKS_NOTE;
            esl.Type__c = CCC;
            esl.Case_List__c = caseObj.CaseNumber;
            esl.Template_Email__c = esl.Category__c.equals(ICF) ? ic.icfEmailTemplate : ic.tnEmailTemplate;
            esl.Template_SMS__c = esl.Category__c.equals(ICF) ? ic.icfSmsTemplate : ic.tnSmsTemplate;
            esl.Department_Owner__c = THANKS_NOTE;
            esl.Topic__c = THANKS_NOTE;
            
            insert esl;
        }
    }
    
    public void createLogTNCancel(ICFConfig ic, Case caseObj, Contact contactObj, ICF_Parameter__c icfParamObj, String caseType, String excludeFrom, String excludeDesc) {
        List<Email_SMS_Log__c> eslListEx = [SELECT Id FROM Email_SMS_Log__c WHERE Category__c = :THANKS_NOTE 
                                            AND Contact__c = :contactObj.Id AND Case_Number__c = :caseObj.CaseNumber 
                                            AND Request_Date__c <= :ic.pendingDateTn LIMIT 1];
        if (eslListEx.size() == 0) {
            String emailValue = getEmailValueFromContact(contactObj, ic.emailValue);
            
            Email_SMS_Log__c esl = new Email_SMS_Log__c();
            esl.OwnerId = UserInfo.getUserId();
            esl.Account__c = caseObj.AccountId;
            esl.Case__c = caseObj.Id;
            esl.Category__c = THANKS_NOTE;
            esl.Contact__c = contactObj.Id;
            esl.Email_SMS_Template__c = ic.method == EMAIL ? 
                (esl.Category__c.equals(ICF) ? ic.icfEmailTemplate : ic.tnEmailTemplate) 
                : (esl.Category__c.equals(ICF) ? ic.icfSmsTemplate : ic.tnSmsTemplate);
            esl.Email__c = ic.caseServiceType.equals(AGENT) ? contactObj.Agent_Email__c : emailValue;
            esl.Entity__c = caseObj.Entity__c;
            esl.Method__c = String.isBlank(esl.Email__c) ? SMS : ic.method;
            //esl.Method__c = ic.method;
            esl.Mobile__c = contactObj.MobilePhone;
            esl.Request_Date__c = ic.pendingDateTn;
            esl.Send_Flag__c = true;
            esl.Start_Date__c = ic.pendingDateTn;
            esl.Status__c = CANCEL;
            esl.Description__c = excludeDesc;
            esl.Exclude_From__c = excludeFrom;
            esl.Survey_Type__c = THANKS_NOTE;
            esl.Type__c = CCC;
            esl.Case_List__c = caseObj.CaseNumber;
            esl.Template_Email__c = esl.Category__c.equals(ICF) ? ic.icfEmailTemplate : ic.tnEmailTemplate;
            esl.Template_SMS__c = esl.Category__c.equals(ICF) ? ic.icfSmsTemplate : ic.tnSmsTemplate;
            esl.Department_Owner__c = THANKS_NOTE;
            esl.Topic__c = THANKS_NOTE;
            
            insert esl;
        }
    }
    
    public static Map<String, Object> parseDescriptionWithdrawalSurrender(String description) {
        Map<String, Object> extractedValues = new Map<String, Object>();

        // Split description by ' / ' to separate key-value pairs
        List<String> parts = description.split(' / ');

        for (String part : parts) {
            List<String> keyValue = part.split(': '); // Split each pair by ': '
            if (keyValue.size() == 2) {
                String key = keyValue[0].trim();
                String value = keyValue[1].trim();

                // Convert 'Transfer Date' from String to Date
                if (key == 'Transfer Date') {
                    try {
                        List<String> dateParts = value.split('-');
                        if (dateParts.size() == 3) {
                            String formattedDate = dateParts[2] + '-' + dateParts[1] + '-' + dateParts[0]; // Convert to yyyy-MM-dd
                            Date transferDate = Date.valueOf(formattedDate); // Convert String to Date
                            extractedValues.put(key, transferDate);
                        }
                    } catch (Exception e) {
                        System.debug('Error parsing date: ' + e.getMessage());
                    }
                } else {
                    extractedValues.put(key, value);
                }
            }
        }

        return extractedValues;
    }
    
    String	a1	= ''	;
    String	a2	= ''	;
    String	a3	= ''	;
    String	a4	= ''	;
    String	a5	= ''	;
    String	a6	= ''	;
    String	a7	= ''	;
    String	a8	= ''	;
    String	a9	= ''	;
    String	a10	= ''	;
    String	a11	= ''	;
    String	a12	= ''	;
    String	a13	= ''	;
    String	a14	= ''	;
    String	a15	= ''	;
    String	a16	= ''	;
    String	a17	= ''	;
    String	a18	= ''	;
    String	a19	= ''	;
    String	a20	= ''	;
    String	a21	= ''	;
    String	a22	= ''	;
    String	a23	= ''	;
    String	a24	= ''	;
    String	a25	= ''	;
    String	a26	= ''	;
    String	a27	= ''	;
    String	a28	= ''	;
    String	a29	= ''	;
    String	a30	= ''	;
    String	a31	= ''	;
    String	a32	= ''	;
    String	a33	= ''	;
    String	a34	= ''	;
    String	a35	= ''	;
    String	a36	= ''	;
    String	a37	= ''	;
    String	a38	= ''	;
    String	a39	= ''	;
    String	a40	= ''	;
    String	a41	= ''	;
    String	a42	= ''	;
    String	a43	= ''	;
    String	a44	= ''	;
    String	a45	= ''	;
    String	a46	= ''	;
    String	a47	= ''	;
    String	a48	= ''	;
    String	a49	= ''	;
    String	a50	= ''	;
    String	a51	= ''	;
    String	a52	= ''	;
    String	a53	= ''	;
    String	a54	= ''	;
    String	a55	= ''	;
    String	a56	= ''	;
    String	a57	= ''	;
    String	a58	= ''	;
    String	a59	= ''	;
    String	a60	= ''	;
    String	a61	= ''	;
    String	a62	= ''	;
    String	a63	= ''	;
    String	a64	= ''	;
    String	a65	= ''	;
    String	a66	= ''	;
    String	a67	= ''	;
    String	a68	= ''	;
    String	a69	= ''	;
    String	a70	= ''	;
    String	a71	= ''	;
    String	a72	= ''	;
    String	a73	= ''	;
    String	a74	= ''	;
    String	a75	= ''	;
    String	a76	= ''	;
    String	a77	= ''	;
    String	a78	= ''	;
    String	a79	= ''	;
    String	a80	= ''	;
    String	a81	= ''	;
    String	a82	= ''	;
    String	a83	= ''	;
    String	a84	= ''	;
    String	a85	= ''	;
    String	a86	= ''	;
    String	a87	= ''	;
    String	a88	= ''	;
    String	a89	= ''	;
    String	a90	= ''	;
    String	a91	= ''	;
    String	a92	= ''	;
    String	a93	= ''	;
    String	a94	= ''	;
    String	a95	= ''	;
    String	a96	= ''	;
    String	a97	= ''	;
    String	a98	= ''	;
    String	a99	= ''	;
    String	a100	= ''	;
    String	a101	= ''	;
    String	a102	= ''	;
    String	a103	= ''	;
    String	a104	= ''	;
    String	a105	= ''	;
    String	a106	= ''	;
    String	a107	= ''	;
    String	a108	= ''	;
    String	a109	= ''	;
    String	a110	= ''	;
    String	a111	= ''	;
    String	a112	= ''	;
    String	a113	= ''	;
    String	a114	= ''	;
    String	a115	= ''	;
    String	a116	= ''	;
    String	a117	= ''	;
    String	a118	= ''	;
    String	a119	= ''	;
    String	a120	= ''	;
    String	a121	= ''	;
    String	a122	= ''	;
    String	a123	= ''	;
    String	a124	= ''	;
    String	a125	= ''	;
    String	a126	= ''	;
    String	a127	= ''	;
    String	a128	= ''	;
    String	a129	= ''	;
    String	a130	= ''	;
    String	a131	= ''	;
    String	a132	= ''	;
    String	a133	= ''	;
    String	a134	= ''	;
    String	a135	= ''	;
    String	a136	= ''	;
    String	a137	= ''	;
    String	a138	= ''	;
    String	a139	= ''	;
    String	a140	= ''	;
    String	a141	= ''	;
    String	a142	= ''	;
    String	a143	= ''	;
    String	a144	= ''	;
    String	a145	= ''	;
    String	a146	= ''	;
    String	a147	= ''	;
    String	a148	= ''	;
    String	a149	= ''	;
    String	a150	= ''	;
    String	a151	= ''	;
    String	a152	= ''	;
    String	a153	= ''	;
    String	a154	= ''	;
    String	a155	= ''	;
    String	a156	= ''	;
    String	a157	= ''	;
    String	a158	= ''	;
    String	a159	= ''	;
    String	a160	= ''	;
    String	a161	= ''	;
    String	a162	= ''	;
    String	a163	= ''	;
    String	a164	= ''	;
    String	a165	= ''	;
    String	a166	= ''	;
    String	a167	= ''	;
    String	a168	= ''	;
    String	a169	= ''	;
    String	a170	= ''	;
    String	a171	= ''	;
    String	a172	= ''	;
    String	a173	= ''	;
    String	a174	= ''	;
    String	a175	= ''	;
    String	a176	= ''	;
    String	a177	= ''	;
    String	a178	= ''	;
    String	a179	= ''	;
    String	a180	= ''	;
    String	a181	= ''	;
    String	a182	= ''	;
    String	a183	= ''	;
    String	a184	= ''	;
    String	a185	= ''	;
    String	a186	= ''	;
    String	a187	= ''	;
    String	a188	= ''	;
    String	a189	= ''	;
    String	a190	= ''	;
    String	a191	= ''	;
    String	a192	= ''	;
    String	a193	= ''	;
    String	a194	= ''	;
    String	a195	= ''	;
    String	a196	= ''	;
    String	a197	= ''	;
    String	a198	= ''	;
    String	a199	= ''	;
    String	a200	= ''	;
    String	a201	= ''	;
    String	a202	= ''	;
    String	a203	= ''	;
    String	a204	= ''	;
    String	a205	= ''	;
    String	a206	= ''	;
    String	a207	= ''	;
    String	a208	= ''	;
    String	a209	= ''	;
    String	a210	= ''	;
    String	a211	= ''	;
    String	a212	= ''	;
    String	a213	= ''	;
    String	a214	= ''	;
    String	a215	= ''	;
    String	a216	= ''	;
    String	a217	= ''	;
    String	a218	= ''	;
    String	a219	= ''	;
    String	a220	= ''	;
    String	a221	= ''	;
    String	a222	= ''	;
    String	a223	= ''	;
    String	a224	= ''	;
    String	a225	= ''	;
    String	a226	= ''	;
    String	a227	= ''	;
    String	a228	= ''	;
    String	a229	= ''	;
    String	a230	= ''	;
    String	a231	= ''	;
    String	a232	= ''	;
    String	a233	= ''	;
    String	a234	= ''	;
    String	a235	= ''	;
    String	a236	= ''	;
    String	a237	= ''	;
    String	a238	= ''	;
    String	a239	= ''	;
    String	a240	= ''	;
    String	a241	= ''	;
    String	a242	= ''	;
    String	a243	= ''	;
    String	a244	= ''	;
    String	a245	= ''	;
    String	a246	= ''	;
    String	a247	= ''	;
    String	a248	= ''	;
    String	a249	= ''	;
    String	a250	= ''	;
    String	a251	= ''	;
    String	a252	= ''	;
    String	a253	= ''	;
    String	a254	= ''	;
    String	a255	= ''	;
    String	a256	= ''	;
    String	a257	= ''	;
    String	a258	= ''	;
    String	a259	= ''	;
    String	a260	= ''	;
    String	a261	= ''	;
    String	a262	= ''	;
    String	a263	= ''	;
    String	a264	= ''	;
    String	a265	= ''	;
    String	a266	= ''	;
    String	a267	= ''	;
    String	a268	= ''	;
    String	a269	= ''	;
    String	a270	= ''	;
    String	a271	= ''	;
    String	a272	= ''	;
    String	a273	= ''	;
    String	a274	= ''	;
    String	a275	= ''	;
    String	a276	= ''	;
    String	a277	= ''	;
    String	a278	= ''	;
    String	a279	= ''	;
    String	a280	= ''	;
    String	a281	= ''	;
    String	a282	= ''	;
    String	a283	= ''	;
    String	a284	= ''	;
    String	a285	= ''	;
    String	a286	= ''	;
    String	a287	= ''	;
    String	a288	= ''	;
    String	a289	= ''	;
    String	a290	= ''	;
    String	a291	= ''	;
    String	a292	= ''	;
    String	a293	= ''	;
    String	a294	= ''	;
    String	a295	= ''	;
    String	a296	= ''	;
    String	a297	= ''	;
    String	a298	= ''	;
    String	a299	= ''	;
    String	a300	= ''	;
    String	a301	= ''	;
    String	a302	= ''	;
    String	a303	= ''	;
    String	a304	= ''	;
    String	a305	= ''	;
    String	a306	= ''	;
    String	a307	= ''	;
    String	a308	= ''	;
    String	a309	= ''	;
    String	a310	= ''	;
    String	a311	= ''	;
    String	a312	= ''	;
    String	a313	= ''	;
    String	a314	= ''	;
    String	a315	= ''	;
    String	a316	= ''	;
    String	a317	= ''	;
    String	a318	= ''	;
    String	a319	= ''	;
    String	a320	= ''	;
    String	a321	= ''	;
    String	a322	= ''	;
    String	a323	= ''	;
    String	a324	= ''	;
    String	a325	= ''	;
    String	a326	= ''	;
    String	a327	= ''	;
    String	a328	= ''	;
    String	a329	= ''	;
    String	a330	= ''	;
    String	a331	= ''	;
    String	a332	= ''	;
    String	a333	= ''	;
    String	a334	= ''	;
    String	a335	= ''	;
    String	a336	= ''	;
    String	a337	= ''	;
    String	a338	= ''	;
    String	a339	= ''	;
    String	a340	= ''	;
    String	a341	= ''	;
    String	a342	= ''	;
    String	a343	= ''	;
    String	a344	= ''	;
    String	a345	= ''	;
    String	a346	= ''	;
    String	a347	= ''	;
    String	a348	= ''	;
    String	a349	= ''	;
    String	a350	= ''	;
    String	a351	= ''	;
    String	a352	= ''	;
    String	a353	= ''	;
    String	a354	= ''	;
    String	a355	= ''	;
    String	a356	= ''	;
    String	a357	= ''	;
    String	a358	= ''	;
    String	a359	= ''	;
    String	a360	= ''	;
    String	a361	= ''	;
    String	a362	= ''	;
    String	a363	= ''	;
    String	a364	= ''	;
    String	a365	= ''	;
    String	a366	= ''	;
    String	a367	= ''	;
    String	a368	= ''	;
    String	a369	= ''	;
    String	a370	= ''	;
    String	a371	= ''	;
    String	a372	= ''	;
    String	a373	= ''	;
    String	a374	= ''	;
    String	a375	= ''	;
    String	a376	= ''	;
    String	a377	= ''	;
    String	a378	= ''	;
    String	a379	= ''	;
    String	a380	= ''	;
    String	a381	= ''	;
    String	a382	= ''	;
    String	a383	= ''	;
    String	a384	= ''	;
    String	a385	= ''	;
    String	a386	= ''	;
    String	a387	= ''	;
    String	a388	= ''	;
    String	a389	= ''	;
    String	a390	= ''	;
    String	a391	= ''	;
    String	a392	= ''	;
    String	a393	= ''	;
    String	a394	= ''	;
    String	a395	= ''	;
    String	a396	= ''	;
    String	a397	= ''	;
    String	a398	= ''	;
    String	a399	= ''	;
    String	a400	= ''	;
    String	a401	= ''	;
    String	a402	= ''	;
    String	a403	= ''	;
    String	a404	= ''	;
    String	a405	= ''	;
    String	a406	= ''	;
    String	a407	= ''	;
    String	a408	= ''	;
    String	a409	= ''	;
    String	a410	= ''	;
    String	a411	= ''	;
    String	a412	= ''	;
    String	a413	= ''	;
    String	a414	= ''	;
    String	a415	= ''	;
    String	a416	= ''	;
    String	a417	= ''	;
    String	a418	= ''	;
    String	a419	= ''	;
    String	a420	= ''	;
    String	a421	= ''	;
    String	a422	= ''	;
    String	a423	= ''	;
    String	a424	= ''	;
    String	a425	= ''	;
    String	a426	= ''	;
    String	a427	= ''	;
    String	a428	= ''	;
    String	a429	= ''	;
    String	a430	= ''	;
    String	a431	= ''	;
    String	a432	= ''	;
    String	a433	= ''	;
    String	a434	= ''	;
    String	a435	= ''	;
    String	a436	= ''	;
    String	a437	= ''	;
    String	a438	= ''	;
    String	a439	= ''	;
    String	a440	= ''	;
    String	a441	= ''	;
    String	a442	= ''	;
    String	a443	= ''	;
    String	a444	= ''	;
    String	a445	= ''	;
    String	a446	= ''	;
    String	a447	= ''	;
    String	a448	= ''	;
    String	a449	= ''	;
    String	a450	= ''	;
    String	a451	= ''	;
    String	a452	= ''	;
    String	a453	= ''	;
    String	a454	= ''	;
    String	a455	= ''	;
    String	a456	= ''	;
    String	a457	= ''	;
    String	a458	= ''	;
    String	a459	= ''	;
    String	a460	= ''	;
    String	a461	= ''	;
    String	a462	= ''	;
    String	a463	= ''	;
    String	a464	= ''	;
    String	a465	= ''	;
    String	a466	= ''	;
    String	a467	= ''	;
    String	a468	= ''	;
    String	a469	= ''	;
    String	a470	= ''	;
    String	a471	= ''	;
    String	a472	= ''	;
    String	a473	= ''	;
    String	a474	= ''	;
    String	a475	= ''	;
    String	a476	= ''	;
    String	a477	= ''	;
    String	a478	= ''	;
    String	a479	= ''	;
    String	a480	= ''	;
    String	a481	= ''	;
    String	a482	= ''	;
    String	a483	= ''	;
    String	a484	= ''	;
    String	a485	= ''	;
    String	a486	= ''	;
    String	a487	= ''	;
    String	a488	= ''	;
    String	a489	= ''	;
    String	a490	= ''	;
    String	a491	= ''	;
    String	a492	= ''	;
    String	a493	= ''	;
    String	a494	= ''	;
    String	a495	= ''	;
    String	a496	= ''	;
    String	a497	= ''	;
    String	a498	= ''	;
    String	a499	= ''	;
    String	a500	= ''	;
    String	a501	= ''	;
    String	a502	= ''	;
    String	a503	= ''	;
    String	a504	= ''	;
    String	a505	= ''	;
    String	a506	= ''	;
    String	a507	= ''	;
    String	a508	= ''	;
    String	a509	= ''	;
    String	a510	= ''	;
    String	a511	= ''	;
    String	a512	= ''	;
    String	a513	= ''	;
    String	a514	= ''	;
    String	a515	= ''	;
    String	a516	= ''	;
    String	a517	= ''	;
    String	a518	= ''	;
    String	a519	= ''	;
    String	a520	= ''	;
    String	a521	= ''	;
    String	a522	= ''	;
    String	a523	= ''	;
    String	a524	= ''	;
    String	a525	= ''	;
    String	a526	= ''	;
    String	a527	= ''	;
    String	a528	= ''	;
    String	a529	= ''	;
    String	a530	= ''	;
    String	a531	= ''	;
    String	a532	= ''	;
    String	a533	= ''	;
    String	a534	= ''	;
    String	a535	= ''	;
    String	a536	= ''	;
    String	a537	= ''	;
    String	a538	= ''	;
    String	a539	= ''	;
    String	a540	= ''	;
    String	a541	= ''	;
    String	a542	= ''	;
    String	a543	= ''	;
    String	a544	= ''	;
    String	a545	= ''	;
    String	a546	= ''	;
    String	a547	= ''	;
    String	a548	= ''	;
    String	a549	= ''	;
    String	a550	= ''	;
    String	a551	= ''	;
    String	a552	= ''	;
    String	a553	= ''	;
    String	a554	= ''	;
    String	a555	= ''	;
    String	a556	= ''	;
    String	a557	= ''	;
    String	a558	= ''	;
    String	a559	= ''	;
    String	a560	= ''	;
    String	a561	= ''	;
    String	a562	= ''	;
    String	a563	= ''	;
    String	a564	= ''	;
    String	a565	= ''	;
    String	a566	= ''	;
    String	a567	= ''	;
    String	a568	= ''	;
    String	a569	= ''	;
    String	a570	= ''	;
    String	a571	= ''	;
    String	a572	= ''	;
    String	a573	= ''	;
    String	a574	= ''	;
    String	a575	= ''	;
    String	a576	= ''	;
    String	a577	= ''	;
    String	a578	= ''	;
    String	a579	= ''	;
    String	a580	= ''	;
    String	a581	= ''	;
    String	a582	= ''	;
    String	a583	= ''	;
    String	a584	= ''	;
    String	a585	= ''	;
    String	a586	= ''	;
    String	a587	= ''	;
    String	a588	= ''	;
    String	a589	= ''	;
    String	a590	= ''	;
    String	a591	= ''	;
    String	a592	= ''	;
    String	a593	= ''	;
    String	a594	= ''	;
    String	a595	= ''	;
    String	a596	= ''	;
    String	a597	= ''	;
    String	a598	= ''	;
    String	a599	= ''	;
    String	a600	= ''	;
    String	a601	= ''	;
    String	a602	= ''	;
    String	a603	= ''	;
    String	a604	= ''	;
    String	a605	= ''	;
    String	a606	= ''	;
    String	a607	= ''	;
    String	a608	= ''	;
    String	a609	= ''	;
    String	a610	= ''	;
    String	a611	= ''	;
    String	a612	= ''	;
    String	a613	= ''	;
    String	a614	= ''	;
    String	a615	= ''	;
    String	a616	= ''	;
    String	a617	= ''	;
    String	a618	= ''	;
    String	a619	= ''	;
    String	a620	= ''	;
    String	a621	= ''	;
    String	a622	= ''	;
    String	a623	= ''	;
    String	a624	= ''	;
    String	a625	= ''	;
    String	a626	= ''	;
    String	a627	= ''	;
    String	a628	= ''	;
    String	a629	= ''	;
    String	a630	= ''	;
    String	a631	= ''	;
    String	a632	= ''	;
    String	a633	= ''	;
    String	a634	= ''	;
    String	a635	= ''	;
    String	a636	= ''	;
    String	a637	= ''	;
    String	a638	= ''	;
    String	a639	= ''	;
    String	a640	= ''	;
    String	a641	= ''	;
    String	a642	= ''	;
    String	a643	= ''	;
    String	a644	= ''	;
    String	a645	= ''	;
    String	a646	= ''	;
    String	a647	= ''	;
    String	a648	= ''	;
    String	a649	= ''	;
    String	a650	= ''	;
    String	a651	= ''	;
    String	a652	= ''	;
    String	a653	= ''	;
    String	a654	= ''	;
    String	a655	= ''	;
    String	a656	= ''	;
    String	a657	= ''	;
    String	a658	= ''	;
    String	a659	= ''	;
    String	a660	= ''	;
    String	a661	= ''	;
    String	a662	= ''	;
    String	a663	= ''	;
    String	a664	= ''	;
    String	a665	= ''	;
    String	a666	= ''	;
    String	a667	= ''	;
    String	a668	= ''	;
    String	a669	= ''	;
    String	a670	= ''	;
    String	a671	= ''	;
    String	a672	= ''	;
    String	a673	= ''	;
    String	a674	= ''	;
    String	a675	= ''	;
    String	a676	= ''	;
    String	a677	= ''	;
    String	a678	= ''	;
    String	a679	= ''	;
    String	a680	= ''	;
    String	a681	= ''	;
    String	a682	= ''	;
    String	a683	= ''	;
    String	a684	= ''	;
    String	a685	= ''	;
    String	a686	= ''	;
    String	a687	= ''	;
    String	a688	= ''	;
    String	a689	= ''	;
    String	a690	= ''	;
    String	a691	= ''	;
    String	a692	= ''	;
    String	a693	= ''	;
    String	a694	= ''	;
    String	a695	= ''	;
    String	a696	= ''	;
    String	a697	= ''	;
    String	a698	= ''	;
    String	a699	= ''	;
    String	a700	= ''	;
    String	a701	= ''	;
    String	a702	= ''	;
    String	a703	= ''	;
    String	a704	= ''	;
    String	a705	= ''	;
    String	a706	= ''	;
    String	a707	= ''	;
    String	a708	= ''	;
    String	a709	= ''	;
    String	a710	= ''	;
    String	a711	= ''	;
    String	a712	= ''	;
    String	a713	= ''	;
    String	a714	= ''	;
    String	a715	= ''	;
    String	a716	= ''	;
    String	a717	= ''	;
    String	a718	= ''	;
    String	a719	= ''	;
    String	a720	= ''	;
    String	a721	= ''	;
    String	a722	= ''	;
    String	a723	= ''	;
    String	a724	= ''	;
    String	a725	= ''	;
    String	a726	= ''	;
    String	a727	= ''	;
    String	a728	= ''	;
    String	a729	= ''	;
    String	a730	= ''	;
    String	a731	= ''	;
    String	a732	= ''	;
    String	a733	= ''	;
    String	a734	= ''	;
    String	a735	= ''	;
    String	a736	= ''	;
    String	a737	= ''	;
    String	a738	= ''	;
    String	a739	= ''	;
    String	a740	= ''	;
    String	a741	= ''	;
    String	a742	= ''	;
    String	a743	= ''	;
    String	a744	= ''	;
    String	a745	= ''	;
    String	a746	= ''	;
    String	a747	= ''	;
    String	a748	= ''	;
    String	a749	= ''	;
    String	a750	= ''	;
    String	a751	= ''	;
    String	a752	= ''	;
    String	a753	= ''	;
    String	a754	= ''	;
    String	a755	= ''	;
    String	a756	= ''	;
    String	a757	= ''	;
    String	a758	= ''	;
    String	a759	= ''	;
    String	a760	= ''	;
    String	a761	= ''	;
    String	a762	= ''	;
    String	a763	= ''	;
    String	a764	= ''	;
    String	a765	= ''	;
    String	a766	= ''	;
    String	a767	= ''	;
    String	a768	= ''	;
    String	a769	= ''	;
    String	a770	= ''	;
    String	a771	= ''	;
    String	a772	= ''	;
    String	a773	= ''	;
    String	a774	= ''	;
    String	a775	= ''	;
    String	a776	= ''	;
    String	a777	= ''	;
    String	a778	= ''	;
    String	a779	= ''	;
    String	a780	= ''	;
    String	a781	= ''	;
    String	a782	= ''	;
    String	a783	= ''	;
    String	a784	= ''	;
    String	a785	= ''	;
    String	a786	= ''	;
    String	a787	= ''	;
    String	a788	= ''	;
    String	a789	= ''	;
    String	a790	= ''	;
    String	a791	= ''	;
    String	a792	= ''	;
    String	a793	= ''	;
    String	a794	= ''	;
    String	a795	= ''	;
    String	a796	= ''	;
    String	a797	= ''	;
    String	a798	= ''	;
    String	a799	= ''	;
    String	a800	= ''	;
    String	a801	= ''	;
    String	a802	= ''	;
    String	a803	= ''	;
    String	a804	= ''	;
    String	a805	= ''	;
    String	a806	= ''	;
    String	a807	= ''	;
    String	a808	= ''	;
    String	a809	= ''	;
    String	a810	= ''	;
    String	a811	= ''	;
    String	a812	= ''	;
    String	a813	= ''	;
    String	a814	= ''	;
    String	a815	= ''	;
    String	a816	= ''	;
    String	a817	= ''	;
    String	a818	= ''	;
    String	a819	= ''	;
    String	a820	= ''	;
    String	a821	= ''	;
    String	a822	= ''	;
    String	a823	= ''	;
    String	a824	= ''	;
    String	a825	= ''	;
    String	a826	= ''	;
    String	a827	= ''	;
    String	a828	= ''	;
    String	a829	= ''	;
    String	a830	= ''	;
    String	a831	= ''	;
    String	a832	= ''	;
    String	a833	= ''	;
    String	a834	= ''	;
    String	a835	= ''	;
    String	a836	= ''	;
    String	a837	= ''	;
    String	a838	= ''	;
    String	a839	= ''	;
    String	a840	= ''	;
    String	a841	= ''	;
    String	a842	= ''	;
    String	a843	= ''	;
    String	a844	= ''	;
    String	a845	= ''	;
    String	a846	= ''	;
    String	a847	= ''	;
    String	a848	= ''	;
    String	a849	= ''	;
    String	a850	= ''	;
    String	a851	= ''	;
    String	a852	= ''	;
    String	a853	= ''	;
    String	a854	= ''	;
    String	a855	= ''	;
    String	a856	= ''	;
    String	a857	= ''	;
    String	a858	= ''	;
    String	a859	= ''	;
    String	a860	= ''	;
    String	a861	= ''	;
    String	a862	= ''	;
    String	a863	= ''	;
    String	a864	= ''	;
    String	a865	= ''	;
    String	a866	= ''	;
    String	a867	= ''	;
    String	a868	= ''	;
    String	a869	= ''	;
    String	a870	= ''	;
    String	a871	= ''	;
    String	a872	= ''	;
    String	a873	= ''	;
    String	a874	= ''	;
    String	a875	= ''	;
    String	a876	= ''	;
    String	a877	= ''	;
    String	a878	= ''	;
    String	a879	= ''	;
    String	a880	= ''	;
    String	a881	= ''	;
    String	a882	= ''	;
    String	a883	= ''	;
    String	a884	= ''	;
    String	a885	= ''	;
    String	a886	= ''	;
    String	a887	= ''	;
    String	a888	= ''	;
    String	a889	= ''	;
    String	a890	= ''	;
    String	a891	= ''	;
    String	a892	= ''	;
    String	a893	= ''	;
    String	a894	= ''	;
    String	a895	= ''	;
    String	a896	= ''	;
    String	a897	= ''	;
    String	a898	= ''	;
    String	a899	= ''	;
    String	a900	= ''	;
    String	a901	= ''	;
    String	a902	= ''	;
    String	a903	= ''	;
    String	a904	= ''	;
    String	a905	= ''	;
    String	a906	= ''	;
    String	a907	= ''	;
    String	a908	= ''	;
    String	a909	= ''	;
    String	a910	= ''	;
    String	a911	= ''	;
    String	a912	= ''	;
    String	a913	= ''	;
    String	a914	= ''	;
    String	a915	= ''	;
    String	a916	= ''	;
    String	a917	= ''	;
    String	a918	= ''	;
    String	a919	= ''	;
    String	a920	= ''	;
    String	a921	= ''	;
    String	a922	= ''	;
    String	a923	= ''	;
    String	a924	= ''	;
    String	a925	= ''	;
    String	a926	= ''	;
    String	a927	= ''	;
    String	a928	= ''	;
    String	a929	= ''	;
    String	a930	= ''	;
    String	a931	= ''	;
    String	a932	= ''	;
    String	a933	= ''	;
    String	a934	= ''	;
    String	a935	= ''	;
    String	a936	= ''	;
    String	a937	= ''	;
    String	a938	= ''	;
    String	a939	= ''	;
    String	a940	= ''	;
    String	a941	= ''	;
    String	a942	= ''	;
    String	a943	= ''	;
    String	a944	= ''	;
    String	a945	= ''	;
    String	a946	= ''	;
    String	a947	= ''	;
    String	a948	= ''	;
    String	a949	= ''	;
    String	a950	= ''	;
    String	a951	= ''	;
    String	a952	= ''	;
    String	a953	= ''	;
    String	a954	= ''	;
    String	a955	= ''	;
    String	a956	= ''	;
    String	a957	= ''	;
    String	a958	= ''	;
    String	a959	= ''	;
    String	a960	= ''	;
    String	a961	= ''	;
    String	a962	= ''	;
    String	a963	= ''	;
    String	a964	= ''	;
    String	a965	= ''	;
    String	a966	= ''	;
    String	a967	= ''	;
    String	a968	= ''	;
    String	a969	= ''	;
    String	a970	= ''	;
    String	a971	= ''	;
    String	a972	= ''	;
    String	a973	= ''	;
    String	a974	= ''	;
    String	a975	= ''	;
    String	a976	= ''	;
    String	a977	= ''	;
    String	a978	= ''	;
    String	a979	= ''	;
    String	a980	= ''	;
    String	a981	= ''	;
    String	a982	= ''	;
    String	a983	= ''	;
    String	a984	= ''	;
    String	a985	= ''	;
    String	a986	= ''	;
    String	a987	= ''	;
    String	a988	= ''	;
    String	a989	= ''	;
    String	a990	= ''	;
    String	a991	= ''	;
    String	a992	= ''	;
    String	a993	= ''	;
    String	a994	= ''	;
    String	a995	= ''	;
    String	a996	= ''	;
    String	a997	= ''	;
    String	a998	= ''	;
    String	a999	= ''	;
    String	a1000	= ''	;
}