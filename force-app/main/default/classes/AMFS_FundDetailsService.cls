/**
 * @description       : 
 * @author            : Muh Syafiq Hidayatullah
 * @group             : 
 * @last modified on  : 22-09-2025
 * @last modified by  : Muh Syafiq Hidayatullah
**/
public without sharing class AMFS_FundDetailsService {
    @TestVisible private static Boolean throwEx = false;
    private static final String HASH_MD5 = 'MD5';
    private static final String DATE_FORMAT_YYYYMMDD_HHMMSS_SSS = 'yyyy-MM-dd HH:mm:ss.SSS';
    private static final String DATE_FORMAT_YYYYMMDD = 'yyyyMMdd';

    @InvocableMethod(label='getFundDetails')
    public static List<OutputData> getFundDetails(List<InputData> inputs) {
        List<OutputData> responses = new List<OutputData>();
        List<String> lbadIds = new List<String>();
        List<String> fundCode = new List<String>();
        List<Boolean> lastCallouts = new List<Boolean>();
        for(InputData input : inputs){
            lbadIds.add(input.logBookActivityDetailId);
            lastCallouts.add(input.isLastCallout);
            fundCode.add(input.fundCode);
        }
        Log_Book_Activitiy_Detail__c lbad = [SELECT Id, Name, Policy_Number__c, Log_Case__r.Id, Contact_Policy__r.PolicyApp__c, Contact_Policy__r.Entity__c, Contact_Policy__r.Policy_No__c FROM Log_Book_Activitiy_Detail__c WHERE ID = : lbadIds LIMIT 1];
        String appId = lbad.Contact_Policy__r.PolicyApp__c;
        String policyNumber = lbad.Contact_Policy__r.Policy_No__c;
        String entity = lbad.Contact_Policy__r.Entity__c;
        String caseId = lbad.Log_Case__r.Id;
        responses.add(buildAPI(policyNumber, appId, entity, caseId, fundCode[0]));
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
    
    public static OutputData buildAPI(String policyNumber, String appId, String entity, String caseId, String fundCode){
        OutputData output = new OutputData();
        Long startLongTime;
        if(UserInfo.getUserType() == 'Guest'){
            startLongTime = System.now().addHours(7).getTime();
        }else {
            startLongTime = System.now().getTime();
        }
        try {
            AMFS_Service_API__mdt config = AMFS_ServiceAPI.getIntegrationSettings('Fund_Detail_Service');
            String jsonBody = AMFS_FundDetailsService.buildRequestBody(appId, policyNumber, entity, config);
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
                return successResponse(Response.responseBody, fundCode);
            } else {
                AMFS_ServiceAPI.logTransaction(Response);
                return errorResponse(Response.requestBody);
            }
        } catch (Exception e) {
            System.debug('Exception in buildAPI: ' + e.getMessage());
        }
        return output;
    }

    public static OutputData successResponse(String responseBody, String fundCode){
        OutputData output = new OutputData();
        List<String> investmentFundCds = new List<String>();
        List<Double> fundAllocations = new List<Double>();
        List<Double> totalFundAmount = new List<Double>();
        List<String> descFund = new List<String>();

        Integer targetSize = 4;
        Integer sisa = 0;
        try {
            FundDetailResponseWrapper fullResponse = (FundDetailResponseWrapper) JSON.deserialize(responseBody, FundDetailResponseWrapper.class);
            if (fullResponse != null && fullResponse.Body != null && fullResponse.Body.Policy != null && fullResponse.Body.Policy.hasAccountDetailsIn != null) {
                for (AccountDetailWrapper account : fullResponse.Body.Policy.hasAccountDetailsIn) {
                    if (account != null && account.hasInvestmentFundDetailsIn != null) {
                        for (InvestmentFundDetailsInWrapper invest : account.hasInvestmentFundDetailsIn) {
                            if (invest != null) {
                                
                                investmentFundCds.add(invest.investmentFundCd != null ? safeToString(invest.investmentFundCd).trim() : '');

                                String tempFundAllocation = invest.fundAllocation != null ? safeToString(invest.fundAllocation).trim() : null;
                                fundAllocations.add(tempFundAllocation != null ? safeToDouble(tempFundAllocation) : null);
                                
                                String total = invest.totalFundAmount != null  ? safeToString(invest.totalFundAmount).trim() : null;
                                totalFundAmount.add(total != null ? safeToDouble(total) : null);
                            }
                        }
                    }
                }
            }
            system.debug(investmentFundCds);
            system.debug(fundAllocations);
            system.debug(totalFundAmount);
            if(!investmentFundCds.isEmpty()){
                List<Master_Fund_Code__c> nameFund = [SELECT Id, Name, Desc_Fun_Code__c, Plan_Code__c FROM Master_Fund_Code__c WHERE Plan_Code__c = : fundCode AND Name IN : investmentFundCds ORDER BY Plan_Code__c ASC];
                Map<String, Master_Fund_Code__c> fundMap = new Map<String, Master_Fund_Code__c>();
                for (Master_Fund_Code__c mfc : nameFund) {
                    fundMap.put(mfc.Name, mfc);
                }
                for (String fundCd : investmentFundCds) {
                    if (fundMap.containsKey(fundCd)) {
                        String descName = fundMap.get(fundCd).Desc_Fun_Code__c;
                        descFund.add(String.isBlank(descName) ? '-' :descName.trim());
                    } else {
                        descFund.add('-');
                    }
                }
                for (Integer i = 0; i < Math.min(investmentFundCds.size(), 4); i++){
                    if (i == 0) {
                        output.investmentFundCd0 = String.isNotBlank(investmentFundCds[i]) ? investmentFundCds[i] : '-';
                        output.fundAllocation0 = fundAllocations[i];
                        if(investmentFundCds[i] != ''){
                            output.subdana0 = investmentFundCds[i]+' - '+descFund[i];
                        }else {
                            output.subdana0 = '-';
                        }
                        output.descFund0 = descFund[i];
                        
                    } else if (i == 1) {
                        output.investmentFundCd1 =String.isNotBlank(investmentFundCds[i]) ? investmentFundCds[i] : '-';
                        output.fundAllocation1 = fundAllocations[i];
                        if(investmentFundCds[i] != ''){
                            output.subdana1 = investmentFundCds[i]+' - '+descFund[i];
                        }else {
                            output.subdana1 = '-';
                        }
                        output.descFund1 = descFund[i];
                    } else if (i == 2) {
                        output.investmentFundCd2 = String.isNotBlank(investmentFundCds[i]) ? investmentFundCds[i] : '-';
                        output.fundAllocation2 = fundAllocations[i];
                        if(investmentFundCds[i] != ''){
                            output.subdana2 = investmentFundCds[i]+' - '+descFund[i];
                        }else {
                            output.subdana2 = '-';
                        }
                        output.descFund2 = descFund[i];
                    } else if (i == 3) {
                        output.investmentFundCd3 = String.isNotBlank(investmentFundCds[i]) ? investmentFundCds[i] : '-';
                        output.fundAllocation3 = fundAllocations[i];
                        if(investmentFundCds[i] != ''){
                            output.subdana3 = investmentFundCds[i]+' - '+descFund[i];
                        }else {
                            output.subdana3 = '-';
                        }
                        output.descFund3 = descFund[i];
                    }
                }
                output.totalFundAmount = totalFundAmount[0];
            }
            system.debug(output.totalFundAmount);
            system.debug(output.investmentFundCd0);
            system.debug(output.investmentFundCd1);
            system.debug(output.investmentFundCd2);
            system.debug(output.investmentFundCd3);
            system.debug(output.fundAllocation0);
            system.debug(output.fundAllocation1);
            system.debug(output.fundAllocation2);
            system.debug(output.fundAllocation3);
            system.debug(output.subdana0);
            system.debug(output.subdana1);
            system.debug(output.subdana2);
            system.debug(output.subdana3);
            system.debug(output.descFund0);
            system.debug(output.descFund1);
            system.debug(output.descFund2);
            system.debug(output.descFund3);
            
            if((String.isNotBlank(String.valueOf(output.totalFundAmount)) &&
                String.isNotBlank(output.investmentFundCd0) &&
                String.isNotBlank(output.investmentFundCd1) &&
                String.isNotBlank(output.investmentFundCd2) &&
                String.isNotBlank(output.investmentFundCd3) &&
                String.isNotBlank(String.valueOf(output.fundAllocation0)) &&
                String.isNotBlank(String.valueOf(output.fundAllocation1))&&
                String.isNotBlank(String.valueOf(output.fundAllocation2)) &&
                String.isNotBlank(String.valueOf(output.fundAllocation3)))){
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
        FundDetailRequestWrapper fullReq = new FundDetailRequestWrapper();
        fullReq.Header = new RequestHeader();
        fullReq.Header.SecurityContext = new SecurityContextWrapper();
        fullReq.Header.SecurityContext.username = config.Username__c;
        fullReq.Header.SecurityContext.password = config.Password__c;

        fullReq.Body = new BodyWrapper();
        fullReq.Body.transactionId =generateUID();
        fullReq.Body.operation = 'FUND';
        fullReq.Body.appID = appId;
        fullReq.Body.entity = entity;
        fullReq.Body.service = 'getFundDetail';

        PolicyWrapper policy = new PolicyWrapper();
        policy.policyNO = policeNo;
        fullReq.Body.Policy = policy;
        return JSON.serialize(fullReq);
    }

    // Invocable Input
    public class InputData{
        @InvocableVariable(label = 'Log Book Activity Detail Id' required=true)
        public String logBookActivityDetailId;
        @InvocableVariable(label = 'Fund Code')
        public String fundCode;
        @InvocableVariable(label = 'is last callout on flow?' required=true)
        public Boolean isLastCallout;
    }

    // Invocable Output
    public class OutputData{
        @InvocableVariable(label = 'fundAllocation0')
        public Double fundAllocation0;
        @InvocableVariable(label = 'fundAllocation1')
        public Double fundAllocation1;
        @InvocableVariable(label = 'fundAllocation2')
        public Double fundAllocation2;
        @InvocableVariable(label = 'fundAllocation3')
        public Double fundAllocation3;
        @InvocableVariable(label = 'investmentFundCd0')
        public String investmentFundCd0;
        @InvocableVariable(label = 'investmentFundCd1')
        public String investmentFundCd1;
        @InvocableVariable(label = 'investmentFundCd2')
        public String investmentFundCd2;
        @InvocableVariable(label = 'investmentFundCd3')
        public String investmentFundCd3;
        @InvocableVariable(label = 'subdana0')
        public String subdana0;
        @InvocableVariable(label = 'subdana1')
        public String subdana1;
        @InvocableVariable(label = 'subdana2')
        public String subdana2;
        @InvocableVariable(label = 'subdana3')
        public String subdana3;
        @InvocableVariable(label = 'descFund0')
        public String descFund0;
        @InvocableVariable(label = 'descFund1')
        public String descFund1;
        @InvocableVariable(label = 'descFund2')
        public String descFund2;
        @InvocableVariable(label = 'descFund3')
        public String descFund3;
        @InvocableVariable(label = 'totalFundAmount')
        public Double totalFundAmount;
        @InvocableVariable(label = 'result')
        public Boolean result;
        public String message;
    }

    // Request Wrapper
    public class FundDetailRequestWrapper{
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
        public PolicyWrapper Policy { get; set; }
    }

    public class PolicyWrapper{
        public String policyNO { get; set; }
    }

    // Response Wrapper
    public class FundDetailResponseWrapper{
        public ResponseBody Body {get; set;}
    }

    public class ResponseBody{
        public PolicyResponseWrapper Policy {get; set;}
    }

    public class PolicyResponseWrapper{
        public List<AccountDetailWrapper> hasAccountDetailsIn {get; set;}
    } 
    
    public class AccountDetailWrapper{
        public List<InvestmentFundDetailsInWrapper> hasInvestmentFundDetailsIn {get; set;}
    }

    public class InvestmentFundDetailsInWrapper{
        public String fundAllocation {get; set;}
        public String investmentFundCd {get; set;}
        public String totalFundAmount {get; set;}
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

    private static Double safeToDouble(String val) {
        try {
            return Double.valueOf(val);
        } catch (Exception e) {
            return null; 
        }
    }
}