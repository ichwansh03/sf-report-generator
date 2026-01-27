/**
 * @description       : 
 * @author            : Ahmad Yazid Munif
 * @group             : 
 * @last modified on  : 01-10-2025
 * @last modified by  : Muh Syafiq Hidayatullah
**/
public class AMFS_EmailGenerateController {
    public static String touchPoint {get; set;}
    public static List<String> emailtoAddress {get; set;}
    // ET_AMFS_Email_to_DIPCAD
    // ET_AMFS_Submit_Metadata
    private static final String ETSUBMITMETADATA = System.Label.AMFS_Email_to_DIPCAD; 
    public static void sendEmailtoDipcad(String logBookId, String touch, String queueLba, String fromPage){
        List<Log_Book_Activitiy_Detail__c> logBookDetailList;
        List<String> emailADS = new List<String>();
        String nameCS = '';
        
        System.debug('=============== EMAIL - EMAIL TO DIPCAD ============= ');
        List<AMFS_Dipcad_Setting__mdt> dipcadSetting = [SELECT Id, Email__c,Size_Attachment__c FROM AMFS_Dipcad_Setting__mdt WHERE Address_Type__c = 'Receiver'];
        for (AMFS_Dipcad_Setting__mdt setting : dipcadSetting) {
            if (setting.Email__c != null && !String.isBlank(setting.Email__c)) {
                emailADS.add(setting.Email__c);
            }
        }
        System.debug('#### EMAIL ADS '+emailADS);
        // List<AMFS_Dipcad_Setting__mdt> dipcadCCSetting = [SELECT Id, Email__c FROM AMFS_Dipcad_Setting__mdt WHERE Address_Type__c = 'CC'];
        // for (AMFS_Dipcad_Setting__mdt settingCC : dipcadCCSetting) {
        //     if (settingCC.Email__c != null && !String.isBlank(settingCC.Email__c)) {
        //         ccEmail.add(settingCC.Email__c);
        //     }
        // }

        try {
            Id orgWideEmailId = LogBookActivitiyController.getOrgWideEmailAddressId();
            Log_Book_Activitiy__c getCreatedByEmail = [SELECT Id,CreatedBy.Name, CreatedBy.Email from Log_Book_Activitiy__c WHERE Id = :logBookId AND Touch_Point__c=: touch AND Queue_No__c =: queueLba];
            nameCS = getCreatedByEmail.CreatedBy.Name;
            List<Master_Dipcad_Code__c> dipcadCodes = [SELECT Id, Name, Kind_of_Transaction__c, Department__c, Deskripsi__c from Master_Dipcad_Code__c];
            Map<String, Master_Dipcad_Code__c> codeMaps = new Map<String, Master_Dipcad_Code__c>();
            if(!dipcadCodes.isEmpty()){
                for (Master_Dipcad_Code__c code : dipcadCodes) {
                    String combinedKey = code.Kind_of_Transaction__c + '-' + code.Department__c;
                    codeMaps.put(combinedKey, code);
                }
            }
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
            logBookDetailList = [SELECT ID, Log_Case__r.CaseNumber, Log_Book_Activitiy__r.Log_Book_Date__c, Log_Book_Activitiy__r.Touch_Point__c,Log_Book_Activitiy__r.Touch_Point_City__c, Log_Book_Activitiy__r.Queue_No__c, 
                                Log_Book_Activitiy__r.CSO_Name__c, Policy_Number__c, Policy_Name_Holder__c, Product_Type__c, Customer_Name__c, Customer_Relation__c,
                                Is_Policy_Holder__c, Segmentation__c, Department__c, Kind_Of_Transaction__c, Document_Type__c, Document__c, Document_Information__c, 
                                Stamp__c, Remarks_Long_Text__c, Notes__c, Transaction_Type__c, Case_Type__c, Customer_Mood__c, Status__c, Need_CR__c, Log_Case__r.Type, 
                                Log_Case__r.Case_Type_Config__c, Log_Case__r.Case_Type__c, Log_Case__r.Subject, Log_Case__r.Description, Log_Case__r.Description__c, 
                                Log_Case__r.Nature_Config__c, Log_Case__r.Category_Config__c, Log_Case__r.PIC_Department_LU__c, Log_Case__r.Status, Other_Document__c,CreatedDate,
                                Dokumen_Tambahan__c,Form_Tambahan__c, EForm__c, Canceled__c, Contact_Policy__r.Policy_No__c,Form_Utama__c,Status_Metadata__c,Status_to_Metadata__c
                                FROM Log_Book_Activitiy_Detail__c 
                                WHERE Log_Book_Activitiy__c = :getCreatedByEmail.Id];
            touchPoint = logBookDetailList[0].Log_Book_Activitiy__r.Touch_Point__c;
            system.debug('logBookDetailList2 = '+logBookDetailList);
            system.debug('logBookDetailList2.size = '+logBookDetailList.size());
            
            Integer i = 1; // counter untuk semua log book
            Map<String,String> mapDocInsertedDoc = new Map<String,String>();
            Map<String,String> mapDocOtherDoc = new Map<String,String>();

            // get EmailTemplate
            EmailTemplate emailTemplateId = [
                SELECT Id, Name, Subject, DeveloperName, HtmlValue 
                FROM EmailTemplate 
                WHERE DeveloperName = :ETSUBMITMETADATA
            ];
            String idTemplate = emailTemplateId.Id;
            String emailSubject = emailTemplateId.Subject;
            String htmlBody = emailTemplateId.HtmlValue;

            Set<String> allLBAD = new Set<String>();
            Set<String> failedLBAD = new Set<String>();
            for(Log_Book_Activitiy_Detail__c detail : logBookDetailList){
                if(detail.Status_to_Metadata__c!= null && detail.Status_Metadata__c!=null){
                    Map<String, Object> dataMap = (Map<String, Object>) JSON.deserializeUntyped(detail.Status_Metadata__c);
                    for(String keys : dataMap.keySet()){
                        Map<String, Object> innerData = (Map<String, Object>) dataMap.get(keys);
                        String status = (String) innerData.get('status');
                        String nameFile = (String) innerData.get('nameFile');
                        String idValue = (String) innerData.get('id');
                        String idValueLBAD = (String) innerData.get('idLBAD');
                        allLBAD.add(idValueLBAD);
                        if (status != 'Success') {
                            failedLBAD.add(idValueLBAD);
                        }
                    }
                }
            }
            allLBAD.removeAll(failedLBAD);
            system.debug('##### Email LBAD ID: '+allLBAD);
            List<Messaging.Email> listEmailtoDipcad = new List<Messaging.Email>();
            for(Log_Book_Activitiy_Detail__c detail : logBookDetailList){
                Messaging.SingleEmailMessage em = new Messaging.SingleEmailMessage();
                if(detail.EForm__c == true && detail.Canceled__c == false){
                    if(detail.Status_to_Metadata__c!= null && detail.Status_Metadata__c!=null){
                        // system.debug('##### Email Status LBAD Final: ' + detail.Status_to_Metadata__c);
                        // system.debug('##### Email Status Image Json: ' + detail.Status_Metadata__c);
                        Map<String, Object> dataMap = (Map<String, Object>) JSON.deserializeUntyped(detail.Status_Metadata__c);
                        for(String keys : dataMap.keySet()){
                            Map<String, Object> innerData = (Map<String, Object>) dataMap.get(keys);
                            String status = (String) innerData.get('status');
                            String nameFile = (String) innerData.get('nameFile');
                            String idValue = (String) innerData.get('id');
                            String idValueLBAD = (String) innerData.get('idLBAD');
                            for(String successLBAD:allLBAD){
                                if(status =='Success' && nameFile == 'LogBook Activity Detail' && idValue == detail.id && idValueLBAD==successLBAD){
                                    system.debug('##### Email LBAD ID Check Name FileLBAD: '+nameFile);
                                    system.debug('##### Email LBAD ID: '+idValue+' Masuk Status: ' + status+' : '+nameFile);
                                    System.debug('####AMFS Ada EFORM');
                                    List<String> allDocuments = new List<String>();
                                    String key = detail.Kind_Of_Transaction__c.replaceAll('[ _-]', '').toLowerCase();
                                    if(detail.Form_Utama__c != null) key=key+detail.Form_Utama__c.replaceAll('[ _-]', '').toLowerCase();
                                    String masterEReceiptData = eReceiptMap.get(key);
                                    // String key = detail.Kind_Of_Transaction__c;
                                    // String key2= detail.Form_Utama__c;
                                    // String masterEReceiptData = eReceiptMap.get(key+key2);
                                    
                                    if(masterEReceiptData != null){List<String> docLists = (masterEReceiptData).split(',');allDocuments.addAll(docLists);
                                    }                
                                    if(String.isNotBlank(detail.Dokumen_Tambahan__c)){
                                        List<String> documentsInserted = (detail.Dokumen_Tambahan__c).split(';');
                                        allDocuments.addAll(documentsInserted);
                                    }
                                    if(String.isNotBlank(detail.Form_Tambahan__c)){
                                        List<String> documentsInserted = (detail.Form_Tambahan__c).split(';');
                                        allDocuments.addAll(documentsInserted);
                                    }
                                    String combinedDocString = String.join(allDocuments, ',');
                
                                    String currentEmailSubject = emailSubject;
                                    String currentHtmlBody = htmlBody;
                                    String combinedKey = detail.Kind_of_Transaction__c + '-' + detail.Department__c;
                                    Master_Dipcad_Code__c getDipcadCode = codeMaps.get(combinedKey);
                                    String deskripsi = getDipcadCode.Deskripsi__c;
                                    String dipcadCode = getDipcadCode.Name;
                                    currentEmailSubject = currentEmailSubject.replace('{PolisNo}', detail.Contact_Policy__r.Policy_No__c);
                                    currentEmailSubject = currentEmailSubject.replace('{Code}', dipcadCode);
                                    currentHtmlBody = currentHtmlBody.replace('{kindOfTransaction}', detail.Kind_of_Transaction__c);
                                    currentHtmlBody = currentHtmlBody.replace('{documentWrappers}', combinedDocString);
                                    em.setTemplateId(idTemplate);
                                    // jika POS : cukup kirim ke yang handle
                                    // jika ADS : kirim ke email ADS & cc yang handle 
                                    emailtoAddress = new List<String>();
                                    List<String> ccEmail = new List<String>();
                                    if(logBookDetailList[0].Department__c == 'POS'){emailtoAddress.add(getCreatedByEmail.CreatedBy.Email);
                                        // emailtoAddress.add('aulia.syifa@mii.co.id'); //for testing
                                        // emailtoAddress.add('muh.hidayatullah@ms.mii.co.id'); //for testing
                                        // emailtoAddress.add('ahmad.munif@ms.mii.co.id'); //for testing
                                    }
                                    if(logBookDetailList[0].Department__c == 'ADS'){emailtoAddress = emailADS;ccEmail.add(getCreatedByEmail.CreatedBy.Email);
                                    
                                        // ccEmail.add('aulia.syifa@mii.co.id'); //for testing
                                        // ccEmail.add('muh.hidayatullah@ms.mii.co.id'); //for testing
                                    }
                                    System.debug('#### AMFS : Email ke ' + emailtoAddress);        
                                    System.debug('#### AMFS : CC ke ' + ccEmail);
                                    em.setToAddresses(emailtoAddress);
                                    em.setCcAddresses(ccEmail);
                                    em.setSubject(currentEmailSubject);
                                    em.setHtmlBody(currentHtmlBody);
                                    em.setSaveAsActivity(false);
                                    em.setOrgWideEmailAddressId(orgWideEmailId);
                                    // System.debug('#### AMFS Email '+em);
                                    listEmailtoDipcad.add(em);
                                }
                            }
                        }
                    }
                }
            }
            // System.debug('####AMFS listEmailtoDipcad '+listEmailtoDipcad);
            if(listEmailtoDipcad != null){
                if (!test.isRunningTest()) Messaging.sendEmail(listEmailtoDipcad);
                E_Form_Log__c efl = new E_Form_Log__c();
                efl.Status__c = 'Send';
                efl.Email_Type__c = 'Metadata';
                efl.To_Email_Address__c = String.join(emailtoAddress, '; ');
                efl.Touch_Point__c = touchPoint;
                efl.Log_Book_Activitiy__c = logBookId;
                efl.Description__c = nameCS + ' Success Sent Metadata';
                insert efl;
            }
        } catch (Exception e) {
            String stackTrace = e.getStackTraceString();
            String errMsg = nameCS + 
                    ' Failed Sent Metadata ERROR: [LINE ' + e.getLineNumber() + '] ' + e.getMessage() + 
                    '\nFULL STACK TRACE:\n' + stackTrace;
            // String errMsg = getCreatedByEmail.CreatedBy.Name + ' Sent Metadata ERROR: [' + e.getLineNumber() + '] ' + e.getMessage();
            E_Form_Log__c efl = new E_Form_Log__c();
            efl.Status__c = 'Failed';
            efl.Email_Type__c = 'Metadata';
            efl.To_Email_Address__c = (emailtoAddress != null && !emailtoAddress.isEmpty()) ? String.join(emailtoAddress, '; '): '';
            efl.Touch_Point__c = (String.isNotBlank(touchPoint)) ? touchPoint : '';
            efl.Log_Book_Activitiy__c = (String.isNotBlank(nameCS)) ? logBookId : '';
            efl.Description__c = errMsg;
            insert efl;
        }

        // VisualForce Email - NOT USED
        /*
        try {
            System.debug('#### AMFS logBook.Id '+logBook.Id);
            EmailTemplate emailTemplate = [
                SELECT Id, Name, Subject, DeveloperName
                FROM EmailTemplate 
                WHERE DeveloperName = 'ET_AMFS_Submit_Metadata'
                LIMIT 1
            ];
            String emailSubject = emailTemplate.Subject;
            emailSubject = emailSubject.replace('{PolisNo}', '123123');
            emailSubject = emailSubject.replace('{Code}', 'NONONO');
            String logBookId = logBook.Id;
            Log_Book_Activitiy__c getCreatedByEmail = [SELECT Id, CreatedBy.Email from Log_Book_Activitiy__c WHERE Id = :logBookId];
            String targetuser = getCreatedByEmail.CreatedById;

            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTemplateId(emailTemplate.Id);
            mail.setSubject(emailSubject);
            mail.setWhatId(logBookId);
            mail.setTargetObjectId(targetuser);
            mail.setSaveAsActivity(false);
            mail.setTreatTargetObjectAsRecipient(false);
            
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Email berhasil dikirim!'));

        } catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Gagal mengirim email: ' + e.getMessage()));
        }


        try {
            List<Decimal> listTotalSize = new List<Decimal>();
            List<String> receiverEmail = new List<String>();
            List<String> ccEmail = new List<String>();
            Log_Book_Activitiy__c getCreatedByEmail = [SELECT Id, CreatedBy.Email from Log_Book_Activitiy__c WHERE Id = :logBookId];
            ccEmail.add(getCreatedByEmail.CreatedBy.Email);
            List<AMFS_Dipcad_Setting__mdt> dipcadSetting = [SELECT Id, Email__c,Size_Attachment__c FROM AMFS_Dipcad_Setting__mdt WHERE Address_Type__c = 'Receiver'];
            List<AMFS_Dipcad_Setting__mdt> dipcadCCSetting = [SELECT Id, Email__c FROM AMFS_Dipcad_Setting__mdt WHERE Address_Type__c = 'CC'];
            
            for (AMFS_Dipcad_Setting__mdt setting : dipcadSetting) {
                if (setting.Email__c != null && !String.isBlank(setting.Email__c)) {
                    receiverEmail.add(setting.Email__c);
                    listTotalSize.add(setting.Size_Attachment__c);
                }
            }
            
            for (AMFS_Dipcad_Setting__mdt settingCC : dipcadCCSetting) {
                if (settingCC.Email__c != null && !String.isBlank(settingCC.Email__c)) {
                    ccEmail.add(settingCC.Email__c);
                }
            }
            
            if(listTotalSize.size()>0){
                listTotalSize.sort();
                MAX_EMAIL_TOTAL_ATTACHMENT_MB = listTotalSize[0];
            }else{
                MAX_EMAIL_TOTAL_ATTACHMENT_MB = 22.0;
            }

            System.debug('AMFS : Value Tablet Dipcad ' + receiverEmail +' size : '+MAX_EMAIL_TOTAL_ATTACHMENT_MB);
            System.debug('AMFS : Value Tablet CC Dipcad ' + ccEmail);
            
            List<Messaging.Email> tempEmail = generateEmailBulkSplit(logBookId,fromPage,receiverEmail,ccEmail);
            if(tempEmail != null){
                if (!test.isRunningTest()) Messaging.sendEmail(tempEmail);
            }
            System.debug('Email Send Successfully >> '+logBookId);
        } catch (Exception e) {
            System.debug('*** SENT EMAIL ERROR: [' + e.getLineNumber() + '] ' + e.getMessage());
        }
        */
    }



