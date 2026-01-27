/**
 * @description       : 
 * @author            : Muh Syafiq Hidayatullah
 * @group             : 
 * @last modified on  : 22-09-2025
 * @last modified by  : Muh Syafiq Hidayatullah
**/
public without sharing class AMFS_CustomerProfileService {
    @TestVisible private static Boolean throwEx = false;
    private static final String HASH_MD5 = 'MD5';
    private static final String DATE_FORMAT_YYYYMMDD_HHMMSS_SSS = 'yyyy-MM-dd HH:mm:ss.SSS';
    private static final String DATE_FORMAT_YYYYMMDD = 'yyyyMMdd';

    @InvocableMethod(label='getCustomerProfile')
    public static List<OutputData> getCustomerProfile(List<InputData> inputs) {
        List<OutputData> responses = new List<OutputData>();
        List<String> lbadIds = new List<String>();
        List<Boolean> lastCallouts = new List<Boolean>();
        for(InputData input : inputs){
            lbadIds.add(input.logBookActivityDetailId);
            lastCallouts.add(input.isLastCallout);
        }
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE ID = : lbadIds LIMIT 1];
        String policyNumber = lbad.Contact_Policy__r.Policy_No__c;
        String appId = lbad.Contact_Policy__r.PolicyApp__c;
        String entity = lbad.Contact_Policy__r.Entity__c;
        String caseId = lbad.Log_Case__r.Id;
        String appIdEIP;
        if(appId == 'RLS'){
            appIdEIP = EIPConstant.APP_RLS;
            responses.add(buildAPI(policyNumber, appIdEIP, entity, caseId));
        }else {
            appIdEIP = EIPConstant.APP_DMTM;
            responses.add(buildAPI(policyNumber, appIdEIP, entity, caseId));
        }
        if(lastCallouts[0] == true){
            if (!AMFS_ServiceAPI.logList.isEmpty()) {
                try {
                    if(Test.isRunningTest() && throwEx && AMFS_ServiceAPI.logList.size() > 0) {
                        throw new DmlException('Test DML Exception for Coverage');
                    }
                    insert AMFS_ServiceAPI.logList;
                    AMFS_ServiceAPI.logList.clear();
                } catch (DmlException e) {
                    System.debug('#### AMFS listLog Error ' + e.getMessage());
                }
            }
        }
        return responses;
    }

    public static OutputData buildAPI(String policyNumber, String appId, String entity, String caseId){
        OutputData output = new OutputData();
        Long startLongTime;
        if(UserInfo.getUserType() == 'Guest'){
            startLongTime = System.now().addHours(7).getTime();
        }else {
            startLongTime = System.now().getTime();
        }
        try {
            AMFS_Service_API__mdt config = AMFS_ServiceAPI.getIntegrationSettings('Customer_Profile_Service');
            String jsonBody = AMFS_CustomerProfileService.buildRequestBody(appId, policyNumber, entity, config);
            AMFS_ServiceAPI.IntegrationResponse Response = AMFS_ServiceAPI.makeHttpCallout(
                config.Endpoint__c, 
                config.Method__c, 
                jsonBody, 
                AMFS_ServiceAPI.getDefaultHeaders(), 
                Integer.valueOf(config.Timeout__c),
                policyNumber,
                appId,
                entity,
                caseId,
                startLongTime);
            if(Response.statusCode==200){
                AMFS_ServiceAPI.logTransaction(Response);
                if(appId == 'RLS'){
                    return successResponse(Response.responseBody);
                }
                else {
                    return successResponseDMTM(Response.responseBody);
                }
            } else {
                AMFS_ServiceAPI.logTransaction(Response);
                return errorResponse(Response.responseBody);
            }
        } catch (Exception e) {
            System.debug('Exception in buildAPI: ' + e.getMessage());
        }
        return output;
    }

    public static OutputData successResponse(String responseBody){
        OutputData output = new OutputData();
        try {
            CustomerDetailResponseWrapper fullResponse = (CustomerDetailResponseWrapper) JSON.deserialize(responseBody, CustomerDetailResponseWrapper.class);
            if(fullResponse!=null&&fullResponse.Body!=null&&fullResponse.Body.Customer!=null&&fullResponse.Body.Customer.canBeIndividual!=null){
                output.birthPlace = fullResponse.Body.Customer.canBeIndividual.birthPlace != null ? safeToString(fullResponse.Body.Customer.canBeIndividual.birthPlace).trim() : '';
                output.fullName = fullResponse.Body.Customer.canBeIndividual.fullNM != null ? safeToString(fullResponse.Body.Customer.canBeIndividual.fullNM).trim() : '';
                String birthDateStr = fullResponse.Body.Customer.canBeIndividual.birthDT != null ? safeToString(fullResponse.Body.Customer.canBeIndividual.birthDT).trim() : '';
                String formattedDateStr = String.isNotBlank(birthDateStr) ? birthDateStr.substring(0,4) + '-' + birthDateStr.substring(4,6) + '-' + birthDateStr.substring(6,8) : '';
                Date birthDate = String.isNotBlank(formattedDateStr) ? safeToDate(formattedDateStr) : null;
                output.birthDT = birthDate;
                for(AddressInWrapper addr : fullResponse.Body.Customer.canBeIndividual.hasAddressesIn){
                    if(addr!=null){
                        String addr1 = addr.addressLine1 != null ? safeToString(addr.addressLine1).trim() :'';
                        String addr2 = addr.addressLine2 != null ? safeToString(addr.addressLine2).trim() :'';
                        String addr3 = addr.addressLine3 != null ? safeToString(addr.addressLine3).trim() :'';
                        String addr4 = addr.addressLine4 != null ? safeToString(addr.addressLine4).trim() :'';
                        output.address = (safeToString(addr1).trim() + ' ' + safeToString(addr2).trim() + ' ' + safeToString(addr3).trim() + ' ' + safeToString(addr4).trim()).trim();
                        output.mobilePhoneNO = addr.mobilePhoneNO != null ? safeToString(addr.mobilePhoneNO).trim() : '';
                        output.emailAddress = addr.emailAddress != null ? safeToString(addr.emailAddress).trim() : '';
                    }
                }
                system.debug(output.birthPlace);
                system.debug(output.fullName);
                system.debug(output.birthDT);
                system.debug(output.address);
                system.debug(output.mobilePhoneNO);
                system.debug(output.emailAddress);
                // output.customerID = fullResponse.Body.Customer.customerID.trim();
            }
            if(String.isNotBlank(output.address) && String.isNotBlank(String.valueOf(output.birthDT) )
                && String.isNotBlank(output.birthPlace) && String.isNotBlank(output.fullName) 
                && String.isNotBlank(output.mobilePhoneNO) && String.isNotBlank(output.emailAddress)){
                output.result = true;
            }else {
                output.result = false;
            }
            system.debug(output.result);
        } catch (Exception e) {
            System.debug('Exception in successResponse: ' + e.getMessage());
        }
        return output;
    }
    public static OutputData successResponseDMTM(String responseBody){
        OutputData output = new OutputData();
        try {
            CustomerDetailResponseWrapper fullResponse = (CustomerDetailResponseWrapper) JSON.deserialize(responseBody, CustomerDetailResponseWrapper.class);
            if(fullResponse!=null&&fullResponse.Body!=null&&fullResponse.Body.Customer!=null&&fullResponse.Body.Customer.canBeIndividual!=null){
                output.birthPlace = fullResponse.Body.Customer.canBeIndividual.birthPlace != null ? safeToString(fullResponse.Body.Customer.canBeIndividual.birthPlace).trim() : '';
                output.fullName = fullResponse.Body.Customer.canBeIndividual.fullNM != null ? safeToString(fullResponse.Body.Customer.canBeIndividual.fullNM).trim() : '';
                String birthDateStr = fullResponse.Body.Customer.canBeIndividual.birthDT != null ? safeToString(fullResponse.Body.Customer.canBeIndividual.birthDT).trim() : '';
                String formattedDateStr = String.isNotBlank(birthDateStr) ? birthDateStr.substring(0,4) + '-' + birthDateStr.substring(4,6) + '-' + birthDateStr.substring(6,8) : '';
                Date birthDate = String.isNotBlank(formattedDateStr) ? safeToDate(formattedDateStr) : null;
                output.birthDT = birthDate;
                for(AddressInWrapper addr : fullResponse.Body.Customer.canBeIndividual.hasAddressesIn){
                    if(addr!=null){
                        String addr1 = addr.addressLine1 != null ? safeToString(addr.addressLine1).trim() :'';
                        String addr2 = addr.addressLine2 != null ? safeToString(addr.addressLine2).trim() :'';
                        String addr3 = addr.addressLine3 != null ? safeToString(addr.addressLine3).trim() :'';
                        String addr4 = addr.addressLine4 != null ? safeToString(addr.addressLine4).trim() :'';
                        output.address = (safeToString(addr1).trim() + ' ' + safeToString(addr2).trim() + ' ' + safeToString(addr3).trim() + ' ' + safeToString(addr4).trim()).trim();
                        output.mobilePhoneNO = addr.mobilePhoneNO != null ? safeToString(addr.mobilePhoneNO).trim() : '';
                        output.emailAddress = addr.emailAddress != null ? safeToString(addr.emailAddress).trim() : '';
                    }
                }
                system.debug(output.birthPlace);
                system.debug(output.fullName);
                system.debug(output.birthDT);
                system.debug(output.address);
                system.debug(output.mobilePhoneNO);
                system.debug(output.emailAddress);
                // output.customerID = fullResponse.Body.Customer.customerID.trim();
            }
            if(String.isNotBlank(output.address) && String.isNotBlank(String.valueOf(output.birthDT) )
                && String.isNotBlank(output.birthPlace) && String.isNotBlank(output.fullName) 
                && String.isNotBlank(output.mobilePhoneNO) && String.isNotBlank(output.emailAddress)){
                output.result = true;
            }else {
                output.result = false;
            }
            system.debug(output.result);
        } catch (Exception e) {
            System.debug('Exception in successResponse: ' + e.getMessage());
        }
        return output;
    }

    public static OutputData errorResponse(String responseBody){
        OutputData output = new OutputData();
        output.message = 'Error Integration';
        output.result = false;
        return output;
    }

    // Build Request
    public static String buildRequestBody(String appId, String policeNo, String entity, AMFS_Service_API__mdt config) {
        CustomerProfileRequestWrapper fullReq = new CustomerProfileRequestWrapper();
        if(appId == 'RLS'){
            fullReq.Header = new RequestHeader();
            fullReq.Header.SecurityContext = new SecurityContextWrapper();
            fullReq.Header.SecurityContext.username = config.Username__c;
            fullReq.Header.SecurityContext.password = config.Password__c;
            fullReq.Body = new BodyWrapper();
            fullReq.Body.transactionId = generateUID();
            fullReq.Body.operation = 'Customer Profile';
            fullReq.Body.appID = appId;
            fullReq.Body.entity = entity;
            fullReq.Body.service = 'getCustomerInfo';
            PoliceAccountWrapper policy = new PoliceAccountWrapper();
            policy.policyNO = policeNo;
            fullReq.Body.Customer = new CustomerWrapper();
            fullReq.Body.Customer.hasPolicyAccount  = new List<PoliceAccountWrapper>{ policy };
        }else {
            fullReq.Header = new RequestHeader();
            fullReq.Header.SecurityContext = new SecurityContextWrapper();
            fullReq.Header.SecurityContext.username = config.Username__c;
            fullReq.Header.SecurityContext.password = config.Password__c;
            fullReq.Body = new BodyWrapper();
            fullReq.Body.transactionId = generateUID();
            fullReq.Body.operation = 'Customer Profile';
            fullReq.Body.appID = appId;
            fullReq.Body.entity = entity;
            fullReq.Body.service = 'getCustomerInfo';
            PoliceAccountWrapper policy = new PoliceAccountWrapper();
            policy.policyNO = policeNo;
            fullReq.Body.Customer = new CustomerWrapper();
            fullReq.Body.Customer.hasPolicyAccount  = new List<PoliceAccountWrapper>{ policy };
            
        }
        return JSON.serialize(fullReq);
    }

    // Invocable Input
    public class InputData{
        @InvocableVariable(label = 'Log Book Activity Detail Id' required=true)
        public String logBookActivityDetailId;
        @InvocableVariable(label = 'is last callout on flow?' required=true)
        public Boolean isLastCallout;
    }

    // Invocable Output
    public class OutputData{
        @InvocableVariable(label =  'Birth Place')
        public String birthPlace;
        @InvocableVariable(label =  'Birth Date')
        public Date birthDT;
        @InvocableVariable(label =  'Full Name')
        public String fullName;
        @InvocableVariable(label =  'Address')
        public String address;
        @InvocableVariable(label = 'result')
        public Boolean result;
        @InvocableVariable(label =  'Phone')
        public String mobilePhoneNO;
        @InvocableVariable(label =  'Email')
        public String emailAddress;
        // @InvocableVariable(label =  'No KTP')
        // public String customerID;
        public String message;
    }

    // Request Wrapper
    public class CustomerProfileRequestWrapper{
        public RequestHeader Header { get; set; }
        public BodyWrapper Body { get; set; }
    }

    public class RequestHeader {
        public SecurityContextWrapper SecurityContext { get; set; }
    }

    public class SecurityContextWrapper{
        public String username { get; set; }
        public String password { get; set; }
    }

    public class BodyWrapper{
        public String transactionId { get; set; }
        public String operation { get; set; }
        public String appID { get; set; }
        public String entity { get; set; }
        public String service { get; set; }
        public CustomerWrapper Customer { get; set; }
    }

    public class CustomerWrapper{
        public List<PoliceAccountWrapper> hasPolicyAccount { get; set; }
    }

    public class PoliceAccountWrapper{
        public String policyNO { get; set; }
    }

    // Response Wrapper
    public class CustomerDetailResponseWrapper{
        public ResponseBody Body {get; set;}
    }

    public class ResponseBody{
        public CustomerResponseWrapper Customer {get; set;}
    }

    public class CustomerResponseWrapper{
        // public String customerID {get; set;}
        public BeIndividual canBeIndividual {get; set;}
    }

    public class BeIndividual{
        public String birthPlace {get; set;}
        public String birthDT {get; set;}
        public String fullNM {get; set;}
        public List<AddressInWrapper> hasAddressesIn {get; set;}
    }
    
    public class AddressInWrapper{
        public String addressLine1 {get; set;}
        public String addressLine2 {get; set;}
        public String addressLine3 {get; set;}
        public String addressLine4 {get; set;}
        public String mobilePhoneNO {get; set;}
        public String emailAddress {get; set;}
    }

    private static String generateUID() {
        String hashString = '1000' + String.valueOf(Datetime.now().formatGMT(DATE_FORMAT_YYYYMMDD_HHMMSS_SSS));
        Blob hash = Crypto.generateDigest(HASH_MD5, Blob.valueOf(hashString));
        String hexDigest = EncodingUtil.convertToHex(hash);
        system.debug('##########' + hexDigest );
        return  UserInfo.getUserId() +'-' + Datetime.now().format(DATE_FORMAT_YYYYMMDD) +'-'+ hexDigest;
    }

    private static String safeToString(String val) {
        return String.valueOf(val);
    }

    private static Date safeToDate(String val) {
        try {
            return Date.valueOf(val);
        } catch (Exception e) {
            return null; 
        }
    }
}