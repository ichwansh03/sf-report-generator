public class CallLineSPAJ {
    public DetailTask dTask {get;set;}
    Public String serializeError{get;set;}
    private Boolean isIncludeRLS = false;
    private Contact ct = new Contact();
    private Call_line__c cl = new Call_line__c(); 
    
	public CallLineSPAJ(ApexPages.StandardController controller) {
         
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
                
                // get data Premium Breakdown
                dataPremiumBreakdownEIP = EIPConnector.getPremiumBreakdown('Premium Breakdown', ct.Entity__c, ct.PolicyApp__c, ct.policy_no__c);
                dTask.setDataPremiumBreakdown(dataPremiumBreakdownEIP);
                
                // set servicing code
                servicingCD = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPartyDetailsIn[0].servicingCD;
                servicingCD = servicingCD == null ? '' : servicingCD.substring(9, 15);
                
                // get agent info
                dataAgentEIP = EIPConnector.getAgentInfo('Agent Info', ct.Entity__c, ct.PolicyApp__c, servicingCD, null, true);
                dTask.setDataAgent(dataAgentEIP);
                
                // get Policy Details
                dataPolicyEIP = EIPConnector.getPolicyDetails('Policy Details', ct.Entity__c, ct.PolicyApp__c, ct.policy_no__c);
                dTask.setDataPolicy(dataPolicyEIP);
                system.debug('DATA CUSTOMER='+dataCustomerEIP);
                system.debug('DATA PREMIUM BREAKDOWN='+dataPremiumBreakdownEIP);
                system.debug('DATA AGENT='+dataAgentEIP);
                system.debug('DATA POLICY='+dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type);   
            }catch(EIPConnector.NoDataException e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
            }catch(EIPConnector.EIPConnectorException e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
            } 
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
        public String CCY {get;set;} 
        public String gender {get;set;} 
        public String insuredID {get;set;} 
        public Date DOS {get;set;}
        public Date DOA {get;set;}
        public String paymentModeCD {get;set;} 
        public integer ageNasabah {get;set;}
        public integer Position {get;set;}
        public integer CompanyName {get;set;}
        public integer Job {get;set;}
        public integer Tenure {get;set;}
        public integer BusinessSector {get;set;}
        public integer detailTaks {get;set;}
        public integer ToolUsed {get;set;} 

        public void setDataCustomer(EIPJson dataCustomerEIP){
            try{
                String address1 = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].addressLine1;
                String address2 = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].addressLine2;
                String address3 = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].addressLine3;
                String address4 = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].addressLine4;
                address = (address1 == null ? '' : address1.trim()) +', ' + (address2 == null ? '' : address2.trim()) +', '+ (address3 == null ? '' : address3.trim()) +', '+ (address4 == null ? '' : address4.trim());
                dob = CCCUtils.strToDate(String.valueOf(dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.birthDT), 'yyyymmdd');
                
                // Integer days = dob.daysBetween(Date.Today());
                Date today = Date.today();
                Integer age = today.year() - dob.year() - ((today.month() < dob.month() || (today.month() == dob.month() && today.day() < dob.day())) ? 1 : 0);
                 
        		// ageNasabah = Integer.valueOf(days/365);
        		ageNasabah = age; 
                
                
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
                insuredID = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].insuredID;
                totalPremium = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].hasPolicySegmentDetailsIn[0].sumInsured.trim() == '' ? Double.valueOf('0') : Double.valueOf(dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].hasPolicySegmentDetailsIn[0].sumInsured);
                totalTopUp = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].topupRegularModalPremium.trim() == '' ? Double.valueOf('0') : Double.valueOf(dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].topupRegularModalPremium);
                tanggalPengiriman = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasApplicationDetailsIn[0].applicationDTTM;
                policyStatusCD = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyStatusCD;
                PSOURCE = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].sourceChannelCD;
                Plan = '';
                AmountBenefit = '';
                AmountBenefitDate = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyEffectiveDTTM;
                statusPending = '';
                CCY = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].currencyCD;
                paymentModeCD = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].premiumAMT;
               
                
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
                gender = dataAgentEIP.Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn[0].canBeIndividual.genderCD;
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
            cBayar = (String.isNotBlank(ct.welcomecall_product_code_plan__c) && ct.welcomecall_product_code_plan__c.equals('HONPRE')) ? '-' : ct.WelcomeCall_Payment_Type_Name__c;
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