/**
 * @description       : 
 * @author            : Muh Syafiq Hidayatullah
 * @group             : 
 * @last modified on  : 22-09-2025
 * @last modified by  : Muh Syafiq Hidayatullah
**/
public without sharing class AMFS_PolicyDetailsService {
    @TestVisible private static Boolean throwEx = false;
    private static final String HASH_MD5 = 'MD5';
    private static final String DATE_FORMAT_YYYYMMDD_HHMMSS_SSS = 'yyyy-MM-dd HH:mm:ss.SSS';
    private static final String DATE_FORMAT_YYYYMMDD = 'yyyyMMdd';

    @InvocableMethod(label='getPolicyDetails')
    public static List<OutputData> getPolicyDetails(List<InputData> inputs) {
        List<OutputData> responses = new List<OutputData>();
        List<String> lbadIds = new List<String>();
        List<Boolean> lastCallouts = new List<Boolean>();
        for(InputData input : inputs){
            lbadIds.add(input.logBookActivityDetailId);
            lastCallouts.add(input.isLastCallout);
        }
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name,Log_Case__r.Id, Policy_Number__c, Contact_Policy__r.PolicyApp__c,Contact_Policy__r.Entity__c,Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE ID = : lbadIds LIMIT 1];
        String policyNumber = lbad.Contact_Policy__r.Policy_No__c;
        String appId = lbad.Contact_Policy__r.PolicyApp__c;
        String entity = lbad.Contact_Policy__r.Entity__c;
        String caseId = lbad.Log_Case__r.Id;
        String appIdEIP;
        if(appId == 'RLS'){
            appIdEIP = EIPConstant.APP_RLS;
            responses.add(buildAPI(policyNumber, appIdEIP, entity, caseId));
        }else {
            appIdEIP = EIPConstant.APP_DMTM_REST_V3;
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
            AMFS_Service_API__mdt config = AMFS_ServiceAPI.getIntegrationSettings('Policy_Detail_Service');
            String jsonBody = AMFS_PolicyDetailsService.buildRequestBody(appId, policyNumber, entity, config);
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
            PolicyDetailResponseWrapper fullResponse = (PolicyDetailResponseWrapper) JSON.deserialize(responseBody, PolicyDetailResponseWrapper.class);
            
            if (fullResponse != null && fullResponse.Body != null &&  fullResponse.Body.Customer != null && fullResponse.Body.Customer.canBeIndividual != null) {
                output.socialSecurityNOKTP = fullResponse.Body.Customer.canBeIndividual.socialSecurityNO != null ? safeToString(fullResponse.Body.Customer.canBeIndividual.socialSecurityNO).trim() : '';
            }
            if (fullResponse != null && fullResponse.Body != null &&  fullResponse.Body.Customer != null && fullResponse.Body.Customer.hasPolicyAccount != null) {
                for (PolicyAccountResponseWrapper account : fullResponse.Body.Customer.hasPolicyAccount) {
                    String tempDownPayment = account.downPaymentPct != null ? safeToString(account.downPaymentPct).trim() : null;
                    output.downPaymentPct = tempDownPayment != null ? safeToDouble(tempDownPayment) : null;
                    String tempPaymentMethodCD = account.paymentMethodCD != null ? safeToString(account.paymentMethodCD).trim() : null;
                    output.paymentMethodCD = tempPaymentMethodCD != null ? safeToString(tempPaymentMethodCD) : null;
                    
                    for(HasDetailsOfRisksInResponseWrapper detRisk : account.hasDetailsOfRisksIn){
                                if(detRisk != null){
                                    String insuredID = detRisk.insuredID != null ? safeToString(detRisk.insuredID).trim() : '';
                                    output.insuredID = insuredID;
                                    for(HasPersonalDetailsInResponseWrapper per: detRisk.hasPersonalDetailsIn){
                                        if(per != null){
                                            String insuredBirthPlace = per.birthPlace != null ? safeToString(per.birthPlace).trim() : '';
                                            String birthDateStr = per.birthDT != null ? safeToString(per.birthDT).trim() : '';
                                            String formattedDateStr = String.isNotBlank(birthDateStr) ? birthDateStr.substring(0,4) + '-' + birthDateStr.substring(4,6) + '-' + birthDateStr.substring(6,8) : '';
                                            Date insuredbirthDT = String.isNotBlank(formattedDateStr) ? safeToDate(formattedDateStr) : null;

                                            String insuredGenderCD = per.genderCD != null ? safeToString(per.genderCD).trim() : '';
                                            output.insuredgenderCD = insuredGenderCD;
                                            String insuredFirstNM = per.firstNM != null ? safeToString(per.firstNM).trim() : '';
                                            String insuredLastNM = per.lastNM != null ? safeToString(per.lastNM).trim() : '';
                                            for(HasAddressesInResponseWrapper addr : per.hasAddressesIn){
                                                if(per != null){
                                                    String insuredEmail = addr.emailAddress != null ? safeToString(addr.emailAddress).trim() : '';
                                                    output.insuredEmailAddress = insuredEmail;
                                                    String insuredMobilePhoneNO = addr.mobilePhoneNO != null ? safeToString(addr.mobilePhoneNO).trim() : '';
                                                    output.insuredMobilePhoneNO = insuredMobilePhoneNO;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                }
            }
            system.debug(output.socialSecurityNOKTP);
            system.debug(output.downPaymentPct);
            system.debug(output.insuredGenderCD);
            if(String.isNotBlank(output.socialSecurityNOKTP) && 
            String.isNotBlank(String.valueOf(output.downPaymentPct))){
                output.result = true;
            }else {
                output.result = false;
            }
            system.debug(output.result);
        } catch (Exception e) {
            System.debug('Exception in successResponse: ' + e.getMessage());
            system.debug(e.getStackTraceString());
        }
        return output;
    }
    public static OutputData successResponseDMTM(String responseBody){
        OutputData output = new OutputData();
        try {
            PolicyDetailResponseWrapper fullResponse = (PolicyDetailResponseWrapper) JSON.deserialize(responseBody, PolicyDetailResponseWrapper.class);
            
            if (fullResponse != null && fullResponse.Body != null &&  fullResponse.Body.Customer != null && fullResponse.Body.Customer.canBeIndividual != null) {
                output.socialSecurityNOKTP = fullResponse.Body.Customer.canBeIndividual.socialSecurityNO != null ? safeToString(fullResponse.Body.Customer.canBeIndividual.socialSecurityNO).trim() : '';
            }
            if (fullResponse != null && fullResponse.Body != null &&  fullResponse.Body.Customer != null && fullResponse.Body.Customer.hasPolicyAccount != null) {
                for (PolicyAccountResponseWrapper account : fullResponse.Body.Customer.hasPolicyAccount) {
                    String tempDownPayment = account.downPaymentPct != null ? safeToString(account.downPaymentPct).trim() : null;
                    output.downPaymentPct = tempDownPayment != null ? safeToDouble(tempDownPayment) : null;
                    String tempPaymentMethodCD = account.paymentMethodCD != null ? safeToString(account.paymentMethodCD).trim() : null;
                    output.paymentMethodCD = tempPaymentMethodCD != null ? safeToString(tempPaymentMethodCD) : null;
                    String tempPaymentModeCD = account.paymentModeCD != null ? safeToString(account.paymentModeCD).trim() : null;
                    output.paymentModeCD = tempPaymentModeCD != null ? safeToString(tempPaymentModeCD) : null;
                    for(HasDetailsOfRisksInResponseWrapper detRisk : account.hasDetailsOfRisksIn){
                                if(detRisk != null){
                                    String insuredID = detRisk.insuredID != null ? safeToString(detRisk.insuredID).trim() : '';
                                    output.insuredID = insuredID;
                                    for(HasPersonalDetailsInResponseWrapper per: detRisk.hasPersonalDetailsIn){
                                        if(per != null){
                                            String insuredBirthPlace = per.birthPlace != null ? safeToString(per.birthPlace).trim() : '';
                                            String birthDateStr = per.birthDT != null ? safeToString(per.birthDT).trim() : '';
                                            String formattedDateStr = String.isNotBlank(birthDateStr) ? birthDateStr.substring(0,4) + '-' + birthDateStr.substring(4,6) + '-' + birthDateStr.substring(6,8) : '';
                                            Date insuredbirthDT = String.isNotBlank(formattedDateStr) ? safeToDate(formattedDateStr) : null;

                                            String insuredGenderCD = per.genderCD != null ? safeToString(per.genderCD).trim() : '';
                                            output.insuredgenderCD = insuredGenderCD;
                                            String insuredFirstNM = per.firstNM != null ? safeToString(per.firstNM).trim() : '';
                                            String insuredLastNM = per.lastNM != null ? safeToString(per.lastNM).trim() : '';
                                            for(HasAddressesInResponseWrapper addr : per.hasAddressesIn){
                                                if(per != null){
                                                    String insuredEmail = addr.emailAddress != null ? safeToString(addr.emailAddress).trim() : '';
                                                    output.insuredEmailAddress = insuredEmail;
                                                    String insuredMobilePhoneNO = addr.mobilePhoneNO != null ? safeToString(addr.mobilePhoneNO).trim() : '';
                                                    output.insuredMobilePhoneNO = insuredMobilePhoneNO;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                }
            }
            system.debug(output.socialSecurityNOKTP);
            system.debug(output.downPaymentPct);
            system.debug(output.insuredGenderCD);
            if(String.isNotBlank(output.socialSecurityNOKTP) && 
            String.isNotBlank(String.valueOf(output.downPaymentPct))){
                output.result = true;
            }else {
                output.result = false;
            }
            system.debug(output.result);
        } catch (Exception e) {
            System.debug('Exception in successResponse: ' + e.getMessage());
            system.debug(e.getStackTraceString());
        }
        return output;
    }

    public static OutputData errorResponse(String responseBody){
        OutputData output = new OutputData();
        output.message = 'Error Integration';
        output.result = false;
        // output.planCd = 'HONMEP';
        return output;
    }

    // Build Request
    public static String buildRequestBody(String appId, String policeNo, String entity, AMFS_Service_API__mdt config) {
        PolicyDetailRequestWrapper fullReq = new PolicyDetailRequestWrapper();
        if(appId == 'RLS'){
            fullReq.Header = new RequestHeader();
            fullReq.Header.SecurityContext = new SecurityContextWrapper();
            fullReq.Header.SecurityContext.username = config.Username__c;
            fullReq.Header.SecurityContext.password = config.Password__c;
            fullReq.Body = new BodyWrapper();
            fullReq.Body.transactionId = generateUID();
            fullReq.Body.operation = 'policy DETAILs';
            fullReq.Body.appID = appId;
            fullReq.Body.entity = entity;
            fullReq.Body.service = 'getPolicyDetails';
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
            fullReq.Body.operation = 'policy details';
            fullReq.Body.appID = appId;
            fullReq.Body.entity = entity;
            fullReq.Body.service = 'getPolicyDetails';
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
        // @InvocableVariable(label =  'Insurance Product Name')
        // public String insuranceProductRk;
        @InvocableVariable(label =  'Insured Gender')
        public String insuredgenderCD;
        @InvocableVariable(label =  'Insured obilePhoneNO')
        public String insuredMobilePhoneNO;
        @InvocableVariable(label =  'Insured emailAddress')
        public String insuredEmailAddress;
        @InvocableVariable(label =  'KTP')
        public String socialSecurityNOKTP;
        @InvocableVariable(label =  'Biaya Transaksi')
        public Double downPaymentPct;
        @InvocableVariable(label = 'result')
        public Boolean result;
        @InvocableVariable(label =  'Insured insuredID')
        public String insuredID;
        @InvocableVariable(label =  'Payment Method CD(SKDR/DKK)')
        public String paymentMethodCD;
        @InvocableVariable(label =  'Payment Mode CD(SKDR/DKK)')
        public String paymentModeCD;
        public String message;
    }

    // Request Wrapper
    public class PolicyDetailRequestWrapper{
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
    public class PolicyDetailResponseWrapper{
        public ResponseBody Body {get; set;}
    }

    public class ResponseBody{
        public CustomerResponseWrapper Customer {get; set;}
    }
    
    public class CustomerResponseWrapper{
        public List<PolicyAccountResponseWrapper> hasPolicyAccount {get; set;}
        public BeIndividual canBeIndividual {get; set;}
    }

    public class BeIndividual{
        public String socialSecurityNO {get; set;}
    }

    public class PolicyAccountResponseWrapper{
        public String downPaymentPct {get; set;}
        public String paymentMethodCD {get; set;}
        public String paymentModeCD {get; set;}
        public List<HasDetailsOfRisksInResponseWrapper> hasDetailsOfRisksIn {get; set;}
        // public List<AssociatedWithLifeInsuranceProductWrapper> isAssociatedWithLifeInsuranceProduct {get; set;}
    }

    public class HasDetailsOfRisksInResponseWrapper{
        public List<HasPersonalDetailsInResponseWrapper> hasPersonalDetailsIn {get; set;}
        public String insuredID {get; set;}
    }
    
    public class HasPersonalDetailsInResponseWrapper{
        public String birthPlace {get; set;}
        public String birthDT {get; set;}
        public String genderCD {get; set;}
        public String firstNM {get; set;}
        public List<HasAddressesInResponseWrapper> hasAddressesIn {get; set;}
        public String lastNM {get; set;}
    }

    public class HasAddressesInResponseWrapper{
        public String mobilePhoneNO {get; set;}
        public String emailAddress {get; set;}
    }

    // public class DetailsOfRisksInWrapper{
    //     public List<PersonalDetailsInWrapper> hasPersonalDetailsIn {get; set;}
    // }
    // public class PersonalDetailsInWrapper{
    //     public String firstNM {get; set;}
    //     public String lastNM {get; set;}
    // }

    // public class AssociatedWithLifeInsuranceProductWrapper{
    //     public String insuranceProductRk {get; set;}
    //     public String planCd {get; set;}
    // }
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

    private static Double safeToDouble(String val) {
        try {
            return Double.valueOf(val);
        } catch (Exception e) {
            return null; 
        }
    }

    private static Date safeToDate(String val) {
        try {
            return Date.valueOf(val);
        } catch (Exception e) {
            return null; 
        }
    }
}