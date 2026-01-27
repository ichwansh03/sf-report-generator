public class DetailNasabahCtrl {
    public DetailTask dTask {get;set;}
    Public String serializeError{get;set;}
    private Boolean isIncludeRLS = false;
    private Contact ct = new Contact();
    private Call_line__c cl = new Call_line__c();
    
	public DetailNasabahCtrl(ApexPages.StandardController controller) {
        
        try {   
            cl = (Call_Line__c)controller.getRecord();
            cl = [Select id, name, contact__c, createddate, WelcomeCall_Days__c, WelcomeCall_Call_Line_Status__c, WelcomeCall_Attempt__c from Call_Line__c where id =: cl.Id];
            ct =[Select id, name, policy_no__c, entity__c, policyApp__c, phone, Agent_Code__c ,
                         welcomecall_ape__c, welcomecall_issued_date__c, welcomecall_product_code_plan__c, email, Total_Premium__c,
                         WelcomeCall_Payment_Type_Name__c, welcomecall_effective_date__c, MobilePhone, LastModifiedDate
                         from contact where id =: cl.Contact__c];
            populateDetailNasabah(ct, cl);
        } catch (exception E){
            System.debug('=== ERROR MESSAGE === '+E.getMessage());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        }
    }
    public void populateDetailNasabah(){
        isIncludeRLS = true;
        populateDetailNasabah(ct, cl);
    }
    
    public PageReference populateDetailNasabah(Contact ct, Call_Line__c cl){
        serializeError = '';
        Axa2_Json jsonUtil = new Axa2_Json();
        if(!isIncludeRLS){
            dTask = new DetailTask(ct, cl, null, null, null, null);
        } else {
            dTask = new DetailTask(ct, cl, null, null, null, null);
            system.debug('mau ambil data');
            String servicingCD;
            
            // get data Customer Info - Customer Profile
            EIPJson dataCustomerEIP, dataPremiumBreakdownEIP, dataAgentEIP, dataPolicyEIP;
            try{
                dataCustomerEIP = EIPConnector.getCustomerInfo('Customer Profile', ct.Entity__c, ct.PolicyApp__c, ct.policy_no__c);
                dTask.setDataCustomer(dataCustomerEIP);
                
                // get Policy Details
                system.debug('policy app: '+ct.PolicyApp__c);
                dataPolicyEIP = EIPConnector.getPolicyDetails('Policy Details', ct.Entity__c, ct.PolicyApp__c, ct.policy_no__c);
                dTask.setDataPolicy(dataPolicyEIP);
                
                if (ct.PolicyApp__c == 'RLS') {
                    // get data Premium Breakdown
                    dataPremiumBreakdownEIP = EIPConnector.getPremiumBreakdown('Premium Breakdown', ct.Entity__c, ct.PolicyApp__c, ct.policy_no__c);
                    dTask.setDataPremiumBreakdown(dataPremiumBreakdownEIP);   
                    
                    // set servicing code
                    servicingCD = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPartyDetailsIn[0].servicingCD;
                    servicingCD = servicingCD == null ? '' : servicingCD.substring(9, 15);
                    
                    // get agent info
                    dataAgentEIP = EIPConnector.getAgentInfo('Agent Info', ct.Entity__c, ct.PolicyApp__c, servicingCD, null, true);
                    dTask.setDataAgent(dataAgentEIP);
                    
                    system.debug('DATA PREMIUM BREAKDOWN='+dataPremiumBreakdownEIP);
                    system.debug('DATA AGENT='+dataAgentEIP);
                }
                
                system.debug('DATA CUSTOMER='+dataCustomerEIP);
                system.debug('DATA POLICY='+dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type);   
            }catch(EIPConnector.NoDataException e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
            }catch(EIPConnector.EIPConnectorException e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
            }
            
            /*
            system.debug('dataCustomer: '+dataCustomer);
            Map<String,String> errorMap = new Map<String,String>();
            String servicingCD;
            Object dataCustomerJSON;
            if(dataCustomer == null || !dataCustomer.contains('"transactionId"')){
            dataCustomer =  dataCustomer == null ? '' : dataCustomer;
            errorMap.put('Customer Profile API', dataCustomer.escapeJava());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Customer Profile API RLS '+dataCustomer));
            return null;
            } else {
            dataCustomerJSON = JSON.deserializeUntyped(dataCustomer);
            servicingCD = String.valueOf(jsonUtil.getData(dataCustomerJSON, 'Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount.0.hasPartyDetailsIn.0.servicingCD'));
            }
            if(!errorMap.isEmpty()){
            serializeError = JSON.serialize(errorMap);
            }
            */
                        
                        /*
            String preBreakdown = RemoteDataController.getRemoteDataPremiumBreakdown(ct.policy_no__c, ct.Entity__c, ct.PolicyApp__c, 'Premium Breakdown', 
            '', '', 100, 1, 100, 1);
            //servicingCD = servicingCD == null ? '' : servicingCD.substring(9, 15);
            String agentInfo = RemoteDataController.getRemoteDataAgentInfo(servicingCD, ct.Entity__c, ct.PolicyApp__c, 'Agent Info', '', '', 100, 
            1, 100, 1);
            String dataGIPolicy = RemoteDataController.getRemoteDataPolicyDetailLife(ct.policy_no__c, ct.Entity__c, ct.PolicyApp__c, 'Policy Details', '', '', 
            100, 1, 100, 1);
            */
            // if(preBreakdown == null || !preBreakdown.contains('"transactionId"')){
            //     preBreakdown =  preBreakdown == null ? '' : preBreakdown;
            //     errorMap.put('Premium Breakdown API', preBreakdown.escapeJava());
            //     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Premium Breakdown API '+preBreakdown));
            //     return null;
            // }
            // if(agentInfo == null || !agentInfo.contains('"transactionId"')){
            //     agentInfo =  agentInfo == null ? '' : agentInfo;
            //     errorMap.put('Agent Info API', agentInfo.escapeJava());
            //     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Agent Info API '+agentInfo));
            //     return null;
            // }
            // if(dataGIPolicy == null || !dataGIPolicy.contains('"transactionId"')){
            //     dataGIPolicy =  dataGIPolicy == null ? '' : dataGIPolicy;
            //     errorMap.put('Data Policy API', dataGIPolicy.escapeJava());
            //     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Data Policy API'+dataGIPolicy));
            //     return null;
            // }
            // if(!errorMap.isEmpty()){
            //     serializeError = JSON.serialize(errorMap);
            // }
            
            // Object preBreakJSON = JSON.deserializeUntyped(preBreakdown);
            // Object agentInfoJSON = JSON.deserializeUntyped(agentInfo);
            // Object dataGIPolicyJSON = JSON.deserializeUntyped(dataGIPolicy);
            
            //dTask = new DetailTask(ct, cl, reBreakJSON, agentInfoJSON, dataCustomerJSON, dataGIPolicyJSON);
            system.debug('dTask: '+dTask);
        }
        return null;
    }
    
	
    public class DetailTask{
        public String polisNo {get;set;}
        public String productCD {get;set;}
        public String productName {get;set;}
        public String polisOwnerName {get;set;}
        public String polisInsuredName {get;set;}
        public String address {get;set;}
        public Decimal APE {get;set{APE = value == null ? 0 : value;}}
        public Double premi {get;set{premi = value == null ? 0 : value;}}
        public String telephone {get;set;}
        public String cBayar {get;set;}
        public Date issuedDate {get;set;}
        public Date effectiveDate {get;set;}
        public Date DOB {get;set;}
        public String email {get;set;}
        public Decimal attempt {get;set;}
        public String status {get;set;}
        public Decimal days {get;set;}
        public String faName {get;set;}
        public String cabang {get;set;}
        public Double totalPremium {get;set;}
        public Double totalTopUp {get;set;}
        public String tanggalPengiriman {get;set;}
        public String policyStatusCD {get;set;}
        public String PSOURCE {get;set;}
        public String Plan {get;set;}
        public String AmountBenefit {get;set;}
        public String AmountBenefitDate {get;set;}
        public String statusPending {get;set;} 

        public void setDataCustomer(EIPJson dataCustomerEIP){
            try{
                String address1 = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].addressLine1;
                String address2 = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].addressLine2;
                String address3 = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].addressLine3;
                String address4 = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].addressLine4;
                address = (address1 == null ? '' : address1.trim()) +', ' + (address2 == null ? '' : address2.trim()) +', '+ (address3 == null ? '' : address3.trim()) +', '+ (address4 == null ? '' : address4.trim());
                dob = CCCUtils.strToDate(String.valueOf(dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.birthDT), 'yyyymmdd');
            } catch (exception E){
                System.debug('ERROR '+E.getMessage());
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
            }
        }

        public void setDataPolicy(EIPJson dataPolicyEIP){
            try{
                premi = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].premiumAMT.trim() == '' ? Double.valueOf('0') : Double.valueOf(dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].premiumAMT);
                productCD = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].planCd.trim();
                productName = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].planNM;
                String insFirstNM = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].firstNM;
                String insMiddleNM = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].middleNM;
                String insLastNM = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].lastNM;
                polisInsuredName = (insFirstNM == null ? '':insFirstNM)+' '+(insMiddleNM == null ? '':insMiddleNM)+' '+(insLastNM == null ? '':insLastNM);
                tanggalPengiriman = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasApplicationDetailsIn[0].applicationDTTM;
                policyStatusCD = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyStatusCD;
                Plan = '';
                AmountBenefit = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyStatusCD;
                AmountBenefitDate = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyEffectiveDTTM;
                statusPending = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyStatusCD;
                
                if (dataPolicyEIP.Body.appID == 'RLS') {
                	PSOURCE = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].sourceChannelCD;
                	totalTopUp = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].topupRegularModalPremium.trim() == '' ? Double.valueOf('0') : Double.valueOf(dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].topupRegularModalPremium);
             		totalPremium = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].hasPolicySegmentDetailsIn[0].sumInsured.trim() == '' ? Double.valueOf('0') : Double.valueOf(dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].hasPolicySegmentDetailsIn[0].sumInsured);
                }
                
            } catch (exception E){
                System.debug('ERROR '+E.getMessage());
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
            }
        }

        public void setDataPremiumBreakdown(EIPJson dataPremiumBreakdownEIP){
            
        }

        public void setDataAgent(EIPJson dataAgentEIP){
            try{
                string firstName = dataAgentEIP.Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn[0].canBeIndividual.firstNM;
                string middleName = dataAgentEIP.Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn[0].canBeIndividual.middleNM;
                string lastName = dataAgentEIP.Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn[0].canBeIndividual.lastNM;
                faName = (firstName == null ? '' : firstName)+' '+(middleName == null ? '' : middleName)+' '+(lastName == null ? '' : lastName);
                cabang = dataAgentEIP.Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn[0].branchCD;
            } catch (exception E){
                System.debug('ERROR '+E.getMessage());
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
            }
        }
        
        public DetailTask(Contact ct, Call_Line__c cl, Object  preBreakJSON,Object  agentInfoJSON,Object  dataCustomerJSON,Object  dataGIPolicyJSON ){
            Axa2_Json jsonUtil = new Axa2_Json();
            attempt = cl.WelcomeCall_Attempt__c;
            polisNo = ct.Policy_No__c;
            issuedDate = ct.welcomecall_issued_date__c;
            effectiveDate = ct.welcomecall_effective_date__c;
            ape = ct.WelcomeCall_APE__c;
            email = ct.Email;
            days = cl.WelcomeCall_Days__c;
            status = cl.WelcomeCall_Call_Line_Status__c;
            telephone = ct.MobilePhone;
            // Modify Cara Bayar for product HONPRE by Faizir (11/01/2021)
            // cBayar = ct.welcomecall_product_code_plan__c.equals('HONPRE') ? '-' : ct.WelcomeCall_Payment_Type_Name__c;
            cBayar = (String.isNotBlank(ct.welcomecall_product_code_plan__c) && ct.welcomecall_product_code_plan__c.equals('HONPRE') )? '-' : ct.WelcomeCall_Payment_Type_Name__c;
            polisOwnerName = ct.Name;
            /*
        try {   
            if(dataGIPolicyJSON != null){
                productCD = String.valueOf(jsonUtil.getData(dataGIPolicyJSON, 'Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount.0.isAssociatedWithLifeInsuranceProduct.0.planCd'));
                productName = String.valueOf(jsonUtil.getData(dataGIPolicyJSON, 'Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount.0.isAssociatedWithLifeInsuranceProduct.0.planNM'));
                premi = Double.valueOf(String.valueOf(jsonUtil.getData(dataGIPolicyJSON, 'Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount.0.premiumAMT')));
                
                String insFirstNM = String.valueOf(jsonUtil.getData(dataGIPolicyJSON, 'Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount.0.hasDetailsOfRisksIn.0.hasPersonalDetailsIn.0.firstNM'));
                String insMiddleNM = String.valueOf(jsonUtil.getData(dataGIPolicyJSON, 'Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount.0.hasDetailsOfRisksIn.0.hasPersonalDetailsIn.0.middleNM'));
                String insLastNM = String.valueOf(jsonUtil.getData(dataGIPolicyJSON, 'Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount.0.hasDetailsOfRisksIn.0.hasPersonalDetailsIn.0.lastNM'));
                polisInsuredName = (insFirstNM == null ? '':insFirstNM)+' '+(insMiddleNM == null ? '':insMiddleNM)+' '+(insLastNM == null ? '':insLastNM);
            }
            
            if(agentInfoJSON != null){
                string firstName = String.valueOf(jsonUtil.getData(agentInfoJSON, 'Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn.0.canBeIndividual.firstNM'));
                string middleName = String.valueOf(jsonUtil.getData(agentInfoJSON, 'Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn.0.canBeIndividual.middleNM'));
                string lastName = String.valueOf(jsonUtil.getData(agentInfoJSON, 'Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn.0.canBeIndividual.lastNM'));
                faName = (firstName == null ? '' : firstName)+' '+(middleName == null ? '' : middleName)+' '+(lastName == null ? '' : lastName);
                cabang = String.valueOf(jsonUtil.getData(agentInfoJSON, 'Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn.0.branchCD'));
            }
            
            if(dataCustomerJSON != null){
                String address1 = String.valueOf(jsonUtil.getData(dataCustomerJSON, 'Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn.0.addressLine1'));
                String address2 = String.valueOf(jsonUtil.getData(dataCustomerJSON, 'Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn.0.addressLine2'));
                String address3 = String.valueOf(jsonUtil.getData(dataCustomerJSON, 'Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn.0.addressLine3'));
                String address4 = String.valueOf(jsonUtil.getData(dataCustomerJSON, 'Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn.0.addressLine4'));
                address = (address1 == null ? '' : address1.trim()) +', ' + (address2 == null ? '' : address2.trim()) +', '+ (address3 == null ? '' : address3.trim()) +', '+ (address4 == null ? '' : address4.trim());
                Object objDOB = jsonUtil.getData(dataCustomerJSON, 'Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.birthDT');
                dob = objDOB == null ? Date.today(): (date)CCCUtils.strToDate(String.valueOf(objDOB), 'yyyymmdd');
            }
            } catch (exception E){
                System.debug('dataGIPolicyJSON '+dataGIPolicyJSON);
                System.debug('agentInfoJSON '+agentInfoJSON);
                System.debug('preBreakJSON '+preBreakJSON);
                System.debug('dataCustomerJSON '+dataCustomerJSON);
                System.debug('ERROR '+E.getMessage());
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
            }
		*/
        }
    }
}