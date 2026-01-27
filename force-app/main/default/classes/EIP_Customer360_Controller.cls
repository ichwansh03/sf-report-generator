public class EIP_Customer360_Controller {
    public List<Contact> currentContact {get; set;}
    public List<Case> listOfCaseGA {get;set;}
    public List<Case> listOfCase {get;set;}
    public List<Case> listComplaint {get;set;}
    public List<ICF_Non_CCC__c> nonCccList {get;set;}
    public List<Survey_Response__c> lastResponse {get; set;}
    public String generalAttitude {get; set;}
    public String caseOrigin {get; set;}
    public String lastResponseId {get; set;}
    public String lastCase {get; set;}
    public String policyNo {get; set;}
    public String policyApp {get; set;}
    public String entity {get; set;}
    public Boolean isLatestCase {get; set;}
    private String contactId;
    
    public String sessionId {get;set;}
    public Boolean isDisplayJSON {get;set;}
    
    public String agentName {get;set;}
    public String agentCode {get;set;}
    public String agentStatus {get;set;}
    
    public String claimNo {get;set;}
    public String claimStatus {get;set;}
    public Integer claimTimes {get;set;}
    
    public String jsonStr {get;set;}
    public PolicyDetailCls policyDetail {get;set;}
    
    //--Inner Class Policy
    public class PolicyDetailCls{ 
        
        public string policyNumber {get;set;}
        public string SourceCode {get;set;}
        public string PlanCode {get;set;}
        public string PlanName {get;set;}
        public string PolicyStatus {get;set;}
        public Date ApplicationDate {get;set;}
        public Date IssueDate {get;set;}
        public Date EffectiveDate {get;set;}
        public Date ExpiredDate {get;set;}
        public Date DueDate {get;set;}
        public Date TerminationDate {get;set;}
        public decimal TotalPremium {get;set;}
        public decimal TotalSumInsured {get;set;}
        public decimal TopUpPremium {get;set;}
        public decimal InitialLumpSum {get;set;}
        public string PaymentMethod {get;set;}
        public string PaymentMode {get;set;}
        public string StatusDescription {get;set;}
        public Date PremiumHolidayStartDate {get;set;}
        public Date PremiumHolidayEndDate {get;set;}
        public string ePolicy {get;set;}
        public string MataUang {get;set;}
        public string currencyCode {get;set;}
        
        public decimal RegularTopUp {get;set;}
        
        public PolicyDetailCls(){
        }
    }
    
    //--Standard Controller
    public EIP_Customer360_Controller(ApexPages.StandardController controller) {
        contactId = controller.getId();
        //sessionId = contactID + '-'+ CCCUtils.getSessionID();
        
        //PageReference thisPage = Page.EIP_InformationPanelPolicyAgent;
        //thisPage.getParameters().put('sessionId', sessionId);
        
        currentContact = [SELECT Id, Name, LastName, Email, Phone, MobilePhone, Entity__c, Policy_No__c, PolicyApp__c, Owner.Agent_ID__c, Last_Case__c FROM Contact WHERE Id = :contactId];
        listOfCaseGA = [SELECT Id, Origin, Type, CreatedDate, General_Attitude__c FROM Case WHERE ContactId = :contactId AND General_Attitude__c != null ORDER BY CreatedDate DESC LIMIT 1];
        listOfCase = [SELECT Id, Origin, Type, CreatedDate, General_Attitude__c FROM Case WHERE ContactId = :contactId ORDER BY CreatedDate DESC LIMIT 1000];
        listComplaint = [SELECT Id, Type FROM Case WHERE ContactId = :contactId AND Type = 'Complaint' AND Status != 'Closed' LIMIT 1000];
        nonCccList = [SELECT Id, Policy_number__c, MOT__c, CreatedDate FROM ICF_Non_CCC__c WHERE Policy_Number__c = :currentContact[0].Policy_No__c ORDER BY CreatedDate DESC LIMIT 1000];
        lastResponse = [SELECT Id, SurveyTaker__r.Name, SurveyTaker__r.Case__c, Answer_7__c FROM Survey_Response__c WHERE SurveyTaker__r.Case__c = :lastCase LIMIT 1];
        
        lastCase = currentContact[0].Last_Case__c;
        policyNo = currentContact[0].Policy_No__c;
        policyApp = currentContact[0].PolicyApp__c;
        entity = currentContact[0].Entity__c;
        
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
        } else {
            lastResponseId = null;
        }
        
        if (system.label.WS_JSON_Display =='true' ) { 
            isDisplayJSON = true;
        } else isDisplayJSON = false;
    }
    
    //--Query Policy in SFDC Related to Contact Opened
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
    
    
    
    
    
    //--Called when Page Load
    public void initData() {
        retrievePolicy();
        retrieveAgent();
        retrieveClaim();
    }
    
    
    //--Connector to Agent Info
    public String retrieveAgent() {
        try {
            EIPJson eipCustomer = new EIPJson();
            if(Test.isRunningTest() == false) {
                eipCustomer = EIPConnector.getCustomerInfo('Customer Profile', entity, policyApp, policyNo);
            } else if(Test.isRunningTest() == true) {
                eipCustomer.Body = new EIPJson.EIP_Body();
                eipCustomer.Body.IcAx_AXAAsiaCustomer_Type = new EIPJson.EIP_IcAx_AXAAsiaCustomer();
                EIPJson.EIP_AgSa_InsurancePolicy rec1 = new EIPJson.EIP_AgSa_InsurancePolicy();
                eipCustomer.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{rec1};
                EIPJson.EIP_IcAx_AXAAsiaParty rec2 = new EIPJson.EIP_IcAx_AXAAsiaParty();
                eipCustomer.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPartyDetailsIn = new EIPJson.EIP_IcAx_AXAAsiaParty[]{rec2};
                eipCustomer.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPartyDetailsIn[0].servicingCD = '63626204011191';    
            }
            System.debug('eipCustomer : ' + eipCustomer);
            
            //--Preparing Parameter for Agent Info Request
            String servicingCd = eipCustomer.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPartyDetailsIn[0].servicingCD;
            String partyNo = servicingCd.trim().mid(9,14);
            Date dt = Date.today();
            String appendMonth = '';
            if(dt.month() < 10) {appendMonth = '0';}
            String factPeriod = String.valueOf(dt.year()) + appendMonth + String.valueOf(dt.month());
            System.debug('partyNo : ' + partyNo);
            System.debug('factPeriod : ' + factPeriod);
            
            EIPJson eipAgent = EIPConnector.getAgentInfo('Agent Info', entity, policyApp, partyNo, factPeriod);
            System.debug('eipAgent : ' + eipAgent);
            
            agentName = eipAgent.Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn[0].canBeIndividual.firstNM;
            agentCode = eipAgent.Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn[0].partyID;
            agentStatus = eipAgent.Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn[0].partyStatus;
            
        } catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        } catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        } catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin.'));
        }
        return null;
    }
    
    //--Connector to Policy Info
    public String retrievePolicy() {
        try {   
            
            //--Call EIPConnector to get Policy Details
            EIPJson eip = new EIPJson();
            if(Test.isRunningTest() == false) {
                eip = EIPConnector.getPolicyDetails('Policy Details', entity, policyApp, policyNo);
                System.debug('EIP : ' + eip);
            } else if(Test.isRunningTest() == true) {
                eip.Body = new EIPJson.EIP_Body();
                eip.Body.IcAx_AXAAsiaCustomer_Type = new EIPJson.EIP_IcAx_AXAAsiaCustomer();
                EIPJson.EIP_AgSa_InsurancePolicy rec1 = new EIPJson.EIP_AgSa_InsurancePolicy();
                eip.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{rec1};
                eip.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyStatusCD = 'Active';
                eip.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyEffectiveDTTM = '20190907';
                eip.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyDueDt = '20190907';
                eip.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].initialLumpsumPremiumAMT = '100000';
                eip.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].ePolicy = 'E';
                eip.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].paymentMethodCD = 'T';
                EIPJson.EIP_IcAx_AXAAsiaLifeInsuranceProduct rec2 = new EIPJson.EIP_IcAx_AXAAsiaLifeInsuranceProduct();
                eip.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct = new EIPJson.EIP_IcAx_AXAAsiaLifeInsuranceProduct[]{rec2};
                eip.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].planNM = 'LifeInsurance';
            }
            
            EIPJson.EIP_Body eipBody =  eip.Body;
            System.debug('EIP-eipBody : ' + eipBody);
            
            EIPJson.EIP_IcAx_AXAAsiaCustomer eipCustomer = eipBody.IcAx_AXAAsiaCustomer_Type;
            System.debug('EIP-eipCustomer : ' + eipCustomer);
            
            EIPJson.EIP_AgSa_InsurancePolicy eipPolicy = eipCustomer.hasPolicyAccount[0];
            System.debug('EIP-eipPolicy : ' + eipPolicy);
            
            
            //--Set Var
            policyDetail = new PolicyDetailCls();
            policyDetail.PlanName = eipPolicy.isAssociatedWithLifeInsuranceProduct[0].planNM;
            policyDetail.PolicyStatus = eipPolicy.policyStatusCD;
            String effDateStr = eipPolicy.policyEffectiveDTTM;
            policyDetail.EffectiveDate = Date.newInstance(Integer.valueOf(effDateStr.left(4)), Integer.valueOf(effDateStr.mid(4,2)), Integer.valueOf(effDateStr.right(2)));
            String dueDateStr = eipPolicy.policyDueDt;
            policyDetail.DueDate = Date.newInstance(Integer.valueOf(dueDateStr.left(4)), Integer.valueOf(dueDateStr.mid(4,2)), Integer.valueOf(dueDateStr.right(2)));
            decimal premiAmt = decimal.valueOf(eipPolicy.initialLumpsumPremiumAMT.trim());
            policyDetail.TotalPremium = premiAmt;
            policyDetail.ePolicy = eipPolicy.ePolicy;
            policyDetail.PaymentMethod = eipPolicy.paymentMethodCD;
            System.debug('>>> Value Result : ' + eipPolicy.initialLumpsumPremiumAMT + ',' + premiAmt);
            
        } catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        } catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        } catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin.'));
        }
        return null;
    }
    
    //--Connector to Claim Info
    public String retrieveClaim() {
        try {
            EIPJson eipClaim = new EIPJson();
            if(Test.isRunningTest() == false) {
                eipClaim = EIPConnector.getClaimDetails('Claim', entity, policyApp, policyNo);
                System.debug('eipClaim : ' + eipClaim);
            } else if(Test.isRunningTest() == true) {
                eipClaim.Body = new EIPJson.EIP_Body();
                eipClaim.Body.IcAx_AXAAsiaCustomer_Type = new EIPJson.EIP_IcAx_AXAAsiaCustomer();
                EIPJson.EIP_AgSa_InsurancePolicy rec1 = new EIPJson.EIP_AgSa_InsurancePolicy();
                eipClaim.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount = new EIPJson.EIP_AgSa_InsurancePolicy[]{rec1};
                EIPJson.EIP_IcAx_AXAAsiaLifeInsuranceClaim rec2 = new EIPJson.EIP_IcAx_AXAAsiaLifeInsuranceClaim();
                eipClaim.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfClaimIn = new EIPJson.EIP_IcAx_AXAAsiaLifeInsuranceClaim[]{rec2};
                eipClaim.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfClaimIn[0].claimReferenceID = '63626204011191';    
            }
            claimNo = eipClaim.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfClaimIn[0].claimReferenceID;
            claimStatus = eipClaim.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfClaimIn[0].claimStatusRk;
            claimTimes = eipClaim.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfClaimIn.size();
            
        } catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        } catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        } catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin.'));
        }
        return null;
    }
}