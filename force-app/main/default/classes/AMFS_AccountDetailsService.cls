/**
 * @description       : 
 * @author            : Muh Syafiq Hidayatullah
 * @group             : 
 * @last modified on  : 22-09-2025
 * @last modified by  : Muh Syafiq Hidayatullah
**/
public without sharing class AMFS_AccountDetailsService {
    @TestVisible private static Boolean throwEx = false;
    private static final String HASH_MD5 = 'MD5';
    private static final String DATE_FORMAT_YYYYMMDD_HHMMSS_SSS = 'yyyy-MM-dd HH:mm:ss.SSS';
    private static final String DATE_FORMAT_YYYYMMDD = 'yyyyMMdd';

    @InvocableMethod(label='getAccountDetails')
    public static List<OutputData> getAccountDetails(List<InputData> inputs) {
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
            AMFS_Service_API__mdt config = AMFS_ServiceAPI.getIntegrationSettings('Account_Detail_Service');
            String jsonBody = AMFS_AccountDetailsService.buildRequestBody(appId, policyNumber, entity, config);
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
        List<String> listNomorRekening = new List<String>();
        List<String> listNamaRekening = new List<String>();
        List<String> listNamaBank = new List<String>();
        List<String> accountTypeCD = new List<String>();
        List<String> accountBankCD = new List<String>();


        List<String> listNomorRekeningCC = new List<String>();
        List<String> listNamaRekeningCC = new List<String>();
        List<String> listNamaBankCC = new List<String>();
        List<String> accountTypeCDCC = new List<String>();
        List<String> accountBankCDCC = new List<String>();

        List<String> listNomorRekeningCD = new List<String>();
        List<String> listNamaRekeningCD = new List<String>();
        List<String> listNamaBankCD = new List<String>();
        List<String> accountTypeCDCD = new List<String>();

        try {
            CustomerDetailResponseWrapper fullResponse = (CustomerDetailResponseWrapper) JSON.deserialize(responseBody, CustomerDetailResponseWrapper.class);
            if(fullResponse!=null&&fullResponse.Body!=null&&fullResponse.Body.Customer!=null&&fullResponse.Body.Customer.hasPolicyAccount!=null){
                for(PolicyAccountWrapper polAcc : fullResponse.Body.Customer.hasPolicyAccount){
                    if(polAcc.hasPartyDetailsIn!=null&&polAcc!=null){
                        for(PartyDetailsWrapper partyDetail:polAcc.hasPartyDetailsIn){
                            if(partyDetail!=null&&partyDetail.canBeIndividual!=null&& partyDetail.canBeIndividual.hasPartyAccountDetailsIn!=null){
                                String tempAccountStatusCD = partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountStatusCD != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountStatusCD).trim() : '';
                                if(tempAccountStatusCD == 'B'){
                                    listNomorRekening.add(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountNO != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountNO).trim() : '');
                                    String firstName = partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM).trim() : '';
                                    String lastName = partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM).trim() : '';
                                    listNamaRekening.add((safeToString(firstName).trim() + ' ' + safeToString(lastName).trim()).trim());
                                    listNamaBank.add(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.bankName != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.bankName).trim() : '');
                                    accountBankCD.add(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountBankCD != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountBankCD).trim() : '');
                                }
                                
                            }
                            if(partyDetail!=null&&partyDetail.canBeIndividual!=null&& partyDetail.canBeIndividual.hasPartyAccountDetailsIn!=null){
                                String tempAccountTypeCD = partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountTypeCD != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountTypeCD).trim() : '';
                                String tempAccountStatusCD = partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountStatusCD != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountStatusCD).trim() : '';
                                if(tempAccountTypeCD == 'CREDITCARD' && tempAccountStatusCD == 'B'){
                                    listNomorRekeningCC.add(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountNO != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountNO).trim() : '');
                                    String firstNameCC = partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM).trim() : '';
                                    String lastNameCC = partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM).trim() : '';
                                    listNamaRekeningCC.add((safeToString(firstNameCC).trim() + ' ' + safeToString(lastNameCC).trim()).trim());
                                    listNamaBankCC.add(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.bankName != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.bankName).trim() : '');
                                    accountTypeCDCC.add(tempAccountTypeCD != null ? safeToString(tempAccountTypeCD).trim() : '');
                                    accountBankCDCC.add(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountBankCD != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountBankCD).trim() : '');

                                }else if (tempAccountTypeCD == 'SAVING' && tempAccountStatusCD == 'B'){
                                    listNomorRekeningCD.add(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountNO != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountNO).trim() : '');
                                    String firstName = partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM).trim() : '';
                                    String lastName = partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM).trim() : '';
                                    listNamaRekeningCD.add((safeToString(firstName).trim() + ' ' + safeToString(lastName).trim()).trim());
                                    listNamaBankCD.add(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.bankName != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.bankName).trim() : '');
                                    accountTypeCDCD.add(tempAccountTypeCD != null ? safeToString(tempAccountTypeCD).trim() : '');
                                }
                            }
                        }
                    }
                }
            }
            output.nomorRekening = !listNomorRekening.isEmpty()  ? safeToString(listNomorRekening[0]).trim() : '';
            output.namaRekening = !listNamaRekening.isEmpty() ? safeToString(listNamaRekening[0]).trim() : '';
            output.namaBank = !listNamaBank.isEmpty() ? safeToString(listNamaBank[0]).trim() : '';
            // output.accountTypeCD = !accountTypeCD.isEmpty() ? safeToString(accountTypeCD[0]).trim() : '';

            output.nomorRekeningCC = !listNomorRekeningCC.isEmpty() ? safeToString(listNomorRekeningCC[0]).trim() : '';
            output.namaRekeningCC = !listNamaRekeningCC.isEmpty() ? safeToString(listNamaRekeningCC[0]).trim() : '';
            output.namaBankCC = !listNamaBankCC.isEmpty() ? safeToString(listNamaBankCC[0]).trim() : '';
            // output.accountTypeCDCC = !accountTypeCDCC.isEmpty() ? safeToString(accountTypeCDCC[0]).trim() : '';

            output.nomorRekeningCD = !listNomorRekeningCD.isEmpty() ? safeToString(listNomorRekeningCD[0]).trim() : '';
            output.namaRekeningCD = !listNamaRekeningCD.isEmpty() ? safeToString(listNamaRekeningCD[0]).trim() : '';
            output.namaBankCD = !listNamaBankCD.isEmpty() ? safeToString(listNamaBankCD[0]).trim() : '';
            // output.accountTypeCDCC = !accountTypeCDCC.isEmpty() ? safeToString(accountTypeCDCC[0]).trim() : '';

            system.debug(output.nomorRekening);
            system.debug(output.namaRekening);
            system.debug(output.namaBank);
            if(String.isNotBlank(output.namaBank) &&
                String.isNotBlank(output.namaRekening)&&
                String.isNotBlank(output.nomorRekening)){
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
        List<String> listNomorRekening = new List<String>();
        List<String> listNamaRekening = new List<String>();
        List<String> listNamaBank = new List<String>();
        List<String> accountTypeCD = new List<String>();
        List<String> accountBankCD = new List<String>();


        List<String> listNomorRekeningCC = new List<String>();
        List<String> listNamaRekeningCC = new List<String>();
        List<String> listNamaBankCC = new List<String>();
        List<String> accountTypeCDCC = new List<String>();
        List<String> accountBankCDCC = new List<String>();

        List<String> listNomorRekeningCD = new List<String>();
        List<String> listNamaRekeningCD = new List<String>();
        List<String> listNamaBankCD = new List<String>();
        List<String> accountTypeCDCD = new List<String>();


        try {
            CustomerDetailResponseWrapper fullResponse = (CustomerDetailResponseWrapper) JSON.deserialize(responseBody, CustomerDetailResponseWrapper.class);
            if(fullResponse!=null&&fullResponse.Body!=null&&fullResponse.Body.Customer!=null&&fullResponse.Body.Customer.hasPolicyAccount!=null){
                for(PolicyAccountWrapper polAcc : fullResponse.Body.Customer.hasPolicyAccount){
                    if(polAcc.hasPartyDetailsIn!=null&&polAcc!=null){
                        for(PartyDetailsWrapper partyDetail:polAcc.hasPartyDetailsIn){
                            if(partyDetail!=null&&partyDetail.canBeIndividual!=null&& partyDetail.canBeIndividual.hasPartyAccountDetailsIn!=null){
                                listNomorRekening.add(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountNO != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountNO).trim() : '');
                                String firstName = partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM).trim() : '';
                                String lastName = partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM).trim() : '';
                                listNamaRekening.add((safeToString(firstName).trim() + ' ' + safeToString(lastName).trim()).trim());
                                listNamaBank.add(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.bankName != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.bankName).trim() : '');
                                accountBankCD.add(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountBankCD != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountBankCD).trim() : '');
                            }
                            if(partyDetail!=null&&partyDetail.canBeIndividual!=null&& partyDetail.canBeIndividual.hasPartyAccountDetailsIn!=null){
                                String tempAccountTypeCD = partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountTypeCD != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountTypeCD).trim() : '';
                                if(tempAccountTypeCD == 'CREDITCARD' || tempAccountTypeCD == 'Credit Card'){
                                    listNomorRekeningCC.add(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountNO != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountNO).trim() : '');
                                    String firstNameCC = partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM).trim() : '';
                                    String lastNameCC = partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM).trim() : '';
                                    listNamaRekeningCC.add((safeToString(firstNameCC).trim() + ' ' + safeToString(lastNameCC).trim()).trim());
                                    listNamaBankCC.add(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.bankName != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.bankName).trim() : '');
                                    accountTypeCDCC.add(tempAccountTypeCD != null ? safeToString(tempAccountTypeCD).trim() : '');
                                    accountBankCDCC.add(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountBankCD != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountBankCD).trim() : '');

                                }else if (tempAccountTypeCD == 'SAVING' || tempAccountTypeCD == 'Saving'){
                                    listNomorRekeningCD.add(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountNO != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.accountNO).trim() : '');
                                    String firstName = partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM).trim() : '';
                                    String lastName = partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM).trim() : '';
                                    listNamaRekeningCD.add((safeToString(firstName).trim() + ' ' + safeToString(lastName).trim()).trim());
                                    listNamaBankCD.add(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.bankName != null ? safeToString(partyDetail.canBeIndividual.hasPartyAccountDetailsIn.bankName).trim() : '');
                                    accountTypeCDCD.add(tempAccountTypeCD != null ? safeToString(tempAccountTypeCD).trim() : '');
                                }
                            }
                        }
                    }
                }
            }
            output.nomorRekening = !listNomorRekening.isEmpty()  ? safeToString(listNomorRekening[0]).trim() : '';
            output.namaRekening = !listNamaRekening.isEmpty() ? safeToString(listNamaRekening[0]).trim() : '';
            output.namaBank = !listNamaBank.isEmpty() ? safeToString(listNamaBank[0]).trim() : '';
            // output.accountTypeCD = !accountTypeCD.isEmpty() ? safeToString(accountTypeCD[0]).trim() : '';

            output.nomorRekeningCC = !listNomorRekeningCC.isEmpty() ? safeToString(listNomorRekeningCC[0]).trim() : '';
            output.namaRekeningCC = !listNamaRekeningCC.isEmpty() ? safeToString(listNamaRekeningCC[0]).trim() : '';
            output.namaBankCC = !listNamaBankCC.isEmpty() ? safeToString(listNamaBankCC[0]).trim() : '';
            // output.accountTypeCDCC = !accountTypeCDCC.isEmpty() ? safeToString(accountTypeCDCC[0]).trim() : '';

            output.nomorRekeningCD = !listNomorRekeningCD.isEmpty() ? safeToString(listNomorRekeningCD[0]).trim() : '';
            output.namaRekeningCD = !listNamaRekeningCD.isEmpty() ? safeToString(listNamaRekeningCD[0]).trim() : '';
            output.namaBankCD = !listNamaBankCD.isEmpty() ? safeToString(listNamaBankCD[0]).trim() : '';
            // output.accountTypeCDCC = !accountTypeCDCC.isEmpty() ? safeToString(accountTypeCDCC[0]).trim() : '';

            system.debug(output.nomorRekening);
            system.debug(output.namaRekening);
            system.debug(output.namaBank);
            if(String.isNotBlank(output.namaBank) &&
                String.isNotBlank(output.namaRekening)&&
                String.isNotBlank(output.nomorRekening)){
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
        return output;
    }

    // Build Request
    public static String buildRequestBody(String appId, String policeNo, String entity, AMFS_Service_API__mdt config) {
        AccountDetailsRequestWrapper fullReq = new AccountDetailsRequestWrapper();
        if(appId == 'RLS'){
            fullReq.Header = new RequestHeader();
            fullReq.Header.SecurityContext = new SecurityContextWrapper();
            fullReq.Header.SecurityContext.username = config.Username__c;
            fullReq.Header.SecurityContext.password = config.Password__c;
            fullReq.Body = new BodyWrapper();
            fullReq.Body.transactionId = generateUID();
            fullReq.Body.operation = 'Account Detail';
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
            fullReq.Body.operation = 'getAccountDetail';
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
        @InvocableVariable(label =  'Nomor Rekening')
        public String nomorRekening;
        @InvocableVariable(label =  'Nomor Rekening CC')
        public String nomorRekeningCC;
        @InvocableVariable(label =  'Nomor Rekening CD')
        public String nomorRekeningCD;
        @InvocableVariable(label =  'Nama Rekening')
        public String namaRekening;
        @InvocableVariable(label =  'Nama Rekening CC')
        public String namaRekeningCC;
        @InvocableVariable(label =  'Nama Rekening CD')
        public String namaRekeningCD;
        @InvocableVariable(label =  'Nama Bank AccountBank')
        public String namaBankAccountBank;
        @InvocableVariable(label =  'Nama Bank')
        public String namaBank;
        @InvocableVariable(label =  'Nama Bank CC')
        public String namaBankCC;
        @InvocableVariable(label =  'Nama Bank CD')
        public String namaBankCD;
        @InvocableVariable(label = 'result')
        public Boolean result;
        public String message;
    }

    // Request Wrapper
    public class AccountDetailsRequestWrapper{
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
        public List<PolicyAccountWrapper> hasPolicyAccount {get; set;}
    }

    public class PolicyAccountWrapper{
        public List<PartyDetailsWrapper> hasPartyDetailsIn {get; set;}
    }

    public class PartyDetailsWrapper{
        public IndividualWrapper canBeIndividual {get; set;}
    }

    public class IndividualWrapper{
        public PartyAccountDetailsInWrapper hasPartyAccountDetailsIn {get; set;}
    }

    public class PartyAccountDetailsInWrapper{
        public String accountNO {get; set;}
        public String payorFirstNM {get; set;}
        public String payorLastNM {get; set;}
        public String bankName {get; set;}
        public String accountTypeCD {get; set;}
        public String accountStatusCD {get; set;}
        public String accountBankCD {get; set;}
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
}