public without sharing class CallLineCoolingOffCtrl {
    public DetailTask dTask {get;set;}
    public Call_line__c cl {get;set;} 
    public Contact ct {get;set;} 
    public String contactPolicyNo {get;set;}  
    public String sms_delivery_dt {get;set;}
    public String email_delivery_dt {get;set;}
    public String hardcopy_delivery_dt {get;set;}
    public String coolingOff {get;set;}
    private Boolean isIncludeRLS = false;
    Public String serializeError{get;set;}
  
    public CallLineCoolingOffCtrl(ApexPages.StandardController std){  
        System.debug('>>>> CallLineCoolingOffCtrl <<<<');
        cl = (Call_Line__c)std.getRecord();
        //ELVI
            try {   
            cl = (Call_Line__c)std.getRecord();
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
            //ELVI    
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
                totalPremium = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].hasPolicySegmentDetailsIn[0].sumInsured.trim() == '' ? Double.valueOf('0') : Double.valueOf(dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].hasPolicySegmentDetailsIn[0].sumInsured);
                totalTopUp = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].topupRegularModalPremium.trim() == '' ? Double.valueOf('0') : Double.valueOf(dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].topupRegularModalPremium);
                tanggalPengiriman = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasApplicationDetailsIn[0].applicationDTTM;
                policyStatusCD = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyStatusCD;
                PSOURCE = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].sourceChannelCD;
                Plan = '';
                AmountBenefit = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyStatusCD;
                AmountBenefitDate = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyEffectiveDTTM;
                statusPending = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyStatusCD;
                
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
        }
    }
    
    //Elvi
    public void populateDetailNasabah(){
        System.debug('>>>> populateDetailNasabah <<<<');
        isIncludeRLS = true;
        populateDetailNasabah(ct, cl);
    }
    
    public PageReference populateDetailNasabah(Contact ct, Call_Line__c cl){
        System.debug('>>>> populateDetailNasabah 2 <<<<');
        serializeError = '';
        Axa2_Json jsonUtil = new Axa2_Json();
        if(!isIncludeRLS){
            dTask = new DetailTask(ct, cl, null, null, null, null);
        } else {
            
            //test
            Call_Line__c getData = [select id,Contact__c, Contact__r.Policy_No__c from Call_Line__c where id =: cl.id];
       
        if (string.isNotBlank(getData.Contact__c)) {
             
            Boolean setSMSDate = false;
            Boolean setEmailDate = false; 
            
            contactPolicyNo = getData.Contact__r.Policy_No__c;
            try { 
                 
                String PARAM_TYPE = 'e-Policy';  
                String POLICY_NO = contactPolicyNo; //'520-3069546';
                
                wrapResponse GetDataList = new wrapResponse();
                GetDataList = getDataEIP(POLICY_NO,PARAM_TYPE);  
                 
                system.debug('GetDataList:'+GetDataList); 
                  
                if (GetDataList != NULL && GetDataList.Status == TRUE) {
                    JSON_MAP_CONVERT_EPOLICY JSONEPOLICY = (JSON_MAP_CONVERT_EPOLICY)JSON.deserialize(GetDataList.ReturnData, JSON_MAP_CONVERT_EPOLICY.class);
					
                    System.debug('JSONEPOLICY:'+JSONEPOLICY);
                    List<JSON_MAP_CONVERT_EPOLICY.HasPolicyAccount> policyAccounts = JSONEPOLICY.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount;
                    for (JSON_MAP_CONVERT_EPOLICY.HasPolicyAccount policyAccount : policyAccounts) {
                        List<JSON_MAP_CONVERT_EPOLICY.HasCustomerInformationIn> customerInformationList = policyAccount.hasCustomerInformationIn;
                        for (JSON_MAP_CONVERT_EPOLICY.HasCustomerInformationIn customerInformation : customerInformationList) {
                            List<JSON_MAP_CONVERT_EPOLICY.HasNameValue> nameValueList = customerInformation.hasNameValue;
                            for (JSON_MAP_CONVERT_EPOLICY.HasNameValue nameValue : nameValueList) {
                                String name = nameValue.name;
                                String value = nameValue.value;
                                System.debug('$$$$ Name: ' + name + ', Value: ' + value); 
                                
                                if (name == 'email_delivery_dt' && string.isNotEmpty(value) && value != '') {
                                    email_delivery_dt = value; 
                                	System.debug('$$$$ email_delivery_dt ' + email_delivery_dt); 
                                }
                                if (name == 'sms_delivery_dt' && string.isNotEmpty(value) && value != '') {
                                    sms_delivery_dt = value;
                                	System.debug('$$$$ sms_delivery_dt ' + sms_delivery_dt); 
                                }
                                 
                                if (name == 'email_status' && string.isNotEmpty(value) && value == 'Delivered') {
                                    setEmailDate = true; 
                                	System.debug('$$$$ email_status ' + setEmailDate); 
                                }
                                if (name == 'sms_status' && string.isNotEmpty(value) && value == 'Delivered') {
                                    setSMSDate = true;
                                	System.debug('$$$$ sms_status ' + setSMSDate); 
                                }
                            }
                        }
                    }
                }
            } catch (exception err) {
                system.debug('Error: '+err.getMessage());
            }
            
            try { 
                 
                String PARAM_TYPE = 'Hardcopy Policy';  
                String POLICY_NO = contactPolicyNo; //'520-3069546';
                // POLICY_NO = '316-6982169'; //'520-3069546';
                
                wrapResponse GetDataList = new wrapResponse();
                GetDataList = getDataEIP(POLICY_NO,PARAM_TYPE);  
                 
                system.debug('GetDataList:'+GetDataList);  
                 
                if (GetDataList != NULL && GetDataList.Status == TRUE) {
                    JSON_MAP_CONVERT_EPOLICY JSONEPOLICY = (JSON_MAP_CONVERT_EPOLICY)JSON.deserialize(GetDataList.ReturnData, JSON_MAP_CONVERT_EPOLICY.class);
					
                    System.debug('JSONEPOLICY:'+JSONEPOLICY);
                    List<JSON_MAP_CONVERT_EPOLICY.HasPolicyAccount> policyAccounts = JSONEPOLICY.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount;
                    for (JSON_MAP_CONVERT_EPOLICY.HasPolicyAccount policyAccount : policyAccounts) {
                    	System.debug('policyAccount:'+policyAccount);
                        if (String.isNotBlank(policyAccount.policyEffectiveDTTM)) { 
                    		System.debug('$$$$ policyAccount.policyEffectiveDTTM:'+policyAccount.policyEffectiveDTTM);
                            hardcopy_delivery_dt = policyAccount.policyEffectiveDTTM;
                        } 
                    }
                }
            } catch (exception err) {
                system.debug('Error: '+err.getMessage());
            }
             
            if (setEmailDate == false) email_delivery_dt = null;
            if (setSMSDate == false) sms_delivery_dt = null; 
            
             Date earliestDate = null;
            
            
            system.debug('+++ email_delivery_dt:'+email_delivery_dt);
            system.debug('+++ sms_delivery_dt:'+sms_delivery_dt);
            system.debug('+++ hardcopy_delivery_dt:'+hardcopy_delivery_dt);
            Date date1 = email_delivery_dt != null ? convertStringToDate(email_delivery_dt) : null;
            Date date2 = sms_delivery_dt != null ? convertStringToDate(sms_delivery_dt) : null;
            Date date3 = hardcopy_delivery_dt != null ? convertStringToDate(hardcopy_delivery_dt) : null;
            
            
            if (date1 != null) {
                earliestDate = date1;
            }
            
            if (date2 != null) {
                if (earliestDate == null || date2 < earliestDate) {
                    earliestDate = date2;
                }
            }
            
            if (date3 != null) {
                if (earliestDate == null || date3 < earliestDate) {
                    earliestDate = date3;
                }
            }
            
            System.debug('Tanggal terlama: ' + earliestDate);
 
            
            // email_delivery_dt = '09 Feb 2021';
            if (earliestDate != null) {       
                Integer numWorkingDays = 14;
                
                // Hitung tanggal 14 hari kerja setelahnya
                Date after14Days = addWorkingDays(earliestDate, numWorkingDays); 
                coolingOff = convertDateFormat(string.valueOf(after14Days));
                // coolingOff = convertDateFormat(string.valueOf(earliestDate));
                   
                
                system.debug('earliestDate:'+earliestDate); 
                system.debug('coolingOff:'+coolingOff); 
            } 
        }
            //test
            
            
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
        }
        return null;
    }
    //Elvi
    
    public static String getMonthName(Integer month) {
        Map<Integer, String> monthMap = new Map<Integer, String>{
            1 => 'Jan', 2 => 'Feb', 3 => 'Mar', 4 => 'Apr', 5 => 'Mei', 6 => 'Jun',
            7 => 'Jul', 8 => 'Agus', 9 => 'Sep', 10 => 'Oct', 11 => 'Nov', 12 => 'Des'
        };
       return monthMap.containsKey(month) ? monthMap.get(month) : '';
    }
    
    public static String convertDateFormat(String inputDate) {
        if (String.isBlank(inputDate)) {
            return '';
        }
        
        List<String> dateParts = inputDate.split('-');
        if (dateParts.size() != 3) {
            return inputDate; // Format tanggal tidak valid, kembalikan nilai asli
        }
        
        Integer day = Integer.valueOf(dateParts[2]);
        String month = getMonthName(Integer.valueOf(dateParts[1]));
        Integer year = Integer.valueOf(dateParts[0]);
        
         
        return ((day < 10) ? '0' : '')+ day + ' ' + month + ' ' + year;
    }
    
    public static Date convertStringToDate(String dateString) { 
        Map<String, Integer> monthMap = new Map<String, Integer>{
            'Jan' => 1, 'Feb' => 2, 'Mar' => 3, 'Apr' => 4, 'Mei' => 5, 'May' => 5, 'Jun' => 6,
            'Jul' => 7, 'Aug' => 8, 'Agus' => 8, 'Sep' => 9, 'Oct' => 10, 'Nov' => 11, 'Dec' => 12, 'Des' => 12
        }; 
            
        List<String> dateParts = dateString.split(' ');
        if (dateParts.size() != 3) {
            return null; // Format tanggal tidak valid
        }
        
        Integer day = Integer.valueOf(dateParts[0]);
        Integer month = monthMap.get(dateParts[1]);
        Integer year = Integer.valueOf(dateParts[2]);
        
        // Mengonversi menjadi nilai Date
        return Date.newInstance(year, month, day);
    }

    public static wrapResponse getDataEIP (String PolicyDetail, string typePolicy) { 
        wrapResponse setResponse = new wrapResponse();
        
        Boolean Status = False; 
        Datetime currentTime = System.now();
        String ownerId = UserInfo.getUserId();
        
        String inputString = String.valueOf(currentTime)+'-'+ownerId;
        Blob inputBlob = Blob.valueOf(inputString);
        Blob md5Hash = Crypto.generateDigest('MD5', inputBlob);
        
        String transactionId = EncodingUtil.convertToHex(md5Hash);
        System.debug('MD5 Hash: ' + transactionId); 
         
        String username = System.Label.EIP_username;
        string password = System.Label.EIP_Password;
        string service = 'getPolicyDetails';
        string operation = 'Detail';
        string sourceCInd = 'SFDC';
        string validToDttm = '';
        string validFromDttm = '';	
        string reEntryRt = '';
        string documentID = '1234567890';
        string entity = 'AMFS';
        string appID = 'EDMU';
        
        
        String responseBody; 
        // Get the JSON string.
        String requestBody;
        try {  
            
        
            // config request body
            JsonGenerator cj = JSON.createGenerator(true);
            cj.writeStartObject();
            cj.writeFieldName('Header');
            
        	system.debug('Header:');
            cj.writeStartObject();
                cj.writeFieldName('SecurityContext'); 
        	system.debug('SecurityContext:');
                cj.writeStartObject();
                    cj.writeStringField('username', username); 
        	system.debug('username:'+username);
                    cj.writeStringField('password', password); 
        	system.debug('password:'+password);
                cj.writeEndObject();
            cj.writeEndObject();
        
            cj.writeFieldName('Body');
            cj.writeStartObject();
                cj.writeStringField('transactionId', transactionId); 
        	system.debug('transactionId:'+transactionId);
                cj.writeStringField('service', service); 
        	system.debug('service:'+service);
                cj.writeStringField('operation', operation);  
        	system.debug('operation:'+operation);
                cj.writeFieldName('IcAx_AXAAsiaCustomer_Type'); 
        	system.debug('IcAx_AXAAsiaCustomer_Type:'); 
                cj.writeStartObject();
                    cj.writeStringField('sourceCInd', sourceCInd);  
        	system.debug('sourceCInd:'+sourceCInd);
                    cj.writeFieldName('hasPolicyAccount'); 
        	system.debug('hasPolicyAccount:'); 
            		cj.writeStartArray();
                		cj.writeStartObject();
                            cj.writeStringField('validToDttm', '');
                system.debug('validToDttm:'); 
                            cj.writeStringField('validFromDttm', ''); 
                system.debug('validFromDttm:'); 
                            cj.writeStringField('reEntryRt', ''); 
                system.debug('reEntryRt:');
                            cj.writeStringField('policyNO', PolicyDetail); 
                system.debug('PolicyDetail:'+PolicyDetail);
                            cj.writeStringField('applicationRk', typePolicy);  
                system.debug('applicationRk:'+typePolicy);
            
                    	cj.writeEndObject(); 
                    cj.writeEndArray(); 
                    cj.writeStringField('documentID', documentID); 
        	system.debug('documentID:'+documentID);
                cj.writeEndObject(); 
                cj.writeStringField('entity', entity); 
        	system.debug('entity:'+entity);
                cj.writeStringField('appID', appID);  
        	system.debug('appID:'+appID);
            cj.writeEndObject(); 
            
            requestBody = cj.getAsString();
            
        	system.debug('requestBody:'+requestBody);
             
            string apiUrl = System.Label.Rest_WS_Endpoint;
            apiUrl += System.label.Biz_getPolicyDetail;
            
            
        	system.debug('apiUrl:'+apiUrl);
            
            // Konfigurasi request
            HttpRequest req = new HttpRequest();
            req.setEndpoint(apiUrl);
            req.setMethod('POST'); 
            
            req.setHeader ('Content-type', 'application/json');
            req.setHeader ('Accept', 'application/json');   
            req.setBody(requestBody);
             
            Http http = new Http();
            HttpResponse res;
            
            if (!System.test.isRunningTest()) {  
                res = http.send(req);          
            } else {    
                mockUpsample mock = new mockUpsample();
                res.setBody(mock.getPolicyDetail());
                res.setStatusCode(200);    
            }
            
    
            // Proses respon dari API
            if (res != null) {
                Status = TRUE;
 				responseBody = res.getBody();
                // Proses data dari respon API (jika ada)
                System.debug('Response Body: ' + responseBody);
                // Lakukan operasi lain sesuai kebutuhan
            } else {
                responseBody = 'Error get Data Request'; 
            }  
              
        } catch (exception ex) { 
            responseBody = ex.getMessage()+' Line: '+ex.getLineNumber() ; 
        }
        
        system.debug('responseBody:'+responseBody);
        
        /*
        Session_Data__c sessionData = new Session_Data__c(); 
        sessionData.session_id__c = transactionId; 
        sessionData.service__c = service; 
        sessionData.operation__c = operation; 
        sessionData.classtype__c = typePolicy;  
        
        sessionData.Entity__c = entity; 
        sessionData.page_name__c = 'CallLineCoolingOff'; 
        sessionData.data__c = responseBody;  
        sessionData.data_request__c = requestBody;  
        insert sessionData; */
        setResponse.Status = Status;
        setResponse.ReturnData = responseBody;
        return setResponse;
    }
      
    Public Class wrapResponse {
        Public boolean Status {get;set;}
        Public String ReturnData {get;set;}
        
        wrapResponse() {}
    }
      
    // Fungsi untuk menambahkan jumlah hari kerja ke tanggal tertentu
    public static Date addWorkingDays(Date startDate, Integer numDays) {
        Integer daysAdded = 0;
        while (daysAdded < numDays) {
            startDate = startDate.addDays(1);
            // if (!isWeekend(startDate) && !isHoliday(startDate)) {
                daysAdded++;
            // }
        }
        return startDate;
    }
    
    // Fungsi untuk memeriksa apakah tanggal adalah hari Sabtu atau Minggu
    public static Boolean isWeekend(Date checkDate) { 
        // Convert Date to DateTime
        DateTime checkDateTime = DateTime.newInstance(checkDate.year(), checkDate.month(), checkDate.day());
     
        String dayOfWeek = checkDateTime.format('E');
        return dayOfWeek == 'Sun' || dayOfWeek == 'Sat';
    }
    
    // Fungsi untuk memeriksa apakah tanggal adalah hari libur (dalam contoh ini, diasumsikan tidak ada hari libur)
    public static Boolean isHoliday(Date checkDate) {  
        
    	List<Holiday> holidayList = [SELECT ID, Name, ActivityDate, IsAllDay FROM Holiday WHERE ActivityDate > today];
    
        List<Master_Holiday__c> mst_holidayList = [SELECT Id, end_Date_time__c, Active_Date__c  
                                                   FROM Master_Holiday__c where Active_Date_F__c > TODAY 
                                                   AND (service_type__c = 'Helpline' OR service_type__c = 'Customer AFI') 
                                                   AND Type__c = 'Holiday' AND Entity__c = 'AFI' AND end_Date_time__c != null ORDER by Active_Date_F__c DESC limit 1]; 
      
        Date mst_holiday = null;
        List<Date> listMstHoliday = new List<Date>();
        for(Master_Holiday__c hol : mst_holidayList){ 
            mst_holiday = hol.Active_Date__c;       
        }
          
        return (mst_holiday != NULL && checkDate <=  mst_holiday) ? true : false;
    }
    
    public class mockUpsample{
        
        public String getPolicyDetail(){
            return '{"Body":{"Customer":{"canBeIndividual":{"birthPlace":"                              ","birthDT":"19790101","socialSecurityNO":"1928XXXXXXXXXXXXXXX","genderCD":"F ","firstNM":"HONDXXXXXX MIDDLENAME LASTNAME","hasAddressesIn":[{"mobilePhoneNO":"087799999999","emailAddress":"xxx@axa.co.id"}]},"hasPolicyAccount":[{"currencyCD":"RP ","policyExpirationDTTM":"0","isAssociatedWithLifeInsuranceProduct":[{"hasPolicySegmentDetailsIn":[{"sumInsured":"        9000000"}],"insuranceProductRk":"Solusi Dana Pendidikan                            ","planCd":"HOND14         ","planNM":"Solusi Dana Pendidikan                            ","insuranceProductCd":"HOND14         "}],"policyDueDt":"0","policyNO":"502-8073020","hasDetailsOfRisksIn":[{"hasPersonalDetailsIn":[{"birthPlace":"                              ","middleNM":"MIDDLENAME","birthDT":"19790101","genderCD":"F ","firstNM":"HONDXXXXXX","hasAddressesIn":[{"mobilePhoneNO":"087799999999","emailAddress":"xxx@axa.co.id"}],"lastNM":"LASTNAME"}],"insuredID":"1928XXXXXXXXXXXXXXX"}],"hasPartyDetailsIn":[{"servicingCD":"65056804006826      ","partyCD":"                    "}],"paymentModeCD":"A  ","topupRegularModalPremium":"       4200000.00","policyStatusCD":"[00] PENDING FOR UNDERWRITING","ePolicy":"Y  ","hasDetailsOfPolicyIn":[{"gdbValue":"               ","loanRepaymentAmt":"            ","dividendAmt":"             ","futurePremiumDpIntTypeCode":"                  ","loanIntTypeCd":"           ","dividendTypeCD":"           ","futurePremiumDpAmt":"                 "}],"hasApplicationDetailsIn":[{"applicationDTTM":"20220207"}],"policyReserveAmt":"              .00","premiumAMT":"       6087336.60","terminationDt":"0","paymentMethodCD":"C  ","policyEffectiveDTTM":"20220207","sourceChannelCD":"          ","hasLifePolicyChangeTransDetailsIn":[{"endPremiumHolidayDT":"0","startPremiumHolidayDT":"0"}],"issueDt":"0"}],"key":"95acd820-f69b-451b-9884-bab4844ead22#10.144.5.14#SFDCEIP"},"service":"getPolicyDetails","appID":"RLS","operation":"application DETAIL","transactionId":"unique 888","entity":"AMFS","status":"1"}}';
        }
    }
    
}