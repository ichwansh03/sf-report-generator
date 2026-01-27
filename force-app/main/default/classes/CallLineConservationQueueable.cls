public class CallLineConservationQueueable implements Queueable, Database.AllowsCallouts{
    
    public Map<String, String> prop;
    
    public CallLineConservationQueueable(Map<String, String> prop) {
        this.prop = prop;
    }
    
    public void execute(QueueableContext qc) {
        long startLongTime = system.now().getTime();
        String message = '', response, errorMessage = 'Get Conservation: Failed to insert assesment, please contact Admin';
        
        EIPJson requestConserv = new EIPJson();
        
        try {
            requestConserv = EIPConnector.getPolicyDetails(EIPConstant.OPERATION_GET_CONSERVATION, EIPConstant.ENTITY_AMFS, EIPConstant.APP_RLS, prop.get(EIPConstant.FIELD_POLICY_NO));
            
            if (requestConserv != null) {
                if (requestConserv.Body.Status != null && requestConserv.Body.Status == '0') message = String.isBlank(requestConserv.Body.exceptionObj.message) || requestConserv.Body.exceptionObj.message == '' ? errorMessage : requestConserv.Body.exceptionObj.message;
                else validateCoreRemarks(requestConserv, prop);
                
                response = requestConserv.toStringJSON();
            }
            
        } catch (Exception e) {
            system.debug('Call Line Get Conservation Service RLS Error: '+e.getMessage());
            response = e.getMessage();
            message = errorMessage;
        }
        
        Map<String, String> logProp = new Map<String, String>();
        logProp.put('ObjectId', prop.get(EIPConstant.FIELD_ID));
        logProp.put('Message', message);
        logProp.put('Report', 'AMFS Collection Robot RLS');
        logProp.put('CaseType', 'Redemption Konven (Conservation)');
        logProp.put('Request', EIPConnector.getRequestPrettyPrint());
        logProp.put('Response', response);
        BaseCoreServiceController.insertLog(logProp, startLongTime);
    }
    
    private static void validateCoreRemarks(EIPJson requestConserv, Map<String, String> prop) {
        system.debug('request conservation: '+requestConserv);
        String consStatus = requestConserv.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[1].statusReasonCd;
        String prevStatus = requestConserv.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[1].uwTypeCd;
        String uwRemark1 = requestConserv.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[1].hasDetailsOfPolicyIn[0].uwRemark1;
        String uwRemark2 = requestConserv.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[1].hasDetailsOfPolicyIn[0].uwRemark2;
        String uwRemark3 = requestConserv.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[1].hasDetailsOfPolicyIn[0].uwRemark3;

        String reason1 = requestConserv.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[1].hasDetailsOfClaimIn[0].hasClaimDetails[0].reason1;
        String reason2 = requestConserv.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[1].hasDetailsOfClaimIn[0].hasClaimDetails[0].reason2;
        String reason3 = requestConserv.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[1].hasDetailsOfClaimIn[0].hasClaimDetails[0].remarks;
        
        String surCd1 = requestConserv.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[1].hasDetailsOfClaimIn[0].claimStatusCD;
        String surCd2 = requestConserv.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[1].hasDetailsOfClaimIn[0].claimTypeCd;
        String surCd3 = requestConserv.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[1].hasDetailsOfClaimIn[0].remarks;
        
        prop.put('Cons_Status', consStatus);
        prop.put('Prev_Status', prevStatus);
        
        List<String> uwRemarks = cascade(new List<String> {uwRemark1, uwRemark2, uwRemark3}, prop.get('UW_Remark__c'));
        system.debug('uwRemark list: '+uwRemarks);
        prop.put('Uw_Remark1', uwRemarks[0]);
        prop.put('Uw_Remark2', uwRemarks[1]);
        prop.put('Uw_Remark3', uwRemarks[2]);
        
        List<String> reasons = cascade(new List<String> {reason1, reason2, reason3}, surrenderCodeMap(prop.get('Reason_Status_Config__c')).split(';')[1]);
        system.debug('reasons list: '+reasons);
        prop.put('Reason1', reasons[0]);
        prop.put('Reason2', reasons[1]);
        prop.put('Reason3', reasons[2]);
        
        List<String> codes = cascade(new List<String> {surCd1, surCd2, surCd3}, surrenderCodeMap(prop.get('Reason_Status_Config__c')).split(';')[0]);
        system.debug('codes list: '+codes);
        prop.put('Status1', codes[0]);
        prop.put('Status2', codes[1]);
        prop.put('Status3', codes[2]);
        
        System.enqueueJob(new CallLineMaintenanceQueueable(prop));
        
    }
    
    private static List<String> cascade(List<String> values, String newValue){
        if (String.isBlank(values[0])) values[0] = newValue;
        else if (String.isBlank(values[1])) values[1] = newValue;
        else if (String.isBlank(values[2])) values[2] = newValue;
        else values[2] = newValue;
        return values;
    }
    
    private static String surrenderCodeMap(String reasonStatus) {
        Map<String, SurCode_Mapping__c> surcodeValue = new Map<String, SurCode_Mapping__c>();
        Map<String, SurCode_Mapping__c> surcodeName = new Map<String, SurCode_Mapping__c>();
        for (SurCode_Mapping__c code : SurCode_Mapping__c.getAll().values()) {
            surcodeValue.put(code.Value__c, code);
            surcodeName.put(code.Name, code);
        }
        String surrenderName = surcodeName.get(reasonStatus.replaceAll('[\\s\\u00A0]+', ''))?.Value__c ?? 'UNCONTACTED (BUSY,ON THE LINE, ETC)';
        String surrenderValue = surcodeValue.get(surrenderName)?.Name ?? 'UNCO';
        system.debug(surrenderValue+'+'+surrenderName);
        
        return surrenderValue+';'+surrenderName;
    }
}