/**
 * @description       : 
 * @author            : Ahmad Yazid Munif
 * @group             : 
 * @last modified on  : 02-10-2025
 * @last modified by  : Muh Syafiq Hidayatullah
**/
public class LogBookActivitiyController { 
    private final static String MSG_CREATE_SUCCESS = 'Log book activitiy has been created successfully';
    private final static String MSG_SEND_SUCCESS = 'E-receipt Delivery Process was Successful';
    private final static String MSG_CREATE_FAILED = 'Log book activitiy is not successfully created'; 
    private final static String MSG_EDIT_SUCCESS = 'Log book activitiy has been edited successfully'; 
    private final static String MSG_EDIT_FAILED = 'Log book activitiy is not successfully edited'; 
    private final static String MSG_ERROR_NEED_CR_REQUIRED = 'Need CR is required'; 
    private final static String MSG_ERROR_STATUS_REQUIRED = 'Status is required';  
    private final static String MSG_ERROR_COURIER_REQUIRED = 'Courier is required';
    private final static String MSG_ERROR_NEED_FORM_UTAMA = 'Form Utama is required';
    private final static String MSG_ERROR_NEED_KIND_TRANSACTION = 'Kind Of Transaction is required';
    private final static String PARAM_TYPE = 'type';
    private final static String PARAM_ID = 'id'; 
    private final static String PARAM_STATE = 'state';
    private final static String PARAM_EDITQUEUE = 'editQ';
    private final static String ALL_OPTION = 'All';
    private final static String STATE_DETAIL = 'd';
    private final static String STATE_EDIT = 'e';
    private final static String RECORD_TYPE_REQUEST_CASE = 'RequestAMFSCase';
    private final static String RECORD_TYPE_INQUIRY_CASE = 'InquiryAMFSCase';
    private final static String RECORD_TYPE_COMPLAINT_CASE = 'AMFSComplaintCase';
    private final static String TRX_TYPE_REQUEST = 'Request';
    private final static String TRX_TYPE_INQUIRY = 'Inquiry';
    private final static String TRX_TYPE_COMPLAINT = 'Complaint';
    private final static String ENTITY_AMFS = 'AMFS';
    private final static String NON_CUSTOMER = 'Non Customer AMFS';
    private final static String CUSTOMER = 'Customer';
    private final static String DEFAULT_SEGMENTATION = 'Reguler';
    
    private final static String DEFAULT_CUSTOMER_RELATION ='Diri Sendiri';
    
    
    // Add by Ranti at 13/10/2021
    // add message error Sent E-Receipt
    private final static String MSG_EMAIL_FAILED = 'Email is required'; 
    private final static String MSG_PHONE_FAILED = 'Phone is required'; 
    private final static String MSG_EMAIL_AND_PHONE_FAILED = 'Email and Phone is required'; 
    private final static String MSG_TYPE_SEND_FAILED = 'Type Sent E-Receipt is required'; 
    
    // add Type Sent Receipt
    private final static String TYPE_SEND_SMS = 'SMS'; 
    private final static String TYPE_SEND_EMAIL = 'Email'; 
    private final static String TYPE_SEND_SMS_EMAIL = 'SMS and Email'; 
    
    // add by Adi
    // add constant identity verification
    private final static String MSG_POLICY_NO_BLANK = 'Policy is Required for Verification';
    private final static String MSG_IDENTITY_NO_BLANK = 'Identity No is Required for Verification!';
    private final static String MSG_VERIFIED_MATCH = 'MATCH';
    private final static String MSG_VERIFIED_NOT_MATCH = 'NOT MATCH';
    private final static String MSG_VERIFICATION_FAILED = 'Verification Failed: ';
    private final static String MSG_GENERAL_ERROR = 'Please Contact Administrator for Details';
    private final Static String MSG_DUKCAPIL_NOT_MATCH = 'Tidak Sesuai';
    private final static String PARAM_DASHBOARD = 'DASHBOARD';
    
    public String sensitiveCustomer {get;set;} 
    public boolean isMultiple {get;set;} 
    public String caseTypeFieldId {get; set;} 
    public String availableCaseTypeKeeper {get; set;} 
    public String selectedCaseTypeKeeper {get; set;}
    
    // Add by Faizir Isman (2020.07.08)
    public Datetime datetimenow {
        get { return DateTime.now(); }
        set { datetimenow = value;}
    }
    public Contact contacts {get;set;}
    
    public String dateNow {get;set;}
    public List<String> documentsInserted {get;set;}
    public List<String> otherDocument {get;set;}
    public String csoName {get;set;}
    public String city {get;set;}
    public Boolean isInsert {get;set;}
    
    public Log_Book_Activitiy__c logBook {get; set;}
    public Log_Book_Activitiy_Detail__c logBookDetail {get; set;}
    public List<Log_Book_Activitiy_Detail__c> logBookDetailList {get; set;}
    public Map<String,Log_Book_Activitiy_Detail__c> mapLogBookDetailList {get; set;}
    public Case logCase {get; set;}
    public List<Log_Book_Activitiy_Detail__c> listDetail {get; set;}
    public List<String> listDocument {get; set;}
    public Case cs {get; set;}
    public String logBookDate {get;set;}
    public String logBookDateDetailFormat {get;set;}
    public Boolean visibleEdit {get; set;}
    public Boolean visibleDetail {get; set;}
    public Boolean isValidCustomer {get; set;}
    public String [] docInformation = new String []{};
        
    // VSNAP, Taufik MII, 11 Feb 2020
    public Boolean showbuttonPCIDSS {get; set;}
    public Boolean showbuttonPCIDSSCC {get; set;}
    public Boolean showbuttonPCIDSSSaving {get; set;}
    public String firstContactId {get; set;}                    //Store current selected contactId from Initial lookup
    public String contactPolicyNo {get; set;}
    public String contactEntity {get; set;}
    public String contactPolicyApp {get; set;}
    public Boolean SendEmail {get; set;}
    public String ContactKYC {get; set;} // perorangan / Non Perorangan
    //public String ContactKYC {get{ if(ContactKYC==NULL) ContactKYC='--None--';} set;} // perorangan / Non Perorangan
    public Boolean beneficialOwner {get; set;}
    
    public Map<String,String> mapDocOtherDoc {get;set;}
    public Map<String,String> mapDocInsertedDoc {get;set;}
    List<String> newList = new List<String>();
    
    // add by Ranti at 10/05/2021 define attach
    public List<Attachment> newAttachments {get; set;} 
    public Id caseId {get; set;}
    public Integer totalAttach {get;set;}
    public String entityAuth {get;set;}
    public User userObj {get; set;}
    public Id parentIdAttachment {get;set;}
    public Id parentIdCreated {get;set;}
    
    public Boolean isAttach {get;set;}
    public Boolean attachIsInsert {get;set;}
    
    //added by Ranti at 10/21/2021
    public String firstEmailContact {get; set;}        
    public String firstNumberContact {get; set;}
    
    // added by Ranti at 10/22/2021
    transient public String attachmentStrBody {get;set;}
    transient public String attachmentStrName {get;set;}
    transient public String attachmentStrType {get;set;}
    
    //add by khris at 27102021
    public String paramQueue {get;set;}
    public String paramTouchPoint {get;set;}
    public String paramDateLog {get;set;}
    public String lbdId {get;set;}
    //end add by khris at 27102021 
    
    // Added by Ranti at 11/24/2021
    public Boolean showPP {get;set;}
    public Boolean showNonPP {get;set;}
    public String sendType {get;set;}
    
    
    public String kindOfTransactionID {get;set;}
    public String DepartmentId {get;set;}
    public Boolean checkCourier {get;set;}
    public Boolean isEditQueue {get;set;}
    
    public Time editQTimeServed {get;set;}
    
    //add by adi at 2024/05
    public String identityNo {get;set;}
    public String identityValResult {get;set;}
    public Boolean isIdentityValidated {get;set;}
    public Boolean isIdValPossitive {get;set;}
    
    //Add by Mario - EUONIA 02/02/2025
    public List<Touchpoint_Setting__mdt> touchpointMDT {get;set;}
    public String TabletEmail {get;set;}
    //public List<String> DokumenTambahan {get;set;}
    public String selectedDokumen { get; set; }
    public String selectedForm { get; set; }  
    public String linkEform { get; set; }
    public String helpText { get; set; }  
    public Boolean isEform {get; set;}
    
    //add by Yazid 21/05/2025
    public String saveSearchPolicyId {get;set;}
    public String savePolicyNumber {get;set;}
    public String saveEmailPP {get;set;}
    public String saveNoTelpPP {get;set;}
    public String savePolicyNameHolder {get;set;}
    public String saveProductType {get;set;}
    public Boolean saveIsPolicyHolder {get;set;}
    public String saveCustomerName {get;set;}
    public String saveCustomerRelation {get;set;}
    public String saveEmailNonPP {get;set;}
    public String savePhoneNonPP {get;set;}
    public String saveCSSubject {get;set;}
    public String saveDescription {get;set;}
    public String labelEmailTemplateCustomer {get;set;}
    public String labelEmailTemplateDipcad {get;set;}
    private static Decimal MAX_EMAIL_TOTAL_ATTACHMENT_MB = 5.0;
    private static Decimal BYTE_TO_MB_CONVERT = 1024 * 1024;
    public Boolean isButtonDisabled { get; set; }
    public boolean isJapenPOS {get;set;}
    public Boolean isTanpaFormUtama { get; set; }
    public String emailList { get; set; }
    // public Map<String,Master_Dipcad_Code__c> listJapen { get; set; }
    // public Boolean isLoading { get; set; }
    @TestVisible private static Decimal injectSizeAttachment;
    @TestVisible private static Decimal injectTotalSizeAttachment;
    //--Generate picklist KYC
    public List<SelectOption> getListOfKYC() {
        List<SelectOption> tempList = new List<SelectOption>();
        tempList.add(new SelectOption('', '--None--'));
        tempList.add(new SelectOption('Perorangan', 'Perorangan'));
        tempList.add(new SelectOption('Non-Perorangan', 'Non-Perorangan'));
        return tempList;
    }
    
    
    private Integer indexDoc = 0;
    private Map<String,String> mapDocInfo = new Map<String,String>();
    
    public class CaseData {
        public String logBookId;
        public String recordTypeId;
        public String contactId;
        public String transactionType;
        public String caseType;
        public String status;
        public String subject;
        public String origin;
        public String description;
        public Boolean nonPP;
        public String generalAttitude;
        public String nature;
        public String category;
        public String businessChannel;
        public String cutomer;
        public String complainant;
        public String channel;
        public String customerType;
        public String product;
        public String complaintType;
        public String priority;
        public String complaintDetail;
        public Date receivedDate;
        public String courier;
        public String department;
        public String appeal;
        // add by Ranti at 10/10/2021 define list attach after insert case
        public List<attachmentData> AttachCase;
        // add by Ranti at 14/10/2021, add sent e-receipt
        public String emailNonPPReceipt;
        public String PhoneNonPPReceipt;
        // public String typeSentReceipt;
        public String contactPolicy;
        public String contactEmail;
        public String contactPhone;
        public String parentIdAttach;
        public String createdByAttach;
        public Double Amount_to_be_Debited;
        public Double Account_Number;
        public Date Follow_Debit_Date;
        public Date Follow_Hold_Date;
    }
    
    /**
     * @description 
     * Untuk keperluan data E-Receipt auto populate Documentnya
     * @return Map<Id, Object>
     * @author Yazid 26-05-2025
     * @date 26-05-2025
     */
    public Map<String, String> getDataeReceipt(){
        List<Master_Dipcad_Code__c> eReceipts = [
            SELECT Id, Kind_of_Transaction__c, Document__c, Form_Utama__c 
            FROM Master_Dipcad_Code__c
        ];
        Map<String, String> eReceiptMap = new Map<String, String>();
        for (Master_Dipcad_Code__c receipt : eReceipts) {
            String key = receipt.Kind_of_Transaction__c.replaceAll('[ _-]', '').toLowerCase();
            if(receipt.Form_Utama__c != null) key=key+receipt.Form_Utama__c.replaceAll('[ _-]', '').toLowerCase();
            eReceiptMap.put(key, receipt.Document__c);
        }
        return eReceiptMap;
    }
    // End by Yazid MII 04/09/2025

    // add by Ranti at 10/10/2021 define method attach string
    public class attachmentData {
        public String body;
        public String name;
    }
    
    public String [] getDocInformation() {
        system.debug('## getter > docInformation : ' + docInformation);
        return docInformation;
    }//end getter
    
