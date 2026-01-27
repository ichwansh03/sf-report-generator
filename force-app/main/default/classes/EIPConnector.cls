/*
*   to connect EIP by method
*/
public with sharing class EIPConnector {
    private static final String DATE_FORMAT_YYYYMM = 'yyyyMM';
    private static final String DATE_FORMAT_YYYYMMDD = 'yyyyMMdd';
    private static final String DATE_FORMAT_YYYYMMDD_HHMMSS_SSS = 'yyyy-MM-dd HH:mm:ss.SSS';
    private static final String ERROR_MESSAGE = 'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'; 
    
    private static final String HASH_MD5 = 'MD5';
    private static final String HASH_SHA1 = 'SHA1';
    private static final String JATIS = 'JATIS';
    
    private static String requestJSON;
    private static String responseJSON;
    private static String signature;
    private static List<String> paramsOfSignature = new List<String>();
    public static Boolean allowInsertSession = false; // sementara EIP connector di support untuk proses simpan session data
    
    public class EIPConnectorException extends Exception {}
    public class NoDataException extends Exception {}
    public class EIPException extends Exception {}
    
    public static String getRequestPrettyPrint(){
        return requestJSON;
    }
    
    public static String getResponsePrettyPrint(){
        return responseJSON;
    }
    
    public static String getSignature(){
        return signature;
    }
    
    /*
*   construct for standard pagination (0)
*/
    private static EIPJson.EIP_AXAAsiaPagination getPaginationStandard(){
        EIPJson.EIP_AXAAsiaPagination pagination = new EIPJson.EIP_AXAAsiaPagination();
        pagination.startOfRecords = '0';
        pagination.startDateTime = '';
        pagination.rowPerPage = '0';
        pagination.pageNumber = '0';
        pagination.numberOfRecords = '0';
        pagination.endDateTime = '';
        return pagination;
    }
    
    /*
*   construct for Auth header EIP for CCC
*/
    private static void setAuthHeaderCCC(EIPJson eipJson){
        EIPJson.EIP_SecurityContext securityContext = new EIPJson.EIP_SecurityContext();
        securityContext.username = Label.EIP_Username;
        securityContext.password = Label.EIP_Password;
        
        EIPJson.EIP_Header headerCCC = new EIPJson.EIP_Header();
        headerCCC.SecurityContext = securityContext;
        eipJson.Header = headerCCC;
    }
    
    private static void setAuthHeaderCCCRLSWEB(EIPJson eipJson){
        EIPJson.EIP_SecurityContext securityContext = new EIPJson.EIP_SecurityContext();
        securityContext.username = Label.EIP_Username;
        securityContext.password = 'SFDCEIP123!';
        
        EIPJson.EIP_Header headerCCC = new EIPJson.EIP_Header();
        headerCCC.SecurityContext = securityContext;
        eipJson.Header = headerCCC;
    }
    
    private static void initBody(EIPJson.EIP_Body eipRequestBody, String operation, String entity, String appId, boolean isPagination){
        requestJSON = null;
        responseJSON = null; 
        
        eipRequestBody.transactionId = generateUID();
        eipRequestBody.entity = entity;
        eipRequestBody.appID = appId;
        eipRequestBody.operation = operation;
        String eipRequestBodyx = System.JSON.serialize(eipRequestBody, true);
        System.debug('XXX INIT XXX '+eipRequestBodyx);
        
        if(isPagination)
            eipRequestBody.AXAAsiaPagination_Type = getPaginationStandard();
    }
    
    public static EIPJson sendRequest(String signature, String requestJsonEIP, String bizDomain){
        List<Session_Data__c> sessionData = [SELECT session_id__c, data_request__c, data__c FROM Session_Data__c WHERE signature_data__c =:signature LIMIT 1];
        System.debug('=====MASUK SEND REQUEST =====' + sessionData);
        EIPJson eipResponse = new EIPJson();
        if(sessionData.size() > 0){
            requestJSON = sessionData[0].data_request__c;
            responseJSON = sessionData[0].data__c;
            eipResponse = (EIPJson) System.JSON.deserialize(sessionData[0].data__c, EIPJson.class);
        } else {
            System.debug('=====MASUK SEND REQUEST Else=====');
            eipResponse = sendRequest(requestJsonEIP, bizDomain);
            System.debug('allowInsertSession ? '+allowInsertSession);
            if(allowInsertSession){
                try{
                    System.debug('==== Start Insert Session ====');
                    Session_Data__c newSessionData = new Session_Data__c();
                    newSessionData.signature_data__c = signature;
                    newSessionData.data_request__c = requestJsonEIP;
                    newSessionData.data__c = eipResponse.toStringJSON();
                    insert newSessionData;
                    System.debug('==== End Insert Session ====');
                }catch(Exception ex){
                    System.debug('ERROR - Insert session data');
                }
            }
        }
        return eipResponse;
    }
    
    private static EIPJson sendRequest(String requestJsonEIP, String bizDomain){
        EIPJson eipResponse;
        try{
            requestJSON = requestJsonEIP;
            String method='POST';
            
            EIPJson convertReqJson = (EIPJson) System.JSON.deserialize(requestJSON, EIPJson.class);
            
            String endPoint = Label.REST_WS_Endpoint + /*'biz=' +*/ bizDomain ; //comment biz by Beni Rama 14/04/2022
            if (requestJSON.contains(EIPConstant.OPERATION_NOTIF_REMARK) && requestJSON.contains(EIPConstant.APP_RLS_WEB)) {
                endPoint = Label.REST_WS_Endpoint_2 + bizDomain;
            }
          
            RESTWebserviceService rws = new RESTWebserviceService(endPoint, requestJsonEIP, method, Integer.ValueOf(Label.WS_Callout_Timeout));   
            rws.send();
            
            System.debug('response 124456:'+rws.getResponseBody());
            String responseJsonEIP = rws.getResponseBodyReplace();
            responseJSON = responseJsonEIP;
            eipResponse = (EIPJson) System.JSON.deserialize(responseJsonEIP, EIPJson.class);
            
        }catch(EIPConnector.NoDataException e){
            System.debug('No Data Exception EIP Connector sendRequest');
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'No Data Available.'));
        }catch(EIPConnector.EIPConnectorException e){
            System.debug('EIP Connector Exception');
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE+e.getMessage()));
        }catch(Exception e){
            system.debug('error');
            System.debug(e.getStackTraceString());
            System.debug(e.getCause());
            System.debug(e.getMessage());
            throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
        }
        
        return eipResponse;
    }
    
    //Ichwan Sholihin: 12/1/2025 insert record policy notes
    public static RecordPolicyNotesService insertPolicyNotes(String appId, Map<String, String> properties) {
        RecordPolicyNotesService response;
        
        try {
           
            String method = 'POST';
            RecordPolicyNotesService.UWRemarks uwRemarks = new RecordPolicyNotesService.UWRemarks();
            uwRemarks.notificationTypeCode = properties.get(EIPConstant.PARAM_NOTIF_TYPECD);
            uwRemarks.remarkCode = properties.get(EIPConstant.PARAM_REMARK_CODE);
            uwRemarks.departmentCode = 'UW';
            uwRemarks.lastUpdateDate = properties.get(EIPConstant.PARAM_LASTUPDATE_DT);
            uwRemarks.completionDate = properties.get(EIPConstant.PARAM_LASTUPDATE_DT);
            uwRemarks.remarkIssueDate = properties.get(EIPConstant.PARAM_LASTUPDATE_DT);
            uwRemarks.referenceNumber = '';
            uwRemarks.completionStatus = 'R';
            uwRemarks.remarkDescription = properties.get(EIPConstant.PARAM_REMARK_DESC);
            
            RecordPolicyNotesService.Policy policy = new RecordPolicyNotesService.Policy();
            policy.policyNumber = properties.get(EIPConstant.PARAM_MSG_POLICY);
            policy.underwritingRemarks = new RecordPolicyNotesService.UWRemarks[]{uwRemarks};
                
            RecordPolicyNotesService.RequestParameter reqParam = new RecordPolicyNotesService.RequestParameter();
            reqParam.languageCode = 'E';
            reqParam.countryCode = 'IB';
            
            RecordPolicyNotesService.Request request = new RecordPolicyNotesService.Request();
            request.RLSPolicy = policy;
            request.STPRequestParameter = reqParam;
            
            RecordPolicyNotesService notes = new RecordPolicyNotesService();
            notes.RecordPolicyNotesRequest = request;
            
            String requestJsonEIP = System.JSON.serialize(notes, true);
            
            requestJSON = requestJsonEIP;
            RESTWebserviceService service = new RESTWebserviceService(Label.REST_WS_Policy_Notes, requestJsonEIP, method, properties.get('ResubmissionFlag'), 120000);
            service.send();
            
            String responseJsonEIP = service.getResponseBodyReplace();
            responseJSON = responseJsonEIP;
            response = (RecordPolicyNotesService) System.JSON.deserialize(responseJsonEIP, RecordPolicyNotesService.class);
            
        } catch (Exception e) {
            system.debug('>>> RecordPolicyNotesService error <<<');
            System.debug(e.getStackTraceString());
            System.debug(e.getCause());
            System.debug(e.getMessage());
        }
        
        return response;
    }
    
    /*
*   check status from EIP
*   thrown NoDataException for no data and whitelised error code (business error)
*   thrown EIPConnectiorExecption for unexpected error from EIP
*/
    public static void checkStatus(EIPJson.EIP_Body eipBody){
        if(eipBody.status == null)
            throw new EIPConnectorException(EIPConstant.ERROR_MSG_STATUS_NOTFOUND);        
        String status = eipBody.status;
        system.debug('status =='+status);
        if(status == EIPConstant.STATUS_SUCCESS){
            //success
            system.debug ('================ parse success');
        }else if (status == EIPConstant.STATUS_FAILED){
            system.debug('eipBody.exceptionObj.message =='+eipBody.exceptionObj.message);
            // check error code, maybe unexpected error or no data
            if(eipBody.exceptionObj.message == 'Customer not found'){
                throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
            }
            
            if(String.isEmpty(eipBody.exceptionObj.code)){
                system.debug('error code not found, throw error as is');
                throw new EIPConnectorException(eipBody.exceptionObj.message);
            }
            
            if(isNoDataError(eipBody.exceptionObj.code)){
                system.debug ('================ JSON status is 0 with Exception Code is ' + eipBody.exceptionObj.code +  ' (No Data)');
                if(eipBody.exceptionObj.code == '280001'){
                    throw new EIPConnectorException(EIPConstant.ERROR_MSG_OFFLINE);
                }else{
                    throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
                }
            }else if(isUnknownCriteria(eipBody.exceptionObj.code)){
                throw new EIPConnectorException(EIPConstant.ERROR_UNKNOWN_SEARCH_CRIT+eipBody.exceptionObj.message);
            }else if(eipBody.exceptionObj.message == EIPConstant.ERROR_INVALID_PHONE_NUM){
                throw new EIPConnectorException(eipBody.exceptionObj.message);
            }else if(eipBody.exceptionObj.message.startsWith('{')){
                throw new EIPConnectorException(eipBody.exceptionObj.message);
            }else{
                system.debug ('================ error code : '+eipBody.exceptionObj.code);
                system.debug ('================ error message : '+eipBody.exceptionObj.message);
                system.debug ('================ error backEndError : '+eipBody.exceptionObj.backEndError);
                throw new EIPConnectorException(eipBody.exceptionObj.code+';'+eipBody.exceptionObj.backEndError);
            }           
        }else{
            system.debug ('================ error code : '+eipBody.exceptionObj.code);
            system.debug ('================ error message : '+eipBody.exceptionObj.message);
            system.debug ('================ error backEndError : '+eipBody.exceptionObj.backEndError);
            throw new EIPConnectorException(eipBody.exceptionObj.code+';'+eipBody.exceptionObj.backEndError);
        }
    }
    
    public static EIPJson getAccessTokenAMFS() {
        EIPJson eipResponse;
        try {
            String method = 'POST';
            
            EIPJson.EIP_GetToken tokenBody = new EIPJson.EIP_GetToken();
            tokenBody.client_id = System.Label.Client_Id;
            tokenBody.client_secret = System.Label.Client_Secret;
            tokenBody.grant_type = System.Label.Grant_Type;
            tokenBody.audience = System.Label.Audience_SAG;
            
            String requestJsonEIP = System.JSON.serialize(tokenBody, true);
            system.debug('request json eip token: '+requestJsonEIP);
            RESTWebserviceService rws = new RESTWebserviceService(System.Label.Endpoint_SAG, requestJsonEIP, method, Integer.ValueOf(Label.WS_Callout_Timeout));
            rws.send();
            
            String responseJsonEIP = rws.getResponseBodyReplace();
            responseJSON = responseJsonEIP;
            
            eipResponse = (EIPJson) System.JSON.deserialize(responseJsonEIP, EIPJson.class);
            system.debug('rws get token: '+eipResponse);            
        } catch (Exception e) {
            if(System.isFuture()){ 
                throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
            }
            else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
            }            
        }
        
        return eipResponse;
    }
    /*
*   construct for service getPolicyDetails EIP without pagination
*/
    public static EIPJson getPolicyDetails(String operation, String entity, String appId, String policyNumber){
        return getPolicyDetails(operation, entity, appId, policyNumber, false);
    }
    
    /*
*   construct for service getPolicyDetails EIP
*/
    public static EIPJson getPolicyDetails(String operation, String entity, String appId, String policyNumber, boolean isPagination){
        EIPJson eipResponse;
        try{
            System.debug('+++++ getpolicyDetailsCheck ? ');
            String service = EIPConstant.SERVICE_GET_POLICY_DETAIL;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            System.debug('+++++ initBody ? ');
            // construct policy number
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.policyNO = policyNumber;
            
            // construct customer type
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson= new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            customerTypeJson.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{insurancePolicy};
                eipRequestBody.IcAx_AXAAsiaCustomer_Type = customerTypeJson;
            
            EIPJson requestPolicyDetail = new EIPJson();
            requestPolicyDetail.Body = eipRequestBody;
            setAuthHeaderCCC(requestPolicyDetail);
            
            String requestJsonEIP = System.JSON.serialize(requestPolicyDetail, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(policyNumber);
            paramsOfSignature.add(String.valueOf(isPagination));
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getPolicyDetail);
            System.debug('+++++ eipResponse ? '+eipResponse);
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
        }catch(EIPConnector.EIPConnectorException e){
            if(System.isFuture()){ 
                throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
            }
            else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
            }
        }catch(Exception e){
            if(System.isFuture()){ 
                throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
            }
            else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
            }
        }
        
        return eipResponse;
    }
    
    public static EIPJson getPolicyFraud(String operation, String entity, String appId, String policyNumber, String ClaimNo){
        EIPJson eipResponse;
        try{
            Boolean isPagination = false;
            String service = EIPConstant.SERVICE_GET_POLICY_DETAIL;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            
            // construct policy number
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.policyNO = policyNumber;
            
            // construct customer type
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson= new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            customerTypeJson.customerID = ClaimNo;
            customerTypeJson.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{insurancePolicy};
                eipRequestBody.IcAx_AXAAsiaCustomer_Type = customerTypeJson;
            
            EIPJson requestPolicyDetail = new EIPJson();
            requestPolicyDetail.Body = eipRequestBody;
            setAuthHeaderCCC(requestPolicyDetail);
            
            String requestJsonEIP = System.JSON.serialize(requestPolicyDetail, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(policyNumber);
            paramsOfSignature.add(String.valueOf(isPagination));
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getPolicyDetail);
            System.debug('+++++ eipResponse ? '+eipResponse);
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
        }catch(EIPConnector.EIPConnectorException e){
            if(System.isFuture()){ 
                throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
            }
            else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
            }
        }catch(Exception e){
            if(System.isFuture()){ 
                throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
            }
            else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
            }
        }
        
        return eipResponse;
    }
    
    /*
*   construct for service getPaymentHistory EIP without pagination
*/
    public static EIPJson getPaymentHistory(String operation, String entity, String appId, String policyNumber){
        return getPaymentHistory(operation, entity, appId, policyNumber, false);
    }
    
    /*
*   construct for service getPaymentHistory EIP
*/
    public static EIPJson getPaymentHistory(String operation, String entity, String appId, String policyNumber, boolean isPagination){
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_GET_PAYMENT_HISTORY;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            
            // construct policy number
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.policyNO = policyNumber;
            eipRequestBody.AgSa_InsurancePolicy_Type = insurancePolicy;
            
            EIPJson requestPaymentHistory = new EIPJson();
            requestPaymentHistory.Body = eipRequestBody;
            setAuthHeaderCCC(requestPaymentHistory);
            
            String requestJsonEIP = System.JSON.serialize(requestPaymentHistory, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(policyNumber);
            paramsOfSignature.add(String.valueOf(isPagination));
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getPaymentHistory);
            
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }
        
        return eipResponse;
        
    }
    
    /*
*   construct for service getPremiumBreakdown EIP without pagination
*/
    public static EIPJson getPremiumBreakdown(String operation, String entity, String appId, String policyNumber){
        return getPremiumBreakdown(operation, entity, appId, policyNumber, false);
    }
    
    /*
*   construct for service getPremiumBreakdown EIP
*/
    public static EIPJson getPremiumBreakdown(String operation, String entity, String appId, String policyNumber, boolean isPagination){
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_GET_PREMIUM_BREAKDOWN;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            
            // construct policy number
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.policyNO = policyNumber;
            eipRequestBody.AgSa_InsurancePolicy_Type = insurancePolicy;
            
            EIPJson requestPremiumBreakdown = new EIPJson();
            requestPremiumBreakdown.Body = eipRequestBody;
            setAuthHeaderCCC(requestPremiumBreakdown);
            
            String requestJsonEIP = System.JSON.serialize(requestPremiumBreakdown, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(policyNumber);
            paramsOfSignature.add(String.valueOf(isPagination));
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getPremiumBreakdown);
            
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }
        
        return eipResponse;
        
    }
    
    /*
*   construct for service getBeneficiaryDetail EIP without pagination
*/
    public static EIPJson getBeneficiaryDetail(String operation, String entity, String appId, String policyNumber){
        return getBeneficiaryDetail(operation, entity, appId, policyNumber, false);
    }
    
    /*
*   construct for service getBeneficiaryDetail EIP
*/
    public static EIPJson getBeneficiaryDetail(String operation, String entity, String appId, String policyNumber, boolean isPagination){
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_GET_BENEF_DETAIL;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            
            // construct policy number
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.policyNO = policyNumber;
            eipRequestBody.AgSa_InsurancePolicy_Type = insurancePolicy;
            
            EIPJson requestBeneficiaryDetail = new EIPJson();
            requestBeneficiaryDetail.Body = eipRequestBody;
            setAuthHeaderCCC(requestBeneficiaryDetail);
            
            String requestJsonEIP = System.JSON.serialize(requestBeneficiaryDetail, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(policyNumber);
            paramsOfSignature.add(String.valueOf(isPagination));
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getBeneficiaryDetail);
            
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }
        
        return eipResponse;
        
    }
    
    /*
*   construct for service getFundDetail EIP without pagination
*/
    public static EIPJson getFundDetail(String operation, String entity, String appId, String policyNumber){
        return getFundDetail(operation, entity, appId, policyNumber, false);
    }
    
    /*
*   construct for service getFundDetail EIP
*/
    public static EIPJson getFundDetail(String operation, String entity, String appId, String policyNumber, boolean isPagination){
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_GET_FUND_DETAIL;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            
            // construct policy number
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.policyNO = policyNumber;
            eipRequestBody.AgSa_InsurancePolicy_Type = insurancePolicy;
            
            EIPJson requestFundDetail = new EIPJson();
            requestFundDetail.Body = eipRequestBody;
            setAuthHeaderCCC(requestFundDetail);
            
            String requestJsonEIP = System.JSON.serialize(requestFundDetail, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(policyNumber);
            paramsOfSignature.add(String.valueOf(isPagination));
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getFundDetail);
            
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }
        
        return eipResponse;
        
    }
    
    /*
*   construct for service getCustomerInfo EIP without pagination
*/
    public static EIPJson getCustomerInfo(String operation, String entity, String appId, String policyNumber){
        return getCustomerInfo(operation, entity, appId, policyNumber, false);
    }
    
    /*
*   construct for service getCustomerInfo EIP
*/
    public static EIPJson getCustomerInfo(String operation, String entity, String appId, String policyNumber, boolean isPagination){
        Map<String, String> params = new Map<String, String>();
        return getCustomerInfo(operation, entity, appId, policyNumber, isPagination, params);
    }
    
    public static EIPJson getCustomerInfo(String operation, String entity, String appId, String policyNumber, boolean isPagination, Map<String,String> params){
        EIPJson eipResponse;
        try{
            
            String service = EIPConstant.SERVICE_GET_CUST_INFO;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            
            if (operation == EIPConstant.OPERATION_DUKCAPIL_DIRECT_VERIFICATION) {
                system.debug('getCustomerInfo: ' + EIPConstant.OPERATION_DUKCAPIL_DIRECT_VERIFICATION + ': ' + params);
                EIPJson.EIP_IcAx_AXAAsiaCustomer customer = new EIPJson.EIP_IcAx_AXAAsiaCustomer();
                EIPJson.EIP_IcAx_AXAAsiaIndividual individualCustomer = new EIPJson.EIP_IcAx_AXAAsiaIndividual();
                List<EIPJson.EIP_IcAx_AXAAsiaIndividualAddress> hasAddressesIn = new List<EIPJson.EIP_IcAx_AXAAsiaIndividualAddress>();
                EIPJson.EIP_IcAx_AXAAsiaIndividualAddress hasAddress = new EIPJson.EIP_IcAx_AXAAsiaIndividualAddress();
                EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
                // define hasPolicyAccount
                insurancePolicy.policyNO = policyNumber;
                //define hasAddressesIn
                hasAddress.hamletNo = EIPConstant.DEFAULT_HAMLET_NO;
                hasAddressesIn.add(hasAddress);
                //define individualCustomer
                individualCustomer.socialSecurityNO = params.get(EIPConstant.PARAM_MSG_CIF);
                individualCustomer.individualRK = params.get(EIPConstant.PARAM_MSG_PASSWORD);
                individualCustomer.passportNo = params.get(EIPConstant.PARAM_PASSPORT_NO);
                individualCustomer.titleTXT = params.get(EIPConstant.PARAM_TITLE_TXT);
                if (params.get(EIPConstant.PARAM_FULLNAME) != null) individualCustomer.fullNM = params.get(EIPConstant.PARAM_FULLNAME);
                individualCustomer.hasAddressesIn = hasAddressesIn;
                // define customer
                customer.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{insurancePolicy};
                customer.canBeIndividual = individualCustomer;
                eipRequestBody.customer = customer;
            } else {
                if(!String.isEmpty(params.get(EIPConstant.PARAM_MSG_CIF))){
                    EIPJson.EIP_IcAx_AXAAsiaIndividual individualCustomer = new EIPJson.EIP_IcAx_AXAAsiaIndividual();
                    individualCustomer.socialSecurityNO = params.get(EIPConstant.PARAM_MSG_CIF);
                    
                    if(!String.isEmpty(params.get(EIPConstant.PARAM_MSG_EMAIL))){
                        EIPJson.EIP_IcAx_AXAAsiaIndividualAddress addressCustomer = new EIPJson.EIP_IcAx_AXAAsiaIndividualAddress();
                        addressCustomer.emailAddress = params.get(EIPConstant.PARAM_MSG_EMAIL);
                        List<EIPJson.EIP_IcAx_AXAAsiaIndividualAddress> addressCustomers = new List<EIPJson.EIP_IcAx_AXAAsiaIndividualAddress>();
                        addressCustomers.add(addressCustomer);
                        individualCustomer.hasAddressesIn = addressCustomers;
                    }
                }else{
                    // construct policy number
                    EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
                    insurancePolicy.policyNO = policyNumber;
                    
                    // construct customer type
                    EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson= new EIPJson.EIP_IcAx_AXAAsiaCustomer();
                    customerTypeJson.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{insurancePolicy};
                        eipRequestBody.IcAx_AXAAsiaCustomer_Type = customerTypeJson;
                }
            }
            
            
            EIPJson requestCustomerInfo = new EIPJson();
            requestCustomerInfo.Body = eipRequestBody;
            setAuthHeaderCCC(requestCustomerInfo);
            
            String requestJsonEIP = System.JSON.serialize(requestCustomerInfo, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(policyNumber);
            paramsOfSignature.add(String.valueOf(isPagination));
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getCustomerInfo);
            
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            system.debug('getCUstomerInfo: no data exception: ' + e.getMessage());
            throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
        }catch(EIPConnector.EIPConnectorException e){
            system.debug('getCUstomerInfo: EIP Connector exception: ' + e.getMessage());
            throw new EIPConnectorException(ERROR_MESSAGE);
        }catch(Exception e){
            system.debug('getCUstomerInfo: exception: ' + e.getMessage());
            throw new EIPException(e.getMessage());
        }
        
        return eipResponse;
    }
    
    /*
*   construct for service getClaimDetails EIP without pagination
*/
    public static EIPJson getClaimDetails(String operation, String entity, String appId, String policyNumber){
        return getClaimDetails(operation, entity, appId, policyNumber, null, false);
    }
    
    public static EIPJson getClaimDetails(String operation, String entity, String appId, String policyNumber, String claimNumber){
        return getClaimDetails(operation, entity, appId, policyNumber, claimNumber, false);
    }
    
    /*
*   construct for service getClaimDetails EIP
	Modified by Dimas Support MII 26/05/2025, In Progress
*/
    
    public static EIPJson getClaimDetails(String operation, String entity, String appId, String policyNumber, String claimNumber, boolean isPagination){
        EIPJson eipResponse;
        
        try {
            String service = EIPConstant.SERVICE_GET_CLAIM_DETAIL;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // Basic body structure
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            
            // Setup Insurance Policy block
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            
            // Only set policy number if provided
            if (String.isNotBlank(policyNumber)) {
                insurancePolicy.policyNO = policyNumber;
            }
            
            // Only set claim number if provided
            if (String.isNotBlank(claimNumber)) {
                EIPJson.EIP_PnCClaim_CLAIM pncClaimIn = new EIPJson.EIP_PnCClaim_CLAIM();
                pncClaimIn.claimNumber = claimNumber;
                insurancePolicy.hasPnCClaimIn = new EIPJson.EIP_PnCClaim_CLAIM[] { pncClaimIn };
                    }
            
            // Optional safeguard: throw error if both inputs are blank
            if (String.isBlank(policyNumber) && String.isBlank(claimNumber)) {
                throw new CalloutException('Either policyNumber or claimNumber must be provided.');
            }
            
            // Wrap under Customer > hasPolicyAccount
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson = new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            customerTypeJson.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[] { insurancePolicy };
                eipRequestBody.Customer = customerTypeJson;
            
            // Wrap full request
            EIPJson requestClaimDetails = new EIPJson();
            requestClaimDetails.Body = eipRequestBody;
            setAuthHeaderCCC(requestClaimDetails);
            
            String requestJsonEIP = System.JSON.serialize(requestClaimDetails, true);
            
            // Signature parameters
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(policyNumber);
            paramsOfSignature.add(String.valueOf(isPagination));
            signature = generateSignature(paramsOfSignature);
            
            // Callout
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getClaimDetail);
            checkStatus(eipResponse.Body);
            
        } catch (EIPConnector.NoDataException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Backend sedang offline.'));
        } catch (EIPConnector.EIPConnectorException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ERROR_MESSAGE));
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ERROR_MESSAGE));
        }
        
        return eipResponse;
    }
      
    /*
*   construct for service getAgentInfo EIP without pagination
*/
    public static EIPJson getAgentInfo(String operation, String entity, String appId, String partyNumber, String factPeriod){
        return getAgentInfo(operation, entity, appId, partyNumber, factPeriod, false);
    }
    
    /*
*   construct for service getAgentInfo EIP
*/
    public static EIPJson getAgentInfo(String operation, String entity, String appId, String partyNumber, String factPeriod, boolean isPagination){
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_GET_AGENT_INFO;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            
            //construct name and value
            EIPJson.EIP_AgSa_NameValue nameValue = new EIPJson.EIP_AgSa_NameValue();
            if(factPeriod == null){
                DateTime currentDate = Date.Today() ;
                factPeriod = currentDate.format(DATE_FORMAT_YYYYMM);
            }
            nameValue.name = EIPConstant.FACT_PERIOD;
            nameValue.value = factPeriod;
            
            //construct party number and name-value object
            EIPJson.EIP_IcAx_AXAAsiaParty party = new EIPJson.EIP_IcAx_AXAAsiaParty();
            if(EIPConstant.APP_IDAS == appId){
                party.partyID = partyNumber;
            } else {
                party.partyNO = partyNumber; 
            }
            party.hasNameValue = new EIPJson.EIP_AgSa_NameValue[]{nameValue};
                
                //construct for insurance policy object
                EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.hasPartyDetailsIn = new EIPJson.EIP_IcAx_AXAAsiaParty[]{party};
                eipRequestBody.AgSa_InsurancePolicy_Type = insurancePolicy;
            
            EIPJson requestAgentInfo = new EIPJson();
            requestAgentInfo.Body = eipRequestBody;
            setAuthHeaderCCC(requestAgentInfo);
            
            String requestJsonEIP = System.JSON.serialize(requestAgentInfo, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(partyNumber);
            paramsOfSignature.add(factPeriod);
            paramsOfSignature.add(String.valueOf(isPagination));
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getAgentInfo);
            
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }
        return eipResponse;
    }
    
    /*
*   construct for service getFundHistory EIP
*   startDatetime (yyyy-MM-dd HH:mm:ss)
*   endDateTime (yyyy-MM-dd HH:mm:ss)
*/
    public static EIPJson getFundHistory(String operation, String entity, String appId, String policyNumber, String startDateTime, String endDateTime){
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_GET_FUND_HISTORY;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, true);
            
            // set startDatetime and endDatetime history request
            EIPJson.EIP_AXAAsiaPagination paging = eipRequestBody.AXAAsiaPagination_Type;
            paging.startDateTime = startDateTime;
            paging.endDateTime = endDateTime;
            eipRequestBody.AXAAsiaPagination_Type = paging;
            
            // construct policy number
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.policyNO = policyNumber;
            eipRequestBody.AgSa_InsurancePolicy_Type = insurancePolicy;
            
            EIPJson requestFundHistory = new EIPJson();
            requestFundHistory.Body = eipRequestBody;
            setAuthHeaderCCC(requestFundHistory);
            
            String requestJsonEIP = System.JSON.serialize(requestFundHistory, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(policyNumber);
            paramsOfSignature.add(startDateTime);
            paramsOfSignature.add(endDateTime);
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getFundHistory);
            
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }
        return eipResponse;
        
    }
    
    /*
*   construct for service getFundPriceHistory EIP without pagination
*   valuationDate (yyyyMMdd)
*/
    public static EIPJson getFundPriceHistory(String operation, String entity, String appId, String fundCode, String valuationDate){
        return getFundPriceHistory(operation, entity, appId, fundCode, valuationDate, false);
    }
    
    /*
*   construct for service getFundPriceHistory EIP
*   valuationDate (yyyyMMdd)
*/
    public static EIPJson getFundPriceHistory(String operation, String entity, String appId, String fundCode, String valuationDate, boolean isPagination){
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_GET_FUNDPRICE_HISTORY;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            
            //construct valuationDate
            EIPJson.EIP_AgSa_InvestmentFund investmentFund = new EIPJson.EIP_AgSa_InvestmentFund();
            investmentFund.investmentFundCd = fundCode;
            
            if((entity == EIPConstant.ENTITY_AMFS || entity == EIPConstant.ENTITY_AFI) && appID == EIPConstant.APP_RLS && valuationDate != null){
                valuationDate = valuationDate.replaceAll('^([0-9]{4})-([0-9]{2})-([0-9]{2}).*$','$1$2$3');
                investmentFund.valuationDt = valuationDate;
            }
            
            EIPJson.EIP_IcAx_AXAAsiaSubAccount subAccount = new EIPJson.EIP_IcAx_AXAAsiaSubAccount();
            subAccount.hasInvestmentFundDetailsIn = new EIPJson.EIP_AgSa_InvestmentFund[]{investmentFund};
                
                EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.hasAccountDetailsIn =  new EIPJson.EIP_IcAx_AXAAsiaSubAccount[]{subAccount};
                eipRequestBody.AgSa_InsurancePolicy_Type = insurancePolicy;
            
            EIPJson requestFundPriceHistory = new EIPJson();
            requestFundPriceHistory.Body = eipRequestBody;
            setAuthHeaderCCC(requestFundPriceHistory);
            
            String requestJsonEIP = System.JSON.serialize(requestFundPriceHistory, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(fundCode);
            paramsOfSignature.add(valuationDate);
            paramsOfSignature.add(String.valueOf(isPagination));
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getFundPriceHistory);
            
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }
        return eipResponse;
    }
    
    /*
*   construct for service getFundPriceHistory EIP with selection fund price and date range
*   valuationDate (yyyyMMdd)
*/
    public static EIPJson getFundPriceHistory(String operation, String entity, String appId, String fundCode, String valuationDate, String endDate){
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_GET_FUNDPRICE_HISTORY;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, true);
            
            // set startDatetime and endDatetime history request
            EIPJson.EIP_AXAAsiaPagination paging = eipRequestBody.AXAAsiaPagination_Type;
            Date startDate = CCCUtils.strToDate(valuationDate, 'yyyymmdd');
            paging.startDateTime =  String.valueOf(startDate.year()) + '-' +
                String.valueOf(startDate.month()).leftPad(2,'0') + '-' +
                String.valueOf(startDate.day()).leftPad(2,'0') + ' 00:00:00';
            paging.endDateTime = ' 23:59:59';
            paging.startOfRecords = '1';
            paging.pageNumber = '1';
            paging.rowPerPage = '1';
            paging.numberOfRecords = '64';
            eipRequestBody.AXAAsiaPagination_Type = paging;
            
            //construct valuationDate
            EIPJson.EIP_AgSa_InvestmentFund investmentFund = new EIPJson.EIP_AgSa_InvestmentFund();
            investmentFund.investmentFundCd = fundCode;
            
            if((entity == EIPConstant.ENTITY_AMFS || entity == EIPConstant.ENTITY_AFI) && appID == EIPConstant.APP_RLS && valuationDate != null){
                valuationDate = valuationDate.replaceAll('^([0-9]{4})-([0-9]{2})-([0-9]{2}).*$','$1$2$3');
                investmentFund.valuationDt = valuationDate;
            }
            investmentFund.saleExpirationDt = endDate;
            
            EIPJson.EIP_IcAx_AXAAsiaSubAccount subAccount = new EIPJson.EIP_IcAx_AXAAsiaSubAccount();
            subAccount.hasInvestmentFundDetailsIn = new EIPJson.EIP_AgSa_InvestmentFund[]{investmentFund};
                
                EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.hasAccountDetailsIn =  new EIPJson.EIP_IcAx_AXAAsiaSubAccount[]{subAccount};
                eipRequestBody.AgSa_InsurancePolicy_Type = insurancePolicy;
            
            EIPJson requestFundPriceHistory = new EIPJson();
            requestFundPriceHistory.Body = eipRequestBody;
            setAuthHeaderCCC(requestFundPriceHistory);
            
            String requestJsonEIP = System.JSON.serialize(requestFundPriceHistory, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(fundCode);
            paramsOfSignature.add(valuationDate);
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getFundPriceHistory);
            
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }
        return eipResponse;
    }
    
    
    /*
*   construct for service getAssNotes EIP without pagination
*   assessmentType (“CLM” | “POS” | “UW” | “OTH” | “PA”)
*   lastUpdateDateTime (yyyyMMddmmhhss) -- Optional
*/
    public static EIPJson getAssNotes(String operation, String entity, String appId, String policyNumber, String assessmentType, String assessmentRefNo, String lastUpdateDateTime){
        return getAssNotes(operation, entity, appId, policyNumber, assessmentType, assessmentRefNo, lastUpdateDateTime, false);
    }
    
    /*
*   construct for service getAssNotes EIP
*   assessmentType (“CLM” | “POS” | “UW” | “OTH” | “PA”)
*   lastUpdateDateTime (yyyyMMddmmhhss) -- Optional
*/
    public static EIPJson getAssNotes(String operation, String entity, String appId, String policyNumber, String assessmentType, String assessmentRefNo, String lastUpdateDateTime, boolean isPagination){
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_GET_ASS_NOTE;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            
            // construct assessmentType, assessmentRefNo and lastUpdateDateTime
            EIPJson.EIP_IcAx_AXAAsiaPolicyAssessment policyAssessment = new EIPJson.EIP_IcAx_AXAAsiaPolicyAssessment();
            policyAssessment.assessmentClassType = assessmentType;
            policyAssessment.assmtRefNo = assessmentRefNo;
            policyAssessment.lastUpdDTTM = lastUpdateDateTime;
            
            // construct policyNumber and policyAssessment
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.policyNO = policyNumber;
            if (operation == EIPConstant.OPERATION_NOTIF_REMARK && appId == EIPConstant.APP_RLS_WEB) {
                insurancePolicy.applicationRk = EIPConstant.DEFAULT_PAGE_START_NO;
                insurancePolicy.generalRk = EIPConstant.DEFAULT_HAMLET_NO;
                insurancePolicy.SARamt = EIPConstant.DEFAULT_HAMLET_NO;
            }
            insurancePolicy.hasPolicyAssessmentDetailsIn = new EIPJson.EIP_IcAx_AXAAsiaPolicyAssessment[]{policyAssessment};
                eipRequestBody.AgSa_InsurancePolicy_Type = insurancePolicy;
            
            EIPJson requestAssNotes = new EIPJson();
            requestAssNotes.Body = eipRequestBody;
            
            if (operation == EIPConstant.OPERATION_NOTIF_REMARK && appId == EIPConstant.APP_RLS_WEB) {
                setAuthHeaderCCCRLSWEB(requestAssNotes);
            } else {
            	setAuthHeaderCCC(requestAssNotes);
            }
            
            String requestJsonEIP = System.JSON.serialize(requestAssNotes, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(policyNumber);
            paramsOfSignature.add(assessmentType);
            paramsOfSignature.add(assessmentRefNo);
            paramsOfSignature.add(lastUpdateDateTime);
            paramsOfSignature.add(String.valueOf(isPagination));
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getAssNotes);
            
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            if(System.isFuture() || System.isQueueable()){ 
                throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
            }
            else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
            }
            
        }catch(EIPConnector.EIPConnectorException e){
             if(System.isFuture() || System.isQueueable()){ 
                throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
            }
            else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
            }
        }catch(Exception e){
             if(System.isFuture() || System.isQueueable()){ 
                throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
            }
            else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
            }
        }
        return eipResponse;
    }
    
    /*
*   construct for service getGIClaimDetail EIP without pagination, validFromDttm and validToDttm
*/
    public static EIPJson getGIClaimDetail(String operation, String entity, String appId, String policyNumber){
        return getGIClaimDetail(operation, entity, appId, policyNumber, null, false);
    }
    
    /*
*   construct for service getGIClaimDetail EIP without pagination only
*/
    public static EIPJson getGIClaimDetail(String operation, String entity, String appId, String policyNumber, Map<String, String> validDttm){
        return getGIClaimDetail(operation, entity, appId, policyNumber, validDttm, false);
    }
    
    /*
*   construct for service getGIClaimDetail EIP
*/
    public static EIPJson getGIClaimDetail(String operation, String entity, String appId, String policyNumber, Map<String, String> validDttm, boolean isPagination){
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_GET_GICLAIM_DETAIL;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            
            // construct policy number
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.policyNO = policyNumber;
            
            // validation validDttm not null
            if(validDttm != null && validDttm.size() > 0){
                insurancePolicy.validFromDttm = validDttm.get(EIPConstant.VALID_FROM_DTTM);
                insurancePolicy.validToDttm = validDttm.get(EIPConstant.VALID_TO_DTTM);
            }
            eipRequestBody.AgSa_InsurancePolicy_Type = insurancePolicy;
            
            EIPJson requestGIClaimDetail = new EIPJson();
            requestGIClaimDetail.Body = eipRequestBody;
            setAuthHeaderCCC(requestGIClaimDetail);
            
            String requestJsonEIP = System.JSON.serialize(requestGIClaimDetail, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(policyNumber);
            paramsOfSignature.add(String.valueOf(isPagination));
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getGIClaimDetail);
            
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }
        return eipResponse;
    }
    
    /*
*   construct for service getGIPolicyDetail EIP
*   certificateNumber -- Optional
*/
    public static EIPJson getGIPolicyDetail(String operation, String entity, String appId, String policyNumber, String certificateNumber){
        return getGIPolicyDetail(operation, entity, appId, policyNumber, certificateNumber, false);
    }
    
    /*
*   construct for service getGIPolicyDetail EIP
*   certificateNumber -- Optional
*/
    public static EIPJson getGIPolicyDetail(String operation, String entity, String appId, String policyNumber, String certificateNumber, boolean isPagination){
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_GET_GIPOLICY_DETAIL;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            
            // construct policy number and certificateNumber
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.policyNO = policyNumber;
            insurancePolicy.certificateNo = certificateNumber == null ? '' : certificateNumber;
            
            // construct customer type
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson= new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            customerTypeJson.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{insurancePolicy};
                eipRequestBody.IcAx_AXAAsiaCustomer_Type = customerTypeJson;
            
            EIPJson requestGIPolicyDetail = new EIPJson();
            requestGIPolicyDetail.Body = eipRequestBody;
            setAuthHeaderCCC(requestGIPolicyDetail);
            
            String requestJsonEIP = System.JSON.serialize(requestGIPolicyDetail, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(policyNumber);
            paramsOfSignature.add(certificateNumber);
            paramsOfSignature.add(String.valueOf(isPagination));
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getGIPolicyDetail);
            
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }
        return eipResponse;
    }
    
    /*
*   construct for service getToken EIP
*/
    public static EIPJson getToken(String operation, String entity, String appId, String grossAmount, String trxRefNo, Map<String, String> params){
        DateTime dtStart = DateTime.now();
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_GET_TOKEN;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            String enabledPayment;
            Map<String, String> additionalData1 = new Map<String, String>();
            Map<String, String> additionalData2 = new Map<String, String>();
            if(EIPConstant.OPERATION_VSNAP_TOKEN.equalsIgnoreCase(operation)){
                enabledPayment = EIPConstant.CREDIT_CARD;
                
                // set additionalData 1 in customer
                additionalData1.put(EIPConstant.CUSTOM_FIELD_1, params.get(EIPConstant.CUSTOM_FIELD_1));
                additionalData1.put(EIPConstant.CUSTOM_FIELD_2, params.get(EIPConstant.CUSTOM_FIELD_2));
                
                // set additionalData 2 in hasPolicyAccount
                additionalData2.put(EIPConstant.SAVE_CARD, params.get(EIPConstant.SAVE_CARD));
                additionalData2.put(EIPConstant.SECURE, 'true');
                additionalData2.put(EIPConstant.FINISH, params.get(EIPConstant.FINISH));
            }else if(EIPConstant.OPERATION_V_TOKEN.equalsIgnoreCase(operation)){
                // TODO
            }else if(EIPConstant.OPERATION_REGISTER.equalsIgnoreCase(operation)){
                // TODO
            }else if(EIPConstant.OPERATION_PGP_TOKEN.equalsIgnoreCase(operation)){
                // TODO
            }else if(EIPConstant.OPERATION_PGPDEBIT_TOKEN.equalsIgnoreCase(operation)){
                // TODO
            }
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, false);
            
            // construct grossAmount, trxRefNo,
            EIPJson.EIP_IcAx_AXAAsiaPayment hasBilling = new EIPJson.EIP_IcAx_AXAAsiaPayment();
            hasBilling.transactionReferenceNO = trxRefNo;
            hasBilling.grossAmount = grossAmount;    
            if(enabledPayment != null){
                hasBilling.enabled_payment = enabledPayment;
            }
                //construct hasPolicyAccount
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.hasBilling = hasBilling;
            
            // construct additionalData 2 in hasPolicyAccount
            if(additionalData2.size() > 0){
                EIPJson.EIP_AgSa_NameValue[] arrayNameValue = new EIPJson.EIP_AgSa_NameValue[additionalData2.size()];
                Integer i = 0;
                for (String key : additionalData2.keySet()) {
                    EIPJson.EIP_AgSa_NameValue nameValue = new EIPJson.EIP_AgSa_NameValue();
                    nameValue.name = key;
                    nameValue.value = additionalData2.get(key);
                    arrayNameValue[i] = nameValue;
                    i++;
                }
                insurancePolicy.hasNameValue = arrayNameValue; 
            }
            
            // construct customer type
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson= new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            customerTypeJson.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{insurancePolicy};
                
                // construct additionalData 1 in customer
                if(additionalData1.size() > 0){
                    EIPJson.EIP_AgSa_NameValue[] arrayNameValue = new EIPJson.EIP_AgSa_NameValue[additionalData1.size()];
                    Integer i = 0;
                    for (String key : additionalData1.keySet()) {
                        EIPJson.EIP_AgSa_NameValue nameValue = new EIPJson.EIP_AgSa_NameValue();
                        nameValue.name = key;
                        nameValue.value = additionalData1.get(key);
                        arrayNameValue[i] = nameValue;
                        i++;
                    }
                    customerTypeJson.hasNameValue = arrayNameValue; 
                }
            
            eipRequestBody.IcAx_AXAAsiaCustomer_Type = customerTypeJson;
            
            EIPJson requestToken = new EIPJson();
            requestToken.Body = eipRequestBody;
            setAuthHeaderCCC(requestToken);
            
            String requestJsonEIP = System.JSON.serialize(requestToken, true);
            
            eipResponse = sendRequest(requestJsonEIP, Label.Biz_getToken);
            DateTime dtEnd = DateTime.now();
            Map<String,DateTime> dateTimeMap = new Map<String,DateTime>();
            dateTimeMap.put(EIPConstant.MAP_REQUEST_TIME, dtStart);
            dateTimeMap.put(EIPConstant.MAP_RESPONSE_TIME, dtEnd);
            
            Map<String,EIPJson> eipJsonMap = new Map<String,EIPJson>();
            eipJsonMap.put(EIPConstant.MAP_EIP_JSON_REQUEST, requestToken);
            eipJsonMap.put(EIPConstant.MAP_EIP_JSON_RESPONSE, eipResponse);
            
            Map<String, String> propertiesMap = new Map<String,String>();
            propertiesMap.put(EIPConstant.MAP_SERVICE, service);
            propertiesMap.put(EIPConstant.MAP_OPERATION, operation);
            propertiesMap.put(EIPConstant.MAP_ENTITY, entity);
            propertiesMap.put(EIPConstant.MAP_POLICY_APP, appId);
            propertiesMap.put(EIPConstant.MAP_ORDER_ID, trxRefNo);
            
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }
        return eipResponse;
    }
    
    //Ichwan Sholihin, 9/6/2024: getRequest (POST) for request policy latest DMTM
    public static EIPJson getRequest(String operation, String entity, String appId, Map<String, String> properties) {
        return getRequest(operation, entity, appId, properties, false);
    }
    
    public static EIPJson getRequest(String operation, String entity, String appId, Map<String, String> properties, boolean isPagination){
        EIPJson eipResponse;
        try {
            String service = EIPConstant.SERVICE_GET_POLICY_DETAIL;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.applicationRK = properties.get(EIPConstant.PARAM_TYPE);
            insurancePolicy.policyNO = properties.get(EIPConstant.PARAM_MSG_POLICY);
            insurancePolicy.producerRK = properties.get(EIPConstant.PARAM_MSG_PRODUCER);
            
            // construct customer type
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson= new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            customerTypeJson.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{insurancePolicy};
                
                eipRequestBody.Customer = customerTypeJson;
                
            EIPJson requestPolicyDetail = new EIPJson();
            requestPolicyDetail.Body = eipRequestBody;
            setAuthHeaderCCC(requestPolicyDetail);
            
            String requestJsonEIP = System.JSON.serialize(requestPolicyDetail, true);
            eipResponse = sendRequest(requestJsonEIP, Label.Biz_getPolicyDetail);
            
        }catch(EIPConnector.NoDataException e){
            system.debug('getRequest: no data exception: ' + e.getMessage());
            throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
        }catch(EIPConnector.EIPConnectorException e){
            system.debug('getRequest: EIP Connector exception: ' + e.getMessage());
            throw new EIPConnectorException(ERROR_MESSAGE);
        }catch(Exception e){
            system.debug('getRequest: exception: ' + e.getMessage());
            throw new EIPException(e.getMessage());
        }
        return eipResponse;
    }
    
    //Ichwan Sholihin, 9/9/2024: addCustomer to table call note
    public static EIPJson addCustomerCallNote(String operation, String entity, String appId, Map<String, String> properties) {
        return addCustomerCallNote(operation, entity, appId, properties, false);
    }
    
    public static EIPJson addCustomerCallNote(String operation, String entity, String appId, Map<String, String> properties, boolean isPagination) {
        EIPJson eipResponse;
        try {
            
            String service = EIPConstant.SERVICE_ADD_CUSTOMER;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
			
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            
            // construct customer type
            EIPJson.EIP_AgSa_NameValue valueCwc = new EIPJson.EIP_AgSa_NameValue();
            valueCwc.value = properties.get(EIPConstant.PARAM_MSG_VALUE);
            
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.policyNO = properties.get(EIPConstant.PARAM_MSG_POLICY);
			insurancePolicy.policyRK = properties.get(EIPConstant.PARAM_MSG_POLICYRK);
            insurancePolicy.registeredBy = properties.get(EIPConstant.PARAM_MSG_REGISTERED);
            insurancePolicy.accountNo = properties.get(EIPConstant.PARAM_MSG_ACCOUNTNO);
            
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson= new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            customerTypeJson.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{insurancePolicy};
                
                eipRequestBody.Customer = customerTypeJson;
            
            EIPJson requestPolicyDetail = new EIPJson();
            requestPolicyDetail.Body = eipRequestBody;
            setAuthHeaderCCC(requestPolicyDetail);
            
            String requestJsonEIP = System.JSON.serialize(requestPolicyDetail, true);
            eipResponse = sendRequest(requestJsonEIP, Label.Biz_getCustomerInfo);
            
        }catch(EIPConnector.NoDataException e){
            system.debug('addCustomerCallNote: no data exception: ' + e.getMessage());
            throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
        }catch(EIPConnector.EIPConnectorException e){
            system.debug('addCustomerCallNote: EIP Connector exception: ' + e.getMessage());
            throw new EIPConnectorException(ERROR_MESSAGE);
        }catch(Exception e){
            system.debug('addCustomerCallNote: exception: ' + e.getMessage());
            throw new EIPException(e.getMessage());
        }
        
        return eipResponse;
    }

    //Ichwan Sholihin, 9/9/2024: addCustomer to table conservation
    public static EIPJson addCustomerConservation(String operation, String entity, String appId, Map<String, String> properties) {
        return addCustomerConservation(operation, entity, appId, properties, false);
    }    
    
    public static EIPJson addCustomerConservation(String operation, String entity, String appId, Map<String, String> properties, boolean isPagination){
        EIPJson eipResponse;
        try {
            String service = EIPConstant.SERVICE_ADD_CUSTOMER;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
			
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);

            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.policyRK = properties.get(EIPConstant.PARAM_MSG_POLICYRK);
            insurancePolicy.statusReasonCd = properties.get(EIPConstant.PARAM_STATUS_REASON);
            insurancePolicy.processedDttm = properties.get(EIPConstant.PARAM_MSG_DTTM);
            insurancePolicy.policyNO = properties.get(EIPConstant.PARAM_MSG_POLICY);
            insurancePolicy.uwTypeCd = properties.get(EIPConstant.PARAM_MSG_UWTYPE);
            insurancePolicy.otherInsuredInd = properties.get(EIPConstant.PARAM_MSG_OTHER_IND);
            insurancePolicy.registeredBy = properties.get(EIPConstant.PARAM_MSG_REGISTERED);
            
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson= new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            customerTypeJson.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{insurancePolicy};
                
                eipRequestBody.Customer = customerTypeJson;
            
            EIPJson requestPolicyDetail = new EIPJson();
            requestPolicyDetail.Body = eipRequestBody;
            setAuthHeaderCCC(requestPolicyDetail);
            
            String requestJsonEIP = System.JSON.serialize(requestPolicyDetail, true);
            eipResponse = sendRequest(requestJsonEIP, Label.Biz_getCustomerInfo);

        }catch(EIPConnector.NoDataException e){
            system.debug('addCustomerConversation: no data exception: ' + e.getMessage());
            throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
        }catch(EIPConnector.EIPConnectorException e){
            system.debug('addCustomerConversation: EIP Connector exception: ' + e.getMessage());
            throw new EIPConnectorException(ERROR_MESSAGE);
        }catch(Exception e){
            system.debug('addCustomerConversation: exception: ' + e.getMessage());
            throw new EIPException(e.getMessage());
        }
        
        return eipResponse;
    }
    
    //Ichwan Sholihin, 11/5/2025: Insert Assesment Maintenance
    public static EIPJson insertAssessmentMaintenance(String operation, String entity, String appId, Map<String, String> properties) {
        return insertAssessmentMaintenance(operation, entity, appId, properties, false);
    }
    
    public static EIPJson insertAssessmentMaintenance(String operation, String entity, String appId, Map<String, String> properties, boolean isPagination) {
        EIPJson eipResponse;
        	
        try {
            system.debug('EIPConnector insertAssessmentMaintenance');
            String service = EIPConstant.SERVICE_ADD_CUSTOMER;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            
            EIPJson.EIP_IcAx_AXAAsiaPolicyAssessment detailsIn = new EIPJson.EIP_IcAx_AXAAsiaPolicyAssessment();
            detailsIn.assmtSection = properties.get(EIPConstant.PARAM_ASSMT_SECTION);
            detailsIn.assessor = properties.get(EIPConstant.PARAM_ASSESSOR);
            detailsIn.assessorDTTM = properties.get(EIPConstant.PARAM_ASSESSOR_DTTM);
            detailsIn.assmtRemark = 'Confirm';
            detailsIn.lastUpdDTTM = properties.get(EIPConstant.PARAM_LAST_UPD_DTTM);
            detailsIn.assmtRefNo = '0000000';
            
            String description = properties.get(EIPConstant.PARAM_ASSMT_DESC);
            List<String> assmDesc = new List<String>();
            Integer counter = 1;
            Integer maxChunk = 75;
            List<EIPJson.EIP_IcAx_AXAAsiaPolicyAssessment> detailsInList = new List<EIPJson.EIP_IcAx_AXAAsiaPolicyAssessment>();
            String sep = '\u001F';
            if (!String.isBlank(properties.get(EIPConstant.PARAM_CASE_TYPE)) && description.contains(sep)) {
                
                system.debug('split desc');
                List<String> parts = description.split(sep);
                for (String part : parts) {
                    if (String.isBlank(part)) continue; 
                    Integer start = 0;
                    while (start < part.length()) {
                        Integer endIdx = Math.min(start + maxChunk, part.length());
                        assmDesc.add(part.substring(start, endIdx));
                        start = endIdx;
                    }
                }
            } else {
                system.debug('not split');
                Integer start = 0;
                while (start < description.length()) {
                    Integer ends = Math.min(start + maxChunk, description.length());
                    String chunk = description.substring(start, ends);
                    assmDesc.add(chunk);
                    start = ends;
                }
            }
            
            for (String des : assmDesc) {
                
                EIPJson.EIP_IcAx_AXAAsiaPolicyAssessment detailsInIndex = new EIPJson.EIP_IcAx_AXAAsiaPolicyAssessment();
                detailsInIndex.assessor = properties.get(EIPConstant.PARAM_MSG_POLICY);
                detailsInIndex.assmtSection = properties.get(EIPConstant.PARAM_ASSMT_SECTION);
                detailsInIndex.assessorDTTM = properties.get(EIPConstant.PARAM_ASSESSOR_DTTM);
                detailsInIndex.assmtNo = String.valueOf(counter);
                detailsInIndex.assmtDesc = des.trim();
                detailsInIndex.assmtRefNo = '0000000';
                detailsInIndex.assmtTypeCd = '      ';
                detailsInIndex.assessmentClassType = '';
                
                detailsInList.add(detailsInIndex);
                counter++;
            }
            
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.policyNo = properties.get(EIPConstant.PARAM_MSG_POLICY);
            
            insurancePolicy.hasPolicyAssessmentDetailsIn = new List<EIPJson.EIP_IcAx_AXAAsiaPolicyAssessment>{detailsIn};
             
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy2 = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy2.hasPolicyAssessmentDetailsIn = detailsInList;
            
            List<EIPJson.EIP_CustomerCommunication> messages = new List<EIPJson.EIP_CustomerCommunication>();
            
            EIPJson.EIP_CustomerCommunication msg1 = new EIPJson.EIP_CustomerCommunication();
            msg1.target = '00038173';
            msg1.sender = 'IBDIGIASS';
            msg1.deliveryStatusCD = '';
            msg1.messageType = '02545';
            msg1.deliveryStatusDesc = 'L';
            msg1.additionalRk = '';
            msg1.channelID = 'IB';
            msg1.bizDivision = 'PA2';
            msg1.messageID = 'LFPASST';
            msg1.chargeAmt = '00045';
            msg1.bizContext = '00001';
            msg1.message = '';
            messages.add(msg1);
            
            EIPJson.EIP_CustomerCommunication msg2 = new EIPJson.EIP_CustomerCommunication();
            msg2.messageID = 'LFPASSD';
            msg2.bizContext = String.valueOf(counter-1).leftPad(5, '0'); //based on assmtNo
            msg2.chargeAmt = '00126';
            msg2.message = '          ';
            messages.add(msg2);
            
            EIPJson.EIP_CustomerCommunication msg3 = new EIPJson.EIP_CustomerCommunication();
            msg3.messageID = 'LFPASSH';
            msg3.bizContext = '00001';
            msg3.chargeAmt = '00042';
            msg3.message = '          ';
            messages.add(msg3);
            system.debug('messages: '+messages);
            
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerAssmt = new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            customerAssmt.customerRK = '';
            customerAssmt.dependentNO = 'ASSD';
            customerAssmt.staffStatusCD = '';
            customerAssmt.sourceCInd = '';
            customerAssmt.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{insurancePolicy, insurancePolicy2};
            customerAssmt.haveCommunicatedMessage = messages;
            system.debug('customerAssmt: '+customerAssmt);
            eipRequestBody.Customer = customerAssmt;
            
            EIPJson requestPolicyDetail = new EIPJson();
            requestPolicyDetail.Body = eipRequestBody;
            setAuthHeaderCCC(requestPolicyDetail);

			system.debug('requestPolicyDetail: '+requestPolicyDetail);            
            String requestJsonEIP = System.JSON.serialize(requestPolicyDetail, true);
            eipResponse = sendRequest(requestJsonEIP, Label.Biz_getCustomerInfo);
            
        } catch(EIPConnector.NoDataException e){
            system.debug('insertAssessmentMaintenance: no data exception: ' + e.getMessage());
            throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
        }catch(EIPConnector.EIPConnectorException e){
            system.debug('insertAssessmentMaintenance: EIP Connector exception: ' + e.getMessage());
            throw new EIPConnectorException(ERROR_MESSAGE);
        }catch(Exception e){
            system.debug('insertAssessmentMaintenance: exception: ' + e.getMessage());
            throw new EIPException(e.getMessage());
        }
        
        return eipResponse;
    }
    
    //Ichwan Sholihin, 11/14/2025: CR Register Maintenance
    public static EIPJson insertRegisterMaintenance(String operation, String entity, String appId, Map<String, String> properties) {
        return insertRegisterMaintenance(operation, entity, appId, properties, false);
    }
    
    public static EIPJson insertRegisterMaintenance(String operation, String entity, String appId, Map<String, String> properties, boolean isPagination) {
        EIPJson eipResponse;
        
        try {
            system.debug('EIPConnector insertAssessmentMaintenance');
            String service = EIPConstant.SERVICE_ADD_CUSTOMER;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            
            EIPJson.EIP_IcAx_AXAAsiaPaymentHistory historyDetails = new EIPJson.EIP_IcAx_AXAAsiaPaymentHistory();
            historyDetails.paymentRefID = '002134870';
            
            EIPJson.EIP_IcAx_AXAAsiaPayment hasBilling = new EIPJson.EIP_IcAx_AXAAsiaPayment();
            hasBilling.hasPaymentHistoryDetails = new EIPJson.EIP_IcAx_AXAAsiaPaymentHistory[]{historyDetails};
            
            EIPJson.EIP_IcAx_AXAAsiaClaimDetails hasClaimDetails = new EIPJson.EIP_IcAx_AXAAsiaClaimDetails();
            hasClaimDetails.reason1 = properties.get(EIPConstant.PARAM_REASON1);
            hasClaimDetails.reason2 = properties.get(EIPConstant.PARAM_REASON2);
            hasClaimDetails.remarks = properties.get(EIPConstant.PARAM_MSG_REMARKS);
            
            EIPJson.EIP_IcAx_AXAAsiaLifeInsuranceClaim hasDetailsOfClaimIn = new EIPJson.EIP_IcAx_AXAAsiaLifeInsuranceClaim();
            hasDetailsOfClaimIn.claimStatusCD = properties.get(EIPConstant.PARAM_CLAIM_STATUSCD);
            hasDetailsOfClaimIn.claimTypeCd = properties.get(EIPConstant.PARAM_CLAIM_TYPECD);
            hasDetailsOfClaimIn.remarks = properties.get(EIPConstant.PARAM_CLAIM_REMARKS);
            hasDetailsOfClaimIn.letterCD = 'P';
            hasDetailsOfClaimIn.hasClaimDetails = new EIPJson.EIP_IcAx_AXAAsiaClaimDetails[]{hasClaimDetails};
                
           	EIPJson.EIP_IcAx_AXAAsiaLifePolicyDetails hasDetailsPolicyIn = new EIPJson.EIP_IcAx_AXAAsiaLifePolicyDetails();
            Integer maxLength1 = properties.get(EIPConstant.PARAM_UWREMARK1).length() > 140 ? 140 : properties.get(EIPConstant.PARAM_UWREMARK1).length();  
            hasDetailsPolicyIn.uwRemark1 = properties.get(EIPConstant.PARAM_UWREMARK1).subString(0,maxLength1);
            Integer maxLength2 = properties.get(EIPConstant.PARAM_UWREMARK2).length() > 140 ? 140 : properties.get(EIPConstant.PARAM_UWREMARK2).length();
            hasDetailsPolicyIn.uwRemark2 = properties.get(EIPConstant.PARAM_UWREMARK2).subString(0,maxLength2);
            Integer maxLength3 = properties.get(EIPConstant.PARAM_UWREMARK3).length() > 140 ? 140 : properties.get(EIPConstant.PARAM_UWREMARK3).length();
            hasDetailsPolicyIn.uwRemark3 = properties.get(EIPConstant.PARAM_UWREMARK3).subString(0,maxLength3);
            
            EIPJson.EIP_IcAx_AXAAsiaRemarkDetailsIn hasRemarkDetailsIn = new EIPJson.EIP_IcAx_AXAAsiaRemarkDetailsIn();
            hasRemarkDetailsIn.creationDT = properties.get(EIPConstant.PARAM_ASSESSOR_DTTM);
            hasRemarkDetailsIn.lastUpdatedBy = properties.get(EIPConstant.PARAM_ASSESSOR);
            hasRemarkDetailsIn.lastUpdatedDT = properties.get(EIPConstant.PARAM_LAST_UPD_DTTM);
            hasRemarkDetailsIn.remarks = '';
            
            EIPJson.EIP_AgSa_InsurancePolicy hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy();
            hasPolicyAccount.policyNO = properties.get(EIPConstant.PARAM_MSG_POLICY);
            hasPolicyAccount.originalPolicyNo = properties.get(EIPConstant.PARAM_MSG_POLICY);
            hasPolicyAccount.convertToPrivateInd = 'S';
            hasPolicyAccount.sourceChannelCD = 'CO';
            hasPolicyAccount.uwTypeCd = properties.get(EIPConstant.PARAM_MSG_UWTYPE);
            hasPolicyAccount.statusReasonCd = properties.get(EIPConstant.PARAM_STATUS_REASON);
            hasPolicyAccount.statusChangeDT = '000';
            hasPolicyAccount.premiumAMT = '123456789123.56';
            hasPolicyAccount.policyValue = '123456789123.56';
            hasPolicyAccount.policyTypeCd = 'O';
            hasPolicyAccount.agencyBinderNo = '000000';
            hasPolicyAccount.issueBranchCD = '000000';
            hasPolicyAccount.collectedByAgentAmt = '742266';
            hasPolicyAccount.binderPurposeCd = '03';
            hasPolicyAccount.assignmentFlg = '123456';
            hasPolicyAccount.applicationRk = properties.get(EIPConstant.PARAM_ASSESSOR);
            hasPolicyAccount.validFromDttm = properties.get(EIPConstant.PARAM_ASSESSOR_DTTM);
            hasPolicyAccount.registeredBy = properties.get(EIPConstant.PARAM_ASSESSOR);
            hasPolicyAccount.groupNm = '';
            hasPolicyAccount.hasBilling = hasBilling;
            hasPolicyAccount.hasDetailsOfClaimIn = new EIPJson.EIP_IcAx_AXAAsiaLifeInsuranceClaim[]{hasDetailsOfClaimIn};
            hasPolicyAccount.hasDetailsOfPolicyIn = new EIPJson.EIP_IcAx_AXAAsiaLifePolicyDetails[]{hasDetailsPolicyIn};
            hasPolicyAccount.hasPolicyRemarkDetailsIn = new EIPJson.EIP_IcAx_AXAAsiaRemarkDetailsIn[]{hasRemarkDetailsIn};
                
            EIPJson.EIP_CustomerCommunication msg1 = new EIPJson.EIP_CustomerCommunication();
            msg1.target = '00038173';
            msg1.sender = 'IBDIGICRRM';
            msg1.deliveryStatusCD = '';
            msg1.messageType = '00953';
            msg1.deliveryStatusDesc = 'L';
            msg1.additionalRk = '';
            msg1.channelID = 'IB';
            msg1.bizDivision = 'PA2';
            msg1.messageID = 'LFPCRREG';
            msg1.chargeAmt = '000820';
            msg1.bizContext = '00001';
            msg1.message = '';
            
            EIPJson.EIP_canBeExternalOrg canBeExternalOrg = new EIPJson.EIP_canBeExternalOrg();
            canBeExternalOrg.natureOfBusinessCd = '';
            
            EIPJson.EIP_IcAx_AXAAsiaIndividual canBeIndividual = new EIPJson.EIP_IcAx_AXAAsiaIndividual();
            canBeIndividual.masterIndividualId = 'N';
            
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerAssmt = new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            customerAssmt.customerRK = '';
            customerAssmt.dependentNO = 'CRRM';
            customerAssmt.staffStatusCD = '';
            customerAssmt.sourceCInd = '';
            customerAssmt.canBeExternalOrg = canBeExternalOrg;
            customerAssmt.crossSellableFlg = '';
            customerAssmt.customerClassCD = '0';
            customerAssmt.telephonableFlg = 'Y';
            customerAssmt.canBeIndividual = canBeIndividual;
            customerAssmt.customerTypeCD = 'SCR';
            customerAssmt.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{hasPolicyAccount};
            customerAssmt.haveCommunicatedMessage = new EIPJson.EIP_CustomerCommunication[]{msg1};
            
            eipRequestBody.Customer = customerAssmt;
            EIPJson requestPolicyDetail = new EIPJson();
            requestPolicyDetail.Body = eipRequestBody;
            setAuthHeaderCCC(requestPolicyDetail);

			system.debug('requestPolicyDetail: '+requestPolicyDetail);            
            String requestJsonEIP = System.JSON.serialize(requestPolicyDetail, true);
            eipResponse = sendRequest(requestJsonEIP, Label.Biz_getCustomerInfo);
            
        } catch(EIPConnector.NoDataException e){
            system.debug('insertRegisterMaintenance: no data exception: ' + e.getMessage());
            throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
        }catch(EIPConnector.EIPConnectorException e){
            system.debug('insertRegisterMaintenance: EIP Connector exception: ' + e.getMessage());
            throw new EIPConnectorException(ERROR_MESSAGE);
        }catch(Exception e){
            system.debug('insertRegisterMaintenance: exception: ' + e.getMessage());
            throw new EIPException(e.getMessage());
        }
        
        return eipResponse;
    }
    
    /*
*   construct for service doOrder EIP without pagination
*/
    public static EIPJson doOrder(String operation, String entity, String appId, String trxRefNo){
        return doOrder(operation, entity, appId, trxRefNo, null, null, null, false);
    }
    
    /*
*   construct for service doOrder EIP without pagination
*/
    public static EIPJson doOrder(String operation, String entity, String appId, String trxRefNo, String method, String status, Map<String, String> params){
        return doOrder(operation, entity, appId, trxRefNo, method, status, params, false);
    }
    
    /*
*   construct for service doOrder EIP
*/
    public static EIPJson doOrder(String operation, String entity, String appId, String trxRefNo, String method, String status, Map<String, String> params, boolean isPagination){
        DateTime dtStart = DateTime.now();
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_DO_ORDER;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            
            // construct payment
            EIPJson.EIP_IcAx_AXAAsiaPayment hasBilling = new EIPJson.EIP_IcAx_AXAAsiaPayment();
            hasBilling.transactionReferenceNO = trxRefNo;
            
            if(operation == EIPConstant.OPERATION_SUBMIT_DATA){
                EIPJson.EIP_IcAx_AXAAsiaPolicyPaymentAccount transferAccountDetails = new EIPJson.EIP_IcAx_AXAAsiaPolicyPaymentAccount();
                transferAccountDetails.statusCD = status;
                
                hasBilling.method = method;
                hasBilling.transferAccountDetails = transferAccountDetails;
            }
            
            //construct hasPolicyAccount
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            if(operation == EIPConstant.OPERATION_SUBMIT_DATA){
                insurancePolicy.sourceChannelCD = EIPConstant.CHANNEL_SALESFORCE;
                insurancePolicy.remark1 = EIPConstant.MSG_UPDATE_DATA_FROM_SALESFORCE;
            }
            insurancePolicy.hasBilling = hasBilling;
            
            // construct hasNameValue in insurancePolicy
            if(params != null && params.size() > 0){
                EIPJson.EIP_AgSa_NameValue[] arrayNameValue = new EIPJson.EIP_AgSa_NameValue[params.size()];
                Integer i = 0;
                for (String key : params.keySet()) {
                    EIPJson.EIP_AgSa_NameValue nameValue = new EIPJson.EIP_AgSa_NameValue();
                    nameValue.name = key;
                    nameValue.value = params.get(key);
                    arrayNameValue[i] = nameValue;
                    i++;
                }
                insurancePolicy.hasNameValue = arrayNameValue; 
            }
            
            // construct customer type
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson= new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            customerTypeJson.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{insurancePolicy};
                
                eipRequestBody.IcAx_AXAAsiaCustomer_Type = customerTypeJson;
            
            EIPJson requestDoOrder = new EIPJson();
            requestDoOrder.Body = eipRequestBody;
            setAuthHeaderCCC(requestDoOrder);
            
            String requestJsonEIP = System.JSON.serialize(requestDoOrder, true);
            eipResponse = sendRequest(requestJsonEIP, Label.Biz_doOrder);
            
            // start logging
            DateTime dtEnd = DateTime.now();
            Map<String,DateTime> dateTimeMap = new Map<String,DateTime>();
            dateTimeMap.put(EIPConstant.MAP_REQUEST_TIME, dtStart);
            dateTimeMap.put(EIPConstant.MAP_RESPONSE_TIME, dtEnd);
            
            Map<String,EIPJson> eipJsonMap = new Map<String,EIPJson>();
            eipJsonMap.put(EIPConstant.MAP_EIP_JSON_REQUEST, requestDoOrder);
            eipJsonMap.put(EIPConstant.MAP_EIP_JSON_RESPONSE, eipResponse);
            
            Map<String, String> propertiesMap = new Map<String,String>();
            propertiesMap.put(EIPConstant.MAP_SERVICE, service);
            propertiesMap.put(EIPConstant.MAP_OPERATION, operation);
            propertiesMap.put(EIPConstant.MAP_ENTITY, entity);
            propertiesMap.put(EIPConstant.MAP_POLICY_APP, appId);
            propertiesMap.put(EIPConstant.MAP_ORDER_ID, trxRefNo);
            
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }catch(Exception e){
            //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }
        return eipResponse;
    }
    
    // Catur Purbo 20200803, getPolicyDetails with start end date
    public static EIPJson getPolicyDetails(String operation, String entity, String appId, String policyNumber, String startDateTime, String endDateTime){
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_GET_POLICY_DETAIL;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, true);
            
            // set startDatetime and endDatetime history request
            EIPJson.EIP_AXAAsiaPagination paging = eipRequestBody.AXAAsiaPagination_Type;
            paging.startDateTime = startDateTime;
            paging.endDateTime = endDateTime;
            eipRequestBody.AXAAsiaPagination_Type = paging;
            
            // construct policy number
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.policyNO = policyNumber;
            
            // construct customer type
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson= new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            customerTypeJson.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{insurancePolicy};
                eipRequestBody.IcAx_AXAAsiaCustomer_Type = customerTypeJson;
            
            EIPJson requestPolicyDetail = new EIPJson();
            requestPolicyDetail.Body = eipRequestBody;
            setAuthHeaderCCC(requestPolicyDetail);
            
            String requestJsonEIP = System.JSON.serialize(requestPolicyDetail, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(policyNumber);
            paramsOfSignature.add(startDateTime);
            paramsOfSignature.add(endDateTime);
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getPolicyDetail);
            
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }catch(Exception e){
            System.debug(e.getStackTraceString());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }
        
        return eipResponse;
    }
    
    // Catur Purbo 20200803, getPaymentHistory with start end date
    public static EIPJson getPaymentHistory(String operation, String entity, String appId, String policyNumber, String startDateTime, String endDateTime){
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_GET_PAYMENT_HISTORY;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, true);
            
            // set startDatetime and endDatetime history request
            EIPJson.EIP_AXAAsiaPagination paging = eipRequestBody.AXAAsiaPagination_Type;
            paging.startDateTime = startDateTime;
            paging.endDateTime = endDateTime;
            eipRequestBody.AXAAsiaPagination_Type = paging;
            
            // construct policy number
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.policyNO = policyNumber;
            eipRequestBody.AgSa_InsurancePolicy_Type = insurancePolicy;
            
            EIPJson requestPaymentHistory = new EIPJson();
            requestPaymentHistory.Body = eipRequestBody;
            setAuthHeaderCCC(requestPaymentHistory);
            
            String requestJsonEIP = System.JSON.serialize(requestPaymentHistory, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(policyNumber);
            paramsOfSignature.add(startDateTime);
            paramsOfSignature.add(endDateTime);
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getPaymentHistory);
            
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }
        
        return eipResponse;
        
    }
    
    //Added by Dimas Support MII 07/02/2025
    public static EIPJson getPOSTransaction(String operation, String entity, String appId, String policyNumber, String startDateTime, String endDateTime){
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_GET_POLICY_DETAIL;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, true);
            
            // set startDatetime and endDatetime history request
            EIPJson.EIP_AXAAsiaPagination paging = eipRequestBody.AXAAsiaPagination_Type;
            paging.startDateTime = startDateTime;
            paging.endDateTime = endDateTime;
            eipRequestBody.AXAAsiaPagination_Type = paging;
            
            // construct policy number
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.policyNO = policyNumber;
            
            // construct customer type
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson= new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            customerTypeJson.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{insurancePolicy};
            eipRequestBody.Customer = customerTypeJson;
            
            EIPJson requestPolicyDetail = new EIPJson();
            requestPolicyDetail.Body = eipRequestBody;
            setAuthHeaderCCC(requestPolicyDetail);
            
            String requestJsonEIP = System.JSON.serialize(requestPolicyDetail, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(policyNumber);
            paramsOfSignature.add(startDateTime);
            paramsOfSignature.add(endDateTime);
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getPolicyDetail);
            
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }catch(Exception e){
            System.debug(e.getStackTraceString());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }
        
        return eipResponse;
    }
    
    public static EIPJson queueRelease(String operation, String entity, String appId){
        EIPJson eipResponse;
        try{
            
            String service = EIPConstant.SERVICE_SEND_COMMUNCATION_MESSAGE;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, false);
            
            // construct customer type
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson= new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            customerTypeJson.customerID = Label.Chatbot_Username;
            customerTypeJson.customerRK = Label.Chatbot_Password;
            
            eipRequestBody.IcAx_AXAAsiaCustomer_Type = customerTypeJson;
            
            EIPJson requestQueueRelease = new EIPJson();
            requestQueueRelease.Body = eipRequestBody;
            setAuthHeaderCCC(requestQueueRelease);
            
            String requestJsonEIP = System.JSON.serialize(requestQueueRelease, true);
            eipResponse = sendRequest(requestJsonEIP, Label.Biz_queueRelease);
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }
        return eipResponse;
    }
    // add by Catur
    // edited by Fajar
    public static EIPJson sendCommunicationMessageT2M(String operation, String entity, String appId, Map<String, String> properties){
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_SEND_COMMUNCATION_MESSAGE;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, false);            
            
            System.debug('properties == '+properties);
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson = new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            List<EIPJson.EIP_CustomerCommunication> haveCommunicatedMessage = new list<EIPJson.EIP_CustomerCommunication>();
            
            EIPJson.EIP_CustomerCommunication communicated = new EIPJson.EIP_CustomerCommunication();
            System.debug('[?] [Survey URL -  EIP Connector]' + properties.get(EIPConstant.CS_COM_TARGET));
            communicated.target = properties.get(EIPConstant.CS_COM_TARGET);
            communicated.messageID = properties.get(EIPConstant.CS_COM_MESSAGE_ID);
            communicated.deliveryStatusCD = properties.get(EIPConstant.CS_COM_DELIVER_STATUS);
            
            haveCommunicatedMessage.add(communicated);
            customerTypeJson.haveCommunicatedMessage = haveCommunicatedMessage;
            
            eipRequestBody.Customer = customerTypeJson;
            
            EIPJson sendT2M = new EIPJson();
            sendT2M.Body = eipRequestBody;
            setAuthHeaderCCC(sendT2M);
            
            String requestJsonEIP = System.JSON.serialize(sendT2M, true);
            System.debug('requestJsonEIP : '+requestJsonEIP);
            
            eipResponse = sendRequest(requestJsonEIP, Label.Biz_queueRelease);
            System.debug('ResponseJsonEIP : '+ eipResponse);
            checkStatus(eipResponse.Body);
 
            
        }catch(EIPConnector.NoDataException e){
            System.debug('[#] [ No Data  T2M] '+ e);
            throw new EIPConnector.NoDataException(e.getMessage());
        }catch(EIPConnector.EIPConnectorException e){
            System.debug('[#] [ EIP Connector T2M] '+ e);
            throw new EIPConnector.EIPConnectorException(e.getMessage());
        }catch(Exception e){
            System.debug('[#] [ Exception T22M] '+ e);
            throw new EIPConnector.EIPException(e.getMessage());
        }
        
        return eipResponse;
    }
    
    // add by Catur
    public static EIPJson sendCommunicationMessageTADA(String operation, String entity, String appId, Map<String, String> properties){
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_SEND_COMMUNCATION_MESSAGE;
            if(operation == EIPConstant.SERVICE_GET_HISTORY_REGISTER || operation == 'claim'){
                service = EIPConstant.SERVICE_GET_UW_DATA;
            } 
            
            /*else if(operation == EIPConstant.SERVICE_CUSTOMER_PROFILE){
                service = EIPConstant.SERVICE_GET_CUST_INFO;
            }*/
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, false);
            
            System.debug('properties == '+properties);
            
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson = new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            EIPJson.EIP_IcAx_AXAAsiaIndividual canBeIndividual = new EIPJson.EIP_IcAx_AXAAsiaIndividual();
            
            canBeIndividual.individualUniqueID = properties.get(EIPConstant.PARAM_MSG_LOGIN_ID);
            canBeIndividual.socialSecurityNO = properties.get(EIPConstant.PARAM_MSG_CIF);
            canBeIndividual.primaryLanguageCd = properties.get(EIPConstant.PARAM_MSG_LANGUAGE);
            canBeIndividual.individualRK = properties.get(EIPConstant.PARAM_MSG_PASSWORD);
            canBeIndividual.birthDT = properties.get(EIPConstant.PARAM_MSG_DOB);
            System.debug('tanggal atas == '+canBeIndividual.birthDT);
            canBeIndividual.documentID = properties.get(EIPConstant.PARAM_MSG_SESSION_ID);
            
            if((!String.isEmpty(properties.get(EIPConstant.PARAM_MSG_EMAIL)) || 
                (!String.isEmpty(properties.get(EIPConstant.PARAM_MSG_PHONE))) || 
                (!String.isEmpty(properties.get(EIPConstant.PARAM_MSG_CORESPONDENCE))) ||
                (!String.isEmpty(properties.get(EIPConstant.PARAM_MSG_PHONE2)))
               ) && operation != EIPConstant.OPERATION_REACTIVATION){
                   EIPJson.EIP_IcAx_AXAAsiaIndividualAddress individualAddress = new EIPJson.EIP_IcAx_AXAAsiaIndividualAddress();
                   individualAddress.individualAddressRk = properties.get(EIPConstant.PARAM_MSG_CORESPONDENCE);
                   individualAddress.emailAddress = properties.get(EIPConstant.PARAM_MSG_EMAIL);
                   individualAddress.mobilePhoneNO = properties.get(EIPConstant.PARAM_MSG_PHONE);
                   individualAddress.subdistrictNm = properties.get(EIPConstant.PARAM_SUBDISTRICT);
                   individualAddress.stateRegionCd = properties.get(EIPConstant.PARAM_STATE_REGION);
                   individualAddress.cityNM = properties.get(EIPConstant.PARAM_CITY_NM);
                   individualAddress.provinceNm = properties.get(EIPConstant.PARAM_PROVINCE_NM);
                   individualAddress.postalCD = properties.get(EIPConstant.PARAM_POSTAL_CD);
                   individualAddress.mobilePhoneNO2 = properties.get(EIPConstant.PARAM_MSG_PHONE2);
                   
                       
                   canBeIndividual.hasAddressesIn = new List<EIPJson.EIP_IcAx_AXAAsiaIndividualAddress>();
                   canBeIndividual.hasAddressesIn.add(individualAddress);
               }
            
            if(!String.isEmpty(properties.get(EIPConstant.PARAM_MSG_CHANNEL)) && operation != EIPConstant.OPERATION_REACTIVATION){
                EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
                insurancePolicy.preferredChannelCd = properties.get(EIPConstant.PARAM_MSG_CHANNEL);
                customerTypeJson.hasPolicyAccount = new List<EIPJson.EIP_AgSa_InsurancePolicy>();
                customerTypeJson.hasPolicyAccount.add(insurancePolicy);
            }
            
            if(operation == EIPConstant.OPERATION_REACTIVATION){
                EIPJson.EIP_AgSa_InsurancePolicy policyDetail = new EIPJson.EIP_AgSa_InsurancePolicy();
                policyDetail.policyNO = properties.get(EIPConstant.PARAM_MSG_POLICY);
                policyDetail.preferredChannelCd = properties.get(EIPConstant.PARAM_MSG_CHANNEL);
                
                EIPJson.EIP_IcAx_AXAAsiaInsuredPersonDetails personDetailRisk = new EIPJson.EIP_IcAx_AXAAsiaInsuredPersonDetails();
                EIPJson.EIP_IcAx_AXAAsiaIndividual personDetailIndividual = new EIPJson.EIP_IcAx_AXAAsiaIndividual();
                personDetailIndividual.birthDT = properties.get(EIPConstant.PARAM_MSG_DOB);
                
                EIPJson.EIP_IcAx_AXAAsiaIndividualAddress addressPersonDetail = new EIPJson.EIP_IcAx_AXAAsiaIndividualAddress();
                addressPersonDetail.emailAddress = properties.get(EIPConstant.PARAM_MSG_EMAIL);
                personDetailIndividual.hasAddressesIn = new List<EIPJson.EIP_IcAx_AXAAsiaIndividualAddress>();
                personDetailIndividual.hasAddressesIn.add(addressPersonDetail);
                
                personDetailRisk.hasPersonalDetailsIn = new List<EIPJson.EIP_IcAx_AXAAsiaIndividual>();
                personDetailRisk.hasPersonalDetailsIn.add(personDetailIndividual);
                
                policyDetail.hasDetailsOfRisksIn = new List<EIPJson.EIP_IcAx_AXAAsiaInsuredPersonDetails>();
                policyDetail.hasDetailsOfRisksIn.add(personDetailRisk);
                
                customerTypeJson.hasPolicyAccount = new List<EIPJson.EIP_AgSa_InsurancePolicy>();
                customerTypeJson.hasPolicyAccount.add(policyDetail);
            }
            
            if(operation == EIPConstant.SERVICE_CUSTOMER_PROFILE){
                
                System.debug('TEST 1');
                EIPJson.EIP_AgSa_InsurancePolicy insurance = new EIPJson.EIP_AgSa_InsurancePolicy();
                insurance.policyNO = properties.get(EIPConstant.PARAM_MSG_POLICY);
                
                    List<EIPJson.EIP_AgSa_InsurancePolicy> insuranceList = new List<EIPJson.EIP_AgSa_InsurancePolicy>();
                    insuranceList.add(insurance);
                    customerTypeJson.hasPolicyAccount = insuranceList;
                
                
                canBeIndividual.socialSecurityNO = properties.get(EIPConstant.PARAM_MSG_CIF);
                
                 EIPJson.EIP_IcAx_AXAAsiaIndividualAddress individualAddress = new EIPJson.EIP_IcAx_AXAAsiaIndividualAddress();
                   individualAddress.individualAddressRk = properties.get(EIPConstant.PARAM_MSG_CORESPONDENCE);
                   individualAddress.mobilePhoneNO = properties.get(EIPConstant.PARAM_MSG_PHONE);
                   
                       
                   canBeIndividual.hasAddressesIn = new List<EIPJson.EIP_IcAx_AXAAsiaIndividualAddress>();
                   canBeIndividual.hasAddressesIn.add(individualAddress);
			
			String requestJsonEIP = System.JSON.serialize(customerTypeJson.hasPolicyAccount, true);
            System.debug('requestJsonEIP : '+requestJsonEIP);
            }
            
            if(operation == EIPConstant.SERVICE_GET_HISTORY_REGISTER){
                System.debug('TEST 2');
                EIPJson.EIP_AgSa_InsurancePolicy insurance = new EIPJson.EIP_AgSa_InsurancePolicy();
                insurance.policyNO = properties.get(EIPConstant.PARAM_MSG_POLICY);
                insurance.generalRk = properties.get(EIPConstant.PARAM_PAGE_NUMBER);
                insurance.lobRk = properties.get(EIPConstant.PARAM_ROW_PER_PAGE);
                
                List<EIPJson.EIP_AgSa_InsurancePolicy> insuranceList = new List<EIPJson.EIP_AgSa_InsurancePolicy>();
                insuranceList.add(insurance);
                customerTypeJson.hasPolicyAccount = insuranceList;
                
                canBeIndividual.socialSecurityNO = properties.get(EIPConstant.PARAM_MSG_CIF);
                
                String requestJsonEIP = System.JSON.serialize(customerTypeJson.hasPolicyAccount, true);
                System.debug('requestJsonEIP : '+requestJsonEIP);
                
                
            }
            
            if(operation == 'claim'){
                EIPJson.EIP_AgSa_InsurancePolicy insurance = new EIPJson.EIP_AgSa_InsurancePolicy();
                
                EIPJson.EIP_PnCClaim_CLAIM pncClaimIn = new EIPJson.EIP_PnCClaim_CLAIM();
                pncClaimIn.claimNumber = properties.get('claimNumber');
                pncClaimIn.policyType = properties.get('policyType');
                pncClaimIn.policyNumber = properties.get('PARAM_MSG_POLICY');
                pncClaimIn.claimTypeCode = properties.get('claimTypeCode');
                pncClaimIn.claimStatusCode = properties.get('claimStatusCode');
                pncClaimIn.totalClaimAmount = properties.get('totalClaimAmount');
                pncClaimIn.totalApprovedAmount = properties.get('totalApprovedAmount');
                
                pncClaimIn.firstApprovalDate = properties.get('firstApprovalDate');
                pncClaimIn.lastApprovalDate = properties.get('lastApprovalDate');
                
                
                pncClaimIn.preAuthorizationNumber = 'false';
                
                insurance.hasPnCClaimIn = new EIPJson.EIP_PnCClaim_CLAIM[] { pncClaimIn };
                    
                    
                EIPJson.EIP_AgSa_NameValue hasNameValue = new EIPJson.EIP_AgSa_NameValue();
                hasNameValue.name = 'pageSize';
                hasNameValue.value = '10';
                
                EIPJson.EIP_AgSa_NameValue hasNameValue2 = new EIPJson.EIP_AgSa_NameValue();
                hasNameValue.name = 'page';
                hasNameValue.value = properties.get('pagevalue'); //'1';
                
                insurance.hasNameValue = new EIPJson.EIP_AgSa_NameValue[] { hasNameValue, hasNameValue2 };
                
                
                List<EIPJson.EIP_AgSa_InsurancePolicy> insuranceList = new List<EIPJson.EIP_AgSa_InsurancePolicy>();
                insuranceList.add(insurance);
                customerTypeJson.hasPolicyAccount = insuranceList;
                
                String requestJsonEIP = System.JSON.serialize(customerTypeJson.hasPolicyAccount, true);
                System.debug('requestJsonEIP : '+requestJsonEIP);
                
                
            }
            
            if(operation == EIPConstant.SERVICE_ADD_POLICY){
                System.debug('TEST 3');
                EIPJson.EIP_AgSa_InsurancePolicy insurance = new EIPJson.EIP_AgSa_InsurancePolicy();
                insurance.policyNO = properties.get(EIPConstant.PARAM_MSG_POLICY);
                
                    List<EIPJson.EIP_AgSa_InsurancePolicy> insuranceList = new List<EIPJson.EIP_AgSa_InsurancePolicy>();
                    insuranceList.add(insurance);
                    customerTypeJson.hasPolicyAccount = insuranceList;
                
                DateTime test = date.valueOf(properties.get(EIPConstant.PARAM_MSG_DOB));
                String birthdayDate = test.format('YYYY-MM-dd');
                System.debug('TEST birthdayDate: '+birthdayDate);
                
                canBeIndividual.socialSecurityNO = properties.get(EIPConstant.PARAM_MSG_CIF);
                canBeIndividual.birthDT = String.valueOf(birthdayDate);
                canBeIndividual.genderCD = properties.get(EIPConstant.PARAM_MSG_GENDER);
                
                 EIPJson.EIP_IcAx_AXAAsiaIndividualAddress individualAddress = new EIPJson.EIP_IcAx_AXAAsiaIndividualAddress();
                   individualAddress.individualAddressRk = properties.get(EIPConstant.PARAM_MSG_CORESPONDENCE);
                   individualAddress.mobilePhoneNO = properties.get(EIPConstant.PARAM_MSG_PHONE);
                   
                       
                   canBeIndividual.hasAddressesIn = new List<EIPJson.EIP_IcAx_AXAAsiaIndividualAddress>();
                   canBeIndividual.hasAddressesIn.add(individualAddress);
			
			String requestJsonEIP = System.JSON.serialize(customerTypeJson.hasPolicyAccount, true);
            System.debug('requestJsonEIP : '+requestJsonEIP);

                
            }
            
            /*Adding by Fajar Salam*/
            /*Create User Add Hock*/
            if(operation == EIPConstant.SERVICE_GET_ADD_USER){
                if(!String.isEmpty(properties.get(EIPConstant.PARAM_MSG_POLICY))){
                    
                    if(!String.isEmpty(properties.get(EIPConstant.PARAM_MSG_EMAIL))){
                        EIPJson.EIP_IcAx_AXAAsiaIndividualAddress addressCustomer = new EIPJson.EIP_IcAx_AXAAsiaIndividualAddress();
                        addressCustomer.emailAddress = properties.get(EIPConstant.PARAM_MSG_EMAIL);
                        addressCustomer.mobilePhoneNO = properties.get(EIPConstant.PARAM_MSG_PHONE);
                        canBeIndividual.birthDT = properties.get(EIPConstant.PARAM_MSG_DOB);
                        canBeIndividual.genderCD = properties.get(EIPConstant.PARAM_MSG_GENDER);                        
                        List<EIPJson.EIP_IcAx_AXAAsiaIndividualAddress> addressCustomers = new List<EIPJson.EIP_IcAx_AXAAsiaIndividualAddress>();
                        addressCustomers.add(addressCustomer);                        
                        canBeIndividual.hasAddressesIn = addressCustomers;
                    }
                    EIPJson.EIP_AgSa_InsurancePolicy insurance = new EIPJson.EIP_AgSa_InsurancePolicy();
                    insurance.policyNO = properties.get(EIPConstant.PARAM_MSG_POLICY);
                    List<EIPJson.EIP_AgSa_InsurancePolicy> insuranceList = new List<EIPJson.EIP_AgSa_InsurancePolicy>();
                    insuranceList.add(insurance);
                    customerTypeJson.hasPolicyAccount = insuranceList;
                }
                
            }
            /**/
            /*Adding by Fajar Salam*/
            /*Create CHECK User Add Hock*/
            if(operation == EIPConstant.SERVICE_CHECK_USER_ADDHOCK){
                 if(!String.isEmpty(properties.get(EIPConstant.PARAM_MSG_POLICY))){    
                
                    EIPJson.EIP_AgSa_InsurancePolicy insurance = new EIPJson.EIP_AgSa_InsurancePolicy();
                    insurance.policyNO = properties.get(EIPConstant.PARAM_MSG_POLICY);
                    List<EIPJson.EIP_AgSa_InsurancePolicy> insuranceList = new List<EIPJson.EIP_AgSa_InsurancePolicy>();
                    insuranceList.add(insurance);
                    customerTypeJson.hasPolicyAccount = insuranceList;
                }
  
                /*page tabulation*/
                List<EIPJson.EIP_AgSa_NameValue> dynamicsField = new List<EIPJson.EIP_AgSa_NameValue>();
                if(!String.isEmpty(properties.get(EIPConstant.PARAM_ORDER_DIR))){
                     EIPJson.EIP_AgSa_NameValue orderDirField = new EIPJson.EIP_AgSa_NameValue();
                     orderDirField.name = EIPConstant.PARAM_ORDER_DIR;
                     orderDirField.value = properties.get(EIPConstant.PARAM_ORDER_DIR);
                     dynamicsField.add(orderDirField);
                 }                    
                 customerTypeJson.hasNameValue = dynamicsField;
                 /**/
 
            }
            /**/
            /*Adding by Fajar Salam*/
            /*Create User Add Hock LIST*/
            if(operation == EIPConstant.SERVICE_LIST_USER_ADDHOCK){
                 if(!String.isEmpty(properties.get(EIPConstant.PARAM_MSG_POLICY))){                
                    EIPJson.EIP_AgSa_InsurancePolicy insurance = new EIPJson.EIP_AgSa_InsurancePolicy();                    
                    List<EIPJson.EIP_AgSa_InsurancePolicy> insuranceList = new List<EIPJson.EIP_AgSa_InsurancePolicy>();
                    insuranceList.add(insurance);
                    customerTypeJson.hasPolicyAccount = insuranceList;
                    customerTypeJson.validFromDttm = properties.get(EIPConstant.PARAM_MSG_START_DATE);
                    customerTypeJson.validToDttm = properties.get(EIPConstant.PARAM_MSG_END_DATE);
                }
                /*page tabulation*/
                List<EIPJson.EIP_AgSa_NameValue> dynamicsField = new List<EIPJson.EIP_AgSa_NameValue>();
                if(!String.isEmpty(properties.get(EIPConstant.PARAM_ORDER_DIR))){
                     EIPJson.EIP_AgSa_NameValue orderDirField = new EIPJson.EIP_AgSa_NameValue();
                     orderDirField.name = EIPConstant.PARAM_ORDER_DIR;
                     orderDirField.value = properties.get(EIPConstant.PARAM_ORDER_DIR);
                     dynamicsField.add(orderDirField);
                 }                    
                 customerTypeJson.hasNameValue = dynamicsField;
                 /**/
            }
            /**/
            
            customerTypeJson.canBeIndividual = canBeIndividual;
            System.debug('masuk sini');
            
            eipRequestBody.IcAx_AXAAsiaCustomer_Type = customerTypeJson;
            
            EIPJson sendTada = new EIPJson();
            sendTada.Body = eipRequestBody;
            setAuthHeaderCCC(sendTada);
            
            String requestJsonEIP = System.JSON.serialize(sendTada, true);
            System.debug('requestJsonEIP : '+requestJsonEIP);
            
            if(operation == EIPConstant.SERVICE_GET_HISTORY_REGISTER || operation == 'claim'){
                eipResponse = sendRequest(requestJsonEIP, Label.Biz_queueHistoryRegister);
                String eipResponsexx = System.JSON.serialize(eipResponse.Body, true);
            } else {
            eipResponse = sendRequest(requestJsonEIP, Label.Biz_queueRelease);
            }
            checkStatus(eipResponse.Body);
            
            
        }catch(EIPConnector.NoDataException e){
            //still process to front end
            System.debug('no data exception exception ==='+e.getMessage());
        }catch(EIPConnector.EIPConnectorException e){
            System.debug('eipconnector exception ==='+e.getMessage());
        }catch(Exception e){
            system.debug('Error exception == '+e.getStackTraceString()+' in '+e.getLineNumber());
        }
        return eipResponse;
    }
    
    // add by Adi
    public static EIPJson sendCommunicationMessageWhatsapp(String operation, String entity, String appId, Map<String, String> properties) {
        EIPJson eipResponse;
        Config__c jatisConfig = [SELECT Id, Name, Value__c, Generate_Date__c FROM Config__c WHERE App_Id__c = :JATIS LIMIT 1];
        Date today = Date.today();
        try{
            String service = EIPConstant.SERVICE_SEND_COMMUNCATION_MESSAGE;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, false);            
            
            System.debug('properties == '+properties);
            EIPJson.EIP_IcAx_AXAAsiaCustomer customer = new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            List<EIPJson.EIP_AgSa_InsurancePolicy> hasPolicyAccount = new List<EIPJson.EIP_AgSa_InsurancePolicy>();
            List<EIPJson.EIP_IcAx_AXAAsiaCustomer> hasCustomerInformationIn = new List<EIPJson.EIP_IcAx_AXAAsiaCustomer>();
            List<EIPJson.EIP_CustomerCommunication> haveCommunicatedMessage = new list<EIPJson.EIP_CustomerCommunication>();
            
            EIPJson.EIP_AgSa_InsurancePolicy policyAccount = new EIPJson.EIP_AgSa_InsurancePolicy();
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerInformationIn = new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            EIPJson.EIP_CustomerCommunication communicated1 = new EIPJson.EIP_CustomerCommunication();
            EIPJson.EIP_CustomerCommunication communicated2 = new EIPJson.EIP_CustomerCommunication();
            EIPJson.EIP_CustomerCommunication communicated3 = new EIPJson.EIP_CustomerCommunication(); // updated by Support MII at 22 04 24
            EIPJson.EIP_CustomerCommunication communicated4 = new EIPJson.EIP_CustomerCommunication(); // updated by Support MII at 22 04 24
            EIPJson.EIP_CustomerCommunication communicated5 = new EIPJson.EIP_CustomerCommunication();
            EIPJson.EIP_CustomerCommunication communicated6 = new EIPJson.EIP_CustomerCommunication(); // updated by Elviana Victoria june 2025
            EIPJson.EIP_CustomerCommunication communicated7 = new EIPJson.EIP_CustomerCommunication();
            EIPJson.EIP_CustomerCommunication communicated8= new EIPJson.EIP_CustomerCommunication();
            
            
            // updated by Support MII at 22 04 24
            if (properties.get(EIPConstant.WA_CATEGORY) != 'BookingCall'){
                communicated1.messageType = EIPConstant.WA_CC_MESSAGE_TYPE;
                communicated1.message = properties.get(EIPConstant.WA_CUSTOMER_GENDER);
                haveCommunicatedMessage.add(communicated1);
                communicated2.messageType = EIPConstant.WA_CC_MESSAGE_TYPE;
                communicated2.message = properties.get(EIPConstant.WA_CUSTOMER_NAME);
                haveCommunicatedMessage.add(communicated2);
                communicated3.messageType = EIPConstant.WA_CC_MESSAGE_TYPE;
                communicated3.message = properties.get(EIPConstant.WA_CUSTOMER_SERVICE);
                haveCommunicatedMessage.add(communicated3);
                communicated4.messageType = EIPConstant.WA_CC_MESSAGE_TYPE;
                communicated4.message = properties.get(EIPConstant.WA_SURVEY_URL_LINK);
                haveCommunicatedMessage.add(communicated4);
            } else{
                communicated1.messageType = EIPConstant.WA_CC_MESSAGE_TYPE;
                communicated1.message = properties.get(EIPConstant.WA_CUSTOMER_GENDER);
                haveCommunicatedMessage.add(communicated1);
                communicated2.messageType = EIPConstant.WA_CC_MESSAGE_TYPE;
                communicated2.message = properties.get(EIPConstant.WA_CUSTOMER_NAME);
                haveCommunicatedMessage.add(communicated2);
                communicated3.messageType = EIPConstant.WA_CC_MESSAGE_TYPE;
                communicated3.message = properties.get(EIPConstant.WA_SUBMISSION_TYPE);
                haveCommunicatedMessage.add(communicated3);
                communicated4.messageType = EIPConstant.WA_CC_MESSAGE_TYPE;
                communicated4.message = properties.get(EIPConstant.WA_POLICY_NUMBER);
                haveCommunicatedMessage.add(communicated4);
                communicated5.messageType = EIPConstant.WA_CC_MESSAGE_TYPE;
                communicated5.message = properties.get(EIPConstant.WA_CUSTOMER_GENDER);
                haveCommunicatedMessage.add(communicated5);
                communicated6.messageType = EIPConstant.WA_CC_MESSAGE_TYPE;
                communicated6.message = properties.get(EIPConstant.WA_CUSTOMER_GENDER);
                haveCommunicatedMessage.add(communicated6);
                communicated7.messageType = EIPConstant.WA_CC_MESSAGE_TYPE;
                communicated7.message = properties.get(EIPConstant.WA_CUSTOMER_GENDER);
                haveCommunicatedMessage.add(communicated7);
                communicated8.messageType = EIPConstant.WA_CC_MESSAGE_TYPE;
                communicated8.message = properties.get(EIPConstant.WA_CUSTOMER_GENDER);
                haveCommunicatedMessage.add(communicated8);
            }
            
            // set hasCustomerInformationIn payload
            customerInformationIn.haveCommunicatedMessage = haveCommunicatedMessage;
            system.debug('haveCommunicatedMessage cek ==> ' + haveCommunicatedMessage);
            customerInformationIn.sourceCInd =properties.get(EIPConstant.WA_NAMESPACE);
            customerInformationIn.documentID = properties.get(EIPConstant.WA_TEMPLATE_ID);
            hasCustomerInformationIn.add(customerInformationIn);
            
            // set hasPolicyAccount payload
            policyAccount.hasCustomerInformationIn = hasCustomerInformationIn;
            policyAccount.sourceChannelCD = properties.get(EIPConstant.WA_PHONE_TO);
            hasPolicyAccount.add(policyAccount);
            
            // set customer payload
            customer.hasPolicyAccount = hasPolicyAccount;
            customer.sourceCInd = Label.EIP_Jatis_WA_User;
            customer.dependentNO = Label.EIP_Jatis_WA_Pass;
            system.debug('generate date ==> ' + jatisConfig.Generate_Date__c);
            system.debug('today ==> ' + today);
            system.debug('jatistoken ==> ' + jatisConfig.Value__c);
            if (jatisConfig.Generate_Date__c == today) customer.customerID = jatisConfig.Value__c;
            
            system.debug('Customer ==> ' + customer.customerID);
            
            eipRequestBody.Customer = customer;
            
            EIPJson sendWhatsapp = new EIPJson();
            sendWhatsapp.Body = eipRequestBody;
            setAuthHeaderCCC(sendWhatsapp);
            
            String requestJsonEIP = System.JSON.serialize(sendWhatsapp, true);
            System.debug('requestJsonEIP : '+requestJsonEIP);
            
            eipResponse = sendRequest(requestJsonEIP, Label.Biz_queueRelease);
            System.debug('ResponseJsonEIP cekk ya : '+ eipResponse);
            checkStatus(eipResponse.Body);
            if (jatisConfig.Generate_Date__c != today) {
                jatisConfig.Value__c = eipResponse.Body.customer.customerID;
                jatisConfig.Generate_Date__c = today;
                update jatisConfig;
            }
 
        }catch(EIPConnector.NoDataException e){
            System.debug('[#] [ No Data Whatsapp Service] '+ e);
            throw new EIPConnector.NoDataException(e.getMessage());
        }catch(EIPConnector.EIPConnectorException e){
            System.debug('[#] [ EIP Connector Whatsapp Service] '+ e);
            throw new EIPConnector.EIPConnectorException(e.getMessage());
        }catch(Exception e){
            System.debug('[#] [ Exception Whatsapp Service] '+ e);
            throw new EIPConnector.EIPException(e.getMessage());
        }
        
        return eipResponse;
    }
    
    //Start GetCustomerList from MDM by Faizir (02-03-2020)
    
    // Separate getCustomerList by sourceCInd
    public static EIPJson getCustomerList(String operation, String entity, String appId, String relatedPolicy, Map<String,List<String>> params){
        EIPJson eipResponse;
        
            List<String> accountNOs = new List<String>();
            List<String> emailAddresses = new List<String>();
            List<String> telephoneNOs = new List<String>();
            List<String> socialSecurityNOs = new List<String>();
            List<String> nameDobGender = new List<String>();
            List<String> customerIDs = new List<String>();
            List<String> documentIDs = new List<String>();
            try{
                system.debug('Method : getCustomerList');
                String sourceCInd;
                Set <String> keys = new Set<String>();
                keys = params.keySet();
                for(String key : keys){
                    sourceCInd = key;
                }
                String service = EIPConstant.SERVICE_GET_CUST_INFO;
                EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
                
                // construct Customer Party account
                EIPJson.EIP_IcAx_AXAAsiaPartyAccount hasPartyAccountDetailsIn = null;
                if(sourceCInd == EIPConstant.ACC_NO){
                    accountNOs = params.get(EIPConstant.ACC_NO);
                    if(accountNOs.size() > 0){
                        hasPartyAccountDetailsIn = new EIPJson.EIP_IcAx_AXAAsiaPartyAccount();      
                        hasPartyAccountDetailsIn.accountNO = accountNOs[0];
                    }
                }
                
                // construct Customer Addresses Information
                EIPJson.EIP_IcAx_AXAAsiaIndividualAddress hasAddressesIn = null;
                if(sourceCInd == EIPConstant.EMAIL){
                    hasAddressesIn = new EIPJson.EIP_IcAx_AXAAsiaIndividualAddress();
                    emailAddresses = params.get(EIPConstant.EMAIL);
                    if(emailAddresses.size() > 0){
                        hasAddressesIn.emailAddress = emailAddresses[0];
                    }
                }else if(sourceCInd == EIPConstant.PHONE_NO) {
                    hasAddressesIn = new EIPJson.EIP_IcAx_AXAAsiaIndividualAddress();
                    telephoneNOs = params.get(EIPConstant.PHONE_NO);
                    if(telephoneNOs.size() > 0){
                        hasAddressesIn.telephoneNO = telephoneNOs[0];
                        hasAddressesIn.addressTypeCD = telephoneNOs[1];
                    }
                }
                
                // construct Customer Individual
                EIPJson.EIP_IcAx_AXAAsiaIndividual canBeIndividual = null;
                if(sourceCInd == EIPConstant.ID_DOC){
                    socialSecurityNOs = params.get(EIPConstant.ID_DOC);
                    if(socialSecurityNOs.size() > 0){
                        canBeIndividual = new EIPJson.EIP_IcAx_AXAAsiaIndividual();
                        canBeIndividual.socialSecurityNO = socialSecurityNOs[0];
                        canBeIndividual.hasPartyAccountDetailsIn = hasPartyAccountDetailsIn;
                    }
                }else if(sourceCInd == EIPConstant.NAME_DOB_GENDER){
                    nameDobGender = params.get(EIPConstant.NAME_DOB_GENDER);
                    if(nameDobGender.size() > 0){
                        canBeIndividual = new EIPJson.EIP_IcAx_AXAAsiaIndividual();
                        canBeIndividual.firstNM = nameDobGender[0];
                        canBeIndividual.birthDT = nameDobGender[1];
                        canBeIndividual.genderCD = nameDobGender[2];
                        canBeIndividual.hasPartyAccountDetailsIn = hasPartyAccountDetailsIn;
                    }
                }
                if(hasAddressesIn != null){
                    canBeIndividual = new EIPJson.EIP_IcAx_AXAAsiaIndividual();
                    canBeIndividual.hasAddressesIn = new EIPJson.EIP_IcAx_AXAAsiaIndividualAddress[]{hasAddressesIn};
                        }
                if(hasPartyAccountDetailsIn != null){
                    canBeIndividual = new EIPJson.EIP_IcAx_AXAAsiaIndividual();
                    canBeIndividual.hasPartyAccountDetailsIn = hasPartyAccountDetailsIn;
                }
                
                // construct for object Body
                eipRequestBody.service = service;
                initBody(eipRequestBody, operation, entity, appId,false);
                EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson = new EIPJson.EIP_IcAx_AXAAsiaCustomer();
                customerTypeJson.sourceCInd = sourceCInd;
                customerTypeJson.relatedPolicy = relatedPolicy;
                if(sourceCInd == EIPConstant.NAME_DOB_GENDER){
                    if(nameDobGender.size() > 0){
                        customerTypeJson.customerRK = nameDobGender[3];   
                    }
                }
                customerTypeJson.canBeIndividual = canBeIndividual;
                
                if(sourceCInd == EIPConstant.MDM_ID){
                    customerIDs = params.get(EIPConstant.MDM_ID);
                    if(customerIDs.size() > 0){
                        customerTypeJson.customerID = customerIDs[0];  
                    }
                }
                
                if(sourceCInd == EIPConstant.POLICY_NO){
                    documentIDs = params.get(EIPConstant.POLICY_NO);
                    if(documentIDs.size() > 0){
                        customerTypeJson.documentID = documentIDs[0];
                    }
                }
                eipRequestBody.IcAx_AXAAsiaCustomer_Type = customerTypeJson;
                
                EIPJson requestCustomerList = new EIPJson();
                requestCustomerList.Body = eipRequestBody;
                setAuthHeaderCCC(requestCustomerList);
                
                String requestJsonEIP = System.JSON.serialize(requestCustomerList, true);
                
                // set signature
                Long start =  DateTime.now().getTime();
                paramsOfSignature.add(service);
                paramsOfSignature.add(operation);
                paramsOfSignature.add(entity);
                paramsOfSignature.add(appId);
                paramsOfSignature.add(String.valueOf(start));
                signature = generateSignature(paramsOfSignature);
                
                eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getCustomerInfo);
                
                checkStatus(eipResponse.Body);
                
            }catch(EIPConnector.NoDataException e){
                System.debug('tidak ada data getCustomerList');
                throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
                //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'No Data Available.'));
            }catch(EIPConnector.EIPConnectorException e){
                System.debug('EIPConnector Exception');
                //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
            }
        //}
        
        return eipResponse;
    }
    /*
    * END GetCustomerList from MDM by Faizir (02-03-2020)
    */
    
    // Catur 20201014, for fullerton integration
    public static EIPJson getCustomerInfoFullerton(String operation, String entity, String appid, Map<String, String> params){
        EIPJson eipResponse;
        try{
            system.debug('starting Get Customer List Personal...');
            
            String service = EIPConstant.SERVICE_ADD_CUSTOMER;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, false);
            
            // set startDatetime and endDatetime history request
            EIPJson.EIP_AXAAsiaPagination paging = new EIPJson.EIP_AXAAsiaPagination();
            paging.pageNumber = params.get(EIPConstant.PARAM_PAGE_NUMBER);
            paging.rowPerPage = params.get(EIPConstant.PARAM_ROW_PER_PAGE);
            eipRequestBody.AXAAsiaPagination_Type = paging;
            
            // construct customer type
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson= new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            
            EIPJson.EIP_IcAx_AXAAsiaIndividual individualCustomer = new EIPJson.EIP_IcAx_AXAAsiaIndividual();
            individualCustomer.firstNM = params.get(EIPConstant.PARAM_FIRST_NAME);
            individualCustomer.lastNM = params.get(EIPConstant.PARAM_LAST_NAME);
            individualCustomer.localNM = params.get(EIPConstant.PARAM_USERNAME);
            individualCustomer.socialSecurityNO = params.get(EIPConstant.PARAM_UNIQUE_NUMBER);
            individualCustomer.birthDT = params.get(EIPConstant.PARAM_MSG_DOB);
            
            if(!String.isEmpty(params.get(EIPConstant.PARAM_MOBILE_NUMBER))){
                EIPJson.EIP_IcAx_AXAAsiaIndividualAddress addressCustomer = new EIPJson.EIP_IcAx_AXAAsiaIndividualAddress();
                addressCustomer.mobilePhoneNO = params.get(EIPConstant.PARAM_MOBILE_NUMBER);
                List<EIPJson.EIP_IcAx_AXAAsiaIndividualAddress> addressCustomers = new List<EIPJson.EIP_IcAx_AXAAsiaIndividualAddress>();
                addressCustomers.add(addressCustomer);
                individualCustomer.hasAddressesIn = addressCustomers;
            }
            customerTypeJson.canBeIndividual = individualCustomer;
            
            if(!String.isEmpty(params.get(EIPConstant.PARAM_ORDER_BY)) || !String.isEmpty(params.get(EIPConstant.PARAM_ORDER_DIR))){
                List<EIPJson.EIP_AgSa_NameValue> dynamicsField = new List<EIPJson.EIP_AgSa_NameValue>();
                if(!String.isEmpty(params.get(EIPConstant.PARAM_ORDER_BY))){
                    EIPJson.EIP_AgSa_NameValue orderByField = new EIPJson.EIP_AgSa_NameValue();
                    orderByField.name = EIPConstant.PARAM_ORDER_BY;
                    orderByField.value = params.get(EIPConstant.PARAM_ORDER_BY);
                    dynamicsField.add(orderByField);
                }
                
                if(!String.isEmpty(params.get(EIPConstant.PARAM_ORDER_DIR))){
                    EIPJson.EIP_AgSa_NameValue orderDirField = new EIPJson.EIP_AgSa_NameValue();
                    orderDirField.name = EIPConstant.PARAM_ORDER_DIR;
                    orderDirField.value = params.get(EIPConstant.PARAM_ORDER_DIR);
                    dynamicsField.add(orderDirField);
                }
                
                customerTypeJson.hasNameValue = dynamicsField;
            }
            
            eipRequestBody.IcAx_AXAAsiaCustomer_Type = customerTypeJson;
            
            EIPJson requestCustomerInfo = new EIPJson();
            requestCustomerInfo.Body = eipRequestBody;
            setAuthHeaderCCC(requestCustomerInfo);
            
            String requestJsonEIP = System.JSON.serialize(requestCustomerInfo, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(params.toString());
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getCustomerInfo);
            
            checkStatus(eipResponse.Body);
            
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            system.debug(e.getMessage());
            system.debug('Error exception == '+e.getStackTraceString()+' in '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }catch(Exception e){
            system.debug(e.getMessage());
            system.debug('Error exception == '+e.getStackTraceString()+' in '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ERROR_MESSAGE));
        }
        return eipResponse;
    }
    
    // Catur, 20211012 get policy detail with params for dmu
    public static EIPJson getPolicyDetails(String operation, String entity, String appId, String policyNumber, Map<String, String> params){
        EIPJson eipResponse;
        try{
            String service = EIPConstant.SERVICE_GET_POLICY_DETAIL;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
            
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, false);
            
            // construct policy number
            EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy = new EIPJson.EIP_AgSa_InsurancePolicy();
            insurancePolicy.policyNO = policyNumber;
            insurancePolicy.applicationRk = params.get(EIPConstant.PARAM_TYPE);
            insurancePolicy.validFromDttm = params.get(EIPConstant.VALID_FROM_DTTM);
            insurancePolicy.validToDttm = params.get(EIPConstant.VALID_TO_DTTM);
            insurancePolicy.reEntryRt = params.get(EIPConstant.PARAM_DMU_NEXTPAGE);
            // construct customer type
            EIPJson.EIP_IcAx_AXAAsiaCustomer customerTypeJson= new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            customerTypeJson.sourceCInd = params.get(EIPConstant.PARAM_SOURCE);
            customerTypeJson.documentID = params.get(EIPConstant.PARAM_REQUEST_ID);
            customerTypeJson.customerClassCD = params.get(EIPConstant.PARAM_RESULT_GROUP);
            customerTypeJson.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{insurancePolicy};
                eipRequestBody.IcAx_AXAAsiaCustomer_Type = customerTypeJson;
            
            EIPJson requestPolicyDetail = new EIPJson();
            requestPolicyDetail.Body = eipRequestBody;
            setAuthHeaderCCC(requestPolicyDetail);
            
            String requestJsonEIP = System.JSON.serialize(requestPolicyDetail, true);
            
            // set signature
            paramsOfSignature.add(service);
            paramsOfSignature.add(operation);
            paramsOfSignature.add(entity);
            paramsOfSignature.add(appId);
            paramsOfSignature.add(policyNumber);
            paramsOfSignature.add(params.toString());
            signature = generateSignature(paramsOfSignature);
            
            eipResponse = sendRequest(signature, requestJsonEIP, Label.Biz_getPolicyDetail);
            
            checkStatus(eipResponse.Body);
        }catch(EIPConnector.NoDataException e){
            throw new NoDataException(EIPConstant.ERROR_MSG_NODATA);
        }catch(EIPConnector.EIPConnectorException e){
            system.debug(e.getMessage());
            throw new EIPConnectorException(e.getMessage());
        }
        
        return eipResponse;
    }
    
    private static String generateUID() {
        String hashString = '1000' + String.valueOf(Datetime.now().formatGMT(DATE_FORMAT_YYYYMMDD_HHMMSS_SSS));
        Blob hash = Crypto.generateDigest(HASH_MD5, Blob.valueOf(hashString));
        String hexDigest = EncodingUtil.convertToHex(hash);
        system.debug('##########' + hexDigest );
        return  UserInfo.getUserId() +'-' + Datetime.now().format(DATE_FORMAT_YYYYMMDD) +'-'+ hexDigest;
    }
    
    private static boolean isNoDataError (String errCode){
        return label.WS_NoData_ErrCode.contains(errCode);
    }
    
    private static boolean isUnknownCriteria (String errCode){
        return label.WS_UnknownCriteria_ErrCode.contains(errCode);
    }
    
    public static String generateSignature(List<String> params){
        String key = '';
        for(String param : params){
            key += String.valueOf(param);
        }
        blob hashSHA1 = Crypto.generateDigest(HASH_SHA1, blob.valueOf(key));
        String result = EncodingUtil.base64encode(hashSHA1);
        return result;
    }
    
    // Catur, 20210317 future method for insert log pcidss
    @future
    public static void insertLogPcidss(Datetime requestTime, Datetime responseTime, 
                                       String requestJsonString, String responseJsonString, 
                                       String orderId, String policyApp, String entity, 
                                       String operation, String service)
    {
        Log_PCIDSS__c logPcidss = new Log_PCIDSS__c();
        logPcidss.Request_Time__c = requestTime;
        logPcidss.Response_Time__c = responseTime;
        logPcidss.Request_JSON__c = requestJsonString;
        logPcidss.Response_JSON__c = responseJsonString;
        logPcidss.Order_ID__c = orderId;
        logPcidss.Policy_App__c = policyApp;
        logPcidss.Entity__c = entity;
        logPcidss.Operation__c = operation;
        logPcidss.Service__c = service;
        
        try{
            EIPJson responseEipJson = (EIPJson) System.JSON.deserialize(responseJsonString, EIPJson.class);
            logPcidss.Response_Code__c = responseEipJson.Body.status;
            if(responseEipJson.Body.status == EIPConstant.STATUS_SUCCESS){
                system.debug('########## masuk sini atas' );
                logPcidss.Response_Message__c = EIPConstant.STATUS_SUCCESS_2;
            }else{
                system.debug('########## masuk sini' );
                logPcidss.Response_Message__c = responseEipJson.Body.exceptionObj.message + ';' + responseEipJson.Body.exceptionObj.code;
            }
        }catch(JSONException ex){
            logPcidss.Response_Code__c = EIPConstant.STATUS_FAILED;
            logPcidss.Response_Message__c = responseJsonString;
    	}catch(Exception ex){
            logPcidss.Response_Code__c = EIPConstant.STATUS_FAILED;
            logPcidss.Response_Message__c = ex.getStackTraceString() + ';' + ex.getCause();
        }
        insert logPcidss;
    }
    
    public static EIPJson submitMetadata(String operation, String entity, String appId, Map<String, String> properties) {
       system.debug('## submitMetadata connector x' );
        return submitMetadata(operation, entity, appId, properties, false);
    }
    
    public static EIPJson submitMetadata(String operation, String entity, String appId, Map<String, String> properties, boolean isPagination) {
        system.debug('## submitMetadata connector' );
        EIPJson eipResponse;
        try {
            
            String service = EIPConstant.SERVICE_ADD_CUSTOMER;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
			
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            
            //Construct hasDetailsOfPolicyTransactionIn
            EIPJson.EIP_IcAx_AXAAsiaGeneralPolicyTrans policyDetail = new EIPJson.EIP_IcAx_AXAAsiaGeneralPolicyTrans();
            policyDetail.transactionTypeDesc= properties.get(EIPConstant.PARAM_TRANSACTION_TYPE);
            system.debug('## policyDetail.transactionTypeDesc ' + policyDetail.transactionTypeDesc );
            system.debug('## policyDetail.transactionTypeDesc x ' + properties.get(EIPConstant.PARAM_TRANSACTION_TYPE) );
            
            List<EIPJson.EIP_AgSa_NameValue> hasName = new List<EIPJson.EIP_AgSa_NameValue>();
            
            for (String key : properties.keySet()) {
                EIPJson.EIP_AgSa_NameValue nv = new EIPJson.EIP_AgSa_NameValue();
                nv.name = key; // key = param name seperti PARAM_MSG_POLICY
                nv.value = properties.get(key);
                hasName.add(nv);
            }
            
            //construct policy
            EIPJson.EIP_AgSa_InsurancePolicy policy = new EIPJson.EIP_AgSa_InsurancePolicy();
            policy.policyNO = properties.get(EIPConstant.PARAM_MSG_POLICY);
            policy.key = properties.get(EIPConstant.PARAM_CASE_NUMBER);
            policy.processedDttm = properties.get(EIPConstant.PARAM_MSG_DTTM);
            policy.sourceChannelCD = properties.get(EIPConstant.PARAM_SOURCE_CHANNEL_ID);
            policy.applicationRk = properties.get(EIPConstant.PARAM_TYPE);
            policy.customerRk= properties.get(EIPConstant.PARAM_CUSTOMER_RK);
            policy.policyStatusRk = 'NEW CASE';
            policy.hasDetailsOfPolicyTransactionIn = new EIPJson.EIP_IcAx_AXAAsiaGeneralPolicyTrans[]{policyDetail};
            policy.hasNameValue = hasName;
            
            
            //Construct customer
            EIPJson.EIP_IcAx_AXAAsiaCustomer customer= new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            customer.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{policy};
            eipRequestBody.IcAx_AXAAsiaCustomer_Type = customer; 
            
            EIPJson requestPolicyDetail = new EIPJson();
            requestPolicyDetail.Body = eipRequestBody;
            setAuthHeaderCCC(requestPolicyDetail);
            
            String requestJsonEIP = System.JSON.serialize(requestPolicyDetail, true);
            
        system.debug('requestJsonEIP ===== '+requestJsonEIP);
            
            eipResponse = sendRequest(requestJsonEIP, Label.Biz_getCustomerInfo);
            
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        }
        
        return eipResponse;
    }  
	
    
    // Upload Image to DIPCAD
    public static EIPJson addCustomer(String operation, String entity, String appId, Blob fileImage, Map<String, String> properties) {
        return addCustomer(operation, entity, appId, fileImage, properties, false);
    }
    
    public static EIPJson addCustomer(String operation, String entity, String appId, Blob fileImage, Map<String, String> properties, boolean isPagination) {
        EIPJson eipResponse;
        try {
            
            String service = EIPConstant.SERVICE_ADD_CUSTOMER;
            EIPJson.EIP_Body eipRequestBody = new EIPJson.EIP_Body();
			
            // construct for object Body
            eipRequestBody.service = service;
            initBody(eipRequestBody, operation, entity, appId, isPagination);
            String fileImageEncode = EncodingUtil.base64encode(fileImage).toString();
            if (Test.isRunningTest()) fileImageEncode = 'qwertyui12345';
            //Construct hasDocumentDetailsIn
            EIPJson.EIP_IcAx_AXAAsiaDocumentDetailsIn hasDocumentDetailsIn = new EIPJson.EIP_IcAx_AXAAsiaDocumentDetailsIn();
            hasDocumentDetailsIn.documentID = properties.get(EIPConstant.PARAM_DOCUMENT_ID);
            hasDocumentDetailsIn.documentMIMETypeCD = fileImageEncode;
            hasDocumentDetailsIn.documentNM = properties.get(EIPConstant.PARAM_DOCUMENT_NAME);
            hasDocumentDetailsIn.documentTypeCD = properties.get(EIPConstant.PARAM_WORKTYPE);
            system.debug('document encoded? '+hasDocumentDetailsIn.documentMIMETypeCD);            
            //construct policy
            EIPJson.EIP_AgSa_InsurancePolicy policy = new EIPJson.EIP_AgSa_InsurancePolicy();
            policy.policyNO = properties.get(EIPConstant.PARAM_MSG_POLICY);
            policy.key = properties.get(EIPConstant.PARAM_CASE_NUMBER);
            policy.processedDttm = properties.get(EIPConstant.PARAM_MSG_DTTM);
            policy.validFromDttm = properties.get(EIPConstant.VALID_FROM_DTTM);
            policy.applicationRk = properties.get(EIPConstant.PARAM_TYPE);
            policy.sourceChannelCD = properties.get(EIPConstant.PARAM_SOURCE_CHANNEL_ID);
            policy.hasDocumentDetailsIn = new EIPJson.EIP_IcAx_AXAAsiaDocumentDetailsIn[]{hasDocumentDetailsIn};
            
            //Construct customer
            EIPJson.EIP_IcAx_AXAAsiaCustomer customer= new EIPJson.EIP_IcAx_AXAAsiaCustomer();
            customer.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{policy};
            eipRequestBody.IcAx_AXAAsiaCustomer_Type = customer;
                        
            EIPJson requestPolicyDetail = new EIPJson();
            requestPolicyDetail.Body = eipRequestBody;
            setAuthHeaderCCC(requestPolicyDetail);
            
            String requestJsonEIP = System.JSON.serialize(requestPolicyDetail, true);
            eipResponse = sendRequest(requestJsonEIP, Label.Biz_getCustomerInfo);
            
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        }
        
        return eipResponse;
    }
}