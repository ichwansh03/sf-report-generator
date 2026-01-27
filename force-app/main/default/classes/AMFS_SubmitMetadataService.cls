/**
 * @description       : 
 * @author            : Muh Syafiq Hidayatullah
 * @group             : 
 * @last modified on  : 29-09-2025
 * @last modified by  : Muh Syafiq Hidayatullah
**/
public without sharing class AMFS_SubmitMetadataService {
    @TestVisible private static Boolean throwEx = false;
    @TestVisible private static Boolean logThrowEx = false;
    private static final String APP_DIPCAD = EIPConstant.APP_DIPCAD;
    private static final String ENTITY_AMFS = EIPConstant.ENTITY_AMFS;
    private static final String OPERATION = EIPConstant.OPERATION_SUBMIT_METADATA;
    private static final String OPERATIONIMAGE = EIPConstant.OPERATION_UPLOAD_IMAGE;
    private static final String TYPEMETADATA = 'metadata';
    private static final String TYPEIMAGE = 'image';
    private static final String INITIATETYPE = 'initiate';
    private static List<EIPJson> sensitiveResponse {get;set;} 
    public static List<AppLog__c> listLog = new List<AppLog__c>();
    public static List<Id> idLbad = new List<Id>();
    // @future(callout = true)
    public static String submitMetadataService(String inputs) {
        AMFS_SubmitMetadataService.callApiQueue(inputs);
        return 'OK';
    }
    public static String submitMetadataServiceOP(String inputs) {
        List<Map<String,String>> propertiesMetadata = AMFS_SubmitMetadataService.propertiesMap(inputs);
        AMFS_PreviewLogBookDokumenController prevCtrl = new AMFS_PreviewLogBookDokumenController(inputs);
        List<AMFS_PreviewLogBookDokumenController.BlobMetadataWrapper> propertiesImage = prevCtrl.getMetadata(inputs);
        List<Id> propertiesImageCV = AMFS_SubmitMetadataService.propertiesMapImageCV(inputs);
        List<Id> LBDIds = AMFS_SubmitMetadataService.propertiesLBDID(inputs);
        Map<String,String> mapResStatusLBADOP = new Map<String,String>();
        List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper> resResultOP = new List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper>();
        for(Integer i = 0;i<propertiesMetadata.size();i++){
            Map<String,String> r = propertiesMetadata[i];
            String valueStatusDetail = 'On Process';
            mapResStatusLBADOP.put(r.get('LBAD ID'),valueStatusDetail);
        }
        for(AMFS_PreviewLogBookDokumenController.BlobMetadataWrapper r : propertiesImage){
            AMFS_PreviewLogBookDokumenController.APIResponseWrapper resultOP = new AMFS_PreviewLogBookDokumenController.APIResponseWrapper();
            resultOP.status = 'On Process';
            resultOP.nameFile = r.documentName;
            resultOP.id = r.contentVersionId;
            resultOP.idLBAD = r.idLBAD;
            resResultOP.add(resultOP);
            idLbad.add(r.idLBAD);
        }
        System.debug('==== Res Result: ' +resResultOP);
        for (Integer j = 0; j < LBDIds.size(); j++) {
            Id t = LBDIds[j];
            String getResultOP = mapResStatusLBADOP.get(t);
            AMFS_PreviewLogBookDokumenController.generateResponseData(t, getResultOP, resResultOP);
        }
        return 'OK';
    }
    public static void callApiQueue(String inputs){
        List<Map<String,String>> properties = AMFS_SubmitMetadataService.propertiesMap(inputs);
        // Integer i = 1;
        // for (Map<String, String> propMap : properties) {
        //     system.debug('Metadata Ke : '+i);
        //     for (String key : propMap.keySet()) {
        //         System.debug(key + ' = ' + propMap.get(key));
        //     }
        //     i++;
        // }
        List<Map<String,String>> propertiesImage = AMFS_SubmitMetadataService.propertiesMapImage(inputs);
        // Integer j = 1;
        // for (Map<String, String> propMap : propertiesImage) {
        //     system.debug('Image Ke : '+j);
        //     for (String key : propMap.keySet()) {
        //         if (key == 'documentMIMETypeCD') {
        //             continue; // skip key ini
        //         }
        //         System.debug(key + ' = ' + propMap.get(key));
        //     }
        //     j++;
        // }
        List<Id> propertiesImageCV = AMFS_SubmitMetadataService.propertiesMapImageCV(inputs);
        List<Id> LBDIds = AMFS_SubmitMetadataService.propertiesLBDID(inputs);
        Long dtStartEx = System.now().getTime();
        try {
            if(Test.isRunningTest() && throwEx) {
                throw new CalloutException('Test Exception for Coverage');
            }
            Integer indexImage = 0;
            System.enqueueJob(new AMFS_SubmitImageServiceQueueable(idLbad,LBDIds, properties, propertiesImage, propertiesImageCV, indexImage));
        } catch (Exception e) {
            Long dtEndEx = System.now().getTime();
            System.debug('####### Error Send Metadata' + e.getMessage());
            System.debug('####### Error Send Metadata' + e.getStackTraceString());
            logTransaction(e.getStackTraceString(), '', dtStartEx, dtEndEx, '', '','MI');
        }
        if(!listLog.isEmpty()){
            try {
                if(Test.isRunningTest() && logThrowEx && listLog.size() > 0) {
                    throw new DmlException('Test DML Exception for Coverage');
                }
                System.debug('#### AMFS listLog size ' + listLog.size() + ' - ' + listLog[0]);
                insert listLog;
            } catch (DmlException e) {
                System.debug('#### AMFS listLog Error ' + e.getMessage());
            }
        }
    }
    public static List<Map<String, String>> propertiesMap(String inputs){
        List<Log_Book_Activitiy__c> lba = AMFS_SubmitMetadataService.loadData(inputs);
        List<Map<String, String>> properties = new List<Map<String, String>>();
        for(Log_Book_Activitiy__c a: lba){
            for(Log_Book_Activitiy_Detail__c d : a.Log_Book_Activitiy_Details__r){
                if(d.EForm__c == true && d.Canceled__c == false){
                    Map<String,String> worktypeData = getWorktype(d.Kind_Of_Transaction__c, d.Form_Utama__c);
                    String CASE_NUMBER = String.isNotBlank(d.Log_Case__r.CaseNumber) && d.Log_Case__r.CaseNumber!=null? d.Log_Case__r.CaseNumber : '';
                    String MSG_DTTM = String.valueOf(d.CreatedDate);
                    String CUSTOMER_RK = d.Department__c;
                    String MSG_POLICY = d.Policy_Number__c;
                    String TRANSACTION_TYPE = d.Kind_Of_Transaction__c;
                    Map<String, String> prop = new  Map<String, String>();
                    prop.put(EIPConstant.PARAM_CASE_NUMBER, CASE_NUMBER);
                    prop.put(EIPConstant.PARAM_MSG_DTTM, MSG_DTTM);
                    prop.put(EIPConstant.PARAM_TYPE, worktypeData.get(d.Kind_Of_Transaction__c));
                    prop.put(EIPConstant.PARAM_CUSTOMER_RK, CUSTOMER_RK);
                    prop.put(EIPConstant.PARAM_MSG_POLICY, MSG_POLICY);
                    prop.put(EIPConstant.PARAM_SOURCE_CHANNEL_ID, EIPConstant.SOURCE_CHANNEL);
                    prop.put(EIPConstant.PARAM_TRANSACTION_TYPE, TRANSACTION_TYPE);
                    prop.put('LBA ID', a.Id);
                    prop.put('LBA Name', a.Name);
                    prop.put('LBA Touch Point', a.Touch_Point__c);
                    prop.put('LBA Queue Number', a.Queue_No__c);
                    prop.put('LBAD ID', d.Id);
                    prop.put('LBAD Name', d.Name);
                    prop.put('LBAD Case Type', d.Case_Type__c);
                    prop.put('LBAD Log Book Activitiy', d.Log_Book_Activitiy__c);
                    prop.put('LBAD Policy Number', d.Policy_Number__c);
                    Integer idx = 1;
                    for(E_Form_Master_Data__c e : d.E_Forms_Master_Data__r){
                        String metadataEform = e.Metadata__c;
                        if (String.isNotBlank(metadataEform)) {
                            Map<String, Object> rawEFORMMap = (Map<String, Object>) JSON.deserializeUntyped(metadataEform);
                            for(String key : rawEFORMMap.keySet()){
                                Object val = rawEFORMMap.get(key);
                                prop.put(key +'-'+ idx, String.valueOf(val));
                            }
                        }
                        idx++;
                    }
                    properties.add(prop); 
                }
            }
        }
        return properties;
    }

    public static List<Id> propertiesLBDID(String inputs){
        List<Log_Book_Activitiy__c> lba = AMFS_SubmitMetadataService.loadData(inputs);
        List<Id> properties = new List<Id>();
        for(Log_Book_Activitiy__c a: lba){
            for(Log_Book_Activitiy_Detail__c d : a.Log_Book_Activitiy_Details__r){
                if(d.EForm__c == true && d.Canceled__c == false){
                    Id prop;
                    prop=d.Id;
                    // Set<Id> processed = new Set<Id>();
                    // for(E_Form_Master_Data__c e : d.E_Forms_Master_Data__r){
                    //     prop=d.Id;
                    //     if (processed.contains(prop)) {
                    //         continue;
                    //     }
                    //     processed.add(prop);
                    // }
                    properties.add(prop); 
                    
                }
            }
        }
        return properties;
    }

    public static List<Map<String, String>> propertiesMapImage(String inputs){
        List<Map<String, String>> properties = new List<Map<String, String>>();
        AMFS_PreviewLogBookDokumenController prevCtrl = new AMFS_PreviewLogBookDokumenController(inputs);
        List<AMFS_PreviewLogBookDokumenController.BlobMetadataWrapper> metadataList = prevCtrl.getMetadata(inputs);
        for(AMFS_PreviewLogBookDokumenController.BlobMetadataWrapper r : metadataList){
            Map<String, String> prop = new  Map<String, String>();
            prop.put(EIPConstant.PARAM_CASE_NUMBER, String.isNotBlank(r.caseNumber) && r.caseNumber!=null? r.caseNumber : '');
            prop.put(EIPConstant.PARAM_MSG_DTTM, String.valueOf(r.uploadDate));
            prop.put(EIPConstant.PARAM_TYPE, r.worktypeTransaction);
            prop.put(EIPConstant.VALID_FROM_DTTM, String.valueOf(r.signDate));
            prop.put(EIPConstant.PARAM_MSG_POLICY, r.policyNumber);
            prop.put(EIPConstant.PARAM_SOURCE_CHANNEL_ID, EIPConstant.SOURCE_CHANNEL);
            prop.put(EIPConstant.PARAM_DOCUMENT_ID, r.titleContent);
            prop.put(EIPConstant.PARAM_DOCUMENT_NAME, r.documentName);
            prop.put(EIPConstant.PARAM_WORKTYPE, r.documentType);
            properties.add(prop);
        }
        return properties;
    }

    public static List<Id> propertiesMapImageCV(String inputs){
        List<Id> properties = new List<Id>();
        AMFS_PreviewLogBookDokumenController prevCtrl = new AMFS_PreviewLogBookDokumenController(inputs);
        List<AMFS_PreviewLogBookDokumenController.BlobMetadataWrapper> metadataList = prevCtrl.getMetadata(inputs);
        Id tempId;
        for(AMFS_PreviewLogBookDokumenController.BlobMetadataWrapper r : metadataList){
            tempId = r.contentVersionId;
            properties.add(tempId);
        }
        return properties;
    }

    public static List<Log_Book_Activitiy__c> loadData(String recordId){
        List<Log_Book_Activitiy__c> resultLogBook = new List<Log_Book_Activitiy__c>();
        resultLogBook = getActivityData(recordId);
        return resultLogBook;
    }

    public static List<Log_Book_Activitiy__c> getActivityData(String idLogBook) {
        return [
            SELECT Id, Name, Queue_No__c, Touch_Point__c, 
            (SELECT Id, Name, EForm__c, Canceled__c, Case_Type__c, Customer_Mood__c, Customer_Name__c, Customer_Relation__c, Department__c, CreatedDate, 
            Form_Tambahan__c, Form_Utama__c, Dokumen_Tambahan__c, Email_PP__c, Email_Non_PP__c, Is_Policy_Holder__c, Kind_Of_Transaction__c,
            Log_Book_Activitiy__c, Log_Case__c, Need_CR__c, Phone_PP__c, Phone_Non_PP__c, Policy_Name_Holder__c, Policy_Number__c,
            Product_Type__c, Remarks__c, Remarks_Long_Text__c, Segmentation__c, Status__c, Transaction_Type__c, Log_Case__r.CaseNumber, 
            (SELECT Id, Name, Metadata__c
            FROM E_Forms_Master_Data__r)
            FROM Log_Book_Activitiy_Details__r) 
            FROM Log_Book_Activitiy__c 
            WHERE Id = : idLogBook
        ];
    }

    public static Map<String,String> getWorktype(String kindOfTransaction, String formUtama) {
        Map<String, String> worktypeMap = new Map<String, String>();
        List<Master_Dipcad_Code__c> masterDipcadCodes = [
            SELECT Kind_of_Transaction__c, Name
            FROM Master_Dipcad_Code__c 
            WHERE Kind_of_Transaction__c =: kindOfTransaction AND Form_Utama__c =: formUtama LIMIT 1
        ];
        for(Master_Dipcad_Code__c record : masterDipcadCodes) {
            worktypeMap.put(record.Kind_of_Transaction__c, record.Name);
        }
        return worktypeMap;
    }

    public static String getMessageResponse(String input){
        String statusAPIMetadata = input;
        return statusAPIMetadata;
    }

    public static void logTransaction(String cleanedResponse, String cleanedRequest, Long dtStart, Long dtEnd, String pol, String caseNo, String label) {
        try {
            if(Test.isRunningTest()) {
                if(cleanedRequest == 'Error'){
                    throw new QueryException('Simulasi error untuk test class');
                }
            }
            AppLog__c log = new AppLog__c();
            log.Entity__c = ENTITY_AMFS;
            log.Method__c = 'POST';
            log.Policy_App__c = APP_DIPCAD;
            log.Policy_No__c = pol;
            log.Response_Payload__c = cleanedResponse;
            log.StartLongTime__c = dtStart;
            log.EndLongTime__c = dtEnd;
            log.id__c = label+'-' + caseNo;
            log.Request_Value__c = cleanedRequest;
            listLog.add(log);
        } catch (Exception e) {
            System.debug('Error logging transaction: ' + e.getMessage());
            System.debug('Trace: ' + e.getStackTraceString());
        }
    }

    public static void responseJson(String input,List<EIPJson> response){
        sensitiveResponse = response;
        submitMetadataService(input);
    }
}