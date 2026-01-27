public class CustomizeCaseServiceController{
    
    @future(callout = true)
    public static void sendRequest(String csId){

        Case cs = BaseCoreServiceController.generateCase(csId);
        system.debug('Case: '+cs);
        User usr = BaseCoreServiceController.generateUser(cs.LastModifiedById);
        String policyApp = [SELECT Id, PolicyApp__c FROM Contact WHERE Id = :cs.ContactId LIMIT 1].PolicyApp__c;
        String contactPhone = cs.ContactMobile != null ? cs.ContactMobile.toString() : cs.ContactPhone != null ? cs.ContactPhone.toString() : '';
        
        if (policyApp == 'DMTM') requestDMTM(cs, usr);
        if (policyApp == 'RLS') requestRLS(cs, usr);
    }
    
    public static void requestDMTM(Case cs, User usr) {
        long startLongTime = system.now().getTime();
        String message = '';
        String statusCode = '';
        
        EIPJson requestPolicy = new EIPJson();
        
        try {
            system.debug('===REQUEST API CORRESPONDENCE/INBOUND ROBOT DMTM TO CALLNOTE:');
            Map<String, String> properties = new Map<String, String>();
            properties.put(EIPConstant.PARAM_MSG_POLICY, cs.Policy_Numbers__c);
            properties.put(EIPConstant.PARAM_MSG_POLICYRK, '('+usr.CommunityNickname+') '+DateTime.valueOfGmt(cs.LastModifiedDate.addHours(7).toString()).format()+' '+cs.Description);
            properties.put(EIPConstant.PARAM_MSG_ACCOUNTNO, cs.ContactMobile != null ? cs.ContactMobile.toString() : cs.ContactPhone != null ? cs.ContactPhone.toString() : '');
            properties.put(EIPConstant.PARAM_MSG_REGISTERED, usr.CommunityNickname);
            
            requestPolicy = EIPConnector.addCustomerCallNote(EIPConstant.OPERATION_INSERT_CALLNOTE, EIPConstant.ENTITY_AMFS, EIPConstant.APP_DMTM_REST_V3, properties);
            system.debug('requestPolicy case callnote: '+requestPolicy);
            
            statusCode = requestPolicy.Body.Status;
            if (statusCode == '0') message = requestPolicy.Body.exceptionObj.message;
        } catch (Exception e) {
            System.debug('Error insert case TM to callnote: '+e.getMessage());
            message = e.getMessage();
        }
        
        String reportName = '';
        if (cs.Origin.contains('Phone')) reportName = 'Customize Inbound Robot DMTM';   
        else reportName = 'Customize Correspondence Robot DMTM';
        Map<String, String> logProp = new Map<String, String>();
        logProp.put('ObjectId',cs.Id);
        logProp.put('Message',message);
        logProp.put('Report',reportName);
        logProp.put('CaseType',cs.Case_Type__c);
        logProp.put('Request',EIPConnector.getRequestPrettyPrint());
        logProp.put('Response',requestPolicy.toStringJSON());
        BaseCoreServiceController.insertLog(logProp, startLongTime);
    }
    
    public static void requestRLS(Case cs, User usr) {    
        long startLongTime = system.now().getTime();
        String message = '';
        String statusCode = '';
        
        EIPJson requestAssmt = new EIPJson();
        
        try {
            system.debug('===REQUEST TO API INSERT ASSESSMENT MAINTENANCE RLS:');
            Map<String, String> properties = new Map<String, String>();
        	properties.put(EIPConstant.PARAM_MSG_POLICY, cs.Policy_Numbers__c);
            properties.put(EIPConstant.PARAM_ASSMT_SECTION, 'OTH');
            properties.put(EIPConstant.PARAM_ASSESSOR_DTTM, cs.LastModifiedDate.format('yyyyMMddHHmmss', 'Asia/Jakarta'));
            properties.put(EIPConstant.PARAM_LAST_UPD_DTTM, cs.LastModifiedDate.format('yyyyMMddHHmmss', 'Asia/Jakarta'));
            properties.put(EIPConstant.PARAM_ASSMT_DESC, cs.LastModifiedDate.addHours(7).toString() + ' - ' + usr.CommunityNickname + ' - ' + cs.Description);
            properties.put(EIPConstant.PARAM_ASSESSOR, usr.ID_User_RLS__c);
            
            requestAssmt = EIPConnector.insertAssessmentMaintenance(EIPConstant.OPERATION_INSERT_ASSESMENT, EIPConstant.ENTITY_AMFS, EIPConstant.APP_RLS, properties);
			system.debug('requestAssmt: '+requestAssmt);
            
            statusCode = requestAssmt.Body.Status;
            String errorMessage = 'Failed to insert assessment, please contact Admin';
            if (statusCode != null && statusCode == '0') message = String.isBlank(requestAssmt.Body.exceptionObj.message) || requestAssmt.Body.exceptionObj.message == '' ? errorMessage : requestAssmt.Body.exceptionObj.message;
            
        } catch (Exception e) {
            System.debug('Error insert assessment maintenance RLS: '+e.getMessage());
        }
        
        String reportName = '';
        if (cs.Origin.contains('Phone')) reportName = 'Customize Inbound Robot RLS';
        else reportName = 'Customize Correspondence Robot RLS';
        
        Map<String, String> logProp = new Map<String, String>();
        logProp.put('ObjectId',cs.Id);
        logProp.put('Message',message);
        logProp.put('Report',reportName);
        logProp.put('CaseType',cs.Case_Type__c);
        logProp.put('Request',EIPConnector.getRequestPrettyPrint());
        logProp.put('Response',requestAssmt.toStringJSON());
        BaseCoreServiceController.insertLog(logProp, startLongTime);
                  
    }
    
}