    public void setDocInformation(String [] docInformation) {
        this.docInformation = docInformation;
        system.debug('## setter > docInformation : ' + this.docInformation);
        System.debug('index : '+indexDoc);
        Integer docSize = this.docInformation.size();
        try{
            if(this.docInformation != null && docSize > 0){
                String d = '';
                if(listDocument != null){
                    String docName = listDocument.get(indexDoc);
                    d += docName;
                    d += '[';
                    for(Integer i=0; i < docSize; i++){
                        String val = this.docInformation[i];
                        d += val;
                        if(docSize > 1 && (docSize-1) != i ){
                            d += ',';
                        }
                    }
                    d += ']';
                    
                    mapDocInfo.put(docName, d);
                    System.debug('mapDocInfo : '+mapDocInfo);
                }
            }//end if/else
            indexDoc++;
        }catch(Exception ex){
            String errorMessage =  ex.getStackTraceString() + ' || ' + ex.getTypeName() + ' || ' + ex.getMessage();
            System.debug(errorMessage);
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_CREATE_FAILED));
        }
    }//end setter
    
    /**
     * @description 
     * Constructor LogBookActivity mengecek parameter di URL apakah ada IdLogbook
     * untuk bisa digunakan juga untuk keperluan Save & New ketika CreateLogBook
     * @author Yazid 26-05-2025
     * @date 26-05-2025
     */
    public LogBookActivitiyController() {
        // change by Yazid MII 04/09/2025
        DateTime dtToday = DateTime.now();
        checkCourier = false;
        isMultiple = false;
        identityValResult = '';
        isIdentityValidated = false;
        isIdValPossitive = true;
        clear();

        system.debug('LINK EFORM 2: ' + linkEform);
        logBook.Type__c = ApexPages.currentPage().getParameters().get(PARAM_TYPE); 
        isEditQueue = ApexPages.currentPage().getParameters().get(PARAM_EDITQUEUE) == 'true' ? true : false; 
        identityValResult = ApexPages.currentPage().getParameters().get('identityValResult');
        if (identityValResult != null && identityValResult != '') logBook.NIK_Verify_Result__c = identityValResult;
        if (ApexPages.currentPage().getParameters().get('isIdentityValidated') != null) isIdentityValidated = Boolean.valueOf(ApexPages.currentPage().getParameters().get('isIdentityValidated'));
        if (ApexPages.currentPage().getParameters().get('isIdValPossitive') != null) isIdValPossitive  = Boolean.valueOf(ApexPages.currentPage().getParameters().get('isIdValPossitive'));
        if (isEditQueue) {
            editQTimeServed = dtToday.time();
                system.debug('editQ time server from parameter:' + ApexPages.currentPage().getParameters().get('editQTimeServed'));
            if (ApexPages.currentPage().getParameters().get('editQTimeServed') != null) {
                String strEditQTimeServed = ApexPages.currentPage().getParameters().get('editQTimeServed');
                String[] splitEditQTimeServed2 = strEditQTimeServed.split(':');
                editQTimeServed = Time.newInstance(Integer.valueOf(splitEditQTimeServed2[0]), Integer.valueOf(splitEditQTimeServed2[1]), 0, 0);
            }
        }
        newAttachments = new List<Attachment>{new Attachment()};
        string logbookid = ApexPages.currentPage().getParameters().get('logbookactivitiyid');
        String timeServedStr = ApexPages.currentPage().getParameters().get('timeServed');
        System.debug(':::::::: TIME SERVED0: ' + timeServedStr);
        
        // add by Yazid at 05/06/2025
        saveSearchPolicyId = string.valueOf(ApexPages.currentPage().getParameters().get('policyId'));
        if(saveSearchPolicyId!=null){
            saveCSSubject = ApexPages.currentPage().getParameters().get('csSubject');
            savePolicyNumber = ApexPages.currentPage().getParameters().get('policyNumber');
            saveEmailPP = ApexPages.currentPage().getParameters().get('emailP');
            saveNoTelpPP = ApexPages.currentPage().getParameters().get('telpP');
            savePolicyNameHolder = ApexPages.currentPage().getParameters().get('nameHolderP');
            saveProductType = ApexPages.currentPage().getParameters().get('productType');
            system.debug('DEBUG:' + ApexPages.currentPage().getParameters().get('isPolicyHolder'));
            saveIsPolicyHolder = Boolean.valueOf(ApexPages.currentPage().getParameters().get('isPolicyHolder'));
            saveCustomerName = ApexPages.currentPage().getParameters().get('customerName');
            saveCustomerRelation = ApexPages.currentPage().getParameters().get('customerRelation');
            
            saveEmailNonPP = ApexPages.currentPage().getParameters().get('emailNonPP');
            savePhoneNonPP = ApexPages.currentPage().getParameters().get('phoneNonPP');
            saveDescription = ApexPages.currentPage().getParameters().get('description');
            
            logBookDetail.Contact_Policy__c = saveSearchPolicyId;
            logBookDetail.Policy_Number__c = savePolicyNumber;
            logbookdetail.Email_PP__c = saveEmailPP;
            logbookdetail.Phone_PP__c = saveNoTelpPP;
            logBookDetail.Policy_Name_Holder__c = savePolicyNameHolder;
            logBookDetail.Product_Type__c = saveProductType;
            logBookDetail.Is_Policy_Holder__c = saveIsPolicyHolder;
            logBookDetail.Customer_Name__c = saveCustomerName;
            logBookDetail.Customer_Relation__c = saveCustomerRelation;
            logBookDetail.Email_Non_PP__c = saveEmailNonPP;
            logBookDetail.Phone_Non_PP__c = savePhoneNonPP;
            logBookDetail.Remarks_Long_Text__c = saveDescription;
            cs.Subject = saveCSSubject;
            identityNo = ApexPages.currentPage().getParameters().get('identityNo');
        }

        if(logbookid!=null){
            log_book_activitiy__c getdetail =[select id, touch_point__c, queue_no__c, log_book_date__c, Time_In__c, Time_Served__c, Handling_Time__c from log_book_activitiy__c where id =:logbookid];

            List<Log_Book_Activitiy_Detail__c> getLBD = [SELECT id,Status_to_Metadata__c,Status_Metadata__c from Log_Book_Activitiy_Detail__c WHERE Log_Book_Activitiy__c = :logbookid AND EForm__c = true AND Canceled__c = false ORDER BY CreatedDate ASC];
            Integer statusResponse = 0;
            List<String> failedLBAD = new List<String>();
            List<String> failedImage = new List<String>();

            for (Log_Book_Activitiy_Detail__c detail : getLBD) {
                if(detail.Status_to_Metadata__c!= null && detail.Status_Metadata__c!=null){
                    Map<String, Object> dataMap = (Map<String, Object>) JSON.deserializeUntyped(detail.Status_Metadata__c);
                    for(String keys : dataMap.keySet()){
                        Map<String, Object> innerData = (Map<String, Object>) dataMap.get(keys);
                        String status = (String) innerData.get('status');
                        String nameFile = (String) innerData.get('nameFile');
                        String idValue = (String) innerData.get('id');
                        String idValueLBAD = (String) innerData.get('idLBAD');
                        if (status != 'Success' && nameFile == 'LogBook Activity Detail' && idValueLBAD == detail.id) {
                            if(status!='On Process'){
                                failedLBAD.add(idValueLBAD);
                            }
                        }
                        statusResponse++;
                        // if (status != 'Success' && nameFile != 'LogBook Activity Detail' && idValue == detail.id) {
                        //     failedImage.add(idValue);
                        // }
                    }
                }
            }
            system.debug('##### Log Book Id ' + logbookid);
            system.debug('##### Failed LBAD ' + failedLBAD);
            
            isButtonDisabled=false;
            if(failedLBAD.isEmpty()&&statusResponse>0){
                isButtonDisabled=true;
            }

            logBook.touch_point__c= getdetail.touch_point__c;
            logBook.queue_no__c= getdetail.queue_no__c;
            logBook.log_book_date__c= getdetail.log_book_date__c;
            logBook.Time_In__c= getdetail.Time_In__c;
            logBook.Time_Served__c = getDetail.Time_Served__c;
            logBook.Id = logbookid;
            logBook.Handling_time__c = getDetail.Handling_Time__c;
        	System.debug(':::::::: TIME SERVED-1: ' + getDetail.Time_Served__c);
            
            String policyNo = ApexPages.currentPage().getParameters().get('policyNo');
            contactPolicyNo = policyNo;
            TabletEmail = ApexPages.currentPage().getParameters().get('tabletEmail');
            listDetail = inquiryLogBookActivity(string.valueOf(getdetail.log_book_date__c), getdetail.touch_point__c, getdetail.queue_no__c, '', '', '', '');
        }
        // End change by Yazid MII 04/09/2025
        
        userObj = [SELECT id, Entity__c, Profile.Name FROM user WHERE id = :UserInfo.getUserId()];
        entityAuth = userObj.Entity__c;  
        parentIdCreated = userObj.Id;
        attachIsInsert = false; 
        
        // added by Ranti at 10/03/2023
        kindOfTransactionID = System.label.Kind_of_Transaction_ID; 
        DepartmentId = System.label.Department_Log_Book;
        
        availableCaseTypeKeeper = JSON.serialize(KindOfTransactionMultiple());

        //Added by Mario at 30/05/2025
        linkEform = ApexPages.currentPage().getParameters().get('linkEform'); 
        helpText = ApexPages.currentPage().getParameters().get('helpText');
    }
    
    public List<Attachment> getNewAttachments() { 
        return null;
    }
    
    private void clear(){
        cs = new Case();
        logBook = new Log_Book_Activitiy__c();
        logBookDetail = new Log_Book_Activitiy_Detail__c();
        if(listDetail != null && listDetail.size() > 0){
            listDetail.clear();
        }
        listDetail = new List<Log_Book_Activitiy_Detail__c>();
        
        DateTime dtToday = DateTime.now();
        logBookDate = dtToday.format('yyyy-MM-dd');
        logBookDateDetailFormat = dtToday.format('yyyy-MM-dd hh:mm:ss');
        isValidCustomer = true;
        listDocument = new List<String>();
        logBook.Time_Served__c = dtToday.time();
        indexDoc = 0;
        mapDocInfo.clear();
        docInformation = new String []{};
    }
    
    // START INQUIRY
    public PageReference init(){
        System.debug('==== init() ');
        clear();
        inquirySearch();
        return null;
    }
    
    public PageReference inquirySearch(){
        String logDate = logBookDate;
        String touchPoint = logBook.Touch_Point__c;
        String queueNo = logBook.Queue_No__c;
        String policyNo = logBookDetail.Policy_Number__c;
        String policyNm = logBookDetail.Policy_Name_Holder__c;
        String custNm = logBookDetail.Customer_Name__c;
        String kindOfTrx = logBookDetail.Kind_Of_Transaction__c;
        
        System.debug('Search Filter ('+
                     'Date='+logDate+
                     ',Touch Point='+touchPoint+
                     ',Queue Number='+queueNo+
                     ',Kind Of Transaction='+kindOfTrx+
                     ',Policy Number='+policyNo+
                     ',Policy Number Holder='+policyNm+
                     ',Customer Name='+custNm+')');
        
        listDetail = inquiryLogBookActivity(logDate, touchPoint, queueNo, policyNo, policyNm, custNm, kindOfTrx);
        
        return null;
    }
    
    /*private List<Log_Book_Activitiy_Detail__c> inquiryLogBookActivityOld(
        String logDate, String touchPoint, String queueNo, String policyNo, String policyNm, String custNm, String kindOfTrx){
            
            String soql = 'SELECT ID, Log_Case__r.CaseNumber, Log_Book_Activitiy__r.Log_Book_Date__c, Log_Book_Activitiy__r.Queue_No__c, Policy_Number__c, Policy_Name_Holder__c,'+
                ' Customer_Name__c, Kind_Of_Transaction__c, LastModifiedDate, Contact_Policy__c, Customer_Relation__c , Document_Information__c, Other_Document__c, Department__c, Log_Book_Activitiy__r.CSO_Name__c, Log_Book_Activitiy__r.Touch_Point__c, Sensitive_Customer__c '+
                ' FROM Log_Book_Activitiy_Detail__c WHERE';
            soql += ' CreatedBy.ID = \'' + UserInfo.getUserId() +'\'';
            soql += String.isNotBlank(policyNo) ? ' AND Policy_Number__c = \''+policyNo+'\'' : '';
            soql += String.isNotBlank(policyNm) ? ' AND Policy_Name_Holder__c LIKE \'%'+policyNm+'%\'' : '';
            soql += String.isNotBlank(custNm) ? ' AND Customer_Name__c LIKE \'%'+custNm+'%\'' : '';
            soql += String.isNotBlank(kindOfTrx) && !ALL_OPTION.equals(kindOfTrx) ? ' AND Kind_Of_Transaction__c = \''+kindOfTrx+'\'' : '';
            soql += String.isNotBlank(touchPoint) && !ALL_OPTION.equals(touchPoint) ? ' AND Log_Book_Activitiy__r.Touch_Point__c = \''+touchPoint+'\'' : '';
            soql += String.isNotBlank(queueNo) ? ' AND Log_Book_Activitiy__r.Queue_No__c = \''+queueNo+'\'' : '';
            soql += String.isNotBlank(logDate) ? ' AND Log_Book_Activitiy__r.Log_Book_Date__c = '+ logDate.substring(0,10) : '';
            soql += ' ORDER BY Log_Book_Activitiy__r.CreatedDate DESC LIMIT 30';
            System.debug('SOQL = ' +soql);
            List<Log_Book_Activitiy_Detail__c> listInquiryLogBook = Database.query(soql);
            
            return listInquiryLogBook;
        } */
    
    private List<Log_Book_Activitiy_Detail__c> inquiryLogBookActivity(
        String logDate, String touchPoint, String queueNo, String policyNo, String policyNm, String custNm, String kindOfTrx){
            
            String soql = 'SELECT ID, Log_Case__r.CaseNumber, Log_Book_Activitiy__r.Log_Book_Date__c, Log_Book_Activitiy__r.Queue_No__c, Log_Book_Activitiy__r.Status_send__c,Log_Book_Activitiy__r.Last_seen__c, Policy_Number__c, Policy_Name_Holder__c, Email_PP__c, Phone_Non_PP__c, Email_Non_PP__c, Phone_PP__c,Status_to_Metadata__c,'+
                'Product_Type__c, Document_Type__c,Stamp__c, Remarks_Long_Text__c, Customer_Name__c, Kind_Of_Transaction__c, LastModifiedDate, Contact_Policy__c, Customer_Relation__c , Document_Information__c, Other_Document__c, Department__c, Log_Book_Activitiy__r.CSO_Name__c, Log_Book_Activitiy__r.Touch_Point__c, Sensitive_Customer__c,Log_Book_Activitiy__r.Sequence_Email__c, Log_Book_Activitiy__r.Sequence_SMS__c '+
                ' FROM Log_Book_Activitiy_Detail__c WHERE';
            soql += ' CreatedBy.ID = \'' + UserInfo.getUserId() +'\'';
            soql += String.isNotBlank(policyNo) ? ' AND Policy_Number__c = \''+policyNo+'\'' : '';
            soql += String.isNotBlank(policyNm) ? ' AND Policy_Name_Holder__c LIKE \'%'+policyNm+'%\'' : '';
            soql += String.isNotBlank(custNm) ? ' AND Customer_Name__c LIKE \'%'+custNm+'%\'' : '';
            soql += String.isNotBlank(kindOfTrx) && !ALL_OPTION.equals(kindOfTrx) ? ' AND Kind_Of_Transaction__c = \''+kindOfTrx+'\'' : '';
            soql += String.isNotBlank(touchPoint) && !ALL_OPTION.equals(touchPoint) ? ' AND Log_Book_Activitiy__r.Touch_Point__c = \''+touchPoint+'\'' : '';
            soql += String.isNotBlank(queueNo) ? ' AND Log_Book_Activitiy__r.Queue_No__c = \''+queueNo+'\'' : '';
            soql += String.isNotBlank(logDate) ? ' AND Log_Book_Activitiy__r.Log_Book_Date__c = '+ logDate.substring(0,10) : '';
            soql += ' ORDER BY Log_Book_Activitiy__r.CreatedDate DESC LIMIT 30';
            System.debug('SOQL = ' +soql);
            List<Log_Book_Activitiy_Detail__c> listInquiryLogBook = Database.query(soql);
            
            return listInquiryLogBook;
        }
    
    public List<SelectOption> getKindOfTransaction(){
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Log_Book_Activitiy_Detail__c.Kind_Of_Transaction__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        options.add(new SelectOption(ALL_OPTION, ALL_OPTION));
        for( Schema.PicklistEntry pickListVal : ple){
            String val = pickListVal.getLabel();
            options.add(new SelectOption(val, val));
        }
        return options;
    }
    
    public List<SelectOption> getTouchPoints(){
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Log_Book_Activitiy__c.Touch_Point__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        options.add(new SelectOption(ALL_OPTION, ALL_OPTION));
        for( Schema.PicklistEntry pickListVal : ple){
            String val = pickListVal.getLabel();
            options.add(new SelectOption(val, val));
        }
        return options;
    }
    // END INQUIRY
    
    // Add by Yazid 04/09/2025 MII-EUONIA
    /**
     * @description 
     * Untuk mengecek apakah form tersebut E-Form atau bukan dengan mengecek berdasarkan KindOfTransaction
     * khusus untuk E-Form JAPEN akan cek KindOfTransaction dan FormUtama nya
     * @author by Yazid 04-09-2025
     * @date 26-05-2025
     */
    public Boolean checkEform(){
        Boolean valid = true;
        System.debug('##### masuk ke checkEform');
        System.debug('##### Check Dept: '+logBookDetail.Department__c);
        System.debug('##### Check Logbook Kind Transaction: '+logBookDetail.Kind_Of_Transaction__c);
        if(logBookDetail.Kind_Of_Transaction__c != null){
            Set<String> listEForm = new Set<String>();
            List<Master_Dipcad_Code__c> eformKindOfTrx = [SELECT Id, Kind_of_Transaction__c, Form_Utama__c, Is_E_Form__c from Master_Dipcad_Code__c WHERE Is_E_Form__c = true];
            for(Master_Dipcad_Code__c record: eformKindOfTrx){
                String cleanedTransaction = record.Kind_of_Transaction__c.trim().replace('_', '').replace('-', '').toLowerCase();
                listEForm.add(cleanedTransaction);
            }
            Set<String> listReqJapen = new Set<String>();
            Set<String> listFormUtama = new Set<String>();
            List<Master_Dipcad_Code__c> eformKindOfTrxJapen = [SELECT Id, Kind_of_Transaction__c, Form_Utama__c, Is_E_Form__c from Master_Dipcad_Code__c WHERE Is_E_Form__c = true AND Form_Utama__c != null];
            for(Master_Dipcad_Code__c record: eformKindOfTrx){
                String cleanedTransaction = record.Kind_of_Transaction__c.trim().replace('_', '').replace('-', '').toLowerCase();
                if(record.Form_Utama__c != null) {
                    String cleanedFormUtama = record.Form_Utama__c.trim().replace('_', '').replace('-', '').toLowerCase();
                    listFormUtama.add(cleanedFormUtama);
                }
                listReqJapen.add(cleanedTransaction);
            }
    
            String kindOfTrx = logBookDetail.Kind_Of_Transaction__c.trim().replace('_', '').replace('-', '').toLowerCase();
            System.debug('#### EFORM Kind Of Transaction = '+kindOfTrx);
            System.debug('#### EFORM listEForm = '+listEForm);
            System.debug('#### EFORM listFormUtama = '+listFormUtama);
            isEform = String.isNotBlank(kindOfTrx) && listEForm.contains(kindOfTrx);
            // if(isEform && logBookDetail.Form_Utama__c!=null){
            //     String formUtamaInput = logBookDetail.Form_Utama__c.trim().replace('_', '').replace('-', '').toLowerCase();
            //     isEform = String.isNotBlank(formUtamaInput) && listFormUtama.contains(formUtamaInput);
            // }
            if(isEform && isJapenPOS){
                if(logBookDetail.Form_Utama__c!=null){
                    String formUtamaInput = logBookDetail.Form_Utama__c.trim().replace('_', '').replace('-', '').toLowerCase();
                    isEform = listFormUtama.contains(formUtamaInput);
                }
            }
            System.debug('#### EFORM isEform = '+isEform + 'formUtamaInput = '+isEform);
        }else{
            valid = false;
        }
        return valid;
    }

    /**
     * @description 
     * Untuk validation sebelum save, jika validasi input gagal maka akan tampil error validasi sesuai yang ada dibawah
     * seperti : cek form Utama Japen harus isi Form Utama 
     * @author other edit by Yazid 26-05-2025
     * @date 26-05-2025
     */
    // START CREATE
    private Boolean additionalValidation(){
        Boolean isValid = true;
        system.debug('validation logBookDetail.Customer_Relation__c:'+logBookDetail.Customer_Relation__c);
        
        if(isJapenPOS != null){
            if(isJapenPOS){
                if(String.isBlank(logBookDetail.Form_Utama__c)){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_ERROR_NEED_FORM_UTAMA));
                    isValid = false;
                }
            }
        }

        if(logBookDetail.Department__c == 'POS' && String.isBlank(logBookDetail.Need_CR__c)){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_ERROR_NEED_CR_REQUIRED));
            isValid = false;
        }
        
        if(logBookDetail.Transaction_Type__c == TRX_TYPE_REQUEST && String.isBlank(logBookDetail.Status__c)){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_ERROR_STATUS_REQUIRED));
            System.debug('======================== Statusss: '+logBookDetail.Status__c); 
            System.debug(logBookDetail);
            isValid = false;
        }
        Boolean checkTrx ;
        if(logBookDetail.Department__c == 'POS' || logBookDetail.Department__c == 'ADS'){
            checkTrx = checkEform();
        }else {
            checkTrx = true;
        }
        system.debug('##### checkTrx: '+checkTrx);
        if(!checkTrx){
            system.debug('##### Masuk Kondisi !checkTrx: ');
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_ERROR_NEED_KIND_TRANSACTION));
            isValid = false;
        }
        system.debug('##### Check isValid: '+isValid);
        // for testing
        // if(isValid){
        //     ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'isEform '+isEform));
        //     isValid = false;
        // }


        /* if ( logBookDetail.Is_Non_Customer__c == true && String.isBlank(logBookDetail.Email_Non_PP__c) && String.isBlank(logBookDetail.Phone_Non_PP__c) ) { 
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'Email Non PP or Phone Non PP is Required')); 
            isValid = false;
        } */
        
        /* if(logBookDetail.Type_Sent_E_Receipt__c == TYPE_SEND_EMAIL && String.isBlank(logBookDetail.Email_Non_PP__c)){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_EMAIL_FAILED)); 
            System.debug(logBookDetail);
            isValid = false;
            } else if(logBookDetail.Type_Sent_E_Receipt__c == TYPE_SEND_SMS && String.isBlank(logBookDetail.Phone_Non_PP__c)) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_PHONE_FAILED)); 
            System.debug(logBookDetail);
            isValid = false;
            } else if(logBookDetail.Type_Sent_E_Receipt__c == TYPE_SEND_SMS_EMAIL && (String.isBlank(logBookDetail.Email_Non_PP__c) || String.isBlank(logBookDetail.Phone_Non_PP__c))) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_EMAIL_AND_PHONE_FAILED)); 
            System.debug(logBookDetail);
            isValid = false;
            } else if((String.isNotBlank(logBookDetail.Email_Non_PP__c) || String.isNotBlank(logBookDetail.Phone_Non_PP__c)) && logBookDetail.Type_Sent_E_Receipt__c == '') {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_TYPE_SEND_FAILED)); 
            System.debug(logBookDetail);
            isValid = false;
        } */
        
        
        return isValid;
    }
    
    /**
     * @description 
     * Untuk menyimpan Transaction di LogBookActivity. Didalam ada cek validation (additionalValidation)
     * jika lolos maka akan diproses untuk menyimpan LogBookActivityDetail
     * @author Other edited by Yazid 04-09-2025
     * @date 26-05-2025
     */
    public PageReference addPolicy(){
        System.debug('=============== ADD PROCESS LOGBOOK ============= ');
        System.debug(':::::::: TIME SERVED3: ' + logBook.Time_Served__c);
        PageReference pg = null;
        try{
            logBookDetail.Document_Information__c = generateDocumentInformation(mapDocInfo);
            
            if(additionalValidation()){
                
                System.debug(' == = = body:'+attachmentStrBody);
                System.debug(' == = = NAME:'+attachmentStrName);
                System.debug(' == = = TYPE:'+attachmentStrType);
                
                System.debug('LogBookActivityController isMultiple status: '+isMultiple);
                
                // added by Ranti add multiple transaction
                if (isMultiple == true) { 
                    
                    system.debug('multiple save!!!!');
                    String[] caseTypes = selectedCaseTypeKeeper.split('<br />');
                    
                    system.debug('caseTypes:'+selectedCaseTypeKeeper);
                    system.debug('caseTypes2:'+caseTypes);
                    list<Log_Book_Activitiy_Detail__c> logbookdetails = new list<Log_Book_Activitiy_Detail__c>();
                    for (String row : caseTypes) { 
                        
                        //Added by Elvi 2025 --> Case type is empty for multiple transaction
                        //String kindOftrx = logBookDetail.Kind_Of_Transaction__c;
                        logBookDetail.Kind_Of_Transaction__c = row;
                        checkCaseType();
                        cs.type=null;
                        Log_Book_Activitiy_Detail__c details = new Log_Book_Activitiy_Detail__c();
                        details.Policy_Number__c = logBookDetail.Policy_Number__c;
                        details.Contact_Policy__c = logBookDetail.Contact_Policy__c;
                        details.Is_Non_Customer__c = isValidCustomer ? logBookDetail.Is_Non_Customer__c : true;
                        details.Policy_Name_Holder__c = logBookDetail.Policy_Name_Holder__c;
                        details.Product_Type__c = logBookDetail.Product_Type__c;
                        details.Customer_Name__c = isValidCustomer ? logBookDetail.Customer_Name__c : row;
                        details.Customer_Relation__c = (isValidCustomer && !logBookDetail.Is_Policy_Holder__c) ? logBookDetail.Customer_Relation__c : DEFAULT_CUSTOMER_RELATION;
                        details.Is_Policy_Holder__c = logBookDetail.Is_Policy_Holder__c;
                        details.Segmentation__c = isValidCustomer ? logBookDetail.Segmentation__c : DEFAULT_SEGMENTATION;
                        details.Need_CR__c = logBookDetail.Need_CR__c;
                        details.Department__c = logBookDetail.Department__c;
                        details.Kind_Of_Transaction__c = row;
                        details.Document_Type__c = logBookDetail.Document_Type__c;
                        details.Document__c = logBookDetail.Document__c;
                        details.Stamp__c = logBookDetail.Stamp__c;
                        details.Remarks_Long_Text__c = isValidCustomer ? logBookDetail.Remarks_Long_Text__c : row;
                        details.Document_Information__c = logBookDetail.Document_Information__c;
                        details.Other_Document__c = logBookDetail.Other_Document__c;
                        details.Sensitive_Customer__c = logBookDetail.Sensitive_Customer__c; 
                        details.Transaction_Type__c = logBookDetail.Transaction_Type__c;
                        details.Case_Type__c = logBookDetail.Case_Type__c;
                        details.Customer_Mood__c = logBookDetail.Customer_Mood__c; 
                        details.Status__c = logBookDetail.Status__c; 
                        
                        // add by Ranti at 13/10/2021
                        // insert data receipt
                        details.Email_Non_PP__c = logBookDetail.Email_Non_PP__c;
                        details.Phone_Non_PP__c = logBookDetail.Phone_Non_PP__c;
                        // details.Type_Sent_E_Receipt__c = logBookDetail.Type_Sent_E_Receipt__c; 
                        details.Email_PP__c = logBookDetail.Email_PP__c;
                        details.Phone_PP__c = logBookDetail.Phone_PP__c;

                        // add by Yazid at 13/08/2025
                        // details.Form_Utama__c = logBookDetail.Form_Utama__c;
                        // if(isTanpaFormUtama!=null){
                        //     details.Input_Form_Utama__c = !isTanpaFormUtama;
                        //     system.debug('isTanpaFormUtama Save&New:'+details.Input_Form_Utama__c);
                        // }
                        system.debug('isTanpaFormUtama:'+details.Input_Form_Utama__c);
                        
                        logbookdetails.add(details); 
                        listDetail.add(details); 
                    }
                    
                    system.debug('logbookdetails:'+logbookdetails);
                    
                    saveProcessMultiple(logbookdetails);
                } else {
                    System.debug('#### Masuk Ke else Save 1 Transaksi');
                    // added by ranti at 10/22/2021
                    List<String> bodyAttachments = new List<String>();
                    List<String> nameAttachments = null;
                    List<String> typeAttachments = null;
                    if (attachmentStrBody != null && attachmentStrBody != '') {
                        RowIteratorUtil rowIterator = new RowIteratorUtil(attachmentStrBody, ','); 
                        nameAttachments = (List<String>) JSON.deserialize(attachmentStrName, List<String>.class);
                        typeAttachments = (List<String>) JSON.deserialize(attachmentStrType, List<String>.class);
                        
                        while (rowIterator.hasNext()) {
                            bodyAttachments.add(rowIterator.next());
                        }
                    }
                    
                    
                    if (bodyAttachments != null && bodyAttachments.size() > 0) {
                        for (Integer i = 0; i < bodyAttachments.size(); i++) {
                            attachment attach = new attachment();
                            Blob bodyAtt = EncodingUtil.base64Decode(bodyAttachments[i]); 
                            attach.Name = nameAttachments[i]; 
                            attach.ContentType = typeAttachments[i]; 
                            attach.Body = bodyAtt; 
                            newAttachments.add(attach);
                        }
                    }
                    
                    System.debug('=============== Attachment: '+newAttachments);
                    System.debug('=============== Attachment Size: '+newAttachments.size());
                    
                    Log_Book_Activitiy_Detail__c details = new Log_Book_Activitiy_Detail__c();
                    details.Policy_Number__c = logBookDetail.Policy_Number__c;
                    details.Contact_Policy__c = logBookDetail.Contact_Policy__c;
                    details.Is_Non_Customer__c = isValidCustomer ? logBookDetail.Is_Non_Customer__c : true;
                    details.Policy_Name_Holder__c = logBookDetail.Policy_Name_Holder__c;
                    details.Product_Type__c = logBookDetail.Product_Type__c;
                    details.Customer_Name__c = isValidCustomer ? logBookDetail.Customer_Name__c : logBookDetail.Kind_Of_Transaction__c;
                    details.Customer_Relation__c = (isValidCustomer && !logBookDetail.Is_Policy_Holder__c) ? logBookDetail.Customer_Relation__c : DEFAULT_CUSTOMER_RELATION;
                    details.Is_Policy_Holder__c = logBookDetail.Is_Policy_Holder__c;
                    details.Segmentation__c = isValidCustomer ? logBookDetail.Segmentation__c : DEFAULT_SEGMENTATION;
                    details.Need_CR__c = logBookDetail.Need_CR__c;
                    details.Department__c = logBookDetail.Department__c;
                    details.Kind_Of_Transaction__c = logBookDetail.Kind_Of_Transaction__c;
                    details.Document_Type__c = logBookDetail.Document_Type__c;
                    details.Document__c = logBookDetail.Document__c;
                    details.Stamp__c = logBookDetail.Stamp__c;
                    details.Remarks_Long_Text__c = isValidCustomer ? logBookDetail.Remarks_Long_Text__c : logBookDetail.Kind_Of_Transaction__c;
                    details.Document_Information__c = logBookDetail.Document_Information__c;
                    details.Other_Document__c = logBookDetail.Other_Document__c;
                    details.Sensitive_Customer__c = logBookDetail.Sensitive_Customer__c;
                    
                    if(String.isNotBlank(logBookDetail.Transaction_Type__c)){
                        details.Transaction_Type__c = logBookDetail.Transaction_Type__c;
                        details.Case_Type__c = logBookDetail.Case_Type__c;
                        details.Customer_Mood__c = logBookDetail.Customer_Mood__c;
                        details.Status__c = logBookDetail.Status__c;
                    }
                    
                    // add by Ranti at 13/10/2021
                    // insert data receipt
                    details.Email_Non_PP__c = logBookDetail.Email_Non_PP__c;
                    details.Phone_Non_PP__c = logBookDetail.Phone_Non_PP__c;
                    // details.Type_Sent_E_Receipt__c = logBookDetail.Type_Sent_E_Receipt__c; 
                    details.Email_PP__c = logBookDetail.Email_PP__c;
                    details.Phone_PP__c = logBookDetail.Phone_PP__c;
                    

                    //Add by Mario at 02/05/2025 EUONIA
                    system.debug('Dokumen Tambahan : ' + selectedDokumen);
                    system.debug('Dokumen Tambahan : ' + selectedForm);
                    details.Dokumen_Tambahan__c = selectedDokumen.Replace(', ', ';');
                    details.Form_Tambahan__c = selectedForm.Replace(', ', ';');
                    // 
                    details.Form_Utama__c = logBookDetail.Form_Utama__c;
                    if(isTanpaFormUtama!=null){
                        details.Input_Form_Utama__c = !isTanpaFormUtama;
                        system.debug('isTanpaFormUtama:'+details.Input_Form_Utama__c);
                    }
                    if(isEform == TRUE) details.EForm__c = True;
                    System.debug('detail dari log book :'+logBookDetail);
                    // Faizir 20210804 , add duplicate validation New Complaint / New CHS
                    // Start
                    List<Case> checkCases = new List<Case>([Select ID, CaseNumber from Case where policy_numbers__c = :details.Policy_Number__c and Type = :TRX_TYPE_COMPLAINT and Status != 'Closed']);
                    List<String> caseNames = new List<String>();
                    if(checkCases.size() > 0 && logBookDetail.Transaction_Type__c == TRX_TYPE_COMPLAINT && (logBookDetail.Status__c == 'New' || logBookDetail.Status__c == '' || logBookDetail.Status__c == null)){
                        for(Case casesCheck : checkCases){
                            caseNames.add(casesCheck.CaseNumber);
                        }
                        ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'Sudah ada Case yang sedang berjalan dengan Nomor Case : '+caseNames));
                        return pg;
                        // END
                    }else{
                        
                        // Existing process
                        saveProcess(details);
                        listDetail.add(details); 
                        
                        logBookDetail = new Log_Book_Activitiy_Detail__c(
                            Stamp__c=0, Department__c = null, 
                            Kind_Of_Transaction__c=null, 
                            Document__c=null, 
                            Transaction_Type__c = null, 
                            Case_Type__c = null,
                            Document_Information__c = null
                        );
                        
                        
                        cs = new Case();
                        listDocument = new List<String>();
                        docInformation = new String []{};
                    }    
                }
                
                pg = Page.CreateLogBookActivitiy;
                pg.setRedirect(true);
                pg.getParameters().put('type','Walk-In');
                pg.getParameters().put('logbookactivitiyid',logBook.Id);
                pg.getParameters().put('policyNo',contactPolicyNo);
                pg.getParameters().put('tabletEmail',TabletEmail);
                pg.getParameters().put('editQ',String.valueof(isEditQueue)); 
        		System.debug(':::::::: TIME SERVED String: ' + String.valueOf(logBook.Time_Served__c));
                pg.getParameters().put('timeServed', String.valueOf(logBook.Time_Served__c));
                pg.getParameters().put('editQTimeServed', String.valueOf(editQTimeServed));
                pg.getParameters().put('identityValResult', identityValResult);
                pg.getParameters().put('isIdentityValidated', String.valueOf(isIdentityValidated));
                pg.getParameters().put('isIdValPossitive', String.valueOf(isIdValPossitive));
                //Mario EUONIA PROJ
                string linkForm = System.label.AMFS_Link_EFORM + logBook.Id+'&queue='+logBook.Queue_No__c;
                pg.getParameters().put('linkEform', linkForm);
                pg.getParameters().put('helpText', 'Belum Send to DIPCAD');
            }
        }catch(Exception ex){
            String errorMessage =  ex.getStackTraceString() + ' || ' + ex.getTypeName() + ' || ' + ex.getMessage();
            System.debug(errorMessage);
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_CREATE_FAILED));
        }
        indexDoc = 0;
        mapDocInfo.clear();
        isMultiple = false;
        // return null;
        System.debug(':::::::: TIME SERVED4: ' + logBook.Time_Served__c);
        return pg;
    }
    
    // added by Yazid 22-05-2025
    /**
     * @description 
     * Sama seperti AddPolicy namun ini digunakan untuk button Save & New Transaction
     * semua yang ingin di autopopulate disimpan dalam parameter : getParameters().put()
     * ketika sudah di simpan dalam paramter akan di cek terlebih dahulu lewat Constructor
     * agar auto populate dan User tidak mengisi kembali
     * @author Other edited by Yazid
     * @date 26-05-2025
     */
    public PageReference addPolicyandAutoPopulate(){
        System.debug('=============== ADD PROCESS LOGBOOK ============= ');
        System.debug(':::::::: TIME SERVED3: ' + logBook.Time_Served__c);
        PageReference pg = null;
        try{
            logBookDetail.Document_Information__c = generateDocumentInformation(mapDocInfo);

            if(additionalValidation()){
                
                System.debug(' == = = body:'+attachmentStrBody);
                System.debug(' == = = NAME:'+attachmentStrName);
                System.debug(' == = = TYPE:'+attachmentStrType);
                
                System.debug('LogBookActivityController isMultiple Populate status: '+isMultiple);
                
                // added by Ranti add multiple transaction
                if (isMultiple == true) { 
                    
                    system.debug('multiple save!!!!');
                    String[] caseTypes = selectedCaseTypeKeeper.split('<br />');
                    
                    system.debug('caseTypes:'+selectedCaseTypeKeeper);
                    list<Log_Book_Activitiy_Detail__c> logbookdetails = new list<Log_Book_Activitiy_Detail__c>();
                    for (String row : caseTypes) { 
                        Log_Book_Activitiy_Detail__c details = new Log_Book_Activitiy_Detail__c();
                        details.Policy_Number__c = logBookDetail.Policy_Number__c;
                        details.Contact_Policy__c = logBookDetail.Contact_Policy__c;
                        details.Is_Non_Customer__c = isValidCustomer ? logBookDetail.Is_Non_Customer__c : true;
                        details.Policy_Name_Holder__c = logBookDetail.Policy_Name_Holder__c;
                        details.Product_Type__c = logBookDetail.Product_Type__c;
                        details.Customer_Name__c = isValidCustomer ? logBookDetail.Customer_Name__c : row;
                        details.Customer_Relation__c = (isValidCustomer && !logBookDetail.Is_Policy_Holder__c) ? logBookDetail.Customer_Relation__c : DEFAULT_CUSTOMER_RELATION;
                        system.debug('IS POLICY HOLDER: ' + logBookDetail.Is_Policy_Holder__c + logBookDetail.Id);
                        details.Is_Policy_Holder__c = logBookDetail.Is_Policy_Holder__c;
                        details.Segmentation__c = isValidCustomer ? logBookDetail.Segmentation__c : DEFAULT_SEGMENTATION;
                        details.Need_CR__c = logBookDetail.Need_CR__c;
                        details.Department__c = logBookDetail.Department__c;
                        details.Kind_Of_Transaction__c = row;
                        details.Document_Type__c = logBookDetail.Document_Type__c;
                        details.Document__c = logBookDetail.Document__c;
                        details.Stamp__c = logBookDetail.Stamp__c;
                        details.Remarks_Long_Text__c = isValidCustomer ? logBookDetail.Remarks_Long_Text__c : row;
                        details.Document_Information__c = logBookDetail.Document_Information__c;
                        details.Other_Document__c = logBookDetail.Other_Document__c;
                        details.Sensitive_Customer__c = logBookDetail.Sensitive_Customer__c; 
                        details.Transaction_Type__c = logBookDetail.Transaction_Type__c;
                        details.Case_Type__c = logBookDetail.Case_Type__c;
                        details.Customer_Mood__c = logBookDetail.Customer_Mood__c; 
                        details.Status__c = logBookDetail.Status__c; 
                        
                        // add by Ranti at 13/10/2021
                        // insert data receipt
                        details.Email_Non_PP__c = logBookDetail.Email_Non_PP__c;
                        details.Phone_Non_PP__c = logBookDetail.Phone_Non_PP__c;
                        // details.Type_Sent_E_Receipt__c = logBookDetail.Type_Sent_E_Receipt__c; 
                        details.Email_PP__c = logBookDetail.Email_PP__c;
                        details.Phone_PP__c = logBookDetail.Phone_PP__c;

                        // add by Yazid at 13/08/2025
                        // 
                        // details.Form_Utama__c = logBookDetail.Form_Utama__c;
                        // if(isTanpaFormUtama!=null){
                        //     details.Input_Form_Utama__c = !isTanpaFormUtama;
                        //     system.debug('isTanpaFormUtama Save&New:'+details.Input_Form_Utama__c);
                        // }

                        saveIsPolicyHolder = details.Is_Policy_Holder__c;
                        saveCustomerName = details.Customer_Name__c;
                        saveCustomerRelation = details.Customer_Relation__c;
                        saveEmailNonPP = details.Email_Non_PP__c;
                        savePhoneNonPP = details.Phone_Non_PP__c;
                        saveDescription = details.Remarks_Long_Text__c;
                        
                        logbookdetails.add(details);
                        listDetail.add(details); 
                    }
                    
                    system.debug('logbookdetails:'+logbookdetails);
                    
                    saveProcessMultiple(logbookdetails);
                } else {
                    // added by ranti at 10/22/2021
                    List<String> bodyAttachments = new List<String>();
                    List<String> nameAttachments = null;
                    List<String> typeAttachments = null;
                    if (attachmentStrBody != null && attachmentStrBody != '') {
                        RowIteratorUtil rowIterator = new RowIteratorUtil(attachmentStrBody, ','); 
                        nameAttachments = (List<String>) JSON.deserialize(attachmentStrName, List<String>.class);
                        typeAttachments = (List<String>) JSON.deserialize(attachmentStrType, List<String>.class);
                        
                        while (rowIterator.hasNext()) {
                            bodyAttachments.add(rowIterator.next());
                        }
                    }
                    
                    
                    if (bodyAttachments != null && bodyAttachments.size() > 0) {
                        for (Integer i = 0; i < bodyAttachments.size(); i++) {
                            attachment attach = new attachment();
                            Blob bodyAtt = EncodingUtil.base64Decode(bodyAttachments[i]); 
                            attach.Name = nameAttachments[i]; 
                            attach.ContentType = typeAttachments[i]; 
                            attach.Body = bodyAtt; 
                            newAttachments.add(attach);
                        }
                    }
                    
                    System.debug('=============== Attachment: '+newAttachments);
                    System.debug('=============== Attachment Size: '+newAttachments.size());
                    
                    Log_Book_Activitiy_Detail__c details = new Log_Book_Activitiy_Detail__c();
                    details.Policy_Number__c = logBookDetail.Policy_Number__c;
                    details.Contact_Policy__c = logBookDetail.Contact_Policy__c;
                    details.Is_Non_Customer__c = isValidCustomer ? logBookDetail.Is_Non_Customer__c : true;
                    details.Policy_Name_Holder__c = logBookDetail.Policy_Name_Holder__c;
                    details.Product_Type__c = logBookDetail.Product_Type__c;
                    details.Customer_Name__c = isValidCustomer ? logBookDetail.Customer_Name__c : logBookDetail.Kind_Of_Transaction__c;
                    details.Customer_Relation__c = (isValidCustomer && !logBookDetail.Is_Policy_Holder__c) ? logBookDetail.Customer_Relation__c : DEFAULT_CUSTOMER_RELATION;
                    details.Is_Policy_Holder__c = logBookDetail.Is_Policy_Holder__c;
                    details.Segmentation__c = isValidCustomer ? logBookDetail.Segmentation__c : DEFAULT_SEGMENTATION;
                    details.Need_CR__c = logBookDetail.Need_CR__c;
                    details.Department__c = logBookDetail.Department__c;
                    details.Kind_Of_Transaction__c = logBookDetail.Kind_Of_Transaction__c;
                    details.Document_Type__c = logBookDetail.Document_Type__c;
                    details.Document__c = logBookDetail.Document__c;
                    details.Stamp__c = logBookDetail.Stamp__c;
                    details.Remarks_Long_Text__c = isValidCustomer ? logBookDetail.Remarks_Long_Text__c : logBookDetail.Kind_Of_Transaction__c;
                    details.Document_Information__c = logBookDetail.Document_Information__c;
                    details.Other_Document__c = logBookDetail.Other_Document__c;
                    details.Sensitive_Customer__c = logBookDetail.Sensitive_Customer__c;
                    
                    if(String.isNotBlank(logBookDetail.Transaction_Type__c)){
                        details.Transaction_Type__c = logBookDetail.Transaction_Type__c;
                        details.Case_Type__c = logBookDetail.Case_Type__c;
                        details.Customer_Mood__c = logBookDetail.Customer_Mood__c;
                        details.Status__c = logBookDetail.Status__c;
                    }
                    
                    // add by Ranti at 13/10/2021
                    // insert data receipt
                    details.Email_Non_PP__c = logBookDetail.Email_Non_PP__c;
                    details.Phone_Non_PP__c = logBookDetail.Phone_Non_PP__c;
                    // details.Type_Sent_E_Receipt__c = logBookDetail.Type_Sent_E_Receipt__c; 
                    details.Email_PP__c = logBookDetail.Email_PP__c;
                    details.Phone_PP__c = logBookDetail.Phone_PP__c;
                    
                    // add by Yazid at 13/08/2025
                    details.Form_Utama__c = logBookDetail.Form_Utama__c;
                    if(isTanpaFormUtama!=null){
                        details.Input_Form_Utama__c = !isTanpaFormUtama;
                        system.debug('isTanpaFormUtama Save&New:'+details.Input_Form_Utama__c);
                    }

                    saveIsPolicyHolder = details.Is_Policy_Holder__c;
                    saveCustomerName = details.Customer_Name__c;
                    saveCustomerRelation = details.Customer_Relation__c;
                    saveEmailNonPP = details.Email_Non_PP__c;
                    savePhoneNonPP = details.Phone_Non_PP__c;
                    saveDescription = details.Remarks_Long_Text__c;
                    system.debug('AMFS saveIsPolicyHolder: ' + saveIsPolicyHolder);
                    system.debug('AMFS customerName: ' + saveCustomerName + '-' + saveCustomerRelation);
                    system.debug('AMFS emailPhoneNonPP: ' + saveEmailNonPP + '-' + savePhoneNonPP);
                    system.debug('AMFS csSubject Desc isPolicyHolder: ' + saveCSSubject + '-' + saveDescription +'-'+saveIsPolicyHolder);
                    //Add by Mario at 02/05/2025 EUONIA
                    system.debug('Dokumen Tambahan : ' + selectedDokumen);
                    system.debug('Dokumen Tambahan : ' + selectedForm);
                    details.Dokumen_Tambahan__c = selectedDokumen.Replace(', ', ';');
                    details.Form_Tambahan__c = selectedForm.Replace(', ', ';');
                    if(isEform == TRUE) details.EForm__c = True;
                    
                    

                    System.debug('detail dari log book :'+logBookDetail);
                    // Faizir 20210804 , add duplicate validation New Complaint / New CHS
                    // Start
                    List<Case> checkCases = new List<Case>([Select ID, CaseNumber from Case where policy_numbers__c = :details.Policy_Number__c and Type = :TRX_TYPE_COMPLAINT and Status != 'Closed']);
                    List<String> caseNames = new List<String>();
                    if(checkCases.size() > 0 && logBookDetail.Transaction_Type__c == TRX_TYPE_COMPLAINT && (logBookDetail.Status__c == 'New' || logBookDetail.Status__c == '' || logBookDetail.Status__c == null)){
                        for(Case casesCheck : checkCases){
                            caseNames.add(casesCheck.CaseNumber);
                        }
                        ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'Sudah ada Case yang sedang berjalan dengan Nomor Case : '+caseNames));
                        return pg;
                        // END
                    }else{
                        
                        // Existing process
                        saveProcess(details);
                        listDetail.add(details); 
                        
                        logBookDetail = new Log_Book_Activitiy_Detail__c(
                            Stamp__c=0, Department__c = null, 
                            Kind_Of_Transaction__c=null, 
                            Document__c=null, 
                            Transaction_Type__c = null, 
                            Case_Type__c = null,
                            Document_Information__c = null
                            
                        );
                        
                        
                        cs = new Case();
                        listDocument = new List<String>();
                        docInformation = new String []{};
                    }    
                }
                
                pg = Page.CreateLogBookActivitiy;
                pg.setRedirect(true);
                pg.getParameters().put('type','Walk-In');
                pg.getParameters().put('logbookactivitiyid',logBook.Id);
                pg.getParameters().put('policyNo',contactPolicyNo);
                pg.getParameters().put('policyId',saveSearchPolicyId);
                pg.getParameters().put('policyNumber',savePolicyNumber);
                pg.getParameters().put('tabletEmail',TabletEmail);
                pg.getParameters().put('emailP',saveEmailPP);
                pg.getParameters().put('telpP',saveNoTelpPP);
                pg.getParameters().put('nameHolderP',savePolicyNameHolder);
                pg.getParameters().put('editQ',String.valueof(isEditQueue)); 
        		System.debug(':::::::: TIME SERVED String: ' + String.valueOf(logBook.Time_Served__c));
                pg.getParameters().put('timeServed', String.valueOf(logBook.Time_Served__c));
                pg.getParameters().put('editQTimeServed', String.valueOf(editQTimeServed));
                pg.getParameters().put('identityValResult', identityValResult);
                pg.getParameters().put('isIdentityValidated', String.valueOf(isIdentityValidated));
                pg.getParameters().put('isIdValPossitive', String.valueOf(isIdValPossitive));
                pg.getParameters().put('identityNo', String.valueOf(identityNo));
                pg.getParameters().put('productType', saveProductType);
                
                pg.getParameters().put('customerName', saveCustomerName);
                pg.getParameters().put('customerRelation', saveCustomerRelation);
                pg.getParameters().put('emailNonPP', saveEmailNonPP);
                pg.getParameters().put('phoneNonPP', savePhoneNonPP);
                pg.getParameters().put('csSubject', saveCSSubject);
                pg.getParameters().put('description', saveDescription);

                system.debug('SAVE IS POLICY HOLDER: ' + saveIsPolicyHolder);
                pg.getParameters().put('isPolicyHolder', String.valueOf(saveIsPolicyHolder));
                pg.getParameters().put('logBookDetailId', String.valueOf(logBookDetail.Id));
                string linkForm = System.label.AMFS_Link_EFORM + logBook.Id+'&queue='+logBook.Queue_No__c;
                
                system.debug('LINK EFORM: ' + linkForm);
                pg.getParameters().put('linkEform', linkForm);
                pg.getParameters().put('helpText', 'Belum Send to DIPCAD');

                
            }
        }catch(Exception ex){
            String errorMessage =  ex.getStackTraceString() + ' || ' + ex.getTypeName() + ' || ' + ex.getMessage();
            System.debug(errorMessage);
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_CREATE_FAILED));
        }
        indexDoc = 0;
        mapDocInfo.clear();
        isMultiple = false;
        // return null;
        System.debug(':::::::: TIME SERVED4: ' + logBook.Time_Served__c);
        return pg;
    }

    /**
     * @description 
     * Untuk tombol done dilogbook, ketika done maka akan menghitung waktu
     * @author Other edited by Yazid
     * @date 26-05-2025
     */
    public PageReference done(){
        System.debug('=============== DONE PROCESS LOGBOOK ============= ');
        System.debug(':::::::: TIME SERVED5: ' + logBook.Time_Served__c);
        PageReference pg = null;
        
        List<Id> lbadIds = new List<Id>();
        List<Id> cdIds = new List<Id>();
        try{
            System.debug('logBook = '+logBook);
            ID idParent = logBook.Id;
            if(idParent != null){
                logBook.Time_Out__c = DateTime.now().time();
                
                Time timeIn = logBook.Time_In__c;
                Time timeServed = logbook.Time_Served__c;
                Time timeOut = logBook.Time_Out__c;
                
                System.debug('Time In = '+timeIn+', Time Served = '+timeServed+', Time Out = '+timeOut);
                system.debug('Time Served EditQ = '+editQTimeServed+', Init Time EditQ = '+logBook.Handling_Time__c);
                List<Log_Book_Activitiy_Detail__c> lbads = [SELECT Id FROM Log_Book_Activitiy_Detail__c WHERE Log_Book_Activitiy__r.Id =:logBook.Id AND EForm__c = true AND Canceled__c = false];
                for(Log_Book_Activitiy_Detail__c lbad:lbads){
                    lbadIds.add(lbad.Id);
                }
                if(!lbadIds.isEmpty()){
                    List<ContentDocumentLink> listCDL = [SELECT Id,LinkedEntityId, ContentDocumentId, ContentDocument.Title FROM ContentDocumentLink WHERE LinkedEntityId IN :lbadIds AND ContentDocument.Title LIKE '%Tanda Tangan%'];
                    for(ContentDocumentLink cdid : listCDL){
                        cdIds.add(cdid.ContentDocumentId);
                    }
                }
                if(!cdIds.isEmpty()){
                    system.debug('##### Log Book Detail Id =' +lbadIds);
                    system.debug('##### Content Document Id =' +cdIds);
                    List<ContentDocument> cds = [SELECT Id FROM ContentDocument WHERE Id IN: cdIds];
                    for(ContentDocument i : cds){
                        system.debug('#####=' +i);
                        delete i;
                    }
                }
                logBook.Waiting_Time__c = getDuration(timeIn, timeServed);
                //logBook.Handling_Time__c = getDuration(timeServed, timeOut);
                String tempHandlingTime = '';
                if(isEditQueue){
                    if(logBook.Handling_Time__c!=null){
                        tempHandlingTime = getDurationWithInit(editQTimeServed, timeOut, logBook.Handling_Time__c);
                    }else{
                        tempHandlingTime = getDuration(timeServed, timeOut);
                    }
                }else{
                    tempHandlingTime = getDuration(timeServed, timeOut);
                }
                logBook.Handling_Time__c = tempHandlingTime;
                // logBook.Handling_Time__c = isEditQueue ? getDurationWithInit(editQTimeServed, timeOut, logBook.Handling_Time__c) : getDuration(timeServed, timeOut);
                // Waiting Time Not Achieved : Sum If Waiting Time > 5 Minute 
                Integer waitingDuration = getDurationByMinute(logBook.Waiting_Time__c);
                // if(waitingDuration != null && waitingDuration > 5){
                if(waitingDuration != null && waitingDuration > 5 && isEditQueue == false){
                    logBook.Waiting_Time_Not_Achieved__c = true;
                }
                
                // Handling Time Not Achieved : Sum If Handling Time > 20 Minute
                Integer handlingDuration = getDurationByMinute(logBook.Handling_Time__c);
                // if(handlingDuration != null && handlingDuration > 20){
                if(handlingDuration != null && handlingDuration > 20 && isEditQueue == false){
                    logBook.Handling_Time_Not_Achieved__c = true;
                }
                
                // Generate Batch
                logBook.Batch__c = getBatchNow();
                logBook.NIK_Verify_Result__c = identityValResult;
                string linkForm = System.label.AMFS_Link_EFORM + logBook.Id +'&queue='+logBook.Queue_No__c;
                logBook.Link_E_Form__c = linkForm;
                
                logBook.Expired__c = true;
        		System.debug(':::::::: TIME SERVED6: ' + logBook.Time_Served__c);
                update logBook;
            }
            clear();
            pg = Page.LogBookActivitiy;
        }catch(Exception ex){
            String errorMessage =  ex.getStackTraceString() + ' || ' + ex.getTypeName() + ' || ' + ex.getMessage();
            System.debug(errorMessage);
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_CREATE_FAILED));
        }
        indexDoc = 0;
        mapDocInfo.clear();
        System.debug(':::::::: TIME SERVED7: ' + logBook.Time_Served__c);
        return pg;
    }
    
    private void saveProcess(Log_Book_Activitiy_Detail__c detailData){
        System.debug('=============== SAVING PROCESS LOGBOOK ============= ');
        System.debug('logbook activitiy master = '+logBook);
        ID idParent = logBook.Id;
        if(idParent == null){
            Database.SaveResult result = Database.insert(logBook);
            idParent = result.id;
        } 
        
        detailData.Log_Book_Activitiy__c = idParent;
        insert detailData;
        if(detailData.id != null && String.isNotBlank(logBookDetail.Transaction_Type__c)){
            insertCase(prepareCaseData(detailData, cs));   
            
            newAttachments.clear();
            newAttachments = new List<Attachment>{new Attachment()};  
                
            attachIsInsert = false;
            isAttach = false;
            firstEmailContact = null;
            firstNumberContact = null; 
            
            attachmentStrBody = null;
            attachmentStrName = null;
            attachmentStrType = null;
        }
        
    } 
    
    
    
    private void saveProcessMultiple(List<Log_Book_Activitiy_Detail__c> detailData){
        System.debug('=============== SAVING PROCESS LOGBOOK ============= ');
        System.debug('logbook activitiy master = '+logBook);
        ID idParent = logBook.Id;
        if(idParent == null){
            Database.SaveResult result = Database.insert(logBook);
            idParent = result.id;
        } 
        
        List<Case> insertCase = new List<Case>();
        for (Log_Book_Activitiy_Detail__c row : detailData) {
            row.Log_Book_Activitiy__c = idParent;
        }  
        insert detailData;
        
        List<Log_Book_Activitiy_Detail__c> getDetailData = [select id, Case_Type__c,Status__c, Is_Policy_Holder__c,Email_Non_PP__c,Phone_Non_PP__c,Kind_Of_Transaction__c,
                                                            Contact_Policy__c,Is_Non_Customer__c, Remarks_Long_Text__c,Customer_Mood__c, Transaction_Type__c, Policy_Number__c
                                                            from Log_Book_Activitiy_Detail__c where Log_Book_Activitiy__c =:idParent and log_case__c = null];
        
        Map<String, string> mapLbaDetails = new Map<String, string>();
        for( Log_Book_Activitiy_Detail__c row : getDetailData) {
            mapLbaDetails.put(row.Kind_Of_Transaction__c, row.id);
        }
        
        Log_Book_Activitiy__c[] logbook = [SELECT ID, Type__c FROM Log_Book_Activitiy__c WHERE id = :idParent LIMIT 1]; 
        String logbookType = '';
        if(logBook != null && logBook.size() > 0){
            logbookType = logBook[0].Type__c;
        }
        
        // collect all transaction and put on temporary map
        if (getDetailData.size() > 0 ) {
            String[] caseTypes = new List<String>();
            Case logCase = new Case();
            for (Log_Book_Activitiy_Detail__c lbaDetail : getDetailData) {
                String subject;
                string contactid;
                
                //Log_Book_Activitiy_Detail__c lbaDetail = getDetailData[0];
                
                boolean nonCust = lbaDetail.Is_Non_Customer__c;
                string policyNo = lbaDetail.Policy_Number__c;
                
                if(!(nonCust)){
                    Contact[] resultContact = [SELECT id, Sensitive_Customer__c FROM Contact WHERE Policy_No__c = :policyNo LIMIT 1];
                    if(resultContact.size() > 0){
                        contactid = resultContact[0].id;
                        contacts = resultContact[0];
                    }
                    subject = policyNo;
                } else {
                    Contact[] resultContactWithLbaPolNo = [SELECT id, Sensitive_Customer__c FROM Contact WHERE Policy_No__c = :policyNo LIMIT 1];
                    if(resultContactWithLbaPolNo.size() > 0){
                        contactid = resultContactWithLbaPolNo[0].id;
                        contacts = resultContactWithLbaPolNo[0];
                        subject = policyNo;
                    } else {
                        Contact[] resultContact = [SELECT ID, Name FROM Contact WHERE Name = :NON_CUSTOMER LIMIT 1];
                        if(resultContact.size() > 0){
                            contactid = resultContact[0].id;
                        }
                        subject = NON_CUSTOMER;
                    }
                } 
                
                saveCSSubject = subject; // save auto populate
                system.debug('saveCSSubject:'+saveCSSubject);
                system.debug('cs.RecordTypeId:'+cs.RecordTypeId);
                
                logCase.recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(RECORD_TYPE_INQUIRY_CASE).getRecordTypeId(); 
                system.debug('logCase.recordTypeId:'+logCase.recordTypeId);
                
                logCase.status = lbaDetail.Status__c;
                logCase.ContactId  = contactid; 
                logCase.Subject  = Subject; 
                logCase.Origin  = logbookType;  
                logCase.Description = lbaDetail.Remarks_Long_Text__c;
                logCase.NonPP__c = !(lbaDetail.Is_Policy_Holder__c);
                if(!(logCase.NonPP__c)){
                    logCase.General_Attitude__c = lbaDetail.Customer_Mood__c;
                }
                
                logCase.Case_Type__c = lbaDetail.Case_Type__c;
                logCase.Type = lbaDetail.Transaction_Type__c;
                logCase.Courier__c = cs.Courier__c;
                
                //caseTypes.add(lbaDetail.Kind_Of_Transaction__c);
                caseTypes.add(lbaDetail.Case_Type__c);
                //String cType = logBookDetail.Kind_Of_Transaction__c;
            }
            // end collect all transaction
            
            // create case for all transaction and put on temporary map
            Map<String,String> mapCase = new map<String, String>();
            CaseServiceController caseService = new CaseServiceController();
            List<Case> result = caseService.processInquirySaveWithClosedStatus(logCase, caseTypes);
            if(result != null && result.size() > 0){
                for (Case row : result) {
                    mapCase.put( row.Case_Type_Config__c, row.id );
                }
            }
            
            // get case id dedicated for lbaId based on transaction type/Case Type
            list<Log_Book_Activitiy_Detail__c> updateLbaDetails = new List<Log_Book_Activitiy_Detail__c>();
            for (String key: mapCase.keySet()) {
                if(mapLbaDetails.containsKey(key)) {
                    Log_Book_Activitiy_Detail__c logBookDetail = new Log_Book_Activitiy_Detail__c(
                        id = mapLbaDetails.get(key),
                        Log_Case__c = mapCase.get(key));
                    
                    updateLbaDetails.add(logBookDetail);
                }
            }
            
            if (checkCourier == true) {            
                logCase.Courier__c = cs.Courier__c; 
            }            
            update updateLbaDetails;
        }
        logBookDetail = new Log_Book_Activitiy_Detail__c();
    } 
    
    
    private String prepareCaseData(Log_Book_Activitiy_Detail__c lbaDetail, Case lbaCase){
        System.debug('=============== PREPARE CASE ============= ');
        String trxType = lbaDetail.Transaction_Type__c;
        System.debug('logbook activity detail = '+lbaDetail);
        System.debug('logbook activitiy case = '+lbaCase);
        
        Log_Book_Activitiy__c[] logbook = [SELECT ID, Type__c FROM Log_Book_Activitiy__c WHERE id = :lbaDetail.Log_Book_Activitiy__c LIMIT 1];
        String logbookType = '';
        if(logBook != null && logBook.size() > 0){
            logbookType = logBook[0].Type__c;
        }
        
        CaseData csData = new CaseData();
        csData.logBookId = String.valueOf(lbaDetail.id);
        csData.recordTypeId = cs.RecordTypeId;
        csData.caseType = lbaDetail.Case_Type__c;
        csData.transactionType = trxType;                
        csData.status = lbaDetail.Status__c;
        csData.origin = logbookType;
        csData.nonPP = !(lbaDetail.Is_Policy_Holder__c);
        
        // add by Ranti at 10/14/2021
        if (lbaDetail.Department__c == 'CMU' && lbaDetail.Kind_Of_Transaction__c == 'Complaint' && cs.Complaint_type__c == 'Soft Complaint' ) {
            csData.status = 'Closed';
        }
        
        // add by Ranti at 10/14/2021
        // add sent receipt
        csData.emailNonPPReceipt = lbaDetail.Email_Non_PP__c;
        csData.PhoneNonPPReceipt = lbaDetail.Phone_Non_PP__c;
        // csData.typeSentReceipt = lbaDetail.Type_Sent_E_Receipt__c;
        csData.contactPolicy = lbaDetail.Contact_Policy__c;
        
        if(!(lbaDetail.Is_Non_Customer__c)){
            Contact[] resultContact = [SELECT id, Sensitive_Customer__c FROM Contact WHERE Policy_No__c = :lbaDetail.Policy_Number__c LIMIT 1];
            if(resultContact.size() > 0){
                csData.ContactId = resultContact[0].id;
                contacts = resultContact[0];
            }
            csData.Subject = lbaDetail.Policy_Number__c;
        } else {
            Contact[] resultContactWithLbaPolNo = [SELECT id, Sensitive_Customer__c FROM Contact WHERE Policy_No__c = :lbaDetail.Policy_Number__c LIMIT 1];
            if (resultContactWithLbaPolNo.size() > 0) {
                csData.ContactId = resultContactWithLbaPolNo[0].id;
                contacts = resultContactWithLbaPolNo[0];
                csData.Subject = lbaDetail.Policy_Number__c;
            } else {
                Contact[] resultContact = [SELECT ID, Name FROM Contact WHERE Name = :NON_CUSTOMER LIMIT 1];
                if(resultContact.size() > 0){
                    csData.ContactId = resultContact[0].id;
                }
                csData.Subject = NON_CUSTOMER;
            }
        }
        
        if (string.isNotBlank(cs.Subject)) {
            csData.subject = cs.Subject;
            saveCSSubject = cs.Subject;
        }
        
        csData.description = lbaDetail.Remarks_Long_Text__c;
        if(!(csData.nonPP)){
            csData.generalAttitude = lbaDetail.Customer_Mood__c;
        }
        
        if(TRX_TYPE_COMPLAINT == trxType){
            csData.nature = lbaCase.Nature_Config__c;
            csData.category = lbaCase.Category_Config__c;
            csData.businessChannel = lbaCase.Business_channel__c;
            csData.cutomer = CUSTOMER;
            csData.complainant = CUSTOMER;
            csData.channel = logbookType;
            csData.customerType = lbaCase.Customer_type__c;
            csData.product = lbaCase.Product__c;
            csData.complaintType = lbaCase.Complaint_type__c;
            csData.priority = lbaCase.Priority;
            csData.complaintDetail = lbaCase.Description__c;
            csData.description = lbaDetail.Remarks_Long_Text__c;
            csData.receivedDate = Date.today();
            csData.appeal = lbaCase.Appeal__c;
        }
        
        
        system.debug('lbaDetail:'+lbaDetail);
        
        if (lbaDetail.Kind_Of_Transaction__c == 'Request_Add Debit' || 
            lbaDetail.Kind_Of_Transaction__c == 'Request_Auto Reinstate' || 
            lbaDetail.Kind_Of_Transaction__c == 'Request_Hold Debit')  {
            
            csData.Amount_to_be_Debited = cs.Amount_to_be_Debited__c;
            csData.Account_Number = cs.Account_Number__c;
            csData.Follow_Debit_Date = cs.Follow_Debit_Date__c;
            csData.Follow_Hold_Date = cs.Follow_Hold_Date__c;
        }   
        csData.courier = lbaCase.Courier__c;
        
        // add by Ranti at 10/10/2021 set list attach from newAttachment
        List<attachmentData> addAttach = new List<attachmentData>();
        
        for(attachment a: newAttachments) {
            if (a.name != '' && a.body != null) {
                attachmentData attach = new attachmentData();
                attach.body = EncodingUtil.base64Encode(a.body);
                attach.name = a.name;
                addAttach.add(attach);
            }
        }  
        // add by Ranti at 10/10/2021 set insert attach
        csData.AttachCase = addAttach; 
        
        csData.parentIdAttach = String.valueOf(parentIdAttachment);
        csData.createdByAttach = String.valueOf(parentIdCreated);
        // csData.AttachCase = newAttachments;
        
        
        System.debug('caseDataObject = '+csData);
        String caseDataJSON = (String) System.JSON.serialize(csData, true);
        System.debug('caseDataJSON = '+caseDataJSON); 
        return caseDataJSON;
    }
    
    //@future //:commented by Ichwan 11/14/20224 to avoid multiple async process from Trigger_CustomizeCase 
    private static void insertCase(String caseDataJSON){
        System.debug('============================= INSERT CASE ===============================');
        try{
            System.debug('caseDataJSON = '+caseDataJSON);
            if(String.isNotBlank(caseDataJSON)){
                CaseData csdata = (CaseData) System.JSON.deserialize(caseDataJSON, CaseData.class);
                System.debug('caseDataObject = '+csdata);
                System.debug('=== Trx Type:'+csdata.transactionType);
                system.debug('======== LogBookId : '+csdata.logBookId);
                system.debug('======== LogBookId CaseType : '+csdata.CaseType);
                
                
                if(String.isNotBlank(csdata.logBookId)){
                    String trxType = csdata.transactionType;
                    
                    Case logCase = new Case();
                    logCase.RecordTypeId = csdata.recordTypeId;
                    logCase.ContactId = csdata.ContactId;
                    logCase.Subject = csdata.subject;
                    logCase.Origin = csdata.origin;
                    logCase.NonPP__c = csdata.nonPP;
                    logCase.General_Attitude__c = csdata.generalAttitude;
                    logCase.Case_Type__c = logCase.Case_Type_Config__c = logCase.Request_Type__c = csdata.CaseType;
                    logCase.Type = csdata.transactionType;
                    logCase.Appeal__c = csdata.appeal;
                    
                    if (csdata.status == 'Closed') {
                        logCase.status = 'Closed';
                    }
                    
                    system.debug('== trx Type:'+trxType);          
                    
                    // add by Ranti at 10/14/2021
                    // add sent e-receipt
                    logCase.Email_Non_PP__c = csdata.emailNonPPReceipt;
                    logCase.Phone_Non_PP__c = csdata.PhoneNonPPReceipt;
                    // logCase.Type_Sent_E_Receipt__c = csdata.typeSentReceipt;
                    
                    CaseServiceController caseService = new CaseServiceController();
                    Case resultSave = null;
                    if(TRX_TYPE_INQUIRY == trxType){
                        logCase.Description = csdata.description;
                        List<Case> result = caseService.processInquirySaveWithClosedStatus(logCase, new String[]{csdata.CaseType});
                        if(result != null && result.size() > 0){
                            resultSave = result.get(0);
                        }
                    }else if(TRX_TYPE_REQUEST == trxType){
                        logCase.Description = csdata.description;                
                        logCase.Status = csdata.status;
                        logCase.Courier__c = csData.courier;
                        logCase.Request_Type__c = csdata.CaseType;  //tambahan 14/09/2020
                        
                        logCase.Amount_to_be_Debited__c = csData.Amount_to_be_Debited;
                        logCase.Account_Number__c = csData.Account_Number;
                        logCase.Follow_Debit_Date__c = csData.Follow_Debit_Date;
                        logCase.Follow_Hold_Date__c = csData.Follow_Hold_Date;
                        
                        resultSave = caseService.processRequestSave(logCase, ENTITY_AMFS);
                        
                    }else if(TRX_TYPE_COMPLAINT == trxType){
                        logCase.Nature_Config__c = csdata.nature;
                        logCase.Category_Config__c = csdata.category;
                        logCase.Business_channel__c = csdata.businessChannel;
                        logCase.Customer__c = csdata.cutomer;
                        logCase.Complainant__c = csdata.complainant;
                        logCase.Channel__c = csdata.channel;
                        logCase.Customer_type__c = csdata.customerType;
                        logCase.Product__c = csdata.product;
                        logCase.Complaint_type__c = csdata.complaintType;
                        logCase.Priority = csdata.priority;
                        logCase.Description__c = csdata.complaintDetail;
                        logCase.Description = csdata.description;
                        logCase.Received_date__c = csData.receivedDate;
                        logCase.Courier__c = csData.courier;
                        System.debug('LogBookActivityController: TRX type is: '+trxType+' and logCase: '+logCase);
                        resultSave = caseService.processComplaintSave(logCase, ENTITY_AMFS);
                    }
                    system.debug('======== LogBookId Case resultSave : '+resultSave);
                    if(resultSave != null && resultSave.Id != null) {
                        Log_Book_Activitiy_Detail__c logBookDetail = new Log_Book_Activitiy_Detail__c(
                            id = csdata.logBookId,
                            Log_Case__c = resultSave.Id);
                        update logBookDetail;
                        
                        // add by Ranti at 10/10/2021  insert attach 
                        List<Attachment> listInsertAttachment = new List<Attachment>();
                        //inserting attachments
                        if (csdata.AttachCase.size() > 0) {
                            System.debug(' === Attach Public class: '+csdata.AttachCase);
                            for(attachmentData newAtt: csdata.AttachCase) {
                                if(newAtt.name != '' && newAtt.body != null) {
                                    attachment attach = null;
                                    attach = new attachment(); 
                                    Blob convertBlobAttach = EncodingUtil.base64Decode(newAtt.body); 
                                    attach.body = convertBlobAttach; 
                                    attach.name = newAtt.name;
                                    attach.parentId = resultSave.Id; 
                                    //insert attach ; 
                                    listInsertAttachment.add(attach);
                                }
                            }
                            if(listInsertAttachment.size() > 0) insert listInsertAttachment;
                            
                            
                            /* List<attachment> delAttach = new List<attachment>();
                            delAttach = [select Id, ParentId, Name, body from Attachment where parentId=:csdata.parentIdAttach AND CreatedById = :csdata.createdByAttach AND createdDate = TODAY];
                            if (delAttach.size() > 0) delete delAttach; */
                        }                
                    }
                }  
            }
        }catch(Exception ex){
            String errorMessage =  ex.getStackTraceString() + ' || ' + ex.getTypeName() + ' || ' + ex.getMessage();
            System.debug(errorMessage);
            sentErrorCase(errorMessage, caseDataJSON); 
        }
    }
    // END CREATE
    
    // START EDIT
    public PageReference initEdit(){
        System.debug('==== initEdit() ');
        String recordId = ApexPages.currentPage().getParameters().get(PARAM_ID);
        String state = ApexPages.currentPage().getParameters().get(PARAM_STATE);
        System.debug('==== recordId = '+recordId);
        System.debug('==== state = '+state);
        logBookDetail = [SELECT ID, Log_Case__r.CaseNumber, Log_Book_Activitiy__r.Log_Book_Date__c, Log_Book_Activitiy__r.Touch_Point__c, Log_Book_Activitiy__r.Queue_No__c, 
                         Log_Book_Activitiy__r.CSO_Name__c, Policy_Number__c, Policy_Name_Holder__c, Product_Type__c, Customer_Name__c, Customer_Relation__c,
                         Is_Policy_Holder__c, Segmentation__c, Department__c, Kind_Of_Transaction__c, Document_Type__c, Document__c, Document_Information__c, 
                         Stamp__c, Remarks_Long_Text__c, Notes__c, Transaction_Type__c, Case_Type__c, Customer_Mood__c, Status__c, Need_CR__c, Log_Case__r.Type, 
                         Log_Case__r.Case_Type_Config__c, Log_Case__r.Case_Type__c, Log_Case__r.Subject, Log_Case__r.Description, Log_Case__r.Description__c, 
                         Log_Case__r.Nature_Config__c, Log_Case__r.Category_Config__c, Log_Case__r.PIC_Department_LU__c, Log_Case__r.Status, Other_Document__c, 
                         Contact_Policy__r.Sensitive_Customer__c, Sensitive_Customer__c, email_PP__C, phone_PP__c, is_Non_Customer__c,Email_Non_PP__c,Phone_Non_PP__c
                         FROM Log_Book_Activitiy_Detail__c WHERE ID = :recordId];
        visibleEdit = STATE_EDIT.equals(state);
        visibleDetail = STATE_DETAIL.equals(state);
        
        if(logBookDetail != null){
            if(String.isNotBlank(logBookDetail.Document_Information__c)){
                docInformation = (logBookDetail.Document_Information__c).split(';');
            }
            if(String.isNotBlank(logBookDetail.Other_Document__c)){
                List<String> otherDoc = new List<String>();
                otherDoc = (logBookDetail.Other_Document__c).split(';');
                docInformation.addAll(otherDoc);
            } 
            
            // added by Ranti at 11/24/2021
            if (entityAuth == 'AMFS' && isValidCustomer == true) {
                //if (logBookDetail.Is_Non_Customer__c == true && logBookDetail.Is_Policy_Holder__c == false) {
                if (logBookDetail.Is_Non_Customer__c == true) {
                    showPP = FALSE;
                    showNonPP = TRUE;
                } else {
                    showPP = TRUE;
                    showNonPP = FALSE;
                }
            } 
        }
        
        
        return null;
    }
    
    public PageReference edit(){
        if(visibleEdit){
            System.debug('===== edit() ');
            try{
                System.debug('Update Note = '+logBookDetail.Notes__c);
                Database.SaveResult result = Database.update(logBookDetail);
                if(result.isSuccess()){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.CONFIRM, MSG_EDIT_SUCCESS));
                }else{
                    ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_EDIT_FAILED));
                }
            }catch(Exception e){
                e.getStackTraceString();
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_EDIT_FAILED));
            }
        } else {
            visibleEdit = true;
            visibleDetail = false;
        }
        return null;
    }
    // END EDIT
    
    private String getDuration(Time tStart, Time tEnd){       
        String duration = '';
        DateTime dtStart = Datetime.newInstance(date.today(), Time.newInstance(tStart.hour(), tStart.minute(), 0, 0));
        DateTime dtEnd = Datetime.newInstance(date.today(), Time.newInstance(tEnd.hour(), tEnd.minute(), 0, 0));
        
        if(dtStart != null && dtEnd != null){
            if (dtEnd < dtStart) {
                //dtEnd = dtEnd.addDays(1);
                dtEnd = dtStart;
            }
            Long msec = dtEnd.getTime() - dtStart.getTime();
            Long hh = msec / 1000 / 60 / 60;
            msec -= hh * 1000 * 60 * 60;
            Long mm = msec / 1000 / 60;
            msec -= mm * 1000 * 60;
            Long ss = msec / 1000;
            msec -= ss * 1000;
            duration = hh + ' hours '+ mm + ' minutes';
        } 
        return duration;
    }
    
    private Integer getDurationByMinute(String timeDuration){
        if(timeDuration != null){
            try{
                String sHour = (timeDuration.substringBetween('', 'hours')).trim();
                String sMinute = (timeDuration.substringBetween('hours', 'minutes')).trim();
                
                Integer iHour = Integer.valueOf(sHour);
                Integer iMinute = Integer.valueOf(sMinute);
                
                return (60 * iHour) + iMinute; 
            } catch(Exception ex){
                System.debug('ERROR - LogBookActivitiyController.getDurationByMinute() = '+ex);
            }
        }
        return null;
    } 
    
    private String getDurationWithInit(Time tStart, Time tEnd, String initDuration){       
        system.Debug('Time Start: '+tStart+', Time End:'+tEnd+', init Duration: '+initDuration);
        String duration = '';
        String initDurationH = initDuration.substringBefore(' hours');
        String initDurationM = (initDuration.substringBefore(' minutes')).substringAfter('hours ');
        system.debug('init duration hours: '+initDurationH+', minutes: '+initDurationM);
        DateTime dtStart = Datetime.newInstance(date.today(), Time.newInstance(tStart.hour(), tStart.minute(), 0, 0));
        DateTime dtEnd = Datetime.newInstance(date.today(), Time.newInstance(tEnd.hour(), tEnd.minute(), 0, 0));
        
        if(dtStart != null && dtEnd != null){
            if (dtEnd < dtStart) {
                //dtEnd = dtEnd.addDays(1);
                dtEnd = dtStart;
            }
            Long msec = dtEnd.getTime() - dtStart.getTime();
            Long hh = msec / 1000 / 60 / 60;
            msec -= hh * 1000 * 60 * 60;
            Long mm = msec / 1000 / 60;
            msec -= mm * 1000 * 60;
            Long ss = msec / 1000;
            msec -= ss * 1000;
            
            system.debug('extend duration hours: '+hh+', minutes: '+mm);
            
            hh += Long.ValueOf(initDurationH);
            mm += Long.ValueOf(initDurationM);
            while (mm > 59) {
                mm -= 60;
                hh += 1;
            }
            system.debug('duration afted extended hours: '+hh+', minutes: '+mm);
            duration = hh + ' hours '+ mm + ' minutes';
        } 
        return duration;
    }
    
    /*
    * Batch 1 : 08.00 - 11.00 (Same Day) and > 15.00
    * Batch 2 : 11.01 - 13.00
    * Batch 3 : 13.01 - 15.00
    */
    private Integer getBatchNow(){
        Datetime now = Datetime.now();
        Integer offset = UserInfo.getTimezone().getOffset(now);
        Datetime local = now.addSeconds(offset/1000);
        
        Time timeNow = local.timeGmt();
        Time tmBatch1 = Time.newInstance(8, 0, 0, 0);
        Time tmBatch2 = Time.newInstance(11, 1, 0, 0);
        Time tmBatch3 = Time.newInstance(13, 1, 0, 0);
        Time tmBatchEnd = Time.newInstance(15, 0, 0, 0);
        
        Integer batch = (timeNow >= tmBatch2 && timeNow < tmBatch3) ? 2 : (timeNow >= tmBatch3 && timeNow < tmBatchEnd) ? 3 : 1;
        System.debug('time now = '+timeNow + ', batch = '+batch);
        return batch;
    }
    
    public PageReference changeDepart(){
        logBookDetail.Kind_Of_Transaction__c = null;
        system.debug('logBookDetail.Department__c:'+logBookDetail.Department__c);
        
        if (logBookDetail.Department__c == 'CCC') {
            isJapenPOS = false;
            isMultiple = true;       
        } else {
            isJapenPOS = false;
            isMultiple = false;  
        }
        system.debug('isMultiple:'+isMultiple); 
        
        return checkCaseType();
    }
    
    public Map<String, List<String>> KindOfTransactionMultiple() { 
        system.debug('KindOfTransactionMultiple');
        String objectName = 'Log_Book_Activitiy_Detail__c';
        String controllingField = 'Department__c';
        String dependentField = 'Kind_Of_Transaction__c';
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
        
        Schema.DescribeSObjectResult describeResult = objType.getDescribe();
        Schema.DescribeFieldResult controllingFieldInfo = describeResult.fields.getMap().get(controllingField).getDescribe();
        Schema.DescribeFieldResult dependentFieldInfo = describeResult.fields.getMap().get(dependentField).getDescribe();
        
        List<Schema.PicklistEntry> controllingValues = controllingFieldInfo.getPicklistValues();
        List<Schema.PicklistEntry> dependentValues = dependentFieldInfo.getPicklistValues();
        
        Map<String, List<String>> controllingInfo = new Map<String, List<String>>(); 
        List<String> options = new List<String>();
        for(Schema.PicklistEntry currControllingValue : controllingValues)
        { 
            controllingInfo.put(currControllingValue.getLabel(), new List<String>());
        }
        
        for(Schema.PicklistEntry currDependentValue : dependentValues)
        {
            String jsonString = JSON.serialize(currDependentValue);
            
            MyPickListInfo info = (MyPickListInfo) JSON.deserialize(jsonString, MyPickListInfo.class);
            
            String hexString = EncodingUtil.convertToHex(EncodingUtil.base64Decode(info.validFor)).toUpperCase();
            
            Integer baseCount = 0;
            
            for(Integer curr : hexString.getChars())
            {
                Integer val = 0;
                string department = '';
                string listData = '';
                
                if(curr >= 65)
                {
                    val = curr - 65 + 10;
                }
                else
                {
                    val = curr - 48;
                }
                
                if((val & 8) == 8)
                {  
                    department = controllingValues[baseCount + 0].getLabel(); 
                    controllingInfo.get(controllingValues[baseCount + 0].getLabel()).add(currDependentValue.getLabel());
                }
                if((val & 4) == 4)
                { 
                    department = controllingValues[baseCount + 0].getLabel(); 
                    controllingInfo.get(controllingValues[baseCount + 1].getLabel()).add(currDependentValue.getLabel());                    
                }
                if((val & 2) == 2)
                {
                    department = controllingValues[baseCount + 2].getLabel();
                    controllingInfo.get(controllingValues[baseCount + 2].getLabel()).add(currDependentValue.getLabel());                    
                }
                if((val & 1) == 1)
                {
                    department = controllingValues[baseCount + 3].getLabel();
                    controllingInfo.get(controllingValues[baseCount + 3].getLabel()).add(currDependentValue.getLabel());                    
                }
                listData = department+':'+currDependentValue.getLabel();
                options.add(listData);
                baseCount += 4;
            }  
        }  
        
        return controllingInfo;
    }
    
    public class MyPickListInfo {
        public String validFor;
    }

    public PageReference checkCaseType() {
        cs = new Case();
        logBookDetail.Case_Type__c = null;
        logBookDetail.Transaction_Type__c = null;
        listDocument = new List<String>();
        indexDoc = 0;
        mapDocInfo.clear();
        docInformation = new String []{};
        isValidCustomer = true;
        
        
        
        String kindOfTrx = logBookDetail.Kind_Of_Transaction__c;
        System.debug('Kind Of Transaction = '+kindOfTrx);
        // isEform = String.isNotBlank(kindOfTrx) && listEForm.contains(kindOfTrx);
        // if(isEform){
        //     String formUtamaInput = logBookDetail.Form_Utama__c;
        //     isEform = String.isNotBlank(formUtamaInput) && listFormUtama.contains(formUtamaInput);
        // }

        //Add by Mario 07/06.2025 EUONIA
        // if(kindOfTrx == 'Request_POS Lumpsum' || kindOfTrx == 'Request_POS_Withdrawal' || kindOfTrx == 'Request_POS_Withdrawal Big Amount' 
        // || kindOfTrx == 'Request_POS_Pengalihan Dana (Switching)' || kindOfTrx == 'Request_POS_Perubahan Alokasi Dana (Redirection)'
        // || kindOfTrx == 'Request_POS_Switching & Redirection'    ){
        //     isEform = true;
        // }else{
        //     isEform = false;
        // }

        // Set<String> eformTransaction = new Set<String>{
        //     'Request_POS_Lumpsum',
        //     'Request_POS_Withdrawal',
        //     'Request_POS_Withdrawal Big Amount',
        //     'Request_POS_Pengalihan Dana (Switching)',
        //     'Request_POS_Perubahan Alokasi Dana (Redirection)',
        //     'Request_POS_Switching & Redirection',
        //     'Request_POS_Perubahan Alamat email',
        //     'request_POS_Perubahan nomor kontak',
        //     'Request_POS_Perubahan Alamat Koresponden',
        //     'Request_POS_Redemption',
        //     'Request_POS Cooling off',
        //     'Request_POS Pemulihan Polis',
        //     'request_POS_Perubahan ID KTP',
        //     'request_POS_cuti premi',
        //     'Request_POS_Perubahan Ahli waris'
        // };

        // isEform = eformTransaction.contains(kindOfTrx);

        // Set<String> eformTx = new Set<String>();
        // for (String s : new List<String>{
        //     'Request_POS_Lumpsum',
        //     'Request_POS_Withdrawal',
        //     'Request_POS_Withdrawal Big Amount',
        //     'Request_POS_Pengalihan Dana (Switching)',
        //     'Request_POS_Perubahan Alokasi Dana (Redirection)',
        //     'Request_POS_Switching & Redirection',
        //     'Request_POS_ Perubahan Alamat email',
        //     'request_POS_Perubahan nomor kontak',
        //     'Request_POS_ Perubahan Alamat Koresponden',
        //     'Request_POS_Redemption',
        //     'Request_POS Cooling off',
        //     'Request_POS Pemulihan Polis',
        //     'request_POS_Perubahan ID KTP',
        //     'request_POS_cuti premi',
        //     'Request_POS_Perubahan Ahli waris',
        //     'Request_POS_Japen Financial',
        //     'Request_POS_Japen Non Financial',
        //     'Request_POS_Japen Ubi/Uwi/Ure/Uco',
        //     'Request_ADS - Perubahan Alamat Email',
        //     'Request_ADS_Perubahan Nomor Kontak',
        //     'Request_ADS_Perubahan Alamat Korespondensi',
        //     'Request_ADS_Perubahan ID KTP',
        //     'Request_ADS_Perubahan Ahli waris',
        //     'Request_ADS_Redemption TM',
        //     'Cooling Off'
        // }) {
        //     eformTx.add(s.toLowerCase());
        // }
        // isEform = String.isNotBlank(kindOfTrx) && eformTx.contains(kindOfTrx.trim().toLowerCase());
        
        if(String.isNotBlank(kindOfTrx)){
            // VSnap - Taufik MII, 11 feb 2020 - Get Result for SKDKK
            if (kindOfTrx.contains('SKDKK'))
                showbuttonPCIDSSCC = TRUE;
            else
                showbuttonPCIDSSCC = FALSE;
            
            if (kindOfTrx.contains('SKDR'))
                showbuttonPCIDSSSaving = TRUE;
            else
                showbuttonPCIDSSSaving = FALSE;
            
            Schema.DescribeFieldResult kindOfTrxField = Log_Book_Activitiy_Detail__c.Kind_Of_Transaction__c.getDescribe();
            Schema.sObjectField kindOfTrxObjectField = kindOfTrxField.getSObjectField();
            
            Schema.DescribeFieldResult documentField = Log_Book_Activitiy_Detail__c.Document__c.getDescribe();
            Schema.sObjectField documentObjectField = documentField.getSObjectField();
            
            Map<String, List<String>> resultDocument = getDependentOptionsImpl(documentObjectField, kindOfTrxObjectField);
            listDocument = resultDocument.get(kindOfTrx);
            System.debug('listDocument'+listDocument);
            
            Schema.DescribeFieldResult trxTypeField = Log_Book_Activitiy_Detail__c.Transaction_Type__c.getDescribe();
            Schema.sObjectField trxTypeObjectField = trxTypeField.getSObjectField();
            
            Map<String, List<String>> resultDependentTrxType = getDependentOptionsImpl(trxTypeObjectField, kindOfTrxObjectField);
            List<String> dependentTrxTypeList = resultDependentTrxType.get(kindOfTrx);
            if(dependentTrxTypeList != null && dependentTrxTypeList.size() > 0){
                String trxType = dependentTrxTypeList.get(0);
                // logBookDetail.Transaction_Type__c = trxType ;
                logBookDetail.Transaction_Type__c = (logBookDetail.Department__c == 'DPLK') ? TRX_TYPE_REQUEST : trxType ;
                cs.Type = trxType;                
                if(TRX_TYPE_REQUEST == trxType){
                    cs.RecordTypeId = getRecordTypeCaseId(RECORD_TYPE_REQUEST_CASE);
                }else if(TRX_TYPE_INQUIRY == trxType){
                    cs.RecordTypeId = getRecordTypeCaseId(RECORD_TYPE_INQUIRY_CASE);
                }else if(TRX_TYPE_COMPLAINT == trxType){
                    cs.RecordTypeId = getRecordTypeCaseId(RECORD_TYPE_COMPLAINT_CASE);
                }
            }
            
            Schema.DescribeFieldResult caseTypeField = Log_Book_Activitiy_Detail__c.Case_Type__c.getDescribe();
            Schema.sObjectField caseTypeObjectField = caseTypeField.getSObjectField();
            
            Map<String, List<String>> resultDependentCaseType = getDependentOptionsImpl(caseTypeObjectField, kindOfTrxObjectField);
            List<String> dependentCaseTypeList = resultDependentCaseType.get(kindOfTrx);
            if(dependentCaseTypeList != null && dependentCaseTypeList.size() > 0){
                logBookDetail.Case_Type__c = dependentCaseTypeList.get(0);
            }

            //Add by Yazid 13/08/2025 EUONIA
            List<String> listReqJapenTrx = new List<String>{
                'Request_POS_Japen Financial',
                'Request_POS_Japen Non Financial',
                'Request_POS_Japen Ubi/Uwi/Ure/Uco'
            };

            String kindOf = logBookDetail.Case_Type__c;
            if(String.isNotBlank(kindOf)) isJapenPOS = listReqJapenTrx.contains(kindOf);
            System.debug('Kind Of Transaction = '+kindOf+' isJapenPOS? '+isJapenPOS);
            
            System.debug('logBookDetail.Case_Type__c :'+logBookDetail.Case_Type__c);
            isValidCustomer = logBookDetail.Kind_Of_Transaction__c != 'Wrong Counter';
        }
        CaseServiceController caseService = new CaseServiceController();
        checkCourier = caseService.getCekCourierCase(cs);
        return null;
    }
    
    public static Map<String, List<String>> getDependentOptionsImpl(Schema.SObjectField theField, Schema.SObjectField ctrlField) {
        // validFor property cannot be accessed via a method or a property,
        // so we need to serialize the PicklistEntry object and then deserialize into a wrapper.
        List<Schema.PicklistEntry> contrEntries = ctrlField.getDescribe().getPicklistValues();
        List<PicklistEntryWrapper> depEntries =
            wrapPicklistEntries(theField.getDescribe().getPicklistValues());
        
        // Set up the return container - Map<ControllingValue, List<DependentValues>>
        Map<String, List<String>> objResults = new Map<String, List<String>>();
        List<String> controllingValues = new List<String>();
        
        for (Schema.PicklistEntry ple : contrEntries) {
            String label = ple.getLabel();
            objResults.put(label, new List<String>());
            controllingValues.add(label);
        }
        
        for (PicklistEntryWrapper plew : depEntries) {
            String label = plew.label;
            String validForBits = base64ToBits(plew.validFor);
            for (Integer i = 0; i < validForBits.length(); i++) {
                // For each bit, in order: if it's a 1, add this label to the dependent list for the corresponding controlling value
                String bit = validForBits.mid(i, 1);
                if (bit == '1') {
                    objResults.get(controllingValues.get(i)).add(label);
                }
            }
        }
        
        return objResults;
    }
    
    // Convert decimal to binary representation (alas, Apex has no native method :-(
    //    eg. 4 => '100', 19 => '10011', etc.
    // Method: Divide by 2 repeatedly until 0. At each step note the remainder (0 or 1).
    // These, in reverse order, are the binary.
    private static String decimalToBinary(Integer val) {
        String bits = '';
        while (val > 0) {
            Integer remainder = Math.mod(val, 2);
            val = Integer.valueOf(Math.floor(val / 2));
            bits = String.valueOf(remainder) + bits;
        }
        return bits;
    }
    
    // Convert a base64 token into a binary/bits representation
    // e.g. 'gAAA' => '100000000000000000000'
    private static String base64ToBits(String validFor) {
        if (String.isEmpty(validFor)) return '';
        
        String validForBits = '';
        
        for (Integer i = 0; i < validFor.length(); i++) {
            String thisChar = validFor.mid(i, 1);
            Integer val = base64Chars.indexOf(thisChar);
            String bits = decimalToBinary(val).leftPad(6, '0');
            validForBits += bits;
        }
        
        return validForBits;
    }
    
    private static final String base64Chars = '' +
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
        'abcdefghijklmnopqrstuvwxyz' +
        '0123456789+/()_';
    
    private static List<PicklistEntryWrapper> wrapPicklistEntries(List<Schema.PicklistEntry> PLEs) {
        return (List<PicklistEntryWrapper>)
            JSON.deserialize(JSON.serialize(PLEs), List<PicklistEntryWrapper>.class);
    }
    
    public class PicklistEntryWrapper {
        public String active {get; set;}
        public String defaultValue {get; set;}
        public String label {get; set;}
        public String value {get; set;}
        public String validFor {get; set;}
    }
    
    public  list<SelectOption> getDocSpec(){
        Schema.sObjectType sobject_type = Log_Book_Activitiy_Detail__c.getSObjectType();
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe();
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap();          
        List<Schema.PicklistEntry> pick_list_values = field_map.get('Document_Specification__c').getDescribe().getPickListValues();
        List<SelectOption> globalOptions = new List<SelectOption>();
        for (Schema.PicklistEntry a : pick_list_values) {
            globalOptions.add(new selectOption(a.getValue(), a.getLabel()));
        }
        return globalOptions;
    }
    
    private static ID getRecordTypeCaseId(String Recordtype){
        return Schema.SObjectType.Case.getRecordTypeInfosByName().get(Recordtype).getRecordTypeId();
    }
    
    private static void sentErrorCase(String errorMessage, String data){
        System.debug('=============== EMAIL - SEND ERROR CASE LOGBOOK ACTIVITIY ============= ');
        try {
            // Send email
            String[] emailTo = (Label.Notif_Email_Addr_To).split(';');
            String[] emailCc = (Label.Notif_Email_Addr_Cc).split(';');
            
            Messaging.SingleEmailMessage em = new Messaging.SingleEmailMessage();
            if (emailTo.size() > 0)
                em.setToAddresses(emailTo);
            if (emailCc.size() > 0)
                em.setCcAddresses(emailCc);
            
            em.setSubject('[ERROR] Salesforce : Logbook Activitiy ' + String.valueOf(Datetime.now()));
            em.setHtmlBody('Hi, this is an automatically email from Salesforce Admin.<br><br>' +
                           'You have error when create case in logbook activitiy.<br><br>'+
                           '<b>Error Message : </b>' + errorMessage + '<br><br>' +
                           '<b>Data : </b>' + data + '<br><br><br>' +
                           'Best Regards,<br>' +
                           'Salesforce Admin');
            
            if (!test.isRunningTest())  Messaging.sendEmail(new List<Messaging.Email> {em});
        } catch (Exception e) {
            System.debug('*** SENT EMAIL ERROR: [' + e.getLineNumber() + '] ' + e.getMessage());
        }
    }
    
    private String generateDocumentInformation(Map<String,String> mapDoc){
        String docInfo = '';
        if(mapDoc != null && mapDoc.size() > 0){
            for (String key: mapDoc.keySet()) {
                docInfo += mapDoc.get(key);
                docInfo += ';';
            }
        }
        return docInfo;
    }
    
    // Catur 20200116, added for new lookup standard
    public void fetchContactDetail(){
        Contact contactTemp = [Select ID,MobilePhone, Entity__c, Policy_No__c, Name, PolicyApp__c, Sensitive_Customer__c, Email, Phone FROM Contact WHERE ID =:logBookDetail.Contact_Policy__c LIMIT 1];
        saveSearchPolicyId = logBookDetail.Contact_Policy__c;
        savePolicyNumber = contactTemp.Policy_No__c;
        savePolicyNameHolder = contactTemp.Name;
        saveEmailPP = contactTemp.Email;
        saveNoTelpPP = contactTemp.MobilePhone;
        saveProductType = contactTemp.PolicyApp__c;


        logBookDetail.Policy_Name_Holder__c = contactTemp.Name;
        logBookDetail.Policy_Number__c = contactTemp.Policy_No__c;
        logBookDetail.Product_Type__c = contactTemp.PolicyApp__c;  
        
        parentIdAttachment = contactTemp.Id;
        if (String.isNotBlank(parentIdAttachment) && entityAuth == 'AMFS') {
            isAttach = TRUE;
        } else {
            isAttach = FALSE;
        } 
        
        // taufik mii, 20200203, VSnap
        firstContactId = contactTemp.id;
        contactPolicyNo = contactTemp.Policy_No__c;
        contactEntity = contactTemp.Entity__c;
        contactPolicyApp = contactTemp.PolicyApp__c;
        
        // added by Ranti at 10/21/2021 
        logBookDetail.Email_PP__c = contactTemp.Email;
        logBookDetail.Phone_PP__c = contactTemp.MobilePhone;
        
        firstNumberContact = contactTemp.MobilePhone;
        firstEmailContact = contactTemp.Email;  

        //Faizir, added new field sensitive customer for walkin 20210804
        logBookDetail.Sensitive_Customer__c = contactTemp.Sensitive_Customer__c == null || contactTemp.Sensitive_Customer__c == '' ? '' : contactTemp.Sensitive_Customer__c;
        generateSecNo();
    }
    
    public Boolean getCekCourier(){
        CaseServiceController caseService = new CaseServiceController();
        
        if(TRX_TYPE_REQUEST == cs.Type){
            cs.Case_Type_Config__c = logBookDetail.Case_Type__c;
        }
        return caseService.getCekCourierCase(cs);
    }
    
    /**
     * @description 
     * Function ini dipanggil dari VisualForce LogBookActivitiyPDF.page
     * Untuk E-Receipt PDF menambah keterangan dokumen apa saja yang di E-Form
     * @author Faizir 08/07/2020 edited by Yazid
     * @date 26-05-2025
     */
    public PageReference previewPDF(){
        String queue = ApexPages.currentPage().getParameters().get('queue');
        String touchPoint = ApexPages.currentPage().getParameters().get('touchPoint');
        Date dateLog = Date.valueOf(ApexPages.currentPage().getParameters().get('dateLog'));
        // isInsert = ApexPages.currentPage().getParameters().get('isInsert') != null ? ApexPages.currentPage().getParameters().get('isInsert').equals('true') : false;
        // change by Yazid MII 05/09/2025
        Map<String, String> eReceiptMap = getDataeReceipt();
        system.debug('### AMFS eReceiptMap = '+eReceiptMap);
        logBookDetailList = [SELECT ID, Log_Case__r.CaseNumber, Log_Book_Activitiy__r.Log_Book_Date__c, Log_Book_Activitiy__r.Touch_Point__c,Log_Book_Activitiy__r.Touch_Point_City__c, Log_Book_Activitiy__r.Queue_No__c, 
                             Log_Book_Activitiy__r.CSO_Name__c, Policy_Number__c, Policy_Name_Holder__c, Product_Type__c, Customer_Name__c, Customer_Relation__c,
                             Is_Policy_Holder__c, Segmentation__c, Department__c, Kind_Of_Transaction__c, Document_Type__c, Document__c, Document_Information__c, 
                             Stamp__c, Remarks_Long_Text__c, Notes__c, Transaction_Type__c, Case_Type__c, Customer_Mood__c, Status__c, Need_CR__c, Log_Case__r.Type, 
                             Log_Case__r.Case_Type_Config__c, Log_Case__r.Case_Type__c, Log_Case__r.Subject, Log_Case__r.Description, Log_Case__r.Description__c, 
                             Log_Case__r.Nature_Config__c, Log_Case__r.Category_Config__c, Log_Case__r.PIC_Department_LU__c, Log_Case__r.Status, Other_Document__c,CreatedDate,
                             Dokumen_Tambahan__c,Form_Tambahan__c, EForm__c, Form_Utama__c
                             FROM Log_Book_Activitiy_Detail__c WHERE Log_Book_Activitiy__r.Queue_No__c = :queue AND Log_Book_Activitiy__r.Touch_Point__c = :touchPoint AND Log_Book_Activitiy__r.Log_Book_Date__c =:dateLog AND Department__c != 'CCC'];
        system.debug('logBookDetailList = '+logBookDetailList.size());
        system.debug('logBookDetailList2 = '+logBookDetailList);
        
        dateNow = CCCUtils.printableDate(logBookDate,'dd MMMM yyyy'); // print date ke sistem penanggalan indonesia (DD MMMMMMM YYYY)
        
        Integer i = 1; // counter untuk semua log book
        mapDocInsertedDoc = new Map<String,String>();
        mapDocOtherDoc = new Map<String,String>();
        for(Log_Book_Activitiy_Detail__c detail : logBookDetailList){
            if(detail.EForm__c == true){
                String key = detail.Kind_Of_Transaction__c.replaceAll('[ _-]', '').toLowerCase();
                if(detail.Form_Utama__c != null) key=key+detail.Form_Utama__c.replaceAll('[ _-]', '').toLowerCase();
                String masterEReceiptData = eReceiptMap.get(key);
                System.debug('EReceipt >> detail.Kind_Of_Transaction__c '+key);
                System.debug('EReceipt >> masterEReceiptData '+masterEReceiptData);
                if(masterEReceiptData != null){
                    List<String> docLists = (masterEReceiptData).split(',');
                    // System.debug('EReceipt >> docLists '+docLists);
                    for(String item : docLists){
                        mapDocInsertedDoc.put(detail.ID+String.valueOf(i), item);
                        i++;
                    }
                }
                if(String.isNotBlank(detail.Dokumen_Tambahan__c)){
                    documentsInserted = (detail.Dokumen_Tambahan__c).split(';');
                    for(String docIns : documentsInserted){
                        mapDocInsertedDoc.put(detail.ID+String.valueOf(i), docIns); // insert to new map inserted doc by ID
                        i++;
                    }
                }
                if(String.isNotBlank(detail.Form_Tambahan__c)){
                    documentsInserted = (detail.Form_Tambahan__c).split(';');
                    for(String docIns : documentsInserted){
                        mapDocInsertedDoc.put(detail.ID+String.valueOf(i), docIns); // insert to new map inserted doc by ID
                        i++;
                    }
                }
            }else{
                if(String.isNotBlank(detail.Document_Information__c)){
                    documentsInserted = (detail.Document_Information__c).split(';');
                    for(String docIns : documentsInserted){
                        mapDocInsertedDoc.put(detail.ID+String.valueOf(i), docIns); // insert to new map inserted doc by ID
                        i++;
                    }
                }
                if(String.isNotBlank(detail.Other_Document__c)){
                    otherDocument = (detail.Other_Document__c).split(';');
                    for(String docIns : otherDocument){              
                        mapDocOtherDoc.put(detail.ID+String.valueOf(i), docIns); // insert to new map other doc by ID
                        i++;
                    }
                }
            }
        }
        // END change by Yazid MII 05/09/2025
        
        /*
        System.debug('isInsert == '+isInsert);

        if(isInsert){
        blob body = ApexPages.currentPage().getContentAsPDF();
        Document objDocument = new Document();
        objDocument.name = queue+touchPoint;
        objDocument.body = body;
        objDocument.FolderId = UserInfo.getUserId();
        objDocument.contentType = 'application/pdf';
        insert objDocument;
        }
        */
        return null;
    }
    
    //add khris 03/11/2021
    public PageReference sendNotif() {
        system.debug('paramQueue email = '+Apexpages.currentPage().getParameters().get('paramQueue'));
        system.debug('paramTouchPoint email = '+Apexpages.currentPage().getParameters().get('paramTouchPoint'));
        system.debug('paramDateLog email = '+Apexpages.currentPage().getParameters().get('paramDateLog'));
        system.debug('SendType = '+Apexpages.currentPage().getParameters().get('sendType'));
        system.debug('lbdId = '+Apexpages.currentPage().getParameters().get('lbdId')); 
        if (test.isRunningTest()) {
            Log_Book_Activitiy_Detail__c getLb = [select Log_Book_Activitiy__r.Log_Book_Date__c, Log_Book_Activitiy__r.Touch_Point__c,Log_Book_Activitiy__r.Queue_No__c,id from Log_Book_Activitiy_Detail__c order by createdDate desc  limit 1];
            
            paramDateLog = string.valueOf(getLb.Log_Book_Activitiy__r.Log_Book_Date__c);
            paramQueue = getLb.Log_Book_Activitiy__r.Queue_No__c;
            paramTouchPoint = getLb.Log_Book_Activitiy__r.Touch_Point__c;
            lbdId = getLb.id;
            
            system.debug('paramDateLog:'+paramDateLog);
            system.debug('paramQueue:'+paramQueue);
            system.debug('paramTouchPoint:'+paramTouchPoint);
            system.debug('sendType:'+sendType);
        }
        
        if(paramDateLog != NULL && paramQueue != NULL && paramTouchPoint != NULL && sendType != NULL && lbdId != NULL) {
            Date dtLog = Date.valueOf(paramDateLog);
            
            logBookDetailList = [SELECT ID, Log_Case__r.CaseNumber, Log_Book_Activitiy__c, Log_Book_Activitiy__r.Log_Book_Date__c, Log_Book_Activitiy__r.Touch_Point__c,Log_Book_Activitiy__r.Touch_Point_City__c, Log_Book_Activitiy__r.Queue_No__c, 
                                 Log_Book_Activitiy__r.CSO_Name__c, Log_Book_Activitiy__r.Status_send__c, Policy_Number__c, Policy_Name_Holder__c, Product_Type__c, Customer_Name__c, Customer_Relation__c,
                                 Is_Policy_Holder__c, Segmentation__c, Department__c, Kind_Of_Transaction__c, Document_Type__c, Document__c, Document_Information__c, 
                                 Stamp__c, Remarks_Long_Text__c, Notes__c, Transaction_Type__c, Case_Type__c, Customer_Mood__c, Status__c, Need_CR__c, Log_Case__r.Type, Log_Case__c,
                                 Log_Case__r.Case_Type_Config__c, Log_Case__r.Case_Type__c, Log_Case__r.Subject, Log_Case__r.Description, Log_Case__r.Description__c, 
                                 Log_Case__r.Nature_Config__c, Log_Case__r.Category_Config__c, Log_Case__r.PIC_Department_LU__c, Log_Case__r.Status, Other_Document__c,
                                 Contact_Policy__r.Email, Contact_Policy__r.MobilePhone, Email_Non_PP__c, Phone_Non_PP__c, Email_PP__c, Phone_PP__c,Is_Non_Customer__c,
                                 Log_Book_Activitiy__r.Sequence_Email__c, Log_Book_Activitiy__r.Sequence_SMS__c 
                                 FROM Log_Book_Activitiy_Detail__c WHERE Id = :lbdId AND Department__c != 'CCC'];
            system.debug('logBookDetailList size = '+logBookDetailList.size());
            system.debug('Log_Case__r.CaseNumber = '+logBookDetailList);
            
            ICF_Parameter__c icfParam = [SELECT Id, User_Id__c, Password__c, Sender__c, Division__c, Batchname__c, Uploadby__c, Channel__c, ICF_Email_Template__r.Subject__c, 
                                         ICF_Email_Template__r.Email_Header__c, ICF_Email_Template__r.Email_Body__c, ICF_Email_Template__r.Email_Footer__c, ICF_SMS_Template__r.Email_Body__c
                                         FROM ICF_Parameter__c WHERE Entity__c = 'AMFS E-Receipt' AND Record_Type_Name__c = 'Master_Email_SMS' LIMIT 1];
            
            Set<Id> logbookDetailId = new Set<Id>();
            
            String urlEreciept = Label.Ereciept_URL;
            if(paramTouchPoint.contains(' ')) paramTouchPoint = paramTouchPoint.replace(' ', '%20');
            urlEreciept = urlEreciept.replace('[QUEUE_NUMBER]', paramQueue);
            urlEreciept = urlEreciept.replace('[TOUCH_POINT]', paramTouchPoint);
            urlEreciept = urlEreciept.replace('[DATE_LOG]', paramDateLog);
            
            if(sendType == 'Email') {
                system.debug('start email');
                String subjectEmail;
                String bodyEmail;
                List<String> listEmailTo = new List<String>();
                Set<String> setEmailTo = new Set<String>();   
                
                if(logBookDetailList.size() > 0) {
                    for(Log_Book_Activitiy_Detail__c lbd : logBookDetailList) {
                        // if(lbd.Email_PP__c != NULL && lbd.Email_Non_PP__c == NULL && lbd.Is_Non_Customer__c != true) {
                        // setEmailTo.add(lbd.Email_PP__c);
                        // }
                        // if(lbd.Email_Non_PP__c != NULL && lbd.Email_PP__c == NULL && lbd.Is_Non_Customer__c == true) {
                        // setEmailTo.add(lbd.Email_Non_PP__c);
                        // } 
                        
                        
                        if(lbd.Email_PP__c != NULL  && lbd.Is_Non_Customer__c != true) {
                            setEmailTo.add(lbd.Email_PP__c);
                        }
                        if(lbd.Email_Non_PP__c != NULL && lbd.Is_Non_Customer__c == true) {
                            setEmailTo.add(lbd.Email_Non_PP__c);
                        }
                        if(setEmailTo.size() > 0) listEmailTo.addAll(setEmailTo);
                    }
                    system.debug('listEmailTo size = '+listEmailTo.size());
                    if(listEmailTo.size() > 0) {
                        subjectEmail = icfParam.ICF_Email_Template__r.Subject__c;
                        bodyEmail = icfParam.ICF_Email_Template__r.Email_Body__c+'\n'+icfParam.ICF_Email_Template__r.Email_Footer__c;
                        
                        if(bodyEmail.contains('[CONTACT_NAME]')) bodyEmail = bodyEmail.replace('[CONTACT_NAME]', logBookDetailList[0].Customer_Name__c);
                        if(bodyEmail.contains('[LINKPAGE]')) bodyEmail = bodyEmail.replace('[LINKPAGE]', urlEreciept);
                        
                        // added by Ranti at 12/20/2021 
                        Date d = dtLog;
                        string dateStr = DateTime.newInstance(d.year(),d.month(),d.day()).format('dd-MM-yyyy');
                        system.debug(':: Format Date:' + dateStr);    
                        if(bodyEmail.contains('[CREATED_DATE]')) bodyEmail = bodyEmail.replace('[CREATED_DATE]', dateStr);
                        
                        // system.debug(':: System Debug:' + system.label.IMAGE_EReceipt_AMFS);    
                        
                        // if(bodyEmail.contains('[URL_IMAGE]')) bodyEmail = bodyEmail.replace('[URL_IMAGE]', system.label.IMAGE_EReceipt_AMFS);
                        
                        ErecieptNotifController ereciept = new ErecieptNotifController();
                        ereciept.sendEmail(listEmailTo, logBookDetailList, subjectEmail, bodyEmail); 
                    }
                }
            }
            if(sendType == 'SMS') {
                system.debug('start sms');
                String bodySMS;
                
                bodySMS = icfParam.ICF_SMS_Template__r.Email_Body__c;
                system.debug('lbdId:'+lbdId);
                system.debug('bodySMS:'+bodySMS);
                system.debug('urlEreciept:'+urlEreciept);
                system.debug('icfparam.User_ID__c:'+icfparam.User_ID__c);
                system.debug('icfparam.Sender__c:'+icfparam.Sender__c);
                system.debug('icfparam.Division__c:'+icfparam.Division__c);
                system.debug('icfparam.Batchname__c:'+icfparam.Batchname__c);
                system.debug('icfparam.Uploadby__c:'+icfparam.Uploadby__c);
                system.debug('icfparam.Channel__c:'+icfparam.Channel__c);
                if(!Test.isRunningTest()) ErecieptNotifController.sendSMS(lbdId, bodySMS, urlEreciept, icfparam.User_ID__c, icfparam.Password__c, icfparam.Sender__c, icfparam.Division__c, icfparam.Batchname__c, icfparam.Uploadby__c, icfparam.Channel__c);
            }
        }
        // PageReference pageRef = new PageReference('/apex/LogBookActivitiy?sfdc.tabName=01r0K000000qFhm');
        // 
        inquirySearch();
        return null;
    }    
    
    /**
     * @description 
     * Untuk E-Receipt PDF menambah keterangan dokumen apa saja yang di E-Form
     * @see Function Ini isinya harus sama dengan PreviewPDF() diatas karena dipanggil ditempat yang berbeda
     * @see VisualForce Ereceipt.page
     * @author edited by Yazid
     * @date 26-05-2025
     */
    public PageReference landingPage() {
        String queue = ApexPages.currentPage().getParameters().get('queue');
        String touchPoint = ApexPages.currentPage().getParameters().get('touchPoint');
        Date dateLog = Date.valueOf(ApexPages.currentPage().getParameters().get('dateLog'));
        
        // change by Yazid MII 05/09/2025
        Map<String, String> eReceiptMap = getDataeReceipt();
        system.debug('### AMFS eReceiptMap = '+eReceiptMap);
        
        if (test.isRunningTest()) {
            Log_Book_Activitiy_Detail__c getLb = [select Log_Book_Activitiy__r.Log_Book_Date__c, Log_Book_Activitiy__r.Touch_Point__c,Log_Book_Activitiy__r.Queue_No__c,id from Log_Book_Activitiy_Detail__c order by createdDate desc  limit 1];
            
            dateLog = getLb.Log_Book_Activitiy__r.Log_Book_Date__c;
            queue = getLb.Log_Book_Activitiy__r.Queue_No__c;
            touchPoint = getLb.Log_Book_Activitiy__r.Touch_Point__c; 
            system.debug('LV QUEUE = '+queue);
        }
        
        logBookDetailList = [SELECT ID, Log_Case__r.CaseNumber, Log_Book_Activitiy__r.Log_Book_Date__c, Log_Book_Activitiy__r.Touch_Point__c,Log_Book_Activitiy__r.Touch_Point_City__c, Log_Book_Activitiy__r.Queue_No__c, 
                             Log_Book_Activitiy__r.CSO_Name__c, Policy_Number__c, Policy_Name_Holder__c, Product_Type__c, Customer_Name__c, Customer_Relation__c,
                             Is_Policy_Holder__c, Segmentation__c, Department__c, Kind_Of_Transaction__c, Document_Type__c, Document__c, Document_Information__c, 
                             Stamp__c, Remarks_Long_Text__c, Notes__c, Transaction_Type__c, Case_Type__c, Customer_Mood__c, Status__c, Need_CR__c, Log_Case__r.Type, 
                             Log_Case__r.Case_Type_Config__c, Log_Case__r.Case_Type__c, Log_Case__r.Subject, Log_Case__r.Description, Log_Case__r.Description__c, 
                             Log_Case__r.Nature_Config__c, Log_Case__r.Category_Config__c, Log_Case__r.PIC_Department_LU__c, Log_Case__r.Status, Other_Document__c,CreatedDate,
                             Dokumen_Tambahan__c,Form_Tambahan__c, EForm__c, Form_Utama__c
                             FROM Log_Book_Activitiy_Detail__c WHERE Log_Book_Activitiy__r.Queue_No__c = :queue AND Log_Book_Activitiy__r.Touch_Point__c = :touchPoint AND Log_Book_Activitiy__r.Log_Book_Date__c =:dateLog AND Department__c != 'CCC'];
        
        dateNow = CCCUtils.printableDate(logBookDate,'dd MMMM yyyy'); // print date ke sistem penanggalan indonesia (DD MMMMMMM YYYY);
        system.debug(':::logBookDetailList:'+logBookDetailList);
        system.debug('logBookDetailList2 = '+logBookDetailList);
        
        Integer i = 1; // counter untuk semua log book
        mapDocInsertedDoc = new Map<String,String>();
        mapDocOtherDoc = new Map<String,String>();
        for(Log_Book_Activitiy_Detail__c detail : logBookDetailList){
            System.debug('EReceipt Generate >> ');
            if(detail.EForm__c == true){
                String key = detail.Kind_Of_Transaction__c.replaceAll('[ _-]', '').toLowerCase();
                if(detail.Form_Utama__c != null) key=key+detail.Form_Utama__c.replaceAll('[ _-]', '').toLowerCase();
                String masterEReceiptData = eReceiptMap.get(key);
                System.debug('EReceipt >> detail.Kind_Of_Transaction__c '+key);
                System.debug('EReceipt >> masterEReceiptData '+masterEReceiptData);
                if(masterEReceiptData != null){
                    List<String> docLists = (masterEReceiptData).split(',');
                    // System.debug('EReceipt >> docLists '+docLists);
                    for(String item : docLists){
                        mapDocInsertedDoc.put(detail.ID+String.valueOf(i), item);
                        i++;
                    }
                }
                if(String.isNotBlank(detail.Dokumen_Tambahan__c)){
                    documentsInserted = (detail.Dokumen_Tambahan__c).split(';');
                    for(String docIns : documentsInserted){
                        mapDocInsertedDoc.put(detail.ID+String.valueOf(i), docIns); // insert to new map inserted doc by ID
                        i++;
                    }
                }
                if(String.isNotBlank(detail.Form_Tambahan__c)){
                    documentsInserted = (detail.Form_Tambahan__c).split(';');
                    for(String docIns : documentsInserted){
                        mapDocInsertedDoc.put(detail.ID+String.valueOf(i), docIns); // insert to new map inserted doc by ID
                        i++;
                    }
                }
            }else{
                if(String.isNotBlank(detail.Document_Information__c)){
                    documentsInserted = (detail.Document_Information__c).split(';');
                    for(String docIns : documentsInserted){
                        mapDocInsertedDoc.put(detail.ID+String.valueOf(i), docIns); // insert to new map inserted doc by ID
                        i++;
                    }
                }
                if(String.isNotBlank(detail.Other_Document__c)){
                    otherDocument = (detail.Other_Document__c).split(';');
                    for(String docIns : otherDocument){              
                        mapDocOtherDoc.put(detail.ID+String.valueOf(i), docIns); // insert to new map other doc by ID
                        i++;
                    }
                }
            }
        }
        // END change by Yazid
        // for(Log_Book_Activitiy_Detail__c detail : logBookDetailList){
        //     if(String.isNotBlank(detail.Document_Information__c)){
        //         documentsInserted = (detail.Document_Information__c).split(';');
        //         for(String docIns : documentsInserted){
        //             mapDocInsertedDoc.put(detail.ID+String.valueOf(i), docIns); // insert to new map inserted doc by ID
        //             i++;
        //         }
        //     }
        //     if(String.isNotBlank(detail.Other_Document__c)){
        //         otherDocument = (detail.Other_Document__c).split(';');
        //         for(String docIns : otherDocument){              
        //             mapDocOtherDoc.put(detail.ID+String.valueOf(i), docIns); // insert to new map other doc by ID
        //             i++;
        //         }
        //     }
        // }
        
        return null;
    } 
    
    //end add khris 03/11/2021
    
    public PageReference identityValidate(){
        system.debug('identityNo: ' + identityNo);
        system.debug('Policy_Name_Holder__c: ' + logBookDetail.Policy_Name_Holder__c);
        system.debug('logBookDetail.Policy_Number__c' + logBookDetail.Policy_Number__c);
        PageReference pg = null;
        if (logBookDetail != null && (logBookDetail.Policy_Number__c == null || logBookDetail.Policy_Number__c == '' || String.isEmpty(logBookDetail.Policy_Number__c))) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_POLICY_NO_BLANK));
            return pg;
        }
        if (String.isEmpty(identityNo) || identityNo == '' || identityNo == null) {
            system.debug('identityValidate: ' + identityNo);
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_IDENTITY_NO_BLANK));
            return pg;
        }
        
        try {
            String policyNumber = logBookDetail.Policy_Number__c;
            String fullNM = logBookDetail.Policy_Name_Holder__c == null ? null : logBookDetail.Policy_Name_Holder__c;
            Map<String, String> params = new Map<String, String>();
            params.put(EIPConstant.PARAM_MSG_CIF, identityNo);
            params.put(EIPConstant.PARAM_MSG_PASSWORD, Label.Dukcapil_Username);
            params.put(EIPConstant.PARAM_PASSPORT_NO, Label.Dukcapil_Pwd);
            params.put(EIPConstant.PARAM_TITLE_TXT, PARAM_DASHBOARD);
            if (fullNM != null) params.put(EIPConstant.PARAM_FULLNAME, fullNM);
            
            EIPJson dataDukcapil = EIPConnector.getCustomerInfo(EIPConstant.OPERATION_DUKCAPIL_DIRECT_VERIFICATION, EIPConstant.ENTITY_AMFS, 
                                                            EIPConstant.APP_DUKCAPIL, policyNumber, false, params);
            
            if (dataDukcapil.body != null) {
                system.debug('==> Success hit dukcapil service: ' + dataDukcapil);
                EIPJson.EIP_Body eipBody = dataDukcapil.Body;
                EIPJson.EIP_IcAx_AXAAsiaCustomer customer = eipBody == null ? null : eipBody.customer;
                EIPJson.EIP_IcAx_AXAAsiaIndividual canBeIndividual = customer == null ? null : customer.canBeIndividual;
                EIPJson.EIP_CustomerCommunication haveCommunicatedMessage = customer == null ? null : customer.haveCommunicatedMessage[0];
                if (eipBody.status != null && eipBody.status == '1') {
                    isIdentityValidated = true;
                    String custNik = canBeIndividual == null ? '' : canBeIndividual.socialSecurityNO;
                    String dukcapilMessage = haveCommunicatedMessage == null ? 'null' : haveCommunicatedMessage.message;
                    system.debug('==> custNik: ' + custNik);
                    system.debug('==> dukcapilMessage: ' + dukcapilMessage);
                    if (dukcapilMessage != null && dukcapilMessage != 'null') {
                        isIdValPossitive = false;     
                    	identityValResult = dukcapilMessage;
                    } else {
                        isIdValPossitive = true;
                        identityValResult = custNik;
                    }
                    /*if (custNik != '' && custNik.equalsIgnoreCase(MSG_DUKCAPIL_NOT_MATCH)) {
                        isIdValPossitive = false;
                        identityValResult = MSG_VERIFIED_NOT_MATCH;
                    } else {
                        isIdValPossitive = true;     
                    	identityValResult = MSG_VERIFIED_MATCH;
                    }*/
                    
                    logbook.NIK_Verify_Result__c = identityValResult;
                } else {
                    String dukcapilMessage = canBeIndividual == null ? '' : canBeIndividual.titleTXT;
                    String errMessage = dukcapilMessage == '' ? MSG_GENERAL_ERROR : dukcapilMessage;
                    ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_VERIFICATION_FAILED + errMessage));
                    return pg;
                }
            }
        } catch(Exception e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_VERIFICATION_FAILED + e.getMessage()));
            return pg;
        }
        
        return pg;
    }
    
    public PageReference generateSecNo() {
        try {
            system.debug('generateSecNo:logBookDetail.Policy_Number__c: ' + logBookDetail.Policy_Number__c);
            String policyNo = logBookDetail.Policy_Number__c;
            List<Contact> currContactList = [SELECT Id, Name, Policy_No__c, PolicyApp__c, entity__c FROM Contact WHERE policy_no__c = :policyNo limit 1];
            Contact currContact = new Contact();
            system.debug('generateSecNo: currContact: ' + currContact);
            if (currContactList.size() > 0 ) {
                for (Contact c : currContactList) {
                    currContact = c;
                }
            } else {
                return null;
            }
            EIPJson eipResult = EIPConnector.getPolicyDetails(EIPConstant.OPERATION_POLICY_DETAIL, currContact.Entity__c, currContact.PolicyApp__c, currContact.Policy_No__c);
            system.debug('generateSecNo: eipResult: ' + eipResult);
            EIPJson.EIP_Body eipBody = eipResult != null ? eipResult.Body : null;
            EIPJson.EIP_IcAx_AXAAsiaCustomer customer = eipBody != null ? eipBody.IcAx_AXAAsiaCustomer_Type : null;
            EIPJson.EIP_IcAx_AXAAsiaIndividual canBeIndividual = customer != null ? customer.canBeIndividual : null;
            identityNo = canBeIndividual != null ? canBeIndividual.socialSecurityNO : null;
            identityNo = identityNo.trim();
            system.debug('generateSecNo: identityNo: ' + identityNo);
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, MSG_CREATE_FAILED + ': ' + e.getMessage()));
            identityNo = null;
        }
        return null;
    }
    
    //Add by Mario, EUONIA 20/02/2025
    public void onChangeTouchpoint(){
        system.debug('Touchpoint: ' + logbook.Touch_Point__c);
        touchpointMDT = [SELECT Id, Email__c, Label FROM Touchpoint_Setting__mdt WHERE Touchpoint__c =: logbook.Touch_Point__c];
        //system.debug('Email: ' + touchpointMDT[0].email__c);
    }
    
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        System.debug('SET TABLET');
        system.debug('Touchpoint: ' + logbook.Touch_Point__c);
        if(logbook.Touch_Point__c != NULL){
            for(Touchpoint_Setting__mdt  mdt : [SELECT Id, Email__c, Label, Tablet__c  FROM Touchpoint_Setting__mdt WHERE Touchpoint__c =: logbook.Touch_Point__c]){
                options.add(new SelectOption(mdt.email__c, mdt.Tablet__c));
            }
        }else{
            options.add(new SelectOption('', ''));
        }
        
        return options;
    }
    
    public List<SelectOption> getDokumen() {
        List<SelectOption> options = new List<SelectOption>();
        system.debug('Touchpoint: ' + logbook.Touch_Point__c);
        Schema.DescribeFieldResult fieldResult = Log_Book_Activitiy_Detail__c.Dokumen_Tambahan__c .getDescribe();
        List<Schema.PicklistEntry> picklistValues = fieldResult.getPicklistValues();

        for (Schema.PicklistEntry entry : picklistValues) {
            options.add(new SelectOption(entry.getValue(), entry.getLabel()));
        }
        
        return options;
    }
    

    // Added by Yazid MII 26-05-2025
    /**
     * @description 
     * Untuk mendapatkan OrgWideEmailAddress
     * @return Id OrgWideEmailAddress
     * @author Yazid 26-05-2025
     * @date 26-05-2025
     */
    public static Id getOrgWideEmailAddressId() {
        String emailAddress = 'noreply.general@axa-mandiri.co.id';
        Id orgWideEmailId = null;
        OrgWideEmailAddress owea = [
            SELECT Id
            FROM OrgWideEmailAddress
            WHERE Address = :emailAddress
            LIMIT 1
        ];
        // OrgWideEmailAddress owea = [
        //     SELECT Id, Address
        //     FROM OrgWideEmailAddress
        //     WHERE DisplayName = 'AXA Mandiri' and IsAllowAllProfiles = true
        //     LIMIT 1
        // ];
        orgWideEmailId = owea.Id;
        System.debug('Org-Wide Email Address ID ditemukan untuk ' + emailAddress + ': ' + orgWideEmailId);
        
        return orgWideEmailId;
    }

    /**
     * @description 
     * Mengirimkan Email dari halaman CreateLogBook untuk button Send to Customer
     * @see sendEmail(); dan sendEmail(String logBookId, String fromPage)
     * @return PageReference
     * @author Yazid 26-05-2025
     * @date 26-05-2025
     */
    public PageReference sendEmail(){
        // String lbdId = Apexpages.currentPage().getParameters().get('lbdId'); 
        String idLogBook = logBook.Id;
        System.debug('sendEmailtoCustomer >> '+idLogBook);
        // String idLogBook = 'a1wBK000000PWKrYAO';
        sendEmail(idLogBook,'createLogBook');
        return null;
    }

    public PageReference sendEmail(String logBookId, String fromPage){
        System.debug('=============== EMAIL - EMAIL TO TABLET ============= ');
        Messaging.SingleEmailMessage em = new Messaging.SingleEmailMessage();
        List<String> emailToCustomer = new List<String>{TabletEmail};
        String nameCS = '';
        try {
            // untuk keperluan log
            Log_Book_Activitiy__c getCreatedBy = [SELECT Id,CreatedBy.Name, CreatedBy.Email FROM Log_Book_Activitiy__c WHERE Id = :logBookId];
            nameCS = getCreatedBy.CreatedBy.Name;

            Id orgWideEmailId = getOrgWideEmailAddressId();
            System.debug('AMFS : Value Tablet Email ' + emailToCustomer);
            emailList = String.join(emailToCustomer, ',');
            labelEmailTemplateCustomer = System.Label.AMFS_Email_to_Customer; // 'ET_AMFS_Email_to_Customer';
            EmailTemplate emailTemplateId = [SELECT Id, Name, Subject, DeveloperName, HtmlValue FROM EmailTemplate WHERE DeveloperName = :labelEmailTemplateCustomer];
            Log_Book_Activitiy_Detail__c firstLogBookDetail;
            if(fromPage != 'createLogBook'){
                firstLogBookDetail = [
                    SELECT Id, Name, Customer_Name__c, Policy_Name_Holder__c, 
                    Log_Book_Activitiy__r.CSO_Name__c, Log_Book_Activitiy__r.Touch_Point__c,Log_Book_Activitiy__r.Queue_No__c, 
                    Contact_Policy__r.Name, Contact_Policy__r.Policy_No__c, CreatedById, Log_Case__c
                    FROM Log_Book_Activitiy_Detail__c
                    WHERE Id = :logBookId
                ];
            }else{
                firstLogBookDetail = [
                    SELECT Id, Name, Customer_Name__c, Policy_Name_Holder__c, 
                    Log_Book_Activitiy__r.CSO_Name__c, Log_Book_Activitiy__r.Touch_Point__c,Log_Book_Activitiy__r.Queue_No__c, 
                    Contact_Policy__r.Name, Contact_Policy__r.Policy_No__c, CreatedById, Log_Case__c
                    FROM Log_Book_Activitiy_Detail__c
                    WHERE Log_Book_Activitiy__c = :logBookId
                    ORDER BY CreatedDate ASC
                    LIMIT 1
                ];
            }
            String idTemplate = emailTemplateId.Id;
            String emailSubject = emailTemplateId.Subject;
            String htmlBody = emailTemplateId.HtmlValue;

            // Subject Email
            String todayDate = String.valueOf(Date.today());
            emailSubject = emailSubject.replace('{Tanggal}', todayDate);
            emailSubject = emailSubject.replace('{NamaPP}', firstLogBookDetail.Customer_Name__c);
            
            // Email Body
            htmlBody = htmlBody.replace('{namaPP}', firstLogBookDetail.Customer_Name__c);
            htmlBody = htmlBody.replace('{tanggal}', todayDate);
            htmlBody = htmlBody.replace('{polisNo}', firstLogBookDetail.Contact_Policy__r.Policy_No__c);
            String queueNumber = firstLogBookDetail.Log_Book_Activitiy__r.Queue_No__c;
            htmlBody = htmlBody.replace('{queue}', queueNumber);
            htmlBody = htmlBody.replace('{csAgent}', firstLogBookDetail.Log_Book_Activitiy__r.CSO_Name__c);
            htmlBody = htmlBody.replace('{touchPoint}', firstLogBookDetail.Log_Book_Activitiy__r.Touch_Point__c);
            // generate Link in Email Body
            string linkForm = System.label.AMFS_Link_EFORM + logBookId+'&queue='+queueNumber;
            String templateUrl = '<a href="'+linkForm+'">Link</a>';
            htmlBody = htmlBody.replace('{link}', templateUrl);
            
            em.setTemplateId(idTemplate);
            em.setToAddresses(emailToCustomer);
            em.setSubject(emailSubject);
            em.setHtmlBody(htmlBody);
            em.setOrgWideEmailAddressId(orgWideEmailId);
            if (!test.isRunningTest())  Messaging.sendEmail(new List<Messaging.Email> {em});

            E_Form_Log__c efl = new E_Form_Log__c();
            efl.Status__c = 'Send';
            efl.Email_Type__c = 'Customer';
            efl.To_Email_Address__c = emailList;
            efl.Touch_Point__c = logbook.Touch_Point__c;
            efl.Log_Book_Activitiy__c = logBookId;
            efl.Description__c = nameCS + ' Success Sent EFORM link to Tablet Customer';
            insert efl;
            // Email_SMS_Log__c esl = new Email_SMS_Log__c();
            // esl.Status__c = 'Send';
            // esl.Email__c = emailList;
            // esl.Description__c = 'Walk-In : '+nameCS + ' Success Sent EFORM link to Tablet Customer';
            // esl.case__c = firstLogBookDetail.Log_Case__c;
            // esl.Entity__c = 'AMFS';
            // esl.Send_Flag__c = true;
            // esl.Type__c = 'CCC';
            // esl.Touch_Point__c = logbook.Touch_Point__c;
            // esl.Method__c = 'Email';
            // esl.Request_Date__c = Date.today();
            
            // insert esl;
        } catch (Exception e) {
            String stackTrace = e.getStackTraceString();
            String errorTypeName = e.getTypeName();
            String errMsg = nameCS + 
                    ' Failed Sent Email to Tablet Customer ERROR: [LINE ' + e.getLineNumber() + '] ' + e.getMessage() + 
                    ' type error '+errorTypeName+
                    '\nFULL STACK TRACE:\n' + stackTrace;
            // String errMsg = getCreatedBy.CreatedBy.Name + ' Failed Sent Email to Tablet Customer ERROR: [' + e.getLineNumber() + '] ' + e.getMessage();
            System.debug('errMsg'+errMsg);
            E_Form_Log__c efl = new E_Form_Log__c();
            efl.Status__c = 'Failed';
            efl.Email_Type__c = 'Customer';
            efl.To_Email_Address__c = String.join(emailToCustomer, '; ');
            if(String.isNotBlank(nameCS)) efl.Log_Book_Activitiy__c = logBookId;
            if(String.isNotBlank(logbook.Touch_Point__c)) efl.Touch_Point__c = logbook.Touch_Point__c;
            efl.Description__c = errMsg;
            insert efl;

            // Email_SMS_Log__c esl = new Email_SMS_Log__c();
            // esl.Status__c = 'Failed';
            // esl.Email__c = emailList;
            // esl.Description__c = errMsg;
            // esl.case__c = logCase.Id;
            // esl.Entity__c = 'AMFS';
            // esl.Send_Flag__c = true;
            // esl.Type__c = 'CCC';
            // esl.Touch_Point__c = logbook.Touch_Point__c;
            // esl.Method__c = 'Email';
            // esl.Request_Date__c = Date.today();

            // insert esl;
        }

        return checkCaseType();
    }

    
    /**
     * @description 
     * Button Test SendMetadataDipcad
     * @return PageReference null
     * @author Yazid 10-09-2025
     * @date 10-09-2025
     */
    public PageReference sendMetadatatoDipcad(){
        System.debug('=============== Metadata TO DIPCAD ============= ');
        String idLogBook = logBook.Id;
        System.debug('##### AMFS CreateLogBook Send Metadata >> '+idLogBook);
        // idLogBook = 'a1wBK000000gRYTYA2';
        AMFS_SubmitMetadataService.submitMetadataServiceOP(idLogBook);
        AMFS_SubmitMetadataService.submitMetadataService(idLogBook);
        // AMFS_EmailGenerateController.sendEmailtoDipcad(idLogBook,'createLogBook');

        // Email to Dipcad Lama
        /* 
            if(lbdId != null){
                AMFS_EmailGenerateController.sendEmailtoDipcadOld(lbdId,'activity');
            }else{
                String idLogBook = logBook.Id;
                AMFS_EmailGenerateController.sendEmailtoDipcadOld(idLogBook,'createLogBook');
            }
        */
        return null;
    }
    
    /**
     * @description 
     * Function untuk mengirim metadata dan mendapatkan nilai return value 
     * jika success/partial success maka akan dikirim email
     * @return String Success/Failed/Partial 
     * @see AMFS_SubmitMetadataService.submitMetadataService(logBookId);
     * @see AMFS_EmailGenerateController.sendEmailtoDipcad(logBookId,'createLogBook'); 
     * 'createLogBook' hanya sebagai penanda ini dari halaman apa
     * @author Yazid 10-09-2025
     * @date 10-09-2025
     */
    @RemoteAction
    public static String sendEmailandMetadata(Id logBookId) {
        System.debug('##### AMFS CreateLogBook Send Metadata >> '+logBookId);
        
        AMFS_SubmitMetadataService.submitMetadataServiceOP(logBookId);
        AMFS_SubmitMetadataService.submitMetadataService(logBookId);
        

        return 'OK';
    }
    @RemoteAction
    public static String buttonSendEmailandMetadata(Id logBookId) {
        Integer failedStatus = 0;
        List<Log_Book_Activitiy_Detail__c> getLBD = [SELECT id,Status_to_Metadata__c,Status_Metadata__c from Log_Book_Activitiy_Detail__c WHERE Log_Book_Activitiy__c = :logBookId AND EForm__c = true AND Canceled__c = false ORDER BY CreatedDate ASC];
        List<String> failedLBAD = new List<String>();
        for (Log_Book_Activitiy_Detail__c detail : getLBD) {
            if(detail.Status_to_Metadata__c!= null && detail.Status_Metadata__c!=null){
                Map<String, Object> dataMap = (Map<String, Object>) JSON.deserializeUntyped(detail.Status_Metadata__c);
                for(String keys : dataMap.keySet()){
                    Map<String, Object> innerData = (Map<String, Object>) dataMap.get(keys);
                    String status = (String) innerData.get('status');
                    String nameFile = (String) innerData.get('nameFile');
                    String idValue = (String) innerData.get('id');
                    String idValueLBAD = (String) innerData.get('idLBAD');
                    if (status != 'Success' && nameFile == 'LogBook Activity Detail' && idValue == detail.id) {
                        if(status!='On Process'){
                            failedLBAD.add(idValueLBAD);
                        }
                    }
                }
            }
        }
        if(failedLBAD.size() > 0){
            failedStatus++;
        }
        String result;
        if(failedStatus>0){
            result = 'Failed';
        }else {
            result = 'OK';
        }
        return result;
    }

    /**
     * @description 
     * Function untuk mengecek E-FORM sudah selesai diisi/belum sebelum metadata dikirimkan
     * @return Integer 1 = valid; 2 = ada yang belum di Isi; 0 = tidak ada E-Form
     * @author Yazid 10-09-2025
     * @date 10-09-2025
     */
    @RemoteAction
    public static Integer checkDetail(String logBookActivityId) {
        Integer validationFailed = 0;
        // Boolean posDepartmentFound = false;
        Boolean eformFound = false;
        if(String.isBlank(logBookActivityId)){
            return validationFailed;
        }
        System.debug('logBookActivityId >> '+logBookActivityId);
        List<Log_Book_Activitiy_Detail__c> selesaiEForm = new List<Log_Book_Activitiy_Detail__c>();
        List<Log_Book_Activitiy_Detail__c> belumSelesaiEForm = new List<Log_Book_Activitiy_Detail__c>();
        List<Log_Book_Activitiy_Detail__c> details = [
            SELECT Id,Department__c,EForm__c,E_Form__c,Canceled__c from Log_Book_Activitiy_Detail__c where Log_Book_Activitiy__c = :logBookActivityId
        ];
        for (Log_Book_Activitiy_Detail__c detail : details) {
            if(detail.EForm__c == true){
                eformFound = true;
                if(detail.Canceled__c == false){
                    if(detail.E_Form__c == true){
                        selesaiEForm.add(detail);
                    }else{
                        belumSelesaiEForm.add(detail);
                    }
                }
            }
        }
        if (eformFound) {
            if (belumSelesaiEForm.isEmpty()) {
                validationFailed = 1;
            } else {
                validationFailed = 2;
            }
        }
        return validationFailed;
    }

    // untuk button preview dokumen logbook
    public String getRedirectToOtherPage() {
        return '/apex/AMFS_PreviewLogBookDokumen?recordId=' + logBook.Id; 
    }
    
    public String getRedirectToLBA() {
        return '/' + logBook.Id; 
    }
    
    // public PageReference justTesting() {
    //     System.debug('=============== Button Testing ============= ');
    //     String idLogBook = logBook.Id;        
    //     return null;
    // }
    
    public void untukCoverageFunctionPrivate(String caseDataJSON, Log_Book_Activitiy_Detail__c lbaDetail, Case lbaCase){
        try{
            insertCase(caseDataJSON);
            String result = prepareCaseData(lbaDetail,lbaCase);
        } catch(Exception ex){
            String errorMessage =  ex.getStackTraceString() + ' || ' + ex.getTypeName() + ' || ' + ex.getMessage();
            sentErrorCase(errorMessage, caseDataJSON); 
        }
    }

    // END by Yazid MII 09-09-2025
    public void getMultiPicklist() {
        system.debug('Dokumen Tambahan : ' + selectedDokumen);
        system.debug('Dokumen Tambahan : ' + selectedForm);
    }

    @RemoteAction
    public static List<String> getDokumenTambahan() {
        List<String> picklistOptions = new List<String>();
        
        Schema.DescribeFieldResult fieldResult = Log_Book_Activitiy_Detail__c.Dokumen_Tambahan__c.getDescribe(); // Change to your object & field
        List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();
        
        for (Schema.PicklistEntry entry : picklistEntries) {
            //system.debug('Labek: ' + entry.getLabel());
            picklistOptions.add(entry.getLabel()); // Use getValue() if storing API Name
        }
        return picklistOptions;
    }

    @RemoteAction
    public static List<String> getFormTambahan() {
        List<String> picklistOptions = new List<String>();
        
        Schema.DescribeFieldResult fieldResult = Log_Book_Activitiy_Detail__c.Form_Tambahan__c.getDescribe(); // Change to your object & field
        List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();
        
        for (Schema.PicklistEntry entry : picklistEntries) {
            //system.debug('Labek: ' + entry.getLabel());
            picklistOptions.add(entry.getLabel()); // Use getValue() if storing API Name
        }
        return picklistOptions;
    }
}