    // ================= START - OLD SEND EMAIL TO DIPCAD ==================
    /*
    public void sendEmailtoDipcad(String logBookId, String fromPage){
        System.debug('=============== EMAIL - EMAIL TO DIPCAD ============= ');
        Messaging.SingleEmailMessage em = new Messaging.SingleEmailMessage();
        try {
            List<Decimal> listTotalSize = new List<Decimal>();
            List<String> receiverEmail = new List<String>();
            List<String> ccEmail = new List<String>();
            Log_Book_Activitiy__c getCreatedByEmail = [SELECT Id, CreatedBy.Email from Log_Book_Activitiy__c WHERE Id = :logBookId];
            ccEmail.add(getCreatedByEmail.CreatedBy.Email);
            List<AMFS_Dipcad_Setting__mdt> dipcadSetting = [SELECT Id, Email__c,Size_Attachment__c FROM AMFS_Dipcad_Setting__mdt WHERE Address_Type__c = 'Receiver'];
            List<AMFS_Dipcad_Setting__mdt> dipcadCCSetting = [SELECT Id, Email__c FROM AMFS_Dipcad_Setting__mdt WHERE Address_Type__c = 'CC'];
            
            for (AMFS_Dipcad_Setting__mdt setting : dipcadSetting) {
                if (setting.Email__c != null && !String.isBlank(setting.Email__c)) {
                    receiverEmail.add(setting.Email__c);
                    listTotalSize.add(setting.Size_Attachment__c);
                }
            }
            
            for (AMFS_Dipcad_Setting__mdt settingCC : dipcadCCSetting) {
                if (settingCC.Email__c != null && !String.isBlank(settingCC.Email__c)) {
                    ccEmail.add(settingCC.Email__c);
                }
            }
            
            if(listTotalSize.size()>0){
                listTotalSize.sort();
                MAX_EMAIL_TOTAL_ATTACHMENT_MB = listTotalSize[0];
            }else{
                MAX_EMAIL_TOTAL_ATTACHMENT_MB = 22.0;
            }

            System.debug('AMFS : Value Tablet Dipcad ' + receiverEmail +' size : '+MAX_EMAIL_TOTAL_ATTACHMENT_MB);
            System.debug('AMFS : Value Tablet CC Dipcad ' + ccEmail);
            
            List<Messaging.Email> tempEmail = generateEmailBulkSplit(logBookId,fromPage,receiverEmail,ccEmail);
            if(tempEmail != null){
                if (!test.isRunningTest()) Messaging.sendEmail(tempEmail);
            }
            System.debug('Email Send Successfully >> '+logBookId);
        } catch (Exception e) {
            System.debug('*** SENT EMAIL ERROR: [' + e.getLineNumber() + '] ' + e.getMessage());
        }
    }
    public String getContentType(String fileType) {
        String contentType;
        if (fileType == 'PDF') {
            contentType = 'application/pdf';
        } else if (fileType == 'PNG') {
            contentType = 'image/png';
        } else if (fileType == 'JPG' || fileType == 'JPEG') {
            contentType = 'image/jpeg';
        }
        return contentType;
    }

    public List<Messaging.Email> generateEmailBulkSplit(String idLogBook,String page,List<String> emailAddresses,List<String> ccAddresses){
        try{
            System.debug('GenerateEmailBulk');
            labelEmailTemplateDipcad = System.Label.AMFS_Email_to_DIPCAD;
            // labelEmailTemplateDipcad = 'ET_AMFS_Email_to_DIPCAD';
            // query for get Dipcad Code
            List<Master_Dipcad_Code__c> dipcadCodes = [SELECT Id, Name, Kind_of_Transaction__c, Department__c, Deskripsi__c from Master_Dipcad_Code__c];
            Map<String, Master_Dipcad_Code__c> codeMaps = new Map<String, Master_Dipcad_Code__c>();
            if(!dipcadCodes.isEmpty()){
                for (Master_Dipcad_Code__c code : dipcadCodes) {
                    String combinedKey = code.Kind_of_Transaction__c + '-' + code.Department__c;
                    codeMaps.put(combinedKey, code);
                }
            }

            // get EmailTemplate
            EmailTemplate emailTemplateId = [SELECT Id, Name, Subject, DeveloperName, HtmlValue FROM EmailTemplate WHERE DeveloperName = :labelEmailTemplateDipcad];
            String idTemplate = emailTemplateId.Id;
            String emailSubject = emailTemplateId.Subject;
            String htmlBody = emailTemplateId.HtmlValue;

            // get logbookDetail
            List<Log_Book_Activitiy_Detail__c> resultLogBookDetail = new List<Log_Book_Activitiy_Detail__c>();
            if(page != 'createLogBook'){
                resultLogBookDetail = [
                    SELECT Id, Name, Customer_Name__c, Policy_Name_Holder__c, Kind_Of_Transaction__c, Sign_ID__c,Department__c,
                    Log_Book_Activitiy__r.CSO_Name__c, Log_Book_Activitiy__r.Touch_Point__c,Log_Book_Activitiy__r.Queue_No__c, 
                    Contact_Policy__r.Name, Contact_Policy__r.Policy_No__c
                    FROM Log_Book_Activitiy_Detail__c
                    WHERE Id = :idLogBook AND Canceled__c = false AND E_Form__c = true
                ];
            }else{
                resultLogBookDetail = [
                    SELECT Id, Name, Customer_Name__c, Policy_Name_Holder__c, Kind_Of_Transaction__c, Sign_ID__c,Department__c,
                    Log_Book_Activitiy__r.CSO_Name__c, Log_Book_Activitiy__r.Touch_Point__c,Log_Book_Activitiy__r.Queue_No__c, 
                    Contact_Policy__r.Name, Contact_Policy__r.Policy_No__c
                    FROM Log_Book_Activitiy_Detail__c
                    WHERE Log_Book_Activitiy__c = :idLogBook AND Canceled__c = false AND E_Form__c = true
                ];
            }

            List<Id> activityDetailIds = new List<Id>();
            if(!resultLogBookDetail.isEmpty()){
                for (Log_Book_Activitiy_Detail__c d : resultLogBookDetail) {
                    activityDetailIds.add(d.Id);
                }
            }

            // get eformData
            List<E_Form_Master_Data__c> resultEFormMaster = [
                SELECT Id, Name, case_type__c, Log_Book_Activitiy_Detail__c 
                FROM E_Form_Master_Data__c
                WHERE Log_Book_Activitiy_Detail__c IN :activityDetailIds
            ];


            List<Id> eFormIds = new List<Id>();
            Map<Id, E_Form_Master_Data__c> eFormMap = new Map<Id, E_Form_Master_Data__c>();
            if(!resultEFormMaster.isEmpty()){
                for (E_Form_Master_Data__c eForm : resultEFormMaster) {
                    eFormIds.add(eForm.Id);
                    eFormMap.put(eForm.Id, eForm);
                }
            }

            Set<Id> combinedIdSet = new Set<Id>();
            combinedIdSet.addAll(activityDetailIds);
            combinedIdSet.addAll(eFormIds);
            // System.debug('combinedIdSet'+combinedIdSet);

            // get ContentDocumentLink EForm and LogBookDetail
            List<ContentDocumentLink> resultContentDocumentLinks = [
                SELECT Id, LinkedEntityId, ContentDocumentId 
                FROM ContentDocumentLink 
                WHERE LinkedEntityId IN :combinedIdSet
            ];

            System.debug('resultContentDocumentLinks >> '+resultContentDocumentLinks.size());
            List<Id> contentDocLinkIds = new List<Id>();
            Map<Id, ContentDocumentLink> contentDocLinkMap = new Map<Id, ContentDocumentLink>();
            Map<Id, ContentDocumentLink> contentDocLinkMapLBD = new Map<Id, ContentDocumentLink>();
            if(!resultContentDocumentLinks.isEmpty()){
                for (ContentDocumentLink cdl : resultContentDocumentLinks) {
                    // check if contentDocumentLink is from LogBookDetail
                    if(activityDetailIds.contains(cdl.LinkedEntityId)){
                        contentDocLinkMapLBD.put(cdl.ContentDocumentId, cdl);
                    }else{
                        contentDocLinkMap.put(cdl.ContentDocumentId, cdl);
                    }
                    contentDocLinkIds.add(cdl.ContentDocumentId);
                }
            }
            
            List<ContentVersion> resultContentVersion = [
                SELECT id, ContentDocumentId, Title, PathOnClient, FileType, VersionData 
                FROM ContentVersion
                WHERE ContentDocumentId IN :contentDocLinkIds
                AND IsLatest = true
            ];

            List<Id> cVersionIds = new List<Id>();
            Map<Id, ContentVersion> contentVersionMap = new Map<Id, ContentVersion>();
            Map<Id, ContentVersion> createContentVersionMap = new Map<Id, ContentVersion>();
            if(!resultContentVersion.isEmpty()){
                for (ContentVersion cv : resultContentVersion) {
                    cVersionIds.add(cv.Id);
                    contentVersionMap.put(cv.ContentDocumentId, cv);
                    createContentVersionMap.put(cv.Id,cv);
                }
            }
            
            List<Messaging.Email> listEmailtoDipcad = new List<Messaging.Email>();
            for (Log_Book_Activitiy_Detail__c detail : resultLogBookDetail) {
                String currentEmailSubject = emailSubject;
                String currentHtmlBody = htmlBody;
                String combinedKey = detail.Kind_of_Transaction__c + '-' + detail.Department__c;
                Master_Dipcad_Code__c getDipcadCode = codeMaps.get(combinedKey);
                String deskripsi = getDipcadCode.Deskripsi__c;
                String dipcadCode = getDipcadCode.Name;
                // System.debug('getDipcadCode '+dipcadCode+'-'+deskripsi);
                
                currentEmailSubject = currentEmailSubject.replace('{PolisNo}', detail.Contact_Policy__r.Policy_No__c);
                currentEmailSubject = currentEmailSubject.replace('{Code}', dipcadCode);

                currentHtmlBody = currentHtmlBody.replace('{descriptionTransaction}', deskripsi);
                currentHtmlBody = currentHtmlBody.replace('{agentName}', detail.Log_Book_Activitiy__r.CSO_Name__c);

                // System.debug('currentEmailSubject'+currentEmailSubject);
                // System.debug('currentHtmlBody'+currentHtmlBody);
                Decimal totalAttachmentsSizeMB = 0.0;

                List<Messaging.SingleEmailMessage> emailsToSendForThisDetail = new List<Messaging.SingleEmailMessage>();

                // attachment file from eform master data
                List<Messaging.EmailFileAttachment> attachmentsEform = new List<Messaging.EmailFileAttachment>();
                List<Messaging.EmailFileAttachment> attachmentsCurrent = new List<Messaging.EmailFileAttachment>();
                for (E_Form_Master_Data__c eForm : eFormMap.values()){
                    if(eForm.Log_Book_Activitiy_Detail__c == detail.Id){
                        for (ContentDocumentLink cdl : contentDocLinkMap.values()) {
                            if (eForm.Id == cdl.LinkedEntityId) {
                                ContentVersion cv = contentVersionMap.get(cdl.ContentDocumentId);
                                Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
                                attachment.setFileName(cv.Title);
                                attachment.setBody(cv.VersionData);
                                attachment.setContentType(getContentType(cv.FileType));
                                attachmentsCurrent.add(attachment);
                                attachmentsEform.add(attachment);
                                totalAttachmentsSizeMB += (Decimal)cv.VersionData.size() / BYTE_TO_MB_CONVERT;
                            }
                        }
                    }
                }

                if(attachmentsEform.size()>0){
                    for (ContentDocumentLink cdl : contentDocLinkMapLBD.values()) {
                        if (detail.Id == cdl.LinkedEntityId) {
                            ContentVersion cv = contentVersionMap.get(cdl.ContentDocumentId);
                            if(cv.Id != detail.Sign_ID__c){
                                Decimal attachmentSizeMB = (Decimal)cv.VersionData.size() / BYTE_TO_MB_CONVERT;
                                if(Test.isRunningTest()){
                                    if(injectSizeAttachment !=null && injectTotalSizeAttachment!=null){
                                        totalAttachmentsSizeMB = injectTotalSizeAttachment;
                                        attachmentSizeMB = injectSizeAttachment;
                                    }
                                }
                                if (totalAttachmentsSizeMB + attachmentSizeMB > MAX_EMAIL_TOTAL_ATTACHMENT_MB) {
                                    Messaging.SingleEmailMessage em = new Messaging.SingleEmailMessage();
                                    em.setTemplateId(idTemplate);
                                    em.setToAddresses(emailAddresses);
                                    em.setCcAddresses(ccAddresses);
                                    em.setSubject(currentEmailSubject);
                                    em.setHtmlBody(currentHtmlBody);
                                    em.setFileAttachments(attachmentsCurrent);
                                    em.setSaveAsActivity(false);
                                    listEmailtoDipcad.add(em);
                                    attachmentsCurrent = new List<Messaging.EmailFileAttachment>();
                                    totalAttachmentsSizeMB = 0.0;
                                }
                                Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
                                attachment.setFileName(cv.Title);
                                attachment.setBody(cv.VersionData);
                                attachment.setContentType(getContentType(cv.FileType));
                                attachmentsCurrent.add(attachment);
                                totalAttachmentsSizeMB += (Decimal)cv.VersionData.size() / BYTE_TO_MB_CONVERT;
                                System.debug('AMFS : Sent Email cv.Title >>> '+cv.Title);
                                System.debug('AMFS : Sent Email attachment >>> '+attachment);
                            }
                        }
                    }
                    // System.debug('AMFS : Sent attachmentsCurrent >>> '+attachmentsCurrent);
                    if(attachmentsCurrent.size()>0){
                        Messaging.SingleEmailMessage newEm = new Messaging.SingleEmailMessage();
                        newEm.setTemplateId(idTemplate);
                        newEm.setToAddresses(emailAddresses);
                        newEm.setCcAddresses(ccAddresses);
                        newEm.setSubject(currentEmailSubject);
                        newEm.setHtmlBody(currentHtmlBody);
                        newEm.setFileAttachments(attachmentsCurrent);
                        newEm.setSaveAsActivity(false);
                        listEmailtoDipcad.add(newEm);
                    }
                }
            }
            System.debug('Sent Email Successfully : '+listEmailtoDipcad.size());
            return listEmailtoDipcad;
        }catch (Exception e) {
            System.debug('*** SENT EMAIL ERROR: [' + e.getLineNumber() + '] ' + e.getMessage());
            return null;
        }
    }
    */
    // ================= END - OLD SEND EMAIL TO DIPCAD ===================
}