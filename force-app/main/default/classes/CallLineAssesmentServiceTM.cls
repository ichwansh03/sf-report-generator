public class CallLineAssesmentServiceTM {
    
    @future(callout=true)    
    public static void requestPolicyTM(String clid){
      
        Call_Line__c cl = BaseCoreServiceController.generateCallLine(clid);
        String ctTeleservicePBC = BaseCoreServiceController.getValueFilterReport('Report Teleservice & PBC DMTM', 'Call_Line__c.Case_Type__c');
        String userTeleservicePBC = BaseCoreServiceController.getValueFilterReport('Report Teleservice & PBC DMTM', 'Call_Line__c.Agent__c');
        
        User user = BaseCoreServiceController.generateUser(cl.Agent__c);
        
        String mapRemarks = '('+user.ID_User_DMTM__c+') '+DateTime.valueOfGmt(cl.LastModifiedDate.toString()).format()+' '+cl.Call_Remarks__c;
        
        //custom setting for mapping reason status
        Map<String, CallLine_Reason_Type__c> reasonMap = new Map<String, CallLine_Reason_Type__c>();
        for (CallLine_Reason_Type__c reason : CallLine_Reason_Type__c.getAll().values()){
            reasonMap.put(reason.Value__c, reason);
        }
        
        //custom setting for mapping activity result
        Map<String, Call_Status_Type__c> statusMap = new Map<String, Call_Status_Type__c>();
        for (Call_Status_Type__c status : Call_Status_Type__c.getAll().values()) {
            statusMap.put(status.Name, status);
        }

        Map<String, String> prop = new Map<String, String>();
        prop.put(EIPConstant.FIELD_ID, cl.Id);
        prop.put(EIPConstant.FIELD_CREATED_DATE, cl.CreatedDate.toString());
        prop.put(EIPConstant.FIELD_CALL_REMARK, mapRemarks);
        prop.put(EIPConstant.FIELD_POLICY_NO, cl.Policy_No__c);
        prop.put(EIPConstant.FIELD_ID_DMTM, user.ID_User_DMTM__c);
		prop.put(EIPConstant.FIELD_CASE_TYPE, cl.Case_Type__c);
        prop.put(EIPConstant.FIELD_CONTACTED_NUMBER, cl.Contacted_Number__c.toString());
        
        if (cl.Case_Type__c == 'Redemption TM') {
            prop.put(EIPConstant.FIELD_ACTIVITY_RESULT, statusMap.get(cl.Activity_Result__c).Status_ID__c);
            prop.put(EIPConstant.FIELD_REASON_STATUS, reasonMap.get(cl.Reason_Status_Config__c).Type_ID__c);

            insertConservation(prop);
        }
        if ((ctTeleservicePBC.contains(cl.Case_Type__c) && userTeleservicePBC.contains(cl.Agent__r.Name)) || cl.Case_Type__c == 'Lapse TM') {
            prop.put(EIPConstant.FIELD_ACTIVITY_RESULT, cl.Activity_Result__c);
            prop.put(EIPConstant.FIELD_REASON_STATUS, cl.Reason_Status_Config__c);
            if (cl.Case_Type__c == 'Teleservice') {
                
            } else {
             	insertCallNote(prop);
            }
        } 
    }
    
    private static String getCustomerId(String id, String policyNo) {
        
        EIPJson requestPolicy = new EIPJson();
        Map<String, String> properties = new Map<String, String>();
        String custId = '';
        
        try {
            properties.put(EIPConstant.PARAM_TYPE, '10');
            properties.put(EIPConstant.PARAM_MSG_POLICY, policyNo);
            properties.put(EIPConstant.PARAM_MSG_PRODUCER, '1');
            
            requestPolicy = EIPConnector.getRequest(EIPConstant.OPERATION_REQUEST_INQUIRY, EIPConstant.ENTITY_AMFS, EIPConstant.APP_DMTM_REST_V3, properties);
            system.debug('requestPolicy result: '+requestPolicy);
            
            if (requestPolicy.Body.Customer != null) {
                for(EIPJson.EIP_AgSa_InsurancePolicy hasPolis : requestPolicy.Body.Customer.hasPolicyAccount) {
                    if (hasPolis.hasCustomerInformationIn != null) {
                        for(EIPJson.EIP_IcAx_AXAAsiaCustomer customer : hasPolis.hasCustomerInformationIn){
                            if (customer.customerID != null && customer.customerStatusCD == 'CV') {
                                custId = customer.customerID;
                            } else if (customer.customerID != null && customer.customerStatusCD != 'CV') {
                                custId = customer.customerStatusCD;
                            }
                        }    
                    }
                }    
            }
        } catch (Exception e) {
            system.debug('CallLineAssesmentDMTM.getPolicyLatestRedemptTM Error: '+e.getMessage());
        }
        
        return custId;
    }
    
    public static void insertConservation(Map<String, String> requestProp) {
        
        long startLongTime = system.now().getTime();
        String message = '', response, request, custId;
        
        EIPJson addCustConservation = new EIPJson();
        
        try {
            system.debug('insert data customer to table conservation');
            custId = getCustomerId(requestProp.get(EIPConstant.FIELD_ID), requestProp.get(EIPConstant.FIELD_POLICY_NO));
            Map<String, String> properties = new Map<String, String>();
            properties.put(EIPConstant.PARAM_MSG_POLICYRK, requestProp.get(EIPConstant.FIELD_CALL_REMARK));
            properties.put(EIPConstant.PARAM_STATUS_REASON, requestProp.get(EIPConstant.FIELD_ACTIVITY_RESULT));
            properties.put(EIPConstant.PARAM_MSG_DTTM, requestProp.get(EIPConstant.FIELD_CREATED_DATE));
            properties.put(EIPConstant.PARAM_MSG_POLICY, requestProp.get(EIPConstant.FIELD_POLICY_NO));
            properties.put(EIPConstant.PARAM_MSG_UWTYPE, requestProp.get(EIPConstant.FIELD_REASON_STATUS));
            properties.put(EIPConstant.PARAM_MSG_OTHER_IND, custId);
            properties.put(EIPConstant.PARAM_MSG_REGISTERED, 'SFDC Services');
            
            addCustConservation = EIPConnector.addCustomerConservation(EIPConstant.OPERATION_INSERT_CONSERVATION, EIPConstant.ENTITY_AMFS, EIPConstant.APP_DMTM_REST_V3, properties);
            system.debug('conservation response: '+addCustConservation);
            response = addCustConservation.toStringJson();
            
            if (addCustConservation.errorMessage != null) message = addCustConservation.errorMessage;
            if (addCustConservation.Body.Status == '0' || addCustConservation.Body.Status == null) message = addCustConservation.Body.exceptionObj.message;
            if (!String.isBlank(custId) && !Pattern.matches('^[0-9\\-]+$', custId)) message = 'Last Customer Status CD is '+custId;
            
        } catch (Exception e) {
            system.debug('CallLineAssesmentDMTM.sendReqAssesmentTM Error: '+e.getMessage()); 
        }
        
        Map<String, String> logProp = new Map<String, String>();
        logProp.put('ObjectId',requestProp.get(EIPConstant.FIELD_ID));
        logProp.put('Message',message);
        logProp.put('Report','AMFS Collection Robot DMTM');
        logProp.put('CaseType',requestProp.get(EIPConstant.FIELD_CASE_TYPE));
        logProp.put('Request',EIPConnector.getRequestPrettyPrint());
        logProp.put('Response',addCustConservation.toStringJSON());
        BaseCoreServiceController.insertLog(logProp, startLongTime);

    }
    
    public static void retryConservation(EIPJson response, String id) {
        Map<String, String> requestProp = new Map<String, String>();
        String operation = response.Body.operation;
        EIPJson.EIP_AgSa_InsurancePolicy hasPolicy = response.Body.Customer.hasPolicyAccount[0];
        
        requestProp.put(EIPConstant.FIELD_ACTIVITY_RESULT, hasPolicy.uwTypeCd);
        requestProp.put(EIPConstant.FIELD_REASON_STATUS, hasPolicy.statusReasonCd);
        requestProp.put(EIPConstant.FIELD_CALL_REMARK, hasPolicy.policyRk);
        requestProp.put(EIPConstant.FIELD_CREATED_DATE, hasPolicy.processedDttm);
        requestProp.put(EIPConstant.FIELD_ID, id);
        insertConservation(requestProp);
    }
    
    public static void insertCallNote(Map<String, String> requestProp){
        long startLongTime = system.now().getTime();
        String message = '', statusCode, response;
        
        EIPJson addCustCallNote = new EIPJson();
        
        try {            
            system.debug('insert data customer to table call note');
            Map<String, String> properties = new Map<String, String>();
            properties.put(EIPConstant.PARAM_MSG_POLICYRK, requestProp.get(EIPConstant.FIELD_CALL_REMARK));
            properties.put(EIPConstant.PARAM_MSG_REGISTERED, requestProp.get(EIPConstant.FIELD_ID_DMTM));
            properties.put(EIPConstant.PARAM_MSG_ACCOUNTNO, requestProp.get(EIPConstant.FIELD_CONTACTED_NUMBER));
            properties.put(EIPConstant.PARAM_MSG_POLICY, requestProp.get(EIPConstant.FIELD_POLICY_NO));
            system.debug('value of map properties: '+properties);
            addCustCallNote = EIPConnector.addCustomerCallNote(EIPConstant.OPERATION_INSERT_CALLNOTE, EIPConstant.ENTITY_AMFS, EIPConstant.APP_DMTM_REST_V3, properties);
            system.debug('insert call note success: '+addCustCallNote);
            
            response = addCustCallNote.toStringJson();
            
            if (addCustCallNote.errorMessage != null) message = addCustCallNote.errorMessage;
            if (addCustCallNote.Body.Status == '0' || addCustCallNote.Body.Status == null) message = addCustCallNote.Body.exceptionObj.message;
 
        } catch (Exception e) {
            system.debug('CallLineAssesmentDMTM.sendReqAssesmentTM Error: '+e.getMessage()); 
        }
        
        Map<String, String> logProp = new Map<String, String>();
        logProp.put('ObjectId',requestProp.get(EIPConstant.FIELD_ID));
        logProp.put('Message',message);
        logProp.put('Report','AMFS Collection Robot DMTM');
        logProp.put('CaseType',requestProp.get(EIPConstant.FIELD_CASE_TYPE));
        logProp.put('Request',EIPConnector.getRequestPrettyPrint());
        logProp.put('Response',addCustCallNote.toStringJSON());
        BaseCoreServiceController.insertLog(logProp, startLongTime);        
    }
    
}