public class RetryCallLineAssesmentTM {
    
    public static void retryAssesmentTM(String logId) {
        AppLog__c log = (AppLog__c) SOQL.of(AppLog__c.SObjectType)
            .with('Id, Log_Call_Line__c, Log_Case__c, Request_Value__c, Policy_App__c')
            .whereAre(SOQL.Filter.with(AppLog__c.Id).equal(logId))
            .systemMode()
            .toObject();
        
        EIPJson convertReqJson = (EIPJson) JSON.deserialize(log.Request_Value__c, EIPJson.class);
        system.debug('request value: '+convertReqJson.Body.service);
        Map<String, String> requestProp = new Map<String, String>();
        String operation = convertReqJson.Body.operation;
        EIPJson.EIP_AgSa_InsurancePolicy hasPolicy = convertReqJson.Body.Customer.hasPolicyAccount[0];
        
        if (operation == EIPConstant.OPERATION_INSERT_CALLNOTE) {
            if (log.Log_Call_Line__c != null) {
                requestProp.put(EIPConstant.FIELD_POLICY_NO, hasPolicy.policyNo);
                requestProp.put(EIPConstant.FIELD_CALL_REMARK, hasPolicy.policyRk);
                requestProp.put(EIPConstant.FIELD_CONTACTED_NUMBER, hasPolicy.accountNo);
                requestProp.put(EIPConstant.FIELD_ID_DMTM, hasPolicy.registeredBy);
                requestProp.put(EIPConstant.FIELD_ID, log.Log_Call_Line__c);
                CallLineAssesmentServiceTM.insertCallNote(requestProp);   
            } 
            if (log.Log_Case__c != null) {
                system.debug('case retry');
                requestProp.put(EIPConstant.FIELD_POLICY_NUMBERS, hasPolicy.policyNo);
                requestProp.put(EIPConstant.FIELD_DESCRIPTION, hasPolicy.policyRk);
                requestProp.put(EIPConstant.FIELD_CONTACT_PHONE, hasPolicy.accountNo);
                requestProp.put(EIPConstant.FIELD_COM_NICKNAME, hasPolicy.registeredBy);
                requestProp.put(EIPConstant.FIELD_ID, log.Log_Case__c);
                CustomizeCaseServiceController.requestDMTM(requestProp);                    
            }
        }
        
        if (operation == EIPConstant.OPERATION_GET_CONSERVATION) {
            
            requestProp.put(EIPConstant.FIELD_ACTIVITY_RESULT, hasPolicy.uwTypeCd);
            requestProp.put(EIPConstant.FIELD_REASON_STATUS, hasPolicy.statusReasonCd);
            requestProp.put(EIPConstant.FIELD_CALL_REMARK, hasPolicy.policyRk);
            requestProp.put(EIPConstant.FIELD_CREATED_DATE, hasPolicy.processedDttm);
            requestProp.put(EIPConstant.FIELD_ID, log.Log_Call_Line__c);
            CallLineAssesmentServiceTM.insertConservation(requestProp);
        }
    }
}