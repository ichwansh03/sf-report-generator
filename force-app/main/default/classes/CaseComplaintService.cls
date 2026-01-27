public class CaseComplaintService {
    public static HttpCalloutMock mock{get;set;}
    public static String estr {get;set;}
    public static String rstr {get;set;}
    public static String mstr {get;set;}
    public static String errMessage {get;set;}

    private static final String AMFS = 'AMFS';
    private static final String COMPLAINT = 'Complaint';

    public static CaseComplaintAPI.CaseResponse callUpdateFACase(Case caseObj) {
        FA_Integration__mdt config = getConfig('Update_Case');
        mstr = '';
        estr = '';
        rstr = '';
        String endpoint = 'callout:' + config.Named_Credential__c + config.Endpoint__c;
        Http httpObj = new Http();
        HttpRequest requestObj = new HttpRequest();
        HttpResponse responseObj;
        CaseComplaintAPI.CaseRequest cReq = new CaseComplaintAPI.CaseRequest();
        cReq.existing_case = generateCaseExtFromCase(caseObj);
        requestObj.setMethod(config.HTTP_Method__c);
        requestObj.setEndpoint(endpoint);
        requestObj.setHeader('Content-Type','application/json');
        requestObj.setBody(JSON.serialize(cReq, true));
        requestObj.setTimeout(120000);
        mstr = requestObj.getMethod();
        estr = requestObj.getEndpoint();
        if (Test.isRunningTest() && mock != null) {
            responseObj = mock.respond(requestObj);
        }
        else {
            responseObj = httpObj.send(requestObj);
        }
        rstr = responseObj.getBody();
        CaseComplaintAPI.CaseResponse cr = (CaseComplaintAPI.CaseResponse) JSON.deserialize(responseObj.getBody(), CaseComplaintAPI.CaseResponse.class);
        return cr;
    }

    public static List<Attachment> callGetAttachments(String caseExtId) {
        FA_Integration__mdt config = getConfig('Get_Attachments');
        mstr = '';
        estr = '';
        rstr = '';
        String param1 = '?parent_id=';
        String endpoint = 'callout:' + config.Named_Credential__c + config.Endpoint__c;
        Http httpObj = new Http();
        HttpRequest requestObj = new HttpRequest();
        HttpResponse responseObj;
        requestObj.setMethod(config.HTTP_Method__c);
        requestObj.setEndpoint(endpoint + param1 + caseExtId);
        requestObj.setHeader('Content-Type','application/json');
        requestObj.setTimeout(120000);
        mstr = requestObj.getMethod();
        estr = requestObj.getEndpoint();
        if (Test.isRunningTest() && mock != null) {
            responseObj = mock.respond(requestObj);
        }
        else {
            responseObj = httpObj.send(requestObj);
        }
        rstr = responseObj.getBody();
        List<Attachment> resultList = (List<Attachment>) JSON.deserialize(responseObj.getBody(), List<Attachment>.class);
        return resultList;
    }

    public static CaseComplaintAPI.SyncAttachmentResponse callSyncAttachments(String caseExtId) {
        FA_Integration__mdt config = getConfig('Sync_Attachments');
        mstr = '';
        estr = '';
        rstr = '';
        String endpoint = 'callout:' + config.Named_Credential__c + config.Endpoint__c;
        Http httpObj = new Http();
        HttpRequest requestObj = new HttpRequest();
        HttpResponse responseObj;
        CaseComplaintAPI.SyncAttachmentRequest saReq = new CaseComplaintAPI.SyncAttachmentRequest();
        saReq.parent_id = caseExtId;
        requestObj.setMethod(config.HTTP_Method__c);
        requestObj.setEndpoint(endpoint);
        requestObj.setHeader('Content-Type','application/json');
        requestObj.setBody(JSON.serialize(saReq, true));
        requestObj.setTimeout(120000);
        mstr = requestObj.getMethod();
        estr = requestObj.getEndpoint();
        if (Test.isRunningTest() && mock != null) {
            responseObj = mock.respond(requestObj);
        }
        else {
            responseObj = httpObj.send(requestObj);
        }
        rstr = responseObj.getBody();
        CaseComplaintAPI.SyncAttachmentResponse saRes = (CaseComplaintAPI.SyncAttachmentResponse) JSON.deserialize(responseObj.getBody(), CaseComplaintAPI.SyncAttachmentResponse.class);
        return saRes;
    }

    public static void syncFACase(List<Case> caseList, Map<Id, SObject> oldMap) {
        List<String> caseIdList = new List<String>();
        Map<String, String> caseIdMap = new Map<String, String>();
        for (Case caseObj : caseList) {
            Case oldCase = (Case) oldMap.get(caseObj.Id);
            Boolean diffStatus = oldCase.CHS_Status__c == caseObj.CHS_Status__c ? false : true;
            System.debug('***CaseComplaintService syncFACase diffStatus: ' + diffStatus);
            if (diffStatus) {
                FA_Integration__mdt config = getConfig('Update_Case');
                List<String> criteriaList = config.Criteria__c.replaceAll('\r\n|\n|\r','').split('\\s*;\\s*');
                System.debug('***CaseComplaintService syncFACase case values CHS_Status__c: ' + caseObj.CHS_Status__c);
                System.debug('***CaseComplaintService syncFACase case values Entity__c: ' + caseObj.Entity__c);
                System.debug('***CaseComplaintService syncFACase case values Type: ' + caseObj.Type);
                System.debug('***CaseComplaintService syncFACase case values Origin: ' + caseObj.Origin);
                System.debug('***CaseComplaintService syncFACase config values criteriaList: ' + criteriaList);
                System.debug('***CaseComplaintService syncFACase config values Entity__c: ' + config.Entity__c);
                System.debug('***CaseComplaintService syncFACase config values Type__c: ' + config.Type__c);
                System.debug('***CaseComplaintService syncFACase config values Origin__c: ' + config.Origin__c);
                if (criteriaList.contains(caseObj.CHS_Status__c) && caseObj.Entity__c == config.Entity__c && caseObj.Type == config.Type__c && caseObj.Origin == config.Origin__c) {
                    caseIdMap.put(caseObj.Id, caseObj.Id);
                }
            }
        }
        caseIdList.addAll(caseIdMap.values());
        syncFACaseFuture(caseIdList);
    }

    @future(callout=true)
    public static void syncFACaseFuture(List<String> caseIdList) {
        System.debug('***CaseComplaintService syncFACaseFuture caseIdListc: ' + caseIdList);
        DescribeSObjectResult dr = Case.getSObjectType().getDescribe();
        List<String> fieldList = new List<String>(dr.fields.getMap().keySet());
        String fields = String.join(fieldList, ',');
        String q = 'SELECT ' + fields + ' FROM Case WHERE Id IN :caseIdList';
        for (Case caseObj : Database.query(q)) {
            try {
                CaseComplaintAPI.CaseResponse cr = callUpdateFACase(caseObj);
                if (cr != null && cr.success) {
                    // do nothing
                }
                else {
                    errMessage = String.isNotBlank(errMessage) ? errMessage + '. ' + cr.errors.toString() : cr.errors.toString();
                    System.debug('***CaseComplaintService syncFACaseFuture FAILED TO UPDATE CASE: ' + errMessage);
                    throw new CaseComplaintServiceException('FAILED TO UPDATE CASE: ' + errMessage);
                }
            }
            catch (Exception e) {
                String rBodyStr = rstr, methodStr = mstr, endpointStr = estr;
                errMessage = String.isNotBlank(errMessage) ? errMessage + '. ' + e.getMessage() + '. ' + e.getStackTraceString() : e.getMessage() + '. ' + e.getStackTraceString();
                errMessage = String.isNotBlank(errMessage) ? errMessage + '. Endpoint: ' + methodStr + ' ' + endpointStr : 'Endpoint: ' + methodStr + ' ' + endpointStr;
                errMessage = String.isNotBlank(errMessage) ? errMessage + '. Response Body: ' + rBodyStr : 'Response Body: ' + rBodyStr;
                System.debug('***CaseComplaintService syncFACaseFuture FAILED TO UPDATE CASE: ' + errMessage);
                throw new CaseComplaintServiceException('FAILED TO UPDATE CASE: ' + errMessage);
            }
        }
    }

    public static FA_Integration__mdt getConfig(String operationName) {
        DescribeSObjectResult dr = FA_Integration__mdt.getSObjectType().getDescribe();
        List<String> fieldList = new List<String>(dr.fields.getMap().keySet());
        String fields = String.join(fieldList, ',');
        String q = 'SELECT ' + fields + ' FROM FA_Integration__mdt WHERE DeveloperName = :operationName';
        return Database.query(q);
    }

    public static Map<String, Object> generateCaseExtFromCase(Case caseObj) {
        Map<String, Object> result;
        if (caseObj != null) {
            Datetime todayDt = System.now();
            result = new Map<String, Object>();
            result.put('Id', caseObj.Case_Id_External__c);
            result.put('Name', caseObj.Case_No_External__c);
            result.put('Last_Sync__c', todayDt);
            result.put('Status__c', caseObj.Status);
            result.put('Request_Status__c', caseObj.CHS_Status__c);
            result.put('Sub_Status__c', caseObj.Sub_Status__c);
            result.put('Pending_Status__c', caseObj.Pending_Status__c);
            result.put('Occupation__c', caseObj.Occupation__c);
            result.put('Case_Sensitive_Customer__c', caseObj.Case_Sensitive_Customer__c);
            result.put('Policy_No__c', caseObj.Policy_Number__c);
            result.put('Document_Request_Revise__c', caseObj.Document_Request_Revise__c);
        }
        return result;
    }

    public static Case getCaseById(String caseId) {
        Case caseObj;
        DescribeSObjectResult dr = Case.getSObjectType().getDescribe();
        List<String> fieldList = new List<String>(dr.fields.getMap().keySet());
        String fields = String.join(fieldList, ',');
        String q = 'SELECT ' + fields + ' FROM Case WHERE Id = :caseId ORDER BY CreatedDate DESC';
        List<Case> caseList = Database.query(q);
        if (caseList != null && caseList.size() > 0) caseObj = caseList.get(0);
        return caseObj;
    }

    public class CaseComplaintServiceException extends Exception {}
}