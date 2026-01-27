public class EIPConstant {
    public static final String CHANNEL_SALESFORCE = 'Salesforce';
    public static final String MSG_UPDATE_DATA_FROM_SALESFORCE = 'Update data from Salesforce';

    public static final String ERROR_MSG_NODATA = 'Data Not Available';
    public static final String ERROR_MSG_OFFLINE = 'System Offline';
    public static final String ERROR_MSG_CONNECTION_FAIL = 'Connection To Host Failure';
    public static final String ERROR_MSG_STATUS_NOTFOUND = 'Response Status Not Found';
    public static final String ERROR_MSG_UNKNOWN = 'Unknown Error. Please Contact Admin.';
    public static final String ERROR_UNKNOWN_SEARCH_CRIT = 'Unknown Search Criteria';
    public static final String ERROR_INVALID_PHONE_NUM = 'invalid Phone Number';
    
    public static final String SERVICE_GET_POLICY_DETAIL = 'getPolicyDetails';
    public static final String SERVICE_GET_PAYMENT_HISTORY = 'getPaymentHistory';
    public static final String SERVICE_GET_PREMIUM_BREAKDOWN = 'getPremiumBreakdown';
    public static final String SERVICE_GET_BENEF_DETAIL = 'getBeneficiaryDetail';
    public static final String SERVICE_GET_FUND_DETAIL = 'getFundDetail';
    /*Add By Fajar Salam*/
    public static final String SERVICE_GET_CUST_INFO = 'getCustomerInfo';
    public static final String SERVICE_GET_ADD_USER = 'adHocUserCreation';
    public static final String SERVICE_CHECK_USER_ADDHOCK = 'getAdHocUserCreation';
    public static final String SERVICE_LIST_USER_ADDHOCK = 'getListAdHocUserCreation';
    /**/
    
    // ADDED By ELVI
    public static final String SERVICE_RESEND_EMAIL_EMPLOYEE = 'RESEND EMAIL EMPLOYEE';
    // ADDED By ELVI
    public static final String SERVICE_GET_CLAIM_DETAIL = 'getClaimDetails';
    public static final String SERVICE_GET_AGENT_INFO = 'getAgentInfo';
    public static final String SERVICE_GET_FUND_HISTORY = 'getFundHistory';
    public static final String SERVICE_GET_FUNDPRICE_HISTORY = 'getFundPriceHistory';
    public static final String SERVICE_GET_ASS_NOTE = 'getAssNotes';
    public static final String SERVICE_GET_GICLAIM_DETAIL = 'getGIClaimDetail';
    public static final String SERVICE_GET_GIPOLICY_DETAIL = 'getGIPolicyDetail';
    public static final String SERVICE_GET_TOKEN = 'getToken';
    public static final String SERVICE_DO_ORDER = 'doOrder';
    public static final String SERVICE_SEND_COMMUNCATION_MESSAGE = 'sendCommunicationMessage';
    public static final String SERVICE_GET_CUSTOMER_LIST = 'getCustomerList';
    public static final String SERVICE_ADD_CUSTOMER = 'addCustomer';
    public static final String SERVICE_GET_HISTORY_REGISTER = 'getHistoryRegister';
    public static final String SERVICE_CUSTOMER_PROFILE = 'CUSTOMER PROFILE';
    public static final String SERVICE_GET_UW_DATA = 'getUWData';
    public static final String SERVICE_GET_GUEST_INFO = 'getGuestInfo';
    public static final String SERVICE_ADD_POLICY ='addPolicy';
    public static final String SERVICE_STATUS_KARYAWAN ='EMPLOYEE PROFILE';

    
    // add map values to Valid DTTM
    public static final String VALID_FROM_DTTM = 'validFromDttm';
    public static final String VALID_TO_DTTM = 'validToDttm';
    
    public static final String OPERATION_POLICY_DETAIL = 'Policy Details';
    public static final String OPERATION_INSURED_DETAIL = 'Insured Details';
    public static final String OPERATION_CASH_VALUE = 'Cash Value';
    public static final String OPERATION_POLICY_CHANGE = 'Policy Change';
    public static final String OPERATION_APP_DETAIL = 'Application Detail';
    public static final String OPERATION_PAYMENT = 'Payment';
    public static final String OPERATION_PREMIUM_BREAKDOWN = 'Premium breakdown';
    public static final String OPERATION_BENEFICIARY = 'Beneficiary';
    public static final String OPERATION_FUND = 'Fund';
    public static final String OPERATION_ACCOUNT_DETAIL = 'Account Detail';
    public static final String OPERATION_CUST_PROFILE = 'Customer Profile';
    public static final String OPERATION_CLAIM = 'Claim';
    public static final String OPERATION_DMTMALI = 'DMTMALI';
    public static final String OPERATION_AGENT_INFO = 'Agent Info';
    public static final String OPERATION_REPORTSTRUCTURE_HIERARCHY = 'Reporting structure hierarchy';
    public static final String OPERATION_TOPDOWN_HIERARCHY = 'Top down hierarchy';
    public static final String OPERATION_SUMMARY = 'Summary';
    public static final String OPERATION_DETAIL = 'Detail';
    public static final String OPERATION_NOTIF_REMARK = 'Notification Remarks';
    public static final String OPERATION_REGISTER = 'Register';
    public static final String OPERATION_V_TOKEN = 'VToken';
    public static final String OPERATION_VSNAP_TOKEN = 'VSNAPToken';
    public static final String OPERATION_PGP_TOKEN = 'PGPToken';
    public static final String OPERATION_PGPDEBIT_TOKEN = 'PGPDebitToken';
    public static final String OPERATION_STATUS = 'status';
    public static final String OPERATION_RISK_DETAIL = 'Risk Detail';
    public static final String OPERATION_SUBMIT_DATA = 'submitData';
    public static final String OPERATION_QUEUE_RELEASER = 'Queue Releaser';
	public static final String OPERATION_LOAN_HISTORY = 'getLoanHistory';
    public static final String OPERATION_ADMIN_FEE = 'getAdminFee';
    public static final String OPERATION_RESET_PASSWORD_PAGE = 'resetPasswordPage';
    public static final String OPERATION_VALIDATE_SESSION_ID = 'validateSessionId';
    public static final String OPERATION_RESET_PASSWORD_PROC = 'resetPasswordProccess';
    public static final String OPERATION_BLOCK = 'block';
    public static final String OPERATION_UNBLOCK = 'unblock';
    public static final String OPERATION_REACTIVATION = 'reactivation';
    public static final String OPERATION_UPDATE = 'update';
    public static final String OPERATION_GET_POS_TRANSACTION = 'getPOSTransaction';
    public static final String OPERATION_SEARCH_PERSONAL = 'searchPersonal';
    public static final String OPERATION_RETRIEVE_CUSTOMER = 'retrieve customer';
    public static final String OPERATION_GET_ACCOUNT_DETAIL = 'getAccountDetail';
    public static final String OPERATION_SEND_WHATSAPP = 'sendWA';
    public static final String OPERATION_DUKCAPIL_DIRECT_VERIFICATION = 'Direct Verification';
    public static final String OPERATION_REQUEST_INQUIRY = 'get transaction status';
    public static final String OPERATION_INSERT_CALLNOTE = 'insert call notes';
    public static final String OPERATION_INSERT_CONSERVATION = 'conservation';
    public static final String OPERATION_UPLOAD_IMAGE= 'upload image';
    public static final String OPERATION_SUBMIT_METADATA= 'submit metadata';
    public static final String OPERATION_INSERT_ASSESMENT = 'Insert Assesment Maintenance';
    public static final String OPERATION_CR_REGISTER = 'CR Register Maintenance';
    public static final String OPERATION_GET_CONSERVATION = 'get conservation';

    public static final String ENTITY_AMFS = 'AMFS';
    public static final String ENTITY_AMFS_2 = 'AMFS2';
    public static final String ENTITY_AFI = 'AFI';
    public static final String ENTITY_AGI = 'AGI';
    public static final String ENTITY_ALI = 'ALI';
    public static final String ENTITY_MAGI = 'MAGI';
    
    public static final String APP_RLS ='RLS';
    public static final String APP_RLS_WEB ='RLS_WEB';
    public static final String APP_DMTM ='DMTM';
    public static final String APP_DMTM_REST_V3 = 'DMTM_REST_V3';
    public static final String APP_CLIPPER ='CLIPPER';
    public static final String APP_BIS ='BIS';
    public static final String APP_IDAS ='IDAS';
    public static final String APP_CARE ='CARE';
    public static final String APP_PSEA ='PSEA';
    public static final String APP_G400 ='G400';
    public static final String APP_MIDTRANS ='MIDTRANS';
    public static final String APP_MIDTRANS_2 ='MIDTRANS2';
    public static final String APP_VERITRANS ='VERITRANS';
    public static final String APP_VERITRANS_2 ='VERITRANS2';
    public static final String APP_LINKAJA ='LINKAJA';
    public static final String APP_TOKEN ='TOKENAPPS';
    public static final String APP_CHATBOT = 'CHATBOT';
    public static final String APP_SLS = 'SLS';
    public static final String APP_FULLERTON = 'FULLERTON';
    public static final String APP_EDMU = 'EDMU';
    public static final String APP_JATIS = 'JATIS';
    public static final String APP_DUKCAPIL = 'DUKCAPIL';
    public static final String APP_DIPCAD = 'DIPCAD';
    
     // add map values sourceCInd
    public static final String MDM_ID = 'MDM_ID';
    public static final String POLICY_NO = 'POLICY_NO';
    public static final String PHONE_NO = 'PHONE_NO';
    public static final String NAME_DOB_GENDER = 'NAME_DOB_GENDER';
    public static final String EMAIL = 'EMAIL';
    public static final String ACC_NO = 'ACC_NO';
    public static final String ID_DOC = 'ID_DOC';
   
    public static final String ASSESSMENT_TYPE_POS = 'POS';
    public static final String ASSESSMENT_TYPE_PA = 'PA';
    public static final String ASSESSMENT_TYPE_CLM = 'CLM';
    public static final String ASSESSMENT_TYPE_UW = 'UW';
    public static final String ASSESSMENT_TYPE_OTH = 'OTH';
    
    public static final String STATUS_SUCCESS = '1';
    public static final String STATUS_FAILED = '0';
    public static final String STATUS_SUCCESS_2 = 'success';
    public static final String STATUS_FAILED_2 = 'failed';
    
    public static final String FACT_PERIOD = 'factPeriod';
    public static final String CREDIT_CARD = 'credit_card';
    public static final String CUSTOM_FIELD_1 = 'custom_field1';
    public static final String CUSTOM_FIELD_2 = 'custom_field2';
    public static final String CUSTOM_FIELD_3 = 'custom_field3';
    public static final String SAVE_CARD = 'save_card';
    public static final String SECURE = 'secure';
    public static final String FINISH = 'finish';
    public static final String TRANSACTION_STATUS = 'transaction_status';
    public static final String TRANSACTION_TIME = 'transaction_time';
    public static final String STATUS_CODE = 'status_code';
    public static final String STATUS_MESSAGE = 'status_message';
    public static final String SIGANTURE_KEY = 'signature_key';
    public static final String BANK = 'bank';
    public static final String VA_NUMBER = 'va_number';
    public static final String ORDER_ID = 'order_id';
    public static final String TRANSACTION_ID = 'transaction_id';
    public static final String SAVED_TOKEN_ID = 'saved_token_id';
    public static final String SAVED_TOKEN_ID_EXPIRED_AT = 'saved_token_id_expired_at';
    public static final String GROSS_AMOUNT = 'gross_amount';
    public static final String PAYMENT_TYPE = 'payment_type';
    public static final String MASKED_CARD = 'masked_card';
    public static final String CARD_TYPE = 'card_type';
    
    public static final String PARAM_MSG_SESSION_ID = 'documentID';
    public static final String PARAM_MSG_LOGIN_ID = 'individualUniqueID';
    public static final String PARAM_MSG_PASSWORD = 'individualRK';
    public static final String PARAM_MSG_EMAIL = 'emailAddress';
    public static final String PARAM_MSG_DOB = 'birthDT';
    public static final String PARAM_MSG_CIF = 'socialSecurityNO';
    public static final String PARAM_MSG_CHANNEL = 'preferredChannelCd';
    public static final String PARAM_MSG_LANGUAGE = 'primaryLanguageCd';
    public static final String PARAM_MSG_POLICY = 'policyNO';
    public static final String PARAM_MSG_POLICY_STATUS = 'policyStatusCD';
    public static final String PARAM_MSG_POLICY_VERSION = 'policyVersion';
    public static final String PARAM_MSG_POLICY_DUEDATE = 'policyDueDt';
    public static final String PARAM_MSG_CORESPONDENCE = 'individualAddressRk';
    public static final String PARAM_MSG_PRODUCER = 'producerRk';
    public static final String PARAM_MSG_POLICYRK = 'policyRK';
    public static final String PARAM_MSG_PHONE = 'mobilePhoneNO';
    public static final String PARAM_MSG_PHONE2 = 'mobilePhoneNO2';
    public static final String PARAM_MSG_ACCOUNTNO = 'accountNO';
    public static final String PARAM_MSG_REGISTERED = 'registeredBy';
    public static final String PARAM_MSG_RENEWAL = 'renewalDt';
    public static final String PARAM_MSG_TERMINATION = 'terminationDt';
    public static final String PARAM_MSG_OTHER_IND = 'otherInsuredInd';
    public static final String PARAM_MSG_DTTM = 'processedDttm';
    public static final String PARAM_MSG_UWTYPE = 'uwTypeCd';
    public static final String PARAM_SUBDISTRICT = 'subdistrictNm';
    public static final String PARAM_STATE_REGION = 'stateRegionCd';
    public static final String PARAM_STATUS_REASON = 'statusReasonCd';
    public static final String PARAM_CITY_NM = 'cityNM';
    public static final String PARAM_PROVINCE_NM = 'provinceNm';
    public static final String PARAM_POSTAL_CD = 'postalCD';
    public static final String PARAM_FIRST_NAME = 'firstName';
    public static final String PARAM_LAST_NAME = 'lastName';
    public static final String PARAM_USERNAME = 'username';
    public static final String PARAM_MOBILE_NUMBER = 'mobileNumber';
    public static final String PARAM_UNIQUE_NUMBER = 'uniqueNumber';
    public static final String PARAM_ORDER_BY = 'orderBy';
    public static final String PARAM_ORDER_DIR = 'orderDir';
    public static final String PARAM_PAGE_NUMBER = 'pageNumber';
    public static final String PARAM_ROW_PER_PAGE = 'rowPerPage';
    public static final String PARAM_SOURCE = 'sourceCInd';
    public static final String PARAM_REQUEST_ID = 'documentID';
    public static final String PARAM_TYPE = 'applicationRk';
    public static final String PARAM_RESULT_GROUP = 'customerClassCD';
    public static final String PARAM_RESULT_GROUP_DAILY = 'daily';
    public static final String PARAM_RESULT_GROUP_MONTHLY = 'monthly';
    public static final String PARAM_HASNAME_VALUE = 'hasNameValue';
    //added by Fajar Salam
    public static final String PARAM_MSG_CREATED_DATE = 'createdDate';
    public static final String PARAM_MSG_SENDTO = 'sendTo';
    public static final String PARAM_MSG_START_DATE = 'validFromDttm';
    public static final String PARAM_MSG_END_DATE = 'validToDttm';
    public static final String PARAM_MSG_EMAIL_MDM = 'emailMDM';
    public static final String PARAM_MSG_SEND_DATE =  'sendDate';
    public static final String PARAM_MSG_PHONE_MDM = 'phoneNumberMDM';
    public static final String PARAM_MSG_LAST_LOGIN =  'lastLoginDate';
    public static final String PARAM_MSG_GENDER = 'genderCD';
    public static final String PARAM_MSG_MODIFYBY = 'modifiedBy';
    public static final String PARAM_MSG_VALUE = 'value';
    public static final String PARAM_DMU_NEXTPAGE = 'reEntryRt';
    public static final String PARAM_DEPENDENT_NO = 'dependentNO';
    public static final String PARAM_ORIGINAL_POLICY = 'originalPolicyNo';
    public static final String PARAM_PAYMENT_REFID = 'paymentRefID';
    public static final String PARAM_CONVERT_TO_PRIVATE = 'convertToPrivateInd';
    public static final String PARAM_REASON1 = 'reason1';
    public static final String PARAM_REASON2 = 'reason2';
    public static final String PARAM_LETTER_CD = 'letterCD';
    public static final String PARAM_UWREMARK1 = 'uwRemark1';
    public static final String PARAM_UWREMARK2 = 'uwRemark2';
    public static final String PARAM_UWREMARK3 = 'uwRemark3';
    public static final String PARAM_ASSMT_SECTION = 'assmtSection';
    public static final String PARAM_ASSESSOR_DTTM = 'assessorDTTM';
    public static final String PARAM_ASSESSOR = 'assessor';
    public static final String PARAM_ASSMT_REMARK = 'assmtRemark';
    public static final String PARAM_ASSMT_REFNO = 'assmtRefNo';
    public static final String PARAM_LAST_UPD_DTTM = 'lastUpdDTTM';
    public static final String PARAM_ASSMT_NO = 'assmtNo';
    public static final String PARAM_ASSMT_TYPECD = 'assmtTypeCd';
    public static final String PARAM_ASSESSMENT_CLASSTYPE = 'assessmentClassType';
    public static final String PARAM_ASSMT_DESC = 'assmtDesc';
    public static final String PARAM_CLAIM_STATUSCD = 'claimStatusCD';
    public static final String PARAM_MSG_REMARKS = 'remarks';
    public static final String PARAM_CLAIM_REMARKS = 'claimRemarks';
    public static final String PARAM_CLAIM_TYPECD = 'claimTypeCd';
    public static final String PARAM_NOTIF_TYPECD = 'notificationTypeCode';
    public static final String PARAM_REF_NUMBER = 'referenceNumber';
    public static final String PARAM_REMARK_CODE = 'remarkCode';
    public static final String PARAM_REMARK_DESC = 'remarkDescription';
    public static final String PARAM_DEPARTMENTCD = 'departmentCode';
    public static final String PARAM_LASTUPDATE_DT = 'lastUpdateDate';
    public static final String PARAM_COMP_STATUS = 'completionStatus';
    public static final String MAP_REQUEST_TIME = 'RequestTime';
    public static final String MAP_RESPONSE_TIME = 'ResponseTime';
    public static final String MAP_EIP_JSON_REQUEST = 'RequestEIPJSON';
    public static final String MAP_EIP_JSON_RESPONSE = 'ResponseEIPJSON';
    public static final String MAP_OPERATION = 'Operation';
    public static final String MAP_SERVICE = 'Service';
    public static final String MAP_ORDER_ID = 'OrderID';
    public static final String MAP_POLICY_NUMBER = 'PolicyNumber';
    public static final String MAP_ENTITY = 'Entity';
    public static final String MAP_POLICY_APP = 'PolicyApp';
    
    /*
     * EIP_CustomerCommunication
     * added by @Fajar Salam
    */
    public static final String CS_COM_TARGET = 'target';
    public static final String CS_COM_MESSAGE_ID = 'messageID';
    public static final String CS_COM_DELIVER_STATUS = 'deliveryStatusCD';
    
    /*
     * EIP_CustomerCommunication
     * added by @Adi Wijaya
     * 2023 March 26th
    */
    public static final String WA_CC_MESSAGE_TYPE = 'text';
    public static final String WA_CUSTOMER_NAME = 'customerName';
    public static final String WA_SURVEY_URL_LINK = 'surveyLink';
    public static final String WA_PHONE_TO = 'WAPhoneNumber';
    public static final String WA_TEMPLATE_ID = 'templateID';
    public static final String WA_NAMESPACE = 'nameSpace'; 
    public static final String WA_CUSTOMER_SERVICE = 'layanan'; // updated by Support MII at 22 04 24
    public static final String WA_CUSTOMER_GENDER = 'Bapak/Ibu'; // updated by Support MII at 22 04 24
    
    public static final String WA_POLICY_NUMBER = 'policyNumber';
    public static final String WA_CATEGORY = 'CATEGORY';
    
    //Add by Elviana Victoria
    public static final String WA_SUBMISSION_TYPE = 'submissionType';
    
    // add by Adi
    public static final String PARAM_PASSPORT_NO = 'passportNo';
    public static final String PARAM_TITLE_TXT = 'titleTXT';
    public static final String PARAM_FULLNAME = 'fullNM';
    public Static final String DEFAULT_HAMLET_NO = '100';
    
    public static final String DEFAULT_PAGE_SIZE = '100';
    public static final String DEFAULT_PAGE_START_NO = '1';
    
    /* RLS-DMTM Assessment for API field name mapping
	* added by Ichwan 12/16/2025
	*/
    public static final String FIELD_POLICY_NO = 'Policy_No__c';
    public static final String FIELD_CALL_REMARK = 'Call_Remarks__c';
    public static final String FIELD_ID = 'Id';
    public static final String FIELD_CASE_TYPE = 'Case_Type__c';
    public static final String FIELD_ACTIVITY_RESULT = 'Activity_Result__c';
    public static final String FIELD_REASON_STATUS = 'Reason_Status_Config__c';
    public static final String FIELD_ID_RLS = 'ID_User_RLS__c';
    public static final String FIELD_ID_DMTM = 'ID_User_DMTM__c';
    public static final String FIELD_CONTACTED_NUMBER = 'Contacted_Number__c';
    public static final String FIELD_CREATED_DATE = 'CreatedDate';
    public static final String FIELD_POLICY_NUMBERS = 'Policy_Numbers__c';
    public static final String FIELD_CONTACT_PHONE = 'ContactPhone';
    public static final String FIELD_COM_NICKNAME = 'CommunityNickname';
    public static final String FIELD_LAST_MDDT = 'LastModifiedDate';
    public static final String FIELD_DESCRIPTION = 'Description';
    public static final String FIELD_ORIGIN = 'Origin';
    public static final String FIELD_STTS_HAS_CALL = 'Status_has_call__c';
    public static final String FIELD_UW_REMARK = 'UW_Remark__c';
    public static final String FIELD_COL_CALL_DATE = 'Collection_Call_Date__c';
    
    /* EIP_RLSUpdateNotes
     * added by Ichwan 11/25/2024
	*/
    public static final String HEADER_PARAM_SERVICE_NAME = 'serviceName';
    public static final String HEADER_PARAM_MSG_NAME = 'messageName';
    public static final String HEADER_PARAM_MEP = 'mep';
    public static final String HEADER_PARAM_COUNTRYCD = 'countryCD';
    public static final String HEADER_PARAM_LOBCD = 'lobCD';
    public static final String HEADER_PARAM_ENTITYCD = 'entityCD';
    public static final String HEADER_PARAM_SOURCE_SYS = 'sourceSystem';
    public static final String HEADER_PARAM_TARGET_SYS = 'targetSystem';
    public static final String PARAM_LINE_NUMBER = 'lineNumber';
    public static final String PARAM_CREATION_DATE = 'creationDate';
    public static final String PARAM_CREATION_TIME = 'creationTime';
    public static final String PARAM_USERID = 'userId';
    public static final String PARAM_SECTION_CODE = 'sectionCode';
    public static final String PARAM_LENGTH = 'length';
    public static final String ASSESSMENT_DETAIL = 'assessmentDetailDescription';
    
    public static final String PARAM_CASE_NUMBER = 'caseNumber';
    public static final String PARAM_CASE_TYPE = 'caseType';
    public static final String PARAM_TRANSACTION_TYPE = 'transactionTypeDesc';
    public static final String PARAM_CUSTOMER_RK = 'customerRk';
    public static final String PARAM_SOURCE_CHANNEL_ID = 'sourceChannelCD';
    public static final String PARAM_DOCUMENT_BASE64FILE = 'documentMIMETypeCD';
    public static final String PARAM_DOCUMENT_ID = 'documentID';
    public static final String PARAM_DOCUMENT_NAME = 'documentNM';
    public static final String PARAM_WORKTYPE = 'worktype';
    
    public static final String SOURCE_CHANNEL = 'CCC-W';
    
}