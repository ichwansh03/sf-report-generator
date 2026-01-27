public class AMFS_SubmitImageServiceQueueable implements Queueable, Database.AllowsCallouts{
    @TestVisible private static Boolean throwEx = false;
    @TestVisible private static Boolean logThrowEx = false;
    @TestVisible private static Boolean disableChaining = false;
    private List<Id> LBDIds;
    private List<Id> idLbadPerFile;
    private List<Map<String,String>> propertiesMetadata;
    private List<Map<String,String>> propertiesImage;
    private List<Id> propertiesImageCV;
    private List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper> resResultTotal;
    private List<Map<String,String>> mapResStatusLBADTotal;
    private Integer index;
    private String type;

    public static List<AppLog__c> listLog = new List<AppLog__c>();
    private static final String APP_DIPCAD = EIPConstant.APP_DIPCAD;
    private static final String ENTITY_AMFS = EIPConstant.ENTITY_AMFS;
    private static final String OPERATIONIMAGE = EIPConstant.OPERATION_UPLOAD_IMAGE;
    private static final String OPERATION = EIPConstant.OPERATION_SUBMIT_METADATA;
    private static final String IMAGETYPE = 'sendImage';
    private static final String METADATATYPE = 'sendMetadata';
    private static final String INITIATETYPE = 'initiate';

    public AMFS_SubmitImageServiceQueueable(
        List<Id> idLbadPerFile,
        List<Id> LBDIds,
        List<Map<String,String>> propertiesMetadata,
        List<Map<String,String>> propertiesImage,
        List<Id> propertiesImageCV,
        Integer index
    ) {
        this.idLbadPerFile = idLbadPerFile;
        this.LBDIds = LBDIds;
        this.propertiesMetadata = propertiesMetadata;
        this.propertiesImage = propertiesImage;
        this.propertiesImageCV = propertiesImageCV;
        this.index = index;
    }

    // for metadata chain
    public AMFS_SubmitImageServiceQueueable(
        List<Id> idLbadPerFile,
        List<Map<String,String>> mapResStatusLBADTotal,
        List<Id> LBDIds,
        List<Map<String,String>> propertiesMetadata,
        List<Map<String,String>> propertiesImage,
        List<Id> propertiesImageCV,
        Integer index,
        String type
    ) {
        this.idLbadPerFile = idLbadPerFile;
        this.mapResStatusLBADTotal = mapResStatusLBADTotal;
        this.LBDIds = LBDIds;
        this.propertiesMetadata = propertiesMetadata;
        this.propertiesImage = propertiesImage;
        this.propertiesImageCV = propertiesImageCV;
        this.index = index;
        this.type = type;
    }

    // for image chain
    public AMFS_SubmitImageServiceQueueable(
        List<Id> idLbadPerFile,
        List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper> resResultTotal,
        List<Map<String,String>> mapResStatusLBADTotal,
        List<Id> LBDIds,
        List<Map<String,String>> propertiesImage,
        List<Id> propertiesImageCV,
        Integer index,
        String type
    ) {
        this.idLbadPerFile = idLbadPerFile;
        this.resResultTotal = resResultTotal;
        this.mapResStatusLBADTotal = mapResStatusLBADTotal;
        this.LBDIds = LBDIds;
        this.propertiesImage = propertiesImage;
        this.propertiesImageCV = propertiesImageCV;
        this.index = index;
        this.type = type;
    }

    public void execute(QueueableContext context) {
        Map<String,String> mapResStatusLBAD = new Map<String,String>();
        List<Map<String,String>> listMapResStatusLBAD = new List<Map<String,String>>();
        if(type == METADATATYPE || type == null){
            system.debug('==== METADATA ==== ' +index);
            Long dtStart = System.now().getTime();
            try {
                if(mapResStatusLBADTotal!=null){
                    for(Map<String,String> l : mapResStatusLBADTotal){
                        listMapResStatusLBAD.add(l);
                    }
                }
                if (index >= propertiesMetadata.size()) {Integer indexImage = 0;System.enqueueJob(new AMFS_SubmitImageServiceQueueable(idLbadPerFile,resResultTotal,mapResStatusLBADTotal,LBDIds ,propertiesImage, propertiesImageCV, indexImage, IMAGETYPE));return;
                }
                // String checkSend;
                // Log_Book_Activitiy_Detail__c currentDetail = [SELECT Id, Status_Metadata__c FROM Log_Book_Activitiy_Detail__c WHERE Id =: LBDIds[index] LIMIT 1];
                // Map<String, Object> dataMap = (Map<String, Object>) JSON.deserializeUntyped(currentDetail.Status_Metadata__c);
                // for(String keys : dataMap.keySet()){
                //     Map<String, Object> innerData = (Map<String, Object>) dataMap.get(keys);
                //     String idValue = (String) innerData.get('id');
                //     String status = (String) innerData.get('status');
                //     system.debug('==== METADATA Check idValue: '+idValue);
                //     if(idValue == LBDIds[index] && status == 'Success'){
                //         checkSend = 'Sudah Terkirim';
                //     }
                //     else {
                //         checkSend = 'Gagal Terkirim';
                //     }
                // }
                // system.debug('==== METADATA Check Status: '+checkSend);
                String request = '';
                String response = '';
                EIPJson requestMetadata = EIPConnector.submitMetadata(OPERATION, ENTITY_AMFS, APP_DIPCAD, propertiesMetadata[index]);
                Long dtEnd = System.now().getTime();
                
                request = EIPConnector.getRequestPrettyPrint();
                response = EIPConnector.getResponsePrettyPrint();
                
                String statusDetail;
                // if(index ==0){
                //     statusDetail='1';
                // }else {
                //     statusDetail='1';
                // }
                if(requestMetadata != null && requestMetadata.Body != null){
                    statusDetail = requestMetadata.Body.status;
                }else {
                    statusDetail = '0';
                }
                String valueStatusDetail;
                if(statusDetail == '1'){
                    valueStatusDetail = 'Success';
                }else {
                    valueStatusDetail = 'Failed';
                }
                system.debug('===== SEND METADATA LBAD ID: '+ propertiesMetadata[index].get('LBAD ID'));
                mapResStatusLBAD.put(propertiesMetadata[index].get('LBAD ID'),valueStatusDetail);
                listMapResStatusLBAD.add(mapResStatusLBAD);
                
                // Insert Log
                logTransaction(response, request, dtStart, dtEnd,String.valueOf(propertiesMetadata[index].get(EIPConstant.PARAM_MSG_POLICY)), String.valueOf(propertiesMetadata[index].get(EIPConstant.PARAM_CASE_NUMBER)), 'M');
                System.enqueueJob(new AMFS_SubmitImageServiceQueueable(idLbadPerFile,listMapResStatusLBAD,LBDIds,propertiesMetadata,propertiesImage,propertiesImageCV,index+1,METADATATYPE));
            } catch (Exception e) {
                Long dtEndEx = System.now().getTime();
                System.debug('####### Error Send Metadata: ' + e.getMessage());
                System.debug(e.getStackTraceString());
                logTransaction(e.getStackTraceString(), '', dtStart, dtEndEx, '', '','M');
            }
        }
        else if(type == IMAGETYPE){
            system.debug('==== IMAGE ==== '+index);
            List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper> resResult = new List<AMFS_PreviewLogBookDokumenController.APIResponseWrapper>();
            Long dtStart = System.now().getTime();
            try {
                if(resResultTotal!=null){
                    for(AMFS_PreviewLogBookDokumenController.APIResponseWrapper l : resResultTotal){
                        resResult.add(l);
                    }
                }
                if (index >= propertiesImage.size()) {
                    Log_Book_Activitiy_Detail__c LBAD = [SELECT Id, Log_Book_Activitiy__c,Log_Book_Activitiy__r.Touch_Point__c, Log_Book_Activitiy__r.Queue_No__c FROM Log_Book_Activitiy_Detail__c WHERE Id IN: LBDIds LIMIT 1];
                    // Id logBookId;
                    String logBookId = LBAD.Log_Book_Activitiy__c;
                    String touchPointLBA = LBAD.Log_Book_Activitiy__r.Touch_Point__c;
                    String queueLBA = LBAD.Log_Book_Activitiy__r.Queue_No__c;
                    System.debug('====== Send Api Image LBA ID: ' + logBookId);
                    AMFS_EmailGenerateController.sendEmailtoDipcad(logBookId, touchPointLBA,queueLBA, 'createLogBook');
                    System.debug('All records processed.');
                    return;
                }
                String statusResult = '';
                String request = '';
                String response = '';
                
                List<ContentVersion> cv = [
                    SELECT Id, VersionData 
                    FROM ContentVersion 
                    WHERE Id = :propertiesImageCV[index]
                    LIMIT 1
                ];
                Blob imageBlob = cv[0].VersionData;
                System.debug('====== Send Api Image for file: ' +index+' - '+ propertiesImage[index].get(EIPConstant.PARAM_DOCUMENT_NAME));
                System.debug('====== Send Api Image Blob Size: ' + index+' - '+imageBlob.size() + ' bytes');
                
                EIPJson requestImage = EIPConnector.addCustomer(OPERATIONIMAGE, ENTITY_AMFS, APP_DIPCAD, imageBlob, propertiesImage[index]);
                Long dtEnd = System.now().getTime();
                // request = EIPConnector.getRequestPrettyPrint();
                // String requestSafePayload = request.replaceAll('"documentMIMETypeCD"\\s*:\\s*"(.*?)"','"documentMIMETypeCD":"[REDACTED BASE64 DATA]"');
                response = EIPConnector.getResponsePrettyPrint();
                String tempStatus;
                // if(index==0){
                //     tempStatus = '0';
                // }else {
                //     tempStatus = '1';
                // }
                if(requestImage.Body != null){
                    tempStatus = requestImage.Body.status;
                }else {
                    tempStatus = '0';
                }
                AMFS_PreviewLogBookDokumenController.APIResponseWrapper result = new AMFS_PreviewLogBookDokumenController.APIResponseWrapper();
                if(tempStatus == '1'){
                    result.status = 'Success';
                }else {
                    result.status = 'Failed';
                }
                result.nameFile = propertiesImage[index].get(EIPConstant.PARAM_DOCUMENT_NAME);
                result.id = propertiesImageCV[index];
                result.idLBAD = idLbadPerFile[index];
                resResult.add(result);
                
                // Insert Log
                logTransaction(response, 'Request Hidden', dtStart, dtEnd, String.valueOf(propertiesImage[index].get(EIPConstant.PARAM_MSG_POLICY)), String.valueOf(propertiesImage[index].get(EIPConstant.PARAM_CASE_NUMBER)), 'I');
                System.debug('HEAP SIZE Queue Image (current): ' + Limits.getHeapSize());
                System.debug('HEAP SIZE Queue Image (max): ' + Limits.getLimitHeapSize());
                
                for (Integer j = 0; j < LBDIds.size(); j++) {
                    Id t = LBDIds[j];
                    String getResult = mapResStatusLBADTotal[j].get(t);
                    AMFS_PreviewLogBookDokumenController.generateResponseData(t, getResult, resResult);
                }
                System.enqueueJob(new AMFS_SubmitImageServiceQueueable(idLbadPerFile,resResult,mapResStatusLBADTotal,LBDIds ,propertiesImage, propertiesImageCV, index+1, IMAGETYPE));
            } catch (Exception e) {
                Long dtEndEx = System.now().getTime();
                System.debug('####### Error Send Image: ' + e.getMessage());
                System.debug(e.getStackTraceString());
                logTransaction(e.getStackTraceString(), '', dtStart, dtEndEx, '', '','I');
            }
        }else {
            system.debug('TYPE NOT FOUND');
        }

        if(!listLog.isEmpty()){
            try {
                if(Test.isRunningTest() && throwEx) {
                    throw new DmlException('Test Exception for Coverage');
                }
                System.debug('#### AMFS listLog size ' + listLog.size() + ' - ' + listLog[0]);
                insert listLog;
            } catch (DmlException e) {
                System.debug('#### AMFS listLog Error ' + e.getMessage());
            }
        }
    }

    public static void logTransaction(String cleanedResponse, String cleanedRequest, Long dtStart, Long dtEnd, String pol, String caseNo, String label) {
        try {
            if(Test.isRunningTest() && logThrowEx && listLog.size() > 0) {
                throw new DmlException('Test DML Exception for Coverage');
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
}