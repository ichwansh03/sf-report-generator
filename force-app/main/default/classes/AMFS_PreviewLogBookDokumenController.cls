/**
 * @description       : 
 * @author            : Ahmad Yazid Munif
 * @group             : 
 * @last modified on  : 09-26-2025
 * @last modified by  : Ahmad Yazid Munif
**/
public without sharing class AMFS_PreviewLogBookDokumenController {
    @TestVisible private static Boolean bypassTrigger = false;
    @TestVisible private static Boolean throwDML = false;
    private static final String DIGITALEX = 'digitalExperience';
    private static final String LOGBOOK = 'logbook';
    private static final String LOGBOOKDETAIL = 'logBookDetail';
    private static final String APIMETADATA = 'metadata';
    public String errorMessage { get; set; }
    public Boolean isLoading { get; set; }
    public Boolean isDE { get; set; }
    public static String lbIdDipcad { get; set; }
    public Id recordId { get; set; } 
    public Id lBookDetailId { get; set; } 
    public Id pageDigitalExperience { get; set; } 
    // List Object
    public List<DetailWrapper> detailWrappers { get; set; }
    // public List<ContentVersion> contentVersions {get; set;}
    public List<Log_Book_Activitiy_Detail__c> resultLogBookDetail {get; set;}
    public List<E_Form_Master_Data__c> resultEFormMaster {get; set;}
    public List<ContentVersion> resultContentVersion {get; set;}
    public List<ContentDocumentLink> resultContentDocumentLinks {get; set;}
    public List<ContentDistribution> resultContentDistribution {get; set;}
    // List ID
    public List<Id> activityDetailIds {get;set;}
    public List<Id> eFormIds {get;set;}
    public Map<Id, E_Form_Master_Data__c> eFormMap {get; set;}
    public List<Id> contentDocLinkIds {get;set;}
    public Map<Id, ContentDocumentLink> contentDocLinkMap {get; set;}
    public List<Id> cVersionIds {get;set;}
    public Map<Id, ContentVersion> contentVersionMap {get; set;}
    public Map<Id, ContentVersion> createContentVersionMap {get; set;}
    public Map<Id, ContentDistribution> distributionMap {get; set;}
    public Map<Id, ContentDistribution> contentDistributionMap {get; set;}
    public String typePage {get;set;}
    // public Boolean tampilkanFlow {get; set;}

    public AMFS_PreviewLogBookDokumenController() {
        cVersionIds = new List<Id>();
        isLoading = true;
        isDE = false;
        try {
            recordId = ApexPages.currentPage().getParameters().get('recordId');
            // lBookDetailId = ApexPages.currentPage().getParameters().get('detail');
            pageDigitalExperience = ApexPages.currentPage().getParameters().get('documentId');
            if(recordId != null) {
                typePage = LOGBOOK;
                loadData(typePage);
            }else{
                // if(lBookDetailId != null){
                //     typePage = 'logBookDetail';
                //     loadData(typePage);
                // } else 
                if(pageDigitalExperience != null){
                    isDE=true;
                    recordId = pageDigitalExperience;
                    typePage = DIGITALEX;
                    loadData(typePage);
                } else{
                    errorMessage = 'Oops! Please save your data first to generate an ID.';
                }
            }
        } catch (Exception e) {
            errorMessage = 'Oops Error! Please save your data first to generate an ID.';
        }
    }
    public AMFS_PreviewLogBookDokumenController(Id lbdId) {
        cVersionIds = new List<Id>();
        this.recordId = lbdId;
        this.typePage = APIMETADATA;
    }
    public void clearAllVariables() {
        resultLogBookDetail = null;
        resultEFormMaster = null;
        resultContentVersion = null;
        resultContentDocumentLinks = null;
        resultContentDistribution = null;
        activityDetailIds = null;
        eFormIds = null;
        eFormMap = null;
        contentDocLinkIds = null;
        contentDocLinkMap = null;
        // cVersionIds = null;
        contentVersionMap = null;
        createContentVersionMap = null;
        distributionMap = null;
        contentDistributionMap = null;
    }

    /**
     * @description 
     * Function untuk memuat seluruh data untuk halaman preview document
     * @author Yazid
     * @date 29-09-2025
     */
    public void loadData(String typeId){
        activityDetailIds = new List<Id>();
        if(typeId==LOGBOOKDETAIL){
            System.debug('Load data logBookDetail'+resultLogBookDetail);
            // resultLogBookDetail = getActivityDetailById();
            // if(!resultLogBookDetail.isEmpty()){
            //     for (Log_Book_Activitiy_Detail__c d : resultLogBookDetail) {
            //         activityDetailIds.add(d.Id);
            //     }
            // }
        }else if(typeId==APIMETADATA){
            System.debug('Load data for Dipcad');
            resultLogBookDetail = getActivityDetails();
            if(!resultLogBookDetail.isEmpty()){
                for (Log_Book_Activitiy_Detail__c d : resultLogBookDetail) {
                    activityDetailIds.add(d.Id);
                }
            }
        }else{
            resultLogBookDetail = getActivityDetails();
            if(!resultLogBookDetail.isEmpty()){
                for (Log_Book_Activitiy_Detail__c d : resultLogBookDetail) {
                    activityDetailIds.add(d.Id);
                }
            }
        }
        System.debug('AMFS : activityDetailIds'+activityDetailIds);
        // get eform master data
        resultEFormMaster = getEFormMasterData(activityDetailIds);
        eFormIds = new List<Id>();
        eFormMap = new Map<Id, E_Form_Master_Data__c>();
        if(!resultEFormMaster.isEmpty()){
            for (E_Form_Master_Data__c eForm : resultEFormMaster) {
                eFormIds.add(eForm.Id);
                eFormMap.put(eForm.Id, eForm);
            }
        }

        eFormIds.addAll(activityDetailIds); // add semua id ActivityDetail untuk file terupload
        // get content document link
        resultContentDocumentLinks = getContentDocumentLink(eFormIds);
        contentDocLinkIds = new List<Id>();
        contentDocLinkMap = new Map<Id, ContentDocumentLink>();
        if(!resultContentDocumentLinks.isEmpty()){
            for (ContentDocumentLink cdl : resultContentDocumentLinks) {
                contentDocLinkIds.add(cdl.ContentDocumentId);
                contentDocLinkMap.put(cdl.ContentDocumentId, cdl);
            }
        }
        System.debug('contentDocLinkIds '+contentDocLinkIds);

        // get content version
        resultContentVersion = getContentVersionIds(contentDocLinkIds);
        
        contentVersionMap = new Map<Id, ContentVersion>();
        createContentVersionMap = new Map<Id, ContentVersion>();
        if(!resultContentVersion.isEmpty()){
            for (ContentVersion cv : resultContentVersion) {
                cVersionIds.add(cv.Id);
                contentVersionMap.put(cv.ContentDocumentId, cv);
                createContentVersionMap.put(cv.Id,cv);
            }
        }
        if(typeId!=APIMETADATA){
            System.debug('cVersionIds '+cVersionIds);
            contentDistributionMap = getContentDistribution(cVersionIds);
        }

        // getDocuments();
        isLoading = false;
    }
    // public List<Log_Book_Activitiy_Detail__c> getActivityDetailById() {
    //     return [
    //         SELECT Id, Name, Policy_Name_Holder__c, Sign_ID__c, Dokumen_Tambahan__c, Log_Book_Activitiy__r.name, Kind_Of_Transaction__c
    //         FROM Log_Book_Activitiy_Detail__c
    //         WHERE Id = :lBookDetailId AND Canceled__c = false
    //     ];
    // }

    /**
     * @description 
     * Get data Log_Book_Activitiy_Detail__c berdasarkan LogBookId
     * @author Yazid
     * @date 29-09-2025
     */
    public List<Log_Book_Activitiy_Detail__c> getActivityDetails() {
        return [
            SELECT Id, Name, Policy_Name_Holder__c, Log_Case__r.CaseNumber, Status_to_Metadata__c,
            Policy_Number__c, Sign_ID__c, Dokumen_Tambahan__c, Status_Metadata__c,Department__c,
            Log_Book_Activitiy__r.name, Kind_Of_Transaction__c, Form_Utama__c
            FROM Log_Book_Activitiy_Detail__c
            WHERE Log_Book_Activitiy__c = :recordId AND EForm__c = true AND Canceled__c = false
            ORDER BY CreatedDate ASC
        ];
    }
    /**
     * @description 
     * Get data Log_Book_Activitiy_Detail__c dengan parameter LogBookActivityId 
     * @author Yazid
     * @date 29-09-2025
     */
    public List<Log_Book_Activitiy_Detail__c> getActivityDetails(String idLogBook) {
        return [
            SELECT Id, Name, Policy_Name_Holder__c, Log_Case__r.CaseNumber, Status_to_Metadata__c,
            Policy_Number__c, Sign_ID__c, Dokumen_Tambahan__c,Status_Metadata__c,Department__c,
            Log_Book_Activitiy__r.name, Kind_Of_Transaction__c, Form_Utama__c
            FROM Log_Book_Activitiy_Detail__c
            WHERE Log_Book_Activitiy__c = :idLogBook AND EForm__c = true AND Canceled__c = false
            ORDER BY CreatedDate ASC
        ];
    }
    /**
     * @description 
     * Get data E_Form_Master_Data__c berdasarkan LogBookActivityDetailId
     * @author Yazid
     * @date 29-09-2025
     */
    public List<E_Form_Master_Data__c> getEFormMasterData(List<Id> activityDetailIds) {
        return [
            SELECT Id, Name, Log_Book_Activitiy_Detail__c, Sign_ID__c, case_type__c,
            Log_Book_Activitiy_Detail__r.Log_Case__r.CaseNumber, 
            Log_Book_Activitiy_Detail__r.Policy_Number__c,
            Log_Book_Activitiy_Detail__r.Kind_Of_Transaction__c,
            Log_Book_Activitiy_Detail__r.Form_Utama__c,
            Log_Book_Activitiy_Detail__r.Department__c
            FROM E_Form_Master_Data__c
            WHERE Log_Book_Activitiy_Detail__c IN :activityDetailIds
        ];
    }

    /**
     * @description 
     * Get data ContentDocumentLink untuk dokumen E-FormId
     * @author Yazid
     * @date 29-09-2025
     */
    public List<ContentDocumentLink> getContentDocumentLink(List<Id> eFormIds) {
        
        // linkedEntity == id eformmasterdata
        return [
            SELECT Id, LinkedEntityId, ContentDocumentId 
            FROM ContentDocumentLink 
            WHERE LinkedEntityId IN :eFormIds
        ];
    }

    /**
     * @description 
     * Get data getContentVersionIds untuk berdasarkan ContentDocumentId setelah getContentDocumentLink
     * @author Yazid
     * @date 29-09-2025
     */
    public List<ContentVersion> getContentVersionIds(List<Id> contentDocumentIds) {
        // berdasarkan contentDocumentId
        return [
            SELECT id, ContentDocumentId, Title, PathOnClient, FileType, VersionData, CreatedDate, FileExtension
            FROM ContentVersion 
            WHERE ContentDocumentId IN :contentDocumentIds
            AND IsLatest = true
        ];
    }

    /**
     * @description 
     * Get data Worktype untuk keperluan DIPCAD sent metadata
     * @author Yazid
     * @date 29-09-2025
     */
    public Map<String,String> getWorktype(String kindOfTransaction, String formUtama) {
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

    /**
     * @description 
     * Get data document Type untuk keperluan DIPCAD sent Image
     * @author Yazid
     * @date 29-09-2025
     */
    public Map<String,Master_Document_Type__c> getDocumentType() {
        Map<String, Master_Document_Type__c> docType = new Map<String, Master_Document_Type__c>();
        List<Master_Document_Type__c> masterDocType = [
            SELECT Id, Name, Document_Type_ADS__c, Document_Type_POS__c
            FROM Master_Document_Type__c
        ];
        
        for(Master_Document_Type__c record : masterDocType) {
            // String cleanedName = record.Name.trim().replaceAll(' ', '').replaceAll('_', '').replaceAll('/', '');
            String cleanedName = record.Name.trim().replaceAll(' ', '').replaceAll('_', '').replaceAll('/', '').toLowerCase();
            // System.debug('#### cleanedName >> '+cleanedName);
            docType.put(cleanedName, record);
        }
        
        return docType;
    }

    // public void generatePDF(String recordId){
    //     // Get the describe for the object
    //     Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get('E_Form_Master_Data__c').getDescribe().fields.getMap();

    //     // Build the field list dynamically
    //     String fields = String.join(new List<String>(fieldMap.keySet()), ',');

    //     // Construct and execute the dynamic SOQL query
    //     String query = 'SELECT ' + fields + ' FROM E_Form_Master_Data__c WHERE Id = :recordId';
    //     List<SObject> results = Database.query(query);

    //     List<E_Form_Master_Data__c> eform = new List<E_Form_Master_Data__c>();
    //     eform.add((E_Form_Master_Data__c)results[0]);

    //     // Call your existing method
    //     AMFS_GeneratePDF.AMFS_GeneratePDF(eform);
    // }
    /**
     * @description 
     * Function yg harus dipanggil lebih dulu ketika load halaman previewdocument
     * agar dokumen bisa di dapatkan dari function getContentDistribution()
     * @author Yazid
     * @date 29-09-2025
     */
    public void createContentDistribution(){
        // for(E_Form_Master_Data__c e:resultEFormMaster ){
        //     system.debug('##### Eform ID List:' + e.Id);
        //     // generatePDF(e.Id);
        // }
        if(recordId == null && lBookDetailId == null && pageDigitalExperience==null) {
            errorMessage = 'Oops! Please save your data first to generate an ID.';
        }else{
            if(cVersionIds.isEmpty() || cVersionIds == null){
                errorMessage = 'Belum ada transaksi yang diselesaikan.';
            }else{
                try {
                    isLoading = true;
                    
                    System.debug('AMFS : Agent Preview cVersionIds '+cVersionIds);
                    Map<Id, ContentVersion> contentVersionCreateMap = new Map<Id, ContentVersion>();
                    for (ContentVersion cv : [SELECT Id, Title FROM ContentVersion WHERE Id IN :cVersionIds]) {
                        contentVersionCreateMap.put(cv.Id, cv);
                    }
                    // System.debug('distributionMap '+distributionMap);
                    // System.debug('contentVersionCreateMap '+contentVersionCreateMap);
                    
                    // Prepare new ContentDistribution
                    List<ContentDistribution> newDistributions = new List<ContentDistribution>();
                    for (Id contentVersionId : cVersionIds) {
                        System.debug('contentVersionId '+contentVersionId);
                        System.debug('contentVersionMap '+contentVersionMap);
                        // System.debug('distributionMap.size()'+distributionMap);
                        
                        
                        if (!distributionMap.containsKey(contentVersionId)) {
                            // System.debug('tidak ada'+contentVersionId);
                            ContentVersion cv = createContentVersionMap.get(contentVersionId);
                            System.debug('tidak ada cv '+cv + ' ' + contentVersionId);
                            
                            ContentDistribution cd = new ContentDistribution();
                            cd.Name = cv.Title;
                            cd.ContentVersionId = contentVersionId;
                            cd.PreferencesAllowViewInBrowser = true;
                            cd.PreferencesLinkLatestVersion = true;
                            cd.PreferencesNotifyOnVisit = false;
                            cd.PreferencesPasswordRequired = false;
                            cd.PreferencesAllowOriginalDownload = true;
                            
                            newDistributions.add(cd);
                            distributionMap.put(contentVersionId, cd);
                        }
                    }
                    if(isDE == false){
                        System.debug('newDistributions'+newDistributions);    
                        // Insert new ContentDistribution records
                        if (!newDistributions.isEmpty()) {
                            insert newDistributions;
                            System.debug('masuk if newContentDistributions');
                        }else{
                            System.debug('existing ContentDistributions');    
                        }
    
    
                        List<Log_Book_Activitiy_Detail__c> newUpdateDetails = new List<Log_Book_Activitiy_Detail__c>();
                        for (Id detailId : activityDetailIds) {
                            Log_Book_Activitiy_Detail__c updateData = new Log_Book_Activitiy_Detail__c();
                            updateData.Id = detailId;
                            updateData.Preview_Document__c = true;
                            newUpdateDetails.add(updateData);
                        }
    
                        if(!newUpdateDetails.isEmpty()){
                            System.debug('AMFS : Update after created distribution');
                            update newUpdateDetails;
                        }else{
                            System.debug('AMFS : Gagal update after created distribution');
                        }
                    }else{
                        System.debug('AMFS : from DigitalExperience');
                    }
                    
                    getDocuments();
                    isLoading = false;
                } catch (Exception e) {
                    errorMessage = 'Oops! Somethings Wrong. '+e.getMessage();
                    System.debug('gagal insert'+e.getMessage());
                }
            }
        }
    }

    /**
     * @description 
     * Function yg harus dipanggil lebih dulu ketika load halaman previewdocument
     * agar dokumen bisa di klik view, download, delete
     * @author Yazid
     * @date 29-09-2025
     */
    public Map<Id, ContentDistribution> getContentDistribution(List<Id> contentVersionIds) {
        // Get existing data ContentDistribution
        distributionMap = new Map<Id, ContentDistribution>();
        resultContentDistribution = [
            SELECT Id, Name, ContentVersionId, DistributionPublicUrl, ContentDownloadUrl
            FROM ContentDistribution
            WHERE ContentVersionId IN :contentVersionIds
        ];

        for (ContentDistribution cd : resultContentDistribution) {
            distributionMap.put(cd.ContentVersionId, cd);
        }

        // System.debug('Get ContentDistribution'+distributionMap);
        
        return distributionMap;
    }
    

    /**
     * @description 
     * Function untuk memetakan setiap dokumen/file dari contentVersion ke masing-masing LogBookDetail dan E-Form
     * di mapping dalam DetailWrapper yang dapat dipanggil di VF AMFS_PreviewLogBookDokumen
     * @author Yazid
     * @date 29-09-2025
     */
    public void getDocuments() {
        detailWrappers = new List<DetailWrapper>();
        System.debug('after insert');
        // System.debug('eFormIdsList '+eFormIds);
        // System.debug('ContentDocumentLink '+contentDocLinkIds);
        // System.debug('resultContentVersion '+resultContentVersion);
        
        // Ambil ContentDistribution berdasarkan ContentVersionId
        System.debug('cVersionIds '+cVersionIds);
        contentDistributionMap = getContentDistribution(cVersionIds);
        
        System.debug('resultLogBookDetail size >>> '+resultLogBookDetail.size());
        for (Log_Book_Activitiy_Detail__c d : resultLogBookDetail) {
            Map<String, APIResponseWrapper> responses = new Map<String, APIResponseWrapper>();
            if (d.Status_Metadata__c != null) {
                responses = (Map<String, APIResponseWrapper>)JSON.deserialize(
                    d.Status_Metadata__c,
                    Map<String, APIResponseWrapper>.class
                );
            }
            // for (Log_Book_Activitiy_Detail__c d : details) {
            DetailWrapper dw = new DetailWrapper();
            dw.detailId = d.Id;
            dw.detailName = d.Name;
            dw.policyNameHolder = d.Policy_Name_Holder__c;
            dw.transactionType = d.Kind_Of_Transaction__c;
            dw.additionalDocuments = d.Dokumen_Tambahan__c;
            dw.transactionFormUtama = d.Form_Utama__c;
            if(d.Status_Metadata__c!=null){
                APIResponseWrapper responseLBD = responses.get(d.Id);
                dw.statusResponse = (responseLBD!=null)? responseLBD.status:'On Process';
            }else {
                dw.statusResponse = 'Pending';
            }
            
            // String statusMdt = 'Pending';
            // if(String.isNotBlank(d.Status_to_Metadata__c)){
            //     if (d.Status_to_Metadata__c.contains('Success')) {
            //         statusMdt = 'Success';
            //     }else{
            //         statusMdt = d.Status_to_Metadata__c;
            //     }
            // }
            // dw.statusResponse = statusMdt;
            system.debug('status response'+d.Status_to_Metadata__c);
            List<ContentDocumentWrapper> detailLevelDocuments = new List<ContentDocumentWrapper>();
            Map<String,ContentDocumentWrapper> documentMapping = new Map<String,ContentDocumentWrapper>();
            for (ContentDocumentLink cdl : contentDocLinkMap.values()) {
                if (d.Id == cdl.LinkedEntityId) { 
                    ContentDocumentWrapper objCDoc = new ContentDocumentWrapper();
                    objCDoc.contentDocumentId = cdl.ContentDocumentId;
                    objCDoc.linkedEntityId = cdl.LinkedEntityId;

                    ContentVersion cv = contentVersionMap.get(cdl.ContentDocumentId);
                    System.debug('result cv >> '+cv);
                    if(cv != null && cv.Id != d.Sign_ID__c && !cv.Title.contains('Tanda Tangan')){
                        String idMapTitle = cv.Title.toLowerCase();
                        idMapTitle = idMapTitle.trim();
                        idMapTitle = idMapTitle.replaceAll(' ', '');
                        idMapTitle = idMapTitle.replaceAll('_', '');
                        List<String> idMapTitleFinal = idMapTitle.split('-');
                        idMapTitle = idMapTitleFinal[0];
                        System.debug('idMapTitle: ' + idMapTitle);
                        
                        objCDoc.title = cv.Title;
                        objCDoc.pathOnClient = cv.PathOnClient;
                        objCDoc.fileType = cv.FileType;
                        objCDoc.contentVersionId = cv.Id;
                        // objCDoc.statusDoc = 'Pending';
                        if(d.Status_to_Metadata__c!=null){
                            APIResponseWrapper responseCV = responses.get(cv.Id);
                            objCDoc.statusDoc = responseCV!= null ? responseCV.status : 'On Process';
                        }else {
                            objCDoc.statusDoc = 'Pending';
                        }
                        
                        if (contentDistributionMap.containsKey(cv.Id)) {
                            objCDoc.documentViewUrl = contentDistributionMap.get(cv.Id).DistributionPublicUrl;
                            objCDoc.documentDownloadUrl = contentDistributionMap.get(cv.Id).ContentDownloadUrl;
                        }
                        detailLevelDocuments.add(objCDoc);
                        documentMapping.put(idMapTitle,objCDoc);
                    }
                }
            }

            Integer documentFound = 0;
            List<String> documentTambahanList = new List<String>();
            Map<String,String> nameDocsMap = new Map<String,String>();
            List<ContentDocumentWrapper> detailLevelDocumentsTest = new List<ContentDocumentWrapper>();
            if(d.Dokumen_Tambahan__c != null){
                documentTambahanList = d.Dokumen_Tambahan__c.split(';');
                System.debug('result documentTambahanList >> '+documentTambahanList);
                for(String doc : documentTambahanList){
                    String cleanedItem = doc.trim();
                    cleanedItem = cleanedItem.toLowerCase();
                    cleanedItem = cleanedItem.replaceAll(' ', '');
                    cleanedItem = cleanedItem.replaceAll('/', '');
                    nameDocsMap.put(cleanedItem,doc);
                }
                // System.debug('DdocumentTambahanList: ' + documentTambahanList);
                // System.debug('nameDocsMap: ' + nameDocsMap);
                
                for(String item : nameDocsMap.keySet()){
                    ContentDocumentWrapper objCDoc = new ContentDocumentWrapper();
                    if (documentMapping.containsKey(item)) {
                        objCDoc = documentMapping.get(item);
                        objCDoc.pathOnClient = nameDocsMap.get(item);
                        documentFound++;
                    }else{
                        objCDoc.pathOnClient = nameDocsMap.get(item);
                        objCDoc.title = '-';
                        objCDoc.fileType = '-';
                        objCDoc.contentVersionId = null;
                        // objCDoc.statusDoc = 'Waiting';
                    }
                    detailLevelDocumentsTest.add(objCDoc);
                }
            }
            
            
            System.debug('detailLevelDocumentsTest: ' + detailLevelDocumentsTest);
            dw.detailDocuments = detailLevelDocumentsTest;
            // System.debug('Detail Documents Size: ' + dw.detailLevelDocumentsTest.size());
            dw.sizeDetail = detailLevelDocumentsTest.size();
            System.debug('eFormMap: ' + eFormMap);
            List<EformWrapper> eFormsData = new List<EformWrapper>();
            for (E_Form_Master_Data__c eForm : eFormMap.values()) {
                EformWrapper objEForm = new EformWrapper();
                if (d.id == eForm.Log_Book_Activitiy_Detail__c) {
                    objEForm.eformId = eForm.Id;
                    objEForm.eformName = eForm.Name;
                    objEForm.caseType = eForm.Case_Type__c;

                    List<ContentDocumentWrapper> documentsData = new List<ContentDocumentWrapper>();
                    for (ContentDocumentLink cdl : contentDocLinkMap.values()) {
                        if (eForm.Id == cdl.LinkedEntityId) {
                            ContentDocumentWrapper objCDoc = new ContentDocumentWrapper();
                            objCDoc.contentDocumentId = cdl.ContentDocumentId;
                            objCDoc.linkedEntityId = cdl.LinkedEntityId;
                            
                            // get from map contentVersion
                            ContentVersion cv = contentVersionMap.get(cdl.ContentDocumentId);
                            // System.debug('cv'+cv);
                            if (cv != null && cv.Id != eForm.Sign_ID__c) {
                                objCDoc.title = cv.Title;
                                System.debug('result documentsData >> '+cv.Title);
                                objCDoc.pathOnClient = cv.PathOnClient;
                                objCDoc.fileType = cv.FileType;
                                objCDoc.contentVersionId = cv.Id;
                                if(d.Status_to_Metadata__c!=null){
                                    APIResponseWrapper responseCV = responses.get(cv.Id);
                                    objCDoc.statusDoc = responseCV!= null ? responseCV.status : 'On Process';
                                }else {
                                    objCDoc.statusDoc = 'Pending';
                                }
                                // objCDoc.statusDoc = 'Pending';
                                // APIResponseWrapper responseCV = responses.get(cv.Id);
                                // if(responseCV!=null) objCDoc.statusDoc = responseCV.status;
                                if (contentDistributionMap.containsKey(cv.Id)) {
                                    objCDoc.distributionId = contentDistributionMap.get(cv.Id).Id;
                                    objCDoc.documentViewUrl = contentDistributionMap.get(cv.Id).DistributionPublicUrl;
                                    objCDoc.documentDownloadUrl = contentDistributionMap.get(cv.Id).ContentDownloadUrl;
                                }
                                documentsData.add(objCDoc);
                            }
                        }
                    }
                    System.debug('result documentsData >> '+documentsData.size());
                    if(documentsData.size() > 0){
                        objEForm.documents = documentsData;
                        eFormsData.add(objEForm);
                    }
                }
            }

            dw.eforms = eFormsData;
            dw.sizeForms = eFormsData.size();
            System.debug('Detail EForm Size: ' + dw.sizeForms);
            if(eFormsData.size()>0 || documentFound>0){
                detailWrappers.add(dw);
            }
        }
        clearAllVariables();
        // System.debug('detailWrappers'+detailWrappers[0]);
    }
    
    /**
     * @description 
     * Function untuk mengecek transaksi tersebut sudah di Review oleh CS atau belum
     * jika belum dari sisi nasabah tidak bisa lanjut
     * @return 'Ready' atau 'NoPreview'
     * @author Yazid
     * @date 29-09-2025
     */
    @InvocableMethod(label='Cek Preview Document')
    public static List<String> checkPreviewDocument(List<String> recordId) {
        List<String> responseMessages = new List<String>();
        try {
            if(Test.isRunningTest()) {
                if(bypassTrigger){
                    throw new QueryException('Simulasi error untuk test class');
                }
            }

            List<Log_Book_Activitiy_Detail__c> lbDetails = [
                SELECT Id, Name, Policy_Name_Holder__c, 
                Dokumen_Tambahan__c, Log_Book_Activitiy__r.name, Kind_Of_Transaction__c, Preview_Document__c
                FROM Log_Book_Activitiy_Detail__c 
                WHERE Log_Book_Activitiy__c IN :recordId AND EForm__c = true AND Canceled__c = false
            ];
            System.debug('lbDetails preview: ' + lbDetails);
            for (Log_Book_Activitiy_Detail__c detail : lbDetails) {
                if (detail.Preview_Document__c == false) {
                    if(responseMessages.isEmpty()){
                        responseMessages.add('NoPreview');
                    }
                }
            }
            if(responseMessages.isEmpty()){
                responseMessages.add('Ready');
            }
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
            // responseMessages.add(0);
            responseMessages.add('NoPreview');
        }
        return responseMessages;
    }

    /**
     * @description 
     * Function untuk menghapus contentDistribution dari dokumen yang terkait di E-Form
     * @return kembali ke halaman PreviewDocument dan akan hilang dokumennya
     * @author Yazid
     * @date 29-09-2025
     */
    public PageReference deleteDistribution(){
        String documentId = Apexpages.currentPage().getParameters().get('documentId'); 
        String lbdId = Apexpages.currentPage().getParameters().get('lbdId'); 
        System.debug('AMFS deleteDistribution >> '+documentId);
        System.debug('AMFS update LogBookDetail >> '+lbdId);
        try {
            List<ContentDocument> delContent = [SELECT Id FROM ContentDocument WHERE id = :documentId];
            delete delContent;
            System.debug('ContentDocument with ID ' + documentId + ' deleted successfully.');
            
            List<ContentDistribution> distributionsToDelete = [
                SELECT Id
                FROM ContentDistribution
                WHERE ContentVersion.ContentDocumentId = :documentId
            ];

            Boolean deleteFile = !distributionsToDelete.isEmpty();
            if(Test.isRunningTest()) {
                if(bypassTrigger){
                    deleteFile=true;
                }
            }
            if (deleteFile) {
                System.debug(distributionsToDelete.size() + ' ContentDistribution records deleted for ContentDocument ' + documentId);
                delete distributionsToDelete;
            } else {
                 System.debug('No ContentDistribution found for ContentDocument ' + documentId);
            }

            Log_Book_Activitiy_Detail__c updateDetailPrevDoc = new Log_Book_Activitiy_Detail__c();
            updateDetailPrevDoc.Id = lbdId;
            updateDetailPrevDoc.Preview_Document__c = false;
            update updateDetailPrevDoc;
            System.debug('Update LBD Success ' + lbdId);
        } catch (Exception e) {
            System.debug('Unexpected error deleting document or distribution: ' + e.getMessage());
        }
        // if (!test.isRunningTest()){
        //     loadData(LOGBOOK);
        //     getDocuments();
        // }
        return null;
    }

    /**
     * @description 
     * Function untuk mendapatkan seluruh data LogBook seperti untuk halaman Preview Dokumen
     * namun dengan return berbeda dan untuk keperluan sent API Metadata DIPCAD
     * @return List<BlobMetadataWrapper>
     * @author Yazid
     * @date 29-09-2025
     */
    public List<BlobMetadataWrapper> getMetadata(String lbId) {
        lbIdDipcad = lbId;
        // lbIdDipcad ='a1wBK000000kiFlYAI';
        System.debug('#### AMFS getMetadata >> '+ lbIdDipcad);
        List<BlobMetadataWrapper> metadata = new List<BlobMetadataWrapper>();
        loadData(APIMETADATA);
        Map<String,Master_Document_Type__c> docTypeData = getDocumentType();
        // Ambil ContentDistribution berdasarkan ContentVersionId
        System.debug('#### AMFS resultLogBookDetail >> '+resultLogBookDetail);
        System.debug('#### AMFS resultLogBookDetail >> '+resultLogBookDetail.size());
        for (Log_Book_Activitiy_Detail__c d : resultLogBookDetail) {
            Map<String,String> worktypeData = getWorktype(d.Kind_Of_Transaction__c, d.Form_Utama__c);
            for (ContentDocumentLink cdl : contentDocLinkMap.values()) {
                if (d.Id == cdl.LinkedEntityId) { 
                    BlobMetadataWrapper objCDoc = new BlobMetadataWrapper();
                    ContentVersion cv = contentVersionMap.get(cdl.ContentDocumentId);
                    System.debug('#### AMFS result cv >> '+cv);
                    if(cv != null && cv.Id != d.Sign_ID__c && !cv.Title.contains('Tanda Tangan')){
                        String titleStr = cv.Title;
                        Integer dashIndex = titleStr.indexOf('-');
                        if (dashIndex > 0) {
                            String beforeDash = titleStr.substring(0, dashIndex).trim();
                            beforeDash = beforeDash.replace('_', ' ');
                            System.debug('## AMFS deetail beforeDash >> '+beforeDash+'-'+titleStr);
                            if(!beforeDash.contains('Tanda Tangan')){
                                objCDoc.contentDocumentId = cdl.ContentDocumentId;
                                objCDoc.linkedEntityId = cdl.LinkedEntityId;
                                objCDoc.contentVersionId = cv.Id;
                                // objCDoc.versionData = cv.versionData;
                                objCDoc.documentName = beforeDash;
                                objCDoc.titleContent = titleStr;
                                // objCDoc.fileType = cv.FileType;
                                objCDoc.fileType = cv.FileExtension;
                                objCDoc.uploadDate = cv.CreatedDate;
                                objCDoc.signDate = cv.CreatedDate;
                                objCDoc.caseNumber = d.Log_Case__r.CaseNumber;
                                objCDoc.policyNumber = d.Policy_Number__c;
                                objCDoc.worktypeTransaction = worktypeData.get(d.Kind_of_Transaction__c);
                                objCDoc.idLBAD = d.Id;

                                String cleanedKey = beforeDash.replaceAll(' ', '').replaceAll('_', '').trim().toLowerCase();
                                Master_Document_Type__c masterDoc = docTypeData.get(cleanedKey);
                                System.debug('#### cleanedKey '+cleanedKey + ' - '+masterDoc);
                                if(masterDoc!=null){
                                    if(d.Department__c == 'POS'){
                                        objCDoc.documentType = masterDoc.Document_Type_POS__c != null? masterDoc.Document_Type_POS__c:'';
                                    }else{
                                        objCDoc.documentType = masterDoc.Document_Type_ADS__c != null? masterDoc.Document_Type_ADS__c:'';
                                    }
                                }else{
                                    objCDoc.documentType = '';
                                }
                                system.debug('#### AMFS objCDoc.documentType'+objCDoc.documentType);
                                objCDoc.statusResponse = 0;
                                metadata.add(objCDoc);
                            }
                        }
                    }
                }
            }
        }
        
        Map<Id, ContentDocumentLink> cdlByLinkedEntityId = new Map<Id, ContentDocumentLink>();
        if(!contentDocLinkMap.isEmpty()){
            for(ContentDocumentLink cdl : contentDocLinkMap.values()) {
                cdlByLinkedEntityId.put(cdl.LinkedEntityId, cdl);
            }
        }
        
        for (E_Form_Master_Data__c eForm : eFormMap.values()) {
            ContentDocumentLink cdl = cdlByLinkedEntityId.get(eForm.Id);
            Map<String,String> worktypeData = getWorktype(eForm.Log_Book_Activitiy_Detail__r.Kind_Of_Transaction__c, eForm.Log_Book_Activitiy_Detail__r.Form_Utama__c);
            System.debug('## AMFS eform result cdl >> '+cdl);
            
            if(cdl != null) {
                BlobMetadataWrapper objCDoc = new BlobMetadataWrapper();
                ContentVersion cv = contentVersionMap.get(cdl.ContentDocumentId);
                System.debug('## AMFS eform result cv >> '+cv);
                if (cv != null && cv.Id != eForm.Sign_ID__c) {
                    String titleStr = cv.Title;
                    String cleanTitle = titleStr.replace('Japen', '').trim();
                    Integer dashIndex = cleanTitle.indexOf('-');
                    Integer dashIndexOriginal = titleStr.indexOf('-');
                    System.debug('## AMFS eform beforeDash >> '+titleStr + ' -> '+cleanTitle);
                    if (dashIndex > 0) {
                        String beforeDash = cleanTitle.substring(0, dashIndex).trim();
                        String beforeDashOriginal = titleStr.substring(0, dashIndexOriginal).trim();
                        objCDoc.contentDocumentId = cdl.ContentDocumentId;
                        objCDoc.linkedEntityId = cdl.LinkedEntityId;
                        objCDoc.contentVersionId = cv.Id;
                        objCDoc.idLBAD = eForm.Log_Book_Activitiy_Detail__r.Id;
                        // objCDoc.versionData = cv.versionData;
                        objCDoc.documentName = beforeDashOriginal;
                        objCDoc.titleContent = titleStr;
                        // objCDoc.fileType = cv.FileType;
                        objCDoc.fileType = cv.FileExtension;
                        objCDoc.uploadDate = cv.CreatedDate;
                        objCDoc.signDate = cv.CreatedDate;
                        objCDoc.caseNumber = eForm.Log_Book_Activitiy_Detail__r.Log_Case__r.CaseNumber;
                        objCDoc.policyNumber = eForm.Log_Book_Activitiy_Detail__r.Policy_Number__c;
                        objCDoc.worktypeTransaction = worktypeData.get(eForm.Log_Book_Activitiy_Detail__r.Kind_Of_Transaction__c);
                        String cleanedKey = beforeDash.replaceAll(' ', '').replaceAll('_', '').trim().toLowerCase();
                        Master_Document_Type__c masterDoc = docTypeData.get(cleanedKey);
                        System.debug('#### cleanedKey getDoctype '+beforeDashOriginal+' <ori-clean> '+cleanedKey + ' - '+masterDoc);
                        if(masterDoc!=null){
                            if(eForm.Log_Book_Activitiy_Detail__r.Department__c == 'POS'){
                                objCDoc.documentType = masterDoc.Document_Type_POS__c != null? masterDoc.Document_Type_POS__c:'';
                            }else{
                                objCDoc.documentType = masterDoc.Document_Type_ADS__c != null? masterDoc.Document_Type_ADS__c:'';
                            }
                            system.debug('#### AMFS objCDoc.documentType >> '+objCDoc.documentType);
                        }else{
                            objCDoc.documentType = '';
                        }
                        objCDoc.statusResponse = 0;
                        metadata.add(objCDoc);
                    }
                }
            }
        }
        clearAllVariables();
        for (BlobMetadataWrapper wrapper : metadata) {
            System.debug('#### AMFS Document Name: ' + wrapper.documentName + ' - '+wrapper.documentType + ' - '+ wrapper.titleContent);
        }
        return metadata;
    }

    public class DetailWrapper {
        public Id detailId { get; set; }
        public String detailName { get; set; }
        public String policyNameHolder { get; set; }
        public String transactionType { get; set; }
        public String transactionFormUtama { get; set; }
        public String additionalDocuments { get; set; }
        public List<ContentDocumentWrapper> detailDocuments { get; set; }
        public Integer sizeDetail {get;set;}
        public List<EformWrapper> eforms { get; set; }
        public Integer sizeForms {get;set;}
        public String statusResponse {get;set;}
    }

    public class EformWrapper {
        public Id eformId { get; set; }
        public String eformName { get; set; }
        public String caseType { get; set; }
        public List<ContentDocumentWrapper> documents { get; set; }
    }

    public class ContentDocumentWrapper {
        public Id contentDocumentId {get; set;}
        public Id linkedEntityId {get; set;}
        public Id contentVersionId {get; set;}
        public Id distributionId {get; set;}
        public String title {get; set;}
        public String pathOnClient {get; set;}
        public String fileType {get; set;}
        public String documentDownloadUrl {get; set;}
        public String documentViewUrl { get; set; }
        public String statusDoc { get; set; }
    }
    
    public class BlobMetadataWrapper{
        public Id contentDocumentId {get; set;}
        public Id linkedEntityId {get; set;}
        public Id contentVersionId {get; set;}
        // public Blob versionData {get;set;}
        public String documentName {get;set;}
        public String titleContent {get; set;}
        public String fileType {get; set;}
        public Datetime uploadDate {get; set;}
        public Datetime signDate {get; set;}
        public String caseNumber {get; set;}
        public String policyNumber {get; set;}
        public String worktypeTransaction {get;set;}
        public String documentType {get;set;}
        public String idLBAD {get; set;}
        public Integer statusResponse {get; set;}
    }

    public class APIResponseWrapper{
        public String id {get; set;}
        public String idLBAD {get; set;}
        public String nameFile {get; set;}
        public String status {get; set;}
    }

    /**
     * @description 
     * Function untuk mendapatkan seluruh data LogBook seperti untuk halaman Preview Dokumen
     * namun dengan return berbeda dan untuk keperluan sent API Metadata DIPCAD
     * @return List<BlobMetadataWrapper>
     * @author Yazid
     * @date 29-09-2025
     */
     
    public static void generateResponseData(Id lbdId,String lbdResponse,List<APIResponseWrapper> response){
        // if(Test.isRunningTest()) {
        //         if(throwDML){
        //             throw new DmlException('Simulasi error untuk test class');
        //         }
        //     }
        if (response == null || response.isEmpty()) {
            System.debug('List respons kosong. Tidak ada data yang disimpan.');
            return;
        }
        Integer totalMetadata = 0;
        Integer totalMetadataSuccess = 0;
        Integer totalMetadataFailed = 0;
        Integer totalMetadataOnProcess = 0;
        Integer totalMetadataOnProcessCount = 0;
        Map<String, APIResponseWrapper> responseMap = new Map<String, APIResponseWrapper>();
        APIResponseWrapper responseLBD = new APIResponseWrapper();
        responseLBD.id = lbdId;
        responseLBD.nameFile = 'LogBook Activity Detail';
        responseLBD.status = lbdResponse;
        responseLBD.idLBAD = lbdId;
        responseMap.put(lbdId,responseLBD);

        // for (APIResponseWrapper res : response) {
        //     if (res.id != null) {
        //         responseMap.put(res.id, res);
        //         totalMetadata++;
        //         totalMetadataOnProcess++;
        //         if(res.status == 'Success'){
        //             totalMetadataSuccess++;
        //         }else if(res.status == 'On Process'){
        //             totalMetadataOnProcessCount++;
        //         }
        //         else{
        //             totalMetadataFailed++;
        //         }
        //     }
        // }
        for (APIResponseWrapper res : response) {
            if (res.id != null) {
                responseMap.put(res.id, res);
            }
        }
        for(String keys : responseMap.keySet()){
            APIResponseWrapper value = responseMap.get(keys);
            
            totalMetadata++;
            totalMetadataOnProcess++;
            if(value.status == 'Success'){
                totalMetadataSuccess++;
            }else if(value.status == 'On Process'){
                totalMetadataOnProcessCount++;
            }
            else{
                totalMetadataFailed++;
            }
        }

        String statusAPIMetadata = '';
        if(totalMetadataOnProcess == totalMetadataOnProcessCount){
            statusAPIMetadata = 'On Process';
        }else if(totalMetadata == totalMetadataSuccess){
            statusAPIMetadata = 'Success';
        }else if(totalMetadata == totalMetadataFailed){
            statusAPIMetadata = 'Failed';
        }else{
            statusAPIMetadata = 'Partial Success';
        }
        String jsonString = JSON.serialize(responseMap, true);
        System.debug('#### AMFS Data JSON id'+lbdId+' - '+statusAPIMetadata+' - '+jsonString);
        try {
            Log_Book_Activitiy_Detail__c updateLogBook = new Log_Book_Activitiy_Detail__c();
            updateLogBook.Id = lbdId;
            updateLogBook.Status_to_Metadata__c = statusAPIMetadata;
            // updateLogBook.Status_to_Metadata__c = lbdResponse;
            updateLogBook.Status_Metadata__c = jsonString;
            update updateLogBook;
            System.debug('#### AMFS Data JSON berhasil disimpan.');
        } catch (DmlException e) {
            System.debug('#### AMFS Terjadi error saat menyimpan data: ' + e.getMessage());
        }
    }
    
    // public List<BlobMetadataWrapper> getMetadataTesting(String lbId) {
    //     lbIdDipcad = lbId;
    //     lbIdDipcad ='a1wBK000000hFqD';
    //     System.debug('#### AMFS getMetadata >> '+ lbIdDipcad);
    //     List<BlobMetadataWrapper> metadata = new List<BlobMetadataWrapper>();
    //     loadData(APIMETADATA);
    //     Map<String,String> worktypeData = getWorktype();
    //     Map<String,Master_Document_Type__c> docTypeData = getDocumentType();
    //     // Ambil ContentDistribution berdasarkan ContentVersionId
    //     System.debug('#### AMFS resultLogBookDetail >> '+resultLogBookDetail);
    //     System.debug('#### AMFS resultLogBookDetail >> '+resultLogBookDetail.size());
    //     for (Log_Book_Activitiy_Detail__c d : resultLogBookDetail) {
    //         for (ContentDocumentLink cdl : contentDocLinkMap.values()) {
    //             if (d.Id == cdl.LinkedEntityId) { 
    //                 BlobMetadataWrapper objCDoc = new BlobMetadataWrapper();
    //                 ContentVersion cv = contentVersionMap.get(cdl.ContentDocumentId);
    //                 System.debug('#### AMFS result cv >> '+cv);
    //                 if(cv != null && cv.Id != d.Sign_ID__c && !cv.Title.contains('Tanda Tangan')){
    //                     String titleStr = cv.Title;
    //                     Integer dashIndex = titleStr.indexOf('-');
    //                     if (dashIndex > 0) {
    //                         String beforeDash = titleStr.substring(0, dashIndex).trim();
    //                         beforeDash = beforeDash.replace('_', ' ');
    //                         System.debug('## AMFS deetail beforeDash >> '+beforeDash+'-'+titleStr);
    //                         if(!beforeDash.contains('Tanda Tangan')){
    //                             objCDoc.contentDocumentId = cdl.ContentDocumentId;
    //                             objCDoc.linkedEntityId = cdl.LinkedEntityId;
    //                             objCDoc.contentVersionId = cv.Id;
    //                             objCDoc.versionData = cv.versionData;
    //                             objCDoc.documentName = beforeDash;
    //                             objCDoc.titleContent = titleStr;
    //                             // objCDoc.fileType = cv.FileType;
    //                             objCDoc.fileType = cv.FileExtension;
    //                             objCDoc.uploadDate = cv.CreatedDate;
    //                             objCDoc.signDate = cv.CreatedDate;
    //                             objCDoc.caseNumber = d.Log_Case__r.CaseNumber;
    //                             objCDoc.policyNumber = d.Policy_Number__c;
    //                             objCDoc.worktypeTransaction = worktypeData.get(d.Kind_of_Transaction__c);

    //                             String cleanedKey = beforeDash.trim().replaceAll(' ', '').replaceAll('_', '');
    //                             Master_Document_Type__c masterDoc = docTypeData.get(cleanedKey);
    //                             System.debug('#### cleanedKey '+cleanedKey + ' - '+masterDoc);
    //                             if(masterDoc!=null){
    //                                 if(d.Department__c == 'POS'){
    //                                     objCDoc.documentType = masterDoc.Document_Type_POS__c != null? masterDoc.Document_Type_POS__c:'';
    //                                 }else{
    //                                     objCDoc.documentType = masterDoc.Document_Type_ADS__c != null? masterDoc.Document_Type_ADS__c:'';
    //                                 }
    //                             }else{
    //                                 objCDoc.documentType = '';
    //                             }
    //                             system.debug('#### AMFS objCDoc.documentType'+objCDoc.documentType);
    //                             objCDoc.statusResponse = 0;
    //                             metadata.add(objCDoc);
    //                         }
    //                     }
    //                 }
    //             }
    //         }
    //     }
        
    //     Map<Id, ContentDocumentLink> cdlByLinkedEntityId = new Map<Id, ContentDocumentLink>();
    //     if(!contentDocLinkMap.isEmpty()){
    //         for(ContentDocumentLink cdl : contentDocLinkMap.values()) {
    //             cdlByLinkedEntityId.put(cdl.LinkedEntityId, cdl);
    //         }
    //     }
        
    //     for (E_Form_Master_Data__c eForm : eFormMap.values()) {
    //         ContentDocumentLink cdl = cdlByLinkedEntityId.get(eForm.Id);
    //         System.debug('## AMFS eform result cdl >> '+cdl);
            
    //         if(cdl != null) {
    //             BlobMetadataWrapper objCDoc = new BlobMetadataWrapper();
    //             ContentVersion cv = contentVersionMap.get(cdl.ContentDocumentId);
    //             System.debug('## AMFS eform result cv >> '+cv);
    //             if (cv != null && cv.Id != eForm.Sign_ID__c) {
    //                 String titleStr = cv.Title;
    //                 Integer dashIndex = titleStr.indexOf('-');
    //                 System.debug('## AMFS eform beforeDash >> '+titleStr);
    //                 if (dashIndex > 0) {
    //                     String beforeDash = titleStr.substring(0, dashIndex).trim();
    //                     objCDoc.contentDocumentId = cdl.ContentDocumentId;
    //                     objCDoc.linkedEntityId = cdl.LinkedEntityId;
    //                     objCDoc.contentVersionId = cv.Id;
    //                     objCDoc.versionData = cv.versionData;
    //                     objCDoc.documentName = beforeDash;
    //                     objCDoc.titleContent = titleStr;
    //                     // objCDoc.fileType = cv.FileType;
    //                     objCDoc.fileType = cv.FileExtension;
    //                     objCDoc.uploadDate = cv.CreatedDate;
    //                     objCDoc.signDate = cv.CreatedDate;
    //                     objCDoc.caseNumber = eForm.Log_Book_Activitiy_Detail__r.Log_Case__r.CaseNumber;
    //                     objCDoc.policyNumber = eForm.Log_Book_Activitiy_Detail__r.Policy_Number__c;
    //                     objCDoc.worktypeTransaction = worktypeData.get(eForm.Log_Book_Activitiy_Detail__r.Kind_Of_Transaction__c);
    //                     String cleanedKey = eForm.Log_Book_Activitiy_Detail__r.Kind_Of_Transaction__c.trim().replaceAll(' ', '').replaceAll('_', '');
    //                     Master_Document_Type__c masterDoc = docTypeData.get(cleanedKey);
    //                     System.debug('#### cleanedKey '+cleanedKey + ' - '+masterDoc);
    //                     if(masterDoc!=null){
    //                         if(eForm.Log_Book_Activitiy_Detail__r.Department__c == 'POS'){
    //                             objCDoc.documentType = masterDoc.Document_Type_POS__c != null? masterDoc.Document_Type_POS__c:'';
    //                         }else{
    //                             objCDoc.documentType = masterDoc.Document_Type_ADS__c != null? masterDoc.Document_Type_ADS__c:'';
    //                         }
    //                         system.debug('#### AMFS objCDoc.documentType'+objCDoc.documentType);
    //                     }else{
    //                         objCDoc.documentType = '';
    //                     }
    //                     objCDoc.statusResponse = 0;
    //                     metadata.add(objCDoc);
    //                 }
    //             }
    //         }
    //     }
    //     clearAllVariables();
    //     for (BlobMetadataWrapper wrapper : metadata) {
    //         System.debug('#### AMFS Document Name: ' + wrapper.documentName + ' - '+wrapper.documentType + ' - '+ wrapper.titleContent);
    //     }
    //     return metadata;
    // }

    // public static List<APIResponseWrapper> dummyData(){
    //     List<APIResponseWrapper> testData = new List<APIResponseWrapper>();
    //     APIResponseWrapper dummyData = new APIResponseWrapper();
    //     dummyData.id = '068BK000003sHTZYA2';
    //     dummyData.nameFile = 'KTP_PP_(Copy) - 302-4513933.jpg';
    //     dummyData.status = 'Success';
    //     testData.add(dummyData);

    //     dummyData = new APIResponseWrapper();
    //     dummyData.id = '068BK000003sLCDYA2';
    //     dummyData.nameFile = 'FP5 - 302-4513933.pdf';
    //     dummyData.status = 'Success';
    //     testData.add(dummyData);
    //     dummyData = new APIResponseWrapper();
    //     dummyData.id = '068BK000003sGm1YAE';
    //     dummyData.nameFile = 'Pemulihan Polis - 302-4513933.pdf';
    //     dummyData.status = 'Failed';
    //     testData.add(dummyData);
    //     return testData;
    // }

    // public static Map<String, APIResponseWrapper> getApiResponseData() {
    //     Log_Book_Activitiy_Detail__c logRecord = [
    //         SELECT Status_Metadata__c
    //         FROM Log_Book_Activitiy_Detail__c
    //         WHERE Id = 'a1xBK0000012yXNYAY'
    //         LIMIT 1
    //     ];

    //     Map<String, APIResponseWrapper> responses = new Map<String, APIResponseWrapper>();

    //     if (logRecord.Status_Metadata__c != null) {
    //         try {
    //             responses = (Map<String, APIResponseWrapper>)JSON.deserialize(
    //                 logRecord.Status_Metadata__c,
    //                 Map<String, APIResponseWrapper>.class
    //             );
    //             // responses = (Map<String, String>)JSON.deserialize(
    //             //     logRecord.Status_Metadata__c,
    //             //     Map<String, String>.class
    //             // );

    //         } catch (Exception e) {
    //             System.debug('#### AMFS Error deserializing JSON: ' + e.getMessage());
    //         }
    //     }
        
    //     return responses;
    // }
}