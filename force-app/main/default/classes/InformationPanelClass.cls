public class InformationPanelClass {
    
    public String jsonResponseCustomerInfo {get; set;}
    public String jsonResponsePolicyDetails {get; set;}
    public String jsonResponseAgentInfo {get; set;}
    public String jsonResponseClaimDetails {get; set;}
    
    public String continuation1;
    public String continuation2;
    public String continuation3;
    
    public List<Contact> currentContact {get; set;}
    public List<Case> listOfCase {get;set;}
    public List<Case> listOfCaseGA {get;set;}
    public List<Case> listComplaint {get;set;}
    public List<ICF_Non_CCC__c> nonCccList {get;set;}
    public List<Survey_Response__c> lastResponse {get; set;}
    private String contactId;
    public String policyNo {get; set;}
    public String entity {get; set;}
    public String appId {get; set;}
    public String agentId {get; set;}
    public Boolean isLatestCase {get; set;}
    public String generalAttitude {get; set;}
    public String caseOrigin {get; set;}
    public String lastCase {get; set;}
    public String lastResponseId {get; set;}
    public String answer7verbatim {get; set;}
    
    //--Variable for page
    public String customerInfoGender {get; set;}
    public Date customerInfoBOD {get; set;}
    public Date birthday {get; set;}
    
    public String policyDetailsProductName {get; set;}
    public String policyDetailsPolicyStatus {get; set;}
    public Date policyDetailsEffectiveDate {get; set;}
    public Date policyDetailsDueDate {get; set;}
    public String policyDetailsTotalPremium {get; set;}
    public String policyDetailsEPolicy {get; set;}
    public String policyDetailsPaymentMode {get; set;}
    
    public String agentInfoAgentFirstName {get; set;}
    public String agentInfoAgentLastName {get; set;}
    public String agentInfoAgentNo {get; set;}
    public String agentInfoAgentStatus {get; set;}
    
    public String claimDetailsNumberOfClaim {get; set;}
    public String claimDetailsLastClaimNo {get; set;}
    public String claimDetailsLastClaimStatus1 {get; set;}
    
    
    public InformationPanelClass(ApexPages.StandardController controller) {
        contactId = controller.getId();
        currentContact = [SELECT Id, Name, LastName, Email, Phone, MobilePhone, Entity__c, Policy_No__c, PolicyApp__c, Owner.Agent_ID__c, Last_Case__c FROM Contact WHERE Id = :contactId];
        policyNo = currentContact[0].Policy_No__c;
        entity = currentContact[0].Entity__c;
        appId = currentContact[0].PolicyApp__c;
        lastCase = currentContact[0].Last_Case__c;
        //agentId = currentContact[0].Owner.Agent_ID__c;
        calloutCustomerInfo();
        System.debug('agentId = ' + agentId);
        
        listOfCase = [SELECT Id, Origin, Type, CreatedDate, General_Attitude__c FROM Case WHERE ContactId = :contactId ORDER BY CreatedDate DESC LIMIT 1000];
        listOfCaseGA = [SELECT Id, Origin, Type, CreatedDate, General_Attitude__c FROM Case WHERE ContactId = :contactId AND General_Attitude__c != null ORDER BY CreatedDate DESC LIMIT 1];
        nonCccList = [SELECT Id, Policy_number__c, MOT__c, CreatedDate FROM ICF_Non_CCC__c WHERE Policy_Number__c = :currentContact[0].Policy_No__c ORDER BY CreatedDate DESC];
        listComplaint = [SELECT Id, Type FROM Case WHERE ContactId = :contactId AND Type = 'Complaint' AND Status != 'Closed'];
        lastResponse = [SELECT Id, SurveyTaker__r.Name, SurveyTaker__r.Case__c, Answer_7__c FROM Survey_Response__c WHERE SurveyTaker__r.Case__c = :lastCase];
        
        if(listOfCaseGA.size() > 0) {
            generalAttitude = listOfCaseGA[0].General_Attitude__c;
        }
        
        if(listOfCase.size() > 0) {
            caseOrigin = listOfCase[0].Origin;
        }
        
        if(listOfCase.size() > 0 && nonCccList.size() > 0) {
            if(listOfCase[0].CreatedDate > nonCccList[0].CreatedDate) {isLatestCase = true;} else {isLatestCase = false;}
        } else if(listOfCase.size() > 0 && nonCccList.size() == 0) {
            isLatestCase = true;
        } else if(listOfCase.size() == 0 && nonCccList.size() > 0) {
            isLatestCase = false;
        } else {
            isLatestCase = false;
        }
        
        if(lastResponse.size() > 0) {
            lastResponseId = lastResponse[0].Id;
            answer7verbatim = lastResponse[0].Answer_7__c;
        } else {
            lastResponseId = null;
            answer7verbatim = '';
        }
    }
    
    //--UUID Generator
    private String uuidGenerator() {
        Blob b = Crypto.GenerateAESKey(128);
        String h = EncodingUtil.ConvertTohex(b);
        String uuid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20); 
        return uuid;
    }
    
    //--Json builder for "CustomerInfo"
    public String jsonRequestCustomerInfo() {
        String uuid = uuidGenerator();
        String s = '{"Body":{"service":"getCustomerInfo","transactionId":"'+uuid+'","entity":"'+entity+'","appID":"'+appId+'","operation":"Customer Profile","AXAAsiaPagination_Type":{"startOfRecords":"0","startDateTime":"","rowPerPage":"0","pageNumber":"0","numberOfRecords":"0","endDateTime":""},"IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"'+policyNo+'"}]}},"Header":{"SecurityContext":{"token":"Dummytoken-1234DMTM","password":"sfdcEIP234!","username":"SFDCEIP"}}}';
        return s;
    }
    
    //--Json builder for "PolicyDetails"
    public String jsonRequestPolicyDetails() {
        String uuid = uuidGenerator();
        String s = '{"Body":{"service":"getPolicyDetails","transactionId":"'+uuid+'","entity":"'+entity+'","appID":"'+appId+'","operation":"Policy Details","AXAAsiaPagination_Type":{"startOfRecords":"0","startDateTime":"","rowPerPage":"0","pageNumber":"0","numberOfRecords":"0","endDateTime":""},"IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"'+policyNo+'"}]}},"Header":{"SecurityContext":{"token":"Dummytoken-1234DMTM","password":"sfdcEIP234!","username":"SFDCEIP"}}}';
        return s;
    }
    
    //--Json builder for "AgentInfo"
    public String jsonRequestAgentInfo() {
        String uuid = uuidGenerator();
        String s = '{"Body":{"service":"getAgentInfo","transactionId":"'+uuid+'","entity":"'+entity+'","appID":"'+appId+'","operation":"Agent Info","AXAAsiaPagination_Type":{"startOfRecords":"0","rowPerPage":"0","pageNumber":"0","numberOfRecords":"0"},"AgSa_InsurancePolicy_Type":{"hasPartyDetailsIn":[{"partyNO":"'+agentId+'","hasNameValue":[{"value":"201808","name":"factPeriod"}]}]}},"Header":{"SecurityContext":{"token":"Dummytoken-1234DMTM","password":"sfdcEIP234!","username":"SFDCEIP"}}}';
        return s;
    }
    
    //--Json builder for "ClaimDetails"
    public String jsonRequestClaimDetails() {
        String uuid = uuidGenerator();
        String s = '{"Body":{"service":"getClaimDetails","transactionId":"'+uuid+'","entity":"'+entity+'","appID":"'+appId+'","operation":"Claim","AXAAsiaPagination_Type":{"startOfRecords":"1","startDateTime":"","pageNumber":"1","numberOfRecords":"100","endDateTime":""},"IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"'+policyNo+'"}]}},"Header":{"SecurityContext":{"token":"Dummytoken-1234DMTM","password":"sfdcEIP234!","username":"SFDCEIP"}}}';
        return s;
    }
    
    //--Callout I for page action
    public String calloutCustomerInfo() {
        String jsonString = jsonRequestCustomerInfo();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = 'https://prodapwsg.axa-tech.com:10443/prod/id/eip/rest/invoke?biz=CustomerManagementR-id-v1';
        request.setEndpoint(url);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(jsonString);
        String resBody = label.InformationPanelClass_ResponseBody;
        if(!test.isRunningTest()) { 
            HttpResponse response = http.send(request);
            resBody = response.getBody();
        }            
        System.debug('resBody taufik : '+resBody);
        jsonResponseCustomerInfo = resBody;        
        deserializeCustomerInfo(jsonResponseCustomerInfo);
        return null;
    }
    
    //--Callout II for page action
    public Object calloutPolicyAgent() {
        System.debug('====Start Continuation Request====');
        
        //--Create continuation
        Continuation con = new Continuation(60);
        con.continuationMethod='responsePolicyAgent';
        
        //--Json body
        String jsonString1 = jsonRequestPolicyDetails();
        String jsonString2 = jsonRequestAgentInfo();
        String jsonString3 = jsonRequestClaimDetails();
        
        //--Url endpoint (CHANGE TO LABEL)
        String url1 = 'https://prodapwsg.axa-tech.com:10443/prod/id/eip/rest/invoke?biz=PolicyManagementR-id-v1';
        String url2 = 'https://prodapwsg.axa-tech.com:10443/prod/id/eip/rest/invoke?biz=PartyManagementR-id-v1';
        String url3 = 'https://prodapwsg.axa-tech.com:10443/prod/id/eip/rest/invoke?biz=ClaimManagementR-id-v1';
        
        //--Request policy
        HttpRequest request1 = new HttpRequest();
        request1.setEndpoint(url1);
        request1.setMethod('POST');
        request1.setHeader('Content-Type', 'application/json');
        request1.setBody(jsonString1);
        this.continuation1 = con.addHttpRequest(request1); 
        System.debug('Request 1');
        
        //--Request agent
        HttpRequest request2 = new HttpRequest();
        request2.setEndpoint(url2);
        request2.setMethod('POST');
        request2.setHeader('Content-Type', 'application/json');
        request2.setBody(jsonString2);
        this.continuation2 = con.addHttpRequest(request2);
        System.debug('Request 2');
        
        //--Request claim
        HttpRequest request3 = new HttpRequest();
        request3.setEndpoint(url3);
        request3.setMethod('POST');
        request3.setHeader('Content-Type', 'application/json');
        request3.setBody(jsonString3);
        this.continuation3 = con.addHttpRequest(request3);
        System.debug('Request 3');
        
        System.debug('====End Continuation Request====');
        return con;
    }
    
    public Object responsePolicyAgent() {
        try {
        //--Response Policy
        HttpResponse response1 = Continuation.getResponse(this.continuation1);
        String resBody1 = response1.getBody();
        jsonResponsePolicyDetails = resBody1;
        deserializePolicyDetails(jsonResponsePolicyDetails);
        System.debug('Response1 = ' + resBody1);
        } catch (Exception e) {System.debug('Error response 1 : ' + e);}
        
        try {
        //--Response Agent
        HttpResponse response2 = Continuation.getResponse(this.continuation2);
        String resBody2 = response2.getBody();
        jsonResponseAgentInfo = resBody2;
        deserializeAgentInfo(jsonResponseAgentInfo);
        System.debug('Response2 = ' + resBody2);
        } catch (Exception e) {System.debug('Error response 2 : ' + e);}
        
        try {
        //--Response Claim
        HttpResponse response3 = Continuation.getResponse(this.continuation3);
        String resBody3 = response3.getBody();
        jsonResponseClaimDetails = resBody3;
        deserializeClaimDetails(jsonResponseClaimDetails);
        System.debug('Response3 = ' + resBody3);
        } catch (Exception e) {System.debug('Error response 3 : ' + e);}
        
        return null;
    }
    
    public void deserializeCustomerInfo(String js) {
        System.debug('.');
        Map<String, Object> mapLv1 = (Map<String, Object>) JSON.deserializeUntyped(js);
        System.debug('mapLv1 = ' + mapLv1);
        System.debug('Lv1-body = ' + mapLv1.get('Body'));
        
        System.debug('.');
        Map<String, Object> mapLv2 = (Map<String, Object>) mapLv1.get('Body');
        System.debug('mapLv2 = ' + mapLv2);
        System.debug('Lv2-operation = ' + mapLv2.get('operation'));
        System.debug('Lv2-transactionId = ' + mapLv2.get('transactionId'));
        System.debug('Lv2-status = ' + mapLv2.get('status'));
        System.debug('Lv2-entity = ' + mapLv2.get('entity'));
        System.debug('Lv2-service = ' + mapLv2.get('service'));
        System.debug('Lv2-IcAx_AXAAsiaCustomer_Type = ' + mapLv2.get('IcAx_AXAAsiaCustomer_Type'));
        System.debug('Lv2-appID = ' + mapLv2.get('appID'));
        System.debug('Lv2-AXAAsiaPagination_Type = ' + mapLv2.get('AXAAsiaPagination_Type'));
        
        //--Detail "IcAx_AXAAsiaCustomer_Type"
        System.debug('.');
        Map<String, Object> mapLv3sub1;
        if(mapLv2.get('IcAx_AXAAsiaCustomer_Type') != null) {
            mapLv3sub1 = (Map<String, Object>) mapLv2.get('IcAx_AXAAsiaCustomer_Type');
            System.debug('mapLv3sub1 = ' + mapLv3sub1);
            System.debug('Lv3sub1-canBeIndividual = ' + mapLv3sub1.get('canBeIndividual'));
            System.debug('Lv3sub1-hasPolicyAccount = ' + mapLv3sub1.get('hasPolicyAccount'));
            System.debug('Lv3sub1-customerID = ' + mapLv3sub1.get('customerID'));
        }
        
        //--Detail "AXAAsiaPagination_Type"
        System.debug('.');
        Map<String, Object> mapLv3sub2;
        if(mapLv2.get('AXAAsiaPagination_Type') != null) {
            mapLv3sub2 = (Map<String, Object>) mapLv2.get('AXAAsiaPagination_Type');
            System.debug('mapLv3sub2 = ' + mapLv3sub2);
            System.debug('Lv3sub2-rowPerPage = ' + mapLv3sub2.get('rowPerPage'));
            System.debug('Lv3sub2-numberOfRecords = ' + mapLv3sub2.get('numberOfRecords'));
            System.debug('Lv3sub2-pageNumber = ' + mapLv3sub2.get('pageNumber'));
            System.debug('Lv3sub2-startOfRecords = ' + mapLv3sub2.get('startOfRecords'));
        }
        
        //--Detail "canBeIndividual"
        System.debug('.');
        Map<String, Object> mapLv4sub1;
        if(mapLv3sub1.get('canBeIndividual') != null) {
            mapLv4sub1 = (Map<String, Object>) mapLv3sub1.get('canBeIndividual');
            System.debug('mapLv4sub1 = ' + mapLv4sub1);
            System.debug('Lv4sub1-genderCD = ' + mapLv4sub1.get('genderCD'));
            System.debug('Lv4sub1-hasAddressesIn = ' + mapLv4sub1.get('hasAddressesIn'));
            System.debug('Lv4sub1-birthPlace = ' + mapLv4sub1.get('birthPlace'));
            System.debug('Lv4sub1-birthDT = ' + mapLv4sub1.get('birthDT'));
            
            if(mapLv4sub1.get('genderCD') != null) {customerInfoGender = String.valueOf(mapLv4sub1.get('genderCD'));}
            if(mapLv4sub1.get('birthDT') != null) {
                customerInfoBOD = convertStringToDate(String.valueOf(mapLv4sub1.get('birthDT')));
                Integer bdYear = customerInfoBOD.year();
                Integer bdMonth = customerInfoBOD.month();
                Integer bdDay = customerInfoBOD.day();
                Integer tdYear = Date.today().year();
                Integer tdMonth = Date.today().month();
                if(Math.mod(tdYear, 4) == 0 && tdMonth == 2) {
                    bdDay = bdDay - 1;
                    birthday = Date.newInstance(tdYear, bdMonth, bdDay);
                } else {
                    birthday = Date.newInstance(tdYear, bdMonth, bdDay);
                }
            }
            System.debug('Info Gender : ' + customerInfoGender);
            System.debug('Info BOD : ' + customerInfoBOD);
        }
        
        //--Detail "hasPolicyAccount"
        System.debug('.');
        Map<String, Object> mapLv4sub2;
        if(mapLv3sub1.get('hasPolicyAccount') != null) {
            List<Object> tempObjList = new List<Object>();
            for(Object o : (List<Object>)mapLv3sub1.get('hasPolicyAccount')) {
                tempObjList.add(o);
            }
            Map<String, Object> mapLv5 = (Map<String, Object>) tempObjList[0];
            System.debug('mapLv5 = ' + mapLv5);
            
            if(mapLv5.get('hasPartyDetailsIn') != null) {
                List<Object> tempObjList2 = new List<Object>();
                for(Object o : (List<Object>)mapLv5.get('hasPartyDetailsIn')) {
                    tempObjList2.add(o);
                }
                Map<String, Object> mapLv6 = (Map<String, Object>) tempObjList2[0];
                System.debug('mapLv6 = ' + mapLv6);
                System.debug('Lv6-servicingCD = ' + mapLv6.get('servicingCD'));
                if(mapLv6.get('servicingCD') != null) {
                    if(String.valueOf(mapLv6.get('servicingCD')).length() >= 13) {
                        agentId = String.valueOf(mapLv6.get('servicingCD')).substring(8,14);
                    } else {
                        agentId = String.valueOf(mapLv6.get('servicingCD'));
                    }
                }
                System.debug('agentId = ' + agentId);
            }
        }
    }
    
    public void deserializePolicyDetails(String js) {
        System.debug('.');
        Map<String, Object> mapLv1 = (Map<String, Object>) JSON.deserializeUntyped(js);
        System.debug('mapLv1 = ' + mapLv1);
        System.debug('Lv1-body = ' + mapLv1.get('Body'));
        
        System.debug('.');
        Map<String, Object> mapLv2 = (Map<String, Object>) mapLv1.get('Body');
        System.debug('mapLv2 = ' + mapLv2);
        System.debug('Lv2-operation = ' + mapLv2.get('operation'));
        System.debug('Lv2-transactionId = ' + mapLv2.get('transactionId'));
        System.debug('Lv2-status = ' + mapLv2.get('status'));
        System.debug('Lv2-entity = ' + mapLv2.get('entity'));
        System.debug('Lv2-service = ' + mapLv2.get('service'));
        System.debug('Lv2-IcAx_AXAAsiaCustomer_Type = ' + mapLv2.get('IcAx_AXAAsiaCustomer_Type'));
        System.debug('Lv2-appID = ' + mapLv2.get('appID'));
        System.debug('Lv2-AXAAsiaPagination_Type = ' + mapLv2.get('AXAAsiaPagination_Type'));
        
        //--Detail "IcAx_AXAAsiaCustomer_Type"
        System.debug('.');
        Map<String, Object> mapLv3sub1;
        if(mapLv2.get('IcAx_AXAAsiaCustomer_Type') != null) {
            mapLv3sub1 = (Map<String, Object>) mapLv2.get('IcAx_AXAAsiaCustomer_Type');
            System.debug('mapLv3sub1 = ' + mapLv3sub1);
            System.debug('Lv3sub1-hasPolicyAccount = ' + mapLv3sub1.get('hasPolicyAccount'));
        }
        
        //--Detail "AXAAsiaPagination_Type"
        System.debug('.');
        Map<String, Object> mapLv3sub2;
        if(mapLv2.get('AXAAsiaPagination_Type') != null) {
            mapLv3sub2 = (Map<String, Object>) mapLv2.get('AXAAsiaPagination_Type');
            System.debug('mapLv3sub2 = ' + mapLv3sub2);
            System.debug('Lv3sub2-rowPerPage = ' + mapLv3sub2.get('rowPerPage'));
            System.debug('Lv3sub2-numberOfRecords = ' + mapLv3sub2.get('numberOfRecords'));
            System.debug('Lv3sub2-pageNumber = ' + mapLv3sub2.get('pageNumber'));
            System.debug('Lv3sub2-startOfRecords = ' + mapLv3sub2.get('startOfRecords'));
        }
        
        //--Detail "hasPolicyAccount"
        System.debug('.');
        Map<String, Object> mapLv4sub1;
        if(mapLv3sub1.get('hasPolicyAccount') != null) {
            List<Object> tempObjList = new List<Object>();
            for(Object o : (List<Object>)mapLv3sub1.get('hasPolicyAccount')) {
                tempObjList.add(o);
            }
            mapLv4sub1 = (Map<String, Object>) tempObjList[0];
            System.debug('mapLv4sub1 = ' + mapLv4sub1);
            System.debug('Lv4sub1-policyEffectiveDTTM = ' + mapLv4sub1.get('policyEffectiveDTTM'));
            System.debug('Lv4sub1-hasLifePolicyTransactionDetailsIn = ' + mapLv4sub1.get('hasLifePolicyTransactionDetailsIn'));
            System.debug('Lv4sub1-paymentMethodCD = ' + mapLv4sub1.get('paymentMethodCD'));
            System.debug('Lv4sub1-policyRK = ' + mapLv4sub1.get('policyRK'));
            System.debug('Lv4sub1-policyExpirationDTTM = ' + mapLv4sub1.get('policyExpirationDTTM'));
            System.debug('Lv4sub1-initialLumpsumPremiumAMT = ' + mapLv4sub1.get('initialLumpsumPremiumAMT'));
            System.debug('Lv4sub1-hasLifePolicyChangeTransDetailsIn = ' + mapLv4sub1.get('hasLifePolicyChangeTransDetailsIn'));
            System.debug('Lv4sub1-hasApplicationDetailsIn = ' + mapLv4sub1.get('hasApplicationDetailsIn'));
            System.debug('Lv4sub1-isAssociatedWithLifeInsuranceProduct = ' + mapLv4sub1.get('isAssociatedWithLifeInsuranceProduct'));
            System.debug('Lv4sub1-topupRegularModalPremium = ' + mapLv4sub1.get('topupRegularModalPremium'));
            System.debug('Lv4sub1-policyStatusCD = ' + mapLv4sub1.get('policyStatusCD'));
            System.debug('Lv4sub1-terminationDt = ' + mapLv4sub1.get('terminationDt'));
            System.debug('Lv4sub1-hasDetailsOfPolicyIn = ' + mapLv4sub1.get('hasDetailsOfPolicyIn'));
            System.debug('Lv4sub1-policyDueDt = ' + mapLv4sub1.get('policyDueDt'));
            System.debug('Lv4sub1-premiumAMT = ' + mapLv4sub1.get('premiumAMT'));
            System.debug('Lv4sub1-paymentModeCD = ' + mapLv4sub1.get('paymentModeCD'));
            System.debug('Lv4sub1-ePolicy = ' + mapLv4sub1.get('ePolicy'));
            System.debug('Lv4sub1-hasDetailsOfRisksIn = ' + mapLv4sub1.get('hasDetailsOfRisksIn'));
            System.debug('Lv4sub1-issueDt = ' + mapLv4sub1.get('issueDt'));
            System.debug('Lv4sub1-sourceChannelCD = ' + mapLv4sub1.get('sourceChannelCD'));
            
            if(mapLv4sub1.get('policyEffectiveDTTM') != null) {policyDetailsEffectiveDate = convertStringToDate(String.valueOf(mapLv4sub1.get('policyEffectiveDTTM')));}
            if(mapLv4sub1.get('policyStatusCD') != null) {policyDetailsPolicyStatus = String.valueOf(mapLv4sub1.get('policyStatusCD'));}
            if(mapLv4sub1.get('policyDueDt') != null) {policyDetailsDueDate = convertStringToDate(String.valueOf(mapLv4sub1.get('policyDueDt')));}
            if(mapLv4sub1.get('premiumAMT') != null) {policyDetailsTotalPremium = String.valueOf(mapLv4sub1.get('premiumAMT'));}
            if(mapLv4sub1.get('paymentModeCD') != null) {policyDetailsPaymentMode = String.valueOf(mapLv4sub1.get('paymentModeCD'));}
            if(mapLv4sub1.get('ePolicy') != null) {policyDetailsEPolicy = String.valueOf(mapLv4sub1.get('ePolicy'));}
        }
        
        //--Detail "isAssociatedWithLifeInsuranceProduct"
        System.debug('.');
        Map<String, Object> mapLv5sub1;
        if(mapLv4sub1.get('isAssociatedWithLifeInsuranceProduct') != null) {
            List<Object> tempObjList = new List<Object>();
            for(Object o : (List<Object>)mapLv4sub1.get('isAssociatedWithLifeInsuranceProduct')) {
                tempObjList.add(o);
            }
            mapLv5sub1 = (Map<String, Object>) tempObjList[0];
            
            System.debug('mapLv5sub1 = ' + mapLv5sub1);
            System.debug('Lv5sub1-planCd = ' + mapLv5sub1.get('planCd'));
            System.debug('Lv5sub1-hasPolicySegmentDetailsIn = ' + mapLv5sub1.get('hasPolicySegmentDetailsIn'));
            System.debug('Lv5sub1-planNM = ' + mapLv5sub1.get('planNM'));
            
            if(mapLv5sub1.get('planNM') != null) {policyDetailsProductName = String.valueOf(mapLv5sub1.get('planNM'));}
        }
    }
    
    public void deserializeAgentInfo(String js) {
        System.debug('.');
        Map<String, Object> mapLv1 = (Map<String, Object>) JSON.deserializeUntyped(js);
        System.debug('mapLv1 = ' + mapLv1);
        System.debug('Lv1-body = ' + mapLv1.get('Body'));
        
        System.debug('.');
        Map<String, Object> mapLv2 = (Map<String, Object>) mapLv1.get('Body');
        System.debug('mapLv2 = ' + mapLv2);
        System.debug('Lv2-operation = ' + mapLv2.get('operation'));
        System.debug('Lv2-transactionId = ' + mapLv2.get('transactionId'));
        System.debug('Lv2-status = ' + mapLv2.get('status'));
        System.debug('Lv2-entity = ' + mapLv2.get('entity'));
        System.debug('Lv2-service = ' + mapLv2.get('service'));
        System.debug('Lv2-appID = ' + mapLv2.get('appID'));
        System.debug('Lv2-AXAAsiaPagination_Type = ' + mapLv2.get('AXAAsiaPagination_Type'));
        System.debug('Lv2-AgSa_InsurancePolicy_Type = ' + mapLv2.get('AgSa_InsurancePolicy_Type'));
        
        //--Detail "AXAAsiaPagination_Type"
        System.debug('.');
        Map<String, Object> mapLv3sub1;
        if(mapLv2.get('AXAAsiaPagination_Type') != null) {
            mapLv3sub1 = (Map<String, Object>) mapLv2.get('AXAAsiaPagination_Type');
            System.debug('mapLv3sub1 = ' + mapLv3sub1);
            System.debug('Lv3sub1-rowPerPage = ' + mapLv3sub1.get('rowPerPage'));
            System.debug('Lv3sub1-numberOfRecords = ' + mapLv3sub1.get('numberOfRecords'));
            System.debug('Lv3sub1-pageNumber = ' + mapLv3sub1.get('pageNumber'));
            System.debug('Lv3sub1-startOfRecords = ' + mapLv3sub1.get('startOfRecords'));
        }
        
        //--Detail "AgSa_InsurancePolicy_Type"
        System.debug('.');
        Map<String, Object> mapLv3sub2;
        if(mapLv2.get('AgSa_InsurancePolicy_Type') != null) {
            mapLv3sub2 = (Map<String, Object>) mapLv2.get('AgSa_InsurancePolicy_Type');
            System.debug('mapLv3sub2 = ' + mapLv3sub2);
            System.debug('Lv3sub2-hasPartyDetailsIn = ' + mapLv3sub2.get('hasPartyDetailsIn'));
        }
        
        //--Detail "hasPartyDetailsIn"
        System.debug('.');
        Map<String, Object> mapLv4sub1;
        if(mapLv3sub2.get('hasPartyDetailsIn') != null) {
            List<Object> tempObjList = new List<Object>();
            for(Object o : (List<Object>)mapLv3sub2.get('hasPartyDetailsIn')) {
                tempObjList.add(o);
            }
            mapLv4sub1 = (Map<String, Object>) tempObjList[0];
            System.debug('mapLv4sub1 = ' + mapLv4sub1);
            System.debug('Lv4sub1-canBeInternalOrg = ' + mapLv4sub1.get('canBeInternalOrg'));
            System.debug('Lv4sub1-branchCD = ' + mapLv4sub1.get('branchCD'));
            System.debug('Lv4sub1-canBeIndividual = ' + mapLv4sub1.get('canBeIndividual'));
            System.debug('Lv4sub1-partyID = ' + mapLv4sub1.get('partyID'));
            System.debug('Lv4sub1-partyNO = ' + mapLv4sub1.get('partyNO'));
            System.debug('Lv4sub1-partyStatus = ' + mapLv4sub1.get('partyStatus'));
            
            if(mapLv4sub1.get('partyNO') != null) {agentInfoAgentNo = String.valueOf(mapLv4sub1.get('partyNO'));}
            if(mapLv4sub1.get('partyStatus') != null) {agentInfoAgentStatus = String.valueOf(mapLv4sub1.get('partyStatus'));}
        }
        
        //--Detail "canBeIndividual"
        System.debug('.');
        Map<String, Object> mapLv5sub1;
        if(mapLv4sub1.get('canBeIndividual') != null) {
            mapLv5sub1 = (Map<String, Object>) mapLv4sub1.get('canBeIndividual');
            System.debug('mapLv5sub1 = ' + mapLv5sub1);
            System.debug('Lv5sub1-hasAddressesIn = ' + mapLv5sub1.get('hasAddressesIn'));
            System.debug('Lv5sub1-distributionType = ' + mapLv5sub1.get('distributionType'));
            System.debug('Lv5sub1-lastNM = ' + mapLv5sub1.get('lastNM'));
            System.debug('Lv5sub1-distributionCD = ' + mapLv5sub1.get('distributionCD'));
            System.debug('Lv5sub1-firstNM = ' + mapLv5sub1.get('firstNM'));
            System.debug('Lv5sub1-effectiveNominationDT = ' + mapLv5sub1.get('effectiveNominationDT'));
            
            if(mapLv5sub1.get('firstNM') != null) {agentInfoAgentFirstName = String.valueOf(mapLv5sub1.get('firstNM'));}
            if(mapLv5sub1.get('lastNM') != null) {agentInfoAgentLastName = String.valueOf(mapLv5sub1.get('lastNM'));}
        }
    }
    
    public void deserializeClaimDetails(String js) {
        System.debug('.');
        Map<String, Object> mapLv1 = (Map<String, Object>) JSON.deserializeUntyped(js);
        System.debug('mapLv1 = ' + mapLv1);
        System.debug('Lv1-body = ' + mapLv1.get('Body'));
        
        System.debug('.');
        Map<String, Object> mapLv2 = (Map<String, Object>) mapLv1.get('Body');
        System.debug('mapLv2 = ' + mapLv2);
        System.debug('Lv2-operation = ' + mapLv2.get('operation'));
        System.debug('Lv2-transactionId = ' + mapLv2.get('transactionId'));
        System.debug('Lv2-status = ' + mapLv2.get('status'));
        System.debug('Lv2-entity = ' + mapLv2.get('entity'));
        System.debug('Lv2-service = ' + mapLv2.get('service'));
        System.debug('Lv2-IcAx_AXAAsiaCustomer_Type = ' + mapLv2.get('IcAx_AXAAsiaCustomer_Type'));
        System.debug('Lv2-appID = ' + mapLv2.get('appID'));
        System.debug('Lv2-AXAAsiaPagination_Type = ' + mapLv2.get('AXAAsiaPagination_Type'));
        
        //--Detail "IcAx_AXAAsiaCustomer_Type"
        System.debug('.');
        Map<String, Object> mapLv3sub1;
        if(mapLv2.get('IcAx_AXAAsiaCustomer_Type') != null) {
            mapLv3sub1 = (Map<String, Object>) mapLv2.get('IcAx_AXAAsiaCustomer_Type');
            System.debug('mapLv3sub1 = ' + mapLv3sub1);
            System.debug('Lv3sub1-hasPolicyAccount = ' + mapLv3sub1.get('hasPolicyAccount'));
            
            if(mapLv3sub1.get('hasPolicyAccount') != null) {
                List<Object> tempObjList = new List<Object>();
                for(Object o : (List<Object>)mapLv3sub1.get('hasPolicyAccount')) {
                    tempObjList.add(o);
                }
                
                if(mapLv2.get('status') == 1 && tempObjList.size() > 0) {
                    claimDetailsNumberOfClaim = String.valueOf(tempObjList.size());
                } else if(mapLv2.get('status') == 0) {
                    claimDetailsNumberOfClaim = '0';
                } else {
                    claimDetailsNumberOfClaim = '0';
                }
                
                Map<String, Object> mapLv4 = (Map<String, Object>) tempObjList[0];
                System.debug('mapLv4 = ' + mapLv4);
                if(mapLv4.get('hasDetailsOfClaimIn') != null) {
                    List<Object> tempObjList2 = new List<Object>();
                    for(Object o : (List<Object>)mapLv4.get('hasDetailsOfClaimIn')) {
                        tempObjList2.add(o);
                    }
                    Map<String, Object> mapLv5 = (Map<String, Object>) tempObjList2[0];
                    System.debug('mapLv5 = ' + mapLv5);
                    System.debug('Lv5-claimReferenceID = ' + mapLv5.get('claimReferenceID'));
                    claimDetailsLastClaimNo = String.valueOf(mapLv5.get('claimReferenceID'));
                    
                    if(mapLv5.get('hasClaimUnitIn') != null) {
                        List<Object> tempObjList3 = new List<Object>();
                        for(Object o : (List<Object>)mapLv5.get('hasClaimUnitIn')) {
                            tempObjList3.add(o);
                        }
                        Map<String, Object> mapLv6 = (Map<String, Object>) tempObjList3[0];
                        System.debug('mapLv6 = ' + mapLv6);
                        System.debug('Lv6-claimRK = ' + mapLv6.get('claimRK'));
                        claimDetailsLastClaimStatus1 = String.valueOf(mapLv6.get('claimRK'));
                    }
                }   
            }
        }
    }
    
    private static Date convertStringToDate(string dateStr){
        //string newDate = dateStr.replaceAll('/', '').replaceAll('-', '').replaceAll('\\.', '');
        //system.debug('New date: '+newDate);
        Integer year = Integer.valueOf(dateStr.substring(0,4));
        Integer month = Integer.valueOf(dateStr.substring(4,6));
        Integer day = Integer.valueOf(dateStr.substring(6,8));
        Date dateObj = Date.valueOf(year+'-'+month+'-'+day);
        system.debug('DateObj: ' +dateObj);
        return date.newInstance(year, month, day);
    }
    
    public List<Contact> getListPolicyNo() {
        List<Contact> tempListContact = new List<Contact>();
        if(currentContact[0].Entity__c == 'AMFS' || currentContact[0].Entity__c == 'MAGI') {
            tempListContact = [SELECT Id, Policy_No__c, LastName FROM Contact WHERE Name = :currentContact[0].Name AND MobilePhone = :currentContact[0].MobilePhone LIMIT 1000];
        } else if(currentContact[0].Entity__c == 'AFI') {
            tempListContact = [SELECT Id, Policy_No__c, LastName FROM Contact WHERE Email = :currentContact[0].Email AND MobilePhone = :currentContact[0].MobilePhone LIMIT 1000];
        } else {
            tempListContact.add(currentContact[0]);
        }
        return tempListContact;
    }   
}